Return-Path: <linux-kernel+bounces-882657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E59C2B104
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3D34F3DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAF2FE04D;
	Mon,  3 Nov 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGBUQB9t"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB52FD7A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165765; cv=none; b=QLRk349PIYFc5EUTSIvS9GVJ7HnUVnILd28wkQ20J4+L5RYFdzk2HJEHpj0YHQ+lk7t7SzL9z05YgtJ5+U/PgaZbeDyDZf0va5Pow/t6QZ4YIDGvmx8+y+HqBCmm/fAqa/WedHBeCWzJUnivQ79PN1ITQMK7K7vx7VW337BYUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165765; c=relaxed/simple;
	bh=6ZrNl/ngLoJZnlxjtl0fuspSS9WxfyurEoxLHc0OcuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpHQGjtphxKaPzT0SyCkPErgx7H5OqbPGgNESjH3InJo/rnZHrQsIKW/1uCK9Er8y3YDAEodEA3dyqJQ9vkHw8P4X8G2L9+GqPYFOm/M2S96YkHKJsoOIGEYcBt8NmXxBPHxecqH763XverAVWQveI1Fx1YbhN2MGsotI6ZF6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGBUQB9t; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so3930927b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762165764; x=1762770564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SreQgbs8FZxGugGHfThLujDnp52T3JIHyxXt2kdLSQk=;
        b=JGBUQB9tdagQkH3rgDF5L2lIH3LnQ9BlgztptwM5lRLXaDaaH4F866ShsQsORPHHJn
         3NT2H9+mNFQOVq3K5vjeP8JfLhE9R3dj2kygFOnzszuZ9p4tc7fVTSiM9PYi56BC973m
         iVW3dwGT5DfTA/R0hfi+Ohri+2xjzrDNNTG20Y8RwkOfECaz19cJTWHXnK25H4b/W8Tz
         zkW7Xlj3M+MDjXPQEshsA2Ew01bbV9VP+VwiTlWjMNmUbFVQEeoNADna62ggNJNP1mXM
         4uj1W9KwiKzEYQDwnjKfEbihYeM3bCLtEGrIu2+FhpT6Sm0m1cydTPWj/Em2AXSySDWa
         ijBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165764; x=1762770564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SreQgbs8FZxGugGHfThLujDnp52T3JIHyxXt2kdLSQk=;
        b=gt511sSmwNVEptu+9dqX1g3IPkR/LXxply0kkVXwpap/pRhaDrwiEvbYeXnsLhyWiZ
         8Bi1BTgBDq+CgTGnQb/qx9P0FtmXIyAxy9bFbIXQvgkTao3Wl03J9KTCTPBy4bRvRuet
         oblPfvyXLHTeCuuvcntgYYceLSnZ6qFJym/6wrpcvmhH113fgb5fmJ6oz1TXbXHfN16/
         Te4dghOfgklHMURjvJpnspYXpjs6Z4GbsTYprcagNCbwuaZmherDzM7bXWmOM3FLpGh3
         CC6rrXB6w1TryBFSwY0YFuxFnMN+De5dbELsM+xSLy8dSVr+GrtsRyFc6fUWAAPiYMgy
         1ehQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKTEe2hQKCcMpDyIGz95ogVuxfOaYhaL04nSM1x+7uy6oLd1GW80ulOfleKyW90LJmG05doBSeosuRKu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QJpFTaMhzWviVa5sHS72JWFd+MJ5TVUA6b5HT/Jg9Kqt4rlS
	H0aVNFsDzRq+/MJpNFWdLfrYWS9Ak38ip8ZpSVLNy3L9dQlN5Hv3mXqxT+U2EoCdGiy9dw==
X-Gm-Gg: ASbGncuDZIx7FVuoszkjU6nUPJzz1CNNYVkLzUviRAikH/VF8z9b3zTS9vA0sxeZ1AB
	LvTu1taQIa5FYL8IcxdeFAKxDXZ5RegdcMJZKS4GK6O/K4PiS3RrnwojFzOKPamzwwdZqYjPcpD
	KAigkairpBcq6EhGzBKEzbSMPGU4f9/Mfxh4WMPpItmMKPAyLp3+11+pDRJLsL6qpumH52wMLyk
	FUGv+cF98b1uVrYTsrV2u4l1FiuDDqXdhfJFEAAaGhK+9/MKJ+HDZrDrr0t2TRiaSIE77qNWL2O
	Vr3Y3r0xTMYX1PeMmDHs+Qs76wGODf2cJUwSgTe7utmKfA6VPCZOPTm+kMt8qXhieEuiXDKmiRu
	7BAq69VrpRqlIDkxcOJ0xrJe6EAbY8RYeIX33qmunfQu+3c9KO/NighXODZLnYjIbz3WGA4dgr1
	7GH32Nu81U7hsWnvOxljzQEU+d
X-Google-Smtp-Source: AGHT+IFGkL/RoKNPPYlKPRtLg67sqvY1KtcOvTrjcRhyd1gANep47MlnB8OrM8C2RK9j8TxajEEQVQ==
X-Received: by 2002:a17:90b:55c6:b0:341:124f:474f with SMTP id 98e67ed59e1d1-341124f5694mr4668163a91.32.1762165763650;
        Mon, 03 Nov 2025 02:29:23 -0800 (PST)
Received: from localhost.localdomain ([116.232.39.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8c8eb03sm9798250a12.15.2025.11.03.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:29:23 -0800 (PST)
From: Mingye Wang <arthur200126@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Mingye Wang <arthur200126@gmail.com>
Subject: [PATCH 2/2] Documentation/admin-guide/binfmt-misc/mono: add Caveats
Date: Mon,  3 Nov 2025 18:27:44 +0800
Message-ID: <20251103102753.462-2-arthur200126@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251103102753.462-1-arthur200126@gmail.com>
References: <20251103102753.462-1-arthur200126@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will clash with wine. Spell it out.
---
 Documentation/admin-guide/binfmt-misc/mono.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/binfmt-misc/mono.rst b/Documentation/admin-guide/binfmt-misc/mono.rst
index c6dab568006..a11655c72b5 100644
--- a/Documentation/admin-guide/binfmt-misc/mono.rst
+++ b/Documentation/admin-guide/binfmt-misc/mono.rst
@@ -68,3 +68,16 @@ other program after you have done the following:
 
       If this fails with a permission denied error, check
       that the ``.exe`` file has execute permissions.
+
+Caveats
+^^^^^^^
+
+You may have noticed that our registration line is virtually the same
+as the one for wine, with ``MZ`` as the magic number and no offset.
+This means that if you have both wine and mono installed, only one
+of them will work, depending on which one was registered last.
+
+To solve this problem, you can use a wrapper script for either wine
+or mono that checks the file type and invokes the correct interpreter.
+For example, ``file`` is able to distinguish between .NET CLR binaries
+and regular Windows binaries.
-- 
2.49.0.windows.1


