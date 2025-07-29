Return-Path: <linux-kernel+bounces-749298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10496B14C89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8863B5DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500328B7EE;
	Tue, 29 Jul 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etLanObY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031C28B401
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786179; cv=none; b=Jpl/cZyevcl/QbhoKN7qM8SUB4rh+LIQw+fyJid1nVcN5NKkF6Q/EJrccXQCkO8ZkTpcmS0DeVciQ8shohlQgL+XWbr5Qlpkw8TKf+hEyAQZ+B5GNk1A8Hbx0aRjPvUpXjE9w+Jc5tXjleslrWq/a8eAcc4iOfedrSRAQmDwW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786179; c=relaxed/simple;
	bh=3NjEr949klcb1iGBUHCvKsBaHUyDI+r7RHxECamMvxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnZlSE391aVDmvWwVTyCqaBwawTuvuc7Yl9c1KpX9/Bi9VyPhlfpsk4cu69g2mg8Apqe5tOXTadh5/5cSzIKLNqtwKHTXxsYG29muHssMeDCklrZ/xLFrIN3ZZW4A1SKubtHkQ1Z0QdBvpFtP711U9Hxh/T3iUPDF7T5zBzzEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etLanObY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8kNYg031280
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PkaxQrVa3W0fxICjBisBL0T34FtsYWW4gH/vbW0r5IY=; b=etLanObYoN0FHF8M
	tCb6Wi/II1hgH+MP0T91I2lskdN7C3WRuvs8y4I/j/0XOzKB4At76gt93SjLtmpA
	VsN32ukeBKHu31t3XOcnj0YlEtB2PUlAnY/pK0hksYvYnMvs5OS+EBuQPyDOdI/C
	crN7ftqP1PM2DsvE5dmNNjQgz3hxyYhq3Ro9XvtdKQ0ltl5cx2+qEIRSufrKqKLK
	uPHtRkxjUq/ki36QlFF7tyKEZ9N5Yseqq5WYGcmHysgvZaOqp/N+G3x4nE4FuOVj
	pdiDPEvAshnNX+GHUpt5m/UmNt7w1c7lbYVH7TEqJVB+U0S90fSc4KnEd02LsWo0
	vOI/+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xd65y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:49:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so50824285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786175; x=1754390975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkaxQrVa3W0fxICjBisBL0T34FtsYWW4gH/vbW0r5IY=;
        b=lXFX1hEeAsJfbl6UwDuSgU61mVAaHppa+il950XVvNXN2H5zzUGBEB5YvzEuA5dn2b
         ewjQCV1frUT64Cwazg50qOK3rfvODxYib2T2XqxvY3RowL9MOzjw5nWk4LS2jRIuHt+r
         jFqQ2sGY84ksATLd3hcwtrGgbg/r0rqD2Hl3y/9cOhdpq6b76nU7d7q9lRxRsNWaACHG
         iNK+ojmWcEJbetn9vtFZ0GFrV5Van9rDOsh9WHqcsIyhM/LFffxao+wz2lzThxzilmn7
         YK6B+akpe5wTX33TaGvZRvau2pDNoD2JzI98EDiJTLr/c7kgFJEbic01XMaod9orGJAT
         ZqbA==
X-Forwarded-Encrypted: i=1; AJvYcCViJrdSPtj2C44vvfCp6cq0qbC1KCF0V7Rt+EASq6KDxXOmAW+BxD5JECcJJe5MfUMagAYE78AmnjrVdqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtsjLQ6yDzCdNsJFwM597OcLs7gol/tgi829pfdSl5Ldb8rkL
	8z8Bg6XX+F3Mkg4/mEEvM9VixD3huKSLj7vuP4JdtJxiWILAYpbtQ7obnIomT5hVRDF6I3Pcs9H
	LE/GWYqY2lOf2eAG9tRv4gp1YwbTL++1mJRS3/3qUr9Mjf1zLDzpT4HXlzeuqfO9YYec=
X-Gm-Gg: ASbGncvxbD0dowxUUnvyBPzQNiRMwR6J1faZai1B6V/mwAPc3GY0Dy2i+IAbSe35hYE
	qw2yyuHrzUs0bvTCNnUq8QFAwHns76m3qfEdfpI1Je4lJydHHuS+9jE/2CScs71Rvo/5CXRx/4/
	1AfN0X542itoajSg2ESpLL1fwJ9rhKKlxOa1agdM3YTF8101iBVQCaIlhHzwmGqzpu+FtNkiBcO
	mqUm4V34wPgZYHpsoTB99Yt38D2RKKGwA1B1Bb+LIz0NLD3wtEgM8kVMfTPMHlweoY9ksjMEtPB
	ABPPs5IyqsIJjwG9gMYIvh8+OJI0Vsf6ZqmDrzWnMLpp0qHjYi0SrdM7CzQvDMlty6s1BbYnhln
	8UA67KIs3yypE4Z9KOg==
X-Received: by 2002:a05:6214:4a51:b0:707:4020:8631 with SMTP id 6a1803df08f44-7074020c508mr39353586d6.5.1753786175193;
        Tue, 29 Jul 2025 03:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET3lprW3Hl+UblfFO22E57srKZN9s6YGNunKASndnP8ZoduMXNySxnL5z0zpm6nnnqWds75w==
X-Received: by 2002:a05:6214:4a51:b0:707:4020:8631 with SMTP id 6a1803df08f44-7074020c508mr39353486d6.5.1753786174855;
        Tue, 29 Jul 2025 03:49:34 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635accc38sm560388766b.114.2025.07.29.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 03:49:33 -0700 (PDT)
Message-ID: <8b30c83f-5f35-49d5-9c37-4002addf519a@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 12:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
 <25uelsjuw4xxfopvfn4wvlj2zgivwbjprm74if5ddwvht4ibfz@yctc2kvfmxyw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <25uelsjuw4xxfopvfn4wvlj2zgivwbjprm74if5ddwvht4ibfz@yctc2kvfmxyw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4MiBTYWx0ZWRfX+GlsBHEtoRIo
 PyLKEbtD5dsXFBP4e5C1AQlQUrR6zlkmEVDnsoAwH27LP1Ho2rbgey8KE6rxxyLua+T1LI2UwTZ
 4Z5NXpjt/0xV/H2vzycNK/ZL1XZT2kWC1Th16krl7WV9R4l6pm4HcxZqJzfcY5hP99sNiVXESpU
 YVAZ4K62MmPMagX5uODEJtDNbF1TwiuLHB7Rv6+L4OvrqxJa1EAWRC2m7tmYA2w3HBXe07JOgBT
 +YxpTktp8PXkD3QdzYdnIad96o6yZZnJEdiL0EvQBo2LhPPd7PT0H2Ap+rz2+93C/61XafdA5sr
 5ZVue6vVlQkeQ8oDAVS7T6M1cKb4ISREUGtuANRhFkImZFUR+m7LG5VmfR3mBdedlA4Erl37QPu
 tHtTi5hByNdOpudEvFOd7Lp/hBNWoY+33Z+YE9lGZq64boUpAkvhYklbGYroTLMepneQxmAB
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6888a740 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=N_I0jeO3kqKEb7emQd8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: FdAJrMGx5LNV_J80CPWOXPlnRp__wgfT
X-Proofpoint-GUID: FdAJrMGx5LNV_J80CPWOXPlnRp__wgfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290082

On 7/29/25 12:48 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 29, 2025 at 11:12:41AM +0530, Taniya Das wrote:
>> Add support for Global clock controller for Glymur platform.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  drivers/clk/qcom/Kconfig      |    9 +
>>  drivers/clk/qcom/Makefile     |    1 +
>>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 8633 insertions(+)
>>
>> +static void clk_glymur_regs_configure(struct device *dev, struct regmap *regmap)
>> +{
>> +	int ret;
>> +
>> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>> +				       ARRAY_SIZE(gcc_dfs_clocks));
> 
> Why are you doing this manually instead of using
> qcom_cc_driver_data.dfs_rcgs ?

I guess that has been merged last week or so, so yeah, please rebase

Konrad

