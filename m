Return-Path: <linux-kernel+bounces-795877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A8B3F8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE0516A57F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1192E8E1F;
	Tue,  2 Sep 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6oC9Khp"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C72E7F1E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802373; cv=none; b=pLztoY5o75RYjsO/SKT8pRcR3qfuQ0zGuJCLL3nAsFFdwngDqX8gF5XD0TLiagAUY0jbAD0hhMwM+XEFl1WyBH2mQyhLzUnN+FHn5oebJKJ4I6mJk+aOV4OogaIKEUwmV/9QnIiSzFkJX0brh3dlkzfO2PBabsUAYwpWOVbfG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802373; c=relaxed/simple;
	bh=koiejtjJlpqtXarBrORI6mw99ruaARcVA9rvYu437aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LWMI3UjS7VYzL23Euv43nNM72+MNyGEh1moQgGiRK2Aoj8RglTkzIHEMQGbdQD78/XZPxqowopRRS5yz2s/QlB1RuCZRL464cuyPKjVE9gB0DqZ1lZY+Y041zV0jXhfWm6oKL+7sq3gavTZEPnd11jQdoeeo/AG157HpuDHATE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6oC9Khp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso30490115e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802371; x=1757407171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JP1QA+RZ7uMNnI6suXZ0G9wwt/IV21LJWjZMZ+MqgQ0=;
        b=h6oC9KhpiwUUKYCOzmbv56LayJz0NqSQ6IwUPLc7kAcxc/HFDWeuM5B7neAtzmFAT1
         dXY3QambcGqKShVt+hEy0TQ3tZHnefmj5QXRbBj7nrtWe82mBJv7+G9GBc5/WQvUj95A
         pEMg078/8EpQCu8HzkC/lEu7Mj4piAl0JWeMjih6kdnlbHv/XqroJLAElYG93UkDrHld
         q8ByyP819w6JW6ziguS4SOo6wi2dYD8KG3kT+51B9zBozUABgwn0UNR3KMamwqspdlpz
         XEgUGy9sVL5PCrgbMpY+VzJWtKRpWY+k/XQzlJcciVxAvCSbXDcWTNtRJEdwV675ltms
         asqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802371; x=1757407171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP1QA+RZ7uMNnI6suXZ0G9wwt/IV21LJWjZMZ+MqgQ0=;
        b=G5xPwkc8zSvFyL2pQI/u79TZhXhuXr11NWeAthHyMXox0/8UZx3nFoyZRgn5Wy78cB
         IwRT0KCQlvTOgQkACMM2IYZxe4XOc2H1UpBTjC2/8cFG98QHsGBst9EG48BwDK1jlL07
         5PC1kq6Gz5APBwp/B2t26W8l52GrgW6nLwCtTPBmQydhPiRoYVzHTCFDBjJ43XpRDfQP
         A/hvizTj5EsThafDrFVZnwgVcG0ESN3FP27emslBqiqXCatY+LXsYlPWqMuyhKpEc06l
         FgWmS+CVib7ZlegVoc5mWYuIYMpnNZnLUSNBzmPtEXgmQwaxdagQUI21C79z7Z25R7ao
         yHlA==
X-Forwarded-Encrypted: i=1; AJvYcCXx0eKy8SOkcMCcL5xQpYuTxo6UHuw/Qxjs04VlpUINXl+fwql1w6G/tQha1u8bB2v4MLCQs8se5Y9iOL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgg19hEmSJEtSgVDtE+/kOfOFYQJYgCDDr2+dEbMUezd4cjkox
	G89usccljHOJFAIOqu4cAAp4pNQRVtvFbMz1aB7psqQTtzwBK8vm1IVjIY1tsoM2sRTYGRwSuI9
	rMQ64pN3Vo5ogZl5mug==
X-Google-Smtp-Source: AGHT+IEJiBZvawIN2RgaGyQWpOpWEL1rOV3VDXt/kFR5FQk24WrYF7J15eKsT4qagQtBygvpi7Ak/mP13MhKKiw=
X-Received: from wmti8.prod.google.com ([2002:a05:600c:8b88:b0:45b:732e:5a16])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f94:b0:45b:772b:12b9 with SMTP id 5b1f17b1804b1-45b855336dcmr90049625e9.15.1756802370679;
 Tue, 02 Sep 2025 01:39:30 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:39:29 +0000
In-Reply-To: <20250901202850.208116-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250901202850.208116-1-dakr@kernel.org>
Message-ID: <aLatQY1ea3on4n8I@google.com>
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

Acked-by: Alice Ryhl <aliceryhl@google.com>

