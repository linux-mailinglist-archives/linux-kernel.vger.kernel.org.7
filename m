Return-Path: <linux-kernel+bounces-790622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDBCB3AB04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D35164E023F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC888277CB2;
	Thu, 28 Aug 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYv8ov/P"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF3270568;
	Thu, 28 Aug 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409783; cv=none; b=L5RFr02qAM6w/qlV8Gs+a0fiWPPKBA7L0Ve0UB4MHpFrTBArXxKEiOB18gMnobJ8e09HuzIKiO1JstCjYlo0NSMR3BTSzXaxSw8JV40P5gs6HTTsL61Vo4CAW20ZXwLqfEHPOV00mcG4p7cANmj24fU3J+MWHbl+aGxmntny+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409783; c=relaxed/simple;
	bh=FPYnbt4z9PqW8+XCueL8f6hyeaxZluayQKz6AjJWREU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKKqfz3HYQvMkMGGvtl+6p5xcgfzEhkZjaM6GlqF+AVBlXUqv9hpzK1xe+kOHly+keDCIOzihzPosROygoVUeV3liHjBbT0VhsMu1xIpRIbCFS42oearoHVIDuYHy1B62BPPps7n335pLntUvNrgMGYDaIQlio/f3R7E+MujvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYv8ov/P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24602f6d8b6so2666445ad.1;
        Thu, 28 Aug 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756409780; x=1757014580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPYnbt4z9PqW8+XCueL8f6hyeaxZluayQKz6AjJWREU=;
        b=mYv8ov/PADjXvjt50W9sAxKjulxhZJ0tsDx4+N5TOsHnSLaJBy21VnFrv3OGIBvX59
         NdA+s0ccebpNxML4/5QzqBtd/RITvQWFXG1emUYnnzmp3ZvMHfPuEOlU3euSwXVOoAFu
         nyhAepLUTdFsQp7qMVpf/26fY6BqHwJbGVDrFwC5MFA20hN3meize3+3HA7lMVkPbjCa
         EacvfF2BInv8r38V+HjLNhNaKMIlo2E5ymICxuyeCIJ6UwsE8aouZZbZ3JK3Rdd/QsUj
         h78dt9VB0nD8S86GcRrdqAn78ptigncxfIIyIveB8/Pi9yGLk/VbdcPTxfHmAR0usOtf
         BKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756409780; x=1757014580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPYnbt4z9PqW8+XCueL8f6hyeaxZluayQKz6AjJWREU=;
        b=PV5725kxbHZZVMzPAcHYavpQPEgU4QJPikVamUbcI2WvyYiIoFLd+Nt5qelbDAcB/p
         phTPGmcZqajqSQEAUhpYaxk2Lq4x8dQjXxuc7dlZKod80v2TmDEflwdcopCNL4QHd9AW
         rtSxGzXp04Bi5nDdQi5L3lzP/QdHIDLuDGvtKMST9JEcBvt3EURevbc+TMfrHA1/jNb6
         qKdc0YoxcnHXSZ6g+s2sInu9wUgANrIxqgPhjBfdJROs20c7gyqooahpli0UotMmZTOa
         2c0z9ps9L8YwnJOzE8L8U7RRxY/bV62h2Xsvho0sEvhi79MZ63yFmHLZsn8ErHBWfW1S
         yqHw==
X-Forwarded-Encrypted: i=1; AJvYcCUPm97hxEBspj7aqjgpxg81/KAvNN5JLbDpcBhvU+f7tSwpKVO9VFEtNuvk7QxPl8zfTMf1/zypprwnLKU=@vger.kernel.org, AJvYcCWBFVJyEjbwdt3CovTNxP4LRCgI+KS5SvnYbV0dJAjTZWUN6j0n/xACrXcVlTbyXZ+bPiG+ond1Emq30LmmacU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzO2sezbkO2KScGX3VVkj1WnbgjCCNyfUypEL6PpRcbl7ce2Ij
	3KykFxrncZ0qVy44ayjgK812oZL1AJi6n0BDn2O3jSpi4MJWnNfzMFMDJRhznU3+YtbHhJCv9ea
	vt2+RUwaqOt/9/vjUzlyg1cWyEC33eAo=
X-Gm-Gg: ASbGnct/XmETJsJTyUJNBXBfc1Ls21C1m0IEJHNIyIymy+gFYbgsS4gnMQoV2q39VZZ
	D8oVUJM9XQa1Geo3O+gx2e6hLDlU8FyX5eAtF16hczgqFMjUDxUTMxDHmkI7cv0h+4lxKo4laY7
	c16a1bQBeV2GhJnfyUqRP4zkE+DM3Sn/J3fcSgPnUrtX/lkRJESDh2RpM7hwTckRG60/wyYuEek
	/DzL3vVwQmjYqehWJCAvB9Dz/IMQ7IB8+eqImnNxE/3pko6IOk3hIfBcR10XAKCJKP65zY5cOGo
	BKief1lg0hmevcYdch2sOCMTxQ==
X-Google-Smtp-Source: AGHT+IHfdoPvT3BCCGLuczSe9PPNY89s467ywbu87kEOVFUaRViMez0tWnQkPG3jel8d8TX57n3a2PCq5DJC/O1xUEM=
X-Received: by 2002:a17:902:da8b:b0:246:b41d:252e with SMTP id
 d9443c01a7336-246b42c6bbamr143309125ad.2.1756409780124; Thu, 28 Aug 2025
 12:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828160247.37492-1-ojeda@kernel.org> <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
 <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org> <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
In-Reply-To: <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 21:36:05 +0200
X-Gm-Features: Ac12FXw2hLVUgBSwSS2yfSEkQm89avb4BuFIG4x_TILvdztH4UADYAvwE3UX24Q
Message-ID: <CANiq72=6Ji97UW96V-VjjbRG=ouGeHA7QXpP2gBOJYFx=oJ19w@mail.gmail.com>
Subject: Re: gpu: nova-core: arm32 build errors
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> and a `DmaAddress`
> newtype, not just a typedef, could perhaps be nice anyway?

The one from your linked patch is not a newtype though, so I guess
there is a reason for that.

Cheers,
Miguel

