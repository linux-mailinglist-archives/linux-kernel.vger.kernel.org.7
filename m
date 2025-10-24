Return-Path: <linux-kernel+bounces-869192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C7C073CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1174188A547
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E823C4FA;
	Fri, 24 Oct 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AYhIiJNS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7261D514E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322574; cv=none; b=PngelZck/uD9r3SjGe6VrIZiypAHtOqegXxvzuLDbTkK1C0m7i42Hi6pMCclUT1PWhwgyDbXG2h1zYCuD9EKIcQRkFZve9H2KD7/WIYZLEgIPaznWDq92j2QcARCbVoyKdue5MzXjvH9866g1D5VXppLhKCp9pHT6ZFKDunB4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322574; c=relaxed/simple;
	bh=5TtwmnLbDDTqvZTxESC4gxv7z3uy/Gk67LVww9+74lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvjA2p1aFW/DNjP3+LrQBS/kvIbpj3p+41fGkGPT+O3HVBq8olg6WbDLKP5Vt7fG7OFZ89Npn6bJoSkdUqdC2SSnygYhKekQfzZ9YVocvSdVQFYznHkOz5vSrRNfXYuo6vbsMUTM1ZU3NPDD2sI1WlP7lojvbiDhuOGve21ecBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AYhIiJNS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378e603f7e4so9965021fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322571; x=1761927371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hoXtHHA5k7qKtUM3YbUnyrHBlYIGcj0sn2V7B2w8uw=;
        b=AYhIiJNSgW9VfySWCqhv8vusgRNE0Xyz4rRuFPljaIV+rKixnuML7H56bpNKIod08N
         emvQHQGDdyQao6oi3K6/J+qxOOsHhJQKSUJ6ALrqJEWrgOGC+04KLQgRtJnw3nmhYIGV
         Xulx4f7CBwhhnGHF5QojhNtX478qnCBi5TSfxdNPHnoO/gFI7QWtzRXmJ2s2DT6+HYss
         El5pLH92HLYX1a1k7lGJNw0n6fCa1BSGfFDwn9JVe6Rhf5fLlXA8+TTI/rWQZRLwchkt
         bpmLCEQ3Qzcmew/86eCUyezpSSMg8Iz4y2OINNPbCDUcJ5AijJm7Q61b9DhHoWmXq8SL
         9ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322571; x=1761927371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hoXtHHA5k7qKtUM3YbUnyrHBlYIGcj0sn2V7B2w8uw=;
        b=GMo0R22KhAeizmLhvCHbO4YUuWTwiobp96/99ltPiOh0odW9B68DexP+W5uhDqyig3
         xZampTUx+mfIaxQWf9dUcZKKnvhCwsJUenphcZbBt47y0vkKTYCTe2GKVozzq0iwDWC2
         cl5YY65lwR9yZJOvVb4cpVFebSWFE92wAPHdOyHS2KVe8XMfyD2F41sRq98Bf4W76UfS
         ktmNqoDYEC7uPu/r30ZkILeL8iyo8ZdPcT1BRabkhZRBY0CVO2JfedJ5SdEbN9e5kLRQ
         1fz0U83frUaWg5zaOgqSchu1DBv3jrh0W8uIlFNOwxVeYG5pDqTcVrVuGKJWQg9moY+I
         e+qA==
X-Forwarded-Encrypted: i=1; AJvYcCW4auENnuw9WZSzgjIWer430JqOXVWeYYJuin2yM0V8PIpPLepUmOnB5Ehgt2kboMq0eMQihEe6TnCWkig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkH/1CrhazAsZnojQTUdasEAeOXvS8hX1gcnZSUmOkW5NYZrK
	MH76nJ4i2gN4y9N+5gFlExflTqh6CyUNjdqOTmdYW9mnAqpHE8WTisMRcWixGab6LyXOoKfwz8r
	F9GSjgQuPBkY2IyNUhnC8V6OrJxGHgYK4EOe5VYJ3EA==
X-Gm-Gg: ASbGncvuEID5uq9/69cCJPWeAMVuP12TS6nlwrooV4C2LseMEN1cm+Ii/Vwy/DiLqPi
	QRsjDBnCQnKs+RVdqMSHFo0Js98ZmVcG8u+3K1SZk/SCPK3Kn6qlFm1gh/CYSgBk6yXtnK70qim
	P12+4nMejX3leLEUioiMX0V/TKBFLpXkvJrwMdTxZ1o4ld4fjjsdbyzMongb7+n12rlwZk0waUw
	ncr95V3pmTaeK2Y88cFika3TyEk++Jkvp6vOd+6C697GJr7k3Gr9TVPKf7FCD1Hplli
X-Google-Smtp-Source: AGHT+IH8WOU0xbwl7Y+ksyd5jD9X6PhDLczYsD+A6K0t8J7OJdygB2+hIh+k9oSvOmjM4CFOKsep5og5GveG+1uLBEs=
X-Received: by 2002:a05:651c:12c7:b0:372:93dd:681a with SMTP id
 38308e7fff4ca-37797a744bfmr92216601fa.35.1761322570537; Fri, 24 Oct 2025
 09:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-4-pasha.tatashin@soleen.com> <mafs0ikg7fbez.fsf@kernel.org>
 <CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
 <mafs0o6pwe1sy.fsf@kernel.org> <mafs0jz0ke1qd.fsf@kernel.org>
In-Reply-To: <mafs0jz0ke1qd.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 12:15:32 -0400
X-Gm-Features: AS18NWDS5bf4nRNM2qxXHaSonlVu1EPNEq3HBS0RPvYO5kiX8yMEO_3tWdOfdcs
Message-ID: <CA+CK2bB_xPAsHXU62Hd5iBt-+Jf2BiXQM4M-QEL=AA_Xu-APhg@mail.gmail.com>
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Oct 24 2025, Pratyush Yadav wrote:
>
> > On Fri, Oct 24 2025, Pasha Tatashin wrote:
> >
> >>> > -int kho_add_subtree(struct kho_serialization *ser, const char *nam=
e, void *fdt)
> >>> > +int kho_add_subtree(const char *name, void *fdt)
> >>> >  {
> >>> > -     int err =3D 0;
> >>> > -     u64 phys =3D (u64)virt_to_phys(fdt);
> >>> > -     void *root =3D page_to_virt(ser->fdt);
> >>> > +     struct kho_sub_fdt *sub_fdt;
> >>> > +     int err;
> >>> >
> >>> > -     err |=3D fdt_begin_node(root, name);
> >>> > -     err |=3D fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys)=
);
> >>> > -     err |=3D fdt_end_node(root);
> >>> > +     sub_fdt =3D kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> >>> > +     if (!sub_fdt)
> >>> > +             return -ENOMEM;
> >>> >
> >>> > -     if (err)
> >>> > -             return err;
> >>> > +     INIT_LIST_HEAD(&sub_fdt->l);
> >>> > +     sub_fdt->name =3D name;
> >>> > +     sub_fdt->fdt =3D fdt;
> >>> >
> >>> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
> >>> > +     mutex_lock(&kho_out.fdts_lock);
> >>> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
> >>> > +     err =3D kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
> >>>
> >>> I think you should remove sub_fdt from the list and kfree() it on err=
or
> >>> here. Otherwise we signal an error to the caller and they might free
> >>> sub_fdt->fdt, which will later result in a use-after-free at
> >>> __kho_finalize().
> >>
> >> I think, it is better to simply do:
> >> WARN_ON_ONCE(kho_debugfs_fdt_add(...));
> >> Now debugfs is optional, and there is no reason to return an error to
> >> a caller if kho_debugfs_fdt_add() fails
> >
> > Yeah, that works too.
>
> On a second thought, maybe pr_warn() instead of WARN_ON()? This isn't an
> assertion since the debugfs creation can fail for many reasons. It isn't
> expected to always succeed. So a full WARN_ON() splat seems overkill.

I sent it with WARN_ON_ONCE(), I can change it to pr_warn_once() if
there is another revision, otherwise we can just send a separate patch
to make the change it is not that important.

Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

