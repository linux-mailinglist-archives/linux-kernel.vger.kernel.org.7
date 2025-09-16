Return-Path: <linux-kernel+bounces-819139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ADFB59C00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C218817629C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A62320A38;
	Tue, 16 Sep 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1FytrLZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329C2264B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036249; cv=none; b=K53b24cZNtYQ16yULKaIFRHtoy23HPdAD30KaqX3/tLjF3X2puFNWhVZipalcn2NJNsYjIi9jesvBzfdcBsrwU2SwYahFWI9n1F2cGtvCo6ghpkhfbuTaV2B7KHeQAX4OwxMGaa3rhSXb2IR4JTYNdOoUgtMo3r7XtpdLQ96U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036249; c=relaxed/simple;
	bh=QtaKSBDW16KCWpDQej0w3KV1bPwSRIUQZFPEM7MtEI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gltpPpHnNRVaCgLa6zyAyfyKmjuvNH+zrAcks9sHyGB8INHV+YzwGgEvU8WqbxRGDvoDGA7oqMPhSVYuO+pht2eshoH98SfgNhpqhoUwEuuQmK4H4oDklCtyrELj71PgJhVdq3DFWR30UyE1JulRCx4Q7b1dPVqK2gDezwdF5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1FytrLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA7lFj020302
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YOAZ40DrsPCGrdYCkt8MTvOj
	Gy7jGDD/2JSb9vwK9ps=; b=Z1FytrLZt9wFuBQrrMGpBNnYUiHlqKmretL6Qev4
	n5J0xGXBBsdPv3FP11sZxEp0yBfLFd9c/c5b0z9iuuhsZTiE41ITRAQjEWp99Y7S
	l/1uSHccNcP5vkoW5M/FUViN9Im3nU3QlLEcpSEljp+ymZmmxwIKqMOjwP5d2VD/
	4h9gE6yNq5hLrWBqgZuPxAcoHeWt/GKxTxeYhZFthqjoEay0w+fWMCTBY/69fnwn
	1j+OXy4NuCAaIvdwcs7g59QxJq5ZDG1cZj1Q3j91zkfpjHVAIc9c/vliia+MY5bI
	DvutR6XWcr2f870YPy95LzCKGRpTUmAHyeJyLiwgYn6mmA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1smvt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:24:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f290579aso114804621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036245; x=1758641045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOAZ40DrsPCGrdYCkt8MTvOjGy7jGDD/2JSb9vwK9ps=;
        b=idiX20f0WeOvL0zu7T/G8jkC0rDtYfobFXpt0ZQwPW3HMZlQFo5DLGggNSApatmx9D
         13Bsrlr8v1ZOjPWW0mD7LPScMoIPIxHJ3T67tX21Hl9WSV+JamII/UuSyi4+hM9LSJnp
         pYgN9x8wpUTDGPy+eaESiv8mofyLkGAWstG67Zc8N1g/qAUXzIbAI2GjK87/EcftIRUS
         iuwZKaAsqGaXZQbh943pF/4CJiF0JRAj90TNChT+RswMPv+lZydad7odkafohk/YqetO
         mU/b70IMD2Au9aXMuGHJzt27IieINjBnIOLpFtHax0qv37uBRYn/CDZSUsy92BBZEQ7I
         P5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWo9t7ki/rd61R6F1miKDiXMpfkPBFaX8/9cu5wHDvyDUoynisrZSOb7K3tdYN9pRa5svEKw0z9ct8XHYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgl+UeZPTW1zCGYM7vyw7wWWNO9WxOet7qXSWVhnbOq3v/SeRn
	P+8G9sDqe8H+xtAmK9RHsfDnHESukiBAi/xizYJilo+x2qSh3DrzfVLP/R+cVzgn1cPoTK1Cok5
	KvAJDkrI54jfQD8ZufF5VPyydABsEmEQ4G9m85zGFD2f+Fqx3ZedSjx0I6WG8WVOPvJc=
X-Gm-Gg: ASbGncuyLNq38JGgtt7yp3p+8T43OzGW+Ol76PDLgrDWkg/2paUnuRoc7yWzywSNfZw
	gzP9ePkn5csdwDRYGL4oPjN2/eunJyIhch6pthGcYF9odHgGxDQj5nuZvg0rxr2fwITfeRzEVO2
	B1ZRuE1ximSnD3QxhE+i9zUq4ieA1fjO9WFmq+tEf74nMY9IatJ/v5ieBGtS27G3h+6kUKmvZsS
	0H1PsVdQSekgFkWmvH0meJbT06sNrXmuRaq7G0FjkUNQq+gb83nRKviJEGkq5eS8eOsC8XDEW3b
	nkfzfW+iHOiJghR8eg+5vo4zVUrFY45UvSeGgAh6ovL9EIovZuDE14xSdC2u0wTMVgCiXJtOqDf
	ZPBVJ5Sz/hFHcfTiOLN2Qx52uXKHAxKeZwdM7kcRdv7MqQfqWC8bw
X-Received: by 2002:a05:622a:4d45:b0:4b5:e644:67e with SMTP id d75a77b69052e-4b77cf982a8mr280631101cf.16.1758036245355;
        Tue, 16 Sep 2025 08:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoeXaD4RPHM2aloTgPF1kNC7rywOjcpj1oNZKOTTj1VqcL1edfsgvTKtAJQPrPo3ytrJ6T8g==
X-Received: by 2002:a05:622a:4d45:b0:4b5:e644:67e with SMTP id d75a77b69052e-4b77cf982a8mr280630341cf.16.1758036244775;
        Tue, 16 Sep 2025 08:24:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a58316sm36218721fa.8.2025.09.16.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:24:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:24:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Remove unnecessary cells from
 DSI nodes
Message-ID: <ww5libgz6c6cfisch5um7sanhdvnm6aoz6uaqq4vbiraygmiei@fmxpat6ofd7a>
References: <20250916141931.601957-1-eugen.hristev@linaro.org>
 <kday4tlzjmycgfexiaxgwnan3a3nfxt7sgslncsktcyw5bmr7d@nmjtdm3gd2sk>
 <9d74713c-00fc-4a17-92ed-b3e3420160e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d74713c-00fc-4a17-92ed-b3e3420160e1@linaro.org>
X-Proofpoint-ORIG-GUID: NASLAlP52mlVJhAZEyNeJ9NrRgkvf0XU
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c98116 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=kvEb3oXna-i2HelZiMwA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NASLAlP52mlVJhAZEyNeJ9NrRgkvf0XU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX5l1vRGIgAga9
 AEWwuQHeYXtioq5vybZWT1LyqqtdE2R6FEtDDrmzwFoG3yVoNajOUp6uoK3/aCFY/OK2EmoCEaO
 YItZ6vRQYSmyYQljmVaSBOuTbLd0g5QkbMBDPib+w2eIvk4xJzrzfZ8QGjrulaXbwx6Q+JdhNV+
 b5Gn+UcehdzFYAU78D37g5UONNilS2D966U2MKaAKg7uLhCFwWAQByhHPQcbPc0px7Y4QbLLlnW
 KGqNuG3VfHx9Y+xH0/PYJj9cZcKgE3T0fsG3ARhHmIiprbcDGALe1pIFiEaeC6gTEpKejaj2P28
 bI2/rcFPKCnTzHgpj9iyaR5T8qFaMPjjqmb4BLsbxIuj0OlbPWoqM0WD3u+5mJCthOLTycvgdA2
 nZaErM5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On Tue, Sep 16, 2025 at 06:11:07PM +0300, Eugen Hristev wrote:
> 
> 
> On 9/16/25 18:03, Dmitry Baryshkov wrote:
> > On Tue, Sep 16, 2025 at 05:19:31PM +0300, Eugen Hristev wrote:
> >> Fix warnings
> >> Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000:
> >> unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
> >>
> >> Fixes: 73db32b01c9f ("arm64: dts: qcom: sa8775p: add Display Serial Interface device nodes")
> >> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> >> ---
> >> I haven't found a pending patch for this, so here it goes, sorry if someone
> >> already sent.
> > 
> > Thanks, but no. The nodes are correct. I don't think we should be having
> > the -cells boilerplate each time somebody adds a panel under the DSI
> > node.
> > 
> 
> I understand your point. But leaving out warnings for a possible future
> node is not ok from my point of view.

Then please fix the compiler not to produce those warnings. This applies
to most if not all DSI hosts, not just DSI controllers on Qualcomm
lemans platform.

> 
> >>
> >>  arch/arm64/boot/dts/qcom/lemans.dtsi | 6 ------
> >>  1 file changed, 6 deletions(-)
> >>
> > 
> 

-- 
With best wishes
Dmitry

