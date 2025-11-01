Return-Path: <linux-kernel+bounces-881598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE93DC28870
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4D3482F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAA1F63FF;
	Sat,  1 Nov 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuiro7t1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778083A14
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762038822; cv=none; b=SMmnHMqsBx4+reiWsw420dDhRj8FH6c5FrAfja5ptpdE/IqgJInJ9y19Xfg11ryxeaA8bxi9+aNnO1cyhbZL7MOmPtMME9UXDNOjMKDiWidniowWbJbbegWfZudO4s015axAI1gVqm7miia7U8tk9BX+HnAcns68AKLu+FvwXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762038822; c=relaxed/simple;
	bh=SrBDDWvLXhp6U/q9qNGjROiU4g3/enClGtkXirRh038=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmzXIIDdcAQKPkBG/9AXws3MefU1VWysuCs13OChEmJo3cjgLIvbdIbl/Nhjwlyk8iTgTzNNJpG4pu4n2nHF2URBxGR4a1XMviV/IUveceFfRO6qUVOot9MdX6mFuhezXOvnRdR+A+cpQG/6sWPUY7ofa8cE0NNN2OGnAE2pNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuiro7t1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d50e1c82so31874701fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762038819; x=1762643619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYzGZVeDG/F2ZwAs7gohbCGEqRaB9fTMjsTsiPiSNv4=;
        b=Vuiro7t1K/kjRdRhbHqfsvvpkFJeiuHIV9wV1rz9YcYxGQ3VFVY4+EjongG7M8+D52
         MXI8BqAFzxxhXgcOlKS2dID5H9PbdeOsRKezDik4zFKdKylM5W4btKxiiJ6LJFrEw1Pj
         2WuWQwls5grEA11cyQPWF0cdwfckDAFS5J6lRCc+khG8Vz2i895dN1NRhh5aukdbpSXs
         jxjYuwlfYIb20XLTnO5R/lvfoq2T1/JcJ3IvZNNNbTLYQ1U91bQxGJ95xbzOISnlGp9t
         ykPRQIiRCMiD7rNPy7PBJidrSc/a8OKmpnneK76cVU6RnituckberWNjbzmrNMrhTPDG
         wgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762038819; x=1762643619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYzGZVeDG/F2ZwAs7gohbCGEqRaB9fTMjsTsiPiSNv4=;
        b=RGTyHyvunD7u/Fwhws4Ue//+cZ8n72AG3Q6RJ9G4JDlCV/g6Z5/LQQKJiwDgq5NNa/
         riGY4m7xWo1sFbqgD9Q/uVkx5ckt0rMINcwoG7nS8zePKUzP89JZCmEjmwfkxdaSB0pc
         MRbfNddCDK4FIubZYvoH9BzduJtpsdSc4e5UHrhtuTBgHLn/SA8mNiAT1kEjjB4pL9uG
         NoNA+AficwUtTMJF/uYZ0qXXYgMnKdmcPMjcNpkWM8TA5rp0MTLMHGvzzphyHacszT39
         j+3/cbfBXPY/jDNO3YiWxnSUK5JJrSgcInIWsL/vx02nNUGGDhivRFfzoDG+O2RmUDsp
         15yw==
X-Forwarded-Encrypted: i=1; AJvYcCVmZeNjsDL1iDYVADAiSAMdNCiPaGpP5f8dyaCZYpShNH74ROtwA8wwbbo2cxrQ9YjIWMY4OBcktroglWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoW6yfjQc40TWiP9HZZyngCteZgWAq71iL5177qT6zkOvUL/2
	I6iK7FnXQscBmqUqhUjp+dNMyAyLT3/Ov+iPEJxz2o25FbJVvG165Pn4XmNoiMhXL2IHwBQjCGH
	q9GQUY0NgjznFEPHoUROw+pHnnq86MxSv8w==
X-Gm-Gg: ASbGncvwZtUc13Maxw6Bn0D7zU1hbB7AuRnmbfpeluHfCTMtkX+LcSJxs3d9wfA1xVr
	n7zphsh/IWydHiVkxYsmwSvxiM7XwfsAR3vyJ9AgiWaynHomKZ/Q3gk1WY+t9Emflx6Lrlgmt3K
	JqBow2niCXpphSMA33jN020AYbBdyOpp3BS7qT58Uuxxq5qnv261j6o1KU3RsNZq8o+Bao9GoCA
	wVR3INsi3IlKPpdhjbsBj2jzwe7nIOkxz9kQ4K7w/DQ6yx/jmILn2OW4/XRqe4/WqHWoAc=
X-Google-Smtp-Source: AGHT+IE8XHymc5LMX6z1ku44swz3jJJw2qy7TpmnFfZvFQicmRNID6fCODQ/EG2fDStIeCQx9l6QeL3n1Ukp8sZtLxA=
X-Received: by 2002:a05:651c:19a6:b0:378:e673:cff0 with SMTP id
 38308e7fff4ca-37a18da4d4fmr27578951fa.5.1762038818390; Sat, 01 Nov 2025
 16:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-tegra194-dc-mmu-v1-0-8401c45d8f13@gmail.com> <20251101-tegra194-dc-mmu-v1-1-8401c45d8f13@gmail.com>
In-Reply-To: <20251101-tegra194-dc-mmu-v1-1-8401c45d8f13@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 1 Nov 2025 18:13:26 -0500
X-Gm-Features: AWmQ_bmW3soIlYVprrFQERj13nFXgvHtfazndXt9w2FXnFW8w2VSQcJDNe151xY
Message-ID: <CALHNRZ_QrQHCmF7f1z29tAmuNR-=rG1SgYJ1sssK3VXiQqURYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "arm64: tegra: Disable ISO SMMU for Tegra194"
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 6:01=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> This reverts commit ebea268ea583ba4970df425dfef8c8e21d0a4e12.
>
> Mmu is now being enabled for the display controllers.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 1399342f23e1c4f73b278adc66dfb948fc30d326..854ed6d46aa1d8eedcdfbae1f=
dde1374adf40337 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1807,7 +1807,7 @@ iommu@10000000 {
>                         #iommu-cells =3D <1>;
>
>                         nvidia,memory-controller =3D <&mc>;
> -                       status =3D "disabled";
> +                       status =3D "okay";
>                 };
>
>                 smmu: iommu@12000000 {
>
> --
> 2.51.0
>
>

Question for Jon as the author of the commit being reverted. The
commit message states "we do not have a way to pass frame-buffer
memory from the bootloader to the kernel". If I understand this
correctly, this is talking about seamless handoff. What does this have
to do with enabling mmu on the display controllers? Seamless does not
work on any tegra arch as far as I'm aware, but Tegra194 is the only
one that doesn't have mmu enabled for the dc's. But enabling mmu
allows for better and faster memory allocation. My initial attempts to
enable this didn't work because I tried to attach them to the main mmu
unit, see the related freedesktop issue [0]. After noticing in the
downstream dt that the dc's are on a separate unit, I made it work.
And so far, it seems to work just as well as Tegra186. Then when I was
packaging up the change to submit, I found that this had been
explicitly disabled. But I'm not seeing why. Am I missing some
additional factors?

Aaron

[0] https://gitlab.freedesktop.org/drm/tegra/-/issues/5

