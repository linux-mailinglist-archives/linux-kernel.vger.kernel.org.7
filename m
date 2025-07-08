Return-Path: <linux-kernel+bounces-722025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C524AFD244
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CF016C43C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5F2E540B;
	Tue,  8 Jul 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvoO2R1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37E2DD5EF;
	Tue,  8 Jul 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992909; cv=none; b=JiKa1DIao6dt8uoIQFnFzljBGxDoCUnUlT2QpvXBxLusLzwsIBAJ6b6qmm0UqbOAnu8SToiuryq5KwO1qoHzmEa4Ra9P1rvEB1w+J+YGogRSTEwBTXNSDsb7+/TtZZMpL9WW+q0xSxIAKOJrD+1bAu7MCB81JuuhiHKlD+66T5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992909; c=relaxed/simple;
	bh=rdhMhDbDsUjX5hjIU+cPezj8rvV97MeHEnix0pjd8uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTDREB3LyO+hxg7o9UwKTumZp36nT3rkH8AnkGnjcdcWwppUItsLVuX9vNKw47uZllixNcbu7uz5nE8yqy2qcNHKRo/Dp6J2syNAobxpDUZObuhdqAJiO530ZliA7RuvBHQjd6ZewzVNQxJMR6/HFqrWraQv9uFUanp8VZtFo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvoO2R1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFA4C4CEF5;
	Tue,  8 Jul 2025 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992908;
	bh=rdhMhDbDsUjX5hjIU+cPezj8rvV97MeHEnix0pjd8uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvoO2R1ocwBu3BcUOR6JUthSRVHALJHP3DmQaDLCBk79STEH2VyJD0xBK2AJp5A/W
	 q0TwEC8ZFJW1veRmOMT33V5fUeqMARCvOa7aEm5nMtYvXF7reYMt7A8oEyhyU+doMe
	 wjqdG5W1wpSlo6A3fiqMzuz2NOSIjZsLkj1Ne5hl4PUvdbMNo1dKvrG2QMw+Lqjckd
	 aVS1vAhBB2SHXlYXXDQizdcFW1sxemkSydjJUhkzt4sHAESQ8Oj81Go54x2rI7axDJ
	 Oa8zJ++ewGd0tFPQ/+QctMy1zZCppeQ04Y0XUSqqm+38e9W+EEhCcgGwEQAg4Fnqch
	 VkFJXqFBOSyEw==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Yixun Lan <dlan@gentoo.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH] riscv: defconfig: spacemit: enable sdhci driver for K1 SoC
Date: Tue,  8 Jul 2025 17:41:28 +0100
Message-ID: <20250708-doily-concise-12620a7ceda5@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250708-02-k1-sdhci-defconfig-v1-1-73c631717338@gentoo.org>
References: <20250708-02-k1-sdhci-defconfig-v1-1-73c631717338@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=384; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=95Fz3TVw+WlzEnWMLxXYtXF67YYqJlPsPN4hDfqsBVY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBm5XtauXyYuEzncynLKUyByqX10zN6dH3uclv1p22kvZ 5T3eIlfRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZS/YuR4Wbz3XxHiZt531Yb WYif0l6e3rffy83n9Hylj09279E468rwv6ZmTvKRBStSOw/f71O0OlW+ITjkwgMVy9c5W3O7PTZ lsAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 08 Jul 2025 09:44:56 +0800, Yixun Lan wrote:
> Enable sdhci driver support for SpacemiT K1 SoC, so eMMC storage
> will be probed and activated, Tested on the Banana Pi BPI-F3 board.
> 
> 

Applied to riscv-config-for-next, thanks!

[1/1] riscv: defconfig: spacemit: enable sdhci driver for K1 SoC
      https://git.kernel.org/conor/c/0bb48ad676d5

Thanks,
Conor.

