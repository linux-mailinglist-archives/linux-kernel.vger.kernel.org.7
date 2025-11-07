Return-Path: <linux-kernel+bounces-890229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E43C3F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEEF14EFA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661F305E09;
	Fri,  7 Nov 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipfe5PL6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ihM4IUXQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AE25D208
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512312; cv=none; b=f2JGfv6eQKpR75mJEK1bV7g8r0rxJKjq6CN2xtFbS4kyld1Oo20VcmS7t05fuozdD1bX1ju5xfZoJm8E2YBxqwK04fqYj02y6cD43/E82Iqx8jcq05WqiT74RXuU22BaBv8T6U3XBxvHBXZriEIxIhGSsN7mX279sItoI+fjMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512312; c=relaxed/simple;
	bh=cldVxJpRNKgcFoYyGi5TZxiwhzfN4EJKPJL34klWTCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0nbAtBmdAj5QACmpjXKfOxLuMjDCTuReLZSypFXNlBnQTgId9FYo95ST6Yf0PHCI3ihQ2Gp478G6AmMqIPbxJV0szwjTbtmgDo+/KWzNOguO/OMAXy0MtFIyfOBKG8IHoeCe/0DNvhLlawBwNMLKirCLBLSP5SHHDDji+Up/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipfe5PL6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ihM4IUXQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A73MwLi1864955
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwr
	q4S+rbnQ=; b=ipfe5PL6a6URkUKf47E+fnN8OJTeFFpPmO/56E5fGfl/Z/LIWPA
	lw6qMCHtDTx6QUB24WoH2ZAC0mU4pKVutO9ZpHmUai+t99OUP2h6BUozLojhz0Hj
	/e63Ysz3kAGX76R5XwMdfgnUZ5X7iXcRivTEQv9IBSU4y9kHHjhvmLAF6z7lImDh
	VXEMBOiicE7urIDLTc6EYoYxCuPikzQqZso73+7PhJGHq29J/x+Lz1bda7GjFrrL
	DA0e2HlSMA9mbxjqcTgjZnIJ6WNd3d3IyHSwO51xRapsyZipFmm0ZLto97E9Cr6E
	Ib9dfW+7yNmAtwywZrSZ4TQJzd1gq/xTjtQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a98ta173x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:45:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34188ba5990so1437046a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762512307; x=1763117107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwrq4S+rbnQ=;
        b=ihM4IUXQLx0fBQ7xi76wwlAtq0sa9LsEAn5mpQeYoVFr7w7jdtQkwc2qyadcGSKKuM
         vRtmteFEcUh3tPyar6QIK8PNO/4Nriwa7xq9JZJrh85YKrrSZ7vOMuWGQ3/827sI6Gr8
         eyVjamA8HGoGp8YvkyID6QpBirhOVnxWYBeso83E1rSN6WNYLVZCdVCvtmS0hT1yNk+9
         Eae68zlOnpkOKf9Zam12Rd/ptlGi3W2ZGqpREZesChJXJXFkBIlVaY9NS10rG6wSnTMb
         /JNy8nQQPMKLDdwexV+zqTn2Ks8xjVehxE1MjDHgdds6hy4bZ76h7xB/5eTx05Uh9YYZ
         7gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512307; x=1763117107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwrq4S+rbnQ=;
        b=TCNTrpjm0Y2j3MRCLHpMMBBD46ma+1zdhhdH30yMjalD6lmxp8NmCllopWOMBcIE7A
         XzTKG5PzeFapyWbbEaN02dvFNV3x9YfVUeQjJB4l9Z/pvN2QvYXQ0Vg399QX02+BkCDN
         iEzCAFWNSGMNDZute2TKU3P3tS7Q+lw/FuPNEV88dApJ0OvbJXr+kSgtjOxLqHK/KDo6
         KM311yMvxUfbbF8/ZRqJrirE5M1OeCTcdi5ktoLwKneUF1jUL8uxqyhIzO6d8zqrmzyZ
         9lFyRjCOWhBgz17MRYHssqeMrnS67QJwUwGvG0FlWyeuFM7J5IPz6trBOdZQQHlmkFaX
         ROZA==
X-Forwarded-Encrypted: i=1; AJvYcCXowMp1zBBaUCmtQBvZ0Q3zFM5QydutbrfC5lB/IEeuitAEadhXYyKZn0xCQQpicL3BgpO7LwraemFjmwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5c+7RjmziI5l5G9n0paABbXwNXd6jePnElJZ2UV/Hh4jKoh+8
	DdRJE07txYC3JEYWSnAuVqtpRajjcJidHE7EGHsAKg4kebAR5Oz003FXmJRsDMpGNQQG3+me3UO
	6vEYjAcVXg6/Ba6JvTGmH9i16Ohg24kjbOwHUlxlvIDjvAdOilKlsJ0SvKr9V7irF8n0=
X-Gm-Gg: ASbGncvpgQXy0LriX9BPKr0Mpwq41vIfZsmqzILT9DmRKjme7gLvy/YIzWTgSTrJtb8
	5lIbEQUMVv5UNUpGiDlHcoe25EPrhxELUKT8vp9hmF0Cr5sOMwd/wRGgp4fVL1oDZ2h/e2B9+Fn
	hv+CXNsf1ViqVo64xPvB3OySD81l4O3uRml03LTJwzmBrjNaFxp3ccj8TvbK2u5Bw4esS/dT4pa
	qUHziHvm899k0zBTWS9Zd7LAweFg12p4oyS4a77LUKUyXV5YJj0orS+ApJZUFQY7jN1GDCJocfl
	hdgJm+pjpflfXDhEhPUUMVILhgfof+MxIsvVz1usCdQgdVfTIS9WepF+ae6P5vaVMvxc0253M+P
	ysMkC8VOQnRmep/jsXzgi/uFtMlIGEl0YjrX2SGwTLWjd7ldso3Dt
X-Received: by 2002:a17:90b:2b43:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-3434c59666cmr3200926a91.36.1762512307543;
        Fri, 07 Nov 2025 02:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLIPMfoRBFdSkLK6MSwRI0bu0MIuKCQtHo+cC8zhSDBXAl4TEpY+PzJ0TgjkcmFqBio+utwA==
X-Received: by 2002:a17:90b:2b43:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-3434c59666cmr3200902a91.36.1762512307083;
        Fri, 07 Nov 2025 02:45:07 -0800 (PST)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08b69e5sm2137711a91.0.2025.11.07.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:45:06 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: gregkh@linuxfoundation.org
Cc: Jamie Iles <jamie.iles@oss.qualcomm.com>, Thinh.Nguyen@synopsys.com,
        fabioaiuto83@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH v2] drivers/usb/dwc3: fix PCI parent check
Date: Fri,  7 Nov 2025 10:44:37 +0000
Message-Id: <20251107104437.1602509-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NiBTYWx0ZWRfX5BBytNMiArOb
 ynoI61LgW9N6YO2uKxtdAyOvMBsm1Fm6xLgLsAFenDwTXDKlBMxaCSLmx7snGwvszVFr5uLBbkB
 GrlqdqHTEeOIL6xSASNMKeYD72eMinBgItNNdZkKoazAqoLdA1Lc/TTQGGdFx8n/RJbngJ0+nQc
 7ZD3Cj8hXtvFUOb/kJlhDkMb9ryxty+H1gcp8x8RdS0WK5WsaQjpNMa1aVmW+1PKv+aSSQoG8DZ
 nmjyCz9F0Y4SWC8opfMe7h7IxkvZrIYom3QbbtD+Ytgf2r/D1knHH5sKu5dz7hAsLHhLqN8BHka
 4tlJZG9PdobYodgpdU8mZCYz44PZ0PjwPRP4T1hN9rAQ3Y1bIKDWJsqtHmJv43TQkfG0XW5wEoO
 5mThhSkUSQqRzhK4yIFcaA+A6qyDrA==
X-Proofpoint-ORIG-GUID: PGY_Anz3mEfBGy5dHiac7YDPRrOflank
X-Proofpoint-GUID: PGY_Anz3mEfBGy5dHiac7YDPRrOflank
X-Authority-Analysis: v=2.4 cv=G9IR0tk5 c=1 sm=1 tr=0 ts=690dcdb4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=jM0-4Wpw8WwY0CpfOG8A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070086

From: Jamie Iles <jamie.iles@oss.qualcomm.com>

The sysdev_is_parent check was being used to infer PCI devices that have
the DMA mask set from the PCI capabilities, but sysdev_is_parent is also
used for non-PCI ACPI devices in which case the DMA mask would be the
bus default or as set by the _DMA method.

Without this fix the DMA mask would default to 32-bits and so allocation
would fail if there was no DRAM below 4GB.

Fixes: 47ce45906ca9 ("usb: dwc3: leave default DMA for PCI devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
v1[0] -> v2:
* Added tags
* Cc stable

[0] https://lore.kernel.org/all/20251105145801.485371-1-punit.agrawal@oss.qualcomm.com/

 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ae140c356295..c2ce2f5e60a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
@@ -2241,7 +2242,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
+	if (!dev_is_pci(dwc->sysdev) &&
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
-- 
2.34.1


