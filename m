Return-Path: <linux-kernel+bounces-849858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F8BD11BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5464E5007
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986726E143;
	Mon, 13 Oct 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDZKPQJL"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5ADF59
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760319915; cv=none; b=DYoZSsOvpnVpfUJ66mBo4bdjmUIGJxlsALLRdRruLM6Y8SqY30KX8VncJo/OubJgBTs5TIOwpbqCH1HrKxaslC+masU/Fi+3mq/7fBwJ3K/JRETa2fDTW81FSGfoAas0XKrBLJbVVTl0WsYWfHv9tgQFhtCuASpasjQCXmVqRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760319915; c=relaxed/simple;
	bh=4cFWIHu2r+hIi3lR7nn54Om8JSsWHbd/WNP/kpV9rAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Am4oR0WwuNOZAP1Mgcxoo6Pf5sIpMEatfqtg1lNWllbu8kImfxTKs3/zts7ld/+OOH9NxVaDwYAHGRjEMDhFYYfDXfRpmpCmoLIDBg/zdI9XmES/c/bVc2Qo8XyyNhy/h7NPdsVTX2oCn3ILcRTvjTGQk0B/aVWh7IKPnlm0WyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDZKPQJL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f605f22easo3133497b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760319913; x=1760924713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8WwB9JEN8AlsIlOO6fnHt3vfwGimPuwPhAm6kicKpU=;
        b=EDZKPQJL8cSGmTnl+MpedZ3H3vFFxf9c+Ka2+1tRFaq6qqJOILOuyFMmJBCzoUrz0O
         NgkT51OWgvJQc6estpbDYuYQFnjr7gZuvk8FYPGuf/qnrDbAlu2C0upfgEPIoaCP5Rzc
         ll4/big2pY/OldZWKBCWLirbEddCtO4UNOmvDXsmm8HlSiBwHZs0YHUyPBTC2JNojOAY
         qrIUY9zhKP1+TtCwC4+OgjQZOJqafw8Nu31UTNGhkYKjL9DznvbA2pZw6+H5mhDcjoSY
         wD0BDFe5CALrRiz7/kKEQ7kPswQPzrKR7Bi3DLXjoibNN/93JkNMnyU+KqpxowzVm1ZF
         Rc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760319913; x=1760924713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8WwB9JEN8AlsIlOO6fnHt3vfwGimPuwPhAm6kicKpU=;
        b=E/8WdeqbS2OCNyB3gZ42rH9kJ/d74at+82iMqGlqSKsnTCDdkTGziqp0VUjbUzrhIF
         t8ijwKOFlllYjmJLhAnRgMUGrmvZwUQf30ApBC9v5g0x4sRTDCwhkCtjNKok+IMeDKBG
         MpjiJyQ8mgBiZM8R+iOU7JVcpSP4CQDCeeoxePB1nlzjPU2r6bLuSREZISf5GS2+thrY
         KlLTjiIxBuCIpAPcOFv50UX95XLf2TViKhHLjrt5aTW9DdW0y18paGPmrtB0LSPk9RxO
         QsT7oH3hLSzCV57KrRo/Uq9IZbI5cZvHj0OqR1C+jggeqHVwaQ+3/Kr+n3Qogd28td0l
         msxA==
X-Forwarded-Encrypted: i=1; AJvYcCVtM9LgGM8dSewknxIXemyLNJenWztDAE+5fIrgFLN3836ssQrmb8uehJUSPVwzvq2NszBzpLlWBNMUz0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8BkrIqlJfGm4I4kdKJaLtfbyF5rJJdYgfoRuFEUHEOj6zloL
	gVFdGEHf4xVDUUKeOuoSBBxP1zabMvtidt83JQGBXjDrLuos3J5Yip7OFJQPZvkt5JE=
X-Gm-Gg: ASbGnct3fsRBgjc7HauGQF/RIxJuL3By0E0ZnTUWnxCWIvYlHgdYATjaKwM/X/WTdqi
	g5RF4hBK31qmjCOdSH6Cw/6dmgCac8oeHw2+1WRQkr4BuacCvBpwMwdb14TtxTzwna8AZNdC2AW
	Pgg3xcAQAT+SaiJGfV0tEUiJHNVFuw6+IRygLu6tHXvUYSxJLEgcJMJJufHhodlhfixcSfQiKBo
	QU3IdgDIrNM1DAyS7TCY/MUxDpM67B3lNTar4+tjKiYp8mejQle6JxZDX0OYsDESdl41e98zFW+
	RadEPrm2jVyMNIJ5MzQxkzomiTgKwI0+w5MegVgPcGbVkWPlfKomW4FGCL/LrEa5yhKeqJcjSdF
	DjAyackLSLE3H/gNjgVyt0yMeCYypJcuFKQLMn/bzpJkSE/tPzYP6rVcqDK0mmiSkjM/mbM3Ywj
	XhEk8/KPKh9YVv/fPNDJPR1D2NChJ9qNLeljGCQaoGRxh9FjmCLMuK/i8=
X-Google-Smtp-Source: AGHT+IF4MP0Ujym/6Nd3Q0UMlQ6V1AarYEbhDz3LNzhC/YBLjAa+zqOYHB+wMZ45iJ8HR1IJO2ucdA==
X-Received: by 2002:a05:6a20:2585:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-32da8462b36mr25759861637.54.1760319912912;
        Sun, 12 Oct 2025 18:45:12 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aab6c1sm10343857a91.13.2025.10.12.18.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:45:12 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: khalasa@piap.pl,
	khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH net-next v3] hdlc_ppp: fix potential null pointer in ppp_cp_event logging
Date: Mon, 13 Oct 2025 01:43:19 +0000
Message-Id: <20251013014319.1608706-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update proto_name() to return "LCP" by default instead of NULL.
This change silences the compiler without changing existing behavior
and removes the need for the local 'pname' variable in ppp_cp_event.

Suggested-by: Krzysztof Hałasa <khalasa@piap.pl>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v3:
  - Retarget patch to net-next (cleanup, not bugfix)
  - Remove 'Fixes' tag
  - Drop explicit PID_LCP case in proto_name() per Chris’s suggestion

v2: https://lore.kernel.org/all/20251003092918.1428164-1-kriish.sharma2006@gmail.com/
  - Target the net tree with proper subject prefix "[PATCH net]"
  - Update proto_name() to return "LCP" by default instead of NULL
  - Remove local 'pname' variable in ppp_cp_event
  - Add Suggested-by tag for Krzysztof Hałasa

v1: https://lore.kernel.org/all/20251002180541.1375151-1-kriish.sharma2006@gmail.com/

 drivers/net/wan/hdlc_ppp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 7496a2e9a282..159295c4bd6d 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -126,14 +126,12 @@ static inline struct proto *get_proto(struct net_device *dev, u16 pid)
 static inline const char *proto_name(u16 pid)
 {
 	switch (pid) {
-	case PID_LCP:
-		return "LCP";
 	case PID_IPCP:
 		return "IPCP";
 	case PID_IPV6CP:
 		return "IPV6CP";
 	default:
-		return NULL;
+		return "LCP";
 	}
 }
 
-- 
2.34.1


