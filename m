Return-Path: <linux-kernel+bounces-788431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B090EB3843F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619F5366473
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8996356904;
	Wed, 27 Aug 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OTcu6qo4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0235690B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303199; cv=fail; b=Zn691i+uC/urK5IYjiPiX/h2zsTmTJ9S4UYaQ06g24TWctQSyHoWppaTuyiZLfjf+j9ISHKVf0GlAKD0SMGlGAPQneKw/4pIlOdKobD47BYQO0o+vii6dgSCYbHZZOIkkX8VCOABdCkpdBVD/ltA38FOWLGu1R091IGGitycJVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303199; c=relaxed/simple;
	bh=0BA33ZsummWU4252PtSR/7VDGp+ngWjZbaTzTKK6YZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WJIeZFxDF8lMFQaEwSnzNl/sRflpkjQEGQmgykueEtfDKmOU7H66mw2cpNRrWWo1H4ffdha6PV4XhpobBvEVL4JXTQfWfMy5zXpxk1+RxqRQFdJlLe8pMVBCzK3raUTTvWjZiF4eMMBimGnvqiJqEN4HoXNGxLLoncoEVR3p1Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OTcu6qo4; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMtfl8ZaV/sAWiqP2AV3PllARO8engtEJxKYBWykT9lXHvO6Le+hgmJL1RmQPCW+QsvSgytHsoKEIU+2/6RmVlcsHVP58zUCeSKIiR3tEUDFEknREmbh8OgWoUu0KkLN+HIX6reVqx2UnADH+/Lc+NbqWu8zyYSCKyS25QX2/NCc4I0tF1PUCN7mBfIMfnPoKILgUF/weBtZWPK34dTl9qy6Teh4N78aNfBlri2qxGaD1KxEt4dv4NNRu+UahosETH7k2z+cDKjwA+RA7hA1p1kiNZR1ScqTV4TKcDUZkRj+BiAj1OGxqlUManMSRjKioM9sVwf6kwARKD5LsgEHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl9UBhq5Xzhz6YxyZDO6gE47MqshMlgfDdo4nvt3U14=;
 b=khLFoOYPcCSyQuOHOxClRDB5mSSgnJwtwrFuckbGdaR9IBbAD8DIZyhtVN0o1+BvgDZtOghzdwS6VA1H7F6nlpiQ2htqEAg9tg2tmAJKPxyv0ih7KCy5rWR50OYm/ikYr6kS4oI4kpo/diOQguHgMGAW5oz26pTjv398XpD2EycxHSjSFTS6nkv9heO3MXr0nuU7/zvHsifVEZDgfNU4wztJE0zOSPRcmeAZhSUxvOiSd1Z6+xXBNXIJ8Fqq7dcUjyslcJmi7gpVX7kVqmQc2ZMadUH7FiPttKKLL5XgW3dfmEr4qNtARUlQr9/pfMtWJ+7dhY/I60f2FjC++wtI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl9UBhq5Xzhz6YxyZDO6gE47MqshMlgfDdo4nvt3U14=;
 b=OTcu6qo4JRgl6bmkmHsWCPS7s6dfte2eC4+4Oy3rb7E1TVfULI3LbHjSnwfcRwCKLqEMqliRwjnBoMPihIrtEMFcJmJKFdW8kuqno7cyilm2awOZUX7YB58GDka++39EJ+qd9RL3WtFjshLqpIOnmDKZp3Ll0memdWjr871B+u0=
Received: from BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33) by
 CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Wed, 27 Aug 2025 13:59:55 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::69) by BYAPR01CA0020.outlook.office365.com
 (2603:10b6:a02:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Wed,
 27 Aug 2025 14:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 13:59:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 08:59:54 -0500
Received: from [172.31.63.243] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Aug 2025 08:59:53 -0500
Message-ID: <39e7bafa-652c-4ee7-80b6-1edb97640d73@amd.com>
Date: Wed, 27 Aug 2025 10:00:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] xen: replace XENFEAT_auto_translated_physmap with
 xen_pv_domain()
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, <xen-devel@lists.xenproject.org>
References: <20250826145608.10352-1-jgross@suse.com>
 <20250826145608.10352-3-jgross@suse.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20250826145608.10352-3-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9552ac1e-ccb6-4d30-da98-08dde5720047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE1kMzB0MWlpeXNYSE5XdmdEYlphakNkWnNFWW5FaGlOYTh2aWZtMCsxanlR?=
 =?utf-8?B?SERkcjVYNjN4SDgxWGtSN3ZLUUNLQjB0QzRjS1VWU1duR0pzbytNNm9JOVl5?=
 =?utf-8?B?YXJQMTQ5ZWovVXJKeUNIbmdidGpCMTdRam85b1FSVnFpZnBYTVBHUWVjNFhP?=
 =?utf-8?B?eDg5bmVWc3R0TkhYVzVEc01QbVNCci9SbkVBQjdLR1pPTGdQN2w1RCtsb1lx?=
 =?utf-8?B?S09OWGFVRHpKQXdvOXNiZzZscGRONWJuUXgycVQzcDJOZG9nTFdtU09IOS95?=
 =?utf-8?B?SkdJbURBZFRBeEJHZjVYMnI0WEZxNDlxOGNZUVZ1YTJIdTdDVkFWZWtRK2hl?=
 =?utf-8?B?NWF4eVd3UGo1RTdaRm82dWVZNCtxdnQySk10cDVYbEl2ZTZLTC9FMFEzQVFO?=
 =?utf-8?B?RTFaUW9nMVpBM1VqdTRRSldyeWVieXFyZ0ZPZHY4RFV0SXhpa2JodHFvd0lE?=
 =?utf-8?B?eTJuaWRGYVJVc3RBY1BrRzAwajRkZ2gxc0lzY01GZm03YVptQVB1Zm5oR0h0?=
 =?utf-8?B?NVUyTHg2Nk1ERFRzVzZybGM2NjlhU3FCR3lkajdKdGo2R3FDVFZkL2VqK0tY?=
 =?utf-8?B?Q08xUXJ5d3ZsdWczdEk5dXM2YlYyeUVhNXNzZGg4cE9WUG0wSHlDV284YnFK?=
 =?utf-8?B?QllqZGo2MXp2alJZTi9qdTk2Skt6Y3cwQXRLSlFjNjhvSHJjYjZneHBTdFdi?=
 =?utf-8?B?UGhSeXlGcXFQNS9wOUsvcDA2amVXK0w2SEV5Rzl5OWtKMUhVMjRweHFtTEx4?=
 =?utf-8?B?WnQyZDM0NEFscnlnWkZEUkZQRm1VRnpxOHJDQW9uRklpYzg3M2Q3Wi9nT0hm?=
 =?utf-8?B?U0kyZGVvVmpTeUZ6bDdTZWEzUFU2eUVnL0Ntb3F3VGV6dTZDaTlTYTRFSFJh?=
 =?utf-8?B?aVJ0SithTU1UdUJlQVQwNXV0S2pLUkFhcVVFUmY5RlpEZlMvY2tvRlpURXFT?=
 =?utf-8?B?eDhUbXpGTklnWkoxTmI1VUdjVzVBR29rN2p6My8xb3RhcC8xN3RMampNMTdz?=
 =?utf-8?B?UDJxSDYwL2hWVnIvb1BMNE9XV04zdkxvVFBCcGgrSnNUdGVZZkluZFpTazE2?=
 =?utf-8?B?NmxCV2c5aVBlanFobzY2M3FaNVgzcDQ2SDBhbUMyM0VxY0htcUkzUTdmeHRl?=
 =?utf-8?B?K1NacnB5K2hpVXF3ZW1IMnVLbEhJcXQzNE1qTDQvbC8xZXZhL3hiT2VEdkRZ?=
 =?utf-8?B?ak5yeVN3SmhheW1YWUxoM0VZSUoxQlNwRjNMVEFYZUZacWdCVlhKcTNvWHFl?=
 =?utf-8?B?c2s1bXhlMTAyZFgwZXUvKzlJSGRXTVAzWGxVS2JBejV3UVgyM1FpaG96Mmxq?=
 =?utf-8?B?ZmFOaWlBc0FNQzlTVFhHZFFwa3pCRUlHbUc1ZGUrOWtFRlhSVjVaYlE2S3Rl?=
 =?utf-8?B?VnlWOHhkNC9OTCtuYWZPSHpXNFlRaHdXaGt5NFMxQmJIRlRDaFNDd2p2ckhB?=
 =?utf-8?B?cFk3R3Y1eUZGb1pQWndDaFBuOHNtMHFOdStLb1RmRm5iQ3JGb3ZMb29VQjZG?=
 =?utf-8?B?RDNuU0dkMmF4K3Q0Sjdkb0xxbE5INEVnVG82NTVweWNUZlZnU3VmamZZM0Nm?=
 =?utf-8?B?Z0QwY3Q4WWZEcDF0V1QreGtWNFFXbDM4eEZTNzhqMGx5UVpaazFCbmQ1MHJ3?=
 =?utf-8?B?bitZMi9RclZDMTFVOFVBOVFZMndQK2U5dnQ1UlgrV0cyM2pYNFlkSkQyd1FB?=
 =?utf-8?B?SnVVOGlnWTRFQTFsaDI4dkFEY2VScUNhekRqOUZBUDVyR1VEZHZVTE51WXhv?=
 =?utf-8?B?NjdObWNNQ01vRjdZZXY3VE1OMFBIR1dpTGtzWWhLcjJwbjZMWUd3N1NUMjNK?=
 =?utf-8?B?dGhXcE80Z1ZZdnYwb2I1bVpiTnc3bUE4dTl2UEJJL2VQdzk2U0lHRHFsZFA3?=
 =?utf-8?B?VTJMNk1FUFdnSzkxRjRaWW1PWHlIUk9UOWJFTVlBdE40RUJkUUxYS1QxWXNS?=
 =?utf-8?B?SFRNd0crUXcvQWdxNktyd280NlJBQVVqVFVrNW5OTnlFMFpIMlhsSmZlYTNB?=
 =?utf-8?B?N0FZVzI5YkdaQ1RnNVQ4cHUyd3ozZDhocUxIcGFWVkV2RkRjd1I3ZURMMmpi?=
 =?utf-8?Q?MUHwAY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:59:54.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9552ac1e-ccb6-4d30-da98-08dde5720047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761

On 2025-08-26 10:56, Juergen Gross wrote:
> Instead of testing the XENFEAT_auto_translated_physmap feature, just
> use !xen_pv_domain() which is equivalent.
> 
> This has the advantage that a kernel not built with CONFIG_XEN_PV
> will be smaller due to dead code elimination.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

