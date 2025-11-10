Return-Path: <linux-kernel+bounces-893405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A79C47495
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2ADA349946
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960113128BA;
	Mon, 10 Nov 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QhgRz4hN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322313C3F2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785831; cv=none; b=Pdjr4vK0atqVLYcfiEW0B+PKkR6QRtPePpKHtPEJP1tYGifocQXQUC2d+vYZxtHz89mqU0m4Qy03JWvQZTXx2lHN0xEldOI2FgqknwnLSaeLAETpmg9DoIxXrz39AFRRe3h7fIih39j3F1N8BfgLSCBBLwRoc0yCSgEn+ATyG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785831; c=relaxed/simple;
	bh=k2YSKwxVZGVxkOBrgPBD+1Fh3rvZlMKg92t9xqni42o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS2Up8IcklcSOlV4b0lGmulHvkRlgW+9B9ASNp0AKD00ro8kEcz7llDoPPAzuCOsMG4DBVAuqLlqDsiNqKpOEB4AkWwJs+Dyhmvi2iRJgLw6KTXeiAcf833a67l8noRrvgElFyRpvRxI2PSfXL6HRhcbpTxGmcVyLAmp9Jy87bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QhgRz4hN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762785828;
	bh=k2YSKwxVZGVxkOBrgPBD+1Fh3rvZlMKg92t9xqni42o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhgRz4hNY7mbc1S154Wx3KHAkOAPzFdHXrtxOl2AWZaAQ9+ad7BcbSQ/FaqP52rGh
	 Kp9CWy9ooGRGtWplc7SRIsWOnUw5/3twlKTjKwOD51PLKDA5lXUBHSLwKYLWyR2KsX
	 +dXNiogEPh3RTLb5RQlu8E1PY5MnbFfIvsyiZ+QierPMMgbbFBU9vpc5qL8/bhWaKY
	 N0+N8IrJszLOQLpTvvntKAkPcsp+hXa+g8+ofZi5rVizzjjKU2B81Kwv+42/cie9Zs
	 5WpuZvtyZqfDr9lhE/eCRJ0MWx5H9Dfhk1wklDyM8gc9zx0w+gcnONg2lO/CKiO2Oa
	 f5yG61In6ZF3w==
Received: from localhost.localdomain (unknown [92.206.121.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gerddie)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4289C17E130A;
	Mon, 10 Nov 2025 15:43:48 +0100 (CET)
From: gert.wollny@collabora.com
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] drm/etnaviv: Add support for running a PPU flop reset
Date: Mon, 10 Nov 2025 15:37:46 +0100
Message-ID: <20251110144625.18653-1-gert.wollny@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250630202703.13844-1-gert.wollny@collabora.com>
References: <20250630202703.13844-1-gert.wollny@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all, 

this is the fourth version of the series to add PPU flop reset. 

Changes w.r.t. the previous version are: 

  * Apply all changes suggested by Christian Gmeiner: 
   - replace "asm-generic/int-ll64.h" with "linux/types.h"
   - drop flop reset type enum since we only support one type here
   - move function return parameters on same line with function name
   - replace open coded for loop with memset32
   - add cnost to local static values
   - add a return value to etnaviv_flop_reset_ppu_init; handle and
     pass errors on to the caller
   - handle etnaviv_flop_reset_ppu_init return value
   - use dev_err for flop reset error message
   - fix include guard to be consistent with the other driver code
   - fix license header and formatting

  * run "checkpatch" and fix issues reported by it: 
   - don't initialize module parameter to zero
   - avoid multi-line string in warning message

Many thanks for any comments,
Gert

[PATCH v4 1/5] drm/etnaviv: Add command stream definitions required
[PATCH v4 2/5] drm/etnaviv: move some functions to a header to be
[PATCH v4 3/5] drm/etnaviv: Add a new function to emit a series of
[PATCH v4 4/5] drm/etnaviv: Add PPU flop reset
[PATCH v4 5/5] drm/etnaviv: Add module parameter to force PPU flop

