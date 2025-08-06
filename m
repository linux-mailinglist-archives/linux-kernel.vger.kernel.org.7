Return-Path: <linux-kernel+bounces-757249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC73B1BFCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59F7189F4A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026C1E51F1;
	Wed,  6 Aug 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="og2ZVOMe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AE1EEA31
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456954; cv=none; b=mbBgA9Ms1ejfy55eAyLuC+4rv/crL7BTe3YCHTZIqq+uRtIXyyIVMMvvmnv/laRU6G1I4ajFUOqgd/jlmBhPx45RGl49lyaAh/WAmL3+0w2m9v/0tOxJKESp0IM++m90Y9fSDffEZa+f5gSSu0vgfsk8M54GhOY8OtGxvKjeQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456954; c=relaxed/simple;
	bh=8WJRB9z4af0UImArOa5ALggEuPHFuNJE9SWPyHMiVjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEI/oQJ6wz0I2Vxx4vCoSfm2HLt+eTnvIyzz9CMHixpJhVgbcu1ucYX0kJ5PLxEu+W01hI+t0g7h1srJz7Ys7XdWapBLUs9GATme+F0BjbVzkvkUsonwKAShIPixdAnzsNYH1a4aJqjyZn3fPrn3vkU82ScDkDDhSRVnBxj4sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=og2ZVOMe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761emw2012612
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 05:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=68sovdrrPXA8QmhrUduSJfVa
	9A4OBtR8N7I8vuIQI5E=; b=og2ZVOMe+cesabO+Jelxst82ERdX0OQCdHzquAe4
	xAMYVlYsx9fTdGKY5c5lACgqhvs9X4fJ5HiYHkBZxM71YIDhHymJ0D6DeoovpG1Q
	JoB7HB2KuIws5dKopH1fNX833/QEMwj+SIIAD2Gtubn48raOfmoz0gfMj3MQB6Ir
	sO4SfyTKq38M7VeKCxvka7E1sWyt7xrzT7J3/GJMxMfgLbz92CI+zNxbXa1C8WTM
	SCQ4iRlcrxbZBADmrxHtYxWxdFuCF6/z//nUqlv39TItIvfuxTnsD565TfAK13UG
	CRJI88EAiq+t0dej+CHktqLiGIFHY/B8nrKKGhGIuFdmJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvysgq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:09:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b06908ccacso66103351cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 22:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456951; x=1755061751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68sovdrrPXA8QmhrUduSJfVa9A4OBtR8N7I8vuIQI5E=;
        b=OstN316eOepk9FnncNFHzKEGcw39jZpGtYxz4ijqkG/G1wR9VBH9vGp0A3KHVl/vbL
         vF2JSuRUPikfbRZkZbttZCrwDMt3Sbko35eo7JSlPlVGOJadbToNI8gaKyy13mJUCeiL
         jrDMg5eesJ2HP+2oOm7pBnBnDSjOmHojAbORWyiwXgB7jRaLbowoSOvRim7QMlN5axBm
         kijDi5xjUhSj8QbauMxVD60Sf+EQ61V6cyGSe6A9Iiu1S3zzjzStNDBgWpS66BFIyFe1
         1iczpFtqvbLvga/51UaMDAgKsomag/kwjSwfxtwy6skenFEWwEmMVa/EQHcU/+zzoqfj
         70oA==
X-Forwarded-Encrypted: i=1; AJvYcCWSoVyftC5VpihM6Q6oY7nOyhLx0losoo3FD/fBGxp5oxunVzEmcsfnPVGtY6GdTw9hGa9YvzmZJjrueWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAyuhHkQGN93ZjzprOMd5Tq0yDg9HeFxN0c+wr5m5u0rT5oUQ
	rQSnEKUHWu1IXZLHD9dTLWIgktvj4TQ4qdE6NLKkTMrXtJwTKlElRydu1g/NAEvVhx9u2Ke4R9Q
	gy1jesQCCdlkOWuEVZ/5svodcM3OFH4v+kyR4oOfgFowxYcFjQ9SN1HggXbcWZXzN+Ow=
X-Gm-Gg: ASbGncsRTjJ0R3pelDS3a+dSd6FvE2a/jhtiAcgO+NAIDenbnClhdGC5FM+XchoT5aA
	JkGdtbK+4NAoGEshs/axcUw6RUO3z4MC3jW3Ib1V4Rttr1NNaT9xBtFpWZRYvqTiGVeyfLWWnao
	/Uyi/2OZq6LqzxUZbgMWhmc2D+4h6rLXx7v+vmSkYKcNTtioAScCC+mhjrVAVR88CD/3sXJRyww
	PfsAfF7yPFJ5NpSMS+ZCd9tR1FVTCUOP0k2AaOeGcoT9olNn+sLIDrHAFyzlrsL9F2KqFa4bRiL
	bNMW5xuV/O0ZFzaPZvDSsLdsihE1Bk+jXwRykgpOcHIFsI4rCTIMfywKrFYaza4UjxOtMCtA9DL
	hsOO9tqQKW7C757Ag/UTCShWioBvex9pbNRO8zXvENXP1VP4QLSBu
X-Received: by 2002:a05:622a:1814:b0:4b0:8f9a:857e with SMTP id d75a77b69052e-4b0915e7139mr26390401cf.56.1754456951139;
        Tue, 05 Aug 2025 22:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFotMGRHjeIm1vbeYr6C42G1MErJI4kAH19Ib7B+nZARpwmp9NCyvWcD9AMhVLBzKBMuD1ytw==
X-Received: by 2002:a05:622a:1814:b0:4b0:8f9a:857e with SMTP id d75a77b69052e-4b0915e7139mr26390171cf.56.1754456950777;
        Tue, 05 Aug 2025 22:09:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98aabsm2215050e87.103.2025.08.05.22.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 22:09:09 -0700 (PDT)
Date: Wed, 6 Aug 2025 08:09:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
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
Subject: Re: [PATCH v6 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <b3tgv7zhiix5rzrw4xv5rtaoaikstdew5lo4htvepl4phl44dx@q3xztyk6fagy>
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-2-dbc17a8b86af@quicinc.com>
 <b24ln55wgmjzksugbowgilxqbnp6d6mgq4cdqljrj4jftuefa5@gjcszc3t4bqg>
 <179982fe-ff3f-4d57-9ac9-15f0512facb3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179982fe-ff3f-4d57-9ac9-15f0512facb3@quicinc.com>
X-Proofpoint-GUID: MO_-1PCyu_m4g6ZPIAPuu4Pa6eNsw9hh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+/AyH5dFV1p8
 oAXMOWALBaJahs4jr9cJ2QY8LuqbO81b/F0Nw8O+IQN0iWvFPHEfPvBLb1bFiu8ZK585g0ZGGhE
 /UsiJ1MnjqJb8YBH5j/I3CV200CbxIRqDDRmHhdZlw0GkVwNfZCAZIuC4UiYFnY54gW/2Pdfv45
 MMEG2DIS7SxshVZmY1QsmrHIhq4fEN4IT0VoBvlK9RZ9LPKxS8+dWpXrL0miEKP/b2blLZ/dAtw
 9kszWVEQ8LldKr9VIoxr6AsJ1BAa+81W1SWzYSGSGnoHRAIz9Yg5QKVVfZtpmOWA41A2o8AtkoI
 9CZNYsYGy2M5xLFQnQJQhCvrDzJPHUXaqHR3rtFQam9AYyuNztcz2YDsJIzhrai9RDYPYL4ctUJ
 2HUOGi2f
X-Proofpoint-ORIG-GUID: MO_-1PCyu_m4g6ZPIAPuu4Pa6eNsw9hh
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=6892e378 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=sYGqIWXcBYFHAWytNyQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 12:07:55PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/8/6 11:46, Dmitry Baryshkov wrote:
> > On Wed, Aug 06, 2025 at 11:16:46AM +0800, Yongxing Mou wrote:
> > > Add compatible string for the DisplayPort controller found on the
> > > Qualcomm QCS8300 SoC.
> > 
> > 
> > Typical comment: you've missed the explanation, why it can not use
> > fallback.
> > 
> Hi, Dmitry, we move this explanation to DP controller patch (patch 6). There
> we provide a detailed explanation of the DP controller,why we need this
> compatible, and why not use fallback. Thanks.

They are different patches, reviewed by different people. C&P might be
helpful enough.

> > > 
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > >   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
> > >   1 file changed, 2 insertions(+)

-- 
With best wishes
Dmitry

