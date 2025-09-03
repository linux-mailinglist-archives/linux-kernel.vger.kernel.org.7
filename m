Return-Path: <linux-kernel+bounces-799560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDCB42D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EFE3AF09D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2BF2DCF68;
	Wed,  3 Sep 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xx0yNjCW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC831A314B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943167; cv=none; b=EwhG3I8wJq2OwfeAN5hiQu4yMkGFbehRvMbQvdTnoZsGRV9sL4paKGW04MvKaYdM1UXsTOsNi7xjSWBqxmnAhwoaKbd2SPe01XXK8V6uMa2llOax7O20pe1S/MCaiLiogGiyDRemnRMfdbUr06pG/LiWa/J5xpg9jHfDHhDmUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943167; c=relaxed/simple;
	bh=bKafahgtjgSdUvTRQ8tQoB1hM0RhKnBI179S/IxZw/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS0202Lx7waCHZ2AxZHMI931cwSHg6yqfw2b1DQzmZgX87Wo57bHGzDfhGl1qGiwqZ7nwQvXZA4yyI8LGlzCrvM0hNfg+W5Exbx5Tw/KwHtumINsZ8B9yPC6E6VtZ3dGQi/amiuOZ85NvDrMe4mcnNSNLdeJ6Qf6pPTSw1lKn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xx0yNjCW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxqGf030576
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 23:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YkAb+BdBtP58KIf9+ez4rCZs
	0vp9S2izMGPKnDHcn8s=; b=Xx0yNjCWc23/jxyl1eg4ByuqjbHai1cBJFdKW3Q5
	KvdNa7vyj3JWHPxkffq/lRpP7fXMPDknOw6cGXnM/+uk9KGlm8r89byL/v9JMlUO
	QJoLrscT7vDB+w02w0XPUZ79Q9hnk7dw1AXzTZkW34JR85y6bk8kPQMLVv9MbOUP
	pxOFxEUeZYgV6bPNI+dUzwEzod8JbekD7jK/WiPbKj/3MSSy+oJqWZhmdoahRzxY
	vDMStYZ2i2Ckf5Ghux+rqoiqbg6kPdyGa/bdQ4MQgCUqh4mQ63XZXhqVmXktDw+4
	6X0kTnxdAalkzZHB0sN+ObWTIiDOqBESgoBEf845xGPr5Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw05jf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:46:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-72108a28f05so11537086d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943162; x=1757547962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkAb+BdBtP58KIf9+ez4rCZs0vp9S2izMGPKnDHcn8s=;
        b=Ah9YsDL8kC9z/wY0pCqZjMwBybW0s6bmv+TkL9Cyjg0u+eUoM1c9utlWKBaieHcscW
         IYt3HERMi4XPjZ7Kqs6x45F7z+bn34Ik6Iwk1UfURnMhPhm9F7LFgnuTzIziviVfAJjX
         QGPMAxLqMTFQymIApIcNZ1dzDnM6GaW4orol8DcQWO6bEHSevAA5NdLw63wh+FVKTs3+
         UITfm3qJgSTurEO0uzShwIkbIYoT2XXu3enC5UVqSW6H46ai1Xo1QWWX3d9zDHF2qeeX
         vkKGPmLSQXPWT1Zd/xV4bZM1/UwvE6xjqMsCIic2VJqCFjWFTb1Rf/MTYQDMfX5WSACs
         +riw==
X-Forwarded-Encrypted: i=1; AJvYcCUFNs3ExRp4KA6dXCZd69X03vuQclocXqTyLpwDby+p6aTDZ+SWAZCSZYNpLkov1HcKrMe3o+QnjIuEMCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm44f9WRNW1Qicb/cdS6nL7dibXuaCbUUQF3jqB+4gscqZF96T
	wIW8Q4A+Ex8Ji1Q+1iENuMe33iGl2DWSJ//yyrvHq5Z8AtlRpPqsVtejm7duhEg8WEGaycrwv7A
	Dn9rQLexzvTaOyNbeqAXYaKYKVysL5p4O5k/GA7IXq0lDIHAGUwyXdzEwZ/EV0vfid10=
X-Gm-Gg: ASbGnctYlBM0MumThs5RLzt+E9X29bkBRSKZAkAb8jr8cSJJRCPKMTkqFfzu4pNtFvY
	380rH8VA+vtaDeI3mHyiWQB6yqbDvW1JQhlAce5/2hOey8L5Xf8E5bKyqC9Nei4n5Ul6IqDVDGE
	ouar9rYwcu6KtVw38byqluOhjBKjGrzRtL9DEkrTwwevqlJMKYcc5YDZInWzeT3jSsM4I3G+Ouv
	xebCnRJrTu6qbKeiQVMejwhqEFx+wjbi5c8PLg4CbFxir1N10zukuu2YEz0fr1cBuwqJQVEUQ5M
	3WFpVzUhoOsp9n1KPFTW7zKfx9Wz3+tUPtYxyfXpIeNE9/kc4el9dGBsgsYZB7TlVNZccltj79J
	Ql7jEQBUGA92P546XDiTfsEvCkBZGEBIj33DuE3lKAbuK9EBQyGqW
X-Received: by 2002:a05:6214:5199:b0:718:a53c:d5ea with SMTP id 6a1803df08f44-718a53cd8b4mr134396666d6.41.1756943161752;
        Wed, 03 Sep 2025 16:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeKw8/l+JU/+w+pUW5gWTeEM0B3lNbyMq4ZaRy2csjRNAmkpAtPFYULmhJ/idZ8VM17Hpkeg==
X-Received: by 2002:a05:6214:5199:b0:718:a53c:d5ea with SMTP id 6a1803df08f44-718a53cd8b4mr134396226d6.41.1756943161076;
        Wed, 03 Sep 2025 16:46:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfbb87sm827119e87.105.2025.09.03.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:46:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 02:45:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/6] dt-bindings: display/msm: dp-controller:
 document QCS8300 compatible
Message-ID: <j7whxaqfeyz6fqwg54h2mivobbvo3plvxxzor7whmwjkhavndw@ulqfidkwwn6j>
References: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
 <20250901-qcs8300_mdss-v10-2-87cab7e48479@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-qcs8300_mdss-v10-2-87cab7e48479@oss.qualcomm.com>
X-Proofpoint-GUID: Dnao7JzgfGM4Yq2LeqSCzdAODk8WBCZ7
X-Proofpoint-ORIG-GUID: Dnao7JzgfGM4Yq2LeqSCzdAODk8WBCZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX9bmUr7deXUDu
 t0EP70Bsamm/Y7B82Ya+3/FFmGXRHl8dWTRRzw/5YpWZU+LdCkzgMTGclEcgy5QRzc8Nf5rBBqp
 0Hc3tLCFOIyroVcofDB/8EfI/+gu8Og2PH3Sn/xjio4bDXLAsW3W5Uh4obUAuH1IFq8VfULFZY5
 B6HWEEd6t7Y+bRf4kGmnqT08oDQa7XwCLjNK2g7W76SHkC6hWgw7YjmcBtRW5ckzKyeXgQOOuck
 C2hQyXnwHFzaT/OFQ2CceptsZvkiiNB6tFK62kAg7Izk8e4swx7JmBUL+M9/ah5dN2pDG5GjPQD
 u8HbnDw8UX5F+6jgEQEXg/TWkbcRVY139a2P7fMlQeiBj8K+dYG0k7CXwpSo76XC8bdi74wiM6m
 YAEwiGk8
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b8d33a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EZgLUtVhDPKl7mjbVu8A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Mon, Sep 01, 2025 at 05:57:30PM +0800, Yongxing Mou wrote:
> Add compatible string for the DisplayPort controller found on the
> Qualcomm QCS8300 SoC.
> 
> The Qualcomm QCS8300 platform comes with one DisplayPort controller
> that supports 4 MST streams.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

I've picked up the last version of the DP MST patchset. Could you please
rebase this patchset on top of it, hopefully making it finally
mergeable.


-- 
With best wishes
Dmitry

