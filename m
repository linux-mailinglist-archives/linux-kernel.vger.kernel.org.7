Return-Path: <linux-kernel+bounces-849131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC305BCF44B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B7E14E8B83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C1265614;
	Sat, 11 Oct 2025 11:21:53 +0000 (UTC)
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020137.outbound.protection.outlook.com [52.101.171.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A31170A37;
	Sat, 11 Oct 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181713; cv=fail; b=Psr3M0GLhuwUDNlrFnLIGsAllHbEIZs6Mt+9tRspVTQF9qn/qMmJrNLUUq97uG0xu2aM1mXiHuQQAu443ZWd1XVOqcKi9/st6LiYjRaerzkS1xnEOgAYLj5LFdNOmEHHuAC5d18lUBpQO9bNz9rKu98mdqOQb/8jTpuw+eXDJKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181713; c=relaxed/simple;
	bh=HkDkgzvj0qmlb6hNYrJZJXLuMfq/IENzZiCeY4y8zV0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eRxJEqRFyatyPWBmAI0IbbNVvILkq/qdh9X5sqkBDGc0yFhUUhi0W0xtsGSUnVUFFPu2sSOpoaMhEnOAX6987Bvns8QXUYbxWwS39Ss0WacZWgTEdg8S0YDaviaScjkiYWHvQhrzEzaK5mYNdAQAlCx+cYP6J6vfGAIIJG5vFNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass smtp.mailfrom=siewert.io; arc=fail smtp.client-ip=52.101.171.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siewert.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puLGOj/kt6I0IrnUvlQAFLTMjXnLozMWe8QSBZ9JbXUYFFZHp1u08AX+YklDxVQMObpKGsynag7vZCv6H3XpAOAe27H1tj7366kD0IbBvolpFBjdGx22q0khVCKjjSpbVgo1WB8niLvk4bDRkIISz4UNSLIll6SvKL9yS59MQsgYfGAPYg5Gzo7kOarRKLq9np0vC4tucWUgGr1xiaqbVgrp6vN4DcfL8tDFmoCH4Ult2PZZmWtU2WEqBo6in7csAKb+Z13mZt+LH+Nd2qu3ZktzBh77xBQOJD0OeW+dhqXUPDDo32fp271qPB9/gLJ89kofUWeIsv1alu8AKQfZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReglBI6t1Xrv/9KYPS7rgLPkTzEi7OiLREObbmNjx3c=;
 b=ErUfSw/RjVj0Wmt3Zfj7nQyK6oo+TYnKWbfBta3vK9okYe+jjIiMlyrHjbKJ9qOznVqcEI63q+UPoXmdTBzGNniZ0WeXsq+QTBqO8DQg+00eS4+dv9OaLasY0x7uEjEj6FT6Aw0HmJtY/cGPdQyWBfl8oo2Hv/Ci798IuhTD2Q8oF56FcJQo1DYAM1UqboyRCieOzWhemwVY7/bjK1kj9JLcJvYYHZXOI17/9Ihckl2VqCb5PmB1d8Jv0wJqhPqiiRK9PUEZhvwN4etOqdY9dbt+Dukeu1nOPrqzgAszu5L11fvtVUPWFcJgGGBZD5OXaB6jsxZV72NgiyKd5Gl7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR5P281MB5421.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 11:21:45 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9%8]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:21:45 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	Zev Weiss <zev@bewilderbeest.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC support
Date: Sat, 11 Oct 2025 13:21:18 +0200
Message-ID: <20251011112124.17588-1-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR5P281MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 069691cb-ca76-4832-54dd-08de08b85c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZXmJa8pFt47cFtEPcdAHRHmEgz+7I5OqqS9qNZoG+FRI6ic9bWHgetZuyZAb?=
 =?us-ascii?Q?/y4FDe0S8Q0muH85tdpnAnu8ml4UAnKXnRGlWRjkN8j2Gv1GWlGfnbv4g3dt?=
 =?us-ascii?Q?9pZhopriOyQUYV90vnkkL2+NYg96TQ6cIalXBurGXBn0W6XdF/vkzaNG1auN?=
 =?us-ascii?Q?qlwVfrG8Yk0xetJLv8gra1lLKQCs6nVCGRpx4Dwhj6LRj9+jQhEjB55alPXt?=
 =?us-ascii?Q?UmRe5VMo2I790OQEnHiu9p8OdtPzCJoSDJ27Fg9CZBgeZuK598FTUEzplAVR?=
 =?us-ascii?Q?McBtDwRmiARLIXkMk46VRI030eLkTHjZ/E2M8o7mL42ewalqBS/fbrhrCa89?=
 =?us-ascii?Q?yj7+On0tyxxwAGsu2scX20rZRtJyJXer4nnuwy28ACPpyctQsMqUwREpROVZ?=
 =?us-ascii?Q?uk0stlXpuuQ47hNik8AOd5HQfSQudMfJwOpGT2dvmhIJfrWTvoezNpOgy9kR?=
 =?us-ascii?Q?ZPBgCi3jyVSfUQatuEidogEOPl356bNX9dsIjR75rxAJbpASPdM/p9IOZ8Ss?=
 =?us-ascii?Q?ZTAhf6vC6jASQrtasUJgxsDZT8JC4dNAsyBlqe0jLqsvH8y6bhUG+AM2pZ/Y?=
 =?us-ascii?Q?GEZhOlnfdSptvFBRxC7O4EYA6wlIJn6f1Srw6JywGXEwR+vMsXvUqbb0sVyw?=
 =?us-ascii?Q?Z1H6YMWeWzSMRTLZ6S1OsfPYjDMcVjnjvt0bMlDrjheGbgw5R9ZzUR0xqDpi?=
 =?us-ascii?Q?PLM9PEO12wf2HSMUZUbLbd7TvVKH9zc+hv3tXORuk/5B/kfh33xK/RQ5uenZ?=
 =?us-ascii?Q?tMVU1sARSS9ZlrU/S1ocpyHmW42YrJAJyUSjUfWzuXZidPIXJAL8f6nxR/FR?=
 =?us-ascii?Q?1vQYWFOiDx0gTfpikfleWzEmfqd9d6xF/jRhg3q+VslIG2WeVvvmzeqSRVaw?=
 =?us-ascii?Q?pRqReMALPkFhvVwVbyGnh7DV8FPnMhb3lL0XDPH67gz7azApZjxAGCwdwlo2?=
 =?us-ascii?Q?g8kR8h4ghFD1JMXpa3kcM3/SFVTKRKENdARS3zHWOW7/QLYq+Z7pl2uOdUFO?=
 =?us-ascii?Q?LY56WgBN+cf/ycKNFyzsQgQc6XkoEMJctI5ADF/PknD4XD7dAQTfy4+v629a?=
 =?us-ascii?Q?TkOf3euFNVP1vNQ7zlGPeVIbHNviKqaSWvMbqcZcabC0rikfwpxyg9qt9Kqf?=
 =?us-ascii?Q?yjM4kP5LVYIzfvEncJVjamF/UMreTZ82wIhH9ucskJzuDb9JZcvPMU/aMdoK?=
 =?us-ascii?Q?Y+ryJpnC2ZwloZcqUUHNbZdd4SPlAevRfFIFxLOEarDDsIeyfNewxA3nEl1e?=
 =?us-ascii?Q?NRm1hOmaYQ+P2CLWqcOSzoZoFqHABlX5OxXcMcdGgXjYfipqSsTE4zd4qNce?=
 =?us-ascii?Q?BPV1hYxc0ROmcH1j+l+qJAAA1twFyH26fpvE0QJ2+6nyMJ/mqsOIEg3I/jRR?=
 =?us-ascii?Q?oFUsEr+TP0YljX2ssitSyfwrNevVEHWKfv+4Pg8W27mZW1XuEp9+3HHdKZFv?=
 =?us-ascii?Q?gWEn7rSRcXd0aEQvlhoUxPrcmtI2K5mH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HAQNmJottrxlP8yvERZ5s/0vIW+HCppBqqBr4x8BjhWbOf1hEzyoGIYJ1Vk9?=
 =?us-ascii?Q?FQ+m6ucQ9eySOwF6zmwYXT6KhqBMnwnVwWuP3X8X5k6NYgdZxKfKJdbyfcdE?=
 =?us-ascii?Q?NEYUUGxU0AssftjLTQ4AiEkwoidUIiKDOTc+rOcSCcQ1DMrOOj/1VPYJK1v7?=
 =?us-ascii?Q?qF9d7iyPWqm/2lNOBBU2T15pDf9pG+PITsgXPFkqPAjcYuvDsU8hekms7ca7?=
 =?us-ascii?Q?JmTKNYAiXnkKhhql8gTdGQ5iovjMy5tnZCMRH9w57ktHi8HK/GtLejevwM7D?=
 =?us-ascii?Q?85FNhtQAqTgh/y0Ns+8mlbETH/vET2iShGpkzlnjCZCQGg2nPoWy96DwfC+o?=
 =?us-ascii?Q?GOh5LzpsiTjqadrQxrhmrZtYUW10FXPcAbDmBF1CgYFIugCvibxB4ikMiJ0f?=
 =?us-ascii?Q?erovzv9Hh4GczvdmW5+CPDrD6KHVtvbaY3QpAGHB1Nq5E+BVkHd3Latx7prL?=
 =?us-ascii?Q?/GYrhQ9s0Ew8pWvJTTiGA1l7RPVu1d2CSAq8rzx/n0/XtURStFDyNogBpG/z?=
 =?us-ascii?Q?OvnCX6k6T74Np3xSKWsgyuWMK0oPFJQvZ1grl9b4nqusp+vOEgz2g9kvhD6L?=
 =?us-ascii?Q?LkIOYhq7DfA/eGs6taNuWxfIWkSqD4PcXS2hvSsOwG4RxzkAhIOw13krVN6H?=
 =?us-ascii?Q?08ALyBf45YINdjtcLIZCXMEV86gmTI/tkzA3Ww41rKKCL1nZ9tbrghjN4gzz?=
 =?us-ascii?Q?aAPgjcYSKKiqT+raQnYDLoGziIwKEH4onF17rXjbVrZgUpuMVAy0IovzAxct?=
 =?us-ascii?Q?HT3//LeHk+5fAqQItm78D8/H2Re15Znv5eGYqaRuUgx+8U+nITCNyozbugUp?=
 =?us-ascii?Q?arlEhmWREtGTeGhDn9Pvp/2p7Q5A3xNeRNL9IfF0yNdK6CgAj9ZdUZh6VSLv?=
 =?us-ascii?Q?bM19mVKSKZAhTQN5ORI6Zxq4Kp22giU4vG2x5xphfFX4FRzcGe6JtAQ0tzVA?=
 =?us-ascii?Q?mkE7xdcVz6miLVtywu05hJzsmxbX5sjWbGkUCEtpOnRy2eiBW/Xg05u3Sfuc?=
 =?us-ascii?Q?sT+cp/5ue7h2xyJ4TlN8IV+wx6ajJ6MkjUuj8P9s+cPGgRi9LKjucdDJYWpF?=
 =?us-ascii?Q?iXuj6GViBC4xyySbkSnjYZkwRytELhxBKD2pHco1qQQhzOe0CqQUE8yKzD3e?=
 =?us-ascii?Q?tRZFWQkv4oKCWauNemezvb6INwQseTT5g2QhCReLkk88Mr3/sbX5bcXkeXMF?=
 =?us-ascii?Q?nhVxAWV8FEkwqV9SrCc3n9pVqLmljX+5okkqJAVp/LJh0R1jWfRnTCubX648?=
 =?us-ascii?Q?HsjWVsFgDcfEsc3EqZ/T8gR37YjoNxHhUyDD3A1UPVrQBIEItdDccHKndqcT?=
 =?us-ascii?Q?BVUm/aiTuV5Ddf279dq+EzAQMuCjp+9gdNvOPNTclIUZtn6JCK6HM7X4E+fl?=
 =?us-ascii?Q?lhGmFKS1SeH9316G3lszZ+26uqmTPwStfc7dfChhCKa/8nVvzUfSe+ECribs?=
 =?us-ascii?Q?vDD/MAoYMhjK6XaxRoOSxP2t6/vvEZUiO8vataS8uInCHqeV8gyT7lNz56br?=
 =?us-ascii?Q?UDpHWgpCIzsRs6snrFGF09cROkC7u/6CPUvXgJ6gjWEe0KrzI3M+I26X54sj?=
 =?us-ascii?Q?PkQJgC46JXQkpPWf9CR8W19Y/4gXG7ty8uv1SJa9Q0kyMFwDBCqGhizilqhb?=
 =?us-ascii?Q?t9e0aKzPUs1++vkSeb8MNvA=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 069691cb-ca76-4832-54dd-08de08b85c2d
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:21:44.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r7cCmTr6LC6o5dRya2U5xguN1MGKwXvL1IiCeuhe4Qi16Jtz5fy+1vFSmBsQkWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5421

Hi,

This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
which uses an ASPEED AST2500.

The mainboard exists in three known flavors, the "normal" X470D4U, the
X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
BMC SPI by default, but they are all swappable.

All flavors will use the 32MB flash layout which should prevent unnecessary
complexity of the device tree.

Please note that this board has been fully reverse-engineered.

Thanks,
Tan

v2:
  - fix led node names [robh]
  - fix missing gfx memory region and other fixable dtbs_check issues [Tan]

Tan Siewert (2):
  dt-bindings: arm: aspeed: add ASRock X470D4U BMC
  ARM: dts: aspeed: add asrock x470d4u bmc

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 350 ++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts

-- 
2.50.1


