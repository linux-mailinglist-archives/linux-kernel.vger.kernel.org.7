Return-Path: <linux-kernel+bounces-877853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA0C1F326
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9431E3A3EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50733F387;
	Thu, 30 Oct 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUEwHxGO"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84F2848B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815413; cv=none; b=YDoNCkju+cQWDO8BqD/RVH3OSl9qUz1H2MPap4u40QoFdQokTbWQYJh820Y+aQjiAJCByf5K1IlOCj4rG0TDSRrf2uwSxPaWeE7nmyD2HyIz9sgkhkfQFvLH2xzVZiwuW9dyjWrYHxsjsKsOo6sBG8NPhFmyooqPYzdQBCI0wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815413; c=relaxed/simple;
	bh=ixhG+PRVCdRnZp3Hg/4I8LgGvCEzE7KLm5I/e839XBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ7xElGmgHMYa0C9Hdh76UrWdXvt3/IvAht2DFfK1INuwb1E9YjpsctpLqFcCi1pnpmwwpL6PFisfLm7Kc36hUP5ucG9TpISe+zbEuWn/fRoGQteO3ggORbmxUwRBE+2jyGV8Tf5ovLkZ8Z1fYjTBTY3lN6eXhizs8Uis2PnVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUEwHxGO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a2852819a8so793054b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761815408; x=1762420208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzW+i3uSQPTIyj+Ag6YFq0ylKZC2QeNYLUsRfJSSEWg=;
        b=OUEwHxGOE+VcJYoTJVsuhun6pGo/WJkN6FlzIVGw/v1/YEtfwHStXgeayO6PYVdRBH
         oI9SUZtKRz7xo9uasNukQpjGXidxJcXAqb1EaX1K1tF8bD+yBNBSYpiBNFnAI7Tc1M/p
         YfcSTx91NXbTlHLC07MxsIYpIBAK3YF0/1NVAUapEsfGdRe0GaTjOdqE9Gp7R5g1tkD9
         lUrkKuBqYQxdUznQkLkI5leI+biJ1OPmAMTYKxTiqkyaFTYxxxRVELo8gxj/sCGIfGMf
         WT5oi1SZgi6LZGZiqJLZwm3GGE5MA0TlAV6MbmavRoQNbN6kwr1WPcOhyVLjyDmICDd5
         IrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815408; x=1762420208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzW+i3uSQPTIyj+Ag6YFq0ylKZC2QeNYLUsRfJSSEWg=;
        b=wBVLXVHuGshSMO3GP3sRcpdYWFM8hLxLeJffteHqBNoeVsqq/Y37QWHrSWJwf8v+cj
         rypRM73knphFox/pecJSqSxayqupcVAj/gruV8DjfqC8JlDZhkJ4wuQPNmbmOov1lG/a
         As1HhWREF6gFL//50lqd/7mj9O+Igw2kIIXmKqlGbN52z5GOY0kV7Kkrocr+2BvMAXgt
         psEqTCmFCbZh6tG/NUkac7DXvfUJ0wHv3ibgWNFwHZzOayX33YbJiLQ4LxtzszmyqU4V
         WoVtnvPDXlfsmUOKC401yhVQ375phYLrMjtt+RIqsoG5NOJdY3hOfqiFYQRbq3QTHj5z
         9IiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiZwTo9+4Z2K+du9VmZ8eDh2qm8wO+HW7H26U3Pq4Tcjbpv1DjHoy+r7EXyeXJFVYf79cC331t40oFNPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTae9QjJI1rOOb7BIL7Fe1hAKMXCeRp/RgqAR1Nx5nW94VlmHK
	LcUUiY/g9iebTOo9wvY/aZjok8MiCRFlfTtMQwuPNuj9yEt8c/VGzwPI
X-Gm-Gg: ASbGnctv6bz6mTourc0e7cQ8FrZDJmFkvyYjeAdlsYWLe9VuSZjXKu10w3DXKDybghU
	zrgGXqhD2T5KEjLTTr803NMyaQmubzwxjaU14nv7P8rxX5kXYUZ/7/e8PRQD87Vrt0RWNbWx7HT
	9kyJ5ibYzJBZ/R/yzhTNMoidBWADaW7hw53W4M9xWj6qSYVdIS1XQyo7kNc3qqDb8Tsh0eAXYzl
	Smi9G0IGEPaavR+rBb8l6Hvjpm2DO3h5KHzWa1e6PvMCl7DaOjwcLQMGIgwIXmam9V25UAbsuad
	RfFO4KSEt3iRnK1bOoM3P0t6g6XWY9sGjcVkI2ENnh+8Mk3DGWtbGgC13Wc8uLuyxdgBBfKccqQ
	nkMVYdEc7NITzWV2ogrHtUbfnrNiMSzgF3/9NMZ7HXKqN2XC8tO7BqWSGq4zBjRY/WSHwEKpTTv
	xDNXEp1mFNbUjA
X-Google-Smtp-Source: AGHT+IEg4g4gEZCGcb4tXOH2lPJfVirKyqlOxOw3/QY2ei5Z6cCi9UsIX0h19mA8E8I4kU4y19rifQ==
X-Received: by 2002:a17:902:ced2:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-294def36255mr75467535ad.49.1761815407715;
        Thu, 30 Oct 2025 02:10:07 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:68ad:2e67:289c:5dac:46fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0827fsm177414165ad.31.2025.10.30.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:10:07 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:39:59 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: hpa@zytor.com, bp@alien8.de, dave.hansen@linux.intel.com,
	david.kaplan@amd.com, i.shihao.999@gmail.com, james.morse@arm.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, reinette.chatre@intel.com, tglx@linutronix.de
Subject: Re: [PATCH] x86 :kernel :rethook: fix possbile memory corruption
Message-ID: <aQMrZyDxb09R8KPl@fedora>
References: <20251025114830.295042-1-i.shihao.999@gmail.com>
 <6D2E5C3A-451C-40B6-9A03-3FBD552B933F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6D2E5C3A-451C-40B6-9A03-3FBD552B933F@zytor.com>


> Please don't submit a patch where you are explicitly saying you are blindly following a tool and don't actually understand the code.
>
> If you did understand the code, or the architecture, you would know that the ss field is embedded in a larger pointer-sized field.

Hi Peter

Well thanks for correcting me .Thank you so much for your time.
I regret not thoroughly investigating this matter.appreciate your
feedback and if there is anything  i could do please let me know i am
ready to improve and also sorry for the late response .

best regards,
shi hao


