Return-Path: <linux-kernel+bounces-889329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37921C3D4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DE188B379
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7434FF54;
	Thu,  6 Nov 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wvfdd9nL"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93817351FAB;
	Thu,  6 Nov 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459069; cv=fail; b=ng0hIHeXDwolsNbHRe+Yr5AKK5ZwB7OfepCjKA664ifNhYuw4eQV5H6+tpO75vJFnJH/rA3v5Y5EqUfGMBjIbARdb1JLamN/nHXPep+j6eHMGW42hkiDUlqhMA6GegUYwbnEyrdEtDlGvF5+LgmX0FRpKlV3ggGmj5xZ1NlNJzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459069; c=relaxed/simple;
	bh=h7NxkbAMMPYMkHk1k5MSlwVDi0sevBksMHAVgZPxQoQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XV+o8RobV1QdcdsCRZ54OJAWUPz48tdgqpK0e83d4IOr1BrqbhbFlpZjkgWZT6IcqNsohpKdgNM/06AWXwn6QIFfrvrSBxx5R8d12SJ3qSnW+Kiv8N1cWV2whkhON81yW8uVaUUQZ4tgKr/IoErQtqTGWPGQcrZK1Vds8i3iYkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wvfdd9nL; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nq+in71QZ8OHKGr5/j0ZTsws/BXr8TDoaLvBRkLsHxlQ7NP+RfNb0lyfofImmsm9bLhb7tjrdcgM9RsDSqn1wLp8+tm0KoFe3DfrmbYmZq7V3cPmFQ/cVrUcb6GCD9xHnGEAJ+5hmehdrlOb1iGmpgmtF/3PO6fOliEeaboZBBg/hsUJI9a9P6hD8VqwWK8PcxAfVmOA607Wws3F8I4UQwO21pTZiE2VCZ7sfNrppFT+j8kLjDvCW7wYzg4hGfa0WKe4B/xxA82PE3gaZRH1ygYgKIvm8UHbNZyfNVQBkx73uIiMXtQz01eLdApN947PC9tZWrzZCbbHL8kSSkmwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvstXx/lAoUyOUCYcSwSuJC361zeEuspxrO9X9aXvC0=;
 b=J+txWZ7CqiOmSRsQHI/Fk1i1r+Jpf/lEKnN5v4ZrGxTy+WZQQAfi0NtDeywI5QuanUhqFEyiuGnzUjNGuge5Skn6Ua7uH9W3855t1nVKvvAoraWdU1FXLZbh4irxDzuPFvatEzXrLLRxc9QY5brpo+A+bSzx/I3W9GPjsC1ZBou+EzMyNokggK2JKhor1zl9QvVQsoddqERAZ2gYBzTFTMuQ/sEj2Anxb/2kr332QKC7kP7jxJiK6SG4EdVLUQCh0CwBA8bLFSaBOM3NJWN8wRV5V41dlsa7kiPKVGjgPFF6f6Nlv51/mFpGpEeMboyxs4vjtL5IS521mKYQbHJ4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvstXx/lAoUyOUCYcSwSuJC361zeEuspxrO9X9aXvC0=;
 b=Wvfdd9nLOpDjqOM2ckF+Xm+GhHfHJXJWNPIBJzslMksb5YFJFq8e9CQOgPipFdu1L9A4hK/ns36pLcRoFbbp2BY1ZiV8jbkkqR8Vqcb4HdN4AnR8koLddC9mONC136ArLpgsJBOAP+GoNjVoCMwcgDz8C8LuQ8JbqjkK2INhFMbmraNCJcUeNGpQzr4vnUJhbRoc2WeFynfvOoaZECMiSN7xQZIXmVX0/YNByCQT39u1aRcVzF/ALlzKjxagg4QvSwlYJwGpFSM2FIaulsQilDuvy5Spxla36fnnQgrNn1X5qIHS7+e66s/WxyNGabyhk8u9yB3xZu5OhX6yOF1LZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 19:57:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:57:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 14:57:21 -0500
Subject: [PATCH v2 1/3] dt-bindings: clock: imx6q[ul]-clock: add optional
 clock enet[1]_ref_pad
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ccm_dts-v2-1-12fa4c51fde7@nxp.com>
References: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
In-Reply-To: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762459054; l=2234;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=h7NxkbAMMPYMkHk1k5MSlwVDi0sevBksMHAVgZPxQoQ=;
 b=j05vTQFAcTyBZsTD3CSphFA/2OEX1m1Wv56vs/zFdGf9OO5VQ6QiVDIOLobhlT73Ma0aLcf4G
 ZdfS9UYDAIJBP2wvi1ZpKcUde+DyUEafPhugJ45WYPeYSMBTohcoNUl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcae3a5-9a1a-4ab6-5aaf-08de1d6ec005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlltM1RTVURYbU45Ry9zdzlqNFdPS2FSUTNFSUJyRnBvYW52Um1nS3pMUnFF?=
 =?utf-8?B?bHdQZ3BvUlNCK2FZNlg5cmFjTDhqcmpZdDQvMUE2MUxjOEdkd3RxM0RiOWdK?=
 =?utf-8?B?TEFqNm55WXhmSDZweUZHSjRLTFdSTzFKaEIxcXlwaGkycVdVNnoyUnN6Vkda?=
 =?utf-8?B?L2F2VGlrVDFzUmsvWGc4b05HbWFVZTJaZFRQNTlFR0o5VnFWMkNoRGZPSEJs?=
 =?utf-8?B?MGxpM2JjYzRVSUpCQzUybzFVMTJyMVZ0WHRxckdZU3lhWERwdFFIQjU4VkJP?=
 =?utf-8?B?UC9DbzhWWXlDMUY1bHdwMUV3MEMzdEtJaVlMSUV2RUcyV1JQVEcvdUNLYzQ2?=
 =?utf-8?B?cGVwUTRRWXhrL2FxWlNnR0taSXZYNi9GS0JlTTB1SFg2WkNiRmdnOHlld2U3?=
 =?utf-8?B?eGRxcGt6YWhJKzRublhvQzJvSy9tRGhjUkZpUlh2ZEdVSVM1RUpkYXBybUlx?=
 =?utf-8?B?Yk9pQ0liZjNYZGZzQ2picDdJR0YyazVOcVJSd28rVGs0ZzdCKythRHQ1WXhU?=
 =?utf-8?B?Z3l5bzVnVVNQbmRicml5YVdEMVVreXpDckJiSkxieTRCNnZSSzlXZzlYUTJH?=
 =?utf-8?B?aE1zWUNhdTE2eUVwVG9tVkVzQlRLZ290eFBTd1BXQ2RIRy9XaVJoTTlUVllQ?=
 =?utf-8?B?dmp3bzJZcThpK09jQkhwOWYwT2NOU3lEU3FTeUhTdGloaXFsaVFJT1hMbTdm?=
 =?utf-8?B?RlF4SFA0eGpCNFlOcGVmRWY3RDMzZ3YwaUtsNE1IMkJWaXNUTlpBNlRkR293?=
 =?utf-8?B?dmk0RGY5bHIzdjNVSTQycUhyb2ZxdnRrei9YUzQvYks0bWh5QkxRNlNPT1o4?=
 =?utf-8?B?M3FTZUVzQ3REWWlxRUdDQ0duRi9UYm1iaEgvMGNuR25hRXlZUFlzWU9uOE53?=
 =?utf-8?B?emJKMnk5aTJ3bWlQVGhzVzVsa3l0SEI0ZnJIVlEydFZ4eFB4Y1JUS0gyQVNK?=
 =?utf-8?B?NDhCZEUyTGIxa3duRkorWnpqbEhwQnRaYURVcmtCbWxib3RCeGUxTVQ0UDU0?=
 =?utf-8?B?Z211ODBXTXJ5dTdkUUNDQjlFWWNYNTNjdy9mNTYwVmVUcURXL3VHc1UyY3Zo?=
 =?utf-8?B?TGpGRG5TV3ExWTNVc3MrMFJRSWZJR3NLbmdIdHVaTTNyT29nZHAyQlBDWDU0?=
 =?utf-8?B?MU9QMW1RVk55dUVFK0hoYU5PdUFjc0hyS0h5SXY2cGhJdEwzMWxYck1NOHJP?=
 =?utf-8?B?WHAxaS9mOVdOS2FncXZ4SlA2YytUZjVYUmZUbXBKQTJES0U4RWw0RlBud244?=
 =?utf-8?B?SW1PeGtNOTVRV3VCMmlUNkx2NWplT1UrVDFVaE44YmNPM3N2K3VXVDNUQk5Q?=
 =?utf-8?B?ZDA0bjNReTZCbXR6SjRnY3JYWG1obi9uVkZDZUZLVS8vSUpJRU9pZE00L2ZO?=
 =?utf-8?B?WE83NEFsUEE3ZFljKzgySkJ6QzZTaGN4eXFBMWZNcEpzNkhZRGpNSko0TGJM?=
 =?utf-8?B?UzRyd1BjV3lPRjl2V2ZWaGlVSGZTcnlSeUdCZVpabTZmUFhVY2JQK1kvN1pq?=
 =?utf-8?B?UmRtNXRMMndGUHJxQ2JoK2FBR3RjMzI2RUNRS2tsMmJVT2EreVVwRUp0SWti?=
 =?utf-8?B?QWQ5dlBnbVhkdlduSCtIVmVJVXdQR2toOGtQZnNHdkkyRjJ6WUZQZ3htaEM3?=
 =?utf-8?B?V0NLWkNFbVpyTGE0SEZTR3UxYnBPWE16WkJCSEoraFRONTlIUC9Fd0hpaEcv?=
 =?utf-8?B?OGJvZUFQRG42RW9OWTdoZzdRZlI2U0J0dGNqTGpvOTBVZzgxWHJQQ0VXekxK?=
 =?utf-8?B?UDBYVUZLTXViSnNaY04yUUZmQ1BpOG5Jak9qbDhtenFDeFU3RUNpMEg3bTlG?=
 =?utf-8?B?V2hQK2xzZk5HdzdsUVBWU2piUjdQTGtKNWR0YU9FSy9YbG5CRTgwSTJ3Tk9S?=
 =?utf-8?B?NUtuVEV2VjhYN0pLN09kamZWMDR1TmR6OVdsbGRnRkhia0ZuaFVLZXU3d2lV?=
 =?utf-8?B?elI0QWZ0TFVrcW1HK3cxZ1NIc2U5RFdXK2Jtd3hVcGFzdnZHV0pZOXV6VHhh?=
 =?utf-8?B?VC9LZnVqYmQ0OEoySldEYnhwUVNwODJzZGpLcW5xcU1uVlhoV1RITElxRHEw?=
 =?utf-8?B?dEFOQUd4U2IxSEpxcU91dk9YMk8zNDA0N2hZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjgxZXdOd0d6MTdJTGpiNWJoUjgyckVPZU55OFpPNXJFZHV0RUQ2a24xaUtw?=
 =?utf-8?B?WXQ2NnRVa1kyMEsycG42SnVVS2xjNDZiVjdZRzBwNE4rZm1SMWlPYVFIdDRI?=
 =?utf-8?B?dGNNZFRNbk9NMzlJMDZoTGdycWNzNHY0a1V4c1JQb1VENENsVTBiZURaSmFL?=
 =?utf-8?B?cTJsUXF5aGdveksxOVhKUjN5YUtJdkZLQ3RvM3ZFUm1UcitDcXVFQkJmbkF0?=
 =?utf-8?B?N3lTUklrdW02Y3puMUFsZUdPT09UWmJGeVQ3VUR2clVZVWJPaGNweUZVZGNU?=
 =?utf-8?B?ZXVHNGVJRjJZcFVUTk1xSEh0cURKczdNZ3NuTWxpK3BsNTlqRXdtRHdJUmhI?=
 =?utf-8?B?bFZkS1ZJc2dFRE84N1lxVEhaVUJxcml4SGE0Y1hyNVdvcHljQmFmajdNK25a?=
 =?utf-8?B?T1o2ZGRFWXhxWHRmdStucTlvZjlyS0MzRk9FRW1OdW1iVkYvSm9GcWhsZFBY?=
 =?utf-8?B?ak1NbkxuT1Brcmlmc24vaVNzb2FRYk9oc0NtVll1U01IMjdwdWlkOXMwdTl2?=
 =?utf-8?B?TlJqaGxzU2VQRGNOamtHQXZxMjFVTzRRVWl5OUhIZEZYWGdiandVN0xpS0E3?=
 =?utf-8?B?OEVpQ3E2bjlUMU8rbVJoU0lqbndBekp6aFpRL3h6OEVBYkVFM0gySGNwdW9a?=
 =?utf-8?B?Q3J0UkhpZ1lEajZrYm1UdTFDMlUxQWVVQkd2M0Jxc3k1aWlKaFFES0RVcFEv?=
 =?utf-8?B?Y0Ntck9POXN6MHJUczBqRk9DNHdIbzhlWmIvaHJFclJyRWMvUUdZMUpJOFhp?=
 =?utf-8?B?OXBIaW1QZE91c0VuZnZqZy9kSUd2ZGptL2toS2pJd3FnNzZqTWpEMkpmQmJs?=
 =?utf-8?B?SitRSmpRN3l5cThoR1AxUWlTQng5TkZVN29PMS84V0ZobkN0QU9nQzVJaXh6?=
 =?utf-8?B?LzZ6c1lFWXBNMEFRMXUzdkZvbVMwRGwybXhUbmtmdHFTWjVsM0doUDBSN2tN?=
 =?utf-8?B?dnZKeDBhTlJvOWFtN0JmODlDYzdVUklCZStYOTN2RjRESmtuQmlCekMxN0hU?=
 =?utf-8?B?cGxIa2J5aW52MHRkcUVnUHBXMlN3OVU3aXhtVFBldTZLd3FMSlVLU25USXVF?=
 =?utf-8?B?THpWOE1zM0FTeVJIRjZiMDE2SkUyQUN5V1Y0NXFZUnNkZmRwOHdyM1YzZ1FI?=
 =?utf-8?B?aUxVNlNMbjJTS1NuNHFVOVlNL3NNM0JxdDZ0YVlhUUUzSFd5YW8yWUFkbDlF?=
 =?utf-8?B?WTlBZjJiQVJIUnhTajZRN3lmNzlJUEtwbWxvc0w4NXFtbzNTRXBES081QVd0?=
 =?utf-8?B?NlZVblZtRU5WTk96M1Z0SWJNUW1zZDc3VVpFUktyYkpqdUxkTzBaNkFsMGhT?=
 =?utf-8?B?ZVdyOXFtVHU1Wm9DR0c4cHZHdXJSQWlJUUIrSlRHaXFYU1dHdGZqUlNHL3V0?=
 =?utf-8?B?SDNTVktESFBOL2IwSkxJb1p0d1I1YjVRVTdIWjRWaTFzemJsVzcrTkJhOStq?=
 =?utf-8?B?Szd1VmhZYmxJQjZQc25iY2NCWW8rVXlWWXMxbHAwcEtuaXlDUnFUblAwcnFs?=
 =?utf-8?B?OHFKRVJOeldEZ3QrcHJNUFZ2S1FGdW1qN0kwOVprRmF3V0JObVlTS3R1b3Ur?=
 =?utf-8?B?azdGVDZTdFhNMVdFWHkyKzVkS2x2OTdxMVAzR3B6N2I1MmJydG53bjRZdGc0?=
 =?utf-8?B?MWVjTE5zMzkyLzYyZ09HWmpNajY3a0VQdXdZZC92VENuQUJ4WjVTYU1QSkhy?=
 =?utf-8?B?YVNCRzhrT2dzVkpSSUdqRW5IczM2aDR4ZmZiWXdwNGZjWWRnZEV1SW1WRzJy?=
 =?utf-8?B?cGVmOU9QZ0RaVG1pcDdtZFpSZnNSWVk2cEFpTlRTTXBKYTBBMU5sZHJ1OVVS?=
 =?utf-8?B?c0R3L1ZpTFdpVU1adnNUNWtOZVpmREcwa2tXdG5wOVFQTUlLUkIvYVVQNWJv?=
 =?utf-8?B?dVcvL1dwMkRJWkFUUFZ6cVdCaW5RUlZybG5vU0psSGtpMSt6cUZiVmkrT2dJ?=
 =?utf-8?B?bTJpZXAwSzBEZkEvanNaYTFtY28zandaaVBOMjdLbXQ1TDBaRXl5SjRqVTB0?=
 =?utf-8?B?Z2hyaFM5R1kxVnQ5T2w5V096WE52THE1eVp4MlZ0bFRGS3FSUEdNamdvdHZr?=
 =?utf-8?B?dGtDZlB6OGx4eVVScjJFSU1lbzI4WEtuOERHbnlEN2g0ZFNWckNKWmFFVzFY?=
 =?utf-8?Q?3yCJS+vVGnPa3pNCsW7HkiX5E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcae3a5-9a1a-4ab6-5aaf-08de1d6ec005
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:57:44.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W76lN6f/SWjQU5qbuOG3YVNTka7sXIfLRldeCiQilu6VQ+m/n2oqNeGZaOVoyF3oVezKVUGwshrahH0DPDF49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

Add optional clock source enet_ref_pad for imx6q, enet1_ref_pad for imx6ul,
which input from ENET ref pad.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.yaml  | 4 ++++
 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
index cd3c04c883df4ab02af29582369757df36269cb6..e78a493ffa59050a1b4974c62b14cfd9c0eb86b5 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -29,20 +29,24 @@ properties:
     const: 1
 
   clocks:
+    minItems: 4
     items:
       - description: 24m osc
       - description: 32k osc
       - description: ckih1 clock input
       - description: anaclk1 clock input
       - description: anaclk2 clock input
+      - description: clock input from enet ref pad
 
   clock-names:
+    minItems: 4
     items:
       - const: osc
       - const: ckil
       - const: ckih1
       - const: anaclk1
       - const: anaclk2
+      - const: enet_ref_pad
 
   fsl,pmic-stby-poweroff:
     $ref: /schemas/types.yaml#/definitions/flag
diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
index d57e18a210cc1d8a836b50058613dfb0308fbf11..035002721a3b3b65fe67734e13b686b91539f328 100644
--- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
@@ -29,18 +29,22 @@ properties:
     const: 1
 
   clocks:
+    minItems: 4
     items:
       - description: 32k osc
       - description: 24m osc
       - description: ipp_di0 clock input
       - description: ipp_di1 clock input
+      - description: clock input from enet1 ref pad
 
   clock-names:
+    minItems: 4
     items:
       - const: ckil
       - const: osc
       - const: ipp_di0
       - const: ipp_di1
+      - const: enet1_ref_pad
 
 required:
   - compatible

-- 
2.34.1


