Return-Path: <linux-kernel+bounces-800500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B98B43872
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AA91B25894
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78002FC86F;
	Thu,  4 Sep 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2+Ubdhu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C52F9C2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981024; cv=none; b=dVuVXNvz2q+xjjsrR9pG1R+kt+HFrWWObkjQaIDv3Gg/wEQbxUFczA2XbgLjauzVuUDr82+q8157APWBRIGUrsKFnivg+1YcRQXMF+AEkaF0KJzCdjuWsLg/BG4QnQq8FVPpbpjnd4tB0BAcpXhHyhmxefhEM+wvQueKwuuazeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981024; c=relaxed/simple;
	bh=7MJyzBaUxP9X5PagJDcFR2Xl0v9tA5iGZjMRO04beHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZEc5srwrRGEKgV8c1ghU8L4loMNZeZm7yfPoKIjcF2qXiuINyhqbJJ3ssmqNa3U++dLnBAtxPB9/E9/VmRR/3D4lC6UImmJZxsaziA3x4JfKEAw/TQpOCszbfyLToqPM2NGHN5PY0C8xsgZQuX+b999jACn0w6939TNS8jjcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2+Ubdhu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X780013583
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 10:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rmgllivFRv6RjPwaBGym+Zby
	4n60SrTDmfiiEvhrg5E=; b=b2+UbdhuhLawegkDcLTK0dX7H/ggcXf3MnP37WvU
	c2aEonH9wF0KhNcaKD6oLOfakxBTr58H8WNkcve053YRYurMvjEzksh5jwxIUozJ
	pu2nu6SPAxDk8IAeTeaDOuIViFGlAbA6GDH9sGYi+lXbti1tNjB0IB2FqbRW2jrA
	YNVNmCacrLyh/GYV+y8Ol4dmdbzNn/yHEKicAmEWWN88PkZlVIbEEe7nS47rbTvX
	OYv5eLMFVOOITqurcEpiqbSnTgfHeogQWBGsH7z+A0qcEpUvtY2EMXsutsK0vSfX
	RGCP5nM6Wh2Lgo3pR/mKoA/CpcoDH6deWIDYQhMHLFxt0A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyb160-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:17:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c99f6521dso11711045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981020; x=1757585820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmgllivFRv6RjPwaBGym+Zby4n60SrTDmfiiEvhrg5E=;
        b=ldlMZZUxPEXcpUax6bHvSm9yAcmVypQK0xdZzJBvZiMxPHqVRZiRreHWK5osUzlnTS
         kyrhAmA3RFriZR1+eqYSDApIC8LwIxXXoXQJbeE5N3d7jV0pI7HZAbxffWFqbi9h4oTF
         dVhM23iuQyGAw0YK9XxjsXSxQvbkD/AUbxJpBOgEW9dG94YhcO0xu+ETOEFjJurhiXjX
         GVpnwFCLHWnv3wTgKDFxDsAxIkGiZm36PoLC9ngUNoSlMRs4SiziLYUiX5ZhHDCKFDXq
         dBjZJC1mkoqVt9caCBfsQg0jQiIJg2P882IcNfJ4E0Hqn7NYm2MoSmBMJ8s5JiG5Nfwo
         dtjw==
X-Forwarded-Encrypted: i=1; AJvYcCX31mIV7jEf89ubuReDjM1MsvkF7i9VBJ1BGKfATk4plO5Com+6XwYtHeK7kAIKK8uVsS+ANNIo7y+74tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjudNmCME00dXIMlzv3d5VlsGNawi94kc+K8PEAWLRVAISsMu
	33527PO0wC4xfD/ZafkQAav//iemqacZ6qZ+Srtj13tCMfHObTG4zjKgFqruTzuG32bfPCon5Jb
	6IsVx3Xxr2hObDAiL6OgUHMm6xocGxeJa4cMcdlWjRF7ksWFdhOldaBnjmKI0N8LsM0vqXmhdik
	NGXw==
X-Gm-Gg: ASbGncuVYRV7JC5CCCl1KpgJCew/2y0qBhkIX0GVHy1C+EP1cj+mxQVVwnK53q6GiVk
	CtUYCagbnyxtmsP8OadhQfdfEi53uUpdZwDiqF+tXjPzcPLlUM8PXY6YeEHKfuaNWkDdlxWbnO1
	VtdElyBKvIX/wiwYlElERsVjtPT7STfslx1rV6iZUrlNIxQhpRCWTLRRBZwuwhhCYBH5u3XkPmE
	VoBDBX8nxmpyxF7M4XhXyTp4/hFR2+A9ndCibDQwVCINdcw0AmaV2grwlVjXB12GrlXrmFqeB1/
	dLnRszs2iGLsJ/09hQ2Gs2g8+1MLzA8+tzAwY8TZ84F5FftQ3XnZuPpsR6JJpYDQAe6cSCCV9A=
	=
X-Received: by 2002:a17:902:f70d:b0:248:d917:a57c with SMTP id d9443c01a7336-24944ad11e1mr272852135ad.40.1756981019641;
        Thu, 04 Sep 2025 03:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF62jdk6gndKp8OgF73KFyvJIMRCikJPPEDPzJaEVOadSZ9EtTIxaw+Nb5rGXP78fAdDW33dA==
X-Received: by 2002:a17:902:f70d:b0:248:d917:a57c with SMTP id d9443c01a7336-24944ad11e1mr272851775ad.40.1756981019086;
        Thu, 04 Sep 2025 03:16:59 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc91987f4sm14453055ad.33.2025.09.04.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:16:58 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:46:52 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add binding for gunyah watchdog
Message-ID: <5210a5e2-0d75-4532-b3ca-1cbdf8ea2a9e@quicinc.com>
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
 <20250903-gunyah_watchdog-v1-1-3ae690530e4b@oss.qualcomm.com>
 <ea295ff6-5395-4470-afc2-76e5e2dc9fb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea295ff6-5395-4470-afc2-76e5e2dc9fb5@kernel.org>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b9671d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=gEfo2CItAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=oqeMfTGgUyYRHvyDDiUA:9
 a=CjuIK1q_8ugA:10 a=i6qsmYmKKdoA:10 a=csto0wWSG80A:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: h264ai56Cxf0gsyNgsuGk1nCdb6vRI-a
X-Proofpoint-ORIG-GUID: h264ai56Cxf0gsyNgsuGk1nCdb6vRI-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX4DA637C/xCwJ
 NxhFdtrYKs066ydK2guejs+Ivs5KH6XuxvyKGgTnygupasUCs39dSIGW/Yj1pm/jSd0yKAkBt9y
 i3LQYD/fwtY7mqPXQZnng4NZZ+VXkEEYj8ame7gFjtwb1g6g+R/qHKK7LyVaF32AQw0XtWDdEKL
 uFgrtRk79BN1s+lSfPoSveH5xRsFrWPvN9XgCGeueq48mzufipIm37bEo1CJjw/fTAUfoX4MnHP
 SqVc0J2hhg9GETQiUUK/MQe9tGskh3jOMA3l9/hUb2L/1h3zDHNZSEmklY4WR2cW/3UO7X/u6BN
 chIBZ+p9T4B0OTm1bJSr1K4PfcmPmhCkq2BqvnL8c1Nt8Gd9EFg5Rc3EpjgGTdH5t96CMkrIPrM
 6B+kw8vE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Thu, Sep 04, 2025 at 11:52:32AM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2025 21:33, Hrishabh Rajput via B4 Relay wrote:
> > From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > 
> > The Gunyah Hypervisor applies a devicetree overlay providing the
> > pretimeout interrupt for the Gunyah Watchdog that it will be using to
> > notify watchdog's pretimeout event. Add the DT bindings that Gunyah
> > adheres to for the hypervisor and watchdog.
> 
> Wasn't tested, so limited review.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> 
> > 
> > Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > ---
> >  .../bindings/watchdog/qcom,gh-watchdog.yaml        | 76 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml
> > new file mode 100644
> > index 000000000000..bde8438c6242
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/qcom,gh-watchdog.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/qcom,gh-watchdog.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Gunyah Virtual Watchdog
> > +
> > +maintainers:
> > +  - Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > +
> > +description: |+
> > +  The Gunyah Hypervisor provides an SMC-based watchdog interface for its virtual
> > +  machines. The virtual machines use this information to determine the
> > +  pretimeout IRQ which the hypervisor will be using to communicate pretimeout
> > +  event.
> > +  See also: [1]
> > +
> > +  [1]: https://github.com/quic/gunyah-resource-manager/blob/1b23ceb0dfa010b3b6b5a5f7a4ec1e95b93ab99d/src/vm_creation/dto_construct.c#L519
> > +
> > +properties:
> > +  compatible:
> > +    allOf:
> > +      - const: gunyah-hypervisor
> > +      - const: simple-bus
> 
> What? No.
> 
> Don't create patches with AI.
> 
I am next to Hrishabh when he is writing this patch. I can confirm he
did not use AI :-) not sure what tool Krzysztof is using to catch
patches being written with AI, that tool needs some improvement for
sure. 

I will let Hrishabh share why he put simple-bus here.

Thanks,
Pavan

