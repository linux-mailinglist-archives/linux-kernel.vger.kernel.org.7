Return-Path: <linux-kernel+bounces-755205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F61B1A306
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC01884C09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF326158C;
	Mon,  4 Aug 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSBcPGe3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014825F780
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313266; cv=none; b=Nq+EVG0tpZwJrimGNWwX8VJwu4dyp2Mp0sWEKs+ImNLsFJPMPzTPo9lUDIwi00c6NNZMfR/DL+k6feYH6sua7Q9Rmg++1n1ALwrSHvlfBOuv70x60TSn14zSD7qU9YPF27VjPvZM71+iH+vISVmDzyOBdrB8SmlJ8qtumdeCu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313266; c=relaxed/simple;
	bh=nitCmAavgS3eup+SMOcSyyiqncdlMa5i+nammlA7TIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyYYRu3fyUQq/XRoKDLTXilBzx56d9LIoIE8M6yei3/dH5dmXdhii5UbWGHVk/l8ltN2bu3GaApNUDf59qic9gC/muI88m3YS8guLbh42tvSDOxL0/SwL5oXO70uFLQ9F2uajoCD1jliOmGaNp8STskwck+9FpL9V3pIhrZGbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSBcPGe3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749Fck1019447
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 13:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iuqkYJEHU46HSu5bF/1m8NgiJsyaKNVDD5t0GtyZPKU=; b=dSBcPGe34hwe5cmj
	mNB3LlId72lzaYJtZSgzsodfASxhHgARWwRu90eZ1psCB2Cxis7dqc4ti5c19Bwh
	fS5Ol7nj6L/cPPs+hAdS0M3wuTukXxrxLvwdKWUhaKLuSfgzj/9XQ0ZXkaQ7CE+y
	TxJAZGADC6zvrzGWl+9zyEvsArtjZgCVl9c1z7tUMCfR/KC4VbZaNny4SVONspCj
	GO3WIoaOu0tLyRvMmtdxBoK0Fl1HxZkP8D7KTxc3htCsBBT2kevwoVjKQswWu9pO
	2Xjn7p/TxO3v+qi6ZnXmUO8ed/yL0nckSKO0rKjMumMPR60y7lltL86OcGSro+2d
	1BbibA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek51bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 13:14:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e7f8e1dfd3so17704985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313262; x=1754918062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuqkYJEHU46HSu5bF/1m8NgiJsyaKNVDD5t0GtyZPKU=;
        b=JCP7RNCwA9wM4wftAG4ip4Q8hETaaAIhxZCOz77Rlg8aQ3dXbe7fXWFTJ2TuDaks/s
         eSDhIKSyFyr8Df3oqurLYrEtypu2Pu7AwZXgd9I2/uuJ1dEFinPuWzkg2bOB4HQo/6uW
         g7P0Eg/Fb1hotJ8nU0aql6sH4qqgKYPSoo96vuXZn1hw7EltJe5Qx+ffkil4Vs5wRBUZ
         2oBV0818H61CgC36nEFp/UM7rjrfBttCvX/k18F2D9p+1Vepkz4EaASTls2edjTdiZxh
         7VoTZxKSaDs/cNMEgm6XBhR2D6vb7sOOglYESX02ZtY4kwl39nSDTmBB2Y8hOkiXVPjt
         yZtw==
X-Forwarded-Encrypted: i=1; AJvYcCWqg16wCJqgwV4ZMkpR5kyOCmt5NKuEZbBtGzZLGQABlRU57aXwhrxRn6Q80wWOuc8LibG9/28ahZ2vleo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyI+Lo8VTBf3d08G1i9THe9CuAkmzBzjzAbo5/jNQBg/yMS3p
	aK+AosI71XlP6pnVomaCHe9erRsZx7UPegEWIv2Ya7R4bX8bzW/UIJx6bGuTVomwh/h3JzEe59g
	ZaAA1Hwf4rvlL9u1I/hIHOurN8QploWJJFnKYaJQrnPMUnkvor3Poa/py9u8HolE72og=
X-Gm-Gg: ASbGnctBiG33J0u91TSiyVlPxhxn3Y+Lr8z5g1O3DB4RdBHC95+Zan+vkLfb2uXppOW
	8sYpiFUu5L1nvBfsAHyS5wImxKI1ilCdpCGSRuRcfcKZ4QDAJbOHTd0t4qrXm0/b1NDUiRDZnNq
	df5jP6IhVNur6d1S4lx19twJKHCY3Nm/uT4dUswaKU6rv4ldE67tZoQ/pXZLId6yuf7+5dT0DC1
	UHne3cBlwj6icOS6sBgeYhYmnqn3EFy8UM+MyzNAII0N4aoPfSobiCgwUQHF1Pee4n4zjvK8WQp
	AV8NJbU/us6O3/3R2dgsn1Q3/OvTyErNbSCoVixV515JAmCRFQxt9E7Wj/u23o1+4VIId4fLZpt
	v0p/EALpIe81gUSNsYw==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr127004985a.4.1754313261985;
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQKfXoAA4iQAVx7vrakGz5rhAfhLmMpyLiivrawj8ql8YqoebUHyRY/Z++bxkV80jn4cAicg==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr127000885a.4.1754313261562;
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm6810919a12.38.2025.08.04.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
Message-ID: <dd278225-6680-4dc2-a0d4-e110fb2cfc20@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 15:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soc: qcom: mdt_loader: Remove unused parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-1-5e74629a2241@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-1-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=6890b22f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wXYMRSRB5Pq2Cuyld4wA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MiBTYWx0ZWRfXwQASqWXyebST
 yLI6ZFB76HX3i7D39XtR+lSGjFsOouBiKrECGfWgNIRjzZq0XWFDgxZrCeaq1Ie//t6EH0CmamM
 OdW8xkvB1WXT+FdMIpQoshwjys5wHubjlWWMK5DPLr6kir3o10curmziS6dNd+ueYu/kUzF/Tov
 9lWYXTj9QxsuZ+aO7gfY+MM7/TjQB9u/0CnXSG5dPpPmvdvF/6awF2m1hF7jxOMaSwNvOaP+Xvl
 5BKCNETnY59x35I++ImD11fXgccxZIDonLBz9ct0UCUcmsfwJs4DTgDze/etQLY7ipi/WqPzbdu
 Ykai6aDkQ88FMJp9Td4IyGO9DzW9dGocxrrgEcayJl6UM9NxczX90+UioQR2tKmTQuhgwHbh9yH
 MXlIvD/a2R33fmt4ouecXaJrKvdXLPRdY+a2MEYyWa44HDfz+/Dg7vasAKSDtyCfhWXOINr9
X-Proofpoint-ORIG-GUID: lUdpQaW5-rLFdpF0AW4gsOZcZauPqJ1d
X-Proofpoint-GUID: lUdpQaW5-rLFdpF0AW4gsOZcZauPqJ1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=960 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040072

On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
>  operations") move pas specific code from __qcom_mdt_load()
> to a separate function qcom_mdt_pas_init() after which the
> pas_init variable became unused in __qcom_mdt_load().
> 
> Remove pas_init argument from __qcom_mdt_load().
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

