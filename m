Return-Path: <linux-kernel+bounces-581175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4CA75B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B08188ABB1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BD1DC991;
	Sun, 30 Mar 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c/a/T8SF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DF1C5F25
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356674; cv=none; b=pOZ0fsfW92Fw+TIlb0BguGLm4YE+O1+FIBYM9E+g9HzccaLJD7HJUwz76AoWdXO2DLpa1bo7cE2GWYX1jORVCRMFnVbfZe1Loltu9YnISF9YPVAMBs9lIHNQbbcrYBiTsr6eV9NZIqGZrnYjFPoqHMQ9mLKfB239FN3D0fm94KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356674; c=relaxed/simple;
	bh=7xAAdSx3SziRtvlRu+9iYdZze4R1GlyrcLEJHwdiGcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMlS/XQOE6/r2NFDiEAP9noKYnm8aI/2HMlJtYF7taSdDoeyBibvNgtdrvuytiOEP8v0umbawZ+JGRlsgg1sHEsAZYim+s0r9erqCDzry4SbdLAW07ZmAFk6p8VSGdvAIXVgfZyptPE+dJ1w1ojrgPi+3auUPYUyCumQq0+ego0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/a/T8SF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UDiLmu030077
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 17:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RGy/BXdkn+FaBjrjE0e4Ilhe
	82g2XsSffULT0Mpi/HU=; b=c/a/T8SFK0hvkeaIWm4+QDdjLdgpxofI4GfhWu0q
	IxP6UIO8QduzNTAMP2g8hs6201g+gVtfOdmS2I3IVYFEuk3Vq/qldBd8JJ3Glr/l
	vnLXYW3v1iUkkUtKGjywMNqpOLPo8tFkKyeL3xw2KJIy9zZoijq7eBFJO+wJw8xU
	t2j3RA/C3uZQn9AU5cMvY20+Ve7Wh+jpSNStbG4a+4dhQphDhzq0kN/db3NHuNiq
	QaJ/9xtrAorhel0MaIogJn5XpK3EJzYjaKYXJIod/+Gqz5QWeR66lTDdTPqP9Zt8
	nk6BkXtElnrSuWGXDFDq5J8kH6nBqhpnowShShkNDbfmOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qau63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 17:44:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so6056919a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 10:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743356670; x=1743961470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGy/BXdkn+FaBjrjE0e4Ilhe82g2XsSffULT0Mpi/HU=;
        b=D3pC97CmIs8Wtf3xkM5MXKSDCXeewQqag7t7CrsNCTPkumqQnCOnHVrUeJvnr0pSFV
         30IX3mx1wYaS9QExA9QE8eSS+lvr1Vc6d3XJnzzN0fTo+pI3OZGaQ5PbuVtUJfvI59hd
         rwoyd/1qDyfOIKV9jkohrs+J+VVny9TIQWt/Q3cLUq21IxErUSwD4LJfxqEKhGsivWwK
         +XfoKRLmE+ioprF3a3FVn9zWAzpboT3Ouil7uJb45FtROOdF3J8p/V0TBCLGZfdk++G6
         ZoUcDnOLkKBFKk4EYmGJDQNnHZ183eFJmMT++hMRH0ADtedCrCFe2S6tlUqHYzOgaYJF
         r32A==
X-Forwarded-Encrypted: i=1; AJvYcCUjDwkH7EYjRWfL7+u6tQqyIetnYkSzOqpHLSkpcAlD0pmbHztUF+svO1lTCPM0UvQvYbjXnBnZK84MfsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDehHpwsm3+9dBo9VZHHpe3KPsA3GYUVnEqhWi6JSFlzsNdlJm
	7n+lVehFEqxkBVswIkZyS/Mx2GxTxsX4Ygsm9bzDt0j4/q3+uRIHp/r15r8CA88bQ4dnqlsdeIS
	b1rYpJV2MKorKmibatzquIv/kBQ+BEpbLyMOqKwfL11X+6vOgrUhSry9QTMwB2HV0RI/VunIHXG
	zoRZxgmjgGSaUXElM1DAHg1pXbfslw3AcyDONT8vd2Ln1h0cMFVkaAoQ==
X-Gm-Gg: ASbGncviJ/lgx8U/73QXZq/+67CwYRJGJV5cmtDa8OrRPElGFV4A5I085loQWbpreBu
	eK7MTKvRMxHPOcmfcLBIFffW2sj5qxxWnxl+msQ8JqtqcvFc+MaVvjsmMVxKMuYC5ywcG3KOM
X-Received: by 2002:a17:90b:2c8e:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-305321634dcmr8431992a91.34.1743356669578;
        Sun, 30 Mar 2025 10:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYT5EvuXXuFkySKTzmGaRo+rd5mpcdPSG+aWnOrbUh0FdJS7OnX4GtLZAsl5B9bjpyb5koZKe4LgDVemtvgkc=
X-Received: by 2002:a17:90b:2c8e:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-305321634dcmr8431980a91.34.1743356669138; Sun, 30 Mar 2025
 10:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v3-1-156801d97a8a@linaro.org>
 <qub7j44btsgd2vdn67jn65c7y7kx4dhjojoh4z5erjalugctad@fyenu2xkuo4b>
 <CACr-zFCOqGmsFnJ_aW7cV99gmQdEtso3JGEiFFeKjk6-p6R54w@mail.gmail.com>
 <CAO9ioeWTgK2AYYt19VSOVjF6rt00xZ=gt1=dUb4A7UEEMwgaSA@mail.gmail.com> <CACr-zFA=m=ObUF3ZOgbGth5tXEkfUPczbEveEtsZGvNLXm2q2Q@mail.gmail.com>
In-Reply-To: <CACr-zFA=m=ObUF3ZOgbGth5tXEkfUPczbEveEtsZGvNLXm2q2Q@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 30 Mar 2025 20:44:17 +0300
X-Gm-Features: AQ5f1JopJpsKWlYgNEeDsWijzZrZlG95psgKKUCGGgfkE5wpBqVHTlAvFRUtsQk
Message-ID: <CAO9ioeWSn4H=y0c62c2TgXtPakhATv33NeYDcMLKMSmLLFo6bg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp: clamp PWM bit count to advertised MIN and MAX capabilities
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67e982ff cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hzK5tJkHoMkwow-xmq4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5J7VPhFBfwS4PlnfWzXPLHguNOd1xPYg
X-Proofpoint-GUID: 5J7VPhFBfwS4PlnfWzXPLHguNOd1xPYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-30_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503300123

On Sun, 30 Mar 2025 at 20:21, Christopher Obbard
<christopher.obbard@linaro.org> wrote:
>
> Hi Dmitry,
>
> On Sun, 30 Mar 2025 at 18:17, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sun, 30 Mar 2025 at 20:11, Christopher Obbard
> > <christopher.obbard@linaro.org> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On Sun, 30 Mar 2025 at 17:42, Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > On Sun, Mar 30, 2025 at 05:31:20PM +0100, Christopher Obbard wrote:
> > > > > According to the eDP specification (VESA Embedded DisplayPort Standard
> > > > > v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
> > > > > less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
> > > > > the MIN value as the effective PWM bit count.
> > > > >
> > > > > This commit updates the logic to clamp the reported
> > > > > DP_EDP_PWMGEN_BIT_COUNT to the range defined by
> > > > > DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN and _CAP_MAX. This ensures correct
> > > > > handling of eDP panels that report a zero PWM bit count but still
> > > > > provide valid non-zero MIN and MAX capability values. Without this
> > > > > clamping, brightness values may be interpreted incorrectly, leading
> > > > > to a dim or non-functional backlight.
> > > > >
> > > > > For example, the Samsung ATNA40YK20 OLED panel used in the Lenovo
> > > > > ThinkPad T14s Gen6 (Snapdragon) reports a PWM bit count of 0, but
> > > > > supports AUX backlight control and declares a valid 11-bit range.
> > > > > Clamping ensures brightness scaling works as intended on such panels.
> > > > >
> > > > > Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
> > > > > Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> > > > > Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Properly rebase patch on top of latest version of drm-misc-next.
> > > > > - Make patch more generic by clamping PWM bit count to advertised MIN
> > > > >   and MAX capabilities (suggested by Dmitry).
> > > > > - Link to v2: https://lore.kernel.org/r/20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org
> > > > >
> > > > > Changes in v2:
> > > > > - Split backlight brightness patch from T14s OLED enablement series.
> > > > > - Use PWMGEN_CAP_MIN rather than MAX (Dmitry).
> > > > > - Rework commit message to reference eDP spec.
> > > > > - Rebase on drm-misc-next.
> > > > > - Link to v1: https://lore.kernel.org/all/20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org/
> > > > > ---
> > > > >  drivers/gpu/drm/display/drm_dp_helper.c | 48 ++++++++++++++++++++-------------
> > > > >  1 file changed, 30 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> > > > > index e2439c8a7fefe116b04aaa689b557e2387b05540..fcc26cb96a51066a503433b2dc660126155d179c 100644
> > > > > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > > > > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > > > > @@ -28,6 +28,7 @@
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/iopoll.h>
> > > > >  #include <linux/kernel.h>
> > > > > +#include <linux/minmax.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/sched.h>
> > > > >  #include <linux/seq_file.h>
> > > > > @@ -4033,8 +4034,33 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
> > > > >                           aux->name, ret);
> > > > >               return -ENODEV;
> > > > >       }
> > > > > -
> > > >
> > > > Nitpick: please keep the empty line.
> > >
> > > Sure.
> > >
> > >
> > > > >       pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > > +
> > > > > +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> > > > > +     if (ret != 1) {
> > > >
> > > > No. Please take a look a few lines below, where you are removing
> > > > corresponding lines.
> > >
> > > Hmm, the original code which reads CAP_MIN and CAP_MAX both check if
> > > ret != 1 too, am I missing something ?
> >
> > Yes, you do. Please scroll this email a few lines down.
>
> OK, so just so I understand fully before preparing next version, no
> change is needed in the logic in this line? Just a commit message
> change?

Let me do that for you. This is from your patch:

@@ -4061,21 +4088,6 @@ drm_edp_backlight_probe_max(struct drm_dp_aux
*aux, struct drm_edp_backlight_inf

         * - FxP is within 25% of desired value.
         *   Note: 25% is arbitrary value and may need some tweak.
         */
-       ret = drm_dp_dpcd_read_byte(aux,
DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
-       if (ret < 0) {

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So... I don't know what to say here.

>
>
> > >
> > >
> > > > > +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> > > > > +                         aux->name, ret);
> > > > > +             return -ENODEV;
> > > >
> > > > Hmm. Why? It was 'return 0' before and your commit message contains no
> > > > explanation.
> > >
> > > Yeah, basically returning 0 here would not set bl->max but indicate
> > > success. Is my logic correct? I will simply update the commit message
> > > if so.
> >
> > Please describe that in the commit message why it's required for those
> > two reg reads to succeed.
>
> Sure.
>
> >
> > >
> > >
> > > > > +     }
> > > > > +     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > > +
> > > > > +     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> > > > > +     if (ret != 1) {
> > > > > +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> > > > > +                         aux->name, ret);
> > > > > +             return -ENODEV;
> > > > > +     }
> > > > > +     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > > +
> > > > > +     /*
> > > > > +      * Per VESA eDP Spec v1.4b, section 3.3.10.2:
> > > > > +      * If DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> > > > > +      * the sink must use the MIN value as the effective PWM bit count.
> > > > > +      * Clamp the reported value to the [MIN, MAX] capability range to ensure
> > > > > +      * correct brightness scaling on compliant eDP panels.
> > > > > +      */
> > > > > +     pn = clamp(pn, pn_min, pn_max);
> > > > > +
> > > > >       bl->max = (1 << pn) - 1;
> > > > >       if (!driver_pwm_freq_hz)
> > > > >               return 0;
> > > > > @@ -4054,29 +4080,15 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
> > > > >        */
> > > > >       fxp = DIV_ROUND_CLOSEST(1000 * DP_EDP_BACKLIGHT_FREQ_BASE_KHZ, driver_pwm_freq_hz);
> > > > >
> > > > > -     /* Use highest possible value of Pn for more granularity of brightness adjustment while
> > > > > +     /*
> > > > > +      * Ensure frequency is within 25% of desired value.
> > > > > +      * Use highest possible value of Pn for more granularity of brightness adjustment while
> > > >
> > > > Huh? I don't see a corresponding code change. If you are fixing the
> > > > comment, it should come as a separate commit.
> > >
> > > Sure. I will drop this hunk.
> > > I folded it into this commit as it was a leftover artifact of moving
> > > the code around.
> >
> > Please refrain from folding unrelated changes.
>
> Sure. I will be more careful in future.
>
>
> > >
> > > >
> > > > >        * satisfying the conditions below.
> > > > >        * - Pn is in the range of Pn_min and Pn_max
> > > > >        * - F is in the range of 1 and 255
> > > > >        * - FxP is within 25% of desired value.
> > > > >        *   Note: 25% is arbitrary value and may need some tweak.
> > > > >        */
> > > > > -     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> > > > > -     if (ret < 0) {
> > > > > -             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
> > > > > -                         aux->name, ret);
> > > > > -             return 0;
> > > > > -     }
> > > > > -     ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> > > > > -     if (ret < 0) {
> > > > > -             drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
> > > > > -                         aux->name, ret);
> > > > > -             return 0;
> > > > > -     }
> > > > > -     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > > -     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > > > > -
> > > > > -     /* Ensure frequency is within 25% of desired value */
> > > > >       fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
> > > > >       fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> > > > >       if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

