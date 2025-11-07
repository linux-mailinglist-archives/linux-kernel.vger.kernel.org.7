Return-Path: <linux-kernel+bounces-890685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF4C40AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775BB427E46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509832E68E;
	Fri,  7 Nov 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UbHDGiAt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F3271E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530570; cv=none; b=NEvmFwKseAgb2qUkdMTzX8t3TVq8lN5ZhaXQ0OPZI5Gdm9nu+nNazID2CemCnbe8AhlfEwDPv+Mf6qRmxkzjlyclEeaAfc6uCW+ygosBaLw1DIw36Gp7IzsN32NWWJCYRPWKEOMBSnilwNFjCtgAkcGY/TwiHxQjZ/QinbxN+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530570; c=relaxed/simple;
	bh=7za5Sd2CGbYsFXxwOnGNM8Jslwis+pCwNRd0c2y4a64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPvqWVClKqrM3lXZckKeL3klUECuI79lzWbfBAO16o3dQvRVtuJzyAZ7qGK9vDF35Al9U2p/IIKxz7H9ghE+yTfmQtu4ATO+y4UWMovbPS9Tf5NfncO3wLoEmK6T1hycbSnfAR2sw+YmtJx5dEjwUmg6zyKkGjjF7r1q3IsmO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UbHDGiAt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso536666f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530566; x=1763135366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq4MExtB76y0zEBbNqiZC5rZ/xWdqQI6U2spz/c6ZLQ=;
        b=UbHDGiAtJkQj69S/bC3gBzkOdQEUmivGXqgeY2xgWFwPYJHgWAy4OuEhJoHVeEvbXT
         25tsgVeYyk1xfHSTyHTvyKGRDUylLjbuwbpgcNYoQN4K51/aivtfC7keCeOV3GmbJvqb
         GbMmRIHLgoHRJKG8vU2gqw+wc7BhlUiCJaZ+4FZBMMGun15EWCgbAgnMuCExsylO1nmN
         oKD8ZEj2lJZSfEjF1zJgvS0LRA/qS4Td94Sy+oAZAU3F8LyziG8Mwfdj4IwENosVHXGW
         UkiLU4ZkH7DNYtUmGl1gyc8gha39CTMf0Y01RYjgNzyMvDnG5gPfe0xor9exJPrCnnzs
         VQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530566; x=1763135366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qq4MExtB76y0zEBbNqiZC5rZ/xWdqQI6U2spz/c6ZLQ=;
        b=vf9aAI8Pefa+Q3VDPzGB2roW370mx68ehYUAO2RGqB86/l45cdiKANWviaB2RUepxO
         0O/yBRv/HCpL4SWeE/1gOUR23cKSBoVRBHqPVuui0O0m4IuM7gqgD8NY1sGR2BEMupI6
         onfKV6vWvFCjy2kl86tYUzjikATx7AvU1bSRwO4+ARxyfiNmBI4K03427/gZ+grwNzfq
         jNH0dIjzC0dRTd2l6i+BGXjqid3cBCm/wb5r7tGlAgHvH70CWbiUmwh8jOWPP/G67Eav
         Sv3AM8eER8OEjh/McUWWbNmFXUjJqY5KRBRnNHOWQCTYltL5oNmkf3VZ2I7aqzpry2Pp
         BFIQ==
X-Gm-Message-State: AOJu0Yz52sg6Hq8GjUy8tlkPkNGfaAq4PVa1GDaKY6XJzzl1Y3ZAwScW
	Q4NRhDZQPz8jr+u6cPlqGdyFjwCW29lKGnOWXPNObSTgEhcKYBL3n5Z4OGZKe30LMq6Vmi3X1pI
	ofsOP
X-Gm-Gg: ASbGncunpHct8ubOKu7tG7UzI3Gm/BN5mtHRQAfcgqDfreQMWOtl1AA+n+19AxP6RRB
	pLzaBr/vTpenWJyFIOdp8qgrpXHSzghkzi2as+NKeb3N9tep0zPF1QG49AgIvYd/eAhY0YupkNJ
	ZwMNA17FOnkM7zabWVMUFZPFNcraNIb4rR1f9mT1en6q8usPebhVGGLEKYTdithbWKGVtQu9A6Q
	fFUtgESr7JUO7gZtmz3ffw1F8uU2nH8AAm83Oh+NhbLXZsVBn5yhvoOE9hiyIJppAuoRIaibrkC
	KaJvuGUUSfEaGBEGqq0mzGkXgi8K6DDa94aRx5msY3DEwlfoD9IkbOgQqlUeWhYO7h/1myBGozj
	9dlYAtKxTDwCN3RRAt4T1DzTmbFS/9Y9XZzDhcoBA7CdES4N7FCmWQDbbk0TIagblorpIYi5u+Y
	3V9OGw2sZmf6YtMtEC43crJH2Lyp2CNDe/Z+s=
X-Google-Smtp-Source: AGHT+IEhUIEI5+F913Bjhs0+Zl1YPWT7epmOweSo2OlY5tR346YUfwrdeSsWD37i1I0Bd1XqYIQHwA==
X-Received: by 2002:a05:6000:3110:b0:429:f01d:dd83 with SMTP id ffacd0b85a97d-42ae5af3b50mr3391420f8f.62.1762530566060;
        Fri, 07 Nov 2025 07:49:26 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:25 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 1/2] virtio_balloon: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:49:16 +0100
Message-ID: <20251107154917.313090-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107154917.313090-1-marco.crivellari@suse.com>
References: <20251107154917.313090-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/virtio/virtio_balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1b93d8c64361..74fe59f5a78c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -983,7 +983,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_del_vqs;
 		}
 		vb->balloon_wq = alloc_workqueue("balloon-wq",
-					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
+					WQ_FREEZABLE | WQ_CPU_INTENSIVE | WQ_PERCPU,
+					0);
 		if (!vb->balloon_wq) {
 			err = -ENOMEM;
 			goto out_del_vqs;
-- 
2.51.1


