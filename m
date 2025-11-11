Return-Path: <linux-kernel+bounces-895909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE9C4F3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45B5A4ED278
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE84B393DE0;
	Tue, 11 Nov 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MeBs0vAl"
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74873730F1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881987; cv=pass; b=GZUcppYDe0WxdAEwQ0fIrQrn1e7XrEaIo5RSK/NEWnN79265dpMdMWUwSYcxWaMVsTT8xXmh0zRUy0WE3eExT2oxFlbY6n+qO7l1f8L7FBn27Pf1ny6wiczktjRTjT2EJnW77KH0sisxmA9ELfcc7POpL1g075Xzpaqv7XAJ4LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881987; c=relaxed/simple;
	bh=fGEXgunrl9FTquLyoAqFKq7Y4iaVGi3mztkWXISr/mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWQA3pCS9Vi6UtFFFzFH3NoKsWfPPJOCQIJMr1lN35AppHQYDw1H1nV+nMTA4t1ZbWnLMLFwLIa4hqr56eRwT05QBUgpl2miNGPhXX1TktFkqhD7fOE/JbLhibI+XlQ7F8t72MiTdIbPrXbrj4KGFbNarPwfHVkWwn1EzhohUIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MeBs0vAl; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DC444782877;
	Tue, 11 Nov 2025 17:26:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-121-213-86.trex-nlb.outbound.svc.cluster.local [100.121.213.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 69FA8782A54;
	Tue, 11 Nov 2025 17:26:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762881984; a=rsa-sha256;
	cv=none;
	b=0J7hKXdHWGUhuMYjopblG/a/ktX7eRjc3ERxz/o+VuKq+q5zpWdozVP4xRmKpEBZEI5iyw
	ckUlvSYZtvl9GcqDUFRtk1ek01kVkEP+QIfg/SNm7q4KJIt27Zo/1lRfUxVvKAz9rs2nhH
	0TJ9NNEYYWhSxiMHe7rXkLdg8Zmxuz97L9EaTBHzzjwvLyLWlsi7/2CUORZEhYFlMsIf6X
	c1jks8ZxOQvbyyMj5n5YDHxKYtaYHgni3glXATwMfGlKEMx8uIZmmpJKWVv/QXf3foi+UZ
	GR+oGT5rkt964idf1Vmp4rLf08vsOwFsiXQYm8vRqyIdfmdiV2Xmh2PLGiNpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762881984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fGEXgunrl9FTquLyoAqFKq7Y4iaVGi3mztkWXISr/mg=;
	b=zx5/4bj2uSrWlTHnlPr2VQvpzl5GU6Av6g0R6mpdnWvEuFzebekhXc8Yy30mLM5XKu+5vD
	+CNwsYPMPv9tis9LEo0whPD+Ex4I8xqTMdyPcE/r/Y/848VydRDaWprVR1FJxygGZ7S5MQ
	OJ3YW4XDXAl9chig3+bpA5nM6wo9WSF1+CELsk1ZePztQyO7bGxbrYEPOim9g3BiExcPNv
	rY798LWd8SyvP+kbdR2+c/3SHD4Bzj/SOSAT604Lo3A2Rs6t7rvXurPB7Wk1OxyJhRWaKO
	1YDfxuucyXU+lkC5IvJqd0ybvIpzTHaRQrFWTCb7fAK0Y0kzAxTvMMBZucbbJw==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-4j59m;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Shoe: 3cfc82b06efca727_1762881984722_3782567276
X-MC-Loop-Signature: 1762881984722:3676767511
X-MC-Ingress-Time: 1762881984722
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.213.86 (trex/7.1.3);
	Tue, 11 Nov 2025 17:26:24 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4d5YNb4z1Dz2W;
	Tue, 11 Nov 2025 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1762881984;
	bh=fGEXgunrl9FTquLyoAqFKq7Y4iaVGi3mztkWXISr/mg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MeBs0vAlrFCikEu4BdYnm3CWXL/eYV16oGylX0dD5s3QHKiJsB0iQsYhZDfHK02Wc
	 16uYwnZMJRJ6y7vkJm3DQAPUWdL4AKi811KMhQ3yfLvCFz7N4/BFhvpzOQyGNvz+P0
	 ZG/YsLmJ1i6ktuz/7b4ZcWnE6mUmwPqZtKYF8wmhGpk8n7+0lPVIKrWZRDn4tL2i6X
	 J8tpPyiW987HegmmpcfDF/dpMUvUAfeh/rvPkH01qKcUsAdlpFzKhgcBGxe89/0910
	 51CoD35q06Kgfkdtx1+NVboRFlmlApXURVnBRQNuGeR14BIng2RjcdGjX3q1aZ76h6
	 CGwEoJLZCK0tw==
Date: Tue, 11 Nov 2025 09:26:21 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/madvise: allow guard page install/remove under
 VMA lock
Message-ID: <20251111172621.thszs4gtc5exsvuy@offworld>
Mail-Followup-To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
 <cca1edbd99cd1386ad20556d08ebdb356c45ef91.1762795245.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cca1edbd99cd1386ad20556d08ebdb356c45ef91.1762795245.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20220429

On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:

>We only need to keep the page table stable so we can perform this operation
>under the VMA lock. PTE installation is stabilised via the PTE lock.
>
>One caveat is that, if we prepare vma->anon_vma we must hold the mmap read
>lock. We can account for this by adapting the VMA locking logic to
>explicitly check for this case and prevent a VMA lock from being acquired
>should it be the case.
>
>This check is safe, as while we might be raced on anon_vma installation,
>this would simply make the check conservative, there's no way for us to see
>an anon_vma and then for it to be cleared, as doing so requires the
>mmap/VMA write lock.
>
>We abstract the VMA lock validity logic to is_vma_lock_sufficient() for
>this purpose, and add prepares_anon_vma() to abstract the anon_vma logic.
>
>In order to do this we need to have a way of installing page tables
>explicitly for an identified VMA, so we export walk_page_range_vma() in an
>unsafe variant - walk_page_range_vma_unsafe() and use this should the VMA
>read lock be taken.
>
>We additionally update the comments in madvise_guard_install() to more
>accurately reflect the cases in which the logic may be reattempted,
>specifically THP huge pages being present.

Makes sense.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

