Return-Path: <linux-kernel+bounces-749012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505DB148DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4267A7AA56E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CF236A8B;
	Tue, 29 Jul 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RedLhj72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD0290F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772471; cv=none; b=ECnZk/8ZWVhGASNGOBRdIYABJUh5nLbDUSRa8drAzvPsNkHlkdd3c4EUDntmnRXXDTV45YKFV+CUzr3ukBa+v9EnFj+SRHBEEiAx54z2xSF3lb+E4jikmUQYW36nSV8eKhmcAR9moQBIqm7YEFOY6Cs4+rvhpMvn2Sf0i0B5iCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772471; c=relaxed/simple;
	bh=3tBTHRalWy/QO8wxn1gZNiMb5JUUhOUpuNqt8uMFEBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=daNX++xhJVQFv7+ItwVihFEZWpLCPAp5EuJB7lT0jSbzQemc2/BN47ECRux6tjm7LUycBiLqHgtp5J8rb/DmZR0D6uSJI4VpVM1tbbmEwj6wlbW3F0FMSw+e5Y1Gvj/32t8/HOkMebp1NP68Xv3Kd8oxrdhMFzYpqyIpAI836Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RedLhj72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E8DC4CEEF;
	Tue, 29 Jul 2025 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772471;
	bh=3tBTHRalWy/QO8wxn1gZNiMb5JUUhOUpuNqt8uMFEBk=;
	h=Date:From:To:Cc:Subject:From;
	b=RedLhj725kgdZ7cYaQmmAZp2ov428YNTXkrZ6G/0rl605w2lGyMVlPsROi4ODADyp
	 kKxV4uTWcyYU/ylcQd2vM31lPVPgxealiW2EXIxs3SoHcKBbNWF9zhEozhbK1IGuL7
	 RqcFfDcYY8961toiT0W+e+12IFpTO0Qp/dp4CQX5L8s/rMHqjt+yqtxhKlWir+WyRD
	 n3C6NE+LayZ+mD7UuqSuO1XTYDGefh5zirBe7ok9dXPbZwnsjcu4oEYB9sGTKB1JI6
	 NTUqDYazqVN7SW+PtmBDNawZN6TXCsyeKvrBywlGTc6gX35Icafo9VLTRH88wIBLol
	 M0U3vNZf3zDYg==
Date: Tue, 29 Jul 2025 09:01:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.17
Message-ID: <aIhxs-6YQFywxr5k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cleanups Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-07-29

   # HEAD: 7f2b41ac3f29f682cde113f1d0b4b43d261902fe x86/apic: Move apic_update_irq_cfg() call to apic_update_vector()

Miscellaneous x86 cleanups.

 Thanks,

	Ingo

------------------>
Neeraj Upadhyay (1):
      x86/apic: Move apic_update_irq_cfg() call to apic_update_vector()

Nikolay Borisov (1):
      x86/mm: Remove duplicated __PAGE_KERNEL(_EXEC) definitions


 arch/x86/include/asm/pgtable_types.h | 3 ---
 arch/x86/kernel/apic/vector.c        | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

