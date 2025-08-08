Return-Path: <linux-kernel+bounces-760367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E0B1EA3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75E63B28B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6027E07B;
	Fri,  8 Aug 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLUl3Dnu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA23594C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662845; cv=none; b=DCBdlh5dQZXS/040y3eAtmAvBQXLtNdNlWiD1Nj0WPFtSDxuT07oyq47veJvk/+Ff1NG3C+smiQXS27WgXYi80ph872ZJO4O++QYtAvzEZnpiB6udvaD0aSlj2RyJGkIY4jN445wSuTqMBYY/Tyh7WkonjfNjoDQM3WVW5Ey5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662845; c=relaxed/simple;
	bh=tDanMDF7NSdHJArEW9Dn/YhfJMaDLhAoellmFVPteoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+SNXSAjdZ3IbKYAm7jMFi6MAAGnvu2voqgYfoVu+ie9GXFpLBOL69Ib0/yCo9fOOe5+c7l0S9XlIYRgl3ZCgTY6t30s4EnVCPUbWl8GCy6502RiRN7BaJNLwkayLGLhoVMjvzlzK+Vj0uy0YQI5zqsC0aMSFnuNg0E3WhDmZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oLUl3Dnu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZK6TQC+G4OnlPVEtP+8kObCZsoquXr6dRAsNr/EOhLs=; b=oLUl3Dnuif+1i8JMDXppVUlfzV
	SHMvNRysBszknYyBS7qdZ6Jen+9y1xzhZvIrhJ2Wwkrb3pNTScCDACyoqj0/MTcG1aF7dV3GMGRJf
	QEzlFk/8bt0PS3PdTwl6OxS/2ZlI8KILkx3ELKMXfEArgUS7H4dTbFsgZPwMupTgJWOzxbjGcXx6k
	dQPkUM+/ZLe4pKBWms9TBYlzZCXWkbqNsImEnFMhajpXjduPntXdtmk785I/klDiOs+PKstG6l9HR
	fNlPvwatfnXQP2WTfXG+K0tASKmvPGul4CJygArRmWnrGTkNmrra+Vo0EqHagtnkSejH0AqObKTRQ
	DFF9C3bw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukNxY-0000000EULv-4AJl;
	Fri, 08 Aug 2025 14:20:41 +0000
Date: Fri, 8 Aug 2025 15:20:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: yes PANG <pangyes608@gmail.com>
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	sandeen@redhat.com, dan.carpenter@linaro.org
Subject: Re: kernel BUG in jfs_evict_inode
Message-ID: <aJYHuO771xiH3a0J@casper.infradead.org>
References: <CAJLDUOf6tk0SSL-Qf9WN73tbOjQqL86vVN1S1uPd4LE5p102eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJLDUOf6tk0SSL-Qf9WN73tbOjQqL86vVN1S1uPd4LE5p102eA@mail.gmail.com>

On Fri, Aug 08, 2025 at 11:53:02AM +0800, yes PANG wrote:
> Dear Linux maintainers and reviewers:
> We are reporting a Linux kernel bug titled **kernel BUG in
> jfs_evict_inode**, discovered using a modified version of Syzkaller.

Don't do this.  Work with the syzbot people to get your modifications
upstream.  Dealing with "my special modified version of syzkaller" is
painful for everybody involved.

