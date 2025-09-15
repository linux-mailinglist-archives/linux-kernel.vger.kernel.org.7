Return-Path: <linux-kernel+bounces-815980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CEB56DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76289189A0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C31B3935;
	Mon, 15 Sep 2025 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfsfyYJQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E12AE77
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899929; cv=none; b=tvgVAMfBHMs5vsaW8+Itu77k8nug0tPAznETna7hvWEgUsY5iQneO//euiJps+WCwjf/oFUhxJolSn1eqgxuXf73U7xZND20/fOFhZOBD/LzoDBTAyWMPtIOgEk6xA2QlaCHimoTUGSo4F8vRNt/YjwKKYCUgsIt3Ea/hfKGvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899929; c=relaxed/simple;
	bh=G9I03g1+B1kgdcsw9VpEBjxMKs5K7uTkt5sx8ds/htE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pka1KTsv/cs2MKijo8Bj66iPNxQyL3JrdZzh7QtuLoIkFitP590wDhaPA1PDw5B0Ff6rptX1e7s82hN3yRbgnhoJraMSrF4tganSOjxx3TCXZvJhfkvuumiChTDfx7YsvkIBlgxPwz/ZmdKucbjRXp5RGxyQR0G2V/gU9p78sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfsfyYJQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMWR6P022271
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L2NTX765/GLBc70cqhGhsWfR
	H7iv5feao/sj54eTvHs=; b=dfsfyYJQjQlGBQERRuhpyDMMSArymyJ2JVkJBosw
	FjmNwNQR4eaBvHz7ScxIjMDfdRvAiJKG3wuFDN3HbkU5XeYXXssw+nbE+HN2RdqM
	Rm0Q1oRAXLHHNvERyxwlY3X0NeaoAaZAsr7D11HjFkMQMh8SodDpc9BQCHXQ2M5X
	Qm9DfdBvKGIRWa9xigTLXvSjuEQuCK3VwJ33i2nXEVPxbmOJTA3St+Is0V7XxEEf
	F4+WEyquxlaJEqNpoc6me/osK1B6OLQCeQEv+VD/l2WKnYXqp8J6qFpPguc3b/Y2
	SEjX3b9eSLMXcGWDiY4zsyohPqwK4OV5TcWC5GkB93//Fw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv32n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:32:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b6019b13b2so144298261cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899926; x=1758504726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2NTX765/GLBc70cqhGhsWfRH7iv5feao/sj54eTvHs=;
        b=kfoFKISxYVJVzOrDBr+EYyk3q5iENuYqMkiE+QJH5F+puEBKxpZZBYp2XeNbqRobGJ
         6PHE/BoCDHwZLIwj0AZM/HmmbJkNuKs8rBQEnMsgAZldI4o+IBt8HkH4SJ13E/59sGu6
         cM3SIHmZTQpshMlkvMeP8CRtcO0PCexwq3RhE3qAhb/zIRfQWhyDhZ5lfPSqjEdxyOX8
         oEqgK2a4nEIqrARn0PHNLotH/O+ByVXchl6jGZhKe17XoY15BNq8O6yNDwUY/eqpYEWP
         lQurRsn8DsffqsiomwHyZz1xu0iQqcm6KrIG+ZLosQpDdnh9q/0l/Y77T0QjK7w36K1X
         MuBw==
X-Forwarded-Encrypted: i=1; AJvYcCWyOdluCX6XKtSV7e89k9mZzRdO2ZEyN29nQECoERZLUMrh166c8PSYFquoYQEU84FsYoqArTCp2+zSgfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrI1Zr8C3t//pArfuZLqs6FvWaf2ULz6Qnb/FbPHZ/Zb0E4+Rq
	zT1yMgp2yhV2mP+OsNdoVHkIIvyqvZDmyCNh/wfmvioCR48MJwFqidxiMtiKS5VdPymcIUCg5I7
	/gX1ShZx0qppUyQS5H2lvUWWGSWn44qkhIX/xxhVYpbfHknxWiT68zHt5J0fADfbEGIw=
X-Gm-Gg: ASbGncsaRo2Vomiutq4RtrhJ/5x+kRAOmGN0qaKxf93km0CunkE//dChupmeruXgZQL
	OiFUdI0ZoYsFWzyubxnBJTpe0D7uRWsbdltesKJep6haq95WIFSpILDbz9M3b+FMHhjSEhk75gx
	M64Ke6jV3knn8cZosyk0YuWYFS6+KIwlut85cNUJTjgtSX9/SZjJKsLOIDpflcy5lxyv8KHhYKI
	ngZCLVlmuXbFbwCf2ZtIWrIg4HYrpcW8DA9IM7MLY0APkiS4Yl5tbeSyVwg5dFY/9ewabPM1lcP
	jIWijfG/1RY0nFjfO1+ibUh4s4t/JV/CAJBGI7fe+YGwZ9dvYFbUtl7IPeixcOsKvJZj31dGz45
	V9+XM+Vg54IvhtYt4xxBBaz7dN0pTrL0kEasICsiP7ZzaoGKoX5jW
X-Received: by 2002:a05:622a:14d3:b0:4b5:e8f8:d79e with SMTP id d75a77b69052e-4b77d0c8413mr145136061cf.51.1757899925611;
        Sun, 14 Sep 2025 18:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRphhZ8pdE7c8/Iq9pK+oZ5EVGXoKWdHtWdfHe4OFvQoc76dVf/TqwAUi+N2fI3ngj4GnFQ==
X-Received: by 2002:a05:622a:14d3:b0:4b5:e8f8:d79e with SMTP id d75a77b69052e-4b77d0c8413mr145135801cf.51.1757899925198;
        Sun, 14 Sep 2025 18:32:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56ffcd4545csm2882855e87.140.2025.09.14.18.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:32:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:32:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dmitry.baryshkov@linaro.org, l.stach@pengutronix.de,
        dianders@chromium.org, m.szyprowski@samsung.com,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_clock_recovery_ok()
Message-ID: <q33wciy7eygu5kx4gtbj3h2vdoqnqzjhff2j2ksnpftxqbmst7@54uzyhw23qr5>
References: <20250911112756.4008435-1-damon.ding@rock-chips.com>
 <20250911112756.4008435-3-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112756.4008435-3-damon.ding@rock-chips.com>
X-Proofpoint-ORIG-GUID: T5P_WTtT2igksAnXljIRPEcWSqFD6qF0
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c76c96 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=GvRoZV4vhj9c5SIpLqEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: T5P_WTtT2igksAnXljIRPEcWSqFD6qF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfXwkSNB6DtqUAX
 FcxTWQtEfsgm1WMoktk8RIyePSnjxI/J2I5a5vTGq2+JAJTxmFt5H4Vrwo09/Vqorpks4e5eRBM
 bQRPA4j62vyoXvOOBInhgVUO81setiK16VihpPF8T8RkvZsoOEmLTPHm7cCFeAFilH+4shXsq3e
 gwEq074sNBvDOfCHG/PUhfR57SHKS6LFWW+y7oXj4gW4G/fccZcWwKEHBZV3L520nMl4aYjHyRW
 pB/WayNKNN62NGpkCc4Rttt6Mhi9seSGF/mndmAL0S3vBLU50KL/htzsvjBQrLaUnggb88hIyAa
 oNTsOoxGwvCXG6juQ+4TMyj9OYNuJOXN70QtyK4w0V8/27OMXPgUw/iC5uKoLc0bPGYzWjSOWoG
 WM5nAGZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029

On Thu, Sep 11, 2025 at 07:27:54PM +0800, Damon Ding wrote:
> Use existing DP helper API instead of analogix_dp_clock_recovery_ok()
> with the same function.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 20 +++----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

