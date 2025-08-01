Return-Path: <linux-kernel+bounces-753446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7CB18322
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82F6624EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD9265CAB;
	Fri,  1 Aug 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="egO7XlpD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F825156CA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056982; cv=none; b=oF6YPyeSWq003KgQ98mWnxa6fwxhRw6KgcJ273G7vxBq05rbAtTV8ktuwba0vB2h4zyV20pz4fHcRCZCGeLcZf5Vv0lmuBZ2Lh1ii69Z5bLzAj3bZq+8qC4vwe4u6nsK5YAZc9ZrrVJ1GwPiTs5jObWyrcf7wn8nXmAbeU37E3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056982; c=relaxed/simple;
	bh=nItOCXaMTZikrEd/SG/gPX9uFOdLbGk1tBhDXjWOOog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siirXMiTHWQ0fqCKYREmJGNl/FyvfPDsf3cKHIOjTyiFxEp16boXp08qAhumJf/G7T5cR+Chd/Qy8y+eq5djyYQZEP8O11Kp68OKQRQSTPF0fnKVgeNAe1i4WUaXnEkpdFHXYcgNqK3lheU1xaTJz0vWNCatRV+GDb1Gd/sPVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=egO7XlpD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719H1jp018900
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 14:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ygnu3vKtE4DVMIUyobWs5dsEn3embXwZTU9fPdwC1w4=; b=egO7XlpDG/iZg2Pd
	ouw+Sd0Y5zRBUvnt27rkvfU8XyM6lTFdcypePMt7sLtPBPz7lY4q5vGZ0653Nrl9
	zFDCV0w09TNVGYGMtNND3D7/hKCpL4WgkBwe06VaKPVobsZSMHa0wjbbRAMsv7f1
	Zy3rrkQznQtBaMbWxLlP1LIT4ajP7F801kftJg8+cqVZrzkTypJk9lE39XXmHlig
	9QQ5KDul+1Y11dL/MyPwDYCf0R3I8aGRZbSxwC5a6o7MwKvwZx+oxQNoMZmEaTSR
	5Tcdh0bRpLfbIqfONpPah0N8+wj8kS1wjCSc9HI0iWQClnaQ5V1agVVJyAndZ7TL
	g+nFEg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qdabxe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:03:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707428e0cd2so2798086d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056979; x=1754661779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygnu3vKtE4DVMIUyobWs5dsEn3embXwZTU9fPdwC1w4=;
        b=U2zNJ5dN1Q4B6jmD1taWvdnQppvf06wQAQKWNRQhoFxBzORZA8Y37BCqFGvMmDix6+
         QaOTJpcsMzcvOH2mjGtXZ7M7YQhYdRfp96lrctpS7eA4X+XMijoRATZfDttdWQpn7SOR
         02YmQiSBMBCGgi2nPDYvMptjJsjvVl0GtdvSSPVBfMOnsy3xXuEnHFMyvMjc43mv4a+D
         b8vGYHcfxeXkitlSh/GF8sT+8UFZXDtkqzJgmYGqmnnfpkI6TXH69viszKFhcA+LwVtJ
         /VfAZfZrAhZHKXdGC5JhOG+cFvrwOZDQMGFg5idY7GYI8wS02v3EEnJQfiQKr2OEfS1I
         1Arw==
X-Forwarded-Encrypted: i=1; AJvYcCUSiH6AjcF+zrvVTRm7yU2g1tsKsuuu5B/tpnqa/Ga4uiljY5yG3Iw/3Hbakyq6L7gtoj00cwrFRlOfzPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySv4UcPkCEAkcyhOCYjL+xciHmrV11KqW1BaqlmZjgXfeLYuJ3
	EG4JcPt5rH1ll03gyw/HQOS2XlYzSTBiXwprS7WURkZEig4MdDZsQ4DPQdpF95RWqOPrzR121K2
	yQzoIGKBO55DIc67U9okgesAgKO1446JfYOyTGph7Wk7cMIP8QuMCiTVW7wBPSzAeNjY=
X-Gm-Gg: ASbGncsLwlnU4M+rJ6+c349B2KAygKNLDGjDgh600FQUIC4S/DzuOBjS/8th38XwknT
	k4HR+12q6+ud9CIIj4JE9zv5/jGBX5QjDvw0b172p4ff4K85WU/xIEloRkifj++D1uWlZbo227/
	975Sl+JCoUVsuvqv7oVRaZzSGKyKGYPwPd8krfDaCTusINyw/gEHYDDReqJwfnZ/VvFEU2rvI8x
	cArdG7HA43wQIKnkR3AbLFsCmSpO6Em0Y1VsYRQ8OWKqF+GV+HYZaUawbvS9xNwzuUjJm6x3bt7
	7f7LsP6BNvUJ+xFIJsPqmrnwkwISjz3k+cS0TQXG7zFbN2GgYDoBKvg0cI2dh4lMtBk0KXqL0Dq
	5ufsQUpWJ/wx0NqN+rA==
X-Received: by 2002:a05:622a:450:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aedb9d4b86mr86440801cf.4.1754056979053;
        Fri, 01 Aug 2025 07:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcPlC48/d5ChZvKarK4CBxmt6g2Onl0ZKqiWKPbE3pGDFKjvLO3RnhPcMsdo5wR85JCYopFQ==
X-Received: by 2002:a05:622a:450:b0:4a7:4eed:2582 with SMTP id d75a77b69052e-4aedb9d4b86mr86440301cf.4.1754056978309;
        Fri, 01 Aug 2025 07:02:58 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436b2sm283269666b.142.2025.08.01.07.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:02:57 -0700 (PDT)
Message-ID: <5696951a-d4cd-4b98-8190-a1126dca4317@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 16:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280: Add q6usbdai node
To: Luca Weiss <luca.weiss@fairphone.com>, cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250801-fp5-usb-audio-offload-v1-0-240fc213d3d3@fairphone.com>
 <20250801-fp5-usb-audio-offload-v1-1-240fc213d3d3@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250801-fp5-usb-audio-offload-v1-1-240fc213d3d3@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UTDASry9AHY14wh9P-W-jlVNsGDP083O
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688cc914 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=s1otzWxbid28AevFAO0A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: UTDASry9AHY14wh9P-W-jlVNsGDP083O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfX/9OTpfW2KzqI
 H2qq99f6qppr+nUD6debCYUgr2U5IqpxPuT7K9Mcb3x8393ArDiXvlE07EBNSNzaEmQJ3k5Cu5H
 yDp/Pq2zTDbNDUd9i/uu1WTHULYRnzUoNckrI6LpXDtqfX+ChWaUfAJH47Nw7LqjmJ6iY4YE3Av
 RUQZk7V2Y5xqelZDLH9ElzbYCbvCwH7or2j/S1UJNfXhJO3u/R7AQ2AJ8OEPugFbmWHrivWizj+
 7nqd/Z1bBVpfOGzPt/HXQcVyXYQef17/HE8rTD5f32N/2Mc470hJwyHNp6Vy167cL31oC3a/u+w
 YTpC2tnfb2E7/sXbMFeKM9u/UtKBs5KfvYBxaVKboPvcjLush599GiVkmcaIDkqcPkg3N2fo4g4
 L6VbaAYkPBReDS4wbgnjMbNBEdpQnIFBGzKShABd0t+ZHFeIaD6hUQBRinuOv2JfmijPAVh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105

On 8/1/25 3:51 PM, Luca Weiss wrote:
> Add a node for q6usb which handles USB audio offloading, allowing to
> play audio via a USB-C headset with lower power consumption and enabling
> some other features.
> 
> We also need to set num-hc-interrupters for the dwc3 for the q6usb to be
> able to use its sideband interrupter.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

