Return-Path: <linux-kernel+bounces-809214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4A2B50A14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E2956499B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489381E0DD8;
	Wed, 10 Sep 2025 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aqZeeGr0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1EC13AD1C;
	Wed, 10 Sep 2025 01:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466559; cv=fail; b=ck7kTg0lRcmjRiZJgguUShIvhcnLMjAL71kU3B5IERpOn4jh9nyEOiDsQtL9nkF6cyQTY/PDsBrI5c5qWNWnlCtzvYzLOMzAnd3Fy9BFNMezdcJM4TcmVwBo4phzrhWuVcWRsI5IRzriYxoKMyYTyl4WQhdfopoRqa5wyKq7/xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466559; c=relaxed/simple;
	bh=xwo2pK4wyy2mw0rYVLjlqiHzRslbKuPnR5hSs19Pl88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw+DGEo4UqE3r08gKNd2VSKmSVe9eEkNGu20qpRlFy1cQJRRd9kZLlAqFKmP9ViQFHfveHACBtcWnzL7pPY0tvn1u+S8HlrE9ZEKbvePXo3OaeI02jy/1NHRBtrYI05zVhPppSsQEf+jIjImLI2cS7mEv6hmNm8yjPl8JgLbxIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aqZeeGr0; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XymUpvF5vBpZ/Rhp/270ejlDBZ6BPKbx2fQNPHgzmIgAEZkdIzGSMeJIAQZWdgBb0LgPVqKXd3/xKJZGK7w2J3CeF0O2IsxeXTVTKoanYFRMGZMdqS3r4KAP1YuNm20ybVJgLpeLzSfMs9eMfS3+pJmQ8n24yfUg9TZIaqQpqfKdO7YJKMeL5BGVE9nNunafgL6+tW3Qe9dYT1iDqo+xD8D3Wa8ABVWZkrtLG5R/SY+nSbFRerQXWWn/nqA7xeP+TO0oTxsahMlO9y91faXNSHuq+gbrLrRrp0C916pbVn4uO186YPYpgfwPf8E25jZdfTnN4bdSweqdndGlUJd8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcPFffDgG2uonILcDq7HCpHfkFnTz85zw/Z+T/ZqDXc=;
 b=Cw9ipqlEuxGuWDREOt4YmG8l9ocpp7Z+NMppYaBUGTZ+aVbUhHS+iX/sjE/oOcimcKoPJ30YXjZPzw2epsN1vMo7/SXta8jEKxI/CiBlxdTSMT7gfraMrnBPGywtNqvNZYVFfIQE8ERr6HiC7Dj4f3GOAL/4NQdZSZiE4DlbGih/fEH7/PX1KBKNR6IqUI6rqaufARJXRIBtQE1hX0TUjrX2pgP1BR5aW9VE/3khTq4AnOp1y3q8f4fvVyTd4eN4ayAxsh2mH3fQRRB3Dh/ZRFj2LY7O9jtL6GlthN+3WT4f2BtlqZD8XugS1dwR6qPCNV8msZTsIGjcxFZGEMC+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcPFffDgG2uonILcDq7HCpHfkFnTz85zw/Z+T/ZqDXc=;
 b=aqZeeGr0k2Ec5nfl28QrJxgWhZ3HeE9+QYZb0/I73+eYsqjhYNZWthq7EBRC8yn2A9SMm+DDFop8PCCAAZZxhbH/VUaddH5RKAxKZwhv7gpPhGg/vnQjSEYOxcPzmRA2GnRGyqPprBng6hv89+zaq2fu5we8hy6mq7pvKMM2b8420811rrw/LYiV141b0wY5rkDUllXRbA3dMtF5clGmjWBxcnL4EYnDgDLIsWbIKVe1sBDRez5BcB7SiUv7y5L99ebpVu3MN6elTKbRPwRK98MnUz2Ww9W0NumCNXNgMP4AstZfyPKrgK0M4iKIQNarIwji1yWOFstj4+4mif6yhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 01:09:14 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 01:09:14 +0000
Message-ID: <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
Date: Tue, 9 Sep 2025 18:09:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Vitaly Wool <vitaly.wool@konsulko.se>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
 <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9b004f-5cfe-4ac4-b952-08ddf006a846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZ4MzlmbzV0SE5TSHRpN2huS3dFS0VDRHJ2VzQ1TzNIRjdYNzdUQW1iWHZn?=
 =?utf-8?B?UmdYRFJCeXpnWTNIcGdRNmhQSDczc1R5cXdpNzVJVW1yVmNOT1JRaHhtSkll?=
 =?utf-8?B?WHFOekdvQkxVVzJvQlloZXJFUmlJSEJ1TmNHTEhOcWRXdU0vRWdLOGNnZm8w?=
 =?utf-8?B?MzZJS0N0Z3o3eXZNT0w4R0p5bERCaVVyeEZTRU14UW9sUUxOaDYrVFk0ZnRx?=
 =?utf-8?B?SWsrWnFnV3lZcGdTdzR6MmJLbVdXR2lrZE55NFp6N1M2MmRON2R1TTZSdjBY?=
 =?utf-8?B?MWNuSndKSmd4S0hMWEtzNTltc1J1TXM5YjUxclQyZUJ5ZEEwVDFaaC81NmRV?=
 =?utf-8?B?NldxSlJNZ0Z5cm9sSXZHYzlZVVZ3VG9mOW41VVYyUm9nUWIvTWttelRVY3lB?=
 =?utf-8?B?K1BGMXBEMHNia0dhemJlcGpWdWNOZHRydFl6VW1HdEgzcHdGNEkxRzhUaElY?=
 =?utf-8?B?Z0U3WTl6RUtEOFV2bERWZXhyNStoditkV01LcncvQlRKby9yTVhpcGIwSUJt?=
 =?utf-8?B?NDhBWTNiZFM4eFlPZnRlZVJUdmFJUHkxYlBkU0xmU281bGRUMHZIOE9UbzBI?=
 =?utf-8?B?NndYR3BjbkNYd2J2dnFEbC9SL1FPWEZ5VVJBZ2NRZ1lWblNUQ3FjbjVDVUxS?=
 =?utf-8?B?RWwwbWo3NUNyVVpvQmV3NVZUWktvNko2aVY2eUlzQTRpQ2dDM283azJ3Um1S?=
 =?utf-8?B?K1ZobnNYSzZPeWpDUFdVVXZhWEFkWWorRXFKYk5hejVXUytVUDNqYjRMaUNh?=
 =?utf-8?B?dmRkSktMY2tlY3ZFRTRDREVsSHFlMk1OMTkvUGxua28xVUVIL1Q2b2tLYkZ3?=
 =?utf-8?B?VXppZ2dIUC9SK2JuRmVNMzFXaElNM2I5cHNNbTV6REdOamtpMmpCeUt2YXV4?=
 =?utf-8?B?dzJqeHZQQlhWQ3FJZmhBd3RRbmJCenZ3MytNOEhORmZuYXQ5Q0lHdUZaYXdJ?=
 =?utf-8?B?eDA4SEQvdjdoSGVaZ0I2WEx6SFA3TXVxOWl5bWttV1pubFJyZE5aMnRTVjNJ?=
 =?utf-8?B?MXNCeXhVdm83S3pnWVZNSHU5aFNQUUkvc2JvLzRkTitTOHRGMUF2N0VpRUVX?=
 =?utf-8?B?ZkQ2b2M0YUlEdU9RRVZ3b2NXcnZYcDV1Y2pEVTREcElYTmJiYlRrK3QwVGsy?=
 =?utf-8?B?Z1VjaW5ER2F2QmhpYUYxOUNpMzk1YlhEcWNzandnUkJCbXBpRDZVSnQrbDF3?=
 =?utf-8?B?bDNabWNjemJnc0l0MklNelBZNGQzTU1UUUNwVyt0ZDB6UkszSUJobFlSVGdq?=
 =?utf-8?B?N1BPanpKSld2Wm5Jc0ZaYWNXalRxZ3NsQWNNQnI1dURUbER3ckNybURUZEpS?=
 =?utf-8?B?cGZ0dXVveTF5WEYrYTUrZUlCeFg2SGY4TzU0SXdCdldpR0RONmx4MUZFKzB5?=
 =?utf-8?B?UUwzTVhnWWg2dG90bURLWXRLVWZGdWxXRG9UQzdSMzdCSFJsOCsvZXVqdEww?=
 =?utf-8?B?VVZ4SzJsUjRiUWhkNDBlV3hsdUVPMmhjTUJzSmFucXdtb1VDcWllSWI1K1hi?=
 =?utf-8?B?YjF2dFFLMnVUSGJrTWVRN0p2L1llVWRlRUVMVWhEVmJTc2JIaWNoZ05LRkgz?=
 =?utf-8?B?UnhzSXZERFBKTDAyWlhSVmw4SWF4SXRLVmh3Mlo5eTBWOWRraHlKcXROcVoz?=
 =?utf-8?B?TXNweXNvVWhzeHdOUGNlVHFTYUl6UUxCamVHa3JKT1ZnNHQ5WXF6OUNtd2pk?=
 =?utf-8?B?YTJNNGp4T2I3UGhhOEZmQWpCVFUxT2l6a1VZcjZid0F4VWNoam8yK245bGI5?=
 =?utf-8?B?L1lqR2J3QUVnOFg5a0VxS2x6TlV2VkV6RGFySVphMi80MDZQeGdzaVIyMmt0?=
 =?utf-8?B?OUJaV0FHT0FxdWRuc1NIY2p1bXJ2TGwySTFUZ1lZK2F4U1IvL2tFQXpuMEVp?=
 =?utf-8?B?L0FMaXROYkg0ekg5Wmxtd1QwUTNSNkljblhLeHltZGhGQ1FlTTdCcW1uNHk3?=
 =?utf-8?Q?GkW5F1jaxMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtKZUo5eFlYVTErTFhIdVdHeUVDcVJrZ3NuNGdDRnVFd0owNXc5OW1JZ0Vx?=
 =?utf-8?B?clJLcGlKVGQ1NUovK0xieDZJRjJlOXFKRCtxOFV5QTF1QU9rYTkxNlBVQWtj?=
 =?utf-8?B?dy82NXVjWDhUQ3BQVkx0ZzY4NUEvL1BROFpLOGQ3dm10UFpOcTdpRzM4U0JZ?=
 =?utf-8?B?ckFrMVRvQjhqeUJIRUdJSlMrWUtJNlpiNm9SdmxqVVNJRDVDcHFDbDlrUzlj?=
 =?utf-8?B?NCtTRWtjdEVDV2dRMDBCVVpYUWJBYWZxcWZRZlBzZ1hGVUgzdWlCL0RUUUI4?=
 =?utf-8?B?YktmYU1qUzNOaUc3ejV0YktjRVp3Wm8ydVczb29NMFpBUXB6KzgyQ2pHdkVO?=
 =?utf-8?B?MWRRcmVMbFMzeFZidEVqV0l4Ny9BVmNIN3d1ZUdiQmw1dXVQdmtBQ1pScWg1?=
 =?utf-8?B?TGVESzduaTJ5WnJJODl0SVRYOTdGemFHeXZHTHpERWYxZnMrMGdYYVJJVEM0?=
 =?utf-8?B?SHpWOCtmMjhNbE83UlJjazJVWWZ4QXJqM2ZFS1drSEoyUFZyVVcwQWVFMnZv?=
 =?utf-8?B?VlE3bGZxWjV6MHA0S3ZmYmo1dklyRzBoSS96dVYwREZEQitMZXBPMzBFVFBo?=
 =?utf-8?B?TU1WTXNIVFJNRHZNTkVxd0ZuTVVvRHlkSlk2bURlelg1VkRkN0QxTlVKVFJE?=
 =?utf-8?B?aHJrQVkrcElRRjBvZmFqVVpKY3lMUC9ITk9ON0FwWERDQ21FYktiSHo1RDZC?=
 =?utf-8?B?NFcwZmFuOE5ZZERDRDZFNUlBT1F1RmVVWm8ybWRVYytNZ3IvUzBQTHVYcHVR?=
 =?utf-8?B?RXRsQjdGb01EK1JBWWRMcTdLQVNjOFpVUHJnaWorR25ad2ZvQUp3OVJYdlQv?=
 =?utf-8?B?cU1BVTB0MS9nN01ZK2R5Ym0rRHpWTzRaRm9ybVNmU21sWEkvclJSR2h4TTV1?=
 =?utf-8?B?VkY5b1Y2UUxFRVo3UU5DTzJEZWEzNzlhdER3eXNxdmRXVkczMEl4ZE1ueW5h?=
 =?utf-8?B?YVE4VXcyZmV1TVlPMVdMRGNMZHgvRmY0b1dyQkVSaHUxK09CT0pFSnhZS0RB?=
 =?utf-8?B?UUk2bm5xUkxtcktVdWwrNlBzdXI0T1FuTTFUWHRvSWhXWGVMcHdkOHVKRTI1?=
 =?utf-8?B?UUw5OXVTNnRwOEdUck1CcDJzR1d1WUZqMnhwYmhSUkVaQzVTSGtHMmdBSHgy?=
 =?utf-8?B?QXNSMWttYk5XOUtwNlR3ajhxdG9aWmdmOFVjWXpuSkhNaEtEejdFZXVrWjhC?=
 =?utf-8?B?d3NDVUQrd1NxT2pRcThzSkRrNVhnak5ZVllCSWw0eTR2Z1VhZXJnS0NCWWd0?=
 =?utf-8?B?MXFBOHAwSGFZWThmTmhJalZDMjhvVUdkamNHNFBtcktuZUN3VktZN3lSWWtm?=
 =?utf-8?B?bWlqbWxmNUhNU2lOdVQzenFqVk1rMWFsN0V2WXN3YkMzVDJNMk03RDdSNUlr?=
 =?utf-8?B?cmN5VlZzMlJRcmtzME9La3JIenpaRmdwbVoycEJPdWg4aU9uc1h2Q0dST0l1?=
 =?utf-8?B?Wm9sQ1RLb2p0ZC9KOEw0WXdXaXJRcGppL2NRRFEweGFXYUcrTkVUeGlkZGli?=
 =?utf-8?B?UFMwRUZRWkprMmlFUWJYZlF6SnFYbjFjTHEyYkdnU042VEkzZW1BQ3hheWlP?=
 =?utf-8?B?SW1qZGVuRVZSb2tKeFkyOWdXZFc4TjFOWU55dXRrV0Q2QlVqWFR2OGdHOHQx?=
 =?utf-8?B?UmptMkhuKzBWYXlTcitUK2RES3V6am4zSUhscXRQanExa1BST0p2TllQSGQx?=
 =?utf-8?B?TlVqQTlxM0tIcG1QTGN6MnVuOXVjUCt2cmZ2ME1CM2pITlRqeVRZaEFuWlJw?=
 =?utf-8?B?OVJiSi96WmVYZ1A4SWJodDFGOUtuNStBOTZqb0t4Q1AvdmxHaDg5S21oUXpH?=
 =?utf-8?B?MUdtd3FpQXVrWlltQ1R3aVdVVEYxM3lKTVcvTHdRanBRWUt0bnRhbkptTHpD?=
 =?utf-8?B?K0tZL3I0NUZJaTRuRWN5dThrZWNIMm1DNUg3SkVBN3NrWEVPamlWNUloREc5?=
 =?utf-8?B?UEhHWkM5bFVCQ2RtOElJMEt1SGRGekYrclZGNGxuZ1RsQW1EOTFwbTJsSkRK?=
 =?utf-8?B?WHdWRmpCS3ZrTENoWTJxOFIvRUozUzgvbFZWVEtqRjhncHIyOTQ2ektZT2Nj?=
 =?utf-8?B?eGVqRGEweTc0aWNEUVl1R0pWTDlMMnNZa1Q5aDlxalJPd0theVR6WENrWE9D?=
 =?utf-8?Q?IPQRfDFpgDADpKaYoAVQvrdlQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9b004f-5cfe-4ac4-b952-08ddf006a846
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 01:09:14.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv+0W9A7mD/6fDiEteM6GMXRumbS+9/5qKsorcgrLHXMMw80HkVPjSlcJV7qaHOQZjJk76P9qzXH/fOSpAKnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

On 9/8/25 2:21 AM, Miguel Ojeda wrote:
> On Mon, Sep 8, 2025 at 11:06 AM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> Why not use &raw? Consistency with the rest of the file?
> 
> I guess -- it is a good thing, but since we are actively trying to
> move to the operator, it would minimize work to avoid adding new ones:
> 
>     https://github.com/Rust-for-Linux/linux/issues/1148
> 

Interesting. I know the topic of rustc minimum version (1.78 right now)
has been discussed a lot, but I'm somehow still confused about how this
works, on nova for example.

The &raw feature requires rustc 1.82.0. So I thought we couldn't use
it. But clearly we can...right?

So confused. Please help. :)


thanks,
-- 
John Hubbard


