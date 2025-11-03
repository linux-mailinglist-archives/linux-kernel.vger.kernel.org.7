Return-Path: <linux-kernel+bounces-883479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3CC2D8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5AE3A2558
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D123F294;
	Mon,  3 Nov 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ/rnIsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3941C72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192962; cv=none; b=ghlqACpLIGkpduMH85TNoH7QghstHAC4ah9rnCLvyfmwxGafihaJEao2d1CwMA9BbT8RMDskcmsVOWP6vqaqOamKbjjVMGimY9mxC+WY3EaLhTT/yqIT3xLPzxjl1f41JaEsk97L/0Ev8q1LEeGRyPNR1nbIK737ldQUy1LJZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192962; c=relaxed/simple;
	bh=eG5n+gndF8e0beK2oqNvA+G9a2E4qmKoofNCVIki7n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThgeNzqjUApnvdaKxLjFrMx9LfhApshJXtPoYcHQjCyti4x4Esn+CyacyOp3b7GBazQsTwMVzqQ5zG/+cGYGkmB2viJv7sy8Dyz/+ELySfEcG6YxoeubEjBNRItitJsaFhRI33BDVJNz62QDoNlsWYWu41oJU742w23S66jTQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ/rnIsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE5C4CEE7;
	Mon,  3 Nov 2025 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192961;
	bh=eG5n+gndF8e0beK2oqNvA+G9a2E4qmKoofNCVIki7n4=;
	h=From:To:Cc:Subject:Date:From;
	b=cJ/rnIsGFyt798HOUhwVpAhp5rwBCX7jIcMn8RxznG/cDU4jT+533agy4CoUEXWMC
	 qP8kyYGV4derqCSEXkw56mboX+61rvDl58m3aUTlbh6uu2rctWhg80uaIndVzvS7VL
	 jMRXtocc8Zn3SKwXsXOP2JWtD20jLWMCQyITPrqWpE9DsgEXVou0q20yjllsvZ56iX
	 VKe8wRq6PWssnv+WWmI9ZE5iVyx9KD8rbOUUCqalmWI7BzYqK8uO6EpcnpSkt6GyLx
	 sun/Jx3GFdow/+wsHZ/QQ6nYRsyE0Y6IM6srZ8nD+Vk2XLpjhc73omoji3gg7yn+z8
	 qP1hoheL45Zuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kho: misc fixes
Date: Mon,  3 Nov 2025 19:02:30 +0100
Message-ID: <20251103180235.71409-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series has a couple of misc fixes for KHO I discovered during code
review and testing.

The series is based on top of [0] which has another fix for the function
touched by patch 1. I spotted these two after sending the patch. If that
one needs a reroll, I can combine the three into a series.

[0] https://lore.kernel.org/linux-mm/20251103110159.8399-1-pratyush@kernel.org/

Pratyush Yadav (2):
  kho: fix unpreservation of higher-order vmalloc preservations
  kho: warn and exit when unpreserved page wasn't preserved

 kernel/kexec_handover.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
prerequisite-patch-id: fce7dcea45c85bac06a559d06f038e9c0cb38b17
-- 
2.47.3


