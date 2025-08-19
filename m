Return-Path: <linux-kernel+bounces-775096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2681B2BB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038444E0E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F13112B2;
	Tue, 19 Aug 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQuU/FZy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA881732;
	Tue, 19 Aug 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590110; cv=none; b=fDsZFgZlhojC+pPl/iKh2OcdtDz8D/CZlYFofYBdJKe9T9jA0OAVINwp73i1ECkEXBhNkQobK2xCCIuZ/M9w09CO+y8QHIti2Wr9CdHcsQaSKXT7Zd5HonaA71dBlWDIADkQq+OE+qfa4Dge10HzszA6BtUSb9UAxdFjEXxEaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590110; c=relaxed/simple;
	bh=xLuI9J3eKRbOgmyykghu0sMWbo+gDxFTq5myhbGOfLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoJkKY6bgAzGrkc4uSULHI2nFa41H4JTY1ofpP6kMta7t7PvyfwNWmlQ3cJi3uL2UPs34Rh5byRO/mYJ5bARcYUdbcZSP+c1njGBdEFx3bkV7o5q/uqQR1oF9q9Tjh00gEF8m/UTxtQDwqI30PqHD8uUDBpkz85zNZPzBl6ZWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KQuU/FZy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7Yq37uEARiaeWzVAuQ1673KP3G4WL0vAS2SoUZ9rgsc=; b=KQuU/FZydiS/sP1KorWl2dJriw
	n0UhmFRYGcF4Wecqrw4HMrzdCLsozhQy/ogCM/a8JQFMlWHmCykFZ4i8FigU3mUETlRYwYa1IhkEJ
	jWJrkzciCtH8k7yKMZM7HgPxR5RfLkCuo/aBsB11PFJ0B9lcn3qOBlXHD4JtrN6hMYVZ6H4vkOfEB
	p7CgqT93wbHBlbG2kdQiG8wDjPQjgn4goKebI6+YqbMft5qZ/8LQ/TU0tLueeeBFfkEglhhxN5ijR
	/GlEe6RYwpWbJGv2pXAwk8lXpmnJ6zcubUvpJnJYBnZE5atqHKD0/32r4BqKLHftRPrYzsLv0ObzD
	tTPIG2ow==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHBU-00000009jl3-1cD3;
	Tue, 19 Aug 2025 07:55:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] list.h: add missing kernel-doc for basic macros
Date: Tue, 19 Aug 2025 00:55:07 -0700
Message-ID: <20250819075507.113639-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc for the basic LIST_HEAD() and LIST_HEAD_INIT() macros has
been missing forever (i.e., since git). Add them for completeness.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/list.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20250814.orig/include/linux/list.h
+++ linux-next-20250814/include/linux/list.h
@@ -20,8 +20,16 @@
  * using the generic single-entry routines.
  */
 
+/**
+ * LIST_HEAD_INIT - initialize a &struct list_head's links to point to itself
+ * @name: name of the list_head
+ */
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
+/**
+ * LIST_HEAD - definition of a &struct list_head with initialization values
+ * @name: name of the list_head
+ */
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 

