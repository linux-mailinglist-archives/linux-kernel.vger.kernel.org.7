Return-Path: <linux-kernel+bounces-852331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820CBD8B06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65F44FB998
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A192D4B5E;
	Tue, 14 Oct 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpQiSkmd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B962EBBBD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436866; cv=none; b=KTCVPTBQCkYQSpwnpwsJRcTER98XdAbYJq4D4coT2qfUVT8P+0KFoWt4BCyPK115AJ+xJ46HGv3OdHuHsz3ey9HC7h62VdAJfb0noEdL30LMzn4Kks39eds4pa8D5tdW2DzHCSoaZLpeUW24vL7wNCIk6fyekUGq6C91GE/6GxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436866; c=relaxed/simple;
	bh=p2TdPMV4pF8n2l1FtsxCGoLL8f8hoiv0YnRdvUXX/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2+E9hwYmy9EAHP8YU2VAbNXBjXK5udrmOX7yG2/BuSBa9jTwLz1GF5tJvFqB5MXQ3sFODXG/onCbNYK7yIZUUNyIRULAsLoFXDJJ2ud753kPkwwcwpyeY5X3CEl+oBp28sjaJCgZ1iGrAJnfTt85ofB8e+TkpbVQVS6HT/pu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpQiSkmd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87IZR001489
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vMqv4XU7nIEZtG/sYMmrZR0+
	HUe1TmboOJN+Lx0BU9A=; b=lpQiSkmdqbENU6E09+OLL0c0rGlbdmFCqjO5KuE9
	x5ddN2YLeiOmpsl6+RX6fTMK95i7qVPY71hB6MfodrIqY8plcZ75YQObzBHwzk2p
	z6ZeA1jdoz69eZtg5ZCBfuAYajXoBamGM4QTgLETBHKrqgYL0EIG6SshP+rdLbsj
	iMwvQS/Y4BJSbkhCvp/5a0WooKlgUEgHsTDHSHJeOZWc9eBzMv+r0WypMHTI8s0m
	XRYKD+Z+tg0yuPb+P9hWVsREAPI02HN5Si2Ksn3uRQgdGAefzzcKLF+GT0PC3p6X
	XkecNJfOnfIdr3D4FgA19+JasxOlKJW4YI9VwQW19oReyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa882ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:14:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8544316ef6aso1014035585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436862; x=1761041662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMqv4XU7nIEZtG/sYMmrZR0+HUe1TmboOJN+Lx0BU9A=;
        b=bPqh2KByzYJlCbdHdkI83MN7UHymfvAazBHEh5ac6hRU3P7D71ldE9rqbVncQQNrfj
         bfyWMRelX9FuDxoKBH/JMAwOc4CmPig+44kf+iMQQJ12bx9KR5SEDTbYeRWuWcB1Expc
         OcNxQp/UT2BLE9r1s1F3xqtQ9ri5/6lqd61tGNRrp4N1FsW/qQab/9iZ61AMYj/ubIH7
         9p8j/NGdAVcZUdHbmicgmNcOHInaGH8Mj4ptTb9Rl9wJw9r9kHWmImEPlmMdtAdkkwti
         kY+JXkENHf+wKXZG5eLPeW4YhRnsH9S+6DnitEREHRA68nXE3JY4X81NoGp/RqrFDLLn
         nGVg==
X-Forwarded-Encrypted: i=1; AJvYcCVjNkqb579imkgCrMJv1wVUwNNcnKZBvCbUnPOxtTgffP4CWd6GL4xH6NEW1FmYrfpu5nMwLvFNhGRu3mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKOoBs/o25pY2qSsFXDUyeFfJVI0l+cLgTy5apqCNhxm2gAWu
	EcyIRHC+oeKNMG2X8m7BTOX0u5ZJfqjavzxrnnTIAtGtCo51qwn9d/O72CFes3Czc9YTqfziNKS
	gNQSwMVsH8KOePfjdL7KliQ7XxklG30RphJ0Cd8CoLLNbM858JQRg3vLt7c+OG/qo7aA=
X-Gm-Gg: ASbGnculfLfVley6a9Ue+98VsTsxvlW7+/f7YH+UUvP6nrTv0lvxwLxwE7P/lcxowC4
	ZIcX2xvz54UsDxsbJamgb2uWm2DJeNGgIBFYjaJ49UA4GWK4TanJU2nE/f7qZiOqLZ/5gzn1VAw
	nQYXoPq9lq8+6doxCkr2V/8E2HzoRCaKfABmHg77MPvQc4e5VN3hflAuSaf4Y9XzJBbTFCM8O2j
	i6GBhh5SWZbcY6IZnYXvqOPP41FVlc+sAdduCAy+9Cp3BYHyFlIw/YYIfeKGzw2g4ytG2sQ9zO4
	byh09f1aSKP+KyKJFj98bT/Z05VO50ohh65KTclzl5pghHK9IRzxj70e/SRS3Ng2eSInZVmCqjU
	/pB/siujxl9b/qiSDdZVQQ9C0OmGPDT0mH1b6DMkrdyXi7Q+pGmPS
X-Received: by 2002:a05:620a:701c:b0:852:d8db:f4e7 with SMTP id af79cd13be357-88353b34013mr3649401885a.43.1760436862454;
        Tue, 14 Oct 2025 03:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE26zUzxtiqBGz0fWHzoxuwaD0agTvo+ttD3Wx8z2D8qcgGeylJwiFMQLgCJJlf67ZKAB+sWw==
X-Received: by 2002:a05:620a:701c:b0:852:d8db:f4e7 with SMTP id af79cd13be357-88353b34013mr3649397085a.43.1760436861964;
        Tue, 14 Oct 2025 03:14:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3ee2asm38789591fa.50.2025.10.14.03.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:14:21 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:14:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
Message-ID: <5t3uowqhhmnbqhrvmkr7pfls7753banu6aizlszczrem27uesu@po47ah6eic7p>
References: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
 <20251014-phy-qcom-edp-add-glymur-support-v3-3-2772837032ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-phy-qcom-edp-add-glymur-support-v3-3-2772837032ef@linaro.org>
X-Proofpoint-GUID: Pe06MPyCz7fhzLLqK7xUQBdNX7O80_Lp
X-Proofpoint-ORIG-GUID: Pe06MPyCz7fhzLLqK7xUQBdNX7O80_Lp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX9UVHsqtiS15S
 G6dK2gA0C4q1f6MCP/yWIEPW4gWhduZXIkieC9qDudhssmyFlrLSmMPj124DTWZCuBa5RsSVyc0
 2CwnumXxQeGskN5u9OwhBAk/NbKTJ3HFwMPTJqE7BPHsrlxhUxVL/4I0Hevr77DgDgTh1lz8eNM
 98XhJ44kWj+GTCZBXRlTkNO1swaMH5bFMsr9PFT+QtdwkPFdkuykgpk/hqbZrTk+3DwKb/WkoM3
 GD5Tp79w6ICiVOHqzuOzL5uFBbhdbmO3G8MerFnCyjo0YKkoWxwaXmCaxS+KmhOUjrHJpV2FjBA
 PRaSk9/S2g8Kff9ZSEghYRGDRSAdndFcOhrwds7xHnwYwKQH33FnEocPjCQndFUzZn3JyBbNA7W
 nMHCNYBOWz+xDKtQbGwmPS4EsOuGlw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee227f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UOUSw7ZRRveOu6dMj8oA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Tue, Oct 14, 2025 at 01:02:29PM +0300, Abel Vesa wrote:
> Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
> for the same version number. So in order to be able to differentiate
> between them, add these ones with DP prefix.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  | 52 ++++++++++++++++++++++

I think other patches have adopted
phy-qcom-qmp-qserdes-type-subtype-v8.h name.

Would it be possible to follow the pattern?


>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..2bef1eecdc56a75e954ebdbcd168ab7306be1302
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h

-- 
With best wishes
Dmitry

