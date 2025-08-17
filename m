Return-Path: <linux-kernel+bounces-772493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D79B2935C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12A6208367
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF828ECF9;
	Sun, 17 Aug 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zulq9vW0"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D528E607
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438644; cv=none; b=SiwYqter+hTAyCMrGxaHjzoP5BgMSyEEvw1eJZi1oHPytzXUtoASWrjRH2WSYJtBY3zsFZxnQ8l3H65X7YI6wnmbUvKSo9SvV1vlZfX7Jv72CzK98tb8/PEdQZfTZqbOtOofVGIIFmihYKShDvwonJDQ5GrqNZ+FC8ADgSgllW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438644; c=relaxed/simple;
	bh=UZjXx5avIfuubM+Zn4X9q7hFFmL/Kbj1tW1DOKGPsnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l1obI6bSBdDlkPqqEYaq5zZ8scaotGYS5A0BBvKG1NS3Z0HQMVfQoXJJc63cDYchJens4/ST+YN7y8C1/iFQPSallkzD5avsVoHwfXO811ikMR4j0jCknh9cXyFConH7p84aow+tXUsAu/7yVydyrKyBT9tVropLui8QzCtVCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zulq9vW0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582bc5e4so36872515ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755438642; x=1756043442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+XrzEY8HAgXuZ0nsdvKPQkBrNM9LhdmG5VI5NsW7Fq4=;
        b=Zulq9vW0I2iWgs/i/zHzAzMw3Y/nxlNRGuSc+jeRRG5a/BtBo0VW9GZSylfLpQUfLe
         LkxF7SV/nhYIsJYB6U2BZkXypGFfjZiDIq40udGZt+1VkfB4aN35KgNRb036CA8cQ1nB
         Eeo1NwwXfFUkuifQXlgFmUNfZtLPhGM+ZB1esy7EIOFFyGAEBsNFg1k+LnDtqh9fugpd
         Oboid5mYs8YvwiPDmVRYoTTJ377OkD+qYd5rmsRPLIpEgXpymcI103bvpeobXQ93LwWy
         BCbnv3BkvlOg5eKWG0uiOZ8VJQzA2wGHc74yyfTYuD53T9O/DO2YMmk8MhXc4xDuPEdF
         M72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755438642; x=1756043442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XrzEY8HAgXuZ0nsdvKPQkBrNM9LhdmG5VI5NsW7Fq4=;
        b=Gmemn02wCcihfQNxzUlk3EKg04WsernsNK3wjYBbQ32uthdDBwvErFsVEPFMuRDB5b
         olAOB74F18JqTvMwpz5loaSPzPubpVHB4hHT52B6GysqBCHUcM/gjPPnvs5OfZM4twYp
         7rxjtxXkXF2wztZLtIPykjHa+Z7dddtE+Mjs7+FUtkl/VkpjrPm3g4AFLik3rl5O8CZX
         FMUiPGT8NrwgPuSHXpnmO7IySqaPyfVasGfM+JX3OQGFGndbJ8/BlFungGlX5VQR17vS
         gkerg4nEFKZq0Wa3g/w7PeC/Jt6wXGnqfLNOLHAyAeVzsdpqFsIDMIy7nEFceSjH8S6B
         GRYA==
X-Forwarded-Encrypted: i=1; AJvYcCVsq6vKjUADQPqxdwt+Sw6LVnViP6Em7ZSuW+DMfjaLdDjHj2CimY8h9f6CTAKdTs3/Qh22fnsres+Hgn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeaGlLYWoR+OVT0XrcMBWlhjyuDtQo3/zXjc4JXsjfa9ngOAL
	bbIV7h5jNNVzfxCVQ9usc2ffh3dIWLjGqvViCphC8EpKwesYBhvCiGlmF1sk67gWih0CtCu/4Uo
	CDJWPJp2X0twQUA==
X-Google-Smtp-Source: AGHT+IGZwYycHQyeO1JVo2RV3fpKCRN1QcohTgxiXTuT0tKpzYONqzOdl6u4wdpA9sRYNgyfOEH73e9czcVNuQ==
X-Received: from plhe7.prod.google.com ([2002:a17:903:1c7:b0:240:707f:e631])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:37c4:b0:240:71ad:a454 with SMTP id d9443c01a7336-24478e133admr102950865ad.1.1755438642560;
 Sun, 17 Aug 2025 06:50:42 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:50:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250817135034.3692902-1-cmllamas@google.com>
Subject: [PATCH] binder: remove MODULE_LICENSE()
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"

The MODULE_LICENSE() macro is intended for drivers that can be built as
loadable modules. The binder driver is always built-in, using this macro
here is unnecessary and potentially confusing. Remove it.

Cc: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 312b462e349d..28634f786e70 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -7088,5 +7088,3 @@ device_initcall(binder_init);
 
 #define CREATE_TRACE_POINTS
 #include "binder_trace.h"
-
-MODULE_LICENSE("GPL v2");
-- 
2.51.0.rc1.163.g2494970778-goog


