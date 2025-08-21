Return-Path: <linux-kernel+bounces-779049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B20B2EE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAA65C3073
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1062E266E;
	Thu, 21 Aug 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0HwYr/u"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A84296BA6;
	Thu, 21 Aug 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758391; cv=fail; b=Yu3x1fu751pGpQWVaPx8HbJmdQp1J9eALBXrDGERDv+GoKTzZUPRxkRUR2bckjDbTbSmwYzFdoDeGSrq4ZiGMF5nubeRyZ9wORDqXFI2jfz+5lMRZ7mt8u0aVygTRex/msHNdQn4bQoGry8UWS3gJoUbHAxnOeOyEoRjFmBc378=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758391; c=relaxed/simple;
	bh=PgGGetspkfCdxRIrB9IGm3eOsPCXZznXEN150rxDoEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbie/u2LdpY50mADCjB3wZh5myF6W/SWwg3688n+B6n6HnLTczOusAsUqCSTF+zjVLVE6MGtFPIqNpbukdjaeWYK9Gz5l5EguKl6ouywBdjel6SfekPTJJYB5KwuQYRqCtwyxHH4K3+qtv7Lv1jkYEgjjraNrUqZGSP87KeLflE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0HwYr/u; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBEnC1oSkq69fIFhHkvjyTjdYVeE/jA69Xhsz/e9qeYyESEGf42BmHoZq5/aSK4T9xLI0Bg9NvpKSzJ74+c0W47Ozc1LDtwxXPUAaadiX4p1UFmFBECVK8u4eGTzei0cnt3d0oaLxyaK7d22EgtB+o+ZnVudwrB/N1MKksP8yl8wXOCDFeonrGH3L31t6qG+iWEWL5aoaVmwwyivbFHOoX5H3pFNoLvGJnwbmknVm+IG9fojDGft8o1x3+UGHcywBLbBPJ3TIjvjhtkm3om9pUqxVurJL5nxVn0T75JqCaI0DngUoj9Q1bKRzq3xpzBpVvUfiDxaNRzpLoPyVWWCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESXGxfaYJ0O+/9O8j4G/UqQeVItZLTs4n4g6iVDYeNM=;
 b=XjWyRuMuusvbAKefd3Mt8djKMQHn2k456KNdbNXnYBDCcX8m6fjFocxL9XYRJSLbXxqW19X+VwtG6wNnzM4IOGS6UutMyjSIswvr6iUUNL3TPNcDInt+/YE+jLHXEKou5Wrn0XultN921FAOUPokey68GBCSoZ2MHjoMMTA1c+xbsLir7SY/ZtsvKOZHqX6scjk5FpZbye5jqfD82nskal15c+k666FF8TDFu0Cna83m9/HsG0Po0tH3qRI7VQusbKJb5F4sdUqkxRgEd9JbAVTLvt19MrNrkrnAh2Lli08CaECpk52XPCwwyRespNQugEXu8tXhSMdjloeFzFTYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESXGxfaYJ0O+/9O8j4G/UqQeVItZLTs4n4g6iVDYeNM=;
 b=S0HwYr/uQgQw/Zle7TwiVkJUU7LXvKtNu8HSL2AoRvxtU+EomPT70iSLW4+4BzlG9pch7jKRvrBqEVaWknaCC9jH1K8n4Yu+IrQYPtJw7VYd5sTH/1diEXa0Y90g/GyB5y9ioV4ZK6+0SSsgvswYlfB79A1ULM2/FSrIfQEAEV250rekeBEetKKWXI/RExO/m5c8IpoVAXdAAM9ajDnsV44QUvOMpUqFEtWR9/QG3TYhtT2qIxRwOnzGKaug7gniSFOouIm/9s4tr30B2MlGM03f6ElpZpI0IEzp9R2d1fwYCbfxHSBTaMoVIF8LoB6FJ8IgVadlctzgwYtAHsQJVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by GV1PR04MB10079.eurprd04.prod.outlook.com (2603:10a6:150:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:39:46 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::a361:2618:7785:3bc9]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::a361:2618:7785:3bc9%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:39:46 +0000
Message-ID: <38c470ee-0961-4197-a64f-e25bbbfc08ba@nxp.com>
Date: Thu, 21 Aug 2025 09:39:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Add missing IORESOURCE_MEM flag on
 resources
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Saravana Kannan <saravanak@google.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820192805.565568-1-robh@kernel.org>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20250820192805.565568-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::31) To AM9PR04MB8907.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8907:EE_|GV1PR04MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c195bf-092c-418e-f850-08dde07d84d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNPWmx1OGNjcUxOcmFDYUNoOTNKb1NVeWFzRUFDL1ZtcTlUVUFrRnhQdjRx?=
 =?utf-8?B?MFRFWjVINU9xOHA3WE4wR2xkcW5RV05JSHIxSVFjdFJTSFRyY3NqaWdzSFYr?=
 =?utf-8?B?VDZNRzNYdWFLc3JySUN6aXF6VnBEdEdiZEYvMmowWDNITmNZdUtSUDJLU3Vy?=
 =?utf-8?B?aDNPUy9JN3NoNExRVXRPMUovclJhQlltak1GQk5nVWhGbmp2QnE5QnBqeWFh?=
 =?utf-8?B?U01ONzEzMG5XR0VHRmhXS0ZUbklWemkyMGx5RTNBT0dwZkg0WGgrSW9Td0tC?=
 =?utf-8?B?WjFwOTF3QW9DSUMya1Nhb0VrNlBtM2VwS2lmUEl6b2p4QXMyb3hHVWlMR2Fy?=
 =?utf-8?B?dWVPdG4yQWIrS2tEVnpJbE53U2ZMOXFaUExFUUx1V0pibXhrdGFCL3crRlk2?=
 =?utf-8?B?RWRpWG8vQXZlZHlUNktHU2dCNFdKckhiVFVvOFQ4M0NxeXBodjFFZ2Fudk5Z?=
 =?utf-8?B?Wjl0TDRaQk14MmtQU01DMTI1UzR4NENydlFCeHJlOS9GZ1JlckNJZmhWYmVr?=
 =?utf-8?B?RWRkRWgxSWVWcjBQdFEvbksya3pBS05aeCt2N3JtYjhkZ0x0VllxUDF1dmFr?=
 =?utf-8?B?MlZ5RUpJWVR0SGhQcFkyeHJqV1NIc01KV1ZkMGhuZ3ZVeXo5SXhvL3ZRajdr?=
 =?utf-8?B?NmZCNnJlbFpYbG9rZ1ZxeDM0K3pFUGxnNTlFeSsrNFlqZW9FTS9uamg2Wk1I?=
 =?utf-8?B?bnN2SnY0bDFCS2M4VnA0NXYvcm8ySCtWL1Y0UVRyTzBDeUxEVVRZNEhTQ28r?=
 =?utf-8?B?U3NGVlJvNG16WVRRVDZTbVE4RGVxS2N6OWI3N08wNElrME50MEJSY3VrWGJI?=
 =?utf-8?B?Sm5NT3pSSVhzM2hCWllHRCs5MkNuRitrcWdoQWF1NmlMMytuaHpvVGM1UzVs?=
 =?utf-8?B?S0JNWGU2bzEyVmRNQmFCSnRROHZFcG13d09YS0hyWDVqYzVNWHFpNENYWWUw?=
 =?utf-8?B?MG11UDZPbVJxOUJ2dWQrb3lhYzlKR1pEY1FPd1grdWlGdjhXMHpaVi9kT25k?=
 =?utf-8?B?ZEJvUW5vaUdBS0RmeGlyQmdPeVdydUhSc0dLb09saXRpaTQ2NksySm5LSjAz?=
 =?utf-8?B?Q3RUVDVtZ1g4aHk0NWVybUhEdmtFUkErakludUQ5bU8xU1FUaTRRbHVZT1hT?=
 =?utf-8?B?VGpEYWx4VlpzVmVhQUlPKzlybzNoa250Y2dRRmx1c0YzTGNUR095UEVHNVVT?=
 =?utf-8?B?bzllS1ZrRHFGcTBrUXpBeldMbmR6RW9ybW5ZTER6eGQyT2VaOTR2R2ZRK3l0?=
 =?utf-8?B?ZERuZVV5aDFnQlptVzg5bFdzMlJHRFFZZkFXaGZYeWN2N28yTFVlbEJRVDlI?=
 =?utf-8?B?Ykx1QnhIWGkwRXFEWHBFaHd4Q1JnNkNBOXNqcVA5VVpxaGxGWGt2UUl6djFF?=
 =?utf-8?B?aHhCTjhLZmFDVjFpaDA1UDNyYjdZMGdFVWp0UWIxOENhSVBXRi9xeWYrbjk5?=
 =?utf-8?B?V0VGQUxjekcrWXdzTktLdHJMNXlmTXdzeXdBdVFJOTZ3OGpYV29JdFlUTEoz?=
 =?utf-8?B?QWRzV0lXRTNuaktUOThqangvc0t2K0djMVMrVkwyLzhscEJwQzk5b05PMGQ1?=
 =?utf-8?B?Rnltd3ZtUTJ5UjNMTlUxSCs2cCtCejk2aytUNU5TSnNQRzNpV0JWQXZqUXVk?=
 =?utf-8?B?eWJVZVNWU2dWZ09hWDdUL2YvWkI3ODZQVjlnNDEzSkpRblUvdS8zY0RTSUNF?=
 =?utf-8?B?RXd6WnBCV1NCbnBLc1FXV0h4dDRHVXFON1Y3d2g0NnhGM1FNcXlDUTlRci9a?=
 =?utf-8?B?bHY3cEtlUlJnSWtaMHNXMzFPSjZXUWdJUnZmeG0xeWdJMVRXMmhGMEp2dEQ0?=
 =?utf-8?B?NWV6L3p3UmRUaTByQXM3UVFQNDFpd1ZwQW10U05MVzJoaVhVcCsxaERwemd6?=
 =?utf-8?B?NGlqV2N3dFlPZktEYURzOWZHcUVRT3NvMXVTWStvYWlQb1lhcnB4NDd4QW8v?=
 =?utf-8?Q?KY+oN3ROMeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3Y5c1V6Wko3eVROM3RyN2EyQ1BYYjdQSWVXaEQ0bjlJdm9tWjlybHBMRUZr?=
 =?utf-8?B?R1ErSXNqN3NGb2pkWmNjWGwrTjdub3MyTWZGaXoyeXRlcllhSWxBU2ZOcnJN?=
 =?utf-8?B?MHNJanV4OWZJR2pNdlR0L0lnZlljVERXNjlOY2xjUURTZzYzNkw2Mkc5VUxQ?=
 =?utf-8?B?M2t6N0gvaDNwMXc2a0xkMVJncFdpaUY2NE8vQ0VVVlhDU21BanR6OUtLTFI1?=
 =?utf-8?B?SjFEV0ZienZsUnZPNkk3dXZ0aHFhVE1reUN0MUFnM1dvVHR1S2JieHFlUXdI?=
 =?utf-8?B?OVEzdUFoTERiRWdoRmVZRGhKS216T2pIWWFvNzlCV21ISGdTUVlPcWkwV3NO?=
 =?utf-8?B?SVRyakVNVmxKMWF3WTNaOUMwS0VmT0RTUlFmczVWWFJnZE9YT0RTbmoxak9E?=
 =?utf-8?B?dlFGcktZZXVPeVBUOXRYaEdIUmpnUUdqYS9DU3JRLzRtZHo3REF2NkV6UTQx?=
 =?utf-8?B?eUg5dHZralYwY20yUXIrVm8zMkVSRWY4ZVQzS2hxV24wVTB6WU1xc1g5NTVm?=
 =?utf-8?B?OUc4SXpLZE9rc3ZqaWxhdmtRZUpGRjJGQ05UOGl5UXJLWHdHVUxVWW45d3VR?=
 =?utf-8?B?emQvQmtVNUFMdlFVYXg1OVVydmFnd3IvSVRTTXZvcFlValA5bE1OWWNtMXlj?=
 =?utf-8?B?VTUyeEZYQ0VVRjFIZ0RUVFcyRFptNTBVd2RKMk5vck50ZzJSVTYxc1E2cFQz?=
 =?utf-8?B?NDU2ZmY3aHRrUzl3QktGQTYzZm84UTE2UXB3TGx1ZUtlOXdjeDkzT2Y4bitN?=
 =?utf-8?B?L3VMR0FGKy8ydFByMHF6ZHBkQ2U4emwyWHg5ck9yV1AvVE1ZbU1mVUg3QlR2?=
 =?utf-8?B?ams3MzFpUVl1bmtWWUd4a3VuWitmT1E5cG4veGlJU3QzUEd3dVNEajlLOEE5?=
 =?utf-8?B?UEEzSzlaV3lUbnEwUnpJNU9pN3RtVE1HVGZsQm5DbHUrci91SWM0WHR3YlNq?=
 =?utf-8?B?UEFraUJpcWY4T3NVMitIYkVkK0hpaFVCMmQySHF0aDkvd1BZRGViTERPUHpR?=
 =?utf-8?B?OEIxNEdQSkpEenRZcmg3SHJjWHVvMUdqSjB4eUphUTB0TGkwS3lMRkxVbnpP?=
 =?utf-8?B?c1ROa0VFOFlEdXRMVlFhZXZkVEFSbU9aOGxYYXkra2ZUbmYzVy81dFFSZ1NT?=
 =?utf-8?B?VkkxWkJSUjUwWHRmTUd3bkxyRy9VcjV6eit1S2NmMWlGcWdFWFdjMmFmTEdO?=
 =?utf-8?B?WmhtOVZlOWcyQVZTY0swZmthZ2pVeVJIRndtb3BvNUhaSlN4bjZNbXVXNUlz?=
 =?utf-8?B?RklTTHhiZjZDOGdaZDQ3ZEZEYjIyeS83Q0RrMHh6Tk42Z3dJaUxGaXRSSCtH?=
 =?utf-8?B?ZHhMUnFFRS9oNmI4RVRzZ0k5eWpQL2tGRFZVSURvbkthUmlqa1N3WHRYNGwv?=
 =?utf-8?B?VGZsa3F6UnZPemY3ejhhNjVJdURzMTFDUThBSE1OZFRBcXVEWEhCSDhYaVdZ?=
 =?utf-8?B?MGdQaVRjc2lEUFhBZFY1dENwcmU3QSs3emkvQTZBTjZ3S21oQzI1aVRIS2pB?=
 =?utf-8?B?Y0NVSW1lV0p2enJydWttZXBZQXNSdkZBeGMwY2NpMEpORGtqekNFOVVobXV1?=
 =?utf-8?B?VUVHL2R1a21NZlpwVTlrM0U0cWd4aFZDQUFXMVNMajk4am9wMlUyTXgxb01h?=
 =?utf-8?B?bDRaRk1sZ2s4cnU4K2JCWjNWSVlCOGY0dzh2SFFOV2VWZ250VmVlamladys5?=
 =?utf-8?B?bGxTZmYwVGc4Yi9PdXdvSUZ5ZnRYYjJXckxFRVU2MVI2SVdIUWs4d0M5UXBk?=
 =?utf-8?B?RlRRN3p2YVBWWkRnNjVJNDBxeTJCMUFOTGdvejlYVDNmRGhmT1pXc2hIckxn?=
 =?utf-8?B?NEpERmFscGdhSnFjY2NNRTNRM2xZRWN1b1VrUU5xcVZRdEpBVGtiWndOL3Fw?=
 =?utf-8?B?YXBwa0M3YmpDN005cW8raXVUNU9KaVdjMkNNeDZJR2RhR0VpYUh3d1ZBb0dB?=
 =?utf-8?B?VFBmWEgwWGh4YzBjWVhvZk4zdURsL29mS0JvbjlQOUw4ajJlZ0JOc3hUTnVX?=
 =?utf-8?B?WEJhS05ta1FnbWxYNG9aZ2laNjk3dkFvbkJyenI5S2w3SHJtdVVRTTFZcFZZ?=
 =?utf-8?B?Z2pGbVpyRkhyN0YxVit5ZklxNDczLzRvY3dCVklteWozYjZsSlBSTlIwNW13?=
 =?utf-8?Q?QuRpfZBC7tWcoSK623BRy9nq+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c195bf-092c-418e-f850-08dde07d84d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:39:46.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T9VcaqxPnVaVAlEjHoyACi6XP04KkV6yX49qHKq5eq/MOUN9g8RVd7k5Tz4nRwUcOuMhw/rPSRLR3B8Lp5Uyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10079

On 8/20/2025 10:28 PM, Rob Herring (Arm) wrote:
> Commit f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse
> "memory-region"') failed to set IORESOURCE_MEM flag on the resources.
> The result is functions such as devm_ioremap_resource_wc() will fail.
> Add the missing flag.
> 
> Fixes: f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse "memory-region"')
> Reported-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reported-by: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
>   drivers/of/of_reserved_mem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 77016c0cc296..d3b7c4ae429c 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -771,6 +771,7 @@ int of_reserved_mem_region_to_resource(const struct device_node *np,
>   		return -EINVAL;
>   
>   	resource_set_range(res, rmem->base, rmem->size);
> +	res->flags = IORESOURCE_MEM;
>   	res->name = rmem->name;
>   	return 0;
>   }


