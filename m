Return-Path: <linux-kernel+bounces-845442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A463DBC4F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DEC2347611
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E68253F3D;
	Wed,  8 Oct 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="jZIETUWJ"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FE246BB6;
	Wed,  8 Oct 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927658; cv=none; b=OAyLTtC0eS5KWDwMH8usVqF7mbtgEOkeJLtBpuAI5izchpay+AzOIdlz8PhcrCaKcWp7sBA1r1LLiDxQnKOvrVUgEO4JQ4WNmF/ekD1o9cRutpHg8ohBULbHcwRPRa0oUTj8i8qAH/c3rGrrRPJqhgyjVWiHj7nZOsGlx8eCtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927658; c=relaxed/simple;
	bh=2uY5NoijnwdLmleoPPRrn2yh0v/tr1KGjdpZ1mjviHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbtyzh0ELSteywkPPrBFvudCTGKl3hvyVU9Y2tpiUVBnThmZSva920b4SCstPWNq/CDEa6cd9VyHbqoSUNwlMNMP62rl/FUPFpG4e9MHqwguDcBQF09F+845MXC1o2u5CLQslxvacb0cFBMw8Hnxe+j/SWp6LrH7hI/TVK8tp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=jZIETUWJ; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 35F5880732;
	Wed, 08 Oct 2025 15:47:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LklD46OLveA0-D59SuP6u;
	Wed, 08 Oct 2025 15:47:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759927653;
	bh=2uY5NoijnwdLmleoPPRrn2yh0v/tr1KGjdpZ1mjviHk=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=jZIETUWJfKDZBha4rR9GU61rEsPoWRPnta/4npIBviypEjNMjfHwAtG2UCmdOVi91
	 Nh0XBjQafoKH2JbdN8iFqoHwDoAr2Zd4V3BH7YEEL5cSxf6d12TSqfXdUxlo9sjnJK
	 eM9hO3IRO2qqHBHcAQdLQsw38NhuKv1MwLbKWFYw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	lyude@redhat.com,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 4/4] remove completed task from nova-core task list
Date: Wed,  8 Oct 2025 15:46:19 +0300
Message-ID: <20251008124619.3160-5-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008124619.3160-1-work@onurozkan.dev>
References: <20251008124619.3160-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The task is completed in this series.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 Documentation/gpu/nova/core/todo.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index 0972cb905f7a..de70a857fcfd 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -210,14 +210,6 @@ capability, MSI API abstractions.

 | Complexity: Beginner

-XArray bindings [XARR]
-----------------------
-
-We need bindings for `xa_alloc`/`xa_alloc_cyclic` in order to generate the
-auxiliary device IDs.
-
-| Complexity: Intermediate
-
 Debugfs abstractions
 --------------------

--
2.51.0


