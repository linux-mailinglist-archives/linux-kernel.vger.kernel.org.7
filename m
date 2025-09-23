Return-Path: <linux-kernel+bounces-828949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45AB95EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0777188ADE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D4322C9B;
	Tue, 23 Sep 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tzLIuP0y"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36A2D739F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632423; cv=none; b=oZ5UEqFgfEdfg1PgFiFPVtKp3lbFYrThpx0Y7bjL7k+YK68n6j35pUyQrD587bbM/LS8X8+S8Yp7479ClBKfmtMLiY7Q/UihXmYUjGs8WB7Pk869eh4yItA670+uioU3+q8L4mx/n7Jkp/GabyM1eFXnGd/6DF9GS52qUTuv7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632423; c=relaxed/simple;
	bh=vy+E1zYorab2a2XzZaWSJSTfgNU9c2BkfDyhamaFdNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hnZHTYdIDfs4ZdQJhnsT9pJZL4bMhFXw3PF4E2yCSE1lvh5RTRt84lCLCn6gKY9CZi+Jzbe4fYztlLrOB2gsEanB9eP9kGk1ceX7Uw6MyEYtSMSrEswrpqKO+zmj7VFR8DgdykFvjBrwq5EG9BAaoNC6LFguloViRTN6pXSHB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tzLIuP0y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so775210366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758632420; x=1759237220; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jQgMsYwYsxfq6lp2ULuttB6hJRdnd9uyWFcrhi5sA4=;
        b=tzLIuP0ytWEKt28m+XgNKc3A38n1kYglPDYpLPKQ9pf3nF2bth1ydLw7MKzk1XCPHP
         88V9fU2Aa/9Q8j4ya8cbO+uwwnT1qsToam7ZlXsPujzjSyGWj0Zp8hX9Vsf17dSs7i80
         v94pugzz43u4mdrhFVA65m0SpvgIVzU8gVTOT/1YyUOuyUQzrc1DI9g5w/c2OPb0Xjz+
         ewS8OYNry6V19co0fcnvGVh3Cg3Z/0yS3mnQRpmB+Slfr1QlD1WNOEl/6+bdxXHL6VZN
         QCHeNpiLfmYrDTYGJWiFNTBOm59xu8czIzBPkYEXW4UOBi+MdpRksHUkG8OZlxs98Kmy
         7Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632420; x=1759237220;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jQgMsYwYsxfq6lp2ULuttB6hJRdnd9uyWFcrhi5sA4=;
        b=WTGoIedvmSmKxcAa2f9BHZdAT4+fcdQ9vyUcEIqSEd/Aq4TyytnQXEXoOTaoHm7lGA
         se/LRdbUKPjkof5KnDd8Q9ASJAFgUP+6+T8/Bn3qf4K9+S/vPoL3fYEHww1P77mjJ0/8
         FwRTLW2pG4xDFmRY1V6O1OooG2ucASwBgAw1eP0YFXoDceho9QBjuy7EoheBcXDdpQgc
         f/5yWhDoVO7wSk/9z8Y705F4Tb4A4n7xwZvrMY4NulmsDDoH25BRBQWlKtnSOgPX0+HO
         BRfEdgN6aYU1Qd2R1Z10PaLcp4TWkILoT9jJHG7j454gYN0EFYZpeyz06WYEbQW89M41
         djVg==
X-Forwarded-Encrypted: i=1; AJvYcCUCwJCpOdaDLmvvBFKJTNfGxi4LsRvsvITotNvwLKUGB456VDpV+yD3fn1NYFL/lgi5zhCTI7WEmnnNWa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMx4cZCs2fGnAo2+Jv/UviRrrwXiVLT9ZQW/Qh4rFrNQpZGCeY
	7cdvxIyie/lppTENGPeFcB6nQMtb89De+TxA5LL01gh0i21Jh4wYj6ReaIz9eDV/iBk=
X-Gm-Gg: ASbGncv3y2ztE9iULeFGN5YKSMoTHByuSfwWZLN7Vxh5PIU+DUa9gNCH1sVhJoNFm66
	W31soAWVhHAaBnY2QzCTdB/qAfNX0KWEpvsvbgWITVDAevhJPXYFuavFFP09USeQHs6cz26OUFS
	Q3CTzxuTwG6vMrnua7JDNLB8jLXH9jl9PEn/RVxwN/AK/wSp6ndvI2A/exVT8EHWPmY6/vPtH8O
	oFIf/JxEoHPpY9+l6/XNaDpIgDVufJzFpQrLtAW4T0y9zaE0VcToj4MpTblFNnCc06HUk8uloP3
	etGE0QkALfPa8cgznOKJsBsKeX71L7gLrBFZwUlxIsa6SP9lAaHHAzR7apH26c0ZwNayr1oqppP
	a8QiNhPnE0oivshD6sUz/HA2PXHJ8Kfkv5jwJ5jqik3nmkO/bJsCp2s1jzSKxNGXx5KlL
X-Google-Smtp-Source: AGHT+IGD3NrE0KKZ/8qWAbi1hdO1vb3x/gJtMsj6xAGGJGo8t9h8hbseK2tTsAYUn9WPQe0nC385bA==
X-Received: by 2002:a17:906:6a1e:b0:b2b:f498:e2f7 with SMTP id a640c23a62f3a-b302b80a6f0mr239870866b.47.1758632420275;
        Tue, 23 Sep 2025 06:00:20 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b264fc79404sm978329866b.10.2025.09.23.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 06:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 15:00:19 +0200
Message-Id: <DD075WC7A6KR.NJJA1Q4WAJUZ@fairphone.com>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for sm6150,
 x1e80100 and qcs8300
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
In-Reply-To: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>

On Tue Sep 23, 2025 at 1:01 PM CEST, Dmitry Baryshkov wrote:
> Bjorn said to me that he disliked the conseqeuences of renaming
> qcs615.dtsi to sm6150.dtsi. Let's increase entropy even more and rename
> even more base DTSI files.
>
> Leaving jokes aside. It's not uncommon to see different names for the
> same SoC (or almost same SoC, with no visible differences from the Linux
> side). The platform now known as 'lemans' is a good example, because it
> had been using SA8775P, QCS9100 and QCS9075 in different contexts for
> slightly different modifications. QCS8300 / QCS8275 is another example.
> All such names cause a lot of confusion when somebody tries to follow
> the actual SoC used by the platform.
>
> For 'lemans' after a lot of trial, error, Naks and reviews we've settled
> upon having 'lemans.dtsi', the core DT file for the platform and then
> naming individual DT files following the marketing name for the platform
> or for the SoC.
>
> Apply the same approach to several other platforms, renaming the base
> DTSI and keeping the DT names as is.

If we're doing this already, sc7280 -> kodiak? That also covers sc7280,
qc{m,s}6490 & 5430 and sm7325.

Also, does this mean that milos-based Fairphone 6 the dtsi should be
milos.dtsi while dts should be sm7635-fairphone-fp6? The latest patch
series uses milos-fairphone-fp6.dts.

Regards
Luca

>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (3):
>       arm64: dts: qcom: rename qcs8300 to monaco
>       arm64: dts: qcom: rename x1e80100 to hamoa
>       arm64: dts: qcom: rename sm6150 to talos
>
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                        | 4 +=
+--
>  arch/arm64/boot/dts/qcom/{x1e80100-pmics.dtsi =3D> hamoa-pmics.dtsi} | 0
>  arch/arm64/boot/dts/qcom/{x1e80100.dtsi =3D> hamoa.dtsi}             | 0
>  arch/arm64/boot/dts/qcom/monaco-evk.dts                            | 4 +=
+--
>  arch/arm64/boot/dts/qcom/{qcs8300-pmics.dtsi =3D> monaco-pmics.dtsi} | 0
>  arch/arm64/boot/dts/qcom/{qcs8300.dtsi =3D> monaco.dtsi}             | 0
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts                           | 2 +=
-
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts                          | 4 +=
+--
>  arch/arm64/boot/dts/qcom/{sm6150.dtsi =3D> talos.dtsi}               | 0
>  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                  | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi                               | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                        | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                       | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi        | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts            | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts             | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts           | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts              | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts              | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts           | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi           | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          | 4 +=
+--
>  arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts              | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts          | 2 +=
-
>  arch/arm64/boot/dts/qcom/x1p42100.dtsi                             | 4 +=
+--
>  27 files changed, 34 insertions(+), 34 deletions(-)
> ---
> base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
> change-id: 20250923-rename-dts-5d74d6132f40
>
> Best regards,


