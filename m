Return-Path: <linux-kernel+bounces-728900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D55B02EA6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D90117A996
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E01953BB;
	Sun, 13 Jul 2025 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XazxUalS"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765627F9
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383372; cv=none; b=aia+nLa5Ir1QQpS5C7bg7RUbwNDSukU5w2f1KDn7wUTrAn6mdo6ZY39r0Nxgh+8mImuo08HzJWYc0am+Sj4mKSPHvdorMisJhBQSB0cr+pHu+xx2DDmaR0hRUsQvIK/dWp+eMCkztDndFHQJ6+zlkfELmBMqoKlSHK1gXHbKy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383372; c=relaxed/simple;
	bh=vV6rojAChJBlu6omswjEVQ0wLA+6YPGc+qDm8ODsNw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WkexS9XAVRyGLnQAkdblzRa3hYzISQB2AJHKJbiRfzT5oR0tJe3Lc1pg6/KZJoIMQO+LZ7NydWULhKoGPj9yj9V/cSmPSsuu0JpugLu8ZPDI05sl60bdTUXvAI+lX3lYB8nKRb79TTbIyomAvWYnjqqVWZaS3RN+jQfuOL5Gb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XazxUalS; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so2643707f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752383364; x=1752988164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVj5KwXr/8QzOp1lXz/aegzDFB4gNyhVW/14q17cfIY=;
        b=XazxUalSbiAXeJFYUnYa6+UCtH7YJ//MY451AiqJSRd0Jr0dlmXd2KRLNgB5Gajyl5
         +/BoE8OOEMYiogDBpIpEKqU0rxMP21PPNAgJS2HMFmDbEFYEEqsCch/EiKjQ7zgXRcIB
         POq8w8mTnZq4QHL2DLdKmiAei3xRG0706V+8YpnSwPVUpKP8ULeBHZTB7A3/uZhwOSeO
         GX06SzzPpBaHP2lT3uScDPcS1ghNz0P/RhMyQiMKpdlj+ytF4Msqqiw5NNcwOhVfTvRM
         IbDXL9FkJcxpZaxPcd8sdboW+LgRaXn1SrRAyR+tmGdmZnHeBtBA4W6eB9pIUoqVkf27
         U45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752383364; x=1752988164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVj5KwXr/8QzOp1lXz/aegzDFB4gNyhVW/14q17cfIY=;
        b=pWreGjxEvygUEMiFaMft3GHdhzQ3wbkRaDvMqKa1Vnm1bTDPn8/z0JgRCW5O35mcGP
         Lu0zMkzm3nk/6xQ8C4d9bpSac9lhjmgXw7NW9hLygThsvdVtbm5SCxfkSLeX1HTwDXr1
         0Y2h0j/cEL2jdtt5ZJtS/MpinIj3NvF87tHjmnqMO/3/MJX0q57owXJu+xNeO7wnVaEx
         uEsquLekp/AD9kyUgZVrbu6Ga5KJ9WclfYBZUOsXFn2j5SinlrfNja/K5F5qwpus9Q/e
         ggTRQU1K3L7ClOHZGrGWN+csGYEqQUZGIw6SHcU2UatRJDZiNjUrNENUpVDRcADY3rLH
         ob8w==
X-Gm-Message-State: AOJu0Yx0hv2az0k9fGQ9bcuVtLs4oyl3x4+vxcYnqFCGOvnvNQq8ZYQb
	Jam67OxrCkVubB9kYweDNVhp665Vkhr30iMYWs+uJvxCJN46uz+7I4WD0WjsqgeYL8I=
X-Gm-Gg: ASbGnctxzUYphV9A3zrr1xO8Gbo6Q/mJI16bWUZTfySZaqmp5mS/MJaAWfTnn4ZfC5w
	R9/7Xq3GYEd3cGpOwiF3XVMUPbjKRK5d/Wui0TkCV0yhESjSu/MRCvQD2BiAKMouoyhRFVAVpNA
	5cdHa0wWnlvnNTrTsZjDzAsYVz0dpBLKsXyxN3tXPv9uigc+5ccqg19zAT6ItM0LEl9A2i6SqGH
	FvfH7z+9JBOsZkl8jyHb4/sp5v4QCJWQgHjWspdHK9w+ja/ndkmNjUL6Gvagp9L1UhmgM9ylBZY
	iI6glz0O0QPtxHtg2ztMPyxAnEgHShEE3mDwUH5JXSGvYBqxxA9Li/kr6UtkrFrKk0a1y1jLOTo
	w1ZvqaFHQ41Ycm/1lrOc=
X-Google-Smtp-Source: AGHT+IESj9rnyOluQG/Pq4tT/wJQ3fnQYLjgN1G4PzW6cucpIcfdszyOyoxCy1jE5nbCD6s5KM8zCg==
X-Received: by 2002:a05:6000:719:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3b5f186ed4bmr7748049f8f.24.1752383364583;
        Sat, 12 Jul 2025 22:09:24 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:828:f400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f210f1sm8125879b3a.88.2025.07.12.22.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:09:24 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] Handle NBCON consoles on KDB
Date: Sun, 13 Jul 2025 02:09:17 -0300
Message-Id: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0/c2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nj3byk5Pw83ez0lKT8ZN3UtOS0ZGPztJRUEzMloJaCotS0zAqwcdG
 xtbUAWP4+wl4AAAA=
X-Change-ID: 20250713-nbcon-kgdboc-efcfc37fde46
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752383360; l=1400;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=vV6rojAChJBlu6omswjEVQ0wLA+6YPGc+qDm8ODsNw8=;
 b=JwVzljEuIFCRSA1QpD1puYGWP0KCL5H0AfxjuzqkuPOuI200puckYZu11plckPCusjOrTcLCC
 /drqOtjokhDCphwrGdM9w9x/5S6z1WAubAF3Pf2i5C7K+f9VfMwltyk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

After the proposed patches [1], it was suggested to start using
console_is_usable instead of checking if that console is enabled. It was
noticies that KDB was always calling con->write method, but this
callback is not usable for NBCON consoles.

As a first step into making console_is_usable public, I prepared these
two patches that makes public some nbcon functions, and also fixes the
KDB to also handle NBCON consoles.

Thanks to all reviewers of the patches posted on [1]! I hope this is the
first step into implementing all the changes suggested in that patchset.

[1]: https://lore.kernel.org/lkml/20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com/

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (2):
      printk: nbcon: Export console_is_usage and other nbcon symbols
      kdb: Adapt kdb_msg_write to work with NBCON consoles

 include/linux/console.h   | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/debug/kdb/kdb_io.c | 46 +++++++++++++++++++++++++++++++++++++++++----
 kernel/printk/internal.h  | 41 ----------------------------------------
 kernel/printk/nbcon.c     |  4 ++--
 4 files changed, 92 insertions(+), 47 deletions(-)
---
base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


