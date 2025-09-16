Return-Path: <linux-kernel+bounces-819181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EDB59C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D8F3240C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6669315D28;
	Tue, 16 Sep 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iyHw8xrA"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B8309DB0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037924; cv=fail; b=hKZU1aAXfFbnQ9t0MU0OQlM0eNPDg5r1Xanpg0x6dlpdQMRmGEIkm6bPLfMzu0+27IJi35dXbugQ5HRVE1WrahEkyyFcxBQSdfuSkDqAeg1No6e3AhfuZEmgpSvFnTlFt/Py9HR8upG3LwMT63LX3ks5xxZ9Y+cioQLCWGbFrdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037924; c=relaxed/simple;
	bh=zA7hAbGw2+fwGLWqqJ55/UFfbCMYe2FwTDIr8XRf79o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UKgQPX9d2kcJI/gVSlGEJJsifFs+YIYvvteJWFMIY2s2peYPc+cNsU+SfbAqxiEznvW9t0TXosL0Ng7gbxTo8PxouXOLiuX5qPfNxG/OmGnJKMLcKQHvtQst/YtKAn0I1HMYq8JtOWwQg4vhKl0uM7EST9yF30zWzZ5OlVLc+B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iyHw8xrA; arc=fail smtp.client-ip=52.101.57.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqUNcQmLLtdqpYYqwW6oGZzfcQ52W18gmZUGh1pRS+wNeffhVbpAYe0EeaIn4s+SDX/ObkKbDLgJLlGD6HySEjxPDZlrN4o0AyxNqAvuLhpW7vakJiHl1dWC9NwZLAlR4Xi7L6OC+ER5+cXLUFSZ6ULWHTEHouQMyB6S8ItejpjlwiBzspzpeTFcBNwt+i0RRWmXheqjSZY7NVFpLsx+43txd9OAv8Oyi+Wmp97Ewkgc2m5u8msjefa4axupa6ltQcY+q2HKDHQvjGcD1SDO5NQDwZSDK2mk01aqpiUymx4MyZTju89Az1Idkf6zweIQYFncmq19YScBE1RDJXu6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X93WleMYoA3TfEJpZimh+X5R02K5hSZVqqQ2U3AMqSg=;
 b=Xsj5YVYcGLtiK4w+y74mBnOtG+a/MiWNM35VOac2Fq3XK1lZxFhQ8slyeFD/4yT6CGFK7OuyC6jRkhCpwyjcZQzAoQuSDmzfCo2zPzE+5Ahn49NCCw9m9RQGE2Awp7WDHAYjUn7x8B416pbFjmm0MIeLglaMqCcyCJsWYsMzejzXLAO3jPqgZXaRj5B9wdnL2Oqvy9jROxEmcshJc3QAJmNV6o/K0sXxa3Ie49NEs8rzRgB5KF/1lv7yrDZaYt49JZi/zXgmM2vYyNPy2AkWva8ZA1qS6yHjb1luoqOQTPMo5lIDds31J3Rkg2VThJCdTDHsRBC2SeYk5DoHCDJD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X93WleMYoA3TfEJpZimh+X5R02K5hSZVqqQ2U3AMqSg=;
 b=iyHw8xrAtYwVzcqxmiX2WD6BBLbuQZn3SRcscPowDLGQ81ijfPiJ4KbiIztrZ1a+N2qSbOzUmD869mbrzDg58aJsrDSkc3i8032p86Igdu2qAzNM1iJ1RIx8NAx1Wy+N7i13fT8CORaDwK/M9czm7VciyyrVfUnippdkl0fXT1RV5exr6nBipwTJhRVI9Cj/xRFfPlFcnEjK2Pc10qDjcAqFkPn98fTWPIvuUukMO8+rxErTwRHD+0dYBqGUCxGxrHEtqZSOOIeBEeniHKmojZtZztK/9MLUSXF86DT6lOtA9O7pBwCU8vOYiQn20IpDMqhYlZnOM+TbhC7u9FaT8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS0PR03MB7727.namprd03.prod.outlook.com (2603:10b6:8:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 16 Sep
 2025 15:51:58 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::79f:ee0b:809c:4efb]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::79f:ee0b:809c:4efb%6]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:51:58 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: yilun.xu@intel.com,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC secure updates
Date: Tue, 16 Sep 2025 08:51:52 -0700
Message-ID: <20250916155152.411121-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:a03:167::43) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS0PR03MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5327a85b-fc2e-496d-b782-08ddf538f7b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1xJgxI9lu5SwViL90rguiI3LGzz6w25G7f/5trtj+/kqIva9pXogAl2WDyR0?=
 =?us-ascii?Q?sCiHZtFPIYHpQazx7diR0fzPV3JjtkFlqRKONsZkRBmNumqWpzfT5GObG1be?=
 =?us-ascii?Q?jwZuv74QeO9rUfYs9P1b0sSQwUK8Km3X/QnXV/YBHeoo35jlxhadmLcMj2jc?=
 =?us-ascii?Q?j/PSEzUMPSZubTpTqHGNSbHd4yf16twR4EkSSyK33/e/qxi4j5UcIF2ghYzr?=
 =?us-ascii?Q?2tJ+iq/rBr+CJity0+Y7mFPnKseuV0nwhMS4U4suRrvWoLUTCFpm+0XIFqJD?=
 =?us-ascii?Q?4cxPSd1xOw1y27vfEY31sYEuAvS3C1r6f+FKkYc+F/fNzZ+s0QNDPdpdH2DU?=
 =?us-ascii?Q?r1S/QWRYd5xniojqHMZ+3IOmpO/PKb+hV7aVCZtjFUVQT1V2crdEHrTh6gIE?=
 =?us-ascii?Q?M2skISIJBpnzJ5a9mic0JFZF+dVNzJQZLSJt4bf7oQ4u6xDbmCdX31FIDRrv?=
 =?us-ascii?Q?YGaVf11V4Yl7BPLXGejDnVxP0Jxm+v9mdOAm9TEBZl1KnkHv9QDJ9+kn+feG?=
 =?us-ascii?Q?gfAH3iq6+vfPFdIg3pcVbmDykG/DZ/e0uvWh/W4ZYTCexuns7HGGh+6e5FWb?=
 =?us-ascii?Q?YoVbtXDxJ1eSr5il5P/TmG8N97XpJwqkjRqPRfvVwmBFQ4dOX7QYyLVdYZs/?=
 =?us-ascii?Q?glfSwPynUmK/V2YDAlzv/e5fmnnD+ttWhj8wGEjNo2g69waW5W1RMY0rTO0j?=
 =?us-ascii?Q?AyqlvRyl3CR6Uaocj5sNaYm0COuUlbUmSKJdmxuR/z22v+MywQE5rX68nb+N?=
 =?us-ascii?Q?J7B5qxOd+EKTfRZBP88ulUgskSYSqt1M9rrU5BDyagXMiGhkGKm5zj07QyCZ?=
 =?us-ascii?Q?qV75KgWLU1FdcKzDeeJsanwpJiwFfHkeS9vL0NHwKYincZYlkeISqOpIafrF?=
 =?us-ascii?Q?Xrt987lu0rgBd2XEWhQiawIP+XujtzLufpEGqyeUAJhFDc6rD79ZEprF0I3S?=
 =?us-ascii?Q?aqyeeN0iV+sqh+XP0zcuOduhhy0Qd3avsBGTVlESWrC4rf5MSR9JGC99gGgm?=
 =?us-ascii?Q?p8BL/61uKH4We6dlF+fvnTlvZwmMFczppgcaLeP4Df6l/CahNW7gdqwoem5S?=
 =?us-ascii?Q?91E2/NGwqnAZA6Q0YPmy6RpF8t6Ne7Qm/Tg1Ix6Hpfp6spd+yIuiZpx0yyQX?=
 =?us-ascii?Q?GHdcKhORgEQLz7fvxFCzdYsqvcIwQhbkpUknM7++GsQGgrGlbGkvS0szr+ls?=
 =?us-ascii?Q?plGVGQIVXKrLdEgtVa3k7/OlvhCAUeInnURnsR7sj0KpIDvFQ77MyBLwOPhE?=
 =?us-ascii?Q?eVrwSOaRSmNm1i21OZBNNrE5zDn92ccX7OEJ46LlGMynDvjVU7I+K07HZvZf?=
 =?us-ascii?Q?KBVvmHD4e7gPHqGVwdnm2M9XcHy5J0Vrpr3IMdJ91L/ExgpPccuVL7accUs+?=
 =?us-ascii?Q?PC8SdXaekZgW+h8ExDKWD6xSUn7dO6nmenux9lRS95abM9Ypx/Zsmuf66K2f?=
 =?us-ascii?Q?fqLLTThEYsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R40LN3SVmQglochOu4WiMULxkT/mjfRI+e1YCilXyHjhduQi3ZMVZV2te+fw?=
 =?us-ascii?Q?6r/mZmmmCvBRfbCS2nomha/aOkHQKYa/uaUTBf/R4Jcu9fPT3MEqvSCO8qM4?=
 =?us-ascii?Q?oJlSdK7PL4n6wdTcLZer2mWLgkjl1rK3ZxUhZy2naIcEVkrkPJXX19c9w2I1?=
 =?us-ascii?Q?zta8bXpAVhns7myGfU1B+dP/aUb5yN8sxrcAx0Up60DX9hrBeswIOMLxbJQt?=
 =?us-ascii?Q?nM4yYWHnyY81KYazg4Xdpk93Y0wRGFbQGyBNFxsphl7hzATxyDMs1SdmAOO8?=
 =?us-ascii?Q?tBs3VxdNHBHQvczXxM/0IWpaCgL1ZZ2IevO3afHepw9M8s/zPGfogwUJ8KWw?=
 =?us-ascii?Q?qbEf/UG+HWlnB/gMjz50zm9Vab/7cQ0YGgrHC6u/1/TiyB59fdAwdATxARor?=
 =?us-ascii?Q?h8BlVhT6NXgG38zletaihL1hHbHuawQiI6ROMe5ssWNqp8qwtlExop+7jIMy?=
 =?us-ascii?Q?bTjF2UHE0Rhrm9C6DlR6/woI3itigIXx0A1OJsbx1helZKo0TXaXrScas2AY?=
 =?us-ascii?Q?Kr/fAfUTRM63oHRu5GqqDjSBBiISnwq8GZoIPew1hYBnZW/JanOSFX5oLbaz?=
 =?us-ascii?Q?WJ4uhcj2N78yk1DWs+464lQI59DZ+ZU0Cx8eOSrkxU3leliKq/UVXoovY7Yc?=
 =?us-ascii?Q?5urg+AghVPSkHJUVnSNACw0c8e4CXx/953j5tHjZl0GTFyr24nTRaSjPEHmI?=
 =?us-ascii?Q?5u1QAzVvbhCkplcvyVzFDQbrLNMnJIJU5VfJd20UYq9FDRRthdttWCVRXz+q?=
 =?us-ascii?Q?S4bpLz5EXUxzjXVw0XMmD3wX4Xx1bq4QAnbwsuM/eQLC2BAGv5cw2XI3wul7?=
 =?us-ascii?Q?g2Ly9xDmHtwBywsGRUF96fXkNpEzA2je6q/94Sab+y52MobxNB1zF7Bjk5Jx?=
 =?us-ascii?Q?YD+cUZibZ+hxSFXtAtJtWSVF/qeciLGm1eE8nlFjnB6w6WOEO1ULFXpcXGAT?=
 =?us-ascii?Q?P439PUyEwjhsbPQyJprKvjWl73eaAECP0NYonDmikULXolZw8aJizKsttyxD?=
 =?us-ascii?Q?/G/LTBbqB0bVc5kC8OS8aqhcSqbr6UPa1KpQegjSDZlSpxAWTV5DE39/PTQf?=
 =?us-ascii?Q?Z2Ho0FSX/O6rY6LQ0pTXtvKawo6VZbuLceITsRdPShc0EjV+NXHLjoGF/D8u?=
 =?us-ascii?Q?pTwpbz5Z7AEvKGoPfayOnRAywpYivUOPaKyxtWsI7eFN7k0r9AR5T1s+gExA?=
 =?us-ascii?Q?AwlKXPnTQhkMjJUa3L4CXHi/kP5fH84EX4BOJhWXqlXvXjjDlRzseiMbEPLn?=
 =?us-ascii?Q?MJrEnMrAMRdKkOx1XT5AZ8c3YHcLZO0X/X5vyavZGDuE4v88l97zvICKslCz?=
 =?us-ascii?Q?XoF1FGhYtgPctq8mt5mAaZliInqdMDWpeTm+4WaQX9bC1/gyCS+eh7t+f/ke?=
 =?us-ascii?Q?DNEu40PM0Y0kjDZNHsj0dqD75uo0XFdQwO3ifUwX+hJFqkkcJrXK3DX3yAhy?=
 =?us-ascii?Q?9B6h3c6zNwhsHRqqKCO2Ou89Gayv3lISTNCahnspVOxdfjMgI34pP2Y0FyR4?=
 =?us-ascii?Q?/i7gVbHNBkuyAYL4DQuCuMiLlzUDzr7KQ23WWHpcUqAt/o8T6w4eQ72OuN2G?=
 =?us-ascii?Q?n0aSFw0haAjd2Le6v047STDqGKPXllfXsrZitp/TwOjZ12SA6iv1+31Al4TY?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327a85b-fc2e-496d-b782-08ddf538f7b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:51:58.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+EnRM+q3sCCMlAJtmS3mydNBHZ8Oq9ehHEGIj16ScdLim0n9g0CXsEGWTl4Ble9iaJXdAp2TJJF4i3VxuCaMrIY3FFu+GfVbLkzwe9r0Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7727

Xu Yilun has kindly agreed to take over maintaining Intel MAX10 BMC secure
updates, since I will be leaving Altera.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9da37c8dee69..b9c1bf9b9dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12689,7 +12689,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MAX10 BMC SECURE UPDATES
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
+M:	Xu Yilun <yilun.xu@intel.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
-- 
2.35.3


