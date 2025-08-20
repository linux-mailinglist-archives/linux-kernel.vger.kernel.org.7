Return-Path: <linux-kernel+bounces-777840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC61B2DE63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C78A3B147F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8791DE8B2;
	Wed, 20 Aug 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPZlA9WX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FB1C8633
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697847; cv=none; b=Y0DaCVK9O8CUuIgPliENiDvuNWWJA2TIBj2MLp3wDxiHnwl68kvjOfudZTxXWPMPRMRFcaFhtGQrLWKSulE4xS096ht7jDDEFLtx3y7V7lVibtFebH8SUrpMzxigKILQsf7HV6ypwD8RSYZx8fV84OKhmpNMqkSd6QsbwsNA390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697847; c=relaxed/simple;
	bh=b0/QUmQZTnjSI4FUdSDcu3Dgx7Wqh1oUkGTzTE0iZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEyAuq5bxhSNPYkB+y1O+pc0FExwXjJvIoLGAFphV0fUDHhaCMX/nn3eHVUT83lISjsGrZpyIN7+ffFN8bzovOqZwyUichhbCNOo+e5AyIG90rAx6Ie8uXvIzTulOJI9xG5bDxKz75rCqbnwlSek8Eq4Z4PEQyZSRpbNYJcQlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPZlA9WX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1773FC4CEEB;
	Wed, 20 Aug 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755697847;
	bh=b0/QUmQZTnjSI4FUdSDcu3Dgx7Wqh1oUkGTzTE0iZfU=;
	h=From:To:Cc:Subject:Date:From;
	b=mPZlA9WXyomVGQyisDdMv13WgrIwJlg4r+Xf7NpI6l9QOvum3unBrdbXfTq85nNoH
	 nvlzWzKOTrkUoXXu+NZRXmqYPRGrezXxaYQ4GSOG+63oeFO+kMdKt5nec8QB83oTbP
	 IjMlz4iYu6fwi6IEDtDs6joGc2ucyiqpHUWXrErZOEM7Tdffi7Nkk01+rNlAYOZpMt
	 3MZxn6C07APQXG47nkimwiZJoHXvD8tHNIYBJrP7YINACjoyquSF6WJaG+kzsaZ/+A
	 lD3q23k+fMI4lGhyp9fe3rAVQ/XHwPA6egqOsHHOunQ0P5cIp81TSt41a9bBtb2bMC
	 TZ/8rfotYLBuQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH -v1 0/2] x86/microcode: Add debugging glue
Date: Wed, 20 Aug 2025 15:50:41 +0200
Message-ID: <20250820135043.19048-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

ok, here's v1 with all review feedback incorporated.

I haven't added tags from previous review because they were to a conglomerate
diff and not to an actual patch.

Btw, the thing helped me already debug one small issue. So already bearing
fruits. :-)

Thx.



Changelog:
=========

v0
--

this is something I've been meaning to do for a long time: each time when
doing despicable things to the loader, I get to add debugging code too and run
it in a VM to see how those despicable things fare. But then I remove the
debugging glue again when cleaning up the despicable things and turning them
into proper patches.

So make this debugging code permanent but keep it out of reach from production
use and have it build- and boot-disabled  by default.


Borislav Petkov (AMD) (2):
  x86/microcode: Add microcode= cmdline parsing
  x86/microcode: Add microcode loader debugging functionality

 .../admin-guide/kernel-parameters.txt         | 14 ++-
 arch/x86/Kconfig                              | 16 +++-
 arch/x86/kernel/cpu/microcode/amd.c           | 88 ++++++++++++++-----
 arch/x86/kernel/cpu/microcode/core.c          | 51 +++++++++--
 arch/x86/kernel/cpu/microcode/internal.h      | 10 +++
 5 files changed, 148 insertions(+), 31 deletions(-)

-- 
2.51.0

