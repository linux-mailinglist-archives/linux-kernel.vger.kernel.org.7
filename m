Return-Path: <linux-kernel+bounces-844991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FDFBC33AC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CD43B274E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88E2BD015;
	Wed,  8 Oct 2025 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LO4bZPhY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13722BD001
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894170; cv=none; b=oMlUVNTtDjIZfoNw3XRyDax8ehgsmkT+AflhovOOWhro0RDNKJbCbjqzskamxfQxI1Dn6SEuQ8z/3R/XFjXtTRbXR20gKzcoafuWMNZXkKHl7hRg5exeMaf2oBsfU8NHf9BuDjlQX4f+cE//iIJopbd3u4YH1UN0k3CEXXsrxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894170; c=relaxed/simple;
	bh=PhC/2B+2mSbFA9P1cevxdTv+G9a2xtf0omNJybKc1wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRnCy8oZQDejB8V4xkTJxhVP2+O70JcpY37/cUeHlfaWIVDoP5Y9mI7zgimp4NuufiqxCcy+T3KOlX3hi2hf6l5SMIN/yamy6PKy68moUk+OITKhIxP5VzwpNYKhKuX/L+xy9heICErMlkaFC97eOg7rgO+Wy1jr/XqxykEvNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LO4bZPhY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803XWK028187
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 03:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hb5DjFcBZ/27YR59szZGZtjq
	+9HN8vs9l1pnCZa9knw=; b=LO4bZPhYIUWjzodfMIGxtaOkz6y3sCxainM1BKWI
	R8vql3u8rKdDuIPiFKSuEXYWCFU0Bnm7dhoTsLxl/ZmpnuAjcGOVmA1lC9XeQbfB
	5Gmxhmspv1CdZFAKG1Wv1SX3Iz4ZA75kPBK1YdIDZ1Alx2qO9TSGldVFCJw3/sMa
	avcenaQUTcR+x+bg5SMAeALK7Tiyiq9GGmbOqWzpK9DpjzDYNTF4LLH8bz8EGNKF
	PkLBLshs1NpMff43sgCr7wZfhzU6I/rQxHgk28U+0fhM+MTFeca2N0mj7kc+psK5
	sZSHlyu82qsht+4YRsrAy2DJlzwudzYT5gCLKlw33YxMAA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wksp20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:29:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d77ae03937so188029711cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759894166; x=1760498966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb5DjFcBZ/27YR59szZGZtjq+9HN8vs9l1pnCZa9knw=;
        b=NxKXHTkkZDybMsFYisXLDxvp4wt/cLAJE2BYHeXpMG3kaaVL3ctb1hRVhXS3+Mce5s
         K/5iyCj2q1mKWmcblYthJSGqstB0K7W6RMs1H2S+2AbxjhgcBhyzh2hUIdZfZ/vBIL5T
         OpFvLNE3uBfT9qboGnpTyhdOoWDE3a5OjZgCk9RtgOELBj4NROa70O0sD1icUizUMeKZ
         LfgnZ8gEhpRx4/bX89fVd3OOve+1XmsIYrJL9aZLaKMRsg4erwhB0wgEadR//+2gx51J
         HEcjBW3RpUlezvYhrx+hiDOTu434N3d6ox9EjB0NxlsQyvIS7Occn9we6XHBbuyOOUaW
         7DHg==
X-Forwarded-Encrypted: i=1; AJvYcCWhiZC7SgGwVYUTd47dwf4VYTr4M7vcbMUxtcJA5SQp2MXS5r0M8mjGl6cV/5aZDuqoBfYtz8q7h7xLxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFW13TTmpWpBt14F8dEcBZn7VedXluqfqxQqqO/OdKDsayqFu
	yQQAW16DVD4oVnhP4WzMmZ3mk0MmU35ZecADbnQ1bYHclQoJiAtRaFnmIc5v+zR5GUw/Ww1kfQj
	elSjKnmjexSJbTrSY088HRdiky2FkB7zvyysLZZjExOvY7IV6uM98S5mYeNCMYPBxV5c=
X-Gm-Gg: ASbGncsJcR3PWpkYXd5vqSc/s4kh2N0XZoccCyFUNJuVCW1Wkbj37SuFa96hlBleQIy
	c65LK8SYjTOuUZFP6BswVvezT2T6ZZche5dEyGlOUduWb+Z6Ps4FPAl5G4SLIEuMeaW74AfYpQk
	GjcqykVLOTyyb0KGoBshGLdP9nGczRly5W0Kl/dJ8ZpcQR6X9USOkmhBqH1arJJLiun4AEbALJ5
	aiVnOJlGSUlgkqBMx69CldD55O4WySYnnRe3Ig93PzBfvRKtkB+eFIojtWS+e+o8LAy78ee6Ebx
	TXtBrjZ4u5ATTbbLP1HNFkBzZaU82TZINXPmObIRjl4b4QL1/R7JU4GusCGjhen9Csj/Da0ihQi
	P7GAcWvmLjhJwaqk2Twqy6L1Okg+cbDyzyJFbx83IZkVGbkgIA6XMGvDkHA==
X-Received: by 2002:a05:622a:5a08:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4e6eacdacf4mr25643381cf.15.1759894166666;
        Tue, 07 Oct 2025 20:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ym17qd6d8i8m9rZB6O5niP9nPtV34vtdf+6ORfgYkgZ/ZUEANvQEfhGIf/ybRQkhY43jCw==
X-Received: by 2002:a05:622a:5a08:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4e6eacdacf4mr25643231cf.15.1759894166258;
        Tue, 07 Oct 2025 20:29:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011ab25asm6715686e87.119.2025.10.07.20.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:29:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 06:29:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-asus-z00t: add initial
 device tree
Message-ID: <cphv74xpoaltdlk5qjksmfjmsdk7fvpu6dvpo3bz2wdhtshaai@dxzk7qxro4tx>
References: <20250930132556.266434-1-xerikasxx@gmail.com>
 <20250930132556.266434-3-xerikasxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930132556.266434-3-xerikasxx@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX6yBRgy7EZIJa
 DYgYvP0pjgUaJZgNGhN3WD0gEWRkSdSa/aabRAQorEV4WHiYn7aP3QEyiiD8hkBpxYSbo6cZbbM
 rbkeiMD7DeZE+JheolCBR28PAI9PCufW2Td7AiEQBSTxLod8xPJ/Gpp0Bk1bN30alNbLTyqTdda
 5lGZj2pvkCrnY4F5xngRttZ3JLxOdkdxraiZ+9k/IRfoOFsdauaGRHJyiBSF6khHvuFqEQzKGSB
 sljpRprVHCKhtA7ON0S2w5H9mXTniQMnd9yBCNdlPK+uNWfYq4AE54uqXPHAUK1EBNNawQZIW48
 lFX6crDTrIcmj/OInilfAglEKoIH7OqeDfXHOquO8u54I1+Gy5y92iYrxHkl/AAkkgX54CXplVi
 7Z7gfqC90b/1S+S9Vu6nkK9UAlw0HQ==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e5da98 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rlI1ognr9DFfacYL9GkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Qm-haQ2jUkqdB27IASBFPyOeIu5nu81-
X-Proofpoint-ORIG-GUID: Qm-haQ2jUkqdB27IASBFPyOeIu5nu81-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On Tue, Sep 30, 2025 at 04:20:10PM +0300, Erikas Bitovtas wrote:
> Add an initial device tree for Asus ZenFone 2 Laser/Selfie. This
> includes support for:
> - UART
> - USB
> - Internal storage
> - MicroSD
> - Volume keys
> - Touchscreen: Focaltech FT5306
> - Accelerometer: Invensense MPU6515
> - Magnetometer: Asahi Kasei AK09911
> - Vibrator
> - Audio input and output
> - Modem
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../arm64/boot/dts/qcom/msm8939-asus-z00t.dts | 255 ++++++++++++++++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

