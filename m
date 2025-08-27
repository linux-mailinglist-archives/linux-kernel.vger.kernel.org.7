Return-Path: <linux-kernel+bounces-788205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C4EB38136
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162701BA4342
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FB2D8DA9;
	Wed, 27 Aug 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="AtZbAcQw"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8502BEFF2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294628; cv=none; b=GfX6A9yl7fh/E8k8f4bSDnZOgRg6Zu8nJLAyJPSO3ML1WwBx2GcB98bOaWQLqAUjwxXf1Q5iAKBa451y4hJIdNDD+5wjHLRiGLHKjvAvEmZfP8/PMws5zimJ87yP2CQMPr7QC0hjO/WKw0gFHAYyw3cwOFG88yOtEa/k5fLSffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294628; c=relaxed/simple;
	bh=GfndeEOwCnpCOK3QWCzVz+jGoFaf5I3pq8HSBnsv0uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADFpApKwG38gL90kcQBwDBlYNv6fOKN86RVnw7NtKTaMaYVG8Jkav6Q1VWweyuX3VvW9Ysfv2uFcj4R+OqHMJEliP+2bRjVujYUtYZWsaSqLIhuDrXBb89T2AWn9CMEAVfZJCe5fcn7q3KHGHHyhopVMGK45yGsqnXTeDblsGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=AtZbAcQw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e87061a6d5so708616485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756294625; x=1756899425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfndeEOwCnpCOK3QWCzVz+jGoFaf5I3pq8HSBnsv0uc=;
        b=AtZbAcQwipf68DNAKU/koo1OYHwfq2Xw5h8TSz+WWocCZjfXN7oUVhxr7kAE6f1ROM
         CS0ggh32Ha/cSMEbH1LpIr4atRKVVuKqpEBQMRFWr6lsbxbp3AkhuK0UviGm2x041Qu/
         RNkIZd14Z4oQtWbPq0iyvzaCQLNTsiIfvKkjT/8cV6g4o1CYqIvFjBHyur30E5vfqDgT
         zPa5moh3qeoXtjEsm6/FT3c1yQobnClH12mYjB5jExGyfhmImMVsWeoVHQ9+XO0Fa4BC
         SzeAPwC933BEpEXH8vFptog8x5AHKMJyVGlw0Rj3hz+tZccQ6pLs/2eNY0zRhAakJvh1
         UBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294625; x=1756899425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfndeEOwCnpCOK3QWCzVz+jGoFaf5I3pq8HSBnsv0uc=;
        b=HoKkg7nwxwf+awMqi9c4zIHIN/cOP8PejkCgIKDATYA7NISxE1uSFmnJtkoTSuDIU9
         G6kwwOcNm00gNBsIE7VGRFf31UVASLJ096B5pRtrKrgbH9NIXd/XSIs0+Ah+R807Akex
         EKESvozOhIeUaYBd8YyCNSjkzbgGYhyRwyvISWDZXy87OyRa2EoV8+StgIKqP7vEvcDi
         RNjeIDlHZqqb65UEpIvdbxs2k2RMVFukW0EPOOwxaVO5CJL76SncjD7TOdO71MUrXjFu
         kyxnnSJLhshaErFnHJIiHM3EcFo6N/jHKDdJllhQ0cbUeV4cgjvyJZjTBQBLbDv8T3W0
         +j6w==
X-Forwarded-Encrypted: i=1; AJvYcCUjJfihpYZtVque72jJUWSQpm854WmULGRAiTTStWp1nr5XQimXAzLs6n9bL7jMwwfYTcd0rJXqPMk7ZRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAQSrYO4ggvTGebWhrL4DCvJsY33C2Wm3t93bN7SFAO4/iiHk
	b8YyKpzBzLqWgxR0+npFeA8Xs/3dB5JCu6+TnUGpZRCp03mubMxA9+mvvAVLupKIG9tQmJEtpUQ
	CKTaAGoD1rrlf0PTdpC7stmBLm6/8sSzGy8x4NWQ1zQ==
X-Gm-Gg: ASbGnctkcd6R7oUUR33xdx1IGlEH4lccAcXJH2sdHul+T+g2CAm/tYnVvUejEzLVQwK
	UhAwJmfTMiZjPF/oBTvPmRF5LzD5qB2O4ozHQYKQxyqfugbX1CEkLGdahbbHl6WHMCUjAgBHMxM
	GMSDbHq/SBLDvUkaUweEHovJrZooLZ4pYmnkT1zWdblnpXklqWwBAIKmJMWVC3bm2eEAPVWdr4B
	8DXPhbnBqAF+Wty
X-Google-Smtp-Source: AGHT+IGm7iJLIIebL1+88laKEXRfjU4Dz7HmoTdOZAJey6UBB7j4fE3V3lw96EobEWDFpPJOKKiRUxKIM3arwj0EGNg=
X-Received: by 2002:a05:620a:3711:b0:7ee:4a7e:e9a3 with SMTP id
 af79cd13be357-7ee4a7eece9mr1477937485a.48.1756294625009; Wed, 27 Aug 2025
 04:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator> <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat> <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
 <20250827-enchanted-merciful-badger-d51816@houat>
In-Reply-To: <20250827-enchanted-merciful-badger-d51816@houat>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 27 Aug 2025 12:36:53 +0100
X-Gm-Features: Ac12FXzn6v9MHx6a6sqFNAPJ1q2fkI0xvp2gSmrt9F65w1ac40HF9ChdBRScx2U
Message-ID: <CAPj87rMDj-3ohEtXQYy25Rp0zNtZxQxS4Rmd-akgx9kkvB4Ysw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
To: Maxime Ripard <mripard@kernel.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, Marius Vlad <marius.vlad@collabora.com>, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, 
	tim.huang@amd.com, dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, 
	alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com, 
	chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com, Wayne.Lin@amd.com, 
	dominik.kaszewski@amd.com, alvin.lee2@amd.com, Aric.Cyr@amd.com, 
	Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
	dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, 
	linux@treblig.org, haoping.liu@amd.com, Relja.Vojvodic@amd.com, 
	Yihan.Zhu@amd.com, Samson.Tam@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, 27 Aug 2025 at 12:21, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Aug 27, 2025 at 11:39:25AM +0100, Daniel Stone wrote:
> > There are other reasons to have uAPI though ...
> >
> > One is because you really care about the colour properties, and you'd
> > rather have better fidelity than anything else, even if it means some
> > modes are unusable.
> >
> > Another is for situations which static quirks can't handle. If you
> > want to keep headroom on the link (either to free up bandwidth for
> > other uses), or you accidentally bought a super-long cable so have a
> > flaky link, you might well want to force it to use lower fidelity so
> > you can negotiate a lower link rate.
> >
> > I'm all for just dtrt automatically, but there are definitely reasons
> > to expose it to userspace regardless.
>
> Oh, yeah, definitely.
>
> But bringing the big guns and the requirements we have for those to
> address the point initially discussed by the gitlab issues seems like
> biting off more than they can chew.
>
> Even more so since whatever uapi we come up with would still depend on
> the EDIDs, and they would still be broken for these monitors.

Sounds like we're agreeing with each other then.

Shengyu's 'I want these broken panels to work' usecase is probably
best served with an EDID quirk, yeah.

The reason Marius is working on it is the reasons I said above though
- some for uses where we'd rather clearly fail out and push an error
to userspace than continue with visually-degraded output, and some for
uses where people have bought a too-long cable (or bought a too-short
one which is now at tension through a 180=C2=B0 bend) so we want to force
the lowest link rate possible, without dropping to a ridiculously low
resolution.

So I don't think these are in tension, and Marius should proceed with
his work (complete with the proper userspace to back it up), and
Shengyu should proceed with new in-kernel quirks, which will be
effective when the properties are set to auto, but hard overridden by
userspace if it decides otherwise.

How does that sound?

Cheers,
Daniel

