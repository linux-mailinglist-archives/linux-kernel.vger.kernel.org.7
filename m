Return-Path: <linux-kernel+bounces-890497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CCC40322
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B573B1056
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E931BC96;
	Fri,  7 Nov 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hv/VOq3E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IcTGpFhS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A991D31B9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523516; cv=none; b=EMjadKBMSh+A5AFTnE5PeWllauiijudyvl5PlGXmzShl+Z8DBSOj5BuAiP82QzoiTKH0Z8SSZlToXuhZM8yFBIa7iqXI6s+kB9ZiAZmnf/hLwiaZgYAyDxd7rYZa1Wpi0e6mLrCuB89PJWgIPWXbyd3Q2OJiyWsYM1myI4b9Ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523516; c=relaxed/simple;
	bh=zOhrY5GaYQzKSZYFPVRNOLzmbILZydfiFpKWaRoudBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaMHpOCzY/5a3WvRYp/nkB8nAUqx/NqlMgL++TwG3t6flsSnaZKB39AMY84BlngIZ37dGDpWYmuyF4XA9iTFuVcdlm1Z56K4sUJEpR/Qm4/kjMsww/YQvoNgPln/1SpuZ7gpoNXRSKw93XI76V13yL5F56KS8gmLxTe8v2yzSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hv/VOq3E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IcTGpFhS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A28711F457;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qvlsbcBZ089j/NzKsFpZxKXLw4TpiqdOIdH9JEv6Go=;
	b=hv/VOq3EaIjugnpTHlyuexxWXtm8g/2kpUkHkEFcLqzbntwk2VQbs/0UADiHRwjhEtXgVe
	9m0saOZMtKmuS66+fWVSxLn8YvoHdn0DqSwX8bkqgKhL1V+eDBzv9HHlmxCsDMi4/Rb8i2
	fNLiaPvX+3KLs5VK5onNE6RPbRYJnMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qvlsbcBZ089j/NzKsFpZxKXLw4TpiqdOIdH9JEv6Go=;
	b=IcTGpFhS0Io25VB39gRKl5Bm2aB2cTMdBHcJp96/4WXPT1fzF1fsjhk6rcG35ZFRNzav70
	D1mjH+OKDBcGa2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E64F13A67;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8C5zInL5DWlFCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Nov 2025 13:51:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 07 Nov 2025 14:51:24 +0100
Subject: [PATCH 2/4] slab: turn freelist_aba_t to a struct and fully define
 counters there
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-slab-fms-cleanup-v1-2-650b1491ac9e@suse.cz>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
In-Reply-To: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A28711F457
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

In struct slab we currently have freelist and counters pair, where
counters itself is a union of unsigned long with a sub-struct of
several smaller fields. Then for the usage with double cmpxchg we have
freelist_aba_t that duplicates the definition of the freelist+counters
with implicitly the same layout as the full definition in struct slab.

Thanks to -fms-extension we can now move the full counters definition to
freelist_aba_t (while changing it to struct freelist_counters as a
typedef is unnecessary and discouraged) and replace the relevant part in
struct slab to an unnamed reference to it.

The immediate benefit is the removal of duplication and no longer
relying on the same layout implicitly. It also allows further cleanups
thanks to having the full definition of counters in struct
freelist_counters.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 52 ++++++++++++++++++++++++----------------------------
 mm/slub.c |  8 +++++---
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 078daecc7cf5..42627b87d50c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -40,13 +40,29 @@ typedef u64 freelist_full_t;
  * Freelist pointer and counter to cmpxchg together, avoids the typical ABA
  * problems with cmpxchg of just a pointer.
  */
-typedef union {
-	struct {
-		void *freelist;
-		unsigned long counter;
+struct freelist_counters {
+	union {
+		struct {
+			void *freelist;
+			union {
+				unsigned long counters;
+				struct {
+					unsigned inuse:16;
+					unsigned objects:15;
+					/*
+					 * If slab debugging is enabled then the
+					 * frozen bit can be reused to indicate
+					 * that the slab was corrupted
+					 */
+					unsigned frozen:1;
+				};
+			};
+		};
+#ifdef system_has_freelist_aba
+		freelist_full_t freelist_counters;
+#endif
 	};
-	freelist_full_t full;
-} freelist_aba_t;
+};
 
 /* Reuses the bits in struct page */
 struct slab {
@@ -69,27 +85,7 @@ struct slab {
 #endif
 			};
 			/* Double-word boundary */
-			union {
-				struct {
-					void *freelist;		/* first free object */
-					union {
-						unsigned long counters;
-						struct {
-							unsigned inuse:16;
-							unsigned objects:15;
-							/*
-							 * If slab debugging is enabled then the
-							 * frozen bit can be reused to indicate
-							 * that the slab was corrupted
-							 */
-							unsigned frozen:1;
-						};
-					};
-				};
-#ifdef system_has_freelist_aba
-				freelist_aba_t freelist_counter;
-#endif
-			};
+			struct freelist_counters;
 		};
 		struct rcu_head rcu_head;
 	};
@@ -114,7 +110,7 @@ SLAB_MATCH(_unused_slab_obj_exts, obj_exts);
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
 #if defined(system_has_freelist_aba)
-static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)));
+static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(struct freelist_counters)));
 #endif
 
 /**
diff --git a/mm/slub.c b/mm/slub.c
index 5f6408c9e0fd..8330e4f8b3b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -764,10 +764,12 @@ __update_freelist_fast(struct slab *slab,
 		      void *freelist_new, unsigned long counters_new)
 {
 #ifdef system_has_freelist_aba
-	freelist_aba_t old = { .freelist = freelist_old, .counter = counters_old };
-	freelist_aba_t new = { .freelist = freelist_new, .counter = counters_new };
+	struct freelist_counters old = { .freelist = freelist_old, .counters = counters_old };
+	struct freelist_counters new = { .freelist = freelist_new, .counters = counters_new };
 
-	return try_cmpxchg_freelist(&slab->freelist_counter.full, &old.full, new.full);
+	return try_cmpxchg_freelist(&slab->freelist_counters,
+				    &old.freelist_counters,
+				    new.freelist_counters);
 #else
 	return false;
 #endif

-- 
2.51.1


