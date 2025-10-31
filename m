Return-Path: <linux-kernel+bounces-880847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D291AC26B47
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A322188774A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710230C36B;
	Fri, 31 Oct 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3BZT3QWu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzGxr6YQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3BZT3QWu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzGxr6YQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2C2BD031
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938454; cv=none; b=Pj2TtvWgvzb3QFDbsynDrZ56SO3LudlOcfKTLc7bZ/+uXS+7u67S/eF0BPxfvcfTPoATX1szdIGvtt0Bv3rsPvu6oRxghwXlhmYlp+bsJP5FxfZQ83IpQT9vmxaxMEDxI0SA9Ecs9CjDhitLe98joH2kCmQsbog+Q84/KivF76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938454; c=relaxed/simple;
	bh=tdIQVzxCdHHST+lx9mVyeTdC1vPSDJtBFjO11Q1I9Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMAQLBszPttnsCu0KTebfUDeX6Ooa9XUZQZ890V6qreP9KmWl+tutxua+gnij9NlhLB5nOkK5wVQr9+8aCNsAuzQ7T5WT6GJ3jHL4rxPexhNh/snY6PvPQ7TFVu6oKda7G0pk9b5FCxLglsMWVtG60XXHBxTKgvl+92Kc4KEBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3BZT3QWu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzGxr6YQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3BZT3QWu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzGxr6YQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2FFE1F387;
	Fri, 31 Oct 2025 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761938450;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8CXA0Bjn3nF33c1hD4I/XDZ9ecku8uMBSoXdaq4Hbs=;
	b=3BZT3QWuSqhiQoTYmeZWu9KGw2WejhoV6E2MDVle4yvYDFGU7c7ttdKNQY+Fp0IyUCqXGM
	xivAwvpClFy2PCCvP1ClbUGw/cfQDUk1Rtb0yBBgdACM43+r24/XrEC4HYuBO3PR1sjGAo
	tAKdFFDoILmGfJ4K+HcaVXzuQ0IvRc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761938450;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8CXA0Bjn3nF33c1hD4I/XDZ9ecku8uMBSoXdaq4Hbs=;
	b=zzGxr6YQ26SUNRuFd3NgsL5J39WCzLqVnOehs2uxEb87wNBfVFLxnLx4icWATHU3yaXykg
	8Nomhra/cExAQKAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3BZT3QWu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zzGxr6YQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761938450;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8CXA0Bjn3nF33c1hD4I/XDZ9ecku8uMBSoXdaq4Hbs=;
	b=3BZT3QWuSqhiQoTYmeZWu9KGw2WejhoV6E2MDVle4yvYDFGU7c7ttdKNQY+Fp0IyUCqXGM
	xivAwvpClFy2PCCvP1ClbUGw/cfQDUk1Rtb0yBBgdACM43+r24/XrEC4HYuBO3PR1sjGAo
	tAKdFFDoILmGfJ4K+HcaVXzuQ0IvRc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761938450;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8CXA0Bjn3nF33c1hD4I/XDZ9ecku8uMBSoXdaq4Hbs=;
	b=zzGxr6YQ26SUNRuFd3NgsL5J39WCzLqVnOehs2uxEb87wNBfVFLxnLx4icWATHU3yaXykg
	8Nomhra/cExAQKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67A113393;
	Fri, 31 Oct 2025 19:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id peKEMxEMBWkOKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 19:20:49 +0000
Date: Fri, 31 Oct 2025 20:20:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>, HAN Yuwei <hrx@bupt.moe>,
	linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs] b7fdfd29a1: postmark.transactions 9.5%
 regression
Message-ID: <20251031192048.GK13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202510271449.efa21738-lkp@intel.com>
 <2adac975-01f1-4640-a073-715c804987d6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2adac975-01f1-4640-a073-715c804987d6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F2FFE1F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Mon, Oct 27, 2025 at 06:19:59PM +1030, Qu Wenruo wrote:
> 在 2025/10/27 18:11, kernel test robot 写道:
> > Hello,
> > 
> > kernel test robot noticed a 9.5% regression of postmark.transactions on:
> > 
> > 
> > commit: b7fdfd29a136a17c5c8ad9e9bbf89c48919c3d19 ("btrfs: only set the device specific options after devices are opened")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > we are in fact not sure what's the connection between this change and the
> > postmark.transactions performance. still report out due to below checks.
> > 
> > [still regression on      linus/master 4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d]
> > [regression chould be solved by reverting this commit on linus/master head]
> > [still regression on linux-next/master 72fb0170ef1f45addf726319c52a0562b6913707]
> > 
> > testcase: postmark
> > config: x86_64-rhel-9.4
> > compiler: gcc-14
> > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> > parameters:
> > 
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	fs1: nfsv4
> > 	number: 4000n
> > 	trans: 10000s
> > 	subdirs: 100d
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202510271449.efa21738-lkp@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251027/202510271449.efa21738-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/disk/fs1/fs/kconfig/number/rootfs/subdirs/tbox_group/testcase/trans:
> >    gcc-14/performance/1HDD/nfsv4/btrfs/x86_64-rhel-9.4/4000n/debian-13-x86_64-20250902.cgz/100d/lkp-cpl-4sp2/postmark/10000s
> > 
> > commit:
> >    53a4acbfc1 ("btrfs: fix memory leak on duplicated memory in the qgroup assign ioctl")
> 
> This is definitely not related.
> 
> >    b7fdfd29a1 ("btrfs: only set the device specific options after devices are opened")
> 
> But this may affect performance, because without this fix, btrfs always 
> falls back to `ssd` mount option
> 
> Now it will properly detect rotating devices, and won't set `ssd` mount 
> option by default.
> 
> But if this is causing performance drop, we should really consider if 
> `ssd` should be the only mode we support.

I think it's a good idea, though this can have also negative performance
impact.

The SSD optimizations are now only the cluster size selection
(fetch_cluster_info) and waiting for log writers (btrfs_sync_log(),
added in 2011 cd354ad613a39). IIRC there used to be selection for the
async io.  On rotational devices the extent placement can have impact on
seeking, but this becomes upredictable on aged filesystems.

