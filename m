Return-Path: <linux-kernel+bounces-853276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C37BDB156
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98F718A6489
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EB2D061B;
	Tue, 14 Oct 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O1heP3BJ"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818A2D7D42;
	Tue, 14 Oct 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470750; cv=fail; b=FMMfBAHWbBKdYsI1C/I3DnBas2mNxgGMIfaGQZR8BRnZr6MxIFj9xk1N7DvzKWT2c8LH+qBTX+BCuYQOZCFwUln0EZlfsHLv2Z+lrxtJMfcqkFxj9pSZkvplCb1HlQH8LYejAaHVXmtAgaj227gOeOgzwhL29wpufdFutvtOBNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470750; c=relaxed/simple;
	bh=58DhL3zMvqEMPhqImw9/QOA5WT5XtR9bU7IqqSV35G8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oIDLVgp8FL/K0Mk11J7NwX8ZoeE6+EGnXecWUe/dgp5l6cARguORbvSWDKk9yt7nGM74YQQO3OWPC9Y9a+bygPbnbWPc5XnNe4ptTLXc7ftZ0eKoWdh+MHsrLDPhAsqIPpU6QQfneXiUb1dUrTFbiuYkK7fKVIPQpaMQak/TbCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O1heP3BJ; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbtCWReRe2UVDBKDHQt3sWKz0aAd7Kh7rRwKb5Ufgwilb8R0MrzQptYP9pLvmm2xyE7dN5BJLQRfMedFB5F4F2lN7ZOKm8JavOA4AfaROJB5YnuUas4BbbUZj02t2FUoGsVnq8SNkV07taDz58dGO3sQNMGFhU34ydZ2P8k0FOADiFOf45Q9Ji9eJLNkDFL0GzRJc3SEDG/bKHsfUkjF+p8ppMVer9BM7SlJC7wBaMKTB8v093yi4bBBe5tajvItej2TWkF6gEK1/+LtMg3k9GhOrKWB9RxFyh4QdwbjPC6mih+z+UTFXU1DkYgIXuOoMsMraAZO74OUrQ7ehOXRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDWYiLUFUXJSlR/58H0Y8CTY3R1C889hCziNwBY8y/c=;
 b=wGfEzBhfn/Aj3fVER8c5bSUoHR7K2UJdnQW4mwGnNKUYAEQLVHhUraMmpmFxzPl5vkoHNxMFMHKCffnAwehB97tciAJ0MLC0kiC/XlZjYdTamnHLrLVeI7gUm5k7IDGamKtbZ8wKIlg4uJ+32qiogtnpMIZTQ9wdQ0tos6XXEKcpCkWhi/N9POzoicz+zouc7X88gWa8sszcPbPmj2susNZPMKpQIK0SvkOXyyIlMOXEMQkeJLqaQ3SUjx2kBnPycwDtD86hf+CnNPrafV2QMAUhjSN8wKEsTWRewT0ENw4C+ZoNmpS2z8mUL04uaxmK+mhzRr62DOG8v7998Rb1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDWYiLUFUXJSlR/58H0Y8CTY3R1C889hCziNwBY8y/c=;
 b=O1heP3BJEjtGDuYm048xdnnXpNdNuGTlGuw8b0QbEQIPJ12sNC8ODqPWMUL9mYbj0khLHct2+SgxNlAFF9y4hyJpaN3URA54OmIPs6l43q9aZ4W4NTcrSGhcik+0rK1V84s81CZrlswpf/2SnZw5Xj9zCGHnAds1nt7WL+b96ExPXEeRwAZodkjusW58W0veRc8z335hMd4HSq60boj76DlEp8vc2igf9Km0CRBIzHT+sE+TnWnMd4hq8Fga80vqSFF+bgjyOfRUJbKMLWelw9UMobr4qkwBxi5t/tkl8ljlHwNfPhUkUiZEP7hzlVX7UqRZlTPFgUPqoGUWnC8Fpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:39:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:39:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:23 -0400
Subject: [PATCH 6/8] ARM: dts: add device_type for memory node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-6-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=781;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=58DhL3zMvqEMPhqImw9/QOA5WT5XtR9bU7IqqSV35G8=;
 b=mcSMP9UMML593ssHRw+C6X6huPntyQ2ldJoYyRQKwnHiaVyv/s6Z2y7F9ZAUXqN1B7NbBCSn3
 dRA2Fot1CqgDYW5LInaiO5ulGXHrgHNbe/K9WEL8VYOVBx6eo/ziCIf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: bc377d18-47f6-4291-043e-08de0b5955bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWVXMWgrSmduazRSa2dRTk1QV2xnRWFoc3BOeTQxSGV1QXA3aHdLbGpiZEZE?=
 =?utf-8?B?VFJsKzU4Zk51bWRvR0dOWktrbFBkemZ6Sys1MzMwVy9wTG5RRk4wMHNPY21h?=
 =?utf-8?B?d1VQWHFOenBQUEdBLytMcC83dUFMRCszN3NoYXlFY2lta1ptZWtZNTlpQjFh?=
 =?utf-8?B?blNPUUtPTTdXejlvbnhlMVhOVnAzTjhIRHVTc01PZ20wTFVvWjFRcHdpTEdC?=
 =?utf-8?B?bkVWeFBSSGlhUWRQOWd6NGJMcXV5dzNlS3IxVHZSNGNGWkJqZXdNZ21CVFFy?=
 =?utf-8?B?ZDU3WFlCUlhVZ1R3MzFQeXlmSHA4ZzNqNnV4WXZuTVpuTnhaRFNxNXhFcFNY?=
 =?utf-8?B?K2hpMmtWODlRVElYZHArY0VYaTJXbFpFTWZhWU1YcXVhL2ZBYVNVOFJKQVlI?=
 =?utf-8?B?U014Yk5xcDR1QS9FbGpLMjNPUHNBa1k5UjBkTzdnWm9ERjVBcUZjTGpRMWFM?=
 =?utf-8?B?dXI1VjRMRjhNaFlDb0d1YURvcENTU1duY280ejdjTkNzZFhldHBFVDNuOEc1?=
 =?utf-8?B?TWR6NWRJMW42SUJxQ1hvSytmMXNWeU5yanRSUVh1alZkQ3hZR3hYVGxQTXRk?=
 =?utf-8?B?clF6K0VSQUE0OUJmUmJsaFFMYnNMcndsYjBIS1d2TnQvd0FNZldad25XNDdZ?=
 =?utf-8?B?UFl6Z0Q0N2JEUjdsZXkzQ28vdVlWQi9zd0J1M1FDbDQyTVBILzlFUjJ1ell4?=
 =?utf-8?B?OXAwVmtzcHAwSVI1TE5TRFZwU05kTlpjV0dmaHczYnVRRU5lMlhvWVZMdC9Q?=
 =?utf-8?B?TUlYM0RvWjkrOFo2NW51OFE2YkY5WVZlZmxSa2Q4MjZlS2p6a0hIb09lVlRm?=
 =?utf-8?B?Ly9GZ0s2ckcwMlFKNFNjaDhBc05ZbVNnRzdQWUppcVpxRkNpd2loRWRvM0tM?=
 =?utf-8?B?dCtsREtDR1dVOVJieU5jNjdGelY5dWRjbEtGZlNqUGE2YUNwSmFYaHdva0pt?=
 =?utf-8?B?c0pXckVxUkk3dEtuMEd2MVRXclE2Vit6M1ZSZDcyTkhSSXVNU0ZjdlVCdFhr?=
 =?utf-8?B?ZEVBNUxna0RjS2VzMmlSZlJhc2l4VmthN3NaSGxaRFB6KzNqdzJzWmFhOVZN?=
 =?utf-8?B?T2JoTWg2SkRNQjdHbWpoRkJ1Mnl6eG1PUG1weVdBNUtBWWZOL2IraVpiaktS?=
 =?utf-8?B?eVhUMHdaL0F3dzJaWTlkc3BrNThCSUlCY0pXb1lad2VPNlY1eDAvSTRpbEZV?=
 =?utf-8?B?WmpXYmpvNGNXVDZpTWxHZUQ5REFHZGRadDhqOWpFTExBMWhJMU9Ea1Zkckx4?=
 =?utf-8?B?UUlvTGFIbUtyRFJ6SW5Kc3ByakVnYjdEbHhoaUVRbXZYajhzbmoxekJRZDIw?=
 =?utf-8?B?ZDdaaTJpcDZYR2tQQ0RNZU5VUSs3RUNlZHJGaTFtMzZ6UzcxcGhZMVVxdVZw?=
 =?utf-8?B?QzIxL013UHdSTjNJQjY0Yys5bEdtMU12bnJFMndmN0p6Z1ZUTUFVMU1LU1hw?=
 =?utf-8?B?clRGamwzUlF5VzFRT3c4OUlPRG50VklYV1BvRFVtTHBIbWNDK0ZzYUR4bS9Q?=
 =?utf-8?B?c1p1N1I1MlZtb0UzRS9iV2N1cFRaZG90VlJSTnZxZnczOEt4bzMvdzluaFhu?=
 =?utf-8?B?b0REM21nZ25XdzRJZWZGdUs3cWZoMExQZjRLSlNqZmhmU1I5SEhjcThoRkZv?=
 =?utf-8?B?QW5QRXZrak5HQm8vb0t1em1zVE1KSUpyQm5jT3F2S0lIYWR1RHZpazhQOGM1?=
 =?utf-8?B?Tno1Z21zN3dIaHZjQkxvSHJOWmRyL2ZsWEl4OWFyMmtHdUxhblY2eXI5QWJa?=
 =?utf-8?B?bEFvS0I3cUVCM0hCQWNuMlh3QWlPQ1NGWlN4R3RSODZNWndXaTNxOGJXSHBM?=
 =?utf-8?B?MlNsd0JaVnlvT0VVNjk1Vmo4MlEwQlVKUTdZOE55eHpNSFA0b01abDN4RFF2?=
 =?utf-8?B?Q3Z6eWo2enBBTXByNzZsblUwWGo1MC9iMXZDd1FzMGFTaEdKQ0pCTHBoMDhl?=
 =?utf-8?B?WHRaV1VWQzJFTVNwd2lxb1ZIL1pFMUMxK3owUTEvbGFKdDBnalVMTFdBT2hr?=
 =?utf-8?B?YllCWHAyT0Z4MFRIcStjSWJheVFKQlRRR1lMaWt5bm93M3hGVU80bWg5aHk4?=
 =?utf-8?Q?PpwFpc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky85VmJrb3lMNDRIUkpTL3pvcUxSeFR5ZWIyTzVia3UyZUdpNHgrN0p1Uk4v?=
 =?utf-8?B?Q1pGTFA1TEVoeTFOTy81dk5jOUVGUysxcWNHV3dqKzBVUzBsdXNWY3NGUkww?=
 =?utf-8?B?Nklic1hhOE4wOUhFYjVad0lOdmdudXZNWDNBb2NEZUJrNnJrcFFVRUxtVjM1?=
 =?utf-8?B?bDQ0SUt6ejNxb3lNT0ExaGxhTjkyOXFFSzVGOGtTeWdTYmlaOHQ0cENzcWQx?=
 =?utf-8?B?akdNQjQ3cExsaE9uR2dZZTdsaS8zVWhPRWN4TmlCQmtEeWM1VzR3VmJveHBI?=
 =?utf-8?B?V3ZLUlZycGhCK0dtRHFKMHYwU3pWWjBwV3RLbzZOQWw2QVNTSk5HZVFlUFhS?=
 =?utf-8?B?OTkweHhrT1AxOWdtT1g5RjlYV0kyLzZERDJtQjc5RG9FcXNlWUxxbC9UYzRq?=
 =?utf-8?B?dG00UjE5bHVsMklWNUZHNitIQjA4QmNkdHZadFFYeTh5cTVEb2lvUnFsY2Jo?=
 =?utf-8?B?SlVRZW9WVmp3Q1g5UDQ4NGNpUDZNUTJRWERGYW95amlRa1BSODUva0s1MzZU?=
 =?utf-8?B?d0RibW5lVWVqY3MyRWVlaHBUMXVzcDZMVi9mM3RPdkNDdFFKSFVrZDBwNWRP?=
 =?utf-8?B?VWlkaThnUVExY245Z2x1aGFKSzloMlJGdkJ2SWpkaXJ1d2U5Wk5WZXVKWGNu?=
 =?utf-8?B?YUM1cFhRWlBOTGkyYUkvZDJ5MjBLdTZqZE5aMzFPa2dVRXc1TVVtdE1yV0NW?=
 =?utf-8?B?Tm5CUlBxNy9BbDM2S0I4RHpqc3hnMUlWVkYrK2FMRjNKRElpZU1RQnM5M1dO?=
 =?utf-8?B?R2FOMFZUd2hXNXFHa3Z4bXhsczR3MElDcDU4RVdQSVZzbDNFWGxEWWtjRDYw?=
 =?utf-8?B?aGdyS3JkTmdqM1VzcUpGN1BzL2p3SmR6OGRHK0grRVRoZ1NTYmFpQ3pxK254?=
 =?utf-8?B?RU5ZZU5iaE5zSm83UjVlRzZlNmJDVkJlWmtMRjNxd05xcXRRK3JkRmhhUWpD?=
 =?utf-8?B?Z25sUUY1eTF2V3Bjc0JlTXJ2dW8yOHpJd2d6bFR3dVdqcVppVDRmN09LRWpW?=
 =?utf-8?B?OC9YME9Xa3dxTlkyNnArQTFZcUFjYkNsbUNmb3RjSlBGMWhhNjFDK2JEWE9E?=
 =?utf-8?B?WVZhb3RsT3I5b2l4dXkzRFBsalhmdjVhWURvVHkzUHBwcmlDVzcyWkFDT1ph?=
 =?utf-8?B?R0lxUkpUVUxOaDRySDlDYklKUE14WEY0cnVMTlgrSkY1R25PeTA0YVl3c2E4?=
 =?utf-8?B?eUM1aUVFSW1heVNHZ0VONmZqT3A5eDBmVUR1Nm5BZlY3YnhDeGR2M08yM1lG?=
 =?utf-8?B?Qlpmbm85TDJrTTlYTStMWG8zR3JqSXlDK1JTZlo4TTE0Z3cva2tXWU5VaFFk?=
 =?utf-8?B?R0FLWEl0dUcyZXFtRE41MlNGUEh6TTJzejVxd1pmTTN5N3Zpb3k3TjhmS1Q3?=
 =?utf-8?B?cmhheVprR0lvRGYrcGx5SUxSMmREUnNtSUpUWlE1L2RJRXdNenFPODlGVGlJ?=
 =?utf-8?B?UUIwdVNHem5MU2MwaEdNV3grMU5UYStjWXNPRkt0MzZNNWFuZWpYUHpMVm1n?=
 =?utf-8?B?cEpRdDdFRHZyL2tSaFFGT2ZEY01UNTIremRTd0xiR3NBSjU4SWwvNnMyNVcy?=
 =?utf-8?B?NlJQSlhhRmZNOWloaTNiTE0yZzFXMW1aUDNDZUVRSnNPSTdXT1lSZFY4Z0RM?=
 =?utf-8?B?TDJ6TEkyTEVnbHJFWitzL2ZzSFBmc3VNUFhuOTBadDlTMFVkQnBXYUxYdnlt?=
 =?utf-8?B?L1RUMlFPZ0VveXMxQURmTnJzYUd0bTcyaFlpRk5qdXJFZGlVdGJDSHRjNmw4?=
 =?utf-8?B?L2RtVnFqS1JKSDJOem11dkNwYmhVLzN5REExSncxdTFEb214MXdmWDRJWks3?=
 =?utf-8?B?SC9OS2RFSXd3Vmt2V1ZiSDhRNXd4QkM4RHU4V0Y2TmQyYlRTNXlGOEJBcTRS?=
 =?utf-8?B?ZkgxZi9NYXluUlpaRHVvZHAzbUJEWUFsbi9BcXF1bXN6VFQyU2dreExJMHFP?=
 =?utf-8?B?VmE0T1hKUUY2cTZkck5lK25oYVRNQkZFZnY0NzRHdDdyb3VaVGtZcFZZaWJv?=
 =?utf-8?B?NklxVTE0M2hjRUNoamIzUFNxL2M3aFJxMjhMY1UxZmhUbG9HZFpQUTBwWTdy?=
 =?utf-8?B?YWR3MDc1bEtLMmNIUWJISjBCaCs1NnpCSUp1QWRIZlNYcTl2MDgxV0RFNFFL?=
 =?utf-8?Q?BB8Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc377d18-47f6-4291-043e-08de0b5955bd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:39:05.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFGQ0kRSBXzjjv1jQXtt/L+umPZkCNQFhT1H09OIGLvvsyDQQYF1WV9ibRp+fo09tQrGcXcY5YfvZF2lAtPzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Add device_type for memory node to fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dtb: / (ge,imx6dl-b105pv2): memory@10000000: 'device_type' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index 7a3b96315eaf55328cae2329357305b70c99fe6b..d5baec5e7a7824c05ca64c36a1839efff0bd7f71 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -14,6 +14,7 @@
 / {
 	memory@10000000 {
 		reg = <0x10000000 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_3p3v: 3p3v {

-- 
2.34.1


