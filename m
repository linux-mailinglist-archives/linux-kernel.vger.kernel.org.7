Return-Path: <linux-kernel+bounces-896219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FFC4FE61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1F444EDA85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483B352FB8;
	Tue, 11 Nov 2025 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R0lVyfmV"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC9326955;
	Tue, 11 Nov 2025 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897371; cv=fail; b=sDywh/8b8qAAlFZ+8gbKZucjL39Dkh1PEZ4BKNQBiMh3hq8V9euovZXDjYjdUjXqNtoXnCDbXc9AsieuGedOoImoNlE3symP+cMcfroBYh5BkLVanbCLHriTj9PRg5hPsi0V2I3zWlC2HPmQl8J1qH7qw4W6fR1ow9cKgX+Eq0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897371; c=relaxed/simple;
	bh=CGjDzRXz+eQXEoJENI8tLIYhP+g0jZuTr4Gv8ve0irI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T2K3vMdmYnDfYCUXrOZJyRSoGqKu05ahrhRdNQyfRBOfrzQPDbHM/M4d8ztjJdAPGejm0Rh50L3w9b0D2atdIgfe8ZjoPFI2VL4+vgsIxvpB9Jeb9vtw3g3ZszkL4A66qXIiSPicorqdW6uaHMcS1FJdCHWQOLvPilepstvaLw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R0lVyfmV; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrxKMcC3fWQ9UpHZt/Ga3qay28QCAep+pR2nmkdwNP7r+NitZ8ZESI8NMwyySmDZPnwmd8ZKUynzhD9aEirf5qAYcle2ydiur2Hx1Q331OXRr7nWhSn36pJW2AE7F+LEaqIWexe4C1QBVQ/I/Vc7OHKFdwURAVdzzXohQ/b7LVmfRbZAn7rwFIS9cnHl3Z7UQuiVeV87a8fhx02OLwrn4uYAZTp2yiSuDNYihHEIVac5075QUg8E2TPkccATNxUJ1DoXXdD4iYbfbT/SMeYpO1kUoetmrdNbHxZPlH0sW2mL5QbnpgMyBgD2ptbgHK0bmC/Bcseids4/+1sGRq+Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KIAOBMOSnd4359GMBHbIy2cPl2H25yHCjXiRW3frPk=;
 b=No7VBOWSM0YFc7MJ34plNOrTCuMpXHC48eBP8DBFZw96pE5F8aTolt3ZoIKtqdKczvx5NZdWbkHp8wxLKhKLizAiq91dDLUNwrekZCiTnDmy57Ywi1eob2UfrQ0hkpmw+XYbcOrFX/QCYk/Lns5KHJhjmy1VrZ7SA7c+2F7ZEIHEFySLd2RUXa9XNHFpC1JVt/SRZ+N3B1ALd3sWRLCtP2Vb/IvR8n8uyFFRlJUfhyJk4dF2vBwfrzhbh5zbc7MtHyj+Fy0ipkNjD7K+M1U132f3uDIWzllbMbGSCnZgBr8KY2O8g20l62+s+OdUriMIDFuPdL4SZB1ZRXuA7ay0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KIAOBMOSnd4359GMBHbIy2cPl2H25yHCjXiRW3frPk=;
 b=R0lVyfmV72adVA+qj/c/BWBPqB+qBm57VttDOPET2BlOGFSYZbk+XSV+snwDMdmCtX4YnJx/2q3n346PsCb7hfV0qZthCK/FOZtcIwX6AznGViW0op36SQQhDDEWhqNpaZV9cKONVNzJLzzSY9PcLo6pN0Nurvi+TpIRZiBkAQ4quoWRzcc70Bh3y2hrHh55kyc4nCuDV2jB8eKhI69o2Pmz2y945E96ulQeSP+B+kEkR6FGE/ura8CdsGX6S5/vxSOJOk+Is7B33gY41tremctdyzBBqq6TEwuoNgWvo4CJpdDT6Zkdn35g6mXNUV0vBclC0QFwt2DhVKM3ume7SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:42 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Nov 2025 16:42:14 -0500
Subject: [PATCH v2 2/5] media: staging: media: imx6-mipi-csi2: use
 devm_mutex_init() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-stage-csi2-cleanup-v2-2-371bb951776f@nxp.com>
References: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
In-Reply-To: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=1541;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CGjDzRXz+eQXEoJENI8tLIYhP+g0jZuTr4Gv8ve0irI=;
 b=g8ew52iRmWoAYwm3FK+Qh1xlpOoBADjsnTzV57ylK2yat7OukOzXbQ3l+yP4+EdRkIT+Ns2Nn
 dWlBhRMny0fC1uTGXr75ImmivjAm11yhL6+gWC6DD6Qp0wrq/O7GBfX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a45673e-0628-4094-e1e0-08de216b3dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1ZNZm9ySGdzWVEzK1doM3I0UGlTRzZtUG12QVVHMjlZQmg1VGlJVEJKQmpU?=
 =?utf-8?B?VFkrTWJoNStTNDBnRllKQ3ZFSzd1enJWUkxCdjFWVzE1bnp0NVRvZFM3RmJ3?=
 =?utf-8?B?aFRTYXhKbU91d05yWE1XTmVFbnRySjdZek9aT0lERnQxckhLSTdweXg1dXBO?=
 =?utf-8?B?b3l3a1gzTnlkZkNvd3ZDV1dPOWo2cDhYMTk2VnJtOWJCcWVvNHdPY2FBWnpw?=
 =?utf-8?B?RXM5anBvOEZ3RFlWT1NqdmprM29NL1dCV1VoSUhtNmdNY1JjdFBCZ1daUFE4?=
 =?utf-8?B?SEl1T3JGR203OFl6VCtOKzRkNzh4dTRRVEpEMTRDRGRwd3JhUFNzaGVwWDd6?=
 =?utf-8?B?RVFIUGwwRkNmMGVEVHRxTjhkbnAvNENMa0gwdlI2Rk44V3Z1VnppV3Yxb000?=
 =?utf-8?B?Q25Od0k5VHJHSGVrTkxOWTk3bDBEWjFzYWFXNEhvQTBFUWRzNTU4SW1tM2xj?=
 =?utf-8?B?Vy96akNmY1h6TWhrbUtqMTA1R2ZDeEwzRnRZMFd5Qi9ZWTg4aUh6ZUNpeGpm?=
 =?utf-8?B?Tjc2cWw0QnEwcHlHbUVhYjl0blR3eUdpMUp6cmlLaW51cFhDdlNJVTM2aUFG?=
 =?utf-8?B?MmdwVkFWUm5xc0l2OXFCd3JObitqL3g5UUFLVFFnUWR6MEJCZmRQSFVMYy83?=
 =?utf-8?B?Qkl6cUo0OEdzdHZNVXJlTmJtMnlockJuUEl4WTdvaDFWeWxuUFMwNEI1Z3hs?=
 =?utf-8?B?TURaZHlOa3YrTzdlbU9hNWl4SjhSdTBqMzNlRGRvRTBoQ2k3OHR4QUhpc0o1?=
 =?utf-8?B?a0xGcVA4K0xLd3VaWmU4REp4VndrTHZwcEs1dE1BSnVLRllRbVlBcXdpODM1?=
 =?utf-8?B?Y24zTjR1VXpNbE9ZS2YxMWVMM0JxR3pEa3c5YTlYcjJTc1lSL2w0OHo4Zkc1?=
 =?utf-8?B?WnBHbE40azNXY0ZKMEUrMFBKMllxanpGOEUwcEsySUwwdTc4bzY3N3A0WXZp?=
 =?utf-8?B?MExwVlpHSmdleFF6YzdwYW1oUHI4SnVscnpkOWNNUFlnREJ5UEludi9zaGlZ?=
 =?utf-8?B?U0xoc00zcHR0bXJvT1lsbzRWaldPcXJpdTlQWjBJSk9teWkxbGxaNFptVndM?=
 =?utf-8?B?a0U4VTNKT0JPR2IwS3I0ZE1NWTVTc0Z5MkUzTGc0N2ttcWkvZ3NrRFZjWXFx?=
 =?utf-8?B?eFZKdDlKQm5PWlUycVVBQzgrTkRlWGlEYkhzNDRaOHk3UU41dXVqNHBhSjVu?=
 =?utf-8?B?a2NtWTVLa3RoSkkveWFBSTNuYjlYd1N3b3daSFRUYVJUYm1BYitoNW1GL0U3?=
 =?utf-8?B?dFlxQ3R6N3FxM2FMNktCRGhBMk5HckhoTVBKNG5sa3Q1dy9SditrR1NlMTRt?=
 =?utf-8?B?aytEL2RaL253N0NKK0FvcmI4OU44Z1BOcEtEczk2RWgwVC96RDFrdFUwRnF6?=
 =?utf-8?B?UWVrcXFlaE4rTk5USTZuRjBtbFVKL0lhTmpNQzZxb1BNNmFEMDl1Vlo3azV0?=
 =?utf-8?B?dnQ4eS8ydnFNZ0pVSVJmbitySURjVEw2Q1c3OG5nY2E3RjJ3T0IzZjN1YXYw?=
 =?utf-8?B?YmhxNzMzZkx1ZTgzOUFuSHdxZko3Zm45azI0bTh6Y01hbmgrWUpQN2F0Y3Vz?=
 =?utf-8?B?c1FEMlB2dTRKZjhRUVlNR21qSnoxT1ZXYzZvWXJiQkJDQndwTFNCNTZXQ0U1?=
 =?utf-8?B?dmdOK2FuK0NRMWlhTzFyYXhCeGxEZzFXQ2VSY3pGUmx4NWZKNTk2dVpQZS9o?=
 =?utf-8?B?OFFQaW0rSHJTbG1hY3JGdkpVSi9aWlUwU05FQ2gyelhZb1VwSU1jN2NVaFRm?=
 =?utf-8?B?SFBUODlOMmFxTXNoNUxJd0RKay9YUXpBa2c4OTJsY0lrWGt1OVNqOWYzN0lO?=
 =?utf-8?B?TTZxeEtwR0pJTHFFMDdDY2hoYVdyaU1HOTNhNWtNMXdycTVDREp4VldBNDhX?=
 =?utf-8?B?SUZYdUQvOTRDVWxrV1hPMFNTQkZXOUhrZ0NhODlobW1jV3hSdUhmaXNBWHY3?=
 =?utf-8?B?RGEzTDMxTU5keldEWU9EaloySmhseEJ2ekFzdk5XMlptclpoRERNeVROUHJ2?=
 =?utf-8?B?aElBRVY1RWZkR2s1UHRWaVFuNGExbFR1V2d2UXJIM1dxR1JTUUxVQ213R1pt?=
 =?utf-8?Q?+ERfbS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlQ3TlYxYkNuRHZoeDY0SXowOVR3aXlnZDcrNktSa05ydG1uMldXZmdxUHVk?=
 =?utf-8?B?dlpSdTl4YmlIQzZiRGI0K3ltV280YTdFZ2RoMGQrdHZVMk02ZWpEem1Nck9R?=
 =?utf-8?B?OFJmT1BZbElnZGNNMy9YSmk0N21tOEc1RlZjN0hOaVc4Wi9vTGNhbUNwMWNZ?=
 =?utf-8?B?Rldhd2pYNGl1bjVqWG8waHloVEVSc0hSNER1UC9TR0ZhMFhWaDA0Z2VPS3Rp?=
 =?utf-8?B?dER4dkJETmJhbGpSZXNVNTF4RDZZRVVUdUZWT0dZYkJxc0tZYlNVK2xtZUh3?=
 =?utf-8?B?T2pqc1o0dFNZeGdEcUFGZ3E2c2lSUlZhd0ZKT0JneXFOaFpDZjZJNzcvWmJW?=
 =?utf-8?B?U3pUM21PQkdQcktPUkQ0QnFtd1JLb1V5Y1EzMS8wNjFKODNtRHBSdnlFRmlG?=
 =?utf-8?B?NGVtSWxBcmxiNU8yYW43OWdFUXFoMDFGRUJTMGtmSVR1YXcvSWhEM3QxVlNC?=
 =?utf-8?B?alpkL3ZONXV5YkxLTTUxYWhaN2llVU81WU5aT3dOWUh1cWNWMWhYNnBzbFNi?=
 =?utf-8?B?cjYxaklvdW9TUTBCZUpZaTJzNUxqMXFQK3Mzb0NBODNRbUIyQU1IRUV6cDVQ?=
 =?utf-8?B?UGNqeDlJdE1INGdGSktOZXpUQ1Z2eks3SDBPTm9mb2hrRjluamFyalpGR283?=
 =?utf-8?B?aWh4LzVQd0I5Uml2cXl4MXBOblJaYXI2a0xvazhKcXhEYXNEY21QV3FMYy8v?=
 =?utf-8?B?amtOOWYwQ1JwQVM1a2wvUW1RdjMzdWlGNU5ibkQyWGlXckJnamIrUVl4eU5n?=
 =?utf-8?B?d1BZMlBxVHJxcGV1ZjFoeitTcnJzZHhqWVNrV3dJWVVHeXIrbENBMnFackFD?=
 =?utf-8?B?R1hHOFByemJKdjhKR3dBSGM5L0F5dW1zQWRrdnF3MysxWjUzV293R2JoZzJQ?=
 =?utf-8?B?T0xQcUNnZzduSTlueXdNY3E2OWpoRlFlNVI2UTN6WGMyaVIzWTI1R2RSRVIv?=
 =?utf-8?B?RDNpOE5kSUZyczR3eGRZazNISFVZNzBZSEpaSWlDYjQxQTZHQlZncnVWc0hN?=
 =?utf-8?B?WDd2NnRTU2FEUTR2d1B6WmZOSmplVXl1ZlA5ZTUxdGRsWGhMd1dxcXFKcmpa?=
 =?utf-8?B?bGErMjFUY3F3Y2gxaEd4Sng1aTA3WUZnZ2tZN2NTZkRZZWJlNkoxWEhQaFV3?=
 =?utf-8?B?aThkR0UxanpxWXhaT3RZVnZGeHhEdWszaVV2VUFoQXN2a3hKY01tUnI1K3lt?=
 =?utf-8?B?cllyUVRjbHJIcHFJMWtDUUM2TWFBMy9CZGR1aXNDeTF0QVNxZFN3K201bUsr?=
 =?utf-8?B?ZXhmdnJXVlpjek5ET1lrNVJTKzN2cXJKc1F4ZVkwaHZCSmpqWUcwdnlha0R6?=
 =?utf-8?B?aG93THJFODdnVTUwcnYrcjA5QTJQK3NTNzJPem44eE1CQ1FsTWJMTlRvNm4x?=
 =?utf-8?B?TWExQzJpQnBsbW5YMFlkTlVSYS8ycUhqRkl0bUJaTzZSeXFIZFI3VDh4a1Bo?=
 =?utf-8?B?OFcvMW9tSi8rdHhaTWJuZXhsNmppeElLWnVsTzN5N1ZQN0xrYndFWDk3NE9r?=
 =?utf-8?B?eU1jZzlVZlZvNHhUaXlMa2FLeDBJRUdiWFFLOGdMYm5haTlkeHdSSFZNM1VB?=
 =?utf-8?B?Ync1UDRoODBzSStoZTFEZ2k5alI5RXVVdVNkVnNwRVVhTGVkWmNkNzRzNmU2?=
 =?utf-8?B?dWd0YTlrYzI4SFFQbzR2TXlOSGs5YzUrb0pJOGNWa2U2a2JvOUpZN0xxTmt2?=
 =?utf-8?B?NEhTeS9xNlAxNjhZS2xHZitkTHZvVUNyYTM2Z2Exa0Q2TGxSWWVLS2lsZHE4?=
 =?utf-8?B?QWREMnlmZ0VuRUthY2ttYWtEN25Zb0V4SDZtdXR1UFNrdFRLalE3bDhJdWZx?=
 =?utf-8?B?aFJrS0VZZXBCS0xIcVdUQ05ZeXlIQWQxVk9va2V6Rk1ZTVJBR3hqMVQ1MUdq?=
 =?utf-8?B?VHNtT3F1ZkFHL2ZUalF4UElCRUxwVVpjZW16WFdYZURLcnRtaC9ZeXZKM29P?=
 =?utf-8?B?U292MkVRV2xlNmxMUm1lQ2sxZ2FBbnlGZnNPRjRHbEd6ZkNiNHNKTFBGZzR5?=
 =?utf-8?B?a0UwMWltbUpmYmQzMU5tUmV2aTRTQjRXN0FwTVdjeEZ1NXpTek1kS2pIcURv?=
 =?utf-8?B?V1M2alZLNm9GVmpoS2xrcXpJT1ZpN25yelkvYUpReGFWZjNXcno5R05hUWd6?=
 =?utf-8?Q?QZotjLwkVIApZnthB3i3C3/zX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a45673e-0628-4094-e1e0-08de216b3dd7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:41.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/7OV63XuAmfnc5UWNR1X6yXvw0X3gfWE7AdhVgirm1n9Ca/84nbtezvfyE6ERWKC6X+lCBE+JvZ1Hpk3nPwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

Use devm_mutex_init() to simplify the code. No functional change.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 1113ea2a37f03753423164069b95c049968cc0af..4f740170d2bbf586ac0a58b5d25f8f8432e9e6a3 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -777,12 +777,14 @@ static int csi2_probe(struct platform_device *pdev)
 	if (!csi2->base)
 		return -ENOMEM;
 
-	mutex_init(&csi2->lock);
+	ret = devm_mutex_init(&pdev->dev, &csi2->lock);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(csi2->pllref_clk);
 	if (ret) {
 		v4l2_err(&csi2->sd, "failed to enable pllref_clk\n");
-		goto rmmutex;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(csi2->dphy_clk);
@@ -805,8 +807,6 @@ static int csi2_probe(struct platform_device *pdev)
 	clk_disable_unprepare(csi2->dphy_clk);
 pllref_off:
 	clk_disable_unprepare(csi2->pllref_clk);
-rmmutex:
-	mutex_destroy(&csi2->lock);
 	return ret;
 }
 
@@ -820,7 +820,6 @@ static void csi2_remove(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(sd);
 	clk_disable_unprepare(csi2->dphy_clk);
 	clk_disable_unprepare(csi2->pllref_clk);
-	mutex_destroy(&csi2->lock);
 	media_entity_cleanup(&sd->entity);
 }
 

-- 
2.34.1


