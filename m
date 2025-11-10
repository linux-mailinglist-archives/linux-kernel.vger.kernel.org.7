Return-Path: <linux-kernel+bounces-893016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68426C46579
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7165A4EC0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A930149E;
	Mon, 10 Nov 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MF3PeftE"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AB302743;
	Mon, 10 Nov 2025 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774946; cv=fail; b=LWoqkrB6/+iEIUH9fa6wHFVIRNyk1OKLdSQcbQ8JsBWaVUAhnPe+ecUUFEojbYeHSv3efw5gnYA2aHH+JC6xaaHcLyuYCmY2K9aoyOdJBvMyzK3XM0wnEuhOhQhPqT/9saARjQh0qFR4zV6A3wZsgvWF37QItYh/PpxCNxAZHyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774946; c=relaxed/simple;
	bh=TB46P+sRVNQEoXyH3p5q9YLcyMdGhB9s28Nrdaa2PfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lz6cyaElYWn6EkDcSv0/FiAPSiGDVS2G237l2YwKL2veAdXq69HoqQDXgK3/NIlPW8Jq37+sVN8dmlBNQjbqdBpiZrR2qtj3OpcteCNqiTHkuhb+JcAbQY8BccRLFXUW0pMaCjSb5+3zRfFZ0CpsAdVgMandia0seYUxinpJvrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MF3PeftE; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/wGMPXjNPQWA4q+Z50z8881zoTUZPKV0z4q0QujfyP4TsVouZFH2zCZiqpZHRwivfn3BDF2gFTImHuQZp1JnCdRfT89D1LyiX+ZTkoBbjotID2GME/ZnvdTLqsE0cFFC4LNCJz6vF8nw82QPL+4AJczcCziV+ftrY2kZ13D9RqiwMjMM3s/8D5xZEhPAfA/LjZ0gTMb5H2xyKiD+ZK0EgVPoy6Z8FIaBQQPefmeW/VWGYtrb02Tyg1wPgYFOFg+d1Wv2UbIPk2zgJ0Jlrl29W6degxfUdA8VMH6CzqoZKbPxDDBAQnp4kaERDXsxYYsRF9PhUfyRAMhUdl2uruyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTxDeII4ezaQKtWd23/M1ql6FR1DsbR1sDDs63kyraE=;
 b=jr1t7DED5QD5A1Koef753HXKmw5TN+BePwGgF40VFSmat0GWXDiOzlvQmfxnpY2CBxU3UIe0SkWtR+tCdjBy6/oswrl0PwzjVj9SABOB/Ulr6Z9lqNkQSzDXTc1aA9TRWOgQ0ZTun/hp6Nx2utzAxe9zyTu3veGU2MZOeXfpCV5/mpwfKRVdewfBPM6it6Lr/LfLd+jCAj+jPUV5ek8LvhGow0nwQHW/Qn1MX7LmFQSVqKyrZMBkE3m9k2nzTvOXWXDssxkx4R4Ku5nXS/a7XOZbS4JM/eDtI1KO00hZeSLmlytvia8Qo3mep94i9LIEtLCRar/tEACyULwvefF1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTxDeII4ezaQKtWd23/M1ql6FR1DsbR1sDDs63kyraE=;
 b=MF3PeftErb/7dV5Jv22NBuxCFDBxqgKOPDq9J859IcyDYO7QZYqEiA6yFrZW+rGLkfIEAzdq+Dk1ZN6/ERy0Zz92p+6u4FEBXAMav+3+rZ+50ES39ThR/nvt53r0YAgu1RKQepS6ePWFD9bXEgAD9QsbPedxGcm+C2spvFT8OhDjb4ZcmVEeAzdEHwWzdHnD1aLkzBRzPtTgobLEbm9zJVokM2vXwqteEHdiQEqDPudsH7fBAK3NMxNaGmu2Vh3rlLDHgz+InuTXCfTquUEhTRUeusQEXCUNHcAz9xp9yvOi3VdbImG0tl8/dzB3Ko3ucOJDM9Nad0LYhyeW1jmq1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:42:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 11:42:21 +0000
Date: Mon, 10 Nov 2025 13:42:16 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 0/2] phy: microchip: lan966x: Allow to invert N and P
 signals
Message-ID: <20251110114216.r6zdgg4iky7kasut@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: VI1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:803:1::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: c643b81b-fe23-4989-6133-08de204e34b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CVdZ5yUXIMM2sHb0E638BcWOkTqluSsphb6cO+DJ2xDoGLRTme8VOrFIGKKn?=
 =?us-ascii?Q?2gqbwlRHBsN7Ut5puGipEN0OkGzJYA7GyWoO3dxSebStKVc1YEzXNI/jVoQi?=
 =?us-ascii?Q?I2CYENdcN25SMmwnEXtuH+I6wLypI1hEEvL+tTPNnL/Au5i8XrBqjTC+cCp6?=
 =?us-ascii?Q?xIDssPdizzdx6QZSrOrjiRIBNsJLJTtKtYrLCVuQdbHrLPK6BWCJh2GyhZGF?=
 =?us-ascii?Q?KrZcPoDVxll15IbW+OduGXYCZS9ikhWrxLotfyNx0xxlRuhRPDQN5pJLCGC9?=
 =?us-ascii?Q?xGoxRWSfrwRThdHauSX3TxyOzVa7Fi2hjbAqiYBPVlNovQT35oJYTXlwkq8S?=
 =?us-ascii?Q?3MfZlVmWNPlwK5MYvpk9RG/hYbWwR1lExBt9VweTp0QllUb/dbiSl6LmPFdd?=
 =?us-ascii?Q?QwuDAplwijFksmmRx2xJ2sEk14CUFRHHY5tMAXP5HSQBlzyqWj5nq0ORYjgp?=
 =?us-ascii?Q?IxWMNOZxGki2Vk8xurQ6QpoVA+bbOtPo86vCpniAq66IUZ/f3EqKvqSjGTp5?=
 =?us-ascii?Q?yzhVR0DQea4OYdbfNUbl8hXbP5gmf9YcaZdZevYb9dXgmYW65nOnTo6Y7qo8?=
 =?us-ascii?Q?s66F69F6HFMTO9+M6IKxWhm1rqp9uX6gw5NIkc6NU5/RJAHW9ND9gNM5ETfb?=
 =?us-ascii?Q?3PzGYV+j8Hid887pI35RZjX1kRJmTHJHHItt2Xj08xw9svEyRvoWVh6ykBLg?=
 =?us-ascii?Q?nKW1D9+trzXfbseBK4Zb+YUCTj6MDkKG92RdpjowIFXnO+QWQ/kdsthrftcZ?=
 =?us-ascii?Q?1emhaQ0CPwSQ/QDZMqtyI3Nbf9jZxqANQqQ2W/dXsZaTtAoBJwsEO/UGqbIn?=
 =?us-ascii?Q?mKLi4r9AKvewdaHQ0eOqckCrMjFCMxO/nuCqX5bUpfPJc8cnhOXWJg3v2S1c?=
 =?us-ascii?Q?iRP1VAStPdJrsma8d+Yb1JaWNPRKfjrtF5VGh7l0dwfnH8Ci8anXuwvneHnM?=
 =?us-ascii?Q?E4XSWZIhE6Y+DSVAmyaGb6JR8EwmmJxdHl+DpoMhPi9TJtYg31i3caDlkFjr?=
 =?us-ascii?Q?gLYV+VTB8lk1AlFmu9OnEK+jok4yqbnxgaw2wHrOOSGBSPL9fdKIXd1bvjDE?=
 =?us-ascii?Q?ul3SMZxA8yqamd/Gz6LnrpUJqrXFis776XKNumDEa95gdg/TxywWCpDqiccy?=
 =?us-ascii?Q?rZVMBCQa8ZhMJV9YkEeLFuuaG6IGVLtwLWhOfp42qVgmEFxM7uWDZHbuZEQl?=
 =?us-ascii?Q?PAt9kRaWHrS0Atjrfb5gssZ7OuD9+ZXVFrSCfV4DA3zCkAsxbwUDOhFvcFIA?=
 =?us-ascii?Q?OhmODCe1F9z6S0f5WH+0tMGTab2NoKC0HvGaCn4yyXb+yrLDWX88Q4GW5Hei?=
 =?us-ascii?Q?i70lNVrsbbBAnPEPGVtt/24BLq+tc4kOlhqxt842ghvGhiCJS7irKdxyG0Vu?=
 =?us-ascii?Q?6dW83eBeUBM0CBXcwhM9jZ6ShvxXMrv6jz8lsjBBN6jp9y6ggw/HFj4NDC5w?=
 =?us-ascii?Q?G4Rn5OmHOSDgnm6fpzCVUSu+C/TI0upr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIfnfIAoHB93MOvaStdJdbT1Eq8bxA2tDsix2Nq5sCJdF74sIJQbp/nSzAZE?=
 =?us-ascii?Q?SjyyDpjqO7pTVNtZSutV0btwKdSw0rh2EXFE32MevABHmKJGbkptEazweKN0?=
 =?us-ascii?Q?/Tj1MnqhSXI771HbQXYcd3mABCBWG982PD6mi5akcG2/ihYK5Aved2jsI6TC?=
 =?us-ascii?Q?49X4Z3SQctoaFT/080QDXUi7CHvByJIK//nFbSKHwo6bFRddAsgaTK/BV8pL?=
 =?us-ascii?Q?70TZSdIn+q8LdAPrajnvX3VBXZ28Uuwo/eE5KzsEyGi/ezCxTS6RDfJya7nn?=
 =?us-ascii?Q?n6OOY7f45ahfASoU26guDdz6Ef03UXOWo8Zun6cvWKPdF68xu+LUj5XZCl01?=
 =?us-ascii?Q?Vve/jVwAJgIhakU0gAW7LxFF+a6o2oZf520pC9O0ThUIUrNdR2j3XcA8GV0H?=
 =?us-ascii?Q?YHzLrm6i4Lem4EQyY/uuReivgkEZL1lGYREvtWQklTksJJ2RplMB7urlOW/j?=
 =?us-ascii?Q?/g4hrjNVkmsL7ac6B/+k7zbx7fsbj6eq6tX9tH+JdyL8pvc90+O+6QE+2zPZ?=
 =?us-ascii?Q?ugRTgxzlVc+7bnW5pUmS06yGhtyMmi2364wnniOgcK8NMt8Q4S3FuJLM3IVW?=
 =?us-ascii?Q?kYsS+yBlqgFnJQkyfRN/y2AVXuHCA13436sDg/UwTs0DB9TfN8fU2aC3EWHu?=
 =?us-ascii?Q?dEUeOc5NESIx9LnssLY2z5YlhKJ9LKid37HwTI6w2DXu+MZgaEiTLbjk6ZV0?=
 =?us-ascii?Q?mDU6sWNvQXfTtmKYoG5OYjWk4IrKGJX8Ekr+FOkzG84EV/ARWmm5Q4qIAP2z?=
 =?us-ascii?Q?c0wqoZO81J0rbSEHy9LL+Io/mnAVVoPPKZ4wjp1DQy9hj9/MFKOdeSugqx/C?=
 =?us-ascii?Q?Pe7/QDqGNngiKaVmxCsIvTyo7XlNb8lhR4uiNbovcD6aeA/hCXY/Wncis7EY?=
 =?us-ascii?Q?+dDBEUclGdwhmNLjnzojevMUve8zCZCDeOdYOa7IITenGHO2XQpM2L57pETs?=
 =?us-ascii?Q?WnQLd6gOqaIXSIUdyARfhfhO/336CXrJyYwCQ0M32yInGkzpZsLsJZpE9GtP?=
 =?us-ascii?Q?J3DYGHHEyEp5KpThx0QCBlDUnMMrD1xC89HyKFJ3IJAMyTSFZNpNMo1T6P1f?=
 =?us-ascii?Q?0YmquEs37x2XdiENWHAGfj4ili85Yn82y166jvFm3rPEwinXF1qoSlxwn8Qh?=
 =?us-ascii?Q?mwcLWnLKba/BqM4jJ4PELr7u6hGdllR6J6AJDGSW3JTYz/NDjnlA/I9YSIXh?=
 =?us-ascii?Q?s2yRQTQErTPLMpo2No7GKaDdxRArVIlzqB5cSazzIaiB6CHglyO0/coubwfa?=
 =?us-ascii?Q?P/XTmSL+YKGJXCVxDBd3T2m4AgufUrCUpIsUsuAxoNDqQEsorzSi94p6qgfd?=
 =?us-ascii?Q?1l9dU1J55pAiRW6/xeNUwHSb3lrTxu6trvkeUhEHid0EU7exYfVG/V4EHzN1?=
 =?us-ascii?Q?4OJfr8/P4kqoXmClbeu0UaQ1QmK5LjAnL3nxMyIgadWLywaCg0DQOYKqrd/+?=
 =?us-ascii?Q?EEn6qRRaaw/+O6ShJPsPWiLisEsn1KHZkMRzklojMANdQv2lYI01IHimGHW8?=
 =?us-ascii?Q?604tdR7sMuTQXYGQ0KCtymfllPv/Jj1em6GtEQUjAg6621AaeAgQDAsv322Z?=
 =?us-ascii?Q?HsAlV9RJzYty9Pa1f9m6x8ylRSY1bnGnmubRxEV26wP1DOUgH/fm6MQrp06w?=
 =?us-ascii?Q?Jfnjr6XIz/9Pawx3u8VcHwxGf9bF/3hpOqtKRr9KqwG8Pw+VAkWiv7vxZa5m?=
 =?us-ascii?Q?dLWw/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c643b81b-fe23-4989-6133-08de204e34b7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:42:21.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htT8HLsyv/9gvcUKThqiGUpLTVEy64j9HqjGFq1IgDx7EYvayBbVv+B40C1mCIRFjOWD9qKQF+7060vOQl+c/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278

Hi Horatiu,

On Mon, Nov 10, 2025 at 12:05:34PM +0100, Horatiu Vultur wrote:
> Allow to invert the N and P signals of the Serdes for both RX and TX. This
> is used to allow the board designer to trace more easily the signals.
> 
> Horatiu Vultur (2):
>   phy: microchip: lan966x: Add support for inverting the rx/tx lanes
>   dt-bindings: phy: lan966x: Add optional microchip,sx-tx/rx-inverted
> 
>  .../phy/microchip,lan966x-serdes.yaml         | 24 +++++++++++++++++++
>  drivers/phy/microchip/lan966x_serdes.c        | 23 ++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> -- 
> 2.34.1

For context, I am trying to describe the lane polarity property
generically, and I've already blocked Daniel Golle's attempt to
introduce the similar in intent "maxlinear,rx-inverted" and
"maxlinear,tx-inverted".
https://lore.kernel.org/netdev/20251028000959.3kiac5kwo5pcl4ft@skbuf/

I am trying to find out all there is to know in order about this
feature, and I just noticed your patch, so I have to ask some questions
in order to understand, had a generic property existed, whether you
would have used it.

So I see that you don't have OF nodes for individual SerDes lanes, so
this makes your device tree structure incompatible with simple
"tx-polarity"/"rx-polarity" properties. Are those something you're not
willing to introduce? What about other stuff that's in
Documentation/devicetree/bindings/phy/transmit-amplitude.yaml?
You also won't be able to make use of the existing device tree
properties if you don't have OF node containers for each lane.

