Return-Path: <linux-kernel+bounces-845092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC371BC37DE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC70E1898770
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07321DE8B3;
	Wed,  8 Oct 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgkOzyt1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB21C2BD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905922; cv=none; b=M55sy7hMMD7VHrDpuQChUclJT6JvnPO+aKHzULYwIY5/XdGIxdezNqxko2ikiXpHpwIi2ePBm+cWSEwjRKE41J4BTTwShwH7bftjCq5oWnopTacEl8i/iYLFHjo18254cJrmoquhkdXod53gQdtlLRrU9tnMb8rqrzD8UZdIzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905922; c=relaxed/simple;
	bh=PYadS1dvzEoESy7tFYGh83mfsXXM6Ar6GNIAFMRN5uA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XeyunxejHjWwY1UkegyIFBqfJHGNiPIaeTg2E3uNRiPFYPPCpGl+K7k0ftHZe7/JUPr6J/hEOpJbiiqJxxvxY8eM270OVcT67qMD2jt0rKbEJzfR7BfQQdq6LUsr+8fF7hE+M/YowDDhzqarPypJLcx9AlbC6fKZCjjsX4vibJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgkOzyt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759905919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJVbY3GluUVD/bUFHTF3UIglDWTesrXuNLqs55KHQ7w=;
	b=VgkOzyt1BDUc0lwGarCa3Fd2JDe06atqXBOfJ/O+nhCFO6Dy06wCbBLsFdFW2N+waDb4qU
	5ukn+33nUWIBp0zeLsFmk4a2l+xiXLCZkKWDrruLxfcM9RbxlLbJ14ER1eAI2l09mxUgs8
	bjP6BtDLP5dETmZ7deQlDT5hlTeeXjI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-osLdB_iANrakTswFji9xJw-1; Wed, 08 Oct 2025 02:45:18 -0400
X-MC-Unique: osLdB_iANrakTswFji9xJw-1
X-Mimecast-MFC-AGG-ID: osLdB_iANrakTswFji9xJw_1759905917
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426c4d733c4so55947f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759905917; x=1760510717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJVbY3GluUVD/bUFHTF3UIglDWTesrXuNLqs55KHQ7w=;
        b=bzeBV6HAAxfaFu64rtWZdqMlQRe8adbjTKpsqx2DPgVT2sCTUZw6qQgLT8Ra5ISVKb
         37XhECnfmDjcABX3R22ExFj8QWnNylYx68LkdUgebsC0wVv3eowwvZ7UXTVT7NeXfA1S
         IAOOhAMYnO3SbOtpQ0ISMT782+iXBiMmOWgnQdV1+u2RKxceO0bCpu7Egl6G5HCf1Q5D
         BrxigeXDYf9AaHeJOacUX24y8pK6W0Kb9i9DTPICgj36UtK0ub0CmD9/GQdQ64pT7GIq
         N/VC85Z5VOkgq/IHeGJ4RQtW2/scaxECvfv6FX6eZe7nZ5cZnyCqpjjTzUphT71pvdnU
         xCig==
X-Forwarded-Encrypted: i=1; AJvYcCVV8w1Nps5Ucn3ggu70fIRMdC2CQT4Wet/XxuydLy0ffmtAnqo7kR4WlDDgtQndooiMTHfYK8TqES0hnNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0c9TANboPudDBHFMiyV4+5QGUe3GDNnq3KuSrIHmbBhp7RAqh
	MdCX8c8wP7l5PYLI/gFuLF+w3j6VbB1qusnnv95gN6ErDWZWz8O046GSU/A/ISRiAZ7ps2mTO/l
	KdfFWofEPTx5GYTVkz0uZ9QhIfEkDpM2R6tHHSO+AAGlWhvF+9yXvQwBOYGzxmekaYA==
X-Gm-Gg: ASbGncsUEOOL/eR10FOu6+wS1H0YEwNVydvcSoqsa/qnrhRBRAVKmhVSCKQTz5fPXJX
	5wb64x7FuEytPCE8aSYGn4ReKoEZKbNCeTot0dQ7x6zxB+uY5oZ5yTEeOdEZm/Tz/f9/M0pAgkU
	SCUp5pFnEAlvtTmoIs1ycTZtBUND6/I4sFoKZPb5V0C2wndq06c0/FR4EsPsG9LOXHZpY1O6rmB
	/3tCu6Q3AQAz0WvAj/hZ93BI/iavvlqoEjJs1tLkUgDLI2wFStzmctV7EE2V8X5tCBnNNWEMTnJ
	qngX0Og1eFDZvHPOMr76jE1hPpdipxdvx+UewAmHTdEQvcNpgvrf01dJhsD91M4=
X-Received: by 2002:a05:6000:2910:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42666ac3686mr862917f8f.8.1759905916924;
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGhkljYRFGEvEIqP5lbKRu7wLfVXBIy1Iby6FD0gYGh4jsIXXgt/9QoZx4JrtpnRnL09JTEA==
X-Received: by 2002:a05:6000:2910:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42666ac3686mr862901f8f.8.1759905916552;
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c1589esm23364655e9.9.2025.10.07.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
Date: Wed,  8 Oct 2025 09:44:58 +0300
Message-ID: <20251008064500.245926-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --quiet option is available in all other rtla tools and documented
in the usage string, but was accidentally omitted from timerlat hist.

Add the missing --quiet option to timerlat hist for consistency and to
avoid confusion when silencing its output.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..983153b311ff 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -830,6 +830,7 @@ static struct common_params
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
+			{"quiet",		no_argument,		0, 'q'},
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
@@ -859,7 +860,7 @@ static struct common_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:qs:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -961,6 +962,9 @@ static struct common_params
 				timerlat_hist_usage("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
+		case 'q':
+			params->common.quiet = 1;
+			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
-- 
2.51.0


