Return-Path: <linux-kernel+bounces-754670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7FB19AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061BD1896885
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C55224220;
	Mon,  4 Aug 2025 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VsnnaUqE"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70F1DF985
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281068; cv=none; b=KQL7G8e4PEOZHJEGCxl3mCr8mVemu/o5j4LTJ/qX8uakivkWjSNClbOEH/cWDnAONMv9E/GZqeW6AN/Tk5f8mLixaHLsXAg7HNCULqRM4ot6a//1oklKlNHl3IFgzXje8wzei6vlrTd/uo4NbTZ6iG2X6VUL6c6R3DEu5hzV7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281068; c=relaxed/simple;
	bh=UkP0E4UfHWs27GLjO5NJjuLdapDhGCFyUrRQBUuueiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaotNGEpKhkOpG1SJZ5eHrhotRMWoSevKthhp8Rj+clo4brouuJYs2CoXh4pzchG4GO8biwt+6BU9hB0/werb+UDTz4FO6t7C/IaudW1uyP+T3Lj/D1TX7kZDz0tB4xyoXYPQzHaYf5F1VUdVhuD/HvBNF5ITZxCOxeHeX7JzZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VsnnaUqE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Aug 2025 00:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754281054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0M9ZvKP4fwKl6JlW8sauGJ2yeG2JB9awxi8njeECQk=;
	b=VsnnaUqEhrQ9L8sGioT23frPZd8q3eDn0SYmzAcd454+0ya5AgDX9OCnCje3/rpkVipuTa
	ijh1z7iqX1knxWf3RmcsCDdCRveglPr1vDKWQGsK6RDVUdeF7IQy0JVMcqGInLIEVjvpHn
	FGGFvuWAkzveG4/QUbn1PvuTm/dbRyI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: Coly Li <colyli@kernel.org>, 
	linux-bcache <linux-bcache@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcache: enhancing the security of dirty data writeback
Message-ID: <c2awlgl4ih23npqa3k2ilbrbhciv3nfd7wg5xnsjjxikcmednb@nwn3qc7aqhou>
References: <20250731062140.25734-1-zhoujifeng@kylinos.com.cn>
 <etlu4r6gxbe2jc3eemj3n4slg6xraxtxxydvxvmhv77xv42uss@7aw3yxbdgrdl>
 <tencent_656F159830BC538C2D26CD68@qq.com>
 <zcxdklyr2ugq7cfbed4olcsfcboy3nksxtpjs2g76bauvef5cq@4akbspw3ydiw>
 <tencent_22DE1AC52BA931BD442CE823@qq.com>
 <wxyamy7fkf7of4olnvqju2ldflnpj3k5u6qsufvesb3mtoaxwb@fuu5brsbgjwf>
 <tencent_6FE47FFD5A5D8EF818ACD926@qq.com>
 <p4uhjrka2rdj67ph5puvaixxhstcyfitzq63pwrafdwtabtjwn@fbie2x77lqee>
 <tencent_31215CC45AD29EC835D34AD8@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_31215CC45AD29EC835D34AD8@qq.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 04, 2025 at 11:47:57AM +0800, Zhou Jifeng wrote:
> On Sun, 3 Aug 2025 at 01:30, Coly Li <colyli@kernel.org> wrote:
> >
> > On Fri, Aug 01, 2025 at 02:10:12PM +0800, Zhou Jifeng wrote:
> > > On Fri, 1 Aug 2025 at 11:42, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 11:30:43AM +0800, Zhou Jifeng wrote:
> > > > > On Fri, 1 Aug 2025 at 10:37, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > On Fri, Aug 01, 2025 at 10:27:21AM +0800, Zhou Jifeng wrote:
> > > > > > > In the writeback mode, the current bcache code uses the
> > > > > > > REQ_OP_WRITE operation to handle dirty data, and clears the bkey
> > > > > > > dirty flag in the btree during the bio completion callback. I think
> > > > > > > there might be a potential risk: if in the event of an unexpected
> > > > > > > power outage, the data in the HDD hardware cache may not have
> > > > > > > had time to be persisted, then the data in the HDD hardware cache
> > > > > > > that is pending processing may be lost. Since at this time the bkey
> > > > > > > dirty flag in the btree has been cleared, the data status recorded
> > > > > > > by the bkey does not match the actual situation of the SSD and
> > > > > > > HDD.
> > > > > > > Am I understanding this correctly?
> > > > > >
> > > > > > For what you're describing, we need to make sure the backing device is
> > > > > > flushed when we're flushing the journal.
> > > > > >
> > > > > > It's possible that this isn't handled correctly in bcache; bcachefs
> > > > > > does, and I wrote that code after bcache - but the bcache version would
> > > > > > look quite different.
> > > > > >
> > > > > > You've read that code more recently than I have - have you checked for
> > > > > > that?
> > > > >
> > > > > In the `write_dirty_finish` function, there is an attempt to update the
> > > > > `bkey` status, but I did not observe any logging writing process. In the
> > > > > core function `journal_write_unlocked` of bcache for writing logs, I
> > > > > also couldn't find the code logic for sending a FLUSH command to the
> > > > > backend HDD.
> > > >
> > > > The right place for it would be in the journal code: before doing a
> > > > journal write, issue flushes to the backing devices.
> > > >
> > > > Can you check for that?
> > > >
> > >
> > > I checked and found that there was no code for sending a flush request
> > > to the backend device before the execution log was written. Additionally,
> > > in the callback function after the dirty data was written back, when it
> > > updated the bkey, it did not insert this update into the log.
> > >
> >
> > It doesn't have to. If the previous dirty version of the key is on cache device
> > already, and power off happens, even the clean version of the key is gone, the
> > dirty version and its data are all valid. If the LBA range of this key is
> > allocated to a new key, a GC must have alrady happened, and the dirty key is
> > invalid due to bucket generation increased. So don't worry, the clean key is
> > unncessary to go into journal in the writeback scenario.
> >
> > IMHO, you may try to flush backing device in a kworker before calling
> > set_gc_sectors() in bch_gc_thread(). The disk cache can be flushed in time
> > before the still-dirty-on-disk keys are invalidated by increase bucket key
> > gen. And also flushing backing device after searched_full_index becomes
> > true in the writeback thread main loop (as you did now).
> >
> 
> The "flush" command previously issued by GC was supposed to alleviate
> the problems in some scenarios. However, I thought of a situation where
> this "flush" command issued before GC might not be sufficient to solve
> the issue.
> 
> Suppose such a scenario: after a power failure, some hardware cache data
> in the HDD is lost, while the corresponding bkey(with the dirty flag cleared)
> update in the SSD has been persisted. After the power is restored, if
> bcache sends a flush before GC, will this cause data loss?

Yes.

