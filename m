Return-Path: <linux-kernel+bounces-753964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B41B18AD8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116286277A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7F199934;
	Sat,  2 Aug 2025 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XtbbFQf6"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FCB672
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754113980; cv=none; b=nNluK7lFSQ3Hz4+pfLY4G+oGPZWnKtv4NC/q/Mu+odHWV0gb6xDqhlpt9MYiReigzUyy59mP1ySCh8fump+GOW47zByqvrB899febqc8sX1upjHOJIYSwAJNKLrOv/8QCYmSGnMCtSE/ZciJxGZeF7UEn3nTS6u/DMpwKKz2YWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754113980; c=relaxed/simple;
	bh=wNO3uLn2upUzq89T01Jao8P4GbWLlf6GDGAd0/xCyWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9tfcqr3rnrpBkaWnlTj/KUGEyy1msWrzx97knICgc5BHgtTKWsZeZ5Dvb5fFZz4G+B8gQm1tBxs/kgeu6aTsyPMOeCwo49gvK4XMQ+6EmRijUabSL6YidWFFjuMueN83i2GIxsNTpxd5oLSyDYaox1YOaM4bxdTl5XrO1KXIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XtbbFQf6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=HHCaNB52yuekIRwCCDC1USYuyWytAzs8P2QVsRxGOLY=; b=XtbbFQf6NE9NBvDMM4qJyHTled
	GJ6YKJNpSj+K3CDEfZhSw2jJ6bwPPledS7gd3yyXnz9O6wqG0NIMu/xBkYJ/kLenGaiJFysMwdSEw
	sJkamOaKUiN2H8fhVFMIL9CGgyNtcpYJUjImUhTITimKvitDCY6pzHumYhBMKeV/DRJmcVkTodwy8
	P5FXgWGEpdnH6ijk3ekk1xlBjX6Wgd+rVJucsHeByn4KSnDn64hX/HfgrV15sIc7P1OIorD8TqSD7
	QvuS8hWCKqRgyrPHilp5ZmKwEi3C+HI83YasWJQVNaFe6ySX6dgKD5EDCjXTSU1mYlyapKsbqqcO9
	GbRK71WA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ui5Aq-00000005klp-24eO;
	Sat, 02 Aug 2025 05:52:52 +0000
Date: Sat, 2 Aug 2025 06:52:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYQ==?= =?utf-8?Q?l?= Mail]Re:
 [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802055252.GU222315@ZenIV>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 02, 2025 at 04:32:39AM +0000, 高翔 wrote:
> >       __task_pid_nr_ns+0x74/0xd0
> >       ...
> >       __handle_irq_event_percpu+0xd4/0x284
> >       handle_irq_event+0x48/0xb0
> 
>         Huh?  Just what is it doing inside an IRQ handler?
> Hell, the notion of current process is not usable in those,
> let alone any properties of such...
> 
>         Details, please.
> 
> 
> Obtain the current process pid in the ufs compl command. This scene is possible.

Nothing of that sort in the mainline (or -next, for that matter), but...

>  Call trace:
>   __task_pid_nr_ns+0x74/0xd0
>   get_common_info+0x9c/0x1c0 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
>   io_monitor_global_log+0x1a0/0x294 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
>   cb_android_vh_ufs_compl_command+0x304/0x578 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
>   __traceiter_android_vh_ufs_compl_command+0x54/0x78
>   ...
>   __handle_irq_event_percpu+0xd4/0x284

... for asynchronous callbacks if that sort there is no such thing as the current
process.  At all.  Using current, let alone looking for its PID, userns, etc. in
such context is a bug.  Don't do it.  It's a bug in your module.

