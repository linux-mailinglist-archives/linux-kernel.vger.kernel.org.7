Return-Path: <linux-kernel+bounces-791445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1BB3B6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1DD1C28184
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171B3043AC;
	Fri, 29 Aug 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wxPPHdGZ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E62302767;
	Fri, 29 Aug 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458971; cv=none; b=I59YCYxAwQ+YfxxDJlAuHl7SeZyyCTGtaZuAG17weqra0SHeRpOlwoqs/fgnsOZvt6GmbIkrVPGhqmwmjrL1GJ+QcLiDiNSZ4n/PeQIWkajCCgDFAUXVrNzJ20Tfq34lpPirvZXhGgTNf2WdELCvgHtG+I/uUzNgJMNxUvubWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458971; c=relaxed/simple;
	bh=nrAuW1Dre8YYZruXiOjDQyeX2h7ccXr1JMgctezFHXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cmT/52yD5F2wThFLiE2A8IS52EwfmqrcS4AdfRyp++E/6NuAqaxYlMiiVcGiVk/KzNVMv2qrVTV/9OU+zXYwZWoJU/jyIavp63jdw4KfiVRSOUyRFi7fvD0EkQE4VH6QjSogva1PvCUMHsnWfGNK+bAmhNenLIuUBpopu3ir8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wxPPHdGZ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8wKLF020899;
	Fri, 29 Aug 2025 11:15:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Hw0EdPE3qQoSXFpnBVMg26
	9/A+GuHbRwyn9EvX4XOUg=; b=wxPPHdGZA0QWXX5o728xL/J/L5dYA1yiDhmvHK
	MZ/ZVbddZ7XNUiPo6jvWphJJo1OXxhr+UpQC7kAxSqxqPn1g6v0FMNhjB4DjHeAl
	Jv3ZpI3JgUTAm3656+UYZjzzBersWw0NoOL6qedmBXU9K+IPa0q3UTvsA0cB2TIM
	RD5GPQiky9VUGdVvvHvviar/iJTLhawxORik1YxBhuPuvn7SMJwjlM4VqUG+cCq/
	xuFSwW4Z5QwF5WCt0PscOa6BMYTtMIv9roasGK4hMEmVTbAPQzHhstH1tCWw+Lud
	gH0VsgyvWtVLqcTXVZ4sJA8RCU7k/kKy7D2SsKNC9SwnZoeg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5v0gr1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 11:15:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BFDC340046;
	Fri, 29 Aug 2025 11:14:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 41E5679CCAC;
	Fri, 29 Aug 2025 11:13:27 +0200 (CEST)
Received: from localhost (10.252.3.130) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 11:13:26 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 29 Aug 2025 11:13:25 +0200
Subject: [PATCH] dt-bindings: panel: lvds: Append edt,etml0700z8dha in
 panel-lvds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250829-drm-misc-next-v1-1-fedb48cf50dd@foss.st.com>
X-B4-Tracking: v=1; b=H4sIADRvsWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNL3ZSiXN3czOJk3bzUihJdE1OzVBNLA5MU06QkJaCegqLUtMwKsHn
 RsbW1APY9uyxfAAAA
X-Change-ID: 20250829-drm-misc-next-456e4904d5bb
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01

List EDT ETML0700Z8DHA in the LVDS panel enumeration.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index f8f95e772778f54c1c3cb9975b4c0571654c817c..4388d5375851a215f005dc38171dd7a307588b85 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -48,6 +48,8 @@ properties:
           - auo,g084sn05
           # Chunghwa Picture Tubes Ltd. 7" WXGA (800x1280) TFT LCD LVDS panel
           - chunghwa,claa070wp03xg
+          # EDT ETML0700Z8DHA 7.0" Full HD (1920x1080) color TFT LCD LVDS panel
+          - edt,etml0700z8dha
           # EDT ETML0700Z9NDHA 7.0" WSVGA (1024x600) color TFT LCD LVDS panel
           - edt,etml0700z9ndha
           # HannStar Display Corp. HSD101PWW2 10.1" WXGA (1280x800) LVDS panel

---
base-commit: b7243862f82a088d6fb7e22a25c7c024818e631d
change-id: 20250829-drm-misc-next-456e4904d5bb

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


