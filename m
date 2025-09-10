Return-Path: <linux-kernel+bounces-809760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D38B511B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B352A189B680
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42F305E1D;
	Wed, 10 Sep 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqIcVkn4"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B472C026F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493766; cv=none; b=IRTCFYCUjIO6O6ixhipovWQo+HZJ9P7YSjRRKmYsfTvMFkeRx5xUPEed1R+YJltE7MbVLEykRZQaCq4VbIK6hMCgrjfq8Xk4PVm0/uUmZMU6JhHULTQ+49rDi0HQ12HDAraTqnt7ZIu+2G/HnDOxIqt1Pm/D147LfMv5R6h79iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493766; c=relaxed/simple;
	bh=wciHuAgMx+2GJhChDhOKQ4rJ/R9yGdHCN3IlbgGwiU8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Kg1h/DWqRdilTXoZo6zSG9p/4CBhfewAAX60nCDRzXju229JIXNWp+pXLKU5FFvVTTEBWBtUbGw8L5o/uL+3Bez8nUkmN9ROhdAFPGObnSvtZRuEqi1PWBUk78O0cA1Vi3GrvqxAhotVjq6KEM5SZHPvC+ZahCKmidK0gqjxiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqIcVkn4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772301f8ae2so5284604b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493764; x=1758098564; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImzPRgDObsfgy5RyQ+yQw0Lu3cbWU0zwkYDqCowNcKE=;
        b=GqIcVkn4ZW1mmv7a9u7Kn1i081/ARcIuFPiI9VUSTfzmSUbf3dkbg3LY1rkjQRbaJr
         XFs0X/Hea9W1Q9MDokEXh7/peFbSlS1X5ETBQrv8OeZcW9NspqOyLbNCU5hb7jD5LZUK
         9uApmZQRrSXfXXT2DfA6DDQsG5/HhfL4Fjeu4jQFmglc1SpSF3/W9kKn0LtQE2h4Nwpf
         XOBW0+Hr1SlWTWvZRZ8gR5f8yDmw4rYO4w291ZgS4Dy6V7crnyN2uEdZiXbSar7GBqPM
         loLjJSjxumkffYdOFuZdshTAVMfeStsuYBVnywbCjaGPJub4c9jgJHeXNOTbkq9643y+
         1nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493764; x=1758098564;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImzPRgDObsfgy5RyQ+yQw0Lu3cbWU0zwkYDqCowNcKE=;
        b=N1dlTWUqDh5LkN4UDpzVlwcCdUbj5Yzju/QmQR8cRgtQjoxQqAirMd8LugQuvRESsg
         zLSu2IfEydoE2AFK2t591L4RCab2ELLoLp4TClJeAinrLYGZn19aHCKQPX14XyNRtKGJ
         j/nZUYKFRUhNBmo0IF+0wymkFMZbFeK6aQnmZYc00I993ZsJhtItwI/5paUgj51jZ/P9
         FfommqvPt/jwZq/aKjlMImWASQ0fjjvun7tfKb8vWruA+gx/N+2hyvwYeW5wEGPiVtaW
         f2wxMgX08Aw7gifRj9XfkggPlcpJQNeIwGmAa4v0oC+r5DH7lOQv8fpmZfwemPw993Rt
         zOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoaEkH7B3aCs5zPkxCAyZ8u6T/MuB/MN8Mg3MXfh+vdmASrPTYiSOiacBmSi9HWUU5nBCwbRGe4WZa+tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvCRC4k9h2TG7QODylSY2Lic1Si4k3aK4IslrPXYlNzy7m+Sr
	icnq43qXT0Pgy0WYYc0M4dSCaKjT2nonvijvFRx+7vzNJzGBQXsC67pH7YwJlVkVgmo=
X-Gm-Gg: ASbGncskNPLpAHY0O04KNSPXT1ubpek0RdpOU8Le4SlMRJ7BicbLjnWY+EBrIvyAGIv
	iFMMu8LeneS0DFB5lmtMQ/LT1oK0m2URasws0AX1rd4XtuLwsr6jKs9RjKPw1+IQDAjd96+wCzi
	XDSijFRi9vOIpS+nCgV1DT2VudrFU0dt6YOb1qRj7pQKwCwSm2xvnZPWIYhgI+zopVQg6rw+6On
	EDMb2fKahGHePZcKALfz1yuw11ZUeDP1Dxfl29M+SB/iI8/ZzcoIwg65slbD+LTWI+TVuHP6BBZ
	ZLx8GjxvHYwmvuLKDw7oaPrBfwidGqOpO9S7kRxXKNqe36IJXYr64T4SebNnrnhzAv7yGIr/0+t
	ghwbv0JASm6W7R2fWRX+spBiRw8b+Wo/qfKxed8ICf28i2ZZTZ3ZXM617Xielxfegzw8eqpqlgA
	==
X-Google-Smtp-Source: AGHT+IETufX5eGXswBWfONkkjs2mG4X/3qG9UfNw/it3L+63kjQY2ng38lS96kK0Oo6oyMasEeziaA==
X-Received: by 2002:a05:6a21:7781:b0:253:6b75:bc00 with SMTP id adf61e73a8af0-2536b75bea1mr17103823637.37.1757493763816;
        Wed, 10 Sep 2025 01:42:43 -0700 (PDT)
Received: from linux.internal.baidu.com ([111.108.111.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a24fc29sm1953653a12.0.2025.09.10.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:42:42 -0700 (PDT)
From: lirongqing <roy.qing.li@gmail.com>
X-Google-Original-From: lirongqing <lirongqing@baidu.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] afs: Remove erroneous seq |= 1 in volume lookup loop
Date: Wed, 10 Sep 2025 16:42:35 +0800
Message-Id: <20250910084235.2630-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Li RongQing <lirongqing@baidu.com>

The `seq |= 1` operation in the volume lookup loop is incorrect because:
seq is already incremented at start, making it odd in next iteration
which triggers lock, but The `|= 1` operation causes seq to be even
and unintended lockless operation

Remove this erroneous operation to maintain proper lock sequencing.

Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v2: add Reviewed-by, and Fixes tag
Diff with v1: rewrite the changelog

 fs/afs/callback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 69e1dd5..2c0d274 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -140,7 +140,6 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 			break;
 		if (!need_seqretry(&cell->volume_lock, seq))
 			break;
-		seq |= 1; /* Want a lock next time */
 	}
 
 	done_seqretry(&cell->volume_lock, seq);
-- 
2.9.4


