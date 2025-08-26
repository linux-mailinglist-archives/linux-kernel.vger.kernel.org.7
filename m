Return-Path: <linux-kernel+bounces-786583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFFB35E75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5584F3AA25F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C062FE58A;
	Tue, 26 Aug 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iwW+Zxdm"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943B1B6CE9;
	Tue, 26 Aug 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209470; cv=none; b=lXc7U0ASYYdbdoiGowmLC4nHC2frjm8kJZFUGBQfrsB4TuEA5vb+O/F6VX6RvmlIyDGEvhHZC3SsSv/MieiNtpwqfN5taOV6Yfbey1baQ21a//ycOYkYhWFfDBI+ar3Z2v8FkFYHSfdC2+xKLfY4SDLG5Yqw0fSjrDyNiqWq9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209470; c=relaxed/simple;
	bh=OrggidM+LK7nnvAKbTP0fEjnhNKfzuF+kkOf9+kmCaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AF4v76bb+ty6CEORVRtZTP/pdnni9O6LEslZjlYhC8k2XjUq/d1RDHzx5XnxCk0FVhmYpFJk1B4ThRN2P/0+culVMFcLUWO6BNRFZ+MLrVFIWE5kkAMsjw/482FTfu3HrLyspUfTJ3hpS1i7+DNoU/dI7/WTDCh98QKdjogliBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iwW+Zxdm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QAh1cg003615;
	Tue, 26 Aug 2025 13:57:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=DPoFd6YrsP1taRoO8mNWFQ
	0/gf5CfIZX1LZobHyFZWI=; b=iwW+ZxdmpvYkeWnR7/M1tbFbXFtCt2+cHk/XbT
	v6Pxnt1DynuR/IJHO1W/IMXmU3mlehUiSSjk8Q2BQpIDsg/kz9uSVQ0n4Al2jeAn
	GIoXrCsYpnGUC0H5/B8Fbd8N44eugP+UNzZN0JbNNnWklsNLpcw0USqR0ZZPgosy
	YJINTkXlk4+PlYdJv9KYDXVzN3UKza+KfmZDd4cNAyTgCl8jPXsQu44TxUF+a0zn
	7KmiuEbguTGAZ7raoVWH0OlC3Q2mPGjHF1YabHA1bQTgUP1UqmLDVd8LzdbAJg6r
	KJDQrHo/51AEfXsuZePkCKMIU890aZvZYK5dWZy6RT+MR78w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qrkmgmwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 13:57:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4DC6F40044;
	Tue, 26 Aug 2025 13:55:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE91D6C6463;
	Tue, 26 Aug 2025 13:54:59 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 13:54:59 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Tue, 26 Aug 2025 13:54:27 +0200
Subject: [PATCH] dt-bindings: panel: lvds: Append
 ampire,amp19201200b5tzqw-t03 in panel-lvds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250826-drm-misc-next-v1-1-980d0a0592b9@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAHKgrWgC/x3MQQqAIBBA0avIrBvQgaS6SrQQnWoWWmhEIN09a
 fkW/1conIULTKpC5luKHKnBdAr87tLGKKEZSFOvB7IYcsQoxWPi50IybO3IZJy20Joz8yrP/5u
 X9/0A7nlnUl8AAAA=
X-Change-ID: 20250826-drm-misc-next-21e669e21a06
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01

List Ampire AMP19201200B5TZQW-T03 in the LVDS panel enumeration.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index fcb5834f799a8afd00dbb6a053d206d689b3f932..f8f95e772778f54c1c3cb9975b4c0571654c817c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -41,6 +41,8 @@ properties:
       - enum:
           # Admatec 9904379 10.1" 1024x600 LVDS panel
           - admatec,9904379
+          # Ampire AMP19201200B5TZQW-T03 10.1" WUXGA (1920x1200) color TFT LCD panel
+          - ampire,amp19201200b5tzqw-t03
           - auo,b101ew05
           # AUO G084SN05 V9 8.4" 800x600 LVDS panel
           - auo,g084sn05

---
base-commit: 7399c13f619f33dc8bdce838f3c83e88a18765ee
change-id: 20250826-drm-misc-next-21e669e21a06

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


