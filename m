Return-Path: <linux-kernel+bounces-808428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC24B4FF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7881C24B73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070622A7E2;
	Tue,  9 Sep 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i90iwT/3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87334DCFE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428584; cv=none; b=Cm/Ez1HD245hk8id/b0sdh+F6/al+ehh74U2NDMjMu4wfuzVJtezT7Tb5UyrCNIGTg6jTOfD5N5/bNs+501BkkeC14YSjlDvBiqHjEBHQs10FITN8Znedz5kbd6jrM9wcGH1n9Rr8hRFOp2amMl0Gq1fgETWipkJzOaAUwxAbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428584; c=relaxed/simple;
	bh=j4FzMmoXD8KnnKWCCxb99YcZ8DatoQzx7/AfR5ZkKlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTeWKtvaBD6Gt/ZrmB631m0FjzJ5MPYkWCMWcCnX7WwhQDelenhyv/TxGRArWnN67il0s0Pg9G820wRqKKm1v0Ks6EVGdzqoJ05FdBn0BWB0E2CP+UMbJbYrAkV16YNJ6RPwBClqucfyO9vu2SOixWlfkGyxwvQ++suzo+6S25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i90iwT/3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LTVQ029178
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zXGegGJ48SCtTO4w0PCDokld7WbWJN8IL1FLEXJw6Qs=; b=i90iwT/3Lg15lvDO
	+hri2zsxcEqjOzAZ0dNzp6OusuJQuoQKWBDb1KWRd9w88Lm8SY1lDq8wIa+rQD4y
	oiOdvSoQuBbAt/AzRceXd00+w91Ez6MsljUDLN9AggtMb9BgtaASur2oj7zeA/8G
	Zyd9qdfz1g5fOP4lyCIMSr29WLTSfRowpvK80fEdAyiClC5yMRPH31dlyvYXi0c4
	Nq3cYiSYnHQllm450Yny+7ygiYWyo5lRKPSnMsFk1Kvs+GsVs4p/vl72GkOkrSiv
	K1/cUPOMN1KLqyYqxazY6wxU3j3Ihn6pJMn53cN8qPfSYT68lD0ET1R0hTa+2P4n
	8DMhEw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8ghvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:36:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-71ff3e1256cso137104486d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428581; x=1758033381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXGegGJ48SCtTO4w0PCDokld7WbWJN8IL1FLEXJw6Qs=;
        b=FbXsWgjHrfPpuan1sXIQPQhPgMhD5PG4th6WEpN2+2MfSKZpoYBGUcyQP2UUqYRhvo
         xFO8MMPcfujI+tDfSt5HYes0O+SwwOhOYl+2AwmsajHE7iyB3CjUh4pHJD2OCNri27Pg
         KhfUd8k4eTfvHOPfFqW+kriIgPoY/zcZfTvDNr/fdOK3dXHGD0qMBP2qcUlTuPOdQ1ZS
         RqHfchhOzaMfHn0Vw1uzRghAKgDtW412YshQD/rhRpNNdrbZh59GYnmyzN7++X14OatN
         W69IK/QWeG3xJgkONdm/41IMFiN2KqSjshIN5VKhgmpI76Oj3e19RiPTDu51y3/wR1jy
         +Xdw==
X-Forwarded-Encrypted: i=1; AJvYcCUNsaiE/VQVRGTTgIOytn6nwEk8d5z+EmLoyBRu9jfqrZF3J3GdzP8nmR16L1aWfz+fA+F44Mlw7CRaYDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPNbKAvOCo3XgOQXjkdKb4JXbnYNG9jcaddRa64NKvyhi89x+
	6z3MWKuJ/9x7faNt9+BspUPRaMm7MvsloRX2NcnfqolUm7iNPJPBXZGIDE32CEpY0j/AKXsptMW
	M/aX4XaYyhCl4T38lfh1SR8MJwhPuWgPKewlGFtD5BkUDeshp7FubgWlC0DKmvRcL1TA=
X-Gm-Gg: ASbGncv/cCiylK24cKJ10k0W9mXnnltSmYz4rjCeNjcfz2peNELbczd6qoij60Ze5TE
	4AlSA3y7GU8OdIHKkn37Ge1Obx6kaNyYhNnky657y26b4U23rGBuNH0hKMFMI/jwRfS5Q2mlXMo
	pFx+bI/4q3M6SP0gbPOYcMnuTlMn00ejfnW2qh7F2U7a3LTwJ5UHdsW+0A+JHNRn6ojtbC+eWCn
	SsYRaZxdp85OIzZqTAaYXcdbqXn5ot3DuUEv8IgxWAMeJtqvpwuepGC5SoQBz3F/2RRGrVh+CRg
	phossICm79YZCyWIZR9u93DeIA2aIVPHmTS3Qo320gIfiR9kIJseFDheMKm8ca6J4Max2ZwKz8L
	luLrCQZTZVot0yFDUdB5/rt3y0brPmByt8Nf+dEL1+bRO0VesWaRE
X-Received: by 2002:ad4:5cea:0:b0:721:2fac:ba84 with SMTP id 6a1803df08f44-7391bf469c7mr138686566d6.14.1757428579885;
        Tue, 09 Sep 2025 07:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF77zne3M2caVk1ttaE+RHTc/idA8A8JOQgAJqG37QNc5KMMVGPSFhdpJNJlTAki4xuMukecA==
X-Received: by 2002:ad4:5cea:0:b0:721:2fac:ba84 with SMTP id 6a1803df08f44-7391bf469c7mr138686186d6.14.1757428579379;
        Tue, 09 Sep 2025 07:36:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424708sm567120e87.8.2025.09.09.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:36:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>, Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ite-it6263: Support HDMI vendor specific infoframe
Date: Tue,  9 Sep 2025 17:36:14 +0300
Message-ID: <175742856369.1251022.15056942229474893550.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908-it6263-vendor-specific-infoframe-v2-1-3f2ebd9135ad@nxp.com>
References: <20250908-it6263-vendor-specific-infoframe-v2-1-3f2ebd9135ad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX5E5lGd5fwvjf
 Ot0Uxe026bHjb08jeHoOYfpXEmQ+GTYx8I/1l+xVtsh1DsDY+rb5HaKlXEJSZxjlG/Cwld7jz6F
 Cyk1kAys9NHQROsMAn7BIYRs597EkJ6yRmm9QFYcXiVhXuuAXC1/DzAMqum9DleuTsAS6gQHQ1k
 kEnRHJw3W7p0fn370pUI8ylP+ASsV6Tvgd1vMiF51ZOcBtIV9HHMBsSF8pfVdxlr+YDV/PmWhVN
 YObsXbObWMpvl4E+KxyhtNWuijrC0b+RMADqAqjLPQt9QWwn0T0gClyiPWel6ytQHh5rzlqW8ZR
 l0Evy5OGRcW7LyT1XL4pFM1uc7PVrrp0l9ceGiKq6liVV0Wcctcg/Kx/P+Hl/8okrdpOT4bHFWz
 he2htrwW
X-Proofpoint-ORIG-GUID: pd0QRIGFGLsUptI6aaOFn8pvtobdsqwE
X-Proofpoint-GUID: pd0QRIGFGLsUptI6aaOFn8pvtobdsqwE
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c03b65 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Rpg_6oIlysUL7RbACEAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Mon, 08 Sep 2025 14:05:48 +0800, Liu Ying wrote:
> IT6263 supports HDMI vendor specific infoframe.  The infoframe header
> and payload are configurable via NULL packet registers.  The infoframe
> is enabled and disabled via PKT_NULL_CTRL register.  Add the HDMI vendor
> specific infoframe support.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: ite-it6263: Support HDMI vendor specific infoframe
      commit: f50b969bafafb2810a07f376387350c4c0d72a21

Best regards,
-- 
With best wishes
Dmitry


