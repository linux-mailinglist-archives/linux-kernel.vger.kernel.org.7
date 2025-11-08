Return-Path: <linux-kernel+bounces-891568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63296C42F29
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E57F347689
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BB24C07A;
	Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnQLgxIs"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F223AB88
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617718; cv=none; b=JtSNT0r+PImCqPYQ/4SbmIexDluProo74nWlTR8909RV26a8kHrso1h3zxVhGynjeIMHq5GdMB6h/9//8Pr0X0hvUEGHR0gjAigi7KxBAk8EnwvJy3Kc223H4fTBSt3KfOYuvF7Pylsl5acgE9GDPqPzluFTVD5hLGK+5U87JgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617718; c=relaxed/simple;
	bh=vFLZWv/FUrDafqhdvi7+WMCrHvjI3U/d+lidxcdSdHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIAgo+h1kq2M2OHcr8kL+J2GC49P8DcXtV8TLJAn8KoBQ7gIt4dZ6W3jsnCXObQhXDCbHqkMkJrS3wApUCbbQQqFkHhNDnfAPPVVnW2sk+etiz/jOxFGXbEP+oeQDaFzmAQ/3v7lATF7o4T9Xd2/u5z3zgnf9+api2QyVVMUf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnQLgxIs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953e415b27so15036665ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617716; x=1763222516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=jnQLgxIswzz0nLjG+u0WujrtVyeGbMRC+j2q7GE3Yn+R02GssqD+BkAksaYf97VlHX
         tl7ePsSEzgYrxm9fV/q7ufil+ri0cW7gAxv3sRmXRd6M5tJKOPR6dJN6YkCdDkCIxB/D
         CjnwlOF23bluccGhNiZrb/4lDoI1iUsNU5YUyguPev0gElKN9hZmZqZpTMTy5xdY5A16
         B+reFJgK3yh/GW3EHuQWz3jkssTxbyhyLJz3NmtMDGQrHBaY9MTXllnucRu64IVa5knc
         4ve7XVVl6m40dxi7EopsM6SbTt+55LPrLf0xk8BZm/DFltpQKt9aogdqEoQEXrBU0AEc
         KauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617716; x=1763222516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=jb+omzpa8WACdLZmg1M7c/7+e3JbXpobaTFJw1ZPnMhyuToBpfyBSweruknJxMJDOr
         vbdrBzlg5rwgjBlklNvwse9TJzB6ihWIHRzhbOvxRgIZYz0hEtThplYP4UUSOqiVHXcf
         XpcRaInKNvkuBAfgp5XvKMOZ/32ZAdUoaVtlAvGcP/rQVr/eZAAnGAvuBLPi55XjrLV4
         a9Q8K/zX15D2AwTaHXvJEbN1I/jc3SHYM2t9XyvTU+hW9jJroZW4Vyl3TuiJDJC2Wg6K
         +0WQMMnIQaSLSQft8Rv0m+wolhMlN00/sRkLl2GKzM96KyPW9QuKRUV8Z8onuuJteo1E
         Wgxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRApL9IUbtG0Efppd0U/b/EOMIXvchTxndpPU7uHPbKp+lghVyj/es9nwPQ8NhER934Pu3AF+xsMqut3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4ObVf7FrJ+NyGdFoq5jEis/Pt3gUGYt4ZE6vtVYaseZl4ZE+
	uPNGA+QVrEVvJsmE29ZC1SrME6xYOqmMhzmNURkd5BRGLi2U8TNXfhQY
X-Gm-Gg: ASbGnctENhKS2U+1NBp/pzcsKlsvtFuI0gQ//DUPAyts/MFzKv6OGEhNhI3fbQ1YFUP
	xL3DslyyCqKrYAFTNnuYkDcePzzzdeP6tP5kHPZ8aMVmFf7Ed3m6+IuMJLAZNh9/rIuGT2K/zqO
	OnEdvqSTxP//oO3GL3zFCGa8+/Xl/NlT8D14SI/zqGBa/4q9FTNQBBJU4PHqLfyd2oU+2tyHvoN
	YgCSv3pJWM0xuPlQlHGz/Pq21jG2erKwlUXUmLU44nJ+DHsSDwo2YQcBdTpI+7EUSYKtX8OQx1F
	Gwo9kYEDT5pMcHpfjQUg5CdDIeas/8abAj13+3wp/huPp93c4s9e2Prmmy9bNIQSBPDFUtvdm5l
	DGzscKQa612gdjKEBYAmuRk/IToVlo9s/qDSSusOVpYwKX/c1TXjkSNV+NqbeFifgqq4YacxjWm
	qKeQSAFGUd
X-Google-Smtp-Source: AGHT+IEfqRtwhtlx9re+8tiJC6AWXgiAQTuALNt7ZHJZ0Q9RkasCM/u0W7yOilEslz3OhmJAdBVkcA==
X-Received: by 2002:a17:903:244a:b0:295:592f:94a3 with SMTP id d9443c01a7336-297e57101bamr32706755ad.48.1762617715878;
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm92578535ad.108.2025.11.08.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:56 -0800
Subject: [PATCH net-next v4 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 13b685280a67..6889bdb8a31c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -236,10 +236,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


