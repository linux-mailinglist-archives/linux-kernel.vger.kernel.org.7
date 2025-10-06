Return-Path: <linux-kernel+bounces-843227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCCBBBEAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C379C4EEF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250902DCF57;
	Mon,  6 Oct 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehrut/i4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8B1E98F3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768835; cv=none; b=NiT4KEG3gdivr3uFUtez0MEFGCZMS6IoxRoJQI1nLALzx89AyQuq1BQxH+zPOnMM0lSD0PJ9aG32Vo7jpsrsPvaOHM05stYTma7gSnVqoK0JT60uyiBmMQWOCQGra8UnE+dTvpEihbYxVnRtfiJTklWhxq4siCEGfDnHDFBJChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768835; c=relaxed/simple;
	bh=veOdlZZAnBK5isc9zicCFKD4YiH6nvr7JBqv75sEnMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIacGaA53COWHoTnrsKD0t+D4FwU8OnetXZXyfYtseW7guKAlFA9npClKXzOuXGqCqQjmIdjrVfUQueW2C1dcaB9WSZyyH6XO9yu06RnuhYh4JO/HQdKJjHz6Q0boW1fUT/O8pFg5LUAFW6jlr4gIc+ZiSOZ/16VcxdnFV8FwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehrut/i4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269640c2d4bso7965525ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759768833; x=1760373633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBA6fOaVmQat7EDMxIX5UPGSZ7U9w/6YSIQNIRnUw64=;
        b=Ehrut/i4r0bRwkjvO2cwH6tEuMQlvICJIDsNdYaEuXwWbYUQWgllbaEQsL+7BggVYV
         PIKf9aiE027/2JEyjtcb9v7kHACYzf0QYfrMaRMkBEeSoz0yYMB6z0JdnBRXgVWY0r2g
         SIAs7B/IdIQInY8h8yOwX2UNvMwDlZ+EfRTi078xAILFJ0I96x93DNpFSn5vN3NRNpQC
         zr3ilO4A5ThUCyJEiB8XH+K0+7YSc5FaT3IWdDcpcrpXSnmCfqKvPP3oWI8df1H+tLU8
         JeyutHRKKiZjxsuVRaEcoU2FaL+prMXYoeEPYC9FqjnLPkijYmPXx5GoAS7uvRZBZk0b
         xxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768833; x=1760373633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBA6fOaVmQat7EDMxIX5UPGSZ7U9w/6YSIQNIRnUw64=;
        b=iC6UEuZjMmDAYTnUu01SkzX3iVyTPpAe2vwagRV9DgHnJmH+YLMn6skzR3t0mSiO14
         ziDDm5wLG6oxDshaeMl95aHgj90F1EjubkBvXPsfBaIegD5A5VPklIa6H1zxIO7Fm5TC
         4B+GABfSj97/ZzPDCfuLrg3hu2ZEZMIF/BnhvxawDdV5qp7kORfROy925llf4RZ0UJio
         onzmvMnKYJP2x48fmKc7XMLo52vDzSDBzQWuUFnJ4rPLfaSpOeU+oBZLXOyWL4V/kwgs
         EoGTcrdgcyXrCRFDzGMVgjv86Ptz1Ye//i/DCNc/ZG6bamXgaHU3zErYMr5m8dRL1IpI
         CfDg==
X-Forwarded-Encrypted: i=1; AJvYcCUYfq3pWBdv5rR7UjYxuo2F4uvV2sW4lG8b46IAEJIQY31w+JGQY3AuRqB6YCK9wG3VOxn05FzpAIo0bfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4N5a1JjOR7o6KaE1zokVegUia+xqDHVtQe2K79HB6QGZVBbC
	Gcw1I2AOUJ2qWK7dz9RN7JgLO/YZ5K7AxOJjMRNNYjxuTsC+vVP/CZE8JHKa1fK1AymkcqqKl9f
	zOmEGLI/7j8RRb03TtDj8QrXogZIvViM=
X-Gm-Gg: ASbGncs30s0TofJpr/ZuLinBSk6LloGhaHbrVBqU6iQMYW9DgILCzSKAcBuOon/HGef
	/HOenzfQvSywZ40nxauwsUyQGuRy+j5TdQ/vqlCx9Zl7X1lPgIzucINE/vDJMKeukMolSBoMb89
	6vmPyVDa8L14Os0jghf0+FAOlxqU6+ur0Z8cI0xyoPBeA861bm+wHeX0kB8ooe0X8W5MT1kdgqi
	BDRq4b/vRJJZdXx7SMXpMjCMkUye6gJd1VSf1NHq6sn08HORy6pOPWzQo974trOk7cHf0j51gbT
	T9dwwmI3xaUIa3b8yPu2TQEbpSQ7+2QiZHdkP8boUlLKoGv5IX+D2ub9vIgz
X-Google-Smtp-Source: AGHT+IED5q3x4DCSIrQmSNaI/hNM8JVZko4zCwH8pMSwHQyx8XQQtYie0DUOqb6XI3JebRYkGwAJqCnOXAShGoi26PE=
X-Received: by 2002:a17:902:d4cb:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-28e9a6d01b1mr103155035ad.6.1759768833343; Mon, 06 Oct 2025
 09:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930144537.3559207-1-joelagnelf@nvidia.com>
 <20250930144537.3559207-7-joelagnelf@nvidia.com> <DD7GCYCZU3P3.1KK174S7MQ5BW@nvidia.com>
 <81490b32-6ea2-400f-a97e-ad2e33e6daab@nvidia.com> <DD949OHGD5WP.1X9TCLIEKSHGB@nvidia.com>
 <4324469D-4C47-441E-9AD3-54CEE379537C@nvidia.com>
In-Reply-To: <4324469D-4C47-441E-9AD3-54CEE379537C@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Oct 2025 18:40:20 +0200
X-Gm-Features: AS18NWCxy-Hq0OsmWL4xZOPiIrqjK1XDIHFlDGJPGtRa1Eva01va6UDuU96QULw
Message-ID: <CANiq72mC5pWz92KYtOhtgOcMuTeuzOeM9xrbkna+HkrwHAQqVw@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] rust: bitfield: Add KUNIT tests for bitfield
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Yury Norov <yury.norov@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:14=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Well, it can be efficient. It really depends. I have been contributing up=
stream for about 15 years if you see the git log, often when someone chats =
privately with me like you did and they told me they are ok with a patch, I=
 save them the trouble and add their review tag especially after they alrea=
dy added their tag to all my other patches. Surprisingly though this is pro=
bably the first time anyone has been pissed off about it.  Anyway I will no=
t add your tag henceforth unless you publicly reply (or you let me know oth=
erwise by chat).

If they just say they are OK with a patch, that would just mean an
Acked-by, not a Reviewed-by.

In any case, the documentation states those tags cannot be added
without permission -- if someone gives you a tag privately, it is best
that you tell them to please send it in the mailing list instead. That
way there is no confusion and others (including tooling, e.g.
patchwork and b4) can see it.

Thanks!

Cheers,
Miguel

