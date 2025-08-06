Return-Path: <linux-kernel+bounces-757314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413BBB1C0B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E141F18A404E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC022144CF;
	Wed,  6 Aug 2025 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jH9Nacwp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GxB/dRSC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF51BA4A;
	Wed,  6 Aug 2025 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463234; cv=fail; b=DH/M+wq9ANlYqD5yyq999wlnkleph4CTD2u8MgnkklUHLgRp9xc58CmJ9dIqkV5NJ49IhnqIK62YCoYRkp5Y36LzWtDkBi6Q7fDMTz+4G320GP+IXGTWtYsalxRlgidhZt7mPXQV5YR7QmfzChGqAuiVdCSizWeoG1a0XlYbE+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463234; c=relaxed/simple;
	bh=Ckj5cNming19g5xVmH00/Jwu6VqXlZVAkYCMrg2FR5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDhEMuoNaNmaYTQooXslQbY10c2pUjQFV81nDvljR5AJki8xAYjhJTX9CRJ/i5FBMY5gPPJ85DzDQlbfDRbX8/fwPuD6O3zP6Ctf+MtXJVH5ODjYkUv9xD+lnb2p1eUbA4xT0FViBLOq68AQfxpa4+AT/YaZtJ+bQ8Ci6vFLT2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jH9Nacwp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GxB/dRSC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 18c3ecf4729211f08871991801538c65-20250806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ckj5cNming19g5xVmH00/Jwu6VqXlZVAkYCMrg2FR5M=;
	b=jH9NacwpyvHfGT6U3bTa1XnLcnnYVKDkNLtw6DFltoK5HNeXBs7gHRpEeq3fVtpj5Bd95dyJpJeASuTesw46GBOfX3ylylbnT/C7BbnjIMoKYFIIqxMk1S7R8/9z6vjB5dh9kTETrCAiJYhKBWK2ViBBIQd7zI72ijD45JKFFPQ=;
X-CID-CACHE: Type:Local,Time:202508061453+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:e40931e7-d16a-42ee-aa47-8d6fde444fd6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:8ce22b09-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 18c3ecf4729211f08871991801538c65-20250806
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 362919313; Wed, 06 Aug 2025 14:53:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 6 Aug 2025 14:53:43 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 6 Aug 2025 14:53:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqgtWyE9UfTlB7Gx3nAH4vizWvldCO8rK/KoTbswN3uKzSzumVZd3HsBnsi6mXgjsltRWp3tYYSZDn0nbF1cDkcsPwPy9V3NdiejQDPKXaBTaNn+4IihzkX9YpCQ1ajQfD04XalRZoh+5dQoILj73BRyuxD80Hf4S8lqsIIkos2q8okSHIgB+8Bh6AFkozJL8aKb+Jqfnj/v5LqSeUbdziPsEjmYSq4g+M/7nE8wz2KrYQ/TBS7htgaSdaHUIUo2GxO6yjxPzKYlYyScsrw4nc9EFP8+pTMZJNXygGfgPH3YLqfao+8ovEbymQafEgPzII/LI7qShO1tVz0JiU7J7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckj5cNming19g5xVmH00/Jwu6VqXlZVAkYCMrg2FR5M=;
 b=Y2rQAjCH4gz8jbzEbmv7XYLKQPZJDkIRlUjLQejGdQWPLumvPY+cH6kYt3PGzMGQ8lsSUJYCXrzo0f0omZqy2ubaWUEZRoFfXuUbaPveUtBpx4Ysy8VhE1i+yRqAL45nt5mI2lRztzCdFk2XMc2qGkLpbXj60Djc7Uq8IgClobUZLVNOIBdTXAJr4zqa9QpRwENK60a9wAxQMqqPEb4xBo7b5Yi2HHTuXRughkcW/j4KKGuvTuICP8ElU0u5EGVNHNB7ST2BWVNUuHGIFD0BAXPGoMvK9G79eKKea63CWTDLTDa9+boj1BbDn6PgBBTAPDg09Kq4Um5guG+OEYzK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckj5cNming19g5xVmH00/Jwu6VqXlZVAkYCMrg2FR5M=;
 b=GxB/dRSC5Bv0iNc3LCkV76zSVAcfWZy61VGZT0xpc9yJaUdmgHAlX7ZM032YG1ZVmNK4Cu4IjCVvVzYYigCyvvozrIhSIcMAB4bY4En+McXJAJgrioP2FehP5fRS26cE9Gjf7X6fwF1mX/6mpRDTbYw7fwX1u2yn5pqI0hROYtI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7123.apcprd03.prod.outlook.com (2603:1096:101:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 06:53:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 06:53:39 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= <yongqiang.niu@mediatek.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: display: mediatek: dither: Add
 support for MT8196
Thread-Topic: [PATCH v2 6/7] dt-bindings: display: mediatek: dither: Add
 support for MT8196
Thread-Index: AQHb/sZ56NVpqEdavk285pFHdUctvrRVQB8A
Date: Wed, 6 Aug 2025 06:53:39 +0000
Message-ID: <3f7add11f15ab49ab3cb3f60164fcaa0cacf3ecc.camel@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
	 <20250727071609.26037-7-jay.liu@mediatek.com>
In-Reply-To: <20250727071609.26037-7-jay.liu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7123:EE_
x-ms-office365-filtering-correlation-id: 1c32ebf5-89db-477a-72fd-08ddd4b5f966
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|42112799006|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?L2VHQ2NMdnloOHJRbU8rVEtWeWdoWTlQMys2NURNUStqQSs5ZzdaNGlhYW5v?=
 =?utf-8?B?UjZNNHB4dXNmMUpTRXJ0TnFQOE9TMll0QTZlUDdkSFNNUVVmUkZRMy9sTCtT?=
 =?utf-8?B?QXdWVTIvcld6ZXc5Y0JQN2RQd3owMEZ0UlFYM2FzUmlEblgxc0JGQ0YzQkRZ?=
 =?utf-8?B?aHZkN3JhTjRCZFYxTmhWVlJPNFU5TW9iTW94Y3Y1aE9JZVMzYlRDMHp1aGF2?=
 =?utf-8?B?aWtCN3hCWktuR3lIcjdzdENlVkpiS21rWHVvU1dlbk5JeW83V1dSdTZReXdo?=
 =?utf-8?B?OUxyNDVLekZOVFQxNHhLT1dXYVRyVzBLSWVnb2x4U2kwWGxpaUIvQWQyMHlF?=
 =?utf-8?B?dlZ5a1RRRVNFWVB2SFZycHFUZllaMzg3UEptc09HRjVoNVVuNVlMRnMycUVp?=
 =?utf-8?B?eWNvU2M3ZytZSHkvWHRRY05mMjAyaFE1c0gyaHQ5a0VBVVdkRG5Ka1h4Qmlw?=
 =?utf-8?B?TmtFUnF2U1BuY1g3T0RoQ1EwMEJGVGtTNlBzUTZsSENUNjhuK3grV3AwcWFD?=
 =?utf-8?B?RlNtREtoTmVib255UENvSTBwOURHVXkzVGFHMGswZnEzK1ppQXFUNnZia3Vt?=
 =?utf-8?B?ZFNISkUyNU1VK2xFTVB5QkFNVjVDUHk3T0FQbnZ2M0wvWjhmcEZHS2V4V2x1?=
 =?utf-8?B?QnBvRUg0OWwxSXlIZmVWYlZ5V1pJOVdkMWZLZHJ1U3pGMyt5L245V21WWFQ2?=
 =?utf-8?B?OG9lNktrVW9SYngxUGx0QkpLemJmZlVzZ3FueGV4eDVucGo0SDRMbEJZMXlp?=
 =?utf-8?B?K21RQ3h6M2tPTHEwdzdEN2hIbk9KaWNyNTVpRmF3d3NoemE3cVF2WnZxOTBB?=
 =?utf-8?B?elJEV0hzUXF6RkYzSlVNa1EzVmpRL1d6YmJOekhYQzhHdmdzSXVnVWJYWlp4?=
 =?utf-8?B?b3hEM2FDakNNdFk0YzZDMzlEcGtJSXZTTWRzMitCZzZsNVBqbkJ4eVpUNS9Q?=
 =?utf-8?B?Q0o3Sk84YUV3cWNOZzZPbm9BdWk5WjRmL0J4TmVKblg5d1AwVEIxSmVrOTZx?=
 =?utf-8?B?aXZMbDJJSlhGZ0dLa0JqUjBVYi9RSmc1SVB1YmVpZW9NbmRoWERkMEFPWjRR?=
 =?utf-8?B?dERZNmZTUE1RM21DSTBFUDVkSEZTNi9ydGl2YVk5Y3FTb0F1SUVYV2hmV1dY?=
 =?utf-8?B?aWRZaE02Ujl1TkpCNlU5MGZabDN3dWRJWEpDTDVLSGxmeE1BZmh1VHR1a0Fw?=
 =?utf-8?B?K3lZOEJHcVdibnlCbFhxZENNWWUwNUdEZWh3ZTEvNkJRTE5uZndidzgrdEJj?=
 =?utf-8?B?em1oQ1RSNFdPYUpRNFNZSWVJNG53RjRWcmFTVE9XbURhWW02WXZtZ2MrWFBY?=
 =?utf-8?B?Wmpib2lMbnliZm0zNUJZcXNqbUcxM0l5UUl5ejk4TUlOVStmVEg4dkdreE5K?=
 =?utf-8?B?Wkd0SWtwNzdLTFVFaUZkRFNSbFNYVTVTdWZFMHhld3VWTG1XTjNpbDVxNEpN?=
 =?utf-8?B?R3Z6aytGZ3BEZlFNTThjdHptRkNjN1kzZmlkTTZ4UnArY0FsMVlvSUR0Zjkz?=
 =?utf-8?B?MnAzN2tKYWlHcjNUbTVPUUhETFg3dlQwQU13WE1na21seGI5ejRBc2ZUVDRn?=
 =?utf-8?B?cWg5NUw1TThBeGtZRUora01ySHZGTzAwSnh0Wk4yVHVMUlVOMERvMmdzWTc0?=
 =?utf-8?B?L2loMHVzV3dWZ1dvYitQcFlSZThPdmFRUUJxeDhoSisyaTRJL0R4Z25QT21y?=
 =?utf-8?B?Z1dOS2twMmJEaFFDbGNoMCtRR05sQUgwczRRVDNnSGY1azJHbVVURHhGSnM1?=
 =?utf-8?B?UnNkdGMwcXJkOW9NVEFpdzB3Z1JBOUh3azVHbU5wZ0NtNXFCOGpVVjZOckFP?=
 =?utf-8?B?L1pySkczNk9ja0RXOW1NeUJZQVpSazRoWDdkNzFUK2tOZ1laUUFZMVBWN3pW?=
 =?utf-8?B?bnBMQVlzT1FFdUJPcWVCMU5iSDdGRURDRVN0dTdpOXRrU1o5Ui82cEhMTjh2?=
 =?utf-8?B?VlpkeGRrMmNBczVycHQyNXVoRzEwZDJFc3IxZ1RvSXhkR3ZZVHkrVFNrZGdF?=
 =?utf-8?Q?mwP96PbSjPyHj1GN/T+dPF2ySG5Xdo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Njd6K28rT3lNeG1oMzI0dkhBeXBQOE1TSHpRclh0aFN0UmZITVhXOHB6NGYv?=
 =?utf-8?B?TzluWXk2dStpUUVpRURVbVpTOGYvcXBmbTR4MzRwUzI3UnRlTkNjcjk5N1Va?=
 =?utf-8?B?VlFNdTBxVm5xWlhERllXN0F2bkRrV01ZZVQvNE8xMGhtdEJMSThKQWtLSjZF?=
 =?utf-8?B?WGIreG9TQmQ1RzMxekJKdXl3bjVuWElwQmRWdVhHeUlOKy9mRnpvWnJzTC9R?=
 =?utf-8?B?dVRSQUYraGJya0lWY1ovSk5VZ0U2eDFpeXlTNG1zY0Vqcm50cjUvY3pOekND?=
 =?utf-8?B?a0VIdmVaSGFkYlpXeVBTSWhnLzA3RVp5dlY4Wmhic1E4dmhpVmFBdUMwNHp4?=
 =?utf-8?B?RmNuMmRzUzdjcldKNjY2SGpRNGVOd3NWTUNxZDgwQmhLL3NrSTBTcDFxQWli?=
 =?utf-8?B?SDduQ201eXNYZjh5bW1nZGxPVzk1OHBJSHFxQ3VVQi9rMDNkMHcxZEdTYWZ6?=
 =?utf-8?B?dFQ2TXc0Tm83ZWhVZVJtQWo0bmN0MS9SdmlmWWVIZUZ4Nyt5c2x5OHluMmhT?=
 =?utf-8?B?UmZUbkFoMW1tdmdUOTNISWhHNE8vUFg2VHBxYWEvZ1J4NkFhSzIvdnllaTA0?=
 =?utf-8?B?VHJaS0xtcUVGS3Q4UVZ3ZkxEMk9mNFRybFR6UzhYNFovYnFZQ0FhRThoNDVE?=
 =?utf-8?B?OHBLbTU2WjZHSEJDa0hUMjduTzVhVXEwRW5WblIyekdlcjFBbmFRbUo2bEZL?=
 =?utf-8?B?TEVwWkEvSVUzMFhGZUR6MTFySFd6c0tWZjZOMk9PNGs5bitVMTRkeU56bXFK?=
 =?utf-8?B?YkhCZW4raXhqT21aWlVEVjV2YWZlZ3J2RkpXc28xTDIrdnVTUVJWa0hlQmht?=
 =?utf-8?B?N2tnNEwrQ2Y1MTZ0RXlYd2NwQ0NZdjBwVUdJajhscnFsQSt1cXRJWm9LQmx0?=
 =?utf-8?B?bVNyRmJmNUhDdVFkL0xCM0I0dFN4ZjVla0xBN2Y0TUhtOE9BeUtmM0xNSmhH?=
 =?utf-8?B?aTZUd2R5Z2lOWEgvbE9Qb3hhbGd0K2tkNmR4Y2NmZmF6NURESlptQkQ1dVRH?=
 =?utf-8?B?SHQ4SVNXMHR6ZzNFWllHVWJBMmRLQjhhQnVlMzFZa2VlMG9na1l1RHdYRGtL?=
 =?utf-8?B?cEtQNWlhci9rR3JXaENmTkp1OHVWdU42UVpuK1l6OFZ1cmxkTURnRmtHaS9F?=
 =?utf-8?B?a3Q5SzAvaHdqQWNBRHFGeUNTTGFKdU5lVm4rUmpCaFNNWm51Wmt5UzFIMGY4?=
 =?utf-8?B?Z3d0Q2pmYVZaMXhnZ0hVWldGVmdOZFZ6UTJsME5FM0FhanhRYWhWRFlaaWVE?=
 =?utf-8?B?TTlVdE5IMjczNWYvSVZ5dFZlSnVXRTA0ZlNrUjR3ZXdUeXBLS1MzQmVRYmMv?=
 =?utf-8?B?WXQ3ZE9tWDVpMFExenNBU3J6RXR4ZWZFdXNXME01R0lHQzEvVG9xM1hhd3J6?=
 =?utf-8?B?Ty91ZXJJM1kzK1AzV3EyYnFjUEZNUFVScjdNdStLdUorQ3BKQ056VHJjSFdB?=
 =?utf-8?B?TEZiRjYwWHF5Z2owb2VGeU1jeEFwbzRMWnEwQyswRGZXWkhuWlYzUDl1OWhx?=
 =?utf-8?B?TGk4VHhBc3RwWlUvbDRLeEVXbUdla0ZZcEdzWnJmeGxTRkg5RjM5amQ0cHNz?=
 =?utf-8?B?a1l2bTRCUUExdkZqRlZJcFFWWE4vSGtJS09XcXVmdXYyMWJGZUV4bnArbVhP?=
 =?utf-8?B?alZ3VFRZZCtDbzZTTjNQM0VsUkJHd1dTU0gyTnZlMHpnczFOZmVOV3VUN0tt?=
 =?utf-8?B?RDNnV3lIS295c1RwdkMxd082ZUJJSTJ3QndNelBPSFZ1eStjZ3B3YVB2K043?=
 =?utf-8?B?ZGFZblpxL1dmckFESENFdjNIaWFEZzNiaFQ2VG81aysySnhFNkRVT1V4bWZ3?=
 =?utf-8?B?RTBFejBwbDVwWU95RnRZVXFmM29mY0tGbjY5a3YrY3RveGxHRGs0UE10K3U1?=
 =?utf-8?B?UzZrV1hBTTgvZUQ0cVNNelZTazlRdzZGTUtTNEIyTmFYMW5CcCtwbjZ1NHdP?=
 =?utf-8?B?RnNTQmhzZmt3SFdEWnR4d1NjOUFmNmtLdXplMDdGSXlDRGtpSE85RDMvN0RH?=
 =?utf-8?B?R2lyTm90YUtNQys1MjQzbGxjSFhmN2c2ekFQS3Q0TWVwaDhlUWFZQmRPUHk5?=
 =?utf-8?B?OEUrd3NpeEdUWWxkdUVNYWxHOUZwUUdHZ3VEZzFDQXR2Qm1DTWJvTUdNSkxK?=
 =?utf-8?Q?qLm0VfPtq/7YvNPaua4oXdAwn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92AE4EA9F5226F4F8F2357B207F3A281@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c32ebf5-89db-477a-72fd-08ddd4b5f966
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 06:53:39.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHJrGMnBkNWNbqQmOhxje0ezGu83Za+mPFEz+GU10SuX87ppX8rjNw+FO1cZm/oC2OF4UYe0WZPBy8wmBeNNzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7123

T24gU3VuLCAyMDI1LTA3LTI3IGF0IDE1OjE1ICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
YSBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhlIERJVEhFUiBJUCBmb3VuZCBpbiB0aGUgTVQ4MTk2
IFNvQy4NCj4gRWFjaCBESVRIRVIgSVAgb2YgdGhpcyBTb0MgaXMgZnVsbHkgY29tcGF0aWJsZSB3
aXRoIHRoZSBvbmVzIGZvdW5kDQo+IGluIE1UODE4My4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogMjAyMjAzMTUxNTI1MDMgY3JlYXRlZCA8amF5LmxpdUBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRl
ay9tZWRpYXRlayxkaXRoZXIueWFtbCAgICB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGl0aGVyLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXRoZXIu
eWFtbA0KPiBpbmRleCBhYmFmMjc5MTZkMTMuLjFmMTcxOTIyOGI1ZCAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWssZGl0aGVyLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGl0aGVyLnlhbWwNCj4gQEAgLTMxLDYgKzMxLDcg
QEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItZGlzcC1k
aXRoZXINCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtZGlzcC1kaXRoZXINCj4g
ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgzNjUtZGlzcC1kaXRoZXINCj4gKyAgICAgICAg
ICAgICAgLSBtZWRpYXRlayxtdDgxOTYtZGlzcC1kaXRoZXINCg0KTGV0IHRoZSBudW1iZXIgZnJv
bSBzbWFsbCB0byBsYXJnZSBpbiBvcmRlci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gICAgICAgICAg
ICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxODMtZGlzcC1kaXRoZXINCj4gIA0KPiAgICByZWc6DQoN
Cg==

