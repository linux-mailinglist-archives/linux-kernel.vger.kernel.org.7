Return-Path: <linux-kernel+bounces-695517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AADAE1AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B1A7AF02C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 12:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962A28DB4C;
	Fri, 20 Jun 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HBHDeQZ3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9028C860;
	Fri, 20 Jun 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421404; cv=fail; b=gkoADjrmQsBsB4ERzqDj2sAK14V73hYFctp1RUQNFc8fNlmg+UatX+wwq+781SRsQNwqn/blgv9tX0rKPvh3ld79xGQVcUjZabd4F9Tff4/a+OLRfxZX3+yn+xpxkrPz8L8hq2luUBbRUCt2FCOEKK7124vsKhlDouIY8P7Zplo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421404; c=relaxed/simple;
	bh=26o30OrLH6ADivCw1bQBNISBFB85yKShSiJaApW432U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SHN5qP0TEC4yb2HvWR6VxtUqtzZzaM+5YKyxIaeikANqZN8UiWD9qSgzYllG83AJ4uoaA66bpvCmqMStPX1RwpUYP/yaA8oGaOc9uF+CN5TJh9EFGpVq11bFaGso39Y49JsQezy06D7canc9FpHYfcBJq/VMNBuszyu4n0vnedM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HBHDeQZ3; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvsYxc0t6LU7Kn5S/NXp/F3JGVdK7QAb/x9kQZIpYqCnRKmvJ9oRrJHHYinsPaGXv4WEDpQOnDZq4IlSy+/WeuTybqgRgBIXpyAklsbB/U9eTJMMoO2FMvpcvMPhUQb92dWpDwcjWtq63JAkCZAbSGNj1gx7WmCJIxNweOh+AWXeVu+VeBnKzSRrte1F2l94A0NSzrg8QW2Um60cNhVnAiugeQP/YWAke4Wg/p9QArzpIoLPvg86IHL78hINe7ZOPgkTGs9kX4kGH1xj7s1bzPd90vbHPGxrpYVpYITUr3vw6BgBa8UXxf7f4J3vKP8Dsq3e8eaTUieWNsbqspGloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhAUD8tTkg92cyKthTaSKTQGaCyfc2/22Z9ZNswNtao=;
 b=XRvkbFv4WBpGbqWrbeVGTnA0L4AxAj4cifzfzUgl2clCOJv4wodrMoEUcdGW8cZgnJnlfGx0A6+TZPCHF0yQwItiRRw8hF8KFcYjIbi+HwE37CYGD/vfZH0dWcxtQFJloA8fWbJvV2o0wcBIsrE+I2ajKW30cGbJWwitzNifYS8fPgL5GnWmc4n6cd+9LmLZnUPGUl7LAMR8l8SOFcQ7mTz6pLRFbINb6ec+jLC6EXJX6geSL4RRqqkPyAxTPkSEAQdE1Jg2Lo/x5LebfRUu4aMdPJ+d9Co9aHqVZRdaB7HKM6HIXFUNaois4QJpBG4Szwh8h+42Gfe+yXfYmPGXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhAUD8tTkg92cyKthTaSKTQGaCyfc2/22Z9ZNswNtao=;
 b=HBHDeQZ3u9oox9w7tRqICx6bW6LLLTmlB9jgihpDehyIk1d3x5uOP/cvmcDh+BXQk18L83//0ao/g4fxAueLWwOP51hbk2gtg71gkWZWGk+5RM/K0xkN95PjV7J7ZfSAVHwIl3l//xBlDsLKRzIt2tDezEAkdgMFHMF4OwYLiLQ=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 12:09:59 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::68) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.26 via Frontend Transport; Fri,
 20 Jun 2025 12:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 12:09:58 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 07:09:54 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/2] Add SoundWire machines for ACP7.0/ACP7.1 sof stack
Date: Fri, 20 Jun 2025 17:38:41 +0530
Message-ID: <20250620120942.1168827-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 31177a56-9d35-4f06-597e-08ddaff360aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Un1VJtMrdRRYRnP7h3hKjgfC6lBDnvRGp9uqR+9F3SXF00Fm9OLhxkTdZUpP?=
 =?us-ascii?Q?iLj0ORaOdXS0VkOu+ivzR8mWbuOUlQdzq70M3z+Q1LUdJoJHHA617LV0T8pj?=
 =?us-ascii?Q?lVpTStoR/nofiuoTukvP0XMAcftytMDYwexQt5QKaf+9pRZnO4If+nXzIYxz?=
 =?us-ascii?Q?M3Fn1lEwzfrHBrJufm/WL2XSkEtGC1LU/sxBMPWo2+8M0xl+gevPVWj30mm5?=
 =?us-ascii?Q?2kUWtfDJEVYqgMxvfwMD0k8ox8LDPzyiOmsdrSUDo6W6wFb7fqKiHF0qpPT7?=
 =?us-ascii?Q?jFrJ+wRzSpsigNWExZn16NbPVynhC5YbHsTfBIOdesEk9a/ClpJHUpjBeiiK?=
 =?us-ascii?Q?TyXG1IW6/SuAh+eR2dKQrgXqHQzU8NgBlMhbVAjvKbH5KrCOvwuol+cRDFX6?=
 =?us-ascii?Q?mZ5DdC4h1qO6rV5UGIpHRIOnoLOX1AeLBdu1qd/P/5O2RpKciNbW7ojQbnx7?=
 =?us-ascii?Q?vJyttVHrXRkjU5ppYaSx5BWWsKfS4NZV3+UZkYhHvbj9FkMhFaeacUhHvYrk?=
 =?us-ascii?Q?lyUtOPLeLpTQ5Rd9O9Ksr24FExp0En70MmSQVHccya+YqmlUY5x+PugKwYm9?=
 =?us-ascii?Q?T3pIBmoiBhaZKEv5HgGOUfOlGvpGnPUisRqKoHRa8szKCDmiPtNiwP3k6I3C?=
 =?us-ascii?Q?nEQrU+tyZiZ6v+3sYp+W+klcJB3cA1ivGVXh72emmG1hEphkCJ6eI8ZBjK/z?=
 =?us-ascii?Q?BT1wck8QXAmCGO/5oS5nYsg+VOV/UluxzapHjitBMk1Fd+a6QmfpobiiiIiW?=
 =?us-ascii?Q?9fh9h2OSAKTOHpM4mVz9yby/gxhroFOLAEbfL3Gg1Fp1xNSncaPulg1S+eXt?=
 =?us-ascii?Q?eIhSfQJuK+jEW6zYoQh852ExFKKIRiLcsT8h310UZwLa4fUVtzPsfm0n8aiq?=
 =?us-ascii?Q?LU1MZE6vBKFv+VPQscGBJh9QR0rejXygMXqE1J50Q+beNq8YXtSFPszUBp86?=
 =?us-ascii?Q?EDz3YpmbglSVNJ3njp8V/YY/eq/PccTW95LVjzRnOmFBWdmx0kyKpZPDJVq/?=
 =?us-ascii?Q?inv8pZT8zcHzDeCqRzfgMLzHYUtdY3/A9v5NF8zE5090gqoH33fA4zn3ciiY?=
 =?us-ascii?Q?nhWeXJ1QL1efcrCjbmkopiwyu2ppj26OKDBL+260+efpA4MDikclmZPHofrx?=
 =?us-ascii?Q?+ftcCIQVoWubi1f/GfrFFAoktWIFPlPPNg7CXUyuH8ktBGlQvPqssoWQmlxC?=
 =?us-ascii?Q?jbguhCHjPRbxihv9zU0T4XXXzbk7BTLSZLTsLX6ImBg1k9rjcJTTWJ2ngtFA?=
 =?us-ascii?Q?mWV4sTeb0fovnVkdRmpLorqS+Y/9fwOX0iqiYJHoDtY6UXCtnWLaCfo7STz/?=
 =?us-ascii?Q?6XnlZzz3PhfNtC9O0Vy7Z7EnNCfxG+twuTs/05e3p8mTv8KTjdsRnUF6hHOq?=
 =?us-ascii?Q?smH9LTXcZKGpHXLElfr2IIV0Cg8PV/FSFWGv/JV5WxYUhe8Fv3ftTrXGAg9b?=
 =?us-ascii?Q?eZKRAPhmV+Uc569j/6b3UhOOeaP6NRyrMJsZ9YEMx84+ETOAvRL6uzvOOH68?=
 =?us-ascii?Q?a6piUfTNmB0Cgq3GRrsfgSDY6d5J/YCydUPH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 12:09:58.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31177a56-9d35-4f06-597e-08ddaff360aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734

Add SoundWire machines as alternate machines for ACP7.0 & ACP7.1
platforms with the below machine configuration.
Link 0: RT722 codec with three endpoints: Headset, Speaker, and DMIC.

Vijendar Mukunda (2):
  ASoC: amd: acp: add soundwire machine for ACP7.0 and ACP7.1 sof stack
  ASoC: SOF: amd: add alternate machines for ACP7.0 and ACP7.1 platforms

 sound/soc/amd/acp/Kconfig                |  1 +
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 12 ++++++++++++
 sound/soc/amd/mach-config.h              |  1 +
 sound/soc/sof/amd/pci-acp70.c            |  1 +
 4 files changed, 15 insertions(+)

-- 
2.45.2


