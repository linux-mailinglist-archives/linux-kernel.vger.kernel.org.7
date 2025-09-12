Return-Path: <linux-kernel+bounces-814720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F958B557B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355155C3655
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109532D5432;
	Fri, 12 Sep 2025 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ljutO9o/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C52D29CA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709585; cv=fail; b=oQ7GXxMIQi93gRSRwAlzlJeIzfC5KmxE2AbLc8kasxrKjp/jKji71TRDcihs8QPOILTP7qMGuHNp04mzzCDWshvcem8YKoJMjpiRcwlF6j6porG9tB0drdhrHJVJn/OgfdfK3bo7MtEeF3LkiMTMl/be6u2VyaNDnp+XABgmUYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709585; c=relaxed/simple;
	bh=uG+vHIWckJae1Cnj0SFF0Z8A8QRMQv/eAQD9F9A4zrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEStzm5mtjEm2+kUq6RGbT4sM2z6pmq/Eq66EFoEBeHoBdo5rMhpz6Quq16CD/6Cnalz7tAgih1YKmnAjkHIVIsEDMe8HenqF/7NctWG5dRucpuNV3uXXQ5lSwvEinnVQA6JmV4G6QcSzt9jl2UOOTEIIVR3XZAdydG1ZMENRu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ljutO9o/; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqJ8FxK6+7Zhw5AHxxHdREiuLZyynWZl9uTWJiR+1ONh9BjCr0CvuyCwFIafpv9eBo1w0cJhTb12LDPWLpEYElJGMH7j/3cEtevQ+oaRXX9YArLsQrpLQv4ns0Am5XBoy1bVC3ft2M6pHnqdqAKqxDKlIpy/19Xkn1iV/SkaVVtWGmk1LH1yAn0HIxbW2W9m4NRRfLYGJ+ZG+qufLAIPRmfFR7EDzFu+Rirad1fZKNoJMALcBEDNG2YSiUBDieg2DqFjH6NUnUjqdzjsaSYPzo3aHv9nIIKXhZIUu/LHDBTe8suULpUFnOzwFRPbBqqZpM7dYbbMYtCV6OfqrKzv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENNsci6YMz/2nPwVgUpJT57lvg2z6D3F3Fb7jUWJHu8=;
 b=s/VEe0MKAurA1Er0r1OQtSj5dtOZutbCWejd8s3FHSt4oj1JNmEJsOm3hezQYQwKQnZSyCqowW1LjEHTgp60MyXkH9R9X7AUrYBdOxPa0qNBunzW6aiQkHpB0o8BJ5o/KjZnG4sjTGMeL5CXIkdbogHxtE/6JPCE1W3HWdzOjYhavDr9mFXRY0RWy64TWapDg/CFSEHNLvW0qI32P/r5q5Ph7VbqFbjlCQbGy2n+VdXf2A5IjoW4sZTx6S2MUMvQGAkwSoPjuw1D6RZPTvyvlG37INqBm20vlxrGbJ8QCExdZ59jx2XYXfKliFRu7v3+B4nL/exkr90c2Ac5YJkaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENNsci6YMz/2nPwVgUpJT57lvg2z6D3F3Fb7jUWJHu8=;
 b=ljutO9o/OSEJsPWCwZYceNnjgU89838qYVnr2LP5RqRUQq1XAyBCPvSCtagqIt4mhNK3+kLSQV1FKWooXddr5oKhbC9j0pFVpdgrb9OelQuJBcFysUj7Cza9tPYmhtOt9mKk33jQkNNDoS3MFt4rMOgr3EJ4GB9z4aViFUB64mk=
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 20:39:39 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::a1) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 20:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 20:39:39 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 13:39:38 -0700
Date: Fri, 12 Sep 2025 15:39:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Sean
 Christopherson" <seanjc@google.com>, <stable@kernel.org>
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Message-ID: <20250912203917.c7p7tavqydytugmb@amd.com>
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bac9602-8d28-46bd-c0b7-08ddf23c7e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JY9gtaVeoDGA5MOp10meynRwRuA8wYnAsnOdYX2vqpe+6oH3FLiONrOZpRV?=
 =?us-ascii?Q?r2W6OHHxYQ1Nwonm19A3ajMTKUDRCdufM/WEWlMTJgQzuS5pitkrCFoBHLEl?=
 =?us-ascii?Q?IiEwo452dy6Dwq1bM7WxWXXMBWAoqgbEzR9p7CJYQhvn6SsEV+b9HIW8wnUG?=
 =?us-ascii?Q?jnjCB7hvJSPqJ/pcIxZaQWrPr69VmXMlLkRVFDjxkvvHpsOCOSOvd17PYYUa?=
 =?us-ascii?Q?wAPKZnja8bhTOIIp8fGh5G33EF97y8HFtUCdNQPNnxS2IBem01piXUaD0JDW?=
 =?us-ascii?Q?QwiVM/nJ8CFNG+eePGBK14VkbkvkZ4IEzLV9xrnv7OW84XfQNmAx/6pU9j5S?=
 =?us-ascii?Q?dybT09LV3og+A9mEtBPOOCoVuyXwN5rMaDCcy4AYulPtPLw2dVQW0DRFVj9p?=
 =?us-ascii?Q?hpBirNnfzrRgGnhEDJJDh8mKSyp9nMT2rqBmxcOQ6FxzMZf/JlKr8AxZBxTH?=
 =?us-ascii?Q?UgEjsGIIaUa2v2mk5EwFPee4x5wQ52LSfKl7tjieMZyD9Pp0xGGsonWAbw06?=
 =?us-ascii?Q?CPBgLhPh2fPL7u6Eb6npsKVC+Jkkf/BZn83tX8uXT0Ld6cE/gw5awZFEZnql?=
 =?us-ascii?Q?6kvcdd5Kl0cdqoOsrZov3WOoXW74D1BGNdkS1j3JwvGzdM1GaHCSOdP9/IQw?=
 =?us-ascii?Q?ZSUN5LXvq2IziOGNWNOx8P7NwqJeqlea1HesQgBAj1TsGeG/7ZE/FO2EWj3F?=
 =?us-ascii?Q?mgvlnfHA+VjDSPxPvFljs90rNP1K3O17aaYqletUDVrfK72R7UJQFTFPONm2?=
 =?us-ascii?Q?Atu7M2Mf8cCBBBAoBl4LzMw4qeAP7Dg11TURgfoGBQd6T9dU26MZmrySmKai?=
 =?us-ascii?Q?zxZt/yZt21Ca5rMRFGAPA+DFAouyz+PkrUSV5bdHpyMmvpMHo8SLhWg3Ai8o?=
 =?us-ascii?Q?P3iJ2P/xO6tZqkQDHjsxIJGkAZkJ0exxVK4G2w4hutbW2sk+6nUVqanAZ3hX?=
 =?us-ascii?Q?2s1hUbt2+6RSKfervxxnNERecsGV+0FWLI3489aVMMGrJQ7PmlQNnI0Zug1+?=
 =?us-ascii?Q?cWI2LBODTG/wu0StG3fNjT3CIqk3Woi3dyLC9ujf9LPNh9Jg3EgEmTHEZ0Ah?=
 =?us-ascii?Q?NCspBZAaJTo55kRwi5v4WjansyaIHo2GLC30p91tgRWasRYjw51ARudWCQLO?=
 =?us-ascii?Q?4tKDaSPB0K3/tnbfI027SUreB71F8KQr3YKy8w5OvlHHx0VrfN0Y6NLX3RQO?=
 =?us-ascii?Q?0za6G3WW4FdR4GOqbmgKYgjr58Pn04A10nTaTPT+pi3SPAyoXNIxi2Osj+YN?=
 =?us-ascii?Q?bcWDm5o+L2C18lkw3eByFceJL22Zp1WksO8P4UssZPjhr2i53LIKs+U78qdp?=
 =?us-ascii?Q?scq9sLEPsJsD6Vdcc0TEgRKmwBpsYnrN6RlhPShGyETTXZOC9ofVZuU0NoE5?=
 =?us-ascii?Q?nFJHMxChB3Qm/mcrXX+KnvcBipcdL/WcpWvXY+J6vtDy+Ic4GUUYK3tQBPY/?=
 =?us-ascii?Q?X8+tRyzjUEXT+1kj8h7PsVT36JYXYIAdCyCNdbfa/DoN4y5hJidXz7rMN0Xg?=
 =?us-ascii?Q?gsuuJSMuqy1GPmTkXb+9krMWUq4NkbkwAACw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:39:39.1171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bac9602-8d28-46bd-c0b7-08ddf23c7e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

On Fri, Sep 12, 2025 at 03:29:19PM -0500, Tom Lendacky wrote:
> The sev_evict_cache() is guest-related code and should be guarded by
> CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV. Move the function
> declarations under the appropriate #ifdef.
> 
> Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
> Cc: <stable@kernel.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

