Return-Path: <linux-kernel+bounces-836070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9BBA8AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF97B52BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF94286438;
	Mon, 29 Sep 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="um0V/pVK"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277821FF36
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138476; cv=fail; b=VhfcC9kOS9pqlcqMz0Y9GBtHMxsyMDdrEETRIkcFyYbVdllPFJftErErlYsLTua/aicJ1+avCvtN/I8Ux+YI0Yi+LtzOGSUdjdhE33fYxg/KhDRWQnmVFBvc3w5mlxGd0Rz0x2QfksdBE2AFhU8VyV0jPniJrOrMwnFSnoadwyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138476; c=relaxed/simple;
	bh=YCFcJefS11oATcqcr3MMJebvvG6IuofSa324P+w6DkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZkJUFYmVWXf0GxuyGFaGTmEZ+nRPlzZbx09zskQ6ViYwsnAgyzlG3H0q9dMs7qO4Jdml3BvlZKt5tfl2mmQsHXFcAqtM49Ph2NzX/dr+lYhfmBw9TVM7p7iyiF/V6ZRAs+7TSMFbzJRbX/z7cRrn+4x6IazY12AF0fbT5IARl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=um0V/pVK; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa3/4fNa8c2IWUG1ze6Ty0uC6ijoUkhREDdVRPZl0lZZ5p+Wtg+jUAb1vWfC14Tixg4ys+ldTdxvOhWmDLcXxateeQhI1LfdVPycgtRF0y/KX1MXtOkkQPAzTHZbdDH6iI/360AV5xhbX2GPVTSAX4JRpU9tqCCyOtkBhBEMPQha9mtJ5INh7J74BtYQmBV+3dd9s9o77LQZcL0NWCrtY9m7kZkVtFzlDuy8iGJyyMooFxoQozQkwWk698BqJycdaNG/0WEngQUx4K/IaBOv25DfhUDg/v60MCUyR/+p/jt01ZWvbCpppyalGkgMp6TRgB/pg+I9kSfMTAMT0roTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCFcJefS11oATcqcr3MMJebvvG6IuofSa324P+w6DkI=;
 b=NDDr4zTa+brisDSzt98i9PQ9Sxn9GIhmEn8HcDMrVquCAME5Lz2+He3Q8ekJHoDGy2hPMhuZwAIevSpLYsh+ASObgTMar6F9sgrRIOZUWFPM6Xi721avxqEXLf1yukIGzoqu5jrh3aESYPzw1nJx0Gxrpw0W0skPTIUX4h0+yj46/WdeQq6IA3woIvmVIKShX6CY8svI/kprOBwBRvWztroTx7KmAY8wD+uVT5eVxOkAvWSfVbuLoFU6umzFOqLve4jfMinxqT7pHtNsjYWc3TDTfmEzR9z7ixBbW1gp+1/pFJwFl3E82vGmJ9umYyRY2ongvTEhPqeEAyY8v2aYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCFcJefS11oATcqcr3MMJebvvG6IuofSa324P+w6DkI=;
 b=um0V/pVKANCG1OERWoTyYsJPZTLNb8UGHbQtJhUU0UQTgXvFgpPES+/lmAo1EtWBz+U1yr1yzVE2isHTos4xtFdJb22hYGSzkOxRXmwXeeBAL434DJ6oipskr7QGrY/zLPwLtQHL8/+FlQm/NhMMUA8brckrYUhY7jck3x9JnTMb4VXB/7hB1J5J7LLNTPmEbee9kbc+MnH7Ej2+61Kdxb43CPJWSIrMh5ov0UaItwzmzDCYjucB6K6JWBMoewZmukIyWG2aphsJkCjlFe5gH6NifUgXedHyAx1pZLUzYDCc2TOPTvx/SjcgKL6N5eptRmNQ3x0R+fqpbjziITFiqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7093.eurprd04.prod.outlook.com (2603:10a6:20b:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 09:34:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:34:30 +0000
Date: Mon, 29 Sep 2025 18:46:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Harini T <harini.t@amd.com>
Cc: jassisinghbrar@gmail.com, michal.simek@amd.com, peng.fan@nxp.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH V2 1/4] mailbox: zynqmp-ipi: Remove redundant
 mbox_controller_unregister() call
Message-ID: <20250929104622.GA15568@nxa18884-linux.ap.freescale.net>
References: <20250929073723.139130-1-harini.t@amd.com>
 <20250929073723.139130-2-harini.t@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929073723.139130-2-harini.t@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5c490b-25db-412e-3e75-08ddff3b63c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXw1sVWAKiALrniAwVz3TWZ8N0bckCU3oJASIJAOf87etfqC4l3zv3GZ3yV4?=
 =?us-ascii?Q?C+QWKqlhDwktSaC22Uy0PfIfd3DI2nJYmwCePp6Z/TzMmZUbaLWSW2gUz+VF?=
 =?us-ascii?Q?zMwBYgty5kcUCK+OJ5q0hlh6PzGa/aQ2qg6+nN7lsGI/b4MObVNErbYvEZfT?=
 =?us-ascii?Q?EvYh6OuzvqqWZPDpngO+ulTdIYjosUBT3mMJh3P6o47/sIzW7VWgAdn0qM61?=
 =?us-ascii?Q?2ctQsmcyfaCD7BTegwPddV8BSHSIZqxyA41c7qYhg9n1Vm4439gWtZoZAJNJ?=
 =?us-ascii?Q?dDSgjk5k14HdquQWaqBSsAHnUIhN2kKoaNK6E6OOEi1i88IMdKrvVDn43m7s?=
 =?us-ascii?Q?YzTT66S3gIgouWaVxiskFMk24pZQ613Uv0M+1T0hdHDjk0eGtovpxK7AtsGq?=
 =?us-ascii?Q?ImKFITNPdcYAPLd3Snjrh17SCxGn//2MmEaUfzR1sIph3bJdt8/lrobwozCd?=
 =?us-ascii?Q?HomVT07ehJeVzVbYKJDorQNfGxBHnsqbCNc0y2KPGY2zYXf0fV/UmnWVpGDI?=
 =?us-ascii?Q?4Tnmy2KfxsVLbvGhlRZ+bxBjOMs6lh6q0vNIuyS8Yr8lfexgSddxDXaEslkZ?=
 =?us-ascii?Q?F09uOdk3sSOL/o0Mih0ExhRNY5PzRp+R/frk/SmsQcZwJsqZfUUW+Q3S5nY5?=
 =?us-ascii?Q?TZu0yl8SFQ/5axPQh1iNBaD/Cv/3XdTLWHVd5xSryG+00CavxoLCTBOfs8If?=
 =?us-ascii?Q?pfT3yqIyggn2CkqLUfnToMFUdPws4IKlz8Z9JXYCKNiVp0rH4st9UwFfeQuH?=
 =?us-ascii?Q?3YW/NLhOUi6epZnkicb5uP5sbXbk6bjImyfKO5y/TfHewgpzTM4CpuqmmU8p?=
 =?us-ascii?Q?AV/kLrYnc1+nNPetGR9EFHdwaYjgaCFEBavkBMAB9UUk8KDWBfXgmNGMiaQY?=
 =?us-ascii?Q?fYdBGnDtqdN7hAbmb51XhNLdLyBTfWdTuM+/5se4sKccb847tlPnFM8/glge?=
 =?us-ascii?Q?0JplTmZld+bmaqh8Lebd6C9SIMPs8OpQmITWojPnooKBrE5d86jjLQLWRt9X?=
 =?us-ascii?Q?ajOSPQENGHrytFYODMDf2DF5WSllr/Lm2az0na4Q79BeWDyN2V9wu/EB+8Jk?=
 =?us-ascii?Q?63hq8ImcQVef/mWzuzzkcL4oHI9Nx+FsBhcg52A1q2uaRex1+Blk5026iFYM?=
 =?us-ascii?Q?UTcz0EIIwtKW162HpofNVZ8zXtnoNdwjY0gLfdWt7jKYs+EN4c4S859FjSv7?=
 =?us-ascii?Q?wUhK4lNDiG/VJij+I/JzDSDj5TOSLXSeGcpmHsTSW5JAdkBXt5mOXYxnnAMk?=
 =?us-ascii?Q?7XE5k64OHpG25GHd+p4zD5eAKOAuy5B9t1pR3llIbbPcncHq+FmfxHNdX4Az?=
 =?us-ascii?Q?SFh7p9QKLJ5INFn5RjIn3sYRm9HrR6Ka2j35qjvh1dl6gjaXil3WHer26bqw?=
 =?us-ascii?Q?SHa+B5v/C6LuKSLk5XwzHInzWg+d3HDrMN1M6JmO1ukhMPAqB+qOYDz/0yC6?=
 =?us-ascii?Q?2k7wx5X0qFvxPkPk1V+eALg5Vlsz7LJmJMRoK86b/oFhPQH6heDtyqHlOWQs?=
 =?us-ascii?Q?oqA23r2ghZKqb6tLks3iV5uROjwReYwuVgul?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEGZlUlrG4G6FhoQBtAsoEJLmvC+vZxymJxFCQIZJc5B0A6suvETyIrQ7EXf?=
 =?us-ascii?Q?dS2aGfjQ8SDymujXd2I6Zm7gz13h8henmBP0G3jf8B7qt0CvYggiNh9KVyDH?=
 =?us-ascii?Q?6ura8eym64qgxYqu6jXFyyfjbYwkwF/fn952OejQbaXIuRs/1UsN3/ENxsPR?=
 =?us-ascii?Q?wHUXqEY62tUatgH2ZOde/bXa0ntq57KB17VVGp03BegQy1CFa5ENUB+83HVA?=
 =?us-ascii?Q?Is7hvyeXPCAUMWE+bbEHT8u4NDiNVEEv6veOgo3lMgBaD6MX17AQK7fLuFAq?=
 =?us-ascii?Q?0F7OtFmnYddjKt6u4vrwUKj7n7NiTWclPrW6BvBG9BCd7dcDwyFHHOPiM9yV?=
 =?us-ascii?Q?G0iQSi2TMJb4RNArb2v5oy4hKHVCL9JSXk+to5ud851QFNtPujLN3/1s+s+D?=
 =?us-ascii?Q?gn94fhQbDmLiSuM7kEzw+E0KqBev4OPdrvdLJ6vF78IDKg50vvfGpQ8CMyf8?=
 =?us-ascii?Q?2cSD2MSoZvEltNqZRvVhmBHpM77Yd1x1B5rTkOFsJryEtYjFikzvmcMxW2A7?=
 =?us-ascii?Q?DrlSGAiV68uVmL42FW+hrpjwqc2c0syPyW8uly21hx0b0iuVvSKmsWT41sEp?=
 =?us-ascii?Q?eGmQwajBMMnklMTBP68KaOp7/QUC3ruws5dJt+UVHdo7iHP/GxXJx8u3i78q?=
 =?us-ascii?Q?NK7q55NxdCBvINK8Yo1napwNSHRUMu55YODAblmdhzXYL105AEA0AAS88D62?=
 =?us-ascii?Q?Ypec3havEupF78igl7muBvKH9DxSkXIIQwQ9JGSHFTIN4Z0B3tjk1hFTc+0f?=
 =?us-ascii?Q?XRwZz9JcG2S5yI2Y4OOqZLpnTw18soZi7IMy64UB/JhwrBop5cOVe5WLQPCz?=
 =?us-ascii?Q?Pt3RB5N39PZ/BYrpcR8GLngE1pgTYIt6DLEpaTfAaYtVqdhfKmcqZgfwm77l?=
 =?us-ascii?Q?KBtI441+OGNveLXPrPFs84PaMNRB22o/PRCGS61IJyMcN8eDXGYglFcFSjjv?=
 =?us-ascii?Q?BM9TNOJs0jl8tkcurI5Nb5vg8uoZom8LOH2jgAsn0QzzrC8GJLtg2o+pEkXk?=
 =?us-ascii?Q?PfC+HctlvKF8qfepr688xtz0f3wAkX+Qd6wvIX3QJlflJl7gp1f8T2EU24Tv?=
 =?us-ascii?Q?iGTPHVYNNdx/3afE3sfbQ5vm9BC3H+Ltd7b5XbNX/J6cQaTUVBlXUuuj/cnK?=
 =?us-ascii?Q?okE8wHxvFSTZhu5VVaumzBV19N8j32Q8isqlAx4NMNkscqOtXjop1E+K4ZRw?=
 =?us-ascii?Q?/rVY2unkDUjlUf+8AncNMzO6MmQg0mQerXW6zRV96bM/XQ9oxsvZqkcBZMCb?=
 =?us-ascii?Q?iF1BPGjIxGLmLR/ZTbzaAc1DLd2/U8C3l4IwgytxO7es6wybiJQDsHydfV8c?=
 =?us-ascii?Q?yvZG1H9aPOLMIsTM9gPqcPBIzGJwwUSaJ5MlFoI7aGY/LyTsLL9XQUUfcYnG?=
 =?us-ascii?Q?y/0EtcWXF9SqlQQCQkpBQ1yod/xIZJ3sxy6tL1H9i/2GRwxiQajF8zluO4P4?=
 =?us-ascii?Q?g6gIkp0yY9TwBP7ygscHbYGbkNyrM/cqeLXNAH22LEKAGh7gZNZ39j/KkIeN?=
 =?us-ascii?Q?em5T7l/wGqHRFGrXWAsu96n//h2EZoWPUYL1Cg8HPGuCO1kSSaLcqTnpGjiL?=
 =?us-ascii?Q?YOanVQkzBgutHWfdD+yFk4HW9KPBBBkMIRiE55Qa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5c490b-25db-412e-3e75-08ddff3b63c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:34:30.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibafK2VhotJ1mQGuTV0nnqBpXP2boKd8j2jCKHSPk0E3r6/HQPibQFW8Lg+E8qZ0QfUpc6+jiDx2KAXmsyQQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093

On Mon, Sep 29, 2025 at 01:07:20PM +0530, Harini T wrote:
>The controller is registered using the device-managed function
>'devm_mbox_controller_register()'. As documented in mailbox.c, this
>ensures the devres framework automatically calls
>mbox_controller_unregister() when device_unregister() is invoked, making
>the explicit call unnecessary.
>
>Remove redundant mbox_controller_unregister() call as
>device_unregister() handles controller cleanup.
>
>Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>Signed-off-by: Harini T <harini.t@amd.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

