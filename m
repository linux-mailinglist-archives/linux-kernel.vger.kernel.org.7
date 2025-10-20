Return-Path: <linux-kernel+bounces-861226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B3BF220A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85F234F8BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AB268688;
	Mon, 20 Oct 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVPwlWDt"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AC264F99
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974187; cv=none; b=WWstcHirug64NDRZf3zKwRmvx/txF4JBSj6rZ1mTiIipnPlXQbiQCGqU4oULN6AhK41uY4z8v+RnArmOr2q/uOzpMeqTAk6QGqCow2A5Gx0cEJ7r2slpybMpbT0KcGqz8EKOjIaaQEkPUl2pvA+uFUoPAxk92yaAnBXtoje5KxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974187; c=relaxed/simple;
	bh=ZSrVIlXZbIztPu34mUPr4GN3FVQxFj17MJ/iqYM2zzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SKia+FYQ6/JlcvZfUYHUwExr0whyXgS1O6cWx3Ridp1L2LycZMY1lXKM9jUr3RHmL5MVmXWXIWgo+MPYYQvycpDCOzYkWezDDxE0Ie6Wi57mhMrFx04laoztWdW7X8tQSDUMw552MoXLQDaC0DvJRW4BBLQlEH76F0ulTCdPFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVPwlWDt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K5ddsP030509;
	Mon, 20 Oct 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hRdS7yvBpCbzDAVAzHiIzuoGs/zt
	A/fmYg6aJkrP7yc=; b=LVPwlWDt05OAraF12a+3vptCKJ5XUwiW43qHzfwbYRXm
	UaU5IpWD5UhBKvhYhrwqZN7bX+SRWDda2nidXyJrbS6rom54a24LKNcBtm6VzxPh
	72l0uprfzJyrHh6WuO4ERumTjKimHefqxwliQEUGGrGED1rh+CyiHvAWo08qp6dO
	ZD2uXM3OtAi1aSMAN+Ha1KFsT8sVWl56nJMfu1UxM0APnD5Mx9Xk6FHnqeswCT+H
	/gRQXyT/xfLwMFMYL3euLO8VIoFrEWaMeajXetYqy8CtaTcWqGKHRcWjHoixYKHB
	Mw6E3b2IDqfoY+un/mu1myeIfPBNErhzdfolPihOog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vh57u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCGFBt011066;
	Mon, 20 Oct 2025 15:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx0x2ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KFTOPO41550172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:29:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3137320043;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEE620040;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 15:29:23 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH 0/2] nvme-pci: Log failures to probe
Date: Mon, 20 Oct 2025 17:29:06 +0200
Message-Id: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJV9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3byy3NT4gqL8pNS0xMwcXWNLczNDI4NEE3NDSyWgpoKi1LTMCrC
 B0bG1tQBVx4WSYAAAAA==
X-Change-ID: 20251015-nvme_probefail-3976120a4719
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UVGitCESVy7LEkCr3g9U6iMhGW7WmRMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6nxj3/yMPPsN
 zEw0XlvN2bzb+HSaF+Byk1rqbGzeAIfgdckudv1qw2VW7s96bzUkUZ7fqDz1OKCSyJ6xu+0nMK9
 pN44uT8XQCx02ZkNI+nU3CaUfdpo9shU2YDLPn/MMwLxIm6bE2lJOERqxflhaEJNKRetVMiBHmS
 /STdt/f8iHHrq/HqcI839I4aOnDUsK7afwv3kYG+oAN+On4O1ZLz/YRMU3IP7sqC9yfYCcE7cd7
 pDrNZBx6A0YgAfu7D7rtGx4lrU9n5J6fBnUG5nPksyXM11IfRxhmmSwZnMSd4VbgNtXEbPNjvJ2
 ZC+FdUPFgxs7zDYTiS51HBtP+dJDf42Jwmk66jpY45B1JiWkP2XcZHtJeY/HPmQVB4C+cWabqqR
 trqBMzUWYbTh9iSa59iUbq6sWs+GIA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f65558 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=CcIrr7SvaQpJMEGp5N4A:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: UVGitCESVy7LEkCr3g9U6iMhGW7WmRMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi,

occasionally, an NVMe drive fails to reply to MMIO reads despite the PCI
link being operational. In these situations (obviously not on the
boot-device :) it is preferred to have this reported in the kernel log
instead of deducing that something is wrong by comparing expectated vs.
observed number of nvme devices.

 - 1/2 adds a clear indication that the device driver failed to probe an
   NVMe drive and will not register a nvme device.
 - 2/2 adds a debug log that allows to further zoom in on the exact
   failure

I've split this into two patches, since 2/2 might be less important wrt
to back-ports, etc.

Thanks,
Gerd

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Gerd Bayer (2):
      nvme-pci: Print error message on failure in nvme_probe
      nvme-pci: Add debug message on fail to read CSTS

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251015-nvme_probefail-3976120a4719

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


