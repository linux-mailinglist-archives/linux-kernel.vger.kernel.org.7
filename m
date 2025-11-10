Return-Path: <linux-kernel+bounces-892337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74C44E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E5A188B6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D64369A;
	Mon, 10 Nov 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCCDT4gB"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0572606
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747370; cv=fail; b=AcV+s/AxMh4Xo5Wn0OIXJieNB7MaulwCr/ajhbEErdhnO4caGmTlPXQpE8PBzpqctUwJHUW5YSTz+pwDaY7XWkKt6MRgFVWcbk3oSGEWAxUGB/bYVb4Th318RAWTNxvLIU4njktDPem8hoRUTqz2Qz1/VRSdIEMXx9IqQJuwrxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747370; c=relaxed/simple;
	bh=AEmdpIgehxBqTPATBXg3bh1oL4DOCs3SaOKTDPbvGgA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uiwUp1xU48Xw8MHo6odAd6nWTu4kVZGrQ9m085Gb74Vh0cV6MwWtKbSp1yNM/InhAolGXV/YFH3fa0oCFiqKiqwQhnwfzn1EPPZdWMqP4SZTKA2a4AazwlNzVLBe6Ej+8OG9/sZI5wntczOfQsnTbMngtB/34nBzMBa2wlZWdSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCCDT4gB; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GInNWMWZvMA6YJSe+ihn5PaBmIeXhg0rBfvq9wMCcjxE4sDHbrUdRlkbOkUc/mJYO7w1FGHMhxoCaEbrEpwMliWhkCb09RniLHEQ0NLvZwDQCSPa7jy5J4APsSodiRXqAFNBPrh6AHdD31qTYPnIFwYox1Fx33D43GkdsWWfL1o1jHvPofdzu8hEL0RejJUNuWoYFJtHS4i3k2pBmRB7XLPmiWRO5scGu206zfq4Z+Q+tcU1sbNEN4ae8jtlCtJW9X49gQ6FlcHC5kcU3CV3bPyOkOdA27MbrKRaogw28Y/qEGg7g5S2TfSAbuQT4N/lD4FZz6G064AWY0NXPAu7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnx+aouHFP9/8572ZzPrZP9xOhsyZd/CPbKwL0LiZ2c=;
 b=zNkcbxflaPrEchp0U1qRmBeWBye0fweS7IbCiygAHHqHjpGvIgRjF0yS6B/vO4MszPdGB4fFNor5jG2m4tATgRpitX/ZZcH8q2buUkrOey4gLwbTC7/rufEGFuC68Pl1SnZFHrS+3fTRl7n4OVrjt5JpO2EYsRqOyraEMO1G/8plTvc3IhnKId6fOSS/BxlB+HEtH5qPV5XSyHq3KZFqPnhbXF64pFLZ3nRDgVYyP0XR8HzW9mz3GiXbUgR5a66qCVJDR4qBs60jvc8JetsmEwNkalwlMLeeDd++W9HcZpZdBXdKAuZzlgBQCBV75QGp0RPYXtPqRqDhY7oYe1Gxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnx+aouHFP9/8572ZzPrZP9xOhsyZd/CPbKwL0LiZ2c=;
 b=iCCDT4gByQVga9snvmuve91jmL446CR3J6G+yUryxUN2iOzoBjJjjx+dXFXZBx4RbCIVSg81h17Hf03UzNIdnQl/0d6iQj0Dn6WMqjMHHiOCkiQZo9ryGaO+sSFfmBZGPREmA/HazrNszGgpVngE8tAn3GGT82ggHSo4g96jKRAe168S5ZrVLdQH2yXKzZJD46QRy2zL57Tnl1M7jPGEserfMxR+HO2iWB7XQz46hLMXnYTbWrO4w0q6TBYk/YEJfJKACfyT7FCed591E3PeHAnzZ313ZeHrSn7P+mRqG+mHJW15usnUyEL5MYNGrELr+Jqe645KNyVCz6WKwBMXsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:02:46 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:02:46 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 10 Nov 2025 12:02:56 +0800
Subject: [PATCH 1/4] mtd: spi-nor: micron-st: rename the die_late_init
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nor-v1-1-cde50c81db05@nxp.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
In-Reply-To: <20251110-nor-v1-0-cde50c81db05@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762747415; l=3670;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=AEmdpIgehxBqTPATBXg3bh1oL4DOCs3SaOKTDPbvGgA=;
 b=9hYfaMuhKe8mmB0Wy8+LgSE5QUX1S6VFqNLZSq55Lwtzj8n3JWGmzSQrPfjGs8I6XnmSYvSeG
 cGkvbXNdYYFBVdIe7cHeDsayTR+Hv1Ei/1EUJ9+c/t+ag6S2sL0UGxO
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 566226df-cca5-4ed1-d42f-08de200e0195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFF4SEV1VHljOHV0NGJ0QTZhMWM4Y21pS3V0Mm13ZWRkZXFLbVJIeGJyWFd2?=
 =?utf-8?B?TnprRTlKUlM3QVYrcGdBTVZHd2FoU2NqWE51bGh2cENxTjlKcE03SGNzTGk0?=
 =?utf-8?B?SlJxRE5nOWVzMVdzd1lwNUIxMFVMRmFBVy9zQzVnKys5WU5JRlVJb1ZORSt5?=
 =?utf-8?B?MnVHZVM0eUlKbStxVjNhY0pZMDRMOFNiQ1RvaENnZU82Qy9lbW1PNzV5aDAr?=
 =?utf-8?B?clhXMko5OHNlU1FHeVduQzJLeWdyaXAxOE5HRWEwdmkwVDdsbEVHZ09WNjMy?=
 =?utf-8?B?R0ZaMlpVNXlJUEg2OFIxQ2REQVB1cXQvTlQ4di94bUZDTFV6NnF3NHF2U05k?=
 =?utf-8?B?Ukk1NjdEdmljeDB6SkxkQUFiekhLY3NuMG9FN0VldEpwNHF1aVgvWHpESTdL?=
 =?utf-8?B?MHRybjNqQmJBRFBxT3VqVlNTcERLaGZ2MVRlTkpxK0ZtUWxNT2JXeTZ3cG5E?=
 =?utf-8?B?TDFjTUJid3B4c1RDMENWMC9WbE0vQUhEdFh1OG5Ea1B3TzNqa2ZLV0t1YTdR?=
 =?utf-8?B?NmZ4Uk5TMzl6V081OXhqYzlKcVpxZ0ZOMXlJaFp0NTBVeTJ1aURna2IvM1Ro?=
 =?utf-8?B?d1dDVS82cFNCTkF3V0luRThPYzM2TjZadVRSM3F4NUxXVEVVcEswazN0NENU?=
 =?utf-8?B?d1hyd2JZeXlabmwzYmVxTFY2OXI0YVdnU1Qxa1FpRm5wZy9KOHI4b2RzQTN5?=
 =?utf-8?B?MEpsTUdERkxSMEFSUU50ZHVQUkN5Qkh1RCtLZ2ZGWTQ2UTZHTU01QW1XUlRV?=
 =?utf-8?B?T0xCT3ZKNmd5Vy8zelJPU3pUMkNNbW1PSDV1OVJrOFVzeXNzekY5SXNiQ2tl?=
 =?utf-8?B?SzFHay9nU3BhVTA3OUNsbUhQRHZpajF4a0dIVTVGY2ZPL0pIWFI1Y2ZoNFpK?=
 =?utf-8?B?YVRoN0F3b2FzRWo4LzFwUjhhcDg0cXBrc3ZLUUxjWUVPV2t6Q3ZZbVlKdjhl?=
 =?utf-8?B?YlBlL1I0ZW4rL1ZxYi9ya0t1TE1uTEZHQStYR1d5dmVqemVoaXdrUUdaTUR1?=
 =?utf-8?B?cmRuSW1pQzB3VEd4ZjZIcHN0SnFrTWplcUVaTFRoWlhnaW9jWm5tRmhiNlBt?=
 =?utf-8?B?d0hHejJHcXNyWCtPVTdHTS93Y2htUjRFZUhERVd0Uy9WQnVMZW44TWxCNk1Y?=
 =?utf-8?B?bk5vcGRiZ3NmZGtMeWpSQ1FETGxZd21zdE80Qzh2QTh4dGxZTnltOUF2Mnht?=
 =?utf-8?B?dzFpdThTYkJydmphQ2FCMldaVU9MOGlHMzZ3VWhKMHlkSWk4Ulh4UUZlUG5v?=
 =?utf-8?B?WnJTWmdpTlVTYU90L2h6WXZzRmxQY2VyOW9mc2hiZGNDRGFCZWdYMGJaU3li?=
 =?utf-8?B?WCt1NHFscm50OEw4SFhtMjdrWll2azMxakJmMk1FMEdueDZFeHNPYmpEZ2Q2?=
 =?utf-8?B?V0t1NXpHTmYwUFNkWTc4cjhxTCtZb1dmYU42d3F4YVMrTytzcU13ZDBjM0ll?=
 =?utf-8?B?REhKa2tOVmVxd1NScDVUcFd6M3dXclprV09UMHlsWlk0TjJZa1p6YjVaN0Z4?=
 =?utf-8?B?VnRka1A4U0hBbGxpM3Y4VGI4cTU2RWZWRkUzOVZJQy9kRk5vU0VFeFZvdWVx?=
 =?utf-8?B?cXZqRFpHc0YrZlBPTTY0dHl3ZzZ2V08wZ3k0ZnhSeDRpU2VaRnRBdHlqdUdy?=
 =?utf-8?B?V1dldzFZdXVFRWtmTnpYMCt3NzNlODFaYVR2aFJIdXBuVzlKY0xxbTBURS82?=
 =?utf-8?B?VG83YzRMT09uR2tEMlVIMTFNc3B4d09MV2syN25GZFNrUmRPaFBpdUNySnJq?=
 =?utf-8?B?Y2d1Q1NNQkJxOVpubFgzTkhaZE1RY3BZZy8yTlhwN2xhTXdNY3NpT3BacHM3?=
 =?utf-8?B?YmZQNHgzVVNnVkxNZXBWYytvd2JFdzd5d25hb3NsQXU3M2cwRUJucEZvbmE5?=
 =?utf-8?B?aDViRmJMa2lIbjdZeUF6TkpucmxhRGxTdDI1alByQVJRaEhJUCtOTEtSdlB0?=
 =?utf-8?B?ZjRiYkMvWCtmU2IwMG1WZmVYcFJHd05tb0h0K3ZlWHQxTDdzN1NWQlJxTklk?=
 =?utf-8?B?eENrNjZuNGJ5VkU0aXJqdXR6Rk5Fdk5VaUtMZDV0MjRwd0pRdzh4KzQzQVd6?=
 =?utf-8?Q?6rhzn6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dURzaEFUVkw4QjZhOTNmYUlDZGhNNFdIVlIrVjdtVncwZmQwSDA3RjVnRFBx?=
 =?utf-8?B?dTJKVWg1c1ZZRHBiWS93WHE1S2hmeUhmaGdIZEc3bXdiOHBGcXR1ZHJQZFRC?=
 =?utf-8?B?cGlhRkFPS3libEJKZXk5Qmpia3lMbFIrMlh1RjVGcXo5NUYyYmxzNDNiZ2ZV?=
 =?utf-8?B?eGsrV21vdi80WkdzMklWR09pd3BaYWtxVHYxZzRKMzZ1QVdKcUVEUTBOYTZk?=
 =?utf-8?B?b2h1NE5IVGNFVUhhb2ZUd3hyN1daNDZhYmVtVTJ2UHZIdmxMeWZielJrT3pu?=
 =?utf-8?B?dHZDQnFWbEY1WEpiY2hiTFljS2hsbEtqMis1ekhIYW9JVXAxQ3RMTmRHVjkx?=
 =?utf-8?B?SmQ5aXlzMnJGR21Jd083NWFHS3RPKzJPWUFYZnE4YTlpZ2RGZDc1d1o2REZl?=
 =?utf-8?B?ZDYwSEdjamh2WG82VjRpQ01UTWpwSncvK2l1ZjhYdkFqakV1VjdkZFl6WW41?=
 =?utf-8?B?YTJETjdHOVdEcGFMQXNWS09EYno2MUZEWUJVUjZHWXpUZU50cEE1Z2FQcEZj?=
 =?utf-8?B?cHVqeUxOZ3RSVms4eGFiUWIzQVh5QmxXN1kvQ0VQZkhnMzgvTGk3Q0t2QVVO?=
 =?utf-8?B?ME5abUxzQ1d2MkF6ZkVvNGYxS0V2R0NnSlVDNVNhTEFaUUNDU0R3YldLSXNX?=
 =?utf-8?B?Nm41THo0N3I0OXhXdk0zS0Z1M0crNG9RbG9OLzVPdW92QUg2WHl3allpbWpE?=
 =?utf-8?B?RWp4eXlMTWVqbVVNazk5SklFR2JsMzhYNkxNdUJNYTY5V0JHajhNbFNHSkJ3?=
 =?utf-8?B?YVVaMzdGRUVwcmhYWGg4U25QTGxQSHpTNjNHVlFtUFM4d3Y4UDNjTTVoTXd5?=
 =?utf-8?B?TzljQmNTcEJ1MS9rS1Q5dktYMVQydVhQWEY1aEMzL2pBcXRuZGlOY1BsM3Ar?=
 =?utf-8?B?Q2xPWCsrZHZBZHk3THBGN29yZXRxQ2hCbXBrZHZkclAydzN0MmVOdUFGanFU?=
 =?utf-8?B?WVphNVZIcHNHZXI1bG9odlBxM1U2dDBkS01idnFzdkt2Z1hQdExlNXJkUkky?=
 =?utf-8?B?WlIxUm5vcXhibHZuM3RuMmdHTVlmUHhPTlBTUDh1RnJyKzd1YVZnbTVnRTJK?=
 =?utf-8?B?aTNYWlBsV0ZxRlNCeExad3VWc0k5MkY5QkRjS0VLSkl3c3BQV2l1dlZuak5r?=
 =?utf-8?B?bzNFQVBiQXRwVEpZVm5UbXVqVWU2TzVCbDRPWkNKaEE2eUMzcUN3bktwYVU0?=
 =?utf-8?B?Yk1ueFhCUVo2N0JGWTUzaW00SWZ1aGhGMVJmYU5ZSGJRMU5vUlVHVFJab01u?=
 =?utf-8?B?S0w2S0VoYzVESWxrbWI2ZGpPUnBleWxFbkJWYm1raTlUbGFOZHNWaU9Vdm5V?=
 =?utf-8?B?bEJIZTlYTWNhbnRPdFBwSkZOZE96dEFqaHZocE1CRnN5bm5QaWsrL0VXYUhO?=
 =?utf-8?B?NHZJakRFN1RGN3k5K1FkaWxoRWxuRS9IOTlkTnN0d0EyMFdVcFU0TnBDd2Jn?=
 =?utf-8?B?MTRFRjFkdDd3VnRuWVZVcUhMNE1vQ29naklSdU01K0pIeGpMMUpPYUM2NFpu?=
 =?utf-8?B?QmtkUzQ2Z0tuM3VEVk53VW0rQnlQNGpwOHZRaC94U3FxbzZQSjF3RmU4Nlpz?=
 =?utf-8?B?T0ZYOUhlditJOXQ4RUpRanA0SUJ4L3BubDBEZ0xROGdyZmxLSlJYb3V1M05V?=
 =?utf-8?B?NDF3T2I2TUhFS0hHT3NpeUFSSHBPaEtHc3RRd0lPRzczY1R4VjQySm5JZ3JC?=
 =?utf-8?B?QTBRVnNLUHQ5c1VFMm53L2RjYmpEN25Wb21TUm42R1pEWUhvVmhzOVc4OUpv?=
 =?utf-8?B?Q2xrSXZCZVdyVkExSlVsa3ZFYWdwNjNtcTFSWVEwbjcwalg1WG1zN2F5N0xj?=
 =?utf-8?B?VFNEZS9YZDY4SjZQN3NWZldXUExtemdZL0VOdGdVbWpWVDNQcTNPZ3MwVXZN?=
 =?utf-8?B?Qk1rUmRUY0xrdmRpNEh0Q2FKd0tDaFo0Yy9PWDVZdjE3VjQ4SnNBL3JvS3hO?=
 =?utf-8?B?aWtPaDNkR2xVNHJxSHFVb25ZTWpRNFdmVEhId1NmN1RVc0RlNVc1WXp3bEdl?=
 =?utf-8?B?UjNidnFvcE9SbVN6T0lKUStuRkhZc2N5b0NHd1ZDNys3ZkV3bEVqMmp2ZU5N?=
 =?utf-8?B?V2xEZHlkUXN5SzZuZlFnRDJkYlBSRzFEM2h6ZGNGTzdzcUkvMEJJVHV2aGZs?=
 =?utf-8?Q?DupA1Oc+3A27YEDEL8PSjfqb0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566226df-cca5-4ed1-d42f-08de200e0195
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:02:46.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDUiJlsBPiHEzwfbCL0SaACFZxrQ2YObdSJlxaoBMOCcmAigJf7iIFyV7sTT/UiRhvWiRsR8xwv8926pFTeS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

st_nor_two/four_die_late_init() also suit for micron chips, so
rename to micron_st_nor_two/four_die_late_init().

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 187239ccd549510c6e9a6eacf4ae41158287e077..92eb14ca76c57f29ece1edb3fe652c56d1c2888f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -127,6 +127,38 @@ static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 			micron_st_nor_octal_dtr_dis(nor);
 }
 
+static int micron_st_nor_four_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 4;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
+static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 2;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
 	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
@@ -193,48 +225,16 @@ static const struct spi_nor_fixups mt25qu512a_fixups = {
 	.post_bfpt = mt25qu512a_post_bfpt_fixup,
 };
 
-static int st_nor_four_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 4;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
-static int st_nor_two_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 2;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
 static const struct spi_nor_fixups n25q00_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q01_fixups = {
-	.late_init = st_nor_two_die_late_init,
+	.late_init = micron_st_nor_two_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q02_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct flash_info st_nor_parts[] = {

-- 
2.34.1


