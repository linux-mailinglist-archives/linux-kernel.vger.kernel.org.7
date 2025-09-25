Return-Path: <linux-kernel+bounces-831639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6EB9D345
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5431E7A3A13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A72E172E;
	Thu, 25 Sep 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UaALzCdV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAE1DB12C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767557; cv=none; b=qonHgGjbesS9KSt0Q697zLe1m9zXvsJ7r9fc0i9dyuow8pIhtKtDmU9U3QpOgaMjnf1t5ORA/zRS1Pbc6ZanNw0jYdokzFDzFuRh8OXvEFupzFf0AYPvF9rY8jtJnmYbkSiFXjFNNvugUFkFh5nobw4kzDrKvcV/tXSLw2s4kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767557; c=relaxed/simple;
	bh=2esFbPJwuZNBvuWMWMGHgBr2T2aPcaPBSG9Bo+tbOBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhEzHBu8axtpBHmSOmx2Uff0QI02cU3MZo+o4VquaSg3u00o6oNdswE91yBw9c72q+gCGWBOCeDAYaxLE+95IpIyzmDOs/LmUFF2dJjOuQR2iq7vfvhfZpVkoqCG6Po0sL6YItTf4NFNOhIqL0Gadw4mhG/gvSizIEk8NWgRyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UaALzCdV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1ajAr029565
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WP6034qc9OdpvRUZ+H/itl+v
	tk+A7rdlL3cpQBd8BR8=; b=UaALzCdVvMwadCXCuUupOm0S1BaT2tdFQFTFGMkV
	9RZo1XCqQs2BsOP3INZ01lNXnOXEvVkWCDARxQ7RICiGAg/gVhw9ted+i6vREZ46
	efHVe+eExc8PLhtd5enZR+RBPSFpkcaxcd4vTQrdjLHcl/Mf6Eqc/YHCLp2fKoNl
	wBS0e2kf09AwPDUDhV6oRCC1JGLnWhKmaLc6qzwht3iJe2F0QEsH6ZHuQzUK7eg/
	uHmtG6LTebQs2cm90Xt5JrRKOHCibGgS7ULkUlXiXbcj+njcFkyEtVc7eporB4DH
	cfYNGy+9PeGkAFwtoPI/+AUopZkUuMKjGsKKQ61KoXs7ew==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpbar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:32:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4bf85835856so14764601cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767554; x=1759372354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP6034qc9OdpvRUZ+H/itl+vtk+A7rdlL3cpQBd8BR8=;
        b=VLOHiXWHO4hii/hJKfCOww5oX2zGeahH7gBJ7OgQwn+AHtnKb+uZUuNDRfQxSuG4uE
         UG8gPNFNMtP4OnnUof+mlqomzhc+Sxgk2b557eoZOBqabwRRvEk/Q9pO9XWs6d+oadN5
         LptSyL0tAJXBwPPoUg+a/UYeFySWN5d3KyG6kBz9r/WCIW1exSYVsdRHEr2l4qiNWxw+
         e8mwn1ia08NzwJJ3+4V5bLnC3OsY+MFKbSs9iD46bK1+qSQbZhlOQXEUuSyfmXtaAgT8
         Eb9EWcWNtUptGp2OdZVifznkV58Jnx9qoa44WmISg4yJ8/XnUV+C7VH6XOFai56CLKxO
         FqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkmCdhbicbi6gEnfkI/oZy1X1Enwu9/TOvX6V9wO6BXlT27z6BTFjawQPtjmJpjypoXX+zaPhh7iNqAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnWsbEgx1Jx9XcatSEDWZQDYXHXqfM4nqE6sDgndO1ypbNNWW
	lnA8gKtn9MnEhuoA2AHhIaLgBRNWXK3TUoCOfsRWtS8AcbWydwLJ4mFUTXCO5zxkl1e5Bw6Hv5D
	+EKvS+iCtym2cqvceLajGvEjBUME3lR1uCEvUVB/dKDUcZA705MI9RU+md0c1iZizIjU=
X-Gm-Gg: ASbGncvgugTMobY976kHA5WrUPIBtJnSb/jhTLZWGL9W38tnAQ72oY6aE9bVJVGgUYT
	VCj3w566No+NP01J12EpAxDsJjOu+XM7MZ+9cVlz5p3Fj414sEMnEHfronpcsm1yQf/l29D8vat
	25DGbQYXqomExxLYCIqQd2qwpMERzE+H66uyUk4OFdhNPmEDAZt4+h8aMZMQ1Yth/lVKtscwLEo
	3uyWoJqpz6gWCTLctGjdXxlSykyMIITygS+HULPoa9ckqJlf/3XHaIOCDuPZvEyNVbEV2IArHWr
	gxi/yvGcuvbhjTDwq1d7HNMXyVdU6y1gxjfW8x8sAz1uG2EicDJMCq4EoZFYCgGSVioN1JlVXch
	ibQg3g78eZ8sQE42ocN7Okhi2i6x+Un6w1gMKz4gYgsmMrTfr47iK
X-Received: by 2002:a05:622a:190e:b0:4b7:acab:852b with SMTP id d75a77b69052e-4dacd2444dfmr11870331cf.26.1758767554432;
        Wed, 24 Sep 2025 19:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa2IDBVMPJ9g/d5ctxxzydrjUFXK6difp7z1Bg2KGvP8iuKn8/jevRHGqUMRizyeUvFoawRg==
X-Received: by 2002:a05:622a:190e:b0:4b7:acab:852b with SMTP id d75a77b69052e-4dacd2444dfmr11870031cf.26.1758767553939;
        Wed, 24 Sep 2025 19:32:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583171e50d3sm237438e87.139.2025.09.24.19.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:32:33 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:32:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] regulator: rpmh-regulator: Add RPMH regulator
 support for PMR735D
Message-ID: <7zxx4kcplkfblivww3b2cm57vgkp6tdspmptor45w653xcwjtx@ziyhu7liqnkh>
References: <20250924-knp-regulator-v1-0-d9cde9a98a44@oss.qualcomm.com>
 <20250924-knp-regulator-v1-2-d9cde9a98a44@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-regulator-v1-2-d9cde9a98a44@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Df0qu6ExlwWnGRU2wdjZYYA1J3ETCwNN
X-Proofpoint-GUID: Df0qu6ExlwWnGRU2wdjZYYA1J3ETCwNN
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4a9c3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B0fzD_Jn_k95df8NiIgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX5/HvvNJsu3Rm
 ThUW6yETjggOvb2KXw9vQba4kKBGUaYSti9tOexwxRVP6k3VhBH7pNhYJUeUup1q3t6xCKOtel3
 rEUBcqPnooTtZwmVSr+d4jo4/65ylfR/xfb0li+TlaUt6F0Lk11sGdqYimlRIuvADnx6LwbAya+
 J5wPDMcPOx6d1au8Adg6lmYAuI5R1/TH0HlciD7VgRO/ENLLQz2v1uqcHPlSK1Ta8V3pxNSzrAL
 pdkb+mljHl3+sgcxadtVHYTV5h3GAYy21MJJ77bY5Kd5Fzwqg8dewaO8yBd08OKFwxAf+3jp6bF
 WW7sllDenCgwcbcBtltEPK5snhG+EbsHKOI0vMf7YmNZGuc3cCLtKK9doL4e+T+gCxcqAVzIG7O
 dlJT1aw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 04:30:48PM -0700, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add support for PMR735D PMIC voltage regulators which are present on
> Kaanapali boards.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

