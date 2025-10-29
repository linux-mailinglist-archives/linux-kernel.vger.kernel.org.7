Return-Path: <linux-kernel+bounces-876883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B818C1CA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 883B44E3179
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F4354AD0;
	Wed, 29 Oct 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc370OoA"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BA30BF75
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760656; cv=none; b=pr/HTHoRKjJ29yn1ps5SjdmPqGI55r8AcvYhrHEVlDKDfuiAJQxaPL8cP0c3+WAzf/YN1kR03CFoCpjyMHAZTmiIlWd01LHUDvNbVKt8OkeVzAEYhuWLYb1kgKfpKgwx21C5AHQfrGYx+wAJYcw+ND5wWirB94loA+LmWjUIX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760656; c=relaxed/simple;
	bh=q4G6Z3tmtUPTA3pyRliiBAglQ+ctalR59e9PIQK8Jjo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jciVVs+lxEE7ux9UQNJAGDg975ugXYq2jeQXGZWPyYWvLNPx7WLydbWDR6ZGoHFyQF2M+WhwXgj49Ls1cPGQnBzjV6tqBdFRKUuHb9fTYjAufHK8jweYKHKQvTWLXuTGdgxZD/tiUuUlRNQKG3794KZjDSO+u5Cg175wVnbQDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc370OoA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso126590f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761760652; x=1762365452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PizgSZp8pst5R3ZXKOAFmbyk/ir0h79jwp+tXy3J6Ik=;
        b=nc370OoA8Etny9+1rEHQdT+97Sbzy08s3SQlNgyg371QPQzEqIuYwCRRbfiOvjuaeL
         jge5/UGYoGBtyu+G7/DW3ePimY/b75tJ0uelpgfhPYnqV8BwVfeMupSq709tE2E1C4gG
         SpxfjZsFI/seImUp4D/ad7ISRTpPrO+ZbccLqSHi/d3kogW1RYss+Qcfsv9lgKoA1KBZ
         1Bk0z7CGZlAKFi5V/g4VNPfY4cMWUxYMS+eGYHbP6/Nc4jOSjeDW4oAPmMPDbcu+DMH3
         gKOORB9WCdwqq5W1idvthDJGbGEnLSiOzst7BUsw1IurKqRsOk4mU29L8lBFEkOBboUC
         saUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761760652; x=1762365452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PizgSZp8pst5R3ZXKOAFmbyk/ir0h79jwp+tXy3J6Ik=;
        b=vpeJqkDpJNQPkxsBlM2jyO1Y9p1akrzzK4hY2d7WraXO6ZBpXMcznIBnRgQoNWKzIY
         s0L8KWJiw2vKFA+D5HEovCY3EiYrhpinbd0ChNDgkJD0x5QHImpIy1LOX4F29qI2c+ip
         +6Bi0SNdi6OIHQg4VTM0lhurAqc/8FU/d2ZhWSWD4vH7nrDq750T0zjspm3seEh+MQRz
         OOKTwVtYvnbISPPWOtuCru0ufPX8CwBkt60N10XIB46wfGIsuaFMYzz51vz8pveRt/vd
         Udx35UI94JbhULadlA7JxZWcjtR7RpVo6mHvieYS7L5Sws5XPLij+n5oe9jNxbFYAXiY
         OMqA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3VrCf1i3qBThBA7HY0FUdXMQZk4PSKcpP0YtMoJHYNtnaIhxNDXeMEAUIro5csgETcayYmkdVTqGjiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPw8pdCPZJcEUmhl2jxJZo/t5ggqYT3EsjbFS8Cm9qzhY9/RDA
	sHxiDX483JAuEBTqLUrCS/w3/OzYUyNvsW3ptOwinfuhbQxCIZgf35SYjbNuiQ==
X-Gm-Gg: ASbGncvtkYjYs856BqNme38dttb4kQzBdwChpitQnfqADUGwUWIazyH8+KbAFWobJBr
	MNKQZ4Pauy70f0WJIeW8qBnjtY3Gx4WXnKcX2kxV2iwHk7QXvCAUQ3rK2FX3/SM6csm0QAcp/Eg
	6UUNzMkWCL7H49e4kG1au1I+lL2TCpqytRnL1vdwd8fv9ixov1tZ7ym3mOfWv2jUqBAD5kVHUMW
	jsUNaiWC/Mb+mYgGolpy1M7f9mfk3IowRzaq1PxFth0ilXidHWhrhYbgm3nLHjiOJYvWzJZWh3n
	gCxNfpXWpXS6XJbMGlTVECyqncEgfEeUbwuL67f58O75n6/JuDc0E/IdFWmL4PEqSTqUEscTlqy
	W0B3jXjEvgcyhxftE03CCN308i4JtyC5qVnuUnW5uwfRq5VVsGWWM66Hq2O1OT8IiqoBMmHxu3P
	coHvxDV7kIX3Uws9AhywAuUDm1udX6Cw==
X-Google-Smtp-Source: AGHT+IE5Q6T9pvLvPyRy7McqkUhSQviQSdOilTp+2soA933WphNo3Q/lSUJ5/V5yEcSVBOx/08pMRQ==
X-Received: by 2002:a5d:5f90:0:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-429aef715f6mr4386949f8f.5.1761760652309;
        Wed, 29 Oct 2025 10:57:32 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm27520132f8f.38.2025.10.29.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:57:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: add tracepoint-update to .gitignore
Date: Wed, 29 Oct 2025 18:57:18 +0100
Message-ID: <20251029175720.12998-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New tracepoint-update tool is not ignored from git when built.

Add it to scripts .gitignore to prevent including files in commits by
mistake (for use that have the bad habits of using git add .).

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 scripts/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/.gitignore b/scripts/.gitignore
index c2ef68848da5..4215c2208f7e 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -11,4 +11,5 @@
 /sign-file
 /sorttable
 /target.json
+/tracepoint-update
 /unifdef
-- 
2.51.0


