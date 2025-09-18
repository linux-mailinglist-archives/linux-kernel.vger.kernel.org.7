Return-Path: <linux-kernel+bounces-822018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068FB82DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3952D587293
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06B242D8C;
	Thu, 18 Sep 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SblFZEZ4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DB241686
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168864; cv=none; b=QeTPz+lu7KjjOZEdJwkkBxg25Ijyr3qoHWRxqa2FvEKEg2lEA67ceJFMb3KGHHFgyaOCfsZXX/IvuiiSctF1AkLxKV0p7P17q35svJYkKlU2eBzokKpRoa3tWwoytMp4oKO29fFPMzMHE6/Q8WUqVogj6qpyrZFNZFkntao4SYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168864; c=relaxed/simple;
	bh=xsSC9NODBLQNJO8UOBzzlN3x3OgvcCBfrbA+2H0P1No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJP8oOxnijvxJ6Y08Dmr3a27x//LltX3QPEjkvRj8b/oRYB7EsOlAajslBy1rTJymAf1LRJ02Y2SR1aErba5XyRSTzj7QXEPMQOotM5DmUfCSJwglbGLFnxCxeyhKAy+D8Cp+j4p9UgQdKekvDF3pNs5X+H/oYOoD+b+bLweLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SblFZEZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3tEDr014233
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aCNDmHkvNY9CrJM/mPFO6zJGKSeooOfxAkQ8HJXEz3s=; b=SblFZEZ498279MOz
	Hkw+Et0q6V/VIfMyuduzYbMcR53L3BpndHtO9HOuhb2f4Hw1fLg7919GpnCSZ5fi
	1lkPrHrO9HP3YOujDwG6g27veIL5hvZhaAQdhwGlwI2+qLld0ibftLFTVH8klWGs
	JGRqyDKY/3pbUdGBQGaN7MMCNYv4muGhK+bjdS6Sal9+5+g+iX0ydurZ/n632Hfe
	ChA3MEjRWwPNL9mzdQqP1dHosU8iSu7uVuXKBgj9BrG8LNeUdMjzoRRPuCcRPSwX
	7WDHvKZcSu4bq4XyH+ShQNtsXNeDbvmcPB8/WfYwu6sjb8d/VYOPF19fpvZtoIWt
	B+43Qg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu4vqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:14:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54f303289aso376085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758168861; x=1758773661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCNDmHkvNY9CrJM/mPFO6zJGKSeooOfxAkQ8HJXEz3s=;
        b=pbWuQMonTeaSFrA+B50cSc00Z4rAWYW1nr0o1z74m/7wIqb2wvuU/Fy6/xJE/m96Fr
         bT7X9Pv336Plk9GhbcI4YnPUL572PlACpgzJ7X8lUqx1IaPne6F4nM6PnYvK1OrJUnF3
         qR0Y3oX+zkM/XXfB2LzwU5AwCCtQkZ2DT+zxDcII/oK5qWJXkGJV6s9FQBSZmb+AIj51
         f22ObmK0LkEw+5LNRQaJZxXkKGf+ZwGXfeWc3o3+zXMVzb097L7mLX8m/Xdx36o2Y6ln
         ywCK1AljEzNiKYzjTEMa+hLL3cl3Fdvj3rfAlelZ71VGVlVAu+VfSZrt2BEROPvAUqmc
         jKOg==
X-Forwarded-Encrypted: i=1; AJvYcCVO/8tfPV8x87L0xgEORyR1ONqhrD7q4otu6m5aSAK4GgfAj2Z1cq/HFC/eLoeBSPZIiRggTC3SjR5vcZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGqNu2lIYRA+Lnao2sTi9uEAMTDQH1AuhtWqDSGfP7MZrVX2A
	9N7LU6nf6qq7khgoBHFS1KUiN6YD7BruiK5QN2J4xcgKwG66AIi6s1nawb9l0ysYHTPgZ77LDJF
	4UkzxEOB9ngntDIrdzhl+QiIb4HAtyNNVNYxnZkn7d0WkKEL3WbShFeGIhKFt4z3edCk=
X-Gm-Gg: ASbGnctQ/VMA1S6UeGOR5f3/K5aflbC8i6kNjTaMs9W11oR1diLrCT3IdHuH9KlhJkf
	JVGk/enEkTMTKQrSKvyh5157drAhH50jQ6UkerhNyYMyldhOeJn07PsZClvDEb7OFvtyOiCes7V
	JhTPMBtgACVcZwsGfU09YM358XdmAxGMmIDaVah0Vur4K2W/7AWxWCoJe5cjtSEWOg0bF7acbdH
	fTaoY9xkVaZl/8kcEl6GKm8Z5zNsF/qdRQ+XWhuVPGoXbvv5ACuLteYIySBdMd7wTOoROQr6Tsc
	h5awOdoWP/R6mz28FJcyjth1rC/m+J6NII7fAJHPwU+uqBlajRFun7u2yUwi+srdloFUOzXxTuB
	ypw4Bd8mhFW5lDWK+LbliNIZS2SVlc7d+vbk=
X-Received: by 2002:a05:6a20:914d:b0:243:f5ba:aa82 with SMTP id adf61e73a8af0-27aa1e62dd7mr6641615637.30.1758168861306;
        Wed, 17 Sep 2025 21:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEESmYhA9ZUlRBuUTUXtxNrHCYKFq5Co1XH0AnMN4ttsNfHWhbopdOhRVpdLtRhJpb6K+upXw==
X-Received: by 2002:a05:6a20:914d:b0:243:f5ba:aa82 with SMTP id adf61e73a8af0-27aa1e62dd7mr6641593637.30.1758168860852;
        Wed, 17 Sep 2025 21:14:20 -0700 (PDT)
Received: from [10.133.33.39] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061aa5fsm996954a91.6.2025.09.17.21.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 21:14:20 -0700 (PDT)
Message-ID: <b745c515-2264-42aa-8d92-663efc7f6276@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:14:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on
 QCS8300
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
 <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy96suqMKwvVE
 pPOjver+KlfKJ6uN89HenWomOvYbMBX8Umq8GU94ryvui1x8l3c+wFLtN6pCowsuZxPkVdNfGX+
 fCK3CFeq5fVS7dxkjeS6Zdom/E82YDltCkBF7vQhxDJqy0RcNmcclw2D1vgp16Uej9L+/EXQsws
 +ZLTcygF+whh8N1+Zg7gijRGhDQDXsAWNvGRiifKJ5zdAJgnCSpVVBmENYvLhth0BpG/9fi+kT7
 UQi2BVkPU65TUTJQt8VHA1dYimC2PgCAp5Rss5XCdcl7jF8qJhKltOMluWfD+Q8oZ3XQw88p031
 r9/yRCdqJEUS/5yq29NdT+WBBHZeE0zmlYI5bBaBnZvDCxs9s8WAeJwsIkk1Ktj/U8Y2msjuuG8
 MgMYouvu
X-Proofpoint-ORIG-GUID: HtYyoGu3a4F57oAEmnCWec89OVhBjEdo
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68cb871e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=zVao1zPCBEz49K_-8u8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: HtYyoGu3a4F57oAEmnCWec89OVhBjEdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 9:01 AM, Krzysztof Kozlowski wrote:
> On Thu, Sep 11, 2025 at 07:24:03PM +0800, Yongxing Mou wrote:
>> Document the MDSS hardware found on the Qualcomm QCS8300 platform.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> Patch v11 and still basic issues. I am very dissapointed.
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof
> 
Hi,
Sorry for the confusion. I did intend to remove the Reviewed-by tag, and 
I mentioned this in the cover letter, but maybe explanation in 
cover-letter was probe not clear at all.

This patch includes three changes:

1.In the displayport-controller compatible property, "items" was changed 
to "contains".
2.Use "qcom,sa8775p-dp" as fallback.

These changes might not be considered significant. So I’ll be more 
careful next time. Thanks~

