Return-Path: <linux-kernel+bounces-895437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725CC4DE60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EE71889877
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BEB3711C8;
	Tue, 11 Nov 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSxsaPr6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuaxlcbR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03C36E1AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864208; cv=none; b=YXXew13Dny1hIPlGPUtxlRDPImp68qYf9SLyHiZqSrSE9EV1cve/NcU9Ycs+N6lujUNtD7/UbqMMHFG+y9FeK6ns0bMp2N2E4DUTFI/axfHEWcNx+V0BCPG1AySz7LSqAx9cB/L+3dR3j6UVyGGR0WPLTBvfgIpiHkh7UGy2IME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864208; c=relaxed/simple;
	bh=dB8Ue9D/OJCd2P+B6eSyqNbmWDWbA3cTGphzjnIuCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuGwb1l9D9Hg2oVktPHs8QDv0jafZ+PkbpiNHlhxvKyPIGMsM+rjEItBZribtMPO7WgaOkndlTXOdGjgk68qV6KAY8xUf2pBlLQXwrmMxhEzLM+VY3VmMLBY8dRYlfGuOhT69C2aC3ZYaDN2Y7OGvF4VVQdWM1YTcSVQHFpDfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSxsaPr6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JuaxlcbR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGjMo2118480
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hBs6+xWoLI/U3b24rkOBpj2F
	X7NTpjk+sdbP859Hs0s=; b=eSxsaPr6WrcV5ySsbXB9AYitmCJYpQFggD+nREFQ
	pG2uX8DRL+X4TNu0TEJNH3G+Y5fIs/zXNu2GsVVsftljOFzfCI8q+xSN9ZVKt1cT
	AMDCAAHdDWd/Mxp6Sd55K0MV7R/lCekb+a/txYFISaZ+94e74VSkE53HZRFEp7cq
	qt+W2abJoVe9XYk9We8mvXHVJK1DjbzSk2RJlKWPCCv22CRu5Rgch/8QLMQflF/B
	1n0dSArA4TyMHwSIW6cxDBUBwEkQqzfSg4mPnd1nLaokUVQOdfvXxr15mFYEquou
	8Z0hfWV8uUOGrGUV5fmx5by/rgYi4TxCgnswYT5FUlljDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8jccs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:30:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a1c15daa69so1259732085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864206; x=1763469006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBs6+xWoLI/U3b24rkOBpj2FX7NTpjk+sdbP859Hs0s=;
        b=JuaxlcbRZkQbjzX9tRMI6NY7pcYSG9Ty9SEU8gXdHCpvVtThRdHBBfYvV7VVFVjTd8
         O5oE3aJkel1zuGwOo6VIVardtaeqe36epmrv1RluJpCkV7pBo2poIR4ud/ZYacUoXQKo
         V1xDvdLSC07bSs4ywihIiY8ivJYNrPhbNhRyN9szo0ffoCdhuNG/76+89hv25Qz/QKGR
         s8v01TCRnZ9KPCyepzJdAPMqGHkd3agZ+sXkSTKi00E7Z5AUD9SrVtP3T+ufsv+c5lvv
         kPrQXC2rcYTGoiEadK0Xy5vOI8dqYOGA0t4T3pWQkcRzgArcxqUBCNFBzyCK8A1KNpFG
         T1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864206; x=1763469006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBs6+xWoLI/U3b24rkOBpj2FX7NTpjk+sdbP859Hs0s=;
        b=lNXcJvBqSo+zofD54+dCCnGfUvdq/cTI5ERxcKVNwjJmtPXr0UPvSAoFDTvZZiyO1V
         +N9oog6T+G0oI29l61hLcyhvJDHDmuxeBvMYR5HuSEZZ+ZC/kwBGUQD6Rn+lTc2PMP9d
         tssWOjshJMu8CmyH+zWO67dWxCaVuzuo0zc8BgGc4CS4bOoeYk5hMGn5wPpliUs7+Rl0
         zBDM1Pr6e5ZpdtqK3+kJcu4ihOMTEVb0Usqz9GfQHPQHnYyRkOtVGh3z01KpX/y2FFqN
         lzfdE9JNVaiFzNfXe9VEpCCEacNk20gPlH2YgjIGbEwyxui8oQCga6cMzwBMAQ7//szZ
         /cOg==
X-Forwarded-Encrypted: i=1; AJvYcCW8oZ51rdwSL0Ec2MB+aoJmzzgS1jsqULe9ouNMkYMkouqoTEAsaRuUPqqpj/deyCYmG7/Bz2w+7zvquow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAFIKR8I2vdoJD4t0ybUYdHqawlRSezwyLbGfaCjQDezrsw21
	wzcY00lGa9VfMMJCO3hTBneegYRBs/+YN3ar61LN1VGVzNWc3XX+ZAdgRVN3IgwdYrNVgxcSjWn
	Ml6fN12eyHCSN+nmYWmDtUuWz80sQzZLiiLUEtfyQ9rHyNKsL1ecLoWmPZfP1bPf3SkE=
X-Gm-Gg: ASbGncuMxkgnu1qAfnqonc5tKNjuIksfub32nE7A4Vk2ouugh+lj/Ec2AP8QgyMWfR6
	RRsNaU0ENN+nQtLJtFjmPjorhVtZpiT3zVYLt7LJDwqFF7DP2N/YsauxJ/GCvon1tZ+ZaD9UUBl
	5rXs+SO/6dSSXEGjVxjoPH4k/Tqv0iOcwg+AaqO1lUKMJdsaOqU2l+DvziIpL/Sf2dnPY11nAbm
	/mzgj/q3DxXe9LtyvSPu/agJMmzkT1NRQNW5NUi77cXnT/3o5MLAxuk3QhKXLVPZqlqEcCjHByp
	EQ37T0sRce6eOrhcPD3J2Nmv46n6x+J2g9S58AD8gL8nkxzaarrZ80vR3Lbd3SNELg0WMqyt1KL
	RdARQOzOZOdz0Mnjv5vRt1/Y+S4siI9GxJVA09GnH55VOjvKrkx95p6FNVypzsMX6L4PVqdgnDL
	Y1+dYglSVJ7GIQ
X-Received: by 2002:ac8:5f94:0:b0:4ec:fb4d:105e with SMTP id d75a77b69052e-4eda4fe0a8bmr137123241cf.69.1762864205709;
        Tue, 11 Nov 2025 04:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/wAmTt64QZYcRPu2yVc2CYacZ2Ql3aGNECWBHUNigTi3vj/RKjWKUB+wbah0KY0qbLTwsww==
X-Received: by 2002:ac8:5f94:0:b0:4ec:fb4d:105e with SMTP id d75a77b69052e-4eda4fe0a8bmr137122491cf.69.1762864204948;
        Tue, 11 Nov 2025 04:30:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f078765sm44935281fa.19.2025.11.11.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:30:04 -0800 (PST)
Date: Tue, 11 Nov 2025 14:30:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK
 flags
Message-ID: <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
X-Proofpoint-ORIG-GUID: EzcH4VkFoRWXtmBN58sXghsaIFk3h5qZ
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69132c4e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=8Z5QE3b6LG9DqZ8cva8A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfXx5t675Dnpw+4
 mRDM/9trNfamggdUIlCzOmbi6/8FItKXJoxNOkMgbxg5icNxTcAgyTOrzxSGq7VWLR00cdoYJfn
 fD961u2GKZRkYOrclFNo5IkjbOpNx8sYjBUx6qOaynYedwgc5E/kXH3fJ1f6iMcg5hPrb+2OScI
 NAqLRpdkt8662B9CQOFHHKjSp6OjmVhmBYH9XqtIc0tteakkbGYUYjDqdHNPp/6ATNIIc7favkF
 /v4qJDrdPLkn9x6Ct+vKWqSfZa9KqxG12MHUecaJs3D+4oMaA6Q4rMOmUP6MWvHoL1RXUDIerdA
 HHObvEq6eWtwVEr2X7rgQD+3YjTN9WqEQDBTl+CmjYLDhwbTCXkAQQMRJzR77FmEn0AMlKGzDfP
 H0LZ2IWPr5s5dDc8x7rVE7sq2rUnog==
X-Proofpoint-GUID: EzcH4VkFoRWXtmBN58sXghsaIFk3h5qZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110099

On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some DMA engines may be accessed from linux and the TrustZone
> simultaneously. In order to allow synchronization, add lock and unlock
> flags for the command descriptor that allow the caller to request the
> controller to be locked for the duration of the transaction in an
> implementation-dependent way.

What is the expected behaviour if Linux "locks" the engine and then TZ
tries to use it before Linux has a chance to unlock it.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>  include/linux/dmaengine.h                       | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1594598b331782e4dddcf992159c724111db9cf3..6428211405472dd1147e363f5786acc91d95ed43 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -630,6 +630,15 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set, the DMA controller will be locked for the duration of the current
> +    transaction.
> +
> +- DMA_PREP_UNLOCK
> +
> +  - If set, DMA will release he controller lock.
> +
>  General Design Notes
>  ====================
>  
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea9844ca6161208362ef18ef111d96..c02be4bc8ac4c3db47c7c11751b949e3479e7cb8 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -200,6 +200,10 @@ struct dma_vec {
>   *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>   *  to never be processed and stay in the issued queue forever. The flag is
>   *  ignored if the previous transaction is not a repeated transaction.
> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
> + *  descriptor.
> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
> + *  descriptor.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_CMD = (1 << 7),
>  	DMA_PREP_REPEAT = (1 << 8),
>  	DMA_PREP_LOAD_EOT = (1 << 9),
> +	DMA_PREP_LOCK = (1 << 10),
> +	DMA_PREP_UNLOCK = (1 << 11),
>  };
>  
>  /**
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

