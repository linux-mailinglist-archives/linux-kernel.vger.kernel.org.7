Return-Path: <linux-kernel+bounces-811745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E9B52D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E6C3AD3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65932EA481;
	Thu, 11 Sep 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QC+t+69u"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AF2EA147
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583184; cv=none; b=eXorWsdDB9vbFHerPFZ8A/5XJm1cc7l9wE/Ei+3iVNbWtnGqoMVaVdC8PbnHpQHw7XFCq010yzYAD7V8JiT0JsinRrqmr1rRHQhEld203ejN4w+vg80sWjlU3j6jjbrp+yxhsK6bK5YS+I9+OQr13K9SYUAn2tCyXDvjwpLACqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583184; c=relaxed/simple;
	bh=6zJl6jcafeCZ6YmJZKiwF1mOHdjn2LFeup/aII/uTkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDj67kfXULRKQq8B+pMHztfJNPgSb6irUNaQgMZmzgmz72ENmSR7z7PM+sP3Tf8wI0ztcDiS39UHFXp/LhE1xiEepJDbIElj6O43v2BbA1DA8PYqGFZz66PFlpJ4+ket3xBtW92C+Hg5jsjfrsdC3Ke5lKKvDimgMxh0gM4THks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QC+t+69u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6zJl6jcafeCZ6YmJZKiwF1mOHdjn2LFeup/aII/uTkE=;
	t=1757583182; x=1758792782; b=QC+t+69uG4DucNnuK/YfvucwvFZUNe4Gccx1wH0hgKL6Zi2
	ch4Qkl16qFgxchDiDpaYI7UMsH1JZ5+ZdzHLvw7mw1jgImQUZXBfrMGlCQHE5ectmDaPdDrT6Yu8G
	cCFmhKKXNFa/y76hX5uwgQn+PV2ytjQ2Buv4RdiDHurx0LTSZp3+If/1V84FVNFVM8aS+g94yYp9R
	xXq2iCHfw5HfsKtsBYzy1PVXh0Tq/9WSBULDfxRjhmCTM2lv9H19BP35QOXTzwIEKB1XPaAKqAdKg
	vKHke2r2WJVT326aBvybWXFNdHv3sCLdzY9sFbUz5hk873zVWHC7clFuZecWbDhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwdfk-0000000F14S-3HyQ;
	Thu, 11 Sep 2025 11:32:57 +0200
Message-ID: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:32:56 +0200
In-Reply-To: <20250810055136.897712-9-tiwei.bie@linux.dev> (sfid-20250810_075311_619208_642A3A1A)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-9-tiwei.bie@linux.dev>
	 (sfid-20250810_075311_619208_642A3A1A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> Add initial symmetric multi-processing (SMP) support to UML. With
> this support enabled, users can tell UML to start multiple virtual
> processors, each represented as a separate host thread.
>=20
> In UML, kthreads and normal threads (when running in kernel mode)
> can be scheduled and executed simultaneously on different virtual
> processors. However, the userspace code of normal threads still
> runs within their respective single-threaded stubs.
>=20
> That is, SMP support is currently available both within the kernel
> and across different processes, but still remains limited within
> threads of the same process in userspace.

Another thing that isn't covered is anything relating to interrupt
affinity, I guess? Is that automatically not working, or will it look
like you can change things but that not do anything?

I don't think it's important now (though eventually I would actually
like to have it for our simulations), but was just thinking about it.

johannes

