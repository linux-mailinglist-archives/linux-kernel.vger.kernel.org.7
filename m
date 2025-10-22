Return-Path: <linux-kernel+bounces-864542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF2BFB07E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6823F3A702D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E43101C2;
	Wed, 22 Oct 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sueq6TsG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1730BB97
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123686; cv=none; b=iHd1tnz005WVtigXwNju3FPzse5p5umK+c2JPwxsWvgEtzLn2qLwz2kw3XcakcSUNuB30FuWOkrnKT17gyswYMirHSLuzSiHnfCLjwaw2z8UdvFTIWaz0P8JSILCl4m+Hn1kaEFFkcgaO6putT309sQrbI+f2jDkYnPyE3SeS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123686; c=relaxed/simple;
	bh=5sCwvusLGqime2/Jy9aXr2cPI9fkv2LkkGeuCX9BmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1VvOvFZCH742zzheCq06A+EjRGgeyvuAlpPcv2khL4nK2lWHFWTxl245k8jRbz5njLX57Pg8YMJwTCbBdDmyHiT9gRxaihNSOX6Owy66nssHJiYyXvfJOXluWdc325w8jg80A/kjJxl2H4D57fWS+CkPU62SoYsn6qss8+yHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sueq6TsG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M1h6M7018736
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ivByTKhSESO0VcSxSaiYVhLG
	ISoDBO/7JhIXLIxz05I=; b=Sueq6TsGpWeoJOGBcFLsAoEpnNOT5Zb3CGY8mvZv
	gfOPV7k9z6T2f0I4pY5ky6HGf1X3WfGCpYKcwdW3b0oju+29JAlCw7rCH/ZHTvNc
	GeVIh467mrIM7SQThMhMtAX+diha7PqnQq7lzfhdLl6RGLU77jbfu2Y9MNsH3bKK
	LFX+P6QG/ANcyg7YTtLA5ArjjNVXGKIEC7q8sMLP5O6GbCI86mnLZBUG/x7qoxYU
	aO9HyHXoKSu6vOQYriUK4f7K3tzly/Pm+GspcFlmtPu6EgPDS2MzxP5x/t+/6j3F
	WSOJl/FYYfUlSJzXQCAikJHggiJmwnvoV9ZRJj6q2gum8A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469kxcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:01:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f610f7325so5596587b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123682; x=1761728482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivByTKhSESO0VcSxSaiYVhLGISoDBO/7JhIXLIxz05I=;
        b=FHVZ/oDJiMPMU1OTacfNYOAWWLikJAOUQfHHgpnk8wQOw3zCtJ4YS1V0ypOUWnvaJR
         xiat1xIEpAIedR7R2k68D/cMPxhPq+vDm+c6h7uuFj+LUYvViSZ+5K+LwQ0a+quX+YGx
         9nEK5ucC2vj8wVR2dQnq/KrXp/YzBs5Hb948X2gprC6ylK1PFJtZXasHVBXOKmr4NCzt
         dR5S7998epz4v2p91MQSRTrqtESE80n50WwLOmGsm43Js/dzuhn+WppRFe4Fyv94B744
         FFwSvalVelMryvRd5zEi9xYE28HN7vX+PSC66epHYYhQ2ugbfchx4u+pewB0KNEtWbEo
         z20g==
X-Forwarded-Encrypted: i=1; AJvYcCV+yYXN0rrzpAPVJFN1Naz+a1e3K7pMhcpjuk9R6aiqXb8/HWAABfdNbeqdjgbNSXpl3EQYt9e/ygJ+9Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKyzgysj+X0jf6SFvKpL/toVvDNh8wZbdiQulP1niUShs8/n1
	El6Lr08astTgALxP/m4fvF5+XkCdZmBpY3XIfqUxP0xAoBRONXiRGPD6OB/VR0n8t4f05RF2BtF
	9s6ySU136tL/h8OC6++MUWkJx//ZwHk0EJN5vF7vmcpTWs+mE4zDJp4ya4KALoVOf22I=
X-Gm-Gg: ASbGncvqOg1+3MUFR0oEUXodg53JckMiHgU+FEL7RfmxzYwIp4KYGBkx8jmI3MYTKDw
	i0m4aC1UrSk47bqOedogk8kvnq0KBR05hIw27/eQdkD3kiVMB8bp0M+C2kSNUTVFFpWteTKVk0s
	FVnYJehBLs/n6ejEgNH7nX9wdMiJJb56Ll+whmrN+2oOk0zekMURrws69ZZjANgOZX3UGYnLeCs
	wXnLEO9PKrgl3WskPZC+6WDsYa+CdbMDvfnEzpTf8wrN5+J2qQrZM9oygrRhpcQsfDFjCkBlobV
	1uLBi4xFFJ25VgSaJHwISQV4/7ABoaA7ptOmRld8hv/FSfdS+EKgyhUxSFH/XUqjUrj591yb5Dy
	8VuYtZAAs+yKMBDUo73PkS+Vt91ar47ZFbJRIINKyb2KOAg==
X-Received: by 2002:a05:6a20:72a4:b0:246:354:e0ff with SMTP id adf61e73a8af0-334a85242b0mr26308719637.8.1761123682224;
        Wed, 22 Oct 2025 02:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrlAYEvjmvObgyZJEcggou/JfliOLpgFt5Kg0VJQSp8IlUPjr3+XSTnue892eZTAwBzkWAUA==
X-Received: by 2002:a05:6a20:72a4:b0:246:354:e0ff with SMTP id adf61e73a8af0-334a85242b0mr26308680637.8.1761123681758;
        Wed, 22 Oct 2025 02:01:21 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cd9005e2dsm2273885a12.9.2025.10.22.02.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:01:21 -0700 (PDT)
Date: Wed, 22 Oct 2025 02:01:19 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v5 6/6] phy: qcom: qmp-pcie: Add support for glymur PCIe
 Gen4 x2 PHY
Message-ID: <aPidX8h5z7/A059s@hu-qianyu-lv.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
 <20251017-glymur_pcie-v5-6-82d0c4bd402b@oss.qualcomm.com>
 <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxju35izazp7zrzs6vyy2cxuynzc6k4i4iot5pjahwl2bfoka5@cutpfodvixmp>
X-Proofpoint-ORIG-GUID: YfbmFFjClFGEW2MTH9nYjJXAdFZW7sza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX+M2AtF6JUAAm
 2NGqbuzbQ+I/yFIHKQMxh8jo4ZoM6+Vt8KGICu1L4FzZE+TN5COzc7bbAi68laMEmGvPDRI0bSS
 IsF8Lriwnw9f3FgUmr8MTKe0KR7/YX/F1eUrwFmE6TuhEE89PcMfBrrY9IpCZKwdDe7/cAQ563L
 4X4/E8sxa2c1wpwRBOPvuTeQAQo0HlWYSjL2XNTLLcnrrSFSnN8GS8RQXXhzpcNNnvmMpaYEeG+
 Qv7CI7ux5mHkSpJ7V0CyCRG72n7U3bvpeMubUfUo8JSIFCObFvQ9agnL/6uuCfpYDxtxqPBAZQj
 tLKdHM84J4axBf9p4srU3zCAOnEXlyw0py9fcaGapZZAgu5MgW+L1/RXhh5ZE+gm7y/bE3Pw3np
 97z/YVNtRaU3/3bxDmv5qTN44HJXag==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f89d63 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=YTQ-dMB4pklsVi_CFI8A:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YfbmFFjClFGEW2MTH9nYjJXAdFZW7sza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On Wed, Oct 22, 2025 at 11:53:01AM +0300, Abel Vesa wrote:
> On 25-10-17 18:33:43, Qiang Yu wrote:
> > From: Qiang Yu <quic_qianyu@quicinc.com>
> > 
> > Add support for Gen4 x2 PCIe QMP PHY found on Glymur platform.
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Since this is something I already sent upstream here and it is more correct:
> 
> https://lore.kernel.org/all/20251015-phy-qcom-pcie-add-glymur-v1-2-1af8fd14f033@linaro.org/
> 
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..2747e71bf865907f139422a9ed33709c4a7ae7ea 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -3363,6 +3363,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
> >  	.ln_shrd	= 0x8000,
> >  };
> >  
> > +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
> > +	.serdes     = 0x1000,
> > +	.pcs        = 0x1400,
> > +	.pcs_misc	= 0x1800,
> > +	.tx		= 0x0000,
> > +	.rx		= 0x0200,
> > +	.tx2		= 0x0800,
> > +	.rx2		= 0x0a00,
> > +};
> > +
> >  static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
> >  	.serdes     = 0x8000,
> >  	.pcs        = 0x9000,
> > @@ -4441,6 +4451,21 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
> >  	.phy_status		= PHYSTATUS_4_20,
> >  };
> >  
> > +static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
> > +	.lanes = 2,
> > +
> > +	.offsets		= &qmp_pcie_offsets_v8,
> > +
> > +	.reset_list		= sdm845_pciephy_reset_l,
> > +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> > +	.vreg_list		= qmp_phy_vreg_l,
> > +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> > +	.regs			= pciephy_v6_regs_layout,
> 
> Definitely not v6 regs here. Needs to be v8.
> 

Hey Abel, please ignore this phy patch and dt binding patch for gen4x2,
Krzysztof reminded me you have posted patches for it.

- Qiang Yu
> NAK.

