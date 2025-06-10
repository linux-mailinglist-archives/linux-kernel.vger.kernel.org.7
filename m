Return-Path: <linux-kernel+bounces-679917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88545AD3DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166FC3A4303
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB65239E91;
	Tue, 10 Jun 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovvHo31L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73673230BF5;
	Tue, 10 Jun 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569837; cv=none; b=ehHEVHxZ6QM+adWIYFGNi7F9OqUrJQo7/mfdphnCCDK3UnPyC4U6G1wLuwl5aaJlr+lUjFGsJB09i6KF+9pXSMC7peG0ZKt+ncPUzhBE1zZSJVrP5wAp/+qT3rWGrOownbKjMjLTJtI7t0mLqLBI7OJqcvDXLg8f2uAu/4ETwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569837; c=relaxed/simple;
	bh=BaMCopdFsyf97DgXqkRC4ITODJy4XrlKF7Fhset0d1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A+AsLeCNG3i0JnpEIf/1TtS88pSxb1i4DyZtp9TXo0wEiW0YX4NJnnPwWNIwsag3D2bM667udfXfuw58cTX1rdJUaM8xVM4NqKO1bXPZU8AjmbzlqEh+aGCBKWnkq0ghtA/btWZWbiKLDVu3F9BNmqOtXvFuSJ7Qy4GQ2ATJQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovvHo31L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C094C4CEF0;
	Tue, 10 Jun 2025 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749569837;
	bh=BaMCopdFsyf97DgXqkRC4ITODJy4XrlKF7Fhset0d1w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ovvHo31LihN3bqay3oxdNAZg8ziXGuJMFzBf/bDoJchcVuTQEBhFh0STNaRk1YMTz
	 BKChWJsjYzZ9da9D9wjke+9cVy7LuzEb9CZh8zp9htnrJBh/YjSMpW7OiqFmhZQdIL
	 0A30zqDIb3oJUgHuk9Sa+b4rUW7eWL7q6X+i3aPltNsu/ditrWKFJCMogt8+ZbDdyx
	 vSioFA6JPCIwrdosvm6OdaRb8GF+trwD2b1mMTZQPp8qihJIlOmjVfZXZ7JPLfN2Uk
	 oBGaRdsF5pYVZ3/4UHX2ZeB3b5T9FCqb6TgX4uC5hEmbVvYv2weSdcqikOFjywoMxd
	 Cpi/xnpk3+x2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA9C5B552;
	Tue, 10 Jun 2025 15:37:16 +0000 (UTC)
From: Mahesh Rao via B4 Relay <devnull+mahesh.rao.altera.com@kernel.org>
Subject: [PATCH v4 0/5] stratix10: Add framework for asynchronous
 communication with SDM
Date: Tue, 10 Jun 2025 23:37:07 +0800
Message-Id: <20250610-sip_svc_upstream-v4-0-bcd9d6089071@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNRSGgC/23PQW7DIBAF0KtYrEs0gHGwV71HVVkYxglSHbtAU
 KLIdy/BqtIqWf6R5v2ZGwnoHQbSVTfiMbng5lMO9VtFzFGfDkidzZlw4BKYYDS4pQ/J9OclRI9
 6orhXVpl2qIWQJK8tHkd3KeTH55Y9fp+zHLfhA+6qjYWWhtmMy0H3v/zkgqHDYOw47DUAV10Sd
 33QAamZp8nFrkrNjklyLzm6EGd/LW8kVloKXXP+fHFiFCgoBbJlLYyCveuviF7vslu0xB+CZK8
 EnoVRozS1NJmxT4L4I/DmhSCy0GhQupbALYp/wrquP8yoZ62aAQAA
X-Change-ID: 20250131-sip_svc_upstream-e78d8c9b4335
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749569835; l=3196;
 i=mahesh.rao@altera.com; s=20250107; h=from:subject:message-id;
 bh=BaMCopdFsyf97DgXqkRC4ITODJy4XrlKF7Fhset0d1w=;
 b=Dg/uJSgebPZk7zffIlpCTxoQsG5cXKLK/GheSOMKIUb21q96Avuu9QQCzZGYCgaLJm9h2nnhQ
 iyZFxStkiDaA2s/gNv2nN+6pR8tFZCR4s6g37iIB8VBfjf0NQy2vkX9
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
 drivers/firmware/stratix10-svc.c                   | 934 ++++++++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       |  76 ++
 .../linux/firmware/intel/stratix10-svc-client.h    |  92 ++
 4 files changed, 1234 insertions(+), 140 deletions(-)
---
base-commit: 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
change-id: 20250131-sip_svc_upstream-e78d8c9b4335
prerequisite-change-id: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028:v3
prerequisite-patch-id: 6a4223bd2c01a0fd20925e597c906dc64e11ec2f
prerequisite-patch-id: 33ca4dbe8b8e18d3e51145c6bcaae55170878b22
prerequisite-patch-id: a02bca91874f4405191e60704574a0c99f37d184

Best regards,
-- 
Mahesh Rao <mahesh.rao@altera.com>



