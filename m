Return-Path: <linux-kernel+bounces-897568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C34C53911
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A9C5662B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C602733B961;
	Wed, 12 Nov 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HjLhsrHt"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678C2C08D0;
	Wed, 12 Nov 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961299; cv=fail; b=E9eR2AQVVrzCvKBczQVSxyvI7fKgRCSCOwKAG40IAGbhxcP4DL/eSU/IU9q+ySQ6m8+mxHAkvlqMMBBxzAbng+q5DbrNm8RAJq8LCOF6+ToDdWcDhxsTTzBAuWthwiM/RmHf0ldevZwMNk+7Vfg7TRH+p+NR5yqfFidc+aVqcxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961299; c=relaxed/simple;
	bh=r8dd4HhO9wrS5uaGlVCBiuERBweftZ94kmiPoUPIVs4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YysWUEecV+sPRVC1ti4xB/t6IWp66hIpuSfMb1OyM7s69L0WUNgKxck93BeJKz5L40xbQGyJEXGXKIx1VfL3bqtIZZGACd8NZqpu/bY6IzAP1ueBKVjEOvDZpZMlK4/680MEr7Hcr1V8NDFxCIMSlRAPAW+aPFRxd76CVWSjDAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HjLhsrHt; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBRfHujT1ChdfRdfGG3zb5QMkKhfC5fQ5xN9XiQtEjQyU19HQMq34rLFDw+Hci3vrCFqg99PVb5IJV/eUz4PFzj4qs9DY136uppYBbUoxNPwOajMHG2MVBGyykvckuhEg7qSNUqC2UtXvkZ+Z5oF3iirXq6cLVBA8ItORvO+W1KsWLdN8u+26RSGLo8Xekg0hHyhdI0YKHQoe/b1SiVKOexiOV2+NwOX8upSXZ9MJXPwaOyGcAQfAXUPvqiW0p32GRjRNbfmAdIUmL6T3DmUxq4twixG12fhZnT8nAuqUsPWxZcFFv6kHQeL370nls345mgXnA6IDNnthUcJBcDBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8vaRJNL0kQBYKykG5LS0MzykMS9bcKEz4mFbo1noJw=;
 b=awjgs5GeTJXsQ6ibkOLilTHsNP92ylO6SbyU/SR1qqLMMd7+s7opIeQNmyi35aAwV+jvXh5/IRQD6KwfVHMLbq2OiV823AsFHNU+YA8NPXJHriczdNEqeN26sKj00lsfF/5JwUl8zHDr/kPfixfd+s8B84EqGevd+F/0RO84nkqcLHJ436WTBBHu837AaeqU2r0F1DQtjZZ4dC2a5kQ4TzqPwsFq/G5N3IN7OhhOd4PWMMBdXdkJoYA2YCKKR42EjvcmpuxDnH6VErVWAZrlAuNGtgMVKIsbDRHqqBQaOU9yvq6bAhbNGYzyh8ExNsW8Ek/ZQacWje8x7nGR/BAWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vaRJNL0kQBYKykG5LS0MzykMS9bcKEz4mFbo1noJw=;
 b=HjLhsrHtqbW/U+9VGlbHS/Ni9W4lXuOQPhVzpCXjcRX+qIHluuniMKCQkYZpqwYFt9lAraqEUtVLCONAM0y9Y+ggLdtPEIaOEf6ZUR1E2jNm8o5+oy/nhlk3isesG0s2Ett4MvViSH8vmrmhy9e9JlQJHV1FrsoLguqR9lk5eAc=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by LV3PR10MB8130.namprd10.prod.outlook.com (2603:10b6:408:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:28:13 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::ec) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 15:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:28:13 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:28:07 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 09:28:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 09:28:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACFS6Y22918843;
	Wed, 12 Nov 2025 09:28:06 -0600
Date: Wed, 12 Nov 2025 09:28:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH v3] dt-bindings: arm: keystone: add boot_* mboxes to
 ti,sci
Message-ID: <20251112152806.zsinwwzaht2ws2wh@headpiece>
References: <20251112-k3_syscon_add_boot_mailboxes-v3-1-66155a4236dc@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112-k3_syscon_add_boot_mailboxes-v3-1-66155a4236dc@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|LV3PR10MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 57be9dd4-24b9-4295-d145-08de22001809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcn7zlLONOCAghSixwAhgMVsaRv8nSAFxL0gmg2mf5BZoIECq2QRAxdLwL4c?=
 =?us-ascii?Q?u72VzE7ZvbDYj7FI6LWFvS9Vt+kFXUXy6w4szCCx7fJeX4mlqa3jimWQ2qPz?=
 =?us-ascii?Q?iYyRqq28QCIER9fXHbgaNnOd25OG4t6dTaU6wNVWHEoWlh1LV/a9TYDdDD38?=
 =?us-ascii?Q?Veu7ZHQNPdg3mkmSvMHytJTIwOZRLU8WH+nN166Uoht3kezh08SVpFW4H8bh?=
 =?us-ascii?Q?OhVI/ZepVGpJPflloqzRsHh5nc6i3ymsZ8/vw34PcvdV3YnlyJ5KasiPv8C8?=
 =?us-ascii?Q?0OyUWzvkZ3bwnyCkQ+3kdzSYTbXbo6t4kpzKCHRqkpHQSIDQd2PpqPjfpEt5?=
 =?us-ascii?Q?EW60GsX33nEuA7QTbhNmuhnIWx4mwQ2QN9N9ijDlHuPe7TJ1uhQnHEoTDPOr?=
 =?us-ascii?Q?y6s/rLK0yUfNn37lBUMk7Xno7P32z4ueh3R28oAMM/lY1dLyK754/UFytvGq?=
 =?us-ascii?Q?qTAXgqmLIyX/57H0avmHsnxiO5fCdx2BPbo3tv3cPk4U0PNjX8RwAL7WVOra?=
 =?us-ascii?Q?wnpeyTiW+o2b3ssc6Mf6U4mU7tfScqZ3TV5eCV9ely0geTY9iWy3vFb8gjG6?=
 =?us-ascii?Q?YHGk5r6Mtd25z9PMuD9zc8H/EphZQ1+hww/IOes2FOV0+t8GUfK6f5zvLibz?=
 =?us-ascii?Q?WqzSOqZlVlkC1XgajQc6QIoPvoZxQN89Tl6U5avVGzUUMRzY3N+9NnHRnELq?=
 =?us-ascii?Q?r2Hphd2iTMXcIIeDggW8wSXa6/JWnvPTWifi+hccXnDTUACeAubVCmP/kYLX?=
 =?us-ascii?Q?AAH5Aw7f9W+en/3xS+lj/eUxqTp9WAVz+6QL3g9LjObCDaBS1uOVWbDsmxgA?=
 =?us-ascii?Q?3VOzVv3FQ7s+aBw5km8oSp/+nQ/uLXGQX8PL4ezFmZj89V7y1U1e/6721hkQ?=
 =?us-ascii?Q?UTuOdyUgNRTrDfMlPEsv6HoD3TiALTzCSFVfwlYdhnH84reuwzhhQ0qoJ0/o?=
 =?us-ascii?Q?rEUPFsZGhfMbHGzwWR7FTY36Yd2HNBmw+BFIC7fUy9+ypC6ca3aKVYA87Ork?=
 =?us-ascii?Q?rFAIXTb/QiHKwSRe+aCn6bWbTb4MuFY8D7CZ49Pu9h37JmMAKaUW9Nbf8D0d?=
 =?us-ascii?Q?pn53eP3iTv4OTzzV0vzqmY3vnMpZD3CwpHvnZu8ldjEPpBUK5WRWr79FQitW?=
 =?us-ascii?Q?5cp/XWMQIIhBb7K3TXXua0VvW9ebWEfeCAo8RYLXbE2As9lhiIMVRglvx8Pf?=
 =?us-ascii?Q?0CdOLOkXwjWY+mArsD0+XLejtlH85M9yCVE3tDvE494iwEAs11y9rExH6seD?=
 =?us-ascii?Q?xbRoksaVuuE1WXbu/bJoFTUGg+nwDOsREkFGPEBTMUy/HaLERjC7EHTMraGF?=
 =?us-ascii?Q?QNfBCsGLJh1wtvcDWjdjNl7CfFWIXPyCJ+WPMaLY86oyw+kQ6VkOpkIWJ6af?=
 =?us-ascii?Q?cpkARnP9e0k0Ddd1aBWdVOdZIHWBQkuxvvv9DRUrfZuPbsKfBj4vR8LvbF+6?=
 =?us-ascii?Q?YIC37udLxgfHr4vonsz3CL9A5npBdEUe/t/+HxZ32ANawtde4oKVT7CKRgcE?=
 =?us-ascii?Q?MciRw/ihYtzTCl/3mfgL8i6qlu71ArZewWMQI7NlCK9312mITTfypCsL8JIv?=
 =?us-ascii?Q?woo8CVeRm73waKlODE4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:28:13.0609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57be9dd4-24b9-4295-d145-08de22001809
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8130

On 15:54-20251112, Anshul Dalal wrote:
> The bootloader on K3 devices makes use of mailboxes as per the ROM spec
> which might be different than one's available to the kernel (firmware
> spec).
> 
> Therefore, this patch adds the missing mailbox entries to the DT binding
> to represent the mailboxes exposed by the hardware during boot for the
> purpose of loading the firmware.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v3:
> - Drop [1/2] of the last patch series
> - Update existing example with boot_* mailboxes instead of adding a new one
> - Link to v2: https://lore.kernel.org/r/20251112-k3_syscon_add_boot_mailboxes-v2-0-aebc1e47b391@ti.com
> 
> Changes in v2:
> - Remove maxItems entry
> - Remove RFC tag from patch (added by mistake in v1)
> - Document the new mailboxes in mboxes instead of mbox-names
> - Provide example with all the mailboxes set
> - Update commit title to have "ti,sci"
> - Split into two patches
> - Link to v1: https://lore.kernel.org/r/20251111-k3_syscon_add_boot_mailboxes-v1-1-529a27f21076@ti.com
> ---
>  .../devicetree/bindings/arm/keystone/ti,sci.yaml      | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index 25a2b42105e541cb3c8ad12a0dfec1af038fa907..be8a5b2b051b441884795059c70892910d981130 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -51,15 +51,27 @@ properties:
>      minItems: 1
>  
>    mbox-names:
> +    minItems: 2
>      description: |
>        Specifies the mailboxes used to communicate with TI-SCI Controller
>        made available from TI-SCI controller.
>      items:
>        - const: rx
>        - const: tx
> +      - const: notify
> +      - const: boot_rx
> +      - const: boot_tx
> +      - const: boot_notify

Sorry for joining the party late.. just saw the thread while happening
to glance at the pending list..

k2g does not use boot_* mboxes, the load mechanism doesn't involve
ROM talking over mboxes, we load the pmmc on that SoC! ti,am654-sci
onwards does. This would be a good case for adding a conditional
property, IMHO. That said majority of the K3 dts entries still use
k2g-sci for k3 (#facepalm.. i should have caught it, but missed).. but
that cleanup is for follow on patches that could fix.. driver seems to
be able to handle the same.

>  
>    mboxes:
>      minItems: 2
> +    items:
> +      - description: RX thread
> +      - description: TX thread
> +      - description: Notify thread
> +      - description: boot stage RX thread
> +      - description: boot stage TX thread
> +      - description: boot stage Notify thread
>  
>    ti,host-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -90,9 +102,10 @@ examples:
>    - |
>      pmmc: system-controller@2921800 {
>        compatible = "ti,k2g-sci";
> -      mbox-names = "rx", "tx";
> -      mboxes = <&msgmgr 5 2>,
> -               <&msgmgr 0 0>;
> +      mbox-names = "rx", "tx", "notify", "boot_rx", "boot_tx", "boot_notify";
> +      mboxes = <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>,
> +        <&secure_proxy_mcu 5>, <&secure_proxy_mcu 4>,
> +        <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;


>        reg-names = "debug_messages";
>        reg = <0x02921800 0x800>;
>      };
> 
> ---
> base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> change-id: 20251105-k3_syscon_add_boot_mailboxes-8452bdd98962
> 
> Best regards,
> -- 
> Anshul Dalal <anshuld@ti.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

