Return-Path: <linux-kernel+bounces-848985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32845BCEF69
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB2C3E597A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F41DE3B7;
	Sat, 11 Oct 2025 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7UmDJJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDF7D07D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154427; cv=none; b=Lpmvng+qyXJ7TqquqvDO2LbhQ/hwVUA7IhHQyZeQJJWfQ9XTMt5PlesQmRoqMJr4VehGhx7aAw6lBL03Efs4hKVoHWue5tAcDNJG3wXt5nDqyFjFn5RhDBJ2ApJ68u2omYREhCE1aB5rpU0BlgdB6zc0WdTLUlhtlKr/Tnlz4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154427; c=relaxed/simple;
	bh=Y9R6jnrHx6wNiJ6fkibSYMWyr5pV3Dkc0hSiZh5ugqE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qMtcXnzZHlEJXUgT/Zc2apzgcURx03qAokTpxL6fqUzvnEbjqORdhUfOOSREXM9yzp3mTZMX5Vzd4qsG1i2bA5JgyoMfUJ+pFLwGlUtn78MmkNVuTgsJm/ZpIN8oES4K2A89tLFbIYUwUEXW/rMn2tqAW1wtDTCnS9GD7/zU6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7UmDJJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFDAC4CEF4;
	Sat, 11 Oct 2025 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154426;
	bh=Y9R6jnrHx6wNiJ6fkibSYMWyr5pV3Dkc0hSiZh5ugqE=;
	h=Date:From:To:Cc:Subject:From;
	b=p7UmDJJqAJ4fmUYHZlCeOkxV31J/sxo0CwbEJbWi8oif9fEbq4RH6Miuos2G9Wk2A
	 tUUVuY/TBfy5YaYINZYy0sWqemosbysC/s253EyKCaIZ9NgW/Zzo/p1V7YtvshziC5
	 sTIzcuF691GjyAnreEA/Dp2MLg/MaCszRHJKI+XuFDykGxqS2bi1gwjxMASe+ogFAE
	 LQY4W2OVjf1HKaptF5Ao4SlMROjCiyeJ5iZKKi3AFPkmEAMPGT60wouv1KXHcJutNV
	 NVeuRyOwshtotSkqndjcn/9ZRWuvDcB1sZE1iq7Zy0iISJz5D4D6OjHJIg+445/bhV
	 jcKS5tUSyR0Dg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7QZa-00000000jYR-36RV;
	Fri, 10 Oct 2025 23:47:10 -0400
Message-ID: <20251011034633.619611825@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 10 Oct 2025 23:46:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.18:

- Fix tracing_mark_raw_write() to use per CPU buffer

  The fix to use the per CPU buffer to copy from user space was needed for
  both the trace_maker and trace_maker_raw file. The trace_maker file is
  used to write ASCII text into the trace buffer, but the trace_maker_raw is
  used to write binary structures directly into the ring buffer.

  The fix for reading from user space into per CPU buffers properly fixed
  the trace_marker write function, but the trace_marker_raw file wasn't
  fixed properly. The user space data was correctly written into the per CPU
  buffer, but the code that wrote into the ring buffer still used the user
  space pointer and not the per CPU buffer that had the user space data
  already written.

  There are several tests in the test suite to test the trace_marker file
  but it appears that there's no tests that test the trace_marker_raw file
  (this needs to be fixed), and this bug was missed.

- Stop the fortify string warning from writing into trace_marker_raw

  After converting the copy_from_user_nofault() into a memcpy(), another
  issue appeared. As writes to the trace_marker_raw expects binary data, the
  first entry is a 4 byte identifier. The entry structure is defined as:

  struct {
	struct trace_entry ent;
	int id;
	char dynamic_array[];
  };

  The size of this structure is reserved on the ring buffer and the pointer
  to the structure on the ring buffer is assigned to "entry". Then the data
  is copied via a memcpy() with:

  memcpy(&entry->id, buf, size);

  But the fortify string detects that the size is bigger than the size of
  the entry->id and produces a false positive warning.

  Hide the write from fortify string with:

  void *ptr = entry;
  ptr += offsetof(typeof(*entry), id);
  memcpy(ptr, buf, size);


Steven Rostedt (2):
      tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
      tracing: Stop fortify-string from warning in tracing_mark_raw_write()

----
 kernel/trace/trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

