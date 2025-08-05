Return-Path: <linux-kernel+bounces-756239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805FDB1B1B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C02B3BA69E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08930260575;
	Tue,  5 Aug 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LuKoO6EX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D07261581
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388299; cv=none; b=pqoPuXu/iOJY9OZxFzf+FNoBbmZ7Qg9/c63FSURP2eVxxdX6suXMX5tgaeb5DJ2fsz/yb5tMpA8+QtJ4rvsFmnLVSFu3HcvcNK+w8rd6go1tUoiP9AVQRDy03VdTwHJoirZtGhD6BgYyBTfLi0N5DBFStoqWqKFaSPsMty7Z2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388299; c=relaxed/simple;
	bh=16NaxHMSEZhPQMhjlmNpZcKyw1FlxxouGtxWL5uWmvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buXJMYNYQeFKOPJP5hkrEU8PpEW+LUwFnqgiyRFjiw4jNG91pry3y68/fSBYVeHJ+yfFf94GZubcNUE8FPsCDWCYVtJYsfuV1hkJC3FjTyDH5T36O/1Qv0DD3CRKUy+2qxtL9czcNGqpLKSSin1ZEZwkIXoP1N3Q+WtzBFT2rlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LuKoO6EX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757siJR003249
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LZ1Q7mltGYgZKuRjlXj10Xho
	1f26ht9lWK5c6ij/Em8=; b=LuKoO6EXUBF3DJ3QOFvbziK7d2B+xJruqrjmTwWQ
	HQGi0xUweghEiGaO1TCmBXJdUPjaTQTXBxHp+880PfmTamLyYm2ilfpcIDw03eBG
	c+mMLgCOBMzBL/b1XL2oxgskxsRB3frhm8Hxbd6MXYuA+WveRUn1rZhx5yiMPnIb
	gNpQapczuBtAOMSPxz65AYoChJuJTkX0SPVu5tbvYNFXTzORII9jH7ibxDROdiKM
	x3YHb9G1gcnZe5VtTDIPZOPICp9HXHlR5udn6fDMpV7x+7rceQKa589aEQZDKerb
	qhkW3l1drm8MYMNMce0XjFmu0U4pDv4Y4YF5mSyiTXZ0ZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48b3j3syhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:04:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e6a5428a76so554303185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388295; x=1754993095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ1Q7mltGYgZKuRjlXj10Xho1f26ht9lWK5c6ij/Em8=;
        b=jhaOzHRUcjahDV6wovjszDYAkvgE8HnxDoXNq976A7lRHKgGG+YS/fmTp41zu0AIkZ
         iXyTSYydJS6olz0NkVPrGGDwM0XVxTZcbwj2rG3pbci8ElEK7gBTYiF/oAqKaLgJRjyq
         CFvWdNwrrJAsvkxXIde0rGxlCY4KJTZeu0vMYaIljeTzWmE4ikK+DxbAaSbk6Y85UxMw
         74IXsD+pPY2BEurpnpaKNBPs8RqfZJyks655/1fgysfxDsnIJmvC4X7vHF0nbMc2iORx
         JQyklu4uvFkvqpdS5plHHA/8Sstys9MMJq1DZ6gVOXsNN6AHY51futfFSQwxrOWGAVBX
         XLqw==
X-Forwarded-Encrypted: i=1; AJvYcCWqQctrH3LOUOrZLGcDAdMKdvUmTpw8KhdJHuCbNVisN926Z2PTWAxhT+ASdVgq5RX8TMo0rM8xJi4TvXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cv4nC1tMg3L/12Ck085IEGN9uSt7NYWjyuE+He2YV0JSwe1/
	ia5/lq7ftJTPFDjaaLU493os06Tl7XbWN96OR8UQKUPown/v+Bu+MwMm6WB4GcNCZq+T5FL5nu+
	ceEgSZ2cX+lw5BFAuN3VpAm5FBcWNyZnCayIM5GVNXC1M5oUOeez7292m3u3MZvSiMIM=
X-Gm-Gg: ASbGncs22SpD1pFhKso/53YiJCtxvDUxxmV4jt8z/bDQev9mIw8GAo36vXqeXUdu0OL
	OqUkizksGhaXx3IEuI1ZZAnoRwofRU6wtle8ZAu1T0P8f64cyIuuvtmwZtuo+ZjX+sEv9iHRLOu
	/Bpp8wRMBpZLjiZUkAtLR06Qi525J4ZMjzu9bVPKqFSzyv99pkkCq0PItqM7XXBWdl2VI/IwxZi
	VvQHtJ2ITj/xYDBjdkYnbF/rfaAbru7LC2mwa0xSgNVy3zJ00IBkGchrsNX6qSMViX6T4aQbz2d
	L7UgNBb21Wd7FmC5lyEru3VOeASKKS88jEdX+AplfMoI6/jvSXXArAlqTcAvQ/tRztuB0NUxXny
	vG3uTGMvifwKo8sRlesiqRER1VcpBmyqEnSlDAhL6fxh+iV4+XhMy
X-Received: by 2002:ac8:7d12:0:b0:4ae:cc49:e9ac with SMTP id d75a77b69052e-4b07fae5b1bmr48885151cf.29.1754388294848;
        Tue, 05 Aug 2025 03:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjc6p47qGpkwh31qlCKW+VV6tTU4R+W2maetJnUC3VlVpc14sJK3TH5Iz5iQDFhJnukuCBxg==
X-Received: by 2002:ac8:7d12:0:b0:4ae:cc49:e9ac with SMTP id d75a77b69052e-4b07fae5b1bmr48883671cf.29.1754388293461;
        Tue, 05 Aug 2025 03:04:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm1926807e87.30.2025.08.05.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:04:52 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:04:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
X-Proofpoint-GUID: ctr_DhZQgJyuP8R10VwhomVGHJYN1Rae
X-Authority-Analysis: v=2.4 cv=TZ+WtQQh c=1 sm=1 tr=0 ts=6891d748 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=lzajS59LejGemfuab08A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MCBTYWx0ZWRfX71ZWlzBisTYL
 URUqEHPMdCUTpcmaLC39hDa/Vj/jmFjIaOduv4mwM5tvhuE+zriiHWEuU7y9mirm3YFNEPysVk4
 GkI6kEkeB7Bs7mDWoxRIJIJZbSFtSunLJTxIa//zjf/62mk0WuMcji2HmzLAcaq1J45pl4NA+eB
 c9j6F415l+CmZZLpkc51rCRtxPXHxDa4Pam6sTASiTWwmG/vIJWwcBv7xzbSqzadGlHWKbggvPC
 uJ34t5Hxi8RrsBXpmwcCpPvUflB0GCAMWkr1NSHdlYl4Ybt80LjBlSzb+BYIRF/b2U9+ikidfBM
 xGXdkCHRkYCBAJv6jzVznwDVZDsXrzE06pxvINEc3DvaNvLDmxulb3IGwSqcfEKziwkYQg0IUG2
 xXYN+Ueq0j5IVkzHz15sJaxBu57cBshyH3qFe5silMTKLTeGuhjRpegSpluDasbCMU+ayobq
X-Proofpoint-ORIG-GUID: ctr_DhZQgJyuP8R10VwhomVGHJYN1Rae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050070

On Tue, Aug 05, 2025 at 08:44:28AM +0200, Jorge Ramirez-Ortiz wrote:
> Add a qcm2290 compatible binding to the Cenus core.
> 
> The maximum concurrency is video decode at 1920x1080 (FullHD) with video
> encode at 1280x720 (HD).
> 
> The driver is not available to firmware versions below 6.0.55 due to an
> internal requirement for secure buffers.
> 
> The bandwidth tables incorporate a conservative safety margin to ensure
> stability under peak DDR and interconnect load conditions.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index adc38fbc9d79..753a16f53622 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -1070,6 +1070,55 @@ static const struct venus_resources sc7280_res = {
>  	.enc_nodename = "video-encoder",
>  };
>  
> +static const struct bw_tbl qcm2290_bw_table_dec[] = {
> +	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
> +	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
> +	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
> +	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
> +};
> +
> +static const struct bw_tbl qcm2290_bw_table_enc[] = {
> +	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
> +	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
> +	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
> +	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
> +};
> +
> +static const struct firmware_version min_fw = {
> +	.major = 6, .minor = 0, .rev = 55,
> +};

This will make venus driver error out with the firmware which is
available in Debian trixie (and possibly other distributions). If I
remember correctly, the driver can work with that firmware with the
limited functionality. Can we please support that instead of erroring
out completely?

> @@ -1080,6 +1129,7 @@ static const struct of_device_id venus_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
>  	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
>  	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
> +	{ .compatible = "qcom,qcm2290-venus", .data = &qcm2290_res, },

Please keep the table sorted.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, venus_dt_match);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

