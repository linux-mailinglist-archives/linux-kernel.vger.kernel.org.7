Return-Path: <linux-kernel+bounces-861143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6BBF1E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11DC1895F21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4C207A20;
	Mon, 20 Oct 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NFWEqb/4"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832A1F4180
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971291; cv=none; b=YIyLIciAwvnYNLbNb1HmmoKrghLfkZWeD5PK8YRAINRtAMoXG37fL0ptv2wcvw+czIZ9ilpBINisrSbdMitR4IEVj8EYY8HwkljdPKWhqcF8bgn7ERbD2SaEw22TT1q1ZpxyE9MgZwG9pB8cuO1Rm7iKErEk1YC6+hPBMJ6lG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971291; c=relaxed/simple;
	bh=QICUxYp+L2zXCEhrHqlxOoYFROcbNU34PpfOB7sStyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RaOKFe1UbK7gKn8p5D+0VNmy2ftCa+F7xEUt0IMKsETDzGgq4xqpy9b0O/QwaA2mtUrhkPxKiaqY0rzZ+RWs+/nI47pG1NrVrbrc6pgc3eVpXqKle6/22EEkvOgVf/T7dYJjsPQlr0v+C5ChBKcwhuX6M9f1MZJa/fPLTn9U3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=NFWEqb/4; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47109187c32so21160695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1760971287; x=1761576087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYPY6D0JincaD+faD7f9Zc4BXEKrjLHqDj6P/RcgmrA=;
        b=NFWEqb/4+GcJrebXC0riZXCZBReWKpNpRwsCqMeWGyJSKg2zlQ64JMJBJ55CqNHGWG
         +X6yXX5455x60nNys4VWpKvdrL8gP+NOqjThEGL9CCWscFitHdCirN9kAiQJoAWjdmVB
         1qLJZ8EbBUjWGBecD5WsZV3jlSPL0cglpE+Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760971287; x=1761576087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYPY6D0JincaD+faD7f9Zc4BXEKrjLHqDj6P/RcgmrA=;
        b=kYMCbqY/D+/hLqrsA/xY10mI7yGAzHAWG1ws5yTziuDZVJhLcrg1NaHt+Ga59dv2f6
         tYBv4Hd0fWVHeTYsjPh5yJfw8xEg/+1chsV8s49vyuKxCfclme67KKRYCVCCO9HFcWnw
         4D1dlamf36HtNOLzIV2ZONW5Aaif1QOzeQvmf+WBERKwFZwH0NKOHtUhx/xCGEPW+dxI
         2UMg7eNz3QK+F10gNRKn8sJdeUJuczwJZ4U/+ebasS7piA86Zvh6IwqVhPbWnXI/Uz1x
         sOdP5IjHyJV1GDRpqjsEZbGZflYExjv/pLDdMoifTjOFpV/3gbiABvJ8R7qV1VoDNhbf
         kdcg==
X-Gm-Message-State: AOJu0YymLnIOVWwkPDjH5GjQquWQ9RNChXuvB5/uaF7nUTUvXfq9kFJ9
	wZxG/lB4PNrv5oeLzvcFj1iTFUlsxyOPd8SOB/U20nrHzJqhz5Hlq6z4E4WKpiO+j3AGXqeQaZq
	jXB1ivuJAB6Lu
X-Gm-Gg: ASbGnctneBqwbhUStK0uz8dHbgmOtaNwswg7vlkOytNOTNFsrHnMQb/uvNsxnWpdmoz
	yTRGWWVINZttScK3ELBIt3RImfYLjrFfA8yNOMozgd5zeGcFqnKsdg+lwnFjchP94gqVp7wGtN6
	n0/MhDtEMUUOOlaq1oTS7/KApmTNDsH5d5JxSzmZ4TQ/oOd6Edm4IT3GGHwZ92UTYXVEVnPn+y/
	qTY67pT+3Dp/wSXAzNNfGrKyFPYfz98+Room+7WJZZZBhbiXmFTDSnwyhxz9/UVcvELzOB8cIJJ
	8VQKRxf94/tAJt4yHIV6icWU+y7Xacu88VFnGRjppYepL27kC5ePRPimwjgf6vUATHiXgZxtLsL
	nPmsrnsFMYPPT7Js+qjGTyLlv5l3lFLHGYeeLanKsSeUgdbimjr2mnABkA8G8YHFn/S18HKZ1ds
	E5krV0bmGRzJniOfHbf8QaqOmdZkXJChFGo3fmU5DyFVsgqTGnmaDcCPWygWPlMA==
X-Google-Smtp-Source: AGHT+IE1uVvj21X9Dl1QxnNvRaU5zD74D5dHfFOu6BL6rH7tsSsn5P4On370EsSfSTsI/mq+zRh7ag==
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id 5b1f17b1804b1-4711c487d74mr62394265e9.9.1760971287192;
        Mon, 20 Oct 2025 07:41:27 -0700 (PDT)
Received: from localhost.localdomain (host-78-149-11-196.as13285.net. [78.149.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47357776ce3sm30789165e9.13.2025.10.20.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:41:26 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/microcode: Fix Entrysign revision check for Zen1/Naples
Date: Mon, 20 Oct 2025 15:41:24 +0100
Message-Id: <20251020144124.2930784-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to match AMD's statement.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7033.html
Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index cdce885e2fd5..28ed8c089024 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -194,7 +194,7 @@ static bool need_sha_check(u32 cur_rev)
 	}
 
 	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80012: return cur_rev <= 0x8001277; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;

base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
-- 
2.39.5


