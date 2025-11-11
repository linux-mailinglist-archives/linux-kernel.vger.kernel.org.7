Return-Path: <linux-kernel+bounces-895893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44225C4F33F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0C4434C841
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FAE393DE1;
	Tue, 11 Nov 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fdbS9yPy"
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7A393DD5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881152; cv=pass; b=nQaWcnDh83N1T6JgRqtDQ1HCR/80vlDIW9yB9SPpMATi7XhE6L1vti5SUtjQt+Iku+4xAM6N9/YBzyPxV5FELG00Dr1fk9kqCD0v6ln7iDA5VIFnYp6XD55hvxS7+FFCdnISugiQ+qH+NHRdjKJoRV5wdeo05h43JNWhOF/TIIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881152; c=relaxed/simple;
	bh=DwzBrHIlFCrwz0pBkyv1QDmJzAlCpDAp0FiyfPycSs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mprqD7zPvJoRb899UVMvNoxVo0JVf/1FKNijed1g067Va8KylmwrIEedJFEqbxkWf/wNscleja0yhiy1zcYwLz02JmYgrLxRwo7tRdM6AFFCa3UoRqMhV4MZBjydM8hbCnB4fwr9M59GO+lLIybFRkqO1V+qxV6s4JDxO5GVcO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fdbS9yPy; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C57D0823062;
	Tue, 11 Nov 2025 17:12:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-121-222-5.trex-nlb.outbound.svc.cluster.local [100.121.222.5])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4C95B822E15;
	Tue, 11 Nov 2025 17:12:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762881144; a=rsa-sha256;
	cv=none;
	b=NsSl1/ShxD0udbXLaUE66r4LaIXTX1mri5bAqCel7RD+ou8zW0k4oEI4D/eSFS5PhaGKIb
	lZtfGhrY8VRVfcLFiI7iUcnbJONbA8ZFJNSdBZvNjMtJhB+Vt9L1ZqDygVfFY4iByQzzto
	J4eY6wBBxdFvXX9OJyk3EwDx2mKcYw/MS56b/64voLRPBU94hMqojI93ulieAuSev6C8ri
	Ijrz1pIZhOUV3traxQHNf23rECqwrh8r20j35NRHgQO7KUdQl6C3XIwLo+JAvw4nt/TwMI
	erV28UTcGjIQP1Rqa1KXKUm2KEBxv0cclB2JlXSwJfgugUa44v0O2SX2lA8zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762881144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DwzBrHIlFCrwz0pBkyv1QDmJzAlCpDAp0FiyfPycSs4=;
	b=yA62lARTIsiukPI8WFo1RSylWDxMK66D20q2wi3jS9JXwaiBH1/exxmHQDeR4xBKgPvGw7
	tqeCtpcVp/7sZhDy1pBJZfNrPV2LrIXHaz/0JEO6ha5Nux63bYhj3JuQ+ZLGxoxC91yAPh
	5n5uSAE0NX7Te2tZYjJn/blmSfl3JqslfY88qnhuG+j5kiWduEQpUdodBauIZlGDrafzVO
	sMC9SWRRIvmUcIjPhENvSznYHDvY/5Kbka+WBJNvgEs880RVS9YaRr8fO9gx5zQzpo5Otu
	X+U6mBv9vNmqAJM72JsoEKfPpbv7FZFneiAcgTpiDgQjnT+9HbN4okpA5Ve/Gg==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-dvdb4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Plucky: 01ba490779e6d506_1762881144597_2899740575
X-MC-Loop-Signature: 1762881144597:3773387619
X-MC-Ingress-Time: 1762881144596
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.222.5 (trex/7.1.3);
	Tue, 11 Nov 2025 17:12:24 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4d5Y4R3s1VzSJ;
	Tue, 11 Nov 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1762881144;
	bh=DwzBrHIlFCrwz0pBkyv1QDmJzAlCpDAp0FiyfPycSs4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fdbS9yPyZzrPZntWn2v0QMdrCT5fSSVzYV5XV0sz7xrk21l/fNV8DFWDmmQ75kNT1
	 EprQvQCvZLSYv8vUc+YSdFK8CDT4yoa2BcwdVlyIS9ED9JBaymtGcS+Odxv2dqTh38
	 6r2NYmf/V4piTqs8jUD6/BINrH0WHhmWRLUdsXEzc9cyuA4lAmiiPB9mQJhDooBtMA
	 Shevrno0+zAsus57hWpBTFZiYe8qKV0Y37iWW5aOg+dVUMyfIncEXIWblXvk/yNfEB
	 enPcljnxINeFKVjfD3NtRgQ3YAq0WVdxEF1voVXL4Y+Ai7U5RnWrjdqc2m6HnKRn5I
	 uAVmX4hmhxItw==
Date: Tue, 11 Nov 2025 09:12:20 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: rename walk_page_range_mm()
Message-ID: <20251111171220.vbafzcqhiauhxlpl@offworld>
Mail-Followup-To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
 <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c684d91464a438d6e31172c9450416a373f10649.1762795245.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20220429

On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:

>Make it clear we're referencing an unsafe variant of this function
>explicitly.
>
>This is laying the foundation for exposing more such functions and
>maintaining a consistent naming scheme.
>
>As a part of this change, rename check_ops_valid() to check_ops_safe() for
>consistency.
>
>Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

