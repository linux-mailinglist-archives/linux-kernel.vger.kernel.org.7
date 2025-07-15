Return-Path: <linux-kernel+bounces-731542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD4B05600
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8116F830
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B42D375A;
	Tue, 15 Jul 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t0PV5wmX"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF711F0E47
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570801; cv=fail; b=fFFLGN0d85RomRPNGRcMXRztDL/fvII7D4qCMGS16FMD4iZfCdfFJU9gtJsN+6rwvI2S+p9gRtNqPpVrlcYhS2GWxi53DWXJj1OIVH61r7UAkHOO5bw2rqG9t8K3zRK00hBYYQcwhu/U3qQLpoorS9aiCGqvdAnbYjkOrIYmB20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570801; c=relaxed/simple;
	bh=CqrsJ3TS4/Q7zRsenmedsjWQvHvG8QUELPqOgyvwx3M=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1OD/2E5pd10Z+ekByhGc/bJU6hbC1p/WiEiAU9nFcDKZgPUjpG+E2bWiKaMzACJGgJqRa6zqhWSDXWEGnFjrPKGxGe2oWfn3OpmUYZlEqR9x/5SxR2zJeNnB0937k2bOc4pcWAkZ/gm6umGK03/ice9dY+kuIEsRTTK4L+KsFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t0PV5wmX; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N73nGGbotOOmvEnGKcveNWXuAh3Eod+/uEIizJWFfrf5fp9aefsCs3FtY2Nh1LCmGPsPJRrdrRFoFsY868lEuo4T+v/hF0MuvKEsODtz92pQq8LGD/pB1YdMSgK9CNXBIeZj4nlYjRgPADWJst7FD+dWj8TnyCRI3b4yz8sikdH8RbBwgswNMz0tovBzQLd4GaQBZ55Sdvi8owzt84qjLPMh6bQKdevn4w09bTActnTv3Fc0CZqUR4Eg22H7Xt/LNi/KTvuLDvziQ7pF4XhsFUycTE4vYR3OIDT65uNGIR6X+PZibvljKntQLwiqG2UYqOsSagJNPk3L3yFRUqeuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kPb/KHdIf32Mn9UkQ8D2nsshAUxkRrsa64dgtNCID8=;
 b=S4iSsfmVp+ndur0eo+04bZhyO50ie6WVoic1UKUtr1fIQaADswI/DMgsKNl2xGKWzAfQzPaja3bPzLdwJpfRZblMnWT60Q9t/YnqgjQb1S12xm3/Q/Ebq/ZlJ4Nk+GwU1XGP+hgJULQQ+B2V/92hjCRksbWAu/eHPfgtDZUqh2UNMOeCbuWQl+Y+CqZbGO/W8GhiV50/onD83u4FXxn92+IkV7eXpk2uRRgcT7DWxSk1eTjXRWU6LBp82pHkEAXjb7RnRWt/8Kt4edNgPqPp7nxNd0ZXgjzzIxKIpllhNioGa8sSEjNcOb7NIuX5l8wNwdYFXikL25/DAt3owYckxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kPb/KHdIf32Mn9UkQ8D2nsshAUxkRrsa64dgtNCID8=;
 b=t0PV5wmX7S814v6EBTL9xJsiMtfP4RZhGieIANlCRrjTd41afpBeNlncQWidvYF9LUXP/3sMvY6FxNF+L8aw7O5K5XinbcPjlQHU4sWdkUykEQpVsmNOxgMJs2JKXd17TezCOxnvPzvnpeVHl0hFBYPllYqWgvGbCUhJFF44VQA=
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:13:17 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::f1) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Tue,
 15 Jul 2025 09:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 09:13:17 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 04:13:12 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
In-Reply-To: <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
 <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local>
Date: Tue, 15 Jul 2025 09:13:10 +0000
Message-ID: <85ecuhx1eh.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 48106b03-d408-4ac0-a5a1-08ddc37fd5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfr0maKHAltFz+ah1/JeGDe78B705sg1j8+tuJbs5Qw+qWDHdnixecOKBl9u?=
 =?us-ascii?Q?SlBxexIqwB4pj4QxMRBqYxM7IJ8Xb9Q7CXWtyiKmA3SsX4G9GRElj8Va7/4p?=
 =?us-ascii?Q?WYh32CwZZPgLZQVRg2hb+4/Z2VvsBnt99cWFRMfiy6gB98v58wbbph6+6yAt?=
 =?us-ascii?Q?/E30TjQk0JTO7bABzKNsLifAmgO8mwXF4Ujy+16HEZ6gcI7nchey2EK4Yxey?=
 =?us-ascii?Q?MwGcatOwQ1KUJzvIYHCKhPzdB60t0gPqcQne5cpeQqUuTUC7YGjgiJHqO/3T?=
 =?us-ascii?Q?Xm/msM77+QDnVIOJWx0MO4qO9EclUl6P5N4CDpr1BtNNn665PIw9MkCiTEgT?=
 =?us-ascii?Q?Ju8TVxFMQLk+mIjM/ZOPGJX/iP7tGpPa3fznVFLt6iMrEjxRQUMlPcGaa/ES?=
 =?us-ascii?Q?an/8zAIAw73rXOwIcZN/B7coAuPeF3uTphBAvekqA0QscaG4AmbEx0DXpMTe?=
 =?us-ascii?Q?lIX0FD3ZXAPp89nfbGNmbU4fHhc833UK5tLwUGDFL8Hp7Iku3l/lgt7P3F/M?=
 =?us-ascii?Q?kuUDoxGbctTN4jgoZ0wqmhRtTW0TjYhnMCoWUwxSj9Y91aW704Di92UI9KS8?=
 =?us-ascii?Q?lja8xuOsCKDaaQnZcKIRrH1pM7WwkNoLjt+9gxFrygNVNGmRi7d3ElUy9PP+?=
 =?us-ascii?Q?cTTs6wpSBtTQHW0lpRzWf0AkIfwO3Y1BysUhPxoGq0jXw94MsURWiEDXZVKI?=
 =?us-ascii?Q?ST9HAcLF/LzouQ5+rLPanXRc0lZ6QJZ629jNFiIWNAMQzoGFKvRERwBEER5j?=
 =?us-ascii?Q?ZqMBsxntsakkTz3bzb/e3qQGmBErNY9MNl2Ia9oR81VhvF3ZMt/az3Bldmce?=
 =?us-ascii?Q?kuRu2wTrEo7eHtMmgK1CR/BGmunTVPw9QKphyyewKL43dO+58GoJAbyo2cWj?=
 =?us-ascii?Q?HFDdEazwmYsrlgKFTSyW3+sex1tP0QyE/TFR610/XW/G4GZrYu6ORvPPwvIC?=
 =?us-ascii?Q?EBdLDMJ6W1zxmY2xLyYjPlq23PZ3xj64CGnWv3nHVRpuz3kyULMI4HvwGrkH?=
 =?us-ascii?Q?6jS5Jai+TsDsgqx2ujtCl7ug9WuAyi969AmIQYn2CPsuhLDsrqPE82x4uccp?=
 =?us-ascii?Q?VgpBLRskkRKwpC8tWwEw5wiyQA4Y36N/amC49tUq2SIMdCcXE6MonUNhWkUx?=
 =?us-ascii?Q?TPKvHexwT2W/0AgFirWp42o8sGFmzPh1A2056KA3YDBwQXv3S+ECx5rn/cRr?=
 =?us-ascii?Q?BlRS+6G4/9s5R3QSKGv0W5sbvG3uIPZl+eQQjh2qrD6JPX8sTu/0eB8F7aCX?=
 =?us-ascii?Q?Ik0X0x1WAWfQDrdlLRDkkkM3HoboKqjtW+cWqkJQa4TWdNg4xHOlgoNVIKfS?=
 =?us-ascii?Q?qcl66qmqBXLKjsyGKVG0r/fDVKloxCOOGb3D0FyO0f48rx/0ex3iLFqTkBip?=
 =?us-ascii?Q?MR0Kol4kccdmfMp1eyDeXO5FBWbjxkh6957cTXvVb/ziN51KPkh9VUNEBa2I?=
 =?us-ascii?Q?7hlX1xrocKYc/zBD6RDfp5AnPnR/8qpNeKoeTvsoOfMS4X7O7+oUfFWHIVsR?=
 =?us-ascii?Q?uJ0a+JTEi7MqZd8KabcP5mX5MSCwRBwC2AoR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:13:17.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48106b03-d408-4ac0-a5a1-08ddc37fd5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

Borislav Petkov <bp@alien8.de> writes:

> On Mon, Jul 14, 2025 at 09:36:04AM -0700, Sean Christopherson wrote:
>> Or as Tom suggested, return ES_EXCEPTION and let the kernel's normal machinery
>> WARN on the bad WRMSR.
>
> Ack.

That will panic the SNP guest instead of #GP:

root@ubuntu:~# wrmsr 0xc0010134 0
[   20.804335] ------------[ cut here ]------------
[   20.804336] WARNING: arch/x86/coco/sev/vc-handle.c:383 at vc_handle_exitcode.part.0+0xc1b/0x1090, CPU#0: wrmsr/607
...
[   20.804507] SEV: Unsupported exception in #VC instruction emulation - can't continue
[   20.804508] ------------[ cut here ]------------
[   20.804508] kernel BUG at arch/x86/coco/sev/vc-handle.c:123!
[   20.804514] Oops: invalid opcode: 0000 [#1] SMP NOPTI

Regards,
Nikunj

