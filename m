Return-Path: <linux-kernel+bounces-843663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D0BBFF25
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B3C3C5046
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD21F8AC5;
	Tue,  7 Oct 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjyGWNAp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE01F4C84
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800257; cv=none; b=r0vEaoiM1/BV85R/YxwMhAi7RpDimsf50fcxv9jZcn/0L4g4jMA/msJt0BAM7HvFEeUiVGmGcd2xP2+81Wx8x+xrdVYYW6CQyjeEHPlEZwmu24MSrh4FVX1EiFE1vmRDV28253EyjeZoF4mHrbyfbCzBOiRx+bi/JGteaFHlUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800257; c=relaxed/simple;
	bh=K8Ito6N/92UmC74Spy9HYuGQHrNOoq6p4xRrDPVTJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juWmJdcEqKYWdgl3vEl8wL6h3voP1gTUEP3mYs9cVmSIingH7xxDUIkIJB0SEa27XMBqbJOPFOHXEa3PVyOvehG0h4u/QXWJDWxT4tdHbI6DcQkNAwqUD6IwoAjL5FFT9IVHMKRqC3H92sYXNKUcp7vT3UvduwKn5aV/p2nS6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjyGWNAp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Fsq3i019973
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 01:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=66P1iIdEuvGo5diDEZmJaYVv
	t9N9VnWj2nfgQmKd5qw=; b=QjyGWNApzIqB97CD1aJHkp4L1wPftj+T2iyf2kX8
	Y5N67B/2481e1p1wyz6XjJtaXpoK6MiO6G1LV7E+dVnre5e1QLfQ6dDTws/OSxaR
	VP5NiXYEkJwIVKrcMQqUt55/0Dxyic6N51zUUuwBtDVfPA7t1y5LiBeCNf4HLTy4
	OO6+i4epvCyjn1wGNC84PshJR5gT0eWb89Tof/4pQjV2RuRYYZJZgBDBdizC7udw
	jiYqU4UpLlpO5I/K+bMiREmq6ElmOiFQyDdjo8yzj8KLump2pBt/Q+wGY9s6sAQW
	vJj75CjdTuB/JX2vzCbKmB1+nBM1AV3uPgiofSZ34zyNhg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn5x92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:24:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-876ee102b44so138292396d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800252; x=1760405052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66P1iIdEuvGo5diDEZmJaYVvt9N9VnWj2nfgQmKd5qw=;
        b=aQA2iPz1GO8Ipe9n1s3ps482WpJQTTUjYenbZhZXSpJvmQCuhXMp8yNoK99UO4JQJc
         EhzOIgr3F+8zNzg3V8dAkcbzrEBD0MeRULY1X86P2DopgDmCqICfdhhzjoR165eCLWaS
         zlDYVGH3+6r7RsWKXERT/rTR1s1NP/EvyAcfLV1D3T1ibE7BtRprZ9uaOZHqUX7wy1q9
         aCnUGMkh4xk5U39dFbfAjD7ZpvPOManLRIJTN+xRT93o7Emz9qorRDukLqW8QsPMJw/8
         ILFmAeRg1JU0tAca53CvHReKn8uvNv9rcEYcHE+PMxzQawaOaC7pBuonli2FcLFdQlKZ
         izXg==
X-Forwarded-Encrypted: i=1; AJvYcCXMYSpD0c72alZ3kEf+BkeS9DlJ88lHjaJvAb6iqbFjEobC7lwmQjInfyHOvngAzQ7pqZ4i9oRORb/m1BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsJZIrC/8BbIvyKJvRbwanRsXMoNX4GlCC4/BpW/8z9mudjHb
	AG+0lg82DNWsTyhyxIaBGgVg7C+N+f6XGsFruSILqFvSJZAp7Qruko+5QFoiOI5Q9RxWi/lHXMb
	a79X/vXKeC2XgFZnmfn6wkb2g5pTm7k8xCfyuD8RCWnRx8eNQVDdWTvlljRZrKkGzuCw=
X-Gm-Gg: ASbGnctLQqSnalMSqsbse3ZYZuGCAc35Uxjbu7YJR4IPsRetxvNneQgswlcu9v6sFP0
	TLZdyaJLOCwt3v9uuphOp6AE7872WUxloYBtMwGK07el+pXqHpR8oRUAfEFXWCd/WqPoHNgfsHM
	uLbXrc2Om5o6SCNPjrVWD+fOPUQ0K+9aZaNr1LvqqzIQDFANy9+q0WVTl24a32RL8iOmcUjRU3r
	hS14a+Bkc1Q+zNr8CI7CLok9GvU5aPD0dC/H9nbtEGt3rOLaryH9+mL2gQGU3M62DbGFZ3FlfAS
	fjjlrgbqmGcPproyl0fmlIZ95Yh2DViJD6eDOlMVnxB+ky3juACAHoxm/wlsaSqa+ZoTebip6TO
	u07hfZbRpBW763ovEa3h1X/L1wTgRi8leEe27m555UnGzQaNcEBTqePJXGg==
X-Received: by 2002:a05:622a:50d:b0:4b4:95ec:c830 with SMTP id d75a77b69052e-4e6de93596cmr23862171cf.42.1759800252475;
        Mon, 06 Oct 2025 18:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEikV73yqB+TdwAmKQ1pcop3SJZ414TP6d8b9XiKWBJUcVMyY265dINYELgJj65zxVKuqbsgw==
X-Received: by 2002:a05:622a:50d:b0:4b4:95ec:c830 with SMTP id d75a77b69052e-4e6de93596cmr23861911cf.42.1759800252004;
        Mon, 06 Oct 2025 18:24:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113491asm5543464e87.36.2025.10.06.18.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:24:11 -0700 (PDT)
Date: Tue, 7 Oct 2025 04:24:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 04/20] arm64: dts: qcom: kaanapali: Add support for PCIe0
 on Kaanapali
Message-ID: <noonr5lrw3ig373pi4c7efakil34vsaej6cshs52us35n2bbmd@7xmq35w6wetc>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-4-3fdbc4b9e1b1@oss.qualcomm.com>
 <68fbfa0a-605c-4b6f-8ef6-33ebeea8909a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68fbfa0a-605c-4b6f-8ef6-33ebeea8909a@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX2l4KA8FzOHNi
 MoX4o6sKU2nt3Pq4SZ+YxKVS7pGLORSvI9PsmvQL1loicL8fYUqhdmcL49I1mLZiMrWvuNro5ZY
 t42x6oeQmKX+2rryI6EmF/st/xBSpFPjhHguaMDG0ebr76btk5oYDp+VDMIeoGHcdSshejQy9iz
 nR5eFmnsrSAm3SFnhEQNLGKxKOfjpifobTAAjSLTQpQbq+eR5unwaHsKooTR1CKJeZ+06CnUA19
 BOVYpSTMBiDbs7jQ9hzm0lVI9AUq/RdGZRJTssT5tmzju88d86NG0HtaJIrmLRoGgsVG5Sn/Phn
 8+rlux1C9/7yPH/dwE6MZcJs4aYp4DSHO7DMNEk2mFIPoGhCxxcitF819XEkQrkrAyuMd3wzOZA
 F5EnKLKlOT7U99qC62+Au4M47xcqGQ==
X-Proofpoint-GUID: G6Sr42Hb4f0l6v-z5BYh27fnjkwgyvbL
X-Proofpoint-ORIG-GUID: G6Sr42Hb4f0l6v-z5BYh27fnjkwgyvbL
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e46bbd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=pzI5C_7f7Ztj6dnNTwcA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On Mon, Oct 06, 2025 at 11:23:23PM +0900, Krzysztof Kozlowski wrote:
> On 25/09/2025 09:17, Jingyi Wang wrote:
> > From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > 
> > Describe PCIe0 controller and PHY. Also add required system resources like
> > regulators, clocks, interrupts and registers configuration for PCIe0.
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 182 +++++++++++++++++++++++++++++++-
> >  1 file changed, 181 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > index b385b4642883..07dc112065d1 100644
> > --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> > @@ -452,7 +452,7 @@ gcc: clock-controller@100000 {
> >  			clocks = <&bi_tcxo_div2>,
> >  				 <0>,
> >  				 <&sleep_clk>,
> > -				 <0>,
> 
> 
> Why are you removing lines which you just added? What sort of buggy
> patch was before?

Weirdly enough, it's correct: this patch adds clock provider, which gets
used by the GCC. You might argue about the split, but there is no bug
here.

> 
> > +				 <&pcie0_phy>,
> >  				 <0>,
> >  				 <0>,
> >  				 <0>,
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

