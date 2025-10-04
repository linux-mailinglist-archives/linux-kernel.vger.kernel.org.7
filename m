Return-Path: <linux-kernel+bounces-842194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDABBB9307
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CA0188DA27
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CC257437;
	Sat,  4 Oct 2025 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmr2ExC/"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD525785B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621842; cv=none; b=PQFzqCh9OeujdkoRdfb4FF7HdLBk6b31msKS7YJaiq05MqixoD7/zxTR8xqjCF28y4MxdJIJqDzI8gxkf2JC20HKEDrwItDNoPaWCmF7qyWJmtkLqKQiIFJMeNXm3tZvb2A3FMQD/HBYW0RRGLA10GDGrQtcp0zj/ZR0n71hoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621842; c=relaxed/simple;
	bh=EXyB3no/ZYQZiw4k2sIVnM4eV2neGR0XKhmW6028cdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsf5a50Fx9ilwMffBeUdM6j6rOY0ewUc4dzW5ghmW+pjLmk99AJbz0r90YICPhG1tXhhqvuNUc1QroW82QMR5ioSoxbhUE4RH3o94SQ7GDxuwldLNpAOwqt78ygLaDVMMgYmH/CSrQPwf9oOW1/i8dZM/nVQZ2sqpK7iqyXyrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmr2ExC/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70ba7aa131fso37164466d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621840; x=1760226640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=Gmr2ExC/ahizGo5cxeQXkFW86dwTO8nMHPObyB+wxLcnWNJ5HdwutrgO0Mltfvv/Wp
         3DpJQx02gbKTeEWPIPcqSZQZ8hZQyQU37b8iulUUG40wb1orggxB4lxiAmQGXdHi7VEg
         Bt/ja8gkzGcXVn510StpEomHonNZ7vA0Tyi1qKzXtntCsPDRxNApu/t0wo1+2M74qprP
         ny0gyr5oZsCrQH8lZJQUIfUnJYjMgPXtQf8/GsKY8akZeD885AmLqo514VWemvjZCD5o
         ODaUnyYMNiG7Y6AVn858kvmzM9f0IPom2W2Lwbw9Pvf0qjT7YRVevUkhPqu95vC8q4tu
         g67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621840; x=1760226640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjU7oe93mN2yk67x3/TWExFFSzr4kO2WctOACXz9uio=;
        b=vKJ+/WVPip8J6CMkzXIJxOeqXJHAipb2ALcmxCd/RIjBMpb6JeGRzPVtPQjTfzz/H1
         8F4VAqlB9GFL67peMfufAysK2hcmW7XB5jr5R337HXN7PXeguW4dG1O6ckPg/ctcXpfC
         Y+PlaHCQU5zhhLZczhR2daPXQkVgOwcRZASNDy69G3MqubYXypXe2tU0f5npaWxxd7rd
         JLjmwOlIaE7KRMB2zcJdQVYDsTt8/RTawEsPo9L1wQJlpZJBHEkwzsHNzkIsfImsyNZI
         Qwlhy1uVmGm+/r7dc4QgmKkz1pGqPP79zgpf1M1xupJeqIbzFBxnvQuWzW0RCHhxmF4z
         JvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO/hnBxLW9GFI1OH1Dn1UTO7jBJXnxm6+EGhW6qfqyGVn5qrnbK5u6kjFr2m/FInNKOuZD25VsUM5XPlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LM/e4gpCyH2NNrTkYJN9YibBvkAEgMx00e3vNm2RX3Ei4TeT
	jHLnGnIyK3EsNzIwr1Ur7AoQm4qgDDkKFfoSYHXnMadimW571N0J8shg
X-Gm-Gg: ASbGncvkuv+In5mqoPSjcKx1h//VareIgwuEqLIeh1ouvLUsck1JC9KN8SPTyVVtGgz
	Z0eHfV5G8QqlYFMERmUq2hMb/70kYCDG1f1mTlps9qQLB8Nednpju5LTMX4z+o1IhLePge0RcJ4
	JG+Y1BnIupLEMHvTWrOfGvSjfcDsDRPD2OYP189/djVxpG79jMHBbaZzjtOolvWp6VNlIZDg6ZX
	XAJs9xajplRdCnPT2MsT7CkYZb0vs7Yy7kWFsLdX6plmmIktYZUoEmErAwdZTjbTpbo1Rljq8Se
	BV8fDi9+YV7UG2KX9+XqhShHjRrh1B+CQUhOGFSFTFSQp3k+dWbE/ds9WsHhsBYsX371EIZFhWN
	rDNNDWw88aZ2t+iIQVf6ikqgfNDK4v2K3wrPHfl/HJy20BJAGvXB6Um3YSjJ0S9zZTtrccfvcTh
	jGyXrrajYG7QKKALg=
X-Google-Smtp-Source: AGHT+IEUWXDZx+IAlNDV8Mu+BE5kMa9E4iKCTAQ71zUHKPBS5QeBaFqes3mcBdLmYCHeSFsI3jGX4w==
X-Received: by 2002:a05:6214:230f:b0:796:bfca:9c68 with SMTP id 6a1803df08f44-879dc77b87bmr86391786d6.3.1759621839475;
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:39 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 4/5] selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
Date: Sun,  5 Oct 2025 08:46:58 +0900
Message-ID: <20251004235001.133111-5-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 .../test.d/dynevent/add_remove_fprobe.tc      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 2506f464811b..d5761d31217c 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove fprobe events
 # requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
+# Note: list-style specs and :entry/:exit may be unavailable on older kernels.
+# These tests auto-skip at runtime if the list form is rejected by tracefs.
 
 echo 0 > events/enable
 echo > dynamic_events
@@ -89,4 +91,123 @@ if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
+# ---- New accept cases for list syntax with :entry/:exit and !-exclusions ----
+if echo "f:test/__list_check $PLACE,$PLACE3" >> dynamic_events 2> /dev/null; then
+	# Clean the probe added by the guard
+	echo "-:test/__list_check" >> dynamic_events
+
+	# List default (entry) with exclusion, explicit group/event
+	echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	grep -q "test/list_entry" dynamic_events
+	test -d events/test/list_entry
+
+	echo 1 > events/test/list_entry/enable
+	# Should attach to PLACE and PLACE3, but not PLACE2
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable and remove; count should be back to baseline
+	echo 0 > events/test/list_entry/enable
+	echo "-:test/list_entry" >> dynamic_events
+	! grep -q "test/list_entry" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with explicit :entry suffix (same behavior as default)
+	echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
+	grep -q "test/list_entry_exp" dynamic_events
+	test -d events/test/list_entry_exp
+
+	echo 1 > events/test/list_entry_exp/enable
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_entry_exp/enable
+	echo "-:test/list_entry_exp" >> dynamic_events
+	! grep -q "test/list_entry_exp" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# List with :exit suffix across the same set
+	echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_exit" dynamic_events
+	test -d events/test/list_exit
+
+	echo 1 > events/test/list_exit/enable
+	# On return probes, enabled_functions still reflects attached functions.
+	grep -q "$PLACE" enabled_functions
+	grep -q "$PLACE3" enabled_functions
+	! grep -q "$PLACE2" enabled_functions
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	echo 0 > events/test/list_exit/enable
+	echo "-:test/list_exit" >> dynamic_events
+	! grep -q "test/list_exit" dynamic_events
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Enabling entry and exit together does not double-count functions
+	echo "f:test/list_both_e $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+	echo "f:test/list_both_x $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+	grep -q "test/list_both_e" dynamic_events
+	grep -q "test/list_both_x" dynamic_events
+	test -d events/test/list_both_e
+	test -d events/test/list_both_x
+
+	echo 1 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Enabling :exit for the same set should keep the count the same
+	echo 1 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable one; count should remain (the other still holds the attach)
+	echo 0 > events/test/list_both_e/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $((ocnt + 2)) ]; then
+		exit_fail
+	fi
+
+	# Disable the other; count returns to baseline
+	echo 0 > events/test/list_both_x/enable
+	cnt=`cat enabled_functions | wc -l`
+	if [ $cnt -ne $ocnt ]; then
+		exit_fail
+	fi
+
+	# Remove both definitions
+	echo "-:test/list_both_e" >> dynamic_events
+	echo "-:test/list_both_x" >> dynamic_events
+	! grep -q "test/list_both_e" dynamic_events
+	! grep -q "test/list_both_x" dynamic_events
+else
+	# List-form not supported; skip silently
+	:
+fi
+
 clear_trace
-- 
2.43.0


