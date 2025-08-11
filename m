Return-Path: <linux-kernel+bounces-762356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA76B20565
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A05C16224A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD72248BE;
	Mon, 11 Aug 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IA02Yh3N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEC19E97A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908348; cv=none; b=co0lrDjnfIykBjD5xJFSpvDkqPFUp5ZKwFeCzkZrWQNS084oXGM+z0KVeZaGzC6SkRdEaCrh0+bEfcFWTgJQUMjjdBDF1hNfYTaeah0ieZ0ziFJTChKKofSaD1+CToITERvBY0Zo1uzEfQvP8G9p6Zl6aao8kIGn8iwlHvgyi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908348; c=relaxed/simple;
	bh=7/8dM/Xx2So3McTrDBstGgyw4FvAIG3Efd5JypBSmKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgDC5m85fLXisH43WbFLperuhZYbmQnS6fyllGMYdCIze7ze71wwNR4K9FAVkhdthb3PM7OGhvvP2/cSsC6a7/1/DBUDW0uCnKr9v5GG8/S7e0i9nt+wc5tUZt7dYVAzo0liu+9H/pbAyLNU1X17LrtKuXGo92n0ZU1UInWpAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IA02Yh3N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKuh018311
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WlaZxjCGfsTi93SkuSR2T8Yq
	07Bi9pE1AjxRp5EAaPI=; b=IA02Yh3NboUJA0n3jJF6ku+QfGN0XT8g2rXZFYHy
	VCmVeGkQGdA0BITjpCxL1edsddPuQe5QTWsNLXvBQw7tad1h0hBtKRwE93PqghzA
	dhJUCdZsCZXqwj3zwbGr0g8/Ds1hKLCdjOBQNnflluOO1h+t34NmbXZzwwCXD43M
	ppy8wv9uyj/xeD8I+mcF4GXFvhh0zHrppeje6qljyf9RqJvDO/7dPwZ8/7NHxE05
	XzYTP7uYT5c00PkSBMt0AnQmxCVD6AHOAUDo+hRzv1lgQgsvArT4p6OmXhIEsaI/
	79LVIGNGDTTW64bNBp7uFHK8IBLz1Qw6dvDKJ3CXsKsEcA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g401d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:32:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08b271095so116906991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908345; x=1755513145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlaZxjCGfsTi93SkuSR2T8Yq07Bi9pE1AjxRp5EAaPI=;
        b=Y64CsWi4JdZkWwcL+y/vuXHM4lcs6RtEVEvbLMxFqMixioONjKBEPtH4u12RK2tq2q
         N/mfMFNjJacYiQemO9DaYnaO1RGmX0RKKq2PlgpL12bwaekU0Us7Rccc4kBljhV2gQtc
         mUEhcXhj9SyVcxkcELvnRvzdW6EpCbksthNNE5y8IUuoqWQ3nBbj4B0v6Xohuh4OJ1Nd
         +2rw9RMBYvppMfWD4ZZNBP0j6++AnX8SWaER5CrQaDUsysBHqf5xAHnyerGxJC3bPW60
         BVgaVQQl4Q5Wn+GoPp5D80BTEBxVwa8mhlFgqs5SZ5aMeq/JCfA1p3HtE0B0BuViVYdQ
         vhHg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4npfruQem13soJqhOB44bUdx3WaSYvN7rY4u+K5eHX1YNHRRaG9fE9SMwH/8YKPHfyoSJmG2fX5Wtvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzg5LqyB29k1dNZ95ZTVjlmzEehd+U+cq7eXoeW42a9dgwhK3
	htyMRIbNJy6ExSTfKtDSSF74LlOP3Q0RKurrUnfbLOpIodCR+ZYvgve7hcNY07zp4BsrIVTNoLZ
	w+Zj7YWXolGB0RIeWrPbH8PeHuISuhosgJl8rdw8IYaO8gQoSUvqGsjEzz43eFgSVZsY=
X-Gm-Gg: ASbGncsOo5MVotm9FQn3qh8ozOD+Zg0ZvFznbDAz6g7D2X0Xrqc2+0eIpTdQMVua+Yq
	vMh75e5XoeRp9fMGF3ZEC6D0AAa/t6CyIX1IX5lV2tB3+XoP7XiHknKE0uuj+CygvaLBeBSxnzU
	N1YFzx0X8OjXmlBCqFVMh4462xj0Vo1Q/A7B8f+id5R8FbJ2E79lNDnDjVN4EE+paTGCAPoEIyu
	RIIardzBSPVnkdxra6LyYWYa3hkqd2WK1L8joKtjTZmIVUD3cMWRnR+d+oeBpgRneJF3/be+yno
	aUIvY/ZcBId+9M5S4Xvx5E3LtXWrAY6FxTPsmfpN4K45glxjS9Dl/uJ4EPXhZBQ/LKqaW+0xP6H
	wwT4SoHWlfAAi9jlwPDvyCGcupTe1nBI4sQPvV5oWfYheTvDPQaMN
X-Received: by 2002:ac8:5850:0:b0:4b0:8633:f961 with SMTP id d75a77b69052e-4b0aebe7865mr200416321cf.0.1754908345033;
        Mon, 11 Aug 2025 03:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8sa5r1o7gt5+wFXRCE2Q7Do41HTXVXbxsWRBmDIwxhwtGo1QPiM9a8ztAkxfkOqvDVAq1A==
X-Received: by 2002:ac8:5850:0:b0:4b0:8633:f961 with SMTP id d75a77b69052e-4b0aebe7865mr200415961cf.0.1754908344591;
        Mon, 11 Aug 2025 03:32:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c158sm4264371e87.14.2025.08.11.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:32:23 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:32:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] drm/msm/dsi/phy: convert from clk round_rate() to
 determine_rate()
Message-ID: <oukh4eoh3kwyzqo5shujprxsizssbs2gckaa3fr54tqu5qmqkc@6nbvqf4rc5av>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <d00689fb-8074-48df-ae95-bcdf5e756111@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00689fb-8074-48df-ae95-bcdf5e756111@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c6ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9wg58hZYqdY_vEwv324A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX2Xmka9XmNXFc
 j0EW0vULM+T4unXdzFzqSZRCyGzSv3qM5OKRnJwJ5Y5V7T0tCpNOx0rfhORiFqSYosCtTn1/PKq
 ga7ZA664ykG/TNydE3iPGzowdSjbEtjOvkGiPePf4xXTjjOANyQCyx4JMpU9jT6bsnF29BLw/BP
 Onk2U9X7ySgJRuW97IvaWS7ei5XzBp8E6yUnqvnmkiajPs8apOozf9ZLmQOkKrpPU3n2lA7HfNS
 sYypk29cClvO+ka/OrVdW+4wacfclZ/N3oD38XPfODRy/+gkepE6dLYAB34Epy8onHIrMd6NSVO
 gBDwPEnzuSRCK6RVcnuSx16VMHmHRaK5aYMPgnN/vAGJOPLi/vwU87ZLLfFqMVJM4Vck1IxgpHu
 iHzQmXLX
X-Proofpoint-GUID: eB-73iLWZOnfTMLCACfjCQbthp_Pyaxs
X-Proofpoint-ORIG-GUID: eB-73iLWZOnfTMLCACfjCQbthp_Pyaxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Mon, Aug 11, 2025 at 11:02:46AM +0200, Konrad Dybcio wrote:
> On 8/11/25 12:57 AM, Brian Masney wrote:
> > The round_rate() clk ops is deprecated in the clk framework in favor
> > of the determine_rate() clk ops, so let's go ahead and convert the
> > drivers in the drm/msm/dsi/phy subsystem using the Coccinelle semantic
> > patch posted below. I did a few minor cosmetic cleanups of the code in a
> > few cases.
> 
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Unfortunately pw-fdo doesn't track series replies. Could you please r-b
patches individually (sorry for the troubles).

-- 
With best wishes
Dmitry

