Return-Path: <linux-kernel+bounces-619767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFEA9C0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A849A58A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F82356BF;
	Fri, 25 Apr 2025 08:28:04 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47352356B0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569684; cv=none; b=Mmqjhwd03NY0QE/XmDLWE8xmh+ULWAXc3cxkoANLLE16kH99qfsJ0B8lSw6J1W2xsJNDtsM0UwLIRfAjywCudrMO8wfnpI3PApERsUoBtgUyZ/cPJRHs75Scn4O2LXF4LvmiDpbxP5Yz+kaF4DKpIjX6+3ySy9DINoPoTy0vZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569684; c=relaxed/simple;
	bh=6rOKxS5Hw2eNy9jVAw1WmtWuouSghuBsncuIjmFyLSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py6OWta4SSYAkEFP12ddLFqCHSa0zL5akij0qQWsN9GuGrHjVAwaJjY6oDW90DthMT9KvAM/KJsLNvMGa9CXK7BIzXLE801Qe2SPvLKy8c/Urv0d+ViqZFr8vkCnokJG8MxsG1Yz00UxVvsU1aCgqlSfDSdjDbMRa5UWrViKeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04ED91F38E;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E27E813A80;
	Fri, 25 Apr 2025 08:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEQDN4hHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:52 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:24 +0200
Subject: [PATCH v4 4/9] slab: determine barn status racily outside of lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-4-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 04ED91F38E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The possibility of many barn operations is determined by the current
number of full or empty sheaves. Taking the barn->lock just to find out
that e.g. there are no empty sheaves results in unnecessary overhead and
lock contention. Thus perform these checks outside of the lock with a
data_race() annotated variable read and fail quickly without taking the
lock.

Checks for sheaf availability that racily succeed have to be obviously
repeated under the lock for correctness, but we can skip repeating
checks if there are too many sheaves on the given list as the limits
don't need to be strict.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 724266fdd996c091f1f0b34012c5179f17dfa422..cc273cc45f632e16644355831132cdc391219cec 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2758,9 +2758,12 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *empty = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_empty) {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty,
 					 struct slab_sheaf, barn_list);
 		list_del(&empty->barn_list);
@@ -2807,6 +2810,9 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *sheaf = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full) && !data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
 	if (barn->nr_full) {
@@ -2837,9 +2843,12 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
 	struct slab_sheaf *full = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full) {
+	if (likely(barn->nr_full)) {
 		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
 					barn_list);
 		list_del(&full->barn_list);
@@ -2862,19 +2871,23 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
 	struct slab_sheaf *empty;
 	unsigned long flags;
 
+	/* we don't repeat this check under barn->lock as it's not critical */
+	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
+		return ERR_PTR(-E2BIG);
+	if (!data_race(barn->nr_empty))
+		return ERR_PTR(-ENOMEM);
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full >= MAX_FULL_SHEAVES) {
-		empty = ERR_PTR(-E2BIG);
-	} else if (!barn->nr_empty) {
-		empty = ERR_PTR(-ENOMEM);
-	} else {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
 					 barn_list);
 		list_del(&empty->barn_list);
 		list_add(&full->barn_list, &barn->sheaves_full);
 		barn->nr_empty--;
 		barn->nr_full++;
+	} else {
+		empty = ERR_PTR(-ENOMEM);
 	}
 
 	spin_unlock_irqrestore(&barn->lock, flags);

-- 
2.49.0


