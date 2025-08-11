Return-Path: <linux-kernel+bounces-762729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB0B20A44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B7B2A2F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0642DAFAE;
	Mon, 11 Aug 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GRC353ky"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EA2D7805
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919212; cv=none; b=fhnycgqYrCuLnVVoEkBKQd23BzjSKI247CPd1dvcSw7F4KuOvHDE/g1SVuS04dGIsHttqahnOcxeZlyO3qS9OuK30/XjNZyt92uhmScABa6nL/x3Unzg5lC6pWhTL3rx9Fs+leBu2okI3A4YOu2vdP/+/Mwf8bYB+xUowpATiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919212; c=relaxed/simple;
	bh=CuKFRpUhENP80Q7iJzfvvqq99WsSVUBxaGht3bYsh7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QqFmJdJywaM6vZHacFf4ur5cRikTRCx9cgMx1MfXGe6VQ5wgVTUaC9LFqXrNYmIMstA9e8m/N0OwJCmCzVNBToGTOxOL3zwhIjMv2e2CH0J2CkUw+VzB57bHXGhjZtCn9QqN0cUXHK2UeqYRza2Sez/U8LFQ8uj9Kk9wfrACZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GRC353ky; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3b783ea502eso3055106f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754919208; x=1755524008; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGqFXTFFoammkG7cKMo/k89rqdeq0Z3cexjc7G9jgt8=;
        b=GRC353ky4228b05pLdEyUoVWD9QQehIipAOMPpxWAuS32w1+of5sD4xkAUvmd+KAH6
         JLscG0sTGwCsunuZaIPlZFENEe8XNb21HJYdlkECPoAnqvw85BoNdtvd7TRZieGl8Edo
         2+pz/cKS3s7bvMvd+3ranNMyQE3GghRzae2jaFWM3a4Itd4Nb2Ya1njqqo6j0aK1l23c
         Clrnr3vD+m9EdCP62dR1Nd5DkmSQP9IVEUpgzNz60CupDWjrqBe61gXF7f2iXR/8fL4w
         HbfKk1Ktaa+/xU10QBmZXwxmuppzShjSNZQ2e/ab+4Ab2eHJ4Yyf2fjn87JB8Yts0raf
         t1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919208; x=1755524008;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGqFXTFFoammkG7cKMo/k89rqdeq0Z3cexjc7G9jgt8=;
        b=NrLbKnN454KHBvSQoKhljGMknl858GxQRND4Nmr426zyPmC49FVi++jM9DXStnq6Ds
         A4njF1theDUHNt0HVNQYrIPMYNJQDTFKIXW1j3nu+/KSgWnRK+j8/+jcw/F8uPa+FfMi
         vibCePe26V8RlTsoe0S9cbhmZMEZ6Wow+JR1Kwhc2qumG9QoqgMv/O1BZdiLkSuNRO7z
         xG7omRNIPs2zZmXIUAGHO4UGSfspKebfbo6VPR3X28gxHiywWio2YHHjUFFqkuMgEFRH
         c/m6ScnmD6nXBOWCFKeEPCfCmhx58a+nxW1PLgbBVLbvpl+8lffc0uTcyLd0lTKszAre
         Rbqg==
X-Gm-Message-State: AOJu0YwwBTRYilejsGFWZDGQ4waj53q1qpwHQzTFZOAqccQb1/RrCIQD
	SIVanP+1a314w744sFsCcXy4cmAYZyMpui3vJHRixipTaoSrKzEtQjnEOqcZc7fGOzBQpq+cl7g
	H4sqtJTa7tA==
X-Gm-Gg: ASbGncv7JC4vmCa+F3mrWdbfaWaKRbMpJZcWyC8lALz1FRyyy7GtZsu0JbU6kwiTAYg
	Ix7xo7v5WykHwRKmuTcRz7uzezTSQA3VpxgWkJJXxPW2kHOjKfB7yUiOm7xNl75ufu0rfTCm5wp
	Hjusr6HUmo1QZmT0rHtm9lbiLmzcPTY94SedVBNLVeT6TAhHi+5DNVPHpvRMjL3jBWfvhI6lr8x
	/vemFJz0yfYX8uc56YwR+PUtbBkfC5NlDXEBOUK5+Zm+M0a27cP8p5KEO/7noZxgODvHQrokMH0
	voyNkTPPGz8sF4zouqa7vMtbGzyZA6e7VYTYbAg/zy+khjiPGuWSrt8O3xKh/gy3ZVJVSIURfj/
	FvN0WWZd4NQPWXMoA9R84IGro0ERQc4j81+swbF7OuTFYMg==
X-Google-Smtp-Source: AGHT+IEtu5YCDoKEGEP+PO+yl2JlsMEF80msR9K0KCfrQsuK9CPCnUIGMqjibUCxoYX2kKLa6PIzWA==
X-Received: by 2002:a05:6000:2210:b0:3b8:f864:9a19 with SMTP id ffacd0b85a97d-3b8f97ec4d5mr14294155f8f.22.1754919206713;
        Mon, 11 Aug 2025 06:33:26 -0700 (PDT)
Received: from [127.0.0.1] (71.36.160.45.gramnet.com.br. [45.160.36.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd18c9sm26667449b3a.91.2025.08.11.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:33:26 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/3] Handle NBCON consoles on KDB
Date: Mon, 11 Aug 2025 10:32:44 -0300
Message-Id: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzwmWgC/3XMQQ7CIBCF4as0sxYDtBV15T1MF+0wtMQIhlGia
 bi72L3L/yXvW4EpeWI4Nyskyp59DDX0rgFcxjCT8LY2aKl7aVQrwoQxiNtsp4iCHDpsjbPUHaB
 eHomcf2/cdai9eH7G9Nn0rH7rHygrIUWvCNGedGfG44VfTHuMdxhKKV++5oMTpwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919199; l=2244;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=CuKFRpUhENP80Q7iJzfvvqq99WsSVUBxaGht3bYsh7w=;
 b=rioD2BT7cWSecfYzzH9VX7oRtbYdh9mbeNDMEJlnzm2UA6WIVZihjcXBf/N5yohI9TUjdtxLu
 VHxf+uG9K5gC6t2pUPGCAOdThACGdx5z+RLz3ekTgiJEgjHnVrxHOjb
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

After the proposed patches [1], it was suggested to start using
console_is_usable instead of checking if a console is enabled. It was
noticed that KDB was always calling con->write method, but this
callback is not set for NBCON consoles.

To fix this usecase, export console_is_usable and add new nbcon code to
acquire a context that KDB needs in order to call ->write_atomic. After
these patches are accepted I'm planning to go back to [1] again to use
the function expected here.

I did the tests using qemu and reapplying commit f79b163c4231
('Revert "serial: 8250: Switch to nbcon console"') created originally by
John, just to exercise the common 8250 serial from qemu. The commit can
be checked on [2]. I had to solve some conflicts since the code has been
reworked after the commit was reverted.

Without these patches, NBCON consoles won't receive the kgdb messages. I
tested using [2], and it works after this patchset.

Thanks to all reviewers of the patches posted on [1]! I hope this is the
first step into implementing all the changes suggested in that patchset.

[1]: https://lore.kernel.org/lkml/20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com/
[2]: https://github.com/marcosps/linux/commit/bea249773c9caf56821f9ec06c7f9649e4966c61

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com

---
Marcos Paulo de Souza (3):
      printk: nbcon: Export console_is_usable
      printk: nbcon: Introduce KDB helpers
      kdb: Adapt kdb_msg_write to work with NBCON consoles

 include/linux/console.h   | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/debug/kdb/kdb_io.c | 26 ++++++++++++++++++++----
 kernel/printk/internal.h  | 41 --------------------------------------
 kernel/printk/nbcon.c     | 26 ++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 45 deletions(-)
---
base-commit: bea249773c9caf56821f9ec06c7f9649e4966c61
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


