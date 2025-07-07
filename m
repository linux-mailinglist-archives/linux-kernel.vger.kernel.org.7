Return-Path: <linux-kernel+bounces-720200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24BCAFB877
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A71423C08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E021B9E1;
	Mon,  7 Jul 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D6Q2Ee9j"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4422B8C2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904802; cv=fail; b=JPvvnoFRDdChvcqWzvOTuR04rB8nqtY+S28NRbhGAbnvAGEP4Mp76drzlmpbChBPjU2kJYacU63j68/zu2AmiTDTzXZ5eaBk+VK3Y6r6674seW1d4a0WJka5r4/dljrj4plqZruCDgq7SJtZl4RUjgENgbOERd+pQ3H0piWSHDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904802; c=relaxed/simple;
	bh=elqxKLLFUuFqiPWAYVMA0kzwlsoFup32C8mtsKQ3m7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KDP+pqSe/QPXTQmd5r9eJP8d7OKy5+Di/1sJbwFlkNAsy+PFxH+zDFratQs0+Sx5C75pQomgc2M1s3ABABwD8zSA+yXCEECIWHMYqmyMTG/f/PavRJAY4aPa9D+H27eZAMGp7x/nZvfdQsl6bOFFDkp8ujrtIUC1TNaQb6r679k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D6Q2Ee9j; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlWpYSeux2jDf7CcoP8t6IUlBgUVvSQU9awKfhy9JIkh+xvV1A1NZ/ywRX/pRJ3KUDwk9Ljg6TGeivhunnIu9OD/P0mW7VpqwNu+3GQmtYK93nmoaQhk4weGmGNuvcLbCf6mh3POVmL9Gf2MjodHUb3PNYQn25cqr5A91nYP7JXn57P5BDgssDGmXDVVNiJ5ObY/QFJfY1OApyrXx46r3qbZ3SIhzCTcvl/g7Eo1spc0VVb9jW/vpOCCsdBvDBUdXsO7n3gZdgGREfrVEp9iY9X7BpzJn2bK80yHRfb49VYJGxdznBo/dDZHExr16j/pLzOluPLKiwbJM3Pn3Pokog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL47XE0BrlrxLv86ipFz9Skrt2ixUoerK8p996xVxr4=;
 b=goZZ/VjRaccC8GPwYm9MBVs70higyhPsrOwZKrFYilCAWwA3ongFkc2jEV4vUxRssEGd2cknynFK8VlWNupRynQuxEdQ827/YhWYo6SM3U4vO3+QgbycfgbcK459SsO878NwCwYxAw+B42EKY9/5kjPLw78U+Y5fgH4IIsczyTHNNrrJKt7rIru9zKOTxqYOd1KTnUI0Vxa5T/bsplvGS90i7G5mgL668zECfOC7YcVEzbslW9GTkwH2MQKVhV7MYqMt5qAY5OW5eIovmXtMZY8BAxBhqVUNtlj+S8pwMz3qhtEGYgjXeUyaZVI8VP8WUwNShFbHwZvRuOgr/fcnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=9elements.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL47XE0BrlrxLv86ipFz9Skrt2ixUoerK8p996xVxr4=;
 b=D6Q2Ee9j+5KOaX7esylRCvg69YJW8SMmr+m0PTm1mi/q8FvbUcox+sjBs8DMFmmyDmXlCBucdMc5Xxwworn9WSs3E75x/yJVDpplTZ/Dsi5CmD1x9x7C3CrYbRoZqFv5cvRLBVYGqJejMoGHES3kKwv14SEJ0wf5SbF3FF/Kb1U=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 16:13:17 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::c7) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 16:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 16:13:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 11:13:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 11:13:15 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 11:13:15 -0500
Message-ID: <987f0165-7aac-13d5-0a13-c49c987719a3@amd.com>
Date: Mon, 7 Jul 2025 09:13:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Is PCI passthrough of the AMD XDNA device possible?
Content-Language: en-US
To: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Zhen,
 Max" <Max.Zhen@amd.com>
References: <8ef53fef-a1bf-4948-8105-9fbf341e034b@9elements.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <8ef53fef-a1bf-4948-8105-9fbf341e034b@9elements.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: dd618eed-d978-47cc-fa96-08ddbd712ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWFhMS83bndrQjdCdGJuZEJSeHIxem54ajVvZjVjZUMydkRSeTJiWjNheXIy?=
 =?utf-8?B?STBkVm9hYjc2SHFiazJmR0Flb0x4cUp6YmJnbWFiTkV6aGhGU0RTdG1TTnpP?=
 =?utf-8?B?ekFWRlROOEpCQmZ6aXhnUmg1NEl5ZDd6ekR1ZmZoeFNSZElYeS9aOC9oRy9w?=
 =?utf-8?B?Mm1abG43d1QxTzBwTjNXbE0rNlg0am9xeGk1YS84aWdLZ3hwQ0FrYVBDajg1?=
 =?utf-8?B?dlFrNnhVbWVWcEY1WW40eUhpcHRYVjN1WVFGT1JKTU1DNkE1dllhZUxBVXp4?=
 =?utf-8?B?U21QM2tqdWl5VUpwWnMyNXF1ZnFqMGVBc0RadUxEZXlwSWxBSkp4MWJtUUhx?=
 =?utf-8?B?dEM1RXI1UlQ3dU5KTktobkpVN1dLN0RVUGI4VWwrVkhFUWpUaXBGd1B5aGdi?=
 =?utf-8?B?cmhxL0lQQUFuR2Q1Y2tZMUZuVnpWRkJYdWlwWG9vd2VNemw1K2lTRjBiQnFH?=
 =?utf-8?B?SmEyMjVySnpyWEpJbTR2clNsQlc3ZExaQWJYZy9JTFk5aVRhMjhxVWVyUEhE?=
 =?utf-8?B?RkhQK1dCcWw1UnRKZERSa2Q5TVVvYmpKSGRkOWl0UUlOVVIyK3hySFdOUk5V?=
 =?utf-8?B?THZwT1RVV0RQVTJEN1ZJWTFteWd1ZCtZVHhkc2xrdWl3TnB1N3dIa0JrR1Uz?=
 =?utf-8?B?eThiMmducy9QeGxjbldqcEpDbHYzeGpYS21qY21QRXZXOWdHdDdhYmU0d0E1?=
 =?utf-8?B?MkxhL0JJSStDU0txNUMwMUFUMVIzSk1yODhjRVk1ZEZMNlBQOWY3aFR0N2Qx?=
 =?utf-8?B?bzRNTGcwR1k5c2FqTXp2RVJzZDRoRis1Q2dKZFlRK0NTTERQM0RzVjBjVE95?=
 =?utf-8?B?MU1OOXJkUEh0YVRjQnRxOHJ4NlRZNHZjSzZKQndpb1dVS2dTN2oxZjgxRVhx?=
 =?utf-8?B?NjRGL1FGYmxSVHorMFROT2hUMWFEbWlyQ1U2VWkxQy9rSWNIZXlIRGp2elFx?=
 =?utf-8?B?VlUrQXNQRlJEVFRHR2h0REJNMUZvRlJJcmg2ckpFMFZZbXhISkRrRlNFa1A1?=
 =?utf-8?B?d1EzYUo0cjM1KzFsbDhRV0I3NEdtQ2RmNy9ZdFh0eDVyOXY1amlNK2xtU1g2?=
 =?utf-8?B?TDNxamxjbUc5dWl6QXUrSWVDeXpNTDFWSnNvdjF6RHgrZjZFWTg3d0FDTSto?=
 =?utf-8?B?SlgwMHdkQU5LV1JOSStaWmszaExDZ2hjQ1dZVTRjVzBneWxJbDdXSjY4NWZo?=
 =?utf-8?B?TmRCeE8xRmY0UGZOYkdad1pTdGhKaC8wOWJjdlg2d0lEU0FKT29KZkg1MUcz?=
 =?utf-8?B?V3dpN3dWZnpxUGphak5hQ1NXSGtOM0VqMEx2NVZ0RjB2UkwySWZ6MEZ2N0Zi?=
 =?utf-8?B?ZFh4eFYzZ0VyNjFrRU9Za3hkeGh0TnFoK3NKR3lwL08rM0c2Y0FuNy9oVzly?=
 =?utf-8?B?eFhBSjVyY3YvODQvdHZEQ1o1UDB1cFR2cUtaL2IxZmNMZkNGUXZGT0VBRWtq?=
 =?utf-8?B?WjJLZkpveEM2VlEwb2Y1L3ArOXY4c0hmaTBkWFJza2Ewc09HZlcwWTRBbzQy?=
 =?utf-8?B?ZG5DcUM4TkN2ZEJKMnJGV3JYMFc5Znc3RktUOGc1alFlbWMzei9NanhjNGlq?=
 =?utf-8?B?dmdxOGFKVlB6Z2dGNitrNUtVcThrRFhSWjB3TkdzRHc5ajFZeGFJeTZDdWt3?=
 =?utf-8?B?ODlkUTdCM1lVYjdWTXdOaGYzUVh3QnlQVVdRUHNUa2x5bVc5aXg3YU5RTmRO?=
 =?utf-8?B?QnJnTUROODNZd3NtcWdEcW9Zd254dXVRWE1jNWpwa0JyVkFEMXFyVFdRdmZs?=
 =?utf-8?B?eVlVUzJhNDBjRkZKcUFCSDNPaExyOXlmOVZ0V3pNNjY0NXJra0xKdmt1Y0JS?=
 =?utf-8?B?ejdwaVZFVDhZSHBpMnFJbFg5T0dPODdSaGR5bU5tR2dFRXB6akx4N1hvSW41?=
 =?utf-8?B?Z1l0UmVMSlRVRXlsTDR1STM1VFY1RnBXU3hNYmJiSHllaFVvK04zaEwzVWtv?=
 =?utf-8?B?bzI0a04vM3NwbDhTcDJkYkV5Q1BWN0c3M3E4MWc4MXQ1eWd2SkdKNDF1K28z?=
 =?utf-8?B?YkkzUGtBZWFaWmNNcDdOZlJNV0FMU1BsdnhGME13ZmVUcjFKTmlSUkU2ZXdP?=
 =?utf-8?B?Rm5wWXR2N0F1RWpEaTZhOU41L0l4V0d5eU9sQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:13:17.1900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd618eed-d978-47cc-fa96-08ddbd712ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149


On 7/2/25 02:14, Marcello Sylvester Bauer wrote:
> Greetings,
>
> I have some questions about making the AMD XDNA NPU accessible in a 
> virtualized environment. I tried using VFIO on QEMU, but I could not 
> get it to work.
>
> Here is a brief rundown of the resulting issues:
>
> Simply adding the device to QEMU ("-device 
> vfio-pci,host=0000:c4:00.1,addr=4") results in the following error:
> ```
> amdxdna 0000:c4:00.1: [drm] *ERROR* aie2_init: Enable PASID failed, 
> ret -19
> amdxdna 0000:c4:00.1: [drm] *ERROR* amdxdna_probe: Hardware init 
> failed, ret -19
> ```
> This makes sense, as the drive relies on the IOMMU for the PASID 
> extension.
>
> Fortunately, QEMU supports hardware-assisted IOMMU virtualization with 
> the AMD-vIOMMU device ("-device amd-iommu,intremap=on").
> While the driver can enable the PASID extension with this device, it 
> fails to establish communication with PSP during firmware validation:
> ```
> amdxdna 0000:00:04.1: [drm] *ERROR* fw return error 0x8
> amdxdna 0000:00:04.1: [drm] *ERROR* failed to validate fw, ret -5
> amdxdna 0000:00:04.1: [drm] *ERROR* aie2_hw_start: failed to start 
> psp, ret -5
> amdxdna 0000:00:04.1: [drm] *ERROR* aie2_smu_exec: smu cmd 4 timed out
> amdxdna 0000:00:04.1: [drm] *ERROR* aie2_smu_fini: Power off failed, 
> ret -110
> amdxdna 0000:00:04.1: [drm] *ERROR* aie2_init: start npu failed, ret -5
> amdxdna 0000:00:04.1: [drm] *ERROR* amdxdna_probe: Hardware init 
> failed, ret -5
> amdxdna 0000:00:04.1: probe with driver amdxdna failed with error -5
> ```
>
> Note that it also causes other devices on the host system to 
> malfunction, such as the GPU:
> ```
> amdgpu 0000:c3:00.0: amdgpu: SMU: I'm not done with your previous 
> command: SMN_C2PMSG_66:0x0000000F SMN_C2PMSG_82:0x00000007
> amdgpu 0000:c3:00.0: amdgpu: SMU: I'm not done with your previous 
> command: SMN_C2PMSG_66:0x0000000F SMN_C2PMSG_82:0x00000007
> amdgpu 0000:c3:00.0: amdgpu: SMU: I'm not done with your previous 
> command: SMN_C2PMSG_66:0x0000000F SMN_C2PMSG_82:0x00000007
> amdgpu 0000:c3:00.0: amdgpu: Failed to disable gfxoff!
> ```
>
> Now to the questions in this regard:
>
> Are there any known limitations or information regarding the 
> virtualization of AMD XNDA?
> Is there public documentation on how the device interacts with the PSP 
> BAR, and if not, what does firmware error 8 mean?

Unfortunately, XDNA hardware/firmware does not support passthrough. The 
validate fw error with passthrough setup is known. If you would use XDNA 
in VM, you may try virtio solution: https://github.com/amd/virtio-npu


Thanks,

Lizhi

>
> Thanks for the support.
>
> Kind regards,
> Marcello
> -- 
> hardware: Lenovo ThinkPad T14s Gen 6 (AMD Ryzen AI 7 PRO 360)
> QEMU: v10.0.0
> Linux host: v6.15.4
> Linux guest: 6.14.0-22-generic (Ubuntu 25.04)
>
>

