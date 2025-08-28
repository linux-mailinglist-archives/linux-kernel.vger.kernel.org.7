Return-Path: <linux-kernel+bounces-790191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E4B3A1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C78A7AB0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B126561D;
	Thu, 28 Aug 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjnuTlC4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXR6YRFC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjnuTlC4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXR6YRFC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537DB665
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391477; cv=none; b=ljQuuv0loeGA/7mVkjuHSIuBMljBaYoAEdrB8d7y0TDhdm6jPZK9o7cS2COuuvYNvNf60ERCTaI93ztQeIjOjCKMCh0Ne4wNBRdW5rcV35zOFnAxItPdhasalx4JJ4isOwVIFCo4RNVKSqSoil8CGFcGooH7NYozUHHxjn/vDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391477; c=relaxed/simple;
	bh=tNA3DDUc81X+YxUNtdH63clIrTAh5wtApuNUIftWx30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+eDEEHwYOsTSUovNvNXIDXRUdiOem66AIKERejxEtMCg2578VzOLAv6Ak37adoBszjsKR0h525EUIK+F6qbK7TD+oBRq33bL5TbXdSlYGBQdADs7rU8StkYg14L/fyHOKlclE3jALbUjZOUPbKwmf9Qa6UayAbpn49lVrNxXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjnuTlC4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXR6YRFC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjnuTlC4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXR6YRFC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89B7720C68;
	Thu, 28 Aug 2025 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756391473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wAf1rSyN0U88x/f7J+bzl7K3AHopgiG6PvRguCxbi5E=;
	b=UjnuTlC4dxVxCW4DBvUrGdDPbNkR+BCF8FOKlMXnSSwk6RGdZbS0bqAKTHPnu1cz5I/+EN
	OHIbE434/kd3p92SgiD5yvxjDODUKJBa1w6QvuRGxfSF/1ozLVlJL9VBW27XI8kHgo6NRM
	729WZYs/lZKRhme+7kbweUO1vKT1CUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756391473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wAf1rSyN0U88x/f7J+bzl7K3AHopgiG6PvRguCxbi5E=;
	b=lXR6YRFC4GWT0l59A/+aOcjIr/ToKs1Heigrdyp5i66BHDgi66AwP2yUDBaECiPO4THwjW
	n7EWRqbx9OOImlBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UjnuTlC4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lXR6YRFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756391473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wAf1rSyN0U88x/f7J+bzl7K3AHopgiG6PvRguCxbi5E=;
	b=UjnuTlC4dxVxCW4DBvUrGdDPbNkR+BCF8FOKlMXnSSwk6RGdZbS0bqAKTHPnu1cz5I/+EN
	OHIbE434/kd3p92SgiD5yvxjDODUKJBa1w6QvuRGxfSF/1ozLVlJL9VBW27XI8kHgo6NRM
	729WZYs/lZKRhme+7kbweUO1vKT1CUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756391473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wAf1rSyN0U88x/f7J+bzl7K3AHopgiG6PvRguCxbi5E=;
	b=lXR6YRFC4GWT0l59A/+aOcjIr/ToKs1Heigrdyp5i66BHDgi66AwP2yUDBaECiPO4THwjW
	n7EWRqbx9OOImlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A0721368B;
	Thu, 28 Aug 2025 14:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P2zKGDFosGhuIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 28 Aug 2025 14:31:13 +0000
Message-ID: <8d536d53-a365-4a9f-8d30-bbade9a85e3e@suse.cz>
Date: Thu, 28 Aug 2025 16:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Content-Language: en-US
To: Carlos Llamas <cmllamas@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, "open list:MEMORY MAPPING" <linux-mm@kvack.org>
References: <20250828032653.521314-1-cmllamas@google.com>
 <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
 <53b938ed-dd78-42fa-8cde-f3a938b6f39f@suse.cz>
 <b58449cc-022b-497a-97f2-c91776d133dc@lucifer.local>
 <aLBn4vb0Pmwoqt51@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aLBn4vb0Pmwoqt51@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 89B7720C68
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 8/28/25 16:29, Carlos Llamas wrote:
> On Thu, Aug 28, 2025 at 03:22:54PM +0100, Lorenzo Stoakes wrote:
>> On Thu, Aug 28, 2025 at 04:21:05PM +0200, Vlastimil Babka wrote:
>> > On 8/28/25 07:38, Lorenzo Stoakes wrote:
>> > > On Thu, Aug 28, 2025 at 03:26:52AM +0000, Carlos Llamas wrote:
>> > >> Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
>> > >> checks") moved the sanity check for vrm->new_addr from mremap_to() to
>> > >> check_mremap_params().
>> > >>
>> > >> However, this caused a regression as vrm->new_addr is now checked even
>> > >> when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
>> > >> case, vrm->new_addr can be garbage and create unexpected failures.
>> > >
>> > > Yikes, sorry my mistake.
>> > >
>> > >>
>> > >> Fix this by moving the new_addr check after the vrm_implies_new_addr()
>> > >> guard. This ensures that the new_addr is only checked when the user has
>> > >> specified one explicitly.
>> > >>
>> > >> Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
>> > >> Signed-off-by: Carlos Llamas <cmllamas@google.com>
>> > >
>> > > You need a Cc: Stable.
>> >
>> > No need as the commit being fixed is from 6.17-rc1?
>> > But it's better to use "[PATCH mm-hotfixes]" to make sure it goes to 6.17
>> > and not the next merge window.
>> >
>> 
>> Ah haha really? I'm losing track of my patches.
>> 
>> Yeah sure as per Vlasta then Carlos :)
> 
> Oops, sorry my v2 raced with this.

Nevermind, Andrew can fixup locally. Thanks :)

