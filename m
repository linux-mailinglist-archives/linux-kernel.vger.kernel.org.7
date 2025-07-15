Return-Path: <linux-kernel+bounces-731243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCBB05196
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784E43B289F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1925D1E9;
	Tue, 15 Jul 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qZtohutC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF92CA8;
	Tue, 15 Jul 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560153; cv=none; b=oEZpL0EfEMLRvtNzrlTfFKFt5E67e0Gdiioqn7bmQour2mduucJGMBoCBimeO2X+1NH1uEiFjZUA07IH+ZhIGy4sfracYmaJH5ThDnj+qqe9EBNSSIvjfRYemfacqabapgxcHombrdP/jWJgH3HD9B3d48mUGmBRukvHzI1KYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560153; c=relaxed/simple;
	bh=WTy1aa3OenxvoxmBAf6IceGklWn8Jzstk7awYeZjqMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ml/IaJf5V9374XDbK1PJ0CJRRgJY9uuCfv53UStp1uaKzZxxHTks2kJN54e+la/A0BPO1Ag7w9IxqUnSQWwKEv8ehaqChBmToxaQts4Prot6Ygel5wJCbQ+wvewSjO3C/+xcUdUqMHE2fAYmvg04LDcbnfXQsqyw1yagS4J40Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qZtohutC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EKfD9M020124;
	Tue, 15 Jul 2025 06:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nP/E9UZXRWlJZvX/E4yNRLrOxasX9t+ppX7bweOD7
	Ik=; b=qZtohutCDSZMQmRfDcQifCPO+VbJXfMkQebEijQMys6/GG6iBkZAFEh9s
	71WAmvrLseuHMFad6YQSVzDAIi2CV4YE9pg18dmua2B+++rCW149FAw4ADDq7rtw
	cXF7BshSlpO1xP0Wxo+tAxB/tW8aSn2zeFjwKotdsfYEAvgJAlmdgq/VCaW7Y68r
	0wj2u9obqgJe4aOxyKKec8Rm7v/15bmzLDePudaOsBeeVSvNQ1gRa5NpJtIhwoKM
	7gI2ihx2tnrWh5BkbhOzPpNsEBOole9hFBZTxprWVvYP2vWZM8cTZ2esaZF5MhQA
	EUZsBh5nnjrs8daYq6VzEMPJ+NtGQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6w72e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 06:15:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3NDfe031903;
	Tue, 15 Jul 2025 06:15:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21u1bt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 06:15:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56F6FiUg26083870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 06:15:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA095805A;
	Tue, 15 Jul 2025 06:15:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97C258056;
	Tue, 15 Jul 2025 06:15:41 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.27.213])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Jul 2025 06:15:41 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] Documentation: core-api: entry: Fix typo "systcalls" -> "syscalls"
Date: Tue, 15 Jul 2025 16:15:29 +1000
Message-ID: <20250715061529.56268-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6875f212 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=2Dt5MM4rC1aRafM5efAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MSBTYWx0ZWRfXy/gXzbivEjsk z7ODChMYSWiudx0+Xe6sTFR3VyqhRKLIoPx6KTckBq7daYE26Gc8dpbGQDoMZRw3fn6hnD2nZG+ nOKq3SUi6SXzeu0OSpdFClmhttizPEcN9/vvvQ54MFc3JQmb17dHoIzTkYmWTYpm71m2LaVMROd
 3Jj6FaOh/BYyndD2s5IPEZ1aF4va2lynBy8Z9vBlFXOTQWwi4VSkg7Em1KTL5sxABIpNyY8Fk1H AB+xZl8ZYM7FLxAhN2EIvkrqC4i5JVFtbLHSaQvAZ+qBgPLPqEe0St5MYouStuc6+IW2p+Yq8wm 2aSb55RfuLGBtP89UHVtc1JK22Hs6MPtL3eZemUhHovOX95T7VnpET0Y/8c3dbzrRNrnBO54oxo
 gcMXJaZbhYAH8azjpFuVXCRXMQP49vsSPX4PvwLk3RwjF0s4JJq1BqYGNcvj4Krr8SCtlRLQ
X-Proofpoint-GUID: jTu7R-wLPJZrCJTIBqshr3G1TLB0mTJR
X-Proofpoint-ORIG-GUID: jTu7R-wLPJZrCJTIBqshr3G1TLB0mTJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150051

Fix a typo: "systcalls" should be "syscalls".

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/core-api/entry.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index a15f9b1767a2..e406a325341d 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -105,7 +105,7 @@ has to do extra work between the various steps. In such cases it has to
 ensure that enter_from_user_mode() is called first on entry and
 exit_to_user_mode() is called last on exit.
 
-Do not nest syscalls. Nested systcalls will cause RCU and/or context tracking
+Do not nest syscalls. Nested syscalls will cause RCU and/or context tracking
 to print a warning.
 
 KVM
-- 
2.50.1


