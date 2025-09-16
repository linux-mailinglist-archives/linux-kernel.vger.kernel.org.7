Return-Path: <linux-kernel+bounces-818183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205CB58DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCECD2A5AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4B2D8774;
	Tue, 16 Sep 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLdtZX/c"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B962D23A9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001345; cv=none; b=DdpU0Rym38YO5fDH7vwAfPg2Oe0erDozEDmBGWL2En7HeMnVkfT7pJYNCukKWYeN7aIAJWhPu8X2PNpYwu983rmCCsSZVRegyo4xnPqdSyTNPuSBmfLFgQnitX7dAzYzl+u2eeoW7nXlBjeaDjX++70qWnHncWeDNkmM19wrMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001345; c=relaxed/simple;
	bh=d2Ks+Ez2kkiMgnmwiuOB1yzGYoU50hvL0gFy9bbawNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0+qgAOP6d4X7RsJHJ1n3j5S80ZT4zMwt7ebOsdvoA8glEeI5XE9CJGw6U2+CJtVWxOXwDv4lv93mMX5e/zYhuSOI7iWRc+lTalY/kDcx9EnpnB8pGJI3dxvJez4y3O1DOBPX0e1zrPjPoIXilGbAxU1N6OX1m5N6LtdIo2ozk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLdtZX/c; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7724df82cabso5174558b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001343; x=1758606143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OrphTQTPcPloMHaTWuSR0TqiJdZDQyGVN8eE5nU/kg=;
        b=fLdtZX/cIxnrc7ADRhhzQS1AQUgaMPH/yx69Cvr/3wJj7pAnYlP7BVb3vtFMmmtgD8
         kG2qfDKXTf3Z9BISLpCcgHw3E6rHS87OexD93ed98M+1jd6zo47KSaz5WtnPhCYjElWc
         wbWgqdcbVaShig0+q/FXrcNBMyu2O3an634R0YmPHaL/Y3NWciWfO1UsqkG8PqYmyMrX
         5oj0u3anQocWmwX8OlvMcDB4cy3QHmBWrO7WB3cNR4ULh0yC3Xt+PWr0PyVV5oU4gmKi
         vW2j3Vqp4nL19bzZZYwUkP+F7cFjhPFGS8JEqEXK9eA3ImWyHUAkTdv0fBYhI91DcNaV
         BGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001343; x=1758606143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OrphTQTPcPloMHaTWuSR0TqiJdZDQyGVN8eE5nU/kg=;
        b=suZkCSVMt6upwGAj2HoCSi+jtfrfQRwU52fQcQ+CXgbbuYi5QOhsvcpO3CFF0FUP6O
         nP47SzpRJcEgZmjHisiF3wKjuVBRZP/3IT+1CqyWuvCeEjieXlx8H0l9gK84L2FWTXqg
         U6yJZ1ayYhX5htem/VRapmyyTtqpdWErN2pzzR2jA2ypx6+3ANSpsp5c/IgUeYuX1V7L
         Bao3F3GfcvL+Os+WI7Oti5uGGkIb7leg2mnOXY6Nbb1/8UkYHZaVv5pJ00XUPvpkvW0w
         jOwyJG5q8shIedN6NyJcl2F2VzNosZss0EDZP21c6SzIkM6LbU4QRHIvxjXQaLwp6nX8
         6BkA==
X-Gm-Message-State: AOJu0YyH+0Si0/oueFt1+rqVMZ3FIwg78X7iIe7TYiAXXMy3YgQzp52w
	2L9TErtoA5rIVVApiVVfcQJw0T2ti0Og93kBXlJjLQwXAErRVblVwxz4
X-Gm-Gg: ASbGnctGyauDL/zzNe0hpriPiIZU2RbnVJHqV0Li376wcYj3sIXTJJ2rpjo9GjM/0dT
	PJtsBnkd4LUYYTxJB48PzAqJFwKeWuJx3y0VV8EnPJ4vgVoPQ3GeBelAI4twJdPbbbvHGQWaBZH
	0LbEajevlPtQc2/NCK4ZjonvOJpXeqVmkR7LoJ78QIJUoLkBa6Pm78I1fzU0VQW8TL1uzYRGC+j
	bvkFGBrGczVyrspvJnZbUpCq+Vo+CuZyPDjQjerYxMQihSt4tDS9EowlbGkaAAQlBLnlTiQTmKR
	eNYH5+6e2QlppVS4xO+z8QiKqt0f5+EyzGTyiQ2eqFsHhAD2AQP32izp+49v0Xp3zPHCQ2yXxFb
	6jeaKYeJDWvadcR+gppDIVsnEjA==
X-Google-Smtp-Source: AGHT+IFjkDAeBD3m3VhlVk8jYHDU8nrvwEkAOBqjFcy5ibI78SkWM7xIqAKJtkrXYmtLfgV7adazMQ==
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a506 with SMTP id adf61e73a8af0-2602ca077cbmr20640551637.57.1758001342621;
        Mon, 15 Sep 2025 22:42:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77654a55d08sm8626719b3a.77.2025.09.15.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 817F84227236; Tue, 16 Sep 2025 12:42:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 4/5] Documentation: trace: histogram-design: Wrap introductory note in note:: directive
Date: Tue, 16 Sep 2025 12:42:02 +0700
Message-ID: <20250916054202.582074-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=bagasdotme@gmail.com; h=from:subject; bh=d2Ks+Ez2kkiMgnmwiuOB1yzGYoU50hvL0gFy9bbawNs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfpirH3M5u7rrglCKnIn7+0dSGWyln3SvTbzr6rjLs ke2dA5zRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYiycrwP5Yv/PU6v5fdOt+8 b4b73JbunH4qInOCllbor/XsKwNX7GVkWMJ47OTmLQ1GPuXfZziWlzSuSPl91IG/8dll7j8xDzk F2QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use Sphinx note:: directive for the introductory note at the beginning
of docs, instead of aligned-text paragraph that renders as definition
list.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram-design.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 4faff1669b77bd..ae71b5bf97c6c7 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -11,13 +11,14 @@ histograms work and how the individual pieces map to the data
 structures used to implement them in trace_events_hist.c and
 tracing_map.c.
 
-Note: All the ftrace histogram command examples assume the working
-      directory is the ftrace /tracing directory. For example::
+.. note::
+   All the ftrace histogram command examples assume the working
+   directory is the ftrace /tracing directory. For example::
 
 	# cd /sys/kernel/tracing
 
-Also, the histogram output displayed for those commands will be
-generally be truncated - only enough to make the point is displayed.
+   Also, the histogram output displayed for those commands will be
+   generally be truncated - only enough to make the point is displayed.
 
 'hist_debug' trace event files
 ==============================
-- 
An old man doll... just what I always wanted! - Clara


