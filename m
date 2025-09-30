Return-Path: <linux-kernel+bounces-837951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F9BAE1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254693269A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A630C10B;
	Tue, 30 Sep 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYttMf2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368530AAC2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=Fu1R4jWjQzhAxIf9iB4IcSXYlVfFaoMu+5RbwPhOXGkb1/63iPoufKMfYCYxYKJYpnGOYwW9QigoAuskLkvI+Uae7eoQDNEjQUb6BI1twKKERpPb7N6rggDIj8gsZKpYWXIDfWVjeje4DX/QZJYOAmeYHq3C05MbjQuJl+M9RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=yHsMTGqvohOFfGloUw1p3CtiQgsrh/OUcTuurZP/zf0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b9+OwRVGWnpLqWVdD6w6Up+LJqoFhU/Orhmv/Qpz886AGzk0wKzoB+j9WhWRBCoAVGFXeIErUpChpd375+n6MfYn2JUsVHvNS70tLddoamj7IxC5g2DS8uE2DMhF8bV1iFmoOHM7orqGl1Vz378wFmQPOQSuabeeq9lc34Nt664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYttMf2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6EC113D0;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=yHsMTGqvohOFfGloUw1p3CtiQgsrh/OUcTuurZP/zf0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=CYttMf2fTXDaIU4UB4/TrCKYjnT1zDUvl7QeKBPLPocnar8blRJ2sFK7Ryaxy80x/
	 hgoN/UPuujXSts2Wtn/pg/imbhuN9kssEJnbdC66msRvhxhMXFWvBsBJ1iQxoyOnM1
	 d97jsF9tfylDXBc5Y2oCcIH+fCc/UFVUkD6T4bIZRNFih/KRep3UbmYRqWuBjZ+5k7
	 nfd8mmMx/1OJU0JbSpYHXMfBmyGWG3N7c9sy6ijz4NZUfJ/YkIWmtPa0zpbhu2M7Gk
	 mNe159f1+eMSCMDjPkas7WiQBWMIo7m+VW480o0wYBps2N0ylAAS/Vcrc3GM0DYXvf
	 eDs6Ps9y+mL/Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIHo-0mOL;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170302.037046621@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Elijah Wright <git@elijahs.space>
Subject: [for-next][PATCH 05/11] tracing: Move buffer in trace_seq to end of struct
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Elijah Wright <git@elijahs.space>

TRACE_SEQ_BUFFER_SIZE is dependent on the architecture for its size. on 64-bit
systems, it is 8148 bytes. forced 8-byte alignment in size_t and seq_buf means
that trace_seq is 8200 bytes on 64-bit systems. moving the buffer to the end
of the struct fixes the issue. there shouldn't be any side effects, i.e.
pointer arithmetic on trace_seq

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250821053917.23301-1-git@elijahs.space
Signed-off-by: Elijah Wright <git@elijahs.space>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a93ed5ac3226..557780fe1c77 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -21,10 +21,10 @@
 	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
 
 struct trace_seq {
-	char			buffer[TRACE_SEQ_BUFFER_SIZE];
 	struct seq_buf		seq;
 	size_t			readpos;
 	int			full;
+	char                    buffer[TRACE_SEQ_BUFFER_SIZE];
 };
 
 static inline void
-- 
2.50.1



