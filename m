Return-Path: <linux-kernel+bounces-754698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDDB19B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58654E0500
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5B21B9D6;
	Mon,  4 Aug 2025 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UwhjAQc4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="p53exaWa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46E4685
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285590; cv=fail; b=ebkCAMlDE5z2lUD1qx9n0GvKrcnwH3fpKUevCF+6pSnl0XbwQUlxygJ2if/QIs5P1NWGY7p9+IgvJz4uNC8i+8P2+YX1xhSFQrk5KZhqZVCqlZPRJ7DELpLwGfL+u3n8hYTTwygciaXgM8x23qz/+uyVaFpKqfHP4IXthmz1hBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285590; c=relaxed/simple;
	bh=0UgYQ2wrN0pmrZrnrGGgZRvYF+gKFU5jiGRABwRA2LQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0jE8S5NadqEcIs+ZK1O1wJGHC0tZiQO+f2Mhd8iSXsn6xG2LWky8QaTKd1Git++5pkwRKkwwoGWfeUfyUYNuyYtNucKuiZ26JuO+QPmfKqlsjMkPqLS0lc8x16R1ZNwbN3RPF9YHi7HdYHa8Pl8bDDPkVq+xsP9OW4PAemldkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UwhjAQc4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=p53exaWa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 77f03f9c70f411f08871991801538c65-20250804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0UgYQ2wrN0pmrZrnrGGgZRvYF+gKFU5jiGRABwRA2LQ=;
	b=UwhjAQc4w9feog8jYBhi58EdMUuvKCMlGT5KHwY5WqgPHFfNd7gkG7oDAS6+LzeJuCIOCbCV1C0JDEPfdhQZMwJ7sMeZHtFZ4nOCbdsPzAoOioH1Gt92dykBa9JdVbOpjGw44y3q4T1eJSmnIvtwZt/SMS5wS4WHwWEwuLM4giA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:4f93b28d-4542-4de1-a743-0da3b840b58a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:64e3790f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 77f03f9c70f411f08871991801538c65-20250804
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1439966945; Mon, 04 Aug 2025 13:32:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 4 Aug 2025 13:32:52 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 4 Aug 2025 13:32:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq5TsDt3U7u0rZsba5X8B7Mo+WweBG8W6lRskZBLNXSnHHshYBs3uvqObhCpSUSFwsoIomlQZiA6bxHxs4E49gap2AkSGyAE71IR6R0R1UgSnxcezAAP7gLmSmomoGNIqLjMIeGXkbgkvSqmIkW0QnxakpkUrDhB1HYPFwZS8o8gNqgpWB6T1SV8aTZhCxn9RnNNc33CDF07JhXgkA12jwEcbA2B78Uv0Dxtwdb9UhjeLH6qpBVcVTYRG+E8qqRixxfq7s16cHbZQxwh3GjP+d2xGZhx6UIxorKCO7pfLpo3/GOfHjXM8QkWxP3sKwatWZNKgaCJGSOIpM9TUqaqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UgYQ2wrN0pmrZrnrGGgZRvYF+gKFU5jiGRABwRA2LQ=;
 b=mMt+Tapbs4nIdlbtha4oRBIZHCKapw0OoW58swJkYNaeUJy6P2yQ1owG6xeCXb4O+mwg6jm9BURiN3l+4vHwd4QH83+4RhmW74d4MuXGC80hbqz9AGACkFyg0wQZ0o6dt5Sg/VjoE7L2mGe6bJcECuacmdzFMQz0oDdpcSZ975zWF0lGeHi8sD5z/6JnXuKvAdjkqZlzc6mlEP9z0FT9wz72ihsVCTvvuC0Qpql6zi6uCcyF+/HBAsjozsSJoHjN588O+UjQJqe3E0hOuVsBZE2NA9IkK9spccdXDKujLgj86kZ7rMAXXnX26/RWNj8vpZgKxRADYmeBRASsRPHRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UgYQ2wrN0pmrZrnrGGgZRvYF+gKFU5jiGRABwRA2LQ=;
 b=p53exaWa0nfS+1Xy93AG5xTFLEZM6InrMtkLaq4qqng88JCVb1XQ9h+R0JSY/v7AomXMNxaeHlg5ZbTm8CQVk1gjJYVDzU/3rVNnWAYM7w4JbaJ/a6yenGtjNqOXa/DqyeI0jDWaEZKtJuTmYizdK2k9VyyqxcANETZOruV+yyI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8209.apcprd03.prod.outlook.com (2603:1096:990:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 05:32:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 05:32:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "towwy321@gmail.com" <towwy321@gmail.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "granquet@baylibre.com"
	<granquet@baylibre.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?=
	<Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: dp: Fix suspend/resume training failure
Thread-Topic: [PATCH] drm/mediatek: dp: Fix suspend/resume training failure
Thread-Index: AQHcBGIWD0x9Pyy7ZUm9cR9DTuvCLLRR+agA
Date: Mon, 4 Aug 2025 05:32:49 +0000
Message-ID: <d2e118a85bac5ce2be7882b6339ebce563d37953.camel@mediatek.com>
References: <CACw2aoTa8KU-KkxqA10OeVK+yV7t-B94KDa4Odi1sbpY6qAENg@mail.gmail.com>
In-Reply-To: <CACw2aoTa8KU-KkxqA10OeVK+yV7t-B94KDa4Odi1sbpY6qAENg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8209:EE_
x-ms-office365-filtering-correlation-id: 8809a65b-2757-49d7-341d-08ddd31859e9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L21GZzV6L0g1a0hQZnU1WkZEaTBTeHI5N0Jrc1crbDRsVHVNandSZGZlYzNy?=
 =?utf-8?B?ZzhMbS94YUlydXFvMHMvR0hrYk5QemwwT0xrU2FheWRneWtKZURXYkZia203?=
 =?utf-8?B?RXpnZUo1eEpIc0g4SEVIUXJXZjZISFp5a3V1WEtsSjM2eFpQOUZ3QkxSRG84?=
 =?utf-8?B?U2E1NEFUMjV2VnBlMkZhUHBPak42RjJVelVxUW16SDM3NDB4NEltNG4xQkI2?=
 =?utf-8?B?OFdEcXN1VVoxV092TjVkTnJaTnBvQXYzSlNVODdPc3ljNTdWTkVueXNvU2V4?=
 =?utf-8?B?NTVwTXlENkg5NDYyM0p1UmhkN29MU0syeEYyWmFJTkxUQ1Avc1ozMnpBRnpK?=
 =?utf-8?B?NUpMblhFcUVzeEM4ZlBUVVJ4SEJGN201OUpQcWorUWJURmtFbUNTZ3k4Ujdq?=
 =?utf-8?B?SU9yZG82L3NZNmgzSXNCdEJLVUtjbjZDLy9OK1hsOUN4WGlvb0dkMTV2ZzNo?=
 =?utf-8?B?R0hoaVRMZjNFR3liNytPNTVnOStNYWgzYzZwbFR6Nkd6emVad3dMUS9GM0Rh?=
 =?utf-8?B?R1ZUSUpkekMxN21yZkFSQ1FCNTU1Zyt5V0RYTmduVEhpeHI2WmtDSVdYb3dC?=
 =?utf-8?B?aWY4SS9mak9WUmttUU9QK3BSeTJpU3FJbFNVMUxrZ2llQ0l4bWFGVmpxbS9N?=
 =?utf-8?B?eFVxQ1dqZXlNRkRQaWgzcWVjVmo0M3VVVkdjZUJwUkxwbU92RndQUmF5bG9m?=
 =?utf-8?B?WTgzMFJnZ1FoT25xay8wbFJydmNETXNXNitkbjNXVW5OcGU2SmpVUFhxNUt4?=
 =?utf-8?B?TzlYK2dRYnl1NzdjcEh1OWwveFd6a1NiVHJ6ODUrdnFpQ1V2MDB0bXZkcUFS?=
 =?utf-8?B?NW1jVmhrQWtoRmNvTzJjZ0d3SzhYdGgyOFVkOGRPdkFrRWtBb2ZyVzUyQnpW?=
 =?utf-8?B?eWY5S0crYmlvM1BreXJFTEZwZ0lHbVBCTS8rZllqQmhQVzZIclpvcUN6eVNJ?=
 =?utf-8?B?NzM1Z0tTOHBEd0didytOd1RDanZ6L2h4NGF5b3dHTjlha29oVVVzODFEejc1?=
 =?utf-8?B?L1cxbjNNdkZJaHIzYnZKd08xNk1na25MODJlQkhIVXZwZW1Meld5eGVEM2xJ?=
 =?utf-8?B?bTU4cisvb24yV2NWTk9heTVwZGpyUmlId3phUWFOZElVcHVNY3ZtcUNBcnpi?=
 =?utf-8?B?Tk0zQW5WcnIxYXFISGwwUkp4dnA3VFdaMGxOSG0rYzZ0a2ozWHViOXlyZU9o?=
 =?utf-8?B?M2xITjh5UVpNL3VCR2FhalExUDYwYUFQTlRoOFZ4ZjV2RzBuQklWR01zd0Fn?=
 =?utf-8?B?Ylg0cjB5VGh4N1RLSisxSkxhK1Q5eG45cmZ6RXpqeTIwcHRxUGlDZDJPQ3pO?=
 =?utf-8?B?dWZiV0gwR1BCcjBZV256a2xzblFVdmhTNFJYZ0lxMEc4ZzlaSitXVTVQMEpQ?=
 =?utf-8?B?YWpZL2s4RGJuRnZqYjMwcy9sbnBNYUNSaWZWZWRSUU9KaksrZ3BSUlU0WTQ4?=
 =?utf-8?B?K2VmaU5VeDBTaktDSllBYXFteENsVXJJR1BEbGVObGs1YjV4ZzVXelFLQmpJ?=
 =?utf-8?B?RFprTUpMbXBwdEdFUDR6bEhBbmk2UEs5dTVoV2p6c1dBd2dmQzEycXZWOGl3?=
 =?utf-8?B?RFlTdVJhRzhNQmNkK01MYit6WEtXdlM3V1AyaVRDSmg3UDhJdVdZQTdTckIx?=
 =?utf-8?B?c2J3dS9xUCtJdy9ucTJGQng5TjZYWUYrNHBuNnNxb2VGNHVkNzYrY213WW9m?=
 =?utf-8?B?cXV5Yy94ZHVtWm9GSGhqNk1jemxWQXdkN0hybjArdnZRelNtQ1lVL1plVUVm?=
 =?utf-8?B?aEJwMGRPVWtPQ0xsejZZTk9tb25oelp0Tmc1ZTc1RTBtTUZFb0cyeTkvZnZs?=
 =?utf-8?B?amFRNTc4R2xnT3VHMUNCRzduK1N6WlcrTVBFclkxenYxNmFxcWFHWUROLzU5?=
 =?utf-8?B?THp3WDRDay9oWnV5TUt0WXlPRHlYMm1yeXpXdmhpVXRkRlFjUVA1VUpzWUJM?=
 =?utf-8?B?dTRpNWVIT3ByYmR2cUlNbHJQZ3BPcU5DdTYxdVFEWE9uT3BNR3lqQ0xycTFV?=
 =?utf-8?B?RUM3UmFCbEN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW8ydTRZNFFxN3l5b1BmSXo3eExudWlBMDVtcUxKMkFvZ1dNUUg3TDhlUmc1?=
 =?utf-8?B?Vjg0UHkxQkxZOHh2bFg3bzZ6NlFNcUhTcUljRzJ1S1h3ZCt5cTF6ODFPUlN0?=
 =?utf-8?B?eTR0NUZLYThMbUlHaEJqOWZneFNQVzk5RVhzcVJKcnMyMzNsYmUzMHlQYlJO?=
 =?utf-8?B?REw3aVh2Ty94TmZIY3BFcTVSdmU4dU5MSE5LcGd2a2lqSVlJeFdKSGptNllL?=
 =?utf-8?B?Wm9aaE51TS9sUGhxR3h0ckc4UElnQTR6YWVLMjRkVkxMVEVhMXBubC9jQVBp?=
 =?utf-8?B?ZlNkY3pIOVFjMFd2SktWeEhqVzNHREc0NFpaQXVxMjZza0ZOdVJoUWdCWFVh?=
 =?utf-8?B?Y1c2MDd2WHE0Y3dQOUFxdFhJNzc4d0NEOUNvOXBQZ3BFcVFNRHZ5bGIvMHAr?=
 =?utf-8?B?QUVGYURjOCs4UTBKektyQnlQa1dCcU5jWjlPcS9JeTdHZEErV2pteXk4emEr?=
 =?utf-8?B?VUdVczJoZ2g5R2JpN3dabWQxWUZSL053VUVVWXhBUXhqd2lZeGd2QkRCSGJY?=
 =?utf-8?B?c1ZWOXp3VzlveHdVZk9MSzNxZWRNRmZmcmpia0Q2MVB0Vjg2UVFxeXFSdnlr?=
 =?utf-8?B?MDYvUVp0eGNMK05IR2VhV3dxM3hsYVpkc2ZYbVc5WVFVR3VoWlY0YmFBcUlx?=
 =?utf-8?B?RCtLOTZmbFl4OXJMMGcyc0NsNmhvVHpRNFVDSjltUVo2aGRGektOMEswMi9k?=
 =?utf-8?B?c05UbEd1TTFleGZHa1lBU095NTE5WHVKQ3RybytCQS9NWXl5WXMwTC8xVHJv?=
 =?utf-8?B?SWtVRWpzOFlKeXpDZmN2d1pjQ2RmUXA2aTdFTVlNdnFYbXJkMU5kMExwcmll?=
 =?utf-8?B?NDZLWU9rWFhOYXhHYWVNOEdZZXBjeEZYck9RQjN2aDRrMnkvdktHSnVOUlI1?=
 =?utf-8?B?T3Q5b0x5ZkJ0RkVMOS8vQmJyVlhFeXZ1enJSNHBYN00wdk00MFFOeEZJM2dk?=
 =?utf-8?B?NFFadWtINDlUd3NaZ3pJZXVNb1FiOFRReCt3c0RsNTUxbnZwMkpwOGhqRXJH?=
 =?utf-8?B?dTdmQVdOUzBTK0c2TlBucWwxMm9BOTQrb0JvUWRHVW9JQlBWWFZONGFzS29U?=
 =?utf-8?B?OFZsdDlqeE5jdElvTnlHTHZBaHZKMSt5S0hubmdQZWFuT0ttZmRqN0RwZFpQ?=
 =?utf-8?B?SWxOQXgzc2tqQmhSTmh6V1VFQTJlVUt4QjViTnhWalFiWC9iWDU1cmRjZXpZ?=
 =?utf-8?B?dnV0Y2phbnMyRTU0T0tQRGRrb0pjZ3BzcWIxWC9ReVpSYytIL05GbHRLaWFV?=
 =?utf-8?B?V3hpcW0yeEp6TWJ5NlRjaTJaYzAzTGNjNDNVOWtBOWJYbkl6WXJhd1JnME9V?=
 =?utf-8?B?QUdDYzJHVkRuU2JxUFRxTGk5dWhFeXhQWHhYNFRIcEZ3ME1WWVRGb3BMZTQ0?=
 =?utf-8?B?Q1ZVR3I2T2IzcmxYQXYzT2pDeTJ4UExEMnRIVTRoNG1odU5WOHBaSGpCVGZF?=
 =?utf-8?B?Y3FMK1ZtRE9PWkYxZlczR3FUZjIrWkZuUVZWUnZYcDVzNWR3R00zUDBveTBL?=
 =?utf-8?B?Ui9tLy9ZbVJucVFQU0owOHZVOGYxSThxbGJBeXIzRGo3OHN0Y1B5L2xjUzVo?=
 =?utf-8?B?dVB4WjlMT0d6ZTlPaHNHV0xyVzVVMWFkclVpclloTkRxYWxMajNEUGp3a3hm?=
 =?utf-8?B?NkFLUUFZMnhqRHFtd1RxZWNZSzNoSk1kdTQ0WVR2MGpoeGcrOVFrZGY3Z2Ew?=
 =?utf-8?B?RHhnZnA0cytXV3lPZUlrNHJQcmNBT1Z4UFdUalBDd2lhbEdua2xhczhoT3Fz?=
 =?utf-8?B?andUVGN0OHd4eHB2K2dCazExbDhIYXgzQkpaUXVhem1PWkN4YVNMYTdORXpH?=
 =?utf-8?B?TDd3NUhOdVlXUlNmWSs2cUhCdXZmcVgxeFFGdmcreEtoUktnaUdhc3lWOFZK?=
 =?utf-8?B?amRzcnhIREE5YkRjUlZpL0FaQjZ5Q21STHNRb1N5SkNzU2p0QnZCOFQ0d0ZB?=
 =?utf-8?B?aDdtN2cyMkZVT3kvZzhtK0hkN1RmNklaVHVJNnlnbmxtdVRiZDQrQTJYRlk1?=
 =?utf-8?B?V3grc3o2WnRIU3BwTVMwV00wYVZqTG1uaEM1MXMzblB4UllBNmxJMDQ3VXFW?=
 =?utf-8?B?TVJWR2pGSTl0UlJNbS9vWmVwM3RSS3BVWDFiVWk2djN2TzliMXJKSHlkeFVG?=
 =?utf-8?Q?Hed8bi/m9qzKkLtEOxPrvyGE8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F49D895D10D5242895E45C624828F4B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8809a65b-2757-49d7-341d-08ddd31859e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 05:32:49.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERLNq0P/qCTsW9nHFceUAKxi6K9f45VXLpyqQVIUCZCos9FFC9pM9dOQlLvsGcNTTvIpTNod2SnNQ3kEukvkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8209

T24gU3VuLCAyMDI1LTA4LTAzIGF0IDE4OjMyICswODAwLCBIYXJ1IFpoZW5nIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IEZyb20gNDkxOWJkODU4Y2Q5Y2JhOGU0YWFkYmE3YzNkMWZkNDM0ZWYzYjA5ZSBN
b24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogSGFydSBaaGVuZyA8dG93d3kzMjFAZ21h
aWwuY29tPg0KPiBEYXRlOiBXZWQsIDE4IEp1biAyMDI1IDExOjI4OjM3ICswODAwDQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL21lZGlhdGVrOiBkcDogRml4IHN1c3BlbmQvcmVzdW1lIHRyYWluaW5n
IGZhaWx1cmUNCj4gDQo+IFdoZW4gc3VzcGVuZGluZyBhbmQgcmVzdW1pbmcgRGlzcGxheVBvcnQg
dmlhIFR5cGUtQywNCj4gbGluayB0cmFpbmluZyBtYXkgZmFpbC4NCj4gDQo+IFRoaXMgcGF0Y2gg
YmFja3BvcnRzIHRoZSBzb2Z0d2FyZSBJUlEgaGFuZGxpbmcgZm9yIERQLA0KPiBhcyBlRFAgdXNl
cyBoYXJkd2FyZSBJUlEgd2hpbGUgRFAgdXNlcyBzb2Z0d2FyZSBJUlEuDQo+IEFkZGl0aW9uYWxs
eSwgY2FibGVfcGx1Z2dlZF9pbiBpcyBmbGlwcGVkIGluDQo+IG10a19kcF9ocGRfZXZlbnQgdG8g
ZW5zdXJlIGNvcnJlY3QgaG90cGx1ZyBkZXRlY3Rpb24NCj4gZHVyaW5nIHJlc3VtZS4NCj4gDQo+
IFRoZXNlIGNoYW5nZXMgZml4IHRoZSBEUCB0cmFpbmluZyBmYWlsdXJlIGFmdGVyIHN1c3BlbmQv
cmVzdW1lLg0KPiANCj4gRml4ZXM6IGY3MGFjMDk3YTJjZiAoImRybS9tZWRpYXRlazogQWRkIE1U
ODE5NSBFbWJlZGRlZCBEaXNwbGF5UG9ydCBkcml2ZXIiKQ0KPiBUZXN0ZWQtb246IEdlbmlvIEc3
MDAgRVZLDQo+IFNpZ25lZC1vZmYtYnk6IEhhcnUgWmhlbmcgPHRvd3d5MzIxQGdtYWlsLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgICAgIHwgMTAwICsr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwX3JlZy5oIHwgICAzICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5k
ZXggYmVmNmVlYjMwZDNlLi4wY2ZlNzkyYmMzNmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwLmMNCj4gQEAgLTEwMTIsNiArMTAxMiwxNiBAQCBzdGF0aWMgdTMyIG10a19kcF9zd2ly
cV9nZXRfY2xlYXIoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgIHJldHVybiBpcnFfc3RhdHVz
Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIG10a19kcF9zd2lycV9lbmFibGUoc3RydWN0IG10
a19kcCAqbXRrX2RwLCBib29sIGVuYWJsZSkNCj4gK3sNCj4gKyBpZiAoZW5hYmxlKQ0KDQpVc2Ug
J3RhYicgaW5zdGVhZCBvZiB3aGl0ZSBzcGFjZSBmb3IgaW5kZW50Lg0KDQo+ICsgbXRrX2RwX3Vw
ZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM1QzQsIDAsDQo+ICsgICAgU1dfSVJR
X0ZJTkFMX1NUQVRVU19EUF9UUkFOU19QMF9NQVNLKTsNCj4gKyBlbHNlDQo+ICsgbXRrX2RwX3Vw
ZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM1QzQsIDB4RkZGRiwNCj4gKyAgICBT
V19JUlFfRklOQUxfU1RBVFVTX0RQX1RSQU5TX1AwX01BU0spOw0KDQpTaW1wbGlmeSB0aGlzIGFz
Og0KDQptdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVFJBTlNfUDBfMzVDNCwgZW5h
YmxlID8gMCA6IDB4ZmZmZiwNCgkJICAgU1dfSVJRX0ZJTkFMX1NUQVRVU19EUF9UUkFOU19QMF9N
QVNLKTsNCg0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdTMyIG10a19kcF9od2lycV9nZXRfY2xlYXIo
c3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgew0KPiAgIHUzMiBpcnFfc3RhdHVzID0gKG10a19k
cF9yZWFkKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM0MTgpICYNCj4gQEAgLTE3NTEsNiArMTc2
MSw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3BhcnNlX2NhcGFiaWxpdGllcyhzdHJ1Y3QNCj4gbXRr
X2RwICptdGtfZHApDQo+ICAgICAgIG10a19kcC0+dHJhaW5faW5mby5zaW5rX3NzYykNCj4gICBy
ZXR1cm4gMDsNCj4gDQo+ICsgbWVtc2V0KG10a19kcC0+cnhfY2FwLCAwLCBEUF9SRUNFSVZFUl9D
QVBfU0laRSk7DQoNClRoaXMgaXMgbm90IG5lY2Vzc2FyeS4gRHJvcCBpdC4NCg0KPiArDQo+ICAg
cmV0ID0gZHJtX2RwX3JlYWRfZHBjZF9jYXBzKCZtdGtfZHAtPmF1eCwgbXRrX2RwLT5yeF9jYXAp
Ow0KPiAgIGlmIChyZXQgPCAwKQ0KPiAgIHJldHVybiByZXQ7DQo+IEBAIC0yMDMxLDggKzIwNDMs
OCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2RwX2hwZF9ldmVudChpbnQgaHBkLCB2b2lkICpk
ZXYpDQo+ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX2RwLT5pcnFfdGhyZWFkX2xvY2ss
IGZsYWdzKTsNCj4gDQo+ICAgaWYgKGNhYmxlX3N0YV9jaGcpIHsNCj4gLSBpZiAoISEobXRrX2Rw
X3JlYWQobXRrX2RwLCBNVEtfRFBfVFJBTlNfUDBfMzQxNCkgJg0KPiAtICAgICAgICBIUERfREJf
RFBfVFJBTlNfUDBfTUFTSykpDQo+ICsgaWYgKCEobXRrX2RwX3JlYWQobXRrX2RwLCBNVEtfRFBf
VFJBTlNfUDBfMzQxNCkgJg0KPiArICAgICAgIEhQRF9EQl9EUF9UUkFOU19QMF9NQVNLKSkNCg0K
V2h5IHRoZSBkZWZpbml0aW9uIGlzIGNoYW5nZWQ/DQoNCj4gICBtdGtfZHAtPnRyYWluX2luZm8u
Y2FibGVfcGx1Z2dlZF9pbiA9IHRydWU7DQo+ICAgZWxzZQ0KPiAgIG10a19kcC0+dHJhaW5faW5m
by5jYWJsZV9wbHVnZ2VkX2luID0gZmFsc2U7DQo+IEBAIC0yMjY1LDYgKzIyNzcsNDEgQEAgc3Rh
dGljIHNzaXplX3QgbXRrX2RwX2F1eF90cmFuc2ZlcihzdHJ1Y3QNCj4gZHJtX2RwX2F1eCAqbXRr
X2F1eCwNCj4gICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIG10a19kcF9z
d2lycV9ocGQoc3RydWN0IG10a19kcCAqbXRrX2RwLCB1OCBjb25uKQ0KPiArew0KPiArIHUzMiBk
YXRhOw0KPiArDQo+ICsgZGF0YSA9IG10a19kcF9yZWFkKG10a19kcCwgTVRLX0RQX1RSQU5TX1Aw
XzM0MTQpOw0KPiArDQo+ICsgbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5T
X1AwXzM0MTQsDQo+ICsgICAgSFBEX09WUl9FTl9EUF9UUkFOU19QMF9NQVNLLA0KPiArICAgIEhQ
RF9PVlJfRU5fRFBfVFJBTlNfUDBfTUFTSyk7DQo+ICsNCj4gKyBpZiAoY29ubikNCj4gKyBtdGtf
ZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVFJBTlNfUDBfMzQxNCwNCj4gKyAgICBIUERf
U0VUX0RQX1RSQU5TX1AwX01BU0ssDQo+ICsgICAgSFBEX1NFVF9EUF9UUkFOU19QMF9NQVNLKTsN
Cj4gKyBlbHNlDQo+ICsgbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1Aw
XzM0MTQsDQo+ICsgICAgMCwNCj4gKyAgICBIUERfU0VUX0RQX1RSQU5TX1AwX01BU0spOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBtdGtfZHBfc3dpcnFfaHBkX2ludGVycnVwdF9zZXQoc3Ry
dWN0IG10a19kcCAqbXRrX2RwLCB1OCBzdGF0dXMpDQo+ICt7DQo+ICsgZGV2X2luZm8obXRrX2Rw
LT5kZXYsICJbRFBUWF0gc3RhdHVzOiVkIFsyOkRJU0NPTk5FQ1QsIDQ6Q09OTkVDVF1cbiIsIHN0
YXR1cyk7DQoNClVzZSBkZXZfZGJnKCkgaW5zdGVhZCBvZiBkZXZfaW5mbygpLg0KSSBkbyBub3Qg
bGlrZSBtYW55IGxvZyB3aGVuIG5vdGhpbmcgd3JvbmcuDQpMb2cgd291bGQgY29zdCBDUFUgdXNh
Z2UgYW5kIHJlZHVjZSB0aGUgcGVyZm9ybWFuY2UuDQoNCj4gKw0KPiArIGlmIChzdGF0dXMgPT0g
TVRLX0RQX0hQRF9DT05ORUNUKSB7DQo+ICsgbXRrX2RwX2luaXRfcG9ydChtdGtfZHApOw0KDQpJ
biBtdGtfZHBfcmVzdW1lKCksIG10a19kcF9pbml0X3BvcnQoKSBpcyBhbHJlYWR5IGNhbGxlZC4N
CkRvIG5vdCBjYWxsIGl0IGFnYWluIGhlcmUuDQoNCj4gKyBtdGtfZHBfc3dpcnFfaHBkKG10a19k
cCwgVFJVRSk7DQo+ICsgfSBlbHNlIHsNCj4gKyBtdGtfZHBfc3dpcnFfaHBkKG10a19kcCwgRkFM
U0UpOw0KPiArIH0NCj4gKw0KPiArIG10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9U
UkFOU19QMF8zNUMwLCBzdGF0dXMsDQo+ICsgICAgU1dfSVJRX1NFVF9EUF9UUkFOU19QMF9NQVNL
KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBtdGtfZHBfcG93ZXJvbihzdHJ1Y3QgbXRrX2Rw
ICptdGtfZHApDQo+ICB7DQo+ICAgaW50IHJldDsNCj4gQEAgLTI1MzQsNyArMjU4MSw3IEBAIHN0
YXRpYyBpbnQgbXRrX2RwX2JyaWRnZV9hdG9taWNfY2hlY2soc3RydWN0DQo+IGRybV9icmlkZ2Ug
KmJyaWRnZSwNCj4gDQo+ICAgZGV2X2RiZyhtdGtfZHAtPmRldiwgImlucHV0IGZvcm1hdCAweCUw
NHgsIG91dHB1dCBmb3JtYXQgMHglMDR4XG4iLA0KPiAgIGJyaWRnZV9zdGF0ZS0+aW5wdXRfYnVz
X2NmZy5mb3JtYXQsDQo+IC0gYnJpZGdlX3N0YXRlLT5vdXRwdXRfYnVzX2NmZy5mb3JtYXQpOw0K
PiArIGJyaWRnZV9zdGF0ZS0+b3V0cHV0X2J1c19jZmcuZm9ybWF0KTsNCj4gDQo+ICAgaWYgKGlu
cHV0X2J1c19mb3JtYXQgPT0gTUVESUFfQlVTX0ZNVF9ZVVlWOF8xWDE2KQ0KPiAgIG10a19kcC0+
aW5mby5mb3JtYXQgPSBEUF9QSVhFTEZPUk1BVF9ZVVY0MjI7DQo+IEBAIC0yNTUyLDYgKzI1OTks
MzAgQEAgc3RhdGljIGludCBtdGtfZHBfYnJpZGdlX2F0b21pY19jaGVjayhzdHJ1Y3QNCj4gZHJt
X2JyaWRnZSAqYnJpZGdlLA0KPiAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lk
IG10a19kcF9icmlkZ2VfaHBkX25vdGlmeShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAr
ICAgICAgZW51bSBkcm1fY29ubmVjdG9yX3N0YXR1cyBzdGF0dXMpDQoNCm10a19kcF9icmlkZ2Vf
aHBkX25vdGlmeSgpIGlzIHVzZWxlc3MuIERyb3AgaXQuDQoNCj4gK3sNCj4gKyBzdHJ1Y3QgbXRr
X2RwICptdGtfZHAgPSBtdGtfZHBfZnJvbV9icmlkZ2UoYnJpZGdlKTsNCj4gKyBzdHJ1Y3QgbXRr
X2RwX3RyYWluX2luZm8gKnRyYWluX2luZm8gPSAmbXRrX2RwLT50cmFpbl9pbmZvOw0KPiArDQo+
ICsgaWYgKG10a19kcC0+YnJpZGdlLnR5cGUgIT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkgew0K
PiArIGlmIChtdGtfZHAtPmhwZF9zdGF0ZSAhPSBzdGF0dXMpIHsNCj4gKyBpZiAoc3RhdHVzID09
IGNvbm5lY3Rvcl9zdGF0dXNfZGlzY29ubmVjdGVkKSB7DQo+ICsgdHJhaW5faW5mby0+Y2FibGVf
cGx1Z2dlZF9pbiA9IGZhbHNlOw0KPiArIH0gZWxzZSB7DQo+ICsgbXRrX2RwX3VwZGF0ZV9iaXRz
KG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM0MTQsDQo+ICsgICAgSFBEX09WUl9FTl9EUF9UUkFO
U19QMF9NQVNLLA0KPiArICAgIEhQRF9PVlJfRU5fRFBfVFJBTlNfUDBfTUFTSyk7DQo+ICsgbXRr
X2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM0MTQsDQo+ICsgICAgSFBE
X1NFVF9EUF9UUkFOU19QMF9NQVNLLA0KPiArICAgIEhQRF9TRVRfRFBfVFJBTlNfUDBfTUFTSyk7
DQo+ICsgdHJhaW5faW5mby0+Y2FibGVfcGx1Z2dlZF9pbiA9IHRydWU7DQo+ICsgfQ0KPiArIG10
a19kcC0+aHBkX3N0YXRlID0gc3RhdHVzOw0KPiArIH0NCj4gKyB9DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBtdGtfZHBfYnJpZGdlX2Z1bmNzID0g
ew0KPiAgIC5hdG9taWNfY2hlY2sgPSBtdGtfZHBfYnJpZGdlX2F0b21pY19jaGVjaywNCj4gICAu
YXRvbWljX2R1cGxpY2F0ZV9zdGF0ZSA9IGRybV9hdG9taWNfaGVscGVyX2JyaWRnZV9kdXBsaWNh
dGVfc3RhdGUsDQo+IEBAIC0yODAxLDcgKzI4NzIsOCBAQCBzdGF0aWMgaW50IG10a19kcF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIG10a19kcF9wb3dlcl9lbmFibGUo
bXRrX2RwKTsNCj4gDQo+ICAgLyogRGlzYWJsZSBIVyBpbnRlcnJ1cHRzOiB3ZSBkb24ndCBuZWVk
IGFueSBmb3IgZURQICovDQo+IC0gbXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsN
Cj4gKyBtdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwgdHJ1ZSk7DQoNCmVEUCBkb2VzIG5vdCBu
ZWVkIElSUS4gV2h5IGRvIHlvdSBlbmFibGUgaXQ/DQoNCj4gKyBtdGtfZHBfc3dpcnFfZW5hYmxl
KG10a19kcCwgZmFsc2UpOw0KPiANCj4gICAvKg0KPiAgICogUG93ZXIgb24gdGhlIEFVWCB0byBh
bGxvdyByZWFkaW5nIHRoZSBFRElEIGZyb20gYXV4LWJ1czoNCj4gQEAgLTI4MjksNiArMjkwMSw5
IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAgfQ0KPiAgIH0NCj4gICB9IGVsc2Ugew0KPiArIG10a19kcF9zd2lycV9lbmFibGUobXRr
X2RwLCBmYWxzZSk7DQo+ICsgbXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4g
KyBtdGtfZHBfc3dpcnFfZW5hYmxlKG10a19kcCwgdHJ1ZSk7DQoNCkZvciBEUCwgaXJxIGVuYWJs
ZSB3aGVuIGJyaWRnZSBhdHRhY2guDQpEbyBub3QgZW5hYmxlIGhlcmUuDQoNCj4gICBtdGtfZHAt
PmJyaWRnZS5vcHMgPSBEUk1fQlJJREdFX09QX0RFVEVDVCB8DQo+ICAgICAgICBEUk1fQlJJREdF
X09QX0VESUQgfCBEUk1fQlJJREdFX09QX0hQRDsNCj4gICByZXQgPSBkZXZtX2RybV9icmlkZ2Vf
YWRkKGRldiwgJm10a19kcC0+YnJpZGdlKTsNCj4gQEAgLTI4NjEsMTAgKzI5MzYsMTUgQEAgc3Rh
dGljIGludCBtdGtfZHBfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgc3RydWN0IG10
a19kcCAqbXRrX2RwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IA0KPiAgIG10a19kcF9wb3dl
cl9kaXNhYmxlKG10a19kcCk7DQo+IC0gaWYgKG10a19kcC0+YnJpZGdlLnR5cGUgIT0gRFJNX01P
REVfQ09OTkVDVE9SX2VEUCkNCj4gKw0KPiArIGlmIChtdGtfZHAtPmJyaWRnZS50eXBlID09IERS
TV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4gICBtdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwg
ZmFsc2UpOw0KDQpUaGlzIHBhdGNoIGlzIGZvciBkcCBub3QgZWRwLCByaWdodD8NCldoeSBkbyB5
b3UgY2hhbmdlIGJlaGF2aW9yIG9mIGVkcD8NCg0KPiAtIHBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2
KTsNCj4gKyB9IGVsc2Ugew0KPiArIG10a19kcF9zd2lycV9ocGRfaW50ZXJydXB0X3NldChtdGtf
ZHAsIE1US19EUF9IUERfRElTQ09OTkVDVCk7DQo+ICsgbXRrX2RwX3N3aXJxX2VuYWJsZShtdGtf
ZHAsIGZhbHNlKTsNCj4gKyB9DQo+IA0KPiArIHBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsNCj4g
ICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC0yODc0LDggKzI5NTQsMTQgQEAgc3RhdGljIGlu
dCBtdGtfZHBfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+ICAgcG1fcnVudGltZV9n
ZXRfc3luYyhkZXYpOw0KPiAgIG10a19kcF9pbml0X3BvcnQobXRrX2RwKTsNCj4gLSBpZiAobXRr
X2RwLT5icmlkZ2UudHlwZSAhPSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiArDQo+ICsgaWYg
KG10a19kcC0+YnJpZGdlLnR5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkgew0KPiAgIG10
a19kcF9od2lycV9lbmFibGUobXRrX2RwLCB0cnVlKTsNCg0KVGhpcyBwYXRjaCBpcyBmb3IgZHAg
bm90IGVkcCwgcmlnaHQ/DQpXaHkgZG8geW91IGNoYW5nZSBiZWhhdmlvciBvZiBlZHA/DQoNCj4g
KyB9IGVsc2Ugew0KPiArIG10a19kcF9zd2lycV9ocGRfaW50ZXJydXB0X3NldChtdGtfZHAsIE1U
S19EUF9IUERfQ09OTkVDVCk7DQo+ICsgbXRrX2RwX3N3aXJxX2VuYWJsZShtdGtfZHAsIHRydWUp
Ow0KDQpJdCBzZWVtcyB0aGF0IHlvdSB3YW50IHRvIG5vdGlmeSBjb25uZWN0aW9uIHdoZW4gcmVz
dW1lLg0KWW91IGNvdWxkIG5vdGlmeSBpbiBzb2Z0d2FyZSBmbG93IGFuZCBkbyBub3QgbmVlZCBh
biBJUlEgdG8gZG8gdGhpcy4NClRyeSB0byBkbyBpdCBpbiBzb2Z0d2FyZSBmbG93Lg0KSWYgeW91
IGhhdmUgYW55IHByb2JsZW0sIGxldCdzIGRpc2N1c3MuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsg
fQ0KPiArDQo+ICAgbXRrX2RwX3Bvd2VyX2VuYWJsZShtdGtfZHApOw0KPiANCj4gICByZXR1cm4g
MDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+IGluZGV4IDhhZDdh
OWNjMjU5ZS4uN2M5N2UyMzBiZTUwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwX3JlZy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBfcmVnLmgNCj4gQEAgLTI4Niw3ICsyODYsMTAgQEANCj4gICNkZWZpbmUgUE9TVF9NSVNDX0RB
VEFfTEFORTFfT1ZfRFBfVFJBTlNfUDBfTUFTSyBCSVQoOSkNCj4gICNkZWZpbmUgUE9TVF9NSVND
X0RBVEFfTEFORTJfT1ZfRFBfVFJBTlNfUDBfTUFTSyBCSVQoMTApDQo+ICAjZGVmaW5lIFBPU1Rf
TUlTQ19EQVRBX0xBTkUzX09WX0RQX1RSQU5TX1AwX01BU0sgQklUKDExKQ0KPiArI2RlZmluZSBN
VEtfRFBfVFJBTlNfUDBfMzVDMCAweDM1YzANCj4gKyNkZWZpbmUgTVRLX0RQX1RSQU5TX1AwXzM1
QzQgMHgzNWM0DQo+ICAjZGVmaW5lIE1US19EUF9UUkFOU19QMF8zNUM4IDB4MzVjOA0KPiArI2Rl
ZmluZSBTV19JUlFfU0VUX0RQX1RSQU5TX1AwX01BU0sgR0VOTUFTSygxNSwgMCkNCj4gICNkZWZp
bmUgU1dfSVJRX0NMUl9EUF9UUkFOU19QMF9NQVNLIEdFTk1BU0soMTUsIDApDQo+ICAjZGVmaW5l
IFNXX0lSUV9TVEFUVVNfRFBfVFJBTlNfUDBfTUFTSyBHRU5NQVNLKDE1LCAwKQ0KPiAgI2RlZmlu
ZSBNVEtfRFBfVFJBTlNfUDBfMzVEMCAweDM1ZDANCj4gLS0NCj4gMi40NS4yDQoNCg==

