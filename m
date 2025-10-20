Return-Path: <linux-kernel+bounces-861781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4ABF3A69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1550018C4700
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33A2E6CAD;
	Mon, 20 Oct 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EXfRjmbx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75592E718F;
	Mon, 20 Oct 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994439; cv=fail; b=YCy5ci21cBO9cEV08aWQoByWm+/SZI6XiukemX4QOdrWrfKtioLc6L4rBLSic7znWI4jfM7DRcWCx01L+LY6uBDH5wzTPo0NCIAjUMgYJxEW1elfNpXqCaQfGtaA9gKlgOLucYkqVeQx02NGtUCFn/7kqGy8A3rh2t8bUqrS57Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994439; c=relaxed/simple;
	bh=ow5mGN688cVCXK745NZs7e6vJucjn8jDq3yyjehkDjY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sJKTgIuDoE+2mc1Zs6oGauInc0fMzSw2Dvi5HlSxO+inmZxGU3aw8HjBGz5y8pTZu/c00D6xshVJdkRTtZy9g67kHdIhRXhMqQbPk3dElezuf4pNg9gnh7CjHqy7SDSAJNgBCICKdGn6lHpHcRZ9hve46nYGA4/+/VjQs7l4gUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EXfRjmbx; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFpTtvAg+ouJO3eocKgY9SzOXWJLuavtJ8I+eBZId3sw+MLlDbaFBQa8+9VIh/7pFcP22L1Etgn3WdXrvwk0fnPTBvXDa8KpICF5xQBVhe4BXzjYwnPwWDSn9J0IR3xw0V4zLLdWIi6Lq7eygsKAruvYljCo5p1eLSj/dfgGvb+ZNrRulC8vddR//c3Z04rFhg2q3/zYtLePISaES6QBUA4cefDDn3RVg0EF/AoeQYIJFt/XVTdy6jS7rAXbhqk0e0HzLBCRLtoEKi/vsBAgydfktBqJtDsU/N2rC/K38juQGCftaizUSgwX9ye9m5pDJNRX2c0dgJ+WMN75B1LTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9phlVN9Mi7K7p9lrebzJwaGeIazWWB6sCxvTPy57AnA=;
 b=vPKqoyLpvDeg2NkJhkcr+shIaGUBC5X9QQsSfu4PTjBpPzTojQkVBdStiCC4vwioF+hvsCLEGI9NaOvFrB9YooBu3KtOUpSagdSY2rjopqIfdAS7yGe8h6Ay5QzoGrUfiHtpB2lo6H2hUDk26rHzycrmePNNLNOucz+499we8TxLGaC7CpLlIbRNteyRBcfJV8SfXCw5fgfdmYjkApn12EibLHAmgD3Yb2/R4b0HNdKy5Q4DsgPZFrqnIgr+Wy0CaDV0dghfKLNHv9arRYGcBfRfuAktc8zrqOXP3h9CUzSrew8Egff8JKt593TsUp59uIlmsjWT3lw3vcLICoSHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9phlVN9Mi7K7p9lrebzJwaGeIazWWB6sCxvTPy57AnA=;
 b=EXfRjmbxSJXp2Q979wyG2cV7/I4/a8ajjowAkqgEH2VTYLC1gu8iyxqWmmIoLPX5AMCzbX0c22LzIYWwAZd1YECUM7X2jGECZveLpFIs1wwcNI0bOuZ4SbwPz5WbmZLMZkLG6PPaEFVsfM8cdCPU1zrkF2MjhiUU2Csz9YyI5w1TLPRF7YpxPTr21qWXjTSRxqCRiMMxhlKJtN36WgvcVdUNVDFhElR9IrY6/Rqrcdqdb/FhvVla2YGaPIK4LQcYmM+uJ4bPRz9qV8W7NbAZNn1ygEhEznOZEy/Qh/v9dIc1TF5PX1CHqGIFtSOyvRJUQTxiJCy2LyrcawLJR8C1gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:07:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:07:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:40 -0400
Subject: [PATCH v2 6/9] ARM: dts: Add bus type for parallel ov5640
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-6-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994408; l=2034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ow5mGN688cVCXK745NZs7e6vJucjn8jDq3yyjehkDjY=;
 b=FR2Y11GqNxoKBB7saBp3lQbDwXDaVFDR+J8HA1NVmiAReJQDcE2bjWzloSBhGKTCh1LGL2eba
 utiyP9P2NVkAqMPcHt8TKSaJ5qo3mxmvTN7NdZc6MdaJBnJKMzadY3G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: b63a8d5b-23cf-43fd-7274-08de101ca39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmxpYmJJSmVGUXJhbTVDT2xtREF6am9iR1JZQ25DdjhLbERaN3FNVmw2UFVF?=
 =?utf-8?B?ZzdOclJwWXNjMGI1REp5TjJjcks2ZFgrdXlzQTRaQUsvdkN3Y0h0eXhUTW94?=
 =?utf-8?B?eWVZWkdreGtXZEVHS2dkamQxSGVucVNsUThFL0Rkb2xhdnpNZ2xwUU1Ea3hJ?=
 =?utf-8?B?S0JmLzBKWUtVdEREZG14bXZMUldLVFBWNitLRVd6cG5wMzZ0QW03R3haenRZ?=
 =?utf-8?B?dTlmY2d5TlVJcHViQ2VEWG04dXVZcDIvdlNNaGViK0FZeFBpWnZsaXUvTEdJ?=
 =?utf-8?B?TFlQUTBvTW9oTHZmSlZLamM4a1RlRm9hblQ3S2kyT0xvbWJmb1NTZWRNWVp0?=
 =?utf-8?B?ZXlVR3kvYzlsb3BIWEtYd1l2NWYxVHVwL0JCTWFOUlZSamxyQkVNU0FsZXFr?=
 =?utf-8?B?OTl1a1h5Um00TEVTUTFLM3RxSzd3dmlzOUV0OTZlazJpWUpOTWo3L2FZZFND?=
 =?utf-8?B?ditVRUFUM0hZd0VyeXhmN2xQd3FPMUZ6UjJJcmxlSDgxZUZQaFE3Z3VQazRm?=
 =?utf-8?B?bVZtclRFZzNqbE5sM0o3MmpsZHcyYXZ1MkRyUjVBM0RyaENOakY1Z09sa0Zk?=
 =?utf-8?B?czZEdnJ1M3BOb2hJYXFIWmNNVE1tcThOLzFaUlZBQ1dJODVVYTFCVERINktZ?=
 =?utf-8?B?dGdob2FFM0k3U3h2WGdUampyK2V6L016dFN4bGNqbHNCdGlRWUcyRjJXMm54?=
 =?utf-8?B?cjZubHlRVCtLYVBhNjJ1SG51YjVEQ0hoMzNSRzdBVzdxcmwwa0NuUXhuandX?=
 =?utf-8?B?YTlzTGZMdDJoaU53WG00TGcyZW9DOWNkV1NNeWJiY2J6dHgzS0hzeTZQcmNE?=
 =?utf-8?B?MGxZYWdSVEtNZzkxdTZmSkZyNTFRZmR1eTJFRUM4RksrRU91RDNRaStFcko2?=
 =?utf-8?B?N090U3JTMHpmTHl6TmtnWDV5UnpKMVYxUnJUZXhOd2Y3dXd4VmNEN2R0blhm?=
 =?utf-8?B?RkliMmNrUHlCcjd1K1FsamhobGFNTFNYY2phaDlvdFlZTytSdmhRTmlxOVhF?=
 =?utf-8?B?OUVCdEFRMFNMYld4a2JhRXE3SHBkM2tJQVJrSW4vS01DMVgvNGFIdldZSmVM?=
 =?utf-8?B?UHNyQ3BqNzREL2FJT3lqRzRDb2FGaGUxR0FOK3hWTVRtY2hNalR1NWRXY1g3?=
 =?utf-8?B?RVlRYmFpdVhaMVRyVVBIdmRQVSs0WnVTU043VEUrejNFMHlVYzlJVm1oYXlB?=
 =?utf-8?B?bmZMamJ1TUc0OFQwWU1XcnFFUmExRzhFUFdrblVzbG9jbWtXWjlEV0ExT1VO?=
 =?utf-8?B?NzRRSzJENHR4enRYS2srWSt0THJGY0cyTFgvOGRJNXREVFQ4dzFyR05Jc2Nk?=
 =?utf-8?B?aTEwMkNSOSsxMXREd096VExPRnBWR2FQdXcyQVlGSkRENmpIWC9iUTQ5WCs2?=
 =?utf-8?B?TVZ0M1MxaVFuSDN4ZEhzSjYzQ1VUN1ZRRStnVlBDbWp6M01sbUQxMGQranNR?=
 =?utf-8?B?aUVVQlRaNDZiZ0xYQ2cydmV0SEJzbGdtRXpuUGs4K2VETFZYQ3FjZllqcGwz?=
 =?utf-8?B?VDdORjlwaUFNRlhUai9tTkxYV21PdG8yZ3MydmVDcjlSNjdhbmp2R09IaDNK?=
 =?utf-8?B?dGQvamUvNDRpWG1vdFFKRVVTVUZmSytHQjVWekE5VVJvRXBmSkNKWUY0Umg5?=
 =?utf-8?B?U0N6UEFCL3hhRkRud3IvK2p4QittdlhOMkhxV1owZ2d3Q2FXQnZuaC84OWow?=
 =?utf-8?B?NXlmNlZlZDF4VDRFeGdRd1RKcmtWUlVtdld4V3BZNHJ5VG85MlpDdnF4YVUz?=
 =?utf-8?B?akxGTThKUU5aTTdpclBmWExJOXhLelRYdm1IZEJlTGx4SG5tMFMvWGM3c1Fa?=
 =?utf-8?B?ckJZbGowbHVNTWUvWmNHQUpkTWpPMllWMHpWY054NjFIeGszSmpsdW90c0hJ?=
 =?utf-8?B?a0R3SXl4SWlKRWZqcjZzbWxuT2RPMDkwL0F5b1JqSVljeTU1NXNRSFhvMzVF?=
 =?utf-8?B?eTliUnFhdDFQQlY0TCtjb2VWN1ZGbW4yOTdIYklvZDM5WG1Wem9Zbk5HREMr?=
 =?utf-8?B?aDRLVlZIcDFTTGdZVHRqTXRhRG0wa0ZLRm9NQmxHeGtQemRGM3hxZWJEZVNM?=
 =?utf-8?Q?CBqWHB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajQxakFqTnR3eVl4Wk1nYjh0TTlHbTBRZEZ2b0pMWTV0K3RWMnptR3k1aUtB?=
 =?utf-8?B?VWFuK1NmVDMwV1RvL1JkaGwvTnlOeUFNVU9yWlJ4Z2g3MWRnUVNuNEdrVDdr?=
 =?utf-8?B?MHYvbWY4TUZKZTIwU3gzSzhId1VDb1RUK1ZCT0pZUEpRM2YyTU53VHd3WDJQ?=
 =?utf-8?B?YkZXS2F4VXQ5QnlNVEtQMjMxajY5ZHIvR0hWbGQwalZLSkZNYUp1WkxZdlhr?=
 =?utf-8?B?aS9rd0lzWkZJMkZZV3N4NHdhOXptNkozWHVSeGh4MkVBSUpKVHljVU1oMVBW?=
 =?utf-8?B?WUY0M2VEQ3QwTkt0dEFEWmtSU1MvbXFldEQ5bGlGenBXa3RzYzJGZmppaVJp?=
 =?utf-8?B?aUM3TTlCWnFtLzJ1dWU3bnV3bkJ3aWdGT1JjZ1M0eUZqVU0za0lMd1dlVVFu?=
 =?utf-8?B?WUIxWFQ5Nnh5SWQ4b2NGYTlKQXkvdkxWMVFwMVdRRHFncFAwVHZLSE8wZU5u?=
 =?utf-8?B?YnBlWlFWaXAxSkgvMm9LdVRhMDliZFQ5YTVTL3VMK3BjbDZPaFYwY0wyeXky?=
 =?utf-8?B?UmtSeEdRcHVxSnZtbUdIRnkzQTZzbUNoRE9nRTRLYWlYcG5qd3ZaanY3dU5V?=
 =?utf-8?B?UlpGV0w2bTRUZmJzYS9wY2JLUWQ3TXAxWHc1UHZzK21jeDEzR2pPVVNhZkll?=
 =?utf-8?B?NUFVOEkvZFdlNzJuUmd6ZHpIMzQ0UTNITFZwSkVYMHR2VUxKNG9LdzVicXJO?=
 =?utf-8?B?M25QTk80bWhtdGYxT3pxS0NxZjAwOUxsMFdhS0lZLytzbkdlbGpQWHVUTDQy?=
 =?utf-8?B?Mkc1UVI5MGxGby9PemZKbWkvL2UxN0VTbXM5QmN3dEVJcWxySDl3ZDUrUG9H?=
 =?utf-8?B?aGNUU2k5MkZEL2Z0SEhYNGNlL1VLSjFEek1Rc1F2UzR2ZEVJVUtWNFZ3eGdx?=
 =?utf-8?B?U0xBM2c2TVl3ZlNnTGhUdHBLWFJNNmh3TFErNXBIWnVkVXE4Sk1nSHh0eFpS?=
 =?utf-8?B?ek9EK0pHeG4yRGUvNThTQ2RqSUR1YUJFZkJVQXIvOXJaYWdRWTBXNE1lNHFE?=
 =?utf-8?B?bmJyclBTR3N5M0sydWhYQlBSK0dUVXlDZmZ3Yndub2JTNTFzZUtrS2FqVUhs?=
 =?utf-8?B?K3h2dlB6VE1RZ2NFR2QrWTR5NlIzUkpQTGpDU2lEd05yUDF6di9EUzgyajdh?=
 =?utf-8?B?ZmdWREtZT2l6Q0RFeW4rU0gvSlFaUVBPaC9jQ0NFWXcrVXFnSmtRUEpkRmJZ?=
 =?utf-8?B?eFZWS2RQaVUrc1I2WjdKcGdhbnFJdzdIdmU3NTJ0eFF2ZW9McEh4OHBEY1Jv?=
 =?utf-8?B?Y1NXQ1RWZFQ1RUVCOVVhUHkwU05ydHp5dWRaeXJWOFp2NmRraDVxZE1NRHMx?=
 =?utf-8?B?OHY4S0p0bmRMdmQyREJKOCtZZVQvOTZtL3BPa2FoUUxFSmxpZzYyUFpWV0d3?=
 =?utf-8?B?QjZUNnRhTHM4aXdvdXJpRjhnbVJJL1ptLzBFdU0vT1lYWDh4bk1XMnNreFd6?=
 =?utf-8?B?Z09hb2tuV1NSbStWUU5hSWZ3aDl1VE04cHhxV3czU29rTVFWcnJGTGdNUjNI?=
 =?utf-8?B?TmF0S0VKQUF1U20rRUE3TTRTSTVEcFl1bGpuaVNieGRoRW5yOFZZV2l2c21j?=
 =?utf-8?B?NjNoNlZ4UmNpVzhSQytnQ29xc2p0WlR1RjRYdFhXamNmLzZJN2RoWlVDUEpU?=
 =?utf-8?B?djFEWlNjenIxMmJsZUZPc3o4U2Q4UzZIL3U3VndhWGIxamNWUHREZlpxMUhW?=
 =?utf-8?B?SmorcHlaa1dyYnJvRzRLRVNUUmYzVGJIMUpNbUZVN1NwREtEWG9qcG0zYjg1?=
 =?utf-8?B?WnZEeXhmcXQ3OEp5UUlQeE15OTNGRlF2MFpUcjBZNGxhcWNKWDBsZjVkL3ha?=
 =?utf-8?B?Y0dUa3A4NlJjemJZTlBoc3dxSzVxUlNKS0ZoUW1VQy9pY0U5NHFQUkY4RkF5?=
 =?utf-8?B?ZFdhVEIweFhFU2pEWjdvd0s0TE90RUZrcEZnUW5XZkVhdzR6WEhXODk1Qk1s?=
 =?utf-8?B?cnRjTzEwdlpNbjU0blJMc1ZDeFNoVEhKT3grbU5qMEJ4dUt3dmprYUhnbkxW?=
 =?utf-8?B?VGpVZTN6aTBmRXhHNmFXdlJHazh4RzRhaU9MZXdnMVNranRCNk4zMXpUQUdq?=
 =?utf-8?B?SkdiOUYzeGlTMFVmRm5SU01kWXA2Z28vUmxaMVpSL0p2UjdPK3ZybEdWSjhB?=
 =?utf-8?Q?FJBWjTyEQDfo2KfQ0LUoIO4Fz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63a8d5b-23cf-43fd-7274-08de101ca39a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:07:12.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1o7Gcssz/RRyufN5VLEHHNErNCUxzGJDr6fwNqH768Skyc/8fd4yS1AjbYXnLtSji+yNEJa8VSFDpf2Q2Jn9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Add bus type for parallel ov5640 to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dtb: camera@42 (ovti,ov5642): port:endpoint:hsync-active: False schema does not allow 1

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index 8323be1bfb769fda5c21ea9d4790786654e996a8..b2d9e528fcfec55d5467a11ae4308fc92c1d1d50 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/media/video-interfaces.h>
 
 / {
 	chosen {
@@ -372,6 +373,7 @@ ov5642: camera@42 {
 		port {
 			ov5642_to_ipu1_csi0_mux: endpoint {
 				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
 				bus-width = <8>;
 				hsync-active = <1>;
 				vsync-active = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index cc2a7b61a293a0d8919a74a0ea28ae83390dd68b..d1adbb11c51ae078094dbe475b85038c89d243ac 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/media/video-interfaces.h>
 
 / {
 	chosen {
@@ -299,6 +300,7 @@ rev B board is VGEN5 */
 		port {
 			ov5642_to_ipu1_csi0_mux: endpoint {
 				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
 				bus-width = <8>;
 				hsync-active = <1>;
 				vsync-active = <1>;

-- 
2.34.1


