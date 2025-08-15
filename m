Return-Path: <linux-kernel+bounces-771412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B8B286B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BA25E652A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74829C35F;
	Fri, 15 Aug 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="d9Itf7ek"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977B1FCF7C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287586; cv=none; b=KIh1IqdCtpXz+f37anS3JYJdzZPjfXyyNrkG6d1xjItKb93AvfSrwIlmlc69iUH2UowGH2KfYl/rWPmNHIM4CjO8GmpP0XCrSSt81j7AHNrjJxCl7+ihRZsTSObMQ5Dfv5BrF1bgeteOqRYmj4jQZ1v0DyTzFYB+GfVmKxHcwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287586; c=relaxed/simple;
	bh=+zChAHpfi3lHjY4gO3zWsfDescL+7k7+vqAaN7hvtFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIioW4erWD1SdPIVAJQK2BYXE3mM5sy8vvC0styXgSm3Tz2gB3WeFhXH0IKXHPIdS6UuUGD0s8S9o7oxsEGq9qH5I+B4KxuNhS8B8l8/P7LRoNrSV/X376uFs0tfZTD0w8iXaDKEdajOc3C6mTEYkDa6iynRjgrfC/BQtk309Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=d9Itf7ek; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250815191242789db59559600a88cf
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Aug 2025 21:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=USxneUXUzwvy4ONZPxHVb3S2bzpXkI+fylWBF3uXSu0=;
 b=d9Itf7ek6ywE5gLyhu19HYz7POAjVg0c5DgpH5ZK2Rgyyto70aGPqOvdZQuQgjT48aIwh+
 4FLWgMsQmwduOfWt/4efI5/sRW4aDoGjSoOj+HmSYyXE4K3jQj1/dc0Iv9qPvTTIvEi4Kxsb
 VHz5Mdg9tMr27JTpulCrmHNljPm1jzJ1lxZkA9FyvOmGqwLDlwM3y2VHSsnEDZsUEy3MAfC+
 beokb1IzJHTndjI5WbpXD3SEbfmaNpBcKhAqA55UiDPa15xRUIiyB7nOsW5LOgJkNTBpUO4o
 MvfExDCCo+4eRdxMSo8kDbF9VD/WyFF19OMyBbKtgAcJn80/NMjJerTg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 0/3] efi: stmm: Fix for incorrect buffer allocation and cleanups
Date: Fri, 15 Aug 2025 21:12:38 +0200
Message-ID: <cover.1755285161.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

One critical fix for the EFI StMM driver and two smaller cleanups.

I'm carefully optimistic that we will get better test coverage in the
future: I have a working RPMB model for QEMU, and this is where the
crash was found now and debugged in.

Jan

Jan Kiszka (3):
  efi: stmm: Fix incorrect buffer allocation method
  efi: stmm: Use EFI return code of setup_mm_hdr
  efi: stmm: Drop unneeded null pointer check

 drivers/firmware/efi/stmm/tee_stmm_efi.c | 59 ++++++++++++++----------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.43.0


