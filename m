Return-Path: <linux-kernel+bounces-863219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05535BF7485
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC61883CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21669342CBA;
	Tue, 21 Oct 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+PfDRZf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627B4AEE2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059614; cv=none; b=haoPuT80nj6ENE23BeQXJFQsca1ki4D3wtjmWVZwwR/lE2JXGK7UL9Tx8q3zaHdtvF3aFmwlGc1+JVnhNY/Q9cX0rVJXGwHG1X2a91SyhMxCziaFNOzPtsY2ZGtRXAh7VDiYD/Py/8r60Z8fpqCBD7Li5zF7p0X5vce3eSHC1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059614; c=relaxed/simple;
	bh=57ydvuAT7vxuO11JefcYN70B9F3zvGHN9xiN6uZbz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+i5elvme/WCsURlqQlftygqB5ms4EHQpwLlxyLIFkS9mR5moETj1Ms83a/o80/cXOw//oPZCLb+N3aPV3VuiVpW5XGS2HtYqE+EE4KUxMFP10zOA6CikFEL7nviPETb/onbL/5q01kV7a3eb1ycnNlQ8QdTuOJ798Pb6scgqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+PfDRZf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29094f23eedso7776355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761059612; x=1761664412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57ydvuAT7vxuO11JefcYN70B9F3zvGHN9xiN6uZbz34=;
        b=J+PfDRZfyQrl9gN0jqZT86cvoa/KD8k0VQe+czqxptT+zH0wMyVL0xHMmHWx8jZXho
         bX1YEKOP75N1tK99gm50cySJHAgL4hrEqoemf1YlwSfVikmn6juCxcAjTc3QRtMBTPHi
         p8XkITS41sQi8/3CwnrU4myS3XlCXrM/6P+yxYisgAav3e/wHkuqQ6gvGpkE9calstfl
         Sx9qSFR7/U/xg2Qx7XY8THl2MIGigW/joLCs9owXaACk735wS5gvcjrIXIqjj64zloyR
         8KsjhxPG4+dTpSFUaSKJm3s+8JapdKUFl/MxH8hv5QXitFMCVRRntYF3grIvE7i9nktl
         Z+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059612; x=1761664412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57ydvuAT7vxuO11JefcYN70B9F3zvGHN9xiN6uZbz34=;
        b=F3lkFKma8o5BklOfSbwme6E22n38KteKFuzkbmza1XB2GlbOUFRMgh5/BtEU4GdJfw
         8tLlvwoj8T+Am34T2nNMpQCEWtZtICtHq7ggsctDRMLWWDdxSBkre1oM2PCCHgcq5LLp
         z234uVZ6IaRcFVXfXQqIiXNzjRDrOcQ/UXVAHdZLGYKHZY8FFq5xJUR+rJ72rQm9kAgO
         cMZBaYXWNmfbM0KSJXAA1JLEYfAI5K5qGYi9eGgwztgIfytsHL8tEitUlcKTnHNC4Duw
         RhFeANY0kFYyvvy1BsW07bQ7qmxz9UCRGnASbz8Ghol9xKR7zv/oaZuIg2Hy64NNiZUN
         CHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBNKzD7lI8aqBZLgLjIXnHi240MfPH0w/g5aEgse6V0wsDUjWBRP/KmtP43HD90pKjVfmt126N50MLddU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDiogfFB+bKSw1ZskPl54rYd5dEFkepLHzjUcarf+nsfgQc0m
	qSrEA/ouDkjUYTNyZH2bj5WnIj+JlEX31iBttLxgI3u4enCwI+0Thzmx/pk8X+cWP+H2KqMWTtv
	ukfZ/OyYHBvswilNwniEeSkulf7gjrwU=
X-Gm-Gg: ASbGnctO4828XjQipFT1BOrGasNtO1u4GWwd94nX/6iSKkYXsvkzX2Q6IPO5aLpO1x0
	n1coqpAwZjrEPxJ1VmDNrPrPrjXxvh4BPCL8hXHjUseyHBc+dbLniaZLxwfqJYlw+2waYFRdYsZ
	E3vw1hyZWeG2V2hYTAZ4ZCs+oL97ALX4IxZ4DmYU3qcBUo8Lz5Oiv7zE2kTvrFEp37ml6d8uB1X
	50h1A7tBRwPmF0UHt0aHsSu86p3cP8MDd8Jmy4jaO8h9YrecRxOHjpdWP9B66UJSzJ5/oBeGCPb
	U8t8eioc/wfwxRRDZIAkeMow0kL5rSR/awzG7nzyc44/1EcHARUJL4WGqlsWt5Ly7ujLDgo+/JJ
	f+SUQaeZ/er9A0A==
X-Google-Smtp-Source: AGHT+IGgqiWCyvNeB4hPlMOrHURKLRGVAx/W44tWY3fpOgVc0+3DFhE9hXxgb3jRu16vu0k1lq4PNekfLfhW94/L/b0=
X-Received: by 2002:a17:903:1a0b:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-292d3e50f14mr22906285ad.2.1761059612469; Tue, 21 Oct 2025
 08:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com> <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
 <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
 <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org> <CANiq72=eOYk=WM5xfMkHj-REYjedYiYNakVvfto-AUL5E0O8qA@mail.gmail.com>
 <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
In-Reply-To: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 17:13:20 +0200
X-Gm-Features: AS18NWCXx7ypRBqMiH9LNo1SlX1iEiuxCpYwgdy8Fb6LtbgnqAlrqPRp8MG7hQ0
Message-ID: <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com, 
	daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I'm not even sure we want that necessarily. I'd probably go for just docu=
menting
> that the value will be clamped to 0 <=3D value <=3D MAX_UDELAY_MS plus an=
 internal
> pr_debug!().
>
> This way the function can also explicitly used in cases where the driver =
isn't
> sure whether the value is in range and use it without duplicating the cla=
mp
> logic that the function already does internally anyways.

That would mean we cannot catch bugs in the common case where I would
expect callers to know what the delay range is.

i.e. if they aren't sure what the value is, then I would prefer they
clamp it explicitly on the callee side (or we provide an explicitly
clamped version if it is a common case, but it seems to me runtime
values are already the minority).

i.e. EB is useful because it allows us to catch bugs. If we remove the
EB, then it means things are more ambiguous and thus bugs cannot be
easily be caught anymore because one can actually rely on the
behavior.

Cheers,
Miguel

