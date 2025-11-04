Return-Path: <linux-kernel+bounces-885541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC148C33447
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2515B4286BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36966347BC9;
	Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzY0SXqV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317B3469EE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295957; cv=none; b=D6H3/xAFpz46zTc6nGXJJ0C6mzcMG4GAmowvRlsKSAPg/n+VbTklhZ3XKGjrnKIrAE8pah33g+ZuqHz08iP2EnGqlMepln1Z30QnpP8l9xLtyBdn3ZdXAXdV+NU6iASsc+gPogZZSe0dgZCLpPyledNe3SWUcvuXIBFaMIDH1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295957; c=relaxed/simple;
	bh=dKYcrUk99CdeL/H3uIfsCxfnuKjJF+qFwDzoOr7kT4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UITTtUrKL7PI8XAdbp1tabMc75x54TlxkZPp6006xGdgpinlWaIdRAbMDILEO0nfsrYL9MVN1+KUvJlaWbR9Dulc7pYtcR9A64mJ2FE5ce9ZTNPxLW4zxoe9BnXskvKAAMihk5SoWJ2wcM0bO0E1yG1tntMCF/qhpX2E871Zlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzY0SXqV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so78611805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295954; x=1762900754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=CzY0SXqVwyO1GCzWMmjfNiQTq99E/p1LfzZkggbERkoMjPYz9sP/AVKSOa7Hok5Lhl
         vvH5npWNZVEBO/GQeBie7IwylCiwqBtSV+rxXNPrXjLTARr/9f0Wtjrf7Ynnn6uLrsv+
         czHhQA2Zy0xaMT0GJHiwNxlisk/MRuZyTWAsM5eXL3UwHsAtqv6gng0kBY7xEjnui9O3
         YwOnMoUfR7zo2yWTfn1zooEzEMqSRNnTsKjr7eezuKvrEhnfhpUGnCDp9TESuE86vPrb
         BMrke6JwS3NRyH4IlcwT6uq/ITVse6DCjYqMy8YkW5ZJMYiMXS40VkfUd9/ZR9Q5MqPA
         7mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295954; x=1762900754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=k6KnL/7+HnSup/ClKU1uMVbJpdJAI38D/jUCKJzMkUrX1P2RdathJaQgcJzsO5Dm1w
         X0KomfYlIkgGt97FURfXcgpFacapJ3ItL479ohroiVHjaEaE7ab74T73Pgj/KU2EF7SH
         Ka6kzj0bVCMmOaDgFKbilqFHLIIMb7yZEDnEmIfYow2uURRYQzxJkummODTL5+euwWq9
         XhLYZiA5jLSLZpTAx0YfajiyMNPE1pbPTSDSsiK9NutJnRKlFmu3EnOQcZ3sz4urB67e
         i1FFVcvx9Fr4L4XFrYXGBarO0qqbDNhFAxLC0jfavSKkYomxI2JJRu0Amq2KhTXbSbYi
         mWfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwknqX/mdQY/fRO/8byFDVcyor2J0UnkwHW8e44dyoLIFCvIZ3rtr2FmuwSr5+HP30nrENSBPpHeOAfKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxssm61EYLJVXe8sFRLC8miwzOKWqQP7g17x7aEY7CxbdKW24ad
	xSWcw+VnNJ2mnoqd58IFFkLklEDbx9LApMJ0+/i+xDImEe5D+DqkjD5W
X-Gm-Gg: ASbGnctRy2dTlgVulz0MgTK0wRhZzOM162EI1cBnkkdHBNx1VaOIh+N0PREKl4MY6e8
	HqyaPl30Ttq/izamR/oAWToZCdqfSPcdKARi5Vhi1VipHB3KhCYLNmnTdqKrBm50fiX8DnFAQ/G
	CjThuPOXfNJpz3s5xBfNNA5fdsbNVMhDVp5QX2KOSGmQnjhz5fVIWI1TplLEw2oypNrogBq4Je7
	rVxgt4JFmHqCZ2/OPaxF90U7NBcsIVcyWnhDpWnj8KDDU5NToe/jQvOxYq8jcaO6lcBG1LTAlyB
	WovpKSJV3ctTnCePy54IuJFGbhO3ucuiLXvqM9Kx6cQ5Ki7dVL1hprTHJyuf3gUFMlhQvJULxAj
	woHgxSZ8tn/l0vzpL+YgZdMqM1QtQCHH8DQkgCc7ZyP++pKQiKtvhMCrrWC1BuDjppumLYqdL
X-Google-Smtp-Source: AGHT+IGfGmQ8EXplL0hPzNqnOeWP5or72IZ12giPyrZz4vb4nazXJcS6uZFq2FRiYWZU3H7Y1pH3yg==
X-Received: by 2002:a17:902:ce89:b0:290:b14c:4f37 with SMTP id d9443c01a7336-2962ad95560mr17604575ad.30.1762295953856;
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39340475ad.1.2025.11.04.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:55 -0800
Subject: [PATCH net-next v2 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-5-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

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
index 5637c98d5fe8..81656b9acfaa 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
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


