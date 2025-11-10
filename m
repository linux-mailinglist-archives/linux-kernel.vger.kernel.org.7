Return-Path: <linux-kernel+bounces-893155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84567C46A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 248404EB57E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AA23EA88;
	Mon, 10 Nov 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxerOKUe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVnX/ANM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEE30CDA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778357; cv=none; b=rDbAN5moonEEk8wicHeQ52DIuKOetM30+rmZXQiUnHE9G1gqaAx1LEFt5KUUzdgsZV2ONuBr5G7XPLaDBpgObmV0aorTcRK1o+0bbjtYwou3HThRtbVNqR7xdW+bvK/p7V5x6bMaxeDDXPBvqdCyBdcQzjfs8VOTKm2Kz/CMIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778357; c=relaxed/simple;
	bh=gFT+3Amm33MdGkcRdM74CB/X6g8NjdXUxYSkJHwrXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaoGVc7lCtmXwKtXUSPGTFP3L3C8EECEDV/UfxxVx2xMif7STfH/AkUNY/k2h8i5TIUx9TCZ73Iq/gVqM7EhQxdDhmgenWtZYmzuNbV2oY/KlAwgPuikDeq6OZzYn0Fca9cFr0DFGvbwrYmO1GYhkffFQwPVCtYI6SMBX/EMZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxerOKUe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVnX/ANM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8smUU1811815
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mu3glRqdWt9AjEDpzM9mxwbY
	vCJas7wdjM+G13lxLSI=; b=QxerOKUeZjj15a4crxY+DH4S8zzP3rWz/sO8sLwf
	sOCc0DMNDrPBJjio7zt0ZHZf0R15FgV3XeQanp+u8q6+vGmG53vze3ihn6PUiRmf
	s+pw6NrPstpg1NofLK/d18PaehVchBr3NaD3GJRQk68MOU/bobVe93QEWhzJKuej
	8UzyYtMBa3CbBczNocVTSi7OAaInx5B9wy/lsXdCI6/wVApM8oVkbQ4WukHGS1Dt
	jfarP1Ya8E6//EULG0O6O2p24ycwNdGg1vMSEfKW9x67ojiYCSHxUGdPwklM72Xu
	sgTUwKJdZ2GPBYH4ox/pCAnp5tDNpDOuy6909Qw8zdrxMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1hvb2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edae6297a2so2335701cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778352; x=1763383152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=gVnX/ANMniM9mqxpJ72ah+wuJEZGOLCMJSFnkIGI5bC6eC1i2PYzPipJEq21OwoxhE
         UgBHFU8ZEDj/5lehZytkE87VroxMWNMEX+R8fm07Lg4PMn3vnyIGbuyXc/pGlAuK+B6G
         YrQ5ltWOAL2h/NeT2UdqA/eF2Tc3IzsM5Xfn6YbTj0zbfdhBzo6R2CJpV/XDYmj3kT90
         xA+o4fdM/GWbriy+eSDxecFp94cgo06Qf3eMsdrpD+yL22G54JGFEd11jFGYyl4unkfK
         FEpBHH7VvJnY1+eKVLntCz9HBxT4p9JBblP8W6yCsWGy2aT3dbn8OlPgXUbe7xvGmi1w
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778352; x=1763383152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=HGecZ2Mmuz8TYyGkAhfOjHzKEcG4YaAdoZRmf/wvy9TdM3siYfgUNn75t45+iCwOU4
         LTKND+Xy8gyGWb1GsS95WU7BmPVfB4RB+9E0Ov5vYuEFYsW6hjLKxG517picrwk6NWJe
         kMgfRqoZUHtxSFPnpuL5EQmhsITrgBHEbub71x14D2MVTtMCZPcDI9zNgzv9bvukGcUN
         zRZAo9vjvaVpx6RqwLVJjeXSUvt6b94sOpltWyU5w6f8PPPV9sNAmC2+c3PRHb86LvCI
         RDxJHXcnwYzb18TvLHBq1EHUQK4o5I0OkkHFo8NQYLdnJkjdkwqwJDYekmoJTZUncmod
         MIEw==
X-Forwarded-Encrypted: i=1; AJvYcCXGKZQchapXoUSnn6qwGWLnorOegigFLEGqAGmw5GukfBlSYnOn0NWe2OrdHh74YAUsrDhKlTkf2FAzxM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybw8dC5zaE7RHOIEkdC/HzcW563I64NCRsAe10BIHzVHMWjPhL
	URZ39HawM84PJAnMgIzn37gehcYpUQW5nxYWWABoebLqTA979DhBZ4IqEZXm2EpFvACtW2nc4vx
	pfasgp2KwVUnQmWkLsy5paaC4ozpHTENLs77xHfrG5zrtJYPcd842ghUV6ttI7qeQubY=
X-Gm-Gg: ASbGncstbMHTNRfUqLdt2PvD/YMx92qEB0lovwU6njF7mmORYkQi0wIJ0ZVGYG3B+HS
	efGdJIeFgfAt/vywbIpB+4M0q1VZ3L7WYUXHrml3QWppfLzxduM71nfeEUlQ0CAet1Qs/WutQPM
	iAwAu056ks0iuAg2bnDSKoP86LYfLkWfT721uglVauW1GT2dw8bIpBfo4UA/ui6YxHLTZ6WEhc6
	KyTdDkzkURuok8LpkWKsYvFqu3uvDHN7eR9GswmHyRQuJl80+syAbr/sdfd8MWjne/6S/2jxxCY
	p83XWwGL1waMyTN6k/SAUKbRQypzH+e0euzupERx6YYCaFajt6uUrD/ZRHDcFyDdR6fdZMiLxTr
	lT0ZnLDyR59vUOtb4A62oZIsdl4+u/ii/TY5euXeYPHUU9TvFlBBygJvMS/9Qr/w5XJEO9qpks6
	mVFTI7/f1M1CtS
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893731cf.29.1762778352482;
        Mon, 10 Nov 2025 04:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc7FjOtBgPgHxkl2t4dPvZb4lKQroBgN5ujgHUpHoA0lYUguSSs9vhkQDvjQQA7BW9uWg36g==
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893141cf.29.1762778351861;
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019f21sm3973713e87.37.2025.11.10.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Date: Mon, 10 Nov 2025 14:39:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Message-ID: <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMCBTYWx0ZWRfX3A2lzJ+roa7h
 sZJNf03VTmkhqpDuYbmIrktHcgUOLTIur6viDjD9WBkT3DvXqWFrpaj3xXxdf6hAvTbZ1w3cD0f
 sdpqvccHPaEsP/8XipCaIDuHPZdwYo9N9uYf7eS9ummZt9zdjZwvh+B+03RfF1QwhK7GjRxlfhf
 KErJjlFt7Q5iHptIn+ZUhK2OzUMnOPXdUYvy46p/aXq+EYJEWWzNVeo2yYwuQX/jyaHRbawG9hC
 teosH40Vb/57CB6JQOIZYwMML4S2rTSJg8DhePg6XXmVg7jSfVn/hkzayBzpZiazs6tclzAlzXf
 j/lupYLqxWWOpn/IPDCNVffItovdszCgbic368Q8voWTRhlX5wOWxqWbafKNx4P0KWbUrc5E6wG
 uVJ1x9GjBmE37iqY4NjeDFTnu/m47A==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911dcf1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vuKYHiuAbYjNwaP7v-kA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Df2bMq_GCpir6_LwthaMhAq_yzdvfpMt
X-Proofpoint-GUID: Df2bMq_GCpir6_LwthaMhAq_yzdvfpMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100110

On Mon, Nov 10, 2025 at 11:27:09AM +0530, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The 3.3V supply for the module is assumed to come directly from the

Why do you need to assume anything?

> main board supply, which is 12V. To model this in the device tree, we
> add a fixed 12V regulator node as the DC-IN source and connect it to
> the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)

Why do you cc stable for this patch?

-- 
With best wishes
Dmitry

