Return-Path: <linux-kernel+bounces-896217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3698C4FE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B74E77B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1F33D6E9;
	Tue, 11 Nov 2025 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZsIQNNE5"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC63326949;
	Tue, 11 Nov 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897359; cv=fail; b=lB4h2Y58ipKbzBsi44d9sTag/pi7Js1hv2FlXlQ4PAyswKKdD9ThqXdlmwkf0Jtp2QYCJ3qwdxHf9WiVOddnEzpTBzpQ3oJ09okoZnZJLOuCt9Ux8rrWEGNHAb7KQQ4yoMuBfGMX60UzPCDs427TdkwmMUH6imoi5JEk7bTzSBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897359; c=relaxed/simple;
	bh=I9MBNqgBZy+soBq+lAFBlpa4tZWN4rh8+W2Ykll91e8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ZFxmfdwFem2c3qBHfNmFV8y2HoTM8v1Vc3l0YFgOaOqUhod9LUTeDPQKh1MLWnix2W/jvW53JsIVPr1CvYOUOKqzkdFKep+f/J+jVdptCIgxr/kwQqorBGgVKb/JmfjrjpReQ8VPe+Qnm8CgKpTDoLca9n0l/+n+FsQRajUxhTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZsIQNNE5; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZlbn/W05sv5VZD7GGKDxxf1nz5N93BynWCXEHaheNJrMD0HoW7B/peFx4v4mm0C7CCL9K2hdd4wBxMoI7aQ0SSzTfJBlfsC/MukVxDp7mWLZURu8ok+icMBm5rLnaX5ynRbljS502ByCOPhU/0hQJowtT7wSCxgqFZMDYnDUp81lgLPUZxNN5LodZZ2qfdwCXPtwUUNm1FZ6I0vb4D13xQjrjv8oWF6Rsm63MR6WWzDvpBDgS+qqW28e57fNVYG0D0UvNf+IJfGmwEThbTR4Hpx2fq8198ztRAxoeD/iN2kfnnGOVC4Q7UoqJg8RwHNleoTkuSXeavgZKvJXNFxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Yy+rcl7EN7d6Ym/61hr9Xpygj+GMSeiyBJKC009Zg=;
 b=alDh7XrvKmZYEA9ljAjLT7ytwrGq9GB02NFx5biB8rf0ewgjfoWW4qsytKv1OLk/e4MHHQAi+CHPR+x0m0Rwxvxfxq/i1jhAu+W6sL5z8XFijogGn3ZnNlCugVRn9OVHyhuWuIf6XJX7AyZIww3Lb5BSEjWX1ecJXlv3uyvD68KGmxjnCGUsFtPp+8Geeh3AwRYOcv9f2C/Lrhi8qDY1+D6F3MUyJGgxqukflU1X5z6bHfXx5EKj8lsHHLXT8T2iWXRZY+jnhqIM1SJt6zCheFF7TWQW0ewZMeh/UdSH09BICKnjg1fQ4b713Pe9UaumMy2enSJcJ+NRIDt5C1/HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0Yy+rcl7EN7d6Ym/61hr9Xpygj+GMSeiyBJKC009Zg=;
 b=ZsIQNNE5XvRysJUV4HdC3m3Uap8GVPJ0gX64Czhtz3Kz8KiJkB1gjCuuJh+VXP6d0eIetmKkTTdoVR6IlFcqs6tnwUo+o3nor/ocZ911oQif9SIZIVNENZR+6f/c9nBPUm3bEiZCwPGABOpLu3PeVmlCTzuo+g9aPZK3n5ckRuRqOozT1THqw4HJmb2lEq5nOOK5+4Cw95a0ZzcIxlmQ3Xxb5E3YnYHkDMU1/IuhXOrDkYFzUlFsaSM/2g6izCIydgs9Guwgvdagv0dAnu7fY4HyBZi0/BRdXdlwLnnx0BOUAc1C0bPz7Q89O9dOkPdYWwGABjteFL/t7j1UfLKB4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 11 Nov
 2025 21:42:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/5] media: staging: media: imx6-mipi-csi2: trivial
 cleanup to prepare convert to common dw mipi csi2
Date: Tue, 11 Nov 2025 16:42:12 -0500
Message-Id: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALStE2kC/22NwQ7CIBAFf6XZsxiWlmI8+R+mBwRqN1FKoJKah
 n8Xm3jzOJO8eRskF8klODcbRJcp0ewriEMDZtL+7hjZyiC4kIi8Z2nRVZpEgpmH0/4VWG9vqFC
 OFk8K6jBEN9K6R69D5YnSMsf3/pHxa3859S+XkXEmbSdkK0XXanPxazia+QlDKeUDvxM0wbIAA
 AA=
X-Change-ID: 20251106-stage-csi2-cleanup-6db1715fd187
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=1453;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=I9MBNqgBZy+soBq+lAFBlpa4tZWN4rh8+W2Ykll91e8=;
 b=/3oY8Lw1+a2JErHBhAMq9/P1M0Nh+7hrWzHO/bxdn7vwD/tfhA5pREY3mWTCb9ICttC7oA2Z2
 AzlvgxxHf2bAsuzwZ3U8OVQ9RTcZCLXhDgmHQleA/oJ2c+jkbY71UFs
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ba5c98-21bf-4249-99f1-08de216b3939
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UVBWUjJGNEJOeHl4MW5TVURoV1NuUnRZNFNna1pYQy9Zb0E5K0lrTG5OUnNh?=
 =?utf-8?B?czhSK2xETzVCRTFIYWgzS1JYNjN0REJTWVN1WGR2ZFFxZnNWNnRIZ3poTXcw?=
 =?utf-8?B?SGVwb1ZIWjd5MjBxR05hcnk3c2RseWRUMXVFVGZGcjF3N1hhbzVETzgzdUJJ?=
 =?utf-8?B?OWl1bkRJbEJSSmNZUEhnTzZPMTRHLy9jREl4OFNwelhBMjhSWmhjTlNUemdK?=
 =?utf-8?B?K21MK0Jma0YrOXRiN3FNVDU1S21EcW1Ga09FY01tNndYZExnNm51TW8zYzlm?=
 =?utf-8?B?d2tTK1p2cTd4YVVrNVVwQnZRN05FL0JRcStXZVllSWY3YzN6TzgvS0tQN1hn?=
 =?utf-8?B?OVNXSXRzWkJVaUpuTk5BNlgyd0xGMXRWTFdmK01STnlkcVMrM21xUXZmRjcx?=
 =?utf-8?B?TVZiak1RQTVja3d3dU9UU0lSNXVkWmprOVEzQ29xUVJZTXVJdld1R25OUXZo?=
 =?utf-8?B?bzBTRjJvanFIdnBvRkxuRXRMK1g1TDd5cjAzYzZnWmp1Tk5wUkx4Q29QRExX?=
 =?utf-8?B?ZDcxaWpuQllodEg3VE94bFoxZ25rWWdBM2Rac09mTUhacSs1aWZ1ZU0vSGt6?=
 =?utf-8?B?K1JBaEh4aG9xd25ScDRlNGJnRVZPV3NXSW8vSWZERDRYcEwyU08xdzRvNHF4?=
 =?utf-8?B?U1pnb2U1YkxNaE54RTRyZmEvS2RZUGVISmVnRitCS3Nld0NmMHlZUVdMSWVq?=
 =?utf-8?B?bW5mcEFLOERhVEVRbFhiQnpoTk1wRmVwOXJybnZ0Znc3dTRBUEkwcTJZTXVj?=
 =?utf-8?B?Mm1kQSs2TGFSdW13dG8xUlkvVGVuTE9Ib3QvanAwdjdocERZdXdxSDl1OGJj?=
 =?utf-8?B?RDNhM2lXVEcxdnpkc2tablVnbDk1d0pmaUVsWERFSklXWnpRY2dyZWZMRXdQ?=
 =?utf-8?B?ZEpUeHExbGNSbmYvY3JrbEVST1ROcnlBaCtIN2RaandCZ1c1dnpqcGNxMVBD?=
 =?utf-8?B?bklReXV1R1BRcEhvaDNpRUFhOXpoYWVKdHhIV0IvajhPcW5OSXhYajhNWEpJ?=
 =?utf-8?B?WHBKNlhsdXZISlF5cG9QWnk1Z1pYMWc4MXlrQ25SckF0UkZNSURlMXBTUXhZ?=
 =?utf-8?B?M3dYaHdOaTQyYkEzWnhCZWFUZnRXMkQvWHNEWm1XOXRqakxHMW9BOFpmNG9y?=
 =?utf-8?B?M21wejNoQjkxaUUxRjhQV3hHeDNKQnNYWS9aL0JXbE5wVWNzUFpMWTFiQklD?=
 =?utf-8?B?OEdEOVVnTlRCeTh1bW0wQW1GeTl1bnNDM2p5WTZVTXJPZlJ0dDE5WUZublM1?=
 =?utf-8?B?V3hZNmF4NEVYU0N0NDE4dDA5RGcxUitwTzFKVGl0Zi9ZUzQweXFxMzA1dXE3?=
 =?utf-8?B?Mk5LbjNlTGdCTjJPeTNnOWN6NmNHUXo5ei81d21pSnF5UHpGYXlkOUNsR2RN?=
 =?utf-8?B?SFNJL012TDNHcGRWVjJtYVZ5SG1UZHFIVHI5eTBib0U3c0QzOWhDdlZwSG5O?=
 =?utf-8?B?VjVFVVNCSlpyVGZaWmN0VEM4cHFESkpNUGZYb0trZVA0dnNWdU5Cbkh0emxt?=
 =?utf-8?B?ZUpWWVUranU5MWhielZJZGlUZVE5Q0J6TjNNd0FvUkJDMzc1TFd0UkY0dVBJ?=
 =?utf-8?B?LzhHalVPMENlcFVKTUpES3BhZmJvWnEwMUhCdWdlRytKeXY4UXB0ckZFa3M0?=
 =?utf-8?B?TEk3TFU3eE4ybUZGN0s4S1NrS2ZrZXkrbU1SR0VzSXdtT0xEYndYWVdSSXZG?=
 =?utf-8?B?Zi9hRWIyenJBdEVCMjFTaFF4bzEzejlxL3I0Nmh5bUxJejhTUndaeXZZeDMw?=
 =?utf-8?B?bk1LdXU1b3RDWnU3bC9HN0F0Mm5ENHRKc0pjM0g1Y3VYMWdzazkwUVFFUmpq?=
 =?utf-8?B?MnZSRW14RkJUM0ZTTVhlM0R4eU9hbS9oRkU5NHViNFZ1UldCcW1TU0M5Zm9a?=
 =?utf-8?B?WVlpZ3d3WkhGaWpmaDVpQXJLdmdZZjJRdjBPTlo5WEZnbHhFa21pbjJXeGhE?=
 =?utf-8?B?M0FqMEsyUGNGY3Q5b0dyYlRWVHhERjh4dXQ4Y0doSHpUcGdUVzlEU1FscUhm?=
 =?utf-8?B?d2J1LzBPVWk4SW9Ta2FRY3V0V1JzZFpjNzhkcnMrd1ljdVFDOUJUcGd4YjA5?=
 =?utf-8?Q?Pyq8ze?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Mm96UDBNQWt2UGtFNHhnY0c2WFZTV3U2em83OWxlU2poYjdqM3BqWlJuQzlD?=
 =?utf-8?B?QXJkam1DdGZ5RnJFVzZLL3pLc2UvTHNXU2djS2MxTTRWTXlOU2JhUG56dFFm?=
 =?utf-8?B?dHFYOXA4OUJKdlozUUZGTGtsaDZHUnpVejIyZFNuY0MvOTFFNlJWM0ZBb3pI?=
 =?utf-8?B?Tm0wQzhLN24yeCtnWjB3dnBNb05kY1FrLzJHSkY0TmdGZUNTSmQ2enowejNm?=
 =?utf-8?B?Q3lNcUJHQ2VQWDJhUnlMZXJwa0ptMnJ0SWZaQ01Ca1pocVgxdEVheGhSL0Rq?=
 =?utf-8?B?aXVUekFXMFMwZFFHK3pIOWZDeW1wT3JXNGVIZG94VnlQMVlCTy9rYnJaK1Ri?=
 =?utf-8?B?Yjk0ODJNTWtwck8rQk9Na01ORVNaWElIMUdGVWRUNUR5d3FjY2FkVmRNejRm?=
 =?utf-8?B?NTh5bmRZNmVMYXd1QnZSZDdEUS9hRFY0WU1OM3V2Qm9PWlJhcFI0RE4wRkhs?=
 =?utf-8?B?L0o2bHM0eEFBaURpNkNnSGFEcXBLSWE2ak9USHhablRlbmRodnBUU2U0Tld1?=
 =?utf-8?B?N0kzek4vNWM4OHFUdXM5ZWU3dmY3MUwyL3VvN2liTGRSYTFRV3d3UElubmM2?=
 =?utf-8?B?citsZGVHVC9UbGVPcy9wOG5tN3hiRnZERzM5aVdCd1Q2OGRnRktuazduV2Ey?=
 =?utf-8?B?bTBoUDRKNjFiRnJMWGZuUnNsaks1STlwcW1NZXlPTHVlcDlKdUdIUTRzVk1B?=
 =?utf-8?B?V041UGFlN2JXcnhYcnNobk9XZklLVDYybm9MajFaakhnNkx3WWxObFFsV0lp?=
 =?utf-8?B?S3FjVU1RZlJtWTZ1ay9VRmFxcFR1OTNPSUFWN3dRRGVTeTlEbnR0UkhyWERh?=
 =?utf-8?B?Q0cwYnBtZjVPZktTMlRYVHZZT3JYazlhUlczWWhjZENhakNxVTdrSXpkVTJI?=
 =?utf-8?B?dXJFQVZJVEw4OG9KUkl5cytmUVFGdzBLR1dOOU0zU2RhbnZxSlpqY3JyWjlO?=
 =?utf-8?B?UWRMSW1oeXpVUXBTWjV5NXgvcDJHNHd2NzU1KzNmSCtUMGhQRnUrLy9yZ0Rk?=
 =?utf-8?B?NmEyS1lENm1vbUdKQWl0anJyWkNXZVlTVHc2azg0RHdPU3FBd0l3STZraVBD?=
 =?utf-8?B?K0g4STcxaVBDQnNRK2lvaEJOaWlQdjdrR3h0eHgrVnFYNW1GY3dHeFdMa2hH?=
 =?utf-8?B?aDl1eDJrOVQ1OXVMZXNkVXdEZXFPOUVLY2dsckpETXVZS1BJcXhzemdGR2lZ?=
 =?utf-8?B?RVhTcHJZdTIwSitucm85dllRVmdRVTF3dzFpUFJheE54d0MwWTZBTUIwRWR6?=
 =?utf-8?B?Vy9McFpaSUsvZ3I0YVg4UGF5MElCR0JmdzZVQXNSb2JjRG1rOUNBSkhtRU0w?=
 =?utf-8?B?OW81ZmVlWVdLMDVDK0I2YnhyQjBHWkpVOGFiNGVKMDdQdDV1VFR0eTZRdUs2?=
 =?utf-8?B?M3lIN0VEMll0eWE4cFpONFhhTkdaeDVXS1dYQm1RYy83NytlM2VwRmtYUVps?=
 =?utf-8?B?Z0cvcmpZZ2RLajNkZStvbXZ2YmdUSUZUcFFUVWh4WmI4K09xZE82REJrQTcr?=
 =?utf-8?B?MHFQNGVvSktzdUZUU1VXV0JicWdFNFJoblI0UldwTFVRTDUxOG1nTTgvT3BZ?=
 =?utf-8?B?SzhvSDJJdkxQdkhTbWpHZHZWU0Z3czNPYlIxdFZJY1p3ZTFJcHc4eDI0VldI?=
 =?utf-8?B?eENlVTRDcW1XamNBWEtkanpIdHdNTEk0cUJvNzAxWC95MmM2VXJjalRjb0cw?=
 =?utf-8?B?MmR4THdabXAyNnU4d002blZIVy90UllPWk04djlhK1lQT2JnOXNKSnJvM2NM?=
 =?utf-8?B?S0J2ajNzNTlCMDNVRllYaGV3Q2JwcU9VV3ZQcmhaNUdHYnN3Y0pWVi9KSDd0?=
 =?utf-8?B?b2tyNVEzYWF6dlMrci9EaFhoNjgvbSs4Ukszcml5V3M5QzZ3QXlIY1JYeGRC?=
 =?utf-8?B?OGh4VTNzUit3Z2pzWU1hVmdYa2orZ1hGZEdVbXI1Z2paMGpGZXp1Y0RzZVVU?=
 =?utf-8?B?eXFqVkV6TUwyN0IrZDJDNkErditVb3pCVmhQV0hwTWYxUXZET3lnL1l0WElN?=
 =?utf-8?B?QzFGRGZaV0VqWHJ3NGNyL2lhcVBjTUJ4VllIa3BmdlBUaEJOQXdPUjNHdzVZ?=
 =?utf-8?B?L1A4ejVrMzVMUWY5ZERlQ0NxbS9aa2pVSC9ib2dxMWg1c3pBVDg2R3dvTGJh?=
 =?utf-8?Q?uMJIkll2BCJqUaW8GBzKlD3jY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ba5c98-21bf-4249-99f1-08de216b3939
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:34.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsY0uK3n/+A/J7jCDT75nOV9naRXehQG5YSR+cOa+3UCELeFsVo4458na0jd6ToB2i5tMKPu4BzckkuUqYUOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

Previous https://lore.kernel.org/imx/20250821-95_cam-v3-0-c9286fbb34b9@nxp.com/
There are too much patches (32) in above thread.

Just extract first 6 cleanup patches to review easily. The overall road
map see above 32 patch serise.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- collect review by tags
- drop media: staging: media: imx6-mipi-csi2: use devm_add_action_or_reset() to simplify code
  need more time to understand nf_unregister() and subdev_unregister()'s relationship.
- detail change see each patch's change log
- move devm_mutex_init() patch to second one
- Link to v1: https://lore.kernel.org/r/20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com

---
Frank Li (5):
      media: staging: media: imx6-mipi-csi2: replace spaces with tabs for alignment
      media: staging: media: imx6-mipi-csi2: use devm_mutex_init() to simplify code
      media: staging: media: imx6-mipi-csi2: use devm_clk_bulk_get_all() to fetch clocks
      media: staging: media: imx6-mipi-csi2: use guard() to simplify code
      media: staging: media: imx6-mipi-csi2: use devm_platform_ioremap_resource() simplify code

 drivers/staging/media/imx/imx6-mipi-csi2.c | 209 +++++++++++------------------
 1 file changed, 80 insertions(+), 129 deletions(-)
---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-stage-csi2-cleanup-6db1715fd187

Best regards,
--
Frank Li <Frank.Li@nxp.com>


