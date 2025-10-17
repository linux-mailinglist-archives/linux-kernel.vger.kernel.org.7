Return-Path: <linux-kernel+bounces-858071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28933BE8C80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD88D1895011
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9A34F479;
	Fri, 17 Oct 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlLyrrzw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983B34DCF2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707064; cv=none; b=jd8VlmUMxrGCE49UQYeTCSNqJlHgMdrSS7SsLhGjak5Vq9Q1TlngmL09yivM0yeEuqUw3BOohM+egEVhtp2ogCWyytMExp0byIorpPL936SfklfK+zLrcjnx7LAoCO5q9J7EBjLBylYQDvxSCwDVjBRaONWcbUvwfSW1waCW3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707064; c=relaxed/simple;
	bh=bBet7OKcIFo8/SortnaFr6ndbpW4yi8PlghaYES4Z50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjDBuOJ3/QEUFXO14lNovHQoyTvfvTIMDUYqkBCImxTOujs8gSTDxBiYDv7AUjgC85/A3fVNHlyqmmnQNjBsNNq3vK1aMvu2QPudl+6Wu+1tmxSppDSbn2r1LHmPupjlAX/kT7KGfv8Yv+i+XcTWWxLx1Tv1oEjd1KEfMF/dZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlLyrrzw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7psjj017062
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3LILjlfqEYOLQkEETs/dYDTn
	PSt3uyaP94CFMKgd6Sk=; b=jlLyrrzwtrCiJc+Phc1WGAhn3uCYpQEpV6fp4kmQ
	IgSDmMmz4nwq/hXvFoNCiLhVJQQ2/gHO/M2xmyip868BiXM7Wa5rhetqO2bY2Vkj
	dX77ZmUZpKQ41bKC4YLYVbfYTpsaXiScROwBzLmsR/6VsfoME4Vi4ksSJXoKXxJy
	ywT4AnumPn12zPcWe3TOUBv52zWiNFm1wU2Ir9VyuRG0DN4JPfrX8IckxmsAO/sz
	B5HSU7OvjAiz5JQhl6hIC6B8GYIX2rE6c/o3l4xzvXioX04K4TKxKvn+lfjvxhV6
	VZp5BuiJ3Etwr0MwahRyuBBRJTQVie5h7esPIr9IaejlIQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5vf6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:17:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f7eff9d5fso716397085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707061; x=1761311861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LILjlfqEYOLQkEETs/dYDTnPSt3uyaP94CFMKgd6Sk=;
        b=qt0Wv4Sc/5yHbe1DdLegtTSwoXnFQawop+kWUPT70G1pJY5Y7dMMQDG6BQ3rIq0UHz
         PUUuxCxhs56kJDI+IxWuw9ThuPrjaVADXYu2RXMCj2x+8V1COy9EgPlIGnqwr6+dMLSb
         XkPoyco5EdFc8jZ0vy+kSS3pov44qQ52dlMEJOTpxI6zpztG57LzwGZofBPg+KhbfVpB
         RUje7FNL5nHt5ep1lhX/FoaN4D/2fnP3spozqTu4VgiQ3FDEnB5ZpccwIEzP0TwMpOJ7
         O2KM845XsZsr9lpKV1X0CNM1qWgtASFpfk0iTdqhMgyh1tN7htG0wnK576XCuTs8iZob
         wZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc75BDhTJMdnrl1kwX5JrXFxvfSNuiPZuYQ4CqosBUpC65yTasuvcwPxI262mZuW1ypAO5jByBU7V9IhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIHRQbY9sFSPHqNho+s4WM6BLDCaxq6z0PTwyQbFxDgGuiahl
	9D457KRiPGBQ1NKJo2RjdGFFXo6JhS+4B69xyv8BdIVR20X6zDsGzEO5JQkcYqGEgZ6jHMc3SVL
	hZjdxPDVjh3ewg9Udr1wESRsoSNTBBePWP/eKYub3Tdbrs+B1NQaqz/WkGeucEuZmt9Xhz+8VRU
	M=
X-Gm-Gg: ASbGncvHbhOwwJXSzzOCdn+IiNHUT2NGktm2GzYVWU+GrY4uoB7in9WYm27EEsYeEhI
	oHNFGwyBwOh9FVjT/yp0sQfYAvgpcPGm7Wwy6ioQ4ac/nc/3rbsqw1RvoWltZ3VM3AYwvvlg+l6
	WrMp0zYL0IMtCkC6g4gXdCvQgssyrm5SufgJu6o0C5J6EZgwyMzK04SUkF823T3xYnTW8u02dIh
	PVH0tyE7VNQJtVj7ljRNZKEtAiQqQRyK4e2ixLvSW+RXHxXJQlU7FOvPI4pJAjbw0EdJxF18Ynt
	4KMrM93WytRZ1v+O3mQMkGbmUkTwBJl8sEmiCxz4fuu5SyxnvekDl2hu8YyKlz1fuIOjsSa7VpZ
	UcTsQ0J/7nZJwYNgMOTexcGPgCS0LYKkekNKxeZvnqNDH/e3AbORvfkFBHmKA74KksOvGN6NlAX
	aLFWoGUXbL5kE=
X-Received: by 2002:a05:622a:1482:b0:4e6:ebcc:23fb with SMTP id d75a77b69052e-4e89d2b9904mr60570481cf.36.1760707060800;
        Fri, 17 Oct 2025 06:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7v+jw5TyUGE2GPu1mMtX3P0F0LCVH2wPKYMO3Oz7sZ6e30VO+kzOqFROiuxwu8cIa+k2C/g==
X-Received: by 2002:a05:622a:1482:b0:4e6:ebcc:23fb with SMTP id d75a77b69052e-4e89d2b9904mr60569691cf.36.1760707060268;
        Fri, 17 Oct 2025 06:17:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea3ee2asm60957181fa.50.2025.10.17.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:17:39 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:17:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: prasad.kumpatla@oss.qualcomm.com, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/5] ASoC: dt-bindings: qcom: Add Kaanapali LPASS
 macro codecs
Message-ID: <nvomxjtxisrwb6gnqf2xvzo2sxgwsoquvvdiujrbhvjm7atwgw@g2jpwjusfcz4>
References: <20251015-knp-audio-v2-v3-0-e0e3e4167d87@oss.qualcomm.com>
 <20251015-knp-audio-v2-v3-5-e0e3e4167d87@oss.qualcomm.com>
 <6nyqz5fsqyqgtsqk6xxm4iorzoelhkgnghm5xczh6iamvmdfpa@2vff2lk6sq7e>
 <3d96ff4a-1d3d-4089-b571-b4d28062566a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d96ff4a-1d3d-4089-b571-b4d28062566a@kernel.org>
X-Proofpoint-GUID: 02z1kF_7B_xFs72_qKRi4WfRkB-JNDQY
X-Proofpoint-ORIG-GUID: 02z1kF_7B_xFs72_qKRi4WfRkB-JNDQY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX3/kTa0U08Yzv
 ++XsuKM33qB3RJkeUytNhJqjp0h8hVmiZIG+ryaXipqrKm9ebGLnlzjF7Yypre0xUNOVxMw2pwt
 3k0Ct6vmEyPUcgzXmBJrzh4SX4TF+zBynmI8xA2OTeH87prn5xDenkqAYGgjtXKw9ZVRAYMSsdG
 lR1pyMlShpTztizS6mTJBc4alQ8KVHdWn62BeEXdU5WIGxN+Yj97J4VnLoKcEOONeVNtZ5Mr17t
 veqaVLsByo9foKxSB57a6aFoVBmS97cjdBZCL7jbKNU7VV+1ds+7hdgrrZzvPZlwrIcFxZvqO0N
 ih3+Oi3HV6O8d+aSlM+nkupq8vNhNu0wylFVSBnj2hbPaztstxun7n82n83kZpYumIbZF1pvShh
 hMNqhZ/CkJ/l41MJpd/dFRG9iMlHcA==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f241f6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ugvR7wMMjgv2hvCkpHgA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Thu, Oct 16, 2025 at 08:59:29AM +0200, Krzysztof Kozlowski wrote:
> On 16/10/2025 02:54, Dmitry Baryshkov wrote:
> > On Wed, Oct 15, 2025 at 01:27:19PM +0530, Prasad Kumpatla via B4 Relay wrote:
> >> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> >>
> >> Add bindings for Qualcomm Kaanapali (LPASS) RX, TX, VA and WSA
> >> macro codecs, which is likely compatible with earlier SM8550.
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> > 
> > What does this serie of SoBs mean?
> 
> To me looks fine (see v1 and v2). Prasad wrote the patch, Jingyi changed
> it and sent. Then Prasad took that changed patch and changed more.
> Perfectly fine.

ok

-- 
With best wishes
Dmitry

