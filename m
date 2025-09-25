Return-Path: <linux-kernel+bounces-833230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28FDBA1795
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD9674164F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1B31DD88;
	Thu, 25 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4Hk8RqT"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9D279903;
	Thu, 25 Sep 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834851; cv=fail; b=QhVXONQIFr89THTUtHOfXhToxvF4Jkr8G7BZaxqkx7rHN76jIlX0o9A0fDObQ7nsTs8VzR+dkCK7jT4LMaHt214JQMBxM/gVIZYeeDDmHshYt+Bk7SdX2tZkTVE6fy6ZzpXU48s7DebzGu857TT25qvgX5kGfeeDRZhDILqEvbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834851; c=relaxed/simple;
	bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GNCfwHk9cdZviLqkqoU8xA+npl+Q/18gSzy9UiOshF/wZBbujEsnbxCw7Zz4JyyXgVpLJWUDlF7fW5tiDSngkHi0z/bmadxPB7piXQb7G+ijNuoBSRliFqfbxGFKnofQlWOSndmPT/VweCNX700Qx5nnoembC5ya6mwMfDKDrck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L4Hk8RqT; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMwIMm1RuTUU6g/zAK+uSzwJ5ez1G5U1XX3TikqzZ93H4uX3jT3zmk+WERnM3UL2NXwCpGoLwtKChDkW+f27oATQIy6eSX7dNsew++OrAG6GZTyWcYH5ymvFGOR27hsuwzc3LXM9SVp51A3brvj5I0O2QH0AKQKkFBN4utC+oj4MQEVSTb4m6XdGm4JagZ1rsrpXxuxuMcs4CB2LoLW97WIu2eW0RxaaAIEHXiIvIiEu7DDzenkbCyY20XGTeJhHWcypsI9Lgqb8bgDAb4uEcqulKkHCj+/gRqfOFeVIBYY+ZTpBUOUucarxmGwJ9hE2AdMnc3BjuJ6PacUqIb4mdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=kxlujuuAaBdVZkHgpfbJtzVen4EvvPETEjLuHiTyUGvBRg14VIGpVQYTnzGEM2BWDdD7TqhwzmzBzMUjrBH6rmFlUXNBxWbAU2/6FPqZnIlunwrHsgIssJ0l97FjDowKL5qQzXC+PUE3Un1mp6QQWoSeffRXU8PfEsntjTGC/8hP/EN8f7MSpqSjkNw5MPMU1OzPGvTjOFza+WvkKZYEnDOZiYwJ270FfXGwaMrilYzY+b55omyeEaEBUEx9LxyyERdbiT/nzWU64PEpqElsn5omfcCB4BOAvsE5MVe1XxaqO1PyX81WXclD6tI2psYlJdi2vsiA/tPsIxs2CYf0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=L4Hk8RqTo3/CxqRIRUDN4gUmR8NWbCAxL6/z27mXFwFHesXg8w84q6fOJDbWOjIYGIYqI42QFdRD0zk7oKc+vFC/zv8/0J9+XaBqQQ/dk8VZq1EhL0eknuFtGHe5snyXujy+sUMtjmoQhAGal5sIa695Q97pySEtu2pNihPhsj9L/v4FxMT5KMcGZZ+tbQ1jwAlWkddnUavo7bWS2AtOCKLmSqLCa1L0yueDhx97Vrhw1FwmyjuQ8m+XhlbXCfDFUGE+HjnyFzH+NsjeYxTtGUDEYHEqzjxHSCVSsnVC+loYUxpn8tDSOMUcV2BdS5sjOfKRZUJa3WN+Q6AUg0O0nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:06 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:45 -0400
Subject: [PATCH 01/11] ARM: dts: imx6: rename stmpgpio to gpio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-1-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=3867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
 b=leOGxRMyRBxvkTPckeBtuhSlZrf7A+wmC9AP64OZNrKpFJtVr4U/iSY/NvB9fKwon4blt5jO5
 Hj0mBdPwynYCiK8t6WOZ+x3+VWpiO/t/AaF1TAsBZM68N8Wy3nzMcEM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0028ca-3c94-4894-f9c9-08ddfc7875c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R01LZXpnaW9RREVJUGRTODlFU01LQ2k3Z0pqSUgzbnphTTlTSkdTRlZINTdB?=
 =?utf-8?B?MnE1YXZLdTgzdkFkbzdWemU1VTgzdmRSTXBVa0JKQm1pSmI1cmttWWpIMS80?=
 =?utf-8?B?WHdBUHZJM1ZEVWdLbkN4RnVPanNCL3dmZG9mYVhOMC81QmF1WXFZK0dVWWQw?=
 =?utf-8?B?THpOUk9pRTdiN3pDRTlnVU1ZVXgyY1pPbmtRV0RlbUJUV0dlSmZaTEE5QXUv?=
 =?utf-8?B?QlJqNVZrK2ZnZEN6RzRDbXJINnlWd0RTeTZycS9yTE5SZlo3VjJDY1NDd3J5?=
 =?utf-8?B?RzFIQUxKaFdzN2dvQnBLQmtNb3JycDZweGhnaFZrUi9La1dmdlMwaW5uWU5t?=
 =?utf-8?B?SXJHZzlPa0dEaXpaZ0dTU3c5SkF6bW4rNHB5c2FCOGFUdkhLY0dqUkFUeG44?=
 =?utf-8?B?UWQ2Ukc4WkZBYk52RTNCRHpibnIzeldsZkg2TGRKS3hlckFreE15SE5UTE9B?=
 =?utf-8?B?TjZ0RU0zZjZ1U2NaNEZOaGxwVmtkZDJwc1Q0eHRBNHRaVThXV3BiajBick9G?=
 =?utf-8?B?ekZsSTh3NzdFVlhvajY5dUFQc0RURjZjeUc1R3lJdzF2OGp3Z0plUkMybU9h?=
 =?utf-8?B?OGtiMGMzWWdIMStDUTZ3cC9vVGlxcEFZajByNFIwbHB2c3BLR29kMDAyRkor?=
 =?utf-8?B?R2UxemIwRGh5T25IWU1kYVhlZ2VUWVBFbnFmS3h5bG0xdG5ISmxYMVVzUlU0?=
 =?utf-8?B?ME8wb3JpMWsrVzhqZGt4bnlrVmhObjdmdHRua3M5b0E5SUVVamU3czdZdVlt?=
 =?utf-8?B?QmVpZ1FJMGE1TjVCbWo2cVY5cWl2M2JZMkhiTFlvSG8yUGFjRW9wVEdweXVI?=
 =?utf-8?B?eG95ZEdFY0RzQ0hJejV1S1NBU1YrUjNHbk5mbVA4TmFuS3kxb3Q3Smk2QkVI?=
 =?utf-8?B?MkdWcDBHMktCMUdaeFhrVEQ4Y0JJM1M3L1dtaXMrY2ZTNnEwYUZsd0hqZnA1?=
 =?utf-8?B?bGJVVitjZ2xOVnhDeWgvQUl6Y3BLZVpncXhBMmJsSndDOXEvTFBZRmhFT1Zr?=
 =?utf-8?B?K2ZxdjlPUXRoNzJoajhiOWJkdXRRaisycTh4YUZpcFFIdEVxcDh0eDFTN2VJ?=
 =?utf-8?B?N1FYUHRkejdyWE5GVXYzNTRTcnZMLzZIdWo1OUNhbnFwTFY5L1I4c0cxTTZ6?=
 =?utf-8?B?Mk5qdXVYc0p5dFpCdkJyclBOU3Bxckx0dk1KREtPQUplaFFiWU14MlNKVVFN?=
 =?utf-8?B?TWc3cXdnR3g5anVnN3JLSUpoUXpoZDBObS9VVE1UdE9Xd014eGkxM1BvVEpK?=
 =?utf-8?B?aU9VMC9VbnVGQTZrQndxSzU0TkphNDh0cjVxdU0yZmhzUXJFM25RdTQrdmRV?=
 =?utf-8?B?SHc1NzlidG1nVjdGSjczZVhzNWlDZktzaCtBcHpqNzB3Mm1mYkRDM081WTNi?=
 =?utf-8?B?N3I0Nm9sRWNsNVFYV2VFUGVTYm9uamRHTUVua2lWTGFqK013c2dqNm9QaXZw?=
 =?utf-8?B?YXQ4QU1EazFDNWQxbTRZVUlRN1pjTXI4SEpBV05uMEdkUHNqSk9hcC9veHFz?=
 =?utf-8?B?a2tLTWtKVHBic09iRTBPR0Q3SWU5QWNHRDVTN3dmYzJXUWdBRjVKbkpibkNM?=
 =?utf-8?B?UUgwQWViSGkzYzJ3bGhYNDVEQ2dUUnFrNjVsb21tTEdrT2VQVnFuN3Zxamhh?=
 =?utf-8?B?R0RmNUJpYlZSbExKTzMxMERxU2U2SHIwbklJbWZUcmVrYTltTUplVTRKMS81?=
 =?utf-8?B?bS8wU0JtcW5JZm5jZTMvTGh2em1kbEpuWlp3aW9vRURLZFpDN01hdVhYd3Fa?=
 =?utf-8?B?S0Q5T0doZG85UXRjZ244M0lzY3RuZ1hPYWZtcnVPS2YrQU1BZjlubExINmtt?=
 =?utf-8?B?Yk9WYVAwV2FkYk9FejR3Tm84QU1BSEFac0xNWTU5ejB4blZ4MCtkK0lJR0Rk?=
 =?utf-8?B?M3d5dzN0TzJlZEEvWE5xbUhqbUtmckNsMDBsYnpoMS9DZ1JRT3lyUm0rakNn?=
 =?utf-8?Q?cfRVHcvh7ZKMCLFyaaM8G6+Tg7ERSJ1V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRsWEZjOElULytqRDZ0RE5nYUtVTmVsOUhaMkw3dXJ1ZldhK3Q4eDdKYjcz?=
 =?utf-8?B?elhsdzcrUVpkcDRIT3NtNFNrSTk4a0UvRVpEQ1JPVU5IS3ZyRHpRMGhUL05L?=
 =?utf-8?B?eCtWRXFNREZuaHFDbVNYZzNUeTQwME16NkhibE9tejJob2RwZEhMZnd4L0hC?=
 =?utf-8?B?czNwMHdpT01tUjVnMDRtdzFOR25XS21qSzh6VUJRUEMvK2VESThEU1VSczA3?=
 =?utf-8?B?OEpwY0lDZEY2MGcycHNOL3BTOGZ6UmVjWmhFbDVMWi9xU0FZR01XdTY1RkpB?=
 =?utf-8?B?d1kzcUMwc3lzNS9LQlQ4emRFMjhRK0ZPVVF0Uy96dkVpQ2xlWmVJallrWHZC?=
 =?utf-8?B?c0VWNDc3ZXJ4MEJXd2s2YW5FN3p5K1cwYVpldnlMb3pVbGw2WHp6bnQxV3NY?=
 =?utf-8?B?aFZFVFZiN1NvWk1ScklIM1VxdDB6S1JpejVwMHJEdzdqN1pWcndPQXQ5eThF?=
 =?utf-8?B?LzdiVlltWmp4bVREdjdWbVVKSFZhMmxCbUhxVEJ4eGJ5aWNzRzEzRS9RZkZU?=
 =?utf-8?B?TXBBV0pWdm9RS3dQYjBycERzVWRYRzl5WXJtS2Rrb0VzbGVKNzNJVlEyOW9w?=
 =?utf-8?B?TFBjQmFFS0h4WmRHVVpvOTBUUDBBdnE2V2VoSThyUnFPUk5nUEh5M3Bpa1Jt?=
 =?utf-8?B?elFSRDNXM2tRODcyVU5vL1VxVy9VTjhCYlJBMjhFL1g0Y1ljdnpCVnFLYlNa?=
 =?utf-8?B?UVBJRHhOM0wxc2UrSWJBZ3hablRycnRFekFmKytRejM5SXUvWTVYWk1KTkx4?=
 =?utf-8?B?UjNtVytFcmNWd1hiQXZ3azYzeElOUWJudzgzbWUwWTJPZllsZ0hpbVhNT1NX?=
 =?utf-8?B?Nk51TkZNa1FUZ0VackhzdithNFlyNWtzek80TkV5TDQrZ1p6ZzBQdUpzdFlh?=
 =?utf-8?B?cFNjbnFjTXVEOTdIeEZaazVabm1Xdk9tbUtTVktFRGpOcmxmSmVGbGJkUlkr?=
 =?utf-8?B?cWFFbHl2c3E3Rlp5T0c2OE9ZL0dQTjhWRGcrTVM5S1dSdUt3cGVpWURLcEJC?=
 =?utf-8?B?WlVlUlAzS3JNZnZhN2xGeTEwQ3BkVktpY0RybkVMN2NpUGNMSGk5QkVmUUoy?=
 =?utf-8?B?SlVCNWdZQ2h0OUtZdVRBbFErSU9jTThXaDV1dnJzK0cxb3NtVVVVOXBBLzVl?=
 =?utf-8?B?ejh6K3FhREhLYzU3UXpGTWlIcDliU1gySTIyS1ozcU5kOWg3OHdWWG0rdGNU?=
 =?utf-8?B?UGRONHpWUll2NDlMbUpCTHhheUluUjEySVJRbjVlVW1zY0JnNk1ZN0NkdFJh?=
 =?utf-8?B?elh6eUVtL2I4YytwKzA2SU9JdW9TNmlFNktEdTJBeTFEZTZaOGljTjJIQnQ4?=
 =?utf-8?B?MHhCTkdvc24wTmowT2QrMnJpbWdJbjluRVFUZzVXSkZzOW1MWmN0MUJ5bGVD?=
 =?utf-8?B?N09XYUN2VVVQdmhqd2lxZW1Tdk90RkxFYlczVXFtVkVaK1JqUUExUHV2bDNH?=
 =?utf-8?B?cXdHMGtQSkZwYncyUTZJdmM4d1I0R1drMmxZVnQwTW9nOUt2R1ZWTXF4S21W?=
 =?utf-8?B?eGdDUFFaeG8zbDY3U2s2dVJkak12UUhWL254aThna091bFpjZjhkbWpuRTVM?=
 =?utf-8?B?TklDMHFpTk8yR3VBdUZsRm83QXNnUnkzdWRxTkx0ejU1OHNna09TM29nOUJj?=
 =?utf-8?B?S2ZKVHl5YkRVbEdrUDEyZmlqbmw0YytKMFcxOWdrOWNuSERDdWFEeDFCVDdB?=
 =?utf-8?B?bkZWMmsvY2hTMEtQek9OK2k5MFF2dGtXVkMvcFhIeEt4ZXJFL2pxWTBOdFN1?=
 =?utf-8?B?bUZDbFdtK29JZTkzbmdoc0hWbnRybFVST3pkU2N5VkJzS2ZDQUlsVjRSREcw?=
 =?utf-8?B?d2NsekdlVmc1N0ptb0wvR3gvc25pNi9ucFkxbTdsL1JhSU1zaUcyOC9wY2VN?=
 =?utf-8?B?MFhUODVGQ1laTzdGNm1ObU45WS9oR2xWdXRBU1FBY0hrL1FTMFJNUmtmQUtE?=
 =?utf-8?B?dmZLaTRmV28vTGxUQTh4Y0xIUEJJL3NDUE9MbGZjMTdkQ1FZdW85SUZzeEZz?=
 =?utf-8?B?ZnBvdFBQRExkR0hoOUhpSkxGZU9NcXZJRy94cnY2TjY0UlhjTFAxa3JGTC9Z?=
 =?utf-8?B?cXI4UWVvT1E5VUtrR3VFRGJXUk9zM2dYRng4T1cxMUlWQzVNWFFyWlYreDBa?=
 =?utf-8?Q?a5iiHdcuBBDLSXlQmPCCx1a8Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0028ca-3c94-4894-f9c9-08ddfc7875c2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:06.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unrlc5lADlzeLPD0yOdpw8fxFHdjChtV2iO8DbSBd5aO5eeVZdmDimVSFN5W2grS7Ew63UPPNRceC7FNrWzlLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Rename stmpgpio to gpio and add gpio-controller and interrupt-controller.
Rename stmpe_adc to adc. Move interrupt-controller and gpio-controller
under gpio node.

to fix below CHECK_DTBS warnings:

/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@40 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@44 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi  |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi     | 12 +++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
index 17fabff80e903f621814492a8f8b837c5721adbe..cbe580dec182e1428d39477fa800a6e5ae1fe20c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
@@ -236,9 +236,12 @@ stmpe1: stmpe1601@40 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio1: stmpe_gpio {
+		stmpe_gpio1: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
@@ -250,9 +253,12 @@ stmpe2: stmpe1601@44 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio2: stmpe_gpio {
+		stmpe_gpio2: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 419d85b5a66061d4389df5d42de626183c27a9e6..8a0ce250e57607ef157fe34859cf77f45f54935b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -589,7 +589,7 @@ stmpe_ts: touchscreen {
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe_adc {
+		stmpe_adc: adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
index 4c09bb31269662adeb0b06991f45765935bef01e..e34c8cbe36aec682f46ffa128247bc47f3a6cab9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
@@ -122,15 +122,21 @@ sgtl5000: codec@a {
 		VDDD-supply = <&reg_1p8v>;
 	};
 
-	stmpe811: gpio-expander@44 {
+	gpio-expander@44 {
 		compatible = "st,stmpe811";
 		reg = <0x44>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_stmpe>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+
+		gpio {
+			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
 		stmpe: touchscreen {
 			compatible = "st,stmpe-ts";

-- 
2.34.1


