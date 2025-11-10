Return-Path: <linux-kernel+bounces-892671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92926C45958
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC21188FC12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC432FF659;
	Mon, 10 Nov 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FND1wwhq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EA28CF6F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766218; cv=none; b=FfcoLea88SAs1ysrDSmpcRwNBvcVP3ClJtevP0loqN193M7uHjrcL1t02boZz7fCbV/+73OAJFX+A2vd4Y9VZT3f4o2q+Of3mhBfijjVH0tr9rQ4HkANuPW4FpEIrQBrqMEVXHsTD0PoxtRls63EldwPLcpqIXLvj+jdaaSjP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766218; c=relaxed/simple;
	bh=tCq206NdGSXhHhkxeyivxiNaMMGS4bP8iHd62J1xHE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uWADuisnBbnp97pDF6SAE1hv3WVcVDUR4mpON3xbuo9sCHxNG30vDOJo792cgUihfSJnaKKEypPPJbJAHwbY6JHrkT+QHa895UJyYuEQfu5ftTvlooSU7T5vOJKdPUsRvEZyPZfdqDzVa7vHU29JWu3b+BRBdwhnJpowP+fZV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FND1wwhq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso13716025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762766215; x=1763371015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DCz0mrUxydHy6qjTOATBcYgT6UozKbC5ALC3SvZaJg=;
        b=FND1wwhqnhZoLnIgASlyTbkw/PrUltyKmDwLE9+sMv3/BbYEiJFIdvYt5CxGZUSo0z
         Cxq1uYnBXDYnPmsXEkjPT/h05LpRyfozG/8IK17tzJG+qhjHgtVj60srIeK9yiRJYqlt
         sNSB4wi6ntGnr/Pj6wvrQnMVGg0UB6NeF90ICtwE0Qo8W3NCHcRknaPwKMygb2b1SOVp
         x7r5SyqaWTruibsv2a8NLmyeoLsmnSga3i272FEH59lYhuUHIZ5VA43QZxbocZR/ghGL
         u4T30tQLw5mDWNX2yCgo7O2UUfkHRo4PNqCX44ntUkOKF83w1jHKbVUhxmGwM1vgl5Yu
         EhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766215; x=1763371015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DCz0mrUxydHy6qjTOATBcYgT6UozKbC5ALC3SvZaJg=;
        b=Hv6XtcIh9WqtMqPFNAbiZK0qmrJgOJB9cGRWKd6GwOi0rpPBkJYEKCKwalZKKiTf42
         gGVPJof0177QjI9D0a+EnFD9A0IyKYZ/wR3K4zpUz/hy1w/2SDcgmrVhSwlGzzgC966L
         tEJ8jd9ctCvPOjln08pZH+idgeVY5A8aS9HUzbeeGxGLqwM1zu491fQvc+OJv6J3pgta
         KlLDE54oyIYI6aWPGeKlpcB4vJUCJgBZVmbOd1YSqbcG8/z8+pRK95PBT0DFdQfKgmHe
         scFWfff9cbARe+HXND9iyq6wRTLsdxOJ5kW0yaXOup/1bErG6eXM3Feys6xsNisO2ocP
         EvVQ==
X-Gm-Message-State: AOJu0YyImcWz8IxdcQv7FGPd1AOSGmegAgC02sqOd+NKkFVgjdT7bs9j
	6gOZkm+A4esLMq0eTNIQgcR6RFA17pR4q5hZMHn3MgFEXm1K9QeA37kfyqQOlmMzv71NumWrCU5
	JVSKky4mBpV7KzIqC+w==
X-Google-Smtp-Source: AGHT+IHJ0Wfc0oAyeXl3CzhYOpmTVuUwWYrw7MhcHKSK7WmFvUCgdXgPO3lw0ZhkywgHCWYQIR+SztdrcuiXOf0=
X-Received: from wmbjj18.prod.google.com ([2002:a05:600c:6a12:b0:46f:aa50:d716])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc7:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-477732834e3mr43391405e9.26.1762766215290;
 Mon, 10 Nov 2025 01:16:55 -0800 (PST)
Date: Mon, 10 Nov 2025 09:16:54 +0000
In-Reply-To: <20251107202603.465932-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107202603.465932-1-lyude@redhat.com>
Message-ID: <aRGthqv1efOU3Ic_@google.com>
Subject: Re: [PATCH] rust/drm/gem: Fix missing header in `Object` rustdoc
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Shankari Anand <shankari.ak0208@gmail.com>, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 07, 2025 at 03:25:56PM -0500, Lyude Paul wrote:
> Invariants should be prefixed with a # to turn it into a header.
> 
> There are no functional changes in this patch.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Applied to drm-rust-next. Thanks!

