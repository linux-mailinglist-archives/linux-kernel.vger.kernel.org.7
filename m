Return-Path: <linux-kernel+bounces-887880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11141C394AE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E13F1A40363
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE852DE704;
	Thu,  6 Nov 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ee9gXkge"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012014.outbound.protection.outlook.com [52.102.136.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D972D2495
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411390; cv=fail; b=IYXUtNxNSLehBxgT2BJbBzD9w78cr62S4J1eQEM1wBYP+RKDBXf6od7UwmHFJYdYSxkDjB6F0gXvvYiqtYn5pGaMygnnmbS5Rq0o4Un51xhttXEjD9AzjgrzBLuccAz8/d352HYPKxYXrI9oUGLBzhtME2jgr9Yv1Rwa/elm/6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411390; c=relaxed/simple;
	bh=YEKk0cA/NJfLJ8F1GIFHpbBxpm6107NuXGEBimy55N0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBpZviuhPAfNnnn8nULBd9fV3ujQZ7vfg1xwUgxWWKoPKElu1QMWW3LUArLzMRpCMhDy+1r1a8CQDhx1/e/5F9U6xPEizG5oxeUrGkabD/V0w2AAfHrszVlz++xJcqoJMEv9cUaOQk3mKWhnvyszlkjLYCDaP35F/SYvD9heWFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ee9gXkge; arc=fail smtp.client-ip=52.102.136.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYLIXUyXgVBnxHEbpCtu1B7LORxq90P1BK4CD997VFWgUgVAwi7RpnSul9sEXElxD/gkEvqZBS+HCTKJm+EVlZnyY16xGGvcbIXcLpF+WyWO6miHlZT8VjFzPJrheIhqc/4KKCcmdDcARe4rshSMhbOmHOwmiekGr8y5WZloMVBTGvphiha2ywZ0Pc3ak0LvFV8yDo89TaxH3IIRL/Cg5VXySDppyfM4494dJNYq9vSyFFFx0zYg+U0mDEtCN9JyFuTOo+LgzOv5GEWhajizxFNSAMo+cjge+wEUvq9atP3H6X6sI86Rt0vClwBjPj8K0I+3sLF0pHxAE8nrvY08qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFtqgc7QVhIpVUQ5fmXJEqExxhqvPolsoRTuWzAEKxo=;
 b=t7WAeZ1AcLRTVH0i9CQbSyVempfBTwLgFp7oRiUUUAS71/S+voJw/BpuKRinc21TfP61Tplyun3EkU1LDvb8McFfzkrYfo08BQVZBDdRC8tQ5z/ZENX4XccMliCTqZ34IItOlbZ6Rn05ktA/PodhqJoQurl2Sbsqdfd96o7/ql9/ko7LEGcF8m5rNVXHvHtQbSZdACpUZuaIbsgqfGspABOMRC9AAJWqVdZ3CGALarIZge1WviIE0wfwjXkJtVmuvCGnGiE6/R+dSs3cO8bOExkFWiEDD08NBGrZEXVJkrgoL78bzpx8f9HptEsO4kwkLjBM0AE3rrGPVEsRBAz/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFtqgc7QVhIpVUQ5fmXJEqExxhqvPolsoRTuWzAEKxo=;
 b=Ee9gXkgeckCC9/CT5yL5iwmNhzbjUIVNCTyR4S8mwT7Ala7ZgF6KyHnqDcW2nIwzvndNewk+5AzxeKdJQxpffSWoNsFyY4jicYLo25pEeCnaL0Hz51PiDJnwiT0suGu+xjW/s5E5MugJ5pYEfPOQACsxeVHsQM8uQSyDE9A44Uc=
Received: from CH2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:610:54::34)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 06:43:05 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::52) by CH2PR11CA0024.outlook.office365.com
 (2603:10b6:610:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 06:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:43:03 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:42:58 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 00:42:57 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 00:42:57 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A66gr3T817583;
	Thu, 6 Nov 2025 00:42:54 -0600
Message-ID: <ddc4e2df0a5593d4a6051057c6406db338f4c0ba.camel@ti.com>
Subject: Re: TI K3 AM69 Kernel Panic when PCIe Controller is Enabled
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<jpaulo.silvagoncalves@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Kishon
 Vijay Abraham I" <kishon@ti.com>, Swapnil Jakhade <sjakhade@cadence.com>,
	Andrew Davis <afd@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	=?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<joao.goncalves@toradex.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Thu, 6 Nov 2025 12:13:07 +0530
In-Reply-To: <oawjd2mscz2untz6zc5mqn6ak2oxdul6pnaexiohe6ae3bow2r@afkvpu4izrvt>
References: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
	 <cf751cf7-53a5-438b-9903-903bd8c39b23@ti.com>
	 <oawjd2mscz2untz6zc5mqn6ak2oxdul6pnaexiohe6ae3bow2r@afkvpu4izrvt>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ0PR10MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c8d20-5e3d-4d62-0c43-08de1cffbca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|376014|82310400026|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elMzamlrZC8xb1o5b0o1YkEwVDdiNWpmY3NSYnNyaDJrREdXbjhEbFhPdzBz?=
 =?utf-8?B?RWJEeUVYSGRqbC91a0NJRktBTm9FRjJqV1R6djBGMVljRXUwbGVkN2JpK29E?=
 =?utf-8?B?Um5OWjdoakxkSVVZcG5ZOHdaRkV4ZlIvZlZETGx0eGo2OFNXcktFR0g4VEQ5?=
 =?utf-8?B?clE4UCt1VXNRRGlEVU1rZHRLdTdFdkNEUHR0bDFPVUxXeXJZQW84bGRoaytw?=
 =?utf-8?B?Wk1ZVzkrUU05YWkyNURldkJUa0ZLZ1VQZUlTZjVYS1J3TGN2MzBRNU91VnhW?=
 =?utf-8?B?M1dHQzRScU5Fc1BMQ3JUWEFKdWZWazBqSFBqTGlFaHdyTmp0dldmdVpZcEpR?=
 =?utf-8?B?VXgrMVNVaHpiUnZ2eEtUUUJNNEluUGU4MmplMXo3aWM0a1N2RjhRR0hNZ0pw?=
 =?utf-8?B?UzczUzF3T1pweThkUVRSN29FblA3clBuSGFpVXlGbFUvWmVvUDVuNUNmQzIr?=
 =?utf-8?B?U2tPR0VlRFlTc1RYRUcrZEg4UHQrOHJUSzE5USs3TVorUlFDZ1NnV2g5WjZC?=
 =?utf-8?B?Q2RYSGRiZFJKeDZXUGxiZUY2ZmJjRk9FbFJ0OS9MQWM5QkFLL2FnUWRNTjAy?=
 =?utf-8?B?MnFmb0FCL1ZHTHRDQzhOY3FvcjZHYldFZWhXNFMxYUZqR0wvYXV3ekJlWVdV?=
 =?utf-8?B?L2FoZzNBSkwrcXlFdk1mQVZmaFBTU3dmL3dkQ0MvdVNwTFZZbmZub3ZJcU45?=
 =?utf-8?B?MkNrSmVpUG9QWEFDZGFZYkZac01aN3BNZWRnSE42c2E1ZEpSS2M1MEllOGh6?=
 =?utf-8?B?OHUxT1VMZVBZd3NiMktITzZxYkNCcnZNNFE3UVZGUXgyWS9JRHN4aEI1M3dm?=
 =?utf-8?B?RjQwOTNzalBWa3pWK1Y5UnBOODBiWFl1blgrQ0padFk4M1NyT3o0K0loUDVa?=
 =?utf-8?B?OXcraS9iT2VHdzYxaWE4aVNtbEdxaHpuNU1Ld1BXVm1WS3Q2M3p5OS9RU2hz?=
 =?utf-8?B?VWtlbDl2MDJkWSt2ejNJVURwdVR0OUpnQ21Rb1dqYys3NXdUTnlUTlo4TTdv?=
 =?utf-8?B?ZVJ4ci84YzV5bldMYmYyV0hFTEFTaE5yUmRQZG5vYUxSb0R6cVo2QnM3bytk?=
 =?utf-8?B?dHY4emptTmUyY002Q0p6MkJ2NjlpbERXbUhaM2hlQy95NjF6cUd0Tnl0NEFB?=
 =?utf-8?B?Qnc1d2QrK0UyRWV0UEdTNEo1emxGR2Yvd1dCUXRtZ0RyNW1BRWxwaGNLdGo0?=
 =?utf-8?B?d0ZydGZSTXgzNW91SHFZWlZIdkQyS0tHYllwWW5aWEZ5QWJyWVNaYkJjUjBl?=
 =?utf-8?B?dmFuM0NZamw3YnQwYWNWYWlJTUFld2l1UTZZOFlWTWd3YVQrM1RxUGFUdjNY?=
 =?utf-8?B?VUtXVHA0ZVBQV25hZ3lOKyt2c1I1WFdNR085YVAzaFJYLzg4ek1jSGxnbG1p?=
 =?utf-8?B?WXJJMmFac2tjWSt4NTJqWXRYelNjTFBlSEhBdHNwRU8zRGQwNWZqTlYrY3Fs?=
 =?utf-8?B?WEZKOU5lSFppSmt6Y015MXRVZkF3R0dURkY2NC84V1p1U2IzbFFqZTdNY2JO?=
 =?utf-8?B?N2sxZ0V1elduU0NsY0ZXR2ZQUTlKcCtselpVUzJPNFFyYkRSN0dRUk4rNm50?=
 =?utf-8?B?MVlYTDdFNkVHaEV6ZUsrVGhBUk5KbTJXeThmc2xhZHdKRi9rNHA5dk5jTHJK?=
 =?utf-8?B?MVE0WHhqWDYwMktxbnZVSXRlWDMzdWt0dHFjR2ZyNXkvZFRlYWVSUGpUS2hH?=
 =?utf-8?B?NFZoSmtMNXE3L1JDTkQyRlEzWUxmM0J5Zk13SzF2QWpwMGYyTko5aVF4RktI?=
 =?utf-8?B?dytybDlTb1pjQ3hDSUF3Q1Q1b08xS0FXOEE4NmZaaHhOMXQvdWhqRnN2VEJ1?=
 =?utf-8?B?djJ0MUF5Mzd6MDF6UDJOVlhNbG1YZXlkYlp1dHBVK0lETUVqdkJuVUY5SkMr?=
 =?utf-8?B?dW12N2NVRllwOWVzVkt3dndLeU9rL0R2eStVbTI3UzA5RXpBODhoaklWMkNJ?=
 =?utf-8?B?Y1drWDVhWC9ubUJLQmRLaFRXelJ3TFQrSktIaVZFUXY5ZFp3VDd1Tk1xYmxx?=
 =?utf-8?B?Um4rVUtJYkJuZlB1Vk1aTDJUSUFqbGtrWmZZbmIvME01TDErQmUwcEtTNFlY?=
 =?utf-8?B?N09jYTVGaWdQdHlFTWIyclhIcGs1SWJYNWRPaXJzZXlKT1ludktHdm5yUito?=
 =?utf-8?Q?Nwj4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(376014)(82310400026)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:43:03.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c8d20-5e3d-4d62-0c43-08de1cffbca1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447

On Wed, 2025-11-05 at 11:10 -0300, Jo=C3=A3o Paulo Gon=C3=A7alves wrote:
> Hi Siddharth,
>=20
> > The E2E thread above leads to another one where the issue was claimed t=
o be
> > seen only with the usage of an external reference clock, and it was fix=
ed
> > with the usage of the internal reference clock. Does this hold true for=
 the
> > board that you are using as well?
>=20
> No, we changed to use the internal reference clocks on the current
> hardware revision (sent upstream on [1]) and still have the same issue.
> Please look at the PCIe nodes in [1] so you can confirm this. For
> example:
>=20
> //file k3-am69-aquila.dtsi
> /* Aquila PCIE_1 */
> &pcie0_rc {
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pinctrl_pcie0_reset>;
> 	clocks =3D <&k3_clks 332 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> 	clock-names =3D "fck", "pcie_refclk";
> 	num-lanes =3D <2>;
> 	phy-names =3D "pcie-phy";
> 	phys =3D <&serdes1_pcie0_2l_link>;
> 	reset-gpios =3D <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> 	ti,syscon-acspcie-proxy-ctrl =3D <&acspcie1_proxy_ctrl 0x3>;
> 	status =3D "disabled";
> };
>=20
> [1] https://lore.kernel.org/lkml/20251104144915.60445-1-francesco@dolcini=
.it/

Thank you for the details. From the logs shared in your email at:
https://lore.kernel.org/r/pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb=
2@y4ox65e66mkj/
the following lines make me suspect that the issue is related to PCIe ASPM
(Active State Power Management):

[    7.480637] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw
L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[    7.493685] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM

I have two suggestions:
1. Disable ASPM using the Linux commandline option:
pcie_aspm=3Doff
If the bootloader that you are using is U-Boot, you could run:
setenv optargs pcie_aspm=3Doff
at U-Boot prompt before booting Linux.
2. I had seen an ASPM issue long back in 2022 and had narrowed it down to
the Data Link Layer being inactive when the PCIe Core in Linux accesses the
Configuration Space of the PCIe Endpoint:
https://lore.kernel.org/r/faa13ac2-27b6-94f3-ecde-60256bbbda1b@ti.com/
The fix for it is the patch to which I have replied above. Direct link to
the patch is:
https://lore.kernel.org/r/20220602065544.2552771-1-nathan@nathanrossi.com/
and it modifies the ASPM driver to wait for sufficient time if the PCIe
Controller doesn't have the
ability to report the Data Link Layer state (this is the case for the PCIe
Controller on the AM69 and other K3 SoCs from TI).

Please test them and let me know the results.

Regards,
Siddharth.

