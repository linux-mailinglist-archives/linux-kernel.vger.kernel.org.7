Return-Path: <linux-kernel+bounces-790091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCAB39F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FF2463CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545473112C8;
	Thu, 28 Aug 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN7bDlnt"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE813C9C4;
	Thu, 28 Aug 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388514; cv=none; b=c22XkB76pB0SjgBDJTDci8y3S1kck+5zKtw+XVbpkRBkhrDC5BSMDLi7lH3xESrhBhHJN3MNdvBHwx4P9krMgH17hQvhU4LFGp85ONJIONSGYoE3u3xrCAVwKM+AlNFZnM8ee56v2BVJgyqOhjIWLZqD/YcJURDWBwem0tH2U+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388514; c=relaxed/simple;
	bh=4JMv7Vja1pz6kI178jKc4TTOoehx14jxHa+KiI/NOs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cglIKrS15GOTM69I4lL++/gmcMTS8NkBf6WXHBlxNMq1wNvqttRpSF7ZzDGKDGjiR3ie1IyWcqOEH073LTISkLxuNpoqsIHIdJeAAauxCC7Q6yFA7nHS0Q5pUFeZigVuMepetkSsvuhYwCT47XeA5Taz65E8LeZpeM9mxY8wGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN7bDlnt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32557bbc0ecso33620a91.3;
        Thu, 28 Aug 2025 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756388513; x=1756993313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JMv7Vja1pz6kI178jKc4TTOoehx14jxHa+KiI/NOs0=;
        b=QN7bDlntKk2T3bKTKPuIoEM55ec12D9rOVFQSCMU8YiPvBKpRFaBKfcgEs8cCBmDGX
         UxWyr+8tc+V8blKFd/bwozPutL5IJPmJ1eRGMn6sz8CbY67C1fgSqO5cOc3EU0QipZQY
         L98pkquUo9oEaPYlm6B6Iq+VGHFpglOP5/R8a05RawkP/r0BSuI1EsvnJBJVzY79j1Io
         bHh6QKT4BCmfYWD+fUTWb1MP5rw03eoejJzQl5elMdSv5dcgqB6G9uScVa4zX2kGITpy
         W221aO1QyEuoqx3zqsBec/7w5hNi3195o9SMX1/73HpbUcPOvhe3bTJnZOgPjaoAr5iM
         56tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388513; x=1756993313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JMv7Vja1pz6kI178jKc4TTOoehx14jxHa+KiI/NOs0=;
        b=VQF+U8Cui9pDX7IfC5D3doGgju5kfrWUmc84LN0+9Iq8HDe/ZBznIlV9sA+CDgIMoz
         ApEyNJ91QCMNxjsbFCnhzNhn9FvJl2qUdeLhdmUOGXxPsOJ7nSlNdi4COQAawkFyKMPX
         pusXUM34r37zMt3LKN4af/x7YuI9Lj/J/n8At8bblsts1HlRRMnulMw+IRto528/lwDy
         yFOHey7pPfrryt5KX/nO+Yoi2l4S09mtpryyTY4YSwtvJDjQkEHQ9J1ONi25u4tsd7w1
         hUlNjVLBuiKd6stpcAVwBS5/xI6VrF7pqxSEWOnDi968xJQesFElcxC/vz+OIi0Q2nQ7
         2nXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIDUhlKonVAKhxiUd5ule1Zd4fYXfCJGv/aBislOav73DoySEKIYLh7FIxfS023Q+GRyMXEA2DCG9xg4B7w7o=@vger.kernel.org, AJvYcCWqfL9MphnsR+Or56mll5BVmReT7M4MmNRw7OU+Vvl+Uyh4/UD6m6kpBWkuVxJE3o0/Lw8m3kJ9BP3WiRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKhUhfIrvTvyoaDowkGk3BT1x/l1jjI2E3arAS4tyUHjm7e7P
	CUWpazKsKuBkAfE6CZEj80qZ0qjrtu9jZvHhA7h6NC6iiZ3+q9hoJ4INaqEpnmjYxU/TZLuKfDj
	w4ec9htOt/y93lFh43B5St8tlUYoE/eo=
X-Gm-Gg: ASbGncv3YdqqvRkjPyE1D+8uXvjGqGwFpiaM+7iNuted5CL+AEIuDnPb1t9SZhdMwuT
	SJ2rUwjwV9CSGe2/MM9/R3od2tvLU6c09HCFPYksQFj/J8Y5bl7iLNulK+4eR6cKo9KqAurgb68
	SCqJwyFmZ2DmtnViUd2aDx7+PTRMAfXHNSbVVx0PAST8Cdr5MB4cYMWpd64oo+TVOH2s03W+kyQ
	vHlIcYGiBF+hoM/J3vZWNc+ixS6wPGhFgFurQ41fxv5pYjVguMMkcSsuhj5fAW/5PGOeA4Dud2V
	riGpNXRqFYe7wekCJz6lFP3A6Q==
X-Google-Smtp-Source: AGHT+IHaC1HEFDBNL5xRyK6yHVlXQV/L5fAoluCuAZJZ21bpqhYVsF/CU+oFsSFeqjZOtoNi3caEGaGAwt9VLiyaIZI=
X-Received: by 2002:a17:90b:1c06:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-32518c85effmr14570764a91.8.1756388512689; Thu, 28 Aug 2025
 06:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828131135.125303-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250828131135.125303-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 15:41:39 +0200
X-Gm-Features: Ac12FXw0tG58LYsZToK0SPC4HzM00VLScMKY7BanvqHVBF5p3Kcz3mRJ_Fkbq_w
Message-ID: <CANiq72=HfZqjp7d2v3jj8+K7EJhzMtMOYbT0E_aU8V7uJuvmBg@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: Update ARef and AlwaysRefCounted imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:11=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Hey, yep I agree. So should I drop the Fixes tag?

No worries, I can do that on apply.

Thanks for confirming there is nothing I was missing!

Cheers,
Miguel

