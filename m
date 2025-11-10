Return-Path: <linux-kernel+bounces-892900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1872C46127
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF53B3A5897
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CB306B15;
	Mon, 10 Nov 2025 10:54:18 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BE305979;
	Mon, 10 Nov 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772058; cv=none; b=RemN1t757S8mq/8F5Zc5g81U3MxCuvgoStn9NN3GCksuqZAQMp0weigCKPsdzqIADDhSWcWdPWcgTELIQIiZgRzQbBN69lNlFk0mH/J7i71Qg/c+tl0w/20kUFuAE9fAkhkzrBAwfgAiOuJQeW3SeZSgic554FPJEb07jWklMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772058; c=relaxed/simple;
	bh=fkII+u2Xi1j9Pi9PhUZR+DtBkWafcMr/0eUNixqElOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKQnVVTlkzjVow1lakmhXSVoyXUGgFZ7tHCkViZrscg+jFz45BvarTX5RXC/7hGlwKSRFsahbf0Hdtp+UY0MnZhvs9UstfHVP4u3SRxceBfl02XTG3RrxLF6TgQY/BGuzFvoyRwV3eA0SyvKq8mDaB4T2m3W8ygpYKnJT7iApZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id D274D31B2C;
	Mon, 10 Nov 2025 11:54:06 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 0/3] media: pci: mgb4: Add support for GMSL1 and GMSL-coax modules
Date: Mon, 10 Nov 2025 11:53:54 +0100
Message-ID: <20251110105357.1813-1-tumic@gpxsee.org>
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

Changes from v1 to v2:
* Properly use NULL instead of 0.
* Fixed missing "media" prefix in patch #2.

Martin Tůma (3):
  media: pci: mgb4: Add support for GMSL1 modules
  media: pci: mgb4: Add support for GMSL3 coaxial modules
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


