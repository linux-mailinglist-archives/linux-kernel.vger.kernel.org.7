Return-Path: <linux-kernel+bounces-787601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1AB3787B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AC21B62F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7361304BD6;
	Wed, 27 Aug 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdIXpJhQ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C7277803
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264417; cv=none; b=h/IRmFYn7nFovbs/OEEUopNnr+rGaJ/HJY6Qn54Sex1ifXfr8qQ4Z6lqA2CQpT7UIFaicav232P+ErlfkDFRSKx/VhsswV7GenN6fzMTnMymxCLg2fpxn50boPCr47Q0RNH2kzp5FPBnJWoV8zVJz7CKM2kHlauP3hwPt4xp69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264417; c=relaxed/simple;
	bh=yX/qwjcskcMcSyJexqyC0NTHw40p2wM6719vDgdsxWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWPnZrfoiCW70uL1QcBSSdR/ROMiHzZ4dgJ5XMKtep0ikVTgLMXZbm82tacoADxvcE9W5PeAhbG2szUB1++lZgaVTb/CshMNPvaur/0M7jkhvbPtMmkRbYzD71vPvhy9H6xu6mQ3tn8Tk4L2Ql9GETx1ygY0SZbo+pMK+PWou0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdIXpJhQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24626e06f04so41241205ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756264415; x=1756869215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/McTYQdEpEwGe2x8bB8le16r9isb4SHvShhNxkUsgc=;
        b=SdIXpJhQBno+2ieX8WHPZMaGoKFzY5cShL6f/RgRaFieLOM34GkgEMbH+2Z+f+hvcC
         sPsgWFM3deBofzDxx6FEa9eHH5f0zYcEt0GUoYpMm7NEKC22H5MmkB7jR1fDCY27L8cj
         40tJyUUUcvUQqL1eWGhOq0KBCXtu3YMXlyIiVzMYQyLgwtGSKF7GAhe9P7QnHXdUIw4a
         +1FAmRHUGKJprGY8GarwKCCf/9ajD6IHe9XntnoPUY8FMh2Dnfe86aPfkQyaGnUdtG9w
         eIiRz9uOYY35G+G2YuF4gN6SGDzhh0OhMXo+4KlzfYxPXKA2dU7s6DoggpGrl06MB9BN
         3H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756264415; x=1756869215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/McTYQdEpEwGe2x8bB8le16r9isb4SHvShhNxkUsgc=;
        b=vR2bOhgdiItcTGIPyz0g3RpRtFBLw/Tu4vxk5nhes8S4yHInphn/ruUdJ1C011jAdy
         ds4U8SlIroSmYczWGUPMtn9ZabF/C0krfxTRoCHP4rPzNmRQ+cDaNliCR2xEtxwfP+sp
         qSFkQ3HHH0rNQ/oZAbgTU2GKRFBwTOadhk5g3kJER+BtpzxsWMXNECks6NTSRLBY2odr
         Ovux9RwZEpnjQeosoi05I4rMtJ7LoEf7qmqJFoji91yl/xaiZHldSDi/aCjk8Fn+nPmI
         r6joZBHoHrfOqZAsUpLxcnoPU7Ioxl3kY6sOG+a67Cz+Xyjp69CdWUbHNaH1F+RixKxk
         Jnlw==
X-Gm-Message-State: AOJu0YwrGgdNiGkGUqhBVYOfvRib1AKEAzDmvYGt4LJVUNhjZCNk5bjV
	x8j06mBFXjz0DmBfKdUa/pzmpqRD0tUXD3Xw6IFne2gK1E8PXxZDO538
X-Gm-Gg: ASbGncve2EjQRlI4nJoKGIGMnYucU2huvbXqxpDRc5XDI47fz1T0NmjoCCj6nh0SkIL
	NghqsPgMX+vv5rMbZX0tSE+VUsq0MsnaQw/U/5mvaUZx2PT86eUopwsrz3DRPYxmZDqDOIHVOWV
	T47cy0pGP6YvnHOkUqMJQbvUOWoNViB/XUlJB0BxFsOf7ul3A2YxbpR6LJxaFmjilnb4BHesSud
	Z8QE3JwqWTuinTWbIZchmnC/vCwiAziLtaXCLYS7iFhonPzmixwT3adnFWLqKljBGTrnbnOflCa
	T8Ol6Atu4SE6Fn2rccBBgo3GzgdeKD7Vjvs9gKbc0MJEyRxglUXIrzC4/jlsaFppPfjgXlrFn9a
	BDc4ByTBUok3hVnlCXzB4ptjI/v3WsF/y4+DLFYTP5sKQPYCnY0LCF74JyOdbbvt2OmTICnqrgT
	u6SwCT5Q==
X-Google-Smtp-Source: AGHT+IG2H8wGjRa60KI6T0koRJsOFwn2LT50b5OO468YqNT5u67p9oELQGYQjhYbmh2R95CEmTqTsw==
X-Received: by 2002:a17:902:db0c:b0:240:10dc:b7c9 with SMTP id d9443c01a7336-2462ee2ba4dmr165619485ad.9.1756264414733;
        Tue, 26 Aug 2025 20:13:34 -0700 (PDT)
Received: from linux ([223.181.113.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248681adacdsm30226275ad.10.2025.08.26.20.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 20:13:33 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: dot@dotat.at
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH] scripts: Add missing break statement in the switch in unifdef.c
Date: Wed, 27 Aug 2025 08:43:16 +0530
Message-ID: <20250827031316.11293-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing break statement in the case 'V' of the switch in
unifdef.c

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
The current code works only because version() calls exit(0) once
it finishes printing

 scripts/unifdef.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/unifdef.c b/scripts/unifdef.c
index ff15efd6e7d7..465246fa7fd5 100644
--- a/scripts/unifdef.c
+++ b/scripts/unifdef.c
@@ -305,6 +305,7 @@ main(int argc, char *argv[])
 			break;
 		case 'V': /* print version */
 			version();
+			break;
 		default:
 			usage();
 		}
-- 
2.50.1


