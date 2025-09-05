Return-Path: <linux-kernel+bounces-803329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A51B45DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55CC3B036D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1643302162;
	Fri,  5 Sep 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaZMVkxR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7932C0274
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088881; cv=none; b=PAFQPWzSRpf7VhqCXh5XQpYI5eNJJH5ggbvdfpSwubTE/6jpJr2c8a8KFqZ6r/1v3ld/punrxu2Z9JcyYBiBBaeYNRA5u+vtBO/N6MAhBy36ZH7gk7M2rtbaht1Ie7cOax44C959fij9lT6BQMn+Dxg131F77fnGqAfEkglEad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088881; c=relaxed/simple;
	bh=QzQU6X3d7uC2WCQBqpeq3Z9QU13w7Y+ipPzD8W6kKso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0TWO9d68vKzYVb5To9oBDih6a9RSGJt3+9pIDBqDx2NiMzMesBAMdtooeURYzbt+yeBMbFEoJEACV3QVazrk1NgVn2MNv++AJEp91z4o/lXPfSBxuV72CzM5z2KYwibaTOvsejLNPqTJ8MI/rOZMH3h5Di5e0BROWqyfiBg8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaZMVkxR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585G9WGG005051
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4uwzJLV0wZH0OwJa1YLvQG99
	I8WF7++RUAwFDj4AzKo=; b=BaZMVkxR8r1DNF/+8QLZHIMpFQhxY8xYFoKWrYHV
	NgHslzkeqfqTzesQZjsFxoMm6i2vT2ZdO2ArCiXlF3Qpz+gYsO3ZljAd4efBEYFj
	xwiTwSDFdL7ftH9yjOhDYgsB7T6CfAAJVIBznI8H8Ao1su8A3+ZTd5tYeNv1kyEN
	1ouYZhAPFJ9Cf5JGpZVPtwetmQzbl3VWVOJe7mZ1wVPCN33J9zaZwwJKmoYQlPO5
	L6c9APEnr8YNTCIqg5cKqo7tuzAwtC/DyaMWATDasOBQRYSpf5LE3o2UDk7wfLvD
	HT8NXpmF/4o39ySa68++vhUvIgC79s5KJ/I8jO54pkSqHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbu2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:14:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b339e7d107so59813601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088877; x=1757693677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uwzJLV0wZH0OwJa1YLvQG99I8WF7++RUAwFDj4AzKo=;
        b=m80RMdJ/I/qFLRmeZHYOvozp/7ng8oxfPUus015kdMP0yjTPrXa8jtq0VOamPGbY5+
         8qCsTdmPvFmx629xh1bpjh6ltytUGpHqlrO+ONDlhqKsJd6JVSFoJKyQielDo++Wb2DO
         7y4N9HryFNVF4KDicT6BpXr4HH+o+y7dJDblpn/19O0Okc81VyW3NYlYvI/m+ciuGJ1n
         inanRKtzZJCgewSn8j/ANUetVKYvS7r7CkSIvo5W3Km62Rfi3qw/5BJKLxgAhw8Cr5EE
         FI4qFJuC96Iy09GJmD7KIU8RJRg/Aat+bhdwGzfygE2KVIrulhbWLGHjpf762vBAnNuP
         YWgA==
X-Forwarded-Encrypted: i=1; AJvYcCWMerBeTPuD9eSrt4RWvYvi+EZsTrs7xLiZ785O3zfwSDXvSKx4Naf+vh+srkNfMCzBuJ8XuAg7tELf0WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yExqFDQ4txJBzBsfxGHJgrhb/cHb+dnv/N4272Mbzf7HfRgy
	qvs/KG61N1S6/RZ0xIDm/DbQ1+Kj87puxuZk2s63NtaU5sfbTpLpSZKu7IlGj8XKk6PvXLvCrh1
	NJSyIuKC07lkZ/FIGhs3PqnkXaWufTdvnU4IvoIPdc4+xl8N9eLtBvGnooSDFsKUau4s=
X-Gm-Gg: ASbGncvWiz+NmnnBGsnKQ6YAYFTrqu2LOhxpTcReKjGczUltMBFOuUOupJe6OC3uGO1
	11SJg9nK/v5XS6VrxIaQRLi3gn+vULf1t5JMXWNvOcIGQxPo1Pe/znIaEBCY/0mTprwKhXgVMwO
	No72JWxQSLplzX3+6ZkQd4iSwThq9mQA7UD2xfSpwqf5YPI/XqstjpXzQ7WmNwQssftV2YY9F3z
	Fobqbj72BfJVLZF5ODio9CCmZg/qxvdBGghq9He97k4J/mAm75T9Xd0XRVvXHaDRRX4aX7DD1hZ
	6EwGNcZhWrklrqVabevg67/Q5f4d+4ouKo28Jb+ybHe+zhZK72Ko1ujT9fKwPylS4JH50CMa0YA
	AxIrpGiDgKfCJdLr+YpzaOIydZ4/3M1hi5fWGVAwxyFLHowVSdaHb
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr73086381cf.78.1757088876918;
        Fri, 05 Sep 2025 09:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKI6ICcB8YsU1+RJItro0ZVf3DZvV4LKkRV/LL6vupHTnzLn+/DenDDljZTOEtKsyf4ex7gw==
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id d75a77b69052e-4b5de44524bmr73086051cf.78.1757088876476;
        Fri, 05 Sep 2025 09:14:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad523b3sm1816008e87.151.2025.09.05.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:14:34 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:14:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire
 port correctly
Message-ID: <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX6gnmRiW8/W7R
 nSDkx6L5RAEWZBciIlZx1vSST9vmVE6k5gmPsow/3wnaaZEQBvI1aCVFozNM2drzoF4DF5xl+bn
 H4dHWuyYAQ+htaABtlQcg5wrLqDd21sQg9G3/Qn7r6kbt1a9NcGKLunWjXvv81MDkiAT2/nmMet
 Qg18A/kCOcDkIylL7nHUAZDG+5xX44LDYUwxQS0Vp5EP5HhHofc/AqjCM38DfxYcFfY09Izk1vd
 F9o0iKe0NKgVSjAHEpTGSaMIRGUHQ1uJ22mX+CRSPqxzFQZVOqp3Asy9Fs3CtKJ8VHFsKN5dpLF
 0Z1diao1e9A+bDeAZt1OMhamUau9TxZvFGYvHRNfiNO6vFq5k0mWtWlmUMaecwCakWzEccJHfe/
 M/KAYGd0
X-Proofpoint-GUID: e-EUCXhCwTBaJ2I93WA-j9Vk7alCDZBW
X-Proofpoint-ORIG-GUID: e-EUCXhCwTBaJ2I93WA-j9Vk7alCDZBW
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bb0c6e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i95AebK-tMX4XhNiilcA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Fri, Sep 05, 2025 at 04:44:19PM +0100, Srinivas Kandagatla wrote:
> For some reason we endup with setting soundwire port for
> HPHL_COMP and HPHR_COMP as zero, this can potentially result
> in a memory corruption due to accessing and setting -1 th element of
> port_map array.

Nit: if passing 0 here might result in a memory corrution, then
corresponding code should be fixed to warn loudly and ignore that 0.

> 
> Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd937x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
> index 3b0a8cc314e0..de2dff3c56d3 100644
> --- a/sound/soc/codecs/wcd937x.c
> +++ b/sound/soc/codecs/wcd937x.c
> @@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
>  	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
>  		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
>  
> -	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
> +	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
> -	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
> +	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
>  		       wcd937x_get_compander, wcd937x_set_compander),
>  
>  	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
> -- 
> 2.50.0
> 

-- 
With best wishes
Dmitry

