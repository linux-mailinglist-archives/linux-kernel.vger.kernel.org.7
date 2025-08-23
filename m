Return-Path: <linux-kernel+bounces-783010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A5B32852
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2341C273CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463223ABB0;
	Sat, 23 Aug 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4WhYT9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911833DF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755948088; cv=none; b=c7yuZKGAsuz3SAYzBhTWCdWM4SRIQUfch051voS00oDRlVf1lkHNx54/ALcKIHQdTF7fkntWqAnoKqdZmo70uqTz/epNo5OGbo3pqckEyam6I0kWjKSuzizOE3RSSGbz0Hfa01A2WgFr5swLKQVCCd8OU0SqNf3A5NqPMPX8KuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755948088; c=relaxed/simple;
	bh=I6lZ4A4EqYO5YYGvuXgOpjACi6idh/NxTYnMNhQcPiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc; b=NWQixmbCMORCkVjXhG3vbqwSL5/G4gYlvX8VNJuVFZXirvmllvh1SxZM3Fo2UORVVf4ZrKTrvdCBmamrR5goolzJ8E1jRsQaeN/dOIbPSJWtgYnUY5i1MeWj1Iay/AHlrayiYaQ9iyjmxVmYTIW9Q+HZE4SNnIHMV4VajOB+VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4WhYT9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A9C4CEE7;
	Sat, 23 Aug 2025 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755948087;
	bh=I6lZ4A4EqYO5YYGvuXgOpjACi6idh/NxTYnMNhQcPiM=;
	h=Date:To:From:Subject:Cc:From;
	b=P4WhYT9LbFAJLjdXzzf5rrnIS/gddvgllo7qofUwHTk//D6bd0nQmZ9CcvdrWd3Rg
	 SOb10QzOyDydF1nX1+fjD+pSuiepNBjzKglOXqqFno+aSJmdV3Vf2I16UP8hlgeVuZ
	 bJYUSFML3PRCjz3j+P5K9xOIvtjBdNZ9g3B8lMMhfnCYkOCtsypxS2YlMm2CkMZNh0
	 YkwtlBINR0l3pkBARoX/4vNiGin7WCLSH5MF4tEK4kLJmbfgmhy6oinQhBs0Dd99lU
	 6R36gd55Ry9MnvaoFhJ4Xf8q1XAm5cbU4KaPPHRHMTS0UdPQA4pAtA9L1yd+vSTElZ
	 /R8PrSdbwbozQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 13:21:24 +0200
Message-Id: <DC9RN9QVWOSM.1RH74QYO0EI73@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: [GIT PULL] Driver core fixes for 6.17-rc3
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Christian Brauner"
 <brauner@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1

Hi Linus,

Please pull these driver-core fixes.

All commits have been in linux-next for a couple rounds.

No conflicts expected.

(You might receive a duplicate of commit ba6cc29351b1 ("debugfs: fix mount
options not being applied") from Christian, since it ended up to be picked =
into
both trees.)

- Danilo

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
 tags/driver-core-6.17-rc3

for you to fetch changes up to 3a68841d1d9b6eb32b2652bbb83acd17d5eb9135:

  Documentation: smooth the text flow in the security bug reporting process=
 (2025-08-17 12:23:30 +0200)

----------------------------------------------------------------
Driver core fixes for 6.16-rc3

  - Fix swapped handling of lru_gen and lru_gen_full debugfs files in
    vmscan.

  - Fix debugfs mount options (uid, gid, mode) being silently ignored.

  - Fix leak of devres action in the unwind path of Devres::new().

  - Documentation

    - Expand and fix documentation of (outdated) Device, DeviceContext
      and generic driver infrastructure.

    - Fix C header link of faux device abstractions.

    - Clarify expected interaction with the security team.

    - Smooth text flow in the security bug reporting process
      documentation.

----------------------------------------------------------------
Charalampos Mitrodimas (1):
      debugfs: fix mount options not being applied

Danilo Krummrich (5):
      mm/vmscan: fix inverted polarity in lru_gen_seq_show()
      device: rust: expand documentation for DeviceContext
      device: rust: expand documentation for Device
      driver: rust: expand documentation for driver infrastructure
      rust: devres: fix leaking call to devm_add_action()

Miguel Ojeda (1):
      rust: faux: fix C header link

Willy Tarreau (2):
      Documentation: clarify the expected collaboration with security bugs =
reporters
      Documentation: smooth the text flow in the security bug reporting pro=
cess

 Documentation/process/security-bugs.rst |  25 +++++++++-----
 fs/debugfs/inode.c                      |  11 +++++-
 mm/vmscan.c                             |   4 +--
 rust/kernel/device.rs                   | 208 ++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----=
---------
 rust/kernel/devres.rs                   |  27 ++++++++++-----
 rust/kernel/driver.rs                   |  89 ++++++++++++++++++++++++++++=
++++++++++++++++++--
 rust/kernel/faux.rs                     |   2 +-
 7 files changed, 318 insertions(+), 48 deletions(-)

