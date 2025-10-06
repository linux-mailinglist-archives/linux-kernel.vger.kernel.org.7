Return-Path: <linux-kernel+bounces-843033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B6BBE413
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA3A188ECB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF12D46CE;
	Mon,  6 Oct 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmEidpXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E12D46B4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759072; cv=none; b=mf/dxdanXSzz/7KwXkK+U5K8Z8xwqqiIBBglq7CSIn6ephH7b019A7bqLHXDYZFXUfK4kp2ozLsbrYWfyeeEEKHtVDK9vQ7XMApyI0ds5BezozQgfB0MO6+Of9Z0ZuswRvxD3iHgTmhw/GwJoK82Ri7DNSYG6Z2IoQGHhVTyqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759072; c=relaxed/simple;
	bh=aoHPu3E0mvHoalx0FWQM3EH+lnlTpy4HtT99+90hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YGWfhmPGcreEdWgGS4o92tYcospn7nMKWLIwrKMmiYMgR59hze4QoiofmIOJtJ7ZLvtBGqfGascvOXjBEiL4uKsSnFZRNlWiEQIBGQGvIz8Vz/Csl1YFw+fBLUUMYb2gPWBbFBnVDiU0BLJ/pgZFykUn4QfiKskQ/Qca2aeihno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmEidpXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759759070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
	b=BmEidpXeRIMuK/tfySLjeQYOKX/+647oGr9GafDofUk8gtSPxzni6m+UHx5Czh8X3FVAbo
	k7ZIETUoA609tH+8UP9GB/Gt3YUPv8lzXkhFlA50qNIMc32GDOTvvOYuG6tMqaYVUJTE5z
	C/0Mqaxeq3m+MjWApf+HnShN4M3tFFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-KsQR8aHBNc6GRqbwJlvv1Q-1; Mon, 06 Oct 2025 09:57:42 -0400
X-MC-Unique: KsQR8aHBNc6GRqbwJlvv1Q-1
X-Mimecast-MFC-AGG-ID: KsQR8aHBNc6GRqbwJlvv1Q_1759759061
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee130237e1so1749513f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759061; x=1760363861;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
        b=LF7VscR0LyE+Ha0oXKUcr1WcYOwzunadajKsg7/nPbu4C6LsDnnSzTwCjv+qOKjgmc
         iE7odbrnYhVdzB3G3sPzBFZvY85pX12v+a9nYEExc2BJW1qzWxLJIyVRSx/Kjn3G87Wh
         VLvnPILW5wE0rsViIF+/4kwmlA/DDtEWnhoBJyKwSzrH3dAmw6IODBBpzF4GytgRioGn
         zzR/NQHnT+rX+8oFVd23Z+N8Q8WBIAALxpICzmtQX0uiljpLXdaKjJXrawER5/uQvFi0
         PYdfKgEZLHPrt/3m9e3RW5NvreWk6jb9p9I/IARR2IBLQHZlf47EskDI0Dy76z/mPcCe
         sHAw==
X-Forwarded-Encrypted: i=1; AJvYcCUfJVtxg6hds/uKC9k9A34bLBuwx6r2sHubvJpnxncnJi3uQlqvWins66f13z6GZmSZliB1+n9Hr0qHpBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+llqelKgxZuHWXCBKSC2ibtROA1jnWmb3BXR6fnMG/XE9DW3n
	4VByicv9KgC0Xdjhiz6vM+kwzuAFev+hqVvxIHWSkZWNg17Ryy9ffQXDE6xMqk9FSNzaJA18KB5
	yeqqhOoYceFwQAoSYc8dXbWwnGKkXvODOjjn6RSRGx6Ic0P/V0VsurzFVR2UUCygUGA==
X-Gm-Gg: ASbGnctk+D6VuOlQj1dAukHIRpM7FWzTPhessFiakjgFubqdk7RYyZMIQDPRJ/myqIp
	hnmT/n8UsYAbiawz1r1H6Zgp7LxUE4N7HKMfW4Q5UBPp3r3G4Gy4iQAtw1PyNX2yyUOAVnCspqi
	NBsZA6+ZUKC/4DAeZvzBSFDaUXtZ0c9T6HpWulYksnCSPCCaAaxvTE1bdTqY3y+yhxvUsg+b0aY
	vYHOfuwMxXTH5XnSy1TVyTNxdO8IJiEO93IidCDsmUzeYGxdNpR1pg0IlQ3wXnCjVfiBNYwkqCH
	WbzwMQUVltlOg9vcZJX6V2Gl88Pg5oinecRRIbrAfTsEGdJ1ygcYm1AstbqdbpslYBlsfpwYnmn
	CwTIyJQ0y3SSczEfQPs4=
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743318f8f.14.1759759061362;
        Mon, 06 Oct 2025 06:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSEXhNL5qt3C2EExsoRcqgHMQ8DFjBOOTUMJgsVGWdtBaHzjZoYrl+W+SOqr9EcfM/+bfqVw==
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743277f8f.14.1759759060881;
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm21356683f8f.11.2025.10.06.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:57:38 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
    Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>, 
    linux-s390@vger.kernel.org, llvm@lists.linux.dev, 
    Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, 
    Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
    Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
    Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
    Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>, 
    Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Message-ID: <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Sep 2025, Tariq Toukan wrote:
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +	if (cpu_has_neon()) {
> +		kernel_neon_begin();
> +		asm volatile
> +		(".arch_extension simd;\n\t"
> +		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
> +		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
> +		:
> +		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
> +		: "memory", "v0", "v1", "v2", "v3");
> +		kernel_neon_end();
> +		return;
> +	}
> +#endif

This one breaks the build for me:
/tmp/cc2vw3CJ.s: Assembler messages:
/tmp/cc2vw3CJ.s:391: Error: unknown architectural extension `simd;'

Removing the extra ";" after simd seems to fix it.

Regards,
Sebastian


