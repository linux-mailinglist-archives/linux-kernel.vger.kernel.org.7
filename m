Return-Path: <linux-kernel+bounces-803026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8FB45997
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E4B581DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3B35CEC2;
	Fri,  5 Sep 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MXEp56+k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C435CEB2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080244; cv=none; b=rbQI0Zuc5+M7lIjBhCrvhstft4RACN8onlVN0w/lwZvouMOOdasIKwl1uh81MDu86NiaSKeAFd/MIMXAOAM7teE0npZ/lu4zDd6YioJiO137MA/h0YDxTxz1Ap8nfrZdBLzNOzQ6XCCiHL361AiXpxGhclHC3tmgdNnLCoAqcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080244; c=relaxed/simple;
	bh=4XGnut1KQ5kuNGnU7q5t4kWQ8e03NglGs0Fl6o2RhkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X43VvjPeNYnaSTk0Q7xPfubJKSrccV/zt1XcUA3lyOE99Hozq0R6Xnjom++rdzjEvetnknKbvhUTuHKDFqD8+8gVtWXbTxmtA3LeLipJIrCAkjLUnAvIMxonfRRVWrWI6unx2mD0sdVikOQUcSO3RK9xfUOJgFgrejUbAnjR9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MXEp56+k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58572Ooc003799
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gEQXFpfF2RLL/Hgz4KyNGpY0
	IZf9BMj2+2h8HwgD2BY=; b=MXEp56+kNC0f0+Vd/QsFAwauK0Ede9zrelhvaL19
	ysQXCRYbW6pWYu7qYVcWq+qAKbZUJO7lr/FHbCEv2+ktYku8QYWufBVv4uFg/qhq
	YonFxqrkHGSaTU+TRrkJ+Vh2FYEGJ2ONex/EOWstxez3VLrzVS8PkTj6dhjWGBYu
	K1e4mrWPZRZSJ8tq4HE9L8G8gY4/WabljOc3sau0AgjnLe/fpwfG9cO8Rstd6SC2
	RspuvTdRgkyEDLLhGaNWdJLQrLNkCETyXyLrR3C5HG63mBDVIymnTm83kJc8g01u
	Tjeo9USBVsIGpR+gjoVwE4Z0bph0IWCN5abnnQgH/TCxjw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbdmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:50:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so39243671cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080241; x=1757685041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEQXFpfF2RLL/Hgz4KyNGpY0IZf9BMj2+2h8HwgD2BY=;
        b=B/aKw6AWEqi4uG2S0hkvCbg5FRb/CER6gYJ6JkbQmqTtBuzJptFWZ70kAjWou9csvT
         cvE90QLldq3ajscv1mK5V6mtR79/JpG1eiYSbMowsT5M5oRhUrC0iqEVoEtmonA1GvQb
         MFndj/c7m1c3m27M1KzckQ6sXEsLFM9KXyt60NhAWKgfK9eE7dB/BvUnixKLa48Alu54
         6kZTVKUnz6od1f/VYkh8Hp4mtRg32sQQRQY1P+nAF1PTEnJGqNcqQZHVsTZHPachtbjE
         DjiAnt/zYZf+biaySrA8yXABGty1gzjqE862KpQhCcGmnqFoSYood4cGRSM5smYcTEMM
         XWcw==
X-Forwarded-Encrypted: i=1; AJvYcCUZj7TefAt03E57ECVkVDkSULW4/kx/3884O1IAkhtsaRquxJZyzIk0EECyLAyLyl2EgHwl5INY/CPzwYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpK2PbPum2Iudh0gz0C0/SOlAaZ1wJ5NEMM9Cw2nsgpZmoC6eD
	QVxZjWLSex7MCUm3K/3IGnquYj/B4R8d5rqXmTqv4/uSCbaoW2sVRaUUCnNent2cN/B0+8Kzdc4
	keoxLSbxIbEUVAW1JnH2Y4i0STuXS/BlykN2Umzw6Fp9CZVIrhDybCgDhERekIoyv1Jk=
X-Gm-Gg: ASbGncsk/VoXvpGvRTF8l/8taSdSrK9/dyFu3Uc7K6xJFJOpcoTBCBUWwJy5DWEp96B
	bwU9OKLkWeDxEVRkSxs44z8VlBemqzsvZeNqJ53G+BTULtX6bfONZh3WYm78D+gnAifJIt/OSAC
	0nlqjv/0qf17Gex+TAq5PoNRJcwZS4uzIB/qv19TpWD8Iui8QwY3dvSZCBQKqWwrCmRz68gsfIP
	iGPIee8SBl+LjWWTY7uy4DG9WvxsbgW2PAf2HgOiVXJco8CWZINb9uBpQpfzRRm7g2rnoU3umPq
	jn7iwZh+A3Zzljx7ebtKPfofHvYpv70Yv+KfT/6YUAw3yiAwcHP8S5AlKOjmt5jA3SeeAYWJPpF
	rcW31BZkCvfT62ykhKS9HIkpK/Nwt4TkKKJacSEIhYGe4YZzYauB4
X-Received: by 2002:ac8:7f88:0:b0:4b5:eea8:3658 with SMTP id d75a77b69052e-4b5eea83886mr16446661cf.63.1757080240746;
        Fri, 05 Sep 2025 06:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9MeUrOkje/yhcJw0U3KyLgE4LLXgaLmVOt6iaIs6F82Zo+mL6i2IiNuAwDQlzVrfywNScMA==
X-Received: by 2002:ac8:7f88:0:b0:4b5:eea8:3658 with SMTP id d75a77b69052e-4b5eea83886mr16446201cf.63.1757080239973;
        Fri, 05 Sep 2025 06:50:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c65sm1789340e87.85.2025.09.05.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:50:39 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:50:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/8] ASoC: codecs: wcd: add common helper for wcd
 codecs
Message-ID: <6igcrtfra6h75v5g3wucokxw3ncj3k66ui3jnhfpdf2lmxc3tm@3hzihrpgjaz3>
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-3-srinivas.kandagatla@oss.qualcomm.com>
 <kmm4e5bg7uehmlsgrfhzo4agr6ga6d5gxtpxq5sg4t3wql5p6m@llwyz4kzsj7y>
 <f6a631bb-d17d-4eba-adfc-4db08540f5a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a631bb-d17d-4eba-adfc-4db08540f5a0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3IeJvLVkIzmS
 gQGtsjmIcbnAY5Uh+xZde+s9q+S5vn8Oo0i/cQl61Femh2fzV3o4us290yZuCqZOsgS2+1ly18+
 DF35JEX2mKZ8Jmfbw7ganttH0fMSe+LthEp9k8SxbVfgIlNvdAgmYdiZ+ZiXO75et2o7AcyXzRC
 12L07dHmz4Su0mmM8sRqgfCHXhutXELLGBB3AMP/6dxa+FDCBOtxGVi9E2XzPIIZP9gabTihCZx
 nCZ/zcezPrSzB+GdMyCvHYvAD8YiPVYHQPdTtCOtYmKi7XMEpL9LED6wHhUJQSEKs2XhUBr78u3
 l6T4hBq/nwdj1s9zUVlRFLhPNm30lWZeGKQ3KewtAhO5h+nf85UkIdLIjr0kuHRvZBbe8eYu5d6
 8EJAkf9K
X-Proofpoint-GUID: lUlYXnsLBNDBUWbIZvKmCrZ66AEQPRcV
X-Proofpoint-ORIG-GUID: lUlYXnsLBNDBUWbIZvKmCrZ66AEQPRcV
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68baeab2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=vlklIGvXIyMSkDzfuDYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Fri, Sep 05, 2025 at 08:03:49AM +0100, Srinivas Kandagatla wrote:
> Sorry for some reason I did not notice this email!.
> 
> On 8/22/25 12:18 PM, Dmitry Baryshkov wrote:
> >> + */
> >> +
> >> +#ifndef __WCD_COMMON_H__
> >> +#define __WCD_COMMON_H___
> >> +
> >> +#define WCD_MIN_MICBIAS_MV	1000
> >> +#define WCD_DEF_MICBIAS_MV	1800
> >> +#define WCD_MAX_MICBIAS_MV	2850
> > These do not belong to a public header.
> 
> 
> All the wcd codecs have same MICBIAS circuitry, this is the internal
> micbias circuit we are talking about here.
> 
> Actual micbias value comes from device tree, but these are min/max
> ranges that are supported by all WCD codecs.
> 
> Why do you think it should not be part of common header?

Because they are not used by any of the users of the header.

> 
> --srini
> > 
> >> +#define WCD_MAX_MICBIAS		4
> >> +
> >> +struct wcd_common {
> >> +	struct device *dev;
> >> +	int max_bias;
> >> +	u32 micb_mv[WCD_MAX_MICBIAS];
> >> +	u32 micb_vout[WCD_MAX_MICBIAS];
> >> +};
> >> +
> >> +int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
> >> +int wcd_dt_parse_micbias_info(struct wcd_common *common);
> >> +
> >> +#endif /* __WCD_COMMON_H___  */
> 

-- 
With best wishes
Dmitry

