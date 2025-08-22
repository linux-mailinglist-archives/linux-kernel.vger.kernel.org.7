Return-Path: <linux-kernel+bounces-782220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E1B31CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3DA1BA18D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB13126DD;
	Fri, 22 Aug 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ae7FAZsr"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77459305E0D;
	Fri, 22 Aug 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874217; cv=fail; b=Z7aRNWiHdopP7Zm5eaYAlFm0Djrg0HqQgG6yF5RRbsukOZP+S2cG98f++PtqQYfDFj1AIT/8ieNQVfcHIu9SNhLeKR2zADN3CPZ2vUvw4hqT3Yb/sgHJoLAQyYRCAjOy+msw7KlGaJY/NgT5HDxC6d++PBJSyh4RBoSBC5QrdsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874217; c=relaxed/simple;
	bh=Bo9JfeierndIz/H45PHmW8cMOt342671rkqJWYezT04=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JLF+m/7cO82WCt3UkuUzEal1eZLdRgoGglE91kN7ATIiSkzviFcbZ9XfgaXeY1bsGkAU4Peu15YIFYT+Q6R/a58j3QiiF33FiYlKHr3Rrg1bSQ5eWqQrcZLjpUi3hjwbcP3hUij7pkOQLscd1aA8Kh8brEZLe64VMMW6OUx2oaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ae7FAZsr; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDvTtDHFuE2T3YpbRCj2+HW9RE/2vd41ME9tek1NiDd4o44lNmKSnWHmebOw0o1+fPGYGA2Ssj9qzryJ8Ww2PC+L87iZjvztgtCC6jwLFeil6MKoqX4Hdl+5HXz3HL8JxonOXEX7Kmz3Ih0tAqAfQ+hEHc2AQbNPDaNzR/wi5Hnq0UCFYp1MeEbYl3c2b7B+h4XvfjJD7F70YoR6XU202YFSqOF6zHQhOi50NCoakYNImUoR0F8zKXTkGbkkOJ7a4ACwBzg+9Z1OpjZ3bdSC0e/jUwxC8Ko7EBaezYjuv3y1Nqw2b84+Xx2b3yQhT5nnafZrPL2J8iS+CnWXsmDEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcIXNYrs06UNJ7gDBRCZhPnsBL1DdQIyjPhfawvY+8c=;
 b=RHrgLpEtT9Te7ABrJ7hfM+TSUYpip0XP0I6IK1QbL24HuoVzZjKWApt5vPp7DTmSIZmSJH/K6WXzxIXPjMaqhFqiZowYBLkdwcAD0NawRlw7yQtGdAWcDMjSuBUuUxXsu9lzK1Uy3S2ql+zRabJgZWe2wOzRPSPdhT1vwmfvLrWun8mOVvPLqdFuSEqE3TQwY1am2XxP/Ing+ATP0hsDCbLOkLt6Bef9Rqar+0J5giCLhPkFMYYEHUuuubanG2eG86Mduih70Cm5Y3JiY9k3iTVBSfti26P8JU7jLjAaqUBc8nfUQ+/oYQwNI3owVQ6PvxRFkMUcjpqSjshlx40fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcIXNYrs06UNJ7gDBRCZhPnsBL1DdQIyjPhfawvY+8c=;
 b=Ae7FAZsrqLvK6X0pwDuP2YWFNAtdTZaf2mL9LPNWmUaQ0NBtt7VN2DG5vm/rxZlu932Maukn4YeYkeHeRe0/Tm53UnhpOVWDjMgN+djpkSlNM7RBkKpqr6sEzz2H2j0EG7fvmZaxu8M7PmosvtJiM2w6KhPMSSI55Q4DmtBBYlz+iyoH0UGhq9KBqvLu6D/NCyX14BztUuoMTcbGMCd8aTdhBkiowVUz4kmwn0ftkiBezHrrF+HEwnl8wR8oiYxsS/L7Dz07tQboPJ4Brs/kUooFB7SrllQHId/rHKmGB9h0ZiPNmlR7ae24ViqbfjTA85AMn9o/fWii4dvOJMt+dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 14:50:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:50:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/4] ARM: dts: clean up most ls1021a CHECK_DTB warning
Date: Fri, 22 Aug 2025 10:49:57 -0400
Message-Id: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWDqGgC/33N0Q6CIBTG8VdxXEeDgyl21Xu05kBA2QocOLI53
 z30pi5al/9vO7+zoKiD1RGdiwUFnWy03uVghwJ1g3C9xlblRkDgRDjl+B4pASpaNcX2KYKzrsf
 GmIYxqThTAuXLMWhj51293nIPNk4+vPYniW7rfy9RTHAt6kZWshREw8XN47HzD7RpCb4EIL8Fy
 AJo1lQlFwxk/RHWdX0Dwp8tUPYAAAA=
X-Change-ID: 20250818-ls1021a_dts_warning-fff933bd83da
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755874209; l=1416;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Bo9JfeierndIz/H45PHmW8cMOt342671rkqJWYezT04=;
 b=VFzjItlf4m2NljeDAtEUwOiHiev3b39NED20gFHPrWpC7Usz7JITiHrQZ9KEPJbHJU2OWr9ve
 KwCrJauP/tzDMqhxlDk6kNc4l/V1kdOISZ7Q4sDKbyzRdOrssWMma0W
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c10300-b5e8-49cd-a720-08dde18b328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWUxdDZSb0t0a3ZWR3hPYk9uZjRXMnlrN1BNbHhEc2hKVHR2d2xQT2hvREVz?=
 =?utf-8?B?a3ZkOVRFZ3ZiM3J3cVFtUTJtRkJoYXdlT3VPU1hINnpFc3FqeitEQXVmaWRJ?=
 =?utf-8?B?VHdOQUUzOWtURTJJWXpaLzZqdlRGb29tRlpra1h4Ym1xL1RJdDB1YXNJNXE0?=
 =?utf-8?B?aXNaRWJsYWRPcGZrTnRqaFJiUkVHa1NqQjNZN2w0eDdMdUNDWWZiY3pXYWxh?=
 =?utf-8?B?VE11NzNEZXNtMTZFMk5yRkJOY2x5c1RpMXgrZkYxS1gvUEF0VGdnbGRkSnBC?=
 =?utf-8?B?N2J5RDBJd3BrSWc1cjlIV0VPUWlNa3ZteW9oMVU5cnM3S05CbVRhUFMxbzFo?=
 =?utf-8?B?TW5CVW5BWGdBTDBKQ0xVTjVGbDJ1OEtaZERJQVZXTVRkWjNrMUpiMHFoNnJh?=
 =?utf-8?B?ZmYwRzgxTnBRNExxWXZ0VXVWcjFIOXNrOE00TVJzaDc3R2xlcUc5REVwY1Q1?=
 =?utf-8?B?Mld6UkZVYmJmKzdId1JEd1c3ODN1a09ab3lLQ2pyTVJ2bk1DeWtFNDQ3cVN2?=
 =?utf-8?B?c3ZjQXl5SEVDY2R0VExhTU5hemFsNGJTNkhCblJ3SGk3dnhzdFJZa3VEZFlK?=
 =?utf-8?B?R09qS0JnTEFiN1FvaXU3blFRd2N2U0ErdnNON0k0TWN6dnBzMlhOS1R1d3lG?=
 =?utf-8?B?RTJmUCtwTCtmUWVsS0tXQ0hNaE9wdElFdGVxQi9ycVNoRkVUUC9GQWkzSkZE?=
 =?utf-8?B?b3YzRnlWUmpZV3AvL21xTmhIMmxUMXc5UkpudjB1N3UrMGVzZ2FxaFBOa2xK?=
 =?utf-8?B?cE5rdEhYK0RaZlRWTi9rV3Q3Vno3bmNyeWpnYm9sYlhyQ0E3R2V1RUZPbGN2?=
 =?utf-8?B?MVFzdE9EaWtwREFBYWN0aGRsK3A2V3RvdnpnV2JHT0habWk5NFhVanJGa0Q4?=
 =?utf-8?B?QzhuMjR5TC96TXdBNHpQR2g5Zm5zSHk2THNlQjZjZDRFZHl5dUFhcEZkWXNl?=
 =?utf-8?B?OFRlb21rVGhQMmw3SmlJK2QrY3IxWk5PL1NwTERyVlRuS2RpWVc5RVlpc3Nm?=
 =?utf-8?B?anpuZGx0QVRyOWttMjdhOTdYSk9pRXF3UndJWjF3MkkwNXk5WG50NWFkemlz?=
 =?utf-8?B?WGp6S0dMRjNCOXdDR1Z0dEFrVTh1N1VabTdJbWZHWE5ZUC9iVGZRREtWZnI0?=
 =?utf-8?B?QUl2eVJ2Z25yZ0V0UjhYVWU1cHV6SkxETUNzK2xCQzN4NmsvcTJ5K3dWRjF5?=
 =?utf-8?B?bXl1UDFYcmxHNzNDZlkzd3RyY3hUYWRoTHZjNlhnMjl1c1BDWG95Zlc2RStP?=
 =?utf-8?B?R3ZGTGxJQjE5czZNQzZtaGZGSUFPLzlGUWJlY2ZqVXJxY0NTblBzd1BxTmt2?=
 =?utf-8?B?ME8vS1U3THByMFFQU3RxZm9NVWZWS1dTV2V4Z205THkrbHlQaFdFeURpbHE5?=
 =?utf-8?B?a3NJaFgzelUzUlhUQmtTbGtNNVBqWDdjOWdXV05TYnNNWVJuSVF4K1J0MkQ3?=
 =?utf-8?B?SUhFTzhLdFNaYkFSYmZoUlAxTTZpdmt4RGZyZTdzUW1jQzllZWJRS1pHa1Vz?=
 =?utf-8?B?Y3IvbXZaQkxuVEFGRVB1SFBFVlBRSXMzb05STXlIcVovVzJEWGNwQk9kVmZG?=
 =?utf-8?B?WXUrWjBQV0lpZlZSL3pnYU9rdFV2N2k2TkdLZGRtb3hhU1hUNG9jS3Q2Z05a?=
 =?utf-8?B?NTV0cm5yaFdSVmc1Mlc2MDJkRlpLeElHbXl2Y1BpaVZPRGlDN2hiWk5TNGov?=
 =?utf-8?B?M0RGeVY5bExHYXFYL2l1bmZJSDlVWFZZQUpRb1pRTzdNc01vOWY2em9YT1dR?=
 =?utf-8?B?YkhNTjFUUWFnbitYUjFNMG92eE80NitCRmE3WWYwU2plR0lpTTdWSU5ySGNF?=
 =?utf-8?B?OVN6VFV6N2FkbXJhc1BTVUFGTmFxRWtabWlsbWxKbGVzSTBaU1F6MzhVWXpj?=
 =?utf-8?B?bmpvTUcwVmd0K1lNZm9ld3EvVkh2R0JIdjJmclA4aStsOTB6R1BCNDBHM3Rt?=
 =?utf-8?B?M3FHWm9zVHFYR2QxNExzVEpHWHJLbGJMMklNa293S202RUZjMkxWamw4NDFu?=
 =?utf-8?Q?TkyDK7A0QM8ePj6SKRzaFK/J7zwMrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU9ZSGdsUm53bFlaemVXVlJVcm1GUGFrVWw4YTJ2cFdHSVU4a09GWEdHajhR?=
 =?utf-8?B?L1JUUk1GN1dvYlNTZVZpZ2E4ZklsNHIwbkUvanlvMzAvL0VlWGJCSTFWamFN?=
 =?utf-8?B?TXZON1p2UUFtandDYTIxdlN4UnZlL2Z2NG55Yk9BYTRzMExCdzZscjVvbVlO?=
 =?utf-8?B?K2ZHZjNwN28zWFFlNGlRbFhXOHNQM0pISUJpS1R3RW9KOG96ZXc2bVhiVm9K?=
 =?utf-8?B?MkJCempmUGhVcm9VR1ZTNkx4SjFmUmxEdllQWFQ3c2FrTy9GbVF3akhEN2dQ?=
 =?utf-8?B?YWd2NkZzS3dPcXlPMDlSL3AzbmV4d0tLL2R5eEhoTFNlQVVjRGJxRU9jTE13?=
 =?utf-8?B?MUU1S21lbUVzRnpXOWV4U2d2Zzdwa3FQVnNVTThQVFc5ak5kU09zYk53YXh3?=
 =?utf-8?B?ZGUxamhLRzloMEN4VHJLRENBUC9CRTgyVFdOemVvcTFQaCtRVjF5UWQ1UU1W?=
 =?utf-8?B?R1RkVDNadjRuOWt3WHU3UnJhTktsaDlEZUNZbGJyUkJGUXlWaG14WGk5UnZZ?=
 =?utf-8?B?TStDeWd5a1BkNUhtOFZNbDJSMjB0dFRJcW1rRTREUHB0dmhPK3QwZkN3V2JE?=
 =?utf-8?B?eThtMk9KVXF6VHVlTEh3V0NkUW81QU82SDBpckpMb1QyNmVhSjk2YlZMMXBn?=
 =?utf-8?B?dmtOMTBXTGs0YWk5Z256NDZHcHUxM1ErMjllcXR0eWRBcUNwaXlkUUc4R1Nn?=
 =?utf-8?B?TFBpdmpGMVgrWWtuSDF6a0JWTWtSa1JnWElFc2c5RHZyMTlRc0ljeXE2RHJs?=
 =?utf-8?B?SHJKUHVGalRQQkI1TmVROVdtSEovNllSb3Q1RmJ1YXNvd0hBWnEwZ2xPQnFu?=
 =?utf-8?B?clVhZWQ3SzdYbitqK0xuMEsyNGlLYVZuK0lLeHUwUXlqTzZsNlRTbm50UWtw?=
 =?utf-8?B?S3JpVjFNMGV4UEZiNmFqbUJkNlp6UVdlRG1UazFpelRnbmE0ZlF3TlMvVGdR?=
 =?utf-8?B?RjlmUXNaVGlVVmVPL3kxRFBtTDZqTTJnRGkyWGNUeVJJdU93L29MTnVXRTU0?=
 =?utf-8?B?OVdqdWQ2Y1NZQTgrU3dDWmcxTTFSVW5nRFp1ZFJkN25KWjNiRlgzWndYSGNv?=
 =?utf-8?B?R0hmZGRkU1lUallUdXNQcVhxcEVWcWFaaUVacCtWU2ZTZTZjQmFuUWhLL05M?=
 =?utf-8?B?bmlJYWtyWGdwak1NUUZ6ZkZLRGJHV1Nua2NvTVl3NU8xWmRRYVoydm42bXhV?=
 =?utf-8?B?R2FTYi94eTVQcllNMGpHZ2xVMENEd2pTNmg5b1ozZFV0dUhzWGV5eTdpMHls?=
 =?utf-8?B?cnlpTkV2N0FGK0lIR3pDOUhuZkNNbkhsUFhhMzg5N1c0V20wWEZQRENKelhO?=
 =?utf-8?B?NFQxb013Wis0NTYydjduOEN0WWdaYTdZQVQyQ1RiVWZzYUU1RjJybkNLM2Jw?=
 =?utf-8?B?Z2pOalBPc0tWM3VSVUJFUmtycWlOVFl1YlBoNDRMaFZISEIxVGJNZ0YxYmsw?=
 =?utf-8?B?dmxlNGhFdUNaSGtuMDFKT09Da2EwN1NBUDNGUlpYQnVHTnVJamtWMWFxaEhX?=
 =?utf-8?B?K1pWSUs4OUtqZ3JGc08xUjUzVnNIdUZWekVUY1BwSllhYjN5bHVNSDZkMTlC?=
 =?utf-8?B?Q0xQTEIwWTEzS205b05BNmkwZ2hlSHBlUzBaSkR1M1NtVURyUlFmTWJOSGpS?=
 =?utf-8?B?UVlvN1VTVG02UitnbWFzdjZrb2ZHL2txUGxpeDd3SWlENFRtbmJJUHFVOHpx?=
 =?utf-8?B?SXJvS3R1ZzhlTEl5QlozWUNtZHNHOTBrMkJNbE1iVG5BcU0zTUVrUzZaWVBX?=
 =?utf-8?B?aTZmMysrUFNUVUdnWmxKY0NTTHNtYnpPZEZReHBWSzA4dkVicDhWZWRZa0Jv?=
 =?utf-8?B?VkZXRXNpMkd5VzR1YXNaNUZvVUN4SGdqOEM0SE5rOVJkcU9oM2xPZjVYYlph?=
 =?utf-8?B?ZDJGTlhJSmIvN0xQd2RISWNaMFVmaW0zcWJ4RmpuSldlMTE2dENkY0dzMEVo?=
 =?utf-8?B?d09veTQ4NDk5RUo4MnNnNUpjcXlhcitoM0xEUEFuSURSdnVUc2FyeG1jUENm?=
 =?utf-8?B?SUcrMEFnWElJTGRCVEtQQytnR3ZXRGduYU1RN0p0MmFRK0lQaDcvSThEQjJi?=
 =?utf-8?B?STR3ZEFuZXR6bVJrRlg3bFJYcEM0bCtBcWprVCs2Q0xiNEhaSTlMbW55NUZm?=
 =?utf-8?Q?Z1Gg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c10300-b5e8-49cd-a720-08dde18b328b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:50:12.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4swFKhE2zcr3RHQDYj130DVAotoHfxC4nzq/sM3P9gasJIFR/m7rYJumDP9IKDtVpfLdJ9A4O2DaOvVGcXVXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086

clean up most ls1021a CHECK_DTB warning.

Old uboot check esdhc@1560000. The new uboot already switch to check both
esdhc@1560000 and mmc@1560000. So we can rename it now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- rebase guoshawn/imx/dt tree. Remove patches that were already merged.
- Link to v2: https://lore.kernel.org/r/20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com

Changes in v2:
- squash rename to flash patches
- remove duplicate patches already post in
https://lore.kernel.org/linux-devicetree/20250725061339.266125-1-alexander.stein@ew.tq-group.com/
- Link to v1: https://lore.kernel.org/r/20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com

---
Frank Li (4):
      ARM: dts: ls1021a: Rename node name nor to flash
      ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
      ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
      ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1

 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 8 ++++----
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts | 2 --
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi    | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 75ad5f47c58aee30248d294a58c8ee52e079a8e3
change-id: 20250818-ls1021a_dts_warning-fff933bd83da

Best regards,
--
Frank Li <Frank.Li@nxp.com>


