Return-Path: <linux-kernel+bounces-765062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF3B22AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014291882400
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C62EBBAE;
	Tue, 12 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gugEFzoH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235A2EBB8E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009658; cv=none; b=hSgc42k5+C+Qmr5IBwA4j9wbq3LZFVwq3+tAT/A5Lytglxrz2VlcMHrflRbnmMG0eFHlCf0nL2zl264VxCXGaawnJMoWmbBOzAxg+UXBtDqlCc5Wnj9SZb28IX3QbJ9TURFJ/Faaxm5+1bCY6g7OhQft0R/f5Qn+MFwvPiJi1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009658; c=relaxed/simple;
	bh=dCRqataLA66dZJ1YRHlWTY3qoxuRgsndmQxu0wuYWhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqOPeCg8o5u7w5tkRHaE8ZXaDfshoPRdek+jGjHSlU0SHtp3TgGcZgUgBhGxFLsDEiDX/ybGkjkuojtzhuZKP/vpsaJTRtMTdln01Ds/sRN0FC6Wn/jqyCJ4uLxOMMGtLyiMkiN+l5zO0D7u2G9Y1GL/aj975DtZkMgm5WbQ5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gugEFzoH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9H0+sUqPkWGutsGuMBTZemy9juMhjF+bUDnckQaH8A=;
	b=gugEFzoHGjZsdOGM83bNKWe/E4vqou1UT/BABgqIPMaWb2ge9kJYnSUYEhGWYdlJ3DF8bP
	rtBhQZefkaTCVqQAvX4e5r8IbY7tv0O1I1OkkFMOvzyBk8FuvH0hGE6eZ86ge/C6ekcKIs
	rlp6v3FxxW0Ft3R30iaz5LCHzroWt6I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-2aOhcN5QMme0uTJJqGZcoQ-1; Tue, 12 Aug 2025 10:40:54 -0400
X-MC-Unique: 2aOhcN5QMme0uTJJqGZcoQ-1
X-Mimecast-MFC-AGG-ID: 2aOhcN5QMme0uTJJqGZcoQ_1755009653
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b081b2a94cso183599311cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009652; x=1755614452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9H0+sUqPkWGutsGuMBTZemy9juMhjF+bUDnckQaH8A=;
        b=UWvtutwwN/IYoiuyaR7BKai84+qjLlojDNmqc0xYmeSAlh41v2nxkaySFEIFBuYjwd
         jNHSC4dqsy7puYQS98MKyLEZ4AWkqk80s7OMZHCco5zaMxi+wbva//TaOY+/yPWK7DPH
         FxC/Nb3sQXVZCSBgf/HRz4hX9Y6bSu4UZUuU7M2vsWyZOqXf1MhqTh21EhjKX7k2LKsE
         /wnjKtGgsG1696hlErEYyhxFJoa3RL5Bt1e45t0NY2i85idZtqjJiB3OcL53KgVUDQTN
         gq/eIsOZdY0Yl7rxgOvXq5g/pIC26DmX3zsigeeLgPFWQdeplmq1g+NkUC+RIrUZxPMi
         33qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6of8rVFQVR6XL6dhtKLoGulWo7sD8voK8Cjs+v9zaH/puO1mA0UXeajaworvfRFI2CA6uPQepw7gGs1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU2OQlly2Z9q2eYsf5zxHKJ4S+3KG9BEGN9k2TjrFNjQRCBsW
	aM+u/b4MWrZYP4amRdgsrGV0j21gnBF1ETW8T9P9UM0idF3GqpHwviKArF357nprsbsgZjGocmK
	+wBjzefs97DQmRzOXrCXuO+dQ0O/ZOVdCBh1FQtcJ8rVxxo6uRq6YQps93Q5SnBaBSHWtXlCudZ
	H7ef6TV5vHtmt7VfMfvfUC/FDgPloSX2GvKgXvmu6P/YtTQEcR3S8=
X-Gm-Gg: ASbGncuNDq9lznye7Qure5yXZX4NI1GWqyDbBBYFiHV9bdt2/dbt7E/I85NMOtWiV3b
	9oooec75/1omihGST4P4ufrRLpId37dfWX24dxpFsgqNu5aCjZWHf1RmNWZ7ButdK0lxF3dMQI3
	bxPP10bWlA4CujKQygWv83wFhR/MsHzPH5/dzFFaOYk5RNij/AT643nI0DexEHNESPVwJxaRbUF
	BK0Lkol5GlXmK90NcKDT7m1KtCE9L6njcp+eBawp5WfLiN4+x00xnG+rVLzIypzIPo7w+MBLco/
	ooEQUSs2lR9tPrioQRErsiKcTiR3TNHsYOu1zzMy2PcrhaBEnfmujs19XJF7hxuTR7TmI23YP/W
	U4g==
X-Received: by 2002:a05:622a:99b:b0:4b0:8092:9918 with SMTP id d75a77b69052e-4b0ecba3144mr48202151cf.1.1755009652257;
        Tue, 12 Aug 2025 07:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/GBNxJlXzAEommYuP641e9fRZ9EZKdhv3Y1t27AZSKt0xtc3v5WiBawsf4OPXx5wGmJGpw==
X-Received: by 2002:a05:622a:99b:b0:4b0:8092:9918 with SMTP id d75a77b69052e-4b0ecba3144mr48201591cf.1.1755009651795;
        Tue, 12 Aug 2025 07:40:51 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:40:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:31 -0400
Subject: [PATCH v3 1/9] clk: add kernel docs for struct clk_core
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-1-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=4276;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=dCRqataLA66dZJ1YRHlWTY3qoxuRgsndmQxu0wuYWhA=;
 b=oYaK35NUukGmkDI7mBbltcQ75razu+JbR47JwXDr1gECCF1sVqMWwKb+m+OjRJ15VmTltfH3X
 ugTMGFoIYW2DIQWzBZQz7WcqlyUxSmyw2aT25DvUDyQGDbFIMZpfoXV
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Document all of the members of struct clk_core.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..41690448ce9ada8eaa30221950da4a3b1c4552d2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -57,6 +57,61 @@ struct clk_parent_map {
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
+ * @new_parent_index:  Index of the new parent during parent change.
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
+ * @new_parent:        Pointer to new parent during parent change.
+ * @new_child:         Pointer to new child during reparenting.
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
+ * @duty:              Current duty cycle configuration.
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
2.50.1


