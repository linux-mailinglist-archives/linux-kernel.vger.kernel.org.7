Return-Path: <linux-kernel+bounces-878191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73932C1FFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F0619C5969
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CE2F83CC;
	Thu, 30 Oct 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="na+pFh2S"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C181F4631
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827045; cv=none; b=JcquolQFvsNKyILUngTU2aCQ2W/IXjgFb3qkAhdp3Jx0JwejNLdx6LG1IvZuJPQlifnKfjm3rSVIfkgjuU2dP4jo3LYx1Zw9evG3GXgl4JBfYnMaOaCsGU/kHbD1KEXmY6ztggc9wfMvlXYvSDzMgDMM3Hwep1bbfqOOjtkkX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827045; c=relaxed/simple;
	bh=brCK5tMNj3yFo9Tm+NXeTbfAWOsVC0hNn45lh4GGU2w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fn2NtyZelqlVRSXfMm+Qzgr2RQ10Mrg4BwuOqfhrUt5Gn6YJ2TzWFrK+LBGjMJlLHPW7tR/npUO02ET8Isv7BsLR4TUFNjRx8MNNl/Nm+O8Djod5nuYxI6t2zjK1sdshfxCOGDlqhksxVPzRUw4jX52IcXmJ1i016mZgmVt3SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=na+pFh2S; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 55da0dd0-b58b-11f0-9e68-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 55da0dd0-b58b-11f0-9e68-005056994fde;
	Thu, 30 Oct 2025 13:24:09 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 2889fedf-b58b-11f0-83be-00505699891e;
	Thu, 30 Oct 2025 13:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=TweaoBplodlVdxsoJvbnrw8dG9VhGVy4IBPuwkFtA4w=;
	b=na+pFh2SAXn53+El5NKC6JTwHXPdQ0s0qL4Hw36fPaiVrxe6Tbb+JRAmCHerBcupxMINmux5xX6PW
	 xoedI+o6lrP3hrl82HG9yt3z/w3K7Bv0eFy0TDz2fpUARj0XT9n0XCBHi9jJ/UV0Va06TQEWvEF6hz
	 NEb6IwRwbj/Ysl5zYBohnD/+qmETgJWaQhqhp88FteJPwkKGktl2Rte6moSEPG32fgFfLwOp+uT0Iv
	 9ymJw4fI/J0wKRxeAZyE8NsWB67SlNROIeud389EAnoj+cqI8JXIdRXeF0VBy2w+b1dvwPP8e2I54s
	 YQpiKjx8/2QgYdAXZL8uUXEviJ5G8dw==
X-KPN-MID: 33|siE5HIY6JarvfY98K0xoGPPK/p30dpPuEVCR8saV2W/Ms2kI5ezRaP3t7oqOTz+
 cL64LA0Qewzv3csud18uvadi7k+24a1y4tGq8bw5hsB8=
X-CMASSUN: 33|PhRa11lWUxe5ynUPN2POeMvXUOvjPXXG2Xswc5ny+OdIqo1JMttOc5NXO3mrkom
 9v1dVygRJtHP/5LeFYXGKSw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 2882cf03-b58b-11f0-b8d7-005056995d6c;
	Thu, 30 Oct 2025 13:22:53 +0100 (CET)
Date: Thu, 30 Oct 2025 13:22:53 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	Khalid Aziz <khalid@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
In-Reply-To: <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
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

Hi Jan,

> 
> The patch looks ok to me but since minix filesystem driver is in the kernel
> mostly to allow mounting ancient unix filesystems I don't quite understand
> the motivation for adding the new mount options. Why not just fixup
> minix_rmdir() to better handle corrupted filesystems?
> 
> 								Honza

I am doing the Linux kernel mentorship program, and was looking to contribute
to fs. Since I saw a lot bugs on syzbot related to minix (and jfs too) not
handling corruptions well (yielding warnings in drop_nlink e.g.) I figured
it was a low stakes project, not completely trivial, yet within my scope, to
attempt to implement what ext4 does for these kind of problems (and jfs
implements the same opts too).

I would have asked about the exact status of minix, but was told not to
bother maintainers without a patch. I would be open with trying to improve
minix further, but of course if there are better options to get it out of
the kernel altogether that may be better. Sad for me, since that means still
zero patches, but that is not your problem :)

Anyway, I hope this clarifies why I submitted this patch.

