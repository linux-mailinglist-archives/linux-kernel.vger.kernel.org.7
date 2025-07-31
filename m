Return-Path: <linux-kernel+bounces-752458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE8B175C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8082A1C22F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1B262FD0;
	Thu, 31 Jul 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxFLxl4l"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45174101EE;
	Thu, 31 Jul 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984222; cv=none; b=h5qOkDX4CkuFk/bSvOM0GLYH4v4TxkraywL9BDN7zDm9NM3cDdI6W9qdzSRhmbuNbXwi/zCjA70+uvJsFlFw0/f9zkMiBd7MoNmWClrPxHf7jfnJZgZZPHcDOrMW+b9xXgD519zwlIfK6rq3AWi0NA1VwR9xqo6V5JvlY4OWK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984222; c=relaxed/simple;
	bh=ciTmizI2WlEA1n5c6/anXG8Ito9bRhalcMJLPsvPgPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHt1eZqE4ItounMOxw1kBB5PLw0Fw/Mi5l53AWgITdwacY+ehlksH931nYZT+8zWGmIYkysezwfaCzi1+bgGg9sxlvwI5qqjWrMqa2hB73PFN9XrBNBaYu8lRP/Qn8J8z31hS0Y6BQhEKWKz4iV+J3ZrCizoIOEylRZLYsdi5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxFLxl4l; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso742996a91.2;
        Thu, 31 Jul 2025 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753984219; x=1754589019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciTmizI2WlEA1n5c6/anXG8Ito9bRhalcMJLPsvPgPQ=;
        b=BxFLxl4lqR3BoKf2nq6lwhgkPq9AnXX7DzEfNCZxGj5fE177F8A0xXELvgxQ35zlYN
         mfrO6D/pmfgTltssSG+1p/4kwB6Iu5hLiZ5dzdCthhiduiZ/ILbe9uH9pC5gNlqIuoWr
         s2m150pDkFOIvMzKaom+/ajScHYOU0LtlH1IiOwRFj1hMxgqtmulg/ZpxKgBs9rHhSR5
         4MWg9nEEaQyHn3pwl/2/W2s9oNFriB0XxFkCjDKhAu33mvZPKu99ozOhP2EiqhyMwI66
         9ZEky9pOBItvmFM8DcHMoK/oTPLpfsTgyz3d3p+ZhoPs3byiDmIUYiW6tfBrbkunSYlO
         Hv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753984219; x=1754589019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciTmizI2WlEA1n5c6/anXG8Ito9bRhalcMJLPsvPgPQ=;
        b=hsdM6h/YkbV9a/tmrbSt/IFJADu7S5M4VokSoEXTFMFDyXXTTvWhbmzsOuicEUAQ4n
         X0gkNGMAnw3Ji6the2IgrlNieu4Jici4uCVAvFStWxhK1DIfI5X76CQaIbtiTC7yb7Ct
         PG35nXjMROCkHkjcICrN0dXptZNneA7H1Uy4Nbx/ghjQZSdceo8xAf5syQQI/bDOk5wb
         arTQcZ1K/sY1FqXfW6EQmaT6v6OfZhGdSGPPzWrKAfriSsjBGJvkV33XpeHy1905UuNb
         EuyQ4eeGvV2ywS/DacBvX0V2JYE6GCJRK+8e8MSV54HNcF6BJXANJaY9KPI6QjfHQBLF
         E5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp3U54QxvKGNaBB98UoMqClDrUdC7wrjwLoaPyX2G8cf0UNG6ovSbwukoMUJhzc5aV/HZtEDprpEOr2AQSm3Q=@vger.kernel.org, AJvYcCWKl8cYMp0JzoUsq/D5vOCkI/R2rCTA0rpYfnATH5vO4CNPIxZZrg0/PZv/uYpz8A4b9KvRkPq/4r4inQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ivq8p33LbSxCzcVDVgnUOquMvopfYiC6i+/wVl0ly00IOo5d
	IlSUUMC8Fze2GrQ4lKCagor+OUW7cKbw5oqSYewCKJsHrfDfegrOO5PnVggxnaFY8itg2E2D4GJ
	aZUUTCCK7VwP8m9RKN40rTuL/ZH3DM9A=
X-Gm-Gg: ASbGncuj8p4/Q7Nw7/68i2WNzP8CVKaHEjhmqwk+KX8pZHqI6rwKY4tbGplMwkxYF1c
	JeBCzxyxcdIdJFhlOR7cBBwv96Y9epJv2iXioF8s2fejBMDazvYuKiPb0BY2kv2Qxn2NJ4zRDzU
	OUpBcgXhuRS3LfD4EZEdvNgYNRw26eHki6vwG+wdsfa57k1T+Ls+zw/gHyxIwfmJeE1CtL9q0pl
	/mmvA==
X-Google-Smtp-Source: AGHT+IGj/6SSzd0OejxO85oRV7C+7WZ/rwfxlxSe5Oq2i4hIiPR1YEQmt6REP13C8bYcFdlG6R86xzXULByJZnMpKo4=
X-Received: by 2002:a17:90b:1dcb:b0:31e:cee1:c5e1 with SMTP id
 98e67ed59e1d1-31f5ea68b04mr10567137a91.30.1753984219409; Thu, 31 Jul 2025
 10:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
 <CAPRMd3n-1nx6BnL=OtrrJqS1gCxYAw2wSaHUQ19174Y=ShqO6g@mail.gmail.com>
 <f958ac81-c092-4958-a61a-d30c8389f431@kernel.org> <CAPRMd3kvemvtEM4976+MGRbLJV+4X8Hwvodc0q8+0jtgT_V3Rg@mail.gmail.com>
 <DBQBRYBV9YVN.35REJ1DIA06L7@kernel.org>
In-Reply-To: <DBQBRYBV9YVN.35REJ1DIA06L7@kernel.org>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Thu, 31 Jul 2025 23:20:00 +0530
X-Gm-Features: Ac12FXzfVmkjG7UFUVLEUpJBUn-BoyQdS8LwOpRtR1o5vCT2M2vD2pXQ2H9Mr8U
Message-ID: <CAPRMd3nQSyXB+K2Fcs7WJJmtY2F7sm8tFOD1PrkQyHgND=Ju1w@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Jul 31, 2025 at 14:54 UTC, Danilo Krummrich wrote:
>
> Ok, did you send the other ones already? I don't see them anywhere.

The commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted
to sync::aref ") refers to the patch where ARef and AlwaysRefCounted
were moved into a different file. [1]
To update the call-sites accordingly, I was advised to split the
changes by subsystem so each patch could be reviewed and acked by the
respective maintainers. [2]
These patches are all part of that same effort, although they aren't
shown as a formal series since the subject lines vary to reflect the
specific files they touch. [3] [4] [5] [6] [7]

> NIT: Please don't top post. [1]

> [1] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-i=
nterleaved-replies-in-email-discussions

Apologies, I=E2=80=99ll make sure to follow the interleaved style.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
[2] https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4=
i=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
[3] https://lore.kernel.org/rust-for-linux/20250716090712.809750-1-shankari=
.ak0208@gmail.com/
[4] https://lore.kernel.org/rust-for-linux/20250716091158.812860-1-shankari=
.ak0208@gmail.com/
[5] https://lore.kernel.org/rust-for-linux/20250716091827.816971-1-shankari=
.ak0208@gmail.com/
[6] https://lore.kernel.org/rust-for-linux/20250717072724.14602-1-shankari.=
ak0208@gmail.com/
[7] https://lore.kernel.org/rust-for-linux/20250717073108.14943-1-shankari.=
ak0208@gmail.com/



On Thu, Jul 31, 2025 at 8:24=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Thu Jul 31, 2025 at 3:59 PM CEST, Shankari Anand wrote:
> >> Where is the rest of the series?
> > So actually it's spread across various subsystems. I had given the
> > notation (2/7) to have a count of the patches under the same effort.
> > Apologies for the misinterpretation.
> > But yes, recently Miguel suggested discontinuing using the notation
> > but as I had sent the patch long back, I didn't resend it.
> >
> > If it is confusing, then I'll resend it without the series notation.
> > But, this is basically a standalone patch.
>
> Ok, did you send the other ones already? I don't see them anywhere.
>
> NIT: Please don't top post. [1]
>
> [1] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-i=
nterleaved-replies-in-email-discussions

