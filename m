Return-Path: <linux-kernel+bounces-894692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BBC4B9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FED3A28BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2D29ACF7;
	Tue, 11 Nov 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SbWyT8kn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF036242D90
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841359; cv=none; b=G9qppVIkmaGdesL8u7Q3zJxhqzJhQpVobBe7lri+jQvx4lacW3/jNcpVluZLf+zJnHZUdObj8m3oYoH63jiA8KSqkUBSg65QlfD9TWVagcO2VGhfcsK2xQNkPJcW21x+RKF175LdNyIGJd67NQHu8Yy0PMSl8YtMoMW0EHcTEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841359; c=relaxed/simple;
	bh=0794MkOE5b63wV8ngAkDG93egpvhWGoeEIDqLIZpQ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFM8b/T8Puo5LUuEJh9S3iE1wuEi0GNqpIsRHr/yk4c1GDQd1pJ6acfvFZO1zpJqpLNrsi01aZESJ8N4HwiXrYnq4b/+ysmlnrVE2MNvnVI6gjmbm39GFHGWIAkpnIOwjKt3f4pKGvMjRFcT3sutRLalW2oPqGa2wFCR64JLT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SbWyT8kn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PMcxZNEUscYbQoI/8aFEfvoW5j0WBCUVW2IFzxcGTQs=; b=SbWyT8knLDaV2s5Q3FJGumK4KC
	talk5Fvc7x5t2voIR65pu0h/3SvP3Vhn8OpiElG8XSTWm7KEh34EEzByW+dscHjuYJyLmDaGcGq9J
	vfF/Ial/wUueKaD10zTRqe7zV7QjdHm52u8cC2IdJXI69eGoEIqsZaiveLwF6RVAveRT3KqswC87J
	geEkRbQ4qi0z019JniNwPW6FWcqpW0+Y3KvL/yxyx/hZ2SrZSqP4M/xLomHAEzvRbxp6JPNqyug4i
	E36tnSo9tN1NAAi/hHW8npaLlyAmRhHRQEsUiFapfXKqfDn62ipleecNv/31hmjWIUBpHvuc1Vz3I
	AP3oorMQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIhZ7-00000006b0J-0blW;
	Tue, 11 Nov 2025 06:09:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] backlight: lp855x: fix lp855x.h kernel-doc warnings
Date: Mon, 10 Nov 2025 22:09:16 -0800
Message-ID: <20251111060916.1995920-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing struct short description and a missing leading " *" to
lp855x.h to avoid kernel-doc warnings:

Warning: include/linux/platform_data/lp855x.h:126 missing initial short
 description on line:
 * struct lp855x_platform_data
Warning: include/linux/platform_data/lp855x.h:131 bad line:
   Only valid when mode is PWM_BASED.

Fixes: 7be865ab8634 ("backlight: new backlight driver for LP855x devices")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 include/linux/platform_data/lp855x.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251107.orig/include/linux/platform_data/lp855x.h
+++ linux-next-20251107/include/linux/platform_data/lp855x.h
@@ -124,12 +124,12 @@ struct lp855x_rom_data {
 };
 
 /**
- * struct lp855x_platform_data
+ * struct lp855x_platform_data - lp855 platform-specific data
  * @name : Backlight driver name. If it is not defined, default name is set.
  * @device_control : value of DEVICE CONTROL register
  * @initial_brightness : initial value of backlight brightness
  * @period_ns : platform specific pwm period value. unit is nano.
-		Only valid when mode is PWM_BASED.
+ *		Only valid when mode is PWM_BASED.
  * @size_program : total size of lp855x_rom_data
  * @rom_data : list of new eeprom/eprom registers
  */

