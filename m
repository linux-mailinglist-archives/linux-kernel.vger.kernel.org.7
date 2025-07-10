Return-Path: <linux-kernel+bounces-725096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99DAFFABF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DA57A71E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D0288C18;
	Thu, 10 Jul 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GDLLPJK0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6328751B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132207; cv=none; b=VrdZVPVlELRQMcClesaHM9qKwWEgy6oOhDFpWgHxCCw6eOkoDBf6uk/EiezoCN0wHWTVzMoMWQhy2V2nzUrUA8ZmSzvSf9/4CXexFfOU/5rIV+q1ayGkKSlVrSMjMaQzIf2+dEpWuwKZBYegowg8+RDVjMOPGOVN8eIK5QO9rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132207; c=relaxed/simple;
	bh=+r9t8NkyC82YRs0j8dokFjw3LIpPqRJpCwL0NVhMRMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALHX+f55WCSWxSbN1h2AVtODTNbsGxAkf/jei5hwmlfT8eFzokOPoma5O1uUwhMYr32bKvRi2G4ilkRYilSLmWkJCBpKjh0YgLdo7IkhUaVOy6zjRgEnPGXM9fbe2Z8jQ3NVgqpabG0jFaxSsKeWsCFxbnzkzkZMaFA/PBR1lHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GDLLPJK0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MmLxD019358;
	Thu, 10 Jul 2025 07:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jNdjqe
	xWD9dvYK3FbcoWaXW00tzKthPqJvN4dLJv1oc=; b=GDLLPJK0KPWUnpOHh57cTl
	jQH1DOrwKVl9jNRne9xgV03rbi22JyIeoCem54a0Pl3BjTkK/fMXGibRjwLrAVb9
	8qd+h94kOZ1kRnLH/U5ALlVOvRZrFVNo2Q9DW4Mm+FHGWWLiI8FHu/uDEncAgj12
	f1nt+RkZL+FtgaDritrc6IecCdEt5QtLjVGvymgGtzOP7tVV2RYqVGd3JSTARRyh
	mVG7C/HvDRWyTo3BozHv4KU9pIXSITyTItu3Ds8X3jTvKmwuz2T+n7y+AMeh4uIg
	F6d5PQmK/zavK4Z2IEIdLSTjK3Pw6RLbOAeTNfavbreNt0gpKweuz2Qwgxq/cCuw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4bbpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:23:18 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56A7KgN9010608;
	Thu, 10 Jul 2025 07:23:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4bbpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:23:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5enaX021561;
	Thu, 10 Jul 2025 07:23:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectvn80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:23:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A7NGgK32375300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 07:23:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A37D58053;
	Thu, 10 Jul 2025 07:23:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCC2058043;
	Thu, 10 Jul 2025 07:23:13 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.90.171.232])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 07:23:13 +0000 (GMT)
Message-ID: <8bda71d7c25900616beb706c73a04bd54830252b.camel@linux.ibm.com>
Subject: Re: [PATCH] ocxl: sysfs.c: Replace scnprintf() with sysfs_emit()
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Jul 2025 17:23:12 +1000
In-Reply-To: <20250710071815.351069-1-seokwoo.chung130@gmail.com>
References: <20250710071815.351069-1-seokwoo.chung130@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA2MSBTYWx0ZWRfX3cpkbFpWlich 7VKpJrRtWSHtUtVoeCxuZ9CZ0HTjL+wRrHVZvA8le2faTE/WMVRduSw7JnZI6GcbQnBd3k8u0Of ZxTw22AHCUZvtISWQUXG8vCCPxNcTDxMHZfuzfxU5wJubLlv6wCY5XdAtzZtdNGnI6937OSAHFM
 dTluHK4/PUlwKn5tdZ/0U1OtFkcS1pzfyxeBt6zUP+Zf4Vtao8byFWlPvKPF6QmIj6ATP8LZAUM fVoYOX1lzcEKhNJoD33QORg8xaErSYnU0tsCwUdgQ11RwqGKsyOoG/+1OxDD2osMBVfnU1WTxpq u5jgy+JftOwkNNjHDTXcN4Q4wRYHwePCr83RLzEx1oClbY1j8/HHD6CA6qbt0lcoNKxayUyE7kP
 HwmL26I4s/Jb08nMJNGG6R2teEBkxhnJ/ZvWs/eRKmpAPYHbAhJaZEMUdXBfXoBBisTHivpZ
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686f6a66 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=ywHtLLQGUfgKd5ouuJYA:9
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: xK_GEAAhqq0p9QJ5-w3E_7rDrPGfAyLU
X-Proofpoint-GUID: 04QUFcX3Cf19Hy3NCJIhVqO8slIh68Kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=531 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100061

On Thu, 2025-07-10 at 16:18 +0900, Ryan Chung wrote:
> This change uses sysfs_emit() API usage for sysfs 'show'
> functions as recommended from Documentation/filesystems/sysfs.rst.
> Intended for safety and consistency.
>=20
> No functional change intended.
>=20
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>

An identical patch has already been merged in char-misc-next:

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20250620024705.1132=
1-1-ankitchauhan2065@gmail.com/


Andrew

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

