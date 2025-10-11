Return-Path: <linux-kernel+bounces-849305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA5BCFC74
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1A30348690
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C6527FD48;
	Sat, 11 Oct 2025 19:52:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAF22332E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212372; cv=none; b=PstVKINxiiQjUlNvnj7cLNelwwkz0pbBpYcvdkLU9XQHUlFpuRfkjP78Xk7J99sFxUCsfACsOgr/YEAErlZL2sgGfU2q+XwgBxV7lB94E0gu513hxm+cENYNQkJaPa7awMseT3A9c9II/2seEhTWAZvro4+uwvRfiLs/c89SYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212372; c=relaxed/simple;
	bh=kpoGC/lyg5DvwtQNKeqDHthh2J9B6y/AxNs8Ev0tJ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AFsslDa8ak6SRmAi1P+r3ws7cawbJU+1kIuKsZEnSCfepiLqATBN55Uw+8JKC2zmcGqaqgE0d0pr/E7YUqU6Ui4g/0MTDxDGPediiE3VkcOMYRobqRCbjELu3xUyJEMDilrW5zMhW24L5ihjzu0a26buwFOEHp4yquD2Vk7cucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CB047881D2;
	Sat, 11 Oct 2025 19:52:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 35B646000A;
	Sat, 11 Oct 2025 19:52:41 +0000 (UTC)
Date: Sat, 11 Oct 2025 15:52:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: A couple more fixes to v6.18
Message-ID: <20251011155240.59f0ff07@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: huan9oi55x514qamh9cpaps3y7ybbxgz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 35B646000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xgh6JlK4N4c2VCDzzo+rw2f1zq9MKVtk=
X-HE-Tag: 1760212361-933376
X-HE-Meta: U2FsdGVkX19Grnwt1suQwOx6s1w3psbHY2DrZxyZ/GCCcuPbPHk1DM6YovoW8Bvm7nLnBR6SGZGw18Esq30Nqh4kdfqzVxjUGjEETR1+fZPeCd2Yl3j91MoN0Hr/Ibg2aUckIAu9P/LrIG4XZiMZg2Lq9V41co5qWuDz6RHyzrym4rTqUByYF57vXwyEUOO3OZJD5JwAxlALg+9FjrONm6ND1gPs4kM/V6Tj4S8KvaCx0CWmx0pegYeregMtJ7d97RGTf2JMNtLkSy2EnL8OzKBhMVr5Xj22c4fA5JYVZ0Qnic6u4o89NcixKmEfnEwxrcuAdc1x+5TqO3BIiyyk5jclj7IubOUm



Linus,

tracing fixes for v6.18:

The previous fix to trace_marker required updating trace_marker_raw
as well. The difference between trace_marker_raw from trace_marker
is that the raw version is for applications to write binary structures
directly into the ring buffer instead of writing ASCII strings.
This is for applications that will read the raw data from the ring
buffer and get the data structures directly. It's a bit quicker than
using the ASCII version.

Unfortunately, it appears that our test suite has several tests that
test writes to the trace_marker file, but lacks any tests to the
trace_marker_raw file (this needs to be remedied). Two issues came
about the update to the trace_marker_raw file that syzbot found:

- Fix tracing_mark_raw_write() to use per CPU buffer

  The fix to use the per CPU buffer to copy from user space was needed for
  both the trace_maker and trace_maker_raw file.

  The fix for reading from user space into per CPU buffers properly fixed
  the trace_marker write function, but the trace_marker_raw file wasn't
  fixed properly. The user space data was correctly written into the per CPU
  buffer, but the code that wrote into the ring buffer still used the user
  space pointer and not the per CPU buffer that had the user space data
  already written.

- Stop the fortify string warning from writing into trace_marker_raw

  After converting the copy_from_user_nofault() into a memcpy(), another
  issue appeared. As writes to the trace_marker_raw expects binary data, the
  first entry is a 4 byte identifier. The entry structure is defined as:

  struct {
	struct trace_entry ent;
	int id;
	char buf[];
  };

  The size of this structure is reserved on the ring buffer with:

    size = sizeof(*entry) + cnt;

  Then it is copied from the buffer into the ring buffer with:

    memcpy(&entry->id, buf, cnt);

  This use to be a copy_from_user_nofault(), but now converting it to
  a memcpy() triggers the fortify-string code, and causes a warning.

  The allocated space is actually more than what is copied, as the cnt
  used also includes the entry->id portion. Allocating sizeof(*entry)
  plus cnt is actually allocating 4 bytes more than what is needed.

  Change the size function to:

    size = struct_size(entry, buf, cnt - sizeof(entry->id));

  And update the memcpy() to unsafe_memcpy().


Please pull the latest trace-v6.18-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.18-3

Tag SHA1: 3697c271c3c640784960e2f66b787cb34b29bb1f
Head SHA1: 54b91e54b113d4f15ab023a44f508251db6e22e7


Steven Rostedt (2):
      tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
      tracing: Stop fortify-string from warning in tracing_mark_raw_write()

----
 kernel/trace/trace.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0fd582651293..eb256378e65b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7441,7 +7441,8 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 	ssize_t written;
 	size_t size;
 
-	size = sizeof(*entry) + cnt;
+	/* cnt includes both the entry->id and the data behind it. */
+	size = struct_size(entry, buf, cnt - sizeof(entry->id));
 
 	buffer = tr->array_buffer.buffer;
 
@@ -7455,7 +7456,10 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 		return -EBADF;
 
 	entry = ring_buffer_event_data(event);
-	memcpy(&entry->id, buf, cnt);
+	unsafe_memcpy(&entry->id, buf, cnt,
+		      "id and content already reserved on ring buffer"
+		      "'buf' includes the 'id' and the data."
+		      "'entry' was allocated with cnt from 'id'.");
 	written = cnt;
 
 	__buffer_unlock_commit(buffer, event);
@@ -7497,12 +7501,12 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+			written = write_raw_marker_to_buffer(tr, buf, cnt);
 			if (written < 0)
 				break;
 		}
 	} else {
-		written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+		written = write_raw_marker_to_buffer(tr, buf, cnt);
 	}
 
 	return written;

