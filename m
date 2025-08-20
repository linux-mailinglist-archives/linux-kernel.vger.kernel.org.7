Return-Path: <linux-kernel+bounces-778197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942CB2E28B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ECEA00FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4A32C32C;
	Wed, 20 Aug 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4CmMqHd"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485132778C;
	Wed, 20 Aug 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707843; cv=fail; b=kY58M6/OZTv6nWQMCqD5jmD1LZP9WGH7TXS3t+cDX3cY9INDOAeKXdJHfybTDfGVNKFaKNFY5sPli4bystyBiDGBMh8l5eX2izu504NTBySSFmYRCATU24llJPDzEjG8tS0zIj6mcxggR82nVTNbspKhPJFJxAxaZkVAsm5MntU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707843; c=relaxed/simple;
	bh=4zpzh8YvZVs3SPwJDzW3ShZrMlrYcOEy540xZEIFuzM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=D5HzDy6PT2PT0ZAPLLc3ta/j8+5r+WdOfTEWGNsqn9P8VDz1/h8+kU5hmHh04Y1q1t+otNodqe1sQjTi+hIJypWseZYLHiGIpUlEZb9lpqO8NMZug/7H1kOsmCKKhxC0Ou7pjHJQ0xsiNRFMLi/OmXtP0qgDS6ynL+M8PtCdjbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4CmMqHd; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZQ/0pitC1IlIkkDArLVOhgNU4+GbVMS6uY3wG/8gNLi07+7vivvL8/t4g266MEN4HR2bG/x95PFHT1E1JPHCg4OueYwjnkMQfUiydWnfrj8D15k//Anlcf8Qo3xJVg56/gHxVagiwS1XY8byNtASn+kcCfXXQoUq0ALIQWGZm+09ig18N5p9ti804n9C40w/MoPq/9P8EVXIGuDjD2hNggO5pSY+SPsSnKE76AuHYrcq5Cys3scwfVCF1jc8LQG+cwq+Wm4zbMaVxu++6Rh0YpN8vGbziE14VwGEAWqJF6bO4w0uGk+u20XCeT3nqUffWJRlECTKRAhkkyAFbJtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da9LUAyKv0YKznX40faP6GRrAbNpA1rpTFVSqyZmgXU=;
 b=WbuRfUqjHdoJe6b1FvVjIX2h9Gg3ORqzlryZioEuZ/9f01g1CCan7RA3kks2vda2QV00tcs83Xdd3ubo1hlgPo6eFHv8Uxi6U/w365UPAZWGet2pUQcIPZVCXCYFjdF0g5wSz+gsAfWSRTuOzJPfc4B5U9qlXVbCAnN9yJbbPEnBouHOrepcQNT55IujgRmqh2Fynk9CPFoinzy9wvI/N22oHD7zGT5Fo7R6yU4VesE5ByXacMqhcRWLU9ntbFmLXTsgoehj3HVMEUJb7GBR6J5qbpXuSKxrk5kKyNieSESQhMzTXLwG/kJJ7JB2FjrYjdzIk5GM9X4Qajk7Vx0Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da9LUAyKv0YKznX40faP6GRrAbNpA1rpTFVSqyZmgXU=;
 b=M4CmMqHdY0C9cESF/nqL8JNc1kwo+v40+Sum1NYCHbM4poPxgudo5ZRxvWIVIaTwWJmDZx246PpWlo1+ZhXHh59mKf80wuuQoP1J+a8lSruLrT72L14iBgbhiLZlRBscwFb4DKUMj5cOisYjHLKnkBx9ZpFK/ks0ZsCgVGxKXiHolMgeoAM9Re6naJ6ROdGhpgV3LR/ehtao/HL45bbrQhv52pSe08PNw3G8azcY6bSoaNv7q2bL6kXdb6aVSFf594ENboZt9Ei0PfjTJPXWnN1xIR+7LUmjLh7a2H32G+nsrjQeqfnzxMsPnC4AaJoUzbpUx7V6K7O3U3jjfltpYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:13 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/7] ARM: dts: clean up most ls1021a CHECK_DTB warning
Date: Wed, 20 Aug 2025 12:36:50 -0400
Message-Id: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKL5pWgC/32NWw7CIBQFt9LcbzE81D6+3IdpGijQ3kShgQZrG
 vYudgF+ziRnzg7RBDQRumqHYBJG9K4AP1UwztJNhqAuDJzyK21YQ56RUc7koNc4vGVw6CZirW2
 FULoRWkJZLsFY3I7qoy88Y1x9+Bwnif3s/15ihJJa1q26qYukht/dtpxH/4I+5/wFP9UkJrQAA
 AA=
X-Change-ID: 20250818-ls1021a_dts_warning-fff933bd83da
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1729;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4zpzh8YvZVs3SPwJDzW3ShZrMlrYcOEy540xZEIFuzM=;
 b=LKhTxO1Qtzf96ROPfTDOnepQVWnE/4O0GmQo8Hwnvevs/vqoJclkIwQM3bOJZVL7nCzsorhP0
 DrusjMR6XmtAbk1r/7WKeYz0/u15LfhXCb1fU7LqztCsD0hOdV4NfMq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: b1de6c54-b567-44ea-9233-08dde007d0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZIUVNJbTcvVDN2WkZOd1dzKzVnM3hIMUg0bzI0NUU3eDRhdHRodEUxaVpW?=
 =?utf-8?B?V0xHS01mZitDd0o2M3lyVXlZaXg1M2kzQUFoMy9vaS9zQmpoUjRPOVJXZVBV?=
 =?utf-8?B?aE5HeGE4M3NjenFNa0phanQwc1F2eWRwVWxCYktZV3E2OWhkRGs0ZFE0bm9v?=
 =?utf-8?B?Z1JHWW1SV3VtczZIZjk1RjVpQXFRWUpCRFJmY29QYVQ0ZE5mV2J2QklrZlZZ?=
 =?utf-8?B?TkFRZm5IZ1JoVHlERUZDd295VG1zdzdYYnpCeEJwelYxbzJmT1dCakZsT2hC?=
 =?utf-8?B?L3pvd013RmYrRTFSR1RmMERoSnlBbzY5K1ZpSldpT1U4NHdQSnprVVpTWVM2?=
 =?utf-8?B?UXhoT3JZZzhGOU1paWlDTkRxdm8xQk9tcm8xTE9xeWJzWXdnVHRhN2t0U0p2?=
 =?utf-8?B?M1lEQWJwamhXcjIvajNrL1krMkdYT3NvWHlxRWZZTldPZmJKQzNKRVY4OXpq?=
 =?utf-8?B?eHprc3ljMDR4cndCY2VCUllweFdCTEZRVGJEMno2b2IwSkI5OFc3dEU4OTNy?=
 =?utf-8?B?dHJoclJSTjV0dldST1Y5NkNES2xrQWdwcG1qUUtpMDBNdWFWMEY0bmw1S3ZL?=
 =?utf-8?B?RE95VGptaXlsY3FYU2p0OHJQUU5Sc09nalZCOUJjS3I5Y0lSQTlHMHFJUkJs?=
 =?utf-8?B?ZVFyYXRrS3hBd252WmNZVUttK1YvTld6dzgwQno1VHpJTHg5YzdNRk9EeW45?=
 =?utf-8?B?ZDJSL3hiTjlhNy9uRmQ5Mkl3NExYR0N5eUtEZ1pkN0JLUnBwcXJ1NktjWVds?=
 =?utf-8?B?OFo4YkFHRFdQaHhCMVZRZ3RYeklMcEY4anJoSXBMK2dRYlJlQ015d2VWL1hF?=
 =?utf-8?B?QmUzaDlMb05OTXRWSE9wdk12eEw4bnpiNGV4NFlLUm1iaUxvWUtKcU9mTUpS?=
 =?utf-8?B?VHlwUkhOSk1ycTQ5dzRmRWdtVHVVOFgzQnNxaGY2WXpKNDJsME5wY1Fva1oz?=
 =?utf-8?B?QzdaZ3pQM0xCcHl2aTF4akc3Zm1FQXZPNnFVNUNtaVZwdEQyQTQ0M1RDaGxz?=
 =?utf-8?B?R01uVkNSa25sNm1QY21mQVk1T0cyRExmd1RVSWdrZm5YUHBHOGlvVFBZZ25U?=
 =?utf-8?B?WVhLRDRscWRPY3EyWkI0a3NDanpYcHJ0NEJqUWh1L29OM0xiQnNRdVlmTVky?=
 =?utf-8?B?YkdHMGlOVEMrdU1xSm9Mb1ZPbjVRMDZwOXluVUNhTnBabE05Y2RXR0lsMkxZ?=
 =?utf-8?B?cVBFRkhZWnUvUGlCbjFWd1pPKzJtWVBJR0Fkc2JBeXA3VjkveUd4alBwQXY0?=
 =?utf-8?B?cUdiOTNTbTNlcFJtc2RFZzRUWU51NGRtR2grNDhJa2dTbXNORmFTWVJxMEhO?=
 =?utf-8?B?c2NjSkRLdldaekdKN1FTa3pvTmZndk1NdlhzSzNPWGZjSWgzOEVVY0hIUUtT?=
 =?utf-8?B?Q1IrOXQrVWVFcGxEcFBkNHA0OEVxaE5tcFcySnB3YkoyeW81emh1Tk9ybkx6?=
 =?utf-8?B?UnEwNUJKZ0J2aUlaMkVZRTNyMnZGOEttSytDQy9xNmR4Nkd6L1JCbnVqcFF1?=
 =?utf-8?B?RTRXS2grS1J6T3VzQU1IcjhybzdlZm5EbDYrN0x2cFFDanpsRHMxc25qUkZY?=
 =?utf-8?B?d21hM01pUmhpTks4R29PWmpESFN4cDlJbVdQUWkyakoxUDhYY3JpNHpxcXhC?=
 =?utf-8?B?am5BZCtDUWNaWlQrdENUeTV0K1NWZ0U5Tzk4OUtuWkFISnVxYms0Mi96dDZC?=
 =?utf-8?B?VnlVUzlDU3NiYnNDaGlSN1ZSVVVzOVNuZzdaMVd2T2NZc0FMUnhtMDNBVi8y?=
 =?utf-8?B?RWdob2ZTU1dzRlIxa2lrTHI5S0NvajBycUpYc0RlNngxRlMvd05yd2xFOUpU?=
 =?utf-8?B?dnhRU1hqWVdFYTNyWklTd3ZhOE9IRHJyMDdjTkp5MVZ2TjMya3FoR1huYjVs?=
 =?utf-8?B?N1dyQWZiU05TL2tXUEdVUndkb2dqYUFEdFRtbTM4bFpyMHJOWm42QVd2QWdy?=
 =?utf-8?B?UUtleFdIYm5RR2Y4eXBLUnB1S1BDRUc2eGRRRi9iNFR1M2xQRFF3R1lsaHRy?=
 =?utf-8?Q?eraKmRxYT+W6GeS665hW7l2dHq0TRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJld3Y5cmd0blVOdDRLbllPZHh3aDQ0NytOaSttNGJMR0NRS2VyUEJkOEZl?=
 =?utf-8?B?WkZBbWJnbVIrK0xlVzM3TWpieGJxMDV4OEZHWkNZdXp2WDlPN2ZkVThwWjVZ?=
 =?utf-8?B?SU1OSFdFaTREa1cveENOZ25DWlJ3bEcxcWs5MUVwMERaZFJoYjA0L0pNUXpV?=
 =?utf-8?B?OEcwT2V0SUQrakNIQjNJZDhjcUlxRkt4OHYrYjhiM2tnKzNpdENvaEtYblpi?=
 =?utf-8?B?VmF2blU2NDl5T1lraldRMG9PbnBxcFJCWEV1UVp6R01yNHFCWHdiaDhqanB4?=
 =?utf-8?B?a056bHJTQzVWVExMemgwSThzdHRZUkxTazF0ZVlLRXBuN0lPdjlvTk01RUpL?=
 =?utf-8?B?NEUzeStiSkpOeUJHaHJDNlcraTN0VU05L3dPQkdOMW1wMlBxdzVOT0sxMGFj?=
 =?utf-8?B?ZlBTUlNFaVYza3NmL256enZZZnV1MmwzMWVvcGNIYmNoSHd0clFwemNoeE11?=
 =?utf-8?B?Q203Q3RrQ2lkaHRoQ1B0bmUvYkllUExacUJWeHcyRU1Na2tsRHo2OVhpVzI5?=
 =?utf-8?B?enR5b3FLMGplOURFVHNOTENuUU1CYmk3YTZjMHZBakJneSt0OHA5enRYNHJI?=
 =?utf-8?B?YVBkUFNVN1FvMzNHOVZ2ZnBydHhnVSs2Qm41UjZQZDAwVXBTV3FXQXArUjlh?=
 =?utf-8?B?TXZ2L2dWNGFsVVptdlFLbnkvQjdMNi9JbXhmaVkxSHZQRHdBVnJxTGd2NHpv?=
 =?utf-8?B?QUIxbzV1MlVXbENBMUV5VnVBOCt6RGFQTTltMGhPVnphUlBvVWg5NmlDOEFY?=
 =?utf-8?B?c0pzYmJjTlZJdG1rc3NVREpuSGxXWlRXamIyczV6WFlDbkpqbC94MWhVNUJY?=
 =?utf-8?B?MncrVSt0alZwZXVuNDZGcjJrdndEdjFkbWt4SzlCMWtIcm1FM3cvTTJvV25Y?=
 =?utf-8?B?MGVtRDlJcHoyeHpyK0pDZE90bG9yK091UjBpQU92d3RDTHNxT0lWMERRNldh?=
 =?utf-8?B?Z0ZjTTV0c1E3aGFsazBxYmtVbkg3d0VIeTNsOTFsOXZLWllhOG1qYjhQNTNP?=
 =?utf-8?B?Z3ZyTjBUTC95dmI2bkRwMCszN1JybEhEMzNVNTJWTG55SlpVZTY5SU0vVlA4?=
 =?utf-8?B?cHBIUng3NVk3cjlndi9TVWh4ZUtDVkhQN05KaFhUSlFvSmVZY2tJZWNrazVL?=
 =?utf-8?B?L2JDRUxqb01uVUUrb1FObWdON2J4VEpQc1JxL0djbERibCtvWnlHNGxkR0l4?=
 =?utf-8?B?eHNlWnVTSktzdkdlTGtieElxb0JOV0JYTzNORGlIWE9OaXBkd0VRd2Z2RGJi?=
 =?utf-8?B?TXN5UDJUTXRxcUlUREFBRlhTSXUxcERHTGN1Y3VWMzFqRlRjVWptaVBaellx?=
 =?utf-8?B?S2p2Y2hDc252U1paYXdIZ1pxZWt3ejBwQkpiNHJZUCt5dTdVcTM0T3FiaEFE?=
 =?utf-8?B?MEw0Z2hrLzJCM0ptNWN2QURSOThnbnhCb0phNGYrS0xlYk4vSzA3YmJydllr?=
 =?utf-8?B?NDdLSlBTQzIxUE9DQzdpTlVSVGV0TlBPVGZTMEQ2SjI0aTdaUEZrUzIrSDRr?=
 =?utf-8?B?Sk1JWXdtZE96TUgzVFBFcFptUEtjSGZ5OE5WSzZNOGkzK3cyTVNWTGRMZFZ4?=
 =?utf-8?B?YUFMRzh5MGJEUHVmTWwrbU44WVpabFhTV2hLZW5KUjk4YTh1OHhpNThYK3Rv?=
 =?utf-8?B?SkJsbElWNjkwdnA5Njl1ZlhabnlCK2FUam9sRnNHdUMyMjkxRFJSYmtqUkho?=
 =?utf-8?B?YURJSEdGQURENWd2SHgwTjlEYWI2T01qc1hlTUtKTjA3clJkQm1jdUYvUWwy?=
 =?utf-8?B?Tmh2aHR5V2Z6SUg3YjRwUUVaSDY5OFFrQzNCbFh2cXRVS1Fhc2E4QVpXT3BC?=
 =?utf-8?B?alc0OU9GUHZnOUhZOXA5bUdtaithYm91UlIvb1JCNGp2RnZ5aHJRZDRta0hE?=
 =?utf-8?B?MURQSWtYVTEwSkFtZ0lZRndiTkxoU21qNW5hMmg0SGl6MEZtTGVzZWJIN3FV?=
 =?utf-8?B?WW4vaitrZXN3YTNvRFQ3YXE5S1ROTldBL2FTL2s4SDdJNzdEallod3NPMllQ?=
 =?utf-8?B?TVcweUlzQVJXNnA2bi82TXpNQndpNjNoWUtNNXV2a2tOeks0ZGVkbEVKem1C?=
 =?utf-8?B?RkUzakFvbnUvQlFZMnNiOEFMNnp3NFZueXlDTCtzaktoZ0R0aGRSeTIxeU9E?=
 =?utf-8?Q?PkzQKJxv2bbIk9+9hcHTzteZL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1de6c54-b567-44ea-9233-08dde007d0dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:13.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUuqj0unUcSMFAPDSLEJhcMME55R72k0MhIP5Iur3clxN/8v3urEFnYve0UI15ERU7oc+1FTbtvSGokTl/x3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

clean up most ls1021a CHECK_DTB warning.

Old uboot check esdhc@1560000. The new uboot already switch to check both
esdhc@1560000 and mmc@1560000. So we can rename it now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- squash rename to flash patches
- remove duplicate patches already post in
https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexander.stein@ew.tq-group.com/
- Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com

---
Frank Li (7):
      ARM: dts: ls1021a: Rename node name nor to flash
      ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
      ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
      ARM: dts: ls1021a: Rename node name power-controler to wakeup-controller
      ARM: dts: ls1021a: remove big-endian for mmc modes
      ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1
      ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech: Remove fallback compatible string edt,edt-ft5x06

 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts                          | 8 ++++----
 .../dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso  | 2 +-
 .../dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso  | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts                          | 2 --
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts                          | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi                             | 6 ++----
 6 files changed, 9 insertions(+), 13 deletions(-)
---
base-commit: 3ede6e44fad31f1c80dd01188683f0caa0f19247
change-id: 20250818-ls1021a_dts_warning-fff933bd83da

Best regards,
--
Frank Li <Frank.Li@nxp.com>


