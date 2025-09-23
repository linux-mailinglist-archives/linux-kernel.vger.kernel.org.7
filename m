Return-Path: <linux-kernel+bounces-829136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C845FB965CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2552E2648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1122652AF;
	Tue, 23 Sep 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMrZy223"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA013B5AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638397; cv=none; b=CA4izYEFrfgkByzXvP0Ph+0mkhNdKRk3Z1ZMeDX5ARvc9t8x2vcco6A26mAqFHLsYqoS/2V/3GE1HzVw0Zt7vV7dV+3FHP/GY7DKfPv5M6fuiR5AXL/Joitqr7mJ0ypptet/G5DkMQkWuUI742YUoRNNQ0J9zS/YPU5FjmhVVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638397; c=relaxed/simple;
	bh=ifOqpq6EI5oUKKyRISwbxG5xRCmiQg5s1ikEzZQUYQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOp13TLD8mA58AgXTgzdBVHWcRkHz7AEVejWOCnAWkX7xlr/oFaw0JVZluzjgzFsHa0NhJa/ey4cyq3poSTAxacwhQ5gbmG1YY2HjoOw5NXViCI5edwsWX3884cFC3haFN5iPIo7WxigBPCkOnvcm4HN2Bt6kc110/96Oza9O8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMrZy223; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSSrqefXj8F1pFE7kwL8lKNSLHc0UQvp/2g3qfW9jDk=;
	b=fMrZy2232IukmdHqpK6jAa0jncEUUctbBlD+MUrJbfx3Z7SCF/ueBMcI0dc/Dm8Nwl4nwC
	B3YdTFezd+R+V8CtIGON/XgNJ+vJiNgGKYnBMvvDwTaLw1BcZ0T4sNu+DUYQTrhnB+zNok
	JuGMk6orsCmgsAsm1a2hsaTChxNZzsk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-_7Z9GmUGM0aCdJEA3AK4Ww-1; Tue, 23 Sep 2025 10:39:53 -0400
X-MC-Unique: _7Z9GmUGM0aCdJEA3AK4Ww-1
X-Mimecast-MFC-AGG-ID: _7Z9GmUGM0aCdJEA3AK4Ww_1758638392
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-846f089463eso560098185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638392; x=1759243192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSSrqefXj8F1pFE7kwL8lKNSLHc0UQvp/2g3qfW9jDk=;
        b=g/VqxOPLMOQ9/WrDkUhMlIzRnKa04jbtgp7V2diHzV7P84CPKQnVKaKBtDHWoPa085
         A9A6zEg/FmqH45PsGRdca0ZpFi06xONra3SfJuH7Cq3PnG51RgN3IQreotsQ0RYVJvyh
         vDciJan0cDf541eSGZk78MbR7a0ixFJ8Co/JQffPJpif4KtlMrnSatr/5xd0dOePqCqD
         ikTztI+DrGZS7ks+h8N7fNopVhEKPJmwQP6A00TplBeWi1OG/eMb669kRsSd7hi2pQ92
         thgQHuZ938BqRbpIlS+vW62lmrMBuMKe2+TY8Rr3qZoWREGRndDoPJuel5to4EJZl1bu
         2xWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqF+JRYBPSpcE6Q6gVjWQFh+XpqJYwibpHOlvKpWLcSJMbrHV58EOS2TbqLtzSQHpF0QLeYZ5BSrOnFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iDYRSQpWg1Ip6K0WJdXfDqkDv7IqqWo4Jz05I5vEjAnf3/df
	WF0nsHWaenj++UyQlxDxxZsiI4UTufHM5+w2a+nUDWO+x6C8T/0dmS3qRiBrztpXWLdrVtAKQhx
	YqdRW6ETSqFL99jGhZh6EOSJU+tfHY8Is9Z+req5gnzFqil+t66cRJuvhwSIxn77ihA==
X-Gm-Gg: ASbGncuX7qC9veL5hk+S1n0/9JQebIFM+hE5OL/rNOnm2noLSIwlYcLqUtdY+HSXRJv
	jaRoFAXCjmJiJZs8cQsPydWpHRxyErI7j9c6nZQCQGH0a5gSSUvDagWBSNR6ZdMEBTyrd5iXuKp
	J5nJ0dc3/j3hGiR52D93nClLspQm1DnqW3iZ1VsjjBZU8BErp6yltV3bfX/Eh6Qx/YHncateonW
	HkDxIdpkXZ2fTU6o3wmMebk6z5yj2JYi55hQgTPwLDqXWJkgTzHYGAWbOOe/m/wEF5hRSyr5DiE
	fYGT7fTzwOhwqBqkP3KzeifDu0MGp/s+lA84HJJaybMvtN8Q8zrww/ZFCi4oDJlljLoHepv1km9
	QZIM4941abSNpz5lTslE6ZxJ5FmzUN4Icn6zTG6c=
X-Received: by 2002:a05:620a:bd4:b0:84d:5320:287d with SMTP id af79cd13be357-8516fb9021amr294261385a.34.1758638392274;
        Tue, 23 Sep 2025 07:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKBUZpAD3XPLNDp4LkeiD173qMrCb+kitUiyWzyeQr+nw9KW/OanK+ID3iaqXtbBXsBu95YQ==
X-Received: by 2002:a05:620a:bd4:b0:84d:5320:287d with SMTP id af79cd13be357-8516fb9021amr294256985a.34.1758638391633;
        Tue, 23 Sep 2025 07:39:51 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:39:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:20 -0400
Subject: [PATCH RFC v4 01/12] clk: add kernel docs for struct clk_core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-1-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4554; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=ifOqpq6EI5oUKKyRISwbxG5xRCmiQg5s1ikEzZQUYQ0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubdRLzFhYrFgxd9+rLaksV/NSTSxflO5nTtuR8Kr0y
 X6vdw/lO0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZiIVR/DP62oW8vcIjxeCbEE
 Vjy8V5daO3HbGsEHUn5GP7geMpXlfGf4p71hXdWcU3feNPyaHqX5Z9Onpy9vxdz8L7TI5bdM6Jw
 5E3gA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Document all of the members of struct clk_core.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..018dd5a32ecbf166718da3eda851f51fdfdd2088 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -57,6 +57,64 @@ struct clk_parent_map {
 	int			index;
 };
 
+/**
+ * struct clk_core - This structure represents the internal state of a clk
+ * within the kernel's clock tree. Drivers do not interact with this structure
+ * directly. The clk_core is manipulated by the framework to manage clock
+ * operations, parent/child relationships, rate, and other properties.
+ *
+ * @name:              Unique name of the clk for identification.
+ * @ops:               Pointer to hardware-specific operations for this clk.
+ * @hw:                Pointer for traversing from a struct clk to its
+ *                     corresponding hardware-specific structure.
+ * @owner:             Kernel module owning this clk (for reference counting).
+ * @dev:               Device associated with this clk (optional)
+ * @rpm_node:          Node for runtime power management list management.
+ * @of_node:           Device tree node associated with this clk (if applicable)
+ * @parent:            Pointer to the current parent in the clock tree.
+ * @parents:           Array of possible parents (for muxes/selectable parents).
+ * @num_parents:       Number of possible parents
+ * @new_parent_index:  Index of the new parent during parent change. This is
+ *                     also used when a clk's rate is changed.
+ * @rate:              Current clock rate (Hz). This is effectively a cached
+ *                     value of what the hardware has been programmed with. It's
+ *                     initialized by reading the value at boot time, and will
+ *                     be updated every time an operation affects the rate.
+ *                     Clocks with the CLK_GET_RATE_NOCACHE flag should not use
+ *                     this value, as its rate is expected to change behind the
+ *                     kernel's back (because the firmware might change it, for
+ *                     example). Also, if the clock is orphan, it's set to 0
+ *                     and updated when (and if) its parent is later loaded, so
+ *                     its content is only ever valid if clk_core->orphan is
+ *                     false.
+ * @req_rate:          The last rate requested by a call to clk_set_rate. It's
+ *                     initialized to clk_core->rate. It's also updated to
+ *                     clk_core->rate every time the clock is reparented, and
+ *                     when we're doing the orphan -> !orphan transition.
+ * @new_rate:          New rate to be set during a rate change operation.
+ * @new_parent:        Pointer to new parent during parent change. This is also
+ *                     used when a clk's rate is changed.
+ * @new_child:         Pointer to new child during reparenting. This is also
+ *                     used when a clk's rate is changed.
+ * @flags:             Clock property and capability flags.
+ * @orphan:            True if this clk is currently orphaned.
+ * @rpm_enabled:       True if runtime power management is enabled for this clk.
+ * @enable_count:      Reference count of enables.
+ * @prepare_count:     Reference count of prepares.
+ * @protect_count:     Protection reference count against disable.
+ * @min_rate:          Minimum supported clock rate (Hz).
+ * @max_rate:          Maximum supported clock rate (Hz).
+ * @accuracy:          Accuracy of the clock rate (parts per billion).
+ * @phase:             Current phase (degrees).
+ * @duty:              Current duty cycle configuration (percent).
+ * @children:          All of the children of this clk.
+ * @child_node:        Node for linking as a child in the parent's list.
+ * @clks:              All of the clk consumers registered.
+ * @notifier_count:    Number of notifiers registered for this clk.
+ * @dentry:            DebugFS entry for this clk.
+ * @debug_node:        DebugFS node for this clk.
+ * @ref:               Reference count for structure lifetime management.
+ */
 struct clk_core {
 	const char		*name;
 	const struct clk_ops	*ops;

-- 
2.51.0


