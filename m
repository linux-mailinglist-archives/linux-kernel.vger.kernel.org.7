Return-Path: <linux-kernel+bounces-739539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B846B0C78B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FD166BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087762DC34A;
	Mon, 21 Jul 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGkz1TGc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3882D3745
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111594; cv=none; b=MuFVeO4fFPwIXka3ub2ZY0V5hqs5RPUhRX3IUZkaUDN8/lb3pjUkMn/0/IHGqzFYg9RjdPFUKpfui3z3VuMP0IuWrmF/356YdbObMUc09uZ2+5/LX/8xpJxJMPiAWiEIqTObHLCTrGoGiCi6rUeKQADuHsVFgWCKs/xzjjolewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111594; c=relaxed/simple;
	bh=V2zOpe0W1PErgnFJB7s4XF1g/T4nndP6y9n3glr899Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqeis4sa3EsWCa8X1R5rnBEfsPEpo3jy22RD0FGLLiivW9HKe/OOoBgszYh9joMoW+9MsZJuyzbdLlPz2RsGNxQv6IzcjMVRom2K8vatUGP4PllChNBZ+2KdzAU+f3J++YkGAcnOloGds55irImwCSRSlmSnCM8Cug12x8xFwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGkz1TGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAWEZo015737
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=MnOD77sB2Ik3kJ7rDMTC033zhiY3x1p8B9vcyupzsb8=; b=BG
	kz1TGcI4MFfbOe5H/VgBz4u5HbpHgshH6Xl1II8hXJUKWkg8HPL9JYwqbx2neLEG
	ljnqf/ncKlo91sx1F74m4BqX/xfV1tDeVhB9CpttO0w1skrxPCoTRlkYij3WEpvn
	bnJ0ZuKiiHt6QSfoxIfml17kM8nKkQhyiagixzuZ1lf93nLPb7haKctryk4kfbyK
	15DboDxgowALoAWR3aPMDt2JL8rQj1+iDdDwdGKntmJdHp1H0jI/kUwq669Ldcfz
	/Ewm0bToxyO6SYurW+BdrDKtW1QOQthRkp9PWeJwGEvs4/CB1gS44/VtTpKhFiR+
	TJS7KfYYfiPU9zu1sUrg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451dsuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:26:29 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4033c872b60so3320577b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111589; x=1753716389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnOD77sB2Ik3kJ7rDMTC033zhiY3x1p8B9vcyupzsb8=;
        b=qKln03+nohTF8tvLrPIb7TMJNGhH/UG59HgE/65MnAz6qN39XVoMKmYNmv8Q4wlZwH
         4zzbyZ1+VtqopyG/qSRMU8fe4y9kqw/UAYXwx7TBGkT1Km8hPWU2KIviSFA+Dv8JzwI5
         GoileaB8XXnB1Kzf/c0kwVCHxY6iNo81bkBdqplbwBB6fZhhA/wj95jDKj/TOclLOUku
         W1T2nfrg9S5zoA3gpoREC/8gGRl74n/ucTfstXChPlu/YBJDh8oUIEIfpbcMNt5OFulx
         z9HThJbae+Lj7MY7UzHGqr1d/vcPe3dxnGiU2cCsjL75ycJjZVFB5rGW48am9HW3wCHr
         LUGA==
X-Forwarded-Encrypted: i=1; AJvYcCWQcHaLcLPBoLZyzobwxDlPXKPTBcYvpRj4AGl6Ry2m9geypL25d8u9GtNe9HEFovtGpGPllyPGWy3MRTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53k8xkYY6oHkg8tDeXmQzHBVW5CPo2yG9DwUGQxIkzjVFa3cW
	bK68uRhHw9ze4KAQvrCvSEqb6CbGdpgqMl2XXL/vCJkCaDeli5Z/U4u/wLAnZ3XVOlTKYMKdvPI
	PXRdUL2np4gHR8k26IOtf23nQvw25B+Fs94dZxUfvnEoNUTAnsPWjAT/D/tWGsYS4uyg0xmXnQo
	Ry9CraSkD/LkSYitiuom7R/xx7kj8HadOje1u2c2RhB2srNAuqzdf2
X-Gm-Gg: ASbGncu6eWsPtEshlEhl6tKj4WJo3UWRNVwcbkVpg//8NzdTSHjhwrEae55Dg9woDeK
	vGPUDYnQRv9sxcoZr6Pm2yzSIlh7axdBYh3Zh8VUE84Sl4AiPAp3ZdvaLOgTiJdCfxKivYGvAYE
	DQDxzWaYb9wFv7iQ/jXoKjlbnc1H1cPruEQDldjj4fIjZHxtUL9u2K
X-Received: by 2002:a05:6808:3a15:b0:40a:533c:c9cb with SMTP id 5614622812f47-41d05654bcdmr14287436b6e.38.1753111588601;
        Mon, 21 Jul 2025 08:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXFzYPkALClywTu5mOqRfeWp2m4fp272DjkezOJQOXBIAzqRGxPfJR9UxsN521B6259dXufoQBJ1qY0x7OZog=
X-Received: by 2002:a05:6808:3a15:b0:40a:533c:c9cb with SMTP id
 5614622812f47-41d05654bcdmr14287392b6e.38.1753111588114; Mon, 21 Jul 2025
 08:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
 <20250718105407.32878-6-vignesh.raman@collabora.com> <7c6suvc6quwwxni2nsos65btzim2lbv7f2u6mz5qbupzpmpzgb@g46wg63ubr6l>
In-Reply-To: <7c6suvc6quwwxni2nsos65btzim2lbv7f2u6mz5qbupzpmpzgb@g46wg63ubr6l>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 08:26:17 -0700
X-Gm-Features: Ac12FXw4vMk5Whh0pLXxQUQeTvmf5_E4on_jddtIDBax9_-2BPFjBHHhqwcfDPI
Message-ID: <CACSVV03x0DZLmoc_0GjiL+qhYH2ei8nKzuPRCTa+h6+j1pbhbQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] drm/ci: uprev IGT
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, daniels@collabora.com,
        helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
        robdclark@gmail.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
        lumag@kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e5c25 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=kxiJzIYbFHhRTRM7nIQA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: bIGtqwCTsUWkBXG0ZUMA0x3TpqBRC29P
X-Proofpoint-GUID: bIGtqwCTsUWkBXG0ZUMA0x3TpqBRC29P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfXwQHrbto7msyW
 ZoAYA+Z+EJ0fxT6QTlC0/h0CVVGKWigfZ+u6Oqwz3ojOfGZfNBPtHWAWgvCYNT7tR34ZKsVsP2V
 b2XgK/C2BFDOrcsPa5OFk09n7gBsHjqJ7YeowjVSztsuAzr3scSj2UVfJnKThtWUIkfwkMArW0W
 o/i/4Fv/Ld3OXHrc0VvaOkDtdrLrqg1Y+gi4hkbBLlkC/NJUpjBTvVMXdizeE+N4xyunP2ltGz5
 sjeDNxRwWLhsLmooDI5HMuJZJ8wLFhKeJ96keZhe9E/uL9WiZnLOD/23V1L8hvdQrNj87uZfzJ1
 3cxifkqDfDyNZerQvlKXoi3waWGP3Yh4v9P/clPaj8I03+Y2lAuwjANffwErWXGCK3qiXI3OfCu
 b9pVSvyyoP5ip0XuwPhqHuMm8zZVgVzKRR5GKvPMklfBl77KKi6udp9NE28wYyOrYSmZuIyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210137

On Fri, Jul 18, 2025 at 5:54=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Fri, Jul 18, 2025 at 04:23:57PM +0530, Vignesh Raman wrote:
> > Uprev IGT to the latest version and update expectation files.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >  drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
> >  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   2 +
> >  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |   7 ++
> >  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  11 +-
> >  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   2 +
> >  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  29 +----
> >  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   7 ++
> >  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   8 +-
> >  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |  83 ++++++++++++
> >  drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt  |  10 +-
> >  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   3 +
> >  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   5 +-
> >  drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt |   6 +
> >  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   7 +-
> >  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   5 +-
> >  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  | 119 ++++++++++++++++++
> >  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   7 +-
> >  .../msm-sc7180-trogdor-kingoftown-fails.txt   |   1 +
> >  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   1 +
> >  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |   1 +
> >  .../drm/ci/xfails/msm-sm8350-hdk-skips.txt    |  73 +++++++++++
> >  .../drm/ci/xfails/panfrost-mt8183-fails.txt   |   1 +
> >  .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   1 +
> >  .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   1 +
> >  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  12 +-
> >  .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  21 ++++
> >  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   9 +-
> >  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  35 ++++++
> >  .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   4 +
> >  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   3 +
> >  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |   3 +
> >  31 files changed, 416 insertions(+), 63 deletions(-)
> >  create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
> >
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fa=
ils.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > index e4a8f8352cd6..9bf38c077f8e 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> > @@ -15,3 +15,4 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> >  kms_plane_alpha_blend@alpha-7efc,Fail
> >  kms_plane_alpha_blend@coverage-7efc,Fail
> >  kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> > +core_setmaster@master-drop-set-user,Fail
>
> Could you please point out the issue / failure log?
>
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozee=
n-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-f=
ails.txt
> > index e4a8f8352cd6..7441b363efae 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails=
.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails=
.txt
> > @@ -1,3 +1,4 @@
> > +core_setmaster@master-drop-set-user,Fail
> >  kms_color@ctm-0-25,Fail
> >  kms_color@ctm-0-50,Fail
> >  kms_color@ctm-0-75,Fail
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt b/drive=
rs/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > index 8d26b23133aa..f387c73193c6 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> > @@ -1,3 +1,4 @@
> > +core_setmaster@master-drop-set-user,Fail
> >  kms_3d,Fail
> >  kms_cursor_legacy@forked-bo,Fail
> >  kms_cursor_legacy@forked-move,Fail
> > diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt b/drive=
rs/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > index 9450f2a002fd..84ffbe0981ea 100644
> > --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > +++ b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> > @@ -210,3 +210,76 @@ msm/msm_mapping@ring
> >  # [  229.752499] CPU features: 0x18,00000017,00200928,4200720b
> >  # [  229.758095] Memory Limit: none
> >  # [  229.761291] ---[ end Kernel panic - not syncing: softlockup: hung=
 tasks ]---
> > +
> > +msm/msm_recovery@gpu-fault
>
> Hmm. I thought this should have been fixed...

There is another fix which came out of stress testing the kernel uprev
in mesa-ci:

https://lore.kernel.org/all/20250718-msm-gmu-fault-wait-v1-1-4dcadd3b0eb6@g=
mail.com/

BR,
-R

>
> > +# DEBUG - Begin test msm/msm_recovery@gpu-fault
> > +# [  153.288652] [IGT] msm_recovery: executing
> > +# [  153.295317] [IGT] msm_recovery: starting subtest gpu-fault
> > +# [  153.317588] adreno 3d00000.gpu: CP | opcode error | possible opco=
de=3D0xDEADDEAD
> > +# [  153.367412] adreno 3d00000.gpu: [drm:a6xx_irq] *ERROR* gpu fault =
ring 0 fence 814 status 00800005 rb 016b/0215 ib1 000000010000B000/0000 ib2=
 0000000000000000/0000
> > +# [  153.383449] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: hangcheck recover!
> > +# [  153.393296] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: offending task: msm_recovery (/igt/libexec/igt-gpu-too=
ls/msm/msm_recovery --run-subtest gpu-fault)
> > +# [  153.436085] revision: 660 (6.6.0.1)
> > +# [  153.439702] rb 0: fence:    2063/2068
> > +# [  153.443659] rptr:     360
> > +# [  153.446389] rb wptr:  533
> > +# [  153.449103] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
0: 0
> > +# [  153.455746] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
1: 0
> > +# [  153.462387] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
2: 2062
> > +# [  153.469293] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
3: 0
> > +# [  153.475680] adreno 3d00000.gpu: [drm:a6xx_irq] *ERROR* gpu fault =
ring 0 fence 814 status 00800005 rb 016b/0215 ib1 000000010000B000/0000 ib2=
 0000000000000000/0000
> > +# [  153.475919] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
4: 0
> > +# [  153.475925] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
5: 0
> > +# [  153.475928] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
6: 0
> > +# [  153.475930] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
7: 1
> > +# [  153.529587] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  153.539837] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: hangcheck recover!
> > +# [  153.549597] msm_dpu ae01000.display-controller: [drm:recover_work=
er] *ERROR* 6.6.0.1: offending task: msm_recovery (/igt/libexec/igt-gpu-too=
ls/msm/msm_recovery --run-subtest gpu-fault)
> > +# [  153.566489] revision: 660 (6.6.0.1)
> > +# [  153.570099] rb 0: fence:    2064/2068
> > +# [  153.573878] rptr:     0
> > +# [  153.576411] rb wptr:  688
> > +# [  153.579134] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
0: 0
> > +# [  153.585775] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
1: 0
> > +# [  153.592410] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
2: 0
> > +# [  153.597308] [IGT] msm_recovery: finished subtest gpu-fault, FAIL
> > +# [  153.599039] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
3: 0
> > +# [  153.611856] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
4: 0
> > +# [  153.618498] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
5: 0
> > +# [  153.625132] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
6: 0
> > +# [  153.631766] adreno 3d00000.gpu: [drm:a6xx_recover] CP_SCRATCH_REG=
7: 0
> > +# [  153.639162] *** gpu fault: ttbr0=3D00000001042fc000 iova=3D000000=
0000000000 dir=3DREAD type=3DTRANSLATION source=3DCP (0,0,0,0)
> > +# [  153.648502] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  153.650144] *** gpu fault: ttbr0=3D00000001042fc000 iova=3D000000=
0000000020 dir=3DREAD type=3DTRANSLATION source=3DCP (0,0,0,0)
> > +# [  153.650241] adreno 3d00000.gpu: CP illegal instruction error
> > +# [  153.671006] platform 3d6a000.gmu: [drm:a6xx_rpmh_start] *ERROR* U=
nable to power on the GPU RSC
> > +# [  153.687278] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob] *ERROR* =
Timeout waiting for GMU OOB set GPU_SET: 0x0
> > +# [  363.495437] INFO: task msm_recovery:876 blocked for more than 120=
 seconds.
> > +# [  363.503070]       Not tainted 6.16.0-rc2-g0594d0b01a7c #1
> > +# [  363.508838] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" di=
sables this message.
> > +# [  363.517142] task:msm_recovery    state:D stack:0     pid:876   tg=
id:876   ppid:274    task_flags:0x400100 flags:0x00000009
> > +# [  363.528876] Call trace:
> > +# [  363.531554]  __switch_to+0xf8/0x1a8 (T)
> > +# [  363.535703]  __schedule+0x418/0xee0
> > +# [  363.539486]  schedule+0x4c/0x164
> > +# [  363.542986]  schedule_timeout+0x11c/0x128
> > +# [  363.547281]  dma_fence_default_wait+0x13c/0x234
> > +# [  363.552123]  dma_fence_wait_timeout+0x160/0x45c
> > +# [  363.556947]  dma_resv_wait_timeout+0x70/0x11c
> > +# [  363.561582]  msm_gem_close+0xac/0xe4
> > +# [  363.565405]  drm_gem_handle_delete+0x74/0xe8
> > +# [  363.569951]  drm_gem_close_ioctl+0x38/0x44
> > +# [  363.574297]  drm_ioctl_kernel+0xc4/0x134
> > +# [  363.578442]  drm_ioctl+0x224/0x4f0
> > +# [  363.582050]  __arm64_sys_ioctl+0xac/0x104
> > +# [  363.586292]  invoke_syscall+0x48/0x110
> > +# [  363.590254]  el0_svc_common.constprop.0+0x40/0xe0
> > +# [  363.595197]  do_el0_svc+0x1c/0x28
> > +# [  363.598705]  el0_svc+0x4c/0x158
> > +# [  363.602035]  el0t_64_sync_handler+0x10c/0x138
> > +# [  363.606601]  el0t_64_sync+0x198/0x19c
> > +# [  363.610465] Showing all locks held in the system:
> > +# [  363.620406]  #0: ffff0000840200a0 (&tty->ldisc_sem){++++}-{0:0}, =
at: ldsem_down_read+0x18/0x24
> > +# [  363.629412]  #1: ffff800080d7c2f0 (&ldata->atomic_read_lock){+.+.=
}-{4:4}, at: n_tty_read+0x15c/0x57c
> > +# [  363.643169]  #0: ffffbd9c0475d920 (rcu_read_lock){....}-{1:3}, at=
: debug_show_all_locks+0x18/0x1c0
> > +# [  363.654158] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> --
> With best wishes
> Dmitry

