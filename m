Return-Path: <linux-kernel+bounces-759159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9AB1D95A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B173AE635
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3D25DD07;
	Thu,  7 Aug 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nvVRMBAr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD62561AA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574627; cv=none; b=jpgUKngsYoKBdjMe2qPZdMt+XtANQH6xtAa5AwV/lg5xU7HSuF9FLYCww8/ghBzsKx5rJWdZZQvIQYfqdkTr8+imlK8ibfpH73nYGpHmMyxfBSWsKfLnyZ6ZXUZdhOyh1OrWQVZH7o7KL6KJtMI53u36CbX4NfRAHgsEhVyfD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574627; c=relaxed/simple;
	bh=pVZc/u2JXcJZ/aRAfpTKab2xWf0eHpihlZOCZE1c4dc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln4nkHUS3QrYSLqTL//bM0JTWP0TpgeJFty+BGiM8YQC86k3Y5idt4Ziaa/X1LCEJR9Fj7P9xl9P0b1AGuYuaz0eQOgfsArVIK5PL3WDT+YVlYBrWGncTYhurZCoV16DQDdSQmZ1nUI88lj+/GbGtRabx+wFjfB0Nvi/oa6n1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nvVRMBAr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779D16E019133
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 13:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5OmLGnYd7WdAQT7cvTn0HfXjvy8zdD3OEZAP/wXH4gA=; b=nvVRMBArE+Uh4dD9
	D5hbo4mfYcGTwYgQ/dCvaplVYAexzlxNyPx2OejbF25SU+c5Ws6rn9/igO2FP60t
	PDT+kipj6iaAmYYzvSJVQ2hiu5KDCz77O2hS0ICMuG0HNZEoyUmjX++1I19DiANq
	zfZMG6C0zg3OGSMMSItBWKEdN0tktNIgScH/4+t1YpEGNT0hi8OXI70Vz30e/vwY
	xwQA7kN/zHS7LbMsBLnZK0kb1dEJFhW1Z0ZH0ydZigxNVd/GdB8Qk8ZUFr5VZWuV
	f0XrT6LrxR2gha7mNccKC48SPXrpbpzFwepjac3sADT8oRi0ps3eZux58iKk7jQt
	dDASig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8eehj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:50:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70771983a52so23785276d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574623; x=1755179423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OmLGnYd7WdAQT7cvTn0HfXjvy8zdD3OEZAP/wXH4gA=;
        b=tW9f5U9pi5uR263uBWSCSQIqRMklXoLM5+ahyTbiNtb8Ai/UxeMCdHubWKN6yW3JcX
         Vo3m0TgHZZrUXyMr8stREpy+MUasOH9Bp0bbiNWqzYarU8hLJiWeOzQ+aATQxIcxeRMd
         xk7jlacUgZnFmzifzlY8gAEGRAlNh6gDtrz2MwRPDQxb1ulCkXAJ0V/KkCdoENJwOMvs
         k+Nqm7qabhcmO595toalRSpayTBHT7ZSk7Zk8VSUAPUdcsInbC1K59jRXJbhCjcboWKA
         qixeHjGObYXRpe/3B6NT2Btlen/xMeYIB8qvA5fwspxuEId0+3D9F9aBypCvMe/XSYpD
         Q6pg==
X-Forwarded-Encrypted: i=1; AJvYcCWacGyN3AVU/rRs6jLFnNL8ml/Ts0GudAVnIFvJOM3F5CzwJZ2R5lM7WPYyEc8woZ+DxxW0xs/N6/CJtZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMTmKWC09+AEqu9XMlZU7jcr6cTGFiICjgp4gH9C0UqMk7w5B
	U4BaoRMJnd+UghkmalJ5bNRZTf6+kZ38E6BYLMzyG0J6eW7aso23haqIF6v4/T9obaRqQIxu//n
	Ia5xW7pDfaBGF9CDwFW3NJOOJeeX0Yr93+fL1JLGbyVSZbxHQPwOrCZGrjoBoBWrgyJM=
X-Gm-Gg: ASbGncstHyDSzJw68Csbk38+j3UIL1LeVc2ikwCnvaCsPV94f0zr75k+JsmeHdDJYZC
	moL4aB4rsU35gF2D4qWeYL7cYNKO0/bCIQd7Y2PzFGu9FKdug8ILqUbvOSOJfVTDZtwI4d8qEQU
	kBwyPC08gls3O32O6OrWN4LK2rx4ClVKh1TpqIMFK3nhEynvYSbLmMPVvsz6oOia932z+yGrjV1
	myE9DNQe++Yft+4DVURpaMydaEI3BwID3P4x2rNvROlYJCtAfjGbgNb8YCPQ2t42nzFhECrRYuL
	2H4n8OirQg2ujAkd1mVV46e0/ca6q/VcDf7AzorgiuWYr3jtnYACSsRhkAxue2X9TEHGeQ==
X-Received: by 2002:a05:6214:4102:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-7098a855026mr44069946d6.44.1754574622778;
        Thu, 07 Aug 2025 06:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX5W9OIu6saBYDV0YXjlz5Xl07l+QbXVshJX2L+0ypDPs8YDP0IdLJwPHCyRtytfrRNuaQaw==
X-Received: by 2002:a05:6214:4102:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-7098a855026mr44068536d6.44.1754574621124;
        Thu, 07 Aug 2025 06:50:21 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm17965636f8f.43.2025.08.07.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:50:20 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 7 Aug 2025 15:50:18 +0200
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        quic_vgarodia@quicinc.com, konradybcio@kernel.org, krzk+dt@kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJSvGhRkFXEJeR8u@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-6-jorge.ramirez@oss.qualcomm.com>
 <4chbcvub4scnv4jxjaagbswl74tz4ygovn3vhktfodakysbgy3@kukktkwd2zsr>
 <aJHgh8mon9auOHzi@trex>
 <aJHqpiqvulGY2BYH@trex>
 <to2hrxml3um6iep4fcxhkq7pbibuimfnv4kfwqzlwdkh4osk5f@orjzbuawwgko>
 <aJMMhIqNupwPjCN+@trex>
 <0248afed-b82d-4555-8277-e84aacf153fd@oss.qualcomm.com>
 <aJNTigOMy1JFOxot@trex>
 <s3rr3p5axi3iu4zvgwgjyhjtxmv7sgp6bqkmsgv2l76p7zxu2k@rxzbblyr57an>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s3rr3p5axi3iu4zvgwgjyhjtxmv7sgp6bqkmsgv2l76p7zxu2k@rxzbblyr57an>
X-Proofpoint-GUID: C5m2bDfI3BVDWk1ilMwOqtc8fdrdN__L
X-Proofpoint-ORIG-GUID: C5m2bDfI3BVDWk1ilMwOqtc8fdrdN__L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+ADAUZ6c6fWL
 z8JXIZ6el/pdb7JpS6FqabeYwFlsXGOKH7agFknixgOV5c3TfWeGaor47dDd0FCXvg6CgBJIiEM
 3b0mr6swr7wyDbUZtEF7d/tY8dN6W7gs5AGzQnZZtxjTlb74hfgXO486NgZtghCDAPJCecq2gar
 mi5Fwx81UYaQrxJTmigp9/+qmOlCDUDopqZgie2EMRmj8Rqj5Am8e8M8ULQ3TzpHBKUEZrmN3o7
 wnMhjDD4NGpHRPMsr50Q3bGfQj0FfkpGSxhEz0IoCwlJBxjg8zHpvJw/A2LOJeauCx2roZi1VXS
 cTVE0bkwtf0UjbVvtozPiT2ZbMWYyGKy67qFyfdf/+UkdN9oRgvTbwKTvEwczu7mCtyHtnRRi+p
 9Vpi4ANl
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6894af20 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=NOzLQxjBGogwJnxeP90A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 07/08/25 14:52:08, Dmitry Baryshkov wrote:
> On Wed, Aug 06, 2025 at 03:07:22PM +0200, Jorge Ramirez wrote:
> > On 06/08/25 11:01:09, Konrad Dybcio wrote:
> > > On 8/6/25 10:04 AM, Jorge Ramirez wrote:
> > > > On 06/08/25 04:37:05, Dmitry Baryshkov wrote:
> > > >> On Tue, Aug 05, 2025 at 01:27:34PM +0200, Jorge Ramirez wrote:
> > > >>> On 05/08/25 12:44:23, Jorge Ramirez wrote:
> > > >>>> On 05/08/25 13:04:50, Dmitry Baryshkov wrote:
> > > >>>>> On Tue, Aug 05, 2025 at 08:44:28AM +0200, Jorge Ramirez-Ortiz wrote:
> > > >>>>>> Add a qcm2290 compatible binding to the Cenus core.
> > > >>>>>>
> > > >>>>>> The maximum concurrency is video decode at 1920x1080 (FullHD) with video
> > > >>>>>> encode at 1280x720 (HD).
> > > >>>>>>
> > > >>>>>> The driver is not available to firmware versions below 6.0.55 due to an
> > > >>>>>> internal requirement for secure buffers.
> > > >>>>>>
> > > >>>>>> The bandwidth tables incorporate a conservative safety margin to ensure
> > > >>>>>> stability under peak DDR and interconnect load conditions.
> > > >>>>>>
> > > >>>>>> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > >>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > >>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > >>>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > >>>>>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > >>>>>> ---
> > > >>>>>>  drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
> > > >>>>>>  1 file changed, 50 insertions(+)
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> > > >>>>>> index adc38fbc9d79..753a16f53622 100644
> > > >>>>>> --- a/drivers/media/platform/qcom/venus/core.c
> > > >>>>>> +++ b/drivers/media/platform/qcom/venus/core.c
> > > >>>>>> @@ -1070,6 +1070,55 @@ static const struct venus_resources sc7280_res = {
> > > >>>>>>  	.enc_nodename = "video-encoder",
> > > >>>>>>  };
> > > >>>>>>  
> > > >>>>>> +static const struct bw_tbl qcm2290_bw_table_dec[] = {
> > > >>>>>> +	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
> > > >>>>>> +	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
> > > >>>>>> +	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
> > > >>>>>> +	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
> > > >>>>>> +};
> > > >>>>>> +
> > > >>>>>> +static const struct bw_tbl qcm2290_bw_table_enc[] = {
> > > >>>>>> +	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
> > > >>>>>> +	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
> > > >>>>>> +	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
> > > >>>>>> +	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
> > > >>>>>> +};
> > > >>>>>> +
> > > >>>>>> +static const struct firmware_version min_fw = {
> > > >>>>>> +	.major = 6, .minor = 0, .rev = 55,
> > > >>>>>> +};
> > > >>>>>
> > > >>>>> This will make venus driver error out with the firmware which is
> > > >>>>> available in Debian trixie (and possibly other distributions). If I
> > > >>>>> remember correctly, the driver can work with that firmware with the
> > > >>>>> limited functionality. Can we please support that instead of erroring
> > > >>>>> out completely?
> > > >>>>
> > > >>>> yes, in V7 I did implement this functionality plus a fix for EOS
> > > >>>> handling (broken in pre 6.0.55 firmwares).
> > > >>>
> > > >>> just re-reading your note, in case this was not clear, the _current_
> > > >>> driver upstream will never work with the current firmware if that is
> > > >>> what you were thinking (it would need v7 of this series to enable video
> > > >>> decoding).
> > > >>
> > > >> I'd really prefer if we could support firmware that is present in Debian
> > > >> trixie and that has been upstreamed more than a year ago.
> > > > 
> > > > 
> > > > I share your view — which is why I put the effort into v7 — but I also
> > > > understand that maintaining the extra code and EOS workaround for
> > > > decoding needs to be justifiable. So I chose to align with the
> > > > maintainers' perspective on this and removed it on v8 (partially also
> > > > because I wanted to unblock the current EOS discussion).
> > > 
> > > +$0.05
> > > 
> > > I thought we were going to eventually relax/drop the fw requirement
> > > when the driver learns some new cool tricks, but are we now straying
> > > away from that? (particularly thinking about the EOS part)
> > > 
> > 
> > um, no not really: the decision was to simply drop support for pre
> > 6.0.55 firmwares for the AR50_LITE.
> > 
> > Pre 6.0.55:
> > 
> > -  has a requirement for secure buffers to support encoding
> > -  requires a driver workaround for EOS (providing a dummy length)
> > -  during video encoding.
> 
> If it requires secure buffers to support encoding (which we do not
> implement), then EOS workaround is also not required (at this point).

My bad earlier — the EOS workaround applies to video decoding, not
encoding.

Video decoding does NOT require secure buffers, which is why it can be
enabled independently of the firmware update.

to clarify, the EOS workaround is necessary for decoding because:

- The current driver doesn't fully follow to the HFI spec WRT EOS
  handling, which leads to issues like the one we're seeing.

- The firmware we're using doesn't accept the upstream driver's existing
  workarounds — such as hardcoded buffer addresses like 0x0 or
  0xdeadb000, which vary across firmware versions.
    
The way I see it sticking to the spec — that is, always passing a valid
buffer which was my preferred choice and my first implementation — would
make the driver more robust and less prone to this kind of problems.

Failing that, I dont see the issue with adding workarounds/quirks to the
EOS handling (in this case).

if (IS_AR50_LITE(core) && is_fw_rev_or_older(core, 6, 0, 53))
	data->alloc_len = 1;

Even more considering we already have:

if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
	data->device_addr = 0x0;
else	
        data->device_addr = 0xdeadb000;

In terms of an abstration, there is no meaning to these values since
these are not valid buffers: we are just filling whatever it makes the
firmware work.

