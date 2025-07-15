Return-Path: <linux-kernel+bounces-732623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A478B069B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41CF5800A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BB2D3ED9;
	Tue, 15 Jul 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aq0P36/V"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359102D5426
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620495; cv=none; b=byhhDMXEvJsgmfo9hGTyygK8xDZAPrGUu57ktGY2trSZ7WqAdquGqoxJRLznL5k2k1HzfJhkbpNz/fQkV+vFwPpSDxL8hQn75udLKrJXWN2kyzZkJ1DdZ2PRo/EW1Os1ISG9Oi7kdJOe2rsBlT+OUEQXxciNwyrjJM8vPEU0REM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620495; c=relaxed/simple;
	bh=C0yIBGjgQuUwh2cILUg4KfKwRH5Zo3VTXMZAiLB5IzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nmg5UqGbjpi1wJrCDgQ/ewrgqbsnj2ahNqkjQ2IlTbQCy2mOBPgP+f/A/BRMLoaLh5R1NMqdzoa1U99jI8ARFk23EWb13c5Wr/DHxzPJL5Kary18AoCN4SmrXVKXhZ4BuJg6onQgnDIQHTx/PhzSc7b4L+1nFiBIUId0I54RjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aq0P36/V; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e58d50fe2so785408a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620492; x=1753225292; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=Aq0P36/Vw14ZTOSZP7VIoVXi0jFTCXxSroHDH9b1wV7v8QYZs64zqWi1W1JNVwADNZ
         tzJKbkbCaG2wczXIw7esS3v9YoRn1c+XrXrH578lawGjfqxViYMUlqv8aTuVmctyw0pN
         3hbX7LBqwQ2sXTiX3HiqKDQjOZIOS5I1q5+EgdKDizdV0HnM6Te5jiiw0ouhUAXT16bM
         uJT0EUXj8I9LkO+6k6KTxe/2eo3WHRSloo37tZ7qUyVwzUmmPDR/ekiERhxn8nUF46BA
         ix5d3m0XAx8s7bqczDZ/0AlMX9oe4NZxfO4ph1bRKC8GkeDPG6M1hXLP1ECisprPC/hP
         xR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620492; x=1753225292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=vKJBtKghDYwEwaB4UqOWgdgLig4jiVtETrEEBzPtuvpdWA/1NtLvEMaapt/IgEW92t
         r1S7HAp4U+sL/VQq27kP0n1giLAYs9KVfQZNZaAoswD0Oo/Fh21hTkwcLKY9QuygHp6V
         BqCc4qTAy4E+Efc429QJUq/B7BiG/5sSFOjeeCZ4NOfvoiIZaZxyPJncEjx7OBUOZrGm
         TEVrbI8SxSnszCtKuO28HuYqrexCfy2YbQK3bbXGBzI85IN0A8CjSe2wnbcMM15bfz75
         k0Y1kpSxK40eQSY2tHGppwPoSAPlVDvg+UTEhOZq3tYIhblKEOc0NfPu4pBwhRxNkLvY
         vZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeJJe4ZXHPoFsB+6eun4c5L1T43VkKxvM7sFKj9BLe0BfKC70tF+IPSRZb75ts2xn1q90+qF8ZiElp4LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIwinQR80lBoqLfoxNmRyLdhxm+OoMusAipWaHYblJ03sPUFX
	f/Xood0bt8FJ+muIXSvVTt3+McfFFlm5rOfbd+qLstHtXuvha6ZLsejoaiFsvJz+6IM=
X-Gm-Gg: ASbGnctC4nBwtjC/TT99lxg1KtQz9glyXgiuANDif/TD5fwDZp6GG1yYH1YHC8Lk9Sb
	My/eYLo249kNJVxsaLJGTbTn/01T9Eo1RRupCMQYlqNyRlqBT9GBu7wTYj3MmjgrZ8ilEverRS/
	3Gr03aEvAHGpqeyU1a/qHEUMGBcL1xoxK6i6svKpjX3KnajqJQbDah1Ykzj8zLgkNG3tjtjd2Th
	4W78MprrnqWcDN0fHOy35xMWX9ZaZzAbZRY9JrWXw+o//2g9lAjLCtCP5dFPgFzYxRAk/2nHnS1
	sip3h4NojWoOfzP5Nf9ecBGXgdeVgOyilV03UX0rb4YH6cgdVCR+/bgqSuuMfbRbgXi/75la6ek
	Rd35mFCXr5lI7ojAqxa+cWJ4+iAtOyg4shrZwyY8=
X-Google-Smtp-Source: AGHT+IE8Nfeo8scY90CqHg5efo6nAkc64loFfqqe2YK8azM++ugsfehXsqpsTS6+ghhEcDe7uWrOaQ==
X-Received: by 2002:a05:6808:3c49:b0:401:e721:8b48 with SMTP id 5614622812f47-41d031f1f01mr437628b6e.8.1752620492132;
        Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41c267defd7sm558510b6e.11.2025.07.15.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:30 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in
 esw_qos_move_node()
Message-ID: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __esw_qos_alloc_node() function returns NULL on error.  It doesn't
return error pointers.  Update the error checking to match.

Fixes: 96619c485fa6 ("net/mlx5: Add support for setting tc-bw on nodes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e1cef8dd3b4d..91d863c8c152 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1405,9 +1405,10 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 
 	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
 					curr_node->type, NULL);
-	if (!IS_ERR(new_node))
-		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+	if (!new_node)
+		return ERR_PTR(-ENOMEM);
 
+	esw_qos_nodes_set_parent(&curr_node->children, new_node);
 	return new_node;
 }
 
-- 
2.47.2


