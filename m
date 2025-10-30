Return-Path: <linux-kernel+bounces-878405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402AC20862
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6B418904F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FC23EA9B;
	Thu, 30 Oct 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="s+Ysh6L6"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753237A3C1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833441; cv=none; b=P3Vxvcqtn5HC8wYpgn2q47NYS80mpSnQEpobT1SKbPcVe8tBXeuDcu9MWrR6saYZHjk8RpUGgeV7V1BbTG/Dp7Si9C+oNO5ZkzCJD2fPTx358d+33n9mjOsn7vEt2m9kEYi0FKPwotITJ810HGawxf4AuIXvp2fKOHee0oFacxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833441; c=relaxed/simple;
	bh=x0gRfgwwb2IFkRD0DpGlvxRNflqEZumP+YvMoSdPXqQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I7e3/51k8pxc2UmIG5/QpjYmcx3lie36Yf5Ah/lxm+eI/pm+4EO9n5dbVfCL0lapL6+ugikpx+pw4IddELQ+DvCWS0Wk27LxcmheeNJDUYAqXoF6s3KyF4r6vvhXPciQ0hN3XRtCToR1b9+hlcvD8F55/AjuH/R4pO7KtD3es3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=s+Ysh6L6; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 0fff8db7-b59a-11f0-ad1a-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0fff8db7-b59a-11f0-ad1a-005056999439;
	Thu, 30 Oct 2025 15:09:34 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0d2a1850-b59a-11f0-99be-0050569977a2;
	Thu, 30 Oct 2025 15:09:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=2eEy/6EcAVyFWHfUVEkAOX6BOji9hmVNnJRFpSNEEMA=;
	b=s+Ysh6L6riHvxHupOpCI8JFjCudaFSIccfn0bhjjL55didougKPvPiPCV1SFe0P0nlpvzgoimjUw1
	 kNFRbrBEUd9nsrS5/v5t/rcWAylg8NQPNOErPnC/SxFtOZ0h1JD2MFU1+n6lG2IMwCFZtknuhvyQSg
	 biGcLG+22RVlyEpBvDVKmztLiRmzGhYRFsdwVJh3Q9JtKzP2ZNK2fvgJ4pUtabLdLLDVFS3rQlcvpO
	 ay9I6fpKAT7vq0pFrhA2tRBX6C9t99dDWHLmF49y8Zf06ad2OrqoC1uiqjGJnHcA9UleLl/1fbLTRK
	 KlrQiEqb/yyDzY0srpaH3zFYUaxLIIw==
X-KPN-MID: 33|gOa/nWvXxVoNd4itQTBEZz7rboYn28RKV+/yRyql5XYbyO//xOtnIvAjjbl62iM
 ThwB+7SPjLai5cL+PCkbDJjHSapoUuvJvi2wQzN6u74U=
X-CMASSUN: 33|Rmem3q1b9cO3SQxroIm/awni+4Ar88f5X/NYEBW+vJM5bTO+fgfCQ/8yVRnsK1E
 hYGnb/ZuRGy82l2iOy3akTA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0d1b85ec-b59a-11f0-94b1-00505699eff2;
	Thu, 30 Oct 2025 15:09:29 +0100 (CET)
Date: Thu, 30 Oct 2025 15:09:29 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	Khalid Aziz <khalid@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>, Taotao Chen <chentaotao@didiglobal.com>,
	NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
In-Reply-To: <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
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


> 
> I don't see a licensing issue. It's BSD licensed. Also, this is a
> userland code, so we wouldn't need to worry about that too much.
>

Oh, my bad. I thought Minix (the OS) had some licensing incompatibilities
with Linux, and this repo takes code from Minix. But that may be long in
the past.

> 
> You're quite right though that userland replacements will need to meet
> some criteria before we can rip out the in-kernel versions. This might
> be a good discussion topic for next year's LSF/MM!

Would an in-tree but out of kernel implementation be an idea? Like how
kselftest is integrated in the code, even though most of that also takes
place in userland. That would guarantee a level of support, at least for
the time being. I could take the code, verify it, and write some tests
for in selftest.

And there is still the issue of what we do for the syzbot bugs until a
more permanent solution is achieved.

Anyway, this probably goes over my head as a clueless beginner. Just
trying to see where I can help. Thanks a lot Jeff for you answers, I
appreciate it.

Jori.

