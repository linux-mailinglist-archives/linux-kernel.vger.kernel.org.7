Return-Path: <linux-kernel+bounces-849206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EBBCF81B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C17DF4E2FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA8127E041;
	Sat, 11 Oct 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kyQAP5R0"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD223D7E8
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198787; cv=none; b=gmFa1JztCf+3VptDAyMkNdIxSTmh/mXfLyBHjqxWuOnymwJYe/YWaO0s6PsAE/hzCH1QzVhDghpcXC/K48kbX+cY6mkdBj0Gt3x5hKMhG6Be0sDvnnxlAKIzS1lSXVs+OLt9VvwkOqsXnysN9kesqffWEncfgei11v3z8821/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198787; c=relaxed/simple;
	bh=rN0VA7WHvWr95YTZl4jyj8/DRwg+FCiMIs7MsHjYVTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqXNKIo7QHcgEsJbaeG28KGISWKzWBGmMR5Wc085gNOki55qwOjPutH+ANngLtzykSQFA8WadvCCv/+NZmO0c6+ZTS9o8IvLi9Zw3GjltoXiH9QHMaIGGrG1IesKQs9iARPuvxuFAKGSgNVNfnQqQzN7OEL8UlDb/217u+UJi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kyQAP5R0; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C5EC0240027
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760198379; bh=075p0rTLucZmvaXWjrxbWoj/6tMybuSUrg/SEF8SJsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=kyQAP5R0kbWLcMvdLruOaii9pILTswu/sBUB4xQkPpSqFUcSJt4M80DCEJQeLqPMZ
	 typ1jEpTkjH8rFUI/VKPtBxWf6kLNnX+GaUQh7S9W+ArwoIGDwGGjvHowRyhhdnH2U
	 4kRsQccJhrJElhCC2a+V4GQnZKH8rVS4ihFpSAmi/P3U9juuvI+RzOVdifT0PNu0G6
	 zFpP9hI8bB8bx1LaYPnfhXLoM79uP1kbM648y8ifuRh+21krNDosZWaPG5Voa372st
	 d2KIzzw5TjioNFjvqL6V73gLrFJNlpk0xK3ygeswI4/iQ6uiq9YWkGR7gRqaqhgNwJ
	 AMtQmxQOKiV8w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ckSwq26Qfz6v1n;
	Sat, 11 Oct 2025 17:59:39 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 2/3] MAINTAINERS: Apply name and email address changes for Martin
Date: Sat, 11 Oct 2025 15:59:39 +0000
Message-ID: <20251011155903.7442-2-martink@posteo.de>
In-Reply-To: <20251011155903.7442-1-martink@posteo.de>
References: <20251011155903.7442-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update to new surname addition and currently used email address.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cb7a124f6e8..8740d6d04714 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11574,7 +11574,7 @@ T:	git git://linuxtv.org/media.git
 F:	drivers/media/i2c/hi556.c
 
 HYNIX HI846 SENSOR DRIVER
-M:	Martin Kepplinger <martin.kepplinger@puri.sm>
+M:	Martin Kepplinger-Novakovic <martink@posteo.de>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/hi846.c
@@ -15536,7 +15536,7 @@ F:	include/media/imx.h
 MEDIA DRIVERS FOR FREESCALE IMX7/8
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-M:	Martin Kepplinger <martin.kepplinger@puri.sm>
+M:	Martin Kepplinger-Novakovic <martink@posteo.de>
 R:	Purism Kernel Team <kernel@puri.sm>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-- 
2.47.3


