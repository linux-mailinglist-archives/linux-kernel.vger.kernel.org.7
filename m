Return-Path: <linux-kernel+bounces-759528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7609CB1DEB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02C7581A76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3974257AC6;
	Thu,  7 Aug 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZIB3MLzX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088B242D88;
	Thu,  7 Aug 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601417; cv=none; b=b6ywwrxrzfUmykHk/vqLC7pzYmzfDR8uXkUzezfuh8pz5Y3c2c+72FCQ6dY2RqYADZ8soYb/X1j3kgkONwQgBAaHb67IzAfii3SCa38WcPGiDRXAQBpbrH8fdd450EWVl6HHDem8uT57yA3d64x3DgxwaaFzS3IHMiWA+M+KUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601417; c=relaxed/simple;
	bh=PwkNYzG3U+cEE2mqijReEHcHctUbOk4Qt/P6iEiOhLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbe5ZYPDjrg5dyjQgkgy27diZZob1F5J975P6FNc7WAaf5mKGqPQt533d3/JaZkS9qhqxUfu3FNjc4dJP40ViAcE3lCaIYbvsnLd188e//HlhbXJ8jYcyUkuvXzveOvXKUY9KrGJV8d4W7bTOKh0pbYpCKzCzle0mUpSofZ2jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZIB3MLzX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1C37C40AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601409; bh=/f0yra3jKRUuZY1CcQozi7KbJsG/mkrO/HorAL/LPY4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZIB3MLzXk4xrYqub8wGLovKbGRG36nVXN00Ms675vVFTpPZEWOZQ27JBg+a5DlVPv
	 O4fsggZB9CK96TGZEnAgQmHU/T7dSxypP/XqIAF66B2mQP4C1uppWCwaoKOX/uZfJr
	 8wwWRe6omsubnaBnH58wF1cToreY3xITnbewGsmxQ49vMm92Qz1Effp/wj/fLsFw+K
	 MR5dtnK8L+sAaevl5xw+s4nNnkdrk65xPdPjpjuoKVtZ4/m1XvFOOZHdKKhDpu+BlX
	 W0fUuxbBDJW/xZBW8hCqz/1o0e1E+n3bArIlS8e0WtLJiDpvqzsO50QwMwE6SYxcp9
	 83dwxeT2LCgYw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 1C37C40AD1;
	Thu,  7 Aug 2025 21:16:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/12] docs: kdoc: thrash up dump_struct()
Date: Thu,  7 Aug 2025 15:16:27 -0600
Message-ID: <20250807211639.47286-1-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In my ongoing effort to truly understand our new kernel-doc, I continue to
make changes to improve the code, and to try to make the understanding task
easier for the next person.  These patches focus on dump_struct() in
particular, which starts out at nearly 300 lines long - to much to fit into
my little brain anyway.  Hopefully the result is easier to manage.

There are no changes in the rendered docs.

Changes in v2:

 - Reduce the regex backslash removal to keep them in place for
   {}()[] even when not required.

 - Restore some of the single-use variables set from regex matches

Mauro, I have applied your Reviewed-by to everything except patch 10,
hopefully it is more to your liking now.

[Helpful hint for the future: if you are going to make a bunch of
subtle changes to regexes used throughout a patch series, do it at
the end...you'll go through far less rebasing pain that way when you
have to change them... :) ]

Jonathan Corbet (12):
  docs: kdoc: consolidate the stripping of private struct/union members
  docs: kdoc: Move a regex line in dump_struct()
  docs: kdoc: backslashectomy in kdoc_parser
  docs: kdoc: move the prefix transforms out of dump_struct()
  docs: kdoc: split top-level prototype parsing out of dump_struct()
  docs: kdoc: split struct-member rewriting out of dump_struct()
  docs: kdoc: rework the rewrite_struct_members() main loop
  docs: kdoc: remove an extraneous strip() call
  docs: kdoc: Some rewrite_struct_members() commenting
  docs: kdoc: further rewrite_struct_members() cleanup
  docs: kdoc: extract output formatting from dump_struct()
  docs: kdoc: a few final dump_struct() touches

 scripts/lib/kdoc/kdoc_parser.py | 497 +++++++++++++++++---------------
 1 file changed, 258 insertions(+), 239 deletions(-)

-- 
2.50.1


