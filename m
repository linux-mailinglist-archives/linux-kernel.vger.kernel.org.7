Return-Path: <linux-kernel+bounces-868057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58AC0440D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A4219A331F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E726FA67;
	Fri, 24 Oct 2025 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSkLe2wE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686926F28A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276491; cv=none; b=g4mfQpW5ZdaHDsFKF4JUOPD/8zjHYV96gOcO7XmPQO4HGDKi9T3hvjTKRvIHdLuoJMX4uxS1ugVZ62v/rpgVyOpFMakscKZcvvv0mEsrV9YzlTuw2GrSqSORBLJgfEl4WHhxYBE2biCda++deHuDt+zUNtu5ujbT5oCC3tZWQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276491; c=relaxed/simple;
	bh=URfQXCT0Oo1XzPB6UUfoeOejCbgTclqtEEluHABIaUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDGdlSrDlQI45dO4K/3BcJxamjWFv7e1Yej6kOzo3+5xf4kWJstPYuFwMs1PBR/Bzg0xcATknYlI5B6HLpBfgXBBSA2kfKM48FQDzTV1gDIeOOnkF08OQHP3H/e63k+er2ZeWAyYENctsDQ4YrHxgSUOdEiFpqWqfhqr7/1y4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSkLe2wE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3MHLI021692
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hZRKGHf5eiS7medbsEc1yTLg
	vLooHsK/MU89hBujSiA=; b=kSkLe2wEBX6htBZhmJddfIpPgH8+2BOgJcKUnTPn
	LA7b3rz7bThHoqr5R3H4BHfAnHL75uEabGJ7D7mR1QR+Ns3xXgWtrugaiV4V6gNF
	5KRbQ+cavGnM4Od0PZUl9GIBFuedmlbwW8DOJnE6jW0H7ugjPcZ1t6LgmM605il4
	qqhHDdV/3qZNooHaCR0TteVcp3JaVzPKYRaVEsCWVeqwGZSbX9LIlAXM098HszX5
	9tll+BVOkuhWRdEU7yFPdzRkhZJQNkdLk9Q1Ml1YAe/mddkZzUrBrfcBsx+ZlROm
	FAX7Ju381ZYHpsYyJOxhel9T4MY4IFug5XCl57pHafLXEQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8mtja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:28:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88d842aa73aso563445185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276486; x=1761881286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZRKGHf5eiS7medbsEc1yTLgvLooHsK/MU89hBujSiA=;
        b=K2eqKqhqfh6qRH4iQD5X/mUaOTbOi4pAMBObQ4rwSGkrNviM3OxOWoAGbjlcSWP90E
         ab+g45zFglgKUrSODS2GkZRZFPP9YXuSYTaCY7TgumtjrmXMkt9MioEY6Il8Z74OSQYI
         gkQyZWmFwnir7jAgrpsx7uTTV0ifGh/4ZTaqee4QJCoPqeMiPO6JNcSR3tZaFr90tYSY
         HUtqc+9SpYICXTQYbMyJXwb58cNoD9STmT2Si4eNWqz30MMYfg6gK5Vm2i/2Cyvjnyxt
         todBIZUDOKWZMhMONU5NJv15x5OnBSA4n8p5o0pCt4YFVi9Kql93L7a7kn5DXWnck8Lt
         z3ug==
X-Forwarded-Encrypted: i=1; AJvYcCU3hH24+NhLrgoWEMzSgTG3039EQr75RReJKhG1E5kFtkEMyqfayfsmcdVMyr0AvhH00lCbolwCBL77BjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60Vf7nHn2gFbbKEv6ZS+7taUWSNc96dJZWWai1yXB42Bu3WNl
	S3vhsNn4nHADeEuCgjKRySd9+Rd99Us4YK6j44rt8ABGrT9FL6hm9mOYggK7HO1XuqZEEdo2ke9
	Ba6X2ghyynDl2ui7QM6bmw15vC7OHGdZrYtGF3TukcGy6Iir0wL2WqMxxwharFytDFuI=
X-Gm-Gg: ASbGncvLD1keqw86seq/79GIxdSmXF0L8rq+qX4rRoGWHfrDf87KSE6qeCmhC3f15je
	2Hn+yCC+RmYFtz1IK+j8Ssr7m7k7MYJsL4+MNzG3abGpC4I/BuLdPvZU2kV9V11Punf65JpEodj
	VOUMoLjZxNhNfInaV8nwxNQ09VjFBp/JohooxhceKQCXx74NswdX4ulDdCQhBBtAS+Lq2l65O41
	eZVoJdJ3WaXYhgIOcRMB6reQe68fXWB7BRZwZg5TN6GnvW4HOeN8U2kS1hWBnITc1LjjgFgZtLM
	HWzktLX0jLhSaLFyUoVxqN6qdU/auBBc2Wknrgj9kLGmd7CSqw1CvMqCHOYP2w+kOUzR9mkIj5k
	FHVK3vDf+JEi10086+RaGKwQmJNhnuFGJw3r9N5v0ZXplfUW3W8wKId17Ch4b
X-Received: by 2002:a05:620a:6884:b0:868:1899:b3c4 with SMTP id af79cd13be357-89070115826mr3155293085a.48.1761276486141;
        Thu, 23 Oct 2025 20:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnIyfQMj4mmjccKB+vbnKu6/RWvsqjZb5kPuk+y1TdkZQGLJl3cVSm65rC7YNEyAuhfj8+ig==
X-Received: by 2002:a05:620a:6884:b0:868:1899:b3c4 with SMTP id af79cd13be357-89070115826mr3155290385a.48.1761276485620;
        Thu, 23 Oct 2025 20:28:05 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c1169a47esm299748285a.37.2025.10.23.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:28:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:27:53 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Message-ID: <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: uAVc5xdbjZ9OFHo-zGrz6ilrZ8EhOvQL
X-Proofpoint-GUID: uAVc5xdbjZ9OFHo-zGrz6ilrZ8EhOvQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX31z+6+oZrS1R
 H/NSaEU0xtC8TyJFAl2ZSZq3v4YNl5GheEJj80sSl3B+ekDRrAuQvtAShfprht8diILcJlg7Cvp
 T9CpVdfWEqJxbi8iGch3kd9G9/dsPuQ/soOcElxcomscfuyzu0M354J5uNe5/n+K6MPPOZe42RX
 hxWsIll+gUhs+MMJRxzKtRUgEIxuicOZM0i2YYqMm4ACrgfvRsziZDMVz0tvCTFpTxUXLU3MDmR
 kJQVMn755zGMdXCx/4CNgrA27YyXRbU9hNhx+LCSVH3GZV7VQyYX26a1n2ETR5knm2+RZirUxun
 RTulmdTaErGg4XMgh/cg16rPoZKat4DESUZkoixdfINCSelN1WO/8eAty7Gl+tTVJUco2ZpCELz
 yKUtWyDC67dx68x/dIIz+2bEMyQLpA==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68faf247 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=w-wrxfCwE3y99oquOGQA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
> >> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> >>
> >> Add DSI PHY support for the Kaanapali platform.
> >>
> >> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> >> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> >> ---
> 
> [...]
> 
> >> +	.io_start = { 0x9ac1000, 0xae97000 },
> > 
> > These two addresses are very strange. Would you care to explain? Other
> > than that there is no difference from SM8750 entry.
> 
> They're correct.
> Although they correspond to DSI_0 and DSI_2..
> 
> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
> new features. Please provide some more context and how that impacts
> the hw description.

Thanks for your reminder.

Correct here:
io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1

And v2.10.0 no clearly meaningful changes compared to v2.9.0.
just some register address change.

Thanks,
Yuanjie
 
> Konrad

