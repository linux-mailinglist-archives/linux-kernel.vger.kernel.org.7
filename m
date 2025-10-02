Return-Path: <linux-kernel+bounces-840587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBCBB4BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0903B66FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464726C3B0;
	Thu,  2 Oct 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVGTfPfx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66111157A72
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427189; cv=none; b=PGIAJd4LaZYTmMberezDW+7CzBzVlJyEzDu94IVoeg0odE+rKCipTy3uJ8eKXepSuo+e86/Rx5HkXXakqj3sxCEv1kiZ0SkhWAytDSNyZzhjcKByr3MT99W9BY26Wep4tGQiP5AdRAjr6FyIxwEinhmFxIOAuAJaGp8UrJFvIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427189; c=relaxed/simple;
	bh=d8JhIBf9djcZXIfnCciHGMpxUiYp6eLd6xES6V8e5b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pv0l3Hd9E3qlTJ5PTt5dIE5/Xt/FCi4b6psFMUnAWvXSChdM3FMA0urnNRdBsMzMdv5jTiDVbFANNKpqhHxos/fjZgYYVUQP3Lz8AKDyT52FTS6zPnP7nEXOZAD+3OJhHH7wyfAFQ92qoaGgXKB8Adv5e5JqRiE7y2vR5kZe3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVGTfPfx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso11012335e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427186; x=1760031986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9sNcmKDNcl/Dt3ZzxXXGUrNG+YQTuMkF7kiQoXtwf4=;
        b=jVGTfPfxVhVMhkmsDF+t7oSZfg4gnmuGPOwpaeSwkFBUD/50nnhMYzq0Cnt3EZN8rm
         OgcjZt/+08HKhmT6NKfQhNI+tiYtg7pcN2cE9un/y1+fR0kcagV6ar5d3r630WiFTXQe
         Qm/uWOPnnUSGG8CwRj2bVsBawLAlUe1Dd1B6OqK8+6wy3IJFGkRaBFjfuRS84jsfYfbN
         VVawYtsjuxCMBWwm19qt1LD5XYR+jGo3QwBO5dfUroy8Z5A7CbRd/AyMqK9hXY9rue1j
         KklufSGQzC1CUq6r6qPUkNaV6v+MAvx/zLTZnNDzsIqKJ1Zbx89fCoe6B9aa+91OCZ+4
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427186; x=1760031986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9sNcmKDNcl/Dt3ZzxXXGUrNG+YQTuMkF7kiQoXtwf4=;
        b=KyYFqt5jnULyyPlp4eQ0DJPePJr2LIixhC3STnAUVgSaN9j7OooJny/ETuDxqR9I0O
         JiiqriC1VSIKEhYO6tYaj18n2T01BM8+9oEgD6Re8jSPksqGjgpKmsT7nvEUC3Fh32Jj
         H1mfij3LfLhLmRzRHhzqxUjKCf6gkrXvzFceUJnusVjMGz3cPwrK6pFk1NoKx+qwcj/0
         6DV9uODWYSl0TMoGJQC5FVN0HmaqA78+9SXyOcVKR8q7VkYLPzRsWzewrP+RJggZ7RDE
         V25XHPi7ln/tg4PVellpscvqcXvVqiES370zFkIr/xVJnCuJHaATPDU1/L8ysSnRujkM
         ehxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT+Hxn/ddT/nxSv9wYPK9KL3novQ55nYVNCPsBWL9kwcXpi4YISenpJun+8hfxKNKWPQ+gffmMFoPtrhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/stq7NikP8zIF/0Cdnrg20ahkn1H1GzWo6DuYHv7WWGVQ7i3H
	W2P/XXHxH6jS3KJo47TAf/sfUcEuFtlMIWYOVolgI8AsVJG3iscRMHaR
X-Gm-Gg: ASbGncsjJ1xx4OA5PdAJ0sar9JHl6+NjAxgg3kp7d/uCMWFWZREJu9+Jh3V/UMe/yOG
	H4F3T1BTQxNvQaS82UrR337HMX2EOdgNYsgxBQV6fFVBsgDjuLbVmXE3JQ70PSeDyimaD0NJL29
	O+WcPh0NA6rU/fUEpABioo60ZARy/3ARMm0FGbdDa4f/wKN+K8igYagHe/bepRyJu+XXvRtMT7o
	UXenbO+uyyP0ajtuvkzBIZnatxM49NGmFikGazo/hUNPU1o/p9zpBx5xvmobpjdBVigL2rNMY/Y
	oYnsorbKZiFUFke39Fkht88UnoUBJo7EGHa4OmLDE66jllZ3Ch8hYzhpo0rmNrxb4EYuK2UyP69
	6aM9Jx2otlrCs51vT90481ntmNE204StaR3yEShyNcQ==
X-Google-Smtp-Source: AGHT+IHDGwwW7vV9OjeTKcYO8fMtxK6OUhwxnDACT7Snh7gOrjwK+iCQOUA3HzoB6hu+zfULqCwkWQ==
X-Received: by 2002:a05:6000:2c11:b0:3ee:1296:d9e8 with SMTP id ffacd0b85a97d-4256714ca6cmr97372f8f.17.1759427185491;
        Thu, 02 Oct 2025 10:46:25 -0700 (PDT)
Received: from pc.. ([105.163.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bcc2csm43640665e9.12.2025.10.02.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:46:24 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	david.hunter.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe
Date: Thu,  2 Oct 2025 20:46:17 +0300
Message-ID: <20251002174617.960521-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put call to release device node tbi obtained
via for_each_child_of_node.

Fixes: afae5ad78b342 ("net/fsl_pq_mdio: streamline probing of MDIO nodes")

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 577f9b1780ad..de88776dd2a2 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -479,10 +479,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 					"missing 'reg' property in node %pOF\n",
 					tbi);
 				err = -EBUSY;
+				of_node_put(tbi);
 				goto error;
 			}
 			set_tbipa(*prop, pdev,
 				  data->get_tbipa, priv->map, &res);
+			of_node_put(tbi);
 		}
 	}
 
-- 
2.43.0


