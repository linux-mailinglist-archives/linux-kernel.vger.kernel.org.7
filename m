Return-Path: <linux-kernel+bounces-879794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423FC241C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3608407306
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77C32ED3E;
	Fri, 31 Oct 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Wvu0RMkS"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3932E6AD;
	Fri, 31 Oct 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901704; cv=fail; b=aNEnHhTPRjUMYGOoKVl6B/Ob2yTs5sstad0ITKf3WjHhwHvAwPIXRe/o+pMqVpjlnXB3GvstamcPhU6qe/rj5ZwUAUIzOu0RyTiFtfI0RN0jUOeAr/MI6Yot96Jqfnp7d1DHj3RpDjIdlWM2zdi5KXl95iqCvVrGgjbB0l7fSHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901704; c=relaxed/simple;
	bh=zc7p8q8GaWeg7i1xpM5qQXfV6x1oneAFtgt7Wekw2r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3Fk13QgYmJIgwWnvE1UlQautPQj+Wd6Nwpyfkv9IbOSTU9HdMQ/tS69cuG5IDRmghQQIR7K/X6sL/fVqndK4QCaaTdKDM908MNf/XLPCfi+dPihHeNnvU96ksYveCaK1OYJurZIT2kVS16nSBSWsZ+7UABu4mswAOYijfXp2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Wvu0RMkS; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVH+Fr3EPB+g5jY8qzIocMjUbO6jaU0T0iW84GoIt2T1D+xkJBTW/taviJm/0cn4224qpas/NrHho8cXHOQUZoodobTVX435nBrVTusCntVWAC6CLjdgs1Ct38EIeYOlwCsp66qQPiIfTHXRAPgFcX2/lbENlgePZtipP9vmQP1KQdSHXvYh9rUbLUGLiGnzAiZCzvVK2+bCem1/WAlZiDaOGcopfjKvQAuo+39sqmSYwdPbaf5cgGrKBmyoIWFKoeUa+wtuNwwhWo6B9bCUxEwCV0a/VBDtt9K35cITqxsHwAvAyFun2RL8hgFtAAO+MwgPvaGNym1aq6Ox+SOOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzKcYfXEHV+HrwnN8dj3/cA4YSzTWnsVhIsi7pZQTCY=;
 b=Sm6fBJ13daJm6kC2k9FIupQVp8DDAp7uStP5KJrr/eJcq0lebibplkf3F5mi6k3s465XmL6FnDLmM/o3xRaJ3z3/8UMJWlUq3Re+gYx5sS/dnXENCKC+oRw12LKlEW93TaZjhySWALNVAgn21GVsXr+2RYJ6RBw2S3D6MOD8led/LX6rJKdkDL4HaujrF4qtpCfl4ga43zV71c1ggf0z7qHugcB2zVU9mB8xXKZC/alKrBjveMQxbpMNis/LZykMoaHQwT2uOhPCoSWtTwNkgAQuwWmlz7SzZOvmA0iPe0jcNc89le8YzcQLfvkxuOt8HXqXtRe2odwMbXhQn9fQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzKcYfXEHV+HrwnN8dj3/cA4YSzTWnsVhIsi7pZQTCY=;
 b=Wvu0RMkSOWSrRH+2+0wM2uQqC/4hggG8TdHspBEjVmTIwpnXX51xxk3T6pgoMAjBzc4Fy0USPp4D43CiKFiKDbJSMyDvmmLgK2/xZOTc61+QMMvfGc0KxHCyxtjLhKx1wpBNn9D48w6sGRZ120OdKQRXHSjZbJFpbS//9SzmxebCvLjyosL+xNaqfY771oYEzKs9CXuwIsAnOiz3qtVMJTUpO062hRomOGz6Ieetc/BhbVtCAHKBUvrv2wHFLeMuYAn0+lX1vxqi/YVlU1o0IUidfCWmCfJAwyDtpJlLOJH7Zf1v2iCIvivVLbmsqaClODhmbXTS7CnWR0lTwAAGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by CH2PR03MB5269.namprd03.prod.outlook.com (2603:10b6:610:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:08:19 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:08:19 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH v3 1/3] dt-bindings: i3c: snps: Add Altera Agilex5 SoC compatible
Date: Fri, 31 Oct 2025 17:05:56 +0800
Message-ID: <c55c62f31b63a9aa821501bbf93c6b5e9fb2487b.1761901158.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1761901158.git.adrianhoyin.ng@altera.com>
References: <cover.1761901158.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|CH2PR03MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: aa040aa5-c660-41b9-a63f-08de185d08f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDee/S44b6jXJ15saReI+7M9osGx3NEd43wWFkWofmpKbwAR+8wyb4F695OV?=
 =?us-ascii?Q?qOuoMFckJEtJbEwnFKn0bFVeWoLqMM7vD3hOM7LRct7D6ZeOpjUDD+G3KFip?=
 =?us-ascii?Q?rdJIT5Zt/HwGm+qKreXyrDwXLby2iyu8MApcCFZdmGlBmgr14Ee2Foy61Iaj?=
 =?us-ascii?Q?A3Dl+YavGXAAJyjk4xQTjK+SgLclTduRw6mHCndvPY/+WfcOed6JSmqgcGPT?=
 =?us-ascii?Q?Ulhg81L/OuhEy59yHWY5sS5c/JQkLHHte2+R+TqPp0NhRIu10yPsWfc/qg2d?=
 =?us-ascii?Q?AJsFJhF+ckS0BwVQlA3akUr385Xub3qdLBBO14fQW+R5uh5EFzBQTQ2frcna?=
 =?us-ascii?Q?81w+zF3cEIzjaMGmL9Nm9P571dX7B3jz0JdgmmIjniRVLnBLYrEk4qjV9SNU?=
 =?us-ascii?Q?nQRW4KbdTIS5vgCnf1LCGfNAFbr+VfIJeCKOEMD6LjrGL6A3QVMCziAEAZsa?=
 =?us-ascii?Q?eF3wHHzG+K+ojIKSKEeqniJ0jj8NzpU8cpd4rvgIzy8pqblHGEBFjASe7rMt?=
 =?us-ascii?Q?7FhuHIszVAxuI8qmp7EiVYv2KDxnFuxD1rG+06y1/ULEUATTjvmza8rp3WCX?=
 =?us-ascii?Q?E/C8rezCOyNDn7At837Hc73tW2Ay/ea3X1+604Vx/AZoxXyrJV+60dMyaJyV?=
 =?us-ascii?Q?NnMyod1NZB7g9cagroaFK6XPnYKseTeZsQg3r5aQhilMBSUV4U1AYgQukY47?=
 =?us-ascii?Q?dLEdQuj3yw5qmnxUG7Hw/QlBdfs9imzouc+COqAYKxBmNDFHMV+fcDrkzDzA?=
 =?us-ascii?Q?o5uapplN92ydaPOQySZXKI7RBLsJsZf7OHRRSzs5q6oru998ETaB0ZGkEh0v?=
 =?us-ascii?Q?OlxV48GK5SUsi3uLjmWw74qhSXe0UneiXTd7x1LEgart82rferuiAraQG/8+?=
 =?us-ascii?Q?wP/d5ICOARurbaENgrL4oYmMTeZ+y7tyACTCm9RYZ3+qPyoP1L7DgW9nTggd?=
 =?us-ascii?Q?DZi6rgynTUSvMvyBx3zRronuHAIXvtleP3tmnuNI/+8Kv7OI8kvFJ64p/luN?=
 =?us-ascii?Q?z4O9+DITAQEk22XGC6H/tWilQAc5L2xA9R1yAgJ8ew4RVEO17EMBqZyI3as7?=
 =?us-ascii?Q?F/zmM1sYXU+eH2/+QSCzo9J5vTlTkoBSzYak1yeTZaKPJWPmN834wm29QzOE?=
 =?us-ascii?Q?Qg5XHcYZJb/3YXZDyAEMeus78E6YRQehA/StfHjvPpq95eTr5BXIjI1GQrIW?=
 =?us-ascii?Q?oziViqMZ+dPVFu73IHMptNHhnfmdjN2GL0XjbvAL8B34KM7enD8vsfjTgsvY?=
 =?us-ascii?Q?6/KPrRkHH43/NsEUltq3fV7FwnzbTUlp4cs+XY66EUkKyDAOg7qvZbICKDG9?=
 =?us-ascii?Q?2BaRYSsLvlxtIv+UUNL4A7jzsQ9hxYk1k+yK4SVwSRGY0dzAWag6Cd2lM+l4?=
 =?us-ascii?Q?VO7QoAljXFqFaiFwY+1EA416ZAZeW0B4VqpsSdwdcgoka89RPO5pzMZ1lTjJ?=
 =?us-ascii?Q?7JPnVdZcEvanymRq8pGGX1w6OW2cxdFoflyM5KJsnN5xixfDflLMS34n0nhZ?=
 =?us-ascii?Q?9j9lLWuHKWRsI8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OLZqN0GIg1dNEMlTanAHQlvtRCfpuA7FWQ49V2VXF0WvF/WmrIs1P3q+nnS?=
 =?us-ascii?Q?pYk8s4j1gyloPp9TGwTh6Rki8TndhqRNDwGMl1X6RRIS1KDymKoMICIrKlF0?=
 =?us-ascii?Q?yz8shrHDrMf5o8awlJ9hqPVl6AJv+HJgnCCJW7LbWeQR6Jw0X0Fcjy0ErXbl?=
 =?us-ascii?Q?Wpo2GmmmpYfuRhxD1x0Yg2RoGV1j9GKuWwTdtTojTeKv/JMI5QtdNxDyJNeB?=
 =?us-ascii?Q?zM5cqQOYzNm8eN6ISFz1cXt6+AcYIHVnUixA0u/Ys7oroacsSgCidYFI7Vyk?=
 =?us-ascii?Q?OYDe/kT5o760TA94kTc5yrsu1uGBT/dm5fL+NPhxgh16ADh3LAdpkZu8Ckeu?=
 =?us-ascii?Q?cw7cfGtTDWVoXbeT2JAdin5JHVAPosN8lH2FWhq7D+gC9fBoTG7+iFTjQjv9?=
 =?us-ascii?Q?I/vmk7AecstyFN/onz9GrRrDd1YSQiCdBTW8I8CysG/gMvHNVwgqjAsVsD3j?=
 =?us-ascii?Q?Y6mizxuk9FpouWANsK/UBbEKTAP//uuGoUyjZF1oW9jUO9s5jrdDWLCTQMo5?=
 =?us-ascii?Q?1O4YCCY/mvX5jVmBLFUZmd2RUGk91a0A93p1wc8bOo3wpPFyYM2eMyabmtvI?=
 =?us-ascii?Q?tUqkiNdY4HdcWGetmYy+tp1YcolvOkGgtGEz51kz48iEw6K7AmA2FJOpLwJx?=
 =?us-ascii?Q?q1Tfg5fhuhFwbn3NhI/RI+s72wofqwCHBLlkRbPhl0vhpE1In4bGrwXe4Szz?=
 =?us-ascii?Q?+30YQwwW0pYT51EVIblIlTF2xbtH/U/eq0ekfCtuMv52njhNU65kQlZWf3IV?=
 =?us-ascii?Q?g3Nm/vnrrFu2wTI7umhxA8uTxOd64D8Udz/ISzkxxTSukLyRAR2InPGEnmFs?=
 =?us-ascii?Q?epsVUbDaeTCBndkjDevsZ75QoyS5cV2QYWCYhR8TEv+dQFkL9B05+r71BOd7?=
 =?us-ascii?Q?vqkfedGPWidO0auNGTBLe11eOUuoajF1jBh/tFBnG3Sstuo739+4b6m3uzuK?=
 =?us-ascii?Q?S5EjTW6pFs8yrKmE46XaW9k0/2erTke7wVc/KXfyppqf5AXD1/8nD5E+dqBf?=
 =?us-ascii?Q?WDLILmeILXiIXKIIrYOkjpTJ5juJi0vv6vdX2N4m3x4K6KF0R4VKUi79pwcf?=
 =?us-ascii?Q?ufKCeI7DpyGgCRd4sGc6du+KUUsohJFjYmWqrJiaVZelPJx4f+m4H/AQKl/5?=
 =?us-ascii?Q?ahCPbFDJv0NZdi1ASICqo+pekwIIxrrDE73c8+4bH0KlhNDVvQ0KmkdaO3eM?=
 =?us-ascii?Q?8RAwB3h28ctGphf0zbuxNjTRDkIxnX+BGAzngleWh2H8/uEhWD0INVeBwfHT?=
 =?us-ascii?Q?/A71iaHliNJM6TINNoQ3Pp+T21QDMEHQ/6ky/DKBROC8/Vm1kukIKS8WuUJK?=
 =?us-ascii?Q?7B4wZOMIt8CNu5mwjAMhrKM6UUTI4tTOXsKd9DJY39Iz2v6RfI3fpRsft8jH?=
 =?us-ascii?Q?tefBzYuplwprvuZ5Vfe2lqwZlQzH1gb7m6WGQCbFsq83knXiDponCE12dF3Q?=
 =?us-ascii?Q?KTAcSwZ2lMOUF4CcZLc+yre97J2Y9sOOTuKcXvBAwhZcmat1K/KbzhP/vJfO?=
 =?us-ascii?Q?x2AkaEkHrUVMdK6r8Jn4obv24rsjZKRsZ5kC6eGgwX3/X4ya6ukcG9FYV0ly?=
 =?us-ascii?Q?jpgy5gEx9pzifHX52vGNACebu6hNcP52yE4+c4dCJOpBiA6MdSk+fiGPBGlv?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa040aa5-c660-41b9-a63f-08de185d08f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:08:19.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5dAwY+D0yy4V75nYRVdlQsVreVy+6b85OHL4D6nJxxuQJEi/l12zt2XTobmibm7OIUAUOJ6cqkJJuDwO5EOTJuB5Cenc9E1UrJi8AVdlhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the "altr,agilex5-dw-i3c-master" compatible string to the
Synopsys DesignWare I3C master binding. This allow Agilex5 to
use the generic DW I3C master controller while applying any
required platform-specific quirks.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 5f6467375811..e803457d3f55 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: snps,dw-i3c-master-1.00a
+    oneOf:
+      - const: snps,dw-i3c-master-1.00a
+      - items:
+          - const: altr,agilex5-dw-i3c-master
+          - const: snps,dw-i3c-master-1.00a
 
   reg:
     maxItems: 1
-- 
2.49.GIT


