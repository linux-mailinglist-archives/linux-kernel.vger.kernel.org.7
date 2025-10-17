Return-Path: <linux-kernel+bounces-857419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83103BE6C05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF65585127
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672E30FC2C;
	Fri, 17 Oct 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0+vrWH2"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B27233704
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683551; cv=none; b=SkjC+bhwmyBxnanLS3RteNcUzvnVmBc6yxSi4kpQL+ahGVLqMreHMnCY9GBJo4pLv4ZHY71/HrbWPgAAdfTGO3cI1rIe5cNFwPWQm6L+ckHsi8b7jM8eYUm903OiN8xDSgkg7mfXdb41WApx86SlQaeF5WMdzifZNgIMGhE7rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683551; c=relaxed/simple;
	bh=FYvJjju1WVaSiGZ+rPPQkrZA9117N9fCrf8pnzruHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEu3SpWKD1GOLlfGQUyYbxwH6NuwwAwyuhh591+dpp8Vb+Bj8OtTNRpljP8cy0Nyq53NH37fnkrVDnQPj9bP2J9VcGjsd3D6vwzk7oj+aJZyoE0n2BDJ+EeZJBD2T5Y6VLRiT2QyBpl5f2fq2Fh5FUE1hSb4QHi4k2TkX48cxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0+vrWH2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso1108785a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760683549; x=1761288349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OTXlHG1bxvEhqF+MtL8+GAk+TyLUEMZOGcZpRcNlI8=;
        b=N0+vrWH2KiVaSXwLjggSvWpLJc82iPNfw3euYD4UirU7w7bLhwOMSHiT8i/JCQeHna
         iyJ2PfM6OL07cydWFXL78RBCrBqqCEnCWJaLOrpmAgr7PZj7LJeLQfj5jfUVKQpSCt2D
         H3Kqw/d9krBPlxqj6qgOcjlnPKTJ89Px/TWkBHic5myGic5jtWW56tJf3zOMZqd/RyRl
         KjU8Ddkzw7UxwJ08LzzUQJHUFbEVqp/rS7qwFstn5cga1GZkrZZON3+Gl0ayaEkiicMU
         +KK9MD8YJ5TgsmwuHdz9KL7Rlk3er4bg+r9Wra9Tur1HEum1aO6al6zvOA3pQxwyHWnF
         h9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683549; x=1761288349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OTXlHG1bxvEhqF+MtL8+GAk+TyLUEMZOGcZpRcNlI8=;
        b=ISQrZov5sYqjEGXTKaQ9FAoB4YPfYyzGLcH43tOy8Tc52hRFEZx9L10moZ6M7Uvenn
         RiDTHQ1sI8AtGPABsc8OCU2FM6ack4ZBvLklOECDd9NqJH7Vd+oH95BFnSpW+n4fl8sI
         7+PKnbEEWYcUGJNoMF0oTsfR/C3s9Ez5IPUbB7/kXP77k3khbxjqr01/NSN0RuXaLjKC
         w7HCyO5UYI5pJQfOt+XCl49No2wb+M2jyXL/KGd2EBK8H5H+7NwvcPLtfiHSKpDf2MeP
         CzU/GYLCOSS1vS2avVjKIVwLmWLB+AyVXLkGJey4m4bulWO0+wLSfD13QFoNIQGF2UVf
         TeJQ==
X-Gm-Message-State: AOJu0YxnvtnRHBZoliLd7k2UwWW0uEoZkYG2+zccdYxdKi7K/zkyTxDj
	e5kjRPCWYTIN57CNRss2wXnzw/kCyx4MNUDNMTxfgUhdvosmCE+w6DX9
X-Gm-Gg: ASbGncu2RIJPNm2DdsPL3wQ4SwQ9KBcXOj0bEPG61aey1paPU1rth8/Ymyzr4yhtFY2
	8q8IQ3Kn2Zr3EjIRManrnGXqVfFJJb/xGhCzbLkIpORSOSGb8+2NI4Twqb8lW9UTiLwWKOLT1W3
	2LqO45yXA9PUzeAFva5JgvHQpdwKbOzRD26geHCcOkw0vc9D/CwSJ0eXSxT3ILBMpI90hVY3SkB
	GrdEYISdkDogRp8Fg6ZtybW6CkWoqa1GiBuAZqcvdX3VJ/xRCfrXrXmRirmIZKm6UuZuyFRLTK7
	6nj2DRUV3s5XvNXJHcIW4W+3It3jBTC6/3mR28iYFseyM5fv88tcTCO10RtPPhCogvUXIYQVs/0
	v7xK22foqc59nVLe79I88ZWku5GBHHzVc8njvBthnO6ebdoWcI7jLBp4RUpjy80dMv//tH+BTS1
	m3+j8=
X-Google-Smtp-Source: AGHT+IHcXLWHNbzKsIB+C9Oh/hpylcx5d6i9aDz/MdYArA+TbwBPxFJyXT0U63tzhiO5gzo4vkuOVA==
X-Received: by 2002:a17:903:11ce:b0:273:3f62:6eca with SMTP id d9443c01a7336-290c9ca804emr30281085ad.18.1760683549284;
        Thu, 16 Oct 2025 23:45:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afd74esm52471495ad.113.2025.10.16.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:45:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B8F034528BFC; Fri, 17 Oct 2025 13:45:44 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	linux-hams@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 2/2] net: 6pack: Demote "How to turn on 6pack support" section heading
Date: Fri, 17 Oct 2025 13:45:26 +0700
Message-ID: <20251017064525.28836-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017064525.28836-2-bagasdotme@gmail.com>
References: <20251017064525.28836-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=bagasdotme@gmail.com; h=from:subject; bh=FYvJjju1WVaSiGZ+rPPQkrZA9117N9fCrf8pnzruHlg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfnxwUPzdpYU3+lm0tx07E8/eWPhZeNY3Ffk7Q+lczh f0etrhEdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BeAiGxgZ9pXxfn2fOvuMYbr3 88+b8v6I3UroLnkQeuFfcXzLt+bdixgZvq3+l+sxee2LV13GyyxXndI741XyXuYW80GbRZX5P8K msQEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

"How to turn on 6pack support" is a subsection of "Building and
installing the 6pack driver". Yet, the former is in the same heading
level as the latter as sections, making it listed in networking docs
toctree.

Demote it to subsection.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/6pack.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/6pack.rst b/Documentation/networking/6pack.rst
index bc5bf1f1a98fb7..66d5fd4fc82128 100644
--- a/Documentation/networking/6pack.rst
+++ b/Documentation/networking/6pack.rst
@@ -94,7 +94,7 @@ kernels may lead to a compilation error because the interface to a kernel
 function has been changed in the 2.1.8x kernels.
 
 How to turn on 6pack support:
-=============================
+-----------------------------
 
 - In the linux kernel configuration program, select the code maturity level
   options menu and turn on the prompting for development drivers.
-- 
An old man doll... just what I always wanted! - Clara


