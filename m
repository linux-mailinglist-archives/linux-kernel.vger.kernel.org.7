Return-Path: <linux-kernel+bounces-835787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59114BA80F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C25189B143
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AB2367B8;
	Mon, 29 Sep 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUR6oTCR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272E239E76
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125981; cv=none; b=kk56vRzjAT2MWLIbFprboJj/ocNIRtSYbLtS9TVbeDZSEZCOtKrnxrAuA5Jh9u2dQdMcZRm5Bha6HceqfPUPkVpK9erAp3PKeY3vAU/T0wdWlOGBjRdxv2jPoIXxKXoyF+rero7qP3AAd+cWBpWiNfEvlubvi5werFM1bi+tOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125981; c=relaxed/simple;
	bh=R1hOZFlZFY7ahQICoW9mfCD5k6/twe3bR2ww9vrXT3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4g9wtAtHMC1dN2jCkETy3iGTyOuzKM+ShpmVgedx0mLqykwLLvKf+TWsUexfYI3IJD2Yyb5JN4BNC0BVzruzftERNawmCK6R1wt6iqDuadoJ7Cd6Sv2Sfgj9liUSFcSFRl2jFHXv+wjWpcVHdfFYyHyt5eZrDJhEaGq+h0eswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RUR6oTCR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLpgdQ005609
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q0XpjhlKCQT5F8kJy8PyiFfpDsgcYYWrp+FmjNI18ME=; b=RUR6oTCRZ6j8OWTe
	v9adyTFiwTSoxot/syatb/FF3ga2I64NuyGOo9SWYM+Ek8ACA1Z60RE3qz6BuEo2
	K4YFA9pW4r/NM++KHDMxns5/E8XekFWRw2b1vXSi1L81uB4doin5jaNELEegAXtF
	rpy0dK2sgL+Om4dVsKlVqdVtj6dftwlBFDvCXHFdsSNYAnlUI3BupaGHt9zdV9+V
	aQwQxe1iYq/z25oFzje2Uf8cDUGZPcAte0yn2JewRsFbQEzSEkAy5Dn42jF/EKV+
	nTCOziE30UDvXFbA5M5M2pEg7r3zUhaycNJlBEwjlmYBvLN0HDyhslw/ISp7yYbx
	uFngAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqv3p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:06:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-332560b7171so3953457a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125977; x=1759730777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0XpjhlKCQT5F8kJy8PyiFfpDsgcYYWrp+FmjNI18ME=;
        b=NuYdJYtQdMRV2+zw3V55hZB4Ds4VTpRkmN42cqPF2lhdLNWOLP56IZpgi65WbvBzfa
         oJTKA+fq7tP2pXr+v/PRu+KxPk+jSeOTCPxX5UUVJzIiyRuZ0EFbAab/Ms7kbdpcuiIX
         9j5fq7wWbDPe8m0ocuSFhHdTOp+okd7KYgLDlJ7RprgFtaBuzd2wj84nCmMbub0ztUZO
         HrArmqqZ80x9RnUYau8o9xDHH0nUwm/O3/c2sE02T7vZyhiemNBn9O4uWFz8WuWCyTY5
         b5tBNRQKUCr/gS5HSb/u2ulqC0ovHsWW4HP/6qKr0FUmMp8ELv69TUwRdRnKO+i6aExr
         sARg==
X-Forwarded-Encrypted: i=1; AJvYcCWqxItIqQqooEtRDFM63LC0Mz4FO5c2S6+gem39dw0N1Cezzs9iy3q2l/uWz9Qg4ntrfXKfmxD7SWBIRTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DsdyslefjdvPBwsMjfksIlYep9q8Yi2g/iwBGWSMi9A3WI1s
	8yYEXnvt/OcGmv6GWSV1RwTIxJeFSqRl+2dso4bMMeOuChnPJC2xBXPPlaR1+26C/ECP6HIaNaa
	pz9RVEgZjlntBA9zvlYo5dLQK35751FApovOHKrqydgT4LW7dVXvhy4QG9NPdPQGTyDI=
X-Gm-Gg: ASbGncszz/YnkFly2NDWZo/ksHS875NN74cer8DViHWPv7R9B4skiEC5C5AxzQlw1GU
	SpoGwxT9CK7VV7yLegyFdQ2eLjzdE50+5DQVU3qVsJuP9YNQl3lA3/S/SV0tKrguTWKIz3ZpbYV
	vcChzaSHEfSlH9+uzqZoKciZlp1U6oBEyEsHvI5zQpQQiJjYhIa3l9dagn89nAFeoV9KuyHMUs8
	gxQb5nWl3nV2eFiMMWvZWQbQLa6KqabjWoxatEOXVkH427WW+kIPBRzVorWSWbFP1UJuQFVroEa
	n6oKU8pD5IdmWpL0sI3LVQEggOiu8Keq+8sutmFeBaLf8rZz3qwb+Whpl7l0BvOz/5uIN/3u9uK
	A1/CxnPYLwPzuuMFpzhh49pwTd7I5gC2KTBQ=
X-Received: by 2002:a17:90a:dfc6:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-336b3c40429mr8314079a91.7.1759125976472;
        Sun, 28 Sep 2025 23:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQVPf+oBaonVnZ99jEvDhUwui7DGxCtnmjbrzMR45Ek6O6rY2D4syi0FnP3OVmzqjbKW12UA==
X-Received: by 2002:a17:90a:dfc6:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-336b3c40429mr8314045a91.7.1759125976021;
        Sun, 28 Sep 2025 23:06:16 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-334326758f3sm6481957a91.2.2025.09.28.23.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 23:06:15 -0700 (PDT)
Message-ID: <d374036c-1263-42f4-b9ae-13b21427b01d@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 14:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali ADSP
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
 <20250924-knp-remoteproc-v1-1-611bf7be8329@oss.qualcomm.com>
 <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <h4lk5psnwx3ma3um2sozhcdccwhmgmbje2lgjks2czcrzn4mre@svtnbyzvrivw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VWuCKEbZZpDhfuKA1X88LXa63mi3xuz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX3Fn2ZNVDG0tz
 jHIjWu6351WI5CBQBLvuXYncMXAg5VSw5SvupwRLiHlMBhBWgQH84K5iJmnTWvtA6NdgBc/+RO8
 mOF2QsBZ/0IxJLeUU3CrWfNC/AOIAwlPm8MHIHK7OXXzwgI/O05Wk2PRwXtGPda8TwG3Jag3bTX
 GFz0MIVPs/q9wBiqGwhW+2nL8QzvqwPnNF+wnjvc3HFiUA3tspf+ZVS4pILic1LNM7N0Sm+rKyJ
 3QX9PB4UZNrCrpxwmSJCMyTVAX9dZ6PlOOYGboG0c3GmpkkcFraqrcmPIejuVMXI06ZvPeHr9QJ
 G7pFC6o3+TyF1JdisRJ8q9lGaCX4Yuijx6D8pQ/FrRQbQixZD7kT7Md85X83Y0sPyt3QFoikFac
 uc+zzXjm0Wmt+vhV52HNpCDfpOtw/g==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68da21d9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VpiTcBU3MjFUXm55aNAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VWuCKEbZZpDhfuKA1X88LXa63mi3xuz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/25/2025 10:19 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:37:22PM -0700, Jingyi Wang wrote:
>> Document compatible for Qualcomm Kaanapali SoC ADSP PAS which looks fully
>> compatible with SM8750, which can fallback to SM8550 except for one more
>> interrupt ("shutdown-ack").
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> index 2dd479cf4821..be9e2a0bc060 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
>> @@ -28,7 +28,9 @@ properties:
>>            - qcom,x1e80100-adsp-pas
>>            - qcom,x1e80100-cdsp-pas
>>        - items:
>> -          - const: qcom,sm8750-adsp-pas
>> +          - enum:
>> +              - qcom,kaanapali-adsp-pas
>> +              - qcom,sm8750-adsp-pas
>>            - const: qcom,sm8550-adsp-pas
>>        - items:
>>            - const: qcom,sm8750-cdsp-pas
>> @@ -95,6 +97,7 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> +              - qcom,kaanapali-adsp-pas
> 
> This one and the next entry are redundant. Do you see why?
> 

This one describe the interrupt:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,kaanapali-adsp-pas
              - qcom,sm8750-adsp-pas
    then:
      properties:
        interrupts:
          maxItems: 6
        interrupt-names:
          maxItems: 6
        memory-region:
          maxItems: 2


>>                - qcom,sm8750-adsp-pas
>>      then:
>>        properties:
>> @@ -185,6 +188,7 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> +              - qcom,kaanapali-adsp-pas

This one describe the power domain

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,kaanapali-adsp-pas
              - qcom,sm8550-adsp-pas
              - qcom,sm8650-adsp-pas
              - qcom,sm8750-adsp-pas
              - qcom,x1e80100-adsp-pas
    then:
      properties:
        power-domains:
          items:
            - description: LCX power domain
            - description: LMX power domain
        power-domain-names:
          items:
            - const: lcx
            - const: lmx


>>                - qcom,sm8550-adsp-pas
>>                - qcom,sm8650-adsp-pas
>>                - qcom,sm8750-adsp-pas
>>
>> -- 
>> 2.25.1
>>
> 

Thanks,
Jingyi

