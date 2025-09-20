Return-Path: <linux-kernel+bounces-825807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA1B8CDB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D825A4E0ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E6306B06;
	Sat, 20 Sep 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3IVZQezj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0C30648E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758388356; cv=none; b=IPmTvWnDRV+2a9VU6kayWgPqPLMi8bzA7JayV1oVUY9BSNgYmpVQW5rcRMdp+35/TuG6O+Lt1OSxjp7Z66h3VffLRO0pP+5JmbiUmlbstWNMLhbKyS72c+DHKTxSXhQSq1dGxJVz0NU1cKmlEumb9srxfEdUA0dEOtbAKKbN6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758388356; c=relaxed/simple;
	bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIKNpL3sBEv7c48HrNnmfE3sw0ADtIrK1+MgkOVy0HpSzR/vaX0X6kujju0ZaUKU0WjWP3UXZZtQN7lGFHt+qdOkhQLNMjX7BrdA6+vOIOku+AQL8A3Lml0erd+fOFoijCnWCQIEYt+rbGGBGHsmURRBs6BW7wt0MBYnzlgn/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3IVZQezj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso1519370f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758388353; x=1758993153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
        b=3IVZQezjkGRGY6jnZJUt2i+7WB3R0jDFvJ7S3CpqjSTX0Go0KM4dgBQaC5qeaLM7SZ
         MZBOmRWse7OxHunxwEPMleKziE8OpjqcsTBIFIxckSMSeiGfl8VsnlNDRedpN4cWYrcM
         63JobxUMPd9Ef2Fl/w8VvBA+lm3xJVXO9cueYXQLd9IEFQ6K/HM6axlSV5PG3+/7zabB
         lHRSh2NHXozM1z4/MIpktKncf6rHZ8cHoZT2+HSXtMLajrVoOvztL1PBd51XkXNQs6EP
         46qB+neSN+QgJ07PjdIAEdajmKfXNbjW4FNJT5ulbl+YMeoogNGxYcy/T1WSFKEGZsq1
         tLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758388353; x=1758993153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
        b=TPvUy33WlJbUFov+uXFWdrU0yoPK2sFXaIC7UvU6AgVb6XqUMqMwBrPHx74/lOwX/7
         Jw0ewThLrkkjI7RdcCCJRGb19Xkdex9lRJR4W0W5SctnuftZkevescEAMpdIEHE3L0KC
         HsrUtl0VLzJAIeNpbOAWuDv5rg8T+KOipl5L3mnxUufqAlbSKgJNLdOgNvsaDs/NKUEK
         6eBA6TjiTbmTRFp8MUA1Bv3AoQTOsDmxK1czeREutWwwMLLr/O8F70e7kzdizXDGe5d6
         FhGkgckl6kYaMl2zjssVVTbnrmRrs90uqh5Wi89xw/3gJsjzJ3ocDc7BpkVF1OAI0BtK
         kBPw==
X-Forwarded-Encrypted: i=1; AJvYcCWeAcgo505VsNSb1B/7jUwoNJA4M7pguxjdFctDAmCyqISyvqwehADidO9sfa9N5/05sCRbVIZzqJosGM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xY0lLI3541Om8OoOW5w3GerAKHdLnP0v7w5JRnNYuHw6+lMZ
	qWt49YXWpSFutjr/C0zZyhGe+c4rUsk2EDHQwBTE5hV7dymf2gmIUSIk8EvAS/JnJBFlNpNTXwk
	mKUddlTCJIm3RVFvS8LzIP+4DGRADMs8SE2VgogKW
X-Gm-Gg: ASbGncv7lDqYP3dPSyBadOL5Moty+xGfWv6kY6bThaoKqa/1TcjdVx6lwXMXruCAmuz
	5FFs5rynSY/aRu/W5OFKgcO5osDBnD8/xg3Y+ApHWnPHDmIy6nzjx7JNImRKZt+UNFD+1lZFsge
	njkKbkxPC/a/W6jImbBujfozazOK5rtD+ge1hw9Nn0ISn6PZx/IsLyVpjTY8q8VmGO7b4jQ3ODx
	9SgblI=
X-Google-Smtp-Source: AGHT+IF+4bGibPipIgcJxYKVfn8BssHq8357Z0KdCsFz2M+fcQoYEotuvWkwJadILn9AOtmYWB0Q/o9Ht+aVSBuXwCM=
X-Received: by 2002:a05:6000:2c03:b0:3ee:2ae2:3f35 with SMTP id
 ffacd0b85a97d-3ee7bad118cmr5460258f8f.6.1758388352843; Sat, 20 Sep 2025
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com> <aMG6JVMcMxVuX7De@tardis-2.local>
 <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com> <175834480479.4354.6269916774389395049@lazor>
In-Reply-To: <175834480479.4354.6269916774389395049@lazor>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 20 Sep 2025 19:12:17 +0200
X-Gm-Features: AS18NWDvOSD7Ew9WoF-qENluBOtHGPEWpUP8mLuio2luAr2ur7aLvfUzGRJxJH0
Message-ID: <CAH5fLgib2a7UK0cYqy1cM6h_OZDMWf+JX+KpXXCJNTZchyfP5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
To: Stephen Boyd <sboyd@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:06=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Daniel Almeida (2025-09-10 11:47:30)
> > Hi Boqun,
> >
> > > On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
> > >> From: Alice Ryhl <aliceryhl@google.com>
> > >>
> > >> These traits are required for drivers to embed the Clk type in their=
 own
> > >> data structures because driver data structures are usually required =
to
> > >> be Send. See e.g. [1] for the kind of workaround that drivers curren=
tly
> > >> need due to lacking this annotation.
> > >>
> > >> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3=
dc9da95@collabora.com/ [1]
> > >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > >> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > >> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> > >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > >
> > > This tag list looks a bit weird to me. Why is there a SoB from you
> > > before Alice's SoB? At least for the usage I'm familiar with, outside
> > > the case of Co-developed-bys, multiple SoBs is used for recording how
> > > the patches are routed. For example, if I have a patch that has my So=
B
> > > and I send it to you, you queue in your tree and then send out to oth=
er
> > > maintainers for merging, in general you would put your SoB after mine=
 in
> > > that case. But I don't think that's case here? Alice's patch has only
> > > her SoB:
> > >
> > > https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48=
d023320eb8@google.com/
> > >
> > > What's the intention of the SoB tag here?
> > >
> > > Otherwise the patch looks good to me. If we get the tag list resolved=
,
> > > feel free to add:
> > >
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > >
> > > Regards,
> > > Boqun
> > >
> >
> > You have to include your SOB when submitting patches from others.
> >
> > This is something I tend to forget often, so I made sure it was there. =
The
> > order may be indeed off though.
>
> Yes the order is wrong. The first SoB should be the commit author.

One optoin is to just land the original patch:
https://lore.kernel.org/all/20250904-clk-send-sync-v1-1-48d023320eb8@google=
.com/

Alice

