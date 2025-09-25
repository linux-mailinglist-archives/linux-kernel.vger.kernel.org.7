Return-Path: <linux-kernel+bounces-833232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF012BA17A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80351C80584
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16CF277026;
	Thu, 25 Sep 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bul7iaP/"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33701321F3A;
	Thu, 25 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834860; cv=fail; b=uAaOM90WbpfdhzlxouyT86umBmWiGRA1npdGQSh7OCOygLs4+Rrsv/4rp63rasWm5+ROhNh0aMnVD6Ikyz8GE59W/jv5crscecxoeXWGavL6mW8goglvblCrU6vOAkARPebM1vt8h4oJff6JXoa58W7Fovm5U3BrGo5MEbRhoAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834860; c=relaxed/simple;
	bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rd2QpNqctbd2lkFj4z+DwpfJVqBJeZrQpCMDNPDURPkoa+Blmdl60+aoQRcI8A5xAYv4z3g9eLsP6E2pU7JSpUTScjwkJI/fo3ZrNBrPi2SpDYtXZaXPbYrNPilFbkytCIjKvgDy3krWlWXQEPsv3D4lbsxU4ss22UgqqDwgic4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bul7iaP/; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3i9eCH7fF6KwCTIpkxw2r2CZHEt+SS04G62Opey/yagOVb8MuMQ9muy6YWkHriWIMLj+b2aegTCmlEbHhfO/1hduIHuazKBubhTx231vdwiaw95WexN66O5t4ci1kWvdPE/1S/S1GCCLbvZ3DEypNncwxAPB8IsQtmag1cQbTRX6cWFSaYsrAYA3LOFJENaAgRu2trpQZYgbzyd9PKx/XqP32WGt/dMwWK9Y5kEXFhRp9VggEU/nl4z5PYwvP8BPKcs/PTpUMWj8/Ie8EBiPLzkemTycX+PnAEZc1VlA2bC0sNKlrheMOzVlQn5q8rAtrJ4OU+hjysHV6Rh1Y4jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=psO9Qjt1nbZaRe62MgTzVJSoMUqfwvKCT10HUcwNrVVbEXXp/aCagwTbe4c5JmO+DIo3xd4PnmWMWL5tlsVOTeoznX8GmkE+5C4KHqrNCIFtK73LhZxrSqoQa99vAgVKsyR0mk7LwzA/kfIGJTPGkB34raxBsMK9IMVHv/B8CUI/4CLxThaCb2VeQASkx4MptXGXyLUnd2dI3cvmQi3KvRMNvrGIXSyD1lZwSrEc5RvAzv5lUrQbxOWUxR42ouNkHPSrQouDTx4pPIeM5QrWOLQWewu/Bk2+UNFU+6dowqPLi4hVr03BWSRXIpII3SbX2rMuVv9MTxEF/fkoo5XIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=Bul7iaP/2eB6heOGBc31gVG24pPZpcwvbkdKxCkFfPcFu0oOvdQLdCQtsFyDU2D6sBbyZz/OcqMG2nqWmbEOOLzUj/n+waMMikZXvd0NtymQLwQxUUP0v3you9wu5pw0s5lUJ+9j2gRjmOyE39kIvN/iPRXHGA2mAARfBh+Tje7pNPwESddPXVrSZadWknnEjB42c8VrIM5sXqaM2mtRvb6DcNx4n25PzujhkzUL/l81NHaRQTnyrRv9rBTFJsTouYfaoktnITYN8vQEvX9KY8R3Yb58Raj7wGlqdTNiim2TcoeX5IwL8rO74SEwYOUU2rtVMGYEFBu0I0HmEEik2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:13 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:47 -0400
Subject: [PATCH 03/11] ARM: dts: imx6: rename m95m02 to eeprom
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-3-748380dd0d22@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=990;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
 b=OTc+o1E8X/S97LE9W8kAJogxcEVYmKaFEds7SnY30C2hFFDT+GOQPJr6wrjRp208I7diuxb5s
 jjJQrSJoiikAvBxr1OpZSJkUNj5PhtzJdpDUoJ4d8/u4qhKkHEZ00z1
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
X-MS-Office365-Filtering-Correlation-Id: 2561a4d1-cf3d-4ff9-7870-08ddfc787a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3k3NDlYeHJTSTczRGdTN0ZnYTZpcnBjaEJ6STdPVWhCNnd4ak8yNkhWdVA3?=
 =?utf-8?B?MGx1Zm5Bc2hjMExzOE5mZWUwd1dXY08zczJGZlU2SmY0R2hsTnNXbG5xd05V?=
 =?utf-8?B?YUFsT0J0RFh2c210Nk5QQ1c0SVZUSmVpYzlzK0NlQUljK0pDYWIxalVhMTZY?=
 =?utf-8?B?MUloclNVbDd0ZjAwdFFkNWNZNkdOL0d5M2FnZWZEdDhaZitUeXNCRGI4elhS?=
 =?utf-8?B?SU5LNFdWNWM3cjBtRUpVV2FiSXdLWCsxdUxTR2JUcjJ2dGdFUmtoZUdiVTl5?=
 =?utf-8?B?bllaRTkxY3B5aXZpUEk3UHB1WlpDSnE4QzhubGVtOXN1ei84dVdaNmJJRHBR?=
 =?utf-8?B?VTNTUUhUOUpBVDZDSkJDWHQzOUVnY1I4bFlyWk5aWldOS2ZtZ1JnYVBDUVdh?=
 =?utf-8?B?a3BhMGkvbVRYd1cvaUZLMlliMzZCNHY1RHk4L3FYNExHbEZtMHE3dW83L3pa?=
 =?utf-8?B?Rk1TeFhVNmhyVlRVNmdTN01PUVNmbVJMWkhCT0UrTk9kNll4dlJuQktOMFh5?=
 =?utf-8?B?U2NGQ3ZkdVQ1NHdKWmxiais5N28rcGNhQXU1NjdnYURGMUVPNmNUbEZQYkwv?=
 =?utf-8?B?c3llY3VlOTJlOFpqRXFqTTVCblhhN2dydGxFSUpkaGRNdFREeGh2Z29qQ2l4?=
 =?utf-8?B?STB0bDFaRjhvS0srUElWSWFwTDk4eDY3dTg4NjlCdmpOd0h4SXV0b1V6SnlE?=
 =?utf-8?B?L0p1anBxSis5bGp3dHlabDBjTnk0K2dJaFBuV3RuaVQxZDNWQmdXVnVQQXAx?=
 =?utf-8?B?NCtnQTEwdVQvdHZpVmU0ZG4ycW8rQTlMVTJMOVRnRkttQmxabG9oZ2hIY1dO?=
 =?utf-8?B?cTQzdlYwT3NqVUZSaFBnZEVpMzRkemJhUzdwQjQrL1ZKYWJlVzBVREFoWEg4?=
 =?utf-8?B?V2ZxQ1pDMFhLUjVwb001dGNLdHdXSktQbS8yN09qenNMN21KSjFrNjZ2RWs2?=
 =?utf-8?B?MFZIMytYdU1Ma2JETkFobXZJbzQ3ZEJ3VC9PamZLNXhrdzhmZTBHUVM0NlpE?=
 =?utf-8?B?ZHNVK1dna1VKSkQ1aWNEb2ZJWWpUdFNrWUNXMk92UjdPMHU4KzN4WkFCMndq?=
 =?utf-8?B?eGNBTS85MTNiV2VTK1RDTXQzK2hUcHlOM1ZKK1BqWGVTTzN3UXZDQTB6VW1G?=
 =?utf-8?B?bElieVlkUmY3L3RITFBZazdPMDl3ZktMaDdkeVZFZmRIbzc2cjV3WGtMQUJ0?=
 =?utf-8?B?blBDQkpSakxLSklTL3BMNlFSajExSTU1L01zZzlJaG9nSzVPTGdpWFlDRGYz?=
 =?utf-8?B?QWk1MTZ1VnZlcXlZYzNYaEJ2K2tYSllrR2RITGZtWWUxSklEWDY3TUFWNndV?=
 =?utf-8?B?QlJ4cGxTSTNpM2tiRStya21QaXZjbDc0SEc1eTdpU3BpYWMwZ3JNNUptSDFK?=
 =?utf-8?B?bURuNW83eVkvRmJNelZlYjNWbUtORGtDSFZCSW85MEI4bEdwWG92MDhaZEU2?=
 =?utf-8?B?YmxjdEk0dFFPOXZ6RnBpdHBoT0d5Y291T2dMa2FsZ0RSdlpBakxFeG5ZWEFm?=
 =?utf-8?B?SWNJbzYzRGRtNzJUL1o0OWNaU3pFbTFyYUVHYjNkaTNhY29LbVBBZFpMbWZO?=
 =?utf-8?B?MFlTRlNhYkJ5bkRGN1VDSjF4MGlSeW14UkNTNHFrSWh2YVUzQ201VnlQMUlX?=
 =?utf-8?B?amZpZ2lOQUtaL0xabHpTMldIbFY2Y1F6bTkySmtMZ2lERFlwVlhyVXFhN2Ny?=
 =?utf-8?B?d2NrMVpBcE9UVXREM0FDTUwyOE9EblhBbmc2R3ZtVGc1M3h0cER6WmJTN1du?=
 =?utf-8?B?MndqSDlXRTcvWnFwbkxoWWxJWUh0aE82T3BxRE9GQWRCVnBHeGdWajRONWl6?=
 =?utf-8?B?dk93aHBPWDJtVzgxVUtrcU5mZVJiTEtsMTNpM3oyZDF5eXB3Q3lQZDM3M01v?=
 =?utf-8?B?cUhiUUU1VWpiVytqenozTy83Nlh3NGRZRmFQdmRqaWRRUGdrN0xUV29vQUkx?=
 =?utf-8?B?OVNtaElTeHYvbW1TVHNrZ0NaTEJaZzN4aTV1SGpraEJnQlNodUl5bDRQRFRq?=
 =?utf-8?B?dGc2c0FvdG9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ZMcHNXMHpaOUxRazFVZkExZThHRitMM2Ria3UzdVRsbHJLZldHTmxkZy9p?=
 =?utf-8?B?Q09WcUdMWDZDQjNoTlk3eFZ5MUlQRWJkYXkzTzZnUnNleVRqTnBrSm4wYWxr?=
 =?utf-8?B?OElsbWV3eG56bVRLUC9kV1NyOUF2Qzg3NUR0Rm5yeVVvMnJpUlBSZUpJNzhM?=
 =?utf-8?B?MDhGYkJLcm80bGJGa0VEQWsxYUpYOGlnVlAzTy9MbzA2VjFqcTJlYkVrRGox?=
 =?utf-8?B?c3pmM3pPZEdQcVJnNjk1cVZmWE92eEdvVTByUXhKc2xEUFhWM0RGTDU5MFhU?=
 =?utf-8?B?UnBVNE54VFYwTDB1bUQyc1ZGK0Z0S2pqR2lPcENSUm9VbFM5Kzc4bVhBaXlx?=
 =?utf-8?B?S3BTdGF2YlpTakRSYkRmeTVwTTF3c2tMQSszVGJOOHRHWmlpQ2UvUjVHLzlq?=
 =?utf-8?B?akdRQ2lRZk5uUjhHblVLSnVFTmtmdElCTURjb1VLOFpFNzBvallIQ1VCWkQx?=
 =?utf-8?B?MjNJcy8zWC81R2ZneVpzT1dXMlRWbGpnZkIrQVVqQkhLRTJwODFUL0RKWXFl?=
 =?utf-8?B?cUlsblpKRHhXVjNBM1pDV0ROUnBoTEk0eGxMSDI3Y3dZT1RiOExQdWVZeFdR?=
 =?utf-8?B?VUpoL3MzUnpaR2xuYS9yQlptL0x1eE5aejcrSVpLcGgxdzVzUzBZQVZaYWhw?=
 =?utf-8?B?MGRpMmZhUUJiMnViekVOM2xTVzdENnB6YkI2WTlvN2JCcCtFdXNleUxaOEp0?=
 =?utf-8?B?aVNPTlVWRkpncmpEZ0pEUUlQMDRjVkNIVzZHUkJmdFA3bXhvcU5XVHBBaDY1?=
 =?utf-8?B?Y3hvYkMzOHV5Y3pILzF0VUlmNEtldWpGSDN6QzZMcFUzbStMTTI0QmIvSlh2?=
 =?utf-8?B?ZnVVVFVpTnk5d01vSDFBcUpUMUd2RGUvanZMQS9IUUJ3dzQ3WnlxUkRWUGw1?=
 =?utf-8?B?UjdhUUdabXovNTFIYXF2TW1DVnJ0OWxkamtJSTh4QUplSTZWTjFvQ0JtMTdp?=
 =?utf-8?B?NUpJY09iakJDSUVaUk1SMEUzMGFvcWhmMDJQUTR3M09IeHc4MVY0bkhNN3BO?=
 =?utf-8?B?bjZzbXROT3V3M0dIRWlVblVidVJKMFdCNWhwaVcyRWc2Y0xiYldKMWs1RFhB?=
 =?utf-8?B?TmsrOFFRL3hTN1VQT1oxVlRnMkdBNWxCYTBQbEVac3k5SVoxYyt6dnB0Ulh5?=
 =?utf-8?B?MjY3T3NuQWlPQU52QkZOa28wU0JnTmVLK2pIVTgya1VBZnFabnJxWTRiaThD?=
 =?utf-8?B?WTFxNE1oTG9oanZoLzZpSm1DL0NaU050V3ppdi9QTDZoZTlIaUE5MkNLb1E2?=
 =?utf-8?B?L1hzZVQzRGNZcjdYd05Ka0lnSlhwL2EzdWJja2RNSW9xelk4dk0rYlpxZ2hx?=
 =?utf-8?B?Zk1MZDRwbE5lTjRGUFVXaVZPdms0RmwvY00rTDdXT3R5S3hlek1oTTNYNGFh?=
 =?utf-8?B?WkZOR3BuMHJSMnVqbHVaaUd1clBuRVErajNvTlkxRXprblVURWdRQVBFSk1O?=
 =?utf-8?B?SnVjVTZtQmpQNlVxcmpYT1p1NDN5TEoyMjdrL2VwaXVIeUJSTkRlWlY1cXA0?=
 =?utf-8?B?aE9ta0ZvOUg4UU1GaC8vakdaU2JWS2VNT3pvUnJmV0VmSFBEUzlYMEE1dFox?=
 =?utf-8?B?K3JSY1ZjYTgzeEJvTHB6RS9oZlRvUFNKZlJzd1lTdmJiN0szLzVYUWVhTE9o?=
 =?utf-8?B?WUtkUW5WOXhjNkcxZERzK2xNNzVuQWF0cG1LTUtyVDg5eVdhS2hiUjlZWEtJ?=
 =?utf-8?B?Ym1ZUzFIMlV0dExqdkpOR2NLa3VMVDBlYnZ1VlV2UkhwYXRMeHcyajdtdi9E?=
 =?utf-8?B?b0dpS0pvck9oZU1UVVJpOFp2SnVNYmRDK3NvcGx5WVZIaEJha1dnZ045VVdH?=
 =?utf-8?B?NjlBTGVzUlVIVTZoSkJFb1VWRnZ4WloxVzd5YnQ2M05tTzBjZG9hUnI3TG8r?=
 =?utf-8?B?VGUwRVZWMit4aHlsQWtuV2NEeGVFY1JoeTFzclg0eUtZV3NHekJuRGNSVjJl?=
 =?utf-8?B?bFloQmFmQWZQMkJ6U09ETG8yaERMc1oxRjBXTW9mTTA3WlRUSUtRa0tkQTk2?=
 =?utf-8?B?K1JpRXd3ZUJGb2ZPMElXdGNYeHJEYm5wK25KYkwvNmVqVVlIT2pWL2tyRmR2?=
 =?utf-8?B?YVJSc25USEJkVlNPblVoTnNHRlRCdWU5RWpRbnRzUXhjT0Y1eWZMZEg2L2x6?=
 =?utf-8?Q?MczFJvVfjc+ggT9AvJOp+l/WG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2561a4d1-cf3d-4ff9-7870-08ddfc787a12
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:13.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGU0kOzmWpp45QSozMIZWXv+/ex1Gs1VBYQmLHrD4Wi1iRREwIifg3ofhJVsi8ZWZ31t5oCduWnwBUvtc6HQKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

rename m95m02 to eeprom to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: m95m02@1 (st,m95m02): $nodename: 'anyOf' conditional failed, one must be fixed:
        'm95m02@1' does not match '^eeprom@[0-9a-f]{1,2}$'
        'm95m02@1' does not match '^fram@[0-9a-f]{1,2}$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..f1cfbe2ddcd37f6e7c8312eb7a3e384c82ff61c3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -124,7 +124,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5 &pinctrl_ecspi5cs>;
 	status = "okay";
 
-	eeprom: m95m02@1 {
+	eeprom: eeprom@1 {
 		compatible = "st,m95m02", "atmel,at25";
 		size = <262144>;
 		pagesize = <256>;

-- 
2.34.1


