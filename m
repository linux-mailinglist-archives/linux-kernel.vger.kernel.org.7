Return-Path: <linux-kernel+bounces-776427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F1B2CD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A077B4F78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33053340DA6;
	Tue, 19 Aug 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcwJl8hE"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21F341AC6;
	Tue, 19 Aug 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632681; cv=fail; b=c2Yg687FhQ07lGBPbYdC3bpXYagW8MeSk7gGqBvRA/z+j+BAh4fhtxPHm1AU0cG2aClQFM0sQWBssBkUBnAYR4hIAZZkpwu1y2RVYoPOK0ZT9v+WwPLvQXDKmZGbhjDzd9kSMuhmQ5a3fUzSvDmqjFhmOdp+RCl3IDGSkAG+lA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632681; c=relaxed/simple;
	bh=4ufwdKXwRHz3ljXvRAvTFVwgtBR8dDOuyEwjmqG/w3U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=prfT2bBZ/aK9AuX6rK2wdgxzQVaTriAt6VkijxPf5bBQ8yttyeDhct4fAFJZELRGyqjrvvnO/GZYAwFBQrgs3KrQUnTl0AID2hbGNN9eOZNAWGrInqEnVLx7KSZ4mfyv8fXLjOHtC6z4DN4D7zasEd4TA1h72ffKGYNi7O5s2N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YcwJl8hE; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBlnxDS4D9VnofI++oXoVdaq0r9NZ8cFXZu9ihhTAIVkBngL1EyORU8RF5XYbRAkHeKKxiBd6J7JJBADdRvEAuQsAU7pV0akj1UJ/1shFGI5FI2fT7xRvYuRqAkcgd1xQxwdPY7qNQdLKa5A5/KvTm23THkSI98C7iQx06a3Y/36dTLiNpTTE6sa7Vqu4I5/Hn5oYDUQ4fkppLA5cKQ73bQmynaFGy2GY/OvErfujb+to9riiS9KivG7kDLh4vJQqr0epRiMVDBuQsYeQm6NSzwLvL8w7Dr2zY7dhIwpjs4VPXz9qBvsvvfqpXg9KJK9f+UJs9QILbj7dpRyo4NfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIhPmMcOyGy15m+G+tx2e1fIuUtBxONzs6lWHmaQcUI=;
 b=h1yWVpRWnKuZMwQrY65nqmMi8n9hGokHZh8My2GattTx0sNUHRgxt8rsgttZyUj+LluLq2wpBHSUmClXXX2+8OX2jBnxpt1j2Jil9msYsLD6aAlSz9Pcsr5erEhf5C/QFkwXdQPnV4vnodG86V5tOvk0r7BAdloVuQocpnGyQMJiF+gZl6o1MttcrqQy3Tap4wj+S0HasFYm4UW69d7P4VqTNZyfm8K29V8wikogW/32liNNVHI3c5ZKiYHcjKVFuruO9NXaFECwy3SZuXOrKOeNhXqQdJmOfrquZtN59sx13uttmRQCUe8prsxZhVsM5Sn94GHRA0P9Bgt4Ts9gIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIhPmMcOyGy15m+G+tx2e1fIuUtBxONzs6lWHmaQcUI=;
 b=YcwJl8hE8m/leWX17NKN43Nmq/qbbhvReOH7lRiQlDKdkUH/JP05wWU0SQDas/Z6pg0+aJmQ0zpHZAgn8Q0TtC2seYdRWMutQkSZais5uKvSCa5FJVJD0Kdd2jHCo4gePjabLMet2K32M9NVke4VELPlk0cns4flWkbK9ec4qA9ciBJ6P7rGce6SK087JOsyNucYBkwNJ/DL1YyfkvPEVjhUmEmSs4ASilSmH/1x1T8ODAAikRkdPxz2+8Je6/SpJEDZsa2+TdYGw+EAhTBUxCB8uWqviMZ5L2mJgJB0kjM3LiWYaX+d7bWUWtfjPWL32+dGpfLiHaYpn3cNnAFu+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 19:44:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 19:44:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Aug 2025 15:44:07 -0400
Subject: [PATCH 2/4] ARM: dts: vf610: add grp surfix to pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-vfxxx_warning-v1-2-080930d8e1ea@nxp.com>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
In-Reply-To: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755632668; l=3640;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4ufwdKXwRHz3ljXvRAvTFVwgtBR8dDOuyEwjmqG/w3U=;
 b=YEFXsnuoWmZ5mub1W5ztf2ZDTeGvPVHv4RhvOaScYmr4XJ6g9CqEe1PMzqTV3Ew/hCrkIe8fq
 zo+R0vhq4EiA7ddUcUMiB60hJARgcGP+OCwiYRouRAG86IGTa3pJ2Wk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e93ba2-0e45-495f-8a45-08dddf58d330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWFZUWtpajZBWWRtRmxPRFg1MWxweEtXREJYWm0rWUdrOW1NMXlkbGMwQk5Q?=
 =?utf-8?B?S1BhVG5zR2NVTlBiUDlHakJHdVliLzJ5Y3RlUE1LdjJBMmdpNkVmWXpWYmdB?=
 =?utf-8?B?Q1VvNkxuV21sRjhLRndxc1RXc280MHZxdGZFZjFtWnlHMXdaVlFkekk0MnhW?=
 =?utf-8?B?VVRtU3NIRW16eVRicXVRaHBEekZURXF3MjlMMlFsRUZ0V1Zadk85dEd0cWlq?=
 =?utf-8?B?OG1YNVBWRk5SNVdTYm5hKy9tK01kdDRvS3hrSmJVdCtNTWc3WDhGS3BpM1pz?=
 =?utf-8?B?M2NwWnB1RUxhV3JBNGJpb2pnenFJK1BQT2dHNUlVN2xUSVhKdUlxclMrcDZ4?=
 =?utf-8?B?Q2h3UzVTTmlJTDBCaFowc0tLVlR6dXAzQkZWemRnU0k0NGw5REVVcmNvTStW?=
 =?utf-8?B?SGloQWhSNjMvck5WdHZVVVBNMVdYblRybFdZRStVOWpnWVc0RkI1UjZBMklm?=
 =?utf-8?B?Z2NhcjRkeEQ3TTRwSytvZkVCVXoydFNjTjJZUUZPVmF2R2NVN1hRQm14ZXli?=
 =?utf-8?B?SEdjTkFzdDVCSlpYSThldDhoYWo5dWRaR3VuZW42Rzd3bUdleWRpTWVFSnJ5?=
 =?utf-8?B?T3o2TldXc2tiTlUzSWdoMWhrNGRpREozUzE3MEx6dysrMktpbFN1c0VoNXU4?=
 =?utf-8?B?eGtNVXdQK3FKVnVscnVZeDhEblJOUUVkWkk2a1FQQlAxQVQ3VnpLSUV1UXJG?=
 =?utf-8?B?NG9LWWszRU5yVVNMOW1sdTNHZkNaMW1zeC9YTy9haWZKenZFZlJsWjBjeDhR?=
 =?utf-8?B?b2JPMEJ3REpTR2FBVGZXcitiZXFneWQ3WTA5dkJ4M0Y3YU5vQWwrQVZoVWNu?=
 =?utf-8?B?NEVTam1nZEJTVlZOWWY5U1MrS0VMbnZPOWp0Q0hieFArVjlMQlp4MmRMVFVy?=
 =?utf-8?B?STJ4R2tETnQxM256OUdkQkFFOTZxSnYrbVlvYk02akM0OXhKUnlNVmc2dHhw?=
 =?utf-8?B?ZitmL21OdVMyK0s5bmRyMXdMZ1c3Z3V2WXJoU2tDWjFNWHdzQ0JOV1RzOTBn?=
 =?utf-8?B?cFZZYlh2NExUQWtOMTJOK3B4M29zdzRkZ2xXMzZWYTZuZC9QZHF4Mkt4NnUw?=
 =?utf-8?B?QjNhaysyRnhSZmNXYWNlSUdTcGVvRU5OMGJ0aE4zalEvU0RWUVZ3cGduUkZ4?=
 =?utf-8?B?THlFSm1xTGdacCtiWFU0cVlKbGc1VXhrakVDc055WHY4b3NLd2lDSDJ1Q3Bv?=
 =?utf-8?B?Ry9Sdmpnb3BQVlJ0eWNZNG9TQkovLzZUT1pkekdiK0F2UVdVVGwrd1JEcEp6?=
 =?utf-8?B?UGsxTk9VWTRFdlZLelc2TUkrNHhjKzVUTExMOWdJcy9Cd3NOQmNTOGVKMmJE?=
 =?utf-8?B?MkJyMmJ2T1FUQnNOWWxCWGRvVlVDemR4S3o2N0h5SU5oTHMwV1hSWExuSk9Z?=
 =?utf-8?B?Mlp5SVZPMExMNGtZVko5V01pVnVCY3NJekJ5ZUgrcmZHeGJJY0p2Yy9uTUtL?=
 =?utf-8?B?VlEvS0Z6dnY3OWJ6encxOXREelBPRzAwMW9xSWdXTnFOT0VFRmJFL2owN1Nt?=
 =?utf-8?B?NGZQQnBML3RkZVBLak5pWTVXK0ZaVVBXTWtlaUV4cXZIL1A2NWppUmNORjRO?=
 =?utf-8?B?NVZhUUVyWUNIK0lhcmpyTGdIdmhVMkowdVJGOHB5NVlxU2Z3VThZdm1jeFRL?=
 =?utf-8?B?eWVjS2xvdCtYbHVVN0VUN1JLdVBMMnJ1U1B6ekZYcTkrSnMvOUdBKzlVUzhM?=
 =?utf-8?B?YlJNQ2lqOW81OU5KRXh2dng5djV4bUNhb1YxSWVoYTdXU0dPeTFRZmpheDhw?=
 =?utf-8?B?enNNLzZyTit5REdsMUU0U2xQUGdEcFQ5QStuQkpKblNjZ1UwRXpiQlhBTzdy?=
 =?utf-8?B?ZnNFRklrMXd4SG90T2tHWDY3bTVLWUVkc2xoTGxndkVxTXZWUHRWalNHV09o?=
 =?utf-8?B?a1dCQmtHS3FVRHIvaEJDRWhDK05mYi9xTXNXRThCQ0NiMVIvM3VFK0NFczlD?=
 =?utf-8?Q?FBOK5pz4J7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEVtWG5Odis0NTVZUUN0L2FBa2tqNEpSOXBZUzJPNCsvODhaTk1YQUhtdFJN?=
 =?utf-8?B?U3JlNUFLbm9lZHVnZExZQTRob2k3QllFaGdlMndwTDQrRU5odFVZbFVoMDIv?=
 =?utf-8?B?OWlWT0k5ZWtaWExEdzVMVFJNbkpZanFvck9sZm83aWxYY0hGQjhOK0dhWXJx?=
 =?utf-8?B?dzRMeCtlOUQwcWJOMFVqdTA4UCs0Qzl0WEZiYXdZbUpCamdreE13Y3NiVVFN?=
 =?utf-8?B?OVFTM3h6QXpXdmI1akkrbkJDWjFpaTJxVXQzUnZWcWNqTUtWbWNBTFN5UnZ6?=
 =?utf-8?B?Y09mRUJOajdHMTZWb2sxcTJqNmNmaXg3bDFTd3lKeWF6cks1a041SENuZGps?=
 =?utf-8?B?ZTlwb1NENEwxbU5iTGlYdkk1U09hZjhKclJLbUcvYms2d2ljOURlamVDMWZy?=
 =?utf-8?B?VzRyQXNBS0tETElqM2dHRkRUS2NIQW9JMkphL1NIZFBxc1I2emVwRkF6Q0dY?=
 =?utf-8?B?U0JwNll1bUlPajdvc0pGSXZUZDN5RGUzeDZWYldtSVBGWmRQaFBzSTFkVkp3?=
 =?utf-8?B?dmd5UFdLK3V6MzZXVnExa2JaN1J1MjlJMTVRUXlrTXNWenhQZGtPMWFxUjJ2?=
 =?utf-8?B?dkR3Qnl0RkJ6RERCRThiQWdiWG9OdzNESk9LeXFoNFpvRTZ1QW9mb3NYdmJs?=
 =?utf-8?B?a0VHMFI3bUdKK0Q5dE5QRlZSd3ZGMkNzMmovSTBjbE9mMlJpb29kYVJiQnZ2?=
 =?utf-8?B?dXQvZzJKdE1XRGdVZHQ3Wk5Ednl4SUVrbXdZLzVzeS93NEI3S0J2dDh3SEdy?=
 =?utf-8?B?VUJuYUJXRG9SKzkwS3VTb0lMRTRlT1JwSlZzdkZWaHdwVFljL1lVOFNFQXhr?=
 =?utf-8?B?T2E0TkNON1BCZ0d4U1hKeWludmtCcm5lMGNZbWpIWjVQUGFKV21mdmFGR0Rn?=
 =?utf-8?B?NXFpTEhoL0U4eDRmSUZNYk04UUVDT1NlbzRnSXJZOHg3ZlVYdXdwWnRsTkFD?=
 =?utf-8?B?QmxwOHRMSjFPdXV5YjdLcGZESWpPdnowQU82VVpkZkdZSkIzc0ZheGw3dHlV?=
 =?utf-8?B?OGVFUGhXc0ZlMUYxU2Y5Y1pzVU5pVW93aGdrbHo5RDlyV3AxOG9FZVBTajJG?=
 =?utf-8?B?aTNNV29uYUxUM1RwYysyYjZtb281KzIwTlVVeHExRjFXZUJzYXdMaHVSTHJK?=
 =?utf-8?B?dVluSkZSYmp4a0tyVnpTYTI5Y0tSVGRjVEo3cVltMWRmZGpJTHlUODdHN3h3?=
 =?utf-8?B?SmZ1ZHNwQVVCbys5eXptTWpMVFFVQ3VvWllPdlBpcGNVdEJkNTlNUXM1YWxD?=
 =?utf-8?B?QXNLTU5JaS9Dck9ISEsvaEdFdWphSUQvUk8vK3FtU1VsMnUwSU1uaGlHL0VM?=
 =?utf-8?B?RzEydmxhNmN1ZnJ0UjZ6NGVmSlN5QWM5WlNlc1ovWGszWmZJVGlGeXI5cUt2?=
 =?utf-8?B?ZklXaXlIU0J3eE1Rc211UHdPRExmRG9HTUs1TFJtUDB4UWxaZGVRaFErcUZV?=
 =?utf-8?B?dGNLQ1BrQVRjN3BGdzA2OGFJeGNJNEFkMXB2R0c1MDF2QS9sd2cvYVZ5SGNh?=
 =?utf-8?B?UGVSdDdmWWhWZHZ3Sm55ZjFoUG9YUHEyRlRIUXlwV3crSEEwczVNcTlVT2N1?=
 =?utf-8?B?MkgyRnFTaEpKanVUMEM2NUxzWFpRSEtWaklGWXNHcTFjMmd6U0MyYW8xanJK?=
 =?utf-8?B?V0JOeW5GZHAyN2wwVzYvZTQyWlZ2OTE2VXZpbGF2Wmk3akRaVnpFaWVZamNp?=
 =?utf-8?B?VDZiemFQVkREMVdyR3NDZmNvUTE5RWdtV0FVYUxXR3ZDVTZXUU1ydWZTMzZq?=
 =?utf-8?B?Z1pYdlNMeHhFVzRIVE1WdFR6YlQrZ0FmT3p1S09PNFVZWXRYRCtuT2FmMHBz?=
 =?utf-8?B?NGtCclVVblBYYXZWQUkwTUsvVGNuWm9Rc01YU0ljMjRtM1ZlUFJVUWlYQnYv?=
 =?utf-8?B?VlJwMzU2alM2RzBQa09KOGJ3YzEwWXJjLzY5eG5ZQ0psZ3c0c3dTZnVSRTRD?=
 =?utf-8?B?THZrZVIreDN5bmw1NEliSlBCMW5DcWZwbnlTK1gzUEJZU1hxZ3UvTUhHMWpl?=
 =?utf-8?B?UUxYa0lPSnVmN0ZwRGxWQmtmazZVbUk2UzVLbDhBWFpZRjM3YUZER1VjQWRU?=
 =?utf-8?B?RThYdE02Kzl5eDQyT3pyd0hMYjVabVBkeEpxS2gzQzZyUUg5TXgwamtISzdI?=
 =?utf-8?Q?Mhu5Nf+j5KLsiDgdujWRCtSZf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e93ba2-0e45-495f-8a45-08dddf58d330
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:44:35.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+RGAQGA1T8KbDRq4vDfqSOwUWh7vHcyyRSG+dd5zLnu9+vq5LlCUY86hQ1iQYrsZlJaCnXxiA21WYHwfyS8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

Add grp surfix for pinctrl to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dtb: pinctrl@40048000 (fsl,vf610-iomuxc): i2c0grp-gpio: {'fsl,pins': [[144, 0, 0, 0, 12738, 148, 0, 0, 0, 12738]], 'phandle': 19} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts |  8 ++++----
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi      | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
index 029f49be40e373f706f7f67c34358ba9272ea0af..be61472393620e54c2fb83abe9fb232c055628ca 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
@@ -412,13 +412,13 @@ &mdio1 {
 };
 
 &iomuxc {
-	pinctrl_gpio_e6185_eeprom_sel: pinctrl-gpio-e6185-eeprom-spi0 {
+	pinctrl_gpio_e6185_eeprom_sel: pinctrl-gpio-e6185-eeprom-spi0-grp {
 		fsl,pins = <
 			VF610_PAD_PTE27__GPIO_132	0x33e2
 		>;
 	};
 
-	pinctrl_gpio_spi0: pinctrl-gpio-spi0 {
+	pinctrl_gpio_spi0: pinctrl-gpio-spi0-grp {
 		fsl,pins = <
 			VF610_PAD_PTB22__GPIO_44	0x33e2
 			VF610_PAD_PTB21__GPIO_43	0x33e2
@@ -428,7 +428,7 @@ VF610_PAD_PTB18__GPIO_40	0x33e2
 		>;
 	};
 
-	pinctrl_mdio_mux: pinctrl-mdio-mux {
+	pinctrl_mdio_mux: pinctrl-mdio-mux-grp {
 		fsl,pins = <
 			VF610_PAD_PTA18__GPIO_8		0x31c2
 			VF610_PAD_PTA19__GPIO_9		0x31c2
@@ -437,7 +437,7 @@ VF610_PAD_PTB3__GPIO_25		0x31c2
 		>;
 	};
 
-	pinctrl_pca9554_22: pinctrl-pca95540-22 {
+	pinctrl_pca9554_22: pinctrl-pca95540-22-grp {
 		fsl,pins = <
 			VF610_PAD_PTB28__GPIO_98	0x219d
 		>;
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi
index ce5e52896b19d1ce80c2f34bef160ab57f12885b..91cc496ffb9065c98f539d7f5b553cb3926031aa 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi
@@ -335,7 +335,7 @@ VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
 		>;
 	};
 
-	pinctrl_gpio_spi0: pinctrl-gpio-spi0 {
+	pinctrl_gpio_spi0: pinctrl-gpio-spi0-grp {
 		fsl,pins = <
 			VF610_PAD_PTB22__GPIO_44	0x33e2
 			VF610_PAD_PTB21__GPIO_43	0x33e2
@@ -345,19 +345,19 @@ VF610_PAD_PTB18__GPIO_40	0x33e2
 		>;
 	};
 
-	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
+	pinctrl_gpio_switch0: pinctrl-gpio-switch0-grp {
 		fsl,pins = <
 			VF610_PAD_PTB5__GPIO_27		0x219d
 		>;
 	};
 
-	pinctrl_gpio_switch1: pinctrl-gpio-switch1 {
+	pinctrl_gpio_switch1: pinctrl-gpio-switch1-grp {
 		fsl,pins = <
 			VF610_PAD_PTB4__GPIO_26		0x219d
 		>;
 	};
 
-	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset {
+	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset-grp {
 		fsl,pins = <
 			 VF610_PAD_PTE14__GPIO_119	0x31c2
 			 >;
@@ -370,7 +370,7 @@ VF610_PAD_PTB15__I2C0_SDA	0x37ff
 		>;
 	};
 
-	pinctrl_i2c0_gpio: i2c0grp-gpio {
+	pinctrl_i2c0_gpio: i2c0-gpio-grp {
 		fsl,pins = <
 			VF610_PAD_PTB14__GPIO_36	0x31c2
 			VF610_PAD_PTB15__GPIO_37	0x31c2
@@ -392,7 +392,7 @@ VF610_PAD_PTA23__I2C2_SDA	0x37ff
 		>;
 	};
 
-	pinctrl_leds_debug: pinctrl-leds-debug {
+	pinctrl_leds_debug: pinctrl-leds-debug-grp {
 		fsl,pins = <
 			 VF610_PAD_PTD20__GPIO_74	0x31c2
 			 >;
@@ -436,7 +436,7 @@ VF610_PAD_PTD22__UART2_RX	0x21a1
 		>;
 	};
 
-	pinctrl_usb_vbus: pinctrl-usb-vbus {
+	pinctrl_usb_vbus: pinctrl-usb-vbus-grp {
 		fsl,pins = <
 			VF610_PAD_PTA16__GPIO_6	0x31c2
 		>;

-- 
2.34.1


