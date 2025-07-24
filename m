Return-Path: <linux-kernel+bounces-743992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585CB10696
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B17C1718F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85295245016;
	Thu, 24 Jul 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c68fSYgO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F8244698
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349581; cv=none; b=jUGMZB4fEd/YB/hUNuHOgr7JdnRh/NgrRcBA6SIKANhWaUY99i5iQeopxN89dkBFpf9DrUk9hCSNkfdi+AoXk/qOs9H3pnvsiaMchrcjMV+LcUXQTDSbEMMNG95DP9gWF8CU9JmVf+uUGUZQiawslzHLpFwBLW6ynlJbKT0k5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349581; c=relaxed/simple;
	bh=OApKSnb9P9dV9tmzVBDvhpUVhZ9RnzxeOZUpevIwVpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K009ByaRfIe4GRSqI88mT/hp7GApt8KeF1/8dTU3ffWTqTus/drReEldeaOE7rDxcZ8jaxFGMsX/H82BwhkUj15L9IJJubmdizz1ll2m3GnwI2bGfOocKxs8e2ZnA9B+kIFatEadAjnswQreg2hJTlDB2TvCbJu9QZ5hH2DL0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c68fSYgO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NNlnSG024793
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mqPtRcbsCOw9EJIhatPqsdNe
	y6biej6WaprATCoZHfI=; b=c68fSYgOcIskSyM6amsMkBBy0BUZ63dZppXvSR6V
	ShYY/drd2v1u08mUGLBLhR+93YR1U7a9lqlgqG8AiVptN0O4i6AWGm2JleaNChuV
	U3irDMUEogVwhjLwmkTgR7qW8DluJ2yUv15RI9qYR80xUExaXLF8IdTkt5axpvO1
	/Uw/W2aSplfjChw42ZiluTY76yFQeIp4mWTOgVLVp7QjKBNxLD5sl2PBNLwz0cKW
	xuswAev07TGblCaGnrK1sfhwqlw9YYFisKb3plzSX2Ci0RDu7s27+dUZ44hovL71
	w/ogQ7YeDJShrUx2Z1yfRhi9aRevRPvrpnrywxBeJehNDA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6tc5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2349498f00eso17851045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349578; x=1753954378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqPtRcbsCOw9EJIhatPqsdNey6biej6WaprATCoZHfI=;
        b=gMHf8oRHFsL0Rc81UH1JbTnpY9CQILER3s39FQWTo7tFryLAKnh+s+WYZHE4JCCFd0
         ieatcLZiaeVhHuATXR0bq0AIqxVE/hBv5LFm1WRn9nVG1OCV9VmgHhIvp/2Nws66nwEA
         xLkyne0uuGqlsYnFwIyTEA9NTeEJqMFWbvfCOBMLqhKVJW6HPvDIbtxNdu7zsgyz0iYx
         87ECziaTOk8By9Fvh3QfSy5r5zPYi2bWcp8KTVyulhbzDJsM7IGqQS2ef+v489FYRoHM
         wRM1zdXVPw3NYHFkFX23KtVppfMkHKE0HD8BOxF2tYAK1c0mrY3hTdZq4eSnfUPrwEmk
         rZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNZ4IP62EslGpQDfl0BfbGhbOMcKatEqOiks/rlJL0PZmP89WV1FONla5jBHvbwkT90QCymRB7mST4j9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8t2DGBc/7QK071be+pDRxDXO/CemiHBsGyhfJR8CDVkBpdroK
	KORxVaGJe+Iqz0g4yYwnQ8GT40nn5ubkoR9gQVHs7D7+HTp6gHEBC6sTYX+2Yxb+/G9jlserFBg
	gV8aj2e1tR/w72iNFZpEjQMdyRuKbLKp21N7+5gdx3RDPkYsYrtIzu9OK+1IUvL9bK3dpYkRZ4a
	4mJ/1VHQKUyCi8Fzab5XdEDwIlKK1YnYU/LlmFYn1TXA==
X-Gm-Gg: ASbGnctxeeTKSxhlOpoLehOodEHJRHgBLnw5sYVUwiXMdOc79LJ2IfViglYlrJ6r43G
	P4PzoppfDBjT+0tZIx3khTgPFU0lXTNdutWGe21iS2oIoKtySZC7+3aaKCG55zu37+AA7IwW3RS
	YGNIdUoVIjtfGeOwqiSvWf5Xx/Cd6PAlL6UcQ=
X-Received: by 2002:a17:902:d0d1:b0:236:6f43:7053 with SMTP id d9443c01a7336-23fa5ce54a6mr13650505ad.2.1753349577732;
        Thu, 24 Jul 2025 02:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzcZWmBo9GRk2H2wGBOAXn/nV3iajdijuwc47ScbovcMfJiyNhRJm/ijNpez+vVpfMM1XLZpby4Ds8CFIu3OM=
X-Received: by 2002:a17:902:d0d1:b0:236:6f43:7053 with SMTP id
 d9443c01a7336-23fa5ce54a6mr13650325ad.2.1753349577252; Thu, 24 Jul 2025
 02:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org>
 <Z-pTcB0L33bozxjl@hovoldconsulting.com> <CACr-zFAiKRTHyRAF5HkM2drCMD7Q_Z3ZUFAsSnevy38yD8XMwg@mail.gmail.com>
 <Z--eRHaYw_vbgK2f@hovoldconsulting.com> <CACr-zFA77ogDSNEOGd32Rdh3geqkL25T0BKtNdKzUdjrL0+9RA@mail.gmail.com>
 <aCw4EK_8C1KLb6MD@hovoldconsulting.com> <6612cd14-8353-4d3a-a248-5d32e0d3ca23@linaro.org>
In-Reply-To: <6612cd14-8353-4d3a-a248-5d32e0d3ca23@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 12:32:46 +0300
X-Gm-Features: Ac12FXzfi9ETqpAOxGcnUxM_fc41kHLrlMlbMTS6AIQ3Z-mT3xW4dKOu7lXyMDU
Message-ID: <CAO9ioeWeQ++qSaD5ukooqBg997=1pwwS80NHD_xiHz25ABmtXg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/dp: clamp PWM bit count to advertised MIN and MAX capabilities
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6881fdcb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=2v3lhCP2OwN22-7ziQcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oR445RrJXLZeXbH5F251yu6KUdA-DW32
X-Proofpoint-GUID: oR445RrJXLZeXbH5F251yu6KUdA-DW32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MCBTYWx0ZWRfXxS3TO2LDWRVJ
 kbCphFAG19OIkbLrLcSCxKLYGArzuq8srWgGras+g8bckGUkCi22jGt/DTfME539hsEmWTYsDq9
 TvH/jckgQGSVMBdivvTgK9lTPV5MG7pLnf4zMOlsIEOusOXLfPIxWBvVue0x9g8xHxITqbSt98l
 0/KaTniOE92Nz0yqJBDapu0POT7a1arshCV7C/sCgtoppnpXDFrlV61XeHtK99XB83ECEqcOgx5
 654FyNPcxu90f7FsEVTnvSXmnG6UjzwASqJ8/s/H955cnWO+yGIMTM3NPV2O7EvZpxYBIOedKYn
 cadUGm/DOVwo29sLuRh+gJb0kpYl4/rumiTazuaTRUJOyG+pmt877a738NEVmxmHCkjVWLTmFKG
 dpLkBtmOMf6CspGY0VFLhJpHinSnxgczUBfZQiXVO1FQ1L4UT5F0QJeFYxXg6iPKtnprfeLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240070

On Thu, 24 Jul 2025 at 12:08, <neil.armstrong@linaro.org> wrote:
>
> On 20/05/2025 10:06, Johan Hovold wrote:
> > Hi Chris,
> >
> > On Fri, Apr 04, 2025 at 02:24:32PM +0100, Christopher Obbard wrote:
> >> On Fri, 4 Apr 2025 at 09:54, Johan Hovold <johan@kernel.org> wrote:
> >>> On Fri, Apr 04, 2025 at 08:54:29AM +0100, Christopher Obbard wrote:
> >>>> On Mon, 31 Mar 2025 at 09:33, Johan Hovold <johan@kernel.org> wrote:
> >>>>>> @@ -4035,6 +4036,32 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
> >>>>>>        }
> >>>>>>
> >>>>>>        pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> >>>>>> +
> >>>>>> +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> >>>>>> +     if (ret < 0) {
> >>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> >>>>>> +                         aux->name, ret);
> >>>>>> +             return -ENODEV;
> >>>>>> +     }
> >>>>>> +     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> >>>>>> +
> >>>>>> +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> >>>>>> +     if (ret < 0) {
> >>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> >>>>>> +                         aux->name, ret);
> >>>>>> +             return -ENODEV;
> >>>>>> +     }
> >>>>>> +     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * Per VESA eDP Spec v1.4b, section 3.3.10.2:
> >>>>>> +      * If DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> >>>>>> +      * the sink must use the MIN value as the effective PWM bit count.
> >>>>>> +      * Clamp the reported value to the [MIN, MAX] capability range to ensure
> >>>>>> +      * correct brightness scaling on compliant eDP panels.
> >>>>>> +      */
> >>>>>> +     pn = clamp(pn, pn_min, pn_max);
> >>>>>
> >>>>> You never make sure that pn_min <= pn_max so you could end up with
> >>>>> pn < pn_min on broken hardware here. Not sure if it's something you need
> >>>>> to worry about at this point.
>
> I'm trying to figure out what would be the behavior in this case ?
>
> - Warn ?
> - pn_max = pn_min ?
> - use BIT_COUNT as-is and ignore MIN/MAX ?
> - pm_max = max(pn_min, pn_max); pm_min = min(pn_min, pn_max); ?
> - reverse clamp? clamp(pn, pn_max, pn_min); ?
> - generic clamp? clamp(pn, min(pn_min, pn_max), max(pn_min, pn_max)); ?

Per the standard, the min >= 1 and max >= min. We don't need to bother
about anything here.

On the other hand, I think the patch needs to be updated a bit. If the
pn value changed after clamping, it makes sense to write it back to
the DP_EDP_PWMGEN_BIT_COUNT register by jumping to the tail of the
drm_edp_backlight_probe_max() function

>
> Or just bail out ?
>
> Neil
>
> >>>>
> >>>> I am honestly not sure. I would hope that devices follow the spec and
> >>>> there is no need to be too paranoid, but then again we do live in the
> >>>> real world where things are... not so simple ;-).
> >>>> I will wait for further feedback from someone who has more experience
> >>>> with eDP panels than I have.
> >>>
> >>> There's always going to be buggy devices and input should always be
> >>> sanitised so I suggest adding that check before calling clamp() (which
> >>> expects min <= max) so that the result here is well-defined.
> >>
> >> Makes sense, I will do so in the next revision.
> >
> > It seems you never got around to respinning this one so sending a
> > reminder.
> >
> > Johan
> >
>


-- 
With best wishes
Dmitry

