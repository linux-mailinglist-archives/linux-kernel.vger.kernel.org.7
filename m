Return-Path: <linux-kernel+bounces-833041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD8BA1129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431096C1068
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFE3191C8;
	Thu, 25 Sep 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKD3gwLx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300A218ACC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826202; cv=none; b=QWQ1R5cqp2YwSzZi2S+FxIoJZSq5iBydpFKo3PKveJVa/SND9UqGIcRHJxa54nX0f/bz7kT+imuBFgbnJjfwKS46bY8zAskQqabIKwvKu6f4hZVyOtgKBMBzPQYWVkI5gfNlMxYg1lR84Wwa5DYhnia7anoafuV4jjBwazYWxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826202; c=relaxed/simple;
	bh=mqolVhntoFxEPudKr49V+H+Z6M2mfKe/9ZpqBvaxDpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X68ibT1FGN0kjCIPNNUXXpTWGPVKMfVS/zdvGKBTaEab6TG4UHRwcozayi2CKuDdyYXXuMirTAEXYXXRvdbHtmdVP0wlhcnvIRRXjEbL7bXJps1NCD1UMfL+OLWeadETZgbxEC7hJ7sFxOrFs9jp8ZQK10HZI67wb7PgdIP5D1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKD3gwLx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQXaK005410
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qDehYVnb51D9IEzbSiYb6YP5
	OSGmygiK0FzKBi/Waqk=; b=oKD3gwLxxU299xI/0JM/okrbMCE46MaFNrIUYG2i
	AVgegvRmcVpKdTSFL0WuCyeK1SX+0U6BAULB+bUFs2eYFr/ooB2u8K9OysqGz8Wh
	hYMbvqkoeehQow+GP+InSQTNPh9dmjKUAX2tUJNWdrc2a75PvPI6X5XPih9rlYYS
	M5iWVw1oRMwFrghdbxyQ5qnIeCmSmRpI3cRDlSDt+WEDfau3LaAd/o19z5+gn84i
	E8Lj6IXuoQSsZ6QzR/bG5UwdKYP5i3mcWP4TEavPjS8Ibh/ZsXw3/83OjeCAZVKS
	gzHdZJdnj8xY5nVKbShns3/UaOwzjgz3kxijZ+eYSBz1AA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u01wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:49:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6a82099cfso32913971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826198; x=1759430998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDehYVnb51D9IEzbSiYb6YP5OSGmygiK0FzKBi/Waqk=;
        b=QUiiuTZSigiFzJcaeXV3oBfJqF2ugAhvRA6ROeejb/BjmZlgexoUZ0Ir3ZERsqgPrQ
         C3vJYALany8GUA+hNAdsmdIQlOqan37m0uoosm6gIlNeUsaW4c8CJaJK6Ksi1vnrFh2+
         pqD250aUlmcLAFWzQ0puAdRHM9i6hAkOY+dFPgzf3d2qVCt0F6PU2ie3w6y+W7xKsMPy
         XcBQnCE4Z3t5WOycVWJdmlhv6PIhqj5GIg0m+Nx6u2fZkbfVODFkxMZRu36MFkxhHrx4
         OxgCHf/Cgv1S2So/E2YcxTO4exiCJGZrbspWJTErimVT7oKt9RzyOEM/KoF+nQ4ZtqLL
         1hWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMJOOGR5YBBi0ssbgXFwsZUCWeqty1kV6OkXxwr5oHhW+UH/z/ZnB/IbA61xhgHekQcbY35eu9AwZ5rtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDC+CRTaiH1Z9Dr/BlW8CTLO8WM6m1rbqMktU+xkTc7ZZt6fq
	m2mAnR6ZQzxCb7D9tQnA4DMacjFUsUoYQ5Xp4MoGT2ibjykYtvv0xhGBIYCCVaA7V3CfV7XRacU
	ahu3ujOoJMrBv6iRB4oF5KSRBa2uqWznqzlSv45rJcAUHMtLfBPLCk6htBoxvdbmo3Kw=
X-Gm-Gg: ASbGncuhI9IefMoELiLD9PgKi/UPvk23UwdoK0aQdACrr5oC/yRMQkECQtAhXVAz/SX
	QhyE6PZkWa5wShqqaztEoAwQdcJjZ2TiFlL97+oWQd54d3lLmy5kwvx1runYF8aOiwhtaKeSGp/
	n7l8dF0nHk3BBA1qAskod1wKq2+lQF3YsxXt9zkTtdsiALUhyWlvHjl7e/HSoOCG4ukIwjAgiN/
	bUuy10qS0jO8XmpFpHR8cfiqZhANeJbPBDVdx8OT1We7hILSTenpWKBL2HboPbS5rnGOiya1qK8
	L9TbOdVh44OmJR0Era4GMyKYbHcTQoPP8I2btbbrDMe8boSw8pD9tRqIw4GlolGiNjjfv7jIfZL
	oBDa7fO2TTp1j1OZ+Frkp3u4FzbcKO5FybObBTH3OU8Hg4WIdyTbk
X-Received: by 2002:ac8:7d8e:0:b0:4ca:bde6:cc8c with SMTP id d75a77b69052e-4da49348df8mr58188721cf.30.1758826197849;
        Thu, 25 Sep 2025 11:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1j2v2beSwvHVR13GPB3jhEnCzCgYW50DxdectNMsPW6vbCCP41hZSTalxdH5S/krlOL7I/w==
X-Received: by 2002:ac8:7d8e:0:b0:4ca:bde6:cc8c with SMTP id d75a77b69052e-4da49348df8mr58188221cf.30.1758826197216;
        Thu, 25 Sep 2025 11:49:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665640bsm1022711e87.83.2025.09.25.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:49:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 21:49:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Subject: Re: [PATCH 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
Message-ID: <ig4z72wwufcyiktiqebovfq3dymtlcmy5v5iihvknbggrjyqet@tylhjfvv6syx>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPc8NYrwSLbaFZ_tRVpgkYPUYhaMde77p1VBhqm9PLsGjA@mail.gmail.com>
 <bugtpjwk77lcpa4jjox62ulmy56nf6yykzpr2ryifqqpeig6gp@45lzpngcpo2z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bugtpjwk77lcpa4jjox62ulmy56nf6yykzpr2ryifqqpeig6gp@45lzpngcpo2z>
X-Proofpoint-GUID: _o0qSZuvBeZEbtX7MMDJYhoW_HsbDukL
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d58ed6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=WwjLFScS3zh8zo_N1MkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXxIYKZ9fAZmyB
 auBMU7WpQZmGLBOg8Hm/5bHiMs1hcL/idryku9N8kytCSsi93Fnb/HibNovjsanitQ/kCBjHoVT
 kRHAgENRgqP3U3rAbhwYngznAonRvd54Vu6khcsgno7HmaCupWRsIaj3tScGagK/+wd+uJJxXPm
 4wS+AQIGqFzq3WQTDZCUOzr9gHP6xbS4lrtOmtYhgv80rpG1g3geXNp+yk/gc0SZTFwb2zw+b53
 gwxi6B8Oj8kAzX0GP7tlvCcXYUaHYljG1pssKQmDiPANbNkm2i2DEEUhD5P7dMYd2PgELBAFh7G
 gD4qBwr2PVx4VQGfq01DSX5QvURPtF2RzPwObt7VP6Nsb+HWf5tPXCbvnWMRlFMNhgcWXzmswHf
 PohbyPku0v4HNtoTdA5EIZETffJXwg==
X-Proofpoint-ORIG-GUID: _o0qSZuvBeZEbtX7MMDJYhoW_HsbDukL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 12:06:40PM -0500, Bjorn Andersson wrote:
> On Thu, Sep 25, 2025 at 05:23:07PM +0900, Krzysztof Kozlowski wrote:
> > On Thu, 25 Sept 2025 at 15:33, Pankaj Patil
> > <pankaj.patil@oss.qualcomm.com> wrote:
> > >
> > > From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> > >
> > > Enable pdp0 mailbox node on Glymur SoCs.
> > >
> > > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
> > > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > @@ -4065,6 +4065,14 @@ watchdog@17600000 {
> > >                         interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
> > >                 };
> > >
> > > +               pdp0_mbox: mailbox@17610000 {
> > > +                       compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
> > > +                       reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;
> > > +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       #mbox-cells = <1>;
> > > +                       qcom,rx-chans = <0x7>;
> > > +               };
> > 
> > Again one node per patch. this is really pointless, please read
> > submitting patches before posting.
> > 
> 
> In this series I certainly agree with you.
> 
> This is most definitely part of the next patch, which is core support
> that should have been part of the introduction of the CPU nodes in the
> initial patch.

I'd say, all CPU-related patches should be squashed. There is no reqason
to have CPU, CPU idles and CPUfreq in 3 different patches.

> 
> Regards,
> Bjorn
> 
> > New Soc is one logical change. One.

-- 
With best wishes
Dmitry

