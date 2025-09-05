Return-Path: <linux-kernel+bounces-802711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E8B455DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A435C7C7A89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DC34AB19;
	Fri,  5 Sep 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="M5YL6STW";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="M5YL6STW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022089.outbound.protection.outlook.com [52.101.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D6343D8E;
	Fri,  5 Sep 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.89
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070671; cv=fail; b=hU63ZvQfneq8uGJnaZB47P/z0UGODPx6jEv+V7Bx2V+XaAXTLyiuUGeNFIUGCX0eL+M3G3NCq1I+sQ5gsJoBHNVd7EsXpL9SuICILleEtKvErg0y95k/fDRsLEcMZk9DFif4z6fd0ZC89cwmd/P2nEBDkWvIvWmrloGn+dz9vKM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070671; c=relaxed/simple;
	bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFAKv9uzyxxpk6a/wGEcYwiCWthwSRwrGZ59eNkRU1op1jeweRPZKHwYXK5Qaz7YhkdG1fimOmO7HfKaz7/Ovc9750CgPQwdK420vCCK2//wrr6Zu/gN3WWNYcOxCN6v0oPBvTf5BtRVbiIw7ugKKuLX2evf5GC4OavUfEb9t68=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=M5YL6STW; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=M5YL6STW; arc=fail smtp.client-ip=52.101.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wKjrxJ9Eg5uV6B5aTIGDNpskm9AvhhT7fYdewcaO8uKXXwhqpNzRxhy+P9XSgrsIqctNY0GZh32j2DRVTjhJVGCEEjF2QVGx3azecm6WnnV7dX5go7iI3XL2rFutKquBsDWkbaj85ZkBGWaWShOzVIZpY6K7zK3ML+PNy0xDAgmGOqmFQIM4zey9L9IGBuTVkTButc3tGx8BKfZBK0xRvWP6oKQkIKYi0wkP0ZEWdCAVjxHMXuucpIXMPo+H0Rzq5CHmNpQcKCgGIOSCGnAr1kaYKg79JyKb95LzLBz3fCSrUiG72zOlXeintwGjKrxRyRunvKCZPq96Ca/JQWp4pw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
 b=xAhjLZHvbIF5zrQ4p8g78hP0VGdFlqpqWkvr80guvmqjw1POTR0hLgkbOtfQfwt2RKk6BAhZzjAAP0UGBjny4fQE0GSrxyKAoDWUMKdWZFuiZ50aHFBkzGNdHW1QxB3Dc+8KJ3qfUhzP6+FWh0Vt/zkeNb4FxpwFVnxT8BkMjqcKkL7yvu8B7B8tDHyWBFU51X4S5co72f9UcA0MXEMySKvC5i9yKeWbb1fCAY8ABRoQCGM3oY7Ek5i67C3vEO/K1QJTLTfYhm769CMNWRGmYFe1ALgQf3lIfnnB9V7ceNQdr9yBUC6xywMKJ4ePpXFDu4lCRZS+L4KT0iY7guc31Q==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
 b=M5YL6STWdKam+RpCCrDyhoHH1+Kxy9hEFD1wP3iTYHbO+w4eoe0ISW8qGDiLQeDpyZXLgN8Ko1J5/hyXV/AN5QdFm7ys5gqbBzh+/xzl8myHH59o/wT0x9KqfUwInB1Sg9GiijKf3wK8KK2O1X8APlL47Qp/WPk4wKeVlRoPDAA=
Received: from DU7P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::20)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 11:11:06 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::36) by DU7P189CA0004.outlook.office365.com
 (2603:10a6:10:552::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 11:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via
 Frontend Transport; Fri, 5 Sep 2025 11:11:04 +0000
Received: from emails-983278-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-124.eu-west-1.compute.internal [10.20.6.124])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 58E9D8095F;
	Fri,  5 Sep 2025 11:11:04 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757070664; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
 b=UPOHK+uLPWDGXngyToPsd/CPn14y2SHC+k7cYAbLDDrd7Gx5Qco6AYNtpGMGlr4Dq4WFp
 MiCFgHZ+inlOOQHpToxaKaUXxBiI9nMRgJcgI3Eio/RdPVYO9fhEAVewuHASsPTZxSMyDiT
 Zv1xldD1mlOPHUmyVyALQ1a8AX9xk/s=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757070664;
 b=d6iZU29S4f/XM8g3lgqd77u/RI88lKW7Q10zIwMc8PaFBF9d7eEQfdDQ3f/jJN2I8p3AV
 zfyKogM+yiC0TnDVPFvR8CmZxqLRDiSVIJsMl350vm6EPC3lnQoIoK4J4UlD41Gxe+XCIhZ
 7yPdSowxR8b7nbE9MX0kfX3T+McG9uY=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdCdkf2l5HnQNbzk0AiJFT78dMlQoBquzfgA3ieJ3Krb68bWrkVNljHx0vuPHe6hq36q/j76Kc1+4+pNVFhpp/BuoLPlHq3p+vntYFzI7qk47+AhnoBORw9pgM8Z20wrxMLLnKBeNaZOJMpNE6Ykd2MZz+APWMnOroeP0FOCoBq8g7xGoxsQcb8iqw/gmuFYY3VljC0IQVVzYpt5rRsGCoyuoMEfZWoNsr7aATR2lhY+pdDU/OHnX5ZT02c0BfHMUlUp+kILHpueXg5AvybAvX3LhB5hWnQzjng/Faj+2c1c1qOYNhKrGd8A+8Dva3Bip3AD8TI4Nudo9N+n/pGcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
 b=lgwWaxlRbWeTPxu4Rh86qdZYvob3pjTH6Nr3yU6PTm/0TjKm8XwqWkjDqOzAbrKoo8SPusIc9onuh41bO9fREsYqABt95IPoXPH6KBwhkAsi60iw/8FeHA+2A9Qb39DV8yo0CbgVRCbqB4W/pmV90ar1k/L6HG24TnN6fBrKif8pRtvQjV3wwW6AK43r/7QoTx96HViTY+5IK56YPRKMLpyVeF5lzOJ82b3cGIxWSvveQ9BgTPnnUcfOSIZ9uLAqSIA8tqEKyAwOXWk8Dn6b2Y2BClMXe+KmEFR37rzM8nkTc3FHJW4d3s2U1CTAFlyqmU0kc4DdRadhhWtsJJ/Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C+Qq4zWqglasHxX3Alp2KFW90yLkn2Zj3f9yUgTelw=;
 b=M5YL6STWdKam+RpCCrDyhoHH1+Kxy9hEFD1wP3iTYHbO+w4eoe0ISW8qGDiLQeDpyZXLgN8Ko1J5/hyXV/AN5QdFm7ys5gqbBzh+/xzl8myHH59o/wT0x9KqfUwInB1Sg9GiijKf3wK8KK2O1X8APlL47Qp/WPk4wKeVlRoPDAA=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 11:10:54 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 11:10:54 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Conor Dooley <conor@kernel.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcHlLIJtm9dj7MPUeeCk+9PJYwF7SEbteA
Date: Fri, 5 Sep 2025 11:10:53 +0000
Message-ID: <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
 <20250905104921.7grpgloevlifa3kj@skbuf>
In-Reply-To: <20250905104921.7grpgloevlifa3kj@skbuf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AM7PR04MB7109:EE_|DU2PEPF0001E9BF:EE_|DB8PR04MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2ce542-106b-44f4-059a-08ddec6ce7c4
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MEVKd0FLVHVTSzFwT3ZLUkI2NXJ4U2o4Q3VKcHVYS01LUzhFQ2JGZmo4d2pC?=
 =?utf-8?B?Kzh4b1ZNWk9aYTZjSGtaNGdWK1BsWTJWeXR5dHUzMko2dU9NZ0pBcnFWaVQr?=
 =?utf-8?B?OW9WY3AxcEhSRWFMYnFQdEVJeXJad3JmYXFseUM0aEFtWmsrZmlEdFNqcnI0?=
 =?utf-8?B?RzNvZCtoWlpwcllCUmgzVGNlY1ZLcTdaNHJzcEh0Y0kyUXBENS9SN2pjSmlt?=
 =?utf-8?B?NkNrTndIVmxrdmdLZHFKY09INytrR3lsSFhTWHdtKy9vU0lpSFJ6bTllcTZX?=
 =?utf-8?B?VjBoaUxYOUhSdjZ3ZDJ4eWEybGRvV3NEMUxHbC9WVDB4c3NTVEhjdGRJTzUy?=
 =?utf-8?B?YW4vc0NJNmlxMFdvSXpPZ2ozdUdRVEt1QyttcEI1bmhhSDVZcmgwTDFWUHI5?=
 =?utf-8?B?dnA5Q3AzNTh0YnFoNjNqa2hkajBLNXJZT2lpU2o4RnZiRzZtQURVdzlWS1N3?=
 =?utf-8?B?a2JRZEVZb0Zxb3NvN2E1ZHZtc2ZPdWpZOGRnNEMzais3YVZsTDZ4eUtRMDVx?=
 =?utf-8?B?VkZFbFlrTUZ4UVVEc0xoL21BQ2ZUSkFkNHFpdWF4ZmRta21hcmQ0Z09EaHVz?=
 =?utf-8?B?bmhQbTNOVS9SMXkzdVc1Zzh1aTZBQmlCNTRmaCtMREV5YnZqcllQN3h3dEFz?=
 =?utf-8?B?eWNTM245aEs4Y1VIY0hQcXJJM3QyWDJxeDdnOENDYzVFZzF0S2thRzZIUnFL?=
 =?utf-8?B?dWNOVk9uL2hIL0RaU1RoeUpBMVk0U2crZW9kZkVvZmhJc2FQK2xOb0pBVk90?=
 =?utf-8?B?NHMwbnFkVkRYWEpNelI2T05iS2JQamtnWXkzU2NWamc0Q1ByV3FZV1ZiaGtu?=
 =?utf-8?B?RGlhbE1sYmFtc0dzME11c2phTVZub2FyYzFpeGFLZE5SdlU3bjNXTEJzbUdw?=
 =?utf-8?B?RFB6QmtCZ3U1MEREMDRrV2gxdlBaNWJQWWJFWURCeHMzdXBDYjhvaU1kaXd6?=
 =?utf-8?B?U3NDUjJyM2pFTTdHcGpKWW53ZUhwbnVYNFpjMG45WWhlL0RXbXh5MjMyS05F?=
 =?utf-8?B?eS9EMEZCaHBLQnZRbHpSeTlRMnJRT1RJSlZmMDBMT21zTWl5UlRCdWc0TldG?=
 =?utf-8?B?ckRHUnk5dFhvMm5YTmd6ZXhYT1dsYWFJVCt3VkxJM1RDSS90R0p2T3U1bkdJ?=
 =?utf-8?B?akE2aXRDWUNFRXJQTFNydU1DMGxtYXh0TjAzQ3Jqa1B0Z1pDeVU0Y2daYXFi?=
 =?utf-8?B?UGFOT0VFNU1sUXUrSWhLbWF3ZW5KQ00zMWZNdVhzOHhxd0FjN1lZL2xKaUU2?=
 =?utf-8?B?WUVpRDVvOWtnVzEzYTFCN0lZWEdNNjJrVnBlTlZXdkg5NVNWNnFaYWthM0tL?=
 =?utf-8?B?M2YzR1VBVlNSWTJVVUV1K1V4d1VMZit2c3FxOXFWVlR4R3h0SzJwWGh4NHFO?=
 =?utf-8?B?M0EyUXNkL2JlMzUyNlZraUtwcll4aVZGN2llc2lmQ2Y5QWdGN092ZVBuRUov?=
 =?utf-8?B?ZmFleStxQ3RGSStYNnk0UURGVnNxck8zUnZIU3FEVEgwRWoyVldBdXh3WW8z?=
 =?utf-8?B?M25yb2phSGg5UTlGRXV1RFhlOTdvVXVic3h0b2FDZjlLV1JWN2lsWW5BWkJD?=
 =?utf-8?B?aTlDYTBSbVpUMnJlVksrUGpuTkU4UlREejA1WVVkR05LSGJmRjJhRTduV0E2?=
 =?utf-8?B?ZUNJM29QNHVuVllaSWNOWWh0OTU3aVF2c0I4bmhKN3grbE9QSC9UV3E0QWpo?=
 =?utf-8?B?aVB5emlTWnF3VGFqWFJNaDBFdHdQUHJzSysvRDVLMjFlM2plZDFXa0hzMm9v?=
 =?utf-8?B?WnhKZ1hhcGQwU2lGUWFKaVBIVUV3UmlSZjJQd0tZOUMvZm01NmpNT1lTc1JF?=
 =?utf-8?B?OU81enBML2xIMkFSMWc5MUtXNGJLbnI1dlZQaHo5clF3K3pjNEwxVkZyZFNP?=
 =?utf-8?B?em5LMkp6TW1WeGhuUGloa1pNTmFFTW1kZUkxTWNIU25IZDJJdy8vbk5ReWZJ?=
 =?utf-8?B?S3RXMCttQndWb2lBYnRycVVvUG15eDlkTHZ3SUNrL2lRcWI3OHNWK0tuTDRt?=
 =?utf-8?B?R3R1Tzdoa3ZRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29229394ADB3847AA424AA7ECE1A762@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 6c7d01063ede4f3694a4f24a2d9e09eb:solidrun,office365_emails,sent,inline:0346c0e52b01d855d83c1b7ecef118bc
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	61e6e663-2791-4f69-e044-08ddec6ce170
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|35042699022|376014|7416014|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXFGOFFla3Q0VkZnb2hiQUxNRW8yazdiTW1TMnFwVWhWSUlQT2UxcytWM3Fn?=
 =?utf-8?B?R3hUTWN4WlFJZ0FVZDIyNFM4SmkyOHFWYjlXOTNCRnlmZTdZMlFkdG1Gc0Ux?=
 =?utf-8?B?Q0V5WmlJTWJkd1RQd2hjTEcrM0FvZ1U0ME4rdXpYdThmSHg0MU9KQzY5MVQy?=
 =?utf-8?B?TnNCenhwUUF1WmpwTWdEb0ZtNjRkVkcvYk15aXkvZlhrd0xhR0hURGRrY3c3?=
 =?utf-8?B?aXBOZ0c0OFZQaE56TWFwa3JOaGlIWEppM0pYY1lTQUhZalNKNGUyTGhpVzNC?=
 =?utf-8?B?ZVBlRG9ZZkVBYzNYNTlsMkNWckx1ZVBCNjl5SXFuMUNId0oza2pseHI1R0po?=
 =?utf-8?B?ekhNNmd6RlRkRzhMZjFjU1A5Z3hYNnQ3RkNzTTB5MXI5Qk9NWndxcGtvVkdB?=
 =?utf-8?B?cDhsbVE3SjVxc2RIQjVkYXhibDNFU1dUQ3pMclhpcVR4U2FCeUNOYi9QVGNh?=
 =?utf-8?B?QS8rdTNoWTZpYlVSbnR3T1FrMUNybXpNUUEva0dmQ2xFbGRJeVc5RmswVi9P?=
 =?utf-8?B?VDZMK2N2K3lBR1p2dW9VKzR0YzBwdEtPMjU3NU51aTY0dUtmOW9KMVdFZFor?=
 =?utf-8?B?ajJnWitkaW5qdWxJOVFmbHVaUEo3cTdyR3piSnkrUmQ1d0NQQ05ETmVDNWF4?=
 =?utf-8?B?TytqenZGbm9ZcFRPWlVXTy9aUkl3QjlWa0hWeTlFanl5Q01NYmFmWjg0cFM1?=
 =?utf-8?B?TDg3dkZNRElqOU03MGprQkFXMHp2MjRpNUdybXBQeVoyNWVQbUl6c1hFeGNs?=
 =?utf-8?B?aXUrT0o0aXhJRFlEMG5aRHYrRjU5NG9QalFOU0lXUDdTR2M0Y240eHQ1bEVS?=
 =?utf-8?B?bmNFcVg1cGpOTmdBRFkwSnpGbnlTZ0VPUE9sSS9KN1hHaEZ2YnlnWnB6Wk1p?=
 =?utf-8?B?VHRrTWc2SytCekNYbHE4MzAyRkVoMGtBeHBUV1RLVnNTOHhnWU1oOUNxSmhQ?=
 =?utf-8?B?b3pkWGNvM05ESmdmMnpxYVFkaFpjazlFbW1VMmxzYmlkOGUxNHlYQUxnYkdN?=
 =?utf-8?B?RUNldFEySnFEajhnbjdXWFdRRyt3REhyRThsRmRQTEt0VHF5UnRYQTF5cW1z?=
 =?utf-8?B?Qk1xamtUSkRvem55WXZFUzVyT2dxVk9GR2lFcHR2c2dRVkxDNnpFbllhNVpE?=
 =?utf-8?B?WktzVGtmRno3czBmWG15L0lzWnhwdElUc2I4eDdZUTNmMEhKRDlWZXFXMXpi?=
 =?utf-8?B?bGVIeTNNNjFsZnE3VVNhcy8zY3ZMQjUwVEord3lhRi9FSkRVdVY4YVJJcUtm?=
 =?utf-8?B?R1BkWTVVL0JqWWEyY0M3UTZnMTBxaGhlekFpKzZ0UVJ5QzhLZXZyeEU1RTZK?=
 =?utf-8?B?M3dMdkVySytYRVZ6Q2pZZkFDVkNHMGhJazNaUjNPMlE2eHNMaDArSjNRVzQy?=
 =?utf-8?B?ME00cW5Ld3oyV3laRDZIY21sYjBMT1ZrTktDckVFK1A2SzQ3RktqTm1kQUJa?=
 =?utf-8?B?MG1oeFZTOElIcUpVZHFWcmZ3M2xqcldWcm1rRXU4NDV0KzJCaks3c1hOcExI?=
 =?utf-8?B?bnU0V25PTzA5ZXM2MWxIbHlqQXFjQkM5VVZiaUp3RmlFR2F3SkI3MWlobGE1?=
 =?utf-8?B?ekZOdm9Obm5oRXprakRJVlRaNjdJYURvVHNaSm40YzZ3VXhUOXZuRTBRbW80?=
 =?utf-8?B?Mzk4bW1KQVpoZGR5VUVkN3kza0ZQWDB4czVZa3E3TnRad0dDbUNvRGxINzF2?=
 =?utf-8?B?M0h4THgvMTFGVStTMzhMTitkWFRWZ3ZWYm5RZkY1Qk9qS0NGelRGd053M05t?=
 =?utf-8?B?cHhDUHduZ3FFVklyUlVQTTRXOGFKVU5IY0VSWFZIUW1VOCtxa0YxZ0tGYTdm?=
 =?utf-8?B?ZE9sODZ3VHFsSFRlUFo2OS83MmgyQkkrRGhsVnp4YzJISXRlK0ltd201RkJz?=
 =?utf-8?B?TmxKc0xZamM0Q2xGNUJFeThMQlkvRDcycklyRFlBL0ZvKytJZXBrRDBzUEc1?=
 =?utf-8?B?NXVGOXlJRTV2T3piYUFweHNMUXJMRkh3SCtYcWxzQUpYUlJZVDNLN01HSTNm?=
 =?utf-8?B?dUQwWFlrRXFVclhtSm9OR3B2YmRqSXdIVkwrekxjbkZ2cHFNOVVtSFNOUDFx?=
 =?utf-8?Q?CM7Aq1?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(376014)(7416014)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 11:11:04.5050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2ce542-106b-44f4-059a-08ddec6ce7c4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193

SGkgVmxhZGltaXIsDQoNClRoYW5rcyBmb3IgYWRkaW5nIG1lIGluIENDIQ0KDQpBbSAwNS4wOS4y
NSB1bSAxMjo0OSBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4gT24gVGh1LCBTZXAgMDQsIDIw
MjUgYXQgMDg6MjI6MTZQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gT24gVGh1LCBT
ZXAgMDQsIDIwMjUgYXQgMDY6NDQ6MDFQTSArMDMwMCwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0K
Pj4+IEdvaW5nIGJ5IHRoZSBnZW5lcmljICJmc2wsbHlueC0yOGciIGNvbXBhdGlibGUgc3RyaW5n
IGFuZCBleHBlY3RpbmcgYWxsDQo+Pj4gU2VyRGVzIGluc3RhbnRpYXRpb25zIG9uIGFsbCBTb0Nz
IHRvIHVzZSBpdCB3YXMgYSBtaXN0YWtlLg0KPj4+DQo+Pj4gVGhleSBhbGwgc2hhcmUgdGhlIHNh
bWUgcmVnaXN0ZXIgbWFwLCBzdXJlLCBidXQgdGhlIG51bWJlciBvZiBwcm90b2NvbA0KPj4+IGNv
bnZlcnRlcnMgYW5kIGxhbmVzIHdoaWNoIGFyZSBpbnN0YW50aWF0ZWQgZGlmZmVycyBpbiBhIHdh
eSB0aGF0IGlzbid0DQo+Pj4gZGV0ZWN0YWJsZSBieSBzb2Z0d2FyZS4NCklmIHRoZSBzZXJkZXMg
bm9kZSBoYWQgYSBwaHkgc3ViLW5vZGUgZm9yIGVhY2ggbGFuZSwgdGhlbiBzb2Z0d2FyZQ0KY291
bGQgZGVzY3JpYmUgZWFjaCBsYW5lIGluZGl2aWR1YWxseSAvIG9taXQgNCBsYW5lcyBvbiBseDIx
NjIgc2QxIGUuZy4uDQoNClRoaXMgY29tZXMgd2l0aCBhZGRlZCBiZW5lZml0IHRoYXQgcGVyaGFw
cyBpbiB0aGUgZnV0dXJlIHdlIGNhbiB1c2UNCnRoZW0gdG8gZGVzY3JpYmUgYm9hcmQtc3BlY2lm
aWMgZXF1YWxpemF0aW9uIHBhcmFtZXRlcnMuDQoNClRoZSBjdXJyZW50IGRyaXZlciB1c2VzIGhh
cmRjb2RlZCBkZWZhdWx0cyB0aGF0IG1heSBiZSBhcHByb3ByaWF0ZQ0KZm9yIHNvbWUgbnhwIGV2
YWx1YXRpb24gYm9hcmRzIG9ubHkuDQoNCj4+PiBTbyBkaXN0aW5ndWlzaCB0aGVtIGJ5IGNvbXBh
dGlibGUgc3RyaW5ncy4NCj4+PiBBdCB0aGUgc2FtZSB0aW1lLCBrZWVwICJmc2wsbHlueC0yOGci
IGFzIGJhY2t1cC4NCj4+IFdoeSBrZWVwIHRoZSBiYWNrdXA/IERvZXNuJ3Qgc291bmQgbGlrZSB5
b3UgY2FuIHVzZSBpdCBmb3IgYW55dGhpbmcsDQo+PiB1bmxlc3MgdGhlcmUncyBzb21lIG1pbmlt
dW0gc2V0IG9mIGNhcGFiaWxpdGllcyB0aGF0IGFsbCBkZXZpY2VzDQo+PiBzdXBwb3J0LiBJZiB0
aGF0J3Mgbm90IHRoZSBjYXNlLCBzaG91bGQgaXQgbm90IGp1c3QgYmUgbWFya2VkIGRlcHJlY2F0
ZWQNCj4+IG9yIHJlbW92ZWQgZW50aXJlbHk/DQo+IFRvIGJlIGhvbmVzdCwgSSBjb3VsZCB1c2Ug
c29tZSBndWlkYW5jZSBvbiB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuDQo+DQo+IFdoZW4g
SSBoYWQgd3JpdHRlbiB0aGlzIHBhdGNoIGRvd25zdHJlYW0sIGx4MjE2MGEuZHRzaSBvbmx5IGhh
ZCBzZXJkZXNfMQ0KPiBkZWZpbmVkLCBhcyAiZnNsLGx5bngtMjhnIiwgYW5kIHRoaXMgcGF0Y2gg
bWFkZSBtb3JlIHNlbnNlLiBLZWVwDQo+ICJmc2wsbHlueC0yOGciIGFzIGEgc3lub255bSBmb3Ig
ImZzbCxseDIxNjBhLXNlcmRlczEiLCBzbyB0aGF0IG5ldw0KPiBkZXZpY2UgdHJlZXMgc3RpbGwg
d29yayB3aXRoIG9sZCBrZXJuZWxzIChhcyBpcyBzb21ldGltZXMgbmVlZGVkIGR1cmluZw0KPiAn
Z2l0IGJpc2VjdCcsIGV0YyksIGZvciBzb21lIGRlZmluaXRpb24gb2YgdGhlIHdvcmQgIndvcmsi
IChtb3JlIG9mdGVuDQo+IHRoYW4gbm90LCB1bnNhdGlzZmFjdG9yeSAtIGZvciBleGFtcGxlLCBm
d19kZXZsaW5rIGJsb2NrcyBwcm9iaW5nIHRoZSBQSFkNCj4gY29uc3VtZXIgZHJpdmVyIGlmIHRo
ZSBQSFkgZHJpdmVyIGRvZXNuJ3QgZXhpc3QsIGJ1dCB0aGUgJ3BoeXMnIHByb3BlcnR5DQo+IGV4
aXN0cyBpbiB0aGUgZGV2aWNlIHRyZWUpLg0KPg0KPiBVbmJla25vd25zdCB0byBtZSwgY29tbWl0
IDJmMjkwMDE3NmI0NCAoImFybTY0OiBkdHM6IGx4MjE2MGE6IGRlc2NyaWJlDQo+IHRoZSBTZXJE
ZXMgYmxvY2sgIzIiKSBjYW1lIGFuZCBkZWZpbmVkIHRoZSBzZWNvbmQgU2VyRGVzIGFsc28gd2l0
aA0KPiAiZnNsLGx5bngtMjhnIi4NCj4NCj4gVGhlIHNlY29uZCBTZXJEZXMgaXMgbGVzcyBjYXBh
YmxlIHRoYW4gdGhlIGZpcnN0IG9uZSwgc28gdGhlIHNhbWUNCj4gZGV2ZWxvcGVyIHRoZW4gc3Rh
cnRlZCBiYXR0bGluZyB3aXRoIHRoZSBmYWN0IHRoYXQgdGhlIGRyaXZlciBkb2Vzbid0DQo+IGtu
b3cgdGhhdCBzZXJkZXNfMiBkb2Vzbid0IHN1cHBvcnQgc29tZSBwcm90b2NvbHMsIGFuZCB3cm90
ZSBzb21lDQo+IHBhdGNoZXMgbGlrZSA5YmVmODRkMzBmMWYgKCJwaHk6IGx5bngtMjhnOiBjaGVj
ayByZXR1cm4gdmFsdWUgd2hlbg0KPiBjYWxsaW5nIGx5bnhfMjhnX3BsbF9nZXQiKSwgd2hpY2gg
aW4gYWxsIGxpa2VsaWhvb2QgY291bGQgaGF2ZSBiZWVuDQo+IGF2b2lkZWQgdXNpbmcgYSBzcGVj
aWZpYyBjb21wYXRpYmxlIHN0cmluZy4NCj4gVGhlIGx5bnhfaW5mbyA6Og0KSW4gdXBzdHJlYW0g
bXkgcGF0Y2ggZml4ZXMgbm90aGluZywgaXQgYWRkZWQgYSByZXR1cm4gdmFsdWUgY2hlY2sNCmZv
ciBhIGZ1bmN0aW9uIGNhbGwgdGhhdCBjYW4gaW5kZWVkIHJldHVybiBOVUxMLg0KDQpNeSBiYXR0
bGUgd2FzIGEgZGlmZmVyZW50IG9uZSwgdW5yZWxhdGVkIHRvIHZhcnlpbmcgc2VyZGVzIGJsb2Nr
IGZlYXR1cmVzDQooSSBjbGFpbSBpdCBjYW4gYWxzbyBoYXBwZW4gd2l0aCBzYW1lIHBoeSBvbiBz
ZXJkZXMgYmxvY2sgMSk6DQoNCkkgZm91bmQgdGhhdCB0aGUgY29tYmluYXRpb24gb2YgTWFydmVs
bCAxMEcgcGh5IGRyaXZlciwgcGNzLCBzZXJkZXMgYW5kIGRwYWEyDQpkaWQgbm90IHN0cmljdGx5
IGFkaGVyZSB0byBwaHktY29ubmVjdGlvbi10eXBlIHNldCBpbiBkZXZpY2UtdHJlZSwgb3IgdGhl
IGluaXRpYWwNCm1vZGUgbmVnb2l0YXRlZCBiZXR3ZWVuIHBoeSBhbmQgbWFjLg0KDQpPbmNlIHBo
eSBuZWdvdGlhdGVkIGEgMi41R2JwcywgdGhlIGtlcm5lbCB3b3VsZCB0aGVuIHRyeSBzd2l0Y2hp
bmcNCmFsbCAzIGRyaXZlcnMgdG8gYSAyLjVnIG1vZGUsIHdoZW4gaXQgc2hvdWxkIGhhdmUgc3R1
Y2sgd2l0aCAxMGdiYXNlLXIsDQpvciByZXBvcnRlZCBhbiBlcnJvciBrbm93aW5nIHRoYXQgdGhl
IHNlcmRlcyBkaWQgbm90IGFkdmVydGlzZSBzdXBwb3J0IGZvciAyLjVnLg0KDQpEdWUgdG8gbWFz
c2l2ZSBkb3duc3RyZWFtIHJlZmFjdG9yaW5nIGluIHRoZSB2ZW5kb3Iga2VybmVsIHNlcmRlcyBk
cml2ZXIsDQp0aGVyZSBleGlzdGVkIGEgY29kZS1wYXRoIGxlYWRpbmcgdG8gbnVsbCBwb2ludGVy
IGRlcmVmZXJlbmNlLg0KQnV0IHRoYXQgd2FzIGFsc28gYSBjb25zZXF1ZW5jZSBvZiBvdGhlciBt
aXN0YWtlcy4NCg0KPiBsYW5lX3N1cHBvcnRzX21vZGUoKSBtZXRob2QgZnJvbSBwYXRjaCAxNC8x
NCBpcyBzdXBwb3NlZCB0byBzYXkgd2hhdCBpcw0KPiBzdXBwb3J0ZWQgcGVyIFNlckRlcyBhbmQg
d2hhdCBub3QuDQpJbmRlZWQsIGFuZCB1cHN0cmVhbSBwcm9wZXJseSBnYXRlcyBhbGwgcmVjb25m
aWd1cmF0aW9uIGF0dGVtcHRzIHVzaW5nIGl0Lg0KPg0KPiBJbiB0ZXJtcyBvZiBpbXBsZW1lbnRh
dGlvbiwgd2hhdCBkb2VzICJkZXByZWNhdGluZyIgdGhlICJmc2wsbHlueC0yOGciDQo+IGNvbXBh
dGlibGUgc3RyaW5nIG1lYW4sIGNvbXBhcmVkIHRvIHJlbW92aW5nIGl0IGVudGlyZWx5PyBXb3Vs
ZCB0aGVyZSBiZQ0KPiBhbnkgcmVtYWluaW5nIGRyaXZlciBzdXBwb3J0IGZvciBpdD9TaG91bGQg
SSBjb21wdXRlIHRoZSBjb21tb24gc2V0IG9mDQo+IGNhcGFiaWxpdGllcyBiZXR3ZWVuIFNlckRl
cyAjMSBhbmQgIzIsIGFuZCBvbmx5IHN1cHBvcnQgdGhhdD8gV2hhdA0KPiBpbXBhY3Qgd291bGQg
dGhpcyBoYXZlIHVwb24gb2xkIGRldmljZSB0cmVlcz8gSXMgaXQgYWNjZXB0YWJsZSB0byBqdXN0
DQo+IHJlbW92ZSBzdXBwb3J0IGZvciB0aGVtPw0KV2hlbiB5b3UgcmVtb3ZlIHRoZSBvbGQgY29t
cGF0aWJsZSBzdHJpbmcsIHRoZSBkcml2ZXIgc2hvdWxkIHN0aWxsIGtlZXANCnN1cHBvcnRpbmcg
b2xkIERUQnMuDQoNCkkgcGVyc29uYWxseSBiZWxpZXZlIGl0IGNvcnJlY3QgdG8ga2VlcCBkdWFs
IGNvbXBhdGlibGUgc3RyaW5ncywNCnJlZmxlY3RpbmcgdGhhdCB0aGUgc2VyZGVzIGJsb2NrcyBz
aGFyZSBhIGNvbW1vbiBwcm9ncmFtbWluZyBtb2RlbC4NCg0KDQpzaW5jZXJlbHkNCkpvc3VhIE1h
eWVyDQoNCg==


