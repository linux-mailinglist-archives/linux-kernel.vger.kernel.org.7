Return-Path: <linux-kernel+bounces-852622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822ABD97A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88051888AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7662313556;
	Tue, 14 Oct 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbPNRZGi"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066619F135
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446616; cv=none; b=j7WNCD2E9AJiFp6m7wK/d7IxfsLqHGbQM+6QxY/HVLekBBVZcaCS4SsC3B95AGmkkiBJNpTKnXD9qYaPlGZL/2B2UQMzIU8BqS7fPIDhVrzks5NP7y/HBlynyYGsjXYxSSds7G5laaq0l9YlL4vGnqdAoKaqWNjagHW1IvmJoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446616; c=relaxed/simple;
	bh=LZnaDE/S/cnLfsiCdgYQZBmm8CJyduVyYwPzdW3joA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eHCiAg+LiTpzeTD4eAks4kv5JPZnflZ2yWCDZHCtRMx87N8qCQluS2WZMGZBQuwzoHZV52qeAqzDvtVVFxBFLC6Uf9CWUK98pKdGDEqHqKwiJ9AvARRJEKgop0rCdqASVAA79PCDlnuHpV/FBoToRIi+Fla3VzuifCSqtp8gzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbPNRZGi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28e7cd34047so41349425ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446614; x=1761051414; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o38gmX36PyqmjEq1ZTvcb122z3x4XvhpJiBBsGOOwy4=;
        b=FbPNRZGiLlkHEVjPtMDE/f1z5U1yIEiU035iCpunTyU/ld5oATJ8lClY5OqD105BzS
         eI7QvYUm9gH+2MKQ6WykSrwaoEgBhK91CY4PqBy6Uz23qRyomKKk8Oc9s2u+eyvB0rZX
         CJxDLylDF32QwYdxip7h4nVmW7FdUvsK3iqmCJNy0xK7WkG01cRVP8UUxvk2ZWgevegy
         PNzPtYHlnxkbl5CEHdqNU6XP7fQ5VBAt6+EIlJr+BjvC3zeQts6WDRo6/itAyCWtWlg9
         b0vUsuxYmOSQN3XxuorxKcYXI5DMWvZH482thHvcV780xzQfQewDXohLBNS8mgsGt7kJ
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446614; x=1761051414;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o38gmX36PyqmjEq1ZTvcb122z3x4XvhpJiBBsGOOwy4=;
        b=XuIOoPtg4pJP/tTzma2eAe/UhPjpfFO/81coFiXQQ8NX47S7aa48GHp8XOOF40XE4r
         zlyLcpfOCQF/+f/WuSkvlammPA8H8pW1ig22gU84QumyOG7aL/SM61ObLmwbZVmzZxH8
         Vir2N1lKj67G/OYcEQmsrqGBdy83k/BFnC2YLDSugLL8JTBPxpZsVoRZqLg74fkAAi05
         DcpsxbxPcDGvo06h0mWCdX2ZkthrVTRrfEzLdkT5Bf/ZXaYsc8Yu6doypm+SUg+0Nw7b
         kO/FcydqNaM7itPS5yz0E0SqfWpoc+0iRZ9B5QxZ0DstUCFGApAFMmULtCLgl6+EMInn
         X0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3VlSe7uEF+i+hF+fxrcAa6jBStSkDk/1o9lMIwiTLOhRDWs6F3GFzS4mwxtVLu4CNvbgkYY4l68zJXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVd62r+nEIaLom/9+10QlmYl5nxE/Nb4B/q5s8NaEEzj2VIVEv
	CUgbS7ojRpzHs0ZO71HDvyk7zho0j+ISOBsPHu/6886bh/XYRIQFwRTn
X-Gm-Gg: ASbGnctGEnb4H8YszToRxzgffIbxpt4Ch25HCB4Uh4z1vKlXauTF4FuZ7LSrCu6U5vZ
	93ECHLYmBY5b/wbFokUH4mjnWiKjjxj/X36/BZ0z30E4tlJ365iSgsdCbgm5rYc6dndYFbQXXmI
	Pc1iVDH9t3lX1yTzh+5dI7F/HuQvV308dje6KSHPpO1Qchk4OXzv0u4cSjzBq4VTSlQN1FruShS
	csAJqQIY5jifbk2UQTGlHhz+YGuLfKLg3dt0AK0rnzHKhm5k6pY4RS8OcS4NXnZ9nfyKWUvVQXg
	pPZqXNkE6C9YXgIlcZbAVzLBBjR3x9X57V6O3Sc0m3/L4lj8sZt6pXa5TSj+i0+s1pQwRg+DuDg
	Ka3XgFujaFAV5XVl8GNQU4Z2bs8yLe4pmSSeDxk2N/0wytD4brQveOKd/Sm1D3fFmBIqONHizS6
	k=
X-Google-Smtp-Source: AGHT+IFFPt+m448T/uVhH/uFa4IYkTCQ7dJj+PBX8yKsxeuPCGTRZrXD06eMiOSktRMiwnrCyjS6iw==
X-Received: by 2002:a17:903:2351:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-29027262689mr366784675ad.26.1760446613904;
        Tue, 14 Oct 2025 05:56:53 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3ab2fsm163919985ad.105.2025.10.14.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:56:53 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Date: Tue, 14 Oct 2025 09:56:43 -0300
Subject: [PATCH v1] arm64: dts: imx8-ss-img: Avoid gpio0_mipi_csi GPIOs
 being deferred
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-imx8-gpio-csi-deferred-probe-v1-1-62dd1b949731@toradex.com>
X-B4-Tracking: v=1; b=H4sIAIpI7mgC/x3MQQrDIBAF0KuEWXdAUwxNr1K6sPpNZtEoIwQh5
 O6RLN/mHVShgkrv4SDFLlXy1mEfA4XVbwtYYjeNZnTWmJnl3168FMkcqnBEgioiF80/MJCm4Cb
 /dN5TL4oiSbv7D+2Wvud5AVmyznRyAAAA
X-Change-ID: 20251009-imx8-gpio-csi-deferred-probe-eef6c56a35aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

The gpio0_mipi_csi DT nodes are enabled by default, but they are
dependent on the irqsteer_csi nodes, which are not enabled. This causes
the gpio0_mipi_csi GPIOs to be probe deferred. Since these GPIOs can be
used independently of the CSI controller, enable irqsteer_csi by default
too to prevent them from being deferred and to ensure they work out of
the box.

Fixes: 2217f8243714 ("arm64: dts: imx8: add capture controller for i.MX8's img subsystem")
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index 2cf0f7208350a416d77b11140279d2f66f41498f..a72b2f1c4a1b2ef26196c810b33ecfdebdbc1675 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -67,7 +67,6 @@ irqsteer_csi0: irqsteer@58220000 {
 		power-domains = <&pd IMX_SC_R_CSI_0>;
 		fsl,channel = <0>;
 		fsl,num-irqs = <32>;
-		status = "disabled";
 	};
 
 	gpio0_mipi_csi0: gpio@58222000 {
@@ -144,7 +143,6 @@ irqsteer_csi1: irqsteer@58240000 {
 		power-domains = <&pd IMX_SC_R_CSI_1>;
 		fsl,channel = <0>;
 		fsl,num-irqs = <32>;
-		status = "disabled";
 	};
 
 	gpio0_mipi_csi1: gpio@58242000 {

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251009-imx8-gpio-csi-deferred-probe-eef6c56a35aa

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>


