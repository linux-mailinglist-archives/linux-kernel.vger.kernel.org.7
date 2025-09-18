Return-Path: <linux-kernel+bounces-823225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60266B85D78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8977B4602DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD675316908;
	Thu, 18 Sep 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Uefhcdmo"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB743168FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210773; cv=none; b=m7MG8MElI+QD1poGoiyOKRdhFcF7TAk/A5foduXQWhsNLpB0CuFSGtrTrAxvcZV4cnD6v0t4uWIdjHhYKrfhmNsDXpx/3HOTkkPggKMmTzxz8COAiN+WsbhtsppY95EX7SFUZRmNhxIjxXL6iAXP5BYEs1b7JLB9JwEowvoDXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210773; c=relaxed/simple;
	bh=bKYvTL8MbcZirvGbcTLtImf+31bpwxjEuwrssdUZtAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNBavlBUX5lgHkqOCrI/PZj4oQlNFPBS+i33QbK3fESUqxG2cVKLcQw5c/IbWZdkfzkquRvevhQIrs2zt+1gVBMk40EFTOpEffiHc/IyIzawxZpbywEeHzIBchcXzhgalTFe4/ZXMCBr6bv8d8/THzrUQnWsi/lOgVdXOgjQHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Uefhcdmo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07e3a77b72so319879366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210769; x=1758815569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lcdJmzD84uDfab79lyqxcqnmMvBiautmvBU6m3EhEI=;
        b=UefhcdmoBtjBwTbpcnAf2ErmCwikynF09gDihaFdzPqKJ0v2Mzm8yS3yV96nujBc6I
         PstEwlyp2ljv5LlCQGlPSujTgyxGC2bSltrJOGUuOUhPkp8wsmSAhWqBSlAYWOUgH/Mo
         ENwSameNP8fNnt84kP+QLOAhwQkiaEWAQ71J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210769; x=1758815569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lcdJmzD84uDfab79lyqxcqnmMvBiautmvBU6m3EhEI=;
        b=nWGJ8PVKf2niYsSDvsa0gb7jehWwshvIkghuwuekTYV5qpYe289gt8K2FHcvmGuuac
         sQh6A5LigluR0zOj1CwI5BRVyfX3u4plFoE66ddMAQ74sbxWUZH2JNtNxpD5oBCBYuxC
         nYSeEVxSwC1yhlnpCwa6qsxeZP0Gv6NXRcKeJ9jxVcU6Qh/fqcoEx9G22P7jEEnX071E
         OGHYjZLB78qqBEgzRpPCt6Nwy4FcHyB1cpzyaSO/dSig+okofQeH11u8SgxaREn/OqR1
         52hNXOfxUDOquaP41vKmC9HKW2DEjXtw1RORKgIdrgPja45foLR4+35OV7A8PNabBxsz
         FKrg==
X-Gm-Message-State: AOJu0Yz7oIz3gVwOdCdCA3hnw4Jjci1ypPcgGaShvKCOoobeUAr4ALdP
	GJ24RWJgJHEur/sgpYJGHMV2qpzyjL3uMZVp2PjB2BOhUnZTijJd4UgXxvGJOS+l3DVd/djoun2
	aI5S4
X-Gm-Gg: ASbGncuuyqPf1HMtGYShd7r0OXjO3xnq0Tn9nlCv6M2RoNHoc1jOR49+AAoP9eJoIcZ
	KIsC6A41JBJsxY929LL/RnTudZa+LCyFmqSbN6kon5mp4TzY1R09BbgJIaegmfmUvaOVknOTOPD
	Iwy5ZvyUMHw4EDM8ofgPk8prygqQzTAc1cwRSToooVKMmPqHb/g9SgMiG04HrYnCUClyYtU+UUL
	S95MMTXFmHseGhFL17wVrIxWECnzquOafIulm5vpPPW17alwjh5QcToefOcI6ITvRDkHslj4Cn0
	WBnbG0FErTvJiRnOP7uG/a15LCb6orNIm0ve5tmDCHf6zoTkkr9LqQPGILuDp39XbsRJhtThbaZ
	s060+5VKw9PRw+Oecvpixa91AnzqMCLxS+OxP+yXC+PnRd9N05ehTu+KGCodFPJ/UJd7IG5mgmS
	9R6fm0/H308ASLemhG3Al8+Hm3AW/Vg1B9pMkOmhdg9lCeJHfAWQZRZLaSIveyj/53h6xq0ic3P
	UJ4IdrPtkA=
X-Google-Smtp-Source: AGHT+IErelZCb4Ng2hNIph4lDPD33ehWDH5J7iXux+fMT/vxxySG4ibwfi79WajSIooQhiHJCIIbVw==
X-Received: by 2002:a17:907:934e:b0:afe:ef8a:a48b with SMTP id a640c23a62f3a-b1fae7a9b82mr410713866b.30.1758210768899;
        Thu, 18 Sep 2025 08:52:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:48 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v5 4/6] dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
Date: Thu, 18 Sep 2025 17:52:32 +0200
Message-ID: <20250918155240.2536852-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the touchscreen-glitch-threshold-ns property.

Drivers must convert this value to IPG clock cycles and map it to one of
the four discrete thresholds exposed by the TSC_DEBUG_MODE2 register:

  0: 8191 IPG cycles
  1: 4095 IPG cycles
  2: 2047 IPG cycles
  3: 1023 IPG cycles

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- Adjust property description following the suggestions of
  Conor Dooley and Frank Li.
- Update the commit description.

Changes in v3:
- Remove the final part of the description that refers to
  implementation details.

 .../bindings/input/touchscreen/fsl,imx6ul-tsc.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..1975f741cf3d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,20 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  touchscreen-glitch-threshold-ns:
+    description: |
+      Minimum duration in nanoseconds a signal must remain stable
+      to be considered valid.
+
+      Drivers must convert this value to IPG clock cycles and map
+      it to one of the four discrete thresholds exposed by the
+      TSC_DEBUG_MODE2 register:
+
+        0: 8191 IPG cycles
+        1: 4095 IPG cycles
+        2: 2047 IPG cycles
+        3: 1023 IPG cycles
+
 required:
   - compatible
   - reg
-- 
2.43.0


