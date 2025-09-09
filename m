Return-Path: <linux-kernel+bounces-807229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F9B4A1D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C99D4E1EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977C2FF65B;
	Tue,  9 Sep 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YDYMch1I";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rpmx0Lfs"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC092D8791;
	Tue,  9 Sep 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398460; cv=fail; b=aQlNZICVVcML0QYz+LtsdscAfI0/MWoqMTkGVprJFsXDBgMKZU4CkfOWqTl5ybTA22uSt87UDJv7xrtZBA1r7aSpfCjTEmL7WKXsuwQCy+ZC8E6+Vv2dlTzX8YBFsKCS+bsPM7/ecGmG/Np33Rn0bvZd98+d0/KY9/4MfSUYfYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398460; c=relaxed/simple;
	bh=9xv55ZPUE8HuVbRuHkJV0wd0E9E1w3bLV1ONWXHmWwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JoVD/xvQadFYHngkr12hvjYNN9eVsrngjZVTIqHB6M5qhWJwSmy5VF/s6DUbIEPt/tG4xHOeW0Jbh8Qrq1zIOyyvYRnSegieqPPKBTZsmVtTvku0kwRCR1XPDfZ5JjOFsu0xw5QPYpCEU3lL1/4a1ECjjyjlfT9Q3Grqjtp6w6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YDYMch1I; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rpmx0Lfs; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f70fca48d4411f0bd5779446731db89-20250909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9xv55ZPUE8HuVbRuHkJV0wd0E9E1w3bLV1ONWXHmWwg=;
	b=YDYMch1IONwfVw78T1XBhszOIjc+jSO4ATviFiKZE6Z7dZLXGpF+muW9HRuI1TjGKO6Cp8SuQOqwitwIutKjnf1U0u2aLSvohJDiFuEsgK14SlcfdmQCAA8pCgStR4yulthd0tZciSqNulIxk1qlaFm4cbGTaqiWWkzImwF1iTc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:e56cd51a-f34c-4625-a725-07a0b6ceebc6,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:1ca6b93,CLOUDID:d3065a6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f70fca48d4411f0bd5779446731db89-20250909
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1800367444; Tue, 09 Sep 2025 14:14:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 9 Sep 2025 14:14:03 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 9 Sep 2025 14:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHbk+35ciTUitJQxtIjWd0JLfjszZzbYhkb27OQg8t8V+19dIA+El3HRYJkVZ218Ggt0ZuogW6ihS1skaoISdBZCuFuOjUFboH0WBARWCR2/1WGWwrYjof92MDq+elws1TMlKrBagf9sfburvvnCR8e48S2yNaTvzmRonGJq2Oo+d6rjH9LRxhEXc7nGBOeRtlrZgH8FtSJH0BJ0LPDcDDaJ9KUwUIIbS8uFUR3NO1/ljRfhfMGz3YaBYPPV7D/HIvCe0gUC7zS1JQEpbnGYJ+12ZK3qneTfOQH0Qs9BAEDt/jA19XIQBfVnkIpH+b+xSYNh0nPMnMEwqPngS/L0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xv55ZPUE8HuVbRuHkJV0wd0E9E1w3bLV1ONWXHmWwg=;
 b=MWcYCJz21sz6NaokwGcPMN26qkbuEl9Xuq28EPwUtR51kIIR5BX8Zh5wJFQnjVVigFW7uVXP0m/5YYpriQgejm1qdn8EWNGAHYtdExyqxgjXUTdiChH1SC1Wp2wHhYXqeV8DykFe6k5f5rkAVY5Q8DPbqUjCmX8K0NUgnpjgSnziEB3o+potkDQ5nqpyxqBa6Ggr3I64+Bx8VTohmeTx4mtN222GrNtKc5q2lMKsmNXkw4/Rx/YQ2sorcFkJ+nLtB3P2XLMYjyh7NmTxYHb/K7UCNox+Pc1WfqP+BGHwlCbm7cty2pPGyo8fQZcf4s+YI3c4qb8pmdif6yAvOagOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xv55ZPUE8HuVbRuHkJV0wd0E9E1w3bLV1ONWXHmWwg=;
 b=rpmx0LfslcwBMAKtLqRiUqa1hkoXaE1hcYeMNyVJHrgH/DvRz4w+h0QfzdMVNtf8UZZGDtsZvnSK/3uquQcITerBdNf6VNYL//fHz3WsJ7dFy1/5XFqKqyBTZSBKClq5IIuBRd1i8/zD9UDc9DKeASVHUctHYZWj17OhUmHTyhk=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TYSPR03MB8160.apcprd03.prod.outlook.com (2603:1096:400:47e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:14:01 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:13:58 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 0/2] add VCP mailbox driver
Thread-Topic: [PATCH v5 0/2] add VCP mailbox driver
Thread-Index: AQHcEwpL8kDoXrhfyEqN1e7TUxj8CLSKe8WA
Date: Tue, 9 Sep 2025 06:13:58 +0000
Message-ID: <a88bab7a6d81e59b3381bca24a221055f754047e.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
In-Reply-To: <20250822021217.1598-1-jjian.zhou@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TYSPR03MB8160:EE_
x-ms-office365-filtering-correlation-id: acfba433-7fe4-49d9-c945-08ddef681051
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MnNCOHpYWE9mTTFHTVJOSDU1ZDRqbVpQRWNtdXowSzBVdG5kUmU2TFZZQVh4?=
 =?utf-8?B?TUYzbEtjN0NGb1VQWCszOTh6NEFlVEVsdGZPT3h3a3VGVmVFc1dxSmxqZ0JN?=
 =?utf-8?B?ak5Qd2RHQy9rUHQvZkVvUjNEYXhOYWJveU1kbFhJdWVZbUdzd0FCT1hkT3RC?=
 =?utf-8?B?TUl1ZjdoTHdQbkZXYkV5bTYyR1AzUTROdkRVNStYKzNLanBiWUtzMGtTZXcv?=
 =?utf-8?B?Tk53dzk1WWx1ZWljaG9hTTczZUY5R1U2RW96VXZHMXZZRkFlQmRzbDNZQ1Fu?=
 =?utf-8?B?cnN6VzVmMmRET25QbmZacXgwR2JoVUhURXFYSkJnSUxQcm1UZmFQS1NJRVlU?=
 =?utf-8?B?QjFYOSs0Y3crVmc0Tnd6UGhKRmtqSjdZUDNrL2FhL2xwOXZkT0RnMVdmODcy?=
 =?utf-8?B?TTlhNGpZREl3b3JrZWVSaTJSUUFzK3A1OERXeituOGltQ3hnYlZucDB4UGZk?=
 =?utf-8?B?ZkRteHBzOUhROExONW9xVytMNlNXWXFadzVYQ09nVFczempRV241QklDS0VF?=
 =?utf-8?B?U2ZqcXJ5MjFhMWZYVDlaWHNhbzVBdHNOc0VEaTJ1VjJtYVZFdmJPUEZkRkRW?=
 =?utf-8?B?Mi85M0wxVU1LN0kwaWxqdUFEYW1NYmpHVlZVRTlZNVgySXRzakRpRE1xeDR6?=
 =?utf-8?B?M2t6T3Zrcm10SldEWWs4NTJ0cXJ0bEg0dk1EZ21KVW5xelNDVE9CWVJuMG9I?=
 =?utf-8?B?ZnFiNTlwa1dLNW5RVDJQdVp4VjYyMk5VbVBuNVhhRk9sV3EvaXRMOGtkZEJW?=
 =?utf-8?B?ZlZya2J6V05jU0JIZGNjODFjRXVadTErSXBTQ3paSlQybG5PVlg1dW9odVVm?=
 =?utf-8?B?VzZMNHhuc3ppU2FVb2pFaGo1OEFuL2NObW9tN1FlUXRyWCt0bG0vOU4vS296?=
 =?utf-8?B?K01BYUFlSGdKTUx0Z1FEb1ljME5EL2YxOGU5a0ptRHBWU1Q5Q29YWEJzR2Zl?=
 =?utf-8?B?K2Jzcjlvb3pPd2NqZ1dFTG8vamY0SGVRYzd6TjJXNEZiM0Jyd3l6YlFVNmdp?=
 =?utf-8?B?K3RSb0J4OFhUeVM3NTJmWkY5TG5DZGNpdU5jcktoRGtQeEFYaHZtM21XSGFx?=
 =?utf-8?B?UjZpaFVvaTNwZXFxSDZzU01hQ3RuQTE1Tm1VNUxHcGhaWHRMb3BpYndJeGFu?=
 =?utf-8?B?eEhWcUhrMGxGaEtaYkpYSnB5Q3VCTjF4OHlDWFY5YXBLUlhDZVRpRTd0aUI0?=
 =?utf-8?B?NE0wSE0zNC9Xa0FWVE1HVGgyNHk5dkEzbU1FdTZZaU13NThlVCtmYkhKZXlQ?=
 =?utf-8?B?WHlzT2lvbURBdUMrUERLQkQ5VWIweVlMazRXbHJ3MjRXeFpkcnBzZjlQNTNN?=
 =?utf-8?B?VStRNG55MlJXa3E0eGcvVGRJbnlPd1A3QWg3VU9VZUU1MXRXelN4V3ZpNGNC?=
 =?utf-8?B?alQ4aEtEOVBFZGZ2N3c1TnBWTnROdUFXMUozR2NUd1J2eGF4SHRCQWJRWVlt?=
 =?utf-8?B?OFFtblQ2YktWMGNwdWdRMFFhQzVvVEdBTUxEZ3Q2UUlLc3pnclBqYTUvcWl0?=
 =?utf-8?B?d0p0VTRnNEhuL1Q0SnVSQXh2OUJVUWdtRXpiNndMeUVoVktiNXFYc2U1SUJq?=
 =?utf-8?B?bExLUmxVUHo5RzczdHlTUVRqbFpwWHUwQmtBV1FzQ0dQQVZLbzhWa2xDTFp5?=
 =?utf-8?B?ZU5yQTBPZi9rUTJMNXVsNlY1SVI3SVBLbGlDYy9tKzhQQ1dFQ0xDV0ZwM0VW?=
 =?utf-8?B?UFQ3OHlmeS9JMHhCUXErU052SEZhaU95dGVpdE5KT0Z5MUlqWlczZTNEbGxZ?=
 =?utf-8?B?TEtjTHdDbStFWXRZbzNFSThNd2dpME1GNVM2azl0Z2t2WFlxbm90b1Zkd0pa?=
 =?utf-8?B?V1E3YU93YjBhZzZZRFdEaDB6RWpuN3NZcmpUcnRHUHZvRkNMUloxUzV1YSs0?=
 =?utf-8?B?ZDdsVHFrdDBXcUY5eU1lTDF4Zm1YNlVkS3l0TVd0eTVCU1l3TWJHZEhYdnhC?=
 =?utf-8?Q?Q0RvEUtVY1hIehZCMGkz4xRrjPM0IiX1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGxoanh2MVR2R2ZSYkdlc3gvaHBYOHgxLzFQZDkrcWZ0RDZZcUt5TmdtQlVU?=
 =?utf-8?B?NDA0bjdSdElDK2RCYmhsSEg0dGplVkxyRE43YW1qRnpMS1dMOUduTG5qdEJ3?=
 =?utf-8?B?U0pYdnVGdkpDaVVNRHRZeFlXd09uMWdxbmxqcy81a2xOZnpEQmQvUk1DZExt?=
 =?utf-8?B?K3FRYTdhQmVlNjBIYy9lWitEQ0ZnTS9taDJNbVZQMEhLY3BORW0yYUNENjJ0?=
 =?utf-8?B?d1p2QzlqWFBmRUdTeFcxb1YxMFNLcHdTd3FkQnQvYWk2cHVkdWxNV3ZzMjVZ?=
 =?utf-8?B?SjR6TTN1NERKdmZocnpSYmpYbUpKaXBlZXdLWjJhQmkwM1QrWVpqTUMrNmZG?=
 =?utf-8?B?b1ZqallveUFIRUQ3V2lWQkUvdjlFenUwYXN1SkY0Tm5oRkZDcHdoT1p4dXc3?=
 =?utf-8?B?T3JhWld2dW1vM1VkYWMzS2FiblhEVFVFN3p4Wjc1WE0yYzlZUzRHcG9nUUNV?=
 =?utf-8?B?OU5sWVF1cjROQzduSlZicytwTzljT0FlQ1UzMDVZaFQ3bk83RFpyNXY3aXQ5?=
 =?utf-8?B?UytNVWJRZmljV01xaDZIVFhHVnppbmZkVk9ZQTFtbHYxRkI2REMxa2Rkenhw?=
 =?utf-8?B?R1NNV0xtVVhtckF3QXp3ZFcyL1JJNTA0OVNnQkNKSmRxMERBa0Y5VlRHdjB5?=
 =?utf-8?B?bkFNOElLV202TitoelFXZ1V6aThvVEtXQU9pTWlBU0NFNFN4dzNNeXljdkti?=
 =?utf-8?B?VHVYdDkzMy9RR2lyakpmNEpRZE41Yy8xZFBjK05qSnNXdmZpWk9NMmNvRUU1?=
 =?utf-8?B?TXhHYVRIM3JpN1RYcVd4MmRaNTdVM3RkaXFMcTI1MEgrNHNTWHZnMjhLTXNj?=
 =?utf-8?B?bWJDak84SnRwSVJaQjFDQXVaQk04cC9SVVZZeWVWMDFXSjkwMFc4cy9CcnRu?=
 =?utf-8?B?STBWcVhiUW5sWHZQNDlPbWEydlorWUlwZjdOWktWRlJKUVRNSmY2QW8wa1J5?=
 =?utf-8?B?SDlFa3pOL01CT1FmdGZaTEhzc2swemVmNmJpN09PbklZR0VlUFVvTUVzTzFC?=
 =?utf-8?B?dTQ0WXdPbWlVcGREdFJ4MHNDWmFpaWNHc0R2OUtmdUs0ZkdtcjNPN1VNSkov?=
 =?utf-8?B?QTFKWUJNcHBqY05yZm1tbjFNSjYwL0V4d2gxemNDemUrMXltUjdhS1pJMjdn?=
 =?utf-8?B?RXExZ1N5TkthZEowS0ZjSkpWUWpzTGVIL1F5bU95bEFLMEdWK2tUcGZ3bXlR?=
 =?utf-8?B?R3k5THR6VndqaUQ0ZGJtSGVoaXozOGFucDZKT01hamNIRFljUDVIb0ZoWXVO?=
 =?utf-8?B?V1ZnblRyZHprVTc0S2VIVkJ1MlVaWnhtQ2Z1OS9INGdXcTZXdVNvc0kwZXRx?=
 =?utf-8?B?ZzR1T0VZVVFGTzRScUtqRmdGVklENk5tQzFJVkVnUTZvUFFVMmZZSitJWEVL?=
 =?utf-8?B?Q1U0SEZxQk0vb0FUdXd6bGhNZWhxSmV5YjhqYVM2UktFcW15ZjlmWmUrclcz?=
 =?utf-8?B?R25KdUx5TDdnbmFsYjRQNk1CbW0xR0d0d1l6MXFSUkFuM1FUZTRuS09YSGxx?=
 =?utf-8?B?OVo3VEllcEw0Y0NEcWVsRjVsZ0xVc0NabEZKRDVsb29JV2sxMHVjVSt0eFhZ?=
 =?utf-8?B?d3Fkb0dHZ3l4UUwrb3NGVVZOMERHaHlkeGlmU2RGUVAvbDl3TkVIRUtDL1hW?=
 =?utf-8?B?TGo3bzRsMTVteDFVZkVKYWtKRGc1cGltSkxyT3JpT3FCdkVHWW5ucTlEdjUv?=
 =?utf-8?B?UG8rRnliWTJNM05WQVUrSkRkU2duZW5OQmNxWEI2c3FFRHh0ZFlPZ0RGcTV3?=
 =?utf-8?B?L2NzalpyZkQzRktCcWtXLzd5R3E0ZU5MVEtaVU5SY1duUmQwZHBFSUw0Tkt6?=
 =?utf-8?B?YmhMS0FWZWdFcWlySStqdEFTTi9DUHhaOG1KclNiNjJ3cmdySFNBbWFEZGFY?=
 =?utf-8?B?TllmYXY0THNnUm9xQkxFV2xDc3RXelpxSnpreVpVU2JIYTZESGtyZkZzTUEx?=
 =?utf-8?B?Qzk0YmhZMG01N2QrWVhKMGJReUJxUlB4MWliTzBNRVlvMlZLWmJOVWhtMlQ4?=
 =?utf-8?B?cDA3L2J5dVRpQ3cyeDhnU1U2TFZsVXBPNlMreENoakUwV0QyVWpSY1RTOUNE?=
 =?utf-8?B?ZTdJbVRZaUNoNTFYQWdTV1AxRUVjZzFiT0pYdWREMXZEMDBJd3B2bm0rK3dm?=
 =?utf-8?B?WTlidEZpSENhc0JFNFlIVFBhaW44ZHJBMG5hNmQ4ZXpiOWJCZ1FPSzVYbm1Q?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9A2DB897088A4097E00EC521DAAFB0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfba433-7fe4-49d9-c945-08ddef681051
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 06:13:58.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwN6oaZ7KtJmfqjaoGuRY3gtCXpgZ+1fgjclqz7HpzeJrb1u7Dv9VyJTjN+8MXWPhxNfjdJcSGj+EuHVUhcP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8160

T24gRnJpLCAyMDI1LTA4LTIyIGF0IDEwOjEyICswODAwLCBKamlhbiBaaG91IHdyb3RlOg0KDQpU
aGlzIGVtYWlsIGlzIGp1c3QgYSByZW1pbmRlciB0byByZXZpZXcgdGhlIHBhdGNoOg0KDQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUdYdis1R0hTaW5rTUhoQnhSZWtmQ3hGSzhteThK
cWVlUkJzR1hHdVdEcUg9TWptVFFAbWFpbC5nbWFpbC5jb20vDQoNCj4gSGkgZXZlcnlvbmUsDQo+
IA0KPiBUaGlzIGlzIHY1IG9mIG15IFZDUCBtYWlsYm94IGRyaXZlci4NCj4gDQo+IENoYW5nZXMg
c2luY2UgdjU6DQo+IC0gYmluZG5nczoNCj4gICAtIFBhdGNoIDEgZml4ICdtYWtlIGR0X2JpbmRp
bmdfY2hlY2snIGVycm9ycy4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjQ6DQo+IC0gYmluZGluZzoN
Cj4gICAtIE1hdGNoIHRoZSBiaW5kaW5nIGZpbGUgbmFtZSBhbmQgY29tcGF0aWJsZS4NCj4gLSBt
dGstdmNwLW1haWxib3guYzoNCj4gICAtIERyb3AgJ2Rldl9kYmcoZGV2LCAiTVRLIFZDUCBtYWls
Ym94IGluaXRpYWxpemVkXG4iKScuDQo+IC0gU2luY2UgdGhlIHJldmlld2VyIGhvcGVzIHRvIGNv
bWJpbmUgdGhlIFZDUCBJUEMgZHJpdmVyIGFuZA0KPiAgIHRoZSBWQ1AgZHJpdmVyIGZvciBhIHVu
aWZpZWQgcmV2aWV3LCB0aGUgb3JpZ2luYWwgdGhyZWUgcGF0Y2hlcw0KPiAgIGhhdmUgYmVlbiBz
cGxpdCBpbnRvIHR3byBwYXJ0czogdGhlIFZDUCBtYWlsYm94IGRyaXZlciBhbmQNCj4gICB0aGUg
YmluZGluZyByZW1haW4gdG9nZXRoZXIsIHdoaWxlIHRoZSBWQ1AgSVBDIGRyaXZlciBpcyBtZXJn
ZWQNCj4gICB3aXRoIHRoZSBWQ1AgZHJpdmVyIGFuZCBzdWJtaXR0ZWQgYXMgb25lLg0KPiAtIExp
bmsgdG8gdjQNCj4gICANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwODIwMDk0
NTQ1LjIzODIxLTEtamppYW4uemhvdUBtZWRpYXRlay5jb20vDQo+IA0KPiBDaGFuZ2VzIHNpbmNl
IHYzOg0KPiAtIGJpbmRpbmc6DQo+ICAgLSBSZW1vdmUgdW51c2VkIGxhYmxlICd8JyBhbmQgJ3Zj
cF9tYWlsYm94MCcuDQo+IC0gTGluayB0byB2Mw0KPiAgIA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNTAzMTcxMTAzMzEuMjc3Ni0xLWpqaWFuLnpob3VAbWVkaWF0ZWsuY29tLw0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBMaW5rIHRvIHYxDQo+ICAgDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDMwNTA4MjA0Ny4xNTc0Ni0xLWpqaWFuLnpob3VAbWVk
aWF0ZWsuY29tLw0KPiANCj4gSW4gdGhlIHYyIHZlcnNpb24sIHRoZXJlIGlzIG9uZ29pbmcgZGlz
Y3Vzc2lvbiBhYm91dCB3aGV0aGVyIHRoZQ0KPiBWQ1Ancw0KPiBJUEMgc2hvdWxkIHVzZSBtYWls
Ym94IG9yIHJwbXNnLiBUbyBwcmV2ZW50IHRoZSBkaXNjdXNzaW9uIHJlY29yZHMNCj4gZnJvbSBi
ZWluZyBsb3N0LCB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBsaW5rIGlzIGF0dGFjaGVkLg0KPiAN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUdYdis1RlhxWmJfdjJkUU5nQ0tiRnBKckxo
YlZrM2Ywc1dyck1DVmszamFXd29CcUFAbWFpbC5nbWFpbC5jb20vDQo+IA0KPiBKamlhbiBaaG91
ICgyKToNCj4gICBkdC1iaW5kaW5nczogbWFpbGJveDogbWVkaWF0ZWssbXQ4MTk2LXZjcC1tYm94
OiBhZGQgbXRrIHZjcC1tYm94DQo+ICAgICBkb2N1bWVudA0KPiAgIG1haWxib3g6IG1lZGlhdGVr
OiBBZGQgbXRrLXZjcC1tYWlsYm94IGRyaXZlcg0KPiANCj4gIC4uLi9tYWlsYm94L21lZGlhdGVr
LG10ODE5Ni12Y3AtbWJveC55YW1sICAgICB8ICA0OSArKysrKw0KPiAgZHJpdmVycy9tYWlsYm94
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gIGRyaXZlcnMvbWFpbGJv
eC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ICBkcml2ZXJzL21haWxi
b3gvbXRrLXZjcC1tYWlsYm94LmMgICAgICAgICAgICAgfCAxNzQNCj4gKysrKysrKysrKysrKysr
KysrDQo+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLXZjcC1tYWlsYm94LmggICAgICAgfCAg
MzIgKysrKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAyNjYgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L21lZGlhdGVrLG10ODE5Ni12Y3AtDQo+IG1ib3gueWFtbA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbWFpbGJveC9tdGstdmNwLW1haWxib3guYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstdmNwLW1haWxib3guaA0KPiANCj4gLS0NCj4gMi40
Ni4wDQo+IA0K

