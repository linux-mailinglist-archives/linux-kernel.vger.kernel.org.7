Return-Path: <linux-kernel+bounces-859262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6EBED290
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F44E183B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14137226CF9;
	Sat, 18 Oct 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="R+2LR/ps"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A25464D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801331; cv=none; b=oVm7mhCOaesKcWEfE3Dgn2HUq9PzbmfNQi6ZGCadhzizqAcjQMZTV7QaKv0DP6zhYIUZFZE7s20wcKO/fe56L5Qx2jZGGQDxDqbgYzYy4rYQOQk5L3f2DqvH61qApTCbyTb6ga1FJHuEepftyvi9hPjeOjptTFp4NGFcXt6jC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801331; c=relaxed/simple;
	bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peb1NYwDhwdSAI9HUiusUX08R/ucQJmKXDglWDE3tcdWP6fIoL9BgBAkhnbCfW0kPlhGM8ifnZ4nehznQS1QcA1Z1haJtXeYAlpHSqaSGVI0NiKEOBFjpBSDMsr26LfbK1UUs+DOIGuOuX5RN+QJdU0p8rcKVIxS7/dGgAPJf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=R+2LR/ps; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1531588a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760801328; x=1761406128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
        b=R+2LR/psxUR8y/nMybdUNZLtDGmVeVO0lTySF+1grod7fQgCk/SLqbD+ZGw8MZfgjU
         8pvDFxV5x1GC7iREGB3Hbz/0QIY/LggFAXHZJwuR3mZO14Zs9ijl2MxCVYRyYOVdNiwL
         ZZ+bDIlbeK5aXQ8Lm3OZFOZP+uAYRO9v9ozIwTkPtEE9/FMfvN7CCRY2DpipFYhYHqiB
         Pu47SorntMYwq1f/A1Req17yif1WG+TxzmTQ2QxLcJ7NTnf4nZ/59+lW6amXi1ryIJvV
         jmSYk92kgvB6vS0Ucc7lWL69XuLedpa+kCzEm4Isv8/EqoA98U/sigh+CTbkbP7NR50T
         LguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801328; x=1761406128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
        b=gnoTPIkl9ls4hxGOIgbnobIAXDKE0pntiJJqD3jIvxaUsqtoryOtoW0W8PGbR/eLS2
         rK1eASNkWUA6cjTPszCjigAQFYfMuVx3yE2Sam7nt66RBoOhyb5UjpbvTjmGkPuBLrAk
         grsdCHB1M48pzNzz/RfrBO37OruGjfNndhN04+UV+upodk0o9SaKt/p4zt/nF8hPxaEg
         gn85ARNumzSiiF0hCYcG+OYCRNuYQ/oUegwFbaUuFfUxUw2sZWbbWGP87sIOI++QkAHI
         juGLnhjAoSb4J6GsH81PNzBHJHDyzWpVxruFsGcxcWeLLCX/As5MjCz9gb3KuVVBe2qf
         uNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKixLKfmDWF2bi2M99CkdeafqFxPaWK3bWOcMf92iu02hejU5HmnYCp9I0zRNXymrqrq3LaegDVZsEMwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfYrL8buD+kO9q3VEf6BslEm4zm2aZ3zq3J0a3WCnWnvBlQph
	sZw1G0tVP2xKrr8qxvxaRJecZQY6FUoGdJ3bHrymbbZb8aXo5RLUBx5UkwU4hQK216CdpLdVBWK
	r+k2JN0i3naKTTx9SVPMkMZ0tyTnM/DS4xsS/1zdm8Q==
X-Gm-Gg: ASbGncux71PBeuuclwskVQcdO+zngwdk9jpRvXgUQkU0Ro4c+8a3YyBGS0juZCBamEH
	y4UNIN3JG3xL5Wth2rGRBeY79Y5WH7JsfYfN92sZujqLPTQ4nfIQLoJTH0PNIbo81jlBcdsx2Rc
	5n139w8V/g88YnULhE+Pd1A5qyI8ae8gVGMWycmjP1RcyknSQ7o7opcEeaQZF8GVGkp8kMDJwVN
	+0gvT+Oo+prWqgHXAVLqd7a0ME2xxcCCwN+OQul1JPaX4nppDLl6PVwWwyIC7jaLQaH8gNDqeXR
	yQYCyd8K6GqLKrsd
X-Google-Smtp-Source: AGHT+IGD+GIZ6cxCDQx+cpZ1B+6x/CWUhSAiqtZJo+SqncV9lu3xa66p7nHm+gyAAx9koD78PZnXe2MMWr42HEQvxQw=
X-Received: by 2002:a05:6402:2713:b0:639:e5da:637e with SMTP id
 4fb4d7f45d1cf-63c1e1f212fmr6981739a12.6.1760801328092; Sat, 18 Oct 2025
 08:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <aO9ZiERHff7vQiBL@kernel.org>
 <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
In-Reply-To: <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 18 Oct 2025 11:28:11 -0400
X-Gm-Features: AS18NWC5SixWaTv6tISYyRfabBu0M2TA5NSlq-EJV7berBAV8wLpo3xmXCWe7Kw
Message-ID: <CA+CK2bA=g3r7V92NCYZDWNKPguCM5EYdroqHxEH2YxUy68iDyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > Can't we check this in __kho_preseve_order() and not duplicate the code?
>
> Yes, that is possible, I will move it in the next version.

Actually, I decided against this. The check might be expensive
depending on how sparse scratch area. Why make it even more expensive
for kho_preserve_pages() case, which might be calling
__kho_preserve_order() multiple times.

Pasha

