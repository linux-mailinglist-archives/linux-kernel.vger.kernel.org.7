Return-Path: <linux-kernel+bounces-863149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316ECBF71DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E51419A0099
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A333CEAA;
	Tue, 21 Oct 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZw5XuY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566733B978
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057592; cv=none; b=IyJ6rFWvZps8hU+41vGdsLVoA8zgFrP+lAXrpdP4fm6L7cDPgo4pK+bQA7yUkt4g0IR4FEBAgW3mYhIsWg7/zpX7XyQcyUO1zSOisRCIGJAJxby1vHD/XZJNM6xYifnQxS57h/KdcfHohMvPam17OWFefBXgOoVL6YggY3ZCZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057592; c=relaxed/simple;
	bh=AF0MYSRO7xir5V+2SJ3IRYQ9BPELsaow//THttJ29N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyLqWDmkCGyiZWpZwaofgmWQnHavJVm4EQln7KzLvbUXMzC1gECh1RkhtSkTTKtWysn1fUAWsREjoAI1guDoqsoCOSDYkaSGHg8yIKTVGpyiuTNY/NzzXKgQPV9NIctQZxH6B/mz3LBpKJLc3YcqMtfqVoaHxKr+Ik/hjArZ6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZw5XuY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-79cf7fd45afso567482b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761057590; x=1761662390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF0MYSRO7xir5V+2SJ3IRYQ9BPELsaow//THttJ29N8=;
        b=YkZw5XuYQ2/vufj94Av+7xiwm8K67g7X1Tl6eEX2dauQKufAYP4Iv96GOwVKe3vxGC
         8wT+80NbIb0t+4+0ULmRrR13mOsuFIAQrD2O3KyCoEAkVvbL1VfeJ3v/icEP/X0dm40W
         cD2CQHJo3pd+Zll+lEaMJzA27Ry/lW+oKw9uxOay2gHlO+WrOOF616G8KR44S60IcuJW
         5aj4M/5l3oFiebWd3N1Q1dLPXI8K2j6d+o1j2MK6RkvH+MBiz0nOdh87kyXpDZ9xicXF
         L0GKmm6KEdrrK0Rq5Y4MEOSnc+uBOIxKh/e6Jo1iSjb8R3pTEDdr3tyU3URhW8YvFm9o
         1LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057590; x=1761662390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF0MYSRO7xir5V+2SJ3IRYQ9BPELsaow//THttJ29N8=;
        b=SMgbvEeoJXLhQqweTX1iDDxtRvmRdXZvC7XWpxiI86/6N/Xszbrfa6obSm0x3VL8NQ
         W1E2eY3Qe2vXZHch0HVTbRJfM+w2ZdMdP8lblOLMo5P/4qkPQ7l77JDElyPTstU8oweP
         tWNjrd1zQvrFMNiUOvae2wT9URpkDNMIxglLlCwU4Lpw3WxFKliolxdna73WQhEC71Nh
         yCWMRDsQM/gj1bXyipfEGZahTngnq1aASSDmKEl6P7o9ZhaYcso9DY7Si46rV4FyDLjN
         56sIeShEcW7rKtFnqfOhP4Tunlq8pg+lqX8K0QP9tCYKRuAjNNZAZePoXUSUkEHmoBrk
         UPMg==
X-Forwarded-Encrypted: i=1; AJvYcCWlJK+OWBJcnti1D12ZZkvH9Dk4YOWr/8BPiD1cfhGpJ0KF9XRVgpNXDBqieVT4mCOeLqytgSFBnuu4fSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcYBPTb4my415aZdZ2HFAcV/cTegWbk1zH3/HlzchWL57Q3jU
	eMK7X+a1WZg6n5q1ueCAfN7+D6mdRosEhCa6c4CuBzqRuaFO5rqlrhI+8bYH9zZKXQl3AoU6/Xq
	s91g/n0AoTXIaAbM2QOjSrsIfyaJB2gE=
X-Gm-Gg: ASbGncvfkUo0val2JztLInGpsnZ5y4B3cxEpiokOeoGhz3trD5KIyWLRZsCEG91aoSm
	m3TVZIDm0eeSEWwLF6xYcttnzRuOLGeJ0UjW2UgIx24+Sim4TpjW+0K7uUSD6PGmNzbrsGn/1tD
	dNNshtLTCjJIS2ei+YBWQrbODH0P6O5UHroesWVETGxk3wpmrnfFIUePdem1zhqZHJMjXyi4CiJ
	HGWn3LxR2/Inr8R7jrgyqPlU52Dhh8m297cInWXeEygOb+7LEHnQOcUHu2tos2uggOHGS6HOv0S
	xppwUp7DloKWbHaBBE8J44wEvq+fLarilbkO9Vi/cJTpX6e/f93O4DPRWbGMe0eSIlH4ARMbW40
	/K4k=
X-Google-Smtp-Source: AGHT+IFYHUluW54cUyhVulkbdkNZXZcDhPPHb7nZCkyHBnuovoADLLoGyusmRAq0qT9arioxt5XtO9ouHB3a6Feskkc=
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-292d3fb7f47mr22829165ad.7.1761057590537; Tue, 21 Oct 2025
 07:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com> <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
In-Reply-To: <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 16:39:37 +0200
X-Gm-Features: AS18NWCeaZrSN8h8sg6KXRqo4acP85HkWOrqgIecvvyChp-G1McnQ_eQXJMkkg8
Message-ID: <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com, 
	daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> However, if we want to consider it an error if an out of range value is g=
iven,
> we should just return a Result. (A simple out of range condition, that ca=
n be
> handled by the user easily shouldn't result into a potential WARN()).

I think most callers that will hit this are just buggy, and C is EB
(or worse, UB) as well here, so `Result` isn't great.

I agree that a compile-time one is best, since many (most?) cases will
be constants anyway, so we should definitely have that and avoid
calling the runtime one as much as possible.

Now, for runtime values, since random drivers will call this with
possibly computed values based on who knows what, a warn once may be
too much. A debug assert instead would be less risky if it makes
people more comfortable.

Cheers,
Miguel

