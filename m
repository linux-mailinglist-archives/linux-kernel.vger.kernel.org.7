Return-Path: <linux-kernel+bounces-829252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08571B969D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E00188E58D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5784D233722;
	Tue, 23 Sep 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QYL8no54"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E581B4248
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641854; cv=none; b=Gi8qrRVk8eLv3/sHXob6iZ11qhK/DGRLa3j5Xyp09/z5vZyDjhDoXRBrymfUMtw3g60UFdkubrQOzhLff/vUYXANqiOk62yUqRcAP5PaQWSF2GzFM5kjtQBV6jAJFHpZtpta5sXR4sa13+lCKE24mhSDgseY/V8aBKqiwApZ2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641854; c=relaxed/simple;
	bh=VPsPP97J7NiYsQImvFBzCd/NUWkzwiH5aWFfTBKY7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7wt8z/qZqJ2XOiGLho3DMr2D1DfrmyV4hDInTmaJSoZxfSHqL0EdcIt7mngae+9ikpatqtUedhXFLEYTLRqTs5xHOZAUYH77OBr+VzjrG4gm9Ta6wR21Jd+irpGz33rZYCk45X0A0nb+qnWl4DNDBozJN343g910fj9I7DAShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QYL8no54; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-eb368d14a43so784206276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758641852; x=1759246652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wa5b2Ox9cKpFtfieebnhk7CueJ3gddY86USQDYphg/s=;
        b=QYL8no544a9aasSptURayciMEqmX1gfPc6FXP5EPQr5zlyBcAwocQfTAxJpyWgVJnz
         VZiZZ9zj9uoq71tUJd0wYfFnKwIgYzGJ9yfzv58+6R3pHjk+XRAN32I/hF7bmOEfX3JK
         MdZyLoaPD6SUzuudvP8QJuJv9iPdkre4o6olZR4c8xa3dKPQHd3jdOYC4vjAq/nRujs2
         9ol21MWNB+WpIFX9po+zB80WlJs7OhtQFJxGt6R8a5kFNpFm1Cc0osEcF71KcBxUOeBt
         GCavLFtsY4s/leUcjp+GSke2dyRR491WddKoq3tUiw0fKc1ylD3OR4+V71MAZOgLYtu1
         E8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641852; x=1759246652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa5b2Ox9cKpFtfieebnhk7CueJ3gddY86USQDYphg/s=;
        b=nwh6Y5H/WUHSurI/+OjpRkI2K3fh+qPIgSn1TT7c8Szmth2Idq2TjG08kceH01egI9
         wHKdi6XF5L1vr9foB7YQs+9Oak0ZAPz5upIL33AzwPSqpM1AJIrBGudRfkgEWADU6fOr
         D3APFBtNWHWpJzEOM7NwG83+C8lMrZOVQLvZxzosBIvejDnsTLdjDe013NscJr71GuX5
         QPcj4rowBHJcYw1p3rNjAGCCfwyMIP9/uLM7z748/X90FeOuWSWBQ7xBok544hHNi2uN
         lbVhXqUXD1bAusaXyyaQTWtTDCl0oXkW0+YvkZggmhUnKEuwS84Ta7oekC2yNHLXFcH2
         cgMA==
X-Forwarded-Encrypted: i=1; AJvYcCXhGREnMTO6PQ0RuOlXsW/mOdPXSmTTuxPFckq0OBcz6+k+7KlAzDTivnVV4DSqjTtUZuiZnLOuEqJAIv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSWkG5UPj8zrulPjU4/l8fVDSY47RaACYx2L+qGZtMYaTeGbr
	reDihSzFq0Fou7q1Ybt/dOZXlAt+c2e7ImZGNvoKdBjTu0xYJvtxRNTD8heEW96opx0=
X-Gm-Gg: ASbGncvWgZs7J4+sQ2EqLJeNDuprmogP3DSrsicZ1oCzMrswC5RlJjQenhkgFDJtFC2
	WmSs8rno2gHzjwGOQ/MT5rgWvZBBqUWh+7U/YepA8hFR+IpxYI8ZyXPervkFRqMjfTL4RnvKhnt
	l2zfEAU06gqv8c0P7vt/e6VchWgfUDm0wfJu+IkKZKKxE5rbJWYsKukcN7umyb5MTH/kDh/3xl6
	REuItaWNB5AeZPAIkZWvR6na5jm7Z+MoNInMQhdwyNrLSpdrewTsG18MwR5jLQwFPC4jHcKWke+
	UDySfSLT22RwVUMvV1OQ2FVFrOrmvhnVnkQySdCbKm4mrcnMj2C32BXklAeEM7rXBNmkUdXwvT9
	phlDt63dYKOhqB48ZJ4Osd2Jj
X-Google-Smtp-Source: AGHT+IEg1iVUs6leKP9cHj2cx58SzsL13TI+csDZL0P1k6w1OJijHfrbcJXnEnD/4J+xBKVTIxDONg==
X-Received: by 2002:a05:6902:1381:b0:eb3:6e74:dd0c with SMTP id 3f1490d57ef6-eb36e74defcmr792195276.24.1758641851831;
        Tue, 23 Sep 2025 08:37:31 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce854f57sm5087789276.22.2025.09.23.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:37:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:37:30 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-54e8e0f39d672845e2979286@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923-de370be816db3ec12b3ae5d4@orel>
 <20250923145251.GP1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923145251.GP1391379@nvidia.com>

On Tue, Sep 23, 2025 at 11:52:51AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 09:37:31AM -0500, Andrew Jones wrote:
> > undergoes a specified translation into an index of the MSI table. For the
> > non-virt use case we skip the "composes a new address/data pair, which
> > points at the remap table entry" step since we just forward the original
> > with an identity mapping. For the virt case we do write a new addr,data
> > pair (Patch15) since we need to map guest addresses to host addresses (but
> > data is still just forwarded since the RISC-V IOMMU doesn't support data
> > remapping). 
> 
> You should banish thinking of non-virt/virt from your lexicon. Linux
> doesn't work that way, and trying to force it too is a loosing battle.

Well, we need to consider virt when the hardware has virt-specific
features that we want to control. We also need to consider virt when
additional address translations to go from guest space to host space
are needed, as in this case.

> 
> If you have a remap domain then it should always be remapping. There
> is no such idea in Linux as a conditional IRQ domain dependent on
> external factors (like how the IOMMU is configured, if the device is
> "virt" or not, etc).

The remap domain is created when the platform supports MSIs and always
does remapping when the IOMMU supports the MSI table. It could even do
remapping when the IOMMU doesn't support the MSI table since it could
use the DMA table instead, but that's left for a later patch series if
hardware actually shows up like that.

The difference between virt and non-virt is what addresses get remapped
for the remapping. For virt, guest addresses get remapped, for non-virt,
we don't remap guest addresses. And, since we don't remap guest addresses
for non-virt, then, rather than invent some new, arbitrary address, we
just use the host address. Remapping is still in use, but, as I said
above, it's an identity mapping.

(Note, for the current riscv iommu, "remapping" for the non-virt case just
means keeping the set of IMSICs that a device may reach limited to just
what it should be allowed to reach.)

> 
> Be specific what you mean.

I'm always happy to clarify when asked. I'm not sure what I said that
would lead to thinking remapping was disabled for the non-virt case,
but hopefully what I wrote now clarifies that it is not.

Thanks,
drew

