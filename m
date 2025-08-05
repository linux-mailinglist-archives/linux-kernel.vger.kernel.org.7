Return-Path: <linux-kernel+bounces-756276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E4B1B22E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7313B4253
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998A23F295;
	Tue,  5 Aug 2025 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZxJetnW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9F23BD05
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390669; cv=none; b=k/I6L2zQnPxCMLAtwc/d9GJVpsB2QIJGMXiMO6d3Ue3WTGSf7kUxYQD7gCqFfYRsOBbVzKkqzACV9zSleJuNUPR8SzoiG1JJLd4auFGZMh/QyCbo95EKVyYvdqcQUSdvZQda53zIvhUb8/A/WCnTL3UWX+haLpclrbx2PSFtKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390669; c=relaxed/simple;
	bh=xMNNkjuSH+3HYtbiIl/ollmFmRenFvaiHSjwqXnvo7k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AURw7P7tojpfI5DUK5cdERxKzHTDc+yRKeBagujfbfRmMmvM1lWl+y7biCH92kHjvECcXo95QYuO8VdmrLEWqauNV0QHydfFUoAej+2VpApI2jIbP+/eZVpU4f0zjj822xCw3DqjFVEAPWFuxvITG2f/HyBGbyUg4JLMHFIssNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZxJetnW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756ZX5Q016348
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rxC9YEhF7HAygPUX1sY/MO8v
	Fp8TOmYu1uxrDnl8C1s=; b=TZxJetnW9Ot2Rc8/0i+mRkOdGAqLaeIOByVf09NP
	Xg0QjaSfXfPnI/SHy2TUb3bjnW+G9TGKzi7vSxIbpLM7sNFjHGhLwWGXBmV8MnWU
	VlrHfXLaU0wFsSu+nRbx0f3yxHpYvNlb9ycMKGcVoV4NTkvyOKD7eu4/0NnvNF2g
	lxOml6dn/SWpRVxG5c1lhyyByHlsKtIHSVA0vmTMVSNTUsAMqZcAOgx/KzFag8BN
	jlUeP6wk6zLu/pCB5r+yBcu4MRWEz6UGMJ9B80HPt7p9VT0G+CLjPIb7D3HlsyTv
	fmMr8DXKwnBJ4yBngQhZk7dYD/YimVORxcII3Xtr0D5UNA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjrex0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:44:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0791a8e8dso38087891cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390666; x=1754995466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxC9YEhF7HAygPUX1sY/MO8vFp8TOmYu1uxrDnl8C1s=;
        b=lMVWUfc78rNKa6DYoPWCQzQhexndfF4LBCSAJfZ+xjOepedVm/BgQ0jCyks3KbDMY2
         U/KrzQc3/8ca4uE9Gftmp8AeU+DkGS3WZgHBZd8X8ZpREQFhNKfNo7G6f51nhEGEKBuX
         AbD6xKk7iEX53G7Atdme4yr4fO4CaEerPcu7GnHreW5MJwiZNWXbROMNMXqJ6oY1o0AE
         UBIsu1qlIOSeitZNP5IlVW1RzaEV5WBXbajXTIk4b6TMiU/0L8NW2bojkkktESFzJS6D
         V0RWIgO0VrLgweIyhK8jHv7WoApZvmX6spC21h/4xugw9b66ACiFk+MyTuyT+A3KUtg4
         qCfA==
X-Forwarded-Encrypted: i=1; AJvYcCVDlQCyNJ37pzmANJ/ZaGgw9G0jlAUVghs8WjpboVAuS6gKqOgLPBasPSyZTp0JT6LufLxu2KtWrlQNFDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hTXQhdLi4Op20cYYXcnUPL60joMckgr+kX5dWCIESj6JdWjS
	afJd1d/HSrm4Clv1WrOmzxMywIT8Cn17UgctQ7MS5GiWUOUai+XxWzcK8dEQLl5UJV54GzsSmKG
	IjbqtGzEbMXayB+AP2+eUOGa8qjZdqHYO0oGjQTxZkXeIpm+QLa9lDAE0L8tR36AhCTI=
X-Gm-Gg: ASbGncs0DkiCSTX4NWZeI7PZih2+c0yDFDWAdxWLQ9JcX8lB3CEcq9bGb6MOcn4ji2H
	JS2Wyf1xpCrxofttjzxeB9EA/ig57nt9dSA1ZGHJWCkY/Dy6qi28Halp0vLMPSnr6tGP14UFkDf
	jOzym80o2vWE9M68r84iwoorvquhP+VcT90DxkGzNw49/rOrGq761XQL3gxUKAjrQQbpXg6+f6p
	SVhQJE6Jg8YqWm8/Ef4vz0s9YLv0W4T4h4E3Ty5hBkt5UQ/fC/bvn201kh2JmrCji26pHwNGpiZ
	58Bbuh6+Z2BuHHdZlj1zUpDvO5rF9xvpAJBoN81FzatRCd9/AjN8rMBTiqmLslJrvYaG7Q==
X-Received: by 2002:a05:6214:dab:b0:705:816:6179 with SMTP id 6a1803df08f44-709362d810cmr182505056d6.38.1754390666037;
        Tue, 05 Aug 2025 03:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP9CTM5JXUtM9Z6l08Gil36MWqvJFmbSlsYeDtXThdsrHNGHHg9GP8BD/fDSOt/tjYpA41+w==
X-Received: by 2002:a05:6214:dab:b0:705:816:6179 with SMTP id 6a1803df08f44-709362d810cmr182504726d6.38.1754390665534;
        Tue, 05 Aug 2025 03:44:25 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459d7d722dcsm83892505e9.24.2025.08.05.03.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:44:25 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 5 Aug 2025 12:44:23 +0200
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJHgh8mon9auOHzi@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6891e08b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=KpVMlk9tmVbli1cETwMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WGE6-RH0b0cGxLHTQLI89TCOcZEiGmf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3NiBTYWx0ZWRfX92E/rXV68VBB
 izUPpfv/RIVdzD12u0BMsHJVufrPPSniXejjR/9GHCRGDQMY11+R7WFS0QaL5xlIIf35b+1m3DT
 ns6id8CQcwrkUT7ce3mB9Dtx811en6kpc5XO2NkjiKWyhMljn6o8c0yPgAUS028k7rBQmEI2WsF
 XRS9ES3R8+FnY4mgNLD66ACWoa7c+H04Kd9UYkbx9N/R5NdrvuRhSdWbE2oM/keJUm2RNjmMJD+
 U1mhjfb21mAQSRMiFuwLYf4sjU560EPMRpGiEi3jzpKaEA78HzOuRT5oO2+Tu/uBTfZ2BZpKRP8
 oJ2XQmNBZSsg6L0SvvzoKQgiQpz1LRRPBLCQeHyMawVvhKBos3ibQ8J1gS1P8bkILiqh5T+xdAp
 WdFrQ9o13lIBHNj6G33oFpJLGqD1ft9TVclv8zxaaAs44zSLGPr17GJke39tlRO37nS5hUaW
X-Proofpoint-GUID: WGE6-RH0b0cGxLHTQLI89TCOcZEiGmf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050076

On 05/08/25 13:04:50, Dmitry Baryshkov wrote:
> On Tue, Aug 05, 2025 at 08:44:28AM +0200, Jorge Ramirez-Ortiz wrote:
> > Add a qcm2290 compatible binding to the Cenus core.
> > 
> > The maximum concurrency is video decode at 1920x1080 (FullHD) with video
> > encode at 1280x720 (HD).
> > 
> > The driver is not available to firmware versions below 6.0.55 due to an
> > internal requirement for secure buffers.
> > 
> > The bandwidth tables incorporate a conservative safety margin to ensure
> > stability under peak DDR and interconnect load conditions.
> > 
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > ---
> >  drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> > index adc38fbc9d79..753a16f53622 100644
> > --- a/drivers/media/platform/qcom/venus/core.c
> > +++ b/drivers/media/platform/qcom/venus/core.c
> > @@ -1070,6 +1070,55 @@ static const struct venus_resources sc7280_res = {
> >  	.enc_nodename = "video-encoder",
> >  };
> >  
> > +static const struct bw_tbl qcm2290_bw_table_dec[] = {
> > +	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
> > +	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
> > +	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
> > +	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
> > +};
> > +
> > +static const struct bw_tbl qcm2290_bw_table_enc[] = {
> > +	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
> > +	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
> > +	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
> > +	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
> > +};
> > +
> > +static const struct firmware_version min_fw = {
> > +	.major = 6, .minor = 0, .rev = 55,
> > +};
> 
> This will make venus driver error out with the firmware which is
> available in Debian trixie (and possibly other distributions). If I
> remember correctly, the driver can work with that firmware with the
> limited functionality. Can we please support that instead of erroring
> out completely?

yes, in V7 I did implement this functionality plus a fix for EOS
handling (broken in pre 6.0.55 firmwares).

This added some complexity to the driver. And so in internal discussions
it was agreed that it was not worth to carry it and that it should be dropped.

I'll let Vikash and Bryan comment on the decision.

> 
> > @@ -1080,6 +1129,7 @@ static const struct of_device_id venus_dt_match[] = {
> >  	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
> >  	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
> >  	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
> > +	{ .compatible = "qcom,qcm2290-venus", .data = &qcm2290_res, },
>
> Please keep the table sorted.

argh...sure

> 
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, venus_dt_match);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

