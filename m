Return-Path: <linux-kernel+bounces-878806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B4C21843
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887713B5BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990236B976;
	Thu, 30 Oct 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuFB/+08"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375236999D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845611; cv=none; b=rzqk/clQg5L4oTL9xgK7Rvzn95y70vphQueqnD/AU0QR/FsmtuHB6iYsPeNyNsuHTuHIH+PqvHkcBSx9oN1oSGYqRPSKZHTbvlEpanhPVCxuiVW7RYB5MYNAje13iowGJoMpf2aPTYXh6p55u/CZyPkb0C+8ECnH4uxl1qcbMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845611; c=relaxed/simple;
	bh=H4oxfW8LlpZdjRUq6Ea0t/3CAVHgSecFYn9aaImDYe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcyXJ57dkKlI+Fh4NbiAZFS3919Ojb/fEoGGD5CYHQXZquwhm/F31fimtyqNuEmJwL3HlBlP5/sczz9ZgDFik1w5fKqhdXH0yLq4CpSGVf/xecufcpVUooKtCwdjgZmxrazaVLVlDYuX5kfSGlIIVIkE5VT1ni98vQ3avMplw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuFB/+08; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso183441a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761845609; x=1762450409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4oxfW8LlpZdjRUq6Ea0t/3CAVHgSecFYn9aaImDYe4=;
        b=VuFB/+08pdYeJA78Eo4ssiG2X1KkwUEaqAoi6f+Mc5ll6SexgbAFJ3AdmuOYDeBTKG
         5FaKeMQoWNfnPnePO+0mRpdfVxmhm7qAIVhhA88NgEpkEB0u2yEegWSQhwqtGE1MYf+e
         Wz4+biaRNXGmftZgd6AfXdfC4Jgpa8Ik8yGL0i8Al48v0RsDI+NfU9/vsC6wkPDYVvEV
         iDPhLaqrrorm81+00WSFevjLbxwZwI7gzeRL1Xw4xmtpNeZP1cgjPLzH0vfLyNNWg9nq
         QgzXghDXWXbwkjsWr+CPWf3nbATZbfWv90NV2myUcWpOQ1HuHmsQ1QF9WeDlIaeGI7cX
         zDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845609; x=1762450409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4oxfW8LlpZdjRUq6Ea0t/3CAVHgSecFYn9aaImDYe4=;
        b=olw98yuwNutSbc9vY7CzPIRc6k2IrF/eCNKTUyn18Sp4QLP8hdSz62ZZK7gJEC55nX
         QLAMdyXQrv3uM6s+kE+FXE8aLYFSwTpUmhslUpKiiTt8i3b1Sn/NpkIzmNdBhP1Ku/Tc
         T9x6rRazwM69Ktcd9LSIxcgzOzvHetnIZTzd31UpM5toODrwrCNyqV4DhJDuoTaaUd1u
         rQsE87rh8xnBzWdCavtIyThN+Jmq5zmvHNYyt6IwDGitWJKa7mdAz07GCJkPjMmRJJ/7
         g54952S08OnNkSsvbNFaaPUQSvOZMDnz8agvUpk5EjsGDg3liouRsLWBE3KF57xnCsfM
         wVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpEBeGHwcaMnsEIcaD5J51swDCf4LjfF+D+NTo2hTYMAYP+gQpWPyFT+HCOukhKPyQjMiu4boY8YGZT08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ggZNhvpYm/HOLo6RaKUcyYuRGnu2GYRKMDpzHK1V28sogfKI
	J6PUK3E5x0EXKHecKKBDuILTurcuRqKG0mXRgodkIgo/xJG0dEaR7dp/8s2X9grOrTacfb8EDmZ
	ndd0736q0wx+0IlbXJOSHilFNSfayVwE=
X-Gm-Gg: ASbGncuk4aWRQddb6SHuC3ki5qiImFIXvBdvAH5GVmoNWErPKQaZTaPrHD0NZOTfygX
	jSAKlxlbaRefHSJAQ42uiH2lA9DxOjFsLHb2cwdXzlwXT5kaTl+PjTwoQN/wSuWkKnrrsOE+KlH
	tSe4u22bTfOxBF1yGXScnwNg0VKyg7/X8iG6hZgF8VSMXkmALV40znogP085J2wktvPTuaaZBDh
	A5/wV2TZA0G69NwlgSOyuDO6uCZrK14+5aIeIfO5ZfJ8b6gtQQaq6yTgN4M+3YnNnXotOucL8DN
	vQbjcuVncck5AvGxp/tKNzKwIyFZT5Dcg5oVlHz0jp06gHkCSID65ulTDhbjj9WVEPIrQf6Aww7
	69oA=
X-Google-Smtp-Source: AGHT+IEnjYjBApvEV2QGoZHHyDXa+qaKI8ES/te5I3LkfLBQaNi5vi9/OL65b9UrrS/ffKZv8Lj0Yn/P4npQa66AoQ8=
X-Received: by 2002:a17:902:ecc1:b0:290:ccf2:9371 with SMTP id
 d9443c01a7336-29519a8e2c3mr4051765ad.0.1761845608672; Thu, 30 Oct 2025
 10:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-zeroed-of-rs-v1-1-1c46d025128e@gmail.com>
In-Reply-To: <20251030-zeroed-of-rs-v1-1-1c46d025128e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 18:33:15 +0100
X-Gm-Features: AWmQ_bl1pEXbFGijSDZoaUSFwxjZwY7dR_OCs0R-sUe03E0zMHx4JxOi_bitJAg
Message-ID: <CANiq72k1dEHK3f-5RxkAKL185Zx8dtUz8X_V2Pk7eALeyAzZ0w@mail.gmail.com>
Subject: Re: [PATCH] rust: of: replace `core::mem::zeroed` with `pin_init::zeroed`
To: moritz.zielke@gmail.com
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:45=E2=80=AFPM Moritz Zielke via B4 Relay
<devnull+moritz.zielke.gmail.com@kernel.org> wrote:
>
> ---
> This patch was suggested in the linked issue. It's my first attempt
> of sending a patch to the kernel mailing list.

Looks good -- welcome!

One nit: this sentence above would go below the tags and the `---`
below (the `---` here, above the sentence, should not be here).
Otherwise, when applying the patch, the tags will be lost.

Cheers,
Miguel

