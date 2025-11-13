Return-Path: <linux-kernel+bounces-899034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C7C569D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04D53BF2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587382D5C6C;
	Thu, 13 Nov 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wW7vUIsy"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE223F42D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026150; cv=fail; b=DuvfFFj5+Z+ifXQcO7aoN02WH+jYj2WdJ2MMmnVyoL8rZEVyw7ZgljRxD/31YpqtjaUB89ZvZFFivEEBwtZG7gWu63Iyh3CVVlsdugaa1HdESt+S9t9PFzzXedXOdZqY8ISIxEiLRkf2vaITbEoNY6a7I94+1xc8EWcIOpyWPLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026150; c=relaxed/simple;
	bh=bEnqrM+0LuDcL9rwTePzzmWdqKNXa98Rsp/zk08vVfU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuZiEmRayMEPPHGsD2rwjWFENCfhJAiQMkGlKS3QOAuWpGkv85wxJyR4DUjzV3qY5Qfzjok03W+K4skTpgA2s9yETuG9eRBBoV7wGszQYM6vWZGwc6VkpMG3h8Ee3l+h+RgIood0pvxg0czet4592Bd8eAoLTbScw/Xb712xmDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wW7vUIsy; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRYqqTFnGP9N0EjvQjclnJp5etI1Dcej+dmvpgnO3paHGsPZO2IFVgK9z+E6OlhCkibCE/wATpvNs4Q6Ztn7gLe3Jtdux8EpBx8wX2zgv/UdG7KSTtgVsoMK/LzF87GZrJrAopn1XBaBcyZBK/zwKqIfZdZlEcxjQQjyCB9YoeuAqCOsFC4unHqmS51zhHLOhi6E4TinfKF5SkGaB2kftH2KpjaBCptvvmDerqfWs7cAWTeOmh39P80iBBWlaGnh8ZWjU5CNwUfxtCgqsC0XDeiX/CoMkj6b6ZOdGWiOaaWLwMZlz8YJjmNnyH7eKBeyLsbvF+g6KBtM6E9GeY/S3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12CqOjj2fn4TIKGjB/D4rBtKZIRa824RxZ8or13f0dw=;
 b=hykg6f+vIdrDi7mpc3IlbaU7gRhF1FchA/EEgv8TiMdUzv4cQhWzJFm4hPGSl5jI9atqXeu7vSv++7SqERWaqHcsp+I2tygF8ZOLAcm6TpfKwgm5I82Gv5dKu1be4+V7OrDB6/QpKd3H7ptEeO8LVWIwdbqgPoLJeY6irfoxyG/8SzGnD7XvP0btN1hQlD+vFAUd/X6/rd/DU3LdnmAv4F+MUjrfk8W/ppN4jpkZ54TpVjytXm+4THwOPD6nvYIJn2zrclAgG6U2gq9Mydx8IWiFNJ85bVaQf3pjrGv+nyYSnoeiyjjmTLepGMHfv9u/XZfwV0rx6Hj1Lo7j/VsDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12CqOjj2fn4TIKGjB/D4rBtKZIRa824RxZ8or13f0dw=;
 b=wW7vUIsy8gfU1sIlj8pcDzw2yYwgVOem1KzLAxNyF5gwVuTIMyg+JvFzQbRGfIvgKJRIq1MVjN2DjF7G3nVwQWMXy8cJC1oYyOSlRPRE589CzWfNTBsnEdUh7urcIOJyXmuaOo/1dprikDGIeOdAJMebzcx5tpvxs5VRm/+W0z0=
Received: from BY3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:39a::8)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 09:29:03 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::66) by BY3PR03CA0003.outlook.office365.com
 (2603:10b6:a03:39a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 09:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 09:29:02 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:28:57 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:28:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 03:28:57 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD9St68000794;
	Thu, 13 Nov 2025 03:28:56 -0600
Message-ID: <ab085118e844cc173ba158171a08909a006f9abb.camel@ti.com>
Subject: Re: drivers/pci/controller/cadence/pci-j721e.c:648:undefined
 reference to `cdns_pcie_host_disable'
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: kernel test robot <lkp@intel.com>, Chen Wang <unicorn_wang@outlook.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>
Date: Thu, 13 Nov 2025 14:59:11 +0530
In-Reply-To: <wwgrzgcdqralnyrhvufoldiyautpkp2d2chveovgnen5qvt4p6@l6xdmkezpdd2>
References: <202511111705.MZ7ls8Hm-lkp@intel.com>
	 <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
	 <cc48c040dac2edc27b453bc482d62309cea25c06.camel@ti.com>
	 <znkojajaxfudm3xn43ed4my5fcwyszv4gxajnizonqu3pf5t6g@bph3av5mzmg7>
	 <85fb83a9-6d8c-4c9d-8c78-2d3f5d473ea2@ti.com>
	 <wwgrzgcdqralnyrhvufoldiyautpkp2d2chveovgnen5qvt4p6@l6xdmkezpdd2>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: b0546d16-d641-45e7-b64b-08de2297150c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFOc04xbm02N0NLQnE5N2E2aFc1TjBhZy94M0QvdzNUZGFtN3k5NlprWHUr?=
 =?utf-8?B?RkpwQS9obnFrbGx6KzBXZnJzTWZIODgwVHhPUVRrbk5ZZmNuUEZIemxYRWtN?=
 =?utf-8?B?RERkVlpVMXJQOTVoUkxWay9iK1ZDUTBWb2swSkRFYXdaZTJEbzVqbFNqdnFW?=
 =?utf-8?B?bXoyUDF3amVTMFVKemRtVU1yL1BlOW9OYW5tOGdyRkxMYmhUclNnMVI1SVZo?=
 =?utf-8?B?bmVZNDVOMUJPVTZqT3lGUXJwMXI1L1FvUmFpWkZNaWFvWVZRc1A4ejN6QlFx?=
 =?utf-8?B?NFVPQVJJREVPRlRvNGErajZYUFJlS0pzVnpPRHl6UmN1UTU4WkZJUHNCUEhr?=
 =?utf-8?B?dmppSVBZdFBMQWUySC9mcm1YN0pSeC8wakVOem9qSURNMXFTcFdXZ2ZobzRD?=
 =?utf-8?B?bXFVZk1zb1dURnJBU0ZBWktzeS92UUMremxTdWt0RDF5VUpWYjhoMEptcG1J?=
 =?utf-8?B?NWFaYWpmSUxheEFncy9CaFdycFFkaThDNk0vZEFTcml6NkF1WFRjaXFtbWF0?=
 =?utf-8?B?Y0VNbVU5MmFHV21vNlJCdUYvcEc4ajFDWkUxWWZsUDQ0QmVUQTZPdno1WXlS?=
 =?utf-8?B?a1dxdDk4OVZEcTFhSFN6VXUwQmRTWGxRdXlueUFCbDU2TFpINmUwVnIybVZs?=
 =?utf-8?B?NlVhcW1ndzVnTy96OHZ5YVM0NERYYmFoUWNwU3NRNnU4VG92QndibWkxbkxs?=
 =?utf-8?B?ZTEveXVvdUtZSWNWUUdMNlU5NElwanVUVXA3VG9WM3RSUTA1RmNsOWtzSW8w?=
 =?utf-8?B?aWVnamtXTjY2VVI3RVBzZWRSQ0RpMkYxVGFobkIrcWhNOGQyWWhibjJFMUUz?=
 =?utf-8?B?cVNSbFk4OE5kNzMvWEVXSmpWZ3FkWk5tWE51TTBkLzdGa3ZjN0ZkMHZFMlox?=
 =?utf-8?B?V2lHcFpxNnJPOEhGQUhUSkZPZnoxcDB3MGlZZVFpMjRCWFJZeldRTWI2T0VP?=
 =?utf-8?B?UEp0Y0QvM0V0ZFJPeG5QK0k3eTFPYXc0bWVWclM0eGs0dXBhVGVpNGdPN1Y4?=
 =?utf-8?B?czZ0ZjV4MkhPY3A4V2FGdE1VNWtxWmVnRnpBYjVBc0RCak1WTU9lT0RaRW1o?=
 =?utf-8?B?M0Z5eDZabUUwMG1OODhkMnpxVTFVV21nMjk4cW9Pa3YzMy9GT3RsQ25WWFVu?=
 =?utf-8?B?RVAyUktrL0tlYlNtZ0tuOVA0aHRON3dVVFUvUGUvTEpHdkNYaVFaNEo0aEtq?=
 =?utf-8?B?eHFsekNydmNKU2h6L1NLalYrUytycy9WRDIyL2tMTlNZMVRmcDVZQXNISVNW?=
 =?utf-8?B?QW52aWEreHg0RXBwL2NmR08xeGRLYmprU2NiemNUVE5ib1J4b0QzTDFQUlRW?=
 =?utf-8?B?RHlHdWNnWXpTZmFmcDkyTHg5SlFFTDV0MG5SN3U5czJYQjNIUGNkY2c4czZV?=
 =?utf-8?B?SjdLclpVdWwyRTVVKzlTSUZ4eEsveGQ0dmE4K3pRVHNVYjlFMFhBQmlQdnpq?=
 =?utf-8?B?RngyK0NObitCdnJWVk5tMjNsVmpqK1VCS0IxUlpjSC9nZnJVbm5PRC93SkdZ?=
 =?utf-8?B?SStNTFhrQzQ1UEg2YUJlbEQ2d0NFL21jZDZrRHJLNmFScnMvcjZaTGhYK1dB?=
 =?utf-8?B?Zi9vZWhhQVMwZkwzckZwRkpvMWRkZzVjZkV4SXBsK05tdXJsNnNMN2VKMTFj?=
 =?utf-8?B?RlRpdmpWQzJWeVdCQkUzWUJJWEE5Sk5YRHM4WDNlWmtvYjMwTkRQUnRUS1ZG?=
 =?utf-8?B?Uyt6WDVncHVNNHRWNUpKbEZKRjFuQmxBSlByQXZlN3FGb2xwOThvRU1DdWV4?=
 =?utf-8?B?NkhUT1Z2ajRKaEFDSzZlOXRlVWJZS1NDKzU3RkdFbEJhdm50aCtTa1E2SkF1?=
 =?utf-8?B?M3pMa04xeklERmhnU1IyOVh6S2lacy9HelFGQmRnQU82bnVGMUY2eTFiOEh4?=
 =?utf-8?B?N3dHTk51YkxRVjJManVKb0FQU09yNW9kVlJuVXBua1R6VDg1L0NGUG9vN1lK?=
 =?utf-8?B?TGxPVG82cnhTdEVQUnBha1F3V1h0d0N5aFhlcS9mSm9GWHdXcTArTE4yVWJB?=
 =?utf-8?B?a0JxM2hKdE5zd3ZYWVhucG95Ry9NUktHd1ROSW0wUGZldnlhY2h3cXBBTjk2?=
 =?utf-8?B?Rnk4bFNNL3pLQkxnVHE4WmhmR2pnMEFBQlFlVTg3aytIbTJkZGhiK0NsTUVp?=
 =?utf-8?Q?/eHs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(32650700017)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:29:02.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0546d16-d641-45e7-b64b-08de2297150c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943

On Wed, 2025-11-12 at 23:01 +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 11, 2025 at 08:29:48PM +0530, Siddharth Vadapalli wrote:
> > On 11/11/25 7:39 PM, Manivannan Sadhasivam wrote:
> > > On Tue, Nov 11, 2025 at 05:09:25PM +0530, Siddharth Vadapalli wrote:
> > > > On Tue, 2025-11-11 at 16:24 +0530, Manivannan Sadhasivam wrote:
> > > >=20
> > > > Hello Mani,
> > > >=20
> > > > > + Siddharth
> > > >=20
> > > > Thank you for notifying me of this.
> > > >=20
> > > > >=20
> > > > > On Tue, Nov 11, 2025 at 05:28:54PM +0800, kernel test robot wrote=
:
> > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git master
> > > > > > head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> > > > > > commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: A=
dd Sophgo SG2042 PCIe driver
> > > > > > date:   8 weeks ago
> > > > > > config: loongarch-randconfig-r113-20251110 (https://download.01=
.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
> > > > > > compiler: loongarch64-linux-gcc (GCC) 15.1.0
> > > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0da=
y-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)
> > > > > >=20
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just =
a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ=
7ls8Hm-lkp@intel.com/
> > > > > >=20
> > > > > > All errors (new ones prefixed by >>):
> > > > > >=20
> > > > > >     loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j7=
21e.o: in function `j721e_pcie_remove':
> > > > > > > > drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c=
): undefined reference to `cdns_pcie_host_disable'
> > > > > >=20
> > > > >=20
> > > > >  From .config:
> > > > >=20
> > > > > CONFIG_PCIE_CADENCE=3Dy
> > > > > CONFIG_PCIE_CADENCE_HOST=3Dm
> > > > > CONFIG_PCIE_CADENCE_EP=3Dy
> > > > > CONFIG_PCIE_CADENCE_PLAT=3Dy
> > > > > # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> > > > > CONFIG_PCIE_CADENCE_PLAT_EP=3Dy
> > > > > CONFIG_PCIE_SG2042_HOST=3Dm
> > > > > CONFIG_PCI_J721E=3Dy
> > > > > # CONFIG_PCI_J721E_HOST is not set
> > > > > CONFIG_PCI_J721E_EP=3Dy
> > > > >=20
> > > > > PCI_J721E selects PCIE_CADENCE_HOST only if PCI_J721E_HOST is sel=
ected,
> > > > > otherwise, it will not select it. This will take care of the depe=
ndency between
> > > > > PCI_J721E and PCIE_CADENCE_{HOST/EP}.
> > > > >=20
> > > > > But if PCIE_CADENCE_HOST is selected as a module by other drivers=
 like,
> > > > > CONFIG_PCIE_SG2042_HOST=3Dm, then if PCI_J721E is selected as a b=
uilt-in using
> > > > > CONFIG_PCI_J721E_EP=3Dy, it results in this build error as the bu=
ilt-in driver
> > > > > becomes dependent on a symbol from a loadable module.
> > > >=20
> > > > While I don't deny the build error associated with the above config=
, it is
> > > > an invalid config in the sense that the Glue drivers for two differ=
ent
> > > > devices are being enabled. This seems to be a generic issue wherein
> > > > multiple drivers tend to depend on a library/common driver. How is =
it
> > > > handled in such cases?
> > >=20
> > > AFAIK, the common library should be built-in to avoid issues like thi=
s.
> >=20
> > Ok. If that is the usual approach then I have no objections to it.
> >=20
> > >=20
> > > > Is there a notion of reordering configs to ensure that such build e=
rrors
> > > > are avoided?
> > > >=20
> > > > If PCI_J721E_EP was selected as 'y' before 'PCI_SG2042_HOST' being =
selected
> > > > as 'm', it would have resulted in 'PCIE_CADENCE_EP' being selected =
as 'y'
> > > > and this won't cause a build error even with 'PCI_SG2042_HOST' sele=
cted as
> > > > 'm'.
> > > >=20
> > > > >=20
> > > > > I guess, we should force PCIE_CADENCE_{HOST/EP} to be 'bool' as i=
t is getting
> > > > > selected by multiple drivers.
> > > >=20
> > > > This will defeat the purpose of the series that enabled loadable mo=
dule
> > > > support for the pci-j721e.c driver and the pcie-cadence-host/ep.c d=
rivers.
> > > >=20
> > >=20
> > > Your 'pci-j721e.c' can still be a loadable module, only the common li=
brary will
> > > be built-in, which is not that bad.
> >=20
> > Yes, this will work.
> >=20
> > Please let me know if you want me to post the patch to update
> > CONFIG_PCIE_CADENCE_{EP/HOST} to a bool.
> >=20
>=20
> Yes, please.

I have posted the patch at:
https://lore.kernel.org/r/20251113092721.3757387-1-s-vadapalli@ti.com

Regards,
Siddharth.

