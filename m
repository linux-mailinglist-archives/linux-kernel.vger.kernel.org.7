Return-Path: <linux-kernel+bounces-823563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC7B86D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076B25828A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFB31B116;
	Thu, 18 Sep 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdqocagf"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5831A81D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226295; cv=none; b=a6O2gt6r+6F/HhJ+l7QETZQOsYbgYkuCjAbXhcQ1+t5afdL2zRKsoAAkir8wvLfABwKlsB3ngr7XNZXW3ohwzaNZktjpHs1vuCfOMoCI8HBy0veOFySWcs8b/ZNt0/8WAwTLWe4n5RmymyjQVvoSZVlTVIQ2As1nM0mP32o1bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226295; c=relaxed/simple;
	bh=rj45hXAuQZ5pTnKSdEd6dIpPHRwyw4ZKYgOKQst7uXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7VeU5CBqkeVg4djDt/fLENQQHTi3MCSRpsd9TjC0kZ+Z/qkTlc+yszHmkuhaJEHhDxRn8zfi2Wf6Hlk/nPYaLM22gLRzUX/i7nt7Af65fViTRAy7FN/g7nfenu64Uqimb6KIYISyw5uH6C8Mg7PyS0c96muC1B6M6Hi++6nG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdqocagf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8112c7d196eso132228685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226292; x=1758831092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maHjhLKuxUFHWOYvJSC8J0S2l4myVpbFT09XkbzLKKs=;
        b=ZdqocagfsQol6m4QXLM2V8HOsZHq19flBcAbXHHYZab0NQBs7gkOwk+8tjSQhrKCqk
         +bD5d0INM556A0ybpzrZHL8axb0J+SEjYprGLXyJ9/OuzgOt7Qp2RyGnLb9JK4Lk+a0g
         xwoArrajBUriQnqumrcRNxI2s8IaZaome9gWwsvHNTGKL0iv7eDNnxkmOihRmsAg4fFD
         OYhf+UAv7mqmViYIWGSQu/wQVl1ePJLFkoWxHOUxI8hgxOj/IsR0yxv28AuI/RQvTZFx
         MaEzOjB6wlH+Um/Kv2qTqErpoIe7oFRYKBW5FM1BU8Tg53CW1DPXixsDiMLYVi1V0oDi
         /5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226292; x=1758831092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maHjhLKuxUFHWOYvJSC8J0S2l4myVpbFT09XkbzLKKs=;
        b=gtlivK4G1y08pBXOnWkEzEZY+0Ea3IDbHy3xWZfOT06r1mwmL/31+tDOTUteDxjXhj
         kQl5AZgw6vCTItz7AzDCeHwx/KEZ6X07mCZvJzRYsLnUiYbwfS8sL4tLoqIOdQ62n4Tv
         FNfP5l2o2aewjvDEp6Z78+l7vZRJSyKjcieUYA3gGd0qRa3VmK7KPhWp9FHNq5ggofiw
         Gs/UPkhdW1QH9HD7RkUlvZciBl8kRuilrRmzglFLMVwdH5+N8BC1OO6Ylrl9ngJArb0O
         4/gd1MAA+2H/AobXjESkdW1KmV8HshpdeninYQ8CnAHVueYHUrdeNVemzXCXWiv6GZlW
         T2rg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/MhyVliQFT2M5cNS/QAU8orm1J2eZfHlYQgjTP4yo638mkNvQLDzNuMUHm/8Dt+/qLE10vo24e8P7s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0PszNZB/G0xwP156M5m/E+0Sq1o08kEBoYut01ORPoMEvcdY
	w5TsK6GNTAzy6bRy4Sgc2jyNbwhCdqv+KbFk7jUcF7F13uRW93slGEIT
X-Gm-Gg: ASbGncvqn6UgUlP10paG3oZ3i9/OJeOtHcxgiWbvst5S7ByXIH7X659uUYb0C+7LyWs
	WAHngFgvb6lwzzZgddVQ5r1N7FJEg9JCSP3VzOARqErCCBAajo2IHdjgBk+6K8nJTmFCYo7W1NZ
	doxyPW1W53XeNqZDWh0P21M9plEwXO+iEwNtwuYDRwwodolj3pPhSccTuQrd6wIvDjvMYIt0nT6
	hU9BxuEdKAiOgzCVre+HjxHbKIzohAnwxAK3J34tlv5Ljq4jX5hDzCNog0Xe5V3c3N4RVcfmA8D
	68nEGWVFdtz3Xl5QMeV//6zNm1zADQ5O8XffHf4iNT0k9TK5HMYAmiTEegpjC4XmSNQuOJ3Ops0
	yURUuxoQJZWseETaq2wrXwPIpMKvn65/mv4rctvRtJuLp
X-Google-Smtp-Source: AGHT+IFvvDp7Ar1qMFe3+qwycti8v0Ty9KaWDdNlFOgYJ/Wwcr8nmVuDHE8u7R3rXU5g7QLgSdPzbg==
X-Received: by 2002:a05:620a:460d:b0:82e:ce61:f840 with SMTP id af79cd13be357-83bafc2cd5amr86408285a.84.1758226292371;
        Thu, 18 Sep 2025 13:11:32 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:31 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 0/6] module: enable force unloading of modules that have crashed during init
Date: Thu, 18 Sep 2025 16:11:04 -0400
Message-ID: <20250918201109.24620-2-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running a module that encounters a fatal error during the initcall leaves
the module in a state where it cannot be forcefully unloaded since it is 
"being used" despite there being no reason it couldn't be unloaded. 
This means that unloading the crashed module requires rebooting.

This patch allows modules that have crashed during initialization to be
forcefully unloaded with CONFIG_MODULE_FORCE_UNLOAD enabled.


Here are the costs:
 - 2 extra pointers stored in struct module (if CONFIG_MODULE_FORCE_UNLOAD is enabled)
 - struct idempotent is allocated on heap instead of stack (regardless of config)
 
I had to make a design decision for cases where another (f)init_module is
waiting for the crashed module to finish and delete_module is called on it.

Here is an example of the behavior my patch causes:
> insmod crash.ko # insmod calls finit_module and crash.ko runs 0/0 in init
Segmentation Fault
> insmod crash.ko & # insmod will hang forever since it waits for cash.ko init to finish
> rmmod -f crash
[1]+  Exit 1                  insmod crash.ko
insmod: ERROR: could not insert module crash.ko: Device or resource busy

Here, anyone waiting for init to finish will receive -EBUSY upon removal. 
This is true for finit_module and init_module syscalls.
I chose -EBUSY since it means I don't need to modify module_patient_check_exists.
error -ECANCELED might work better

P.S. This is my first patch so I'm new to this.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
julian-lagattuta (6):
  module: store init_pid and idempotent in module
  module: detect if init crashed and unload
  module: move freeinit allocation to avoid memory leak
  module: move idempotent allocation to heap
  module: store and complete idempotent upon force unloading
  module: comment to describe a new codepath

 include/linux/module.h   |   4 ++
 kernel/module/internal.h |   3 ++
 kernel/module/main.c     | 112 +++++++++++++++++++++++++++++----------
 3 files changed, 92 insertions(+), 27 deletions(-)

-- 
2.45.2


