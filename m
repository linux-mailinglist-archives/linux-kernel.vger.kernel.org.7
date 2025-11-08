Return-Path: <linux-kernel+bounces-891563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DDC42F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F5F3A2E0B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA42222BA;
	Sat,  8 Nov 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3YTEMw6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE4C133
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617713; cv=none; b=V4Jx5/3o3T4J9+DYZDkAElJ0z8jKKQUkXyvxnIRxzjC3bJTKYbejvBRrAQavBRf/0Pd2zmNn5SZoE3QuDGBQEXaAACRp6WGn/MmYfjqJR6H0KZMG3o4DDUZFmXZzU4oLmiR9clDUIpVxEFS5niQ2EEbQZnGYYG22+XWkhTRpcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617713; c=relaxed/simple;
	bh=GL2KSL5/GCvtcabkEDmH0mQRKHpNR6LFtcdCsXg/aoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JPHkgvoSyXopAS+n8f46e9AVJfQ0qFqHR0TBz/t+S7/MMqpB1KZIkNAxrd6hxOWaZ35qvA1oSlFzWb/e0Tw9DPmOSUx1QfvE4tqOgz243Yq+/awTEakZDvzXroHmdZKxhNFLajCtPTxUMLxLishstlgeECVEeW3NHnfQNDBgqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3YTEMw6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1479684b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617711; x=1763222511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk+ftSCmg1CG/nltRR0t8BMNABaT0VYcCFBYbPRrPVI=;
        b=A3YTEMw6ljs/d+YUChqdEzcq/Wu1E1YuOP9sp3TJkEkuBAl4U5mGRjm84tsD8xIF05
         yEfVI7czQ4IKiqQWnRV2gU9BSLG5q+Ha+K0SQiUh9e27IQR2ezBM7nN9qbI1+lcLDd5g
         NTqnMUnmAGj0Rbrk5+AdPbUfsAJWMODZWK5GPrlJhMef/pYo/hGgYTpSBylSCzqIo3Gn
         AZqfz06WLd2cjYhw48fPlugAdqaHItydR7uKnfhQvRiXuEzc5qjEhZI22idL3hSB3jwE
         Zifc3gC7QH2jtVMjXCRniwdq2pfHQ+/IUHpBuWcS9x41sweuE3aMpU2t4cMFhvQqezF1
         Kx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617711; x=1763222511;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk+ftSCmg1CG/nltRR0t8BMNABaT0VYcCFBYbPRrPVI=;
        b=Gp8u1UR7JgBt9WLK/TuM2kI/dN5iCSPD2W/Xf6x+SiZEdpgwCH3rF9j8j6ABmq/bYl
         S/W05tFQrwHDq1BDUwfx6089V124VByW40ZZxRYOpTxHhy1QeH+ipuaBb+3sy28X2tI8
         eptLR3kgD80wW+g2DMx7IRlO6O1gfUfp2X0w45lfq0qB0LcZRJEiX2L4rzLejicX3PB4
         I6UhaxtluR9Pu5ULQFtkM+QAUY/icpnYMrDMkznl2QKYmJ2M9EviiwUwzR0E4uW4oKRm
         gRFHITHHsePb6djd2cFz5ZYscmuvWnhvsTPLtxCSskb+029tb7+Qrqqfj/NySeVPs88J
         4ozw==
X-Forwarded-Encrypted: i=1; AJvYcCVz/V2sIZrr4i7uYwsoy5G0xtkXPNqm9qfR51W7tjzmixGpJzYGm49w0dmFFcLZDWC8M8u61MJa9AwrSk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbTvvoES81PYnZd/A4YrCilUWS0yNz5OeS2qAWbtTGbYhdsdB
	q6Yr85r+0liqmYMHqe0nPy0Tb1WIbycnnT8sOGrwpa/T0sYeXvt9P0fa
X-Gm-Gg: ASbGnct1fWYy1zwr6RcIE/gpKsSlfOYlvSAJJVxIPouJwj/ETn3xo3c33nJAh0HVBfd
	HYRstKh7qwoeG/c0Bw7hBjJnGm+ES6s2QEKOR8QcV7KcslOym9GLLJ8MIraRexnlY47sF2/cmec
	KyT56niQn5pnjmSD2A+ugc/Xts+pnrzoYXuZuaqP8D0UQG+CFzWh7v5fXr4OoseWPhmVSCQv1C5
	z63bUPFL4IDec564+j1v+H+Cn1LHyZQldIJDJlGIJmCIF1Chxp/TLAd449dJarMwrfXMk7mreol
	3asOd1X11++mScPNtZB7D/qjkNQboc4cJphMGZH5g8LqN2y7YpYZnuBsztjMP7EktHEf/zN/0BQ
	8CjRkXMWkSJJ0XfW1ccgTxYPbKo95wMLe2V4OgYSiG0ukdGXKDS5PuWRqbRHaTGEsu/ufVn/R
X-Google-Smtp-Source: AGHT+IEHIM0+igw1l8cTysPn1b2itALVEX3/urDFw2r0A+vpNa/C7teOEzoE2qf9or+CsSDT9YZpYQ==
X-Received: by 2002:a05:6a00:4f8c:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7b226f8d5e4mr3563547b3a.16.1762617710732;
        Sat, 08 Nov 2025 08:01:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c0763csm6374312b3a.19.2025.11.08.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Sat, 08 Nov 2025 08:00:51 -0800
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRpD2kC/52Oy2rDMBBFf0XM2lP0slV7lf8oXdjWqBGtpaARI
 iX430tMIV2Gru/lnHMDphKJYRI3KNQix5xgErYTsJ7n9EEYPUwCtNS9klph47x+ItNXqMSVMcQ
 rMc7JY9wuJTfaKFVG2TtrZQiLDjN0Ai6FjidM4g0SVUx0rfDeCThHrrl8HwVNHfuvTD8rawolW
 hqdCV6vtKjTRnV+WfN2V/+LRp4W5UY/2ME8aPfeZh6NSg5PUw1K7NVonKbXWbrlD3Xf9x+YcLC
 MiQEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
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
Cc: Simon Horman <horms@kernel.org>

Changes in v4:
- fix messed up rebase (wrt check_result() and shared_vm_test() patches)
- more consistent variable quotes style
- use associative array for pidfiles, remove after terminate
- Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com

Changes in v3:
- see per-patch changes
- Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com

Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 346 +++++++++++++++++++++-----------
 1 file changed, 233 insertions(+), 113 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


