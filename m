Return-Path: <linux-kernel+bounces-811223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8CB5262E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD82466754
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A9422256B;
	Thu, 11 Sep 2025 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="b6WNDVE+"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824252AE97;
	Thu, 11 Sep 2025 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555901; cv=fail; b=be9CCc8Qybd2fj0RMy3v5vlM1E4zIGsmUWWUnPer5G/79iGnkDkHfibXSf2k24M5SM8zZUbjzrN7ScASO/cQJdq7nZ8u8j5Py43m8SKdSG9zC/lLx8AP+OH8xbFaOl+5ODJujW8eGkVlZz5sURdYQvUMQVgLi7UMfwpLJrO6Wdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555901; c=relaxed/simple;
	bh=GKx1PEn2+jn06ICt4a7jYq+ea1dIn3WEXDjYoNQlPEk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LrV6U93ZXU7W/qtFkvGEgwoTuuyeVadcuewS33Rmps10U4WaE93sZPlp8wtk/0e+s1mXuA7HKK3t7NP1HrMuVwvFNSoDrpUPZLWuon+7aMojcL/WBDESknVodSsJRRwiFcUxOpmxNV97PxRKST32eX9wlm4/PacemDp8ym663Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=b6WNDVE+; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWiM+OTBWUV2wHkuK0cqA+hNSgmfhhW0A97/yEdZqq9JkdGIGZYqUDgUq5tUREAAMmYMxMiLA7krb1/EHWl1++wQj7vP2hGyIWUeFIBxwJ56kCqVA6yEY8eVcyFzeBpFUf27SiR/8LzWZOcUoIn0J00KvMvDccktM+iiG1TJDunWSPQUjfMShAIXD/RyKB+ZF/aznNdKntr5ppnfaRUvmEDIZ7UtSMr/xJfh2Iy1ethWHue+ESZv9nKHdqRrLtUbsduhwoeWadGeFQpfAd+ZDhcPPUU0SrIXN3jOo5hNgv4PBa0iYo4ybiFlrDtz40KRly4ylItfmR29ndlSl3VSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0Fo+0HldEyhi940SIzYsPGxLUKv5Elm+Ygt9xaw6nY=;
 b=nDZobywEGor61MPfCAUX8ZSa/XZv21MqOsJ/uuvamJ5+06ohOVS1dy53tEiCXejMKUy/203jILWTLrL6CJ+b+sUDCK39swGwmyGQM4tgLsoGvrL2SO98v/2ioo9rAcUHvMSlggYzfHRBwShkqvcxXakd1HcObuAXJ7kgsarPzTLzZaJib11EwFv/h30fJdIYKSEdrAyK7Rg3wM/Ty/SAyiBRYz1foUl9FCwDJtZz51cMclOZIEGBgx4AZutQNjy8I/nurvOCuxYDBUOnd+TrGLsl0hKnWspFA7wj3GG6YFHlfDLO7k9HxHQUCzBKha1nMLzOc7PY6HWq2ZMtZxkiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Fo+0HldEyhi940SIzYsPGxLUKv5Elm+Ygt9xaw6nY=;
 b=b6WNDVE+NqP51MzhRm+Jlkwa91qyHhyfjYNDdDprE1iwxKnY+EUthBv8yTL4yKYQ9S+t1yPRonfsWqqw/blIFZ2eq2uYFoFSVLiazdgwcQgPCVKM9cUQNdo1VjNf6eGneeB10HnRya8v60Io985pBwvMMQ3DhFV0wWXDOJ8VmDlqYBEUopg1TiMCdGhH2aGrze9u5aRnYcNxWRmyLGJaYoz9brzHs6KtIcJNcI7ED9ciOUu0JNF2BPTuTcQEX6I+HFgiLmLENE3ybNwcXjwTRpvaTYIjm/LZZTkJopWzB1GlMPW3XCUCi2lDeT5zD1Mvf87isjiAMqKcP0YdZotFcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:58:17 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:58:17 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/4] Add 4-bit SPI bus width on target devices
Date: Thu, 11 Sep 2025 09:58:08 +0800
Message-Id: <cover.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|PH0PR03MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaf50fe-dade-4170-179a-08ddf0d6acef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQD3Fol4carT+D8+i6g2wbQFaHm3SUDAsP58KCyF4X0kibjyg7n+adFCh10a?=
 =?us-ascii?Q?+FE7PAWktAWDlttKKVgqCdLSsqIXNc3cTs0tfFew+WNMS5iURrwDwP0ma+Ju?=
 =?us-ascii?Q?KbzCJPBVLCK4V9uWWJdBPTwb8TID8jkp4ihLF6rHdL8znRYvurKiNljX7W26?=
 =?us-ascii?Q?ebV9XZurgegMoiGIAyEIeEfanCWqmqDyky3NU7NmL4LLDvOfJaXfu/B5Z7rf?=
 =?us-ascii?Q?k/1/ztbTBnk273BYjFP4hlwRupJRdA4rtOhOhaE1S1EOvbXMayU2d+mNrV5R?=
 =?us-ascii?Q?K6fU1k81kPOYjgkCixE9b5v2h9rdi0atgKlASuLmwhVK1yQc7RxrOxXwMbhI?=
 =?us-ascii?Q?lBTF6f4W3bGhtM/ZvaGDF3yZDF1zod+xgxfAEuMRlHqLegdzSq8Y+l3aFO8L?=
 =?us-ascii?Q?+eyV+GzCYlJZkVbBMHKqVElcd4x2kYjOifPTduUiQDOiCcLvotxfPb04z/Xk?=
 =?us-ascii?Q?OFwOU+n9mSj3Yhiykulhs+y6/KYn2k9US9dSTKAcc6dUHYt+wSGiB13Y5VGX?=
 =?us-ascii?Q?NmJkaSVdmffgt6KuuuGSrDM/jZVSLt7ea6wmPCCIapx1dBaBo4+dDVw0kt/7?=
 =?us-ascii?Q?li0TpsJbbir+tguplRb0e49jwDB/dkvBsRPS8o0NO6Zjyv/CEXWSPIXbz9+N?=
 =?us-ascii?Q?nwDjgZ/eYi9u9u89BaIOMBgZ27c2xgTZgW2ffGxxQ7iOnJlgRouLix9vUCFa?=
 =?us-ascii?Q?Mh/KkVPnIhg2EKleNN4feCbQB6dBhgf9Pr3/BGyD2oLpPj8F/rQdsf4NTRhG?=
 =?us-ascii?Q?JNNHClexB6pfG8pubsP0VbMZEaoLT314xNX2p47k7k14ZojJ7WF7jc7Rx3T4?=
 =?us-ascii?Q?PSUTxo0lG1wKzUcRnu+v/YVZ577QLKVTnkpVra9otesDSWjoqHqHAgXuz8LY?=
 =?us-ascii?Q?dxrCPprpLqdwu3H0RizsmNQki3kc1csxigVyKQXrwYWLnxuEsiq/SDymQ9MT?=
 =?us-ascii?Q?Mr0NhYogPyZPnknhGCT3/q4d3BPCpgXZfHSBhbDeNjBf2Hr/MGX/k8pa3CU2?=
 =?us-ascii?Q?91MgT2LeJKLw/AzZC1N9Q6eAn1yFkZlaDbwtsJcQ6WFPn1oDZVP7wiIVF/xV?=
 =?us-ascii?Q?cRiPM2QMn0G0JcsbAPvSrbKidFCHPZq9qiB307tuQsruE6vA0VhphE6uIqtn?=
 =?us-ascii?Q?M1M64MRUwFRaFbH9xbe0EWOu6+hDu/2m3s0MVRvqblD4ZJMSjV1IE9uP1Qx2?=
 =?us-ascii?Q?LsG/Cag241Ot+v5kPKXq8jCt2mox27KXX/tcGUfYCi8hnBlaitxlvjWE9S+3?=
 =?us-ascii?Q?qUM9EKmGyO8YrkxPqZHudh4srne77h8qhJPLZ02a7J2wqtbPFEdNQj18w+BL?=
 =?us-ascii?Q?UCiAKIVVvSC3L1IPYf2tT04kvHtrK3XEuRQAB1QmoL4WCPpijdTkUQSb38NK?=
 =?us-ascii?Q?8Dco6Mw3kaPkOp/lf5pQdhDHZoX1xBbaZVepLbSKj5Gay2PnSP+xgz7Ez92K?=
 =?us-ascii?Q?pg+gW+EQkhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYSHso7U/SELVoFrNp+Yv9ONbcZw2uU49Ka3j6Urmc1DmeD9XweyUKbVhCM+?=
 =?us-ascii?Q?9y2qUoPcac4dnV4MaajkJ2/NsGfGjqggx3yDMtMwfBeEcfPfukMc0jcXxf7d?=
 =?us-ascii?Q?a9SnP/thNJIDqf9ieWEXKji12GobAUJIgGsrWHYfgVD8axmTdq1R9sstMLGX?=
 =?us-ascii?Q?kbA7bUC5fD7z2S9PENnj0ebbdIH2Q18TV44wzwP4H4uRJxTKNZii2bojPNH9?=
 =?us-ascii?Q?6Nuf/h8ZHoLjDta8JuEzY9dDiWyGk4f5HhrgnSs4TK7AeWSAreB/U+Rh599P?=
 =?us-ascii?Q?hHFOxgp3ttZzTCAqAWjovJCf0Xrw/kzwo2jV5F5zT+ztpp0LQEMmOccZAKEA?=
 =?us-ascii?Q?Xh4SNwE7s0oOF15yErnOyMz6ltflQNSN29t6J+903cjPfecgivFHuemSDenr?=
 =?us-ascii?Q?k1RhvwdarBjyiIqY3gCqCddWRKoVNVhp/ZlnAW4zGW+ERHIH850AdvEHP4R8?=
 =?us-ascii?Q?3wRJOHaVVIQI0TcxK1GlESUaBca6WeoYKLIRRLJymCMXiy5Pb3o2gK4BXy2C?=
 =?us-ascii?Q?C5YU9/vc+Sk12QSwo7xGC0f6DfpkXtKi1DGpV0wzLNW7Oddm2wT6INY5RtWl?=
 =?us-ascii?Q?5WOwDYpdQCNNJ0UxpDKPTxszaigvIFkui+Wd5WGXRa3J/9jVAZGkXjIX9yXq?=
 =?us-ascii?Q?CrFS2S5SQ2I1u7n++iLJ4+dQDn6XtrBlNlDLVXgLK8kdoIiUq/uPlIgWRHIT?=
 =?us-ascii?Q?McN/T6rmnK2XzzUdeykSO1Yv6TandXxzKgK+qRi0YS0CzJWySEwqJdqNsGm+?=
 =?us-ascii?Q?D4cKkYKUwPRtE8W5vanbA2U6Ak5qHCSMsY5e8NPCPiYJJRhgyqVCgBco2Hvj?=
 =?us-ascii?Q?A+Qas5UR+ZzPT9tg2Xq4y4Qj0ZDPiYgD6+Sl78PBHUEzk0GfczvB0+CN2HAV?=
 =?us-ascii?Q?2NAsuHdeD+olQctxkN0/db9CwN5L35Wrs5PrmMNsOPTsrMEjh7rgTX0GiEet?=
 =?us-ascii?Q?3OZzyzy01J1BsQ5k14gyOmoGxucTQPhJPi60OjUn+OaBJdhE581+AZFLB8db?=
 =?us-ascii?Q?h9UOqCZVddBb7FeFHj5LvloKn+yWg+FF0KDQUDibp3tCISKf7pAlAHFVmgEs?=
 =?us-ascii?Q?Nx7nYTidvaNU/Za81eoLpSukpC13NmWdnis3ZUG8nTk8P0KfD8yIXAdBufkp?=
 =?us-ascii?Q?GsOu+afrWjpvoMX0AAbYHnVSuqHujVfU9jtlCpwrxxa7je4g4uIx6d+hsbSW?=
 =?us-ascii?Q?FwixTLHyHTVNhcPW0J5uRgXn3waUtO6nEbr9rnb7PIlk6XSv6izN+cnuujN7?=
 =?us-ascii?Q?qHZRYtkPzN/f3kosQMqlBfQW7K0G3YwBK1035fWCdpGMpoocj/mJwkgc/9nN?=
 =?us-ascii?Q?yZD59cdI70qSM4fN4Jqyv577TfiSrV1eiHccEwZfq11fCkEmOcgtjG3cQ+sO?=
 =?us-ascii?Q?qaAG7G40SXrRYZ43q4S+MY+JIBvfhgUtXTIWoJBcLwP5hxXfTVeosnekyla8?=
 =?us-ascii?Q?mSAlgndD0fWGw2tlPQRh08Qx3HJ2uhaW9mN1vzUEPQpCbhsQqekGrgnoGxPO?=
 =?us-ascii?Q?9gWLKB8OF0Pyu1xEOST/8LwiWMiO7u87MoTChZI97/h7kPXD9+amD0XRtiP9?=
 =?us-ascii?Q?6moCKzly5XjHt5rU0pcz0F1IYzdCcJM71MeFriXwhTL1kkNC9nZdU0omPLrg?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf50fe-dade-4170-179a-08ddf0d6acef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:58:17.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yottJBqWnPNlT+rVVtezhsBiQi1NRzltPtqTkZXSNyr6a7pg0HC9cvmCa9cJoRisUpSiz93mmq02VyE/u61f1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798

Add SPI bus width properties to correctly describe the hardware on the
following devices:
- Stratix10
- Agilex
- Agilex5
- N5X

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
changes in v2:
	- rewrite the commit message body to align with 80 characters.
	- add additional reviewer
---
Fong, Yan Kei (4):
  arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
  arm64: dts: socfpga: stratix10: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex5: Add 4-bit SPI bus width

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts    | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 2 ++
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 2 ++
 4 files changed, 8 insertions(+)

-- 
2.25.1


