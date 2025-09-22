Return-Path: <linux-kernel+bounces-827253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91795B9148D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145823AEB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D8309DDF;
	Mon, 22 Sep 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN6KJ0ON"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAC7081C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546281; cv=none; b=dvtYC9IX70qdKptSTY4NguDezRye8JuaHWcn9LPbv+LRW6zEm7+bt1KEKEyMBuZb3r947w3iDEaRVtcIDnJQZQyScgldegmaReI4JDYHigfLf6KJhHbnzNdHykTpOXlcrPKMy9vAA7t58TfqNS4WpuJnrJsWQ3hzLigchxg2izc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546281; c=relaxed/simple;
	bh=FMG5xfh2EwtBQe8CnKPSbpNIhMPeeyV6In//RbskC8o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tSNMWIRA8iR2BOL1OiceQ+FqjGpfCmCmcr00CTW5nBMrOYYD0zVT1mpOJFtexWUgqysYoyDY+YWwC9drkPOjoc9TUatic+buigXbGfJVnExct3luE87PdorkDwHJVi2JncuRhoqVHYROy1gN+XFA5w1e6yAzW8rQaHhLXCFJ4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN6KJ0ON; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so518239f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758546277; x=1759151077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iap9wqIfUNfzgRsabkOWwLbHyEDjwXlweruKw/9NanY=;
        b=bN6KJ0ONyqwRgYW0XeyLUggf8aA+XVmQYu4P8Y1lnGTWmvLiKnzzAg8CbAg9kxusvI
         URhwZFdD4skhm4lt6i4xG62L8CyGoegLX0dOqVooDySDQ+s85wPb4A2kKtNkvISuRGkz
         lXp58WfpLMg5IBjIaMAIw5NQu6t56VUmvwq1l10p15cM5wWpyFmMGoV3WytI390pA52P
         O2zwZBjkqcEjxhxo6Cd0pJxdjVmFoxm7qXxpax3o6fbRcJBVIj9yJbfrSZSDc6a6CzPt
         eeP67vAHpKrABGnIAG1eqTjAioTdZWk8p+QAvQRXALySsuympnCtlU3Oj98KptsuDVlI
         nBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546277; x=1759151077;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iap9wqIfUNfzgRsabkOWwLbHyEDjwXlweruKw/9NanY=;
        b=iXZ10fNdBSfOgxEEU6RpeL6jsmI4e0927ZcTVIOo8R7+3emiNLllOw96KYtZpX3+1N
         F6GpgOqO/wVtRSMHLc5GhjLlff6snu2WKi2NqpL+gDjTADNmbFuN/cFCvVLAvzn6w9rC
         OwVJOcdwjZkcPDbxn1UbMQvZNaLSxtRLUuyT5UOY2tusnkEohGHY1jXfSfP7DYfQQzHj
         8HjzMwHSW17SLJjXQg8z7TFnacstc7aO13EDQknUJvvWy3gBtl2qSq/wXpd3H8rkVYXd
         Gkhp3RnMR6uLi+ZbOEvgBNxyWMEark1HafXVBtEJLy1klB2D6Qnj/EkA42XGKPfEgfUA
         GSYw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1G6WqQiGHLyo77Nh0z8Rp6Guq9de3KlPt5J3XGsyI+/VhZTk5o5CsCEY+aXtHzkuvoQmlZx9vy9c01g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXS8rI5mjnXC4YhaKGPEGIm+AWMRC36BbLmLJKRzf110yrIWT
	vhdXgU1tnIMB+BiHEl48yucMuMF4uvu5YaCEnvI1lk2z3K5U+H1BDjdnTJbTGU/n7YVyQ2Z01Sl
	zMJtv4Y9Pcg==
X-Google-Smtp-Source: AGHT+IG4/C+rN4qaU8lkxJCMdTPbpFXd+PfBKwy+XEmnl90zNWLAtfCNII+uZuRAKVlJ4dArjk/TBRTMhKKd
X-Received: from wmbdr20.prod.google.com ([2002:a05:600c:6094:b0:45d:e232:8a66])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2dc9:b0:3ec:ddf7:41b4
 with SMTP id ffacd0b85a97d-3ee87e9c87amr11321359f8f.62.1758546277574; Mon, 22
 Sep 2025 06:04:37 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:04:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922130427.2904977-1-abarnas@google.com>
Subject: [PATCH v2 0/2] arm64: modules: Reject loading of malformed modules
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is version two of the patches I previously posted here:

  v1: https://lore.kernel.org/all/20250919122321.946462-1-abarnas@google.co=
m/

Changes:
  * Renamed the parameter `is_module` to `skip_dry_run` in scs_patch()
  * Moved comments to module_finalize() and improve justification
  * Instead of rejecting all modules with callback, reject those with cb
    pointing outside core kernel text
  * Replace -EPERM to -ENOEXEC when rejecting modules with incorrect cb
  * Fix missing return in apply_alternatives_module() placeholder

Best regards
Adrian

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>

Adrian Barna=C5=9B (2):
  arch: arm64: Fail module loading if dynamic SCS patching fails
  arch: arm64: Reject modules with internal alternative callbacks

 arch/arm64/include/asm/alternative.h |  7 +++++--
 arch/arm64/include/asm/scs.h         |  2 +-
 arch/arm64/kernel/alternative.c      | 19 ++++++++++++-------
 arch/arm64/kernel/module.c           | 21 +++++++++++++++++----
 arch/arm64/kernel/pi/map_kernel.c    |  2 +-
 arch/arm64/kernel/pi/patch-scs.c     | 10 ++++++----
 arch/arm64/kernel/pi/pi.h            |  2 +-
 7 files changed, 43 insertions(+), 20 deletions(-)

--=20
2.51.0.534.gc79095c0ca-goog


