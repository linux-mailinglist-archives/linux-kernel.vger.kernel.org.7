Return-Path: <linux-kernel+bounces-848655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87665BCE454
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20A4057D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4602FE569;
	Fri, 10 Oct 2025 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDBYYi+G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82E2737E4
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121795; cv=none; b=fzxkNR4HZ3ZCJFT0Jb2pMLfLabGsiHHLnCOlzcj818Aqr/6CCZzvxt+AAA3LgBXoZcHegUp4e0HdelsIhaBYXaNpWB9QfJkoWxs5B/d5RwR+y2MV3kYYPEttv0CLqF8/lhLGIrtKmFqCbP3YXBLvcRmf8pVjTUJlFAVwsylMRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121795; c=relaxed/simple;
	bh=u2ReooWSmgo0G11Wp53XreVGi6SSbrE3bLdaKVipLEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQe0u7w0zIMvYpy6kszIG/b3f4h9gSSWh72GFSZLrHUtaEgwJvFRZLADiFSBZlnlNAIymhBS+X8Unmx/TDQyvWik7B78J+BOV1IACsz6vi8/sfIUUo+vodBB/k0o2lxKGTRP7PMu898AmhS38ZTqVN+uo65u/vY5/dAOmFmLQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDBYYi+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760121789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMBX/pZ53RIz57w9TIlg7cS/xGYbde0rk28s7vX7D6Y=;
	b=jDBYYi+GHkjQBnjDkOW3d8NSV6HYHfeyjnNLe/2ax3Ae22OU1kSDgQjoDPHGY0C/qgUBk5
	GOXQfmokXjkno247ewbpOBJCTR+uHxA3ao8AXKDj/HSZoyYk4rjeVfaPS6ooNs7HotqgHv
	S9XQUk+79cOKnHd3WNrtCBJuamCjVdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-Pr-TSykvOgaC7KVbhcuOmw-1; Fri,
 10 Oct 2025 14:43:05 -0400
X-MC-Unique: Pr-TSykvOgaC7KVbhcuOmw-1
X-Mimecast-MFC-AGG-ID: Pr-TSykvOgaC7KVbhcuOmw_1760121784
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 316DF18004D4;
	Fri, 10 Oct 2025 18:43:04 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.90.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A02B01800578;
	Fri, 10 Oct 2025 18:43:02 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:42:59 -0400
From: Phil Auld <pauld@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: Boot fails with 59faa4da7cd4 and 3accabda4da1
Message-ID: <20251010184259.GB436967@pauld.westford.csb>
References: <20251010151116.GA436967@pauld.westford.csb>
 <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
 <e4f2a3e3-649a-423b-9696-6406ef56340f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f2a3e3-649a-423b-9696-6406ef56340f@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Oct 10, 2025 at 08:27:30PM +0200 Vlastimil Babka wrote:
> On 10/10/25 20:19, Linus Torvalds wrote:
> > On Fri, 10 Oct 2025 at 08:11, Phil Auld <pauld@redhat.com> wrote:
> >>
> >> After several days of failed boots I've gotten it down to these two
> >> commits.
> >>
> >> 59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
> >> 3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache
> >>
> >> The first is such an early failure it's silent. With just 3acca I
> >> get :
> >>
> >> [    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
> >> [    9.348115] #PF: supervisor read access in kernel mode
> >> [    9.353264] #PF: error_code(0x0000) - not-present page
> >> [    9.358413] PGD 0 P4D 0
> >> [    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
> >> [    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
> >> [    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
> >> [    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
> >> [    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
> > 
> > That decodes to
> > 
> >    0:           mov    0x10(%rsi),%rax
> >    4:           mov    0x8(%rsi),%rsi
> >    8:           test   %rax,%rax
> >    b:           je     0x18
> >    d:           mov    0x18(%rax),%ecx
> >   10:           test   %ecx,%ecx
> >   12:           jne    0xfd
> >   18:           movslq %gs:0x250eee4(%rip),%rax
> >   20:           mov    0xe0(%r14,%rax,8),%rax
> >   28:*          mov    0x40(%rax),%r13          <-- trapping instruction
> >   2c:           mov    %r13,%rdi
> >   2f:           call   0xffffffffffff81e4
> >   34:           mov    %rax,%rbp
> >   37:           test   %rax,%rax
> >   3a:           je     0x59
> > 
> > which is the code around that barn_replace_empty_sheaf() call.
> > 
> > In particular, the trapping instruction is from get_barn(), it's the "->barn" in
> > 
> >         return get_node(s, numa_mem_id())->barn;
> > 
> > so it looks like 'get_node()' is returning NULL here:
> > 
> >         return s->node[node];
> > 
> > That 0x250eee4(%rip) is from "get_node()" becoming
> > 
> >   18:           movslq  %gs:numa_node(%rip), %rax  # node
> >   20:           mov    0xe0(%r14,%rax,8),%rax # ->node[node]
> > 
> > instruction, and then that ->barn dereference is the trapping
> > instruction that tries to read node->barn:
> > 
> >   28:*          mov    0x40(%rax),%r13   # node->barn
> > 
> > but I did *not* look into why s->node[node] would be NULL.
> > 
> > Over to you Vlastimil,
> 
> Thanks, yeah will look ASAP. I suspect the "nodes with zero memory" is
> something that might not be handled well in general on x86. I know powerpc
> used to do these kind of setups first and they have some special handling,
> so numa_mem_id() would give you the closest node with memory in there and I
> suspect it's not happening here. CPU 21 is node 6 so it's one of those
> without memory. I'll see if I can simulate this with QEMU and what's the
> most sensible fix
>

Thanks for taking a look.  I thought the NPS4 thing might be playing a role.

I'm happy to take any test/fix code you have for a spin on this system. 

Cheers,
Phil


> >             Linus
> 

-- 


