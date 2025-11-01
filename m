Return-Path: <linux-kernel+bounces-881198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD03C27B27
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD87B4E4CA1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382392D73A8;
	Sat,  1 Nov 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABdQt3g0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F12D46C0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990488; cv=none; b=lFqLhRalG7ntshufuhmXkhjHK53cd3W36SbfE3BF7cTuazi6AEJpJ60I0MG5iDAM/KCeE2lohAVxX2Cz9J5+rZw7gXpCMuAyH70/WbrVYEKhnp1dqyk9bwb/qrhIhK0KrnVB+HZlNl1ZAsNvHj0KuiR/J+/OFGidMOI8aQ33C7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990488; c=relaxed/simple;
	bh=VFD6GtIua5YG7zFmjDzL7GA/HqAr0MELlfN71DmH60w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq4Z5ppz8RoR9xecNDuhQ3gRZwLoQ8ayGalBUw5mdR2PupcK/i5mRJrN8sOeijOkyH0UL5x3wCFFf3Z2UAv/Lkd5BHvHBjdFHbcPRttpbyqki8JC8zp8IQAhE5YWkLDM5t0ObmNg1htds8Ms9YlqWBU71PXPXfPPX5SAvRRJU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABdQt3g0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so3180429a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990485; x=1762595285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i163pqyR8qyoX26TG357PYVJu78JzhXd/RDPq6ZRj24=;
        b=ABdQt3g0TTlpYbMo/ARof8OQvjUtMB9l/em7aVs0+wNr3lVgeNbcOcvF5Lqm9n7VVD
         vTvFntx52tMokyCjK4vCOvaS1p8vHy4YVC3qyFa6MhkZqbWaLBELOxsvMsMcYbaRwF6h
         rB07DSBxfK59rWuOm7a+bvr2SXGSUBJmBid9R3kM8DFZ24y4UaJB31OZPtNiM8mWxCMS
         sSK0sTPawyD0exRkqKY0XMwyOeodnBaSUbzdF2AnSjBtUgOPGX1n/+6YXAe7dwZtrvAG
         pYrsqIhEPD+/L+eCaQkdEagedk+UqnuEtZqxFzTfvACRNtzB5mz8CbAOJE6LVC6LKuJO
         23Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990485; x=1762595285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i163pqyR8qyoX26TG357PYVJu78JzhXd/RDPq6ZRj24=;
        b=cuVW0NfNG7lqx1BmrxSapoylxTjz695JFw9I7pYI5AmJu8ytDIpL2nxBmqX02oftTh
         xeftibL+YWr6tCIlWlDEMsC+yL+4vyIdgQ7X3l7KutBVJgTsz07hVnitm4uVO2W8hhRy
         Ly9Ukg7ABTMzfRrKJapAo+O+pmjsJXVUHqX1Uc7ntGNKLMpmo8TxewkT6AGK7lWjFzbU
         regs+oFs2boehQb0vOcRUrtFz791od+9RyceKfp+OqJUwy7yITLxrTDbvxJ0vCfQu2lU
         mxWP2JgW5n8acXAd3SVX4OvHpGGXm1nQj22TQ+1dJ334QeNp+vzsoVdCGDXfEXsnb5DH
         A+Lg==
X-Gm-Message-State: AOJu0YxfRJb4gNJx85bT75/HzXuNUshH5/fUpESGW/8rpBQCxLfNn8v7
	snstcGb4QK+pmFsfcHWy76c7TPxX5xA/Ymqdd+fkM9UU/PqRTGXEbwXV
X-Gm-Gg: ASbGncsZItyzbNHKP36uoQRgj7ZYMh4tZOZgrMO7hi6MOOkc+EXR4xmEeBGL3KZby5h
	jLD7epSguaT6P6dejwBbdQkSYoE+jFhux6aCS9a6ywAFdwbR3F/Omz/OzX7PCMZxi9I9WHvMLBp
	86fx5QylQcrqJ4/GBvtTj0VbsYidkUSIHKAZOaFTVR2z1HdqBbiscU4lk2P83+0lvS2kcTBBF7c
	9acyRr0pWBSZF4z76AbTbV9WTrU02HjCrJieqlsD4o7I6okhMiWawV1+Encw47RhHkHjP/MHO0G
	tNG4uCz8ePDbOJiCY8p9IRF/5unq+y3ab0W0wQ6wEt2H6+BU9+5E43neSBFLJkuh9lLjNxmoJkp
	t6tB4+xVbjU4dpUP2jAPz8C71k00ch+Up8h2opAI9oXr6XAjGGIvwjvbYdINDncvKMYRS+uHF8q
	Dj
X-Google-Smtp-Source: AGHT+IGGaTpxpgNC8ciQSQqiqJUywpj2+O3W4oFH7FhMd41eXjxSmQvEhN4sZcxR4XzrFlG6iXv0kA==
X-Received: by 2002:a17:90b:1c07:b0:340:d511:e163 with SMTP id 98e67ed59e1d1-340d511e58amr540915a91.8.1761990485008;
        Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm4722357b3a.15.2025.11.01.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DB82841FA3A8; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 6/8] Documentation: xfrm_sync: Number the fifth section
Date: Sat,  1 Nov 2025 16:47:42 +0700
Message-ID: <20251101094744.46932-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=bagasdotme@gmail.com; h=from:subject; bh=VFD6GtIua5YG7zFmjDzL7GA/HqAr0MELlfN71DmH60w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1/J61eMXh5r+5VtpuJ9Vae2HZ5pck3/9ZC9+wrTmo CDvkzsLO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARUUNGhp2cd7vve3/YPVXf p5gnfWOM2NMCjeUTV6z6s+aziv7rI38Y/tl3/V3BVPIkw0ZqYnR3IM8kj2mXPBdYrq8qvHHN4sh LWy4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Number the fifth section ("Exception to threshold settings") to be
consistent with the rest of sections.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index de4da4707037ea..112f7c102ad043 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -179,8 +179,8 @@ happened) is set to inform the user what happened.
 Note the two flags are mutually exclusive.
 The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-Exceptions to threshold settings
---------------------------------
+5) Exceptions to threshold settings
+-----------------------------------
 
 If you have an SA that is getting hit by traffic in bursts such that
 there is a period where the timer threshold expires with no packets
-- 
An old man doll... just what I always wanted! - Clara


