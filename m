Return-Path: <linux-kernel+bounces-789541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E91B3970F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6E67B6CED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD12EBBA9;
	Thu, 28 Aug 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWUeYVNE"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AC2EACEF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369964; cv=none; b=XRha9vkVJfTx+ElmGySKHMoYNddXm5YVGZJMdIurXLwoJxCMAlstZWMFL6g68EXswM4VWKEXLGxxaYmxE9vCBD3B0Kelb7Ko9+TVAJ7/eV/4XfdprTRibd6ubmfXM4LkUIhEkpg5NZNYnp7Rz6uT3LuYim4ewYzqiulLvqZah8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369964; c=relaxed/simple;
	bh=/DxPtWBu3ahXV+AyM32F8Z/2kjdzmtoH7doT+WwdD0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxX3N5RsIVHRsR9vG/sdMU+CrlH3O4xhRxSrEl2P7rYJVHkdvTIzEP02eZ/4Z4fwlYPJGhG8YU/hHbhXu8SIZocG6r7AbK87BCjG6jjDCJDM5RkTZMSvXEAvi8/Lt+1vgLsl1P1l+2Qv0kvEP5h7iN8/wbyoh5TQywWoRxLmXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWUeYVNE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3277c603b83so426157a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369963; x=1756974763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnQvoAlyJ1UeIyClhcv/8uPk9nhq2WrX8SuHGTIiXLE=;
        b=VWUeYVNEa7u/jVK0jAYegpVcOE0KQEEVYOzHsrAHzTRf6IcrcWxEp74fMR6M73xrih
         e5SIhqh/6hpZyhgTMif95dWAmx2nFGqyOFQLNc4onxdDkDzNq78GUnAepbJtf7Y6077i
         gFKaI5xwqbX9d+fkJEOq3YmX4InvVlh7kFTwYmtfyF6+IP2MYiZY1+U89fVGx9IskSzi
         j+hBQCc76OEwCa0pREhSEWiD7m6KNNbR64p1NmQFI6SQ+SlPmvqAd8qQZL6z2MfzP6Bn
         oocEtm+wmMlKqyj6qIXM0mueXP2tTeYY4H/n1LN1OcLjdYxUlHMjk94dgk/HhVKzRHmh
         nroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369963; x=1756974763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnQvoAlyJ1UeIyClhcv/8uPk9nhq2WrX8SuHGTIiXLE=;
        b=CF4nL75xcNQlu/4KyXgrjxgi75Dzmg7xuhE9yGkg5jIgNl2jG3IqVanJJwbU0LwJiD
         XEfu0C8AXqCo9xXpHzWSOTh9Uwtlqy+sYwYHt7Lhj70moFr2cAyELp2rpbnXtFvo3t7r
         sDnBUDStkyWqEG5iNNmf/o3usq64rMskNyhHmmKu+/x1Sjj/pAL7nRR9PHLAUTT5Uklf
         ZlcQM55aSsX9JsQEgdgSLM/j1bVcK0qRvdjHIMYG8ZK5shbSoQQNXrK5QMRn27SJR1A/
         SL8kHaTB89Qfh/Y909E8v+762zuMKl1VfUIemHYUpfz+KjhgqQZ6D89G/5jpDZuMSjFQ
         L/HQ==
X-Gm-Message-State: AOJu0Yz+ncZivZmYbi3x6IkcczHMcWf7mUcEwOKcmKS5DzNvxrymTfNz
	y6P9c9yXM1Yj/6JL/NHh6xgUMk8p8KcNM+6Pd5t9CKl5lnjoiZooXlBd
X-Gm-Gg: ASbGncv09sjFclCzOGeOH7ODUH98ZK1lTGDkfNxLjahvY5l/d0p7vYzEpQPdlzvhRbf
	PCsDx/GQCgikkcC2wR00+V3fEwbcVScs8BY1u2zHjQJcUfxVoBU9K+SNwPtgefOzB6NH1ECHjr1
	XDy3ORulY4ZsEJYD/t3EbxotmJIs8RmTlSFowhUy7kH7zg9JWhDAJYq28Jiqag8DBkdAgS8+PML
	pdVm+MAAhbARqEhwbn+fVNrZ0//CvYIIcLROlJFcP8gF0IGmfKuxCmVSCCcZ4JhRQa+dyhJoCk+
	S1rzJnVeFBa+i6lfubPxMfNlvOeqMj68uaFCN3XkpxnkhEoH1rUlBwB7HnxZOm0kZEBNsizB8Rc
	PzLbBvYuFLG5AREdNvsy9DJfZM5wjhIGKMqg9fkQe4/w=
X-Google-Smtp-Source: AGHT+IFp36GvTqVm7PKU86diabfX9OQwlr+0790E1BFSvUJ7wRTAvImDcT+TjrYYfZetgX6K/2FWIw==
X-Received: by 2002:a17:90b:52ce:b0:325:6986:c624 with SMTP id 98e67ed59e1d1-3256986caf9mr20515334a91.25.1756369962486;
        Thu, 28 Aug 2025 01:32:42 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fde4cecsm4335148a91.29.2025.08.28.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:32:42 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 2/2] i3c: master: svc: Recycle unused ibi slot
Date: Thu, 28 Aug 2025 16:32:25 +0800
Message-Id: <20250828083225.3558100-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828083225.3558100-1-yschu@nuvoton.com>
References: <20250828083225.3558100-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

In svc_i3c_master_handle_ibi(), an IBI slot is fetched from the pool
to store the IBI payload. However, when an error condition is encountered,
the function returns without recycling the IBI slot, resulting in an IBI
slot leak.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index baf3059fd668..8863c89775af 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -417,6 +417,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
-- 
2.34.1


