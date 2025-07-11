Return-Path: <linux-kernel+bounces-727638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20AB01D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6E5A2599
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D162D3729;
	Fri, 11 Jul 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1DeWwHnl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FE2D3233
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240443; cv=fail; b=V/ai/nAxfKisjHTso5i5PERvIbH9dkMwXhY13lyxjMVl0L238GngAilQwUrOVG41wN5Cj7eXl6P+20v96HGzYTer07wOp7k/YquB78ICH1e0X6RaAl35/7y+CO1HHo9iku9+YadoXqmEZ8WTY38ThNbigViDTeVN7fqN1PrDDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240443; c=relaxed/simple;
	bh=LNWdHOT0v34N0/JLQAj9ZhRjjsfINdELMNkgVByHviU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJqdpn4B2PtDk0EYL1gKgz8sXLS2alzOp8AOZnlvNc1ljAHlmM8zoGUDow0gJLOWb6nENZrCpqureiwXQeDUqAZcq4pwxWTwgrETchqc85lYKUp3ZXNSgmzjonazTgF4UuvKjlrQziRwzfvLtX5MoyWWg8Fj4O0FUzNrP/6gzPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1DeWwHnl; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWqIxt4eDSFOYPnr5KRbfI8B7Yyk30DQZkDupn9iRz39VSWoNt4ItdZQPlIz3N4xjh+tR/7i3esJ02G9JhCZiA8iFeKASOzeJMMBdp68kBcyT0BEUsJCVy+w+o4PdZZwrWKePz/2wfymImw9jNddEU5CKgKn6x2Me3whirqpOnXY7121qtBRGcb4mPyPk9NTb+Ay4Y3s+6CowhCFriCa1IO7AOS9gngBFxVkQOqWYLzfLXnNbWHhFyRvMuVUcR3JqjgR3767UYHAJdgwqB+ExDP6oeMcu51U56C5SEGn4xg6oPUi3L3O3+F7aQBfBvd0yom6A4zeDgucs10PoGoKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1J+C4oVK5PK7Wv2l9Xig4/6Cw/0WTK2U3A77+juw7w=;
 b=PjE/mrI4xd+8Ei/ZNqs3N13yHnCtoTB9ssOtmw7Tx7Xf+FwaxFTvhEGb8y0wWiJcaohagJ5QgOm4k7jqjsSXlcxK7DD0jeJrn+AZQC/MoRoO3JFJQ2NhvEqtY3a/CqAKWb434CzBQmH+ogs9GIaDAP1dqNWB8SAQHtXVUTS+r3c2GaO56VAjuV0lOdC4AG/8emsLiL15jVKY188k4uQztzct+q1fZ92/iqSmecl6QRHgtrHpcGJMIRz7IpRQybfXJCr3dsxeMHRT9H7Lu+jTzvYs/Ascxa526AUiITB6FJazhxRD1rc74AQYqE42YExHxgUsvrHnQOrzwce8DPFzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1J+C4oVK5PK7Wv2l9Xig4/6Cw/0WTK2U3A77+juw7w=;
 b=1DeWwHnl5NqaXJcmrD1pX1lPyrPj4eJ8gmuqhEHoFlZaoboqZATqHLZ/lDNCJLy2UwLr4YXv8OEvAoURzbDk6EoLFuLxFgjOPdcKJLaKPSKSJgHbPFhs2mZDgw1ZhGesrVPPCvl3BLvttdgGcJfzIGZvt3Uq/IXNOXzu8Pscxfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 13:27:18 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 13:27:17 +0000
Message-ID: <298b6a09-1b77-43a7-82f2-f362d3104f71@amd.com>
Date: Fri, 11 Jul 2025 18:57:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
To: David Hildenbrand <david@redhat.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
 <4fa268f0-d56d-4b6c-aced-06e7002efd28@redhat.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <4fa268f0-d56d-4b6c-aced-06e7002efd28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::8) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 55436aa0-29be-4e10-8158-08ddc07ea7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXp1Z3JGQWdaYkdkZUFJTWFLcFVDMTMyNEgyazR4QzlDTW5VcTd4UkpCbWZE?=
 =?utf-8?B?RjhxNXZxbzZjb1VRU2xFa0twUHBPZnNmRlVYME5YbVNxazU0d1JQd3pmNHhQ?=
 =?utf-8?B?alVkY0l5TGZRMVVVMTBpMEhxM1Y2RC9weDVUMkJtc2VkRElIRTNYNmxIU3R4?=
 =?utf-8?B?a2dLVWJoaTV5YWMvK1BBRFFpYWxiVlIyMG02TkZUdHgwd3VCNXFnelMxUHRl?=
 =?utf-8?B?VmxxTU1ra1lscTk1KzlnQ0Q1RVF4TVZ1c0ZrMFJpRXhBTUM0WXIzM1pzZGVm?=
 =?utf-8?B?bGJHV2IvZlRkTUtlQWZjT1ZXOGpwd3BYZjdwK3lqRENaSWNVTUlIZUdTcjhD?=
 =?utf-8?B?dlhFWVNYQ2tXb3hYaDl6aXZQbHNtaktpQkg5aG4wRTNBWDJxTVBOY3JTR0Vq?=
 =?utf-8?B?NVVwcm0zQUFiMTRveCt4VzFES0JhcVRQOHRBalgrQ1B2Vm5ZTVRhaWY4a09i?=
 =?utf-8?B?QXdZZlFhQ05UMFdwUGVzTkwvelhGNStBd2NtUFgrVnh5cEVRSWZXNEdFQzMv?=
 =?utf-8?B?T1lqQzRONmg2K25xcDB2elVDRmJRVWM3eWZQV1VrUUhvVDM2WlBZWXhDcnNR?=
 =?utf-8?B?UG12UC9LOW8xWXNrWjdPY1NaYk5UWkJmZ290SHppSnk1NFlIcVJCK2pITGF2?=
 =?utf-8?B?bW5hbFZHNTQzM1FjUEFydTYzWGJoc0JVNGw1elZJbGRueHhDeGhhcjhFZmRs?=
 =?utf-8?B?Z3lDKzM2ZHloTTV2M0NFZ05RbkZCN3JNU2Z0U0QxQXZyZzFKdTJNQXJFWHhY?=
 =?utf-8?B?NWxjY002YXk0dDlLa3MrVUhkeHJ5a0hjOU8wNXg1SGFpUUlJR1l6VWVHRXZO?=
 =?utf-8?B?azhndHBNSjBNb1RVUWM0K0F5d0ZadkhDNGFXaDV6eXBSNUdjRXJZTlBqRVBL?=
 =?utf-8?B?V0xqaDFJZW9NeUlPTUtXcVc2aG5KNmNHTzRFUjFKdGIxUTlQdysyN04wZkJ5?=
 =?utf-8?B?QUx1YkJUWXNmKzB5OWJpTG9BYjRSUjlmcDBGUzJJWVB0ck5Sci9EWTZ1WGM2?=
 =?utf-8?B?dzBPTGJiRkEwMGptYmZCamtqR0l5eGlHN1B0RzlYczB3RkFGN1pGY2thZTdB?=
 =?utf-8?B?MTZFUTRRSFdtNVZHVkwrRGFZbHRGbGZhWVZiaXpsckYvM0FvamJRZ3A2YldC?=
 =?utf-8?B?SWQwUitlSWoxTmhCWm9rbU9JUStXOWtWUWlrNlI5ajc3S2JhSExVQ01SYjRn?=
 =?utf-8?B?bHJodEd5dnBDS1kyYWZyVlo4akR4RkRNYXhoeUtuWHRqRm5sSVpDbGhxNTE3?=
 =?utf-8?B?emllVEQrZ1lzMnNYR2lMbUhFQUJBdVZVSXNZOThIR0R0Z0ZibVRuUDUzK0hD?=
 =?utf-8?B?aVEvZi9ISVlnOGJKM1RyUUVXcHVaUjNadUhZVG1pZXFsQmFueVlKZUZ0WEE0?=
 =?utf-8?B?UEpaSjYzVGdKaGxWZit1a0NaMmJJMlpBR012R05OZnMwaGxkdVpWWGkvZ2Zh?=
 =?utf-8?B?VittTWg5YVBndWRJUUZHS0JlbTJhK2NqNk1BNEdhWmdyNlI5aGkzUEtZS0Q0?=
 =?utf-8?B?cjV5aWN2c3VhRnhuclg5ajArZG5YOWh4Y0hkSW5La0JRdWlLZzhZak50NWw5?=
 =?utf-8?B?UkpNeFdQbUhmWk5aank4RHNUU0U5MmpaV2s2WUlsSHI4Tkg4SE5OZnlLRC8v?=
 =?utf-8?B?aUNhRHZ2ZmJxUlo4S2VRUkRrZ3JLT21aM2FrcXl0WVI3Mk85cjJvTUtTTXQv?=
 =?utf-8?B?d3VYOWE3Q2lSVTA4UHJWcnE5aUw3Z0RtQjNtM2FlajJYWGtvKzhDR0NqVEk1?=
 =?utf-8?B?cjkyM3NBd3Ruc2EzbnI5ekJYNTUzLzFQN09Mb0RLV3ZrTk5QcFo0RXV4T1RN?=
 =?utf-8?B?RWsvNVRocE9IMlREUVBUTXpDQmpGUVI1QVlKT091aTlBNTZWdkNRQTlPVSt2?=
 =?utf-8?B?NklkNE44a210SER4bDhnZTNsODN4N2tHa0dWeDY0aDlJdmtYODgrQzdwaTBE?=
 =?utf-8?Q?rV7Ww3yVd3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmtlYklOWHI3M1o2VXNiQU56ODZDZlpHbDFsR054MUYxL2NwNXk1WmlaZXBN?=
 =?utf-8?B?djRlSmpSL0ttdStxSGZlOGo5amNpVEFaSkgvODhjeVFtSnJVS3NGeWcyYTlS?=
 =?utf-8?B?SW9STDY0cHVwM2s4Rlh3QkxURmRrN3RQZnZnUFNHQ1QrbWpEYWJveHhjTFIy?=
 =?utf-8?B?anlBVXN3VXZ0cFhnUVZjN04xMEVTbXh2emRWeDAzbXhmY2pEd0xrYW1zUXQ3?=
 =?utf-8?B?ZVUrZmFYcXNlSytDRGhlSXN4M1UvaC9FcjdONmVxdDU3YlpnNVJzVXZvZ1Y3?=
 =?utf-8?B?VDBrSGp4V3JIQ3NWWDJtbnIxeGlHNEpCOSsxWklIdDAxUzdYb2gyTlJtb3VT?=
 =?utf-8?B?YWVHNFN1V25YS1JIcEpCLzdlOGF4RVdaWGVFN21JNXhPUENVNzlXd2YyNWI3?=
 =?utf-8?B?dlJrTm9oSDRRanBVZWM4aEpiWnI3OVRQSWxuYk0wYlN3N1pRRjVOL2RPQ2U2?=
 =?utf-8?B?cUhuQjYxWi9NMWlsanlxSDd2RkU0T1IvTFJDTjlKdUhncHBLcWJ3VnhwdFlq?=
 =?utf-8?B?ZzZQVFJ2ZTkwY1dmb3dVc1BhdVZSZWhTTDFuazJOdDhvMjZGbFdPSmIyNG94?=
 =?utf-8?B?UWY5b3pyaHRxdGNYT2lwTmgwbjRjVHpZL3F0SnZIMkhCTHBTR2JXM3BDMGFX?=
 =?utf-8?B?VjZoc0xmcnFJZG4yazYwYzRSL3pDNmI5QWlQMTNhSTYzUXViVkF4SWd4bWZR?=
 =?utf-8?B?SjlMb1ZKQjlLNDdrMUh5Unp4WjFoMEk2TXR3SUxWWHFOc08zQms0aytSTS9s?=
 =?utf-8?B?TURJVEFvdG1iejczS1diV3I1OW9MT0dtOHhpc3JwTFAyREtJYmFKR043WHUy?=
 =?utf-8?B?anJTRlJNS0U5U2VpRzZFMFpyK0NGRGFyaWhhREg1eXNGem9QbTFFNEh4ckgy?=
 =?utf-8?B?Y09qVGRjQ3lUbjF1ZkQ2R3ZUTjloTG1lWjhseU5YNnNLbWZBQ0tsbWo1ZnpR?=
 =?utf-8?B?U095eCtCdjZ0d3JBL0pJSnZaeU9TNDFWbGtwOWdjOFAxVTRXaExhbWVNN01h?=
 =?utf-8?B?MEZPWEd4SERJOHBjTHJvaFFraWFvN0hETlhFOXorQ3Y3SENYQW1sNFFSbm43?=
 =?utf-8?B?cW9yQVR6aEFWWGM0NkZBYjlDaFltaWwycERTTUNMV2VJeXpCay9PYldyanNh?=
 =?utf-8?B?eDdhRHVnTG83RHpvQ2M5SGdhWXRwRzJaS1M5WllwV1ZKYTRPVlRtbGcreE4z?=
 =?utf-8?B?WXp2bk5TeHNvcERBQkliVVRvRnBEd3RNYUI2R0d3UkhFUzVhdThBa21rVVVW?=
 =?utf-8?B?WjVaV1hrTU5vbHhZYUhmaXBlQ2lpZW1Ta1ZndGZ4Q2czZ3NvN2FyUWMyTUd2?=
 =?utf-8?B?RTA5Z0pvWTdQMk9VK1pCK29xajM1MUprcHBOQ0c5QzROVnR4T1p3ZHRmanhj?=
 =?utf-8?B?RldJR3lJT25XUkNHcU42WUdQZmhEL2Rvb0dNZGQ2Ky96WE5QMVN1ckFUbDZL?=
 =?utf-8?B?TlN2QTMreEFXcUVDdnhmQXQzalZBZHJqL0ljS29ueUFwVGg3M05MOUh2SEtu?=
 =?utf-8?B?aEJiNWpnVEJWNmV1R0R1NmxpNDIxNS9yb3NHOFFxVDJrQXdMdy9tem00eVRU?=
 =?utf-8?B?TXNUc1UxY0t5bmQzZ00zV0JpdGVpdXc3WFJESmF4QS9xRUFlV25zZVovdS9k?=
 =?utf-8?B?ZDh0VTZVdTd5TTN6UGZrS29oY05DT3gyMEV5cjcvYVJZWEcyckc2Rm5YaDNN?=
 =?utf-8?B?dzRRUndaZ2xMbzM5WHpSWURxUFlYakhuNy9BVS91bmo5YXdiejY4RDBXMmpQ?=
 =?utf-8?B?U0Y4WEp2V2M5K29QM3hVdnU3ZWZDTUZYU25oTjVRZEF5c0JKMHBFMkZEZmll?=
 =?utf-8?B?b2R3alp0cnZqemVocGsxa1IwaTF4RzJjbWI3UWhKRk1Ydi8rWHBTeHpwaWpI?=
 =?utf-8?B?WCtlK1BFdXBUUDMyUVdMSkRtRGxBZWljb25rdkdlSVEycmdFcnhDOENvcFVZ?=
 =?utf-8?B?dGtQZnhHRjJYbk1QSlkyV2MvTURXT2JtcnluTE5sTEFWeE9KT3I4MUExVkZu?=
 =?utf-8?B?dnBzZ20rNURvUW1zbXlrZlVhWXAzcFFPOWx2anZtNURzVmFYaU5nVlpnK2sw?=
 =?utf-8?B?UFEzN1REYTJGdHV1Q2xISXRHckF6QVl3bTBFVHkvWlFhMndyeDFFWnlsQnRl?=
 =?utf-8?Q?oqUi314qRicgu7xKi/ShEEkRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55436aa0-29be-4e10-8158-08ddc07ea7f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 13:27:17.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2o8FZjVaH/GS4BVcmdbf5BWYs4SQZ0jjid5c2tDIxGCmJw+7w6MC7VJnHGH7XImeVVjtJtR7pWZjrOmnhao4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807


On 7/11/2025 5:14 PM, David Hildenbrand wrote:
> On 10.07.25 02:59, Ankur Arora wrote:
>> folio_zero_user() is constrained to clear in a page-at-a-time
>> fashion because it supports CONFIG_HIGHMEM which means that kernel
>> mappings for pages in a folio are not guaranteed to be contiguous.
>>
>> We don't have this problem when running under configurations with
>> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
>> longer page-extents.
>> This is expected to be faster because the processor can now optimize
>> the clearing based on the knowledge of the extent.
>>
> 
> I'm curious: how did we end up "page extent" terminology? :)
> 
> "CONFIG_CLEAR_CONTIG_PAGES" or sth. like that would be a bit clearer 
> (pun intended), at least to me.
> 

How about CONFIG_CLEAR_MULTI_PAGE ?

> We use "CONTIG" pages already in different MM context.
> 
> "page extent" reminds of "page_ext", which is "page extension" ...
> 
[...]

- Raghu

