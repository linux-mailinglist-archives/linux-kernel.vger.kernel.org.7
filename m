Return-Path: <linux-kernel+bounces-818185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6DB58DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F9B7B118E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE272DC34D;
	Tue, 16 Sep 2025 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0f8yKj+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BA2D8377
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001347; cv=none; b=epXYt3uBPuaQa+oBChvzCDOKtNCVS6ZPk7XmOxDc6TD8ZB1M02zj+kI8/CcPp5e4u+Re2D/bGpVievrvNgui9oyG11pH3KSzfLpdFERmU8RUszaA6pQCx3OHzb41m/kFIBWgP2uf6ZWxwwyVfL340sNjzuIodzhGzV0yWX825Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001347; c=relaxed/simple;
	bh=8NBytuejkgmSFrqx+1YX5XgCxvOHNVzzXPSqQWyrZzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3DdasYP1GOkn8lox16tWwzQu8/FH/DDxgVlBL0V6p8lsrgLoezs6uG57HCrGCMKUiegvCmLAeAONJvOtdsRDIkNG1DxeMPnZG/JrqCyg8xT7ouWJJWX8FYsIPLN8TKjvGOeCb2pRPbGLo6UnNXAqtdLkQs7k1Cn+P6w0/l8ub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0f8yKj+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso3518419a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001345; x=1758606145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA+efhhVzcVIxn2rganxCwFW/bnQtqIpNxQbWngi1b4=;
        b=A0f8yKj+jaxcoCmllZ2x5eXF8IMyM7xTtOWs2/ZicTp/+e9Q3vSHOh3x6xOSxJT8Mw
         PiSb1XdaYPFF5qslnsUEVZpaUkpNZi20VbfSIb+4W9udajEeGc84DLarOqc/50gQNytc
         1gG3zFP74XD9Skx4I8hfI2kNujqnbGHYx5970/cxVXsgOlRSihtnZDySeUz4HRsALh0J
         WlU43lm3I6/29StbJaHPgttID3niFtNBUrl5nsIQOYHs80hlwJF/Y/Juzm23aY0uhq7w
         KOzEBX008GHkLV45jiMVW8sskl6/ui6EBbZM7JYgBmVqPoQfCpKcJ4nfM9hvGGjc5Qyk
         IGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001345; x=1758606145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA+efhhVzcVIxn2rganxCwFW/bnQtqIpNxQbWngi1b4=;
        b=ftVdX48MmRYzyQb4dUfLYDQLd6JuhcV8FLqQQD8/d218/v4w5JgxRuvt8Mkddcvxse
         fAsogsuClv5T1Wjd+ZSV/Qm1pI+APEcXMYcxtBCQjDv+uMm6HGsIeTbi9M4dLNZJHgj0
         MNfHD4mhNaIoPDN/R+Ui1cUKi6GnngMMW3CuqG8umwhkMA/RY7hvy2SNrKSUzhrYICyM
         dtn7RV3+6UktEbW403C+H5ERwkMynoPT/oVPXaQvvCkPCq6SNYZlaBtfWUfzTM49wAZv
         G9btIntTrCxB2xSgwcVjN5LckAoI4T1mtqCzPlfEeL+LmT0mqtuurPDPIl3JjHXOtXdi
         U9dg==
X-Gm-Message-State: AOJu0YxeZFGSAXqdJMfK7gqYXlH1eYsI6PXrBA/wE5mbH2Dg/06HnrGo
	0aTXSBGW0p51F89ZpouBudNxEhkkSakEWjB+Tozrov5me3jVTmgExHFa
X-Gm-Gg: ASbGncsqfie9TaxzrznZGz3GMeGscf1yVBGvoHlnx97m09MbgVhBNZoEjM7+zWuXy8G
	QK81l1Q37zghEZy0EBF//eKvlPHVbOixOsF7Yd6KuSzg1vNwStQHZQzhEGc7yP1LhGnrpX2dRTN
	P8Vd/oBdS4yToD4SzQ3Ihp8UQ/UV6J6YZa4bbt3Li2f+WqbFGZC+8Oh6Sn4i0kXIRJVd5igE4OK
	JhBF6JotP8+WED1AHEm8COIpBqVvGT3sTojrnygj39gMoQcX1UgOJyHix2mV+OXoJHH2NBby7UX
	5+Q0XnyZfUUgfTfWoifXWJ+vEC9c/KIFzBoZ6W2koAmGX4A/97jNLFjL7G5Ko2nE+HzCrGMSg8g
	qqMCmpD0BxGAJameguoOUNjCBPg==
X-Google-Smtp-Source: AGHT+IFrvIySj9YPlWQ7FIJlVK7g2Kv/lcrzGY3U0M775dmnSq64Cf2O4rtx9zaA9FHckbb8B+VGPQ==
X-Received: by 2002:a17:903:2a8e:b0:265:8a76:4b0e with SMTP id d9443c01a7336-2658a764cc7mr81319825ad.53.1758001344772;
        Mon, 15 Sep 2025 22:42:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea41d3e19sm420977a91.11.2025.09.15.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D7949420A809; Tue, 16 Sep 2025 12:42:18 +0700 (WIB)
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
Subject: [PATCH v2 0/5] Histogram docs formatting cleanup
Date: Tue, 16 Sep 2025 12:41:58 +0700
Message-ID: <20250916054202.582074-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=bagasdotme@gmail.com; h=from:subject; bh=8NBytuejkgmSFrqx+1YX5XgCxvOHNVzzXPSqQWyrZzo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfhicfRauZvBo4uYlLUIb20Nvtl0TDdOsWM48iYF3M dOSwzqPO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR916MDI+19HuUF1g8Cmj5 nM4xi6Wo3dhrWX5D4OZahUjvUCXfp4wMdz4IRZx++SphzznlPz/r4jX/BatGHomaefLr4ev32wO yGAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here's a formatting assortment for trace histogram docs. The shortlog
below should be self-explanatory.

Enjoy!

Changes since v1 [1]:

  * Apply review tags (Masami, Tom)
  * Reword patch description for ftrace cross-reference link (Masami, [5/5])

[1]: https://lore.kernel.org/linux-doc/20250911042527.22573-1-bagasdotme@gmail.com/

Bagas Sanjaya (5):
  Documentation: trace: histogram: Fix histogram trigger subsection
    number order
  Documentation: trace: histogram-design: Trim trailing vertices in
    diagram explanation text
  Documentation: trace: historgram-design: Separate sched_waking
    histogram section heading and the following diagram
  Documentation: trace: histogram-design: Wrap introductory note in
    note:: directive
  Documentation: trace: histogram: Convert ftrace docs cross-reference

 Documentation/trace/histogram-design.rst | 151 ++++++++++++-----------
 Documentation/trace/histogram.rst        |  38 +++---
 2 files changed, 96 insertions(+), 93 deletions(-)


base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


