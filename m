Return-Path: <linux-kernel+bounces-730544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62799B0460E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADFE3B3F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F023D29F;
	Mon, 14 Jul 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLL1hAwN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLL1hAwN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FA1C683
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512584; cv=none; b=dtjnGSWdxQXVFxncSz93CErUmZiqjrRUtv5+eSnMr5wgTc4zHR0Crmh37ooPNtLIR+QBpXApAGG9Y/8fYqBUWg85/gxvOnRsd+GjJq/njQL2fGMlEtkerhYnA0FrCXRlDJbS/abmGtY7sGmZMNMwAJfUvx27BgO+uTKrskP5vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512584; c=relaxed/simple;
	bh=j832G1nWvFFUcdxP8l+arfRvKR7ywRTjhagzFED8RHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=snEOED4g+QL58nt1ivayWRtpRZfceDqXDbne3y3gHuGEcM2ZIotUhRc8uRna6Pi15z2polTz4109U7Jt3fHSxIBAhOVR+pTXTmo7wRVDSXWq/LHfwancHFUhfS8ObRK1jvFa/qAQVY7kh7IaltncdigNPZcThASzEMth7UeJbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLL1hAwN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLL1hAwN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CB9A21207;
	Mon, 14 Jul 2025 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752512580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WzNIDiTEMhdVvGvqcz1MXwJ40NRaau1t4v75zl/IhnA=;
	b=mLL1hAwNd0dzYP7L4wVwSTBa3Trwj6suDeRDajHwEe1PKr14wVIVycf2HubvZ4gpR4L/SV
	Zl4gRdkWxsRBeIAev4o+70l7EIUzbPaeEpHRi6MNVb9Kv/s18Sx8RC9bkPiOeri3faEAA+
	xhsu4qwqwHrXDRGW04+8S3hVkG8KS8o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mLL1hAwN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752512580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WzNIDiTEMhdVvGvqcz1MXwJ40NRaau1t4v75zl/IhnA=;
	b=mLL1hAwNd0dzYP7L4wVwSTBa3Trwj6suDeRDajHwEe1PKr14wVIVycf2HubvZ4gpR4L/SV
	Zl4gRdkWxsRBeIAev4o+70l7EIUzbPaeEpHRi6MNVb9Kv/s18Sx8RC9bkPiOeri3faEAA+
	xhsu4qwqwHrXDRGW04+8S3hVkG8KS8o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0443F138A1;
	Mon, 14 Jul 2025 17:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUdVOUM4dWhjUwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 14 Jul 2025 17:02:59 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: dave.hansen@linux.intel.com
Cc: mingo@redhat.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/mm: Remove duplicated definitions
Date: Mon, 14 Jul 2025 20:02:58 +0300
Message-Id: <20250714170258.390175-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6CB9A21207
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

__PAGE_KERNEL(_EXEC) is defined twice, just remove the superfluous set.
No functional changes

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/pgtable_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b74ec5c3643b..a5731fb1e9dd 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -214,9 +214,6 @@ enum page_cache_mode {
 #define PAGE_READONLY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
 
-#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
-
 /*
  * Page tables needs to have Write=1 in order for any lower PTEs to be
  * writable. This includes shadow stack memory (Write=0, Dirty=1)
-- 
2.34.1


