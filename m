Return-Path: <linux-kernel+bounces-895319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB5C4D853
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556DF4FC23F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219D357A28;
	Tue, 11 Nov 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lp+G840p"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A452F39A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861162; cv=fail; b=VIHunsm9vsGixiR67AmIbxFuZ0cGNCph2ezsDgHeHQ5DcN/ovGIDNrILvTcwaM9/tkRF1CTKmzPAPa4qDgHLO/ICxVpE6AbhjMjXRIXmvy4jRI36PJ0LggI+31nP9od7xc1AY/Iqot4CP3U1ous4atNH3ryprHIRSH+qP2ml3jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861162; c=relaxed/simple;
	bh=1Ha81Dx2XQUFHiIENzYT+3NBXkabB/pAKcRPbXKtymw=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlwlOLsawOiyPiOxzPiGze9Y/wY1wG/WOmelK3Vw963OreEoc1iOKLEnFG+WnybYrsjhletNjsiJfONaPYUl8U6rhSOdl/ZbYNf0NWwmUk7BFLpcY7H/Awr19Rvf10mFBI7sKAaI2tfdPLbrTqgN+eFuPTZSQzqmTjIkbNq5um4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lp+G840p; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVfgNkVQ4gtUa8ydQRqnPxA/3oVGeRTBMqKjcyNA+DWolb84bK2/53N3Gh0I5TNAc4HuTK75Bq6Uv2Rd8tcCvbtsllDlMVFyckUn65JRdyEpQ1O9vslXuWzjkR8U3np5zJ8HbZ+8EsNXJF0BPS8/jpLqLik/fSyzBc8I1QJXJ8oSFyZ3AVJpv6B89r2YxGFT8RGjAmP8MlTy6onfOk2HmN1pmIcLjCIYhi/Ge1k6YTmPCvJPAiWOUWM3bVqtjqgZKjaOvFOK0RDmWyu6C3Ag81AVEe0slnrHdf9gvXchOd4rNjKMJyFcINNyAyHZQe2Daog0TsNg4FBwBCCrwdK8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0C24cVbwUgh6E3G4JJse8ra03SYOwbkc6jf2Y0AK6o=;
 b=oY/9sezoPuiJ+aUOENsw3x8l5dzKFTFaBWor7smGGR7Dny2PNepN1BfineEDVBZdvKrhIQdcXkmbHo4u/nEKC/FdzA8IUa0lhB7OmTXqzzZ9X1EBDt7bRRBbp4u+iSj/op/Q7ZGyp+u5SLulujnZa0I19uGOQ+zoOWL0XeXSuGrceLFN31Op7zc3s18tbRDem3WwncpQ/iXIGqdPmWZwlJTw28OvzJuwLjai46ErSRNOSEcTODmQtrySWG/kFQ5NOgn0tNE61Y2Y8Jd1CINkLzk6sFyS8KymHYzmtGXzx9v9gbv1zKf+Ldu5WFZlMbY0h1syMAl0b+ZD3G9jxCp4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0C24cVbwUgh6E3G4JJse8ra03SYOwbkc6jf2Y0AK6o=;
 b=Lp+G840prtmjv/N/sjqxB6XwZdc6sYmye/T0SGWf24VGJEdSd1otXrFL+yggWUx3WTUUVEVJA9NjvzQMOI4pz/ol7DYT8dJPxqNX7duSHKT5O0vH0YOdURMO3VrTJtqpIb4ACqzN2CQwp7V4/urSRvLGGLu+QrQ/K0Dtmz41HuM=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by BN0PR10MB5000.namprd10.prod.outlook.com (2603:10b6:408:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 11 Nov
 2025 11:39:17 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b8) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 11:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 11:39:16 +0000
Received: from DFLE102.ent.ti.com (10.64.6.23) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Tue, 11 Nov
 2025 05:39:12 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 11
 Nov 2025 05:39:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 05:39:11 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABBd9JS846495;
	Tue, 11 Nov 2025 05:39:10 -0600
Message-ID: <cc48c040dac2edc27b453bc482d62309cea25c06.camel@ti.com>
Subject: Re: drivers/pci/controller/cadence/pci-j721e.c:648:undefined
 reference to `cdns_pcie_host_disable'
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>, kernel test robot <lkp@intel.com>
CC: Chen Wang <unicorn_wang@outlook.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Date: Tue, 11 Nov 2025 17:09:25 +0530
In-Reply-To: <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
References: <202511111705.MZ7ls8Hm-lkp@intel.com>
	 <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BN0PR10MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2005bb-a652-48a7-f413-08de2116f23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|32650700017|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9jWmF3bmhtRkdNa3FTODhOMnlHU2lMWXVTU0NETWFFaFltTCtnTTIvUEJX?=
 =?utf-8?B?N3BMUGlsVmswandwYkpldWQzcHhQNGhUanNkc0dwZjI0Qi9semdkUnhDZENm?=
 =?utf-8?B?UHpwampvVTB6Mm8wTmVGcGVpeTZCN29nbysySDdNQlUxSGxCbWkxWGI5VEQ2?=
 =?utf-8?B?QWhCWjZYL2lnbFlqaE9yaHZHVkFsNHBsNDhNcVI2SHcrdVJzNnpwUFBTbE1H?=
 =?utf-8?B?UXoyNERHYStzdE1KZWhETVhWdWg1d0IwR29wYkRQcWFDUVZaNWpqZ3JJQmIy?=
 =?utf-8?B?V2thcS9KYXZFV3pQOHIwbm9FVDM4bHJvODdaMFBSY2JTZnJwb292TG1jWU90?=
 =?utf-8?B?OXFyRENJcTZpZlZxRUI0RUxZTmMvakk2bHdzZnVXN1hvWVBrQXcySnhXN1VC?=
 =?utf-8?B?V3FaQzZ6aTNjd3hIS2Z2Tm1VWVM2VG95cmNlb3g5RVJNNUNnNW0ybFZnVHBi?=
 =?utf-8?B?VlFRVEEyVzJndXg3WFJtVXBOUWllMDhNbElJSWlwRmNUbzV5NUNFVGxMTmp5?=
 =?utf-8?B?d3pJZ0pzVUpWQzVHZWZiSCtFMXR4YVZIY3k1elZLTnlMckJMcEk5M1dYeEU1?=
 =?utf-8?B?NURpQ2FUcC9UcUpBZXIzTGkxS1pLV3NWVnFnUC8yczRCUUpIbWVybm9rYnFS?=
 =?utf-8?B?dFlMejU5emtFcEdFcXkxOXdoT1dLTnl0VXlYcjJTenJ3T292bDA0dVoybzlx?=
 =?utf-8?B?WmdYNVcwNnBFSGUraWl3Z2hRaXdnY2I4bG1WejNlNE82L3prZkhwajNxcDJL?=
 =?utf-8?B?NE9EMlVrVHVhOGFMZGhGT3kwMGpRTXBjbEx3blUvMEI2YTVLbE9oNGdFcm1n?=
 =?utf-8?B?WE9zejBFSGlVbC8zMk85T3Y3M251NDJXYUk5YmN4Mmo1cUphTmtpdmx1eUE2?=
 =?utf-8?B?cGRsbmwrTlZ4RFBKcnZaT2hEcVdDMmVyendJREQ5Mi9pN1czN211RGtVSjZZ?=
 =?utf-8?B?RG9PenZDV3VwdVV0ejZ2RTVqR0l3U2ZuNndqWXhrUEhuL3o1NlI4VVZBWlla?=
 =?utf-8?B?REFzWi94VXR1aVd0TlJ0eVVkWk1TcU1XQVAyNWFtK1BvRHNGRVFrY0FqUS90?=
 =?utf-8?B?bG0wWi96YXBBem91Q1lRbUFpVnVSSDNubEljMS92MWtsN0haSCszSjdpdWw5?=
 =?utf-8?B?T0NUcHlxOExJWUMwVmt1U1RHdVZhNVVBMEtWWldWaWdPYi82enFoWXdhVThZ?=
 =?utf-8?B?UjJpODlzSjJ0dkZoZE1xNmJoRTltVllTdSt1VEltRDhrYUFkUFgxVWhjZWxI?=
 =?utf-8?B?UVphT2luVnc1SERZSG44b3hKU0pOR3h5cVBzd283YkdqWjErN1h6R2xSSy9p?=
 =?utf-8?B?Mm1DWkVLSk1RWDdXUGdRczhaSDJveURNaitQQUNZZlF5a1hvVXRxRVAvejdq?=
 =?utf-8?B?YlY0bzJSa2ZJdUg0WVhjdFVXYTZJL25XVHdYcnRYTkJ2d29adjNzbjhzWWdr?=
 =?utf-8?B?UVVDczRBbXp4NGl2T1B0emYwQVNzdjVIRHQranR2b3lJVXlYTnhibmUvMUs0?=
 =?utf-8?B?RmJZVVYwbzlZNHhaWXE0dnpZZGZHS2V2TmxSZnZGMGJEUEl2bXNMNjdldHNF?=
 =?utf-8?B?RlNnVW5qenEvRlRzaDYrSnZnckNmQ21MeXYwbFdZUU9ZTWp1ZS90N0tnMWMr?=
 =?utf-8?B?SzZudjdqclllTzhvMGJmVTdQdTE2VEZNVFZqcVhDbzVWcmUzaXoyUW44MUpQ?=
 =?utf-8?B?aS84RW8rUEx2T2t0ckZHMzZpYXFWL2xTUnRaQXBoNkFjMko0R2dEU1RqcGxC?=
 =?utf-8?B?cFRhVG9OV015ekRudDE5ZmM3dXNteTRzMjYxdTRFUXNkRCtDL2M5MUw3Qmoz?=
 =?utf-8?B?Nk00M01IVFhmcll5SlJxSGg3bEhxc1l3QUs3MHFsdGJvQWxuU05HMGlXK2lm?=
 =?utf-8?B?THJPRW9EeDkvWERCMVRmS1hRa0UzeUNVYzFvYW1XMDUzMVFlTjFBeWt2KzRJ?=
 =?utf-8?B?Z2hEMG1xaHZRV3dpSnlvL1Mzb3lORXZoR1M5cUF2c2lHODE2VXRBa1RBNjZZ?=
 =?utf-8?B?cW84alkxN0t4Q0lGeXI2bEVmSjZQRVc0R1lOVXRiKy9aVnZyTm9udjZkUFJX?=
 =?utf-8?B?S0NSOFlOa1dwcnlpcFA1NXFVeTdleTNiSFc2bXNoSXR6WTQwZkw5TUVTY2dy?=
 =?utf-8?Q?UJTI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(32650700017)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:39:16.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2005bb-a652-48a7-f413-08de2116f23b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5000

On Tue, 2025-11-11 at 16:24 +0530, Manivannan Sadhasivam wrote:

Hello Mani,

> + Siddharth

Thank you for notifying me of this.

>=20
> On Tue, Nov 11, 2025 at 05:28:54PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> > commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: Add Sophg=
o SG2042 PCIe driver
> > date:   8 weeks ago
> > config: loongarch-randconfig-r113-20251110 (https://download.01.org/0da=
y-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 15.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j721e.o: in=
 function `j721e_pcie_remove':
> > > > drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c): undef=
ined reference to `cdns_pcie_host_disable'
> >=20
>=20
> From .config:
>=20
> CONFIG_PCIE_CADENCE=3Dy
> CONFIG_PCIE_CADENCE_HOST=3Dm
> CONFIG_PCIE_CADENCE_EP=3Dy
> CONFIG_PCIE_CADENCE_PLAT=3Dy
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> CONFIG_PCIE_CADENCE_PLAT_EP=3Dy
> CONFIG_PCIE_SG2042_HOST=3Dm
> CONFIG_PCI_J721E=3Dy
> # CONFIG_PCI_J721E_HOST is not set
> CONFIG_PCI_J721E_EP=3Dy
>=20
> PCI_J721E selects PCIE_CADENCE_HOST only if PCI_J721E_HOST is selected,
> otherwise, it will not select it. This will take care of the dependency b=
etween
> PCI_J721E and PCIE_CADENCE_{HOST/EP}.
>=20
> But if PCIE_CADENCE_HOST is selected as a module by other drivers like,
> CONFIG_PCIE_SG2042_HOST=3Dm, then if PCI_J721E is selected as a built-in =
using
> CONFIG_PCI_J721E_EP=3Dy, it results in this build error as the built-in d=
river
> becomes dependent on a symbol from a loadable module.

While I don't deny the build error associated with the above config, it is
an invalid config in the sense that the Glue drivers for two different
devices are being enabled. This seems to be a generic issue wherein
multiple drivers tend to depend on a library/common driver. How is it
handled in such cases?
Is there a notion of reordering configs to ensure that such build errors
are avoided?

If PCI_J721E_EP was selected as 'y' before 'PCI_SG2042_HOST' being selected
as 'm', it would have resulted in 'PCIE_CADENCE_EP' being selected as 'y'
and this won't cause a build error even with 'PCI_SG2042_HOST' selected as
'm'.

>=20
> I guess, we should force PCIE_CADENCE_{HOST/EP} to be 'bool' as it is get=
ting
> selected by multiple drivers.

This will defeat the purpose of the series that enabled loadable module
support for the pci-j721e.c driver and the pcie-cadence-host/ep.c drivers.

Is there a way to address the issue by updating Kconfig? Specifically, is
there a way to re-order the 'select' scheme to fix the build error?


Regards,
Siddharth.

