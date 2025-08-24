Return-Path: <linux-kernel+bounces-783755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C30B33201
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6718856E0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569C21FF30;
	Sun, 24 Aug 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="VeURKhNi"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022078.outbound.protection.outlook.com [52.101.66.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0311A08AF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059544; cv=fail; b=kJqsW9qwjAJtzZSwBXxG2ocl0E2mCaJ1B//qc1FBMeDWISxhSXi9yVBc2PY/C9MHMZxmQPYydXX41uNzHkpu5v2XtmUkzIX0rOBQZRO6yq+hQ7w4dWnVUxzTrPQzuYTnG0tinaz9zjOHwQmdVPAfs3KAFRrrqlMy5GzEspYPSxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059544; c=relaxed/simple;
	bh=Wij4zSgejVDjpzI++dbOC18zqQnc+y41IFdWpW+K4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwX6lrdVzxubuZSGFk6H3KwJ71fLf8RaTkltyRBJvP1KoxjB2LXRwlHW/vfsV5+lZtxHtHfj0IQUskZN5inzl0eugGAC6XuZ8Gpr06hzpynhEd3P94UQgkWNEiVFefvYWWEh5GpVsBTvydkeNn9anQjOAsl63dQmHsNlXb8M8Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=VeURKhNi; arc=fail smtp.client-ip=52.101.66.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfU+el0Y8RZwThgbOLXtdeb0VKjLngFSzGtREteEQlmKururhwSnW6YJl8kgJSHoTiVvZpKcAM8vlo02IvD8EygqCodmm6CYTJtUoUT/wGNHKaVBxgtbLto+We2DJkOcv0zK6tqosvwfpGqXGDvskBDeXBpzwGT0t7S7UKWS7dzTwEZoR8xzk0J6UM4QGR+3c5a+0df4RDOEQQLEYIObOHu8fYgvHweMob00K0pZqzqaJ1xf9kOob59olJyvBlF65EiZTUSVCltJesev6O5zlYNN1jGcClooWAiGQf8wrGHEdcxNOBCfY1lgfox+IzxMmDDH+HLlFi6XOiwC9KZcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnRNLT3alan4vw5AJNHLBKDFk6JCmdf7FdVd/NAaEns=;
 b=NX2p28OfTELhc4mlpTTp5G5C6LNtxLg5fv6g4AYf1ZbI5p2npcFFUky8vemAP6ZHu0xRVzdPlhJenPGJHgb3Fo6s8LCkk2qdXEHkaul09RPJCE3Kx7ccn21qTNx16O/iwlJNXYiMI9WekLiRX20yfUqcI5wyWTiR58pBESE1kMpP1aHx7m+Z0HRzjaXYwYnOov8DR5c/V4cd1JeRs4/pf3x3xgZoC5r7XqCzExFoMqoKX0fLCGi8/EUMU5eqQjcdJpT0CwffXlCxBSgsAteHJ4c/AYsCWLkxBY38wbluuOxgG0MuSJMWnGy/dq7tNl744YljJt8V/y3mJ9mPpdLc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnRNLT3alan4vw5AJNHLBKDFk6JCmdf7FdVd/NAaEns=;
 b=VeURKhNivON1+5QvBiC6V3AY8FRndof0dwt5C3RaDHXF1oS7rVOUGcJ4vuSG6CYstL8iT4I2MH//R/vQDBiO5Gk5zwmOSRvVby56bhB0c3thlGjkDMN0V0nRev5XF/bxU5W4IJJyWp/+eEm6QTnRQBerGysjdxr1vssMdbftpTqPjKSt0aRc4BtrnBSFw1fkiBzPDxQSJapF4RhjdqbP5hQzkCBHoOx2qKMUOrjCLOe9JV37cdpmXMtfRXfk94yOftIcmn52LCK2aBvmBp1xBeta8YYZtjAolfcgijzneqlqOYmp93d5B2FA0Xvqq90eWHfcqoCph4NcTaMGFqFLsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5810.eurprd08.prod.outlook.com (2603:10a6:20b:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 18:18:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 18:18:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 0/3] mtd: spinand: fix continuous reading mode support
Date: Sun, 24 Aug 2025 21:18:47 +0300
Message-ID: <20250824181850.3994184-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: b279ac39-d7ab-448c-e26c-08dde33ab142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1vit7TjZ+NCbX1KEfyBrcUXcj16qVZ3vXPcQbvmQ+QvFi+ThDoy2qRLj64F?=
 =?us-ascii?Q?zqZi6SSwdDyQAnVsgJJIMs9O6KDKT37GXSHiBScnopfOtFD14vFb9MyA3YsT?=
 =?us-ascii?Q?MhWLgZKoMJm7Eo2A7B2yuvrn5Z8J0NSqORkmaT4/hlbhTSss2yEF9cX/HaYL?=
 =?us-ascii?Q?MT4ZhL74VO5UTD7rW8w7JSPNUSh2XikX5oDBOYr+tfWWTzIQkFo5Laz+FiV/?=
 =?us-ascii?Q?6K/LjU9DrDHbn3eYtA3C6gKmnT2mOSweWyulydd0cFh69o8EYABGOGWnfDqO?=
 =?us-ascii?Q?Yipl0rnOeQ+pd4lv280ZbkIrzfT3US/cewhBPphF4F4FwV0HnD/2ltz+fAux?=
 =?us-ascii?Q?AM2AtaaiQRqxTHMShsPszDSRuKVc70VxndwKYUEYjGll04JL/eAXAIB/jHFt?=
 =?us-ascii?Q?V32QBjFp7U2dqweWehdoOpWN4FqvSpd1PpaAk+NUss1wA+yqcMd2O10RGB1e?=
 =?us-ascii?Q?h/Flmw1hiSuFCi0y8Pm3EbaaT3ST9a2Yr1Egt5J3c7Y+kB+r5Ui6iSONVJN1?=
 =?us-ascii?Q?N3qdc4nvRHs7pzrBpOz2Q4JJ9kD8OqVoJ1otyHNeTHT/+wrQQ0/PZh1lAlSu?=
 =?us-ascii?Q?AwSfqXLEM9uLqZucG93bGh8NS0OraOHdE83+w2b8628HdgYKFRjrpYesiWnp?=
 =?us-ascii?Q?GEs8D/DsJFEBf767STljB1O3C624VZGrjamUEQ9FfS4DVdDlXGpAsBZj4Ith?=
 =?us-ascii?Q?ss9/vvwpx1KfIE1CNGUUc5qHPkl91RtdN3HMkAbGP3vG13fsjBbbjdtmz//L?=
 =?us-ascii?Q?uhv5y+7Wch2Qlbrgfmis0hoqAr+tAFzz3spiCxhfRIahzcZ1lscNkQjNfIkF?=
 =?us-ascii?Q?bec2XUXqaHjAkSUjJhZgwT+oy/vSyBuHjzFZ2LvQO256/FWPXLbpSDPUPAoW?=
 =?us-ascii?Q?qI5G8hu0JJFfEP2kksJIUhbH81xEHcwq3xXveQ0TufQpyvLIVsUuBM7BtNJp?=
 =?us-ascii?Q?neup1B8hK2Wl+TnscnBAHZOqw9sx3pwXd6WueSyuxm52cn8U9lfbiyDAAXO6?=
 =?us-ascii?Q?I9a1DaAk0xoqKsFXJUmEQX2QC1Fro7Klvow06FGSf6PTs3If48beoVRlU44q?=
 =?us-ascii?Q?hfwGC3heb4wjewqFQF9CgTMSwTjn5sl2rJioef8h20MTgkBhUFekdDzMxj3l?=
 =?us-ascii?Q?SzYVGP/eqK+NFH2JzBSMGxxSYsDfKWLmFE2+NCnHeUvvDePf2MlbcYAnu+RA?=
 =?us-ascii?Q?Gm3aAcQX9yohcb25Zfn8/dyK/3qIAqJ+c+a6tSAfMfzCTyx/noJ4youDm5OO?=
 =?us-ascii?Q?UQC/intFjtpqcbtQJoPKUMQ84XfObhjiI1ya2fzOjH20xtouax/r8wWk62hu?=
 =?us-ascii?Q?ZC5kWEgbkt8QUs7p16gpkVXGDcDmGBz6lQxzGalOC7+r1EWZ7KoM4SR61CPH?=
 =?us-ascii?Q?wbxf9uuQQ7iCmtdon0F7guFbbCU8rfpk8Ik0F3vs7qBWgHBA0tgRU7aL0Alm?=
 =?us-ascii?Q?4yeaZd7podlwHH7IIqhTq6RLfW9JUwuabFUTvchlXM/T7oWTA2FkVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q+TppAPCOfmJXouI8suVkPGKIa4lIRQozycrR9QE51f71gV+bvNx5bzm8CZ?=
 =?us-ascii?Q?TIWc6fqGfUT9FFkn6SsY8D22XeP8/VO844XJTUPaUeQyKXJCoskvzYXbeMoH?=
 =?us-ascii?Q?2frueCL7z9SlkoxiPTUE0Dz1r5RLhbCe1qz66FhjeLJxenAGA5icow8jaRRx?=
 =?us-ascii?Q?J/VEzVblVKi0UT3wwWrzvDq/H71Pt8TRLRTH+WL9jvObeJc5m7ZsOgMsRagk?=
 =?us-ascii?Q?KvPxtJIbpC/whiV63YqieKftgn9WWnNz1j3IGt+5mKJh48SNvFBKNbpnFKuS?=
 =?us-ascii?Q?6cHfxipaF0afguanK1UCgNx6y7iPGAiAwvHxkM1dWG8iEBSf9glnjUNJ7QVt?=
 =?us-ascii?Q?WyFsBjRX+2l8NShwYQgAYNYDF/k3bJQrBW/Q75oic2CjYuAExSddX5r3zXw+?=
 =?us-ascii?Q?aZOmRQPaYUOrL5BdgXj/hJ9hfpbvHgydy0+uJ8nVcPkX+rasaE08tzW0aAF5?=
 =?us-ascii?Q?lOPZF7YJK7dCt3HYI80PuQ/TswlIk6Q79VJrFPxa9weeufkXAa0g7QenvVun?=
 =?us-ascii?Q?A21cdJuiCRbYthF/0ZSzfz0y9vef31yGoUReV2GDO1/39WBqYVBkF01TK9do?=
 =?us-ascii?Q?wv4wN0hG9Z72sg4C5Xff4+STuJdgVzIYY8Z1dlZcanKGY1STh715ox/gG2x/?=
 =?us-ascii?Q?hdfpGVV9GaB9BK1gc7Ebs0KZXMVj3lnJZmir/QxzPeVeG6FXYgF1iYEMreK8?=
 =?us-ascii?Q?nWDrl2ZOk3Ax7TTkdz++bOqZIXxYHZiAqojIsy/4ddL4hbbzaVQeFYXw2+jg?=
 =?us-ascii?Q?vmd2XhSYPpCCJnCXrqLerYy2aHwAYtTkhhDLm9uPT1+oM3rrK5kGnFYhA7IW?=
 =?us-ascii?Q?eaDFd8uB+7276ZppO0jXs09A9oTZ+mfVt8jGXpizyue4X6RP33QUPZKsR71c?=
 =?us-ascii?Q?SYAlz+utSk73Xe0fPqsciOLTWjcVDCfmuhoVRolPLfLMQaHruO1tUNxsqT51?=
 =?us-ascii?Q?/HaLi9Rz3iUmxiaSxIIGpQO6gaJM2U+pRfiFIkkj/TpszFdtrC9UCaC2wMML?=
 =?us-ascii?Q?lcKTRwRKUeA5Jsr22TUNxKc2VyTCmoeudOGlWSFzIW8kTsK9zLo6N83ihFtC?=
 =?us-ascii?Q?cUJ1tFgZURHwqNnGAskvbLogMhONHfeMrZxJu+fKKX6k4qY0F9l+bUPazr4i?=
 =?us-ascii?Q?O2E1WoISEMX3gVbD7/NXuFO07vqgewXpMyT3/8KYT4d0hEo43yx/pVBYQwaE?=
 =?us-ascii?Q?O32FscMiw0gXRNS08HmR1gzcTSaMSXaiaaWk9pKkZ0recWixPqT4HZ0yqwOJ?=
 =?us-ascii?Q?6aGWr+XHLM8pTLvGzUnfH9JmK4BkXye8PrjFH4wQ4QQeclzOC4mIywsBTD6B?=
 =?us-ascii?Q?eB+az1cg2TWONcxw7TaVS7rNqK6+GuyamU/mbqy+RxcEtN/ItS/9o4xKRyBS?=
 =?us-ascii?Q?5XfBOSYctRATLvRVkV7hdi2V0CFQLp5RvDro8DrnOUWx9KaUv2EHB4Q1VRU0?=
 =?us-ascii?Q?YWs6ZuNZY90cMEBFpsTvBwPlPuT9teO5hDCqODzCN9gsolWc7N4hDUFLkFH0?=
 =?us-ascii?Q?UpwKcx32e3bZqjbX2mEQbcvD22CSLW45fJMMC9UIF87xF1EzInwX6FIlR9bI?=
 =?us-ascii?Q?oPMydyh3HGPbU34bmwLfydjhXVvLrm3512C5HRqEn36j762XqsEm36aBMaTn?=
 =?us-ascii?Q?oO0OTEa4mdaaMuiR7F+9Q6w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b279ac39-d7ab-448c-e26c-08dde33ab142
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 18:18:58.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwLA8DupNYzqfe4DxTYuD09Di/XC7DXsgoG2EoaCTwzjALG9ZeBXgQJbGmS3D2PQC4tK2UZXpqygcw1zqWv02o6bVOGrN8UF/1olwNHZFPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5810

Continuous reading mode is broken for some spi controllers. There are two
possible bug scenarios:

1) "continuous mode" flash and spi controller without dirmap support,
   but with restriction on transfer length in adjust_op_size()

2) "continuous mode" flash and spi controller with dirmap support for a
   single flash page

In the first case, any read that exceeds the limit specified in adjust_op_size()
will result in an EIO error. The limit may even be less than a size of a single
flash page. In this case, any read will result in an error.

In the second case, any read larger than flash page size will result in an EIO
error or spinand driver spoofing (because the spi controller driver returns
more bytes than were actually read).

This patch series tries to fix continuous reading (spinand driver side).
Unfortunately these fixes can't resolve "spinand driver spoofing" case.
Spi controller drivers might need fixes as well.

Changes v2:
 * added helper to create reading dirmap descriptor
 * fix spelling
 * error code is not used for regular reading fallback anymore
 * it's possible (but very unlucky) that someone will do raw reading
   of the flash in continuous mode (i.e. without OOB), so fix dirmap
   creation for that case as well.

Changes v3:
 * improve description
 * move airoha spi controller driver fix to a separate airoha spi fix series

Changes v4:
 * the period '.' at the end of the commit title was removed

Changes v5:
 * rename spinand_create_rdesc_helper() to spinand_create_rdesc()
 * get rid of controller_is_buggy boolean

Mikhail Kshevetskiy (3):
  mtd: spinand: fix direct mapping creation sizes
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

 drivers/mtd/nand/spi/core.c | 74 +++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

-- 
2.50.1


