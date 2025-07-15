Return-Path: <linux-kernel+bounces-731789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDEB0598C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840CE7A05E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C22DE6ED;
	Tue, 15 Jul 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGtPvDSX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F062DCF5D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581052; cv=none; b=oEO0ddljPgb9dolKDjw7N4zpSPTkjl0AK2Iqp3WoNoCK49r2CskhIWBdf0B4Uek9+X7bWjNEqhdbHTPmHjb8AiJJhi+w13EZFsRv0Ta3BvrZjg5tv3K/i/Trv8Lun7V/h+NX/SO/SPH9qjAWieDckqIJEJF1w6APmxagWzVu7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581052; c=relaxed/simple;
	bh=YMGsUhwz2rH2kokdtX0WR7WKnNl++q2YDYKlHWw6jNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSsysDyCP/t5waigvZ9tLjsU0I9+NAN6p+4t6Q+nDkSFprwdlznlpY+3Wdfco/fzLFsRYa+bHAJoW4nZOtg+3P9kVxFvUKsyVYKotFR5BxNSlRlf0s1G11jG8K7bqsnzLD6ITLSC0Mvkq6x50OgHUBMvHbJcpMYPKWLfRUYQ8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGtPvDSX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F64Eh2022077
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uewLyWaWo+XEtP3pU1ovudoo
	X8FXuLSHNKA5wv9Jbhg=; b=dGtPvDSXLEiPdl3CHjLxdrhQbN0NwOq3l+YIPu4X
	hVkm5cNDxft1J4ab42X7iJgqqENQGeXEmEU36rxBCi6BDwLZa78Ii6TK61uWkNEL
	H9DGn7x5fOduOzuOz6Z+S7RbZg9o6LQUuDw4Ls0rRfeHx5bQtUWxnbt379YRfbHq
	1sTTyY7oPBz+I0nqX0ojmZx6Hu2sZ0QI4RiOHoUEHheUKrl//Rs/4oBAGA9QeeUf
	OYwVj54GmbV91u36r1i83vQGmmXpHhYf9guevfNPIWlzlr2Y0RBbxKAzx1cu8Wwq
	shVqwzuDNxs4w5lBq68BQGmYGhYB86tQV8LAGtiCgIoNXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpax70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:04:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5bb68b386so1604026185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752581049; x=1753185849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewLyWaWo+XEtP3pU1ovudooX8FXuLSHNKA5wv9Jbhg=;
        b=Lv0n9MLl4assYMCr4OJ1MscOotLU2rZMBnjuFMJmmUaELt6S1m7lJ1Va9AHaiu11ol
         bZHslno5rGcBKui+OgwvnIHtG5W51f1WBt/SJWEDWzlAIVHjrf//1aGR4v3WkPQx45fC
         fA1xxc3eubytBmJ5YLlwsr+IvFwxuBUEsacP4Krqe9kMWpbdhKcp4biX6QJF6vwCX/IP
         n3WjW74AZmZXk8SQLujkvTQqzgOZ2CAPXKzIq+cVlXJe+bG5gvzb0Sev/vt4O+bLnuCW
         dlab18xmo0L2QNArKVfpZ9lorIuI++Ai1/16B59P5zECOzG6e8+fowAOxhx01upvFKpu
         ckqg==
X-Forwarded-Encrypted: i=1; AJvYcCXOfCKcSGsuyUDlk4ZyJN2VwMWAo92MvPQlqY7+AzFNKO8q3IQiDZAX21aJBzQaN5r+naL1GlQRz6v5ZRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CRLz+iMj4XF7DiqwiKDG+f1kcp9ENAZDEpsVJbP10E+A7zIi
	g5gz67gsdpUv4aDgztOUfn9A3Kuq2O76ol4AE2rpJAgUuDDYj4uUIsAAKhZOTL+tyt1Xfknr/+L
	vkGO453P0n+1GvAqp+BUbQs8eh22kApxkmBFolvMHVfp9BEBqMoHG8YM2zRd+llxIPlI=
X-Gm-Gg: ASbGncuRrkroT/6dJjNS/ljWFjPh2tGfN8ReyA3cf1p9PMbEWRX8VxG21SuBlRHwsjl
	3QSSABmPWWuEcrKsfB1By9L8vODOSRvsppQIEdXPROTiUaTlxtvxB0hOgvvfIBQFvbVLgWKvS09
	sjaUAoKMGMMuWRW9sdJCDedpjfkwGF9UZBuNZZaKVoGo6tTNyPEXcKlZipLUlRpjOuzG70xk2a3
	JrpYGv7KA+QVyP8xrVZp1ykdqb3PKTIhvAtvhbzlK+jRCzlHbNUjwjsSa3fxpvOWfB9I+DOTicT
	1c3sp5MHwTjP+7KRmqCdXOBbocN6xWCMgjd3UYLxLoO+8KHMaKk/mfu9dRPsJMrrmCiCSOZ14Wu
	Bq6CMEQu3Sl2x4j9x+FjA8nZTMDxY0QDZyIYf8YdWx+Zb8RY5L9SZ
X-Received: by 2002:a05:620a:440a:b0:7e3:35dd:4829 with SMTP id af79cd13be357-7e335dd4ee6mr517583685a.46.1752581049161;
        Tue, 15 Jul 2025 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+QA3kcqdK27HrgZ41em40tegk2sEjV/HwigntzMPoVZCR1JNaYYEpmMQ+MrBS7T3eBGxTw==
X-Received: by 2002:a05:620a:440a:b0:7e3:35dd:4829 with SMTP id af79cd13be357-7e335dd4ee6mr517577685a.46.1752581048678;
        Tue, 15 Jul 2025 05:04:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbfcfsm2266306e87.40.2025.07.15.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:04:07 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:04:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Yubing Zhang <yubing.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Amit Sunil Dhamne <amitsd@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/5] dt-bindings: connector: Add displayport connector
 for hotplug notify
Message-ID: <r7b4y74lr5qwejkejquosaar75mthjvjfy4pp6bbl4pgte6cq4@n3gwjolsaw2j>
References: <20250715112456.101-1-kernel@airkyi.com>
 <20250715112456.101-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715112456.101-2-kernel@airkyi.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMCBTYWx0ZWRfX0gNpmk4GJ55w
 gPH4ipggfP0iXMBM579De08s60sPAFQhE0A3Fe8HLzohedCrCBjDrCwn8F4SI15JerLlSEuBALt
 pWAE5nP7ldlMka2nkzZavql5Ly1AGZJot3sULP23/Af5IFS2pTki4ObpD2fX225eiYpkJP3k//y
 jFuZY50cPHsaukC3lL96Bj+yXouvmiRobMOQM7A5GYpwfnHimfcQm1lt6C8aoPmwnU/li9/TZPU
 mb7HCqiY9HGkQidkUBcoP/wffrxtYGy5i5CdsaRGIcCGemwh0BoAPW20Z8fhY+ZnQFRNtmb0kDM
 vJECwAT88ccmmLL7/NZO1F7OAnCXZsWBjAiigAqF9uCtiR/YpGNzcLuq6KDN0+2xmJ1pVNR+4TP
 Eq9SvDF7dQ6am8KXBBIEoApgFTMU8flUtIsDMYS2LFIGecxg/9dgRWW58gxSvgLG41x6wbfo
X-Proofpoint-GUID: 6Ag8vRXxaiaPhIfhHxHgjFghglqLISqT
X-Proofpoint-ORIG-GUID: 6Ag8vRXxaiaPhIfhHxHgjFghglqLISqT
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687643ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=s8YR1HE3AAAA:8
 a=w3lZJLl83XfeLKIF-PIA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=932 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150110

On Tue, Jul 15, 2025 at 07:24:52PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The USB Type-C DisplayPort alternate mode driver will find
> "displayport" property for DRM hotplug event notify[0].
> 
> [0]: https://lore.kernel.org/all/20210817215201.795062-9-hdegoede@redhat.com/
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Please see how it was done on other platforms. For example, qualcomm
(both tcpm and pmic-glink) use port / endpoint to link to the DP PHY /
DP controller.

-- 
With best wishes
Dmitry

