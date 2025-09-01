Return-Path: <linux-kernel+bounces-794425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE68B3E194
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D350716EAE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F208025C83A;
	Mon,  1 Sep 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NUMNtYoN"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94728E3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726237; cv=none; b=pMQvgJHrJ8QNTLU19CBjTFJFpDoXE/lR9uyzJqST/0sLle/a9jZ2U43nRg6ywe839zMboFOZvSglt9mjotR+e39LfqEC99rkB/1w5fuJpixJzjCRC9Ng52G5vkqolbB+imJJwNGRECbXxMFT0iSmPvvtNCyRJYZ8yh3S2gjfGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726237; c=relaxed/simple;
	bh=xQBZuKZbB14BnMFNO14btTVtg0rspb0g8MDjAzEUhu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aL+2U7Bc6dFD861t3+EakByLHIgnnsDbFlvISW8mAKzNzbk14NND8RA1ORhJRtTPvHtrB0MQ+ls/U/mUoS5WIZ9HnMVqC+HAkKJMK9ahKqgzNIGnbtr9ARMID4bBLRMe0aHfbecWdwdkI7Xdkk9dK4e4nLBuzGVx/dW4MD8ALsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NUMNtYoN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77251d7cca6so882265b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726234; x=1757331034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVH3gE/tU2NrwTFLWPs2VeMd5NnIXGOgVMzKZ0VvHYk=;
        b=NUMNtYoNMfmuR5HtntZUZeIwygWlfc19PnIMS63wm/mF3rWsHC6zdE0aO3m+LKkbJP
         jxeIaCmHeKdbajksvmrK5D7AYPPIlKC/E6wGc1oIap/48HTC8JehRAs1GUBY1denJG1g
         Hm8vqivaPkfedxRU9svzsJ5aBml/iGtJFwWKrtARVlC7AorztWu8w2gPPiUPUPafbjmD
         sZeL3NBa9+KPVmL2kWxfiJphWKrJXsjfTflLQrTZ5Bvzf3oYk38DAfmcENpeHwhHyd+m
         RjSx2I61tPx1zCTbQeoTX1mEzyqd5CQAr6Uz+r80c6Ch1YYPIXmJ/SUbLjJtD1VOqlnY
         OHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726234; x=1757331034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVH3gE/tU2NrwTFLWPs2VeMd5NnIXGOgVMzKZ0VvHYk=;
        b=MwYmVzY+0cA4He/fPIJH0skvYZojk8KZa3Ht9OQxHmU2lDiAHy5wnP5vzMusR/ywwY
         2WBlPm58kllVZvL8DSd7EG7YGCX2RV/0VvkLz4Y9LsrMe5rVOaa8s8JJaO81TuMYJvxD
         RerwN3oQKGkx9oriKoYns0E4mwczaKZCNbGvbGmB1VIo6xbZ3ltIRhIXk6hd0vvHtrqt
         I15oH4h8XXf95TvHpnVUUklMcV8c0dneyw7atqUJilmW7IwkKdOidzFCa6Q8qMzn0MVz
         /E2PivdZCcWLQMhIL5Jk7BmRGApd8jbzwIXDThEXnr5/0iaJmbphj7b0zGdkV2ax+8XX
         ITnA==
X-Forwarded-Encrypted: i=1; AJvYcCW2nRRX6BOk7l2/gqnMxdexsV5OaCF18cdXDcZtW1HohaMRulY0dAWBMYFqRMfBsv8iVMUw4EmcedLSZZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9r81++gn3tUCD1c3MK7LHuqtwYp2ck1cTB+RWcFpwtt318DK
	MjMqjwY0GVphzUy3hg/jbEA5loh5uXlSAJHbEWtN2uV1lQ1l4DCGK6+80Ys8+fIlA70=
X-Gm-Gg: ASbGncuTjoCmEVe2de+zqn/IHHL9JHLg8iEUN6OAhf6m/n3GFzquvMsMEjjWCq8Qcvv
	UhR0eZ/tcn6doqVZSIvuJIPGsGkVlYqeeq8Bi7a9z90k2SAq8r6XLf/eBQYjJEIheD6SANcdwN8
	ySSNd6maJOqQcC/Ip6o8CQRy5v6+M9pe2FHh2uNZ/XGli4zLoFqlzTqhK2X7gVZxMdbzKIVezX3
	Zesij7MDEfPH6zXBdM8Eyd+WgHH9LOjTJlt5zhYur6s01dcxTp4dFlUhStKtkAh9SUULjeQop41
	zm7/+V3m3jqvFg615tK76kcDgvJo7Ip3uuWAYt8lCt6aGKvRZMn+6KtY0+zaFQHDhrdF+Tq/744
	CfcItzHWr1Z64wcZiyjVM+TQlmaDZr+AvMRuZvE/2yC0/j60xTZhQW6vfcIB/BnRVHfQPjIFXj9
	x1vcLZO5PFAZ1zFJ60cNDpGm/7mY85+eVX5xr8MkK4tUU=
X-Google-Smtp-Source: AGHT+IELNeEmeLv/bVJbqXS2DLw/rssPuwVvgWByQkWQ+Dl4Z0Oyw27w9LOsidVAsxPp2930j5ZwRg==
X-Received: by 2002:a05:6a00:1748:b0:76e:7aee:35f1 with SMTP id d2e1a72fcca58-7723e3fcb56mr9285395b3a.29.1756726233690;
        Mon, 01 Sep 2025 04:30:33 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm2911441b3a.11.2025.09.01.04.30.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:30:33 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 0/4] riscv: Add Zalasr ISA exntesion support
Date: Mon,  1 Sep 2025 19:30:18 +0800
Message-Id: <20250901113022.3812-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Zalasr ISA extension, which supplies the
real load acquire/store release instructions.

The specification can be found here:
https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc

This patch seires has been tested with ltp on Qemu with Brensan's zalasr
support patch[1].

Some false positive spacing error happens during patch checking. Thus I
CCed maintainers of checkpatch.pl as well.

[1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/

Xu Lu (4):
  riscv: add ISA extension parsing for Zalasr
  dt-bindings: riscv: Add Zalasr ISA extension description
  riscv: Instroduce Zalasr instructions
  riscv: Use Zalasr for smp_load_acquire/smp_store_release

 .../devicetree/bindings/riscv/extensions.yaml |  5 ++
 arch/riscv/include/asm/barrier.h              | 79 ++++++++++++++++---
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/include/asm/insn-def.h             | 79 +++++++++++++++++++
 arch/riscv/kernel/cpufeature.c                |  1 +
 5 files changed, 154 insertions(+), 11 deletions(-)

-- 
2.20.1


