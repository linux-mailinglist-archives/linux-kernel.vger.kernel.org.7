Return-Path: <linux-kernel+bounces-756229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1013B1B181
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F237AB7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360626A0F8;
	Tue,  5 Aug 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kLixXKiv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F31D416C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387621; cv=none; b=HtALeT75YjP4Z6hkUXgpz8cuVYYkGYcI6e/fx/H6A9M0eBLa4dD9YaWuGzdfpCs0L08JfFf25n1llY3pfFcQ3Eea8ZNO14Q2AIeNvjAUZrI/9sxeaYvGSo7wYdag8Pg0I0dxI17zNzSSAH9xTmk1lN4SggxkZO0/faNCeORlNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387621; c=relaxed/simple;
	bh=xHMmS79EOwNX1obgsyb4BRfFjPuIg0OMEA7/lejHYS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOcQpsNeTbGXx0sngdFW2au1YfglLt9YJ0Fo/z3VhyNPTaUpCnZGMZ72SmJIQZ/bJiZfu0mkpNiKGG0ahD4Fa2oWMfKxj9RYcm/6YRpsRCGvlRbJzTRTrjQQYuIrwnNC7bgllFXv7NUyRYo4CyB0m8m3kxt9Y+0fuLRX6CfXx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kLixXKiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757D2af003772
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 09:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6YWPtWFX3lxz3vDOMkYD5yx/
	64V35Kn7WOYr3KL9B5U=; b=kLixXKivEbIXqovRV+tfp5F6v5v1VfLTts5HGL3h
	E7gERMpO7CDcvPP9CzI/X0D4Ubdtd/qrbXtCuihA1Heh8VD+NfyJPTV1r5rHYBwa
	XcmpRIVo+tA9AfTbbrKMMCSkIxj04ktu67vqkCAokbEBntApFqhGPRYEeKEDeOoV
	BpxVSadjzqqXhnojVqnydYcNO17Uk4/E6HTpWHVD9ldRQk7+E4JFu1esk0yYZD/9
	0RkyS4wofxX4AeA29ysDYOBV0WzuKdDaWm5ChqaDB5w8xrRGwWMkSAhE3YYttloz
	UeXFJjIkRjEDhtgSUQ5Db49usgrFNdCLRzZ9f99eBX68pQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjracf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:53:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7073f820d42so123265336d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387616; x=1754992416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YWPtWFX3lxz3vDOMkYD5yx/64V35Kn7WOYr3KL9B5U=;
        b=Q+dN6+wkydlGBXgjP5Iaa0kKOWjtfPQJpk2kmdv4gGlkLtwNNvJoE5MYPkUPwsjMgk
         +uTtoiMWc7gfK65oYH0i3k6xDMbZgIt2OthSwT2w8M9kgWL5FGu7S2H8AxvZTUONpIFQ
         03w1UxkaQrfsYy21lsyg0dH5Gk4KcQZwNMqsZg1radN0SfI+Ys4YLvf1L+Lw6mqvgF4z
         CpllW12ONdPEs0IaRDa9B/dWLyxmw99i+/LxXLtvaHICn2F64ncP7vKVT+eh6HsA52tS
         Xg49ovU/X7MNvDN2AcaV8FtPFk3/W8V3qxFP+21rBcyPAncapIP3wOuQ28HbPk5UhWuv
         65Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmKatYNlp2lGgnflnXviU8DanXrT5ANyplGNia6q/i4+TPqrwTrUedJLCRnxIzMXqjDLuv5ffRzLe99w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQFkDESjFCLsPL/e08/7rdlqLFr7vy7lO1mtzXs7e4Vq/RKy3
	5g/NtOcDrlBtExWd45z7D9hQngFJC/i1ukDYJD1vR1aZo1YjI8eFca2AXoO4tdj8yUU5VYWL/p9
	6uSCy14bYED49iANutVcZ7M36413FbU2YXVk+xbZt8DMMtF+Wd+TAldh8dUkugBvNhrI=
X-Gm-Gg: ASbGnctm+XndHACGft+8MvIiN8afG3EZbMjuiCNIKPpRuqZ2xtGKJI8f6EftjZQJm/W
	gG78JYiIX1PLkkT4FPj11HcoDVBzflZdaSKghP3ABkg8NwvLK8kRxpP41IXGHV9a+sJW4dKcoKo
	UKXH9kdVrBREKPK/+TGxx8mVNrn56HV9/OJwN6YYP8pf3oS9hhMbuw99DX2vKh6HzitEXtTG+VE
	cn/LZzSmD1/ItoV6lIkJAXUyfLQKrUmapezP4Wle44VJmB9vpFXTpGskZQxcGQcAKRfS86mbLXB
	Kgl3igCIjqcbgOzuKRhic1xErSJUTF+7AZR6o6In8S+gbZds1hPw80ukQ6N1Kg1FjJmkGYqzD8r
	cIhMwcAQljLshWmR1v4lvPa5o6NK0BF6wzPgIUPs49hgtQAgjUsIV
X-Received: by 2002:a05:6214:ac4:b0:707:68f2:3275 with SMTP id 6a1803df08f44-7093670cbadmr173938936d6.24.1754387616075;
        Tue, 05 Aug 2025 02:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9JEfjsVXaezVAyd43S9MWYHyWsnb91oC1bbzdUBcv5zD2HV26tmbdacPK/T/W+n9iEvwA0Q==
X-Received: by 2002:a05:6214:ac4:b0:707:68f2:3275 with SMTP id 6a1803df08f44-7093670cbadmr173938696d6.24.1754387615571;
        Tue, 05 Aug 2025 02:53:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272963sm18810621fa.14.2025.08.05.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:53:34 -0700 (PDT)
Date: Tue, 5 Aug 2025 12:53:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mdt_loader: Allow empty section headers in
 mdt_header_valid()
Message-ID: <5hss454btv4w7n6yj2z5fsxufn35xgtjcc4dnaopjwul57bdag@w6qxobezqowq>
References: <cover.1754385120.git.dan.carpenter@linaro.org>
 <5d392867c81da4b667f61430d3aa7065f61b7096.1754385120.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d392867c81da4b667f61430d3aa7065f61b7096.1754385120.git.dan.carpenter@linaro.org>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6891d4a1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=s473dRPoAqI_VoMXqr8A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XESoSIsmKEnkktf3J_eSsajx22fViuWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2NiBTYWx0ZWRfXz5mp/uua7H1s
 /ki6l/c7DhTz4y7bBJGUD2WvvoDs8Dr6PnL1pO7f5lKnbshgSZ9Jz9jYAjpcJT5XtWomf1ebYG4
 czKvStucWQVS1JVnwOADPGgfPPEaGCjeWq0iVf9LfagiKqcC+V5InCxnTsF8Z8hRZMnDl/4Vyv7
 DZBIt88sfOfnEzp+d+0RkHR4oQUpz6zKgfy76By+PajgwZSNn1tDre3mmumZbJzWmakSV6CqOBa
 z1FRehzOjrib8x9FE/k7OFrQsuIGMlyV/ecw34usPeJC8GB9O6gsJ2ac3WfN+g//XUaHzSPmN+I
 RGtt/PRlfnw+AV3i/qtoT+8wfG6LoWJu9peHdnGue8JATFIhEEXxlfhLFICtioD9Y/tp+Tui0Nz
 8UCHAavtZ7noO7YEW2Tw/VG9hfRHKZ5DrlLt3YGwLja2ucugd+/Uqqo1ywfyHmoBaDBYaED1
X-Proofpoint-GUID: XESoSIsmKEnkktf3J_eSsajx22fViuWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=936 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050066

On Tue, Aug 05, 2025 at 12:29:00PM +0300, Dan Carpenter wrote:
> The mdt_header_valid() function checks all the members for the elf
> header to ensure that reading the firmware doesn't lead to a buffer
> overflow or an integer overflow.  However it has a bug, in that it
> doesn't allow for firmware with no section headers and this prevents
> the firmware from loading.
> 
> I know from bug reports that there are firmwares which have zero
> section headers, but the same logic applies to program headers.  An
> empty program header won't lead to a buffer overflow so it's safe to
> allow it.
> 
> Fixes: 9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()")
> Cc: stable@vger.kernel.org
> Reported-by: Val Packett <val@packett.cool>
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/soc/qcom/mdt_loader.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

There was a patch posted by Mukesh: [1]

[1] https://lore.kernel.org/linux-arm-msm/20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com/


-- 
With best wishes
Dmitry

