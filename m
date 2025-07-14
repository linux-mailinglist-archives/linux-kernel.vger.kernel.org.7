Return-Path: <linux-kernel+bounces-730841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887AB04ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58E04A4AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DAE243968;
	Mon, 14 Jul 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLnbG/TV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61922F152
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532425; cv=none; b=YeH0Ofbfob2kdVWnltSisHJ7jCcj9SPX3qir+AopvEdDhEkaPODYrt3mU3Ywa7kMAPPgt/oxhowajmOZrbgLbgimIb9ijzH3BKetQLCTErdZRbL2NnL6cjfbfGAi8fth22PPjUoLDKRbL8nlGuKkUURPE8hzLsI0LTPMsU5L5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532425; c=relaxed/simple;
	bh=bunis5LfXrPX5VTCd+1M7mKLIy9OUoNx+GoYz1o1G4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohbpCGds7to6bpfO0up2rm2lfDmNYOZ70X0absLJKG+M0wRBH3DL9fvebq6vxqqnzxr06L1iig36nNssJNEv+t5OWw8MvUAQ+xGi5vzw1vjtkjGEtoYHhn+yi7JC4jdv7MSAmTkyFG6mEIZGfFxgAueAFaLppw/qbM57aWwFOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLnbG/TV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EHbnnO027032
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jin39v5RU2OC6taZwVEep++H4MP+V5H7HkCH2SULjQw=; b=cLnbG/TVb7wqSU9v
	zXIC8UP2dgJsrBQ/B49OUI5+PtwnNpBuqPs7LZhg2O42Jmd6A5PxQw/dh/SgKwIK
	EzxjQqEWQRmCdeUQFQHRPpkwOCxY4f4rXXUTe31S63/hhRRkKLWIKjFeAoW1IYUe
	VTohsGPvpiI51AuRT5/LwE4T/NbaSkfokgp8/Pgadh9/CNNOKetIbDQf7wWyq8Tu
	5phMJwzNcqPQV7F/zdmW7gUKxPcm9lXFrY0cB1IfKmQ/iOvEKpx1CnImyFgedVEU
	ONa83X4bOFlrR9FXvS9Xgr1nrLa9HgxCtFlv94cLsUbt14wEBqu0s9+Sqpdour2l
	pcPwew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmxd12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e1aeab456cso253934485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532421; x=1753137221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jin39v5RU2OC6taZwVEep++H4MP+V5H7HkCH2SULjQw=;
        b=hWlL5HeNYbW42YkwB/FqcN4Tbk4WmYy/kyOVO1hm4uApBhEs3kl8d0SuAbahulhxvr
         cZs8hVDuS9WFrNWXuVJGOatDdGDSDYryZsuBkUBQ434570TK3a5wvFSUVQhgkon9M4pK
         u78QSaOUYsVgxQ5fDBgBjvow2qRjF8sI+D9Ws0eaKWrT3P/2tfv9g4IjBRZbfZzvVW3t
         b8o+auB3WDUkLJubGa2QTA+zgDoOQeJ0KjmDzLW4nHP8bkokZGjRQWen0hVlO5pZZ67t
         xF09g/metnQFoABrElRAjwMoMouGgdgVAIxe+Iqdy2nnBc/VBrJb/uy37JEBHYHgkoaC
         LXpw==
X-Forwarded-Encrypted: i=1; AJvYcCVsF9R5INYUnJnZi1+f+DP5TRqHs11pPClVT8tOJ2KrmgQvIDgqwHyuZGRs9HY+itxIauwzD0tyNzychCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza75PVRO+XWcqJObgMhs/Ge8shnbI9CcPn+5szdvdplcJedl2x
	Yj3hA/Hk4n+JzgEntbRCOT86UzRT7uAXRK2pKszo54HUznYFJKlRzC3e3r0eTA+M83Fn+AsiknZ
	UHNAYPPSMJS2h/h9EyEv0GL0a3nSHz5HdTYqJv26I48EHeZU8I50I+strZEyo1jb9CUU=
X-Gm-Gg: ASbGncuNkNimKUvqlx4OwV1M18Vfdsi6rJ6XFwbfmRCuVrxo0h7NFRcztOynT9y5ea4
	G7iWLmhWMCCUArnYqDUUScNqhBF2CXcc3DQzLcnMz6PE7lJ6kWKe8DsF1gdjc89rrQ1GAWK2jWG
	ZYOpoCYWc9CygQrxg+AsZYAurvhCDweY7DQITxhqXeZzNmldEEikcZl09BeiOZOohE8SnZtg19Z
	IhQMDJ9UFddn042X0mX2QxiUIw5XIkbfaYTtv8CIiS1tNuYoveJUZcFmkDcNrvY6A3Q+NlkEl6w
	XyW9LHZaSXtpy52zybjyfqx8LLtaQElnKd7pUGODyx6AuutXwpcQrNb1HT6xqVCcI458IGoaNqm
	ScY6S+aaSX2t3IDRUaGGHDqO3ZX3SNghVUG1bAHiuzUx9BUyBUGP0
X-Received: by 2002:a05:620a:472c:b0:7d7:891:83f with SMTP id af79cd13be357-7e338d264c6mr102022885a.50.1752532420665;
        Mon, 14 Jul 2025 15:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCqBgY+159Vec1cfE9dZ+u3XhxSpLqUZeIaerPTNko5JEPCLrdG5Wtqgg6IXPtXcsQrNQU6A==
X-Received: by 2002:a05:620a:472c:b0:7d7:891:83f with SMTP id af79cd13be357-7e338d264c6mr102017785a.50.1752532420066;
        Mon, 14 Jul 2025 15:33:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2930e70sm17078441fa.33.2025.07.14.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:33:39 -0700 (PDT)
Date: Tue, 15 Jul 2025 01:33:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dale Whinham <daleyo@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?B?SsOpcsO0bWU=?= de Bretagne <jerome.debretagne@gmail.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9 RFC] dt-bindings: wireless: ath12k: Add
 disable-rfkill property
Message-ID: <prrra3lon2p4pugkgeytf5ow5wls62lfdnwcdykztw3qzwity2@d26aqh6wdyln>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-8-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714173554.14223-8-daleyo@gmail.com>
X-Proofpoint-GUID: vr5NXYqkVCNJB9jbdyZPT2wkHol1g6lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1NyBTYWx0ZWRfX75JTtfXdxrWD
 iH9fqXXUJ1OXEsBFsqWA6NKEVeUr0O/p5GYJlMev3rV5ut+p0goo/pWBzhbicBPDobLRTedS+Ns
 icU8h1/MzIWlv/lg8vKGH+J717dtP+WlXw9L4onUumUUgO1b0tlgpa8tJXF6XqfyJgKn7ksHb1O
 SY2Pt/RZSiGvFAA8rfOc2e788sZN/WJaHIMV+KanY75VDCxatWijPvAoAv59FNcrwoNe7pP8ZNi
 fAzTfiruCaITEjqveZSwoTZp8+qJCsHBRHqLR3lUa9xVN3zpd9QkRxDV7PyuvFm4rjjLBniexhM
 2Y1R+7X7B/D6xi/2dUJ1jvFQaWZei8PASygvqBNpapT1yfOOiFxBmGZpKiVipaPDRnMmmCQZ1R5
 tE3NzzSHwT4MBEv0ZZ824PYngynvIF1tYTcoQYkEmBUpqP4ZQ2AYFCWLygeELpNKA2Jlzyh3
X-Proofpoint-ORIG-GUID: vr5NXYqkVCNJB9jbdyZPT2wkHol1g6lx
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=687585c6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=g818jjc2pSN6WLbPb0IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140157

On Mon, Jul 14, 2025 at 06:35:43PM +0100, Dale Whinham wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Document the disable-rfkill property.

Why? What does it mean? Why are you describing Linux driver firmware in
the DT?

> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> index 9e557cb838c7..f15b630fb034 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> @@ -48,6 +48,9 @@ properties:
>    vddpcie1p8-supply:
>      description: VDD_PCIE_1P8 supply regulator handle
>  
> +  disable-rfkill:
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

