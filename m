Return-Path: <linux-kernel+bounces-753548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D667B18461
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C25A81EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F026FDA5;
	Fri,  1 Aug 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Noh9TXzF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71021ABAD;
	Fri,  1 Aug 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060390; cv=none; b=dfLWlI/RXR+Fv9oi5l0QpWxF43R/sb2JDFZ3saethuuwKof5gl3dlCYW8W7+LlGZvSakMQUfEWXTMlbhf5qvR+wAaDRTYHa4+qeEFQKbGYUEsONJrcGfr+p3AxjjS7Wg/JqGegcpnEFsMOtArP/Gqqf9UqE5ju0ZwE1SH+nm950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060390; c=relaxed/simple;
	bh=pAZ5jRvsMmLsz+XSoDQJfYBg8JvBO6bMeG29Wk93cvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DB67K3Jm2tSy7JX1Jb3GfyMTJAbml46JIQReKoo9EJr9svFdmqfzsk8f15EeZWqiYHxgiT4/sP4BLV57/7QMFqUsK2BCYjp/2fF66JOX6hVnqDOZOExcYJ/SJNXdmHzx6yGEGySzprunxYDwJj1L6TvS8aaqAyq2rJtKkPvAfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Noh9TXzF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5716IvQl015303;
	Fri, 1 Aug 2025 14:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rkA8li
	2kiIN2vGtrkJIcUMV8KNRLWYgYSUF6Y5Cmtu8=; b=Noh9TXzFBThGLqjh7D3rQ8
	N/jbdii9fp0Gp9bqHuilImpyPNQshICSIJut/QRgSJ/Ry49MNM/kmL1mx9pKWBzi
	GWf+hPehVoiKNKa8YBh8hGbbRFN1tPavLeux+Tke1LBDSur4xc/Kc4+/wNxOT4yh
	seSAZZsCkNRf8s5RgQolnm8CrdAtYTLLGwKBI6W2mSRbccMf4Zik0dmBxp3O4sJ/
	qHtgPnh7+uZzXEvTypJnAW3mJ3zAQeVa6dtBlzsfRNWrYOG3SHfkUcAG7kaEU6PP
	5VYgXjrhLrPlX6ejJ05v8/D+yZxXL1Ik8tizaEIzYJoPoDMKchtzm2X18LV3/WuA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr9bb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:59:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571B1JDA028782;
	Fri, 1 Aug 2025 14:59:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c231hdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:59:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571ExLvo25297568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 14:59:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C97E5805F;
	Fri,  1 Aug 2025 14:59:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2775805C;
	Fri,  1 Aug 2025 14:59:21 +0000 (GMT)
Received: from [9.61.163.64] (unknown [9.61.163.64])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 14:59:21 +0000 (GMT)
Message-ID: <51c32617-5283-4bb5-b881-2f95d0132a58@linux.ibm.com>
Date: Fri, 1 Aug 2025 09:59:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] MAINTAINERS: Add FSI bindings to FSI subsystem entry
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
 <20250731-dt-fsi-cleanups-v1-4-e7b695a29fc3@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-4-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDExMyBTYWx0ZWRfX8kHrqhF4COX2
 7UnZts6lvi4Nz3aqeSA/kZPY9Te7UnLFP0Noq9OmOjNsecMVewyybNXoXgjFBU2cJ/LBqmOanJr
 qS7aoQeg3z9o58f/diWXzvcWdCl88V/V5spw/13A9rL/sjQTg0LJExGkpvm8WoGUHio7LqO+Hhi
 bkPbu7A1aUptWUP204YyjegXcuTOvtb8bd5bMhNRIWT2n94RREmb8hjZMGaoOhgZmbtyk32z2Qa
 LJJKRKoJX3bp28U5YKNqvKHPSpCQqFgdCitquDuvaeJBN1U8fROQr0lAo4EsyFEh3oBPOeUHAWY
 O88rYEWJ79O5S8bcGKmXsu0NhF/I2MdfIbbwJIqIL+bcbJ4ZyJUDiuK9PiXqw4JsqmDNkIYeA9m
 BpOEQ+JluRhYQr5t5Idx73xyLvsdcS40/xOVVNu+6vUOBBFy3ixfjITcBauchxCbjEPGAkTg
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688cd64b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=voM4FWlXAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cTLu4zB1kE6kTx7l-YIA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: aTpJEyPSXWlFWEvVEbyq6mm8MZ2nW6Ei
X-Proofpoint-ORIG-GUID: aTpJEyPSXWlFWEvVEbyq6mm8MZ2nW6Ei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010113


On 7/31/25 17:12, Rob Herring (Arm) wrote:
> Maintainers of a subsystem should also be the maintainer for
> corresponding DT bindings. Add the FSI bindings to the FSI subsystem
> entry.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..4a7b4656822c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9810,6 +9810,7 @@ R:	Ninad Palsule <ninad@linux.ibm.com>
>   L:	linux-fsi@lists.ozlabs.org
>   S:	Supported
>   Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
> +F:	Documentation/devicetree/bindings/fsi/
>   F:	drivers/fsi/
>   F:	include/linux/fsi*.h
>   F:	include/trace/events/fsi*.h
>

