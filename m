Return-Path: <linux-kernel+bounces-787506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5126B37742
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C594D1BA1CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5A1DF996;
	Wed, 27 Aug 2025 01:42:21 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEB190692
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258940; cv=none; b=vCxFc8SbFfOC0uz0ZUXIw1K4ZQubbIN+nPJQ677EZdscpy6HDK3KLBpCKK5TUylQmiEl7EtDE7uFls9xXukow6NxhlmUuqDZUNnYJrvRoJji7vexJJCsZlMqnDFWIz5ctDn2e14ARUOntA/IeL0GNne8qPq8ChAu5Pz4ySG7Jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258940; c=relaxed/simple;
	bh=dEZekCrgd4STm8puZQgXLkMhwyFiTvq9Pm2H0BifID4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhkn/iHIIyxODRcnSaO+xy06ax/PXLBtvzJkTDPK3YbTVwpsGIRyuwSQrcAyTi8KFp5zLUGsVHqgfYE39ixPSprScC/SMBT+HG0VPaG7iHyRZhAYbDQwRTraOsFnSxcTaA/t3D6DOQaSIwnZ2umGAQW8zcNPnQXW2G4ZJyh2afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [101.12.130.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 8D7E032DEF;
	Wed, 27 Aug 2025 09:41:57 +0800 (CST)
From: Bill Tsui <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bill Tsui <b10902118@ntu.edu.tw>
Subject: [PATCH v2 0/3] ARM/arm64: ptrace: fix unaligned hardware breakpoint validation for 32bit
Date: Wed, 27 Aug 2025 09:41:10 +0800
Message-Id: <20250827014113.5852-1-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824124317.390795-1-b10902118@ntu.edu.tw>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed author name. No code change.

Bill Tsui (3):
  arm64: ptrace: fix hw_break_set() by setting addr and ctrl together
  arm64: ptrace: minimize default bp_len for hw breakpoints to pass
    check
  ARM: ptrace: minimize default bp_len for hw breakpoints to pass check

 arch/arm/kernel/ptrace.c   | 16 ++++++++++++-
 arch/arm64/kernel/ptrace.c | 49 ++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.50.1


