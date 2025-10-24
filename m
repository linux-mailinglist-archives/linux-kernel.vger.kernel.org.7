Return-Path: <linux-kernel+bounces-868520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4EC05632
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B183BDBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2D30BB90;
	Fri, 24 Oct 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrzCA3KC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xkpbhDy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mRm1e6Qt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3OOr9Fx0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4E307AC7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298796; cv=none; b=V6ly6rFxqv68ZbSaWezPwq/9f+loVRtbv8uYgkCCg4v4gYaxuLD8g67gFbq1inEN8dJKE8RaYB59980MIry5MbjQhPCZS7Qp/G4PDIrzvHD9VeZqj3BdzBtdnvCHS1w7kQ3Ou7Vj2KhsESWEvXr6yXY6hu3vcqXhy0hPEc8p70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298796; c=relaxed/simple;
	bh=k19w2+x8oDv1raeyzUWLXRjDjzyp6DRPLMb+hrxnPl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDWElfsXsVEOur6g2G3p5P6wTUtPR6IG2ydA/f3oO4mAPHeMQId3PsYGDNXG260IRmw1asNtbcKPWyh153YiPDINnKbdoRCz1stg52y+GJ9VLurnVfDwMXvbGsqOMKnMyo/5OQMCIKxMpP+jYfC9iQwZLWKZy1f9+A/2TXCxwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrzCA3KC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xkpbhDy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mRm1e6Qt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3OOr9Fx0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 277E521208;
	Fri, 24 Oct 2025 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761298788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HaeU5LbPknUgXKPUkJQnm2Eei92xzLJh6du52BkuqtA=;
	b=RrzCA3KCRESdRNCEsTw5XqDS0TnaN7YW6KgYWy/NZ4ql7+WHEPhzf6lK3lo9VfXGhQl7Ct
	sqMHRWch8Ho6W5reGwlom8aY03JRMjFN102NCTcBMT4ZFFqL9tHvDkJHqHdaReKdQgS+ne
	dp2JItXqSv4vFqRyvyAmGM75QBDFtJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761298788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HaeU5LbPknUgXKPUkJQnm2Eei92xzLJh6du52BkuqtA=;
	b=3xkpbhDy2G0quZ8iCxYPCL22vW1lCUfs3Fzh8h1xV5XORy0YeFxUzJ2ZPM/Y96jbRBrd6Q
	4HKmEUgeLg+bvrAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mRm1e6Qt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3OOr9Fx0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761298784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HaeU5LbPknUgXKPUkJQnm2Eei92xzLJh6du52BkuqtA=;
	b=mRm1e6QtA7ifuVnhcBcm22FOsKGeWC4VhNWn1dIoJAavxc9ViIz9pHaCVYAnuv8J077jGl
	LmkRmW4OSii079a/+XERAHDYbUTaZYSKgkplJ9OMJ80iFDvzy6u2y53NZQkXihpHEOEYMZ
	phhzTn8CB1VERSzNSe4bNpN0aP9Zlog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761298784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HaeU5LbPknUgXKPUkJQnm2Eei92xzLJh6du52BkuqtA=;
	b=3OOr9Fx05gyUFr0wK3a4n2/BU0ArJP3tzJF828bttoQ+ByfNCrMTDTicvRuqaUZJb0Akte
	302zmNe8OQmnr6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1160F132C2;
	Fri, 24 Oct 2025 09:39:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3VjjA2BJ+2g0HwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 Oct 2025 09:39:44 +0000
Message-ID: <8b152d73-ecc4-415c-acdc-3f5105412ac0@suse.cz>
Date: Fri, 24 Oct 2025 11:39:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20251023143313.1327968-1-hao.ge@linux.dev>
 <aPs-sKOJQs-OelVM@hyeyoo> <49a186cf-c248-45ff-a61c-a6de1a3a98b7@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <49a186cf-c248-45ff-a61c-a6de1a3a98b7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 277E521208
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/24/25 11:27, Hao Ge wrote:
> Hi Harry
> Hi Vlastimil
> 
> 
> Thank you for adding V2 to your tree. Now, should I resubmit V3,
> 
> or can you assist with making these modifications in your tree?

Massaged it a bit more and now have this:

commit b4bdf6770cadb8bffcf3dce7ad7a346979f79ede
Author: Hao Ge <gehao@kylinos.cn>
Date:   Thu Oct 23 22:33:13 2025 +0800

    slab: Fix obj_ext mistakenly considered NULL due to race condition
    
    If two competing threads enter alloc_slab_obj_exts(), and the one that
    allocates the vector wins the cmpxchg(), the other thread that failed
    allocation mistakenly assumes that slab->obj_exts is still empty due to
    its own allocation failure. This will then trigger warnings with
    CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in the subsequent free path.
    
    Therefore, let's check the result of cmpxchg() to see if marking the
    allocation as failed was successful. If it wasn't, check whether the
    winning side has succeeded its allocation (it might have been also
    marking it as failed) and if yes, return success.
    
    Suggested-by: Harry Yoo <harry.yoo@oracle.com>
    Signed-off-by: Hao Ge <gehao@kylinos.cn>
    Link: https://patch.msgid.link/20251023143313.1327968-1-hao.ge@linux.dev
    Reviewed-by: Suren Baghdasaryan <surenb@google.com>
    Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/mm/slub.c b/mm/slub.c
index 87a1d2f9de0d..d4367f25b20d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
-static inline void mark_failed_objexts_alloc(struct slab *slab)
+static inline bool mark_failed_objexts_alloc(struct slab *slab)
 {
-	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
+	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
-static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 			struct slabobj_ext *vec, unsigned int objects) {}
 
@@ -2124,8 +2124,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 				   slab_nid(slab));
 	}
 	if (!vec) {
-		/* Mark vectors which failed to allocate */
-		mark_failed_objexts_alloc(slab);
+		/*
+		 * Try to mark vectors which failed to allocate.
+		 * If this operation fails, there may be a racing process
+		 * that has already completed the allocation.
+		 */
+		if (!mark_failed_objexts_alloc(slab) &&
+		    slab_obj_exts(slab))
+			return 0;
 
 		return -ENOMEM;
 	}


