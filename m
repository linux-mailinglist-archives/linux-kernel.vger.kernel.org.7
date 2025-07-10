Return-Path: <linux-kernel+bounces-725255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD01AFFC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664173B150F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52828FFFB;
	Thu, 10 Jul 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LiousFGC"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDA28C5D5;
	Thu, 10 Jul 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136542; cv=fail; b=mpfFVdTIGKJhI6HmOjs6KuqJQR9WtF+mRo6GL9BUohrQVvtjbxCKuWkfJizxfb30nc2w4bN00HfPYix3zPDTYffnx3vbFuuWJ4A1rPg9oBAtg4/crlnJxFlbc9Sat8cS5sKT7MmLELcNHlX1CbqQDr0o3FA4HaR6G9DfUlAo504=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136542; c=relaxed/simple;
	bh=LCOZEYs6KB6gRmyFtzl92oM1LwcuHr4QB7pDlViZZXM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IX9ZANoXB+6Kuaa2LIBfwfgThcUS5AMS+JxnNBbMCMK6es8D5RBxbxf/qTziDDwYmzpRJEpoc6CtBMaEKa8bWYcAV0oTMjF1O7VdfbXkgKHQs2W10801ezR8i2ytYzxNKzOH2h409RunqaDrQ8FLAKP0zSvI+ALjbsQXPpocdDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LiousFGC; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReuiPjnd8R46y5ZENB64ze6k660ebYdP3KwnStZQAnKEMGsWwL+VOqBHknHWP+famm55poFfC7S7ABYevQYkE2Ec8eErvdhgqq8f/XN1MERI+87RNlR7IHT4I4WfuSrNNavaLQpwTp/h8fsZ/W+PygTpE8wNmYWQIZcSYnixmiVONHcasPHVmC6ByHpEo7Jz1OYhuHKM4obCQ3u3R5p071gAEm+VPfCQqJ25zAoDnYPkC2PwQelpKV+XQfVdjQ9MoCM1FM9SmgOeBDsx+IU3juGOoNEVFxjn+4u3odrS5TeblGKjD/qz8BkAmEoLAti76Q5yYhl+1Edd9gvwgXMsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRakDug/jpJw0UrxA2Y9i0iCdLPRdgTq7g8jQtiqWEo=;
 b=HYXlbvboy2/kK7sAFu5mIPNhUyeYaNC6fZ1Ma5f4aAjbZUseeD/NMU1Ec9Pb5GGkQoBQe8wmGQYAp4F+xysjFefqwDvw1cN2RY/iq2T8pNhVWfzL7ZWnAlfl+GD+bb2oIyeKyJelz8lgLKCWN9r93ZsTk7Je75sNxs1zbK3wpYPBHVxabcXrJaEuL3zLYOsmtnOYDnbojvrZypto4aBFY4TFmsMk2ygU1uTIuDzkGZcinP2nAvwPzMLV+aLeoCb7ZiUY0Id5Yv4QsW8HPmc0fPlfrUqwe0zH0XNRTflrVkyNtZzUguE5oYCF46+mFvprT+74WPH/ja4Nnld5voGL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRakDug/jpJw0UrxA2Y9i0iCdLPRdgTq7g8jQtiqWEo=;
 b=LiousFGCQ1Ces/c3xW7ZKG3K02OzoD0bildL0qc4bhWT+g6Ln6v2GvssG+uJ2b6aS+uQHGKQ4wEV6Lb1+64Tw/6zWRR7sNbqz+VMxAnOSJY2otJga4lh6bCIlRgSSdBAskYLH21CgH5zq3QQYodt6EQuVRshDKJ3yaBETIEnYfiylLit1z6ZHC3TthImUvwNYXZ3nDmox7dqP+86zySUydxkxpEA8c36uz/4JCSNTXNk4dEnwmIIwByzd531ah5/mGkVwrErDnHhKrhDk/cfHBeizuxujJp3zkfLd2Dt8IreyMBodvxg2vjLle8t8BhKZiarZrYiu0IQci8jQIu/uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:38 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:29 +0800
Subject: [PATCH v2 4/6] firmware: arm_scmi: imx: Support getting board info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-4-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=2282;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LCOZEYs6KB6gRmyFtzl92oM1LwcuHr4QB7pDlViZZXM=;
 b=31Iq4b4SNfTJ3LzFf04s9uc0GNZS1qNQSEmNu/0zykUDF3/cegoAynb1Uv/CokZioQttLTR7C
 tZDHcBAwXD/BNAKBzLT5jNEkGf8UynZXMjch+XvN9vhPcQO7clLnJh5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9fa4d4-2ee6-4b46-6ac7-08ddbf8cbf52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUMxNXpJQmU5OWJRVVBvOGFhWmR6NDN2OVJjbUE2MlB3OHFIc0JqT0lsY0kz?=
 =?utf-8?B?T1dKT3N1YVJKRW5CajhyV1dsTjRSWFgrUDZwWXoyT3BTc1l3RHRzSnN6eXRH?=
 =?utf-8?B?ZE41Mk1pVjhIamlraFEvMVlORm1sb21zVldKa041VGtacVNnQSswc2RxNGNl?=
 =?utf-8?B?QmljMzd4a1hZNXN5WTdKT1VnL01GRUJqYzFEb2xaNEkrK0lkbTB3dFJPbWJE?=
 =?utf-8?B?ekVRUjUzQVdkZU1mTlpnc0h1K1pqR213MndHc3dPaHEwSHhtMDIrSFhpUkU3?=
 =?utf-8?B?Y04yT2RRQUoranBtbFk1U1Z3RHNwZi9xWkFFdU5xMytaUTZmRzRjekxGMnF5?=
 =?utf-8?B?dGk0cDAxVDB3VlQ2OUQrZnZsUkJTWDA5azJKUy9aOXpBYVlYWk10T2VDK2Ey?=
 =?utf-8?B?Yytyc2lLdnkrMDRsSnJ0RU9OU2J1SytCQ2VCTmV0cGNGVzNLS3FrTkFsd1Vq?=
 =?utf-8?B?bXpRbWhIOStDZDNEQjNOeUZ0U0V1Q0lrbktPYlpGNFFlcml3RW9lOHlhOCs3?=
 =?utf-8?B?RFlqNlpnU0tPbWNpcTZ6YXg4V2FlK2xpYnVNOHFZZ1IxMjlOM29aK29NMTdO?=
 =?utf-8?B?L3dkZzgwbFNONmVNeUFseUxvTGlWWGFBajZLMDc0bk8zd0hXMWF3eXdTcEJs?=
 =?utf-8?B?SG9XWFVicmNycWRjVkJJeFdRcXo0ZVVkK09nSU52eTRlZnhXYUpwWk5KRFln?=
 =?utf-8?B?aVZ1a2t0YUFNak9lQXE2bjVSV2w2dFlsa3BXY21wd3pMT2NDNDBwUWFmK1Q5?=
 =?utf-8?B?R0o2SG1ocFYzRHEwQjU1dTcxQjA0RVF5cGJEanJvVUhWaTJ5KzFRNjczek91?=
 =?utf-8?B?Mkh0MXo0YUo4a1FxTEdtSGNOajduR1BxdnpUS2pkZHlCOTlwNlNPYWRhaWxQ?=
 =?utf-8?B?RmVHWENKb0tHS3JzUzgzR0JoOEp1aDdTVGZuaHlWa0ZralJwdUVjWmEydzdr?=
 =?utf-8?B?VUkxenBzWHlTNFVIb0ZpdGZBeE52aDZtRGFjTW5hN3dCV3dBUUcxWmtZbFl4?=
 =?utf-8?B?WE0raVlnRVhiRThiWFlXbDY5MlNid2l2bThZV2VVeG1KTk5XV0tQdDZFdkdh?=
 =?utf-8?B?SmRrYmZxbDJZMHcyRUpwTkVFbm8zUTV4MTVobndUVVZzMHZZVmE0U3lpWTVE?=
 =?utf-8?B?ZnFLR1JXVW5MRVROVlJWSy92Y2pEd2hubm55ZjJiZjZ4N215U3dEZzMyNlha?=
 =?utf-8?B?aUNRQXIxYmY4eURESmwxV2lIeERJMFZFT2p5d01rY2NiYXpmak9Da3hOV3g4?=
 =?utf-8?B?OUxoVjhybm9mUjZKVDFEa1QrcjE0dXd3a2lNTkE1dVBJUzQ4emZycTBlbUZC?=
 =?utf-8?B?b1dXQ0hobDZxMlB5UC9kWFlyeUZvYUxYSlJxemdjRmd6RnVtVXdacm8vRWRT?=
 =?utf-8?B?UG5ZSExoTi9sSDBrc05sSGNmekRJWmRUbUxpVnIwdDl4MmtGZUJ2WEp0bXZC?=
 =?utf-8?B?VW9MaFNaUWNJSHcrRmgveEFDaVd2NkJMU2tuc1R3VHZZVFAzSVVYTjIzVmlO?=
 =?utf-8?B?NmpoZ24xcDB5M0xiTjhRZmtGNnZpajdyUTFhc3JvZWRFZi9vS2wxNjUrcFI4?=
 =?utf-8?B?c04xMUdVeHBXb01hUitXTFE0S3JTR2RlTUtDVWhPeG56bDlqOFpmYlBzMmVG?=
 =?utf-8?B?V1BHWWo4OXh5WlNkT1ZSUU5kNWMxWXdGdmc0TVhIbk5MK2ZuZlJPN0d1SWxy?=
 =?utf-8?B?OHRUVmJ6dURSbk9FNG9NOFI4OUtlUWxPOW5PbGdNb2Jmd1ROTWlBL3JhVmVr?=
 =?utf-8?B?K3RDV0JCMUdNSzdEeXNlR1g2Qmg2YWRXTi96dGtqZ1VUZEd4OGRsUzFoQkI4?=
 =?utf-8?B?V1RFRE9rRHhmbjZUOTVpbjZjRFhMZldwZ3U3SHlDUFFlQnFiSVRWTnNMRlox?=
 =?utf-8?B?QVJXZTFKLzQ3MVVwMUdBWElXS1lJRkxRRW0rbFM2QUJ1NW5OQ29XYVMzN1pR?=
 =?utf-8?B?MGdDYm5QbGRBZERpRnhHcW5BeERVNkY4VXJ2cFJtSEZZV1VrTXplS2VVOHpi?=
 =?utf-8?B?U3FaaFhaQVNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3l3dUxaNkoxYmdUb2Z3cnh3U1J0L2tjbzVDOWtFS0ZPTm5xY0YzRHRLeGxM?=
 =?utf-8?B?akFkbVhNVjJjN1ZkaVV0MFJUNGVTa2JRa1RvcjFXUmdCVFd2YzAxZzFCOUZh?=
 =?utf-8?B?YzdIM1FJc2g0MSsvUldSTTlSZG1wMk9mNFFBbGd3aDBWVnRaTmVMVm9wRTJB?=
 =?utf-8?B?QzNSdmNsWXpBWjBVSDQwT3RNWm01RWpqN0V1SE5LOGdZS0xFdWoyM0dkbHRD?=
 =?utf-8?B?QmIrejhmdVR0V1ZuSnhEaUJaVGloYk1BL3gweGp4amN2UVRxczVuZmRCZU9Q?=
 =?utf-8?B?N2dLQzdzY1F2dU9GZEM2SDM1L1laSnRoUjdPTXV6VzdDNkRXbW9tcS9admRr?=
 =?utf-8?B?dGhWWThLVElPcVVFY2NkcitrRVFpR3c3WlNFQ2NMNEVaejQvMGRtWFFYQk9j?=
 =?utf-8?B?dWtwSy9zcnN3U21zNU5rTlJCWG1UdjFBelcwVmp0R2JjUnhHQmtVd3hlbmh1?=
 =?utf-8?B?cUR0M1BGMUhNRzZyeGx2RnRXZ2dkWWdwbkhjTFZHR3NRWGM1azdNL1BMdnE2?=
 =?utf-8?B?aWhvaDBoMnBHd3BRbWZuaWNpMFBXeU0yd3c5Zk5GR3R2ZkY5aVNSMzM1Ym9T?=
 =?utf-8?B?U255R0pqck8wclo3Mkp1K3lYREg4OHlEd0RZdUxmRW5ZRnZ1bGNTVTZDN0lJ?=
 =?utf-8?B?dlRvQlMxUjlEbUF2cE5uTXBkS3k0bVNabGdSRkhsR0pKaklZTlFXSjRPK2Vj?=
 =?utf-8?B?cDRCMHpDMks5S25tYWxhNTZnZXJmZml4aEd1NDJ0VnFYLzllbGs2ZTU0ZmlO?=
 =?utf-8?B?anVTTThnbVFRWmorSEI2TDBERTE0N3NBckU2aWpHSHhnelNYeVJSR3o0aGRJ?=
 =?utf-8?B?OUtkNEVPN0dTN3VicjhLRDlxS3haQzhKcEFVek5NUUNOVUd2dXhWS1pJdkZs?=
 =?utf-8?B?MDZBZEhYRTJSYk9LempEcm0rWDdjV3pXb2VENFczVnQyQ2U1aTJseFVWK3lp?=
 =?utf-8?B?TzdNWEVBak1SVzh6UzBmeFVSZHBDMXoyRlphaCs4ancyK0MrQmRLUy9xaWkw?=
 =?utf-8?B?WW9GenRnOHIrZ1JQS3FzekJGZWRTK2RmdUptK1N2UGh0c0d4ZUE3Yy84N1Yw?=
 =?utf-8?B?SDRVLy9wZzJoS1VvTWxRMGc1ajZyVXYvam4rZ0cxZlN1dGRTKzZZeHJMTjhU?=
 =?utf-8?B?M2NzUkxkTWdSbjRWS0l0Sjg5NkxmalA4SExFRXhkSjVGUWxYNTVXL1pFdEFQ?=
 =?utf-8?B?N1hGSkJuRkk0d0s1bHdqeEtmeUdyTlVuN0hHMytOWHRjU2FaOHJVMlBCSGQ1?=
 =?utf-8?B?SWRUYnFIaktOeFYxM2EwSzRXdkNYNDZMM2FsQ2gwRWdRSkpzdGRuZTdaMEVY?=
 =?utf-8?B?RmdycGxka0x0NVgvWjJCZFVJWTFBVy9iU3R0ZWdrd2NnNEpoMVBKSTZPcVFF?=
 =?utf-8?B?YnUvWHNRdDhTNVNZUGtnZ29SdG13NFo5Wkl4VkJZMDhpbUVkRWFsdVcxYTNp?=
 =?utf-8?B?eW8rQjhqd1d0K0FzYXczSlRRMjV0RkFYamg0SjduZU1TSm1zYithMmtOUGN3?=
 =?utf-8?B?dzE3L3VLSDdqVUJUYXMrMkpJZXM1dnRVaHMzbitCMk5pRC9UblFBeHdRcWdN?=
 =?utf-8?B?UDcxRFV6VU9CU3ZNcXluMUs3emZKODhSeCs5eXVIL3R0Y0kwcWxjajR5Z3JO?=
 =?utf-8?B?N1RhYWxUTVZsMkRRRDJ3NExtbHlzRktnRCt4TXVOTnF6NmxYb1Rhek5NN25z?=
 =?utf-8?B?V0VOamhyZ3BXMVlzL2ljSGU0dGRwWWY0SnJ3ZFJFWGo5NEpDY2NuSCs3NGJn?=
 =?utf-8?B?bFpqK1FQQjlkS3hGNTdwcm5mU3pDTG9tTklEOFdGeVdmS1RJbzFRN3lQZVM5?=
 =?utf-8?B?UUZ4NVNWYnZ4ZHJWbU9SNmUxMFNxMEJnalpva0cvcmVuSDJtcVpZbVZZZngw?=
 =?utf-8?B?bzJyYS9jeEpWSGRNMnhFdnFWWWZLa3FDYStiYWthN1ZzZ1QyRk1yRklpeVNr?=
 =?utf-8?B?ZWI0WDlIbDNIa1AwN3piWmhieWdmOHB4VzJab3NCckE3am55VDRzMHZwV2N0?=
 =?utf-8?B?YXA0bzNSUThHWUl2M0pjSm9LeE1vdFdBbDZVMEJVREhjNkZ2ejFLTUROdEhy?=
 =?utf-8?B?R3ZpeC9lRUIwS0t2eWtBMTZBVjI3R3JsR1orLzc0clp5V29PRnV0dXczdGZs?=
 =?utf-8?Q?d93CxFMF/92irSOL8WI1dgSC9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9fa4d4-2ee6-4b46-6ac7-08ddbf8cbf52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:38.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaFxKHAJl2CGqCplde9Yafa8gIW/rDhZqKWjExdvivM9uT0L93ZPaTtlSNCCVAbMN69AKsH/yrO1ncyzU/vBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

MISC protocol supports getting board information. Retrieve the information
from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index dc6ea67255b8b1ac95dfb552fa88b65044de8d3f..6b86c35c192d02e13f0d2a7d713bc447886b84bf 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CFG_INFO = 0xC,
+	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -76,6 +77,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_board_info_out {
+	__le32 attributes;
+#define MISC_MAX_BRDNAME	16
+	u8 brdname[MISC_MAX_BRDNAME];
+};
+
 struct scmi_imx_misc_cfg_info_out {
 	__le32 msel;
 #define MISC_MAX_CFGNAME	16
@@ -317,6 +324,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_board_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_board_info_out *out;
+	char name[MISC_MAX_BRDNAME] = {'\0'};
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_BOARD_INFO, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->brdname, MISC_MAX_BRDNAME);
+		dev_info(ph->dev, "Board\t\t= %s, attr=0x%08x\n",
+			 name, le32_to_cpu(out->attributes));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
 {
 	struct scmi_imx_misc_cfg_info_out *out;
@@ -372,6 +403,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_board_info(ph);
+	if (ret)
+		return ret;
+
 	ret = scmi_imx_misc_cfg_info(ph);
 	if (ret)
 		return ret;

-- 
2.37.1


