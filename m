Return-Path: <linux-kernel+bounces-776260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C1B2CAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64F35A81E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747F30BF71;
	Tue, 19 Aug 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DM5c6UxU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AD2E22A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625040; cv=none; b=Kc9pqLYHZrlT/8WjzfNQ8Cg1tdQxPedGfUpCENfCjEfHq1/IF1M5SoAXFafB9BQmUxNHFHMqz4go7fikq3y8FTUeFYsOXtga1+ggw7nEnTkVj5z3aYJNm0h/2oz0JHSQIy6BvjBQhR4uklZJ87dPR+42RVyTCT11lZSgOGw/TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625040; c=relaxed/simple;
	bh=JXPd1rLK4KxreXPwbOiKrhOxW5tmFTs62cIXzsuk8AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KKYZNo1z0spIHEYWdKK9i2jrV6xManreDXgzWoUjmKEC8W5lf/a51dM5/XwNWqWqJMaDUAVhhWljIOvBMu7MgP4yPhk/SajuooC2qd5qj3CCnWpjyjI4f18l9533bRz2VnlPDxUyMbfqA/olHu+ruZ+l8GS1BQujMx3o0kUPMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DM5c6UxU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e7437908so5349516f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755625037; x=1756229837; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO5/mt3F5WN5A5SgwE0dDDSreyFeFbLuWxIdcH33nUM=;
        b=DM5c6UxUhU7iHTTkj2hj4QMHVGYMUdfnGnWOKBp+zAYLoc/DQqrA92WoCGqm8JbkXK
         DStvjVpCytekBsqcOp95f9gmLU4m1XvpWQ6gl2WNt4KXK/lnioNo0GCyxHXF01qCNSA+
         XV470V8PrzVdrZGPGtPHx12/1z7bxo2h7/UVCGVwbVjQNMHu8vt02WxzQYs4iW6Nr6kH
         TUhdHJGMHuBz5Sa9/UB8/Nd44oVhdG6p15dIe65Zz7AGSWl2HHCzwxRJjdYZIsCdYpIb
         0XBkuxGbyB+9CeqG2cE0f4H+3WRL+b+aUQLIUhOaznHYros8d8L4toOSkoHVy3ca+KDS
         jNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625037; x=1756229837;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO5/mt3F5WN5A5SgwE0dDDSreyFeFbLuWxIdcH33nUM=;
        b=cp//Zmweh0DTB9P6tvQwcMjoDfoo4pSz57fCKWnR+OmR0SgJWwaWhrgo7XhMpdrR0q
         boAUiO6wAbUUz3l7m5aKbXvbTE8k+nb/hWE/Gq+28gRF20QwrFasgQglkW5uzJusdZSR
         7AK0ZTEDuAocMpGnsR3jCmcbTwAyk8tJaC+PV1T7j2wTpEQ+Mm16ZEUbk4K660E/tGuS
         rx3DcySzBQy0k0aoCjRvhpfMGo3H9NFxD0Xzwp+MGTOC+fqcYnKB4oRsaWacV19IbKAa
         wMnLn8+VA9/vMhMiWOJ2pfrnMal3N5thn3T7fmZlFZ9MrH6F2StlhMCyWDv6fhcj0mvu
         +lxw==
X-Forwarded-Encrypted: i=1; AJvYcCVtFcwnqGlqKqeWfLqD5mrSujgbbfohxRkR8iajU0Zmea2s6GEMhXu0S2tzr9/L8G6XCaRHzWy8iyA4JVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqI9mZDrctKkXjg6AXirKidw5lqCRMWHNOU9Rr9YCqfRJ9Y6i
	pC9PWXfmZH/JL6ewQZxdxYc6RzCzfltT1pKkQtm+2AqginQxS65Wp7JwpS8FVLR2fW4=
X-Gm-Gg: ASbGncslGcTZtz9tyD5gWQBbrkxHKG4doCaViBlyuT9GnKqQlsj2HrWPIoeDQk5W3Zr
	GZ0SHMfNBg1iT3tqYWDJw7++S0FN8+yvZ77aZeiIi+HbE9othvRQgNVnL/C2zAaY1OppTQzPlrC
	xKL8nThTbhPjuwe4YyQyiRL+qWLxxIf8ht6bwJIh7t7pFNfOWtmRkudFm77S17pt1NJyG3EyOOp
	neCQLiXhwyXtp2yH6Wqi054NvTrch7M/tLdBGZ9MjCE4vqAXqRGfnAFZRrNWA1BKF9NCd+rDqy4
	knoT0R3cZCOlFiL//pmNjSgSbmXot4slE2hs3xy+WvBU5u6tBQNUMmG9tssw37luZkv6qNmqrO2
	NOt8TIzCu/T8=
X-Google-Smtp-Source: AGHT+IGh34R50gEhJycTm5zqMFBCoU3WTDF2MBvLl83PU9al954kLRGJD/Cpv5Dxv7zp9pGb6k4+EA==
X-Received: by 2002:a05:6000:4012:b0:3c0:7e02:67bb with SMTP id ffacd0b85a97d-3c0ecd26d18mr2762797f8f.63.1755625036666;
        Tue, 19 Aug 2025 10:37:16 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2bed9fe1sm2906022e0c.16.2025.08.19.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:37:16 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Tue, 19 Aug 2025 14:37:01 -0300
Subject: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
X-B4-Tracking: v=1; b=H4sIADy2pGgC/x3MQQqDMBBA0avIrBuqAUvTq5QikzgxA2EqmVgE8
 e5Nu3yL/w9QKkwKj+6AQh9WfkvDcOkgJJSFDM/NYHs79vfBGaUcK2lVk9epIkudYsbFBHeLo3f
 e0uyg1WuhyPv//Hw1e1QyvqCE9Ptp2jBdhfYK5/kFGmhp7IYAAAA=
X-Change-ID: 20250819-selftests-lp_taint_flag-c96f5b9b2ed9
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=rbm@suse.com;
 h=from:subject:message-id; bh=JXPd1rLK4KxreXPwbOiKrhOxW5tmFTs62cIXzsuk8AY=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBopLZIfQ0VomklN2mvleQcbBjgLgQY1J4xq4OOr
 qxsw4qZyOSJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaKS2SBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKZGnQ//fBACTrdtPSbzrMFqDYzWog8GqrVdXFi
 4SqqfZ7DKYjSQ5aSMPrsBxJn7TJwY89RaEHx05QfSS+1ZiRtGRXywG5Wf2gMiFq13JCXF7NImqg
 P0JU69SV7XTysIQbGnmtLMnkemaJPoK4IN/7+h0lFlogYfakHzVlOpD1zsnMAk4PWAQx6AKeWep
 xMkfQSlI55rXwmV6n5OqHfMdnDkS3aRNiX8mkSsjeOPT6MlPDOp6pe9rQhC8rUT4TkXm1wEp2i5
 Df58jj4q5Bc/SuPD/Yl37HsoiwAjsQjEfLOsbk6GWoNz3eL3egG8970hI92TTwz9R9yjaAzpjkK
 URSbA2hJd2eXhS2CZnbSNHCV7pyaVuV4Zk5zA5QF7C1VrFpKi4mYst87Jcf9rFgFnn94avGeZOn
 pniqrKf9GBfmRduRXGTnNtlE3NlErpegKumgxlBO1Kyr1fxyWMo1NWG9ZmgaP9DBQKN8Q30zfnu
 MPszoN8iyhd6W5iqdqNS2pJ70dy4cZqq0KBMIsjoW+Aw2HU10wEsvQcLZnSP4N+9TRqaudYrgwp
 1xxwGTBL5AE+parSF7X/ocZmqLRDaigFgjZyhGGt39vRC1CK9/AsY+RApYCCXp7SO+NVEjQ5Zuw
 JSsRVoGi9S1P8OKCfnkGeve0kkgGmVFHEw5znZgbr/apkvQ9EvUA=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Some systems might disable unloading a livepatch and when running tests on
them they fail like the following:

$ ./run_kselftest.sh -c livepatch
  TAP version 13
  1..8
  # selftests: livepatch: test-livepatch.sh
  # TEST: basic function patching ... not ok
  #
  # --- expected
  # +++ result
  # @@ -5,6 +5,7 @@ livepatch: 'test_klp_livepatch': starting
  #  livepatch: 'test_klp_livepatch': completing patching transition
  #  livepatch: 'test_klp_livepatch': patching complete
  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
  # +livepatch: attempt to disable live patch test_klp_livepatch, setting
  NO_SUPPORT taint flag
  #  livepatch: 'test_klp_livepatch': initializing unpatching transition
  #  livepatch: 'test_klp_livepatch': starting unpatching transition
  #  livepatch: 'test_klp_livepatch': completing unpatching transition
  #
  # ERROR: livepatch kselftest(s) failed

Cc: Marcos Paulo de Souza <mpdesouza@suse.com>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 46991a029f7c64ace3945727b3540521ffe2e529..13fc289962cdd77c9fc4eaf1ad336775d6db710d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -321,6 +321,7 @@ function check_result {
 	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
+		 grep -v 'setting NO_SUPPORT taint flag' | \
 		 sed 's/^\[[ 0-9.]*\] //' | \
 		 sed 's/^\[[ ]*[CT][0-9]*\] //')
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250819-selftests-lp_taint_flag-c96f5b9b2ed9

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


