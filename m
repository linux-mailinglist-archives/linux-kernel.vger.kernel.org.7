Return-Path: <linux-kernel+bounces-782785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A788B3254F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A91EB20A93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B1288C20;
	Fri, 22 Aug 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7ax18Wm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61919DF62;
	Fri, 22 Aug 2025 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904239; cv=fail; b=VHyTr+xYufJ7OefNOzhwvYZ2xrDESch5IVsMht78vNwS3iikzRg14L56Yx9Le0RMmNwKwa7foUWANenTrPbvv6gwsQLOd8jrStYls0z/Rbnv7O/x9Ui8fw1zgRGAbSdoF9pYNRs/YhQEnvpmgCpTNdK8gUWKrx/4vZJady0MF/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904239; c=relaxed/simple;
	bh=R01CblxfvX+XhWPzo/pZt2T5yACoasUAwGM+Q6/ZrrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzRIN9bVsN9Nc+QgHArSfbV4QUhjqhxfcWjMn1ZecI2xvzh32NP5ugDr58OhyN0so6xQuoGeaTMhz35iEnRXLSPc6MrzXIG9IOBSzfhnUOYgd2L7xn0tSZLK9CQlOyrBnecBZPOs2QFQGjx8E5vhS9pbO74KlUyDH3LjF4lyEzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7ax18Wm; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvCZLNZ9Qgq+BCoiruTZAc6zuMn8gL71A8Dx9q4hFLHRveoGCrg+SE+Ei52w9P4DSCxQjplEC+6bByjWxDVbuZAxMlik3eDUDMmJ1dIZgLw8DRY6viT7OOTowTG4XHQYOvyyOdjwa9z8nmJkUWhrIHSHRSrMbJfd9V+k75P6uDQw9MVRug6SdrLVnTfZ52tM1YGl4p/CzVLLU2S4nuKg5JqfdQAATvaPNxxS9x9z+++mbQ634R8ME/bsMIS1zys7BWxf0OZg+21KVDZdmZY4ZI1P/zT4Ex4QBHpRVJUNtjvPB7U/uMqA/9eMinBfW9L2se8r5tdmg/XrNguNbiYAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd22jfU9sH8YbpYx9O5rvNGaA1qxERSc9WsezDNndtc=;
 b=AUr4xOYyR4HsX+QsJXOJfH7QsNc02jVsjseUqjsYjqsaOMGFoZ15kbglzYlxVeg1mzAhbujG8K4QY9k6hvHRqDSpqstpfanKX2rGU3w7mWRoZjQURYJCzbqbrjNbfGYYrs3QhoISMav4GZl4avqnX+US/pX/Ro4q+np7imjSStumEAZkcrjq3I6c4QSUJBQor+2c3/L5tQqLg0f52bG785I/YGwPLBN9gZZy5bkC/I88ijQ7jU/++2GfsJjh0FkrzA2yicPBP2x2V0pQVVLps2E/ItRIFheNtwaGN0viu/EHUVF0swCzVH6Rdyx1Elvb8gpl3IrLVvwh2+zju3+u3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd22jfU9sH8YbpYx9O5rvNGaA1qxERSc9WsezDNndtc=;
 b=Y7ax18WmSEe8qqesTLKBRY8FSSqvQO+735invMRUJcmyLjz5OaUSy20LTdrwDvmL5U0eKZcxpBtR5oJi2U/tT9sO7ty2yDn+slKx1t+xQeyaiWZAUA5EKnx2GQ2rrGa1sgQqA6ctECx2LcVa6jw/kg/qnz7oTKWQT/KZT2RU66s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DS0PR12MB9273.namprd12.prod.outlook.com
 (2603:10b6:8:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 23:10:32 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 23:10:31 +0000
Message-ID: <ea4eb63e-c174-40fa-ab7a-0a1a08b6542f@amd.com>
Date: Fri, 22 Aug 2025 18:10:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 Dave.Martin@arm.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
 rostedt@goodmis.org, Neeraj.Upadhyay@amd.com, david@redhat.com,
 arnd@arndb.de, fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 pawan.kumar.gupta@linux.intel.com, yosry.ahmed@linux.dev,
 sohil.mehta@intel.com, xin@zytor.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, peterz@infradead.org, me@mixaill.net,
 mario.limonciello@amd.com, xin3.li@intel.com, ebiggers@google.com,
 ak@linux.intel.com, chang.seok.bae@intel.com, andrew.cooper3@citrix.com,
 perry.yuan@amd.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 manali.shukla@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
 <aKaoYYm1ixYkVtyV@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <aKaoYYm1ixYkVtyV@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::32) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7e242e-fca9-4177-b33b-08dde1d11729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3A3RkRjL29hV0w5b2IvUXBBYjlZN3ZuUzkvaGc1dEU4VWRmSk1JbGxLRXdW?=
 =?utf-8?B?MVRIamJzWHhOclpucUhmTm5YSE1UcFdzUHlXSmFUazd6by9XelpGWEhmQUFj?=
 =?utf-8?B?cnFyL1duTlR4TWduSFMrMy9NanZiWDR0MWFjNDBkMzd0M3RYSm5VMUJ3b01p?=
 =?utf-8?B?Z1NZZFo4bGQyeWNCZ2htTnlBbm44cmFRd2lOOHlPYWFlTm5EVjNqTlUyK0ta?=
 =?utf-8?B?YS8vMVJ3eGNQOWkvRXI2Y0cwaTY3UXVYY0NaTHh0RVQ1MHJlNEZsTWIrS1kw?=
 =?utf-8?B?QW1QWlp5QjhWcHViMk82eU4zb2FRSE9JUENkK0FtZm1QVUlwL1JqbFcrTHVV?=
 =?utf-8?B?RmVEZW5LRHNZV3p2NWZzd3d3VkljanA4eUhEc054UzYzR3U2eGh2WlIyT214?=
 =?utf-8?B?RC9tbVljRlBLdm5pUkF5UjlSUTB2QWxwSERHTXU0dFkvdi9aUmt1VFNnd2lS?=
 =?utf-8?B?aE1Kb3NQTzlzMWNMQjRHODBRNXBaYy9XcTdvd3NFTDkyMjlRc1BZY1FpSlZ2?=
 =?utf-8?B?K2pSWXlnNkoxbUM2dFRBbkZHVkZrbzBUaFF5bG1GZENoYWVQOU9naXJHUzIv?=
 =?utf-8?B?SGp4SUtBdmNpY1NmMHpLWEliOUNKL0loSzFvb2JJNXlGUnRCdjVsaVBzazBz?=
 =?utf-8?B?dW9FbVQvVzNyaXhuNjVBVXZicHNSZVJqNlNZcTVHNk5OQjR5VGFmcVFBN2lR?=
 =?utf-8?B?TGY1L1Z1RTdhL2pPWTFZWmZWejEyQVFWZkVmOHdCREhrcER5cmE0N3lvOHpk?=
 =?utf-8?B?c0NFUU8remZxRGxVU0R2bU11K3NIT0RaNnJVZG9kZThVUW83endhZW5tZlNV?=
 =?utf-8?B?OE1DWUFuNVY5dGloWXhsU0pWVjlUcnVlQWdqMjFKUGtYSysrVGhpRndSa1Av?=
 =?utf-8?B?Yzd4VmErNktGQWU5NEFFRElyb3JGMjJHYzE0SHVvWGRJdkVFRWJwSjUxSTNN?=
 =?utf-8?B?THpzT2hFaUxCNXJlSmptNG1yOCtsS1phWUZCMFVUOEJMWWRVVHRRR1o4NGpt?=
 =?utf-8?B?ckRrMHBuL29JWlh6VTdDelFreDNIS2xPeGQxZWttRlFOWmVRT0lINDg0MDRY?=
 =?utf-8?B?Yi9Fbzl4YUtFRTk4ZFBhcTNGalhLN1FJWElaWURxOEc5cy91ZVV0cHBhVUlU?=
 =?utf-8?B?ZlBIQVREaGhydUdOSU5IeStONnBoY1BiWVJqK1JzdFh1MGdvdnFNUGx6Q1dr?=
 =?utf-8?B?OXdaZjZCZ21hdEw2UnpEaGxuMjJVR3NQOHV0cVVLUXIxV0dOZkNCTEdpRkRl?=
 =?utf-8?B?ZTB2cEIxRUtEbGNSaVhQcFppU1plZVB1bHRhUUdnR2JseHIzaXl6YzU5VURM?=
 =?utf-8?B?UFNHbmlWeTE1ck16a2pUWWdqUGlpMEIydHdHaS9PcnJJNkpxUUt0V3V1akVs?=
 =?utf-8?B?VDdFSHAwMXlqVTVZNFpQd0MzRUNtSmpJTUFsWmtoVzVBLzZYSnd6WlhjZXAx?=
 =?utf-8?B?Mm5vT1BHOUFudG82d1NhWFFBcFJDYytsRFBPWFpzRSsxNWpOYUNpbFpTMHdT?=
 =?utf-8?B?TVo0TThiUXA0TzlJTmJ1STJ0T3hGeWJTNDZQT0JZeElBRnhnSG1sTGxnNy8w?=
 =?utf-8?B?eFEwdGZaMm91dkIyUWJaY2FxRitWS1lGK2g1QUhveXRuNEFHQ1B5L3liWm81?=
 =?utf-8?B?clRFYVp1ZFpQVk9lMmxrVS9saVVPMWNuRTJUcVZYcjl4Q2RLSVRtVk80dlFz?=
 =?utf-8?B?ZFBzUnE1Y0VPUFFuYlJBS2duQjJjZ1M0M2QyWEY1c0lQZ3lZL2lYTDYzU0l5?=
 =?utf-8?B?M1IvZHlGT1JWOGs0ZjFyU0FxV2hwZGUwT3A2RFFhR2JLcTRzaDZ3SngvYTQv?=
 =?utf-8?B?dFJUMW9uK3UrRVYxenVEdml3eW9DdjZIcGlobTJvVC9kNm5MaTF6S0VFNVJR?=
 =?utf-8?B?QTNKS1lTcG80UmZXNjFmUXVUWGJsd1ZPWEJNWW0ySWlBaG40MmVOeHVVdkli?=
 =?utf-8?Q?GfKmvlsMUvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T005UGdnZmZiUUxlQ1ljSUUzeEtENE5sRTlLZFZIMGtTQWZ6ZkZsdmQ3QWlt?=
 =?utf-8?B?N0tBcFYzd05sdm9vb0RkaG54RHlrT3BXeldIVFA3elhLci9Cd2l5ZHljUElG?=
 =?utf-8?B?ODBCRE13WWxaeGN6S2ZkSytDTEJRdWZGcVFQRDFaaDVaak9Od0ZtdjdST092?=
 =?utf-8?B?Y2dCOG1yNjFVb3QzSUhyWFBNMXUvb3ZhdUhScktwMXdaeHM0c2g2STlvY1J0?=
 =?utf-8?B?MEx1Vm4xY3hORjB3NFpGZjJZb1VXRUVlL0ZvbnJ2TTNEeWp2d1Z2YjhMUVhZ?=
 =?utf-8?B?YXpMdDNEL28xWFROZE9jaGtpTzVHcm50c0ZnbFhtZ2VNUzM1czVneDJDNUlW?=
 =?utf-8?B?WXF1dWc3K3RDQUxvTnFDV1NhZlRrNlhrdVNLbHRGNE1nbTIzM0hMT2s4dEJp?=
 =?utf-8?B?dHlvbllwK2pmUi9yREpvejlaUWtYalNOM2gvQ3V4TVBiRTNQcnN1aW8vUG50?=
 =?utf-8?B?S0V6QWE0Qm91YnVwMlNJNEhNTXlCZm9nNWNMSWdvd0dXcUNEMjU2SER3RGNY?=
 =?utf-8?B?cmZFRWh0YTNFRmVJcTdTZ3JiYVpDR0RtNk5YS3ZnZXloaGI1TmtEZFg0OW9z?=
 =?utf-8?B?SXIrdGNQVCt1UVJvVitLeGNGWkx4TlhnWDVCdHFQeFJpTi9GZFlNNi9RaVk1?=
 =?utf-8?B?N0pwbk5IbUhnQnE5bVM2ZEVSdzAvNHlMb1RvNGQ3NGJwS2pqc2h2S1VuUFpm?=
 =?utf-8?B?TXFhMC9XNzlmdy9oR1lFK05kOUNYYXJManhSYldnSWIrWlhhVXpLTFIrQ05o?=
 =?utf-8?B?Z1JlUVJOMHZ3akd0K3FwSzg2TE5oZjVJdUFOYTArdWlielpxS2xnK1g3Z0l5?=
 =?utf-8?B?dktyVHBJMXV0My8ycFhPN3dRVkpGclRmUmVTcVZneDdxVS8xTWpkd2ZQMW83?=
 =?utf-8?B?Rnc1ZUorNjdhMmRoV0NqbWxXalBoOXlCVVcxclF6OWZVaEh0RXgrWUVHRXpv?=
 =?utf-8?B?a3cyZDJIV2JrM0JKQ29DQlpuaC9NQ3p5R24zc2hvbUMrMHFUQmhleUtYRHhF?=
 =?utf-8?B?SDJNbmdKN2w1OXVhK0NPWFk5blBlVWlrOUgzMDc5NDdZTHl1ejNxa0E3cTN0?=
 =?utf-8?B?OTFYdDJlUlJ3TG1tQTc2c2Z6aGNRM250Sm9iVi85NkkzYW40WTlWQnVMbTZL?=
 =?utf-8?B?VXR4NjZXQndpS2ZYWFMxRUVOMzFMbEVTb05yV2NhNzVGd1dtMXQ0dFNiVHE2?=
 =?utf-8?B?dTIxRDhKcmo2aG96clU5UHU5ekxlY2llWjJEd1BQYzRJNXovSWNaK3Awbkwv?=
 =?utf-8?B?a0hpOWFJK1JOTXJyZkE0TUI4ZXhHbzB6S0dJVDZhMTRDWEV6QWZLN0ZkNStK?=
 =?utf-8?B?Y0tEZ0I3QmUzT0dBUEhRb1BTYk5GTFlPV0RrVm9CaVlRNG1QUlJVZ2Noa0xW?=
 =?utf-8?B?bUtna1Q5VkEwMk5jR1VBdDNSVHJzY29lSzc0VEpRYnNTOCtVQjR1L09PazJU?=
 =?utf-8?B?ZHhOWnlkMjl2S1lLd2prclQ0WWplWVRPLzllYXFGU1VBd2FlYlQ0MXhTTWti?=
 =?utf-8?B?N2N6VTdFSzZIbE1pU0wwRHdNbnQ2SWh6SmFiZWJhYjZyY0FaM0ljY243VHpp?=
 =?utf-8?B?U3ZteE9CVkdTcUxNckNTenlrUDB4T1dmNWxLRWl3Ymg5a2tFRTIvZmNxMnR1?=
 =?utf-8?B?aXpyM2xKQkJHUnRLSFRCT0VDRkRuUHU3YUZOSlhiS0dGWk43cDMyTUNCekN5?=
 =?utf-8?B?WVhFYVA5UTQrc1ArTzB3VGdYRlFyNW9oUjkrVjAwR1FYUXlrVHVEMlRmMnda?=
 =?utf-8?B?QkxieUVCUkZYTzdSMzlrZXRHUk15YjhlYk4xY0RkTVJuckpHdmNsYWZiOUpv?=
 =?utf-8?B?NnZiVUhOWjRLT2ZhcVUwVzgwaHFKbjVrMlN6QTlwcmpzRjVwVE9ETExJNXdl?=
 =?utf-8?B?SVdmRlZIWkJCSTJYNk9DY0xodUFpVnhTUzBjMFg0c0dnWVJVK0Npc0tRUXlW?=
 =?utf-8?B?MzRBQ0k0RnBBSnJXZXdLRUx2UlNvRS8renBuOHZ2NWIrY21VRkdkWGpSVEEw?=
 =?utf-8?B?TTErUTNGdTJHVFB6RVUyQ2ZFUDR3VVFXSVVRMUtBREgvR05EbUh1S3dRMGRH?=
 =?utf-8?B?RDJxWjlqQjNCN2tVRC85emYzQW9EMDBpTnptTndQYmNBOFRiYzA3NHJRK1ZW?=
 =?utf-8?Q?+490WNM2OkC4oV8b89JYT1Ypo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e242e-fca9-4177-b33b-08dde1d11729
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 23:10:31.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzERerT8DkTaSiDPPVsx6CzPfr3rqDWzkbRf8rBNUIhcXDfVyCAfLRDN/w60nnA3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

Hi Gautham,

On 8/21/2025 12:02 AM, Gautham R. Shenoy wrote:
> Hello Babu,
>
> On Tue, Aug 05, 2025 at 06:30:26PM -0500, Babu Moger wrote:
>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>> devices into the cache.
>>
>> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
>> exclusively for I/O allocation traffic and is no longer available for
>> general CPU cache allocation. Users are encouraged to enable it only when
>> running workloads that can benefit from this functionality.
>>
>> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
>> "io_alloc is supported by maximum supported CLOSID" part of the initial
>> resctrl fs support for io_alloc. Take care not to expose this use of CLOSID
>> for io_alloc to user space so that this is not required from other
>> architectures that may support io_alloc differently in the future.
>>
>> Introduce user interface to enable/disable io_alloc feature.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> [..snip..]
>
>
>> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>> +			       size_t nbytes, loff_t off)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r = s->res;
>> +	char const *grp_name;
>> +	u32 io_alloc_closid;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	io_alloc_closid = resctrl_io_alloc_closid(r);
>> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
>> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
>> +				    io_alloc_closid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* If the feature is already up to date, no action is needed. */
>> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
>> +		goto out_unlock;
> Does it make sense to move this check before calling resctrl_io_alloc_closid(r) ?


Sure. We can do that.

Thanks

Babu


>
>
>> +
>> +	if (enable) {
>> +		if (!closid_alloc_fixed(io_alloc_closid)) {
>> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
>> +			WARN_ON_ONCE(!grp_name);
>> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
>> +					    io_alloc_closid, grp_name ? grp_name : "another");
>> +			ret = -ENOSPC;
>> +			goto out_unlock;
>> +		}
>> +
>> +		ret = resctrl_io_alloc_init_cbm(s, io_alloc_closid);
>> +		if (ret) {
>> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
>> +			closid_free(io_alloc_closid);
>> +			goto out_unlock;
>> +		}
>> +	} else {
>> +		closid_free(io_alloc_closid);
>> +	}
>> +
>> +	ret = resctrl_arch_io_alloc_enable(r, enable);
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
> [..snip..]
>

