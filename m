Return-Path: <linux-kernel+bounces-735625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95BB091AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF06B3B549E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141932FC3DF;
	Thu, 17 Jul 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cebLjYnC"
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123952F66
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769611; cv=pass; b=Dn/aZGtGy1+URq0dBvNuNL8797iiHscD6FHyR+3Zm8SCjOPM0FNgSp82PzWkgO5TxUxR1Hr46msEyzNL98QbmLoB7TR7/KXKX0Ydq80NQUmb4Mmu+XWcZd1omX7ppOvbWL8+4rBpvYIK/X+oumma7KzPxx8qlKHpXWbgvKo+03s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769611; c=relaxed/simple;
	bh=9vxTDLjhMy3i1W7OCLCWbdaLScCRKmeZiob0oCqDRi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ5A9qsIpnXhGM8NZq/Af8Ey8IYmYwrb5dLE98RHqkWAvCKZHqRufjuaImdLiwJ7kJz+B53EOWkMLXwcV2C9IpNNxZhoWSb+b7cAUQx/vkwuiXIEgVNxm8CV4D9WT5ZNDBS5DM1xzWg0Iy42c1wPioR2f48TjSXyeZIQefBRsNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cebLjYnC; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0A3C825211;
	Thu, 17 Jul 2025 16:26:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (trex-blue-1.trex.outbound.svc.cluster.local [100.120.34.184])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7BB2325490;
	Thu, 17 Jul 2025 16:26:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752769602; a=rsa-sha256;
	cv=none;
	b=8SNnunmW3glvOQGheYQArNqKaFIV9vu1j9xUv4AC2DMJ4e0yAscjAUt2uNH8CNVfRbL0+1
	TkNelkY+I5DCwXRhbmHqG0zlpIhL7/Oa8CogwRsFRr3IBOf1+FlSB8/4g46vE/C/bv7RmB
	CxxL33B/N/j9jdvySdsyho0bPtPMdG+A5sdlY2DFqdBDJctyZsBUcfx6e40GojWdz/vHfm
	3alQJXFNB7LuF7sbI2Wm5U76XX4jYXtKVaUdmRbzFqdQeD8gdU5QqUWynCOjtsEsOtl5gP
	8H0XE7N9nI3art4ilQ/qSMsWW/5FxSvZBhvpGgc75EO1a17/RzVBZXBJ4BhyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752769602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=taTsbv8PIuQoZTsYWPkbrlOV1XuZ5ae2zw2+O37gSmU=;
	b=R5GXCWgJOKGI7tEpnwH38NX59lm8WFocPPvNe6HK9zfXqHhbYg8Mt9rix3dbbk/twIwbvJ
	H7IK3iSATNH/cUtUT4lGK2MGvZTidz1l86O1RLNkdK/iRm+kPvgZBtxDGdx+XJiI2/ZDiK
	ve2QJ9zcj4ZjcYP4TN0TrGdl1nV81cqug8kyCTYkMvmo3fCKMkjOr99d/MB7l81dOxy+0W
	wZeAAAUl/ORl3Hb3Q6+oHyRicI7lJN0tCXyT5MGpbLX56NRgXB27dkz2blNcNyJeFYtd3v
	SIPrfqXeH2rwk005n7SrHRWvXhkkMvxVAMWsdPPDvgBVo5fmSIfPDH+2D4PksA==
ARC-Authentication-Results: i=1;
	rspamd-57f6596c64-rd56w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Tart: 2182cc7943e98074_1752769602819_2687924055
X-MC-Loop-Signature: 1752769602819:3382800013
X-MC-Ingress-Time: 1752769602819
Received: from pdx1-sub0-mail-a235.dreamhost.com
 (sub3.homie.mail.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.34.184 (trex/7.1.3);
	Thu, 17 Jul 2025 16:26:42 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4bjdbg6JpDzFr;
	Thu, 17 Jul 2025 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1752769600;
	bh=taTsbv8PIuQoZTsYWPkbrlOV1XuZ5ae2zw2+O37gSmU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=cebLjYnC/cOReCK80TuPLfcrbAmyXLngzjEMblTHmfk0ILG6pygdHWD0VJJfK34pe
	 0v50QvLGbWyL/i3pgRh4dRr1jooSHpDzWYxaerf0CuHlnZcdA4QCNFNLmPSqWH40DU
	 N7qQ/n71tHqXwFruPYW3b46EYMEBlAz5dAIemsrtRLLkYvkYAWE4rGCWvXQIuRXl9F
	 0k/T1LdK5vS8oBnY5ExY48PFsETmPORnBpL+6czCTjCC3G6JaFTedo/B9MSXjAxihx
	 PtQzLP1zPy+UtlJlBLykAvZkOMpSutRR4rShlWoEUZDmtxP0Fz/6XDKKDAwvU5oEtZ
	 HOKRkH2GHI9Zg==
Date: Thu, 17 Jul 2025 09:26:37 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
Message-ID: <20250717162637.xz77hsj2byamivgm@offworld>
Mail-Followup-To: Roman Gushchin <roman.gushchin@linux.dev>,
	akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-5-dave@stgolabs.net>
 <87qzyfr0u6.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87qzyfr0u6.fsf@linux.dev>
User-Agent: NeoMutt/20220429

On Wed, 16 Jul 2025, Roman Gushchin wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>> @@ -7792,11 +7792,29 @@ int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat
>>			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
>>					  MEMCG_RECLAIM_PROACTIVE;
>>			reclaimed = try_to_free_mem_cgroup_pages(memcg,
>> -						 batch_size, GFP_KERNEL,
>> +						 batch_size, gfp_mask,
>>						 reclaim_options,
>>						 swappiness == -1 ? NULL : &swappiness);
>>		} else {
>> -			return -EINVAL;
>> +			struct scan_control sc = {
>> +				.gfp_mask = current_gfp_context(gfp_mask),
>> +				.reclaim_idx = gfp_zone(gfp_mask),
>> +				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
>> +				.priority = DEF_PRIORITY,
>> +				.may_writepage = !laptop_mode,
>> +				.nr_to_reclaim = max(batch_size, SWAP_CLUSTER_MAX),
>> +				.may_unmap = 1,
>> +				.may_swap = 1,
>> +				.proactive = 1,
>> +			};
>> +
>> +			if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED,
>> +						  &pgdat->flags))
>> +				return -EAGAIN;
>
>Isn't EBUSY a better choice here?
>At least to distinguish between no reclaimable memory left and
>somebody else is abusing the same interface cases.

Yes, I agree.

Thanks,
Davidlohr

