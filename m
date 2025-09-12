Return-Path: <linux-kernel+bounces-814733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC4B557EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD433A15DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E528D830;
	Fri, 12 Sep 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvgzaQG0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAB2D6E56
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710196; cv=fail; b=u0KD4+d9KA78RDko3FCwJ8RQpin8LsYv49Nj55wt4RioiNgDkuKPL8LdVW6sCsHzT6l334AhEIBAsnFuHyBQvMOp/82SJVGxCEtKzdP2ozIQB2ChvsZf2L9HXlozM+U9r8QniQVotj3KdV5HTK/GOo3NOM99IfBuGJuPpMJZZhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710196; c=relaxed/simple;
	bh=/CFUjaCRxGOAkIFFBxkoF8bhNsK119p7/sB+NfM7Kuc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CruwUVE4R9DyWC2j1Py61QE16Mjdbw6xQ18YIS5X2FuNxKsCRkvSJ93JodiOMDzVN1upDWekM1xv7jPYQATCyuwM/FMY5CweranfYx7kg/9oj/JNwcMxWXi8xYIcir15hIbm1uOFG7Zewxt4ItmPFk2fpncRPIec6dOXYbWGRwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvgzaQG0; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmrC6W//qlsL5An12zmvYniKBDGcXKX//QPKPm8lTg0DcCT2/75JY5U2zn2DslTYOJx1aaJ4BlfZIj/6j+UQ3+O2HXlKVI9s9riOmdDGqHVcxwn8uSkNvUBisNubD+9zagp2mx0uB8RITqC9AirgYyZa4HI0oHFN8gBCwhlSwszrXWieoInEB02vC7YEn178HC6O1GXtEYYofzTnPWBGc7e9zh5ByqKkVjoPq0WDYDMoCjtIMm5m8+np7C8ZF7kx7XbKm/sr54bxqPwZL95o3dsi5XKf40njWrupYqedDhLug3AKryLimuqWt8IlfWbSiOiwRxgtTUSTFyZF7wn+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCx2kebGIs6mi9+ROPxK1sE8IdgFaWRZF2tW5bgVRQ4=;
 b=e3aUISwoPlztC+8BU2Lj+xWuJqA9sVorrZKsuAP9CFhcW84FiWdcE/j68oXSt/olLAjsx5UPH2iw6xv2pJR/XnEYrNVHnMwUeFpi1olFCUAH54/LWrtx6uJqNYh87KnLGAbPsad2YuUANm1YE+bHkOfqr4KY3yreozYUFom9mD8Sa/FOLsjUYCj/p3hNgDRprpb+7tCLr22byq4XyWGoW3o5j+4jfU3KaykHQTEPtiTKn8BCqFgXBdEH3yn/1QHSN7a1Irkb8nMqay37DX0Uc8LQTBY4U1BruDa9ihZne4v0gPc0JnH0RYoZ6WNddqut30kzZEwxyiMfqctXFjfVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCx2kebGIs6mi9+ROPxK1sE8IdgFaWRZF2tW5bgVRQ4=;
 b=gvgzaQG0+M4SDI0glaTOd3vKaZ2/tjdp4WlgcjGMP6NJYYERGMZuzbdmFxfRZAWzPUv92b+PNXeB/lLMQHdbRhvMzcvC3kmL1jYS+7mCRJD35b+WQ3sLeI3W41KMqqJ88igCz1SQ0zK33MxwGsT8uU+ESGOzhBkdAJNE11VdU+Y=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 20:49:48 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::d6) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 20:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 20:49:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 13:49:47 -0700
Date: Fri, 12 Sep 2025 15:49:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Sean
 Christopherson" <seanjc@google.com>, <stable@kernel.org>
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Message-ID: <20250912204929.pls6245t746gtalr@amd.com>
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
 <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: cf644ed2-e12d-4dd1-9a34-08ddf23de9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdoX3xFo38q1k7hFfGDfOVFSPcoLYmGZx74hxknZZxPWEa5mTk0XiMi+Xkdb?=
 =?us-ascii?Q?gj+ogUvzvzL2h7hussioEwlOjuMzacFesHbHGswkWWhEsepSk2Ib4nNeqsev?=
 =?us-ascii?Q?e51txw99SIQq8YJYnbyVNzHcwFpZ/NeJJkziWnJxHMTsBEmQaUY6nQkjAGM5?=
 =?us-ascii?Q?5BpUBZPfqdMiqWk7rgMH6AjsJ0ORw/IYWMi6zoCQeyoSuVmHNTpe1t59bXm/?=
 =?us-ascii?Q?P2/vTDr0BmRjtyykEYcr8f4uD1MT839ZW0vBpHqzMlnI9KcB4idKaSxb1J1I?=
 =?us-ascii?Q?kO0ID17ZovLAW9K2IYu3n6cV6EZXX9vhhGgvZILjDZw7SL0RtAzOcTC2xdkz?=
 =?us-ascii?Q?wPAXdCUFMq6JqBua7LIy6AtC00ZkH2VX5ZHQZNxx5s9zzJPpxU7q5w5uvwQ9?=
 =?us-ascii?Q?2X/vUW59YXrGsmtrR4wDoNe45dcv0+mMtfXczRABRctHHd0eRqGOcHmFq74O?=
 =?us-ascii?Q?QJmX4Ce5JYDBW4qwRs/2PReCS0oPvizviNIGvxdgHQ3Dcv0JWsK7+59zSMR4?=
 =?us-ascii?Q?Vxk+MBMkGESAVTzc00ElpwubXD7zFfpmg4m/UI3AhFocRFUw1Vs/nkqKj9gx?=
 =?us-ascii?Q?/43z8fD+HhtoMssODgqOJ01wkse2wD5PdH2DJKG9LEyXkyGIWjFcu6rAsI8s?=
 =?us-ascii?Q?BxKl6UhByWm17g/D7q9n12L5954kCwaObKa+GLNdjEB2aZ1dGh4FsnmDk5k3?=
 =?us-ascii?Q?KGECFIw60+wKqzMae/fkfOC9V42BpaNUNpTsAmW4RQIzNTYFP3nLjqvnqJbq?=
 =?us-ascii?Q?kdLLWEI8bNcDhfVUmibFvffExSnwTXScVCOj0Qbp7fU7DzfHQ6UwvenE/S3d?=
 =?us-ascii?Q?Psso23YnvgBSpDqCOd/WCJT69IXrA1gm37Wel2dCfHVOVeBXEdfjzXtTk+1Y?=
 =?us-ascii?Q?zPQsRuErcBHSrYeenRocpRpLfCRVSbPtWVii/qtu8ZuwucKYfsrq8Zy+YeOY?=
 =?us-ascii?Q?EQp8GXXy2I4JTOr3/MG/oFXvNyYDa580sqUKaHmkw+deAEwUiDlq8EZS84nC?=
 =?us-ascii?Q?w+llvd1xJSRGwCKCabbizen7fqSwHvfEG8+17pP3+mUfwCiNuoFGiB2c8HEM?=
 =?us-ascii?Q?5fpIAbwdIrq9uqR4jnvx/luLNdbsCnVt9ryrK6e0SAW/e3VQFpbVymYfg7Mz?=
 =?us-ascii?Q?ZDZxkePSqQWlv/HL2BqWiH2Op59iDda5XxT3ZyNJoVNv619WfpvDMTXwTptG?=
 =?us-ascii?Q?QOBoWUx6cTl0Na9YKO6XUVZ2o5bEKKXHkgtk0O2+wFZWh1Esf4vEG+bd2ru7?=
 =?us-ascii?Q?WiBry6ItJcx2ZffMFe09RS0vjfg9x+8vDSGtVYhXFupM2K1JBwrNzIV1sk9T?=
 =?us-ascii?Q?7WL+XGevMapyfEpU37UakptdeAvf4fe1GWkaKzR43aag1FcYwQgbTSqwzKXV?=
 =?us-ascii?Q?F6A4d2MGHJJq7lqqx1MZRzfBB0DkLkjyolPgXjeGZ0ZS41J6roJJgcuMO108?=
 =?us-ascii?Q?E1PO75RP5hyu8ZuOH1aPo27k//TKwbQp1zgbVVD87OD06iTs760rmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:49:48.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf644ed2-e12d-4dd1-9a34-08ddf23de9a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On Fri, Sep 12, 2025 at 10:42:03PM +0200, Borislav Petkov wrote:
> On Fri, Sep 12, 2025 at 03:29:19PM -0500, Tom Lendacky wrote:
> > The sev_evict_cache() is guest-related code and should be guarded by
> > CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV. Move the function
> > declarations under the appropriate #ifdef.
> > 
> > Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
> > Cc: <stable@kernel.org>
> 
> Do we really want this in stable?
> 
> I haven't seen any breakages from it...

I think that's actually the concerning thing. If someone built a guest
kernel with CONFIG_KVM_AMD_SEV=y they might be under the impression that
this is performing evictions when it's actually just a stub function.

-Mike

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

