Return-Path: <linux-kernel+bounces-764736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7550B226A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B79188860F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F801C5485;
	Tue, 12 Aug 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwNtQSAr"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B11885AB;
	Tue, 12 Aug 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001121; cv=fail; b=KOIueB/8XFBeqvxvA8gJj3J+8gx/oR/45MixcYPLWBXJrywYRS8wRxCzg4v8sZDMQ9hV73kUHALormGZZBGeSEZujR/aWnpeuaZDNA+s2aDaLA9EBVOu/SahxHeQhH5hVmTPmJPS895dlgnPKpTQvHI6UD3SN/cigW0Kp6KzdXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001121; c=relaxed/simple;
	bh=TbdfWP3CABeqSSuYuCbRtWmGB/XyUv+EAsmAwnE84lY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ShwvfVrW2ZnbId3iAMTmLhFNy8s2i77nCasbFWx1UP8fWeYmD3o0FvHL5JYh2LAJUb54Q8dAYzwtq5ybl/w6CLz4VVTrW5IyGZcLFsQWaljxrlXMu51RKRvvHHGtFBIkZPH9MCyP2EL9PCErrQf0mjy3hnlGXS9BbSMmFs11DyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwNtQSAr; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x47T2DlFZrUlDE6izu+JrJ/PYo0rSWnSb+9RTTgrf21bTX6GXuluPI3h3ipQwZ1UK775lCrhJ3Y2zy7+Iv7U7BTwCX3e2Z4IuZuxwI6qY7nPVyH8l0zzKD0PQGXDAkP7trJukBUuCrql1G6GleUxCsIhws6dRb2bw+z3o1KmwcUmHR2iEzwE3TvxvUo6boyKy8v+C4QCqOqJGp+ug2DGMAL2tileTZQ7jOWojj/IyLcqsMtegWjrn5jNlzuIVyKpCqVIb0kSq4YFBB7n45Vgjwb/anLgFBmuaS39GdPCwa5E/Ebe1/g3+pQBT3RkgdbzfH8Q+kOhWOMYdhlPWiYaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOJlceSj9mAlegOUIEuhaGW9d/dp0W56x5pRLXEMOII=;
 b=C4TXHUxf9WLs2qZVGhi2TDNBpCWBOaCSu2ZI4P3Ku6OUchlx79jP14Qws3tEF+pBQ0lmkEUNlrybrPnh2G/6Ws+F7fVE8qs8t+hQJU6XsDSo+gw2nfieELBuvI7JPhzdYhV3RF2UnI9aWmBzkETn7ZRub1AaXTKfegyH7axh68fT703swCPuWB96v7gmN0ndvutzhnD0l6IoV42pIyReJVcw9NpB47RionfXpW+d6ZC4Dr/QC6Lk75rUJ4E/BR5UtjRcj9di/xqdNXh4jnS2mQGBUKfoXCIZmhGI7Gtd9cTc400fMrx9x9ax962XhTKxAj52q56u2UAJGWlZqfh6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOJlceSj9mAlegOUIEuhaGW9d/dp0W56x5pRLXEMOII=;
 b=UwNtQSArx+fCcWpA7nA3PK1/Oz4zGVTfKMA3Tc08Q0MNKdAQxZi5mXRg2rrh+HLjAJJTO932N0cxvA2gsoq2lxf372u9j5Bco9m3VWPdxLYMHmL7ZgkeSHYY5y840QCaQpmUl2mK82hsNjdbFccgp+huT82LY4gNbbyM7A10hanCh7ZR2UVkDxgktrq0A8MRgFGy1whLyqUj6lIo8ewUlwGLhD2Cjng4pqJn7BTK11NIHvJ9Ew2FWS220oSgZLAhHQ8noj+HswE+7zzSivHwo5e+LsTL2ymzYq2Vsp5DyUw8aQmii885vWo4LVYdFyIyWYmwEEYOXzo8n1KtLWJ3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:18:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 12:18:37 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 12 Aug 2025 20:17:05 +0800
Subject: [PATCH 1/3] clk: Introduce clk_hw_set_spread_spectrum
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-ssc-version1-v1-1-cef60f20d770@nxp.com>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
In-Reply-To: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755001109; l=3904;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=TbdfWP3CABeqSSuYuCbRtWmGB/XyUv+EAsmAwnE84lY=;
 b=xDDoo3ycp158kxQAGmAw58CrldaAPgn0YZwyhuQ+EPF9aUFz/KeilxHt4GfeHMHIMShVxxq1k
 FZfMrBhZhWaBnTrPXYjXLS227Yw3QSmf7HaBGF6YEk71EBNla9Pgkad
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: ced1c75a-0485-4d01-a75c-08ddd99a5d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVkTWl3SWZGY0lLR3pMekJPelM0ckxuVEdFMGJtaWxjNy9iei94QVdsN0da?=
 =?utf-8?B?TnFNVHVTOTVFYnkwY2xsTloxMFh6T3lQcEdJZlMrZ1VHY0hiaXM2R1JsVDBn?=
 =?utf-8?B?OHNCMHVpTXg1VkdPRysyZkRENWpZeVhqQmhkOGkzcFlMR2V0M21nT3R2NUxK?=
 =?utf-8?B?MDVWQzZZT1A0Qlc2SnhyYzUvVjlBZkd4cVEvMFdVajlZRWhvSzVJQTljV2ht?=
 =?utf-8?B?N3VPMjg5Y0FCYko2Qy9RbjMvSnJSSGQ0SjJ1dmc1QWs4Uk5USVdKcitCNzFJ?=
 =?utf-8?B?cklUVmt0emp5WEtnM0Rqc2dCSTlYS2J3b3lhNW0rZ0pvNmoyVThRWmUwbHlX?=
 =?utf-8?B?c0owK3g2aUJjSkJJS2lhOStvVXVaK3BLQzNocWQ4TWxneEJRNnJtMEhQaFBH?=
 =?utf-8?B?TXhOZ2psNlJNVVNIRHl1b2JaWEhDQXovem9MUHRVb09kSmJVNTR1WTVaci9z?=
 =?utf-8?B?WTdIRWhjT3d0aGx5QTlIaEUxVHlZQVEwODNBVitnclN3cFdBTnRhR0FSYlov?=
 =?utf-8?B?T2l6dElMOUNoQzFoaHgxekVDbkZ0UmloZVFBZy9zdWVwZGYzbjExdTNzZXVQ?=
 =?utf-8?B?Y0pTN0JYNVpTaHUxR3pVZURLYUZKbzFrdUxyRDZQSXRkT3FIMjhicytwbUsz?=
 =?utf-8?B?d3EzMVg1MHM5UGtGbDZleHRzclQ3TU1IZzl4T1ZqSWNhOWxaaHRoZkZISVg5?=
 =?utf-8?B?Q0NQdE9FUW40R1UvMXNyckRqN2lOSUJUZ3pVUXhiblB1U1E0SWZlYVE0alNU?=
 =?utf-8?B?V2krT1lBUEUrZW5vRC9Ic1lqUUJoQ3ZEblRXWHRYYTdmck1ycUxCRmVzem10?=
 =?utf-8?B?VFBqSlNzeE5WSTNzZjdLZjJGMUpoeXBjbTNpYTBZSVVVb1pWRVRnTTFFMkZP?=
 =?utf-8?B?dS9iQmVtaXBSL0R6SElGUG5mVjdmMXNnSmo2TmNma2FvSWdrWjRnZHFDLzc5?=
 =?utf-8?B?NDNVYlcyOTUvK0Q3TVNuM2cvUVcyMHF2dzJiYjZTc0doUTlCMHZ6S2lNSk5U?=
 =?utf-8?B?Rm1zZG9HRlc4LzR1ZUFXRVF2aDZWeTMxUnhPOWdpVWlLaEdhMjlIODZ3b0dV?=
 =?utf-8?B?Zy8vZ3RMcGR6RkZrUjhuOUhEMFRXSGdMSExGUnQ5bmZmR3cxOVRYa0RaVGta?=
 =?utf-8?B?M1ZQOVFWVERsNlBwYkZ1REpjZDU1Wi82UnJwajIyRDl6dUYvOW95VUU5dU1F?=
 =?utf-8?B?SWQ4OTVyZ0tPUHVrbVhldHBDU250Ui95V0NicTNrQ2FkMExIa28wQ2dWanV3?=
 =?utf-8?B?dnNjV0JlcWpSQVpZUWlEa2Y3VkpXZ0g5aGg3S3F2S1BIdDVwekdsQlRWTEpx?=
 =?utf-8?B?aFJFQStvby92S0JSMkc4MndsWkc3SlA2eU9UazcrOFhRRkVpVm8rV0tSOThJ?=
 =?utf-8?B?cFg0NXUxb1ZFQ2FyZVloeHZNOUlkWFVpQzNYcVVlQllEL05TS204NXJseTlB?=
 =?utf-8?B?d0JQdWp4c0xHOGdJZWRmclBKYkJvV0wwQWVDcHhrTzlQY04wVTU2dXhXdXlx?=
 =?utf-8?B?bmtrSDg3SllabE9ROEh1M1lJVmtXeUtDM01VODYvVjdIUFhSMENVQytEM21E?=
 =?utf-8?B?NGRxWWdXQzk3NVNpbGQwRk5sUmVBajJ5Tk1TanpmWFEvMm9BTjdmdG5EMVBx?=
 =?utf-8?B?UkVqWHBMcFdmSVBjUmlCS09tQStjNWphVHFHbW5rZE9IanBQVXdHQWVzM25E?=
 =?utf-8?B?NDBvRHJkZzFjeWVIOEJNZ3BSK01UWDBCMDI1bTVsVjhUeHh2TWJUWXVNMndj?=
 =?utf-8?B?anFBbytTWHFqa0J1TFZ0eUQzWk9iaHlUZzl3VVBuSlBieisrd2kraVYxS3RG?=
 =?utf-8?B?Sm5YUVV5V0hHYndUbmdaZGpCT3hwdEZLOWpkdEwrZVZxTUJsS2s0UmUvZEc1?=
 =?utf-8?B?cGlCbkdOclYzbUlsbTg1Z0U0MVNTWmljVUdRa2d0bWMwaFBtdnZuNzllNHBC?=
 =?utf-8?B?K2RKbE5LWGlLd2pzMWpHemJScUxidTN1OUhvaFByQmt4R2dveXZ0K1RobW9H?=
 =?utf-8?B?NzdlZmpXaHF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellEQ0tmOEdWNkpYUms3anpYN0loanFHc0JMd0hJOTVXeGxGUm1Bbi94SmtR?=
 =?utf-8?B?Y1paOVVvMFY2azZPbHF0VDlGODYwWjRkY3BGcnp0aUhaNURYSUVJN3k2cytE?=
 =?utf-8?B?dGZqczNLUWpIdGgrM1BJNUt1bmtiWmsxa3pma0JZUkwzY1Q2TVhkSzVXTllG?=
 =?utf-8?B?TFlwaVVoYlBsSlJNc0xIYUVobVM0ditVN1FYL3ZwSkJ1QWhZNUlOUEpyR3lm?=
 =?utf-8?B?anVOZm0rTm9sOFVZT2hnZHM3U0NRWXJjbUwyalp0NUUrMXJtTS9jVjB4QUEv?=
 =?utf-8?B?dWhVdHRndFZydll1U1pDdjBIQ0c2ejlPTW5EdmtjQk1mUU1jTUJ3S0pLSjlw?=
 =?utf-8?B?QVFRMUVqY3lURWxqWEJtU3YzY2ZmSUtoVU1kS2xTU25oQjIxa1BXTG9MQThC?=
 =?utf-8?B?L0lTSEZURE5OQlJSdzlzNlpLRDM3TXBkeXFJRkdOTjh5SUFaeGw5dm80VEQ1?=
 =?utf-8?B?V0NkeDdFVUpzRG1vaHdEWFp0MWQ4cVhmZVBvVWhZZGkzRVdXcXNVeE1hM0Np?=
 =?utf-8?B?dTJsS3JnUmNxVWhHU2RickdYRTQ5RnRlaW5KOGJpMEtWc3ZxWWRnNDczeVVC?=
 =?utf-8?B?M2tkNElBRTkvUFI1dHNLQjBOVXhzVFM0YUg0Z3BVT2Zibno5YW01OVdseGpa?=
 =?utf-8?B?WHBkYTBIZmpXWjJrNWZKbGxtWEtqQVR3TjZ0Rkw5VHFzZFZYU2QzQjVDWTRy?=
 =?utf-8?B?YVdOQzJsSkNmSE9KL042TFhnckswT2p5RUt2eldMSEV2VkNYbm5Ec0tuQ01T?=
 =?utf-8?B?NDFGbkpkdDhZc3kxY3QrQmEvUWZrT1VXMEN2d3lwbndwZ2FGdGM5RXFjQkpP?=
 =?utf-8?B?VkFGYkRSL3RBQzFIcC9uU20rWlI5aThHNXVFSC9sOGFOdzhiYVFIcUgyUnlr?=
 =?utf-8?B?WkZIcHR5SFU5YXpWbEhoVFppaXN4RHl6RDVEQjlpZloxZG9JRVQ3M3BtdFhr?=
 =?utf-8?B?TjJuajFSS01QeXB5TnBZcXpuSWUxc2RLejI4eVJvM1lOZTBLQ3dlMnkrdU11?=
 =?utf-8?B?VjYxc2VNUHR0S3N0ZU00MmtoOEJVbGZlMzBVMFA4eE5ITGNJdEVPRmwxVDZK?=
 =?utf-8?B?SFhJdG9ESHNQYjdtRUNqbUpQRmk2eDRSdC9zbnMzdUJld1ZCQk1lbnB2VUha?=
 =?utf-8?B?RlE4aE4vOUJMb3Q3R05hQkgwU2c1MGd1amdDOFRVdWV1YlhwWVc1dmRuTEtn?=
 =?utf-8?B?d0I4V3J0N1ZicGhOUEVrT0lxeWdlTmsyZFM1T09BZDBHT1hWQmNwV1d1bDN4?=
 =?utf-8?B?Y1oyeTFmNGJ1WTNvWFI4SGxsMm9vUFM1WWVvQjgrelRVOHRFaFJReFBPRkFi?=
 =?utf-8?B?cU1IaWhCYUJEK2xDRldQcmFOaFJ1dGR0eDZWRnVYSVpBWlNiYjBHRkFuOXUr?=
 =?utf-8?B?Sm1RUEZsQUVEbXByWTI1L0lBcFRzRDVEUjlCYkVNV0p2c3VYYkJqdDY2eVdn?=
 =?utf-8?B?T2cvU21RSHp2YmJ4YkRabEIrSUZLUVlhbXFjZko5NG93UUxtMy9CY3UzQUtU?=
 =?utf-8?B?Qkl4aEtpUFNqMUZYTUszM1haY1I3OU9CSTZ6VjF5ZlNESFIzN2Rwb1Y0S21X?=
 =?utf-8?B?ZVQrQ0JtL1FQZG1YTjhkR01IdGp5bVZzczE1M0MwMWhqT1YzSmFMZXVYWS83?=
 =?utf-8?B?dXN3bXBGeFh2VFh1VTFRQkk1VXgxWlNkYUxRcFhXOFAzcDNKRkJreS90am1X?=
 =?utf-8?B?WHFUN09zdk0vTFlmUzcwNnBoZkJ4TEdrWDNhVXNLWExzZU82dU5vdlhZWnA2?=
 =?utf-8?B?clZTKzlUUDQ4bmd1U00vY3FrVVRrUEdRNE1DRXZmUjhFc3djdE1ubFlNWTVE?=
 =?utf-8?B?ZUVqS1dYRlU5QytVaStLd3MyL0Z3MHpsNTVlbFo3TENuNERVZ2lCWWdOaEpP?=
 =?utf-8?B?NnBaVWQvL1FBVXVXMmZ2MWxJTEhCYWdUVFFFcitVYUFEcUFJMTJndjFiaWEz?=
 =?utf-8?B?eHJKanZYR2FzeUR4Q0xucjJzV2M4R3hNVUZpRzFmYTF5MkNBaXpKdDJjZzBH?=
 =?utf-8?B?eklCNlhlNWNNVTJ4VEF5U0w0S3ZPd1NqVHFsMXJKSFVSRDlhYUFmOHFFR29p?=
 =?utf-8?B?VGkxc3pNRjFoaS9LMHVpTTlrbjR5bHVMbTYrNnBOdjhaRE5qTm9md0VLcGNL?=
 =?utf-8?Q?3EBlY0ehGxMmHk+asvCAmbcC4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced1c75a-0485-4d01-a75c-08ddd99a5d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:18:37.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRwYKHYrcML367LZrzAgHZl9+bGksPfRSDK29dDHBqLLgjRxu0J81H+fNqumRTWwg7A7rmAi5rSNsyA1NgwBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721

Add clk_hw_set_spread_spectrum to configure a clock to enable spread
spectrum feature. set_spread_spectrum ops is added for clk drivers to
have their own hardware specific implementation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 32 ++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..48c7a301b72b30fd824dae7ada2c44ee84d40867 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2802,6 +2802,38 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, unsigned int modfreq_hz,
+			       unsigned int spread_bp, unsigned int method)
+{
+	struct clk_spread_spectrum clk_ss;
+	struct clk_core *core;
+	int ret;
+
+	if (!hw)
+		return 0;
+
+	core = hw->core;
+
+	clk_ss.modfreq_hz = modfreq_hz;
+	clk_ss.spread_bp = spread_bp;
+	clk_ss.method = method;
+
+	clk_prepare_lock();
+
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto fail;
+
+	if (core->ops->set_spread_spectrum)
+		ret = core->ops->set_spread_spectrum(hw, &clk_ss);
+
+	clk_pm_runtime_put(core);
+
+fail:
+	clk_prepare_unlock();
+	return ret;
+}
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..2b6cebe8b12268f537b3c92aa0bbadea601f0eb0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -84,6 +84,26 @@ struct clk_duty {
 	unsigned int den;
 };
 
+enum clk_ssc_method {
+	CLK_SSC_NO_SPREAD,
+	CLK_SSC_CENTER_SPREAD,
+	CLK_SSC_UP_SPREAD,
+	CLK_SSC_DOWN_SPREAD,
+};
+
+/**
+ * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
+ *
+ * @modfreq_hz:		Modulation frequency
+ * @spread_bp:		Modulation percent in permyriad
+ * @method:		Modulation method
+ */
+struct clk_spread_spectrum {
+	unsigned int modfreq_hz;
+	unsigned int spread_bp;
+	enum clk_ssc_method method;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -178,6 +198,11 @@ struct clk_duty {
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_spread_spectrum: Configure the modulation frequency, modulation percentage
+ *		and method. This callback is optional for clocks that does not
+ *		support spread spectrum feature or no need to enable this feature.
+ *		Returns 0 on success, -EERROR otherwise.
+ *
  * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
  *		is expressed in ppb (parts per billion). The parent accuracy is
  *		an input parameter.
@@ -255,6 +280,8 @@ struct clk_ops {
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+	int		(*set_spread_spectrum)(struct clk_hw *hw,
+					       struct clk_spread_spectrum *clk_ss);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
@@ -1430,6 +1457,8 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, unsigned int modfreq_hz,
+			       unsigned int spread_bp, unsigned int method);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
2.37.1


