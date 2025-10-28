Return-Path: <linux-kernel+bounces-874416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09AC16481
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C773BBD80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D334F468;
	Tue, 28 Oct 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1fw2rmJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpluxK2f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB334F465
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673379; cv=none; b=GNG7VJ18YrL/Inqj0Iv8gCqou8r+wQCTlnXM4dFoz1Ir1BA2PPN0ekIvumb982tBdXq9bnNvSqDTZlwDNW5s58MFsJbjQgZscq5b3p38Dd9PdcidW07TM4Yt4H9/pkbwITVsJFPyNlmpOF6zIrawVkfBCwPNjnYFKqgV+CtQsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673379; c=relaxed/simple;
	bh=HR99sC5uZsqVUMBFRelBierRMLcfIMwr4Mda/gA5tLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dks+n8W5hDpxh4iTpyznHdn7NCRf4TyzjtAuxmQFZMbda3mIScawJIFskIpKJqHflObUdiuMq7fUP3fvOJ9xY46HEcwqUW8TY4A1JSxkdT2YjQRXMbfRwpig3Zwg9ozwZd0MTFy9BtYoIKPzce146+xnW+jugIkJwGVnyqXQbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1fw2rmJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bpluxK2f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEniee1974284
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B93WHN0pecu+JdBLsnOgA2E5ylesrRB93++k474f36w=; b=U1fw2rmJxPiAsX0e
	fPld53GvmIDqqsmtnKcmgbh2yWwTfmJoi5MeFtmowMTBT7aCoN8bptdG21zWE1ZY
	WwWGB/thzPWXtngKyscY/r8iUqqg6YUY0IAsyogypR2LR2H4xWL0RP8yY1oiMjkz
	ZDbZOMKVbGrUiqCWcDeKJ/C48mH++6Xmq/bCM8exlMo/W+QjEqgGf6OZ/Q5M5Jd4
	un3rO5g7CEiyFjBWzCVracdDnVVtL3YKe/h9BFKuog9TMPK5lJyGZI3c4KiSjDlL
	O38BkmY9LciKXgY2lxeKdwfhHcfTjHTPl5prYgyLt8J9SGwLYOrhAro4MVN2IwfO
	DlA4AA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pgeadan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:42:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-89018ea59e0so12611001241.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761673375; x=1762278175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B93WHN0pecu+JdBLsnOgA2E5ylesrRB93++k474f36w=;
        b=bpluxK2fi3ErriHg7wCTLKfJl0wZ7F0kdSPY5CtWwh6zS1vU4MuKOL5e4m5vmqLLgi
         dZhg+Q/knCnoU3sxxInfJ1EufWK+U4wojHWWUliBK3t1x1PJjzmHFpU57IEyAyewI5DV
         qFKgSnCMKKKHqVlDE2tEJzt3NINUnriRWomvEY5inJ3ZrsG+xIFpLMj0gaiFfij0npUk
         5gS0cd9+ETb3L1gHxPUf8ZMlQOIAPFAZyQHEQf0vVdt6eLZQ4IfD/mZAFNcplA7SXqR6
         kn3rVVRD2c04F1zQ0mtRabzhcG7gJkybYtyYhcoiQJlXZoVJDP2ndY2iiSmdL0zmKfkl
         phzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673375; x=1762278175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B93WHN0pecu+JdBLsnOgA2E5ylesrRB93++k474f36w=;
        b=AQU+a6TGBq1JwHUM/kFDrtnXtbmih7+bkyXU3VrqH8KtUE88SfbHcYnzCFxXtOi7dq
         7asb6RgGYwoXsXic59l5ZSLfM3hMqxOu1oNd443j0YAliRrTXBL0pXadjHWqX7Fs42j1
         JJfOx8W+JCpoFKGWcSy4rhfbVoVU98Io/iKZwiRAC8kdqxaITW1BSmVi+ie0yS4rEHlw
         Ec0NKXkh3xiHzNArYvhdecAQ6OnN58F683JA0pTjkf5QMtIy5geX1Es7CLuMDayqbxkg
         MkcItBqqyxgUy5S+1VEByUVXG0Nw4DWvrB/gIRQL2dqJsW9W2ipwLMfYvhEc3V9k0N5z
         CJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKuTj5UzST7wmgERXXL9kf1JGdINf7aFzeOErjRNSRdQSEt+LBFQ5qZIWhAgJGYPPrJpyVeMjGpFzoFNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxweNNvB8FsZjy6KP+StARkCdXJGwBqBpSZ5EL8QQMZJ5uH6G04
	lxwuZe/TZnPl3wTmEcu4/+bpDHVimc9uIWPhZViIfYL0yPPqs3Yr2QcYTWPufRuzP1tSanXM6MC
	Iak4KwO985NFN1acpJZ747jYTDXXRN7yCJtIB/PhL1xM+NwiZ8vhWkMXr/3XKkcjKFL4=
X-Gm-Gg: ASbGncsAIsbE2WXbAZNYZVcL1QmcIS51r2mfmVnjY4NbS2NMFKrewbK6TXpMD9iACYA
	OkZBodcvR9NuqnN/+q3dV3ZfSLjhX6TH0nsAjye6HCg9DTgJO6mXKsycfcHYSbaJHM9n4AAlEX1
	uLs6on5KxcJnDQ4JrjdMiDl19GR1YFaOKqeQd2TIaq+Pg9TDc9I/FJNuklck1NOCKOxaQ8W820u
	WRHtkS1S0Ndt55315s6eX+lK6nlD0eD2ww1KOH9r31UNIjb7S0IZiicNW8882OL1fp/Sccl+qNa
	ZUjDF5UYuLkXt2Q6lccs+cD7oVsfFqSNjvIBFIGyJCJKeNewnl1QEG0fVbWy4U2vagkW5FmN00Z
	56/Lkpt1RiPlZNL8WDeIPrABgpvnLfAoN
X-Received: by 2002:a17:903:2348:b0:262:661d:eb1d with SMTP id d9443c01a7336-294cb35eba5mr52386335ad.1.1761671255762;
        Tue, 28 Oct 2025 10:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgukZAvE035BJqYz+pZ5F4IyB2vUki1IRZC6Y+wRVNhxAKQ7bAKZu4Xe6sQ6wpAv1G9+cGig==
X-Received: by 2002:a17:903:2348:b0:262:661d:eb1d with SMTP id d9443c01a7336-294cb35eba5mr52385755ad.1.1761671254865;
        Tue, 28 Oct 2025 10:07:34 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128e41c01sm10882800a12.23.2025.10.28.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:07:34 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:37:27 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] watchdog: Add driver for Gunyah Watchdog
Message-ID: <5a2e8f14-90bb-4487-9c4a-b595218b817e@quicinc.com>
References: <25f7ff09-08ea-4969-9184-9fd01b097558@kernel.org>
 <76479593-c47b-41a7-8349-5d7c1403f7c0@oss.qualcomm.com>
 <73955d58-544c-4299-a099-bfd9e5912a40@kernel.org>
 <636a1f99-acd4-4904-8fae-f159646cc1a0@kernel.org>
 <f4d80be9-986f-4d37-9c25-725eff7bb653@quicinc.com>
 <e03373d9-e2dd-48b6-93a6-554fcd623718@kernel.org>
 <59a00934-cb42-43de-ac5b-a9292b08301d@quicinc.com>
 <aa4faa81-6e9d-41c2-85f0-32045a8f9f51@kernel.org>
 <jaj5oxqcgckndtp7wwe6ukqbh4z5phe3pw3hnhp2hatgqffjzr@y7qevil4o3yr>
 <aba2bf95-836e-444d-961d-0b2ac1fb415a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aba2bf95-836e-444d-961d-0b2ac1fb415a@kernel.org>
X-Proofpoint-ORIG-GUID: wSoubw6TE6LjhbTa-J481fZmws_cbHjo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MCBTYWx0ZWRfXxHsNQk6eZNp1
 HFNi0HfaTxPuM2loGlaXesbmAH2npdJFdSvahPG0yxyubjvov00B+hEFf40qEcUcLMxuJq8uIpL
 HN1hKgLcHCOYoEjoy6oVPjqlGSMpolCy1LbDsQZ0XbyRHwHjmZVGuh80cuuv/uhGl5GGOKWIdmS
 RzfIu94fA7Jnb8RWT6abIDBvXDaceCJEVFyE7DYA45dLKlZqT90/FoD25GMNXSbTq3wqxuJY0jo
 1snGt0VVD7HRZteykVQ8+YnWOXY0QmdiOBeWrIaBWQ+dx1wPMmswUM48EnXJXJht0hsMCyRiidP
 u9eH0v+4TRb75X6f6qMtM7HfygfgFTjm/ekAkLP8eKqesy2AA4FpF0FMNyTzi0sJqycQ446Xguw
 qahxIsSi64ka9NGtt33ygEQtSW2CwQ==
X-Proofpoint-GUID: wSoubw6TE6LjhbTa-J481fZmws_cbHjo
X-Authority-Analysis: v=2.4 cv=fLU0HJae c=1 sm=1 tr=0 ts=690100a0 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=cz7308oxQqenTtKe3SgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280150

On Tue, Oct 28, 2025 at 05:53:23PM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2025 17:51, Dmitry Baryshkov wrote:
> > On Tue, Oct 28, 2025 at 05:40:33PM +0100, Krzysztof Kozlowski wrote:
> >> On 28/10/2025 17:33, Pavan Kondeti wrote:
> >>> On Tue, Oct 28, 2025 at 05:17:44PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 28/10/2025 13:27, Pavan Kondeti wrote:
> >>>>> On Tue, Oct 28, 2025 at 12:07:40PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 28/10/2025 12:04, Krzysztof Kozlowski wrote:
> >>>>>>> On 28/10/2025 11:58, Hrishabh Rajput wrote:
> >>>>>>>>
> >>>>>>>> On 10/28/2025 3:10 PM, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 28/10/2025 10:35, Hrishabh Rajput via B4 Relay wrote:
> >>>>>>>>>> +
> >>>>>>>>>> +static int __init gunyah_wdt_init(void)
> >>>>>>>>>> +{
> >>>>>>>>>> +	struct arm_smccc_res res;
> >>>>>>>>>> +	struct device_node *np;
> >>>>>>>>>> +	int ret;
> >>>>>>>>>> +
> >>>>>>>>>> +	/* Check if we're running on a Qualcomm device */
> >>>>>>>>>> +	np = of_find_compatible_node(NULL, NULL, "qcom,smem");
> >>>>>>>>> I don't think you implemented my feedback. This again is executed on
> >>>>>>>>> every platform, e.g. on Samsung, pointlessly.
> >>>>>>>>>
> >>>>>>>>> Implement previous feedback.
> >>>>>>>>
> >>>>>>>> Do you want us to add platform device from another driver which is 
> >>>>>>>> probed only on Qualcomm devices (like socinfo from previous discussion) 
> >>>>>>>> and get rid of the module init function entirely? As keeping anything in 
> >>>>>>>> the module init will get it executed on all platforms.
> >>>>>>>
> >>>>>>> Instead of asking the same can you read previous discussion? What is
> >>>>>>> unclear here:
> >>>>>>> https://lore.kernel.org/all/3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org/
> >>>>>>> ?
> >>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> With this patch version, we have tried to reduce the code execution on 
> >>>>>>>> non-Qualcomm devices (also tried the alternative as mentioned in the 
> >>>>>>>> cover letter). Adding platform device from another driver as described 
> >>>>>>>> above would eliminate it entirely, please let us know if you want us to 
> >>>>>>>> do that.
> >>>>>>>
> >>>>>>> Why do I need to repeat the same as last time?
> >>>>>>
> >>>>>>
> >>>>>> Now I see that you completely ignored previous discussion and sent THE
> >>>>>> SAME approach.
> >>>>>
> >>>>> Our intention is not to waste reviewers time at all. It is just a
> >>>>> misunderstanding on what your comment is about. Let me elaborate further
> >>>>> not to defend our approach here but to get a clarity so that we don't
> >>>>> end up in the same situation when v4 is posted.
> >>>>>
> >>>>> https://lore.kernel.org/all/b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org/ 
> >>>>>
> >>>>> You mentioned here
> >>>>>
> >>>>> ```
> >>>>> To me socinfo feels even better. That way only, really only qcom devices
> >>>>> will execute this SMC.
> >>>>> ```
> >>>>>
> >>>>> We interpreted this comment as `avoid executing this SMC on non qcom
> >>>>> devices`. That is exactly what we have done in the current patch. since
> >>>>
> >>>>
> >>>> So where did you use socinfo? Point me to the code.
> >>>>
> >>>
> >>> Okay, lets go a bit deep into the socinfo part. we have used
> >>> `soc_device_match()` API to detect if the device is qcom (`family =
> >>> Snapdragon`). It works. However, when we built both `socinfo` and
> >>
> >> socinfo driver. Read my first feedback:
> >>
> >>
> >> "No, your hypervisor driver (which you have) should start the module via
> >> adding platform/aux/something devices."
> >>
> >> And then I agreed if you start it from the socinfo driver.
> > 
> > I'd rather not tie this to socinfo. The socinfo is an optional driver,
> > which is mainly used to provide debugfs entries. Watchdog is much more
> > important. It should not be tied to debugfs-only entry.
> > 
> 
> No problem. Choose whatever driver it is. The problem is that they did
> not even implement that. They claimed they followed review but it is
> 100% ignored. Nothing got implemented and they send the same.
> 

We will register the wdt platform device from smem driver something like
below. This makes this gunyah-wdt driver to register for a platform
driver which gets probed only on qcom devices.

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4..67bf5f075cb8 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1236,6 +1236,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	register_hyp_wdt_after_other_dt_checks();
+
 	return 0;
 }
 
Thanks,
Pavan

