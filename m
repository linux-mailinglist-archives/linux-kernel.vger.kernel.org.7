Return-Path: <linux-kernel+bounces-884958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE92C31923
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337EC3A4508
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4C330D34;
	Tue,  4 Nov 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1xphYpK"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39932E73E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266952; cv=none; b=LmsOQWtobMH2MlALtRbjTmstbr1083dcfLcWNV17uNQ7jEo4mgQjTzBL3s5bj9iwHSFVbralo/HB/jwYGVEPF10dFGvLsmncOoIZphl2nzESuQ+OIPyTnI+KK2V17UDMv51D5J2njaZ83FCYGmq+LDtG2VzAVIDV8iUB6Y0MqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266952; c=relaxed/simple;
	bh=zOvuDFw8E3IMboZLcv+wNk+hwh0bnRBGIEk5JfF2cuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA0C55OR5/1xtKh2rzC224ld7J///iTL+XMkju1BqA4itaLeXMEGGCEE+AfPWEnbEecX8bPMTa0aHKBKr3HiOi3TVBxaHl+lO5ztqUkTE4IIFmxZwfTrd4no+prDS1no0cSURDVa8sgHIlb1kaRR9xrw1O7EliywyYJ736+90SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1xphYpK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c52fa75cd3so4312815a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762266950; x=1762871750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOvuDFw8E3IMboZLcv+wNk+hwh0bnRBGIEk5JfF2cuE=;
        b=m1xphYpKE6hDDnSX/bgO73cESnLzldtv8//tiYH6P57octFb7Psl1F6IOVnJPmuRmQ
         gMwCeKPgrxsO/Z34rnyjCseJd3Sx2aGkn2GfYQz5kU2z6AimgEUShG9jSuuLvMMAEjO/
         54Z5N7EaxON/RMceMfuND+M290HJYtFyQM9SLC79VOsxa18NV7PxTuOSBp74MogI40ns
         sTNpgXDkdf4ysAa0Dhu53FBmI9KcwPbK8sGeW7v72iYZ1iEKaFukkvGBOQprTggZorcz
         17It+r5DbYgPG4PJHokFiBIeglTcu4QKdUb9TXKxAFMIHWnsPMJOUnO4mvE8V71gQlUe
         CjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266950; x=1762871750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOvuDFw8E3IMboZLcv+wNk+hwh0bnRBGIEk5JfF2cuE=;
        b=ZV5vL+QG4vdr6VwM1F6HEdyr0bo9qHGxcPWaXGb1mWar8vc+im7mfbcpNslOplHsvT
         fGFlydiN7wuw248UtcBGf63+8dkJeHfA77ZoUlQEFRzcOC+9D3YJYujWfz4Z5W/65s0f
         9dXeYW3SQibypeM+8JdpJ8VD8vs1GS8sv8yQR1nnCPlj9ouqojPzi2F4Omiqq6GXTr2W
         I3S6ypVAJiqE9WNVP00/XNHHaFSJ6diC4tdxu9yME5W/Sskh4NaVL3754qCwpsZb+mA5
         5gPs3qTPksQOI99wc00I72DLKG2uyiVvpp5jEZeZ+eSgQIjZad4ixZGZUvDoFKpoR7YQ
         HbKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMnr/F/e9+VeByB7CRkvrOAO4upaY3R1P8SrFeeheGie9VtmfZUlLM8sjjhyrcmNag7H509+Kk1X9vFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFRwnH+rXqleW3FFFFgBGgJcZewgx8zsedAZkx+9VYPZhYj4Z
	jpv+qdLmL/mvdNpVtOz3nDnOuzN8Ix8kXMonfMAGSGnOLRZmhT03EEyEmely0HY1fk0hLF1Fcps
	RSeUREQsPwPWguvluvA5ZrxB8TDB95pU=
X-Gm-Gg: ASbGncuxzWJcAJ72HPbDpJSkfleo8nRIZiVQ/55CYDuxcKtkgxF7zGUBrq+Vrb4lYw9
	e2O/wRctLzEuRcsJGknY+2fEDNToTwF5iFnY0DTywOMse+onMAXSQvdfe9NloaVLCCXYFbhNm+9
	AlMaT2uWdnl7mBee83bRzsbcycY6Xip7PgW0bPeh9tXcG6GssQS+AVRqD4mswwsZs/FWWmWWfGN
	Ike3bHzGmGzWYS4/26ftBqXcmR/CDK9Rhd5FyLmbvxcxBiM6yj8093Gvng2
X-Google-Smtp-Source: AGHT+IH4OCkFruz7BGxua5FpIyeWRlYQkDUOWfGwgmmxmCKwpvX6Z4Dm1zHFn09KPDIAh4UKGSRMn0mdbsaJbqb/nak=
X-Received: by 2002:a05:6808:1791:b0:44d:a99e:45c7 with SMTP id
 5614622812f47-44f95fe6b3dmr6712173b6e.61.1762266949648; Tue, 04 Nov 2025
 06:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com> <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
In-Reply-To: <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Tue, 4 Nov 2025 15:35:38 +0100
X-Gm-Features: AWmQ_bkVG2efaCRVFs-QREr4TF_4XAydKse4BHYewSEAhSr6252jH2iQIzSA-jQ
Message-ID: <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

You can use `cfg(doc)` and `cfg(doctest)` to only include parts of the
docs when running doctests (if that's what this is about).

Le mar. 4 nov. 2025 =C3=A0 15:07, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Tue, Nov 4, 2025 at 2:42=E2=80=AFPM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
> >
> > What I'm more worried about is that it might be a PITA to write. :/ But
> > maybe the core folks have an example for how this could be done cleanly
> > and in a reusable way (i.e. we don't want to duplicate the dummy list
> > creation code for every example).
>
> Using a shared module/file may be good enough, as long as the `#[path
> =3D ...] mod ...;` or `include!(...)` is hidden with `#`, i.e. as long
> as the user does not need to see that to understand the example.
>
> But, yeah, we have already a few places in the tree with fake `mod
> bindings` for doctests and things like that.
>
> Cc'ing Guillaume in case there is a better way to do this. The "have
> something applied to several parts of docs" has come up before for
> references too (the "external references map" I proposed).
>
> In any case, even if the example does not run, it is still way better
> to have it at least build instead of completely ignored, because that
> means it will not become stale.
>
> Cheers,
> Miguel

