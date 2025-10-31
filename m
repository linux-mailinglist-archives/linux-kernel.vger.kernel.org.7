Return-Path: <linux-kernel+bounces-879954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD70C24790
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B64ECCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD233FE13;
	Fri, 31 Oct 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Re8q711s"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5894336ECF;
	Fri, 31 Oct 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906819; cv=fail; b=QUBEvR3eNctRHiIENIkfkNYyMHXYUfoz9PWRwJR8pziuLnj09CVmMIvw3rz5AHA6G+ZvyHsYCn5IPHaAUnkcQ7W02h6kXyctqXeK/moDxsctYq1F9I4uZ+vPlqZ7JMJOMMpQzPwD37DHi0clMalCJeQP6DnIjcxNYozAZuxvccg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906819; c=relaxed/simple;
	bh=84DxLgmfAUO6LGUjU5a5KFVWnMBIpu25swCEqR1+5TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/Bwgn4XCwp7D+Y0yy67cf71jhK702uK2TQYmY8B1TNLKt1Auim/82T9vVe87SsBLGpvdGMuIir+JTYuqmahxZNUePIOMV2V0b6PhGHTUMG9PBH3MRNWkM0qOkMb2DLM37LiInT8JA7oRhp2VeZT5jYAYYXElavcF6UsOhI5Hog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Re8q711s; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCMlXcoidTAc+x6NHrG4dPHVIbsadlAT0zNBj1kBcHIdP2ZcC26qXlTWChu9b1KdXBSs5NdV0/etoP7KgL4mmcXHW6n0mPe92unj15tajgRvlWh5eD/4pDuyxGkiwcCErTZGdwVt8J2aLH3+19D2Uww2bb+0v/8hhWn3NC4QUDYezyFPRSoYRZ+aTla6mZV5gxNpzKZ4s2KGIaMckK40CGl0PR2eoYe5Q3+qMsA+qrlHvw0SWUfckbofOTL/ed/mlalJxMpYPVLvmiGNUEUeT74LJ1Lfou9MFT8UtpIBvSNL1QL/L4ClJK44Q0eX6UodM53HaammNlSy7JJ65+3APQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij1ul5HNehg8MGfFp4ClSlVQRvdvohplx4uUOesVo48=;
 b=VscfBHYxXvzM928XYYID1L9t/O3ZYGfqAFQmJoGDPmZrFGYy6499Y3mzJThNzPhgJfI8zjp013LEbusTT75nt3WU5JwsOwIAMMrVSTHVbkWXoIzNEOziZipuE230co+aEABEJUiQkojSqFO3JNnok2t3oZT2R8M+gVZ7mo1lYlQgoOImK+JUjmMPxNbVbeMA4MYmIl4B7TrP+2vxs1Xo7pOI6QrvyQzufpJTiobm+oWqLRcso7yZUF5lKUfPoyfKSFGlO2hqk5/AvmWQPRKOOcI2wVvF+/g4Hza4c98XJqgSfyxRX6/zyQOvZ0BTz83ndgQPOGFJqAs8nsfeIscuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij1ul5HNehg8MGfFp4ClSlVQRvdvohplx4uUOesVo48=;
 b=Re8q711sEnqJotYqSgVltVc0k/FpqrMdp6iWEX+IcMU6eLOORCsDueD30IvnbcyG5WzeREhgrPZAFo8P8MFtLBn8bqj214GHnptZOOM7P4osCtoipWcfriVp2yrkamqxFWF5fDncVMFxSGuBnjxn5X7iWGA7UN8xIWHVA/ljIC641V08OhcNZdu9Eb9tUJPoPdfdCvLlzgiAaO5fcpHd5WLacEYfwEWAlRggxm+OUobDZV4ZSprXFITwNhtBx/3oFnVkex9HqxHTtp+W2sUoNAg/WlRWXz5qWU7Y7IjgcBsat43yUvwTw5BwafD2uQzkWv2Pgl6BoMTuHyyKRXOxfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:33:36 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 10:33:36 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 1/2] dt-bindings: intel: Add Agilex5 SoCFPGA 013b board
Date: Fri, 31 Oct 2025 18:31:16 +0800
Message-Id: <20251031103117.910187-2-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::16) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CH8PR03MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8b4e45-5def-4999-8453-08de1868f264
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AnX5K0kf26OUUg2IVJDk7vqtHpXeRi8aJpblqz/zU+FWPWbmRkD2kXISUW7u?=
 =?us-ascii?Q?jFKjvTkBll2JYaptdJOdxA/3DHX8E1UpDZzZbkW32A69YdPOKs5PzorFecz8?=
 =?us-ascii?Q?5AeNEIJOfAgnXm4yYoxA9VUxCAK86OcvQa5tRgZ6G4o/pLK//QYq+bBxYTZB?=
 =?us-ascii?Q?ml5qS4nRI8dz7z/7TQvyXw/kjsbj6i7wcKl5EfzBcOw+xmrv6yE/NO0V5oDa?=
 =?us-ascii?Q?2WkJrF/nZsXKcNzDWtz0w14i2dUC/yTDjZJu6l00HaWcOs3bb/4Ksugx9lPq?=
 =?us-ascii?Q?JIzngbzscQRCpq9Per7MBB5MbXFrstElxUjFfAZ0yPZ++pDb0wFiCatO4rQx?=
 =?us-ascii?Q?y78Dn24/DMsdv60w7E8FSx2erhgjT2HwKwcN4n84Ur3tZCxP7CjSX0Qisucx?=
 =?us-ascii?Q?6PyoB26dJLae/p/nj7kjuNfqcauW7wwtFAnTDsKglZQUCgwwYRhfDfytyrzC?=
 =?us-ascii?Q?5kgyEKzaLN4KSgYoAkXouoXMmibn0VMNns4eIeLYJFmAIki6GuvL+j4XHAWp?=
 =?us-ascii?Q?3C/KzqldCl5NJuvCWjq230muSI9QODaSSU7vzGkbvH7mgGBArtSZ82DLFE+k?=
 =?us-ascii?Q?/xl5bgpPip57oAtenEBfaTd2uo2qprCU97LUVN7479P38oIrZp9mvTDULYR5?=
 =?us-ascii?Q?PkCiM0/FB3bWNbGQrL0ncMBY95D/KZO0uklBlZ5WPIZlaKAQhValN4blgmJD?=
 =?us-ascii?Q?5ZV7vBmjmT5z7Hi2k9gLvkGkTD4qsLFISR2/tz+SKrwiZ7gjdcoruZ8OwR9/?=
 =?us-ascii?Q?x51QllZMv5O22TWMvl3tsLOleCPaXqewPz3tR3hUq7c2zo1mHhLI1Wi5ni9w?=
 =?us-ascii?Q?cdbEP4kN3GctcC/s/b3vpNozhHHiSpVSJjqTzf005AGVbdG1vTg5n7oI4lca?=
 =?us-ascii?Q?QWKhba+urkLdOjI/8H9rMJcOJhQb9Ml2eUVUwi3Fsb8kRe7fTWbRnSLY3Ugk?=
 =?us-ascii?Q?ANEwys15aJtWm0llNM3gs7ceTngT9oYN8AiQGAihQEdbhCZHb2VFyb48bEIr?=
 =?us-ascii?Q?gJiQqE1yN/V1A7b338oG7kQddURPpYKVFwrcwpx41p0rIVl54JEcv0m8Ss6X?=
 =?us-ascii?Q?Pv+cW1AfVtZsyGkeds/UCf7L89F3cnYNC+X+FBPwINqkTJMx6/S38e13ysjq?=
 =?us-ascii?Q?wgCfkeRMyVm2gBfghTUJrLjApF4DxLcrJ52SQT69mdFgqH5dinhrjKS48Mxy?=
 =?us-ascii?Q?0Uo17KGevE3hLiMntnxqsRqIA61WwWuC61z2QxhOo49L6JOEvUNz5hKH4Yxq?=
 =?us-ascii?Q?f3irvAzR+fpJMUFoUBb8WtOBHBKNxbd7WlnWmEESfQTqVM9P/BVfBHUE0oTR?=
 =?us-ascii?Q?/TCQE0CmrvycjLNn4avaQckQTOmxMdZLG86tTKbGjJ7XE+VDPgYdu4URYoP0?=
 =?us-ascii?Q?5jGbLCv/IpiR5c54v3ngK6LnTfDS27OCLEGRaQkMwnMkyzaIeXSCVhJpIKoV?=
 =?us-ascii?Q?vLZlhFsVle8aUae03PaWAHjLPzJjTeN8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IA4uk/6VjxWc5XrWnbxfZyojmxAD1UZl5FIXxG2etj5gwWeQVc2+Tt4iOQrd?=
 =?us-ascii?Q?WDYf5Ue16aHe94t038k3KigeVoQnOALsHsXNjhlpZ90G+2s6AfDEbLducEOp?=
 =?us-ascii?Q?xlVXqMETW43j/FbPzPrZuu5R8pDTZJvx+B4CoVDj9fXGB/6/5Fawyg64SpK8?=
 =?us-ascii?Q?MnxYNdCi4MHpuXKGnrfZ5NiLpaTzZhlnIE/i0zlwiiqUbtjfA1xzyn4GOZHH?=
 =?us-ascii?Q?UCbiGUaa783+DUXu2PGhHH2l8bfaAGunrtMJm80XwK9jv1yhuAlvdFufzvYn?=
 =?us-ascii?Q?4pPIVMB90vyksau9tFo6xcbXEYoQZ/rkltvCqxDNHFrXyavKgLyB0QS6A8Jh?=
 =?us-ascii?Q?J5U4KvGg0gWU5t8dEKpHzTrCVstMPvOhrrEYCasIhkXPpwFTQBMqizF++4Xg?=
 =?us-ascii?Q?hygaE4rEcY/tv8TpnCGgjx7bxOwtX/N5WuMzYBFAchsfr1D8LHHjykcCysw8?=
 =?us-ascii?Q?QAgjJBqzMapYi0nAJP/vZzUiznp0sM1KILeDDc7OBOObxnq0bCZ7SgLElIiW?=
 =?us-ascii?Q?XC2hJVatgVit0OZj8LSB9icTrIGU1snnVvw40Y85J4xpDu/AuCI8qRH9EcBJ?=
 =?us-ascii?Q?YQa1LHbN9Kl2WBJ3Xu9lFSftuRqaUsisMqom5KuZ6SkEMBrYyc3LS6WF1NOc?=
 =?us-ascii?Q?5RrpTQiXWmb+oCQHCqeoDfO+8zaK33ooURSctQ+s70VgFw2Cn3r1j7RW4NuM?=
 =?us-ascii?Q?q8dMJfDVkr1S1uIWcF6Zkpp+7RQfYc+gfMDNyV6g0mJhZIuAYBwbu+98LSS4?=
 =?us-ascii?Q?U5RSlLoFB9YZY5BZYNn9aTjEtnhtHPkTnAHBI00cKUcO46n133qhPx+Xviyx?=
 =?us-ascii?Q?VGZg4P9tQwReshHQ+bg83oQK0nt2K0OKOoGZOLZi2WgnTh7uNCtkU//nEKP1?=
 =?us-ascii?Q?tnZl5uPy7SmElyPzlRrMKxb0EKOh5qZuTQKHGIVsvcbB1e/xfJfE5qErr3Lr?=
 =?us-ascii?Q?M/5u1VpX6NNgUzLRGzyoELvWWy4atKwJVoXH0mCE65gItOTkkYM3J0D0Bqn5?=
 =?us-ascii?Q?ZrKEtYIBCGcP6IhUgqxBYbsnyYnpRX9dR8pzoWTQUclX0lYoA594klA6ll+1?=
 =?us-ascii?Q?tQDd9mV21MOJoYhwY5IE2NkXfYczr5TX+QiazK4t4WoFxOKWcozAYmrw+xR9?=
 =?us-ascii?Q?OQV7d9sLNIzBJsXxzClI+GssRyPVSLhyCUjc073FoP3FSRx3+A2BLSNLYMGk?=
 =?us-ascii?Q?NH0CHvx0LcD5YAOaNGAoh9n3N4yWiQ+tfybpcMgqajYJWrqINYtNUcAaKuSL?=
 =?us-ascii?Q?Y/pS+aMPD8qdJahPK5j3MwZUVSeWVyIumw+wsJ2aekLb40in/EbA2fL3MLMR?=
 =?us-ascii?Q?egOK3mE7vvkJdYWtqLqeBRNK+r9nAAfCr+/WVHwmpHj3xiWEpUCF6KevS5Mb?=
 =?us-ascii?Q?6QsAryOOjGYMZduxD509PU88SfXrNynfJijLG0TgpJT0yaL+UhLEPCtjSdKW?=
 =?us-ascii?Q?9W/mBRTBUcTRrTQKiAeJi1Lkef8Tm37aqiHMJA7wkPzFGCkwSfW/vPC921fy?=
 =?us-ascii?Q?KeDDPzvS1OneD4BARKSWhXflruPzzn6Wkc1chbV/Z3vD0EdjmpLPkSwegDLT?=
 =?us-ascii?Q?pCHpEYjcX1ldhCziTevmefUPl23WydtSjPeBFoEtDkCDT74mT2seSxRrgPL4?=
 =?us-ascii?Q?AL60mKXwoGwmSUUH57p/tYhQBkIOhh2Xs5Z/b0TmsXED?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b4e45-5def-4999-8453-08de1868f264
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:33:35.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQYYWHKaYVNANQs1jsAh4KxKn9j39o7UgwGpZWmVqenFJlO4RMg5bldwlHY2RilYC4Ke8Gr7YsMOYsECslqB6oYJlIcldBMI5BclrUx0wrArNISFY9BUkgZYVu/EowkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8275

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add compatible for Agilex5 SoCFPGA 013b board.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index c75cd7d29f1a..cf7a91dfec8a 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -25,6 +25,7 @@ properties:
         items:
           - enum:
               - intel,socfpga-agilex5-socdk
+              - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
 
-- 
2.25.1


