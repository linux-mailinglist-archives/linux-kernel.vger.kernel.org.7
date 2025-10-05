Return-Path: <linux-kernel+bounces-842496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20296BBCD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926F73B36B0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920921ADB9;
	Sun,  5 Oct 2025 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WO5WBtQC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D44204E
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759704986; cv=none; b=OZN9lubVWj5EJDJ/pLUanO2xaJvApxfe8gKxOp70z03G1t29cHK4kBTItX/oI5/lVOjeZHY/9WpGieWxVKnRJKQ1z3nBgeTMINa+nDCBzfYB1iNAqwbcinsgYu1mTLQdUNUIvsbVR+J+cIdXhXBhFKtthtGHTYdhGCO3RG/4VNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759704986; c=relaxed/simple;
	bh=CPslW6HqmZWUpJnvYesXoP8whn99ExarVFQEcoGnCRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTAkigwFGxdUks9xUp37El9UjbSsf5ZSVTTd+TO6RFUh9wIZWqXYZ7OvHdpVlqTN/yqPyjN5KKUxTssXq3YrnoWYRPY7KkVp9BgAJdkyL2HiKFmHST7Qnoy2jpLb9IxpwjaBvcHm5UGqyD+b6kVpVKndd9iEMOuqG46EgIKTtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WO5WBtQC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595Lb3QP024045
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/2uWnsbMls6+QfRWazfnelee
	sfKUpBCdSUzAPjRUlew=; b=WO5WBtQC2lyJRDa48iufbKQXpx9qRCTfnUI7YPHX
	FGod74uBMBAffjikoeHvl75x7WDcOug3S7xgHpCBo/YFFOuVA/7AB5EXePa1UtMe
	gWeqhjhJzQJe6o/txjWH0kMzlyvlXzuWwPf5ygCvbeERR1DjxX9+wvjvPqkJtbWR
	JtG1bzMFzf8is2HErHJk9Qq4ZHqLcvcoFJLD8PD7F4dGsuvYUyCkFrN2bsEFwsr0
	N6pt1pxhuSVTYS2goX2i2Md8KRSUYm3ArzPx2HTNUHAogml+ZGV472c5nB9jorEG
	pzZFzKd+9GZCqx75nTyHeXFfyBdcM9DQzY1v5C5xviDvrw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhjdre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:56:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e30eaca8eso129558036d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759704982; x=1760309782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2uWnsbMls6+QfRWazfneleesfKUpBCdSUzAPjRUlew=;
        b=Cx9sC6vz0q0p+Mtpe4UhH6dZ6A7BPC3MlIttu5IJGFKZRxzAaw38K4/j/jHDm64W9M
         dBkSdcYyPEU/H7stU3d3ZaBuq3CpFYGTp1fFI1+YmFRjKkMR29bMgHIEW3qRpGIY2EU0
         go/Y6R2eW/H9F/1RN+sRd+G4zIQDRxa3Unz0qJWX3PFpi1SZw+YjjHC4J8G3E/eZQvAp
         gsW0YGuV/WOMO2YaWkc6HP/Gl71SyMbh1H5FXEnECCGfi0OmeFZ20MgYnYxyYx8JUZMB
         B9HxQf6wZD5k0f9SFgCNU3+vnzaV3k7blihIU6Wz0lFvNDzxGd/yi4/7Bd0P1uYDmyct
         COiw==
X-Forwarded-Encrypted: i=1; AJvYcCVMHLBzNbzsGcVRRotRmDPMLtp+27kYW5KsH7ecNqA3CGWJUPam9tJwdl78dD31smPuUGsmrxWl90KPPNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7MIh3/27mCuBBgCG3k6wN9JCjs9SHjUEzcOoiLgAy4/PcJfJ
	0KeWBhqLwqSnJO7ueN97Zum0D6xaG7wwrXXy3M7Vmx2YZMWM1qGkqtWeWlQ6WF1Lr/iPlbh/1It
	8HcNWF5Z46lOFu0dqZVy5K+svbzC7JCwna2I3uEuJFLCrgbgwEF4S7ij/d99IXBEM9T0=
X-Gm-Gg: ASbGncsUL5KBKMPpxlroypPmyD3arL+WgiHHjXTGqpc46GnNooeMVKRwZxnRsKRubzv
	rEPbstnlNYSfKCKwJZLLJpQ0zpeCa3d5DEsalbGsjYZXFdMPb4u6ZrVa0W05J45eDlsyeOJscb+
	7grLcexYdn8CWhG0Xj9aVy0wCAkJHcA+VSFJhZbgj0pVxTF+hmM7F+Nh0Gaje4ahZ3yzcK7Q976
	GjkM6jV8M23HnBxyznUfWmxp/QQU3V/O1jQzaqxpk7+si+xjVX3Og2NaEwIQPR8u5l5sqVszgRH
	BOp2j31QpJwcvd1d+PvyiOCCvIG+BiMovtH/wV92feD3yNWBLj54q9d91M6Sf5h6bYkgU/BeXjv
	EXqwOml7YdW11Aj6LthfBlFc6SXL4OYXgo6XeNDJr+MnUPNqNRL1RFKkX+Q==
X-Received: by 2002:a05:620a:254b:b0:858:fb03:1c36 with SMTP id af79cd13be357-87a378d2e96mr1325671085a.44.1759704982362;
        Sun, 05 Oct 2025 15:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcLVQ1U2XzBgCSh16EAKCoHAqyRTinAFUHqmO6aWJdesSrBZJIUBhcSHx4M5aFBlxNaomGvg==
X-Received: by 2002:a05:620a:254b:b0:858:fb03:1c36 with SMTP id af79cd13be357-87a378d2e96mr1325669285a.44.1759704981901;
        Sun, 05 Oct 2025 15:56:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba4ce0bdsm39514101fa.53.2025.10.05.15.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:56:19 -0700 (PDT)
Date: Mon, 6 Oct 2025 01:56:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 0/1] [DRIVER] gpu: drm: add support for YHGCH ZX1000
 soc chipset
Message-ID: <z6olmcvc454krz6axhxcgdzhd2vvp2hsyruafnbqybtt6pxrwp@a4ozfscappnu>
References: <20250929063103.7375-1-chuguangqing@inspur.com>
 <20250929104831.8548-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929104831.8548-1-chuguangqing@inspur.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX6ak02CXdi050
 jgfaV1+OWF/qRbCCPcJGt4Uhe/N2qr5gbk9iEty0VeE91Bf4EMJGhdpTwmU3kXOomoDv0VQSecO
 QGxSRVDuy5PqGSqh7AqipXJLAE3EmomPfuvMqsAT/HdfAZPbomA1U3CjV7MgWFmX/5QyEExvMwX
 ojaUqTLxlbZfAUTLbfCjGsmEENdXkSzJI07y2lcwN2lt3M/IYLuvh3K5tyYRrxUtPx991BihdPF
 j3nMdFj6CTWRM/wuZg2zzzEUXX6aq5ID2it+RIJy4Vd7hDjXyslyWKAj6kNp2NKtnztiSbtO7Gx
 q4xdTpJCJJVGC9QqzwldzxWBkcXSgBhsQpoe3AxHERiE/FgSm331K7uXNY2IjEBWKY/pSWgcLqZ
 54FPFaz+17/MWHkWGVmGK2M8mK+mNA==
X-Proofpoint-GUID: LQ2IDkeHF9WExUcw7HfrTgADPrCxUzZ3
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e2f797 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=zYVcCjuztwTJQ5VsRzIA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: LQ2IDkeHF9WExUcw7HfrTgADPrCxUzZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On Mon, Sep 29, 2025 at 06:48:30PM +0800, Chu Guangqing wrote:
> v8:
>  - Use YHGCH uniformly and add the company's official website.

I think you were several times asked to stop sending new revision as a
response to a previous one.


-- 
With best wishes
Dmitry

