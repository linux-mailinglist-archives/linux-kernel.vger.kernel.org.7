Return-Path: <linux-kernel+bounces-824671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A25B89D45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEFA02FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C323164CB;
	Fri, 19 Sep 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMRW5j3p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2753161B7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291077; cv=none; b=ISdkqnZcNOL5KzD+uNIvuHSoipwsWz/RXmhSZ/72pR63I7QhABvodYhWlp4M6ejxmu3mgfoyhOMOU/07E3rdhmbEJyl/allWF3ESLufecyvzcSMrcEyJ1PwaWU9SnjyUz0hOtpBIg1Mp7+fuUEWAQ6QzW5jE0nxz2c+G7cYunGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291077; c=relaxed/simple;
	bh=R/qrj5Q3Wyqp/AZmiE68mfblIts+BuX6V8NoQIVisJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM7dHRCmWrSZCDf1076GK7/VbpF2RIGOr6iUom46qVge8Hi+x7nU7PJsuOLMHOVlPImv82v1toibpAXlgrRqGsI9IlcrpHR4hSJouXQEcZ4Itb/JES1aey47n7aqShu0HBh1cs4f8c2WX5JDPIA9SahNzUvheHB7jZ/e5T75pPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMRW5j3p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3KhvVxVTYBxirZQIaoWjEQk7hBuOtll7FsG0TDKWug=;
	b=DMRW5j3pbZel8mWaRf4ZaB2ONtVG27CtOpDZNGn7qMolfSRKR1Qkfg4xIGH+7tEw9UleE4
	e4+AqLI++MVlLcj3M+NnZN4OYbFNwp0bBBlS363tDUu9YynSSL+V/kehR5frmmCfTqUPTY
	WC9QURIebxWHalBQR5op1nwXKflNOGQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-9-d7pA-kM4u_ZcB3skDlYQ-1; Fri,
 19 Sep 2025 10:11:11 -0400
X-MC-Unique: 9-d7pA-kM4u_ZcB3skDlYQ-1
X-Mimecast-MFC-AGG-ID: 9-d7pA-kM4u_ZcB3skDlYQ_1758291070
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C31091800578;
	Fri, 19 Sep 2025 14:11:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA8E21956045;
	Fri, 19 Sep 2025 14:11:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events strings
Date: Fri, 19 Sep 2025 16:09:45 +0200
Message-ID: <20250919140954.104920-12-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently the automata parser assumes event strings don't have any
space, this stands true for event names, but can be a wrong assumption
if we want to store other information in the event strings (e.g.
constraints for hybrid automata).

Adapt the parser logic to allow spaces in the event strings.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 3f06aef8d4fd..977ba859c34e 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -127,14 +127,13 @@ class Automata:
             #  ------------ event is here ------------^^^^^
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                event = line[-2].replace('"','')
+                event = "".join(line[line.index("label")+2:-1]).replace('"','')
 
                 # when a transition has more than one lables, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
-                event = event.replace("\\n", " ")
-                for i in event.split():
+                for i in event.split("\\n"):
                     events.append(i)
             cursor += 1
 
@@ -167,8 +166,8 @@ class Automata:
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')
                 dest_state = line[2].replace('"','').replace(',','_')
-                possible_events = line[-2].replace('"','').replace("\\n", " ")
-                for event in possible_events.split():
+                possible_events = "".join(line[line.index("label")+2:-1]).replace('"','')
+                for event in possible_events.split("\\n"):
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             cursor += 1
 
-- 
2.51.0


