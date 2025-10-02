Return-Path: <linux-kernel+bounces-840737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B9BB51E3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701574831F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB2287245;
	Thu,  2 Oct 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cit7xuPO"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290B285040
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759436644; cv=none; b=Y4E48VVc1GW92vfcJKWuCpbyy/2k790XE+Lb8la2jwScqs5PnDdQntyFu8qHEZ80efK177u0F8PWcxPCbL3GsusRbaOk/quS3RM+/S1Obx7ywEJu9iw/rrdMYeqkjzKUUPnExym98Heecx1lo+SYSPWC+RCAHTk9g9MuzY4lz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759436644; c=relaxed/simple;
	bh=5ePwRTUACD91KhDeCr227Vw13RrBf6AtS5ztBqKvEAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNeSch7lX3Eqj4c7nlWPc4j19CO5jBKLUv9NCRshktGh8XldGRCReI7f41vWuTIp6y/OyfZVZoyWLIdYiKSHG3B82hONAljUSPMUG23qvhounnrqyohX2tmReU4I3bDGQsxjaMe2zx/VOaYSAPon6WpG89Di8/LQ3v/fqjGcFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cit7xuPO; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso733667137.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759436641; x=1760041441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnqoHX1wLCr2GH1w/VXZguolFxEac8XH6B3cVkslR4w=;
        b=cit7xuPO6Pgu9mYWTmssETK6InWmdnD6HKM2Cs+FvECTDnvwk0QUV0vV8iC+RQ5uOM
         QIQ5sivgbp9+gYP3+aSZRwc1ldxyTPTOASFVvmbi0yA1k1IhrzBFzXmcZrKkFqmSfDaU
         w17lm1VL0i0cAJvna4jVhv8JPDmMVB/uxG5Pccl80Ow51dVmMKwhOfr6EFs7hzlEcKG4
         u90eL1buhe9KWQN80vdyr9Fv3AggBfEC/ntbh9574dsUoxxvuoRzCeVv0vtlFdnXcKal
         +vH9bNmM76urGuf03poIbtija8Q+dmK/DW43P6EZhgvkY1qRiLpgX/i66CqsgIZHTucs
         CfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759436641; x=1760041441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnqoHX1wLCr2GH1w/VXZguolFxEac8XH6B3cVkslR4w=;
        b=HhuTL4nzdoqQjMVtU4h+MtwrrcmEIn18KdODgYYy02O7PtHfmjmdQ9LupSrdMlVyNM
         Psp90f/BxgVeVdvwNVnHLcbWmVubJXK9O/PN5VgKjm4O00FnY77Fi0FZD0NKplBxGgtD
         8Da907l/aQ60aZLYu8fjQeFsSddwRAaE3eZ4TAZZ54onF1Uv6QLrTMrcNOVh41c/mUZd
         iI9sPbpdPuUOLwPp/bXMGewavHLLdPjG/NuQd7K+L16KBFTlu7vIWp4otd0egfC0ZwuZ
         CU6ZqKRVntHxh/LQWQMWEysqpBXBL+lQx/EVTE4Sp66GjQqNNZ1daazU00FUK3Zrsury
         MxQw==
X-Gm-Message-State: AOJu0YwV8yFidhhZpnOi824j4xDFRXucOwe43TSsgBOdWIzWaOqGL/rc
	a99cMn1XQmFYoOLRxBeQWb0QYh+eyGdiltpfITtLazGMeRp3qnO9GzunpJ+WHplq44rOaI9eZYs
	sWWC4yfnzfsy8aNc2I7QU09FMaJX7wO6C72zZ
X-Gm-Gg: ASbGncsrSEKcLjUVMYFbnvjZZ2+l321zJmpnpe8eCgkosx/cy+XBBRijxlIN2qf6ofZ
	nnsnZmxHD9FjU1Ltsnk8+HWhnhyKhb+/0Wb5sHI4M+IIzhlASoBkT5o8hyx72QbNN/kAEjKq9qF
	LDZmS7y70IOGvRjG7zeXBOqpjAcTgP+CwectuQfL2/oLL8nm7UDHmvf/uiUT0SzghRMmvfLS+SY
	zNZkmn9C/EvAgzVrEH8NzHb+Mr7m/qHVElKM1qmrL7fp2Xth/0Z/jIR2KE=
X-Google-Smtp-Source: AGHT+IFX6XXKb8fjFQ+IV0gn4fvOAymA+u5w9F9mOKulkZ8UP3XRd7/6cCFNDpNpMO8a3jqKYd6ajo6xCAE8kRO8/vY=
X-Received: by 2002:a05:6102:3586:b0:57d:c090:dfc3 with SMTP id
 ada2fe7eead31-5d41d1313c8mr202142137.29.1759436641370; Thu, 02 Oct 2025
 13:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002015645.3588322-1-jaegeuk@kernel.org>
In-Reply-To: <20251002015645.3588322-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 2 Oct 2025 13:23:50 -0700
X-Gm-Features: AS18NWBeh5d2oe6HSgGMtjHMr7ezQBdEvHrcctMdwLhdMAkcDhCj0Mlt8wDrHZo
Message-ID: <CACOAw_yyUJUQ6zzHYy+yFY-bOhQ_=hAnPQ_acuNk4KCaQn-Tvg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add missing dput() when printing the
 donation list
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:59=E2=80=AFPM Jaegeuk Kim via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> We missed to call dput() on the grabbed dentry.
>
> Fixes: f1a49c1b112b ("f2fs: show the list of donation files")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 7992386fb9e6..6d2a4fba68a2 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1845,6 +1845,7 @@ static int __maybe_unused donation_list_seq_show(st=
ruct seq_file *seq,
>                                 (loff_t)(fi->donate_end + 1) << (PAGE_SHI=
FT - 10),
>                                 (loff_t)inode->i_mapping->nrpages << (PAG=
E_SHIFT - 10));
>  next:
> +               dput(dentry);
>                 inode_unlock_shared(inode);
>                 iput(inode);
>         }
> --
> 2.51.0.618.g983fd99d29-goog
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

