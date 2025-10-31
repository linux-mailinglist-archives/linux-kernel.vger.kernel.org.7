Return-Path: <linux-kernel+bounces-879535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91320C23537
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C2BF4EE4BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB22EA176;
	Fri, 31 Oct 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DdRslyIK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JrD31Vtb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB2EC0AE;
	Fri, 31 Oct 2025 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891036; cv=fail; b=liMr9YXJNLSeySU1X5DwpO+0y+NgIMPKq3wB55HlG3GFTBlZymJDWVD5lfK3z6DhvAfZWl43wasGkom1NuGed6x9RAz+iz3LELaEyhb+HUFLDo3y18wFzjo1EXRQFZd8J9jCDkGDzLUUYEaQU/ZkOBIkWmLZe/zYC+73XgEUxZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891036; c=relaxed/simple;
	bh=ujgEodnoByvBE1txh2ZjySPjv4jvg+zck59b5t5Jcps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HjE3ya1aSRHv1mZyb5+htHKxQ0b2l4C1fTNmESadsq1IFEmpTXuCUO2Encwd5xxtYoAu2aoCDzkS9IzHNAuJggAshJWDAFHeQixVWXeAjtZIPBg+cW79CAK4kw4CURxFQsJeoEO9AnILP17IvoM0nYWldt35sJ0I7cUeUOe4lug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DdRslyIK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JrD31Vtb; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4a67f2a6b62011f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ujgEodnoByvBE1txh2ZjySPjv4jvg+zck59b5t5Jcps=;
	b=DdRslyIKtY8Hn4mHhJf1eryqKc8AyzWRdANEG0PoSP83G0RhnSt5VLb+mRv4G4/j16/NxSa70cPqw9DeFn4bdU/aIEZX605OyfKetQ3EjFfermPpwWJ5YWRScWGUFZ2UJNSJ0P3PNsUwgsxM9WVbYtWjAX2WaRfdkHKKfx2LOJ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:696e17c5-ae61-4574-bdd1-c34b942740e5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:85567526-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a67f2a6b62011f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1080024843; Fri, 31 Oct 2025 14:10:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 14:10:22 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 14:10:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M274WIPAhFuSuUHtN7Z5BuZ548WRTlGBM6x31ro+Vw8pjWI3fOoEOsPqnQPhLU1suCI1JVZsEzqz/ii7s61nS+29uSYoouz5w5A2EZRErFaq5+KKDQoGxkL4GaPtuyvHnTcqa5WhhIFDmo1sw6eFc66Ac5DAXsaFc/VzGzgUepwgqx+6pogOQVP7xMf0mL/urO+1au89MpatHHCpkSeZFUimf7mV7CLI8gV6EJExP7My4VCkpux6FKbFjmt+tz8cZm/47td6RDbXZigvTkDbkXOh34CHqVTNEP+EJwq2tg856GQeZFBBF4EmJF1AxaOjmxTnbSLVFehhWBjKzOcHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujgEodnoByvBE1txh2ZjySPjv4jvg+zck59b5t5Jcps=;
 b=JmVaaMDFAnYEEijGpH5BooXs5G3fy1DLfKWl2DDTv872kl/Pq+xJDBbBdpdARAiQwq4Gc3aZn0PRVPfs+NM3LS8OrMUkujC0FFSjt+IbuOpaOtMb76rd7lDL1X70U7hHsLvlgHf3RRphogh48+VETpb4+V+13Esx+roCqRP+3ojaL3oOfs5lMRQwpmrZ8aU8oaXdzeD6vkUgFUZa1ynFYLUvEgJfu2+2HPsTIpwdjyplv5/lcBz+yx1n6Yvovr8gO5vlFft0c9q3g2YaAMYSaxEx/DcwpkulRB7X19AB/z/Prrdy9tFBr0lSsx6DH0SZGcu/Pf87mIhEUe2oMGqssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujgEodnoByvBE1txh2ZjySPjv4jvg+zck59b5t5Jcps=;
 b=JrD31VtblSLyuBd6kRAImK3ipsWPRz2niR+XKoWO3ddVSbG5JOsRyksxN8LCCmY4ACciqNU9Xb8YgoUmDNx612KMJ99RXYrR0CpP+mSW0WheF9SrTK/uhWchq371ilN9BrJeuRiP348K6isWS2lVvuq05dBZ/z0KxwlI8QRfEiY=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by TYZPR03MB7932.apcprd03.prod.outlook.com (2603:1096:400:44d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 06:10:19 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 06:10:19 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Topic: [PATCH v11 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Index: AQHcJ8vV2PqDYxR7IUSlntz+/8kT8LTITOKAgBO9lgA=
Date: Fri, 31 Oct 2025 06:10:18 +0000
Message-ID: <1c84112b5a7fa48d8422f531e660aa1b49ec6487.camel@mediatek.com>
References: <20250917120724.8650-1-friday.yang@mediatek.com>
	 <20250917120724.8650-2-friday.yang@mediatek.com>
	 <5e3a0317-31b2-43f1-9a4b-b66447a6044d@kernel.org>
In-Reply-To: <5e3a0317-31b2-43f1-9a4b-b66447a6044d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|TYZPR03MB7932:EE_
x-ms-office365-filtering-correlation-id: 742fbda3-37e4-421e-fbdf-08de18442ae3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?azdBelZTc1lUK09uUnBGV1ZBQU9ySFNqZ2xOdEdxeUxGZGI1WSs2OFRTSzM5?=
 =?utf-8?B?dHdIdWNZOGhGNkNIcTl4ZnNPL3FiaHR6VjQ3Rkd1YjBYZkpzZEVTeU1xQnZS?=
 =?utf-8?B?clFZbTZrUmpSN0hBYWpsSGR3RFB3cUlmYUpEaEFiWEc4L1ZTUHI2UGt3NExL?=
 =?utf-8?B?WDF5SHFvMTJDaURqT2pua3B5SXlhM3BzVTdjQU81YmMvVnBaSXdBZlVaR01M?=
 =?utf-8?B?S1ZRNTJGWkpCVkJPT2djTTZubWpOQXpxZ0RHN3c1VDd1WkF3NDArQWU4OTQ4?=
 =?utf-8?B?OUw0Y0hwMnhhSkxnMnJEQTY3REdhVHJPaFAzNnFjclcrOXRheTlUenpFaUor?=
 =?utf-8?B?MGRDdmZ1bStEQVl3RFNBQnNaVlpuSnVFa2t3eWNaZ3V6MmRhZlZNMVRBR3Fa?=
 =?utf-8?B?QXgrZW9wZjZmUEE4SXJTN09ORnFTNGpXQWNnRkcrd3dUZ2RsNWJPc2tKOXJC?=
 =?utf-8?B?eEpmVEVaZnJJU1NHcTVqcTViTVU3ZHVLdGVWV09udVZiYmNPZjU5Y1gwS0E4?=
 =?utf-8?B?eVhlbFFNWVRhbVFNbER1bjU2R0hnWHdHTHhUQUNYWWRRMXV0U0FGT3B4c3dU?=
 =?utf-8?B?c1JKRnYvQVdpQW4yRkJ2SDNDVXFZNVUrSENIbVh1VzNQL3dMeFZPUFZDTm5W?=
 =?utf-8?B?SnhBcGx0TUdMU2E2THZVMFgvNjhsN2tNMHo0WVhCenRVcFFmdGI1aTVrTkxN?=
 =?utf-8?B?OUNDVDBpcVd6clhnWEJPU1ExOTF6dWJOa0Zkc290VTIyeDAwMXhNRXpIUDRn?=
 =?utf-8?B?azBuYVkzV3hoWDlaQTZVY041ZVcyWUlsejZWWU5yRWJoOW11M280TG9PNlNy?=
 =?utf-8?B?NXBoL3E2VEVPVTFCQUt6UDA5V29WNjVQaE13TU1udnNGWG8wTjk3VHBEcUt1?=
 =?utf-8?B?QUxQRmV5bGNaUGNOcTd0a3I5cUx0cjRnWFQ1bGkvTkw1NU1SQ0k4UzY4VG5z?=
 =?utf-8?B?ZHZKVkVha3lDaStvbnpseVIwaTdhQi9mN3NmS3hoWko2OUJvSE5vUTdpY0xq?=
 =?utf-8?B?RVdSWUVIWHVYRDU2Zk84UlgrSG80SGZkcTRISjJYRHh5RE9QRGkvTThmSFR0?=
 =?utf-8?B?N0pPMzBJcStlVHBDaldNSWU4ZU4vdTA5dkpTTTdwcUZ3bCtOdEtZUVpmZGJj?=
 =?utf-8?B?cGtQenVVTnlSNG1va00vSFdMQ0c5WXNXREE0blprNThzOXpWWnh1WXluZ2t1?=
 =?utf-8?B?ekJqN3VyeHViQitwcDNpa1N6VWRGWmlGRHd4Y0JnSHk4SlNucmZBNDFhQW9M?=
 =?utf-8?B?aFFNRm44N0xmN0tLZVZscm93bTJsVUw3bWcrVnl6Unh6YktIemhKZGM4OFpT?=
 =?utf-8?B?RDFBamx6ZzVOY1FteW1aRkxGMlZsZldEbEtKdzdnTVpYRHBBa3o5TTErRE9M?=
 =?utf-8?B?Z0JsNWxKY01hS3JDbFN5L09EYlZhVnd2S2RkQjRFbzNNQUpOckFCWEU2dnNt?=
 =?utf-8?B?amo0dmFEbThOZm5FYk9FZEw3cDhGNjRma1R2NCtrU1dCU0pKU213dWdMcWFW?=
 =?utf-8?B?ZTZUZjdiZ1l1R2ZFMStrUzNCTTNKQlJPbmVWNkZjdUtUeTZRaFhEQ25uS05R?=
 =?utf-8?B?cCsxU0tCcklldjJDakdNbDdBTFNFeVlXYlJ1NFdQZlZXRzROd2V0ZVpJcTk5?=
 =?utf-8?B?ck9VMzdkU0liQ1cvRkxQTUhncU5YbW5HcXg3ek1HOU4xdFcrY0c1VlNUOFNj?=
 =?utf-8?B?RFBSNzVCeTNoNGNYOGI4a2p5VndXUjRHZURQREZ0QXZmeHFkTWUxU0VDalYx?=
 =?utf-8?B?Y0ppTytMUkJYYWFQKzhXVlpaU0pPcjZicit2VlBSVUV0Rm5xVkdBbGJHUG9l?=
 =?utf-8?B?d3VneFJjMmZ1ZlpzSkxkc09sQy9ZT0xIQlNHRXArK3BIVHNqZWRGZUpITUQv?=
 =?utf-8?B?K29SdmEwU2I4Vm1jT2lPQmM1blgxNWx4SG1iVFJOdURZMVFhWGVsSmc1OUNr?=
 =?utf-8?B?TWZKOUxmbm4raFpqaDJFV0xidEtBaERqRUR3VE1ZRmRvNm5LZDhEeUJPRzFm?=
 =?utf-8?B?dlhYVXlEbjFEY3JpbC9WMXdPZmdZUXRWMTNWZWtpUng5Sk9PalU2VWJRT2JG?=
 =?utf-8?Q?zLVq+C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mmhnb1lPR3ZucDhwNlM0UE1ubnBPNTRNTTJmbEgvbHNZdzFkYUtTbkFHQlNx?=
 =?utf-8?B?cmk2VHF2SnIzaXpLSGVUdERENSthTGd0ZldOUER3OElCV1FLNzRQOUlrU1px?=
 =?utf-8?B?TVRZQ25IWVpTVlcvVFd1djl2TTUwMUlQVmwzOWFjeDVTV1NqdFU5NEIrTkRn?=
 =?utf-8?B?RExhM1ozbDFPYWVXenVkcDMwM1NqdjVESUQreUpsbEJCTThsY2ZLSGdhSHdk?=
 =?utf-8?B?SVlGNU1wM3RFQ1NNVCttTkpaWkNUVUljVWVxYTA5UlI3OENkNkRGNFIveXFn?=
 =?utf-8?B?VTAvS1NSRW8zQ0pCbng4aitPTEJsL2d2TlRaKzdOK0dIbmVucmV2REV4dGJ5?=
 =?utf-8?B?L3JobFRuZ3MrajQ0NEZMUzBjdUcwL3hzR1Nnai85ekN4OWkweko3K2ZyZW0y?=
 =?utf-8?B?a3JTS01KOWlPUUpSbi9IWEJMQUQ3R2xBS0lXMHBtS0h3amNBNUxwSE83NUpD?=
 =?utf-8?B?Zk9yMlR1dHYrem9VNHFqa05mN0MwR3VLaXVXTENlbTI4UC9COGxBbUdKck51?=
 =?utf-8?B?aW14TEs3cmxPMFJmdFkzRThqZ2tyM1VhSFZTWEZ6U3oveVcyZURvOWdlVS9U?=
 =?utf-8?B?T1hGOVVTcmp1Ti93YWZxaDQ2MXJtVStSZmJoWTJOc2FWRzlnc1JDUUpDd0Rv?=
 =?utf-8?B?VFRocURxbFZBY2xnczFDaGh2aHl4YUFKeXl4czJDMVdMSXR5dVN4RWJiMTZG?=
 =?utf-8?B?SFVYNVNMM0ZJdGc1cGh1YndmTytTWmVYTkJIN1V2UzQ1Z1hyVFZUcGlUSUp6?=
 =?utf-8?B?ckJTRUZkd3V6RnpvVXJPMEU2UmgxSklERUo3b0NDVW9PWTYvMURhR3ZjWnJm?=
 =?utf-8?B?SjBkR3g4MUQvZThyODhOdENWakRvU1NHUUdNNlNRb3pTS09IUmIzeXhSTE0z?=
 =?utf-8?B?RHhPdVp4TzY1TVZLcEpETHNvMWRFbGF3M3FoSE5QbTVJYXV5VlB1RGw0S0hC?=
 =?utf-8?B?L3Z5UDk1Y3JNSTZJWDYxcXR5RThtQktHRElrNzVCdVlRRHF5NTl4SnByQ2RS?=
 =?utf-8?B?WXlmYVQ3UkcrZ05SdUViVHo3c1ptdmthbkE0a21RM3NsbGlMbEZVR2wvTTBK?=
 =?utf-8?B?RWtSdmpwSWJFRUJpUytreTZINDdjVWRRZkZNQjBCMXd3Vk1vd0ZNWG1CNDRo?=
 =?utf-8?B?ZU4yU3NhdVpXWEVGRVcxNVFOcGZBREFqZ1hnUGZ5V3N3ZU5EbHFYRHlBcC9Y?=
 =?utf-8?B?ZjJ5cGdwakV6QlhRRXYyTjFkL0lHMUU2SkU0ZDZIVis1dUhMbisyNERnalo1?=
 =?utf-8?B?ak1KZWpWNkc5TkYrWkpFM0lCT1NQUEF5WHhFbTZtTklhTmZWNjlPeGI2d2Jx?=
 =?utf-8?B?dldYd2dCajVjVG5Mb2xqK3NCcjc3cjU2OVJueFZIeTBQdFNZUW1xYWR2ZDE5?=
 =?utf-8?B?Z3dXNkYwSDVhQ0FzUWdFQ3F4bmN0b3AvcVM3bFhNZUw1YkxOTnVIVjhDZmRB?=
 =?utf-8?B?bmIwSUdSSS80OHRYaUErVTBLTHhkVk5ZdmhGTnBubEVDbXlQVTBNNFBRMTJP?=
 =?utf-8?B?Q1pIbmZQZllvcGJmUEVVRzJrUllEVnJWNVk1L0pSUnRETnk1RVFQNkdXaXEw?=
 =?utf-8?B?MldNdForN1NuaW94dUtiQTN3T25CRERIbFBkV3cwRWE0aGJSNytjcjh1Umlt?=
 =?utf-8?B?S09mUUJqN2FNVEwxVG50ZUQvM08wUDFVSHZlMWJWNlA4U2V6ZExLSCtXb1B4?=
 =?utf-8?B?dElNZ3l2YlRjelhNK3JUNTFVUkNDMFdmVENIWXk0NG16dnVURFNWeWx4WWs1?=
 =?utf-8?B?dXhvanJjTytsS3RyYmRxUFk1YW9wd2RQQzAzaWlKaGVEZzhGZkx6K3M1cHBG?=
 =?utf-8?B?RlYxTXZRcVEyWWNMaVhIa1RvUXF0a3JNYjR1WlRCa1Y0SHl3N0tDRzFEcFJl?=
 =?utf-8?B?eFBQV3oyb09rZ0tLWjNIbnV2SmJtOG0zbjVDcy9GK3dRMk1PUVVrdis1c3k1?=
 =?utf-8?B?ODUvRXBmbHhtb1V2Z3ZPTGJ5NVdYZFA3bU1SS01NTXBhRVJEL0dnVEsxUGtB?=
 =?utf-8?B?ZHB2Yk1WRk51ZERXRkFLZ0dlMTh5UGFrZmFyRkpCRHBoUjk1dlp1ZG9IamYz?=
 =?utf-8?B?VDc1eTZTem4yZXE0djZjV2ZSTUoyTDg0U1JYTnZ3UEREM3FBbHVSL1k1alph?=
 =?utf-8?B?ZVJXUmZ3dVpBaVhzMlZjOWtXbHpPSXE4RlBwV1pncFppTU1tK1ExUlJvM0NQ?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95D48ED174B5B4498721DA8E39B529F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742fbda3-37e4-421e-fbdf-08de18442ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 06:10:18.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCw4wYto/gIX7xwI5Byn6BHUATM06NlQ7Fk2+cC9ims3m0uD6UTxTq6IemNXGYLDzExyRZ+XKwtA5ahaPQpcd/M0ub0wrQVSG8zVFzQuOo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7932

T24gU2F0LCAyMDI1LTEwLTE4IGF0IDE4OjQyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE3LzA5LzIwMjUgMTQ6MDcsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+IEFkZCAncmVzZXRzJyBhbmQgJ3Jlc2V0LW5hbWVzJyBwcm9wZXJ0aWVzIGZvciBT
TUkgTEFSQnMgdG8gc3VwcG9ydA0KPiA+IFNNSSByZXNldCBvcGVyYXRpb25zLg0KPiANCj4gTm90
IGluZm9ybWF0aXZlLi4uDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJi
LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+
ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+IGluZGV4IDJlN2ZhYzRi
NTA5NC4uZmM1ZmViMmVhYzFmIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIu
eWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnkt
DQo+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+IEBAIC03MCw2ICs3
MCwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgZGVzY3JpcHRpb246IHRoZSBoYXJkd2FyZSBp
ZCBvZiB0aGlzIGxhcmIuIEl0J3Mgb25seSByZXF1aXJlZA0KPiA+IHdoZW4gdGhpcw0KPiA+ICAg
ICAgICBoYXJkd2FyZSBpZCBpcyBub3QgY29uc2VjdXRpdmUgZnJvbSBpdHMgTTRVIHBvaW50IG9m
IHZpZXcuDQo+ID4gDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiAr
DQo+ID4gKyAgcmVzZXQtbmFtZXM6DQo+ID4gKyAgICBjb25zdDogbGFyYg0KPiANCj4gSXMgdGhl
IHJlc2V0IHZhbGlkIGZvciBhbGwgZXhpc3RpbmcgZGV2aWNlcyBhcyB3ZWxsPyBDb21taXQgbXNn
IGRvZXMNCj4gbm90DQo+IGV4cGxhaW4gdGhhdC4uLiBpdCBpcyBwcmV0dHkgdXNlbGVzcyAtIHlv
dSBzYXkgd2hhdCB5b3UgZGlkLiBXZSBzZWUNCj4gdGhhdA0KPiBmcm9tIHRoZSBkaWZmLiBFeHBs
YWluIHNvbWV0aGluZyBub3Qgb2J2aW91cy4NCj4gDQoNClRoYW5rcywgSSBjb3VsZCBhZGQgbW9y
ZSBkZXNjcmlwdGlvbnMgaGVyZSwgbGlrZSBiZWxvdzoNCg0KT24gdGhlIE1lZGlhVGVrIE1UODE4
OCBTb0MsIGJ1cyBnbGl0Y2hlcyBtYXkgb2NjdXIgZHVyaW5nIE1UQ01PUw0Kb24vb2ZmIHRyYW5z
aXRpb25zLiBUbyBwcmV2ZW50IHRoZXNlIGdsaXRjaGVzIGZyb20gY2F1c2luZyBlcnJvcnMsDQpT
TUkgcmVxdWlyZXMgY2xhbXAgYW5kIHJlc2V0IG9wZXJhdGlvbnMuIFRoaXMgaXNzdWUgc3BlY2lm
aWNhbGx5DQphZmZlY3RzIHRoZSBpbWFnZSwgY2FtZXJhLCBhbmQgSVBFIHN1YnN5c3RlbXMuIFRo
aXMgY2hhbmdlIGFkZHMgdGhlDQoncmVzZXRzJyBhbmQgJ3Jlc2V0LW5hbWVzJyBwcm9wZXJ0aWVz
IHRvIHRoZSBTTUkgTEFSQnMgd2l0aGluDQp0aGVzZSBzdWJzeXN0ZW1zIHRvIHN1cHBvcnQgdGhl
IG5lY2Vzc2FyeSByZXNldCBvcGVyYXRpb25zLg0KLi4uDQoNCkNhbiBJIHN0aWxsIHJlbWFpbiB0
aGUgJ1Jldmlld2VkLWJ5JyBhbmQgJ0Fja2VkLWJ5JyB0YWdzIGlmIEkgb25seQ0KY2hhbmdlIHRo
ZSBjb21taXQgbWVzZyBpbiB2MTI/IEkgd2lsbCBub3QgY2hhbmdlIHRoZSBiaW5kaW5ncy4NCg0K
DQoNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

