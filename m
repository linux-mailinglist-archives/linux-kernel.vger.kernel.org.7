Return-Path: <linux-kernel+bounces-802172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA82B44E76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04C21C271C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA872D4805;
	Fri,  5 Sep 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8z22so3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IzuDVqN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8z22so3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IzuDVqN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8D2D46BB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055485; cv=none; b=WmZPrJqfQCoUvZiiSmoD/RsvhYKnVaWQFB6i0//RFVDHEGM9jNKWh46RPXaTfqjqC4yeD6GM9EgSbOFm5IJNsLf9Xz4Us2y+Lw9jSCV6ftDhIXPzHNbUIss7Ftk+aIpr9DH1H6fKurCytzCRAkIfXpAVQilWQwUQqhOyZyR+s1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055485; c=relaxed/simple;
	bh=51em3yL9A5TxVuRyoXQIvgpg6ujJda7DgvBo10P/m4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iz8YNClErsU1HEKJRsaleEnobq6fP7Wem7186Z30Ds54IX8u/bDTkZ+P1MehrOqfX4jHzSXFI7OqoLQBB/0/WibvKPZSaWBro6M3De5Um8Qu7XUaATVMK/Qx8Ea/5IqQvLkReyj9WjOzjSStXL2d3JZRBr2r/C4axRiFpRe2Q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8z22so3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IzuDVqN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8z22so3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IzuDVqN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C60F76F71;
	Fri,  5 Sep 2025 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757055481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TvK9ixWwRei4oCEeYPKW9uWdDzojNqzJFZHBSy8S3W0=;
	b=y8z22so3t/LCPlVSsXuM4LY9tNaUh5bXHnsvWbMk+++SMpnxNiV0jh2PkM2xRdiMVVgWRM
	fjhdyHbrnbswMmoOgZvWmod1KYfcJ/MLcbWyfDyK3ch+XjDanm19thfdhk7SjBnIhZ15qi
	7C+UfHVOwxuAdwpPrQnvCMGXZgFz1ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757055481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TvK9ixWwRei4oCEeYPKW9uWdDzojNqzJFZHBSy8S3W0=;
	b=0IzuDVqN9K4MgCv9kAMVpxGhM7rgfTOsV+giY2sHFmdIG9TPjv/zYxUsoJDU0jsQkdE0FW
	3nwow3eMQLvoKpAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y8z22so3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0IzuDVqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757055481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TvK9ixWwRei4oCEeYPKW9uWdDzojNqzJFZHBSy8S3W0=;
	b=y8z22so3t/LCPlVSsXuM4LY9tNaUh5bXHnsvWbMk+++SMpnxNiV0jh2PkM2xRdiMVVgWRM
	fjhdyHbrnbswMmoOgZvWmod1KYfcJ/MLcbWyfDyK3ch+XjDanm19thfdhk7SjBnIhZ15qi
	7C+UfHVOwxuAdwpPrQnvCMGXZgFz1ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757055481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TvK9ixWwRei4oCEeYPKW9uWdDzojNqzJFZHBSy8S3W0=;
	b=0IzuDVqN9K4MgCv9kAMVpxGhM7rgfTOsV+giY2sHFmdIG9TPjv/zYxUsoJDU0jsQkdE0FW
	3nwow3eMQLvoKpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB2CE139B9;
	Fri,  5 Sep 2025 06:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rh+/OPiJumggfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 05 Sep 2025 06:58:00 +0000
Message-ID: <c0b9d34e-1a21-4a97-b898-c33f7c8b49dd@suse.cz>
Date: Fri, 5 Sep 2025 08:58:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
To: Vitaly Wool <vitaly.wool@konsulko.se>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250826124454.GA1502@cmpxchg.org>
 <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,google.com,oracle.com,garyguo.net,protonmail.com,umich.edu,linux.dev,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2C60F76F71
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 8/26/25 16:56, Vitaly Wool wrote:
> 
> 
>> On Aug 26, 2025, at 2:44 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>> 
>> On Sat, Aug 23, 2025 at 03:04:19PM +0200, Vitaly Wool wrote:
>>> Zpool is a common frontend for memory storage pool implementations.
>>> These pools are typically used to store compressed memory objects,
>>> e. g. for Zswap, the lightweight compressed cache for swap pages.
>>> 
>>> This patch provides the interface to use Zpool in Rust kernel code,
>>> thus enabling Rust implementations of Zpool allocators for Zswap.
>> 
>> The zpool indirection is on its way out.
>> 
>> When you submitted an alternate allocator backend recently, the
>> resounding feedback from the zswap maintainers was that improvements
>> should happen to zsmalloc incrementally. It is a lot of code and has a
>> lot of features that go beyond allocation strategy. We do not want to
>> fork it and fragment this space again with niche, incomplete backends.
>> 
>> It's frustrating that you not only ignored this, but then went ahead
>> and made other people invest their time and effort into this as well.
>> 
> 
> I don’t think we have a consensus on that.
> 
> And zblock is, after some additional improvements, just better than
> zsmalloc in all meaningful aspects, let alone the simplicity. It is fas
> easier to implement in Rust than zsmalloc, too. Besides, zram is a good
> candidate to be rewritten in Rust as well and after that is done, zblock

If your target is zram (not zswap) then I don't understand why insist on the
zpool layer, as zram refused to adopt it in the first place?

> will be even safer and faster. So while not being “incomplete", it’s
> zsmalloc that is becoming a niche backend moving forward, and I would
> argue that it could make more sense to eventually obsolete *it* rather
> than the zpool API.
> 
> ~Vitaly


