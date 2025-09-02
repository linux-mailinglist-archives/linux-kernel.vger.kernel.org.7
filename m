Return-Path: <linux-kernel+bounces-797139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753EB40C58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F3C564909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D434574B;
	Tue,  2 Sep 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWNm72vQ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026C322C94
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835081; cv=none; b=Tl8OYh5w91BvHbnSmP1jkGXYTyv8VDjkskkhd1qLMI0pMaHTJwRyVRQVKdkvoYJgxKXEBg5ZTjOSTT2SoZl3HLTNh6VLmrKPc84iklNCRB5Jciju3QIjxqOWApUyAsR38A75+D4GpfZUu5spsJv69LAbUJy248Dus5twhq4PNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835081; c=relaxed/simple;
	bh=BdSiKF9n+eeUAE53HFjfWgvtvo0CoweAVbKX7PsygsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CokB532NbDTQGWG5qSekgX69gesj7BqiRghe/+R9SIssC8gTTfG8ROVS2uobSl8+FNc5tjknrjPHAaLv63cDOLhPqbD+Ub6aPr6fJ8/a2EF48/vEgTqb53+pZTL2RXMGlVRMkCpIKhVYf2kUc1P98R9Nc2czm+EQITlBmch0OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWNm72vQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b30d09dab5so60796221cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756835077; x=1757439877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mw2O9IyBVINEqUK0JHnLd+CikD2F9nmgloYlgwO8Xk=;
        b=UWNm72vQNYs7X+YPDrLDqnvGcU0E+U8dnZnthV+HQx+p8O8Kp3KNc9Qjd9y52bZX8G
         vadsu57e2rrGLdzuSiulkvvSyFzy28b1UpNv/Z60GgDdqCrY4rMcnsuyX19Dslt6y/3K
         +vPdRmalidlzNSYYv2zAWdisft+b2K3jXz+/YeiYclKGtaLHuCyrGQ/9r5W9WfLgnL9I
         2q4hOK8KPEuRJId8dYDTNG1CW5Oza3Qx9SCHY+1RSY0Tdy+NTxAV4Ek1wC6QGiaMvtTd
         1jPNauY7Off+IS5Du2qf9xI8m7SXO3p4H+58mHFo3YxSctEbhlhPb734z2hyURklC8My
         5AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835077; x=1757439877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mw2O9IyBVINEqUK0JHnLd+CikD2F9nmgloYlgwO8Xk=;
        b=V+9W8ZK282Pm7O7ww4YPBxin8URlCyRC/8Rnc0ccph35QpfzBOIT2YpDN2y02APrAO
         ujVRLaxUmq56fhTlHv55MtPB8asD1KtVj9wwZm/erhx7KIZSkJBCEAmNKD3l14vpLCHW
         ZwaCrKRWcrCLZnP3V4aZBdME4j0KEzNH2M+OQE8x80dGMGyI1gsSNPlAngbHlgrU1zMO
         Mwmx10mhK0AXZBgumQz5W5zL2RRJAgYiaKDD3besm5wwCIwObBcZlNQTTEijRTZOBZWD
         wEyHHXO4j+qjehJ1/tvNjiCPyi3fTVu+rBKjjUZpknmLKfOLJLLg51W9X7VlffSvcGvl
         KoTg==
X-Forwarded-Encrypted: i=1; AJvYcCUHF+CnsqT0sEv+8uf0fmySO3d2u8V/1n8EWSGuFwXFbZvj9GB7667IAmY3AnEcQ+o/W+86bgnD1mRDMoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszteuIR6r62R/Ugf+MZgwWqkgi/wN/X+yqxcvwzwHi+tfsH0h
	cegO9QOwDt4DTHPAlwn0/fAxwSa3B7kQ+w9AADF/npt7DuUi5sd9mWG1UDeBODXvQ3Q=
X-Gm-Gg: ASbGnctXaFhoC6iH7ua6TN8mkFkNzFgV7tKzPA2bq71uu0ZVGkS07703jXhOJjLBxWu
	yn3hwDHuHt9KLXRGgWb42qz7NY0OH8btlkDQyLC6sZl5DBAvQQ3ZDfiVG3byNyYQ2ROJ+z5ZdRY
	rUuE7E1swGvwgcF5CmmZmIDuXMEXf1cmVv0y/cH3qtFHfHY2UTc95TXRCdwUsvZwCDtLitKYx5M
	iyY/KXwKUgTHAZt5a+VOXuKbK/bGsgycyiGbl55fksLSm2X5Ez2MMOZxFNRPmJSJd4JU2WnW99z
	2MdXnt0JLpTHUpPlcI89CIWzBiRlR3Fv6LhFNdcFh4H98IFnxrsjIWs+/H6KQftISe/5Doqdr6z
	oCqsRciCIf4RvdZazH3wDHPXZMm3Vw7WQz9CpbafTPZudcDcWbzJMO5Or3OF5uD7IGaDp/PcuJ1
	+iaQ5qkHmrS65tpBpy1RS3
X-Google-Smtp-Source: AGHT+IFyf4Ivig73sOQhD71vsZ3IHMgCorpcKXWlE+x2Lg1DUGxucTOJYhdeLvnLQSIj/vNApEFeaA==
X-Received: by 2002:a05:622a:4ccc:b0:4b3:4cf6:f666 with SMTP id d75a77b69052e-4b34cf6f7c9mr32859441cf.11.1756835077394;
        Tue, 02 Sep 2025 10:44:37 -0700 (PDT)
Received: from ubuntu.localdomain (174-138-218-227.cpe.distributel.net. [174.138.218.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462c9621sm15095631cf.24.2025.09.02.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:44:35 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: linux-doc@vger.kernel.org,
	devicetree-spec@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ilias.apalodimas@linaro.org,
	Raymond Mao <raymond.mao@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: devicetree: overlay-notes: recommend top-level compatible in DTSO
Date: Tue,  2 Sep 2025 10:43:50 -0700
Message-Id: <20250902174351.2457022-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When managing multiple base device trees and overlays in a structured
way (e.g. bundled in firmware or tools), it is helpful to identify the
intended target base DT for each overlay, which can be done via a
top-level compatible string in the overlay.

This provides a way to identify which overlays should be applied once the
DT is selected for the case when a device have a common firmware binary
which only differs on the DT and overlays.

This patch updates the document with a note and example for this
practice.
For more information on this firmware requirement, please see [1].

[1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Updated commit message.

 Documentation/devicetree/overlay-notes.rst | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index 35e79242af9a..30b142d1b2ee 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -103,6 +103,34 @@ The above bar.dtso example modified to use target path syntax is::
     ---- bar.dtso --------------------------------------------------------------
 
 
+Overlay identification
+----------------------
+
+When managing overlays dynamically or bundling multiple base device trees
+and overlays in a single system (e.g., in firmware, initramfs, or user-space
+tools), it becomes important to associate each overlay with its intended
+target base DT.
+
+To support this, overlays should include the top-level compatible string
+from its base DT.
+This enables higher-level software or firmware to identify which base DT
+an overlay is compatible with and apply it accordingly.
+
+Example usage::
+
+    ---- bar.dtso - overlay with top-level compatible string -------------------
+	/dts-v1/;
+	/plugin/;
+	compatible = "corp,foo";
+
+	...
+    ---- bar.dtso --------------------------------------------------------------
+
+This top-level compatible string is not required by the kernel overlay
+mechanism itself, but it is strongly recommended for managing overlays in
+scalable systems.
+
+
 Overlay in-kernel API
 --------------------------------
 
-- 
2.25.1


