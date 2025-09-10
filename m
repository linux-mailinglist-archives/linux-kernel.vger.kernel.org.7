Return-Path: <linux-kernel+bounces-810311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31971B5189F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBB2563F75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F915322A08;
	Wed, 10 Sep 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FGr4p1mP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7A32252E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512765; cv=none; b=eZEsQkX2Ty4+y0+TsWeEJHcdwBd1C61oKYOcp4CsQ96b7CBP8NU1j4ujrOpBPRhnOZK+5BB79Wk4RZVllDZNuwZW3bYB6HZXGjGuSxiTU9YQrbJ23PmHAoF9KCel8d+3N1fzleumuE/LglLo6qPs059mrt6hJILM2XlTvs1ad2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512765; c=relaxed/simple;
	bh=6DM9dMZAtcwlDKvhQvsmdFJDn+355Evyd4COdeLDukI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGEtNwCTRttRS7gpI8ZXCBsoNpTL0uHxFM/bwSO72+jWqyrlYveTH+1L/Ml4r7p37NmhgddaWVhwaZt1N02SbUnDYsdqE/g9a86cmiE1FwQC9HUh6ftAaPgREsMlItJbKiIVLathUMyvYoy8rrV1205M2buh3DeS38CG10q1Qco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=FGr4p1mP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1133690166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757512762; x=1758117562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtY6xQODciaFQXT13QEjMt2xFfxEtt0WYueluTMBhAE=;
        b=FGr4p1mPt3o3KMsqm8t8Vr0lNxxODvzir+BfjRbAffjFFbeZcxFSGZofGT+rqfR8ct
         hunTWYBhA2tI7hulGU4SAIUjlqnDWJgv2uOsE+dqfH3stDacSnRPz2qIDTRi6T/0vsi9
         9rUgJiztKDYtwq6tWB9ByfQmpv+vi6Cq7ZQRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512762; x=1758117562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtY6xQODciaFQXT13QEjMt2xFfxEtt0WYueluTMBhAE=;
        b=ryTE4zTYKUaMNLQU8ebmJdemRpveCLIrLhmNy+sjCawKHWCuhGPtqOu3yuatwSNLiU
         ETzY7GDm6cO5XAFz/LlSRWxpoCe08cUpu43MtIZtLYDCTSTsMAUCeambBAHhJBqSxLra
         w/v4jrO2yrrWPpwaGW8xLO2hnLprMWBhNZZu8xwwGYXEWqJN2F4jSa+6cFr1YTvO5GOW
         mLIpjjc+twXhI1+nUxFTHzHqp0Nn19nU7ScHokNASNFylFSQsQ8O85p6wWrzNVa9hfdJ
         WquExTzjWRpCtFUcw0ZPcYG8uUkmHLd2vmM55UlbhsRL6sAVXpbLqx9Nw3lT9fusJlJ3
         kHhQ==
X-Gm-Message-State: AOJu0YzdsOij1tuq44RRgdAW7Hh2Kf/pdMtkO296KMuRf6W7wLyBXZN6
	MYYsbF7gDelnVfl7OezaUfgNP84tD4u+t5c78dk17oCnK4FlTu9DyFS1qv8B9fBV3p7aMykzOnu
	jevRq
X-Gm-Gg: ASbGncvaO9HTY128eIExDJeVl6k/vQfbtqXmGXnwxKkSRmgJ0XsNz0OTgVJOWlLqMQU
	o02F8kREfcDVrxpzXwDz1gk4x7Pqi/RethgjWvknh/LRa0yhrnJe8vHyIsfHyk+XxgXSy1/5UjY
	jhHllfnWHLWjW2XUGLFEZ6MEksAvbdslbv0PCExJ3TLdf2cr4RhmWGM1Uek89eWEgnpCws9NfRQ
	BLFG+eBTrWafPSrffbMPO9ylsFJkR7h5kq+e3YfHslspray8xH9XmoYRVvGvBr241lrW6+OhcTY
	CP24Pfb3+4yY8APVlfixgC1c6SLggv7xbIJm/q5UTBML3GD3rwnSI2U4BNdMRmfGtiysQRyh8hc
	d3WVLU7Fdjwop2JEIWglGV4EkZqgUSEUkUOjh+Mxnw+pUye0KQyKXQgTvLCZOnvgQKjipGv6kmT
	hzjjDi4IDwY+Nfl3QWZjY2mOQdOhrB2n06LUauqPCgMoAEuWHXUIuA21zRR/lLyrla
X-Google-Smtp-Source: AGHT+IEwFKbwXQOp9vR5RWBfca+LwdgNqWC2NlCsLiPo9Z3IGD4hXe/SLsqdKeNLsPpGK5bn7AW6lQ==
X-Received: by 2002:a17:907:d91:b0:b04:626e:f43d with SMTP id a640c23a62f3a-b04b167b9f2mr1190384166b.47.1757512761817;
        Wed, 10 Sep 2025 06:59:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833a4e37sm172523066b.76.2025.09.10.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:59:21 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
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
Subject: [RESEND PATCH 2/4] dt-bindings: input: touchscreen: fsl,imx6ul-tsc: add fsl,glitch-threshold
Date: Wed, 10 Sep 2025 15:58:36 +0200
Message-ID: <20250910135916.3939502-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910135916.3939502-1-dario.binacchi@amarulasolutions.com>
References: <20250910135916.3939502-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for glitch threshold configuration. A detected signal is valid
only if it lasts longer than the set threshold; otherwise, it is regarded
as a glitch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../input/touchscreen/fsl,imx6ul-tsc.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..2fee2940213f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,23 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  fsl,glitch-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      Indicates the glitch threshold. The threshold is defined by number
+      of clock cycles. A detect signal is only valid if it is exist longer
+      than threshold; otherwise, it is regarded as a glitch.
+      0: Normal function: 8191 clock cycles
+         Low power mode: 9 clock cycles
+      1: Normal function: 4095 clock cycles
+         Low power mode: 7 clock cycles
+      2: Normal function: 2047 clock cycles
+         Low power mode: 5 clock cycles
+      3: Normal function: 1023 clock cycles
+         Low power mode: 3 clock cycles
+
 required:
   - compatible
   - reg
@@ -94,4 +111,5 @@ examples:
         measure-delay-time = <0xfff>;
         pre-charge-time = <0xffff>;
         touchscreen-average-samples = <32>;
+        fsl,glitch-threshold = <2>;
     };
-- 
2.43.0


