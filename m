Return-Path: <linux-kernel+bounces-737384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C82CB0ABC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCA18955CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B24220F38;
	Fri, 18 Jul 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="JS+4lSBa"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC621D3F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875646; cv=none; b=NOxUBRSlLPr11ew2CrvHyKxaE0KPs3FEXOmH5GIHPDdxuDc6xBAVJYHCunMY3N8aiXuyTnX7zQRgu0lp3xyw+Rdk5qEydCNlMTd61UKO6q0mUk4HWdptoPIfy7iGQhQCcU56LXGnfH+7yEfJxeCoD4GXUA8hLzVSx3FDBIUSpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875646; c=relaxed/simple;
	bh=a/NOYAhwRSe145AWh5WfqPzAx4sfdmuw0TEuA6xSc9M=;
	h=Date:Subject:CC:From:To:Message-ID; b=bCwStYI4IlZel/XeRQ2sfqv10IeCpItmNhmBJrOtja7JQS1ylsqhf9oWND/LkUnSAqVKpO8d6ez7OfoFo6xqRWiA8K9rGowB+PGwT24LmG8Y/RdTXshcA9VdAHgy57tq22aLvXI2tfJddJ9uVJwDkQ4P36irKLv4quTPaXnwbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=JS+4lSBa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1667583b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752875643; x=1753480443; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txX+SyRfmCFSSLg3W+gric1BD8iWpGSCKSxHmCCGNpw=;
        b=JS+4lSBaOB6P3uhobZ1M85Z8CYMGwQTDthkYWe79wxDhr88oFFjL3etsjkb/PiYxt0
         /pOZLLGGiGaQtGeM7pupcnzyeLqOXa1aU+6DohzF7RgsLsqRHFIZRnEDS9zMm11vLkeC
         pNQZXc/yqtTKIQtJ4LMkzvMwzy5iAcBRz8iFDGCpM7JdDtHNQqQvvAjy5gwCRR1aEQZ7
         esg90jS0iWdGcKngLx9cFYcbMi+fbTvtm1Tdh41xUGEmtRwHD4QqS8L2vdoRTcdksewC
         lN/L+VdqhhV8Uc7nCnqP47o47DN+qj5dE1RAr2+q528qi6532YIxuVuAw37TVVqdd2T4
         93aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875643; x=1753480443;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txX+SyRfmCFSSLg3W+gric1BD8iWpGSCKSxHmCCGNpw=;
        b=GE+nKEfYPPYuIpxwyBvZdtXfuY9Mkiy0DcIRLtNLJqLgEeCrTwIicyiyD7XyopSBm/
         npTv2t7EER1Z+fEiUiJBdkRLqZCGeqJcPAkrbzDsMNjCxQIvcEUScY1VShHI744Wg8Ap
         ifwB0kA2YvKG2mgyUL/DxgTAP9GcRRWAnmxH5WCaSjUi+uhgTLyJYH/Vb+/m9AHcaWxK
         Y/UR64+faOHuGYQtjeGoQrsoV7ZdjPFVAa9rXkmUNSXMy5hEeq9N1gMDzakTNw6QMHbl
         2XZpme5INbXaNaVlNL+7jDODrD20IWVQ2h9N8MNPs9Ker6A+xrIJulHjxgJdeN0k8/Qw
         2bAg==
X-Forwarded-Encrypted: i=1; AJvYcCXvwJ7xi8YW2J/YlH4N1Djo1DCHRGf2yHQ9bMCk03Xia5/tVvHwIktS/C0XYfiucDhiqQpmseh32XI1EWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5djgZuHBvWsW6kSBoz6dV6InGL7ysnV+fQpsM6YjZ2Y5kXLY7
	rJKlHMAq+TSlf+K/i1u3NHngJ2v7XaA+l+K4wN1fTgg9JRrSJUYme5mg0C4UoSXcJi/0HNZlzKM
	WLxQNwMY=
X-Gm-Gg: ASbGncsOGUogc/yAFUf3lQxEDYZCBGKj6gqSGyThlvXO9wWHZ4ARLSOOkaDb2hNbwZl
	itm5lgu/vdcu5fNSRB+OXOEtNgfxHMABofcgQdBjhCIsGTRpbxrjg9S2lv+PipXcBmfiGRbepUd
	6MWCvLIodB54HthxLqB6FX2KXjDWR2esoGzPS6LYvNVD34FnUocq5isOq7VfI6EC4wwuziUpX/u
	pPK4aWc4r1PJQo6jzRAkpGFGZHrtkjqzdnp0siyq9F+B9rYsldvmSuT/3aK+hPqV94zokMJXKRD
	uFqobBeyx4x+o4SLTy5hJpDLONNK0P3ovgvK7SOht5NsnqiaUaL7swTT1aBNYuy5L1F4aU8xKoT
	nVWfWlrUIJ+KZ1lG2aiHm
X-Google-Smtp-Source: AGHT+IFFawVVhTyoZ/7fjVvRJBlkJqtmErTQujTleFZieZ8o0dIxe/nJwq0SfRo071nzfs5Q0sGKbg==
X-Received: by 2002:a05:6a21:104:b0:21a:bdd2:c2f7 with SMTP id adf61e73a8af0-23814268895mr19400274637.29.1752875643033;
        Fri, 18 Jul 2025 14:54:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3f2ff61fe7sm1411708a12.37.2025.07.18.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:54:02 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:54:02 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Jul 2025 14:53:54 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.16-rc7
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-AC007570-958E-4BDE-A86F-44681C9AC10E@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.16-rc7

for you to fetch changes up to b65ca21835ed615907ba231a60db80a2605b94dc:

  riscv: uaccess: Fix -Wuninitialized and -Wshadow in __put_user_nocheck (2025-07-16 10:29:39 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.16-rc7

* Three fixes for unnecessary spew: an ACPI CPPC boot-time debug
  message, the link-time warnings for R_RISCV_NONE in binaries, and some
  compile-time warnings in __put_user_nocheck.
* A fix for a race during text patching.
* Interrupts are no longer disabled during exception handling.
* A fix for a missing sign extension in the misaligned load handler.
* A fix to avoid static ftrace being selected in Kconfig, as we have
  moved to dynamic ftrace.

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: Stop considering R_RISCV_NONE as bad relocations
      riscv: ftrace: Properly acquire text_mutex to fix a race condition
      riscv: Stop supporting static ftrace

Andreas Schwab (1):
      riscv: traps_misaligned: properly sign extend value in misaligned load handler

Nam Cao (1):
      riscv: Enable interrupt during exception handling

Nathan Chancellor (1):
      riscv: uaccess: Fix -Wuninitialized and -Wshadow in __put_user_nocheck

Sunil V L (1):
      ACPI: RISC-V: Remove unnecessary CPPC debug message

 arch/riscv/Kconfig                   |  3 ++-
 arch/riscv/include/asm/uaccess.h     |  4 ++--
 arch/riscv/kernel/ftrace.c           | 18 ++++++++++++++----
 arch/riscv/kernel/traps.c            | 10 ++++++----
 arch/riscv/kernel/traps_misaligned.c |  2 +-
 arch/riscv/tools/relocs_check.sh     |  4 +++-
 drivers/acpi/riscv/cppc.c            |  2 --
 7 files changed, 28 insertions(+), 15 deletions(-)

