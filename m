Return-Path: <linux-kernel+bounces-737671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85897B0AF27
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F152FAA175E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD22226CFC;
	Sat, 19 Jul 2025 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9E9NDCO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CA2367C5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752918305; cv=none; b=qdJaClaUpAciaou9nyNk4D6R4MO7BRZi55H+HM48bs7j+VsY/LaEUTHA2AcpXeDLH/35CB4hfGgcIB9aAn3Dxz7hjC9Q6uC7pkruhKUo+X1clOyac+POrjMSPOCrs0wsAfgN1YG1uluAs3Gdu7x+gDpaHBh4L8zL0pdgGgq9ScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752918305; c=relaxed/simple;
	bh=hqvHHheKAZnHkb3a7WD3cL/KUebdQJVYwj73ESmJgYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWlRKjOfVvYNlE8ISFkRIIyn/Qdkl3boy2bTYQsVxFUGf/g/mm+/a1sopaJZhK2IJUeetaQdIiDgRgMt68NX39R0VYPurftAir+/a013n+qUxePyqOb5L3P31l/v5lzokTv1iOoGf3Nt9C9jvvN53oX5vm8RyYlTlfC5W/YAEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9E9NDCO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4f8S8005105
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=R0sRSQm6QGldYU9cEcvu2UaM
	4oCZ6d5h4JpfdEInEJ8=; b=e9E9NDCOMkAo1RFfIPbiv8pnNNhg/5OMJLWFp7C3
	DqceBnVGb6VdB7PrrPA6b2CaLeh+Wko2ws2f6z9Q5BT8lFEtpvj9BcHQvyJGZmp5
	hRmvANy6TDjoVEdFXQweMZ6+CEyknAwVa8YdVwaY2Es3C5sAw9ACzLInjoHKFVkY
	2+3DshMPetj4hnMpAzJu3AZ1f0xe/fi6xeJuq+CshwJlmsL2L2EcUnun1R2wlcDb
	he09kOf+NGZX4LvZdT+Ri9FivAiDCh58q6WIUHXd8Q+Kzbg6sZVgpGFupj0jhwjr
	dzCmfAtJAtW6E6+QEn4zBVaKP7yBPIyY3nem2eYNgmiVvA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmgcun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:45:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e190b977b9so489007885a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752918301; x=1753523101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0sRSQm6QGldYU9cEcvu2UaM4oCZ6d5h4JpfdEInEJ8=;
        b=gatwu/eQel8Nt1go/tq4BB2dK2hntSA1uJmavns38+aMaQ8mB1Snen1pt1ecFmg4SN
         cfEe3YY+cVu6reNm9hmURwo388iv5Vx7cR1uRRiNjONODBaZncpBdZmtpeHd+DL76GqX
         7k1cu0TeuDszbhHth6IuYTUuNP4lyrOvlZ3VbKFE22WL8WAd35hYozTag4zsHi00DrYj
         ZcCw95BeaC6CRwijdyoiYr66QX91TVHKgW6uwAbZgDqXXtZkoQa1TI48AMHwSFAk5VsM
         xrUfZcqmZViL5q1BgFwbj0IGLZ/Hbtb78GB7t2NlgEeuq3b2AuL5S5ufezC4941WCMJY
         2DAA==
X-Forwarded-Encrypted: i=1; AJvYcCXnWRvZQPzmMBJDrkzbcrjYjAHwmyZzNv4xlWaTKizOOtBGSgYMcKDq/1GN7Ki4Dy3uDsfgyeqD8Cgqu8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84ttWw9qTm1e1tOkQnxjMY0Jgo9K1mnE5nd5Q2AV1fCfmGGO3
	cSjfLUx5WXFVocaS/g6U6gccX9H2XRRQc/kx93j6rOnZ1r1VLRXGn8vEwCvXEpILIlZm806j2Gj
	gzois/gZ8nBS+C6wJlnEjBexueE+rKVttarh1BgWjGDegrMOWVDpTjyMOZjNzhkmtoQc=
X-Gm-Gg: ASbGncvhzETsUct9g1+VvDNR+ZcosTGAq52Rt4qKyyI5r/FjBt5nE6XxYPWMBaDBFtT
	Pql6WoXtpjONIRJCaomAbAg59pCQOjGF1nEdsiFv7DtBRYRlTEFsiiLu+xbVblfDLGfmw+0RUlS
	aXKCrE2/tEQEo6FKVOJQq4kSvpADA3u0lAg5iUcCnV3nTL0BaRfJHRGMWHboZsoEWQVVSC2M71r
	V6a9MBCY7hft1IgG6r0M8BFiuFRV7AK3sHxQ6efTPaFmcAFWNTVBLOWmb4RHlj/NhoGM8GbyVIz
	lshVlmgovR2KS4X94RwhBKDxNpNXCyc2Vk81VtYpd8DOHLV3+yX9pVhA96e23OCBsG8eBcb8fjo
	WC8diABV0es75j3fpH85E6Tv31ffg9BsEQknpHe4JawQIL7TqMLOB
X-Received: by 2002:a05:620a:e09:b0:7e3:43cf:5a73 with SMTP id af79cd13be357-7e35557c7demr767059885a.11.1752918301226;
        Sat, 19 Jul 2025 02:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPdP6NiZKgFvKPiQrN/esZZaRULd3fT9u4TcKGfAdnilezqUcW8siPDqSy3OKK9PIDQMg3ng==
X-Received: by 2002:a05:620a:e09:b0:7e3:43cf:5a73 with SMTP id af79cd13be357-7e35557c7demr767056885a.11.1752918300733;
        Sat, 19 Jul 2025 02:45:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d8f936sm638066e87.138.2025.07.19.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:44:58 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:44:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@kernel.org
Subject: Re: [PATCH v1 5/5] misc: fastrpc: Add missing unmapping
 user-requested remote heap
Message-ID: <lmytte3p2eq7fsjsbogzrqjyimlw42v2x2zystx32nuvnm62yb@wzqrmhqcrzl3>
References: <22uccyp5m2szry7bpitqcav5nlvwch5eqh4mdacfedidgrnyhx@vsjobngwdkmb>
 <dc67df54-2a19-4318-acd4-b96b8549b64d@oss.qualcomm.com>
 <7ogkoxsowpd2x5qmjog4qx5eu4eiinvtnyjz5hfufgna2hz7na@oxzmowlnelxb>
 <61dd2c3f-20ac-484e-8a45-f42fd5f42b86@oss.qualcomm.com>
 <CAO9ioeX1uE3ty5oSezYOLJKqf8G5dLYAS5nRiNvryWTk0RPdEQ@mail.gmail.com>
 <f3d376cc-6e2d-4ac3-88f6-3104eec67acf@oss.qualcomm.com>
 <qw64xqfnyy76f6oawtaecvraejcwyml5k7oxdy67adj2rh46lq@nupxbuy3vwu4>
 <7505f0e8-222d-4052-8614-c12109d14bce@oss.qualcomm.com>
 <cq3qfx32dallivdcwjwqgq7kggiwucpcyhwqqlbrf6n4efkmuc@htjwnigojag2>
 <8b877eeb-941a-47c5-a67d-450dfb772d6e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b877eeb-941a-47c5-a67d-450dfb772d6e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 7Ke4yyFGEuPCfWSilywv-cCMXM4N05Yx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5NSBTYWx0ZWRfX0rbGbRIFXWt9
 PhS6A1/aUQkDiDuTn/EBUIubsfVVYD4Klyp21Y3b58wi6SOtU2fKyqCxJDOjKdbjR6akYnILysz
 jZSZaJl3EKNy1ylenUFIHr61QFUkeMReTKCcdSmSfnFYUrX6SVYxditqDYe/2oPG+0/ZFXvfEcY
 RwoVf6WXLPG0Q5vTmg/RCe7ZQf4hDKZW9oSvAN3BwM67J52z/CHUq1vCvpqDCKDGdceOXt0PKnX
 gHAtxj7votoSl4cYvwVfnbvtnRXV3iCnwlDByfMEk/r8h9BAw+bEOmqwX9/LH06aQMR1nx6xPFg
 P/UA3HmUtgLEwP8BClrVvowESr6KVvt5lYNMVPvNtCpzs6z3sqiEnNO8RtKWQQAlglIdDP9bcY2
 j9wDRbnb4eiBI2y9zJueHYQK9yyYBQrjuohcak9dT4/NADtqYJdmS8vUmI3Yg7QQ3tLdGoyY
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687b691e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=QlMHoEhoFvJFoSiYPA4A:9
 a=MBxd-Kn_9RtsxwEB:21 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 7Ke4yyFGEuPCfWSilywv-cCMXM4N05Yx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190095

On Wed, Jul 09, 2025 at 11:13:49AM +0530, Ekansh Gupta wrote:
> 
> 
> On 6/12/2025 3:54 PM, Dmitry Baryshkov wrote:
> > On Thu, Jun 12, 2025 at 03:02:52PM +0530, Ekansh Gupta wrote:
> >>
> >> On 6/12/2025 1:35 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Jun 12, 2025 at 10:50:10AM +0530, Ekansh Gupta wrote:
> >>>> On 5/22/2025 5:43 PM, Dmitry Baryshkov wrote:
> >>>>> On Thu, 22 May 2025 at 08:01, Ekansh Gupta
> >>>>> <ekansh.gupta@oss.qualcomm.com> wrote:
> >>>>>> On 5/19/2025 7:04 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Mon, May 19, 2025 at 04:28:34PM +0530, Ekansh Gupta wrote:
> >>>>>>>> On 5/19/2025 4:22 PM, Dmitry Baryshkov wrote:
> >>>>>>>>> On Tue, May 13, 2025 at 09:58:25AM +0530, Ekansh Gupta wrote:
> >>>>>>>>>> User request for remote heap allocation is supported using ioctl
> >>>>>>>>>> interface but support for unmap is missing. This could result in
> >>>>>>>>>> memory leak issues. Add unmap user request support for remote heap.
> >>>>>>>>> Can this memory be in use by the remote proc?
> >>>>>>>> Remote heap allocation request is only intended for audioPD. Other PDs
> >>>>>>>> running on DSP are not intended to use this request.
> >>>>>>> 'Intended'. That's fine. I asked a different question: _can_ it be in
> >>>>>>> use? What happens if userspace by mistake tries to unmap memory too
> >>>>>>> early? Or if it happens intentionally, at some specific time during
> >>>>>>> work.
> >>>>>> If the unmap is restricted to audio daemon, then the unmap will only
> >>>>>> happen if the remoteproc is no longer using this memory.
> >>>>>>
> >>>>>> But without this restriction, yes it possible that some userspace process
> >>>>>> calls unmap which tries to move the ownership back to HLOS which the
> >>>>>> remoteproc is still using the memory. This might lead to memory access
> >>>>>> problems.
> >>>>> This needs to be fixed in the driver. We need to track which memory is
> >>>>> being used by the remoteproc and unmap it once remoteproc stops using
> >>>>> it, without additional userspace intervention.
> >>>> If it's the audio daemon which is requesting for unmap then it basically means that
> >>>> the remoteproc is no longer using the memory. Audio PD can request for both grow
> >>>> and shrink operations for it's dedicated heap. The case of grow is already supported
> >>>> from fastrpc_req_mmap but the case of shrink(when remoteproc is no longer using the
> >>>> memory) is not yet available. This memory is more specific to audio PD rather than
> >>>> complete remoteproc.
> >>>>
> >>>> If we have to control this completely from driver then I see a problem in freeing/unmapping
> >>>> the memory when the PD is no longer using the memory.
> >>> What happens if userspace requests to free the memory that is still in
> >>> use by the PD
> >> I understand your point, for this I was thinking to limit the unmap functionality to the process
> >> that is already attached to audio PD on DSP, no other process will be able to map/unmap this
> >> memory from userspace.
> > Ugh... and what if the adsprpcd misbehaves?
> >
> >>> How does PD signal the memory is no longer in use?
> >> PD makes a reverse fastrpc request[1] to unmap the memory when it is no longer used.
> > I don't see how this can be made robust. I fear that the only way would
> > be to unmap the memory only on audio PD restart / shutdown. Such
> > requests should never leave the kernel.
> >
> > Moreover, the payload should not be trusted, however you don't validate
> > the length that you've got from the remote side.
> I was thinking of giving the entire reserved memory to audio PD when
> init_create_static_process is called. This way, we can avoid any need to
> support grow/free request from user process and the audio PD pool on
> DSP will have sufficient memory support the use cases.
> 
> This way the free can be moved to fastrpc_rpmsg_remove(When DSP
> is shutting down) or during Audio PD restart(Static PD restart is not
> yet supported, but clean-up can be done when PDR framework is
> implemented in the future).
> 
> Do you see any drawbacks with this design?

I'm sorry for the delay in responding to your email.

I think this is a perfect idea. Can we be sure that there will be no
extra requests from the DSP?

> 
> >
> >> [1] https://github.com/quic/fastrpc/blob/development/src/apps_mem_imp.c#L231
> 

-- 
With best wishes
Dmitry

