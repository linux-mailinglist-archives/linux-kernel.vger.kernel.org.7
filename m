Return-Path: <linux-kernel+bounces-846996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A16BC99C6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA73B4FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B292EBDC2;
	Thu,  9 Oct 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mqg2cHAl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798392EB5CB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021266; cv=none; b=R19k171zvPOXApYNOBsokb+yjvwUkEQnxUoWgTaVXGqMqvbRrhcD0Vll0csmyUGeVRIMbA7/sbPTJRArG6fCfXW+wK4hq9FHCKeUfDg4I80LiMhnJNCeUETLpiqhtHfwV/noyLJwlF8266cbbD5OL58lLzc+uGCOcZlFzhbbF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021266; c=relaxed/simple;
	bh=wCZcf1vJQBWFgMYZhxV0uN6s2NYKhluKHQpo1wlh134=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqINCM3nUYrdQbWStJi6CYIv6omgHhvKcIjb4j9ELxD1cF2KLFLjlApM6C9qFqu4EoLhMgfOfPWl8f0X6ldtKiTaA4IvgVC4znH+hmjyvAfYWLMoR9IRlyhJKNCNm+0IYgpzp4I9r7fnCFSNBhrqWAlanRKVsbgCb05jyO2msjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mqg2cHAl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIla023272
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ebeBjH17Tc33jzXaK2hqQGrPdF0j3wORZwYG8oLycWo=; b=Mqg2cHAl4vRoAEKh
	zY36ql9Ogij0IhkoIEpBO6O7ntKIJVD0uzTD/DcEhQlvb4V8YAfD1T1uto6atE/r
	Lt8QUkwZKCJf/0dp8KxhLnuUdRm0R8u8eF6kflmhprEQ8z5WEIVOCU3EEXtB86oW
	xrUjVRQYkE5Inf825XEhQqTocG+6txLsGFC43vxJEszhbXq1Amoaqt1bI0LdvOWh
	LgnsGTbDjtygnHCv8W5LsasaVqRYAdjM44/ZQOhBVc8fUDWNocTQugngNOdr5/+p
	nYuwMkPA/QL9a2ZDL7/P9FSyEP7wf810+mL2uWE5t36xn4Iu1QVeMawn2nfwKytZ
	C117tg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m38ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:47:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87bbee3b92cso1796486d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021263; x=1760626063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebeBjH17Tc33jzXaK2hqQGrPdF0j3wORZwYG8oLycWo=;
        b=a1oSUo1P4mVwNbMDFv0oh2WocU8KRHysgWBex6HM2WxdiSu3BZnOh6AO7kXTqjtCeg
         u1jpvGjnfWLrJvfnbAyWki7QIBO4q5CLee2f9goSoLnMWVIa98yQQkc647CNhL8rCPl8
         bvBnfYWjwrjEO6xSehOCCM9nhlpSJ9H3pXFXhoYXOfbONsTvXHH6dBcNTN7DfTI6ztQ0
         grjMRjX15ZPrLpzCLS1eTrjugy7ekqsjA9fpcdticj4IVhFsGfuCq1nK8qZJ0Ta2oaWF
         OiXjw5w221ZNWHSH0WW0a+aLV37KFVmrtv30Mtf5896t8N0l079F3U3qodP6nAyVEUmJ
         Ya0w==
X-Forwarded-Encrypted: i=1; AJvYcCUXxMi9Pp18rwUQQao7EFR2NwB92VyTBvOabd0dGp3X/KP+QvVQTzkSyTw/HJh/dQqgCGagdMaxqNi3O/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH78lXGfZc5je+LaO4c6Cc7jHWalcc14ImeIybTIrTSmVCJ4hN
	ZebLgYzywLpU6D9VKVD/zBlCE8FXUCbX2/bZ7aaCCOtT4fSz7vj8YIELmjYCKeI9WDNzish2Cas
	NCxUKYYH6D7VJNLffD5+OJgxeX0pNBzN7zsmEwWzTXkKNOSUOns6T5LU+W5SK8Dsoycs=
X-Gm-Gg: ASbGncsrMjyeWREcT3ANP94xiIsXfmGZ+edWjfTREKBxo3cmU5d55rTIlTdaI9L4rWN
	kY6cTZHR0hQSDhG3rZFDO9Xp/F80wrV4jPZlXK64tJ+rcn8EuTL+95AEI4lbTIpr677zKoDC71W
	jMgQtjCVFycp7MfniNKES7ME2thJyi3XITEnRpM6pGLce4byDBnT/dGRD1hrgVWCcx5oeEPTq/O
	ktcc/shDNWveSR8HSwWEyMMFBoa3/v2njt0SMcO4VoOIYTBTIqtOBXT4VwDlfNCUBLN8AsjzWrr
	5IV5NRwhXf7wCsNOSPHYYt2/RgoOCmQ8B2ORvJnyaCW2/4CvV/FqLq0YNgnSffkQC9nvj0QLCCl
	ReStTT4G1nX9Gra5CIOZU50lKpco=
X-Received: by 2002:a05:622a:11cc:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4e6ead458c0mr75125541cf.13.1760021263237;
        Thu, 09 Oct 2025 07:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHvkCErGnAd+2F+0V519Y/X6ndedkfODnCNUsDw9spRdQiN0VpPtSkMUsOifF4sBmQy2FpHw==
X-Received: by 2002:a05:622a:11cc:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4e6ead458c0mr75125001cf.13.1760021262397;
        Thu, 09 Oct 2025 07:47:42 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f3c7e057dsm766895066b.88.2025.10.09.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:47:41 -0700 (PDT)
Message-ID: <c16d4e6d-8643-42a6-a7a4-8ca18e6db265@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 16:47:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 CCI pull-up
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>
References: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
 <20251009-dw9800-driver-v2-3-3c33ccd1d741@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-dw9800-driver-v2-3-3c33ccd1d741@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX18Nbjp7wLhlA
 JhDuqj7h5i+V6Rwlo7UJbEXPQ4RR8LrwjoqsASG6yRiKnNKE3WtXzbMd40WFvClhqkQOTXWk1vM
 O//2aK79E1DNBdgY67lH6+6h+ZQNsi0GHyzTWKwKqufK0ovvMXR0+P7FLe9OmuR1aEY5GOOMLIS
 A8tGdZNzfHg1Z7jCCCaUCVD8OfoXAqAFqcEgG9Xe4iW8Wc0i1bXRxWoFaIo7+wHKo4ZjOGySZfX
 yHtzxjlNbRAQoATylJw5Or18Hdc6n3fqJCZOLP09wu07ZVExkxrHWJ/3ZIAgP7FI0O4EJyQqJZC
 RA0hzxVU+sTKHrzdhteoGmXzJ96I1H0pcvwj4JCGhn9PKN4U4Af6w8vFuAUSmd4RN1qKyt3suno
 8WhH+S5BXjt2g/JK8dN2rnQYCg4qoQ==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7cb10 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: -ecVuJ5hiFGK5iO6PARqg5lWYpOSdLGk
X-Proofpoint-ORIG-GUID: -ecVuJ5hiFGK5iO6PARqg5lWYpOSdLGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 4:35 PM, Griffin Kroah-Hartman wrote:
> Enable vreg_l6p, which is the voltage source for the pull-up resistor of
> the CCI busses.
> 
> This ensures that I2C communication works as expected.
> 
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

