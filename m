Return-Path: <linux-kernel+bounces-884912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0CC317A9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E2B188803B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E832D7F4;
	Tue,  4 Nov 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+f3rsGm"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5A2F658D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265820; cv=none; b=jGhmLHDDIXnK/1y+ws4p7RsZDvJnBJ9VJ3L7giPdrzwpE/LAOrqOQqiSwCThImRnkByOPBrlZK6PExLBZVO5WU3bFPFSb57kG0DUMd81O6wqSWVm8StIOnu0weroTBtx4jwYyU+Qj0tkI0p6PdwHY3s2ptHfrOmC/63fnIEOGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265820; c=relaxed/simple;
	bh=Sh+MaVFRymsuv3mSiTuiE0T9KT+Pic0tQtQqdA3cTLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtIvSd1mNSCqS89mxm8dlEs4XLnQVHsS8Mt3uzNZ1YDxKoFV0g2TANIBa50XZdve1NKwlWPQl0gV98BVDkTYT6g7nb5t9CKlJOfA9t/Zi3qehxdNYPXchsia0iJwu0KRQ71e7av+xU/HFld8Cj3kXfnDHTydL+tct2lWhqyFBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+f3rsGm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34053e17eb6so815073a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265818; x=1762870618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh+MaVFRymsuv3mSiTuiE0T9KT+Pic0tQtQqdA3cTLE=;
        b=V+f3rsGmCpVM6N+1Uk3gWTFQv1luplnuwnMk0e3qAaggMF9Lq2zI1Mp+O0V7wDEXzW
         iEi2LW4ot3Es6BzZOYABq5bGzVzAi7XNVg7KzkPgxjf/jK0fPVtcBPv06feELQgAW/K1
         s8U03S8FrECv6hdAP0O6c/sthNKyzuzKH+XR+cudDcgcj/gnnNg1dkSLuXi5rT5pWsbF
         E6NxxA2/BqRbGf2wDq+JEwSIZvWgPQldd9pzYSIYlaNLuzNUUIR7dUh6oKtuz3PUr+jY
         qJCriutJMgIdmgLfCBSycQ/5Ph6iaBs0rVjMhB5HYR1bQnMv/FudoXsQkQ6KS4oIIqNZ
         9Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265818; x=1762870618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh+MaVFRymsuv3mSiTuiE0T9KT+Pic0tQtQqdA3cTLE=;
        b=jmJQwU778GWZwJGmxpfcQnj7YmqZhqaiFHZySzlUwJ4rmLSl9H4DVhG8N2Rrc9DQXP
         F+cuVUVDMt9kvGFc8NFECvtrER85KcvTzXJwRkA3ACIVuHO1TRD2M9lD++8GYVczZqEu
         b0qq/fq2H8181vJjd17rm5LWJ8KpGapMJ3XWve9iFYew1v2PNu45UZHNyc9MF0zRfMxq
         m6xcbYj1w3mesD9cFBWxxBpsuavmnJ37epGblX7Mjk6qzoUWhp/EJt4PNCjU7iMjM66U
         y1/TpB4vlsQrbmhAsUoxuPYTNpTL99/7eIwXHWOiT+7I0uCRxhNAS/DWUDnJzsmo66gz
         bUlw==
X-Forwarded-Encrypted: i=1; AJvYcCVpnmQ+Sq+1Unal5wtbkm0JORC1V8RQJHnjlwsq0mRHxtCqDGleFuhNAcLo3/I3XCGWvMWjUb9IMeooiJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8F6Kg9Ht0+K6TGIM8GEpnVO9FF2z1/GGQmlL/7fSlZXd8erT
	ZH7PnFxI/eDj6Fk1MnuYm8vKp9sxWGphzQZPAVSi2GP4LdU3P7lTMWFvdHQwup1LaFxBY39b6fz
	JniasosOGvAWk1CoB+TsTiiI/XmfiZgc=
X-Gm-Gg: ASbGncsQEPW4NLdoomAIuPQ3ih12a1jPFDgCT5/320DTd2WnI98gNXS+NM8kdYUiKvG
	LsbbWIBfX13w4ag4V9rCnGZQltwUiyJ2T+iNYitFMocpvbA1mQYXEDAzuItGl+Hdyvi3ofhyvnL
	M24IzAwAaBO1cexrav15OvYDrLAasXK6eWnRijfmb+RIZsPoHNBXt/F5s9VO192TfqV+yVvesAc
	rxFDliwcbPb+cTbPGPkWlgPzsBOeIBsqcKSVXK5HXZqgA/H6bYhnjoBDWHzc4mkh8inwkzwS4bm
	sDmnXogpDMvC8uMu3krhGcnkXroyItMFGeA4N8v+m9B/HXMoF/380FdyZGgDPfCkrD8QO9NlKmq
	DT+8=
X-Google-Smtp-Source: AGHT+IFPcCygCFpwJxAi7tzB27/U0llI6K77VjAmQGkHNUGN3whlkaQCTTO+EohRDUTXs16aDzzs2MUAPc6YS382IJc=
X-Received: by 2002:a05:6a20:9143:b0:34e:e7c0:3aaa with SMTP id
 adf61e73a8af0-34ee7c03ef1mr858167637.4.1762265818351; Tue, 04 Nov 2025
 06:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-b4-as-flattened-v2-1-b042d8715a8d@nvidia.com> <aQoJUAdFFBpQiEZU@google.com>
In-Reply-To: <aQoJUAdFFBpQiEZU@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 15:16:45 +0100
X-Gm-Features: AWmQ_blfMcKn6WraSG1MbO5QBQX_DLZkGFH6c-b4AqmylsWifqNf6lbYrNe6YOQ
Message-ID: <CANiq72=ueGrFG-pj+4snGnbrT-AW16_gMAUHn=3pVCE5JX8gRg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: enable slice_flatten feature and provide it
 through an extension trait
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:10=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> You should double-check, but I don't think you need to list it here
> because all uses of the unstable method are under the `rust/` directory.

Yeah, having the indirection and no macros expanding it, it should not
be needed.

It doesn't matter much, since it is stable anyway, but removing it
would at least help other crates not using the indirection by mistake.

Cheers,
Miguel

