Return-Path: <linux-kernel+bounces-767415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C931B253F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368671C838C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A782F99B1;
	Wed, 13 Aug 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOLtDGDx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0722F9980
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113557; cv=fail; b=QU+FdvVxjqPLf0tt8BU+wSTgoAGnQYR7p64opLOPjy6VzAqZRZCSWN8KnDPJC7onYdPBfNjuwVk7+/segDCJwDrK0rBjQXrpQMiAMhN1UYfM8jawI577Tqbz1s9qeLSzWQeRRhKQTBwbP38/YcazdtfcgggcdqFWm2yttCUkp0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113557; c=relaxed/simple;
	bh=LOUIoblLl9aJJO3E5IM6nWIr0e7xZzmm3SMUp2bFl+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YlX2ZxtlFKjeFt5Pyhkr6wc8YzvMMZYI98/6lJleshfrEq30oMoufUBD3Mu5vUzOfghoDxPO8Oa8sg+RGIjEf9JYxZWsKUlKAW2etvcTU3LAh/4bWYHaR7MZhvFH+WmHyFrqbxrM3IxSv2+mxmEMTM/BldMjE598sabBZRzNZF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOLtDGDx; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9QYMkGgcEFeYus7dEm/jAkzziByE0K0lRLfZrPzc0l61/bMgYbNt7ozBW5NPEdPDKghEsGih33iNrFfwuzBsqGaUvF7BgG99A4KhzFk2adrapeXAsDCoA0nFsJP2xQEzq6EFqWBlQ54JIm8GOV2Au/L/76txwDly+eJJrPOOBU7025PY15Z4qpYWh8FjLZIXHgkaUgOxgPLyHwfWp4b+Fp+kRDaN9Ty+dQma8pjOrnLC79Zv5gbasQSe04ia920y6gDiAzbqt5GmuUuVDVdVapTgqDSerXcdYAF3X1g0LhK7/Bi91XyX36giWRCDehFWkN8tD62135HIQRfVaLI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hieaLH02ehRivagRAChRIEyeg8UCJ1s305Jy8gkewiE=;
 b=h2E81P50JrHa5qJL0WN3wn17gC1QiHBCxRVCHU5tz9hDhJbokAjt7NVKQov84rnxwTj5cC2N+XBZGww7eLgHNguH+XYb+qQ+7P/1H4NZNZdOcWCAJKH+mdjPT4nVcaXrHvhwYpNynE6hAJnOghcCvOFBP4A5YozqcHZ/Y38rh+rhTK8BB/5Pj6ca1Y3dpkfp2lyLNsifvnkFflr1wkHklAma81FuJen7XB5yreiQicb5i5JSTqOcrldBfjc/7A3a/4Ly/zNPxVfDleBpFSMbPRVJXuf44V6ZNbd87Gf6i3+QLuXE1qFuXLIlmhUOjVQ2AHxvD/A0xdr272/L4Jkemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hieaLH02ehRivagRAChRIEyeg8UCJ1s305Jy8gkewiE=;
 b=pOLtDGDxGvAdzr5diTGFwIPbUVDOPD5FMO5ZkeOrtP9f5EI/XG2ksSEkf4D1C9UPFKWfXj89VQ5YFWqKglEi4xF3+ZbHB+8cCtCYQ2cf0niCA4bBPJDUjCPi2EalC22vsnPxoTr6SuCYYx2gyPGOy/FSxSt5Qc9NqG8ApgbUR+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 13 Aug
 2025 19:32:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 19:32:29 +0000
Date: Wed, 13 Aug 2025 15:32:24 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v2] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250813193224.GA52005@yaz-khff2.amd.com>
References: <20250723200752.2851345-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723200752.2851345-1-yazen.ghannam@amd.com>
X-ClientProxiedBy: BN0PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:408:ea::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 917834b2-623f-4651-3fa1-08dddaa02417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqgqPpnu0Q4bcHDERr0kYBuSfiXCAB0OIiMSMPhG/T6mabNq5xsPRUfOU7DL?=
 =?us-ascii?Q?64kxni3w6dQP/5pkdEl/2MC5vRgJe53GecvYJiBrrT9bG5DyokpEh6RuP/hX?=
 =?us-ascii?Q?pEKEFXMUXbQqc8iqL/hvB5dYvFgtQ61h5KnfMvG8MLhcsCNrgjV1nAv1VncN?=
 =?us-ascii?Q?ooWqGVzkNefQyJlv5Kz0DSW5Oq5xKi//dMOWzdQfnlTMwto50O9eYmUlrQON?=
 =?us-ascii?Q?qtIirhmxZQXiOm5OnatRNkx49asyeG1WsQUHp9QeqU7KpQ0LlzTwZ8WYLxIM?=
 =?us-ascii?Q?TZDH/q8EQb81CMdtj+X5SLY4nf2jDktMqGDs1I2PpdI8LqMqe4X50jYskI1g?=
 =?us-ascii?Q?aiA6DfgfEnvPdGsHzPmGJx+BTz1AuyjPKMTf2xqzpYQp+9tiq36ktAdmcwjJ?=
 =?us-ascii?Q?Y2umOiC1+tltnVdecEkkI403j5ExH6Cf5AXiNnMcoMw7SuFyVM28BDNYhyJf?=
 =?us-ascii?Q?K7k5DMg8Ae0XeUUaLs5bH/GX5DA8CFtPFDLa6O/2QC+hyB93L9V/Leq5zd0d?=
 =?us-ascii?Q?gLUHq7SXnIDrnfXVOjPpXXI+EanXkiWh4d9riZXus0qj0azTGK3FZhOYnIdy?=
 =?us-ascii?Q?86dn4ttQz9AALQcXn3LpofyW7D0X7AyEe9PF+iPTByiRnTdysiSo04375oEH?=
 =?us-ascii?Q?LIoE1T+d29T9tA1cQfYiSNIF0kcJgpR3N91JdaTUPfAW/jAvVMU+TELjxJF9?=
 =?us-ascii?Q?2yQQ07YtUR8Go6dp6q2CIYaZnrVoAXsKnMfL69eoGazLAbOMiCZZ2akC2VuW?=
 =?us-ascii?Q?38F6BIg2VBE84URXKHZYwdiecSFuCWngoegu76ExUrzbvrGGDWidFM9UPyp8?=
 =?us-ascii?Q?1xKmdirrKRserWQpc30dYzIQjX7fW4v60XzuNzJf2e2PylkYe5wsdsD4C/+M?=
 =?us-ascii?Q?s9/RICsT1rEdLxCqGzP30KCNiivOVuZdeYISvu+z1BMNdvHOXdx4MSoYAtot?=
 =?us-ascii?Q?0jNqX6lr6BK4Kn2J6sfqb/CpmEGh5l3+5LJBRkhlo9+//PUt4BG8QzJwQYk9?=
 =?us-ascii?Q?ddsWjLCuHC6fKGNc7BetfxEtBP4A1XbWbRsPm3/wLG4IUD2ijWhVjpOX7a/n?=
 =?us-ascii?Q?obFcjhq7fMUam1R7AhhI+H8utYSy/0Sh4cb5G6kmuznXnu/dOjbha6Eib/S4?=
 =?us-ascii?Q?2jhDEhhBjbbjSL19Yqz49mNZei6niMqlTeUdNQFIdGLwi1c8Ubb35TV+TVRX?=
 =?us-ascii?Q?/cSk/AapWrgYOu/7EIb3T4gAEX6MJg8NnWP7lMqAf56v2i0W4W8CWDzdCPp3?=
 =?us-ascii?Q?JxP8+tT0CCp09OKtEXXH/X95zUA61Ihs9BtUFY47hiVhc2XIqEbNtD4eCCJ4?=
 =?us-ascii?Q?4qdSY1UkatehHGH+A6IERuMN1tNRBZ75/MlKWfdpa2jYUEI6fExt2qw/mmSX?=
 =?us-ascii?Q?dWt10U11HZl62F7caB03I8yBvsW8q/Un0eG/ULFobaYJCtcx9xgeWtVPLk40?=
 =?us-ascii?Q?RxYpt2KWVNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duwV02a3ZOLSQABXihQ7UK0Q2plbQDfPwR2Bpq8TNhb+2eNUU+cA4L9E7HtG?=
 =?us-ascii?Q?4K9lKit26e0rNkujoofORgMMdLg51+GK2Rq6u7XYJXJd3rTOGT5nMlkKeJrs?=
 =?us-ascii?Q?PdwnSdDrm2Gix+0KMyM0fH1g1WTy0S9Wiuv7iduLQqFVM+gHMU46eg4CmA2K?=
 =?us-ascii?Q?nT1xcY8EVaqFyPlrSn0JUdmftbwf6AoFLwlzWuYgNjtkMZvtvdxi33Q6yRdN?=
 =?us-ascii?Q?gQLNRnKXJ/a2gt0LpL36aaqHAaRgvEiLEnPgv9Z8Oyp1p6b0/qmnj0zZ9x4S?=
 =?us-ascii?Q?mMT4agIrJX3Jqq447d484+p3x/Qfy9ivHTYF726AsyJJ60pEDaARnr0KSoLz?=
 =?us-ascii?Q?e2jOZn4Jtk2zDLO7c8/yUFUsfBSdRZ4p5gNjTQg3ycx99FS5QcNmyDCoyDei?=
 =?us-ascii?Q?nUaNzRfJQpGwBWC+uMRNOjR7FnpQjMQEgaMWWFbx2TlV4dm7nrAWP5LlrOQl?=
 =?us-ascii?Q?i91HxVnIz2nyEl8BQxFWlDcSvl+YHgyFPDA7Xi6AmD6K37SGniHx848uCae+?=
 =?us-ascii?Q?oRTyDMlMDR6hgHKamRx+HA7SnWb/n4rFSkMJXsx/PVSou6IYKiHj6R6hFLiA?=
 =?us-ascii?Q?KFE6CeEhJmxGecSj5TETKJpBIOxytOmkk7IQZISyHnNHeID5d29QMI61OHv2?=
 =?us-ascii?Q?QmOPmzcqiACEKZsbIWDBfq+qRCioeXaAx46wixSoPJNUFp+ZmWOQtd3fHK4V?=
 =?us-ascii?Q?wDeEN2NCq/3zktDGYxItiWGUBws7uGg8jE0I2/ynpwmhWFvpbWXMNyjlFALt?=
 =?us-ascii?Q?sEWmqI9J8iSngh145H5N81pSk/oucnCi7eW6gjPZo2+h81tujuLfmIVaf5nA?=
 =?us-ascii?Q?gvDg02CeJcOs4N69xd/4gQocNL3YHq77WqPDNCF8sXNIJjRTnEUKNjkGdlQc?=
 =?us-ascii?Q?iimV6bW9JdfNPI3HvUws91a/qVhIyEgrpEssRoKdP+E2dTEt1auWJBscm9w9?=
 =?us-ascii?Q?MTht2gaJICon1y0foFPYsoXIgo5K/F0RPESZGBXUW94oasTz5iyWBIUiMXyA?=
 =?us-ascii?Q?pHIDfdFqnem+YIid834h6hwKrlk9vhAgCCNanjLC2D3ktEm+sc4z2ohMKG0W?=
 =?us-ascii?Q?cjX9/pQzKC5FoIJXaHxkdgZZ3hOzppfbvWH6PIIDfmEOprJZmfbHiFkN8wAA?=
 =?us-ascii?Q?sFq5yI9W633S6TQ/oYgOtdFRJ9fnXCLe7p3F1jFiIDps30BLg5B4Lwb1Uqm7?=
 =?us-ascii?Q?NCHsmY6bwIVsgcHnpKCevNPvfvZwSEBCU9pTQc4+6sU2aHM1GDDkiFS9RIFl?=
 =?us-ascii?Q?TsBYz+lHApe58W2MalZRzQEqfH1SOz/ZMLqCLbN7A3Xez9uIrTAitbA7F8l0?=
 =?us-ascii?Q?Rr89/mbkRQcux8w6jZRypAND2PHRubsV0unflWXCJfvL71S9b/gtBP4ExNp/?=
 =?us-ascii?Q?7Y/dI4OMrH3T3/WfUhTOZIJP8RT+i9jMp6G2ar1zg6asAQR35mz1uybVCzWt?=
 =?us-ascii?Q?pzV/L2yXDE8/PcpOHa0YZwBEA9zhsLJc8PHdgzEufb+ZoAVUVEgzQzNaNjN9?=
 =?us-ascii?Q?mJG6iG7fN/1y88f/4oaCsmJB/bFa4Ad2JFeX6sSgNGnQNrrtEleQPIUoLej3?=
 =?us-ascii?Q?SQ8TGRlmyi6wI6mPNvE0guGJSxyoU18SXGXJN6er?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917834b2-623f-4651-3fa1-08dddaa02417
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:32:29.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dNxDdEcT+xPyiVbHQZPQKDO6LZ1hqyls6MSMby8mCSKZY1pghDk3W8HW4FqLODmaJfy6aStGz9JwQ94gzuFrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

On Wed, Jul 23, 2025 at 08:07:52PM +0000, Yazen Ghannam wrote:
> The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> commonly used error response from hardware. This may occur due to a real
> hardware issue or when running in a VM.
> 
> The user will see all reset reasons reported in this case.
> 
> Return early if running in a VM as this register is not emulated.
> 
> Check for an error response value and return early to avoid decoding
> invalid data.
> 
> Also, adjust the data variable type to match the hardware register size.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Reported-by: Libing He <libhe@redhat.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: stable@vger.kernel.org
> ---

Hi all,

Any more feedback on this?

Thanks,
Yazen

