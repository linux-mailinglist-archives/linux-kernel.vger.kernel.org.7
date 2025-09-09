Return-Path: <linux-kernel+bounces-807411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A0B4A408
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C676F3ACEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02777309DA5;
	Tue,  9 Sep 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZj7xuom"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064963081D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403678; cv=none; b=qk3IoII33MG0gDU7kYpUJcZ8XFsvYhYys1xgJIOrn3QXhBK/4uxNmXQZTeqPUeOAh/kRjWSXRZI7nA9QS/lcbMBT5IhBMsS3LSYBwoKVQCsZzU7cNpH7Gnu1UUa8MVga6Pub9NgTHr9fpmacJlGT8d1xibHfNiMzjBCZCqwd43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403678; c=relaxed/simple;
	bh=mCe2NoIOzspNZQbWGoTFtZVQKJ/SMRKgPfNPuArYuyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEg3EsZB8q5m93RMb5UW2O+/wjXtXxtvQYkAnT3kX1i3FgR2Gu11dp+2VsagkJJJc6G3yE675n/6vo/BegtI6GXmQOLuaT0E/JFmSG9vakkkyDQjQPU4JFAL1jISCVz6k+CjYwXI8EQV6R2FSAu7k7OXUAzsQmZP/l4zbH5dnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZj7xuom; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24602f6d8b6so10871755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403674; x=1758008474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCe2NoIOzspNZQbWGoTFtZVQKJ/SMRKgPfNPuArYuyI=;
        b=ZZj7xuomdY5IeWpJ1uc1BqXWesaaZvpUbT10Z6MXWZgLky1dL1LeVhJ0fuDpiD+nqj
         8v3937EXfWDw6YpaeeOAf9EtsCUPl+/TqCeFE6e8HW0Lo2irEsHZJww4XuhFCMOVrqJQ
         kPgwVAWtD1GGiVPZrxhI3cxI/8DeoKtRM6Mj55fBWZSiiFIrwVX5lCaZ8mW+s7A/MBGS
         +tUePsgVKbVdnSrCYTILsMKT3oJjvflJAfpdG3JgJLWl0exh9xkuhNB4iok+3+Vv2l6B
         5UJ78PG0b1OOmoUZmT1Lj+zy2JAqxkB00PYuaQ5qRP4mwa0eY2GMxg3ksqi5I0mTQSYC
         0l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403674; x=1758008474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCe2NoIOzspNZQbWGoTFtZVQKJ/SMRKgPfNPuArYuyI=;
        b=miTtNRWLHClUtPsRG75BRPrM94w56jkARtWDM9QUoD1ZzU6/dw9/8Z9sGqavKtXiFH
         U+7LrQ3jh0qDvZdnAMUJ0QN+dTgXI1KPq5qHcSikVIUOtxpNKuRwxZfxrEbX4rB2ykLF
         d9SSUvXouji7FjNl1FpaA+/s86ILUtVx0ItpCZWDJeDhLBtv/E8lvSornVukPtB8Czm/
         XpV2UAv5izXHB4IRi1n47HA7dWpYw7fx88F/TGShFqmqYBC1x8xNWG6kLJ3UkrCSPYJr
         zN5nvAMRgOcdp8layhvS4aXmpSjOXr8aJfNswTMMeM/UaBouUw6Z10ipynmUPLrv6Px3
         Xs/g==
X-Gm-Message-State: AOJu0YwhFjGXr4RGeQpL+x+y3IyioWwzvMAKl6PknoZwvC2CFCeIMYZq
	80oDSIEIgMzB0A/wEgoNdrkDbRgmmGHG62HZudJSiWcAr8eLdEYKlxzAr8dQN/f3bwQVdMPOdj3
	eOukst2L/mVxItU666YeBzR9zgQ+7Kyw=
X-Gm-Gg: ASbGncu6DSgrAH80ey+lToqcsH9faybqcAmwH3gFrFVsbqJbch2o/YSYBGl/skCVVVy
	V1turucx+hGgnF+zQkb//s6Y5EnnjKWIbfONWSUUL0PWYgMVkTWXgXnHmyrz9xJ8+dDzrk3SqSu
	7EtCYPlwXGknIa0nuYdu6AW8q+E8385BfKow8LQb1lWREdQMviQ8xMrmoB/HBdXgeZeUTwD48wI
	TPRYA+6QMYVWkI/rer/tonHgYzVfDSa/grwAMkLi26IKIB7yoGENcM60AJs/TI6DRDyotpmfkAI
	1p/3qLHcsrxEtK7tyXrIUQXVSSscU524DxVB
X-Google-Smtp-Source: AGHT+IEGuGdElEOpCf7auHQX/q0SITXnsP9j9+YEcmIcskucUh26FQ7it3p4kI06zfGAdQbHrxVvfGd/OS+fsYIlp9U=
X-Received: by 2002:a17:903:5c8:b0:252:e03d:476c with SMTP id
 d9443c01a7336-252e03d4954mr49541125ad.2.1757403674162; Tue, 09 Sep 2025
 00:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com>
 <CANiq72kJxwEncXVVrZoMyjXrtsJUGf+kamz0G+d2we7Fk1Vp6w@mail.gmail.com> <CAAofZF5JbC0=zKMXRDSGfbLaZ7y8Ems0x-5GEVADkHJyY3BkMg@mail.gmail.com>
In-Reply-To: <CAAofZF5JbC0=zKMXRDSGfbLaZ7y8Ems0x-5GEVADkHJyY3BkMg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 09:41:00 +0200
X-Gm-Features: AS18NWD-omM_asMFScQ6JIByC2XPzhEOLPIuAYb04r0LC5uWBf8o3Gkb3SziWaM
Message-ID: <CANiq72ky8snUu71Q-P+reuNtUtjUsa7pOjzFeiNMQ0kwk5P0jQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: replace use of system_unbound_wq and system_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:25=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Unfortunately I noticed I made some mistakes not updating the cover
> letter accordingly... sorry!

No worries! It was just a bit confusing :)

Thanks!

Cheers,
Miguel

