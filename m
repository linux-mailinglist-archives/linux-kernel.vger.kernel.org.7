Return-Path: <linux-kernel+bounces-824987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F0B8AA1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA407BADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92690273D67;
	Fri, 19 Sep 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+zIWkYX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348532129F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300335; cv=none; b=V8DcUBAwvcw1B/2sbEZrwuZymEpO24zzrWBGTxJxWb2ZUujrBoIvIlrTrp2kQ4JaDIrb1Q7ZGoAPHWTZnK/BLtZ94iXXmPQeorNxMG7DVo278847TyKHuOi+vLRZXhyVtZHaryFtiNkwcmvewMvL0csht9gVvP4TZZIK7oWubtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300335; c=relaxed/simple;
	bh=4fs98jrSck3x8PLmQUQVQOKqZfnNTah8hBpBS8SrcvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9YlnVwfn65dgo9bgd2y9FbKGfi6YP+g1h4N269ErDC5CWo2Sn8X6cPfb5dQeTibQGOw6LPYs6/JXL6JeunQ8K8/5vmb/BPJHu2NPg8Gv3Koo458TqkBfXHjNDiLIUY5ciocVfrAfux2TDgPMzq3DrAo3G398OEHlbpgBWoWPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+zIWkYX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDVALb032456
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C20ghaTYz2z07OewDUW3U9kP
	PyChf5ZskPTDdANcg0M=; b=L+zIWkYX2CHEXD1IG7LIUWQjC0kQ25fACtMvwpbi
	OZboAtLm0n3MKd/wqPAgbMCllkaBCywR/c1UNbx1+bk1upwTi5krAOiY71qoc0b2
	mivrON5KmSG3KK97wOSVX03BecCOBLMcWCTd47sVdojrmDgixGdUsvzoIh5GLaDm
	aJVclV883owgqTbbHMTb+uPs707N0k+5UoKpuhQr5EqDLQKjYj5jGRrfrQJsVsTx
	ji7qbLbGiKr67yB3KEJIZgXwx0mG+6sRoNFTnbeB0NUw4vBVXA48aV6Hb2Gz35D+
	RY8MC/gjrF7wxU3T1isgVegs5peQSApRmS6bTSj9bGegVw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyu4tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:45:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78eba80fcdcso48963976d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300332; x=1758905132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C20ghaTYz2z07OewDUW3U9kPPyChf5ZskPTDdANcg0M=;
        b=QommsNtZTLgOBl/jXTG/UfX42x1D/8/Jp3xYDgIsdIc6VinkmrxwVzV5prRbmivknW
         9+AKY7yMP1c7aUAe81arv0ZEfjAsRF5E52uwEoWpXxVQTAgtGt9Tt2l0DpylDm/ONptc
         mXCXK41iR/Pz5Sv9l1rUfmijKMUhHCRmhH+V+sE4WOIZjTvcrAI7kZTgBnU6HlsUq4pt
         WJ6kYHeHgCPv9gk1G03LTnZl97devbJUjVuhuaExABDnsDMDEbzv1E6j5o9/e0fpFTJr
         8qjnqtogsE8R8eDIqutna1FFMC0bCUxHWSkzAgySMoYuyK8eFOz7/ZlWUWREF0S5VXNf
         egJw==
X-Forwarded-Encrypted: i=1; AJvYcCVBl08PmTKSknV8H/Wn6noSCy2xuIBaf93g469K7vIh4l8WtmZUdsN/rIw08cgFVpVgV3Jt3YEDzmYDTcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTuA9btFQZxP5Khop6mJ3C8sOYuDi6HwHHOmPYJzhJZdC2ag9
	GLWaqSpnNo+CY5+PvSelICDvEhOtzcK46ZITMYnmFnC0bd99GI6jS++6TTAqSUZAku19KqMruVd
	LEyOM53/4hEGo6gC8IOrXKatk4otx5o2LTMGNVhxFImaTKj69uW3ewu/11RWzZh7myPs=
X-Gm-Gg: ASbGncuhbyqzAZm/nt3WKetrsCpx+hg1UH4ckjbjcbZWduGDXjDCUSM1f80uLUo01cL
	BTJJIXyoDx2SbVLFoR2ybQKboUPVo3GKR+AFraeqCIcMe4/2Tgs7NXTPnQr89fuyoDauGgtskm5
	+Nmu+x2Jx1I/vlrA6IVnnMGJQ5acpm9RH7AWawzak2LbkBoL0hub9lcfDkbDCFMFSs1p8nSxGlf
	xVjSH0hVrmSHFmcuBs+cKes3McXnND/pOz1/aI6UbBnsIZz9gGzHKLIL4e6LSlfxRa/RwmWUiue
	LMDWWs2mkQYCbnt3ccgjQ5CMRUxRpGjWjk8uu/QpHgsD9QPt+0QVTkj4CaiXUJocIyf1d5PYreM
	WnilQk4PtrSzGEAzY1tZqeSewQM7L+cDjUOjhrC+thy4NpWI2/D1U
X-Received: by 2002:ad4:5de6:0:b0:78d:72e5:4309 with SMTP id 6a1803df08f44-79913f8ccc3mr48541796d6.25.1758300331957;
        Fri, 19 Sep 2025 09:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENMkKKG2cQIkLe25WJp4a+nFBl5DjpFFzclGB37kCIW8D1f1msQ+H2z+bjyqDP10qr1zJDzA==
X-Received: by 2002:ad4:5de6:0:b0:78d:72e5:4309 with SMTP id 6a1803df08f44-79913f8ccc3mr48541056d6.25.1758300331184;
        Fri, 19 Sep 2025 09:45:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a26cbcffsm14030911fa.22.2025.09.19.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:45:29 -0700 (PDT)
Date: Fri, 19 Sep 2025 19:45:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Message-ID: <z3phuuokrhonbukct2siz3ujear5ymtnoviea2epxzvjdmsvkj@w4puf4c44tmk>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cd88ad cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_hUenYmi4SsfCOKiixMA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: lXkytQ-uWd7UocsIZ-gjqmkU63kQOv4a
X-Proofpoint-ORIG-GUID: lXkytQ-uWd7UocsIZ-gjqmkU63kQOv4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwjAvq1uBw/U8
 FfUftg4bQy5J85+oEHNBP1YsMhKRnLpbk1/ebdV6NUGAYUmVgcK1LyF4oqseYNcrdncUHsT1l5X
 kI61/NZKl+Nt8YfvX/Ec3cN8DVvvtXIe48bVawQIC55G+SUHFHAzreRhktI5h+AaoldupE5xG4r
 CvwQRXkaRBHhq94otxkDO4gdIFmY3z6CoWzS0ICiTHQGTDaTeWheHnPXIq0ijiQq5+jhHpqtWAO
 dNKthq9Ln2kYU37I92qvWCkv+dGqYixLlE8DPa2eSyg5KL7lx1ywpA6px9XcpL8cgb89dx3qfzO
 ZVmUL/WVMpn3PCl+3P1MYr89TL3cEbOJXTbYhKwPGQN5+HCA/tpgstFgdWlvNS+jUqUPKCrccIA
 0QCwu52N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Fri, Sep 19, 2025 at 10:24:22PM +0800, Xiangxu Yin wrote:
> Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
> path on the old hardcoded list; non-legacy path uses cfg->reset_list.

Why? Start your commit messages with the description of the issue that
you are trying to solve.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry

