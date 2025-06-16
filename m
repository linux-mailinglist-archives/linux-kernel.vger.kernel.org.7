Return-Path: <linux-kernel+bounces-688447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7DADB295
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4213A5C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DDB296176;
	Mon, 16 Jun 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EUS3Ivth";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MgW6xC8E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vfhUVOzq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tIZobyKL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693D292B5D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081950; cv=none; b=LhVLn6JuL347ZeZb/sonFiBIVYgySUXgCEmKSHySeuuoZ1gjvwtxuoeIlPAjeJh47KjQH2kdUNgiZ+xti3CfC06OzMP6/hUf+Fvr4uSAq19t7/pNrTqjCpGqlWQ6KOARMYo21XN4BuuEbbeC74Xlh/4iZozEh13mByh4JeRZ4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081950; c=relaxed/simple;
	bh=s3YzOzWaTjYxXpa3cQyEUcIg3S8CrnR96BeKw02Caq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKDgzViVsCZE018E3aL/huFnaiS/6Uu0nuBE3jm8h+BJw4PMoRDpE4J0/7ZCUZIC2K/Q5MOfG2sk6zUj5p31RHLXJzANGxTBF+RizRRDL3H6QFzW96zQjrC8v1ZiF9Ik4uVvf6TOGnwq2o6fYmTfLclO9w398VfzCaF8VyIdAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EUS3Ivth; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MgW6xC8E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vfhUVOzq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tIZobyKL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 367F31F79F;
	Mon, 16 Jun 2025 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750081937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ORTOaEJ/0V7ulfpgFNty+PVV14XRbqmPaznEqXnqKg=;
	b=EUS3IvthS1h/vWDgmXPGgkd1+FohlVD1FpXb4EP0jAR1oxycDpf7hW8k68N0E0A7KhDFFL
	1C5EaRIaLoMdsi2FT9tJEIKnlihhsot32sUZmjJLMBmqVd6nWtfL2t28/ySzyon4LLcOWX
	BgxXkUQHcL2Tu4r9n+8m+PpDS1nMZ40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750081937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ORTOaEJ/0V7ulfpgFNty+PVV14XRbqmPaznEqXnqKg=;
	b=MgW6xC8EBPtZcF8MOKpo3nXjmE/zDtIUVK+yvwx3V0z7mZF0u7ebFR6UkyaTCmdX1R8VPS
	JeH6MG8N4swPu/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750081932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ORTOaEJ/0V7ulfpgFNty+PVV14XRbqmPaznEqXnqKg=;
	b=vfhUVOzqPfvtJEJyPcxsI03RAtyuaN+dH2aLXSJd8nX76rBGWH2YisZ+2JAVxaiBbvYZ2o
	GRnxeKnUTFqOXs8gNYEC8Ae0sV0Xs4AZolpQfpqevDvLXirw+DKXnr37cHGvA8WRnCuieP
	QO/pr+m6x6C/wgEkdy8lg/yo7Z3deO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750081932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ORTOaEJ/0V7ulfpgFNty+PVV14XRbqmPaznEqXnqKg=;
	b=tIZobyKLJsT2uqjre24kAJHC2Z+Y4vwfLMgT1OzfiaFwtBEVBhOljYn61hv6WLoupcB8S5
	kTp8LFXiJuynlmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0AB013A99;
	Mon, 16 Jun 2025 13:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AHegJIshUGhHLwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 16 Jun 2025 13:52:11 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 02/11] mm,memory_hotplug: Remove status_change_nid_normal and update documentation
Date: Mon, 16 Jun 2025 15:51:45 +0200
Message-ID: <20250616135158.450136-3-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616135158.450136-1-osalvador@suse.de>
References: <20250616135158.450136-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,suse.cz,huawei.com,oracle.com,sk.com,gmail.com,kvack.org,vger.kernel.org,suse.de];
	RSPAMD_EMAILBL_FAIL(0.00)[david.redhat.com:query timed out,vbabka.suse.cz:query timed out,osalvador.suse.de:query timed out];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:mid,suse.de:email]
X-Spam-Level: 

Now that the last user of status_change_nid_normal is gone, we can remove it.
Update documentation accordingly.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/core-api/memory-hotplug.rst            |  3 ---
 .../translations/zh_CN/core-api/memory-hotplug.rst   |  3 ---
 include/linux/memory.h                               |  1 -
 mm/memory_hotplug.c                                  | 12 ------------
 4 files changed, 19 deletions(-)

diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
index 682259ee633a..d1b8eb9add8a 100644
--- a/Documentation/core-api/memory-hotplug.rst
+++ b/Documentation/core-api/memory-hotplug.rst
@@ -56,14 +56,11 @@ The third argument (arg) passes a pointer of struct memory_notify::
 	struct memory_notify {
 		unsigned long start_pfn;
 		unsigned long nr_pages;
-		int status_change_nid_normal;
 		int status_change_nid;
 	}
 
 - start_pfn is start_pfn of online/offline memory.
 - nr_pages is # of pages of online/offline memory.
-- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
-  is (will be) set/clear, if this is -1, then nodemask status is not changed.
 - status_change_nid is set node id when N_MEMORY of nodemask is (will be)
   set/clear. It means a new(memoryless) node gets new memory by online and a
   node loses all memory. If this is -1, then nodemask status is not changed.
diff --git a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
index 9b2841fb9a5f..c2a4122ae221 100644
--- a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
+++ b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
@@ -62,7 +62,6 @@ memory_notify结构体的指针::
 	struct memory_notify {
 		unsigned long start_pfn;
 		unsigned long nr_pages;
-		int status_change_nid_normal;
 		int status_change_nid;
 	}
 
@@ -70,8 +69,6 @@ memory_notify结构体的指针::
 
 - nr_pages是在线/离线内存的页数。
 
-- status_change_nid_normal是当nodemask的N_NORMAL_MEMORY被设置/清除时设置节
-  点id，如果是-1，则nodemask状态不改变。
 
 - status_change_nid是当nodemask的N_MEMORY被（将）设置/清除时设置的节点id。这
   意味着一个新的（没上线的）节点通过联机获得新的内存，而一个节点失去了所有的内
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 5ec4e6d209b9..a9ccd6579422 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -109,7 +109,6 @@ struct memory_notify {
 	unsigned long altmap_nr_pages;
 	unsigned long start_pfn;
 	unsigned long nr_pages;
-	int status_change_nid_normal;
 	int status_change_nid;
 };
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b1caedbade5b..94ae0ca37021 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -706,19 +706,13 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	int nid = zone_to_nid(zone);
 
 	arg->status_change_nid = NUMA_NO_NODE;
-	arg->status_change_nid_normal = NUMA_NO_NODE;
 
 	if (!node_state(nid, N_MEMORY))
 		arg->status_change_nid = nid;
-	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
-		arg->status_change_nid_normal = nid;
 }
 
 static void node_states_set_node(int node, struct memory_notify *arg)
 {
-	if (arg->status_change_nid_normal >= 0)
-		node_set_state(node, N_NORMAL_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_set_state(node, N_MEMORY);
 }
@@ -1895,7 +1889,6 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	enum zone_type zt;
 
 	arg->status_change_nid = NUMA_NO_NODE;
-	arg->status_change_nid_normal = NUMA_NO_NODE;
 
 	/*
 	 * Check whether node_states[N_NORMAL_MEMORY] will be changed.
@@ -1907,8 +1900,6 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	 */
 	for (zt = 0; zt <= ZONE_NORMAL; zt++)
 		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
-		arg->status_change_nid_normal = zone_to_nid(zone);
 
 	/*
 	 * We have accounted the pages from [0..ZONE_NORMAL); ZONE_HIGHMEM
@@ -1927,9 +1918,6 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 
 static void node_states_clear_node(int node, struct memory_notify *arg)
 {
-	if (arg->status_change_nid_normal >= 0)
-		node_clear_state(node, N_NORMAL_MEMORY);
-
 	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
 }
-- 
2.49.0


