Return-Path: <linux-kernel+bounces-884654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C11C30B29
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5080D4E8CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794412D738E;
	Tue,  4 Nov 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="orsVapPW"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B234D3B5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255075; cv=none; b=TJFoCdhMUC/Fsgt5vFcM1F5AAzIxbHLB7SFnJMxnsz0fWGE4Fh6vPHcs1OBHMzMfvhLrbCQ8uyALa4eWoQtEgkZiquWWVRj5D3g2p1rSWjBRGCuDn+2s9VcZaapJEf5vDhBtPXewp6+GkZ26NdUaTfpsabcPsjFTTdkzr38rqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255075; c=relaxed/simple;
	bh=aRyS9d843WWLHfCU/awjBmR2ZC560F6VzZV7b5Hvmi8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tKUjuGtpwxEcNOprDLqeWNIJq1fraCkBewUYngOBre6AkvJl0P7evdW6rZYWLCEwJd+ZX3BdCe1zlMoeQCAbUIcomrhGd4xMOkTjS870qmerT8auRliuKR+Ybx9YDR8LdXBJIjiVTWC1+/cREVcHb7txMjlB4Y3Xtdx86vBW9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=orsVapPW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42R70u012968;
	Tue, 4 Nov 2025 11:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=vfJzI5vVGpGcn03VPyfYT7i+tLqo
	eKvN3SJgrvH8L8E=; b=orsVapPW//CR8hm4PvqfxHyA6XYqRK70nAo05bMr807z
	4xByKiK9FM1wmvdMeci5mvTZHuAfYj4Rj4V55tBHLpKThzNdEi283JmB3NjS5akM
	DFUOXhBH2MRN/ig9a74O5P3CgyTQJ93jtL8uk2y8TOHfG5R53YH/rRIFBc7vAEy4
	yGcmKnklenjLlKj0/Mizlm1Ljm/FX3ipZnKTsiZDFzboSfM5neEuDJqRVGlvxr5d
	QxtlQF9uKPzLHIRCzTl+VLTl2EoJE56nL0wAxUa9IeZ4toW3EOVqLO+xhEZZtUVA
	jSt9qOhpfmMZl6XGGO0gfpQW02F7rmCeSHtwT+0TgA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vubhu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 11:17:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4BDEpF021463;
	Tue, 4 Nov 2025 11:17:49 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjjg3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 11:17:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4BHmu018678398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 11:17:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FEDD58055;
	Tue,  4 Nov 2025 11:17:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BDD158059;
	Tue,  4 Nov 2025 11:17:46 +0000 (GMT)
Received: from [9.61.246.206] (unknown [9.61.246.206])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 11:17:45 +0000 (GMT)
Message-ID: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
Date: Tue, 4 Nov 2025 16:47:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, venkat88@linux.ibm.com
From: Samir M <samir@linux.ibm.com>
Subject: [mainline]Error while running make modules_install command
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dx3o_3OlNQ9pF_JPKyAASLI8PljQ87W3
X-Proofpoint-GUID: dx3o_3OlNQ9pF_JPKyAASLI8PljQ87W3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX4QxFdVWS5Aqi
 WkcjNvEtE5gSlwFoK86qtg0YAezD6oNVoTIgqVAfCiy6EKmS6iNlVI83ViY3a+ufivMB24Z1MF9
 BH20RMEIweIZWpcjl31F6zxe8Xv/XA2LK57/0+6xAB+S1qUILD7gyZ0pgrwEUHMS7FW5iTpslSi
 QZ3GFvM7phtFOqkDxd88EubPF/JgX2OGvOAIsyECyggg50U/pmnr6SwGKPme6LU++pff+bfZpvK
 5+atxWGrSgWTqojeZhBX9x3hezW90JnJiaSzafaDwy+CH+NeThZMZbO8lqgjh2ofaLGlred861m
 3nOyr0V/aZGmkI7h8QBmFWy68bZ0+UCyXDb+/70m4I/qHoH1IvqyPL6OFeZcb4MdfNiDN5lYvwg
 HfBD0FwrT4sN/rzQvbZdg12UFMRdTg==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6909e0de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=z2003YOFcUP5efOIY1oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

Hello,


I am observing below error while running the make modules_install 
command on latest mainline kernel on IBM Power11 server.


Error:
DEPMOD  /lib/modules/6.18.0-rc4 depmod: ERROR: kmod_builtin_iter_next: 
unexpected string without modname prefix


If you happen to fix the above issue, then please add below tag.
Reported-by: Samir M <samir@linux.ibm.com>


Regards,
Samir.


