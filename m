Return-Path: <linux-kernel+bounces-831952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24836B9DF91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37932189E1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA7725BF13;
	Thu, 25 Sep 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8oHxhiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F5264F9C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787609; cv=none; b=ZT5pybRHpPJYwnxOCY6CWgHS3rxvuJIs+CY2pXw7Efj/I/bI86r6Zj6DyoYYgHO6ESZgeB12rLILkn7i+Sp12zaU6KXkmbzAqrFWmxNinEr7f1Xmqoq1dTx3PJN30RbFmxFKAV+xcAPoooOED/5LKBdJ2/QzqAcAvau7Ueauoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787609; c=relaxed/simple;
	bh=DVwlxF/svV1IFN8OyNfG4o7hvImuO/XEiGO7RMABJJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYO7HzsEBFF2QSl1jln52CjzE2biThsRkntFGII//1Zb/ni5dLz7/QOnQr40hraHAvVcwr73X74g0d4sa19Yz09M8JPrP/RihICcg6+7u43wt2bqqBx/4q1E4LO3QECDUqiKvKbC7LJ2T/80qB4JJDovzAGq4B2fhEU2bdx6+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8oHxhiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B651CC19423
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758787608;
	bh=DVwlxF/svV1IFN8OyNfG4o7hvImuO/XEiGO7RMABJJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U8oHxhiKFkaXwB1bLXCPV8mu1rWJfdC/uGeziAoFpE4updSZ67tARvMaIxUi83YjT
	 ChrMfTh/GkXaavkLXPI1U1ZYVqiEYxYgRFUhJ/rGjS5CCusETayBWuv7k9DKBNgeGN
	 iEO85c0xhU0hdQhZ4aZEynqkdGhHmsbB4/jRHUZmAf6DvL43X95IoX/1Z3pmM4Q8Qb
	 x+hbejC9oFBwdRCbhCee8Zn2n0SFKh1+LQDsuSR8z9t/P38XIPFl1EiiL9FpKVTpvP
	 ZJyVW2u42QKdJq503YhIqaS6A2Fcf8o2vw5/bWgYAB3zQQhDr7v05EEf8zKIREj7Pn
	 rEuNCHv3BTeeg==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso495601a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:06:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTOla16xDGWFPHyLMvtYwcrhmdGCbgVaWae16Un8feGS/P3RYM3PPHPD284xwsB/Fc4ZI44ltBK5d7pqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4gETLlAO6PiJWd9BgrtpzCmldCpL+OkKNHp3O+vBz4Tpt0JS
	2NBLD86Cfc5EA0SmEqdjLn2nExH9CI9EGen63ViWI1n9WyxS3faXQ7T71dTMGMLCyBk9uuKCqmU
	UpF3AwPAaR27KdZs7YcrFfmFB4uEnBJI=
X-Google-Smtp-Source: AGHT+IFCLOK/+UpgibxP5CsAr7jSR89vqrMRyOeMa6JDMQ/RxcVofJDyTrRkOI4g814Y611Xi5LK45hjeu3ifmNG1Us=
X-Received: by 2002:a17:903:1a2d:b0:25a:24f2:af00 with SMTP id
 d9443c01a7336-27ed4a06c8fmr29198305ad.12.1758787608215; Thu, 25 Sep 2025
 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-7-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-7-24b601bbecc0@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 17:06:36 +0900
X-Gmail-Original-Message-ID: <CAJKOXPea3Jhu6H3Sk9oU01YuBnwS1rSnmWpZ=3+qSur5WDh2Hw@mail.gmail.com>
X-Gm-Features: AS18NWBFMHkNBWI1qRqOJIsCl3eK5dq0XfHUmqGPdgc1WKCVM8tL2uyUhPIgiXQ
Message-ID: <CAJKOXPea3Jhu6H3Sk9oU01YuBnwS1rSnmWpZ=3+qSur5WDh2Hw@mail.gmail.com>
Subject: Re: [PATCH 07/24] arm64: dts: qcom: glymur: Enable cpu dvfs for CPU scaling
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Taniya Das <taniya.das@qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:33, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> From: Taniya Das <taniya.das@oss.qualcomm.com>
>
> Add sram and scmi nodes required to have a functional cpu dvfs
> on Glymur SoCs.
>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 87 +++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index ae013c64e096b7c90c0aa4cfc50f078a85518acb..d924b4778fd37af8fe7b0bceca466dee73269481 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -46,8 +46,8 @@ cpu0: cpu0@0 {
>                         compatible = "qcom,oryon";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
> -                       power-domains = <&CPU_PD0>;
> -                       power-domain-names = "psci";

NAK

You just added these lines!

This is some ridiculous way of splitting patches. Sending wrong commit
and then fixing it immediately.

Same as Kaanapali, same broken process which year ago and two years
ago I was already commenting on. You are repeating the same mistakes,
sending wrong code and patches which are unnecessarily difficult to
review. And we discussed exactly this already!

Best regards,
Krzysztof

