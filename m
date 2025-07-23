Return-Path: <linux-kernel+bounces-743360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF5B0FDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A366AA805A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861C275AE7;
	Wed, 23 Jul 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxTz2h7u"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA146275847;
	Wed, 23 Jul 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313439; cv=none; b=NUZ3tJ+9W4BAm1suFiuxfsZf8a7zOM8VXfT6UI4c35y7mE5XsUs17bqKRyt/K59sJB64EJ5yaf/DKWUicl4flOXXsZmSF+R+FLRnh1aVzCChb/bEhUyuKDMMBXyIPTNZqTEJHeWVwhF/9oBo2YgCY0kXK8gWObaGbcy/bivLdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313439; c=relaxed/simple;
	bh=15Yd243fzFztsSeDCTwtZD4/rH1BwFsGUAUMTZgk4BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2oPUbNPv+vsO4oNOTPuAJwVmC+jk/yG+3PssPvqYplweCr+kwY723B1mqOXdnRmV53dvymiFVr2WLBG5QaSgBwGWo4fU+o5F4oOG+85PMJVAVrs8VGIaYSW3zvfYTKIs8OraEQewGev3stZERzBsbKUEujTpgSzOCjClDUfRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxTz2h7u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234d3261631so3055445ad.1;
        Wed, 23 Jul 2025 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313435; x=1753918235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZdmnC8PcEOZPd/qRotPAi5bThc5SgobYaLTba1a6rA=;
        b=VxTz2h7uYtZ3xF1Vqj6QNz/ac7rgRyZEfkREJscLsA3A6GYnyBL47BZUzrG6XRLXrx
         Bp5bGmsKh5JY/kbh7uD7ekzrgvRmrJfXADvoraIsjOmVXC9rFbo6+GsTritNHWZ5B3ZN
         OzN71nnncPIfU+xqaC/g3mgCfXDiP+idyghlWwd0Cl9FEvOI6ImC1zIoH9UYzI1mf10f
         ayM7oLth/89ysqBYzSMIxGSg8rar7u1fWY2kZ9a3tPUr0EEc6RKmLj6mmZRQvDBJzZfA
         2nzpFjxFez2vwwj9sUjqOLBYQhl1VDkQri0RLUU0ZVvuuMlf4cQ1eZNuGroTePuTrdtE
         v1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313435; x=1753918235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZdmnC8PcEOZPd/qRotPAi5bThc5SgobYaLTba1a6rA=;
        b=HkKv93O09F357z5YUV0fnn6rYFE+vKLYsQBjZR2LDQnAI46mcwD1pBfNQdKrYDSRIK
         ecx+Ye6u7+mNLTgEos2ilqdZZDXLwu2BJHPL1YjRDyJdj7rNGYC5ioW9ssPPI8gZWC3A
         IbPZLvm5XBgRBA0IL0OiJR74GpOw0SpkatHqqlEvdm00EObIqWnun+0Nx7fccuh0gDDk
         Lbhb9NJFH7fMio9vcu3hsILb6MImg79wvbeCx1XiuR4Fa9ny0x7mnpRS/ac/hHlcqtGJ
         +OABYy9TwJlWXpXhPwIsRpzGvbeU/SRm0nlTb6/jaxu7Wleb540N0o5BZlRgBNmc2r2k
         8SmA==
X-Forwarded-Encrypted: i=1; AJvYcCVkbpyUpeK85mHfLmvYF4mWi7qpSsHHYWhvlvVw9PAcZBVfbmjeBeDKyg9vN7w07JrBOOezwksV3898havw@vger.kernel.org, AJvYcCWoji8yFpHZP1YPC/+P/Lp+c3j5GeIaLP1UBxE8Gq+3sHegW16f1StkSDE3CLQe2Adh2ufgufj1by7a@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFpTvKBkwTE5+vCcDzpgKAeqc/m/qpw4bwstEKN+wYPci/CWf
	wxiDQsUxUgptQoygo0zC/MljikFSlaNSQwIxWPAX0yQZP6gZWIKE/vfE
X-Gm-Gg: ASbGnctePQZuswFBvEATDm3Zdr4GIeV0LbjG5JEh6eqURi3jWglpZkcqV5eo6iS+eJO
	vdIJkyE+mm2UGIEWNEkN1iOkHAG/lJwR3OguZqJxD0RcYIAKn0J0HtILKCWgsbRA6xFWBkrPRA1
	LskK2gD7Xy695QIhTLZxXC4GyeZbbvpVi4aOf5m6GWnC6KV94KlqhyttzNYGGEEgRP5IeYc3C8H
	qUc3j0ZskaSSR9gDVERgdZ7+jlCmPrGLkWVaDKT6/lXFWennxR6bPx1b7LCnUsMqYPDHmW1g04f
	UA8r8O9ow8h/6WgFqJ0CAMgWckUJnmpmvc2TbQ/KsQKSM9Mb065Ywqq+aZnDIDI33yY2+HJhTxK
	zl94LLOBkrMF7zI3WBCv3/6uj+DuSjPo7mmqhj1/SHu3PnBwvqyqmboUpIft9xRMrVu71O/bNhX
	s=
X-Google-Smtp-Source: AGHT+IFIyOTSA2qmRbTVKiynYv9ixlJ90tvw04lgs/CHVeXhcLa/lbzWOVby0mnDzFVJ3P7H39lEgg==
X-Received: by 2002:a17:903:2352:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23f9817696bmr78290955ad.21.1753313434862;
        Wed, 23 Jul 2025 16:30:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:34 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 09/13] dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
Date: Wed, 23 Jul 2025 16:30:05 -0700
Message-ID: <20250723233013.142337-10-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Fuji-data64 board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 0c9d6a30dce0..3cc6e62ae5f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,fuji-data64-bmc
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
-- 
2.47.3


