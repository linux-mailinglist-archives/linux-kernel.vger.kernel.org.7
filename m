Return-Path: <linux-kernel+bounces-647716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73227AB6C21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BE01899FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A51F4CAB;
	Wed, 14 May 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="trno/NzF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ImztO0JU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="trno/NzF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ImztO0JU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F927702E
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227986; cv=none; b=cOcWxtHRdk8l5du9jlIQ8GxJrQxHbk/e3uY2uTnqRrsCYDaC+LHKPo8cazMGRBIr7sT9orTpPzIZP/qQ8Ud80Db6tvZlO5jZLfgbsFzIeIL7oj90xPnjEq6O7XjWf0Nir+O14xH8QbUwl3p9Ei2DI4Z0blz3qSEHpuKifDt4YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227986; c=relaxed/simple;
	bh=LLFq3O0FdrDdvqxZRkBsqmZ5QAf1LxMqNh4TVhrgZ8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoykM8PQ2LO+xcWRlaCjluzavoqUj/p23JgIBTgqzYZXpmpJNyTBQsboqH/I+ciQflE60yjiKfwJi0kRfepg84ZPKddW2Shqc0iIRrhIvs2piQcMugYps+ByL7y9c9xfv485XlH5WnfEfVLxJHcIlmbG7nn7MZi9VQZQctulVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=trno/NzF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ImztO0JU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=trno/NzF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ImztO0JU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8A31F791;
	Wed, 14 May 2025 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747227982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9DMDyPRjI6E5O11T+MLOWN5723elni8VGDnm6hILQU=;
	b=trno/NzFZkvVtoXuotoZafl5G13MHelOy4wsITEGv+TRznz+MxLocI3Kzngt2PmWmQtO78
	kNKhDJ1hB1GN2CiC5OBFno/MJtw9167JnKLKNVzs74jJuRcm1Zh+B7QKTtEHLzDTumNqHv
	7FflBlKy727hlPzkgHwcTp2mzLgpyN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747227982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9DMDyPRjI6E5O11T+MLOWN5723elni8VGDnm6hILQU=;
	b=ImztO0JUJFx7WXvEHB8H/jlXlRRUUVL6htVHZMzMc/7CgYet1MhIx6bHtZPTRpeRBQnvjO
	FUvmxPLHel+RtCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747227982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9DMDyPRjI6E5O11T+MLOWN5723elni8VGDnm6hILQU=;
	b=trno/NzFZkvVtoXuotoZafl5G13MHelOy4wsITEGv+TRznz+MxLocI3Kzngt2PmWmQtO78
	kNKhDJ1hB1GN2CiC5OBFno/MJtw9167JnKLKNVzs74jJuRcm1Zh+B7QKTtEHLzDTumNqHv
	7FflBlKy727hlPzkgHwcTp2mzLgpyN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747227982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9DMDyPRjI6E5O11T+MLOWN5723elni8VGDnm6hILQU=;
	b=ImztO0JUJFx7WXvEHB8H/jlXlRRUUVL6htVHZMzMc/7CgYet1MhIx6bHtZPTRpeRBQnvjO
	FUvmxPLHel+RtCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A3A2137E8;
	Wed, 14 May 2025 13:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o8qCHU6VJGiadQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 13:06:22 +0000
Message-ID: <f4ebf9ca-b331-4a73-ae7a-050bb0686287@suse.cz>
Date: Wed, 14 May 2025 15:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
 <CAJuCfpFR5MKCQOV14okS8JhwT_c3jZ_weDGmQZ69cq=+ND-ZHA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpFR5MKCQOV14okS8JhwT_c3jZ_weDGmQZ69cq=+ND-ZHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.30

On 5/7/25 01:14, Suren Baghdasaryan wrote:
> On Fri, Apr 25, 2025 at 1:27 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

> One nit which is barely worth mentioning.

OK, made the change.


