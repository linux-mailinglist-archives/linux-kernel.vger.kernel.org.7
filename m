Return-Path: <linux-kernel+bounces-742379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0AB0F0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE23AC0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EE62DC347;
	Wed, 23 Jul 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROB5W2Ny"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433528F531
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269100; cv=none; b=isr2NpAsZ4wuV4SY6f822iDF3GKYiQmqT23GuqdcX5ud+/hHPSOj0zSTK/CNScEOpnZtm29tbENJrauTZ7xoZDbr1b3ny1uRUYIId8kZ6jjN2jgeahj3dG0PTj3SdCYo5z03SfHgsreqWwVBH5aNwz6tVqK+RBtATWAp2O2u+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269100; c=relaxed/simple;
	bh=hCquMW8hz+iGzu9b5ro7FBBb12naHRGKWpeOqXGXr+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=de5JJk/ZCYUTREVasHKJdEXtSssHt7dRJWy6KrVCmLKdfucI8mQ5uBrUvUeJo3evKgcqSAKZAkdqSQoXBZZe5HkO1PLm2ajOsoA4zW0gZyMymyS79sztt9yzyJUroTAiA6m5udrCrdlEfiRwPcb5fQvMk+ZZ8W5P+jQQ49aDBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROB5W2Ny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9QnBr025715
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LjfOncO1vv2+YN0yh1RQX1suHT8F+x0/La6
	1z5ZuOPs=; b=ROB5W2NyRYVBz0VN44Oavxo+AXMs9X1Hi6gLpmZO0qDBjtGP020
	sop6q57ZlOcEgb4GO/UKjXpO2fS8UsqUdyNaEcP29HRjCI/lKaATMMuJ2G11ajHx
	XHoEs+U5Xq/57VBXycXYdFzIfyIe90rEp+oA6eNo/kj6wdtY9l4E4YH2sh9JlhEJ
	bLtXVyDDTe0Ll0YjoB5YV/AbK6+FcmIuPGf9l8lt96YAQKjyuPLZCRYMt258vhmn
	y+eXmAbKCNAenUVnI8PMAswfPQU4Y9McQ/V1xTQ34JYb8gToKS2pRGGFCfXATk/q
	NdkBa/K1P2aNbejyYFYJl1uwV0AkMGQKenw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ubf6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:11:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74d15d90cdbso5667549b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269096; x=1753873896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjfOncO1vv2+YN0yh1RQX1suHT8F+x0/La61z5ZuOPs=;
        b=CUrSvnJn6+GXb52JWysnc1OWqHuHCM6MyNkbigJBUHPFGf8Ci4SBSiWzOZmA1/GCVj
         xmW0tORQDMSC68BY+AHRL2N87bPCKdivN49DWxRYCCFGD3uT8tVLz8ukwA/RzC7dTvfW
         95ulXnRJ4jBuMevNGlg9c7ajcK2YYhLMEur+GWNaOUKlNs7J5zbF1Uen+ejuaq0PvYc5
         6aTQYxpqSXhxuG6YLvsoGRaGtq7WnRxx1sCOZwvLnhfLkJEvDC9X8uzNTVyc+sXmyjRD
         LfmqfTl7MpyW663fNTWvT8D4+YyIgejdpLzt4saHSUrnngmgkb60NvuHpzcLU2kZbRwk
         p0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUD8HjWl7d3BY3nenku4G3jU0Dh3PtwjMk/ZTTqdB9RfRg/39ZltiOVOqsgyDSHlVzswOzBJQ3dkw7OlOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cCEfAItcgfFU7pdaIjVd4hPlIM0WV4S2AlRRYXwoLW9c4syp
	ItMSeFILJFe3qjcgnzszsrc+9ZAmpGhbbqRoExZO79mensKGbZfaHFNuCXLGJOo1Q+n6Gez7JsD
	z8tUIF6K5sSCRwqvq1CI6KbxT/FJNycL+MTA9adBm+sOw+WCBfmzuBZHlNHPGgalxKmM=
X-Gm-Gg: ASbGnctaMwzGRqzRd7r6QWmyYEl1hkCMavMMft9VDs1dMOMU1hJACm23RzoZQpqLyAp
	i4qLM7wZBL+xzRkaGy//nHFAzNTiuHSbJeskED748L7Wk/7GJCKqzYkkzhpHbAuACr5uahsIzTC
	NYTnQ0oPh5DTsRLWzqg7EnkGbN6M8lM0N4MMb+tG0YO8weLyS2PRAlwZauzto8TzGTzun1n5Ucu
	Hs4HbkNiTH3galuqKtrKlIrQbcrA1Yv7BFlnSRx0BQKD3rcnMtcVM0ACW88yZGADtNFYKaLZVaa
	ksKz/fwt3J9Vpy+1ohjZGqqu2M2MS3w/jIIBPmD3X3KuqiuR/k+DLBI=
X-Received: by 2002:a05:6a20:1584:b0:220:e5e:5909 with SMTP id adf61e73a8af0-23d4906e5d7mr4082929637.20.1753269096491;
        Wed, 23 Jul 2025 04:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3QrEmtBPfOc+uqORMvCzZ0j+Ls2REYh19xcaNQaRKIguYCvkAOkdIMlzRkqSP0UAb/qhgg==
X-Received: by 2002:a05:6a20:1584:b0:220:e5e:5909 with SMTP id adf61e73a8af0-23d4906e5d7mr4082892637.20.1753269096075;
        Wed, 23 Jul 2025 04:11:36 -0700 (PDT)
Received: from work.. ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519f69ddsm1431836a91.11.2025.07.23.04.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:11:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Shuan He <heshuan@bytedance.com>
Subject: [PATCH] PCI: Remove redudant calls to pci_create_sysfs_dev_files() and pci_proc_attach_device()
Date: Wed, 23 Jul 2025 16:41:24 +0530
Message-ID: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880c369 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8
 a=vtPyk3adPmH_jGOTQ7gA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX3HdxyerK3dkw
 ryzh4qVxpVgWDSxWYhvMOcAZRNbn/IrV3EHdkF7JgVt0AQpojX7HnENq0dRC++ubDTYkk2Ws8do
 XXISYhmMM8gzWtNJHhhdTxTi4DEOJtup87IuLww2/KhQMPmgPlWVvwcXLCqNfEy0S+kY0wngMRL
 yYFso6g9VrvLTzJzwvwqv0LP76pEorPXwFuy5iN4dPQuiej34934zoWfskwetlV4opTQ9PbwmW5
 hTvuQ+/5yFLnxFRnT0CkXKt+VIhwCd/L8Hlc2+KnB80wYxXKpJ57vpiTkqJrOOCd1oEh8Ih16HR
 4IcQtZuKMVxjVqHrQ5eTT0hqFDDSqw00/zdb1A620q/dqRU/Bo8zaQztUca46dz+gZNAGW3vp6u
 xPUUKJn0H1tWslDpQOaV9MdB2IKpYHmhOCvBZLCzjexUItMKS5EfJ2AjrqxuCbwmwxDMALrC
X-Proofpoint-ORIG-GUID: tHDFOwcap0E8E2ztCRWG8tMpMr-YYt8s
X-Proofpoint-GUID: tHDFOwcap0E8E2ztCRWG8tMpMr-YYt8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=766 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

Both pci_create_sysfs_dev_files() and pci_proc_attach_device() are called
from pci_bus_add_device(). Calling these APIs from other places is prone to
a race condition as nothing prevents the callers from racing against
each other.

Moreover, the proper place to create SYSFS and PROCFS entries is during
the 'pci_dev' creation. So there is no real need to call these APIs
elsewhere.

Hence, remove the calls from pci_sysfs_init() and pci_proc_init().

Reported-by: Shuan He <heshuan@bytedance.com>
Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci-sysfs.c | 9 ---------
 drivers/pci/proc.c      | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..8e712c14e6ea 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1676,18 +1676,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 static int __init pci_sysfs_init(void)
 {
-	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
-	int retval;
 
 	sysfs_initialized = 1;
-	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
-		if (retval) {
-			pci_dev_put(pdev);
-			return retval;
-		}
-	}
 
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..b78286afe18e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -463,13 +463,10 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 
 static int __init pci_proc_init(void)
 {
-	struct pci_dev *dev = NULL;
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
 		    &proc_bus_pci_devices_op);
 	proc_initialized = 1;
-	for_each_pci_dev(dev)
-		pci_proc_attach_device(dev);
 
 	return 0;
 }
-- 
2.45.2


