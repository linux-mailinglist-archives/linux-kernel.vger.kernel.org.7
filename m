Return-Path: <linux-kernel+bounces-734324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82963B08003
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53D34A3AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B62ED865;
	Wed, 16 Jul 2025 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvyEo23o"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FF2ECD1E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702833; cv=fail; b=Jvr7NobJ+zPBjBhOU390aT/LJAiUAxnoIiHMKOfTGricDI7Dqdtbv2qTMwSViFK4bghTLPoY6T8xygpz1dIjAs+zH9W0vHlG5p2CB6ZxUMhYGhWXQAz541MONoXHD21bG/H/aZ2W0pTgzwx0WwAif4S+AHGYG8cVJQlZeStjLDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702833; c=relaxed/simple;
	bh=b3OUusLl96gRR1hKxFtcVzVzNR8gjBMuILGFtgOLIyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2SVGPb+Rqnrhou8XeasyHRp79N6ndH6vJzutC6zBuJJE2hSOzPnfTHWLdd2ktEBN2MKRGDDnDUDqVy2vB1a4/14DwHBva8dya9bC5T79xoE2fQjGJbivqMM9xk6K/fk4/51rNIkjPSjl7E4MZTAXEQvsgu12bihDtotN8Vuvqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvyEo23o; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7l0yiiPU/TNt+RKLelROr57N/8pzhtREpVmSIUmlogYjD443TLLh2EGlj9xzS6RU7tcv+Nqx91mpUrcJJdwbZDq5zDsZzE263DBNvtfWqbgDcF5pwIP0xpDM1QGZ3C8eawpnDSCE5PNSSRZhDXx52G0OlX98d0AplVt8UlKeYnWAuVhlhjSIOuFJkPUI3qmch48LRlpH3BOVj0Nyvbv8Bu9Q6UMHGbKURt18WRsfIjlT+3yzfFSkS1LaCvtRKFrO7bK21R1ZBt+P5STAG8lFo9vIcUCCimzyguJ2lBU77bi5EsOZfjYrycjg5bS1fAz2QDS38VaS+UTxwalDuc1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh7Yxvp6GdGci41yXZQ9WTB9YwsWNEyXv5UGjXgIAeg=;
 b=UsLDVX6utomUl2cQo+8wz72kJ6CCP9NMMgBdpF04lbbJf1Ls2kXboV/7gugVBIK5TBmgt9jwInmIKVcEs1vAQsRLtHBbPZYkHslC0P6UN3PSMbej9qfv4WqoQihnUn3osaAXvo3a3bJEWWnUzPLIkfUcW79M8K/MgISxyVcqwMB/g2lxNwDeo3SgaIxb5Bh1g2GxZGQspxwEbbHckl9feRPGcYvlsn2J1bw8gDDf/ENUL2oAcIu4ZUMJ9Sf/UU1xVyRMsIFsJNBZubS3kqLW5fbQ1fLvIuUIhUOUH9nCvMzy9gwDQkSJ2ATUHINb1HudQNXA7m7MgyewLL4sMiLSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh7Yxvp6GdGci41yXZQ9WTB9YwsWNEyXv5UGjXgIAeg=;
 b=lvyEo23oEOZXcbpRiHEj1nQkUEZA8ZfZDDxs5mZrGZWQbSbvANBgM3GYZXGLnOdZaH/j7bDMTN7EzFcUwjcey1hfMJgDryfFL6lyzVIxUlm1PpMH4vTqlLs32uzDmB2+YLRfoMYJTFIbmz2RED7wMEicgOkAUjko/OBe35NJrjffdrTKLVyoyf+ILbJwfO4P9HwwYG64mnHlVNAl54bRTm0fAjNafke79rqQJglwGryANm8aerdjhbG3z+jx8uKpmRwypt1J7J5/F6QaLgivWSz6L7upoWC9lyYbW0/PKAReeD0nRO8VkByCbp9VJ9GnatCWQzQ6/zLZqlzTDrHvgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 16 Jul
 2025 21:53:47 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 21:53:47 +0000
Message-ID: <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
Date: Thu, 17 Jul 2025 07:53:40 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
To: Matthew Brost <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e61a56-0eaa-4e60-bee5-08ddc4b33ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCs5ZWZSTHorZ2tRRHBrV2lIL3FvZlY0MmlHY21BNGowSHFvbGdBNDh1N21U?=
 =?utf-8?B?OVRvbGpBYTJZVHFDMjdrT3UyWkd3WXFITTRXNUhZTkd0ZHpkY0g2Zy8vVTE0?=
 =?utf-8?B?UkMxRHhOWTRFcENjdE53ekVDTlNsL3FkVU5CdGFaQnVYQXlNS05ZbVBjaDRy?=
 =?utf-8?B?bEprZysvTXdQL3BRUitWK1k5cTVXMXhyYXRHWmJ3WGQ5UUM1NGpYVm96WGxW?=
 =?utf-8?B?U2FhN01oSklxckkycXVZRnJHd1VSOEMrS1JUL3VSTUZDeFcwNFpzQ05tajNu?=
 =?utf-8?B?QTZ6OW92YloyTmNiNi91SmtrWUdML0JheWZVNHp3ZGVOSmg1YXo0M1BUTlY2?=
 =?utf-8?B?cml6eWVpZTJOME9BWS9MWDd4VC9mNzRYV1kxMmFjL2NjM2ZZTldZTDdDb0E5?=
 =?utf-8?B?N2g5NkhVV0tmU0V3UmVXVnJaMUdaNEp6Qkc1ZXZGaUVNU2hnU0I4ZlpZOGNJ?=
 =?utf-8?B?RzRnTlB6TmZoMFhPcjQ5RnNRR1BXQXBIZVRQK0dOUFppMXk2cFZaMXhIRVJz?=
 =?utf-8?B?ZXRIM0txSEd6RGl2bWJnc2VJeW9kVTNRdEtiM05jNkFMNUkzNHNiUzFRWDZh?=
 =?utf-8?B?VGdWdWtmd3VEdVZiaWJ4V3NMVE5lREJzbG5aVlZHSTk3UTAvRUlqRk9YMmU0?=
 =?utf-8?B?QU9YUWtzdjU5UVZLd2hmRUZDeXlhTXBaZWswd0RYZWNmMjVITHlEY0lPZ3Z4?=
 =?utf-8?B?YncxMEUyTE1yQ1dNcGFIMUZFWHBSWmtrZU1rcmVucEU4RU9WWGVSai82MDVB?=
 =?utf-8?B?QzNhamZOckdhbThBSjhUVjgzSjM4Q0Y5Rk5vMXpjbldHY1lnSnljL2IwUFBJ?=
 =?utf-8?B?MlZrcVorVzQ5Uk50QW45TjBkdm1OdU9kQWdlalJ5dnVjOVJSa3dlR3JFaEJM?=
 =?utf-8?B?Q1pUYWRjdE5MNEhSajQ2R3Zya1VRWmpIMDdxZDdyNTlBdXBJUWN4ZkhMTHJK?=
 =?utf-8?B?TjZTa0t6SFA3S3RUWCtuQ3kydTlQU25nODJmaFhpS1VwQzQ4R2lTV0VjL0l1?=
 =?utf-8?B?UDJpM0NFS0tsRERMSEplQ0QrT0Fjb2RlU2FoTXNZUnMzelpjTWZnYWtzQVVP?=
 =?utf-8?B?ZmxIaG1oMTk2VkM5bUk2UWhCc3Y2UGRxYTk3dTZzTEJuZis2cU5nY3F2WU5G?=
 =?utf-8?B?elVKRHh5S1UvYWdUdUM4YWVQTm9FSVpIS0xzcERRbnJ6dzY4MjBVbnFrb0Vv?=
 =?utf-8?B?SVdRWjFXQldRM2UrTzMvUS9ndnlkL1BHeVArdWJ5Qkt0elkzVzhaUlhzR1hv?=
 =?utf-8?B?MSsrWGFzUTl2WE41TXI3U1ZTRElkSHhVOWpuV0JTVHltbVZ0dm1qM0RveE4w?=
 =?utf-8?B?SFJkem40cG95ekpFMjlxYVU3K1VOdFNoeEYvakl0NHgwNUVkZUVTdlZKbW11?=
 =?utf-8?B?cjhZYjd1OVVoeWFvUG1mWmhSelVkODhQbXE5Zi8wTzdqYnZRTEJRQWUwTjhw?=
 =?utf-8?B?TEh4SDNHcmZEYUVFdU5ETlhvaXdmRFl2ME5WQkkzbmdncTMyRHZFYVhFVyta?=
 =?utf-8?B?dFpzM0MyN2ZoNGJzUFlGOWEwcjVENDA2eWpKN0MvOU1KY2ZaQ0tXN3MxUWRk?=
 =?utf-8?B?WHZuakRJbFhEZDR3K1RlVkZHVkNHb2VyMHZOZFJNbFdiRWs4bGtUc1RDUVNr?=
 =?utf-8?B?MnV5REZpQjVmMzVTQkpDRExpUnpOR1JUMjdNaWtLMFRoMmdId1l2TkhXM3lq?=
 =?utf-8?B?eEYrU2xoSmtTTytLczNnbEhsWXlQRnZyMWJGZWZleEdZTEhSa1RrM1B3TzE0?=
 =?utf-8?B?Q1RLT3hmZFhOSUdoU3VOM3E1NGRqUXVjb0lxb3lsWGMxNFIwbTR1TERPdVVT?=
 =?utf-8?B?YlpGdWhIeXJSRkkvZVQyUVIzQWh5U1lFb05HNWNjeW5RWnpvSC9RNStoL1JQ?=
 =?utf-8?B?bE96dnJ6SWdnZnVicnF5UXBCTVhGWDRKNllxTEtwZUlTV01SUTNLeGFaYlB0?=
 =?utf-8?Q?Huuz7wsE11k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzJMcjJ3dk5kTzBSZXNxMWxWK2MxUVU2aFJFNzFhZ2l2R04zUGhaSy9sSGhR?=
 =?utf-8?B?cCtzVGNNMElDTmE2TkZMYWNDS1ZIL1ZwZFgrUTFyL285SW4zL3VyZWFlVUZi?=
 =?utf-8?B?VmZ1L0EwcTF2Zm5OUENkTUZpdHFPY1lkdEZYYXhpbVVMSEUwdnFWK2U4ZnhL?=
 =?utf-8?B?QnYyRGlmQlV6amJoWC9pOHd3R3Y2dldsS29KNFNPYWI3UEFmdDFTSjVlRGZZ?=
 =?utf-8?B?YUoxMlFOWVVPR1dFRmJjUUFzSkJOV0JoVXg2akpuOGRNa0FsSC9CaWVnQmhP?=
 =?utf-8?B?NkgrMlRDQWRkOHVzL05xMHVyY3Z2cjdDL0tacmRiNDUrTU90a3dKTTFuOGZF?=
 =?utf-8?B?MXE0V053SmcxdkxkQkhYS25MK040TzZjNUR6bXYrKzUxUkZTSGU3eVVqRTIz?=
 =?utf-8?B?TFg1WlRuOGl3M2t1NU1HeXZPaDlqWVliMlhWTjhSemZjY2VZSEZ1b3hkcFpu?=
 =?utf-8?B?bkZhSGNOVlF1eis0RFNZTEd0WjEwREtLU2pKcFdmeFRhcUc2NDJ5MEh3N2lY?=
 =?utf-8?B?d2V2VGYvNUFqVitVblhzQTBrQytZc3NqMkNXbXNHQVlRejN5ZEZCa2NEMmgx?=
 =?utf-8?B?Y2FjbDNEY3ZnZnJxQVZHei9KMVg4R0tPNG90TnUxam1RRWwyRFF5Q25pNTNh?=
 =?utf-8?B?UWdWTlhMK0RrZmJVcE5HZmFFcTdSUUJTdkVqTytoZ1g1ZWNiYVBpWFQrclE2?=
 =?utf-8?B?cWRJUk5DbHZaNVVnVlVZUUM2V0hvUjBQSFhESVEzZzJQRERTN01Pck9YKzg2?=
 =?utf-8?B?WGp1RkU0UThOVEppZXlHZGk3MmhIVTh2SEhUdVBJcUtYRk96V0hBSFNLS2xw?=
 =?utf-8?B?dmluTWlRdkVHdFUrdGlOU3NVRW1sbHc2UXN4TVhXQzR2MkpvV1loUWJyc1Zk?=
 =?utf-8?B?aWZMejJFZ0dXT0c3RXBJRWZyRXg3Q0ZxTXBrRms1Y3dDSUNmbDJ6dmhCc3Z6?=
 =?utf-8?B?MGRHVlFUMDJ1L1l2eTgvUHRLeHBiU0xaa2FzcnNyZ0lsU1dEY25pOW9xUUVB?=
 =?utf-8?B?UmN0Z0dpUitXczJxc3dPcHhsaFZpRnJMTVJQKy9GRVBZUGJnc1NCSXBCZGx0?=
 =?utf-8?B?cDZaVUxJKzVoZks0Vm95MVJ3YzQ4MWtYSlFrcjJmZ3Z1YTJRT2MzeDE0NWxW?=
 =?utf-8?B?U0YzMHhrd1Q0QVVMajZzZnkrMWhRK1NiUjRObDJiTUdJVURlYlZRNHdMTHJY?=
 =?utf-8?B?S1dWSXV0K1hyTkNkNE9UVHFzRnVKVjBXMlZpOWYxRTd6YmZ2eGVjNHpnOUtF?=
 =?utf-8?B?a0tzVlhWL3U2ZWhpdjdWRC9vWjBzazJZVWZWQ0xSUXIrQnE3dHcwZ29Bckl4?=
 =?utf-8?B?QmdPeWQwTHRWaHR0andiNE1BdDZRR1JkUk9tZ1hIYW1QeFVhUWc1RGsrbm1v?=
 =?utf-8?B?eUlucjRrTisxbXgrSjJNbjZndFRrT0xhdkwyZHRkQmoreVJpV2JBSmVsdDRh?=
 =?utf-8?B?Vk1kL25ndDF6bVpQNXIxVTJQNFlUOUVYbkU3TXRyT3lERmxUVVV3Q3k3MHFP?=
 =?utf-8?B?NzV0UzFGc0Q5YW1GYStraTIva0o4WVl0ZVU5R1NLVzFlVi9Dc0JlN2QxMmor?=
 =?utf-8?B?b3ZVNTIrRUxEMkZ3ck55czNCK2JGL0dPMVg1R2QvbGFJRzN0TGtHYWtNT3ZF?=
 =?utf-8?B?bmt2bExnM0RGSXRxTEc3ZFRKWXJSYlJ3bFBmOWhwOStIVUVYc25qOWppSzFO?=
 =?utf-8?B?WTM0TjI2NDBxVnZNTEY1Tkl0Q0hmUmJLTndGb2tBTDVjN3ZXelpJbkNxY2tC?=
 =?utf-8?B?S3BwTVpaTWVkUSt1UWIvVDNScHRKVUZ0SUMvZFpwNVFpQTIyUEhvRDZqKzZa?=
 =?utf-8?B?UEZFWlVSWnAwUE5SQjBONVYxMVRKaDEvU0tvcHd0ZGlnTUg3YUVzSXNRL2tt?=
 =?utf-8?B?M3UwLzFkTW5sbUt6V0xjamY1WW94eGlQSzVhSEVoNWtmSm1GYndVWnNjdll3?=
 =?utf-8?B?c0hWd3A4SGc4d3BQNHo1WjJRVExxby9tdVRNMThNTFdIdC8zR21SUEFqZ29z?=
 =?utf-8?B?TXJTeFErSWdTTnVHcXpyM1hTd3pXU1RTU2tnVjF1UzAvK0ZoU2diYkExRXpE?=
 =?utf-8?B?K093Q2pTRFRHSjlsRU1IK1JUaTlYMTdiU0VmckhVN0V2enNPNENwc0N4N1lV?=
 =?utf-8?Q?MWCYXz/CGXB0zmlJH/ZN8DRXx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e61a56-0eaa-4e60-bee5-08ddc4b33ded
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:53:47.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz9PYbsYBBZGXoGhTDjGpA4v9yg1bZ5gQfj9YWuUMCJAHftvUGB2xS+FnITXCCTGg+1tJmOBAOMc8xn9Ih/gEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

On 7/17/25 02:24, Matthew Brost wrote:
> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
>>
>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
>>>> On 7/6/25 11:34, Zi Yan wrote:
>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>>>
>>>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>>>
>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>>>
>>>>>>>>> s/pages/folio
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks, will make the changes
>>>>>>>>
>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
>>>>>>>>> they are removed from LRU lists. isolated here causes confusion.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ack, will change the name
>>>>>>>>
>>>>>>>>
>>>>>>>>>>   *
>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>>>>>>>>>>   * It is in charge of checking whether the split is supported or not and
>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>>>>>>>>>>   */
>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
>>>>>>>>>>  {
>>>>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
>>>>>>>>>>  		 * operations.
>>>>>>>>>>  		 */
>>>>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
>>>>>>>>>> -		if (!anon_vma) {
>>>>>>>>>> -			ret = -EBUSY;
>>>>>>>>>> -			goto out;
>>>>>>>>>> +		if (!isolated) {
>>>>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
>>>>>>>>>> +			if (!anon_vma) {
>>>>>>>>>> +				ret = -EBUSY;
>>>>>>>>>> +				goto out;
>>>>>>>>>> +			}
>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>>>  		}
>>>>>>>>>>  		end = -1;
>>>>>>>>>>  		mapping = NULL;
>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>>>  	} else {
>>>>>>>>>>  		unsigned int min_order;
>>>>>>>>>>  		gfp_t gfp;
>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>  		goto out_unlock;
>>>>>>>>>>  	}
>>>>>>>>>>
>>>>>>>>>> -	unmap_folio(folio);
>>>>>>>>>> +	if (!isolated)
>>>>>>>>>> +		unmap_folio(folio);
>>>>>>>>>>
>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>>>  	local_irq_disable();
>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>>>>>
>>>>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>>>> -				uniform_split);
>>>>>>>>>> +				uniform_split, isolated);
>>>>>>>>>>  	} else {
>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>>>  fail:
>>>>>>>>>>  		if (mapping)
>>>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>>>  		local_irq_enable();
>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>> +		if (!isolated)
>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>  		ret = -EAGAIN;
>>>>>>>>>>  	}
>>>>>>>>>
>>>>>>>>> These "isolated" special handlings does not look good, I wonder if there
>>>>>>>>> is a way of letting split code handle device private folios more gracefully.
>>>>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> There are two reasons for going down the current code path
>>>>>>>
>>>>>>> After thinking more, I think adding isolated/unmapped is not the right
>>>>>>> way, since unmapped folio is a very generic concept. If you add it,
>>>>>>> one can easily misuse the folio split code by first unmapping a folio
>>>>>>> and trying to split it with unmapped = true. I do not think that is
>>>>>>> supported and your patch does not prevent that from happening in the future.
>>>>>>>
>>>>>>
>>>>>> I don't understand the misuse case you mention, I assume you mean someone can
>>>>>> get the usage wrong? The responsibility is on the caller to do the right thing
>>>>>> if calling the API with unmapped
>>>>>
>>>>> Before your patch, there is no use case of splitting unmapped folios.
>>>>> Your patch only adds support for device private page split, not any unmapped
>>>>> folio split. So using a generic isolated/unmapped parameter is not OK.
>>>>>
>>>>
>>>> There is a use for splitting unmapped folios (see below)
>>>>
>>>>>>
>>>>>>> You should teach different parts of folio split code path to handle
>>>>>>> device private folios properly. Details are below.
>>>>>>>
>>>>>>>>
>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
>>>>>>>>    the split routine to return with -EBUSY
>>>>>>>
>>>>>>> You do something below instead.
>>>>>>>
>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>>>> 	ret = -EBUSY;
>>>>>>> 	goto out;
>>>>>>> } else if (anon_vma) {
>>>>>>> 	anon_vma_lock_write(anon_vma);
>>>>>>> }
>>>>>>>
>>>>>>
>>>>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
>>>>>> the check for device private folios?
>>>>>
>>>>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
>>>>> in if (!isolated) branch. In that case, just do
>>>>>
>>>>> if (folio_is_device_private(folio) {
>>>>> ...
>>>>> } else if (is_anon) {
>>>>> ...
>>>>> } else {
>>>>> ...
>>>>> }
>>>>>
>>>>>>
>>>>>>> People can know device private folio split needs a special handling.
>>>>>>>
>>>>>>> BTW, why a device private folio can also be anonymous? Does it mean
>>>>>>> if a page cache folio is migrated to device private, kernel also
>>>>>>> sees it as both device private and file-backed?
>>>>>>>
>>>>>>
>>>>>> FYI: device private folios only work with anonymous private pages, hence
>>>>>> the name device private.
>>>>>
>>>>> OK.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
>>>>>>>>    the migrate_device API has already just done as a part of the migration. The
>>>>>>>>    entries under consideration are already migration entries in this case.
>>>>>>>>    This is wasteful and in some case unexpected.
>>>>>>>
>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
>>>>>>> device private PMD mapping. Or if that is not preferred,
>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
>>>>>>> sees a device private folio.
>>>>>>>
>>>>>>> For remap_page(), you can simply return for device private folios
>>>>>>> like it is currently doing for non anonymous folios.
>>>>>>>
>>>>>>
>>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
>>>>>> remap_folio(), because
>>>>>>
>>>>>> 1. We need to do a page table walk/rmap walk again
>>>>>> 2. We'll need special handling of migration <-> migration entries
>>>>>>    in the rmap handling (set/remove migration ptes)
>>>>>> 3. In this context, the code is already in the middle of migration,
>>>>>>    so trying to do that again does not make sense.
>>>>>
>>>>> Why doing split in the middle of migration? Existing split code
>>>>> assumes to-be-split folios are mapped.
>>>>>
>>>>> What prevents doing split before migration?
>>>>>
>>>>
>>>> The code does do a split prior to migration if THP selection fails
>>>>
>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
>>>> and the fallback part which calls split_folio()
>>>>
>>>> But the case under consideration is special since the device needs to allocate
>>>> corresponding pfn's as well. The changelog mentions it:
>>>>
>>>> "The common case that arises is that after setup, during migrate
>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
>>>> pages."
>>>>
>>>> I can expand on it, because migrate_vma() is a multi-phase operation
>>>>
>>>> 1. migrate_vma_setup()
>>>> 2. migrate_vma_pages()
>>>> 3. migrate_vma_finalize()
>>>>
>>>> It can so happen that when we get the destination pfn's allocated the destination
>>>> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
>>>>
>>>> The pages have been unmapped and collected in migrate_vma_setup()
>>>>
>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
>>>> tests the split and emulates a failure on the device side to allocate large pages
>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
>>>>
>>>
>>> Another use case I’ve seen is when a previously allocated high-order
>>> folio, now in the free memory pool, is reallocated as a lower-order
>>> page. For example, a 2MB fault allocates a folio, the memory is later
>>
>> That is different. If the high-order folio is free, it should be split
>> using split_page() from mm/page_alloc.c.
>>
> 
> Ah, ok. Let me see if that works - it would easier.
> 
>>> freed, and then a 4KB fault reuses a page from that previously allocated
>>> folio. This will be actually quite common in Xe / GPU SVM. In such
>>> cases, the folio in an unmapped state needs to be split. I’d suggest a
>>
>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
>> __split_unmapped_folio() is not for it, unless you mean free folio
>> differently.
>>
> 
> This is right, those fields should be clear.
> 
> Thanks for the tip.
> 
I was hoping to reuse __split_folio_to_order() at some point in the future
to split the backing pages in the driver, but it is not an immediate priority

Balbir

