Return-Path: <linux-kernel+bounces-809359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6725B50C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0E4466FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51626B771;
	Wed, 10 Sep 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvutWUmn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB75243374
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476171; cv=none; b=nu7KJqcbYb6U/eFMwopMukQWva5bK3XS6kVKi/KpT6LtlXtTslsqamG3EomxIXcxuEVQ+7HcbuwWUCQz1jVEUDaZp4glJfU3WQvoU+lmK95UMo3D+DoM3pEkTDK8vxWuFwPyESDwFAax9u3rB5Kpz6KIRgZ97urUwW8+ymRaVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476171; c=relaxed/simple;
	bh=YBv0CW4QbT5Ix1E4QULXQ9Bl3KYGoXwI2sr7c1YlKVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIT8LkQkGWrX1wrXCSOLlvD8pCEnrCnUGf/YCnPs76IVv+CVkxve/MSQyIiCbEvZ8ZLlMxi6wVAlgzMo6k9Ad0ZX8Qkr/2T95w+mnYcA+Ym0w5Lfw2wkUdGOUXcgIlY1QqP5WKegccAEwnWLiNQ6rxUk9ZxFQnr75tQxUkkfDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvutWUmn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Hulbm020107
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jc+OrgV18zTR9+MeCEMWVPIQ
	oOTOsoNv5lyc0iyheDY=; b=RvutWUmnXniH9YLZ3AMy+wjZNJeA5TybiCsnfyqO
	utT5tGiXxakyy4B0AftdGXKCZ+cXNRIq4VnMaS1uDCvAv8gfP6F8ao05NhFVyR5W
	cMixFSnKAsgrEj+4bbi/d1Uf5OnBI5gQWdyDwJf7p1mcStBjTgyaKRfRFhklpAJ9
	iOTNusScYYLpaEYchbjyNXKqU91e57IuaI+yxZa6WAtRy51Rq+zO7BB7u83arObu
	63/ZljKeu+fcXJxX3RTVE6akCl2Wlc5G04VUKFcqNwgcIQW0gcvLgB9T/M0ljCI2
	pw0cBUoIKh6YTfpeaLFjJ7QQNoN/NlpQ27uFozQjsXHjfA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8aad7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:49:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-728f554de59so190381816d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 20:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757476168; x=1758080968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc+OrgV18zTR9+MeCEMWVPIQoOTOsoNv5lyc0iyheDY=;
        b=LSqVePRpAhori0msrdTF2+tcm6ka5gS2TmSmAlmpzNqHqKohpG3uBlD9xZ7Zdw6gJ8
         bxTVA9GW56XLyUPxP+EMz3tUoMAFbLDveGBF86fzjS1qEdM+awlnnwZjTizPCL3srODd
         ypqPs6X5jE2zje1CHRdR5zoMF+IKdPxX47kaY2hEBLfZYI451Riwrv4hyWX69BFA82Ru
         o6gI2h40tRYsqGR8TaYZEjRn0oLjB9KKNKPPJOZNj1+W2nuc/SKpP4ZfiZnAZHDnHVrf
         wmHrWZoBx+m3tKdXDnn1XLalBaBaXBN1PoUWkhJT/gtKvKa312eRhPRfzjYdHldqhP4W
         eE+g==
X-Forwarded-Encrypted: i=1; AJvYcCV/PeAkHd+GGtYNco93S1VoOkgnX/DeT9dumG8YFqQc3n8Wa/O+H01Ym0ESYNctSAHuDBILgHVn/y5unuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xwGAA3xUeHkjWKSBb9zS1SMqlddt5jAgGoEsiB9UOTMe0ZSv
	rlK9YTyWV5KblFgT9ke9z8abrU2KDHs7XbDIspCSP+NkqNkzeqvcov0wf+wCItxgO7U4IswugDK
	/0Ufl753Hjqp9A711ABCTX/wK0HiMzN0mesf8/wPiHDEoaLmdjYeF7HpDjaTXwzLiR7U=
X-Gm-Gg: ASbGncuplOWZ3dA8DZvayly4WiP7+WBxCfi+YYEnxdmmpi3vReAuv0A9vTVYvxr9s/p
	luBarlFxo+bIWmimRcG2EtIBDfYCWvGm33loB6VzZmArxy4dYupuNPfLuMAOze1idFcEHSDLOZC
	Z2OTz46bzfshu3BoKsbOMOSCk4iwuFUvtP1B721JoVpx22b0TZDrORd7O+EgtLzvoafPABHXY0J
	z6TVghu23TKrHFgre8SXT29ehuYHK2OsCgCZJ+qahF64qYZuxi/F7Ew8kYJLezZEaK6/38AOuwv
	hVxZz7F5AGKxbLcNq1xGBAmk1eJo10APhFztKMGgCeIqRkoKuDFEaeGNstUIReCBe/6ojc1sd9S
	sr1zG5ScOmIaLZGacrAsvlHqmX8oUNzLDiPgVJLCvmPeY2FOJmDMZ
X-Received: by 2002:a05:6214:cc4:b0:715:94ad:6acb with SMTP id 6a1803df08f44-7393ca9ac9emr142265996d6.42.1757476168165;
        Tue, 09 Sep 2025 20:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41GdM3QXQSMAuSTL1V5Hrzte1YNWgWub/X0ZUvpjvQT3VvLXj5jdJKN9BtiAgDBHFRBXV+A==
X-Received: by 2002:a05:6214:cc4:b0:715:94ad:6acb with SMTP id 6a1803df08f44-7393ca9ac9emr142265846d6.42.1757476167740;
        Tue, 09 Sep 2025 20:49:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032caasm44137561fa.35.2025.09.09.20.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:49:25 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:49:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4] remoteproc: qcom_q6v5_mss: support loading MBN file
 on msm8974
Message-ID: <ksnxdmxdxe2o3yffvpsxoyzqbqqsstiwkzudwxxv5nrd7ezkyp@7t67vswmkxu4>
References: <20250706-msm8974-fix-mss-v4-1-630907dbd898@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706-msm8974-fix-mss-v4-1-630907dbd898@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c0f549 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=OCLVXrEKwRfTRf4533IA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nIzNy5R_Xcbq5byGwC67Vv_oWXpPNpJP
X-Proofpoint-ORIG-GUID: nIzNy5R_Xcbq5byGwC67Vv_oWXpPNpJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXz2u06YLrA1m4
 hsJ9+ZiWhLbctRw7tKbyMHijq8g5jgTp4X1czyDLoNq2441tcwipkLXWqDN93Uj1ZSPp1J/rQaQ
 +7i7ae9Z6tGpZMeiatsb64m1jCpZQdKC3UdPqxZIPQM/CjdC44sjezvqxwIpAklwTQbqWAOAoyX
 7CyOIizfNE1NzA+OoshN/NKkei3ArklFuiCGKzXqvIIwmkgm/C7TgFWIDRJoscKZ9+Pi0eSx04k
 L/iNLkfGOreW2DQFLE+lmY7YMI3J53QnWxgXsfIgyBJCNfWEntZQtOORP3YHb8fdMr0I2qu7Jpg
 Ho4sh/XQThJ/rvu7ayKczPn4rJWJoJUCEQLdbELEWIhBv8p5eSNYNXG+WRRWj6r83443MWmssF+
 KpelAI0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Sun, Jul 06, 2025 at 05:47:08PM +0300, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> On MSM8974 / APQ8074, MSM8226 and MSM8926 the MSS requires loading raw
> MBA image instead of the ELF file. Skip the ELF headers if mba.mbn was
> specified as the firmware image.
> 
> Fixes: a5a4e02d083d ("remoteproc: qcom: Add support for parsing fw dt bindings")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v4:
> - Expanded to cover MSM8226 and MSM8926.
> - Link to v3: https://lore.kernel.org/r/20250706-msm8974-fix-mss-v3-1-8b5ae61c86a9@oss.qualcomm.com
> 
> Changes in v3:
> - Reverted back to the simple patch from v1
> - Added define for 0x1000 (Konrad)
> - Added MBA firmware size check
> - Corrected the Fixes tag to point to the commit adding firmware-name
>   support
> - Link to v2: https://lore.kernel.org/r/20230508153524.2371795-1-dmitry.baryshkov@linaro.org
> 
> Changes in v2:
> - Replace fixed offset 0x1000 with the value obtained from ELF headers
> - Implement ELF validity checks
> - Link to v1: https://lore.kernel.org/r/20230507172041.2320279-1-dmitry.baryshkov@linaro.org
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
And gracious ping...

-- 
With best wishes
Dmitry

