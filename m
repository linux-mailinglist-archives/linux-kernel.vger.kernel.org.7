Return-Path: <linux-kernel+bounces-750884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD086B1623D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37687B4FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658B2D9792;
	Wed, 30 Jul 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqILptIe"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912A2D6638;
	Wed, 30 Jul 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884339; cv=none; b=b4iA8e9HwZ5RfPpu+fGU740RsirVTVh4MrO3NgxVIQzXXLAZc77vbYsPFImtIm2zDnhKAf6SsWpDcPAMG45sJI6fzbldylt5rvgOsQS6xAAqACZ7shfbv6Eamx/aiSp2x+ZV75JVUIDCUUecFgVnhAIsbCRtwq6PFyQ2gnTA//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884339; c=relaxed/simple;
	bh=/kKIK3iyWDZh80kGJSr4Nr6UxPfDc+Q7qeJsQYAYEZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfJ7zt1BgpV3jgzV+8D/xBoIAaVHOMTR9RairRtE/AW9wCJ41Ta5CwNiCTTPON7B8B7ql1hV6Vxv39zEBMUXUIZ4le/yvtX7bWRUpEFllNUsHXpghduvZKx+IQr4jxBlfttmM/FVEjb8Q6xYGLnPGmsHOxxxLDFcwSpj+IGN+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqILptIe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so43974955e9.3;
        Wed, 30 Jul 2025 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753884336; x=1754489136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgPAdjT04uK/xHZ9MczMsLAu7RXXKs5Vu2Gc+tL0EWc=;
        b=fqILptIejUktLyuefvMmzfMlSn1CBOwGen62HfbnyluwCaUbLIsOvIlIJUI6f5Y7fN
         oKNXxDNcitvxdqEMkvJTiXsHsW+09dhz+sPen5cRenGGNYH8gytUndUOXTzyFNoOx+58
         T5djBIue50JRqzZUXQQEF5MbVDKcoC57ohEl6XizUl3emD7QjikGJphjYBH//IClYIK8
         jGVsTuwHv/wdMTbSakP/tcaRUL0F1WGugbBReFKX4EDuyd8MNqJbXUSrlMMDWqjvc79S
         m0ZzeSUTGm4cCOQkRdpGWFDowO6oAuB+9csLBBg4s0M+9na/xhxJ/jtoxpd8siYjvd0y
         gc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753884336; x=1754489136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgPAdjT04uK/xHZ9MczMsLAu7RXXKs5Vu2Gc+tL0EWc=;
        b=Wdng+ovQVKk8nVp5NOiQnOD/Ad0i1EocZC16KDIz4B+XF7THJxfTpHee0tC9EMqQXM
         yTC7ElPqfnYSn/umTpoFaRgXlygrDiWD34xRoEEduSS1FP2Wrq9ZI80bKAwXgxnTK/rU
         bSPSWK6tJVEezooli1Mkj2lZdL4DdSe/wEGr1e0HdhVy0++H28RE1l81VIDPrI37DFy2
         maq7jlxvs1x4CueYvJCrpB9mjs4WWqAsDTJysxbkFu0F4onNEVAVsipvgpMgOHL4m0At
         FgxdClg1sfGtJ6gXXI5snxI+EvGLmb2z91+KggjdzIIiSiFYhWu1e4Ko7vDL/BXgVKtI
         PuZA==
X-Forwarded-Encrypted: i=1; AJvYcCWq52Tuii0W0syLxk6bWzpcTrD/Z+lIHmCbSrio8zlw6BsbSkOjSeqTn9K/p5074ZG85GXTRS9vFLUF598=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFNyoVCJT6donx+jkpC9TRUDif/YRRyKmLhp751mcDUKeiR3M
	vkrboWT4VSkIdGOAvnugB5Q/SY1y2ASk/Tm+weAn7Qc1Nl/BA3AqmMA8
X-Gm-Gg: ASbGncsi3476/QM96rIXzJvUVz1y9gZmIMtDwqvBkn3CIPeNqMn7hgl3sbvpa7PPB6J
	qmqg38QkkXubkrvDioaMw9QX6OB07c5T18pZuwuJcTqYdFLwFGSP44EJClvEiJGRckqy3cYKVKb
	bSL/hFIBFZZnwUTTEYqkv6e7qO/YpY0HBBy4GfMVabWG2uxPekonbPQSDiV/YpQMgTZJ+2wcj1K
	Wn25EXwoOb9CEDdg0zspNj/svTWDY13hL2TsNWP6pjMoVBbZEKHKVdPS2T55gfl3Y/S5lmrpiOb
	hy5BrHf89UIxpHJpaKX18bjef4p8qSkucldVDRdARKFGoAS1LKqsI5c+BsGc5JO4+8oplZNx+Dy
	5aDJ6y+NcKAj3tYFgrnMb
X-Google-Smtp-Source: AGHT+IF5YsaV16kcAj7VsFNbW+2t8RuCbQ59/atmO6nnCqedUFtSPxqBqVmDmtBbxcX4QjTz9DBsbA==
X-Received: by 2002:a05:600c:4e4d:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45892bbf655mr33852835e9.17.1753884335276;
        Wed, 30 Jul 2025 07:05:35 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588d8fe544sm41816315e9.1.2025.07.30.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:05:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] afs: Fix dereference of pointer 'server' before it is null checked
Date: Wed, 30 Jul 2025 15:05:00 +0100
Message-ID: <20250730140500.2078687-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the pointer 'server' is being dereferenced before it is being
null checked, leading to a potential null dereference issue. Fix this
by dereferencing it after it is null checked.

Fixes: 2757a4dc1849 ("afs: Fix access after dec in put functions")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/afs/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index a97562f831eb..c4428ebddb1d 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -331,13 +331,14 @@ struct afs_server *afs_use_server(struct afs_server *server, bool activate,
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);
-- 
2.50.0


