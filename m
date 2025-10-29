Return-Path: <linux-kernel+bounces-875075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B5BC1828F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A006F3B514D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A862ECEBC;
	Wed, 29 Oct 2025 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbjZI9NM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bC/VxZsU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4728466F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707992; cv=none; b=ZpzqkBw7flXNzVXNHAdCzxe2mN6K2wdLhumCb8IzDcORV7lNBqqED6D+Zd4LlXl9A4sHFIJKMDd5WgqeDa4QgsxBT2v+Stzft6ZA7TPcent4mGONQi1n2Hcb/2/9L9UzxSH8RtyYPjqMTN1gBfJtUtf0ZC/7Tqo8R52G9OxYdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707992; c=relaxed/simple;
	bh=TDBNjpHbqgscAOvy2+GugorvShf4pjjc9+ahVVZmdE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+AR+rnRXbgTkN38biTspLvvT/2QQW9/GQPPeWnp+Ol8t1BRxEvPixsMzbDFiw+41rKGsA+1rvtwqPmde8hAgqhTalHP70ucwlFb96MhS1bfDLfeNAZIWRnGTk+hR4QC55clsA1wOHVbA/4VA+WVWYtzpkAdhIg5pmuh1LKOlec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbjZI9NM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bC/VxZsU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlZaQ2575817
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tfuOdHYPuBbRAFi2S3af3q0y
	P5GTo3VvO9e3ehC0+QY=; b=XbjZI9NMTCuvP0ON7ljI95ue2bFZ+B/HKFusXoAu
	qEkt+u/kwHbY8Nxkjzf2PRQWD1DuCUHonMVw5yzIiNiZmhfXP4vdbOAhjk1YiMIG
	zNTDt2EbSh50D7j1fYqcSFrRq98ideoANTkSqSxFp/e3b7oLxSNmJRvJoybnpeP3
	pCviYwjRMLsogwg3RyK2Z76CnbIfWBKVjjMGrg65qXMQ3taif6HPBANHFNWHdaYR
	Lte9dBJUcmzMsOr4ZVRduSwJ5/qxgCc7ppEgZvLXcyOs/NvaPjSStmiVG+lSsaAH
	SaAVA+G4HDXUtIRRgn2eN0Uu81mc0iArsSZc3/5EEFP1oQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2117u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:19:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a0aa0df911so1135991085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761707989; x=1762312789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfuOdHYPuBbRAFi2S3af3q0yP5GTo3VvO9e3ehC0+QY=;
        b=bC/VxZsUz+d+GRYO7j1qiOT3HJ6mfuGS9bv2mtirPz68IuDjwNSO/lyyMi1QcZgQ8p
         EHvErgfmnsut0Hy7eLFDLoW7J3mV2k0e/g4rBR9IGxevs1kJC1Klh89+LANCb/DXb4zj
         HNLn/0oCu5NHg2kHRME3UrJgv0h4kKXBvA2fK25z0yJrXYHXZgFeDcUvo7NWXVe3i2dU
         XYRB4Ge/Y1nijjyTkrrLyn2GVRJEarXQeYEsY0BvHd94YyAmQbk8tThbgNFhZG4aY+hu
         OANVBpo8DI+CvuDiV4tc+lP0Op1uvhqdhHJYTz9ZDf5i1YgcMz1SxtMIDomcIRAQ1c+L
         tj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707989; x=1762312789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfuOdHYPuBbRAFi2S3af3q0yP5GTo3VvO9e3ehC0+QY=;
        b=X+P3QmvsSmKyieyJn7c13RdCVgRq2F82SF06lPH9nZnxhqzdNQ45a1FC1KYQqfjhLV
         /xHHxszZcXHjjfmPLf+8zE9tMW+/D4ZonGjss13GWo3AhmZzNHu50R1OnYau+z5dKg7K
         fozIot0QjBRHU72dAmPNXCXU6mi2EKXGQ0sIOpGCc07RGp6XSMx6nqxOkFfG3Pa62k2w
         zphb/tCRzHqKsfzMOExFmRxMZolVeOwYogf0viezoVxw0Kdu2TpoSWUbC48MCIuRVjUV
         2kykTlHa0YdJuO4q499qqtqFJUXL8yPU4AkiA5lWBu+KrYiexiMkFhzWRdrbMLx6NyUi
         veAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdcT8/LRaZlzkB4uzvhzro1I///U/NSoOS22kuNyfRYlxb70di7yG6DCS3KmOxCz0urfg1S1X/ZVrHaLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ns+V5bFlzrE23WMN1J43YOWXBfas/9mCfLfyMfcfCq0TYqim
	pl0E+zrltk507RXRIjBwcQ0Chv7XHi9jJZlNcOhSaijYUZNrzu4/m6mQSjoen2ZsP3uHYrxfjum
	ruEBenZiw7cLX4woDIcJvTiC+AHZUPefTYhnx1OulifExaiFv3/UZkprA32E8OhuY3Bs=
X-Gm-Gg: ASbGncvpdWs3QOpPU8nyez0w3032h8ByuqT4Yfyfbsr95vdbrLYxRJlrtboBiwQjmSy
	DXcrmvDMumtRecdd40XSMTIFsj6o09j5QQdVWI2vuFJ3YMuvBZEqS9RKqP7K3y3dLsbNiiOargy
	XZdY3ixV6Ze2xDGgtvjzZCQHCk2bAd4aV1ofB0ETeqfRf1cJUBUJhNrkT+vd9X36lxy3hkoVUZo
	y90ju5uT2o/PsNo5z0lubSyKYuAU0nMRshy+0QYW6GpySKq4YlhbkWUlugrj2x9Yu0G/W8Loz2I
	MUuYpNtGvbJlSzNaBZ+ht+LzMq8EKSazam2e3PuWAPzbUAyFCXMqj19DIk0uNyfNoZk5CyUX1Sv
	KTc0QOEPx80eCaVJ8skjMawSd4bFaazRT3whcu/47zeNUKpqXWmVVsw20eet8GUGY
X-Received: by 2002:a05:620a:c47:b0:8a6:999f:df02 with SMTP id af79cd13be357-8a8ea5951e0mr221841085a.0.1761707988866;
        Tue, 28 Oct 2025 20:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPR1bnU91lCiITa3K23J2bvukY1QCUyEKr+SagA9SP4DVjvaGRLpGPgwIenuTxiRjw0NjoWg==
X-Received: by 2002:a05:620a:c47:b0:8a6:999f:df02 with SMTP id af79cd13be357-8a8ea5951e0mr221839085a.0.1761707988386;
        Tue, 28 Oct 2025 20:19:48 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f243142b5sm979056185a.8.2025.10.28.20.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:19:47 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:19:36 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Message-ID: <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
 <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
 <0291d0f2-483f-48d8-8c75-f1bbcd1ab18f@oss.qualcomm.com>
 <ehgdx7av3jewowkvtsqrbnsphgxm5hryl6n5otnapi4xneldze@gcwvpssisv2x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ehgdx7av3jewowkvtsqrbnsphgxm5hryl6n5otnapi4xneldze@gcwvpssisv2x>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNCBTYWx0ZWRfXzY/PQ39e0w0F
 ELp/PgfWB3GH73wLqZ8zI7BzY9BjzMH0V6HcczaC3anCy3UH6Q0sG+WhhC9prRhZEoItZ1SXoll
 VoJaAAhSS8/OBJsnGFtqi1wVupLdLPqCh520NgcENzNHH2cX1QFMQiI4sZbvwPtwCQwslIHSxj0
 soRrVRudl/e8qoL5oUjdbIwXNr6fSyk8ObNA0IFCzaSWuLyObof/kZ3AqnrGMn1ArjL8SMCbQAX
 s1HzmaiuKps0/dyW41LrRzWV4hBtleLEpzCiivF1lr0yf/YDxLY9DegdtwsVpS8pVEQg+stQAzL
 H4y43wn43ck9atpLCb0QiGImfhKJofchl4x/8ptzY3NTvVwYeqmDlzBGdhRMWPM46BOPtOc8s8m
 81gjEtTXuGMoUi9y76qTMMhl8g5oEg==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=690187d5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dRtYTIcgi1dzbadgoRkA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: e8wgyxNbYqyBNNG7_IgwbKkfquk-1vNO
X-Proofpoint-ORIG-GUID: e8wgyxNbYqyBNNG7_IgwbKkfquk-1vNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290024

On Mon, Oct 27, 2025 at 03:29:40PM +0200, Dmitry Baryshkov wrote:
> On Mon, Oct 27, 2025 at 02:20:26PM +0100, Konrad Dybcio wrote:
> > On 10/27/25 2:14 PM, Dmitry Baryshkov wrote:
> > > On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
> > >> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
> > >>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> > >>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
> > >>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >>>>>
> > >>>>> Add DSI PHY support for the Kaanapali platform.
> > >>>>>
> > >>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > >>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >>>>> ---
> > >>>
> > >>> [...]
> > >>>
> > >>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
> > >>>>
> > >>>> These two addresses are very strange. Would you care to explain? Other
> > >>>> than that there is no difference from SM8750 entry.
> > >>>
> > >>> They're correct.
> > >>> Although they correspond to DSI_0 and DSI_2..
> > >>>
> > >>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
> > >>> new features. Please provide some more context and how that impacts
> > >>> the hw description.
> > >>
> > >> Thanks for your reminder.
> > >>
> > >> Correct here:
> > >> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
> > >>
> > >> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
> > >> just some register address change.
> > > 
> > > Addition of DSI2 is a meaningful change, which needs to be handled both
> > > in the core and in the DSI / DSI PHY drivers.
> > 
> > DSI2 was introduced in 8750 already, but it was done without any
> > fanfare..
> > 
> > I see a diagram that shows an XBAR with inputs from DSI0 and DSI2,
> > and an output to DSI0_PHY (same thing on kaanapali - meaning this
> > patch is potentially wrong and should ref DSI1_PHY instead?)
> 
Yes, I check ipcata Doc, I see DSI0\DSI0_PHY DSI1\DSI1_PHY DSI2\DSI2_PHY in Kaanapali, 
addition of DSI2\DSI2_PHY compared to SM8650.

look like I should add: config io_start = {DSI0_PHY, DSI1_PHY, DSI2_PHY},

Do you thinks this fix is OK?

Thanks,
Yuanjie

> Most likely.


> 
> -- 
> With best wishes
> Dmitry

