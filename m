Return-Path: <linux-kernel+bounces-859673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C0BEE3FF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BD83BB1EB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A02E6CAB;
	Sun, 19 Oct 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZG6XlRve"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4232877D7
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874778; cv=none; b=JU9BWQT/XffhmlRhj8jPmhlc9FHMCxH6D57YohMvCxA0N59wqlD6FX1lcfdSP9w//NRGHUVR+LfHnucCi+OyGTrDKqts1C4tFmZOi4tdmLJPrRd/WdcU80X3Tj7tyK+svxeGx6w2WeAzncuhL4iQK8XlAOWHZB7NJyUJSciFKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874778; c=relaxed/simple;
	bh=LEr6l9kJohkM4u+rj+kOjViijIj6R9PFOf99UTe4xxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKJwZj0NKxJBDwyyVgPnK3Y7d5oYOdlPgqIeoj8g9JlI8T4AMy7yHAypNaLi+h2vD4vxT5SSp5sXoa6q9+5Qv32h3B5vXwZ+nujijGntzH+2gCUu0Xpc3zpACfGSYMa04bwTPbsViKX1nWctafq9pHdBEeDVQ0FZc2X/W8MF5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZG6XlRve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAVNV2015854
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TN7+hMpDo5h/8U2Db7n/Ndrm
	G2ZsOSEUMs79Cs5uzu0=; b=ZG6XlRve7QWzDRwvZRk40ibakpaPla2Tq9keXomE
	hVETZk2RE2Nl7pXWDKz1+4ZwjmenUDh0h6EtOA6JfYP/lR84itPZwh9NeFycO+Eh
	Fp4vwiK+PZjNlguvBxrr4CFHXHBvDfg45enp2RG/qI2sUIfHfX9T9e0KuXao3D1U
	lPu9SrnsZXkjoTcZtX5OB/GbF0Axa6cAiOdJddtS9EGFvf20k7l3bjhVdPJFknCV
	mERaatKCy8x35whZu4M1BGP7wD8m0ZSZETNFIeMGvtZRey/5D7TnTLgiYOjeIyZI
	ZMJ1+TkZNLVf6FXKNZXcmYGrLCwdNaVBUV/80Mm0JOczIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27htcr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:52:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-892637a3736so514257885a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760874775; x=1761479575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN7+hMpDo5h/8U2Db7n/NdrmG2ZsOSEUMs79Cs5uzu0=;
        b=bY9zzi9DZYkUOX3YNhEAn76xqtFskpy9fKz2jvCC1eUSAXzMS496tzyBpK2yvTejh4
         w/pvan0yV/heje9axfDHShaMrWHSOvHm13ZfkfuzaoxB6VELNcH9P+lsRnKH+yK4LsuX
         5htV4AJxMSW//lho+82NMonyMjUV16jMFHKFbjf/tkVZ/VOzWy2k0m2k2watap2du1uY
         5ABtPCLxrhzGJcYfw0W/+KfL+CBoAWT2+Ympw6lAN+COm7VH5MZfC970bALwWw5d4nuL
         ZCfQV/l2SmpAZLv/ZHSZJ+r2fIqeXXCcNZtBFRAmwdeiAyarjkxng6Va3t9KwN2wINRh
         qziQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTWc9Vx0JCaDadlUo8pPKXC9bjsIPHpk8tHAMYZ9WgaC6Zb5DD/g/X0RsSAdeul7cIR2sYSrp2BcThyJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3y5/HM2aoX6Pc5OygUpcxulY4d527D49c2GGZm+NEojKhriQ
	J1mnDV8odPEVEWtxx6o5LIA1L3xQMPAG5QCud50VAYa28PCutacACvWWlUsIR++46bgqF8Hhma4
	pfuOlE7gz+KysvElU1iIiTKJr8Dkzpcfrm+Cwzvwe+EMipwx0IWS/+iHHyLjnI0JjMno=
X-Gm-Gg: ASbGncuZrFVjl0eAKkD/YxGUD2xlvNhjqTmFxRaIGa9vvGpkFNzB/1zVmET3HDoB3ag
	jZgiiBvwWejET1PE+G83/hfqHq7JX4Eafv+F767woOAj5He7cHvzHO7sET/WK1uUmzc6TaswO4x
	z/CaYngYNCX+NQAZCd0F3nb6a4y08Q0uhcFav+pndk98rt/wZvuIDNfhMTFXUNzjvuYXpRiaCWx
	p9PiTuI2TfgST5YyfwLthr4z5Y3YTJ8+zjtWeyjtEVgloX7jsPeaZN4I4qRvh2ZY10op/M4QC38
	h0vWj/nHKanahw1LxdDBVk+PDr6FSgN9El+yDZXO6CGBQw0kXXTeKPOc60ALDy+BZY0qjj6U7HU
	ogkKApFbOcp1iIon0aiuU/fdWHbWl+028V+KqgELc0dzXcef3Wx0zPDbrsd9oN7ORaiwSrveXNv
	DGvpMqWzwxls8=
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id d75a77b69052e-4e89d263d69mr120018971cf.31.1760874775010;
        Sun, 19 Oct 2025 04:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPcnFN62n4rxi/er56tz0GO9JJVb5HUURvhr8kT25MVhi+bHd5RuXDHCFN4GVJs/pYXza+tQ==
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id d75a77b69052e-4e89d263d69mr120018661cf.31.1760874774327;
        Sun, 19 Oct 2025 04:52:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def28beasm1501207e87.114.2025.10.19.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 04:52:53 -0700 (PDT)
Date: Sun, 19 Oct 2025 14:52:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
        sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
        alex.vinarskis@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_riteshk@quicnic.com,
        quic_amitsi@quicnic.com
Subject: Re: [PATCH 3/4] arm64: dts: qcom: lemans-ride: Enable dispcc1
Message-ID: <mxim7iweydzzhetqlao54hrd4ntufdhwdsbaunblyhlovdv25z@gct5iydvzbzu>
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-4-quic_mkuntuma@quicinc.com>
 <v4b35cmwbkoosdgs3d6ftml4yvdkyh27q65ssqojplb7uyniwp@wuxbeof7cikr>
 <869d1f94-9d66-4045-abdb-6e88d504a884@oss.qualcomm.com>
 <62nvkgq4f5hoew4lbvszizplkm67t67dbpskej3ha6m55jnblx@vajuvual7lng>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62nvkgq4f5hoew4lbvszizplkm67t67dbpskej3ha6m55jnblx@vajuvual7lng>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXzfQqI61aJWWE
 LIJJcU6Kk2/2C+tXI0lq9sRSn1yBcD0V0G2bnw2ZpfSktaGHFr1rGa7wl6NNMsskKhUBfzWqxKR
 aujCKpyb3wuLMNsgkSmTdlWVgkpoDX5JLXEuy6Gwnz03ZVgjVLVrtytLmFxt7qWkJs6u6Bgerzs
 he9mYcHH8T+g9VB/S0ZK9xYZMQtWS9nXemyLuO0WKexMpr1ADECX0f1QG4hreIDTwaq8f6wkXRV
 +GBVRmNWGCYBLXWrrC37CcYgBwvhNempBgJp6zClZ5CfBeHgs/E7BeSIWhQ7NPXMoTHGGgAfAjs
 PKptalPo78/yfgO1WNNF0r+vXA1gPHb7xaJcDqjqJ+3mrnNOBN7Ll/8BdnS+JCt28Q1kTqP6Vv5
 3938DM8s1wddlanJS2c5d65rV48uMg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f4d117 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=vRBcCzbY8zNoOr-dCfEA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PMGxS6ojJUo0LjOcw3qq5GUHU-yiSvu5
X-Proofpoint-ORIG-GUID: PMGxS6ojJUo0LjOcw3qq5GUHU-yiSvu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Fri, Oct 17, 2025 at 03:54:09PM -0700, Bjorn Andersson wrote:
> On Wed, Oct 01, 2025 at 11:43:44AM +0200, Konrad Dybcio wrote:
> > On 9/26/25 3:53 PM, Dmitry Baryshkov wrote:
> > > On Fri, Sep 26, 2025 at 02:29:55PM +0530, Mani Chandana Ballary Kuntumalla wrote:
> > >> This change enables display1 clock controller.
> > >>
> > >> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> > >> ---
> > >>  arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> > >> index c69aa2f41ce2..d4436bc473ba 100644
> > >> --- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> > >> +++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
> > >> @@ -436,6 +436,10 @@ vreg_l8e: ldo8 {
> > >>  	};
> > >>  };
> > >>  
> > >> +&dispcc1 {
> > >> +	status = "okay";
> > > 
> > > I think this one should be enabled by default. Unless Konrad or Bjorn
> > > disagrees, please fix lemans.dtsi.
> > 
> > Of course there is no reason for clock controllers to be disabled
> > 
> 
> On SC8280XP we have the same setup (two MDSS), there the clock
> controller was left disabled because not all SKUs had that IP-block
> accessible.

Do you mean some auto platforms or something else?

> 
> Whether this is the case of not for Lemans I don't know, if it is then
> the commit message should have stated that.
> 
> Regards,
> Bjorn
> 
> > Konrad

-- 
With best wishes
Dmitry

