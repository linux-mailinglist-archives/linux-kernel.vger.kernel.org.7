Return-Path: <linux-kernel+bounces-872074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53790C0F2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CAF1883C13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B430FC17;
	Mon, 27 Oct 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHu9jb4V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11l2RuVJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843592E7BCA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581537; cv=none; b=CzgVbgXwtMxxZ+fUD/BWfKEwlJWoJrS6T+iiDBC0xsaq0Wm/XS7CIDTPxrLfmZCXaTV+A7ffwsnJH+rEKNS1cGbVbWOiGoq2bYZgPvR/nWf2NxF+c3ex7S/32IBFIRm7iUk8HVr3jTu1CqHqwFD6XdGnwxfQo4pYPtnZVC53jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581537; c=relaxed/simple;
	bh=+AxAD6cXRkCK0zBFT5W9Tp7Uyg99jlqYGwQAcKzSLug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5kPF4JrI9y4evqVlcxapc1h7H1OTvIYIMfI6zZ/KDSBxzbuLlAUOpRsQ7UoXp+9auz7CudqXFlrvC7cVE0YehqvFnCPwRXi6bq/AjE6kx9pwl1+F9N7c4NkqCnGaumWv5XTtueR0L0uZ7uXtqf4mBmuqWUGpheIpvHH4Fv1OSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHu9jb4V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11l2RuVJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761581533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5eWcFjEGADCigb9KhEJvQgNT4Xfldi/eaTJqK4pwGOA=;
	b=dHu9jb4VISAs6RTv2umPvwhLGx6+cEepfxYFDNPV3bucHDmJX8po8RoHE8U5BaxAWw/Lfw
	t9UytDRNbUhT1PKqDG3aUvCcdNya2hXvIm9b59gSN0Ne+jlg7dJitxn+ZvlPljshjZsU6v
	VuX4NEivowCvS9Q2CFY/KOtNxwp5CrnHnRAiqW7HskwMTGwefFc40BnU6YFC59aqr1XHfZ
	DAVV2CShWKBanjvkjavQ+DcgrAWnGqM2ufYY9ByxB4wCZXlHtyd7rPdzHzYvo2WHJwlj1r
	N7Y4VKzjadoctJqWEgFfRy8AZKV1MlTeNH+ugOPmxOcM/g0YCXDybSD8Zpwckw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761581533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5eWcFjEGADCigb9KhEJvQgNT4Xfldi/eaTJqK4pwGOA=;
	b=11l2RuVJH18TNG7Vrcf4cezp+McpJ0R5XK2H9vLa4geDOSg0i4ABuZUfPG7L+2T3sn4r4+
	u9hmkivb3XcPyKDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>,
	Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 0/1] allow unsafe write_atomic()
Date: Mon, 27 Oct 2025 17:18:02 +0106
Message-ID: <20251027161212.334219-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of a series to allow unsafe write_atomic() console
callback implementations. This will allow console drivers to
move to the nbcon API, even if they are not capable of NMI-safe
atomic writing. The primary motivation for this series is to
support netconsole. v1 is here [0].

This version is based on the rework/nbcon-in-kdb branch of the
printk git in order to avoid conflicts due to the
console_is_usable() relocation.

The changes since v1:

- Use a global variable to track exactly when it is allowed to
  flush using an unsafe write_atomic() rather than sprinkling
  around similar checks based on states and code paths.

- Remove evil and incorrect WARN_ON() detection in
  nbcon_emit_next_record().

John Ogness

[0] https://lore.kernel.org/lkml/20250912121852.2666874-1-john.ogness@linutronix.de

John Ogness (1):
  printk: nbcon: Allow unsafe write_atomic() for panic

 include/linux/console.h | 19 ++++++++++++++---
 kernel/printk/nbcon.c   | 45 ++++++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 17 deletions(-)


base-commit: 62627bf0cadf6eae87d92fecf604c42160fe16ef
-- 
2.47.3


