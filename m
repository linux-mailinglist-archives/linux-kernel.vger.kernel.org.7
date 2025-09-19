Return-Path: <linux-kernel+bounces-824509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE4B896E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE01E16D97D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF3112A1;
	Fri, 19 Sep 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqsibLdN"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1931064A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284613; cv=none; b=Z2nxTMaeIEZwdoXVCMRs5MorCiq+wDXJruCgvkIwkuFqTq07WENnr4Ced3PyNCEqh3CFMmx6+cVXxOFrmpVIvsw4EceVbr7wpJXeJBItF9SKTqqiFb8sW3gSxlc4vn+aiSdl6nbVfjJZ1qXJupmw4rMP45ZVygjz0Sg0DYjovNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284613; c=relaxed/simple;
	bh=jXcK6QPtQGjl7VenT+gJTDdp0iH9IwkSJVpdyKWpWgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qUDZOZkvQaXFox14ZtGLxxpbwcZCbv3syNxgFmih84Fin557QBSFGOa3b+hM5x55mscDN+enRFsdZgUP3IKvYq4lagPNmoM67TO333GpmYfx2dqOpY65zxr6pB9AlBTwcMEBK1Q7lNDEkDIEC2lIlGpgjlbpvqYsCjUAFrmwiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqsibLdN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so24959205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758284610; x=1758889410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gN1SHadTytzDX2xnmPwJ+DG1JmBdmDMrYOUijkOrwgE=;
        b=wqsibLdNJxW8QhxZSIgPItFnAaDQzwpaS2YjBYbYI/ewj8RpR6FYgmVtEP47U8Ve34
         iPr6HWZqtfiCuAWOpmIXq/6hDNWIU7lmQ8QF8WEXto50rUlADihL1CPbINDKIgq06cW2
         IVgJWgBTGXgk2YZmqXAV7geX5jm6d3PAyNlk7Kdi1AJBSIYkfShq02fEI2l27fkymly1
         mTU7Z31hJx9WDbZnRHJ2nwEqZeo4ioqLmioWlLIM8NcP1Tck5D7MOyEbR9onk3aYL2rd
         8K7YseAPgI0TIFxcH8c3pNmDHDFnVscmA5ArK6z0SEO5YOl/u0syHxJv1Pc/VIrEWB4v
         4a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284610; x=1758889410;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN1SHadTytzDX2xnmPwJ+DG1JmBdmDMrYOUijkOrwgE=;
        b=P6P5NVbOngcifty4t9BIforf+uftG+7QfQ+Ys6uqRBW9e+FGbIPEwtlZ0lCkeYWW59
         KypLTqCvKSg44b4lpczaZpk4vkeclaNeNtfhkrMpWKGLuZOiI1yfT8XkQIem5aFgAVzL
         0CxJvLahDT1vJaDlmI3vKhCQzAHElhh9LzMMUi749LS9iqjJpaZz+ORsr8uZwGg2HEdg
         niagrYb6Tgr5OWXuN2pSUED3tU3MYrOo3GIJRhUZHbuRMSUDf1Fgzj0z/tfilqRXmvBo
         cppjWFnS7h5js4mH+4P1ez2/8Q2X3stfpAHvMn2rfnYVjacokCF9SJljiDDrUjFQa39a
         h7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWSft91Dy5/Iq38TYhzev3BWY9KhyAi3bBo131VwGKQdP7JR2XOaTDG/u1F7vHot59GWM1LzdjTr/W0ZXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC9NmniOZeTgi7iyZwgTY/6G9eOoCzK6MFRApgl2cbQVKKFgL
	NwruxQDO2YG8zZgyKABsCM0yukgPji0WGMXs8Ir6nN2JPFGpPVQewuaKwqLJ5oO841NVDYB8Qig
	WmGK5HaWYlQ==
X-Google-Smtp-Source: AGHT+IEQ2BelZBee6Xq8HqG6PdmZYpVVhUtJSdBsldDA1DgWhRzBiM7FdRccvX4b8xCNlWRnu3NYYRZNVwo+
X-Received: from wmbay30.prod.google.com ([2002:a05:600c:1e1e:b0:45b:83ff:5274])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b05:b0:45f:2cd5:507c
 with SMTP id 5b1f17b1804b1-467ebda8e6emr25752215e9.36.1758284610250; Fri, 19
 Sep 2025 05:23:30 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:23:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919122321.946462-1-abarnas@google.com>
Subject: [PATCH 0/2] arm64: modules: Reject loading of malformed modules
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Here are a couple of patches to reject the loading of malformed modules
on arm64 when the SCS patching is only partially applied or we detect
an alternative callback function used in the module text.

The SCS issue is largely theoretical. The code currently performs
a "dry-run" (which we remove), and leave module code as-is if failed.
However the latter issue was reported to crash the kernel at [1].

Patches based on v6.17-rc1.

Thanks,
Adrian

[1] https://lore.kernel.org/all/20250807072700.348514-1-fanqincui@163.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>

Adrian Barna=C5=9B (2):
  arch: arm64: Fail module loading if dynamic SCS patching fails
  arch: arm64: Reject modules with internal alternative callbacks

 arch/arm64/include/asm/alternative.h |  4 ++--
 arch/arm64/include/asm/scs.h         |  2 +-
 arch/arm64/kernel/alternative.c      | 15 ++++++++++-----
 arch/arm64/kernel/module.c           | 14 ++++++++++----
 arch/arm64/kernel/pi/map_kernel.c    |  2 +-
 arch/arm64/kernel/pi/patch-scs.c     | 15 +++++++++++----
 arch/arm64/kernel/pi/pi.h            |  2 +-
 7 files changed, 36 insertions(+), 18 deletions(-)

--=20
2.51.0.534.gc79095c0ca-goog


