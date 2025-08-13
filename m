Return-Path: <linux-kernel+bounces-766732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED010B24A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11EE7B9E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80302E7BB1;
	Wed, 13 Aug 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpLHytG+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE81A9FBE;
	Wed, 13 Aug 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091092; cv=none; b=IPQvTz/6d8SxtJEvrbFXTCTn7LyzzbZBrAGqdbnnJxf/QldZJrjZSkbr7jdgwsAH+HtigOFav0cByV3GXQCEp2NG3hxekv5+pGykf1VCFk0bsennUPVCpYMx0UhWoIOHED6+0KNAvT5pwbd5oBjYjSR7CY/oQdmCjsjlLUsmIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091092; c=relaxed/simple;
	bh=paBBxIJ8noDSJ4LteRLE5WZlCC+7BlQPyGjfPYEj38Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEwMZaYS3na/2HGpfmseKnb2V9C2YAVfAsfpYHC+wTOeh1zgv2qez4lqwj3AbdJ4IkORxwVosJ0EF8R42xxFmqRwa+pU98t3M/w0M1SA2PhH+YrUeBOQ4XqLgMM/LTXXoEDCp09EOZFrvkLkjgaWFXxuJzEpAuoua/mgfj+RIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpLHytG+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b429b2470b7so4425842a12.3;
        Wed, 13 Aug 2025 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091090; x=1755695890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dtvKbvd1NoePKeupTUb6wGa3pqvPcbWWYugYL7f94E=;
        b=HpLHytG+x3gWWe2bYJny9Bu7NLzpxcDYjcJ1TrzLIr66tf7gamQ2tBbYe+klq2xXlq
         Zym1mu08BpoJJ00VskyHCnDOSejCOkjnsyCCY1rGFyFrVTgOfBu2fkkcw1lm7YHN8o+1
         u1sGh8R/Au7jz22KEiEA6sas5lFxEUfzh3tI6i9xMtMoq8vKeIt+OQQp/c4n0nBQiIoy
         V84wVS9pRC1Y91yux33c494BtmhSkoha77/qSXZAFqIRtlIVvRA2vdSGwhvZfEKXqQ6/
         kh0vqiSWnEBJJec0fBustvXgDMFeDRknaBgHcj5jU9wFxdsu27Ca6THzdzJyvMD4wPgI
         74Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091090; x=1755695890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dtvKbvd1NoePKeupTUb6wGa3pqvPcbWWYugYL7f94E=;
        b=rJlOgRY8MtMVR7vCw2VE8KC7eJrVhl8sob1q1zw3rK8F29aYXEvF12ioB20e2MqpmS
         7Bs0OONoF6p5awi5TfkgKwvhikqkNHQhlc3pypKgQCuHIOBsrsj49j2pPHfpE3WQFY35
         zheFu/VjMeVEAnMG/jidtc+CPHsmXi8rFLnTNtv7CS1PScjWtJDemWgTN26uai0d/Lct
         cDa0lAXbCBZGKR+Tk5d1ciUGx/9l5RwlH8IZz5r/aLNafPvgDPZqoeVu9tmnBzR0WZVJ
         jMUVEqg2TD+judNmMCbyFTCGR+cHNwPD9Q+AVq7eYt7KKQCLKorw2qnbtQSXtJPTThkL
         Cndw==
X-Forwarded-Encrypted: i=1; AJvYcCWTLUG9hS8dQNhWZ0dawHqt6xKIbsqwaEDpdl7VPEz4PX6xZ6G2DU/OWgqWkOjp8ykh/vD6RVA6ONg=@vger.kernel.org, AJvYcCXh9qw+WMmejxwSXEZ51VaoX9fuzw7WVrycoGUuO4o1C15tRhdlsJ0R34o6l9cJjYAUkk8svH5OXfcp+1/C@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfXlKQR7UdOeDNNnC/ms3JpG4aD/r19AJGtS1ZUSPV3NiI4Nf
	EjIM9G93OODEBknZnTQLy1jNLc/VZf/s8XJGatf8fbQprN9TtWWe3RK7EXIY9A==
X-Gm-Gg: ASbGncstcUWHWp0Puv1FEjNvmvHnpJxnbROg00jcBE729KFHSkZSelHcgCLe5L3310m
	Duqm24jmUeKST3FAKoAyHJ0auYFXH8Ix80IJKNmbyxUGV7gMtHChRKCgOh6b4WR5JYlrPSVAEEQ
	5XAkTx0e1nl6h9wq6KQTIoDEdtnsNXDg1z1EWFbzE4rq0pRYrSyuzGpV9E0VaPtIFsfpJwuu0Oo
	6I4CJ6YCevXaee3aooraMX+rsbccDYnBIGO5lDfnFmbabKtQKnuoAgSl+sa53h7Ya9OUJ52it/h
	72ZtC4TSzjSbs7yP06Jqdrg4tASz9DeLopatkxR0LswLC1GN5OkP47pDNHYsIP6rxcvvK39TCD5
	mGtfuA01IWwpnSvAqZmsnaxNapk105ddO55eLIj5pvVoAcJlA6dj2
X-Google-Smtp-Source: AGHT+IEvca5Q1Y+XwKwhx/vIhFJnb2VLh00ptMOdHF5t8h9B1lUfXKpJKlk9GNPxbQn4/U+nnx/VYg==
X-Received: by 2002:a17:903:3546:b0:240:48f4:40f7 with SMTP id d9443c01a7336-2430d1e2efemr46395445ad.39.1755091090085;
        Wed, 13 Aug 2025 06:18:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:a55a:73ad:3b4e:d936])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21b69sm329057525ad.71.2025.08.13.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:18:09 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org
Cc: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] kernel-parameters: fix kernel-doc warning
Date: Wed, 13 Aug 2025 06:18:01 -0700
Message-Id: <20250813131801.2701-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Fix kernel-doc warning in kernel-parameters.txt

WARNING: Possible repeated word: 'is'

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf..302145870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7506,7 +7506,7 @@
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
 			Where more than one trigger may be specified that are comma deliminated.
 
 			For example:
-- 
2.25.1


