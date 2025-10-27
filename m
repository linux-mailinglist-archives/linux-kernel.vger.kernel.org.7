Return-Path: <linux-kernel+bounces-871510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA11C0D7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 852F84F0969
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB42FD7DD;
	Mon, 27 Oct 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBs6Fgk9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439E2F12DE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567735; cv=none; b=EjfXsB/J/2DBlt7OpRjsT3bRwFEho6g84KDzdfYolJxR1BiUOHkLDvbEH+smlayd08nGcbYAvUvp6HKtgzmVDgXHrk1ueMKa/oaMBYKLu3bPXneda5HmhVWgY1+n0OtcjHcJoOs/v/LibXuul3f6Gpngqth7MJlIbXWNnWYpUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567735; c=relaxed/simple;
	bh=5HTqrOYqCuummTRQY5R3kBtRSlzJ1dTedKBPppB19TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwSYvRyZzmIiRvpLYXwmXtdUbepgiq+msOOm39t2JuyqH7v3qpEBxg9bKs5vP9spWbld7a5KpEtOzyy/AUldFOBQRyOS2k+iFX2/9gbTBB1AakC/NU/t0/04SARFiSc/6iETiwQk1hxao4a4twIeJv/9rNG5waqeJjd7hvlkklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBs6Fgk9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R9FXER1294976
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Psg+67BfDLKR1waGwn5a3FoQ
	zpaxCzLH0+T9U8DBvbg=; b=mBs6Fgk95ffbn4ieruXYrS9Ov7pW4DuApfupuktD
	bX+M9/sG7KIZXUhn+qqhj100+ee+Iv5KD2GbjThnS4Yhp53XXfxDuex4rPALtaIj
	Fcpz1NKhX3QA1O75SAhUAC1YG399L0jTTLEXYrBLQ4XQGFwktwrkPkKVQrsF6vkA
	gzXRTmfqrUQvFbCLXpbqm5K//BKz0vLluu/2Srtx/T1Bin3VOpkZGJRg+5u1Mgv2
	hXcpprUqVZT4lrMiXbNwjpCWqxOHJwO6pS5wDPUIYgF7a2A/lQq/U4jFsGqEUitM
	oAte68UO9chMnRCUZy5W/CTreeeuHk3HxAiuT5CutnrrGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnb4k8k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:22:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eba247f3efso53611911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567732; x=1762172532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psg+67BfDLKR1waGwn5a3FoQzpaxCzLH0+T9U8DBvbg=;
        b=A1vP4bk/SJSBHjHGCfPeFzSr+EWan3YgnCYQxzKXK66DsV59wiRJ7S/cQ3h4RfONe7
         R4WUGppbd+xRhBIk/gB/J7SmUAhoQHE7/ZSWoQiFc71n3ibX+btC3drQp0SZKG5tVhXZ
         okNd8M2T1yerZKt3jubD1IFkl+2ZThG4TwURTj4AOzDQ04P9Yt5FS2AErKMR/yA3tsd7
         6Kt5T0Fn+0sFeDTufDyzKZjMHUG7P76f4v6Zi44H+CmUJMcS57Z33hceKvX17bf+xf6V
         DdkpZUaqSsjkYeiXYmGxHPcEprUkUUNEIBrsl50EifAv0P4XymSdKs0V+9sqwLdxl6W0
         eyTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmFl7Gw15nVkpl0MPuk4drtakBfLNuWfZzbZ08dN8qdN4fD0mVGA1RFPdzI05cWHFCYWSX8s/pER7Bsnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJi7FYJeLpDX3xIi7RNdq2rwLJSE7jLSEHVo+set9oJ6iwkoKm
	xvYqONFK8mjgRVKKtmm+P8D47rDsWCwgks8R1toZq3bSnbTnKEuerEB3nP1Uzs42Yo/SdzZIf4t
	wPGZiotTp+PJ9SnEqdcptVJbB+lFgUyXbRTRkUXGUxlC+kbvW03AsCVDf3ZYqv8trdIs=
X-Gm-Gg: ASbGncvB1nX9a+3tct808ePJq/hQkNTDJq1jrqWCvvvgi7FfEiuQj+mk5K6CzmAdQzL
	N46wKVUmFZMsv/VuERwzxR1/ptD3EEuuWTJUf51/yUEbG/Nr3+UlltO02nLQyP2MNepGm7x/SXs
	nA9VASKYmsSbE0foFUhy3L/q+z+IgYGnLxm/45nr1Bc6GC1e5+frQAhkzwHq/Z8TaOecQVwEIXC
	RylVzlaTekw4e317NtAm565/uVzIsVTtoTpBBvRi51R+i7hbgPqri1DVOmeXBzESTWnbWkjE7B+
	V8eRVA0CFNjKjlwF4LtNST6LoZ3VPa5WJ08HFCS1FVClIwQJduJUnHLSilm9aFavOXxlnHq9nIu
	67KNYzOo8QjAMDa3a16NjIVZF2VtEEo0JdFtQDgpinQWfnNE3F30FaJ/S/c5df4LILZhwj1Cv9T
	uqqC9dg5C1QMvj
X-Received: by 2002:a05:622a:2291:b0:4ec:f017:9e2c with SMTP id d75a77b69052e-4ecf017a075mr61636221cf.35.1761567728681;
        Mon, 27 Oct 2025 05:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGYgD/La2Tib5FQl2fihboVZ7Zt1I5VSs9oXv2jbhiaDS8YaEpcF2SppZieSQXcjQmVktSMA==
X-Received: by 2002:a05:622a:2291:b0:4ec:f017:9e2c with SMTP id d75a77b69052e-4ecf017a075mr61634961cf.35.1761567727214;
        Mon, 27 Oct 2025 05:22:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0c342csm19672521fa.26.2025.10.27.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:22:06 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:22:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <4bnvh2ydtrmejknzpsxoalxoyjpq5g5cjbrico5ezbek24r52s@u5zy6ekh6lps>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
 <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
X-Proofpoint-GUID: rDeF8vEcvzCTQ-wmRf4n0wy4vZBMFk85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNSBTYWx0ZWRfX/68ZQHP3nIxm
 D0FmoAtp5UNVzM6RXzZWcd+FtLl1W/Lq8XjcKt6geiG0zgFNgINxvO8GeoTqUL/816wJCzZCSIo
 qd+XcWnZ8JeW3FDsWEkxKJsQn1LYPImV7e/p41d8f/lV5PT6ZuPMt1kz0EXJpD4YILqwVGsTbCw
 8q7/dAqU7ZoJ/LqpqoeD/QCf3Y3H9npgphSsBnoPZrmDPc5pKyXLH3FOgGasuSwFgAk01EVm0op
 LnXJEC0DzsPNbO6lelo/TEKbIpEqqZhVgfOO0MuaTrDb7pJStdcgSFulBvfTyAwZvMUvbXrw7Zz
 7E91hx4ZAhQuOnowHa2xsLyAd/L8wufh1OKgie7HGEUqmxZG6IlgR/hCFlL7lBmYjfQ1dVDBQKj
 Y1MU9796clfWOd8R/fc9DtIWkuKGAQ==
X-Authority-Analysis: v=2.4 cv=AJoZt3K7 c=1 sm=1 tr=0 ts=68ff63f4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=UzKOEE2XrYQWi1Oh8k0A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: rDeF8vEcvzCTQ-wmRf4n0wy4vZBMFk85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270115

On Fri, Oct 24, 2025 at 02:00:50PM +0800, yuanjiey wrote:
> On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > 
> > > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > index d6a37d7e0cc6..7eda16e0c1f9 100644
> > > --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> > > +				    1650000, 1950000);
> > 
> > This should be done in the DT. Limit the voltage per the user.
> Two reason:
> 1.
> I see https://patchwork.freedesktop.org/patch/354612/
> 
> panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
> so I do the same work.

Please look for the majority rather than the exceptions. Out of all
panel drivers only two set the voltage directly.

> 
> 2.     Kaanapali vddio regulator:
> 
> 		vreg_l12b_1p8: ldo12 {
> 			regulator-name = "vreg_l12b_1p8";
> 			regulator-min-microvolt = <1200000>;
> 			regulator-max-microvolt = <1800000>;
> 
> 	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
> 	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.

DT has to list the voltage values that work for the devices on that
particular platform. So, ldo12 should be listing 1.64 - 1.8 V.

> 
> 
> Thanks,
> Yuanjie
> 
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > >  	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > >  	if (IS_ERR(ctx->reset_gpio))
> > >  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

