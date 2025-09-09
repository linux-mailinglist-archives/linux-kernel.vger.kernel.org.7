Return-Path: <linux-kernel+bounces-807619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3877B4A71B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93851883515
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82FB27A93D;
	Tue,  9 Sep 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j91VP4Gv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2B279DA4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409135; cv=none; b=ZG/P9XIHdhJZEngFh3wo3vA8L+1PNvrJ5tJKr/tvzlt1G8tCYkXpbtyr/8DstHhJM88vuN/S3HyeJpMu72IWWacIKS9PUM+WB9HWprL+hFqDJNWBChm4mXxF6pHdDDkxehZDET5MHApa65kg1fOXd9+zNbRe1xUB+bvR8uZw+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409135; c=relaxed/simple;
	bh=luaWj8YLVt/GHe7gdqZ+kOjyKtBzDcdnU6RugbywhPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7vpkezwS93ysje4AeHRn5RJ+WbNClkYN5ZpYPYIXo+tlnQA+UCpklAMHJCcnXYJxYjB2gJXfme9xX3SSPBH82fBiGe7RWZ1aAr4BcJrsDrm73gDEkKXVH4ODR8FcDMy/G6BsbE2T9EvEhugBoZq0rk/0GyGIrIdbbagUAnDziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j91VP4Gv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896SnWF007761
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 09:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7/LZ7jld6Mn4TzxL+e3wR4fKEsF+dhJ3GAlByrhuIjw=; b=j91VP4GvonjXVqJG
	g7UJdf4R4krV5SI1hisRHQTgpAYDp99pUNmaH0VbNzRwikm4gD+lpc/O97k/rzaZ
	ldmX0ZDowjWc8kfCWE2m6WJoUqn7gM8RWHgHbMlXcJ+ZoyJYcNUozb/gAWa3ys6E
	xQJA91IUsus+fR4iYRPl7qWpOpSfp6ut6oIJbGYYeopXtVI6IQjHVme9nJRTOck3
	Bc7TSKCQavDYO8j1+qu+zLdk0sHDEDq9C90RRR1XuXUW+yj2pZTx5rQypvKhiEPc
	fMH03JwEx6Q8l5+DjRi9+rhY6OUHB7Rl4JQZwS34qhVLbA8/NARnpTmQI/Golbfx
	TJDfeQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0qmu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:12:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f76fe6f6so9542441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409132; x=1758013932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/LZ7jld6Mn4TzxL+e3wR4fKEsF+dhJ3GAlByrhuIjw=;
        b=hNIk//Sr55hmzxxh7idmhTsbOP3k9MsYR4sOL1MXSkPNp24zdTCog4o4HqAkpEtNg+
         StGKPllO93wyOG1+tUpL5WCJbcG7Ja7BMsj7Ju7B1MseEYcBxGiYibRKKLhFJsypR+6h
         vKjz7z6+BHJu9826NO8QkIKxgsjrB/n+MAZDuLgGp5CjjLP3v30FG2Xucl82XqyyjBzq
         RmDqc7y0S40lw/Xvo+GyCnloxM9VMZhXWupUIivOYN8Vptbwcpg0GOPw21IqLcvXhSbx
         bP5a3cwGTZkiR/k+Qa5zUUVE3I0ReOM+UQxnnxoXoJgH7goMUm6PGNVVEqnRfLf6CrJg
         rXrA==
X-Forwarded-Encrypted: i=1; AJvYcCV1SogeCecsVefdW5SRTPC1jqmMMCpttUbJFC1QEee1ElgS/ZtFYDZyh7EonfKwtQdQ+KxF/pSqt+HDT/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtyok83/aN4qqB3IZIyxJWyhZPIuC+jtOpUpLZk9REBLg6OrR
	XlsIIRM+OWaAXED/MuHV6qJ6dMKixdZNVD4g6gLcCGmLK4oSd4L2rAq6EL+46YowI88cvbOtQq4
	ikI/3vkOcB3F6NxjT2HJqTeRwWWarZyMQUWMQgZHwcznvk2th8Zc7ExR/6RbAUkXOcOA=
X-Gm-Gg: ASbGnctw0yX71l4Kq/tg6pb9dJDRODEA+7X2shemo/ZbgS6fd5Pj+tNt74yubMuwlEp
	PqJEH83EfbAps7kD63/opo5j9ERy9FITxFf0WQ/axylkoQjUvH87M6SYqCB15UW+xvpfErIa6TF
	15sv39RpQ+bhiu2iujDjGkeHEMezCe5CQAxgHMUdHyziUgS4POXMo0B/w7acbBRTRedSaiy5ciG
	zSPQtCmj6JCKIsWiHg/mcHDL5jCCMF9AHQ18FI8AEZLbKGMEY2CTkJZzBeoGAl2QfbvNvsOOv4M
	B2zSDlOMMJMnXkME4n8fo5oeYxHj5rt5s6NT/Spsi/m/elPyeF//SenxuRwSh6lUj6VpaYsU3yk
	6mhLtvWFEoodpKdyedS+30Q==
X-Received: by 2002:a05:622a:199a:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b5f847af12mr81429591cf.6.1757409131441;
        Tue, 09 Sep 2025 02:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT8WcnSygf6bNTgYYy0/PkzY2w1a4gXks9/FKqoCWfWHg07YtEpBTM6SSkzd5fxyaeTOsD6w==
X-Received: by 2002:a05:622a:199a:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b5f847af12mr81429211cf.6.1757409130769;
        Tue, 09 Sep 2025 02:12:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047373afcesm1359797266b.57.2025.09.09.02.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:12:10 -0700 (PDT)
Message-ID: <25df0f78-68a0-4459-a5a1-eb035b0a5395@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 11:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
References: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
 <20250909-a663-gpu-support-v5-3-761fa0a876bf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-a663-gpu-support-v5-3-761fa0a876bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PaxJMXKLMjnhI1ghx8qx83HVdRHIMIQp
X-Proofpoint-GUID: PaxJMXKLMjnhI1ghx8qx83HVdRHIMIQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXwP4tNtdHl+nO
 0dhMQrxFOz3zvYE29zukzVPCzQmC+JSTc5ah7pTEdbwL+mhx4jlbi52b9KcGZ9QonYsB4tMOPPC
 MW4vEdAFUhOj4T7J2WT1S+dfqtRrwVhPFNgmGFbDxMczCjNxM6FgMBlEcRorg32kxqdWU1jpWkC
 SxvaAFeHy/gJsO1WSAjWR0sXgZOuYphQx4wYfbS3zXM+SSfOGwUnuTYwfsyh4M8ITRr09nQK+yF
 0bjbd7qyLzZUFVNXFWPReI0kh/ZisE50+nNHpy/lkBgn2+tkv+9OJBaRkbJyVAOrQSE9lXCEvfl
 yJtTRttjq+GtMdi3GTASlF4FMeS3mHLy0yEFeX9ELEimRG1w2iXC4jzm/deZZdTfN/I2QBJ3me/
 9jMPSwdU
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bfef6c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=bBjZtXtOduL1R7AEkPMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On 9/8/25 9:39 PM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Add gpu and gmu nodes for sa8775p chipset. Also, add the speedbin
> qfprom node and wire it up with GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

None of my comments on v4 were addressed (we agreed to drop the
GMU MMIO range one but others still stand)

https://lore.kernel.org/all/f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com/

Konrad

