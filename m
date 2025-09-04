Return-Path: <linux-kernel+bounces-800539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E8B43902
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948671C27A06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B02F998D;
	Thu,  4 Sep 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IX0C3vNk"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B713B5AE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982428; cv=none; b=ESdTNAGxPVJ7az2S/CVo2Rcj0m4A7fY5vaNblx+jM0UB9JE29nTTH9ac9xRU1GQQgU0KL4ShqscrjBKkRxZJQUxpUr4wRxTJJgokFdPIyoWdHGGybCxF9QbpmcWxdTHSkkHzzeMtnmjp15HSspz1vJfd5jHg41nbbWA4p7/RDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982428; c=relaxed/simple;
	bh=K35TYVQdmCqeD7Q3E8OIUOVLCEHOxk1ZzvVD9CcXM0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYQE2uV500KkrcmfhKdS8xqU3VpwzW8sOolXhMe4d4p1L8vijSaYI+9ixcDlqWoRBTvK6wzuzjzux+DXOFZ9wZU3M14Pj4fOJKBgKAfkH9s7G3+bQCKOJjRvv35pCdQLVOOmZ4t5maztJIDYnUMfClv36sHnUtl79EnBrCrCvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IX0C3vNk; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so507348f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756982425; x=1757587225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6y2QOBZu14x36SZiIQblNfOse9Z30SqsU6mw32en+A=;
        b=IX0C3vNkyF7wS+NVZHzQZdQsK/4MIrU68d9uFFm0UA3rjBeAORNyPm0dDYEUNJeWIA
         yVizZij6kvIZvan6Ssjd/jRhNB0agwwW4l7utVO4UoRYQM+QPSRJjCMW5OcTy0hmIlay
         okZTyTI/169C3jTozGkwFVVYMzzVYPN8A1NrqDt4ajeMgYBDXFMeBfR9E6/MYCN5+uaZ
         IJycZ+N9Kcucf94GWXelN0NU6hNAaMoXJOGGmOnK50SVlHY+gVD8FT+jqRYV2eDAgKf+
         n1WNPLVTPyo5XgIhCeOLuumdbxgQ9OqM9S/vAlAvk+kpVH8ziWlGYHgaYvq8ZjUIvK94
         qxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982425; x=1757587225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6y2QOBZu14x36SZiIQblNfOse9Z30SqsU6mw32en+A=;
        b=p9H90sE7GTpzED5p1ZlCsdU92uTaHMj1ud8eB7/GYTCOSHLKAkXoIlmcl3MKRi0ore
         TPMIhLMIQR5LrHXZqpIT0Pk1go8UkyhzKUXfcqMgDtuiy5RQHZ9d8+W1KsFlGuAQjZ0h
         1mOlNBmKmJF/E4Mimbijcvm4eilB4ZM3Kr2VT2hHX6l3jv5cQEMvggaCfZ57dEIleg3a
         xLMTfIHtm5p9e5DlTOW8zv6piEQarQeUYsdctRAptsudcivuh0q9nzrAkwKEIM7XHA9I
         6/P3OmRYQ2/tlGbu98kWfj4yRuWoW9i7COReaKCDh4J6RmufuAGIPOei5ijhGj6lHepV
         MPpw==
X-Forwarded-Encrypted: i=1; AJvYcCWyuqQZN7qYVXl61TQZw2SNepJ5RJlg79/bMTTJ1KLDAejIbaQOd0B8Lt973pH7LC+KLEoFWzBM8jcJ6Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO77oXRu/PRmYPkgbPpw413Sn8GC7zISb1d2WInygObBAG2l6z
	/ZsgYR1yhGW2C8FzPgSroIeJ2kUznI7YUD1As/MtPEKLeN0N31oNiwXMtLuirE8trgwUZsZO7b7
	2yS4HOxvsl+OYUOPMmQ==
X-Google-Smtp-Source: AGHT+IF9yvAHvKVOXXpEFHka86WFsWc+ojWObCx+xIgC+kdLnrHsvwSPcYjH86gfddOM2J9YtQ9wDriAn1Gd+jI=
X-Received: from wrbfu17.prod.google.com ([2002:a05:6000:25f1:b0:3e1:aeb6:bd24])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420c:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3d6212b9f09mr13611267f8f.63.1756982425153;
 Thu, 04 Sep 2025 03:40:25 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:40:24 +0000
In-Reply-To: <20250901202850.208116-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250901202850.208116-1-dakr@kernel.org>
Message-ID: <aLlsmNzp_KardLUt@google.com>
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
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..1cd6597c7f1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
>  F:	Documentation/gpu/
>  F:	drivers/gpu/drm/
>  F:	drivers/gpu/vga/
> -F:	rust/kernel/drm/
>  F:	include/drm/drm
>  F:	include/linux/vga*
>  F:	include/uapi/drm/
> @@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
>  X:	drivers/gpu/drm/tegra/
>  X:	drivers/gpu/drm/xe/
>  
> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +S:	Supported
> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html

It looks like the right path is:
https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-rust.html

Alice

