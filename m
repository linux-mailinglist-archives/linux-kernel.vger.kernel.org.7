Return-Path: <linux-kernel+bounces-726944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F118CB01341
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3758034B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C961CDA3F;
	Fri, 11 Jul 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OPRoqBjL"
Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820501C84D5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213625; cv=none; b=QyPgXi/eVum+6QBV0HbC7U1kgRY1LOP4DhZvo9UcGY2GO23bijouth9TILclFBytGmbAsCJcCa3pMvfRvkTMQSQFznN9bMeln8BboZFhVyPL7l2aOOyKSyTl3urliWuqYR7oPpYnmLm+uWoDzxhB2dlOgXwpqJDfTXL3mnMZBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213625; c=relaxed/simple;
	bh=viR5sCpMCovkWso9QSh5yW+aCYCywBbDAkKZpSH42oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTVskm5evJ1t3R5CgRCsLlde5/2+p4z4ofEkpqw60kmKxyLl1SMJj4eJhnItB8Im7mTzRasd8LaxjNGThfnSoemX1Y4rbKdgx/yAGH0GAQqKm12dxKPk+qZLmxObKTxnpMAbFTP3+i1qUAgPRuga6vygmzyUSOm1Qqw6YuimfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OPRoqBjL; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752213620;
	bh=iA75JEK9qBVzW8qdLN0P4DaokWl3KKk9Tq0qimdiEuk=;
	h=From:Subject:Date:Message-ID;
	b=OPRoqBjL+YHU38BPuuhDBxRl1OdnWYTUfTEuvkkjBgSnxxJWBIIhJnouicK6m+7KN
	 1mDW1lAO+IjxTG2o6sYxVbsMXlELtWQd4HNprOGGPk7KUnVN+PbEt7y4jm8+Zcxejc
	 kIAT6DU6SBvORAqVvG+MWWXvn8oYfve9DFMH2tWU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6870A86A0000625C; Fri, 11 Jul 2025 14:00:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7002216685331
X-SMAIL-UIID: 903A4E37A5F04913939332C653CAD98A-20250711-140011-1
From: Hillf Danton <hdanton@sina.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
Date: Fri, 11 Jul 2025 13:59:58 +0800
Message-ID: <20250711060000.3413-1-hdanton@sina.com>
In-Reply-To: <f38cef22-d3e8-4f73-a8ba-1a2cb0f4808e@suse.cz>
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com> <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local> <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com> <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com> <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz> <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com> <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm> <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com> <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com> <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 19:42:16 +0200  Vlastimil Babka wrote:
> On 7/10/25 19:02, Suren Baghdasaryan wrote:
> > On Thu, Jul 10, 2025 at 12:03 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >>
> >>
> >> I have the patchset ready but would like to test it some more. Will
> >> post it tomorrow.
> > 
> > Ok, I found a couple of issues using the syzbot reproducer [1] (which
> > is awesome BTW!):
> > 1. rwsem_acquire_read() inside vma_start_read() at [2] should be moved
> > after the last check, otherwise the lock is considered taken on
> > vma->vm_refcnt overflow;
> > 2. query_matching_vma() is missing unlock_vma() call when it does
> > "goto next_vma;" and re-issues query_vma_find_by_addr(). The previous
> > vma is left locked;
> 
> How does that happen? query_vma_find_by_addr() does get_next_vma() which
> does unlock_vma()?
> 
Adding a mutex that protects do_procmap_query() survived the syzbot test [1,2].
That sounds like a bad news as locking vma alone is not enough to query the map.

[1] https://lore.kernel.org/lkml/687092d6.a00a0220.26a83e.0036.GAE@google.com/
[2] https://lore.kernel.org/lkml/6870a4a4.a00a0220.26a83e.003c.GAE@google.com/

