Return-Path: <linux-kernel+bounces-744623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B42B10F48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD8D1CE554F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02412EA46F;
	Thu, 24 Jul 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hHX7Sjoi"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBA2D9EF8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372717; cv=none; b=USJde77xvl4HMpUkIDPk2TwbQESj7+zFUmk5AAMgtj10eYX+FUpD4Pi2zGO6TINpyCzhdLqM//elX00dWZv8autC2pxeOkcIb/NLgtD7cxLyGMkUqnW9QDYcnFYyQfdoTNEigaOmUtFc7+65PznWedi9IzGh2eXtc6sS1vZaWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372717; c=relaxed/simple;
	bh=ryEeuYcLAYGRvXSCPTjToVf9fiO3CfxafwKjekGe70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsDnDp1mKPXLiKKC7VHUJl1jYODMzgIpFk3HjoRtGEAodDyJvYWQrE0syE1WthYJhTTny2bsJNjlNsZdPeVibwAGVVJhLqlHUxfFkVVUIuk9p2E9LLJRk3/ODAQ1bjFnVReZ1vcFfw900MUx/VAaLax49oZQqV7fo1Bw6sM+ONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hHX7Sjoi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hotx+CjPPtwiBgw2ZnDtNKVWgdykO26wplK2aNK/Zq8=; b=hHX7SjoiN1KNlh/ZH7vwjYfC3X
	vCWh29cH39KzptcNBCnWdyZk3sDrnJ8k6on1PN6HiiMb4beie/FH/cb5fn2UydMCoGiUPaUqn66yL
	k9aW9oNNhjYY2pLT9Na9ltjgEzth7UPtO1SlprJClOX4NOPsWuS1AV+UewyiA0zG29Q9Nk9VQnNZk
	GtXCeDIfVUTo0GqSZss3dtI1IE5mABUtVrna/0M45y1sCJyk51tsQv+NZnjMlyaGtG3P0PvBb9bY/
	gthRfp08znuMR/a6l2YMpRBoo3+YLct5gm43i5frGS54rBbCg3ZUkp+hTTpyfkBQKaaq4luY9C37M
	hVdUxnVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueyL2-00000005oow-2bnL;
	Thu, 24 Jul 2025 15:58:32 +0000
Date: Thu, 24 Jul 2025 16:58:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
Message-ID: <20250724155832.GU2580412@ZenIV>
References: <20250724064051.431879-2-moonhee.lee.ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724064051.431879-2-moonhee.lee.ca@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 23, 2025 at 11:40:52PM -0700, Moon Hee Lee wrote:
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> 
> A NULL pointer dereference may occur in ieee80211_sta_debugfs_remove()
> when debugfs_remove_recursive() is called on a dentry whose inode has
> already been freed. This can happen due to a race between STA teardown
> and debugfs cleanup.
> 
> Fix this by checking that both sta->debugfs_dir and its d_inode are
> valid before invoking debugfs_remove_recursive().

>  void ieee80211_sta_debugfs_remove(struct sta_info *sta)
>  {
> -	debugfs_remove_recursive(sta->debugfs_dir);
> +	if (sta->debugfs_dir && sta->debugfs_dir->d_inode)
> +		debugfs_remove_recursive(sta->debugfs_dir);
>  	sta->debugfs_dir = NULL;
>  }

It might paper over the specific reproducer, but that's not a fix...
I'm not familiar with that code; will check the details, but in
this form it is obviously still racy.

NAK.

