Return-Path: <linux-kernel+bounces-677838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A2AD20B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FA188A3C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7001F25B66E;
	Mon,  9 Jun 2025 14:16:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55872606;
	Mon,  9 Jun 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478598; cv=none; b=dlZgjs4Ul4ecPI5M8pyYXzYSMbFrSeZwboUzZlCihSiXsYbi5OICGvQmtp+iNMNJYv3HNqCIlSleHutfZrz9WFnk1bsVLUBpvP1J0+sgDdeZ/9aoNAEyCX0r3C93NVSeFC4dnYpT7u93nKYXwRTT50QKutzQn4E5V56Xoa1dBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478598; c=relaxed/simple;
	bh=u5CJGd9vHy4T1wz11wL77N5cGB075vD93+4oSRBDdUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JD6XcwkuHGxlJ89M120UVn2xnZpmXSdsNLPE9USJytGhv5cVG48dKSXp2d7WfjjS0WNsom+7q721St2Ns80ChzOv4iq8ImBN3RlhyYQKNmLMKWba/PMfn/kzwFKCcHmFqKBmGfpokM/BjM88nfi4bilbA9+FgcsTfvZvD58KxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EE3C150C;
	Mon,  9 Jun 2025 07:16:14 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A4B3F673;
	Mon,  9 Jun 2025 07:16:33 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v1 0/1] tpm_ffa_crb: handle tpm busy return code
Date: Mon,  9 Jun 2025 09:15:59 -0500
Message-ID: <20250609141600.3601340-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 can
support SPs that support multiple services.
If the TPM service is sharing the SP with another service,
it could get an error code of BUSY if the other service is
in process.
We need a way for the driver to retry sending the message
to the TPM service until it succeeds or we know that no forward progress
can be made.
This patch adds a parameterized variable (default 2000ms)
that indicates the maximum time to keep retrying for.

Prachotan Bathi (1):
  tpm_ffa_crb: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 24 deletions(-)

-- 
2.43.0


