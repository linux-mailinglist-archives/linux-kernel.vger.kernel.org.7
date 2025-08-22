Return-Path: <linux-kernel+bounces-782464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A6B320B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EF8A06630
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3BD305E04;
	Fri, 22 Aug 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qwm4Atk6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243C2EA49A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880938; cv=fail; b=pn+MKSMxSH3JE13oQJYw1oH5yu2p0RyWY74MlMslUXwYMv1X5EpE/FZwYzcEhfdW2PKMB8VdL0eFfCSPBEgUci3lUIMFtCjO9uuiClRD2pW+Tr6fUmGThR0uEg0c8lyDwDyE5HaECwphLiTZm8F64vl4dyUgnDxktR1GhX3XzfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880938; c=relaxed/simple;
	bh=+LlQggGIot8ZwLe/rGVNzfuwhSX8ksrZxE7MbWLyE/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzltz+z3I82WzjDYwB742G7Cr6V0k7HpVTcoEkodtQL7jOgfDeoeZnVY5GQqCSWCg7FTii5xLFI92AxsJ8lpCrulKVizqIXKwVEs6d5JO8osSntV6Xy6t4rBEgu2Rp4uxtnqEG013NbC2VxwikBGaUndFjHCaTE3QLAKArpvtiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qwm4Atk6; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm6DYQ/UV9Qv+L49hGTvQQlc+hyHQ4q+sBkO+E/T5wUGdSfAonxYUk8NLsA38jn9LbcRg2Lv96y+je2w2RyukIRSj+XZyykWtzZDw9gQtux0JFciEqiwxCe1MPwNrjuxmLvCUBmR4GpWlT/U3r74zAzEjLTV57YZVHvB1PYQX+617HR2wtS49ZdyH0NZ3BJAMt5xGa7ot/D4VL9yGHsg1bKYaORaPD/8UUtgrSCi7scvS2cKojmBGmc9A5w5W2JDNsch+hVlv268noeJJEgVQStdHS8/RScsWagofchb24FLij3Q7OqV2kMrduOYZDOGuYLovljbBforjG1HTXPvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E994qr6YvfDZn2hVSBEApOB67HdCdeIBqUBypviInHk=;
 b=UpzKMPhyEV5fpZ1MlGAwloKri2NxUYCbxhWf/28KblVvQL1wbZHLjiJkWGPKVA6hGxRpMN0MMj6xVHadBgQO+zwjgLRSbkwH5hPYPvfBIV6H6vtno98UqPPanOuvpLjRV/g7e8WphLLie1Wyhc9Hiz2u1vIddndb4cPTN6vAN2YIQ2vWsrd9tEAgAHr6e0LywXeaAh5mjRfCBcQsDjq44+4VMIlRFIpSihNR924x44So77x8zzAcy+ldtLPH4jqX51SCCNYs550+lZpNbU6k6MaMB5tOdkQ9mHEzkfc8dojH4ZdSbxf7qH+N2/4yfk0D2yxHqNXlmUn7P7MQacfZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E994qr6YvfDZn2hVSBEApOB67HdCdeIBqUBypviInHk=;
 b=Qwm4Atk6gHmsoTmLxXcg3/0ADvX330usn3ApMviqHx9IJGsfg1J1DR7xScgCoaFJDk3sp6Ct6OiQ6Ye5KvsjS+q1K6LvbwfBvriGKMgF7I7d4nPTBnpKVXPg4KFyyxdpFaWiaklnaUhzuDBB/8RtAQ3rNpkYoCQXnW2B4q3pHO0=
Received: from MN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:52d::18)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 16:42:13 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::f9) by MN0PR04CA0013.outlook.office365.com
 (2603:10b6:208:52d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 16:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 16:42:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 11:42:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 11:42:13 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Aug 2025 11:42:12 -0500
Message-ID: <09906ca7-62c7-2ca7-5436-662a6c4b19f5@amd.com>
Date: Fri, 22 Aug 2025 09:42:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
Content-Language: en-US
To: Min Ma <mamin506@gmail.com>, <ogabbay@kernel.org>,
	<quic_jhugo@quicinc.com>, <jacek.lawrynowicz@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>
References: <96e9e5b9-d7f2-4527-baf2-f7519ffbb612@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <96e9e5b9-d7f2-4527-baf2-f7519ffbb612@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 3863dcb1-fda5-4361-7191-08dde19ad8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm4xTGhrTjBRR29lV3NhVW1mVjFybDdsVGpZd1Z5YjFhK0FpeXZpQndQOXJv?=
 =?utf-8?B?S0tpNXg4R2dSNXJGSFhGbHd1anpIN2t3aENRRmFuSmVuTHpscXVEZWdwaGRt?=
 =?utf-8?B?ZFNtK1R1ODY5dnZibkhFd3NWRWM3ZDBwZmdCSU10Nk9XNUFjc1l1ZGJpaWlR?=
 =?utf-8?B?cUZzUGFZcWpOaGJMQ0ZsWlNEMkZBbUxtdXc0cEtKZVBIdC9PdndkbUpneWJO?=
 =?utf-8?B?TjZKUjk1RGs5bENPWjNiV0lKUWtZVHRvcHlCaVN4NVhQNTJsNENpMmxtclpw?=
 =?utf-8?B?SEFJWGhNbXluWnFqeGpvWEZFeXVHUUpHSXB2emhQWEN0WGhZUXFqZFliTy9B?=
 =?utf-8?B?U2k5TGkwak55WFMzSGZrNnA3Y2QzdFhEWE1rVDRlRnQ3SGhJeTlwRGZkVE5T?=
 =?utf-8?B?TTR4VTRnS1A3MllsRm01c1pDOU11ODQzNndBcEVQKzd6elJ4YXRUc0oyb1U2?=
 =?utf-8?B?MzgzSWI4b0UxZEppeXdpL1UxdHNlc3lMdlVMcWR1QWZuR0VHMG9Wbm1INmFH?=
 =?utf-8?B?VHMzTHdDNGsvWEdvZTBvam03SGtLc1lmOHU0SFRsN1FObE5PaHpyekwvZHQv?=
 =?utf-8?B?b1NObnZrNEN4Q2lpanliSnF5Ui9DN1pkYWpiSzZYMGw3YWk3K2k5ZU5KK0pi?=
 =?utf-8?B?VzRSQXk2bUtNK2d6Sjh4OXF2Y3F5UVphQUVFckpPVC9IeEJWb25USnNzcGVy?=
 =?utf-8?B?RnU4K1BraVVvNEpyQkI5Z0UxeC9XSGZSQThneVliSEJjcWkxcXo3dGllc0ov?=
 =?utf-8?B?T1RYTHh5OHAvNGY1bUxTc2hNZlI4KzlSTlYzVU1Za0VvNDZZNTg5Z3VpMWZx?=
 =?utf-8?B?VS9ZK2Zva1Z5elFPK0JETXZOY2ZkdFNabDkxbEM2ZzFYQ0xPTnl3OElUUE5F?=
 =?utf-8?B?UmZqWEpqbE9iS1p4MVdBTTIyRU5TSmx4NURjZ2l4WTQ2QmVhbmxsaDRobnJw?=
 =?utf-8?B?NkU2NTlESHRsQVJ1UnJUZS9rK3c3blVWcDhsNGl0QWhqUTVHOUdhUnBXSkJM?=
 =?utf-8?B?dXRla2txUDA4QWsrbHBZbFJGYzc3NGtOZkYrTmpZSGxjNjB4bExMY0xickVh?=
 =?utf-8?B?ZG5vOVZmNm9yVHpKUllESTh4VCtaTWN0aEdmYUtZWlY5YWZYUWZCdWdIcUJo?=
 =?utf-8?B?YlNOS2U1QjRXWlJLbzlSSXhYbWl2aURWOFE4eUlFMW0wSmtkQ0lHUW9oSW5o?=
 =?utf-8?B?TmtGNnptME9XbUY3MUdkTkJacnZWc241Tm41MkdmM3ljM3B0VDVZVmVpSCs1?=
 =?utf-8?B?TEZYMlpMWTNId0FSTDF4MHdHMUk4NVVxMWFtazJGRkl6ZDBmWmw1VzgzNHR2?=
 =?utf-8?B?QU1rczRFWUJBTEhDWVhmMWNkajA1eUsvRmljM0NtWUpYOXhPbTdvaHpkUmJ0?=
 =?utf-8?B?OXVhOEVMV3A3d2pOcU5hRk44YlM3eHBvRXU3b2trcU9OSk1OTGcyanpHWi85?=
 =?utf-8?B?c01mLys3SW5kT3cwRVBxVDM4SGVHVVBWSWpEZHE0Y0tvYUVkOEpnTHpuS29h?=
 =?utf-8?B?NUpSQ1JzQjVIU1BMazd2Wk5MOGdKWVNJVkZpTVVoYVpNWktxRkJoT2NCMGp1?=
 =?utf-8?B?bXhLWjdxLzdnSHQ5c3p3SUcwUnhybzYyZzZPcUliWU1SdU0wcXI1bVZ1K1h1?=
 =?utf-8?B?a0pFOEZZcDRBN1hpbDFZT3p3a0VTd21BWDdBRmdId2o0bFg0Y0NlODQ1VTRk?=
 =?utf-8?B?NGRLdW9heXY5VjBsakdSUE9NamMzSUtPVEltdXR6UlFpcktpSWNHSVY3dHRi?=
 =?utf-8?B?aGozWG4rb1VDalBlZkpiNTQ5ZmkvNFlrMjF5TFhhVFUycnAyNHhKNVpBdTlq?=
 =?utf-8?B?Ry8ya1N3NlhDUHVtcGpJVFd6SUtUSTVmL0ZRQkd4c3VlRUdVRy80dm1oSUFZ?=
 =?utf-8?B?UldsQTRoaCtPb1kyRGg3TlAvNEU4ZENWZnVxTkd1MUdCci9mSDd5MWpnNWJ0?=
 =?utf-8?B?RWVFZG1TWHdnN3dUb2pqUUhxdlBLK2w5NGlkdHlNejVQdXNyVkdGVEw4L1dn?=
 =?utf-8?B?L1NOaUVBRGFSTHNzUGlxVlZHRTlIOEcyeXNqZXZrRHM0MHNCNjFSMXNRTjJV?=
 =?utf-8?Q?EHlGzi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 16:42:13.6693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3863dcb1-fda5-4361-7191-08dde19ad8ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

Hi Min,

Please fix the patch and make sure checkpatch is passed. I can not apply it.

Applying: MAINTAINERS: Update Min Ma's email for AMD XDNA driver
error: corrupt patch at line 10
error: could not build fake ancestor

Lizhi

On 7/22/25 23:38, Min Ma wrote:
> I recently left AMD and would like to continue participating in
> the review and maintenance of the XDNA driver using my personal email 
> address.
> This commit updates my contact information accordingly.
>
> Signed-off-by: Min Ma <mamin506@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10850512c118..6eefa494000c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1231,7 +1231,7 @@ F:        drivers/spi/spi-amd.c
>  F:     drivers/spi/spi-amd.h
>
>  AMD XDNA DRIVER
> -M:     Min Ma <min.ma@amd.com>
> +M:     Min Ma <mamin506@gmail.com>
>  M:     Lizhi Hou <lizhi.hou@amd.com>
>  L: dri-devel@lists.freedesktop.org
>  S:     Supported
> -- 
> 2.43.0
>

