Return-Path: <linux-kernel+bounces-864455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850ABFAD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E7484DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E73305078;
	Wed, 22 Oct 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VWLxkLz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1A304BB3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120876; cv=none; b=eS7tZCFz/hLINH60kutI4+OJlpaLz/r/D0WMw9fyuNHJXBFhjD1KqPZxKg8TYT+/FUX6DnpT52PIW0FSIbLOUMHS6wevp4tficDdaLFsvOPnCSsCV7dFQevPE8qGdSY97lrjLZ5CiyDCVphllkGByn9bF7IVicjjcLK5WJw30w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120876; c=relaxed/simple;
	bh=nDmcqom4nRH1kg8OrqhgJ/APXOzAvqbtVdtI9YTYb/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dvrHR2nVD+pVMlonaF+skDWqQ3WBvMtRguo/tk75VgtTM2fFgl2EcUXa0GPAv3+I5500kXFQvvYxIbGAqRo7W1nfEjOFV36YeGmtqVdduDfHZm12fjdoCGFA5PYzZNOKTXpan+bKK/ALeK8HW23i4vP3OH1KHioLRPDWBxP/aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VWLxkLz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so72735195e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761120873; x=1761725673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ogsn3X1mobn8/e1uiGkS9XQJsz3R6ivSIjiDXFm3+Q=;
        b=1VWLxkLzd0y2N/vipoDX6gubUhI1J9Uq+NBzcVpmjU45fBdPQ8wI7HsotLqO/dEe5u
         GxAfjYXzFhEgPDw6EhCb4UqLLTXUDoYJW7SwvkJp6z9u51+lmtEUJ8UMk4H43XMUZJjq
         TM7udf/bDj1U2q8zPZel4UBB4olVLrWlnAiTjky8ov21Nv2uFzNJwGpsgtSbcdBoyyth
         88zi6VAQZEH7KwLwnVRcPSKQjqX23KnmpDQZ8pwzbk5ry6Ypu4tCEqtp5TBtXeJ6kW6N
         3KZcNHsOR8lKcqQhu0Atc1DWEvcyL6O3aRVi0a8wDuV1el91WWO8Guo702K483Qb8jkP
         YG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120873; x=1761725673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ogsn3X1mobn8/e1uiGkS9XQJsz3R6ivSIjiDXFm3+Q=;
        b=b6PfFD8u9oPxltR/0CoiR+QNUiK8DatMfbTDPUoouIEo38pU5+rCQKJaOwn7U2tYm8
         ZPDt21ZXdGG/efhAx5Fy77oxwFOV6KfFLiDTxjtJq5Xu8qQQTY5aZ8GRUeugDR5BHlUm
         yyVTizjCMRMkQUw0jRaH7eaH8S9PR6UpVYOlJgkhW4/L34okrD9oE+rqkxlpW7HKUl0U
         bYGpLHjMN5YmERPtU+3E+v/XtDJ+CPQZ0YfzFvqSJMOWvLt5FTJZ77mYFbqp8KRuhjNt
         G/uwmSSkZ7jGKj+OUjavETvyBcgM0qiWMqBhOyu6GwMRMXkmlmbhdfBSuqCIsT0wyZmu
         BT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGZlNuxe9z5+ifKGU2bFv4rQsmqRg40UKtOxfg/ytCKCH1TCUag1O+qVqjxjYyHm699x3mLb175FDLA5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSC4DZk3cHr/uRxLFHeiadz5P0akBkeBeqFuj9ZyB8PxrxuEYD
	xusSvQqUz+CsuEztHFtTDRtB+9tTNiKF+gCI8M6FLeYNlvUC0B6OWEfFFvQzYVeB7/hHqBnejPg
	C+SaOneNziCOg7eUogg==
X-Google-Smtp-Source: AGHT+IHVymDPMVFRxtz+pEpsqCDA+1l2F++eBCPDtyYxS79P5clFYGmutl6mMG3GyLc2Iqc0bUnGJy61wcbICgU=
X-Received: from wmwr3.prod.google.com ([2002:a05:600d:8383:b0:46e:1f9e:6471])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b03:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-47117906a72mr141554885e9.26.1761120872959;
 Wed, 22 Oct 2025 01:14:32 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:14:31 +0000
In-Reply-To: <25717cdeac76376fbcf7ba10a1b2e855800d3778.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210955.2813186-1-lyude@redhat.com> <20251016210955.2813186-3-lyude@redhat.com>
 <aPJDGqsRFzuARlgP@google.com> <25717cdeac76376fbcf7ba10a1b2e855800d3778.camel@redhat.com>
Message-ID: <aPiSZ_CGLD4o755q@google.com>
Subject: Re: [PATCH v4 2/9] rust/drm: Add gem::impl_aref_for_gem_obj!
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina+kernel@asahilina.net>, Shankari Anand <shankari.ak0208@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 01:33:00PM -0400, Lyude Paul wrote:
> On Fri, 2025-10-17 at 13:22 +0000, Alice Ryhl wrote:
> > 1. Annotated with #[macro_export]
> > 2. Export with `pub use impl_aref_for_gem_obj`
> 
> I assume you meant pub(crate) here? (Since we don't really want to expose
> impl_aref_for_gem_object! to users outside of the drm crate).

We will probably need it to be pub later when we split up kernel, but
feel free to put pub(crate).

Alice

