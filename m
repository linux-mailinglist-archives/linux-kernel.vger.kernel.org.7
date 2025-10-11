Return-Path: <linux-kernel+bounces-848930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB4BCED7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F4419E383B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F705733E;
	Sat, 11 Oct 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyTCgO99"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F32BD11
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760144269; cv=none; b=ug4y00sbcyKf9TkMS+74lok1sCGMgNgDmcQHan0/ovONeZMotBnAYC47L60FMwX8rgUb/ZuV4DM+cVqWevkjr3rVwvB/IS+y+Cdg2iNo25O2p0px2OhXWZV9TdhvjR5yCl5r2yqbSnNoY8EW6RGCWhkKMAGRcbaRc0UhyMdKfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760144269; c=relaxed/simple;
	bh=pxFaXm7fX+wzC8Mq9Ld+dRPaRETZ8ZrV2aaybbgn+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhOBTJiZWJFv4q6/jj2lBEiRpet7O8G8zmvBlub29fOR+G4oIVHcHuB3lYHuuOxYNBO2ZIf5Qe58lu5gy4xB/nlrYmO3iGOjmcxocies9INvpkK3yPEXkL/Zb3TYZgGCQuKUm9LtyNujwP9v/IrSE3PKpDn5NRBcvLkgAyOVdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyTCgO99; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AF3F57001310
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mWTLxy0rZFNooeFnWYPYVJJl
	eFqhFfdheiu+gujWVHI=; b=SyTCgO99UcWmKTORmsNBRWC06clBSybgfnsUNE1w
	exFd4Dc9yuYPgMFpiAUzUPBRU9xpCRh7HCH9OepCESJQDlk6rWIGu80RwtUO6III
	4MS5L7wrWaEQeIerEIm9tQGfb4qt+9PKCYFqR7WEBc3xp2LwH1cDrGchAfv59TNE
	i1vFF9jax+p9b7GI1IR58Yovi/veSAd7KqTZfcl9ScOtb31Z7nbHCh5LX87mvu2a
	LWFM/zO/1nbg1s4AeRLy5VKNQy6SCeExaQhHQfK3hJQrbrxpIzJrvfh7naJVeDoA
	NiYG0QE0dIHuERfeqsvkVXpTBQglNxj4Qs0SUCFsJiNEtQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u81xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:57:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-854bec86266so199297185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760144265; x=1760749065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWTLxy0rZFNooeFnWYPYVJJleFqhFfdheiu+gujWVHI=;
        b=i1DptbEAm2NrPyQ8ahxoKcLuMY7AkF6ueLxYcB10dd7s96OEgS9JkWo67y+2xanP54
         U6AQHZijzqKxQlIkoGCIRTVSxbIKzC9ll2vjTBwjwFh3CUy0lKMjGJIuYlAz85vLkaa4
         rp5BlO5Y4O9BsOKti0a0wD4MEKg7gUE1GG35CZASd6AOd2HEOuYoHKYApt0/7P1+K1j4
         K96SRSZuI2S0GO5NiOveCZf/GAJdloHGONnSnY/tfIHOUHNfZGk87JfKhkImb7HSMqmI
         hMF85mpEWTaEWvcW+l2Byaxzpsf5kAfcdkRX8SkghyW9U6nzpiILTeWXpsoSVsaHwCGy
         l6xw==
X-Forwarded-Encrypted: i=1; AJvYcCWYVuwppNAUT2G42yzuoJWmvvt04JhPD4bLZwsgTOSNs57zawSUf3EccKUHF+PgAhReen2WURSaCUgm9PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvim373ptZcS2y5r3TsGeaKxe7lT2Y4xgriLcWUuZ5rzZWmC1l
	SFNF6gKLqshekl0LKEuawrFYMas1Z3C+2FTLiQyYw6kq7Xw1Ld7vg4r+GvQLrI4fBBW/aw+Clna
	G+SNTn3kcc0gPpcVutuZXfQ4xT/pm+irnmLRYMI1EegfuqFA4m0p1D9d/t1v/69udEVY=
X-Gm-Gg: ASbGnctIF5he/33kJtmDKwLj7S0w4qzNrRZPuwib7M6GRln5xwSpMo6wlxS32Xy+J+o
	7jMoE/gmnrwkSayWCNII7ldOLT0oTb+OE9MkB/huXTRStv0COc5DpyQqLrI3e9ALZlgEeEPnmjE
	i59/WlcXEaiKm1IP6PAVS1qjgcdE3Clkh39heIrhj+z9awnBXGOV7towMb6G7DQRy2nLze9Fm2g
	zYQ8o35AqL5C9go4rTukfipgiXIWVKIQW1jXhZ3Hux5rTPlkAG3RXomL/qcxwabJws7IzLafpRW
	GH1UVvHr6uZ7M060z0bKj9PUan8YKqDG4bb5V1uW/EQVnleS0gcM9/CHy46WV0eduQ3PK8hM02G
	1egfpmyY3WrjwEIj0ycoSoCBCmVyD7P7Nhv4nG4t1W5T3diDZ+P54
X-Received: by 2002:a05:620a:25cf:b0:82e:ef43:38f0 with SMTP id af79cd13be357-8834d1ab25cmr2021060985a.0.1760144265270;
        Fri, 10 Oct 2025 17:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH2AkLb+Y8ALOWCBoiUPOowjxA2rC55/UwYTCJSaItp6wUkqo4jUyP2qewXENxC1OockLplA==
X-Received: by 2002:a05:620a:25cf:b0:82e:ef43:38f0 with SMTP id af79cd13be357-8834d1ab25cmr2021057985a.0.1760144264730;
        Fri, 10 Oct 2025 17:57:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908820d275sm1366228e87.56.2025.10.10.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 17:57:42 -0700 (PDT)
Date: Sat, 11 Oct 2025 03:57:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Move CPU idle states to
 their respective PSCI PDs
Message-ID: <wpi7j6vwvpicehri6ftiuz4nk3ufxcgleauqqo4riy4boyizke@gybcggph5qsu>
References: <20251010-topic-x1e_dt_idle-v1-1-b1c8d558e635@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-topic-x1e_dt_idle-v1-1-b1c8d558e635@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e9ab8a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=RGr88_cnInlAke65EiQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: w8yMmLO_FHvpS5KeIY9FdWkO345a15wN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+JGI8sAw/C0V
 f/ddoNTZRqdbtDx+7p6rPAF7EyLPfu3XzFQVkWbXzusMZYnkmGpfLuVG90lQw8crtcXtm6FujkX
 HOtwEidz2S+O/YoVAqH475x2pM4UQBf2BQUDah7gzLfX+G+a0bnUv0iZK1J/Oyo/BNBMsZ01tkb
 19dhp6Z8MX4ifMCY7lbNowDcATZcDk7SE+hIfxKJIB98SLzPv2NiLFbMElg1dL9nluSr/SuDLXP
 p0eNQNEoMGYlCNh9HGTxoyRUYw9W2hK7faoIy92ea+jr7DJAfalMN7FenWuLjo83HAcwotgurlp
 uWYdaMfpr26eSleDRrHAwbc/WIVGEZ8Vil8U5aVCVO9mehb0UCaSnbW7FBBsK8eaEq6g+RJj1Ea
 aGNCSzFh5VIPRTvQHnmRH/2DnUik4A==
X-Proofpoint-ORIG-GUID: w8yMmLO_FHvpS5KeIY9FdWkO345a15wN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Oct 10, 2025 at 10:02:18PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> To make things uniform with other Qualcomm platforms, move the CPU idle
> states under their PSCI power domains. No functional change.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Sorry if you received this twice, I pressed enter too fast before
> fixing the subject and cancelled it at some point in the send-email
> flow
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

