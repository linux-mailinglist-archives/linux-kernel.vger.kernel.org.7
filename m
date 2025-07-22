Return-Path: <linux-kernel+bounces-740746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39145B0D88F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D965AA092F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602B2E2664;
	Tue, 22 Jul 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqYDjf2t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96C2E0919
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184951; cv=none; b=CJNQY/VzF2KW1Ljk/CAf3sp+Mrg03U/rBywpm+Dz+AvqYXYjPIfO/lkUQm7fIgtH029C+/IgFRZ/nlWZIumJuPR/7skmYAKc2Gp5wpxWB92hR66s3PFTA593EBYD7VNMHMvw6weOK1PaqLUHzpFziQ9dSBKJf+a7+46mYO5ONL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184951; c=relaxed/simple;
	bh=g5o/NJLgr/+KZfh7NhSKbgenLoX8ddEIOkGuZqnLS+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnCCgtDGCLgVA+wpgUdAFR6VXh/Z4v+3/k2i/9l+RIrUI5dQF/NdYUQ8cf3DmQPcBpoOKEturLoDaLaCJTuVaCOpwQURoN6ufK5Y+v5Z7XgCVPKXg8s4TBZpF9OY/NrGuKg6ru+shtMiP+gEPXmT3vNsB2JTlT+raNAgLTV5mSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GqYDjf2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBJPgc000995
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B5yI/2W/uYPNoZ/4GmFrmy4p
	o+IDogR9AhFLE+hirtk=; b=GqYDjf2t2uVqAHUeg3Vd+LkW1TXtE4eAV0g/7vUs
	6jHuV78xQ3CAewTGWj8qF74gcbU2tLapuvs3S1xhEeImjZySEk3Y2gK4z9rrXO0u
	mCcsGJ6zRqEk+KnldI4G5YOeYfwOySeckQ886d/PnjfQjenMoY4M2A8IbOZG7r5a
	Tm6MMDQqJlnNhNYX0r6GdNfUmymuA5eiVE5e/XP2ZYP2Ww6XH01/ujjG93SpMyNI
	y0FQhwkUbjYkZlurh8UQyjZqhpUhY+8vsut8KE9PDBbnAznLsSs/jx5/f7xUqX5F
	fF8ShTYqTp3rewB1P0XS2xOfk0JHgdSZlcrihCn0QKm8dg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dh5e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:49:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e347b1a6c7so1296274385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184948; x=1753789748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5yI/2W/uYPNoZ/4GmFrmy4po+IDogR9AhFLE+hirtk=;
        b=Oda1nr5+o77VVagm8QfIp/K7lbIU6Z29CrsviHZPXGixeUGDQkaaOD36oMAeX+Fir8
         LzIptBpHdjHHEkB5kMqUmz9aZq8Z5VEEW3f5plB9VZ3HDmmW/hkWQ10ka1znyfJzund4
         D4Jxzwm87hRUQilt+DZWQV3ddeFgkO0O7ZoRifsR4HXHlcTZ3r/JlXMfTwrJraXl1WZn
         PfMQmmLuBsvPq8HgYx/gKWwulM/ATdGOo/Kl7DXilDzYm5PWqfRvS1zuQS/4DVB1zOjT
         cl72yzeY+yR4xnScVPbWbmdVmr/NoB8y5MY82ffSvfTAU1kpWnzRV4JgCbGhh1piqKXj
         GtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXdiN6lbG1Gj5zBBbDq8odmH4bqbvmGGM0SIA2Hq5t8rfPfuva1mTYzf1xsOzN9PjwszwjvGJCsvcpu/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/z7Zs2/KmFrV4Q3vzX6Pri56KzCgA8mzxlvlc/0IhxrjkUUy
	uQUjM0R62z8bvP0JkbQd7nFq30gjpzeBcDM8t0BpAJFnKL47tRQYWWwpZeAV4bDPG3fL6mhmW3L
	LndHSL2g07o0Sz5SYO0NcFy6iAuIn2FaSCVQyso1CNi5eHcfHl1qwPjKhp2/QKjGdJRg=
X-Gm-Gg: ASbGncvOOoxooiAwuAjqQBDNfatj93xfyM+CgMCIKMYkMuir55HXUbJ7Xkoiy5UDPPl
	T6PNprv3QsL+Y1DGnSNJHFLK3aGqGNiNceisHE0NO6nsMgDb7jPAVM9q/QzKI9J0fHnkqaJlRb/
	199bsGuhL6RbQVhFm2XCM/Ko0J1LQkv/LT10TI5R5AkzsKy2yX2mJdMRUhAUurVF05XH0mlukx2
	5mhCuy1iI+ONB1tC3Ve83GuY29zOOgwEkhGIAXYP06mt+9rn2gTnRFaXYvpg+s4aenEcAaHJWrJ
	iN897Px6Qxy8vbnIGTCoHDl6w4A4IsgGY4qOTgHd016C/hQjfFuzA96MjHf0rX4I2TgH/AmqPXB
	7OgOb8zXY0i+ibk0ZNPB2Lu4k5dLVYgnR8iYuB/uKkm8r6wjwW7Gs
X-Received: by 2002:a05:620a:318b:b0:7e2:733:542 with SMTP id af79cd13be357-7e3435e9e32mr3649940185a.36.1753184948556;
        Tue, 22 Jul 2025 04:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEePpw0gnZfgOgD+EN9ULc+lx2jNFrznEEMSRNdte1hYVihbfjQ0YCdAjzvf6azH9JLj3QIsA==
X-Received: by 2002:a05:620a:318b:b0:7e2:733:542 with SMTP id af79cd13be357-7e3435e9e32mr3649936285a.36.1753184948067;
        Tue, 22 Jul 2025 04:49:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9cb18sm1909407e87.20.2025.07.22.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:49:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:49:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
Message-ID: <uh2lkqa26lavl4evsckiontkmjaiiwvz6jj7zjwylrfojtd5ne@ibk4ckgrsygn>
References: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687f7ab5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bYW4DojQpC9BwyScwp0A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9h_qNBCsk3XkCDSbtLX3K9FqywxZAC1P
X-Proofpoint-ORIG-GUID: 9h_qNBCsk3XkCDSbtLX3K9FqywxZAC1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5NiBTYWx0ZWRfXyOzBgQUVwdL0
 EbJ5D5Jh3Y0gKTVlZt9dy7/LsvoZSnbMgskTcy1BYrEgDRpHeYkaguhxkeW2biPr5jdPkIPqZ5/
 1N0J8Z7L9vdnKRJXpLB2ogKFsXMLjyOLzPkFbkWfkKrn9rryZstCJyTNqvx1xMNI16IRo4Cbtti
 gCs41SluB21Dm8p+1CYLRSJHlCM7CDiPddBpgbEpcLcmSWNAxV4iDvxJ9pIg5KchGtcRxXOLMpX
 ICBEMPKV3yYWoe9WPCRdD+2XdJ6qYneTWCitYeSJAD/ag4l+zKHDwHRcQVgBUyaCErxTc1wTyvJ
 AKE5WNMoFNu6Qvt4Ht3RckofiN4pLpciuzFULvsnyuLFi4w1ejIqNsm5nKiQxUHooHZf/UcZFCC
 RFz4i9+RrMjkICbhroFc6WhkX8cMEURk2qXs7swTtXil85j9yqPThmscRPSKl3kzlntxSOns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220096

On Mon, Jul 21, 2025 at 02:35:04PM +0200, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
> the Frequency and Power Domain level, but by default we leave the
> OPP core scale the interconnect ddr path.
> 
> Declare the Bus Control Modules (BCMs) and the corresponding parameters
> in the GPU info struct to allow the GMU to vote for the bandwidth.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

