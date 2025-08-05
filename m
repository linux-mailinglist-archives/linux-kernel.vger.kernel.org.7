Return-Path: <linux-kernel+bounces-756720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F4DB1B851
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E641816B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A4291C2E;
	Tue,  5 Aug 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbmBQBNK"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540128BABE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410836; cv=none; b=AFFhZWbmybRzT1t6os+hKGZyteyPdkBkBrSEDT2yTME7rmVPW4cREYwe8x8/KCjy/3uvo9Ze+7eb8ccilP8BJ8w+FSGxnMJfBiJkN2o0SZflWLZDxNZjqPUm/ny7DMvrP5EOtFc/ri8Pr/8KVpu4T/MmzQVQu63Jrs1k3z5KXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410836; c=relaxed/simple;
	bh=b2dhbaF/pk/NFPcdxLdEyKbE+xfcHsMrSQj7Hev2whc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Oej5SN8f0Cjc6YKGycTLsnqASpZGaz2wXlwglV5cCSy7B4K/jGdC6FBpbX2CYDFzgAgoPzrxXTx7MhXajKwyu9lje38PJFRZFyKL2oTPR1uN9iP9bYorAOFtWrR3/SYoAWs24edWDx4WfPM+WKilifH6nsMXpyF55yJIwqVBckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbmBQBNK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so5530566b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754410834; x=1755015634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=36rRNVwGvNB+pofkD3n2pIQi/fX7BoFaKjjYFA4l3XQ=;
        b=vbmBQBNKQa47zDk1bZ6loVKtKP8EhqhyXlG02bwspsKVtl4DWd2TaTV0v5p+kfyNr6
         X8zSrVAX+xBUSqHY7LekHAHR9fIp0cgQPwFEQt3vv+Z1VGkyuuPiZZzpBCpzePfrmxFO
         oJvwRNnoZ/wBp1qUupHdfQbo47HySLr1nahZ7icHUEs9UQB1PLc9na+v9arKHoIhffP9
         dvYmrUwvCOI5zskFJWDy8880OC1na41PIoO+8daf4pu2odnC8Cch2cwoZ9Dl21DCeQz+
         6ohpSxZPd43vECCnPmuUGEEOxEzgyySUGhi3JVOO7+UoMHxihgLmIKZRFqNf092ccDqn
         FqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410834; x=1755015634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36rRNVwGvNB+pofkD3n2pIQi/fX7BoFaKjjYFA4l3XQ=;
        b=dKxDw+ekpdFHj93kC9JeqzRQduM7pR+Qm7fFSk8DoYvl4mh9XdegH7xBqWH/5uQnGe
         FPZuBnG3vPFDMY5U/vudHXLsVyaB8rwOu923nh4WRpDEaTs/QwOtAh1O41Syvrks2azA
         8Y8Am8gJtu3a/c93stzBrZgtpuftBXoCig7EZLSS6bybmObponga+8EnJ6Lld+1CuRVV
         EZElYKdoK//jj36AlbGSSRqTDmIYIPU61QJ/mfck8WAgxkgzQFPCBCKHCqhEfOPA9esJ
         J3MylO4a/iWUK7oH8yMAPT9xLXoTsQoIBcPaCwPd/xnhmNg/uMRIWeQrSj9TitprClB9
         RTgg==
X-Gm-Message-State: AOJu0Yxu+K7iIyziZPp41S6J7uRT1/oAaYcJmOLcVPBHpH9MSQNQy13R
	FmEY2Vumr1LTAdSp2IWydo12jEM9d9UGbzbDgRvW1WoqVb97TYEgbCq9Zl+4tedVrheoutDX++u
	TXg==
X-Google-Smtp-Source: AGHT+IHL96s4Hqrn3CB2fAXGuE+D+Q4GO/8xpdFTrf1lxIfh0W20hvtTrVgOvBT9VRIfEQG+3ts14Kkq9w==
X-Received: from pgcv23.prod.google.com ([2002:a05:6a02:5317:b0:b42:26ab:304e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958f:b0:23d:c4c6:f406
 with SMTP id adf61e73a8af0-23df9188b3cmr20456836637.43.1754410834355; Tue, 05
 Aug 2025 09:20:34 -0700 (PDT)
Date: Wed,  6 Aug 2025 00:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805162031.952223-1-wakel@google.com>
Subject: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
From: Wake Liu <wakel@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The constant NSEC_PER_SEC (1,000,000,000) is defined as a long literal.
On 32-bit systems like arm32, where long is 32 bits, this value can
overflow when used in 64-bit calculations.

This can lead to incorrect time calculations within the VDSO.

To fix this, define NSEC_PER_SEC as a long long literal (1000000000LL),
ensuring it is treated as a 64-bit value on all architectures and
preventing potential overflows.

Signed-off-by: Wake Liu <wakel@google.com>
---
 include/vdso/time64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/time64.h b/include/vdso/time64.h
index b40cfa2aa33c..07641b27d139 100644
--- a/include/vdso/time64.h
+++ b/include/vdso/time64.h
@@ -8,7 +8,7 @@
 #define NSEC_PER_USEC	1000L
 #define NSEC_PER_MSEC	1000000L
 #define USEC_PER_SEC	1000000L
-#define NSEC_PER_SEC	1000000000L
+#define NSEC_PER_SEC	1000000000LL
 #define PSEC_PER_SEC	1000000000000LL
 #define FSEC_PER_SEC	1000000000000000LL
 
-- 
2.50.1.565.gc32cd1483b-goog


