Return-Path: <linux-kernel+bounces-758551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F8B1D0B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EF37A3091
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9FF202F8E;
	Thu,  7 Aug 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQur6lz0"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4014D2B7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531296; cv=fail; b=K0RIP/xoomTzWh/Y1kumOWD4WNKCMwATODxQ+5xVXECKjNP7e6QRcNonkAFOCa6UwHRDGYezIl3lI/lURs07gTFpMWKFMUvIHellWH6vkXwdKaQ4FE1O8Q19szRyiBUFAXdxF9FZLzgCVEMBQcTSjjhxKxQ5gRcYwykqCXAikzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531296; c=relaxed/simple;
	bh=NA3EM8mRQtWt9eIBoeKlwwCuZa5HZhga+rB95EyG2Hc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G2G7KHrO3Owxb+8HZSExtiEw7p221Oz/ysCwlNLIkDtovcg3UCW3AyEJXe0zFwRYwOcY5oeGZhd2g+I6YhquA6oMxuP2IquMgJUlMhlFG4XZOXA9N9WZ3BB9LjpjL5yZZt+jtlSeLl/fme26VHDAX1MTG9NxuXQ9TkIc9GMHe3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQur6lz0; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOLXFNLgyp9VKwg8O7The5uDD7s25q8m721HtFKFBQPFzfyB1l4pOsljUjxYWA6VDN4U16HCt7F1dI0g88ekDHEUSOJ23T0JqqY9z2KKLHR2PBSElibkxeXdRbGM42U6EmuDq0TLh14zI1yCP2fyKQcl+2IrSbwjyo2j4dREGq0Bo7gA8OppNU3yLBtNVLqEoVI/wTsd07pzFrjY0fyGfxzLKa3BFXRFGb43Lpjtgl9vVDXECcn78dQ3CRBUHXWL85VrjTwqL9e9oGhpUWq7TSzzObhRhIpW/mzsFhsfOKl0OHMjBdJR3gOj4EY/ISOEV3KAX7j2i+WMDP0CHT8vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbdZtq3D2ExEYc+7zEZaszl3rsZ4HQc51OsQEIzrlMI=;
 b=jKODTQaGpPDB5cQpiKrfKScuX+85+1LP4/Eh6fVJ3hdKnGrmjU429V7w7BKZA1EwpfXG9yWxY2tM78WQX5zw6VyekKDoeb1sMz6BOm0LXIKvJZuiACOgeq+qgb/DQI/2vtZKURGRuuEH3pwX4OmCB8+qNK3Q0sL0flEPzOpuH5PROhqnWjgH7D/sQP9mToq4nYQylmEv+tI8vn8v/cUF96s5Fbu7hGsDiafmpfUIcotdErfglOQ+VlOCcat8YaI6U7DOcBP6TXQwS93E7Cw1sYdouNFn8E1pq75a0VkRuN3Av9Rq4NX4EP6Q3hrQuHdt9Z1Zt5eGH5hkDqlQiTFihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbdZtq3D2ExEYc+7zEZaszl3rsZ4HQc51OsQEIzrlMI=;
 b=eQur6lz0FMArGChH2e0aj9iDWG7zxFfVAIn4UCXdTn2kYJ1H02b19O3uY29j186YYb4dgE+QQ/fdR2KcJmO0EvIJaxuW8sSZ54Fip+xf8W+Tbzc2IY829wMwoYq9XLRJSzVESlZaH+GWlr5bdgZdUdlawqPBSxpPIMVzc5E3eGhD0rKFDZl1i3izJm2dPxeJK431PhcgFPVUpn2YzXlpvrnX3Mf+zof6x0PWrHeta4hVYXFk6nxtQYID1sjpVwTOv9VV+a/ZxqDwhW51+pbWhWe+e/GpEQAQTrBL6XO7lArmN4jGrb/Kn0DL1Bs4NZ6ox+ysftwMwI5T2TmNCwHiLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 01:48:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 01:48:11 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 07 Aug 2025 09:47:43 +0800
Subject: [PATCH 2/3] firmware: imx: Add stub functions for SCMI LMM API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-imx9-sm-v1-2-3489e41a6fda@nxp.com>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
In-Reply-To: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754531281; l=1753;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NA3EM8mRQtWt9eIBoeKlwwCuZa5HZhga+rB95EyG2Hc=;
 b=SSUSxSJlNyuuD+u1rilRCGFmk6EDlj0ARWtM413hTAtt+9/nJEthHFxcIX/uwhwVfAu39REpq
 9g2tn7CMwaKACKKcb1RsCgtxA3mfFVSNvodQpjz28QiCPAHIvSkvW5O
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a27c1b-e20c-45be-604d-08ddd55477a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjlhYlZJcGlZaHgzb1JRVzY2ekk3WHFCSFB5T1JOaWhUdlVXYmE4dFR2Z2Jo?=
 =?utf-8?B?YXg3M3ZWd2VEZ2dZcGtoT090dXk5eXFjNEhuSndkeDQreGhBMTd1Um5hdlMv?=
 =?utf-8?B?TnVtRFdVbnZSdHRtK1NxV3pCMjFGTWUvTWUxNFFxNUNwM1BIRmI0czcvU2lC?=
 =?utf-8?B?Y1lLSmxXQjhEZ2xlakVSb3U0elZZSE9vaVhIWjJ5aEorRW5DZzM5RFJidXJv?=
 =?utf-8?B?SjRnOVErRlRHZWdsUXk4ZytlY1lLVG85Sk4rSm40TkFtdWxOZmN1TW5vbmJH?=
 =?utf-8?B?WTY4TzBmUnlVV0dlYjVqM1pQU0h5M0NVNzk1SkJieFQvYWRjY08zQ0RxMVZn?=
 =?utf-8?B?STNCRzEwUG04K2ZCemV2VGh0eFlFbTl3S1NKb1duYkdmSXZFNmFVcWtObG5x?=
 =?utf-8?B?cmdnclo2NFdNdFZWZGoxSE1QNld4SlB5eTZlWmRhOGNFK2JneU5UdGtDU2hM?=
 =?utf-8?B?RzhLRDJndS9JV0V4TnROUmVOUUdOUDFDTGYvTzU3ZVNzelY3Q1FvOWZjd1Zp?=
 =?utf-8?B?S2l4TXFOcTZhbm1PaS9Fdjg3TSthRXZEVkxIY2tGZDhUTHJYa290S2ZZU1BM?=
 =?utf-8?B?ck9NK01YejZIeDF1ZkhPanYxcmNIM21WYmpUa0lvczhYcFFHV0RBNE9xMFkv?=
 =?utf-8?B?V2FUeGV0ay8yYmROaW80WWYxUm1ZODNoSk1BcVFDSGNGVHd3UEdLRHREeTl3?=
 =?utf-8?B?dFNSRldreVBVNURUenhOOGtJdi9pRU1WU0lQMTEyN0xvbW43aER0aFlMZkxw?=
 =?utf-8?B?Qk10ZTd4bm9qT2NKK01Cb1dZLy9mdlo1VjgzdThvZ3UwK2d1aEhnMTg5Ukta?=
 =?utf-8?B?eXVRSWxnaEltaHpUdVh4cm9HcjVWSHQ1N3NlQTBRK1JFMnFLWW8yNHNqeXNE?=
 =?utf-8?B?SFl2Z0NIdmhnTWxrbmR5MFFIQjlwLzB3VlZTeDNnSkRXcmxpd1pKWTlyR1hS?=
 =?utf-8?B?QWtUc05BKzVLVkxFQUMrSGdTSFBSOCt2ZW9QUE5QbFNZU2U0RTlUZ2VJTE9K?=
 =?utf-8?B?NkFWNEdkZkdoRGZJRVl1N1JIbURlZWFyTzBmQndqcGE5VGVvTjg2UFNFSENv?=
 =?utf-8?B?U0NwdVlwK2hNb2tSRlMyaDhCMk9hYzhFSzQ0TnJpTmM4YWtZTmlYdlRWOCtY?=
 =?utf-8?B?aG9Vb09iQU8yN0ozTVVHYjVleHM3RW53TGxaYmNDM2d6VDQzUFArUCs5a0Q1?=
 =?utf-8?B?NzBZMjRYTkh3dWErdW9BQ3FPcEpIM0xFcEZETlpJelNkQlk5R1VoVXFiczgy?=
 =?utf-8?B?ZGxvQ2ZidmM3NG5vOFh2K2FJMnNMazVoU2xhQ1lBU2RpcEtudWNoU1RkSmg2?=
 =?utf-8?B?NnJrb1FrTzFzLzRZWGVScU5UWHdhcy9hSUZHM0txd2s0aFRmQlhkR2dadFVo?=
 =?utf-8?B?YnZ2M2JIVExKZjZKRU1yM0VZWHBCL3lZMkQwS2o5M2RsM0dBektPaXhrUS9z?=
 =?utf-8?B?Nlo4YjlyMnVVZWVNcmF2emxKNHBESEI1VitpZjZGSmVYUU0ycUlna3djcHZ2?=
 =?utf-8?B?akF3MG1ncWlWTmZNSXAramRibGVJTkYwZjlLbzc4Q3hUNldYNFN3UDMzS09S?=
 =?utf-8?B?a2F2N1BHZlE3dzFYbk5kbWQ5cmxDWWE3c3lxbVE0TTUvYVgrTE1DRnFvTjRO?=
 =?utf-8?B?K0EraEJybGVUK1JtTnVGZGx5TGRiMlNEQUxyYVZVd2M0Z2FtSlB3QUF4ZnRx?=
 =?utf-8?B?a2ZSZXRqZXNZaCsyVGdIUmZTd3E1OU9malMwWGpEd3BMekRwNVRCZDBqUmRD?=
 =?utf-8?B?SFR5akZpNFBhdmdoL3VTd3h5dE5RSk5uN0VIdkxXYXF5eW1XZTRxUkI5MGhD?=
 =?utf-8?B?UjRmOUFURnRFWjRLTk95T3RnMWNYYnNzTFA3NUF1c01YOE1VQnhCejFvczNy?=
 =?utf-8?B?WFJuS0VzRzJmbytKbHc5VGp1YnlMR25BNSszc0hhcm5uTTdTZ1c3TlVjRzJ3?=
 =?utf-8?B?WlJiVW0xRStGNXlTdCs2SERwSXhWSDdhWjJQWXFqUU00Zy93NEVSSTVjUTdr?=
 =?utf-8?B?YVlOSEpBTzFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHA5UHhFY2wwcXRNTkJGTmhReU1LbWRnMW1VOWxpZ3V1SCtwUTQ4RkgvMmtl?=
 =?utf-8?B?RUZvdlArc1lzOE5sZVdqNWZMSTc3TmJqRWpsdEp2NEtJaG8xNk4wK29XZGVk?=
 =?utf-8?B?WjJ1eTJaZ0xiWkpFY0dJRTBpU3hWWEhFaTRSTGZaMTZmeXE4dGQ5dFV0Mis4?=
 =?utf-8?B?T2FGYmNLZEFtL0tNOGVuQm56aXVQOGkrbUcyWjRNTSs1Mmt6dFhVT0ZIUGhv?=
 =?utf-8?B?OHZmUGlpYk5xQU5vTjNQTDQ1Mmx1aUk0bmh1OGsxWmdiblJmVWZ1M3ZmcGM2?=
 =?utf-8?B?d3FGZDZseEVVY0dJU0xreFh2ZDRrZUpvWHF0T0ptY3cyUmVta1RCRDcybjQv?=
 =?utf-8?B?TnZBM1k0dXdDOWplZUdLcXJqZWtzTzRDdHVUR2huMmcwUjhoc0RhU0U1Y0pV?=
 =?utf-8?B?UTAvL3A1ck8zbUFFTHRJajZNaGFVNkxMdUNkeHZYTkFyTUkwUVJSUlUxWm0z?=
 =?utf-8?B?Sk84S001WVNCYzZ5aHozeXUvMUYvTVpZQlVtbVg4b0tpTVRvd0d5aXora0xl?=
 =?utf-8?B?M1pTUTMvRFQ0N0ZSQjVPMGg4OWFVc2d5OEE0ZnBGdll3dWpna0x0K1d5WjND?=
 =?utf-8?B?aU40bTRGbUQ5cC9BdDZPdFQxWkhrS21YR1grVWZuVGJQSlpHMnk2MW9OcGZP?=
 =?utf-8?B?Z1lXUzN2MU9tZUdjcytDWWVsZ3Z5REN1QUtRTThQdFhIcWZvc21OSVk4MHhD?=
 =?utf-8?B?TW1MYU53dERJdlBiWkRQVGk2RC9PYnBmWlNkemdLaC84UjFQNzNYR1RIbUo2?=
 =?utf-8?B?QWxEZlIzVnNWYUN5czJJSWpXdmdGNWNkOXZjOGdjM0JVVFM5U1c0S2M1Nk9u?=
 =?utf-8?B?TklmdDRKNGRvNi9acVFhdmNUSTVZQ0FIeHR5OXg3WHhpNFRoNWtjR2VDS3F0?=
 =?utf-8?B?dGdEdi8zbzJabTNoZ3dJVmZaUzk5UjkyZ1BLNjJKWTcrU2h4S2NiYjIyQktZ?=
 =?utf-8?B?R29uNFg0dGpFd1ZOeVJybW9NSUxDVFZWc1JtWmlNcWM5dmRmUXdqMmI4V1ZG?=
 =?utf-8?B?UmN6ZFU3OUpqMC9tKzE0M09TZVFpdzFzY25JUktFYmhQdkhBeHAxd2hHeXN2?=
 =?utf-8?B?bmpVakVmTVgxa1YvVURYNjJHRmRUKzk5Q1N2SlFIN25GR21LSklIU2h3b0F1?=
 =?utf-8?B?ekVXbGJrZGd6VjR0ZUN0RWlDaHV0WVVocWZXZVk2NllqV0FlU3RqOVRBbDc2?=
 =?utf-8?B?djZpRGNhV0VmbHVnN2E3amxTeklOdEI1Y2VDT0F3TVNqaEpiT2FIVWM4K1dv?=
 =?utf-8?B?ZHl0QTFYSVIyNFpaMjV2ZDVoZEpKTGxMQnpRcXlLZ013TVBYMnNmbEwwVGgw?=
 =?utf-8?B?d0JPUGwwS3ZpaGhidGdNMVBhN1hqbnlSL2twQ1lrL1pLVkk5eXlEdExYYTBR?=
 =?utf-8?B?SHFmV1MvRU9yeHBKREo5cmFqYlI4OE9HUHdVZGk0aFQ4QnhvNWlmQ0NIaFZp?=
 =?utf-8?B?d2hZZU9rZkZkWlJYOC9MaTlsWUphMU14bVFMTlBBYmxGalRQd01kVm5PQXBU?=
 =?utf-8?B?YzAwMWpVUzZZdUY2N2V5aDdJRk1vU1FCcXI4aDV0VGUwcy9uWXo3amp2c3E3?=
 =?utf-8?B?T1BOdGJrWkdCems4Z3ZYSDFxY2MyWVRSbXZCMDFKemJva3UxUlZtZmpxbG5u?=
 =?utf-8?B?UUxldUNyWjZDWXBFRVFGc3d4SmJjOXZBbGltdFhJNjFFRHB1Nk9nYzBaZXY1?=
 =?utf-8?B?dVhubG50UnB2NC9HODFhZFYzWlQ2VkUzajlWVUJhK0cxd2Iwa2JTZXdhNlVU?=
 =?utf-8?B?RmJOZjV5OVdWTlRYeWhCWmljUDRwWU9UVHZLaUlzcEpib3Y4c3E5RW5ZcVc0?=
 =?utf-8?B?anQ5dnNIaTFnZkJUV2xYbWRZczBCeVg1N0REdU51OWdXaGg5ek82NUQ0elZ1?=
 =?utf-8?B?clpHSmwyb09TWG5yTTFUV08rQU04QUdxcmhvZkprL2hlQ3hDS25LU3VtU0t1?=
 =?utf-8?B?OVRaU1docmRJOHJCTml2U2UvdWo4SmFtWk1LY3h5TUVWQnJtUlZ5eHkrQ2FG?=
 =?utf-8?B?bzk0MWVDeVpST2tOMzBUcWlld0tLNytFMEFrdWIxS0Z0MHBhS3g5eVBYM3FN?=
 =?utf-8?B?TWNXWXpjNUNwYXZVWkpWdEV0bG11c241QTJuM1EyRjc0TlRwc0ZJeG5SZG1s?=
 =?utf-8?Q?CHXWlyR2DK2v772+gw+tcrsfF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a27c1b-e20c-45be-604d-08ddd55477a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 01:48:11.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlmmYXgpCb8gp6jwxpzUm4z/0Ze6O+t0mv04EKi5tQlNUOjyban/rL5MJPsryQJFhO1I7OxSHnUSaNuleXUgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

To ensure successful builds when CONFIG_IMX_SCMI_LMM_DRV is not enabled,
this patch adds static inline stub implementations for the following
functions:

  - scmi_imx_lmm_operation()
  - scmi_imx_lmm_info()
  - scmi_imx_lmm_reset_vector_set()

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

Fixes: 7242bbf418f0 ("firmware: imx: Add i.MX95 SCMI LMM driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 99c15bbb46aa8329b5aa8e03017e152074cdf492..f2a72177bb37c1d46145a60710e3809641e0f5a2 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -56,7 +56,24 @@ enum scmi_imx_lmm_op {
 #define SCMI_IMX_LMM_OP_FORCEFUL	0
 #define SCMI_IMX_LMM_OP_GRACEFUL	BIT(0)
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV)
 int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags);
 int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
 int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
+#else
+static inline int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif

-- 
2.37.1


