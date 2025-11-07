Return-Path: <linux-kernel+bounces-890547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC759C404EB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC34F2A85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E2329390;
	Fri,  7 Nov 2025 14:23:26 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E431D387;
	Fri,  7 Nov 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525405; cv=none; b=HKrZGNDXChuMaORKTk2Hbg3HlpeZoSM9ULWzgqkH8dvFsX8w/dZB9ncBqIR1r6JiElJ27X1ixR0jFAPJuMPaLn7KqQvf3O03sapeUPK26wUhcUfESYfTFI8QLprXpKdnnMJNuUBtijHALfjY7PLdkMfolvBfcbkeFUT3ggpguuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525405; c=relaxed/simple;
	bh=URRMFGPJ0ht7XhnWem1k4UfPy6ir8o/fTASWXVVls9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egv+rCEQ1993gy/AwytBJu5mPRIht9wXWqHRk5UQyViZ0tKfJtbaVxuN79L3anjoHZ7Rjv2rgKA5ADFTiGuq/HxNIZvSTzzFTzoWJcf+UURiETyxyFh1phAv0J40Jam4W3L3wutSxZu7vm7rHTqltY03lOejfm6f3Y6pcgVULKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id E1D1C78373;
	Fri, 07 Nov 2025 15:17:05 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 0/3] media: pci: mgb4: Add support for GMSL1 and GMSL-coax modules
Date: Fri,  7 Nov 2025 15:16:45 +0100
Message-ID: <20251107141648.1889-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

This patches add support for two new mgb4 card modules - GMSL1 and
GMSL3-coax. The GMSL3-coax module is a variant of the already supported
GMSL3 module with a coaxial interface instead of a twisted-pair interface.
The GMSL1 module is completely new and requires a separate FW type as well.

Martin Tůma (3):
  media: pci: mgb4: Add support for GMSL1 modules
  pci: mgb4: Add support for GMSL3 coaxial module
  Documentation: admin-guide: media: mgb4: Add GMSL1 & GMSL3-coax
    modules info

 Documentation/admin-guide/media/mgb4.rst | 11 ++-
 drivers/media/pci/mgb4/mgb4_core.c       | 22 +++++-
 drivers/media/pci/mgb4/mgb4_core.h       | 16 ++--
 drivers/media/pci/mgb4/mgb4_sysfs.h      |  6 +-
 drivers/media/pci/mgb4/mgb4_sysfs_in.c   | 49 ++++++++++---
 drivers/media/pci/mgb4/mgb4_sysfs_out.c  | 38 ++++++++--
 drivers/media/pci/mgb4/mgb4_vin.c        | 93 +++++++++++++++++-------
 drivers/media/pci/mgb4/mgb4_vout.c       | 64 +++++++++++-----
 8 files changed, 221 insertions(+), 78 deletions(-)


base-commit: 1a31cb2782104969e48c7ce7e4fc06e403fcb5cf
-- 
2.51.0


