Return-Path: <linux-kernel+bounces-754183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD85B18F66
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CCE3BFF22
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F6259CA5;
	Sat,  2 Aug 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQRgsoNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47824EAB1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152086; cv=none; b=gDukE1kIMOcl+/3hXsQryIIFh3H6OCeji101Dhz1jpZXIA8laU+HM/dLvwxZP7nnCDxNIDJT6CvfOavO3+e5rKakZZ7Zuv4gVNdw2igJs4ugGnPHMn5I7BA/Bo3BY9HhOkqZjdUMM1qeAm5jzUTkRKkdJ/O5Irje5TkINQTCMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152086; c=relaxed/simple;
	bh=PKztpBpC175wXXzmRQnvYbRrP5F2lr9XhbjSgxeGSUQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=g9moRTUKwZQQIZ23d9zmv7fhMhgR98lLOePskSnJhU+zwG6UjW1ZH9OmB5MIZBanPwIwxfPBZXJtfmOCc886SMlDvCawoK5rixp1AWbmvrr6sD5iaQUtbus77mra1abmpemLCf4WzLuG0p5ZH7XNQBxDPlq9s2P++NDqYBcSS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQRgsoNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7718EC4CEFE;
	Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754152086;
	bh=PKztpBpC175wXXzmRQnvYbRrP5F2lr9XhbjSgxeGSUQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PQRgsoNfyhAIUUDKCgRBYmKTeg9d6DIhlqIYfn7T9sh8enI4FYOqzTByj5DBbS65g
	 SEcyjmx8wYgwr9dNqE9dDzWtvYS1wv/wC3rtBD6H1lI5rUE8CSnIEsMYbDFaK9hj4F
	 D4g2cJlQT/JkxL472Ure68m4pEpmyLnWH59Xsjl5Gdpa/ozRNKavnvUeo/J6whOA55
	 HogpkGE6y0Vvg1xTsbWneFH2/GhuWpOklnPVkmzyD7CyvCH7mltOhJcdqgWb4DJ+8W
	 AN1vIbX79HC1ncxsu0LHLEkN3gXPcR7BE99iEliUxiZzmoREngNBmW8TsLBk1cd/9B
	 Mbql9yygvhrhA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uiF5y-00000008SZ4-03dc;
	Sat, 02 Aug 2025 12:28:30 -0400
Message-ID: <20250802162829.867162195@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 02 Aug 2025 12:27:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
Subject: [for-next][PATCH 6/6] tracing: Have unsigned int function args displayed as hexadecimal
References: <20250802162734.529626660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Most function arguments that are passed in as unsigned int or unsigned
long are better displayed as hexadecimal than normal integer. For example,
the functions:

static void __create_object(unsigned long ptr, size_t size,
				int min_count, gfp_t gfp, unsigned int objflags);

static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
			    size_t len);

void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);

Show up in the trace as:

    __create_object(ptr=-131387050520576, size=4096, min_count=1, gfp=3264, objflags=0) <-kmem_cache_alloc_noprof
    stack_access_ok(state=0xffffc9000233fc98, _addr=-60473102566256, len=8) <-unwind_next_frame
    __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs

Instead, by displaying unsigned as hexadecimal, they look more like this:

    __create_object(ptr=0xffff8881028d2080, size=0x280, min_count=1, gfp=0x82820, objflags=0x0) <-kmem_cache_alloc_node_noprof
    stack_access_ok(state=0xffffc90000003938, _addr=0xffffc90000003930, len=0x8) <-unwind_next_frame
    __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs

Which is much easier to understand as most unsigned longs are usually just
pointers. Even the "unsigned int cnt" in __local_bh_disable_ip() looks
better as hexadecimal as a lot of flags are passed as unsigned.

Changes since v2: https://lore.kernel.org/20250801111453.01502861@gandalf.local.home

- Use btf_int_encoding() instead of open coding it (Martin KaFai Lau)

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/20250801165601.7770d65c@gandalf.local.home
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 0b3db02030a7..97db0b0ccf3e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -701,6 +701,7 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 	struct btf *btf;
 	s32 tid, nr = 0;
 	int a, p, x;
+	u16 encode;
 
 	trace_seq_printf(s, "(");
 
@@ -744,7 +745,12 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 			trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_INT:
-			trace_seq_printf(s, "%ld", arg);
+			encode = btf_int_encoding(t);
+			/* Print unsigned ints as hex */
+			if (encode & BTF_INT_SIGNED)
+				trace_seq_printf(s, "%ld", arg);
+			else
+				trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
-- 
2.47.2



