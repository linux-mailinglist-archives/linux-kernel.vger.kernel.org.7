Return-Path: <linux-kernel+bounces-885548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E9BC33488
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23B23B458A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3534B432;
	Tue,  4 Nov 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlnCmINT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEC3491E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295963; cv=none; b=YzXadRfZfKiSFGqRu0oxP9N5C5LQ1ed2+XaxOT+ood9oggYyUxNNwSlHBE3X6UuUQiCLkD2a6V0EKzihh16dLHH+VmTJbFfkKykgtbwZ00r2JvyXzN+b9t2EtPMz6ngcA+QQhuPxc81eHFoFD2+7jkicc19cG/Owbtzj/D+tdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295963; c=relaxed/simple;
	bh=n+S3IdSADlP9+aYaZkaHpgaj3HAWH7tJS0ebxViFg4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/H9zo6bo5FRyEF2KFY4BQfRcM1XLiX0FEts5A4Fb3q4Os6CuRaQgqDpxULw0sWiPCkl2YAhj8CWbZoCjFTz35oAg7Guh72bS77hdxIGElUyCf4mvu2L4SB9e3D/Mt8V04MGI7TBwpLmaUV1t9t43RAPt449ljA64o3RyafT9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlnCmINT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2951a817541so67784295ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295960; x=1762900760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=jlnCmINTbpWQSbKj8zW/Mh98969tNXgDbMZtEWFo19Cs79huIExaTv+VDxiOBDNFWA
         o3EsPAJYCQXDENMrMJEJEz3drbXNSJNDNq5qFd1o4gWy6XV6u3ojCw+u/IDlkqOXbCqW
         u5tJkiM5X9Nk/oLY6pGbi6VW+RLQqfNB8T2uJsNBNEceeJ67IKZy28AOtB1/qHRn4nbL
         FquzmjelJ8GXNdKHT6xh0TK0773IXq09RJxVKTgPLwEjyCb9FDEI2a5UdVwiMXWcabQK
         ROSz5if01uIT6ddKWnaJjN79QOlxFin5WOViwObl7wb2WGaBvVRDdcLC6DpEqbVgLSYE
         Y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295960; x=1762900760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=louJU79g2eVK8rdbuOIXqwqI8nr9ZueJcAcohNn7EZQ=;
        b=ctGEPkRkklZp/YCJYDmYlg2hAKcvolcC+XZQPyegXKLVTHC2PiisP8jfTgHtMnEoCR
         sQlkGjKYJ56xVgppD1gVYB6YB4uEss6krvygrDUnDXSLnE4/PFIT53/CXAfVSASh3zXB
         8vFCi16s9hCK4BBtdXBLsNEo9vAe+qGHBIAzEK1aSuYIvEwaWg2AotkSmqkRP/OERx5R
         daK4LBGK0rWwGeFagiY+ZqnvfhDgUmfD2059cyIkPAhS/aBrFd1gX15MukrUo/dgYHBx
         gfFVU13Qjg4l4GDUtgz655JpWw5RfK+JIof4YyvRTbf1pfh5ym9QgC9sdcN6A60kHuXU
         +8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXkgml5GnXHbpSZSPkH4vxotAw/Ao0rxKF8R3E/rJqk5jfFG/LUYe3WVWWHuLABxOWHhgxkbdabJOhkx2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VlK6Mrb/gfc62/nh3j1zAvlrhcMSYPw7+cz+hACrdOB1VPaR
	AFOv8dbsM5kd3cKz88jPjiq+2wG6zkOXcx0/yNOtvZTcz1txCBpVlq0/
X-Gm-Gg: ASbGnctMzdbwX80aPaBxkWSjLxNQkUmqgfFgp6M75vjPVkyGC8k8s7/GyNavO+pIipP
	iRGKmPUrspOuVOA3b/TBhHM2pNeLbqRBJL9B7A0FAqSt8iDlxieP1hkDa6bdGQU7b4yDN3n1odO
	KCW5epLJpWEQfIAOSn0JNZesGedltTOD6PMSzAx6wrctcK0H+/ygmYmpo6qYoMNHoeq+P28AEd0
	uQxcWfjegZejbaxq8sdLCKzp6PqiHJz15HqLJweriOL+JXFGBjNBOUo+ki0iD4+YTBhx07yAEMD
	UTZTHa8C0Vhgm+350VPMeOmZ+qYyxhq81qK4Lu/3ziZpfc2UUc/xulwtkF+5hdU4mARojpiMG+s
	uqdGiQNSTP4Bn0QyF4xBQt5tRO9E5X55K2b7TylXlHHJ5iZuVTIy9P+sLDtSFkS5eNcetqWWB
X-Google-Smtp-Source: AGHT+IGqM/yITUFIcVMiTb5JYv2w0Kqx9gT7akPgWVpAVZ8aDi3SBcd1PdYtAWJDT/UIWXG9sHA8og==
X-Received: by 2002:a17:903:41ca:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2962ad0c942mr17413335ad.11.1762295960355;
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a7db8asm3463802a12.14.2025.11.04.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:20 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:02 -0800
Subject: [PATCH net-next v2 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-12-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cfb6b589bcba..6085e4cf56d5 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3


