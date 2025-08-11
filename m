Return-Path: <linux-kernel+bounces-762880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB0B20BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDAF16F8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEF23F41D;
	Mon, 11 Aug 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d4qFdL7h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAE23507A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922168; cv=none; b=eClykeOHI4EuIEhTgyR13Cfl/IQ05I4b4Np8vAPcHD6VkQhuttaAjFz7uY866mRHUPWkq8qzyKgYp3mGKs3ewIfUxLmgCgOTKi3jvU1xkKDXrkJv7aJ3bB49rkyAC8cx98urOf+6WZDkcEDYkmHeyP7WdBBGhRT5/GY5DF43DXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922168; c=relaxed/simple;
	bh=sGxVgbpfhkMiC2JIzxyPIDukcvGKIF5ZEd6qaix17IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfG6t40dqmMRL1D4L1qfP1hmC9hT6GtWMYWXw3xzJSiYZjnHX0F0LinkBHP2Fq3NYsw0oEbx156W3yR4Z7aERmToN0s/svQ04qA4bsMGegz+Mxn2ZxWcPPy93MlqatYtSIFTxegoWOuXq2KTJlItq6JIxsvRBhkci0A1zUgfj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d4qFdL7h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCd7007639
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=atvUDHFH97dMJ5RNFFG95hKk
	/JrHvvz/NgsyopsiKk8=; b=d4qFdL7hFWSQqJiJGacCAfvwApxv3jP+S7g5HIx+
	xQZpa8CGuoSfNX0Ddv6iHZBVmd671cQnR0HxEmfbbFfOOe6QQwNv4wMdXjWyGKeO
	4FKZNZumtPL9JBwFDTS8VO9DPnAZVUHnE9u0rAHkGR89T22x+zLoexcUwsu/rmLe
	IVrGrIQ2jcIwy4lIb/rVFiaZ/pqxzTSfwHrkDuDBurZJWdrOZjVvYLVYEyIlnUjP
	vvyQNPFj1Af+30GpLQi3lSEoH19LLIvUR+9nqlwEfRIRhVNGr1lWxiRpAKFHOKa+
	8tR3+/H/txKJAPgXzmnFt284sQTgOo42E3n9v2+Mfub82g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fmxb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:22:43 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4fe1f50e44cso1589455137.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922162; x=1755526962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atvUDHFH97dMJ5RNFFG95hKk/JrHvvz/NgsyopsiKk8=;
        b=gM0KLI2G2HJ1IuM0xoHimJOHU6Kh/HbW433hoHgf40ZJ2X2WgtyyectLiHIcLR4NWw
         wcyuhjEKju0gbFCjSOcn1SvtQzYi4/tWlClWBVrOgUN3bKR2guZedz6xw2Hk4EBckTSA
         DhvVR/JDmxMZWbY7TeHcXJ10jkxSjgkeiFoVHdu1uuYFsA4xupkJKOkjVq8cAx+jEjZC
         t4LScT9SrcbEwboGxnDfyWbFqV5WfGpcvuI2VMug/osNULUddmOU/cbUZ6UF8BJoA/fJ
         1Qyh1+eG8gpW0fXcW4yEWZPvbmRa5GnwZkBDzZRwg+iLRuYcsadOlfR1rFcKKl/J9F7x
         0zVA==
X-Forwarded-Encrypted: i=1; AJvYcCUxRYqwIv81goz0K80R33FgXod7egMP2Mb80+3VQ7C0jo0rUyF3WvikTWgy8n7XgyqIayN7dMPToOF5ux0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6htNLD8+cqxwQO/ywY3lLBxboPxXQtKnZyoyYLtNLZiDXZwPf
	NmbER7hbdbha0THqip0LpK12K4pOLBritS0p+VAmUCA88eFHQLI0stVHhr153iwea2yrzLOCTkj
	6NhuWxb6vjpOR4S5oXTa56EsQ/FCpZNKmaLJFvlGoYleR88KGYS6gS6vvE8p1PcTrmXk=
X-Gm-Gg: ASbGncsM5YSvVtFpjzLBfsfaRsMLEXf1Pe4SzHpsU2EF4ixrLAD/++mnWlJt/kmDiTs
	k2a4vZcU1aF72CnPwJO9jJP1kOPHBRwwnue+1IU3TOV84an5URuxg5wG649oh0MV5539rDUoau2
	Lh+kUvtlFmcbbz2Jmaav2QYGTnXWrxNU/FXN5SW5cVAeDjPUgGw7tk0ByeSx1jLrsqoWGOnM7lC
	FVFzv4ogX2dPSSHiZv6CtmxVhRDyIVLGqUaruHT9YiqNFTC3Q2E/02EwEh0EJlchj5oJWIVU8Zp
	TpmyKSGoWuR2lmePm9AsE+KjJNqK/4qQD3uUvZ0cAjbcgrEh0ODAzWX16+tiF6p0v3HocgY06R5
	ZkpgVQjQ5e7womem1/fo6EcXA67u89q9U0UFVdRxwyAzSkXtvb4Wf
X-Received: by 2002:a05:6102:cd3:b0:4e2:ecd8:a27 with SMTP id ada2fe7eead31-5060cd85eb9mr4315520137.4.1754922161817;
        Mon, 11 Aug 2025 07:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkf0wesS+SmsO1zroWaYcVzGdW2MbxxsG794FhvDnHJ+rgmgrOMISGY1WD1WC3+A+gym4Dsw==
X-Received: by 2002:a05:6102:cd3:b0:4e2:ecd8:a27 with SMTP id ada2fe7eead31-5060cd85eb9mr4315484137.4.1754922161414;
        Mon, 11 Aug 2025 07:22:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac575sm4336851e87.69.2025.08.11.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:22:40 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:22:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] arm64: dts: qcom: sm8750-mtp: Add WiFi and
 Bluetooth
Message-ID: <l6u4y3suv3dpylexbiiznhcuyanlc4ouizhzj2cchblaf6o4wg@fe4laxrioaj5>
References: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: 02H9sMvbUYCo5bTNYF36mCpzpGjGFMTe
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899fcb3 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=TzfybVupH9i6CaRfqM8A:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX28C8xK0n8e6K
 GPEafu6V+hK0c0Kqf8fQp3sWVURViYCyyNqT24EycQZ09VW6AcjDPNR/Zc6x5PZJR14g0RXW4Cy
 qw8Iz/voioJDlYeTBRm6PAutdw8i1xNXqjXlD6L7prZ7TgjNSc3aoQW4H9hyfkr9vGfvw0beSmO
 ovYv5YSP5S10CZINyIHHf3oQ2NOl+uUr9Lksp1sziKMJ7U3r8Org/emmGPsJcN03dghRj8gGXyd
 6wlUB0VJeWkjEjfAW1Xj836uHtIiN0QiwrjpDh+zC40Op8Z47JlIQBQLt1jLYLu5WXjluLsz327
 JVVNg2FFnI2TCz+Scl0AccSBkoIVpAwZQPyaz/TIxbpAk1C6Cn7VRgKtw7u9lZ9KoNvybmgi+bq
 OHu8qx0d
X-Proofpoint-ORIG-GUID: 02H9sMvbUYCo5bTNYF36mCpzpGjGFMTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On Mon, Aug 11, 2025 at 03:10:56PM +0200, Krzysztof Kozlowski wrote:
> MTP8750 rev 2.0 (power grid v8) boards come as two different variants
> with different WiFi chips: WCN7850 and WCN786x.  WCN7850 is already
> supported by the kernel, but WCN786x is not.  Both of the board variants
> are considered newest revisions and the difference is only in MCN
> numbers and internal codenames.

Are they soldered on board, installed via add-on cards or installed via
M.2 slot?

Are they going to be somewhat compatible (e.g. on the BT side?)

> 
> Add WCN7850 WiFi and Bluetooth to the MTP8750, stating that this DTS
> represents the WCN7850 variant.  The S4D and S5F regulators should
> operate at 0.85 V, thus adjust lower constraint and regulator name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

-- 
With best wishes
Dmitry

