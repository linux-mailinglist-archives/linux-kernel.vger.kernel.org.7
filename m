Return-Path: <linux-kernel+bounces-882184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AD8C29D54
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8074E65C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7828C2BF;
	Mon,  3 Nov 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs5/sJeh"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCA28640B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134672; cv=none; b=A2zEDlPibUqOxVuPoHlEV4c3kibFHTkR9ErD3wcPw3FTYzi9squ6pEtqEa9slBpIeXAANX+oFfA9P5GRhN1jBRaDzc0AfeOSiT4JtnVhE8UW34i7DQYpolFK8OUoQ/nm//V2BSvwaIsQm8ECtYLe8h9gs4vYs88VUXFhkFdbQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134672; c=relaxed/simple;
	bh=Ah+90vlkgOlUyyughdO7zNDVG97YW6CBrkKD+MNo5DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9KFl9bf6htcgyE+8n+MYI569c6ltFh4zVtKk8W1GSimDcioENug1xnE9Pen3KvtsoKshBX3V+NPG9bWh0ERRvvH/GnblKMYzBKy1vpfyQwpTgZT3SJQdctP1DH72kPgErq495FgkEqYxOUS+mUXzzCzgwA3o9kxF8gcMdHKdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs5/sJeh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340299fe579so4065723a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134670; x=1762739470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkKTspHYmfWOFM70ifYk5p3S0g4HpZnFTv7ED0DZ6vo=;
        b=gs5/sJehjPczAUnPl5UQKi8WXsYjITxRso2HCFjwADgMp6z8WLd/+AZ/MAGDhpJdDg
         x7fh1P1WchoR87r2ziDAuiGIj3emFPjeE6RldggqqyoyeMC8ZFC3BH/JNn9yNzbJTEjx
         x3J9ryWtnL9g3fHGCl5dvH/vmJyqU9QaHen4V20yprCPVBZqoy7Rz/06zcJitVwMeAkB
         DwLc4Oy950E9ZN/96RqtXEF2K2KJZQzqIpnJDHQ02aRQ13+qKFclNYI5J6evXvGR73Sv
         Cq40ayyJunuOxwPLpfTDs4pfSo2mX/DMWUMiUBYfABaOtDtm1hEd61n98OVmrQo0E+ua
         9XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134670; x=1762739470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkKTspHYmfWOFM70ifYk5p3S0g4HpZnFTv7ED0DZ6vo=;
        b=C+SMj8hwgDsGPU8m4C7fcljcbihoXHTcLZkM8gJgdqU5hWEbB1whspdVbG9de7y/Pt
         e3qHjU+WSNy4I0CNyv5fGQlknjLBua1ddbiO0niJ+1XyyeA/DtO6/BK0pWGVwCdJBmBu
         LaUKBPOJvPota7lM9Bq4JnpRc7XCtlW+nlM7wYr5E4mnTUf+jE0VrKyuZfQhBXiyyPZl
         JUlDjQVOmnYBtbhKA6yxPdPs9NwC4jf9u9d3chh/SlMJaY+BQlfvIbSb7aJ9gPCAM8RR
         +G2l2oSq/2lk4icHL/eb6eJvFGB0nBEDAXHOeMjgjZUp6k1IHsUjbNVwYPV411aqKwY0
         yaXw==
X-Gm-Message-State: AOJu0YwEte0/aGGu3FXJQC4EFuPofUHTvqaoHzGusuhwDNe+4BiUwnyL
	bEuXd7MVOCL3AukzNy89YclNe9H7KRkjyFJ+S6L+xz74q2IZCrwS1D/o
X-Gm-Gg: ASbGnctu8+m3PgkK8wVlQ7VVr2oedTZkLCjmzvae5XJQgQ/tBPfQx2TlMIgYp2Q1Mbi
	zhSDcYqgdPW+ba8Wl7vY+IkMTU2RiK5Fhi/Ehvce57DTHbBtE9CRFhWfwMC7JE28oUEkTYlNtT2
	ASn7TDyUaVmSI3YMb8mjBR0BQW0HzLFns1mqB68/coQSBNibmbe7KYkgJEHBfMNuj4oZyKs75a+
	O+wcIJYUCl8qitRIjn373/4XPJZSd3mdv4SkyTyMH5ZBQevWVplArqS3MGU0iVF8ZvqkccfAbPZ
	xRx7veu0nrCySr5b0gIx4LnSOF1uhIDD6YxQnbYgcvs3ngdBHw2DKX9c5cseuMu5CE8uSUY5m8/
	LMluh7lznUdVb3Bj02L7PL/hIFVQKbH3g7mCOq5g/n1d1EMvgrxle/Zqd1+BduUjK3VvLFs7gRZ
	dMB3D8wO6VgbM=
X-Google-Smtp-Source: AGHT+IFYqMxHMvi7lUWfNqiIwVN9ffiabVUjelb6YerJOXj6/2jPKUMtAkHCDHXwBoUur/VvjPugFw==
X-Received: by 2002:a17:90b:4988:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-3408309d2c8mr13142947a91.36.1762134670266;
        Sun, 02 Nov 2025 17:51:10 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f096a44sm5613194a91.2.2025.11.02.17.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 307594264564; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
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
Subject: [PATCH net-next v3 5/9] Documentation: xfrm_sync: Trim excess section heading characters
Date: Mon,  3 Nov 2025 08:50:26 +0700
Message-ID: <20251103015029.17018-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=bagasdotme@gmail.com; h=from:subject; bh=Ah+90vlkgOlUyyughdO7zNDVG97YW6CBrkKD+MNo5DQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJVHvmWefnGBd8VN1e3bu5JWGZapP8nNXGlrtbHL5 sv7d68UO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRk7cYGa5zpr1bm2BmGtXP VCEqIXdXuX3r9GWW/w3eeYvMWfXEfhvD/yhNplrRWYnf74VznTz9au3KA5O9dCetcV1rafOk8df GBnYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The first section "Message Structure" has excess underline, while the
second and third one ("TLVS reflect the different parameters" and
"Default configurations for the parameters") have trailing colon. Trim
them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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


