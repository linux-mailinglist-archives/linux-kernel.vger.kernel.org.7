Return-Path: <linux-kernel+bounces-897306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E9C5295F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296E43ACAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84C338904;
	Wed, 12 Nov 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itwY0C/A"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B42328612
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955027; cv=none; b=rLPvYu7SjqObQ0oDLq8oPdJSlXs6+Q90DTP+1Nx/DgViAbVaDS4RQppYxja3QUcrvgLY/SD2TCW6fpwtCWyYKNNNQ8gzFomZcx9aL1dl7NxAoFvQgvQRxUec18ZdCE2C/qGCUm8WdVV3vsJF7bztDeEPyxED538ylNwt7usLrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955027; c=relaxed/simple;
	bh=VozFth1LV7p/S52b0/5A9F8rOU2uGB7jckrT9+9w8RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNCfiHne0Edsn4ShjxAMa49xuWAC81VxXrnK/Xfcis3dVzetAk202gtfphvEbBZwsT/LSrVMG8+dBX8V258zEb0mQk1XRFvcUqIMTPnt11hWm5gOqPwQgVTw7KBv7W/6wzQrXTn0EXaXDCKeIOAo/R6uPUailK55uXkEKFkYXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itwY0C/A; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6da42fbd4so299077a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955024; x=1763559824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrx4AQ37NTMlQlrdjLvdwNh3PznoIEilNEwhKspqDuA=;
        b=itwY0C/A8cluZNDwixpvIU7YFfS1V7BiRsLEJYDhqYNCD80/9hHgerrXqw+bCuiqzK
         RYn3/zV368Z69KyhQ3weHlqoq2z7IVE58RNKUFBPPEUClB7vzvu+skR+HOaRyHflI8Sr
         Fo0vywGf7dbQgxKrGpHhjHldDAhpZpvEACA9J1oGRjKv2hBTLvrtmFJ0/G2H2nBdlCaA
         +9c6BE1Skn58EqyfBV8+lUIFLlfXhZo42i5utF2G0homODn+lTLjE7DmJmqwa8WKlAkX
         XmizdxIroBPKo7LnRbwvXSvU/n+SDK6JH4yOfScckMkfPPcr46xmNFqL04TPgBACMrkh
         xWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955024; x=1763559824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrx4AQ37NTMlQlrdjLvdwNh3PznoIEilNEwhKspqDuA=;
        b=VK4regd5hG9xiAzg//ZxBfWttn4IWEkZO/RiBsS028BssIdSikmSUzjRDkthRWt/T9
         GdS79LtCRkmbArYqUqWavZCE+UNgqOAnDFWoPh4WZhXS9Fw+TNe5G+8tq7oxe4GlgKV9
         tM8+JfO9JS8CriRroAoUNQrMedt6gMWdvhiAUkt04ChJWqX53B2tV60Ox1GJL731Ihy7
         Uz0q2GU+WWrf2d8Zl56bLa2OoST4t+7VVyIecT67QNLInB/AnxBOhTdfs7/rO8Q8V2pK
         Sr63x24ZqVxQHvnQSsyZSvqJxvw991gftfmMxRdjXTaTwrxxzyLynhp4wCFgS+DY7Gpy
         VupQ==
X-Gm-Message-State: AOJu0YyLPh7UTzp3qEjg8tU2+QYCZougqaj7ZhCnnHi15/7oz3ngdgMd
	EXU8eHlkyNsXo9+LUIqfW1ff3Bc3tJ3uIaaqBfjmVdbdL8nFmVvdwY2BTDzApxcM
X-Gm-Gg: ASbGncvZxX2KbcVkz++SrD3iTHC1b0Blu+SrOY6CCWoG6oNm+THrZjZPWaCTFrysdie
	zob6lgx+C52PNUZD/JaL9+R/IKxRzEXruJkpyuBZbA271k4LlNTntMV2BnRt2h4GVEkEENWRnfy
	d5Y6URWHDa1ev66rZ2Xb50eFOqhsIWkJeR7lSDsRBiKoRROVSTfOj5xFyvtlXIhzasTvG2degwC
	bkW/XMKjfTvzHS477HrKosA083E4ww6jrWUzOWqgr+A816AQa7AmrLhv0TSV8BiRRiQsHAb66mU
	YYC1vwjO0Xupaq8DkLRCH03hVOuZuqijObWlwBBh/8OJyWPw9OGdK5QCHF1bUMgRAhLpbRkeYm5
	bbmBNZDgzeVdJaXcBJHJoNTNQXvjQ6PBUlJnYvoqjmxD+dqRwuVUq8rfwwf/12SL/QQAE1vM7CC
	8CJB9IAlKY2T837wVIYTE=
X-Google-Smtp-Source: AGHT+IGGEG0M4F+2nw/6k2Jj5qk4SYppzNCowShS2/IeRUKr/7WvnQpWJnPJxfp116J4+oYTibRTWQ==
X-Received: by 2002:a05:6808:4897:10b0:450:6533:f4ec with SMTP id 5614622812f47-450745ae683mr1077968b6e.39.1762955024481;
        Wed, 12 Nov 2025 05:43:44 -0800 (PST)
Received: from fedora ([2804:1b3:a701:421a:3b43:be3f:fcb3:28a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c70641ad1asm5482402a34.21.2025.11.12.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:43:44 -0800 (PST)
From: Gustavo Padovan <gfpadovan@gmail.com>
X-Google-Original-From: Gustavo Padovan <gustavo.padovan@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	gustavo@padovan.org,
	dri-devel@lists.freedesktop.org,
	sumit.semwal@linaro.org
Subject: [PATCH] MAINTAINERS: remove myself from sync framework
Date: Wed, 12 Nov 2025 10:43:30 -0300
Message-ID: <20251112134330.64130-1-gustavo.padovan@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Padovan <gustavo@padovan.org>

I haven't been involved in the work anymore for some time.
It is only fair that I remove myself from it and let other
continue to take care of it.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0c8b85baa6b..4c565ed24ca5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24824,7 +24824,6 @@ F:	drivers/regulator/sy8106a-regulator.c
 
 SYNC FILE FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-R:	Gustavo Padovan <gustavo@padovan.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-- 
2.51.1


