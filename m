Return-Path: <linux-kernel+bounces-822317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC8B83851
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E431BC564E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9862F657C;
	Thu, 18 Sep 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kZo2iYno"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0F2E54D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184228; cv=none; b=H+v9/RrHWNp6JCCSko72oHddmZuPk5atXOWTr/XzJavZw/lfjUiPYoYCRAmxfkYwUEYg4GsTxApS5j4W8ndrQduJ8m9M3MdmyCKSsNd1ymnktBJ4DAexPnskdob4OQipESpsC60GLP1FJesoUrDbY9Ol58fpWQUNzhgtHAen8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184228; c=relaxed/simple;
	bh=t7pBvZawFHeE7XLP195lJ0dhuSUad5+dJ9QdZv1bNfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F61XICRjK5QeYRkaCnRpvmOY7TvV0jktZWmnLnVpdXUhZbnlDiLm7+H0noPhg9eeHvaj+p6OaNY37PeTb0eFtnkgQk0wnjd/8/1LCySeiZTLCS5JkDi872dFhFWR5BNIN2Ku2JmnzCK3LggYqabvFToT8KRjIEI5OVR7TQzX0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kZo2iYno; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/6bLOYTVutz7OZnWxHl9S+ZPChBSh4f/PGlIXbAKrEI=;
	t=1758184226; x=1759393826; b=kZo2iYno81eJQbIzPCjjMTW7fhBqsN6oopuQjEKdxumMb4N
	ENDl5qn+WdkLgnH0RC1pdVIweJSm030e3rXnDSJN4W1f9CEuu2R1yX7BJfoLnV0J1OlETAT5w+Kbq
	t2E+mL1tJQifcTxy3+Zw1Vz3aKvjyvWoWz+bOkNjCt7cUojXjw584H6VLF9VjqLltuxyp1sfYZfg2
	b3Sfo4rOkBsyi6ROQpowNXGTSo0lOZFy6F8Tqr0pc9l1otE6vX4GJ8tUqR7pKSnefwf5KS3eKwg/Y
	wuAchqFIajr0/E8+R1mrBBB5dQu3bfxUD68yS+CpcQZV7LMiXdn0ZekikWibSkcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzA22-0000000D9Ud-3eu7;
	Thu, 18 Sep 2025 10:30:23 +0200
Message-ID: <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 10:30:22 +0200
In-Reply-To: <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
	 <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
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

On Thu, 2025-09-18 at 16:39 +0900, Hajime Tazaki wrote:
> The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
> PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
> drivers over PCI devices (e.g., virtio-pci), the current nommu UML
> doesn't implement it.
>=20
> But without PCI drivers kunit complains as config for kunit
> (arch_uml.config) defines the dependency to PCI drivers.
>=20
> This commit fixes the issue of this compile failures when building PCI
> drivers with nommu UML.  In particular, the fix is to undefine the
> constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.

This doesn't make a lot of sense to me. Why would we even want to build
PCI on NOMMU-UML if PCI in general is dependent on MMU now?

It's not like ARCH=3Dum with PCI and NOMMU has any value even for testing
if such a configuration cannot exist in reality?

johannes

