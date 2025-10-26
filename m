Return-Path: <linux-kernel+bounces-870305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C5C0A6D2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399851899668
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292421B9DB;
	Sun, 26 Oct 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aRuDIKTr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908918C02E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761479382; cv=none; b=MIze3gT+KuYhOGbw5qsNugK21UAzsz68Gb2OsSPhJK/NFBhdB4fbPZekGRl3pRJ1WYyy1S77PCsSGIKqPYgGJ9UPfiayBg+XBJ1aFtFCRkLw+0nyX3VpCRlK35+M2ZMxfOFoxqRWwU+XSVZ7XeuAH1oPfqG/flGKOvxJIca3j/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761479382; c=relaxed/simple;
	bh=+c6gnDHdizWFM2aJ9s7CjAfnK9queXW1PgFJPxbezy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q4AgwUQUsahwKkfjjiqQKNpSdekx6c/vfocNeLKvI6wxasgrBbf+2FW48yFiI08FcZ0XaDv5NclSqs6Er0NoAMiwidmD1OM+5h95WC9rIKujMREuvLKpj1lM1JK5uefB/3JIeM5bAKvGi4AXbRgF+p9D32g49xTkHTZm/f54yF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aRuDIKTr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 42E9540E01CD;
	Sun, 26 Oct 2025 11:49:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MCTy6LrBDGzV; Sun, 26 Oct 2025 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761479374; bh=+QW1aNHKkGN4HEnv6uvz4tZTRlDVkfcIsA7j1DlikFY=;
	h=Date:From:To:Cc:Subject:From;
	b=aRuDIKTrRKLZR1W/8St9fScbSXVKmvGjC5uPxyHNMoVblKEONjg3KeZ0Qnz53wXAn
	 So50pHmyJx+/HsUs06UFRdZUMnArozU9n1+mwCxpudny3OOcfs1KrO6h7Wg3orZ9HN
	 MVVydEIQxW88gnZaZQDWyN6lHL5/JVt7+F2YDi/xt9/kj4PUdTP3mGI8XcKElB99X4
	 qJ8fpjFQ2295rcwse5/eRsW1IbIotDs+bROoD8gakBCi1F7cYahBpgSUb7AK8OB43Q
	 O0INV8m10wN+Ysjp6Zs8uvugzawrc6vxopXD1G3IMd0/pb5qd7XZpUZALoLlnrDT5T
	 vWLRrX7mwt9WOaSBH1+bNEOenUjS5RbnwWOQ2d3wX+scrnglJJWKvMezRfsSIhgIv5
	 xYE4OBT0oQUKcEGSVPD+3DyyTVIYr3VPnTIksX17ac5IsCy31WUMPDQqlzm54VoQlu
	 HkOgF0+chQfkX0b4hooAnhhgok3GDsTPNR8sZZbjnk49VNzwOAPCox6YjuuQ2+nXyV
	 cWHfv9Ytjl71YCao0GUeDJFQRdjw/413QAkwcichWNTr/Z/21T21s+33/RWrXwjEsj
	 SMSxaVsjfPNuy54hip/5GrAtw8I3VLQLFIVUBin2T9/62m0hZjFTg9m7dU9dCnrxME
	 WdMT/f8Z/BCWdAeT6CEuxbfc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8D4B640E019D;
	Sun, 26 Oct 2025 11:49:31 +0000 (UTC)
Date: Sun, 26 Oct 2025 12:49:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v6.18-rc3
Message-ID: <20251026114925.GAaP4KxfT1-DpmVBpp@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a sched/urgent fix for v6.18-rc3.

Thx.

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/sched_urgent_for_v6.18_rc3

for you to fetch changes up to 0e4a169d1a2b630c607416d9e3739d80e176ed67:

  sched/fair: Start a cfs_rq on throttled hierarchy with PELT clock throttled (2025-10-22 15:21:52 +0200)

----------------------------------------------------------------
- Make sure a CFS runqueue on a throttled hierarchy has its PELT clock
  throttled otherwise task movement and manipulation would lead to dangling
  cfs_rq references and an eventual crash

----------------------------------------------------------------
K Prateek Nayak (1):
      sched/fair: Start a cfs_rq on throttled hierarchy with PELT clock throttled

 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

