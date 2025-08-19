Return-Path: <linux-kernel+bounces-775239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C4B2BD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF4E188AB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916731E0F8;
	Tue, 19 Aug 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sDL2Hq9P"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A031B135;
	Tue, 19 Aug 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595120; cv=none; b=ri+KAKbqC+WNW4/+JfTz5m183+Hg7sisAMj27d29gf3U0JZV5KVLwJVsfO1jfLLl+NFb86M6ftl0jQsUlEPT2uMoZNKRa1y9OGoyGKzer8rHUcefSEL8Krgt5hAUl0ObYGavAE89TrGYE1RSJYjbOIh4L/UyB4XtG+8pAwR6vDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595120; c=relaxed/simple;
	bh=ygiXI4RxBu+iQFfYfZV9nYcYMqhGDx98QLPdxbvjPt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qJdP6cDi4/vC92qwp3oNJ4N3GqDa3c6nzs5NxQWVI8viUygpb5V2cClLk5a2fvCxqa2YExyBmoavoR6+T1riXg8az8OAdoAbt+c3JD1MjDd0Bxd+xk2m2O4a5mht/SKml/GGhcpPkbWOdjvqtPggvCF5gSVVykhSk0YtIrCJGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sDL2Hq9P; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8mVwW006539;
	Tue, 19 Aug 2025 11:18:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HOLkOxh3NUb5BnUIjwpE62BqrGkBGy2RFZaS/ppVfto=; b=sDL2Hq9Pcq2/Xudd
	yJGy/beNiAFtIXMG6TI68q9Y+CcuZPCjH+sf3Oju1y/699qcp4ZvQ+2VIxb8KCRI
	n8i4W1eA18u4lsA5KF/0g4eUXUuWfpU+svQ465mOcozZ3goRbAa7Ap2cfGurcfJ2
	HeD9XtxZKOowCPePHZDgIacfRx8yepYGdGa0D1UUNl4LWHgiTfSXN1biFkZY0F0J
	WlcW0qZQEtvnC3PS+pQqKTogZzKJ6DmICJcPxZ3fIZYdEHYsNIhC/oLPMEiZEfsr
	/fsIZPM1C19J9xRBr3KSFpEfxV65iB40uPTKj4bZx580wgwtKVpcXoa2MX8y1poY
	Mff6aA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48k4xmqwkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:18:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6B8544004D;
	Tue, 19 Aug 2025 11:16:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EC1F71764D;
	Tue, 19 Aug 2025 11:15:58 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 11:15:57 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Tue, 19 Aug 2025 11:15:55 +0200
Subject: [PATCH v3 02/13] dt-bindings: display: st,stm32-ltdc: add
 access-controllers property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250819-drm-misc-next-v3-2-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01

access-controllers is an optional property that allows a peripheral to
refer to one or more domain access controller(s).

This property is added when the peripheral is under the STM32 firewall
controller.  It allows an accurate representation of the hardware, where
the peripheral is connected to a firewall bus.  The firewall can then check
the peripheral accesses before allowing its device to probe.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index 4a227799717637df882170ec08c0a8e88ac430ab..d432983a8b20b6e482b411ad0254884d92848d8c 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -40,6 +40,9 @@ properties:
   resets:
     maxItems: 1
 
+  access-controllers:
+    maxItems: 1
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: |

-- 
2.25.1


