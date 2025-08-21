Return-Path: <linux-kernel+bounces-779486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78641B2F4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24783AA030
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7A2DCF77;
	Thu, 21 Aug 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EeUCq43k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB102DBF5B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770235; cv=none; b=s+hedDDlizIpyCHOgHQXRY5yvEeWhBFSqQ9FxJyAa3Y3VHPqSsTwqgSW8zXEyZzw0HSOUa6OXAn0KZZ69fZ2Mj9ucXc0/OPRDfpYZWw8137v4geR8OYFASEpbziSCs7s8apbHyohKs+4vvG6abQgzByPyGKTvikA0cS4YK3vXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770235; c=relaxed/simple;
	bh=IOpmcn53PEqkS2CYk/u+AVkw5l37Cd/P5pjacTzQpXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFVDN++TVk3wiQMnEvDCs0D5iyQlLQ3YBEB1HFp8sDyTzXws8rbtjWg+9scKqAmHv5lI2tzQgH5CERWGdeoNCHsbyLkkiDzkvpqUxIxBjdwQfN5R3gDA1gFQcc2fNSED6OKFx3dHeaw9XOQZBpW6x8QFGt6gF5kk1hy/HOKoDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EeUCq43k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bAqx003687
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SVb9XlaHh7NAzDiLQrW+htsh
	4PsmGg/oSLr5rbvMx1c=; b=EeUCq43kFHXicsz1AxT5uF7u5O7rqZHJ3xxwAfDn
	dAoz5zy3dbXp0J6cgkRG4hr/iIR0La6XgV8F9I6IXxukzNVZPoptQT1yxaSETHhj
	h3v+w/wVHnn4dd4Xi8SHUi9E1buREiZZWRHzrelcaYEXInWbYpVguQJauIslnf5J
	3j3t1ay1quy42AoFzDT3urFsMCq8kd1sm+iPhcyTFyaqdJoX9N/TnLazKop4tQsn
	xay7YO2vRCMPZLjTsmiztnMjV4KwSC677fYCNusqkFV527BBGMVto7NCs0jreSuH
	3HsxigaDt2xtUxgyDezqw157YdLDSH2WDBXBuE4Eol8U8Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdju4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:57:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88de16c0so17875126d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770232; x=1756375032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVb9XlaHh7NAzDiLQrW+htsh4PsmGg/oSLr5rbvMx1c=;
        b=SjB2hfJiSUNnhRd1fh975TzDB5S6kVUwZY5jduDS7jdAlyIQ8eXmMScY0NOZy5hcNc
         kFeIZAz+fRYAIS4Sc2ykkFdxytMWsUD9JEPXKeon7vH8ldrUELcLHw+3EHKLvwV92Wbc
         urdGEyjFS33sIex8MBGpbv93TududPEidbRniSXQ7eila39sjkds6UFrWGYhrwXGTIoF
         OWROOCzz1syeuT43mrZ0K0ZadqQbUo1NdZN7qG3hhWmgCQdMkieZRY6Gzoo7rzodjhSx
         G7OtY4cRtfh9BU2NKFFmxkwUfsCUqAlgBvJ55lODCz6/GV+MtYlIn1scH870yFvlQgFJ
         UH9A==
X-Forwarded-Encrypted: i=1; AJvYcCWdimJIdfFm+vR2yuZ5uArZCbCWJvj7tkX4Ff15d31Yn9UDGTzSwP0xB0TilwLOHIpoJcoFEx3vzoqMkp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZLM3Jxtms4boY9HCIOVw+XPHN75w95GNlwfefUWg1vO+J+E6
	gVcpPBbi2RkCw9bq21rD1j3yd7yICnwSfuybSg8SoVfiY4LT+BHXC35SDTmQ7Pv7Scv5pcSofqU
	5xqrPXYYITXxrSmTMCnyz7uyc/0IrezGWeLgFsKa9I+OsJVdbvRka7Oj0h37IqYByib0=
X-Gm-Gg: ASbGncuINaGj5Vjfpa+nPHJzTVfxImOXBn2oJLrikeix/nhZBcrZdL+lcaD/onite8w
	+0zTXjVzeH+FCM1GwU4SQ6XvaaivbQj2dNqT/U8z0Ux6OKCgHVmF9b4O4hXc3ofGbjtjsc8Ia9H
	wQoQld0oWNzOHJ//Z3QhUffbFU3MLfNM89SNV2aMUCtHGj4r02IxCmcQ4UdBqZ8Ep3v7Xjm8nCV
	azV7NTMHmre3EwCqc0k+SkOZcokYyU9BIGwvDS6Vn06ahIW8GSKXUJwTV3J2L7/buoYWGW5HJ/W
	/E4TOxxogdvrWYFDRmZr5Wpe4KjDC21xR0Ro97QZGlGV1ymBqEdibGw5SClGAJy1VLKQLl0PhEm
	uhVYtgFvtJ6+Zge0LpeEWxRnyo+J6Mm6MDbDM7rU8xUZNYPk4fVYL
X-Received: by 2002:ad4:5c4c:0:b0:707:56a4:5b56 with SMTP id 6a1803df08f44-70d88fd7384mr13862756d6.40.1755770232111;
        Thu, 21 Aug 2025 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWaMiKK7y86qlSXKsjy23FxD9WLBPQ8WQUmWHwy0IkQdYYOWie51bXUGTqyoqGxLizYaDnQ==
X-Received: by 2002:ad4:5c4c:0:b0:707:56a4:5b56 with SMTP id 6a1803df08f44-70d88fd7384mr13862556d6.40.1755770231656;
        Thu, 21 Aug 2025 02:57:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef367728sm2973854e87.56.2025.08.21.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:57:10 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:57:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Message-ID: <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a6ed79 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=nE5-FXN1NE7ZT85CS-kA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1xVWSXbO3O5w2OG2ph2Gm3sPJuTz1GGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX6bfkXb21npFD
 0afl6s4LQAvfSIRgvuJb6f5/fOzsNuqWghbaPPSftkJeK8Rnsx5ReYyxP0C+l82dw+Q3rek/+qR
 OQ4Bi/IddrfOxGb8jLxYWl8+6Zp+uQJ1sFn0GDHkqkSDT+rShsDNCB/zKGu56fH7LZSpXE6kOx+
 bXeV7pjpxqbSNK0+D1Q8CFbf9q/14DKC06L1Dm+Ey6BN0IJcJ0QoMq3LE+hIKEsrgHZeZOeFKNn
 ab8DK7jDKRJz23acem4K71b0OYGcaoFpuBbaKK9VjLWh8hnubT8HmRNQSCSiZAT3O7AFM8Kct69
 BdwRR2IUQ3fp8+8XaevRtMe9e6wr5UJL3+EDybiT/s0U6yh0JbUf+k0ijqsiI9Zwf3u8R+r4J0i
 vsh/PFTVRY9Yf/u8UxOb2vwXxpap/g==
X-Proofpoint-ORIG-GUID: 1xVWSXbO3O5w2OG2ph2Gm3sPJuTz1GGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Thu, Aug 21, 2025 at 02:44:31AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> @@ -5114,6 +5143,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>  		.data = &qmp_v6_gen4x4_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,

Please keep the array sorted. LGTM otherwise.

>  	},
>  	{ },
>  };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

