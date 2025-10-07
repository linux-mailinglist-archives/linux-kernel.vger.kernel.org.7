Return-Path: <linux-kernel+bounces-844501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F2BC2153
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6D64F6158
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A02E6CD8;
	Tue,  7 Oct 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="38CGOve4"
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D42E6CB3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853880; cv=pass; b=WDHuinkvJBDTQw+NaxkZtk9sx8IarEOy8+WK138i0z7qB6GhZxRA/eETUap2+jEStJGB67eVnOQ4IgOwID65ZZ6c+IYNHZLl42k/bFCh8cR8qWf2/3zmKscUnjeYsXtQG+tra6t78MoFZd0wMkKQUrWlaZNn7Qt1q26NvXxYbGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853880; c=relaxed/simple;
	bh=WMCk5RuxBxkKL/bKWsjH32epCgRUaYFkq8qpxUg/rT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IIiC99EZVGMPfDJis1l6aqJihAnuoBt9xlcb+mwuziOko2wG1Yle086WMXPMWABMCluDtjK6D0WiVaK8MwWze3nbmF97P9AIz5mX6trj4juDtKl+UPpywYCwLDZl4yXQe2dZxibzSyBDACm5xgUEzOA6QgSFB+C8PBfOB50YMDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=38CGOve4; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from homelab ([58.82.196.128])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 597GHFhK1883936
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 00:17:24 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1759853845; cv=none;
	b=g2O6RbwQmczahLkXKrHwGibNRFNhUAf9LaW8iLX+jepb/f/Z4lrGcP5uXHBqnmqo9efL+ZdsGMkqAZQDzdg2TSxpf9g3jVUE9qHHYhue3Jmx9NLJ6aEHJVTlM/7RJQZMjbjfOFMMXJEu3QkVJHKKBYsy2asALT8BiDpetNTPijw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1759853845; c=relaxed/relaxed;
	bh=24DsaxGYM2c65pUUHqLrjY0RrgMH0pttOAS/k9JF3RU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jmgP7+3Qp3OQ+DiOfFK8nbhMxMfT7kVfeHrR2f39rqcNbGfYsgzUCqANmUbr/6OYnRUzbFqgOGpYInwbYljKP0jMbJ9DxmgngBY6Few6oyh6T1HNkYBNViX1Ys7E31Jfwtmc3HxUK5nqpbV8JhI7ZyWC702KVNqGPTnTVkzxQC4=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1759853845;
	bh=24DsaxGYM2c65pUUHqLrjY0RrgMH0pttOAS/k9JF3RU=;
	h=Date:From:To:Cc:Subject:From;
	b=38CGOve42jDY+Z9Qk/jeA3D4UncmB8zjjVtZeIOcGI2bjkuoLEhq56o6D9LV7tvZq
	 OEtW++LVhGF8E+4L8ra9vuX50JV/g5ZGjCVH1vVy6uFUBDZqhTZRH//r6muHOXDoya
	 PFnHumP/aKdMZ6FCLres6BSyvCTtGUYOotPNYI/I=
Date: Wed, 8 Oct 2025 00:17:09 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix bad ret code in nouveau_bo_move_prep
Message-ID: <aOU9BXjYDNoPRQmf@homelab>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In `nouveau_bo_move_prep`, if `nouveau_mem_map` fails, an error code
should be returned. Currently, it returns zero even if vmm addr is not
correctly mapped.

Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Fixes: 9ce523cc3bf2 ("drm/nouveau: separate buffer object backing memory from nvkm structures")
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index b96f0555ca14..f26562eafffc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -929,7 +929,7 @@ nouveau_bo_move_prep(struct nouveau_drm *drm, struct ttm_buffer_object *bo,
 		nvif_vmm_put(vmm, &old_mem->vma[1]);
 		nvif_vmm_put(vmm, &old_mem->vma[0]);
 	}
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.39.5


