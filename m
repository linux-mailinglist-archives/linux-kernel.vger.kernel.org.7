Return-Path: <linux-kernel+bounces-829620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9DAB9779E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D2719C8196
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A430B522;
	Tue, 23 Sep 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIgygczY"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C825F994;
	Tue, 23 Sep 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658990; cv=fail; b=SrNUJUVCiAxpAaBZbrwnlPJusFNoIR5w6uGdzB50346MC6NGHiTEWYzR/pDcvaR5jEG+jcsxbNTe+5cqw/wse5BWeRI/d6eaqh6B7SIKd+Xz2ZgIDmofdctxhqKOxfX3KSdDsTiVLjzZEHJcQ8uxCaWbLoXTu8BJ0I2mdz+xeYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658990; c=relaxed/simple;
	bh=5y+M5fnKCCkgZEAZMnWMYKoFsDOilNhPTPJEb0iMbIw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kqGTRXQYZX+0AnigQI5qVPGN3YO9kEDEPwdrDNLKjOLh9q/f6uIu7TtCp2u7CyF5OBeQCoYT4wXgLciELYhzOxJqybrrkriok+CFjGyxi/WQgtVcE7xPU6LgqRVLshczinJWz00B9bTrR2YPXUOTCdKIBN/7sevSay9Trvjytbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YIgygczY; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTsF5JUhH4cu/9hABfW42YFQJyHWXC1UfezRqEx9hROUk7u6MxXqo2Re6scOIyIxf2GcO0UmRP6HitrgbPB7swUpPWI7AuH9EABuewg0LmVazU0Ae1qHCfbB2dIWk4hT1o41QfGBxae5boCAz2ZieBeF2ZloD88OVvEjufdHKWVjMrlvOOzckM5psXMNQPwptiuoX8Pfsa3xV+91/spB4TM4McMIXp5HF+ipAYgWXCVYNXnq8ONTjFQxF2spLSZ2KfBEetRhw4YeH9mX1yy25ysk2ip7ScVhQyRVa83FxCki6uqkdJd9xlCMfVe2d1We5oUGjuZygNvqKuH7bY68Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HVNRKnXwN1l3v7rGC9v9wEQAvyOTqKaPM0kGZyug6c=;
 b=vWn+Xny252HOaBUCmtHW/0rCWF2Xo/7b8yaVocscFLgMSKNE8eiUszRgl2652e3iQGoa8feg0crZoPB/N13xLqT+XtyNT6VbWxP8sQGggErlnhAdg38Zl9nKQbTKfSZqnilmuIR3bqn/q9wDJY7EGlKNT2ayio/HoLxlZ+5HcKbPvldPbk3zedn48zw6gs10oep9dP7coscxPeeSXYuuARkYjgdt4Rsv+VEEsPs0e/iFX4IU5UBiKOFkRifmpqeLIbMkoMfXizqCsxHxmobB27NvtMH8Q8x9z8ZsXvQOy3JS64il9QQ5i7H/ubq9lMlwgPP9Ouvcm7TRgN/30nbNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HVNRKnXwN1l3v7rGC9v9wEQAvyOTqKaPM0kGZyug6c=;
 b=YIgygczYk0vZCCrjS0OQUs7+JrLKZYsgrBntvDYvttEyknpKwNB2MgHOFq/zKi4rQmgiCmTUxyFMnwaMRp4rwXrz0Bu2iX+0D74ciBltQQmAetAzOo9RyAS44ShbE8udWLgnq6wHqbPiuIExBfpylAVY4Caj6U5AC5XCr5LYVCk29kilz9+i3RdtRlizXbL006U8+eWCWY/JVf7TouWQHV9RI4UBPy7XwhNNlhWUwRgHJppIlY9FqIUkXqfM+Hq6x7AFFeEe83jAHtuj76TphPL7PmWv2+y1rndEj0RD71FB4rKSD6U/oQsKZwC7XLru/Zb4zaf54O4cqEN1kb3ACw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:23:04 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:23:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Date: Tue, 23 Sep 2025 16:22:47 -0400
Message-Id: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcB02gC/32NQQ7CIBBFr9LMWgxFpOrKe5imgWEqJBYaMKSm6
 d3FHsDle8l/f4VMyVOGW7NCouKzj6GCODSATocnMW8rg+DizBUX7JUHO+kBo6NEAYnhCYVRY3e
 1RkCdzYlGv+zJR1/Z+fyO6bM/lPZn/8RKyzhD1cmLtEobJe9hmY8YJ+i3bfsC9mkaS64AAAA=
X-Change-ID: 20250602-ls_dma_coherence-c3c2b6f79db2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, Frank Li <Frank.Li@nxp.com>, 
 Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758658981; l=2684;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5y+M5fnKCCkgZEAZMnWMYKoFsDOilNhPTPJEb0iMbIw=;
 b=Q6ljfRqxNIvbOFcQBvEwfDDoc9fOM2qui3z8A2aTyaTvRHTz0PZKpqJ+Srdj2H1dDdSKffMB6
 yI55qMtz7YeCwbFs+y+q8nMhADeoGGRJXA5rZXJxOJysV9/7h2Ua9BT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 271e3d2f-e122-47ad-ecfb-08ddfadeffd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGJXZVpySTNqcmFkUHFUQUdLOWovZFh5a0J2ZHl2RHFIeDVPSktDYkNnamhL?=
 =?utf-8?B?VngvaDhkbXJBR0R6NVFkOEp3b1BFRTh4b2xOdHQzZHBXQ0ZrOTdTdlVRc3Av?=
 =?utf-8?B?R1RLelhPRkRyR2ZDTlEvZC9UdHEzVE5ZVGl1enNqblB3N2xuc1BRTkxqYVRt?=
 =?utf-8?B?VmRPSzkvZGJFaHZoY0xrN1JlUTR0eWtrbStmNTRObzNPM1FXUFpjK0lRU1RR?=
 =?utf-8?B?b25janpzYVkrR243bFRLZENIaXQxemNUV2FSOHBnZXBZNEZxTzZXNndiSkhu?=
 =?utf-8?B?NzZxcnovYmIzcnZVSWMvbFZyMDNBRG94RThMUnJLMytDcUxwa0ZIWHBPd3pI?=
 =?utf-8?B?WDNkNXZrNkhBZ2ljVk9JWjFzMlE0eTJEc3FYTU1BTmZXMlZTMm94eGtHVnRz?=
 =?utf-8?B?UTFzZ3RUd3psbzk4Wm5MbGt0cWdEMVE0WUNzcTBkNTV0akJYOUFRaVVrbEI0?=
 =?utf-8?B?SmI3N0FyWjBZc0ozOFh3eTJkUVhhR3BSY3VGZTlhcjFxWVJBcDNmYURzTEhK?=
 =?utf-8?B?dHVRV00zeFl4bi81WlpHcENMM3BkOHJEWmYvamV3cGp4dndMUFJTdjlTcXE1?=
 =?utf-8?B?K3V3T3NpKzgzeFVhcFBoUWNKWkRjbXJGY2lsSHZUdWFNaUpOU2g1RjhRa090?=
 =?utf-8?B?dkVrc1JQZWlMdFpFYjJUMlpJOTN6aHQ5N00ya05vajNqSktXcmtkWmNJVHhY?=
 =?utf-8?B?Rlc4QWdrU1ZvN1MzdkVncXJHMEhZMm1kQUlwUkhIemdEZm9XRTZRS3UwUklK?=
 =?utf-8?B?b01XOXp3NE1aa1JHT3lHL3hsMnArNnJOang2em5TeVRpQTFuSUxwWCtXakdY?=
 =?utf-8?B?WjRZcEwwZ0ZDSGxZRDVqSFo2RndabkQzMFBiQm9qUTZZYUJNVDhpbGdlQjVG?=
 =?utf-8?B?enhmb1Ywc2xIdzhvOStucDBJTjJLR3N3VTdxNDJjLzQxZkNrWXo3dTQ5cTNC?=
 =?utf-8?B?UGtyWTMvUjMyT0drRElrZGVjS0FsSWthUWhDclJaSnNYWml6MjhMbm1ReVFh?=
 =?utf-8?B?NmF3N1QyY2o0dEtsUWRxODgzVjk1azJQMXAzWnVuMXA3TW5GQjV3dVh2bVFo?=
 =?utf-8?B?OWR2WFNzMHEvd0Jpb2U5bnRsbFNVWFp4dFZ5bXlUSURJdFJ0b2tGVTRwNTdt?=
 =?utf-8?B?angrUnVRanBHRW9oQi9PNSt3SmhhWWRoYjB4MS8xbnE2bGlNVkFRRVZjcW1H?=
 =?utf-8?B?ZmNXTTlUbUhBTW1kZDJzMU9ZN3phQXljUkVvdEk4S3BHM3RBaFVNUExmV2tm?=
 =?utf-8?B?alZOczdRQ0V2K2cvUnV1ZUwyQkVoVnZTOVhFY3dITCtUMjRYZjFYOThpNExN?=
 =?utf-8?B?QzZaZmlEUHgvdVFJRk5lUXgxTUZIZTdoWUkzSmZTNXRITCtkZUowU25pTENr?=
 =?utf-8?B?VlJEWTc1d3JkWm4rR2FRZ1hzbkVrR1NkSVpXZ0hTak9DTlBhSE5PYUxWOGZS?=
 =?utf-8?B?Vmo4TldQSUlWWHl0ZEYvLy9jNHJBSWIvRkIvVVhlNFdRa2JCS1daRmZQWVhi?=
 =?utf-8?B?RUtiTWNMamlCelRjakFoemVoYml2cnA0OE5sZXdTZExBQWFqdHMvZkJCRUZu?=
 =?utf-8?B?ZjN3WWFiY1AxbUlLUHkwRFBkVmZsd0tYaTF2RmZoNzVjK3RsaXIybzluOENw?=
 =?utf-8?B?bkFuZm9NS3F1SEN6dE43RXJKZ0ZwR0Nud2c3ck5UVUhQeEk5Vjl4R0dqM0xQ?=
 =?utf-8?B?ZmlCWUpVYXpIQit4M0owMjdEOFJ5MmFPTWNxYmwvNG9WTlpzcGpqc2Q1eGtr?=
 =?utf-8?B?YWdkWllqZ0R3MnJudGdaMXpMOFNvZ0NVRTI3ZVV2YmVPQVRYUWIzQW5UaTMw?=
 =?utf-8?B?aVlvRnBRODMvTGlydDFueHRqTWNtVkdkVUcxMlNBbDJTQ3FwWjhpMnZEUmN3?=
 =?utf-8?B?TU9WeFRhN0taV1JiZXFzU0crZmNybzhXRWQrNUFvajNNa0FMR2dDM2RTQjhJ?=
 =?utf-8?B?TDdWL3hNa2p6REFaMnpCTmc3cTd5Y2xKMXNKYzF2WWNrL3l0K1c4OGE3TXFQ?=
 =?utf-8?Q?ajg8wUEIny4OY0JZmTK5QjyQ2Sblms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVc3VGMwSnlvSUlKZ1JzZnMxVVVua3JoZnk4Y1drMnpjR0xmV0M5SnV2U29V?=
 =?utf-8?B?aHJkelUwRStGbUliK05Lc0tDeXF1MjdFb250RWE2VzRWQW9pck0wV2lMTDI1?=
 =?utf-8?B?QVdkbUgwTFhVbUpSWUhCMUk5Z0pTamo2ZWtpTUlicVdxQSt2ZjBmOHd5M1ZX?=
 =?utf-8?B?V0g0VmJQcUt0emhiZXZRSWd4SWNFVTJucEg0SzJUY0dRRHoxYXM3YTBGV3lY?=
 =?utf-8?B?Zm9LMkZYM3BMVkxsRjNhS2JFU0VSYms2TUhScmpmaXpwNDNRSDNaekp3V0J1?=
 =?utf-8?B?R2NkRXZPaEFCQ1NiczczYmdYTk1aa1FaVjc2SEpKRmc3bURHdkxKR1JoRnQ4?=
 =?utf-8?B?THVEcTkvQlgrWU05YnJtR2xGOGRmdHN3aExqekNJcWFhbUtSVjA3TjUvYnNt?=
 =?utf-8?B?eXdDS0l5UUlZcDhsVTFwNlp4NEJudnFYczBhcEVEVW5QdExBZklsd0R1aG5I?=
 =?utf-8?B?ZWNqUCttNXlKVzNTQVdiZGVnY2xrT0RBRG85NHhOTlBDUzBwM2krNVRzS2JG?=
 =?utf-8?B?SzNmWVA2S2tYalVHN2FxK0xlRDJHUE42SzVZM0lDalJBUE14V0tYMjBrWkdX?=
 =?utf-8?B?NktEQ1JQZ2VOMXRSQnhNK0tBZ3pQNHBLalV3Y0xoVEN6YmVJS3k4NkhwZGVH?=
 =?utf-8?B?UlZSTnBaYzk2WlNNK0p1enFYVFEvTlJWTlZIUk9CaE90Q09LQkdtL1hCbHJa?=
 =?utf-8?B?WXlwQVh2TXpCdVZqclN1ZHVhNkZieUhxczA1RUtmMWFqZVk2NTMrMXN3U3Jv?=
 =?utf-8?B?cExqc2k2U1MxTEgvekVlRmRRTEEwaTkremRIK3ZvMHNFeHZLNmExVC95UEww?=
 =?utf-8?B?ekJpQm5GL0NiYUE3YjE4OENlNGVRZVV4NmVuYTJuY0xYb3AyTXBKaWhJMjd4?=
 =?utf-8?B?Zlp2VVJtOFZwVkRvMEhoazVPaVU0SFZHek5LNWttSHhjYTBwU3orUUVYWXhm?=
 =?utf-8?B?L3Ixa3F3KzFyOGdnNkUyOW9iRThvTGxsSVh4YWlvbitkNDNCenJmcFBRQTdP?=
 =?utf-8?B?NG9wcmJOZmVEMGpIRG81a0g4aFRuTThYK3p1RXZOR1RDS05vQWJqdnVwQzNy?=
 =?utf-8?B?eGJjb1ppZFEzR1dFSGRoOGdxcTBzQlRPaTEybDkycXlaZEtDOTE3eTNEazhO?=
 =?utf-8?B?T2hvOXZiZ2I5TGg5UU9FN0UzbGVoQmFQNmtNYzhLcXAzWExOWk5xYmdOZE1p?=
 =?utf-8?B?aXBSNnlWM3Fzb1VyWEYrMlAwZmtJRElwdnNBTmdRTU5PaUhlR0s2Vm5SMCt2?=
 =?utf-8?B?Uit2RFVtSTRuYjRQWGhvTDNkV0F5S0ZZdGV6OE80bXg1Ny9FbE1jWnpYakVk?=
 =?utf-8?B?dG9IMmkyMnJ5RUxmZ2JuRFRKUFJKMlVydEhyZnZDZytSNVJyb3Y1T2xOTWtj?=
 =?utf-8?B?ZkhzdTJjUGdwVW94NGd0U1VGb2F0MktnYjFTcmVYSVlxVUNiSWk2eFNOeXJz?=
 =?utf-8?B?RGNvc1U2REt2bDFVcnZqOUlva3o5VGxOY0VPQ21VcWY5cDJzZE5UQmlRVGFi?=
 =?utf-8?B?KzZ0K21tUFc4SWNOU0hNOThwNEtJUUVKc1FYaUJSdzRQZ0o0V0RIeml6WVI4?=
 =?utf-8?B?RFJvN0M0dTVqR21uZG9WRkxGWU14Q0dwYW0vUDlLdG5QMStVM21DcTMwTzdS?=
 =?utf-8?B?ZDV5eUJDWGRlVVVGNW9CY1VBVW44YVVYbjFxZkkzNFJSVkV3Umo1K0FLejdJ?=
 =?utf-8?B?NnVhcGNSYko0ZWdtU29INy9ieldwQ2JHY0xRZktMQ3FpNFRFQ2FOdWtOYVlN?=
 =?utf-8?B?MUpmWW5vcUNUT0lxSXhJVTZZcjRXSi95LzhVenZxbHVETkJBWUVyTHlzeU4v?=
 =?utf-8?B?dlkxMy9DSjFwRDlNam9tMC90WGIvb2hVdUFkMUdROWs0S1NQRDFvdTJWc3Nz?=
 =?utf-8?B?SnZTakR3cHlqYTA1enM1bXJpaDVNcDNXNE50M1dFUnBKL1Zqb09CV0ZqVmY1?=
 =?utf-8?B?ak1nL2pIMDlwMDNiOXdNMnJMZU9mR1lCbzFESFJ4bW1ML0pGeTdGODJXQ0xB?=
 =?utf-8?B?VFpiRHBPeXlkNDBKamlPQTFiTHhmU3NEK0JobGNERG5QSUhpbUNqRzhSQkpK?=
 =?utf-8?B?WUV1cmFXUGR3L3NMYysxc21BZmhHWWpiNUY2NTlwL2NiSndkbWhzR281ZVUv?=
 =?utf-8?Q?3mVo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e3d2f-e122-47ad-ecfb-08ddfadeffd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:23:04.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViRZptv695E1nGIEGkaGrwyhL0EY8Z8xWWexpUEtqvWhPoVqxT9BLERmAhiW3GmCUyqPqeAbTm8NLcAK5aBEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
It needs set gsburstcfg0 to 0x2222.

There are some several try before:
[1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
[2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/

[2]: add new property, which was reject because there are no varience in
the soc. Fortunately the below commit resolve this problem by use software
managed property.

d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

[1] was reject because there are not actually dwc wrap at layerscape
platform. Fortunately Bjorn Andersson's below patch to make it possible
by use correct dts dwc3 node layer out.

613a2e655d4dc usb: dwc3: core: Expose core driver as library

This resolve problem [1] and [2] by use flatten dwc3 core library.

1. add soc specific compatible string at dt-binding.
2. create platform driver for layerscape chips and pass down gsbuscfg0 if
dma-coherence enabled.
3. update layerscape dts files.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- base on drivers/usb/dwc3/dwc3-generic-plat.c

commit e0b6dc00c701e600e655417aab1e100b73de821a
Author: Ze Huang <huang.ze@linux.dev>
Date:   Sat Sep 13 00:53:48 2025 +0800

    usb: dwc3: add generic driver to support flattened

    To support flattened dwc3 dt model and drop the glue layer, introduce the
    `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
    and offers an alternative to the existing glue driver `dwc3-of-simple`.

- Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com

---
Frank Li (3):
      dt-bindings: usb: add missed compatible string for arm64 layerscape
      usb: dwc3: dwc3-generic-plat: add layerscape dwc3 support
      arm64: dts: layerscape: add dma-coherent for usb node

 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
 drivers/usb/dwc3/dwc3-generic-plat.c               | 30 +++++++++++++++++++-
 8 files changed, 79 insertions(+), 29 deletions(-)
---
base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
change-id: 20250602-ls_dma_coherence-c3c2b6f79db2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


