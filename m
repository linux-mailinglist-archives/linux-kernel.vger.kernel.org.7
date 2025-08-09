Return-Path: <linux-kernel+bounces-761035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8612B1F37D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0679C16C21B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91E27FB07;
	Sat,  9 Aug 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PkK+dHIe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2A2236FC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730571; cv=none; b=CR7gXBK+9blpgAMzyNTFoIOotVI6jsngxB/UlqNqx/duQEk6EPq0VR1YkjKus8ht4u8IbQEqoZ5lxvp8Ga4vwOoVVzjcevzPhBmsAnmKRw6T+WJcCqUl4NGY9Q6ZLhPZo3pD7xahLA2sr9AYaDJ6h5arqUv+/4Sb7fH98rTqME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730571; c=relaxed/simple;
	bh=gj5WdryTYu7PT4dTZngjyxnWpSzUxEs+xqEH1hXzTQc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSWSc6soxtnqYRDSKYxusa2i+As2brEdpt/EVAmhd2/gfee0YeNz1G958pa9JWPdsq8Q7TVxDP4gSOVzEtGDND9Gzrhs4gN/AsNUg+oA6A7uIYWB7nhQa1p6W+ST9gLepMDjzLEaJupHjI40/9khCInfqqnO6LkHmvbUt2ovTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PkK+dHIe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5798Wvro001587
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i1p4sIou1OtXlVv6o2JJTzg44/zZ5upOzf0/7xYa3us=; b=PkK+dHIeYigCel8M
	i/26lYcOcLcNcmR7YKbLytinfo1eiki44XBl57oQIYOCcN665fhtPBfXhXqW5GaI
	KyeHFUXCp+/c7EmIEd3vx8i5oNVk13qroSB4tT1OulGxe2MHTTpLwS48RTmptrsB
	oj/pm6wn2oh88s3ej7kvbh0X3bM/tBFMJ5LVdsKYI4ikY/EudQqAjXh3h1ZEmpNj
	JiKMbzz2Bo9v7Nq/SJxPyQraRuZdeQTxXO7bIIoVKBAv9YOOrzmdzB+YGLNihZNh
	6yrcK9XQIXJdqgLFgLDuryEBwWF71gdZQ9t+dcGxVvo4vTe60O8CnnKXREEPZ6Zc
	T1JJHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm8a8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:09:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4aedcff08fdso53595311cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754730567; x=1755335367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1p4sIou1OtXlVv6o2JJTzg44/zZ5upOzf0/7xYa3us=;
        b=bcsv5c3rOOlawjy+GIGUoLc6sZCnC04EZsEQR4y9G6ISFSe9xeYTkBVSis5oWYVwP/
         WCT95k6GWlEU87eT246ya7DJt8Mx2gtx4L9Z6pkVl5HA3klt9iYiCUOU2AGdpX6qinVy
         A76cy2/40j99Ers89YJ8h6XvVfQPtxeA/2fxDhSRAqjriFzXlTMSVukHoY7W1vSM8zbq
         y4LdmfsN3f3bwvoQlM7oUKtU72FcqRt0Qor8gWAUkUG1YCeQ8BftFuqf0cJcOSd+yywm
         EPyBsFB26aN77V8iqgSSeHqpNgpFpOBntEK/PBVDeMeyIHY5Qe5e6lY+wsVkMjM6GgJm
         Ys8g==
X-Forwarded-Encrypted: i=1; AJvYcCVITdsHrjf5KWPD4bbaXcFEEXXwni4Pte4wcdkLvfiLIMGmmahu/36GkPI5tMJlQPkQR+R6Wfos4ohxlXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpO0/PpLqCghDivqUutG42iNwBdHq2oK0STmwH+UFMxpl5phyZ
	aPoueUpsMlezIH9IxKCj4RQwV+d3jHmxows5j6WLwd1XQMcPP8au4yYCqK//x/EyLhdiWdqgnu5
	8nsox6oGWGBJJevcXlw6Wi6xkp5s9DN577AZoiVFvqK/46Uc2vhRwJaCJ4zokb46+zn/xWqAOYV
	ICIA==
X-Gm-Gg: ASbGncveA7FOWX1tJiMWJkHTo4hkmKP/3m1LLsW9+D14cdWM8a7irJy6tEW6Af2ZARi
	dWqW+0qjr4XiQXsnRCP1h8BH1Ke+b4H2OQTl4O+YgnGGHW2KaB4mB5BxRnWhMz/Fg7jE/ywlMwX
	GZsIXkZIh8X9wGI8nJ89f24syHBDhW9fh/6Kd5p7z/TN3vFBNVfdMYmn2njnH6lPiYwMEHsQouC
	fkYk43gtsPn9c3DyOMcQaMFiTINzCqKt8kOWb1Bytdo3ebGly/OM7u4wOHHX6N2EhROrSY+ZXLg
	O2wk/bQejMOKHsVm93vC5leS5fwnjiV8AjVHiuhYDiyaMOVb3jdsIMefj7u+aAzzWk9KAA==
X-Received: by 2002:ac8:59cc:0:b0:4ab:65c3:37d0 with SMTP id d75a77b69052e-4b0aedd7d06mr83220641cf.31.1754730567403;
        Sat, 09 Aug 2025 02:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtfrK4MBV+QXIawmd4r+w5lF0c2fMvBfjSp7sAbrpzm1gjiPZN0ejajPq8vKUzIPcSwLTQWQ==
X-Received: by 2002:ac8:59cc:0:b0:4ab:65c3:37d0 with SMTP id d75a77b69052e-4b0aedd7d06mr83220271cf.31.1754730566864;
        Sat, 09 Aug 2025 02:09:26 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm33241324f8f.18.2025.08.09.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:09:26 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sat, 9 Aug 2025 11:09:24 +0200
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bryan.odonoghue@linaro.org, quic_dikshita@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aJcQRLDplbNetNKN@trex>
References: <aJHgh8mon9auOHzi@trex>
 <aJHqpiqvulGY2BYH@trex>
 <to2hrxml3um6iep4fcxhkq7pbibuimfnv4kfwqzlwdkh4osk5f@orjzbuawwgko>
 <aJMMhIqNupwPjCN+@trex>
 <0248afed-b82d-4555-8277-e84aacf153fd@oss.qualcomm.com>
 <aJNTigOMy1JFOxot@trex>
 <fcdd9534-d494-3fdb-dfa7-1d15da6f697a@quicinc.com>
 <aJSvjqfQw3kNrVVH@trex>
 <447caa6d-13d2-2e75-5f33-6df9b2fd6d69@quicinc.com>
 <2yj3er5j72yoa2ltboopx5gvquur7jl3viqnq5qsci2fxjf4ix@7t63vgizfknb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2yj3er5j72yoa2ltboopx5gvquur7jl3viqnq5qsci2fxjf4ix@7t63vgizfknb>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX0mZwQSGEHiDy
 vG/SJnuBdx2O5dgR+uBZ25X763QLJW5EcERqJnbSu+FPfAXI4rHsZEyKiqf0Naczb1UPXYGKISd
 3hpm/DiT+ML89dYi5PPAIOUC/i5vBoEZzmLs4qUL/Uj8Aq3iVHkEaSXvEnXtHfUMgAMqmbaZMsl
 HowhGE7dB/HO8RIwj3IHwHm1PuMRnFrzTsWhorTmPziy8M6OfmlmMeX0t+M45AA1XkktobPTd0S
 2gYewK8Yd2ACbK6odDd/GRsV5jOUVjN2A+rojHBfGMhDnzbrlKpjwDL2qMq+XYfpbhjT3y7Tf1Z
 wN1ew1Vea7D6Fn8Cjw5V14QdA1Ok/RMjeVdq3I1HBQ3fZ2a0uTsV0jutrP4U7Bgj1QQvK4Cpcy5
 nx9eC8RU
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=68971048 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=24S9wm6B5SMZhME8xikA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: EpJgsC34lsdR1YV9anhs8c4cObQN7sBV
X-Proofpoint-ORIG-GUID: EpJgsC34lsdR1YV9anhs8c4cObQN7sBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 09/08/25 11:18:21, Dmitry Baryshkov wrote:
> On Thu, Aug 07, 2025 at 10:05:10PM +0530, Vikash Garodia wrote:
> > 
> > 
> > On 8/7/2025 7:22 PM, Jorge Ramirez wrote:
> > > On 07/08/25 16:36:41, Vikash Garodia wrote:
> > >>
> > >>> It was agreed that this complexity was not necessary and that we should
> > >>> just drop <6.0.55 firmware support (which would in any case only include
> > >>> video decode).
> > >>>
> > >>> And so on v8, I removed the above.
> > >>>
> > >>> Now I have v9 ready to post it, but Dmitry is asking why cant we have
> > >>> the v7 functionality so I am waiting for direction.
> > >>
> > >> the issue is in firmware for both encoder and decoder. Didn't like the idea of
> > >> driver carrying the hack for a firmware issue. Just because, for encoder, we are
> > >> unable to hack it in driver, we are ok to have it enabled in a newer version of
> > >> the firmware, we can follow the same for decoders as well.
> > > 
> > > if that is the only reason please do explain what do you mean by hack.
> > 
> > I meant that the EOS handling was not needed in driver after fixing it in
> > firmware, isn't it ? Was trying to avoid carrying this in driver.
> > 
> > I tend to agree with the comment made by Dmitry in another thread to have decode
> > enabled with existing firmware, no option but to support the *already* published
> > bins.
> > 
> > Having said that, these limitation of having a separate EOS dummy buffer is well
> > sorted out in gen2 HFI which have an explicit DRAIN cmd for it. Hope this
> > motivates you to migrate to iris soon for AR50LITE variants :)
> 
> Migrating to Iris won't bring gen2 HFI. Think about users which have
> OEM-fused hardware. For them it's not possible to switch firmware from
> gen1 to gen2. Thus, if the SoC has been released using gen1 HFI, we
> should think twice before upgrading it to gen2.
>

As I understand it now after the thread, any driver developer working on
new features should not be constrained by users with OEM-fused hardware.

Since only the OEM can provide signed firmware updates, it is their
responsibility—not ours—to figure out how to deliver those updates if
they want their users to benefit from new features (or new fixes).

The EU Cyber Resilience Act supports this view by placing the update
obligation on manufacturers (at least that is what I understand it, let
me know if you understand it differently)

Breaking backward compatibility is something we must avoid of
course. However, guaranteeing compatibility between old firmwares
(whether signed or not) and _new_ features is a separate matter...




