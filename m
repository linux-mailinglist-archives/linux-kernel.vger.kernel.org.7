Return-Path: <linux-kernel+bounces-862962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE4BF6A51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB75719A470C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB815337BA6;
	Tue, 21 Oct 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWNjZXq8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF90334C34
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051716; cv=none; b=B8BF4ObZ7ddZDfOjgeKqjfMZmrCZa2lIKtfEX1AFZh24H/VsIXPXY/gOD5MCNItiWKxO1HL2bqCSjCIh0kJuofk3ZP1ssRECttxFaNmpwZBvhIP1XEMTR5mq32C9K35KeCC9OrP74PKYH+z9ILNSc7ERMiq3mZezSYr1LcZciQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051716; c=relaxed/simple;
	bh=/6e4Ptuqnezl7IG4EEoTOuL0lZT0IuoppTJCNRC7C4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDiEOKtjikNcpmZ4E7iNc2pqbDXBRGTvRUlU3z0BEdmZxjhffBZF5hFdu5AePoXLVg+R7FoGwVNANjOgf689mycAvzLZDiB/XUNSOyaz7rj26Fv3S1nmcnyLzcXEqASkMFLoAF5rocnKicp1vXbjULPHBLKs74W79Xi4+j//gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWNjZXq8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591c98ebe90so6174567e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051712; x=1761656512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=kWNjZXq80o/qoZVI+9DD+JK1Oet5mMlhG9MQTquN/CWrh42hu7s5/uZQlXgMh1tznv
         0P+ObtgxnXWVARYezIInwqP0Zw2wOf1wnHux69aTuSVHZuiJHgf91wwnCLBAJN50gVPy
         FbyXgd2E8iZFwJleCe/C8r5pgnQE6XiCK5dA9vaAG3n54MvCJj5M2NcgyWCLAXb3Uw1a
         1ZPPel6rCtDKrMrpvyAfJNS1ZuFS5E4UIrMPyRNatK0dS0fNiVUrnAh6FiKD0j7buKtW
         /KDgltGDwivQNyKhGv7TEsbI/ccSMF84JagS2h/nOAh1aAv2otJqAMZajQHvLWFVZDDR
         3yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051712; x=1761656512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=rpn+TGd043J5pJjeKpb0NHDI0zSoDCVSe3rvlJFyhfEbD6wEbbJrFRvBui7RNOYEKj
         j6mM7VSc5ThzrQ2ZVtPkK79LXi9NdIhwoxrnHOWXaQjI3wfyPdssqhCgSqRF0PFpV9jc
         6dORlJfL36BGA/ORegWAGPHc5tOq/aEtS7tA0zr2+rja6nRM/QZroi35khcKUDuIwdmI
         k0daP9VsJqayPZeF7GDlKJX1SpsDfsKZ+rTn96cWpvx1Heqbcu3ZF8HD8076AujOyYtY
         pNUmJRJPwLbsTgbRpbIqqsqag2rKSyt+NFPJwQih9CR78NK5wnPdyIpwWPqeN38wVEcb
         WTvw==
X-Forwarded-Encrypted: i=1; AJvYcCU4keiBd5Lcw5S7JPrrljHQkfJqoQyY7IhxsrPn52dv4LoztRxoxp0OqmAKVBnD5PP26cOoX9RM+WF+ZTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvd9RDMIITrPEfs5HDYQMa+f6oxF9cq8iht1BcFWZWJEYHXUh
	+m8oFts6aWAYvRvmSUQMEu5DrAXw2gwuyF3/SQ9AEefZMnfEj7cS3XU+
X-Gm-Gg: ASbGnctXaaRSNbpzjfU6JFzBf9+4C4g0V8Pv3EaeTBcGJjlTijz6ypP8IkTyh9GTPx/
	CIq6w44TwMOfARUrRKCujbHmb4EKDLxG03Igd+ISYDKyvgWdw9yjiEdCwcgElzkp3zpav+mboW8
	vmJjhf59bvHP6bnVRQyKUUB1uZPt/fbDdaonL8V5VtgOzrhGn94EzQoGN2NvDOizEW5+Pk/gZXQ
	GDLxWRtgYTZ7Q6Ht0tn4hAautTGSCLEb9SwQFxCoU736iujBuMDxuiDB9c6zCyUKf1QcAA5qbxj
	mGM+Tt25YN2Ppen7YEDO+F3+yJOwjPDSKv4maLBNStvaaoW+wwp1bqoNEoFHhbKPYOpHGCcb7hE
	WzdKLxSWKi0crp7GXr8FzsvZ4FszPcPRpe8gucnwqGgDbbk11/2Th7WntBkw9pZJ68bjxsokYDh
	vG9LetA9xBw05OmMiTENZYYXrkaFU=
X-Google-Smtp-Source: AGHT+IGS9wuVDvvevxvg8K71lROg6rYpbM4tkxXD2Kfjl5l0kw3W7LqaDVVdOT+MS4gADMX6EMuH1A==
X-Received: by 2002:a05:6512:e8b:b0:57c:2474:372b with SMTP id 2adb3069b0e04-591d8584a95mr5461765e87.49.1761051711762;
        Tue, 21 Oct 2025 06:01:51 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b37dsm3624098e87.87.2025.10.21.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:01:50 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 net] sctp: avoid NULL dereference when chunk data buffer is missing
Date: Tue, 21 Oct 2025 16:00:36 +0300
Message-Id: <20251021130034.6333-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chunk->skb pointer is dereferenced in the if-block where it's supposed
to be NULL only.

chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
instead and do it just before replacing chunk->skb. We're sure that
otherwise chunk->skb is non-NULL because of outer if() condition.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 90017accff61 ("sctp: Add GSO support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - change the condition in if-block and update
its location for preventing potential memory leak
per Marcelo Ricardo Leitner's suggestion.

link to v1: https://lore.kernel.org/lkml/20251015184510.6547-1-bigalex934@gmail.com/

 net/sctp/inqueue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
-- 
2.34.1


