Return-Path: <linux-kernel+bounces-742534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F349B0F318
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D983A0482
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F012E7630;
	Wed, 23 Jul 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMIodODB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE847158520
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275797; cv=none; b=E/Re8l3AgpYzz4/Qb+73bewv1JQ5Kv7NFXiuc34Rt8YOOVnVbPTz6qlEDR4OZu7UfVLsOzHUWrGvgKFMKm2Vynho44qMcmKchbUgGnwB6StWvxLQk94+s7lNyqZvZ6/pcgwWJp1VNY2ePPlZmSLS0V1taMsZjgsaCQGZI1g/wIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275797; c=relaxed/simple;
	bh=hhGT76V8KdB/AnEeDkwM6i4rqMC9QcTFg6G6rgo2ZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzMLVIpCPcwAl0AD8rYKodmqzZrHF+91JBLCxqJnOYhFJFN0Zs9YIk2bdub/CulVqIdurh/GdDWhr/Jm+RnZFcsLgwfLPBH+bfJkNB6gSOpY+AZ61oWPhQZ+fWe4Uu8I+fr9hvd3e454DZdsjzUoy/VyNGnZyamlZQwwtHfT3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMIodODB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Kx9n005629
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HFQXzphQuSnwMWSCOzGzS0tR
	CSVlyDO4GAoV1UJnlAM=; b=TMIodODBr50HYsW3q7fVLc0cNlu/rVO8GRCYhzJx
	eVCOne+qNIuwo2L4P5jT3B2pNxH6NdvxAvAUTDKOMcJmcVWMplguDvbNQpclLixh
	TBphMA1DVNlelKWmJ3yh9qHPCJE9g2b1rAM9l7uV6hAwWCP+p1YPZI4uUR85R3Mt
	f32PQd9dctZA4MTXWEnutWFDVqQ2kiNqi9cy9uga2zBsfAo2EgdNi5sq8R/ZorMB
	uMS9F9N6kp7euZL9hBHw0Egf7jp3WGk/r7zsc0ic3Hc0IarBDRvqxbtNzR8iBbc5
	G5kW+SZWrMJhMkK2bpxkd09OS82lT++gRvWnFpCByCIylA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ubqx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:03:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b39280167fdso4957169a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275794; x=1753880594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFQXzphQuSnwMWSCOzGzS0tRCSVlyDO4GAoV1UJnlAM=;
        b=Mvqjey59ZMa1Rbuw/85aZNXrJDHt9SorM9SGTzGX0fpL8bLnOQgm2kk1JWZcUSrBIQ
         8CrMqS+7MKoFf/zz8a0aYTEi8JrGCefIv9rbuGNG8GPjQHcTVW9llusNHiuXSsSmH6J7
         NSYAR5mqDHrH7VWyBhp8D+jhcOWICwAqZ62RB1/LtfbiLx4pRPzGoFfpYoTAV10TqmLO
         +8pzH9xJbDfUUaGeM+fhjEwfapWiY6O+y4teot/U0WfIJqbsmuFKH/yw3XJvYv9DF795
         ViGsttsQcrxQUvMLIIefYZy6BLUMsQUDwZCIo0oMUcC8YVSkrhroELMSzn/VHaIP94JR
         KRuA==
X-Forwarded-Encrypted: i=1; AJvYcCW6/dd9eC61Yk2A/VEf1eXc0u7d+/N9CmbHDhjOV+Q9zI7Dlt6k2B7kNCKzijQjMtmPxYpqlLcrFDQNtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzmWbqycQ25VS297NHoOvSxBKS1e9gl04TdTnf3pKP76m9XiL
	Judi/tY4f/kRehsegikz3Cbk5wVG3f7rDH2nvW1I4OrQOK/6kaARo6LWfy4PUi4ZsFar3an/l2A
	5BdTBZbyxAl0Z9ll/f3qEO0AKc3aQYR655WxMNP1MQk8ZDV2n1YXT12R0cFpvMPOFU2s=
X-Gm-Gg: ASbGncuNoO8bcIdL6uooXOv89wiXHc3EeU/wnoOkqdfZByD0oQ68urogzFWj7IVYql1
	V7l4QtkLyE5NIA7fez7TW977bo99e3/Tx1UKxYZWFVPQ7XgA9bcOGQru7zk9AJPnVdRSU/gNErR
	x9CTR+gIzgffngL/2rUqQoyFl1ie+P2s4Eg7HzO8cMVxtSa+ic5IetFum58axT8i8M0Qp9chIkE
	5PdBpfoHpytGS1ok8FF+tdQ/WNYTx+d/0PJqqKHlHEBPp0WYkeXQTjTxfIA+vFGjYRYubETpj+E
	sgBHOWNFclvPmEV70Jl6qt3BLn+T+9W4OXgGieYQyEC2uubzqbqnaUm6gOFxO6KTn9Ab8QU7PAM
	emhYmapAhBFrY5yMWz1fpvQ++uXQVDjkNCszOTU6oKqaG/Z5XstUO
X-Received: by 2002:a05:6a20:938c:b0:237:c17f:9813 with SMTP id adf61e73a8af0-23d49122377mr4529999637.28.1753275793970;
        Wed, 23 Jul 2025 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFDmJryhdzdFntFB7Y2SSkvALhrP5nnK2pjFKNUd1foxAq5uu1XUGR7+ZT77bYOMHIDv5jdw==
X-Received: by 2002:a05:6a20:938c:b0:237:c17f:9813 with SMTP id adf61e73a8af0-23d49122377mr4529923637.28.1753275793474;
        Wed, 23 Jul 2025 06:03:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31ab0fe9sm2317001e87.80.2025.07.23.06.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:03:12 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:03:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ubwc: provide no-UBWC configuration
Message-ID: <3qlbyt3n6cmrrsh7srbxqwczf73mgd63embvlqvyugop4t7vxl@w367alhkh7zy>
References: <20250706-ubwc-no-ubwc-v1-1-e39552aa04df@oss.qualcomm.com>
 <DBJG7C0L3EFP.BOWGHS7WB4RM@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBJG7C0L3EFP.BOWGHS7WB4RM@fairphone.com>
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880dd93 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EqyKFdb9TEg4igYaHI8A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExMiBTYWx0ZWRfX/dCq57D/1sCg
 ls9v9n5JANp8PJ7BwQUvbep8AsKfu1WDvbtCk612KsKNr82+L7RN9WebYt81fJcEfNgcwcwrxSE
 xkgV4RzhkLM5JZQaugRQO0AdFjQVAYoXN1L3U++IGdYfgOtK+zU0cOL/WTgdsUBsAlLNq6Oocof
 NQbEjZjCWixQWSL+Ki9gPJw/uvtmg4hpY5tlsYFlaOlxyg/fOb8ZY8RXvaykuWgy1Ya9kujots8
 v1kKMtjXtnqo62ZQqHJLSZHWxmopR9Pctz0zJWLs8IHH/t54o9tB3QwsuMQMbTKSM9bEwyExe0d
 kicMcvDXYGcIDejn4cKcdwI2oW7yM1Z8FE7c2R/hpa6XWAM/+BqY3zCe3cNekIH3291sZkqXXCS
 Dql0BhCIFJozaemOm9i1BGQ/IQoqCk/znt/0SIznqyXIgIqAa5xVMLH/Qjhh0uiyNVrRqk9G
X-Proofpoint-ORIG-GUID: OFLbMwfLbiVaSLGTakKq_GUGAcVlQO86
X-Proofpoint-GUID: OFLbMwfLbiVaSLGTakKq_GUGAcVlQO86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230112

On Wed, Jul 23, 2025 at 02:54:04PM +0200, Luca Weiss wrote:
> On Sun Jul 6, 2025 at 1:01 PM CEST, Dmitry Baryshkov wrote:
> > After the commit 45a2974157d2 ("drm/msm: Use the central UBWC config
> > database") the MDSS driver errors out if UBWC database didn't provide it
> > with the UBWC configuration. Make UBWC database return zero data for
> > MSM8916 / APQ8016, MSM8974 / APQ8074, MSM8226 and MSM8939.
> >
> > Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > Note: the driver is a part of drivers/soc, but as it got merged through
> > drm/msm tree, this fix should also go through the drm/msm tree.
> > ---
> >  drivers/soc/qcom/ubwc_config.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
> > index bd0a98aad9f3b222abcf0a7af85a318caffa9841..df074520a8cae1a202a14ca094903bb1e7389066 100644
> > --- a/drivers/soc/qcom/ubwc_config.c
> > +++ b/drivers/soc/qcom/ubwc_config.c
> > @@ -12,6 +12,10 @@
> >  
> >  #include <linux/soc/qcom/ubwc.h>
> >  
> > +static const struct qcom_ubwc_cfg_data no_ubwc_data = {
> > +	/* no UBWC, no HBB */
> > +};
> > +
> >  static const struct qcom_ubwc_cfg_data msm8937_data = {
> >  	.ubwc_enc_version = UBWC_1_0,
> >  	.ubwc_dec_version = UBWC_1_0,
> > @@ -215,11 +219,17 @@ static const struct qcom_ubwc_cfg_data x1e80100_data = {
> >  };
> >  
> >  static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
> > +	{ .compatible = "qcom,apq8016", .data = &no_ubwc_data },
> 
> Isn't also qcom,apq8026 missing here? Not sure there's any more
> missing...

Yes...

> 
> Regards
> Luca
> 
> > +	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
> >  	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
> > +	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
> > +	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
> >  	{ .compatible = "qcom,msm8917", .data = &msm8937_data },
> >  	{ .compatible = "qcom,msm8937", .data = &msm8937_data },
> > +	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
> >  	{ .compatible = "qcom,msm8953", .data = &msm8937_data },
> >  	{ .compatible = "qcom,msm8956", .data = &msm8937_data },
> > +	{ .compatible = "qcom,msm8974", .data = &no_ubwc_data },
> >  	{ .compatible = "qcom,msm8976", .data = &msm8937_data },
> >  	{ .compatible = "qcom,msm8996", .data = &msm8998_data },
> >  	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
> >
> > ---
> > base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
> > change-id: 20250706-ubwc-no-ubwc-3c5919273e03
> >
> > Best regards,
> 

-- 
With best wishes
Dmitry

