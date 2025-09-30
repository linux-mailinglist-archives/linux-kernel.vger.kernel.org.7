Return-Path: <linux-kernel+bounces-838112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B6BAE773
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B94A3080
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458DB28724E;
	Tue, 30 Sep 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UI9gjTBo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BC267F58
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260962; cv=none; b=gLxDvRMCubo2TpvuDNf3wetvuQVrl8ssNTDd7nxYvhWfQsyES5+xP2CBPF4XH4LgDQqFk7hcQLwiV4/+ghwrxIkJmRqtCPSvTdV13sG81fa55zLK6ViCIXBjjHZMvmfFTOhVP1cRuJ4QDVknXZtLW3d2R5Xp7NXINUMWuBCTFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260962; c=relaxed/simple;
	bh=Y6ASMnKN0lRfzqLVf3QZa9bH1LtfrSUCRUokUivLfvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRKkeg/pOBcw2CXhv6Y1DPtrnlUdMHg3oekZ1QyWfTfFrsiIEpNMWbktWKlZGZ7yEBE7RFbRSzSEivZyZOYHq0s8wT8dJh8JpCPm9LeAFAyBtic77EyQQPISNfYWqrEXaHW2knCWUOxHiuX69swTnxPNMAdVGEM+uuoialUi+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UI9gjTBo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UCSUx6016964
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvj2v58WhaULcHhKfkj48JWEN5u/Hdq652Y2OxF3nx8=; b=UI9gjTBoXPG5FqK1
	i9EZzEPIBe4cEDqnrdysIx8PJIqOevx3NoJXnRjIohzIMMjafGjLtNHMiLg2OvlX
	ObpiXVh4VE0LWHyv8MoHsBIjRg0HQUmyq/8WNkm/g1XOpnRadVt3vOwQzhhby6GX
	1NzgDujWs3kbAf2Qujma3/qNDL+F2J+ewQ+Jj4tF/z4LrsE3wwUPr9gp3ygQxrAw
	bv5RiBOk+ykEygkPA5yiaOpanR4I5pQPeycLkrYvSOLCDRuNTeNf34pqtSkiRQMA
	bZuN53R8YM7jKqSzZHHAtKkPz+8YRflLot4cgYN0DfSBad/6LsCznUoSGrGK3bDb
	uB/Tug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hhykb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:36:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e0e7caf22eso76145711cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260959; x=1759865759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvj2v58WhaULcHhKfkj48JWEN5u/Hdq652Y2OxF3nx8=;
        b=BFn/0Yhf1tDgZAMRzQ6m7ZYA2jge7lf3glcttFrhsvAYk9OrMjPyaP8tNC2i+dlgbV
         2UpUQoRSJOmW1eRU7zWni9Wey8nfpaqXuHGuQBtNgHkcpfxsod57g5vRuojsnPdI6aqP
         fAVwzeUVTyzH/KwHfSvb7WjxTXSo/nlUtgElaAgn1oRriiggTv6iNJqQTVpuS43qaQJZ
         dJ/j2iAdQYeHROwdQIyqOVItjW6r4XZggYAvI6H2DIRARylwesADS5yyO9NCcaddmRKN
         5S+kXcGeVnvkVQ1NhuK0kHwGN/BlxtjOFFtQQKqLRjcOf8MM+hyjW5usQoWD44mSNWT1
         VkBA==
X-Forwarded-Encrypted: i=1; AJvYcCVLpGU9IgHDcYagtktYu7RbfpS7JmPEvsi7Qff3kdRe5iPc9eeRneImi96B2DpwZDmplOPMxQ6BFJc3nRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNE8xR0qeFuRc9KrV6VbZRA9i4EFlZSJpSlxWvrB85nJ674jiD
	cJRec73SiLJLPCgxOsiIWDvp0D74tx+Cx4O8xtrOhmbIiAnWJnKwyl/8lhiL6u3YPmIHxMt9Ot+
	KEUsg8syRWX9rnqdMjEfbYwFtXSjqcKr3j40RY2hgzSghwJ7Mmq1lhUYPmbkuYgghhK8=
X-Gm-Gg: ASbGnctodFMoOo1/5uIIHABata+4zbAq11rBzZYwDGYkoOBxmA/Y1D7oHjYvQiTuffp
	z6qq81Hk35TGWuMR7kgWakWU60vQvCWkZcsTHCrLt1yYCx02p4dvts3QY+u8UfTRqL6jm5+EZSo
	4LK7wuJorZ+pz0NG3T6CgcoLW+NWSvhIHDHioow2tar+XuzR0WPkeIkkOrFpuVpTLLNUYTsBQc5
	N2ESKvMG5UZmEedfbURhad/AvImMKoSHZNAZL67Rkq3MYaYQPHN6URXUmwOV3GRXzXmCj4t8f5x
	mU4YadOtNtIsoEPdqLomUj6pLxxqW9uCOxYTl4Svzz9lrTl36kj04FhBkh80XhhhIxBV504+8oO
	YnMB4lbV8/t8kvMYqQhzn7teeoP/znXuxklpFyE80g2+1J7qvUHJ8FEUHfw==
X-Received: by 2002:ac8:5810:0:b0:4e0:76b7:35d5 with SMTP id d75a77b69052e-4e41c733499mr10629231cf.33.1759260958631;
        Tue, 30 Sep 2025 12:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkNxeFgWyXeWrWIAptA6yK8icuvlqTlnU99wi9RboNE56Zpsc59WiRM39V19vXyZGsqKMtwg==
X-Received: by 2002:ac8:5810:0:b0:4e0:76b7:35d5 with SMTP id d75a77b69052e-4e41c733499mr10628561cf.33.1759260957894;
        Tue, 30 Sep 2025 12:35:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58737e32f5csm2282387e87.0.2025.09.30.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:35:56 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:35:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 7/8] gpu/drm: panel: add Samsung LTL106HL02 MIPI DSI
 panel driver
Message-ID: <rcx3hpufjmrpzp6tgl75qq5rmk3bcxa6dahl2egpgubu75bpa7@bouekp54w2gh>
References: <20250929142455.24883-1-clamor95@gmail.com>
 <20250929142455.24883-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929142455.24883-8-clamor95@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX1vWvAtdoa4ld
 pIPaxmomdFvtBNEek0jodT5uEYLkN1SS7rD7ekwlf8rhDEAh7jW2jb8ZkuFb+fbgF/+xGR3ceOy
 7uERed3ArXuNgf1RoLrT45d/fohnikul6x4/k+E2ur3sudbZez41YLOomcduoCM0Kj05OAw85V+
 UFvClJ9SARDmiAxKparUIZORotytEh0Z+9UleioQ+ZltJOjZsp7nJ2beVbWOPMR0HgDqGWx5x1h
 dwzwxHLCGuv/tp/9Ahe6HQNjX6X5kaoD8SQeB269OSxyCDLocpgkOkNPL1IWuNUVE+uv/E2+LL2
 YWmvtHcQrmYegzsigg3JvCZutYFWT7eQA9axRPjmy2CxMxkJiL/7hmqOk7kZpyp+azHm3U94zkj
 3wAnVje95Rb2nd/MjjMfbASTGHS/LA==
X-Proofpoint-GUID: sj1VkncxKkv7ahKA5TWBRQKJtNFMpwYT
X-Proofpoint-ORIG-GUID: sj1VkncxKkv7ahKA5TWBRQKJtNFMpwYT
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dc3120 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=sfOm8-O8AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=r3kgLuTu-6ezLa8AVuoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Mon, Sep 29, 2025 at 05:24:53PM +0300, Svyatoslav Ryhel wrote:
> From: Anton Bambura <jenneron@protonmail.com>
> 
> LTL106HL02 is a color active matrix TFT (Thin Film Transistor) liquid
> crystal display (LCD) that uses amorphous silicon TFT as switching
> devices. This model is composed of a TFT LCD panel, a driver circuit and a
> backlight unit. The resolution of a 10.6" contains 1920 x 1080 pixels and
> can display up to 16,8M color with wide viewing angle.
> 
> Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  13 ++
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-samsung-ltl106hl02.c  | 179 ++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-ltl106hl02.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

