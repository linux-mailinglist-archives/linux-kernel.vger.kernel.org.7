Return-Path: <linux-kernel+bounces-774389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A23B2B19D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AA77AEBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC7272E46;
	Mon, 18 Aug 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEZaPvir"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C53451B4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545292; cv=none; b=bNTSE4JRnYk5112MG4/O1jqPrwYYl4y1FW/ZRFuA2KEQkSdcvKsNmtg9+jzpcGjkB66rrGxDR7gDtHgOQUCq7WZ7G+ACau5lSJDdqJQZMNdXNa47IvoBwre5QosyNxqgvP+gitpiv0qonuF55KLNQUDKNJo+Vyq4OpHvQ4X7xV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545292; c=relaxed/simple;
	bh=YFBoCVch8eqMXndK0gyZ4n06EWvxHmxPzDgY0J4slFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNMXbxSW5APfA0z4M87R92mpXKTA5L4AjQGAAVDLSFPCEwlfSBgsRGY5ODT4bvLvLAP6tiK28bkbn/9caeiBE+fNIeUw56wTz/UrL5pFNO+40TVGVP3bQI6CShqPPmKd02FGWnLIqpp9RErLUZvkRTKLIUoi/9WIu6IeUX+/4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BEZaPvir; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267b98a4so3871602a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545290; x=1756150090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxfd31daBvqbLABwOMkfiAIHr4QY1nOru4f7dr2Usaw=;
        b=BEZaPvir7LUTjeXAdm1zsMtNieSq5AXEEOYc5HY1omCXABfTt3A/s9Ip9hHxzC4dK5
         m/VcMrSMMHaoefIqEV5hju2OFn+9bFWtbyK8I4ftEbr46jvTP2kLmXEjKKdlmDKFw28/
         AYnM3/xzn9HC76ZJOqzC4nc9XBDogHVQuflh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545290; x=1756150090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxfd31daBvqbLABwOMkfiAIHr4QY1nOru4f7dr2Usaw=;
        b=sTsxzal7QdTOfEXry9V+H9gr8XSY9zTicacez6f0QaBqWT5lyEZAK8gqIfaXwJkebg
         6EhOwLXaZXtBAJ78xlCGssrfsX1qh68mkLJpJ115YaTPTB6HzEIDMcwhNtV41ChSmwt4
         /AvBO38qbOtOAvCyQ7lkhu3qkBat+liTqrO7VflmC/2zDgwJidlVVqcjyPpTKAs0z4tf
         5QWRAL58z2VxeSYK9CeYmygLly88wSLen5aJmnHKObYv/79bZcOCQYg8oQQxKC7MFR7z
         QVkCyIYYMCcUF5qkWdihQRiBuC2pa9jx/tUCbGC5BPm0xA/2YVnBbSZ0MDwrPurTKlq6
         WRow==
X-Forwarded-Encrypted: i=1; AJvYcCW52UX8cCHDrAIIl1DA+I6wY9RHY3ovo4PJO9q/bJH5jefPlZQkzGPYtk5GDKKWlyta7pVm5uoiJM0++7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+VqTJrflLFtOF77diRtMi5LfMsOF2WQiVi6QiyLDH0zycz4k
	p56be/6DECVC+X8ezAa6VogPD2m8PqV6eXFpxm1XwOWv4xZNbIqcXqScHNVWqLtghw==
X-Gm-Gg: ASbGncvxzp3QZ+a/7paR/kn9vbz2hcbEMQND0zweCOHwezk1Gpxb/vwGhBYcY7pM6/X
	WdwA11ZoW1m5JvfFk7Qe/gUlE4X6cborBDjmM09oEaqftMGYu1uklz79C2SkgmDd/2x0wz80fDy
	HP0z6WkW5DKIcg/enxJvsNn3JbyZOCmLLJOAOsqMfVadguvdExFNgy4fDfhmNSjfi1+SIEo3MxA
	emErTk0qGOGa0Y1qE7aBeZZF/tSRQbh/DneK8soE2gt20TYJt6c3nJxwGs9GgCHws+mjhoocNzV
	csZZIaG5GLtN4mWcI5lEBbPcvvGkphVT/ea3aK8/wR6g96MPg3r7o7DpF0/ZJpq7N3aFyfGDksS
	i2ps6y+NOmlg6EaggLXfOMjIehkD5YC2JlLmVBH935D+bI3R8KBzIP0UqTmZX
X-Google-Smtp-Source: AGHT+IFM/NaQy7mDHxnyZrxb3wGlGreUvlaIt8ZmRUIFMbKk6qyKs6u9+nr5cCA3h4opb/Kh4ta2Yg==
X-Received: by 2002:a17:90b:380f:b0:31f:6682:bd28 with SMTP id 98e67ed59e1d1-3245e591ac7mr97839a91.16.1755545290079;
        Mon, 18 Aug 2025 12:28:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3237e415f64sm671475a91.30.2025.08.18.12.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:09 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/6] genirq/test: Platform/architecture fixes
Date: Mon, 18 Aug 2025 12:27:37 -0700
Message-ID: <20250818192800.621408-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new kunit tests at kernel/irq/irq_test.c were primarily tested on
x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
architectures that throw complications in the mix, with various CPU
hotplug and IRQ implementation choices.

Guenter has been dutifully noticing and reporting these errors, in
places like:
https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/

I hope I've addressed all the failures, but it's hard to tell when I
don't have cross-compilers and QEMU setups for all of these
architectures.

I've tested what I could on arm, powerpc, x86_64, and um ARCH.

This series is based on David's patch for these tests:

[PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/


Brian Norris (6):
  genirq/test: Select IRQ_DOMAIN
  genirq/test: Factor out fake-virq setup
  genirq/test: Fail early if we can't request an IRQ
  genirq/test: Skip managed-affinity tests with !SPARSE_IRQ
  genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
  genirq/test: Ensure CPU 1 is online for hotplug test

 kernel/irq/Kconfig    |  1 +
 kernel/irq/irq_test.c | 64 ++++++++++++++++++++-----------------------
 2 files changed, 31 insertions(+), 34 deletions(-)

-- 
2.51.0.rc1.167.g924127e9c0-goog


