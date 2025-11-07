Return-Path: <linux-kernel+bounces-889994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE9C3F06F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4E4E7C96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311D2C0F96;
	Fri,  7 Nov 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UNoaDg88"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950E25C6E2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505507; cv=fail; b=JplvDZCW6qw5Rsa03s5c74TsO7xZHrVxgfEyTNHQppHHhsXWUh4WBC+OaDh7JWOA+q/ZmeW8oK3FqWhg6MZ6ErudqmFS1OTwUGg5v4EyaXlj1irzUN0zrJQ6ThuWIW5alUvgTMjJ3FLCjArVDfbmb4oF75d5YdHXCDwHKcziRMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505507; c=relaxed/simple;
	bh=0+w+DL+T7/RIHx6h5dnUIDVVOQHxuc3s6tu1W7wXTE0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4k6O5FnxeMAbkhR+drPEAgZyI7Y/cVfuBOyOA1FHgvs9fgpBkpDfGkm4HkOF4tqU/hrm/qea0iHdZj5PG+qbXlRwNqkQ7lM8B0sFj0ebZQJHkUqhxbmrO9OxHld1XLQzxjF7iYrk/D3R56BsfOV1pNmDfg8vwzXO9Lccz9xY7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UNoaDg88; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pelgtSGOA/8NQ8DB4r4DM0xTEKrg/Q4mGN7rtXzpxhMzt7mDSk0VWG/zum5KF52jqF52WlWOa9zsptqP8aWUbl2iOI3YXMQsgitj+Bz/FOnxQF17tNzfoMXNf/cI4b+PDAKSySPvVOmQLaLBh2ZkgS/8qMn1J6UIZE26euaE25iY//Gj1g4hRNcXoSRQ65QPV1qMyJ98rAsb7b8J+DgmKY7lH/yzHsnvh16cL6D1CJo5hsoaT+a/PayK2q8HXWGJHwDw+iaTVYYIwOS0gpyJfhQDn9gv72ahvFiCi9HX0QTHQxZ5uESLoxIdgnM7wAvmGDgWObUrz2Fd0xYn/HtAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBiOR6EQmH4XJnSVnYAM415SzfYnmLDJMsY1EGEls1Y=;
 b=drTI9oQW+sGMNBCHiNgR8PELgstKeR8WSny0ppec4n9UiyS2O4PxH01r7x+FxRUQ3eajAwTqOKVeVLlr8XYsT+XtC6DWi6qv/m2bPkFzLWC4/aiUV99nQMJypYsZ+ClvDpq1I5hsoOGGAq16qB1rM+NhTQYFexUkNMScWQ1hPlhdQKRDU9H3+rIDKaLTOG7/2a4Y3XMKC5XdffLm8F85l47QpYlZ2Y1sCdCwmedypg4UlsS2w+/42cDfNCQ+V77eNj3sZDeU19OTMugjxd9OrcBHq6kdFBfT0ldlNWXfXuGGgirdQ/X4tAM8h6Ay6rjEz7QTclUyPeF1e3CFDnrM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBiOR6EQmH4XJnSVnYAM415SzfYnmLDJMsY1EGEls1Y=;
 b=UNoaDg88x7vm+UCUnCDUxI/wtlDJUndqMHfEHNNtwOKf49YG2BsSUk2GvXRAPrBFxc4qaYiiiSGi4b0RV/nwoDvzzh+OuOCfbpMFWd0wNzU6pwomnFf5k1wnHqHdufJ4vku/83hsjcoLqzYtmcUyNpguosNR9Z2yCLTsjjoCqO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 08:51:42 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 08:51:42 +0000
Message-ID: <0b84865c-5b23-4be6-9902-af9d5e63c182@amd.com>
Date: Fri, 7 Nov 2025 14:21:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, zokeefe@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
 <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::13) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94d253-d8e8-4e6f-9b10-08de1ddadf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVJVZS9yanRYUWtTc2ZuYnJqT3h2NlhobURyZjlyLzgwd0tKMDVQOWRMeGVO?=
 =?utf-8?B?aVVXUG9VaDNjTXo2L21PbWFhdHR2ejBkTTJ1MU1QdkhiVzYxekNWZEkrMVlN?=
 =?utf-8?B?MWl5aUc5bDZLUGZ4ekdya2NNSUI3Y0NwRWExeUhuemE5bzBscVBrOWd0OVRs?=
 =?utf-8?B?dnNCcnRudWovVVdWTjR0eG9Ia0lMeDhVTlNLMElIM3NIdGpyVGx1Qlo2eXNV?=
 =?utf-8?B?SUtDNHpQRndzQVJFN3RVVUZobHU2c2Vmc0xSdFNsVWpKd003c0UxdURRYW5W?=
 =?utf-8?B?aFJoakNYODNxZ3B3c3FzVmRKUWRtMEVhQ2NmWXZqZFRCdThEU0EyWllNZklP?=
 =?utf-8?B?cjJDaCtqcDh2cUgvR2FReGc1SFczSjZMeFl6NS9KS3EvVWg3cDJDNGY5eTRZ?=
 =?utf-8?B?a3hNc2FXb2JOczhCMFVmZjhtMFNSaGhDZ3lnamg5RmxmbTQ5eUJGRFp6MEh6?=
 =?utf-8?B?ZEFJTWNzZ04yeVIyTUgwNU1ZTFJnUjNzd21GWUxJSEQwcTVibHpNTUtoZHBQ?=
 =?utf-8?B?bkpxbGJRSUlTUFlPNi82NEhrVjA1SHlYby9LaHpXaHlHbTBUbytEZzg0RFNN?=
 =?utf-8?B?dU5QczNjdG93TEdiblRBWnVGVjR4ZElhWVN0dmxEVEZFTjdLWCtnS09CaXdr?=
 =?utf-8?B?RVNxNmxTZVZwR3Fhak4wSG9NS0VJWGlFdURaNUc4YUpOdEx6TWIvV1k1Nlgv?=
 =?utf-8?B?UEpZMkFSRzNLZm9COWtqNnRBcnN2N2EvdkI3aGFvWUFZYkc5Mndmaklqam4x?=
 =?utf-8?B?QXhyWWx2RUl6cGowMUx5SXBTcDRQR25lemVoUlJINVViM3RTT3FLNnNjVjds?=
 =?utf-8?B?TzlGOWRGS3NIOFVtc1VzVFJ5RThyQzNEQ3ZYTXlhNytEc1lZQzl1V1BHWkVX?=
 =?utf-8?B?MktseGROb1ZNclJRNFBDa3pEUTFRSU1hYWFHMG1LeVQ3ZTFFS291aXg3VTJT?=
 =?utf-8?B?Qmd5cFdNMlRhTWZuTmtyWjNwOHdTcE5HSkRvcWlyU3dHVFBTMUl4cXY4NVlZ?=
 =?utf-8?B?RURKaENyQTFjdmYwL1BEeFFma3JmbWpmYmVFYUFTL1BBSUJDdzBGK3ZEeHdQ?=
 =?utf-8?B?bmE0eEw2QzVhZVpOZ0o5TTBtdE14YnJUcEhxS3EvRGlNdUpUcXU2cnh0V2tI?=
 =?utf-8?B?cE9UdHFvZWZPRjNKdm9PdXlUZ25ieThnVWVIOWxodzB4M0xyY3ZrdWlrdnc0?=
 =?utf-8?B?d1VvdGZrRG8rQkM5bHltZ1llS3NNbG9YNzhCQmI0bE9ibE1TbStiVXBLQ25i?=
 =?utf-8?B?aXdpUEI1MjhkVVJpVTBLRDI2azZVVGNBY0p0MVNXUkEvejVzNkhzS0pSWkdL?=
 =?utf-8?B?L2dyaWtSTDBET2ZwSTNldTFORnNWNm5xeG5tT3UrYU1vSHVrTXI2bXpnVml6?=
 =?utf-8?B?T0ZydUVFa0drREJDd3R5SE1KNjlBQ0FkOTJiRnRodU1JQVdhSzgyYmpJcWdw?=
 =?utf-8?B?STA4S01yOW52RERkOElveUVmSUJ5VHhqdXQyb3dOSDR3UGVtVzlGNXZPY1JO?=
 =?utf-8?B?dVhLSmxuZ09ZNndKbkMrUldTL0R0Q0lac2FOL1pna1BZUmoxRkZXQkQveXNn?=
 =?utf-8?B?RlVMZjZXN2E1L1JMdmd6eUpMQTVxUDhsSE44dHUxWTlkUFdncFdIRDlVWVVO?=
 =?utf-8?B?VGR2L0hxNHVkczdMblozdHk0VHl0VWdxSUVMY1YycEpVU20yYkhtWHJCWTJX?=
 =?utf-8?B?cGtNMWhNcTExbHhhc0V6UENGTHViZ3lmclhzb2ZoYWt0c3VsSFhGb3lydkg3?=
 =?utf-8?B?am5JNFA0RGxjWTFIUldScHB6VzRzK2d5MEYwaHBJbytWcUh3MXplOWZjOVVE?=
 =?utf-8?B?SHJNblpjaWZ1cGU5N0t2NjVZTHlOZ1MrUjBrWDZMcUtZSXZZeFhraGtkQTJk?=
 =?utf-8?B?T2FaOVJ4YUJYYkJEZE8xTStHTGlxWHJpd1oxS05OQ2dPcTlST095aGg1VUR3?=
 =?utf-8?B?VWVEcVFrN3U4MTFZeG5wZW5nVlpETkNTMXNJUTRQTHdqNW95T2R4b1A4VWta?=
 =?utf-8?B?SXlsUThKNzdXclRJZWlheUpNRHNOL2NIUVBTanROSUtwQ3ZBNXVYVWV0ZlZI?=
 =?utf-8?Q?Hv9o3I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzN2aEh6Q1ZPZytVRWFCREJWSmpkODVMV3NXQ2VyWUhTeGlKTlFiQXcyTHk0?=
 =?utf-8?B?S1ZzcHg2QVgvYTV3RnpYQ2FoSGR6ckNLRlpJdjIxdWFMdTFxOXN0R3VYZmZX?=
 =?utf-8?B?Nm56OGUvbzBmMy9DVmFEOE1rSUMzYk9HTXdjb3V1Q0ZaUy9mSGhjTk96bWgy?=
 =?utf-8?B?eG1EYnd3QjJaclJIeXpSeGlyWHBCRkZGRVlvdGxURGtrOUJJbkhLSTVnTXhJ?=
 =?utf-8?B?RWI0RElYa2F4N2M4SzBHLzJxVVl0c0Jwc1RvVGxqTyt0eC8vRTJDWVppY3V2?=
 =?utf-8?B?RkwzTk5HRHp5cGUzWnpZZHRNd2hvengxU20vS0I3b2hqYUc4dFZVcmVxOVhC?=
 =?utf-8?B?MW1WQzN2Vy9UcHVvRzZmeUhpNmYvTUVwSk5nMHVGVXZiKzdqclQ3VGtUN3h4?=
 =?utf-8?B?c2hmelJyR21nZnNqbktuVkF1N3FGeHdKYVN2NXRBM1h1THREVWdEVlJldTRi?=
 =?utf-8?B?S2JoVmN3L3pKSmtCUkhYNFBjVk5HMW5LT0dSYjJoKzNxY3U5RHBhS3FDclhh?=
 =?utf-8?B?VWpLeW5wNmxkZ1ZVWnZUYlRubnVyc3FMc3NJZXlweFRoMzNBU2NmU1VhN3Jr?=
 =?utf-8?B?TGVqWHp1ZHg4b0pmQlZlNXlGM3BVUUZzWTZMd0w2Qzl1RU94Z2RYUzFXWDNO?=
 =?utf-8?B?VmtRcTJCRVZGaGNQd3NZcGg0YllQMkg1ZXhmVVRBb1BuODMzbXJDVW9uY3JM?=
 =?utf-8?B?T3VUcnVoWlkyeWMvMU82MXlDMUR4N2tXRmM5K3pXMDNGUlM3SEp2eUdqV2xJ?=
 =?utf-8?B?cWUwd1FMWldta3Y5V3lhV3l5RkR4b3VxNzRtV1FsenpPQ3hlOE9pMWFzT0s5?=
 =?utf-8?B?cExQTk50RjhvamtqUHZ6VkxBakN4MHpYbGtuaHR1cE9hVnRlVTRac2NUTmlV?=
 =?utf-8?B?RVNiNTVnMlI1c2FTcUx6LzM0eEhPV1haai9Qc3pzWEJjQ2pyell6TS9XaTI4?=
 =?utf-8?B?c3JGN2Y2Rlh1MFNScDFyeUpkS0tTNS8xQytJYWNJSXZ5WDhjMklyTlVZZmVN?=
 =?utf-8?B?SjhVTkpwV2J5SEpOMEF6MVk3aGNiaWwzZVNMZ08raDNwN3JEZnBHRXppTGRY?=
 =?utf-8?B?b1k4aWE2aXZKTnpXalVwc1VqWk84SVJzcXNDbDhTNXdaeVhVKzdzSVFSOEZQ?=
 =?utf-8?B?RU9RSGkxZEs1VXFSWVJFcnVPenlBRUxhY21DbWs5eGtVM0tUS2RTSDBWYWhY?=
 =?utf-8?B?K2lnSmpsc2ZQOHBMYldoVVhCUWxWbFduUTRudVU4ZCtqTXFSWEdEWklZaUFr?=
 =?utf-8?B?bnNZT0wvMzFhWnF0RFJiUktxb205ZGdZMVp2YU5OeXRCc2FtWFdzaEF3MFVa?=
 =?utf-8?B?T2RJbVFEVlRMUkZqV0F3QndreHZRNGFuUWYrYStnUkFsenFaaFpJTnUvVndu?=
 =?utf-8?B?cUZqK1BodkRYTjBudnQxWVdteUJkbU5BNSs0SU1aRy9UR05aNkJ4UmxGRVpu?=
 =?utf-8?B?OVV4VGZkamloOURrUytKMjBIM0t6WWEyVW5hc1NWUW56Qkc0N2xPYjB2K2VF?=
 =?utf-8?B?NzAvWllNalRmVWVKZXhNMmIvRE9ZbGNraDg0bUp5MlJJb3NSK3p1c1QvU3F1?=
 =?utf-8?B?UHZhclk2dHg1VlNEZkNwQkhXT29Sa2VMQS9HaFA1cExEOHk1blpNaGx4Y2hs?=
 =?utf-8?B?V3FkMjlSc09sUnlxRHJ2Y2JsZ1cwMFJQclZoRTNmaFMrTTlxYUNDM2RPZzNt?=
 =?utf-8?B?b2U4VkRiek03ek8zUldrRU1XUXZ5MUhLaHpDY25NV1dKaXM3clFSaExqNkd6?=
 =?utf-8?B?MUg5ckowZ2lPNEFKeS8xcHN2UHRZR3FhWTBvRUZqd0ovZWFSaEc5M2NhQjli?=
 =?utf-8?B?TUk1aW9vU3dFREEvSGxBSDl5QmhIQ2d0dXJ5SDVZVjAxU0lZUXlXc2hTOXNQ?=
 =?utf-8?B?aFoxS0Z4VnY2MGE1Z0Nod0VTWE9DSWdnTjBhR3NGeHZOcWxKV3NFQURDaDMz?=
 =?utf-8?B?N3gwbFp0OFlxcDV0Vi9maFV6VVZRUStyUkFtN1UzNjdTQlMwbDk1WTdoWGxZ?=
 =?utf-8?B?MGV5TWZ5TEFwdHB3dE96MXlEdDhuSE1BbXdKUjZ0eUpESnNMb1VyUlEwSEpy?=
 =?utf-8?B?ZythWnU4TnlIL3RYZVRnVFl5Z0UvYTNQYmk3TmEzQ0NTekdrK2twK2o1YVBO?=
 =?utf-8?Q?St+xxGkaXTaWvwTSl4oDfv+1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94d253-d8e8-4e6f-9b10-08de1ddadf32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 08:51:42.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1lv/igi+v6CPjqFfpjHc21sk6aTzJoRRbo7l347MMIcZfXQ9AlIhuXQDJLNI8VBWQmjDsZQxvE+WgRAEmzRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527



On 11/7/2025 2:35 AM, David Hildenbrand (Red Hat) wrote:
> On 06.11.25 18:17, Lorenzo Stoakes wrote:
>> On Thu, Nov 06, 2025 at 11:55:05AM -0500, Liam R. Howlett wrote:
>>> * Ryan Roberts <ryan.roberts@arm.com> [251106 11:33]:
>>>> On 06/11/2025 12:16, Garg, Shivank wrote:
>>>>> Hi All,


Hi all,

Thank you for the quick responses and suggestions!
Information asked in this thread:
1. Architecture: X86_64

2. I want to emphasize that the error occurs specifically on a fresh mount after copying the binary.
   Binary can either be freshly compiled or previously compiled. The key factor is the fresh
   mount and copy operation.

3. For workaround:
   I'm calling fsync(fd) from inside the executable before madvise().
   Alternatively, I just tried that running sync from the shell after copying the binary
   also works, as it clears the Private_Dirty pages shown in smaps.

4. readelf --wide --segments large_binary_thp_s_withoutfsync
Elf file type is DYN (Position-Independent Executable file)
Entry point 0x4012e0
There are 13 program headers, starting at offset 64

Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  PHDR           0x000040 0x0000000000000040 0x0000000000000040 0x0002d8 0x0002d8 R   0x8
  INTERP         0x000318 0x0000000000000318 0x0000000000000318 0x00001c 0x00001c R   0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x24aa38 0x24aa38 R   0x1000
  LOAD           0x400000 0x0000000000400000 0x0000000000400000 0x1000000 0x1000000 R E 0x200000
  LOAD           0x1400000 0x0000000001400000 0x0000000001400000 0x53c750 0x53c750 R   0x1000
  LOAD           0x193cd10 0x000000000193dd10 0x000000000193dd10 0x0c3810 0x0c3820 RW  0x1000
  DYNAMIC        0x193cd28 0x000000000193dd28 0x000000000193dd28 0x0001f0 0x0001f0 RW  0x8
  NOTE           0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8
  NOTE           0x000368 0x0000000000000368 0x0000000000000368 0x000044 0x000044 R   0x4
  GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8
  GNU_EH_FRAME   0x156bc5c 0x000000000156bc5c 0x000000000156bc5c 0x0c356c 0x0c356c R   0x4
  GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x000000 RW  0x10
  GNU_RELRO      0x193cd10 0x000000000193dd10 0x000000000193dd10 0x0002f0 0x0002f0 R   0x1

 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .interp .note.gnu.property .note.gnu.build-id .note.ABI-tag .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt
   03     .align_load_begin .init .plt .plt.got .plt.sec .text .fini .align_load_end
   04     .rodata .eh_frame_hdr .eh_frame
   05     .init_array .fini_array .dynamic .got .data .bss
   06     .dynamic
   07     .note.gnu.property
   08     .note.gnu.build-id .note.ABI-tag
   09     .note.gnu.property
   10     .eh_frame_hdr
   11
   12     .init_array .fini_array .dynamic .got

4. Logs from --- Before Collapse --- 

smaps:
55d436a00000-55d437a00000 r-xp 00400000 07:00 135                        /mnt/xfs-mnt/large_binary_thp_s_withoutfsync
Size:              16384 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 256 kB
Pss:                 256 kB
Pss_Dirty:           256 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:       256 kB
Referenced:          256 kB
Anonymous:             0 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           0
ProtectionKey:         0
VmFlags: rd ex mr mw me sd

numa_maps:
55d436a00000 default file=/mnt/xfs-mnt/large_binary_thp_s_withoutfsync dirty=64 active=0 N1=64 kernelpagesize_kB=4

Additional logs inside the kernel:
[  129.257258] collapse_file: ENTER addr=55d436a00000 start=1024 end=1536 is_shmem=0
[  129.257266] collapse_file: allocated new_folio successfully
[  129.257267] collapse_file: XArray slots created, starting page scan
[  129.257268] collapse_file: scanning index=1024 folio=00000000be1a13db
[  129.257270] collapse_file: folio_test_dirty index=1024
[  129.257271]   folio=00000000be1a13db, flags=0x57ffffc8000078
[  129.257272]   mapping=000000004df7b047, inode=000000003395e5a1
[  129.257273]   folio_test_large=1
[  129.257273]   inode mode=0100755, i_writecount=-1 inode_is_open_for_write(inode)=0

[  129.257279]   VMA #2: 000055d436a00000-000055d437a00000 flags=0x8000075 PID=5268 comm=large_binary_th <-- CONTAINS DIRTY FOLIO
                Perms: r-xp  MAYWRITE MAYEXEC
[  129.257281]     File offset range: 0x400000 - 0x1400000
[  129.257282]     Page index range: 1024 - 5120

[  129.257289]   Total VMAs: 5, Writable VMAs: 0
[  129.257290]   Page details:
[  129.257290]     PG_dirty=1
[  129.257290]     PG_writeback=0
[  129.257291]     PG_uptodate=1
[  129.257291]     PG_locked=0
[  129.257292]     refcount=64
[  129.257292]     mapcount=32
[  129.260652] collapse_file: folio_test_dirty FAILED index=1024
[  129.260655] collapse_file: FAILED result=0, going to rollback
[  129.260656] collapse_file: ROLLBACK result=0
[  129.260661] collapse_file: EXIT result=0 
[  129.260661] collapse_file 0
[  129.260662] default 0
[  129.260663] madvise_collapse_errno: -22 last_fail: 0
[  129.260665] thps 0 ((hend - hstart) >> HPAGE_PMD_SHIFT) 8

Note: result=0 is SCAN_FAIL

Now, after the failure on first attempt, when I run the executable again:

-- success run --
Region is 0x56185f800000 to 0x561860800000 - length 16777216
56185f800000-561860800000 r-xp 00400000 07:00 135                        /mnt/xfs-mnt/large_binary_thp_s_withoutfsync
Size:              16384 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                 256 kB
Pss:                 256 kB
Pss_Dirty:             0 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:       256 kB
Private_Dirty:         0 kB
Referenced:          256 kB
Anonymous:             0 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           0
ProtectionKey:         0
VmFlags: rd ex mr mw me sd

56185f800000 default file=/mnt/xfs-mnt/large_binary_thp_s_withoutfsync mapped=64 active=0 N1=64 kernelpagesize_kB=4

  Start: 0x56185f800000
  End:   0x561860800000
  Size:  16777216 bytes (16.00 MB)
  Hugepages: 8 x 2MB

Calling madvise(MADV_COLLAPSE)...
Successfully collapsed text section into hugepages!


5. Yes, I'm calling madvise(MADV_COLLAPSE) on the text portion of the executable, using the address
   range obtained from /proc/self/maps. IIUC, this should benefit applications by reducing ITLB pressure.

I agree with the suggestions to either Return EAGAIN instead of EINVAL or At minimum, document the
EINVAL return for dirty pages. I'm happy to work on a patch.

Please let me know if any other information is needed for debugging.

Thanks,
Shivank

