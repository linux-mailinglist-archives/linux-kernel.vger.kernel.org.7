Return-Path: <linux-kernel+bounces-810263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F93B517F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBDA7B9D58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B63126C5;
	Wed, 10 Sep 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgP8xVIY"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C21EF36B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511042; cv=none; b=c26wiCKNXPHvV5NuDYC463WemWk96fzLOVYxS4nH62M+hTWSd7ng1dF/Cb1c4Wo8j2lB0Q9ektEEtrt65GOgZr+Erc1MWsVNGhSPxL/4Vu6eIXfKruanZfz2zgfSJemfjOWGOqBXKS9NODT4DV5cMkcBaqiMgVWsLbLXsGe92u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511042; c=relaxed/simple;
	bh=+0dvYWW0YLM6sPn0xa7nIVy3l++/JTX8Z40PttWV9BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QwhCIUMfzIW+/PoRaFX+Gcxk9WpA8ZqbW5oY3CwNTGHLucvp5Q/VtNzM/GXu+0Md0MqckN/d5Ed1T2f20/QnhEPvnYOYiIwjuA60RBET5AeCkMi6zjv2577+tLPpGtjtqExN7+bJGA1c177nt32iZlY2+kKO2JIiOseCNPKvC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QgP8xVIY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso23856685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757511038; x=1758115838; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuM5ADDmsvDRmcHroZq1v+E7rFT9yvEbvExVg13TLRI=;
        b=QgP8xVIYwV/VGmeJaGKNe9DitHsvUPGw5AKmErd5k23t723JyS6n2+TaG9caQ+7NjY
         mwwq8xW5WvwROllrlDhSz5RuZshZnLlUwNHjZixH8SqTnSxMJe/Cbiiz909Fru50ksW9
         n6YBDa8sS1KBlJYL1NVCYTEJJzvpusVrSRKq6T8/reVIUx3MbrYyIG0HxTeN15ReWyyb
         twvrH+rYs8rj69AHl9QF78ZOcebZKcV/0BYYcxXmab7wGyQGGw7G7qTdXyW4khAXN75Z
         I+dpE5qeY5wjU0Ehe9O7WdyWUvNxlYkbTiCi0TtSjp4SJ3y0pgj67t8phQrKqV9q2rsq
         eNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511038; x=1758115838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuM5ADDmsvDRmcHroZq1v+E7rFT9yvEbvExVg13TLRI=;
        b=DJ8+Dv5nJJx02UwKqX+W31c6K4weHFS5SGGzHoCPf3lFcQS1gZH0EwKYD8EPoGKZx3
         whNT/HT6V4cC7CB7d55k0Rn8EFvFSatNG3Og3LEP1wZcsl6Oz2Q9nSUAFkxo7D89plt6
         Jns/cbhNfA5REUk/uUwcrBU6pKuRaJS/PSpqz7kweMHLh2A23U9vHpkOpS4xYdCkSJkW
         E5SiRyah62T/5k+4OLM8EzQDPsZ/J3NRWiSpYIV7TB2gizLMVDe/7qA78UeLfdKgAA3O
         1AKgndB0BMBpfh6aRUwcSjWYOedzpMXJBFVuUPAvLplafQGmGnvwrc6TiOUyShtztsAe
         8OVw==
X-Gm-Message-State: AOJu0YwrMrVvK1gp/MP4x0WkGRVrOqbeK95s5TpBdBnh0QCbhscM0tnR
	AdkfEwhKgaSv7BlxkkWCScd4ro4hUSwFaF2FY+IrI5o6t8uSm1CCRxeEHb8pFmo+8AM=
X-Gm-Gg: ASbGncsDB3vSbxQy9L95Y/p54m0rIZGBlKEvCeLY3qUmEJ2E45/n6A3gfIUM78nICvS
	8YWtGuGziOYVfIeqZ9YcIJSQDLtIHkoeO1/1fhJL6gs/DNYQKR84xDUgfaoYmZgIJJafVGUQEMs
	uouiu1KGKAGhy0CxqHV/ZCSX/20oP9nDssZ6ff8M6jhqWBjWbFy48wTRdyL7uOrSJFa0uqO2eO5
	TyYR3ZGqnWqbIbmQNqcPOn55F0fNww+g0BB7gfqAYhgdeJ/70ZxYryVGU197jecpUG1CI5KKO6o
	LaR8QFR6PDUJmSiTnzAXPmesdDtTlMtzUDCKupRkUThPebtrjDI5yjckL9SffnEubvnAPdv5Y5d
	QcTkQw+CUoJ9QCLEh5VavnjV6ngn2NJ+NUHNOUtzX+Q==
X-Google-Smtp-Source: AGHT+IF16lC7AxEoodua5PGUp1T0kiWW7xMxMFTLoAHAXL3Sovft4Oyrs9B7sSnWNkctNMCKPUA2JA==
X-Received: by 2002:a05:600c:c8f:b0:45c:b55f:466a with SMTP id 5b1f17b1804b1-45ddde9295dmr149406865e9.15.1757511038256;
        Wed, 10 Sep 2025 06:30:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm30387015e9.3.2025.09.10.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:30:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] tools headers: Cleanup headers
Date: Wed, 10 Sep 2025 14:30:10 +0100
Message-Id: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJ9wWgC/x3MQQ6CMBAF0KuQWTtJqWDAqxgWY/nIEGxJR40J4
 e42Lt/m7WTICqNrtVPGR01TLKhPFYVZ4gOsYzF551vX144XecL4ldJqPENGZA4rJL437s/3S2i
 8NEE6KsGWMen3n9+G4/gBhkIqVmwAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

A few headers are unused so remove them.

---
James Clark (2):
      tools headers: Remove unused kvm_perf.h copies
      tools headers: Remove unused arm32 asm/kvm.h copy

 tools/arch/arm/include/uapi/asm/kvm.h       | 315 ----------------------------
 tools/arch/s390/include/uapi/asm/kvm_perf.h |  22 --
 tools/arch/x86/include/uapi/asm/kvm_perf.h  |  17 --
 tools/perf/check-headers.sh                 |   3 -
 4 files changed, 357 deletions(-)
---
base-commit: fb96bf8f51698f0666ecd74f7d1b9b394262b65e
change-id: 20250910-james-tools-header-cleanup-93b6c42a4ca8

Best regards,
-- 
James Clark <james.clark@linaro.org>


