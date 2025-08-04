Return-Path: <linux-kernel+bounces-754877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F4B19DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D003A3B4B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA0242925;
	Mon,  4 Aug 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2oC6PDY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC12F2D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297064; cv=none; b=p004v48C3zNk3Sn1UN22CrjpLVjXZZzmj9M7KO1xLhR4lWA8Yn0dF4upKKxCIwaNGTC+CFIBGpnburqimk4YFMM1EYO5BW7/Utk/21WpedxD92dDRRAGB7VOJjIhUpCNhMcXe4G28NRj/Cldjq3ab9gEDWQe4j+RBOeKnxIvqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297064; c=relaxed/simple;
	bh=OQwV5bmZgsyIodUOnXaMt77DHO9HRxq4ALffDwjwojE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CU+Q3HvCrIqerwfV/FM1bGczl9gFIj6m7Ny/ebducARPhU02UMlnPFMQfU/AvwW3dlKBuofhLTHoGAxRxjGYAm5Y8euiAt/9pD402aakMuY/PLJtvbDYhspXGeGZz8JiIyTvB0fK7CJuofVTFst4L40cTTxiYIFG0F7pzYgEWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2oC6PDY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-240763b322fso37158785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754297062; x=1754901862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7weEBtXNu6O3OU3+Ic285vjIwi08+prtGPyxCf9KkS0=;
        b=T2oC6PDYXUzH3z1pwotsr39oTfU1XTEmG21rKTOVRdwdN/Z2GO0mzJd7+CxDeEyBsf
         fdsoiWxRAueBA+ctwaIqzG0XjOP8oeoyuisW1BeCzypBLu+CSJRj9OGYtWCDLnIMywA2
         FRPzw+4XCk846DR7ab9/QnEpOR2wBKDu4axoKD7NnBJFZKupI/QW0ZJRMUGzL+iS9rAX
         BuYY89Sn0liQxm5h47EHRIiIcDKWD9egF3k6HeHMpWDXsKzhjIcnwPjeQjzeU6/OJwIU
         2oMZHJ798sKyj7VmiQuzs0pzE/pBRc/xg41b3Gk/lNjLfI7b3VE/eauVHQ/GJP6UYDdW
         cI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297062; x=1754901862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7weEBtXNu6O3OU3+Ic285vjIwi08+prtGPyxCf9KkS0=;
        b=qlF5K5h5lKCsDQ9NRz83CMF9ADoh8srCs+uQ49MTRa0h51e3DV6qGNH1ZeZKD6l6wg
         xgsxEd1LSAIvkuewCcb9ovACgmtYX0mr6cqRwjoxk5POl40T2+wm2Fq1cDBhKmky6QWh
         HKuJV9esjEEgqbgg92Ct46qroR+HczphrQGIKLNVhfRsUGRl71rXP2OtsjS1mj8LGWMZ
         feS+cnevpwrfsu65eNB2I+/qDGWYpk/rUqvzaN/zszY6j+Ja0D5KV7N9rV5ZBb6ZanYW
         ojz82qBGgAz98J9hMArkRJF/Z9j/ZoehT/fccWlL04e7JDlX/nxaJIXnWaLZGh0kD9Jq
         JCaA==
X-Forwarded-Encrypted: i=1; AJvYcCUNRIxlygUTlda7Ig1FQ5DFI3gpdGedxaNI1FDCSr0xp0xhKHKVgeqwQW08sv9vLUIPJZ8akwuK5baQ4Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJucRX/qGRDL+/hcTQDj7Qg/soW8hH7uiUthV5fhbnm9oWVxlK
	U/IrKAvsfvJZa/LcQCpPWJx/30m2VSSpX8UahjKwLI7xc3v8vpN4Lx2U
X-Gm-Gg: ASbGncumKjBxrxMRUUtCY+eg+D36pP0mJyvWgCZEWynm7kIe3OS1aKCAdjyfnCcDc5W
	dfB1S380wXRLmCQo/hmjZqpd3Au0YA7EZphJUtMUJK+QyWympqpdohpzmPEnuv7S0Zy/ogw25zL
	yCf1LsxCBPmyvoKeCgwc3IKrrqvld2yztVwZgdKHIOgVMyOw6n+awhg6ONK0eLVyqIZkPkl1NVA
	iFYEw19whPRq7AHng2j3hzX2/0/hPIGZiyMUK2UK5kpBeAM2v+yz17kJgpkKcb6Zwe57hLI25YU
	/nnPCkP4nBJmFBOZpG1srIL+vTF9sGjpJRZIMt95jFOkSUqGBYBRzBhXInrBXDnxJnkm8gzLxKg
	8FvU0OUk1ISLliCJDkXHX
X-Google-Smtp-Source: AGHT+IHbpi6lB61KVNgUupM53gjsKp3nANik+LeK6AxHjCEZdLwoL524Z+8ZPz52r/mw5Lm6YeX5Hg==
X-Received: by 2002:a17:902:f0cc:b0:235:e76c:4362 with SMTP id d9443c01a7336-24246f3b2f6mr78754155ad.18.1754297061953;
        Mon, 04 Aug 2025 01:44:21 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899b4b8sm103742855ad.137.2025.08.04.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 01:44:21 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
Date: Mon,  4 Aug 2025 12:44:13 +0400
Message-Id: <20250804084413.3627337-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_kernel_lookup_peer() can also return error pointers.
Add an IS_ERR_OR_NULL() check to handle both error and NULL returns.
This prevents possible crashes from invalid pointer dereference.

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 fs/afs/addr_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index e941da5b6dd9..1f8d1a8a92c3 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -298,7 +298,7 @@ int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *alist,
 	srx.transport.sin.sin_addr.s_addr = xdr;
 
 	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
+	if (IS_ERR_OR_NULL(peer))
 		return -ENOMEM;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
@@ -342,7 +342,7 @@ int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *alist,
 	memcpy(&srx.transport.sin6.sin6_addr, xdr, 16);
 
 	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
+	if (IS_ERR_OR_NULL(peer))
 		return -ENOMEM;
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-- 
2.25.1


