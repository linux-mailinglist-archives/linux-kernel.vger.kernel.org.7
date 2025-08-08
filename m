Return-Path: <linux-kernel+bounces-759785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57236B1E27A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242EF188DB11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F31D54C2;
	Fri,  8 Aug 2025 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="XqTOPM7Q"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2125.outbound.protection.outlook.com [40.107.102.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00A38DD8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635594; cv=fail; b=FDj+O/vXRpBaZXCh24+kLyvdsXFYITgM1wbcdLA5bDL6vUWpNrlX7fY6QhUc5WRPc+ULbhZSWqoAx3ydAycE8Ee6PYR+irze3KbRj4R5dGPdaUiRzbZCY0HDfVh64PJZ2Z7JV//K9udm/vehTIhlloadaN/IRxuP1eihtaIJIxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635594; c=relaxed/simple;
	bh=tjLH/0v/UOQtf+e/7X5m5QpTjAhorsfGgLutR6TpLUs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BVPjsbgD7bi46Qld4BzMjKLYr09Ihj5rnbjAIL6/gVMy7PfZBGfEqLXJQ/TllM347NVMgcNIBzYcp6EzfYz+Kft1GwwxW2bpk6N1Pu5BEVcFB8MDFAxTkVRdszgVY3ROZ3N7sD7J2QilGXsdmCT+jvxPyxcPR2AaTuZhvdQjgJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com; spf=pass smtp.mailfrom=analogixsemi.com; dkim=pass (1024-bit key) header.d=analogixsemi.com header.i=@analogixsemi.com header.b=XqTOPM7Q; arc=fail smtp.client-ip=40.107.102.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analogixsemi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1qu5toB9q0GT7ToMzDpixFlIB4TqEu4p7I1UrrLO8lMUu6hK4KeNxMTtAFtXo+9n/GdjxBEQrptVdOSTWOwGUSopG94VFRrevHAr/8NVdUVpsO6Njccy1iUdbRZvYiHRkjBVkqgpetyggv0TxiRllsXJW4E/kEH0s8cQMU61nV6HDmlqZ3JjwtawHpfJkCHmrWvXmu0Yftepikmd2qv7HqNrIzsnKQH1oh89HHDPxE6hwPsCACuL+CsQNMijKVM75pyyxoAnjqqcv/GcNU0vntFK7W/o5aRabkryYKAZCWphSjW6q40IxWqoVuq/eOrvHjc77uJKkDdfoNtA2bDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4kE+oJhE3W0RSbALcNa3aimAR88EpxIl0EMD7HUpkQ=;
 b=xbOeRyD9EU8yYUQX0bJ8OmDts7Izg8of8U2i7fYM3QtXgZ3Nq/WIn7pdxOATgmlNJKl6ucNefz7QO6NX9K8002TLLoQ6YVJZpaNJgBHu/9TAfW4LFeS7Ft377olB4fIPZQiFCfrDeyjivuPi2KyGxnX2PvGvbEGRPfaiXb9iuManCjxS3eAubWxkul+cWLLgoq2OJDS9FFIGt7xyR6EMGriPj+LtJMI8wf7FoZPm2ayYVnAwM+95tIXnGOm3vMQ8bHzsPgs+yh/wFcFfSKdG0mZcP0TUk2CjMrR4ZsaKCxaZhZIkQPSKiNBUQAd6YeaO5x7zEsRNNLeY/Ax4tNf03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4kE+oJhE3W0RSbALcNa3aimAR88EpxIl0EMD7HUpkQ=;
 b=XqTOPM7QV9kIUMscWPBNoeQ4F07zKUfUOy1ftwFYGiQ2Y1yt1VAs1FWIIWhLOoXlVUeeOF9iKQPQlzOra0DHlQPhBuqQO5GyWOiJ9ha0+Q/X3aW8JmgzGqTBjlaPg57l0CEGnPR3O15rWlAdn8vlerXK0B14X4q/UyNXypDUwHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CO1PR04MB8220.namprd04.prod.outlook.com (2603:10b6:303:163::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:46:27 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5a7e:9e8c:138f:1815]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::5a7e:9e8c:138f:1815%7]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:46:26 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>
Cc: bliang@analogixsemi.com,
	qwen@analogixsemi.com,
	treapking@chromium.org,
	jason-jh.lin@mediatek.corp-partner.google.com,
	Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fix EDID block size at drm_edid_alloc() calling
Date: Fri,  8 Aug 2025 14:46:13 +0800
Message-Id: <20250808064613.2623732-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR04MB6739:EE_|CO1PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 544cb6e9-0ee7-49dc-0bd7-08ddd6474c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bg44ELGIQIJdV0owUlAvkJEiQTJlxa5dram7DDmDW7qYa1W0mp1843RLZhkc?=
 =?us-ascii?Q?gqfg9uAGDGb6Xpk0Re3hDuX9rtoinA2lOAsPkCYPZaxZkX5kOn/AjGA+Fe25?=
 =?us-ascii?Q?2jGtWWycpJdUXOJ7dEcnKwdyjURZm+ZDE/I6qwgcoroaQfw/1UFXYsN/7S2e?=
 =?us-ascii?Q?A5j/C9UmzKtwUZ7IdnU4I4l9Ez7NS+eZb04dXSHAwBNcETvUMApocdU4UHM9?=
 =?us-ascii?Q?LfMfIcG9Own1WYBWZrn1Ttb04qdMekj7zsTOZkdNeeLgclaIcecTVi1RPklz?=
 =?us-ascii?Q?cJvvxY9Ed7n7TR9yIoNwvC0v6FlGc+jrr8hJeFfUOtA1vU3y62ebynsp3hOZ?=
 =?us-ascii?Q?QBn1cussJY+NmryRHbCrUZmFmFvUkBqCMrojKCIDLPzHMTGfSBDUd0Jb1xwP?=
 =?us-ascii?Q?DWC74QY7yqd+yRfe31h/P9oBA8dK7X06uVmUA6gweJkSVZeN53vn3TgojGrd?=
 =?us-ascii?Q?2DbIv7L78fkMp4IQVe2RFuoarBF2GbADgQpjynOy6jBwz1bEYsQQrIOONKCy?=
 =?us-ascii?Q?ygfq033aSnvYqadn47qm+DkWmfrpD1Kh29+12SHJ/xLm6bH59bzfEnBpJDQ8?=
 =?us-ascii?Q?ckf/V0+JOyi/gl+S3RkAeeLCZ3Q5h58e2lFwm7uoFiZGDYwwwA8FurXYMP2n?=
 =?us-ascii?Q?lh8rHYSw7xYOYY2gvR6qQhHfLgVrFPXrsLrkkQ1jHUcSlhbr0m6arMlaO8Bo?=
 =?us-ascii?Q?mLl7t0wfgp6F2PjsoEREWjomXA2SHZbXttqs767QsOuVgeeCRVkz+dvz8lAV?=
 =?us-ascii?Q?THTddNfy174dMmXA9ZSW9jcuQd3Q4E514rvWYHdr93+B4hGGQaI8rN4IyQ/o?=
 =?us-ascii?Q?YDjUje/YbmzXUaUgrbx4HvfiaJOJFZjnTT1+nvG9HT9AW2KeB76qr4jM4yTn?=
 =?us-ascii?Q?r8fTl0W8BCuT9G/lkPfiD9fMYUNOYK3Vwd0gx592kTh9c1cn+hkDr+Ld90DQ?=
 =?us-ascii?Q?7Uq/h3yY5MMTlNt+gu72zlMfAWu+3q83GhUscoWXf3GfvDZw2YJb6Az6WB/f?=
 =?us-ascii?Q?zEbJfKHT6VZOmh79J7Ez6MDEyskrHXCO5JP6Sb0StePSF8TXEzBaPcqtJxgf?=
 =?us-ascii?Q?LLKGs32y3fg28NYtSSbR65R5ISkJ4OfcDIr/C2PRrR3ae9YEJJCzGXS7Re7r?=
 =?us-ascii?Q?+RcsizSi5YsllSnZB0hj85lFAC8e/2xdTJnhs86Dwe7E763dVTJcyVS6oJQR?=
 =?us-ascii?Q?n8WitBN/Q3gBtQsoZhbLIdxBH0xBYVxRbFW02bYmjNew/etqKoQ1q/zyBHby?=
 =?us-ascii?Q?jXuucZ0qpGcU3wn+xnNZW8NnkqTaY22H76B9qaL4oUBpigMHcxAPMfMq22JE?=
 =?us-ascii?Q?DLE/JfVG5RIIvd4tIpzdYJekkNUElwQZ9wpk7wW9HEHvch4WRoPoRW3HR2Q4?=
 =?us-ascii?Q?bMdu0S2e6fWEpt43cHbc4PPUMwsRieXg+vokRolIST40NNYiz2x9YdWfqjVu?=
 =?us-ascii?Q?NI/u3amd/kVYtsPGiK/m5f6RSUmRWBGkdAIUlJS6BtyIMhXmSqtnkFHvzCar?=
 =?us-ascii?Q?XxgFvzf7O2vV7F8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXmgSW1p1KvhkpuiWQVZoJ6HL33SIgGkpC3Rf9DbsMCIpGGp9cKC3XpBFCI2?=
 =?us-ascii?Q?OQkhnJm8IwBLkafSx5ETd4+NIr0grTqamCL3/yzICcA7OC/KJUfDyhUKNFsc?=
 =?us-ascii?Q?sD6IZTVpjOmEQ7i8i9Cvj8DD4lpH5MjRxm41FxoareFFQ71TJ+HJ8Lp6ON1C?=
 =?us-ascii?Q?ODDdXPcxiFTgqaBmZvkTUuHU5kK2r4BwJbQt8cGQmA4cItp3nyNsL0/TGb1u?=
 =?us-ascii?Q?Zr1truCsxIB72QYVlPQ+g43ZJ5XVzE36B+3gGY/oUs03fvcB5dRBYQxDOBN9?=
 =?us-ascii?Q?PjB+ikKLHRozsAPKY8lcHZO4djUnaEz6OFtPw8lsA3Z9EjDy1zqn5bC0+vHR?=
 =?us-ascii?Q?MVPYZa7AmJjX+CYeu1nq4gkIRQww7zyTfU86D0Xqod+3LwxiMsWkSA1hjhCj?=
 =?us-ascii?Q?dS9yfnGZPEo+kSW471SMP3qOb6ovRdrivmfSwS+T7Dvb0WAsXvePemCg1awJ?=
 =?us-ascii?Q?1rgLPmm4R74clYxJedGoU0cH35vz5m4mWKwTOv5Mp4J0L8Z64lwITqkEdNVx?=
 =?us-ascii?Q?egR/tNWEVO2UcYOVUn/hLvZKYFqXW3XbcZmLSnipRUwct2ZQ6rQwb6eiSSKL?=
 =?us-ascii?Q?tri8S1f2EWIYskPwT6JBkl8tlMHPGg9Y9ACFB/KrAFb7fjmjOWAKNJ6n5VDz?=
 =?us-ascii?Q?xLUkGT328N8TnmljXizEtsXlRBy3hLVvTXyfVA0Ows8AEGjoX2VBKPoi5Ap8?=
 =?us-ascii?Q?b3FyCHlfZtbGw84DTCz7aBIArXcBG9pzEEGDxxAYte39Al3gL/oc89yKNHkE?=
 =?us-ascii?Q?4v86A07+evGRPaRcMMe076LeV1PXEJjsAg0VcqnDmUJVDJCKMgBbU2U/Iedi?=
 =?us-ascii?Q?QyhiGCnuU+kElrwdYKTg6gWa7YFMTNRkCG6owqK2AMjvibMxZxEleUVjyDzo?=
 =?us-ascii?Q?/JLQ9q93J8hJWVaUxbvvGtptmID72oW4IReOrpnF3Z6snlJ6j7opw7ag4C69?=
 =?us-ascii?Q?0gRqMjIAtcX6KFg4XCPC55hdsbIl/QNTBcqZ2rVI3xnVMplIjngt6QYgkpV0?=
 =?us-ascii?Q?/1Erye04xprDSIks+mvcfhwTP1Le8z3R9JmE0RykzLVgXMpxSQqXXU12p4PY?=
 =?us-ascii?Q?lYejim8iBcfwSbb4Ynt9M3KhPybPtgNf9Kj8bkqJm40bSorGal9xNXF+oUpG?=
 =?us-ascii?Q?8OyfnkAI7HDWCAGdQbAXmDIhmc/MZu55WR1W57n0irTUNhTgm48gMI3oV/oG?=
 =?us-ascii?Q?IRQb5ySBRpKdYgk1sMdgOReV2142r3Uyu53EEJPBu7FWblc2RBy0P8o7n2pF?=
 =?us-ascii?Q?xdDkJbyLnXq1m8qmwpDfJ+7i0D1hebXm0pthJxDvYjkqDW1+vtbr7Q6JKPKi?=
 =?us-ascii?Q?QghxaKQ42nwVP514U6Qf3EyyusfSoOE0H5j7Uva4eAamu+PRQtsnjkHb3Txb?=
 =?us-ascii?Q?XEeQKKOliQtsGcvHvYJTkuLPpA0grFejltNvMyfQryJjpz5tczp6khK5dkti?=
 =?us-ascii?Q?S73cy9kmrzxQNFFssINOkxtqttNHYJaTAM7e4KLfqafAn5YBeeyJ78pNM2EJ?=
 =?us-ascii?Q?u+9qxLf9ayoWuAt8Y2qrqh0g0dxc96Z2xo9dmLb8MA5jiN7UK5gr+AVn8lTQ?=
 =?us-ascii?Q?+ur7Xo+rmQjFIPrnYfFF7W2dzXmtX0mzAtrdgr/R?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544cb6e9-0ee7-49dc-0bd7-08ddd6474c2c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:46:26.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /H8XsLZEV88p4a1/NUGC6SCI6frSES3ld7WtjpN8hpW0WqJXMhCAYLf010rRWgCeLSuB/e7lZy5fdUctz/JHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8220

Since DRM validates the all of EDID blocks, allocates drm_edid data
structure based on the actually block count returned by the sink
monitor at drm_edid_alloc() calling.

Fixes: 7c585f9a71aa ("drm/bridge: anx7625: use struct drm_edid more")

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c0ad8f59e483..4b5a74e9785e 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1801,7 +1801,7 @@ static const struct drm_edid *anx7625_edid_read(struct anx7625_data *ctx)
 		return NULL;
 	}
 
-	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, FOUR_BLOCK_SIZE);
+	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, edid_num * EDID_LENGTH);
 	kfree(edid_buf);
 
 out:
-- 
2.25.1


