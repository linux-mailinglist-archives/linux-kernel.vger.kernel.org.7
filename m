Return-Path: <linux-kernel+bounces-856371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB9BE4008
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C04F1A65766
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5933CEB5;
	Thu, 16 Oct 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YsEFJfEa"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAB3451BD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626090; cv=none; b=VtPnlFtid9FnHdm8YHE/+9JYycpJggVXIqFSbADpr09beQj0Nma6KVa411C91LtrerfMvtrv9VPGq1tlGhjLCut6SjpqyiTJnyhKYNPyCky/7uQK69UHerISiusDJqscMVYnrK8VU4twJclEUNTyDncpQ3G7qM4PjR2sI5R6LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626090; c=relaxed/simple;
	bh=H1KOU0UUSx5j0ZmO9EjPcxQevsmn9VE1qWW4r5no0Uo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JBkKimRVEVr/nbefUfEGezj716UVINxvPZv/KeRIn8M2OOnNDF8OlPoaPH9mm76UrRSnOLZmkO6rGo1Xc0etgvPCMsEBhgLhIMQ2hnvzL6wfEiIC+2CIDg9xxGSTQGCqqav4qF7h9DfdEbmAdxU2PEli2qkHBWUrBIbYCTNbYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YsEFJfEa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427015003eeso474186f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626086; x=1761230886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5vePrV8ext9QokCllhHv0Ih/WgmHxyM0eLFJaAxvlg=;
        b=YsEFJfEaTY0Vxevh5EFYkQYBi8k/wKug1Bb4Jam2d6/u8xi/rwJOvC9Rh+y139tJYO
         Roy4X2SjwgZmFDUDAEnGXkueI3GPvTIyS+z+u/+AVDERBza2SCwkSTemxbg3va/VaZt7
         gh8rklCgpooVhIU10j+QvukTnfhDCclJou43Pjs2zx3N5y/WIzd0uzMKaQ35EVLDMOl0
         4lLg5eN+A0Ei34uFkqTutZ6lXTsnPUvXRv2saA41+w1dtsNvpSn6JKT/MeerbDMKuWfR
         +jPw5sk6sIfn5+dN8ShRGHALhHUJT2bZsZaUJakqI6CrrIWxBS8jG+qDmmwuumpC9LVT
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626086; x=1761230886;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5vePrV8ext9QokCllhHv0Ih/WgmHxyM0eLFJaAxvlg=;
        b=qliQSKHTAFe3P1dR2axGYzSMnJEADVQlTUGBb6CvLMcEIjaTnfIGOQFqFL6SeR7CJu
         Xl6SdoMd15otEpDJoXzrdRNSChI6ppIwOqpONm5HIFoED6Wtb4HccnJbnsiUJxXHT1jg
         evAWGDvKE+0o9qcSJ3KtIvptGfo7ZpNvs4hgMFphB2hKDFfjAHHUS5nfL2EF/jKySXb+
         +VArgH0bW80pwfI+LIwZNadFGogaBRAMsteEhXkJC3tu3TNd4UD9tSrLc0PYY+2Qp82O
         EPGvQArl4/NCev3VtC7owYiBFyUwLDqEydtq8+csFPnwbZ7jvQ7KV7IARf5hP6PlXl7+
         DwQg==
X-Gm-Message-State: AOJu0YwRC82+12tCPguuQCQzsNSpsObizGv3zdEvTxBGWozPlDKpfseF
	CEiaS6aXs4nW4iBj5Q9iLneDqt2cUa7RphRp9I//V0MLq4HOvLSvGZDyjdVeLS4a5/I=
X-Gm-Gg: ASbGncsuq1ghPfn7FaDFdQdkt5ru+7AOMNNWHPUoobKZpKscZs92kHrw7aNpEcJ0SkP
	tHtVrSnfqqqv+SVaYhJ+iC+c5MQVk5dYH+BmNCsRnpOGOzOZS9XSEkMJND++Cb5lIjZj6wzjy0J
	RfhBj1qFd2Wh1Fb0pVsNE3gv8/O/E55KCyAliuDrzHfIazUpVkwQ+67h0p991h6kFExBhQJ1hCT
	3lvt9Z4np9ru6cu2cQkhKObg97dHXAnflvJtsUqoLbZADSrDE7Sm3t3YPOUyISE2KHQC0Fl0T5y
	1la+/yhDWNen01/lMPgorcPyNqd/K28a3b7lFQQdhs9VahPHN60x6L0M3T9Lhx9nB25/NDAOM+6
	6joxnez327GXpWZTnBesh5w0W4vqtXvTF5maIyS2R6lSXrYHqd7zFDbId0OIAFG0NeWjwWf1H67
	86U0raw6M=
X-Google-Smtp-Source: AGHT+IERUIWQTXWh5PLSc5bbZx21RURf1d5UMdKmDKzTb0MPYiPYllCPyw5w7/xXtq4M9SAfcCkzrg==
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-42704dce7bdmr275848f8f.54.1760626086482;
        Thu, 16 Oct 2025 07:48:06 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:05 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v6 0/5] Handle NBCON consoles on KDB
Date: Thu, 16 Oct 2025 11:47:53 -0300
Message-Id: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoF8WgC/3XNQQ7CIBCF4asY1mIYKFBdeQ/jogyDEmMxRRtN0
 7tL3WhIXL5Jvn8mlmmIlNluNbGBxphj6ssw6xXDc9efiEdfNpNCamFB8d5h6vnl5F1CTgEDKhs
 8NYYVchsoxOcndziWfY75nobXpz7Ccv0TGoELroEQ/VY2tmv3+ZFpg+nKls4ov7YFqKwsFi1a6
 dBTF0xl1dduhaysWqxXomtBmABY2ebHgq5sUyxJZ6xWzmnz+3ee5zcc4Zj8WwEAAA==
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=3629;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=H1KOU0UUSx5j0ZmO9EjPcxQevsmn9VE1qWW4r5no0Uo=;
 b=GT063e8k+3x+rUzaze+XlhqohAOK6J8mVb2KXRKk4S7AYLhMyEAfBwA3B6WVC/JPtWpErm6eN
 nkxM5nJhueuAXnGRpLyw2K38imvp2EloFiFG0vYrWmMPzvlStYLfHMZ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

In v6 the patches were rebased on top of v6.18-rc1, added Reviewed-by tags from
John and did some small changes suggested by him as well.

As usual, how I tested the changes:

Testing
-------

I did the tests using qemu and reapplying commit f79b163c4231
('Revert "serial: 8250: Switch to nbcon console"') created originally by
John, just to exercise the common 8250 serial from qemu. The commit can
be checked on [1]. I had to solve some conflicts since the code has been
reworked after the commit was reverted.

Then I would create three different serial entries on qemu:
-serial mon:stdio -serial pty -serial pty

And for the kernel command line I added:
earlyprintk=serial,ttyS2 console=ttyS2 console=ttyS1 console=ttyS1 kgdboc=ttyS1,115200

Without the last patch on this patchset, when KDB is triggered, the mirroring
only worked on the earlyprintk console, since it's using the legacy console.

With the last patch applied, KDB mirroring works on legacy and nbcon
console. For debugging I added some messages to be printed by KDB, showing
also the console->name and console->index, and I was able to see both
->write and ->write_atomic being called, and it all working together.

[1]: https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0da22aca9ee
[2]: https://lore.kernel.org/lkml/20250825022947.1596226-1-wangjinchao600@gmail.com/

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v6:
- Rebased on top opf v6.18-rc1
- Changed some includes, as suggedted by John
- Reworked comments as suggested by John

Changes in v5:
- Added review tags from Petr
- Changes the way we detect if a CPU is running KDB.
- Link to v4: https://lore.kernel.org/r/20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com

Changes in v4:
- Added ifdefs to only check for KGDB if KGDB was enabled, suggested by John Ogness
- Updated comments about KDB on acquire_direct, suggested by Petr and John
- Added a new patch to export nbcon_write_context_set_buf, suggested by Petr and John
- Link to v3: https://lore.kernel.org/r/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com

Changes in v3:
- Only call nbcon_context_release if nbcon_context_exit_unsafe returns true (John Ogness)
- Dropped the prototype of console_is_usable from kernel/printk/internal. (Petr Mladek)
- Add comments to the new functions introduced (Petr Mladek)
- Flush KDB console on nbcon_kdb_release (Petr Mladek)
- Add an exception for KDB on nbcon_context_try_acquire_direct (John Ogness and Petr Mladek)
- Link to v2: https://lore.kernel.org/r/20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com

Changes in v2:
- Set by mistake ..
- Link to v1: https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com

---
Marcos Paulo de Souza (5):
      printk: nbcon: Export console_is_usable
      printk: nbcon: Introduce KDB helpers
      printk: nbcon: Allow KDB to acquire the NBCON context
      printk: nbcon: Export nbcon_write_context_set_buf
      kdb: Adapt kdb_msg_write to work with NBCON consoles

 include/linux/console.h   | 55 ++++++++++++++++++++++++++++++++++++
 include/linux/kdb.h       | 16 +++++++++++
 kernel/debug/kdb/kdb_io.c | 47 +++++++++++++++++++++----------
 kernel/printk/internal.h  | 45 ------------------------------
 kernel/printk/nbcon.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 171 insertions(+), 63 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
--  
Marcos Paulo de Souza <mpdesouza@suse.com>


