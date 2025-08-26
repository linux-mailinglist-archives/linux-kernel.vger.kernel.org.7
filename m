Return-Path: <linux-kernel+bounces-786526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29270B35AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B9361285
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87E2FAC05;
	Tue, 26 Aug 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSOg0lkx"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9472BFC8F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206903; cv=none; b=M5mJWuZ/xMW81CR+QIAEqrcAYe9L2c1h4F1oX2qQSKThxON7ufbnyJ+rpgZXwMb9yfTnSrsRhpqkRYf7xXkxmXOiznjy2WoQBytMYV69mhkOpA07KlPz95wOtbOoWJy3zcKQLVRJv5lz/fz4ZChKr8aXCrdVteBmGudkRDSmakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206903; c=relaxed/simple;
	bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTIfdgS4YcsRC4wlcTPEcqk9XKRQvII8HjwOg6V1JNYCJctIrd1mi2dG7YWINYsDN5HdUSDKHOElO4UlMK0bru06UVI6q+S+LQcW4z/j7uJ4txj0KZvMPT346gIjUUq2T4lpEHFLESRtbeDBYNy01xixatBFv+0oTlnGOhe7e9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSOg0lkx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70dd5de762cso2649706d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756206900; x=1756811700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
        b=CSOg0lkxGipwRoQW3kixw3ZBftbGV1OQTGFBVjxdBLmoDN8vzwiBx4y5uzWFtknz82
         7qdpSR0hJpM8aFaCMSPfQ1KpnyVcfJYqQlfPBnnbebzEZD6B5QiHUhxDKrB+2vdD+orH
         y8gqP78OnBLPXa1tf7dcO8AuClfSS7JFqIEmlR5BRNTnCgS45+B4rXzHT2fFP6reMBiO
         bouB6aVu6Fc6L9xtKzepXcDi1aNRIUFOxjsGS79dTnd7IGv56bhaAQ0eWjlllCm1sDtc
         PF1xJPCMr8B9KYS6Y1h1sZSDOl8zxWC1Fw5FAcwsEzEfQS9YPXRPMja0NUX0uPXKyJbC
         aDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206900; x=1756811700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
        b=nVuCB5k+ZuPaWHfxbbzoMUhCAoRPOQCliHRZiea4S/Fzu/z8gbMhaMtVZIM2C3aJ+n
         NlNI5xxzXLrWvRaiesUq8q3bJg0CK5Pnxrrm95hstgq7AQTSTyR9NhZqM4SYJYcn4Qjx
         PUTEUOE553FSfibkJxtgfL0gliCm8hkYngcw9jqcklFBCyQWi4TejHOajNEba2HuWFI2
         n3Jov/xoc7WSpYCbU7+XS9k2JwnXCZsG0ojyVYZCE5gYsAKlyj6NeEZZ/Hpo/FxuuB3S
         jU9am5C7ZbI4b2qgEyr4AxtHMQX3CnMoSfrLD0nygreGaBmOiP+jDeqj4Kb4SvVOQIcI
         fV3A==
X-Forwarded-Encrypted: i=1; AJvYcCV8uVfqtA2/Hh9ZfGxGILAxrheqBT+PGbGwKuMIn7HvHDjZYJQN1zt88yTJutWkQsBt2P51DckjRNRpCDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreSJbM8ASz06fUhKuAN0YyyVfTED7unw8mCrY9Fu9fX86cfdT
	JLsaqtExP3N/aVsgOUHbcSod6b1IoXwKJbMPJ38i0x+8lQoEpCaAy/eBxfbFWf4h/waRHB/QH4A
	D/YF8Xcz8IPhwkauchAsmgcsQyeqIefiYAsxd5ilu
X-Gm-Gg: ASbGncszUGWFQQSVwgwMNFuwr++yQqImk3KdjKqqUgV6rRMUgHlJAdJlu40/0ejM5Dz
	R+MIHECKqKHMnUQrL2fqgMEHsNGg4bH36Von+n4C+ymQpYHORHgjnVf4n0KrssEbM+nUupXCHds
	KXb3OyZdq/MPxDqbv++VmQZEmNqZk4SqZOPjNlKg/2kl/xLyCvUbtqWEUoNQDFwnbL+kmsjzzjh
	vr51G8EpKCvyXMyTmvldkB5o+JdAmE1kUIhnQIMTd19VOYb6CsoBK4=
X-Google-Smtp-Source: AGHT+IGipSwQ9H+9lir4i7sthp7jXgbze4rk/DAEYQJrO9h7c1f6+7P3RPCSiB/lbUAJre41WiVi6jclfFNB3YTBRpg=
X-Received: by 2002:a05:6214:20e6:b0:70d:8665:3c5b with SMTP id
 6a1803df08f44-70d970b2b0dmr209892786d6.12.1756206899995; Tue, 26 Aug 2025
 04:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <aKyT2UKmlznvN2jv@hyeyoo>
In-Reply-To: <aKyT2UKmlznvN2jv@hyeyoo>
From: Matteo Rizzo <matteorizzo@google.com>
Date: Tue, 26 Aug 2025 13:14:48 +0200
X-Gm-Features: Ac12FXyU3fT-SuKRuDR_nD8uSQNd7DGjj8J1BVXdXRtps1xhjblio7NMt2GtdbY
Message-ID: <CAHKB1wKZmp2Rpw0zry70i16-c3FVkwtb3-XpLs5P1s4eABDD=A@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Florent Revest <revest@google.com>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 18:49, Harry Yoo <harry.yoo@oracle.com> wrote:
>
> Not relevant to this patch, but just wondering if there are
> any plans for SLAB_VIRTUAL?

I'm still working on it, I hope to submit a new version upstream soon.
There are a few issues with the current version (mainly virtual memory
exhaustion) that I would like to solve first.

Matteo

