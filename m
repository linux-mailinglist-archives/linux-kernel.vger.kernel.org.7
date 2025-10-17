Return-Path: <linux-kernel+bounces-858352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E6EBEADA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51405E7FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998930CD9F;
	Fri, 17 Oct 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S3K4TMhX"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02261330B26
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716568; cv=fail; b=Ftttfk3jNV7bTX7I5Ai3M3yAn7vAq70x8LmFvAvdj3bxvbChlfw4yL/F7+PpxsqXfCX8sMhMxg3vPTdIbMuVTwPhmkdVFOzcmX/hO2DIfZw9ZT5k1XCVv3QUhYp/NTHJAhUKRbsGIIxWHlaU9VEcKGo5ixvmJflA9xKVKnDq9tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716568; c=relaxed/simple;
	bh=nqS7UbwOFB4/7s59/RZWIOMvd8FvXiM0jHYRvi4BFr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XRoA3PAtYos7l3reLsf4kXUn/PNGmvDBIY8LM6b2WukLbtDKKlNBZMG7G6kJx2yCcWpOCJTjNbDApqAu/mNZlJ5M0K8EXI7t+iMVgtVTrUM/ZVR9Dmi4mEgpc6FQsirh9ok0tiNxgJKQ9ngkAoMSskJuDfn5ZwcTPJ70qQxgGMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S3K4TMhX; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+6bTZUpgbqoIP2MbaLEdxHjV5RdmpURWEjc3/DsP4o1D3lKOiDvT4iHYMsjRHm2ammRQPMN9e0qt+cpQWrqzz3SAeKJ/6O1n1bCwMYnhcV+/3O9ABIHd57hPOpF5mKrEHzhyVma71GNYipxGx64FdK/EEE4ro35/Rc1YChYU1hMFdxzNGxns0+qbQoZbQT8xFhG1bPTQVinWKicWQBCivMEXulIqPTrZkDnXvBK7vsMwKueUfa3LqYtWCW82NBxs2+vvxXIl//tzsx8p4AD4CPi4sTnnSqmNhQaN8bWSLIlLnjpQ0+oFckaGUZ2kMRwMOtlGr1GI6NJUFFHwMOmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqS7UbwOFB4/7s59/RZWIOMvd8FvXiM0jHYRvi4BFr8=;
 b=UbCyAasRWUaIsV+FBxgYVR6UEWmCBf9BhIoMQABKii4S781aAruycS9a1LEudC1Qjyppg7+XIgX5GYyxpM6xOmznOXTnMpTfnnMD9/EPp+hRTJUKtAObtcjJNFT+EyR85OHLQP/VYAjMyYAiN+8/e7aJVQh7+2mixNZ9LDCvj0PMoSLa7DxaxhcjH+zzaIbKy8NbP0mNgAtcHPHZXiBrFkhlB6xkGepFdLXUGYpJHR6X6GUZStZfseYlLPeleKttblqdr7A9qwBTmX3mNOC9lpWVlmh+7EXfEqkuyXnXPXtGT+wPNE0C0gIO/qLKhzNGGgpgjRhLTQLoHm8+EGn2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqS7UbwOFB4/7s59/RZWIOMvd8FvXiM0jHYRvi4BFr8=;
 b=S3K4TMhXX7kU5xyWA04lBpZtfrEwupRuWFxJ8nemymzDmWHweKIuWzGzIXGipSCUnwVR3AQsRMBRKtFgliLeAuw4WLsZSRFsrtxjvjkQNiNmHgvWQKZGc2NWSCYazThAUOqIibhhVm9OPBw7bdqDM2WGPrzXc1rpKWTIMbI9YQs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:56:04 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:56:04 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 08/56] x86/bugs: Reset SSB mitigations
Thread-Topic: [RFC PATCH 08/56] x86/bugs: Reset SSB mitigations
Thread-Index: AQHcP3iebP7myPXtn0yvmiVoWPx2QrTGfRig
Date: Fri, 17 Oct 2025 15:56:03 +0000
Message-ID:
 <LV3PR12MB926590DD6CBD277D529C239C94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-9-david.kaplan@amd.com>
 <1c73c8b2-02ad-44ab-ba9b-44b12f3e09fd@suse.com>
In-Reply-To: <1c73c8b2-02ad-44ab-ba9b-44b12f3e09fd@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T15:52:19.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM4PR12MB5796:EE_
x-ms-office365-filtering-correlation-id: 1407f4c9-fbe7-465a-ef0d-08de0d95ad2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlBLZlRqSEwrTDh3VjFic0VvWmZwNUozQy92cEtXZlFDYk93Z3RhV2Ntd2cv?=
 =?utf-8?B?d2VLblNvTjBCbkNXSFRJNGl0SmpSaTVCUllNWVkrUzBraWEzSW5ja1pZK3BC?=
 =?utf-8?B?eGYwQjZyVGRVRDNXazZVMnBvYS9nMjdIT1U5VkIzL1IyWVRsOGs5dThXWWdF?=
 =?utf-8?B?bVJFOWthbVNKdE1qOTJ4N1o5K29nNGNwUWx6MVhNVXc5VzZaMkY0M0QwZWF6?=
 =?utf-8?B?T3B1UTRqclVTc3RCUnVRSDU3RzY1LzRVT0lLYXVPQzIwR1A3Y25GR1RTRElR?=
 =?utf-8?B?NXZWOGxNbVRpT1d6eElRYTBKSGZNWkM4TFlibFJseHQweWl3aGRzSDgyK3Ri?=
 =?utf-8?B?bU8vTUhDZytnSExsbEdzSGFMYjlHR2c1UWRObkpvV2R5NUhkYU9XRDFGS3V4?=
 =?utf-8?B?RHN5MWREdmlxV0d5bTdtVEh2YStNcUpuZ2xGYXdNREcvOUlwOTBvenlHVFNH?=
 =?utf-8?B?aWdQNG1pVXNjaGl3WDBoRWJ3dU95VGRIcjdKNkpvaklNczBPcWgreEd6N1BZ?=
 =?utf-8?B?ZUV6eWw4dzFjb2RPcnc5V1JkaWl5Q1hvSmZrS0h5R0hlcGgwUi9hT0pTazZk?=
 =?utf-8?B?NjUvUEs4VWQ4ZWZWUEk4eUtHa3lkN0ZQdVMxUFJ0dWJoUGtZbVVlYytoNjlo?=
 =?utf-8?B?eDhYb1hmY0daWWkxQWxicDlQZ0U5eTBuMHdTZUtBUDhvQlRwYWhMLzZmOTEy?=
 =?utf-8?B?RnMrcDdBZlo3eTg3bUltbnFnVFpMOHUzMERXUDFkT2R3MEdrOEplQmNZdldw?=
 =?utf-8?B?UG9nQVRaZmRoSlJuSEZqQWRXQ05FZ3RtWUNIQ25rWjdFclQrWVZIdndQR2tH?=
 =?utf-8?B?RUxjeG10dFF5VEFuVWVnc0YrcE9XVGNVRm85NUVldkVOQ0syaWlFb0wrRytY?=
 =?utf-8?B?TjUrR0tKTTBtVW0zdmFxLzdSMUJZRmNNNFFhaXN0SERsMjVtRUNiMjkvQWp2?=
 =?utf-8?B?NTZTeHp6c1RyYjlxQzZCZkdBVFlVWStCcEM1MDg1S1F5U2lTMFdiaVU2WWNW?=
 =?utf-8?B?Mnc1L1VRM2d3bmI4OVhYREovOWM5TGFMT1hJTFFhUnZxb3Z3Yy84THZnQVhP?=
 =?utf-8?B?R2RjZ3A3MEM2N0VvS01iazdBUzFQc05mRkcvQ0F1R3BZelZ1UFNBR1JHOG1L?=
 =?utf-8?B?VUtObndJVE0rRGRydlQwcVJKMUlwdjF5LzRJVUxxcy9vZE9TQVpBb3JvUzUy?=
 =?utf-8?B?b3MwYjI2UE9YNktUa2FXM01KTE00UjhWS25HVWtDRjlmVkVtbHh4RFZqT0x6?=
 =?utf-8?B?NDBYSXdLTC9hSnVNQVVKNC9wUnRGR01MQ1VyYTVWemNYV3lsYit4R2FEckJS?=
 =?utf-8?B?d0pyMEphOXRFMDNmTDhsd21DWUZVeHMzTHNscFYwV0R4UVQxVXROeG1uYVkw?=
 =?utf-8?B?S1BJL3FHRGsyWkVPdkZjeGoyanpXZ01lQjYrOWRzOTRDZ0huZ1o1ektaZXFP?=
 =?utf-8?B?MUdkZ2FYYnpRczlORGRjK21jcnovNFF0UXJOVGdEcUlYZFR2NGpJOUYxdndj?=
 =?utf-8?B?RjFHUzFISmFXSGJldXVRVnVtdEcramZaYVgvYW9lbDhmOVdsTEpFWHpkQkpx?=
 =?utf-8?B?cjJxbHpIUUpyRGo5bXFMM3UzdjFxbHY5SGRnenR3ZXRSWTZ2V05TcHNVM1Nr?=
 =?utf-8?B?TnZibUlOSWdxaEhWUDBDN0U0bkdCREVWUG5IUkc0VWdaMlZnMDhPVGg3WjlW?=
 =?utf-8?B?QVBhZkQrUTB4ZytYZWJFZ2dJWktQcEU3Rm1SdC9mR1FGbTBNd2o3bEdXTHRy?=
 =?utf-8?B?Zk84c1I2UjJTYXI2aVUwWjBZT1U2cGJvTThpaVZzK2I4UXE2VlJtVUJsWHQ4?=
 =?utf-8?B?U2pldHFlaEFWazRsc3hQWTNEQ2srLytvclcvTDBSYlhVU1Juc29JQXNyNWRj?=
 =?utf-8?B?a2x2MENvd3JYL2k5QmdWdXRXNGFvS3BEcWxjVXZnZ3NyckdKd3pwU05jdjN0?=
 =?utf-8?B?amVwaTBEVDk2SWIwaTZkYWNtTU40S1VNNklTZU16UXlEVWtXWnBxek9YOGxt?=
 =?utf-8?B?WHU0c0VSOE5iR2VqUVZ0R2hJclgyUTJtbjFrK1FoUUIzdlYrTVVSTXdGVVFN?=
 =?utf-8?B?eGtpTG1oZUlmb1pyL2Z0eEp3UzNRL1g4N0dTdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZENOZVdqV3YxeDhYK0wzQVQ1YVdOUzc4Y3J2MHM5cFFKQmpZNE9CS2JWSi9m?=
 =?utf-8?B?UHA1NitWbDV0UkNXc2Y1bFJoMG5IMDhBQUszbHdQblQwVVVLeFBUeE9QZDNM?=
 =?utf-8?B?V00zUVRWcUliWi9MY2oyMU16QzdWYlFxUTJudDNKbCtvSUtkQVBjNVdtRG1Y?=
 =?utf-8?B?dEtJcFlQZUlHeFNhTEE2MWhYQ1dsV3JROVZkclJxa1kydGtvSFVRMGRCM1A2?=
 =?utf-8?B?WGhkQnl4U1NGNmxSL3d1TWxHNlMrM2dVOWVoSkJ6VkxXVHQ3d0pzMEUxblBi?=
 =?utf-8?B?RVp5K2lyUlV4QWJITWhWVGFwaVdCVmNWUnpNek5PSUVIUE8xYnNqQzdJOTZL?=
 =?utf-8?B?RlJtYnl6SFFnZFF6VFZ3SlN3MUg4czlzb3VIdEZHZnFEUnR5dGExQ2hIa0JM?=
 =?utf-8?B?K3I3N20vV1o1U0lNU05XOWw0L3ZOYm8yaEtBZCtQTTdDTmpWU2lEaDlMeXcx?=
 =?utf-8?B?WGEraDZRMks5R29NK3Z6SVBta3Ixd3BvSWNEQlJrUEpLSTFkMHlVQjA5RVAw?=
 =?utf-8?B?MDZqYzZ5SDIvZ2FEM0JVU2c3RkVRd1dRNWx2SWYvYXVzK1ZNTk5XcUcxYno3?=
 =?utf-8?B?K0R6S3FpMnZzVzRwWS9rVTVJamFiRUZndVJsQVVmU3BnV0d4NUVseC9aRWRh?=
 =?utf-8?B?VzBZU1duUSt1UEZ4RWlkcUJBY0FlNHhiQVV2OFpWQnVOQWVteklxdlFzMnk2?=
 =?utf-8?B?dm5BZXE2M3diNjJpWXlZWW5vUE9ZUlFkaTdKUFZoTmk1OUJLVzJMZG1kR21m?=
 =?utf-8?B?SG1YT3N0clQrQmY3dVA1VTFqL00zR1dLSitYZXc2UTZBUmNyZkovZFd4Z3dU?=
 =?utf-8?B?eThtTVkrbVVpbHg1WGI5bWFGL0drd3ppd1VnRVpWcVd0Q0lZTStCRkU4NUJB?=
 =?utf-8?B?MGtDMlVUS1BiaW85d1lQaW0yQloxTUZiWCtjNDhISmx3L2ZYcEpEd0dSbE9J?=
 =?utf-8?B?L0ZtQ2NSMFZuQnNhbDdPNnpyRGdaU0V0WFQ4Q256ZE44V0lBRUZKUVZETVVS?=
 =?utf-8?B?VW0xQmIrbzR2U25BVy9MSmw4ZHZpTXlXUngwOWpSYjQySDNYeTVoT0lxN2I3?=
 =?utf-8?B?QlVrLzJlSHJxTjgxS2w3L0FmWWorNjA5RFlLem5zNjNnOFVRRjUxTjFLR2g2?=
 =?utf-8?B?cjFPVXRPQTI1Z0tmUGFpTFU4QlFvUUlBV2hOQkI2empNVTdOZG05amVYZWR0?=
 =?utf-8?B?cnVoVEgzQm9BSEMreWxNY1pKVis5QVREdTIvVWFoRUlnWS9iSWZZdHliSER1?=
 =?utf-8?B?SHBmNHFiYkFENWN2UG41MzM1WkluaHhGcXJ0d1FxMHRCSGdvVTNVczl1cE9t?=
 =?utf-8?B?enVmRjlaT3VlSG9Sd1dROWVDUVJ3QnVRVGdVN0M2U2JwdzZLcS9WUWpEU01D?=
 =?utf-8?B?eTlCNnZDVUZpMHF3RzAxK0J1R2ZXU21UQWFvdVRzWHg2WkNrdzNhUzZTVVNR?=
 =?utf-8?B?QnlEM1l5YjR2blFvdzhnYkZVclFUVG1TVE5qMms0S054WmhFQnVFYVQ2R2FE?=
 =?utf-8?B?U1drWVF1QTFpNW9CcFZnRTVsbG5heWRuOGJHK0txUUdlRXdzUm4yTVBpYWl0?=
 =?utf-8?B?bGdPL0FhWUV0dndUNlpaZ2VwVzVNcFhCaGk5a0pUb2dCOUhMN24zcmJtYW9I?=
 =?utf-8?B?dEcxWkVvaWFmTUxzM1NRSjA3SDVReDkzdFU3SlR0SVpNc2FFRTJkMTZkUnFk?=
 =?utf-8?B?Tk9nYThmVTl0NVNIWDFVbkpnTkNxdkNLSjA3NXZqVDVKb0dhWCtiQWVyTFV1?=
 =?utf-8?B?ZEs5N2lEL1NqLy84aG12SHI2QVB5TWVzTjdJRFpUVitFcW5weS9jd2pWdjcx?=
 =?utf-8?B?d0NPbm1JVE9OdURiK2U3dVF3K09yMGVEaHNTalg5dENZOE9DRnRLeHdDRFdk?=
 =?utf-8?B?RGw5VWVrR042cGhSejA5TTFKaGlTUFVPd2p3YjV2TnZIdTBVT0FvK1g2eGpq?=
 =?utf-8?B?T2pRL3VsQkY4dUMrMHZsUVJGclBHVWcxTnRaK0xkcTJ5cEFqUjZlbS90RXA4?=
 =?utf-8?B?eHBrcTBPWVRvRnlRTEhmSzBJYUV3Si9pSU4wWnczelMzZ1p0bi9rVVBJQTBG?=
 =?utf-8?B?Y2pKTVFxUVRlQzZNcVUyMUFha3JFK2phZ3JncmVFak0yZkw2Vkl1a0xCZWdO?=
 =?utf-8?Q?GHvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1407f4c9-fbe7-465a-ef0d-08de0d95ad2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 15:56:03.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3abiqj1DAFsyycORphupK6oz/+cg4LdB1+kewox7XmVMxLL1xQoW2dhcDXwlCAI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTcsIDIwMjUg
MTA6MTQgQU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhv
bWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4gR3VwdGENCj4gPHBhd2Fu
Lmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQu
Y29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBr
ZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBBbGV4
YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggMDgvNTZdIHg4Ni9idWdzOiBSZXNldCBTU0IgbWl0aWdhdGlv
bnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5h
bCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMs
IGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAxMC8xMy8yNSAxNzoz
MywgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IEFkZCBmdW5jdGlvbiB0byByZXNldCBTU0IgbWl0
aWdhdGlvbnMgYmFjayB0byB0aGVpciBib290LXRpbWUgZGVmYXVsdHMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBLYXBsYW4gPGRhdmlkLmthcGxhbkBhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2J1Z3MuYw0KPiA+IGluZGV4IDRjYTQ2ZjU4ZTM4NC4uY2M3YjFiNjdkMjJkIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+ID4gKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9idWdzLmMNCj4gPiBAQCAtMzgwLDYgKzM4MCwxNiBAQCBzdGF0aWMgdm9pZCB4
ODZfYW1kX3NzYl9kaXNhYmxlKHZvaWQpDQo+ID4gICAgICAgICAgICAgICB3cm1zcnEoTVNSX0FN
RDY0X0xTX0NGRywgbXNydmFsKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCB4ODZf
YW1kX3NzYl9lbmFibGUodm9pZCkNCj4gPiArew0KPiA+ICsgICAgIHU2NCBtc3J2YWwgPSB4ODZf
YW1kX2xzX2NmZ19iYXNlOw0KPiA+ICsNCj4gPiArICAgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX1ZJUlRfU1NCRCkpDQo+ID4gKyAgICAgICAgICAgICB3cm1zcmwoTVNSX0FNRDY0X1ZJ
UlRfU1BFQ19DVFJMLCAwKTsNCj4gPiArICAgICBlbHNlIGlmIChib290X2NwdV9oYXMoWDg2X0ZF
QVRVUkVfTFNfQ0ZHX1NTQkQpKQ0KPiA+ICsgICAgICAgICAgICAgd3Jtc3JsKE1TUl9BTUQ2NF9M
U19DRkcsIG1zcnZhbCk7DQo+DQo+IG5pdDogTm8gbmVlZCBmb3IgdGhlIGxvY2FsIG1zcnZhbCB2
YXJpYWJsZSwganVzdCBwYXNzIHg4Nl9hbWRfbHNfY2ZnX2Jhc2UuDQoNCk9rDQoNCj4NCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgICN1bmRlZiBwcl9mbXQNCj4gPiAgICNkZWZpbmUgcHJfZm10KGZtdCkg
Ik1EUzogIiBmbXQNCj4gPg0KPiA+IEBAIC0yNjcyLDYgKzI2ODIsMTcgQEAgc3RhdGljIHZvaWQg
X19pbml0IHNzYl9hcHBseV9taXRpZ2F0aW9uKHZvaWQpDQo+ID4gICAgICAgfQ0KPiA+ICAgfQ0K
PiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfRFlOQU1JQ19NSVRJR0FUSU9OUw0KPiA+ICtzdGF0aWMg
dm9pZCBzc2JfcmVzZXRfbWl0aWdhdGlvbih2b2lkKQ0KPiA+ICt7DQo+ID4gKyAgICAgc2V0dXBf
Y2xlYXJfY3B1X2NhcChYODZfRkVBVFVSRV9TUEVDX1NUT1JFX0JZUEFTU19ESVNBQkxFKTsNCj4g
PiArICAgICB4ODZfc3BlY19jdHJsX2Jhc2UgJj0gflNQRUNfQ1RSTF9TU0JEOw0KPiA+ICsgICAg
IG5vc3NiID0gZmFsc2U7DQo+ID4gKyAgICAgc3NiX21vZGUgPSBJU19FTkFCTEVEKENPTkZJR19N
SVRJR0FUSU9OX1NTQikgPw0KPiA+ICsgICAgICAgICAgICAgU1BFQ19TVE9SRV9CWVBBU1NfQVVU
TyA6IFNQRUNfU1RPUkVfQllQQVNTX05PTkU7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0K
PiA+ICAgI3VuZGVmIHByX2ZtdA0KPiA+ICAgI2RlZmluZSBwcl9mbXQoZm10KSAgICAgIlNwZWN1
bGF0aW9uIHByY3RsOiAiIGZtdA0KPiA+DQo+ID4gQEAgLTI5MTYsNiArMjkzNyw4IEBAIHZvaWQg
eDg2X3NwZWNfY3RybF9zZXR1cF9hcCh2b2lkKQ0KPiA+DQo+ID4gICAgICAgaWYgKHNzYl9tb2Rl
ID09IFNQRUNfU1RPUkVfQllQQVNTX0RJU0FCTEUpDQo+ID4gICAgICAgICAgICAgICB4ODZfYW1k
X3NzYl9kaXNhYmxlKCk7DQo+ID4gKyAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgeDg2X2Ft
ZF9zc2JfZW5hYmxlKCk7DQo+DQo+IERvZXMgaXQgbWVhbiBTU0IgaGFzbid0IGJlZW4gd29ya2lu
ZyBjb3JyZWN0bHkgdXAgdW50aWwgbm93IHNpbmNlDQo+IF9lbmFibGUgZnVuY3Rpb24gaGFzIGJl
ZW4gbWlzc2luZz8NCj4NCg0KSSB0aGluayBpdCdzIGJlZW4gb2suLi5TU0IgaXMgZW5hYmxlZCBi
eSBkZWZhdWx0IG91dCBvZiByZXNldCwgc28gdGhlIGtlcm5lbCBvbmx5IGhhZCB0byBkZWFsIHdp
dGggcG90ZW50aWFsbHkgZGlzYWJsaW5nIGl0IChzZXR0aW5nIFNTQkQpIGluIHRoaXMgcGFydCBv
ZiB0aGUgbG9naWMuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

