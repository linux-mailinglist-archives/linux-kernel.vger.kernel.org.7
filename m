Return-Path: <linux-kernel+bounces-852398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D2BD8DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EA53A72B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123551F2C45;
	Tue, 14 Oct 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFV8cR26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70D2FC881
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439630; cv=none; b=bXrNcQvkHErCMRuCyIkag8SAbm06pRNObDFfahE/uPnJJTW4fcoqi8BLqbiqmdi6SslZ7l49h61WaA0zcZ0NI5/Pe7BntyHUpASa/kpP9jY3SJd4Y+V5sK29qqACJJbEfOnm8h3zgc0pU63MSFBP8CFUthWjLyJlu+xyIaS5Lwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439630; c=relaxed/simple;
	bh=4HIgfhLvPqzNBu6Z2hIhS6vqYvH1aFHpyuxvAz8zyZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNYWkhL+AboUqpJw3yMR62Y5cwsflCzFQzoRJ9a/4weffflyFT9EDVYpHEBLAYdf6Alx5AqZa33zj+b+fXOMpEBaa5uhiVcGRoCFRE0lDJVj4Rrirys2CtDSjo0/fJL2AogiIpFJZouq+0rh31KYzn9M8N2osj6gqwedJ13feAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFV8cR26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0D1C4CEE7;
	Tue, 14 Oct 2025 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760439629;
	bh=4HIgfhLvPqzNBu6Z2hIhS6vqYvH1aFHpyuxvAz8zyZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fFV8cR26D+e/RapJqsjC4C4EP0/dWT6Ks+uNj+7kIQbhoooaIA8/oSX4O5kE7HZno
	 MjzzSAALbYeJ7RhzBnkxSGBH5oJmiix0FWQ1cNqyuBg1gzthO14t5lAh9j5r1e9Wbo
	 PAfeV7VJs/cV6EfLyKRGo41tcIdwhSIno3CC9pK0cUp9jyLyChgcM89Il9suYoS9xq
	 n6CJ+ZlLG+s22+c0Yolq6Vn5y8P3nnVtnsVnNojUxV0CacWmPuKLFSZWHd6x10qaWj
	 MCTRHwfUVQsK+jN+COTKA1qfIvj/QyUPqRGuCopci+xvQ/0FlOPsKKDzUBU2Pr6geb
	 0J0DBD/Xhuwxw==
Message-ID: <a8e1e739a534051ec8c065cf3e6750c734a0d2e5.camel@kernel.org>
Subject: Re: Linux 6.18-rc1
From: Jeff Layton <jlayton@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List	 <linux-kernel@vger.kernel.org>, Feng Chen <feng.chen@amlogic.com>,
 Matthew Wilcox <willy@infradead.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Date: Tue, 14 Oct 2025 07:00:27 -0400
In-Reply-To: <20251014055458.GA2373807@ax162>
References: 
	<CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
	 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
	 <20251014055458.GA2373807@ax162>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 22:54 -0700, Nathan Chancellor wrote:
> On Mon, Oct 13, 2025 at 10:08:22AM -0700, Guenter Roeck wrote:
> > Building openrisc:allmodconfig ... failed
> > --------------
> > Error log:
> > In file included from include/linux/cpumask.h:11,
> >                  from include/linux/smp.h:13,
> >                  from include/linux/lockdep.h:14,
> >                  from include/linux/spinlock.h:63,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:7,
> >                  from include/linux/slab.h:16,
> >                  from fs/nfsd/nfs4xdr.c:37:
> > fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
> > include/linux/kernel.h:334:46: error: called object 'strlen' is not a f=
unction or function pointer
> >=20
> > bisect:
> >=20
> > # bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
> > # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> > git bisect start 'HEAD' 'v6.17'
> > # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-=
2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
> > git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
> > # bad: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-upda=
tes-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
> > git bisect bad bed0653fe2aacb0ca8196075cffc9e7062e74927
> > # good: [be812ace0378a9db86344ad637c5ed2a5d11f216] Bluetooth: Avoid a c=
ouple dozen -Wflex-array-member-not-at-end warnings
> > git bisect good be812ace0378a9db86344ad637c5ed2a5d11f216
> > # good: [8804d970fab45726b3c7cd7f240b31122aa94219] Merge tag 'mm-stable=
-2025-10-01-19-00' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > git bisect good 8804d970fab45726b3c7cd7f240b31122aa94219
> > # good: [b3fee71e6673393d04476fbe0f4f03f97765e32d] Merge tag 'v6.18rc1-=
part1-ksmbd-server-fixes' of git://git.samba.org/ksmbd
> > git bisect good b3fee71e6673393d04476fbe0f4f03f97765e32d
> > # good: [944df7a31452f75bbc15b1e7215e1aacee8cd1b4] docs: update the gui=
dance for Link: tags
> > git bisect good 944df7a31452f75bbc15b1e7215e1aacee8cd1b4
> > # bad: [50647a1176b7abd1b4ae55b491eb2fbbeef89db9] Merge tag 'pull-f_pat=
h' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> > git bisect bad 50647a1176b7abd1b4ae55b491eb2fbbeef89db9
> > # bad: [c817248fc831f5494d076421672b70a6ec1a92dc] nfs/localio: add prop=
er O_DIRECT support for READ and WRITE
> > git bisect bad c817248fc831f5494d076421672b70a6ec1a92dc
> > # bad: [4b7c3b4c673d40e4b98cdaf642495929f43787e6] NFS: Update the flexf=
ilelayout driver to use xdr_set_scratch_folio()
> > git bisect bad 4b7c3b4c673d40e4b98cdaf642495929f43787e6
> > # bad: [bf75ad096820fee5da40e671ebb32de725a1c417] NFSv4.1: fix mount ha=
ng after CREATE_SESSION failure
> > git bisect bad bf75ad096820fee5da40e671ebb32de725a1c417
> > # good: [64dd8022245038109826c0e2a778f16618d88600] nfs: cleanup tracepo=
int declarations
> > git bisect good 64dd8022245038109826c0e2a778f16618d88600
> > # bad: [be390f95242785adbf37d7b8a5101dd2f2ba891b] NFSv4: handle ERR_GRA=
CE on delegation recalls
> > git bisect bad be390f95242785adbf37d7b8a5101dd2f2ba891b
> > # bad: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: add a Kconfig=
 option to redirect dfprintk() output to trace buffer
> > git bisect bad ec7d8e68ef0ec5c635c8f9e93cd881673445a397
> > # good: [9082aae154be2d9e208b56e249cb886612f7c6cf] sunrpc: remove dfpri=
ntk_cont() and dfprintk_rcu_cont()
> > git bisect good 9082aae154be2d9e208b56e249cb886612f7c6cf
> > # first bad commit: [ec7d8e68ef0ec5c635c8f9e93cd881673445a397] sunrpc: =
add a Kconfig option to redirect dfprintk() output to trace buffer
> >=20
> > I did not try to understand why that patch triggers the build failure,
> > but reverting it fixes the problem (not that it is a good idea to have
> > a variable named 'strlen').
> >=20
> > Author: Jeff Layton <jlayton@kernel.org>
>=20
> I sent a patch for this:
>=20
> https://lore.kernel.org/20250930-nfsd-fix-trace-printk-strlen-error-v3-1-=
536cc9822ee6@kernel.org/
>=20
> which Chuck appears to have tenatively applied:
>=20
> https://git.kernel.org/cel/c/c710de671789388b3af1046c7091685594ec44d9
>=20

Thanks. I believe Chuck is planning to send that patch to Linus in the
next post-rc1 pile of bugfixes.

--=20
Jeff Layton <jlayton@kernel.org>

