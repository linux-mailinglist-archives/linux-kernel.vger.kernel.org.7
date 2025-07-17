Return-Path: <linux-kernel+bounces-735558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5DB090FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D6B189C316
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2D2F94BA;
	Thu, 17 Jul 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yf/27jNf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BA2F9495
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767688; cv=fail; b=djc/CZORWM4LsQRWJVFqDGu2jSspzOQ7quNgAxmTzqHQiB7nOksbK5JA0lg6LdRMcjHvwVVSwZ+WyaCXDfjVyhA6V4lD7+Ll8wEjZJ3E5ctKy8QdllhkRH4entNfaBOVE/eyf06429clhZKIP72DnYErhQwST4P3I2xBFJe7veA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767688; c=relaxed/simple;
	bh=tv4f/J8aV3rMJRtPdMN2y54nZdw2TOZST19UgkMBc2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzGkXCpzRjqxxfOreUaxSNszXJVSvVlB0fjyS0HyBGo8+ahYQatV9xdmadhyPyTjLoIN08sos4oFJFNAzYxrYub39I6wCkC4GgTkTouOQWlbxfYU42B40IObJM5uDIyQsvTCd7fiAoQ/xJyMENFVCHQk2sBrUYmYcLaxsLJ86bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yf/27jNf; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7cskeW8XWw/DuRAfnLMDIMtvMdWPsHr9zcuPoNmknlzticu1vThDNP9R3fJg0jEHDDjHKIhRswfnfCkxrYuu2+nr3y+6kyejFRu46UEuybzU9yVyJ336SarZ4SLUTpiLZuIFh6QiAok0VwBAntGVStx1v92fVe3PuGFlg1kB2O28y9VsFJIWyw6xcmyt5iCESwUlGUryBTWIVTfEcfIzFz1V1wogYXXorkwQfGY/+PI+fmjGe/uMizVDtcPlP2BD8nHhe6EMJSdyow/D9fzNs/n0bDI2N/EELrY0GqAubgwUoLECJGJNsZdKF59zgvvso+62U/U5WzlQJRc8pxu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6NGgzXe401zsnpYXJfIu71P3ICmsDcmpbUM1FgqsiM=;
 b=HV7uWg5FOSEWKob5pHNC+BMu9nayDg8V1YFXam0+O+ySydYDwk2Gr3jCAqixcWvsBosi9y8zBMrD7H8pDdOqIEDzvdG4bUshX4Eqjz7KLHYwxQRO/6zGwZiYahS63k5d1smJidVWXt7v1x4+7jz4uLkgmEpe1XjXrsc5IeOW1OaXOKB5m81KhrbOk10YXVsFqIxaQNgD/wDlZxMhB4kyAt3NUL9pfmzvymj+WbeENzNhNDRa3G0fa4wVKcJlhym3MqG1hQDNC0SoPvIwsfRum6PWK+y6XZMUpja0EL9sN7k7j0DjVrkqIKwh1+Eg9iHewTFoSVBEhOvJY3HjPYuYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6NGgzXe401zsnpYXJfIu71P3ICmsDcmpbUM1FgqsiM=;
 b=Yf/27jNfgx8jlY8gkOUs6UtG972dMc+yPcYkamzuTSsh10XwdHm8srefocdSt7q7QpPJJHKknuqXFQbAPnCwBDKZJDitbtTrsQ0JkHdFIVJugtzxK1CMB23Ph8zw5tkrwmCecJANXQqdHGMcmw5Xi5njfXf3wwXDVsghl8O2Y18Goq3zHTGiY2OQhF8YY1Y2/JyM84aHGBZpaYn5eSYOtsnEAHb/FdlhcBWdmp6w/83C2hEj/QwCmHnBcJgJ0IE8XYiH0xYoJS/FZSU7jR7VuNzXwNZzGZRBqT4PgU+HE8HeO16Ad2uRvTp4UGP4tpPbCzD76Bb7gQ2zGoaCCq5KFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 15:54:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:54:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] __folio_split() clean up.
Date: Thu, 17 Jul 2025 11:54:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8A30F788-2ED9-4F27-867B-BD97D23BB329@nvidia.com>
In-Reply-To: <1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:52d::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a6f3cb-27c7-4115-1ffa-08ddc54a3c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDVjMWl4WFpUY1R2eFJLcUdVc1pkYm9malk4VXpRSzU3Wklqc3FNcmd5N3J1?=
 =?utf-8?B?cUVmdXVqZ2dkM3B4WkVFMUdHYXhzOW4wa05Nd2xjdXRzRWsyeDJOUnE1bUxV?=
 =?utf-8?B?aGZPNTZWWHRRYlBQSjRBZGo5dXhQWmZGMXcwaVlwa2QvTlpNS1U5alZ6QU5q?=
 =?utf-8?B?R0JkdCtGL1pQZ0ZlSlB3S0ZxZ2xEeXNWUFR5ZkpGMzJwSzQ5dVJvNzM4WVly?=
 =?utf-8?B?L2J2Zy9JR1E3NHU0NFhXbmRUSzdZVmx2SnNVNnRBTk5kbWV4Zk9GeCthV3JS?=
 =?utf-8?B?MXo4dUpqQXV1dDdXZ0NocTEzY2Q4WVVjVElYQ3FqVEdZK1RJcjhnYVQ3bTY5?=
 =?utf-8?B?Y0FqM1dwaUtKQmxNcjd4ek5vTUhFTnNhRUIrS0djc1U2VmZyTlR4VHVSZHhL?=
 =?utf-8?B?UGxlMEJVK3BsQkUvVlcyMnlybVFBN2Yxb2gxTG0vaDlqcUJiWmhzaGhRN0Zl?=
 =?utf-8?B?alJBNVJ3ZnhFbU5iYVhWKzdxOC8rQzlxUUF2SXl6TlFLbDAyeUJFV242K3B5?=
 =?utf-8?B?RE9uTW1pcVgzSFI1WTZ5VGpSV3BCcE0zc1hOM0c1Vmo4RmFpTVU4djJHSE5C?=
 =?utf-8?B?YzBzWUUyL2lIRTJyQWpPVW9zbXZZTWxROVZsZGppSVIvZXNSOC9yRnpTZHpt?=
 =?utf-8?B?MkxabXBZVSsvZHhjaWRHNHhzVHRCUnlNM2hEVlcrR2hkU1YrRmtCSFM0ckVE?=
 =?utf-8?B?UFBWa0FjQmtuUmozRXhGQk40RE9LdjVkVUJraUNMQlovOGRvY1VjRmlTUjlr?=
 =?utf-8?B?TUdTNGJTMXdxenAwUEJYTUt6TlFoZERuRDE1V3FjYUFhUVE4RXcvQ2hXN2hp?=
 =?utf-8?B?eEdiRjA5WTdIMU95ZU50dDJVei9tZWdET0tPRStoc1VDaFZiRnBuc005OE55?=
 =?utf-8?B?ZlFZWUdLcFhxRHlHYm9OamRXektmTWI3SUQxZzBwdVlzNEFobkdkTDVuTHV2?=
 =?utf-8?B?aXJGUmg0cU5wOWxHM01HL1VXem5aUE80U3BDbVpCbXNETWZRWERqZUdZemlZ?=
 =?utf-8?B?Q1RrMURRTVAxZ0tQUTg0Q0lNZFpuK3N2MTQxMVh6UmVJVUFoMUJ1VlBqNHhl?=
 =?utf-8?B?Y3c1ZHhZUGxSQmlMRU5rTUp2VVNNd3pLUENrWWJFSTRMQ3RadWtTYWlhWkhi?=
 =?utf-8?B?citnQzd3WGQ3SWRnQTJSUjBXb3luRWljYjNMdUptdVRoZE1Vc0hUNUt1R1FJ?=
 =?utf-8?B?Y0xxdXZiK2lJZ2IrRVprUldRbk45MFNMb1JOZ2REdXpkb0cwYytaY2NZNi9D?=
 =?utf-8?B?WEkzeGxFV2FkSEJmZ1NYRmw4SUhGZG5xc21QbUI5N0NNZ2QwR3gwSno5dGVl?=
 =?utf-8?B?Y1RuNWhPRVp3ZzRoRUhRcjRFUDhzRkVLeGNhazRJTDJlQnlYb2pIdGR6YWFu?=
 =?utf-8?B?SlhsTG5wQWFBdnUxQ1BXWDE4SXoxUGZ2akwwT0dEQWM3V1VVaEpsSGlPNDA2?=
 =?utf-8?B?QnR6MFhTUlFXaWNBbmRrUWgrWjdja0pBZG9jM2grMHZTeDRzeGlCWmllaUNB?=
 =?utf-8?B?a3hiaHl4QWNBZTFYdmFlTXY4S0QzcldyUXNpMlhwbnJldWx6dWN0a2hqb0Z6?=
 =?utf-8?B?bktMNml6K0pUcWU0RjZHOHRGMUIySjBzVFdMRk5takY4SkZzTG40Y3BsM296?=
 =?utf-8?B?K0Y3NUpKWlpoUUVXc1dSRnVLZURjWGZUdGVBYXZrTWZIUnF2Y2JNd0h6TE83?=
 =?utf-8?B?OG1mbmFaUW1JVXlvdGIrMCtjbVFpYyt3clNHQXNSVWpZUUgrUDZ5VHJjdjgx?=
 =?utf-8?B?NmlId0ZWb2dEUzc3TGNkUlNFM052Y1o5TFczb3A3NEhOcVE1MGV4WWxHajRn?=
 =?utf-8?B?RUpzK1dGNDlsSEd0QVZ0ZitQeXcvdlFzOHJkOVhkNzg5WWpwa3FsdldDdTZJ?=
 =?utf-8?B?dExtdkR5S2YrL3lnTlR5cjJwWjhyN0FkaU12MDB2b05wVzE5WDE0aDRzdkVj?=
 =?utf-8?Q?yYKc/366mk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3dGR1d1a3RlSHRrRzBUL1lzS0V1YnpBejQvaUd6dkticFoxNENXaTJZajcx?=
 =?utf-8?B?MUxuRWhqTEdoOVlvaVduS0p5VzhZY0FzRUhKczRqQncweFJwRm91ajYrT1VC?=
 =?utf-8?B?dVZwWFJEOFZEV2hlNWhvczdYak5aeTAvYjcwYy9IY2YxclBHSUpRMjEydkRI?=
 =?utf-8?B?S2xicmJIazVvbDhHeXYvcG1qdTVXN3pzNTF1RnB5V2VRTDJyZTRZSnBxYjJN?=
 =?utf-8?B?UDhVQ1FEdHd2RlQ0amVrTUVqWE9UOW95SEYySW9TbTdoTUlwVHhEajRoTFdJ?=
 =?utf-8?B?eU5LVExOaytFRHpTRVp0d2pMNE0wdnh1T0NBd2g4L1hORCswaW5nc1IreGhp?=
 =?utf-8?B?ek1oSEFrU0xBb2YrUFc2MFJ6UFlMKzN3U3M2ZEZaZGQ4bFNES3A2UWE1OFpL?=
 =?utf-8?B?MFZVazNVYVlQZ0ZGdll5Qk1EZHdKS2NWbDhBQzVJUkJrM2VMemdLTkxQaXgy?=
 =?utf-8?B?NmhJcFFadkYxd3R5MUdhZ0k1elpkTmtSbTQxOWlaWHpSYVF1UldvWVBUNE9G?=
 =?utf-8?B?Snd6SlRJeTM0bTdCOEUwdFA5R3hWRklRdUM5UUxQZlNxK0UxcFJJR1UvZU05?=
 =?utf-8?B?N1VKd2FMSFBwUThERDVScEY0UEJUZUczVUJtUll0RWF4L3JPWDVzM1drNnQ4?=
 =?utf-8?B?WmcvWXpQOTNTRUU4NUJjTWxXNERaZVZvWG9vWlY3OERrQ05DTHh0ZkhTQUxv?=
 =?utf-8?B?dXh1RkFJYitjV290OXpnNXJieW9FSnJGYyszRVd3MEVUeGpKczZmT3JyeTNO?=
 =?utf-8?B?cldzdGFDQ0VBSXl3eklIUWFwMjR5SDlVYk5CUTUxQzFqb3ZGTk93VjdPejM2?=
 =?utf-8?B?Sjg1VjlCblRNVmN4c0JiTmdjSzA1MG1UWDEyRm9DZk1ZMnR3cHFoTzh5MGFz?=
 =?utf-8?B?R1BNRTJydHdFTjdxMHNTYnR0bldEV0hpUURoaE04YTRGaDBjbzdETzBoV0wx?=
 =?utf-8?B?ZFdpc05LeUNybXBxRTNuWkQyVjRmV3F6V2FiamZTeWI3aEpxVkZITXJjNnUw?=
 =?utf-8?B?K21GOVhQT3Z1Yi9EdnBxOUsxeGFTRnJFb0xwRjJleU5XNFprWkFHQ3ZoU2k4?=
 =?utf-8?B?Z21kRktoR3lTSVdIU0xLTEZnc0tnTEpxRTRKQUFUZUZDdUQrT040aWx2VEJj?=
 =?utf-8?B?N3o5WlVsamlrTkV6TU95WTI2K1J0UWd0NllVd24wM1VmMys2ekduSkh0SFdL?=
 =?utf-8?B?ZytNYSs4U1B3MEgweit4T0VCQnB2RDIvaTRqazU1ZUUzNzJ3MkNKNE83ektZ?=
 =?utf-8?B?SU5sSmp6aWtZMkd6NlEyUzIyVDVtSUdmc1VLVGtVczNNRFlWUUF5Q0IvTjVY?=
 =?utf-8?B?VDA4akJBYUJSWEwrdEpodFh0T1FQSUdKSTRCYjZ0Uit5bGFXREE1aCtPdFFH?=
 =?utf-8?B?VmQyUy9jMmhZRGhLZ1ZWRklHaWM1dFFuSjUzck9FY2ZZbWZWK2dzaFBPcjZO?=
 =?utf-8?B?UWpGVll6c1hyb1haaGpiZGlHV0c4TnFqNTBrYVlWSnluRzlENWd1dWtjSkkw?=
 =?utf-8?B?M255OTdvOFNtOUxoWnRxU1o2eUNQM1ZYOCtoMkYrcjFqWVpMSjkyV2tVR2Z5?=
 =?utf-8?B?QjZBZjR0OEtPTFdzK3hpUmpGVjNXYUk0RE5BT3J5RkpWRWU5c01NS3ZTM0ps?=
 =?utf-8?B?S0ZZQStwRDNTOTFablFLOEQrYzZIZlZVbFQ2ZGdYZXRXWHNFdkdOZ2JaekZp?=
 =?utf-8?B?SURPSXc2dmoyV2NhTmlNK0JicThFL3Vpek0vMWNkYksrYXhZd3RIcjVsTmE2?=
 =?utf-8?B?YVN4SG9FSTdyZDZCZTJnV2ZmdmxnNHBzVmxXcEVCL3BNLzREWXVSUXVSTjVX?=
 =?utf-8?B?bnJkNFdhZnhBTFV3eldZOGJBTitYNnBibzZuejhWRnJXUjBVbjZpS2VVN0Rx?=
 =?utf-8?B?MEVKOXhHZy9HeUUzTHZ3cGMyNlJwT20raDRmZ0hmb1FOOStDSkhMWk56dWZn?=
 =?utf-8?B?SXBDUThoaFErcHlPeFZ6L2RBWUR2UHdleW9KU3h1WGdPblMyWElQSTUrU1Ny?=
 =?utf-8?B?ZHQxZ2lGeGd6Q00zTlpFRVJ3SlFMb2doRENHSTNnSDRZMHdSaUVaNkFONENX?=
 =?utf-8?B?SFZLaEU4U1pQa2NEOG5mcjVGenA0ZitpVnRzc0RUZkZ4ajNPZmlLUVBtUko3?=
 =?utf-8?Q?Ma6fmjf9MmpJ2BSdbuTrVtDe0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a6f3cb-27c7-4115-1ffa-08ddc54a3c97
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:54:39.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m9JKcwY0ZkmuqDceNEPEihVeaQTFrZtMVU3b+LXTc3yvT8SLMlAbi2mywjpS0NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

On 17 Jul 2025, at 8:40, Lorenzo Stoakes wrote:

> Hm something has gone weird in mm-new with this.
>
> The patches are in the correct order, but the 2/2 patch, 'mm/huge_memory:=
 use
> folio_expected_ref_count() to calculate ref_count.' contains the cover le=
tter
> and has the suffix:
>
>     This patch (of 2):
>
>     Instead of open coding the ref_count calculation, use
>     folio_expected_ref_count()
>
> But immediately prior to it is 1/2 - mm/huge_memory: move unrelated code
> out of __split_unmapped_folio() but with no cover letter reference.
>
> Andrew - has quilt got confused here? :)

Since I am going to send V3 (also include after-split page cache code patch=
),
maybe Andrew can drop this series and
=E2=80=9Cmm/huge_memory: refactor after-split (page) cache code=E2=80=9D. H=
opefully
we can get everything right in V3.

>
> Thanks, Lorenzo
>
> On Mon, Jul 14, 2025 at 01:18:21PM -0400, Zi Yan wrote:
>> Based on the prior discussion[1], this patch improves
>> __split_unmapped_folio() by making it reusable for splitting unmapped
>> folios. This helps avoid the need for a new boolean unmapped parameter
>> to guard mapping-related code.
>>
>> An additional benefit is that __split_unmapped_folio() could be
>> called on after-split folios by __folio_split(). It can enable new split
>> methods. For example, at deferred split time, unmapped subpages can
>> scatter arbitrarily within a large folio, neither uniform nor non-unifor=
m
>> split can maximize after-split folio orders for mapped subpages.
>> The hope is that by calling __split_unmapped_folio() multiple times,
>> a better split result can be achieved.
>>
>> It passed mm selftests.
>>
>>
>> Changelog
>> =3D=3D=3D
>> From V2[3]:
>> 1. Code format fixes
>> 2. Restructured code to remove after_split goto label.
>>
>> From V1[2]:
>> 1. Fixed indentations.
>> 2. Used folio_expected_ref_count() to calculate ref_count instead of
>>    open coding.
>>
>>
>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B5484=
5@nvidia.com/
>> [2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia=
.com/
>> [2] https://lore.kernel.org/linux-mm/20250711182355.3592618-1-ziy@nvidia=
.com/
>>
>> Zi Yan (2):
>>   mm/huge_memory: move unrelated code out of __split_unmapped_folio()
>>   mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.
>>
>>  mm/huge_memory.c | 289 +++++++++++++++++++++++------------------------
>>  1 file changed, 142 insertions(+), 147 deletions(-)
>>
>> --
>> 2.47.2
>>


Best Regards,
Yan, Zi

