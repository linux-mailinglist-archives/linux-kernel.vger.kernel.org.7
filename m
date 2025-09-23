Return-Path: <linux-kernel+bounces-828880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7726B95BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A522D1889B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B4321268;
	Tue, 23 Sep 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R5s1o+Nh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OFfuYF56"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA12874F5;
	Tue, 23 Sep 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628013; cv=fail; b=kMHa9epJ/1iJyo7a5gr9LOkW0QTtrGxrplG0/KWttjjw39Rom5/ILF0qGgFteTialS3yuRFndz6NFslmdIc847uSlkAlWvuxeQ20TfQhMTuU2nosSQNUK8GUSlNgl5z85WP2BQrP4sS4peJ3w6yvYM/kiPjzqWF9iqE9Fip0eyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628013; c=relaxed/simple;
	bh=6ZYMQaU6iTg+ntCigY8yuUCj8932fWsL3KO1t44ENSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ArvCOntUarTjvyIXZ1n8yiEK20CiDpzQ2xaldNn++YtonKFtK4nuGnhiwyrZgp0xUHw6RWfuPy1rTVV8uytqim/G+TzgNu1mloNRry17l93FXHLtyGpuhkaXw5x1LKp8uwaJmhGM7d0GAyXdBWJ3CRYwz+k+5NisD/wRrEaKas4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R5s1o+Nh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OFfuYF56; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fa3084a8987211f08d9e1119e76e3a28-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6ZYMQaU6iTg+ntCigY8yuUCj8932fWsL3KO1t44ENSI=;
	b=R5s1o+NhrCdQiQ/chE/6GONh13+T6LJi58V6lAcr9LBicnCuz+kA291EWwj/h0BmxzE0q+AaY7orzyv262itoCFyhqfa4qPnG92Sil1wMfUB/Byjf8Q00o1LKCBX3Y9LjlMTxLZA+jX9SUlNQf2n9xPv90VZK/EhYZT6nqtiTII=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:9a448058-7a4a-485f-8198-17d97e12c5cc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:0e87c321-c299-443d-bb51-d77d2f000e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa3084a8987211f08d9e1119e76e3a28-20250923
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1918477589; Tue, 23 Sep 2025 19:46:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 19:46:42 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 19:46:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGmy5A86vq/ybh5GlZm1U6ke4lsWukL7/+u9k+X5eDWqqDuuCiJTVc/q+o1xeMlEhW2URTBdwNsl36H/jgCJ9688fEu1nHWWvAw6r4eke15mZgCABsUvGrNyWaHAIdUqTDkwxdivFphCWsP1jk9dhVN0AHWnosYcDc0+EIGi6zbOKXsqlz3P1cs+6kbAKLNN96JiawJLPYNnCS/8CEuvRat5zJMHV8l+cvr38xXO3LPN0uu09gb9Cud8rvpKDpOe2U7kf0pgk9gjfDJD6E9yK5AI/KIihBoTjc7q8dUn6N8aaP6mrSQ7QWrKMcJum9JaZXNvEhR2DGq2dMWdWwMUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZYMQaU6iTg+ntCigY8yuUCj8932fWsL3KO1t44ENSI=;
 b=mrRvrLkJWQzTOKpWMgPdUmSTOmCZ8hnrV/cMu5sKmaoCEZrdgFAd5OJ/fClCq74zq3+Flo3iGRMel/bLioWsB8fKiiJR/hzmfztrBdx5aJVlRNBfMTjQZFENpprlcqUQ6yDA/De/ir/tYUabalbuANuoR/TjeK7dWbHeOGzb9jGrG5fnQoKaj1mtX2JQZ+Q6A9TDrR3Nhl55eoUcaMbZIsOSoUeXVrLgjGWjnQjBUZSqG1uYXe/VoNq3EnCOn+o/yczqlLQYHiY6RsNXlgMopsgkiNmgTko7hoQ6J+PUTxJkD/jRFYftjQDBIZ5sXxA8I0tZCdGR8hwBxdQRwk4HQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZYMQaU6iTg+ntCigY8yuUCj8932fWsL3KO1t44ENSI=;
 b=OFfuYF56vk7m+/aGUq1wgyvsJ2p5pH32lseb4rylaTgAf07TmavPmP61D6ClSq2bErLUkSqg17KmNrFWyWqkGdKqEc+wXdYDK6ODF8NargpIU5/iv8EY7r9OmbZaxcR0FFwH4EhzE7w2m16dMA14Ri7qCYVVY6uD3NBU4JTco94=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TYZPR03MB7083.apcprd03.prod.outlook.com (2603:1096:400:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 11:46:38 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 11:46:37 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"nicolas.frattaroli@collabora.com" <nicolas.frattaroli@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgACRkwCAAIY+AIAAKeQAgAIpV4CAAcjDAIAAYpcAgADhGgCAAG01AIAALKKA
Date: Tue, 23 Sep 2025 11:46:37 +0000
Message-ID: <15f3bb4bd00925636922871160b46f1104d409b7.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <13850137.uLZWGnKmhe@workhorse>
	 <eb9b0ea70abb09f45c50e88b6221948ae09be6f7.camel@mediatek.com>
	 <2382077.ElGaqSPkdT@workhorse>
In-Reply-To: <2382077.ElGaqSPkdT@workhorse>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TYZPR03MB7083:EE_
x-ms-office365-filtering-correlation-id: c16bb2cb-a515-4768-4877-08ddfa96daa6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUx3Z1M3U0xsdjBtNTBnRnRYQ29DbDJVcHc3QmREc1lrb0RHWGZCVEJ0eWt1?=
 =?utf-8?B?SFM3cHJDSFl4ZTgxOGRJQW05Ym9YRXRFVEpOcmg2S2lJU1A0QW9zQUxIRUdu?=
 =?utf-8?B?Z2VVQUIzVjBKZCtZZy9wWnJTd2dXanp2cEdXdzdFOGcxM0toVjNCcnc5ZERS?=
 =?utf-8?B?bkpqM1I1SWZvR0tVMDRDSUhxVVRyYWMvQzJLTEIwTUh0YmVic2tDNnlBVUdF?=
 =?utf-8?B?dHRvS0dZc1BWYU8raUhDZlRldHcvSzdVaSsreFFyTU9lMVR2TmxYa2EvZWpx?=
 =?utf-8?B?K29BMFl0RlMveThyTFBZM2hUQUlwTTlUTys2L0FadGR1cGZVd2VGTHZaalFD?=
 =?utf-8?B?VjIrUWpUZHlwaGpJckNZMStTdXk0ek00a2M3VzJyK1JyRDMzRnYreko2RkRu?=
 =?utf-8?B?YjlJWHNwQlBNS1RXemlERUtLVDQ3RTZnSmJHSjh2TElycE5abVQ2Vk1LOTYx?=
 =?utf-8?B?UmprOHFmbEF0TkIyT004OTlyVThQMWdWeHI5cUt4bGhqMFVGWkVya3IreVhV?=
 =?utf-8?B?UXc4T0luazBXdzdoeG1iUlhDc1d2NE8xZjAvdWs3OCs3K3pxLzFEbFdnQnJy?=
 =?utf-8?B?NkpIQzZJNDRkczZMdTR1dEJzeUxWOC9MSk5iZG9URDRPQWZabk5YRWNpRS9H?=
 =?utf-8?B?M21lT2U4L1lXZ2ZMUUloU1A1a2JUNmFkWGRvZFVoczlmV1pJVXBtazRpYjdB?=
 =?utf-8?B?dWQ4cG5ack00WSt5a2RHcHlmc25OSmRQVWJJKzcrVFJNTFVrcWhOQ3dHcFJp?=
 =?utf-8?B?anRVdHpMbUFUWEYvQ0lwQ2JsRW9scmZDamNBeVlyT0JTUmluQXR6eTFwRFgr?=
 =?utf-8?B?RmFMYXA2b1NFc3F5a3ZBZUkzVWZCMTIxNlBXeE1TV2RucHMvVTlCUEs5VmZr?=
 =?utf-8?B?ZWFFQmNOUTZzMTRheDkvR2Npb3E5RXdkVmNja1BzWWVhc2c5RkVaTmQrSGsr?=
 =?utf-8?B?QnEyRW9BS2t4UytRT0p3cWw3dHdaN1dPZXozWVdNSGJnSG1rZ1JrKzlOUlps?=
 =?utf-8?B?dU4xWFB5aXhZQWQ1OUNvT2trTmE3Y0lOQWxOeTZuaVBrQWVxVWVQV21tbkt3?=
 =?utf-8?B?ME95YWF2YU8zdDB1ZzEwKzVudm5LUVRTVmMwaUxtN2wrUm14YkxXL2xraUcv?=
 =?utf-8?B?aExCK2VWdTRmYjVOWkMwWnN6bS9jU0R3a2RhU2Y2MmcvREdDTEN0d0FoenVm?=
 =?utf-8?B?QWl3VytCTlNJa3BIdkw2ejc1US9hcXBIQkpvMjc3NUlUeExDS1FzSGtmRVYw?=
 =?utf-8?B?TERxNW1yYzdCMUorTzhaYmlWVTZJUGw3RVUrUStZcEhGenFrc0F6OTNVRE9i?=
 =?utf-8?B?SkorZnhWTFNvcXhYbDRyWnFrWkpKWWJRYi9PQ3E1T2I3d3ZCbStrMmlpNkx5?=
 =?utf-8?B?UXg0SHkvaWcxekJWRndGaHNSb3E4aUMwRjVGOHYxWnJ0QkJ6UHJibVFQRm9i?=
 =?utf-8?B?d0lWNy8xV1UxMFM4YUhMQWNrYUozZ2tqQzdXNGtHM2N0NTZmWjd6M1o4VUJB?=
 =?utf-8?B?b1plL2hLOTFGSXpTVnBZMEt0eFhzb2RrSllHa3BXdnVEam5ETUVKVHZUOXM2?=
 =?utf-8?B?SlRSZStXaVZxL2VScnljYWVrUWtkcTh4cEJ6OHZwckVrek44VXFwNVBEZWF0?=
 =?utf-8?B?a2pIM3FNOXlQZFFKUDFZMk16aVpUNWhBQmNtZE4ybVQyNHUxYit6aFFPRVlK?=
 =?utf-8?B?Ung0bjM4ZnNUZ3BvaGpkUnZtd2cxVHlzYVYxZDJHTXEzWGhlbVlQcC9yUTM3?=
 =?utf-8?B?ZHZ0WUFIcTNySnZxWnFsNWhOT2JJT3BvN3EraExXL1NXNC9jS2RPbTJFN1hJ?=
 =?utf-8?B?TGRleUYreGFYQ2pWSkVTbCtGWUI4dXNnTHNIZVE1YWRqcHU4aHRVUVlnZ3hN?=
 =?utf-8?B?UnlzUWNvWjhueU9SS2Fsbk93MHBtWDZVLzVpdkFxQi9GdDdBLzduTmZUSk56?=
 =?utf-8?B?UjFLd2kxSHl1YnRJaWxXQTF2Z1lSOUc5cE5uWTJySmFEdFNUaEhnTkFDNExk?=
 =?utf-8?Q?O9iuYSaOUr0pL35VH1g7xYqUE+v7I4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODgrVnZ2VUsxVnB6a0tzbk5ReWMvb281aEtxS0MvemQrRDZBeTBnc0c1cU5s?=
 =?utf-8?B?VzRWaFlsMmFISXhubzI3Rmk4RFY0eGN2SWFMVTdqUm52aUNKMUl1bkhYTkVk?=
 =?utf-8?B?Y0ltRlg4T2RRRFM1bFRMaGZKMzFQQzRNWXJJNGg2S24rb0xnc0RabDVoYURr?=
 =?utf-8?B?ZDhWZzhSdXpKVzJsOHlKVDhsR2hEMUZWVGl4QjVsdjd6YlUxMXgvMVgyZkFW?=
 =?utf-8?B?ZlFmZ3JNLzdPeVlhT0tYb3l1bmlONnJBeXRkK3JWemIybDZad2dqSldDM0Vr?=
 =?utf-8?B?NDlLSVBIRzQyc3RQSGMyWTJSaUlMN1NieGxLeFVJWWx6eW9oQlVla2hlMjlU?=
 =?utf-8?B?SitjamkyV1g0WWw0L0tQK0JHZVV2bFNGL3hJQmdOYWhrS2h1WDVDeWtUTHo5?=
 =?utf-8?B?ekg5Y09lcktvNTJ0OG5NNmdqbEh4NTdEeU4zaEJxeU9INHVaaXdwOHNJMlQx?=
 =?utf-8?B?VnBZUWJBeHd1QTQxNFpTYkdTdTJGSTVQRy9USlpRV3lHRVRiTk9Qd0t0aUcv?=
 =?utf-8?B?a2xHUU9tNzdFazRUckRrbXR0Nk5ublVNWnk2SURKanhkdGRqandMV1JLQW04?=
 =?utf-8?B?TUo1TUgxeVpJbEw0d1oyb0h2QW9lOHJQZXhhNjlTWkZyRjZ5TG9mejhGSDNt?=
 =?utf-8?B?Q01JeDV1TDVBeXAvZWdrRXdqYkx4SnBYdURkenc3TE50ZjNpaDdIamlQeUMv?=
 =?utf-8?B?QzVzQWpJYnJpVkljaW9UMGxCMzRGSXhRWHpWU2piSWIxb294am1rSGlWc1Vp?=
 =?utf-8?B?bDVQclpkMmNRVEpSLzFuaS9zRXNnbGN6czh5Zms0TGU1S3pINVVhRldnckxF?=
 =?utf-8?B?M0tHOElvN1Nsb2pzUjA1eEN0b056S05JL0l3b3o3VDEzTi9RekYwcUwybkRa?=
 =?utf-8?B?RFljaCtDY0pVRDdaeFg0N2pOM0RMZ1ZrZXQ5T3FKZkwwUUpVNzE1ZmhBODZG?=
 =?utf-8?B?eDUrWmx1czJydlJsV051RDc4aU9ucmFhbmE2eFhUVmszdlloUm5UTGIrM1ZR?=
 =?utf-8?B?NitaZ3hxeEVqdmd3Z3FHSU9nMjB0bzYrTzdWdjc3bnNMNnl5YUVTSUJBc1Nz?=
 =?utf-8?B?T2liR2JuOHcrRGoraUFLeks0bWtaMExzdzlTUi9TV09IaDNWVHAzM3hNRndt?=
 =?utf-8?B?UWFHMm5QdmVZbXpBUStKWS80ZGZtWmJZTEs3MS8vaVJ4YlJxSktScVppbUJ0?=
 =?utf-8?B?MTNVSHhoVWc3QnlOdWJKbThPZnNIYWc1M2YvMys1cUgzVXNLZUNtY0F3YlJ2?=
 =?utf-8?B?TkFkNFZpbTg5OVlGY1hkalN5WmtxdWErMFR2bVZML1RteXJsUWpXb0JPL2R5?=
 =?utf-8?B?clI3aWo4TTlaNEZSeVFPdlZTSUNoQlB4RDdBTGh5SmlZdjQwRktUTUhzMDJP?=
 =?utf-8?B?UklsRnNlbDg4MW1zTXRkRkxpRmNLOUNzemRKRHhGNGV5N1hKeEhSZHl5dEE2?=
 =?utf-8?B?aHVuVFFBVlNyYTVFWWdUbW1MTlpZVlpqaWJQYXJwZ2RtTnVGUXlFK0txdy9z?=
 =?utf-8?B?cHpXNnZYcEtBSzByTDVWMmdDOWhLWWNJczFSV2tSczRoNkxIRUt6bU04MWhR?=
 =?utf-8?B?aG5ScFBJdStST0IvS2Q4NER0R3ZFOW5QSTRYN0hwQm1vUHEweHUxNldLZGhS?=
 =?utf-8?B?MUtZM1hEcjQvT2xBNk9KODRmMzdsSkwxWFpwenRnT2hYMGpQMTR3QitpSjBZ?=
 =?utf-8?B?d2VaN0RJZlAxcUdFVnhwY2NpTis1Tk5WeEdxeFloempFU1ZuR1dUd1hWY3dy?=
 =?utf-8?B?RFZ4MEovQ3AxeXVvaDB0eU9CS1FPWERHaC9OQ2RwUElVWmNVVDRMN1ZHdWdR?=
 =?utf-8?B?L0hLekNhOTRiTncraEZGNDFXNXRuVHZZTmM3Z0k3d1hEQTVFVnhoVEFRYTIr?=
 =?utf-8?B?QmRDUHhSSy9IT0RYa1lGVnFaUnZvYXJveGpiaVc3Q21hdTRCTC9ZeE5qSUJZ?=
 =?utf-8?B?TlI5ZFF4UG40N0R6RkNQRmRxaUJDL0tGQ3Y5R3l0K05ZK2ZMWG9KQ1lQTWVa?=
 =?utf-8?B?dkVOTFM3anRUNDVsYlFTaXdnL2NFQ3pVamRDKzhlb3R5N2wwVllYajhHaEJz?=
 =?utf-8?B?K293VmQxNTB3UzRkWCsxVFcva3FmVVlsSEpoS1ovam83VHRTWlBPSnRsdFNh?=
 =?utf-8?B?aUVlRm9hK01wQUpPVmhOVHp6RlQ3LzRVdC81NWZvaDRSZEw2SUJhTXppdVND?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED4880B0945154439C5235432B5BB89C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16bb2cb-a515-4768-4877-08ddfa96daa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 11:46:37.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKtuudE1A8aRXfWIhfyqyCbWAEXFPrteEVCmWXDP2N8Afzy2LWiiyJ8Onp8mw6C4PoEiBbSmU5Rr0ZCJ1J0LOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7083

T24gVHVlLCAyMDI1LTA5LTIzIGF0IDExOjA2ICswMjAwLCBOaWNvbGFzIEZyYXR0YXJvbGkgd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gVHVlc2RheSwgMjMgU2VwdGVtYmVyIDIwMjUgMDQ6MzU6
NTkgQ2VudHJhbCBFdXJvcGVhbiBTdW1tZXIgVGltZQ0KPiBKamlhbiBaaG91ICjlkajlu7opIHdy
b3RlOg0KPiA+IE9uIE1vbiwgMjAyNS0wOS0yMiBhdCAxNToxMCArMDIwMCwgTmljb2xhcyBGcmF0
dGFyb2xpIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+
IE9uIE1vbmRheSwgMjIgU2VwdGVtYmVyIDIwMjUgMDk6MTc6MjcgQ2VudHJhbCBFdXJvcGVhbiBT
dW1tZXINCj4gPiA+IFRpbWUNCj4gPiA+IEpqaWFuIFpob3UgKOWRqOW7uikgd3JvdGU6DQo+ID4g
PiA+IE9uIFNhdCwgMjAyNS0wOS0yMCBhdCAyMzowMiAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToN
Cj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3Blbg0KPiA+ID4gPiA+IGF0dGFjaG1lbnRzDQo+ID4gPiA+ID4gdW50aWwNCj4gPiA+ID4gPiB5
b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIEZyaSwgU2VwIDE5LCAyMDI1IGF0IDI6MDLigK9QTSBO
aWNvbGFzIEZyYXR0YXJvbGkNCj4gPiA+ID4gPiA8bmljb2xhcy5mcmF0dGFyb2xpQGNvbGxhYm9y
YS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiBGcmlkYXksIDE5IFNl
cHRlbWJlciAyMDI1IDE4OjMyOjEyIENlbnRyYWwgRXVyb3BlYW4NCj4gPiA+ID4gPiA+IFN1bW1l
cg0KPiA+ID4gPiA+ID4gVGltZQ0KPiA+ID4gPiA+ID4gSmFzc2kgQnJhciB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gT24gRnJpLCBTZXAgMTksIDIwMjUgYXQgMzozMeKAr0FNIENoZW4tWXUgVHNhaSA8
DQo+ID4gPiA+ID4gPiA+IHdlbnN0QGNocm9taXVtLm9yZz4NCj4gPiA+ID4gPiA+ID4gd3JvdGU6
DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCBTZXAgMTksIDIwMjUg
YXQgNzo1MOKAr0FNIEphc3NpIEJyYXIgPA0KPiA+ID4gPiA+ID4gPiA+IGphc3Npc2luZ2hicmFy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+
IE9uIFRodSwgQXVnIDIxLCAyMDI1IGF0IDk6MTLigK9QTSBKamlhbiBaaG91IDwNCj4gPiA+ID4g
PiA+ID4gPiA+IGpqaWFuLnpob3VAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gLi4uLi4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvc2xhYi5oPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ICtzdHJ1Y3QgbXRrX3ZjcF9tYm94X3ByaXYgew0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gPiBNYXliZSAnbXRrX3ZjcF9tYm94JyBpcyBhIG1vcmUgYXBwcm9wcmlhdGUg
bmFtZSA/DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICB2
b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IGRl
dmljZSAqZGV2Ow0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBtYm94X2NvbnRy
b2xsZXIgbWJveDsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgbXRr
X3ZjcF9tYm94X2NmZyAqY2ZnOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBt
dGtfaXBpX2luZm8gaXBpX3JlY3Y7DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiA+IE1heWJlIGFsc28gaGF2ZSAic3RydWN0IG1ib3hfY2hhbiBjaGFuWzFdOyAiIHNvIHRoYXQN
Cj4gPiA+ID4gPiA+ID4gPiA+IHlvdQ0KPiA+ID4gPiA+ID4gPiA+ID4gZG9uJ3QgaGF2ZSB0bw0K
PiA+ID4gPiA+ID4gPiA+ID4gYWxsb2NhdGUgb25lIGR1cmluZyB0aGUgcHJvYmUuDQo+ID4gPiA+
ID4gPiA+ID4gPiBBbHNvIGlmIHlvdSBoYXZlICAic3RydWN0IG1ib3hfY29udHJvbGxlciBtYm94
OyIgYXMNCj4gPiA+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gZmlyc3QNCj4g
PiA+ID4gPiA+ID4gPiA+IG1lbWJlciwNCj4gPiA+ID4gPiA+ID4gPiA+IHlvdSBjb3VsZCBzaW1w
bHkgdHlwZWNhc3QgdGhhdCB0byBnZXQgdGhpcyBzdHJ1Y3R1cmUuDQo+ID4gPiA+ID4gPiA+ID4g
PiBTb21ldGhpbmcgbGlrZSAic3RydWN0IG1wZnNfbWJveCIgaW4gbWFpbGJveC1tcGZzLmMNCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJIHJlYWQgc29tZXdoZXJlIHRoYXQgdGhp
cyB3YXkgb2Ygc3ViY2xhc3NpbmcgaXMgbm90DQo+ID4gPiA+ID4gPiA+ID4gcmVjb21tZW5kZWQu
DQo+ID4gPiA+ID4gPiA+ID4gSW5zdGVhZCB0aGUgYmFzZSBjbGFzcyBzaG91bGQgZXhwbGljaXRs
eSBub3QgYmUgdGhlDQo+ID4gPiA+ID4gPiA+ID4gZmlyc3QNCj4gPiA+ID4gPiA+ID4gPiBtZW1i
ZXIuDQo+ID4gPiA+ID4gPiA+ID4gQW5kIHRoZW4gY29udGFpbmVyX29mKCkgc2hvdWxkIGJlIHVz
ZWQuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSSBkb24ndCByZW1lbWJlciB3
aGVyZSBJIHJlYWQgdGhpcyB0aG91Z2guIEJ1dCBJIHRoaW5rDQo+ID4gPiA+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gPiA+ID4gZXhwbGljaXQNCj4gPiA+ID4gPiA+ID4gPiBjb250YWluZXJfb2Yo
KSBpcyBlYXNpZXIgZm9yIHVuZGVyc3RhbmRpbmcgdGhlIGludGVudC4NCj4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEFuZCBob3cgZG9lcyBjb250YWluZXJf
b2YoKSB3b3JrID8gOikNCj4gPiA+ID4gPiA+ID4gdHlwY2FzdGluZyB0aGUgZmlyc3QgbWVtYmVy
IHRvIGl0cyBwYXJlbnQgaXMgdGhlIHNpbXBsZXN0DQo+ID4gPiA+ID4gPiA+IGZvcm0gb2YNCj4g
PiA+ID4gPiA+ID4gY29udGFpbmVyX29mLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
LWoNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBXaGljaCBpcyB3aHkgaXQncyBjb21wbGV0ZWx5IGVxdWl2YWxlbnQgYW5kIHNpbmNlIGNv
ZGUgaXMNCj4gPiA+ID4gPiA+IHN1cHBvc2VkDQo+ID4gPiA+ID4gPiB0byBjb21tdW5pY2F0ZSBt
ZWFuaW5nIHRvIGh1bWFucywgY29udGFpbmVyX29mIHNob3VsZCBiZQ0KPiA+ID4gPiA+ID4gdXNl
ZC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5vYm9keSBpcyBzdWdnZXN0
aW5nIHR5cGVjYXN0aW5nIGNmZywgZGV2IG9yIGFueXRoaW5nIGVsc2UuDQo+ID4gPiA+ID4gVHlw
ZWNhc3RpbmcgYmV0d2VlbiBtYWlsYm94IGNvbnRyb2xsZXJzIGlzIGZpbmUgYW5kIGFyZ3VhYmx5
DQo+ID4gPiA+ID4gZWFzaWVyDQo+ID4gPiA+ID4gb24NCj4gPiA+ID4gPiB0aGUgZXllcyB0aGFu
IHVzaW5nIGEgY29udGFpbmVyX29mLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC1qDQo+ID4gPiA+
IA0KPiA+ID4gPiBPSy4gSG93IGFib3V0Og0KPiA+ID4gPiBzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpw
cml2ID0gKHN0cnVjdCBtdGtfdmNwX21ib3ggKiljaGFuLQ0KPiA+ID4gPiA+IGNvbl9wcml2Ow0K
PiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQW4gZXhw
bGljaXQgY2FzdCB3b3VsZCBiZSB3b3JzZSwgYXMgYXQgdGhhdCBwb2ludCB5b3UncmUgdGVsbGlu
Zw0KPiA+ID4gQyB0byBjb21wbGV0ZWx5IGlnbm9yZSBhbnkgc2VtYmxhbmNlIG9mIGEgdHlwZSBz
eXN0ZW0gaXQgaGFzLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+ICAgICAgc3Ry
dWN0IG10a192Y3BfbWJveCAqcHJpdjsNCj4gPiAgICAgIHByaXYtPmRldiA9IGRldjsNCj4gPiAg
ICAgIHByaXYtPmNoYW5zWzBdLmNvbl9wcml2ID0gcHJpdjsNCj4gPiBUaGUgdHlwZSBvZiBjb25f
cHJpdiBpcyAidm9pZCAqIi4NCj4gPiBXb3VsZCB0aGUgY29udmVyc2lvbiBtZW50aW9uZWQgYWJv
dmUgYWxzbyBoYXZlIHRoZSBpc3N1ZSB5b3UNCj4gPiBtZW50aW9uZWQ/DQo+ID4gDQo+ID4gVGhh
bmtzLg0KPiA+IA0KPiANCj4gTm8sIGluIHRoYXQgY2FzZSB0aGUgY2FzdCBpcyBpbXBsaWNpdC4g
V2hpbGUgdm9pZCBwb2ludGVycyBkbw0KPiBzdWJ2ZXJ0IHRoZSB0eXBlIHN5c3RlbSwgdGhleSBh
cmUgbmVlZGVkIGluIHRoaXMgY2FzZSBiZWNhdXNlDQo+IHRoZSBjb25fcHJpdiBtZW1iZXIgbmVl
ZHMgdG8gcG9pbnQgYXQgc3RydWN0cyBvZiBhbnkgdHlwZS4NCj4gDQo+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgd2hlbiB5b3UgZG8gc29tZXRoaW5nIGxpa2UNCj4gDQo+ICAgc3RydWN0IGFwcGxlICph
ID0gc29tZXRoaW5nOw0KPiAgIHN0cnVjdCBvcmFuZ2UgKm8gPSAoc3RydWN0IG9yYW5nZSAqKWE7
DQo+IA0KPiB0aGVuIGlmIHRoZSB0d28gc3RydWN0cyAoYXBwbGUgYW5kIG9yYW5nZSkgYXJlIGlu
Y29tcGF0aWJsZSwNCj4gdGhlIGNvbXBpbGVyIHdvbid0IGV2ZW4geWVsbCBhdCB5b3UsIGJlY2F1
c2UgeW91J3JlIGV4cGxpY2l0bHkNCj4gY2FzdGluZy4NCj4gDQo+IFdpdGggYW4gaW1wbGljaXQg
Y2FzdDoNCj4gDQo+ICAgc3RydWN0IGFwcGxlICphID0gc29tZXRoaW5nOw0KPiAgIHN0cnVjdCBv
cmFuZ2UgKm8gPSBhOw0KPiANCj4gdGhlIGNvbXBpbGVyIHdpbGwgdGVsbCB5b3UgaWYgeW91J3Jl
IGRvaW5nIHNvbWV0aGluZyB3cm9uZy4NCj4gSGVyZSdzIGEgdXNlcnNwYWNlIGNvZGUgZXhhbXBs
ZSB0byBpbGx1c3RyYXRlIHRoZSBwb2ludDoNCj4gDQo+ICAgICAjaW5jbHVkZSA8c3RkaW8uaD4N
Cj4gDQo+ICAgICBzdHJ1Y3QgYXBwbGUgew0KPiAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1l
Ow0KPiAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgd2VpZ2h0Ow0KPiAgICAgfTsNCj4gDQo+ICAg
ICBzdHJ1Y3Qgb3JhbmdlIHsNCj4gICAgICAgICAgICAgaW50IHg7DQo+ICAgICAgICAgICAgIGlu
dCB5Ow0KPiAgICAgICAgICAgICBpbnQgejsNCj4gICAgIH07DQo+IA0KPiAgICAgaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIqKiBhcmd2KQ0KPiAgICAgew0KPiAgICAgICAgICAgICBzdHJ1Y3QgYXBw
bGUgYSA9IHsiR3Jhbm55IFNtaXRoIiwgMjAwfTsNCj4gICAgICAgICAgICAgLy8gd29uJ3QgY29t
cGlsZSwgZ29vZCENCj4gICAgICAgICAgICAgLyogc3RydWN0IG9yYW5nZSAqbyA9ICZhOyAqLw0K
PiAgICAgICAgICAgICAvLyB3aWxsIGNvbXBpbGUsIGJhZCENCj4gICAgICAgICAgICAgc3RydWN0
IG9yYW5nZSAqbyA9IChzdHJ1Y3Qgb3JhbmdlICopJmE7DQo+IA0KPiAgICAgICAgICAgICBwcmlu
dGYoIiVkXG4iLCBvLT54KTsNCj4gDQo+ICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgfQ0K
PiANCj4gSWYgeW91IGNvbW1lbnQgb3V0IHRoZSBzZWNvbmQgc3RydWN0IG9yYW5nZSBsaW5lIGFu
ZCB1bmNvbW1lbnQgdGhlDQo+IGZpcnN0LCB0aGVuIHlvdSdsbCBnZXQgYSBjb21waWxhdGlvbiBl
cnJvciwgd2hpY2ggaXMgd2hhdCB3ZSB3YW50DQo+IGJlY2F1c2UgdGhlIHR3byBzdHJ1Y3RzIGFy
ZSBpbmNvbXBhdGlibGUgYW5kIHdlIGRvbid0IHdhbnQgdGhlDQo+IGFzc2lnbm1lbnQgdG8gd29y
ayBpbiB0aGlzIGNhc2UsIGFzIHRoYXQgd291bGQgYmUgYSBidWcuDQo+IA0KPiBUaGUgc2Vjb25k
IHN0cnVjdCBvcmFuZ2UgbGluZSBhbHdheXMgY29tcGlsZXMsIGV2ZW4gdGhvdWdoIHRoZSB0d28N
Cj4gc3RydWN0cyBhcmUgaW5jb21wYXRpYmxlLCBhbmQgd2lsbCBjYXVzZSBub25zZW5zZSB0byBi
ZSBwcmludGVkLg0KPiANCj4gSSBob3BlIHRoaXMgaWxsdXN0cmF0ZXMgdGhlIHBvaW50IEkgd2Fz
IHRyeWluZyB0byBtYWtlLCB3aGljaCBpcw0KPiB0aGF0IGV4cGxpY2l0IGNhc3RzIG1ha2UgaXQg
aGFyZGVyIHRvIGZpbmQgaXNzdWVzIGJlY2F1c2UgdGhleQ0KPiBmb3JjZSB0aGUgbGFuZ3VhZ2Ug
dG8gc2ltcGx5IGFjY2VwdCB0aGUgY2FzdCByYXRoZXIgdGhhbiBnaXZlIHVzDQo+IGEgY29tcGls
YXRpb24gZXJyb3Igd2hlbiBzb21ldGhpbmcgbm9uc2Vuc2ljYWwgaXMgYmVpbmcgZG9uZS4NCj4g
DQo+IEtpbmQgcmVnYXJkcywNCj4gTmljb2xhcyBGcmF0dGFyb2xpDQo+IA0KPiANCg0KSSBzaG91
bGQgbm90IGRpcmVjdGx5IGFzc2lnbiBhIHZhcmlhYmxlIHRvIHByaXYgYWZ0ZXIgYW4gZXhwbGlj
aXQgDQpjYXN0OyBpbnN0ZWFkLCBJIHNob3VsZCB1c2UgaW1wbGljaXQgY2FzdGluZy4gVGhpcyB3
YXksIHRoZSBjb21waWxlciANCmNhbiBjYXRjaCB0eXBlIG1pc21hdGNoIGVycm9ycywgYXZvaWRp
bmcgdW5leHBlY3RlZCBlcnJvcnMgY2F1c2VkIGJ5IA0KZXhwbGljaXQgY2FzdGluZy4NCkxpa2U6
DQogIHN0YXRpYyBpbnQgbXRrX3ZjcF9tYm94X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpj
aGFuLCB2b2lkICpkYXRhKQ0KICB7DQogICAgIC8vIHNob3VsZCBiZQ0KICAgICBzdHJ1Y3QgbXRr
X3ZjcF9tYm94ICpwcml2ID0gY2hhbi0+Y29uX3ByaXY7IA0KICAgICAvLyBzaG91bGQgbm90IA0K
DQpzdHJ1Y3QgbXRrX3ZjcF9tYm94ICpwcml2ID0gKHN0cnVjdCBtdGtfdmNwX21ib3ggKiljaGFu
LT5jb25fcHJpdjsgDQoNCg0KDQogICAgIA0KDQo=

