Return-Path: <linux-kernel+bounces-831668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6097B9D47D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8893A169A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE91DE4E0;
	Thu, 25 Sep 2025 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BvxnQNSC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC8E55A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769746; cv=none; b=u+UHHdzr38dVFL6JjcqKAVEoEnqifbhz4c6F0XBSQFKbleR4FWe7s2c7pdI/fPrnWUdkDNyN3idZxuYC1wlaj7Bo0qrVl9bKZrjfJH+Fd4YtgWSDVUPruaFKirS0i62G616PIgSjKxnXMx1DrgwJ6W3xZe55qY8YmhZf3I2RkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769746; c=relaxed/simple;
	bh=Wpq1EF2/MC+MMyWi+/4FoTAIE4BeeN2Q8DcmVhhEVIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T15jcB+1tIRbWDzEvT9d9HWXIK3GlqqpYP96pO5Q70e3Ue8vhoq5TA4jcou2AD9RQn4SZ6oxqzZehY1OJdQpNfOXOjOcr6WAdZC/xJryp/O4ZJ8BVQek5f28MuWmnx/1gkkdsuePiMsXRx7W8N7mkiqn9Zh/qQT0AUUtd2JD8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BvxnQNSC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P02kPH018785
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xxZapyWudFtqXj3PRC44LC7g
	+rW5KB33WelvpZxqWZU=; b=BvxnQNSCJHvelW6XJwzbJMIEuw/uq/zNAVy6+FXQ
	+Bnoj2jWL+UWhgExZvPYyV5bhfxAJoT7zDKW0vgTKZwOx6LjcAkv0L9XFZl5itZP
	EzkInAzyoAZUCUm/Hsi3l4MCV6ptqlnvqaIATCnwzXBTDjsg8JR7gqZJNaWpvOY1
	hsw21tJg+w06fJayEAJDPj7sHRoItxnKF39SFDUrzLdYknwXORUPusYQquUWY+mX
	Qb0r5qxHC7U6AuxfBVxzhFNuONyYRswwQovBgejzIFSRbJ3lycCbyN1hAvOaZ69U
	44yNuvmBJ4qOhPjsCxmp5KrBpIvG/qSnUBCdHyC+/oR+1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkagxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:09:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d77ae03937so14034511cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758769743; x=1759374543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxZapyWudFtqXj3PRC44LC7g+rW5KB33WelvpZxqWZU=;
        b=EnQhebVoVj3hMcWCTPqyABYYUoHzz10W+RbU6w25kqTP8ayJOG8VAQSvfVC7o0Nq5Z
         CbmimAwG/d5EEwEbwdYi8pTubS2Uf7dGWKRZBvjY9F0ZSkpZLP3SBZR1t4nCf0vIP15M
         jOSkRAZmDwoPCGD/BDN4em7Zou11t9gVZx2Ans+sFrpOdz4hkuK0Z0Tk74d2e9BAeTD9
         ajzCYIT9B5qPYbQmaDY15Q9kjrbDEZ+nCTBCrbbJXh1VNzdiw3zVjfluYZdGpcLo8w99
         ECaewEndsm+8RsUVlSAPJ8qmPy0/b52eZDHyItCEaWXb2BAvmGHhCDpPYOYs81U3cTEe
         p9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWD9bsH4GRmj/yGRuG8rpntLTzumsu1GJooIFRAfIAxYXWtS+TPIzaBw8V3GwNcI/24PYCq7djTZb8y1wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMKdOk/FAPwzWVEipr48y2Ss8o5PUFa1Z5pu+h8wjzo4/+oBr
	giJ/piavh0Q+2cVZDS4HG43O8+WFv7CiCb+xTEibTgo+eCqh1iYHV4nfE2sTJn+EcJnMH72xdfF
	JAJMsGJXhq1Ief/BL3lCshtZcDqzT9aVN5hI5gpxUlSpfeMh05FWWhA2+yCM10pRgJYY=
X-Gm-Gg: ASbGncthWanxc7JG+KlVbqW2HXQ4cH7rII04NnkhaDjGAHeNNRfofP7wKs8x+rCPXQN
	NgJv1vBlM0DdnabYAye0C7xJ3DgzMtwjGLe1wfw4R9IhUftqryhFroHb9hZtpJ+WKfQNiZ/AS+Q
	7RKjI7ZkkgByFgMzkhR1dpRjaFEzL+x/bYqr88zlpKuiKJB27/k/qBltD3Ane/S2g/PdEzeZU+o
	wM4yuUk85Jhgp13KIKxsWJdLRZcTzyF+bQuQ4aP/4txFRw2fMvFEvueRn2rC9PdGmfn/3QMPGBN
	OFVNUAwnDdIBoLc0u72okgFV9gQf43Q+93V3eGSgWkMZ+WoMBedzvW/BxZxq6t7pVFGaThpYGrL
	X4FGkf3/D9rWMoGwIXl/PVqLqycTTdS2TTyMOSj3ySCveB4gcD+n2
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr28268721cf.54.1758769743181;
        Wed, 24 Sep 2025 20:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjD6roAMh62lhIixQNgSFreoILQwURlIwfNhtYVCV+e3dpo7i11o2BA0fnbYsIB373kLxg8w==
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr28268491cf.54.1758769742726;
        Wed, 24 Sep 2025 20:09:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313431271sm281762e87.20.2025.09.24.20.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:09:00 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:08:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lumag@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, quic_abhinavk@quicinc.com, simona@ffwll.ch,
        sophon@radxa.com, tzimmermann@suse.de
Subject: Re: [PATCH] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <5au5p32oyouifgmqlnl7unm6n7tbxq45wpwpqx57xoepiucmxw@tjqlbh2a57yk>
References: <6mq5morx4kuwmxa3dhpxf42uqedtveectlbeodl5oj74rqk4gy@oweda3unauqj>
 <20250925025714.20121-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925025714.20121-1-liujianfeng1994@gmail.com>
X-Proofpoint-GUID: 4exPHubJHFE9Y5sL1WnKI6euN7vq6FT8
X-Proofpoint-ORIG-GUID: 4exPHubJHFE9Y5sL1WnKI6euN7vq6FT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX1I4YMhHqNa72
 fxsisWsEG0UQXgI72y/S8zVWOWu8DO5SmNNR+d8tFtjQ32cBgHDg1bD1u7AG6SdH80GRUY+t0eG
 z24OSlHiONFPc5+wlbHQBt1IlXMh6pZhkih/jJZ+WLEhVhpiMnhoE8529Z0CmM+INMrARX2ihu2
 QcfEU/RaZFRGiWvOrh8k0xOBn52tg4TbbYDxNItm2m9RuZvTokkZ5QWcjWcf7yvVB5ZwNdEFMjd
 K5XQXhbrovYtRvt0xEsePN/4kKf2gt0NUUsb7Wm+QBTI0bpXx1vJway9eWQqbByDFUy8h7rUndn
 zTXAuBbrH7Wv03YlXgCQKSUnPMEgUfXMKatb3Q4fuqrhfdwdsM5/KR/e9Zqv2LbqCGd6nIT0q+d
 IU0HVKbZ
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4b250 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=5y6PCNOKMUJiDNq-dWAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Thu, Sep 25, 2025 at 10:57:14AM +0800, Jianfeng Liu wrote:
> Hi,
> 
> On 2025-09-25  2:18 UTC, Dmitry Baryshkov wrote:
> >When does q6apm_lpass_dai_prepare() happen?
> 
> q6apm_lpass_dai_prepare() happens both before and after hw_params/prepare
> of hdmi-codec:
> 
> [   14.055198] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.067225] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.089925] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.105988] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> [   14.106027] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.122707] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started

From this log I don't see, why the function would fail in the way you've
described. Could you please post (for comparison) a trace log without
your patch?

> [   14.132017] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.197843] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.633992] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a660_gmu.bin from new location
> [   14.635452] [drm] Loaded GMU firmware v3.1.10
> [   15.929293] rfkill: input handler disabled
> [   19.406507] qcom-soundwire 3210000.soundwire: qcom_swrm_irq_handler: SWR Port collision detected
> [   19.415672] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   19.465864] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   19.581446] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   19.693965] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> [   19.694012] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   19.706621] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
> [   19.722543] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   19.775071] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> 
> Best regards,
> Jianfeng

-- 
With best wishes
Dmitry

