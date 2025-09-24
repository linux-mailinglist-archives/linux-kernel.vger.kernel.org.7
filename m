Return-Path: <linux-kernel+bounces-829839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577FB98057
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A275178BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063B1FECB0;
	Wed, 24 Sep 2025 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hb1WWVBA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YiiLCfuT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11CC8CE;
	Wed, 24 Sep 2025 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678160; cv=fail; b=ZCML7LLG9xdZmErMU0yFxt1PAHcPoRZ6wVlTzqf1sONz+WQc0O9++z91++4mtmnUW604dK+G6v3jOYjp6woueK/1EB1CROE6OGrssYKFP/JUPq2U7zQrovSQ4ukFqR5P+KuKleYe82T45mTOCfGfeUqAX5oiEbeLSCCvvcI4C1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678160; c=relaxed/simple;
	bh=ZSRI2cfdQbHckFDfS9/L85FkF2CEFNHCC/QStQtQ4/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCd2hY+zKW1c/7sGLdARkNKMTgoz4I7tt1fG4+k8gakCpW7zyeRwVjskKEbvwrZgXa43kqM+9EkfAt41IZzBuenjE2N12xxKgAkZnbWpUCesajQ9XCitF1LecL+Bfj8c9/dGbcsfZaeRC7Ee+9nz494M61ZDKtAkMtSAAwGy/dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hb1WWVBA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YiiLCfuT; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b89ff7a698e711f08d9e1119e76e3a28-20250924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZSRI2cfdQbHckFDfS9/L85FkF2CEFNHCC/QStQtQ4/E=;
	b=hb1WWVBAR1wkGyOljd5EyPwbAiO4mwqwNRAAvlbEdmYbQcYxZ8A7Z/hPrLR4JGW1i7b2F6i9XJ4aB5xK01gMBjPceRInY8qIb2HeFx8/MjjMIlheC2oQ10KPbWPBReMVge2OE1419Q2yMZKJS/pHC40c4oJw9drinZJK+oCd/+w=;
X-CID-CACHE: Type:Local,Time:202509240942+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:f22f164e-ec30-4e5d-98ad-a90cf6ac3f48,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:17e69ef8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b89ff7a698e711f08d9e1119e76e3a28-20250924
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 672895276; Wed, 24 Sep 2025 09:42:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 24 Sep 2025 09:42:22 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 24 Sep 2025 09:42:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKmnyF/8Lnx1kLTZ0/nTuy1fE7H5A8QoUuVBkZ00Qv7IjrKknaATNaG/XFDYQGnJ0hCMxpq1nUVqq1gCpKk9AS7CqzC1Z3Al84wvAsb32r+K1wUBmLyFIS1DUkCFkE2p7jaQjbuFStvZlCbcfYaBhZPnDnEEAH460wmPy5FL3fAxijx/gU4J8uII4h75rNBbjFvNYzNzrVAHaLEae5116dQDYKisrw47oBS6HVJL06P6Db//Tu5ir0bRBMcjpatGQsnRo8sMzpEWVf3sjoE+bmKD05qZhrM9UxS87wFx+vBlgsHRWI8Daf05A+6ms55j+0kwPuPx0Rjz5aHphtX2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSRI2cfdQbHckFDfS9/L85FkF2CEFNHCC/QStQtQ4/E=;
 b=spHeia/KLid2fUYElFHsLuqfPbsZz5CHWZJZAwd8JUhLFVpfqefVuyq8IllJVAVyFYdLI5ziXqvJmAgiUcmPVjkFUL3/LKAXnE8fLRv7JkR6nY+y+Le9TSS8A7oseuZTqvXHKl9mkK2O1uOkJ2t8lwYOP6MCZhFrSyuVQ33Ls9LkJYcf7mGydhj1GJw9E51zqH8N6stCJeQoDbyAp/CbnMwLe8WcNoiNOwBiHsRnSfxjGu8RWz8pnREVahMg3zUke6Ohqby0JA7s62ckt1RUuaDDVikM+nCPXUFlXuODUpHhWge8umrFfpqeImSGOfQqikzkh/j7lfKcfiRZ0tuiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSRI2cfdQbHckFDfS9/L85FkF2CEFNHCC/QStQtQ4/E=;
 b=YiiLCfuTWevHxTiX5xHHRs8gXBpXMRO4RrOL1fA/erz3UYXDCT6krMwagMoa/BL8a8BlhMjEUz/o53RFG/bNzIWe0VnS+pXMD4VUwUh293IE6EivN0snX3vO88gl1/gqEoO7r5ec8yCxGuauepkkmdPuQ6zcGHA+HTntkzzSjyk=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TYSPR03MB8808.apcprd03.prod.outlook.com (2603:1096:405:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 01:42:19 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 01:42:18 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "nicolas.frattaroli@collabora.com"
	<nicolas.frattaroli@collabora.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgACRkwCAAIY+AIAAKeQAgAIpV4CAAcjDAIAB9sOAgADQQ4A=
Date: Wed, 24 Sep 2025 01:42:18 +0000
Message-ID: <e0fe9215133686069c1628e474ca2f934cbe6aa8.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
	 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com>
	 <5789241.GXAFRqVoOG@workhorse>
	 <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
	 <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
	 <CABb+yY2bYh70A=n9+XBBqthjngZP2D8ebFje-F9TN7K0c+fmMA@mail.gmail.com>
In-Reply-To: <CABb+yY2bYh70A=n9+XBBqthjngZP2D8ebFje-F9TN7K0c+fmMA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TYSPR03MB8808:EE_
x-ms-office365-filtering-correlation-id: e1a09f86-71cd-4164-3c39-08ddfb0b9917
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVhGbGRDQ0k0cU9Wbk8vbHh3RlR1NTQrOTRaN20yYWQ3a0F2M1ZUMkp4NjFs?=
 =?utf-8?B?aUZ3VVd4Sk1Tc0VXNXlTdUliYUc3Tk1wVml4QStCSG1FNjJuRkU1bFQ0b3U4?=
 =?utf-8?B?eUR1WHZ1RWx2blZ5UGRVME93aDg5RUxoaFQrZWZNejd0VDZxc2hsb1BaMS9T?=
 =?utf-8?B?ZERVbUhHQUNJV0dVTU1RZE9ibDhUdVNwcmU0TWNzblQ3Sk1ycXBxVHFjSyts?=
 =?utf-8?B?TGRUZzJJaVBCV0Z4OVhiMUFSRGFwWkRkMm1CZkp5VEVZRDhCU1hNdVBMdmVU?=
 =?utf-8?B?RlpqRFFkODgyb0ZseWlXekVnM3c1a1J2cHZNYVV3Z2pFUDZRV1R3U1ZQSnNM?=
 =?utf-8?B?bVpVemhLdWQ3cUZzV0hoQzZoUWVkVDZuLzZXQndCNTVwd2VRdEgwbTVWMkJz?=
 =?utf-8?B?VlY0SnJLdCthOUhBMEMwczI4Y3hlQUpVZ1lpeXJVeVdZYm1XaCsvZUJ1V3Bo?=
 =?utf-8?B?dlFSSG1zVlByKzJuNHA4N2ZOTlNwZnh4U1hNOGhGRXI3MG9zd0RKZ1VEbVkr?=
 =?utf-8?B?MmdsZWtUOXJOV3FIRHEzS0hxL282VXFLZW9NY3N4ZXE2NzRER01WQWhPMEVM?=
 =?utf-8?B?Q0k2UVl4T21xR0l5R20xdEFFRmxRTTdWQXNQS25FSUJTVUZOb3JWU25Nckta?=
 =?utf-8?B?SXY4RG5BWnY1cU9QcWR4QjZDRzRYOXRxY1pkTEVrOHBKMW9iQks1QjY5UXBC?=
 =?utf-8?B?OXowemZEY1duOEowZEw2K1VqbjVHMkZxRTA5clRBc0hrUHRxTUZlM1Z3UHRV?=
 =?utf-8?B?ZEtEbDNNMWR6WWhtdGxnUzlNMU9xWFlFWVAyTUgxZkhBdGVlUEFtb0tHeHNO?=
 =?utf-8?B?NjhqeW9wOXJjOFArdndxSzhOdS9nbXY2djA5anh1WjNlNWhqaFp6OXJ2SlVM?=
 =?utf-8?B?WmxHUUc3R29vREl4NUNkajV5QXVhYUhPR3J6RUJwdHZob2hVeGpOVmI1MG9l?=
 =?utf-8?B?QkVRMWw2Rm9lMXZ0dytaRno1aDhsSk04amtVeHdzY2M5ZDczdjdVMjFNRnhW?=
 =?utf-8?B?WWVnMVlrbDFTQlBIaGdKZEorYTU2TU9PMGNhUUtpdExjVnlmT1dQL09vUkJC?=
 =?utf-8?B?VWowYjM4aDVITHB6c081YnJzU296VW5hMG15SjhvelZtUWRrZ1JydW95bjJX?=
 =?utf-8?B?K0tFNWhPK2txVi83Y2FFWmNsalJFOFFKWlMwMkl2RmRXQ25GVWFrMHdVSVdv?=
 =?utf-8?B?Ry9UekpiV3VEMlN3TE9obkhtVXVSWHEvZkJ1UUIvR2h5MGRlTFhSSTFSM3Z3?=
 =?utf-8?B?RjhPU0s2a21HOVRXbmVDSWFjazhpTHJKSGpIS0dQR2F1Ti84ci9yb3pzU1hY?=
 =?utf-8?B?MDBER0Nvb29pN2kzNjN2SmtDdnE5T2tSa2F4U1VycXRIbWlpT0ZIRk12Znlt?=
 =?utf-8?B?Zk9aMGRGRllFYlB2WWRhL3VneUlCcThrZnRxSHdZYmtVb2lBQWIveUNzK1V5?=
 =?utf-8?B?TFZBWlVMdGp1UVN3NGg1R2FiQ0IxS0N2YUI1ZXJveFdwclRtQmx3NFF0MVRC?=
 =?utf-8?B?bUgvNWpXUHRGd28rQjRuL0JBSUFaaHdRRkhMdkRab2J3elc0cVNtQjRRSzRr?=
 =?utf-8?B?Qy9ubEJOcFc3aklicHl2bmdvRTdTRUVMdlhTMkxGUTVOLzNLMnd6cGxzSEVY?=
 =?utf-8?B?bFRENFBsUGR5TnJvTnhSMGlXTllmRWJBMXg0MWswYjU1S08zTmt5VlhkbVkx?=
 =?utf-8?B?NUxUelFxaG9aZ1M2c3crZHRWNlJKb2h4anRqZklHMkN5VC8xckZNS3VDMWlE?=
 =?utf-8?B?czFKUmhKTjhUWG8vU20yNVhWZ0dlWlRwK0s1SVBTb0tmRmRzQW9oL0hJRkQx?=
 =?utf-8?B?bE5nN09Jbng4dGhudm5tMW5SdEdVU203ZVFaam83YW5vcFRSdzFIRm84alM1?=
 =?utf-8?B?WjJiaFBYOTZSZVNoU2tuY3kzTWdnbE1DUCsyVzE1ek1pM0dDMklvRDB3NE1l?=
 =?utf-8?B?MWQzZEJIMGJWS3pTbUl3blZpNDhESXVWVkFlb1dxTyt0NWxrYVA4N3IyK3p5?=
 =?utf-8?Q?OH7s1SnrPaOSf/4FVNnbn67tJH7cd8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy8wQWI4VkgwWk8wYnlnMkZxWUNEeTQ5aUFjd2RzTlBUWlB0TUtpMUN3bXg2?=
 =?utf-8?B?UEs3ZEZ4RlJRYndNandrWVNZeDVLRnZRY2R6T0tKbHpyZEduNzN3b2IyaFlI?=
 =?utf-8?B?aVFsd2s1cmJ5L2VzQnBBdXQxL01BUHkvU2s5SWF1SHBTQUw0TTdUN1NGNDZG?=
 =?utf-8?B?MG4vRzEzaTNJb3lOTjArRXhwMUJqd2tYS1VJZ3ZCblIvUDA4dzhrUXJtNGdI?=
 =?utf-8?B?SkJYNFA3UzJyRUpWTkwzNGtObEgzRENUVXJIaWs4OU1ZRWVGbjdDODQ0S0dQ?=
 =?utf-8?B?MVJQL3g5L3BiNHRWK3JBWmZGd25DeHU3SlZHVVZGMkhpNXc1bndqaXJsdTFx?=
 =?utf-8?B?YTlzUTJtVFJEdnhOU3RDVDR4Ty9wOWQ3bmFDNUd1UkFNdVZiNGkxZS90Rm5X?=
 =?utf-8?B?dFdwRTRnekt2ZG1RR3ZpWTNEMTg4dlRMU2pJY0tHUGdxVUlyMk1rZUc2Yk1K?=
 =?utf-8?B?bE9Sc3lvMkR0RWNBblNUbGdjNmx1SXRBNlQ5SG9lOTBsUlR4dG1BRkx4SS9l?=
 =?utf-8?B?M2dzc2I2UHlHd3YxQ1BPNVB6L3NjWTJoajlKaG82MTAzVE1WbzFvcytTRWVE?=
 =?utf-8?B?VWlYQnNPZ1JXa3E5UWdjTzcvb0VWc2VqRWV5VkZOMHhCQkdLKzBqSHlEcVMy?=
 =?utf-8?B?SzRkRmY4OGhXVkdDejc4cXFENjV1a2EwMDVQUnNMT0JHOCsvUGtsVzRIUEtl?=
 =?utf-8?B?Q01TWXVnSzJkMWFzbWZyeDhzTXJZMitPQ1JMbmNRb2szMFVOZlpiblFHY2Zl?=
 =?utf-8?B?NWlkWUxQV0lUN3gxL0o5NkpidG00VkNWbXlKaE5Pek1TWXJBUW5TN2JkcGdO?=
 =?utf-8?B?SUdmZm5raTNZaWZEU0Z2eHlLeDhTUWpBR1Fpc1dVRWVYOFZJbG5DcGxkQTc3?=
 =?utf-8?B?VGZuMG5EMzY5cWdNTEtxclM0QkZMYjA5MVlZN0VmM1dsOStUY0RKek14K2Yx?=
 =?utf-8?B?VkJ1S0ZBVzlPdEg0RE9MZEhjTjBLcFo2S0Jub1lmQ0VCU3crdmZmZTJ1ZnV1?=
 =?utf-8?B?Q3E0MzNENXRFazFxOVNiS1FJQW9UK0RBS1NxVi9jK0JQKzJmOGlmMmlJbjZU?=
 =?utf-8?B?Wm1hUDJMZlBSay8rVktCbm5CTWhxL2Y5RTgrY1FheUtaaEcxcWFpcWJhM0FH?=
 =?utf-8?B?RzNpVExwS1M1TzF0enp5RUtXaHZmUi9XdEJZamprS2FMMlREOU9FeHpGb0NG?=
 =?utf-8?B?bzRJeFlNQTJ3Zko0WGVzU2tjQ3lwNEE1VjFTVGtwOWdMVUJnaldudk5wSGVi?=
 =?utf-8?B?ZDU0TGFkamZYN0FENDgzWW56S0dzeGFLVmRVUXJaUU93LzJ3UEozbkJ0WkRm?=
 =?utf-8?B?akMwWWxNUXFmWUdYSXpxNGcrcGF4bXgrYndOR0tFYWlseVpsc0dPYTh6U0VO?=
 =?utf-8?B?WTVxSjBXM213K2laTVZmVngzUkFBTHpySVVFbXBHZVI5bVB2M3FLWVFSWlgr?=
 =?utf-8?B?ZXBZVXE3NW92RmNaNUhHQ2NjWDZ5MCs5Qno1dytjV0tLa0NIMTRXdXc5bGJL?=
 =?utf-8?B?b2Z5cVc5OWowQTM5UktEZ2oveTBlOFRyKzMvTElpRVBMRUpBZjBDQUQ1M2NT?=
 =?utf-8?B?L2FLL2NlZDZtbHBQNm15UTd3ZEJTU1NXNnh6cVMyeHBOM01FaExDSkdjVGtk?=
 =?utf-8?B?UlF3Y0k1Y0ZoK3ExM1lLWFdFRGZ2S3QzMmNEU3RCeG1uV3FMTUdCbHdVajBH?=
 =?utf-8?B?cXVaZHByS3dEMFlqK0Z3VUttYjJXMmViWVdKaWVJUW1Oa3V1bjlSNXZxbUpk?=
 =?utf-8?B?SXZNcGZ5VE9SZ0pUaWt1V2xNNXNEMFpSdHdZbjNjZ25wa0Npd0VaRCtsanNO?=
 =?utf-8?B?bXBKcjRoejNRdDhMSUFDeXRPWC9qcytqei8vT0FYb1phcjhLZmcwMGE3c1NI?=
 =?utf-8?B?emExY2Y0NzkxL2RGaFpyZWkzMTUwSUlncnh4ZUkyaDUrT0pZTExtenVxb2Vs?=
 =?utf-8?B?eWZjUjJxaTdENFVMOG9BamJkMm56cHNsQTRadUVoWE9VWHF1elhPV1VkNWh0?=
 =?utf-8?B?b21XYjRScGwxQ2JITENKSWRESklwNFpkZzVLclZiUUpVaXliSFRuZTRRZlJk?=
 =?utf-8?B?WU9Wdld4cGpwSjhMRTV1TUVxL0RrNzJXSjBKYjdwUGVsRVplZFduN0NuY25q?=
 =?utf-8?B?ZXAyUHFqOThteUVtRUR2QmorR0ptMDdJN3N2clpza2JCR05oRXBqdkp1SzNY?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88BC31035D013F42979BDBDE07876E2C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a09f86-71cd-4164-3c39-08ddfb0b9917
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 01:42:18.8043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfF+RTHuTHL9TCoq1aaRyYH6BeF2CzdgSl6X5w7tFEXGrixdWKlrcODGAD9fQ6w9I68IQu3cXL1lswHBNQo9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8808

T24gVHVlLCAyMDI1LTA5LTIzIGF0IDA4OjE2IC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIE1vbiwgU2VwIDIyLCAyMDI1IGF0IDI6MTfigK9BTSBKamlhbiBaaG91
ICjlkajlu7opIDwNCj4gSmppYW4uWmhvdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiArICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsN
Cj4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+ID4gPiA+
ID4gPiArICAgICAgIHN0cnVjdCBtYm94X2NvbnRyb2xsZXIgbWJveDsNCj4gPiA+ID4gPiA+ID4g
PiArICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfdmNwX21ib3hfY2ZnICpjZmc7DQo+ID4gPiA+ID4g
PiA+ID4gKyAgICAgICBzdHJ1Y3QgbXRrX2lwaV9pbmZvIGlwaV9yZWN2Ow0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gTWF5YmUgYWxzbyBoYXZlICJzdHJ1Y3QgbWJveF9jaGFuIGNoYW5b
MV07ICIgc28gdGhhdCB5b3UNCj4gPiA+ID4gPiA+ID4gZG9uJ3QgaGF2ZSB0bw0KPiA+ID4gPiA+
ID4gPiBhbGxvY2F0ZSBvbmUgZHVyaW5nIHRoZSBwcm9iZS4NCj4gPiA+ID4gPiA+ID4gQWxzbyBp
ZiB5b3UgaGF2ZSAgInN0cnVjdCBtYm94X2NvbnRyb2xsZXIgbWJveDsiIGFzIHRoZQ0KPiA+ID4g
PiA+ID4gPiBmaXJzdA0KPiA+ID4gPiA+ID4gPiBtZW1iZXIsDQo+ID4gPiA+ID4gPiA+IHlvdSBj
b3VsZCBzaW1wbHkgdHlwZWNhc3QgdGhhdCB0byBnZXQgdGhpcyBzdHJ1Y3R1cmUuDQo+ID4gPiA+
ID4gPiA+IFNvbWV0aGluZyBsaWtlICJzdHJ1Y3QgbXBmc19tYm94IiBpbiBtYWlsYm94LW1wZnMu
Yw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIHJlYWQgc29tZXdoZXJlIHRoYXQgdGhpcyB3
YXkgb2Ygc3ViY2xhc3NpbmcgaXMgbm90DQo+ID4gPiA+ID4gPiByZWNvbW1lbmRlZC4NCj4gPiA+
ID4gPiA+IEluc3RlYWQgdGhlIGJhc2UgY2xhc3Mgc2hvdWxkIGV4cGxpY2l0bHkgbm90IGJlIHRo
ZSBmaXJzdA0KPiA+ID4gPiA+ID4gbWVtYmVyLg0KPiA+ID4gPiA+ID4gQW5kIHRoZW4gY29udGFp
bmVyX29mKCkgc2hvdWxkIGJlIHVzZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgZG9u
J3QgcmVtZW1iZXIgd2hlcmUgSSByZWFkIHRoaXMgdGhvdWdoLiBCdXQgSSB0aGluayB0aGUNCj4g
PiA+ID4gPiA+IGV4cGxpY2l0DQo+ID4gPiA+ID4gPiBjb250YWluZXJfb2YoKSBpcyBlYXNpZXIg
Zm9yIHVuZGVyc3RhbmRpbmcgdGhlIGludGVudC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEFuZCBob3cgZG9lcyBjb250YWluZXJfb2YoKSB3b3JrID8gOikNCj4gPiA+ID4g
PiB0eXBjYXN0aW5nIHRoZSBmaXJzdCBtZW1iZXIgdG8gaXRzIHBhcmVudCBpcyB0aGUgc2ltcGxl
c3QNCj4gPiA+ID4gPiBmb3JtIG9mDQo+ID4gPiA+ID4gY29udGFpbmVyX29mLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IC1qDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBXaGljaCBpcyB3aHkgaXQncyBjb21wbGV0ZWx5IGVxdWl2YWxlbnQgYW5kIHNpbmNlIGNvZGUg
aXMNCj4gPiA+ID4gc3VwcG9zZWQNCj4gPiA+ID4gdG8gY29tbXVuaWNhdGUgbWVhbmluZyB0byBo
dW1hbnMsIGNvbnRhaW5lcl9vZiBzaG91bGQgYmUgdXNlZC4NCj4gPiA+ID4gDQo+ID4gPiANCj4g
PiA+IE5vYm9keSBpcyBzdWdnZXN0aW5nIHR5cGVjYXN0aW5nIGNmZywgZGV2IG9yIGFueXRoaW5n
IGVsc2UuDQo+ID4gPiBUeXBlY2FzdGluZyBiZXR3ZWVuIG1haWxib3ggY29udHJvbGxlcnMgaXMg
ZmluZSBhbmQgYXJndWFibHkNCj4gPiA+IGVhc2llcg0KPiA+ID4gb24NCj4gPiA+IHRoZSBleWVz
IHRoYW4gdXNpbmcgYSBjb250YWluZXJfb2YuDQo+ID4gPiANCj4gPiA+IC1qDQo+ID4gDQo+ID4g
T0suIEhvdyBhYm91dDoNCj4gPiBzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpwcml2ID0gKHN0cnVjdCBt
dGtfdmNwX21ib3ggKiljaGFuLT5jb25fcHJpdjsNCj4gPiANCj4gDQo+IFlvdSBkb24ndCBuZWVk
IHRvIHR5cGVjYXN0IGEgdm9pZCAqLiBTbyBzaW1wbHkgZG8NCj4gICAgIHN0cnVjdCBtdGtfdmNw
X21ib3ggKnByaXYgPSBjaGFuLT5jb25fcHJpdjsNCg0KT0suIFRoaXMgc2VlbXMgdG8gY29udmV5
IHRoZSBzYW1lIG1lYW5pbmcgYXMgd2hhdCBOaWNvbGFzIHNhaWQuDQpJIG1vZGlmeSBpdCB0byB0
aGlzIGZvcm1hdC4NClRoYW5rIHlvdS4NCg0K

