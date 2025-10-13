Return-Path: <linux-kernel+bounces-850802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE522BD3E55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3F534FD1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3B30B515;
	Mon, 13 Oct 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UctH4wmB"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437130AD07
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367206; cv=none; b=biuEpEN+/+3Hc+lgCAMZpHeABXDeSL+9LaN8/FKJdO8MyJ7TOdWav/EY3uh27T7OomerJdZTJ1JBJpaMrV5qzWiO5xuQQB6nOdoYZshjFPu+TA8GHlXodWt+Dwt0vWVn0peB+WR8mAo/lf5oSkY6r8toYAz88g53nsdbCuSbEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367206; c=relaxed/simple;
	bh=7sj1EbpAJnpeoVxMcwuWL5zaTTOuVyXNUSbxilQjCno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP8ujELh8jTAGxGpk5Kqfwj9tdU5MTNDmK3vMTevq2h0sKb2ZSOpqieSyxseqU6YqPR0fXQdKeySRcLKbpCacNoHNsuzTVuMbcv4J3jF0WcgCJS1P6ACEo4TPTGtvXNhlMlLJMl/V3ioY7XeVGCE/afR0SDIM8G5ZHV6/rJ6F+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UctH4wmB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso3288903f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367202; x=1760972002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=UctH4wmBAKbnO0vP3yMu2v49mDyJRbxIaYIwLePGAWHxopZjFpXBsZIeBl+qR3GAl1
         XpmCRJRlhsfcLHZmc3k9CgUSAa9gtvnyWcGJu6jZ2ZLUWj1R/bu6plny8LaRw0X6BI7I
         BXdh0FzvmnLxzuB9BFw5QiYieUpnqK0jia1HZKqqcYRxGlBUZhqCqUBIBCiICNxJSMI7
         cLU/ixvgI53rY8lGbXKwkquaf+9ZcVLUfXjoBbz8cEPSv+PBOyQJJemBtp9HKFetixpt
         l7hC7IQFgNjXFv37bAp99VmdJtOJjh5FvHTyuZmfdlFQS5d9lAzhQNbTyQ0iEZcWplfn
         syDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367202; x=1760972002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqDy67Vpwu3GYg1tc86jhK5pz5tDZBEzHj59MW+Ighs=;
        b=xCQKls5ohVmLvg2msmgqEhR0ZbWZo5+HftOHxW/7Umfi+rMeRhAX5Ej1MRzzHHWNOd
         D5g/zsxszADQixJ6i5jNIIbIncWmnd+74VuJ8agjYxEFdJ9sS/jgC1a1i4o27O003W4V
         r7Fkimwh0ck8g7F7NV53SsYzWHmoSlEt8oPcz4vW8QtAPZ3m8TEioT7VDwRlxcqcWiKo
         /gMU58wXtV3tqT/OlEqCEjZzOWOLB54rgF5l9U1WvEH0IrZgL0Itt3VdWYd82OPU8bG2
         QzV3qh0+9hcZ2utxUtxZkoG5z3MofpKTp/kmUlM3uvMYg0KXilqYGWB90K7L3gSEiNxE
         84mA==
X-Forwarded-Encrypted: i=1; AJvYcCXwKzaN3cstE46cPRaGVbt7VsxCmUFoyozfxDfznjYfP2ML7FUHttUG6PPWCNHT5wl+BGWTEIotGmrzzW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlpAoHXFhDHT2uS1FBUFPm+OlRhSCYnulrgIpigygMf/Ur3LI
	SArLJL4q3fRy0N9aUbJ6c33aoGgiMJnZtPN/T4Z7uvFxsjx+WhTdLG5F
X-Gm-Gg: ASbGnct3Xdph7vPcJfTm5rN+v1oL53++v38J6yaEvgP7FbELTYDecQMD1n3rAoZrrNH
	jgNFxfItIw6op+HzWBqke3X4AHI7sR+2bMYv7+uyzvhAhKLc14IvqEIN7LQBDg0FR2JBZPAXzYF
	axa5mmBjlbJVKGma7S599k2OLLUXF/QweN7ownq+FUwLaEVdG3ydTvFt0SLrsxYwcXloepjdIug
	RDM7Br2DCnij4P4Xh0z9vK02s+MVZwMhMt0RkL1FFqOXdKXKGWLtD+VhH+kpSoWxCsbcKqbR8iE
	H2sQTzx4T7TXygKuTTZgydb8BICZbg3+oo3p6eXcDu4uv1HOOYRtEu0z6o+irb9iQmEWowaCFue
	uAw0qUM1AD5JPgITp4EBYMEE1
X-Google-Smtp-Source: AGHT+IGuhS3kQZ1R1xe6ZB/ZEr0fg6Xs5SvekWOSlXtM50KBa0/ETxk5cO3wUCuWkLLaVPOmY7sV0A==
X-Received: by 2002:a5d:5d03:0:b0:3ec:e0d0:60e5 with SMTP id ffacd0b85a97d-42667177bd4mr13708475f8f.15.1760367202162;
        Mon, 13 Oct 2025 07:53:22 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 01/24] net: page_pool: sanitise allocation order
Date: Mon, 13 Oct 2025 15:54:03 +0100
Message-ID: <96099d1c7af73b1086ec1c7de1488b50147d07bf.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to give more control over rx buffer sizes to user space, and
since we can't always rely on driver validation, let's sanitise it in
page_pool_init() as well. Note that we only need to reject over
MAX_PAGE_ORDER allocations for normal page pools, as current memory
providers don't need to use the buddy allocator and must check the order
on init.i

Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..635c77e8050b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -301,6 +301,9 @@ static int page_pool_init(struct page_pool *pool,
 		}
 
 		static_branch_inc(&page_pool_mem_providers);
+	} else if (pool->p.order > MAX_PAGE_ORDER) {
+		err = -EINVAL;
+		goto free_ptr_ring;
 	}
 
 	return 0;
-- 
2.49.0


