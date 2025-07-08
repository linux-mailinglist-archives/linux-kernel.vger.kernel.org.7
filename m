Return-Path: <linux-kernel+bounces-721737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAFAFCD41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352873B2B16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772562DAFD8;
	Tue,  8 Jul 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdRP6Hui"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B99274FF2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984349; cv=none; b=s4hJwVKCre5Yfcsj4DL+LZpcuimHCznSHqstc8c+BRAu0sfscU0z0aPjvEw5NLpmP2heyc1EJwRIzE36wbYGBM9oJD4mDQQLASivqYxHmhNFDhXQLVLjle4TD7E4KNT1tB4ELpppyzpfdR1CvmwWSz6eYNoz8/NBM8lMjye41fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984349; c=relaxed/simple;
	bh=ZtrrtzG8CBKD7GY7+soKg4RhDNkLV26sXMNQPor5OB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4vAlBpEK90tfMBzean+ryBv1KnIfbzIIW9mz+D41NpjEtAFSIN9+erRfP/2L1+X6N3okwL2p5AmTXtpiGnqdcXt1vLB2TP9pkJfN8uOM5+njWmG6qu2+NfzCQo/VK3q3ZOdaEcuATR0ize6yWYfGlT1qYUclbNLMTjvwL38Tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdRP6Hui; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AATDk025476
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CCN+ZM0WDYfEPfbtoKj8b1vYzeDnrGa8gkgH54G6yIw=; b=CdRP6HuiYwLg9Vk9
	AeVfvHTLmPR+V0N0INtC9KamNorbzYFjmSbc3FdoIuHJIT9aypuTUhdxhkUS5i5Q
	GKnjbK6H+Dk2eLLCY1zHXb2+IWNfA9QFO7MENMZvUijOIKZsBU9pusb4fNyETDYa
	35N2MOCU0KLqoU09PNhWKZPspjW1dqapjTgTe4KufOOmL+eDiExAOusRxss/rXuk
	EE6IIMvGVSP3HsNjOK148rfsqQKwGEPPe1EcJqDhKmcW4s/w8+Tkd4r2FX/EritA
	wSh4d42TD3JYMn3Qx4N5q5sXH7kUhx9TEMm/08IZ3EJEQu02jUqULTkkagWxN35d
	/eU0Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0we0qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:19:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09a3b806aso39867785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984346; x=1752589146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCN+ZM0WDYfEPfbtoKj8b1vYzeDnrGa8gkgH54G6yIw=;
        b=UmXPvcyYGqw+3uf81ORLx7+6moRyOShlAtaoAcp3QBXFpUUNHJg8WKjcWuj1+TG15X
         FUy/G+Hmnspdd0wqLR9rv7vvOWgKYqw3AvqXCIOzP7bL2oOMFFmlKEe2v5L3PKpqc7Gg
         CEltHmUjw3VVOMHWOT78RYokF1fkuK1qSpOoR7jUbownFtx9qW6RWFXhj7yPhmIMeJrw
         bP9Xxx/DaOHxvYktS2J8Her7KCqi+ugD56TpzQogAsOiMjvlWwY8cTJgwsrzta2/JaUN
         47CLJJGbunNvRUYkj/QuoYrXUXTx1SoIIrhK7pWyvhpd29H/LPTFmbohbzQjvHEvHps8
         KcvA==
X-Forwarded-Encrypted: i=1; AJvYcCUqTeMdRpp6qWl8AiRjBQREHdpzNVAgSR/fHa2PFEpMcFUKOAEBgZmiMFC7jayUrF4wtG8bWGeQrjYf1+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUjp8PMe3kRyT7rNoB0mepOv3mO4DOpxjKbXeT/DUJg1vzFvL
	SXz785HoSAQtuwHbC+/Zqg1XzHctPzi9MpsMEIrAak2tI2daXRFPBiQ0W/ybPfGFfpIBmDYrkyX
	oBIVG7RN9oy6GaqUYr2DfkMJjqlHTUYxgEsiDZtcNz3T7I4Cc7DVJPuE0qEGVCxphYWg=
X-Gm-Gg: ASbGnctkPb1iyEbC1u6ksdMNJ5+2Fzi83wFKF3G9Z0mYXWPjN/t79sqMIfMbml4n9+K
	2ykZSy6PN05iY5GfhpQppXUr158ZRpQflLzGb6xpBwPJdQbSMPNpOun+fp8W8Mt7BBCzxFIwm0z
	3kpWCpwWWK2sKzBNGSUjHgmRHfoGJBXgi0CgTu7YADpOGdkf+NWVeIjemUMcOjMDVXcF/d31fbr
	Bz/4/PAGEpz4gYzjnYb+p0AgKsAbcJBeD4mX605PIdY4zURk1ZDS1UNqQ9vp8mSWGpm2FDjTsUN
	9k4Dar0gH8AqZeY6eNPD/SpGwHRy+LEDOoeN6QNt9Mc3KBxqxYBFNKpeBL4VHjKadACqONRfNMC
	5kJQ=
X-Received: by 2002:a05:620a:4707:b0:7d4:6286:c7b5 with SMTP id af79cd13be357-7d5ddc69c3emr930835285a.10.1751984345584;
        Tue, 08 Jul 2025 07:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGToZ7bX8sdPXYqo2EckDoDatolatmGiV3VIUcLArEf8GV6va65uu0OaC+oWZpqVwYJHsZ0cA==
X-Received: by 2002:a05:620a:4707:b0:7d4:6286:c7b5 with SMTP id af79cd13be357-7d5ddc69c3emr930832785a.10.1751984345114;
        Tue, 08 Jul 2025 07:19:05 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b64ebfsm893538766b.168.2025.07.08.07.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:19:04 -0700 (PDT)
Message-ID: <f4a74a00-a860-4410-a4db-b946c6211e68@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:19:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: ipq8074: Add the IMEM node
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-2-692eb92b228e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-2-692eb92b228e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XwpU4A930t4kdRKZbNbPphEyoScMP_TZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExOSBTYWx0ZWRfX/N/4MUYr72xE
 Nn2CJ2WH/0ylrMo2S7vfIpU1F9R/CmxghGQr/VNK1zVHl4EZ2A0q+MI8o4o+2pO5PwgN0xRfypX
 DrSEv2K8J6bUbErU/oHfkCpNJdhgfB1zcK2SJk+io34rqu3To4t65+1yeLHV+uOjuZKHIikW0WP
 TcB89/a5VhmlRJtmp+IyxmY9eN4LVRuuUSxAZTLxiSO7FJZPH7KLWFhkKtq+Dn1OJ9mBc5mF8Ck
 pURGwLLLvta7oJl8SQrgOK7Ar3UYZ6wlq6Z8t/cbeSvS+kK05HZ+YZQVbPFZhYOaNfNQccmhE+c
 r3ZEA/CrsdUzQebjMQl0nXUgpiyfnIBn0JJF+I25UBnb0+VVunwfr4TJ0U4ve9paloZWJzB1xF6
 v4JOLiV16HQSdob5xWnx4o8GhgGIcxghSFu7wM3TvdymX7oYv3bqf3c6jZA4MN3lbxUqRwGD
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686d28db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kR6MMDqDNadd9sbrY20A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XwpU4A930t4kdRKZbNbPphEyoScMP_TZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=818 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080119

On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
> Add the IMEM node to the device tree to extract debugging information
> like system restart reason, which is populated via IMEM. Define the
> IMEM region to enable this functionality.
> 
> As described, overall IMEM region is 24KB but only initial 4KB is
> accessible by all masters in the SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rounded off the size to 0x6000 (Konrad)
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

