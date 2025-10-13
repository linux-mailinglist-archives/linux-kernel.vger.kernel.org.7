Return-Path: <linux-kernel+bounces-849946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA2BD1674
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008423B4A01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6029E0ED;
	Mon, 13 Oct 2025 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="umhfsCFb"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB41DE4CD;
	Mon, 13 Oct 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760331710; cv=none; b=TIL0OOLirwN53L8WSvPG+kZKBkJyMKI1d2roA6Vqlkg24BlUSer2UGRJdd6oeeUb0Sbv2UADUBrkBpaUxvrEP37K4lCZx5MzEStso5ChFhbXNPU+PO1lcGTyy8A5Y0w9jqnnG6w5d7fNXPjsouUu2DrnnOhOpN2e9NVVuTssn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760331710; c=relaxed/simple;
	bh=4J5LGrq7OMGx1MNEdiPZF+G6fEqOe0YJph2v5MWv9bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dnrXRrSwPTOAmv+ouBXllxd+jW4+D7aNIAMiy0fsEfewJK4Tsx6/683s91Y2Sy8/yW4YzV1DETQmogLlfV/v0pt15+5CFCoL5VbtCGiJVEco+EotJMrUHRjcrFS4qcgwzXrl11fMECLxrXwHO1uMV2pBQrlYpZoALQRGWNtLPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=umhfsCFb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D1d1As008042;
	Mon, 13 Oct 2025 01:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5/1+zr3RO0xbMkR5qrMRJrxNkPm
	FSZTcYUeQ1bsYn8s=; b=umhfsCFbMLhd7vNVGBkD5t1zFyiWjJVi5+JgsyD4XFe
	EwkSIZ+SyRV2L8Y5PMvqtVCxwsXurIybsZpgZ/uZsSTG7loJygFFMsYI2Aqp7QWn
	nHBcGx/e3MSYYGo30BYrJZYka4BFl6RtMAv7v88la/Me1cILR/VPYxAlR8UWDBzE
	OP7OZZ+WU1rZ25qaanH2gJP2Bc/h8XT99Ur/FZao8xwYnkxZugM3yv8Vp4FTOJBY
	v3TEgtAsuJLMnZE7INxv0dYikOvWgDwt4PPxb+UnNioR4a6eNNJydMpMYZvCi4hG
	aVBq0x9iRZx7jF87ZSAMyHJQTu7m5lq9FC4/Hm6c5vQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49r5jc4cej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 01:01:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59D51IDt011641
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 01:01:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 01:01:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 01:01:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 01:01:18 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D510BW000974;
	Mon, 13 Oct 2025 01:01:06 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 13 Oct 2025 13:00:47 +0800
Subject: [PATCH] dt-bindings: hwmon: pmbus/max17616: Add SMBALERT interrupt
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-upstream-max17616-v1-1-0e15002479c3@analog.com>
X-B4-Tracking: v=1; b=H4sIAH6H7GgC/x3MQQ5AMBBA0as0s9akg5a4ilgUg1mgaRFJ07trL
 N/i/wiBPFOATkTw9HDg88jAQsC02WMlyXM2lKrUqLCStwuXJ7vL3b7YGDSyamw9tkq3RDPkznl
 a+P2f/ZDSB703DKpjAAAA
X-Change-ID: 20251013-upstream-max17616-37a4b8058eed
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760331661; l=1101;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=4J5LGrq7OMGx1MNEdiPZF+G6fEqOe0YJph2v5MWv9bk=;
 b=NZVKdZkRMfjrFAajEqYa9JkhhZsrhhqUmzLjytn1g6w9m9gOMa1QR2nZK/OTvlVggH9wJy8O3
 5j/kqZl8NcEB+fdbZruNW8gxeebNqglxVuSLunKl1TXPNAefWj1ou+1
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=OdqVzxTY c=1 sm=1 tr=0 ts=68ec87a0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=v_06EXNfVaksHon8OEUA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HrvflApiNByhf16ABWmA5XhAau0PKsGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDAyNSBTYWx0ZWRfXzt0BLb12fK1B
 Hy+aECSdxNq5hnsA228rbDPueJie2/g00NlX9PwXQbjX/i+b1kSWrHJ8nzzPi4Am2XvUEHvweNp
 WuSs8Y38UyGibfXwbbm+aVMwDu7ijjShCOyYRcYIEI//s8kKEtac7cbdMk6WPANkqetZQVS9Q+x
 k+jNCpDd4T9PTHY07waGEZwXHIz/EcXfKD8Pworo3uZHMOWJpOxqjwmwzn/yBfPBjGxAxTh88gs
 q7ifgWjzg5QAMs/v5Rk7+0zaEnrQSHm8+jLa3quvXjltZEXUm1i5V9IhTq/bcrUWMhajYqp/Xpz
 UF/1NgtCaEcrWTeERr307Jm4i/LqaHvafrg8nyF/x3aSeG34Vu262p1wPAa9xoyHm3uQtzf5riD
 iyWK+PZWNB6Fg00VboVF9GfgzWENPw==
X-Proofpoint-GUID: HrvflApiNByhf16ABWmA5XhAau0PKsGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120025

Add interrupt property to document the SMBALERT pin functionality for
fault condition signal.

Suggested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
index 4680d354af0ef706bbd90d2546f5f25149654b6c..fa48af81e083cbc69d17c01862f8f771eacf3332 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
@@ -26,6 +26,10 @@ properties:
 
   vcc-supply: true
 
+  interrupts:
+    description: Fault condition signal provided on SMBALERT pin.
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: 2a364c163c1fa9fe62c2f06e84fb7d2f995e461f
change-id: 20251013-upstream-max17616-37a4b8058eed

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


