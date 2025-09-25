Return-Path: <linux-kernel+bounces-832022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8FEB9E28E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD62E382889
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6139C27979A;
	Thu, 25 Sep 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hd2oAQzi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YZVVfTd5"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F127877D;
	Thu, 25 Sep 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790777; cv=fail; b=lSnzZ7zaEti8LsvdoiCM9lRe5IITqr99EXPF36kp5LvP1NLsISwEwLdedGYwXyMow5QVhKepvkTlBt1RjhxTuqzQAOOLqe2nb/LoBP7EIxzvrPN51+2MhGYQEvxOe7rNAVxtZ32faa7NfcPgtbOXpQlGp6pZFWB+1A0/D8x4+hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790777; c=relaxed/simple;
	bh=Peeq+XbcY91lY6YcfMZe2qQ7w7VgZc1WlUuc0u6bfNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cit5T7yP2mbCjjOvUx3TVZ+6d7xmdfKA21PMHCtwClo9JBbiQvckVjiR83hZnHZelKjKNplYbH/zLr9Xs6XBYNuzj35deYeNJIizkxeZ3oK9aM9uljTMJexTsPCLn92212dyOOWz1IdkpucYoB6Gg8s5QYHnGPmaDFwMjER8eAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hd2oAQzi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YZVVfTd5; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ed3ba94a99ed11f08d9e1119e76e3a28-20250925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Peeq+XbcY91lY6YcfMZe2qQ7w7VgZc1WlUuc0u6bfNg=;
	b=hd2oAQziy4w1nf/49K0bUaT5FkihwSyjQgTEcb6fyAz9IeeC56c0d1vS9aHnuOl4x5B2yDJXMv+KPsEcAo0eK/Y8534AR2g8QuY7N/rgcupfLeIyablzTCZnWT6LGK0Pm37MyWsgMwtKhkhVFxuqqCXfteQysg5CSVP4a0ONQq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:691695b0-70c9-410e-88bf-f2d894c5b30a,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:a9d874c,CLOUDID:65e2abe9-2ff9-4246-902c-2e3f7acb03c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|11|97|83|106|80|1,File:130,RT:n
	il,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ed3ba94a99ed11f08d9e1119e76e3a28-20250925
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1032475459; Thu, 25 Sep 2025 16:59:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 25 Sep 2025 16:59:19 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 25 Sep 2025 16:59:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhKQxXwoAO6YlZDJKyBkCR5WoCo4yCa5fMxlnHnS64xka09O9Ga7nE6ejei3R+bgNrUwuqY+uFsG2ia6VCpa8iIh4M6j6FD8k905XVathICSAvab1Z8vO/BiHBc2146aAsmIgVEYmfswQHBSICCK726IwCzG40vIWt9ZeXRYRgEPKiozQD0yMR5q0rrMKa5l6FI4OcQZENuuZwDaNUVS7dfhFjyDgJH2hsg1j+dKg+7ttIiyvFMSF9D2bliFHEltZNo4xAUJuJuT4AMIa1YxYVxRB4QWqm28Ji8gyGfn1FMER+77+Iwp5IRfk1Bywqv6QvxDjaYU1oorh3RP0IpZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Peeq+XbcY91lY6YcfMZe2qQ7w7VgZc1WlUuc0u6bfNg=;
 b=nwbXRWFmzW1Zv3YiasYbqMGiAiVcbkFuG0ppaylq2OP+9epmUBMShC21rLm/f85/0oqvJx0hi0tCC1xxcVTSwmkS1yOKG5ff/z6oCBFqMLvHuq7itwT4uun3DkRYtk43iRkXAbsubePzhtR4DaNdzi/vXlqVDWQ8UIn5rjBl0tucsTs7psLOltSn1XVQjLHDE2qoA5yDr0Cp/ron/E/AzIi7795iKNymcQSt9YRodvtoa5uvXzjrpwuYpQslffsqgGBYfodfkFHq7BzbUfg1YL0nwjwElpTZtoTcvP6MwEsfWaJdX5LWaVYJ9MDuenOXLKjN7tG8uA7Y21rp4KT6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Peeq+XbcY91lY6YcfMZe2qQ7w7VgZc1WlUuc0u6bfNg=;
 b=YZVVfTd52fV2OFya8JArAnybmkTw+F9nGuFNtfblZjbg8IJHupeoEjxLa8rmwPjtpzvba5Bs3dJrbe/hi+XaYYM6Sv3mD8nza0YIrs9+2r+W7WdUeWW2rkSNo0onRqZvQJQ9amZET5Jqm4oG4Bdw6xQpJ6XZgTRj1Bdf/6iioro=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:59:13 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:59:13 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "perex@perex.cz" <perex@perex.cz>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Topic: [PATCH v3 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Index: AQHcJ6hWrwp3VcKniUe8rNPF8nTL9bSXSM2AgAxdM4A=
Date: Thu, 25 Sep 2025 08:59:12 +0000
Message-ID: <97b82949673a2b894be1476f499b80553f9a1009.camel@mediatek.com>
References: <20250917075336.5985-1-hailong.fan@mediatek.com>
	 <20250917075336.5985-2-hailong.fan@mediatek.com>
	 <27deb3bf-7b93-4049-b3a4-b0c9bfcb5c43@collabora.com>
In-Reply-To: <27deb3bf-7b93-4049-b3a4-b0c9bfcb5c43@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|SEYPR03MB6580:EE_
x-ms-office365-filtering-correlation-id: 33d6510d-7997-4bfb-6ecc-08ddfc11cc65
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VVhzczNYTU9rS2pQUHhBYzQ3VjlEdXpULzQ2SVFMRjhVV2lOWXpIM0FuallU?=
 =?utf-8?B?UzBIbEFnR1FaYjkrUzdKNWNKS2FneW1KSml4M3V4NXNqVURnYitpQS9yVjhV?=
 =?utf-8?B?RUtqbmorZ1A2U2J6UmJGRUFwanZjSFFremE5VWdycHRqb01ZUW54bzVXblow?=
 =?utf-8?B?QWdqSm9VRlhCMDlWRkF2dmY2RHhBLzI1QVBtMmdnOUZNdXhkOHQ4MTBkaExx?=
 =?utf-8?B?dytud3JTRk5paEF2OTFPWklxS3VndW9Wa3ZZa3FpYWdaSEJXT0tEbUVSaUpk?=
 =?utf-8?B?RHlFdGZUV2NXaXh0M0xTNEhRL1h2M241aHBqRE0zbEpmNkpsNXd2SGVsczdS?=
 =?utf-8?B?MGhOMmtRRWtOZUFlMnl4dXh5VGFLdTdxemVuREU3dHVGZ0lOU01MbHM5c1Fl?=
 =?utf-8?B?WjJjbUxYdGVTWGhiNkMxWENOaHo0NmplSkE2NHFHVzBSLzdybnVRNld0VCsz?=
 =?utf-8?B?eVVoR0ZoZzNWM3grV0Voa3VxRGwzN280VTltaU9FUFlmY2NpSmc2NkNYeW9N?=
 =?utf-8?B?V2t2czJtMG5kSFhmb3RFL0dSL1JhMXFjOUlSK0lnRnJQcHRDbEFnN0xkRTB4?=
 =?utf-8?B?K3NBSkJjd2tnMFQvNDBNL3lEUEdnUFZxb0xWcVlXdFJJZENiTXV4SEhkQndF?=
 =?utf-8?B?S3pXazQzQktLY1JLVXgwc3RCVzdqNFM4eS9XNGxKSDUxOWRxcm5WeDVxUVQ3?=
 =?utf-8?B?WFZEcXIvMzlDaHdyUGdRQUlVRExSTWI5L1FrR0NsZndvVGFYV2Q2VXg3YU5n?=
 =?utf-8?B?aGMybzNFVDBjUWhRUmhPd2c0QnV5dzVHU0NWU25zcFk4UVhndkRzT294MnY4?=
 =?utf-8?B?VUJURzBnSTBRWTJ3RWx1M1ZkZHJGSEpJRDdDUmhrL3dqaXhoaU5MKzhRVmhP?=
 =?utf-8?B?QVJVb3NPckx0WHlQN016dFBQNERyTFlmNWIxaGRRVmFFK05id1k3ZVlGaUp3?=
 =?utf-8?B?UHJZNWtzMG4xbEFOV3A4VllhdVgxK3dZMGJnM0xvS2JVc2lHKzZDSXpIbVM0?=
 =?utf-8?B?aVUxYzlFRGY1ckNJYkZhZ1lHQk9kQ3Rzd0twSmhmY3l3NXZPNXNVVE5ZQnMx?=
 =?utf-8?B?Wk16RE9hZlRZZ08yZHZ5RHRTbmZVWWZXYUtZVUF2NERvdkhvVDRRaS9kRk1K?=
 =?utf-8?B?VjBsd3pySkd3cG9DaDY4Q3dFaVhNdGZIVENGOHUwS1ZiNGJ4em5JOGVtWkt0?=
 =?utf-8?B?alFtS2NIVVljWm9WY21uMERUZktNNjdHMG5Mbm1VRW5SVUg5VHhic2dKdHBP?=
 =?utf-8?B?bUQxemY1ZVlTMXlEMG5laHQ3MjNPajMzM0R6T3oyaE5rdWg4dkhYSTZ3UU91?=
 =?utf-8?B?ai9VcnV0Ky92TXpNWHJwaWZ5WlJQdGZFRkhkY1hqaERCNkpaaDYwZENEMmo5?=
 =?utf-8?B?RHFZZ2MyNlRBQThWdU5CS2VZeEFQOCtCaTN4bWswS1dhMkJpZVBKQ1hmMUk5?=
 =?utf-8?B?UC9BRXpuakNNcUNkQ25BV3R2eVVSMUxHQ2M4NEJqc0d1enFVeXJDRDV3aG5Z?=
 =?utf-8?B?Y0h5dWZ5WStQVkxCZWVqM0paN1owYUExYXp1aHFlbVdSdzYxbk9NWkFseUU2?=
 =?utf-8?B?WEZZaU1uQTFVZ1NhMk5RbWM4NCtJK1VURlFza2RvUXoxWmdyVFRNRXdqaVJM?=
 =?utf-8?B?cUZVSU40QUp2Z0M0NnR4SzEwLzVGc2paNDJnTnh4dVNrYzNsTXp3b2o4Mklj?=
 =?utf-8?B?bi9LdkpXL0RCQ2wrR2VoTFZpNWdaUEdzVkVoNzI1THludGdESkIvdEh1MjE3?=
 =?utf-8?B?Q3JhUFhrWi9oc3RlVFc0L3lPbUtNaGNyckxhc2VqTFN2cEU2aTBkNUU1M1Qv?=
 =?utf-8?B?TG41a0Y1R0RaRUlxRHkrQ2N5elQvWW02eHN2SStodHV6MVlFQ0xYWDJDSzIy?=
 =?utf-8?B?d2JPQldqeXpHMDl3d3gvVE5HS002VjZoR0ZYQ0YvV1J1R05yMXUvNEw4Rksr?=
 =?utf-8?B?TXNNaE1WeHNmcjY0a0wzMDRSajA4dkg0ZG5BMUpCQXREdWo5Q2JwalUvdk83?=
 =?utf-8?Q?FAqjdvsJnxTofmNTwRVlQlwgjd3Dk8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZLWjdYbE9TWG9ybHZJczdEKy9ubnljcDhJQWs2ZXB6TzFuYkVCa00zUm9M?=
 =?utf-8?B?T1NXaVZuTzBsbzI4aW53V0FJbWFJRU5waVdaNEY1ZGJwdUFIWUhXdk5uWFlx?=
 =?utf-8?B?YmlwdHpVUkg0NkMreVdpMjkrTWF4UVhnWHVGRDdhL0xiRGxHbk43NTI1SjZY?=
 =?utf-8?B?U2pibVZTc3IyZWM3VCtTYy9OZ2F4LzVacTJ4NDFYR0N5M0x5OFpZYWVFbDlU?=
 =?utf-8?B?TWJOYys5Q0JMZGxoQmx2SndzQ0tCbUM4TXNLeTMxUE9qVUc3cG8reUtaU0FU?=
 =?utf-8?B?Ti9xaERWQVBpNkVPSTNKL2FEcVVkRUl2T2ZQUitURXUyMnBPcUlaSkhoT3ZS?=
 =?utf-8?B?SzVhaDJMUlZ4ZTRkeEtKZ1VmTTN3YTF6a0I3MjB1eUxVOENYcnYzSVN2UzRO?=
 =?utf-8?B?WWZFYzFURTE1Vm50Rjd1aVVLY0JPWklySnN3cFdDaHBlY1VGbTR6R3d5Nmhi?=
 =?utf-8?B?NDNhZ1VLdnBwVFJ4bjR3YTdRWk5tcmFMV2JkSmx2ZFBvek94bktEczVpN0R6?=
 =?utf-8?B?M0k4eHp2MU5uUGRaZC9aNmV0L1pIbGI2RjJQR2ZXd1NEcjlWOHd4OHdrMXkv?=
 =?utf-8?B?RTdQRTBETlBzclljeWhld2ZRcDl5WUVGZTgrVDNlU2FyV3hBdjhpZDd3YnJJ?=
 =?utf-8?B?MVF6VUVFMnlGcEp6c0tBdkRMaTE5aVNDUXA2bVRnRkZWQU15SmF2ejlLNFNk?=
 =?utf-8?B?VE9ITFRnbVJKaGNVQ1cvSDRVTk1yekdjemZkN21HdEczRlFiY25IeUp3QmZi?=
 =?utf-8?B?bHhRZVV3b3pVa3A1ZTZaNHc0L0x0WVY4YmozLzUraFg0RnVFUnhSNUZkd3p3?=
 =?utf-8?B?VURCTHJEMzR1dGMxU0loaHVMUTUwRnpIT29EcWJGWURKVThPQ1NhNmVxQVFI?=
 =?utf-8?B?Rk16N2xXeDNQNjdrVHlQL3gwUXpCVFcrQmsreSszRWtqU0RqSW9pSWxnemZr?=
 =?utf-8?B?UjNxWFB0NHdHemk4MXpVV0lzSzVYL0VmaTlmUHU4a042WXpCanBHbjB6ckpi?=
 =?utf-8?B?QnkySHE4dGkzNFRIVEs5RjlIQXpnMDNYa1ZjQ2Q3M1lBRnI3Tk9ubzdJc2RR?=
 =?utf-8?B?OEFTYUdaMjg2Z1Z3dkZJWkdSR1p6WVlCZjNqeERwZENwdm9kcnl0TnVuN1dI?=
 =?utf-8?B?ejd4UGh1TFltK1ZRNCtISFpXb1lQaTFzem5tWTVPOGZkU2NUQnpkL2xQVE1F?=
 =?utf-8?B?dzJ5d1ZDYXJLd2t3d0JRK2kzZjAzZFpzMVZMdkR6YiszZi9qbFpKUVZ5ZFUx?=
 =?utf-8?B?am90Z3dtaVRzMGN3cXcwbFJ1cTlYMDFFRDgzRFpJYkFOcmtQNkx1MTNiUHRS?=
 =?utf-8?B?Q0NrR09HVDB0VkNVZTdMenRFcDJ1NnNkT3NJTWlrVy96bjNzNDFBQ0FacS9E?=
 =?utf-8?B?c2pPSDc4Wlp3cE1ZaHhZQVZzMEV5OU13VlhycXEwdUYxREJsQThzbVZHSVRT?=
 =?utf-8?B?TWFFU3FZaFRicnlkTXpxRDlYUW9sVzhPSDJYS2FZVllhbWlUTHF5ZlM3S28r?=
 =?utf-8?B?d1N4YStXSHBGd2xaUFBPS1gxZjBJZ09sZFV0K2Fkb3RyWUdOemQ3WE84enRK?=
 =?utf-8?B?eVVjaHZHYWFHSXlicUZvZ2trSmROQlFMRk9iTHdDdXJEUWdYbjh3V05KdC8y?=
 =?utf-8?B?ZFZYRHljMllwYUExWW5PVnBObENFdkRweW9kcHNRYjdOYXpJUWJ0WHpwbThH?=
 =?utf-8?B?ZHlObXgyY2xDTkhFQnNoRGtYRlJITVBIQVhrSUlQaWFicFpIc2JuTUF6RjlL?=
 =?utf-8?B?VmNtRnZ3eHFaV0o5VFBrMVNOMVdCNUJRYmQreDY3OUtJVmZFUWRjRzRmY0hI?=
 =?utf-8?B?NVRDQWZvQWQzVzQ1aFBUeHY2K0NYc1hZczYrU1paYkZ4OWVKSlpVdCtWc0FN?=
 =?utf-8?B?bElTQ21qVDh6anlZb1p4WGcwRVpKL2E0S1A1QVJQL1NyTG4vVUZ1MnNYWkZV?=
 =?utf-8?B?QVZrS3JZNzU0cGh5QnVJYVJkZ1JuOHB1L3pxME9QMHhwTVJnUDhLZGtkTFdU?=
 =?utf-8?B?Vk52MDR3WjM0YTRTQ0s3SG9VQTV4ZHJTbGh1M3pnYVh0YzZrOStXc0pxZVJ2?=
 =?utf-8?B?V3ZwVGpUZGNWM3VrVzVIVFYrdWNYUis1SGFBSGl1OVAycHZuaU11WjN3ZWV2?=
 =?utf-8?B?U2grWG8vNFB6N2dtZ3M3Q3ExdFExSnEvd2c2S2tlN3l4bkE1MGl1aWpYeDJG?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E09787D9562D8429D09ADFD4E7F865A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d6510d-7997-4bfb-6ecc-08ddfc11cc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:59:12.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei3qFdvks0bS3qF58fB2wdVsQ7V2DqG6roU9HAWu5Odto93ufZfdiSlYrkqtvcWmN8XQHCddQQGTl9SgS8gD3PIMF5K6LLKdQNoQjRJ0Ilc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

T24gV2VkLCAyMDI1LTA5LTE3IGF0IDE0OjEwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNy8wOS8yNSAwOTo1MywgaGFpbG9uZy5m
YW4gaGEgc2NyaXR0bzoNCj4gPiBGcm9tOiBIYWlsb25nIEZhbiA8aGFpbG9uZy5mYW5AbWVkaWF0
ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24g
Zm9yIHRoZSBNZWRpYVRlaw0KPiA+IE1UODE5NiBEU1AuIFRoZSBEU1AgaXMgdXNlZCBieSB0aGUg
U291bmQgT3BlbiBGaXJtd2FyZQ0KPiA+IGRyaXZlciBub2RlIGFuZCBpbmNsdWRlcyByZWdpc3Rl
cnMsIGNsb2NrcywgbWVtb3J5IHJlZ2lvbnMsDQo+ID4gYW5kIGEgbWFpbGJveCBmb3IgRFNQIGNv
bW11bmljYXRpb24uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpbG9uZyBGYW4gPGhhaWxv
bmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9iaW5kaW5ncy9kc3AvbWVk
aWF0ZWssbXQ4MTk2LWRzcC55YW1sICAgICB8IDk4DQo+ID4gKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvbWVkaWF0
ZWssbXQ4MTk2LWRzcC55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvbWVkaWF0ZWssbXQ4MTk2LQ0KPiA+IGRzcC55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RzcC9tZWRpYXRlayxtdDgxOTYtDQo+
ID4gZHNwLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uYWYwZjlkNzEyMDBmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvbWVkaWF0ZWssbXQ4MTk2LQ0KPiA+IGRzcC55
YW1sDQo+ID4gQEAgLTAsMCArMSw5OCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4g
PiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvZHNwL21lZGlhdGVrLG10ODE5Ni1kc3AueWFtbCpfXztJdyEhQ1RSTktB
OXdNZzBBUmJ3IWpjenplU2lmd0Q5bml2S3p5cUlpYXFzOXMwVkloaEd4NXlrVjBnMzIwMzQ2TlBa
ZXJZdGV5MUxnaHItR0YxakFrNUdJbE5sejBmRzhxREpneGstaG5RWHZmRHE3N1BMZCQNCj4gPiAr
JHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchamN6
emVTaWZ3RDluaXZLenlxSWlhcXM5czBWSWhoR3g1eWtWMGczMjAzNDZOUFplcll0ZXkxTGdoci1H
RjFqQWs1R0lsTmx6MGZHOHFESmd4ay1oblFYdmZJOWxldUVTJA0KPiA+ICsNCj4gPiArdGl0bGU6
IE1lZGlhVGVrIG10ODE5NiBEU1AgY29yZQ0KPiANCj4gbXQtPk1UIChNVDgxOTYpDQpPSywgdGh4
Lg0KDQo+IA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBIYWlsb25nIEZhbiA8
aGFpbG9uZy5mYW5AbWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4g
DQo+IERyb3AgdGhlIGNvbG9uIHwsIHlvdSBkb24ndCBuZWVkIGl0Lg0KT0ssIHRoeC4NCg0KPiAN
Cj4gDQo+ID4gKyAgVGhlIE1lZGlhVGVrIG10ODE5NiBTb0MgY29udGFpbnMgYSBEU1AgY29yZSB1
c2VkIGZvciBhZHZhbmNlZA0KPiA+IHByZS0NCj4gDQo+IG10LT5NVCAoTVQ4MTk2KQ0KPiANCj4g
QWxzbyBkb2N1bWVudCAqd2hpY2gqIERTUCBjb3JlIHRoaXMgU29DIGNvbnRhaW5zLiBTcGVjaWZp
Y2FsbHksIHNheQ0KPiB0aGF0IHRoaXMgU29DDQo+IGNvbnRhaW5zIGEgZHVhbC1jb3JlIENhZGVu
Y2UgSGlGaTUgQXVkaW8gRW5naW5lIERTUCAtIGJlY2F1c2UgdGhpcyBpcw0KPiB3aGF0IGl0IGlz
Lg0KT0ssIHRoeC4NCg0KPiANCj4gPiArICBhbmQgcG9zdC1hdWRpbyBwcm9jZXNzaW5nLiBUaGlz
IERTUCBpcyB0eXBpY2FsbHkgdXNlZCBieSB0aGUNCj4gPiBTb3VuZA0KPiA+ICsgIE9wZW4gRmly
bXdhcmUgKFNPRikgZHJpdmVyIGFuZCByZXF1aXJlcyByZWdpc3RlcnMsIGNsb2NrcywNCj4gPiBt
ZW1vcnkNCj4gPiArICByZWdpb25zLCBhbmQgYSBtYWlsYm94IGZvciBjb21tdW5pY2F0aW9uLg0K
PiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+
ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvY2xvY2svbXQ4MTk2LWNsay5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3Bvd2VyL210ODE5Ni1wb3dlci5oPg0KPiANCj4gQmVmb3JlIGluY2x1ZGluZyBiaW5kaW5nIGhl
YWRlcnMgd2l0aCB0aGUgc2FtZSBuYW1lcyBhcyBkb3duc3RyZWFtLA0KPiByZWZlciB0byB0aGUN
Cj4gc2VyaWVzIHRoYXQgYXJlIGN1cnJlbnRseSBvbiB0aGUgbWFpbGluZyBsaXN0cywgYmVjYXVz
ZSB0aGF0J3Mgd2hhdA0KPiB3aWxsIHVsdGltYXRlbHkNCj4gZ2V0IHVwc3RyZWFtLg0KPiANCj4g
ZHQtYmluZGluZ3MvY2xvY2svbWVkaWF0ZWssbXQ4MTk2LWNsb2NrLmgNCj4gZHQtYmluZGluZ3Mv
cG93ZXIvbWVkaWF0ZWssbXQ4MTk2LXBvd2VyLmgNCk9LLCB0aHguDQoNCj4gDQo+ID4gKyAgICBh
ZHNwQDFhMDAwMDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5
Ni1kc3AiOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDFhMDAwMDAwIDB4NTAwMD4sDQo+ID4gKyAg
ICAgICAgICAgICAgPDB4MWEyMTAwMDAgMHg4MDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgPDB4
MWEzNDUwMDAgMHgzMDA+LA0KPiA+ICsgICAgICAgICAgICAgIDwweDFhMDBmMDAwIDB4MTAwMD47
DQo+ID4gKyAgICAgICAgcmVnLW5hbWVzID0gImNmZyIsICJzcmFtIiwgInNlYyIsICJidXMiOw0K
PiA+ICsgICAgICAgIGNsb2NrcyA9IDwmY2tzeXNfY2xrIENMS19DS19BRFNQX1NFTD4sDQo+ID4g
KyAgICAgICAgICAgICAgICAgPCZja3N5c19jbGsgQ0xLX0NLX1RDS18yNk1fTVg5PiwNCj4gPiAr
ICAgICAgICAgICAgICAgICA8JmNrc3lzX2NsayBDTEtfQ0tfQURTUFBMTD47DQo+IA0KPiBhbmQg
dXNlIHRoZSB1cHN0cmVhbSBuYW1lcyBmb3IgdGhvc2UgY2xvY2tzLg0KPiANCj4gPCZ0b3Bja2dl
biBDTEtfVE9QX0FEU1A+LA0KPiA8JmNsazI2bT4sDQo+IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhF
RF9BRFNQUExMPiwNClllcywgSSBoYXZlIGFscmVhZHkgc2VlbiB0aGUgcmVsZXZhbnQgY2hhbmdl
cyBpbiB0aGUgbGF0ZXN0IGxpbnV4LW5leHQuIA0KVGhleSB3aWxsIGJlIHVwZGF0ZWQgaW4gdGhl
IG5leHQgdmVyc2lvbi4gVGhhbmtzIGEgbG90Lg0KDQo+IA0KPiA+ICsgICAgICAgIGNsb2NrLW5h
bWVzID0gImF1ZGlvZHNwIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJzeXNfY2xrIiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICJhZHNwcGxsIjsNCj4gDQo+IGNsb2NrLW5hbWVz
IGZpdCBpbiBvbmUgbGluZTsgcGx1cywgcGxlYXNlICJzeXMtY2xrIiBpbnN0ZWFkLg0KPiANCj4g
PiArICAgICAgICBwb3dlci1kb21haW5zID0gPCZzY3BzeXMNCj4gPiBNVDgxOTZfUE9XRVJfRE9N
QUlOX0FEU1BfVE9QX0RPUk1BTlQ+Ow0KPiANCj4gcG93ZXItZG9tYWlucyA9IDwmc3BtIE1UODE5
Nl9QT1dFUl9ET01BSU5fQURTUF9UT1BfRE9STUFOVD47DQpPSywgdGh4Lg0KDQo+IA0KPiA+ICsg
ICAgICAgIG1ib3hlcyA9IDwmYWRzcF9tYWlsYm94MD4sIDwmYWRzcF9tYWlsYm94MT47DQo+ID4g
KyAgICAgICAgbWJveC1uYW1lcyA9ICJyeCIsICJ0eCI7DQo+ID4gKyAgICB9Ow0KPiANCj4gUmVn
YXJkcywNCj4gQW5nZWxvDQo=

