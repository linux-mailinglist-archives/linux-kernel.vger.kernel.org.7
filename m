Return-Path: <linux-kernel+bounces-856669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC85BE4C52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA72E544242
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F12350D69;
	Thu, 16 Oct 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Iujkqqma";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mEPE3t1K"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AA31D734;
	Thu, 16 Oct 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633943; cv=fail; b=c70sVbW2Voxbxthb4NttqzuXSDyoA378uwrW9MQWrSjrG4D9nZcK8VDO9kvLrA+9lGa6PAFpnfFk9KuhyIYdVlKzqixFvxalSUb2597iO0LdgUJnYcQd9z8M75rHSqeqwJT3bVLmJ5XWobxV5t8bKBAEg0JNrU4mk5Sgs9+KIJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633943; c=relaxed/simple;
	bh=HS2Uo9naVxxtKpYwUc0L+cG+1ST1OUNnCxXY31GY65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUBXiMd5cKK3kbWMLvOD9W884feuYHHWtnKFa//zjRrTnNmWAFP9K7GwuwT/Kjn/w76VKcMuriuOFULze3L2MH4BSkzaQb/kk7cvrcIdu6SZcOjL8KhDn1/pduo7c5lR/dBT6jM0FBFvDULGl6mATkIhI37Rf5IDBPPGFB44GnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Iujkqqma; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mEPE3t1K; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDT1pi4017700;
	Thu, 16 Oct 2025 11:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=; b=
	Iujkqqma3i3oA4ROJPJkZiawyIc26KzI1DH38hjQ8cpBLNnjQuj+0mXVUdxXise4
	/TPY1Dl5h+mrJbaF0AXza6eWUmXHraGl73pbQoql72b3O32D1lk38pWBLlElmp49
	IpQae76jstPlKP5Y3/wjbYG48gJAkFmXrejTK+A2raKWVqXD7AhuQzF+0PI+cyjT
	ciKceh+WcyqPlqA3+AY3RrDRViSf6pPx5mqnW5BvehCzfBJldMa9FUj7P1PLaYSc
	2f5ulY4wMUH8wjP7o2TogTAO64X6PfC44IPVkiCmSUrwwpjmiU+9oXBBDyk/8siz
	RPSCDbGjMp0ellxz1yyMxw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023075.outbound.protection.outlook.com [40.93.196.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngb3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoDkqGplMh4dH1jiyhgg0EDC//kFRHBJ2DXqzbR4oXhEwSsBO0kW525ZcUvdqz+KlYqlFP9lk8lSqygHr9XZEWvUjWA6EWXsZs6uqDGEP6/1tK8/MC3r+Dch0LGInr7hP4o3i+JwVqQaxHTYCcrqAAPcrVLTiJNlxrmF3iKUv8RYmHAMjSYeCaWngvQWtisj0jikdeyke2CGrpjsdkBrWn2cW+12wm7KEcH0jYkHJR2N6hwC0OLphJUeneJOtNTJbZ1OZFybeJzdVOrn9SMJRK52QAl4Q3ESNjyv4z5db9HJJz9QAewy/Jk2N3frPQg3cJ+brnFzR/DVPBQXfsPgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=CTi3CGTiK94Wq8GP1YNSa85U6akTa+i19nmZs/Ys8/IMVAkw+9gDrPxgPU2TRV8YsV5jCL7DqB5YFmBr17zD/xQH3BFZIFD6tQFsnzIfeX/xV544kKC+JFtbMK6aFcK8TilJiN6FInbNy+n+Y0y9of8lGZA4AVerjy+ZaHRz0gvH1jsEbVm7y/94ZSG8K1lRcGcuHW17wSdlcBd5JDjhUZJcsRjEcyGlIsuypJAiz3VgfT9/bbsiMmPXRPa71866vyYL6yhJgx/FtG3OveJre38LDCfDZNcv4de5/Dv5EqACv/wabN2X92vo6YBk5pwtP9FjRZKbGn0uv/7h4ZoS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=mEPE3t1Kfp5+g6U537+2+gci5jyfC+06mmZhrKEBsqJBK1qnDgHz4VDACa+hWvk3uotYF4VF0NQGbo9toLwxqWK8vdJKXci8OtKMAdxChycARGP3R46YAmBeyMYpYYZQmfDs3spAu7Wz17oq8KucHJZqk7EdEMF2J7WuxB1RA10=
Received: from PH8PR22CA0022.namprd22.prod.outlook.com (2603:10b6:510:2d1::17)
 by LV8PR19MB8446.namprd19.prod.outlook.com (2603:10b6:408:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:58:50 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::c2) by PH8PR22CA0022.outlook.office365.com
 (2603:10b6:510:2d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 96BDA406556;
	Thu, 16 Oct 2025 16:58:46 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3B3CE820244;
	Thu, 16 Oct 2025 16:58:46 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 05/11] ASoC: cs530x: Correct constant naming
Date: Thu, 16 Oct 2025 17:58:16 +0100
Message-ID: <20251016165835.143832-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|LV8PR19MB8446:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3324f5cf-2eee-4a62-caba-08de0cd547a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IiN0zrCvu/XG9T5de32Fo//OIf7/sldlAAuf8MaJbIGxP4QZJJ4f6sOoH4MZ?=
 =?us-ascii?Q?RVMjluphDc+3+zy4Vf8X+/944ZRY2d6elkljBI5bNBiKeWUVrNOao319oWYV?=
 =?us-ascii?Q?imHpZ58yQ2mUMBtDx6M1tuIelyo3uvtpAItQqc5CXjRNB8zfkQP16YxIoA5w?=
 =?us-ascii?Q?o2QVfbleIBgi9b6b47ZtKjA/0DbyKsfll88VP3QS4xRd9Tu4Rd4ZG63yJ61w?=
 =?us-ascii?Q?GjyE0IYH9B2oU5ro1MlJxfOQmItbHx/R1Nk2Qu4tERWMAUCb9eJRY639lmXv?=
 =?us-ascii?Q?kiq31Dobjn5Z/LPK3NI2atrnUpE/sdKyaYLDAyQwesmcBL32oVtIg5bXwobu?=
 =?us-ascii?Q?okmQfjmX1+nU1FQgak/LbinMnRgytHDLEB2qc7wpOMwsAcoZT0ZVSjAVW5jL?=
 =?us-ascii?Q?l7YSewUxsJO9TUsheSqEfv41HJPGIAT4CnOIfaC/fVw3CgNzMxWTbef4BBaw?=
 =?us-ascii?Q?FMlxhqlqxXfk40JWGyBVQ5PYLcUJl5Ek7fGkab2e5C1Kt5qndhRJdSHytOVe?=
 =?us-ascii?Q?FoOZogs15XqYOJQ8WH+TeJbAuIC6X0tmHT2ks/tLFeV4BkZpCUhJP1MHDdl6?=
 =?us-ascii?Q?CkK7g7zVUhkMIGifHAquFWo3iycBO6NtTLCPDsSDaUArRPcAkKGHTC++BoOz?=
 =?us-ascii?Q?TVqXMR3VbtBuzNmvECv2YPPPnJWR8r0eVV65LshZRjDKixPaXl1yWzQBJW4g?=
 =?us-ascii?Q?qRgudBGWEFdIxUku05RazUD89t43n7yzpjzXvD1jbnICwXEGwr7lv3/4dE1x?=
 =?us-ascii?Q?HYDDqwHcmpSkij5tYM/LtTd4I2APZ1V5Xim7V0I1Q+y9fhnh8yAChEO/tfNZ?=
 =?us-ascii?Q?iYvwmyTdqei3zMEcb7lz6iMtBGBJd0H95IzNvA/ay0AZrD5HPSdmCGvFeArk?=
 =?us-ascii?Q?mjQuWRa0c0JC7Wi6mURKMesWx1eN7YzoRWYC2/uwxnp5Ra/xoRxqzDfd8xqj?=
 =?us-ascii?Q?6smrGYn3Zg5FI4akR11awwVAEkQNB65XbqcD1aKJ3SrMLXf+MQmRrS98XA/t?=
 =?us-ascii?Q?N5qiPK998W3eFUCz6mrrIQi5QbciqJLbzr2NC562lbgQ0agEoWF8SwlytqQk?=
 =?us-ascii?Q?p7ae8aEy3Nuhfsy/rIghZXtTtlh9kDTTp7FV32HzTe0aN+wR+laE1UyqjeVd?=
 =?us-ascii?Q?/EEePAXqZcxQTPgT743Fk9H68Ygn8JOiByYQ6xyzqZ07FLhUIjRB4iF+p2Ob?=
 =?us-ascii?Q?KSZU5tF9lJFaepOB8XElHk9W0/buD1fcBqBuSf4ogY1S7RzlqrR0lDnSlyQQ?=
 =?us-ascii?Q?DS+zzTcyC2K26qLHO6MZqjfjnyMvRW5AuttR3zHNmRKbpQYTDyesW0UZ5EtX?=
 =?us-ascii?Q?aoxdCYgpAMY5KllCgL0sMsgf9ZusJi9bQDjREOfjsbRFFOAx3MTCZMDprl90?=
 =?us-ascii?Q?68swmwQhwCYT1gU3uBv4FgKi89wmVF2isW+nYdqRWRkysCnXDmHXYxDh3Ttq?=
 =?us-ascii?Q?ZWdCwnyDE9Gbqd6jfC28oiiqhKRoEBI8un2x/BO1cjkcCtNMYJ1gkNiF7IA0?=
 =?us-ascii?Q?aTQMBo4CX8Q4qjv85O5EGFgvUKfXTBxQPU3iC1k+ps4ZRt3LUot8fw8YX9Lk?=
 =?us-ascii?Q?cmHwoCeVq9RHVbWruRw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:49.9720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3324f5cf-2eee-4a62-caba-08de0cd547a0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8446
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f1244d cx=c_pps
 a=ZwnHHYtbhvZyeoWvue1Gvw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=zWlGrJBK1FuhkNR3vBAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: lXFJ6k8yoVOyLHacXjNFSL7fyxtPeWIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX5yYklSEO84p5
 iHtjVM6zQI8iyMRV0Ju4onvkhmjzwq2TliCt5QqIhfASZGraSimQbZC2Fm9tH2Rs4kjOc5veWBs
 ypp8tGkUFfD+gDtbi3W5csyYhyuJTkBp2IzI20FMg2o2ixSY5lvvRy+Azm2L3yyxJqsR6hX4p64
 xNiZL9+lsNcmJ/jzi2OIEP1HcdXIMRvgxL3Hvm2dZAPeo3EzVq7Qr6fKydz5vc7pEmRRN0Nx/4r
 4gU48jc7UkxuiIoj7cqcvjkISTOVkQ9dTOGCSEDekvJfaHVo1etQrk6S/Vn6UtnsNyvfKv3Frai
 ICrDroKfup8EjmR/Cm4Tpuz7MBN4008kgwDAro3uI04Us+RHNuuRiLFdCyfGhIkZ35SjfKKIl1h
 wfAuMQbzvDi+DnlkH0rfkeViYNKqqg==
X-Proofpoint-GUID: lXFJ6k8yoVOyLHacXjNFSL7fyxtPeWIf
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 10 +++++-----
 sound/soc/codecs/cs530x.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 4add46ef93cb..336ed5f225ea 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -491,23 +491,23 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 44100:
 	case 48000:
-		fs_val = CS530X_FS_48K_44P1K;
+		fs_val = CS530X_FS_44P1K_48K;
 		break;
 	case 88200:
 	case 96000:
-		fs_val = CS530X_FS_96K_88P2K;
+		fs_val = CS530X_FS_88P2K_96K;
 		break;
 	case 176400:
 	case 192000:
-		fs_val = CS530X_FS_192K_176P4K;
+		fs_val = CS530X_FS_176P4K_192K;
 		break;
 	case 356800:
 	case 384000:
-		fs_val = CS530X_FS_384K_356P8K;
+		fs_val = CS530X_FS_356P8K_384K;
 		break;
 	case 705600:
 	case 768000:
-		fs_val = CS530X_FS_768K_705P6K;
+		fs_val = CS530X_FS_705P6K_768K;
 		break;
 	default:
 		dev_err(component->dev, "Invalid sample rate %d\n", fs);
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 165adb88f4a4..cdd54bfa259f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -69,11 +69,11 @@
 /* CLK_CFG_1 */
 #define CS530X_SAMPLE_RATE_MASK		GENMASK(2, 0)
 #define CS530X_FS_32K			0
-#define CS530X_FS_48K_44P1K		1
-#define CS530X_FS_96K_88P2K		2
-#define CS530X_FS_192K_176P4K		3
-#define CS530X_FS_384K_356P8K		4
-#define CS530X_FS_768K_705P6K		5
+#define CS530X_FS_44P1K_48K		1
+#define CS530X_FS_88P2K_96K		2
+#define CS530X_FS_176P4K_192K		3
+#define CS530X_FS_356P8K_384K		4
+#define CS530X_FS_705P6K_768K		5
 
 /* ASP_CFG */
 #define CS530X_ASP_BCLK_FREQ_MASK	GENMASK(1, 0)
-- 
2.43.0


