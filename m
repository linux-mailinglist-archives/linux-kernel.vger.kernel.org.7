Return-Path: <linux-kernel+bounces-896128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148BC4FB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8971B3B3CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D4279918;
	Tue, 11 Nov 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/uUU1Fg"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CF23183B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893142; cv=none; b=uyfbCYIP+5/tJY6HxDtx6NUuZU4vXGWgJcoO44AUDCj6+b+MZ+dKHS46Mr2k+U9BsnpI+KtpVwRUPF5mIqF96MHoWT5WCws1SLYcFGZunJxlY9HLLySk/cT65odFqqn3O+G6RrSIbSQij4OQYR4XAzaohAkdX8wvW0MaqM9Evkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893142; c=relaxed/simple;
	bh=K0ITm4kaj7zgUCCm0JCFhPjRTKRmOjBpzfNcGnDqMnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozZBG4GXcALg3QLRYEY4qhyw2FYOTaSo42AxRlcAtdxfr3lbuYZHy/lEmu9UkiD8yg9geg+wHpanf8pr6j8z9IogadA9uCT58eLJ1HQC4SpnNUl3oGyYPa/KZRWt9KjGYjuMit6KQGeMQ/qszz4Ed0TRTyLYdcBo4IGNV7pfZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/uUU1Fg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ba3b6f1df66so16806a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762893139; x=1763497939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ITm4kaj7zgUCCm0JCFhPjRTKRmOjBpzfNcGnDqMnE=;
        b=Q/uUU1Fg6VYY/Ds7mNy9ZFqgTICmbt6LmKf/7bUzSowKmOXsLcumLAvddmX4RgBQIs
         gLpYoHCRpho4HHz6XnKJgRIUDiCoNiU3SYaohiWkq6ggNhpxU0D9dL4p2yRjObmvEzx5
         vd9czcVrUAJU4sJoFQ4eIwt6ZhhMjpIVJyF5fIxYM3yI6vg9TDAsR3IEnXS6Dnqk3aR9
         Ct7ENM42B5e3cQbqFe3hQAjBTZ2AWR+xTxqDb0QSOxAXz/fxBg3uhcStaccgLLsV7jL2
         EB62ATKlvtn4aeFWdN/8/y/lLJFuAiXDuQnaxtgLy+e1S36g+wiOPC00t6zRLVOe1Qjt
         kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893139; x=1763497939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K0ITm4kaj7zgUCCm0JCFhPjRTKRmOjBpzfNcGnDqMnE=;
        b=LFyt6je2rDEtllcaPFC4LcVJUBRJCHhhYswUfItO1scFtkum72OdE4t0OzXI6ZEjaH
         6vM2EEa9anLk0sceavm9L6coiDwc+4DUKPw1hGgYRsHpMwiw/tI0WP6o5PNSITdprepo
         HS4pG91sX+A5BimXIFfFoXL4jxetrtosr7BxKr+2adjN3HOHA64k1/5/UzHmm9dICvjs
         GFcx0s2is4uJ75mk0HpBzjiSZbo8wOAG+C1CuD75uWlTrH8i4dbPaAhREuGQNQRruNVO
         ayZxv+GxsZlYxLbkSoTrmg3tQKv1ZgsOcHNrgyB7OLy44e7lZLPtra0JMq3ncLdq6bnS
         6HbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDWIwtZHVU4NeAmJ+vc1SaVW5LEhDTS2MoWjfj9Tei9pb9r2NSn2JE1YdKlhjJ5ukqbBsyvrBd4Szi3r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uCXJl9Dd1oGeDnLUjjtfqPOkpr7D+5mmFD3FhR3XMiHDZbMn
	rZisZ00tQRPXxxE6GiZ29IsKmKJIFgiplooPD5xyyuqZ9VovDAP6EnRSbxFsBAtiulJgVErjTz0
	yq5rH8MpgQIPckdj19t9cb7H4wgesFQE=
X-Gm-Gg: ASbGncv9HrkVRAdOAFthcmRi0Ctqw92LmUgoUds6/+MyMZAjKQU2yg1bGHZ7WjbJ8YU
	TaHX1rRwhPqMd3WFhnRUjq4J1le7P9K4PzwDwDBaS3S2HzHb2BE3S/CPUXVR/x5f4D7sPzhJz0m
	3JyRCcnukYrfsjw0Gw97QGL0omHs3xkG0jI4br/g4hV4DysmBjlLIEgGLSBert97xCNkuG5uDfv
	kKFyvjFwOH1sby4B2DOEOe3xoj8PnpwPhyZt0rEf6Crb3021lvU+R51ODC+MjivVl5GMVZH230l
	oa6hlyQLoXbOb7Ef8/IAI+NEUerLT5ENK2hx2xa8O+NdcJyfZIxcv1fm3snnAtqKZzMmiv6uphW
	qJMpVfAAn3HN1fw==
X-Google-Smtp-Source: AGHT+IHkhivjJqX5b/37P8r79971KGp5/CtKc/qZSlE2EIFXEGP5n3HbQm7JyHmom9185URkqKimQum3m1tK5n6XgK8=
X-Received: by 2002:a17:902:d2cb:b0:298:f0c:6d36 with SMTP id
 d9443c01a7336-2984ed87089mr4321895ad.5.1762893138722; Tue, 11 Nov 2025
 12:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
 <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
 <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
 <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com>
 <CANiq72kYYu9C94aY72HK1ELSmvktF3nq+G4+smdAW_Xaxw1kqw@mail.gmail.com> <CAAOQCfSRVqFZAJN_m-kGLe6fnqKYyhLUf_WOKdHHMW-C6NShkA@mail.gmail.com>
In-Reply-To: <CAAOQCfSRVqFZAJN_m-kGLe6fnqKYyhLUf_WOKdHHMW-C6NShkA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 21:32:05 +0100
X-Gm-Features: AWmQ_bkuC058fj8a17da0j-IGoO37yszAwGTtwPbytKgwIYY0ZLqmecqu3judng
Message-ID: <CANiq72nU7LOSEv=RsewAwiEbeO4=pTqg_pm+WJGfum90BC43kQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:54=E2=80=AFAM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> You can add your own tags in the doctests, and with our patch waiting
> to use the new rustdoc doctests extraction, it should be pretty easy
> to plug such a feature into it. We can check it together if you want
> when the patch is merged to see if we already have everything needed
> or if I need to add more things on rustdoc side.

If you mean the `unknown` field (in the JSON) that I mentioned in my
message, then yeah, I think that is good enough (though we should
probably still prevent collisions with future `rustdoc` ones).

If you mean something else that I may be missing, please let me know, of co=
urse!

And yeah, we can take a look together (likely after LPC).

Thanks!

Cheers,
Miguel

