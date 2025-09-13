Return-Path: <linux-kernel+bounces-815334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28694B562F2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD97F561774
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442B260566;
	Sat, 13 Sep 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aicbIYdG"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5852566E9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757795868; cv=none; b=mLkDCgXU3yFkB4ahCxKPjRSqAfY1ngvI+pAyMBvwSd56G9UxPXW2GmRGw57T1lW3fHVf8AGPoDxH82BlXjpsGVxDnaMEoxyv2M8UGTbDgrTLLGM1U6qnCpjPb+NH19V19a4254ZxvgBeb92VZ2b/xAkvRAUXp9usUjs1AxNcOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757795868; c=relaxed/simple;
	bh=mATTaO6ztWHtL31tz3fa3XmKHBNOJGaadXz3sI1bEqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcYNr7M9XXp/YXrQ41V6YctFDZobpIdJsiCcxAT4X51hs3u/5LU5GtXgY+9ufVMW4yTOBmB3mETg/+pUSKnuJbntm3Ib4Gxxw7Z2EPMJhvQOyrMOwUj4XMPysfU/9aYxCFsI4zuenwjxQgv0TFoR/Ldxs+vt+45iX90IxtmYLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aicbIYdG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cb6c57a16so3550865ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757795866; x=1758400666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mATTaO6ztWHtL31tz3fa3XmKHBNOJGaadXz3sI1bEqM=;
        b=aicbIYdGiH8VNGqjOQzBkUyuHU8uFGws2VWGJQo0fZQx21hdpG9qIAfStWBdFrpmL0
         8W7cdIixRIwsWlocIhQJTUCvcLyJxux58ol0HRg8FnKduEmrl+MFQHFAALG1uKf9mWrL
         s6zoeo4zZ5SYRWHV9HYQaUZ397KIQQew0IQ/ZOh0Vk+/VBoukNXETU/CEw2qCsOSL3jx
         e+giTYBZdUjJJ6/qDd37w6bTDdjnzSSfklLPmF8S1TMBP6LDgO+5pJ3vmuD+/QnX/7Ag
         ov5bQu0jKpW2wj13XsWULvhp9GYR4YxmN52RIfvP01Rvh5dKlfRuHxwyCTTw7QFBcPWF
         nDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757795866; x=1758400666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mATTaO6ztWHtL31tz3fa3XmKHBNOJGaadXz3sI1bEqM=;
        b=YRXpZBOYoXmpK+on6+D4x7KzLcrKMrgm1sIMpk74ob9vrpoya5vQgXhzLfbMldNT4W
         iUbpVsgGyRgiAswPRk/3CsHu01RxjXjKFt99Z/lh+C5XN7wVRNEZBnxVYoKeqnJIGmhR
         6Wdc6hVwzY8WQnw82ST/OfZwuDbkJRBVIBm4aKHW8N8IrmTlf0RT5YvO7PLK7MIyxuAf
         +xxYM7wuYWLYW8MTOIo8JA0Rn0MFRR+dlpL+Ny/CvZ6b/PGYnYuP38kONEEuOENNo3g7
         OZ7j6B/u+cbvPbgxNqvBMpJ1aLfsYG0i9m+iTzLtW7ph2dS/UstYZh/UkAMJUj9c7NQW
         SnuA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6fDWz8s+sP5Umig56tcBoYJtmSXUR4g4s213V+/YWy/65v+PAucKcL3Xbe9qxHWkf+Ss5A5lPoG+fBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOa0NTNrgHWEsFf07xSuVmZC5OQKM6aaAOK1YqLH1lqW2mq7W
	xC2gCZixrK9yakpCM2MjAh2t2XH4ArMm6Chp/fPp94NWC/ptrFbgsUHXbnHodbbdvjPLyEPcReX
	xoRw28gP0O7PNgrMjpkLHPQHRccXJnS0=
X-Gm-Gg: ASbGncux7ou5IldZkLri5f/G1BO7DCcsKk24hpgznkqeN+dSo6v3oA5Z7s7Iez1+cwn
	Y+kSoW/dSNLoeOUNPwfSwf1k9nMY/Qy8dAl5g7ZWnf5HUP/moXYh3iHbIEGybrNfxqr+mt+NUbC
	xN37qWiNsOmHPvyPSkBwbIsdLnZ5dd4XBzirlFFWZyTxX2D7ptTn0M/etK7sUP6eaROt4YjmsOp
	0VxSr+kEpuKVkV3IXowETQ4L5auFhicLxdIOpExj2cdx44mvGLA+gAZKmsMEBVZ/TBJX0DyGjeX
	DJBL8VEJpj2xJifIYtnB4k0pN8z53OmWWKg4
X-Google-Smtp-Source: AGHT+IHrVkKejELNksEXUkmKRimQGTe3Ad5+7htwK4BUNxGJGqqmJCijjdcznEeh8fuxUViY+RIMf0xL/mdPT29M8js=
X-Received: by 2002:a17:902:ce87:b0:261:500a:5742 with SMTP id
 d9443c01a7336-261500a594fmr14779775ad.10.1757795866176; Sat, 13 Sep 2025
 13:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com> <e1755470-587b-4a43-8171-3d031b7fb4f4@kernel.org>
 <DCPYQNZG1OJK.2EE4JWJAROK57@nvidia.com> <ce74db34-77bc-4207-94c8-6e0580189448@kernel.org>
 <DCQ074EMFNIK.1OJLWJXWZLDXZ@nvidia.com> <20250913010226.GA1478480@joelbox2>
 <DCRPJKD0UHDQ.IOWSOB2IK06E@kernel.org> <20250913171357.GA1551194@joelbox2>
In-Reply-To: <20250913171357.GA1551194@joelbox2>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Sep 2025 22:37:34 +0200
X-Gm-Features: AS18NWCCjEi2nGimzvlQTTclneuWdDWNwA3S6j0YpJVAggEoL-8q-kmCadYD0Hg
Message-ID: <CANiq72n50MaMXeWdwvVOEQd3YEHbDRqeeRzbdY8hPnePtq-hnw@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] gpu: nova-core: move GSP boot code to a
 dedicated method
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 7:14=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> I am not alone in that opinion.

Hmm... I am not sure how to read this.

> This should be first-class in a (systems) language, built into
> the language itself?

I would suggest taking a look at our website and the links there (like
issue #2) -- what we are doing upstream Rust is documented.

(Danilo gave you a direct link, but I mention it this way because
there are a lot of things going on, and it is worth a look and perhaps
you may find something interesting you could help with).

> except to satisfy paranoia

Using unsafe code everywhere (or introducing unsoundness or UB for
convenience) would defeat much of the Rust for Linux exercise.

Cheers,
Miguel

