Return-Path: <linux-kernel+bounces-757540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B73B1C364
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61093A3A16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3022173F;
	Wed,  6 Aug 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa19P0tJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD185289E2E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472640; cv=none; b=VBpdKj+ULfUnH8owKNX6TFSorFzvXCuvh4IRErpHebeYut3O32PU8UCkQTHGbH3MEev83kaqSOOKD6lQa5P9SMk76YYPZY7nyBrQA6KWTxQePKPji7Qfhgxvkg/hMjbNKbhRjnJqwRZyOpvH5WDXwKiEc3l+QswZ8kLPTaE+CIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472640; c=relaxed/simple;
	bh=oM0lMX5NbA9LV+vdx7kVpo7EN9KJbvCiVdEvhHKvOIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSwhLo01xED0WT9Ppcr0iFeYoFt8hTd5K2bq1h+0nlyuuc7QR3ndjPW5YQUbCqI6L55l3bA3cbm2eYHiHXby+NZoLEWoP96gaqGjtKy5n3/+7Vb7v8Ond/vpQmZxwAXvOW3w/gIucens4AR/v98jRuBgFdl0juLu/oTW1Fg6by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa19P0tJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766R7ol019336
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3F7jW292s5J/5EU/tt0B7PNoOU6z1hNas34m+AYe5s=; b=pa19P0tJNdOXEswJ
	Pw4gd7FffZPMraN/BaQ7eF8E8gVkZp2zUozm9zTZUhWDYpEzcq3CKQRKv0qMh9W9
	89+kvoyyND7HaI2jJeycRnJul++h87ihBEGNYgxYndq/iRE/VWEGYSrKIdl6/pnh
	lT1biFG7wQ2w0se8AvUGPLFixi1SPB6xfWma0Du3ERVQzo7M2/Ij5tR4siyYXSUL
	Bm/tmjTr7O7+WOtOS8y07P78Ie4ISV1aedhjsnVJK+SXhNXy25VnFElbYy05LH2f
	IaVxiko6R6avcytDxCOwu5xwuPUZOU1t/sHOSYLzNHal/7L86n8Yb5huxgnpdMFx
	fhGinQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6t4xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:30:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073674bc2aso19544266d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472637; x=1755077437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3F7jW292s5J/5EU/tt0B7PNoOU6z1hNas34m+AYe5s=;
        b=S+ssCi7iIobKX1yI7qdc9VF7okoJZQQv2wpVKuHPYeF6/VSy5eLT+PSAVKeRnlzppF
         m69WnbIJv3B+W7oZLxnj41a99pRn8Hl3E099qgDxOb0qGWImM1R+NYfMx/9EduJhVZDF
         AZlbesB04iL76c5mkZWxy7MnkFJ0MYJsdxPLjFaFI7ZlSM1exsuz29+X2zwgKb4Njvda
         Pd/CyLvL9JWkyLQjJXKBuVHM+IWe5hUAtYBDiW7u91buc+35bip6ePriC6tAZ+r15I+6
         1bA39TLLpxRnrq2JIuFyxG0CLtxMhSH3uPfPz+6fK74rAV4PxTc5cn0VJyKF0gnsdKrO
         QgTg==
X-Forwarded-Encrypted: i=1; AJvYcCWTw5BOKr2qdAhtBo34yA5GhLVq8F0TZ5f1oQsHQmyhrL4GzM+RvLfQZVOoVjV4ibplCa5iaXSEZo/m7/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSE4LuGRm0nqZtLjQG0sh/rCFRtaQ1TchVrLyxqKrlMSErU7LP
	h9MYrPTdREqGeollYscFWnktTLlDNeHHZOCc32LHY6iP2TM8dVmVnEZKO/dwXyLhUh1jz/tQD6I
	MWahV87fOZ+U04tgXGhWnNaJJjcpFO3TXMlHp8ag5oivb34tD++Qp+SBWL1VG5w3GF5o=
X-Gm-Gg: ASbGncsUp+Dh9+VEtBsDq1SJYWT54faoOoOtMmAcDnlTga+POKEG42T6aQnUXZXpMVC
	e8mvZb6c5WMZkroI0TiJ6B7ZgL2tVeGE5ho9DeH2Ied2eALDxawCQrZHACz0KTisjvnhE85svfm
	7h0Udwvz2KuNXicO1fbPPVqb3vPmchgf3k3d6FDGW2PM3biwEzrsvm5Rfd9yhbstuXUtr47NhaY
	uXrbKTC++94PVgdmTef0orEACVF8OTw4KqXF+6fRKaYXL0AsKxXjSAL8GcS41ubrkUXuK8+/T10
	fEa2p3nIwjW0tYhDdSHHsdZv4XeZWX5pn+FA+2sOyot67ao+L4XHDRDhZC12vGdkvpij9RVzFTr
	tgPXrcSB4Llog5Jgr+A==
X-Received: by 2002:a05:620a:191c:b0:7e7:fbbe:a193 with SMTP id af79cd13be357-7e814d1869dmr186496185a.3.1754472636615;
        Wed, 06 Aug 2025 02:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQKtkuAek7TR7Gpi3LxI21nwdlFWmLTMwrNP99WIXsIbBRgltr6cJsFAy/rkQ4ETKM7Y8xeQ==
X-Received: by 2002:a05:620a:191c:b0:7e7:fbbe:a193 with SMTP id af79cd13be357-7e814d1869dmr186493985a.3.1754472636112;
        Wed, 06 Aug 2025 02:30:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm9983730a12.25.2025.08.06.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:30:35 -0700 (PDT)
Message-ID: <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 11:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2QX5a9LBIMmnwbG3DXH1uLMisYPP1Tge
X-Proofpoint-GUID: 2QX5a9LBIMmnwbG3DXH1uLMisYPP1Tge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXweJIyKckmbeG
 DPiNqUip15sUbIWhIEjg37hYnXXM3ypV1E4LWj/3HPGmXBYq6OMtbJR1oc+qsba8aHnBGmNSdoU
 z2ckhnu7idE0wk8MiFPfLAhKJfC1X5hZ/A2mkVbRXfd0y96Nm/pIuzMl3KpCt8h0zIuSHnt2uUF
 OWoBac34E4VcmkdZQfqWBNoqLB8iy8XF7OjoNduXVSr0s/DOASh0FwnShSl1ppQbYoC5zsWqxUT
 LUTOr1fT1TCXI5PoNH9Eo2dcOTUWobDjO/BksGO2tL2IJ0i9lCwsjHxOCTWG4rgR8yWXFBoxdZD
 DKObOhBuJOohA4q2dgyxw92ewVxBvTqcmYbpYd+Za5r9GBn+h183JnvSLvsSIxnU0Nnrsa9x4bV
 /twDynMJ
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=689320be cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=UDxpVAc4W1oXZRtQ2dUA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 11:27 AM, Taniya Das wrote:
> 
> 
> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>> boot. This happens due to the floor_ops tries to update the rcg
>>> configuration even if the clock is not enabled.
>>
>> This has been working for other platforms (I see Milos, SAR2130P,
>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>> seem to use non-shared ops). What's the difference? Should we switch all
>> platforms? Is it related to the hypervisor?
>>
> 
> If a set rate is called on a clock before clock enable, the

Is this something we should just fix up the drivers not to do?

Konrad

