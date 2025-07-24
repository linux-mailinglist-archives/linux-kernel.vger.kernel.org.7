Return-Path: <linux-kernel+bounces-745004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7CB113A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57EF1CE0A13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D123BF9B;
	Thu, 24 Jul 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="YFEekSaF"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842C239E6B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395178; cv=fail; b=VPQo2xynb9hJ1037C3dduKwcopDz8Wvl3Nk7qaG4au/iN1NR2/5100zaq96lFNBsrd5aYZJML7qMbBqBugg7esaq5NXStJIa2YgnAJdtiHgvtUmZChWsOdHB8MTCyJsCSxmRXi8ZpI2qPQ9wN1dRnXe5xnuEtdWTHgYy/gLqSzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395178; c=relaxed/simple;
	bh=IJK+Ir0tA81uQBjcbA8kZcA3NomCl5bI1FTIjPIlJVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UaaDZPIMz/7VCRGP0NHCjB7pATIj7pBkX9vWDChRONglqrimh4CSiBCtHMpIwX0JtALPK/4HCgKpTROqJHL2Lucgcc6pjX7dogFSUfWH5XTTJ5IsFDttpLbjExa6L5h5Zme4c1+mTpCiBirLm8N3YfurN9d7Tt3CT45yKkuMj44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=YFEekSaF; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiUGM/dM4ygxgy9hxveRZa1DPIEuxsj8E2K4jIMiqmdOz4DpKyxbrCsWZzja+bb2y82Z8HV41PYyFzbI8U9p+m6/OwUXVfAChWD/Y8QBMHbADyxGu3N8msSetofFv83NFnAmdENBRsa1+lIrf8IgC/MW3FNH97KixawQPqI41smXuv0Y7hmSUjLx5nuHzETNRjhlFPpyOAbKhwNpCk1AkWVDyTb/+iWzVXy4JwWifO6cu6/LqfJ5YZqD0jl6KdOR1VzAroVNlwgBp98u3Xgoegt8ZbQBom09Vx+CNRcg19f2cROZvr8ioKtjpR8fe45a9qR3pkJ16D5qxlVPoYsg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBEyo8bg4ozRRld/qGFPTsbvmKm10Quqq/Wi0K/VYaY=;
 b=df5cRSuonU7nyToH1/tLoustgNnA39r3N3+GlO5ptcX22zHhmm38liwlZq3uWv1RZGTFqU8XaK3cC3EAtRcde83q6xMiFnzfnzfWZ6ZK6/lliYESzihJcvFSdG16B2hR0f2MmKoKNUoJpnADlbqzJx1I9KWPt4jTDLP5vhRwzsvWKzMMxrePyafpOA2qUUGOkR9H35VR7XdX98qYe50f7tfGJgxyVh/TEEME1VnFm8rx2cB1h7PyFKHwO7S/7fucXlR3FIAwmu4Vij07mon9U/Gu+hE2ZnQojV7YOU5UoJd4f25Yx9Q97YnLAUp84HX0cIjYKbJXRj4/QVNKGoU01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBEyo8bg4ozRRld/qGFPTsbvmKm10Quqq/Wi0K/VYaY=;
 b=YFEekSaFW4iW+yAvZQvOwpwdX7+izlBx320dFNYQx75P4fzna/AcBBnv3NS26jVi3zUGASjMdCi6AmJokJFYFoGXfXtLqGJkPNgcDA/QIIoEgWPLScvPkfuQ61c4+2iFqccqMjF/h2LPmNF3KKK5uUms4YU634UZvNYwVRUzdeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8089.prod.exchangelabs.com (2603:10b6:806:32f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 22:12:51 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 22:12:51 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: cpufeature: add AmpereOne to BBML2 allow list
Date: Thu, 24 Jul 2025 15:11:04 -0700
Message-ID: <20250724221216.1998696-3-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724221216.1998696-1-yang@os.amperecomputing.com>
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0236.namprd15.prod.outlook.com
 (2603:10b6:930:66::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e598df-dae9-411b-69ef-08ddcaff3b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FGOcDkrRHKn7ny9zRn+37g/RjXojS67zdsmYVM0Hfc1A0GfXZD+ljs37kSu5?=
 =?us-ascii?Q?cP9JT0EmE+zz12veS9Zz+A9WrG/aOYnrY/5cOsP8PM4x5814eiSJBVcBUXp9?=
 =?us-ascii?Q?VN/pmhAcOjBAV/UWX/1AASXv+cc5jguaveySUZ0fJIqhOqmY1c3H2LXZRoQS?=
 =?us-ascii?Q?iH6J0Y91iIb1JfrfhycgvNhkkIojRyQw4/hqPzggal0z2oZMNlrXueLt0fCT?=
 =?us-ascii?Q?zkjUfr46fjAaF0mrOM2SAdlywjbH/bZ3mbDGu54c8JSRTkpFUrDARrgy1oaf?=
 =?us-ascii?Q?P7tidKdnp3xM1zjFKolYDMshkPMXsV35DQDHJUtJPCvSd03MxdWOM6CjziRo?=
 =?us-ascii?Q?iXizgIBj8TGJObC65IjwNcdKjrRx+3U5QQd9QilRgzRE/okbc6Pn/8vGMzRz?=
 =?us-ascii?Q?Pz+GayO5VIYaxvrm+NYsjLGwp/E6mQ69uphFXVyFvcMG37JHJeP9dzQnRcIu?=
 =?us-ascii?Q?/nrWOU/UyCaJbZFd30Bv72iPdKvtIMJPYnzStC7yOjBV9X0kjqsodEVanW8d?=
 =?us-ascii?Q?X8Otcvqvi1qTqJ4OmOZW4pIbDvE/GhGuojaj58GQzwN3lvcYOz25HtYPFc2c?=
 =?us-ascii?Q?7gYmVmXp5Vz/jYhRzBzG9yI6z5lJp3MRbiKRkQqNpocQKnyU/TrtsVlYMz1v?=
 =?us-ascii?Q?2ZfDKFBJIC9rEYvzdUMYzXqk6vw/bPDGl7zXWylnLXYp5eqHJD/M/A+e3cjF?=
 =?us-ascii?Q?5JrfrvDSZrc3T6cU5aHN25zQPns4nygo/wh87V0J7miUgH8XxvFST2ZZcJIg?=
 =?us-ascii?Q?HfRMxKnZVc6OFUQKe1XWQmGU5uK6KPKFFrFN72MDVy4uCZM34SFPi3qB0iqL?=
 =?us-ascii?Q?Uw78uKTkVXIRoNApw2Xn5qacbdoXp5VSzy5wfaNb1d1ZysQ8E56U4JBVTnsv?=
 =?us-ascii?Q?EmAxL1recGRB4JLcDFGzG+yOj8kmXnr+I/O6k7CETayfbCNZ1aEXCKWk+zBJ?=
 =?us-ascii?Q?Dh8ugPZITC/SHSKcD9BbEYGSkNu5za8u5ApSMI7b9GPNaLql6Fy2aKcGwWfN?=
 =?us-ascii?Q?CNtR5AihZEOLtUDoKFDxzEvPPJzt1ETRhYfkIw+6LUSTeF6D4nxpmuTqMz2u?=
 =?us-ascii?Q?SUaIeq4mnlvgJAhsEAU1rTfFeeMV+hr7XI5aCpaFnYIn3gWFky4pZ9d1q72f?=
 =?us-ascii?Q?CCe5pw5kEsbBmQhcS0Omf/GNIL8QC4pdOCaAXArgSoerNvUW3JKR9MkzQUlD?=
 =?us-ascii?Q?TOHnSUTSd/HGL+0jBE/kJv6U1RnRIBOW4UUlFH5H3ZYvezKQM8kA9Fh1uMBx?=
 =?us-ascii?Q?PVaBQwZmjButppMhi+0TJGz+PR5Q/GgxcFEeBXe4An2XgSAs+WAHirA5PMZ3?=
 =?us-ascii?Q?LgJ35CZBNVzUAVdVLEk2YGn42Hvhm5jIl5nmMTOYk6CQbDomTa9YIwiwNclc?=
 =?us-ascii?Q?UxRIXIoavjjPPXg5PFJrROCZhczep4QY0WTmcLfGrapZf1vVSRvXSlm99mmc?=
 =?us-ascii?Q?XdDaNwESnUsXvua31Mg+NFm0elMLOrerYIm8f8vpAChkoSZI/EjtjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?47eO5PcadLQvRC/RIabKSkl7I0lAcCGOAJaUI56eFU+GCIoeHn5hOTU8IPu+?=
 =?us-ascii?Q?S7pVS2RS8dU3qYgiVmRZLnzcwd86KKtIzJb98FgKLMgzpzorc0bl/IAzyrzS?=
 =?us-ascii?Q?Dfcv/+/fw74W1Bgk4UUBbWBcQyLyqonqFrFALGPfJDqvHivqUlYhXzDZQluS?=
 =?us-ascii?Q?30UIJfjml3UcGf6Njv6fLFk6bI3WkQ1qpEiM18zkGojByOgpq0wTYO4tglae?=
 =?us-ascii?Q?vJ8xHqtdGVeAp2rP3SEdz3VoOqZ9WadkT5d0rURbdS7y5dwjREKa9cyST+ga?=
 =?us-ascii?Q?MdfGjwEOVcOuU4dFrgD9atRkX7Wu4n9fTbAX33cXjgErU1RvUbGdUQKxMAg3?=
 =?us-ascii?Q?4vl7VeDcgE23N0mNut/VX9U5B3nJzqFoeRJpfRUFjQuoQ5aVntln0Tt4C1Em?=
 =?us-ascii?Q?GGukuhaChrA1JNggv5/gbMhwbxsOG6NfE8nJUroQ7HZxXNfTKvws2aa4Bp18?=
 =?us-ascii?Q?VPuX3eHOPXBbpmX2xTbxM/ntIRYpetp/EHlwvplBzusO9fm8xRkkxb2tYQB2?=
 =?us-ascii?Q?ajNWmeiw/cTDbpgHIPj6jYnf3MENpIRMAHVtlamPSM3Gxux2HSXe8uiQauqr?=
 =?us-ascii?Q?pEZfub/0TRGRxysenL+8ThvhXA5FlK8arPghuts0yItZ+MrbNDFyIqGBIW6Y?=
 =?us-ascii?Q?6tch7Gk79PMQn2Nx7drWOeA4CIa0QTOIG1Y7E1XZhDibRCKRspgbFFNiLeKs?=
 =?us-ascii?Q?SGTXgGoX8EMT/c2GoOWWFfB7VMX/kDunsvJN9rUd9+3TBddN1XqftwUamX6K?=
 =?us-ascii?Q?8dEwbigxAvnkkqWIdEhwnZUhPRWxOKrspRlM5kf/qh+nmt4gBKKjWjDTXAlJ?=
 =?us-ascii?Q?LiEYf2GV+dwTEgk7WE1fyJLXOUdixnHU6x0jRRN1l78RPwnXS0Y3Em/Z/F+f?=
 =?us-ascii?Q?pKc+qCitRy4EljPjqAeeV9a/gZmwMjxQg9WR1IhsPmV6ySVaprlasxkfzoDD?=
 =?us-ascii?Q?zfEJulA+uz5PwiLwuvZ7DQiE6BEivYWbHwiXX64Jh0AEBupE2wW+nDtTPweO?=
 =?us-ascii?Q?E9RlHIDVQpaysuwk73FmAdBeon/25lkriDswUj9HDACeonlbGjg45CHZc7pf?=
 =?us-ascii?Q?dDvR+1rGcGTU1YlKWsV25cz9vgMp6IHm5DcJMBmtHSlp2ke+npj/65jwSGES?=
 =?us-ascii?Q?A79vRUGQkgog2UIcj+DM0rjVtBCxbivYiK4qfZ3dtilUQZ8WZbsxllrFzGmC?=
 =?us-ascii?Q?2WzlryIsAsAhaCTA0393bdlRa1rCL7yodjwULf01nTnNe7zKyhHgt2ROYjQ2?=
 =?us-ascii?Q?o2rnH6DRzEYj9KDp6Fbc0VinPj/zP0z41Q33t2bhcg88HGicrSaRHYqenucr?=
 =?us-ascii?Q?/sQFmFeS3b8kdXxpnFa02osGuuZrfiD/eKw1N3QMacK78O6qsrI3NtOSEGRv?=
 =?us-ascii?Q?O86ly/eXS3jjZ2PxdIfFby/oC5voIGIxAknk9uoxnY8m0Jvrn09bTns2xLi8?=
 =?us-ascii?Q?QUEpkU0Hd89VPgKZgxyvUwde3Q6rOC3LIiQoflomN/MvLDOd7TUDhnMpAu6+?=
 =?us-ascii?Q?MdUooJKqUzyZ4pJ0X7hU/dbkNLM40JxvCbHoqQ2EQMgYbZvtb7UVQbaBDler?=
 =?us-ascii?Q?UnWQ7ZE1vfWlDxM76xiQg8xuwhc7yPhAHpMKkvW9z6OoZK/egBkND0pgquM9?=
 =?us-ascii?Q?wMFo5Ulmic1v2sR04q9mPg8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e598df-dae9-411b-69ef-08ddcaff3b3e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:12:51.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSE+HW2L6pZCQqrlj9b6mRRyR/NtFljmOjinofLhtYKafcrhNHrzZXct5GbonjEuc4BL3Vh1Qh00qCQaU4tJGIa0RiO7+cXO93l8TUle+c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8089

AmpereOne supports BBML2 without conflict abort, add to the allow list.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/kernel/cpufeature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7a3c404288d5..d2a8a509a58e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2230,6 +2230,8 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 	static const struct midr_range supports_bbml2_noabort_list[] = {
 		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
 		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
 		{}
 	};
 
-- 
2.50.0


