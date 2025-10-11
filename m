Return-Path: <linux-kernel+bounces-849301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D15BCFC6B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AFE424432
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017D2857CB;
	Sat, 11 Oct 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3hpDnJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591B28313F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760211778; cv=none; b=XNrf2yDC54vAInl08YpsLwJ/+enJZl+5kswD4r4T20qkWCShbKr4GjbGhKlvwIi7Y03hCA+40dG/gniBbQXnMLgPX5D7lze7yIdiH6fmTi7Mfkuo5i+88SqY3khMItltR9+tpwgcx4afaU3VLINyH0/BBuVsQ7erqBaPxehpqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760211778; c=relaxed/simple;
	bh=H0x5qNizUuSONAlRSltx6ljUr6vcwgUkUcZc834gl6E=;
	h=Message-ID:Date:From:To:Cc:Subject; b=NFchNZFIg/X8yd+nNkAOWxHYqC56BqQdxd7mw5Rl5+PWzd4EAZphwJzG4bq0ZwmubEdJj42tK4q380yjXusdx9imWccLiVBLSshL9u+d31fpt/LoZbNrphKkG5apOpcoJprH3SVhmh0m2mIIMyy5XU4o2+Zav+et9V5R0WDUHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3hpDnJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F4CC4CEF4;
	Sat, 11 Oct 2025 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760211777;
	bh=H0x5qNizUuSONAlRSltx6ljUr6vcwgUkUcZc834gl6E=;
	h=Date:From:To:Cc:Subject:From;
	b=G3hpDnJqKh4DBvyjjkldg0X5NKct71r0eXiTCAmB4bR8Ujp9ywNSFncBKqIzSJV96
	 Ja92hXs7nikTlWyhlBW43+CZbywb5Eodk7VmU94wPWSnnrUuEfIb/Kw+x2lZyCHUyA
	 OzyMVCDGKzYDJ64LVEbR9Npy16fIsg26nq5M7vdwY8/W+sarlwxCKl0dTG9otKiieM
	 mE6kiqeLFZueCBYzsV4i2Q7Qj2az4u6BOv5VFoRJOrrzAcFcwlFEVZ9V9uB/TLrnBw
	 Xz+WywfQrPmulVwFbXKrR/l5HEVdc913zDx/axF9zuSlHls5cF42XEO892f4INJX3G
	 nbL73MCagz5PQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7fUX-0000000021O-0c3P;
	Sat, 11 Oct 2025 15:42:57 -0400
Message-ID: <20251011194236.326710166@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 11 Oct 2025 15:42:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH v2 0/2] tracing: A couple of fixes for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

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


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: 54b91e54b113d4f15ab023a44f508251db6e22e7


Steven Rostedt (2):
      tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
      tracing: Stop fortify-string from warning in tracing_mark_raw_write()

----
 kernel/trace/trace.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

