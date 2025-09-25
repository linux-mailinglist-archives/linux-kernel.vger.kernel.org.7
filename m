Return-Path: <linux-kernel+bounces-832441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A705AB9F531
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D5F4E0FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710E1E832E;
	Thu, 25 Sep 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Shfztjga"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D311DE4FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804381; cv=none; b=lH1L/QkP0ATA1YgHQ1sprvnkEnPvkK3NE7eqZGb8iX1yHCLuJIkGDOyU3BH2oVrId8Am5Qo8oH4abE6Z4DMmPXZ6GZMYA4kGbIxJ35k93MLEQuG+9qib1nOyDkhIWO4fFvPXLImig9fetCy/Zd1XgGHHGNFzGLM98StVDQC7AzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804381; c=relaxed/simple;
	bh=b7+0FUqc0MYeklzSPwrXmiQ+m53hAJ9Fa27fFR/T4ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9m45nwK/HoeLM3a2+OdMjzjjKPKYDOLRgFHva3fQEpnK7s1yKBuaRUCE2zAGE824URAZysjB6/E/UMwSkig7Z3p5Qo9/GpGObVUVIRNVyDSOKHTa0DqJQYti18F8MuvsJ8Mx/vTbHHGJRc6YE7oZGdCyfI1uCyOgdyeBtpmTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Shfztjga; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9D15O023762
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eBfKcPb+IOlBSzmdNVDaaI4Kshn4SPqfBYjmmQnheSM=; b=ShfztjgaO75BgNn7
	pLyJaT5YjczOEprODBf+Zz6e0usexCvoR0H9cKQyrREGlXfUGh0dn4TO7ywgxrWz
	AjunhbAt8yAiwjGQHhbH3MFe2SdOMgGiIx22evpvPtXw33leinyF6xfEhXLR0hnU
	ZocwlauamUiMIqfeHWJy/p80t754unpPNXPxppmT9xXr6GX9kpGIN00Aou5qQtDk
	o41cb8cnsNBYT5SKyv7jQRDjiA2I/LmDNykiEqXdqkriDfQ9uUHu5XwZW200+DtK
	C28cIbm62A2fwLs4r6l/+nY1NcAees5pDcntdahKmwZsSFwQHzi/1JS/h2cr4L6G
	3fW6zA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0f4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:46:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso2031026d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804378; x=1759409178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBfKcPb+IOlBSzmdNVDaaI4Kshn4SPqfBYjmmQnheSM=;
        b=XraEUMaEGp5kAbFW956nkjT/jD9mlLT/DY15YbFTG3mf2RWFudl1gPPLb9d6tCbyO1
         HNA4IXc8+HiGoTeVqnQOi7b4LrglJdnUU39k6cVFY3dImujuO4K8PbENzjkbceifeUaU
         qwldU6s/TjhbY2j+eP26Dx5iBdpn4CYanAkGuvX+shUb4zRicHAInyjM8aXgFfZHzf9Q
         4xoAaU69k5jrQzJMQkiwYTMrG9WzomFvhIH3+CqKfYZvGVrmXb/hdzKVAVtzar4G/j3M
         SvzicAYtw+/eCjlOkoBOgFThOaK3MditwoxCvY/KPG7JqSj2HiEopRXw0idW+nDjeLfz
         Ld2w==
X-Forwarded-Encrypted: i=1; AJvYcCX13L+z2XcQ0BLn3vHFRpksacr8dvByAl1eRXt+3gUlvK5iyGKLUDa1gltnKYtNG9KkMvj2x4lUhpPlJJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+RbJQfUw7hfHGQfDlvlj3M929nIqH6NQG1C2tJ7iMtTW+8ea
	6lo/Rif0oZPGmcwa9cAg8Qy2hVOaanPwtPr+i9FDMJO6bnkoOYzT01VNYv9A3UEiztlKkXnnm8t
	0aiVJhsZjem9vEC7nyRyP2Na2YvnqF1ofw8tIPK47OUeBiXeYDTDru6XS1ObcTh4eRHQ=
X-Gm-Gg: ASbGncu5EY2YxdEDCORVwFWgXOVH0ua2aD1AMDBYWdPJALh2zqPGWEIUzS8kS80waLM
	hxUzXwpN3KieFqtxX5rGwX0Ze/qLYic9xCN9I4uSucd4wYPa5X7YKm/wPe2cmQLbZrZAanijF6j
	ramdU76rI+CI+vcnK0Vyst7y73dUli+0NdyG0nJNbQ/5kRBqVixnqRj09cngNu+hO0ddrF3BAN6
	KELNxlZW+XIrsaJC9HAKLF1DJ7lvyZrGmqUF6ph7RWUYw0JiNDAG/iTxziaGvPE180bJ5D51LJV
	2wCwNAbdzWSarwvaJ22eqyt/EkiN9WYF4Hexee//vsy9uZScBg0dBZjicsUgNjW9GkQnHE5FMyu
	qu6G9WqNsEpQHSFtsebfKYg==
X-Received: by 2002:a05:622a:1905:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4da4b048343mr30697721cf.9.1758804378075;
        Thu, 25 Sep 2025 05:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd5JvjjG2pBr13XQCrzkjzaC3gf49ULTcdScWZxwe/IXNnSmnRT5xxpfNzh8Shpav4MIBYKQ==
X-Received: by 2002:a05:622a:1905:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4da4b048343mr30697331cf.9.1758804377616;
        Thu, 25 Sep 2025 05:46:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d1210sm163567166b.9.2025.09.25.05.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:46:17 -0700 (PDT)
Message-ID: <623d9895-4087-4419-ba6d-b03c55b0ba50@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] clk: qcom: clk-alpha-pll: Add support for controlling
 Pongo EKO_T PLL
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-8-29b02b818782@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-8-29b02b818782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d5399b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=J5jK6kj7L5UlLF6NqaMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ZjdgDnMPU0jzNBHnbyXk7wZl_Ded4GkC
X-Proofpoint-ORIG-GUID: ZjdgDnMPU0jzNBHnbyXk7wZl_Ded4GkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX+i1uxxPG8bsg
 E7AgQuQpeuM1yvBHo1okSVEPNd0i2yT55WhCPoCGktMZ9EEePs0y/WtU8GKIpvJA44U271BRVHc
 tptm8Ys2jYAfxB50+fNcZkStTUPk1/kBej+OYF58tYHZWJCQirLBYOfo37xlSmUZoBQ3wMka6lx
 TuRH6COg2msQwS9JTp4qQaHWINkFgT6k66o1TcbV5N5HseeFW744pgnN7iOjWgwbtHjcZqRYq+s
 UTOmqVysO/yXjAvDS//0KZITj1YUwEMAnqfXfk4O8vAfFUyuN05o+/VwiAaJ5poLtmrQl+Us7pd
 Dk5ozfPStooTN3yz2PLu2YI5GON6zxSZZLsg4tGZYPUhL6kczjSgMHfmyPIHIOdzVPNo6YtPfCx
 D5QsptIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/25/25 12:59 AM, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add clock ops for Pongo EKO_T PLL, add the pll ops for supporting
> the PLL.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

