Return-Path: <linux-kernel+bounces-793309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD33B3D1B6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3403AEDDF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92121B9C1;
	Sun, 31 Aug 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bXWbyvHJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96335957
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633640; cv=none; b=VSXGJBzsukHqnb13q2Jus2QpVMury3GvGGp5A9dzJpELqjzAbH3RrHrAVRP/saeGzi2w0AIFJnWReY0+4CrsdekjbQZVahO19QWgOWphCl29bKuGPt5g0k1t6/LWYftUanK5MevP7iY0vdBBOmXY2MqIYp/Z6pSJ6tWgMyILQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633640; c=relaxed/simple;
	bh=yt/nWbOfXF5kuDgzZuUJGmhBewS7nuhfz/YLaJTeK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OWya12vXQM2Z0h8XUSUMBJ/y/44cBPM8QG89l1IsVM7aSiV1eIUqKFEXMQyZE4/ssryy2bYmTRS5zAxEwqRrZdmnxM3IRR4p9Wre3Aa184gSi5Is/teBIZ8MfrDMlJwXVBLD0cYpC35qKgcMvaHoFpGAaSN459T0VCMCSyeoSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bXWbyvHJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BB0640E0174;
	Sun, 31 Aug 2025 09:47:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id D3P6908lrtC4; Sun, 31 Aug 2025 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756633633; bh=Ex6N/qYolfsJukMvyP32lwQ1imWZyzMMc+ndqeYOpRw=;
	h=Date:From:To:Cc:Subject:From;
	b=bXWbyvHJ+vMzPHoHlTV7djwMR0w+to44nL7s/MOLOOkcLKrr4N0GvDUKj+ej89P5F
	 fUEDuqWb3LUmN+fWfvoVLZgb+O7HiUsk82MPbcbIp1qCsuXfse0F6ueesqMKlkrIed
	 xhaZljjtdIIEzU666qY+u9BTZoUOLe0AZVpZah8fjIaoaXb13nK8HsP3Z5ai7QRwKC
	 bHngaedHL6mSi3f2Dd/GjX9GwfxZQBxGzfLbfhNYlng5AbrjWjSDQBbXPBEaNK6Wqe
	 FaLzMeGBwb5bWBAQOXFceGde2c1XnGPg/eAKfbfKyOQ2Cc+kCl5zE/KBNsfBZ4wild
	 X9KquN7GRhVTpjqV6ngbQn/kiyjr4g0Q/Nfq6ZFXr6WYH4RanFL/EErojhan8DTd0t
	 c7FzC0Q/de1Uf9HguUoyq6oLPENqWHjUeA78N9uw0pqe6nOJVZHOPxb08Vzd8lpT4g
	 oHbcWeeu8tuslf3ibIOsJl4fSohBm4OxQTK/eG243UfkiEHGGchGVlXuBDzXR8mecm
	 ieMuYbBLHZREdb1Ji1YMrNyyaK0dU2NgPc0j/tPl8q/xkOxpsGZOxbRHuwM9JDPyBf
	 7nPMKd2hQJNDUV8CWChNwPx8dLCKBzuSGHVmMoC8pI3dVBf3MCFYBp13nWMPifz1hz
	 sDVyUPuA84gaBOiCh2yMqjHE=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id D829B40E016D;
	Sun, 31 Aug 2025 09:47:09 +0000 (UTC)
Date: Sun, 31 Aug 2025 11:47:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.17-rc4
Message-ID: <20250831094701.GAaLQaFRBnUhtbH-Tw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the sched/urgent lineup for v6.17-rc4.

Thx.

---

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.17_rc4

for you to fetch changes up to 52d15521eb75f9b521744db675bee61025d2fa52:

  sched/deadline: Don't count nr_running for dl_server proxy tasks (2025-08-26 10:46:01 +0200)

----------------------------------------------------------------
- Fix a stall on the CPU offline path due to mis-counting a deadline server
  task twice as part of the runqueue's running tasks count

- Fix a realtime tasks starvation case where failure to enqueue a timer whose
  expiration time is already in the past would cause repeated attempts to
  re-enqueue a deadline server task which leads to starving the former,
  realtime one

- Prevent a delayed deadline server task stop from breaking the per-runqueue
  bandwidth tracking

- Have a function checking whether the deadline server task has stopped,
  return the correct value

----------------------------------------------------------------
Huacai Chen (1):
      sched/deadline: Fix dl_server_stopped()

Juri Lelli (1):
      sched/deadline: Always stop dl-server before changing parameters

Yicong Yang (1):
      sched/deadline: Don't count nr_running for dl_server proxy tasks

kuyo chang (1):
      sched/deadline: Fix RT task potential starvation when expiry time passed

 kernel/sched/deadline.c | 18 ++++++++++++------
 kernel/sched/debug.c    |  6 ++----
 2 files changed, 14 insertions(+), 10 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

