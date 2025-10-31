Return-Path: <linux-kernel+bounces-879798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A7C24109
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160845847EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CB3321C6;
	Fri, 31 Oct 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iPib4xQi"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44916330B1E;
	Fri, 31 Oct 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901710; cv=fail; b=HpcaoJXy05k6tvseu4P7Psjwu8SrHHvxQVs48qNyjrhCApTidPUhmDAKK5GPJsPhgiIV6XZwmCTJVoqiGi0hDGOT8ezHJjSwFwb0gcIuIFdqfSxQ3R0nWJgpBGBM7pGUpPs6oHD+jy9DLtgG+TGDAMLzXzen5oYh2V2xp3E0IkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901710; c=relaxed/simple;
	bh=RWQt/fIXUD8wrBFfCJlFM1YWH30krNvK9QEPRadlops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TPTyYq0I6FM5j+nNxusvAnWPp6KkDidckkPkIt4SKd5nKRMg337vk29Dx4zZtcJCGEOjUUoG57dGH6bBm9X5r/tU+8uYhV7Z/rtoZJMMCS/umjLcugIZ2zaQV7RtbaJ31/5+LrZ2X1TXL2OuFubj17bfTEa/KXm2cnoV3Ot3UKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iPib4xQi; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0/X65scQAbf35heYmwImNh1pVxsWeJHnGHrN+kyb7uklNTD1CvdM/5rQj9HWD8rMa24jseeL5DG1gd/DafjfSMTcX6mz6GnIScO0e6ObAu1uVFvamQ3XxyMiW/vlA7cN4Cg6BM8fR/i0nmYJK01niAQzrVgGZJzQZHBUS3bMk2rtss/FAvU+q8fjeUa9JEmTYI32SyRdOfDy9KmM3SLvQ72MlsNEfImQHWuUQdx7zu2xgWQMa+na4fl6+VBqW7Eow5/7cX7yNye1dj+4zoL/nx5kAV5CHzC4mx+0AbMOqYJaNPpjhsVBYQamhbYmVByhf5R9OalJLsjeOdUyvKGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a06TC9fbxJSuXnWSo6SmK4mUJuFJixpOaXwRGeUP+PE=;
 b=LoigQ3IwgIVGGRdSDHZD0ucC3iD/0OOx7eXLXa4K/Q8+OEmEfoSCj8j+uchGrUEGg2Lk37c7IOjwhGYSqlk9MigoJGWUrHbk7DjSpPFegb1jZO3K55SljmDSt5sSwf0lvlaPDI0+q88d7UOvljm4cmx9NZ5KXq8cXNxsSBcDriYZrM9/nFpF7euHiNj7lQ6tQQwYadV9I8lB77Dr3S4uyaS0B+MgsTW2LNRhAzmm+nEtOQ3qZprT5n6Ou4iPt5LHfEZQKLg5er+h5rtkP7yqHcK+1ypHd040OP0FZFVHuIsxYxWoyBMzude9ZJwGo/y0gT3gVagFnjJUJ06PkD4Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a06TC9fbxJSuXnWSo6SmK4mUJuFJixpOaXwRGeUP+PE=;
 b=iPib4xQiRPVyyWcn744vVz9NvUt/w8KBK/V3VuaC19IfXS/Pae4I4tx0ASaBdb2qPBwvGiY8yun8HNBVAXv1LQ9XWzC1JIFv5SMDKtWmOI2XbVWZTxtzRypIXt+lM3ktf4f15Ew/JD9WPn4nqrnheHBuSSsmp911uHYaaAsTtRS+76h2TXjNxM5TyhfLfbrlp1z5rZBsFEtbiyVLJBPOhvJIN2ofpd9IbmcKIzFyu/dJZ7LmtUsEsJSHSb0glNeftJrJsOGQ/NH+61yj3W7mu51aDgWuvoIDJCkc4HDuUn0rUuVgE2C7zhDq0OdGEwhWZChEy+emDmjom+O1Ga8ZDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by CH2PR03MB5269.namprd03.prod.outlook.com (2603:10b6:610:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:08:26 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:08:26 +0000
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
Subject: [PATCH v3 3/3] i3c: dw: Add runtime PM disable quirk for Altera Agilex5
Date: Fri, 31 Oct 2025 17:05:58 +0800
Message-ID: <81ec74bab4ed1e843709ad95acfe2757b737abb4.1761901158.git.adrianhoyin.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: aafc7aef-bd87-499e-f76a-08de185d0d18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZ0xqBZ/Sq/TEcpppyeEPoTM+l2clIWA4lMzWnOj6PqXNk6pHcWjNrqPJyTF?=
 =?us-ascii?Q?nu1rhwb+hR9lHxLYcgvZCC95hZS3Es8TJ0SAAsCJjpFbii/VJZY/geyllaBZ?=
 =?us-ascii?Q?qcd0wlm0L6cWlIXUgj56lBCSfsj0Lunb47zAVB1pmHa1h1mVTXcONQfzaGhp?=
 =?us-ascii?Q?+qXmzGpSDK3qze2PRmcPRquY9obUT7j7yKP/eT9226Rm3qU6wJGnXJY9C8m/?=
 =?us-ascii?Q?XAzxBAU/YHPe2cUPFEHYcJpPY+CAQnVIn1b4chsaF0sdCa1lk4RGljs3S9s1?=
 =?us-ascii?Q?/FR2eoWm2NNKY0fiDtJ7AszX9TWPBAeXKLpfQzkBdJs7kxWzgIuweyPu9U26?=
 =?us-ascii?Q?yLpQgEqCTHP2yhPV0CWyVE0xc10AVwPyp4xcO4FlVmtq73Sr8Dzze8YBQv8k?=
 =?us-ascii?Q?CfWQyh03K3Hh2Km1Pbi8hrvvdZl+0XWfBpqaloNRk+p0Fok7U5xAbhQ2YhyV?=
 =?us-ascii?Q?9AW0jYy1Dd50ZEFX3cw6a06zNi5ylrUu6YsWT5EtIaay1fr4mdK29APcHD8a?=
 =?us-ascii?Q?yC0U4qE+9BFXuRCr1WhvYiUJnsN5P8MaoI7CDk5nyZZ5xKZe5PUuUoyk9MB6?=
 =?us-ascii?Q?IE/gswyEV+y5aOPm7hF1cSNXNql14Z+5hUl9F7D2OL1NE/i0KkQsveCRGGp6?=
 =?us-ascii?Q?+GU5M9CudKWagTouE1fOPxR9cm73XBq/XdneT0VO9uBixmGHEUQl/uwYnhHo?=
 =?us-ascii?Q?T8ldqKfhEYmsh4s+G3SxS+sAiNqoPaSct7aqALazYIpTSdNs2l9HUhntK97T?=
 =?us-ascii?Q?JPOhin9fLElG8hwZBCVu2Nu0e3gdvmPftyl4qnVxg2fSl02pA+ZqyqiH6KHV?=
 =?us-ascii?Q?gtiPhLK+pHzicsKU2GkZD2PNNtHuCIiLch3lSCFksSJKop3EfIdbxZP5ZbHC?=
 =?us-ascii?Q?ASm+Ab0B5NNIEB2qfm9P6Ud1su77JplMY5UBw+S5nR9/Q2gHMbC7hZSkyzc+?=
 =?us-ascii?Q?b0H9CTDjaABfWgbdaNRHXGmz4oRlQmhD26gNn8FcXDoqhnXNv7z53Of28R0v?=
 =?us-ascii?Q?lUCKldqjFWqxXvFtQmK3J8rcF5ZnaFy/ayvg9CWl57wiV8/Y1bMXzLqKlFY8?=
 =?us-ascii?Q?ut7yP+soSurpK4ZtpY+v3Z0RgpYMWtmH271gWsgbfWRFXvbglP3m06t6ELyj?=
 =?us-ascii?Q?Ru6BiLWVZa5KTH1mnMVJsQM6k2tf6eaid0ITfc2s1X2JVq8aYW0c/JcufZq0?=
 =?us-ascii?Q?TDslUkDGNoJDOFpIWAm70vVd9D7zSKApPfz8YDtrXmuDIIweOCuVgG96C0it?=
 =?us-ascii?Q?kt83OWKKQ0CF6UPY7GwmzSh9XYD54WCJdMD5UgoePuwItmKWvjFL96QitzBG?=
 =?us-ascii?Q?k4jWd2KXKTnN0GlwMObV8OSDoC7GjIrbT7gJQdcm38RnQ49QeNv7fYjNaYAI?=
 =?us-ascii?Q?bxghgATe/nqiVlwoMC4wHeftzykuO6fPqhA2Q/C4DAzH0vKGwvOfvH4wYfTw?=
 =?us-ascii?Q?nUtWv+DHnwy1SEHXJ3ntRhxuEwBn7AooHAulL4ABTzKX2joomSXI5/wvfPjQ?=
 =?us-ascii?Q?TKqA1IKYSCU2uJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EKhhVNTHKWvbT/6tuOQ9KVN1muALkHnBaNp80s8IO6ldFe/W63YmVzgZGhO?=
 =?us-ascii?Q?gQyBau4ZBVmcd6CVl2Cs2ANrXJCV/EwzdrcHZcVV9A04/s1/7FreqtV4cbIJ?=
 =?us-ascii?Q?HVZO9OUTWR6SPwp3vqr3s81HPXcq4MzRbJJxPNab39e02Wfp9LY5ANiL7aqu?=
 =?us-ascii?Q?xU3c+Sn8Z7KD++75EfaDDWWSyCXKGAsTeJQc+S1OlMPwPWWW6/xnU1RcMfaV?=
 =?us-ascii?Q?bxHQyV80Y6BIXdvShwey+V+92vSM0zYHXJCxFw8Jb/eFz+9lCjpcKS63p9Mu?=
 =?us-ascii?Q?OFnyObX25fjY3JL1QkMXtwyzY4nhjB6rCOAZbWO1nP16/01rZizh9IJxlCPk?=
 =?us-ascii?Q?KHC+YRDLTZrCqkIILBUWugYCsn1sB0Yk6DsEVtE8pL+2GtSQ+iy+S8EnH7YZ?=
 =?us-ascii?Q?HpJH1tabh6OXRQSJJMUiuQwHu19vGkYkrG0nILAI5og/JHgn1uQSl1fkXIk8?=
 =?us-ascii?Q?kT08P8KCq20csi6qHj8l1+ZDpr5zBv7jB/Bmt0sJPO26/6XNI6rMfei2sbdn?=
 =?us-ascii?Q?4Ak0uuhStDpGhWnvUARGl3a8QWeFj6ImiGd+oyBboWijXlykMWfzUvlx4nyI?=
 =?us-ascii?Q?mMNz+9J3064GogbGZKZq8D/dcvaBnyZ8z49qu0eo+upe3rdRxCHEWaZQyw7g?=
 =?us-ascii?Q?I6qg0SKI6j72V7V+6hRvJVRfwc+9/SzJp34YmRHES0PA8VwUjacyqw8w8jBt?=
 =?us-ascii?Q?+U6889wX0HN5Rgm6Euy235D5g0YJpjievdv3aG0RMMa5TwLBDgQ4DzAb45Ad?=
 =?us-ascii?Q?vatwVTrzMCrOWrbngLZlpmM7fGCs3+6AzOyItBbi8cDfjBOUr6fwU/QGmmZp?=
 =?us-ascii?Q?eiNG9G04WZFHB0qskN/71g7jMfg8liaZ2u+Ax0uC7p/qRL7AZfQQlll50Yju?=
 =?us-ascii?Q?sqZrOpJ7FeblOwVyy7l03HcQ0JNyDJQATWNfPA5vupQ4Qwyd64n1i/zChzqK?=
 =?us-ascii?Q?2ECoI6xmS/z/InpUF6qcJp+1tQeCTfRRqLvxX99aigR52yL15mUemHV/712o?=
 =?us-ascii?Q?I+w0wUb5TGK4lBENbcnZ4DPaFKZFYzI/aFsy3gys+hu4HuW7tZWj26cByivI?=
 =?us-ascii?Q?9XYYlg4m42CANEo35Gis+aEFeTl1uWj6TSrFl3I9ayAy5HM+WHsbumD01LfE?=
 =?us-ascii?Q?NqGFCbnZyLWaLwiG9lVxk3qJ1ISQIP9UufJSd84HkDahfWjMTuu1EVSCX9ve?=
 =?us-ascii?Q?5VrFW19268KczOsvvao+PIOrxH0i5fueWrJYgIt2ssgg0wKGcz6dQ/2r3d7M?=
 =?us-ascii?Q?iEj974q6CcBMABFjLZ9UCVMPjZ/pHsQaH4EuwNaaveXx1Lezzr8yyTClwBxc?=
 =?us-ascii?Q?Ocd5a7F0Mp79M5ZoL4wVqIoboiqJCpH51ZIlS6jJQseQqRZquPk00FuFJe+k?=
 =?us-ascii?Q?CoKsKwtz5FNL1+wsFMzTbE4YLvNmv75lrQxwijrwxfX7W4Qs6OjJBCoygsst?=
 =?us-ascii?Q?mw2Tixv26+FcAE05ylvkQ49sPxmMdCwNwlQumhij8mwsYfBRKyamUerxs23O?=
 =?us-ascii?Q?SSAbXO/+8BStYcHD9+akDtbiQ59cG6+QixukaZmVUUXyOTU4Bwf6h8zVhcMK?=
 =?us-ascii?Q?T3RWZYDRv1jfPetn24tDIGwp3g/kGO1O+lT3doqU6ctGCoYID7HKyVSyMBu2?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafc7aef-bd87-499e-f76a-08de185d0d18
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:08:26.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l5rT1MCaTwTN/w3T/ya6SM8dKlXsY8yp8LttnhGRuytzddmXR60e5O3d9sOeE+NtAl2jLvbowZ6TdY4fjj2lU6g+IqkAHPPZOE6pVZQjA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add support for disabling runtime power management (PM) in the
Synopsys DesignWare I3C master driver through a new quirk flag,
DW_I3C_DISABLE_RUNTIME_PM_QUIRK. When this quirk is active,
the driver skips all runtime PM operations (e.g. pm_runtime_enable(),
pm_runtime_get(), and pm_runtime_put()), keeping the controller
continuously powered.

This change addresses a reliability issue observed on Altera Agilex5
where the i3c bus enters a hung state when a slave device tries to send
an IBI while the controller is in a suspended state which happens after
the DAA procedures. Once suspended, the controller no longer drives the
SCL line, causing the SDA line to remain low and leaving the I3C bus in
a hung state when a slave device tries to send an IBI. Disabling runtime
PM ensures the controller remains active, allowing IBI transactions to
complete correctly.

A new compatible string, "altr,agilex5-dw-i3c-master", is added to
represent the SoC-specific variant of the DesignWare I3C controller,
which requires runtime PM to remain disabled.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 171 +++++++++++++++++------------
 1 file changed, 103 insertions(+), 68 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..97da2b17b5aa 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -228,6 +228,7 @@
 
 /* List of quirks */
 #define AMD_I3C_OD_PP_TIMING		BIT(1)
+#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
 
 struct dw_i3c_cmd {
 	u32 cmd_lo;
@@ -635,12 +636,14 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = { };
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	ret = master->platform_ops->init(master);
@@ -682,7 +685,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	dw_i3c_master_enable(master);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -798,12 +802,14 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 		writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
 	}
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	if (ccc->rnw)
@@ -811,7 +817,8 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	else
 		ret = dw_i3c_ccc_set(master, ccc);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -824,12 +831,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	u8 last_addr = 0;
 	int ret, pos;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	olddevs = ~(master->free_pos);
@@ -893,7 +902,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	dw_i3c_master_free_xfer(xfer);
 
 rpm_out:
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -929,12 +939,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i3c_nxfers; i++) {
@@ -978,7 +990,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1089,12 +1102,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < i2c_nxfers; i++) {
@@ -1127,7 +1142,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1272,12 +1288,14 @@ static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return ret;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return ret;
+		}
 	}
 
 	dw_i3c_master_enable_sir_signal(master, true);
@@ -1294,7 +1312,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
 	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
 	       master->regs + DEVICE_CTRL);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1305,12 +1324,14 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(master->dev);
-	if (rc < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, rc);
-		return rc;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		rc = pm_runtime_resume_and_get(master->dev);
+		if (rc < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, rc);
+			return rc;
+		}
 	}
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
@@ -1319,7 +1340,8 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 
 	if (rc) {
 		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
-		pm_runtime_put_autosuspend(master->dev);
+		if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+			pm_runtime_put_autosuspend(master->dev);
 	}
 
 	return rc;
@@ -1338,7 +1360,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1573,11 +1596,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	platform_set_drvdata(pdev, master);
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	/* Information regarding the FIFOs/QUEUEs depth */
 	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
 	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
@@ -1592,6 +1610,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
 
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1601,9 +1626,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	return 0;
 
 err_disable_pm:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	}
 
 err_assert_rst:
 	reset_control_assert(master->core_rst);
@@ -1617,9 +1644,11 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
-	pm_runtime_disable(master->dev);
-	pm_runtime_set_suspended(master->dev);
-	pm_runtime_dont_use_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		pm_runtime_disable(master->dev);
+		pm_runtime_set_suspended(master->dev);
+		pm_runtime_dont_use_autosuspend(master->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
 
@@ -1742,12 +1771,14 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	struct dw_i3c_master *master = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev,
-			"<%s> cannot resume i3c bus master, err: %d\n",
-			__func__, ret);
-		return;
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)) {
+		ret = pm_runtime_resume_and_get(master->dev);
+		if (ret < 0) {
+			dev_err(master->dev,
+				"<%s> cannot resume i3c bus master, err: %d\n",
+				__func__, ret);
+			return;
+		}
 	}
 
 	cancel_work_sync(&master->hj_work);
@@ -1756,11 +1787,15 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
 	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
 
-	pm_runtime_put_autosuspend(master->dev);
+	if (!(master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK))
+		pm_runtime_put_autosuspend(master->dev);
 }
 
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "altr,agilex5-dw-i3c-master",
+	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.49.GIT


