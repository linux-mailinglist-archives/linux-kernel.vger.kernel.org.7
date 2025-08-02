Return-Path: <linux-kernel+bounces-754232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F42B1903F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899543BAB80
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146C242D96;
	Sat,  2 Aug 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUufSsuE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164518DB01
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754172052; cv=none; b=Ri7MXroIJKxeDWZoktStDMDqkjgZ67qYUMqYXxWmWH+bHnXG+hHhlefZlIFKPmGxwimjD080qG6p+yPnOMxgxwa2INi2GNeo/dR76czLQDRl4DVqWJPNmah1fAMdROvrEVkIpUeFbXDCLkZFWjAULQjVQIfN1raVmY+HgTgSEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754172052; c=relaxed/simple;
	bh=nGDHMJYfkL4nju2+is+kww5uk6KkuyZpMB47n2TaaUU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JNEAWIBus1X/IoFqUBQW+cPY7niUzZ85PmrqjA9jzY31AIpl1L0FBsHLZtMpKgjoJSEJe1fOp8AzcLgzT4wFnGLE9VXWBpWWgeNKIKqoPdaGK+HgJmjzAOuYWgCgBt1nlpxBILC8AI9blvwuTirlIawg5tFt50d1YiYjZXhqGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUufSsuE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 572Kve5K028180
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 22:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=nGDHMJYfkL4nju2+is+kww5uk6Kk
	uyZpMB47n2TaaUU=; b=RUufSsuEiK0PMlNyDBy3RNWL//pV6L/WUjQUZ4DK0THi
	gXw2/LY+/vzc5ej49Yt1zP1/gJXMATisk+dFXYQjQjUouJ930q7wuWoH37YLCBCl
	PAMURUQCVMLpjocNrAmxVnOKQ7CNVKRb2XqmAaLbR2Ftb5M36yPdH/cSFBJKYbeh
	vUoVcGULl8r91HYE295oKD+FPDGvBkqWc36DRLsclE9Cit3iABD7XUNvFq6+Htx8
	lJK4pqA+emVSbbjZp5pmZQDvcmlDdJTPDDWQ3ckDZQ5MLccYsneXjnAB/0gzqhua
	GHeogApweRmrXbgkXXUE5KPqxG5QObnCzBCerLnYYw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489a6d2nst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 22:00:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 572L1YJl015876
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 22:00:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489b1a2s46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 22:00:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 572M0nj529033098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 22:00:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9DE258062
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:00:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6266E58057
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:00:48 +0000 (GMT)
Received: from [9.124.215.172] (unknown [9.124.215.172])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:00:48 +0000 (GMT)
Message-ID: <df4c285b-7e50-4162-a571-18fe9f013292@linux.ibm.com>
Date: Sun, 3 Aug 2025 03:30:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: priyama2 <priyama2@linux.ibm.com>
Subject: Unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDE3OSBTYWx0ZWRfX3quc+aeos7rn
 1wroekelhY9jvJm/HWIKCP7tmCyMmVqXJTGA+/aplPN4JaoCMI6dXW70JH65OYKyfh1/HjtQtXJ
 F4OZTmwV3VWhyv038bghFecCj7eeL6gP2u/nk85fP/y6Q0/qCOZg4yCoaPjHmO1PCUENGcs3Rou
 114B/EwOp/tt+LuUfnI08AOYHHQDeL/hxRpHA87hsYnabHmflRv2NxTDgQxSrnG+hizBolpP7K9
 7ZP48kpg/dC+IJTQWFe/byiuwMyqq+9XgtUrtyR+D93HxbK2pU7F7QjH31gdonODWwdFWntV2A9
 0Ytv/dUAH6u81ve6Kp48hujC8CeFW6Ky+N7gH9EmouaBz+0Ne+OxM+tZVtltGxaktHdk5HxdiMM
 2JAmEU91JEANAKl+8nVQeEt/hOQxu4MPrR+ADowm3subSI5VflIIZTtz+wvgSrEVvGe35ctK
X-Authority-Analysis: v=2.4 cv=Qp9e3Uyd c=1 sm=1 tr=0 ts=688e8a92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6pRh6elaA0mVHwgLl-YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y5QFRrleNp5lWR_KA_0gklO_ZiFpIQZ2
X-Proofpoint-GUID: Y5QFRrleNp5lWR_KA_0gklO_ZiFpIQZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-02_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=370 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020179

Unsubscribe


