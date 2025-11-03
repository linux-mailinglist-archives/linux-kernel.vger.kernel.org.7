Return-Path: <linux-kernel+bounces-882308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF6C2A264
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF11F3A4C80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6DC28EA72;
	Mon,  3 Nov 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjX9XTLv"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4E28D84F;
	Mon,  3 Nov 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150307; cv=fail; b=bFRAb9htMir7d7ftEQWuVtqbNovn1IFxOTTxezuOj+c0MG1k3j9q/4Ze/ySW1zFeQzG1SmO6s+R+lLlEZ+clmgRXo4wiGRz2GogsbWJrpCejBAPc2PA7+KHN/YayXkJNCT3nELmE9iHAvelTZbWvgM4XV+InGnpK4HzuN6H8EXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150307; c=relaxed/simple;
	bh=HDm8Rd9b4quYQFB2DKKqTDFcYxZEjY451ZxzP0HpF6g=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cu4f7t40oYUWlzFJ2A6U1mSRvD+xmshOQP+thjwbf5/A5vL6GaY1dj5ZlNfLqaB+0Ue2FObYi77UQkDBch5kEOOH/I/PV8nvLE72HaPr0GSqtRQNG6GMZLNkOqP2ViQ0YoTxw1A4o2jQOrQBSXXQ2iebV8SRBx15rLzJk7E45Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EjX9XTLv; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdyN3Yhy8hmuRK3qNKnX1v3Xtvo/zcvPzTbaa3pPQmXlP90nH/Ox0BH9MNM0AiqDoDCZBi0+jvHixeJBshRqChCafnzkxuWh90/dmRNRqKH5I5nUIi22UiD0gSHawyuTp/gqMAKzDfBGY1OdWIjHLGyzrFZKxeBioX0lYE3ek7tw6lO8l5viYqIAjGb7YfC0voF5QJlwJlkOG82NkwGvjr+y/ZwA7ageD6VbXv4Ic7DFg/O8WcPDXTeeNs9Zw0W5+UHVvXY7NIFTk3FMa+jjvIL/Mwx55DKb/XwRea5hu4raj3nOcVRahqwOIy6PaWJUOIA3XomFyGFPFzOnSw5vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDm8Rd9b4quYQFB2DKKqTDFcYxZEjY451ZxzP0HpF6g=;
 b=Dxpqw8mOYwc0vPHrCj4ljQPHKRfTKC+ehThH4+4vVpaBdZvU95VAu8S6ke0qYi5aGluhloOFBKYH47ESvNvMO+h2qfj9OjIm94u5wPmUm+kSxBop2gbFd5hgQNTJ6ZuET0/4uRyXi1yuI1DSubF73a00Kx8UaVsxkjSYhbvmJ6Q+1XF7z25D6Z5qlkgsC+l6Py0LBYdA8UtLcGnVUPtaYSRXIELHlcaQDO7UTSnrnHwVcHkpVvc4WozU1Es6/0bZIY+Ps0GvqmnuxGct+2Q3noyiCGjr+L1Xmmt8VKFNV4ujw/Rb7uMEThVg1ZeKhbb5fU6tkAn7sAYCrU9aOGDi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDm8Rd9b4quYQFB2DKKqTDFcYxZEjY451ZxzP0HpF6g=;
 b=EjX9XTLv/IiGb3Qso1aIMqCBU09SLPNMN9hFUwT8S9ZFSJ0xq0Bb3bvRSPacAtRxWOMEdYy5TbkAtSSnvb/pb3rRmxxwVzjS3V5x9Y09mhtuRpIe6fEd343YLk6yloNLDRD7s85+AEPcoUX7uQWFmFR34Cytx1OqSQdwkuSTheE=
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by SA1PR10MB7697.namprd10.prod.outlook.com (2603:10b6:806:38f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 06:11:42 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::80) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 06:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 06:11:41 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 00:11:40 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 00:11:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 00:11:40 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A36BaMF3604758;
	Mon, 3 Nov 2025 00:11:36 -0600
Message-ID: <b8886f01b66a50feb8fda4435f95eba67fbecff6.camel@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, Francesco Dolcini <francesco@dolcini.it>, Wadim Egorov
	<w.egorov@phytec.de>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Daniel Schultz <d.schultz@phytec.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 3 Nov 2025 11:41:48 +0530
In-Reply-To: <ed1317ad-72a2-478d-b931-8f08d8c7e159@ti.com>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
	 <ed1317ad-72a2-478d-b931-8f08d8c7e159@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA1PR10MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 64261b8f-269e-493e-76bb-08de1a9fdb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|34020700016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHNzSk9xRkE3NGdtUHhOWGZHTDg3QndHOUMydzZUU2FLTERLODVvcndOK3JF?=
 =?utf-8?B?b2d5Zk9oM0N3dzJqeUpOUWtESnd2NDloNlUxZXlsTzlBVDY0UTUrdmVLUjVS?=
 =?utf-8?B?dXJBMTY1VXBrajBseWN4bWo2SkxWdi9pRjhpVDl1cER0Z2hrak9sM2FqdHd3?=
 =?utf-8?B?V0hEaHZYTlg1VEZnS0tTY0IyZVVTTjNLWWlqZUk4ZVFtVFJ1dnlzZDQwOXd1?=
 =?utf-8?B?VW16OTJtY3NqZHVEczVCa1NkTzFmSTJudG9nSXpKM0hCLzJ6ME91NXV1ZVJR?=
 =?utf-8?B?Y0JvM3pIUnNZOUxacTBleFliVHJ4WW83dHk0ODBwUFppODJobEdxaW80ZXVu?=
 =?utf-8?B?NURkR3RwUlQvamRNSlhzeVZKVTNwUFd2NlRMMTJUd0MvQTFUeERHVGZVUkEv?=
 =?utf-8?B?UER3SndHUUhrV0ppMzFYWHk0UUVpRnpsRlZZZTdLSGo5NnByQXdGM2g2clJV?=
 =?utf-8?B?UGVTallNWkVKcDhQWEVKam9NUm5GZ0MzLzhUOXhVcGlMaU1xZWU3L1BRWFAr?=
 =?utf-8?B?UzFLaVV4NkdjeHJwWml2aFNPUU81UXQ3Ry92UDVDRk9pK3l2MHByTGt1OElG?=
 =?utf-8?B?Y20zdGxhZC95SzlqdXMvbng4dkk3dXgzdmQxUTVaUU1MQXhCK045NnhiNFpM?=
 =?utf-8?B?Ym5RL1pEYUxuT0tTQ1FONm1pV0NtbUlva2VnUUo1VDhKWUpoTG1PVFFKcHJH?=
 =?utf-8?B?YU9lUHkweS9DSW9yUHY1RmdlaFp2UUFnMW94dTlNQTlOOW93cExiRHAxNjcv?=
 =?utf-8?B?NkF1VUhFQkFIQ1lsK1h2U3RlUi9uNUFxcXhueHgwUDVQSTVDK3BxakFNQm5q?=
 =?utf-8?B?bm54RDBmcXRNV1c3Z29aQWJzME1xK01ucDZMcDd3WXl6dnB4NlJ6REJIZFdH?=
 =?utf-8?B?REZmRzlrWjZHci8wZ0VoVXFKY0E1RU5JVU9OeDIxekV3KzZpbG5FTWxLRW8r?=
 =?utf-8?B?MXRmWjliMnhwRHdUeFVuR2x2Sk9YYitmSkEzdnc5QUFCWFBmT1JINk44NDVP?=
 =?utf-8?B?MENEemlUZXFWVXFqN3lNdGtTZko5YVQ5OCtTU3JQUVh2OVVpNExXT05JZVBr?=
 =?utf-8?B?MUVicjZjOUExQnhKakY1WUNJanZyQW40aXlOQ3MwZi9hdjlQK3NOMjJNaVhY?=
 =?utf-8?B?UE9kN2VmakUraDdFSGpqeC9KQjhzOEJReDU3R3N1SmhHL2MrSERCSVhqT0pn?=
 =?utf-8?B?MjNEakNzakZFSVpPL3dRODRXVzJucFE0MVJsaFZ2czZoMEp1eSs0SW16M0N3?=
 =?utf-8?B?TGR0WW9PZ2lZSTZqSS9uWURYL014ZlhtTHZLWlI0L0NaUHNLRFNROG9acndl?=
 =?utf-8?B?RURnbVBrUG85YUo5bFRST1MrSVc0S1hpTGthdEx0cU9pTFZiQ1VISGtudC9R?=
 =?utf-8?B?VGU0THFiZkVVZlhXcCt4aGRUTVc3OUtxVW45ZzRrZk5uYVRCSWtRVnJHZDVR?=
 =?utf-8?B?SldOYnFsOFZWTFEvQkZtNlVyMXljTXZ4eGd3Q2dySHRqQWVXT0VrTkNoN284?=
 =?utf-8?B?dlUvRk9HUXlZL0R4SWNDNmsyVkZBL1U1MTA3THdrM2VqOERNV05KTjRZQjFj?=
 =?utf-8?B?dGwzWjBCSGdFMUVVWkFXZUI3TUZLR29nY1BNUWhWQzNwdnRjZ3ErR2wvYlhJ?=
 =?utf-8?B?bkZzWENuaXBPNmRnekh6L3o5ODJmR3h0Z3BKVjgzOVJKaDZMdlA3ODZBRjRY?=
 =?utf-8?B?V2NFbUVIMlVSdklrbzU0VlBmOG9ua1M1QXdyaWtaTktRZDRyekRzaXd4VTU0?=
 =?utf-8?B?ZFlkd210U1JJT0c0L2ZvV082S3YrWVRCcVdTaWsvMVBUT0c4SGVaRkswRjc2?=
 =?utf-8?B?NnN3dDR6VnhCT0JNMDJrV1ZUUlM1citNM3V1UHpLMi90SFJzZ0NLTFVXWWE2?=
 =?utf-8?B?d3NQRW1FV0F5OVMrWmdBOGtYeEpadS8ySkhpbEJpUzhBcGVsYmVobHdBWEh6?=
 =?utf-8?B?eDMwc3dVNmFPUEpFWUVoeWZYVGVWVmRaeVdQZ3FWdUYxRWFYTDZrRktLUUZq?=
 =?utf-8?B?VzNSTnlEb2JUdXdvL2dlZkJYWlo2cThzTldrdTZWamlCRkVaaGFRVHpZUU1u?=
 =?utf-8?B?RjFEMUdTT2UvaEM0YUw2MzZERVlkZTV4OVlZM1RnTlAwRHFjVm9ucHNGaHU4?=
 =?utf-8?Q?Mzxg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(34020700016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 06:11:41.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64261b8f-269e-493e-76bb-08de1a9fdb51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7697

On Mon, 2025-11-03 at 09:30 +0530, Vignesh Raghavendra wrote:

Hello Vignesh,

> + Francesco, Wadim, Daniel, Matthias
>=20
> Please test/review
>=20
> Hi Siddharth,
>=20
> On 25/10/25 13:07, Siddharth Vadapalli wrote:
> > The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G =
and
> > CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. Th=
is
> > correction has been implemented/enforced by the updates to:
> > a) Device-Tree binding for CPSW [0]
> > b) Driver for CPSW [1]
> > c) Driver for CPSW MAC Port's GMII [2]
> >=20
> > To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
> > 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
> > 'rgmii-id'.
> >=20
> > [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: up=
date phy-mode in example")
> > [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode=
 for fixed RGMII TX delay")
> > [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII ID=
 setting")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >=20
> > Hello,
> >=20
> > This patch is based on linux-next tagged next-20251024.
>=20
>=20
> What boards have been tested?

The following is the list of boards on which the patch has been tested,
along with the test logs:

1. AM62A7-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/7952f349fa9654fe5ff1cc6bf=
660ad8b
2. AM62P5-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/cf3671be887d57f20ca1c2cb7=
f094650
3. AM642-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/b02f8f4a2e05aba1235a00074=
6690311
4. AM68-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/146b8ba5eaf654f19a3cbdd4d=
d36bb36
5. AM69-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/090f410bb3cb6f0dbd2be5274=
34c60bf
6. J7200-COMMON-PROCESSOR-BOARD:
https://gist.github.com/Siddharth-Vadapalli-at-TI/24bc3c30876e3ed7dc8f53ed8=
d7b7035
7. J721E-COMMON-PROCESSOR-BOARD:
https://gist.github.com/Siddharth-Vadapalli-at-TI/4e026303613a48656b512a84a=
d830253
8. J721S2-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/40b202bf50468bd724a14c5e8=
96f8706
9. J722S-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/fe5523e384ba3e10b3d82c6d7=
43b9665
10. J742S2-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/7d46156a9d3d101153d0efcda=
ccf1a4a
11. J784S4-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/8b9146d66e00f80af661c8cb4=
a90acfa

Regards,
Siddharth.

