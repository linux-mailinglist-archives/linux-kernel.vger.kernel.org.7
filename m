Return-Path: <linux-kernel+bounces-878311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968FDC203CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B73B42E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61639218AB0;
	Thu, 30 Oct 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kcKuqp6A"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53A2557A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831111; cv=none; b=oNYonIyLkfa2JzuwgNrHCl+qmGGFjTu68HDqnnEzpzcCenvZsteRXQnij1GSAEGJQqNBMu2akDADDdo61lSCBCQxGgyNWfndop/CUEYWG7qLJGGWuvFws67r3zY/dncQTIf3tjC/8o4MbSecjJWNxnPotQuqSqDolYDP8uXKjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831111; c=relaxed/simple;
	bh=Svk7dHTr2ilj/YLrcK7cgXeMyf3gp21F7lY8CtYHzZg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PsA55u4i7jjxOiNhW7M7J+ZaNG+bR9XQmcx9dBw0HF4LrvH8OUW6ZfQkSGlDbopojVggkiMGBO8CDzdxMDQw6WFIqeTuo3azF3xBHE1qfEo99L5yftH46+umhWUlouulQ/F1lgj/76ZuT2Er5txdn8Q5zpALjTrmRwuiwENxIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=kcKuqp6A; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: f5535523-b594-11f0-9e68-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f5535523-b594-11f0-9e68-005056994fde;
	Thu, 30 Oct 2025 14:33:02 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c7e42fe6-b594-11f0-83be-00505699891e;
	Thu, 30 Oct 2025 14:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Svk7dHTr2ilj/YLrcK7cgXeMyf3gp21F7lY8CtYHzZg=;
	b=kcKuqp6ASEbApVy9Gyh4LyN/2jxHKkK+rbsnYpz2rGOelmxG0m3ZzvOM/swIgbkG9564c87Iv6iPB
	 RqPBNtYIrMTbDeINr9TtjVSrFblrgs3sV1vGXFwUA1k8cPnqu8PPTHO2wDExav7YTQ+aUhAnRMa1yx
	 k2UWPbuhQG80W46M+hF66g7KUaYBoauNR7zw/0sNQQxW5SivBrsxBySbA2VZXROJ7VbfMwJ+GuuNmX
	 a0MK37kBSvvZBvu3Lca3ISxe8gVVR0mUS1DgO4McWyjH+uzEAy51GRgrLGwWbVmYsfrVJejNFQUrHT
	 32Kx+FDFNtyu3AJqroPKxxUAfKTWVyw==
X-KPN-MID: 33|PUFm3suIrV9htZ/jvjyEBKrg4hqi0rEj+UtlxHv9wmLaZpK1+zL7Zy83eLPZXkU
 69uc09EhQ13OPi8Ey5wEfG3tuun13jINDcoD7Rvn3Haw=
X-CMASSUN: 33|DXt98IFyBX15frFu4ymS61iafF6ai2qlLsORvzhSO73HHzjtTydFd5SUGDn3PBj
 xE4/F8DUYCuAxxQXHNqf6Ow==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c7d748cd-b594-11f0-b8d7-005056995d6c;
	Thu, 30 Oct 2025 14:31:46 +0100 (CET)
Date: Thu, 30 Oct 2025 14:31:46 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	Khalid Aziz <khalid@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>, NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
In-Reply-To: <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

> Not necessarily.
>
> I'm not sure if your internship covers this, but you could start a
> project to build a minixfs FUSE fs (if one doesn't already exist). If
> you get it working and stable, you can then submit patches to deprecate
> and remove it from the kernel.


I would have to ask Shuah but am open to it. But a quick search turns up
this: https://github.com/redcap97/fuse-mfs . I would have to see if it
actually works and it does not seem to support v1, v2 of minix fs either.
There might also be a licensing issue.

> For some background: this is a continuation of a discussion that we had
> at LSF/MM summit this year. A lot of these smaller, less-used
> filesystems represent a significant maintenance burden. Whenever we
> have to make changes at the VFS layer, they represent another fs that
> we have to touch.

> Many of these are not performance-critical and are hard to test. They
> would be _much_ easier to maintain in userland if we can make that
> work.

One question I would have about this is that if we move minix, for
instance, out of the kernel code, how can we be sure that it is
maintained. What if some Github repo suddenly disappears? Like I said,
I would be fine with helping maintain minix, otherwise what should be
the course of action from here? What demands do we place on a userland
replacement for minix before I submit a patch to deprecate and remove
the code?

Thanks,
Jori.

PS. Sorry for sending this twice. I am still having to remind myself to
"reply all". My apologies.

