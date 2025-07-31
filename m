Return-Path: <linux-kernel+bounces-752438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3FB17594
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A395CA80894
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40307264615;
	Thu, 31 Jul 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mgKoT17h"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17B13D8A4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982940; cv=none; b=QfnyxuFFVsq5Mweg96oguayCrsTrechqeBvh+kIkB23zwZ4TXFlLjL89pTK5rO4n9LrIEru5zVVUVegmd0xLcYp2e9cWZDB1U4MpT3K0xRX7Js+TtMMOiV1g83P/fXKG4+VTRlH4xHUIerdWY05nfrq2lBxWVXNFfxJBL4WOd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982940; c=relaxed/simple;
	bh=7eoSokCF8arafZEuyCrzN1S2Uwk35HNEsUdMYr5dyDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q96jo1pXm49ZBhSD58xyNexWRPM/6ld2vw9yhR5qKYiUke1I2fJIgayAGGqnLsvniGsboY/RJICW07NDRwoqbIk4WDv+0X3FGp9dVwci+JaVgDkHk/MmzZx0g/UH344P2vMI0M9TcLtEZvR1zDQgtH287mNMHwqVo2VytMCREcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mgKoT17h; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Fwx/pYBtKXWSp2eD62l2WVnaBhf3VbvA/LumAEnqK8M=; b=mgKoT17hfHhfqHCfw/GTS1boTc
	gT1ciF9/Y89OCJXn0ReK4dbkBjHuk1kPwPZiA9VWt+/cNgr8Rqstilp9/26PvA6Rn9yBkVGNsxGyp
	qaf6SrXSqAfcWIyelsG7OIzTBZLrM9eV0Um6t084UDGxddGUTbcTng1gkie6ip5evKTknaU7eLFMt
	drfyjNY7lnC2NBw6e6EAljnKg2ql50eaCmK0lFaDHCgVMILYHnWPJZOQN+o16H6JPqwQgY+0rt5PV
	4bgurdkfHUpr9gUFAYtzqC5zDPfmJ/rxQPAWCb3gF6QiAonRFXRf3b1YRlFYJhE0DkkbqQLAlegJW
	fFUPuSTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhX5I-00000008AHq-3KCj;
	Thu, 31 Jul 2025 17:28:52 +0000
Date: Thu, 31 Jul 2025 18:28:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	hdanton@sina.com
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
Message-ID: <20250731172852.GQ222315@ZenIV>
References: <20250731171729.46432-2-moonhee.lee.ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731171729.46432-2-moonhee.lee.ca@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 31, 2025 at 10:17:29AM -0700, Moon Hee Lee wrote:
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> 
> 
> Thanks for the review and valuable feedback.
> 
> Upon investigation, I found the crash occurs when the netdev's debugfs
> directory is removed while a station still holds a pointer
> (sta->debugfs_dir) to a dentry within it. A subsequent call to
> ieee80211_sta_debugfs_remove() may then dereference a freed dentry,
> triggering a use-after-free.
> 
> To address this, I’m preparing a patch that clears sta->debugfs_dir for
> all stations associated with the interface before calling
> debugfs_remove_recursive(). This ensures any later station removal
> becomes a no-op and avoids referencing a stale pointer.
> 
> This reply is intended for syz testing and to provide context for
> review. A formal patch will follow.

> +	/*
> +	 * Before we delete the netdev’s debugfs tree, clear sta->debugfs_dir
> +	 * for every station on this interface.  This ensures any later call to
> +	 * ieee80211_sta_debugfs_remove() sees NULL and avoids touching a dentry
> +	 * that we are about to free.
> +	 */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
> +		if (sta->sdata == sdata)
> +			sta->debugfs_dir = NULL;
> +	}
> +	rcu_read_unlock();

Umm... Is there any exclusion between that an ieee80211_sta_debugfs_remove()?
This looks fishy...

