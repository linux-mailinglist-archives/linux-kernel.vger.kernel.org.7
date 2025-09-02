Return-Path: <linux-kernel+bounces-797069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DEB40B76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93CD200DDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61591309DC6;
	Tue,  2 Sep 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FkUxEILO"
Received: from iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.221.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C8267B89
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.221.209.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832523; cv=none; b=kTgCZC05k7wE6DMOB5THBP+77xxPwMXtzcbU19E+s0sOzPBcWhRBfSInXclyzwaMnphvju4EIx4tBCepVUAj0hoSp5bUTClyUtjfXrwyURK3VrpuiBQYeZe75SloOo3oPzEJQKso3GEb6j/d5/2h7TqCK5V9J641nD8jY5isgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832523; c=relaxed/simple;
	bh=aRi81xEr2xcqiHE0kuc1uHCWN3eEyMOKBVhZ3dVR47s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeM0SbCzwy8Vp7zqIipe+9f9EE+6WLrGy1OzyxfEnpw9L5Dhc/3T80FcH4jyr4t5s89+IRmL/jXqpYL84wz5a5YIkckEnP3zxQOnefKtGMK7XA1hISGb0uMvfI7KpvE8yEob94+jsVmhbXnEsuYI7OrF4528v8ajVE31zUNfQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FkUxEILO; arc=none smtp.client-ip=3.221.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832521; x=1788368521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cz3lDzn0UcYssZ0SDsYtHmrnkmHQBrVHUfWnPQ7Qch8=;
  b=FkUxEILOoArdX9rYIC5SZzKf/EtOiyanMZ0c35WZ+BuZe8u3OILZ8DRP
   yfnB4AbUaLY1RqYfxzJ40dmV9OZdYd498Ed+yDwzFkzAwDCr711lH4FfZ
   tM1x+rlrgawkzTFH9Zuvb7QmUR8PBlKOUoImoXtd0uoY/qK0GRRsKhfdJ
   QMmP0b4Rp8QkIjHJ8Sar/NjfPRbwFmZNJpXtSHqHanYQEJg2DXkFdipiv
   dBWGELbdAnpMQ3RAt7epzB1pHZ0FOjzFxDDqQxLJA1WNbqZfvklwlH8h4
   ZTwMwtFBpnoTCCg8EC6Plr0L5T1y1M8CEL2AVF8pj+YzTc2f7DKv2PILP
   g==;
X-CSE-ConnectionGUID: hfn3rfNpTReXfYWy+II2WA==
X-CSE-MsgGUID: jRIFNbY/RaSD5ZvwIlZLlQ==
X-IronPort-AV: E=Sophos;i="6.14,267,1736812800"; 
   d="scan'208";a="1799358"
Received: from ip-10-4-10-75.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
  by internal-iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:01:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:14969]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id 52b9a439-02cb-438b-b156-3e0c55758966; Tue, 2 Sep 2025 17:01:58 +0000 (UTC)
X-Farcaster-Flow-ID: 52b9a439-02cb-438b-b156-3e0c55758966
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:01:57 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:01:55 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Christian Brauner <brauner@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 0/7] Add compatibility fixes for KVM selftests with non-glibc C libraries
Date: Tue, 2 Sep 2025 17:01:37 +0000
Message-ID: <20250902170147.55583-1-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This patch series adds compatibility fixes for building and running KVM selftests with musl 
and other non-glibc implementations. The changes address missing function definitions, syscall 
numbers, macros, type definitions, and runtime compatibility issues that are otherwise handled 
by glibc.

The series includes both build-time compatibility fixes (missing definitions, type mismatches) 
and runtime fixes (stdbuf compatibility in mixed libc environments) to ensure KVM selftests 
work correctly across different C library implementations.

Changes in v2:
- Split pidfd patch into two separate commits
- Dropped PAGE_SIZE redefinition patch - will root cause warning separately
- Dropped __packed fallback patch - tools infrastructure already handles this correctly
- Dropped pthread_attr_setaffinity_np patch - maintainer provided solution


Aqib Faruqui (7):
  selftests/pidfd: Add architecture-specific fallback definitions for
    pidfd_open
  selftests: harness: Include pidfd.h to get syscall definitions from
    tools/
  selftests: kselftest: Add memfd_create syscall compatibility
  KVM: selftests: Add backtrace fallback
  rseq: selftests: Add non-glibc compatibility fixes
  selftests: Fix stdbuf compatibility in mixed libc environments
  selftests: kselftest: Add ulong typedef for non-glibc compatibility

 tools/testing/selftests/kselftest.h                    | 24 ++++++++++++++++++++++++
 tools/testing/selftests/kselftest/runner.sh            |  2 +-
 tools/testing/selftests/kselftest_harness.h            |  1 +
 tools/testing/selftests/kvm/lib/assert.c               | 10 +++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c             |  1 +
 tools/testing/selftests/pidfd/pidfd.h                  |  4 ++++
 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h | 14 ++++++++++++++
 tools/testing/selftests/rseq/rseq.c                    |  8 ++++++++
 8 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.47.3


