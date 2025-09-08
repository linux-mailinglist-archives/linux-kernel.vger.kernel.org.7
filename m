Return-Path: <linux-kernel+bounces-805336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD7B48749
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B884A3C49FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F82EBDD9;
	Mon,  8 Sep 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U7zy8PAJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE421ABBB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320315; cv=none; b=SCGhqRs5AwV3TLmc4bpDO8NuutDK8TZMR9jpHBYNwaMeAyA80u9jr9yc0/dq+5a8HIW3SNmr4J1YYNCDrMBJNV5Ewa5eVWdGUfgudKX3zHk7tPsc2e9YflPPILzuozMyoFbE/y+mSLn6O5Pni/nCK3Twrbr/F7w5Nw3AJMQaP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320315; c=relaxed/simple;
	bh=AUQQo6irlE7E3ePC/FnCDrpVMGqKdlKU11iw8041iSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNokFIhTtuNT74JjOhgs+Lv0QEkkby4jDFZG1fM0r+as+QGhtVqoMh0vifz1L+6r63FvLMXTtW0SE5ttKVthycpoMywkgsyniERAAUY7mHMZF15sMwpmAFoqtW4sFMBzfKWMB52UeztkrDZV0idXNPPzVgumqYviUPLsdBMMlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U7zy8PAJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883kleR012537
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDj4s3a98eQH3kjfCKPvSCUrdn86VZnNX6R4VUENK8c=; b=U7zy8PAJSiUcRkoU
	gH/HMI+/sYg3Kxqx1pCMXol22dL8e2fYakoZYSQV4pjqRjQaj1y643dpgVbVdSsZ
	OKZRLE3bEOHjnRSvPdpBNZhHQtZ9V/Me4AcOJSrTn6ogLQDQmnPBZdGL/isHss35
	jaI4xlF8/UEZeA/QHlfL4bpETikEpF1pyUCu7NCy/4Z4PxIhNoDMHgYuJ+k/BR5M
	8k5ygoxn1C7Ot/KnlbjRsdpUtuO5C5V7i6JPidkRZYigPhxMhhxehuFDzaD+Vtgk
	+NdJIjllD5eK42nE0kPTt5KuEvQ43m8jF8B0vheSx0ivmOjy6cTu2Q1wXOFhuIuA
	rFHVjQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrp0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:31:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b600d0a59bso9043381cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320312; x=1757925112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDj4s3a98eQH3kjfCKPvSCUrdn86VZnNX6R4VUENK8c=;
        b=VudDCA4Kdfo6IVWQ+B40VF9o2TiRCyQItY4Nn90/QDKZmB45/35igpDuetjnfiZxEg
         acSkvraYajLKwzuRiVIDHRG1YmGkeVVnUYv5wCzRWEoOc9CPtZp9ACRQ8nCryCY4iPSl
         ZPoFnWRL1jyIViwDlmC/YzjDQQWw5eABFCKZcWtBsM96clxURRxIeeQGuHwRsF+At7y+
         qI8hqzN3TOpaAIZToMcO6UWQnIT1ZDZ4ZNfeAKPUyeKhcP4BXWTqAJsteCI6561pvTMW
         6oW8ZkpAjhax7SQbowX6EyemV12MzyftSOYrtvPmEiQJahqh4pUgcttrnPqSl/KXgG8o
         0PNg==
X-Forwarded-Encrypted: i=1; AJvYcCVlJcKeEGhGqU2kOB23kRDVZEEKJI5HxEe3JP0YmWzVzXLF0pNkcYUB2ZFtW38i/dJ4SOeKKKY/hgkCb4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQicoeu/1CPbK1iTBR9FMZm9hScLQE2+5o5TCE1oMEmRh5wIA
	HyL65HjSdC7+fPZ8TXfLrYG+dnDzrFdxAhhAS1J6yoLtUaN9rIeQaPTBvq9SMoA2pHQMifg8DFE
	mnVWj9Zx0OYvmDl6t9ctVnZPp35N98pjvIVZtt4FJDXuErSLGWvkVAtfLDuP5kRqMoTs=
X-Gm-Gg: ASbGncvHrEAI34zGvakL0T+ZNbpVdtcVQWGMm8MsaiwYB5BNysJ5VLyGDl/gSTYhHrX
	vktrIeGlZX143FdSIl+epI2GQj73iS4xkGpN6CGIHXTNrcXL9KaERmDpXW4Ph6qmrGGfVIt2mbA
	wQedi42Cl1nl8KYXACwJH34KGhrtSzcIAhej2olNRlDUOAqqqmcqUwHgcj3hsSIgwxq1gZeFNj1
	Ex3+zG/v3/NkG4tVOPPaZdV5/7hX0k1q4h/RpEz0W2r2INepOkip13XYHCBkK8LGwaOm/XPrVY7
	D4P7J3iGXgFz4/GzGhi61ANCeAVQ4aRbMbI1jP/iqcC9gZWprjCLg+NdIJHnp3ffESHvEugmUf2
	20/uCkHIjska/GUwvgno7iw==
X-Received: by 2002:ac8:5acc:0:b0:4b3:474:503b with SMTP id d75a77b69052e-4b5f845df5amr53971061cf.12.1757320312286;
        Mon, 08 Sep 2025 01:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENfddQ3XkKBsMFx4ZOT6KiDbqO6YdDCzQfQfVOn7EvCvfbABtcsu0rhy8wmR139Hd8/r8kTg==
X-Received: by 2002:ac8:5acc:0:b0:4b3:474:503b with SMTP id d75a77b69052e-4b5f845df5amr53970981cf.12.1757320311763;
        Mon, 08 Sep 2025 01:31:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0426516668sm1906322566b.46.2025.09.08.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:31:51 -0700 (PDT)
Message-ID: <18c588b5-7b3e-4adb-bee3-8e7e445eb550@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] phy: qcom: qmp-pcie: simplify AUX clock registration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
 <20250907-qcom-dp-phy-v1-3-46634a6a980b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-3-46634a6a980b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3CqzEL1X6yXe6NAH7QB1fBwYM1rSr_u2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfXxcW8RnPlGm59
 gDPzQZjUk2ghVzGb2SmZSkgCckVquun2stYHjr6llg7D+TFE8OqHtaZSCNz16tITVEFVuf0TkbA
 KVsHHo1X5M9eFfBMkf40UMVmz4ReDcaRriRXLMWHbOBwifsf1tWvV5fRNEDQnqE7YuTFetvdn7e
 0yY0Wn8K6hQTLeUn8u0XV0PFGTXdHdjr86tiSy86HIh9i/QltYE3I4l47hOHSl0TpUQRMi5Maf+
 WGHfpjiUNHiXuNZYaMRlP+UNzTD25uaVfGe8ITjjJKe6LbbigNvt9vJF/kR7krvB4wi7DElXGJV
 ByIHFmRq/0IAkik1fo2eLuAFd0VrM+JhUHBeSl/fpZnKk1ERFbBxfpdi7UgS4lepHWsWcp38jQW
 5MtZQWBk
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be9479 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IMqhVVJ5aANQV6WWCkkA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 3CqzEL1X6yXe6NAH7QB1fBwYM1rSr_u2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

On 9/7/25 4:52 PM, Dmitry Baryshkov wrote:
> Instead of hand-coding it, use devm_clk_hw_register_fixed_rate() to
> register the PHY AUX clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

