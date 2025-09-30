Return-Path: <linux-kernel+bounces-837972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D8BAE28A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A8116D737
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E12FBE16;
	Tue, 30 Sep 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KcxfgXRa"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267C18A93F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252913; cv=none; b=fRvDbHGBpZkc5U6WplgVm3DLYuI9q63DNlOZiSqiPnHbC6zurUsGgOKkfNRSjcHhqCyQC2Hqg81WQG2WG2EU+ocVwesv2f/TQKInUTrM1mt9P+kQ5QoHwzaWbkoH80hGs+HgBc8B4D4wuVT1EDHx0UyE5mE2BDeOFCDh4JRuSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252913; c=relaxed/simple;
	bh=GhIP5aPh9MRa2gL0StZgxRMv/CG/5FCZLkZ/8A7/yKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D2FxzYgT51LxczRCGR2n3p2JO2BLSSnEfDIHBoBKaU4mAQ4kaYbF45q6+KdAGRTWgnK7QR1ClorpDFYzUcn2ytXD+P3Xgrqo+eTt/6orCB+HnU5bjZEHcGoysbS/eOBc+zrRd5VTtf/pY528EXhRtK+LURbg4CJTyR2IduVjQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KcxfgXRa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so37373335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252909; x=1759857709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/6LXcu9tvzcjiii9k/Gxj16rMXktJNUCOaFZ8sE9cI=;
        b=KcxfgXRaJokydFmvkySnkGw2hCMiINn2Wit17IhP3rXFx2Dn3nulvTr1E8JC9z2bp3
         3imxG9+N6XLRcoYi80mfj8fY6R8A/ae7UThP/qAtm9clhC4DEwNa2+4oFGbpYHQmvu3V
         1zl9ArGcCxVibbn14X+frcTS8tXlrRRjibsVHgCUGwVNRs+0A7mm8CuOUnEoMpcJv6gR
         Fs0xpkFtyVbhW0lgVkj4wvQ/lhLV/5qoPryknV5oAlGXKa/n1jf3BKbNOlTTWGMedIh4
         WQv92vRiaBj8WgYvLKQH0DuSgbxFaaZgkT9T08ko+fuO0nCSc8ILpEVYINqxirSFmPcW
         HYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252909; x=1759857709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/6LXcu9tvzcjiii9k/Gxj16rMXktJNUCOaFZ8sE9cI=;
        b=X8LJVZqhCdmbOfblO+GIm083PWVcXiPCM2B/LBx7/pWvrOIrrrmgPQirCObvUv1/Xc
         elJIPsdV7b+rJFxA5Cnms1hRLwe6UpkDJNTW5uJBljNy3BzuRSYMLtW/GOzc3d5q5/rF
         INH4wq1i7tA+eQcNuWvRkfpofc57Sta2k4eSLAljxQh82x7GTvIUNp/i/M/tkAW8z4pt
         aHMTdLYfxsghbdkew0SdW5ZjqdDpMe5PyHv0onBMo601L2UO8507amRGOnqL2BZr8FsH
         HE907iM6TTBAT/nhTdGsBFU5oRMT+yChGyCk6L25Vddb+ykwseacGiR8UwizyMasIC8o
         kj0w==
X-Gm-Message-State: AOJu0Ywwtpib1AyQ953lm/sYzkIADEXwaaTUIwXUR9y267FRiAByA8vN
	K2nv9XYkGT5NdmDlqBZ3HtPVhj16XW49ELTEAM52eiJ0ZYBQN00F+iBGyNObe0MN7Pw=
X-Gm-Gg: ASbGncuhyR41Lls5224K8fDvj+ymzuj/WEaHQFavJD3uqFjCZ69sH7N/QjX+y95fxCO
	bjKlU5e4XWUE64DdNH8Z0VLDrXCjYvgPSE+wpKitjWBm9bkeZbCSdAWpkIsIIxdLRaKP2NYMJwc
	iT7/M4ntyP4uNoeopIvx87WuhnRZWQpzpOtwgCoshPz0ILlzsSZhKSHUvAQLiebounky2VcKfje
	UK3ol3PKgQHekEPNynZysMnkQk5Yw+lkLomZNqDodbCXoL2ADXBKhAzsXr0+vMcTQB1HqwtacSh
	bjaEiYqapw9bBk9P6TuurtmECsA+XSY1xNB/er0kHCmU9aAGcY0N3Yvwc1YhNVD6zF+IDHaxHJ3
	Znpc8E06cNlKnWxpAhVorCHdlLdhjkm49CPI5+0Jr+DPKb2MXkPRERJyH3JoOo4gdWTaQvlDiuj
	evNiGX
X-Google-Smtp-Source: AGHT+IH3UulnDnvppv/n3rIMQMNoKKjA2far7XIzraCQs2hOWp3NOnh+j3Xd+9J7x3LSh031TzPLUw==
X-Received: by 2002:a05:600c:8719:b0:45d:d56c:4ab5 with SMTP id 5b1f17b1804b1-46e6125e310mr6205555e9.5.1759252908605;
        Tue, 30 Sep 2025 10:21:48 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:21:48 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v5 0/5] Handle NBCON consoles on KDB
Date: Tue, 30 Sep 2025 14:21:06 -0300
Message-Id: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIR3GgC/3XNQQ7CIBCF4asY1mIYKFBdeQ/jogyDEmMxRRtN0
 7tL3WhIXL5Jvn8mlmmIlNluNbGBxphj6svQ6xXDc9efiEdfNpNCamFB8d5h6vnl5F1CTgEDKhs
 8NYYVchsoxOcndziWfY75nobXpz7Ccv0TGoELroEQ/VY2tmv3+ZFpg+nKls4ov7YFqKwsFi1a6
 dBTF0xl1dduhaysWqxXomtBmABY2ebHgq5sUyxJZ6xWzmnz+3ee5zfY3PH5WwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=3519;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=GhIP5aPh9MRa2gL0StZgxRMv/CG/5FCZLkZ/8A7/yKE=;
 b=TIxkkKuQUoxWju/JR0p8ObJARy+/U4NFEvCswSEjVjPr7ikpi9KlPlHnwVYfG9GUHtTMOUvWO
 2bOzqVKpfAfB1LSm/AuBfhzFMb/2TqdlCI1qWHC+y9Uu+DROT+w5BL7
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

In v5 only patch three was changed, changing the check for KDB CPU, as suggested
by Petr Mladek. Also, it was based on the recent panic API [2], which now sits on
-mm tree.

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

 include/linux/console.h   | 54 ++++++++++++++++++++++++++++++++++
 include/linux/kdb.h       | 15 ++++++++++
 kernel/debug/kdb/kdb_io.c | 47 ++++++++++++++++++++----------
 kernel/printk/internal.h  | 44 ----------------------------
 kernel/printk/nbcon.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 173 insertions(+), 61 deletions(-)
---
base-commit: 39c3d8a3e54a8aeb26de10365318f2c747a8eb25
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


