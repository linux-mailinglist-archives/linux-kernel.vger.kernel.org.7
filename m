Return-Path: <linux-kernel+bounces-865541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B82BFBFD71F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5571564113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574012D5929;
	Wed, 22 Oct 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmDIOatO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEE348870
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151305; cv=none; b=I1hS1skXHrajYo1NXFmkqatb+eQ1K3D61CV3l6ODJ77eQ2y1SHNCLz1S1yFNhFxA0RJW7dRChEfiUptyR634UH+9Xc15DRrfJqS0AWv0XFZ3Ek67T+bWgcmtryZaSBnKV26nOMCEKh2rAVlVFIH1hNtfn3jigf8vXw3WflLtDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151305; c=relaxed/simple;
	bh=dyBHWW2GuAfwvJ2oHoKOOFUrERxAVPMXWvg5OMsJz5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb9jHvfh3tW1JUAUMI8a7U11B/iapJ79Jed/H8/PTxiQL9OGmdX6cw31bvmliSJOjRof1jKo/WiIoRuBzuULUhhAnYoO/7ic1C3ufwL/O+/SBC4WmYB7qFVeRiuVFSC4GwTgA/OU0ELR8+cCsNkkxisNm+M52xS7yPU4TMSDz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmDIOatO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MB8tPu024200
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wP06UGSoKxrw415mfswkrKuCr9sYpruJ9sx77F40TyM=; b=CmDIOatOmKcwXZuh
	WrSaev0C1+B3KYa/kmaT+FKkNAAzbkD3a4BWbIO6dOlJRfF1eQCOvfCPZf4hoQMm
	7FVcimSL6b7ZVdk8rwvh8NfWD0w/bLYEltxaXNSGDxqFJ00ZYI8oEq9UxC4xPjF7
	yzuO6e2E/PPMXCraDBWv6KAgkUXNfJhLgsRJwh7tfE6rMsyDNRG3RyfhWnO9ppSR
	8+zkieSwzgK0SPKQTYshEUqq2PnHrsIfuRx6QHXN26eqXz8wuT4ALODrmHfCiRX4
	tF29jLmB8zckz/YAblYVXncWUYrZhithAIM4bKR0Gtm4B+ekyedu+i/TuTxj5JWB
	UXWieA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w85e7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:41:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e892b1c102so4924301cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151301; x=1761756101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP06UGSoKxrw415mfswkrKuCr9sYpruJ9sx77F40TyM=;
        b=XdLZt1W0qghyM7AE1vzHcXg5cNnT2QBIJ9WuPW3G3XDE1TlcOVSV/s0FZj/XabkuFV
         zGnJhVJUskPnrFIUHP8hujSfsDNPJJEom9NZKKptu0dyYQiVfg45rW7PTD+C8sWkHMhV
         TgR/Sk0ZnKMFhUp60YdxFB2he4HdJmk7+rabPADbKWfBKpFPsYsXID/ejAxyGA/y1Zfp
         TNvw+1fEUAmDOItkzmJbVvrrIHZmXM1RVBaEn0tMXGrpDBGdUJOgHzRU4s8XiZS1rcsg
         2ifXsaSpmJvxOBOKsiE3Q82N3PoM1Qf5c1NcFPwaAHRqzBKn8x+x/jaqym7lOBn7R70k
         fGLA==
X-Gm-Message-State: AOJu0Yz5hwlmJUAzCotkIV48GH8Lx1L/CQoosqW20qSE/lp50w1MdVBd
	gX9TgHDYX36zfe36/571fNAyOmP6IZ2VwHHuyH7Ty0drR8YxYKEiDzI9FQmaVdluZ5+EJ+5hhS7
	CIX95XCDjRfvsJYda/HQoVqqEUqBmmSs9xXWGMja5kz1WDdcp5JDorehp+v6IPFdHpBI=
X-Gm-Gg: ASbGncu1TOLVKoQ9wzX6wINUMmJN7OMoandpDbGtx0qWcym0pKnKrIVi9BEOxGAycuH
	oLMT0P8/171dM6hghI8bQrbgCgLejLACN5pfaSohCB2lwcFA6G1ozjK4fXndw11uyYUa/+VD8Uh
	TutPwCyeBIAPJci00D9IBQIIwO7QGBsu+rpwulJrxsu1JKcwztXcLS71qell7gT2KjtTdNMuzRY
	ppwW8uhbjItWsmyvvAUzNQ0aZasqfywpysCqDC18nS61UJmJNJCVeLgDa4A2lUdTdTN57JlK01f
	6OIS06JKn/LMYc6m9io4MIRSHzoQD8xbJMseGT+o5xcxOXctuwJkZo3WH3eYa+nUL543U99vZj9
	WeNcU3nxa3Xi3VwSKpbkJ1nwwEH7cj9rXywXY39t3KVLdDppMiPlUfOwW
X-Received: by 2002:ac8:5e51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e89d1f94eamr180584941cf.2.1761151300468;
        Wed, 22 Oct 2025 09:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTPhl/gCybkXFKJAiRPLwUPk3R3ErdJqsxNwT2SQ3vNYaOe1tbdKrzeN0wa+yAMUA0I+7AGA==
X-Received: by 2002:ac8:5e51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e89d1f94eamr180584611cf.2.1761151299934;
        Wed, 22 Oct 2025 09:41:39 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6aaf93a32asm934824166b.51.2025.10.22.09.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:41:39 -0700 (PDT)
Message-ID: <e4cf1f77-af38-4f36-a590-dc662fcdb602@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:41:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arch: arm64: dts: qcom: sdm845-starqltechn: fix
 max77705 interrupts
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
 <20250926-starqltechn-correct_max77705_nodes-v5-2-c6ab35165534@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-starqltechn-correct_max77705_nodes-v5-2-c6ab35165534@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX8Yc/kiEXmKmt
 bREhBX6UeQ6PjvI0ql67AK8QgJRNa5X3vRWZe9lYbDQOJAC4mTOSO7fjUewaEQ58SEfzKNTOgMP
 h9jIHn4kuE1Mn+sL8BSQGrv5vlfpwnRUSLIISgRuWakUuqFWzdnT1bG2ltMcpDNqi0jAyzvOfqo
 wAMj+WGu4eJx9M74Wmg7ADPj5GOlnjKeJs1Zx3MaszI01wAdqo9Yo0/xpqbS21M+R8EDkDI2Ass
 UYPjZyRx/azXG2FA0Mx+dC4SO+q0r+GsvUcDFcAkmHurjWeiXbW+qPeIDxYcIorAi+wq488ltle
 t/gVmoXikKoxVxQfZhjbmmYMhX0pXkqhsajUAOI8m9qnxr8eKQonbRthFVyFj+/D0Ufkvj435XA
 xdrkpzLHhwT+oJ6Ky1jIOuGrEcA8sw==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f90945 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=5u1LwdSNXLj5JZSvkjkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: m6Fr-all0Oa9vz7BZKXvg6KXFMRPpeRq
X-Proofpoint-ORIG-GUID: m6Fr-all0Oa9vz7BZKXvg6KXFMRPpeRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 9/26/25 7:13 PM, Dzmitry Sankouski wrote:
> Since max77705 has a register, which indicates interrupt source, it acts
> as an interrupt controller.
> 
> Direct MAX77705's subdevices to use the IC's internal interrupt
> controller, instead of listening to every interrupt fired by the
> chip towards the host device.
> 
> Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad



