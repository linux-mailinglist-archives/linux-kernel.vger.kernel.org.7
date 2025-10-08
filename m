Return-Path: <linux-kernel+bounces-845129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3FBC3A10
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1536319E2F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C82F6578;
	Wed,  8 Oct 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UOC+N/pU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E52F60B3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908695; cv=none; b=kZijK3DbtIzIr/cBEAmXA1+WESVD6wd5i/dQXV6qvasRlbfSg7Yfnse45VHnJV3RFNrJ5Ih0Xy5gIl47sCTaOOist9nk1gy7KoRAOz0h1eD6rLRhhLM1ZysQtza3k7QCHg/8jvfkOkxKNmTGLmB1tQnhQVVcoJkjRXNvFuqo0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908695; c=relaxed/simple;
	bh=ln6sKcZOKPZ+XGO7m2rvWcGsZmm59wEyyrCSMtyXxXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZH0bDdZPbykGtVP2jfZyxR53g5nRalL4SYojWJ1WLVOWdAFZkdSmkrpDmytgIDsAIx4870J6PVhAcVy6d1ijjtmpm5zG68+6AXCtfekgcZERW6WboxYOZ1k4c6Sgu87hZ+DJcBQGu+HHxSWCvM1xMUSDSO9aIvr+LEiOiWdIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UOC+N/pU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803TqN012228
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 07:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cv0p3chaZUKm1oNKGTLwDf2U
	C5ikXunO3QBpHUXSjv4=; b=UOC+N/pUwDHkEKXf/eRqgIaR+H6fwZjE5C6mMe6c
	GwjBpjeM+WXMB5JkBMYCUuSlDuKh/L0zb8CAuuh/V9Q+NXsnrq0Z/MAu/GxA/4/I
	nUBTeOHAafA988dwhBnYROp3feBMTtFnSbKUzzOijEXN3Vc3J8aNwDaycd5LO/+E
	RzJaS/Q++D4S+FneSqFXUdkIc9R6WrA/ZVwmZliCqGMZZDLOy4I9liWke6iHbeoy
	Cv9QLu7jpLYg0V+3i03BfMt5DoFUr9Rh0nJ62ZE1QWssSvpeEzBdpD337S0X9Jf5
	vQlAc2BnRYxdTeb3n0EMnsHdwLeFGbGHSfqWmOzjtWMS9A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9nwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:31:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810289cd5eso11718213b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908690; x=1760513490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv0p3chaZUKm1oNKGTLwDf2UC5ikXunO3QBpHUXSjv4=;
        b=bmbi6wgKVFLmmLGX9a9ztNmdgDu6HWsrP+SKvkQ277m8KMB7O74dF6a8vYv80PhvCn
         Lbb+MDEKBvgRoxzsoGhdNE52PTb5RgY9w+kKqFHn1gQ9eK6OvsHLlxp2ez/gy5dTZnjC
         IZ14MInJL9opuhbbY9HmHXcsSKVXEQZ+/Al7So1kZUZgTGWL6DVQ2LQmxk67rQXgVWP/
         nnjLcjY/0RdijWIyG46n5R2KVnGTDzu7oO6ozq8TUlpXlYSRAsHZihFwWrBCuAB3oBUL
         fHsVp5SqPFr95qXb1VBaE/Gyy3dsIUkoobBZ2qN3X3BYZSMJCTkMfSTmYSiAWu5YbYVe
         dsYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0vnFp3G75NQhty9JSFtezilnZc4+2RwS33gDymt1W30Z+9BOwh6dS7neevj3jaUA34Hxle/Q6GOx8DcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyalKAJQpwIjY0Sy8CKlCcC8IQy4D0rQAUqYAGCMzW5XLETjIlq
	CXmazTVV0rpWZF1spdxpSbOPIjwqOFKjeASJQTN39Ld1oMdOuQEgok8B8ZJ/x+PItoU5888eMcq
	Vn2375d99xry4mFl74NcnrwcKpAeevF+AZc0veQ1mxlV+h6DNn/jCCmSPeiCMMkN0ozw=
X-Gm-Gg: ASbGncsb7A/BvFDGshj4d12odb6EKdWDGhZLWbnHzOzB+e8NvDk9hB24hv1KWvuoat/
	dHaIFPk/kxk7qzvXdKkF2u72tdcaGnydCqPvYICVZKVpK3Ctt0KvaYoPuBguJ2Pea/JjlQTUfoz
	saARK7TV5qhgcSZNxUrDtGfP4ICJ93aaF0GxzbIEJwhIfUxoDUEIq949L3ByNYo+QqITmYPaoLO
	7AxbuppxiM6ppksOa0Fdci5CUUALvvPvdT9a48ZbOY+cW+fk4AshMsQzHBPaJDARP9vH0vSMXfM
	gKD7+Z4M5GkC/0R7+lu1d7+zjHpzYXOMtFXjrvMrCh8WrAvs9fxb4XINQ5laELTToRmSSlEVrIV
	KpmrNPqyitGYs5x3UZ0GKsX9CALA7fe8=
X-Received: by 2002:a05:6a00:8d5:b0:793:1b79:ee61 with SMTP id d2e1a72fcca58-79387434292mr2799354b3a.22.1759908689536;
        Wed, 08 Oct 2025 00:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0PtpfjSD+k9WPCixY0Bm3Le9er/Wn83Bo+pYbYYWeIL3zSfYVwydxkKlBtco/P3dMcZCISg==
X-Received: by 2002:a05:6a00:8d5:b0:793:1b79:ee61 with SMTP id d2e1a72fcca58-79387434292mr2799323b3a.22.1759908689052;
        Wed, 08 Oct 2025 00:31:29 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daccsm17552074b3a.16.2025.10.08.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:28 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:01:23 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for
 Glymur
Message-ID: <20251008073123.GA20592@hu-kamalw-hyd.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com>
 <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
 <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
 <mzoctelzfp6h2ezzkc3j7gnghsaf67flxqlvfhtlpdfxtddsvi@zqihmnygvdjk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mzoctelzfp6h2ezzkc3j7gnghsaf67flxqlvfhtlpdfxtddsvi@zqihmnygvdjk>
X-Proofpoint-ORIG-GUID: 2f-LQwaVGxUSkxk6v44-hHA_yrYJSe6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX8zBTzBvWY5Er
 0Ex8Sj6eQZOE/WIYJIWgCVQxeXUY1hr5yX0fe1gVAKLzYACLeE7TNblAzgBmFEI1n/ex5lwFLai
 UxMRklvfkKodSFwpXLZ/hVq+TAOX2zl9zeMDWJ+NfY1XbmpsEKvtBjKC8VcEd4QON9bcgdKoxXM
 g2JnaZ5JE9CpeLIJQnJh4X7vlskq7O2LS93+mTymy+Ec+/05DoWW7+hnRZaMVl474amSGW0MvZu
 iiCbq++IpTGm8ik62zuUbNSMmPMHJaG0UAersw14olMfhaFsx1y82EmzIQ2dcgaPUhS0IWKs9Yu
 68ob7GSKP8X2mdwLbLwFLiwx6qC2pnpnhmTLF4NpcCSUaV8Ob3b6EDRxwhOaD/3ipyPVFX7jhdr
 NWh8pleOEz+3oh52eTR1Xateg3AiIQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e61352 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CcCa3DaCAM46YlkYK6gA:9
 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 2f-LQwaVGxUSkxk6v44-hHA_yrYJSe6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

Hi Krzysztof, Dmitry, Konrad,

On Thu, Sep 25, 2025 at 09:57:02PM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 10:34:52PM +0900, Krzysztof Kozlowski wrote:
> > On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
> > > > On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> > > > <pankaj.patil@oss.qualcomm.com> wrote:
> > > > >
> > > > > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > > > >
> > > > > Add multiple instance of PMH0110 DT node, one for each assigned
> > > > > SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
> > > > > CRD.
> > > > >
> > > > > Take care to avoid compilation issue with the existing nodes by
> > > > > gaurding each PMH0110 nodes with `#ifdef` for its corresponding
> > > > > SID macro. So that only the nodes which have the their SID macro
> > > > > defined are the only ones picked for compilation.
> > > > >
> > > > > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > > > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > > index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > > > @@ -7,6 +7,8 @@
> > > > >  #include <dt-bindings/spmi/spmi.h>
> > > > >
> > > > >  &spmi_bus0 {
> > > > > +
> > > > > +#ifdef PMH0110_D_E0_SID
> > > >
> > > > NAK
> > > >
> > > > I already explained on IRC in great details why.
> > >
> > > A short summary or a link to a channel / date would be nice in order to
> > > include other people into the discussion.
> > >
> > 
> > Of course but:
> > 1. You were there so maybe you remember the arguments, and:
> > 2. I'm offline, using phone, not having laptop, replying during my
> > personal time off just before merge window so any emergency time
> > should be spent on important matters instead these two huge patch
> > bombs adding such usage I already said: NO, don't do this.
> 
> 
> Well, If I'm asking, it means I don't rememebr the discussion. And I
> defeinitely didn't know that you are spending your personal vacation
> time in ML. And if the discussion was with some other people, then
> somebody else can drop the response to the question.

Just wanted to give some background on this patch.
Even though PMH0104 and PMH0110 are common (b/w Kaanapali and Glymur),
they don't share the SIDs. So we tried to use status="disabled" to handle
this but we observed that because of the node name being common in the
two included files, it ends up overwriting the previous node with the
same name.

eg-
#include "pmh0104.dtsi"  // assume contains pmic@4 { ...};
#include "pmh0110.dtsi"  // assume contains pmic@4 { status=disabled;};

Here intention was to use the pmh0104 on sid-4, but it gets overwritten
with the pmh0110 on sid-4 ( with status disabled). This is why we ended
up using the `#ifdef`, ensuring that we can control the exact pmic that
gets picked by using the PMXXX_SID macro.

side note, i did `grep` in the `/arch/arm64/boot/dts/` and i see a lot
of instances of `#if...` present in that.  Assuming the concern here is
about the use of `#ifdef`.

Can you suggest some alternative approach?
or comment on below approaches:-

1. Can I use `pmic@pm0104_d_e0` ?
This may work but looks like a departure from the current format
i.e `pmic@<sid>` used in the arch/arm64/boot/dts/qcom.

2. Create PMIC-ID based pmic dts? `pmh0104_d_e0.dtsi` and likewise add all
pmics? But this could mean creating too many pmic files and end up
bloating the dts/qcom/ directory.

3. Add the nodes directly inside glymur-pmics.dtsi ( not using #include)?
It may make the file too long and IMO it may take slightly more time, to
look at the file and tell what PMICs are present and at what SID.

Please share if you prefer any of the above suggestions? or a completely
different approach to get around this. ( or if the current NAK'ed patch
can somehow be improved still? or share link for old discussion so i can
study it)

Would value any advice that you can share. Thanks in advance!

> 
> -- 
> With best wishes
> Dmitry

Regards,
Kamal

