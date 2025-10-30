Return-Path: <linux-kernel+bounces-878917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F7FC21C30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF61C4ED3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4FB304BA4;
	Thu, 30 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+q//aIJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4iAQRN9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB51E1DE7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848676; cv=none; b=sdMUGzLiWfsbr2WAI5G27K60r5vpJEhDZKcI8y5dWBC2PztPAPH1EGQnulqMlJceIilk/eiwK4/e2a5ivmiF/XpuY3XfrAlng7cqb+jvjsCy4E0lP8+pOpivaGIPiyTBzaaqu618LpkiriTgkwJoEtgu9OzNIKTiudy9Fhe/VAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848676; c=relaxed/simple;
	bh=n5LDDnU31B/FU4hkVylg5WKwzdJmETUQKTTzRhOKfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0jXYFbxdxYWtTsvPVoCy4o2JVCzsmgTVI9LKPmJC/jn2XBLSj1gklaqItoOyLtKUb9XmO6Bdzd6AoXICmnHfBCYSHQ19Hn3duKsy+ni0n3VzCeyLpESEfqEgsVG/9qGhrFsQVe5JD1ukXFlgR6+zEwrwp3OVwpbMVtsPv9YHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+q//aIJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4iAQRN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UAPKhn3281432
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=syXUOD6JoN9BeOT8Ps+v7SB2
	QPgUbs++JkB3a+FX+aI=; b=X+q//aIJYPavTm/MJPOaMRJnxV388UO7RYFQCWvK
	JjVcniBUwCX1CaGgS8IBovEx11gbOmz+apnTAa5WXHAQAwSWCXlAzcbme/YjQAW6
	ldmw5uxe0LF92pmZmqW4HH+tHa5Ukec5c/eKlquYkm0lEhCAv+Imdg9NeDcUhXjC
	8+AgnFGp1JiUyzEbLgO3Z+BPz0OxBWQKXDHeF4pOUmV2a5m4nPrArDUivC0378+y
	sMji2N2LnUx0aSS7Uv+5VZIRyt2bX70YWQgWl0WDnMQU69HuAon/igIMoHj3pKVa
	8xCzUEcnkL2q+5ohUXhM2N42XFD35qE0ms3YGsdRlCi5Tg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468khbg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:24:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8aafb21d6so32927271cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848673; x=1762453473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syXUOD6JoN9BeOT8Ps+v7SB2QPgUbs++JkB3a+FX+aI=;
        b=L4iAQRN9DXO1eznCaNfMRvre8dvaRlLK3GJ4JyZUqDqGpSJppHYbmSFXSFME3TgLQ3
         o3C1NO/25Wn/YyV5aJA3YSu6H9S39wsDyJ/EFqMfufCrEGL7O+o68wihPJxOr7pLY5Ue
         9BnPpBM4zJ50ngNNk6QVL8dhcFgY8Q9CJ5KKCCRXqQ8sfWFwFxGHsfzsgzWbcfaJHXiz
         u4wBXDKp71mrGr17r5NrxZ8ATjlLOfpd+AGMIHvo0+ZhaNVDFcyu/PtdyJn9c99JoGF/
         0hoLOdiSyIdnODgihyK2PKNXOm/54/s1+OyS9/aGc4e7SFkwDP+2uKvHBM8O4VvxZOSM
         INqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848673; x=1762453473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syXUOD6JoN9BeOT8Ps+v7SB2QPgUbs++JkB3a+FX+aI=;
        b=Ao0vfn3XP/sGxf7NmrMAiJP62a5qHyUERFpHmdVZDr1/2nh6dKvd0LVYVm1KMJVvIH
         2+7Ugfe5PoNm3mkG8SjUIPF28d0JvXiXEBXW/qH5IVNw75tt5r8RSWW+xcLaeS7M+3Ix
         ufHohkiC76V5Swm8mgo0ikqZ3moiutQQ76I19aoue5nTZyKygngEafFBbHtgWpIQnFcv
         U5FaVbJeM/26O0cwOLLUSQkue9kOyghpd6ksb/vg+VJUvX3mEriLVOCaGECvB3tUol/J
         dWXsZHLP1HhYXQLCkGLUtA8UFUajBr3joZ/o1jbRYBcFSx78V1bzIEYZ4poS+AyLBWfi
         1Trg==
X-Forwarded-Encrypted: i=1; AJvYcCV50B/6kZ5eFpAMF40Q4NJhhthVKXMRHPP5/1SYLNDARPwv/5AP5x9RgxH7wAabmP16Zmh39ozIIZhvlgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw76eHq1hj8bcGOaewBwKf1zYkfKBxoit1ymZhbNQz+4sgLM6W
	jLxnxn8WaEBkipALJ9WgXL++rFDyLmBLy9F93dLZ5kz1QY9fFQr08bA/+pdLp2MWCAsv2eeunPB
	ldvey+OfxjbnWBE74hJL/69O2iUbwSFRFYwqLMek6PY65UeXUJk0spNAvpulo5PAFbag=
X-Gm-Gg: ASbGncuhvkK21jMivAdZ/mKCsWyOg5UjpLFXU0Y+xV+ZTKi0IfAHkQEpiqOh1PYo/oQ
	lPiWoBGOo6+BiQ2f4+w4ktxB/iisz6uMjuprX3MwKr/A9AEpZIj5z9H6mRpYgx+LfbMNOzIEm8x
	HhHl1ZLNMJFlfqbpsOWpGddsuCKVyJ2uFBuMkgpnhkOHb9jZaM7ZBKZcDhoJNfQ6Sci3VPacVQT
	ElufrsepLXjD5nlEJbMJb0AsgWfpa6f9VaRr5y8Vx6vnGq7Dcbv8r+PE6n+2n2hxDGgw1/8fpkt
	XqckT5LVCu+7zHl7mxwD8FaOd8+GilON5/CftrS+4pJQIUYbcEMefnyX310r2uOWE5yVcnr7+kF
	OjS5rdiKoQ1m7YDsliYyCefdL2c7nRg5MB/90ZqTaAu4BSx0Eb20fCa+W6Lc+hy7tJuDP53YANj
	xTqGkOvE5jRLHN
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr7501851cf.45.1761848673033;
        Thu, 30 Oct 2025 11:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmXHfCUfcD2P7/jhUfHS2Z3Z/sOp48KQ53I4Yb9fWNOd7sgUr+yJyHxsPDN81BBTCGrNVwpQ==
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr7501491cf.45.1761848672452;
        Thu, 30 Oct 2025 11:24:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f87f14sm4837077e87.112.2025.10.30.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:24:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:24:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Message-ID: <hlj6cyeybsct4flwvm22t4u5coeyrlwcwfol2cuzab2fjkluwi@frs6m2sjyksp>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
 <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MyBTYWx0ZWRfXyGIKPBWpIBXM
 9xe9PEU43CyCv5vn/1CsCzQCDUnkr8+l6bt3AymZqH/fN0ta+Ja2cn8HFbl/iMCzezQwv5R3SbF
 w1F3Q2WF6egj2n4DcXuA471QB+VrDojx2XrAlrYQlEX6swJnzgDZyRd6pZDLCKl1UarTdIB3YrF
 GBcs3zN7fZfCvBby/ny4anPVZWx+n2Xl+h93SPvNn1MVK9OauXzoWDmhoxX+2/Ci9BECwbwWKxA
 FjJyzV5P8GQWSMGpURap8Q4wm2iaf1IivXkAsRg/AXN3HMcCVUXhd6C/N7uMamYshi14VDVA5nQ
 cqWzSq7oHG70m/4uCzK7KuTG7e5YU3x+mNr8fLs8282CUqTXdk5uC8GORsWwMjnJpwnqYlRlfoV
 SEoojmTsk0X4qatiy/NgnwTwqbUJVw==
X-Proofpoint-ORIG-GUID: ofTppYW1ZjBKwV4qOHr8dfIdBUnbxcln
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=6903ad61 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=nBxtwQxsS3NGOZXr17YA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ofTppYW1ZjBKwV4qOHr8dfIdBUnbxcln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300153

On Mon, Oct 06, 2025 at 11:30:52AM +0200, Konrad Dybcio wrote:
> On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> > Add the missing interconnects to the USB2 host. The Fixes tag points to
> > the commit which broke probing of the USB host on that platform.
> > 
> > Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > ---
> > Note: without the previous patch applying this one can result in the
> > kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> > applying them through the same tree in order to make sure that the tree
> > is not broken (or using an immutable tag for the icc commit).
> > ---
> 
> There seems to be syntax for this, at least for stable patches
> (which we should probably either use or add +noautosel):
> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>     xCxc: <stable@vger.kernel.org> # 3.3.x
>     xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>
> 
> (deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
> b4 workflow)

Bjorn, Georgi, Konrad, how should we proceed with this series?

-- 
With best wishes
Dmitry

