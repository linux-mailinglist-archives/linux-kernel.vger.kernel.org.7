Return-Path: <linux-kernel+bounces-778999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE915B2EDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA618897FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84029BD88;
	Thu, 21 Aug 2025 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="PrHBoU7K";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OLE/uajL"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE0156F45
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754808; cv=none; b=UwJulaRs9PxEH3TdNujyVRdguukqZc2bw4nBUmD7NNqtx66Ym7QKRJTFaCCl1nqKuQQnW2Unx95M4lIDVa/S6eXftRTJuR9EcwZ2KCzgac130YLYLxcRGg1+MK2pS1pG/KZi9lX9crxDsP+yhE5JexWFKkBu1TquNDefOQJPrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754808; c=relaxed/simple;
	bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YT5FJ8mCZe5mZvbPzizJswi/1jWEKdSGzAFE5JNeaMVxirnbRhXIhYnec4X5E86JfI7ZJ5aQ/lt+PIxef/9dT+VAYLfcwAPJFK356wskQpKcPQWpBacrZQRD6A0k7ixgO7NQdu3Se5ReODNOjU1aGHpJiIfyD/sm+AVO8RZyoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=PrHBoU7K; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OLE/uajL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PrHBoU7KhIsI1vFvA5Nn0cV4QxXhIn3ovXrXf4BHzdSUdbNyISYzhFYJRgvnN4N4J3L6bB5TR3PhYuXKkQVvrx+fA1GL0n3VIEB0CQOdT1tILBDD9odVZXskXBnpqHtS643oGUSmHjn6NBxhwPGhvyUJQuqZqis2mTNafGEZz51XzK7IracmkUN79xZwfGb9KBTbB8SsNy7v9xHZaHOFxLjnLpuV4xgiLLDuiWmAPL/mqwA+UCnpN/gN1lAw7hsdEQFqYBOmCCMfxNcJjYiAvPGdQ4/Ujg5A1xjQcxlFia+yDablstqrpaARR86W5x6uOWZMcWqH+PHGDch0LShNhA==; s=purelymail3; d=elijahs.space; v=1; bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=OLE/uajLqzUOzajd+clPqsnqyDpoNjKJUzem2VfUUNJZxmbudVdXTRJKqmPJL53YBWOGl+GZIahjTY4I/ExK6nuyHECropwVzc6R6RHfOb7GqD1wLZoQD0vmJC1t84qCpo5RjYjYMAZA7xQLxCk6RDMGURMwMT/TvE5f8YrVZiyFO0Uqs/HvKY0eetH2WUinsO3ry7UJ2d4K8Sm0O8PBcMZYGDdV2nmDrV5fxXZIoxkTQ6R1B3R15DuFpBqrbrn7QMGnO3PdzGfpBQN2KI1ZjWnv/DHJ1DxD3uLcdjycwzzsfNpe+HHOzLGelBas9r4rYnxKKQ+p4lBJh3YHjfo9hw==; s=purelymail3; d=purelymail.com; v=1; bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 147366:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -770991182;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 21 Aug 2025 05:39:31 +0000 (UTC)
From: Elijah Wright <git@elijahs.space>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Elijah Wright <git@elijahs.space>
Subject: [PATCH] tracing: move buffer in trace_seq to end of struct
Date: Wed, 20 Aug 2025 22:39:07 -0700
Message-ID: <20250821053917.23301-1-git@elijahs.space>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

TRACE_SEQ_BUFFER_SIZE is dependent on the architecture for its size. on 64-=
bit
systems, it is 8148 bytes. forced 8-byte alignment in size_t and seq_buf me=
ans
that trace_seq is 8200 bytes on 64-bit systems. moving the buffer to the en=
d
of the struct fixes the issue. there shouldn't be any side effects, i.e.
pointer arithmetic on trace_seq

Signed-off-by: Elijah Wright <git@elijahs.space>
---
 include/linux/trace_seq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a93ed5ac3226..557780fe1c77 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -21,10 +21,10 @@
 =09(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
=20
 struct trace_seq {
-=09char=09=09=09buffer[TRACE_SEQ_BUFFER_SIZE];
 =09struct seq_buf=09=09seq;
 =09size_t=09=09=09readpos;
 =09int=09=09=09full;
+=09char                    buffer[TRACE_SEQ_BUFFER_SIZE];
 };
=20
 static inline void
--=20
2.43.0


