Return-Path: <linux-kernel+bounces-845387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53848BC4AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B33A29D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E22F6186;
	Wed,  8 Oct 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D17arv5Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774461A76DE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924823; cv=none; b=lIlmeSqYFtKnrWtJHNf8VyHBRMgXxvzCwxlmuHi3NnIxIJSsgp1Vo2Sd351NG8uyRfyamzupEmaQHQoJKtHqU+NLaftrlpl7ZLuhfHAcizMrP7/TtjZTimTppkz/nGq+NuvVQXzt2HLh4dnTTQaTZK3HA4gBiBRv6Y9J0+FbcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924823; c=relaxed/simple;
	bh=4vMQxz8vJDFJ7PyFDHhD7SxqVaewjjy4uYlnHVW2M4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoTEIU4UHnLElkCNXcWQ4QLwgK6MaSJkiJEekTY3FXy2dI2SLaaA7KnYer6c6BlesqjYd97AZuhP2oJEc/7jpg5z8ddj6NBa08AhuEyVYczDfQzS/BIfg6c7V56MPedJcnUkwZ/1QCGHZ0Q64H72hJKHQZ5WST2ywOmtDExRknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D17arv5Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890VVk028952
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uLhdPwh176J3u3H4+MR9RBj7
	7/mlh5xjbvtuKbEqChI=; b=D17arv5ZdJZ6Qh4h4YtBT5rktlFlwB5RSg50OzLx
	bo/10mGSmD5ZOMtheohUoQA+x0+u/sV0Yi6R/oOBu2F+2C3jyC3foYN58xopGVJU
	L+Cx87wWk36FxetmlWo+ZAvoR12AxPWfEzaGoxBzCihmbJeqLRrFV48ru0Hv89yW
	yN9PiOdTRkKUKvIEz9vAR7yeZc3K1jo2sh++w1hMu7YH7Y3r0q1KPr5LMoz6fl4Z
	tOI40Cg6mSnqXD9AQId5wYlO9y1Gfv4FPgeeuTbliNQwrDmdDSnIeRx3cI7XEEQS
	cDZg4kmbMKp3w2FMkKXNEI3pz9Xjn/8ocd5lb7oZ5Clv2w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgtb29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:00:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78106e63bc9so7387403b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924819; x=1760529619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLhdPwh176J3u3H4+MR9RBj77/mlh5xjbvtuKbEqChI=;
        b=Q7ga9BKsEoyXkrr1bQn4Awke/Vf+euDOubmvLqsInqzxTNKTCHntRJgPzDwx63ytAM
         AFUAx6PpM7O5v4/3doP/8KVfsi2AC8k9ijfezF51Chg/OEIFQICyuqxVYHU8t5cU5GPM
         mIyO/rv6f6FR6QHGmoMU8H3YeQCBxtTruzuS+x8/mRCc16xew9n+7MfHgdXLnVRfQBh8
         Zh202gQMhWQvozaNohCCKP4EJNZU3vo+qCAWrWfGVlUnuC5oqSbNy7ivwg01Wfhw81Gf
         UQ98HUCSI/qX2Ejxm5w6K3vF2tzszQM04Hlqrg6sx1nkKdy/3v8W5lOj7UOYimieo3Hf
         W69g==
X-Forwarded-Encrypted: i=1; AJvYcCU4YzTdXFtc+jfJJVbQK6mEWhMn03x2dLwOazdbTY8yIFnU0/EGe5SFeJXJCol6+vMdZh2CDHEK7gNyp4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4x4rL0xrH+slIPy8WJurWgRrScazWaF41ozMyopfwxJSL1snp
	MIcAEKMkrTMwecvO9K78679EMibfk9QWeDNLhBI4uFN9OmaqcZjtIcsixYVPc8oGhh6MuYMuDdN
	2CE/L8K5Hl/jtTBK1rPCNH+rjSDHlG09la+UavD/zaDVvOEVSCszmo/nCknws+T/PHUk=
X-Gm-Gg: ASbGnctym/VBEJlQQrspyv+aknruhUbMmd0AIJhPhDoBNH3ZaT2Gvx1JPrqTuDH/22+
	kM+owzTm0da2YZQS6mK9A2GOzvPHu967yrivCEeQzp08gGGmcZmBmxRbJx2ps1LNOGZl+vMjKoq
	fayKXH73UaYdVIxqWnmdpCzJjKsfvI5OSOA2JB1SuBZB26IVT7gqAWGAokmyUX3c86ZTcldkDrA
	nNjWo1Beiq0e0X8UrpBJGPlL5adgN87YuY0f6eo/OufB5x/5FBxF8Wtn5+ohCmD/xjbI1GyMce/
	D0CsyyMIoPDIrJxHQexU9gq5ISLzx8gK49SCUrJ68Ys6zVL5FI7d6n0M5vHfLATks1CLdknV
X-Received: by 2002:a05:6a21:e083:b0:2fa:52a0:e838 with SMTP id adf61e73a8af0-32da83e39ddmr4358399637.36.1759924818358;
        Wed, 08 Oct 2025 05:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKO7wqlSvx59P2vS6UzWzJ//dvnD3o/iZtvddrv03NuT9ONGsnUOVru90lpyPYje4cnIJpKA==
X-Received: by 2002:a05:6a21:e083:b0:2fa:52a0:e838 with SMTP id adf61e73a8af0-32da83e39ddmr4358306637.36.1759924817502;
        Wed, 08 Oct 2025 05:00:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01faf086sm18623699b3a.23.2025.10.08.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:00:16 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:30:10 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/12] remoteproc: qcom: pas: Enable Secure PAS
 support with IOMMU managed by Linux
Message-ID: <20251008120010.kygbso4vw2ouwlzu@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-11-de841623af3c@oss.qualcomm.com>
 <65e6d61a-7648-4125-8550-8a8c6d476b0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e6d61a-7648-4125-8550-8a8c6d476b0a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX7xB/TEolweDd
 0ksbRh0wrVWYz2IwMfnDzyryyKbqXCK5XyxlH1nihq02xODt8lHF2JI6zSAQK+bQ7iFZ+54myT+
 LeU2yA81OjhxqMDvGBOgoJFwRmdQ9WYaYBkRq5q5ROzQsIUKQKIaqzLsJ38FAb22uX3kNcEvMNT
 Jyf/uROMihw6za68tzCGaiepyfj1zDO7juJDKUouh3nvoN6AB69nTmphR92TYglWJgf2Rgr7AWb
 nMr9KXwDosxcI9bKECVTeQaj2Pl4qWuwOPAqcRPZ1KpkLpzJyAp2m0V2EmiGDUMeDq0K/jcpYZ0
 jdGnRfrkVvq+GaLOwg1rOg+8tgEsupf81KcR7YYCIesY5kuLxCirbBnHCOEYyqyCXA0rMbMlOvk
 abbgQ7IXs3XNbgRCTVtQBSXG+zvHBA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e65254 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=qxcRfBPHBTAMjdSr2WsA:9
 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: vslqDFLz1ggKiTwNUto1jGwgUktx6LfN
X-Proofpoint-ORIG-GUID: vslqDFLz1ggKiTwNUto1jGwgUktx6LfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On Wed, Oct 08, 2025 at 11:19:32AM +0200, Konrad Dybcio wrote:
> On 10/7/25 6:48 PM, Mukesh Ojha wrote:
> > Most Qualcomm platforms feature Gunyah hypervisor, which typically
> > handles IOMMU configuration. This includes mapping memory regions and
> > device memory resources for remote processors by intercepting
> > qcom_scm_pas_auth_and_reset() calls. These mappings are later removed
> > during teardown. Additionally, SHM bridge setup is required to enable
> > memory protection for both remoteproc metadata and its memory regions.
> > When the aforementioned hypervisor is absent, the operating system must
> > perform these configurations instead.
> > 
> > When Linux runs as the hypervisor (@ EL2) on a SoC, it will have its
> > own device tree overlay file that specifies the firmware stream ID now
> > managed by Linux for a particular remote processor. If the iommus
> > property is specified in the remoteproc device tree node, it indicates
> > that IOMMU configuration must be handled by Linux. In this case, the
> > has_iommu flag is set for the remote processor, which ensures that the
> > resource table, carveouts, and SHM bridge are properly configured before
> > memory is passed to TrustZone for authentication. Otherwise, the
> > has_iommu flag remains unset, which indicates default behavior.
> > 
> > Enables Secure PAS support for remote processors when IOMMU configuration
> > is managed by Linux.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +	if (of_property_present(pdev->dev.of_node, "iommus")) {
> > +		struct of_phandle_args args;
> > +
> > +		ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus",
> > +						 "#iommu-cells", 0, &args);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		rproc->has_iommu = true;
> > +		of_node_put(args.np);
> > +	} else {
> > +		rproc->has_iommu = false;
> > +	}
> 
> I think the above is a little heavy-handed..
> 
> rproc->has_iommu = of_property_present(...)
> 
> should suffice.. if the developer puts something that isn't a #xxx-cells
> -marked provider in xxx = <>, that's on them

Sure.

> 
> Konrad

-- 
-Mukesh Ojha

