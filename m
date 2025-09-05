Return-Path: <linux-kernel+bounces-803119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C93AB45AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29355C1F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93584371EBB;
	Fri,  5 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ytgLZIur"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CA371E95
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083338; cv=none; b=kdj6dcBn2pLsLAfLHiZQL9z/WQ2ho3+Z9FZO7wQFJbRq9qWck/4DF1rLYcg+ybsS0dLNDMXPLZQTPy+Q+V2cI0SHHYQYuJtbfsMoHF01r64wtt4/iJWzanzl+fUbzy9oi5+wIyJbfkg3J/8vG6s4wlypR0ooOliCPwL7F6f2OWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083338; c=relaxed/simple;
	bh=9eltzYkZmtK+BxmHQXqGpEk1gF7d0a/+PriGW7nUgqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aki2AXAQnOlADFCe/a6TxPh9KXyf0fR78fPnRs1aWp+2xQE8xwiumqmrELZqK6eXqKzCUUQm/Wis7TfacBdTiVQ2Qj8AWbSNqO/jJKS5OzYCluXLnENBWUEcR5i8MTOvxn1vLHTXhqCEHs94bN0G8hoIbiySkLLqo0do9WnZKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ytgLZIur; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 90F0881356;
	Fri, 05 Sep 2025 17:42:10 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:181::1:23])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1gjcva4GjSw0-BoSQdVd1;
	Fri, 05 Sep 2025 17:42:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1757083330;
	bh=th2ZQSBv30cxNtEg4v+c2NKSdsluhH8QiJbMw9CukGw=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=ytgLZIur5dSfvXIAUVwM89h96YWDpBGGCHofkvPn2SDh+it74WrnxkWIOHh4sZLnL
	 X2ML13Gh/23NIZxJnwGur6IJP917PrWBakc3D/J9edVzy2WCafarf92JKe9VQvyeqO
	 0P7mh6AV5Xy46Ze3NuefmhW9hI5o+hZNITsYfdUA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data blocks around
Date: Fri,  5 Sep 2025 17:41:50 +0300
Message-Id: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the issue where data blocks would wrap in cases where the last
data block perfectly fits the ring. This caused whatever was at the beginning of
the ring to get discarded in this case, and the data block would get put there
even though it could be put at the end of the data ring just fine without
discarding anything.

Fixing this issue also allows to simplify the check in data_check_size,
previously it would ensure there's space for a trailing id, which we
don't need anymore.

v0->v1:
- Fix severely broken code alignment

v1->v2:
- Rename & invert get_next_lpos -> is_blk_wrapped
- Add a new commit for changing the logic in data_check_size

Daniil Tatianin (2):
  printk_ringbuffer: don't needlessly wrap data blocks around
  printk_ringbuffer: allow one data block to occupy the entire data ring

 kernel/printk/printk_ringbuffer.c | 38 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

-- 
2.43.0


