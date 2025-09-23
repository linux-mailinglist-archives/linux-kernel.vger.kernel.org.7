Return-Path: <linux-kernel+bounces-829399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034BB96F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92B919C5E81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD96265292;
	Tue, 23 Sep 2025 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tDJzBCbO"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EF2AF00
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647641; cv=none; b=R3R8L7PHZcdEm52TwfNXxI5XJWwbz81XQHxjHjlbatkzRVfIfRxN5rnuACLC3jkg2KZmHx190PwPw5A8WR/QEQERTKo6Jlax8aYygvmVFaRvrtmqw0HwMTI1VWb4NB2gZigPyLqlxJr9SrAcwPgNOGVRZdRUMPeAsaTquZLHRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647641; c=relaxed/simple;
	bh=5qXhkfgq5KWFqQHTaSZbilHlLFvR/X4je7D5Hm/lyaE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akOIz8hDh2IZjKX6ZJ7zqGhVzuqx8hZHTflJm9uEcI0i5IjSDHpZftcIbK8lsmeAeWy4z68OrDvBtpukQHbislwCbPGAG8TQGb6ePo8cJUbIq8y1KE2llBCMYwmAB2puR1kkd8M3B675n/QjxmbBSz1GHPQZg8NHa+6BDEdx3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tDJzBCbO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vjZeveKFzDPAEd4GCEqvLjhW0pC9krDO5tPa8N+ao6c=;
	t=1758647639; x=1759857239; b=tDJzBCbOYpn1g1ZJPhBQRulJAZnIr5zCUWRH6ngGo2jCZFi
	IzqJRVzRTHJg3VnboN5/likzt5c5UzO9/TmA0GXPp5TZmH+oBLFfMeL7IiqQnBFvSE7IyuGm9NWlX
	xcYNrk4I4ysduheBnnzzfGHj8U+GPM0WtxraLezrUeFEftHW2lyYgbr+fb+rrUigETmWjAvQ2Nytv
	gmzvGq0wcpnyLpHb/yNGv6XyLh8vw7+PTKCyBlkR4mqPs1pwryRi4gr36/vW9nBSXfwaubMwN8f9e
	qJCzgPv7BEOan55QLI3IxmuoE4OqUiu6Tr1n+ln5i1eHNOOp0EeF8LT3Og0av23g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v16aK-00000006pCz-1JN8;
	Tue, 23 Sep 2025 19:13:48 +0200
Message-ID: <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>
Date: Tue, 23 Sep 2025 19:13:47 +0200
In-Reply-To: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com> (sfid-20250923_174311_655140_04935269)
References: <cover.1758181109.git.thehajime@gmail.com>
	 <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	 <m28qib8g1r.wl-thehajime@gmail.com>
	 <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	 <m27bxu949d.wl-thehajime@gmail.com>
	 <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	 (sfid-20250923_174311_655140_04935269)
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

On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> >=20
> > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > so we cannot select it when CONFIG_MMU=3Dn.
>=20
> That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> dependency, perhaps it should be reverted, iff you are willing to take
> care of the casual breakage?

Why though? UML with PCI can't really be a functional thing, only a
testing thing, and testing PCI on !MMU when that is actually impossible
in non-simulation is pointless?

johannes

