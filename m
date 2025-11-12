Return-Path: <linux-kernel+bounces-898266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DEC54B72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61A93B7C03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49612E2DEF;
	Wed, 12 Nov 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kx9IS0j9"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021128.outbound.protection.outlook.com [52.101.62.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867B35CBB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986478; cv=fail; b=InU9flc3qzezus6X/4wvbW/8ilNZLukWcjLqAxfFB90ohNlb2E11QpERZ7Y1ywpV2lfGzkCZ3L0QrtOmYOdlgpMcpaDUYBySl2gHlBZrpBBoIVbAQOt3LJ9AdTTxjFfvgGUQQSmqUHNxv0tu0wtecZH9hrAtW8ltEtvfsjslqvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986478; c=relaxed/simple;
	bh=pGDwhlTmn71M77Qs8zdmEzBcAUjyYUr5nj6ENcwKjPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cTZernZBHY0z/yaGLLw8IPz8foXBtq0IZUVQKw2NbDGcymNq+SCX740Orpo5UtAXGftXECCd08Wk2Z4mhoXrndlxLv0lFIlaHai2FYCubJI+3bOxrYEsxGgnHRXo1dUs4Kanct87PRckLIoc8Uq5CrFmRwiflzl/TTI1chfayiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kx9IS0j9; arc=fail smtp.client-ip=52.101.62.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C20pj4+TWxWZH/vfN6X/OIeOkQnN/XiRYsvL+AB9MCyT8VQIzJjl+vxf1EVGs6wLaiuvPLyspnREDs3TVEGCgSA6Ujpy/J4N51luc4Bnh+MaFBGFvoX6ok0gwAfWoSw712kxxPEPALD40aMtmIoWKhWh1r7jaDUuNL+p+/v8F/RMcesGNq4dN22UeiCsOiUTnKIuo8eMiz4HhEvZq/MRbq6MElQypc6AohR2numl7yl6J/xLZ66h8ndYeb+Urzhhwi2psP2iRByGzB1gG4PawN7/8UNBTZ4JTQJvwogeijr5TeWb1qvcRC6/gfI57eOLNtsQ5/W3w+BT57O3go8pKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCLWzX702pi4aTstDqLnv19XZbpXxu4yq61VZJJIH2A=;
 b=KGSAbiIHRU/on937uXjCqpBha8doODZgFh2JgNB0DdFaSbl2UAjkwn8iT67iF0OSc0QhKnymhMC5Rp0dPhUqIEAVKWTRzniLqczE8fnO2FQlCZQ65LrEgAw1ssdwITbzgZn94SuMTBWEH4oTDvZvZaX+H3UHWHwrhN6w7yaEzoLJcYAYIrx52twm3Aocm31hJqRkm1lGeaUo7vtpgE5X9yakuUcGH/EX580KGha0fLmlR+O9pscgNh4ldO9DvNWSLTECVezcL66oCf04O19GpWJU3SbNS2WsHkBhQ353hK46usB95h6q38CA1fUWN/BObSWo/vcqSeTAltAnp2tQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCLWzX702pi4aTstDqLnv19XZbpXxu4yq61VZJJIH2A=;
 b=kx9IS0j9TzHByFMtAOAjiF6BHXT6yi7cUr9qh6J8/jQo3GY8rnSPxfbVgHweonUMhFWwNENAEXeXQcJAbc/i7PgteSnssG1W9i2MePzSY3aww7SL62DOLT5N5IVl9VW8ZC5MuXTuTWVfqy5ImffCRQRdAz6HawU2bISP6gbYD7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB994069.prod.exchangelabs.com (2603:10b6:806:4a3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 22:27:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 22:27:52 +0000
Message-ID: <3aa3558d-cfc6-43a1-8c73-9b01ed1e2b3e@os.amperecomputing.com>
Date: Wed, 12 Nov 2025 14:27:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: ryan.roberts@arm.com, rppt@kernel.org, shijie@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251112062716.64801-1-dev.jain@arm.com>
 <20251112062716.64801-2-dev.jain@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251112062716.64801-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB994069:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bf1169-a59e-46a9-7c72-08de223ab7e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlkxRDdKUmtEeEoyUEpBZndFSVRYYVNaVjBoaVAveTF0SklZei9TUkloVy9p?=
 =?utf-8?B?cUZjdWdZcVRSOUZwSXpxUUkyQTgvSEpGT24rQ1FKM1ZOTjdGVEpjSkxFUWFn?=
 =?utf-8?B?UWd0Vm9FL1VWYlU2UWdMeXNhdEdvWUJNRXhSNmdQUzZYbEpreGVCWk9IVmx3?=
 =?utf-8?B?M1p5UDE4c0VDU0FDK3dETjB3OVpkZ3M0c3RycmplNDcvUnEwNTk0cHM2c1Rl?=
 =?utf-8?B?ekxBVzlvN2VvcjBMZHNtN3VMei9rMGtCdWpTdjY5ekNqR0Z4VGZBVEF4Rm0v?=
 =?utf-8?B?NExSN3MwN1IwVHNKSnFEQUdTdnlHVWF5RDEwUzZTQlpwMFF5aXp5UzZ0aFB4?=
 =?utf-8?B?ZEMrc2JwTk56SitLL2RhOVNTVmFOSlpxMzhnTldJS0J4QW4yNkJwWmYyclM1?=
 =?utf-8?B?dm5GODFERTlmbnJKeVU0TXk5RDhSVlR6cnh1NzFvWkQ3QjBZejF3UW1OM0lj?=
 =?utf-8?B?NkRGbGtPZG52N1E3WG8vU1ZRWVFqRU4rcXJiaWg3bmo0TjMxV3ZvQ01LVmI0?=
 =?utf-8?B?ODQxT2JTeUw2MzZYTFFwYVcxTi9FM3RTMTcwbHAwN1NsbGYyQ256eC9ZbFdZ?=
 =?utf-8?B?YlhyejhxaGsyazV5WUJxN1JyeTgrVTFxREpudkN3NFVvNGVKR2tEbUhxOEw5?=
 =?utf-8?B?NlFXSlJXWVNBZ3AvbU9nQmdQMnRQdjRsclVwYndOMm9RRUFGYnVpcVVoQWtL?=
 =?utf-8?B?V2FXczZsZmlreUE4L2hVdkFHeEtiblFBQjROcmpZNEZNTldQcEpsRTg0dkxz?=
 =?utf-8?B?SzNaYkJNemJVK25OWjZzOXI5WThuNFJtam51bEh6Smt3alpFOTZuaUhLRjJr?=
 =?utf-8?B?b0M2OUF0cGtvZFRpYy9wNldMYkdnZDBWeHY3cEZ1cVR0WW5sc3lXQW11UzNZ?=
 =?utf-8?B?aGVxQUJlelljbDhha3A4cm55QzcveHRrd0VkRTJneGtraXp1MkwrK3NTdzBr?=
 =?utf-8?B?Z1dOazdlY20xbDlheWhKbVRrY01TTE9wb0VhUWZ4WXkxY0RPWThLZnFMdWp4?=
 =?utf-8?B?QmdoMmxpR08xeVhuVi9xeFZacVJ6SkExSFFSVmdvazMrbkhQeHAwd2FITXFZ?=
 =?utf-8?B?R2l0Skk5QU5HS0paWkxpNFgvQ1Q5N3BFMTI3WGp2dmhHS3Q4L3JGSDE2QkIr?=
 =?utf-8?B?VEJneTRDcVBweXpFdTF4RWhpS1ZWVE16SlMvS0FjVXkzUWNvcVZUbTJWMUc1?=
 =?utf-8?B?eU14MlpRUzg3NEdqRjk5c0VtamJ3OVVtZ2R0MFhXL3VJaXB5TC9GY0hMUHNT?=
 =?utf-8?B?RFN6QjJkYzdCRU1xZ0d4dldaR0FhNWNiWU5NckhRakpsMm9OL0ZWMUlyRm9x?=
 =?utf-8?B?MWNKU0Rza1JjRmVYbHkxSGRjZ0w1WVp1djRBYm15Z3FLN0pkTzUzRTlQTWMx?=
 =?utf-8?B?OVpRdzMyNmpTcWl1ZWJVZTkxSjE0NVdySXMrbWRPOGNxb2F1akEzc0ZpM0pn?=
 =?utf-8?B?LzcwMm9vclZ4Y3Z6NEpZL2I5L1pZTkhWYnhyb3A2dDRIenJiYTNHOWt6MUsy?=
 =?utf-8?B?RURpQ3FZNk9weXBNTlMwTjZLNGk4OUpVZ1c5MWRXS0VpeUdWN1lwcFlSL2Vi?=
 =?utf-8?B?TFdBK013S0l4OW9QcU9YaDRvU1AvYzNmTzBFNjFoWW5ESkxab0xZWm13K0ZU?=
 =?utf-8?B?M0ZiNHBVMzBWanJpdEVrQ1FmYkN1YnNVVFFkeE84amtscHFIR1orTFFYcWFt?=
 =?utf-8?B?SGp4VTViZzRPMFZ0YXY3eitLcFBMbVMySXQrSGNvbzdFRWNtQXptL2UxSGZh?=
 =?utf-8?B?eUI1R1Zkc284QkxwYTl3Y3ViLzhkbzZtUmpGWDBZMnUyQTdFY3ZZOHlKRmZu?=
 =?utf-8?B?ZnhlQkxGbnM1MW9xWlZLZ21RV0Zqc3l2TjlSQjUvRUJJbFgxVSt0OFpZTXVD?=
 =?utf-8?B?Tk9yWWNwSFZiVkNEVFJCaWtUVUR2MC9FVDV4NXBHbjFzOFRBdWlQRnBVWWI1?=
 =?utf-8?B?cUVqdnVyWGpkeDM4MDlSaGhtSGJ2cDFhTXFZTE4rajcrUEdoVXNqNVBnbUh2?=
 =?utf-8?B?bHFORWZRVHBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhIaUJtK2h5Q1o5bTd3Um9RZ1lPa2Fab013UkRsYUdlcjVXUGlwOUdINFRt?=
 =?utf-8?B?YnZ0T2RacWFSMnZwQUVFYzYvVkZNSDIwRCtDeXNjLzI3Y3hJYWhhMUNWc2JF?=
 =?utf-8?B?d1ZPbXlhQnA2V1IrSzJDcEtsOU5iM1JncWxwbVc5c0xLZzE2Wkx2SnhJbmNm?=
 =?utf-8?B?cVprdThzQkNHVUQxckJvaEVhL21xY1FwVlYreWI5SFF3dFFTN3BtampGNmxl?=
 =?utf-8?B?YitUbjhockZIdUNIVW9pQ3IvZkRrWjl0M1drNGFEQkU3YldIQWNOUHpZaVlE?=
 =?utf-8?B?b2pFZWR5dWN0TVliMXAwZ2Y3dXY2dGs2aDJvYVk3Q0xPQ1E3T1JFK2J1c3ZJ?=
 =?utf-8?B?cER2ZXB2YjFnakNGZm1oYjRlMFVRN0diTXhpZ2RISzc2dWdHdHhLa1FmNVZM?=
 =?utf-8?B?TEpGakJCanJVS1BIWlRPc01QYTUzdmFGUm94NUVSdEUycXQ0QldtMmxkQzIw?=
 =?utf-8?B?NENQTEI3K2s3OVdIdmRXaG5pd3c1UmsvQmJvOWlvZWJaM2dacnB6R1haeVFm?=
 =?utf-8?B?Um9sM0ZCY25ZdFZGai82Y3czRDFqNWtEbzB5SFJpUGVvWlBBL2g4Mi9iMk9j?=
 =?utf-8?B?SG0xL2w3N3RPUEg1T29KcWg3MVdNUmxDWE5pMVpFbXNzQkpDaXI0d0lSU2tn?=
 =?utf-8?B?Z2NqUmMvdGlwSElnM3pDUzlqM3pTenZjU3M4bWRDMXhvaGdIQXpvRmpDcG9B?=
 =?utf-8?B?TGtzcU95WjVSaFJPVlBxZzBBS0xpUlhpTnJ0OUxrR2xrZE4zeHdjaGlPM2VD?=
 =?utf-8?B?dmpWMkFnSHJSZmVGV2FSenBIZVk5S0k3cTZTQmhOR1ovdGFHbXdCQVUraVBv?=
 =?utf-8?B?blJxOWtLYUpVeW1VbitWWjhOTE5qTjhJMW5HN29ib25idC95OWZEUW5WYUQv?=
 =?utf-8?B?OWRnNGhEQXBiWUFHaWdjTG9ZME1vSlhhUGN0K0FNU2hUSnBsOFJDMHVnNFVv?=
 =?utf-8?B?YVp4Y3RoL3FJNFF0RkRTRmNpVC9FQ0RKOFp5VElwdHZPcSszNWZ5ZnAwL0Fn?=
 =?utf-8?B?KzNRbHdtVEI2bVV4SXB0SWJiNEF6bnF6TFZuanFQUHNFaTN1K24zeFdNZTdo?=
 =?utf-8?B?Q1E4a0R2Y0d6bTVWU2RLa0xxdWxmQ1VCdGFYVllJRnNFTlJTK0hqZVlsbTJP?=
 =?utf-8?B?eVhxM21NWmt2ZmZYR1VUUktWRWg5dWljZmNWcEdNRjdFdjFJbGdoYTQwTkRH?=
 =?utf-8?B?RUVRaVRSd1Jvcm95dnpVakNWQnUyMEJCRWtIR21ObTczRnNnbkRpSEVITXdB?=
 =?utf-8?B?eTlRNWtYOUZITTFYbWF4MXgrdGIyVVNvKzRMUXhaVnJ4d3h5VWRLclFCbzgr?=
 =?utf-8?B?Z0RvZENEajIvaEtFcVhzamV1TGNpbnlPTHBGdnFJbE1Td3Vpa0s2d29jQzhZ?=
 =?utf-8?B?M3RxdFFCVmhZRUlqblBCWmV5NHZrT3dVUGdCRVoySVJXUW02UG5WRytER2gv?=
 =?utf-8?B?M1VkMFBEbzhxSGl3MEpQdEk5TUNTdnl5T1Zkcm85MzNVaWsyanZRbFlKeVQz?=
 =?utf-8?B?UytqQ1pZUkNKWnJsSlBsRnBOOFBSc2VxY1E3ZzNaQzhPVHVCb0U4UU1GR205?=
 =?utf-8?B?V3FiNjRicEtUODRUT3lxZi94bUNOdHRmdU9qWnoyQUE2T3NORWtLVzNIWjBl?=
 =?utf-8?B?VDBtTnpidC9IK0pKT3pkRVZDaEs0WVFzWWZCTWJZQjBJMHZaYmVQSWdYTHZR?=
 =?utf-8?B?aUJDZm52aDkrVG0yZUhFYVBzTnJPTkIybW5zTktkb3Y0UFZFbDRxK3dWeGJm?=
 =?utf-8?B?SGlkNXFiSmo2ZmVVTWt4QWJ0YXVIQ1hkem9vTlM0azRUK0tyNmgxdHpNbGV0?=
 =?utf-8?B?Z2FlMW5tVEMva3k3My81eU54NmxYdlRnWWt2VkV3M3JWSGlGM0VqT2hZdHgz?=
 =?utf-8?B?SkxpSFc2cWNTZGI2RGdFRDNKNTJ4aldUNTAwcGVvdURyWkpHSy9tL3ZJcTRU?=
 =?utf-8?B?SHZUSkp3akNGTUk3RFRQOGwyZUVZVWFBNXdGN1oxTURlcWdEbFFtMVl4UUJY?=
 =?utf-8?B?RkpmRkttTjJScXh1QWtXV3NTTHA5YjYxcFcrcnAvblNTbC9NQnlUeE40NVN6?=
 =?utf-8?B?SGNMQzdMdFNYaXM4bURrcndHZ3pPSXliWGUxMldjL3hGNDQyQUphZnk3a0FE?=
 =?utf-8?B?ejRlOTAzSTJyenZONmsxV0Znd2VTck5xZ2FZb0FLMVgxQVltVGFuMXQrL040?=
 =?utf-8?Q?astaSDyMhou8I3SkP2Tr+bw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bf1169-a59e-46a9-7c72-08de223ab7e7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 22:27:52.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfPz7xSterSeVUlrZlvo2/RRN75S6uKhARDsnvCa6PGzMcHU2/ro2ThHJ7ZgPRm8wxI/FrraAM3JTRQE532UhL9Hj7kqCM3ATXutx0d8IKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB994069



On 11/11/25 10:27 PM, Dev Jain wrote:
> The rodata=on security measure requires that any code path which does
> vmalloc -> set_memory_ro/set_memory_rox must protect the linear map alias
> too. Therefore, if such a call fails, we must abort set_memory_* and caller
> must take appropriate action; currently we are suppressing the error, and
> there is a real chance of such an error arising post commit a166563e7ec3
> ("arm64: mm: support large block mapping when rodata=full"). Therefore,
> propagate any error to the caller.
>
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Thanks for fixing this. My old patches propagated the return value of 
splitting page table which was called outside __change_memory_common(). 
But it was missed in the final patches.

The fix looks good to me. Reviewed-by: Yang Shi 
<yang@os.amperecomputing.com>

Yang
> ---
> v1 of this patch: https://lore.kernel.org/all/20251103061306.82034-1-dev.jain@arm.com/
> I have dropped stable since no real chance of failure was there.
>
>   arch/arm64/mm/pageattr.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..b4ea86cd3a71 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	unsigned long size = PAGE_SIZE * numpages;
>   	unsigned long end = start + size;
>   	struct vm_struct *area;
> +	int ret;
>   	int i;
>   
>   	if (!PAGE_ALIGNED(addr)) {
> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>   		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>   					       PAGE_SIZE, set_mask, clear_mask);
> +			if (ret)
> +				return ret;
>   		}
>   	}
>   


