Return-Path: <linux-kernel+bounces-889609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796ABC3E09B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A26F1886279
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227D2FBE15;
	Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQE3Bjnd"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380322F6176
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476602; cv=none; b=bHziw1mfxE3kHgIz3JNLXRfKeffh3hyH+kY8tdeT9oRrVI7leYEbafD32xlex2cHclrFVmv0TBBQOh212I/aiXxJgLGAx+8jR4yVXBfvhLDhc6wqk8+CjiycjVwshhKDmpXS5QOURnlUkhV+R8CtcaYCK6sKhoNBxD2UIW6CUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476602; c=relaxed/simple;
	bh=XXNlL9HT6OWyfD6YaISgyik17zuUQszMD6nW7MMjNu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJ+vEEVggOMF7iLO38u/3pYtrXaZQNSVsTPKOt1a/9ot3ghWJdk/oWBhdywRHU/2iHBBBP0Up5p/HDCmx+1P3Ds6vCdTZI+M5adm7uBBH6PbUSavmzT0Fmq+RVFjH2nu/uxx+tlppeOwgfRie2U8jcAVYcrHY0lfQbpmqoezksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQE3Bjnd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso151954a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=VQE3BjndPzgv6lyChA///bM9XjaIyZ38XwkiNVXX+9r4y8PcM4Jhkk+/aSJplHRzFV
         HmdBlsGLfNoQyEXCEjgrbpqXwculFw1s6unKp47wvgq6zpv0Y2UUVzbLg4AEkFXXoOdn
         lWiassIfPbK2PX7WZaKwJvN3UYVBCUu1GbSllvBRHESgEyzk5IslMqnawW1MBDw0KXSj
         Qypb1jrZW+1TyPScZaBiBjXyS3F257KS2ffSWISLsjfltS5CEYEBC/G4XhH5LDvn9Ohi
         8PYZKtB5j715yHpX8flNbkchzPFocYy03Do487rfkyaIinquJCSsp/T176YOuSx/xS8h
         oEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=KndAbl41lLoGYD8JaCyz59zGI6biMqSRSVkZDBfbMKp4o9go0FTPIFWn2En5U0jVr3
         r4ziQMHC/YfVbfAMoktK3mNJVQQbaxOSWgkkAKD1So21ZBuKjSVlVIIKYD/dsNrXrU5j
         K3bhxZc1nzF0etjbIVZkkfFt/r+LLeIyfHuSTskgfweEYOItTwD3LCyt5LIbLL8b0Za1
         WfLReihGQP3y5fB2oDmk44ksm5RpUUt3VedjujVoxWOQeohvib44lP89Ngl3GOQEFqsR
         +G9veBl4k9p0rm7+Kq0ZzVKCA4tJyiQd0QOA4zG3zvdmajLWISnPvgQ/MVbhOv434T1M
         K+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9eUS+v8xMh4FhasnVBZO9nZYvyJOWX2+ZSozImaGC0QpswsaVUJ8XTbZlrMcaHlKvWAUXFxForFtJF0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6hk6gKCe2mkYklSq6hKioiohb+lk4qpSyXUc9WBidkDeq85V
	TefAiY+5qLI48tVVkfdsHN1rTJn4dHJQwFD9ZAkAjxhMOqYLIJ9c/+F6
X-Gm-Gg: ASbGncsGrUkxPRGzeZytCaHF9XYZnRd0Kx5niI58Y4LL+4PjwUZWvoxFCr4ZEWUGZl8
	xj4dGVJ4bb3E1sQvXvZnCx6kWz+pbAfW7qJxvBJrcA7qg3aabgB3WmwWbmpdBkkkRUJFT/4WM8I
	pbc+tp7UGd2EXHK4X2lRJy6vmkdjykV85AyjspIu+YZ3iifwCPzAs9pUPMqka2OMFiqNnEBqN+2
	aY0rES8nwyY48oZ63/j07G3WCyjWq68jHgT5hvN5NKppLwp9ESwiu7CZgt/NCOMBWJyphAYFx7C
	Qg3YwvXutyHG/O6kT+GV3mduMKtbrFsNh+IuDXNjTdOQlhQfK6CKW1KxEuHR1OxLIzG0ovjYzww
	bCs8A3731hvjpe8PAohXYRcDvsEvo5VPVNm4SRIPEp1uyJQkmr3hkgAxDJtpVO6+2A15zibC6/Q
	==
X-Google-Smtp-Source: AGHT+IFOFDetHqDrq/PAxGg+NrZQJpCNEyHjtP9cSvBQ0lXmrGvIWZ7Q8EW8bgf8ugBUgQz3F280Xg==
X-Received: by 2002:a17:903:2ec7:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-297c03a608cmr14724535ad.8.1762476599508;
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm41535535ad.72.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:52 -0800
Subject: [PATCH net-next v3 08/11] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-8-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 05cf370a3db4..7962bc40d055 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -559,6 +559,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


