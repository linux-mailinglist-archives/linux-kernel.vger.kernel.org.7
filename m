Return-Path: <linux-kernel+bounces-765743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4026B23DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DB43A8744
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278819F461;
	Wed, 13 Aug 2025 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiB6wOPv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4117333F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048708; cv=none; b=bP0vLDHXz1RYOOhBsHiqIiGvyfNeyiP++35vyf0KzE/yQ537i+F+quDCUg6KWDTWsv7qp5bIxS5dcNramIgCgeOQXVkWEmHpxq03o8lN8wBim2FAoWBeKOQ75ZcVmg1IpmwhmrGBvmj6RXjvUkOM2/yUIs4mTD7zlgpg7f0Oe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048708; c=relaxed/simple;
	bh=MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1W+KYYPy4LeNsiMTpUS3SPcC0BXAj5zcPJS28Nah13eeUhJLwMO3OT1wFs+ah1dV1ExYa6m5cRuTl2W9DJrk5DlpqsIGOqb1Gqt6xHpL3YHLSX/aBTqTPD3/X9L3M2ZBHfio2TE2rRdNFQyD83rNaHMwlof1Uga/6CSK3ZXfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IiB6wOPv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKXrnJ032229
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=; b=IiB6wOPvYXwAKf4H
	3/5ujJyGZpMq2KmwJJ8MUDUMPmhOg6LTMPvJY+5VQRhRUBcG2HSGxdyrIg9wFCyn
	JWlCSeL39kioCp1HNWSG2J8g6n1yRorLsefD+ozoJY1q2CE3Du1/5az7l3Br4bLb
	Kxa2n+GhYeTjn7h8jKjky4mhvKFzr4ATAp0MgU0xlwy3LnOqpm5AOUR5BxPZYAMf
	cB+flLbu68MCm8sxnUiRmzmegr6up+BHxPQXJ6DGkaOcIeUfm9kc7N/RQQ7cIaa+
	Nm5fPdevV650KCEApjTTlFYQruZu6AJ9Zdl9Xt22agft7PMGOFHZNl29HAFN8N2s
	Lx5XWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vmwsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:31:46 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b42a11d7427so3810146a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755048705; x=1755653505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=;
        b=qNWV0WW7uVZrNnf2dsfaX21iF20TZprslIy8Fvs9cmNtPHIbe5zOlf/kNTfLggHF6E
         HCLvEIFA0ghTJyRyJEDWkiIOFtWsqOLfoSiVj6/W+FEE+TPwBKvTge6j0hgucj72VoWJ
         cAHzVHFSiD7GQ5EQxT8BLg0YwPdwexI0Y1nYOGVhr3/Nd2Izl5XhrPygX94+TytrAVGB
         WDxzTu9qXM6OvYpQQZ4sGcnlns6S2dilFEec/yXGJrDVc2TFLjVgWVzwYFl8n4DSFPrA
         IqoK3GpbH7cbs0zIgWl4GG2FqhUmtpIqBNlOTg3NMJ33m2+JUQorLFmZpsg0F2ANmwGm
         ysOg==
X-Forwarded-Encrypted: i=1; AJvYcCXk9iGRtQFVodfRTmVgoUrdWgUrIpvs2vAxwjQlrBau2VUivuAHvqO1RXCfKArLOt0vkGJeEU1lRa0RC/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx74cBfa39Jkrp5y5l0KR4nAwK8CdNDBx8+RCwuKSe7xFfAcCT
	EbkfMDD5H2jbZlGnUyD9y72LiLj8GKwLgLdsuR9Xxo2FNvU3Yx+ax0kLhMlTRmPZDsQjV2UcOsk
	IZcxUm1dTI1ZAyS802jrcCGUPIwY4+ZqT3Zhc6lsIJfdKLmvfboPw603fhPOkHB380bs=
X-Gm-Gg: ASbGncuzAek5K15QilJA2Uh1KUiGZp2DDhRBRl5sT9RR7WLiXidRJnW+RmwvFIRcMmI
	pd3RNselFpxl8wpAWmZmuwJysv/26c8GD7pptuomQF/BhRy4/gxFFcUaC+UU9O4j7b7MKSNg5u0
	TebTku811czCRCIWLLRZqXP7BpMdI5iEVbC9eOopOsBwZzpYzS2mqNnvuVSQIfO+wIIUn+SQyMl
	KFtGcztKS0kkNWt2I2JpGuL6K94zmTzlbrtydhy9Xe1YZOmdCbdhvhQ9XfVN9nxZ+IHJA+45aWn
	2U+aaV0uhxnHTk+b3RMdMLSVmqDv3K16iMZTneTBusq+MqMoXKKOvgX5r7UbsyBnSRZPR06dFJ0
	ceB+Q2XeP1hOaX/Oe8E0lJ+fXx+j3
X-Received: by 2002:a17:903:3c2c:b0:240:bf59:26bb with SMTP id d9443c01a7336-2430d105d69mr17783125ad.19.1755048704739;
        Tue, 12 Aug 2025 18:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdQ1DXAaDzxKmVvrKlv5h38m6LWfzDz/yLj0/n0px8bSRgCo+HiXsqzUIOas6zP/ZN2Hi6dg==
X-Received: by 2002:a17:903:3c2c:b0:240:bf59:26bb with SMTP id d9443c01a7336-2430d105d69mr17782695ad.19.1755048704225;
        Tue, 12 Aug 2025 18:31:44 -0700 (PDT)
Received: from [10.133.33.58] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef83f3sm310234365ad.28.2025.08.12.18.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:31:43 -0700 (PDT)
Message-ID: <cef1da96-f584-4100-a97d-640fa24e5f54@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 09:31:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
To: Vinod Koul <vkoul@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
 <20250811071131.982983-2-ziyue.zhang@oss.qualcomm.com>
 <aJsYd7tAi4CdOfZ9@vaman>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <aJsYd7tAi4CdOfZ9@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXxbiFXtE9rQr7
 nww9nozHvqd3+DhAHZ5QHESmi+lr4EH9Y6y68CMahjjxb8/tvtByuNGE42qIz1odbLQOcS/lLvi
 OuBj7YLQWUXVbW93u0aSSnLLkKJhUgrLpO5khMFuBfaTrLw4fXvGUvij0yzAwWJGMJX7zR/7n5h
 HpDUJk6ElYHi6x0lMzALp0qRm/6fvUeHlj0LaZmD2KLew3sPtCX12iFdMixd4AJcfpvOu9hGswr
 nYTUqq9YyIaRbrC7Mrs1eXxxOCmYF7YuNHGPuSIYkDb5JMTsYITNq0+dtIxuKFbIDlpdMfingWf
 aW2ddOsruR63O8aASHnvfoD9ZTr/F7ZqT8UZzubm5qeJwpBC293zTcb4WktFIHQJlvX4TcPQRiS
 2kfJ3c8c
X-Proofpoint-GUID: rxSVoRR2-ujZhTriblmKmk5xCvSHaoUY
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689beb02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=buFmA9CyAF0SDTxNqVIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: rxSVoRR2-ujZhTriblmKmk5xCvSHaoUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107


On 8/12/2025 6:33 PM, Vinod Koul wrote:
> On 11-08-25, 15:11, Ziyue Zhang wrote:
>> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
>> specified in the device tree node. Hence, move the qcs8300 phy
>> compatibility entry into the list of PHYs that require six clocks.
>>
>> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
>> used by any instance.
> This does not apply on phy tree, please rebase

Hi Vinod

This patch based on the patch you applied in 8.12.

dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
commit: aac1256a41cfbbaca12d6c0a5753d1e3b8d2d8bf

Can you try to apply it again ? Thanks

BRs
Ziyue


