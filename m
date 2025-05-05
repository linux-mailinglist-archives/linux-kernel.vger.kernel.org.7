Return-Path: <linux-kernel+bounces-632084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE8AA924B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54B43A4C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E242036EC;
	Mon,  5 May 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ueq/TImQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ueq/TImQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD920298D
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445872; cv=none; b=cVII79yvfyN5CI7FiO/duUXNBG+VZ1QsITR+g24FeKd3JGCxwKK1borG14egVmaEcwB3HovPShiDqPyqeATJLKdsyQIXt/v8QbGAMvoz1CtC44PhbkmKGY5x1W8T4vwnlUZ9t9Vpim5OKL7gMjEawhBpdsNsukKjBHQ7lRRsUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445872; c=relaxed/simple;
	bh=jr8Edi/kroFnYhzlPYTU5qQaOazTOdd+r28GGqYCXrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMa6Z2gezqwD5/DwF3JbqSmfeLHySwUPilvGz5i0FAjjlOQSeCIFWkLqZrelrmmOOS6j3hA5bLpqLKyH0Ee+0+0weofV/esG6bGjg5Cd8IoDYEvpimwDPlueuwUTCYYfA5pqlAupK1Qdwx13YGv4SwkjRTEZIoTdkX6Lib5fsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ueq/TImQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ueq/TImQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C09091F791;
	Mon,  5 May 2025 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOI8ODxJkGq4rARRyAkg7GekVbvrcfEDLwIT1TEXOLc=;
	b=Ueq/TImQ9gc58TuuxfvUpjxEEf9uT//pxIgHEBUBfiCbWEeB4HWRioH6hoVKzfckK7dwg9
	GastrQdiyn67wbb5AXSw2tOxq6Ygb9NxfQv2TCfE6v1h+gGCb380qjCdpsxH74+vpUTyOg
	KUvEHxtZDP4QlHWk+74qb1tC5f/gGy4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Ueq/TImQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746445868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOI8ODxJkGq4rARRyAkg7GekVbvrcfEDLwIT1TEXOLc=;
	b=Ueq/TImQ9gc58TuuxfvUpjxEEf9uT//pxIgHEBUBfiCbWEeB4HWRioH6hoVKzfckK7dwg9
	GastrQdiyn67wbb5AXSw2tOxq6Ygb9NxfQv2TCfE6v1h+gGCb380qjCdpsxH74+vpUTyOg
	KUvEHxtZDP4QlHWk+74qb1tC5f/gGy4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A970B13883;
	Mon,  5 May 2025 11:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eRfAKCymGGj3FgAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 05 May 2025 11:51:08 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: eb struct cleanups
Date: Mon,  5 May 2025 13:50:53 +0200
Message-ID: <20250505115056.1803847-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250502133725.1210587-2-neelx@suse.com>
References: <20250502133725.1210587-2-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C09091F791
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This series is about the first patch. See the details there.
The second patch is just a small followup size optimization.

v1: https://lore.kernel.org/linux-btrfs/20250429151800.649010-1-neelx@suse.com/
v2: https://lore.kernel.org/linux-btrfs/20250502133725.1210587-2-neelx@suse.com/

To: Chris Mason <clm@fb.com>
To: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Daniel Vacek (2):
  btrfs: remove extent buffer's redundant `len` member field
  btrfs: rearrange the extent buffer structure members

 fs/btrfs/accessors.c             |  4 +--
 fs/btrfs/disk-io.c               | 11 +++---
 fs/btrfs/extent-tree.c           | 28 ++++++++-------
 fs/btrfs/extent_io.c             | 59 ++++++++++++++------------------
 fs/btrfs/extent_io.h             | 12 +++----
 fs/btrfs/ioctl.c                 |  2 +-
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/subpage.c               | 12 ++++---
 fs/btrfs/tests/extent-io-tests.c | 12 +++----
 fs/btrfs/zoned.c                 |  2 +-
 10 files changed, 72 insertions(+), 72 deletions(-)

-- 
2.47.2


