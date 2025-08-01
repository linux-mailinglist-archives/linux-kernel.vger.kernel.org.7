Return-Path: <linux-kernel+bounces-753541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CCB18450
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDB83A27A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935826FA54;
	Fri,  1 Aug 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cu7ufEW9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DB26CE3A;
	Fri,  1 Aug 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060239; cv=none; b=KLojiBLrjcHPMmBB6JmZMpKyIdO003AvXrGjkCeb1YUEj79zwefsNi6tIBYNg6SlC5kJrJ+A88MijUyHRUFLFYCCsFJsVkUbxOBukjpYC6NGwzraLVWe45NEpq/yHsjjYW2jjAmq1b5OojaCyFCDbWF3jUdscT2Pw47XFYoAahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060239; c=relaxed/simple;
	bh=gbE+jehCMIkCOBGQxsTXoSyQr6yIokZ5llUIZWqQ1K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okV/qHcuaWqAWxT/i1tGZiHPqYMzFFqWKnRSxp56DsDcdbBPxCJzKly1KILOKM8wPXU9/m3Wj/0irg9HyQIeBTbVgSNaWpwIWhP0DrT7IoPDJHRYD34uj4qyhOiNkdKOByDZD/vhmOJdAfxcbommuiZsd5BGAy6pN5YceRiAEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cu7ufEW9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5716RQ45021860;
	Fri, 1 Aug 2025 14:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YnSnKu
	FRT8BCgjASZrg1uqVgtZph4jMWjiixUwKGaeI=; b=cu7ufEW9j3hSs64eHtRRpY
	56JgN2/rMmAdcaMuWm8mJLl99nnqlB4MGOQq+RuPMtlfTM1gJX4mdrkIrqdSvGrA
	jIN4XSekS2D6XxUseipDHOuhZxb1MbJ8hvE0QcoeBp41HlJYDC+6y5uCblzWC79E
	jJgwLraPZAU7vgwpZIGCl3w0qFM+TRdSEbhWSWYMius7tj8aUJGFcKC7Mz/kWfmr
	RyxbxI12K+X07Ae0x1CFFwfkhmj7zNaKSTMU1xsAWLnT5xNnGSi81ME3oIjVG/iy
	hYITdpLc2KUDS4w9+tCHykE0zhordXGmyqk5+SYUVo+qvMBLxW449gWTu8eTgxyg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen9d0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:56:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571ED5Ka015999;
	Fri, 1 Aug 2025 14:56:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aun1r64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:56:53 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571EuqPt32178850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 14:56:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7958158051;
	Fri,  1 Aug 2025 14:56:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3AC5805A;
	Fri,  1 Aug 2025 14:56:52 +0000 (GMT)
Received: from [9.61.163.64] (unknown [9.61.163.64])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 14:56:52 +0000 (GMT)
Message-ID: <0dbd00c1-7b47-4e6e-a8bc-5dd0b5d7e539@linux.ibm.com>
Date: Fri, 1 Aug 2025 09:56:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ARM: dts: aspeed: Drop "no-gpio-delays"
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
 <20250731-dt-fsi-cleanups-v1-1-e7b695a29fc3@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-1-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HIw9ud3jprKX7EaZVCKTXNHQ5Xj2KOwx
X-Proofpoint-GUID: HIw9ud3jprKX7EaZVCKTXNHQ5Xj2KOwx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDExMyBTYWx0ZWRfX9IsCkPss3zXH
 14wNQTMiDkysyvTxDCJW6qeSsum2KPu5soAYnGADq2plh9VwpWivHL7WME3ByJyiHRRoKX9dzdc
 EYxn5BcRRcGUFP2k2WpOFqIhWlmj/TMWw3reYieGLRh41H953e2eVX6oXeQ7IAzjWyaLPDgVdo3
 jO72JIL+sXKXCWnMuH/FZ5G0Oo3/IM07w46Vk9ZLZR/g2mCiY2U32Nu/+PxXg0tpueZEh1XukfU
 mlsm9okJAwFhgaytZEHP5ZQfyLoanOPULC4ilQdADYZOuboivV0ivLcpbKobal6wOzZuVjpMnJE
 zYyKQDlGMXjxSjUAyQk0Gc0BnsvmcIfx7RkUxIP9qD6cMNGZyoD6EMo5OfP+EGt8Pp1L63zQC2M
 TSum2VC6y7niTAhc1mqmPwGzl01e9+2ohpvGd4kOhNpv9p9N+NCwZH2SKd5Dzqm0ggKCkTaD
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688cd5b6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=dLEtqkc4Rl9NwHs-IUkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=974 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010113


On 7/31/25 17:12, Rob Herring (Arm) wrote:
> The "no-gpios-delays" property only applies to the "fsi-master-gpio"
> binding and not the "aspeed,ast2[45]00-cf-fsi-master" binding. It
> doesn't really make sense either as the timing is controlled by the
> offloaded firmware.


Thanks for the series Rob. It's fine with me if you take the bindings 
(we're not using the FSI tree now, Grek just merges stuff as needed)

Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts | 1 -
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts      | 1 -
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts     | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> index 78a5656ef75d..f42254ba6aeb 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> @@ -57,7 +57,6 @@ fsi: gpio-fsi {
>   		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
> -		no-gpio-delays;
>   
>   		memory-region = <&coldfire_memory>;
>   		aspeed,sram = <&sram>;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> index b1d0ff85d397..e5b8d07e7622 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> @@ -80,7 +80,6 @@ fsi: gpio-fsi {
>   		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
> -		no-gpio-delays;
>   
>   		memory-region = <&coldfire_memory>;
>   		aspeed,sram = <&sram>;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> index 24df24ad9c80..2180fa9b6f24 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> @@ -71,7 +71,6 @@ fsi: gpio-fsi {
>   		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
> -		no-gpio-delays;
>   
>   		memory-region = <&coldfire_memory>;
>   		aspeed,sram = <&sram>;
>

