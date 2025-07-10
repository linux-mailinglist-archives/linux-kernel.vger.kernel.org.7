Return-Path: <linux-kernel+bounces-725693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE77B0027E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B33A7707
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47825F984;
	Thu, 10 Jul 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sdufb8j9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA704258CE2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151982; cv=none; b=Yk9qVrnoyApQcrIMeU3c7ZRtaP0FKecD0NIJ3dWU4IELY2EMx1SbnTREhrvQIZLWpbUdnGZMB18bY2k3u9PC39ktg1GG8ooGDpvs6URlRb9WV1TnkHxy2TRQwANAi7Ei9xFMLY2oqSaeOkTnXa1SGicTUx0ZezlBy2kPjkcOIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151982; c=relaxed/simple;
	bh=gtsKpnQ6yinsDHeUj/IE45AbnSB/KJ80LIJqyWJW15w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QT61LVMcTg2l56jRu4dfpyTLykRCQhvie1kLofEQXf30I6ki0CcpjN7vQ4SBfWbmZH6cilVIlchd4cD9NTQFNAmEast2Qce0Y6YrT++dOrf/6/WFpn4Ph3q1ZefbeT/Zb0Mu4nk/0KH0m+RJp5yppqGEArY7klApNDZJWnzdDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Sdufb8j9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9ea8d08so9268775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752151980; x=1752756780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sSolDnOeL8Qn5bsbXBGk9GdJMqX3fYqqm7e5urFgg4=;
        b=Sdufb8j9XVluPnpJU9nOwp4MRV5swJlTaofG069X2SrXk4GTByWKUfBYrdW/n2p3GA
         XvN5/WSnzGE1IRVwkzn8yMI3YvsOGXQysQgVTMrq9iYQV5esbqAIfBGwtbetC4SZXXp0
         utbKSTMoxSELLyLJsymMWBy49KB85VeaYv4RPj61ztSoj2dejFUs2Ha5I+fz5EQlbRFQ
         PjHK0/teNcFM++shvRnMGrXHKnVzqCknlcvOcJVRPxX3cpvAD5ujm1TPTqA4Sd6ThoBO
         56WBoLwVJOoBnrVGYGA83EB8nPQ+CGkFIPSdI2ypyQlHgy7a4eSS6jZsSijdMIK5Y34C
         F5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151980; x=1752756780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sSolDnOeL8Qn5bsbXBGk9GdJMqX3fYqqm7e5urFgg4=;
        b=aYJ0WwAIRjtT+7o/mnVE4oIrXfpY/dY2Fyj0LrqI7adCmRJW9U3/3qvArSsTlVqowz
         1+gbM5jhHPdb7GkTEjEOUNMNvIXdibm6eTYMmqwS8CUa29NN0Bbh4cfqFyQbVMJi4TzM
         mT2bS3Ayp1I2nvwXDQ9iENIIdveBxYL1fRMO/TKcXZ8s8dx/VoCQWlS8f9FBIy16ljXG
         XxxzQjUsl4KKJIau7/uQegOlLwIgE2/+y/wfGRf2ZQ651xixRwrOWVMVeCAv4iro5z0W
         DPxgppzN8jZ+Vw83PFr0lgo/ohU2gXdNqijANLnUXgsJ0ixm4IMkRQgmbsvZIJAj+Cva
         K3kg==
X-Forwarded-Encrypted: i=1; AJvYcCVYxu90IJ3peKPkilfx86O4uWVlxmHsDD2moKrrYFcxr9U54IXl3MpELTOSsGsa3+gORejHpvvQXZpOriA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrh5kJ+B+9nTD/x4OtdGLOoYhGaewqa6TR0gEib5OiKHZDESmQ
	uYkrCkzZwMbeEVY9MqGFhUptJA9pD0QSO3npas/tT6VWR5Hk7gcJmQIT8cbIVEkyAbA=
X-Gm-Gg: ASbGncuwPXxV/77Jx6h8cx6SQRqys65OYYUbGzDTpPSu4n6xK6YkBHNf8LLQl4/yaWo
	NLiid297QgQ3LCLRM8DU/Jwz5cHQvF2NMa1cmuURwuSv+VmB/gEE/4S1R9EXpo4OIIVhHA2BUSd
	M6J5JWieSDxPlBw6rxl2cqrnuw+0D+aKYYS6ueJ1Lq3xgZLk17qiN+9EPlKPTeD75Fr2D3Amhtb
	hCtvv30PXe0GxMsTdlKVbD9UxJe+mMMAAyHKD6GvcZImST7TkA4fdN1wJRYqtiGkmTP6xAWb1fz
	0ZgnU+OtL7W21gQlvY9h6ICKFAPKTH+ub9ernl7aSoShiiKgQ+JBD/XdFZvF/R35F32m83tF0Sc
	ZVfP8W2XEoQsIJTH7q0WeugQ=
X-Google-Smtp-Source: AGHT+IEztXrV4s36cuuPaBPR/uJ57CmW/fEKa2vBaNvpU5su8ofpXHgJ3aoe6UZWiAsKIoYYDMrzHw==
X-Received: by 2002:a17:903:1b04:b0:234:f19a:eead with SMTP id d9443c01a7336-23ddb343a4cmr102677405ad.43.1752151979813;
        Thu, 10 Jul 2025 05:52:59 -0700 (PDT)
Received: from ventana-bhyve.dc1.ventanamicro.com ([49.37.251.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359c68sm19230715ad.213.2025.07.10.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:52:59 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v1 0/2] riscv: Introduce support for hardware break/watchpoints
Date: Thu, 10 Jul 2025 18:22:29 +0530
Message-ID: <20250710125231.653967-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support of hardware breakpoints and watchpoints in RISC-V
architecture. The framework is built on top of perf subsystem and SBI debug
trigger extension.

Currently following features are not supported and are in works:
 - Ptrace support
 - Single stepping
 - Virtualization of debug triggers

The SBI debug trigger extension proposal can be found in Chapter-19 of SBI specification:
https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc8/riscv-sbi.pdf

The Sdtrig ISA is part of RISC-V debug specification which can be found at:
https://github.com/riscv/riscv-debug-spec

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/hw_breakpoint.h | 320 ++++++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/sbi.h           |  29 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 657 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 7 files changed, 1016 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

-- 
2.45.2


