Return-Path: <linux-kernel+bounces-779551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF608B2F586
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6612AAA7D54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB23054F0;
	Thu, 21 Aug 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dovp1mlP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C52DA767
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772715; cv=none; b=r3QdG5G+CjzlMZPbji/mXyL7aJHheZjla6lvxd7TonCDfmCy10Q9ah6Y1z6lfS7QA4mqwUIU86iOOcIBAIdYZT1crrkxNzY5Q4jRbtxCGrsa9WpYfqx3QmRQWENi3FYGAGPPgXJIW7+PvS4Ah8HsUWS++1X+rEdvcl61qBW1T90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772715; c=relaxed/simple;
	bh=dhc4I/MlWDeDvIuwX9I961QDfZaUtY9V9+5sP5hirYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acrlWE6/yce/QqYm8yVZRTxupsyDWyMV+P6rqwgmE8W7vUD04vy7pKqTlLLHSZXZBzx/uAadGpbSiJfmpafqvrh+PNLRkwkSXegYAsY8/Zn98CgIL688Tkn365Zi/k6zt7iyV1b2d3RusmXSHqQ4vX+K2iVTupJZ7DCzQ/MzLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dovp1mlP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b89s012775
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y7XbYhx/DiCJXD+gTIWE345l
	Gfy4pmmZ548BXwvRUTw=; b=dovp1mlPD4cNC3Eo8I/3/JPFWxnwtWzuHGFzGReP
	4yyMfStnGYB3KLM7sDMU1HunVcfcMIzh2RZ4oyV/cskgigggwyUwHrMydSrHgkxh
	FJZIQqENn6Pjn3XbOHVAu17QlENfPWJi77lyChxH3/Phz1BsXmSdztv9o5G7aWMP
	xqRaeBENaXCEKMYGiOeYLlhf81jEXPQsaV2an+8y2gWsvt/7ulINBK/QYNnPAQKV
	7Y6JMAGQFOV8XVW9wdorUH4025hY3ldFNtJkjR9kykEeaaSeXwPwwm87LR2wwu/p
	DMir5IvSKTxNdy101S8J+UMNu0C8Ce7xGjrah8wI4SRDfw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8avv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:38:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d93f579ceso541466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772712; x=1756377512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7XbYhx/DiCJXD+gTIWE345lGfy4pmmZ548BXwvRUTw=;
        b=qlkmitNvAXL4Lc14KZ9vTS5MmL5qViwhv6ZXfpRI4qhtFrrjusJMDMnIuieEMlnVIZ
         FB3cxaq56p2PlZ92NHgZJrpRhdlvYOeSz0lA5Fmi0Mx0Kmk2osm5gwwFNGOUo8Mc0s9q
         xz4Bysjxqbovdnd/qpS3y/trjqkz6iB8TfqxdOTg3Gv2Moiy27jN8h68bWNDFn0LQsOo
         giYWUUovPvF5wlqCsv33y+EOcZJBRA56fSVP49sEiFLNyvH3YdPpIYRhiHP6AUGyLaLm
         cWAouixm9xp/40MDzAJHCHMl7qRwikr4LuRu4+OZRdMlK1cI8FnNbMGbVZtHXJsVG6y+
         E/gA==
X-Forwarded-Encrypted: i=1; AJvYcCXlMbhUcaXcvXuRbYDXjdFkZXJjmgqLkGMRUPBYC98gWHziNVKIr4xYo1jtFmgiYRWokhF579YUqtfNLvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuskS5f4yCpOicpiCSUCLeVzNCraCwn0NvEIBDENQt18bKIpP
	u/U0aNN5Gpu8Kgo0v6me8b7Voa/EMHy8lnZRjgTDJNWBGafIEPXcVlfSm1z4T81b+Cw1VD+722n
	F3QErpX16fQJUQ/7uJlUfgqYeY40gml7ANvKeGi31YN+U1w7VcsulDK5deD9ar5+SS+A=
X-Gm-Gg: ASbGncud8ivAXUbLNRaFztsTAqxwCu0fnF2P0wTfOj+TSe6QIycgEC62os2bwQOaqzs
	oahC6tCrbqATdD1duZSp0G+FeoU7vTbY7qv+UiAw4sY+4JbglkWu+qK8nXLtCoESxaPV+2Tpa6T
	WSDlxv7zC/OodOAKFlMxwbwBWK2Xjl/lAa9gfC4OjEAh6zyVam3ywI6ptwkHQngjmRorwWJ+nAW
	q2i8SwXIVGi1k4CqoKYXP0E6fTlogNZ/QbcSTbpQaQuMEzwtzWa16eVwDNZZXElpQK6U3aBon0z
	9d8dJsXigAsbiIRAF4jVOLdAcrS9Y6Z6h8xfzZD4W1ibintnr2s1wIpiN+aNPb/0tVGjTL+1P1Z
	C7ArFlCSBz0Gve0osT8b+wI/Xc6jMDZVMUs1ZLpXnUwEpQ8EjU9Tt
X-Received: by 2002:ad4:5bac:0:b0:709:e65a:8ace with SMTP id 6a1803df08f44-70d88fc9219mr15034176d6.46.1755772712234;
        Thu, 21 Aug 2025 03:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH61ZKpxI75vebq18AslDQxb4qNuADPe87MuwfCz6Y1lEvwAi3O2ArZrJrJVYNRQ/jcIemWHw==
X-Received: by 2002:ad4:5bac:0:b0:709:e65a:8ace with SMTP id 6a1803df08f44-70d88fc9219mr15033976d6.46.1755772711837;
        Thu, 21 Aug 2025 03:38:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a6045b3sm34241381fa.39.2025.08.21.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:38:29 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:38:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: milos: Constify 'struct qcom_cc_desc'
Message-ID: <dv63p6laidz7aj4ruk347jqboqoiyekddgzqc7xb7n4ppvjkwy@rzdhicxf7phb>
References: <20250820124821.149141-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820124821.149141-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX6EaB9huPeVed
 PWxmv8Tz7NAPJzlejJPQc9J7TJl7wdnzVHxEAQ0KF4vXAKZCqHEdtN5jaT7oekwMZ4r9yPWgw2z
 05VIuEhhBStU1ZrAPKy1nXhUg9TBCBmBmwzHNoqOkKr62D4msRCpImlPweIgDs8HF1J0FQ6JAf+
 iM3dDL9q/NSDEcm4hhgIRhrqKTp9ihF5twjAmDQybBpmPfvQCLNqTUvGUGzjkxXD5f5bLoX3D/y
 GnxkIId4dkW1uap2Iix2fVD340AIKQdG5L2ONlZskx4imKWA9PCiOw5H4CW4sMph3CLFjHRrFSL
 0TbNxseRfcfs/hi4I3r0zgegCedpo/Yp4YInesZhWMMlp9yoaZe8+sMc7S+cfgQg7zDDWUiav2t
 VPzFcrZ72aJmdVfW9JFkQf3oa4z5zw==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a6f729 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LBVU2G7aICa-vlctToYA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OwYYOwHjzrVgCeoUctc9E5VvQti1VdUU
X-Proofpoint-ORIG-GUID: OwYYOwHjzrVgCeoUctc9E5VvQti1VdUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

On Wed, Aug 20, 2025 at 02:48:22PM +0200, Krzysztof Kozlowski wrote:
> 'struct qcom_cc_desc' is passed to qcom_cc_map() and
> qcom_cc_really_probe() only as pointer to const, so make the memory
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> My standard commit... I just keep repeating the same over and over
> again.
> ---
>  drivers/clk/qcom/camcc-milos.c   | 2 +-
>  drivers/clk/qcom/dispcc-milos.c  | 2 +-
>  drivers/clk/qcom/videocc-milos.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

