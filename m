Return-Path: <linux-kernel+bounces-748646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC8B14437
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C16016C2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4A212B2F;
	Mon, 28 Jul 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b="0yXUWkY4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F661F4606
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740501; cv=none; b=djTQFv0g73lkZjbaCmAE3TFvFQ6OMgUXJwFTZ/puE8FTPOBHsHw7pmtecsXFzD8LmzyTBxwVFOMTy/IL9cD7NHhQ8A8J2EovH2A8Y0my/6yhkvNnRKK3ccetI6vfExdj7Ln6ynfWiC0fLAIKB1jSMH8FfDssWqdBQ5VIqeUv1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740501; c=relaxed/simple;
	bh=yKXV6HTAv1BW9n64K03hbVaBzNxb2EgaomNQLwe4DUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJqYzBNEiCFKqXdM03R+W373UFKGLqqTbtq2tey6y8aFT7P19dZ16TETa8BGiGlilqpfUqD75oMMXw3V0LPV/lSAIHoJoZBGECiMG0/s3R3ZRBJIp1Opvv5hOVWzjRSqCllvBpdXm+OF/g6hUai+dVCWea/bhe7hXSjkAC1td/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws; spf=pass smtp.mailfrom=kowalczyk.ws; dkim=pass (2048-bit key) header.d=kowalczyk-ws.20230601.gappssmtp.com header.i=@kowalczyk-ws.20230601.gappssmtp.com header.b=0yXUWkY4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kowalczyk.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kowalczyk.ws
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so7630289a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kowalczyk-ws.20230601.gappssmtp.com; s=20230601; t=1753740496; x=1754345296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVZlePzGjkHlHhNr3txJWdkuHXKAOIv3uj0JeG3SlOk=;
        b=0yXUWkY4+HezKQIKnxkFiSasyCUdW0D5sXrfQOsL33YsOBlWmEh2uSFNWmzWv+jPSd
         LyE4wau2YUAX+PpCVk1A9Ev6kdMNVFCVvoM9QiydTsIMwJmXzsOzSeUx8uq/xB1i0a87
         ZSThPGasqGf7VAkzfo71yCyhMDXyLgVDSV4eoA1NxEH1Erzbqe5+pCBKgQQ5ykwj/bJP
         t8A82JooYqo98wMVDWhc0FjD0EeeXYVwO5ZqhsG9jWBSMWMcaRjK9LGsmNLkmgh3VuSw
         eT3D1VrlCBMSo8MK9Ab/eXkwy4hQgzNPDxWph6e8t7J+ZJAbL+b1SmLltPH2Ue+mdtRw
         0HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753740496; x=1754345296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVZlePzGjkHlHhNr3txJWdkuHXKAOIv3uj0JeG3SlOk=;
        b=EMtIDMJUvSZ2AAdTo3nfGLLYscJiwHRInbl+G942GaizmvHr12tEgwUl5hpS9EIMVz
         817XdJ4ojnlDYL+ggFGh31AoB2yq44P3uX6R3DpvFntawHM3b+ajSaNw5kIScb+WxOJQ
         53loVcIMXa4O+AGFUwUQ+solrvx1vwKZ1i/hp1fOZMcIHZLWniT7FjwMwQdClKVtKuW5
         ehAzUMM7U/v2u9WTCcgfSJVSv7VBQiQWCE2Y67JGK1lk6S/YEPlXZmczniXFUhna1lWr
         W0CYHKfE8+BtW4lErBfBeqh/8Dqaaf3/o49w7lQZJZYqV67L78vpm3W8Lrht6Q/snM0i
         68YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl2ajdm5tkV7QIrHVvuxbX9R0f3Z/u1vXrFq/KtG+eoIkk6bUKMJgNNDFRwxj4d/w7zKj8gqxqeQBxpTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSslljgf/2dosqBwGBJ5VJfeudKqIYPpALs97ObH5d6VBY2bJ
	Qc/Kbvfi03AMJ7IIQYyAIS2WQ0cJYlIQznA7NOpw5ylrah1GQiwKf4kDRPiYPeZtJDh6+RnWJDM
	l74fMNgQRf7l+EaWtA4fgauG3mC6V/oGTwHEAYeZS
X-Gm-Gg: ASbGncsfA+BqBqscVHQMgYo5AWvQ5GycXovsEmfWPcUIqkNa+ereP22Achyfb/JUFmp
	uEyEB2iOxpfd9upDnl8VQ6xsOYCPmtEInjirF62hpNAzGk2QKlVprNwgU7zjxdpe01NSxU98aOn
	OXqONBVX7D+LiNvjSQmdaJro0rv/nzTwOq4ktNskl2mux9GfM1/XOcYuF1rgKHXTdMLUrsCGMK5
	VDbYD8mBjdJi/k=
X-Google-Smtp-Source: AGHT+IF09mPBLrOHTEIB8WHhuFE3I3nCCAFLkKtWOTo/2h9D6SAx8Ni8uYSGEDjY0L/5w9XZjlAxtrdCm0GvAmW8byA=
X-Received: by 2002:a05:6402:2103:b0:60c:397d:d638 with SMTP id
 4fb4d7f45d1cf-614f1d4b520mr12115084a12.14.1753740496343; Mon, 28 Jul 2025
 15:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
 <20250728144424.208d58d5a95057ee7081ccd8@linux-foundation.org>
In-Reply-To: <20250728144424.208d58d5a95057ee7081ccd8@linux-foundation.org>
From: Patryk Kowalczyk <patryk@kowalczyk.ws>
Date: Tue, 29 Jul 2025 00:08:05 +0200
X-Gm-Features: Ac12FXx-SLKO8_1dJESpw0d0b6bu9iuRE34W3EgqURU7mQvBpXDzfaq2MkrIgX8
Message-ID: <CAJCW39+85dtfEjqNejB8xT=JCo2gU5XWY_ohb0OxYKs6G929jg@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com, 
	ville.syrjala@linux.intel.com, david@redhat.com, willy@infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com, 
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, 
	christian.koenig@amd.com, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I apologize for the second email; the first one contained HTML content
that was not accepted by the group.

In my tests, the performance drop ranges from a few percent up to 13%
in Unigine Superposition
under heavy memory usage on the CPU Core Ultra 155H with the Xe 128 EU GPU.
Other users have reported performance impact up to 30% on certain workloads=
.
Please find more  in the regressions reports:
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14645
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13845

I believe the change should be backported to all active kernel
branches after version 6.12.

best regards,
Patryk

pon., 28 lip 2025 o 23:44 Andrew Morton <akpm@linux-foundation.org> napisa=
=C5=82(a):
>
> On Mon, 28 Jul 2025 16:03:53 +0800 Baolin Wang <baolin.wang@linux.alibaba=
.com> wrote:
>
> > After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpf=
s"),
> > we extend the 'huge=3D' option to allow any sized large folios for tmpf=
s,
> > which means tmpfs will allow getting a highest order hint based on the =
size
> > of write() and fallocate() paths, and then will try each allowable larg=
e order.
> >
> > However, when the i915 driver allocates shmem memory, it doesn't provid=
e hint
> > information about the size of the large folio to be allocated, resultin=
g in
> > the inability to allocate PMD-sized shmem, which in turn affects GPU pe=
rformance.
> >
> > To fix this issue, add the 'end' information for shmem_read_folio_gfp()=
  to help
> > allocate PMD-sized large folios. Additionally, use the maximum allocati=
on chunk
> > (via mapping_max_folio_size()) to determine the size of the large folio=
s to
> > allocate in the i915 driver.
>
> What is the magnitude of the performance change?
>
> > Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> > Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> > Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
>
> This isn't a regression fix, is it?  acd7ccb284b8 adds a new feature
> and we have now found a flaw in it.
>
> Still, we could bend the rules a little bit and backport this, depends
> on how significant the runtime effect is.

