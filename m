Return-Path: <linux-kernel+bounces-871894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE03C0EC55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51FD24FE9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83A29346F;
	Mon, 27 Oct 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFJAbpKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAA2D0298;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576957; cv=none; b=UCb0LQYjcCSbgZMIcJCE8KUk7UqtMKJgAIxkwd3pLIYJIuXs/j/pnGKv35lWFfjvinw4qJqHH4J33yV3HTMQPIcKTJcJT5KC1Q/W/JnsP82JUtndSMbDeDglc2p4Kc0uMlVMW6KI53cNiTTOsQMMnUWrF4spzwiJ57Hby0iGOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576957; c=relaxed/simple;
	bh=zclksEatGwHyt87eluat+bMHeuNGX8hMCEVl2HYQYRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V+aHk2i7/qUlPsVN1Bmev0zgDQozQoDJcMQmFsXvryp4/fvVNyT7S/qdFJVEAa98ijUqueWgKM2msDowOPJZtEvmedf//IXWHMapsWghnDTYcwri6pedRaPifZoJDUXD0vCgWZELe4YoCt1AZP5AYpVEJQTkCjOUSCzGVqoOaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFJAbpKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 050B2C4CEF1;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576957;
	bh=zclksEatGwHyt87eluat+bMHeuNGX8hMCEVl2HYQYRw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TFJAbpKcPXez0kQyayz2t0tuXZN7B5LCg2THz44bR/CwdlWDkqZ3wf0TVun/pomPA
	 i4KK51pSyHlUFNKzz33hhZq3vNNTALOqPJ6r2vwC4V+iH44WOY5NiHysdliWqZ9mbg
	 K6evXxa/2TaOA+e3CfH0104y+m3bw45P8QnaaJLmiewfvOidHQ0FDM59lOj74N1I/O
	 /1kIoJLMjcqRnpgmuhqlXr9+mVK+3LC+YyyytaH+ALCcF7fpzGl7ySHTH0VvQmD15k
	 ygX5RXhei9y8ZOKB3Z5zIhSzDLGhVx+GH1yyS8KJKb79uoCX0bcBzKo1Pz/QaryUhA
	 VauXZ3TuignQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDECCF9E0;
	Mon, 27 Oct 2025 14:55:56 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH v7 0/4] stratix10: Add framework for asynchronous
 communication with SDM
Date: Mon, 27 Oct 2025 22:54:39 +0800
Message-Id: <20251027-sip_svc_upstream-v7-0-6e9ab26d7480@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCH/2gC/3XR227CMAwG4FdBuaaT45y52ntME0oTd0QalCWl2
 oR49wWYVKaWS1vy99vymRXKiQrbrM4s05hK6g+1MOsVCzt/+KAmxVozBFTABW9KOm7LGLanYxk
 y+X1DxkYbXCuFUKyOHTN16ftGvr3f60xfpyoPU3OXytDnn1vsyK/de4JEnCeMvIEGrAXluINO8
 Ff/OVD2L6Hfs6s24iQoviRgFTpPKkgVKhNngngQUC8Iograg/VSAUYSM0FOguawIMgqtCG6qME
 6MPMr1IOAS4KqghEYpQ91EYGPwvrvRwbsk0kXJFqHSkclZ9l6ynaw8OVRX7eXsTUdmNC2i9kO5
 ZPJYC112rYdSvqXfblcfgGkIewShAIAAA==
X-Change-ID: 20250131-sip_svc_upstream-e78d8c9b4335
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>, 
 Richard Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761576953; l=3856;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=zclksEatGwHyt87eluat+bMHeuNGX8hMCEVl2HYQYRw=;
 b=smEYJJCDj0JQALbvMbfpZU/6JQ0n0YV3AwHD9MrUifn60n55IJFzKqAmCIIiVCO/IXrxHcpCX
 kJiqLcD8086DfLB1Gx0Veze10+h3QYLpYb9iuRNMeFcM5TZqkKsxf/X
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
Changes in v7:
- Rebased to maintainers branch (svc_driver_for_v6.19).
- Fixed a minor logical check.
- Link to v6: https://lore.kernel.org/r/20250924-sip_svc_upstream-v6-0-c88ef68bf24e@altera.com

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
 include/linux/firmware/intel/stratix10-smc.h       |  77 +++
 .../linux/firmware/intel/stratix10-svc-client.h    |  92 +++
 4 files changed, 1046 insertions(+), 134 deletions(-)
---
base-commit: 6a6263c0ef0ffba7ac7fcf65556cc93d37ececae
change-id: 20250131-sip_svc_upstream-e78d8c9b4335

Best regards,
-- 
Mahesh Rao <mahesh.rao@altera.com>



