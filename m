Return-Path: <linux-kernel+bounces-878055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4495C1FAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 523D734E10A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F30354715;
	Thu, 30 Oct 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEK7jHNi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C0pKRWBY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CC263F30
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821828; cv=none; b=tfejrlCJN2MT0FB2+gO7Kg9fKK9jayzFwXBIoMY497Lz8pUU6o0HZp6syDGqSm4uQp3p9MGniM09+PNXzTQND16gP4NI/lqO14/YAoH8ZkuXI1Fayc15lEwe5s7Av+xCpXbh5ACUpi0AcUXmkHGKJc5P5YgosHvhPS8J7VGaVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821828; c=relaxed/simple;
	bh=Q2iNvrKCt6EjMd8+5wqrhOR7IupMUVpIUZ8n3cJhwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBzcp3jbX7NJzREKzubefR2ZNnTNaFT3qIt5hDbEtL3LgS2W3BNo5QvNpTINUk4AkFAD0JMssS1xQqsnQcKF8TW0mYbxD1k7JVDEZAbeyaRpDJ3C5DP68Xuq4FaDRyz+YIL8glHpCBILO7V5Z/hFL0ulrCSmTfj16/p1ErmCIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEK7jHNi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C0pKRWBY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9PCv93508681
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3pEuAyNGKBOIpdzA6LIfvBm7X71hRcwKlUkme33lXWM=; b=QEK7jHNizowWmjpF
	ImhCH3zVNUF8KwCZIrt7i7QzccwymYkFyBdHEepwQ5QOldv6RIStIV2TXTR9osS6
	6xs85jBSV0faWzZJlO0bqmcDYMtJA0AiDOMyAcT6fakEh7vo1kOaxQEtAtXnlRg4
	eE7rEha8ivBY8hbwUEVBs6pBcIFPE/l4XCQdHN95G2SS4w+7KAFoXRjGCuFB2vpJ
	Hn1q2nRfrN+q+jctdEXOBJzY4WyppEIctNewmsQri8EclBVG5F3IPakneVjS/kcV
	TWCHAI5ppoxwqukOXtiy+yrwPA6J92AUJ8K6DDrPygYVFc9aj4I/IW7E6IJmsVej
	3CsZMQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45cdg8pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8934ae68aso2147451cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821824; x=1762426624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pEuAyNGKBOIpdzA6LIfvBm7X71hRcwKlUkme33lXWM=;
        b=C0pKRWBYq435PtBS7lowzXL8aXZXbLLYxu8CzaAHCtuyQtCup4IIMFROpNmZUQwbD+
         h+L9Nw3OEfg8ppjW2uGfz4blUrteJW39/gWB+7pgtC+yw9GifEYZFyEFGC7szjfRL1aV
         UH7o2P92ns4DcbjHsYAfQN7pKw1qoTKxEzG11CZjp1RyZ1nVuRISizJ9QVqHlkZ20qFH
         4ShkQ9edGj1aAF4X4MU6g4Busb5HYGn9lrITXOhNYJ18iJrrY5OtyyHUasHY0/AOEBEP
         wcpFyLQzZbVQwvE5FplR9FtD+XGpG85BiHC5NJs16QM4zFCdRvDIe1+3lvxZdw4oA4iH
         KQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821824; x=1762426624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pEuAyNGKBOIpdzA6LIfvBm7X71hRcwKlUkme33lXWM=;
        b=SAcPLAR1DV0Q9OVtt3HLaze3VXKCgVnxjyrqZ7vYNBWUY0V58XczdsJQWVlqwRnPyP
         pByc2AXuEK64i50If0Ax7Utob3auwL8PPOyKsoXwKWit+b+LbGlbFlD3al6ap2ENA/Vb
         VoWJk1jejollK3OmSWqhp/icfeTBZYod+UKOCMYJE7MUiQBPkAbldD5HAvh7F3gxSH6q
         pZjd/hyLAzR7H68v3gpt7kUKB8l/sEDjeLuCc1LiWrrFPXelTnMVf6EOeaSo5RHMv32a
         zC5UufH3QIMYQwUd6/JtaqB2ZIAuEnONFcc4bAWPEKpNdoLvIsCeNJnOC7iV4MfcVjLQ
         sUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDwnjHXh3ykTjvRlVuHrn517FVKLYY66I77HfcOJMjRYodQ+M+7Rr7jTEKDdiC+lpMGQykQOv4ZLGi/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfbJvhl5sLpfuDpQPFViN+UUiB/cctQ/botxaWzdZoWbtQdeY
	cpj6IbmVdZ6KZ36I+srFXSmEjvE0bxxBjddEEtJJ4ccOkgbBZ23b8OJx0y0kI9rDosN7GmFnmqg
	NbROuOGJwPCK5okIM/JIpHWYTIRsm1mYlyqFlS9KTNT13Y3MAYmfQ1JrJv8J4kPw3gkA=
X-Gm-Gg: ASbGnctbsm1JtxiZcpVoCiTM2RPXasnPom6GehmZUE27t3fRr5NP9kE6FCAa7VQN5m+
	FQBvmNBT59hICeS43Uf/h6qmbcSsCqpD6EMuO2qUP7bdiP8cYb57XNZWMAoWW9BtjJ6BQ3pooBG
	RGgT87zIctcu3dvtrFHu52xc7XunXoSq/A+E4gsoKY8HBtiwmXktmMxLl2s5/s/YTylZ6ZKBnq0
	QNZJDrKSU+spAZa07Zf6SDsrOksMCSGPlxOTjAmXFtbw7uSd3b1hOuy7FI0/lh7wYP/VGCgIx9+
	FnSv01m+yX5Z1xjOR7Cgh0t7hBMMALJBX7obaTJ/rnEIvpw7pWfuEpNFOm+Zj/zo+LGdWWQva/T
	kejt/TQQ1UIv60b9rp3BRjcaaGhfSI3qPJR/fU3X5Zy7/o9WbKJZasD8Z
X-Received: by 2002:ac8:5a15:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4ed15b8a566mr47304581cf.7.1761821824345;
        Thu, 30 Oct 2025 03:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp/RgZaAkheFE4mvhKiSDpqtGFpbIRQNzBWuC6FBshCSE1O0nllTAOESWCiyF6a/2+gGUbbg==
X-Received: by 2002:ac8:5a15:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4ed15b8a566mr47304271cf.7.1761821823588;
        Thu, 30 Oct 2025 03:57:03 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8544c9f5sm1734960466b.68.2025.10.30.03.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:57:03 -0700 (PDT)
Message-ID: <b7ffdd93-8ec9-43c2-84c4-57d2ba77dc71@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:57:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sdm670: create common zap-shader
 node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-1-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-1-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oaZhk1vY08oEK_5pyvjgW1fBvLluEF5S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfX+QBAN9ZLMPD7
 D5JTv8pZJpmtfCufr/yeE7e3DgGo08LA7SyNtWpiFgSYSMG8ZFZ2zd8UZ/50AdG7BO/Pe8+bCz8
 ttRoevb/TUypjeDkpuZjVAOvx6+kfjoI8+tSOHUmDBvIAswgNKEWS2+vH+K507lpWydSBbUShZd
 H/w5z1kq2hzoIe6bZqx2JDW2xzNpgEirqCPDOOFECkuIEFndnCFK4sPfHpKODFi/lRmdSsXp4On
 Bf2OuOVraySagVUt4G818di3g+DHmGlEAoAwAEdGffHjC5Gqg0gjd5HxczkxNVt4KUuQE15Mk+U
 SmHHQ9GKWJ/wtls7LwH4qbVObL8IwAc6BCh2GCAYYuuqynT0pS77AUwDiXnDsTCmv4BC/tTmU2H
 kRnYQX3IgP9uxqLdDyVAFX+Ge/w6Bg==
X-Proofpoint-ORIG-GUID: oaZhk1vY08oEK_5pyvjgW1fBvLluEF5S
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=69034481 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3S55o6r4CRsqHmcx2iYA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> In order to reduce duplication, move common GPU memory configuration
> from individual board files to sdm670.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

