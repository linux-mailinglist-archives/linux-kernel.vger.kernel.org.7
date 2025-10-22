Return-Path: <linux-kernel+bounces-865408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF6BFD00D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF274EC8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9305C26F2A1;
	Wed, 22 Oct 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CwAZpgPZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B03253F2B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148976; cv=none; b=hNoxSXzJyssKYIfFUI0zObU4heFg/g7y3OEEE+zSMRwT+Z9fBx+nOb9hUUeCtjaHaYk0dkiJOMb+oRjlukE65dk6H/VQoOdYIQEGweF3udSVQEvLphqUZ6tTo5J0kvFR5DJnqKfrLv3fJYZ5isQymdcnvdSTxhrbrGFxTROJ1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148976; c=relaxed/simple;
	bh=6/x4q1TD0Vfpez8lZM9NmTtdfX6AcobeeOsSKpt9cS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkMLjWej/dw4LA1IdfWXWP2eYHU3ez4/ZhMdja3dhYky9iKaNcaRMnaVKrNrubi7YsFICbLXWeMG6Pfl24p7E4CEyyStDhWVuHUSDGbs3O0QOq0FKMWfBlmLKjVj/jTckouQOs6gNjbvghCE3kx5VFC0gU/vXr2rUQM4aa4zudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CwAZpgPZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBclcA027302
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uJi0OYMjtb7TI5hXccKCsroVX33ScGfPgbLnqsYifaY=; b=CwAZpgPZtZC4BmqH
	S6YdD7pK7D0ZZCn9IhbE0muq0MxaeOM1MbxkGWbFyr6cidsSuOPU0FEn/AtnlaKS
	F4IgLX+UM00QDAVPT3B5gY54DzJprP+89jX1Hb/gLqIS1MAvspEqrh+mTO3fGkiW
	nvOOCrScUu9xrBAYWwlA4mmgRITCR1EgFP/3WyAXuR0Op0g9XD7RvUJrCGTsbWnu
	LycPKgqEAXyJEEFcosF1wGk6/642GlfHRVzLg+rUjImiKvrExgvyyNGjJN+YKK5F
	VcjC8bZ1hgSvP7hW3cyrxjat1J0Otl47trdIXREPBaF2CGFREA7kcyvHt+YNNhGp
	9PXHhQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j56au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:02:54 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-554ec61ecadso401283e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148973; x=1761753773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJi0OYMjtb7TI5hXccKCsroVX33ScGfPgbLnqsYifaY=;
        b=DsVYgX+zYk5V2apPUdMhyE5ahmr6UV/UB5ZLxLANk9APmn2+iF2NC/udnC9mCmnUKT
         C6fKXaEltejnFxDtU/UrJ5BrWdIDEHst8mHaXt6jgz1GmILQ0ufZYaMcJSvMZoC61+e3
         Hr9tNKlyG3sN/cBBJLjz93uwZXTrQKQjeWYrbHdD/sv3L/7NjNnMyICsbPG6ytrBMkSz
         pEvPFxKy7F8YPUqUOcqAgeKEeva9TBqU2IRqCMd8eK/Q5lzUTBPhepgJURluOktPlYyW
         JX31jIPeA0yMfaMFrr15zZTyWtjGx6zCw9dXamGUxfSswQuJkFxZfpunmflIswbwsXHp
         tF8w==
X-Forwarded-Encrypted: i=1; AJvYcCWK2qSzK5oASaK+j/gyde8oyz2SfEQq1ioCTde+xF4MvU50xJY3m0IeNRYMvVaiQvNpFdKFmhT3Wj9MggA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGk5Cf3oDHMAAQW4P2afI2tAq6/TIzeACB/hSlzbtRHsqt1SYD
	1OR+utyz2Ned1h5wSxk0C1BDILSBEyffkJix6WE3nszC6zy8Qx4ajJ3wWKBJiXiHCv6+JTnJnV7
	2HE2UGpNv2W9xegdh1sLvLuikZjrEkllaa1h2AlLO8ixnYa8Z+oUhMbk6VDQQlRXkTPg=
X-Gm-Gg: ASbGncvrOM1KVKsbe8FMTruA9Ioy+j/m1QEkcrxUEUn2bAQekO4eNx2wNr1W2on0uBH
	ZMw4+5fH1GML5GScKmTAjohKJ2qWGLnzOBxPT4nLqLVvNEhy6tfKjWrmbwhcY0igxsbjHTDCrWt
	boJoVrCm95BfzK38Rnn1FZdldPKgBXxyVkrh0Wce5it1ns6dBeKWDgYWDyjOGh495cmUmJFu8OG
	H/Ihi7lj1LNHDX75a/qf+DTdOp6B7uNlN+l4/AsAGEvbtH63Rnsthu4Jk2Db/3V/iN0vAQtBTNj
	HxeDlxLAahnq3bqjesMVxnCTJJ8QpjkNlHkZFbEhOKAggxLclwxkGb7xZTCp2NafqhyI9F421aD
	3LQyuMnn1BrTiHkvrWs9tYOeYdfL9jAVg6DDZKfPBxyIH0lckYkG86eVb
X-Received: by 2002:a05:6122:e053:b0:557:4f6:869f with SMTP id 71dfb90a1353d-55704f68872mr118813e0c.2.1761148973031;
        Wed, 22 Oct 2025 09:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi5mRKbI+dib91eM8Z7Q+hS4s8HODIdacNkDVMa5lXczhBdSAgA5tmb1wtM5M/KDWuV6wPhw==
X-Received: by 2002:a05:6122:e053:b0:557:4f6:869f with SMTP id 71dfb90a1353d-55704f68872mr118782e0c.2.1761148972412;
        Wed, 22 Oct 2025 09:02:52 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb52603fsm1382657066b.57.2025.10.22.09.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:02:51 -0700 (PDT)
Message-ID: <4a4a24aa-d8a2-4150-a7bd-1d0a4b141116@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6150: Add camss node
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
 <20251016-sm6150-camss-v1-3-e7f64ac32370@oss.qualcomm.com>
 <b0224cd8-fe81-4229-94a4-c314c7b19811@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b0224cd8-fe81-4229-94a4-c314c7b19811@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXxg4A4Vrq2f9d
 OzXzdndNdTsFqOPmogcb2p27i/ugg4PKveHN8Il+U9B5iR7dAte/Jbd3jujAsBlnBKRpLlZgtEx
 ar14sMiGEG5D/Ya0QGtL22P6DFjv4oA6IUlpNAkotXMvBHd/22k0kSBiCxrGtDenLbYF8bjCIw0
 2HFx9VnqpJK8wEh9+kN55GeC+fYXodtLQBBM1O2syPGrr8/+l8fuNQKXJm1jPzhsTK7a9vQr312
 vvjTLMHJai6qqbcrLb7RoTVGxobsrYlqwPBr35YWE5SVf4sMFaqsalIzrjooBwbHZTSGUkBGsd2
 rf2Abeu4Pj6JcVO1OiAoTHkt4DFcp6fb3Iq+aEd7RwcLr9X9gELSDxVmXKNlKgDAsBkgmYCH9v9
 iFwfcbteOwTdUagoe9N0fiJA5Utnyw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f9002e cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sD1Uv7CbK0E5T9jcHE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: 2lk_wvk0BYJMwin8tzlFH8D8KpLucSbt
X-Proofpoint-ORIG-GUID: 2lk_wvk0BYJMwin8tzlFH8D8KpLucSbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/16/25 3:48 PM, Vladimir Zapolskiy wrote:
> On 10/16/25 13:22, Wenmeng Liu wrote:
>> Add node for the SM6150 camera subsystem.
>>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---

[...]


>> +            power-domains = <&camcc IFE_0_GDSC>,
>> +                    <&camcc IFE_1_GDSC>,
>> +                    <&camcc TITAN_TOP_GDSC>;
>> +            power-domain-names = "ife0",
>> +                         "ife1",
>> +                         "top";
>> +
>> +            status = "disabled";
> 
> Please remove empty lines between properties all above.

What??

Konrad

