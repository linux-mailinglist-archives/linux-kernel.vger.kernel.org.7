Return-Path: <linux-kernel+bounces-776425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E0B2CD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC032A32D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD2341AA0;
	Tue, 19 Aug 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bhCQr0KA"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44D32C335;
	Tue, 19 Aug 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632676; cv=fail; b=upletdBE+o5JDDhNa5TXlz/IwLT/dwsUBUFfka8iy7j+DV+MKXhl9Q006PaoNq96D7ap0JcFE83Usx7rtGo0yQgqwytft99i76opbHW2vauYttNXheMlCUANcMKzvfyZJ0cyJR2mBMATU0je0WXsnB1H/3I+KXeXzNF3abqZLis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632676; c=relaxed/simple;
	bh=3mVn5t615q9QIQTDS5VlTTZSpDpB12ejIPduKOyDAIw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=q4Biv0Zbu+wusaCh+Jh468oed/A9op4dfWGNcFb5S6+JSkfVsUyPjXFFE6nX024hccqn1iw7PtJdJnrkeEVH6wRzn3gxsRb9baBE36Ms6bxATiwSP7npCHMaab+NHX8ZPIQGwdeneW0VPloJ3Xb3zJFOcGiBNSahtKIVI86D1XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bhCQr0KA; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwWTojACzWdNWIgkb3N6r/PNc+VlBmmkEYMSAzKOqmIc5cOVplx4ytHRirac1H+0fpEgEeVVjWH9ilNq9j2oMqpu3fwzjP1cmZUGxEpw8ThaxKfEeQ0EvbN0CiHCVQkjLkbdPDMO+VllWfhQQ7w7gnfdRD0eCN15yHEhw4cU6ib0hLUu0ptes9rNitp7zkLCo4NRRVGa+aSqOhDfOnK35ohp6+IUBKBddRGcS5tTSCwJHhPoZUFzILU9SmL1NE1Tmj468rq9rJOfCfTnd/RCIGrMEQ5D4vdgB6guiEPp7lYJlIp62bbOdALco80PmPYaGIM8F8il9x9UKflykEJjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmA4o7hdxzYctj/B4jAQlNEWk2p8ITKVyW33j4cUsFU=;
 b=Xj9fNkwum3ifnUH13MiOCRFDwPPl5hFaVO9QvrDUFckKZw/ggH718axdq8exFgx3U4viIV6XM8fKnE4NO2XDrSd2RfipnEV1P3O+CDv7YRmO5z/AOaXl98lj27Hsp4IA/LKCiUAnIjzLdoBj9TTB0bgJZhMPEC5/MN2wTiaaY1OzKpCrXN2PCLK8vNZhhReLEubUgpwkHVUTzigPa5/NmFSyPqIoyCv4IQurItrSQChKVuJkicdafGTZtiYnJtoH9c0xlgqLKYrjJOkqbvWZkHDX1jjc93rZ/17dSssV+afAdU6yXQpfMbMTEtDtubbDFnMg9a1QbFXjy3QipR40qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmA4o7hdxzYctj/B4jAQlNEWk2p8ITKVyW33j4cUsFU=;
 b=bhCQr0KA0AjF/z32TVvcDgu7mSTBS4JPTU7Ois2+tWh4PdSnzwO42ZSzZkq+r8irw25CU5xPynIEF78r/x/6DqBy7om/vINYhLpNLmnKlluUQlqI8m1CRMV/jrh3wzs0WpZiYAmzk7vZBT/QX9e1f0oQh903+fu9rpLdiASoUkj8XiLOI+m3RZGJCsQlubNfaacUhNyP7yWBooLH/uo+fFGrPYjK0IKcVYZBhbj6OFGIojPUuqc7ta3Mgk9yHSwQPu6Y3O4Vny1fv0XkoEfSkslaahI2ESU4KjCa1Tj+HOVwHmg9GE22rKNEXsN7t8B3DRSdUqhlNBf35+N7JEBikg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 19:44:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 19:44:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] ARM: dts: vf: fix CHECK_DTB warnings
Date: Tue, 19 Aug 2025 15:44:05 -0400
Message-Id: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXUpGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NL3bK0ioqK+PLEorzMvHTdtFSLZBPLVENzIzNzJaCegqLUtMwKsHn
 RsbW1AKCjZ9tfAAAA
X-Change-ID: 20250819-vfxxx_warning-fe8c49e17267
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755632668; l=964;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3mVn5t615q9QIQTDS5VlTTZSpDpB12ejIPduKOyDAIw=;
 b=j7sLuHNHrEv4GH5l4fjGc3nseXBTgKrv7NgZYlXa9GTxEFVpjn9ZaJpqI5L6xKDVjDhDeG+Gl
 SyuVnZkNYhGAvCF9EnOJhTHq+Tq4PQpBAFLk0t22fTM0MWRJlsNumfU
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
X-MS-Office365-Filtering-Correlation-Id: 50e6dcfe-e948-496d-adad-08dddf58d078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0c3blNZY0tFTkNXdkZjYjJOYXp4NTZ0NVdNOE5LWG1aUVA4U0Zzd0xjN096?=
 =?utf-8?B?eTBaZjJ2K0tMNG01ZU9LWHpzZVRLUkI3ZjE2L0Y0T2ZOMXFRSEtXYmJmYTFQ?=
 =?utf-8?B?YWJGdXAwK1RYTi81MDFhdDdrdXJXdFdoelZMaFhKNGNxMTFaR012MllsQnBl?=
 =?utf-8?B?Syt1M3dWVXdtcy9mUWdaV3NYSUxjZmhxZHlqM0VWMXU4UFM1WmdlODBveWtQ?=
 =?utf-8?B?V2t3NEhuYjN2NHlxWno0cGR3ejVlc0Q5QkxyaDRKdUxnV3pkNit5QUJEYmhQ?=
 =?utf-8?B?UDR2amlmSVpjbHY2bVB0WGxUSzBxZFl4Z3BrS09TTjU3SlhGL1RSNFdrZ0tM?=
 =?utf-8?B?QTNNdzk2OXYvbktqYXVTbEVOOExtY1pwMUhMNjdEb0YzUlhBZXB3ZFBOQU9u?=
 =?utf-8?B?M2RjTkxXL091TEI5bkJWRERlVWYyVmJZdWJtVTlFWExLVzkycTI2eGVDZkg0?=
 =?utf-8?B?Ny9scG8rOE5jQjA5YnVWMkpNNEI4c2hsUWRxSWR5NndJdk85cGgwaHphS3Z2?=
 =?utf-8?B?K1BXa0xJSkhheWs5Y1FZR21DTGZ2R21YMlJMMmNpdzI3VXpoYmMwaWNiSWZD?=
 =?utf-8?B?Q3ErVnBjdFBPTnprd1lGR2YrRUVnNUdoLzd3bGRwankvYkd6WmQ3TWxUcDVW?=
 =?utf-8?B?M3MvZlk2ck8va2NqR25YRlY0RHM1SVVSbDZUT0VOOEk0eFVkVk9EOW1GeTNq?=
 =?utf-8?B?NmlLL3hQQnVIMWd4ZkhiYVdRbEd5ZnNRSGRhbEZuSTloemVibFIzWjRLSmhJ?=
 =?utf-8?B?OVV5T3V3SjQ1Rm9KSk9CSm5FTW9LWjRuWUVzRk9qR1huWXJkV043VTN0QU9y?=
 =?utf-8?B?b2NYaVBuRDJTbTUxeEVhRkJlVnByTm4xM0dhYkkxMWdQTjFVajNGMlBBS28z?=
 =?utf-8?B?dDlhaG82SGFYZC9rQWpQSU4zbVpSSGcwYmxrY1NDOTg1emFlYVQweWlHYmQv?=
 =?utf-8?B?Z1RFRlZ0cGFhMHNYSFE0NWp4aVZWVENhSVFjWHVIRTFWblVUcXBxUzY5blU2?=
 =?utf-8?B?dVBBOVRpSTZXRi8vKzlVd3JjZVlLMGFZTlZGNXlQNktkeUR4VU11TklIT3Ax?=
 =?utf-8?B?NlZkcjhWckk3azhyMzVHZGtQS2M0Q0RMajRKVERERU13MGNKVEc3ODFyY1NE?=
 =?utf-8?B?L3NmRHAyd2orL3U3M0VTT2huMkdMNEFDeUdRc0hnTVRHcjBwdGhDQjcxUy9w?=
 =?utf-8?B?aDhQQSsrVUh4ZjM5djNHZWQxa21Da09vSitKb3FaSnNPWU42N0ZzUW45R3NF?=
 =?utf-8?B?U2tETGFXbGk4WGZSeW9VYzluYUpDSkxDY3k5M2xFdXQzZkI3YVlBeTBmTnZ2?=
 =?utf-8?B?TmVVMHBPQlNXRUkxdWdJOHdZTTdJVTM1M3E0R3JRbm5YcThsTzB1bHVIcGkx?=
 =?utf-8?B?aHdyZTg2cXc1Yy82WTNHQU1CUGd4RmcwTkh1Yk9GZHkvK250MnA4cXh4dkdD?=
 =?utf-8?B?VjA1aStLU0pvUEJwdnlMVU1RVGJxSWI5ZjN5dy9lQWZDb2xKeUJGeHRpV1V6?=
 =?utf-8?B?TnhoaG03VjFJRG5wcXhqQlA5TmJHK2VhU3R4N2JCRW9WUXJYT0R6SFc1YUJD?=
 =?utf-8?B?N3pwMWl4dGlNam1nay9iR3Z1KzZzK3Z6MitZQkhZMm44aG9IRW0xM0ZJVTNB?=
 =?utf-8?B?Y0NCQUwvQlAyOXBReTVWZDZYNEJ0YTRCQTQ4OEJLUWRIcUw1WnNpWDdTYzZa?=
 =?utf-8?B?aWhMb2ovYVh2M2QweURveWw0OGpDblhGODNETWhhNml2T1NyZGJLL0FtNCtS?=
 =?utf-8?B?VEVSYTBHaEw0RTlnZGFNUGpOL0k1OERqTzFEWHNuUlpuSDVHVzVQQkZWc3A1?=
 =?utf-8?B?KzlHUytnV0N4Z2s1RWZKYVdwNWFESnkwRWhpM2E3Y2pHWnJKcTJGOHZYeWQ3?=
 =?utf-8?B?YjVyTXB5VzlNZ1lLTmVHQ3JSVWJHVjFkK2N5VTM5UEtmTVNGQ0FGQ0JSeEw5?=
 =?utf-8?Q?UTnStXwIsIYZqUazhcYyFlVHVyOTWpU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkRWeVpFSWtrZGJ6NERUaTlmbnRFYjNxWkJHWjNIRFNUdkhLMGE5Qnp4ZDBs?=
 =?utf-8?B?SlhzUDNXUnFXWENtQU0vNzFZbHc1V1pOYjRqUmdocStEWnBhSTQvNlRRbHVY?=
 =?utf-8?B?SVhPY2lJQW9uV0JCeVRvTTBEQlFhZmJnNXhUZmRMTzZFOVltOHZETGFBTFVH?=
 =?utf-8?B?dWhpOERHOFA2OHFUYkhIVTNiWnNhOXJFTGhYQW1qMmUxZGhXTjRUWitkSG5t?=
 =?utf-8?B?cmxYTDYxM04zeFhaSElhTEdUSERyOWp0TXhsNk1VanBuVG81bmZrRVIySVVN?=
 =?utf-8?B?eHpWMHFnektkY05GR0QvY00yNmM5Y0plRjFibHViN2ZiSWdqN0NiRENGdlky?=
 =?utf-8?B?Z1VOSndHL0ZrRHlqMzZPdmRoRkJBMEQ1UGRTS2x5eWp4Z1hnb1hNNk9zRVoy?=
 =?utf-8?B?WEU3M1VTQVdOV3F2dVhINDRxQ1pGamRPOW5PTERVS2NUUzlPKzJoUDF5ODlj?=
 =?utf-8?B?ZzM3QStQRmdJVzlQdlMrc29PNHN4YytkKzJBY3hTQWMyeVdlcW5MMDRZK1JH?=
 =?utf-8?B?cUtRdXBEK3ZrMVZadmlPdHBYVW1YRWx6VU00azhJdUlHamxXTUdveVJFZ0hE?=
 =?utf-8?B?RmhQQnFYakIrdDZ6RXVjeDg0MDQ5ajQ2SXZTWU9mTC9pSTFtd0JyUEY4Rkgr?=
 =?utf-8?B?TGZsRUVQZFg3SjdlVmpJL2NyRzMvZ05MOFdkaThnTHMrSzB1K2VEMkt0SXVw?=
 =?utf-8?B?Y0psMzBWRFY4d2xvcitHMnF4OWtjN25LMi9nZmR3TnFkZW5iVUpHcDBTb3pS?=
 =?utf-8?B?NGsxYW1tUFc0dk9Pb1piMVErT2Vja0RqQ3dsNHh6RlVLYVlBN2VSdVAwT2do?=
 =?utf-8?B?TW1aOFlQMThuemtQem1lNnVTYUFrQStpdWcweUU3a2dkcFVvUU95SFYzSDhn?=
 =?utf-8?B?RVRlZU8wcDRDRU1tdkN2TjRINThGekdnMHEzdXhUb29JRmw0Z2FKWlZSMVJ4?=
 =?utf-8?B?UThHVlkrOEUrNXZnOGZsK01JZndwaHgrOUlwc2Fwb1kyNmI2WFk4ekk1U21C?=
 =?utf-8?B?ZURubHp3dm9tZ2k1b0lkYXNSeEZKbnI0SmRZWnlzYzJDQkxlTjBTcmpWc1BT?=
 =?utf-8?B?STFPajNsYVlhYUkvYlJMTnlKT2VrUjEvR1dsTno5T2lTSk92dE1XWGpwVFQ5?=
 =?utf-8?B?RVFIQXJ4QUhpRXcyaTkrYnlRcDlmbDgvdnNMZXhLR1lialRGMXZjdTdSVE9k?=
 =?utf-8?B?TTVDS1VWcXlyajRXRVVpODVvUXpTZ2JZR1MvelZZdXhrT2dCRkJLckgwLy9s?=
 =?utf-8?B?NXNJQ2ZTZFhGSzZCU3VOMzQ3SjNaN0Z0YmxhYndyMnVLV2pFSGZMY0FIYWd1?=
 =?utf-8?B?TkJkdkZrUms3dDFuNHpjNTdETlAzNUlVQVN2akhCWUN2cG5BQkkvbGVWTm15?=
 =?utf-8?B?Qm8zK245R0RqMi9IY3VyUmFEaVQ2Qm1GUktsaEhZRUI5NnNZQTVlYWhzV2Fh?=
 =?utf-8?B?bzZxeWZCalJRU0t3djFFN3hCR0hRNktnd1BDYmw2d2JXZmp2cUpYRnJWS3lD?=
 =?utf-8?B?K3pJYnB4NU5QMkxuNngvR3g1bXpMOXV3N05iVXNqNnIzNStLWHhKQjRLdVpC?=
 =?utf-8?B?QkVDeW0xSE1DQ01RNFV5M3pmUWo5Nnp5L0VQV3lXd2dUNE5yNTg4RWoyeVZM?=
 =?utf-8?B?R0VlbUJMSDUzQTNaRUdpNkw1Y2ZNZlhYa3RrM0F3QnB3ZzBIMitXNWxnTndN?=
 =?utf-8?B?cm9Fd2l0aEtCWUZIU1V6bmViaHJNeDJVRlBrMHVGZllpWVpySVVwS0h1c2hh?=
 =?utf-8?B?ekVDenNiY0dHKzRrblZiaTJzRkhVUGY2bWtFbWIvZmkxRVpFQ0ZmNWJJSk9a?=
 =?utf-8?B?SDM1Z3VMUTdZN05Wem5NVCtmYkFWSkhNL1puWFBuSTg1N0F2SmZaS3g0UXVO?=
 =?utf-8?B?QTJqcWwyODdtdEliZ1Z3K2xxVXhDcklzejIyU2hpNmNRUW9hazgwalBEOXI2?=
 =?utf-8?B?R0o0MmRvSncveWhYc25oUGU2YWdNWitJREtzeEZ1TTVjUlk2Z3hFNTc3b0hU?=
 =?utf-8?B?emVQVUU1YlRObWZDYWNRM2tVZ2VoUlBUd00xQVhmOWdEYkFocEhFdnZjeUFM?=
 =?utf-8?B?alh5RWU3bW1jcWd6QklhK24xWGpvNnNhYTljbHN0Zlo2ZkFKUzBpdFozdWRk?=
 =?utf-8?Q?+0h60i61Tt7jI2SbqOOMFin85?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e6dcfe-e948-496d-adad-08dddf58d078
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:44:30.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BekOVOdMJA0+0awx5J14vN0rYC5LNntsayq1r4j5OlfdvG+KmxC5k7XD9tHSG/i+MhfFnBcJB3WtaX+mK24t6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

Cleanup warning for vfxxx.

After apply binding patch
https://lore.kernel.org/imx/20250819165317.3739366-1-Frank.Li@nxp.com/T/#u

All warning under nxp/vf is eliminated.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      ARM: dts: vfxxx: rename nodename iomux to pinctrl
      ARM: dts: vf610: add grp surfix to pinctrl
      ARM: dts: vfxxx: rename nand to nand-controller to fix DTB_CHECK warnings
      ARM: dts: vfxxx: add arm,num-irq-priority-bits for nvic

 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts |  8 ++++----
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev.dtsi      | 14 +++++++-------
 arch/arm/boot/dts/nxp/vf/vf610m4.dtsi            |  4 ++++
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi              |  4 ++--
 4 files changed, 17 insertions(+), 13 deletions(-)
---
base-commit: 9c15bfe5311638391431166b201d964304ecce89
change-id: 20250819-vfxxx_warning-fe8c49e17267

Best regards,
--
Frank Li <Frank.Li@nxp.com>


