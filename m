Return-Path: <linux-kernel+bounces-786863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE680B36D23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CD95662A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F6223322;
	Tue, 26 Aug 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kvfyShh5"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7560202976
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220272; cv=none; b=A9APvFAEViNd+9hkGt4CeYoDztHQyv02oOUvAdaZIVVA8CXNwWB356b8QMRz0FkSn7oDsI8qwsO16vkZo12oW9UAUpOKhn8K2o0+/TACuhUYl3U+DVa3bFlN1FvdOoCNCAzUJa+AEofoT2fct7/5I+vE/1uyM1JmoGyFtIg4/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220272; c=relaxed/simple;
	bh=oV66E/FpTLjjTr3Wt2H99na0JCk/nu8E2dyXtOJL8s0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPkg042fIZFLB8onn7aTWbhbU0Hi/OvWgsCAgyjRZOWL+DV1LTyLxlZu1tzNVEMdhCdUsiya2JhFx3fFSl2+EPa5rnqVW/Fxx8Y7cAFXz8nDq3+UpXiYe70el/w2SE4H9NQESwIaQvI58ZETb+FKJHuefZcH8GjGnmpnaosYFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kvfyShh5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso3058881b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756220270; x=1756825070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/rODbLEiDc80ZuyhKo3EG6WxWc9OtiTJ41MRtq3bqg=;
        b=kvfyShh5XCC4RcQQ7IVi9FH4tsglM3Fg8bd/aRFLV8FrVVcZ8TCmUnC9/Re+FEqIJ4
         dnZk0+UDQUdOktst2oBs54FptXclomwpmhi9I3mrtyPEB1tZLvTlG8kdwNSDXhwXwuqm
         OhODdcrM2lMmNAF588wwhcKE6AGAftrt8hA+Q16TcQNvfWU19hoSxBtMtBQ9RfCD75he
         zEVOl3ql+xEPGL9uotaxTLVKYT9nriuYjcQt0QanWfHlKwqlC5SltoQ7aTNRdjEgDqn9
         i2bIh5C5AVdyAJhPMDMqo+UVHv802Avnr/vL1XLFAZi/l/tTjYxCT36zFplxjxukA/eS
         3dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220270; x=1756825070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/rODbLEiDc80ZuyhKo3EG6WxWc9OtiTJ41MRtq3bqg=;
        b=ZKiB70QPxBVCXnaGv0BGltD9F1+Upa6goAF39QqIOjzgE5ZCqOtE7uyy/+OAaYikkT
         rvIqvRwx9GS3QPu++hOAVrUEzrVmFzrAqDUTv1eTdjO9Ktj8OzZHRVex/XLaYrl8YyVL
         12z/EW99Bnz66D6ucV5Lh69MBRwlYW/JXzrs9NZmfxYasocuhzBkTY3SKQHd6tUlZ961
         EzUkAEmR79EUFCgkPAPZ6rMvzvc0v4XnVEQL9f5DS1KIyfwpCMw89iE2L5BjlUu7CfDS
         GdpmltnTlHYvQestWoZa4r2M9BFSxra6XVxC6diXN6qOhvH7Sf1GEgilqsKZPylC92GJ
         zCNw==
X-Forwarded-Encrypted: i=1; AJvYcCU1iwyWGiRbFPbAy4DgZnyAChwfR4Y92z2keJ/zg+sgGJ4otAR9dtqZSzkini8BmPkk9oxYz8Gn4lD3fhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjVsDW0iTQVoIj2ZqMMtvur9loNK38hToitiHbm8WrOQGEyjJ
	+x0r1qmUe/rRLKWQO0A0RlahuSMfoyQPMlY3Lgm1jpmdrtiiPkm1RSqo0AEeZtHAhZI=
X-Gm-Gg: ASbGncvY4RPWYAIuoWphEmxJFcBVWDHAeWqfjI3yQV2gGZY4uG7nrboGQVm2gL0xL36
	54w9IeQU+WltKwiZqggL7wcvU6ggc2yGc0EGDHu6wrEh0jTOpHRqY9Hvl18479IXvb5fp1P+uaK
	7SOOsTSltOIvGvzOksTVz2UOm/buHbI0c61ZvDTZTo0v/0PqhV9MJ5SMgB2puqNIjSko+Xuv1Eh
	heiCyKLIKFwZts31qdffPWm3v45h50ybDZxMBgArM+PHn9XEeUOj6L9f4xlV9zzXqUm0Ln0Ys9s
	rl+vYr6RDUMcRH3S+/vblazKA+2yMnJqUQAy9afOeb5H6eyokyr0FY0MyTpoMFP2eKm4y4XzZns
	Sb1Kq+9/nPI4USflrAaVoBanK3hy1T5nuX+j5Oy28SklYnCTV4nTHj+GVdhOiObsfMmY66kqSr0
	jzbV1HSa2NXLyTzmdaA2iFK5Tjlir8zOSxOSdL2JTCctE=
X-Google-Smtp-Source: AGHT+IEIXIQmU8wp8qY4XNiR6DcL8rQwXhPcaNjDBrRolp8ux1+qyrgMhseqoKwxG4bdfNPzKoAmDQ==
X-Received: by 2002:a05:6a00:990:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7702f9d24d5mr19346689b3a.2.1756220269806;
        Tue, 26 Aug 2025 07:57:49 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7209799b3a.1.2025.08.26.07.57.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 07:57:48 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 0/4] riscv: Add Zalasr ISA exntesion support
Date: Tue, 26 Aug 2025 22:57:36 +0800
Message-Id: <20250826145740.92276-1-luxu.kernel@bytedance.com>
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


