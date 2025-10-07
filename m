Return-Path: <linux-kernel+bounces-844023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C95BC0D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D25B4F4C40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0442D94B4;
	Tue,  7 Oct 2025 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="Rl4lxyHt"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D42D8DBD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829023; cv=none; b=kDAqGKKusaGQqYFc65jgER5Q6pS8K6iJZZTl9llPrz6aXrqr1VMNs3feD+Vlpc9xzlR6tgfQTK9VQkOhxZZI/tpltakKQmkQsLL8PgHjvfDZ3XVlnK0MqQ26IwbuclJphCFiaUQ/mpXHw5soQplkK5no9QXOPTy2MLJcVwrvSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829023; c=relaxed/simple;
	bh=DCke+Rgyj5qSCGTteE3WiBXknhrXT31kjNGo+dEDh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWutt0t7gqFRoH9MMCTqP/w/BbG2dNOzVkQQWHcz9PGidDlebxqJK9vqdEKY3/v35snAiakohcvk519qzxFee2UEmdVcACBfZMCS2cU/zuVlvxWfy14wgV4Ni+bjVVB6i35Zcqeb6UcutKqRrHLM1cqWwmChd1OxfEhTedJtW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=Rl4lxyHt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2256195b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829021; x=1760433821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYIeDOuQqkaMDFPi5xbBNKu5rw0w8hiBYlZqsaimji0=;
        b=Rl4lxyHtufz3VMla7gym9bOVGf4ti9qoez2QPJcdrzIS7dX+rMJBW0d9mx6iirsKK1
         SnrJ2+cnQ0/9vVz5AVVXuKhQZ3FxS8S8bap6mbM6OC5pL+r0Au9wiVrb7SO1/o+DCR/d
         X2YvA00r+F7RqHJOQtebPO2tNYQqs78MBadRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829021; x=1760433821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYIeDOuQqkaMDFPi5xbBNKu5rw0w8hiBYlZqsaimji0=;
        b=oSZ5RP9nmdhiLC5CUnsUfpLWITbogsh8xgolhDjvfMAtqkvsrq8kWl+Ns3KuvUirqM
         LOtbtoAvVRrcJyuMUqNBpvLsI3Y0ISJc2+QdG5JFMd01k3bqhVYz/RlJtLBkqJTfzkcc
         5DcG5qzXgcvGpH1s0BmRas8xnqD+xqvDh0gEYZXTu4skTFWxAW2CoJA+tDgfKfBrY4Zj
         tn9rleGO7AkP1sw1Bt6pAfitP9+3j9xaXHrV9yWnxLSqo7L4MWcliZRYBJmLrGayoT/p
         LmH3k0sYtkjmLjuFzyDagd0nu3WDbc4Xb+izYVPxtZ4EYwj7dzNqSieqTMvr+zHkdnoZ
         BiIQ==
X-Gm-Message-State: AOJu0YxIe7hm3keMR/JTudQHlk/m/zf7fOShp/PkS/w4VEUbyg+jT4ON
	eIE6WM+Y6Sdo4pwQURjTkM3EVAHe4uiXQIfkCb/PfLG13ZUnDRrX3yXLyHJP8i01+3A=
X-Gm-Gg: ASbGncu3t61ICILxYh1cZ6VbVQ6dcmPXSjoV2xvr+hsn3Fwj55Ntmy9wzelJV8OnzIg
	ebKj3aRV6ioRvJGCHfxGoxLhlu+j54AQlb2OMYx7A1lmf2fXuQVKFkZG/8zcesk0C+L99Yto6ZP
	oT2XxV8EL2hxP6M2G7wmr/zzLaR8P13Fi9p+6N+y3AA4bQ3mVkIu0iN75FDCPG+pDXBmPtWZSXC
	lGTrGRUcgInzxsP4tQrSgur4igG13NO4XmKkF64MRAPVwZDxyXYP3dGslq2iV97/VoAej6Fdqjk
	vkn5YZZvaT21fuevdTg0iCUvR2j1v2NbVMqMMEGRMgM4XnJ7RF04LjguoU07VBLrxMleNmvucgN
	BfElDIa1e4ceLTP1F2vzrq312VF0u1joJnMnCwalfxaSBp6UxTESlR+S5y7mlksOb7Q7O/HIdHO
	NpzDYNyKjravtpztWVhfsoXEXHmJ3UenxOH3E=
X-Google-Smtp-Source: AGHT+IGnvuQXkfGwuAEx+Yb7NtSe2KQaKWhVmybTLT2ISlnYdo/gl3gHqlFXl6t/Wt6B4xnc3vLRCQ==
X-Received: by 2002:a05:6a00:988:b0:781:d163:ce41 with SMTP id d2e1a72fcca58-78c98d5cc70mr15969410b3a.11.1759829021537;
        Tue, 07 Oct 2025 02:23:41 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:40 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 4/5] zorro: Add ids for Elbox Mediator 4000
Date: Tue,  7 Oct 2025 18:23:12 +0900
Message-ID: <20251007092313.755856-5-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the two ids for the Elbox Mediator 4000.
There are two because it presents as two boards:
- One that contains the control registers, PCI config + io space
- Another that contains a window that contains the PCI memory space

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/zorro/zorro.ids | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/zorro/zorro.ids b/drivers/zorro/zorro.ids
index 119abea8c6cb..fda1db905412 100644
--- a/drivers/zorro/zorro.ids
+++ b/drivers/zorro/zorro.ids
@@ -369,6 +369,8 @@
 	1900  FastATA 4000 [IDE Interface]
 	1d00  FastATA 4000 [IDE Interface]
 	1e00  FastATA ZIV [IDE Interface]
+	2100  Mediator 4000 (Control) [PCI bridge]
+	a100  Mediator 4000 (Window) [PCI bridge]
 0a00  Harms Professional
 	1000  030 Plus [Accelerator]
 	d000  3500 Professional [Accelerator and RAM Expansion]
-- 
2.51.0


