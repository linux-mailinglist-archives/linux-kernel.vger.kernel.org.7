Return-Path: <linux-kernel+bounces-746348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C5B125AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C1587D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB16269823;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrza58Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F225F998
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475661; cv=none; b=X/2EQ6O0/8vO/XJBd6F3GCth/AtH3s923g0tg9kZu3OXnZT3MvV4Z1NzLRRdEqzyDf/euv8jTUFaRk+TEyRsvNu3YzBuF3dYFMEDehQ8/kdxlip/mngtc1yTj9YTKPbFAXoovgzgnH7NN7v65a4WZgyYQLeYdj276FNmbzlT9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475661; c=relaxed/simple;
	bh=lDIeUP7gycBcCkJz7HkOKpX24qAEDV/0w3NBoR6udJI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C7ZfrUhaMeRrf+c09XlP2AjSehnLiMaSOl2l4b1VS34otmUA/+/XBJ/IZedpc/armlpcTOnq4zBT9h3fICU3UWihGhzfzLY+DcLJp464N5Kn4ZStYwAylZN4szuFgAVQqoMD0VZIHcYAw5lvsJV1OzKLpFXB1OfY+xSsTHjKjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrza58Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D820C4CEF8;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=lDIeUP7gycBcCkJz7HkOKpX24qAEDV/0w3NBoR6udJI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Xrza58OqoMApTVUN8863ejqmQw8Q7JtoOnpt/Lgxjj0TRp9lj/pZenDANIq0rOxaR
	 7ML8scrUfqIo7menIMnYUUauMopGvpWIXhFbHbU4tPnX5hAQDLtjoB0YjppmmdE9tZ
	 qTiOrZaQmTl5+9KCf+cIhD4xmNd3F00oi1Y8V5nd4C1fSZLZejixw5Arv8UJhk7r9t
	 f1qzSl406bKG7UNeM3YTYeoIjGhuDORurg6iAsNn5AnykEDLtn9vH22D/WKyYLb6cL
	 oqYFa5fjmexyrGAC+DMWxts50Kf3pB5jCJ4MnEiRH6D0CBci8XMCh40AGWzhLCCcMI
	 MS9V675Ww04Og==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001Qlr-1t5C;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203427.299291833@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:17 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 20/25] rv: Return init error when registering monitors
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Monitors generated with dot2k have their registration function (the one
called during monitor initialisation) return always 0, even if the
registration failed on RV side.
This can hide potential errors.

Return the value returned by the RV register function.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250723161240.194860-6-gmonaco@redhat.com
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/sched/sched.c                    | 3 +--
 kernel/trace/rv/monitors/sco/sco.c                        | 3 +--
 kernel/trace/rv/monitors/scpd/scpd.c                      | 3 +--
 kernel/trace/rv/monitors/sncid/sncid.c                    | 3 +--
 kernel/trace/rv/monitors/snep/snep.c                      | 3 +--
 kernel/trace/rv/monitors/snroc/snroc.c                    | 3 +--
 kernel/trace/rv/monitors/tss/tss.c                        | 3 +--
 kernel/trace/rv/monitors/wip/wip.c                        | 3 +--
 kernel/trace/rv/monitors/wwnr/wwnr.c                      | 3 +--
 tools/verification/rvgen/rvgen/templates/container/main.c | 3 +--
 tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 3 +--
 11 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
index 905e03c3c934..d04db4b543f9 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -21,8 +21,7 @@ struct rv_monitor rv_sched = {
 
 static int __init register_sched(void)
 {
-	rv_register_monitor(&rv_sched, NULL);
-	return 0;
+	return rv_register_monitor(&rv_sched, NULL);
 }
 
 static void __exit unregister_sched(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 4cff59220bfc..66f4639d46ac 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_sco = {
 
 static int __init register_sco(void)
 {
-	rv_register_monitor(&rv_sco, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sco, &rv_sched);
 }
 
 static void __exit unregister_sco(void)
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index cbdd6a5f8d7f..299703cd72b0 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_scpd = {
 
 static int __init register_scpd(void)
 {
-	rv_register_monitor(&rv_scpd, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_scpd, &rv_sched);
 }
 
 static void __exit unregister_scpd(void)
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
index f5037cd6214c..3e1ee715a0fb 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_sncid = {
 
 static int __init register_sncid(void)
 {
-	rv_register_monitor(&rv_sncid, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sncid, &rv_sched);
 }
 
 static void __exit unregister_sncid(void)
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 0076ba6d7ea4..2adc3108d60c 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_snep = {
 
 static int __init register_snep(void)
 {
-	rv_register_monitor(&rv_snep, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snep, &rv_sched);
 }
 
 static void __exit unregister_snep(void)
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index bb1f60d55296..540e686e699f 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -68,8 +68,7 @@ static struct rv_monitor rv_snroc = {
 
 static int __init register_snroc(void)
 {
-	rv_register_monitor(&rv_snroc, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snroc, &rv_sched);
 }
 
 static void __exit unregister_snroc(void)
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
index 542787e6524f..0452fcd9edcf 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -74,8 +74,7 @@ static struct rv_monitor rv_tss = {
 
 static int __init register_tss(void)
 {
-	rv_register_monitor(&rv_tss, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_tss, &rv_sched);
 }
 
 static void __exit unregister_tss(void)
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index ed758fec8608..4b4e99615a11 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_wip = {
 
 static int __init register_wip(void)
 {
-	rv_register_monitor(&rv_wip, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wip, NULL);
 }
 
 static void __exit unregister_wip(void)
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 172f31c4b0f3..4145bea2729e 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -70,8 +70,7 @@ static struct rv_monitor rv_wwnr = {
 
 static int __init register_wwnr(void)
 {
-	rv_register_monitor(&rv_wwnr, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wwnr, NULL);
 }
 
 static void __exit unregister_wwnr(void)
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/tools/verification/rvgen/rvgen/templates/container/main.c
index 89fc17cf8958..7d9b2f95c7e9 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -21,8 +21,7 @@ struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
-	return 0;
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
 }
 
 static void __exit unregister_%%MODEL_NAME%%(void)
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index 83044a20c89a..e0fd1134bd85 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -74,8 +74,7 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
-	return 0;
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
 }
 
 static void __exit unregister_%%MODEL_NAME%%(void)
-- 
2.47.2



