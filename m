Return-Path: <linux-kernel+bounces-869549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E93C08257
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F1FA4FB25E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2582FE566;
	Fri, 24 Oct 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gl7kqixm"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61782FE597
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339934; cv=none; b=Th1u5vjwxmnaypa3P6g0brLIq9QTsveo0Au9+dxGJeKn+do0EWXghtrkmTzTvRnRh3Kt+NouIdr1nahqCTqxPfruHgKgpRaMnQdIk+mOH3EaOIGguMagmANcr5wZ3EGmcC5Pdd+21Ei+UQv281cqB0A42u1KY8Hufj/SdC47v+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339934; c=relaxed/simple;
	bh=GR8vGx9QcuyzlnuWwnQyINXnx42sczidTEfEcLBemfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LfqJJWyXKHHZPaYOyEdttRNq52I+fepERLCqkvQk6xiDcsWQJW+/EPF5HNVEdGQj0ExxPYLMh/hez4qwP6BSnmtTQmetAF9yg86/C737zMz4evkoCTqcObEO4NZLF3t2dJ0UhUXAp60jYYDUUftKRf8Ov2VaFCnM5J3ziOm9tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gl7kqixm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4256fae4b46so1514500f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339931; x=1761944731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T3YI5eM57RqyqbEDMR7KooO+xOjSR2Ak5rIAHhIlRyY=;
        b=Gl7kqixmYRmaaZqIClw5Pxj+fpDT3sITmU+wv4r8vuVo0zi8XgKr5xVG6bbtPmCein
         ht18IJAg9clF0BaeIpKcNPxWZazcrtmSkDgsmA4tPvmCRYfHOE9pU8/u3JdGwz6IlM/3
         94UKY63BOfg7XArRVTSU+nfty+t/MBx77Hzz1ClZvSC0Z7F/PyrI8Dsq5fTm0oE+aHY3
         ATFlm74jJfhpbG+SkgOG8ETzyZIVwphQaUvGKDnHmXC/X4YyvotZhxzIuswdaKkLUB04
         /WSkMm5Q6OVC+gJSwAJp7B+kJqA0RjEPz+/xdQjnPDT0oXQ3ub5NvWg1NW4JwXwCpiRU
         lUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339931; x=1761944731;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3YI5eM57RqyqbEDMR7KooO+xOjSR2Ak5rIAHhIlRyY=;
        b=dWIP/xPmLVhrF+tIfbdIrbremJ2wddo7dUaQWHcR1k5n5ZvxXlN6fHZ4AhqXzjgd/g
         9SwKcN9qHgOX03LBLC/FeHplMqcxzUhQ9/lpVNm7yyQl6Owp5eZgQNEW9uwhh7P3XMTE
         EtVobChl4aiw/+1xAqkPmhwodb+BRiGoggSGPZzBPsneLz+KkjJuxQEgUy0X8ZuglkG4
         B0YhxeowF7HCU9QyVpmu3K9OX4CJuXvfFN/TEi0lrjw7TwHKvk+dOmedSMEz3K4cMotc
         ZIFPysjr7Pr+DPZWOVOtN0PL28lyVfxKAuzy1CuY44J/1e+0wKO6OrAfuWI7X8EF2iLN
         Vuug==
X-Forwarded-Encrypted: i=1; AJvYcCWGGcqJy0KH8hqNGJfIlRDayS9TofZLdx4SxX/dMVlirwzJkCZ3MiXmi/pxNU9/pV6TGzfpqVdRRsrLf1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUV2pVOLZsK+fbeA6hOXQfJPi591aCHqfG6+AuCk2qQkIPWHX
	TNliCwJ3VYaWNEyoiOyIetYU7qXFzHUZDM3oAP4rpvtKPBPeqWzWoFAUgfPzur/7do22ZKrBplq
	PVhY4Y7FTDWlhBNbjQYl8hQ==
X-Google-Smtp-Source: AGHT+IEDBqFflHgl/gW/+KklR8SPQ/ktyy9jGNLtSJYZsdW07iwdQXTRprPA6mSiDkYJURLlI1bHDRD111BgD1be
X-Received: from wrbbn12.prod.google.com ([2002:a05:6000:60c:b0:425:f04a:4d8d])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c6:b0:427:928:787f with SMTP id ffacd0b85a97d-427092879c8mr15711106f8f.21.1761339931205;
 Fri, 24 Oct 2025 14:05:31 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-1-mclapinski@google.com>
Subject: [PATCH v3 0/5] dax: add PROBE_PREFER_ASYNCHRONOUS to all the dax drivers
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Comments in linux/device/driver.h say that the goal is to do async
probing on all devices. The current behavior unnecessarily slows down
the boot by synchronously probing dax devices, so let's change that.

For thousands of devices, this change saves >1s of boot time.

Michal Clapinski (5):
  dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
  dax: add PROBE_PREFER_ASYNCHRONOUS to the kmem driver
  dax: add PROBE_PREFER_ASYNCHRONOUS to the cxl driver
  dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
  dax: add PROBE_PREFER_ASYNCHRONOUS to the dax device driver

 drivers/dax/cxl.c       | 1 +
 drivers/dax/device.c    | 3 +++
 drivers/dax/hmem/hmem.c | 2 ++
 drivers/dax/kmem.c      | 3 +++
 drivers/dax/pmem.c      | 1 +
 5 files changed, 10 insertions(+)

-- 
2.51.1.821.gb6fe4d2222-goog


