Return-Path: <linux-kernel+bounces-802241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161FB44F58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271D25805A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4712F39A7;
	Fri,  5 Sep 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoloE0yz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D92F3635
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056779; cv=none; b=R9bGNibu3jdOyJQh48R3YVd1zk+iOQVW8iAO4CErN5fLLJa3PhBrTbwYnQutQLSE0AIVD3ZXmA7CLUacIeBl3bGOh6gxK1DWUWCyeZVGcLEfBsh4bYGiSXtOb6FlezWcBhKTDrJc8C37ptQwbHOne5vgECOUeE0g0/o1t4hPnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056779; c=relaxed/simple;
	bh=onocq6twXaoXdwX5nQirMF9Kmg6OzlgFZ2RFJQEwhPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0/r+lP39ltr2PWCZskkzzaO5wflxVOVTgihgLsfO9XOAvkObU96Ycw2Oo8u0+C/hTEhUZBgrhudAYx3vKzxjZqIHWHOyRzx4c6G3MQv7+ELSIP0hSdko/AXcyCC3jgUsvcjKodjul3C/m/gIa0mXRIS3cUWXJcQQYqt7EFRD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoloE0yz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso2069275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757056775; x=1757661575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzDQDuZjxVC6oySC+SReVx9M1aCW1txUI5kRYOyeNM8=;
        b=DoloE0yzO1xQj6c9HRZ82gXSVvTz4HrWm9yxFbSZF6YLj10vAkj1nVNZxM+KIFTyj+
         HxOSLOuBMa6vUWW87Sg2VluwSNcWw2vvU+rsFIe5EsoPDJdyeDxHTYSFJaBgWzpPRf9v
         /adRj85HqqPmdVyzGWXGklKrPe42+p41aVFYO9Mk2eLWIQ1VbbleRyaRK1Z3NKrwxTpW
         cVtkdc9zdNKASpA3EjOa1bEBtM46No7ZlF9ovmsLR5SuLbaaAM2Ak0SCq94s/Fn/AZQH
         3zLeid9uVsw2ol18BjFvFji/fLiQ91UdJVL+UTzxFHWYe+wdIwqXHMw4D/WqeFgOz+JV
         U+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056775; x=1757661575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzDQDuZjxVC6oySC+SReVx9M1aCW1txUI5kRYOyeNM8=;
        b=T0E3OutIWM3wwrtNw0a5V6PZcKqnphEWjPE2qMqd8HnvE3ch6NZKhDkBIKnX7mFlo0
         MChyCxA3PxftOwQB7WJ8BQbIcpF5P8yTMCj0fspfM6TTaJmT0QbO5AcoLgEok3ONQT6T
         wNc1hV2kPUC1W4KKTSXCNVD4dzQ2HUMkYNJxFJf9paTuT1QKrTUz0jTd4+Mw/up22WGq
         QsTZzW+FwySk35nWTAGNXZ/FnVf8uW5gfreclgr1NrDbRWk/peuF9Mc2Igr698VgtIS9
         sltOSmjJDngoY65SSJQpx9kyQTNWxxp08qfEVi1todmrAfQ18RHrhrh18EyQALvO3eWq
         k4gA==
X-Forwarded-Encrypted: i=1; AJvYcCUEnITLawN0dGNnEXXjpnSqGFCQsNBDEaDSAnyyxT+Ab6p/B4jDUWTYeak41YWdMSwhRhtJniQkzaIT9zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhdLlOUI+FQf641KCRq3uuPlk5Cq2slB+8jjrajA5xaWORPZz
	5WeK09oPKh/DjCyCtMhC4eARKsSaeRmOfC8tQ+iDjzHjdobCn6YOQrCl1+n1AF6ImWltcuiC6zm
	RwSA2OjMDs0p0PqNYvg==
X-Google-Smtp-Source: AGHT+IHMbd1cgOBQqeIHZBAcbJF/pQ0YegzqkDP/pVp9v6OrwLpQzRk9eV1m5hUFWBGmD9QF/W3bgJQ5m0Nq3FM=
X-Received: from wmqd22.prod.google.com ([2002:a05:600c:34d6:b0:45b:4777:8063])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4aa:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45b855beda0mr160151915e9.36.1757056775334;
 Fri, 05 Sep 2025 00:19:35 -0700 (PDT)
Date: Fri, 5 Sep 2025 07:19:34 +0000
In-Reply-To: <20250901202850.208116-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250901202850.208116-1-dakr@kernel.org>
Message-ID: <aLqPBqXZX7lERvoU@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, acourbot@nvidia.com, 
	daniel.almeida@collabora.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Sep 01, 2025 at 10:26:39PM +0200, Danilo Krummrich wrote:
> Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
> development, with at least Nova and (soon) Tyr already upstream. Having a
> shared tree will ease and accelerate development, since all drivers can
> consume new infrastructure in the same release cycle.
> 
> This includes infrastructure shared with other subsystem trees (e.g. Rust
> or driver-core). By consolidating in drm-rust, we avoid adding extra
> burden to drm-misc maintainers, e.g. dealing with cross-tree topic
> branches.
> 
> The drm-misc tree is not a good fit for this stage of development, since
> its documented scope is small drivers with occasional large series.
> 
> Rust drivers in development upstream, however, regularly involve large
> patch series, new infrastructure, and shared topic branches, which may
> not align well with drm-misc at this stage.
> 
> The drm-rust tree may not be a permanent solution. Once the core Rust,
> DRM, and KMS infrastructure have stabilized, drivers and infrastructure
> changes are expected to transition into drm-misc or standalone driver
> trees respectively. Until then, drm-rust provides a dedicated place to
> coordinate development without disrupting existing workflows too much.
> 
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to drm-rust-fixes. Thanks!


