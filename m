Return-Path: <linux-kernel+bounces-866052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8CBFEC99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8152535409A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AF258EEF;
	Thu, 23 Oct 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcfT/tLC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A422157B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181233; cv=none; b=b+28nueJGAlT4YdvtemOAIXqhpFa0idbntkRXlbZBTPTuIQdtjVnB9Os+WUu5JIy+W++iic0iJ1MLj54LUQrZsgk6avfEU3LTX7ENnFdlxSYKt+zhwUOwXACtag+22jAZ5AH3U12LYivcTcXs2dFmnIAhpVDiUCKVNDTf5vA0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181233; c=relaxed/simple;
	bh=53S5Zx5/+dq3CxymSoKg3PxckRbS+/iJdEXFwbACpeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGnmtAdycHqmpoZkAATBtf12ZUqp04FMpafXOzg9v7NK1gjNR03hu5GNuhLU/KygAVdcocQNJTjjRxVWl6wmvPfI3Z9rBc3g6kb5RKL0CY70cuTLn8VGBqovVjLQKcVgWbDAzV6jyTbTMYgWekmOv2Xg2lYa7N/uprP0C8UF0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcfT/tLC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a265a02477so176302b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=VcfT/tLCM9qe93/s9wsAmucZa7SSwKxk8qkYaI5I93SRF0N+TGfTwwu5PDNEhkYqhS
         JWK31iSk4WICz+bvPoVUW53zHVBSYoAyg+iaxwp8NsrdI0JkxrEs0A1CKuMahafjhKJD
         7547O6hlO+eIOkaTEifFj1li4tk9Tuh70zSLJSGXuYBsG0LXvH0bPuBu84MiGck2ip4H
         F5WqniA03/2cZq3P26FPqZZFNJe7w7qTdNEUqjZBp1XPHjoOi3IPHhhblVaP3QAkrOP1
         Ryp35MorM7iq4DIySQaVOAHTUFN36koedCBpu9PQc8PXNOzE2ktYhHYdNPrPUUkPyKeH
         E2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=HoBpa8X9zDx18QGwpX3krrd4EGzT7TLUCKXtbqcdy9xPMV0kxBZ54FU8f/dzoDCEYq
         ep+5bZqyUa4wCTtyRFy2Yn7YMQfUsjo/qRzqG66K4CxmtYdADF6zsGn5r9zrT0A91oN6
         GEpBLw6ANi2LCSBu/GxigBmZcwg6sOXv15FzALxJf7ctYQIY5WYfNE/05Z918tf6K5ek
         ukalNfmRsCdpQRxLNqZjUw/anzX7LzdZEkCnyZPX67sA0qAeYqU/kpLq0J6lfa2vxi9O
         rVEOk3pPwG1k0BcQR3oB2AGH035oEJwamtnTAMZP4xv3qO0Xd5p3Kf8TSeV3l0wr3Ahq
         UKHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwMKiByUQAWdHPDupxBmJLzZcAPBcQNrA3m6JN2z/2+ClYl1JHl3BUQCDV2Bovv6weHax6A9A26P8vfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4r1W6ZzHt//FFWX55+p2SyFAGL78SFzV08AKzoLb10LxQ+5t
	71PmYLBK7TVcxNPgqnB+MQ8UGDMX4yD9dNVrV913cYj3kC87eGb+bxD1
X-Gm-Gg: ASbGncuweXwSC2+wNqOjgBRcCMAw15YdVaDrD3YcjfXLoZeP7fqWBzWBQZzFBRx/5qt
	KLc5fDG7fsEz2gok6SiT1bN2XHkyNXS0n5pTKeng4yeOOTZhwxCS0WY+MOpsPMR+PyoUKRTuruj
	UoViEracfF/01gaJx+2ECgvd72G56XsnVGTnJcpI/N+084d2nHDhGv2ORB/dI6izPhRI9nyPa47
	xA0uh3wcLAb8cWQdhfVG3mQ6h8fpKz+2ZwLyQgQCxCNF7dnSWtjOaFEIJLx3KZ+/aFAsu9hJl7H
	AkXWEgUOadTkXDP7LQOOu472PojyIXzBh5EWXJPve6EGqcj40QkBVnhcxwq87/4fY3Z+mf4imzz
	fbJlMDfEOA/S4uE+aJ8oALDsrJ6CiNvqetOMucgsSjJpLSukHy1zt6VG3bpPh3UYr5rIhPYgH9C
	Z5YqaL4M2y
X-Google-Smtp-Source: AGHT+IEOLFrEwrP2Rf2uPvi/YyHr9hHzHgOPOlWS5DL5z4avx5Oje0geKjvDdLHF1RWLtx4Gg/89VA==
X-Received: by 2002:a05:6a00:4fc9:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a2745880c9mr1173130b3a.13.1761181230338;
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8a0edsm560059b3a.35.2025.10.22.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:10 -0700
Subject: [PATCH net-next 06/12] selftests/vsock: speed up tests by reducing
 the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6c8f199b771b..99db2e415253 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


