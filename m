Return-Path: <linux-kernel+bounces-894840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA7C4C36F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71A04F7046
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB42E764C;
	Tue, 11 Nov 2025 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgohJDKr"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58D257855
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847830; cv=none; b=roTgMjQQzkBSwr3Bem/AG0NQlvIrrIeaVqQwek+98X0QTW1/7EIsp1T/Mp2AvzOeQzBBeDJOF/btHCPRa6s/HUuQ13MXQHwWiiU+KPVkaViQ17y2Th2VbMdEzyym/Tu4SzCdaL13Z6jVXCnhGUeBqgW5UaJ8d0TU3qSqdQZlOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847830; c=relaxed/simple;
	bh=DjujQ4Ip3o0Fr7W1bLZTv2QT33O7HU1A7IoeReKU2rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=limlZ2Tak+fqFzIGeTEQBLI12rymXWqLKvDTlXjffXaU+GWFDB2TlNV/AycHct8FxDqNNmD3PGSUKh1h8y2ddxRorcCxiTgDUFMsCkVtdeL3dfVgOKaXWSTzE3iDjJX3VCgEjrXpLrFlnd/vNPjJ8A3p1LTIUU2jEY48zrFkOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgohJDKr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340ba29d518so2442616a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762847826; x=1763452626; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx/V++xyadOUZoH/bSkYK6cIm5d5YSgG1Ih7qmUz09M=;
        b=YgohJDKrizeipAwDqV1dQxmk247UldJSqlIYLHiL+l8OSSNRsnFsoIou8tZqWMmIRK
         vd14E4w/Ks9fW1uGlJIU+SzF6HR/7a9I3SqgCTi67GxlgG+Ok7hh20Q1ecDYL7hUkq5w
         2U64pROgnliJztuJUgDq99B9GDUoJKWNF1/Bg5XcK8VJ9TGeXEXxEe7zRpYVja/P7pn6
         +leXUHgCi7/yuC7KEUPWdoF3xyuC/9SM/yvfPH1wxcImiSUCBwfnMoLfRn1b43tNiv5x
         vtEzc46D9MSY6kscDNXv1aSzrMRm5JmWHuIB6NKgjHJjFu0mefWv/MeYrX1fQUJ/Zzmq
         Fu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847826; x=1763452626;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx/V++xyadOUZoH/bSkYK6cIm5d5YSgG1Ih7qmUz09M=;
        b=KnAmDmA76WoTOZurDu5y/UgPTlG9Nz0RdSjKqYmoSf1zu3TuDeA97Y1QosPpgpN0mZ
         VSONGmEolgPczAnr1H7knm61d2LifR5sciNijoXqnA6ewxuzfwE+YMAbBbngxq45n2Lr
         8Gx4yg7cwEAM6jrvVlg7YYoi24jtvuFP3z5jHAFqaxrI7sVkNOf1ImQn91PNAAlbuACe
         Kc6ZpJw6EtXfISBmk6oNZ5LCOPUwKyeklCBy8mX0JU/csQdUj9gXa3dEYioPfF9o7hGC
         Dj0USOG+w+jROkwGv7gbnkuoVke1WGz90GdLKew0M+eaFTzMdaD29WvO9dEReSZ19iy5
         MBIA==
X-Forwarded-Encrypted: i=1; AJvYcCXL4c5lFwwy01I0rxuD075ML1z7snGGEsypiYF1TEnHVzFGrMVtEa+7Rb33DnEoanec4UjKMiLoKJTRRss=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFot4ZedC8Ey3CBuqkq6MpKduqyAOv/M39iSEl9uL5OrZLCD3
	ZU+gRfvPQXnI4N8Nn/uCsC7iM445+ae7HVkzG2uoFkK5mkMKWvOt5O3a
X-Gm-Gg: ASbGncu7GfajhaxwWTq9mnug4KF58qjslkHiY5OVL9XwAsBa73MBPubdL43yqdbo3B2
	aKCalak55pjunAAhE38XhUAr8v6r0fBWTAIAf9Ps8vGRCKPW/o0qpKyPVL6mCQ3+I4b8vr3Pavp
	sO4IsnbjZrazWrQz1rsheYB4NjmgQanIRqQt2+XvJlA+rXIv7v+Jkwcl1oIIzHBolDFPsaWswsw
	I1Sjve83R9SvL3Cui1BvVJKB4M2dWLj20TRH+ByVg71EVuN83c97DsC4o/bbPSqj92rtti5VvN5
	YQnys7rUPCyTfcbonpMzcCOlhaTgicIro6hjcUy4Jnf+bxJv+NA+VBhngxF/ggLQBIgbO8PJDK/
	TceHsI2GbxQhCoDd7q/yMFYnfEDchH1OIC0a6iIqfKvBNxQiEYNOb4FdacMhsQk0OPCY/c91Sls
	8=
X-Google-Smtp-Source: AGHT+IHlgCsPGufic8ljFUM/F3tgYW1VFs7jgyf3xF1GaO+oK0dfmfAL1LcwALg8bAVga+ecAJtk8g==
X-Received: by 2002:a17:90b:3c87:b0:341:124f:4746 with SMTP id 98e67ed59e1d1-3436cd0bd38mr11876908a91.31.1762847825598;
        Mon, 10 Nov 2025 23:57:05 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a7a62sm20318454a91.2.2025.11.10.23.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:57:05 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 13:26:42 +0530
Subject: [PATCH v3] tee: qcomtee: fix uninitialized pointers with free
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-uninitialized-free-attr-tee-v3-1-57905b913359@gmail.com>
X-B4-Tracking: v=1; b=H4sIADnsEmkC/5XNPQ7CMAyG4augzATFbiMVJu6BGNLUaS31ByUhA
 qrenbRTR9j8eni+WQTyTEFcDrPwlDjwNOYojgdhOzO2JLnJLVChBlBamo4oyefII0c2PX+okc4
 TSROjlzEfChGo1GS1QZGdhyfHr23jds/dcYiTf2+TCdbvP3oCCRIJiKqyKmqrr+1guD/ZaRCrn
 nAngvpFxCwqLJyrzZmMcntxWZYvCxm82CQBAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=DjujQ4Ip3o0Fr7W1bLZTv2QT33O7HU1A7IoeReKU2rE=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKF3rhu2LG09/gzQZP8axXa7j0R6UG1515US927qBTuI
 McXluzbUcrCIMbFICumyMIoKuWnt0lqQtzhpG8wc1iZQIYwcHEKwESOsDD8r/X3m9BS3uzHO6nw
 mtQKjc3noi/8+tcb9n3iXpduFseZLAz/FPpfBaZFPTK5eayTs0uq/E63+JnotNdvzULy/ZiM3vN
 yAAA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

qcomtee doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v3:
- fixed commit message and description
- Link to v2: https://lore.kernel.org/r/20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com

Changes in v2:
- initializing variables to NULL at the declaration
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com
---
 drivers/tee/qcomtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index ac134452cc9cfd384c28d41547545f2c5748d86c..65f9140d4e1f8909d072004fd24730543e320d74 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -645,7 +645,7 @@ static void qcomtee_get_version(struct tee_device *teedev,
 static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
 					  u32 *version)
 {
-	struct qcomtee_object_invoke_ctx *oic __free(kfree);
+	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
 	struct qcomtee_object *client_env, *service;
 	struct qcomtee_arg u[3] = { 0 };
 	int result;

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


