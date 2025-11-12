Return-Path: <linux-kernel+bounces-897062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B19C51DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37D818854D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D95311C33;
	Wed, 12 Nov 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqfqRAsX"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC474311C35;
	Wed, 12 Nov 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945805; cv=fail; b=pKbSU0txbWWEctOxggQjFvchcVfleWP4+pSK0z7WQrf+ipVLdb3uRdRZx9hFl5ra/ZKnZo2G8n9K/R7gxbJxCN0+6oq/50tUmX3JpsaAOukqHCZk5QVuKTZmWb9yK5suR7eHF+i9dKF0N0lm2Q3bwecWZbevh72PM/6i3bkaWq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945805; c=relaxed/simple;
	bh=rcS2frbFmxb1wXuKgV1Z6RwzdyBns5WsuBuWo7bXpZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVzh2DDzWG0DgWQFnqaQoxs3JSABwTWML3RZFwbVS00Fk2WMmW06PxpESxMIUBpNg79hbPgUUcBJ+p3fwHW/go2jfgvhp6au5vu+iUKxvTJC1coiQF7PGVT5xuuxy9nTMIYHmYi0W79B23t2mJkgPRKIydJokGcvJdfz80OTrsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqfqRAsX; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCQ1y6thLmdYolgqrPkxYFJ5/rNuWK+wO8y4tiJrhFGdXUCO9B4uYh3qpI3kIr4KESaXD5v3CxbssGf3WbYpttFyRjEUySH8Fn/uFtXXqdiI/5nqcmdJtz8TFXeJ9rLGIqqRyXa0CLCUpf/CdyRmUj/0RthEQvG+4PNDfPmD8lsH8IQZR8GBVO9cZxyj6I4fOiVm2SRmhGUMb7oEXYFPBLJAMKDonQvZjkc9Q1MSfL5O5q/P2vqI/cGGrJCjp60A3SHDUSaNXu/4hv3ioMIor79BPUQwKNzqEI6/XLVtjRUhGw/Gp4NhRB4zT33bIxrCO9lvyO/KoeZdtZ+kTeNS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvZYOn7f/IYF+Ux94f6rk4xh7kKGvvZ3jqvNp+guTgc=;
 b=y6HBHwvFRm0b6LW/o5L3mbI1PCa6flGHisvoRE1iPmhc9nKAxkEmT3aM9B2Do4FiYEMho3FeAaS001kmad3+3/C2xjo0HSN1ef79eJGnUI1/0P+eaNI8+DG+Le2lo+otiAiH9+432QYu0q9MJlJAi7S4ZojPEJgjaNgkQkywotzq9ff5zUD+MfeBhCiH2yliTJGZahSDIvsRKiAEtEkxXGy4f8pbt9oYg71+UHce2M3N4kOfk1qjCgAneMLbbYSjBzLI0DvwSuFXjIoqHSZJfT9po6jEubLrjRAY4q3i9f+Jtb1mnCdq3KN8Gc4n/YnHUz/UZmd5327L2cpSPK7pMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvZYOn7f/IYF+Ux94f6rk4xh7kKGvvZ3jqvNp+guTgc=;
 b=EqfqRAsXkj9E+p1LqS+m2M4d7HvmheFZepHrKmKD+1MzuofgY8Mo+xsECnTPYpcb95y6v45mtmMENRMxnqETEaiFBX2RxWQtu0FpZH1rW0zgwZ9OZa7zdyy1J8MRxoQw/kFpAjGmAQwqAfp+EAGX7fXPJt4SuybeSJIE73yP1Yg=
Received: from DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) by
 IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Wed, 12 Nov 2025 11:09:59 +0000
Received: from DM4PR12MB6301.namprd12.prod.outlook.com
 ([fe80::dde1:c5dd:8672:1095]) by DM4PR12MB6301.namprd12.prod.outlook.com
 ([fe80::dde1:c5dd:8672:1095%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:09:58 +0000
From: "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To: "Frager, Neal" <neal.frager@amd.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jguittet@witekio.com"
	<jguittet@witekio.com>, "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>,
	"Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>,
	"thomas.hommel@emerson.com" <thomas.hommel@emerson.com>, "Saleab, Micheal"
	<Micheal.Saleab@amd.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "peter@korsgaard.com" <peter@korsgaard.com>, "Frager,
 Neal" <neal.frager@amd.com>
Subject: RE: [PATCH v3 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
Thread-Topic: [PATCH v3 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
Thread-Index: AQHcUtm9tp1C9hyiREOhZD1yR0IzG7Tu4glg
Date: Wed, 12 Nov 2025 11:09:58 +0000
Message-ID:
 <DM4PR12MB63012DA79681159E2BDE8EFA9DCCA@DM4PR12MB6301.namprd12.prod.outlook.com>
References: <20251111070555.1169130-1-neal.frager@amd.com>
In-Reply-To: <20251111070555.1169130-1-neal.frager@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-12T11:02:42.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6301:EE_|IA0PR12MB8905:EE_
x-ms-office365-filtering-correlation-id: b2eafa1a-144e-45af-f578-08de21dc04ab
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2/mBRcxGpXajY7Tt4oAg2MtiziSVt0cC48+VQtdgWdV2M6oiWKkIBaYWPrEP?=
 =?us-ascii?Q?uCpfcTps/UDM5v/rlLCrJQoiphynZFR84x2Vixhy9GAvCCBYsuOTbejtCHv0?=
 =?us-ascii?Q?iySeIpxJycIC9HlPWitzK3w4QaWO5OTjwB1JWQZAxdNIsVevi/jxWUdi3LAP?=
 =?us-ascii?Q?JL1HgW4rolkEOJjk699QhR47O3vgygaFOOpQubkI26mxOK3EI7Zlc4z3U/tf?=
 =?us-ascii?Q?YukbWU30iBIAI9FAYl02Th4vQ9kLrLY6XHsAau3HDp+FM+C0I7syuRoMUqCX?=
 =?us-ascii?Q?TnH/V9gJ+PL2VbRCzr5JJnkgG151CI7FfDF2KnBS4opoEccmupJANuF3Dzh4?=
 =?us-ascii?Q?b7+CMxaGlswSA7T4qG1Qsj8p6T/zL5UMJvevp7EuPXCwmGaquffMZsSH3A8K?=
 =?us-ascii?Q?EaJ6YsK/Y1xw+mc/j428EPkCQYMg6aZzeJfy2ywo2dfEYmePtmAJtXck0Atn?=
 =?us-ascii?Q?3gkZZQGcHWqGClmcqyQ8fIP9pgfDUj/k8uSue1V8RPduoKOZ4EhDAGVuuv8Q?=
 =?us-ascii?Q?8jZblGznyOWg13mu3ODbM31bkmulLoIjN4cQGFKIKxw4g/VwEbIliYh21mMp?=
 =?us-ascii?Q?XNwpucRX429KkslpV0eGShS47PfS7IahLg3XzyW40u1VOqcdRBzVlIntqhat?=
 =?us-ascii?Q?AnGSungljzLnLirbDxwkltWlNir/5pGMPA5QbJf/Pf92DE+8hX4O774EUWo8?=
 =?us-ascii?Q?pTOdFEpdKpFXaGVaqRdhND5XOkeaynBb+uqaVFuY4hFrEtblhpvSOJt/QTxL?=
 =?us-ascii?Q?ghqE6RxvE2dk0rbteYypX0cybGIclrMAod4pecuz++OYcbzZE3xgKwlV7c8C?=
 =?us-ascii?Q?XfceVUBTHfckasOxbLPs8D+s8b5SC8+8zrl/1GwqUDsT6PJ/z+kZzba9p9YF?=
 =?us-ascii?Q?/2cjatuqCgkXSmLhJ8HdWwYA4g61o23YaFT3hnOtkzKptqVw08y+s9pPy+Z/?=
 =?us-ascii?Q?UJeLV9QgwZLgK8la7xy6vY7W+BFcsCOo/V83sFadtjJRLudtF3WN6TjI+Rj4?=
 =?us-ascii?Q?HSVTos3lMbI5INzKfk+QwAvrwwzRlJhtuez3pHA0KOhK1QMgdFpR0fYsLh9t?=
 =?us-ascii?Q?OOZRiS9AWTYsbuj/H1haEO3QvR82ozK3MgUy5P0gSLnzBbOCwiunmmyWJeT9?=
 =?us-ascii?Q?s31Y74kAiYORF0h3u8HeJy+WWINoJ8qfD2W53snt/+PVbTP642hKcB860qa1?=
 =?us-ascii?Q?wGJOzMIV0WbqOM/hEQj9u3LmKJJuhOF4i4J2cBi+4aW5hn/5lOyxiS1mmeSH?=
 =?us-ascii?Q?HfFrgMGZSQFSOPR7cC4dI/M+U///49JYWEMb3jXPvuI75dzhS4Aw/j3W6WJk?=
 =?us-ascii?Q?N5aMmqZEVHP/NDv1EOW1Z72vNMvKQbpv2f11/8PMaAVhdLLsfmgwg7JDFU6e?=
 =?us-ascii?Q?kTLzyRbxtt9ED0MVdz1NzDXO9Opoc/HOhYVnDSeU+koF9mqUy1NQgkbgZRlV?=
 =?us-ascii?Q?LzPQFKm68PTc8fTDqzWDsWW6n2e+U+c4RzuB6E/OZJ4S64fA36oxiA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?poVTfM2slqXFyrojTIlmbUoimOcDcDXCZuis9J2P/RGUhHpj3PD1jFVD99Uq?=
 =?us-ascii?Q?cI/PbP1+om3+JbLEYtYnfbspBz698REAHg/Td/uBxXR4TFBdFTVEkJzeFNQW?=
 =?us-ascii?Q?UAMWssnc3T++Qir7ELivkcLrorJq7kgCu6+M4086Cg82MmnA2eVPMeVCoW+I?=
 =?us-ascii?Q?ng9VrpsDFH6hYp4uq8pa6vP6eYc8BCDFmQV1aqzth2zc6zj7rijBS1Zd25ZP?=
 =?us-ascii?Q?xtgz9UxeArJbTfxcvQ6dVMTGxD7cdyz/VL5/WNqbXdr8WktWRBngFgfFXnAD?=
 =?us-ascii?Q?/oeO50fKvvKFp9ZHEYjyt4RNMMFEqfSwfbPxaYJLCFU3lJ9P6vhiV07nZQoD?=
 =?us-ascii?Q?VtjwOJJem5+BasK7PyTLolU4qGkxuSm5+IkIkbicaTb+rzJ+i0XLdAShEMTf?=
 =?us-ascii?Q?9r4sPf06ZBvKYjgBjiN1cbX9FXm+FVr/QDjTY0xGuVBHEuHTNJWNSk+jBoBt?=
 =?us-ascii?Q?q9QMl2xp2qt1yIhnuxFU1r0k1gcfQ9hCGQqN0/m33SD6CKyNrd/axpYYLEBB?=
 =?us-ascii?Q?PaSnDrKdMQUe9i0s6dgkoXoBh9usRXu74OxU9m4AqtL+Xqn+o0hQgDREAQHe?=
 =?us-ascii?Q?qWtczISvRf5RlmI6ZY66d+y/D09MGTYMPLdncpPKFFBnhVVGzBdSaqKAdCzM?=
 =?us-ascii?Q?PIJuIhB4vs+zE7M0pV/wKc3Os94yyueBQyp5gJAtT3lveWClygf8QyF5JMjO?=
 =?us-ascii?Q?PjBREGbrLBD8a1angqvKDGVZu9w8FWgAM3b8+JzAG+mT7mkH13287cCVlfe8?=
 =?us-ascii?Q?gTw9urWIkebNKiL53LLGOTs+1sv29rTt78z/biOV2hDtyZwG5Io1GgZAwQR2?=
 =?us-ascii?Q?d6J53PSY1mgIlpsnlrEkAyaIIODiCjaNDVuhWlrJmfFWQrXXU9MwaZ+vnO/A?=
 =?us-ascii?Q?k4itWK0yPrafPyWuxD3mqU3s/dPsgOD08JhCrxT3lkv01QKeU4sHSZAG62mt?=
 =?us-ascii?Q?yhBZinITKD2nc4w5rAvZW1jYNxzhuLUsb1d/Rdis5mfTrn+GfZ995m5eCWqp?=
 =?us-ascii?Q?dKm22mo2owTfGSbOE1Jy3JEsDlBPDT62IuCBkGDVXfLFwMXDIRx2QQZo/KvH?=
 =?us-ascii?Q?sJOmC54TFezDdU2AdqIscv5EtRCb0BU8HpQ4xaRrkfD6HTbiOnE1Q7ln6mw3?=
 =?us-ascii?Q?v1NzXIXSX02o318gWq4lipeUAQLuysv1UY4DLN8GMcinZyPKDNw/cqzxsJW3?=
 =?us-ascii?Q?N/H9GFfsaicfbpf7DK3nrdPQTUZl0BwlHU+wwyXkDA+Nwi6Pw/CxSqJ4gQru?=
 =?us-ascii?Q?hAfColNZKiRRkc+M6BjFPBbjfr3p+Xa9vVIZRx9wKcyCTRhhmyqxtSizDcVt?=
 =?us-ascii?Q?bQyl827M3k17B+8ri3Y5IM6gW7ejabxqsmOZB/9Z8J0FJcF9XN6dvduuGudz?=
 =?us-ascii?Q?Sioa4n4EH2dLqamuLRdqszLdST0+C5y5bCW57+UWlIhjsulCJnNbiZ70kGfu?=
 =?us-ascii?Q?cAZmxiDsdLPZngRpYJMTKjcGgTQh0dMaUBm7RCHGv5t3DEKV0ZP8rJZ0TG5D?=
 =?us-ascii?Q?FirXSK0J57nB0cvilTu4fp8Ar1FiFRWQ6aJeAM8t4LQ260vBHiBxeEj1gK5t?=
 =?us-ascii?Q?z+IVUYgaA0Sjg+wx/E0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eafa1a-144e-45af-f578-08de21dc04ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 11:09:58.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qySQVBXNbaRde2TMnUcjufNIR/QXPxnGCbWxDum6S+4VpfsE/RaQXOLWay0UfRexDJ84oeSuAJUjbSHxBVg3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>

Thanks,
Jay

>-----Original Message-----
>From: Neal Frager <neal.frager@amd.com>
>Sent: Tuesday, November 11, 2025 12:36 PM
>To: gregkh@linuxfoundation.org; linux-arm-kernel@lists.infradead.org; linu=
x-
>kernel@vger.kernel.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
><git@amd.com>
>Cc: Simek, Michal <michal.simek@amd.com>; jguittet@witekio.com;
>Buddhabhatti, Jay <jay.buddhabhatti@amd.com>; Kannan, Arun Balaji
><arun.balaji.kannan@amd.com>; Thangaraj, Senthil Nathan
><SenthilNathan.Thangaraj@amd.com>; thomas.hommel@emerson.com;
>Saleab, Micheal <Micheal.Saleab@amd.com>; robh@kernel.org;
>krzk+dt@kernel.org; conor+dt@kernel.org; peter@korsgaard.com; Frager, Neal
><neal.frager@amd.com>
>Subject: [PATCH v3 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
>
>Since the following commit, the zynqmp clk driver uses the common
>divider_round_rate() when determining the appropriate clock divider for a
>requested clock frequency:
>https://github.com/torvalds/linux/commit/1fe15be1fb613534ecbac5f8c3f8744
>f757d237d
>
>This means that all the calculations will be in kHz when determining the
>appropriate clock divider for a given cpufreq request. The problem with th=
is is
>that the zynqmp.dtsi and zynqmp-clk-ccf.dtsi files have frequency definiti=
ons in
>Hz, so when dividing requested values in kHz, errors can occur with the
>rounding.
>
>For example, the current pss_ref_clk frequency is 33333333 Hz which genera=
tes
>a cpufreq parent clock frequency of 1199999988 Hz which is the same as the
>highest opp-table-cpu frequency in the zynqmp.dtsi.
>
>But if a user requests the value 1199999 kHz as recommended in the availab=
le
>frequencies:
>
>root@zynqmp:/sys/kernel/tracing# cat
>/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
>299999 399999 599999 1199999
>root@zynqmp:/ # echo 1199999 >
>/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
>
>The calculation will be:
>1199999988 / 1199999000 =3D 1.000001
>
>This will get rounded up to a divider value of 2 giving the following resu=
lt.
>
>root@zynqmp:/ # cat
>/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
>599999
>
>Also, if a user tries to work around this calculation by using any larger =
values, it
>still will not fix the problem because the driver will use the largest opp=
 in kHz
>which leads to the same calculation error.
>
>User requests 1200000
>root@zynqmp:/ # echo 1200000 >
>/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
>
>Driver converts any value greater than 1199999 to the largest opp which is
>1199999 and then calculates the divider value with the same calculation.
>
>The calculation will still be:
>1199999988 / 1199999000 =3D 1.000001
>
>This will get rounded up to a divider value of 2 giving the following resu=
lt.
>
>root@zynqmp:/ # cat
>/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
>599999
>
>This means there is no way to configure the zynqmp for the fastest opp usi=
ng
>the current dtsi files.
>
>To fix this issue, this patch updates the zynqmp opp-table-cpu and pss_ref=
_clk,
>so the clock rates are calculated correctly.
>
>root@zynqmp:/sys/kernel/tracing# cat
>/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
>300000 400000 600000 1200000
>root@zynqmp:/ # echo 1200000 >
>/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
>root@zynqmp:/ # cat
>/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
>1200000
>
>Signed-off-by: Neal Frager <neal.frager@amd.com>
>---
>V1->V2:
>- The clock-latency-ns and opp-microvolt values did not change, so simplif=
y
>  the patch by only changing the opp-hz values in decimal format.
>V2->V3:
>- Improved commit explanation
>- Added pss_ref_clk frequency change to the patch
>---
> arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  2 +-
> arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 16 ++++++++--------
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>index 52e122fc7c9e..482f432ba7f3 100644
>--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>@@ -14,7 +14,7 @@ pss_ref_clk: pss-ref-clk {
>               bootph-all;
>               compatible =3D "fixed-clock";
>               #clock-cells =3D <0>;
>-              clock-frequency =3D <33333333>;
>+              clock-frequency =3D <33333000>;
>               clock-output-names =3D "pss_ref_clk";
>       };
>
>diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>index 938b014ca923..dd9bd39f61e8 100644
>--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>@@ -103,23 +103,23 @@ CPU_SLEEP_0: cpu-sleep-0 {
>       cpu_opp_table: opp-table-cpu {
>               compatible =3D "operating-points-v2";
>               opp-shared;
>-              opp00 {
>-                      opp-hz =3D /bits/ 64 <1199999988>;
>+              opp-1200000000 {
>+                      opp-hz =3D /bits/ 64 <1200000000>;
>                       opp-microvolt =3D <1000000>;
>                       clock-latency-ns =3D <500000>;
>               };
>-              opp01 {
>-                      opp-hz =3D /bits/ 64 <599999994>;
>+              opp-600000000 {
>+                      opp-hz =3D /bits/ 64 <600000000>;
>                       opp-microvolt =3D <1000000>;
>                       clock-latency-ns =3D <500000>;
>               };
>-              opp02 {
>-                      opp-hz =3D /bits/ 64 <399999996>;
>+              opp-400000000 {
>+                      opp-hz =3D /bits/ 64 <400000000>;
>                       opp-microvolt =3D <1000000>;
>                       clock-latency-ns =3D <500000>;
>               };
>-              opp03 {
>-                      opp-hz =3D /bits/ 64 <299999997>;
>+              opp-300000000 {
>+                      opp-hz =3D /bits/ 64 <300000000>;
>                       opp-microvolt =3D <1000000>;
>                       clock-latency-ns =3D <500000>;
>               };
>--
>2.25.1


