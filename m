Return-Path: <linux-kernel+bounces-794626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834BB3E469
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE41883349
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB78212FB9;
	Mon,  1 Sep 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqfjciJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BA1B21BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732556; cv=none; b=UJ/jNdDUSac+PkvkWHDkT17/FFuZiMeKyGXPAug+pyUr8W8lgqWYxFRRhArHBDl/F1U3uPuWoW+GgJMkfrocwmLs9iNKQXpG6FgO95QhiBEAVGkA0LN+14A3Ld/ZsgNcYMcidW5haK0QDp1mt76x99nxFZVWpAgpDkDCnBCIIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732556; c=relaxed/simple;
	bh=lbW3NpZ8OMo5vXUuKLW7nyZt3k/KN4KzLKs5gPRpd80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCWtIRvQFmSHJzu8KYVasMEa6YcqnsFlWMl8b8SeZ/+ol7zZDUYPdF0L43FtUP+d5yECC3lud5GnU++MuHUpRIH3uTL2ITc7Ycq/uDFGPKRxLsDppT5jdnaZGKHN8THxFBBtILjnBmdzS5mYMTLflB92xhk0ywo5O5o8VDujk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqfjciJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C1C4CEF0;
	Mon,  1 Sep 2025 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732556;
	bh=lbW3NpZ8OMo5vXUuKLW7nyZt3k/KN4KzLKs5gPRpd80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqfjciJfccU1D1ZON4qOg99kMBRfc+vamtPwzv58LXNYrMImE77fIglM0Dxhplsrh
	 D+gHNIRG4LBZV2kHxPTCvtTq7UL8VTjhyaBoVGha9dJqxd2idy4SDBH7e6ERyLLRT2
	 zuFxiJOzBaedX2S9lkWw4A16ZDPwm8jtZkk+WEv+WpOj21U0nWlQIaLbbjbl2fap74
	 WgxWux9mhRyF66dKOper7+TSXeCQ9cwanT9aeOVX7mfHQI1UYOdGN6dIf3NWBescdB
	 it8LAOIXnL9SqK/D5jbayd5b54px7aq3l5hLrRN7Ll+DbSySr17XOe1WN7rE9b3i70
	 a+GONJ6IKRniQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB291F4006C;
	Mon,  1 Sep 2025 09:15:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 01 Sep 2025 09:15:54 -0400
X-ME-Sender: <xms:ipy1aNMlQM8QTmBk-zWJqi4g7f1d7WwLIvW7BtYarqxQ1bVQODusFw>
    <xme:ipy1aFHDc0JV4RcL9PADZN54oMFRfz_rs5NINo8gN0dSYdWraSYlNRf-A58ANkq5i
    pNbCNSlHBf8fdTbzOo>
X-ME-Received: <xmr:ipy1aDj5IekzhJZDd2PwoPNKdlzlx9Wn3tMcTMFXOgNaiQfgpg_L_WSQYzrj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghvrdhjrghinh
    esrghrmhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeiiihihsehn
    vhhiughirgdrtghomhdprhgtphhtthhopegsrgholhhinhdrfigrnhhgsehlihhnuhigrd
    grlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtg
    hlvgdrtghomh
X-ME-Proxy: <xmx:ipy1aBROrRYmndBY8c9P6MCYv06D1z-6_-xaIEvM93HoAH1mfcl9EQ>
    <xmx:ipy1aL-Jg-uKbWAJ0SZ7WRGmO4xisifTHeQ0dJBjUGUXQXXtULFtcw>
    <xmx:ipy1aHQqkvcML0xmHZJskeQrIdfIQc1EMIDuJ9rPNPtfYSTWjJP4bA>
    <xmx:ipy1aCbPm_I0MFPuepm_yqb9zoRDqNjjXTNG0E8x7ELw3rL-sf_eWA>
    <xmx:ipy1aAS_4F_qwHHmt32tyctlxfJLALBUcDgcMCFyJz0M-j0cjLGOC7yc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 09:15:53 -0400 (EDT)
Date: Mon, 1 Sep 2025 14:15:51 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, 
	willy@infradead.org, hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <csqlc5ajszg6bybykeezkpcfqlx7nv5ochikrgttzrhqqjaxjv@y2hwbmqu4qfr>
References: <20250901074817.73012-1-dev.jain@arm.com>
 <7towtl2pjubgdil4csn5rg3usbai5xvzz73wqkwj5b5awh2iim@wfvahykzjrlo>
 <9c3a2ecd-ceae-4e87-a6d7-6a7121ab7a15@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3a2ecd-ceae-4e87-a6d7-6a7121ab7a15@redhat.com>

On Mon, Sep 01, 2025 at 10:32:34AM +0200, David Hildenbrand wrote:
> 
> > > @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >   			writable = true;
> > >   	}
> > > -	if (unlikely(!writable)) {
> > > -		result = SCAN_PAGE_RO;
> > > -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
> > > +	if (unlikely(cc->is_khugepaged && !referenced)) {
> > >   		result = SCAN_LACK_REFERENCED_PAGE;
> > >   	} else {
> > >   		result = SCAN_SUCCEED;
> > > @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > >   		     mmu_notifier_test_young(vma->vm_mm, _address)))
> > >   			referenced++;
> > >   	}
> > > -	if (!writable) {
> > > -		result = SCAN_PAGE_RO;
> > > -	} else if (cc->is_khugepaged &&
> > > +	if (cc->is_khugepaged &&
> > 
> > The only practical use of the writable is gone. The only other usage is
> > tracing which can be dropped to as it is not actionable anymore.
> > 
> > Could you drop writable? Maybe as a separate commit.
> 
> I think we should just do it in the same patch.

Change in trace_mm_collapse_huge_page_isolate() interface doesn't belong
to the same patch in my view.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

