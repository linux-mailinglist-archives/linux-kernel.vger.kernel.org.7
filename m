Return-Path: <linux-kernel+bounces-895041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2CC4CC04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2E9B34F034
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12C2F7ADE;
	Tue, 11 Nov 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b85RCau0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503C2E888A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854344; cv=none; b=TJNYV4jfDFVQpRUmhaTNuBP0nleMpy+w+2Dfbt1eXxHXe81uFlD6C9T1mFRcNLCVUQrNSksjdnZY0xzRHpia5XukfwUw0vuLneztudSfKHxNDqXgWv5L/nx9krtuYhx08T6APS4y67vvheZlLcvOBI+3jdKmHl3uXIOBHFt++xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854344; c=relaxed/simple;
	bh=vRX38p3hYqtNV4pJ+f0GWWM+lW+DqOjy2jgWrpXr9uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRUfRWa+sNmpZCDTJAhso7c/YfURYLdAdQ+53WvSJ+7tKMwAFKfbp1D9eOcUBtiQAfsLjUsqeraRT1AKGE6ocMeYwPyCCmpzsc1ervM0DDeV/jnesD529ryzEd+/XTn87sxFgyNGHQT4U361wPuuXbN1X40dhL2JYYPPqgeouNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b85RCau0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47778b23f64so13936825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854341; x=1763459141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx1nuYFauxNJDsTEMWfhjWhH20Bz5VGt7mVFYSFOM1U=;
        b=b85RCau0FEORtU4I+CIRCQAl7yf34kk+qpeHVa67ZIHkHgyVZrqR1rhH7GiewxfJMH
         Jl2D1JcfZZgI1NMHBc+2v63z3T2QN0tUwyGhOghJhirjsQBqRkl0GxSy6XPdBOrLEj4N
         phyjDSxA33feOxx9crLhj0Mo5yNgwhJWmYU+9GhS03TiKhOqgyA9PgrGp3RrgtAhEZnO
         7ZHzqn+lYZG2HtEEIghLQ7j0LzPXkfj1oZI9Uw3OsOFWoZVXkf1boOETY7ztMp4AVjIn
         Sqhh6ZWjJxltkZZYuUWIV5a/OZkMziF7wZlmDcbual6g2ptTNOSMlTQudfyieWR6e9t3
         r9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854341; x=1763459141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sx1nuYFauxNJDsTEMWfhjWhH20Bz5VGt7mVFYSFOM1U=;
        b=S4VSWw7kU6BHGIVJeskyMm0W3j+XGNaF6jY7OBpmp20OIC/bNKkS37cX5HDMquHLpa
         mr0KpvOu6IuZVHLI+Pvk3aIsaNmUglfiBCNYp0mwR3+J0BwXj0q2uO5TKVJ6gI6odNyM
         CEn71lkwA50rw4GdZxtnskZ4g232SsJWcDicZiZSMmPVYy5j4wOvLkofcomqjan4iDN2
         o3Ocu3hemds54RyaxaeEVCNk5CQbXBFyID6ERdc7y3YYJHIbYtVzyr9mUWGiNmPAqKOw
         erRvPSLT8z8oRPnn1bKySx3JiH2DnvN13EUZWxxwvuYrpYDFnAzS5GYMky7ERxGSAEE0
         5Xpg==
X-Forwarded-Encrypted: i=1; AJvYcCWF56JddGGlNTak+DIjw/XMFOJjl/yKorCwExYanmn4kE6aPM2hYpXkRB2EZpViPg8u+nXj5H1DyLSXh1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVdpNsdX5Ak/odomnJiZ+kjDNs7mxijuOrJuvLkUpbcl1JIeW
	eozB2jpOUtomqkvkO+wi1lr5eCUw0+oQV6XZTmBuoOwlT0+AeUm2U4Rq
X-Gm-Gg: ASbGncs2eHVksNUk3SlEfFIOgN7MIcLHGtA6EqeYuhUvikABQNxzPl+yAqG125pdpS9
	s8PJFDOy9FX0bCCsgL1f9Ddr6bcHzF+FLD9iRi9IT0PpLgE8uyfQrJSr+RlbACQ/FSfgSnCNChb
	JYucHg3RrSIBL/8u1kDZVQVh4ruRPk2T2Cq+s7FC7dseipFV1yFAevk7ZBOHSAPXXfd2ORXMA4A
	ueghEQiCmmbE4ydDi2VPjhklQBATsm+KaUz7/moetgAvEMwGcX7wpf527vh3nnJv1OlwlUJ2HNs
	Gm7bRVMBs1tHR+wHg3lQOA5jhFH9jqrzjCZl0+EataeO/HcFFStD8ACrHP/LqqxNGSPPQv9wtqG
	zm7vwwyVUqFhuyhY6/DWqKtXydLACx1/qUoRtR4b9EtKTn/kD79iwhOOGPF8E1AsSlVkfPgAX9g
	m9OTPBQlj7AQVXealCC3bBRL1kIvcTg7JpeW7n0g==
X-Google-Smtp-Source: AGHT+IHw/mhtNaYuO2ro73JGIgSaJJWHXp7QydcgCGHaCB1mKRIecZ+3XliOUUrt9oKL0TNNycWQ+Q==
X-Received: by 2002:a05:600c:1c86:b0:477:7523:da8c with SMTP id 5b1f17b1804b1-4777523de07mr103912355e9.15.1762854340403;
        Tue, 11 Nov 2025 01:45:40 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:40 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 10/10] MAINTAINERS: Update for gpib destage
Date: Tue, 11 Nov 2025 10:45:12 +0100
Message-ID: <20251111094512.6411-11-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the gpib directory
Add the uapu include files

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df07d1a3c28d..4cb0de3777b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10628,7 +10628,9 @@ F:	drivers/platform/x86/gpd-pocket-fan.c
 GPIB DRIVERS
 M:	Dave Penkler <dpenkler@gmail.com>
 S:	Maintained
-F:	drivers/staging/gpib/
+F:	drivers/gpib/
+F:      include/uapi/linux/gpib.h
+F:      include/uapi/linux/gpib_ioctl.h
 
 GPIO ACPI SUPPORT
 M:	Mika Westerberg <westeri@kernel.org>
-- 
2.51.2


