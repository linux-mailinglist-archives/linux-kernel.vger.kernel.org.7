Return-Path: <linux-kernel+bounces-832492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D3B9F798
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45AD4E5435
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264E21E091;
	Thu, 25 Sep 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRLaDrjL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF2220F37
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806073; cv=none; b=Awx2TN1r7lvpV4WgA0qb0MVGyY7QiAoW29IdIiQRoexiLxiCvyuj20ztIVV9/nxvNFbckorcLcmHH28Sy7dGPlLH8C/Yqx0CKXqRpFp2aRR4BRxzxpdtK+WdiDDlFC6GdY+ZZO3AD3YB3yKU0YB+Ngv1Fo62qE4PkJmAsEAl2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806073; c=relaxed/simple;
	bh=qd0Cjf6DpZnMSxDxHyzRu9KmReNI+tBRlR7JETes0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXheUCEdvdzgS0geDQq6ZXh0mpwGQUwTq8fSKOo3HOP3indAqxpPzliXyI8T76A9QTfbX5u7Aexc4vDh6MOIFu+aXgMCkifc1hRZLeTSBnyrdiNmrER1vAFxpO0GAdOKIDUgKkvh5La9s5Ljkxl/ldsM7nVw59w2kfmJNoPQMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRLaDrjL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9rweJ019952
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HFxENkPzd7eD3hqpOwyV5+Tx
	OdegPT/L5L5px2aO4O8=; b=hRLaDrjL7CdcVCoJziZzCZOlYGd/Kibh9Pwkky8W
	RkkU4ABTOxqg3FhHQoMe60PZJan68qp6vD2sZJrCRwK6R1xxSe23HxAjHSCKdNqc
	zTEdIasWgXz1StDSLrNy53gtr6LjZTA9DP4YffVQ+lFyJeIpExLTIsjZm2KeHkET
	DjdkyPFFmAgdP8R3R2C0WfBf4fBrdGMTJKnWWtxh2d8diTGcKmx5K1+b3WkbfcwD
	kPs1WsEggqkCv6L/yZ1ZpiDaTKIsm8zMZPTmxI0M/ktLgKUJ8LupyKvDyqUqgkUD
	Mxb0ZCTXCcX+RN922bTmrHye2Z81wK8LQ5B0/3J8BmqADA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe1dnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:14:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b793b04fe0so21557451cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806069; x=1759410869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFxENkPzd7eD3hqpOwyV5+TxOdegPT/L5L5px2aO4O8=;
        b=LG+i7hV+wl4BxNBx+RRct5Hb7tvRgRZXMj7z6vYhLrZSy9Wk41yEuowYXl0hjBhYYr
         g+xwbDXrPuX5RztpTXXELoCYcGIsAdh2CfwnAgKH1UIUmfI7lHXJmqRTpdtkM+R2t5mv
         zS7DtZbUlKhSqtmqelitBwNrGJI4CMKog7jYSzxq+LTHN634XRlsicurJRrftdfqXCeQ
         Lqin+GweIIbY9ghYhCKJ9BWLsssFEUCRBpIU8LIcBptQgEB19dF9LQJ/WwPimT7L38tm
         d9s1sHYX1xz7X6D6gCwaMrxWsDWnO7UnieQNjEggrI67JWvrjm4tzR8/LeuHwjEl9StV
         W+hg==
X-Forwarded-Encrypted: i=1; AJvYcCXEmR4LrMnvfpXdHMhz/bhV0kto+1q8nxSNIiH/lb3zUE1HV+fv52OtRw7OP15rO8OUOa5KHnNmzARnf8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNguiX1b7N/+RSQiOrXRgdvwg0QLJ+X7rqu9msM9pse6IJWdQz
	lVj/1bJTspMeR9EEGwf8y86fmwbnoJZOlsZEfVeN8r4cApQhTqPM5V+1OVshhWcjAoINmQjib4o
	ZlwcpzAfzg3/Uy6UETs9mvtq+0AM7srwwCI+meG8+Y+Q8MAQkuf02JLiU8SmGIfFWhcgLQIpsTC
	Q=
X-Gm-Gg: ASbGnctFIfKkra0V/JB0mFNxlz4rHS7QRQ70F9KDzUMOQpOUF8EDZr1xoa5FnPpVfX9
	EMkSOuZWiVhZs2Nr8+iwKC0dTKISKE/B8Ra9Mzmrj0/G+4Jx6zgTAz4qDc6KsIZ+IXjeqHrTYp5
	WcBt1/s7hCtXNw1XsbJtAjRfMdZvESmnVaH6NKrtXCugN6uH3MkrlTW8/DeMDsFou8PeZxC6lYl
	aVNkFNjm6m/TKai36FWMv+DnaWF4geJNhbZAtOakvnr5Y0Qkj9toTa6qaAGOFan+VZg2X7hHo9O
	HYLa1pALtv/NJflGCcFQ+MDJrONH390AR3l/BI9uQgzzMcoXhJXnNEVh1Ab678c/DL6emRWye5d
	dLOaBiVVniJiFZ+tTsExN7jlUY1W8ql/YFycZSCevvEE4QVWef6vE
X-Received: by 2002:a05:622a:5a1a:b0:4b7:a71f:5819 with SMTP id d75a77b69052e-4da4b42d158mr48039081cf.38.1758806069086;
        Thu, 25 Sep 2025 06:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH40hIwk3dMT4mQWI4cn8s5ckhmJOi18aT/m48IkBIFn4CkHZaMCvCWcYGmSE74pe3NyzfafA==
X-Received: by 2002:a05:622a:5a1a:b0:4b7:a71f:5819 with SMTP id d75a77b69052e-4da4b42d158mr48037111cf.38.1758806067540;
        Thu, 25 Sep 2025 06:14:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313cde476sm768603e87.48.2025.09.25.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:14:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:14:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
Message-ID: <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
X-Proofpoint-ORIG-GUID: ssJdFvxRdYsBz-sUeolsc7b2Qa3DCo8O
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d54037 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CbpXSumtfHVU6JjQo5gA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ssJdFvxRdYsBz-sUeolsc7b2Qa3DCo8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXzoOBeKlQswE9
 FYJOBfkTRDHe99VaHERGqJboB2Ms83thDderJDFIavAUU+jkR4//BdhDExrcDWKX4T/orsGA//3
 1vBKkRyKAcidvNxJbJT1/9vykyfPO4v0B+WpGWB6adySGD2hcqj3X25q6hJJtcIH+AY7RtV4Utv
 r8We3NS1q109btagXpQouiu2LIleYxTpcdxTG33flMwH1LyH8MrsFq+c377+GQUL/WCv3PDVhIN
 CkvL4B51p3NEC2zaRWQZtmEU7mOtZ3OFuDYKgOa5qbpWhFqB9oyuaD8hiLCbkgr+/PIVJ8jz4LB
 BCaV4dTjw9ud7GvvP68H4OcMwvRf3uJKSIjqasM1v5hVIsnafUmIqquHaLvsjsW6+VXWxezVW3Y
 qSUrRENp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> <pankaj.patil@oss.qualcomm.com> wrote:
> >
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >
> > Add multiple instance of PMH0110 DT node, one for each assigned
> > SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
> > CRD.
> >
> > Take care to avoid compilation issue with the existing nodes by
> > gaurding each PMH0110 nodes with `#ifdef` for its corresponding
> > SID macro. So that only the nodes which have the their SID macro
> > defined are the only ones picked for compilation.
> >
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
> > --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > @@ -7,6 +7,8 @@
> >  #include <dt-bindings/spmi/spmi.h>
> >
> >  &spmi_bus0 {
> > +
> > +#ifdef PMH0110_D_E0_SID
> 
> NAK
> 
> I already explained on IRC in great details why.

A short summary or a link to a channel / date would be nice in order to
include other people into the discussion.

> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

