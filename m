Return-Path: <linux-kernel+bounces-840049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354ACBB36A9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5993188EA80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5422FFF86;
	Thu,  2 Oct 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsUIbsoN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4672FDC5A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396495; cv=none; b=AownbFNl7xXzUdP6l9Yyz5rNYwlSTRcfjxY5tjYR3CGjSeBR6DQ/4ay//NrnJsZRiM+hEonTjt7IBZQrk2pkQiK0ErBgaJwtuTL2Xs6UKGeyhqOi9jgod+MI0k2lf7AY0TYoo+SAr7aFDHmb1Hwv+Aj+PxvgbHN9V4VWWqqBTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396495; c=relaxed/simple;
	bh=siG1bgYonAEUTQ2s8Ux8Lu0beD0iJQSpmvEU3NcNK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxGn1EadEHqDDsfG4UkGyraWRI/O4PtUSwmtc/3t9/+Cfvx6bADERMoECmTk/bOE+U8Gpn/Qrk1wkv3gnelfe9RTQQVst0RJInwn8SqBjygECzRs8cAjG0RR/dpbVZO+iiy4JhFQQj4D4ATduzBdKBHksH9368ray8bOdNfVb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsUIbsoN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57992ba129eso1037428e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396492; x=1760001292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=fsUIbsoNTfjlJbuyLjKLE8zfqVBn7HLAH2HxmR8m2ZYR62jezqgXFgm7EXvQL6h8GG
         Q0SiyOnqGP86GBDy+LjUimDYiul6PtHaA+m0vrHXxJJ44R5ugVcaw+mDQwFCUcgdXOUf
         NjZzQXzdAHT98PNP2mG3avIWxGExCasOoJwCXboycJ+ZgUmUPfw9KdOlvAzVw0Qv3mQV
         Cwx/a4/h05AFU1+UUVe4zylZDfu6Ptw0liLtnE3uOKejOGsihp7581jRqMHH2/Ov6gkM
         safgfZ0aLGwB1HnciSnw0+ItWQas3vP4uqThMdLGhlpLFmFcX04dgIhjDj5AP5JF2RpJ
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396492; x=1760001292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=Q1VaC0N6K56rOzn3FCY7newvqFTWaFb8QY/eEsdAsVW5nvbXROeW2xM89/vIs4gfZw
         APv591QeFE8pX9hVrZ9VJzn4VLH1myOPnyIBu/dlgXPt8iJwxVLYR+3e9Kl1YFbI6t1r
         yfK1AmOI3jHnlcQcXEfKAm3DS+LV/M20rwHSfHowzyFOBulMO4VOCpPBdKIQxdBFL0LO
         eEnkdUYXf2X4iVgmxJBUm+akF4ZpbjE2SVGh0YqtAEfeekauM3b1aowF6EI0Znnnqzna
         1wtd3rIKoXUsMS2D+rdp2DDete/pbbZ7hsUYOTWrBkR4ESVzwr4LLj3jHPxxsCQQGPtW
         w2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUUVcDw6CX+c61gCdTveRjNnvCPngQ0kv+CmBiZvhzS3EotLVcMROdQaMiGcDegH4UN3C+WmyKoAnkd9GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogjsuIGKiy9aTTmYB84L/jv3KlTQmhB7pR8Q96tBCai3uR2jc
	tRYh6mjc5Xw5fGMgGeLE9eG0FrfGynXgIS4ahKFxM08YNQQ117VrcZbv
X-Gm-Gg: ASbGncu/NngVhCSF7lnN6LqsReQfrABfl+mV05kF8UFlLAY1ReesiK2E1D/+mjYRzOk
	C3iK3gRPjt/LHWxQOC9dtLUJG9L2GwW9qRGc1tX2iaY1IzTAhyJ6lunKrMy44p8RRlkHDLKJibk
	dwTC66LlxjQ/OeaSGIJ3cJJ0QIdyMzLiFStvPV/A4BHTUe3CinUiK26A+DdpOacVb/0cmndHHWD
	ufOe6lKQtcwYCbHGG6JGut+3XctaQJSeqyRklMDvyCCVkkydVAAxRmfgMIz690srUCGrHh1yiTr
	wA+ctL1hUW+Y0pbojwl7rHI6Gm4lIdSP/lQy9DOl7ul9lI5GRhR2C7EFRpejgmWqYkgEIIKxwNK
	rkgh/A/gNdGyvMynHEkiCyELDdbjFAnmse6ecCPw4A/ERLbuxibYwc0rdTR9SRMzukeLjt/3vLJ
	EVstj2ERgkbcnS1FwFy9jsr1JnC9Vyi3dyvIBv78Aayd/gwoDsk0U=
X-Google-Smtp-Source: AGHT+IGWYt7Zzu4cL1+wVfYqBSH7iBbYGrSdD+ADAvQhIvYKCsdF8o+ver4QC9QADVpDHqDv4CErAA==
X-Received: by 2002:a05:6512:3d9e:b0:55f:71d2:e5be with SMTP id 2adb3069b0e04-58af9f4ea35mr2108491e87.52.1759396491883;
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e4a5sm650494e87.93.2025.10.02.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
Date: Thu,  2 Oct 2025 12:14:47 +0300
Message-ID: <20251002091448.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

If new_asoc->peer.adaptation_ind=0 and sctp_ulpevent_make_authkey=0 
and sctp_ulpevent_make_authkey() returns 0, then the variable 
ai_ev remains zero and the zero will be dereferenced 
in the sctp_ulpevent_free() function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..056544e1ca15 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.43.0


