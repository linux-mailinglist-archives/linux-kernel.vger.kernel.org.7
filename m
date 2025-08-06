Return-Path: <linux-kernel+bounces-757557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0EB1C387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D85186047
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4D199E89;
	Wed,  6 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="huTiya0X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE275288519
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473300; cv=none; b=nptrV8+7wgtbs5qjm9MwJYuXaKZtdzzQhYnXDQL3XtKGLuOmGplgJcx0VAjp4p2LHETI55/mk5qiVgalHDmD9zQvKu1ZME3sLa4ANDI4rLzLGo7koZEMh7RHssCOo+ORu1FU28cN/PjWyx7SgCZKTzzBGe84M0J6zhNUYpuMKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473300; c=relaxed/simple;
	bh=pgv0yQkNz/DBClC/IvaptKaPbaQzzYBOnrzrNVwFKnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6cOyIsSQekgB50SBCMM6gy7N4vTn9DAVUJXHQTmJOUqZ11er7aV5VKPAKT3RPgogo7nLOSJLqiSY6F8vyZkzWMnWD8IUb+2N9v44vAuzZ79EXCbPU91ojh/2h/6VsY9kHN9AZzmvjOF+ITLpLoerN2QYbVF+5TDuYzZ7DWp6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=huTiya0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765fomw031808
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7VakF4VB+aL+NaS1MnqeG+4TxHm+weWhZ7lip1w6QDk=; b=huTiya0X94aXfKGs
	P5deAgB+8aDXBQ8MSQLYApgbol2kiwjgdDqxq/R6KQIVl+a6Vo80w9YWE9nu+bg+
	47objIpX+U4R4fBiSCVgz16uf0wEb0zKikT+eZoY7sBhkHqlQZmUruEvKopWIUl4
	hygomckaxoPnDh9L0A8OlqwKDnnTmrTkaCCp0qjIdLtUuAyWCS/EknqVCn7i47Ke
	q8LHW2mvDXg8JqPojNE4Ytfh3pOi0ubsD6TzBOO+6rXH2xIGEWduRDIJVK3wgptg
	Na31JYnDJUAzM8XaLDWuOHh5u2d0dphm0mDWVA39BLMRixlDyl1be9QUPuh3JNqJ
	uygLuw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybaac1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:41:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fafb22f5daso15968716d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473297; x=1755078097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VakF4VB+aL+NaS1MnqeG+4TxHm+weWhZ7lip1w6QDk=;
        b=h3JRe4pDdbMC8CkOYxyaKdD5zg+lLrUvl6+goVXUUdgPonfTghJyp1JUYNaup0MXZX
         GFbWoruJkjTUMqklW9L2kp1FkWhkByMG4p30AGaOlOle//6+cHwsp+vgt9LP0zw86RMg
         0gEGfDNM4GkHvWk0/bSVEKac1JBUvGYfBGGN1hTwBt2rD6ODd3koAVxczPObJxLAcywW
         +5Dtm3I4+4xBYCgWrcbpU1nPxz0LrbVKgmE4CJeKzdQHMWlRLj/EBQDzG0P0xlj6nOHl
         F5CQuqIBSpQ8+8CKrfFfpEOvU9Ga5wCt4I8m/Rs8W1jWFG244s9QvhVMJicHnmxppvNx
         3V7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUbJlU96jlIkeh+K1HDf3B4eHHudOpV0bbKsdBgKIhSdMjO9m3ddWx3Wsl6K2l3M73Y7Z8kx9MiqQlI0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1xtZicx72Fk2sy11pB1ctS2cqXnwZpufUNarYnqrxzTpiNpz
	5X4p2R18pVhN/7sfeXo7gIU0Bq7ABZUFRpjRBuogFagHuuq/KkTBHEgmx6wP5dZUz8Eu0+envIo
	izP7iPeOZN9IYRsRpEP6mwkwoyIdI7Gb0SZ+1khUIWzKXRpUy3iepG95gBD3+CYfv4dA=
X-Gm-Gg: ASbGncsf+OhlyZtzAyUa84NOjzpRoHwRX24LE3BMCP1oux7iM6h4v0eZiHfZXqy6eWe
	UhmSrhl/OAa4YEkNRGzB8yOTYoN/FLJDgC9WevA+tmfNO7bEzl/XzG3KCg8n7t1apirTVzXg0Gd
	DGe/Qt+NbE6q+7++GaD7LRTlYsm30nEynfYSHgFfw7QhmgLone8SCpAZRZYsVMBrmPPaEWJSxw7
	FTUdc6ZJz8MN/BUadnGrjUmoZ6MJgef1rb/kCfLX/WSYE8VwojxWvXMP1cCRylwC+zi5gt+B7lR
	39NdGF97hptV3K31HKACDspWtm5xdV+Rtw0sLP34Ho3HfH+RqtVN9f/Coeqf2V3nmZnv5azME0g
	4zn/kcq7FV5JI+7iI1A==
X-Received: by 2002:a05:6214:226f:b0:707:40d4:44e1 with SMTP id 6a1803df08f44-70979352168mr17998156d6.0.1754473296874;
        Wed, 06 Aug 2025 02:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnpjpBA0gv0Qyb9rFEQ373wlImQP3wj+mzhJoMbEtEK39NrrxF/4L/FOwxD6DmpkrQ47JJFw==
X-Received: by 2002:a05:6214:226f:b0:707:40d4:44e1 with SMTP id 6a1803df08f44-70979352168mr17997986d6.0.1754473296303;
        Wed, 06 Aug 2025 02:41:36 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7c88sm9857004a12.41.2025.08.06.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:41:35 -0700 (PDT)
Message-ID: <55e9cac5-3803-40b1-8431-52510a8932fe@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 11:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: qcs8300: add display dt nodes
 for MDSS, DPU, DisplayPort and eDP PHY
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250806-dts_qcs8300-v5-0-60c554ec3974@quicinc.com>
 <20250806-dts_qcs8300-v5-1-60c554ec3974@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806-dts_qcs8300-v5-1-60c554ec3974@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8/VAC7sedvOX
 ZsDKHvj1ysVidPhn2SAvQQRyibGkJihymjufciRFmzjMNQYpNNJgn7uXMXC6OfbTBzL1Re/oERU
 xFr35tIUUlGuUNQEAAvBbUGUc70Bd/IC2W/gK2z/9T0mfEZBgCOIVcWTVZ9hS6Jo+CDZDmO3hh/
 tgzerAEfaRaHf2exOLi/YfjNbT38udKup0wy4TspwbPCP/TDMVZv2V30cjdbgj2dluL9phoIrF0
 0DASyYu+7ASumP2WlKZG6qaZmSdpKQPEsRPdeT9uUJTHakpOvnxgDgY7ANHtkmP3EvU8opXNs9u
 caBpyfuSBhyFKeoBbksMMgw8bZL9BY/KIx+7O9NG0rWAE/RV/RiUiOOqPah9hfJai3RN6FkrOQ5
 mIRts0DU
X-Proofpoint-GUID: ggZoZjKK185hluZ9eafgkIEDklk7_Xl-
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=68932351 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ggSMAipNaOlLgWN-UjYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ggZoZjKK185hluZ9eafgkIEDklk7_Xl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 9:12 AM, Yongxing Mou wrote:
> Add devicetree changes to enable MDSS display-subsystem,
> display-controller(DPU), DisplayPort controller and eDP PHY for
> Qualcomm QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

