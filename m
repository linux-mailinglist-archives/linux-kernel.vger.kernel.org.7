Return-Path: <linux-kernel+bounces-764317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0FB2218D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D78D3AECC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A386261393;
	Tue, 12 Aug 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rl5PFVLI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D62E6139
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987574; cv=none; b=BKt97lNh22oYH/9ftJDMkcHZ9MCkP/vCOcAGz0CrEcUg6qRssU7OG4eqbnUgsy9dLwBAVc9iz0FNBUZyMPO18y6Cc9mrXsHm5lemQPlW0tSdO142pdBlSzaG/vpEb5U04FrZL4GcQYGgNgEMylfb/l2BAFIBw2NysW6/Uy6thes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987574; c=relaxed/simple;
	bh=QbklMDS4M+7Gy4dzmg7gInkywpUCJli+ww3SGtE3dOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyJBLGbE+WO8SQ/o17ppBdGZ61OzsPX1BvAXXR49TOINiz1A/aGR940y3VxKD7WWh5Sl3YbW0lzwe56QLJQUmA7c00iCE8e+gEfhdCHMlqxK2A8kCWd9l6EoU4cFKbS0uXe4bvFKRpsYRfo7VqSwPx/SDTccN6vHgSZorC6UpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rl5PFVLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5KxgP021654
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsGAhOBPhH6jXb8JLaEGyYLWirWIfQYG+A75B8KfNqM=; b=Rl5PFVLIMkTwvV2G
	PNL46chUp4em0p4sYF7iQMs1xSk6nkmQTeIq7r0ptsLXeHFe0tA7AAmBb7HdJmqF
	clp5vz1RZfP/9d61Sc9pZkS3iQrZ+DREH6wE0o0HGdnJw0sSkVdtHdkK/da0UQHv
	ARtzYFDB1W9IXZ9QNC19i18bvBo4uPPJcK8H7pQteADuYqzv4l+qSGnq4s8sI1gG
	xWhhimG27HE7NgWH9/s9zetMMjgQRYBO8EEM8Oh5qEUCRny6O3wwLLlc4SAIIFZ6
	7F8kHu73KJZMOpaUUAyaztcYjPOuf8OyZ6oZMfXnxCEjWLkOzftOTOkpzzxg1Aai
	Mb4mkw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj47d8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:32:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76c0039e0f6so5485834b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987571; x=1755592371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsGAhOBPhH6jXb8JLaEGyYLWirWIfQYG+A75B8KfNqM=;
        b=tDIhYArqWlrZ7tzwosRS2AWisZe/f/9jeDK6MM/41EnwFJEp4pBg1vzyRhJm1RwSfq
         InRxrPH3iZVb3f7zN7MyZ1To57o0Qs9Pe8vpLDMhqQsg+yj/6IwL/cc/slQpBuVHCrsD
         oyPBcegWHwKE9Xzwd7LBLuNDntOSQLqrcKrm/X352Tq5xr2m+tj7O6NCcCXYuYjgRQ2l
         Eh1fRaHHi1ByfBIo9j6v14BTCDfpXo535Gzi/4UnlS9p3EgHAcb/aTZxrkWb9xdzu4ol
         iiHmCjVnZ8EVlKCOBvEgjJOQ5WTsEWUYYxZjBAalkJEEKhazraoNAVn4JYCkeEcZX5h7
         uFug==
X-Forwarded-Encrypted: i=1; AJvYcCVMPVeVJbKjFkB9POa3gvZF8gOyMkeMtLf+yWJlh8cjzz7THNYFAoK5FkwRqfgFf1xoL/T/nv/nMF5WTdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXwgnRCkJYb6Dtteo++d0d+jrcNnoTdnB06nfUXFi18Y5WOlE
	sWI7gDH/uu3Y2ymCdjC9phMpa8fLwo5zgyNxgKKDLApRsyVwZSRdhvX+6pY+Nc9dxdpf6Vp0pIz
	d/REcJxnVRCRMd3tpCsFB/K53xGifEriCBx8+clVKe8EVUDoevEe5jPLpUXVN9Aou3qc=
X-Gm-Gg: ASbGncu90MgBD1RWJvIAu42jigYLoBR+PLH1RGv85GcFl+P5F1l8fVoga1AqEFgHv8Z
	wR2L4VEw0cPjzzSzVgcMVfKmkZlaQlujhKrlCk+3dk8lcP/eSTJbkwdry4IxY2wZCI2IBVeAtn+
	fKlElEwjcYqXwGrdkGMuZJo9CgvYcv3PYLx/R3IdiLUSkekGk9BSPOvSS9i2Plu6OiEwodlMPst
	lWCbOaWwWG8ZSmAX0ZxNO35awfuBodWWGwEcpxc4Lszo/nD3kukdrIzm6I6I6Dl9Q1sWc7FwaD4
	YSuXtqQZdch9FxlX5/XrMDPUti0z/hP5j6tPG0Tp/aB5mRiItCqzyhg5ZpGkr87LBQO9R/yJdtK
	UW738Dg9aq3XZYfCL40indj7Sn6Q9
X-Received: by 2002:a05:6a00:4b14:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76e0def6cd0mr3811799b3a.13.1754987571259;
        Tue, 12 Aug 2025 01:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhR2w6toMfJEA5k8DSMBAr+Hp2gto1dAdBDOIUnY9c0thK8wCmrUNrTBbF64qPxgnoUtOIGQ==
X-Received: by 2002:a05:6a00:4b14:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76e0def6cd0mr3811751b3a.13.1754987570792;
        Tue, 12 Aug 2025 01:32:50 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm28864985b3a.58.2025.08.12.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:32:50 -0700 (PDT)
Message-ID: <23e28eba-3c7e-439e-88d8-998decd2b285@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:32:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add Equalization Settings for 8.0 GT/s and Add
 PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX+8MhTRj+3rkX
 gp5AUWyhNp/CtxF34fAJ931Jyd2YR+741PvVF0IbZ4Qddz7Wn88Z7XcN8DalCt6vFdRJbWEcRpO
 21wV9+CUPEc7AncUcIcDlEBxZU/VWkOi+nfXJjkq2xW0RyyffifuMJJrdczZiQcp+bQYraR+A4J
 p/n5fpaH9W7I+/mosKtowhtOKGzNPl8hltQ+Ueg/FA2MvDUBGo8Ti2beppO6FH8BqIVo/ZnRW1B
 QHCLMYi9nkQIOXAvF5RW4Zru7yK27W2R7ddqHLY8FAYSEm+DwibuCxIbIKtu4Lucp5EUruJ9MP8
 Y2rOdLGpc5nazUXmFEXZN53r8qtnXMPEgNN2BFMvIlp1hplSJWUSgmaIxxWMaqsFRGJju8xQCIb
 sdzirBOQ
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689afc34 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=JG0w1mhhnlL07z4zywYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -fJHZf515kWC1d7GjBpRkL3QJm0oq9SU
X-Proofpoint-GUID: -fJHZf515kWC1d7GjBpRkL3QJm0oq9SU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027


On 7/14/2025 4:21 PM, Ziyue Zhang wrote:
> This series adds add equalization settings for 8.0 GT/s, and add PCIe lane equalization
> preset properties for 8.0 GT/s and 16.0 GT/s for sa8775p ride platform, which fix AER
> errors.
>
> While equalization settings for 16 GT/s have already been set, this update adds the
> required equalization settings for PCIe operating at 8.0 GT/s, including the
> configuration of shadow registers, ensuring optimal performance and stability.
>
> The DT change for sa8775p add PCIe lane equalization preset properties for 8 GT/s
> and 16 GT/s data rates used in lane equalization procedure.
>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
>
> Changes in v4:
> - Bail out early if the link speed > 16 GT/s and use pci->max_link_speed directly (Mani)
> - Fix the build warning. (Bjorn)
> - Link to v3: https://lore.kernel.org/all/8ccd3731-8dbc-4972-a79a-ba78e90ec4a8@quicinc.com/
>
> Changes in v3:
> - Delte TODO tag and warn print in pcie-qcom-common.c. (Bjorn)
> - Refined the commit message for better readability. (Bjorn)
> - Link to v2: https://lore.kernel.org/all/20250611100319.464803-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Update code in pcie-qcom-common.c make it easier to read. (Neil)
> - Fix the compile error.
> - Link to v1: https://lore.kernel.org/all/20250604091946.1890602-1-quic_ziyuzhan@quicinc.com
>
>
> Ziyue Zhang (3):
>    PCI: qcom: Add equalization settings for 8.0 GT/s
>    PCI: qcom: fix macro typo for CURSOR
>    arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset
>      properties
>
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  6 +++
>   drivers/pci/controller/dwc/pcie-designware.h  |  5 +-
>   drivers/pci/controller/dwc/pcie-qcom-common.c | 54 ++++++++++---------
>   drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
>   drivers/pci/controller/dwc/pcie-qcom.c        |  6 +--
>   6 files changed, 45 insertions(+), 34 deletions(-)
>
>
> base-commit: 58ba80c4740212c29a1cf9b48f588e60a7612209
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

