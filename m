Return-Path: <linux-kernel+bounces-827709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2AB9276F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AE84446A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62081316189;
	Mon, 22 Sep 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLzOmE8w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E0313E16
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562990; cv=none; b=oN+IK7CCRHGJQDcR1UdfEmTT5K9E2rjR3vBnDkapZflEYhmkilwqH7fuNGw5mCkci+No+Pg/5NY7x2kZuHg3anz6BQvnWOUZdVeiaQr5fTv9EhREQfj275zJE0hiBXpu6GpXhfk8Q+utHlfTTh8sqI+sbEGmgOqlSNH0N4+8bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562990; c=relaxed/simple;
	bh=JF4w6KNGnuKCjdC182NdLkyovnl2owTMQCcxkDcd66g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enqJwGy8p3SuSM2b0eddbuz9EPfn559hx94uHoa/fAm3rrLLownMutAwm41873Pq3nh5NK2GKG6sNSrzw67O8oKtJwyyD44YGVQS1NHmuWGd3qRoIpjUfHcbDUB1do9ZrPV5pVRT3YPWrV7R58fbbRDkV2qe6IO0BLXO7bZNyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLzOmE8w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGfVRb011758
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=yvgfuHDV+HWhZSkeRI3Pt16FGGVNb4TH8n/i52MwM3g=; b=NL
	zOmE8wLavsRCLuc23aBaXpL2n2/OVgmwBBv6t621NZ5i8QAv4DyQXNpZDfBkSxkv
	kqYkAfXhhKjyB+H84X0C0t7dzDZa5Wxxr+Qv6MnA4i1YOb7S/OfC8aqfgeeDVh4S
	B0/rqTZ0bGjre7DO2yP+EmLTFzVSdYkl19zmcd0o0Ka/+26N8TM3mD4/Nurzhpe1
	9s4Xyfb2ufV96986hxhPMrW8Qo1xd+m1XiabZoXUBlH+x9uR9FUDf4SR1mwB9B45
	sROklBhbOITms1+jG7dmJtC9EsekRsY2qkcElHhGQGn53cF3i8UfHRH/7MpEEn7j
	PFPk9aK3fWZ08Vo5329Q==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0wn56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:43:06 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30cce9b093bso5481040fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758562985; x=1759167785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvgfuHDV+HWhZSkeRI3Pt16FGGVNb4TH8n/i52MwM3g=;
        b=nSz0T9YCcmzIMU0GnnHMTBugTj35ZT82SuqChxmP8tZZuWL1r6waOokuojXN+vYagb
         ecWbkzHGCOWsMDPujblqieQGYhA27Qn3STYqrfJcAn7NDJSMu0IAIP+w2ECIo1wY+T8A
         8zwKRd7rMtQ9x+XSdZzo7+drCg4SYyhJxKqjWEIi8zDiO1XBZN8JUjJM/Sohgg0jN4Lo
         wwNizUAt01DbxmJ1IUOSmf0xd8DMbpNAQ70+lhVytgK33Tjk0S2SbXbEHeg7Zt6/bkPP
         NVGmxJByrk2JP67fjIR8KVTzogCcdnXamQYzggFfqkwH27+NMdc+V7HIZlJ3Rd07zB2y
         smOg==
X-Forwarded-Encrypted: i=1; AJvYcCVbekTidzsDHp4Rzl+RSfspoazRcNNCKCXhqhfpEhE/f/ATFbcQlx2declcVxxSWxSoNCiC5H3ccpnTS9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00zJIVdD5oi3NB6No+OK1fUT0IHbj68exhZRlJZKv9AXv3s3f
	fgTZ1Ac/yrpv7E8JxxSc50U+s2RTWEDrXA0aRswHhtZ0L9DrgZF6IIZY1pfu4nEdLAn9/zrQI+P
	y3msYGgVN2lAI5roJdagl4aBKtRmb8vW4a/M0Dqaetxnv+VqfA8QCStlpH6ogYV4w+REh2ea9h9
	oz4W2EJ/eZnjDL57BTxVYXkrkNKNHAro/ayXuDbbM74Rv/2iuJXFQ3
X-Gm-Gg: ASbGnctrvZ2AOwGEsXA9g9Ofs6lyvdjJkATqUqyQIh9ML263GpnZKPUA67vvtULUYw3
	VPxeSlNhPF4TelfmJzKpXT42OCgUycH+IUAa7NFPq5r1uzNeYxACdN1HF20jRPBV8OPxlZK10Kz
	DktXHQDivN15vhC+i6blFlbG5MGhquj0YI6dF0tMQnQ2QJa4FL+biy
X-Received: by 2002:a05:6871:81d0:10b0:341:2ab5:7d22 with SMTP id 586e51a60fabf-3412ab6015amr1979921fac.24.1758562985148;
        Mon, 22 Sep 2025 10:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoA0dMMXMZm/AwIu12gzZ7XmnuJ5PuUXYj+3q/9EpvzDPqD1DiF05WqIK0oiCIbqyqRkx3oOwvpZFzNPaRND0=
X-Received: by 2002:a05:6871:81d0:10b0:341:2ab5:7d22 with SMTP id
 586e51a60fabf-3412ab6015amr1979906fac.24.1758562984723; Mon, 22 Sep 2025
 10:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
 <20250723190852.18394-2-robin.clark@oss.qualcomm.com> <aNF6N8u1VIFSTaRM@linaro.org>
 <CACSVV033oJodLUS2cwTVeMc9Y3o4np3UgDyX=T8caspRk3--4g@mail.gmail.com> <aNF9TGkEfYqfegrR@linaro.org>
In-Reply-To: <aNF9TGkEfYqfegrR@linaro.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:42:52 -0700
X-Gm-Features: AS18NWDhKnn8QaJQZWfqnPyi5wz3R825ji-5IThInATomz4gWftXC54tqlmJrZg
Message-ID: <CACSVV015U3=KpZqxzH7ySO=ok8k-0ff_-Yzc33SK_Smj1c-4-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Fix refcnt underflow in error path
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 5yJ_BX1YZnx_5fbyHuVj0iBOW9hmxPvm
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d18aaa cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rTF-Ql69s_4GWFK6w8YA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX6v76+mnSE5+o
 p4yBwGp3SDVvFKteLQXRcqp51gOYHyeGrVy5Mec6hMXRb/hG5S53W3uW+WXomdrPEaksx9tX/vD
 tBa6J9svf7XW2ZLuxtr4nzSOkjxgn5LvZhAjpo9lYGqGUEWoaC6ZJINqjEh8oKcNRAtH2Wv9i7s
 IFPfDnOgikGKMwmTM8ANVeHHvuDsxUahD69DHKiSdIoY70vRr4nMqSe0htRktoQoEToDGsBPUKh
 87MZxekjNHmxh8foNS2oa3kGfdnd0LAyNR43lJ2sblsgAjL/i7CZHXOW+vD9n8pemH8d3c09MHP
 qIV06xVtVH7HBM6EtoIrHCH+IZpIMWZZzRCQ3eo+odJFTrLzRxiuFcKCTjvhPWgioIHQ2+V5vK/
 qn0TKQlN
X-Proofpoint-ORIG-GUID: 5yJ_BX1YZnx_5fbyHuVj0iBOW9hmxPvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

On Mon, Sep 22, 2025 at 9:46=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Mon, Sep 22, 2025 at 09:41:07AM -0700, Rob Clark wrote:
> > On Mon, Sep 22, 2025 at 9:33=E2=80=AFAM Stephan Gerhold
> > <stephan.gerhold@linaro.org> wrote:
> > > On Wed, Jul 23, 2025 at 12:08:49PM -0700, Rob Clark wrote:
> > > > If we hit an error path in GEM obj creation before msm_gem_new_hand=
le()
> > > > updates obj->resv to point to the gpuvm resv object, then obj->resv
> > > > still points to &obj->_resv.  In this case we don't want to decreme=
nt
> > > > the refcount of the object being freed (since the refcnt is already
> > > > zero).  This fixes the following splat:
> > > >
> > > >    ------------[ cut here ]------------
> > > >    refcount_t: underflow; use-after-free.
> > > >    WARNING: CPU: 9 PID: 7013 at lib/refcount.c:28 refcount_warn_sat=
urate+0xf4/0x148
> > > >    Modules linked in: uinput snd_seq_dummy snd_hrtimer aes_ce_ccm s=
nd_soc_wsa884x regmap_sdw q6prm_clocks q6apm_lpass_da>
> > > >     qcom_pil_info i2c_hid drm_kms_helper qcom_common qcom_q6v5 phy_=
snps_eusb2 qcom_geni_serial drm qcom_sysmon pinctrl_s>
> > > >    CPU: 9 UID: 1000 PID: 7013 Comm: deqp-vk Not tainted 6.16.0-rc4-=
debug+ #25 PREEMPT(voluntary)
> > > >    Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN53WW 08/02/2024
> > > >    pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--=
)
> > > >    pc : refcount_warn_saturate+0xf4/0x148
> > > >    lr : refcount_warn_saturate+0xf4/0x148
> > > >    sp : ffff8000a2073920
> > > >    x29: ffff8000a2073920 x28: 0000000000000010 x27: 000000000000001=
0
> > > >    x26: 0000000000000042 x25: ffff000810e09800 x24: 000000000000001=
0
> > > >    x23: ffff8000a2073b94 x22: ffff000ddb22de00 x21: ffff000ddb22dc0=
0
> > > >    x20: ffff000ddb22ddf8 x19: ffff0008024934e0 x18: 000000000000000=
a
> > > >    x17: 0000000000000000 x16: ffff9f8c67d77340 x15: 000000000000000=
0
> > > >    x14: 00000000ffffffff x13: 2e656572662d7265 x12: 7466612d6573752=
0
> > > >    x11: 3b776f6c66726564 x10: 00000000ffff7fff x9 : ffff9f8c67506c7=
0
> > > >    x8 : ffff9f8c69fa26f0 x7 : 00000000000bffe8 x6 : c0000000ffff7ff=
f
> > > >    x5 : ffff000f53e14548 x4 : ffff6082ea2b2000 x3 : ffff0008b86ab08=
0
> > > >    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008b86ab08=
0
> > > >    Call trace:
> > > >     refcount_warn_saturate+0xf4/0x148 (P)
> > > >     msm_gem_free_object+0x248/0x260 [msm]
> > > >     drm_gem_object_free+0x24/0x40 [drm]
> > > >     msm_gem_new+0x1c4/0x1e0 [msm]
> > > >     msm_gem_new_handle+0x3c/0x1a0 [msm]
> > > >     msm_ioctl_gem_new+0x38/0x70 [msm]
> > > >     drm_ioctl_kernel+0xc8/0x138 [drm]
> > > >     drm_ioctl+0x2c8/0x618 [drm]
> > > >     __arm64_sys_ioctl+0xac/0x108
> > > >     invoke_syscall.constprop.0+0x64/0xe8
> > > >     el0_svc_common.constprop.0+0x40/0xe8
> > > >     do_el0_svc+0x24/0x38
> > > >     el0_svc+0x54/0x1d8
> > > >     el0t_64_sync_handler+0x10c/0x138
> > > >     el0t_64_sync+0x19c/0x1a0
> > > >    irq event stamp: 3698694
> > > >    hardirqs last  enabled at (3698693): [<ffff9f8c675021dc>] __up_c=
onsole_sem+0x74/0x90
> > > >    hardirqs last disabled at (3698694): [<ffff9f8c68ce8164>] el1_db=
g+0x24/0x90
> > > >    softirqs last  enabled at (3697578): [<ffff9f8c6744ec5c>] handle=
_softirqs+0x454/0x4b0
> > > >    softirqs last disabled at (3697567): [<ffff9f8c67360244>] __do_s=
oftirq+0x1c/0x28
> > > >    ---[ end trace 0000000000000000 ]---
> > > >
> > > > Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
> > > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > > ---
> > > >  drivers/gpu/drm/msm/msm_gem.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/ms=
m_gem.c
> > > > index 33d3354c6102..958bac4e2768 100644
> > > > --- a/drivers/gpu/drm/msm/msm_gem.c
> > > > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > > > @@ -1114,10 +1114,12 @@ static void msm_gem_free_object(struct drm_=
gem_object *obj)
> > > >               put_pages(obj);
> > > >       }
> > > >
> > > > -     if (msm_obj->flags & MSM_BO_NO_SHARE) {
> > > > +     if (obj->resv !=3D &obj->_resv) {
> > > >               struct drm_gem_object *r_obj =3D
> > > >                       container_of(obj->resv, struct drm_gem_object=
, _resv);
> > > >
> > > > +             WARN_ON(!(msm_obj->flags & MSM_BO_NO_SHARE));
> > > > +
> > > >               /* Drop reference we hold to shared resv obj: */
> > > >               drm_gem_object_put(r_obj);
> > > >       }
> > >
> > > This patch seems to break something for direct IRIS/video playback us=
ing
> > > dmabuf. I use a simple GStreamer test pipeline for testing IRIS on X1=
E
> > > (on GNOME, in case that matters):
> > >
> > >  $ gst-launch-1.0 filesrc location=3Dbbb_sunflower_2160p_60fps_normal=
.mp4 \
> > >    ! qtdemux name=3Dd d.video_0 ! h264parse ! v4l2h264dec \
> > >    ! capture-io-mode=3Ddmabuf ! waylandsink
> > >
> > > The video plays fine, but if I try to exit (CTRL+C) the display hangs
> > > for a few seconds and then the console is spammed with pretty much
> > > exactly the messages that you tried to fix here. If I revert this pat=
ch,
> > > everything is fine again. It feels like your patch does exactly the
> > > opposite for this use case. :-)
> > >
> > > It seems to run into the WARN_ON you added.
> >
> > Hmm, are we allocating from drm and importing into v4l2, or the other d=
irection?
> >
>
> Is there an easy way to check?

Maybe strace?  But, I think this would help, at least if v4l2 is allocating=
:

- if (obj->resv !=3D &obj->_resv) {
+ if ((msm_obj->flags & MSM_BO_NO_SHARE) && (obj->resv !=3D &obj->_resv)) {

(sorry about gmail mangling the formatting)

BR,
-R

>
> I would need to study the code to be sure, you probably know more about
> this than I do. I just run this command and it always worked so far
> somehow. :-)
>
> Thanks,
> Stephan

