Return-Path: <linux-kernel+bounces-845447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5DBC4F73
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C83402C77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF42494F8;
	Wed,  8 Oct 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8En/Nhy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971E2264A3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927775; cv=none; b=k/qBOgMbgc3eJHfJAiTKVofEXDuRqPbdnqUVU8ySfiKB+XUQf3u8bsZyaxOyDAHUcHj8euucOYM76Y7baaYI2LgUMWbbt7bOPTsZkmwoSkSH/1enGqIB/SIIG4DtwkZ/17cvVli0uVZrQ2wMBuYZ6gPYoPaOKb0Dk8j7GzM18cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927775; c=relaxed/simple;
	bh=uvY8+U4GBK6Uc4Shp69kQpaAXpdtDNGDh91kAjLxILI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQrM+F+zRXixatP2C4KOTzDluCzM5i76WrmqcEFLfIRYKR/yp7ITQPyoyoF6cYmHD4WvZOQKAXVlStelSDIuywH0HVyjdia+gmBCLkfaYTxf4fKINYsR7fL7QjaXa6d539uyo6/TjjL4tvYgeOcWIkaLSjjk4f6YqIpkDAlWtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8En/Nhy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890mZk029962
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o2l8a/RrMPRcP4HFtypecMkn
	iIuriznY41w/vPB6cWA=; b=A8En/NhyIRh4HBUKryyFxcP6tqikwtzeowJFs/Y/
	bSMfBxwyD7jcPRkkyhOpF7d6hk+X1brXogBJ38N35TZkVAPV88ISBzcEt9z7/ZJ5
	24O7ZR35KJEQii2T1RY91FDEExU1SqmS41wD7tKKuqRSEss2+PNneeq6e6zrjm3I
	lSwJ3QDc1Fpfojoap+WJtabhSPYUoC47wCl7qwaehiBk3X1laIHv6kw1IXjJndlF
	XplTvtDIBLRVK/fis3YjZk/AvZP1Fyn1hSDB6HiUmyr2hsgHPqFELpoecUDIGIwD
	fKw6dZmWAkOdv5SaqgwYtMhhYoynotcg79GgfeENCSeMFQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgtjb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:49:33 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8776a952dd4so156525646d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927772; x=1760532572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2l8a/RrMPRcP4HFtypecMkniIuriznY41w/vPB6cWA=;
        b=SfGGZjIai2V0ue+DyryBI4Suvp1xW+A/TVXsVRHdWDlP6maPHvUqeySAKeFFrixGS6
         8AgFe6FJpjC+N36jwRnuOy3caYpQrl/YAd1BfPp3og9dcmI35gO1srKQbCI4BnaASPm5
         0AbiXwRtNJUnHZpk5lI3B5XNeBltr83bOwCAdSQOpOgEmm5PIurKc5cx+WTP2Bkeuz6j
         PgLPWFD2sTcfQCjBKSzP4p2n9ZJ9zOVY5uL83mY1tAmBdsTQvgcr+Z/ctDLCkFBcaCCG
         dy1pqO49aFam1GwL60GnYkrg5kHoTp9Ve507+RC1Su/n+Ok7N+6XsZHvWnY7rwoGv2XV
         7dNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/1LE8CDHdFpb27Sy1MKEztKS7Ps9DhT+uxQOmsq9OAt9ZcIyFCh3em0ExjpseqcHMOZXc1Ln6tb/1MEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLPOZFZ7kbg8Zjp5yWlQRx8+NPSJRmWJ/7i9sgQ91YiUNnqv6V
	ml9Z4mmMcmJq627NUmPTMNoUEfacY+LqtYWy96C6ulNNUIEMCOJAKylq+azejE41HThMe0BtyOd
	2mxWEqTtlxHbXii4Y1CvNPReB2kpAE6eXyikpRflIhIdZUNvJ0OODn7TRk+tRiuqI434=
X-Gm-Gg: ASbGncu2uApzLTLXiwHIRY3UXcOOt0v8+/q3Oq4lhMR6Ly/JzRIe9AbwU3Xf9ZvdYJT
	M8qvZopHlay+N/SnIXuFWnahX+et3WceI8PEHdvuvPsdsyMfUnP2ZiOJck7Mmf1U/2EwjXAM+te
	sj1yokjKs8SwejQqn05C913c37TKrTna/hUrYb6hAt3cWGZih6TiFzEgjaYoue9fWXiU5b6oZrw
	S8ucFCBVp9cQyWY/CFR9g/9eSqcAP72kIWiMGafI8vzf8O+q3w1sSnd2zuoIueuBh1UMJec0ise
	JVEaPKpnhDb52DsAW+F6eqCblL5LkEQNZOZ5gzbINXB5flQggFzdSAn94xAssJjFzmJFXutb754
	6b9UQp65gaq6Hpij3BGJym3aR5G3gcb2WUoxYSOqMt49+iZKEzNpmXWdv+Q==
X-Received: by 2002:a05:622a:1492:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e6ead694f8mr45839141cf.74.1759927772261;
        Wed, 08 Oct 2025 05:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6R45gywYeXfKfF/AAK9J8gCfjus0oEKiXMqBK9n/2HJsk3Zc+ToSrG2ZqrEHLeKIGtHha6Q==
X-Received: by 2002:a05:622a:1492:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e6ead694f8mr45838661cf.74.1759927771781;
        Wed, 08 Oct 2025 05:49:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fcb2dsm20195561fa.22.2025.10.08.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:49:30 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
        marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        abhinav.kumar@linux.dev, sean@poorly.run, airlied@gmail.com,
        simona@ffwll.ch, alex.vinarskis@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
Subject: Re: [PATCH 2/4] arm64: dts: qcom: lemans: add mdss1 displayPort
 device nodes
Message-ID: <6uo2w4lscjlx5mtio2xw3xgyyu6kem6kavtdxtu7cbyix6kews@h2ou2awbppzy>
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-3-quic_mkuntuma@quicinc.com>
 <e3400ab5-c4ea-455a-b8ea-d4fba2ece85d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3400ab5-c4ea-455a-b8ea-d4fba2ece85d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX3cEJf2TzSQnh
 qOAjaBCt5QsV8KvRHp99Bz5l4AexUfbjtLeWTyHvn26IG81Z56ErhoNVTQsiItmmIdHiW9PbJ/g
 TTfbKE+lzr9YUJlJzgJ0dBpqrXFHTzpLM5voHJzEq8mzd6NRSbuangSIeCkYrpD9GgGzSifwS5s
 71zJRkxkCxKOBoWIm7xtR/1r7brdwD5SASnn6XwbrbPUomEhfkIKfIUxR+W3Zw7XjvbFwvvMJRL
 vppsKuXEJ5yMI3R84NKb/MhztPzFR5BExgvYITJdiqdFgDiIdJeEvl39nwLF7WvO3VQ7tONuXBt
 ztkZvYRAxdN54WPi4WwIKSHyJnPJN9M7fIzGc2VGaRIAQ3J4gnTIk2EfgtcHd4euDls9pn9spux
 HT98yDJqs96dOA6Jz38DE6mSXkOFaA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e65ddd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=dL1b4mpT1AD2RcxrWJwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: V7Fs7GS4DlYG2CBYkBnLzKk_V-UWyCCp
X-Proofpoint-ORIG-GUID: V7Fs7GS4DlYG2CBYkBnLzKk_V-UWyCCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On Wed, Oct 08, 2025 at 02:40:35PM +0200, Konrad Dybcio wrote:
> On 9/26/25 10:59 AM, Mani Chandana Ballary Kuntumalla wrote:
> > Add device tree nodes for the mdss1 DPTX0 and DPTX1 controllers
> > with their corresponding PHYs.
> > 
> > Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> > ---
> 
> [...]
> 
> > +			mdss1_dp0: displayport-controller@22154000 {
> > +				compatible = "qcom,sa8775p-dp";
> > +
> > +				reg = <0x0 0x22154000 0x0 0x104>,
> 
> sz = 0x200

Hmm, why? I think the memory map specifies these sizes.

> 
> 
> > +			mdss1_dp1: displayport-controller@2215c000 {
> > +				compatible = "qcom,sa8775p-dp";
> > +
> > +				reg = <0x0 0x2215c000 0x0 0x104>,
> > +				      <0x0 0x2215c200 0x0 0x0c0>,
> > +				      <0x0 0x2215d000 0x0 0x770>,
> > +				      <0x0 0x2215e000 0x0 0x09c>,
> > +				      <0x0 0x2215f000 0x0 0x09c>,
> > +				      <0x0 0x22160000 0x0 0x09c>,
> > +				      <0x0 0x22161000 0x0 0x09c>,
> > +				      <0x0 0x22162000 0x0 0x23c>,
> > +				      <0x0 0x22163000 0x0 0x23c>;
> 
> 0x2216_2000 and _3000 don't exist, there's no MST2/3

Hmm, I will need to check this...

> 
> sizes should be changed similarly 
> 
> [...]
> 
> >  		dispcc1: clock-controller@22100000 {
> > @@ -6872,6 +7115,8 @@ dispcc1: clock-controller@22100000 {
> >  				 <&rpmhcc RPMH_CXO_CLK>,
> >  				 <&rpmhcc RPMH_CXO_CLK_A>,
> >  				 <&sleep_clk>,
> > +				 <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>,
> > +				 <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>,
> >  				 <0>, <0>, <0>, <0>,
> 
> You need to remove the same amount of zeroes that you added

Nice catch. Which means that somebody was sending untested patches.
Nice.

-- 
With best wishes
Dmitry

