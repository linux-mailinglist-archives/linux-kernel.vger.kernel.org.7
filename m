Return-Path: <linux-kernel+bounces-828713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B7B95436
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91D616A9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124831DDBD;
	Tue, 23 Sep 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b="fDPR6fvq"
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FC2AD13;
	Tue, 23 Sep 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.160.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619956; cv=none; b=s2ydupOkhdc/6jLIa2c8xd+MP26Is95oRlCV5un9qbENyZFhfu6LEJwrrljYvwNK+gvvxUl+DgK8q1DdKB8B1Rz4MiEGdpdyP0+14rNSZnQRc4C8seCgTar3nEkuybLxdlNJXAI9/E2QFs91WMI9F/9YAERj1jiKnNOTFndUDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619956; c=relaxed/simple;
	bh=Az/ByjAipMqvp30wD9jBqkw4LL43yFsruNv1L2KkDAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iys54RQNunXBsVxXjX7h9mA1yiHGjs/k351AdqIh4KARdlj9+qQrfuvhT+7qdGYRdG6lwmwaOWLlMWm9ybe/Q8T3LBjK5PrdiSmjgDLLxolCfEzAnjsLEhXGpVRTWu6erWMC6t2W/yaZKgtz+iJ4BUUkrEw+FrSOXMoTPOzQJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com; spf=pass smtp.mailfrom=monolithicpower.com; dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b=fDPR6fvq; arc=none smtp.client-ip=205.220.160.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monolithicpower.com
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
	by mx0a-002bf204.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58N58bjh1331671;
	Tue, 23 Sep 2025 02:09:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	monolithicpower.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to; s=pps1; bh=2akKLQWH6Av85kaWHRMRJBBOb7p4u4LcQLiJB7Jm
	lxo=; b=fDPR6fvqbY2Dk8/NUFNqbStZ8l5ehbv5h3N//86BcWbKvaq0SWiV/aW5
	JDEA+P2nZwk4SKvaIj2Y3glIXo1TPK7MyKGr6CPMfoU0AJdmM3ovVorbNKxPmZAb
	XVA5t/18Vj6zWrVVtI6if+wDAPKjxSZ1fISCaZDnRB4K2ukmhdmJy/oH6GSu9NkT
	apXqCXe864mtpUOH/pm+3znvKGcH8T7ZzGQpf1jY3DYbd3FwwjuT2dbO4HkY+Yko
	B1zmES6jJeaoVTkjBAitIgYBGuxk1HlKN5i/zINX1kNTeJKfWCNMJUmMWHnaUrS8
	U3XNUfXbSWH+AeKw34WOsh9bIkna6Q==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
	by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 499qpnhh6q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 Sep 2025 02:09:52 -0700 (PDT)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 mps-mslbn03.monolithicpower.com (10.10.10.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 23 Sep 2025 02:09:44 -0700
Received: from HZ-200L-YUWANG.monolithicpower.com (10.10.86.73) by
 CD-MSH04.monolithicpower.com (10.10.70.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 23 Sep 2025 17:09:41 +0800
From: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
To: <Yuxi.Wang@monolithicpower.com>, <corbet@lwn.net>, <linux@roeck-us.net>,
        <jdelvare@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <wyx137120466@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add MPS mp5998
Date: Tue, 23 Sep 2025 17:09:24 +0800
Message-ID: <20250923090926.619-2-Yuxi.Wang@monolithicpower.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
References: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CD-MSLBN02.monolithicpower.com (192.168.86.32) To
 CD-MSH04.monolithicpower.com (10.10.70.213)
X-Proofpoint-GUID: DWL25t2_LzQUKXwj_X2C6-kWgv7QywWA
X-Authority-Analysis: v=2.4 cv=S8jZwJsP c=1 sm=1 tr=0 ts=68d263e1 cx=c_pps
 a=Zb4R73zfuCEKbQz3U9Wi8g==:117 a=Zb4R73zfuCEKbQz3U9Wi8g==:17
 a=Mn2HaNVs01YA:10 a=yJojWOMRYYMA:10 a=oOyOvuMWAAAA:8 a=jfe4B9wozX6hrU8P5YcA:9
 a=G8TaXjCCXnGpTNG3tzU6:22
X-Proofpoint-ORIG-GUID: DWL25t2_LzQUKXwj_X2C6-kWgv7QywWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA4NCBTYWx0ZWRfX6sbbyDiXQGJi
 Iev89xXQdjEkg5WniDPuJDCheMlihSv1TLZWK/tcLhGQGUCLEAnPF6XxAcTEktV4vTDgWe4K1k+
 KHOHqKjF+J/XUEVr4f+z3mQuEBSLRc7Hx+wntnIc1KhxgxJfrzby13BeADDd78a8t1ZFpSa7HYP
 /dgDs/QSuquhUbqj2GD8KFoh4hvt40WWkVxjSt7k87UPhdpMqM/PCHIeckmohcNuScGfnDd1FFo
 aNcORDNXYJPg88hJqoeC0Bf0nwQXWKY1eM2ZX3DmI0AOjr2MBuGrO/b/2yczPPaSfT00jEF8fMP
 xIc3/gUBxH7ZBI+JP97wwhJ+oVw+9l0CcJjA3CdBC9tgO6kJVcKFpQX8CUK36s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

Add support for MPS mp5998 controller

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..a8ec08182e97 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -305,6 +305,8 @@ properties:
           - mps,mp5920
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
           - mps,mp5990
+            # Monolithic Power Systems Inc. hot-swap controller mp5998
+          - mps,mp5998
             # Monolithic Power Systems Inc. digital step-down converter mp9941
           - mps,mp9941
             # Temperature sensor with integrated fan control
-- 
2.39.2


