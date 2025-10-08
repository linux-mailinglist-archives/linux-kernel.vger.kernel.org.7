Return-Path: <linux-kernel+bounces-845325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF0BC4714
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC143BE3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1D2F617B;
	Wed,  8 Oct 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3jdE+9W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC482EB86B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920664; cv=none; b=plojAYLBJcDKzwX39P/lGo8Vvd10NRSj3Czxxj4LNXAgB3eKlsFdvl1RmntKbHNbmt4qs99CssSrvN/etyR6j/I8pGE+jDB/dIpPv1uVuR31rAyyzbEdSDJER+a3rsPfyIhxz7LATaG/VKYiR+XUUux7dZn8d04M8if8Tr7+o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920664; c=relaxed/simple;
	bh=rCJS/DF0vAIK51Y7TrE45g6Mebgpbjw75rMElUhkPPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/+cnezJFYmkfkAIMkGS/INLvgHn999saSRZw6SxvNLtKgMo9oNmHrEjN0vvnTq1cG3jN/l1Rj0WmI3n9Sz1cGkcDmv6tcgcVdTCUcQrbY2jn/6KS82uXCyIK1WCUUDDQFDl676f18ZW/2idac582eBinG4fl9mzhYre4GdbpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3jdE+9W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890enh002274
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 10:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jfiMTH98PGOoSPZGb+t22lVD8sXYwM73ZIvPfeoWjUw=; b=V3jdE+9WAl1VHoRa
	nhSJBhLEArGwp7vQpNOl+Dkjj8LXh3GVFsL9yo7BZwHjnzG4xso7AJqVqVsfj3Pl
	liMT0HPFYuuK8qPQh2ZE6QteTEilUxczQOYPDqMSP4e6UqqJpKAs4oRhAHvIF3SO
	VyUl1Tl6fVbinboMlkZ7LD0eKwbJFLZxNX++XW9btnkQoFc+Vht8U2x2ExdkyVid
	81OaQXTX8YO5mNfCBkGGqg361xBLinONaRHYnK2hT7KY5gOhVVIcszxyABgSz7a4
	2n65Pf3XCfiWxdESWH1SK5SzMiClXislJiESx4lO5mwo6k6bdTbS5WZ1CWxE0N/6
	EMIG5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy724x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:51:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8643fb24cafso150822885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920661; x=1760525461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfiMTH98PGOoSPZGb+t22lVD8sXYwM73ZIvPfeoWjUw=;
        b=qxShfQjTqlBvhX6PBlgEry9BMuhFdCrDgKUQQQAXH81xASeUfvtG6x/GlefiI4rBA/
         WhdK7LKeCTOr4xRIB9NJNchaLWiDBi9dVmqUBPnqtqtme4VhcRO65FpQJz5SpM8sR7ly
         Y/+bwCnk3yaIl4I8c/icWhD8sJJt2soZ/J9S8KURXmSXRUR2I5ITfAUt1NOL8pOY/K/2
         IDHfUJoOv66KU81dxsYARSbHXtRwo846OuxIklpW5W87zDeRTwm8sumrKHi7aIT+BEqd
         MH/lSRs7YCuOqIooIUDt+aRUPD0P233QwOoZ7tDDn75/gYQe0haIBVEbjggFJQkc4RPb
         aQnw==
X-Gm-Message-State: AOJu0YyqN87+j5hk2UkbkeBtuyl8e2jQdlxX4DNEqm56MGn6k8OUmtBZ
	AQfam/ZonYAmVkordWcKVL5wQ12Ey3kHVvK0TqNNH+vwIHACh3Ws/l+K/nxhuksrzs9Z+g88Qxh
	qagZLopXBFzftWNB47D9nbeizoLQy6GDBf43WThAjSLmTrWbATDEHVGnUKqvWutcTAxA=
X-Gm-Gg: ASbGncsgBIyXwvbrmARKzdc5m4bKP97vHIFXWjvCKdoWVd3HUWJ1C+wAoTA/JoOWgrE
	pu3VCJNYvSEhEDyt1XKUBjNO2dvFvdgj2Bf9fLtNRMSBoUuw/MZXbUGNxA8puXXzzMXCgTNyzHT
	6ULW70aL2Q5+NghdDeliUSUqyg1nvr26H602+LAMF5DAsMz7dWRTCYmZFJqAraO8+zdZYgUaaKR
	AjMZwmOZJK51V+KmCqU/qPNcDETGndwAAMriT/iKDWwxmbioTFAe08cDSkdSIZzf0SM0+11hada
	ajbmTgW1jzavjwe2eolUJByDTrdJxf+Ej6ghhFOh2KrbOaA1vJ4/oP3KnvjWbWXKJok7hMC69Ub
	wmrrRrHi9QgouVsFj3JUMp1EnGsc=
X-Received: by 2002:a05:6214:4107:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87b074d2d0bmr26033366d6.0.1759920661261;
        Wed, 08 Oct 2025 03:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL1rSY/nbB1/t5g5hSYIbRk3avvqzjdnWKUPvH18AQ/zbzsVlznDqAFRvxOxM/XUEnY7OASQ==
X-Received: by 2002:a05:6214:4107:b0:774:48fb:f8f2 with SMTP id 6a1803df08f44-87b074d2d0bmr26033166d6.0.1759920660706;
        Wed, 08 Oct 2025 03:51:00 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b7225sm14212981a12.16.2025.10.08.03.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:51:00 -0700 (PDT)
Message-ID: <eb90f34c-4b63-4696-abf5-1d412d7bf263@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 12:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: qcom: camss: tpg: Add TPG support for
 SA8775P and QCS8300
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
 <20250925-camss_tpg-v4-3-d2eb099902c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-camss_tpg-v4-3-d2eb099902c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e64216 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_8ZK2gaWRgDgu38a0eYA:9
 a=QEXdDO2ut3YA:10 a=VIpMrH0tWCsA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: NrSHW92cz1swB3cBhVqNXyTOVu_hbG82
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX7QxcpRai27si
 hywlRtGG+sqs9EEHFbJPDJvJMbaonQ83O5rEWe9Yp0fNR7aNuTbfPo6enzsVckXb6wAhE/R+8+s
 5qJXsaidF4e4ityXTrtLfzwfGteoEp4UmkVKZ4UDk7sMomACKH+BCdhRBM2BP5K1CNHjCh+87s6
 4rzZHDwekLQOBq91enzc2KlMIb0oh/4w4Q+9V2VY4mKrI3avHRD4NmWlB3IWNrS7MkKg+RRqeVx
 2qoZ5tgE6HOUzvLyTfTQE/SnPPNp8xXFNz0Kc02D+fw/BQeJZHSwx/BpuVKOnWJyExX1VOrGrI7
 vDvkX1EE1AgNF3+DpPRTbYLmy+aeKEMMW300wEIepnlXHhBrMN7JdmglfXIo8/zJfYqTziCIIz3
 9u/GY0CnWsWrtndKfY3LSmweSscu3A==
X-Proofpoint-ORIG-GUID: NrSHW92cz1swB3cBhVqNXyTOVu_hbG82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On 9/25/25 2:32 AM, Wenmeng Liu wrote:
> Add support for TPG found on SA8775P and QCS8300.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

[...]

> @@ -4350,6 +4413,7 @@ static const struct camss_resources msm8916_resources = {
>  	.ispif_res = &ispif_res_8x16,
>  	.vfe_res = vfe_res_8x16,
>  	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
> +	.tpg_num = 0,

Uninitialized fields of partially-initialized structs default to zero,
i.e. drop all lines like this

Konrad

