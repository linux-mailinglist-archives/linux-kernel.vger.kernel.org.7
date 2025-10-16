Return-Path: <linux-kernel+bounces-856846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B2BE53A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABDD3A2D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF912D8DA8;
	Thu, 16 Oct 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AIQe20Pl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF43346AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642728; cv=none; b=IT3bXbBC2/ms5wcc84ptGrFL60fSJpP3dPmWKAmvexPSZ5StlrIFw4fEYb2e9Rg/GiRlWg+z1f8n9Kevh5C6w4B5DFrJ6aUgqsExQMpTVLWFFWCYI8U5C6ldxIXzwWy1HWjVHCew4+9j+/BfsxdA3mhqTqhEyotdp+z44WvROD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642728; c=relaxed/simple;
	bh=CCU56jKMu+W55jmMpGsIbLiO2g/PG9wAmlqXGv4sgIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvRkNljkf7SAivcnxxk8hfekhPTr0pprt/paVgp7b1LcSP82b2+TVDK6JhENyVqQRPpMrH714210QBMRTNQ6n91pEVwuBeBIpDtLbHd9bVhUunmQaCQeSwGLru16Zi2+c5oW1TZhhznMMlX28LIxhNLE5207CVd2tvYI0uWSyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AIQe20Pl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GF48wq004423
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lbh0JZUshYKiyc2lneuG2hdFrLCFasxqkus6jGm8OCY=; b=AIQe20PlpmoybnSU
	ukzX03DVDUzqJL5AdIcly90DY9QpfCnyeVv/dW3xW/asKIpJJp9bb0yyfDqZIytg
	JFZ5ZLaZpNfihgTv99P2PCuX558LGOUQo1Y3RWruYYW1Y+1w038bxs1EcfZJehDu
	11DFbfbqQXKNFO0pi+zjzcc3JwlKvuma6Nr0VO2TYydz0CRYk441+HeBj5+XovyZ
	BJb0qArAi7JhVh6ECAwJ95GDwaB8z12UEnSgqIMnXcgapZirrvEHKPMlQlF/6po0
	WN2lMYTcL8RpDjHupDnNNxAqW7v9jAmQCVJPzVgL7sjhNeeB7iba6RDsVQ75xMLv
	DmV+QQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ansgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:25:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso1586603a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642724; x=1761247524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbh0JZUshYKiyc2lneuG2hdFrLCFasxqkus6jGm8OCY=;
        b=eUIL+/cKy7U1wqPV6FxCyaSFArmY54FXPwW9zlZqjpst5/rpoOpSYAT8UvTJeqQSar
         6gBafueV6+hqORRIwR+Gl5q0O/ORzLT6j0e95fvBBc5ec+97tmDRx5xDK/Qf1kPqXoxB
         JjePc1Dg/NdAwyuzheXZXQPQOkgdvdd40CFX9LK/Ns8omS5BNMgFs/rZkz2ieho1z0ie
         dSnKHMyexHYnviMNZll1VMxEehxW5pN5epxjQZGlF00k7QDZ1+TidvAle0CrnbpAYLio
         FZFf9Sp66hJlU4xTnDMNU5CbSdpjzWESxXyOaasdwBm6wszV5J9BB4EQ3uvtz+Xmq/QR
         118w==
X-Forwarded-Encrypted: i=1; AJvYcCU6H+cs/knjUgbj9SNe6SHWxaiBUxLhxRYiZE+XIUGGMEf0fM78dQjRVBfVEcENSr2Qsnh2e18BtJGnv14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rh/yTZxU87sxDd6tKliqIyPhKdjBA6i3wqYqlXAMdMn2x2eI
	oXMDtP5ujqFwFLU7pdFDd++4HqFRBghWbTTBA6B0vB0R7TBrPr6GUOWT6g/fJwTjcPtdW3HbzFk
	+54JAzCSXiTJQFL2wklgaCmTNFJPSxOx13wTl9l4YcSsSA1Mx8NL8l0vZ5o292l9XM7fSrd01/U
	yTVTkjffZnp/0RJo31q/qWq2oIOOyDXiGKMSakIHNLKA==
X-Gm-Gg: ASbGncucGj93mRxj8VTYLPwNUr8RlryBg33qitiUOcjRqnvUjv6GK7cT0fwOm0wUyUS
	WHJg+nEEoZQTq62y7vQL6p5GmAfvbo91NMouMWaXtOnfSYUObv6WvNqs0RLNlneH4bRMo0NCGXm
	E7XgcaoASbYAPkl4PCclqsRNTUeNtdKsFOhDCgJ7nLRu13NtVsO8k3H+rM
X-Received: by 2002:a17:903:15c7:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-290cbb49964mr12082055ad.46.1760642724402;
        Thu, 16 Oct 2025 12:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUo1sf7y9UCTcepHJ9i7RqY5zJv2p9Jgs22z3Q/2raqaie7S0KERNQ0h0ERxNG35cN3dlT3qcKoE/W74pbahw=
X-Received: by 2002:a17:903:15c7:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-290cbb49964mr12081735ad.46.1760642723824; Thu, 16 Oct 2025
 12:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828092615.2114183-1-souradeep.chowdhury@oss.qualcomm.com> <ud4nodcdhxr4pux6nsvqzaclqrnmct6ehjr5bmsxdgjby5xs4k@4c23gunpbf4z>
In-Reply-To: <ud4nodcdhxr4pux6nsvqzaclqrnmct6ehjr5bmsxdgjby5xs4k@4c23gunpbf4z>
From: Souradeep Chowdhury <souradeep.chowdhury@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 00:55:12 +0530
X-Gm-Features: AS18NWA_vFJNl8vztBLwAevewl0Ft1SgCKgxPX-aaUmsnifQALtgx3ww5dEy5Q4
Message-ID: <CAJek3sLVvd_wqHddsuc_n-Ob6Mm1Yyas0RqvZ-Mopy5m6rVidg@mail.gmail.com>
Subject: Re: [PATCH v7] remoteproc: Add device awake calls in rproc boot and
 shutdown path
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicnc.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f146a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jGnfN1tMAAAA:8 a=EUspDBNiAAAA:8
 a=c8bG8LX2rWeYhf_pb54A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=6MwZEyB11foWsxG17m01:22
X-Proofpoint-GUID: X6VwktAu6Cl8bLYeKD2lt51TNifgHHw1
X-Proofpoint-ORIG-GUID: X6VwktAu6Cl8bLYeKD2lt51TNifgHHw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX89ZcWSViZN2u
 LnRSzpM61OOAodvFw9PMB8KKWv0Bdt09Q5FJR6WURXhvYxTvegqo6LU/+y3LIo9so2n8EkMEs7K
 kufh2gQ6TPqgIahwIYG+a8gzfYidFayLWqxOmaqcGVvvd/EcYlECMEFhPprYjnOsuaSFMNhTUWq
 pgh9CQStIwjaS2jogYugTQmYfokU5JxAffTXaNMB7dK+4DoB4dOu/OfcI6XruS+G+ub33F6ZOZ1
 SqQNOYm7Bkfm2zf8nx4/bMQmFtWr+zQ40p5ggO9rAmj+/wVXlcSOUMhEQ+ezBUQ56rcwPcWD7VK
 I6SeSciOaer5UMHGq3Qdi1XdxH6feltgTpsUckwCOmow2Lc/DQmJDULSqFDO0lN8Vhhz6VJMMhw
 s2uS3NE/YjxAlbLEn2iTmtYh3Jq4Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On Sun, Sep 21, 2025 at 8:30=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Aug 28, 2025 at 02:56:15PM +0530, Souradeep Chowdhury wrote:
> > If an user stops and starts rproc by using the sysfs interface, then on
> > pm suspension the firmware fails to load as the request_firmware call
> > under adsp_load relies on usermodehelper process via firmware_fallback_=
sysfs
> > which gets frozen on pm suspension.
>
> How does it fail? Is the firmware load aborted? Does it time out while
> we're suspended?

Firmware load is aborted due to failure from usermodehelper_read_trylock().
It returns an error and there is no timeout.

>
> The usermodehelper is optional, adsp_load() doesn't rely on
> usermodehelper, it relies on the firmware class, which might perform
> usermodehelper.

yes in this usecase usermodehelper is being used.

>
> Please describe how and why it fail, so that help educate others (me
> included) about what the actual problem you're seeing is.

Sure, will include further details in next version.
>
> > Currently pm_awake calls are present
> > in the recovery path, add the same in start and stop path of rproc for
> > proper loading of the firmware in non-recovery path.
>
> I would expect/hope that the git log tells us that the pm_stay_awake()
> in the recovery path is there to prevent the system from being suspended
> while we're restarting the remotproc, as this is expected to lead to
> functional degradation and suboptimal low power state.

Yes,this was merged as a part of the following patch:
[PATCH] remoteproc: core: Prevent system suspend during remoteproc
recovery - Rishabh Bhatnagar

>
> "They call this function over there" is not sufficient motivation.
>
>
> But just to be clear, I'm not saying that this patch is wrong. I'm
> saying I don't understand your problem/motivation.

I have elaborated further, hope this clarifies the issue.

>
> >
> > Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicnc.com>
> > Signed-off-by: Souradeep Chowdhury <souradeep.chowdhury@oss.qualcomm.co=
m>
>
> This is both you, no need to carry both.

Ack
>
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> > Changes in v7
> >
> > *Justify this fix by adding more details in commit message
>
> Please start use b4, so we get proper links to old submissions here.

Ack
>
> Regards,
> Bjorn
>
> > Changes in v6
> >
> > *Add some correction to commit message
> >
> > Changes in v5
> >
> > *Added more details to commit description
> >
> > Changes in v4
> >
> > *Remove stability from mailing list
> > *Remove the extra tab in v3
> > *Change the commit description
> >
> >  drivers/remoteproc/remoteproc_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/=
remoteproc_core.c
> > index c2cf0d277729..5d6c4e694b4c 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1917,6 +1917,7 @@ int rproc_boot(struct rproc *rproc)
> >               return -EINVAL;
> >       }
> >
> > +     pm_stay_awake(rproc->dev.parent);
> >       dev =3D &rproc->dev;
> >
> >       ret =3D mutex_lock_interruptible(&rproc->lock);
> > @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
> >               atomic_dec(&rproc->power);
> >  unlock_mutex:
> >       mutex_unlock(&rproc->lock);
> > +     pm_relax(rproc->dev.parent);
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(rproc_boot);
> > @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
> >       struct device *dev =3D &rproc->dev;
> >       int ret =3D 0;
> >
> > +     pm_stay_awake(rproc->dev.parent);
> >       ret =3D mutex_lock_interruptible(&rproc->lock);
> >       if (ret) {
> >               dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, re=
t);
> > @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
> >       rproc->table_ptr =3D NULL;
> >  out:
> >       mutex_unlock(&rproc->lock);
> > +     pm_relax(rproc->dev.parent);
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(rproc_shutdown);
> > --
> > 2.34.1
> >

