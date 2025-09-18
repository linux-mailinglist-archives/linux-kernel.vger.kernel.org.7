Return-Path: <linux-kernel+bounces-794621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7B1B3E461
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270BE481532
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D930211290;
	Mon,  1 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhg7D97e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8917B418;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732418; cv=none; b=imcVfLPmXovtIqJA8ZCbl3tnjoogw3zvZKC9pOP3mQmFXlbPdw5mq7kY2nIRSuzChvrFMSTySIrX3g8tkdkVudQoMXA9OBZDnbXRwdRhhPjnNDf0FOTT08ZgCKL8PwqBrxogIKKbkQNVxGJ7LL5aMTF+ZsiMCbvfrln5qSJp/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732418; c=relaxed/simple;
	bh=frSJ8z6OF+54546tm2d66zBCkU+yhVDJAZf07QWsMGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QsZ1NtppQr62Bj8XQ1n+hONdOhChfd2dMNA1qExj1ek4MhxJyY0d6dR/tf96OJJwS4r/XTQd6ylOehx6Ajjf8vED8endGVeZC7Ttad63x31h2A/kpiPdoCycoGSbeXml8ZAXMwi1Oz92AdHdaPxRTvHnAh4PEdUdUzdO1k1wTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhg7D97e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70F35C4CEF4;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732418;
	bh=frSJ8z6OF+54546tm2d66zBCkU+yhVDJAZf07QWsMGQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nhg7D97ebYSG5lhCCIPNZ/bBMAzT3wW5WXHi38U9i6ShI+NtYp6KtG72vYSQ6YZ2K
	 DCusdys8TrQfvOVoOJSb1AQf87iF4Kv6qOGkHUpbfIfTozSboCAUs41R3VphP0Xb9h
	 fy9XGunanbTvcLb773WU4/vKACo2D0lQAbUk4gdsuw0zBScRUUqmv9NDRQpXA9Nox3
	 ODYSyJV21CrRxrhPkMNB5oXNg6BUoGawJuuLZvttflLzg2Ra7PRYlJnlUbak2krRAO
	 wUlZvw8EeNQCZL1QWgL9S5F9whMhB/nzxOIQsIXVQK1Rj+I2WaoKhu/Is32ermSXNB
	 iDSa30jgApbDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E403CA1005;
	Mon,  1 Sep 2025 13:13:38 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH v6 0/4] stratix10: Add framework for asynchronous
 communication with SDM
Date: Mon, 01 Sep 2025 21:13:22 +0800
Message-Id: <20250901-sip_svc_upstream-v6-0-b4db7f07cbb2@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPObtWgC/3XR227DIAwG4FeJuC6VMYdAr/Ye01QRICvS2qSQR
 puqvPtYOqmZkl3+yP5sizvJIcWQyaG6kxTGmGN3KUHtKuJO9vIeaPQlEwSUwDijOfbHPLrjrc9
 DCvZMQ629dqYRnEtS2voU2vg5k69vj5zC9Vbk4fFIGpsDdd35HIdDNao9q2lygvwUn2IeuvQ1r
 zOyuXqeLBDXk0dGgYLWIA0z0HL2Yj+GkOy+2LM24lOQbEvAIrQ2SCekK4xfCXwhoNoQeBGUBW2
 FBPSBrwTxFBSDDUEUoXHeeAXaQL2+Qi4E3BJkEWqOXlhXFuG4FHa/f1eD/qfTOIHaoFReij+zp
 2n6BuDNVssgAgAA
X-Change-ID: 20250131-sip_svc_upstream-e78d8c9b4335
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>, 
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732415; l=3555;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=frSJ8z6OF+54546tm2d66zBCkU+yhVDJAZf07QWsMGQ=;
 b=oSv2fw+9JX0dRpMK7yM4DvEenPAZyqOQB495Ldz11o7rI0Dz0mB4wz4wRCnnmBfmirrzS4TFD
 +eNjUmSz3LFBGA+FRjGXrUMwvm8bEcKPZoT362giugbf1ZetIYujwVm
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



