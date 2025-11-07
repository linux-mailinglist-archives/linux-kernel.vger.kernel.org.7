Return-Path: <linux-kernel+bounces-889602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F18C3E056
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EB43A794B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABE92EBB9E;
	Fri,  7 Nov 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3lbuwiX"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46D21FF21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476594; cv=none; b=Iaq+uFVXy2Ge0Kg+4S6MIiSPhwqJ9G2uTyjRgyJF7jlfShZdUQ1bg7m6pihwGP4nAqw52gn+S+i7aekX9Srghp+ggWqnGHwh5iQWFdFffK8BuBwdG1xgdgmCR2415fP/aJx4+LybfO4YCE0xFwUW6PIqfLtC7TOaRPJOKXesZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476594; c=relaxed/simple;
	bh=579y5r6qisDyc0vXZIHMWG8pM549D8gpzJUlycZNzkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rnP49LthA1Li1QSYg3PfqHYPQKN/tFOQsenZNAPKEBD0dtllu+4PrgVqiYyImTcwFx6Anv/QfB0F/pZCZzYIRFXLaWj8wh9SBMtNop4LRnSAHOBPivZ1N+/OHUNC3xZslRPKY8/8zFPPUZRuCwC36vmDx3hFatTdleqzya1woEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3lbuwiX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso150028a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476591; x=1763081391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=b3lbuwiXV2SKO59OSxe4pgmw2CXcRfVDsYj0NUYp+xFaSEtiDSYYuMmnimTI62ubtg
         ABaA3+/bqEJytzEMM3XpYnX8TSbMNZFqM6E+AKa1IHEYSn15Q0xjF8z5BrELURpZMF86
         rY3N9J75x5OL5m1AplPK2gaj4e9vJGvpG2l/hLdHpycC0N1KoZKXq+Zo/5XcYFGuRui/
         yuyAXrBkEZGDVUx4axURtQaNeY1g7lKJ5IIM0RGVkOgHIC7zG5d4Ff6kexR7Bj/S80G8
         K7B/eWtgT6VmA/6wWoM7XRUqYaZOXKvLckGtKO61mruAfJQ2i1J7f+X+eIdl4TKAro+S
         U8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476591; x=1763081391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=tm7b9xxdXmpBtIDbjaw1euBYIOeCBybb+lu+crQx9Y0kPxJy/YGadbTAk3ev7M7hUi
         7TBstDZBPjxhmrkgLLVnSqmGYpy3gPZUZNZYXnM8HhWOdrKETZhuDMS9k3Xz1qCL4+4l
         XFjX3kT2ZZ1v4MJOGqw59aoVTU+6p1zSKM/2g2dAIX570LR3TkE4KR+/Yyt/tUuylZQA
         w5SPwRILDdif8AawKgcBUt8Oyk/P3y+q5Go5wH+hDB+vtPUjAPtRHlCehaABuqTDjFpz
         khsDNaUAUFuory6KgdCkFcF6luiHjSSBV9qOSI9/B/umKRhvlKq8XAB3nMPln8Zojr/Y
         KwPw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Xz7MukQ0w9d5TI24Fv276WQxEf2RscO6Pb9l8hxye8KB1pS8tcZngKDTy0JmQTC3TJE1Xt69jhCqXR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9AO4+1cjJlptfxaZSjIGJdcn/JByOqzefCoXYjgYZYvbzlHM
	RrHSad71NREsUxA8pRV234ws1WV0sadlt6X/Doj0O+2hhmfgz3V9ol5C
X-Gm-Gg: ASbGncsqsv8JjixxKL4F+AaAlvFNm/EP3U9vdtLpz/1xJ6YUAPcOqlvfUCFH0QeM72k
	gkz93MBOgYLikwfUNVwbK03pwkvTtkJTGsQ1IkadtI8loU4y7SGTOQv4FNviNQmAgf3CLGHHzEW
	32UI1TjqUEHeQNAJxjLZMMgqOZcdIwlzfrv+VLafpreZbd2rR7ruHuGVAz9ArTJuhMC74ATGEqJ
	apoKCRkEiElxjh0Aer9pbPRk4CQ0COUZ6ZYog/5xtMld90DZ5HwbuY3IhrobsIPUd7v4sL5PYno
	Bc+X/MdE4lzTxG4UpVb3AfvJLhcvgrbb6dIrEVhlQ+IJyq2m2r6F7+9z+KstZS7/yPrA5JX2CBC
	RIZ4VkhGnqAe3AyL20lsvMsHi7AqM7UGjoZa/Tk3i9HXn3Wn5LNOPkMRv1BLsXeIvPqVMd4ckgw
	==
X-Google-Smtp-Source: AGHT+IGVbNnnCv/JKP0L4AJIgAT7XYbbLVjx7tiV6GHUi/PF7nRC7D/K/BXQFE6YswbPc0qA9n+hkw==
X-Received: by 2002:a17:902:d4c1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-297c03a5f63mr17937825ad.4.1762476591127;
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm42074815ad.78.2025.11.06.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 00/11] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Thu, 06 Nov 2025 16:49:44 -0800
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChCDWkC/52OwWrDMBQEf0W8s1+RZCcmPuU/Sg62tWpEYsnoC
 ZES/O8hptBr6XmHmX2SIAcIDepJGTVISJEG1TaK5usYv8DB0aDIansw2hqukuYbC+6+QIqwDw8
 Ij9FxWNacKhbEIqwPfddp7yfrR2oUrRk7SYP6pIjCEY9Cl0bRNUhJ+Xt/UM2+/8TsX2PVsOYOp
 771zs6YzHlBGT/mtLzT/7LBYTL9yR27Y/tru2zb9gLV0w7oMwEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v3:
- see per-patch changes

Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (11):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 355 ++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 112 deletions(-)
---
base-commit: 8a25a2e34157d882032112e4194ccdfb29c499e8
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


