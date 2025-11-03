Return-Path: <linux-kernel+bounces-883487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6D3C2D945
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0761898FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACE2877FC;
	Mon,  3 Nov 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9wNou3K"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016919ABDE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193140; cv=none; b=Jy4vSNJms/g3mrbAtODoxd34Mk/6RGRLgCnpcfwO2l6Hm0eH5QOjZa6b+aQL7NQndN1zXoqRUv2CAxdvUKuwALywYY0f5uJO+PTTs+COxIKG5CzSFzxFthR1TuRHKrafvEKH69gCTTV8Pfb6WU0vCTfdd+BZn0K1hICzaY1xb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193140; c=relaxed/simple;
	bh=PISYnyVrW+zygEMF1f2YOQFTzGbLCiScr72QBhAs73I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYOGR9GiqhpQijOWLAbRmUprKKdLzrj7sJzcPytcpu8H6nyjW3eZ250sfQPwBgLzXyCXvyDnD+YN5j8dCPkW4JtB8fT7BvAojX+EccpM3LRwVRfsKSBtf7ajF+voTjGMo7yeepBu72UXvicybiicG55XNYw31VCyleOPgxs3BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9wNou3K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-362acd22c78so41719411fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193136; x=1762797936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8aecrmpQ3K9U7oiJGcYa/Rpdn9pxiAVmo61NrsXbt8=;
        b=J9wNou3KNVNCwbK34zdV0koeNZPam9yEEEyJgENpNXhTaTjtqB2YZlP8QT/TLbMypD
         M9kMiXsec/O+gCm0vyRuYZOA3zLrKmEQ8TPTiwxMFVgbgeMqHzS0Wd4Y/2V9w5O2th9a
         +IgdkDIRS+RnBCtPACsmad/jjNo5T4qqM20LKaTOQc6Df3iZ7waOfv4Mk45a/47isCn8
         jCPuvXTEvVqJpxlPvwRXkcyu0a7ivfPLZtwxTXqEUYarS3mMjeI+Q+Qx29ALf+43rzKu
         QS3fL+fJNVEs/Cv59Z2cAmY9HAILXeXIKfDFUk1RdWaTS1jQZhF9GvqhPZiiSHClJQ6z
         Q1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193136; x=1762797936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8aecrmpQ3K9U7oiJGcYa/Rpdn9pxiAVmo61NrsXbt8=;
        b=HBriCys+AJC0VqtA7GlNHSkDQCLp3Ypb9iNluBbQjfVOWzTJBWakLSPoMJO3QsfIbK
         H6Nt/FSaDhSe+Rur0kT1DMVUsn7NynCapJtYBS3dfpxGrQYzanhbcwbEnSEQKkQTWQev
         N7D8SjfMI1Gcskiu0uEf2KOCasG2hvOE6XOusFTIoR1gUUx4nR0vsW/TZ4zbo//Yk2xB
         UAjXUemKdohcla7I+1NU/Bf1xAa2nd6sKPH9IX8JnUgDPGsquoW7ZRET5XgB5wmXg81r
         xMJB2t8TjDxZ5vqpwu8dQmKQl+rmNGzK9AXgCTxEYJiilxN87ALO7i927Xrnt/82Y+89
         FPkA==
X-Forwarded-Encrypted: i=1; AJvYcCXBiwxyV/i2dX8BxrMNBm7KouP4Py13mlCxMiEBMtBo06ibzQl+MymHcLR/1F8n8Or9xpGo+RHRSCVyF30=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAW9IINZXgtexZOpbjs3CDbcSUT3fFzGWqCZAMBDdu3DsdllU
	dt8c6EmtWThQAvAsSkMJeFuLGLV33K4AGpqqqFWKGyiaDgNFLQ9mqZUS0xPsOiCJhAFDQB7+0ui
	i9aB3evb1regITkjWPaGTA38J7TxQ+ZzplA==
X-Gm-Gg: ASbGncu1tE4RqwecOzJiFNJcbA3BY7nvUC0n/Y5S2/Pg6zefOMEtj40j9mOd5k0cJVT
	uoPyHAn5YugC2egCOm0hzUJFTVwW4axQNXR64uo5oZtc1HhZR2jI+q+aSnVobQRqjZuGR/2P2Pc
	/5vjInptCht/FOFIWpaFN1jaqXkVv7KlfNXD/baZHLXP8ViwkZ40D03pGvc4qujO8heV7pZysO4
	Cz1yx+UbNaqhN/UXcU6K+Pqu6KuqOogkHN2BFMpI35YyW77Q0kKCNUaQgnUzHfO20J1CqA=
X-Google-Smtp-Source: AGHT+IGC7/OpISkWQbMMipKycZQIYQDKL8rXabUx2InfXFTpSjCKCJJBdIGKPmclJe97UZMkkDuX8GDTzhUEQwFUA10=
X-Received: by 2002:a2e:bc21:0:b0:378:e8d1:117 with SMTP id
 38308e7fff4ca-37a2626ec92mr31718591fa.11.1762193136204; Mon, 03 Nov 2025
 10:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-tegra194-dc-mmu-v1-0-8401c45d8f13@gmail.com>
 <20251101-tegra194-dc-mmu-v1-1-8401c45d8f13@gmail.com> <CALHNRZ_QrQHCmF7f1z29tAmuNR-=rG1SgYJ1sssK3VXiQqURYg@mail.gmail.com>
 <ehkwvvmvk4mddxtcmne5jrex2rfq4phqsa5zifxdslrpvdl2ir@3zlwejmx5f5f>
In-Reply-To: <ehkwvvmvk4mddxtcmne5jrex2rfq4phqsa5zifxdslrpvdl2ir@3zlwejmx5f5f>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 3 Nov 2025 12:05:25 -0600
X-Gm-Features: AWmQ_bn8e3wfcvjuhO6Vmi4IjMPB_dfMYgSSGbJtskmsQArECnzIC31_RuG-ptw
Message-ID: <CALHNRZ-rArVkbEaiEVwMevfbu0dgX5P-ooVYTd-3RHvrhOJ5vQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "arm64: tegra: Disable ISO SMMU for Tegra194"
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:07=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Sat, Nov 01, 2025 at 06:13:26PM -0500, Aaron Kling wrote:
> > On Sat, Nov 1, 2025 at 6:01=E2=80=AFPM Aaron Kling via B4 Relay
> > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This reverts commit ebea268ea583ba4970df425dfef8c8e21d0a4e12.
> > >
> > > Mmu is now being enabled for the display controllers.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra194.dtsi
> > > index 1399342f23e1c4f73b278adc66dfb948fc30d326..854ed6d46aa1d8eedcdfb=
ae1fdde1374adf40337 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > > @@ -1807,7 +1807,7 @@ iommu@10000000 {
> > >                         #iommu-cells =3D <1>;
> > >
> > >                         nvidia,memory-controller =3D <&mc>;
> > > -                       status =3D "disabled";
> > > +                       status =3D "okay";
> > >                 };
> > >
> > >                 smmu: iommu@12000000 {
> > >
> > > --
> > > 2.51.0
> > >
> > >
> >
> > Question for Jon as the author of the commit being reverted. The
> > commit message states "we do not have a way to pass frame-buffer
> > memory from the bootloader to the kernel". If I understand this
> > correctly, this is talking about seamless handoff. What does this have
> > to do with enabling mmu on the display controllers? Seamless does not
> > work on any tegra arch as far as I'm aware, but Tegra194 is the only
> > one that doesn't have mmu enabled for the dc's. But enabling mmu
> > allows for better and faster memory allocation. My initial attempts to
> > enable this didn't work because I tried to attach them to the main mmu
> > unit, see the related freedesktop issue [0]. After noticing in the
> > downstream dt that the dc's are on a separate unit, I made it work.
> > And so far, it seems to work just as well as Tegra186. Then when I was
> > packaging up the change to submit, I found that this had been
> > explicitly disabled. But I'm not seeing why. Am I missing some
> > additional factors?
>
> This isn't seamless handoff to the Tegra DRM driver for display, but
> rather to simple-framebuffer. While this does technically work, it also
> causes a spew of SMMU faults during early boot because the firmware does
> not properly pass the SMMU mapping information to the kernel.
>
> In a nutshell what happens is that the firmware sets up the display
> controller to scan out from a reserved memory region, but it does so
> without involving the SMMU, so it uses physical addresses directly. When
> the kernel boots and the SMMU is enabled the continued accesses from
> display hardware cause SMMU faults (because there is no mapping for the
> framebuffer addresses).
>
> That said, we did solve these issues and this may not be happening
> anymore with the most recent L4T releases, so it may be okay to revert
> this now. We should find out exactly which release includes all the
> needed changes so that it can be referenced in the commit message. I
> want to avoid people running new kernels with an old L4T release and
> then seeing these errors without any reference as to why that might
> suddenly happen.

For reference, I have rolled back my Android usecase to use the L4T
r32.7.6 bootloaders on T194 for a variety of reasons. So I am using
cboot as the final bootloader and not edk2 as in L4T r34/r35. I have a
pending cboot patch to support simple-framebuffer handoff, but haven't
fully verified it as tegra-drm is currently unable to takeover from
simplefb like openrm does for t234. But all that to say that since I
no longer use r35 for t194 I don't have the setup to easily verify
which point release works here and what doesn't.

Aaron

