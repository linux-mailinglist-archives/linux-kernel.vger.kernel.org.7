Return-Path: <linux-kernel+bounces-828660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E6B951DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4992A75B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172863203AE;
	Tue, 23 Sep 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JrEuqHn3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3D31E893
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618240; cv=none; b=p9Iw25Ojx2muaA4Po69IStJ1SRMMxsYBuksA888juvEC6S4go3dLrCTHoQaD9nAL5rSN2/Dj3Z4hfnZbC4wI4uCBCipHLQvLa4EheW6k5HojllxwTN7olHkx2TMsiieq8+5G1s1ZTFsj2a9UrM/dWZ+wmv6hGfvzCERRf9y+Hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618240; c=relaxed/simple;
	bh=WrWLMRx1uW0ZzkhdUxfHbcyryPg2uXTamdK4SAh3z6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDAv9ihkImRNi/pufY6FkBceXRZ8NMUrBBlZEYO8Ds1FF7/KNVTJShDxz0fqtZlRaCDoy+54u7sOwzBMIof5wbMawSReEY2d8mbGghEIlswF9aZ0OgmihroCfh/t/eQxeT3xdfLXmhm9lcrmqrKxHFTJ55BUr8lccBQYSRiMmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrEuqHn3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8H6xC016023
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N9VvJiiEfuibCwd3WFX3PUUK
	4AoEriLzCqFcQqEJWTo=; b=JrEuqHn3/6Loax1achA80FK+eU7UAK/Ud72aUpM7
	9yT3MMY3Sz/AShAkhxdCK375zi/vZpaNL+eh2BpW5uRleNHFBzXbnBMnLsyu+6Om
	vXGyBTPNIBG0ty6XaS/nOwkjp44nLe6hj+LUOtrEQ2pppI9Zagvrw4MAmj0FtGCo
	j2Nv+lx8fpAUO/2DuoEvP9rFxmROOq1At0s65GteKcQdBQkg9E9s9KE8yQyLejV2
	i7ap2tuuKoU+w+uPaCNmUfihvLiVrQRFol+niSlvP50kMpGKCdY1qRKOo1zbyIEU
	bbVxTXwsoCuc5OqlFxe/SIJ5baElNRMvs4DZL+fW4PmUfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpds2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e45d71f05so107988376d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618237; x=1759223037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9VvJiiEfuibCwd3WFX3PUUK4AoEriLzCqFcQqEJWTo=;
        b=LWDPWbWQnj2xMvKPoZGKc/ZK3UqQaZWVDSiIo32fbSpctHx7kP2nJ3aFKrvBPA9bLh
         7UYw66YMKcEqyTca9lJm6eEmcQL9LB57RKhTzkUgEA7ZtADlJPB/KeCSVv2cF4CwpYi+
         6HGMQEbTEKqpCgc2heyodJr0PyaQf3DEfRM7BrEm0r6NR+7L9vFx3BSP/UZTvFlDTTdP
         N9lZchuYtgTqxD/yHpJv2lBLTxZiISBcRrBSwGmDDocMksdUtTFjY+KwI+Uutx2hottx
         Xf3TA5Te2isykHe5uvCFy3TLDvdc0yDEBeTkjWZ86ZhA/Oc1Hl6XTvYkGBGg2pppPl/K
         IsOg==
X-Forwarded-Encrypted: i=1; AJvYcCXbFXwyS5ZiC7v5CkfIRvws9s4EUuoAt8MS5OzPEF+0mHxQSsIj1ouWbw2J9YGTwWX4LgN3UHDELQZuSYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nF4NMSPvxukj1J256tDhIwFRkDQbiC2SMMEs47NeXtRQv/iT
	afDAUT89rFD1kXvyfVQ9mNxzSIPHyh9f1HRJQXcPhsAEeIXOvYByH0cTatgfybcnMpQSAIARe0h
	s4oKYcl6DO7Ldr0iuPKx8mc+hR2rVRB83vsmpN8qkX44RTQLU24N4O2roXe6aJxb2qR0=
X-Gm-Gg: ASbGnctd7S0re0IVDU+M/O442fiKrfUwYyhAqjmy9hQRYPAJzC11teH7uAOV5gTaXji
	gFiX9HKVFz2qDlBNQojgYZAget4J0+9H0tjKBzbl2wyPcndjhii75jSkTPwc4AJLxhA4Bg26e6G
	uVj5e0eMBKZU4PF53BdO7CTlBXQuo/G9UCDbIUNl3TYf6XObgpwbe6mfdzBmGTbADO93lorFHtz
	CoqQOY13q8TZ+iRQy48AaD1p7rozYJHKGM+J0mtOlOIv3oP81BJ5JM0L8n5tKDr98u0oi3UZZbD
	0DTvR8krLI8k46UgvjqSCd23ijOhNLz98ul+Y2lwhEIIUr7CR01YvkxEeqw5XGVht7oK8Qz6ReH
	8/b/iQn9Y6GI6maYVYNSrpbACSoygho2jP0ELnGwpo85D++ITaUAV
X-Received: by 2002:a05:6214:2129:b0:7ad:179b:6472 with SMTP id 6a1803df08f44-7e71bcbeb77mr20144316d6.53.1758618236556;
        Tue, 23 Sep 2025 02:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXtyN7kZQLjCpjvBStXoTFCJzTiR6gRbqkzv7uy9Rmgc2Siqdmrlmy6eFmsWYX/A81wP5zjQ==
X-Received: by 2002:a05:6214:2129:b0:7ad:179b:6472 with SMTP id 6a1803df08f44-7e71bcbeb77mr20143976d6.53.1758618236091;
        Tue, 23 Sep 2025 02:03:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b9592e6c3sm2402073e87.46.2025.09.23.02.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:03:55 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:03:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>, Pet.Weng@ite.com.tw,
        Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] drm/bridge: it6505: add INT status check while
 link auto training
Message-ID: <pzwwlv4epiy36t7k66ymhbcetyz47tzvx2kxwmbqzdn7kygori@gwwxchq52mkw>
References: <20250923-fix-link-training-v4-0-7c18f5d3891e@ite.com.tw>
 <20250923-fix-link-training-v4-2-7c18f5d3891e@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-fix-link-training-v4-2-7c18f5d3891e@ite.com.tw>
X-Proofpoint-ORIG-GUID: TiiBgksxExMW5KRpKeQ99iL7GwwSi5hc
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d2627e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=YJcEIqG2WBgLaOaGd_8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-GUID: TiiBgksxExMW5KRpKeQ99iL7GwwSi5hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXzEDxhe9SMIhw
 6oribyJiZEw95YTD2luJn8evGuVL9EgcCfIjTAjXXmv3aoKYMTuzBRd+Lkt2LeceNxzhZiPqXvf
 gRYxBxCSc7fARwNZAoqLlHBFoMcmIWE3hSXk7rXJw5Rd9mEvWubJdt8z9SP8tkQ81ELy2F/Oi1N
 JZxyEG8O+Z+q/wPRxiv27mZChC6RVPZ8vO4EhukkFrpNPhijO4IMbBJWYCj0IKpF8WTptMP+qcA
 Cnz5qvuiuqqAGHskGnGNXJ2lEfCespXA6aTFEmR79dezEAXKSptsMkVFk41zMwBjjMzjpwNbhkp
 WhXDQgZuw9Z7Ld0KGuV7AkE5wEDcuBrZbewboSu0kE4bI35UkMBUCFFY7EQSmSXTp3vQRWScWP2
 FmVtarN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Tue, Sep 23, 2025 at 02:23:42PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When start link training, interrupt status INT_LINK_TRAIN_FAIL can use to
> check link training fail and no need to wait until timeout.
> 
> it6505_irq_link_train_fail() remove from interrupt and no longer used.
> 
> IT6505 HW auto link training which will write DPCD and check training
> status automatically.
> 
> In the case that driver set link rate at 2.7G and HW fail to training,
> it will change link configuration and try 1.65G. And this will cause
> INT_VID_FIFO_ERROR triggered when link clock is changed.
> 
> When video error occurs, video logic is reset and link training restart,
> this will cause endless auto link training.
> 
> when start  link auto training, disable INT_VID_FIFO_ERROR to avoid loop
> and check INT_LINK_TRAIN_FAIL event to abort wait training done.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 38 ++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

