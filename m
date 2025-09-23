Return-Path: <linux-kernel+bounces-829145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0326B96648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4523B765F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4322EA146;
	Tue, 23 Sep 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN0qI5VY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EC2F0C78
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638426; cv=none; b=SjVRScnf+Su/nbKEWFChhI0nhyVY//kfsNGLf/DgPeHbDAXdEoWU2IzuolZ0/decIxK1GEmcFu87DZ28G1bpXDZvYi38fdF5UApYBAyQyKfVX+rEZMi+CHYR8hFb4iASf9Yq/eUzRg+HJX+lHi+dVeXhkAZgWwk6OseDPg7UhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638426; c=relaxed/simple;
	bh=H1GPptBRUoh2w27cPKC4anGOn4jSZDc2JlW+WJNT3Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmKHLs5G8H6ew09MFYz1rPbNpWg84tHbwQM3uYYo8ypyDPbp6jKDOJHF8QCVxBrZP9ZmfGiYOogtJVzAYPpYxpESnMDiKa8IA34SrVHidLr6IIACmmqtYS+zfxNdZaOiL9e3B78iyhTgWxADuvyTH/McMMwBJ9CwXBvZRE1JDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KN0qI5VY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PYeewd8MlKC92Ky0ymLghLD05PEieLt3ORobkOYxO0=;
	b=KN0qI5VY7XPN3iALhqc4nTb7ohliHIBuGdi6a+pxdyK5ZhAWaYEaboNYwrKcBEVvRIBDmA
	bR4SMxRhhOAl3GaSuZZ3itwQWYCJHKfrSBivlzDoTz33HM7snuyphrfvXsNbgySvsyKTdi
	f4MMzG2hWrzUDgeMMXs4Q2vwjCfEWB4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-mSfHp44NPaWUCRUjj_BNyQ-1; Tue, 23 Sep 2025 10:40:19 -0400
X-MC-Unique: mSfHp44NPaWUCRUjj_BNyQ-1
X-Mimecast-MFC-AGG-ID: mSfHp44NPaWUCRUjj_BNyQ_1758638419
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-82968fe9e8cso1527234285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638419; x=1759243219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PYeewd8MlKC92Ky0ymLghLD05PEieLt3ORobkOYxO0=;
        b=CFf/34BwPwyNlhASUHsRcI/gboWgwcaoGvcmbqnb/0Wlmyx2o7Ylyx2dR88RDxi/NV
         DGYihPh2wClsq+aj6qyMRAuk8ttCW174DcByshjtnT4QG2g7adc10SmGPlGaU5si6dh/
         2UZ5hyWJfWCB58Ox5qNzG0NeAHHroT8zJfWFjKMTuibF2GCbkRO8eVaG4frFYYgwytDy
         l6AXyGDs56FS/8K+5Af/yu56SNaIbQaUUCROPfcofkP0Pf0ZPVIlidxqK54YTfjKZuRf
         RkCqB+Ddl1RLL1IXaLdTLkFkhIVicV1dbgmJzybmfQnOkekkdDLe3BnJROseTxC4oYvy
         MCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUy+cV/xvoi6TsAwM6Ww9BunTIhtL94TOmWCGXLpt4YJkW0L024OY/bO8pmtEubQr1uc9mT5VlIO+/0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6VQF1nyRQ+ugmFYMYPNqgdZj0NsDrz2HmrgkqixLj4OcOYkS
	eTWLfh6qaGab45zR65e/7CH4cK5+AVpBqsyTWeseLi6Id1hlc3lz/n3aPxxFyObLmseY4ipvFXu
	KQZTGb+dHJfK1sc6XnJ/IcUevkYQQ8whEB0fzLgY6Y3pqeuR3GQ7BLOUAQSIrOQgPZw==
X-Gm-Gg: ASbGncuN0wh/y2fy/r0FFTWLkL+76Brxp3eXSG5vJ8Wyt+t/cSCAUaJwmRnvGvBQKcS
	4rwEJpBDBZXAlMre9fR96Ynkkc+olxpXVbiUynhsf10JvLvULF7ZPV1nl/H9zkyxgRj1HQqywUp
	M+ro3+z7l2cSX1cDD5SzuajMsK7isowA+Dyw8nWKHaUCjADHUrPeW9VdoyenYISS96xcqoTtyqn
	8kcCLgHL75p1YusvzjOaGHDtSSakW8UgP2bwDw1y0vnC6LRDPOB9Z77B7J2e/NrPsrncIFzEs0B
	G9tdk6GF3FHAZLy0YoEDB9+AqSFsfQ1V/L5ugGt+OKnpLGYl7a0fP2eym4E7RJBTqf8l5rTRccK
	Be89xr7D3I1KCFTqwAEdkVqr0TZV2i2gjRqmrmZo=
X-Received: by 2002:a05:620a:198d:b0:850:77f0:3f47 with SMTP id af79cd13be357-85169115b30mr347183685a.6.1758638418778;
        Tue, 23 Sep 2025 07:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbgVS6UuxqwfuMj3mpvBhdDbNqqkvaMjz/xybyYpq+FR7zcqyCung0SHqwOTKpF22MmT0GVA==
X-Received: by 2002:a05:620a:198d:b0:850:77f0:3f47 with SMTP id af79cd13be357-85169115b30mr347179385a.6.1758638418218;
        Tue, 23 Sep 2025 07:40:18 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:40:17 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:29 -0400
Subject: [PATCH RFC v4 10/12] clk: add support for v2 rate negotiation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-clk-tests-docs-v4-10-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14850; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=H1GPptBRUoh2w27cPKC4anGOn4jSZDc2JlW+WJNT3Wg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubTToeDv57+Q7fYVR3TerGdTWiBtJBcxc7dSVmDkn8
 kTxsfvPOkpZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZiIGycjw6dHpxp+nrBY8eF0
 iqFroEZCj5TmPQsWH70lRbM4M/4Wr2X4p11ssX6pwtaG/72/ehZHv+O2+VkxS9Xk7wfBQ0HrEmz
 PcAMA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The Common Clock Framework is expected to keep a clock’s rate stable
after setting a new rate with:

    clk_set_rate(clk, NEW_RATE);

Clock consumers do not know about the clock hierarchy, sibling clocks,
or the type of clocks involved. However, several longstanding issues
affect how rate changes propagate through the clock tree when
CLK_SET_RATE_PARENT is involved, and the parent's clock rate is changed:

- A clock in some cases can unknowingly change a sibling clock's rate.
  More details about this particular case are documented at the Link
  tag below.

- No negotiation is done with the sibling clocks, so an inappropriate
  or less than ideal parent rate can be selected.

An unknown subset of existing boards are unknowingly dependent on the
existing behavior, so it's risky to change the way the rate negotiation
logic is done in the clk core.

Add support for v1 and v2 rate negotiation logic to the clk core. When
a child determines that a parent rate change needs to occur when the
v2 logic is used, the parent negotiates with all nodes in that part of
the clk subtree and picks the first rate that's acceptable to all nodes.

The v2 logic is used when the negotiate_rates clk op is defined
on the parent, or current clk code. Otherwise, the existing v1 logic
will be used. Additionally, the clk_v2_rate_negotiation kernel parameter
is introduced to help with debugging when you suspect your board is
unknowingly dependent the legacy behavior.

Link: https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-2-0d2c2f220442@redhat.com/
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  15 +++
 Documentation/driver-api/clk.rst                |   3 +
 drivers/clk/clk.c                               | 143 +++++++++++++++++++++---
 include/linux/clk-provider.h                    |   7 ++
 include/linux/clk.h                             |  20 ++++
 5 files changed, 174 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf4946bb9efe320f0f62fdcd1560b0a71..3b8534811792165d0468616c8cbb3b78f3591472 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -695,6 +695,21 @@
 			platform with proper driver support.  For more
 			information, see Documentation/driver-api/clk.rst.
 
+	clk_v2_rate_negotiation
+			[CLK]
+			Use the v2 common clk rate negotiation logic. In some
+			cases when a child needs to change the rate of it's
+			parent clk, the rate of a sibling clk can be
+			unexpectedly changed with the v1 rate negotiation logic,
+			and some platforms are unknowingly dependent on this
+			behavior.
+
+			This defaults to 1 where the v2 interface is used when
+			supported by the clk providers. If it is 0, then the v1
+			interface will be used. This is useful for debugging when
+			you suspect your board is unknowingly dependent the
+			legacy behavior.
+
 	clock=		[BUGS=X86-32, HW] gettimeofday clocksource override.
 			[Deprecated]
 			Forces specified clocksource (if available) to be used
diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 93bab5336dfda06069eea700d2830089bf3bce03..c46ee62ba5bd1bf0c66ca282c582963b9ea55580 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -75,6 +75,9 @@ the operations defined in clk-provider.h::
 		void		(*disable)(struct clk_hw *hw);
 		int		(*is_enabled)(struct clk_hw *hw);
 		void		(*disable_unused)(struct clk_hw *hw);
+		bool            (*negotiate_rates)(struct clk_hw *hw,
+					           struct clk_rate_request *req,
+					           bool (*check_rate)(struct clk_core *, unsigned long));
 		unsigned long	(*recalc_rate)(struct clk_hw *hw,
 						unsigned long parent_rate);
 		long		(*round_rate)(struct clk_hw *hw,
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 018dd5a32ecbf166718da3eda851f51fdfdd2088..0cab15f0d7c3d45ff38c1d9971f29d95ac402d41 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -6,6 +6,7 @@
  * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
  */
 
+#include <kunit/visibility.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
@@ -92,6 +93,8 @@ struct clk_parent_map {
  *                     clk_core->rate every time the clock is reparented, and
  *                     when we're doing the orphan -> !orphan transition.
  * @new_rate:          New rate to be set during a rate change operation.
+ * @validate_rate:     Temporary rate that's used when various clk nodes are
+ *                     negotiating a rate with the v2 rate negotiation logic.
  * @new_parent:        Pointer to new parent during parent change. This is also
  *                     used when a clk's rate is changed.
  * @new_child:         Pointer to new child during reparenting. This is also
@@ -130,6 +133,7 @@ struct clk_core {
 	unsigned long		rate;
 	unsigned long		req_rate;
 	unsigned long		new_rate;
+	unsigned long		validate_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
@@ -411,6 +415,44 @@ static bool clk_core_is_enabled(struct clk_core *core)
 
 /***    helper functions   ***/
 
+static bool clk_v2_rate_negotiation = 1;
+static int __init clk_v2_rate_negotiation_setup(char *str)
+{
+	unsigned long enabled;
+
+	if (!kstrtoul(str, 0, &enabled))
+		clk_v2_rate_negotiation = enabled ? 1 : 0;
+
+	return 1;
+}
+__setup("clk_v2_rate_negotiation", clk_v2_rate_negotiation_setup);
+
+static int clk_core_use_v2_rate_negotiation(struct clk_core *core)
+{
+	bool has_v2_ops = core->ops->negotiate_rates ||
+		(core->parent && core->parent->ops->negotiate_rates);
+
+	return has_v2_ops && clk_v2_rate_negotiation;
+}
+
+void clk_enable_v1_rate_negotiation(void)
+{
+	clk_v2_rate_negotiation = false;
+}
+EXPORT_SYMBOL_IF_KUNIT(clk_enable_v1_rate_negotiation);
+
+void clk_enable_v2_rate_negotiation(void)
+{
+	clk_v2_rate_negotiation = true;
+}
+EXPORT_SYMBOL_IF_KUNIT(clk_enable_v2_rate_negotiation);
+
+int clk_use_v2_rate_negotiation(struct clk *clk)
+{
+	return clk_core_use_v2_rate_negotiation(clk->core);
+}
+EXPORT_SYMBOL_IF_KUNIT(clk_use_v2_rate_negotiation);
+
 const char *__clk_get_name(const struct clk *clk)
 {
 	return !clk ? NULL : clk->core->name;
@@ -2321,7 +2363,8 @@ static int __clk_speculate_rates(struct clk_core *core,
 }
 
 static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
-			     struct clk_core *new_parent, u8 p_index)
+			     struct clk_core *new_parent, u8 p_index,
+			     struct clk_core *initiating_clk)
 {
 	struct clk_core *child;
 
@@ -2334,8 +2377,66 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 		new_parent->new_child = core;
 
 	hlist_for_each_entry(child, &core->children, child_node) {
-		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
+		if (child == initiating_clk || !clk_core_use_v2_rate_negotiation(child))
+			child->new_rate = clk_recalc(child, new_rate);
+		else
+			child->new_rate = child->rate;
+
+		clk_calc_subtree(child, child->new_rate, NULL, 0, initiating_clk);
+	}
+}
+
+static bool clk_check_rate(struct clk_core *core, unsigned long validate_rate)
+{
+	struct clk_rate_request req;
+	struct clk_hw *orig_parent;
+	struct clk_core *child;
+	int ret, old_flags;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		clk_core_init_rate_req(child, &req, child->new_rate);
+		req.best_parent_rate = validate_rate;
+		orig_parent = req.best_parent_hw;
+
+		/*
+		 * Round the existing child rate based on the new proposed
+		 * parent rate. Don't allow the parent rate to be changed.
+		 */
+		old_flags = child->flags;
+		child->flags &= ~CLK_SET_RATE_PARENT;
+		ret = clk_core_determine_round_nolock(child, &req);
+		child->flags = old_flags;
+
+		if (ret < 0)
+			return false;
+
+		if (WARN_ON_ONCE(req.best_parent_rate != validate_rate))
+			return false;
+
+		// FIXME - muxes not supported at the moment
+		if (req.best_parent_hw != orig_parent)
+			return false;
+
+		if (req.rate < child->new_rate || req.rate > child->new_rate)
+			return false;
+
+		// Check the child's children (if present)
+		if (!clk_check_rate(child, req.rate))
+			return false;
+	}
+
+	core->validate_rate = validate_rate;
+
+	return true;
+}
+
+static void clk_accept_rate_negotiations(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	core->new_rate = core->validate_rate;
+	hlist_for_each_entry(child, &core->children, child_node) {
+		clk_accept_rate_negotiations(child);
 	}
 }
 
@@ -2344,11 +2445,13 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
  * changed.
  */
 static struct clk_core *clk_calc_new_rates(struct clk_core *core,
-					   unsigned long rate)
+					   unsigned long rate,
+					   struct clk_core *initiating_clk)
 {
 	struct clk_core *top = core;
 	struct clk_core *old_parent, *parent;
 	unsigned long best_parent_rate = 0;
+	bool fine_tune_rates = false;
 	unsigned long new_rate;
 	unsigned long min_rate;
 	unsigned long max_rate;
@@ -2392,7 +2495,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		return NULL;
 	} else {
 		/* pass-through clock with adjustable parent */
-		top = clk_calc_new_rates(parent, rate);
+		top = clk_calc_new_rates(parent, rate, initiating_clk);
 		new_rate = parent->new_rate;
 		goto out;
 	}
@@ -2416,11 +2519,23 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	}
 
 	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
-		top = clk_calc_new_rates(parent, best_parent_rate);
+	    best_parent_rate != parent->rate) {
+		top = clk_calc_new_rates(parent, best_parent_rate, initiating_clk);
+		fine_tune_rates = true;
+	}
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	clk_calc_subtree(core, new_rate, parent, p_index, initiating_clk);
+
+	if (fine_tune_rates && clk_core_use_v2_rate_negotiation(top)) {
+		struct clk_rate_request req;
+
+		clk_core_init_rate_req(top, &req, top->new_rate);
+		if (!top->ops->negotiate_rates(top->hw, &req, clk_check_rate))
+			return NULL;
+
+		clk_accept_rate_negotiations(top);
+	}
 
 	return top;
 }
@@ -2468,7 +2583,7 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
  */
-static void clk_change_rate(struct clk_core *core)
+static void clk_change_rate(struct clk_core *core, struct clk_core *initiating_clk)
 {
 	struct clk_core *child;
 	struct hlist_node *tmp;
@@ -2537,7 +2652,7 @@ static void clk_change_rate(struct clk_core *core)
 		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
 
 	if (core->flags & CLK_RECALC_NEW_RATES)
-		(void)clk_calc_new_rates(core, core->new_rate);
+		(void)clk_calc_new_rates(core, core->new_rate, initiating_clk);
 
 	/*
 	 * Use safe iteration, as change_rate can actually swap parents
@@ -2547,12 +2662,12 @@ static void clk_change_rate(struct clk_core *core)
 		/* Skip children who will be reparented to another clock */
 		if (child->new_parent && child->new_parent != core)
 			continue;
-		clk_change_rate(child);
+		clk_change_rate(child, initiating_clk);
 	}
 
 	/* handle the new child who might not be in core->children yet */
 	if (core->new_child)
-		clk_change_rate(core->new_child);
+		clk_change_rate(core->new_child, initiating_clk);
 
 	clk_pm_runtime_put(core);
 }
@@ -2608,7 +2723,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 		return -EBUSY;
 
 	/* calculate new rates and get the topmost changed clock */
-	top = clk_calc_new_rates(core, req_rate);
+	top = clk_calc_new_rates(core, req_rate, core);
 	if (!top)
 		return -EINVAL;
 
@@ -2627,7 +2742,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	}
 
 	/* change the rates */
-	clk_change_rate(top);
+	clk_change_rate(top, core);
 
 	core->req_rate = req_rate;
 err:
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..9041b17ba99ef16a01e9f4d749e2e4b601a94b93 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -129,6 +129,10 @@ struct clk_duty {
  * @restore_context: Restore the context of the clock after a restoration
  *		of power.
  *
+ * @negotiate_rates: When a child clk requests a new rate that requires a rate
+ *		change from the parent, this negotiates a new parent rate that's
+ *		acceptable to all of the children.
+ *
  * @recalc_rate: Recalculate the rate of this clock, by querying hardware. The
  *		parent rate is an input parameter.  It is up to the caller to
  *		ensure that the prepare_mutex is held across this call. If the
@@ -242,6 +246,9 @@ struct clk_ops {
 	void		(*disable_unused)(struct clk_hw *hw);
 	int		(*save_context)(struct clk_hw *hw);
 	void		(*restore_context)(struct clk_hw *hw);
+	bool		(*negotiate_rates)(struct clk_hw *hw,
+					   struct clk_rate_request *req,
+					   bool (*check_rate)(struct clk_core *, unsigned long));
 	unsigned long	(*recalc_rate)(struct clk_hw *hw,
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b607482ca77e987b9344c38f25ebb5c8d35c1d39..e58f6c91aceaa329b4af90d3924ee63d47ecd68c 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -91,6 +91,26 @@ struct clk_bulk_data {
 
 #ifdef CONFIG_COMMON_CLK
 
+void clk_enable_v1_rate_negotiation(void);
+
+void clk_enable_v2_rate_negotiation(void);
+
+/**
+ * clk_use_v2_rate_negotiation - Use the v2 common clk rate negotiation logic.
+ * In some cases when a child needs to change the rate of it's parent clk, the
+ * rate of a sibling clk can be unexpectedly changed by the v1 negotiation
+ * logic. Some platforms are unknowingly dependent on this behavior.
+ *
+ * This function is only exported for the kunit tests, and this is not to be
+ * used outside of the clk core.
+ *
+ * @clk: clock to check
+ *
+ * Returns 1 if the v2 negotiation logic is used, or 0 if the v1 negotiation
+ * logic is used.
+ */
+int clk_use_v2_rate_negotiation(struct clk *clk);
+
 /**
  * clk_notifier_register - register a clock rate-change notifier callback
  * @clk: clock whose rate we are interested in

-- 
2.51.0


