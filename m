Return-Path: <linux-kernel+bounces-741775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE3B0E8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EDB4E5A10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F721DF755;
	Wed, 23 Jul 2025 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr4jvqDU"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723771D7E4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239066; cv=none; b=l+2XNaiitLxnksdI0BMAHd1ZDDXW2sfAJUzpQBA79NI0Qv8tMF4FLKXLI68xoYI2BVC2V37W+FoLZAQQ42HKQVMeraou7YIijYASP42+grphtuAfkge0eFByTdlfJ9UZpgj9cEGyM0WEHOffJrF1XzVz8iZHsHe0V5CK/f9lzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239066; c=relaxed/simple;
	bh=bBT4L9g3RWOHKRnnytOicSWgTpvBG2gFZKqfKbcmNew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6PL1g2CKuSjxGbGjfEuGEOtg2/HGea88WrlQMWEL/2ONvH34mXejGC0C5jH57lb5knz/jR4xL80SX3OTxsaRep7lJbGcbxC/h1IXp4m7MzltdW8Y1+xUpr5hRlsYwroAELmfv60bp5S+XI63zCfq/DeudIasv94QV7JiWUSrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kr4jvqDU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75ce780af03so2280229b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753239065; x=1753843865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Njbz1ZCRdxWo32AbPbTjAtv4EdlkoZ9UGiPpbN/Wgqw=;
        b=kr4jvqDU0LBOjJYgkDmNgw/YJjLe6d2y/n9YHPP+WL3pclnQxvdwBkFM7JGW5qNn5K
         w2LAa3wMFEZCp1mOWL2VQ111apAd1XjILiPJH2srDfW6xAtLrwof5xsINwjPgbo8+uZn
         kW/Oy8dIQk4Sn2L5CKGEea/jSckC2gotCdBjLgR2XfeAq98kU16Bo19cInP2xrPsc0C5
         iXoPKSn7rFTQJ6RRJXwRfG8nRc2uq6IOezFcd3PD4p4cDlMIgIp0FVmXuU1Rds2mMzK7
         lVgLD2QCJIgehNKRyTNTmhANtLw+ESYIKR9GkPymTrv7yRnNjVRBtf2vpdbkZ5C2iQ84
         74oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753239065; x=1753843865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njbz1ZCRdxWo32AbPbTjAtv4EdlkoZ9UGiPpbN/Wgqw=;
        b=AK2qj94icVDh4re7fL0Ge7v/0zBorF+ouqS/xgfgUssSBqd++PZRv0DvG2pcgWRV4J
         4EelUnidzn3eou+tbKwXfTuGfJl4ayZMXcG7Epo6hamYn21gQ6SUzRpP+5k9fMh5RgDt
         hOaoewqDwA1aIs6iRC9KbvUgOXusPbkP01bU8Nm4lHt0yTDG4vo+j4Ey9jQudV1JT1Nc
         9Nso4+b+sgKgu36J8pwlEuUVoPuoxX7gwzEFDP4AK2WX7SQCXrsrlyf2y3YC1/WS+yHO
         7qa3EUaycdg9BgAf3zm/33xwX4AzW7ZyWQXBUbAu9vaawN/vl9qUJzwzukPq0Zbf/QcO
         Y8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXLUYWw7O4YfTTKZHLm1QeuSxgv9lq+Upj00mRtH1AbuwnXbM11bOjWeBDFeRn1RUCbLwVz0SwbLy3rJIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1wifNmM+UUYYZLS9jvYrtHhSvj73Mkj3yLGDg6Tb+gZ5eYhb
	OE94S0oiW2D4TchMr6SO828121Nf/qiB/CEtVR7biozPrp9R6dN2PTVv
X-Gm-Gg: ASbGncvsuu5gQx+XyLYG+xA0M9btjh5XDygKKoM69wUSf49wFsmraIaxx353GAEx2dE
	Ppnn9KsBHyRZL8AWIZ5abgknUFxuajdP8zoI1M48FTykCvDO0ZEDLfiuihtuBAe5bsYflI47A79
	lmXnfJGGI/ly8Syz9ing/kISWWasW0+W1e4bGkIDg/Trm3A1aXVpSkHYipvUM0ZMWl5f8Ft6HTf
	gQIzc2sVp7zrEbBFaERKRaR2o3Q/+j9zm4hTMphiz8JRUOrWmx60uhHLF1Kn3kBPJc8pzpwii/9
	cCyrPYUmpz58e7kgflwviTBhDUvsw/iyVy9Eg9GeLdQhfUKHrUSzf9zzqxTrSsHWWpYTBmbr73w
	I425H78Grdlc5On75EIPfag5t0zU30K17FC5Z0Wt0
X-Google-Smtp-Source: AGHT+IHpuYhVl5YmWu5fXh0L3TBrW12X/BLK3whPpjge727ynUybGgha6/nx5iPQ68Qb526e4QMHUQ==
X-Received: by 2002:a05:6a00:139c:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-76034a014ddmr1950124b3a.10.1753239064659;
        Tue, 22 Jul 2025 19:51:04 -0700 (PDT)
Received: from localhost ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1546a6sm8575236b3a.92.2025.07.22.19.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 19:51:04 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:50:55 +0800
From: Weikang Guo <guoweikang.kernel@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Ensure phys_to_ttbr on pgdir for
 idmap_cpu_replace_ttbr1
Message-ID: <20250723024923.GA1884099@ubuntu-virtual-machine>
References: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>
 <aH-mlN88NrTzahfM@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH-mlN88NrTzahfM@J2N7QTR9R3>

On Tue, Jul 22, 2025 at 03:56:20PM +0100, Mark Rutland wrote:
> On Tue, Jul 22, 2025 at 04:21:13PM +0800, Weikang Guo wrote:
> > Commit 5ffdfaedfa0a ("arm64: mm: Support Common Not Private translations")
> > changed the contract of idmap_cpu_replace_ttbr1, requiring that the TTBR
> > argument passed in should already be processed by phys_to_ttbr (i.e., in
> > TTBR format, not just a raw physical address).
> > 
> > However, the current map_kernel implementation does not always convert the
> > pgdir/ttbr argument via phys_to_ttbr before calling
> > idmap_cpu_replace_ttbr1. This can lead to issues on systems with
> > CONFIG_ARM64_PA_BITS_52 enabled, as the TTBR would not be properly folded
> > per the ARMv8.2+ requirements.
> 
> For the cases below I don't believe that this is actually a problem.
> Since commit:
> 
>   453dfcee70c5c344 ("arm64: booting: Require placement within 48-bit addressable memory")
> 
> ... we require that the kernel Image (including any trailing unallocated
> bytes accounted for in image_size) are below the 48-bit address limit,
> and so there should be no difference between the PA and TTBR format.
> 
> We could probably test and enforce that in the early boot code somehow,
> if we're not doing that already.
> 
> If we were going to change things to avoid accidents in future, I think
> it would be better to enforce this with the type system. e.g. we could
> have a ttbr_val type that's distinct from phys_addr_t. Even then, for
> the idmap code I think it's better to avoid the phys_to_ttbr() dance,
> since that has runtime patching.
> 
> Mark.
>

Thank you for your detailed explanation.

As you mentioned, if we can guarantee that the kernel image is always within
the 48-bit PA range,then there is indeed no real difference between the PA
and TTBR formats in this context.
In that case, does it mean that the conversion of `reserved_pg_dir`here is
also redundant? (There may be other similar cases.)

If we already ensure the kernel is always mapped below 48 bits, it does
seem safe to remove `phys_to_ttbr`here as well.

.macro  __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
    adrp    \tmp1, reserved_pg_dir
    phys_to_ttbr \tmp2, \tmp1    // This might not be needed either?
    offset_ttbr1 \tmp2, \tmp1
    msr ttbr1_el1, \tmp2
    isb
    tlbi    vmalle1
    dsb nsh
    isb
.endm

Thanks again for the clarification!

WeiKang

