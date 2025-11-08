Return-Path: <linux-kernel+bounces-891573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A5C42F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC3486FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355E2701CB;
	Sat,  8 Nov 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzlad3n9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3891A9FA8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617723; cv=none; b=No0dy+9TquTEVd27fcACjqhuco4UdgYtl0b4WksEOI3+OduPks2CcEyVTFqZdWY7TiCCozaVVdBv7ypCVkUN8t8SaOw5hMmPPiGXNRoCAB5eMpMhdLbmZtHpXb9d2MdVUQhfaPqem7jPXYUVWzIlbTBqSvTQx3zc/gXLY9i960o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617723; c=relaxed/simple;
	bh=w7gg8llTsk8i6LDemrCF1OsQjSqJGBnLeZ97AFtyVxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hezeGeA+KTUL0DW64aeRnoK0o+X/vr4dRPD1m6NmGj2cDbHjErYJ0WYdL7gN2EOKIPc9Lo8JucVKIvPfAztzxBKXIBNM5/rtFznJf4K0J07SlIs3DfSjuNSxz7ebEidE4DRBn2kWhDpxbYq/qPkFTZHmEdzjY5cawxnflRLsDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzlad3n9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso15269705ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617720; x=1763222520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=Vzlad3n9aZsPEf0JRbj4ZO2xRyXLvh7hC7Wx+14o+RX4qHi2P5dzXQOSKeQW+5UhMt
         1unUXywopmn+vwhfMNeKoM+N1TGHrh4twPhhF31FLlrAhxb7bUH9YixAuLS1IPI/N9bj
         Rsly4K4Mm7be2EW3YsnBWG8gPhFy8Z4CWQVSRdSoFJywLqQaPdtBcvzM/PNMZB7K/Q/4
         uDCSVQG1oPrqni7rkdblk/5SSQPL1Bt3/OHL+j/ouxIc82PEpQvCUl6sRjx2MOLk1DLs
         PYJ4xRlJ79hAD9sWoun+TmoqDeSzC7e5jBBVHXbIJuDcKZyyEJPuPh/dtwBh0mzH8UnC
         Mf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617720; x=1763222520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ihp9KzVuRiSrcet5QhKAfVQH/3aU+LQAUyp3hAm1VY=;
        b=FnpoAgpQPYJsqoNkzIZ4A2R4TlgASLOm/7Syhe9Vc8hX5axm/sJrvOhc/9e6IvGge2
         dMNQxUTP8Ao9slZw/uym9paYOWDydHnXp/AJXLYxPZP7aayB0K1FuW9Wa5G6nhHjIoqR
         zGki/8FkRLrs/FeHsQTckTdLRvCq8Wpvmaaog5V+YNHrUj/0LDJFYs0SvctI/qj2tYra
         3CSJTaR/VX+RN+2WdAKuhwFy4/6uMB7sXoE3lDcf5eUgbdJCW5/Vt3yoooXXjcoOK+WS
         cRtZhRKsuoOe4TYgjkTYNtMjLVUWcn/uNAU/90pSycZQaMIaIVQJzpSWfUSd6DZLahY7
         t93g==
X-Forwarded-Encrypted: i=1; AJvYcCUFAbfIdUEekBUm+VSp64WgAs6t2Avjv3Js9ATKqm8W2/i6oZxl2xgqLl/mpkzyzbor2GXMazV3hPuXuHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvs1xqjo+QHgip2Vn+7MoPUUQwUh6H1nfEXcnezbbLqPgBJPd
	xjbqxbSYyz8aoOzck/pAJJYcMnGNp263K8Y/2+JTOTsNfRCqOJsWzztjyBJgyoxz
X-Gm-Gg: ASbGncu7trQKTA3i2t6khiaggYUKKDqw7ZWpvGX13ijnAOOvXOpW2m+pTmfpyi7JQ/m
	e21TfPUmg/ac+W2wvO7PDu7OCO4ohcSBa4zGPCJkTeZYR5AcPh+7KpRxe2Ec8AjQ8ekdjzth1gr
	4w0pJ9PsS5fqh2rBVxhTmmslZcEtYLG4JYJpOoSa34S08S6jbOcXExTu6yWQIZwEApyfpuiu3n4
	OtaqQZv9vxU4pnWxuA0w4N2p9kj5VhNCO5g39qzYXOajExuB9iSAMTh3PFhvydVAZhgRB4JKEMJ
	yt+PNi/1/b4IIOUnaivGr3b3SuM30slCXhSXrvC4HgVaKEd2fhNlX/4fKDBEuIiubZoeU3UYP4G
	MM0e3J7WYVfBLYNbWW7KuE6+UoCDovifDqFKZhiWz1DJq3kdNg6X8+MhpmSbULuj0OaBmKfKzOB
	HSaG2QulNv
X-Google-Smtp-Source: AGHT+IEsWYP5FLryBdHCq6QBhKzU01pCZcyukJfx4pdeg3dtTL07KkZygsC7aczWVHGVLKqYDFo3Gg==
X-Received: by 2002:a17:903:46c5:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-297e562489emr34699235ad.18.1762617720451;
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968602sm95152215ad.9.2025.11.08.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:01 -0800
Subject: [PATCH net-next v4 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-10-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e961b65b4c6e..b611172da09e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -156,7 +156,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


