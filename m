Return-Path: <linux-kernel+bounces-791630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7E8B3B97A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEE97C08D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD66315760;
	Fri, 29 Aug 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h94eX1K5"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB23148CD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464881; cv=none; b=syJqDjEufa4CNiBOtbWNrY3xPT8d3UtlcCuVgDQ2hbd3Z4ju9vbnoV+o2LWODJjzh7CmQ1yam0MWZRLiVcwWQ7eKR1/tX5vPnFEXTAr/YoZGeSR8j0MHTM7ICV0kC6I2d+gWM5WbPu6ozbBW1bjQJ9o6ABD59Qr1EGC8WhLrq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464881; c=relaxed/simple;
	bh=so0KS5+HKtS7bLgo8wlIBPBrMrd/uZF6z+PZRF+H0bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrjfBbelFg7ptoI5O4TL5JaCxA2I4RgeLhycDas/Cr2CWeeklmlc8vbfIdmwM2rQvYL1Xi8LrFk4F8ejWT4ODn5nK/YoGcDHrfpaxGtFHuKhs0pI3oqm8F34nyztFKW1geePDLmnYAUJ/2+IpTu4hutc2iOVSgevYB+Uag3oyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h94eX1K5; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cf12498799so446585f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464877; x=1757069677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2RLysX4FvFaZxrrpQCtMS5piDnkGHi5CdyrEUjW23Q=;
        b=h94eX1K5Wxx/ICOyOMU2fJj16skwRe0a9i0pccb0ZMRC/3GLURFA0Aal8HOHLNX2k7
         H6YJ478Y3YEpC86P9BvjP4C6l+EPWlc5q6gPOVKdGeB8SNZ9MQUVkuMCTwOjEX0RLPop
         3ilypXLnkPuLWkvGkTnssu99nIiFCY1db86yiqoDE3YdcZGdHV4QzBgbsGU/itBis6sg
         I4+JwUwXjCS7dOhQRpZOAxwX1u1HSLWCi7QI7msNV6oIckQlVZGjToKUCAOIVNMQkXGf
         mKNje/UtkF5PvsO3sn2a6PF66VjnLsC9nF8mrlXeC3BzG028wQ03HtSjlwHJaDYWruKP
         TxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464877; x=1757069677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2RLysX4FvFaZxrrpQCtMS5piDnkGHi5CdyrEUjW23Q=;
        b=ChHa8Pg6VL52jWxLEYKPD7kbMTdKAea7r8eUkXNRYcLwlr7LHTVBcXkY3FnG43Ggsa
         blT4QcDPeshnN+vrLvKXDlZnWXQ2jm1l4AZLkSBv2weJhrR6I3cwZcHo6q2k8yqznJ9j
         LU3p90l8CheM4dC2dnBngkeJfCF/v6xvTd1eseURtwCDYo85uhrlyQKnUN8TzYafVh10
         wM9HMYhbXhCEAcPeoVxJ+l48o6QnAvc5jhZ3muUfO2c+XtZ9LUzpfl5jAqcgYM/+zxk5
         q8EK0lUgUcUmphLiz0NVhqX4Iy/SMq/fqMliSiNqwmNkqiGWKNO43GOv0i5G/J0unrbl
         S4ww==
X-Forwarded-Encrypted: i=1; AJvYcCXrR2mzMvQG3q4WM/xwSyQa+ib4BXzq9rH7rakLR5eU5jgOBiqRC9ukPrFyICrFryxsYYtQ4oM/RUGq1KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwe2V+K6iwXGMgcvOZU+fhtxGOCwllWdySNc69o12fX1HesTEp
	Wt+gJ1bSPC0Cm2AU8iDstPH4dM45niuEblw0l0zRosRTLCxPvkHZE3pvXSQ/pTK12tAE7ug1stm
	puDfkNCfz+U+5sRoHzA==
X-Google-Smtp-Source: AGHT+IGn0Rpy1dY1XrZvELEcqgT8iGR3jz5ujSyOBLj7FBCWbv3AUGiqUNArS0IwRoFyThmIfPNLn57QEPEFlW0=
X-Received: from wrbm25.prod.google.com ([2002:adf:a3d9:0:b0:3b7:76ea:26cd])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5887:0:b0:3b7:88f5:eaae with SMTP id ffacd0b85a97d-3c5dc542ac7mr20449959f8f.39.1756464877398;
 Fri, 29 Aug 2025 03:54:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:16 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-9-sidnayyar@google.com>
Subject: [PATCH 08/10] remove references to *_gpl sections in documentation
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 Documentation/kbuild/modules.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..f2022fa2342f 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,11 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
+	Exported symbols have information stored in the __ksymtab section.
+	Symbol names and namespaces are stored in __ksymtab_strings section,
 	using a format similar to the string table used for ELF. If
 	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	symbols will be added to the __kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
-- 
2.51.0.338.gd7d06c2dae-goog


