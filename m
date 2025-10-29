Return-Path: <linux-kernel+bounces-875933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CFC1A2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5AC44E5DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B3E33B971;
	Wed, 29 Oct 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcrqAkz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QvYeMVF3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0A2E6CDA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740421; cv=none; b=oE+9bROf2e4whPQ9xjROYyCepr/p4XfjcUPIHg/16hNqkDBUKJGiNMRr+okw+Ethsghdyf95OFtCATARLgyBVyan30ptZOEWzFehLeX1PwuLQd1tyjMp+Ynzmhru3PgD2BWxmUO/qdF9ThluAxsVK6DkVQFhvSVdozmRIfw0izY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740421; c=relaxed/simple;
	bh=XyQkEd+y0CYJ9pfm1zE2yw6oEotr8KWYSmuNSIz3J7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frHtDUXMQ0RxlxPXwIpjo/fBKIZ1bCcMpcalZ81VcThC5ChSEyDDoy3uo8rTNpJd3GZgJkZ5R+nRi7N1gzILayZIo1N110EDXyfCG7PRpxvK3jA9p/PStHEC6kBNNxEAuYVQF90qNxa8GHERKsZdwvk5fGqbyW94iubp2GqUPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcrqAkz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QvYeMVF3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4vCK13664310
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LH8DR8//cQR8KFgIwkrvcAIa
	YSLF/qbFcu8GX5YeQb0=; b=WcrqAkz4m03q0+tavsbkKVCsMXWn/NxbzL84+XjN
	2XpR7kpBxA3vZ8JNgpfltVWDovqTqkatzpEr2K/gRtPFTko1y70bqf1c+3tYkdkz
	rugMf7EfqXu8HLphzW5uszJlHyrKH8nAxerW6MuX14+ykXqE4Fs/NZLSpPrbsFmj
	qITCnstZvNukN7Luyojrnxm9oaSgLDldM74YvVWjoJcIdV4p73J7WRpYIzdarl9v
	LpC3Rus4umf7S8aJ4GFNt794vtn+1Qx1Txdsca62XoULLEoqZLMHRl765OY5n+ba
	ZZU5o+E4gtnyZHCJ8aDVrYOTeqb16ZgcauouUgO1rMO2TQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1te61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:20:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf77618a5so106082131cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761740418; x=1762345218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LH8DR8//cQR8KFgIwkrvcAIaYSLF/qbFcu8GX5YeQb0=;
        b=QvYeMVF3xv9LQy2UVtZNH8Hy9UWUtUp7ucq9Fi3/ojq1oA+CiFGQ0vtQppoJt+qiJp
         0QqtABoJ1eVW4FSRFIVr/LSJidcxE1twsu7XI+FQpoNdFqbRW53IX6e8KQv5Ni8q8OXs
         9glZYIDCmjujJAAV7X4HtL8fI1O/8bWaDpAVpXkavQRhMpTKCkXLK9zeIgwZmE25GR0D
         O16AMv78eGZ/qsrwXJHbtV54G6eFbnQzGCDETp49wqR6gLzsBTJhOUHOPdbP9M90edx/
         wPHDWuaEvwf/Hm4+tf/wFDt1NBhzZomsbcnAcgk8Jhu5oRg2Z+/jyRJ7Mb3xm6Wv7v/t
         rCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740418; x=1762345218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH8DR8//cQR8KFgIwkrvcAIaYSLF/qbFcu8GX5YeQb0=;
        b=LNePnEK4QjaGRw2lHMtEADqyeMSlMLTRp5gTTRZkm0ngtwCmOBbNDfGBhokZignak5
         BOoDcpq3b9qz2S2+Vo559gnvw9FvFraEHR8gFw4cOGeeDYgDwQyoFOpbONIkfYesiXPC
         j59AKy5YSrPGACRYFaoQNrhzteO0RXClyxD9IFQ8m4BCjaj4Hd7VUhinV8d7+al3RSZw
         tDFBaGz4hZBoBoGXLRvkU0os0n0bhfh7XPOCQjJQ84rECG5tOA8CHBctxEMXLUsQHDdV
         hsQNYoJW2OUhXYHfZNE6n9l+VLw4WEa3KTzbEOluSSLcnbLke7DI2YT6K/MOmt8BQgdt
         gvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXGn9lwmy7s3r8QicgLlFsToiRnxtDRnGEsixgLppuviydd/4YeOD3wQA+qoDUzkkyj4EglEaFtSJKdwio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMvU3xRJwyMC8kLZAYvGYRLpiw8q9ZRRdmjqUK8rVJBIufJQj
	aXEv6AlkiS9uOWoyCB3NTKjWezFL19i/ej3s7WvT8LjNPzHOdjCrLWnkQZCUylgyAa4LpRglRK/
	eclJNfhdNW7w+fai6hkfeTZVgkHyh6+cs2QxgsdzRhjFQR/rxcBn3T8dWR+zzv2WujVU=
X-Gm-Gg: ASbGncvBEHkYOWwEAD9VnSh8dwbDRQ0P4LgaDyncDIF4hmOoareO64DLa177Vuoiq0u
	f+lOJ2Cj13/nO2cXWuQ5rvqgRTDjRA62Kx/wihG0IRUbHijjNc/d21+fJR+IXBM5MnIk3S5dM1s
	VBW+/EUjZxSQq5NUxaM6awIWNPitlIsWmQSDHadDdOZl07GVO4mEOCzt/gqhN7ieQNdAEK143O6
	FcuSGb/qpLz/MiJcY3vBeCeOO5qURHgk0fPzm+37cDKXv4UHOijBzWAvlqmcm9/HJ2yW0lpVFDH
	Lmh96zkjo6EPrFvE8nwKcuFMfefIMIs7yGfgGSXA1QFvs+P0feXEi5vmRtrqAppUqwOgDALTfLa
	PVANsDHfqByvZsVlUFX6KmS+EuoIl7raSuHa32QlkdINQtv8Q+Jb0BqkT5sdROOz9yvwgFYlAW1
	FODD9uOrETquSb
X-Received: by 2002:ac8:7e93:0:b0:4b6:24ba:dc6a with SMTP id d75a77b69052e-4ed15bcc6ebmr35801751cf.38.1761740417940;
        Wed, 29 Oct 2025 05:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMT4/swPPupz/E/qfuue3HwlcRqEuyeBtC/5cT+r75s92xpn7+XVN3dqNaiqtM4Q56IC82HA==
X-Received: by 2002:ac8:7e93:0:b0:4b6:24ba:dc6a with SMTP id d75a77b69052e-4ed15bcc6ebmr35800721cf.38.1761740417042;
        Wed, 29 Oct 2025 05:20:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41cfesm3845182e87.11.2025.10.29.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:20:15 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:20:13 +0200
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
Message-ID: <5hftxsuqz745mxxk2hjpwfxwrm73p2l3dxn2mb2uqb2c44fd2w@l5xvadj7gvvg>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
 <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
 <4bnvh2ydtrmejknzpsxoalxoyjpq5g5cjbrico5ezbek24r52s@u5zy6ekh6lps>
 <aQF0zzUpLeUu4lrC@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQF0zzUpLeUu4lrC@yuanjiey.ap.qualcomm.com>
X-Proofpoint-GUID: 5lCpfkQL1IgoVIEBvfug2rwutvOH6aPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5MyBTYWx0ZWRfX7WkwCluMOtef
 Xwm/n0nDipg6ypkb5GSMhONPzqh2H5v4bcKHv/zy749lARPxlBUtGh7ezpjBg2T1nmR56ukQuSH
 70owemlvxTfN7NUKNu49qFXXMbEndca6uYOTjU1H5mSVh8XiS3i1VXK9idbGIpOo6eQGW1/6rue
 c1Volr+qzwz1lF1GrRcUm0FVvaPHqHNiO0gk6PNZy7hHPfDQOD6Z0MX1ATc41ip3/ah6hhmDZZX
 BRLA7hdQHMJ953aH69nMuaJ6BxP87erQ7/IP8Md8c5g7Yu4NRPxaS4EWXg6QkFzBrbdrexd7TZS
 m81KRuziX4pPot6tSSioEF0GUppXbhGemwNxaWgi05Yv/2hMaFcxLbwQRMF3LtxIUhLY4Rg5t5m
 iBl2KMyYb4i4KBX86VYpWqGBBVCIKg==
X-Proofpoint-ORIG-GUID: 5lCpfkQL1IgoVIEBvfug2rwutvOH6aPG
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=69020683 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=oqA_m_Aqcoo5Vt1K8d8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290093

On Wed, Oct 29, 2025 at 09:58:39AM +0800, yuanjiey wrote:
> On Mon, Oct 27, 2025 at 02:22:04PM +0200, Dmitry Baryshkov wrote:
> > On Fri, Oct 24, 2025 at 02:00:50PM +0800, yuanjiey wrote:
> > > On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > 
> > > > > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > > > > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > > > > 
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > index d6a37d7e0cc6..7eda16e0c1f9 100644
> > > > > --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > >  
> > > > > +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> > > > > +				    1650000, 1950000);
> > > > 
> > > > This should be done in the DT. Limit the voltage per the user.
> > > Two reason:
> > > 1.
> > > I see https://patchwork.freedesktop.org/patch/354612/
> > > 
> > > panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
> > > so I do the same work.
> > 
> > Please look for the majority rather than the exceptions. Out of all
> > panel drivers only two set the voltage directly.
> > 
> > > 
> > > 2.     Kaanapali vddio regulator:
> > > 
> > > 		vreg_l12b_1p8: ldo12 {
> > > 			regulator-name = "vreg_l12b_1p8";
> > > 			regulator-min-microvolt = <1200000>;
> > > 			regulator-max-microvolt = <1800000>;
> > > 
> > > 	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
> > > 	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.
> > 
> > DT has to list the voltage values that work for the devices on that
> > particular platform. So, ldo12 should be listing 1.64 - 1.8 V.
> get it. I check downstream DT,
>   dosnstream DT:
>    regulator-min-microvolt = <1800000>;
>    regulator-max-microvolt = <1800000>;
> 
>   I test 1.8V works, So I will add 1.8V in next patch, do you think it is ok?

What does panel's datasheet say?

-- 
With best wishes
Dmitry

