Return-Path: <linux-kernel+bounces-761203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D4B1F5BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97277B14AA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB4276058;
	Sat,  9 Aug 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kpXwlQ3L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09B1C5F39
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754762553; cv=none; b=l7taFVdbsZKQ2GzpGJqamDQXWOCRyPbKFAF0RIHOGQYRxnuJfg8BMK6O37sL5BgGwLuVl8QBItyGdi5fz4h3C2OvsU74B178ttlxkZ/bSgdQE0Jm4DqUBzQYt6FYMe0798bLBQk75E8IgpX5SpH8KFuWSh5y9OnmvtwZtCw0Bfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754762553; c=relaxed/simple;
	bh=+cK225Tw9bZoaT8RiMlI8lOogVZqkBcgpFO2ENfe9zI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=crrCWWJ2EjPW4IeXE+/xSd+n+N7iURTAuQQLzuzqWs4Squim/rtTUtUPcWUpLF79OLMYG+mt50oX7tZjFxHkrOTWUthFjkxRonYqAp7SpnsXhMsMDBiJDhZept74XXM4+nDoLgDXZqVPhnwJmq468MJK7UC+wOBQ+b8ae9I+1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kpXwlQ3L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6294840E0191;
	Sat,  9 Aug 2025 18:02:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id swfdR79o-Nm0; Sat,  9 Aug 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754762538; bh=Fn250KGrDvUrAWazXEhchqrxBKezcAu7yzoxKmCPwUU=;
	h=Date:From:To:Cc:Subject:From;
	b=kpXwlQ3LrGGjcnPxzht0diAJzPn4oGjWpov8o8OrSV1CMi9YGAh8meCuOWAIhp6u+
	 fl2HXxHpXYB07M1uI0Lk64xQ4mU+dZAn3FT9AmxPwY/EWTF0FSQL5dbDjKUlPCdC4/
	 z7e6hgU9FRFFD8ynio9t80Bck3F4f/9joy35u0dGCti5rg4wruFC2X+BxWQIUHiurh
	 +kvxZIoNqEZQcf9vd2lA/UexeilC9JO8FQA7mvo5RVm6CaAOlyQrrHC30G0ckV5x5u
	 KN6ET/u79KXSD5sT8tnIXfFq9iORNmJfo+lVobbdMRLLzrC/ZACjixhPYNLZXi+3LH
	 bAJSyEUDmtG6LR8PJnyehAeGxJWeaswwg5iUDv7GyyMmpUTpsHoLdMEETzQ8GC/+5E
	 geBQqmRWmo+UjLN+fXsVW6z29+nJTGmE3M+bNyAmXa4YNw3qCNGCVziMtA+X7+zPEf
	 L7TryqCkEGxwBl/3bqYedL0KNEOCGFPR+oAQFOj3VWG73BfONqbwv7zDAFXuSZyc2b
	 KyhO9WYrIcTrckfSjtrbtFDrfIrOsP/hosSn7I0mFRUWQdN52AQz1d9471k7Yqpo9x
	 6vfHZEKc0+pTMwNj+yvwGc24CbqpG0CCXxjoAaPg7AcfT/7JS6N80si8fP3PCAD64B
	 DtLPPObXJe8j8A/da/RSWK00=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25E2E40E00DC;
	Sat,  9 Aug 2025 18:02:15 +0000 (UTC)
Date: Sat, 9 Aug 2025 20:02:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.17-rc1
Message-ID: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a locking/urgent fix for v6.17-rc1.

Thx.

---

The following changes since commit 98e8f2c0e0930feee6a2538450c74d9d7de0a9cc:

  Merge tag 'x86-platform-2025-07-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-07-29 20:05:06 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc1

for you to fetch changes up to e703b7e247503b8bf87b62c02a4392749b09eca8:

  futex: Move futex cleanup to __mmdrop() (2025-08-02 15:11:52 +0200)

----------------------------------------------------------------
- Prevent a futex hash leak due to different mm lifetimes

----------------------------------------------------------------
Thomas Gleixner (1):
      futex: Move futex cleanup to __mmdrop()

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

