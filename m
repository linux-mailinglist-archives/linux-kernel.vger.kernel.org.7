Return-Path: <linux-kernel+bounces-866676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C241C006A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB94E2CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F767309DB5;
	Thu, 23 Oct 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Ij/DX9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C92EB86F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214497; cv=none; b=LGBY9fy8UtNfgXrReFhqsm+cUcZGlAMI0gpoRLUdcFtkKHfe/ZRQJC2p+W60GnpQXaHVg84HPn71Ip/t1GJZ/zaM8Zllk4121HLHaD9H+HGzgztXCFs33zqYmpEOTuw80HX/srKMrsf0uS35IM0UWZw4AFMCEDVXb6ZaJ2HHRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214497; c=relaxed/simple;
	bh=kCE2z4wkYGzvbLAc/K6W1fc+2osskFtUXN3TNkuq9e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsnNngXMpuGPGpMw/wTlvBHk/zlxFZCqabUi4ErQfRa5ykpnCmcy8fmKklQuR1o9e1PCPY+mcv3rHV65MuHqZoEZbrcxuJH3a7sq4enXjhU/wpXo65uSJ3BYnrpMPKeSw6QcgeA+QWn19xqSYM+yCwAqAZb/7y3gG+y5JCZX0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2Ij/DX9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso567725e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761214494; x=1761819294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCE2z4wkYGzvbLAc/K6W1fc+2osskFtUXN3TNkuq9e0=;
        b=A2Ij/DX9pc3vMKYKDrM0UOQCo9TnkaaAly3nCL35OXUe31sMdCHA7ex4/pbBxo2rMq
         bsZeXr1bwRwSnRieH3RcR6w+9/9YvE1AH2jwwxDGk0PWBVsrO5C7lK8CKqBp5zCprpTO
         2Ws6jkD0UAKFV6d7vLQF2VgjXYWgJ/y8r2aZ4FCcWQulT+Clyv+KETOvcVwIKgh9tcvX
         vYy5mZVZ5hpHMGI3NK/OyH6rNr5txdjgFK78y6ft0kBX5TXyeIux3X4wIyzgiNJ3zmLe
         aMm/31vk5NMjAxBlTTZvpDWCAKdPVK2vOlNlGEw/ceT9JKgOgXPHpJD5Yz1R5cMjJ+uk
         SIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214494; x=1761819294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCE2z4wkYGzvbLAc/K6W1fc+2osskFtUXN3TNkuq9e0=;
        b=dlTOVg/7tNM+NM3LeYLitqcgc8o4HbZkW4AOYIZF2SakL6J2Y74GhEMgMN1EVbCSDf
         13l+sFUVzoBL+mJmWn+iyI/uR0uKY7F6CxfxAK72VzEC5ru18jN3t36kb1jPBwWGkRhk
         QmvbC1onLCIuOVsBM6zPQz3my4pulXB6Kv5wj2XeJmw4QHTVY6NTISQXXSH5e4t4Ekvl
         ZxMbwCURylhL3XP+VBLnA3VM/BGPDdsf3u9N5AjaPsAc5E3jo8Aarpo7Ry3W+rox7GLg
         9Q+vrLy6ucN1OLtsdHGoQn/xOFleD8ShnGRIpdydEaGA3OZTYjnIZQX7HfC9ay1ZYonm
         1djg==
X-Forwarded-Encrypted: i=1; AJvYcCUdBWycqUGWiHSNwzlppytnXQXJ+co+P/cifzvXo8fuPWzMamWhykgFfbmh4r65Ojhps56Kn45FQh+o5rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxadhr64JiBnXuTMO5xiU1gtr/toyfOAKE1qP/kHTk03FknuJbL
	0itJB13Q62sNDYXNt9Wdr2z3uo1/a57XMXU6phKn25CMyao2GMTql3flf7vpvXG+L+pPMKUEmeG
	YC3d0CZbZN2dO4R0TpEEpjNokWiumHVM=
X-Gm-Gg: ASbGnctQ8ZPUGoKYhuvjzOvZw+N2Q07jkSfMuBaw9sSP/cCDrsw0XkijVePKYpDoYM8
	S/MmmZ843mwyu5NNJpTqvqFiKoMnt/nXf82ZPw2bCP9n85zSEX5CHUwEIyESMYrvYEHzUeMisYM
	n9ssg3BNapYuj6gAbYLsnRjyFgesyp3To+C0LEC6mnnqMUsLWqi7AMcHwFcSZNoVX5uVIAzPnH2
	yiwc3SfB0rV1mLcBt6NrqdQfu9vXL2cvErRDkIxJbykwkx1eV0JLYuXdctZSA==
X-Google-Smtp-Source: AGHT+IE78l4zjJijoLwVzewdgQkLJWS54jIN7RllyKzp4Mq+f0mmNw/Ii8gOTYnEGn18nRcwOV/Glk3RuLed1KICQ4Y=
X-Received: by 2002:a05:6512:b11:b0:55f:6adb:b867 with SMTP id
 2adb3069b0e04-591d859984bmr7477224e87.45.1761214493617; Thu, 23 Oct 2025
 03:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
 <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com> <CAA+WOBvVasy2wRP_wmP-R6Q8y5B4sN08jNYfHuDVjiWXV+m23Q@mail.gmail.com>
 <904ba70f-b1bf-4745-8e92-d27a6c903673@kernel.org> <CAPv6GL2DQ_wY=r4eV_V=nBGaj20HtYzRfJg==rQJtuO8Fo+HAg@mail.gmail.com>
In-Reply-To: <CAPv6GL2DQ_wY=r4eV_V=nBGaj20HtYzRfJg==rQJtuO8Fo+HAg@mail.gmail.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Thu, 23 Oct 2025 13:14:36 +0300
X-Gm-Features: AWmQ_bnwiEKbYnJwbZXRCmBHVtFK5pPcT6vg0cz54jq0PEpcBMa2utOihxE5H34
Message-ID: <CAA+WOBvfStqh+HTXYrrD_=YUXPYNaKLgHPLQ9g07gfQmAXKAWA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
To: Mary Guillemard <mary@mary.zone>
Cc: Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The other thing making me hesitant of depending on
nouveau_bo_fixup_align() is that VM_BIND is entirely client controlled
and there isn't really (at least as far as I understand) way for the
bo_fixup_align() path to have enough info to e.g. work around the
"client allocates size and binds to address not aligned to that size"
issue (likely the reason for hitting the mismatch case. this didn't
show in the older kernel versions because everything was forced to 4K
anyways).

On Thu, Oct 23, 2025 at 12:39=E2=80=AFAM Mary Guillemard <mary@mary.zone> w=
rote:
>
> On Wed, Oct 22, 2025 at 10:56=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >
> > On 10/22/25 12:16 PM, Mohamed Ahmed wrote:
> > > Pinging again re: review and also was asking if we can revert the
> > > select_page_shift() handling back to v1 behavior with a fall-back
> > > path, as it looks like there are some cases where
> > > nouveau_bo_fixup_align() isn't enough;
> > > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450#note_=
3159199.
> >
> > I don't think we should add a fallback for something that is expected t=
o be
> > sufficient.
> >
> > Instead we should figure out in which exact case the WARN_ON() was hit =
and why.
>
> The reason I wrote this code initially was to handle addresses
> provided by userspace that aren't aligned to the page size selected
> during BO creation.
> This is something I did trigger when typing this patch initially with
> my distro provided version of mesa (likely 25.0.x but it has been a
> while)
> Thomas Andersen also confirmed on nouveau irc channel that he did hit
> this case with an old version of NVK and this patchset.
>
> I think we could just remove the WARN_ON and properly document that
> this was previously allowed and is there for backward compatibility.
>
> Regards,
> Mary Guillemard

