Return-Path: <linux-kernel+bounces-831661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23682B9D441
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7413BB082
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D42E6CC4;
	Thu, 25 Sep 2025 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYh8zZdb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4922E6112
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769172; cv=none; b=qtNRoh3wcWNrYlfRU4h90EU0oY+Ao1JdOek45zZV5QSypohfyBR3I+Ugca+43FauTLidVcxB3bQf3/UjRhX5bqUSuEjf7c2GqI1X1lGiVrxs79cIFTIRVl0+3tOE19aXVQaSytKFofTo9omymOU89snJrgjyx4XUy/GmI6b1qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769172; c=relaxed/simple;
	bh=gWp+RwukaHXXQOdYQ68gcT6pxRzuW8r0v6Od5sh551w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOWZ/OYz9mHpbYlnar5fyAZqBsSLigyA5XH7yvnZYEo2zy6R+wwhWogirMbwxgaUXa0KyTfN/RnDADOiJ/UH678rS0x/2kVs6n/VVC7OfTQbvJF7VqLPtwjmz6ktbNwCJm26jWJhu5wry1fFIXvnky7jnKNwsU2dMgx/WsanLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYh8zZdb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0lZuR025572
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KUkSZrEB+7wwDzk+xOPFFNAq
	wUcknZyQi2qYnntju00=; b=hYh8zZdbVDFXMYczFtJMbxYdsxLlUZcdvGF3pBgJ
	VR7KtARJOu4YQOfC6VikKMumYVzwdIQfAXqIrYakbSc0jkCWNRJojipltMVyPgTg
	osG/2z9n+wRlyhQetruurCd0mnSf2WQT0YTjZvJpa7AONpZKshCZAaGQICt6W3uX
	EhTgbjHo8rAaQ9iTzAqJSVRM84W5A4hhM+o3Zx/QMD0ko7uKGMwu3PSUgerlJi63
	WWqr6dMDDXP1ngLH6LL8KYVX4mkJ5PSTbUiZqt7/0veMGuYl7HHDYIDdU+ImTlsu
	T7PDZmOaymH96DLUmfUGpWhAhymH6W+soaoU4BdFsVf7uQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexu6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:59:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7e90f268f62so6807256d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769169; x=1759373969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUkSZrEB+7wwDzk+xOPFFNAqwUcknZyQi2qYnntju00=;
        b=uu9cQR/vlSqSQmiC27BuOuc3ke2TIyf9P6YLU0Fnl8F/Lr5tDRqX1Hlou/qKgcrH6Y
         OT85a+UDuWLqX8YEPiL6IMDTLc5X8timr+gQzW/XH5PHkQM//UJLxfqtLlmU6kpFLobY
         1TfA4uA03uGj+IJeRqJV5jh3Vj48vY0oVrzLOmb3WP2GypHbUI41wAa6HBYapyeXHqcP
         e2pkSf1SObvTCQvxF6PdyluFUbJo2szZpnPeuc3kGyQzHKpY87Vay5DIFm6D1o1FHw3P
         PIlxrD2OywLKeHKA96cW5vwBPBkEok7lPkncfyNw9jaFlonWebnddIsCyu70TaI/aCNq
         1y2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWTq0BNoSt+Vu9uKjEARjK4UH1t734rOTb1c5CIC7X6H+OOJ4ZE8pk65d2CFypQJ+uj/dASPxBzmtlQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/C6snG+Tb/uqnjn1t4BRmrzGqFMvXA0qUfddb4nqdspPeq1f
	QX5uDTYJK9Ec53/RfCv3WeEd8gCooEyAZjJ9BP2/UzDAcblrzkiem2V3IgUHpdMe7hE5nT9Yvhx
	vdQpDWOFtaudMVhRalK9fTwNWKHmnmPTxgTGks1h6xAAz0Rw8KL0OJqVJKcDzaTAR6Zc=
X-Gm-Gg: ASbGncvgqkZv0SMyqj5mv/I9ezBUEvpiuKHAVn4KWJeU8ndaj9H4NWIx3HAyQgVVagx
	sc7WYxh6mw/XA8P5oC93gvy1La21IUECCgxI/mosMffqjb8VUZfpRomPht5XoJeF9b+t7ajdcKM
	1+F8dor9MPwl4mngFVbVWWvTfWgFJD81OW79jaIw4Xuz8prtvFp7sWU7nv0oOVD8/S7oLZA9igF
	cL7YdjgsZ11OtI1xyD0fOfnuOHJ770DoqQ3zFGZrjIPntgS5X+95cCFRoLtsKtQM5gq66jzVHl8
	givourD3Mdl1jZeZK6bxXvwhUfL6SyCwyXBofEEyO+hMjNo2/MxfwFFaiWKrqvBXdInoepWPq2W
	TvjtxL9g9MY4tavxH9XW3J+nLQkopmp7ygz1JtDlEDz80FvM0Un82
X-Received: by 2002:ac8:57c9:0:b0:4b5:de80:10f0 with SMTP id d75a77b69052e-4da4dcc498dmr26474901cf.69.1758769169458;
        Wed, 24 Sep 2025 19:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbU2tPJev/yLAjKJPRsx1oGdBDYTwvY4oft/2UNElSiRbI6I5eMzUIs0+rpDewl6Pepf+DcQ==
X-Received: by 2002:ac8:57c9:0:b0:4b5:de80:10f0 with SMTP id d75a77b69052e-4da4dcc498dmr26474761cf.69.1758769169048;
        Wed, 24 Sep 2025 19:59:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561a9sm263826e87.74.2025.09.24.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:59:28 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:59:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Subject: Re: [PATCH 3/5] ASoC: qcom: sc8280xp: Add support for Kaanapali
Message-ID: <ru7km6vtbxwnoqtt2zf24si5envayqh7qy45mc5molevrgt5pv@g32atkcwqyan>
References: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
 <20250924-knp-audio-v1-3-5afa926b567c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-audio-v1-3-5afa926b567c@oss.qualcomm.com>
X-Proofpoint-GUID: zxvqOt7Un8YQWLuRVuz00FarPXWYygAy
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4b012 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4OgBFdbP32ImLjEHi4sA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX4WZ++90pLJM4
 JiiJZmtXUKicKfjUEihQye/dkprarVL8vde0Y7qND5Xhj+G3seamV5gVGccZwXB0e9SUo+2seVm
 kCeIwo5i3gVTFgtDkkG/NWnVly+hXMXZ2l+2bsDx7yrRpYCi0dUhOQ9HXiZ2Y3Xpoy6oaW3IMiZ
 g6SjpCTBfuEvWae8GGGBzeWg9kcpqVQ4ByzFCxPdQ437kLW0av8VKoJ8RlsUYhT8FjbS+cvmgHp
 vbPVqMOUdQdPl7S0cuf1Cycm/UuyjEcgi3l8J/W+JED86RDPgqRy6nf6KeSXPvfiOvz5BwM5I6j
 yjGE+JxFMsieZ7Y8PVEf/dH0GTSoFqUO+IN8S4cgrWKzVHdaE+VaIQqLAY95NiKNd9JPXmrPUe6
 bsp5oEFg
X-Proofpoint-ORIG-GUID: zxvqOt7Un8YQWLuRVuz00FarPXWYygAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Wed, Sep 24, 2025 at 05:01:17PM -0700, Jingyi Wang wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Add compatible for sound card on Qualcomm Kaanapali boards.
> 
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 288ccd7f8866..e231112175d9 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -198,6 +198,7 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
>  	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
>  	{.compatible = "qcom,sm8650-sndcard", "sm8650"},
>  	{.compatible = "qcom,sm8750-sndcard", "sm8750"},
> +	{.compatible = "qcom,kaanapali-sndcard", "kaanapali"},

sorting

>  	{}
>  };
>  
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

