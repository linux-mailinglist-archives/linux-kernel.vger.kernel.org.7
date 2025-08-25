Return-Path: <linux-kernel+bounces-785090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF8B345C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B6620116E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2082FCC17;
	Mon, 25 Aug 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ozg8F56T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB52F3627
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135776; cv=none; b=bICNxczgvveeDU2TD9ghe4Llo0KOaBRC6MyspZvLZ+Yjk0onl03G8/ZTcHjuKeUPdZnmxY79dMl9l+8aUuGGrxVtU9eTVQzLL04txzrQgnaMQVqNMLyCXlsOtmQjV/1fipiAy+/NbAo449QKvr9y5sW2f7ZN0853xYdoASJg5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135776; c=relaxed/simple;
	bh=J3OexhTznRccGZs6rVKORbGFuV/gnAKP1RScDPG8lrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmwk90QBhlFIUHexMrdAPKd5QaX4KVAfIl/nYVfoCY2OCHbMrj3GWClyKvpksejQ816Wnqy2ECUEutyqf0zfbH7CA8uZ8NFSIpebG0xtzQMUXjkIxQ3tCsO73SmV6HkPtPcSt9Yi7ZQydEOIRRv6yWX0zfJfD8kU+VdHJRJH4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ozg8F56T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756135773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i2+2A3UxG6szUKYKSkulwqqvxOOp1ZI6uI4Bar8uaU=;
	b=Ozg8F56TgGtkpBI+LAG8HHkUbh+/0sJmOV+X0QfMS+R925zuaGUYGmNgq1LZ5IPBQcIOO7
	Q9lTCzp1FpdUbvA7SGzKz4OhI+rYIlrOwSLWYemg0VWb8gDD0i2HouXaHIYAauMlPxXHF5
	Q9BmXY2TwqSmA9zwYppWIJ0/HVRryI8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-ZZFxc_tEPqqNVn0-3ZQuqw-1; Mon, 25 Aug 2025 11:29:31 -0400
X-MC-Unique: ZZFxc_tEPqqNVn0-3ZQuqw-1
X-Mimecast-MFC-AGG-ID: ZZFxc_tEPqqNVn0-3ZQuqw_1756135770
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244582bc5e4so56393945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135770; x=1756740570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i2+2A3UxG6szUKYKSkulwqqvxOOp1ZI6uI4Bar8uaU=;
        b=EijJcbopN+7llTiIlH/eG982NPnlp6znP7ABkyq23EU3Fri+2snigYH4Z9Pt+0rTK3
         NEcK3moIFcf555RGmkWsMoeGcNQOifNnNr2GIc/6YxmDVH/bcFGNjsihXDqKZMlB4ORr
         VhtaDWzT9wv5jAjkPUDAe9s4rxmZFNrh4rcoKwUW5+OD2X58TH3FnSGSm8Pu3WJVaAX9
         4kwiBBL5lEb9jb3nW6MtEpLfokpVVcVqK24GgBPLml8tUOWDcK98OzfVce3YNIR06Yv7
         6ZS7sFpKzPo1uCJ5jpUUNMYy9+ed72gnlp0I0rr1vgeV5hMR6Hhm0EUoo2KKsW7bdr95
         JhoA==
X-Forwarded-Encrypted: i=1; AJvYcCXKOCMRcB8WHn5XmLkXOlHg2QCtH/bmuPOlvr7KJpLURNgXWN9SoCkfZHGSRsFnMkml3BomkVZcy5oI6B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tVnCRQV02Fnykrj43k5oykyVr1f4oNmgLJjSNzFUrckBvs8x
	bWrNIZrKmsa6o30UvXqTs6kRaYS96Xh9Lgl1uFDKouN+0hkJ7+CrBJEoVY/rs7Eyj2ZnDuE46Sq
	xVCiHKQXKnz6ThAdXs/UqGcdoRo2ht38Yw2NH0Lh3/N+Oy+FjCms3v6w0uWGT5sgNBp4R4sthjg
	==
X-Gm-Gg: ASbGncto89gz3Ek2Md4DWhaajnyJjYcFNVYWYr9vamvQNYj9uEgIqaeRPbdRubExHpO
	jCXmKf1Jo4lAR73ST19DSklDCNGl75XPuFFqfC03/Z16kdlIiuBm89IOZ1TlWAsLjSoqgpjyAlf
	tyX0EykJEKdTBqavu5BZsdMuFcWIxyhJ8dySzSxKPz/I0bqpc+XaEMqkvkhrtqp4GPniuujOlWF
	qAY913RfT4QFFsyKO6lV6gsLBTJGgGEZ3xiKntHotfJ9S2t1kUtPPvczDEk03OXMgS9pydrDH43
	ohBDkZQET0mqcILcR/7EFFRyns/p/GnUHK1wAGzkwMmJ4rucl9et6BpBl3DWgqjK3tNLk7Du35V
	qEXLZ
X-Received: by 2002:a17:902:ec89:b0:246:6fb:5016 with SMTP id d9443c01a7336-2462ee8df3bmr168166835ad.20.1756135770229;
        Mon, 25 Aug 2025 08:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkjrdn8sUCl9oN5WP7fv8c57Lb6oiCyKRUuIJz4eEVVQ+NkS3wVSOVsUIBXnoXNW1yzDXQtw==
X-Received: by 2002:a17:902:ec89:b0:246:6fb:5016 with SMTP id d9443c01a7336-2462ee8df3bmr168166495ad.20.1756135769854;
        Mon, 25 Aug 2025 08:29:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254c47f2dcsm7174352a91.31.2025.08.25.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:29:29 -0700 (PDT)
Date: Mon, 25 Aug 2025 23:29:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Fix false failure when mapping ends with
 free space
Message-ID: <20250825152925.tcbbn5rxbjpk4ts7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>

On Tue, Aug 05, 2025 at 02:55:56PM +0530, Ojaswin Mujoo wrote:
> If we have a small FS where the first free space mapping is also the
> last mapping of the FS, then the following sub-test fails:
> 
>   echo "test whatever came after freesp"
>   $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT
> 
> since there is nothing after the freespace. Fix this by punching a 1M
> hole in a 3M file to ensure that the first free space is always
> surrounded by allocated blocks.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/365 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 36cb2530..bbadae71 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -32,6 +32,10 @@ if ((blksz < 2048)); then
>  	_notrun "test requires at least 4 bblocks per fsblock"
>  fi
>  
> +# This makes sure there is free space surrounded by allocated blocks, which
> +# is needed for some sub tests.
> +$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f

If you add "falloc" and "fpunch" operations, you need to:

_require_xfs_io_command "falloc"
_require_xfs_io_command "fpunch"

Due to not all fileystems support these two fs operations.

BTW, I'm wondering how small (and what kind of) the fs you use, cause there's only
one unused region, even this's a clean fs, there're some still many different
metadatas. I even tried a 100M ext2 fs (which doesn't has log space), there're
many free space regions. So I'm curious, how can you hit this issue? And if the
SCRATCH_DEV is too small (e.g. 10M), do we really need to test with that fs size:)

Thanks,
Zorro

> +
>  $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
>  
>  find_freesp() {
> -- 
> 2.49.0
> 


