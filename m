Return-Path: <linux-kernel+bounces-831679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182FB9D4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC2E3278C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6C2E7166;
	Thu, 25 Sep 2025 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5WwqrKw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21642DF13B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770433; cv=none; b=cauvKATCRcsJK4clFO3dm8rNyS7PV5eGpfh/7jVcJSHXcAjgsrB2iAkxfGkcs3tv+E/+vvqnbZkC5Pe6D1zDyB4eAdXiRbY+a5m0vJLhAIuRY3aBtjNP74Sj4emGaUPgb89kdZjMRomG96O458gwA+3iR9xNAcvG/Cvz3fSKh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770433; c=relaxed/simple;
	bh=rGcUtE/86afTF9uqRK4gYoNc0PprQhYpeEQTVLWaXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRFREf8sHm9flkZvnHHq4kv0twEkoAu4QPzs/fiU850MfeNj/sHVplNfNCqXu2ehAH9uZRpDg3ftYXuw5oeFv8tHkXDURv9TbFe1TxdKAAoBMx11fpXY7YsgHZSPxF0FV39srll6E3CtNBMs4xUAh/PS4HrUayBv4Lyl08TeiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5WwqrKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P14D8A024010
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EmQADFHGa0HAn8WcBDAyiR1f
	H9/wl2rOw2q1lBuUYq0=; b=b5WwqrKwwEkm/tu91fGKi/UMqUBq/ZSASE8bfVzN
	5SVtNJvRiSisHaWGP5gcKbnqLHtJz+AD7MJjlhk6Km5nyiffgvnY6f2fFXF1ipdN
	3V4flFMiKoI0DkUQZh4DDp5C2tUJt5xLVoSIZsRQ1/QhqQKY65MlsOwzdc+3pn+l
	0d2pFkJb4meqMi31QPxEBelWOrx+ak+J0IqexTmRBEx3O8dVql5u9TB4S63lAXAU
	HYkqKJc7Lv9mqX0/EBQjoBZmYBWZAPezIaJuH3oEOOlEhTK3evS3sLR534y4TXJh
	vwAhinnVz6UERNO2SPEkiX/X39+/uPrgevpz7n2mnZpPZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0dkpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:20:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85709cdfab5so119160485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758770430; x=1759375230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmQADFHGa0HAn8WcBDAyiR1fH9/wl2rOw2q1lBuUYq0=;
        b=iTECwIHDhaQZVv8DQOKA7FZdZlCv8Frn+67Yss09UWOJa/yKQ75z4/N/cxEJ+RE4j2
         +XzP4d8HWzb01NeuNKeQ0nESyVc9lQAsj3XkIYufQvoyafD4nyDkaajB/14zM4VQis7q
         ah1i3zxr4v7snfYX7rYtgKTqnWiNdSG98Au7pIhvM3z3DwiD2AxDvpWJkGlSbFFWkNZO
         Ppq91iSFpqXZVc68bCpC5CHYR5ijEiFu+5WNacf4ZSRRHj92Q08ZQSlg9tZHE6X94uyi
         x4AO2oEssVl39YxdChM2wOsSElHArN/cnu/BrnONNJcRs7Z2xsgE3mJTDg9lw2kUXSmg
         iqug==
X-Forwarded-Encrypted: i=1; AJvYcCVbuBrPRl35dOHcyetbnxrto5WCjHlmuUelzYAutgj+8Ct0xeFBessoivcXTs8O5PncHACHOq+jyn73OIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6B0lcEyGCKfjlms3tSM87aSYE6RzbfdH+VrZqod5wDA/a/nn
	LhHkt6gDpIGD/ofMjOk1I2UayYcRUzHlFvbjLk7xI3BDBB0nKsDORa7HBAqF2GxW/lKEEAU7tDi
	eryUibqo0Npi1PYfqguUGVZGrq6VvVUXTLJ+KDZGgu0x+Atqu7uSbOgNW7AJl121gbvY=
X-Gm-Gg: ASbGnctp0te4CP4jZjqyaLWDjqeyKrgnp0X/in9DsJ+6NMito/bCQKLwCDuNN+3u1/W
	BPIg1RtH43K0tugWqaBf9SCWOEV0EDdcO0pAszZAUbGReu/gWt0wM2pXNeqhG/498eNcQEnsHQm
	ULFzvAjnyOwQSjE8ajof6ZvBt9UFHblPlV0ON6x5/+p3fzxheIJ/bDuiYQL/7A2kozlE1QR9GAa
	Mzos8qJqtx8iLRu/hnm2rZc8wj926nI35MkAtHPp1HCXBu2E2awEI1lQolhKS8OH6gfJhE+4POK
	QFwzWUZAbZTrlKWt2FBZXcaW6RHbi4rJrtFTqK+kst23eLdUQZfJRo3YDTV3DxDungOebXBv381
	FmsU2kKrohIxMQ+200X9k7z2tbD4zj8ENKDlqwhptYFlJn9bGdVTz
X-Received: by 2002:a05:620a:6408:b0:85c:59c9:64a8 with SMTP id af79cd13be357-85c59e7e9d7mr68363985a.8.1758770429769;
        Wed, 24 Sep 2025 20:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6OxqnFVf9UIRA9L/037Dq2kcexThTr982bHZ45gWkVyeorxCbqU6svPQ83JrUBf5V5w1yUw==
X-Received: by 2002:a05:620a:6408:b0:85c:59c9:64a8 with SMTP id af79cd13be357-85c59e7e9d7mr68361685a.8.1758770429303;
        Wed, 24 Sep 2025 20:20:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb77101c2sm2273641fa.40.2025.09.24.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:20:27 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:20:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
Message-ID: <sn5a3dqnd4xz3tgtw4vbmjr4pdow4qlo3jjryp5c2sx3wzke4j@fnbexj3kch6d>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4b4fe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=daxzwQADErGqsGprXgYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: MtFy2gJ8z2oyYv8dbhS3go1LqRd8AhnP
X-Proofpoint-ORIG-GUID: MtFy2gJ8z2oyYv8dbhS3go1LqRd8AhnP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX772zbWh8nfrr
 i6fgVLu9q4JFdJiu87sHwWBMnZ44sDrjC5U1Jzby8hpfI/6y/BfkB4gFrz7qmNfGyGY6CpSk04j
 B6xDsX6ovqSarorU2hfkHmEjeqtqFR5I7DpP1om9Y2fkVoiadK38AN/bQPUOfeTw+q/FT+safZ2
 H3Epf8tvcE4nBZWpusyrVXKuPD4gH7ZCsc0vCn+urt9gI46a8FfyNOifJ59nwH5yPtWHf/U/Ml3
 DzMkEUSeYHMbaiexNkAm+oXr5rmi0vqOdNIHS8TO4f8rYmFd6zjVPxZIRkkvJet4zrCfm0AeajZ
 bdyP7JTlvWQAULbYLoQfvP8sxe6ZuYpeC+fOvJUbjmn8lJOBfInrTsNBtLNnlQNeAr0szR0yRE2
 EVDaLHcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On Wed, Sep 24, 2025 at 05:17:23PM -0700, Jingyi Wang wrote:
> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> 
> Add the base USB devicetree definitions for Kaanapali platform. The overall
> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
> (rev. v8) and M31 eUSB2 PHY.
> 
> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index ae1721cfbffc..08ab267bf9a7 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -958,6 +959,160 @@ opp-202000000 {
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {

No update for GCC clocks?

-- 
With best wishes
Dmitry

