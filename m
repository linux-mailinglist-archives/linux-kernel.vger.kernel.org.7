Return-Path: <linux-kernel+bounces-860176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE35BEF829
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D83BB0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B12D9497;
	Mon, 20 Oct 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DWI7b02W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B72D7DFC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942722; cv=none; b=ms3BmHrAZAHIGRB4/0+1SLm5Uu3F/wDunbr+kpRx1YSMvz3cKk5cVyM7m1hWRsw/Xr2+/i6NSlC+CeCJvTpEhmkEveSYtuuqRkLT0sUTQQdgWl47XlHLoK6q2iPtCJhQjKBdlKDfHM/kggzRGZqfKHItlwEBnbA7ZCN6IYusY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942722; c=relaxed/simple;
	bh=rtC3C9uGt4UHU2rn8ibGjqy0rKI3FHFok7NncAPdX+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaefISgOor+kKTJJeYiA5s+SeGj5/r4U6iIBZ+e6amfAcLJVLWuOgj4GcWmoy60m/ilDlQRer7cf1cBJGQUtREj4sp2VnSa5eZSpSR03oPSWVK9xxhkZALwsfiN8meM5w3pt5LPv0wku5ydJ2J8NvZXWeFl8KngD6WPvac+liqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DWI7b02W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JM2E6x022434
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3qj1hX2tzkLQMkkvq7DvgBbML5xuWRY1vxvwpXBVNfo=; b=DWI7b02Wt6xk/JR0
	JiZBjmIgHysOpmUo0s5EwtmCpscN2yWiLBDfqf+N/vQoo2HpsnpLxwVq0DF/mXy7
	SRDa4UhCdqUWSRZcVkFqtQloG9NwldcNbclPT8XqnHkOdkM92b4wSh5Jkk7z5J+x
	VVNkRcHtFVA2qr83Wou6OC3a4ZeyxlsF1MNP77jA0tWH3nnjZKnOcFWOxcAFHCrl
	ca5By6oyUEm3tQDlZ1vwkPfc04cR10AotH3GU42M0fff5sIBLzZRkFib0MBfLSJj
	Ph3MGFiDxpc/Nv4yuU5APrZ3raxKjL8V/LJmWDTHBPl3ehqfcXLVlWK94fpsW+Yq
	OsBfmg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gduvb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:45:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so8762949b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760942714; x=1761547514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qj1hX2tzkLQMkkvq7DvgBbML5xuWRY1vxvwpXBVNfo=;
        b=FZKpMZdsqUa24dQQ3AGNdffal8xNqDplsuNw6pYiFG0X0XOtymLqP8jPM34ZniiCut
         jiCNG02DJTxkWxCX8b8hCWOwOsq4hgQvSaMoTdTQQM1DflvgDRVGu5w0P3pHtJCca9ff
         9y3TeGX9ODqVL1rRfqpRDZWe9OZf70Kx+O/Seq/5qblF+7gR2OS2ZbLClw+Dikq0v3jY
         ZuIreWkjiPp7K3x8iqY8jc/0rk9WpKtS64qNslY4J89v+EhBfCWuSyQwIgAQ7OWV6FQ5
         l8Xof/PbvT8kZfgXxKlXffd+NlEeRgyK/YbEutQ980cp1x+kYT8X7LCpH77UnF7qjqNk
         iGrg==
X-Forwarded-Encrypted: i=1; AJvYcCWDIOymRp59LnxEvcJidmFmU4RUMy1zVdiTbVo7iU8yVSRpy0vRLVz2U4SzbvxkeN5yBO+EKM5i+i6w4G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/CTHe5VaxGIQK6lq9pC6BsTIGclszJ5sgpQTtNlzQQHGXd6L
	nnh8wLPq85Rqgc9+m4LP/TaiRBMyGwH3hsRGE/1ScMHLXzCRdJDRSp3m/OZ+xdVW8m6pRIhvrCi
	toJHdP5Y5Kil3axXoO2/gS3XURZMX39cCYws+7f4A673IhtmWSbSpzJJtmvzFib+UNmA=
X-Gm-Gg: ASbGncvCi5WnBEms9Baa3zyNolvkyBhfl4CD/LdjblwnJWqh0xsIAi6kE2O5OIDZG0G
	AHi76rvJDMqva2AGJuSZy6GLNbMcVq7/BBJMKSkzKzrStJsYDLNcXFXGkm/fT7OnshD9apwv5qB
	4TV4CEg8qRrB/v4g+FAC0b8HAGLMTNAGitz4N/yU8SpiruuAU+xo6G0VwLYVEAMFreSXyJd8B1p
	+6WQls7NYe/7zRsLECeb8vACHIuXcc9B2jysSX3TKUJTrY3t9gv4HcqJQDNOQAemfEJWQ3GpCc5
	vGjWtHsFpDXPj+W//02F4S1Z0EjWA5ipdVVU1SsgGdi9E1Fd7Anl/lfj3RZwVHlawNhNgKvx6lm
	aYImZf83vm2773CPiV0LPZ6ws3loJa/EbpESwDUOaNS+o9bCOjz60MN3k2Sfpoac9aKqVEg==
X-Received: by 2002:a05:6a20:7489:b0:32b:810c:2ba5 with SMTP id adf61e73a8af0-334a8652285mr16399864637.59.1760942714132;
        Sun, 19 Oct 2025 23:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHad5TbzH1sKjCzYpmQGbmCOR4jWr/A8NyZHnhGcDceZbOeyhSYzqUYFrWu/OhNtgqfN1z6lA==
X-Received: by 2002:a05:6a20:7489:b0:32b:810c:2ba5 with SMTP id adf61e73a8af0-334a8652285mr16399786637.59.1760942713297;
        Sun, 19 Oct 2025 23:45:13 -0700 (PDT)
Received: from [10.133.33.90] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76676a2esm6818005a12.15.2025.10.19.23.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 23:45:12 -0700 (PDT)
Message-ID: <8ba56bfe-d0cc-4f9a-93c8-0c361d5c59c8@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:45:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] media: qcom: camss: Add Kaanapali compatible camss
 driver
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-3-f5745ba2dff9@oss.qualcomm.com>
 <0fe25ca8-8dd4-42c7-a818-a803a256f42f@linaro.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <0fe25ca8-8dd4-42c7-a818-a803a256f42f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX6Qk8WgZssIEF
 EHlap+qleJ29eYFVAeNGNPTytGKMR6U8RoN6F9W9gqTlg/734g5XboSPbTFoxhY5ewGakGRZXFz
 9JwH02JOBC4GtUigYbu6nOQCJ1yJvIxeBqiFAe5OL1IIhiVJfcBmMlcaYV1sWbPRtLo815/skJL
 7m51GphYAi5vTLzx6WFymEI+Z5rl72/0XbGwUiW8PKIYvRqyaKZx6OcG04PUpIU+ON/ksND62xK
 uHprUqANn0HuIn0p2N/WUYNzwQZobW3/bKiOZgNAQIFKTSsIOoNfssVNEb0PuNfdAQvOzP0FrSk
 YYi1wQOSOMWbGq99R6/udeTDi6GQYX9jM1d9oRlJak+w/LqX4BqLj9UifH8q37nfnBIyUJB3qK2
 OqPcyrayVySVQTYCTHmYHejdNbCF9Q==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f5da7f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zPKo-_adG0ZnOV3uB6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: oulE1rWI9F4HFSTSzIXHP9VFvy2Bmj8Z
X-Proofpoint-ORIG-GUID: oulE1rWI9F4HFSTSzIXHP9VFvy2Bmj8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/16/2025 4:55 PM, Bryan O'Donoghue wrote:
> On 15/10/2025 03:56, Hangxiang Ma wrote:
>> +static const struct resources_icc icc_res_kaanapali[] = {
>> +    /* Based on 4096 x 3072 30 FPS 2496 Mbps mode */
>> +    {
>> +        .name = "ahb",
>> +        .icc_bw_tbl.avg = 925857,
>> +        .icc_bw_tbl.peak = 925857,
>> +    },
> 
> Looking at other implementations I realise we've been adding avg and 
> peak without too much review however, wouldn't 925857 / 2 => 462928 be a 
> better value for the average ?
> 
> ---
> bod

Ack. Thanks.

---
Hangxiang

