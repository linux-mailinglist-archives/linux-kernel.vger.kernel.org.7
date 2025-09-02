Return-Path: <linux-kernel+bounces-796683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB334B405E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59D35E28B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E97305043;
	Tue,  2 Sep 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUTh9MkL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3A1E5B7C;
	Tue,  2 Sep 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821210; cv=none; b=psDweMaaSolQEwDTcxv3XvjjenfGTm76RbfSS9QDUVM4akLAgVk1444jQAisXzrP0YxX7LFFOL5hH+86Iivlg/aClpaXVzc6x37GWJ3RFNzcUfuv7INLuejT2Zn9ObrM+9pFfx2R5Bfsc9ut/42LQopzpzwLg22OEumPVmuFXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821210; c=relaxed/simple;
	bh=vs9eCQ1Eb0i4CZi8Ztof0a8Ckkg4T5YmnfBqkpzPGWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o9fqNDWE7ESTEY7yOIi9IShhksm8QgWdiaXJUCP6piIb3Kjt9F1QxsHcPuZatmA8cRGHZgaQ6ox/4iGkBDgMmixv+B1v7hpDPqh92pFQwnhry9IXESFKt+jIFjHg7ea6W/O1sFJ8N7lxc0RL/s1qa1Jt/yICv0CXG5pF4CfvWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUTh9MkL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7e69570bso27744695e9.0;
        Tue, 02 Sep 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756821207; x=1757426007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFT8uhGng5M0xnUvfOPSpBoi9A8zPQ2Ye+1CG2fVnso=;
        b=SUTh9MkLTXrY1ke9L5up6HP+MZpEC7PzbjdV+SXcdVfLVTqU4Ci1VMg9moEJ6ONbIZ
         Gaajg75rzDkeRhJFzNWlPQxklssWTLsCjltYWKbcz1zM9LLUIoUd2w6pdW1+zQ45pR7P
         3mrPk90BFS3dXCexNMqVenhfFE//1laS8mlSCPH+eV35RKieK1P7NmvA93bT0Wf12Grl
         exBzq+0mpixzq9qT43t+Ac/1GAx2UQk0YiSrS1pPsr3UEQqGNlB2fZewk1Ob8qQHocgY
         Ldgw67W40ANoe1ltXFIXAaQVh32I9zIrpKBZ1tmxYiYvDTXsLdbdvfM6fMHS1hD7zt/0
         rRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821207; x=1757426007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFT8uhGng5M0xnUvfOPSpBoi9A8zPQ2Ye+1CG2fVnso=;
        b=hh9kFVQLpkqIv/gBwu7cvnamiNu/VzJduAqeI3vVcDpkmIVFjHTZciAKPh787TUXJK
         v+45UtFVRzbzkLPVY6sKJ/r1t0y4gu0+g9S7/2qKJry9ctnXBN9JJCOFN/Jl9E1upQZd
         DnzpvFZILzdBRCJqoK5wSprWxa+Vt1wa6TFW9npNq0Tk+ru31D3PKA+VuPUQnMqXv9XZ
         DZrI4UN/Zo1UMzGnCGUqkhX5iFv8Pl8s0zC5TRzHUNYsRcDcV4Xgm1EVSOxfKYe3x3E0
         y8Z0IePYcskTTzuP1PNBmqEI12a8Cnh4dEsTDbN7GFN1azlJL61WBnGnVSYX5PW9r5sh
         qwdw==
X-Forwarded-Encrypted: i=1; AJvYcCXYsGN7g7kOfnvHqcy1ocUdl/M7uuPeEZ/RYbzYggUyL3fj9gMFNHGSsxTWLPlJosQMLXa6YMqbWa3CuRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFJdpE+aoGIucOyo2GwrxgfYu8VCkQrUJEvG3L+FDj8zICmhX
	uFwY8isKebOUgB9rLfZfCrfoYb8BdqHexhMrYC3tHhb0FsPjPH4u7Rzv
X-Gm-Gg: ASbGnct9Y8Oql1YrlZKrIWDMPMx/7y3IaPWDs7u2ja6yb1KS/YuYhIQxrWrq4tUZ5VK
	N6J6f/j02DAKmJWHFJ4ghS6cJXgpjAkUEyRqaqgH7gnKTipABvb/cWSaQU08IBClZLHEVIOTNZS
	QrK2769GUPiD/1oiGHjDpQM1aEHBtUOKRl4LQ4zMvqzr3oPXOfW9oGIi+IZauGZjPbEeTrgO2wI
	O1PbBUjR6yraMPILH8GRNdxEA9/4ldZOwe3MwsMyfowodznyyV6Dq1RMSAm7hv/+Dg4iDOsYGsq
	PiHDxn9jE09O5fCR6m1KM4gX3JG24ZN9Y4KqoVdaJMONahuA+w5MbbPaxooCFIREXCvkgNZDQXI
	4csK8Mab6SL7V4pL3WO32mJFG/nRbZ1g=
X-Google-Smtp-Source: AGHT+IHjRrWvopx4QsWSeRb/F70NKN9Z74OQ9n/HQdOFnq8W+nkDSUExmV1RxO1Z1ojlWiFxP1CHOw==
X-Received: by 2002:a05:600c:1d06:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45b8557a3f7mr88649505e9.28.1756821206681;
        Tue, 02 Sep 2025 06:53:26 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f306c93sm283628745e9.14.2025.09.02.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:53:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] i3c: master: Remove ternary operator on return statement
Date: Tue,  2 Sep 2025 14:52:39 +0100
Message-ID: <20250902135239.2632286-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The value of ret at the end of the function renesas_i3c_daa
is always zero since previous checks for less than zero have already
exited via return paths. Hence the final ternary operator checking
for a less than zero value for ret is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 174d3dc5d276..275f7b924288 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -679,7 +679,7 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 	}
 
-	return ret < 0 ? ret : 0;
+	return 0;
 }
 
 static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m,
-- 
2.51.0


