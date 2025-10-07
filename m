Return-Path: <linux-kernel+bounces-843804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B3BC04C6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E983BFE13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D21E5B7C;
	Tue,  7 Oct 2025 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kJ1HiXqm"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938E273FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759817307; cv=fail; b=GOnJG9Y8idk0v4f4e7Y+7muQVuYbcEQKCDb862LM7Ius6MUsOE72l9fu2W3k648KErnLHC/Ka5uNmN1IRgkoom8y6xtQovTsezTOJ4PAPgstG6o8nIel7tSqkfbqJudfYGJ/geJzfWonceGi6VrtaYoCvLP3Z+DS8vVW7tMfLxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759817307; c=relaxed/simple;
	bh=Uf89qS06dvXIX+WBCOGaW8sCxotYIbLLneOJgL5nN8Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/P2iTv2rmUVyFoJGm64tvGQNjST6l6IMwfIAsA7TOPkREKcv+gjMd8PWR+LvOsXR8me3Gr19wVjbQVqe+ctXTkXJCNRTpC+rtehtoJp05Erh3ed+2JGZituM+s9wBmbXVxJf4Z4DQ50lwz0j7qjBoP4AwRRXKfSYa5/guVPQYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kJ1HiXqm; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiW6Jd/+RfODK54g2cuxNdsbykLqr9iCyecZzpNX9+rbOI9KXGLrdD58oLAPYOQrI73kdC0Dvh+vKdygD1gXd/f3RvjmJRnBIDRj0FM5lna38RK0Hc8u5+EjyBNfSqCKPJN2IedEJ1utakOslMqKr6VTFSgeT+TmE5+4vl38vVpNXzfc8pInCV1E6+sFHptsefvZpizTmUI6gDYp9OjjnmsifdN5+EING5+T2lxKw3JV+q3KQiVGA7YoSSb9BCo8NlYYsZVin5lE+FWatfjhQaWtDdgbHIHkOiXfApeQCsH1/sWr2EqYF0Vfuequ+hpfp6fyO8DP1rsRwipnnswNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OfYUQxzdRDcQneGnBUEfRRzDx5Lfkuwii42ITnYmUI=;
 b=FuM1Cie0dNDpXCHQVye5ptrzIsaoUQ9HJoozmDgtmyKPYfTu0WheBDBFEf90R1N9cpuTrxhMrJZwukggriiOYCS05ZUlUCJWUTVXUHUe/MHGkfmKtD4PAkOx+KIYrOcu/uyV5j8JMkE18zR+9mkLVgiWK45HmLWDWUKSGOgLtfjhZjbYTDajnCjX5OV1bMJx+PmeMhVZA5p6MnXxucr0WMq4/rvJFGSJY5gAhcYG8AqEoTFbYgHNsiEkPIjIRTSFuvmpkY9vhRIxJm4zjS2dcTN3wykRMhAJ6/p9VH/0nJNLoGtoetcjXYkR8ZBfu+5uH+voGob7IsK1uVk/kVbjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OfYUQxzdRDcQneGnBUEfRRzDx5Lfkuwii42ITnYmUI=;
 b=kJ1HiXqmdlxF/ilYMChxDbVNAdcqdEp2Xm9UD3PEooKSBqzPxMtO/aGHfPn5Wnpwp8ZA5OgRdQ6lThVVLxaSXy2AdvG6VrLW4t0FrdoOMUzvsfQQl6ZsUr5nb2k9flaJcm690A6g3BvCjs3d3508dXVCUBADsXGdLAsfVKPjwzo=
Received: from CH5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:1f1::16)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 7 Oct
 2025 06:08:20 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::ab) by CH5PR03CA0014.outlook.office365.com
 (2603:10b6:610:1f1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 06:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 06:08:19 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 23:08:15 -0700
From: Nikunj A Dadhania <nikunj@amd.com>
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <thomas.lendacky@amd.com>
CC: <xin@zytor.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: Re: [PATCH v2 02/12] x86/sev: Replace call of native_wrmsr() with
 native_wrmsrq()
In-Reply-To: <20250930070356.30695-3-jgross@suse.com>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-3-jgross@suse.com>
Date: Tue, 7 Oct 2025 06:08:12 +0000
Message-ID: <85v7krqm5v.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3a3ffe-d866-4375-bb14-08de0567e9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHIOpFM2LF2WkoTk8k+MlljJqlcQHi1AdpuH59jfsy8vFQdRLXbTOfXLnGK8?=
 =?us-ascii?Q?LylB/73nAIKi3FsFkp9rhpIHpNKrwD13R/gIs8GKt7e40cFjjVSZGeaZwjoT?=
 =?us-ascii?Q?6MrPhjTKXjcE0YlQT/AFu+ckgwn9XXqLTs3l8CIg6JgoEIFGGGekhmo8rUME?=
 =?us-ascii?Q?4NQCUG3+HPrbODv0UXihV8GwdhsV1RQP47jNUFfr3YM8ue4IOT2s5KwQa1lU?=
 =?us-ascii?Q?rkUgxfcnjn3msUGN9t0cVkOgGE9gZubTPZ7tWYX7FDh8ct6G8c7JY38weoSK?=
 =?us-ascii?Q?S/WNEXXY2Y7ZFRbDIIxGynctGYoPy4Ae+6hJ+b333n+JWMZXvOhQcplFVPNf?=
 =?us-ascii?Q?0YiBEpYHfoZkQqIPI2UjPcpItsdGalsfRa9dPExsKxYps2jJuj+kNvZ1ycqS?=
 =?us-ascii?Q?vpERLlFFdmsEXXWI7tM4tTqeSaVin/kl0f+bp/pcU1cHJea4sQmZL/Yz8FM5?=
 =?us-ascii?Q?j+fBzUX7eMQuvLk3bw56UTGEeLaKEIYF54QeLUevy+BzjlvlY8wtXhc4jTRu?=
 =?us-ascii?Q?sydw2ynBP5DsWtm+79TQfS4A4s+JSDPyEpJp9h4dMXpnx6RN94mzfmQc8VDC?=
 =?us-ascii?Q?Dpx7RVMQVKf1ahCyDMVHsOcYxdeWBibPi7/Otb4YbzD+WbOadtVIWN2l1uln?=
 =?us-ascii?Q?LAxYdHF14n1Sm8rnpvkeYhXP9nkHEO/JXlssB0AUg/IXo3tdkuGUEPk1b68I?=
 =?us-ascii?Q?jjz5gv4ipSnCuU9mwcX7ar4rZsjRNr/K8lq5FeoKqov1rMyHxlP/FbK31H25?=
 =?us-ascii?Q?QMBgJ1WNwLv6Bmb6U4TG3PvoCHn96gVTaDXEnxWGDfpg5wCtBm46+y/rbtI9?=
 =?us-ascii?Q?mivmb/I1uDiNraU/SiOiFKGhKGzaupPJhQ/xDCTMJiHSFUEhG6rXZyFK2nAz?=
 =?us-ascii?Q?xAlyJkY4IlUGwghX4k/HFoHzwewyxbH/dC+B375Ca35ybk/Hlchf0WS86CHF?=
 =?us-ascii?Q?ONH6G22cKImZMWVs93k0DD4Be8Pj2D27Fz3TPOi5mhi1rtVM9mjR0DrT16n6?=
 =?us-ascii?Q?GnrzfXELOcUcIgy5v3R9XIMREhMfXujz0s0OMXmpn9h3Yn2CUqtsRwBnDnra?=
 =?us-ascii?Q?mDnT2r6X9J8YYdK2MgXj2ruPWaSZyrZlf4vtiCMyssJfzcTH28Wu9a+ghBbA?=
 =?us-ascii?Q?Rh/0e47XkLHpHQagElIsptiSp3+FXu6A7+WO97uBJPMyBLQvdt1ixb7UE4gK?=
 =?us-ascii?Q?Iut/PRphPF3xFQxTXJ1ui77QFPYsZOypmraFKE+xG4h4V4/bwE66O5/HQuVG?=
 =?us-ascii?Q?BfAQblOiQdq03/7tPwdz2JBhiqQDO75FWBDcS65CAMvB4CNJek6r4WaOgRTF?=
 =?us-ascii?Q?g0lN+ScfSjY1bHbZtQgEVBIGaHr6zu5DRvRiNfg0KLjziOvzpWORYIG+FN0R?=
 =?us-ascii?Q?KXfx639g7XXxbYVCAJHv/+Lnzfw5C/rI+RCombtbE/CXXzko4NWxSYLVqB7c?=
 =?us-ascii?Q?W1Z17ZTMtoxDBXblwuAe3BDl8A3UdvnCLuLworrIsWxTLmC5KDwxuFQS6dMi?=
 =?us-ascii?Q?ALWJOVgOcSomK8QWf7IkOz2PmY6PKGw6GLZWD6NaeaULr0TffmnL3ciMDol/?=
 =?us-ascii?Q?AiwC6DgBxB4rDCgO9Jw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 06:08:19.6301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a3ffe-d866-4375-bb14-08de0567e9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

Juergen Gross <jgross@suse.com> writes:

> In sev_es_wr_ghcb_msr() the 64 bit MSR value is split into 2 32 bit
> values in order to call native_wrmsr(), which will combine the values
> into a 64 bit value again.
>
> Just use native_wrmsrq() instead.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
> V2:
> - new patch
> ---
>  arch/x86/include/asm/sev-internal.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
> index 3dfd306d1c9e..f5d6fb3b5916 100644
> --- a/arch/x86/include/asm/sev-internal.h
> +++ b/arch/x86/include/asm/sev-internal.h
> @@ -89,12 +89,7 @@ static inline u64 sev_es_rd_ghcb_msr(void)
>  
>  static __always_inline void sev_es_wr_ghcb_msr(u64 val)
>  {
> -	u32 low, high;
> -
> -	low  = (u32)(val);
> -	high = (u32)(val >> 32);
> -
> -	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +	native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, val);
>  }
>  
>  void snp_register_ghcb_early(unsigned long paddr);
> -- 
> 2.51.0

