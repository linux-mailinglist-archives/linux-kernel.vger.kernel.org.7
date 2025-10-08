Return-Path: <linux-kernel+bounces-845271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C6BC4382
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C8614EF378
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0272F5A05;
	Wed,  8 Oct 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MxYQueV2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59E2ED866
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917248; cv=none; b=teOTcqsGIacKxXsarUhKUxr/qu6r+13iJly1O9Ml+7vsn+OxdzDRB/pCgz9F5rlzkEqVZlzfYJexv7/xWy/EkwEmZj04Jr5CVDrdrUzLQl+qbUGtjIb7lOhA0WNOEXdPED7VhbUNtYp3D6hC+kEkWcR0vO5Jt6SfPEHarCzun0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917248; c=relaxed/simple;
	bh=1CQtlEWAmGoK1pKpKe15XWPh3wub4+1F2ckrxKV7f1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO+Sxyg7VppAjZd0y857TceEZZ9SI3IcgsekUTVOwueF4jXQZ0CFw33NjPvdifpv6kuaHpRVL7Lymk/GXyFgzJ+fNs8yWnhbcHmNPkYv3/RedsqaYwf3/Z7uStQBUcU80KsYgAhGa6b8YQXI1d0Jxc4ySQWwJATVrKSDdTjRqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MxYQueV2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Oq7014204
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aFIzjuGgDbnK2cw8+042MLhfbBNRjpqs1JtRKpKEdho=; b=MxYQueV2QahWNEQl
	sizcDke5goe/47DMk1wbY/Psl3FM+MfEEDbNA2Mn/in3AMLCqODCYWSqT3xiae35
	AA01bT2lmjt27LeUvwJVsqHi9DLiYDpInPHfss7SITUB/uchwOpwYBBKMso1+mUz
	uW1KoMg0cLSyuTDA6oommCf9mg6Xx0BXxnwfpFL3V1TVXgyS5xvjLU/bbqmYt0Su
	HrQpykT+EaeChT4VdTxavfiRocBhkeYnwgpLosvzcEzlzpY/XaFMco+NesB6VfXz
	6Two1fn5a1kpzSJUyr/+VXHJVnRg1cx5bnxmVnrYbB9BJItce3aKZ27Lbig2+UVA
	aOsLgA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0nrg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:54:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27eed7bdff0so9848715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917244; x=1760522044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFIzjuGgDbnK2cw8+042MLhfbBNRjpqs1JtRKpKEdho=;
        b=nTQOwTywI6nSOGBmAdI+/LAmqGQil804HdceRmSYUFgvE9Pz8US8zWxvFe9seEJ33r
         f6NLGsfl3Ym1FpLnCC72PVFSYf+HEE5VWYDqAS9k96ilaOpnMu0sk60Vrd0UafQ0PJTf
         VFMja63pQy8DgMpN7tsxvD0CQlw4IymQBEWWFc75FdMib/2L/ibqOl1BS4tg1V/Zx319
         Ip5cXgeiMBjOVwHXhwWTNC/rqK8v98g/4QDteqFeA21QFp3FPJ7CXg5lWJkfuEDZB923
         nGyOJvGzLg02x1zAVC2eFsyijISqtS7D0DEssElA7UXjBMvnQUwIkhMTGgr9WT58RhiS
         rpMw==
X-Forwarded-Encrypted: i=1; AJvYcCWvzB3uNI12t8/06x7x/u1DtB4bPzKKLxk0m0zmorqyKe0TT4iHu+vxhOkrx3tlTToo5aIEkQZ1RWVyHT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4ndJDrfNRIOXs+a1eBX5sctwOcjB4B6nvXdL1y0ziSmM0tbt
	7LBnJbKuBZoI7SB5zKsg9LP5AXe0/agEWed2ig6+OQONMEzQ5uwH8mMCY/9N2MdzsEThzIjh4DZ
	emEiujhKwe3GfnBKgukQMR4wtvh8uVDsKVfTDFrzP/7WTRyaislKQ7P8EipcxaYOHZMc=
X-Gm-Gg: ASbGncvbAYb+73ibysp+2hsOBShmj4tOtrkIviwyW8l5yhj2mc8ot0q36r9x61J3AXo
	Sv5QrUSrfkX1V/kJWQAIe2tjnH6oiSWqkynUZPkbJA0ZyfpeZJxoMkbWzJTyDk9jtE+t2hcRbKR
	3fND+YFA4nh9fJLnyf4VSAI4Q7uW1GWHvxt5NL+FsVZl8q7CIG1LzE9ds/UcYpb8NYkNVGQyNAH
	g4M6X1WXSdhpSjoZNZ1VbEqdkQ8rGsr20X4KVNWwJnp6np8egK6jXOFq10tfT02Pex/EoV4wbj5
	JwqnL7cbWpj+HaX+dZxKyBBz4HqTcOXJkjuKngOFCA2Tpf8i1w7UK1v9+MzWP54ZTvuXnA2IJFt
	0oVGQ
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr77582185ad.16.1759917244044;
        Wed, 08 Oct 2025 02:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjlMcCZKwjgYLPXDCXMSmausWa/VxmHFDQuPR+sRg5qtn01XXj7w6EtvhXg4/+h696ZfGow==
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr77582005ad.16.1759917243499;
        Wed, 08 Oct 2025 02:54:03 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.249.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126ad9sm193842195ad.45.2025.10.08.02.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:54:02 -0700 (PDT)
Message-ID: <12edddcb-7b98-503c-c5fa-3acfd3bfe5b2@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 15:23:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-1-e323c0b3c0cd@oss.qualcomm.com>
 <nuunkv3xwfes6wed5xf4re2efakndvvrfl4lhmenilkic4sjiy@5cb2f5ygegvm>
 <522d7244-0003-a42e-9be0-1d353df8d5bd@oss.qualcomm.com>
 <oimuo26ohcye74j6rl5hfbmd4ip5wzudhyiaibf74b5zmjb4vl@xh3dnp7gmvq7>
 <7c6ab647-0c54-4480-9eb2-5c2bbf5f857d@oss.qualcomm.com>
 <b5d465e9-e84c-fabf-f275-3d0a5abf764f@oss.qualcomm.com>
 <2ppixuzddqmpa2d7nkvwwbfn4dnt7j7voyqfqcqeokbkzjg2lm@mokv4cihiuw2>
 <27381eb6-18b8-774d-5171-6326dc6bd9b4@oss.qualcomm.com>
 <09d08a54-2a84-42db-bbab-050dc1487f6e@kernel.org>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <09d08a54-2a84-42db-bbab-050dc1487f6e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hY75S2SNKGkxDCFbVE_ecJi5D1xaNQkZ
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e634bd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Qj1tmCQJ68Tb3jnDqiTdDw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=xDDSp5OMhEVwG_PMfckA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: hY75S2SNKGkxDCFbVE_ecJi5D1xaNQkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfX7pyJY3srUak3
 BZZu766e1cqy7gljol+bFNVmEnwanABkursZQIh05WaihaRGRqLc6b2Zc0iNJVXNrebahJS5qpA
 e2Ou2NifDylJVnAxJYlY6P9j3KH2wPY8xToy7RtmO94Q0kvphkHE59Vb+u8u937TlmdjzskhYzl
 LaHLGFKf5S+2qeT0PtwDgiBwBe5z06byANzoky3yM9g/JDsaPqpy4W+tHOPjzHRom6EpwRVnab2
 dhy7ZjrYM7PchIELObfBa73/45HJEVmQr2FuJwhqZgZ0Wwe1FMxBMEc5FYYNRyYGZN6hwiSr8ve
 rU2oea1F5NUXjBJRuUAGvygRBPRSf5f3dDIpAln263BbcNTYUJqg3B6rhec8S+n7x2Uw5YB4cVv
 bhk5+PjWhhO5mHf+cuwuzza/lsNOMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123


On 10/7/2025 7:28 PM, Krzysztof Kozlowski wrote:
>>>>     then:
>>>>       properties:
>>>>         power-domains:
>>>>           maxItems: 6
>>>>
>>>>     else:
>>>>       properties:
>>>>         power-domains:
>>>>           maxItems: 7
>>>>
>>>> Also, what is the downside in existing approach where we say that the hardware
>>>> can be functional with 5 pds, and 2 are optional based on hardware having them
>>>> or not ? So all combinations of [5, 6, 7] pds are valid. IIUC, the optional
>>>> entries are made for such cases where some hardware parts are variable, please
>>>> correct my understanding.
>>> Kaanapali hardware is not variable, is it?
>> By variable i meant the hardware is functional with or without those bindings,
>> hence was keeping them as an interface but optional. If that fits into optional
>> category, i can keep it existing way, otherwise will update to fix binding.
> You describe here how SoC is wired/engineered/created. Can you create a
> board with the Kaanapali SoC where the power domain is not there?

Not in kaanapali, so it explains if and only if the same SOC can be created
without those specific wiring, then it falls into optional category.

In the next revision of this series, will keep them under regular binding (not
optional).

Regards,
Vikash

