Return-Path: <linux-kernel+bounces-819756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9ABB7E594
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EAB582713
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9072FC01C;
	Tue, 16 Sep 2025 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uu7Xn9bZ"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020095.outbound.protection.outlook.com [52.101.56.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7E2EBBA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066259; cv=fail; b=co2ta42OxsItxtLL+aOfU9UkvHt6sCUUbjuL+bunLc5ia/H4I+kfgCXtXFYg5/YVbS0KAh/IzZLYxQvTY2BWnDcbXqqFGBkLUuKoeIBo0qEap7EtZ2aFR1pwP1Y6WeOQ20f/zsMCen9z2Tm1PQMkltJQaECAT4xGjs01slxYzow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066259; c=relaxed/simple;
	bh=J9SQZvkcqOmXl5o3Qb+GKfEE/saQcJK9NJFi5np5bao=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d389MwUz+WEQJ2m0t3c5BMXNejM/1nAaAVXpdgu/iLg7Rcf3cDXNjOSF55WVGJZyGmLNZWTYlah61B/6lLsK4FwS418aT9Z6ct2zaEeJYVclEDzAdsR5qZAyAQ3sasC7zTzLgExyL786ZrT3Sae5Wcgf4P3sZbI/MjwycrEO+tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uu7Xn9bZ; arc=fail smtp.client-ip=52.101.56.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxF/3W7Mao8iCIkjFjHYwxtQ83texLOWU8hvnim2krIEW46R8Gt4lnu7hOynquojo0mBD442D2wOK4Uq5MZSzM2L0AsMJCkZbrt9n4OQYxSBaaPXKaJcC8otzs8MRSKYxqnGVgv76Biytnk1aT+R20bkQWUN2LHQCWl91GVjKHgIfXSrRhcp2wA6ODfb2DKtxlkrPRC/Wb2csliDDfSxIWw0W8HU6F4DSDCzBJAOLy8sH+K0kG56J2AJZlSua1segHwp8lqEN07Nn/9CrNFY2L7Cb/x7kLR44eIJHlDHWgF5L+AnPaTcqMyFiYG0Tz3zHLOiQxlPdEHuUiUTHa2nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CNy6JxfT0980Yp1xYtIn1xbJ4aMEVIaUM7SCDDcIYI=;
 b=p4UbdE6R0ASo8pJAL4rDF09AWUWHJaWeH1foxu/I03rxcR6lhYcUJCunPwlVph71kyL3N7HopdcKTfWF9ZOwH/y3prvzRDKBI4yiQf33RQeFMLG7kgoaVITmI6o5FD8Q4ch1f35Ew+7FL85onsnr2yeXyHukV1f7Rop/wH/q5hgilIHFXqbxupAmDNQ2FwcfbQvb1dSmdsN0DpHBfwaZYjKFkoVwK3yHtQeKVmXMVY6C/z+3LFScoYZaJsaqhAwZgQYrJ1LLnyqqdL70PUfYtcPEsxcjtF+/vGNPcB/34o08/jtsA7GvFGvqy7OG/mVoDEeNYJdTsOgtMwweMPBK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CNy6JxfT0980Yp1xYtIn1xbJ4aMEVIaUM7SCDDcIYI=;
 b=uu7Xn9bZJT5f2ayN4LmXJUNEeNpQckexgfGJ7Ht196f/eFpHcOpjJU/cJEgKXqnYXYtNjW4pbRcTM1jGkSOqq3+ElWnKXuU36ZXqG10QISdMBW1mXfSkuamfUReiP4FmdKhw/zWQcgq5RlGPVsi07vSMjSC9+A0rpQ8VBUpuplY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6574.prod.exchangelabs.com (2603:10b6:806:1a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 23:44:14 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 23:44:13 +0000
Message-ID: <9357a0fc-2c65-4956-b00b-0ea4eda2fb47@os.amperecomputing.com>
Date: Tue, 16 Sep 2025 16:44:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
From: Yang Shi <yang@os.amperecomputing.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:930:13::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: ba474afc-56c8-4610-d0a4-08ddf57af0af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmsxWE1PVHlwekRROVRhSE4xdCt0L3lpRDFPK0h5RVdsUVBlaEtDbm9vOWta?=
 =?utf-8?B?eW52NU82T0NqenB2QklNUFJTMzM1VUFJWnYzZk9mSFZPVHlTSTRoRklGa0VC?=
 =?utf-8?B?azZRcUV0L2tjbmEwR0daSktqYzRvTlVtOUNzcTlIdG1xVVpNTytic3EzVHFT?=
 =?utf-8?B?UHRQcy81R3U2TFlMQTM3bUlKTTc4bjJhSnRVencwU3pMYmZ4TVFTV0tDSndJ?=
 =?utf-8?B?Y2xzeDh3WGhWcEwybE5zUHl0dUtERlhFOExhRWh4NU92WmZjMnBTVk1IWmFm?=
 =?utf-8?B?SC84dVBWQithNGw5V3ZsNy9KQzBpK3VxRklsc202LzQyeWltcHBuZldOVFZj?=
 =?utf-8?B?NnErelpjTXFBTXhmMjFPb0dCVE9nRDh2VVBNdy96U2dDOWZQcVVtVU56K3RY?=
 =?utf-8?B?MUpPa09jVDYwQXNUQXM0LzQ5UExrWEhKZmJ0US9udzY1U2ZTN3EzVFdlaENP?=
 =?utf-8?B?TmV2WmNVOCtiSUwzbjJqSmoreHAxVVFlVlhhQWZ5bGJQY3pFNVNFKytCOEtM?=
 =?utf-8?B?alFjSk9vNks3YkhnaUMxMW82eDdUZEFNckNZcFpjU0VVRlhFQXJPbFJYaHhp?=
 =?utf-8?B?UWxNNlR6SFpWSHRza3JGWm1qaWMxOCtUZTkxcVhtK011Vks5S1BYMUt4bk1J?=
 =?utf-8?B?ckJzSEZJRUJHRkRJaHVPUHAxWDNPVUlYNG43NWdCcGplWDlacUVQMUNkSHlW?=
 =?utf-8?B?a0JCY2hiZ2pUVmhWdG5lZkVDZWJ6ZWpCL0hLVW5rR3JHaDJ4R1Q2Y21PL0VY?=
 =?utf-8?B?aCtYUTlKd2E1U2NvakZxL25oR1lXZHhmaER2eVp3aGpqc3JhcFJPaEJaOWV0?=
 =?utf-8?B?OHJaSlROSzcwMFZ4Ry9vZ09LYlUyRVgwUXZld0U1K1hZdlhYRzVZTXpSL00v?=
 =?utf-8?B?MStJMHNVaFNUNTdpc1Z2SlhRaERDYnZFazRaWkhQaVRaK3lQK3VjZXVhdEdX?=
 =?utf-8?B?RkhjcEQ5dzA2enhOeExwelV6eEdSeUtZRzhyZldoRUhucjhKMmo4U0dVa2th?=
 =?utf-8?B?bjB2bHlZczBiZ0NjOTMyMVlWcmRZNll3Nm1rQVdiNFZXbEx5VHQ0VFQrdm53?=
 =?utf-8?B?KzJ4L1p4SzNzdEhvL0Qybm01OWl4WVJidmlPcWNHaEdodVBYNGl6b3RlQ0Z1?=
 =?utf-8?B?QklFWnU2S09FZkM4aG0wSnpHbFY0UFpKMnNSRlV1eXRWZ3pyN29KcE5rUTJw?=
 =?utf-8?B?cUZCK2ROUFI1eDRvbGNlT3Q4NUtHUldhS0p3TWV3TXg5bXl5NDV4ZVRudjJl?=
 =?utf-8?B?dWI5c0dJdEg2ZERlRjdHSW5MNWs3bUQ2OWoySDZxbCt6aUs1ci9ZMUxXdCtB?=
 =?utf-8?B?bUdRN0hXa3RseG1WWThQUEJDODJDaHdML1p4RXJ1c2Q0ZmF5TGFCaGZ5ZEpF?=
 =?utf-8?B?eXFxR2s5cG1nQkxBUzAzeHoyVFZpb0ZMN21ZallYUkNHZVlQcExwaVBCSFdq?=
 =?utf-8?B?ZVJNditWc0JuWUdQL1ZRQ3VzWjg4WW95ZndrZmcyQzJXVEZGZXVQU3VrMkIy?=
 =?utf-8?B?aFhkYi9jMWpqRlUrdDBFR3lqaXEzUGNseGI5bWlUdnU0bFp6cTZ1R2hPRG9p?=
 =?utf-8?B?b1E4NC9KSzhsWk5xNEZySDhBS2I4bFdIc0ZwSk1YVUNUQUdQdWJIRXRvQmhV?=
 =?utf-8?B?S2NIUlFrM3Ftdk9FcnFSL2pOWlpVb1ZiT3hZQkdVQVc4SVZiaVVzaG1oWmZO?=
 =?utf-8?B?aUdpQTl6VkRQMnl1M0oyUmN1ZkRCN3IrSjRPMlg5N2YrSURHNWdlY2JQaFZJ?=
 =?utf-8?B?U2dWdm1xUzh2MTl1dmpDUjU0MU9qb1owWnBMZ0htbjdvbStybkRaZjJqSzN1?=
 =?utf-8?B?RzYvZ0FMVWZ3L1ZIejFOb1dZM1NQSi9FRVlCRjVWZjZINmQ5dmF5VFlObVBU?=
 =?utf-8?B?akgxRjdwMldvUmxDSmxwendzZmUydGhvdG1Mc2RubXRTckV2UWIwZ0FKeXNn?=
 =?utf-8?B?emxPWmEyVy96cVNFODhNSzBaTVcrYnkvTXlGbjYzSDlFZFBZYkxnMmFqS0J0?=
 =?utf-8?B?eUFLRDJHaVV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGlXSlpHb3NqU3c5MGt6eldrall4MUExdm5MTlVLS29lVlRhZ1M3YTNONTQw?=
 =?utf-8?B?bVFYU3UzOE1tcG5zVzV0VjBQS0lWbFJ5MXRld29VRVl3MFd4eTJTK1FwSWU1?=
 =?utf-8?B?VE9BNHhrcmxrbWQwd2p0dWhDdS9BcDRaMWdlYmhZRUprVkNhanZJN1hncmRK?=
 =?utf-8?B?ZStTQ2FNWlVlNXlJc3VFSTRUQ2FsaThaQXd1YUdnSzJHSmJDb2htWVhGTGJv?=
 =?utf-8?B?K1paVGt4K0lUdTlvYklHbWtDWjI3ZTRZSldYV25mYm9peTVKem1kZjM5ZGVx?=
 =?utf-8?B?NlZtVXhtMXJjWmJqSkJXbi9WRFFsdzFCcCtwcFVsWlc1cEdXYzVhck45YXFu?=
 =?utf-8?B?Zko5SklWaHJHd285RnRBQitmRWJyc3FJbFhMb1Z0STNGY3ZnNm1rVjRTYkFi?=
 =?utf-8?B?WUYyd2QyN2x1U1RuN2g2NEIybjZlTXpQaE85eUh4Wm1yMzUzU3Jzem01TGRE?=
 =?utf-8?B?YmxTeVJEcGdMMDBTY3VDS0pwU0lwKyt5YmVIcjFFOEkreHhBcXN2UGxSQXBr?=
 =?utf-8?B?TjBzZWdWaWwxTk9rbUNHaXdLa1ZUekk2MVpxUzRtWXRvWnppeE55T3RpQ0V6?=
 =?utf-8?B?ZitDTXhwY05RazFBQWswanEyQmpndFd1cHhSbkZWNlNIbXdVZG9xRVFYbHBX?=
 =?utf-8?B?WlIvYWFOOGszdGIzdXNYK09KdHo0WkhhbjFWYjB4M2xSSnZmOStLN2RjSGxR?=
 =?utf-8?B?ZlNiL25KMVRTV0IxbE1KVDdxVW9TSkxuOFU0T2R2VnZZd3hDUDE0VTF0Yi9p?=
 =?utf-8?B?THVtUGxxT0hsdXdWeEp1aUtwcFFBTHZKYzF6ZGQxSGV2RW1IbkgrMDJ0UFhB?=
 =?utf-8?B?TFpHYkxtM2EvVmw3Vlo5NW11b1NmSUI1L2dOTzRBSjFLNDZwRGdDT2czQ25s?=
 =?utf-8?B?Y3h6U0F6b1RacXJuMHo1bUF2VXJnbVNHUjlXNGlwTTdWbnAzYzJSRkdINnVh?=
 =?utf-8?B?WEdhKzFWRTVBVGpvYldBWnhXWkkwTi9vT3haMisyc1I1QUpVZzBPRXVMbHpC?=
 =?utf-8?B?SG9yQW92bzBhYlhmcVYyQ1czYjFrVVo1dFo5NWNQTEYwd1JTejVITURWR3VV?=
 =?utf-8?B?MkR5Y2dvdGIwWCtncWVtc2Q4RUpJUjJseWhTUGtBc1R5K3BqOEdZbDY2aytQ?=
 =?utf-8?B?MDlITi9OOWswR25mY20xcERKajdSbEhDZWl6U1YwRkFxTTlnaVlVakpFOFlL?=
 =?utf-8?B?Nm9NWnR5L3cvZWRiRnpBc2daNzZEbDlsQVJKWXlCNDN6SHowTk1RQW93eHJV?=
 =?utf-8?B?QnRZUVBlWDhiMkoxRUk5Z2F1MVJKTnVwT2pEclhuSUlxV3RvaHVOK3Z4RXN2?=
 =?utf-8?B?NmdVOG4wTnNEWHRrUVBiNzlGTWNMdVFTZkpWYzN2YTdIYXBYU1FVUkNXbXNN?=
 =?utf-8?B?clRqMFdUWlNkbWk1dkJFbnN5bDBsejNrcFVSS1Jyc2huRnAzVS9VZHlIaFNI?=
 =?utf-8?B?VkVPSWwrdnZkTEFsRlQrcUw3WEN1d21mNnQrUXlhQmlwNXZKYXF1eW55aU9E?=
 =?utf-8?B?OXVmMEJjd2Y1dGZIOWFLNGtSZ2VpdE9UMmQxU3MxSW5ZSjRFRDlxNzZsZUtU?=
 =?utf-8?B?MmFId0x1SFZGYjZXbmtKWXFXOEN3OEtLdFFReWJnWG5NOWFqeFVxVDU4MWdJ?=
 =?utf-8?B?MnFyRlFIZTY3RkRsRXlCL2NXRk5oN3dyMzNLZUZEb2tMR0p1UmxYUCtWakgx?=
 =?utf-8?B?RERZVzM2MEQwbDZtTTlEUFJaL2E2bjlkdmthNnBvR0s5UVg0SGhVT2VVZDNQ?=
 =?utf-8?B?NklkQXJ2dHIrYmdKektIekdsYjhRV2RLc0FEMUJ3aFA2QTd3VTdEU0NjZjVh?=
 =?utf-8?B?Wm5JRXp0UnhDQ29WUUdWYWs2UU5ndE9adTJHVGxhUzRReElkYTlLOEZPZGsx?=
 =?utf-8?B?MmptanA3R0s0dXNreUlxaVB5WWVqTTYwTUFUbk16YUxyYUQxbmZqRHllWGkr?=
 =?utf-8?B?aG9WaGdqNFUzM0lVVW5UYzlGMVVKSnpZYjJESzJHT1F2eHJxOTVTVVBCVWpw?=
 =?utf-8?B?Ym01dHFkdEI3MVNKOG5qVnNQaDZhVnZiUU9JWTllbm9QT1pJYllsaHJrd0JN?=
 =?utf-8?B?ZWdFZkRnSTRWMTFmTWRkVmJTMkFhL2FOVDdCWjM2cjhQaUZYbFRTREExU1FY?=
 =?utf-8?B?eEVtTzJRMm1kS1hMSnBLai9tTEhmeW1CdE9CVmwvSmo3TnZjL3JMSHdZVG1S?=
 =?utf-8?Q?NrriXQYMVZK/HAnoOQ5hDds=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba474afc-56c8-4610-d0a4-08ddf57af0af
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 23:44:13.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCbXYiEaN8p51s9WLRpl5i6GxBTOQLsfJcqRU1bHglT1dJhi+KBcfBokbJCaprz8OXa+sv5FWQ5KUZ4t6grVE8VRqPYuk6NeIJDsRUKjd40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6574

>
>
> 3. kprobe. S390's alloc_insn_page() does call set_memory_rox(), x86 
> also called set_memory_rox() before switching to execmem cache. The 
> execmem cache calls set_memory_rox(). I don't know why ARM64 doesn't 
> call it.

When I'm trying to find out the proper fix tag for this, I happened to 
figure out why ARM64 doesn't call it. ARM64 actually called 
set_memory_ro() before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX 
directly in alloc_insn_page"). But this commit removed it. It seems like 
the author and reviewers overlooked set_memory_ro() also changes direct 
map permission. So I believe adding set_memory_rox() is the right fix.

Thanks,
Yang

>
> So I think we just need to fix #1 and #3 per the above analysis. If 
> this analysis look correct to you guys, I will prepare two patches to 
> fix them.
>
> Thanks,
> Yang
>
>>
>>
>>> Thanks,
>>> Ryan
>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>> Thanks,
>>>>> Yang
>>>>>
>>>>>> Thanks,
>>>>>> Ryan
>>>>>>
>>>>>>
>


