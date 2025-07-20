Return-Path: <linux-kernel+bounces-737966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BDBB0B2B1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B19E188531F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F322D790;
	Sat, 19 Jul 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok2WjRDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6D186295;
	Sat, 19 Jul 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752965456; cv=none; b=hLEDeLzKA/3LilImAPDNtV5XvzpcrJAI2vxfpgFY+kf/nbBHsU6O4K/Mq4jiYzvaxKPbV2hR69iO69ZyoBn1hIpiZdhX9IbqvYyOcI9e2jNSc8yrTMOqcKMr3bHdsQ6pb5G4bjiIqJGK3gfL0LEDspeKu5xCq8P8mBBRkwK3YDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752965456; c=relaxed/simple;
	bh=ZYMP+/at8nGFRJCVR5+BvgvHsIiIuVBydrFRDsPIMss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNE3xB5D9RjKRAs3ZTCCZMVIGBfVDaEJvIEfVZ+bebMBY4CDLFEiX/mpkWQigJVcoCngnZYEQ3xcgjFaoOADnI1nIxqeccz1MYiqIGbc0WGbvsQ/YWcpV9XSkDnnwBBO3s8ratospRAXGMWjkoMMLSXDZ1QssNfn1C66caYoYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok2WjRDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6846EC4CEE3;
	Sat, 19 Jul 2025 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752965455;
	bh=ZYMP+/at8nGFRJCVR5+BvgvHsIiIuVBydrFRDsPIMss=;
	h=From:To:Cc:Subject:Date:From;
	b=Ok2WjRDr+QGB1jQjfrugIls5aTrqQHkjS7lyzZ65TdJ4MrV8DbiZBEHQmA8OmQ1Oa
	 o8yqckVKebjjYHIFNLmtb3kBonjSv0/JjK9BZbpRz/uPPEwpLdwiFhyUfmuEgGiHKR
	 b74H9emRrel8I2MmAPD4QOO1FaPN/utaF5UgUKF9xt1OUi34PbVHo0KLZdFLtEAb0Q
	 S6IacJqHl60rBR59WhujNejWR99Q+PDyz6ab1GiMfVqUDuXDyEgbBYLe/DHpPQyO8V
	 BeAZtCZ8GzlBhPpC1dw6w2/S6MxVm5Bm8E07lDuTk6WsaTYGEic1ojhF3TMctSx0lw
	 lokyAVdf9JBsQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] Improve crc32c() performance on newer x86_64 CPUs
Date: Sat, 19 Jul 2025 15:49:36 -0700
Message-ID: <20250719224938.126512-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves crc32c() performance on lengths >= 512 bytes on
newer x86_64 CPUs by enabling the VPCLMULQDQ (vector carryless
multiplication) optimized CRC code.

This series targets crc-next.

Eric Biggers (2):
  lib/crc: x86: Reorganize crc-pclmul static_call initialization
  lib/crc: x86/crc32c: Enable VPCLMULQDQ optimization where beneficial

 lib/crc/x86/crc-pclmul-consts.h   | 47 +++++++++++++++++++++++++++++-
 lib/crc/x86/crc-pclmul-template.h | 31 +++++++++-----------
 lib/crc/x86/crc-t10dif.h          |  9 +++++-
 lib/crc/x86/crc32.h               | 48 +++++++++++++++++++++++++++++--
 lib/crc/x86/crc64.h               | 15 ++++++++--
 5 files changed, 127 insertions(+), 23 deletions(-)


base-commit: 9b0236f4efb889869f7d4f3f084f508cc0433ec9
-- 
2.50.1


