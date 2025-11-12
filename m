Return-Path: <linux-kernel+bounces-896576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0CC50B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B22BF34BC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00992DCC03;
	Wed, 12 Nov 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgKdOT9b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RiFQUaXT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E20FAAB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928945; cv=none; b=Iq+XTX4mjydrddOqq2/33mi/fepMvzWYrllT/1OI6/Bob0YM1Y6myWd7YW3F3mjToEE/2dmoudO90zqWwbYOWeO4NdXCsclVXx/R+1XNa3o/GyBKv0FujT//ly6a/uUHD78rpolfFkI8zx2nkiqtOREduFo+/YyrW5CH6Abp9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928945; c=relaxed/simple;
	bh=A7CUWqMjauXHT6hHhvu+ZIxufMH4sPH9yuX5FupcZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwQZsaGhN8SY8Mp9QBJ1o4sOHTo+zTEI6EPJaBAjFtIryWEt/cKTmLccPqmQx9mDia8lynw0mY5cG9bzG+sRJUzB1zYxRYHSD6OahYeIfqGgNluSoAmPSRHmkbdw3AxW62zyvyL5GqkSAfoNE5FAufuTyS2840RBNOFS7mEz9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgKdOT9b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RiFQUaXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC2MCnN2812312
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzAUhRKeGOhDrL0SVzP88ptswnErMqcNrlcNyCzXAfU=; b=SgKdOT9bNkdk2FG2
	oLkEW/LEAQK9mTDR635/9241IOdAebnYCzzVOk9KKYiwBfkKVuR0GAp9+SRb96xj
	ivb/+UVJLrKHI7Z5UjWDLuf1jQ8d3vujsNScV1TrCb2xN4hEympNeuwJvI6nTkvf
	HCAqcJ5776+1wLfT9fXDD84FLtLrAyO2+flNveFjL4Yt/+Aq7wA53qdiEolDPv+y
	syRoIwia6rb0pKPQP8tJayNCxAnAiZgDsptmyLYLcCq1cqKZun+AtpPFUnqhkvmh
	Lqsh7Rcp8/yPvsy7Pif/AQuBD7Xcodu5CfsUbOK+1ymtyMt6IgB15lvjNDfV4IaQ
	eizd2w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac855j4fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:29:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso1441404a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762928942; x=1763533742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzAUhRKeGOhDrL0SVzP88ptswnErMqcNrlcNyCzXAfU=;
        b=RiFQUaXTtg8GPTSaOLHIlhG8QbrFZjkJ7+zXhzD6cNzFRETilMSnHZFQOyrUhF5W4j
         CThLa2tau33YXv0u6q9ip6aXkjH3QJesAEEgtVGiT1m/dfi9SugEq2kQdCs1eOUh4CGR
         B9hmMqQqTiqVPkclKbGDdNAmcfPD2z1h0J1JLYtU+GVxl8vRrC2PmwYSMMVJvY2gXWHY
         2SspnZnQ3dXTASO6K0Ys/RVp528b2FGGP2YBpV694XiMj5Ef+M2oZd7vSdPJRpIiejny
         WCUaIbnM7B2/VdpViSZCc8CiBCKWT5KOLkZj+p5CXwU6bOdVInkY5dxmYn47QNnovICJ
         tlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762928942; x=1763533742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzAUhRKeGOhDrL0SVzP88ptswnErMqcNrlcNyCzXAfU=;
        b=nXWw1o8SFmhnedPNfbcGrkJCBpIaDNs0PnYAFv9JZPFzjOXpnGykNPLPwIc4gpu6gZ
         c76ITIgB7UtMofFWYuH5u4kpWCb01HOFdBcYoleYLuxA67j0Tpbv1BiiO7wvmquaRXwH
         DejtCB/H0xoZbB9P4/VI1/dM8BG/WiZIEpabAKePHE1yp4nr26mNjT146rBYL+W4ufaK
         RnXplemt3mlk7EF5MzLlJuuLDIHpda+qP704bDV3b38so2JGkSv+v5ro8Y/t5JeIZLfu
         m6ZDeIOkHT802Lz6gZDh7N9+8w6B9uSEJmfH1ORpVHkrU+/N0LzK5uZQnQJoTauPKyoC
         pbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUQxiaHp3qpPL5neZ2JoN3iAOd4pxPRJetCYyBtrjC7QhEv/qxF2QDc2xkr/bbu9GynxpGD/4YezaqjMak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBI7e31Od+uZx67AEjbcMLHlLlUmzjSFkxKixXZ6lYk+0nvOR
	JCe7GmbUjMNgjIUhGAyOXwhHHbfFr+j9PRAPskXyVJavpyVVoaE2TfJVfDc1bEMuvD6ATSpkbNj
	skr7cDZJD31VR6Rz3VJVNOf0oEnRIjuSPoj40w2iqJxdiRK1l3SVCB+GkHmFqIgCsw6w=
X-Gm-Gg: ASbGncvZlf1LtQ7yEOO1wNPo/5puIiL2N1ak3HVg1FDj0afp3sxDMi5Fq+COoNBM8JF
	WUHyHADchqDT9Pp1jm/+/b48C9V2ZHB4Ggeblhwd/xh5nTu+bNNZnRkAWXVmvXzhuBC2NPuRciG
	TUJ7bp4vzwu3aBhwcvfr0n2OJRZAw5YQ2at71HvKSMEEUDFDM9DISE8PiTu74mVPxaF/kk9J+tX
	+ltr2fvfXDSjJS6XyMgHGdteY71iaz3l2dz+b43nAK93uVm3/3sr5lXaodOTFByt8B72lY9esNv
	Ngp8HKmZk64aZiJ5h3WieKKIjt1TlLI+8XVpvpGmt33jwpduq/zAZn/3ndl+AIpOFU+6+heowjd
	yi5NZZFnQDBUSFL+le+AGNi/TxyZga/ztbW0P
X-Received: by 2002:a17:90b:3dd0:b0:341:8adc:76d2 with SMTP id 98e67ed59e1d1-343dddeef9emr3091934a91.16.1762928942283;
        Tue, 11 Nov 2025 22:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoBsSl4PPVzSUNTAvxsQL7O5rfO/S9VTHWSRRJfl3UQVRGtUcOGu7eHItKP8uuHcfci1PbXg==
X-Received: by 2002:a17:90b:3dd0:b0:341:8adc:76d2 with SMTP id 98e67ed59e1d1-343dddeef9emr3091904a91.16.1762928941763;
        Tue, 11 Nov 2025 22:29:01 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f14sm17849673b3a.45.2025.11.11.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:29:01 -0800 (PST)
Date: Wed, 12 Nov 2025 11:58:57 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: host: scale ICE clock
Message-ID: <aRQpKdRkadwN2WaA@hu-arakshit-hyd.qualcomm.com>
References: <20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com>
 <20251001-enable-ufs-ice-clock-scaling-v1-2-ec956160b696@oss.qualcomm.com>
 <rge3ozfojjpurnxi5otwuobzcw5v6fstlvpodw4icmhimauckx@wpdb4orkjd5t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rge3ozfojjpurnxi5otwuobzcw5v6fstlvpodw4icmhimauckx@wpdb4orkjd5t>
X-Proofpoint-GUID: 28UXpxWfoCbzOOY0v4O4m2hxXim0FIeP
X-Authority-Analysis: v=2.4 cv=DYwaa/tW c=1 sm=1 tr=0 ts=6914292f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OMFupFYHVdvZUXidDu4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 28UXpxWfoCbzOOY0v4O4m2hxXim0FIeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0OSBTYWx0ZWRfX6H4Bwdtmjpet
 a3dfdF8RGHg3zg9K4MzMC6cxQIF8zMQEnza67W7jU5U7TkYziYzxKdxMd5u/csarO+MVeW0zV3q
 /eRTcbK016Ps+XLgOymIH+aHdM9RRkRxChXXYKSlui1AiDwTAaCpDv3gkiFhzNSHPhRqdVbxFah
 8OvBKKbYA3jhLSj6UAiteD6ykqJiNwrBzhfVpKFVGF4owinBrjoz99mTAtGKtx9EPw/AfVYHm14
 Zcg5MphyJJCyBusMjR96/OjYM1gWUEKim7YA/3094yIZns+DOV9hX7Qyx4ief+kamedoy6U69ea
 AIGQHs5qXmiPcfKANNMlf0nLYYwKi1i9MDhEsbp047GzeIWNJDwpcMnwummrdkxEbbu07B7OpMK
 ddJTVbYwL1gkHLYsB2u+IgzbkR+TdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120049

On Fri, Oct 03, 2025 at 10:14:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 01, 2025 at 05:08:20PM +0530, Abhinaba Rakshit wrote:
> > Scale ICE clock from ufs controller.
> > 
> 
> Explain the purpose.

Sure, will add more details in patchset v2.

> 
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 3e83dc51d53857d5a855df4e4dfa837747559dad..2964b95a4423e887c0414ed9399cc02d37b5229a 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -305,6 +305,13 @@ static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
> >  	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
> >  }
> >  
> > +static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
> > +{
> > +	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
> > +		return qcom_ice_scale_clk(host->ice, scale_up);
> 
> newline
> 
> > +	return 0;
> > +}
> > +
> >  static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
> >  	.keyslot_program	= ufs_qcom_ice_keyslot_program,
> >  	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
> > @@ -339,6 +346,11 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
> >  {
> 
> > +static inline int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
> 
> Drop the 'inline' keyword.

Will update this in patchset v2.

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

