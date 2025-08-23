Return-Path: <linux-kernel+bounces-783079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA4B32923
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB7FAA126A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D5238149;
	Sat, 23 Aug 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TdRMCAi8";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TdRMCAi8"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023083.outbound.protection.outlook.com [52.101.72.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826264C83;
	Sat, 23 Aug 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.83
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959331; cv=fail; b=mZ56VM3ojdz2jYHnZLaD28gwOuIQzWzONWaCeSAjMhDZk23/5r2zrJQAEAxkliQSg7viXyt1O/SD1sYPWuo4xgKugBSfyqlHpkruw+aSFxUIytrv2X4sA/9h1FVgR9fHiqACyeCwCTIiHtCHqzE8aCR7Q2U2tYJegXqG/j5ZPfI=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959331; c=relaxed/simple;
	bh=StlgOZxIV/KXBNR8uBhEcsZsVLnVdsTBgFwYk3IP19c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KBqNg/08kSnt704l/MHgYNkbzlNgsHMAt0f0/iFt82muafyqz3tnTLLjuXIRaxajyJPDYpPEaocS6TkNqR0tJG1hsU0+vQIDWtJXTX+EGzs+/ztqfe1LmGvUkQ9Z2H5lo/I3gkioOt/p9l+SyekqPHEEb5CRaZpcKJ2W2BkQO2s=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TdRMCAi8; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TdRMCAi8; arc=fail smtp.client-ip=52.101.72.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ds2lke2me6uG1pgaPGmMmmOB2tPVvv0feoCrrpA4Kh91CVXdpf/J0uYy84guKWj0V47A5ZaGrz/cdA1sFk26Pt8As/uGhfkcin5VvuLNIH7s1tXE2WDSMzHn3scN9ftzibMRcY2hA3DcRZFIMJ67fm1TniGElzKMHbXi8O8rQb5TRqGHJsk+fak3G4epMek+PvcsMK8m5UG8qAt4ojbkg6stF3cdCZjJD7tFslJRNZO53bLVyGKT3ItkSxQHjpfOo38eS2teiRRdJXy85/GM6hmwOAK9Hwo/RWTiVeC2V8KyAOYqPF0RSkRSLRFmnRDgMUk10bx9PpY85hNF0AE9xg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9oeNcNwrioPmIbdCHY0O8cRgD/F6WI8gmczG4mPxl0=;
 b=Kt7WiRp/7vmd2mg33m0Si2dSxTtkPBLDLQLrCMg2I0XThKVlNWTj+Y7+1wlMRKw378+iQ7hqblKvE8UVv3nNGI0qxFh7OFlb1Sovc1F2+8pcI457qP0VrHP+mcEWYILBDiikXviPcBO6hIvu59gyHpfDlJhYW19TLMSgtTOV5deXW+i0lra2p6xjebwL6tltxWlOi8Z1Ekg9oXNAGoB7fQp13phTqrF3GnS+VvA3ITHqODpJ+EarXbtJAwFmNdm+FX7tv4KG7EsTpOqaAR2SuuTdC4c70ViseMLvY7IiGheqdJLA0bdEZV1nhMnXJj5B2e+Zj4TSmYD9VqdkFAnQow==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9oeNcNwrioPmIbdCHY0O8cRgD/F6WI8gmczG4mPxl0=;
 b=TdRMCAi8kmBgLOJH4/PAdMgvmjvImJREpjhYBHJM3cUPdEyiSPAs7ZyHt33P61qoHSEF2kn1QCt9N4Cad+sxU3NyTn9+vw2p9bOUEkFZuA8QA0H3/iuICQLLmXtgwpIXj0SNVet3zXllWaZGphjQGsg9QZBl5Z5/BejCNSTii0o=
Received: from AM7PR03CA0022.eurprd03.prod.outlook.com (2603:10a6:20b:130::32)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Sat, 23 Aug
 2025 14:28:46 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:20b:130:cafe::5e) by AM7PR03CA0022.outlook.office365.com
 (2603:10a6:20b:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 14:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Sat, 23 Aug 2025 14:28:45 +0000
Received: from emails-7425297-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0FF837FEF8;
	Sat, 23 Aug 2025 14:28:45 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755959325; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=d9oeNcNwrioPmIbdCHY0O8cRgD/F6WI8gmczG4mPxl0=;
 b=lxHMb8eWEqh6Khlym65wi+dyyFBG1iUEVftBCMNHw83MSbVqqHCS3C/pYsGQ8+DgTHpJv
 +/359ALNPoGQxPdu4ymCtZvHpjOqlVCJpeCEZ72Whcjfe9YF1bwwyr+QyqF5H0K5LBPShVx
 yDxEP/twYEtjTESS6yJUSPOovZ16vgY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755959325;
 b=LEgUJGCf6nXGjBXD1iG+s0OAte7rdO5/7tr0kdO3bX8tumGVf6PgDHlvLD9MuOpS1Ko3z
 b39kCjk0yqvxiATHm8/O99D1zPpf64wLHNGfC1Xvm6ceUKHxMFAx59fTW2QgP6KggctKDss
 /KlDMWhkb9PMak/Ywv+9mnXfWM6wKSc=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq3rvQvEW2naWKQrwrqS3DYRdg1MJDIGQLfkPeqwK/dWNNa5eAxo/txySZ8kbSYdAl+UUY6pjWeBby9Jo440Vbk36iaRmxsPFCZEtHTTaqU/8hQg01HLx04Bc085Gzc6kRBlAf0GQGr+iaFSHYbNWIWCZetGXRA/d9llfpfl6IdRC6J79PMBVRB3P2DX7sRtYwkD4CSip3kpxxLueTOickfPvC4hyfqTp8K2XI9Ss0q0O3GNeOKZollXFabmy/bDzUPp5d0ErXP0GnrQIJ6OlKH/BySO5wkNn84C4PfoxJsCh9Wu1X3lno5S32EKbr6nLLCkKLKHg0yGu1O3P/CepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9oeNcNwrioPmIbdCHY0O8cRgD/F6WI8gmczG4mPxl0=;
 b=OvVuazeeU0eG70scHuvUCLR5BZ7XvrSGkaEEKLj5iawjxsg6CkVhio4hGyJyBw0ZP+KwuQ4LKNc/o0AXO982tCMaVf+jHmz4QCteu8WGwRV0CEVasLL3bQ9TLkpd7JYZsnW7eAohL+pR7aIY6CsnBM9ns/sEaLR7dP/wX4rsVTU0otIOkwklXbOUHmV5PDxT3mI3EqDosIOTekogGWjsJSWq2FiVMblrMG2bQedD4thy3gsfdTXHkxtbBNvgtlqA40rXlKUJk22105RiTWzqJzjx9nU0qBxeohIRHaUjAAdhgGNKnwcf0EDe5V3HFknCKEd8rLcHeC7IliB/z1r3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9oeNcNwrioPmIbdCHY0O8cRgD/F6WI8gmczG4mPxl0=;
 b=TdRMCAi8kmBgLOJH4/PAdMgvmjvImJREpjhYBHJM3cUPdEyiSPAs7ZyHt33P61qoHSEF2kn1QCt9N4Cad+sxU3NyTn9+vw2p9bOUEkFZuA8QA0H3/iuICQLLmXtgwpIXj0SNVet3zXllWaZGphjQGsg9QZBl5Z5/BejCNSTii0o=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB11146.eurprd04.prod.outlook.com (2603:10a6:800:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 14:28:35 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 14:28:35 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 23 Aug 2025 17:28:21 +0300
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add bindings for SolidRun
 i.MX8MP SoM and boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-imx8mp-sr-som-v3-1-a18a21fbebf0@solid-run.com>
References: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
In-Reply-To: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB11146:EE_|AM3PEPF0000A78D:EE_|AM0PR04MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 958fa8ce-aa5e-4f01-4198-08dde2515e02
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WldtZklaNzB4RnV5Um1LL1o1VEgwbkxmVWJPamVRSWtuVDhQMlUvdlNYNDdS?=
 =?utf-8?B?Vm5Kb0F2L1NmRTRUSW5tdkpJYkRBMTlKbFh3b244VGVFUU9uTTF3N0xKQ1Zz?=
 =?utf-8?B?MFEvSGh1NWkybm5waVFNblF4ZzZSZ3Z5M0l2UVZ4dVh1akFwbld1d0Z0MDZB?=
 =?utf-8?B?YWdFNnlvSWN1VGEySW5NKzNxOVlndnJYVnFuVTBXTzc0NWtBdmUrYlk0UWdO?=
 =?utf-8?B?elNpMHJ2b0tuZXpxYXZZQ05wRGUraHplRm8zMHBVazR1Qk1RblBtbmxhbnFm?=
 =?utf-8?B?QXVjWEdtNDgybmZVNXNkblI2ekYzRVdjbVN1Z042S2RiNmJ1MHZMY3NFVHIr?=
 =?utf-8?B?dmhNOFY2MlNhTHZ5NlY2Y3VKNm5FeHA4RG9wQjVwbDQrakZKRXlCRkZtSmZM?=
 =?utf-8?B?cnpnS3M1ajN0NmFJVVhxQVlLR0Uyc0F4bUdWY2xucDg4QlczUGNwUmRRUk50?=
 =?utf-8?B?ektiVGowNzFNb0xUeG9LYmpmeGg0a09uWmxhNklVb2pHdGpXcU1kYjRlQUxD?=
 =?utf-8?B?TDZrQ0RaK25yalpDR3hHMlJwWEFGZlRxcXltT3RUWlpGTkkzbkhqRENxeXg2?=
 =?utf-8?B?V0Z2clk0cXJySURTUllBMzRBZVBsZ2NQb2QrS3p1SVhWMUN5cG1lSEk3M0F6?=
 =?utf-8?B?bG1pTnZJaDBTSFZ5Nmk3YVhMRGFjVERLbUhFbldRN1NSbnFuZDd5a2s4b1Jj?=
 =?utf-8?B?KzlyZHNzS3ljZmlTVkNYUjUzZEFUVVllTmFQN2JPSTljQXN0czNoS1oxZEU1?=
 =?utf-8?B?cGMwRjM0WDdzekU4Ym9tY1kyd3pxT3BRRVNlakhhWXJyaXowOW1kRzB5Q1VM?=
 =?utf-8?B?UGxmd0N3YnV5N1ZrakdnelFKNEpYK0hVWVlZaTR6azFiM04wMGEyUFd2VW96?=
 =?utf-8?B?K1JvcWlLMHU4bGR6U2U1cThFRGxFUVJaNXBKTHhJMVB4NURob1A1S3RwZ24x?=
 =?utf-8?B?ZWYwMEJmYm5TbWRZSHVDeEhEaHUrRkJ0R1pDemFpMk5jb1FsNG9uenNBN3d6?=
 =?utf-8?B?TnhoVWhzTEpWeEZRUXBsd1dSaGEweThjajhQMFRNcGlZK0hlcXJlN0J3WHJK?=
 =?utf-8?B?TmorNmp6eGFBUVBmM1RyRE9NZFN1Vk9VZjlqdmJNSjRieEs3QXRNM3c4V0lz?=
 =?utf-8?B?OWNSbWVSZ3JDbEtwdm5qWDlkMEJJL3ZYY1E0U0JDL0tyc0pNM0drSnhBNldF?=
 =?utf-8?B?OERkUjlnWjlEV09xVURMenhlUW45WldwQVZqcDlISXF1RTNFdUZXSmhpejh0?=
 =?utf-8?B?TDh1UlBHT3l1YnBPYjEvQXY5c1dqaUprOWFjdExJRVFEYzQ5dU9sTzZVMXBj?=
 =?utf-8?B?dzdyblIvUjgwTDVkaHRUSlQ5UXhpblZzN1NEb0lXaEFSUE13a2dvUUcrTlBh?=
 =?utf-8?B?K1A4N1ZFRzNCdmZYaEozejg0RkM5M0NNRE80UHRCUDk1NXhiNmpaaFYwZzhk?=
 =?utf-8?B?M0ZJODhJc0p6NGJxWXFnclhSdkN0VVBXaXczdlpXZ3hDMTgvTmVmQm42VWJV?=
 =?utf-8?B?b21KVzNnMkdyNWhBcGRiSVZYcUJjN25YS1RoMEQxMzY4bmF6Z1NrMERPMnNj?=
 =?utf-8?B?dXlURDZ2ejFrcUhhTTd1SmVhSi8vK2ZZeXpQSUZrQkdqQnRnTjNjODBIaEhD?=
 =?utf-8?B?Z1F6WGYzSklxcDkzVUhoakpZWGlvSjdMRkduY0k4NDhaM3ZKM2dlSlhPb0Er?=
 =?utf-8?B?TXlUR3RSNTBmc0FKZHBwSDBJNmdFMXkwUmpKNUcrdGVubXEwOGVjc0RNbjZl?=
 =?utf-8?B?N2J3Qy9wWU0rUGFuSmhUT1hQSDJxaFFJU2dEeDNqTFA5WjBBdTlBSytRZ3k2?=
 =?utf-8?B?ODdpTXZhVWFSL25HNERSRmFaVWJ4N21HYVhSZlRVa2w5U0xIK2dFcC9uV3NI?=
 =?utf-8?B?NUZsN2VQc3l6bHJoNDRUOGtFOXMwVWhXMEIvVHJRVEk1V0xMTDRnQXJ5eEEy?=
 =?utf-8?B?SUJHckdtSUNFcmlRS3BuNHVnQ1l2ckhLelR1Z1lXeGd0RXlZSDdCRkxDTkVF?=
 =?utf-8?B?WEJUQ3lJTXVnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11146
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4cfb050e9a424742b81bf547ffda5f5e:solidrun,office365_emails,sent,inline:a9cfcf818f3381afc2c17a6361a4db5e
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	07cc4b27-d2e7-406f-60b9-08dde25157e4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|14060799003|82310400026|35042699022|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzBSV0VSazh2V0gxdlY0YnZ2YVdzNHM1Nk93SU53bHlWcUQ2MmhEZnV4WWc4?=
 =?utf-8?B?Uit6VFhiSzYvUHhDZnYyWmwyYnZFL0Z2YmVmQWVuOXUxR2EzcUlqaVQxMHRG?=
 =?utf-8?B?dERlUmUwSlFJbW83MDRuVmVaL2NZUWViV3Q3SFpOUEk5MjNlaTRJeU9sNllO?=
 =?utf-8?B?YTFrUTV6ZkVMQmJkZVlIYk1iRnRieGNJTlYwUlF3aUg0Z3ZTdlhKcEVFcUEv?=
 =?utf-8?B?a3lKNU5maHBiQ3luMndBUXB4R2lrYjkvWjZheUR0VUZpSEw1SmQwVlNpSlAr?=
 =?utf-8?B?VUdzMmRYVDRNRFNVbTdyQyttMlg1UU5kcG5DWmIwU0E1SDJjT2FETUoxWVVr?=
 =?utf-8?B?czRHMmM0aFBtVkU5UG9kS0hZR1hlVURWcE9Ca082LzVoT3FCb3pJelJpTnZi?=
 =?utf-8?B?L0xTWmF6R0JoRytYNnJ4eWNKY250bnBhQWdtSlprUjN2NHQrS3V6cU0wcGpk?=
 =?utf-8?B?TlhWMkJTWitXNitOdDI1b3hFZ2F4OHJOT2ZCNGR0QUI1SFhaa0t5a2RoOFFo?=
 =?utf-8?B?WVBQdytyN2NnWWw3ZGhwcGxBc25tS1BRM05pTTVkaTVmRDErdDVnSGJzTUNR?=
 =?utf-8?B?ZVIxSGZqalQ4TXB6NGhBUnkyL2xLSDhqOGs3djZPMmhFRFlZbEJJQjR1eVZO?=
 =?utf-8?B?c2lETCt5b2tEVzR0eXBtdk5lSjRlU04rQnRKcFQxWFZobHVqekhraU5UeWFK?=
 =?utf-8?B?c2s2RFd1Z1R2dkVSSlB2UndDVXpHbjQ0c3dmM3ZEb1ZLR2xUUHhpemhIR1dX?=
 =?utf-8?B?Zm5ybnlEK2J4bTkyNDNkaXNFR3ZlekVpK09jeVlkSlF2N2lxc3RLajNTOVB0?=
 =?utf-8?B?SVJjZ2Z6dVN3NHVEb0lwd1pCWXpaUFdwRFlLckVjaUNBQnFYWWJnaytrakF1?=
 =?utf-8?B?RnZBaDJRcnhrUk5ZVkV0YnpSWUIxajBnamRWWU5RNTV0QUkremlUUW9UUFVp?=
 =?utf-8?B?V3lDMVFHbjN1SnZZU0dKSlZjNnhlZmYzd0tuZlpJYUJFM1NiSzNRM1VrVThD?=
 =?utf-8?B?aDRRQjlLZ2M4dmJHZWtFa0Ewb3ZaYXdidzhoVEJhUkFlWnhkQ3d0MExONjNS?=
 =?utf-8?B?TXYzMHA2T1VxMjZkZ0FzSjVKcjN3Zy9oTUV0bTFBb3JCZDJGa3BvVnF4K0hH?=
 =?utf-8?B?QVBWOE5uZnMzc05zYzdkMEcxMHExVFM1ZU9JSlRXdnRneUJXajVLN012QUNP?=
 =?utf-8?B?MXdqUlZleUlKU25KL3V0R0xjV1FaZitSSlFwWnVuUDFpNGhJKzNBZG5vTmdW?=
 =?utf-8?B?c3VPU3FkMmp5ZkxJSi9RTjVSQTg4MlRSalg4bFEwQUtFV2VmUmNJZ2RjeVV5?=
 =?utf-8?B?TEhtOEVLYnArRmdiUEJxWFp5Yy9hc2hnczJSbHg1TDlLTWtITit4VTh5M0p3?=
 =?utf-8?B?b2VOeDdJSlRHTkp1ZVRvWXU0eFJkRzlyNytRSW1YOGVrYnJBQVFBZmRiYjVs?=
 =?utf-8?B?RnoyU1VwNUgzaFEvTzJ1QzR5aVdMZ0tpR0ZUYWlTYVNxL3pibGN5a20zd2l6?=
 =?utf-8?B?MWhPeGl4K28rcC9kNXVicTd2SU1zSXBUREFmdmlFdFY4M3NRbm12T3pQSldk?=
 =?utf-8?B?ZFlKa25MejBkTWRyczRSWklvWU0yZ1dKZXdrR1pDR01vaFcxOHZROEp0QjNv?=
 =?utf-8?B?aTdxRnhtNGVHb3NJMFlaaDhaMDRxWWU3Z3JsYzdZZTkraFp3WnJlNEdkQXg4?=
 =?utf-8?B?UkErWVI2clJ3eHRUVXU2djJla2hXQWRJYlA4ZmlndzV0WHJmR282aWp0VUhs?=
 =?utf-8?B?cTh0M2xEVStPRmMzSnpraUpoSHBtUjJHN1ZNczgwbkJIdmVFOURyY3R4eSto?=
 =?utf-8?B?QVRaMC83c2ZsVUJSTWdhRHBTVHlVeXN1WEJyaDgvMFoyUzQ0YVNZckNhQkoy?=
 =?utf-8?B?TjJkdEhQS3N6UkViMmpOQ3B0Q2tJbzczUTNBWmxjVHdGZXFYblR0dFJneFBH?=
 =?utf-8?B?eWR3ak0zUjd1T3g3QjZtZTdRN0xqd1dDQVlENTVoVW00djJqMU10dkI4d0xt?=
 =?utf-8?B?T3VDNHhSSFM0SzFrZHByRmFxbVJtV3dkQnd5aHdHRmRyd2RwVXdkVWkvdTdO?=
 =?utf-8?Q?eV2okh?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(14060799003)(82310400026)(35042699022)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:28:45.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958fa8ce-aa5e-4f01-4198-08dde2515e02
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769

Add bindings for SolidRun i.MX8M Plus System on Module based boards:

- CuBox-M is a complete produc with enclosure including the SoM
- HummingBoard Mate/Pro/Pulse/Ripple are evaluation boards with common
  design but different available interfaces.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3e9f9e0735a8808721ebba713f14818ee49172a..e03d1ee982cea851c7f8d70e8ed7b6564c8daef6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1200,6 +1200,17 @@ properties:
           - const: polyhex,imx8mp-debix-som-a       # Polyhex Debix SOM A
           - const: fsl,imx8mp
 
+      - description: SolidRun i.MX8MP SoM based boards
+        items:
+          - enum:
+              - solidrun,imx8mp-cubox-m             # SolidRun i.MX8MP SoM on CuBox-M
+              - solidrun,imx8mp-hummingboard-mate   # SolidRun i.MX8MP SoM on HummingBoard Mate
+              - solidrun,imx8mp-hummingboard-pro    # SolidRun i.MX8MP SoM on HummingBoard Pro
+              - solidrun,imx8mp-hummingboard-pulse  # SolidRun i.MX8MP SoM on HummingBoard Pulse
+              - solidrun,imx8mp-hummingboard-ripple # SolidRun i.MX8MP SoM on HummingBoard Ripple
+          - const: solidrun,imx8mp-sr-som
+          - const: fsl,imx8mp
+
       - description: Toradex Boards with SMARC iMX8M Plus Modules
         items:
           - const: toradex,smarc-imx8mp-dev # Toradex SMARC iMX8M Plus on Toradex SMARC Development Board

-- 
2.43.0


