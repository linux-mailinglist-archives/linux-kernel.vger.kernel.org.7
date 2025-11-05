Return-Path: <linux-kernel+bounces-886995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA6C372BE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F1066473E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7233DEF9;
	Wed,  5 Nov 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pv4jYy4I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyyjwFBZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA3330313
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362183; cv=none; b=aZgLk6sYsa1Sv9d6qEp4GI8naelNrHBrLrZJRl96xz0ELTZnO6K9Iqzzdj38iHeAzCXdWMGwb8/TdvqCqUox37zGLmR9TLVGBPv5UKiFJZAOL+CEolK+FT4oNDKxqKQ6EsZkctoiDoZn3FsaSohz/CuXSNrdOr40qS91wAzcKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362183; c=relaxed/simple;
	bh=yp/bnWLHfETEVmldtVZrLCIHTQ/Vp3q+ORHES0tz+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc/1zNI0a0MluZlPKA8n8rh02YJefYNJGW4g/ul7U3AZuDZ1XUz8JY84RNKzBc28gOwIMD0h1GlXYQ8mT/km1IQ7T9DBu7eSpcSunIsFU7yT99M5C5j1EeeJ9GLj0E/Ff/5DUFLKRobn4b+EPvhfQTfDBbZZFUxnRM33WOv5Od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pv4jYy4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyyjwFBZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A599ijD356682
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qyYx+66r12SMj/Ysz7zSUgAk
	oAonFWXlCXbOfXMij+Y=; b=Pv4jYy4I3b11wSUZ2im4uhyPzm/y+/stDpujl6ae
	SiNWLdcpi7Q11oQzcyjYzdYjIyNIV9TfBlxMNfiQJ1m+PJN5mUZoWSts3JG93ksJ
	UBkjQ64EkRdw/TMWyHM8bKnHGJJoYMkvYhUUNBWWf2IlinCVSQ6AgGl9KTH/WLF7
	F96b115k6lQXgRqyxp0hHDslt+Jl/+fl++2atmkU2kQFupy8OXAjI0Z1EvWZQprn
	Ktq5855P0EPs5kZjpDbjJP6/SRlwqS5jEsZDAK9b3EtlPjmjjn2M5EPrG6ALcTzN
	sOINubAo76eS/2Ob0dRw+m7S7oEbjs/Ltq6M46oKW84i0w==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a83q5haya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:02:59 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-786a9b0d282so12721987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762362179; x=1762966979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyYx+66r12SMj/Ysz7zSUgAkoAonFWXlCXbOfXMij+Y=;
        b=CyyjwFBZR8CJgkYbX9pRCeQMX0RvebEVsZ3DH/vNCsUr068EOIC6CYNQBW2htbfQX0
         OTmYjeAY45MsNeGFHexNF2Qoq26YYm4RuHLQLyvTEnSHgykRTsSzJ0TVnKN1760nY1ek
         tYoav20WxbomSu7nuSZ5xkQGmcKFO4A47oIcyJGp0VT32RFyET+t4wQgmkJlhfnfrl/R
         6fgwufYKQBTg4VJ0P5CAM+z4KNW+dSqsTqfZa+ns87ZUzrUkvoGw5/d4lQfBD3Oc8sRI
         hJlUw7jJKjXm1zNkR0BX5uhLZn6bGCTLYn/WSqBUbbWpCfozuMA6cInpPfY6TLeIo7uj
         HQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362179; x=1762966979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyYx+66r12SMj/Ysz7zSUgAkoAonFWXlCXbOfXMij+Y=;
        b=Iw1hiFIEBT9PrtVqEovyiXVCUsk/VmT/8OBzXg+/7B8AycL94YIXLs5YyEuH9LbGND
         p/EEuE9dKzDzb+dMiJORN7I6o5Ij2YgkgFMKpW69ZX5Lrs/Y9NxTIEsPKvQ3Vvh/iTzO
         sj0P20y1Fi475vcfQubazhBQk2pLLiQgxBi7xnGge/ASaNGTEeczbkiMPRpEqe3teBUc
         BLx6HvcaLe84s1LU7goor2mihOHfqVjiN0J+rlcNUqIVFXHiQw3wXTzCfSFPUHVMY7nm
         EjU2rgbIw4jQwjfNWhrKZaDzj+j50HZ/ebb95fNm1oKNP0009KOawOg0Yc0uzSePk5Fk
         drlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPqV+xLHEbwgdS/+VV8hRLwWU4SqdbwuFLDqg7g6s0gUU3djeCyWcdmIJzb+s5ewZFZ4KnLwVDSMyCBAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDov9eiAwk3i6dZYNwUcfQiW98ehd2mvbTMIwIRVq3mq9PV/+
	sR+3jv9zMKlQzv0dCJavmV89WsWjnTpabKXFISlO4O7UF23oqYnoSsyMER0MZ0ywFL4Lg/JHKWb
	cu4Mgsj7T7Q6vzTeLHqzniEraLbVUn5cf5w7TVLA/Ak/A8vxQvJ9XgFAgACph6s+54IM=
X-Gm-Gg: ASbGncsNQTPOHk+4qKPixmGKtLRXBKmfesCQj/Ntn6g0JqoysR3gixECQZxn7nvkX/I
	cIqpnZLNIYtRs0iehAF9WXlNzQs+GRtFJcWCsFjL4c00q/TAxuqOojqqsWGSekag+zT9KeDQmAf
	pX2+IN4KwXMOGsEv1qNHiASDjcaoq5GwAQefQrhje5IcacepqapAS/VF1HLc9vmIJ5igcwX//pr
	4waH5ep8ph250JPsqOZQlU4kCXecjnjcYTiOeBoFsa3rvB8XTe2A6vx12lO5jUe/De1IovX7INw
	mEfZfQKA2IbeEkFHXOAejhqiClFVnpPNXEsD5P+k+DcatCwK6xOShNkb0wujA674sDuINUA1L4k
	ENl61lN9P3KCCpRj/7ybYmPrCUSNgdH0Rnlq5oQxvMvsgmyRFMy1WR1owoW5n+pWFW47d/fozAS
	d9ssUEphWwd4Ha
X-Received: by 2002:a05:690e:c43:b0:63e:3099:fe7c with SMTP id 956f58d0204a3-63fd34c50f5mr3160663d50.16.1762362178881;
        Wed, 05 Nov 2025 09:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTAmyohmCTXGVTToGXMGdUogTSBLrIX4kz1aq4q66xM2USJqaQ352zw9xnhAw2RV1nJjCJjw==
X-Received: by 2002:a05:690e:c43:b0:63e:3099:fe7c with SMTP id 956f58d0204a3-63fd34c50f5mr3160583d50.16.1762362178181;
        Wed, 05 Nov 2025 09:02:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594492b411esm34691e87.105.2025.11.05.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:02:57 -0800 (PST)
Date: Wed, 5 Nov 2025 19:02:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/5] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Message-ID: <motuct5ezykbkta2wz7ek2vwnfaamphrl7b2wpv2bvu7qnnbmc@4j4aurlva4iw>
References: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
 <20251105-a663-gpu-support-v7-2-1bcf7f151125@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-a663-gpu-support-v7-2-1bcf7f151125@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1Lk8S5mvYEBft_YrwOeCL38UGTMMuaRC
X-Proofpoint-GUID: 1Lk8S5mvYEBft_YrwOeCL38UGTMMuaRC
X-Authority-Analysis: v=2.4 cv=YZKwJgRf c=1 sm=1 tr=0 ts=690b8343 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=UQAiW8fk4jwks4S4FoYA:9
 a=CjuIK1q_8ugA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMiBTYWx0ZWRfX7V/mk7OSX3kK
 xbB+xUfUHmUNeELrJAn+Q/NjOYmb/xqnnhQ1HwbFYP84ONcvOJFIYlqunt/m/JLpeQrzutlbtsO
 MOWeDZReuy6jWGjOZazKOuKBDpr6LIz0+x+Mv9zfqr2JpSNeMZAKyrWT5FfPzGzfMQJbZf8P7C2
 4YI0+kaKzFcFxWe+aUanTKJDYWs896dqsn3LLllW5OaX1pDjp76Vw5z2vlL27BVBv5zvfftWn8i
 Crye61ID9VVB3S/Q77fTUgE4Yn7bXvGtDbsSQWj151l75911Eid5cYamwiUPAgUauKcVBtTXacx
 pWTfKTfUugH2SzcUg4+P3hdhs+BVtLtPE9wMit4QujR4qPgvtPhCeBxMYsXByN136omLyhfBJL/
 2h3+8ZZjkiA7vF+yqevlPjGy6VqhOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050132

On Wed, Nov 05, 2025 at 10:15:46PM +0530, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Add gpu and gmu nodes for sa8775p chipset. Also, add the speedbin
> qfprom node and wire it up with GPU node.

Technically the subject should be updated to use 'lemans:' instead of
'sa8775p:'

> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 119 +++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 

-- 
With best wishes
Dmitry

