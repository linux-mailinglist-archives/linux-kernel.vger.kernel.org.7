Return-Path: <linux-kernel+bounces-662143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD59AC3638
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7E173B63
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B3143C61;
	Sun, 25 May 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAUdTKQl"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9725E461;
	Sun, 25 May 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748197254; cv=fail; b=aHhJ0ZgtxsA7eTbP21MJS7ryqrohF3+emVbUza49tuSIwChP5BuRd2n2d3YIUw/d+xf9vrh855HkgA6Niy58Brg/sM+5tkF3qZL64UTcuWDr4FSoQ/M5fcDLgkJ16FSKFv/aGsfTksAfZOuhkxd8FAeOXGi6+Qvg9rnRCvuLQE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748197254; c=relaxed/simple;
	bh=smQFjBITC7RUhnzlaHrr77jblJkoTNAwVanNp/0Rkac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubEEzNlDxSMfvjxX9UUy74nvnnWA7P3Pecv85SPutr+H6tSsm6217YnnQLO0CfardOWMbQMWd5hPNG2ePK7Xd3+KknR/rkRoXM+nyd+JdhSZIXDzEtqck4yLO1G39vm7JElOo6eIaOXoLji60Ogb+TKfXrL38FRQ0DgU09qVL68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAUdTKQl; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkaXfH1fhOQN9Nzd1WqSlilqrpknLfXGqZfO23nXfMMzMhstPFbVUs+5OrBhxxe3fO+Z3gJjyvOF7y6LxVhP4WNXKzNlJo++dSG5WWPB7ADoN6ywIkvh0/ZO3oKpaNa7vVssxGkHvp1emHz31tXRKv5Os0Wyu1LGPc/Cu+vM0C92u5sBR5hVBekz0ZA/nCXusL5OsOrUBch4NKkfA/4kjchoKe0ymo0Xt9EsHESTUfGLasoSku+en4WWTTuDFQACgF5Uel0ueeHXX1ze8WnDquUJj3zGk7x4NPQW0EI1zCOMvh7yKtwiWzTF/dRKd5wj36GbJOvTDQ1UPh5NoYAqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owaQj5tEvXkoy20pg+zNKxHw9AJWqy4zKDg6HGYegPI=;
 b=Ns7CjNEnD3w8Bx+QDynvIDQaeoJwQa2I2g1ZalThpib/R1aWfewCO8Km3uJ3C6dw6fBtfqtESGlRfZojKNaZSVuLbaBT55GbzMyFiYn0c3PoTf3pOP/ixIUMPAjxE7MZwpn609zDTUbVNKzJpmZ776a1Fb7sze5XEnJ77r1D5yZbfipMcYitK6lX0CcdbSARKclf7n1JX1RN5o2CEhDTLgwfYn/9iY8GOueap70JCiBDkvEFpaLv4n6mLZOmK7uC/h5pCD+oUsHlMmiO3yEScPW/Y99GG4THRkoljAYSFhlIrS9BoU4aLUopPgiGP4E33c1EPv14FQcALaKqMFrZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owaQj5tEvXkoy20pg+zNKxHw9AJWqy4zKDg6HGYegPI=;
 b=XAUdTKQlTkvxxyDsg2TAC+afadHdiUSWqE53TfCdrmAy24301+te0lAVnulsma/gmyax3dxweADsKK7ctYhNxJDtyoVR/dDTL4tYQ+j8ZBZqbxFQMVBOdquJUOSBQGAlOKpxHAmKCEprRHGpk/imAc9SzOnmgio5fa6vtdHWXSEQNEX51bLu9dErebOhdORNGazfdASQ10RDTe0lJgyOVZajN5sG9RioNCp+b7CP2CDJJifNEAIO4g8pH8doH9qb2lzlyEgkctiKQN3mYiybD/g/aDxNoobpB4vqA1Lxji66HhyoZNtaCchZpCCgJctDCEJ0HEz+lfRi1ucYGbp6FA==
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sun, 25 May
 2025 18:20:46 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::e7) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Sun,
 25 May 2025 18:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Sun, 25 May 2025 18:20:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 11:20:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 11:20:29 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 25 May 2025 11:20:28 -0700
From: Willie Thai <wthai@nvidia.com>
To: <wthai@nvidia.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>
Subject: [PATCH 3/3] ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the HMC gpio pin
Date: Sun, 25 May 2025 18:20:19 +0000
Message-ID: <20250525-dts-v1-3-9ac63ad3bf15@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
References: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748196599; l=1239; i=wthai@nvidia.com; s=20250525; h=from:subject:message-id; bh=smQFjBITC7RUhnzlaHrr77jblJkoTNAwVanNp/0Rkac=; b=TNZJkehxdJfwzJF5nWaNjn5ea0/ESUX/ofzFYYCjfKuJZ7lHORYzko69npSthS68+pk/GZUHh NLYLHAzUIypCldPWtdySD0t4a05fv2NfEtC1aOsBGu1a49bvUVc7NZv
X-Developer-Key: i=wthai@nvidia.com; a=ed25519; pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2191c0ef-335f-4a3a-3d53-08dd9bb8dd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzAvTjRTajBZTnEvVnJieWhlL0pzVnc5b0pKR1V5SEFIdU1NcDJOb2RIZTU2?=
 =?utf-8?B?Kys5T2NuQ3dDTmI0V3RFNnlQZGpIVW51MHlaVzZzbERmMWlTS1REdmIweUVW?=
 =?utf-8?B?c2pocEh2UjB1ZHFOSjFlakw4VHhUWStsanJDV3k0c2xVTWd6UTlUT29nNnZo?=
 =?utf-8?B?SzV2am5MVVU1SnFxK1dwVTM1c3JzQnJGczJpeFNsVFByMWU4b3JLeElZdVBx?=
 =?utf-8?B?RW95R0NXRHdtRFJCemxmemhRa0kvZTIycFBTRVlTbjBXTUJPZ2Z5RDVFdFZ4?=
 =?utf-8?B?cXlSdHd5aUEyZkNSWGp3WWdHbXhDOGJ0N2pKNVNaM3RWOUZtd3hNZ2Rvenhi?=
 =?utf-8?B?bWV1SmFONVR3elMvRlJUbm5CbDRReGtjTzhRdGc2UDFFSENJZXk1NU40MS8z?=
 =?utf-8?B?czhTamlHN3NDQVVpRHZnMHBRalZqZnI5V3pVM3FVSnd2S2xrN05sNU1xNHJI?=
 =?utf-8?B?WTl3N3g4Q1hueWxsUW1QRGEyR2t3T1V6ajVUcmtNd3A2WDlxWXdKSkxRdFlQ?=
 =?utf-8?B?Q2xiQWxnb1lrcVM4R3FXc0t2SzlIQk01WmR4d0Z3bXN1OEZZclF4aC9EQmlr?=
 =?utf-8?B?ckY0TTdJYy9lNVNRVDRDeEFQR1ZEVUd4Y2ZqaHdLamxrTW55a1hJQ21SLzV3?=
 =?utf-8?B?aTkwY3dLVFFPd2YwYlRsQ3ZqZWxUSmpFTE92VVFqZ2FHcXJyaFlsRnlGRE9h?=
 =?utf-8?B?dGhoaXllUUtVV3I3bjg3TXIwVVljMUw2S0lsWlJwbSs2QWVTcmdEeVEvVnND?=
 =?utf-8?B?UkRVYjJKY0VlUHFtTmxjQ3pIWWhxVitwMys4eUtHRXVnZUF0WHh5WmlhSDY4?=
 =?utf-8?B?ZUxqR1dLd3kvaEVLSk5rRzBuYllQU3I1ZW1qTU1MeDRWR1RBNWhrSE1sMUFr?=
 =?utf-8?B?eFYxSkM4TUl6K3BhZjBCQ0lWRTBOZEhhc1YvQjEvbnZVUWhnSW9ULzkyNEhJ?=
 =?utf-8?B?OGhWbDZ5TlVYbDB1OFF0Ui93c20rMEhTbzErdXA1dnlGOUlKbVhBM2k2dTY2?=
 =?utf-8?B?T1hKWURrdERaRWtwb0NSaGVxWm14RGU2c04yWmJ2OHBUSXJnK1NmRUxqZ2Jp?=
 =?utf-8?B?eFljdzAzZDROK0wrZWI0ZlpQSFgxYVFMM1ZpMmhkZWs1c29uNlFPdTg5MStB?=
 =?utf-8?B?Wnc0UldPMjBtVXltUWpVMUlNYkpPUmx3akNQRXNISzZGSnZVZlBMY0wyZVlP?=
 =?utf-8?B?L1Mzd2UyU2pzZTJzclpkNDNydzc1VVJ6dHlQZFFURURObkJTY0xJOC9VSUJM?=
 =?utf-8?B?aW01c044VnlESEtjVzhNUlVlcm8vK1VnbFc4VU5vZEVjZ2piMmp4QmhWS014?=
 =?utf-8?B?VVZQZkxTRVFRNjUrTVNud1ZpK2k0Z0xQTzRRNit1ZWdOQzJtMENrNS91dmZ3?=
 =?utf-8?B?WnhhbmdQMzZVOEhWWkFITnRSekdPK0xXaWVwSnE1RFIwbWtPc3B0MU9zRHl1?=
 =?utf-8?B?ajFyUDdzb1VvSThwNzB4R3l4Z01tRHd1NXdUNWQrcGdHWEVUSTlWNHhxVGd3?=
 =?utf-8?B?cmhCemVvUGh6YTU3NWplYjVWMW5zWGtTV3NNV3ZRQWpNbTR3Y1JyN2dpSkhL?=
 =?utf-8?B?QWVYVllwTjZpTmlncC9wOExXYWhkS2hGTmZSREFhQzl2OTUzUm9mQXVyQ0JJ?=
 =?utf-8?B?M0NDb3NNbzlYYXh0dHdINUFUZVh6SURvMVA2bGVWOFlqcm1nMWE1Wk9GZ0V2?=
 =?utf-8?B?dE1YY094Uk9BSzg2MnlLS1lSd0RDNXJueGdRSnRwZkNVcDM2ZWVlakcrM1Jl?=
 =?utf-8?B?bEJ0TWVjZXJjUHE3RVp0amR3K2d4RExxTVRycnFDYjRrR2plT2cwais3enIz?=
 =?utf-8?B?L0g3bnErMlV5d0VFUlhHT0l0RG1OK282b2ZwaHRIT3ZXRjNuK2ZIRjV3RHM1?=
 =?utf-8?B?VTRJWmNyMXFERUF2V2xpTUF5NzFGWlUwYkpGR2c1MUxiemhMNGw0RDlWT1I3?=
 =?utf-8?B?ZG1HWnpRUmMrM1V6NUprV1JoMEJiU1RWQkovRlJQeDV3VlcyUHo5bWxhNDA0?=
 =?utf-8?B?T28zNTltWnpjTWdCYWo5eGpyaHd4ZWlnNDNhV2JsT2hUOTZ1Ym85QmtPN1VK?=
 =?utf-8?Q?vj6zL2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 18:20:44.0657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2191c0ef-335f-4a3a-3d53-08dd9bb8dd20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

Repurpose the HMC reset pin to FPGA reset pin.
This change is according to hardware change.

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 1240f6ee92c8164dc642a83d94719a73c1c9bfd5..dcf3d075c7e373709820435a42260c6d2f7d2dbe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -1135,7 +1135,7 @@ &gpio0 {
 		/*J0-J7*/ "", "", "", "", "", "", "", "",
 		/*K0-K7*/ "", "", "", "", "", "", "", "",
 		/*L0-L7*/ "", "", "", "", "", "", "", "",
-		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "HMC_RESET_L-O", "STBY_POWER_EN-O",
+		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "FPGA_RST_L-O", "STBY_POWER_EN-O",
 					"STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
 		/*N0-N7*/ "", "", "", "", "", "", "", "",
 		/*O0-O7*/ "", "", "", "", "", "", "", "",

-- 
2.25.1


