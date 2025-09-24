Return-Path: <linux-kernel+bounces-830052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B711FB98930
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A560D189FE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FDD27FD62;
	Wed, 24 Sep 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+UYCs2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694C7262E;
	Wed, 24 Sep 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699618; cv=none; b=ZzfBzvQ1tNBFcC/FY9/8FrrTgXY9BapNw4J4Sciwj07nqxqgqcIk6TMznDJLeMCtGuCfmd6+RUpGKb3BfmXrtCCshicLDQCGTTHxm9JaPPpQ0DAJgW6TAKSjcXzMqSRoPmV5KKzaxD8Mxri6ikCQGqJxA/QQyXShAQ8rVgjmlTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699618; c=relaxed/simple;
	bh=4j5Z60miIUritTBwAC43ziQ5qBp207JaNHClURFLmr0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=feR6QwLYj8v5X6RFXjV0mCujEE+np3HkQXbRWd2Lpf/oFvI6rgn+WM3g9Eh9FD/GVb+h2L95Vyh4+45GQncnczqQrNGOcL7VAz4/ElvC+7K+gmm4kopXh266EIWw2YLWTxaIN3ARlJ3Q/V8ShSw6UeOIYSHJohIxlcM7Hju55Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+UYCs2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67395C4CEE7;
	Wed, 24 Sep 2025 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758699617;
	bh=4j5Z60miIUritTBwAC43ziQ5qBp207JaNHClURFLmr0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d+UYCs2fMOQ0Z3bmcsKsT60lTz9bH+sJXz0I19mDJL8PKvlyQloOtoC+TpY3ExLxq
	 r3U9vydj/1PPZewCAwYDiUsGMknPzjZ7Ixi65CbnDvUXFxTUAOdPq6yu9ihc0/LJ43
	 Q5iq2fSJAnKGCrctOoONYxj8RuwCCgKrI3lV+JRolvrFxE4s/jj8xFguVNrSNWLW/f
	 /xNApFZOGVplyPrRxFNX4xBOQJiAQzdhr7oC2OnYymhE+fUhTSW5TONuVwFC7NXIwn
	 dklKqPP9ktUKE0TSXs3DQb4stsvd5VQADv//U6k+PpT+8CrEImJq7zjb1ggmvqZFQY
	 cqLyBnqfQv/UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A8CAC5A7;
	Wed, 24 Sep 2025 07:40:17 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH RESEND v6 0/4] stratix10: Add framework for asynchronous
 communication with SDM
Date: Wed, 24 Sep 2025 15:39:49 +0800
Message-Id: <20250924-sip_svc_upstream-v6-0-c88ef68bf24e@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWg02gC/3XSy04DIRQG4FdpWJfmcIeuXNitC12apmGAsST2I
 kyJppl3F8cmHTPjEjjnOz+BK8ohxZDRenFFKZSY4+lYF3K5QG5vj28BR1/XiAIVQBjBOZ53ubj
 d5Zy7FOwBB6W9dqbhjAlU284ptPFzIF/R8+Zl8/SItr/7KXxc6oTudtjYHLA7HQ6xWy+KXBGFk
 +ND8T7m7pS+hliFDNVDAk7pNEEhGDBoDcIQAy0jD/a9C8muqj1ohd4FQeYEWoXWBuG4cJXxE4G
 NBCpnBFYFaUFbLoD6wCYCvwuSwIzAq9A4b7wEbUBNbyFGAp0TRBUUo55bV4MwOhaWtzdUoP/pN
 I5TbaiQXvDJbHmfbWDmFxT5k577RrWgXNP8mb3t+/4bAsaInWoCAAA=
X-Change-ID: 20250131-sip_svc_upstream-e78d8c9b4335
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>, 
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758699615; l=3653;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=4j5Z60miIUritTBwAC43ziQ5qBp207JaNHClURFLmr0=;
 b=Id/qQlsum6CL04Xk/8dUXTQLIinLbHqHfCJuQwewtLaPTUmGRYmcSwzJweDOlWpAgbCkEaifp
 IbffXNZnl2OAHlPF03O+ecnEvYu9KpgEr/dQWKok8rpElIUuSihwWhP
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

The patch set includes the following changes:

- Add protection for querying memory objects in multi-threaded flow.
- Add support to generate and maintain message id and client id for
  asynchronous communication with SDM.
- Add framework to communicate with Secure Device Manager (SDM)
  asynchronously by sending a request and polling for response.
- Add commands for performing Remote System Update (RSU) operations
  asynchronously.
- Migrate RSU driver to use the asynchronous communication framework.

---
- Link to v6: https://lore.kernel.org/r/20250901-sip_svc_upstream-v6-0-b4db7f07cbb2@altera.com

Changes in v6:
- Use guard() helper function for svc_mem_lock.
- Fixed comment message style according to kernel coding style.
- Added fixes tag to commit message.
- Removed id generation patch and use in house ida allocator.
- Changed lock of hashmap db lock from rcu to spinlock for better latency.

- Link to v5: https://lore.kernel.org/r/20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com

- Link to v5: https://lore.kernel.org/r/20250620-sip_svc_upstream-v5-0-732d4ac08a32@altera.com

Changes in v5:
- Use FIELD_PREP, FIELD_GET() and GENMASK() for bit
  manipulation for ids.
- Bring down probing when stratix10_svc_async_init()
  fails.
- Other minor fixes.

- Link to v4: https://lore.kernel.org/r/20250610-sip_svc_upstream-v4-0-bcd9d6089071@altera.com

Changes in v4:
- Added description for svc_mem_lock mutex.
- Wrapped commit message and comments in source
  code to kernel coding style as per coding style.
- Added minor code fixes.
- Moved variables to the top of the function
- Removed HWMON support from in the patch-set, this
  will be sent in a separate patch-set.
- Added support for RSU commands to asynchronously
  communicate with SDM.
- Migrated RSU driver to use the supported 
  asynchronous commands.

- Link to v3: https://lore.kernel.org/r/20250526-sip_svc_upstream-v3-0-6a08a4502de3@altera.com

Changes in v3:
- Changed "Stratix 10" to "Stratix10" in the commit
  message and in source code.
- Simplified stratix10_svc_add_async_client() by removing
  redundant code for async common channel initialization.
- Fixed resource cleanup on negative path in
  stratix10_svc_remove_async_client() and stratix10_svc_async_init().
- Removed optional interrupt handler support, will send the patches
  in a separate patch-set.

- Link to v2: https://lore.kernel.org/r/20250512-sip_svc_upstream-v2-0-fae5c45c059d@altera.com

Changes in v2:
- Added Reviewed by tag from Rob Herring for dt-binding
  patch.
- Resending the patch-set as there is no response from
  the maintainers for the previous patch submission.

- Link to v1: https://lore.kernel.org/r/20250422-sip_svc_upstream-v1-0-088059190f31@altera.com

---
Mahesh Rao (4):
      firmware: stratix10-svc: Add mutex in stratix10 memory management
      firmware: stratix10-svc: Add support for async communication
      firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
      firmware: stratix10-rsu: Migrate RSU driver to use stratix10 asynchronous framework.

 drivers/firmware/stratix10-rsu.c                   | 272 ++++----
 drivers/firmware/stratix10-svc.c                   | 739 ++++++++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       |  76 +++
 .../linux/firmware/intel/stratix10-svc-client.h    |  92 +++
 4 files changed, 1045 insertions(+), 134 deletions(-)
---
base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
change-id: 20250131-sip_svc_upstream-e78d8c9b4335

Best regards,
-- 
Mahesh Rao <mahesh.rao@altera.com>



