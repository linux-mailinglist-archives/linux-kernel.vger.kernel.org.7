Return-Path: <linux-kernel+bounces-859671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4448BEE3E7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528D6400D77
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F90223323;
	Sun, 19 Oct 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gs/FRwS4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F273C0C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874716; cv=none; b=Zw8WBtr/RGwZwOcNq4xIT1x1sCPDkBn+uckaZohA8kv1+rCtYkVfJzndFzKfZyuUiavNKd56p1j4ByLrZ1a5HgiPNwjygLPeTvnqkOwxBw1jhz9UWL46ZaFWCKFa3N5Z9CUg0Odjtj5S0Q93+3cRhyh9rLhW6CxqcCBUB+q0SpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874716; c=relaxed/simple;
	bh=ry+WX3yC0owyIWEzTcrXyxVXHHZBHn+c2IrTj2m+4bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzOTyB37tSD7c+UAAp+/kTXS4JF1kIUGUs030lVxmIdzXedlLGufeAM0BKEgyGHwv1fPXGv3s9KrObyxsSYqZeqTiVmmnPsYog6Ra9xEkEFJapc7S4d5e+voaXZOzCX1mXM7bXFwXT4sqtdAU0zVQVDDZw86InkMW6MW7nX+1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gs/FRwS4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAutDj029628
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DW63Gb0AaVNjKV2fenN7I7eG
	eM0Cics4vF6SLpFHkdo=; b=Gs/FRwS4VExQ6YK3mlQJsrgN/jiwk+C8X5001BMT
	FEGzM4a6o7CClgc3KUsIYiYkwIKD3cO0fp93im300h8hJzSEMXSAEdudq57HTh3q
	CXmS70KxCSj5avqx3w3UrX7BPAQZ0dZHVhZy0wcyFDmg/Fra8oaIkOa8Zwhs3k8g
	0tsa5GPHh/eZ/IPsMChYXK+enG1tYJdDynn4tZteAV+V9rhcibQIAwDNeEMEzFj3
	PXDfOuUNnN2fk6uldDV764MS1R+05gKQR0GsaHJNV7Aiv6kodo5o9IIG41DIgpZo
	uqwO8m+uuqGPK2JiHk/hbnj5IEmLEd/BaIAf8nWPSvWINw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv2973-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-797ab35807eso158336926d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760874713; x=1761479513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW63Gb0AaVNjKV2fenN7I7eGeM0Cics4vF6SLpFHkdo=;
        b=YbiE5E/83zcpsmH7kOWFfH6MOi3phvbIc/FvqakiA2IbeGuplMve+o7yG2tfF9a8Vs
         1BawiAF9VxFh3AsgXlOPUC21U5Pi1iHh+Xx6Y8XxI+Ukq4GT5oFqkZv2YDQGHX+3Dozp
         2G2XYD/EhpdUuesWtLGBSHknsc+SOM5x63Bmwi+P1jeKWiNxI5kzh8zaQWjuI2M6Hlq1
         q5VJPEaJduB8Xg6N92gq83xV1wayrZ5XDhgfV69Uu/Y7bZfc95PFsXmElNq9OQWbiXyV
         Z6FchnQFqul3cKDS+SXApb3IPLqjAqJec3pWzL22lrSMa05sGGsUv54IZ3JE1o8ZapNy
         20aw==
X-Forwarded-Encrypted: i=1; AJvYcCUKhD4UK67FOxSENaRpSLRDkI2zIIlj3TrXyDDTRVPb3/vykNYSupNp+H3f6oXTxPou5pdxDA5KJqt2FCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JpzO6HnLyy3PW9+bTDIVn2CoB6xvYdiDuSLk45Lja80BGLXk
	IBSAAjs7nvAsJxFNsnBNgP6Zshh6iQzmxg5Z+vst15TKgW/sj02JZwdxm17xJtI69LSBulWgfSW
	FGKNTxv59EimejZU9OOj7BBavYpFjAYZiLHbDSaqmQyuZNdc/mWBASOkbJNOq7C/KgCw=
X-Gm-Gg: ASbGncs7HpVtO9IUOlezppEEpcj09pE0/fHX2AqarBRg45q2KaQ7p7lnLgoXSlNIrxb
	iRo1ETlmm7IaA4DgZquznVwSac1KQUgZN284zyP9I4vFt4rtXpD3GENHYLwUeMQrfTgHHgFLNyC
	KMU5gsLehnS1W/vEWnWel/w7SZ1yu5HW+Gno7mrEaDFnq5sBPA5aGNPMoiDVNCpEnR1UYS749tY
	iTyGbftVYoKuuQburUJh52Cil6it1ZmXf/WdHf5XvN+pmY0XTA2dvw0m/yIkdWcRkJ/YFdEwIIM
	cmb4vOWBuj64fm5e/FsgawBn5VzYmB2VgpPjMyaQAoeuKPXYMT9CCbyo4lS/Scua9ubdYdJ+9Ux
	B4i3Al42JkcCWxFYkKnqzJVEsbSz/m73qt0s/NGtgyRvvfuILErFDeM6qWgy9G6To3XadMiasd5
	69mRpbFsdMIT8=
X-Received: by 2002:ac8:5fd0:0:b0:4e8:86ea:9ef5 with SMTP id d75a77b69052e-4e89d1dd2f1mr135423071cf.12.1760874712711;
        Sun, 19 Oct 2025 04:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9OTh4P0uR8SGsBoD2yOpga5vZZ8wKCSK90rD7QDV38t+bgMjYEa6KQh3dtpBpiUYKaycXzQ==
X-Received: by 2002:ac8:5fd0:0:b0:4e8:86ea:9ef5 with SMTP id d75a77b69052e-4e89d1dd2f1mr135422801cf.12.1760874712235;
        Sun, 19 Oct 2025 04:51:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a966178dsm12696881fa.49.2025.10.19.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 04:51:50 -0700 (PDT)
Date: Sun, 19 Oct 2025 14:51:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for Pixel 3 and Pixel
 3 XL
Message-ID: <3jd4k6sltkmo62taxbqyyuqr6xlivzpwpxcvfv3iynrpyji22g@sxyp3fi4zpmd>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
 <n4xims4y5sssqxkchg2tikc7idkzds5ru7ayidcgxdfx77je2d@qo34qucbebnn>
 <73975160-05db-494c-a7ad-d67422edd69b@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73975160-05db-494c-a7ad-d67422edd69b@ixit.cz>
X-Proofpoint-ORIG-GUID: 2_Ppyql7BESd0FQEpLG8w0ULWKBWyweM
X-Proofpoint-GUID: 2_Ppyql7BESd0FQEpLG8w0ULWKBWyweM
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f4d0d9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=uP862qutgqayS25ywV4A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3dhz2s7Lgmkp
 957tyuSnJ3pumpyCfkbhcvOTofRIl8NN12mvLz8QucW0bXTkqYyTY9r+5IvV2QV2r3i9ukYKf7n
 f9kqsqoagX3ySv/wku2SkdpN2gWoxw5Bs2ffRqf4QlCaCr4XBi8M3viqYL/RnDGPnjMm8qhuISs
 wvC4D/di9Ikrnh3EcgQX/GfP4pmluJdx8zgE3N81uaFybCVpYRZvHAz703hqnbwZizWkMZey6KA
 P7BiQbqMA8YwTmGx8DRfA+ZhaXDDVzqkWcpLCuawqkjICI81LZSvD4BOevUFn9GupJnBYXgbFXV
 19PJP4VPE3wTFGl2OhxTUh6TeSRVhMl5sRSWu3yGFSgcgtxSCc9pnQA6Ngoohc7ma3DJIDf9b45
 Gxvh3zndZzzuC2f4Izbo1X4/M63CUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On Sat, Oct 18, 2025 at 12:23:50AM +0200, David Heidelberg wrote:
> 
> 
> On 06/10/2025 00:03, Dmitry Baryshkov wrote:
> > On Sun, Oct 05, 2025 at 03:16:29PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > +		compatible = "gpio-keys";
> > > +		label = "Volume keys";
> > > +		autorepeat;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&volume_up_gpio>;
> > > +
> > > +		key-vol-up {
> > > +			label = "Volume Up";
> > > +			linux,code = <KEY_VOLUMEUP>;
> > > +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
> > > +			debounce-interval = <15>;
> > > +		};
> > > +	};
> > > +
> > > +	vph_pwr: vph-pwr-regulator {
> > 
> > Nit: BCP is regulator-foo-bar
> 
> Can you clarify, all other device-tree use this format, do you mean
> regulator-pwr-vph?

regulator-vph-pwr


-- 
With best wishes
Dmitry

