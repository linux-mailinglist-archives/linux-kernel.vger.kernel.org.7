Return-Path: <linux-kernel+bounces-886030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834EC348CE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB53A7BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668E2DAFC9;
	Wed,  5 Nov 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEY7pTRf"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0D2C11D1;
	Wed,  5 Nov 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332419; cv=fail; b=ExA2B6Y4P0WI5NksKyR3UtkcCjttoaCzcguvaPerP6KUrD+7NjrAHG2pAD0Ug2dWBA0V3am3wEbZMztkqfNJCpvDJKULBWiA5XkMRQYku2glPGungWeU+CrT6Qo2HersdnR3TKIo5HHhsh1OJok5272R+6ZAMOuZ7AZlQwm2zAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332419; c=relaxed/simple;
	bh=3QNV878rxxqAhS6tDBilAHOB7RXSuBBwubO8QXBAKtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ42Ztb53+qtI1Uyf2XNsslZaesljTyqb+aYLhiF5BLqkENSAXOHgB6XxCb94IpLGaNhmOTkrXECXN1Z3MiGuWRQShaUsLn1+4Invmo36OvVivuZ8e0+tZpWSq/W12TEHmjg1vhTrmMXgNm2fTQ7M2jfuzvsknEcFPSg/EQme/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEY7pTRf; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/9nrIBrONtUsisMVOoMD3qCz6SLbPEhQ9YzsHgve9evNx6W6n6hrnx1eHnviho24U8FYopPWW/uCsfCgkTeiMb66L2CVSJWdwVjys5f48ubsmv6JALy6+Hz7ZmCAyIgEbNtlIglcPQIDMz+yCD7iiDINKR8ACyC1qUUnszJjgYal4VodJEcomqal4+8KfW3rFmxMM980ohNrC2wddmOUYP7XJaOfZObvg/lRzHISaI6x+9y+gxBYztgeARU5J4Lgl0VKC/jafNdweSIyp6a5Gi6RAbmLhN5siOfrj3KdiIgjOm4e8JKVcgR0+zE7E18Apy145ziub0UIwzycpKQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxnH3AP0KIidSdFBC6zuBhW7IitRwhgPIsTwyxWgecE=;
 b=ylp91gJ8iSD/pXR/Y/rWibEM4IYH0CPwT+acT4I2ibzTxUPS6Ren/aj6iJU+O+OUHclE73vjqx91lyiKeL3opacBAB9rp1uxpxA4xIYH7BC1s2d1huE4LjIzL8vGhEDniQrAf7ggXdsgTJm4/jwSkXJA5j7qi4lwW+1oMsicnwzP90SPFYbG+UaPou2ttoKR6mya+lv6p4zErY9riM6GZ/mB5FBbs3YUAatlfKQtAOu/+CnOqlZWti+10Mxsj9y7zMFd0oePvrdpah0Ja4lDXTqLWfza5PYQziX6O3/w8vDTqy3G9GjEBc9+h2lnBuNha5TVNiwsjGF3zxL+eQy4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxnH3AP0KIidSdFBC6zuBhW7IitRwhgPIsTwyxWgecE=;
 b=DEY7pTRf6bqZVg6waQCjYwwYMaAi4Dlqe1t7c3MpDCxdt7Jr1imqOPKJgVi6nsnxPCsQHMykVUxs23PA/1RNIDr5em9GXQba2G7ngKVuDFsjL2Wxurow4wxyW9PyVsWZoiueJ8htoXbZIbGtu3gLpeYbHjyq/08OfVe3U/hELzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 08:46:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 08:46:54 +0000
Message-ID: <ca139b41-b4c3-4f0a-a2c1-8cfab6032625@amd.com>
Date: Wed, 5 Nov 2025 09:46:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/20] drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20251104083605.13677-1-pierre-eric.pelloux-prayer@amd.com>
 <20251104083605.13677-18-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251104083605.13677-18-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5621d1ee-f70a-471c-e1d7-08de1c47df23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm8vLzFaQ1NXajJjZU5HaFNKYUVEUlVWRlptZFdBZ1BLbEpTMFJObG1FeFpY?=
 =?utf-8?B?UUZFcmtBVmlqaXJvY1hScS9tenM1OU11R0o1MDBqUWhVSUN0NEpqSWhiejkr?=
 =?utf-8?B?cGtyTDRocys2RWlKY2NQdEJqSW96STJ1QzFvdXhpVFNxMkJhbmgwWlVacTdJ?=
 =?utf-8?B?QWtSd0wxS1BRcjUvbmZlazFncGdOU1JFWjlhckJndXArcXJ4VjQyNnZaclJS?=
 =?utf-8?B?YWE4bWdCK1ozRVNqVVpkVk9wRkNLUjB0ZlF6SngyODF6citDYzRBK1VTaGtx?=
 =?utf-8?B?bklMdm5DWFpMVU1QYm9iQlJMVHhaYWt2WHA2UG93a2NleUpWKzFGcGt3RVVN?=
 =?utf-8?B?MmpGTGs0bVFJR2svVFNha0dNVFUyMVVvNUFLNXhDTFVXU2Z5UG5pZGZreVZF?=
 =?utf-8?B?ZThEbDhaYmJZZ05DY0xZTjN4eklqMWdVY2xYYWVXbzh1UWVjOG9KMGFVVVBw?=
 =?utf-8?B?NFlzd3lxK3ZQUTFuNjIvd2hXNlB2VGh6V1VabURkbW9nQnBtR1pxZFd3eWI4?=
 =?utf-8?B?SUZWRlMrUHZ4T2NYandsajE5bFRqODhTc3dOVFVwa0ttM3kxeHhYdlBXdHd0?=
 =?utf-8?B?Q3lnNUMwek9RTnlJYVVOVVJvYmlsbnVMNTNGL1U3Q0tncjVZbENaWU9haHYz?=
 =?utf-8?B?Wjk5Ump3cnA1Q0wySFJoK1M0NElpZTVmTzZsSTlCUEtkaTRMS1NuOGJOaFBu?=
 =?utf-8?B?aFhSd0g0SWxkbXd1R1c1ektDd3loS1JMM3I3Vnd4SHNrVHZsV0tCTFFxQ282?=
 =?utf-8?B?M1pzOVNyb1QvRFJLamZtbnlYaC84U3V2OEE1akJ2Zk1BTlNLSEZrNDhzd3dZ?=
 =?utf-8?B?TUk5NDhQL05HRzJBd25MUU1ySE1rTERJajVSd091MFljcHRZbUtxM01Yd1Bs?=
 =?utf-8?B?TDkzOHJXVkpEa1dXSlFNdG5sa01oQThxYm43WUF3Ykx3K2NldjJZY0dYL3px?=
 =?utf-8?B?SkdQOGNIaWc5M25lM0t6V01jM0FtWjgxTHlPQUJXV3JxUlh3MWVuMVZ4cnRu?=
 =?utf-8?B?Q0dkb2hqYzJGMjkzWG5RRVU5Y3hUbU9pdm8wN3A2V1J6Q1NPL3ZsNVdnZTh2?=
 =?utf-8?B?QWtmZHBqTnM4WGNNUVo2Y2JPR0J2L0Y4OVFhcjNibXZCcWs3bmJEMWRyWTk3?=
 =?utf-8?B?MlFXNlJ3RHNpRVFodUhMU3FPYkFsYlJUeGg4Wmd0T1hDbGsyMGFuRHhRTmYx?=
 =?utf-8?B?RjV6Tnp2QTM0WDJaN0VVWjlWS0tWNFZBbThEOE45V1VnU1EzVFJjYi9SQyt0?=
 =?utf-8?B?YlZUcmZFRDNZWmV3ajg1S2hZcWpoSmM1K05FcEVqZkhiakFuQllXQzdVYjNQ?=
 =?utf-8?B?TFNPTjRWYnNMS2xUUWx4b0ZncFQ5TGJ1ZzQ3QlVWZUhSeDBvNEhHcllYZnVY?=
 =?utf-8?B?Snd3cnNZc0lRNUhJTmRkcDBPR0J5RjN1TDNiQnhqbHF5UWtZUUdKcHEzNjhH?=
 =?utf-8?B?dStMWnlCUlgyV0ltemNyMVM0VURRSzl1S2IyUEI1OTVZa28rdmlzS25aa2dk?=
 =?utf-8?B?b1NDQlJpY2lzN1NNL000Y1llRkVmQXFvc0JoUXA4b25ZQUd4bTZXK1JkKzdY?=
 =?utf-8?B?VG9TN29TbWJJT21PekNyN05VTzBWTGRtYTB2ZFNna1FMYVhvczVHMmxnZmxq?=
 =?utf-8?B?dnhOS2RITW90Y2pFQTd3enhKalVJdTRXZ1MzQXBTdEZjYVFsSFpCVCtmNEwy?=
 =?utf-8?B?RGlGaTlTdml3eW5vcnRreFVCYXRUUkxmTDdPOVdDNTVDaU03RmhOT1EvWnF0?=
 =?utf-8?B?bWF6R0xqNTBsMldHWUZ4SDkzbVN6WEk1Ny9id0dZaWtDVHNQNWNFZVdieDZU?=
 =?utf-8?B?aGR5cHVocUYvRFZhdklTdW50Umd5QjBrWnhNa25HYWZyQzRjM1E2WUNXNUJr?=
 =?utf-8?B?d2dMZkl6NVc2enZqU0QvSitzTEk1U2x3dVp2WEZlYnlsYkRiU2RYbDFUeTQw?=
 =?utf-8?Q?H5jSJBQChaJ0RtnUl7J7NNLI6mQd3r9V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzV4bnM0ZDZiWEV6TWlyWmdhVkoyMWFTdUhLcjV6SUI3d3RIYzh2TDVyK1Jh?=
 =?utf-8?B?bGFReUVEc1JpaHhWRDVKRVN4emhNMGNqZkNQNjdMeFg4dnFKeXhvMHltZ01D?=
 =?utf-8?B?WEFZZmhUT3h1bGlQVWFxZmZjTE1SKzBGK3FPdVFlL0NqcmtyRW9SaFZOVVdS?=
 =?utf-8?B?YXphcmE1NjR0ajNGUk8vaFBCY2lCRnFib2FXejgvb2xDV3ExMEdUTTJKM0ts?=
 =?utf-8?B?eVlEVEdBYWxyRngzcGJRRmluSUEzN2NmNm1aTHhmUm9ydFRNMEErTXJVQk9v?=
 =?utf-8?B?TEhRR1dYOGM5M0w0NitOQ0xNTWxWdm9UaWxEeGpVaXdnQ25uU1FVWEZxRmZu?=
 =?utf-8?B?TEhTOUJuTU90aUxkY0NreGFhVHM1M21QeDFUYS9nZWpiQXlocWdBZ3hMaDI1?=
 =?utf-8?B?UFV2MldJK0NkelFqVE9SWHRIUUdiZlB2eTBJK2xQdzljSWNETDhZSHhDYnNZ?=
 =?utf-8?B?dmh2WUdocTdRZE8wWXRNcmF6d1VmdTZ6bGFKTmVnZkc4UTg3Ums1bEpkYzR4?=
 =?utf-8?B?MXErOWNSbGQ1azEyTFJhM1orTTQyMEIyQ2s3d0dPNzFzcWR5SjRod1Mya0hz?=
 =?utf-8?B?TFVRUHdVQzVFMTMwTCtTWElQaTVOc3o0MUpHM1ZId1hmTFkzdEMrOU9aNkxl?=
 =?utf-8?B?UVFKZXVHWkg3MWk5U2pkaHRZNjlxS3E3NXNtbzVXR1J4WWpBeGxybTVnam9m?=
 =?utf-8?B?UFFhTjZOcW1DdWJZc2VrRWM5dnl1R2lBVEF3Vmk5QWhPazM0Rk5FZGxzTmhN?=
 =?utf-8?B?RHVOTXI1OVUyQ0xUeU5UMmd1K0JyUVplY0ZEUm45SWRCTWJzUGUzUHJpSURy?=
 =?utf-8?B?T3Bzbm9LNldZbmRIVDJSc1kvRW12bTBXVWgwZDNYUXhsZWVRQ0pHVDl4YXJq?=
 =?utf-8?B?Q1dYWllqQmdUeXBVL0llL3FESjF6WGx4THJHZ3RZUjBwbDFzZ3pYUFk5eVls?=
 =?utf-8?B?dGtxZUgzTkoveitVaE1KWWFrRlFZdFdxeDRvb2ZWc2I2UDU2eU9Fb3ZOZDZn?=
 =?utf-8?B?WVVqaWhGYzNPcmRTeGphWXk5Rkk3by9TWHNJRXdLeW8zQlM3UmJMajU1YVNx?=
 =?utf-8?B?Zjg0MU9pNm55cWlnN2dUaW9vTmttRkoyL3Q0ZyttdFhoaUFHODNSUmhTRlFq?=
 =?utf-8?B?MjZ5Z1dXeCs1ZVNnRlBJeUJ0Tkx3T0kvTnEwaDNWd1hrRUI4cFVsODdaMWRZ?=
 =?utf-8?B?SHNjaHpGSW9uNTRiV1dPRDZDYnZJVU83TFlIcCtkamxVY0FQMVYzM0tnNkll?=
 =?utf-8?B?YThqYUc3amhSQVBFY3ZUZFpPbjlWTjg2WVNmUnYxaVVxdks2bjVad29RZU1j?=
 =?utf-8?B?UE5ZdEVwem9RVUhpQ1M3OXBCZ1VhektBQWN0TG1FcUVFcGxsTTNhTHhDZm9M?=
 =?utf-8?B?WEMwdkdKYkpudHFodytaZVBFUmxJcWpGcDRibzZrTTZncjBneGc3WVV4Ymxi?=
 =?utf-8?B?M1FSR0pJYi9LMFJXQUtWNGQyekNyTnlCejFkYmZYNERSWEdrU3JIT2piZDQ2?=
 =?utf-8?B?TmU0bWRlTjZla1IwQ1haV3VMN1RIL2hNSWZUNWZlcnJIOUtVdmE5U29hYTdu?=
 =?utf-8?B?RWtFdEJRVFk0TFR3NUVteml1TTdpRm9ja3ZRZWlaVFEydmVXcjNPNWVnQmtm?=
 =?utf-8?B?ZHhrNDZ1ZG0zZUlVK3VlZ3M4eTA4RXdBb2labVRaY2loRkhEa21wOWFUZ1Jj?=
 =?utf-8?B?NG5pZGJzUThhWlNHVTErWEMrc3VsR3FlaHkzeGtMVDRUcmdxNWQrckNVbXZW?=
 =?utf-8?B?aWIwT21UVkVUemltRTVYUk1WZVRUY2JlczJwZ3lMVzhZSEwrWmMvQklEZXBS?=
 =?utf-8?B?SE1oMjJ5Z3R5VHQzSXhaSGp4MUVhWUg5ZXJ6eFE1Q1JiL0x2amt2QmJnS0xl?=
 =?utf-8?B?QU81YzJvczdyL1doSGxXV0tXUXlTN2d4VkRNOVhTaXl2YXNPMDVNRDZVWjJp?=
 =?utf-8?B?OXpZdVYvTVdPeXJBU2VJZ0NBb2hLbkRBSGxweXpra0xGUkd6T3NKWEswUzlI?=
 =?utf-8?B?b2hxWEVCY1FweHdkN0U1ckQ0TEdBWTgzc0xGR2Q1Y082UUVTTVQ2WnhRL1FI?=
 =?utf-8?B?RlBvRFNlU2pRUkVRaFdKR1NiV2hoM1FyTE4zZTg0RnZ1RW1tQ01tb1ZITGo1?=
 =?utf-8?Q?NZmKkQXJoQnnmdBK1yqERWl8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5621d1ee-f70a-471c-e1d7-08de1c47df23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:46:54.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uerghm3LD3LmiiYAIF66YvB/iaZWMlIqp2Uay1NpEzsOY8In1Pqu7NoRc+Al2ssT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538



On 11/4/25 09:35, Pierre-Eric Pelloux-Prayer wrote:
> It's doing the same thing as amdgpu_fill_buffer(src_data=0), so drop it.
> 
> The only caveat is that amdgpu_res_cleared() return value is only valid
> right after allocation.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  9 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 86 ++++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 -
>  3 files changed, 18 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4a69324bb730..410e9b68ff81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -723,15 +723,10 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  
>  	if (bp->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED &&
>  	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
> -		struct dma_fence *fence;
> -
> -		r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
> +		r = amdgpu_fill_buffer(NULL, bo, 0, NULL,
> +				       NULL, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>  		if (unlikely(r))
>  			goto fail_unreserve;
> -
> -		dma_resv_add_fence(bo->tbo.base.resv, fence,
> -				   DMA_RESV_USAGE_KERNEL);
> -		dma_fence_put(fence);
>  	}
>  	if (!bp->resv)
>  		amdgpu_bo_unreserve(bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d88bdb2ac083..1f553c56f31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2412,75 +2412,6 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring,
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_ttm_clear_buffer - clear memory buffers
> - * @bo: amdgpu buffer object
> - * @resv: reservation object
> - * @fence: dma_fence associated with the operation
> - *
> - * Clear the memory buffer resource.
> - *
> - * Returns:
> - * 0 for success or a negative error code on failure.
> - */
> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
> -			    struct dma_resv *resv,
> -			    struct dma_fence **fence)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_rings[0];
> -	struct amdgpu_ttm_entity *entity;
> -	struct amdgpu_res_cursor cursor;
> -	u64 addr;
> -	int r = 0;
> -
> -	if (!adev->mman.buffer_funcs_enabled)
> -		return -EINVAL;
> -
> -	if (!fence)
> -		return -EINVAL;
> -	entity = &adev->mman.clear_entities[0];
> -	*fence = dma_fence_get_stub();
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
> -
> -	mutex_lock(&entity->gart_window_lock);
> -	while (cursor.remaining) {
> -		struct dma_fence *next = NULL;
> -		u64 size;
> -
> -		if (amdgpu_res_cleared(&cursor)) {
> -			amdgpu_res_next(&cursor, cursor.size);
> -			continue;
> -		}
> -
> -		/* Never clear more than 256MiB at once to avoid timeouts */
> -		size = min(cursor.size, 256ULL << 20);
> -
> -		r = amdgpu_ttm_map_buffer(&entity->base,
> -					  &bo->tbo, bo->tbo.resource, &cursor,
> -					  entity->gart_window_id1, ring, false, &size, &addr,
> -					  NULL, NULL);
> -		if (r)
> -			goto err;
> -
> -		r = amdgpu_ttm_fill_mem(ring, &entity->base, 0, addr, size, resv,
> -					&next, true,
> -					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
> -		if (r)
> -			goto err;
> -
> -		dma_fence_put(*fence);
> -		*fence = next;
> -
> -		amdgpu_res_next(&cursor, size);
> -	}
> -err:
> -	mutex_unlock(&entity->gart_window_lock);
> -
> -	return r;
> -}
> -
>  /**
>   * amdgpu_fill_buffer - fill a buffer with a given value
>   * @entity: optional entity to use. If NULL, the clearing entities will be
> @@ -2508,6 +2439,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  	struct amdgpu_res_cursor dst;
>  	uint64_t cur_size, to;
>  	int r, e, n_fences;

> +	/* The clear flag is only valid directly after allocation. */
> +	bool consider_clear_flag =
> +		src_data == 0 && k_job_id == AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER;

Absolutely clear NAK to that.

Christian.

>  
>  	/* The fences will be either added to the resv object or the last fence
>  	 * will be returned to the caller. In the latter case, all fill jobs will
> @@ -2531,6 +2465,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  		while (dst.remaining) {
>  			cur_size = min(dst.size, 256ULL << 20);
>  
> +			if (consider_clear_flag && amdgpu_res_cleared(&dst)) {
> +				amdgpu_res_next(&dst, dst.size);
> +				continue;
> +			}
> +
>  			n_fences += 1;
>  			amdgpu_res_next(&dst, cur_size);
>  		}
> @@ -2550,6 +2489,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>  
>  	while (dst.remaining) {
> +		if (consider_clear_flag && amdgpu_res_cleared(&dst)) {
> +			amdgpu_res_next(&dst, dst.size);
> +			continue;
> +		}
> +
>  		/* Never fill more than 256MiB at once to avoid timeouts */
>  		cur_size = min(dst.size, 256ULL << 20);
>  
> @@ -2574,8 +2518,10 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  			goto error;
>  		}
>  
> +
>  		r = amdgpu_ttm_fill_mem(ring, &entity->base,
> -					src_data, to, cur_size, resv,
> +					src_data, to, cur_size,
> +					resv,
>  					&fence, true, k_job_id);
>  		if (r) {
>  			mutex_unlock(&entity->gart_window_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index c059a3d52b57..97e73919cb0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -182,9 +182,6 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring,
>  		       struct dma_resv *resv,
>  		       struct dma_fence **fence,
>  		       bool vm_needs_flush, uint32_t copy_flags);
> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
> -			    struct dma_resv *resv,
> -			    struct dma_fence **fence);
>  int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  		       struct amdgpu_bo *bo,
>  		       uint32_t src_data,


