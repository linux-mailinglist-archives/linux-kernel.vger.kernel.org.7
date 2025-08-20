Return-Path: <linux-kernel+bounces-778075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0AB2E0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58155B662B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E622DEA9E;
	Wed, 20 Aug 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAbY8fe8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70021322522
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702945; cv=none; b=a9wAyM+7gF340dt5fqMN8cbaRRXjH2KTZ43WNIFTT5FMcuRbj8KssV6qTKGLtlGLrFmAomSjVunhcWJwpaormma9+p1BN/DWvkQ94FXIjYIRPruQIKu8AxQV6rLEqdSYkao1q0BCzILwA/bFoMi7U7RjnuJmaZQt702WEvpx5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702945; c=relaxed/simple;
	bh=13FUGJW12CjFo+iuPJUPd57hxgV9qCf1JSMfv2fgBBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3g2+7RuwLYj1ofcF57XsgbNxhPGguC5q9g8keA1/o5JYf+6+mkUDr8NoHgVbIiylI1IRD5nYVW/4L5/u4trqCBtch0slD5Yk9Q7FLHZc8Ovc/hiV1KQhAt55RnSER8ftXSh1zwE2Kq1FUvqXEAEThnCANQ8+EYqnKo0qmhfqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAbY8fe8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266a1e87so48163a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755702943; x=1756307743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQGbBV6UkGThqaYqD2VruRxdB/oQfuxLhj4lvw4NUg=;
        b=BAbY8fe8vUD4tZmgf16I7et6IvdjCRoipuPdW3FpoU56l4Hdnwk9h8iWdFZ4x3Iy1Y
         9va9+WytawnsJ4WKlUxSAN2Cpu6R02tIX0FEqD5JzkHrjJiV6tMSFfQ0hMOkMi20Tg/E
         nz66T2cIUDXfaOpHECqUDWjGpRh56E/fATuP3T7n0oGcUH949nf4XYwS3kuglx2xcsIA
         9IyizZH8DuK3lPus5LQ/6/S9J6ZNR8lQLEBQuIFuxCy/OeIHNyikFnbCxdCJi8N3Hlyv
         2PtAwEdcpAgpwmqS6fBdr4rWrNLm+ZE1/efwO3Jx23wGjMxAX5EyGpOfRzF5yxi3FvT6
         ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702943; x=1756307743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQGbBV6UkGThqaYqD2VruRxdB/oQfuxLhj4lvw4NUg=;
        b=GwVeGC2QEABWOJiDixLaOr9nXU0yKlJg1jGK9qwSfV1qfHlTYL38Ve6fbhBRmwPdIq
         pb5Bu1w5QvySPL6smIICJXId0iKkFKo8wHifBPzIiNUUZm5ITRnBzkZg9Ii/ZJSnPsMB
         3Z7ZE7fgARXB94tWrzB6tEq3xDJ/v+iJuvrpd89pP+84WdDv5WBJlvyUK2v9QdShqyif
         ffJXFOfET0KVsvW4WU8ybisXRkkKkEQ0ggPAXCou+yDyD3MNyPdAT1tEPyV8oa0dWtNg
         hpzyRI3e9bQf0LHUU4YskH0Tjdd/4IMZxVjI/Hxp8DJTDAW/h0csjxLmTmQ1uS+kBzX1
         DLNA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4CHlfV198PlJQENw97lwTj1I2xPVKZaEV2z5NBjQhtQ/JpGVJZKQccFMaxUVcUQC+tFK5eBBhZ37sxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVJfS6D96apGGYk32DsW75V/5zBjN6eiKcrCZNuwo+B/0mEVx
	kYzvxgInHctl1V8tvagehv3I0Yel0LHQBsl/ZjoW5kUiPH4fO7V+U4PYbTJcFRi9MUuRuOxIIxp
	FHh1eLQ==
X-Google-Smtp-Source: AGHT+IE9iGk/sRCwAsdU6VesQcmBbVaZpEaJBxTmZ5Qv6evdaW0ytYvrMeubSC1IlHptd/SUUkon+wRAZeA=
X-Received: from pjg11.prod.google.com ([2002:a17:90b:3f4b:b0:31f:f3:f8c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558c:b0:321:cfd5:3f95
 with SMTP id 98e67ed59e1d1-324e1425be1mr4887657a91.35.1755702942762; Wed, 20
 Aug 2025 08:15:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:15:41 -0700
In-Reply-To: <aKXFKaJuZZTbAbJD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com> <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
 <aKXFKaJuZZTbAbJD@google.com>
Message-ID: <aKXmnRTBzNklwdYk@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 20, 2025, Sean Christopherson wrote:
> On Wed, Aug 20, 2025, Mark Brown wrote:
> > On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> > > Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> > > of the same name defined by linux/overflow.h.  Note, overflow.h's version
> > > takes a type as the input, whereas the harness's version takes a variable!
> > 
> > This patch is in -next and is causing widespread breakage in the
> > selftests -next on at least arm and arm64 due to:
> > 
> > make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> > 
> > ...
> > 
> > In file included from test-pcmtest-driver.c:10:
> > ../kselftest_harness.h:59:10: fatal error: linux/overflow.h: No such file or directory
> >    59 | #include <linux/overflow.h>
> >       |          ^~~~~~~~~~~~~~~~~~
> > compilation terminated.
> 
> Argh, many selftests don't add tools/include to their include path.  The least
> awful thing I can think of is to go with a minimal fix to avoid the collision.
> AFAICT, nothing outside of kselftest_harness.h uses is_signed_type(), so this
> shouldn't cause a different flavor of breakage?

I force-pushed a straight rename.  Please holler if that somehow still breaks
builds.

[1/1] selftests: harness: Rename is_signed_type() to avoid collision with overflow.h
      https://github.com/kvm-x86/linux/commit/dce1b33ed743

