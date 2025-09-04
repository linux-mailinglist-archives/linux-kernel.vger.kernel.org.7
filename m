Return-Path: <linux-kernel+bounces-800547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A3B4390C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE513169F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59C2FCBFC;
	Thu,  4 Sep 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C4+MAcCv"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECE2FC896;
	Thu,  4 Sep 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982521; cv=fail; b=hQ++R1EIDEsqRRyuRsqDxkU29doedlx91vUfwF4oaTaPqDd9zlPHIFlB6kST5+cEoTagdi7gYkZf882uL9HVXiozWNkVEAOcnMpomJLD1a02BAkaL1JXyWL/pBbOw1VvRBrySUIAaymrdcvUmwTqEYpJ4oxGt6/YpwWt9lRX73s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982521; c=relaxed/simple;
	bh=smAOw2LLys6Ccvgu3BgWXtBA5tydyCv6WOl3MxNr6AM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qe5Xw1ixHKZX+lSrmPZKLpJm1ouaVBh7amZ2MF1kLPmzAXsKKchP28IcUgulbxlll2OzZUDnh6CXl8C2GN5yZUZHr22PpozurR3JWsbD7/xKYp+fRWs9Prw6TQixbS55i4VQSozUof97w6BcNAwxg0R9iv3l4HNG1cIZgGQwUSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C4+MAcCv; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFDk0j0+NI+OIXqFiByIDR2C8u4UE4xmuOtS4ftYeLXkYa7vo+krkMZ8PMdw/teLtxjg5sajmNRTKIl7XJ+Sc41+kNZcyjYrlm8dIQF2U3kSngyuSAxkjSYu8oY0QHTyyKt+qNUN1TJBnKlg8wF5vl9fZgpWDrLkzznBA3h7lUv8tkYkvklBtuIRoPp7OEHD2BtvoZdm6ZjSY8puknYJ2zYdT5t8i9sWmxuC28e4u1XShoNhCaIc/9ALKsH9TuJ3Wz90bKcPGLPYMlqBOm3IWqDubzHfIAQ0mVUdRxND8HEWVu7cgu/hQQbjAZ3qpJKc5ojgDxhL7DiwcEst9zF6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBBeiKTrAoJrc6ov3CW0ga8L4TPQoHo3OhY6qTTHfNY=;
 b=cM308oCPlZWaUrygN61sV7lz4hXEnp+SM+wrGEpkt6V5mBTKOZTfVjOC3SDGTZEgs6F8IKLe3lqHBPOYlYlTFqNSxjSBIusIUCxWLILeBhp99g8RAFT5wQvt5T4+Xu7c1yc1mqC+/XytSjed/389aAjSOizAvdaBt0EkkmOJIdTlfN9abCFYNEwOUzx3EvAjYq6VYWhVwEbz99vXebynnllpYTbaCAi+jruBJwElStGMXwERxRkxJRGwCN/1+3iVrdVu4EK5BmgCDgPaXfnHjTqxssDeGDDGFV4y/lp2KzWKB442ZyJajwmQS7jK2I5CKndofdRDtJmh9DrVUBOSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBBeiKTrAoJrc6ov3CW0ga8L4TPQoHo3OhY6qTTHfNY=;
 b=C4+MAcCvLfH+1oQAubP5KkKI4TkMmYO45xy2me3AhDbV5kL9orBzwQGuuq8ZevlEuVBmY7s9+SMU3ei30ygWYX6sxrld5RtNm0ZgX79V3RzmOnJuTyRTs2D/44glP9DaJ6UdIuIDR7S2l0kpw3hxkUGlF0w3++fix905AHCdhjDEii7YBGs1m0E3EElbOccUl8qxoH8gUwz5bi4NzTJDAWHcKdRe7bWIEXEX/a+9EQQ0pIX9aWrfHb31RFgKulA8qkczn6BOM7TPgyKhPVj3wvbDZifFwXNqLQrYlWH8cqaM0Mhs7tNtFuVxj+UHhJhkgrOKF8QhbJtCIEcQjCdwVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6937.eurprd04.prod.outlook.com (2603:10a6:10:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:57 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:47 +0800
Subject: [PATCH v4 6/6] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-6-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=7930;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=smAOw2LLys6Ccvgu3BgWXtBA5tydyCv6WOl3MxNr6AM=;
 b=A/GyhVUwHMtJDW4C+jnEmW/mLirY7B2UfaAfbVFfqfZwO1qNj7DnRJ06LHTWaO9+tfF5ODjr0
 D3yXf2xXSE2BhEpv9dcU9jv6z+jC5Ea95ulFY5XAdPu6WUlgB5iMY5L
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c591bef-a806-4321-1743-08ddeb9fabeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWJFNU1GNkNXS2tncEYzajlVSVpybVk5eHprSDJTVzU3alJIc2ZNYlpIOFI0?=
 =?utf-8?B?YlJBUFJZNW93ME9hbHEyejN0NDAxUjRkT0s3ZzdpOGhWa3YvOSsxMWVTeUl4?=
 =?utf-8?B?UEQrYlRwbngyY05nRmdTZjVVMlNoZXl2R1VMTHQ3UEJ0Z2FOaWc0SFBWODVY?=
 =?utf-8?B?UjdVZ0V5YTF3SzlhY2JsTXZpajllZGZkTCsvUVFZNithTDdZZCtUbStJSSsz?=
 =?utf-8?B?RkNIU2RzaXBHRGx6VG84RURPTjQrUVE0SHBrYTc0bU52VUM3Kzl1V0RxS2lq?=
 =?utf-8?B?MFErb3hEWUhrckZKeXVsY0J6WHVBWGJZOWZaRVJwci9wUXB3MG5aNVJuUklv?=
 =?utf-8?B?T2YwWVhDMkRoTjk3ditaY29xQnRTZG5vZ1daQytWbXY4U1JsZ2F5a0dqM0J1?=
 =?utf-8?B?cGJQZnFSNDl6UlJOdG55ZmNJSXV6RDRpVW5CUU52dXBYZEZPNTFCRU1id0kx?=
 =?utf-8?B?TXBJSUNQWE9ORlVOR0dQcUVCNHNWNDZGTCt2K0F2NDUyWXoxeGZHTnh4d0lq?=
 =?utf-8?B?WGN3SmJ1YlVwS2J4ZU1ab3F5TTczSE9LWVA3cEZxd1NacTRqVmxwczRzSGVI?=
 =?utf-8?B?dUVBdEEyQVVJRWQzQTh5Sm1xOGFLc0hTd0ttZjcrMFJGLzd4OEpBcTZTdVlK?=
 =?utf-8?B?dDlZQVVkVDNhbjFaYkZmeUhsOTNHM3puK0M0TEN1MVEra0dicnFqY3hsRWli?=
 =?utf-8?B?ZGcyZFNydG9lK1NEaDlOM2Vpc0twd3k1dHk1ajBLdWdMbGxnL3l1d1p2Njh4?=
 =?utf-8?B?UUJybjlyQkdvMnNKQTZTdkt2SWhpek5aeXVtZjI2bzducmgrOERlcUN5T2tS?=
 =?utf-8?B?OVFGaGVHSDFaNkp1SmNaRUs4RG51aEdSZ3piWlR4dG95aThRbWkrOXVJRVA4?=
 =?utf-8?B?aGpCMDlqOE8wU3E5WkluZjNLc1QzQzFYbDI1OWdDMzJDM3BJaSt6L2FDdDJw?=
 =?utf-8?B?emZObk42dWpWS21QenBhYTFERWp6ZmlodkwvU3VWUEdsK003VGJuLzBxQU9E?=
 =?utf-8?B?TWZCY2p2RE5NVjhvbWZWVndQZmNiZUpUaks2ekdBWHF5aXBCemU2V1RUZzU2?=
 =?utf-8?B?c2VKdUdWZHh5THVubjRaWUtpdGhkOTFSelMzaFd5dzBxYnJSK01sUUVNajhh?=
 =?utf-8?B?Q25uVlBjN2wycXNGUjNmOFVHVVQwejIxM1JPWE5KMlhaRUJlQk1zWld3blc4?=
 =?utf-8?B?UjY5UWlTVSt4UVdLTkdqUmhRSUxUQzJQd2RIVGNHMWloeDV1aHF2VU1RSDV1?=
 =?utf-8?B?TEFpWVdkUFVNYUZ1LzNiZi93Yzd6ekpVaG56RC9rZEFjcWMyaDBoc0gyK0lG?=
 =?utf-8?B?WUd1dlV5S2ZDY3pPS0N0UWNNMk9XVElMMGk0WTc5ckFRa3hLanNqbUtQcjhI?=
 =?utf-8?B?WUlQaFdhMVp5R25BTG9ZTDJYWGFQMXQvbnViek9mZ3lqeWE4WXdEcElBS2RU?=
 =?utf-8?B?WlIzTmxOTG4zWnQ1OWdQU1ZlR1lmTzJpOWs2YThSdWUzczRvT0I3YjhDK0d0?=
 =?utf-8?B?MjBCNUNlNTd0dnpEekx1eUtpYTBIZEpKbnJvMzdWNjg5LzV3RHdhaDN6TVZx?=
 =?utf-8?B?Tmc4T0JFWmR3NHZiOHp3M0Z6SUl6SUNUZW5Cb3BLOE1DTmxsRm42NXZzUkdz?=
 =?utf-8?B?d1lmTUFnZ1V0MWZPMHFGWldUUVhFTzl3eWh0ZnFOK0hrT0F4NHQwb0ZaRTFw?=
 =?utf-8?B?eUt6WmxaV1pqNm9uNnJXZERjai9tNmErM0ZLU2tJNlk2Zys0dDJkMjdkbmpE?=
 =?utf-8?B?NkhBQ0EzQlpzcDBwRWtPTGVtVkM1OTRES1N2ckdQTDFXR0drQzZEbERwdkNQ?=
 =?utf-8?B?bHpDUTVzM3gyK0ZlNWI4YmNRQVNYQkc4cmgyTWZOZGJkMHlLZ0JwVUl6OTk5?=
 =?utf-8?B?MU5jZjRnZGVTMHM1RjRlb2U4Q1pxNTlvZmVtektWRGFBY3R5N0tpVXEzT1lG?=
 =?utf-8?B?QmMzRDM3ODlxcEwwUkFXVHZ0cDlMUW8rSnU2ZzVKMERYckxPZVFyeXFRZ1Mz?=
 =?utf-8?B?S05xdi81WUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXdEdGxWU2JXbzZKc3NzRmhEVFhITjNKWjJnQXZVQW1jS0JGNm9YeWxxenpa?=
 =?utf-8?B?R01pWXNadis0THUwN1djckFGVllxRlY2STVnTFZ3QUpWa0hjRld5cEZ4MEtF?=
 =?utf-8?B?MTRJRm55OXJFcWUvWUpOQVZ1RVJnYWJQM041VGRnRzBzNjNIaWlEOU44T3J2?=
 =?utf-8?B?bHhtUXJ2NXljK296c2dPWDZSRE9BQzlVOGpmeEpZZlA4eThGZkkydjlRZjRZ?=
 =?utf-8?B?azZFTkt2Tk5XSk4yWnU3MElkVEVrV1hKaURhZDk1YWxiY2dndWxrRjg0QlFB?=
 =?utf-8?B?T1NHNGlCcUt4ZUc1d3Zad3Q5b09aN29hVnN5aE9FMjJ1ZFRJVWc3NktFN1A5?=
 =?utf-8?B?S2J5T2xWL0dqd01JRkQzdVRDd1VDcTRJOGkwbkF1d1JGbXFyTGJIREVKRkhx?=
 =?utf-8?B?RlBWVjVZMnVKcnp1bm0rYVRuTHZzWnNOMjhCN1JqZ0V0dmxFMU8zQU44dlho?=
 =?utf-8?B?QUNoTGpsZ3h3bVhXSHd2S2tKaDQya3VTY1VWdUFPbjRJeHFSOVU1RFdGZi9Y?=
 =?utf-8?B?ZEIwbEdxSWwyTXVNdTcrUWlxcVBTNlBEbXhTSXI3clN3VFIyT3hIeFhtdGtG?=
 =?utf-8?B?bUxGM1FXcDJlbmJobHplSjNMMS9tanh4dG81K1ppQVBjaFVaYlhuUUp3V2NR?=
 =?utf-8?B?WWdGbVBJWmRjSHF0VEY4d0tpdE9EMm9oR25nQnBMcDh0NHRuY0xOTm52Tndr?=
 =?utf-8?B?UVBMNkRYTElsNUprOXY5N1ZadjlreGdNaGpvNnVQNXFxcVF6ditLRlhOZmcz?=
 =?utf-8?B?L1V0UHR0azRkdmxoNzVOaUlzQ005akZnS0RqVDJaWVh4U0tnVW1DendNSy9C?=
 =?utf-8?B?L0QyVVovdG95VmZkUVg0UEdZcmRSdlBRR1IrRXBzdGF4RFhLWGdIcCtUU0Vj?=
 =?utf-8?B?MDBTSFVTbVptTi9taEQ4N3F6QzhNVjB3U1UxSmZ4NExHNmFBVWlGRlFKaVpW?=
 =?utf-8?B?KzQ3QnA4TjIwaEVpTHIvTEFGekYzREFQNktaNllTR2ROOWVNUFhFcyszMXJj?=
 =?utf-8?B?dWZ6aEthd29tTkN5VVprNnhpLy96dzl6am1uMm8zd2NUQXBjRkg2T2djV1Ns?=
 =?utf-8?B?dEVNTnVtb2lwd3pEajFPT01SVUU1d0wxdWtscFNTb1dJSFF5UEpNZUhYNlI2?=
 =?utf-8?B?cmxGVWc3YUlCU284Ym9qQ25CTHd5QVVlWVM4cVRLdnlZdWpGRFNRYmdaUHY5?=
 =?utf-8?B?VlAzWXlwKzZKcVhwRHJ1VVhNSFl2bHdJR3ZOM1p5RHZ2NGF2MEkrenN1ZHZx?=
 =?utf-8?B?bXlrMjd1R21hSk0wZW5jUy9VZ0ZZTUdGZHpXM29oVkxycGJ2TUFFRFhjcm90?=
 =?utf-8?B?U2FxS0pEbldxemR5b1A5cGlQMzhjQ1ZkQkJIZEhsYmRyeHhnd0MxOGtvcXVL?=
 =?utf-8?B?K1RJYXR4YjRrMFdaUHlnNTNQSFpLS1lkakJTM3VFRGV3Y014M3Z3QTNkUWJI?=
 =?utf-8?B?NHJuWnRWOVNnTGpJUjh5Qnl5VG9aY2tjVzVacHUxR0F1Vk0rZXhRWVA5UzBD?=
 =?utf-8?B?TkFmdFJmelJlaGk2ajZaa0ZmbHNUb3JzRlVqSkExT2lEd29aaWU1c25jNnc3?=
 =?utf-8?B?bFdJT3NNQTlaeGlmS3g0TjVDY2VTaWczYTRlaS9KR1lIYzFRaWMvRmtkR05z?=
 =?utf-8?B?ejIxczZEeTN3d0lPaW1UTVRnS3Uyb0orVk9JUU1YUndBWXRkTVZ1MlFybVpX?=
 =?utf-8?B?M3Zxcjh6TmVKaWRUL055TkZTU0gxWEJ2bS9rRDh5bm9aUThVcWIrN09zUlFN?=
 =?utf-8?B?clY1NDB0YUZ6bDhOS2xUTXN5ZVNVbnJkUHluU2NxQzV5V2t2Ry9oM1hSUTNi?=
 =?utf-8?B?eGxVQi9XeGh0MEpYL281c3FQL0wyYjZIRnAwSVI0UHpqcTJON3p3NW41VjNP?=
 =?utf-8?B?MFpNQ01uVG5GMWpyRldrWndTRDZ6WmtuaU9aQmlmQ3l3KzJ0OWI5aFJiV2pV?=
 =?utf-8?B?ZWN4NEk0elgyU2Riem9rajRiSWgwY0NsdlNDRHZ1TzlvbGpWOS80Y1ZyWnFV?=
 =?utf-8?B?TGgwaFJiWUVZK0VVbG5lY1UwUTVYRUtCMnJPanY5NExma0o1bloyNGxkUXE1?=
 =?utf-8?B?Z1E0LzE5ZHZTaWNwMEptRUFNRnNyYUIyLy9Ga3B3V2U2dk1JVWQ2WjNRZ0lr?=
 =?utf-8?Q?bdDblHv23DIrw2VeICheZAES9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c591bef-a806-4321-1743-08ddeb9fabeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:57.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ694CMCBK2Lw3tiIKdiQw9HnzHGSABRJCk9oA3ZphwHvzOLchTz5dlknZTY+L7NvQ+TUUI16Bq9Mo5AVY9kqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6937

Add sysfs interface to read System Manager syslog info

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 232 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..e742a2fff06b44ab7f07e9f97f723ef7ca1ff259 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -44,10 +45,232 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static ssize_t
+wakevector_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, wakesource)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.wakesource);
+}
+static DEVICE_ATTR_RO(wakevector);
+
+static ssize_t
+syssleepmode_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, syssleepmode)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.syssleepmode);
+}
+static DEVICE_ATTR_RO(syssleepmode);
+
+static ssize_t
+syssleepflags_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, syssleepflags)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.syssleepflags);
+}
+static DEVICE_ATTR_RO(syssleepflags);
+
+static ssize_t
+mixpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, mixpwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mixpwrstat);
+}
+static DEVICE_ATTR_RO(mixpwrstat);
+
+static ssize_t
+mempwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, mempwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mempwrstat);
+}
+static DEVICE_ATTR_RO(mempwrstat);
+
+static ssize_t
+pllpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, pllpwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.pllpwrstat);
+}
+static DEVICE_ATTR_RO(pllpwrstat);
+
+static ssize_t
+sleepentryusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepentryusec)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepentryusec);
+}
+static DEVICE_ATTR_RO(sleepentryusec);
+
+static ssize_t
+sleepexitusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepexitusec)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepexitusec);
+}
+static DEVICE_ATTR_RO(sleepexitusec);
+
+static ssize_t
+sleepcnt_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepcnt)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepcnt);
+}
+static DEVICE_ATTR_RO(sleepcnt);
+
+static struct attribute *sm_misc_attrs[] = {
+	&dev_attr_wakevector.attr,
+	&dev_attr_syssleepmode.attr,
+	&dev_attr_syssleepflags.attr,
+	&dev_attr_mixpwrstat.attr,
+	&dev_attr_mempwrstat.attr,
+	&dev_attr_pllpwrstat.attr,
+	&dev_attr_sleepentryusec.attr,
+	&dev_attr_sleepexitusec.attr,
+	&dev_attr_sleepcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sm_misc);
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct scmi_imx_misc_syslog *syslog;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -63,6 +286,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 	if (IS_ERR(imx_misc_ctrl_ops))
 		return PTR_ERR(imx_misc_ctrl_ops);
 
+	syslog = devm_kzalloc(&sdev->dev, sizeof(*syslog), GFP_KERNEL);
+	if (!syslog)
+		return -ENOMEM;
+
+	dev_set_drvdata(&sdev->dev, syslog);
+
 	num = of_property_count_u32_elems(np, "nxp,ctrl-ids");
 	if (num % 2) {
 		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
@@ -108,6 +337,9 @@ static const struct scmi_device_id scmi_id_table[] = {
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.driver = {
+		.dev_groups = sm_misc_groups,
+	},
 	.name = "scmi-imx-misc-ctrl",
 	.probe = scmi_imx_misc_ctrl_probe,
 	.id_table = scmi_id_table,

-- 
2.37.1


