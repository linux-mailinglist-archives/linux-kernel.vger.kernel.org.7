Return-Path: <linux-kernel+bounces-891569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3CC42F74
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503EB3B4ED6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079E253B52;
	Sat,  8 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVTEjkGv"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71623D2B8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617719; cv=none; b=gf2uitc1ilgHk7fBJ6PBygsUTUc83LNNFm/9VSszXDK/Cz3bRedMOIxnwiRrVKaU/fRjb1CY1mQgZA47qH4HfZ+OFTT6E0CBfL1Isk2VJnDUGDY/HLP9BTt93XcMj+dIEhswCXX56DQHlOUJboCEawpfs5HE42u0Xh2QYlEnsqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617719; c=relaxed/simple;
	bh=o4MlQeDS6auM9P4kHNQ3k9pmc0q9lYi9e4vGWiCOtnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnzjfPn1XOyO21G3rZFxEj3nOw7mojrlFkwkhoWlkoU5KpqWR1s1d6tlT4M9FlC5L7mgYXO0O0ZKt9H3k0ySp9YtnFRc3Exvv/jFiR81GDtVN/BTGvbnHosD8O7qZYOkP01s1y7FLAwsjlyVwPQZiOAtGyxvrb6sY89Z7JP5Th8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVTEjkGv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3436a97f092so1002755a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617717; x=1763222517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=hVTEjkGvapsKmGpxS5+PsTRLGx9RFWSF2NeCVEcJo3kTsjGYY6aasCcUCtaLSC1ArU
         jUBY5iS7mzudJ2YK0bwCWUVvNr8+n2LrMM34xoYoOVMAlB+OXBDV34ou5b8cLT9RIFPr
         vzQM0EHWB2MKfePDZKXZCoqLmltzC6chlG6+vNvhzAqBNiQfK6r9wSG0wqpN21pX3WFx
         vPoAgEGN+PsTmgLGmR1sML7KMpwHkVmAKhx+tWY0abW9eAxIZrmnkFyjLZHc0I/zABt3
         3hJbseaYCIVJIUN+U6hHcqMSErDe+e/DfIkJaX+k9sywSU4AZ1nbQTs0fyyP3sWLhssQ
         Tkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617717; x=1763222517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAjRw7PTsJ0iELJkuhd3H4m56at8173dELtud6Xr4j4=;
        b=Icm5MSqgIb/DpZkhwt5jxaE7WvC+sCMKP2DEiEm34hqm00b5iA5nJXIxfGn7nTjPoV
         3BUHmpHn1o2x8DISKZlqDoYtXLrusBabR/8sXJjdzzfQWTNfs0rbYkhEnTmnSBzdbpPe
         mkRS46CrfxiKDH2wR5G40ocL3UmxNrFZMUvgJwlN4PvUHRUWaPnQa1FMLi3mxhdAkqqq
         NLJQOBE8/6MD4TtayBJdmzTOQHhSXDuCFcNzUy0/Hrbs0jEDXO4wyAfqV9/h54f6Szyd
         bgrk9RJcJACtKvIWYeDv8eZldmYl3aAO4+TeXibr0EedAe2/U2I7TvWOJ8RVzsrB4ggr
         ewng==
X-Forwarded-Encrypted: i=1; AJvYcCU+KvL5eWUtpwXm297URN15lBl7aiwP6lonY0v+ZihOr7Kvt9rpmU6Zoh3Fw8W6yqDNVv3iNkTagHoW5QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sPLm7z9RFpt1+Qon03+S0fFSNgJVwhAOkQZ/3a+q5vokPHix
	HvruUUIiAAWA+fLpOwk12kk/+bCLm56HxTo1AonQPRIJX7ndMjS0xZgy
X-Gm-Gg: ASbGncuRcK1SEhi8DW8JP8UwnJqhle0AigvTsDvv7wlL/2Sd4J/DNDMPEXg23X7aycV
	qwSCoJQY5F4Lciawk9ZhL9C9qEvOqlGO9osbF5WbpBLHPdT4mW35nDUgRs9K5FNaqu0WhewoBok
	Har/ezybpRbWYEjdOTAl+/MnrRj90CpUAbDFCHSBJji7bL4vaTjfgt4LWwIc7dp7q00Ytei35un
	hPkaW2iQdDQ3bn+4ts3v3+qthwnI5jvdzlAZy9xuxYj3FBT9+VlER/BHO4q3y4pakeMIMzQzWAP
	BAw9KtpNNKoWzUnUH8tnCh5PwuzuNsZImAn7Jqq7WH1gJupVSvzK5WmADTfWMjScFTQk/sJBsji
	cnCUEETGAgqLv+29fdTPfJu9EQ5KMF/MC68K90T0Ts5zYfZh39i4WAAVfMbkIJ4R+GnxOqn3BPA
	==
X-Google-Smtp-Source: AGHT+IFJMiSDPJLEVgezSpGbFJbQVVjV01QEtUzeI+pmHkqds9NcgUya4c0r1u1o+ppTnMUl7FVAsQ==
X-Received: by 2002:a17:90a:dfd0:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3436cb3d256mr4326835a91.9.1762617716780;
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c3357bbsm5935730a91.12.2025.11.08.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:56 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:57 -0800
Subject: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6889bdb8a31c..bd231467c66b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 declare -A PIDFILES
 
@@ -236,7 +236,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


