Return-Path: <linux-kernel+bounces-797193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F93CB40D38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78DB1B27B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463362E8B68;
	Tue,  2 Sep 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NYzbFqTx"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5842853E0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838050; cv=none; b=Wa5cFGmx8F0HJsbsxQOrdMIM2mOlHfBeXT/osRkb+LXo4JYjc92OvQ38jni/rjyUBV9G81YR/RpzrVM/OE2QWcHHJfURpF1KYxi/tpU5fkor0lQcfR6BzJ+XCkCymBrgTLO+ecVsc+erK7gH0pVdxMHZdxfUTKFA/EAq1GHgVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838050; c=relaxed/simple;
	bh=CfCTirauyBDRzM3gQY7ONrKpMxNilr0F17w9gsO04N4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lSwb/0E4Cr47lEqUcpe+Rbd+Oc0eJSgccYnXoHLLjy/2SUgBmzpDVUGRiJi+2qUIHVD5L6oGt/B9XTR0FiRVYHTw+TudmC++z9FTzxs0ERi/h2dIXszW22qQp0xSeTqNm0kuSxaPzYmkEgMZpQU9QudayDPNT0Ia4Lfbclp2WnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NYzbFqTx; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2051298f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756838046; x=1757442846; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3cKnJ2EnRVvoxrwdhzOABG+ckrFCGnrS/QnRyyFG6Q=;
        b=NYzbFqTxtJoEQKakp2m1iM5alaxTdaKPJ5udj1OkCLTI/yho/zi8Hba6MZJF4ALabf
         fHeLT8k578pZQiE6II+xGvxgGr3vcZPmTxX5Uk/bfMo3TSqNUgLa62NydesNqHsZ5VQA
         NVVrv3meswB94joNBeH+7GIwhPUq9V3dCbRbeAxq+LRP2ma2AbX4orXFoWWukACi+PFv
         8iCf+/Oz9yDS7rtVPxNN+X3Aw0uZHJXpAXUVhmHM8xX6xh/6ktPnK6NffPSah9Pl6iwu
         96C1WB6O6OTt9GctSmGLwYadAWI+PpwUWqKdCzKJ1G4qeebMFUTA/xxOmiysO9/KOw9B
         n19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838046; x=1757442846;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3cKnJ2EnRVvoxrwdhzOABG+ckrFCGnrS/QnRyyFG6Q=;
        b=ACWXJVZHGoX/IrhWYfyPE3iuHXlTtlBt3tDNIxKHh4Ya5i+ffjNpKhlOYcq6RepWei
         nv/qPd6zeuQj4Ccyrjh1CSlojCoJvgaXWd4zFC6AjRrcMpRfYWrlFYoV0etgkDY/MDtb
         xHto3GKtLtq9bOwRzRKOyuwsak8tA3QoaL46QXg4Dy4U63O1JRFOFGji0mVIQLEYlRar
         zPS56mhYTXnQlTONAMgCQzOvPs+OI+GbM3acXbnOJB6sFQBhPT0NliZUBWPtmTTe4U1m
         BiJbmz26e8mTokWqXlYafBtsPx3AqJ5deVmm3NYmF3giCBBvxTpqlExUqAV0PgWKTB0W
         80WQ==
X-Gm-Message-State: AOJu0Yy0+8O1Rk7mMe8lElJlNjvIzaFArsDSBorlySicC0NOCn7unRyT
	Ad5qugRJQ02nIgpQqwReo27L4NqxDnznybVOdmg4DtluyW9B1flkus/L35RjZj/CZtc=
X-Gm-Gg: ASbGncvz1gdGEKfxk60ODnizF4GEgD4k2pLVQIkz4P4H7nlPEaL1zZeAa0lfkloEC/g
	bptY3p9TpbdN/KyORQiMe2EQhFab9/RZhAoO6f6TYj1lJNdY2T15gjQYawNV31D7P9GiBKTAiCr
	/FtI1lLXUzKk4DlgiBQaIxXZo/xTmTMuHiAdDQ6kXU/26E7e/2bvb/2GobZYaheML/fnevpV8bU
	YDC+rYkeGjp7w9PKQ87jOeANJ/WmdhjpV2/fyDLGUTOm/i07Rk+NMXw44i3YI5doANFr6TiAbkq
	E7T416rTUim87b5NlLRsrlVh98dZcleDwCnCr9ZDOP/NZLWSO++H2tQ3jJ+Lxk0Gai3lOoHPg36
	zBIk/ne2QxIQ+MV+ahsxmT4S+W/Evjw==
X-Google-Smtp-Source: AGHT+IGadJheVs+rqTccpTvSvnSIsk3/R5H3cQsdPe4JISg6VV0H6tDzIke0cO2LZPiK04BtP1dLjw==
X-Received: by 2002:a05:6000:2409:b0:3d6:89f0:f348 with SMTP id ffacd0b85a97d-3d689f0f684mr5815272f8f.15.1756838046323;
        Tue, 02 Sep 2025 11:34:06 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm14028477b3a.73.2025.09.02.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:05 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 0/4] Handle NBCON consoles on KDB
Date: Tue, 02 Sep 2025 15:33:51 -0300
Message-Id: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI84t2gC/3XMSw7CIBSF4a00dyym0AfVkfswDsrl0hIjNKBE0
 3Tv0k40Jg7PSb5/hkjBUoRjMUOgZKP1Lo9qVwCOvRuIWZ03iFI0peQVcwq9Y9dBK4+MDBqspNF
 Ut5DJFMjY55Y7X/Iebbz78Nrqia/vn1DirGQNJ0R9ELXsu1N8RNqjv8HaSeJjO85/rMgWJUqhU
 FNv2i+7LMsbk4QU9+MAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756838042; l=2374;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=CfCTirauyBDRzM3gQY7ONrKpMxNilr0F17w9gsO04N4=;
 b=4GXSeC2mymjqgC6HpCNhh153BJsiNcoKEQ5XJHaMzLIA2VAkhofrrNCXPk1HFk/WGyk0hFxVr
 WOXlsJgTYrvBsSyfa4yqMiRg6nXCcGkd3SbpKagV/G4NPqO3PVVxXRv
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

These changes reached v3 (since the first version was tagged as v2 by me...),
thanks to all reviewers for the suggestions and questions about the code.

A new patch was introduced this time (3/4), adding an exception to nbcon
code when trying to acquire the context of a console when KDB is running,
suggested by John and Petr. Thanks a lot!

Testing
-------

I did the tests using qemu and reapplying commit f79b163c4231
('Revert "serial: 8250: Switch to nbcon console"') created originally by
John, just to exercise the common 8250 serial from qemu. The commit can
be checked on [1]. I had to solve some conflicts since the code has been
reworked after the commit was reverted.

Without the patches, I can't see any mirrored messages on the NBCON
console when KDB is triggered. With the patches I can see the messages.

[1]: https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0da22aca9ee

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
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
Marcos Paulo de Souza (4):
      printk: nbcon: Export console_is_usable
      printk: nbcon: Introduce KDB helpers
      printk: nbcon: Allow KDB to acquire the NBCON context
      kdb: Adapt kdb_msg_write to work with NBCON consoles

 include/linux/console.h   | 50 +++++++++++++++++++++++++++++++++
 kernel/debug/kdb/kdb_io.c | 46 +++++++++++++++++++++----------
 kernel/printk/internal.h  | 44 -----------------------------
 kernel/printk/nbcon.c     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 59 deletions(-)
---
base-commit: 618bd49f8533db85d9c322f9ad1cb0da22aca9ee
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


