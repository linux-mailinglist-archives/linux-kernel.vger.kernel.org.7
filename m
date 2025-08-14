Return-Path: <linux-kernel+bounces-769237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6AB26BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D9C686C75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601123E347;
	Thu, 14 Aug 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AesMwfFg"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5277199FD0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186881; cv=none; b=NLtwj88KTgyyNm4jYzd1i6xiTGztwFYZVspOUTppH5iA0ZxdDO1of8geuWJnSKAqdW1F3pgCngWZqn0Z5yLNMiaOPAc7tciacVaYrd65Wa4XgTNNRTZUMXIjU/a1okvQlOs9/D8h+eEvawrg6gwE07xfxDTUlgen1PMV2YztFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186881; c=relaxed/simple;
	bh=F0pElEsvxrR0RRjThz7t1RhU6UkOvkMNrQNHbBwmIrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBaViw+juU+ot9+rEz3uWR2jFwsC03pGjvijLXlkpS5hpYZAZdah+NpkDm7Hw7cIzM2e3h26QeO866vYcT5sjrw693qFQXutNY/RdkMt3h48ccU+XZyg8QgCvL6gY1aZFh83kEiKIqP9OocH5RHUWwc3wgvPXclAL+CtC+CtokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AesMwfFg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e8005bso1246394a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755186879; x=1755791679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvabB1TykqrJuGy2/4C13LzT2Q6NuaXnmqhVowsnYYk=;
        b=AesMwfFg2Y4v8ydIg5KcWovRFzao8+OjlqgnSWYZ6hMnmFQZdYhYcdM1rG2dJ7PRpl
         pQ2Dnnk2PrbTalMzEaiX8/m1WxFyS+x6yslVs5Z9KcBeD+5wfHRkB6NKb6AB335aGlkE
         TAANeaCbrp8LuJ4suTnrLW2BxdacPGqFG9ag6ioofzBUt3quhmDpmDYMdGoXR/MB8qhb
         pn/7HInE0PgdGqz7r9Wbknq8QMg2NXOqCvqPZhiwgufAGzZynpX6hvOty3E5RUXFr+bD
         FsDG/7dA502flcnP0i3xXA1Fehyq+dm5e90lWWS3l7srK5xNzbBZ+rnBR/ueV3q/sooy
         jwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186879; x=1755791679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvabB1TykqrJuGy2/4C13LzT2Q6NuaXnmqhVowsnYYk=;
        b=h9tJhLC2IXviN+UOgwLwovPRkMtuAXSAkpfWipzeohcukzRFtRx678neLXElFwObS+
         uRAUvR7/3twR7Gc43+4L7GX2KWf6fAuz75jSnnsFqgK8uHvj4g72BZGhZCn9gmTSYiof
         foQpFGtCnZLlvInq8B60ciO5aq8ieRkWM16j1J6sCY0jMT6nM2vN4iyYb7y5UdaSMtFt
         0nu2+rpaYOQ2CQqAOAmQ4qQf9LF1Vd+TTRsjyBmwAd8duoIj37l5SgTGfcCAiNHY6gCD
         ZEve+yeKXL1io3s3/J5U+xcaLRFQfjsmSzKPmFJSZTiWGHEY8cZw4sQOc8B2CLlJ2EaG
         9ung==
X-Forwarded-Encrypted: i=1; AJvYcCV44Y+c7gIE1+iLX/5GktbfKXpQUFr4COvLWBQSkY5g+kNf2AmsYyefEeMN8MbqnIz1RLuFSCHEEV70Ncs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsBjzZtHogUAMfGDK5DnWFATaxGKYQgIIHvQGE2qqWVdG+0vg
	RIZC+grMGRJkebToCUYRFsXX7fBni0T/k6TyslDps6DtFPxBR8I0Za6LREg00mY6+2mzWwiv4q4
	gKzJSfqhksvNgnBX5BAl3JKTJBpgs7HSNemJYv8yY
X-Gm-Gg: ASbGncvZA6QSbVGposDbopRZJxNxdzh2Ced1Cg//aigsxw9635G8p8t520pjBH7hK77
	8oQp2dtdwMRiORXwIU0uRfnnRPI3uaaFubxTHgTwcqxvXOwi/rOBMN7MezjHQSeBOuQ/qXjPjRL
	VgtmDzzO02WxpQyugLAcDSU2xLuLiAMmaxD9l+E+4vLw2/eWOE9XVLww2Lm/XwpzVubU0IOpt1w
	B4byTRGHLR1U+zp6Q==
X-Google-Smtp-Source: AGHT+IF3C041JRsjxUqaaZy5hpDym6lDLSiH1UTT6ITfTxQxD+tAO83OLFzF/MDi+d7eudf6g7YOpN2iMFBcxPHh4Nk=
X-Received: by 2002:a17:90b:39c7:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-32327a51eecmr5939431a91.20.1755186879054; Thu, 14 Aug 2025
 08:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com> <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
In-Reply-To: <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Aug 2025 11:54:27 -0400
X-Gm-Features: Ac12FXzlwiXq64khBtAeerI7ifBROgc4LhPQT_zvpgV5Z4PtTDCkCmp0ECJQmC4
Message-ID: <CAHC9VhQNi31KSpB-MtvZO9e5fzuM_87VWb6rrMtxcqOGSPTiNg@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Thu, Aug 14, 2025 at 5:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > I'm happy to take this via the LSM tree, but it would be nice to see a
> > Reviewed-by/Acked-by from someone with a better understanding of Rust
> > :)
>
> I think the idea is to take all these through the Rust one with
> Acked-bys from the maintainers (or we can skip this one and do it in a
> future cycle when the first patches get in).

[CC'd the LSM list, as I just realized it wasn't on the original patch
posting; in the future please include the LSM list on LSM related Rust
patchsets/patches]

That's fine, it wasn't clear from the post that was the plan, and I
vaguely recalled from past conversations with Rust devs that they
preferred Rust wrappers/helpers to go in via the associated subsystem
tree.

> In any case, Benno is very knowledgeable in Rust -- he wrote the
> library being called here -- so unless you see something out of the
> ordinary, it seems OK to me.

My comment asking for additional review/ACK tags wasn't due to any
distrust of Benno - thank you for your work Benno - it is just a
matter of trying to make sure there are at least two sets of
(knowledgeable) eyes on a patch before it is merged.  If it is
something I'm merging into one the trees I maintain, normally I count
myself as the second set of eyes, but in this case I don't (yet)
consider myself a knowledgeable Rust reviewer so I was asking for an
additional explicit review tag.  If someone else is going to merge
this patch{set}, then it's up to them; although I would hope they
would do something similar.

--=20
paul-moore.com

