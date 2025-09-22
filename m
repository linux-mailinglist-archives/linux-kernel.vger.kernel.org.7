Return-Path: <linux-kernel+bounces-827838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3327B933BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C976170915
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E9255222;
	Mon, 22 Sep 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvWDYbj3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5651022
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573074; cv=none; b=gdkJnux+yIQC2bVPEpXEgUFGHB604yvnwYBfT1/tdk3lINPk5YeLodOTfSLVcp8d+WwOxzQxv3ccUQiclmPe07eXmjP/8pAGvNTyS6Etw6ctYbmWbxbzaiwXagMoavWJkeMP/8cAKuOA0OfErF3eHLgVsxhSaEj2xXXQzTTFYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573074; c=relaxed/simple;
	bh=MJEFNOBSo3SKM5qiYRxxqoiLN0A/+xJxbSym8TLAOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDgC5ZLNToPQmgMk+a3/z5R9BBx9IDOI6bE4/HEFqVf89YstU98+1uNGVtD7CbWufdb06/Eik+uS/G5dU2fhqHXUItYNandso4DAaOSe8DVWLJmMoqeh6MyvEYmPK7dCew0D/TZY0scqW65IjUQHrynZNwkiH8p2oo/8CgAw03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvWDYbj3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267f15eb5d3so7040095ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573072; x=1759177872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcwSM1XGta2EiHK7PYQk1Nst2JShxKlF4k281BKxKcw=;
        b=bvWDYbj3iqME7AmlblHpwc+1M5ztBJOGASqHVlb/kZLva/72avzSR19LqgOH2RelOn
         7do6odcBZpcHxaeSOMY9yKKjO8m6vuJGhPQNuGl1MSz6SZm4av5TUNbUvXcDiTok23dq
         TXXZ0tvsHfmZqo1Beaam8sUsNnKpz/4YZOlkdeRD+VcaQNKMfDU8roMZ9yP1PI565mEL
         NFwlUp4qcAVOoJG/+ugesrgxUdPiCAalF38eZcMsr5RlCgok0as1Y+ukUX5igbaBs8w7
         LqMfKTRvpJ1VatoFKgNUD21yT3ee1HGZTtLEDCaojN5ZNBXLoFcgkEl3cL/aA0pMQvpc
         kvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573072; x=1759177872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcwSM1XGta2EiHK7PYQk1Nst2JShxKlF4k281BKxKcw=;
        b=m/SKQyb2mOFA4Oy4Woa2rctZLSahU4aXImF71zsgKXj9GtmxmavHmb7uUHaxjQ1+ff
         F4BBrZRbFYi11F9YKf4nu40wyn/blwhyUPdChjcvV3bM1n7QDGrIYJVRsywNcsyd80RZ
         CxwfK90KI772fuYacxBLzQqFUhwFxFE8flpIESqdcEA3R/AMg8Lc197VygN9nPSTfoCY
         ILgJZ72Qbdh69f9Pn6oyoHzlV0Z2fPNVq2gp6DwsTPdfRSX3zLYO2dv/v5pLMNmfHkUH
         oJs6JNo0NuHkt3yU1kPoSJvRtNgopRzsXmgZYSasBNWPEKBi6ah5dJkWcbRYR+07Y0FV
         69XA==
X-Forwarded-Encrypted: i=1; AJvYcCWH4NBgzFpwKMTrfFHlnwy+nC5PyJ+qEy/SnipYCFg3vBrfERn3UFNGpz1HecdAv0yI6CDQ8n88B+o1reo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwownuHudSI9rVuLfsWLpWmR9SoJ0H8oCBaG/9gNszO25cKc5hV
	EnOX1PU7YtJn2Wl/8c6RYdQFWlJzjMErzn2kGn/KgLGBuFn6MVdK9R0VNSeUAxKkNaIn0BI+juG
	hEmPx+K8TWS9ZlycyFYh8MTipEYHdchQ=
X-Gm-Gg: ASbGnctm/xyqRGd86j/4ZKZdq1xD3pVOCVJTBLbr2ZpNIOfdouZyU4RuJAne8OaJdZN
	RPo/QjQjxXVLS/LUdg5FdyYMxZSvjkIFW8P+so01TRi0Q6pExzZv8ADWHWmhutZa4g+IQYr164h
	WSNs1dUYi0w7WaJ7K6mqnK2XoC8ql8emeP7rRg0Espffc0ntyxswyLpuhEsXQN7jI8G5zWNkkLF
	A0pSo776/lLx7twV8VmrHycb32ZBQfbgsFL7+kZ2oMODTX/ylWbQxOQqnF3il3eNBt9H6tSgaxh
	8KGIg0TOEXeLWcfXo61VC/8Pbg==
X-Google-Smtp-Source: AGHT+IGXlLgoOnlIi0xB27xbNnE/Gt3cViOhpVvylnU7nHRlbjGJ/bgbhPyP5R4jQ61rPO6JCpcQYEV2WsDmAL4iq+E=
X-Received: by 2002:a17:902:d48f:b0:272:f27d:33bd with SMTP id
 d9443c01a7336-27cbb8b9fd0mr1155245ad.0.1758573072387; Mon, 22 Sep 2025
 13:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
In-Reply-To: <20250813-cstr-core-v15-0-c732d9223f4e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Sep 2025 22:31:00 +0200
X-Gm-Features: AS18NWB6PmBlAWRUNDsKcUzY6cTwjDnURYFePpOCqHbTRGNIsxmxdgZIFpfQAjE
Message-ID: <CANiq72nyQiHCvbTw1+njf3ZWYsK-f603iY-oox=9dMyfeCE8rg@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:45=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
>       rust: macros: reduce collections in `quote!` macro

Applied this one for the moment -- thanks everyone!

The others require a bunch of changes in linux-next.

Cheers,
Miguel

