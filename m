Return-Path: <linux-kernel+bounces-858059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C588BE8BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3081885AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A5331A5C;
	Fri, 17 Oct 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfC3onij"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A81D5CE8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706387; cv=none; b=Vabhutd05KoyqMRIxQP3srjQtfzxnhc5qcO13QtXQupR9Ekd2vfaVNWJvMzXOYlyqnL29MVTj/XEi/qGei0EkfL6ROSuXLu97+RdCEzzTQ7x13JafDfZocYnI/iCifvM7rZ9AEQMbyJJIews8JVoTLpwEdW6eMq0zvsMLOVOyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706387; c=relaxed/simple;
	bh=mWKAIcrMZVv1wc3CtzrZKiBn8JYPxLviInXEx8ShWoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knW/IcoGPb3+sCyaVSPy75bX4rtTVf78zUe2J0Bnr5+G2iw61NI9Dhirct984MKs1IxUTZV8OAZCNDqC3X5c57BwoGNiicdqSIItp9OQzqg2NFMFSvAAazIWNrZajQxnfN2jw4AWAYowkp1AcWwNGHxjUVXjX7aKFcQ4by415TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfC3onij; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-394587df7c4so768376fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760706385; x=1761311185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GepDfW9E0nUagdgkcApQSbzos+mlrZqdCRnH825BS7s=;
        b=LfC3onijhmia9bDrgFEDUMNoUqm4GeU1x109mLJ5hDbU/vafwOGN5SGiDzYwu7LPOi
         rGDqcdTZSmjltySNDNDp8LuiVAHqwPRCQTs6TtLQRnLMVtadVj3Z+x+Gjsa2RBW2/ybN
         WZrEIlWWeV7FqD3J1zi+8ztDJVUfyiUcwpG2ETiPMjeonLo11hL3+5ZhRmaU/LnbAKci
         U+ue2+LUMqsRydYpCMxGnZWa9dg+y6dCFnTHOF9HNWMqcnWmdXbhNDYLRHItrjNRm7dZ
         PztLgRbGZPgHcwZparRgc4qAlehCIZvuZWgSGq0mwdx4j/SUxtwICV5Oxi84H3l0C2gI
         +WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706385; x=1761311185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GepDfW9E0nUagdgkcApQSbzos+mlrZqdCRnH825BS7s=;
        b=GhZNKbdWWBRmQppWW0Tl9hM7oorxpNtLWabJASLCtLaexLuG9o5hGuzQ7quYwD2KFA
         ToNRnXMs4YzKX1cG9jKyzefPzAr1iPUHiiWrRyR9tTV9kLQaaYGO2YVdUJQCqRcn2MlG
         pQ4BG+FNrc37Gx2CsZ+naBTasKK3BXfhAY4z58r7/lqEx3Pw+MQrflKlT7hOuknXex76
         HxKNEaJJE4MAGHwVAXlQEfr/hla0W/eDelOm4ok7cdf0EJJDY1qpfPokinQyZILrxcTM
         If0ISfammTg1WUAs6wY81S7W7KfJGCtaxL/Yhtz0rTG7fMvflqneOczwt3G1s4iWpF+0
         mHhA==
X-Forwarded-Encrypted: i=1; AJvYcCWCNC2b0w5pUZhoyUts7QCrqLTucGWI9y61xmK8Tu4aN/n7cLQf5JeTKUh6mcj1kLrA/OuUD+Z/RhNpGYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGozsd6oZZ6gOlilrZfxHFqh/fS8xQ39dokoHll/LKCgLv3j+
	n7SQlLVSYPpxXBVEQs4nbBVTjZxlIH3deXTtmgbBZXcyuwIsDjDlEvIPj7cH/U9jlNGS8uXidoE
	pqfnn1EOVkyxrJb3kbGmg5LYJ3dqNbyY=
X-Gm-Gg: ASbGncs/fZAHL9p3e++GDtQbxVx3GuoA2Mylni+KD1ovtbWRwwVEzL7/DkyPMNGHhly
	/eZab4rS9JYNPTXcH3EV4fUeylv2nYHmzs0C8fCroTEGpJ6CMsWw5F49mv5b594rNZyi1OYH7zf
	/5/3sPQIzwXLik4biESlwJZqof/tBA7a/BkC/MErbxFgDPJE/ae1znUgqK4cw4kaPvnAq1dpEHr
	vtD4xxw6e5KH60SviILem9q/0Io0bX7U83mbWfSa0yK0HD8IUFFp8uRFYEFU1xrIHOEgcg=
X-Google-Smtp-Source: AGHT+IG+lXlLFDl3T0YzSok7m2AbHR6xmpCoLDHgVg8GL/Fi0AuigLh2vODu4DJgLx6XCplrx613O2JGiUegL6nmmjc=
X-Received: by 2002:a05:6871:80e:b0:344:34e3:5140 with SMTP id
 586e51a60fabf-3c98d179d64mr1418450fac.45.1760706385045; Fri, 17 Oct 2025
 06:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016211740.653599-1-lossin@kernel.org> <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>
 <DDK2SA1D77HM.38KOTOTF8FJXI@kernel.org> <CANiq72=Qh9sJLKwACr_McnbGdu8JfzqDuv1AgCjSdwKtt-9Gdw@mail.gmail.com>
In-Reply-To: <CANiq72=Qh9sJLKwACr_McnbGdu8JfzqDuv1AgCjSdwKtt-9Gdw@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Fri, 17 Oct 2025 15:06:13 +0200
X-Gm-Features: AS18NWCeDsB-JZadx55OaJQ8kOop29eKTZv6rb0-8XIQRp_yPbVPdOnyL_WRHqk
Message-ID: <CAAOQCfQzhxDzaJOb3GyVPgcVD0npso4bJ8zuy_63ZSr-rnQ0nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pin-init: fix broken rust doc link
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Indeed, although, please open an issue on rust repository so the team
can discuss how this feature would look like.

Le ven. 17 oct. 2025 =C3=A0 14:59, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Thu, Oct 16, 2025 at 11:47=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
> >
> > Thanks a lot for the added context! I will add it when applying. The
> > `__pinned_drop!` macro will be gone with the syn patches this cycle, so
> > in this case, we don't care what the resolution will be.
>
> In the end, it wasn't intentional, so Guillaume created this PR:
>
>     https://github.com/rust-lang/rust/pull/147809
>
> Thus 1.92 may end up without this change in behavior.
>
> Guillaume and I also discussed the possibility of checking these
> things nevertheless (i.e. without needing a second pass) as well as
> the related topic of having a runtime solution for toggling
> private/hidden items (and thus getting them checked too). We could
> perhaps try a custom thing in rust.docs.kernel.org to see how it looks
> and if people like it.
>
> Cheers,
> Miguel

