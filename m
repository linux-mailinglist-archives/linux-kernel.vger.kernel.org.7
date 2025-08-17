Return-Path: <linux-kernel+bounces-772413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3B7B29251
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CA719665F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97A220F2C;
	Sun, 17 Aug 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ftvqPqvf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264122068B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420181; cv=none; b=UOoYx7CSrO92WZJAPBkY51eZmhh80CSTFuiSenpwOWOizAWD+mX2uIg1Az8DBMpMmb/IVE4bouPkkse/T9+2hLq8gMuo8RUzVFQk15DWDIhWgzmg6917Sq5T6GMaxQ7QeKxGJWtycEOYkP/7VQrChoZp6GXFRJz5twqfLm4g2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420181; c=relaxed/simple;
	bh=jLvII5gw8wKc83IZ7oomK2SIqox1rNj/UaTnaHMA3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FrNnOHdlUd2a6R903KNtI+87NPVJGFupEF4GJTGJKgFlp5PHJ4zAtV134GmC3itPItFuX3zeZW3+itoMnMTNAKYSa+G4HilftCzMZVkU0g6kUfhheZqt6dvg08ifEzGZ8or4wBKV6o5oOg7MCG+bfGYoWItY7HhqklHakPRpXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ftvqPqvf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC9BC40E0202;
	Sun, 17 Aug 2025 08:42:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gauKfWqQ4Lcg; Sun, 17 Aug 2025 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755420166; bh=UdVI9fBHSzENOcHJHpqAGbYTrV18W30SlfpO0nkXor8=;
	h=Date:From:To:Cc:Subject:From;
	b=ftvqPqvfeRptdkM891zUUi8CRPAbXvntSFtnTkpNhZRtyQpmZD4jeMfOtg1zawBOh
	 2dmqYXEP726SRjSwkonS4zqrHRnhq7UaF8oy9xXZaf5wV0Rnz4wPG4oP8v1M7QKuzs
	 6R7Cmu5uF8V2PXv2s+sqHtVopa8hUngbNELGS3WJJnS5hIXUoEg51fLtSaJIj1J+ib
	 +/bqmMYkbsX1ahXqTucuk/qTgJwIFbmA7ZnHJ6nkKQuy4se5fWi2eyKrcw+Yjvf9PE
	 N5fnxLDYDtl0Aq9h+k/a+TjLHUFHxFA1UpRiaumYiCCV+9uv0VR4mHOvVcRJYPoTqt
	 UpYo1WjysGX1nismxNcRQ2NXfz1qwiUIF9PN4M5SFCU52o79bPp+9NyOc05eVJBDh1
	 pLQyEJ4MiJYEQQoQvqEReST+KhqskJPmFVRPa9XYAmwGHnXHCboySRCNqcGx+H9BYb
	 Ph2e1fHNkuAy2ckjFCyjV00t9VAi0/l9TKx9Li+JaBcq/OboGhE6Me4JjMHjP+qLCm
	 pHtrpwv+EngtH+VqWVNRwowAkhVIJduk74nioBaFUgy21U5+DvSVPAcB0m9+jSCjrH
	 l1KQ2JsVUnkoX+9Ik2WCR/l0U4kIMaIR/XnkplP3csb0yxAoy6d4aVA9nOJrqdbUpw
	 BHxE+YRkWjiItOyNMNRzeccw=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA0BD40E0206;
	Sun, 17 Aug 2025 08:42:42 +0000 (UTC)
Date: Sun, 17 Aug 2025 10:42:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.17-rc2
Message-ID: <20250817084235.GAaKGV-7rQHWqTisp3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the locking/urgent lineup for v6.17-rc2.

Thx.

---

The following changes since commit e703b7e247503b8bf87b62c02a4392749b09eca8:

  futex: Move futex cleanup to __mmdrop() (2025-08-02 15:11:52 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc2

for you to fetch changes up to 21924af67d69d7c9fdaf845be69043cfe75196a1:

  locking: Fix __clear_task_blocked_on() warning from __ww_mutex_wound() path (2025-08-13 10:34:54 +0200)

----------------------------------------------------------------
- Make sure sanity checks down in the mutex lock path happen on the correct
  type of task so that they don't trigger falsely

- Use the write unsafe user access pairs when writing a futex value to prevent
  an error on PowerPC which does user read and write accesses differently

----------------------------------------------------------------
John Stultz (1):
      locking: Fix __clear_task_blocked_on() warning from __ww_mutex_wound() path

Waiman Long (1):
      futex: Use user_write_access_begin/_end() in futex_put_value()

 include/linux/sched.h     | 29 +++++++++++++++++------------
 kernel/futex/futex.h      |  6 +++---
 kernel/locking/ww_mutex.h |  6 +++++-
 3 files changed, 25 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

