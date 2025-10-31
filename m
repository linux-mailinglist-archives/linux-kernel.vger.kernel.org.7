Return-Path: <linux-kernel+bounces-879318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D586CC22D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894643A5AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FF20A5EA;
	Fri, 31 Oct 2025 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b="ElCFkYEk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A1A9FA0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871969; cv=none; b=JXtKtPJz51FtCDFzhcqNNJ7E/kQBrNe6YdDLtaG52XrliDUiPQCy2CZIP/HmJ0gKamvRfDXaFe7+OLQ1Jc2bbuaL3jrjNVJeSQwB4BnKMe/hZEiVJrzepeubKOjKDcEy3phEoNbIkZTe3OS82JruVyT7vUDbMrl0X3otKILaLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871969; c=relaxed/simple;
	bh=SBGuCSqkpGwJjxei1YoM4sQr4LyzW3ZZsg7tLfs8uCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N92V538DvnJkZ78/DtP6iKGEx3yGwF6DnJfMSbffBG1KRwmMwTYZJA7TBZMqrS0PxHnvrEfeFLH0UddyGiKfOQytOBXRVcgFAWxJAzJfyvNub+/AIbp++RMm2I+U7XuSofgMhSf0mz059GpkYN8ci0R9XuX2BsvHQ6niJjODseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com; spf=none smtp.mailfrom=darkrefraction.com; dkim=pass (2048-bit key) header.d=darkrefraction-com.20230601.gappssmtp.com header.i=@darkrefraction-com.20230601.gappssmtp.com header.b=ElCFkYEk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkrefraction.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=darkrefraction.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso3449026a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkrefraction-com.20230601.gappssmtp.com; s=20230601; t=1761871966; x=1762476766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEQ18anQMYI+7tHFQ9c7MoTWULdEXT6+PJ++e+/5Yis=;
        b=ElCFkYEk29md+5NzL6mMNI/b3aOjeQq49ij9szpOYXgP9dK5emKUfCPV31ijNdFihA
         25AHP7Zeykfff78qg0Xw54ssuegs7gVMaHKmvzYgcnqioFGOiJAUyY3yuWrRCN3obJ8T
         EglC9qUjn2HrCqCLnEPl/d5wGrLzJ5UIxQ6W0piW6q4KqKoqfd2Sm8JxM6gsCyBjgZ1M
         /g+2dR5CG42gFf5dfdjCkTQbFbS8GyI+WFVfOODV7oh/3kJjukUflucb1zQFuaABedr+
         P7oFJ01WXYQlwMf/cfpo16Vqh0UFpWLTFBhGZwMVBRLgTb/UTxpzX9FzjQtBnk36+Ouc
         O4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761871966; x=1762476766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEQ18anQMYI+7tHFQ9c7MoTWULdEXT6+PJ++e+/5Yis=;
        b=NMdBaOs7pcBnt4F8oVFd7CyQSclRFhB3DJHZrLexmcULbnVPqKzOzlBvwcGXk3qzIy
         m81CrvuoSuQOxLysI1Ng8ocjef/pnN0cgAveOVH7sPkQuPZ2gHmzFTnWeEKF6UnsaEiK
         NVvEBdsWoGHbwcfsOs/kCrRVg1O7JizmAsc1ljO8FcbnLgD2NtweXvj5yUgjPmUA9CeZ
         MfQ1G+fVjsg5muRvwvMYpXm9A54nPed0GNBu/VLgw+XX37O0mPnqDVJPU2MT9Wm5/Ck7
         PIE55pcWGJtiNAOtIU6WVUD/v36gY7tBKzg8QKo7KWTkAt6x6VFmamwOdWwDir4n6z9a
         IYLQ==
X-Gm-Message-State: AOJu0YyOUNq07cBIBXYGmfN3U+39/ZtNUlTl3tOvgL4/2cI8fRZg4X9H
	Eofd7Koort/w/5JLM51bcbKyaqwAtGAVP7HRDcdJHxT4LGnPjm1DPJ/qNStCfKC0ActwDP1q1qe
	HamkRdBe2ITum/UXlNWLJvcL18y6F+kYtDl2suV0y6w==
X-Gm-Gg: ASbGncsI+XnzsSnrGyKpjEgrZU9JV1VXis5q65Kg+f1G6aynORdTB5Fl/V67zxw6upp
	bGBHisDYWY8pZethVU3+uws1qhCAOUTuzeliep30G508cKWSNQHxv0+ddsCO3ZWDStxy6EOBbYz
	fjvzNMOyMo0s7TeLf3MmVxCP5dUHV+te3UKYpIjy27g/Pw18NTOS0d5IW1ZdBuAKdEiuun4+AIO
	PYmJ2v1TXHq93laiwTcMvT2q6f3+uzzLTt9A/mdCMOUyOzlySj6+2PtsTbQ
X-Google-Smtp-Source: AGHT+IH2SGUq2JivC0VwG4m1roqAWpSLfoI246C8KIQXIlrqoVKC3sTa2sFKJ2ZdL8ZfCzcdbIrSayRHAHYKBw+6C5s=
X-Received: by 2002:a05:6402:4315:b0:63e:142e:4b18 with SMTP id
 4fb4d7f45d1cf-64076f6beeamr1270481a12.7.1761871965943; Thu, 30 Oct 2025
 17:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com> <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Thu, 30 Oct 2025 20:52:19 -0400
X-Gm-Features: AWmQ_bnsMkSJn0hwatI9MRI7jNKarfabhU-buAXAiUf2EvCIPzigfImDg_Tk7nc
Message-ID: <CAAgWFh02dw=omW-yiBqZ8S7Q2ka79=5eNicXVhBb7Zz_fEB81g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Mary Guillemard <mary@mary.zone>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:04=E2=80=AFPM Mohamed Ahmed
<mohamedahmedegypt2001@gmail.com> wrote:
> +static bool
> +op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_=
shift)
> +{
> +       u64 non_page_bits =3D (1ULL << page_shift) - 1;
> +
> +       return op->va.addr & non_page_bits =3D=3D 0 &&
> +              op->va.range & non_page_bits =3D=3D 0 &&
> +              op->gem.offset & non_page_bits =3D=3D 0;
> +}

As discussed on irc/discord, this is buggy because it needs more
parenthesis =F0=9F=A4=A6=E2=80=8D=E2=99=80=EF=B8=8F

