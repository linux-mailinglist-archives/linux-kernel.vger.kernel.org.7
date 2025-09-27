Return-Path: <linux-kernel+bounces-834982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A7BA5F59
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939801B2534E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D852DF6EA;
	Sat, 27 Sep 2025 12:52:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013F19EEC2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977570; cv=none; b=Ll7/gQDXk8Lc9YFd1n/UqpxLL33W+ln1DK3K1NO/k/36Mp1oG2ebbNpOTh5jb6EsFkrGgFOP1iXlHhEVnS4RE/2pJ+KQVyBgrkkz96akOGR+InzJ4UP+f+bdSNgD6jyPN4eDoarbEyDm+6G4RdVDtv+s1x+r2JNbGjkKGWKYD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977570; c=relaxed/simple;
	bh=7wNg6G225PWv1ROkJH5or+Nb0IM55uFby3ZjU23ywmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o4IVKQXQjFNak5pMIhNcgDUjf2XWelthyQqMASlZ4yMBQJR6z/sAv+qjFY90vE/JY/xhW8yCJv6W+TlmVLubMQ45IiAccRjn8cQC8PBMfGSTVytlzvrzmkue99wTEn2kZqZH9Vi5j3GaMxkkl+M0PQr6DCI5WKFG15eWUHr/ZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D6A4E1A07E8;
	Sat, 27 Sep 2025 12:52:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 9FCE12000E;
	Sat, 27 Sep 2025 12:52:37 +0000 (UTC)
Date: Sat, 27 Sep 2025 08:52:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ivan Pravdin
 <ipravdin.official@gmail.com>, Wander Lairson Costa <wander@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] rtla: Couple of fixes for 6.17
Message-ID: <20250927085234.6a46c0a2@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9FCE12000E
X-Stat-Signature: yuxukpbsydzxct4xzrbn35srs4998yid
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lJgYIqIsMME0KQCZvN/ASlTkbPjpQcCw=
X-HE-Tag: 1758977557-422322
X-HE-Meta: U2FsdGVkX1/UUfmDaiJch74+hU+czC5QNYU18GtBittAZ+Ct4qx9UNLWJdrynV4o04+RKBQGZuEp/WLIZpHUB3cWsFL1/NQyUKLv5ufvL5dhWuoDpsm0wRECUNkAoT7k/uCxQLi/QgdO/f3W4v+zjG+DmE5QVLw48juXoInCtMqXpY2DzcNxfPy0nJ/5zlhYKNtDK8zkUeuGe3iErhotGWoB5dwZ3Fo/Xavmv50oHoIdpQdU+AfsM4vb4TYI3e8JHTNWwG98h86qbLM6l90/eYhNHqaz+Zm2ue0c7nSDG4P54Bs14qPR4ZbRTPURedI+5vEI2YcUYJRn1hmEpxLlbRq7rvSsIb22


Linus,

Two fixes for rtla in v6.17:

- Fix a buffer overflow in actions_parse()

  The "trigger_c" variable did not account for the nul byte when
  determining its size.

- Fix a compare that had the values reversed

  actions_destroy() is to reallocate when len is greater than the current size,
  but the compare was testing if size is greater than the new length.


Please pull the latest trace-tools-v6.17-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.17-rc5

Tag SHA1: 5f0fc72cedf3fd11f298253d0687eb69ea921dfd
Head SHA1: 2227f273b7dc25a791ae6b152550098aa6934b2f


Ivan Pravdin (1):
      rtla: Fix buffer overflow in actions_parse

Wander Lairson Costa (1):
      rtla/actions: Fix condition for buffer reallocation

----
 tools/tracing/rtla/src/actions.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..13ff1934d47c 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -49,7 +49,7 @@ actions_destroy(struct actions *self)
 static struct action *
 actions_new(struct actions *self)
 {
-	if (self->size >= self->len) {
+	if (self->len >= self->size) {
 		self->size *= 2;
 		self->list = realloc(self->list, self->size * sizeof(struct action));
 	}
@@ -131,7 +131,7 @@ actions_parse(struct actions *self, const char *trigger)
 {
 	enum action_type type = ACTION_NONE;
 	char *token;
-	char trigger_c[strlen(trigger)];
+	char trigger_c[strlen(trigger) + 1];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;

