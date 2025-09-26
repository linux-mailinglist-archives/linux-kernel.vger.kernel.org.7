Return-Path: <linux-kernel+bounces-834381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C6BA494B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017C03A76F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA01242D65;
	Fri, 26 Sep 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATR+jDnu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003623E229
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903345; cv=none; b=eKrdH91VhF52w2TOq4Vu2/no+bByg8lSyNQr1NJhOciTyiFiEXw7b5IbXAtZbOTw5pwk8nyHWyfhRArQf+Xw8nWFhLrQbabvdJQT6dcwgDgIU5rp1l53hyhB45fIiGWoY2jKj3Ru8c1OA22Akzs/DHXp6XhSYas07ixPkR/Pwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903345; c=relaxed/simple;
	bh=fCFtnpHpwYMofzs/A1ZBMsIX2GLcFi3vYB2j7+QN0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCjPQrM6ejt3P4xjLWZbLgeTCAK/mhWBrm/x2hoEJubkDzhpvoCQqez/KbqfwFAld9PypvYO8AJU9r/ydgYoqUzVEW562Tvu5pun4OP48Xzv+MEwpu5JqJYPr3F0obYppIs7acv9st5uP+Wm0ludumpJ8+eUuA/zoRylR7k+J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATR+jDnu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3882e7432bso148943966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903342; x=1759508142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=ATR+jDnuI2i/wG6nbwVYU1iGnWa58dGkPeQ0/yHU0HkVLwBsOBmKEuuszuB/9igH+b
         +ugeJSUfBAB3ewmywmnhnRQUcFXpdW1j/pbum7l2B8vEyVO6p6mpKnw/dAEPdiLTxp47
         sBrhvK/UZyKIiHRqzfMxHIf/XAM59AhzcYPJAM0KG363zh8hVF2gN8BZI47N8CbGjQxZ
         vagveqDPCuPgCHbVwwu6W8XoU8sihqHTprX8H38Vq1XYSIRk2jUNXJ4S/EteQ2CeXAH/
         8aXjMpugm7/oQks7MkYwwHyN9z3FftmU6DFsG94IizA1J16JLSgRo2pxtwakOvE+RL+Y
         Ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903342; x=1759508142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=J1SG9B1loxB3vLR5xuyGO8MASjWV0sMr6kTJqENL8smq6++940RJ6pCkKU37r+d8lc
         eSAZitU+Tdg22ocfTBxpVVVEBQM6+5MvUyr4nknj7Uu9lqqw3ze1SWsf2C/cxHh6ElTu
         rzE7fYgJnODFYq0tifqEr3d/8tWVuigmML1GCBdRzYu0PSF9Vd0mNE3phebBnNKp4o9k
         qzR4SEy3PRhBEO0S5Mhvp4XC2pRWQCISqacoi2ss4n1G++TT2sZUPy02P4LDq/iHUPZj
         tuAYfErHCRiuxdb86DEdRORO0TkbKDjb7SuFyC0u4gose3OY/CzgusNkvW4tbJc1nCCb
         bReA==
X-Forwarded-Encrypted: i=1; AJvYcCVB/2lGxa/I8pL41Pbox7undMSexojeuvi6V1bkU30WQCl7yh2vz7nZkk3AGcGfJX94cseq9mpO9Q26krc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLMLJWZlIA77mek8hmDt6CTx+xwwfj2b2DNFCVGppEToaRcDH
	NsjIsToPG/A0VAQvavO0t3+zes6hhs1QmQBblpCmgWLE+l7/HnxRNRhG
X-Gm-Gg: ASbGncu6IyVwCHowd6K8YERFtjaCCeXnp8XGuXgcrWfibSH85X9q1hqvSnDE1ZSSIjz
	M/AnYckjqAnsRq75wdSc5XeTPfJ/PkImxor547r0VkVdPNZprQpR3i+lJpxxY37wNgJhhP9D648
	Kj4kMeC19K6vlqqvXB69eYZXlGqncbwXBu0lHRT0nsGpUYwaEzPCYyZC6SwX/rK5/CA5EA+PDYk
	oRwdnxMOuU61hD50w6YkOdZVUhoU8vExt+xRI0T3GiNGcWJH52sN7maQnQkj3aOiBuP33SEtOUD
	K1RZeI11Sh7OZpaO2fruRIDZOqD9mVU4IN9mNRhk+1silJAfKnRuNwLDXDuM3Vl33ph5h/VDQAg
	bzEZ8BMBnPLXPSnl09L0ZPNJD7bpaktEYCcTkUx99CvecT8dqUz984But7tQ6UOkemU2FYMbCsH
	yL9RkIO/6UttIBtMDB
X-Google-Smtp-Source: AGHT+IGSKS33vEp7IxROvUKAQKlFRVsjIANObx7t3xDIK+wvc7qqDK/f+4CjmaBx5z0SlWt790YXtQ==
X-Received: by 2002:a17:907:6ea3:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b34bbbda586mr890952766b.32.1758903341471;
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm248308566b.89.2025.09.26.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: Check return value from read
Date: Fri, 26 Sep 2025 18:15:37 +0200
Message-ID: <20250926161538.57896-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to retrieve the return value from the read() function
and raise an error if negative.

When building the test with the command
`make -C tools/testing/selftests TARGETS=net` emits the
following warning:

tfo.c: In function ‘run_server’:
tfo.c:84:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   84 |         read(connfd, buf, 64);

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/tfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..8fce369e6c37 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -50,6 +50,7 @@ static void run_server(void)
 	socklen_t len;
 	char buf[64];
 	FILE *outfile;
+	int ret;
 
 	outfile = fopen(cfg_outfile, "w");
 	if (!outfile)
@@ -81,7 +82,9 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	ret = read(connfd, buf, 64);
+	if (ret < 0)
+		error(1, errno, "read()");
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.43.0


