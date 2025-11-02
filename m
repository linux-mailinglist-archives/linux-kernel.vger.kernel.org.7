Return-Path: <linux-kernel+bounces-881744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D6C28D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490683B3B29
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9296025C80E;
	Sun,  2 Nov 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="AOMSmV1o"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1651B7F4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080384; cv=none; b=fcXVW6TDRQIYTxhkrTw0/87wWEs9uy2ABCONAQB9t/hZcVMxkJJQHRHV1yxzeSE7IS0/NTI4Si233mNZFtS6Yb8j2yGOB2iq4zCXAJ8yYHHr/jHBHbLNsl26iaIbdoSw60k/xzOZDOSKtsVMZi3zlUaVq6P6Z3p8iQa9XTS9CcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080384; c=relaxed/simple;
	bh=Xju41OJcbcKFLggwhkocmxffXUweGOHaInq5OngF0SQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NqI3L1WCzbwhEM2H2vD1w+FuL1V0ql2WrapYUVhd7pegRx3CI//jgp9Z7bjfpOnOuTabG1cm9daWWwxGcF6EuRXByftj5jDptkwQ9mCY04O4QBuEtKCcoWUbySQmxeNyO442ovDW8GtvWQbhFCMCpyPsyBT4An4/gTZv90/fMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=AOMSmV1o; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762080379; bh=kglU/XKbAYPqwRZENe12Zh7i3/LG5a/0OYN/2JQqVZ8=;
	h=From:Message-Id:From;
	b=AOMSmV1o3BA1JWjRqf0chUcyFny82+wjZhjecBeCR5DdsQezmRTeXInzJ8LXY8K+1
	 CqD+O7SY9Tnj6pkTJV7c2YZQ8uXwWnyB5j9yG+ZNul2IqF7rqYqDpEnqZvQpDvHKoE
	 7SrBj9uNt89RoQE/gP0pSRkBlPgvH9qwF5JgX/ak=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id E15EEC06EE;
	Sun, 02 Nov 2025 11:46:19 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2AkJIO024500;
	Sun, 2 Nov 2025 11:46:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 0/4] tools/nolibc: assorted fixes and small updates
Date: Sun,  2 Nov 2025 11:46:07 +0100
Message-Id: <20251102104611.24454-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Trying to port a program to nolibc triggered a few trivial errors that                                       
are worth being addressed:                                                                                                                 
  - inttypes.h is missing, while being generally recommended over stdint.h                                                                 
    for being more portable. Here we add it, which simply includes stdint.h.                                                               
                                                                                                                                           
  - sys/select.h is supposed to be where struct fd_set and FD_CLR() etc                                                                    
    are defined. Till now it was still in types.h. Let's create the file                                                                   
    and move these definitions there.                                                                                                      
                                                                                                                                           
  - memchr() was still missing, thus a trivial one was added.                                                                              
                                                                                                                                           
Finally the help message from "make help" reported an inaccurate                                                                           
installation path, omitting the dependency on $OUTPUT. This was                                                                            
fixed as well.

---
v2:
  - rebase this old changeset onto latest updates from Thomas
  - moved select() definition do sys/select.h as well and include
    nolibc.h to avoid having just a dummy file like in v1

Willy Tarreau (4):
  tools/nolibc: fix misleading help message regarding installation path
  tools/nolibc: add the more portable inttypes.h
  tools/nolibc: add missing memchr() to string.h
  tools/nolibc: provide the portable sys/select.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/inttypes.h              |   8 ++
 tools/include/nolibc/nolibc.h                |   1 +
 tools/include/nolibc/string.h                |  15 +++
 tools/include/nolibc/sys.h                   |  45 --------
 tools/include/nolibc/sys/select.h            | 103 +++++++++++++++++++
 tools/include/nolibc/types.h                 |  47 ---------
 tools/testing/selftests/nolibc/nolibc-test.c |   2 +
 8 files changed, 132 insertions(+), 93 deletions(-)
 create mode 100644 tools/include/nolibc/inttypes.h
 create mode 100644 tools/include/nolibc/sys/select.h

-- 
2.17.5


