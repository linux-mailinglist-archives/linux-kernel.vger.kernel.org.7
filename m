Return-Path: <linux-kernel+bounces-813027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD0B53FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D4189CA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1091482F2;
	Fri, 12 Sep 2025 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9Iwwt9J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCC1311AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640305; cv=none; b=RAm9s1OJbZMBeTmztaG5F+7l97TJwokYfNzsNBQTtrKKBfTa+TkAMvYgbHshVChZz22sGh9KNDutTIbz24LZhvYMcFZg0TYqk2kVCGMRZtHbP9YBe4UfDOhXVz28i/TQurgdVFZ8D18vmxrrp+q5bF97xGY3CBJLkLcpWLQ11M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640305; c=relaxed/simple;
	bh=OXbPd0+GhJaf3PtjeJYGSP6S/zKaFbPnKgsQKZXpZqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpxhPLQQYaBUtP1vdALDyy9Vhr9W2nywenPwmTnowuSo1vizDjlhkM+0CsyfJhOYdPPoMYREscVeZ+sQbB+mfD3O/acJdzX76+mxhTQaX8lCI8Eimh9UET+u0ofiA7UXwRlx0yEocYLdImgcw6neH99qk/+LrAb1PVOeUH2XZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y9Iwwt9J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BJshbT031245
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jVL5pFMdzfmtJDJqaALS6MKa
	H/CYA6RWxHVUSd0whRA=; b=Y9Iwwt9J07xqyPZyLzirtvGTfSjHJt09X6aPx4IM
	5POqfmcnjfJVtTO5/hpE5TrcUBPl3rE+xTqDE2rlFVAB/al+OJCeK686UlLyg7xX
	yORbypKnJPaJtWCfJGZKXCouDKsWEMSsOSYPSzyMx9sFPzK44E4DkUp/qgDxvmuR
	pssa7RBjWk1wm7liEMXUMJBoNYJ0HIembptxXEw4L1v0tsamZ3JevPVKWWMAPRtv
	gbnlBfOkH4PEsGK4Spu4aE0xLVq9eYLq5m/J5vjYUGhtFHcw8ZfwBDPniyAaOSCS
	R0eQ8dHfGryL+QgnO9tgEzdSPgc0E/nD7UO3PStRdnuQlA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg9j7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:25:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fb1f057fso20035681cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640302; x=1758245102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVL5pFMdzfmtJDJqaALS6MKaH/CYA6RWxHVUSd0whRA=;
        b=YSgqnze3jzXBEcXUWWO6pIcUADez0ssN4u4WbV4yAw7zuafqA4ZsBpBI0r+S/yCb7g
         BZ7TBOCtgAnD6rhOYNCPg2k/b85lv4AmyA4gNyHcIxeEnscEkm7EKG5R0Mq88WV0sZHN
         gSWJ48/IocrrkfyQZdZ8zv4hMkbx7QQKVkWllAvIv2kQgyRx2Wwaj6KwNeIZC8hvrRt9
         hvDARSdIjeZKuy4zDJb+50kIArCywCbBUz65j0Nn2yNucw4KtYYHY0K/YgDOe4ce2lGl
         ycDZsq5aW+nVT3seI9GBfT3SIHp3kt7uTr6jsMcURFgo3sI618UuND5BXPOFhOjAz6i/
         kLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUcBPUatmr9nQRacDCdZ/1VhE569npb8I3al5Yeyi1VC6s/zGqPl1CCUgVvI/AsYJU66swWntMPDLNKock=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6Ld9V1t7kOIEzLGc2Bb0ZF4VbVUGICHStcTnWI7OM/+ghgrV
	bEWZi7J2Xz67366NQ9nTpJtViZ/QnKfeZ9Mrhy8Q5f66eX0MrBxKrChBTK2s5VagVT7+3slwjWt
	L4rsulAFAT86fkE7bA16YYsjXCOR1FnJKCciOvFmMvAtwQbhZ9UOCbtAZZVY/m1ifNA8=
X-Gm-Gg: ASbGncuf5YiOsJgj7cX0bSSKS25DKtfdLyGJBDGXVLpu32nYfkV4pEtfIQQePEOGxkI
	oClZlI+HMClqMz8SbaA2wH6kBwKxkivLBoKYGJhhbDdZ8dKzQOyWEJ6efIPnuKHW4kL0/4PPxMu
	ilyfpIaOQoUSjoAkfC8lshI0vvPAbqu3xm5NcKFWMkubTahy+wx6hbLuFlcXxFaBEF9kf0TONHz
	xpFOZnCupTJvzrrUQ10z3gTK/uDCws7agf0jmd0/l9W8Fs8bFgpTXdplt9c67SP1e94JEiVk8cN
	wsV+nKjZrvyXBCwVAbvdUCd9l+nhCLqRckR+RxJsk2sqe2YnthYuGO2yQDVbTpJXnl1Ly2bZJJ5
	6E6nb2mPpCaAqxoUxqp8dm+B/N5c1n09MekdEAzAAyhAnpJxFtVtF
X-Received: by 2002:a05:622a:514a:b0:4b4:c44f:1a7b with SMTP id d75a77b69052e-4b77d0bd2f7mr18789991cf.62.1757640302351;
        Thu, 11 Sep 2025 18:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+QdUbchdxCgWR0jpxz6S1/KovEnrGHT20/GZYw265IPlYpgXYKdIaCAtbH/9CHq+GGr04EQ==
X-Received: by 2002:a05:622a:514a:b0:4b4:c44f:1a7b with SMTP id d75a77b69052e-4b77d0bd2f7mr18789701cf.62.1757640301746;
        Thu, 11 Sep 2025 18:25:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c692daesm788199e87.26.2025.09.11.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:25:00 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:24:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 04/13] phy: qcom: qmp-usbc: Add QCS615 DP PHY
 configuration and init data
Message-ID: <3ihzpsmf3btzeltxggdnbheji6bdeornravua76adw5dhotztu@e3fca2prl45r>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-4-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-4-2702bdda14ed@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XbADA7N-OZ9AFRGsVHG-TtfLo1g214lG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX79SqayurLRu3
 jiRbPEU7yhNfHYyjnuN12ftoPL7krEevv+1U23PUjMYomsRsupPpqtPsU5j7Yqz7ctS0SwJD4iT
 +ReXcWMjHazC1W//tZg7yRx+W2GjiJ6ARM6kJuKHG/cHFNnhJkTzTI+pE7LK7Q5/nawalsAgGJY
 CLIEp9ht9TOwtc2sHeLlcgus71TY6lD+ElUcYvCeZ1P1kZEQ5rXkAnXJxXKm6CnIQedrXx9Zt4C
 kWpR8ypIE7kKZVOi0hInsUYkbyw16cf2sgPS9FJInq65wSWLx3xh52MxeUVLPJLMyCW+MZ48abd
 JF8R2xFnyuJDw9P3C5mRvkppM31VxsVO7TLLajaVZo5Qy3Fzqy7p9605f8yvZBLJ61UKTisi16S
 h0TDHmza
X-Proofpoint-GUID: XbADA7N-OZ9AFRGsVHG-TtfLo1g214lG
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c3766f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LEMoh8uNuNVMCwR6SuoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On Thu, Sep 11, 2025 at 10:55:01PM +0800, Xiangxu Yin wrote:
> Introduce QCS615 hardware-specific configuration for DP PHY mode,
> including register offsets, initialization tables, voltage swing
> and pre-emphasis settings.
> 
> Add qcs615-qmp-usb3-dp-phy compatible string to associate QCS615
> platform with its USB/DP switchable PHY configuration.

This should be the last patch in the series: once you add the compatible
string, it is expected that it works.

The patch LGTM.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 141 +++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 

-- 
With best wishes
Dmitry

