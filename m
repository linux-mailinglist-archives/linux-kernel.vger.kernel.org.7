Return-Path: <linux-kernel+bounces-755034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7434B1A05F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CC189C7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A625394C;
	Mon,  4 Aug 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDaAN4Is"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C015E8B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306127; cv=none; b=F8KlYNbbRs2oBfdBiib084k1hDjV3m6K0PJNoImOfVhYKefWkTsJlMj38drOzIltMe7skjemTIZVg8BUXM/RqxnSZa576q5IEXwhxBh5VGU4TZ2BvCRCRxJC/cB5r9caFTzlqufAtjvZKnsaCyYkwRufAA+FBGsLS8f5QBIp924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306127; c=relaxed/simple;
	bh=G7VJRvbSdgS+wzOGL901RqaflLzSRJ9pft/+txq/7lI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAQ3JPlzwTEwf4pLfI0yeGfNqKFNQABDN/cKIq3ywgA3kTjs0AWiSEp72JdY5cBOrHpSQ2rsU0D9vCw9prKYR+5h/rDxJOU6GjPPJgUufFM3c/gm23OpAan2zDjnhGtSTnN4bXs6sriaP+/tnp6FYzKxSc+Rdhktt2tk9izPT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDaAN4Is; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749Qek8027099
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 11:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=khqumXgaeHAqtOicptnDS0Wb
	FDwIn2bilvzuMqy8oI8=; b=LDaAN4Is/O4pK5Lt70OteEtPMqmDjYYXCRomm1Eq
	jAeq/HHrrREWIRNOvWmD+2kGBxHhYasKCtlgrOUd9JU8y4XhHfITeipz1f92ob+3
	4bSwK2Q3qrxPnLvaVeJdJWGoZyY32xbdBnjEhZ2qV8TRdb7kE/+LbZC3/Rmyld92
	F0KteQ/E1uKcB0FRqvrrWOqAuwoAOeleT3pcufeUvggvE60P+WSomnhuJRaBss88
	36azY6ZJt6OCsyjRTSxb8Ml6OfX/ZUEG25cKvZA9TP7+YFVSTT4lKMnldXh/cnf9
	g34H/+LI8V+5vWuapipKE0ub9DC0P3ry+8/m93JTHUc7aQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pacs2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:15:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07bf0783bso3465291cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306123; x=1754910923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khqumXgaeHAqtOicptnDS0WbFDwIn2bilvzuMqy8oI8=;
        b=Gyik0IMjOaRjSg4tAaZ1rSr9/xAlrmPN2JRnEuKXqawjSKNLckP9AUFiMPOZKYtcfk
         zEK+qsBsd4gQrva954XLkE4cX1NgZBCog16Bawy3FQldYJLWfQA8sOIFyHqoE+qUFr5l
         4+lWCv20l4vBAXavPmjtEOtxblRsGlJbIOfJQRu3wLvz9sA/7vDzFnE4kGqs70lgf80Z
         gA88L8F2ZDW2WIw0VfddBVSw7CaEiiqUKmI5+Wf5haosFYzvYFYtT//dth3e6/3Vl1mY
         hULDET7K51ubYFbuba9J1ZuE0aRGQ38cpsxjFfAKJzuKTJZwTrUjpe+6iSJ4TMM8sCSV
         IKFA==
X-Forwarded-Encrypted: i=1; AJvYcCXkY5tZPVit6lEIA/fsCQJPYYKBOpPNHDxhvPb0qOgzrlQzz8vR8bi1a/y8d54QVCTt+kMhZ/ieFhT0wdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBAUZrtlttCwx/z6NVn7idlS29dNSDHB0xZ12VBla0LgE0utk
	vNHj0YTmZm3mm6+ibaOKjgYOX+7OMf25AnnNnsakilUCNRM7Rh1PMgGfZ8CmjGySL6Xxuit9mCb
	Gpnqn00QP2Gv4O32oOgr7Rz6w4hJmQYArFakvtAytjfz9LbQipr6QT4NI0CM57lTVvgw=
X-Gm-Gg: ASbGncvxm38hAUIPsLqc+Vj4/Ct/AJ/CbgoDsulzsJDoQDsGiWDIpxlvL9/MWyZT1/r
	CgAnhOOh+LviAou9CJj9LQTKUlPQsrMqi+rHdHv8QMKjC0NfvRlfsSBa7uUgzml0C/koZjLUmH5
	pLFfAXyD0AeGYvCDNvz9g/RlD5N59tTwOjlt6OKYMqsOTal3XppWd0TEIjTMjwbeuoB8Kn4uaoe
	a5YSHOzKX8WCTQmrNRk8di+5JcbS3BvzNkAArNe6ECBIvDRK1oa4poXDsWgBSeAaWIZBZXr/YI1
	0PivIGja4ipOc82i4V8MvazXISXqR4V309avqnjr/AhaJlJGCxg8bm2kxFH+HUJfn6RUtw==
X-Received: by 2002:a05:622a:91:b0:4b0:799c:14a8 with SMTP id d75a77b69052e-4b0799c15f4mr9055561cf.48.1754306123122;
        Mon, 04 Aug 2025 04:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqIXmJ2D9AVE3K0rmg2b6xzkn4wYQT4O3dPGfpm20inAFLC64DHI0V56Q6QLRVEJIOBskO7w==
X-Received: by 2002:a05:622a:91:b0:4b0:799c:14a8 with SMTP id d75a77b69052e-4b0799c15f4mr9054801cf.48.1754306122368;
        Mon, 04 Aug 2025 04:15:22 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm5634589f8f.43.2025.08.04.04.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:15:21 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 4 Aug 2025 13:15:20 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, krzk+dt@kernel.org, konradybcio@kernel.org,
        mchehab@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] media: venus: Add support for AR50_LITE video core
Message-ID: <aJCWSAfxBzLYqlQL@trex>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-4-jorge.ramirez@oss.qualcomm.com>
 <4734edd5-8224-4caa-8844-c38dabc6b6c0@linaro.org>
 <aHij+NHG5xbM1paO@trex>
 <8ac6f365-205a-4140-98b1-847f54ce08af@linaro.org>
 <aHjtgHT2Nxmm5nEf@trex>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHjtgHT2Nxmm5nEf@trex>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MSBTYWx0ZWRfX2tteCl2nMECx
 ayfP/IqCJXrwdtn9mceP2AMPnkXlBfpKrTcl3xLZwq4BrPq4ttsVBwwUglbWccX576wLbIHeg6G
 tfgtT0P8BjC5x4DbFMcmf0t3Jf62x2jqFKjaYrkSt4fJjxy7s6PqHj5xsm6geUvt0/6kfBhZTF/
 4wZWEspHn+SySsCJ7Iu7IT6zrnLWmT2x6nzrbmqVGbHM/xu7FUbZ8Z7Y7La0ckAop92LfaoMh8i
 5DTyGhaglFtlSuS0fKsKKfateTDM3LPeDPcMHsDMZggxYKpPw2XQWdA2RDX/4xmADxc38Mfo76R
 Q1SkGH7EO0lN+6hyILm+/mvfhtEZzek9HeE2m5WnuIqRJ30PUs/G6gDWhgtkY4cgxzYTWahNyNq
 yUwxHV8ild0QsyQLJ2Tvhrp5ohLONows4DuM47EgSMMK2s9PgZL4a9VRAF7lrf+IklMwhrqY
X-Proofpoint-GUID: kFv8U4RLOcJzdHp2AbtHWLby6x0Gmuzj
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=6890964c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=p0WdMEafAAAA:8 a=SliKETZjkfTHB_9U9w0A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: kFv8U4RLOcJzdHp2AbtHWLby6x0Gmuzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040061

On 17/07/25 14:33:04, Jorge Ramirez wrote:
> On 17/07/25 10:29:44, Bryan O'Donoghue wrote:
> > On 17/07/2025 08:19, Jorge Ramirez wrote:
> > > > > --- a/drivers/media/platform/qcom/venus/helpers.c
> > > > > +++ b/drivers/media/platform/qcom/venus/helpers.c
> > > > > @@ -230,6 +230,24 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(venus_helper_alloc_dpb_bufs);
> > > > > +void venus_helper_prepare_eos_data(struct venus_inst *inst,
> > > > > +				   struct hfi_frame_data *data)
> > > > > +{
> > > > > +	struct venus_core *core = inst->core;
> > > > > +
> > > > > +	data->buffer_type = HFI_BUFFER_INPUT;
> > > > > +	data->flags = HFI_BUFFERFLAG_EOS;
> > > > > +
> > > > > +	if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
> > > > > +		return;
> > > > > +
> > > > > +	if (IS_V4(core) && is_lite(core) && is_fw_rev_or_older(core, 6, 0, 53))
> > > > > +		data->alloc_len = 1;
> > > > > +
> > > > > +	data->device_addr = 0xdeadb000;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(venus_helper_prepare_eos_data);
> > > > This function doesn't appear to have alot to do with AR50_LITE as it
> > > > pertains to IS_V6() and IS_V4().
> > > > 
> > > > This I think should be a separate patch with its own commit log to describe
> > > > the quite complex logic of version numbers going on here.
> > > Let me give it some background:
> > > 
> > > According to the HFI specification, EOS (End-of-Stream) buffers must
> > > have 'valid' addresses. While the firmware currently appears to make no
> > > use of the EOS buffer contents, allocating and mapping them would have
> > > been a better driver choice IMO. Hoever this one has better performance
> > > which is probably the reason why it has stayed.
> > > 
> > > The firmware then does perform operations involving the buffer's size
> > > and length fields, and enforces boundary checks accordingly. On the
> > > AR50_LITE platform, an earlier firmware version lacked a check on
> > > alloc_len, leading to a division-by-zero scenario.
> > > 
> > > This has been addressed, and we plan to release firmware version 6.0.54,
> > > which includes the necessary boundary check for alloc_len.
> > > 
> > > I should probaly replace IS_V4(core) && is_lite(core) with
> > > IS_AR50_LITE() instead of trying to give it the appearence of a design
> > > feature.
> > > 
> > > seems the sensible thing to do, right?
> > 
> > I'll stipulate to all of that.
> > 
> > I know I'm being pedantic but, the title and subject of this patch is
> > "AR50_LITE" does stuff.
> > 
> > As traveler from a mirror-universe - I would read the commit log here, look
> > at this function and be none the wiser what was going on.
> 
> right this is because I think you saw through my inconsistency.
> 
> The truth is I should have written the function as below; and I think
> now there is a case for it being in this patch since it is addressing a
> firmware issue on the firmware release supporting this core which the
> patch is adding the functionality for.
> 
> void venus_helper_prepare_eos_data(struct venus_inst *inst,
> 				   struct hfi_frame_data *data)
> {
> 	struct venus_core *core = inst->core;
> 
> 	data->buffer_type = HFI_BUFFER_INPUT;
> 	data->flags = HFI_BUFFERFLAG_EOS;
> 
> 	if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
> 		return;
> 
> 	if (IS_AR50_LITE(core) && is_fw_rev_or_older(core, 6, 0, 53))
> 		data->alloc_len = 1;
> 
> 	data->device_addr = 0xdeadb000;
> }
> EXPORT_SYMBOL_GPL(venus_helper_prepare_eos_data);
> 
> what do you think? this is really just adding a the AR50_LITE line to
> the existing implementation.
> 
> > 
> > The EOS check is a fundamental HFI capability which is why I again reiterate
> > it deserves its own commit log with the above explanation - word-for-word
> > would be fine from my POV, to explain what is going on.
> >
> 
> umm not sure yet but if the above does not make you change your mind
> I'll do it.
> 
> > Long live the Empire!
> 
> :)
> 
> > 
> > ---
> > bod

will drop this - not needed since the decoder will not work except with
the incoming 6.0.55 release (see below)

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/630

This firmware - on top of supporting the encoding functionality- removes
the need for the dummy length.

