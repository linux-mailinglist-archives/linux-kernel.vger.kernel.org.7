Return-Path: <linux-kernel+bounces-826183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56ADB8DC74
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF823ACB11
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1B2D8760;
	Sun, 21 Sep 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcNGjLEF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D52D73B3
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461895; cv=none; b=KKoKzWCkUsDEJ0bP08vDqBR41LMEpOx9PtokdqVKbR7yfn+fVHCgoZ8hy7TwN3jXRZs7LNQkCq/e4K1xVSY/3GGt2lnogEVrCCc/Ty1AFA2fbBvucfH1T3Eg3/fKamhMo863FtJhUM01jyxJtbSeOT67OdOK5jRS8/Cm7HDe/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461895; c=relaxed/simple;
	bh=kfxzqQY9FBGo3ot94aCtIjWQ9LMwiuq7sLB8wE8t39o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLaz3OqJOLio491tuAfgXfNgRM/YtXf63poG4yqVwAg8I9mCR4kaTU0nhGsILx1pY+UVdu/CJlD99OqTlPx9vDCySydoLmZWmR9m/lQpuzzceJwonMbkhDvRVBnXxbeuiuk7a9zTNMBBdoTDmYL93Lb02QM9++YINRJdUUL1LDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcNGjLEF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LADCTk011296
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UXvFsOnz/bg69aGhRBaNFRF1
	HMJGHKlWWIW714fk3pg=; b=XcNGjLEFG00hpkufZFQIfp7v2mbvMgaRHxm1X98G
	IWB79xydbywzYmCvdaqZ0S5Hfv4/ScxXaHi4E+H4WHRB3D/nSC3/1VITg19SC9zk
	94QvEKnkvCEg1Pr2z6ULYONwsUlfgadBqpsNlftFAKQHIVzwfrzBqD+2GxNn67E4
	/ojYPjje2uyGgjTkWjFgXcesAAXVFIYDHo9Eiy0qNJ0624CEa8sQapivGGSF29mn
	D7YXNOuZiFTHrGVfgHdjfm5W7Ztrkpxhd7CHIvmbLFZiZOBJPWjJQWK3PFAecIkE
	JDy8f9MSjSQAL76Oo/Doogw6OrzSz6ESZTka21AdxGYYgA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0t8df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:38:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-767e5b2a74fso36695246d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461891; x=1759066691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXvFsOnz/bg69aGhRBaNFRF1HMJGHKlWWIW714fk3pg=;
        b=W5SofkZSCuoCr7ZqD1n/V5xqQnezY4Y28ewyeDYJHCzl2DJaiEZsbiflONZ7gtzgzR
         762/D5qMAV9Cl6pWuctTW1kzaLj+i5Vg9YrJdGobjso5DEb3gGbI8EJpq/3eDiZcsNzc
         WmpsOyy+bYdByb20dB8dT2lqF5dUqxiN1iSJ9JQ0jq+a/81vm/puxW+lKd9YhC0QcbjP
         LuCyIJbUttjPHs7m6gw69yQ1uRHdJpZJF3vavwQRbeRMEwoN1oMsuXT92R2O0OTJfkVM
         ie9BOLcUcvbyi8d0PwtX7qqrbEYNvQTkfIcfZxu/HyGddwDvzALIfHwcTSyMdyqk3Ias
         GgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoRLCyAQDoaTe/qSB4IiTxwlD1m+JcVk0AsRyBQxVe44V50TDJct2+agq4hqhJ1rl8YbMaA79UKSQqTRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUU8qCZRsQ+AuwsT6MlZlEnq6N3zNmaac01D2Y7gPcTe2TzgR+
	9Bh3turYqYFyhV9ZZjquJprUs7PnC5VWCcuYLI5er8CWkJJECGhFBG8439Yttwqmxp9AU3rHtK4
	LkBo2x1t8S/81Wr+mx/rUoFSPq8kQ/83mqvLv7scIH5ImfnCKZX2wl04nAKvvGbtCA0dd9lJCdc
	g=
X-Gm-Gg: ASbGncugvzFy5SXaUYJPTzZLhZqNsOCiaUedcLcgaLotrjTfwbqw7FgLos9OBFv7S5I
	rU/OqeBjeCIyuvjaonLQJj+8Ixb4wz2mNZrlNkL6E9vllhj7y0lDEhMM3BYGg7zb+pNMQ978/CX
	oVekVSgQv1XmupFq73EoXp2vksVdNQHcE39OACM3UqHMC995tHWryQzTiWyziEaujikl0D8UjIN
	DZGpjPKxSvXIWMvWOjHYQzMhxdJKQksSSHjLJhcegkEQbs0bs2TmAP8zTUcemJZ6nu5Iw0qZCQf
	ByAkJu8NALmYLH6mMwAqtZftyg9k7WFUe3hxP2FGg84stRiV59WV0Cx/WlabZsLhkA/ItI9S7Ky
	QxQfmQ/CMsA8srGeAWpKiWYS8YiR+664V5wz73TUzOHTX2wn0Ygbm
X-Received: by 2002:a05:6214:14b3:b0:797:1e3e:bb0c with SMTP id 6a1803df08f44-7971e3ebfa8mr79271596d6.33.1758461891583;
        Sun, 21 Sep 2025 06:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjThN5e2uPVDWFKuoGk6IPrJFb/I2On/gRq0XvQWhXZz/M9H0O9RQW1RejBp9P/jCHPApZBQ==
X-Received: by 2002:a05:6214:14b3:b0:797:1e3e:bb0c with SMTP id 6a1803df08f44-7971e3ebfa8mr79271446d6.33.1758461891143;
        Sun, 21 Sep 2025 06:38:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa480bd5sm22491641fa.65.2025.09.21.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:38:10 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:38:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, Max Shevchenko <wctrl@proton.me>,
        Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: dts: qcom: msm8960: inline
 qcom-msm8960-pins.dtsi
Message-ID: <ehpuhdh6pueeqbw3qoq2ad3xqjefcevja25wia2poyf4kzdvbj@ki3sjyots5im>
References: <20250921-msm8960-reorder-v2-0-26c478366d21@smankusors.com>
 <20250921-msm8960-reorder-v2-2-26c478366d21@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-msm8960-reorder-v2-2-26c478366d21@smankusors.com>
X-Proofpoint-GUID: dRsJuZ6KDM8pLq0_hIFI-9LlUS3D5UGA
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68cfffc4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=kbTPNbk5bq0GMcXo2L8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXxBWROfGyIZRi
 ZkWf7q5E4TlL41bLerJ0vk/1UsWkUxWS/qPNPc6ZPd7JD0eYWGeqMN3gtc9ksfgDC9sqHR1vLQD
 VkjfvMn12FIf0at27fUKXEwzO8N4xM989ohr/wXZR91FKrnszuAxx/Upm1xvGvFunfCHs+S0c1p
 8dOUNnjxj4mZ61/S9L2LJWBW3fZ9gXcjuOVEbsBYvjPV6950ri7wR+YA6cptpFN4XZr/DFnRtAn
 Q7w0Zjy6ecQ1zL1pj9SeUmnda/4ezby1Esdv0lyI3vbNzRrhPDvpn4FbcGWACgUFkWP1APO+5KH
 sicky8LrCyfqUgDIBPdWw6cYetrydT+IUXeorvCadAb6Ta3kAjfI5xWlqScGkLXtNttenp8CewF
 NGDpa4b1
X-Proofpoint-ORIG-GUID: dRsJuZ6KDM8pLq0_hIFI-9LlUS3D5UGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Sun, Sep 21, 2025 at 03:08:05AM +0000, Antony Kurniawan Soemardi wrote:
> Inline qcom-msm8960-pins.dtsi into the main SoC dtsi. Most Qualcomm
> SoCs embed their TLMM definitions directly, with only msm8960 and
> apq8064 using a separate pins file. After this change, only apq8064
> remains split.
> 
> This is a cosmetic change only, with no functional impact.
> 
> Tested-by: Rudraksha Gupta <guptarud@gmail.com>
> Tested-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi | 61 ---------------------------
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 59 +++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 62 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

