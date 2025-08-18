Return-Path: <linux-kernel+bounces-774078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16FB2AE64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417B1580EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF45341ADC;
	Mon, 18 Aug 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="auV5Eg9O"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F67235345;
	Mon, 18 Aug 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535182; cv=fail; b=cmK5pctmGhsg9DdI7lki71fvZYKKxjjUIofXsO80Mmvs8ELa+0+dAq5wq66uokHWeXyEj1uADVGvYoTKp5PKzh6JEnMat3CmITNlaeVNV/eQDVsapWFg7qHqUX2V9e4vIS30cRZrZ4lJhtxhSL87h3FEkAZLXJwRuFZMEjAJCHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535182; c=relaxed/simple;
	bh=kr0IJf9uvCESCxsuSHsLRFeTz4+77OTOBVQqhEBftCo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rCCdQOKGyAPGgzW0YChUv2vHXijQ7ZFgHKDSv+YvDNaL4GAsIpT7C+ywbgrcwP8YftZt2BcqIYN8Rq2Q3j+C8birLvvjZXmYQhdJA0mFsJXVemLRo8GNwJnnXZr98DCU3iNGQcXKd8o9J6EqJcc44V9jY82ddcDBDCZFdVxlkpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=auV5Eg9O; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCHx6VG7uBcB6Bu/0zJXhbFp81ILqMp6zzuFKF+vbGXWTsx52qHuaSJYELO+YxUkLYQTG0PlhK5BCDaniDKsMMUlHqK1rn9CxE0MFfiUefbvvLEzUUstwM1eoWEf7ompWldr+4hXqNcX9FbEHEjEg7iICZABmU7Vk58RlCNuh/7xbUXSgtBm6y7m+6LD5bFe/jq8Fynre7tWqzQAMQfaDrU1Sk11YRvuOJurfWszZPVGzyBKXaBqOfz1kkgOBMveoshUeO5k4hLHmRCD0wqG4CL0toMASNEaxCw/yhEMKUVlvXJNteu7ViWI2x2vBvKR60Ytfl3PlUx46LTjIdq6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5Lic3aDc9/4vb/KxyQEuYCdb+LfUBHTqPt3IFEz+80=;
 b=ZU/qhsY/uDfsHiJOVzaMaTdBhBmFnGlNb02JRrnEm4VqBcQPz9zV82x6Cryd2eR4QrpdVuM/VMaCO6d+epdwDEXn4IwTOZaasajZE+HrBri8Sjgk25sY6ooqPl7P7zD6H/V5RsupUUrAlr4t0RhVvnuk/t0vRVcwbTsA5sYMTvYl3Dkbl4HskublZQ0RTgWDAQcAjrKZ1Akwfd8+LmBtuvQmRrUuqcQR45ihG231Vf+QOCRFJyyC9h5W0ViGOlaGf98QY53Db/vsgt0fazaplyJi0Zc2J2KF140jZBnYwL3LKjIPnDyaQELv21S0ZnAu8Sq0C7GY5Ful5HWGUgVAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Lic3aDc9/4vb/KxyQEuYCdb+LfUBHTqPt3IFEz+80=;
 b=auV5Eg9OKWlON3pFPsODMJr8b2qjB4gnf6jN0MuBmtTZ1K4nCjXZxIal0BNiSoJ9eZcrA/feaA1OmiTEszuxidSqYaSpBN4drImAX36kYZvg52MoKxRElPniJmWl02Ol1OgaQUf8fNVw3ydwHBzSif8hGavj41Z9HvDsYk+5+iPtGS5H/kAzv63XAS3ADgSimQdWLE+xUs2Oi75aURAzuj9viOZXjvjSci2+H8j2Wn6qpnSIccrYWGT9WnywIVTtNnUI+S6rGX3oe814y9KB5a18kB4z1PF4mRHbuhzPBNP7hwK+pcz2OhLQjWaO2A7kW6wEsc2QyNpn5G33jsBZaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6158.namprd03.prod.outlook.com (2603:10b6:5:399::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 16:39:38 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 16:39:38 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 0/2] arm64: dts: socfpga: enable ethernet support for Agilex5
Date: Mon, 18 Aug 2025 09:39:31 -0700
Message-ID: <20250818163933.62086-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM4PR03MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a3ff08-11ad-434d-6e35-08ddde75d254
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbS/DYfcqeAmAeH9ogIUnnK8Lg0RrQEP3zNswDMYw96+LauPSF2QOxeYYEmb?=
 =?us-ascii?Q?aVcDYwFxtmsiFtskTHmTCh+LPZe73wTuYJnMqno/m4G14JYIHCgEfMhqYidf?=
 =?us-ascii?Q?anV9GCyRhtBptpmkjJQhiCz4WAi/o6leYIr0Boi3HgrB3l1l7wGpPuK4T/1x?=
 =?us-ascii?Q?W7bCXfBW8UJDOgp5Jb8jGOfdS0p00Sc1c75xsWB1ybKBC2x5pNa1/2sMuJ1r?=
 =?us-ascii?Q?4spOv+g9OQgj9CLyJRSmuXKGlbOE2AXLnqdjuFHD4ENdZC/IMOulTmrOl8aj?=
 =?us-ascii?Q?aNDJxgRV+gwviDsBx2S8TA0dqeLgtUK7D+xEX04NtY2GkJ8KPkhl4gwJFVTx?=
 =?us-ascii?Q?0J/DZath8JooavdI+FtpxzJkyarJJNUxsRYXPRwTI49nZlgdULnHOWKy4CGL?=
 =?us-ascii?Q?VVkxXq/8hKcz57ymHxyNe9624JJ6SJak+RKc/A7Uy/qaVNind+ihIWLl4DaJ?=
 =?us-ascii?Q?jNqjFVlzjeBatGgOuTCMf1TjnhXUGiDK29xtCrvglRfeuaLD7lCtPKJ1xp72?=
 =?us-ascii?Q?eUKsuP9OBamPwhjQD7LcCW8aitsXEq+A0p4Zd1LYiTlXm8ZvJc81OXDKXtvq?=
 =?us-ascii?Q?r9W2ygQNGmBpC+rcffRqJnL94ULQqPXEeS/47YPwv3prc1mlLSETAM0Ia0mr?=
 =?us-ascii?Q?Ur9hM3VzJCOYrnbRmWnYVVd9J8OVDPlSvOPSPN4HZicXYep3R1m4UtmWPhrN?=
 =?us-ascii?Q?kXXhZ8W5KUW2hBYrvP7VgqDWbvYJjHU92LOMymZvfMbULp1xmRKt9A11l4AV?=
 =?us-ascii?Q?nai93/o9DSOmUTKMF9EbzFz2fvI2U5P234hqaTebZEnbkccf6i6pQGBCy7/Q?=
 =?us-ascii?Q?g7g6SWUpRSaq4te/e8O9NcW0wNchNCYnwAAfXjZKgBzOM0FSnFZpKQSBXS0m?=
 =?us-ascii?Q?+BSeEYF/12ndPOA2sXokb7HNlj4vVWetToaB/wsH9d9fH6XEA82Myw8IUljn?=
 =?us-ascii?Q?i4ed+cp9srg5ErFTes9vH/uSJNyeWvBPPuXgZUF6kxNC51Y+Fg4MCKFfLqPZ?=
 =?us-ascii?Q?HSDPYJgu/v50Vw83YoR63oH3ZUa5OZfkKEzYihzd+HVTKfWHJDzIdhGdSKrI?=
 =?us-ascii?Q?m7pE+o+ByNwq8YqGVmSEFCVJtpqmhZNqpp4wvRnR3bpYlGV95vPeMQLTAeUm?=
 =?us-ascii?Q?xbpffDOJT/8Pje/oK4hKUHKt4y4KtW+WIDrpeLnuqVf/AaIDLhLPyE5tyOkC?=
 =?us-ascii?Q?7xVPibVif8+q6odjeUQQlHleoMQwGSYHjl8QP9i94TDjcFJzfHoprL3B1HPS?=
 =?us-ascii?Q?oIxCFOzAb/jglmEOlL1sScEEghUoCn3RWXaHV5RNNFGu/kx8HWyAzBzrU06A?=
 =?us-ascii?Q?FOgE0zo+JyPEIzps93fU9464VGRXHigTUAEfO6xdaV53TkuJbh+1M1cPpjhS?=
 =?us-ascii?Q?KbBu7sM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zdav3X2Vfae0wI1wHyvSjQoUziJ2tQn4Skqfv2N65xzvMTKOwXWo881nuTZ5?=
 =?us-ascii?Q?Pk2CgSOqUzVJxwPEj4KlUvzwMRKCjyw42D+ojH2XjcyyXK/1FbLH1ohnRay7?=
 =?us-ascii?Q?IEa0EoKaFigY3FA0MopNGnsb9DSJW4sjN8YHJZBKYNR1SniSOREu5+muj/Np?=
 =?us-ascii?Q?QFH79huB9aF4PofJ1JVgJtJfaynJDoS3dxfaTqfNAITnVXseFRmN4KLAYqXQ?=
 =?us-ascii?Q?EoZ3v+tbG1/utlufYcfV6Lu52hfZ5KEezCw2cuQSuog72NojL3Qlsj6J1uyE?=
 =?us-ascii?Q?zeTi2dmNgZyGSW0R1LI4jSD2QC0NxO1t1LQ1Thm1319bu7qUt9qbMvcYuyPA?=
 =?us-ascii?Q?XjFOXpJP2w6nFhXxlS1oqf3zHbp9d5c1//teabFndtp2LkeXZTzsMKwblULm?=
 =?us-ascii?Q?bw/UUDWPNQXLqczQsfgeFAiEmvWVPASaOcSP64VoSUItt6tL9MrgcU2MdYX2?=
 =?us-ascii?Q?81mYmxIC0ex6xtPaYzT6nVJLVTK6AjsUa6vR/oB8/dVGmixpwjuU9dLMZG/Z?=
 =?us-ascii?Q?7mNOrpbV0FM+6VtIWx/SIhVUYW4jOKsFlyHPL2PkaJpBszC1LTBmPgGWyAIp?=
 =?us-ascii?Q?f5OwKegMwxfmUCmPZ90SnriPXUWbjK2yzeNBzP1WXkVybVZGTj7tXNB1t1Sb?=
 =?us-ascii?Q?X0v0GFrObqF+d5DIf988TY1/udhEAwVbI6AuHYuogWcZvectBnJD18eTsXNU?=
 =?us-ascii?Q?V2zz0dGvdrnn/X2riQU24YPMzraQHyU3VDSvCzR2lqAL0Oz9CE49H995Vl/P?=
 =?us-ascii?Q?7bEQiGrxGwQlByxDIY+YQXS/ibOguNrFYHBA5aFI/W8FgGsqQ+KDx+Ni8IGh?=
 =?us-ascii?Q?JLQiNMPZVWxvYLU+53/1qKeANbw+brD+wacBgpKaKe73qyYrVdmNY6ziALJz?=
 =?us-ascii?Q?prdKXF7Er3YbhoUFIop/4FdXuiUkgGL+szErPZoOwn7JF2Ydt18Et9qPezlT?=
 =?us-ascii?Q?pYWnyaDUgdON7xBTJhXQ1UXB3OXkwGb9nMrXeMEWmbCzv6mSX38Q8dNDW+zW?=
 =?us-ascii?Q?26PIm/r788n2pEIWHjjOTSOACfJAvqDCJraua2TvqHQO/fOSrA6GqV92Fr4F?=
 =?us-ascii?Q?TcUqRgqE/IhKbafyhH63Ki2+VQpXlWnuA2Kx/mT0aXqfqS7PfaD2Bu5pH3wh?=
 =?us-ascii?Q?03hAuzV1YLmOQYBnrULRfkseH1QEwSw5xwfb1kCEkIxMBHBUZ7BDk24fUXEn?=
 =?us-ascii?Q?R896YipLsQTdM/jiY4wirpDcOBZ/hSdm7fbbWFmdxfcbob3SryuC7+QHM38K?=
 =?us-ascii?Q?qiFhOU0u4e1D4S4HKX/StVzeGQuTBCIis4LFvzI3DZTxZ5qTo0JFitF6245h?=
 =?us-ascii?Q?vKsoQlNoB36RmWvgDQzk+RZWYzj9iHoMC6VIOwwN925mbGWJoj/470SD2dc3?=
 =?us-ascii?Q?yPXs1y7hPp6xm4iWEnHuAOuqnd2zR2+qcX6v9ZKksip8ekVjViKQI0ketiTj?=
 =?us-ascii?Q?Wh8QmyPW432qytLsyjBNnZdS10JV/k1W3tNfDpoPGbvXI0Rreg2kqgLJSW1b?=
 =?us-ascii?Q?Pn1n7SynJ/tY5SETs7YDsT8PCbxIJkAnuYRay4KMQwTUSoQBM8T9jWUtVdHD?=
 =?us-ascii?Q?gLwCvApqDLsFJnXP+JLyEgGXZp+l+l2C9nNBk50y5/cKxc27Lv3MmOS45Dsd?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a3ff08-11ad-434d-6e35-08ddde75d254
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:39:38.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSgaUbJy208jBRx/hEmTCCPwK2yqick5oB5eIip8Q1qEFiu7/exj5TzjDHFUy2rosvwK2jqWK/UYfV4kb+9ZdKLTLVxCQE5m+oph/AmnFjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6158

This patch set enables ethernet support for the Agilex5 family of SOCFPGAs,
and specifically enables gmac2 on the Agilex5 SOCFPGA Premium Development
Kit. Patches 1 and 4 from v2 have been merged; so they are dropped from this
version. The remaining two patches are unchanged from v2.

Link to v2:
https://lore.kernel.org/lkml/20250724154052.205706-1-matthew.gerlach@altera.com/T/#m3e3d9774dbdb34d646b53c04c46ec49d32254544
 
Patch 1 defines the base gmac nodes it the Agilex5 DTSI.

Patch 2 enables gmac2 on the Agilex5 SOCFPGA Premium Development Kit.

Matthew Gerlach (1):
  arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit

Mun Yew Tham (1):
  arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5

 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  20 ++
 2 files changed, 356 insertions(+)

-- 
2.35.3


