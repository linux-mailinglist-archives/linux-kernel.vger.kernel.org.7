Return-Path: <linux-kernel+bounces-769871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9FB274A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863811CC5394
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A97DA93;
	Fri, 15 Aug 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X0mUK/1A";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TJs7JHob"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4C8821;
	Fri, 15 Aug 2025 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220667; cv=fail; b=iHQw9tVn/pkpBwjlAmM2c9PpMeuJ9eDrKLpP+m0QmLvWVM3KYVyO0uEC4vqDW+N8nOvodw6inMBqPeZH00ZwVW7avFNHI3M3gQCKbIKuR0XiYTJpbb+mKXjPUjwrdNuaTLeybpNXNzU8DQ5Ezwq7z66eHgqH7VN4/aJ6r9t/onw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220667; c=relaxed/simple;
	bh=vUg8VHlbMKQs1KmyrYlYQtohfaxttNKrbOVXlE8vm2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9RT+znuqHYrlD8U7kurpfFX32U1lEziaNFf09qBjEyQUsvBDiYLV8jrS3i47Km22xRyOTu3rqpVO6ulYZyJiuF08ySLDUI0l0QAmh0vVYbYKIgzDBQFwVua2xAFfAH3Qdawk1Tk2RC/fYrfY/HAmnGyiXbXGtz+frU3nEWTcuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X0mUK/1A; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TJs7JHob; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a2c7fd16797511f08729452bf625a8b4-20250815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vUg8VHlbMKQs1KmyrYlYQtohfaxttNKrbOVXlE8vm2Y=;
	b=X0mUK/1ADiGRz5CYYTStdT7tTg2OL+AYeGES4gPNDhprF9BDmIXk0EgFYwB+eJQ7GIEOFVnt4SdZbCBYJ+tETnhkBT9GNRsVzUkAVbl/CvnGA2qc168dPVD3gpusftNDr1Skx/xVONPnEp1yqJ1cLBmrQmRrln45yQ+XE67u3qQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:d57fae52-50a8-414d-a7fe-f02bb08818e9,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:c5dbf2f3-66cd-4ff9-9728-6a6f64661009,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a2c7fd16797511f08729452bf625a8b4-20250815
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1118742475; Fri, 15 Aug 2025 09:17:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 15 Aug 2025 09:17:38 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 15 Aug 2025 09:17:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahoDr0It9GE8HMhRUtzomlq0BybwnOZbKcHxecVK8hfhUxIaBwZuoS5UlSCVHxY8/MR7WifXFtQWz0AZ4OcBcZbvVw7rJ853UMWXeA7rXs+wQUehvKRBuwknyRz11p70Hlps6WxckzxZRYzJvRat7XvIQ5Y0TL2UiBL7AeMycdmVFAJEqWGRfHkhga8dYmcATn9pyAGFzwRChbpiQL3XLJx5pu3F2aPnEcT7AKddkSHJJlW0D0c83+qoQZGyIEs9+3EKM3okIKwz5Tp5R6rKdKcyz29lbZJKHMh3ssc60E59HQMwiWRhjg3O0RZ7Unn1fOFaBP1ShqWb87M+T/YCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUg8VHlbMKQs1KmyrYlYQtohfaxttNKrbOVXlE8vm2Y=;
 b=o23fDrFut3NacYZ1z0+9o0FeEUEeeJ5ga2aW8gRxM5SI90dR5gV2Xt6gPVuwG0GdcDBpD3ys6oye2wTT4/IOxswoKJe1K85zWdIuKzZHvFfYmwh3n44dsVAgu840pTj6NgUEAf2Xmae2xssn2qeau7AzznY+8iwQsE5m5tOyTpnFPVRPBDCpUadzHmseTY5g6A7iXpK1wY96yrl52lnLzfx7JHCh8tGexBfI5w0ZGFKsH9PWieMmuVpNI6uXAu/GY6mRZz+1kmqw3T+/aCRWDEciQ5R1iEs8lndNOMq6j6sS9S0vKCgl9kFT9Pk3fqT8MQwJDx10gcKaAcDzOPvtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUg8VHlbMKQs1KmyrYlYQtohfaxttNKrbOVXlE8vm2Y=;
 b=TJs7JHob+n86P6J7YCDMiwrW5pWiIq9tVL02a1LmzWGNiYwZ48asW0Eii0NlzHjpYKSmgE0JSRbsTGyhhOKWPZcLX6CygZ74vIv/PjRdZvfOsBvEhBKEOrPvajsnd1u/PxHh/LFsxQbQ5G6596RtInzQYewqp+ZXqMoO7y2RtIU=
Received: from PSAPR03MB5735.apcprd03.prod.outlook.com (2603:1096:301:83::6)
 by SEZPR03MB7538.apcprd03.prod.outlook.com (2603:1096:101:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 01:17:35 +0000
Received: from PSAPR03MB5735.apcprd03.prod.outlook.com
 ([fe80::18a0:6ce9:9b10:4baa]) by PSAPR03MB5735.apcprd03.prod.outlook.com
 ([fe80::18a0:6ce9:9b10:4baa%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 01:17:35 +0000
From: =?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>
To: =?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?VmluY2UtV0wgTGl1ICjlionmlofpvo0p?= <Vince-WL.Liu@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?= <Jh.Hsu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>
Subject: Re: [PATCH v1 1/4] [v1,01/04]dt-bindings: mailbox: add cmdq yaml for
 MT8189
Thread-Topic: [PATCH v1 1/4] [v1,01/04]dt-bindings: mailbox: add cmdq yaml for
 MT8189
Thread-Index: AQHcDOm//JXmWLfEVkWeJ5f1b9jKr7RhucqAgAExHwA=
Date: Fri, 15 Aug 2025 01:17:34 +0000
Message-ID: <fcffcbb4b9ecbd8b7f0cd74784b6e104eef737fb.camel@mediatek.com>
References: <20250814070401.13432-1-xiandong.wang@mediatek.com>
	 <ea477661-9b2a-4e79-a21c-4043d0afff88@kernel.org>
In-Reply-To: <ea477661-9b2a-4e79-a21c-4043d0afff88@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5735:EE_|SEZPR03MB7538:EE_
x-ms-office365-filtering-correlation-id: 8ce8d33d-a45e-4ead-58fa-08dddb99841d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlNLQXd5dDlobmZtT1VBYzVWVnZxbmdnN2RQK0t2eUVqZzBudEl3WTdpUXN5?=
 =?utf-8?B?WHVvN1JydXBIRlFQQ0x1bkZxM0pGUFl3dDNsenJ5SFlCWFh3d05lTHVhbUdK?=
 =?utf-8?B?a3IzOGpoSUlQdnZrdVNPVm5EM0dpVnFUQ3hpcG1YN05VZ0N6dnQyd1RrYzJY?=
 =?utf-8?B?UnJtUTZ0RVRiOS9CV3Z5QklJVlRHMTFONm1VZisvK2poY280SnJBeUNDbGlK?=
 =?utf-8?B?VnRYTkFTL0pDVlh1dUh1SWg5Nk1xdWI3OElVTlprbkUrT3Y2U2xJYW05cTVI?=
 =?utf-8?B?OFlTcStlbzF3dkY2Y1FiTEJVVlRPdGxZcVk1TmZDaUNXWlI5NkFITUhlTzFV?=
 =?utf-8?B?TURESkVvQmJSOWN5Q0o1ZFFvMG9TNXBka1oydml3V0VkakowNldjOE5HS2Yy?=
 =?utf-8?B?TC9RMXJxQ3V6cDdOaklFenhSSXpDMHJsZndQU3k5VTRlaG5DSmlyY1BUTWF3?=
 =?utf-8?B?NFNsMlBRRWhhdndXei91NmpidVBvNm0zenZKVGFxKzZFeUJCUUxRcjVyYVE0?=
 =?utf-8?B?VGRIcnE3ZmdKK25sQlR5UGRoUW1PQ0kyUDA5MklaOWg2MmpWWXlZa2o2aExY?=
 =?utf-8?B?cTV4c216U0hUVXhIZWcrZW85MmpSaURtNkZOcTBPYnczV1QrelZJVERHVnM3?=
 =?utf-8?B?U3pBajMxdHVtVEMyM0ZmdjVYMjZqMzZ1bDBJQXBORXB0Z3lEak9Qczl5b1B5?=
 =?utf-8?B?WDA5QWFENkhKM0wyQnBjZEtlandFQmU1ZVJzSjRkQkZNdGxWaDVncjFmKzNB?=
 =?utf-8?B?SStUQ3hGQ0Zrd0ZKWndpUnpSbjJLb0JZUFJiZzdMWGN3MDFpbC9DS1pOR1V5?=
 =?utf-8?B?dnZKelRwaDJTalRCR1pWSFp4aWR3SUtLTE45Y0g0RHU1SzB3SkRpOFE5WUJS?=
 =?utf-8?B?a0V0c0xqUHpXRm8rV1JJWGxIWVVOT3didENvUlNDTUIxcTcySTl5aW1nVTZC?=
 =?utf-8?B?eUVOaTNnZ2xNZUNvNUNyaEdrOXhxWmpZRlJzZ0JYS0RNZ3hNL25FMllLYkd2?=
 =?utf-8?B?SDMwa2NkQWlVRkVjMmhYWnBjb3lodWpSa3lXZWhLMzc0QXpoVVZSdklzcUJX?=
 =?utf-8?B?d3ljMVlDbzhsQkRTUFlZMUQyWlU2eWUxV1pENGs0R3FmckVSMFBzOUZJUmxh?=
 =?utf-8?B?ZEl1OXpMb1MzTmViK21ybElLbjhwTS9rQ1NRcWdHVVliclc2ZTQwTE9MMVpK?=
 =?utf-8?B?a29FVUVGVkdYd2JNSHVyV1BEU3pYVXpRUSt4di9iUWNrOFJjSEN4a1BsOGl0?=
 =?utf-8?B?WlVyN0wrWkFIZjN4MzNmY1NHOWNkMUdNUllhOElFVzhnUDZtNFpYRXVka1p2?=
 =?utf-8?B?RDJ6KzgvR0ZLMWUvSWsrajR1bSszbHJFQlZxMFRRa3Y5RXduT1UzSG5kQnlN?=
 =?utf-8?B?ZTJKemRtZ2NucERPdHhGN2tjblpZSzVBcXhmOVlxSGlINkxrQkkzTlRUbytV?=
 =?utf-8?B?aFFlYy9LZ2FBNkhhc2VVc0JFVnVPTTVCaWxGbjQ1eWJLdXR6N29OY2wrL0k2?=
 =?utf-8?B?T0srK3Jnbld0NFl3Q21Obzc2V0ZZVkRMbmdxRmhZS1pQZjhxWGtZNTJ4S2RO?=
 =?utf-8?B?Z256ZUJJZzhHTlpGT2cwN3Z5blFiVEFZQnpuZkIybzFxQjJVNEhNZmFham93?=
 =?utf-8?B?Y3dUOGxVM2p1czZhS0FxckxiTnpKSmxVaUlTVXo5bG9tNEhTaWdHWnJFR3Vo?=
 =?utf-8?B?QTVINkNmdnJzRVc2Y3dIMytGRENidlNWbzdQMzFzMkwrMjZCK2w4QW5pVVVm?=
 =?utf-8?B?TXMwRmNJb0lFQytHellaSjg0UFNnUVVERHhnOVd6RkJGYUY3R29URFk5a3NJ?=
 =?utf-8?B?VEpXYkZOV3FtMHlwVTRMWEJZYUFjbkJXZk1hME5zNDFwV3g5MFZxVGNrL0Jv?=
 =?utf-8?B?M1FlU3RmQVpTZEhHQ3NFNC82dlJ4a2w3UytJYlpkd0NveHJkT3l5SEVsVGdQ?=
 =?utf-8?B?VWttc3pPQXlISlZaMFZRUnBlT1F6Z1FidGNMcEZ4amJtTkk5bFhqalhHUTg5?=
 =?utf-8?B?Y0N5ck1mWWtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5735.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDlmTVdQdUZELzcxRDlXNXR6NUpEYUc5RDRtaVRpcFlxRnhHK25jRk04eS9L?=
 =?utf-8?B?a0k5RGRGRjI3by9lMVJNRThEdldhbm1SM29NaHdkakRILzB2N2NvemY2TGN2?=
 =?utf-8?B?OVdOWmJoV0hqZ0djK3laTkZWbW1QQW1BczdHckFUTmcxZ1J6QmVCZ0pLUExZ?=
 =?utf-8?B?WFl4Wnd6YWwzWC92UE9Hdm9Td1hXU0lYN2dhSXJuaXZCWmZEZit2VGVZT1pK?=
 =?utf-8?B?UHhPVGFQT2hKWHJSRmRZMUhUK005eWZyQkVCVmpEZFRrTGFxamhNbFZUbHZh?=
 =?utf-8?B?QlpjNDJlb09JMm04MklRTmx5K2N2MFZObGZXaDl4QUhTNEdZVGdjZ3h5ZzJr?=
 =?utf-8?B?eHE5VmNqeFZYY2E5NmJWbXNkMmEyU1RuNktUM2h2Y2ZFa0xwRXluQ3hmTjlF?=
 =?utf-8?B?S21ueVhaYVZONjJNdXpvbUJ5WDd3L0dzUWhGZHVRMStBRjdSYnh0NTJnR29q?=
 =?utf-8?B?aTdxaFU2OVZ5RFYyRFV4anFNbTMzL2dkVkMwOEsvZS9XT1AxN1huaUlUak1X?=
 =?utf-8?B?Y1R4Y0VNVWh5UzNmQ2JtL1JPa281akhVTXA2ZDVsb2ZDTjdJS1NIUkNDU0l2?=
 =?utf-8?B?dmtmSDNCMm9DZC81OXJHa00xdXJYOWY0UU9CcmYvY0l5bW4wcTd0ZlViZFo0?=
 =?utf-8?B?bDUzWm03MTU4cUMrT0JwNm1GVlg4ZWpBWlBFT0FpZndUaFBLdXVVZmplc2ZX?=
 =?utf-8?B?cVdTcXloY3l4elBjbEVhdE00aFEzWHd5R2pHVFUzSUs0Ylk3MWsrMGk4Zjhq?=
 =?utf-8?B?NFVKREdYNjJrVGlsbVdPcjBjTnF3T0dJMUdwV3BEcWpreHR5REZMazhXQkUy?=
 =?utf-8?B?cDNVMlhiNnJpQlQ5bzIxVTlHQ1VtSHQwcUIzNEtBQVpNZXhIZnhkQWFVd2hZ?=
 =?utf-8?B?dzRIdEljZFNnMUlTbllKMmEyNkdxNncvMXVxbWd1QkluZ0dYWmhsL1hWQnNh?=
 =?utf-8?B?R1F4MHdnRHJKNTQ2bHIxcHRGbDJjb3JubTljTjBQMFZzeWZMbkNTUWk1Y0lq?=
 =?utf-8?B?azJCbG5aVmVjZWxBbWJsTGxQRmg1TnFBdVFsbmhwb0dRNU9hSk5CQUNBS0tO?=
 =?utf-8?B?R1pwb1dXRTIxSWJhWDI3dnd0bTF3bUYwNG9uQmhMbDNyMDBObnpsT21jQVp5?=
 =?utf-8?B?WGxnc2YvL1N5VktsQnUxL0l0MWdyVy96RlBkNTk0Mmx5OU44T1FRbFZQamRt?=
 =?utf-8?B?TWRqWEFOMXFsWk1CTHZQeXl0dThxa2NRbm9ZcmFuemRDZ0NVbG13UDZhSHNK?=
 =?utf-8?B?Qk9lOTVCYnN2QTVTR2lVN0NPUUlxeElSMk5HcEttdkc1T1BIbm5YbEl1K1hN?=
 =?utf-8?B?aS9RTXNwMit6TlEwQnVsRUdCb0xhYm83Ni9pN0paUGNmOTgreURRYjZxME9l?=
 =?utf-8?B?WjhwUDBQdEsyM0l2R25kT2FtR05vWFUrQjZIaHdrL3JJVGRxRVNQSjRjL3l0?=
 =?utf-8?B?VFNDeFd0SmFlVGR5WlN3SEdyQ3N3STRvdHFHdEoxaXZFR1FrUWxaYVl1MDRo?=
 =?utf-8?B?MmpRbllvRlVXV213QzQ2Yit6U0hEVTQySEZKd2Rpejd0bmYzTUFVNG11WVRU?=
 =?utf-8?B?UC9RMXBQSjNFVlJMQXBHeHBTNk5sZ2oxdUhUblBNYzZLSXZheDB2M1VSV214?=
 =?utf-8?B?eEtBL3BNOHBDNUNsaFhrM3V4RitzTGpkYko0WjRDWUtSRWxsRWNrQ3czSWx5?=
 =?utf-8?B?SXlBVUNLWVFpNko1L0FCNnlYdUhiRjJhYmQxeFBzN0I4dzAvYzVtZFlhVjNF?=
 =?utf-8?B?K2tsdmVoQzZlNFF0TzFiTm5ORUh3RkI1S2VhQ05nSGdIZzh1TXMxbjZjRnEx?=
 =?utf-8?B?VUJNS3lGNUo2NGxHV0hTSjY0R0VjS1h2MVRYK2pBcFVDNHVqdUl5MjlabEJN?=
 =?utf-8?B?T3AyZnJ1YVNjcTBnS0g0WkdqZy9EZXdjSWdpMFM1c2Z4VXFTeTJPTFc0NDRh?=
 =?utf-8?B?YVpzaVI1WkdvWGVQOVE1aHIyK0VNbmtmY2ttM0Rmb0czajIwOUgvVXFsUkNE?=
 =?utf-8?B?c1JsQVRCUFlqRFljY1QvbWtRQkRjRHdKUnZ5ZUwvZ2YySXhlYUNxQzc2T0FK?=
 =?utf-8?B?bDdHTDU4N2FLcXkwMWM4ZURqL0NJVmJ6dkxabTlnZkdKaEloQVowYlUybS9W?=
 =?utf-8?B?NGtPY0c0NFhCMThvR0krSHpTZW94Q3BEQ3lsaG0wQVBIK2xCNXp6Nm1zQUdU?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC1A5DDBA65194AA38C04DC37F7C429@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5735.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce8d33d-a45e-4ead-58fa-08dddb99841d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 01:17:34.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hc9qfA4MmJwdZL3cb8LYAgofbp5xLIEWwOM+WWalpqmzjpH30rGpbY1hW92KbQgmTIa5azrZVy4vL7ixB05+X0nzrzztyzZ2STfq2Q6JFZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7538

RGVhciBrcnprOg0KDQpTb3JyeSwgVGhlIGZvcm1hdCBvZiBwcmVmaXggaXMgZXJyb3IsIEkgd2ls
bCBmaXggaXQgYW5kDQp1cGxvYWQgdGhlIG5ldyBwYXRjaGVzIEFTQVAuDQoNCk9uIFRodSwgMjAy
NS0wOC0xNCBhdCAwOTowNSArMDIwMCwNCktyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gT24gMTQvMDgvMjAyNSAwOTowMywgWGlhbmRvbmcgV2FuZyB3cm90ZToNCj4g
PiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgdG8gc3VwcG9ydCBjbWRxIGZvciBNVDgxODkuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlhbmRvbmcgV2FuZyA8eGlhbmRvbmcud2FuZ0BtZWRpYXRl
ay5jb20+DQo+IA0KPiBZb3VyIHBhdGNoZXMgaGF2ZSBjb3JydXB0ZWQgUEFUQ0ggcHJlZml4LiBV
c2Ugc3RhbmRhcmQgdG9vbHMsIGI0IG9yDQo+IGdpdA0KPiBmb3JtYXQtcGF0Y2guDQo+IA0KPiAN
Cj4gDQo+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

