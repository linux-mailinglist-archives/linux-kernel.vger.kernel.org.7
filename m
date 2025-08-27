Return-Path: <linux-kernel+bounces-787661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED9B3794B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE953656FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B92D46B7;
	Wed, 27 Aug 2025 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwVPFanO"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED532D0C7B;
	Wed, 27 Aug 2025 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270144; cv=none; b=l+xctTUT1LIsLWRFXBrwmUjeEjccKJe2shtdlj3oxMYoTMkJUrgGQ7qjNODePQo77a5MkXj12Vdfy1NwkaeJMaAByrzjBKLtLkV990O6OilNk5eRasC9Np8DfHS7lyb3Zv4EREEsoP1/9im22vi9PZwRtPCyANE9+TFKt/yEZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270144; c=relaxed/simple;
	bh=MA+7/YYr//CRtGoGjQzO2aBuAhezXjQ7Xlwisx6ri4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+QnVQ0cydKEVkIgwlIBPZ5w4qQlksrXyXBMJ6HHGD3qMpYKm/AwCYa4v6697QXDmuIuNnjK8Ab0bjEyXVwp+Zr892jY6Xy2mdstSt3enoo7TE7cTB60B6Ri5T0XTPgeI+5AARfWfDB3cFD1fUWTEERiIcaBxG5lfY6zSSmb6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwVPFanO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e15ce64eso2298328b3a.0;
        Tue, 26 Aug 2025 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756270143; x=1756874943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3TvCWTr1cdoHdAhmJSDST3DDtYrWvbQgh47NfJBbQk=;
        b=PwVPFanOU4pKQetfyV12+IneAT4cG/o8AKgwrVF2rqepXDRlMjsN5OCZiMjaMwufKO
         zJI1dcb5wQVvDXK96op2VxCVLyqnJehZxysLKMsh/dcq7i1FtRJW5pjT7x7tgB3IuhKl
         IXwdcJWaDlp5ejE/h59wDDRPA+rUGBtHjA6ytOIwo0asLgk4mxqBKkaojMb1D8Ee1abE
         6eID3DfjWIwPuLbiBFiMgd6Msk+ExVjRk0i9AY1rdFnlVaaDc7T2IADTUnW2rDzNefP+
         eJmOHlm8NhT0xXRAD+yEqyjFVUFfZkJ9mec4cjD8t53cNBjNceRZqUPukCJkxuqtwugz
         pJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756270143; x=1756874943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3TvCWTr1cdoHdAhmJSDST3DDtYrWvbQgh47NfJBbQk=;
        b=qnuRzDe0LXJu4XOfaUbK92Fdqr/2ggrBEAYW4LU3qnvnx/bJAZkUkhzfeiYbBw0Vya
         sETsagSdTstcq3CxVlwtE7HtVDdZakX1ZfvIxBLvpF3zXU7u+voLyUNMct5eqGgAK+wB
         W9OILcy45t/XxdBSNnPfE53mZmHIGIyZSm6pHh2ONsbd1XNzz2gVXqFLlVwfc6Nkole2
         OahFdRpBr+hK8juPTfuF932clN50167P+O/E+bOeI88/1gJueq7QkFoEwH7E+16g1B8l
         Ddco9yJdJatDjXqQY2gQpg1yvaKjsv/GMRbcJJ9gNqprhFeRK36Zsi5bZq9oYqpogQUV
         NEXw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ozgmGozps4ydMyJFFHH2cVi3OwL+4ZgCAgty/eq1sVmzuEKQqiP/8ih4k+LZ/efKPGqmLbUkHiLB@vger.kernel.org, AJvYcCV7Lv4ICr77rsVI3BUKDhrhqX0wVcaIQhv889+kRLZmi/X79cchufEt/inGGdX0oLwpUsGJFoZ8nDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaR5DKvPOcFBcJwrFiGxI6IX4ac86RFc50QYo3OkcdstCnsC+
	TiOm4D7ojbK4Spm1C8lWlOd2wyAebjUcYREIiWGOg6EtBQ6nGf6Umnpn
X-Gm-Gg: ASbGncs8O2jiIXPQRHdXbSqaqZzrALLSR4BLtU6Yjqbkku4Ngz59PsQ0OpoDEPOlCKT
	fwEdFjenUefw5dWSeyWz06qxK4DFRczftTj8j9v9D72kvQ1+UMd3pEZ1e8WPGpa/DyPv3aiwQe2
	+2HYQOv493gZQKll+QRq5lWE3jB5ITTCf5jGPiS5Zv7drdFyrY/6Zaa9tAAwpl2tWbGnljMF4gZ
	iilBL4HSTwDfk1WXpV3sJmSiRQsR5NdAiLOIPUV7xjl+qJ5b33MN8T/xU+1wwgsmQ5PkhgQSB3a
	eg462XA8a63m8quwJKzCc5hqN4efBlv0RTMeh5oZw9+oPq/9RRQnp5vS+bUr57Yx1+WNhDWGAMT
	2GDtsz3j2NSSWH2w87yYEgw==
X-Google-Smtp-Source: AGHT+IGi5SECDxZjdkyLW4KqLVO9a6/4HsdHMUeyEI58+0pqQIkQaZ3Re74ROegYk+1eriyJDfXMQw==
X-Received: by 2002:a05:6a20:158b:b0:23f:fc18:779c with SMTP id adf61e73a8af0-24340d2c276mr26869663637.31.1756270142590;
        Tue, 26 Aug 2025 21:49:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2f2ac7dsm4709508b3a.43.2025.08.26.21.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:49:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7F7C44207D19; Wed, 27 Aug 2025 11:48:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] Documentation: management-style: Reword "had better known the details" phrase
Date: Wed, 27 Aug 2025 11:48:48 +0700
Message-ID: <20250827044848.17374-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=bagasdotme@gmail.com; h=from:subject; bh=MA+7/YYr//CRtGoGjQzO2aBuAhezXjQ7Xlwisx6ri4M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnrernUXO96nu+f8OH00W8FF07lyTlMEpFyPvmcUS/r/ fHKF/eed5SyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAira8ZGSa7bTwxtTw7n19m pcLnpHVxS5ltHKUkj+9Kt0iSdN1o1cjIsKWmhWXzyvsTFmy8b/RIt2vadqssZu5dEVxbrUzSFPZ XswAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Management style docs writes on people under a manager, where they know
the details better than the manager himself. Reword it so that it would be
less confusing to non-native English speakers.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:

   - Reword the confusing phrase (Konstantin)

 [1]: https://lore.kernel.org/linux-doc/20250826003437.7695-2-bagasdotme@gmail.com/

 Documentation/process/management-style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
index dfbc69bf49d435..bb7a69e34ef180 100644
--- a/Documentation/process/management-style.rst
+++ b/Documentation/process/management-style.rst
@@ -42,7 +42,7 @@ actually true.
 The name of the game is to **avoid** having to make a decision.  In
 particular, if somebody tells you "choose (a) or (b), we really need you
 to decide on this", you're in trouble as a manager.  The people you
-manage had better know the details better than you, so if they come to
+manage most likely know the details better than you, so if they come to
 you for a technical decision, you're screwed.  You're clearly not
 competent to make that decision for them.
 
@@ -115,7 +115,7 @@ sure as hell shouldn't encourage them by promising them that what they
 work on will be included.  Make them at least think twice before they
 embark on a big endeavor.
 
-Remember: they'd better know more about the details than you do, and
+Remember: they know the details better than you do, and
 they usually already think they have the answer to everything.  The best
 thing you can do as a manager is not to instill confidence, but rather a
 healthy dose of critical thinking on what they do.

base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


