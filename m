Return-Path: <linux-kernel+bounces-881199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCEC27B48
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592023B089A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BB2D7DDC;
	Sat,  1 Nov 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EthWXMUe"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB222D5921
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990489; cv=none; b=dBrxKkvC0DDUNy5FpsgAzjkrs3J0LwijrEenbO0Ah8CLbsfejJHJJ4DDncLlVuSobLrlvn6/Cr2jRm/arqPM19bmJOzxZgbWe8NkcDQR2CYGa1alPoCkTGY1kABGWW95l5XyXrNslGSBUfCe5kzFVsXrGM0F/R1q+h1XouD+zDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990489; c=relaxed/simple;
	bh=pOYQYpe/p2QLe1BjNGnDKFKMgBDeR7vUGryegGJSYW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK6TzM3m7Dz7SDfDThoZmkmEZEhMEgyTRLaXPCl9e2L9jtqunvtFVmKGtC781tiveZ0M8eaq5bCcd0UkaOwPkP5YlYz7KRJ8xDwCHzyRL0paCsBpqRq24gNaOa6oNFMepmdEco7JlFGKohv23lKF9+imz6YWOsBXEHUTPfDWVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EthWXMUe; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so2904842a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990486; x=1762595286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itKwJGhZdbxlkpaaw8hh/vRlQCwh4eBKAzIwk/pIlYA=;
        b=EthWXMUeY9lkzfb6iFId1nEUr9wmyk7ZbkLOhThmn4nuEKSHGZjVRH9+4iOuZzEoTa
         DSAZBTzBAdFh2gdzFoD11zyLDsC86DbpSNYnX/mvD9926cLCDYmsbVJLtuVjFKdye8Or
         Cvazgtkl5+SIovxrLStWPxp8gu31hppEjVj8j+UHh9n8qr9mEotsrMBuBw4qhB0n9xPy
         nLgtVdq4y928Bul13GZjJV6Am4pEv2WLg0fpg/03781qeTt/QjJcH5PS+rKCy7B7Uj0I
         Za2RVaX2LRnvQ30pUJnxG16nTC7iYSA/017tgBXAvS+z5wNqlVK2AE3jYmEAzcgsxZmq
         pYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990486; x=1762595286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itKwJGhZdbxlkpaaw8hh/vRlQCwh4eBKAzIwk/pIlYA=;
        b=tHXTPdzUsYnUsMur1RUiOjTb8HQ4ZFp78HopbSmR5kdIMcHnJLqUT2cuvoaX7Fvdik
         jnYGfWgvGZ1vDUe/rHAiUn1Rr3H3ITtMajEu1utWRIJeFOTS9dBxQTgmzJmyWwWLwLM7
         0m1Fc3o4Mq9YBJeB0sASI1F+C8utzbPZZ9k/skFNznnDVI1wOSvRS8mrn0fvdNFXEUWn
         JBrdjdY//b4HIm8m9bnYphyOGnZbTYSgF8ooM1iyNvberaWGkYzLxwvlhhHg1jgbUmww
         TS4OxP83YvAkPHl9wp5hrd2y6tcNdQZnbgUJDJlWBjYYUGv4NelLvHpufBcy1ULA6RiP
         YNfA==
X-Gm-Message-State: AOJu0YxJG2uhzSTpT3J9CPCYZkOdzuMLMSVGdCD7arZgxKfx0YlnUuBy
	dq8TyrTtLTAL4HNl7nSIfzHnUumyDNf1Obzi6hdjRApkGsHgea3oE6fI
X-Gm-Gg: ASbGncscxBHPZTowIFvqbzHr6zqK5bg5ABMs1MzlamIXsKIsbgRvENDY3pxgJg0gybo
	sz6P/nwgUobKnL/OtaM2oNWaGuqO8DnY31FirinqqY15nx9Gz7XGC+aMaXXryyXsEud6Wkgg2YF
	FYgp18/2Cj/rFLi1NPkwCGJO+YNNc5MwHbn0zbxrySmeMpiJjGtt3ZeAnG8WPAm1HbuNLjQXeCi
	wCx/ESJJPGCKksPo2eGqbGdCt+mETHXrmX3MjlzChVL4Aj5c/vcb6vXRodmbsmI2WlTqu0OJiwl
	0GNDX8xl/p0p7OeylS1hHWzedAARytA2dxvOU3jg5lP3Gqh35SR4nDFM91zaj47Xk2TkrNyup17
	R197CQDzFQqdAJa35eyCfzO9oMXCF9HCAAoo9HGidlPsBqkamXMyH9CTT9mfhECQCDQuhGN3Phw
	Go
X-Google-Smtp-Source: AGHT+IGmSKAUBfWmJQyRevQMSinNhEHGk8mmuhO/TF63IeIvW13vO2DcRHYCG0bn6xcNqmxzXv7kqg==
X-Received: by 2002:a17:902:e84f:b0:295:507c:4b80 with SMTP id d9443c01a7336-295507c4c3cmr31484355ad.61.1761990485598;
        Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29554cba950sm21531135ad.97.2025.11.01.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C5F6541FA3A7; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
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
Subject: [PATCH net-next v2 5/8] Documentation: xfrm_sync: Trim excess section heading characters
Date: Sat,  1 Nov 2025 16:47:41 +0700
Message-ID: <20251101094744.46932-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=bagasdotme@gmail.com; h=from:subject; bh=pOYQYpe/p2QLe1BjNGnDKFKMgBDeR7vUGryegGJSYW4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13KNlx4KFSxULsk3LP3JtY35sWGfXpg2k+SFYP+X2 3yT70V2lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCKibowMZ0r6ZqdFrjr9f4q2 2kWJGVwLvtyy2M357c0KznVcGYJSGxgZbh9tPhniE+L+LnVzSdOyM2f2XuKyycic2vwn+d9mc6M L7AA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The first section "Message Structure" has excess underline, while the
second and third one ("TLVS reflect the different parameters" and
"Default configurations for the parameters") have trailing colon. Trim
them.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index c811c3edfa571a..de4da4707037ea 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -36,7 +36,7 @@ is not driven by packet arrival.
 - the replay sequence for both inbound and outbound
 
 1) Message Structure
-----------------------
+--------------------
 
 nlmsghdr:aevent_id:optional-TLVs.
 
@@ -83,8 +83,8 @@ when going from kernel to user space)
 A program needs to subscribe to multicast group XFRMNLGRP_AEVENTS
 to get notified of these events.
 
-2) TLVS reflect the different parameters:
------------------------------------------
+2) TLVS reflect the different parameters
+----------------------------------------
 
 a) byte value (XFRMA_LTIME_VAL)
 
@@ -106,8 +106,8 @@ d) expiry timer (XFRMA_ETIMER_THRESH)
    This is a timer value in milliseconds which is used as the nagle
    value to rate limit the events.
 
-3) Default configurations for the parameters:
----------------------------------------------
+3) Default configurations for the parameters
+--------------------------------------------
 
 By default these events should be turned off unless there is
 at least one listener registered to listen to the multicast
-- 
An old man doll... just what I always wanted! - Clara


