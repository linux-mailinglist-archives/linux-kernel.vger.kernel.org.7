Return-Path: <linux-kernel+bounces-728572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8FB02A28
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218031C212BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BC27380C;
	Sat, 12 Jul 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwZT7wMC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68C2737E1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310422; cv=none; b=oS6aXB8NTbkxMmhYe87Fp3VaNdGVTkCh1w5UGOisl/ph6j7aku0A1N3XNSPlXVi90ecdqIxnn5ZONq068UztzV5wvpbuEufshIeSTgLVrcpdqxK8HZU3BgZoFa+Q9x2+bfFK2DWEbSJ5YEHrmRKFk81yuPfYvoKQSPJQIuk4oRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310422; c=relaxed/simple;
	bh=FgDiNEbTQUM1CBboZW+3GiNtS2r9vMW/FKryylWNcPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4dfsxbd2TyE/7qlZi4jb6SJeh71kTNeD17MLEgsbMuQcojh1KJni0De2ONG5yODzNZYQhZCQhEp6Kn3ZRDd1fnDzgaJ6y2EAh3l1GxAiVOTtj6ODD40zOfJcGvCKUIStAnq6t7FsU4quX9ee4n3zH8HVsmx2sJYu4itFWEaAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwZT7wMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752310417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAIDyz1RGkL7Fi724SZaRxH/j45Q7rhv41xQSVw0siE=;
	b=fwZT7wMCXCzAo13khJ5zMIURFMdTmQFw6yRVK/J06cN+G7Tl1QboYGu6vvk4oDvndlMIqT
	fEoriqYkoZMWuehOqKYFLbrqh4Zbcowwv+8o7Uzv27OgPmxJhWlJxKu3GK7rk443NXb5Pd
	5nW9QFmXwVF1Ip7YmgeiBaSEMTTsidM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-rJ1iLPsuO5CllPwgaFsBQQ-1; Sat, 12 Jul 2025 04:53:34 -0400
X-MC-Unique: rJ1iLPsuO5CllPwgaFsBQQ-1
X-Mimecast-MFC-AGG-ID: rJ1iLPsuO5CllPwgaFsBQQ_1752310413
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748e1e474f8so4371244b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752310413; x=1752915213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAIDyz1RGkL7Fi724SZaRxH/j45Q7rhv41xQSVw0siE=;
        b=l58VyqrdswdaaYEEi6+k4eOrhLgwn0XeWQPfFdBAwhrAq6YTFbJ9MbU/YjCuo2kk3d
         iusXs/Wv8n+Z2sIOPlFTc3KBP+QUWZjaEZlj/fAA+iPAqLiGgqkR7wWY82hbG1OiD5hR
         n4yc44TSB7XWms3KiORk0sNCCD9tIYYRDH5+udTsfCg1slnT6h0LngK8puL1CeLIva+m
         Ft312oTZZZehvSMvr+h7gbh9dzLv161bywaA/TLWBCZHR5AH7+4+TtFw8J/divKodvFf
         m8imK7j1Jg28xSi0YDPvn9bXn64zT7fzqz+hZFQHh9Y0gxA/fb6Go8HdRYStfwGOFM0P
         kIHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXRSGTSNpWhUSocLtnpDex3o5myZoTgWbGz9PQB5hW5V8G/08gqyHCpcWeqJQ3yaZjEzuN8UsxixUVALM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyroa0ew73YdBozxYMQ8knSe9yKsXE1MjhtU0tj8UY5yn4MpOic
	SKVwH+r3PpO/bjWgi7alrYvOpWgOlTIWKlg1vT+hzwI4gDsbHVNUzSRaY6WSOqRaB8q9noKjiw+
	wOb4ACDy9ET5v0YD4Pv/dFJ5pm+ONhoVqkB0Ct3/4EErme6EcKXLsH4sN7YQz62CpQH0h69UiHw
	==
X-Gm-Gg: ASbGncvGmgvYxAH+G7TAq2RRYgiEYtDGnWKgDqK1yqPT5Dc5UTs0Q8Id9l3vQ0XD1uG
	OWtrtGXZ+RJXxfOww7yKxEevQgOTM8A6esHVDDQrliX3miN1QCWC8uTXkmf8w65+tom9dG4I2Zs
	yBUPpDpEBRsI55UFgi8kZ0Lz1gSbqU8hsCp7sd1bi2roOwaFaAPqd+l00WExZoUk7Jci68heKzf
	O3mRnzXQF7UbvLlkEy8rYg1R/GRQboLX1mjTRSfNOtDUU+PyBc14682ISPEP8cuB7QV7PAmhkw6
	G7u2l8vf2FNnDpx0LH1UN6tyQ37lDRMtJ0tWCoVsiMZckD0KEQgUNVT0Nzf0Twnl50A+84wbl2H
	BglH2
X-Received: by 2002:a05:6a21:600a:b0:232:6ea3:9255 with SMTP id adf61e73a8af0-2326ea39659mr4404579637.31.1752310413234;
        Sat, 12 Jul 2025 01:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBKlciOUeMgwjkYvsVzzcYcnrC96ulKoYgJVXm1bgf0lX9LPSMnyRl4SqR7CY3nqUCCYgPhg==
X-Received: by 2002:a05:6a21:600a:b0:232:6ea3:9255 with SMTP id adf61e73a8af0-2326ea39659mr4404554637.31.1752310412750;
        Sat, 12 Jul 2025 01:53:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm6531143b3a.124.2025.07.12.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 01:53:32 -0700 (PDT)
Date: Sat, 12 Jul 2025 16:53:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Add fix hint for ext4
Message-ID: <20250712085328.kjutrljvhy7ht2mq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250711182744.1512486-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711182744.1512486-1-ojaswin@linux.ibm.com>

On Fri, Jul 11, 2025 at 11:57:44PM +0530, Ojaswin Mujoo wrote:
> This test fails on ext4 if the commit 4a622e4d477b
> is missing in the kernel. Add this hint.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

It's simple enough to catch up the release of this weekend :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/365 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 1bca848a..36cb2530 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -14,6 +14,9 @@ if [ "$FSTYP" = "xfs" ]; then
>  		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>  	_fixed_by_kernel_commit ca6448aed4f1 \
>  		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +elif [ "$FSTYP" = "ext4" ]; then
> +	_fixed_by_kernel_commit 4a622e4d477b \
> +		"ext4: fix FS_IOC_GETFSMAP handling"
>  fi
>  
>  . ./common/filter
> -- 
> 2.49.0
> 


