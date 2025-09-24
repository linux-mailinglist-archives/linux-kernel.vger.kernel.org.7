Return-Path: <linux-kernel+bounces-831003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9B7B9B1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25C232333D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018A314A73;
	Wed, 24 Sep 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scVAGInN"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A52FBE05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736327; cv=fail; b=TZJ3sihQ878YtemDPBmnvHDBwUk79ZC6iFPkD3GJnQwMM6EpNeug9n43upcag1XWZRZkl3R9O8qr4XSk0aidK9N62xDg/gu89gzZ1WBaRscD9hIa/jaehsrCk5e5+S8xE4KdhojofdrGQwsK0m5Yx38/TVqznRwvLVzxcbUi4WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736327; c=relaxed/simple;
	bh=+jNPgZlWaQRPBEPPz5ICH7gKQnKKgGFldo9GVCPQ4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMnNZJZ2oj+zN4qpJYv7Z084dav/tQWVS0iPkkUC7jw7jIddzUFK6jJC6GXzn9e5vao7HsnWjFwNi3mOHYJwirVUjMlSrBfKMSkS0sCB8GATXMOspwRAgEbCu3VJgKJCsXRp4NIxR+k30ByIJJJkqkdvuGeS78uhbNtHCPF9sgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scVAGInN; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMmBDg5prQ8avfKR/zaexTt4bnyGe3L+Tuf4NG52de2ATXCB4KEiufyH9RLzmIhi9IyWLyVT89NOfIbmh8qTYIjMEPCDllVB6xHsqEfJqJE2dNIyUASlyvMVyG2IzaeHXa7kb3MS4MudG2GD3kvcgyCATjRidDBEUsGubR3AC5Kwmln69xZTvPrpxwBXziSX3fFosOJsdZLKPTS/c43iLt9BwEbJm70W3ehzC1EiAPPIpzWy9GVw/n1lsTr5qE/Gex315wb5IlpdYPj+Vud5n1ATnGHIofb21r2Sdn1NBgJZOzgIcnjCB07D2inCblKPmM6ijJi73GE+gV3MXUWxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmoGXR1TLO2QYxenKOFqFtPRIJ1zREnnhiVmRYY7Bc4=;
 b=ru+wGtNKIDi1twRPJ8HaZD1w9T/Cwq+L3q6zaHYZqVpgCVVUGbYmpNs/EfKelGySXJCqLEBUSqTRf3isyjL/nvuEj1KJ550F1OhCXKVZU4nlAZK0ugdWACDGrvEjEtsx+rDEP5XrmLSpHSoerTmPUJPvLeCdnU+aF63P2D8f1u0rB20qfmpbZAufNT6/lnz3/YPYf7ifh664pTiDxV3tkElTBbU6ret6HytvFKET5K+MSzKf1Xu+CVCgE6kUJGNCXsPCDORf11MURVA0bET/9E05KMCTZ6Ecmumgnfwd/uPHdVCD6AFco3yF0B9SQd7OAvzuIBRg5qroEU03z5OofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmoGXR1TLO2QYxenKOFqFtPRIJ1zREnnhiVmRYY7Bc4=;
 b=scVAGInNyEzqvBp99yoxFrUMbViVpzqa2LN6kbeoXwJafeC0IYg0C8KmRneDrSSkpOrqg+FEMpPbmuHfNHENmGW3A0O1ypG/B6xzfIoMmxy/wZNoNVVJgO0wDkogr/NlRrNu0+3ogtFi5Ts6N5EFHLJDTiWa/Uzri8AvoGYCSjXNYq4oXjKVxR5UZIpAWrhWCP/Ky3SgWGw/kVZGhzymA2+TA4F2ojpJdMgSvMEsmHzL9miFtlc73I7BZXjCtQVgrSp1dB+J8syZy/MwEOd12tgvP1DdP6O2TF7hEteMKIISiA+Q9EPKKrmRb2wy7WEKOVgy+yghH1+g2GLVByUR1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Wed, 24 Sep 2025 17:52:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 17:52:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Wed, 24 Sep 2025 13:52:00 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
In-Reply-To: <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f3d359-80ef-4e2c-a120-08ddfb931117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGVQVU9vRU1aVitGM2F2UVFOV1A4MTM1NlZYK3BiTHlQNkprSU54MHNFV2x5?=
 =?utf-8?B?Vjl4NWVCcVE5c2t4OWY1Q1RJTTh0UEJSQ0RGUm1nUXNjOGpOdWZsN01NQ0Fu?=
 =?utf-8?B?KzY5Wi9YTXNaaWcwelhhMXV3Q0JpL0N1T0hIYk5LNEpzbDQ4d2ZPM0lYM3Nn?=
 =?utf-8?B?N2RDRlluQTFSQjlDU1hlYWgrVmk2dVFyUXpXUmpLT3N1TXJUSnhBTmxiSVBm?=
 =?utf-8?B?enRBSzJ3NXU4bGdxUHIzRkRWaXRTcmh1VnhkNWtwZDZwV3p4KzhUOE1uWmRX?=
 =?utf-8?B?RTRrQzNrYWdtN3lJSUxSZHAzYWI2OUFPdjZwMFB2UURwMHg1MjlhOWI2U0ln?=
 =?utf-8?B?bVZEeEtoNlp0b2M2aUVkU3VUd0VzZjZyL2djelhBWFBkRTFwbVFsbnB5dm1Z?=
 =?utf-8?B?U2xLMEp5SkwwMFd2T2ZOZC9oR1NSekswL3RMeXR6ZGF4OEE3QzlQb0NaY0tN?=
 =?utf-8?B?bVFtR0poUFo1WTBRdlkybG9sYWxzdGFjWEF4Z2VWaC9GQ3JjTytpR3RBbHpw?=
 =?utf-8?B?dXZSR096Y0xncnh3WFJhWnA3Q2R0bmZNYzlzUU9lT3NjRTQ0eEZDZ3l3Z3pQ?=
 =?utf-8?B?WFBDVmgxZExyZU40R21SQjY5Q25hNDR3U0o2QUFIc3A2azZQNFNXa3ZSRUdX?=
 =?utf-8?B?YjF0aVJUelEyVDVHWTFNQlJvcG53c2lkUTlDWC80eDc3U21ZbURWSzZXRU5u?=
 =?utf-8?B?Q0FtT3dORjNwMW0rYjBpS2ZJcUdqZ0owRGVWUnM0VmZxUCsxQS9USTFaczRw?=
 =?utf-8?B?NDVCTmR1SmVVTlFxMk5WbGxPVXFoOUc1RUpVVy9Hb0o2bmdER2dGQjFzMlQ2?=
 =?utf-8?B?TXpXZTkrSkt3YXBuN2RWeTIvWWVRSWk0Y2luNmZWRFpHSHI3UHUxQXdHQmdF?=
 =?utf-8?B?WURnVDJoblQ2ZE1weVJ6dExSMytSYU00eW81RFBPSkRjb3VucjJGMGJUajE4?=
 =?utf-8?B?aU1NbHNYdk9LMkV2TVJITXp5eXA0QUE0WHZ0RTFGMjU1U1ZtYVNHbVVEMzAz?=
 =?utf-8?B?L21EdXpTQ0gzdHRMMVpYTTRaaG1aSWYxakNIc3VVUEthRjkyOUtsNkZleWdB?=
 =?utf-8?B?eXhkZVpEMmZMc0VrSUhHUHlBUmZZR1VJZm5VMDVQUC9QUFRScm93L0phNmt1?=
 =?utf-8?B?OWxkdWR0MTBxK3M5dnVsb3FzQkFHOXRySVFXUnYwQkg3TllVaGRPQVA0R0Zq?=
 =?utf-8?B?SjJwWStpM25GSWp0N1JuV1ZyVzQyZlZBUSs1bEl6bFl2eWk4L0FGMDY3RW5W?=
 =?utf-8?B?TEE3cWFvWkVuOHZmVXFMb25YWHN0MXo2YjlOWU5LMHNoS1RaRzRLQ3NIWENC?=
 =?utf-8?B?cVlBZXllU3d0VStUTEF0TU5LWnFhc1htM0t6c2hUd1NqTVRMZXNsWE1uczlB?=
 =?utf-8?B?OUtuWDlMRUo1dDNtSi9yUExrcVloall2cWw2ZkVac2dabitEc0ZkWVF4QWxs?=
 =?utf-8?B?MlhBT2hoUXhlODA3WlVsV3NOYS9GR2lMNzRhWUFsMTFjZGJJcXJJM0p4a0Jz?=
 =?utf-8?B?UDZ1aDNxb1BXME9tUXZhdG1ycWFxd2FNZkFtSWJDaldZdlFYazVFM1lSOW9Z?=
 =?utf-8?B?dkVWSTZCSjgwVFJwQnNWOXFLMGxoSEZHM3k4ZnUxRUVDbGJHK0FFWklCa2ta?=
 =?utf-8?B?NEtzV20waENHZWVTa085ZSs1OTk0WTZreWNRekE4Mmo4ZjZSZFVlcjVNZVBZ?=
 =?utf-8?B?LzdiNTdWZGVOeVVEWHNYeXRuQ2hoOUJtdUFYSXMrTVdnNFNPbG9zSzZXakNF?=
 =?utf-8?B?SnZVZ2VFMlh3ZFByY21YYlpiQjQ3QUJaNVpINnIxaGVxeURsVEFwdklQbjhp?=
 =?utf-8?B?RXV1bk1CdjB5cGpldHp3OW9iRTBWN3p2OWpMS3dqZ1pDSUNvVzBpemwzM0k3?=
 =?utf-8?B?b1JwRWZRY1BXanJBMDBHWkowNDJDdXpma3BVc0dpMURGY2wzcHYrOTkxUmNr?=
 =?utf-8?Q?dGnVtbXlALs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDh0S005Sm5jczVEZXRxajhTbUFwRDRSNnJmOVZhbWpHMnBqeXNIWmNha1FK?=
 =?utf-8?B?R044Z2phWWhua2o5K1hzRTA0b0x6Y0xUZ2tBL3A2Nnp0Z0FGQ3puSEFwWmZu?=
 =?utf-8?B?K0tXQmdJMWprc09SRHRzdm43US9pdjFUK3piVDhxaXBGbUV2L1lrOGZpQWlE?=
 =?utf-8?B?dWVvWE1rb3gyTkdKQVUwUjFlMnRaUW5BU2FCcEUzRGdHN3o1U1RTWVZ6eGFU?=
 =?utf-8?B?ZHpnZE5oaXNPd0R5bTUxcTNGcGFWVGQvNXRzYmdaSmt0L1RCU1hTT1JZZzFv?=
 =?utf-8?B?WmVRdGcvSHpSZnI3aFp0NG1tNldWVGt4ZGZLQnk3Rm5JVTZTbjBYaTh5WEtv?=
 =?utf-8?B?RmR2QUJyeTJWblUzT0lDaGdnUkY3US9sYXQ1NmhaSGd3UE15KzdYUFlIbWJV?=
 =?utf-8?B?eGVuZTQrRWZCWlc0RlpMWGxpYTc3YWV5Z3ZHRCs5K0NTcEZ3VnBNc2dCdU8v?=
 =?utf-8?B?RHltVVNleDhBamsrVTFFZEloTjRzOUd0NG9CSklSL0FLS0NJVUtiNWdZc2Vu?=
 =?utf-8?B?dnFvS2J2aVQycE1MTHhwRmJKS0NGLzVxZ3ZlL3BRQjBpUkpEUXlxOG54MU1o?=
 =?utf-8?B?U2ZTaUVteW01U2pHUjVYd0VSTWl1MnFSVFZGdnZ3V3J1ZGgrTThoRDh5U3E1?=
 =?utf-8?B?UkRjcW1LQ1IrSHB0Uk1RbCtGT0FlMHQ2QXZXTi9Sd2poUmxpVEttZWphVE5h?=
 =?utf-8?B?TDR6anJ5K3hqU2pwV0RRRUk5TkZKcmNEZDRnVHBXSFE2MHBnQWQ2WXgrZDYr?=
 =?utf-8?B?OWZrdEMrRDh5UHd3b3JqTytXVnJ6SFVoeU9vdXQ4TFpLUkNwb1F4R1dYSkpz?=
 =?utf-8?B?aS8ycm1nMytkejRLcXArY1kycmo1Q2JabWtSV2VHc245dnJ6MDdrYytmNFRX?=
 =?utf-8?B?TFQwSkY1OHdObFZvRi80aFRwRWowY25jcU04dG9TTlZndHZYNDJJbGJzWlRD?=
 =?utf-8?B?VkFic3kvWWFoTUZhZjU2UlZDVW1CclBpeEt6TEU2eGlCY3VXVjB2d1pyVVQ5?=
 =?utf-8?B?MkVWc2wxWlZTMlFYd2xZQStzRGJjOFNjL2N6ZEYwUHdDd2gvQy9vcVZaWW9w?=
 =?utf-8?B?VlNZSXZVQXp4dG14cmFYVUJMU1ZOdmd1cUlkcU9wV2JvR0NCOEZmUlRoNFZZ?=
 =?utf-8?B?cVQzREVRdWFjM1FoZEZ6a3UzNlYrTW83L28wR0J3RWhMbGZ6OVk2VjBRSStQ?=
 =?utf-8?B?MzdzbDI4N2JxYlFwSzhXSyt4VGZFSHN3SzdJek9YR3RTTUUxanFNMVZNb1FE?=
 =?utf-8?B?cFE0c1FLY2owS3Nudm5MYlBSdEl3MDVzcmM4dTMxaUtKNTdIbTA3UFYzQ2ty?=
 =?utf-8?B?aTExNTk4dXNyN2psL3MyMEM2NGtPbjRkS3ZrR0ZnbzUwTFpUUGd2NWJLeXRh?=
 =?utf-8?B?RFZnK1VFOXU2NEpZUjFqMVVVb0N6Nnh3aytwQ1VLR0dHOU9kOTVnbEZXUEFC?=
 =?utf-8?B?RmUwcktjNlhuRUh3SnN1WEszN3NwSlJwWFVsN3h0V3c0OFpqTkdORS9sY09Z?=
 =?utf-8?B?V3dYYUFaRzU2a0ZERnFKNW1LK21jSTJ6RE12UFhWbnNMbzhtMlNxVmQyRFAw?=
 =?utf-8?B?N2N5MStTWXVmMXNoRldvck1DaUFNWmFsUEc4S2ZSYmtLcUt0dFJISXVVaS81?=
 =?utf-8?B?OUhJRFdzelJEUEpKdHhaYkNUem85L0E0SzBwVFNVZHBOSjM5Y3RHbS9KempV?=
 =?utf-8?B?R2ZEckorSlJ4dVRSS1U4cUlLSXhHLzJBcy9CS2lhS0V3Q3NobzNsRURsYXRI?=
 =?utf-8?B?WVZzQTVqYUIxcGp6QzlXdEFnanZsM1NXTXZQU1krUGFCc3N2UjAxUDViT0F5?=
 =?utf-8?B?WlMzSG5IZ1lxaWhpbnpWQzdrMmtkUDdXTDBITFN5U0VGQitKQ2VZQUdWRjhH?=
 =?utf-8?B?aXpad1hWL2ZNZ0ZEaWdicHIxazF2NE1IeDlROUZnYVV3Q1h5TnRreTVYTkpu?=
 =?utf-8?B?THNaRXBPY1E2bVBIQWJWaDdaRFNVQ0ZKNkIxTFZVUGtnV0pTaWUySGYzTDNX?=
 =?utf-8?B?cXQ5V096c0N1Z2R6cmtENmNhSmd3WFA5VXBPczNCWjFobWJXaElJUmUvYisr?=
 =?utf-8?B?ZWtXLzczb081N2daYi80aG16Mk9UL3A3ZGE3c1ZxSmRKREIwRXRjWjJua2ZD?=
 =?utf-8?Q?XXeMsKk6DY62ikvz0TMXFvlD2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f3d359-80ef-4e2c-a120-08ddfb931117
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:52:02.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2qHFcjjWtzlYo2Kbx8ThoqMIl7t6hiYyquNMXOlxmkJWOoljz/DNpgOeFARNg3q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

On 24 Sep 2025, at 13:05, David Hildenbrand wrote:

>>>
>>>>
>>>> What I can think of is:
>>>> 0. split code always does a split to allowed minimal order,
>>>>      namely max(fs_min_order, order_from_caller);
>>>
>>> Wouldn't max mean "allowed maximum order" ?
>>>
>>> I guess what you mean is "split to this order or smaller" -- min?
>>
>> But LBS imposes a fs_min_order that is not 0. When a caller asks
>> to split to 0, folio split code needs to use fs_min_order instead of 0.
>> Thus the max.
>
> I'd say, the point is that if someone wants to split to 0 but that is imp=
ossible, then we should fail :)

I agree.

>
>>
>>>
>>>> 1. if split order cannot reach to order_from_caller, it just return fa=
ils,
>>>>      so most of the caller will know about it;
>>>
>>> Yes, I think this would be the case here: if we cannot split to order-0=
, we can just fail right away.
>>>
>>>> 2. for LBS code, when it sees a split failure, it should check the res=
ulting
>>>>      folio order against fs min_order. If the orders match, it regards=
 it as
>>>>      a success.
>>>>
>>>> At least, most of the code does not need to be LBS aware. WDYT?
>>>
>>> Is my understand correct that it's either that the caller wants to
>>>
>>> (a) Split to order-0 -- no larger folio afterwards.
>>>
>>> (b) Split to smallest order possible, which might be the mapping min or=
der.
>>
>> Right. IIRC, most of callers are (a), since folio split was originally
>> called by code that cannot handle THPs (now large folios). For (b),
>> I actually wonder if there exists such a caller.
>>
>>> If so, we could keep the interface simpler than allowing to specify arb=
itrary orders as request.
>>
>> We might just need (a), since there is no caller of (b) in kernel, excep=
t
>> split_folio_to_order() is used for testing. There might be future uses
>> when kernel wants to convert from THP to mTHP, but it seems that we are
>> not there yet.
>>
>
> Even better, then maybe selected interfaces could just fail if the min-or=
der contradicts with the request to split to a non-larger (order-0) folio.

Yep. Let=E2=80=99s hear what Luis and Pankaj will say about this.

>
>>
>>
>> +Luis and Pankaj for their opinions on how LBS is going to use split fol=
io
>> to any order.
>>
>> Hi Luis and Pankaj,
>>
>> It seems that bumping split folio order from 0 to mapping_min_folio_orde=
r()
>> instead of simply failing the split folio call gives surprises to some
>> callers and causes issues like the one reported by this email. I cannot =
think
>> of any situation where failing a folio split does not work. If LBS code
>> wants to split, it should supply mapping_min_folio_order(), right? Does
>> such caller exist?
>>
>> Thanks.
>>
>>
>> Best Regards,
>> Yan, Zi
>>
>
>
> --=20
> Cheers
>
> David / dhildenb


Best Regards,
Yan, Zi

