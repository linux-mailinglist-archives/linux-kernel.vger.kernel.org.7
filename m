Return-Path: <linux-kernel+bounces-734417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2519B08154
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E341C266C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACCCA52;
	Thu, 17 Jul 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a66QHb6Z"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9479C0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711220; cv=none; b=gmBBqgJiw3qiPvuZ08O2KcA+/ovGsKy/qYd4flVpr/6Y8GyceuswuHPRza9XxLi+J5dIVXktOfLu8gUGTp9jOm8FP51/YRoym70YfGsOZKtytcakRbCpPqLLDy26n0JT64kkojzdQYEKpyoJw7E7pYI4LcNYG+f8JVKLCcMxDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711220; c=relaxed/simple;
	bh=7aZhtZfX0RsQUD9sVp1DVDvTSMi4jS6IZUpzUCsZyeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4sWxlQDLQAnA0VGcUbrjkxi3a4O15idzuE9iITAld+EJ/a/cUmkYiWRt44WAb6TXChGgQK1tjbukz8gYz+H9hY6N5B7ppbejRhoq3t58mMs7ZR3KLFFvla4N6MiLw2eAgsXpe9sgopH0Kc6zgg4+zkhvudUU5G+JIi8Cjin7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a66QHb6Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235e389599fso52335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752711216; x=1753316016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxwcBRFZJ/IWYAmgYMBlaC5GLM/oN1cP6KDw+nUVd+c=;
        b=a66QHb6ZX2Cn4S2VMXMK3zO2EzBiaokXyrfvRXS36EaK9E0+JZhMX0iq2NYzauW+27
         xzRmACiz+Th8CCAgcWhbCB3+hZHOHYHtVFIcwuDUR8Y8uM2kQ19lCdxL5iuc5tPTDqIY
         IQJYG6Z+fqnfqnUD8mENBL8TQia+O2RnrpaMnhL29+Jy9IxogdBtgewho/71IMEhXsC6
         I0YjvgE07TQkcZl/cnhk1subQWtEKrlPSC7+L3s6R2tC1JXKrbIONBx1dR+8MUSWK2Xg
         /QO2Wrp/Z971BQo0d+gmQfdWThfA1WxL1Jsu/RH64i6Wn+Yam/7CVoyS0kQFnUP3b51n
         QD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752711216; x=1753316016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxwcBRFZJ/IWYAmgYMBlaC5GLM/oN1cP6KDw+nUVd+c=;
        b=wgK2uTqO1b+P+vkOjvvdHWqqRS59uxlARKnzifiaqtmqvOLCE4BNEMgLghwzpO1Nir
         VHV6ufywYU7+RWKWZsFHALg0nR3OYxYy+ow0o56k4C1pPzTKwkgIjbVxYBtswU9EuYGb
         jGMpCrTC4vL5VWJDGHDxxfXWVX644ExY09EVwjBaXw5Hdr6MgzGvYf4xxA8YbFuX8Gcp
         bdtaDeA7SxjpwzR7r92PiQMNL6Zckxs368RkMaiIGxWTwbALW/mwk2u29a2B9c7aEc1v
         IfkDA41Aqg+aobQ5MNOKQXmBQ0BmwkGbb8E5ckNvtBR2cOOsDV4Usul+l6ZCFvmED+nU
         l4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXnj7BALcyaBwb4fagELMtnKCWgaK1StG/yRgnPSA9wSSBeQa4bMMHfzp3Zm7/BR1+o/hOx12XugB0LEyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTkXk+NLQlOUSD3GzgC32DBdzxIVlyweMQ8LuCedNmOdy+hKb
	7p1vIoG+oWCPCc9ev+QVpW0IbX/OY3+XKU2de5LdncEegBzDIatcQSsEF8vH+cH+JzcjK7FndRg
	2U7XSw5xiJ95EyY+/dSu5xYDdqpAUpb2jALTeVA7B
X-Gm-Gg: ASbGncuTGsMZifPEsHcEuRnpFG99cYAtmCRdUCUNgtUSnVJNAeOz7htEAC/dfGuJ/zl
	rfBIG5SN04vf2BoW1sTQQD5FktK7eS4prfpfQ5nQ/I+69kVZj2Wh1SzoJtIpc79DtwrEsh62igc
	JnBnpZJgcQipUoWeJKOjAyQuEkNTxkh6FMV4xfmiDVGeYbA9e44OL92/KvA34KHQ2M54z7CnsF9
	NFI+A==
X-Google-Smtp-Source: AGHT+IExZ6YQpVxQMTJs5x1bFUTqRcgLAU1GhDN/RUviVrMpTxpuEVJRR17jv0s7D2xBNTbduIancHz0YHYlnDWvA9k=
X-Received: by 2002:a17:902:f548:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-23e2fda6d9fmr1332865ad.8.1752711215586; Wed, 16 Jul 2025
 17:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com> <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com> <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
In-Reply-To: <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 16 Jul 2025 20:12:59 -0400
X-Gm-Features: Ac12FXw4FWxTyOpiBAh39vdC9AS1nFe7p6dT3CD8-f9rngBIdz8mZXayZeabz6s
Message-ID: <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google=
.com> wrote:
> > > >
> > > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexibl=
e (v2)")
> > > > allowed for newer ASICs to mix GTT and VRAM, this change also noted=
 that
> > > > some older boards, such as Stoney and Carrizo do not support this.
> > > > It appears that at least one additional ASIC does not support this =
which
> > > > is Raven.
> > > >
> > > > We observed this issue when migrating a device from a 5.4 to 6.6 ke=
rnel
> > > > and have confirmed that Raven also needs to be excluded from mixing=
 GTT
> > > > and VRAM.
> > >
> > > Can you elaborate a bit on what the problem is?  For carrizo and
> > > stoney this is a hardware limitation (all display buffers need to be
> > > in GTT or VRAM, but not both).  Raven and newer don't have this
> > > limitation and we tested raven pretty extensively at the time.
> >
> > Thanks for taking the time to look. We have automated testing and a
> > few igt gpu tools tests failed and after debugging we found that
> > commit 81d0bcf99009 is what introduced the failures on this hardware
> > on 6.1+ kernels. The specific tests that fail are kms_async_flips and
> > kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
> > VRAM buffers resolves the issue.
>
> + Harry and Leo
>
> This sounds like the memory placement issue we discussed last week.
> In that case, the issue is related to where the buffer ends up when we
> try to do an async flip.  In that case, we can't do an async flip
> without a full modeset if the buffers locations are different than the
> last modeset because we need to update more than just the buffer base
> addresses.  This change works around that limitation by always forcing
> display buffers into VRAM or GTT.  Adding raven to this case may fix
> those tests but will make the overall experience worse because we'll
> end up effectively not being able to not fully utilize both gtt and
> vram for display which would reintroduce all of the problems fixed by
> 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)").

Thanks Alex, the thing is, we only observe this on Raven boards, why
would Raven only be impacted by this? It would seem that all devices
would have this issue, no? Also, I'm not familiar with how
kms_plane_alpha_blend works, but does this also support that test
failing as the cause?

Thanks again,
Brian

>
> Alex
>
> >
> > Brian
> >
> > >
> > >
> > > Alex
> > >
> > > >
> > > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexibl=
e (v2)")
> > > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: stable@vger.kernel.org # 6.1+
> > > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_object.c
> > > > index 73403744331a..5d7f13e25b7c 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struc=
t amdgpu_device *adev,
> > > >                                             uint32_t domain)
> > > >  {
> > > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOM=
AIN_GTT)) &&
> > > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_t=
ype =3D=3D CHIP_STONEY))) {
> > > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_t=
ype =3D=3D CHIP_STONEY) ||
> > > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHO=
LD)
> > > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > > --
> > > > 2.50.0.727.gbf7dc18ff4-goog
> > > >

