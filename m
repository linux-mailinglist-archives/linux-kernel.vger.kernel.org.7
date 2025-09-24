Return-Path: <linux-kernel+bounces-830455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15901B99B42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8824C3721
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80CE2FF16E;
	Wed, 24 Sep 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="i/DeW8Dl"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023094.outbound.protection.outlook.com [52.101.83.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D42FF673;
	Wed, 24 Sep 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715162; cv=fail; b=T/tCn/gTz6yzofHwCXWLyIILdqt2q7NzL4emRBGikj/8niNI9hKcLZ93NPE3pC0PaJprUtG7iuw2e5iMtrtBGMAurfMAjeOMkst8dQ+ZnGxuPZ47eYyHG8idXH5oKpMLNjJ2XVeQQwVdVCn3lVFWKjzd9/kX9ltH7Mik9COt9dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715162; c=relaxed/simple;
	bh=+WRrFnvoysEhGcWArOmddGjUlIOzCXsEWrWNYT+nuik=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LYOLnFCH8rGsYDz8tduKnEXqVZf/S95Mp2Pp5TyVL8YssmgrEMjfmPlNRD92E5sDr4wuU/aQGmKo4nVExTSymdVNj9cI/M/eKRyeL6rf3n/uDCWi91/WQbs7EmgvMHOHV1ZJUx8ylI7G9J91PZm3hNwrqHaIZ4bXuyy1WX2lcTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=i/DeW8Dl; arc=fail smtp.client-ip=52.101.83.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukpcWUBIsJtnKN/SBl8P8iOSzmkA1YeMOIMLYguRjSoE0eFTlMlBDo+uBRXACrp+/o4WdeYNW7amslzKiq6K7a46LILCGnzj8gNKA6loWuSC8qIyD5fPYuINW5ZRwEVHzDWRcyno2V81lJ/gk6eV1B1O5e2XsfKbbJZvqw6Aw1yjABrFB1y3+e0lk1fMOUrhQJAWNwoI20P+WtWAXjLdMU7fPGUImjxeFampOf8Xj96zTNvM+c8hO183+mOjZUF2kH7udZtuhjOljbJNum7sNFeiWPoX4JpKOXgr9MjoRlqPemIejo1yHx6bFxM5CdXuQJkpw97npzNFIqtCI5WzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFHY3vLscXivUh0Okm41iNYooSIqCVdxvCZqiHH1xpw=;
 b=H8V424oYCSnwAWbU/Be73LG0uaWymaqltBGznTN8LUmBvuUp1yYKGcpiRSCeXvZokNgyrfaC7qYitJ/h2Gvwx9HY8THwLxusSHISurilrDkX0JiUokPyRW1q54n1yNo+zaY+UPV4yituIsBEiJPkq3RtPqKx2Ixbobyd1sEwiM1eopVOE1BQQhgF6D/S/bWuZqcUNEBzYEyRk/B056Uv1xnmUL4reEmgM3X5n1ya8xi/ffeqjwTCPlEAl2Slg4zqv8ETI5mod7PgJBfIMnYwR/qPzF4MVR/pOPdxA8dEJwCffP4uGRWgx/0IixYyriWkuoFTPxGKKaRkn57ci9p0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFHY3vLscXivUh0Okm41iNYooSIqCVdxvCZqiHH1xpw=;
 b=i/DeW8Dlf5VYyPz6XQTZCwsxvAJ/6BYDBlne0a/D4eEqgTeMhnOKEBX7e/Bwh5nK1ll9sADlkKOGim5NX3BNH3Fh/7gGGr1Myw6+sOypGhZJu7PChHfq0vBlbnbz1Igi6FI5uBQs1auVUtP6jeykGaNhwbSBpZM9ALTccY515SjX+OXymqDM2pYLpFx1KnSkqWegkNY8plvdU2AF1QoNuxIaRskHB4nVwi5UxdG0xQHWH5H7j4IwDfDoecwbZkES08+gyFdKL7R5aM+QVici9rLfOVlIbZJhBt94uu3DFD31q6nK/rCS5I37HTIHZSOQVsAWK1uOslPkpdzDmbieFA==
Received: from DB7PR03CA0099.eurprd03.prod.outlook.com (2603:10a6:10:72::40)
 by VI2P195MB2547.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:21e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 11:59:10 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::3e) by DB7PR03CA0099.outlook.office365.com
 (2603:10a6:10:72::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 11:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 11:59:10 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 13:59:09 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/3] Add display overlays for imx8mp-phyboard-pollux
Date: Wed, 24 Sep 2025 13:59:03 +0200
Message-ID: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfd02gC/4WNQQ6CMBBFr0Jm7ZhCaC2uvIdhAXSQSYA2LTYQw
 t2txL2rn/cX7+0QyDMFuGc7eIoc2M4JiksG3dDML0I2iaEQhRSV0MjTqieHzo7je0XDwY3Nhja
 STxuwLZtWl5VSnVKQJM5Tz+sZeNaJBw6L9dvZi/n3/alz+U8dcxQoKym0kTfdi/7hhm2h7moI6
 uM4PtyNMu/MAAAA
X-Change-ID: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|VI2P195MB2547:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b3a46d-9c48-4d4f-2e93-08ddfb61c5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXNpYkZtUW9SQUVVWFluaHg2aDlXbGRWb1h5Z2Q4NWZPTFFJbGxORHh2ZXlG?=
 =?utf-8?B?WnVWSnVDTzVoZmxmak1qK1lqODRwSHlCQUYxanNKWU0veHk2c2pwTkZmZnk0?=
 =?utf-8?B?dThhaDF2UDQrODVjcjR4NU9xb1Q5WjJRMDlpSmcwdzZTZTI1dWJ1dmdnVENB?=
 =?utf-8?B?L0JmREZMNkdady85TjNnOUJUeUFUWU1oOVJJZXpwbDVObHV4YkVRRUFMRmVa?=
 =?utf-8?B?VTFWRkQ4Z3BSMFh2dThDYUNtMzlNaTBYdThpdWFobS9BZjNQd1JDeWpydDJD?=
 =?utf-8?B?RXZGbkdGM0VLZVBrZVJjTSs2NDdmTitsUStidVFKeVpMaVFsdzlNZmlLOVUv?=
 =?utf-8?B?WTFnMHNYbWxuT09ITEFtVzdDdzZCaUJYSm5HMDBsbUswNjBMWERrVjdGdllQ?=
 =?utf-8?B?WG1IOTdtYXdwZ1hWdDZNNjg3dXRvaTYybmVLelUyTXNPcGpPMVlWQkNxVU44?=
 =?utf-8?B?K1hiR1BnQnB5MWxnOG5NS2VSK245QU5zZEVhWjVGa2FvK2FVdmJGaHVtckZV?=
 =?utf-8?B?WVFTMFRjYzJnMjVxaWpORkV4eE1tOGVKWlpEaHBZbVJJUGZYVks4a2VVdEJh?=
 =?utf-8?B?U29DUXFucDVUNXZPWUgxQktEWFNzNUlvTXFFMk80SHV3UDV4WW0rYVNqa2Fy?=
 =?utf-8?B?djc0eEphTjBuSytnWkw4M2FSNUxmR3BFSGxPUE9WOTJQZFdOMStpQkNjWk9t?=
 =?utf-8?B?TVhMUlM3OVZsMGFuSWJHdkE5M083QlpBV0Fkb0M3QmpOTnlpSVF2SURyWlF2?=
 =?utf-8?B?SXVmWDFBeklnTDNVcVlNdUdrOWZBZTF3K1hyRHFCTkljUitKQndqVDJ5aThk?=
 =?utf-8?B?TmpqVzBiZWYwZUlJMkx6cVljV3VpSWVraDkvamNXZzliYkw3b1hxOUhGN05u?=
 =?utf-8?B?c1VSYm12b3IwZDNRZytiaXJwa2RPN2pJVVQ1SUlhSzA5TXpBaGpid3UzcUJO?=
 =?utf-8?B?N2k2V3JnQldPTkhBdDBFNUlFbHNVRzFvNDRPMzhEdjhIcXJodzNNQi9BWTB0?=
 =?utf-8?B?M3BxM1k3S05aWVBGUGVQK0w5bTYxS3NkOFRVNmhzMWt2VHBmZmE4UmlXWC95?=
 =?utf-8?B?MEp2cjdMSE9BUURuL0hUbnRubVNsS2ZhV1BoZnVLY05sczJVdThZMjRiblNM?=
 =?utf-8?B?ZTRLNDFWaDVZVXZkQTFSQXZ5a1VEaCt4K3dGL0tiZTFVN1pueC9pQ1JLWjNa?=
 =?utf-8?B?KzRVcGlaSWhyYUdjeEg4QVpiWWJDMXdKZy9henQ1Q0REc1F4SUtxMWNHWWVv?=
 =?utf-8?B?bGZBdldPemttc0tkdU1aSzdwRjBVNmtlVzRWSUhZZVlYanhmeWtpeHROL09m?=
 =?utf-8?B?MURyTXZuMVUvaWRlTUJER2xGci9tdzkrdXBnRmh5YXI0RUxQOHRNVjd2aGMx?=
 =?utf-8?B?eEdPSUlZeis2UHpudkRIdXljT3JUVVZ0QWZBeVBIK3JHNVJaWmxqbzJ2ZWdh?=
 =?utf-8?B?U3BCNnE5V2JKR3RmR3FJSVJxcFJhQzdDMDcvcUxudXd4Rk42Rml6YUpaRG9G?=
 =?utf-8?B?c1ppSmppbERFSXFha3o0M2dkcWdkL1YxMUNYY2ttT2QvWUFCWlltaFdmVFhZ?=
 =?utf-8?B?Zy82bEQyeGN0WjBhNlVTZElnZEhhakRSaktLTXptSFd3U3M0bVNRRWxZNzNX?=
 =?utf-8?B?cGEvZWkyU25rSXltTUF6K0VYNjlVTU1FeHIzQkl1VUgrQndBZ1ZvT2hwOG01?=
 =?utf-8?B?Uk5YLzVxSEhFam1FbHBEMXlSdm9UR2N6eWpWczY1WHBmTnFwaU1tZG5LRlFy?=
 =?utf-8?B?K1p6VmlEbXFSUGh3N1BJcVhDTFkvYXJrSWpyUnJVSXJIMU5mc2lTTGJZUWxD?=
 =?utf-8?B?QjN0TURhbHNNOHNKN2xtSnNDdDU0TmhPOXdoVTV1UHcweUJoV3dIMG83MURE?=
 =?utf-8?B?STV5RStKd29ISlhyY2Q1UGdxdjY1cEpMRFJTRnJrL3cwWXpreWdudTlYUVlT?=
 =?utf-8?B?cGJkV1U4TzI0UlJ4eTB6a2tnTGFLTDJ1S3QyYUNjSlkwTHUxNWNTVkIrQzhp?=
 =?utf-8?B?UG0zTWtHTENBPT0=?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:59:10.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b3a46d-9c48-4d4f-2e93-08ddfb61c5c4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB2547

The phyBOARD-Pollux has an LVDS + backlight connector where one LVDS
channel is routed through.
Also, an expansion board (PEB-AV-10) may be connected to the baseboard
where the other LVDS channel (of the imx8mp SoC LVDS display bridge) is
routed to and there, too, an LVDS display may be connected.
However, both LVDS channels must not be used simultaneously as this is
not supported.
Currently, 2 displays are supported. Both are 10" touch displays, where the
edt is deprecated and kept for backward compatibility reasons. The powertip
panel is the successor to the edt panel and the current panel of choice.
The expansion board (PEB-AV-10) also has a 3.5 mm audio jack and thus
the expansion board may also be used for audio purposes without
displays.

---
Changes in v2:
- Change license identifier of pollux and peb-av overlays.
- Link to v1: https://lore.kernel.org/r/20250915-imx8mp-pollux-display-overlays-v1-0-59508d578f0f@phytec.de

---
Yannic Moog (3):
      arm64: dts: imx8mp pollux: add display overlays
      arm64: dts: imx8mp pollux: add expansion board overlay
      arm64: dts: imx8mp pollux: add displays for expansion board

 arch/arm64/boot/dts/freescale/Makefile             |  15 ++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      |  44 +++++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso |  45 +++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso |  45 +++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 198 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       |  45 +++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  53 ++----
 8 files changed, 413 insertions(+), 41 deletions(-)
---
base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
change-id: 20250908-imx8mp-pollux-display-overlays-b4ab84966c66

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>


