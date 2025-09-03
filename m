Return-Path: <linux-kernel+bounces-797726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EFB41487
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9B5E59B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B02D3752;
	Wed,  3 Sep 2025 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="LzXf+vph"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF120EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878520; cv=none; b=hceYZXK9NNX7smu7Fn6y2MwEzH4AzYR3zq8OiZi2zIXXrzG7/RbItdOQqEkXMYkFqXEaN9OwxHXkQIgIFJ6YXzj23rETFqBbokhfHRCTCxyG9lJSg7mPv5uX3wdXbhhmKKMgAQ+1hDyERMYi8R+xYwfOSnjNq6v0Nzfk05Chylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878520; c=relaxed/simple;
	bh=yZG/bW0eXoOlG6iW68C7uXoAceLhVQ0Dq4+ZBfZsCOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qh2N6pJlFxe0KQvGR5+7FCkEVzdFHi/40MqCuVBmvzy0l9SLcUqTkCbdYCxETDLnZ/oJZkI/T2qg3YSmncZe8blDjnN9Fv8r06n21ShShYF1c/RHeOlauo5TELHJB4+LPXkFZc0UaretSDeNr9lU/bANYjbBLGrF5MKgFR9ro20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=LzXf+vph; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k20.isilmar-4; t=1756878084;
	bh=yZG/bW0eXoOlG6iW68C7uXoAceLhVQ0Dq4+ZBfZsCOA=;
	h=Date:From:To:Cc:Subject:From;
	b=LzXf+vph3jGP83ELwUDUJjQWPGy7efqttH01nXjvNFxnOVpSYnEuOAmfgGmOkFHo8
	 gayAmM1UuXmIQsJy9z/l9DyShD/zsLyOBbVka+GZLCjKHFAMfblsjKb3UXQKVjlbey
	 5Zh86rL9zFwQm508aD9XFL9HNlLiezWeR08GZvlbklraZvxTTsevh7nF5UxeyUNF15
	 km4OhiewyBnGSKsAiCB5n8OABti0iflmhAp8KeWSDgP8F3DAvEDeSkJDbOoqSaL122
	 FibwlZkaX00OjtcY3J4SKJCgGHpWJQXPJsONE2XxadCR2cfzV3G0Gq8hegqj9bybqR
	 E5xFOIzoz03VA==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id D95E5200677;
	Wed,  3 Sep 2025 05:41:24 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id ED4A3A0096; Wed, 03 Sep 2025 07:34:04 +0200 (CEST)
Date: Wed, 3 Sep 2025 07:34:04 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCMCIA bugfixes and cleanups
Message-ID: <aLfTTBltkS0ONZlZ@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

a few PCMCIA changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.18

for you to fetch changes up to 4a81f78caa53e0633cf311ca1526377d9bff7479:

  pcmcia: Add error handling for add_interval() in do_validate_mem() (2025-08-16 15:49:58 +0200)

I know it's a bit early for 6.18 pull requests, but as there's not much going on with regard
to PCMCIA, I want to have this sent out already. And if you think it's -rc5 material as it's all
bugfixs and code removals (which sat in linux-next for a couple of weeks) anyway, I'm fine with
that as well.

Thanks,
	Dominik

----------------------------------------------------------------
PCMCIA fixes and cleanups for v6.18

A number of minor PCMCIA bugfixes and cleanups, including the removal of
unused code paths.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

----------------------------------------------------------------
Bagas Sanjaya (1):
      pcmcia: ds: Emphasize "really" epizeuxis

Chen Ni (1):
      pcmcia: omap: Add missing check for platform_get_resource

Dr. David Alan Gilbert (1):
      pcmcia: cs: Remove unused pcmcia_get_socket_by_nr

Geert Uytterhoeven (1):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch

Lukas Bulwahn (1):
      pcmcia: remove PCCARD_IODYN

Ma Ke (1):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()

Thorsten Blum (1):
      pcmcia: Use str_off_on() and str_yes_no() helpers

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

 drivers/pcmcia/Kconfig          |   3 ---
 drivers/pcmcia/Makefile         |   1 -
 drivers/pcmcia/cs.c             |  17 ----------------
 drivers/pcmcia/cs_internal.h    |   1 -
 drivers/pcmcia/ds.c             |   2 +-
 drivers/pcmcia/omap_cf.c        |  10 ++++++++-
 drivers/pcmcia/rsrc_iodyn.c     | 168 ------------------------------------------------------------------------------------------------------------------------------------------------------
 drivers/pcmcia/rsrc_nonstatic.c |   4 +++-
 drivers/pcmcia/socket_sysfs.c   |   5 +++--
 include/pcmcia/ss.h             |   8 +-------
 10 files changed, 17 insertions(+), 202 deletions(-)
 delete mode 100644 drivers/pcmcia/rsrc_iodyn.c

