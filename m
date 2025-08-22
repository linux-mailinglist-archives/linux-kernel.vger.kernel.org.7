Return-Path: <linux-kernel+bounces-781147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65471B30DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420D6189437C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B92E1F0A;
	Fri, 22 Aug 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SMnpxR49";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yest83Kc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322217BB35
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840686; cv=none; b=CTVzIIW4u3JSRMwCSZLR2iitX7gldbaXSgC79yuyq2iUDle3oSlBQKATvFG3s3aX5sZLBMTBOPZx/oAUN5Rsq6xlJ1W70SAh1EaWJTyUfB2O0wpTOqMuamVCjd+Rc58X85YOg1l2qz9HgL7Gf+f+rR8ttSSvzxl+lHniYjILKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840686; c=relaxed/simple;
	bh=dTkGEsDxuHxvzQ/zuRn7NlikI8/ywmvZmlgu+WQIL+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Go99dw8/lDIKY6nIdB9U3w6rP+yosF81IPoXVKs5EHJbaaSv9gBTTSnUtHn+aNOpdL2uBcXRz1kKmdqKXIjtXkVo0PxLUzGxhYK4g4uYZalH0U/YJz/1IHYl6dIEYeWLXYvZnK7jN+Y/9zCWOUbht7zGBCk/9dirphj/ArTSIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SMnpxR49; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yest83Kc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 038D721E3E;
	Fri, 22 Aug 2025 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755840682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t4yhiDG7pnnHGOYG9tLhM3AjIpjpSUErxIas3N0XuJI=;
	b=SMnpxR49bglg7Ftr94YtzbFpS+ikumwhs8a31QVXR9JNF0o0koOLWKPifkHIovXu2muxnY
	IaIaIQikXW8gDqlbMzMgJLEu6jcEvmBVzW1oF+m7YCsztmraHc4RRkyFRgbYZB7tsxPcWS
	i2SXhnfgqnz+55uUigQJuNaReR79JJE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755840681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t4yhiDG7pnnHGOYG9tLhM3AjIpjpSUErxIas3N0XuJI=;
	b=Yest83Kc32HjMHUx6dp+KZogufXEiwF3G+PR8Hh+5SvZuTqH2O98QPzmTzGqpJ/8IemS5O
	yZKgNNY2EQMoF+70QSHoIJBMzZj0sXykTlRHBFoknDndIRz4/DYYAadRJCYgqsWp/bMv48
	s+egS5cNKgcEpPjkxKxHRge+DlSZ8jM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B95B8139B3;
	Fri, 22 Aug 2025 05:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3fotK6gAqGgxaAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 22 Aug 2025 05:31:20 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.17-rc3
Date: Fri, 22 Aug 2025 07:31:20 +0200
Message-ID: <20250822053120.31771-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc3-tag

xen: branch for v6.17-rc3

It contains 2 small cleanups which are both relevant only when running as
a Xen guest.


Thanks.

Juergen

 arch/x86/include/asm/xen/hypercall.h |  5 +++--
 drivers/xen/xenbus/xenbus_xs.c       | 23 -----------------------
 include/linux/compiler.h             |  8 --------
 3 files changed, 3 insertions(+), 33 deletions(-)

Jan Beulich (1):
      compiler: remove __ADDRESSABLE_ASM{_STR,}() again

Juergen Gross (1):
      drivers/xen/xenbus: remove quirk for Xen 3.x

