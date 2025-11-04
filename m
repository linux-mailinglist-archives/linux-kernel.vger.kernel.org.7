Return-Path: <linux-kernel+bounces-884799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2EC31317
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74CFB4FCEAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D82F619B;
	Tue,  4 Nov 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g5WVrTcq"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B882F5304
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262041; cv=fail; b=sDMIIQO4v2X/2dcryN35ciDDkSMxA973NzOWeFIo4IaugTwR8Nz4VCwKgMWIyWoaB3rXAjSzjwQsEjazSJnwiOcTyhjP6v3FxlpqM6A0O4afYDFZcX1+rtVVXH3wXBe+8jOzLYDNDS/FBdqJ75ankXfMfdQ7WCXuUH4/u5KMZQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262041; c=relaxed/simple;
	bh=TNiWPWz0sQeiUhQn6USe9rb1gIXUPZRQOCK5uqyZJWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/C90fTf+pvOss+U0kzmW60E18L+GO6K0QF0bjd0AiRjWit1RoLOIMCJOqgJCTNZc2+FZd4CbJNb5eEouDQU5Zx+7EWVP0zQadUBzcganspZRRj2cvfkpeKQcTAtttkliRxX0uD5fy5joeuhEsqZ+LCRrC8T2o/7dMxVlXjuExI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g5WVrTcq; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAon34WPaE4UT4iiVJhfuQq9yZQIv3AmYtfCn8XVObHv2uzyAcIUZAHyp8eo91Sjfwahca69wYOo8TpcBJDb4NwI1NZrdk/tjJVD3nfdSfAuc2nNsumpraVOZe1H0x2GYK7y3XvlbrwCa9zT3i8nE/Q7/FcR+4Eg6w0JfPAQ8ce4xOUXbEP89Ve4chbRXBLobbIvYs57BEvRnrHwPxq+Fxtel7DgTeSK2BHdPgKE3Rp/KlZWK89DHXiSzN0jiwuSWOlUUlAc06S9Vtc9tPDcK7Z7rv1U+qQH3jS0ypN1Qg80XwjHhbQsw7RKB40QaAiq//8GuXaFMDLcfxkNgY2ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNiWPWz0sQeiUhQn6USe9rb1gIXUPZRQOCK5uqyZJWI=;
 b=MqKwqU226INv3ZTkx6eWFxKb2e2Z2v8ZrmRh4K4O6EBcU6X6nvtrRrQPuNxxCIu4kgth4H6oG9xXmEdmjmca6I1OJEB9gQE0JuySQT8UO0UoMwO4yP5cXEN2rDMizjBJWIsa17wGkKf7SCQ3RwHR4eCwkJxvfRFyJ/b763Zl3A8CZKEwB016/Qw9xW+4/KVEV/2eLGCOrB/CYhoULXF6gFCrd4R821zrPU7qeHKWlREE+AngIPyrCCKrczDmlfj7ijHxa8xpnQPxmcLYeEwaAi52XnLjL6F+zLmomZ32lgXYSjxJlG4DfsfFuMHk5xglkW86I1KuCMQBV7vw2TvUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNiWPWz0sQeiUhQn6USe9rb1gIXUPZRQOCK5uqyZJWI=;
 b=g5WVrTcqUWr5C5LVKRpfX1nLG9KAZI3eMmG+hzRk/eig6T77BUR7jRQASjXJq4TdltrAK9wA0+rSpCKX3xCM0XUh7FKj0Y+7YkMQB2bpdNI2Sh8FZLKSL/H5cJcd4fLPjL/U8dD33J9LXGgfZYRPYn5HK3vlEdRy9qJfKmNOIyecbutV7T+poLW3NVbpdklBAAAxcPrwduoRKzzU3UQLcArOGkRbybRTzRue62iVbSgjI/Nb2k+XUDYKAAWEdo0hWrbP/ssvshRBH/Q4YE0q5F1tJwmm2x/+JoRn9bblrbC1sjOZmj7eeWssCOqnzFCrwtRHLAUqMWExt8ddDYDf1g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA3PR10MB9271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:13:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 13:13:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index:
 AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAAscICAACr6AIAAC/mAgAAB+ACAAPUxgA==
Date: Tue, 4 Nov 2025 13:13:56 +0000
Message-ID: <2941b3527113a0b09b9a380e4746bf899948708c.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
	 <662a5f56-8851-43a8-af27-237acd799943@csgroup.eu>
	 <437fcacbc39286d1256e1f7ef034a2a3d52a8b18.camel@siemens.com>
	 <764858d5-5633-4aeb-aabe-52f9eb1eb530@csgroup.eu>
In-Reply-To: <764858d5-5633-4aeb-aabe-52f9eb1eb530@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA3PR10MB9271:EE_
x-ms-office365-filtering-correlation-id: 0903a216-c1a3-41b4-f93e-08de1ba402a9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEtCUHFrVldjSWNsejNrVTFvRk1MR1ZBNFk4OGRDUE5DS0ZWWTc2MFUrL2l6?=
 =?utf-8?B?L1BlZ25uVG9wOUNiVWl6dmFHM2R1TzRZdDA3ZE9JMkdSemplRG8vSjhORnl4?=
 =?utf-8?B?UmJHUy9UVDEwZGhHeUg3dUpiMi82MTF5UjdhbHhCbU8yc3RUb1g1RnZpUGFC?=
 =?utf-8?B?ZjU5L0hTSGUwZ0xPT1FoVm55a0hQSFBzVGNRbitaN2djbjZVbWx2dmJyZXl4?=
 =?utf-8?B?MWNyT1pRb1NmRGRHVmJtOXl4MTR6SCtZTUFmN3hxTjhoa0NNeHZSV0tncW9v?=
 =?utf-8?B?dTFXVlJmU2xwNTREZUx5Vi9CRGtJeTZ1Q0RDTEYyZ3RWUm1xRE1uUUJMNkZz?=
 =?utf-8?B?c3RqbUU2c3htT1I0UnlzNnlOTGYxcEFqR2F6eDU5M3E0Q256aXAvWDJTWE1X?=
 =?utf-8?B?NDNneXlHaWpiL2hrV3dKaFBJeER2eUJvSFJQK3lPUElxWHVLcWhRakFLZmNp?=
 =?utf-8?B?dGdHRWVUSEZrUGNtcUE3U01Wc1hLdmJva1dYc0VHQUh1djcrMlV4Tmt0STRP?=
 =?utf-8?B?UGswVk9SdEZSd2k1amtQZnJJbHd3eDNncGtUSU0xbzYzVDBvakhscjRyZStG?=
 =?utf-8?B?ME1IZnp6VmpoS2VRdCt3TEZLRWN4QXRtWjZjODA1aEoreCtOUms1aDVLRndl?=
 =?utf-8?B?SFl0dFZlbUNVVEt0cFh3NVZqQm40MDRiY2R4aFlPakJ5VWFvN0RER1B1ZkMz?=
 =?utf-8?B?WWdWRnAvOFI2OVBmRzFvNGJjU21zTmdIZGJWYUZDMUdBNXdJWlY5NnowWWdx?=
 =?utf-8?B?VU9IOWlHdTd5d2FpTkRJcjNNcEc4THJ6dXNuNjUrdjd1cXdLZEdCSzdQVVhs?=
 =?utf-8?B?eklpWnBsU2U4WEJBam5HR0RHUjJoK1BwZEw4K2RIWlcvWGZRZ1NIbGg0dElQ?=
 =?utf-8?B?Tk5oMFRUSm9PVTZkZ2RFZGdqL2RuZEtMMWZwbm5DY3BCeTl3ci80VStibm9v?=
 =?utf-8?B?elp2dExMWlVNYTAvaEVEeWxBSDBqOTF0a2RKb1IwZStpRHBJdGM3Yysvbi9Z?=
 =?utf-8?B?TEo3WUlBdDFUVk96a2FDMVlFcERualFSUzZod2FLYk5rYitaT0IrTjVsZ1FG?=
 =?utf-8?B?YzZYYTdIbEMzNWs1UVI4YkRPSkZhTDYvVVR0Slc3YVhuV3BNakN0QXU3Mjkz?=
 =?utf-8?B?TlNZU1M1ajlJYUpBTWFIb3dBeUdPSGtlbEJMQWRPZXBoTXliYTJIRlVPc2RQ?=
 =?utf-8?B?cDkrQmxBbzBSa0VuaklzSTU1Q1JzZnpTYW9YTVJhMWp5d1ZZcnVTb0l0ZndN?=
 =?utf-8?B?RFh6R01hTWdjbWJjQmdCMmFJSkJkbW5TOFN1bFZIbUxvU3pXcHFsNFR2dFlF?=
 =?utf-8?B?NXJvUmJ5MzlMRVVXTTV0bVNRSWplKzV0RVZ3QUJnRDJwRURGSGNaODhWZlQ5?=
 =?utf-8?B?RGxGclJWNXNMbW1WZDhEU1BVcmpkRS9NY1hrTVpOR0w1U3h2cFlwcXMwR2xw?=
 =?utf-8?B?b0VncnpjSytSY3VFaGc3MnRHOVMwWURPYWhzNVlUZnhVK2phN0pXZzJCUVpY?=
 =?utf-8?B?cDdEN1hHeG5JYnFVS2Z0OTVBY1gvSmFwck5PbTZLVWNObFdIU1FnNXU3eTNS?=
 =?utf-8?B?VDBOTTJzd1F5bVBnenU0Y2JxRy8rV0ZmWHBMNGczcEdmT0VPK1RXNXh2UmdG?=
 =?utf-8?B?dHNvNlNxWGhNMGE3emFCaU9LUG9UL3lMMndSOUc0TmtTc29IV3h3bklyZ3Zp?=
 =?utf-8?B?NERvKzhKSERna2FBekJzM0VFSUl0Y1B1VmM4RnhVeDVOOFlCaVBXK2hKS3lD?=
 =?utf-8?B?a3ZKeERnWHVLaGZYYzBCL1V4d2FzQkp4VHVOUjRvNU9rWE52ZkJaTWJ4TVRa?=
 =?utf-8?B?NlUvTHFOZ1RBaDR3VDdoMFRFK0o0Y0c2N0U1K0ZPL245WHBMbjNUYmlyTWRU?=
 =?utf-8?B?emQ1ZkdNQS83bEM4UzJLalFBTkZxb2ZabmkxcXJBcEk5a2FkUExuWW9qdC9Q?=
 =?utf-8?B?SFhBS1lOME1aR2QvVy9LandtUERSTUI2SzRwa3ZqTkVybXJPS01BNXF5cFkz?=
 =?utf-8?B?VHNtaDZqaFJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFIxVjQ1OHlVQnh5WFJLL1JqQnNRSDMvYjVDK09PMzhVd2krc1BOaCtXdnF0?=
 =?utf-8?B?S3pzaEYvSGc3YlJ3MkpZZmg4eWd0WElSRVNZUUVnS2NUOU5sRVhncmlUNGhJ?=
 =?utf-8?B?T29lbVRoWnRvV0JhT2c1MFVzR0xCNktzMFVwV0RqWWRleE9wN2ZKYTA5TSta?=
 =?utf-8?B?Z0p0Y2RKemIxcUEzVFZsajJmZWVrTUJMVVJmNGd3K0VzNzR2aThGRm52Vm12?=
 =?utf-8?B?a1AzclFGVENQYUV3cHZDS3dHQXplTk5QU3dzSTJOSStZcHI3R0FTb0R6Wjl4?=
 =?utf-8?B?REJsTGpFNjVkRFRselo5UDZGWUVXeDZzb0tiSldpaWRZRnRwYUg1ZG1TQ2My?=
 =?utf-8?B?UlpyQ1doNFJ4blF3a3NSZ00rVFM2QmtJT21DMEFVdFBWb2l5cko4SDE3aG1V?=
 =?utf-8?B?YkY1TG5VTnVKUFgxclVIMTljelBnWWtrRlJuaFc5LytiN1dFd3NwNFpKL05B?=
 =?utf-8?B?YXFrOXhSU3hFMWI2VEprMW9hSi9zcHpqVW1Md3MybG1uWG5qV0JEZUpVbUt5?=
 =?utf-8?B?R290TXRuQktFc2FGVG5QT2JoMnNZMGQvRk4wNEI0ZnFjenY5aVNDUkNRVzN4?=
 =?utf-8?B?SGZaOFpiYWQ3ZGlpcnlzeHlWR3E0RG1lQUUwSWlWN1JjTjVXK2pGV1U1UWR0?=
 =?utf-8?B?OFc4QVdaLyt4UHMxb0UwYkFRUlFwMkNTVjN6b05ZSi9IbC9VQnRoOW5sSmJn?=
 =?utf-8?B?NVFZcTVUVW1xcUVjeURRcDEwTWh3OURUY2Q5cGx1SGhqSWM4VWppMy9CWThD?=
 =?utf-8?B?dEptNzhSb0ExOXRZeW02a0s0TVV2QURieE1vVlV6L3NPTFdYYmxZWkVXWmxQ?=
 =?utf-8?B?SXVLL0M1L3NsMG5pY2ZPODF1MytCdlNIcHcxcVNIOURGb1ZOVS9waFFiN1Nv?=
 =?utf-8?B?ay9XODlWbUtORE1TYkFPaWxpclAwS1p1Q0ZHdGl1Vmd6VVd4a0dOdkJUdDlQ?=
 =?utf-8?B?eC9QMmRKWW1Za2tJb0g0TDVIWi9vU09zT0FIaXQrTlUzRkg0WVFuL1lDeHJa?=
 =?utf-8?B?UTdaNlh5anVQT0xNYTVLaDR4ekRjRDE0Z2xsUGtBT01YWTYzdWJka096UXk0?=
 =?utf-8?B?dDYyTDYvQVloWFZrV0ZseVd4ZE5CR2R4bXIvVWRNMVRJa2xKaGJmbzJJcWRT?=
 =?utf-8?B?QlpocnZaUS8vN2FFQUo0MnFHcm43VldwUFRvN1BzSGdGbEdXZ09nbDZ1eXNs?=
 =?utf-8?B?M2QwMkJYTUxLTm1SK2p6VFpvRUZ0a2J3U0dINk8wTXlaeG9na2k2NERyYzM1?=
 =?utf-8?B?eTdpY1R1TnczRk43ZkNteGUyLzdhdEorczhlN0pnRXVIbmZJbFU5MExCWXJy?=
 =?utf-8?B?RldNVmwyZVNMUjcvTHFYUUdBTWpnMEtrVE5iS29UN3lneHhvWExULzBYcjRv?=
 =?utf-8?B?Q1FMbStvTGlnRFMyb255bnRmZTRab3llWjFOOHBFS0ZrWDJUWkdkWHR4eW93?=
 =?utf-8?B?dVZYMVlqWmx5Q1Z3ZVlaT1FVL3lpVTRlei9MSGpJQ1hLcUVWMDZUdzZqODd5?=
 =?utf-8?B?QXpZZVNIdk1RMTNzbytma3BEV1ZnMUx6T0o2ay9XUEt0V1g4SGlwSmZySm13?=
 =?utf-8?B?ZHVKa1l6VHpEaHRMWFk5b0t6Y0x6cTQ2Qm9Tb3d0STNqZmFBaVpxV2VTazFM?=
 =?utf-8?B?NSs3OENZZ0FUWmdMdE1YRTNvSGtEd1JlcmFPa1dDN3hVVlJXV1NWa3hseHVu?=
 =?utf-8?B?Z0ExdWFsMWRXMnkvMWQyR0tUM1RSWjJCR3hvWW12WHJFOGpnaGFQT1kwTDU2?=
 =?utf-8?B?UmpjZElPU3BIZjJmNVRDb2ZEWW1qOXIvajdnMmVob1NBeSt0WXZ3eDgzL2VR?=
 =?utf-8?B?c1NOZXB3ZjZieHNyaWVhdEZweUQ0WWRMUnZhN2hQeUNpZG13OTZjYlNHWS9y?=
 =?utf-8?B?SDhpQ2JMdjVTOENONEJFS1VRd3AyQStJdGlCWGpYeTducFJKWUQ1TVZXSlg5?=
 =?utf-8?B?V2FzOWRqZnJhdVM5L1BjOFBic0N3Q2RNT2RFazFwbmUrZ2VSeUNTQ2lYblVX?=
 =?utf-8?B?ck5XRTAzcldEK0Z1UzJRLzVNZ3hUYWxvV1R6KytScEE4Vk5GM2xPTW1kRUFy?=
 =?utf-8?B?TDk5VThIRjVRUm9Hdlp3TS80UzlqaEVBM3ZsMTl5ejkwWmU2alFNSlc4V3Nu?=
 =?utf-8?B?bTBmb1RyRFBPWUxUR00zamNQSFB0YmlKSEFQYkRmWGdHMkNmeWNtREdkeHVw?=
 =?utf-8?Q?ID7w9jlJOYsVaJcvCUnFUbM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08BFD966F3E1704D9C75124FD153CD0D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0903a216-c1a3-41b4-f93e-08de1ba402a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 13:13:56.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAPHImZRfLaz8GSPi8NDzOycGAB+NGzgfJUpPK5J/7V8KHQfkvOVis4TQuwf4DzOoGAndjJ2XSjsbXHMxrNJ1/xtzQxSlxmEGEFVRHPg4ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9271

SGkgQ2hyaXN0b3BoZSwNCg0KT24gTW9uLCAyMDI1LTExLTAzIGF0IDIzOjM2ICswMTAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOg0KPiA+ID4gPiA+ID4gUmVwbGFjZSB0aGUgUkFXIFNQSSBhY2Nl
c3NlcyB3aXRoIHNwaS1tZW0gQVBJLiBUaGUgbGF0dGVyIHdpbGwgZmFsbCBiYWNrIHRvDQo+ID4g
PiA+ID4gPiBSQVcgU1BJIGFjY2Vzc2VzIGlmIHNwaS1tZW0gY2FsbGJhY2tzIGFyZSBub3QgaW1w
bGVtZW50ZWQgYnkgYSBjb250cm9sbGVyDQo+ID4gPiA+ID4gPiBkcml2ZXIuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoIChrZXJuZWwgdjYuMTcuMSkgb3VyIHBvd2VycGMg
Ym9hcmRzIGFyZSB0b3RhbGx5DQo+ID4gPiA+ID4gdW5zdGFibGUsIHdlIGdldCBtdWx0aXBsZSBy
YW5kb20gT29wcyBkdWUgdG8gYmFkIG1lbW9yeSBhY2Nlc3Nlcy4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBXaXRoIHRoaXMgY29tbWl0IHJldmVydGVkIHRoZSBib2FyZCBpcyBzdGFibGUgYWdhaW4u
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIFNQSSBkcml2ZXIgaXM6DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQ09ORklHX1NQST15DQo+ID4gPiA+ID4gQ09ORklHX1NQSV9NQVNURVI9eQ0KPiA+
ID4gPiA+IENPTkZJR19TUElfTUVNPXkNCj4gPiA+ID4gPiBDT05GSUdfU1BJX0ZTTF9MSUI9eQ0K
PiA+ID4gPiA+IENPTkZJR19TUElfRlNMX0NQTT15DQo+ID4gPiA+ID4gQ09ORklHX1NQSV9GU0xf
U1BJPXkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIb3cgY2FuIHdlIGZ1cnRoZXIgaW52ZXN0aWdh
dGUgdGhlIGlzc3VlID8NCj4gPiA+ID4gDQo+ID4gPiA+IGNvdWxkIHlvdSBzaGFyZSB0aGVzZSAi
cmFuZG9tIE9vcHMiPw0KPiA+ID4gDQo+ID4gPiBTdXJlLiBBdCB0aGUgZmlyc3QgcGxhY2UgdGhl
eSBsb29rIHVucmVsYXRlZC4gU29tZXRoaW5nIGlzIGxpa2VseQ0KPiA+IA0KPiA+IGluZGVlZCwg
bm8gb2J2aW91cyBjb25uZWN0aW9uLi4uIERvIHlvdSBoYXZlIGEgY2hhbmNlIHRvIHJ1biBLQVNB
Tj8NCj4gDQo+IEkgcmFuIEtBU0FOLCBpdCBmb3VuZCBhbiBvdmVycnVuIGluIHRoZSBsb29wIGlu
IA0KPiBmc2xfc3BpX2NwbV9idWZzX2NvbXBsZXRlKCkgd2hlbiB0LT5sZW4gaXMgb2RkLCBidXQg
b25jZSBmaXhlZCB0aGUgDQo+IHJhbmRvbSBwcm9ibGVtIGlzIHN0aWxsIHRoZXJlLg0KDQp0aGFu
a3MgZm9yIHRoZSBxdWljayByZXBseSENClRoYXQgc291bmRzIHByb21pc2luZyBhbHJlYWR5IQ0K
DQpEbyB5b3UgaGF2ZSBhIGNoYW5jZSB0byBydW4gd2l0aCBDT05GSUdfREVCVUdfU1RBQ0tPVkVS
RkxPVz15ID8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K

