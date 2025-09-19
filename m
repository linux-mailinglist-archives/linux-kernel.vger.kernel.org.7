Return-Path: <linux-kernel+bounces-824143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BEDB88337
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62CB16B8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036C2D24A5;
	Fri, 19 Sep 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q5Gux1KW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C05B2D2383
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267452; cv=none; b=MtnV7GKvaxuqK8rqGjviJ47c3inhk9JntdUbuNKiyt55pw7hu5jU8Xq3HZ7CbYMky4gzIQf47t8/ap5tUorx6KKANfUuyeY5Ca6zUlbez7wcatkyrA/6BI2cQ170RNJzKyrrI+XQCDug7h1fomKYopsER4Pll2uFW5TkXx85Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267452; c=relaxed/simple;
	bh=v3TxNmA0pt+Qtmfll9ALOjz7DGAewRAEWKdgH99GYDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zb/K6WCHdxlsSWIiEKFFgsL0TS3oStovilKM7a01J6zXD8fE7ADGvHSYhPm4sd7msiY+cNGcT7qdfeHPxHZY+Xk5QJAz/aMxHtgmeaiGC/jCEgNZxEDNCIjUvC42xUhr/aXnHPSUi2VS3DYcoAJToXg8EwY9oazHVK7psN6rO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q5Gux1KW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b0434101so1602106a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267449; x=1758872249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQi8kkf+E11TPqHviak6Q179Pwf94vhIPRCTAWlGN3c=;
        b=Q5Gux1KW7SwDslGyoFa7nd+K6JD3SQE52hUrRe3t23xylhZS72lTewgKtnLKDQuV+q
         M8/27673o9LgfZREIB1LbcGdicp+9gmk4rn29a70ERVOq8hiveN3wglytXZOndSEBAhZ
         oiVQ0S0X2qpDdS2ouLMD/dQ+4sy2km1v6DiY3DslT7mi7Y0D8THVqo5btMfkuDK5EVOp
         W1UwadLyDyQUVWGMsBahMvJ4ZDdbwkF0EwzPbMHePOFWe984ME4Cj6EllH2SaVduxoSy
         RDe6sV8KbkUo5s7pNzGTqHQ/eosWJr4jGrVBmMxPrKLWsZjiMVOiAM8xv/IRaHmcVeJu
         jG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267449; x=1758872249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQi8kkf+E11TPqHviak6Q179Pwf94vhIPRCTAWlGN3c=;
        b=BoH/s+mH9yHY7C5kr5qGP4qhEhQSyRujPSzKeEchrwg/77EpzOswoWdsknyX26C2Up
         HwiNpsdFJy1pqrhYWYLzGtadOGgMgtuhlxHji7ty3MJsS84+vMgsRfNX6VFB0WdTfVXv
         8LmApODqsXCDd6/EDG6/pmXnN98xYKKNEzp5YMzwF9hJLP9LA0SKFsIXaDiyWaSujM8x
         4n/JdDU1gpTStHQe28KkiB0JRopPp0vWkFdWgDh7qJKRxrwFjsodSpkyb5aB5N/UN6ns
         p6XC+TQFwxuObzDMpqoS32io2yEHnD+W+DVqLg8yu1cKhldwQnO2ULdC5m9Zk+Qj3HoF
         CR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKaS7ZJRCHJ29r9TCLanoemjzHyqBNOuyEUEZrDWvkRHGExExxBpstE+EgMbZLSJIftPY61QYUo9w7ez0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hVB+yg7p6rb7clQT6BE5Jz4PGeZa5D/9otRRDGAYsBQscqIS
	blujkbUApWD5D9G5fAWlqWYeZ0SBQfcfjg40nRf7hIn2KpoQ7EDtL8b2CeRsI895ToE=
X-Gm-Gg: ASbGncsN7v1yhJJnD2CIWJRCMMvotNwvIMdOOKbmUeURRrTqcGFGjX/mLncPFNAEVXd
	3LCTagf0qIEYHgRk9S6UcmJ4jp9nqFlLoKb4loahWzybiLQXoRoRN9ffFlxmYRAJZov66S5B2JV
	QriWYCoSgRNUPrWt32Pc/PyHpjQ8lFgR0umRjBKYIXWb9X8tW+PepindOns3Eqg+ieUstIM/vmh
	gT34FCY014h3QKEYeBZA3J+nXFGS9EDeWGmFKAF+v5z+VZKwSt3PRuXh1ZqmwBomvrxGJwRZRGS
	EaevdUwTJPyXGa6i0XsLUMFZOZRaRumSMP+Hd9sq0LSvUG8doY5zXltXiz3jHF5JGNct9edGMET
	BsTAazG8/ydkPx8dUvP3A7qhJwoXYDKjbgr+hqJt2jymfdh/GRTavmjkufn9F+48rLWzJGtzsOP
	f3sXnl9+WmybFm8JO8rJP4SfqCFCu7voN2N41nFd6RJ98VMvmH5Kss
X-Google-Smtp-Source: AGHT+IGt4SFGJptpZ0jrCH0JCo7jlSYHb5iMvq47K6wOnBUV4fZAO0y+jOsnj2fzSLzf3+aWmVng0g==
X-Received: by 2002:a05:6a21:3294:b0:263:7cc6:1c3b with SMTP id adf61e73a8af0-29277cb8e9amr3774594637.60.1758267449202;
        Fri, 19 Sep 2025 00:37:29 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.37.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:37:28 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 0/8] riscv: Add Zalasr ISA extension support
Date: Fri, 19 Sep 2025 15:37:06 +0800
Message-ID: <20250919073714.83063-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
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

v3:
 - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
 so as to ensure FENCE.TSO ordering between operations which precede the
 UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
 to Andrea.
 - Support hwprobe of Zalasr.
 - Allow Zalasr extensions for Guest/VM.

v2:
 - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
 Conor.

Xu Lu (8):
  riscv: add ISA extension parsing for Zalasr
  dt-bindings: riscv: Add Zalasr ISA extension description
  riscv: hwprobe: Export Zalasr extension
  riscv: Introduce Zalasr instructions
  riscv: Use Zalasr for smp_load_acquire/smp_store_release
  riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
    operations
  RISC-V: KVM: Allow Zalasr extensions for Guest/VM
  KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |   5 +-
 .../devicetree/bindings/riscv/extensions.yaml |   5 +
 arch/riscv/include/asm/atomic.h               |   6 -
 arch/riscv/include/asm/barrier.h              |  91 ++++++++++--
 arch/riscv/include/asm/cmpxchg.h              | 136 ++++++++----------
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   1 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/sys_hwprobe.c               |   1 +
 arch/riscv/kvm/vcpu_onereg.c                  |   2 +
 .../selftests/kvm/riscv/get-reg-list.c        |   4 +
 13 files changed, 242 insertions(+), 91 deletions(-)

-- 
2.20.1


