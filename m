Return-Path: <linux-kernel+bounces-864215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791EBFA319
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDE504E3CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538602ECD0F;
	Wed, 22 Oct 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="uJ7Qp5Oj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020099.outbound.protection.outlook.com [52.101.69.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDA2D8DA8;
	Wed, 22 Oct 2025 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113953; cv=fail; b=Wl7EBykD7QTpYuP76ovV684GRmFJw+ZlV4HxhnfC59MN94PZ1vrkFOurfwItkfvLmfSnVGpltzj2WV7Y7AYW+JW/lRjYUMzO79hD7VIz1EGeDDBJPcyicWVtsS2IwHGnPr26EDj1aWYze+v1KrF5yR5NNx9NwXpRLfxxq6iT7EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113953; c=relaxed/simple;
	bh=g273XvRwMFTMiQkCR+ra8EE3Xhwqr8fjDxJ+4NXbLiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXi9Nb7TGxWOk6aNBoElN04vziQiZruWkiEvjeZLrXxxIBxS329kq9YROEvQlbVhOAA94YK3h8+bTCQP2OwVeqdb8xLtD7a1d1LuZPjnL5/EaVfkK1lKtGCK/ec3te7ROlGioua9+Hw/EtlUfViFX5a5EXUz8ThPN6HWALyx5d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=uJ7Qp5Oj; arc=fail smtp.client-ip=52.101.69.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ74s9gFyOHuNIkKLTvWykvvcJDrnfruz5YF9imZ3JZLJHZSXApESF3nVZqNTYJg7wuFaB2TdFw+tG5mhuBDeqcoHhSYuUhADrYF0VG+TYsU3124GYMDrgGLPBfUxVmZdorIJ8eg7POUx26aa67hhKiVVs6aKIBDhyoEQZKo84X4qmEc0Pqa0XzZKg+mihr66VhzjRMER+9rHVS+psFQnisyqZS7GbSCMaUhaCkGALGwzgZeP9DQxssWAKsGlYrO/6anlXDo4+Q1gkLMmfvlGQyvgQhBiirT/uOo/SArnHGcq57wxKxkvLuGKOB0PJeX1GQlkWcGVMlOxp2Y2+HisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g273XvRwMFTMiQkCR+ra8EE3Xhwqr8fjDxJ+4NXbLiQ=;
 b=wwuQXJfHpoL3c7es8WMlx1qCwp3DS/xUlP3dinf4KJVk7vV4CnNY++bskgJwt+Yqrpka74EK+8HRIrPagbg+qCk/bIlYafAKBqYPj3HKoD4f16FxeulSfK4Ka7w0ntulhHlFSw4RZcrmyAkEjCfGQIRa+co48JRlSUR3Dj6Om0OY4XfKVis9fTzvEBJl9D/W32q1I450GuD6FjAyeCK9XluMqNvN1vrsS762NkpvcHdZogh3o6UvzqENWz6SHlH8fZmmuvGA5UnYKuuXdBaSPd51TV0U/zL5qirvmXYSfdNJaBcQKrz5q7mY7CzH/lKukwoHYnSRuBj05MmR30SIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g273XvRwMFTMiQkCR+ra8EE3Xhwqr8fjDxJ+4NXbLiQ=;
 b=uJ7Qp5Oj1iWh7+URXJaJItszTQK51zJpqQ4CbLiNnzQTJtRd7uQqfDZEY8KSDgSFeFnM/US/CQknZcVQzaWJZRovPYJlNFpGzrgH/qgjGqIx7rdLHJ6YR9pxy40zzWEwZT81M3y/Eak92oiIc+rPGWlRV/zh76SXk6d3lWyOFYjArpPXUVbCADuCtwuMS+ad+z6YQn5dWvZ/2RuNnlUTYhMwF30VnFpKbWHXunSAy7X2YGjo3vjdzW5C2q1J8qyDjzjoCpNGtM8bNCAoBWOqtGogDNrH8Ye5vcl3dxmB+lIp+U++n+vDfY605B4Q9QNUQYAp6kmskwSy01aLDL21iA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GV4P195MB3048.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:18:53 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:18:52 +0000
From: Yannic Moog <y.moog@phytec.de>
To: "Frank.li@nxp.com" <Frank.li@nxp.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-phycore-som: add spi-nor supply
 vcc
Thread-Topic: [PATCH 2/4] arm64: dts: imx8mp-phycore-som: add spi-nor supply
 vcc
Thread-Index: AQHcQcMQOuwPfsLsJE6PDd+SFN6y3rTLKyIAgAKIzgA=
Date: Wed, 22 Oct 2025 06:18:52 +0000
Message-ID: <d935b1243b1256293b5a0b31069983ad56555407.camel@phytec.de>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
	 <20251020-imx8mp-dts-additions-v1-2-ea9ac5652b8b@phytec.de>
	 <aPZXCJZQaNnrxC7p@lizhi-Precision-Tower-5810>
In-Reply-To: <aPZXCJZQaNnrxC7p@lizhi-Precision-Tower-5810>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GV4P195MB3048:EE_
x-ms-office365-filtering-correlation-id: e237e4c3-135f-4e73-0479-08de1132df46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTkwUmdseFhyNnNYUWpmc3FXWlRMU3RIb3JCbjhpTVhkYjZIQVRqOFFta25R?=
 =?utf-8?B?NWpDUVM5dTg2Y1ZzSlV6cGVBMFhCMzZMVDZuL0wrM210Rm51a2VwQkVJeWdM?=
 =?utf-8?B?d2dMRnZZTko4OXk5ZjVjQVRTT2JEOExqVFJBNkxKejRyaXBlTDVFUnhwN2V0?=
 =?utf-8?B?UmU4VS8veGpWSlNUUlF3SmwyQlQ5VW9YbGVsRm9BV2VjS1ZrcTRVaHprTEts?=
 =?utf-8?B?NW02SmdGbWJLazR6Zm1Gb2NqbTVTeTVVd0pyenExcEozeEZLOXF2SWg4bGJV?=
 =?utf-8?B?V2N4NVBtSWpqWDBZSmRxR0RBM25QVjVrOTBNb3hrWHh1VjJ6S2N5U3R1RzYx?=
 =?utf-8?B?OVI4M3BkY0NUb2xBMVVrNDVoOVdCcC81SUNIZHc5NlJUQkJhdDg3aTd3anVY?=
 =?utf-8?B?VVo4WVA5VE9RV21rQ3l4YWUvcVhXVjlyRVZjR1AxbS8wWFMxK3B4UFZtRlNX?=
 =?utf-8?B?enZONStyM2lBeHNNTlliWFcvSHNFYjk5dUhOd2MyN3hraTJrdEp1Y3dzYksw?=
 =?utf-8?B?MFFnN2lRNDFpbUZoOGdLRENxWW1PODRFV2FJeUZabHpoZXVMaEErQWRQcjla?=
 =?utf-8?B?Sm1TcVN4cmJPYzVvWXhaMmVEckxIam9McnRqRUt6amtRMHNmcUdWWDY5MEJy?=
 =?utf-8?B?cHl0aXBGMENjRG5uQjVuclM0UFZWTUJsZnE2WWNnN2NMMkZGWUNPc2JRbW1i?=
 =?utf-8?B?WGZIWWkrRTBzRmJ2S214SkQvdjlpWXlzdWhMWGVHTmFhb2hmWTY0aW15dFo1?=
 =?utf-8?B?a0xTSUwvOXBxOVE0d2RyaDZESjFscjV4eThlSFc5eDlSNFdMNkpYajF0NmFn?=
 =?utf-8?B?UDNNWTlYMHd0c3Z4RkhjZWV2K01rbGI0M0UvS0tBcStPY21qVFliZERncHIv?=
 =?utf-8?B?MmNmbTNlUXgrUFdFSEpEZjNwQit6a0RPK3h5ejYvMjRhTkxrT21nTkxmUExs?=
 =?utf-8?B?MXpoM0dBdmR3cFh3dXdVNHN6UnRIWlBXWXBidGhjekt3REVsejYxeUJpSU50?=
 =?utf-8?B?bVdKL0VvZUxSeGlmZU1SRzZwMWQvdWJwakRDVHEydjdrZzZmV3QzSHRXaEJm?=
 =?utf-8?B?UGQ5ZDZiQVlaWGpnMmpxV3V1ZzBYdzR6NndNYmIwcU9ZTWVCcVlSeGdnd0pq?=
 =?utf-8?B?UTNhUW9YcFhCdmRWYWdDYzJzWkpSWjNFdGdkcGI0MzNqRHR3MUJoQ3dCdEVn?=
 =?utf-8?B?blJtK0xISTUrMHRqd2RDQ1ZjU2lzM09OSUJEQitSc2pvRng5M0s1dFVIN3Nl?=
 =?utf-8?B?eHdnNTAxdTJWYUdrVWpQcVpWYVJUSFd4OFd4Y2tsVExTZmp0SCtPelU5WVZP?=
 =?utf-8?B?MUg5TnBlZ1NjaXJ6RWVJR3A4SCsrQTVmeHlvUXZsWkRYLy93VERlcXZtSUZw?=
 =?utf-8?B?RFNXcnB3bmFmTFV3STJuYkEvZC83ejdVWjUvWDEvL2taMy9MWVJ0Zyt2bjBY?=
 =?utf-8?B?bWptUmx6b1NxUG55UlFoNlQwTm5vV1ZNcGdWQzhnN1o5Y09yWUM2NVB4cUZw?=
 =?utf-8?B?RkEvRk1GeFMxN0xGNzN0Tk5RLzdBYUFneFlqQjdGMXBaNS9jcnJUQnBGNGd3?=
 =?utf-8?B?cm9Qc09wWlVyeTMwYUNqL2xqK3YwWlhGUkMxTHdtNW9NL2wzeXM4SUZnS0p2?=
 =?utf-8?B?MEIrc29HKzVEaDl3ZkNFYVIrVWE1NjJuc2FyYXFVNlRDaC9zdndFU1kvcGlw?=
 =?utf-8?B?Z3ByUEtIR0dua0JpNW8yTnM1NkxvdjRqVVc3MVhFRzhXSThLaDdoVlhCa2xw?=
 =?utf-8?B?dHBVU1FWcHhXakREMFZtNGlMd1JyK25IWURkeWNCR0o1UlppRFdaQ2VId0gw?=
 =?utf-8?B?TTFQaVZMNjBrTzlrbk04dlllQUVQYVFNakRzNXd5MUh3bnNLZVVEcE9GR0dX?=
 =?utf-8?B?Q0V2ZkNNd2pVM3EyOFZwaWVIY0ZaYjlidG5QMVpUaHVFeUFCdngzdno0R2hL?=
 =?utf-8?B?bVpCNWVLajlDR04vS2w4YThSaWdJRmZ3bm03RTNOcE5yVGdCWUlIb0RTei9K?=
 =?utf-8?B?UitlYkF2cG9Nd3c3UW9sdFdTU2lCN1BmakxvREc5aDFHUTBCZGNPTkYzSXdx?=
 =?utf-8?Q?y8ypTi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REVBckV0VDczTEgvT2xOYVV5L01sRkoyVHpUbW9hemdvMkFSZkFJa0xhOHdL?=
 =?utf-8?B?cjEybzJOL0Q5Mms1SEFEeFFXaDA3VDlYN0U1VGc1UVptN1FRRVUzb0UwaDFj?=
 =?utf-8?B?d0x2ZGFMTitkQXpjVHorRWY0bzc0OXYwaDNZYzdwMkVIeUV4cndMZFcyUm1X?=
 =?utf-8?B?dlFsRHVVbm5QL2FvZXQwWHdmWFV0UUQ3QUpjbm0xV1gybjV3NmlDcTM3MkFz?=
 =?utf-8?B?T3VISzBDcjYvL1kyeVZ3ZlJBeWFXWVJ3dEhRWk5jYm1ZTXJ0VFZWZ1U5QUJX?=
 =?utf-8?B?cWpzdGdOeG9LUFR2N3ZkQWYwUmJMMERrUnhVT1RHd3JtSzhiekd3dE1mSnZn?=
 =?utf-8?B?S0tZZGp1blJpdjlXZUZFb3pERnhETXBxRWdDbW5pYURlYnZ4aU5xU21xaW4y?=
 =?utf-8?B?T2hVdUt3b3ZBekt4Y0dnM0JQNG16bFJibFVwcUl6Y3RGa2E2MmtKVms3WENO?=
 =?utf-8?B?VExlbTJXaFNjZG9uOTZ6TnhMZmw4cFlqQzhaN25qNHhXVVhvSWhHT1k2bkZV?=
 =?utf-8?B?cmRNcGpRMDVKN0NsbkptQ2IxaEp3cTVUQUo2V1poQkJrUzlrK2IrMWhxc2VF?=
 =?utf-8?B?dm05WFRIS1NUWUhNcmNkb0hNcXpES21OMFUwSFF6alNEaHpLQWtxUDdTemgz?=
 =?utf-8?B?OEd2K2pkODd0MFh3MzA3WWhWNXE0ZDhXdkZVSWM4cHY5Z2FpWExGTjNNRkxT?=
 =?utf-8?B?RDNEajhqVkgrcUNGMWVrTXpDYUM0eklOdm9FRi82OW9RdWgwR0ZldGtkaERk?=
 =?utf-8?B?NEhXNEM1N2d6R3pGNS9kYUpCcmU3Lyt6V1ViSThlRDl2ZVZYRzF6aVhjL3B2?=
 =?utf-8?B?dFA1QTZiWU1iNWxCMDl0TVRuREZ3bXBJSm5sNkV4L01FdTlldGJKdkk4b3du?=
 =?utf-8?B?Y2VJUmREK2xJQ0hmYTJTY2pvS0k2cHl2c25LbTBHQ2wzY2pkZkFsR3dzekFL?=
 =?utf-8?B?dXYya2dRdzN4a3VIK252Mmt5YURzd1lDVFpBcTlpWlNMM240S3A4K09WNXJ6?=
 =?utf-8?B?Y0h5TnJhNUhrU2l2M2RzZHU4K1FsK2lQNXdrRmJkaGhRaDIrRk1mbDZvby9o?=
 =?utf-8?B?Z2k0RTRkcU9heWducC9pTHB6V050RlljY2h6ZU9obXdscXk1UlViOUFlckxS?=
 =?utf-8?B?bDBSU2trS2xVNytIYjlOL1pTYnlkVUFpZzdZWGhJamRQMU5TeXhTK3ludW5a?=
 =?utf-8?B?Z3J1L0xTV1p1YzJDeWYzS3UwZ3VCZkhYejlIQUpjdHRmZUhQTVlWVGkzK01u?=
 =?utf-8?B?UkczYXk3aXBISXhGYm1leHN5dkcyWkpoZWhOQy9sRVUrMWRQdkRRM2lQNnVa?=
 =?utf-8?B?cktCQ1BpeEV5UnRjeWNYbXFhQWx4OVQwVmhJMFllUmdjWmpyMk9qU2pVK0cz?=
 =?utf-8?B?TDRJMmdZQVpUdURmcmR3VTRSejRMWUtwcjNJNVJJc2Y2MVkwUG14V1J2bzRG?=
 =?utf-8?B?Q2VwNlNGYjg5a1h0VkNpR2Y5dkdVMHA0UjJPeE93VC9ITGFTWDRsL21MZUpC?=
 =?utf-8?B?SFgyUktZNkk0V3VUR0JUMGh1ZlhJTVR4RytwaWFldGJEZUF6NDRkN3ZjNDla?=
 =?utf-8?B?TkdUQ0g3MG5WNGZqd3grbXZ5c1dwT08rVmluNEQvUU50Rnh1RHVyazNWQVQ5?=
 =?utf-8?B?NEtOZDMwNS9qVnNvM21sdFY2ZytaN2h6QmRXN0UzSFlCTkZWbXBTSkEyVzg5?=
 =?utf-8?B?OXRoaTdSaHp2QW1vdlJwZmxnYWNGZVVWK3NhbXVMTlNEb2ZMZTU5d1dUTWZW?=
 =?utf-8?B?KzNjTFlKYzd2U21DN3laS1kxMC81dEFINXJXMzFSTThhWXZLKzh3dlQ2QWNl?=
 =?utf-8?B?NjJ1QXZmRDVBb2wzTE9QanlyQTFVMUZ4cktoSjNtNEgwVWpaTnZDZVU1aXd1?=
 =?utf-8?B?RUhnVW1sNnFycnJKdmR1MVJES0piMlNPZTEwUkV0R2MwTCsySm1HQ2VKRjhV?=
 =?utf-8?B?QUVuaG5nbndvcmFYMkhnQmtsWWs1MkRNWU55S2JWNnJKekhmRllHeFFEeG1l?=
 =?utf-8?B?cFJHMll3OUpQRk9kMzQya2dvRmd4cmREL2dmZWsvVWNMNkhheFBvNk1Kamdi?=
 =?utf-8?B?N1R6aWJ3STlQRlpIU09oRUMya09FNDFFRWE5c3RoODloeGJ3ak1TRUR4YTlH?=
 =?utf-8?B?dzFISDhHWmdTWDJyOGJyaTVVaXpLQzZRQllEeFp5YXR0ZjZqNHBXbkVjN0x4?=
 =?utf-8?Q?ZstvcDTOUbfeijETBwmG9hU4wH8BLzY5YVAUYNpwFsxH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D5D18CFF282074293F276C6797E5314@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e237e4c3-135f-4e73-0479-08de1132df46
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:18:52.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHiPWFLMAr9IXrrSpGEGM4x/AD+/4cOca5cQXhWubRRRxu93OuI4OoMjYUFjwJLqv6VQTTaLFjoZBTr8ctJeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB3048

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDExOjM2IC0wNDAwLCBGcmFuayBMaSB3cm90ZToNCj4gT24g
TW9uLCBPY3QgMjAsIDIwMjUgYXQgMDM6MTE6MjNQTSArMDIwMCwgWWFubmljIE1vb2cgd3JvdGU6
DQo+ID4gVGhlIHNwaSBmbGFzaCBvbiB0aGUgU29NIGlzIG1pc3NpbmcgaXRzIHZjYyBzdXBwbHkg
ZGVmaW5pdGlvbi4gQWRkDQo+ID4gbWlzc2luZyByZWd1bGF0b3Igd2hpY2ggc3VwcGxpZXMgdGhl
IGZsYXNoIHdpdGggMS44Vi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8
eS5tb29nQHBoeXRlYy5kZT4NCj4gPiAtLS0NCj4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNpIHwgMTAgKysrKysrKysrKw0KPiA+IMKgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWNvcmUtc29tLmR0c2kNCj4gPiBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNpDQo+
ID4gaW5kZXggODg4MzFjMGZiYjdiZTNkYjE4OTEwMzg1ZTRlMTU2OTFiMWM3NGVmMi4uZDM3MGUy
YTNhMDBjNWUzZTkxYTYwNmFjMGZiZWQzMGNmNWU2ZjliMiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1zb20uZHRzaQ0KPiA+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNp
DQo+ID4gQEAgLTI4LDYgKzI4LDE1IEBAIHJlZ192ZGRfaW86IHJlZ3VsYXRvci12ZGQtaW8gew0K
PiA+IMKgCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiDCoAkJcmVn
dWxhdG9yLW5hbWUgPSAiVkREX0lPIjsNCj4gPiDCoAl9Ow0KPiA+ICsNCj4gPiArCXJlZ192ZGRf
MXY4OiByZWd1bGF0b3ItdmRkLTF2OCB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3It
Zml4ZWQiOw0KPiA+ICsJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gKwkJcmVndWxhdG9yLWJv
b3Qtb247DQo+IA0KPiBOZWVkbid0IHJlZ3VsYXRvci1hbHdheXMtb24gYW5kIHJlZ3VsYXRvci1i
b290LW9uIGJlY2F1c2UgaXQgaXMgcmVmZXJlZA0KPiBieSBmbGFzaEAwLg0KDQpJIGFkZGVkIHRo
ZXNlIHByb3BlcnRpZXMgdG8gbWFrZSBpdCBjbGVhciBmb3IgdGhlIHJlYWRlciB0aGF0IHRoaXMg
cmVndWxhdG9yIGlzIG5vdCBTb2Z0d2FyZQ0KY29udHJvbGxlZCBhbmQgc2hvdWxkIG5vdCBiZSBk
aXNhYmxlZC4gSW1vIHRoaXMgaXMgcGFydCBvZiBoYXJkd2FyZSBkZXNjcmlwdGlvbi4NClNob3Vs
ZCBJIHJlbW92ZSB0aGUgcHJvcGVydGllcz8NCg0KWWFubmljDQoNCj4gDQo+IEZyYW5rDQo+IA0K
PiA+ICsJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiA+ICsJCXJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiA+ICsJCXJlZ3VsYXRvci1uYW1lID0g
IlZERF8xVjgiOw0KPiA+ICsJfTsNCj4gPiDCoH07DQo+ID4gDQo+ID4gwqAmQTUzXzAgew0KPiA+
IEBAIC04Myw2ICs5Miw3IEBAIHNvbV9mbGFzaDogZmxhc2hAMCB7DQo+ID4gwqAJCXNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDgwMDAwMDAwPjsNCj4gPiDCoAkJc3BpLXJ4LWJ1cy13aWR0aCA9IDw0PjsN
Cj4gPiDCoAkJc3BpLXR4LWJ1cy13aWR0aCA9IDwxPjsNCj4gPiArCQl2Y2Mtc3VwcGx5ID0gPCZy
ZWdfdmRkXzF2OD47DQo+ID4gwqAJfTsNCj4gPiDCoH07DQo+ID4gDQo+ID4gDQo+ID4gLS0NCj4g
PiAyLjUxLjANCj4gPiANCg==

