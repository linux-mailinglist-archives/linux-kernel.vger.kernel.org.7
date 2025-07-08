Return-Path: <linux-kernel+bounces-720892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C09AFC1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F6042128A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FA21ADB9;
	Tue,  8 Jul 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cko3B00D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B8214801;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751950196; cv=none; b=lckDpRYv4Iav/lkgkD2qttjVxN/HmBL2uMxkKKppjehwHXsb7DvcJJNN+ArL5P0MFbT7IsZOBhU4Ywsvf3HTNikFbipMqyStSgu0b6zSDQ43/s7u/3eb8ISnqF/dopWiLTdEm3Zgw9yTAMLOz9mZfW3kVqwOMOZcoPi1ydpRy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751950196; c=relaxed/simple;
	bh=9T7pJd+3AHclFZfFANxR31TEKOmHsUX4vkTKeaL5qUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dzMccQwfkoHOf4TAxMN7tXyE0sUhSbOUjX3WeUYYSI+lPJsyNQtsXE4ucaltLHWzt+6yC23JaO3ysh1xbEkm4F8WeDVV+nbQY6fqnv3A96ACaIpE6Y7sx9SkVUTOTG2gSwJKUm9l6Y6GaS4givRcg6YMDJ1DolVh8Sr4m/3t03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cko3B00D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A105FC4CEEF;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751950195;
	bh=9T7pJd+3AHclFZfFANxR31TEKOmHsUX4vkTKeaL5qUs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cko3B00DqynR9Rxk9/uHFXSwGZTUCa0kIw+SUwlYvW5fx9uT883vvTi0IuzxL7/Zi
	 ZTWWFXcJaZ907SXFhM7XhkJ+2iLouvXkzqH9aDhkc8VXrq415SNPzlAOre/JjZKvmp
	 av7fbmr0hrta/XJwzekNMRF+ZDlDDpkegOwHbTZpf3fZZtq9DwF/iuDGOtWHtV5dPE
	 Djb0XjGszCn86vbekNCVnLlpvN1q+V3FKWFt02P7aSuFLDWewZD142vYQiewOR2Q2x
	 lujUA/lvVnQBtafHmUrZbpUqWfX35q1/thD2Lz422G6jADTzxuCR5Yq+TAf6zrqe9A
	 qD6zrq7nIHb2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F08C83F0A;
	Tue,  8 Jul 2025 04:49:55 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH RESEND v5 0/5] stratix10: Add framework for asynchronous
 communication with SDM
Date: Tue, 08 Jul 2025 12:49:05 +0800
Message-Id: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGjbGgC/23PPW/DIBAG4L9iMZeIb+NMHZK1QztWVYThnCDVs
 QMOahX5vxfRSkllj8cdz713QxGCh4i21Q0FSD764ZwL+VQhezLnI2Dvco0YYZJQTnH04yEme7i
 OcQpgegy1dto2reBcovxtDND5r0K+o9f92/5lhz5+3wNcrnnD9NdsTQRsh77307ZKakMVDlaW4
 ZOP0xC+S6xEy3RJIBhbJkgUE0y0JrKhDek4fTafEwSzyXbRErsLkq4JLAudAWmFtJlxC4E/CEy
 tCDwLyhBthCTMAV8I4i4oSlYEkYXWusYpohtSL6+QDwJbE2QWas6cMDYH4eyfMM/zD+ZWYjruA
 QAA
X-Change-ID: 20250131-sip_svc_upstream-e78d8c9b4335
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751950193; l=3308;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=9T7pJd+3AHclFZfFANxR31TEKOmHsUX4vkTKeaL5qUs=;
 b=SLJzTjIhlr6Qh6T/Ov98WUWGv9QmmM+b+UzyGJzRbhgpyhfsLfOdlm9C8scGbR0Dds45Z6BIq
 oIrESjtMLxGC2QZ2kLgdwUtxu1Bq8QicWYzt5hC+ObJf6VzEY0zDe4k
X-Developer-Key: i=mahesh.rao@altera.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=
X-Endpoint-Received: by B4 Relay for mahesh.rao@altera.com/20250107 with
 auth_id=337
X-Original-From: Mahesh Rao <mahesh.rao@altera.com>
Reply-To: mahesh.rao@altera.com

The patch set includes the following changes:

- Add protection for querying memory objects in
  multi-threaded flow.
- Add support to generate and maintain message id
  and client id for asynchronous communication with SDM.
- Add framework to communicate with Secure Device
  Manager(SDM) asynchronously by sending a request
  and polling for response.
- Add commands for performing Remote System Update
  (RSU) operations asynchronously.
- Migrate RSU driver to use the asynchronous
  communication framework.

---
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
Mahesh Rao (5):
      firmware: stratix10-svc: Add mutex lock and unlock in stratix10 memory allocation/free
      firmware: stratix10-svc: Implement ID pool management for asynchronous operations
      firmware: stratix10-svc: Add initial support for asynchronous communication with Stratix10 service channel
      firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
      firmware: stratix10-rsu: Migrate RSU driver to use stratix10 asynchronous framework.

 drivers/firmware/stratix10-rsu.c                   | 272 +++---
 drivers/firmware/stratix10-svc.c                   | 954 ++++++++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       |  76 ++
 .../linux/firmware/intel/stratix10-svc-client.h    |  92 ++
 4 files changed, 1253 insertions(+), 141 deletions(-)
---
base-commit: 47633099a672fc7bfe604ef454e4f116e2c954b1
change-id: 20250131-sip_svc_upstream-e78d8c9b4335

Best regards,
-- 
Mahesh Rao <mahesh.rao@altera.com>



