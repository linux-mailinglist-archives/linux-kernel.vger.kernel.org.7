Return-Path: <linux-kernel+bounces-877058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736AC1D19E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA5564BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AC363BA2;
	Wed, 29 Oct 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HlyaDy5g"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C4363B98;
	Wed, 29 Oct 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767731; cv=fail; b=RTionxsblKg2dJTeZnvBFWBXQVs2dA2Zt6tPD2DAkkymrWzF6GWQgo+QoL0TdCbWUPg1kcnfH4ibxSKRKN3mOv2EAqrFddAjc6CZVkBz7fRgA+ToKAYLYqr6IOpzHFQAy12b7mqaKbBcGpc4P4skH6pBLKnPhyUQYxk4q/dQDRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767731; c=relaxed/simple;
	bh=0XMRh7/QkfAohnPvAH7rF4tr523m1txX9VkK3UNViD0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jNNNFk8F0nj4/cKs/IBmBvQk0/TQazZh5PG1mV5OFHs4aASYUuDoOrHMD1LL2beeFA4RL8woskR3F9mEmjcqxzffW0X97endDAWMUbOYnjoyeCVQppqlmEsL18SSDWkwY6w8QFjaJBEdjiyDnVZQWUEqV3skgtXsNnnJ+TlXVPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HlyaDy5g; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbem8BM4AOJyFEB6sq7wEQqZji5ECRASUTDnFkY5HSZRFJlBVnfvltaZKXPRb/O73wsNtZPbkNrUMHDiVDhdCgKxa5OKzCCFU6wd4EJwMqWn5G762THoix+Nx0WbwuEH5EWriJCXD5t09H8ZQFUs4HCe+wIIHfQB+cBbeM02Roud+wcpeXebWHEmsQDlyMiaPJrTeyhZz5g38X8IFh0LM5DPnFIj5m0EebDKxEIl950mabJIhc0UmaaftaABxdahaEfw7GiptyabXtCMQkLECt/1mxF8x7HVbHY0Qo/282llLyVqXkqOa0oTrKWY42z5jHEEG+fJAEqEmWA7MDwb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3nRmlN5bmsFKPUvYCJEd/Sl4m7ijZBefZ+PVxYKPsY=;
 b=XkKDz09EfU+ESS23sFVUDBo7UWNKC63cGUt5+rHuDk2XbRjv5QNNR0gKkoSSZbnbt4O1Mp+Ce0Qi4b29MwOvM6fFcK2tYkKu9n9/4pHrDZOGrYxj1FCBcvH5LArUzT5Qv7DIuHqVxgYWj0xOyIpC5v8XcwqAu2iWNmfqRt5jse4NYWeoyG00oPXBRVv4q6/baAybtHKw8YK6TGlBwzCiX0KEvRPPG+br8g/lzY83VHDAips6Rd8bhw+ENl5iHeO7MIVyf3v4wAqri8+J71eyrzQ4LkEyY7ULdwYu/uLzHds/VVe4AEaqe6ZLrRxXTsZ8pm0DnmioVOzCfPtctD+l0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3nRmlN5bmsFKPUvYCJEd/Sl4m7ijZBefZ+PVxYKPsY=;
 b=HlyaDy5gnCQfCjtS8j5eckG/QILFq5rco+QL3q5Vhbu2DiSRrlIq4QPjITtgb+IvoZ/I/IKjhQcMo7YMpD2XxbAQdVO063QYWz8XxKmJsUYyNyfIk34ne2vREnOJq5p7mRmwrut+sm1XBXyQXp4ZFQl6Thf+Q3+Oopa6tifxu49m6/RjgGn95/FhW6jyxM/mRZDsfiENNEA4UEqEHu7bvIsJshKMKVmPckRqA3jjZGsqx0aD4phcPq08zbxPDFI7Q+nZ/lU95vKOkeeJ3dcow2I8nBu7A0q3rTLvSfystTSp7WyVoESd9d+sZdaOHg2nvoq3JFV6QlD3YsSKMBcKiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS1PR04MB9682.eurprd04.prod.outlook.com (2603:10a6:20b:472::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 19:55:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:47 -0400
Subject: [PATCH 11/12] arm64: dts: imx8qxp-mek: Add lpuart1 to support the
 M.2 PCIE9098 bluetooth
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-11-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=1383;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WEQPmQkoEPldRwU1oL3BYt29XFFBM/+stDWduLlnhVI=;
 b=Q7jAPNor/KxnCeMcIUnmn8SHYrYxONF2fW1xMLPyTBjbgHPdXx7EN+UX2PK405o650c7MsNsP
 gpKaBU9f0wZC1w6JJKtB9ev8pIMzYDSElK+VRYuyZL3s8T8WqBZlII3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS1PR04MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 01da22b9-1616-4784-10d3-08de17251acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjRiUVl0Q3ozeXBhYnFKN3BzR3VOQnFKUEQrWmIrd0VBZmQ5ak9NSmpLdU1u?=
 =?utf-8?B?cG9KU1ozejhZaUdUSHlnVGpnTkFzMXlCd1RRMENYNU9aZEVPM2czTWRpNUMv?=
 =?utf-8?B?L0lrM3dseWlvOEtJcmpsdGs0U2htbDhsNHZXaDczanN4K1BzNW9kMGw5Rkww?=
 =?utf-8?B?QU92TE9wc3oraE02dldXSFFwYkQzSVZkVk5WaXhPRHNJV0tPbWJpMHJwbmdy?=
 =?utf-8?B?QWR3QVUyZUxOK0hIUXBJZXYvaWRYR3JuR3JDNk51Y05scDBXK1hGemhGRlNT?=
 =?utf-8?B?czRDTlp2ZjNxT0VGVGFGVDdCZ3NHYlRNR1VHNTlVOU9Ib1NEL3gyYlg3YVo2?=
 =?utf-8?B?aGp5c1ZzMzNXNzROZGcxQS9SMUc0RzBvdncrbmtGY2QwRFhOMmkxeStzY0Nl?=
 =?utf-8?B?eFdGc05Tam1vUjJ0cExGdGRlQ3RZWHordEFnZE5ueDl6dnF2OWV3VHd0STJ4?=
 =?utf-8?B?YUlYYTM1QXNyT0phYmpSNzdFK0FiVk43YUJBUm1qMmhwc0lYQ1kxdW5wVkZz?=
 =?utf-8?B?RkUxbUpaQ05QNUlMVE5tdUNYUlFJWHRnenpLQVB5WTRkdnlsK0dBVmNyS2w5?=
 =?utf-8?B?eFhBR1JlZU9qN2JTcktNMTdNTCtvZkYyY0pVREtPMDFNUkJCM205Ty95TU5W?=
 =?utf-8?B?UmFiZW9CdmZpcG5YVEUvOGc4VXhqUVFmNC9KdGVHTXhQYlA2NHNOaVZGOEdR?=
 =?utf-8?B?enRqeFMzZWtBcTJQa1VtdFZsY0p4OWdhY3Q5dHZoR0xkaDRLMVVlSlRWQ0RG?=
 =?utf-8?B?RXREZzhCYmROa0RNYWJYWDZCZXAvdzNta253ZnFrUm5jRmk4WG5xa1RmK3hP?=
 =?utf-8?B?Z2Q3ZU1YOVo1anlHVUZkNEFvRDR4WWdpeXp5OS93aWd6YXNFSkw1T0ZrbW45?=
 =?utf-8?B?OE56OFlXaE5LMlFESDY1S3Y4NDcxQXlwSDdmSWVWU3VrU3ErbVZDMFlZaHRN?=
 =?utf-8?B?ODF2T1RveFJTYTNWcERNazU2bEpZZHdoV2I4RFpLSXlSNzd5ZzJuSHJ4cDJq?=
 =?utf-8?B?RzFmYUhscmpYdlZxd05yOTVVNE1CWEd5cUJ5azdPTTZLNzkxWHpHdW9OeTc3?=
 =?utf-8?B?R0FuTnBhYnl5UGNha1MrdjN5aHFNenc2RitqU1AwSXlWMHJ6THhyK1RMYzFt?=
 =?utf-8?B?SXZrc0diS2tqTWZ5eGtzSGlOMG5YUW54VG1tbFBMVVZCYkFMajlUaTdVSS8w?=
 =?utf-8?B?SGloSURtV01scmpnSFhQSmlBcGVrNU81WUtpT1dBUlZmMmlodnNROElRcmEv?=
 =?utf-8?B?MWt6ZXNIdGplTDlLKzdqTzcvMEVtQjFlYjBMTVAvUjJ2dm9zZ2YzbWVPNVpz?=
 =?utf-8?B?emQ3czk3aHNSNWNWMTBaQjBpbmpib085OUJoWHRoam43YjlXQ3g5REZabDB3?=
 =?utf-8?B?c3Izbm52VGpsdFlFVERXU1drWDdHYmlMRmZrRDIxOWo2T0tmUjNRWFowanVj?=
 =?utf-8?B?S3ZqYUppN0tZTEIvdFVBQlpTS1BKUDUxZktKcG8xaWdDL3U4RGM0SmoxdjJT?=
 =?utf-8?B?b0VCWHlBaG1lOHdrK0I2WVdPYmx0M0tyUGNDeHpMemZhdjEzbGViZUhqQUZ2?=
 =?utf-8?B?MHlLWkQwcUhlMTZYNjdNVnVEYzN0d09reFdDK3FNUElsblIwU3dZM09aaENx?=
 =?utf-8?B?Y2tzV1dyN0NBaTIzQnZKQ25zd1FlV1RoK1lQblJxUlRncTUvUllwcS9wc1NG?=
 =?utf-8?B?ZG8vOVN2ck44TXlqamRkV0QvVnVBL2hlYVZBTk1ZeWZRaFJQRDdiSUVFZkU3?=
 =?utf-8?B?cVhsNWJMMm9nUWJ0U21Id3FBcWFqZEMxdGovMGxmdWo4eVdndjVxd0tCWDQz?=
 =?utf-8?B?bGp6aWdkNEE5TVJ0amIzcU1ySHRJZUtVdzB6WTZtZDFRTHQ5LzdhbitvaFVt?=
 =?utf-8?B?WVc1OVhBbkZLYXRtR0lxMmRFdTB1RHhDUHA5c2tYVmxtVi9ab1N6UElkQXh4?=
 =?utf-8?B?YVJMQldhTGY2TWt4eGhsVHZCdkROQ0wwNVZxUFBzZHJjUWJvYjhZYlJjK0dC?=
 =?utf-8?B?L2QraXA1ZjR0UlFURHIwRWpNNTJuUWwrOW1ScGRqdCthTFlsT0hNZkcydFhM?=
 =?utf-8?Q?pSdK/Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2F5ckthanc3YjV1dlQ1WmhGbEJvMEVJS3VQVmdoNmdqMGhVUEkwb3N0c3Q0?=
 =?utf-8?B?UERiTGEzd2FDcXBMcEhGMnV3ZTBvWDBBWEN6VGgwa0g0SXhOTm9xV1dRR3FJ?=
 =?utf-8?B?d256NE1WQlYyV1BacC8zOG9aM2Jwaks3bnMvME1FR2hiNDhBajNRMTVUZVpn?=
 =?utf-8?B?aDkrNjJCRTIvcnRycnhZZ1FkMjg5eG1MRG51SXp0VFUwc0hycjJHMUJ4RVc1?=
 =?utf-8?B?cUtpUG5wblFqUm82NlV3enA0WVNHdVRmQ2NxSVhUVHRVSUFXZ1F4TVpYL2J1?=
 =?utf-8?B?Und5dXBKdTJ5c2UzQUhocjBJSzVxZjdYTk1MeUNGSU5MempRaW9jckx0MnJm?=
 =?utf-8?B?Sm5qR21JempZNENacDBxbDNhQ2JPWXE5WXdkMzJXL2NGRmZyNlBsQjlCenZC?=
 =?utf-8?B?d1J6NjVaeXVYWTNsZDRzRS9wRUVETzVnMC9GWFBMZDNDUHpFYUZ2TnVnR1lu?=
 =?utf-8?B?L0FWcFU3THgzSXhMVy9ubDhGT3JOZHdFc01NVmdwOWNUVk53YjFsOWZseFRG?=
 =?utf-8?B?SFhhM2VIUFNRcUZ5dDNxSjAwTlBORjdKSGMxS2UrZ2s2S3E3dS90WTViMkkz?=
 =?utf-8?B?OWdVM05GdkFyOUcyNlBZc3NmcnEvbnBDUHJBdnZoa0gyaWZLVVlLUFZORXRq?=
 =?utf-8?B?S1BQUGdFSnIzamFWRC9mQ1U2VzY1UlNidEpOamF5dFJldk9ybUYzakpMekow?=
 =?utf-8?B?Tk9jQk1FbGJFM1dVWk5xNUF1V0ZiZk9OU0NlVjc3OWtpbzRPbS9GVHNuWlNh?=
 =?utf-8?B?K0lSTjloYzBFWFpZZFN6R2pYWTBhMlJVSElFVGRBR2UwSXcvMkhndHh2c1lN?=
 =?utf-8?B?bUd3S014OFlhd3NCWDh0Rk1PQUlHazZKM3lISXdOcHduY3BpVXY2TUJwZ0ph?=
 =?utf-8?B?VXdVQzZJM2dyYSswSXRPZGdRSzJjLzNqWXVzNXRVMDNtdWM5b29iRDNXNzVO?=
 =?utf-8?B?SDdhTEsrVi8vS0dPZkgwOC96VGVGU3VsbExqcGo1TDhDZTNNQkxxcXFpQlBO?=
 =?utf-8?B?cGg4VE1oajUwZytaYWpxRVNQd1piOVFTVW4wVlh6RFV4cUR6UDFWc2dzQUVZ?=
 =?utf-8?B?ODQ0ZFZwNVFOZHJrS01wc0VtMThpM1UvWnB3SldOL1VTajdic0c0REM5d2xv?=
 =?utf-8?B?STU2WUE1Y1ZSeWZwbnZNc1kwMTlQMjhQMjJOS0JoRFFDNERTeUlCS1NEUTUx?=
 =?utf-8?B?dlkzbzg4VlVYa01hMXRCa0JLdzZuZjByT1E0VGNoMkp2R0ZZNTRMSkRhdldk?=
 =?utf-8?B?U0Zqd2J5NUFJeURPSGlWNWgyZDhKZ29WaXJIeWhWTk1GMkdJSVBFR29lV0xP?=
 =?utf-8?B?UXpkN01CNVExaWNvWUwwcTdMRHFIUTQwZTcyYmxKS3lFNGt5OGtEWUs0RXR1?=
 =?utf-8?B?YldVdDBqNURHWFlLOTlUMmRwQjdaaUFOZzZ0NzM1NVIwUTlmTlBjb0xhdlQw?=
 =?utf-8?B?M01SSjV6SUFtalhDYkw2LzlvVytENCtmdlFNemswVnRielVudEFIUnRpVmFB?=
 =?utf-8?B?aGIvUGtmWGpIcDBwWFljVFplKzBLblR4dVpzWVdhUG9kUDA1V1VnMjFrbUVS?=
 =?utf-8?B?Tm5hcGRYcnpYc2ZILy9ZOWd2aVAzZlhMU0U2QmJGeS9nb3E2NGUvbjk4Nk9H?=
 =?utf-8?B?Tit6ZXVlL3I1ME40TWthVjZJdjVKVVR0VTZvUTZTQloyS0h1WlFZNUpaZTlr?=
 =?utf-8?B?SW1CKzloQmc0aFlyejNYY1NEaW4yWlZkWUVlOWMwM2lDUXJJUmxBMElSZHQ2?=
 =?utf-8?B?QlJvL2ZvcU1vcUVJMjlSMFhrQW5ib2NlZHhZQ1JsZ1dEc05xNGc1bTc5d3Ru?=
 =?utf-8?B?TTVaYWtlS3dnN1R6YzFoL0wwMU9ialhqV1lneTNjMFdnNU9xOVFFVzhnWkRY?=
 =?utf-8?B?ZUxXNzVjOEZHeXRiTDlSSVlFUDcrQ2dPRWxtUCsrWXcxSXRnQkZXZE1jRVRE?=
 =?utf-8?B?bGtSOS9vSFYvS3hwRU1yblBGNkhYNjdzeGk5dEJTd0dLMkZ1Y2JuZlRmak9t?=
 =?utf-8?B?bnZRZysyU3RBWHI3LzR1dEJMeUpYdXJzZTVIN2RUdG5xY1FRbFNnMndRVER1?=
 =?utf-8?B?bVdpOTkzbWppanBtMWRaNWx1TTRTUFdEb3lhdWovWmd6WGxZemFPS2RGOTdY?=
 =?utf-8?Q?02+qH29Eps/P3UDFX1SfBHQYM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01da22b9-1616-4784-10d3-08de17251acf
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:26.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU7td9V4cvMQW3yy1G4JuKCzVms9J39og1N5tBveAnSGkgE6X4hoiFgSJWREYBZCjJQxjGRCZ/qiydT7f7FX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9682

From: Sherry Sun <sherry.sun@nxp.com>

Add the lpuart1 dts node to support the PCIE9098 bluetooth on M.2
connector.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index fc10710e4ca3e8472f32ba0beaadd27382ba756c..8b47623835bac028c2e4368d26c8891989b4751d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -642,6 +642,16 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
 &lpuart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart2>;
@@ -985,6 +995,15 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			IMX8QXP_UART1_TX_ADMA_UART1_TX				0x06000020
+			IMX8QXP_UART1_RX_ADMA_UART1_RX				0x06000020
+			IMX8QXP_UART1_RTS_B_ADMA_UART1_RTS_B			0x06000020
+			IMX8QXP_UART1_CTS_B_ADMA_UART1_CTS_B			0x06000020
+		>;
+	};
+
 	pinctrl_lpuart2: lpuart2grp {
 		fsl,pins = <
 			IMX8QXP_UART2_TX_ADMA_UART2_TX          0x06000020

-- 
2.34.1


