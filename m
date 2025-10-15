Return-Path: <linux-kernel+bounces-854904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD606BDFB93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31493E6B97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F2338F52;
	Wed, 15 Oct 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="di/PM3mF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F513338F21;
	Wed, 15 Oct 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546689; cv=fail; b=PFtUzBPExRI0VduOZPSJMoGL5ceWroE+MtlG/+AFlYYJFg/k2j46x5C3V7mg+HmGAh7zV11ehQLpedYHctU5sHd7ImTge3poMGf0sACEhz/8eI2/5FT5+EXEkyBHIlPqR/P4YtMKu1dyWutnd+CLRR7LChQdZMEYerTSaMbfj4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546689; c=relaxed/simple;
	bh=+k+YWG1b3yHzzTKWqV76F9xalznNEx7/ie+fmHfnhIA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lU8c+O7VPAFrQNdiYafShcYZtzNm/5ZRBjJlGZdU1fLM6pEJoYPw3u+fnWlw6wSVa/Wl4e+kFomnSA2gVqFwgaxNzaQmeLL5Xip9N1qfPVDIkShVyhPwzZR5AEmemywFdVNJjMT9LYxXivuKxutxKHLv5rCjQuEtfKmwQSKdA0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=di/PM3mF; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS28E/fPewYOPqdYFT6Ip0CE18OGko7DiqwEAWq3b+GRpp/M9J7M6zkI3CIhHmWVeUACuZYMwA9dKIZyd3MrVWiC1BeKDQ3vCqm/Er5rx9aZime9aycgxXT7vN+WbbiSU2Mt9Cq8Kf/3ONM+q7cbHC8hKlVnz5Z8YFJLBbGPT9dPN4a6Lr0ukDpTcntnXSz2SS6cLanARyQp3/OIoBISzW/Ymvc6g+AxBy5rxzKtox1t9/p1wLluJmsI13Q0lnvO9J6zxlLVXsqIROHoiFqNhX2jzxcDP+BG6UJVYa4NvGeFBhI0Kslsg3pK4ovBWqsJbyLwpPq7RoH3EJHdInO+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfR6VR3GuMrEIZjKV5HW+9MRhLvsSu6Am55icwcVAKg=;
 b=m9oG/W39p+Yx08PKxkVbFIPYCJREoLNuUi6Tnqf/HS0Ld/LHIiBnXD4SGa8VGY1CgwWCBWZK4sQ5rBC7BxAsawNQkVTAnuPLHO3uVKvfdrfJqrlCpfe0vTutfIXz0B2LYA9t8x2+D1YPyrINmvmhFoId7fipMcS6cCfRhEqCiI/GPuk21Iwkq3Sv82MAjwiNgrSJQmtolgVzSn/cD3i4j5OXvz59xAic4jwCjU5grY8qhFw8puX6qBiI0wV17l1gAZk4Rx5c3NUW2/meTheEhCwu967dNyR54KeYtagZk7fFg5MlzUN5q/BpOaJxA+c6tycDm7D99FC0M2SFLLoFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfR6VR3GuMrEIZjKV5HW+9MRhLvsSu6Am55icwcVAKg=;
 b=di/PM3mFAoenn39AJLo0io7YmI4ZFqKZhzGUFQcuk91Y/ps+Y4BR8DDor7lWA43WYdH0gwtQVmGBsfBhaFS2ZyFUL5ioEeIsroXNLaZIotCW456plhQsJ/2rQD5W52ZLveMMkzSxZRbhBchU5/EkTzWiNmEE/Y9VUzyK+45okatUmeR5OmcooxBxzM5g4UgWYTpsii49Hu7rB9GFbH6cF96ScK/5AhSUNf2uCR4VseK6as5Fj6vGKTspze7SiAdKHULCXNeDsXGfbmSATamlInGfxT44hgd300i8wjVVlR37PNCwrNbTFCZNHiS2MVG+xQ9Ox2Dkua2pm9/d4JhTag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:44:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:44:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/11] ARM: dts: imx6: trivial change to clean up some
 DTB warnings.
Date: Wed, 15 Oct 2025 12:44:25 -0400
Message-Id: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnP72gC/32NQQ6CMBBFr0JmbU0ZpIIr72EIIe0gk0ghLTY1p
 He3cgCX7yX//R08OSYPt2IHR4E9LzYDngrQ02CfJNhkBpRYyxZrwXNUvdl8r1802PcqFJmxrki
 2WiHk2epo5HgkH13mif22uM/xEMqf/RMLpZDiemmqRhojDeLdxvWslxm6lNIXZWKSYK4AAAA=
X-Change-ID: 20250925-imx6_dts_cleanup-6edf53e09c62
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=2243;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+k+YWG1b3yHzzTKWqV76F9xalznNEx7/ie+fmHfnhIA=;
 b=u2f1yuFtx6qIdBWLKi980jp7Y+hp+e4HlKsCnxQbkrq1KJ0GFpLA0a0EgE67akfMVOGQvcAJX
 xmhhm05ypeqAVDolauyVtFQKmou4BFuYhzC6tjQC7PFO4IPrhkQxbZV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdf2748-a29f-453c-afdf-08de0c0a2492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHkwOU1jRzUxTlE2OVQwT0ljbk5wTTlLQlVwOGp3NzVsMitCOE5DSWo3UHpX?=
 =?utf-8?B?WVJiYVhYTmdHbHJFeld5a1h4RkM5QkVRRU16TVN0bHE3dVBjSng3QUVsTkdw?=
 =?utf-8?B?WVRSc09XZXgrY3lsT29LTDhnN004UmVsOWxET3c2cW1tODRlZXFpeTMvTVVU?=
 =?utf-8?B?RFY5ZGFGbHRaZkEvTnN2REpaOU9ZQmRXNTB4NnhyNHJoQmwrYUVNM0RhbUpm?=
 =?utf-8?B?OW1JMTBqcnlyZWlqUUVFcGJWVzJjRU9iRkhWcGh6WWZrK3FBcGZGMml1VmxS?=
 =?utf-8?B?Z1hMTnFUdjJTTUorSzlvb3F1cU5WODRtZDhYQUs1QkU1Ym9Ec3lMY05ZdU9k?=
 =?utf-8?B?NFRnUTl0R0o4Z0x0Tlhmc0NmZjRtRTN1QWl3OWtuM0Y2anR6UjFTbGc5Zzgy?=
 =?utf-8?B?bFJTb3hZN3ZHT3Jyci83MFY5NzZseUV6OWtRT2ROaGZxTnl4QnNDZVp3OTdj?=
 =?utf-8?B?U3hJY1BCYTlreFlaVDdGZVFPWWpDNnpJRGJTRTQzYU5hUDM5SlJnY0VmbWdE?=
 =?utf-8?B?Umh1RWdQam1iYjVYay9WZ0V0QUVJcStYbGFLY2xqOVhKM2c0Sy9HZnpER3cv?=
 =?utf-8?B?aGhXcFdnZENGaEhiZVo5UWZEUFg0Sm44OHFZM1UzMDNRTU1CblM3dCtjZlVQ?=
 =?utf-8?B?RGJaM09UMlEyYnVvV3lIc1JTL0JBOWpoNzl1ZG44VUtlbG9jTE45dys0dDA5?=
 =?utf-8?B?dTJ3WEhKVVhxKzdFMllpeXdVVDY5Vys4M21rckNHZHhTQ2FHSkVPWFJwcFNn?=
 =?utf-8?B?akgrSjRVcDdFb3pBbElZQ2pUNW1Jb1c3RWVvNFRxLzBVQVUxRmQ5aCtvdEpK?=
 =?utf-8?B?SzJyRUtSQ0VwOW4rVkJQbjV4TmprNTROZDF6TmtFZ29NcVNNVnh4V2NLNXd0?=
 =?utf-8?B?bFBlaldYbEVpb25KUVB2ZlRpN01uRDNOMFZiOXdFQm1zUm5lSUw3Vjd4SGZO?=
 =?utf-8?B?QXdWZk5mN3dkeWJBSEc2M1paOTM2bERWMnI3UGFnOWNLLy9nZnBXM2dMUWlX?=
 =?utf-8?B?akw2M0NWNkVFaGp3VlltY2VxVHUzL3V5NEpia2JRSmtHQU82WHhIU3BQUXZZ?=
 =?utf-8?B?WHRTRnB1akRrdHVWaytzUlZJVDZWRG5TU0Z4MmRheDRubDk0Q0ZTMytuUThm?=
 =?utf-8?B?dkwwVU85aVJGYUJsdEFCKysranBTZnB2TU8wUG5MMm9aUjlJRnoyV0NrTWZE?=
 =?utf-8?B?VHQ1NEZOSUg5dHNCSW9rVUtEblhnWnh4bGtLTDFWS1I3Zm8xeVlDaTJKZ0xr?=
 =?utf-8?B?c3VNUVIzUWFTVWJaelNxZ0UvZlBEVlM1V09ZREVzaHdDczFTV1FyNHpva0Jy?=
 =?utf-8?B?MUZ3eE1pWlpGRm50aDJtVElBeGFkNCtXY3RzOXkzR1JuNXBIWnVtUS9hODZN?=
 =?utf-8?B?dFhLdis1MjhqMjZsd2xyOXZyM2dHVGFuSHFPOVNqdHNIU0t4bGdYMlVGWDRX?=
 =?utf-8?B?V2djVHE0VnBIa3BTcjF0WXA0OFd5cTU2M1dMaDFzWTFXUjRhUmwwaGdCMktE?=
 =?utf-8?B?RjQ1cFAySTFNVTQ0b29XbVBPOHdJVUdGYzRsbUR2N0k0cld2TXRtUkNPVXVY?=
 =?utf-8?B?QWpHUEVRTksyU1UxaFcyVTYzMHRGdWZMcFpBWFU3N3VHcm9ZWG9QR2tybGVH?=
 =?utf-8?B?eVhtNVJ1WTZIcVNGK2hKS0hGTnpDVE45ZVExMDJyU0FNbk1vOGlzZTlHSDNB?=
 =?utf-8?B?YTVYakZjK2NmUk1YUmhIUFRFRDhHdDQvVXgrOE4rdzk0YnZXalFabTlsYnV3?=
 =?utf-8?B?Q01XUnM5RlZMSll6RmxIMWtyM0RwR1NwdmkzWmJsTnUrTFh0cnRPSDk2SCsz?=
 =?utf-8?B?RkZJaTN4Wm1QRVJZRGVyOVJRcmNEclNsdG9FVy8zVEtDaGNyUVhFVWIzYzNR?=
 =?utf-8?B?c2QyL0R3WkJTUTkzMmFnQmlDV1lhUVc0ejZGNUlGYTAxcG54bEtEbDd1N3pr?=
 =?utf-8?B?MkhJMXZZZ2kzT2c5S1BGcW5VZ3FMUmxHZnJDa3N0N2hRK01EZXRvWEtab2p2?=
 =?utf-8?B?Z0QzbThvZ1JmakNaSFBvWE1uNnNGMndCYzVLNGlMZFlxT1RZckV0N2FyTjNj?=
 =?utf-8?Q?dHSuYJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkRlN3JqVFBPREVQb2J5bjg4QSt4SW1oV0dqUHhOZ2N2WGlidVRHeHpJbDZj?=
 =?utf-8?B?Z0ROWVFqeCsvYS9rZUlVVXEvYXh3T2FLSFZ6V2JnQU55Tnlwc1diMjR4R2hl?=
 =?utf-8?B?bDBRNDg4dEVzd1BscVZ6RnZaTENqa0x0VW1nTlNqT0ErU1c0ODRBVmdXQk8w?=
 =?utf-8?B?dnBOSmt0WUIrVkdVTUYwM3lOaHVVZ3BBbkRkUTZSL2ZpZTJac0JTQVJaSHRW?=
 =?utf-8?B?cGI1ZFYwaXB2Z0NHbnlGbEZQY1JCSytYK2V2eWc1VlFWcExXK1BnTWtRR003?=
 =?utf-8?B?YUxDNGlJODROellsbEgrVFpjOTZzWUEwb091bnlVQ1o1TEIvZmhHQTlCb1A0?=
 =?utf-8?B?WVVtd3p3VW04WitxZDJVakx4RGxvSlB4dnVGMm5UOWhlcU81eVRwLzlZR1Bw?=
 =?utf-8?B?TWpQK3k4M2lXeDArRGtGc05PeDZDSnhaWTgwbkQxaEhwUktUMGtoTVI0UkxY?=
 =?utf-8?B?SFBGYndyZVQxem00M2RNZ09SdnlBaFIrQU43UTVUazdSWXJIK0pZYk4wUDdk?=
 =?utf-8?B?OWJZVjlhcGh1ZTU1c2oxY284SmlrazM4OS9xenQybURJSytkdnVLV2tTNmQ4?=
 =?utf-8?B?Q1lZeGJHOTBnV0N4NVhlOFBoT3M5TzF2QWR4VDhzUjRqNzdXdzMzUWZIcjRO?=
 =?utf-8?B?YzNlTkV6ZTUwVHNlaXBNV0hkSzBJQlNKM2FSY2VZdWVwNm9tSElvQ1RiTW9r?=
 =?utf-8?B?M255YWNvWGZOYzZqVjFaZGFySXMzWHRNOHVtZjJUSDRSek5CcVB2VHp3WTRi?=
 =?utf-8?B?TTB3b2dtcnhjVnJqSGxNSnUvK0JqQ0xrWEpWZE56V1hOSnh2dG9DQUhKZW9U?=
 =?utf-8?B?YTdSSTlCUmlSc3F5bUhmbHlFd3ZmNTcvcklmNzh2RTdSZnZNb1NqeENHMnBp?=
 =?utf-8?B?bXBhTHpQdzNEQzNHNHJBS0hySUgxZlFMUExWQzJtVXBiUE8wQ0VlY0l4SUJC?=
 =?utf-8?B?dVhPaW1OVTFFb0NpMlRLTFNQNytaOVArNU1kMU04UElENWY4c3VrTWFOVmZG?=
 =?utf-8?B?aHB6eUIvdmdFQ2kwRncybENJTlJOSVNicnN2UHFVMUgzS0dsbFJFK09rN3NR?=
 =?utf-8?B?ak9CekxwM1krSlZ5emJGNXl1NWM2ZkxTRDZCR1VycEpPdWNyV09jR2F1ZnJV?=
 =?utf-8?B?cWxBUE0rVzZYMjU4TzVYcDBjemhPZmRxaFpwMlZyMVMxSWNCNW9vbDdLVXFB?=
 =?utf-8?B?L05UeW5vOW5BNU92UnpqOHlEWE03dXBpa0Vmd1pJOWNpN05oSFNJZklBL2pS?=
 =?utf-8?B?cDh5NHFNeEtQbEpVMnRqTk9IU2J1ditUVVlhekxtbUlHalpQMmhPMEd4YmNy?=
 =?utf-8?B?ZzBBVzRmUUNBU2t4L3JDdkNqTGxRZy8vSkU4bEZub0NJSGI0NFJRWWhYUnhY?=
 =?utf-8?B?dUFGTGNuVTF4b0o3WGdWcVoyVEJ0VWc5bVRYVDRydi9aMS96bDRmR2dqZW00?=
 =?utf-8?B?QU5FMFdRdVdvdzBFblFLaXZCV0lBQlBrSzhieldEeXBrcGJUbG5JNzNsb1ls?=
 =?utf-8?B?Wlp4Z01PMHJBVlV0Y0twN2VjQ081M0ZPdHMzNDlrZkVyZ204OVFDRjFoOEtI?=
 =?utf-8?B?NXNzVXRBRG40ZWVHQXBxOVk2L0QwSmRnKzN1MGR1NTZIVmRQenZrRzZudTJj?=
 =?utf-8?B?T3p3STR4YnEzc3VRTUJTT0RqRExrUTZXdkttdGhOL2xPcWJzMll1ZVcwU0lV?=
 =?utf-8?B?VVV3dm5Pd2NWQjZuOEhVTWRjMHRJTER0UlZhR2JZbmhxRERiS0xaWHI5dk9M?=
 =?utf-8?B?ajVvSU12cWRTTk9GaDlDNzhmeThoNDJ5L3V3MVFEODRYMkRzQWFzZFFLakdx?=
 =?utf-8?B?Z1FpNmtsdUI4dXRraHZOclRBZmRqUzZHL1owQm5sQ3pUa1FUNURFbjd4VTdj?=
 =?utf-8?B?Q2xuWTNGRDJEVlFpZDJhMXJGL0tMdmx1YWNWWktmaVhPZTJPd2FiS0V6c1Bx?=
 =?utf-8?B?UDdhN29ZLzlPWEZpeXNsaU9QWG1nNldWSm03NUt5N2ZuWm5iQXJTMTBXb1E3?=
 =?utf-8?B?bzRNbVUyR2J1ZWdGWmJVWlMxdzFnK2YxUm1waGlFRTF4Szh5RUtmMU5IdmJp?=
 =?utf-8?B?MWFmUzdRNVVqU010UXorSWV6TW1pMEx0U0VOcURub292NGptRWx2R1FzMFAz?=
 =?utf-8?Q?IlY8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf2748-a29f-453c-afdf-08de0c0a2492
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:44:43.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TsrWGv4WTH785S5a7in2dFHO39vLemWUzjm0MRsaPQRYkMdfRrqKUw5BnF3unLWqzSEbcVOhNngC4jFVn35Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Trivial change to clean up some DTB warnings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- rename ir to ir-receiver according to fabio's suggestion
- Link to v1: https://lore.kernel.org/r/20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com

---
Frank Li (11):
      ARM: dts: imx6: rename stmpgpio to gpio
      ARM: dts: imx6: rename touch-thermal0 to touch-0-thermal
      ARM: dts: imx6: rename m95m02 to eeprom
      ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
      ARM: dts: imx6: remove gpio suffix for regulator
      ARM: dts: imx6: change voltage-divider's io-channel-cells to 1
      ARM: dts: imx6: remove pinctrl-name if pinctrl-0 doesn't exist
      ARM: dts: imx6-tbs2910: rename ir_recv to ir-receiver
      ARM: dts: imx6q-utilite-pro: add missing required property for pci
      ARM: dts: imx6ull-phytec-tauri: remove extra space before jedec,spi-nor
      ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to i2c

 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts          |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts          |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts          | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts      | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts              |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts        |  2 --
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts          |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts      |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi        |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts   |  1 -
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi            |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi          | 12 +++++++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi  |  2 +-
 16 files changed, 42 insertions(+), 30 deletions(-)
---
base-commit: 2f331cf977ffb87638d3b6e534e06ad60ce32f4d
change-id: 20250925-imx6_dts_cleanup-6edf53e09c62

Best regards,
--
Frank Li <Frank.Li@nxp.com>


