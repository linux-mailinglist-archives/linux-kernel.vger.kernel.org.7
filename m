Return-Path: <linux-kernel+bounces-866056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D272BBFECC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57490347590
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2127AC57;
	Thu, 23 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEV28/Rn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4008265609
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181238; cv=none; b=QxLo2vu+qCIDpszFAKD+A8Bbjfb56GdcpPRKG1HJlqFoxYpc0P7vMqn3CbzmIFhA1gALI0PvmB6FwgGGJan20VYKHE0p8syA2jN9dB79dbi7I01ajewLDcOP9va120tBNwRnYz1/aHSr0GnbF9jbiEmQ/VZTqoFyQZ40TupHLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181238; c=relaxed/simple;
	bh=pCmUOoe9UEmIapGX09RMEqNq2xABcKupn8YH5c6OHyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErMFUxWpiRXtX0b3mh20CFC2QcZ75l4YMRxxDUmERCFPvxWjsYu1iXgaVIEhyjkktpJhP+ODrHrKSar2f/VHEHpEjkxW1n9b0xMxRc1HARmadkGwQbxL8txMh6DhvC8bo6XTarmKuC6JFtn3UhqKgFQ3C9hqRacmm99OCJfY7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEV28/Rn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso221869b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181235; x=1761786035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=kEV28/Rns5coJ3X5E4a6p02RCeuolU4ylPiMB+XyiMs1XlcLmodlQnakG015JngvrX
         Zm4CgaUWvlRgrc6cuH+UdxwvTmtHkTGRHQTs17EZb2UPfusIoHlf1nmroc0szh22xsNL
         AoTSa3IN3Sn60vYlWs4W7DXCm0ddpaUfjWVG80fVUqjO2YdeDkMDmSUkZgcNvMsUYhQP
         A3SrKdsV9U5tdPKg4E8jY0wOlwXD0JXQXS0TCyfJ5klo11OQOadvzpeNQbgD2/3WVhPZ
         OiI7c7xyzj1xTxA2rS0oZdC7XNM4kzkOMQS24hI4iXIP3Zgy2Nel6cNzNmss/xzz4O54
         aTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181235; x=1761786035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=oxLaQg6H0oSM6rj3NImXy/cRseCQs5jAu4Yap5DHZ3w0Rr5nVYh2aSNegd85w/xNf0
         My2wumMF4WgcEVJORy888rDyR7qm1dd+frnbeZT2VXvhEhZpsc6NPsDZ2uFBUnwr8KGn
         4EjR0/DsZ+gzHoq1jkblmfjo8rc/DzHZxoJble8e/6oc1Jzzjjpym0eNxuZKzW0HHTss
         gmZ2uNLsX4dcb7zYw5IkQA77sEAa6awh2XEgxzyvA27AzK8Fq2bk9hj7hZIY7PqjcVkf
         7SeKrsw+ardS9TCBSLvqcjO4ec57EIIaAZEDzeuuAVMy8yPfIh9CYVRHjO67MWStDYut
         Wi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOFT9ac+Z1DnzcBsKrlMdEMiPaLat8usaTZONOLYoLvGpBs0ZMPds6NaLFtXpOhQrozdrExEZSjuB/jMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzba8nlatZqKh8S4sXKOnRZyl3X1tqFYHM3C0Xe0l0UrxX4LFGV
	8LB86muQdWzsKsUYAejbI3EVlKe4PUpLwC8cVIZovGuHTxY70IcnuQoJ
X-Gm-Gg: ASbGncvBv9TtRUaOU0Z+YRHw4W6BqGXnyz9NDaKLToFWAiftQIezvZ8qJEDA5emPTew
	nv1GUbjrFtchlyoI2z+vSwC4NN+30mu57UDskXpNDWYtOXMHpL76dtk8kSptxYMFlU0c8vy1rv+
	bObkLAItFDSCITWVoalD+9bJy+kVmA9pMLwS3KsVJrw6vjDEoNa3lCZsU/2IYVH7ci0zcVQNWpB
	T63xz/FKQnQN9eRKOn2bD1ACvGHrNwrEscE3SGnKzTdSv4jsBLuv5+Tc1X1LRaf6UNNW2W8mIro
	dNbO1ITjnFBxdJJWrx58LZQEVNTqOqczfmpHoU4JQH9EpDL4rvIYBc3U28QgWPawMQ0Hjn7GAwT
	nNKxs6/ROpikPnj/vv4xcqVBZna9tARC+seGb2S373A/7Voi2gIUEbMn5XCljls/6Eqaoqi68Yw
	z8ADUXEpe6
X-Google-Smtp-Source: AGHT+IFah4xKWnPJdJQRrSTe40MUJQKUAPG67skaDGCDDAujY8FssP4vUeP2QuBI2KiQcE2PGKu37w==
X-Received: by 2002:a05:6a00:2301:b0:78c:99a8:b748 with SMTP id d2e1a72fcca58-7a220144d3cmr26283193b3a.0.1761181234838;
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ceddsm584787b3a.24.2025.10.22.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:14 -0700
Subject: [PATCH net-next 10/12] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-10-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a312930cb8b7..aa7199c94780 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -506,9 +506,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -520,7 +520,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -532,7 +532,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


