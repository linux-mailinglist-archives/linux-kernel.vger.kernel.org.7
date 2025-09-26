Return-Path: <linux-kernel+bounces-834124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37ABA3EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9233281BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F81991C9;
	Fri, 26 Sep 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUJaz2/G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E77195811
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894422; cv=none; b=iTv7+d3D7jvQavGm8T45ggHi/YlpCMsyaGUuaG0JAY3Snzk8XUe2ix2eblzDbZtRFXDHfyTNEMm1mkf/KYKZ8FSR+jsDuy8RBwU7qlZyYDJ0P3rHlkEGgNQ9139o4mjUC0DoHSlbAV1x+T7BVQB6m9tk15LigWNwZ9nNoZN1pAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894422; c=relaxed/simple;
	bh=aBFFYUPfC1VbKQE1JBC50s2T3I1/bqs0tYQQd5BNEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yiq3iADt0EyZYy2oLHQ9F+Dsl/K1qi7gNsPFAqB+icn9BRdz/MnRJOWPtUPIFkt2jP6sfDP9HR4+FY1jbdPOLn9iuznHODX5FOjHtFdyDrYLDzKfzS1T2x7zN0vyIAr8OS/8ItRpoVLfWtSXU0krVVQDgUSgY4r554ixSaht39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUJaz2/G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vZx7002621
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fBPPqyIhYVrf4TXpIWvVvJCP
	+mPfq0dKR0wYVfEnFfI=; b=DUJaz2/GwPsGNd2speBWtjpXKQs578FAI0Vmt1GC
	9F4BiV0kpIvpRdbxDIAybUeIVvyYjZ2o3pcCmMwVE93wg917o6DrBMtzj6S+C97z
	s0V064dvfr/FAWjflKKSoAN0iDaKXmzkaSj/lTL/hDopIywRcWpTeVLR9eYvQaY8
	CgNm9SGvvTmiLIWS3oGQt86phUNcPjze03vUh4iH9acxAXE1iQIZXXYaDPwH3X3x
	RaO1Yt3t5W90SJT1NNMUL9Cv8kS/RDX0i/jv4w88TWwSt+5sH2OJkc3yuX0GofqB
	SNEtwllVljkHy52ll9zg3YRaiK2qYcs9Cww7aNn4Ucos8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u30xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:46:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de53348322so14893861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894418; x=1759499218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBPPqyIhYVrf4TXpIWvVvJCP+mPfq0dKR0wYVfEnFfI=;
        b=vxdAI8H3yeXZ/cYbCTyXEsArqWQOWi8wF2rNa9vUlEYDJqOCujw3MEpYOAxmucacyq
         knooJktcZ/kdHIjwMBnhkmCbvPYnmCjAc707lk0L66QZKbuiG3Jym5BxwVIe8+VyZ8Zv
         Y7tWZxv8d5JcL4ezKHUXdP74a9blEfuLqQAStqn0d9eBWRYY+mgelVt0Ssoppu+ClleY
         oSSDzWxBaJwamB7S/gFutYYf0zOCHWG7I4p9AC4XYqJwazr1QYR/3HdxowTR7JEk4eVG
         t2dT7KqRRk1IWL85cZ39ZUPgdCAIG49yb3ouVXm8AoyiEQykyuOidWAVM/cI1fGTPMVH
         xN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXnfUeTYst41nWOqS/wAXDOsKD6uCB3KLFO11MEuxqvCI2LoTXft365h0xYjhhDqR758Q2CkiVmNY1Q/wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeY8UPGVzn23piGQtU+1o+WIsuVleZc2UI7mfYjYKZI70ogMv/
	3Gml2nAfyk8hRW1KMUuHP95iH+DbzsF6it03MirI5rqisv2p7hncoOZV8WYWj/bU0xP0KqGnr9S
	Z1gECpeOI2NCsqCLdwEc3Z3COBQ/Rqm8juJ2gOe/077pH1UIOCmWS0EIuCPlSMR0XBfBSLbaf6A
	4=
X-Gm-Gg: ASbGncs8700kgS9sPFF9Sj2XDCaWQ7/Atny7AkoIjWGjxccMeOJ7zRnNCEWwA/4VXp9
	Kc1egwCZymIPXDkkiu2jQ8sWDf+t1BzGtJ0+Jaf+4I4GWbyRoxSAQP1+7D7VDAebDiwSI86W1cT
	yelPrnzn567ZuTwLg1ai/i/LnkwFURp1fU71SSYmg1+N3uKOaZntufB0cWa+/Q0IfhUH95o9BNz
	N+465WMZI8S4ZiYcRwXDnhMXIyg/FTi8G3hE8eU3s98v+/vEJDIGbXlzMOcGCyMksfGqO9o2+mV
	QKEKS9VJBtqesH3ETcv/v6M6HT00hhFeHqtxBcazrBUPEWDwrtQ7D8GcC1Hvb4V01jfSDvq9Uxk
	BDqHpzIsHsDUZR+4Z/PqN2hPx6X12ihmLygWVTofp3AB6RJJ89JDz
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr107536971cf.54.1758894418329;
        Fri, 26 Sep 2025 06:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgMHv4hlXwVECvlZwSLsQCs3yZNz5dZYBkviU6fW7qoQdMWI+9oVr9Ah5YxWdPj6tHgyDbsA==
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr107536111cf.54.1758894417530;
        Fri, 26 Sep 2025 06:46:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656453sm1831278e87.92.2025.09.26.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:46:56 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:46:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
Message-ID: <vftateior3shdrifao5ueh2pyjbuqbwb3sw3gywzghyhwkplfs@7tzocm576bin>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
 <60c65d7c-1564-40a1-830b-1c9931776fb7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c65d7c-1564-40a1-830b-1c9931776fb7@oss.qualcomm.com>
X-Proofpoint-GUID: psEiH0mZzD4P4I8hJLkZz0iVjHpC6rqh
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d69953 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KfCWjoryZpLtWRJACwUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX5IEdRxlYu7Tl
 5V0NRAAaAshFTjhH7PjMkDdlV7WQp3v1Xjl8E20ZMrTjg8ouF//JiiegQ8wtpi7YjDHmqH4iWc7
 s7mApFqMYIsaf90494Q8Zf041U0VMoYvSokT2UGZJdTJszL7ByXRp7YLzfgRk0yD8exm+6E5UX4
 JSvUCzt7z0ksp77gozWxGcwCGPuKYHvSXhtAE6yt3gB0tE62lqzgdmaBWMZhh/2beXmk9hWg7kx
 Tk45ruquZ24oSFom9oGiWXzjtxbNupMVsbADjKZ6o6PApsZVSlflChIDmFA3LsSUTXI5tLCVkgM
 abnJDVFtEvBDf2/SZ/hOzJ+2Kf2RrBClJnOcjt+/CELYMyxe91gas+g9qZKy0vL7K1B6JGvXnAD
 ihCDvJLnFhD+mk9uj3EoczldVU0zlw==
X-Proofpoint-ORIG-GUID: psEiH0mZzD4P4I8hJLkZz0iVjHpC6rqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 02:11:16AM -0700, Ronak Raheja wrote:
> 
> On 9/24/2025 7:09 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 05:17:31PM -0700, Jingyi Wang wrote:
> >> Enable more features on Kaanapali MTP boards including PMIC peripherals,
> >> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
> >>
> >> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
> >> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
> >> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> 
> [...]
> 
> >> +&usb_1 {
> >> +	dr_mode = "peripheral";
> > 
> > Is it really peripheral-only?
> > 
> 
> For this initial submission, we haven't yet defined the USB role detection
> infrastructure, so it didn't make sense to include dual-role now. The
> controller supports it, but without the connector bindings and role switch
> implementation, it would be non-functional.

It would be nice to explain this in the commit message.

> 
> Thanks,
> Ronak

-- 
With best wishes
Dmitry

