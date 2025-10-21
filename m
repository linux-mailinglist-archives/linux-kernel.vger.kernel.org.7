Return-Path: <linux-kernel+bounces-862986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B36BF6BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C74D50364C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CE334C38;
	Tue, 21 Oct 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Hm68QhlU"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9D32861B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052871; cv=none; b=krcpm6vC3bbrKN97+EZ8/fOfxSeR9o107sDys+SCVdEByuKFX1ArQ2XCocCtOkYPr2Ep++qgFu7vbDBoazsyKNcd5UWq2bv7jJhcDbaIqcLLQ0pTPTGgSlIrL8tRnxngqX44dwDTERa8DRk5JInMsPHTXJZn0myf756p4bS8iH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052871; c=relaxed/simple;
	bh=AkHBvluqEAhBVuY5qakHEhb8DpY+qUwXRRCxYI3Rcw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAuXgwygs40vc3ZQyjV3TIRG2AE9n8v6iJXGJ5cb2NRb9itExYBYsx4LjxUxx2pEcfAiJizuzXQBYRRuPjX5fUyq3HHlhoAGhbJ4QwrlZLKPxdRArwGeLpaTrWLP129wCkm12cLabN3fzDl5V21/32D56An+JgAe5avSeXOgwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Hm68QhlU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AkHBvluqEAhBVuY5qakHEhb8DpY+qUwXRRCxYI3Rcw4=;
	t=1761052869; x=1762262469; b=Hm68QhlUQmqCYF4BdTGukV1WQzvmoNT4JBx46IjxkBvCEXe
	9e4KNZscMTSR6bbep5sMICTqJGYKB0e+0io43h2hAgEkwaiUhtBqzjHeyJHrqlURREdhnaMw8cHmR
	TEXZcNQD+kLoEzU7n2YgHe2qTdc/PgrzqUYu0hXSucBog6147oBGLDAjK7rmz1ROdvWqwBdOHJCpw
	xzgySTWK0u7WyQGJp7W8GRjOF7T557Nlih9kQZcWnfrEfYo1TuDjszI8mlBTH1SK2rI/HUoTQQcQ2
	MdBrawPpDHppu6XT7L6kLV0xpyLsBxO46Sa5f1sA1sSSfTqbCjC+/sNNSwTsJaMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBCII-0000000BrDl-3dF6;
	Tue, 21 Oct 2025 15:20:55 +0200
Message-ID: <fc93795ff03dc767a800a18a6ef33ff778f13b5d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Tue, 21 Oct 2025 15:20:54 +0200
In-Reply-To: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
		 <20250922045020.48158-1-tiwei.bie@linux.dev>
		 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
		 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
		 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
		 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
		 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
		 (sfid-20250922_180452_263852_EC16D5FF) <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
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

On Mon, 2025-09-22 at 19:07 +0200, Johannes Berg wrote:
>=20
> I actually have half a patch somewhere that rejiggers the UM vDSO to be
> more like normal architectures, using lib/vdso/gettimeofday.c and making
> the build more regular etc. Maybe I should dig that up and try to make
> it work entirely - it was part of a previous attempt of adding the time-
> travel thing I mentioned.

So that patch is almost 5 years old and with all the VDSO rework since
then, there's no way I can make that work again right now ... I guess
it'd be better to start from scratch and make a real VDSO for UML.

I'll take a look at your cleanups though.

joahnnes

