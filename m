Return-Path: <linux-kernel+bounces-841960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6539BB89F4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6843A4E1ED5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0002221F06;
	Sat,  4 Oct 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTL4R9Jf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05819DF4F
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558811; cv=none; b=ViunfrTgx772iruOwNGpdJJCmCuxqCn74CdmKBZPlIQB72iZrSEEtCCnMqFspp1B/gDsB2w8SH5qrD1AYsu8MEntBDO2vDj0bEBGiIXwwV942Gp/G4yaE5zqQ8i7BG4D8+3cXKajgouR/TSsW3zwH+whP02sXVfW5/Km/lHh0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558811; c=relaxed/simple;
	bh=E4TpaqU2JrKdPWSIkXzozlfkEfDOp9hCavV8plMCWXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXemuED2idJGE5FwRVZnJU3IGJDRmTd+iL+ODLhhfo+LDUdlCblc0UpfeA/HMtrNA62Q2qv6wijyXSnTVTYuQfBnCU8C4OZy1dAtDkJAUb0qrnfIy/5AXzhhUgNr3/+QUYcAEu0/5Er0+fdGIghVIOXvgkzvKHGIMx60ChzwUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTL4R9Jf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5942BpqI020705
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 06:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8m4k7jTFBedu+wLB0+uZwOmi
	JaNTVqtHpAOlLIi7cx4=; b=fTL4R9Jf0MrmZ6wcWUb2QoCkcsURGAbXIo6uUyFh
	z0CFCo3eqqzhyF1X+DX6pVXLRBY+VBGg61MzFXs5ocqPfVVdLPhzwuUAP3V8aaf9
	dpJ+PN29CC/zhpg4EaGdVDzCbtc/Dl5/vY2h5PHbLGzxce7lTHpMtjpkQIT/tGNM
	aEZO49h/OwzEgyGnyOjxynMXIpu3xdlCfN9No1vISuY8mz6hNKHnW8C+juPXmxzv
	99c8rVMIrRfBIDT679m5p7VZfOuc3AtvS2maeRkHvmkijY8NBpNwmDKFeZ1ySGmY
	+ShMlp201YvYmIhyC5ZYNa7B917jCdHISuaQJPMSzg3xxw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6rbhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:20:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddc5a484c9so76269681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558807; x=1760163607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m4k7jTFBedu+wLB0+uZwOmiJaNTVqtHpAOlLIi7cx4=;
        b=AguFO1DLDRE72mVMMMUlIKQJHxisJHzHf55+XKKvFKyj7Dq4KxHFEAr9znSncLv1Zr
         cWMHulYTgoMSdKdpVCUkIhlpvRXsxKBQ79pr7ZFNfyjpNtIrsLPFD83+bnT/CN6C7Fr1
         D0lNKsiLmar6n7oBN3YsYNd+hgFGaOTq01wgxOeeQ+Dfy5xmwwEiO3Szudq7Rhl4DbkN
         XcTGjHyhtbU5qJcwCnfANifkaMA5Q8xIhdhifb5rX9en+YXcflAsp5EA5tv4Nadihf5+
         i5WaFVv8aicP0F7NgpSph4O0dwjaYdqgxOPS//qzC9EiZ5g7iwqlexcTnFvArIrTMWZ8
         98IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt95ajNe9lBavc3BWmp9ve04ZvtODbq0JcMUhtvaoRKHfSgDF/bceJC+eA5gVA6jEsR98l7XkmQDdoE6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjfL8wpjk7MkTXMTy6y0E2bWEz9SDVq/hZrTlSL1ArMgR+tNXi
	ezrt6IvOo4YY2yQbZl4YETJWap9Y8DUI4zQS0+ch6OKoWlRvmNjMpGCtW6zvjdS0DWw+1ZaDSkh
	AwulyIsAsoF51KHvfv6JRQWYeqsf17sjGF7WP9m2Dln2/RRe/4xvjSigjilmutCJeuVE=
X-Gm-Gg: ASbGncujI/qaT036Sa5S2y/Bl9cR7xy3d7sy2025yvC+iczIsDfMJw8IRj3JRemFRIF
	5n8aHgmnpjMa5JP5Sg8maHWidY9aLde2SqKmwUDzsqhRVMdLeo2J3Tm1KczTHdsOwykWXiQX6QL
	5nfJorpbkZLk+wcElF/IwG7cvHP+ulwFxA2LkUKKnN2BTYh4xRs8Hw1Qv51OqPTABZa1xSq0oNW
	LlZAnfaoyjUSGtAODNt06x/p2ZoN/ZI7N7vz3EjoVvLdpkSSMKqw8aYdcUlro9L4LVI8FDbTQ29
	N2dvEp1CWDNxQxOGvHZd735praS/s4DY29AYrIPAZX6vq6oZGXdvtw1Fb5Qtkb35wZPIUfcXOdB
	m5O7wpgAaR5idHsBMzOJWRPnjIqY7K+oNBMMg/hVeAPzCCkvZ8WER6xctOQ==
X-Received: by 2002:ac8:5f96:0:b0:4dc:93cb:fdf6 with SMTP id d75a77b69052e-4e576ae681amr63138381cf.40.1759558807476;
        Fri, 03 Oct 2025 23:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGidBRK9vwwuPbw+sdHnG+JGdSaIpFRU9khv8BmL2+FlZ/ApkKjfg3yG1B7zJPyfdzHmKwUtQ==
X-Received: by 2002:ac8:5f96:0:b0:4dc:93cb:fdf6 with SMTP id d75a77b69052e-4e576ae681amr63138191cf.40.1759558806948;
        Fri, 03 Oct 2025 23:20:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm21486421fa.30.2025.10.03.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:20:06 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:20:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sa8775p: enable QoS
 configuration
Message-ID: <uscvhnjlqfppfq4gh3gkja3hww5ldyxprbetqzpfmb4753v2ek@76w6rck2r6gr>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-3-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfXzIVyPderQshg
 kuG03DSTFM4pwdx16VHfNgYFfY4yh5n3CgtFAaVJBCb2kSkPOhR2lKdPcNmG5DiLR25q9mDQZib
 czXRHliWZrLRapOyZ+bDnrnrvEYufz3ZEWxLSLOxxDQcglKQEat8Tw/b507MIUTt22rJRHcUbR/
 FLlIjKV15EjosNxGmQROFYZFCogrSSULi/HRPiXAG1g1ChHdAtfco7nsRXqxhLy60tqLRK5ckZj
 tMDPNXTTtZJbEUCbyNsMoegCq1XcCCdOe7+7Pwf4WUidOgogR2ChvXWxXta/B1B7vpAhVL194ow
 vkRal+XGCOGmVH5AvpqrB5eAVh1d0D2yh2ODJKD9axmFCNWQclEyhW22WlLuBPhZMZeHh4iqN8K
 /OI5GFELfCUJtY4qXxfegLx5bgAWXQ==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e0bc98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=sR7M8zb89NgoQLAwK4gA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: f7M2HhkUPqT8hA1SyKar838eB1DzxkkO
X-Proofpoint-ORIG-GUID: f7M2HhkUPqT8hA1SyKar838eB1DzxkkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Wed, Oct 01, 2025 at 01:03:43PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefinedi priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

