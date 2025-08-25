Return-Path: <linux-kernel+bounces-785158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393AFB346BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE20F2A42C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2E3009F6;
	Mon, 25 Aug 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="MvBwvLfA"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11A2FF654
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138046; cv=none; b=QlH1Kzu+XoSBkH4KOgjqY9GJcoRXf5OUHOPymAp2gnOpPC4nhH767ExIusGtNxNTDVdk7Ow4wuDuuuqE9Xe2cIYcrZ0Ntec+GT7nv2ke1AScqilI5KYxBIbHGGRyhLTN/OWHlVk6uy9i5kAMfJ9ElWXis/lNByHH0m9I6rOarsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138046; c=relaxed/simple;
	bh=2Dd39Z5VLNV8NHl8byVSZhxo6MEB4pLX7stKC85GgiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdWru1/kFNVnJFg3Wx29iwZq00DEV2FE7Bx84g2euYmTDK2NogsWkQDGuM+qNLL4bGVkQWoQKKSJnCsylP0RE4ZnMkfros2xRrquz2g2i9VDHwVRs5tOcSa7ZHgmUumCVSl+v8KGGqrK8Fb2EIyFZ94SYJc8dg4ZDaWxrk5fXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=MvBwvLfA; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250825160713ef9a24118c7902d4fb
        for <linux-kernel@vger.kernel.org>;
        Mon, 25 Aug 2025 18:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=op8QEMoJkTGO/bD4ByGq2ruh0tz1u/z+bRtk06GRpeg=;
 b=MvBwvLfAFzh1802zqugSzurNxZbE7JP9ga9wMgjMx5UaC2AEq9Lg5EtAl75/dWUDIbWZXQ
 nCl6aSqYL2R8hFw9T0xYOO1PYthHjUkVmqDbDsWp94JmGyEX8IuggLMh0WywbsE4Tj3ZVh4l
 TmNzfNbZnJk+/Xw9Gd3vuodvz/BtlSx6b4kFAZw7BInB2iRQxRoM07iV7ryFwEXly8xGwHym
 ooC2MHVPJayc/WzExcjkYofOp05+Yo3q6HeWpmskCZ1BDkDgyiK9n4D4yJrUpZXZm/PQjABW
 JcASNFjUV9u34uhsOm2hE3FosFobbi3QdvgCJAla2YIA1hZxOv+sDDhg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v3 0/4] efi: stmm: Fix for incorrect buffer allocation and cleanups
Date: Mon, 25 Aug 2025 18:07:09 +0200
Message-ID: <cover.1756138033.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v3:
 - improve description of patch 3

Changes in v2:
 - simplify page allocation approach
 - switch to returning EFI_DEVICE_ERROR on ENOMEM
 - drop efi return value argument from setup_mm_hdr

One critical fix for the EFI StMM driver, one error return code
adjustment and two smaller cleanups.

Note that the suggestion to convert tee_shm_register_kernel_buf to take
pages instead of buffer addresses is not forgotten, just in the backlog.
I wanted to avoid that the critical fix has to wait for me finding time
to refactor the API as well.

Jan

Jan Kiszka (4):
  efi: stmm: Fix incorrect buffer allocation method
  efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
  efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
  efi: stmm: Drop unneeded null pointer check

 drivers/firmware/efi/stmm/tee_stmm_efi.c | 61 +++++++++++-------------
 1 file changed, 27 insertions(+), 34 deletions(-)

-- 
2.43.0


