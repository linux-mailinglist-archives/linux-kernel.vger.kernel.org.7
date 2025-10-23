Return-Path: <linux-kernel+bounces-866267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71653BFF56A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88AEA355136
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59902848AA;
	Thu, 23 Oct 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XR/Kj5zS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58E246778
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200729; cv=none; b=glOvJu5mE1JFCGLBxhJ5rUdgD8bU7Ro9qlfdBuzwbW5AOwT272atTqw0wK8p6KiuesT4CUzFiRgfP4HeBzT4rRH7DcNp5MUfcwFSxdFwlJSXLXym8MNFYRP+LOGYQmCRdHV1i47oqrTnaq1teU+uh+itbfEWovtgNsdkLQjcC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200729; c=relaxed/simple;
	bh=eK8S6eT6VQaIYZMZfBJ5y9XwVsmR40oqMMGsR0Jy69c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOze6xxmh6eTX71YvMl8WeKnSkqY7v4Kdo36+e1+yJcTISwuKcumJ+xqhpT4iGBhnF0DYd/XW8JCqbUZ5gAxkvN5EkGgAV/xQxMvgKKdk6Zq9H7SeVGax4kOm2htITprKmmJsRzsQewq2GF0hqvECpGe/2mahymSONllwAQFqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XR/Kj5zS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIet94015917
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JCRVrM1iV6c8egPBONX4RhP+y7qVy2uAhpWs7p9gCe0=; b=XR/Kj5zS8JpEY+eb
	jdXKc25NhJRYSEc9CSbhPhQb94LG8OoacpoDsk5WceFpx45I10hdEa5/GeIQIS7f
	XuWPaee8yrmO+9YaVsiuTNaM3VgSbLyDM2ggp9OYttbdluwyfcSXMGdx9abM/cYM
	V7bopgx/t3wrt482Egs6vgJ5VRLao4EzvWPilm956zi+/jk1gd5mTB4jcNCUbbNh
	iAXujezxPIX8AZ/gHbBBVU3abEg7COG16sqFvjJN+RiBg8npkdru2MxOX1zvT7kX
	cRMETEIcPDkRtIU2oxUq8luuEbYVM+FesMFdzKts8zE33zLp0AH/TdrWQjBuZRsx
	avjeUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0n59f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290bd7c835dso4665925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761200725; x=1761805525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCRVrM1iV6c8egPBONX4RhP+y7qVy2uAhpWs7p9gCe0=;
        b=Eg/j3A2bDdol35CSn4B2ONIiVB+hiLULSvceFIEmHhCyR7p1TSjBGzz9+KCphsr8j5
         aTZ3hBSVYPOL80WN/q4UP/s7CbZZSBKYK+0aSBaQS1LUuSXT1YsR/8zcNm4cy7ZmXYpl
         IgaNHTrRpdo2/NhKoOTtLEp5dhLOzz8ENyaIx32/7KEzE5cYlc6UA4+35aMmJmpSSj23
         mrTyTWX2dcZu2xjNrkGVPI1Fxr+bP6icZvvq4akVxA9VCJ70aTGKPy5aWhBtvTPcqPSv
         83Kn8o3mKPynKaPXXJlmR0E0wl5Gq8ZGJeP3XJxcaghuKmuwyojVlJxczszzQsHXX1qc
         FBEw==
X-Forwarded-Encrypted: i=1; AJvYcCX4kjugFlldMNG4dI1t+8509j1Wj9RXVxeZvgvOiRQMOB040Gxz3VYUzIHAG68RgqdxGNzcN7p1bjH9q28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSI/BqVPkIKhfU9pYCkvuEmzq0Ts0oj6lzQnBHwFEZpc3Va3DC
	ihSp9iHiKYUMdRbOxF6ymIYBayypDlMEVcSYA89UMDkSzWSjn0PpN0KNEivCJF+RjJcnG+1TXwA
	ZBtkfRunAe43Y/86Flps0cgQF6CmiIHjvISj24pimXA8U40ajPmlHCY2jx/Svf42crW0=
X-Gm-Gg: ASbGnct4dMbTlKhPboxNZbP5lgGcnF+Iy2BdEovlloL/sy3zJKPNcgNmJQnZLNQ8Ty4
	j/YNG21s5iMttQOpoiRCayZHJdOqllc0An7kfq3WKuyH16b1odrtAH2el6zSPyVpGOiG0b8b1h2
	7+gcrSYmBg3HtMkSjLkMz25Qin+eJdxk9sDhitWJPJ2i0vFVxhzvug5cBse7wK95p6rCAfnnl0r
	+5xPjm1hhVOziiO8A8GtJ47fOnsuPrhP7jGi55O5MuTbk8RgA4zh6BRwl0Is/bIJf3MHbjpRXYB
	gsx44oeW+dJwRyJYAYkJuB1h8Yp2P3SHORePlXYcsl8wO2w0ycVPfMuBnleM0px/CvGorB5gTR/
	JGE2PdLW6SSgT/Rf4umS0TR7LqDhMy/HdSsj5IMq1ZkfAISrek9pgZ6CjiHkUjHvJa7eB7w==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr293186315ad.3.1761200725247;
        Wed, 22 Oct 2025 23:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFd2/d+6gkUf73DA/7Gn22CpH9SZH0kB27SuHl3ZLpVxevmFi2VvJ/lFTT9aCIgsr6cd9Tlw==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr293185715ad.3.1761200723794;
        Wed, 22 Oct 2025 23:25:23 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda86f8sm12196155ad.1.2025.10.22.23.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 23:25:23 -0700 (PDT)
Message-ID: <7bab3dcc-ca29-4d71-8156-7104c4bce614@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom,ids: Add SoC ID for SM8850
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
 <20251022-knp-socid-v2-1-d147eadd09ee@oss.qualcomm.com>
 <118dfd79-f65f-4845-9436-b6be99a5223c@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <118dfd79-f65f-4845-9436-b6be99a5223c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX7Fc3fNEFXHfl
 lzTDbwV+swn4gd00uyw73xaIHHweqzn4LF6PoQhwm+FiqD9mTS5htXcAL+1hrrsg/3RJsKMOGyb
 NNoNvr3T8bWDu4m4+/Lu1GWNZKMXxg0cDpG2XaTxJ0hk4fe+3syfSfaLN8CQdjG0EtIbrIathvM
 4bz8Y0KH1nJ2obbhonfztRcr/YiJiCGYH5/s+/JK7asWHSoUwBthO5eQO3eetb+f2/tbvy0yvIm
 3XQ3XFvIwQoXE1CG15J+zKOVS+caFDbc7k0S4ZsTvtSmOwXeKXFa9YdOYZ27HHc9GdVGAue7hx9
 ohdu3AxaHOTkTPznJ8GivUH3Boc+gsF9LgQ5f+EftgquBHmx+P5TeJIbWmW++QgVEgtHhT2N3tB
 qCaQ9BhLzP/iVvKbeUNq8HXSOsnNLw==
X-Proofpoint-ORIG-GUID: x8Lt18cr-bv4f3WHnyste2X1Fg0pfeyc
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9ca56 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MmHyG1FtGRAvTinHQCEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: x8Lt18cr-bv4f3WHnyste2X1Fg0pfeyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 10/23/2025 2:18 PM, Krzysztof Kozlowski wrote:
> On 23/10/2025 06:57, Jingyi Wang wrote:
>> Add the ID for the Qualcomm SM8850 SoC which represents the Kaanapali
>> platform.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  include/dt-bindings/arm/qcom,ids.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> index cb8ce53146f0..19598ed4679e 100644
>> --- a/include/dt-bindings/arm/qcom,ids.h
>> +++ b/include/dt-bindings/arm/qcom,ids.h
>> @@ -286,6 +286,7 @@
>>  #define QCOM_ID_IPQ5424			651
>>  #define QCOM_ID_QCM6690			657
>>  #define QCOM_ID_QCS6690			658
>> +#define QCOM_ID_SM8850			660
> 
> 
> Why no QCOM_ID_KAANAPALI?
> 
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

the codename KAANAPALI is not enough to distinguish the id, 
for example, SA8775P and QCS9100 are both lemans but has different
id here.

Thanks,
Jingyi



