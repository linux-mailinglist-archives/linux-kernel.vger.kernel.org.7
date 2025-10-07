Return-Path: <linux-kernel+bounces-844576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3172BC2412
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526D13AC162
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD72E889C;
	Tue,  7 Oct 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pico.net header.i=@pico.net header.b="UZfjbaSi"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021096.outbound.protection.outlook.com [40.93.194.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699B1D5ABA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858242; cv=fail; b=VuGPfv+LbT8BHaqDKmesv/S7ft8STlvXna54277qqMsIL5QkVaX1UoapKs0+B+sEvo4ZK0zD8XApvZSb77JQ2iYP0orJOYJOZ4P0Ax8URmXyaBZ+JP6taD5HUKSc1Tm0x3jno71wJHh6gR/+pS7mY9jveCQJ0t3b3Z5ny7vqkLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858242; c=relaxed/simple;
	bh=SXwrQRUdCnRClxXyRpf1q3SQI3mb0UII/ECk1lmkpsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxvU+xhe578QrRtXwGLe7nHsk9BnU67aPdB1I/wMlLITXT+JRUDu3OeeF4WKmagLv/SztBcSTSNB0587b7acCoLXd864E9LEXvEbwtCQAXr3f2sI3UY51tw8ctpEl55mz/JxyGModBNqdsL5qDReBKHfEC9Xgm3Qg3UfzHessjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pico.net; spf=pass smtp.mailfrom=pico.net; dkim=pass (2048-bit key) header.d=pico.net header.i=@pico.net header.b=UZfjbaSi; arc=fail smtp.client-ip=40.93.194.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pico.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pico.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBnydLXS9PKagIx5HrACd1W1Dqx5H6G93wu0SYG4I3PIgDBxZimcDyHoM+52W7wqT6bD6t5zrE8qVUWYYKHb7cKk4YYkoxDs5hDLBxLb9lRHoYt87hyt79Lyh7EIrIc09NIYH7Txp92VPzgp4IA2Rlh2ZNM9UJM5Eqqv429XPoLP4wcf5uJKBTO6SIre4a80qPkbQRUxdcNQDBJmkoS/6YJZ9JGW1e1F3MPiTbdQ3ekgVl8HhafbPFaI8KWseG1AtgW998TC8X1+L2+tYOF3FsRkeMT8B/b5yYGlTQizrgsAwbYgEmov3o4iIwQKWVhu4zk81kKosNJD0nCNTwq7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXwrQRUdCnRClxXyRpf1q3SQI3mb0UII/ECk1lmkpsQ=;
 b=YatCdNcXlLqDwewRqKdRgYrapyEXKHKz0ewmIkrDisl4W8SOExWX8qDEEqrZQ8SlmyiqVtep6CBZrTEXrzjsy+NriGdktoG6xo448tVlIR4taUreemFEkA3/FsqipiIvDDYv56dUPQomYUx23S+g1BJpm7m444L9aMOg3Ik67RCl7LDKPi9W060yrZDfT1qKqFOF2vluceCF9hBmvIXGmykP7IXHe28gojZXkkJTUI+q//rAKfMq7/p1EMRA0HQu9a5Swx6/jOsy060ubJZCDx1+YCtFQIe8u6urm2+gbLOVwL38KybOmzpsjK8b3nv8frb3rUWGqM2CFfQUgNezRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pico.net; dmarc=pass action=none header.from=pico.net;
 dkim=pass header.d=pico.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pico.net; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXwrQRUdCnRClxXyRpf1q3SQI3mb0UII/ECk1lmkpsQ=;
 b=UZfjbaSi30IXO26McoszS28cG7FurqvS0dbFiRn55owz4JZcQajyKd9aGmscs8nkBODdzf2CqikMf8cSCKTKIX5MROXKuejjtG/zZ1GOgoZdsWMCt3RbKbiqoQ7VYYh51ZJGQSOXQ1oElj2zOSn6XkVOuW263fzUf6nH/cw0ntq3BRQ5RZ6k6IUAq1xrpWcMTsftYxD4Pi7PYDLH9cIkbbcRClYeaBOXM41Dn25YNaQQyDDOJHcReOFgBPkURaaui+zSw7OjiZtE7CSp/k61Oq5pE429P78HLGuJJZRrduz7z3tTGFu1uHSEd8an1ynuL9z60s9xieXWnyGOgR3fjA==
Received: from IA2PR22MB5609.namprd22.prod.outlook.com (2603:10b6:208:4bb::5)
 by EA2PR22MB4755.namprd22.prod.outlook.com (2603:10b6:303:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 17:30:32 +0000
Received: from IA2PR22MB5609.namprd22.prod.outlook.com
 ([fe80::94ac:e1f6:1aa8:3c4e]) by IA2PR22MB5609.namprd22.prod.outlook.com
 ([fe80::94ac:e1f6:1aa8:3c4e%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:30:32 +0000
From: Filip Barczyk <filip.barczyk@pico.net>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "Mario Limonciello (AMD)
 (kernel.org)" <superm1@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Thread-Topic: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Thread-Index: AQHcMintX0Ynf8ethU6MZXcy0IjNS7SsBeyAgAFJPwCACah3Gg==
Date: Tue, 7 Oct 2025 17:30:32 +0000
Message-ID:
 <IA2PR22MB560981589D6CB9BCBAEF603A90E0A@IA2PR22MB5609.namprd22.prod.outlook.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <94cd8a1f-1f2a-4cd6-8ab8-49b9d1e9fa2d@kernel.org>
 <20251001134612.GA738751@yaz-khff2.amd.com>
In-Reply-To: <20251001134612.GA738751@yaz-khff2.amd.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pico.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA2PR22MB5609:EE_|EA2PR22MB4755:EE_
x-ms-office365-filtering-correlation-id: 5b807fcd-a463-4153-a19e-08de05c737ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+niR2DRkRw/Uw2SNQZ37noR0NieYlrRvLnRFoR4jk5j6WaU9GcI03KKVu7?=
 =?iso-8859-1?Q?Ns8kCjG4ZoxTP7p0FSW1/CWJIWjWVMUGOdfGEWuWqxOlZSCVXxvQXbXhHc?=
 =?iso-8859-1?Q?FSuhb/g7748/H4Mns/1m/Fp1DKOHJcGFT2TdgDUtCUlbhk2R28G3ut9+Yi?=
 =?iso-8859-1?Q?QeMrmT7M6Q5l/SC/GjXYXKYby+J6SapMb/P8rtzg5dtY4Y0g4rt86Lz6Qz?=
 =?iso-8859-1?Q?mWVpQBAdRWtsG3cCD/GmAzcETO8XavbVVn6H2zXJ45ugtlO743hzdTvnEW?=
 =?iso-8859-1?Q?MmDFpxqKhlXaJ6q1fl6j/LcOYG6NUaQWPs/EEsiqQTMWDa2e+YKfGUSfBV?=
 =?iso-8859-1?Q?7x6YPeIO1WIOrsz70c34rV/Bz4agwIXPAjh8ZylpNApGNZBjHVPs0lCRmi?=
 =?iso-8859-1?Q?jbQ0jwoRWsrgNTE7XMy1jLUkZ2CLEBzPfnTkGutYwvGF6er0oiIIj7JccN?=
 =?iso-8859-1?Q?sJhdvQ+cAINje5EoLnk6ik06lps1pEEaAxFHtGlOgOR0HQKLmnRE3HRmRh?=
 =?iso-8859-1?Q?dnWNAkwtZCIZCS3wWl3sNZXpLMM1EJyZ890KFA5JICDndulD2Naultj29M?=
 =?iso-8859-1?Q?fQ7ZeVKxKh8k8NtL9wcRuyIiSN8DRXipI8+ElHQV7UXcJfqY4+WHBd75fW?=
 =?iso-8859-1?Q?s7HY1lEFM9mwHtk99TRvIFzd2k66fwd5Jmh+uIa+ZL2uA5suZsVz0YXs1U?=
 =?iso-8859-1?Q?pPxyAujDASEP6eo2XkOWpFJJ1f7g9OiLJjyvxxi5u583CNPn1WAgUS1bbg?=
 =?iso-8859-1?Q?+1VX4QITi5Dx9j6zBvWg3/ERDBw1rs+xgZrFa1Wxh219HftjJsH5A+tjCZ?=
 =?iso-8859-1?Q?Y/j15E0Q8W5B8c8vCf4GIPlLX0rm4BH4YctqPG2oMqDnWPJtEmDoYzLfQR?=
 =?iso-8859-1?Q?f3P7t0RxZVO5dsRHQx9IxoRA6jpYg863aA86pw0J7RkSqR0cuRtEvY1Pe9?=
 =?iso-8859-1?Q?eZEM7NHFTfysq1quCZLhZnw1Oa427OPjZdaomnrPUFJCht2swXy8mNaDYA?=
 =?iso-8859-1?Q?w+BNTzJEG2UItSn3BDg5WngBg/W87cCoLmyIypUwDc0Sk8tlxAxVLkspFq?=
 =?iso-8859-1?Q?yxI+DeHCmHCLeLUCg2gPDGYute6LESSPrr48rYSqE8RVPxpZqx39Yi/SHh?=
 =?iso-8859-1?Q?Zoa2X7sE2CNEclcQuIACPyUy9kJulunQGxsMdFwQXPOWAf5HY0QjCNWLTO?=
 =?iso-8859-1?Q?TPWJ/xnQEME0dgsUCbt/BUMikrqx8hx0Jt1dWqVZTMsxX+WZmkbmnMyJov?=
 =?iso-8859-1?Q?IzcKFcxFoBVc3m9Yfl/bXVDphjVgnU/Dk8BSAQTcN9IwZA527f6hjdfOLg?=
 =?iso-8859-1?Q?TEC049D/DJtvNB3l9hbEAPjmcnWhq2qpDmvTeac5Su4+Vx6pXC+LxCOhhw?=
 =?iso-8859-1?Q?29oQBUZyyl+0qAjKJ6CS53hoWFJcZdr+ELVAo8qQIhrZVQ4HTWWbeC9o6G?=
 =?iso-8859-1?Q?e4bsbUX0kZtWQ3xfCaGkHKuoy9WMA9HHVhyKi6F1r5axGKZC/Vvr4EhrbI?=
 =?iso-8859-1?Q?1XhHzJBegRR3zlrP3w0739NGbJpTpasTYx5UnKbeOuKJJwisRoVvzZwDag?=
 =?iso-8859-1?Q?0QguhynwXwifLede5l30mgW/olag?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA2PR22MB5609.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0EozS0oAzNMA58/aOrMqBStv0z8hqzpa+2gAtj0ugo6Enpc/J+g4jg79Df?=
 =?iso-8859-1?Q?1zIF4lKzCcJe4xJ5M68gEqAv7wn6AG+IfF5Te1sX3ourXWnZAH7jb3CSzj?=
 =?iso-8859-1?Q?u89FflrMwrH2e83wug7On/799CtmZwvVwa3d8N36C6GxVbSA2zCS9NklNV?=
 =?iso-8859-1?Q?VGeOI8rnHMmV1busOcCumXmuXeUptM9bn0mmAU4k+brMDUp2auxLmhtL1f?=
 =?iso-8859-1?Q?qxDBI7W1PC+uJZL4LQQm49JjJfJkQNZeR92TaRvf5ULQwDaCDvcEzv6/cD?=
 =?iso-8859-1?Q?3GZIXUjtkLJ28tezrYoR5z5rx5nQHMy27/IG4Jp8L4wDrMXgHHGTodUNJ8?=
 =?iso-8859-1?Q?zJ/OKxDEGwMsQjkWINn6OvhbkJGLjLh4oMYJtG0O7FXO6Fn7M/Xswpyz8z?=
 =?iso-8859-1?Q?zAbUrwDN5JmxAvKf2b/gYklQ1j+OThjfPUVp14btcm9+Y7hxmHVHzu8pb5?=
 =?iso-8859-1?Q?e6tF8wO9wztOry+lv8XGk3mlify/qYpmSG3dHjWthTXAdEJXWBfY6gRAfn?=
 =?iso-8859-1?Q?diUT7Ov5NyUPi/bB9kJ5E1S0RWm4+8aHcw0CsTQ487cje6ZhYkiLA7W3oa?=
 =?iso-8859-1?Q?GR3V9cxNb+B3F7gOVaqiJPNZ0YWu1YskFz57ljIJ3ZFpmhHvT7eb4Iy8cG?=
 =?iso-8859-1?Q?LFMnEvNs0+7RiBmssktgnI3Luh9mFRy9mVBlehpCjfma6oCisUJsKmPXsp?=
 =?iso-8859-1?Q?sO+vMWKB4jugzndJAgmvTE1cfsFH4QTXujvlkJgpy0lB9pRhqMSSBAaJUK?=
 =?iso-8859-1?Q?NY8M+NunmIF9+w3pUOZ73a7Rd7tpilZrTMucf2pG8G+l03RHnRDxfxWSey?=
 =?iso-8859-1?Q?QUqFyuxJDbwd3wgskP9iy5DKK3m3kAb2zP4+Fi1TacvnkKX5bj/lx7i/s1?=
 =?iso-8859-1?Q?+rtMdG36iybUvNO86GOnf7BldyLUF7vOfeVJuIaY6EYXIJGO8JesIJolyM?=
 =?iso-8859-1?Q?/yWKLu7mEModWj3URWuP/Ox46v9zXukbTtivB9DGZZU3NTAIPoLkGNPyQR?=
 =?iso-8859-1?Q?FOnx3N4jZd0fs4ZQeZbBlKRnBkXLWbo22Rbw9Sv1sXic7STjqWiM1YRqvC?=
 =?iso-8859-1?Q?t6ndH1uhpBJWjHzPc6WYf3KOqu0QWkh9hp4QcF2W2J1bjujE71Gw0bHzY1?=
 =?iso-8859-1?Q?iXmbPGOuV3FkNR6Lv6m43bfT+H5rUJZEeWKr6Xz30P3VpaXrL6AgfJi67P?=
 =?iso-8859-1?Q?H/0etqxFqc6EhiBAyqbkqhM8ohyzhgvvQuhf9ba+2Dn/ySlXp6k4D2C41U?=
 =?iso-8859-1?Q?7jOHl+zgf7hHXIZz2EHlpjdC99YoWMaw+jqLEgv7q7O2j1Ui4Ed24BSAl3?=
 =?iso-8859-1?Q?XpdhsUqRIrBdpD7U6BmmNc3NEGR4ue5X2Z+oTl8lgE/WIVgdUaY39SY9Zk?=
 =?iso-8859-1?Q?ms9Da9X3Eq5Q99b1TV/TWa015wYlXK1l71e2OMuH39dDmX9Ejjv75BeP6H?=
 =?iso-8859-1?Q?USp1FDWEmYguprbUFhssKNIgwpDm/fdTEJz4DkvD+R10XypbqC7ZXe192+?=
 =?iso-8859-1?Q?XhcsXUCDafU/pUCYTP1vh7OIoBbBBtw6/XwEKTy/edPteQrZJ9xkgINh7i?=
 =?iso-8859-1?Q?qNtt0Uk3FVWjG3spBbtl0tJhBNCEwMWYTdjPzaRqahpvStRsfG2AongTyI?=
 =?iso-8859-1?Q?8m365z4z98h+BajMPID9tXvFStmT83MDOmCSgl7KMi3uc4KxsPkYBZsQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: pico.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA2PR22MB5609.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b807fcd-a463-4153-a19e-08de05c737ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 17:30:32.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a472a2bd-3702-45a8-8dea-b9e904aa059b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3gtsmtGh+R/8MUiyT+cSBHGAX1xEGU7LP68/LqdfHyhhu2t+1Ux8CsssK4H6RYudXYr7PVL9SHho0VhvyRG/KlBIoTR9REokYH44C5lzTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB4755
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: IA2PR22MB5609.namprd22.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 165.225.16.101
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-disclaimer-hash: bca61952c1a5fdf9848b2982c03a9501578b27bdd50184715eb45205411272b2
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: EA2PR22MB4755.namprd22.prod.outlook.com

<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">On =
Tue, Oct 01, 2025 at 03:46 PM +0200, Yazen Ghannam wrote:</span><div class=
=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(=
0, 0, 0);">&gt; On Tue, Sep 30, 2025 at 01:07:47PM -0500, Mario Limonciello=
 (AMD) (kernel.org) wrote:</div><div class=3D"elementToProof" style=3D"font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt;</div><div cl=
ass=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Apt=
os_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: r=
gb(0, 0, 0);">&gt; &gt;</div><div class=3D"elementToProof" style=3D"font-fa=
mily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, s=
ans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; On 9/30/2025 11=
:45 AM, Yazen Ghannam wrote:</div><div class=3D"elementToProof" style=3D"fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; Recen=
t AMD node rework removed the "search and count" method of caching</div><di=
v class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; colo=
r: rgb(0, 0, 0);">&gt; &gt; &gt; AMD root devices. This depended on the val=
ue from a Data Fabric register</div><div class=3D"elementToProof" style=3D"=
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; tha=
t was expected to hold the PCI bus of one of the root devices</div><div cla=
ss=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Apto=
s_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);">&gt; &gt; &gt; attached to that fabric.</div><div class=3D"ele=
mentToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontS=
ervice, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0=
);">&gt; &gt; &gt;</div><div class=3D"elementToProof" style=3D"font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; However, this e=
xpectation is incorrect. The register, when read from PCI</div><div class=
=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(=
0, 0, 0);">&gt; &gt; &gt; config space, returns the bitwise-OR of the buses=
 of all attached root</div><div class=3D"elementToProof" style=3D"font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; devices.</di=
v><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">&gt; &gt; &gt;</div><div class=3D"elementToProof" st=
yle=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &=
gt; This behavior is benign on AMD reference design boards, since the bus</=
div><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedd=
edFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11p=
t; color: rgb(0, 0, 0);">&gt; &gt; &gt; numbers are aligned. This results i=
n a bitwise-OR value matching one of</div><div class=3D"elementToProof" sty=
le=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &g=
t; the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 =3D 0xE0.</div><div cl=
ass=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Apt=
os_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: r=
gb(0, 0, 0);">&gt; &gt; &gt;</div><div class=3D"elementToProof" style=3D"fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; This =
behavior breaks on boards where the bus numbers are not exactly</div><div c=
lass=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: =
rgb(0, 0, 0);">&gt; &gt; &gt; aligned. For example, 0x00 | 0x07 | 0xE0 | 0x=
15 =3D F.</div><div class=3D"elementToProof" style=3D"font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt;</div><div class=3D"eleme=
ntToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
">&gt; &gt; &gt; The bus numbering style in the reference boards is not a r=
equirement.</div><div class=3D"elementToProof" style=3D"font-family: Aptos,=
 Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; f=
ont-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; The numbering found in=
 other boards is not incorrect. Therefore, the</div><div class=3D"elementTo=
Proof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&g=
t; &gt; &gt; root device caching method needs to be adjusted.</div><div cla=
ss=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Apto=
s_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);">&gt; &gt; &gt;</div><div class=3D"elementToProof" style=3D"fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; Go bac=
k to the "search and count" method used before the recent rework.</div><div=
 class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, =
Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color=
: rgb(0, 0, 0);">&gt; &gt; &gt; Search for root devices using PCI class cod=
e rather than fixed PCI IDs.</div><div class=3D"elementToProof" style=3D"fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt;</div>=
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">&gt; &gt; &gt; This keeps the goal of the rework (remo=
ve dependency on PCI IDs) while</div><div class=3D"elementToProof" style=3D=
"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; be=
ing able to support various board designs.</div><div class=3D"elementToProo=
f" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &=
gt; &gt;</div><div class=3D"elementToProof" style=3D"font-family: Aptos, Ap=
tos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font=
-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; &gt; Fixes: 40a5f6ffdfc8 ("x86=
/amd_nb: Simplify root device search")</div><div class=3D"elementToProof" s=
tyle=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibr=
i, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt;<=
/div><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11=
pt; color: rgb(0, 0, 0);">&gt; &gt; Was this a publicly reported failure?</=
div><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedd=
edFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11p=
t; color: rgb(0, 0, 0);">&gt; &gt;</div><div class=3D"elementToProof" style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; &gt; If s=
o is there a link to LKML or a Bugzilla with the details of the failure</di=
v><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">&gt; &gt; you can include here?</div><div class=3D"e=
lementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0,=
 0);">&gt; &gt;</div><div class=3D"elementToProof" style=3D"font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 11pt; color: rgb(0, 0, 0);">&gt; No, it was reported off-list=
.</div><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Emb=
eddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">&gt; Thanks,</div><div class=3D"elementToProof"=
 style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cali=
bri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&gt; Yaz=
en</div><div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Em=
beddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);"><br></div><div class=3D"elementToProof" style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">I confirm that=
 an issue where EDAC fails to discover DIMMs on Dell PowerEdge R7725, 2x EP=
YC 9475F @ kernel 6.14.3 is fixed with this patch.</div><div class=3D"eleme=
ntToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
">Thanks,</div><div class=3D"elementToProof" style=3D"font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0);">Filip</div><div class=3D"elementToProof=
" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cal=
ibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><br></d=
iv>
________________________________
 Pico Quantitative Trading LLC ("PQT"). This e-mail (including any attachme=
nts) is intended only for use by the addressee(s) named above, and may cont=
ain confidential, proprietary or legally privileged information. If you are=
 not the intended recipient of this e-mail, any review, use, disclosure, di=
ssemination, distribution, printing or copying of this e-mail or any attach=
ment is strictly prohibited. If you have received this e-mail in error, ple=
ase notify Pico immediately by return e-mail and permanently delete the ori=
ginal from your system and any hard copy printout thereof. E-mails are not =
encrypted and cannot be guaranteed to be secure or error-free and, as with =
all Internet communications, information could be intercepted, corrupted, l=
ost, destroyed, arrive late or incomplete, or contain viruses. Accordingly,=
 Pico accepts no liability for any errors or omissions in the content conta=
ined herein. In compliance with applicable laws, rules and regulations and/=
or at its discretion, Pico may review and archive incoming and outgoing e-m=
ail communications, copies of which may be produced at the request of regul=
ators.

