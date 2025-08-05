Return-Path: <linux-kernel+bounces-756456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B125DB1B49C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD83B4C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE127510B;
	Tue,  5 Aug 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0fspBgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgtIllom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0fspBgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgtIllom"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C132750FE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399613; cv=none; b=NYGNs9+hSbRpPq8wOTtooucp4JVxb05Kj4TbLgK7500AX9AUQrA+2BplYYoDQAfh2ybnq1TrmfZ7OBwIR1UrBT1LtjFU3MyCUww+EHVqcGB8YQFCOPuIJcLFEnJSIfy8iO25rlj63+rXgqeiveBxGsLzXCA3crzzddRs3GCbfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399613; c=relaxed/simple;
	bh=HG4Zigi97cTn7NwfO4BqTXIoE6nxZgcqKAJuhJE85rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjELYNQ99DKZdtEEtcVWIUt1jiU7sU0EfY1gAcXZACxe36TpNkZdnK6IdnijFcBhF2lCfg+BfDx4W/itzwqvHpWFY5BZjqw/BUbJMkPquwwVr3/6r3Yk3Fv8ouo6l31GbTBORv9N+Qp2HTbp2yCzQ4FVze9S2cmslXPkz4do4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0fspBgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgtIllom; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0fspBgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgtIllom; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC911F74C;
	Tue,  5 Aug 2025 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754399609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi0O+0PdcmQy2RsQ+A/bu5pdhayeg1okjbaLCenz2T0=;
	b=a0fspBgDv7mHr0gCzRNAy6nYETWL0rIDRUlvXtJP1ZYmOnTK6jsGYCQTi82lAPng7mzru6
	DBdAaMbvCYEUXRJkVxvXDQDWM4uEIHj37QXTgmEPfxSat8O6rMeVwKnklGIS5OOXIyqORq
	A3BgHJtRpxmEIWwbj/yyynNc2YgGVGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754399609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi0O+0PdcmQy2RsQ+A/bu5pdhayeg1okjbaLCenz2T0=;
	b=cgtIllomiETqtcvWGC8w/VKHvxEPfDzsj2/m9sWR5FJXfYzexlDfCESBMazpRTqR/apz3g
	vEa/pPrVhcAMZDBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a0fspBgD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cgtIllom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754399609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi0O+0PdcmQy2RsQ+A/bu5pdhayeg1okjbaLCenz2T0=;
	b=a0fspBgDv7mHr0gCzRNAy6nYETWL0rIDRUlvXtJP1ZYmOnTK6jsGYCQTi82lAPng7mzru6
	DBdAaMbvCYEUXRJkVxvXDQDWM4uEIHj37QXTgmEPfxSat8O6rMeVwKnklGIS5OOXIyqORq
	A3BgHJtRpxmEIWwbj/yyynNc2YgGVGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754399609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi0O+0PdcmQy2RsQ+A/bu5pdhayeg1okjbaLCenz2T0=;
	b=cgtIllomiETqtcvWGC8w/VKHvxEPfDzsj2/m9sWR5FJXfYzexlDfCESBMazpRTqR/apz3g
	vEa/pPrVhcAMZDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0167013A50;
	Tue,  5 Aug 2025 13:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ApkCOngDkmi2FwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Aug 2025 13:13:28 +0000
Message-ID: <a4491b54-4e08-4bcc-bcd3-3bae20a490b2@suse.cz>
Date: Tue, 5 Aug 2025 15:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for
 performance
To: Li Qiang <liqiang01@kylinos.cn>, akpm@linux-foundation.org,
 david@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com
References: <74580442-2a9a-4055-b92d-23f5e5664878@redhat.com>
 <20250805120435.1142283-1-liqiang01@kylinos.cn>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250805120435.1142283-1-liqiang01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5CC911F74C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/5/25 2:04 PM, Li Qiang wrote:
> Ah, missed it after the performance numbers. As Vlastimil mentioned, I 
> would have expected a bloat-o-meter output.
> 
>>
>> My 2 cents is that usually it may be better to understand why it is
>> not inlined and address that (e.g., likely() hints or something else)
>> instead of blindly putting __always_inline. The __always_inline might
>> stay there for no reason after some code changes and therefore become
>> a maintenance burden. Concretely, in this case, where there is a single
>> caller, one can expect the compiler to really prefer to inline the
>> callees.
> 
>>
>> Agreed, although the compiler is sometimes hard to convince to do the 
>> right thing when dealing with rather large+complicated code in my 
>> experience.
> 
> Question 1: Will this patch increase the vmlinux size?
> Reply:
> 	Actually, the overall vmlinux size becomes smaller on x86_64:
> 	[root@localhost linux_old1]# ./scripts/bloat-o-meter before.vmlinux after.vmlinux  
> 	add/remove: 6/0 grow/shrink: 0/1 up/down: 4569/-4747 (-178)  
> 	Function                                     old     new   delta  
> 	zap_present_ptes.constprop                     -    2696   +2696  
> 	zap_pte_range                                  -    1236   +1236  
> 	zap_pmd_range.isra                             -     589    +589  
> 	__pfx_zap_pte_range                            -      16     +16  
> 	__pfx_zap_present_ptes.constprop               -      16     +16  
> 	__pfx_zap_pmd_range.isra                       -      16     +16  
> 	unmap_page_range                            5765    1018   -4747  
> 	Total: Before=35379786, After=35379608, chg -0.00%  

Is the before/after swapped here? This output suggests some functions
became NOT inlined.

If I'm right the output binary becomes slightly larger. But it doesn't
matter.

