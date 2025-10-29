Return-Path: <linux-kernel+bounces-876560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36536C1BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FDB6E4C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082C33B6D1;
	Wed, 29 Oct 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pUoB3zXX"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020107.outbound.protection.outlook.com [52.101.191.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B05C96
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752550; cv=fail; b=q4Paj5tP4Lk+fP5bJlDLfdHMMdRYHVK9MSBMedKwGABrwiYMuFxsTdcBDQxuJLVu4rByN9cMHlS1YQC1xDwWK9IKZMIgkuNNtJsOE/fVHD/3nSVDIRm0iWimKscM5dBzmK2BbKrxVSNM7eopWeW0kOr6Uevo9ku8eO7Zu+9hZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752550; c=relaxed/simple;
	bh=ZLKD54hWsAe1UgMZZdt3vv5WmMpVVHWRzG7QHM1NXqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=azps9bqrnfqhqpTg27CRa3eh4zGShYpxq3TZjB8cLotpPN6HhVUTTQ3igwiC1uTL3d/LtoP4i63COK9g5GZVT9eUgCUfhsnGi0qmxacJe5kp65u9XXebz+lbjMxXJAXvek+PoZbQ/vwfmwCV54qu/nnqIUgtk4Ifj1R5ereyW1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pUoB3zXX; arc=fail smtp.client-ip=52.101.191.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOXOPxfaW0lDHE+RFv8jycFk8nxgrLmzGc4ZYRGJOO0Nm6w/ClgmpyvVAbDfveLPHPhW6E3CCOJrDfkg29seQem/sLJTPq9jxsMgUhbGlN3TFVxJ+Faxpy/CaqP4pQlNa5fErGphIIX5j9CQQL9UBlx0Zr/E5ykocWA0/5Gr0jL8DErIhv9FcjvJWbZdtZ/M7lozfvZT6Y/hhTVJAbXpVn/EhM6v2hm9eUYnqCpv8TxFqLyOTqTzT6or+gnSLzu6+QxvaV3eTYA5Np2TpfNEBQafkRXPbG8Cw7MvHvW1ByU1Az5xUctUelsDjr6Bdpm5LeV3rTZJl0VwuNLGtJ5nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocYmeHw37rsx9HVvQTmvxTN02gBwcoGDKoNV2qTa/v4=;
 b=r0g6SZCts0HRH5k9o/joBylG3PB/RPnJfOAQuwwqiP8FyXZfcgO4DerG8i/fHerZypGFGHIoUV0gyNiVK8KRmdPAL6CQlT8UJf+HpoF+whEtkOQycVDwIk2cc0NmKO4QycWwYUX77jIjtWx4kHg1bY/yOMd6Q39YsZiLyg7OHdj0373KVLFP5oLBKKC8WEFSeHf2jt3mW2IOYRvxUeFDFPDVN30HLD7Ce7C+iRu8Wpdq3xnM+++4lWpGYBGEDd6zeo49PImxoFFky254UqYDh8K7+OV7k8/9/GIfHAldaWFIulozJEkFs8kny83nt2oju0zmRUBc7R1HqIjGpHrLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocYmeHw37rsx9HVvQTmvxTN02gBwcoGDKoNV2qTa/v4=;
 b=pUoB3zXXmD/m/oSosYTLsiYzdT+7Xm94HWhMUq7Z77+GgwUMr3re4/6xo5aLR3gS/Brxi1EAY6X4fhRJdqd6QTYaLXYtDcDdX7fZUlRWfEa3d4Z0+7U2hl70PsqBPZbvV0OlYCb66cP0u1esW2x2mnczUsZMG496K3sPq2D3iZ3Gnbk5wMo4bqj3NVdwehXra/DviM86yq8CltNrAEGnXuHUgtz5gc60K/MGaABpWP5bxGyHSbnB0NRh4a7xn2tY/gXCdSwwbjXSIx02HDRDKeHddBwDEBQPQqr5a10J5uLBHsiHaJYjoHS2U+Cg6CkEawVAWSYXToO6JlZ3jto3nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10922.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:128::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 15:42:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:42:24 +0000
Message-ID: <e693a1dd-5507-410b-8e91-ac06990ff72e@efficios.com>
Date: Wed, 29 Oct 2025 11:42:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 04/20] sched: Fixup whitespace damage
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.529672945@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.529672945@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::41) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10922:EE_
X-MS-Office365-Filtering-Correlation-Id: cf32042f-3bf0-46e0-eda9-08de1701c143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVpkWmRLZE9LK3VIK2h1WkgyM2lmdk1Cb0FzNkJtK25KZnFlUldpV09wVnZV?=
 =?utf-8?B?c1V3TXY5UE5DcDNGTUljOG5kanZ6L1czOHlpZnRsYk16Qnk1WEs1U3BsWVJs?=
 =?utf-8?B?Y2xxZzhJdm9ORzJITG01eG1jczdVS2VjSnJIQ0Vqb3hJUFNMaENCb1FVQm1l?=
 =?utf-8?B?SEZpd2hyclVGSHVKUCtDblVFbWFSY09Hb080bXllZEtQaVRrY1Z3bURxb1pH?=
 =?utf-8?B?aU1JeDRUODl2MDhMMDVFTkZPSW1XZkRoRWw3OFg1eG1sT1JYWU15cnE0bytT?=
 =?utf-8?B?Y0RQeWxZN1kvWTBZaERabWxUeTZ6V2ZGeHVOUFJkYzJNYWRxUGJMcDFmZlpn?=
 =?utf-8?B?cjVxUThGQkExWTlBYXROUW5pcldMdW5MU2p2d3FadUZBYnRidUdwM1FsOVJk?=
 =?utf-8?B?K0lUVWttTkFXa2x4NE5wTjEwN0dkUlB0RWR0YjRVSUdLK2NXS2MxZTZCdSty?=
 =?utf-8?B?aWVTbHNwZExVK3htTUJvSzkwUWovSXIrejN2U2NyVFdMcmR2RFZUVmZSKzlH?=
 =?utf-8?B?T2NDbmpqU09mZDloY1Y0RVlTM0JGcEFKK1VMN2oyTGFEMTkxZWh4WEx0Y1hL?=
 =?utf-8?B?d214QW1qSWg5Q2dwTnpSMnFUT3p1UjVTMVcyVUl0VlFPWG9LNi9RN0U4Tkdy?=
 =?utf-8?B?K2ZwS3JiUllEUE0vMlFxNWZZbk1yUUdsWVNnamxVUHIrbnY3V1lKdUJPTDNH?=
 =?utf-8?B?OTdRb3Fkem1PL0NrUitNbFUwa2hPN0t6VGZhRUsyY3FjSFMyVndoNEs5Zytj?=
 =?utf-8?B?ZzI4UUxRc0FBYVFpYmgwYWs2Z0ppNGtRcVZGbUxkQnVVeDBVbEhBMCtBZTRC?=
 =?utf-8?B?Wkt3b3NudllvZTJDTG5KVXRBSnZrNkpzZFZCQnkxUUJySkc2c2xWQVR1WmN0?=
 =?utf-8?B?UzJGTjJDNVpiL3YvcDlFVWpUSk9RN0t0M3BPM0VnUFNsQVF6SDRjNTZRYWk2?=
 =?utf-8?B?ZTNQRWpzcFhYUW9yNDhEWXZiMG9MYk1jd2hOVkJtcXlRL3pwWUdpYmZMeVZz?=
 =?utf-8?B?WWxZNlhjaTZadjdiQWxGcDVuSGR1djBIbmhwQmlCVjBuMFo4ZjBsOFQvelN4?=
 =?utf-8?B?TjBSVmMrdzdHU3BiTVpUN3BMOUhTSEF4MTdTQm5UUU1KUk1BSHhDZTJacXU0?=
 =?utf-8?B?V2RGaStaVTgxb3FmYXJNWVY3UCtiUWduOW5RcHlNeUpDRGx4K1FnNzdxc2Zo?=
 =?utf-8?B?aDMvU0RiaWpIL1lmZi9kNFZJcERkVktiZ1hOWSszMjFMWFBaNDdYYVRHdkZx?=
 =?utf-8?B?OVdOVk9uc1hYV0dnc1N5NWJEam0vaGtBcjU0Zmgwd21QeFFkZHN4elFSbGdu?=
 =?utf-8?B?U2pscFVHd0FxZHZ0QVZaZFNXMW42cXJEdFErUEQwSS9WMHR5RHVxZXBWMjk2?=
 =?utf-8?B?cTIxYVpielJvTGR4Y1VNYTVqdXFBTUhGTlZUTE9VaXRvaHFyUklDVncxTjhT?=
 =?utf-8?B?TnBkZ2xrSmRRNXZQRmdIdXpFSEhnMTNTSWNobjdHcEtnZWcvT1M0ODhWNUNt?=
 =?utf-8?B?MFhicmlEVFRQbE13eFdxNlpxbWtSVURGQ1VLazFZd0VIQ3lmZGFFOHJ6Vk1a?=
 =?utf-8?B?bVJEeHZYeFloWGVRbXdHR05BeFBSYW4wL24vSy9nN09zWmE3WmdEdEkza0FT?=
 =?utf-8?B?b0Ria1ZFbW1nTTFaRXBpd2Y5aUR3QkJWbmJ4VldTZkhiQU1GN3JZOFU5aE5Y?=
 =?utf-8?B?S0F0cndmS2xUWTN4QzJPK0dxYnNiMld3bmNBcVJ3R1VPRWl3NGg2WjJkNC9k?=
 =?utf-8?B?QkVzbVFzcFJHb2txV1J1WE9Uc0VWbm9hOE5zRkhjKzZnYW80ZHowVmVpMFM3?=
 =?utf-8?B?bXY1Z0c0Mzl5Mk9xdVI0RW50Vm1nTXVsQXFXUjVtRmI4ek1WNUY3dEhKbWpY?=
 =?utf-8?Q?/dWePO0STq3zt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2Y4R2tFNFF3VlNyMDlPSnZCSmkwaENrM0tHSWYyM29OMVFHc1F0OGYvTVpv?=
 =?utf-8?B?Skt0RmRZMkhPclAxNDRMQ01HU2x4aGhxNmUvMXR4SzNrSVZVWjR2aVpqcGRL?=
 =?utf-8?B?T2RaeGJzalFkWk9tZ21tOVl2aWJ4LzZsOHRpSEszZ0FuL3pERm9HZXRpSmc2?=
 =?utf-8?B?SW9WVk42aFRjU2hDbCtDclVYSC9NYVBpakMvNGVzeTVOWFlCWWFDNEdxbmR0?=
 =?utf-8?B?VUxXS2lWcDF0bGRwVmdhYU5CM2p2V252cnAwNG1QT2V0eVNNN1VPT2FJSk55?=
 =?utf-8?B?UHFLaCsrUmpJM2VlYnRXUWQ0ZUhVOTFkYzVmYTY4clB0L1hVNDloK0FCaTQw?=
 =?utf-8?B?VVNMNzRZTFgzeWZCSFc1REUxUWhYT3lNUXZUQ1FoZEw3L1pQL0d0Qk5kcWp2?=
 =?utf-8?B?alF4NmJZTlBVUWlEc1Rhby9qcmIyTU9DTTNEZG5PeVE0dnBuTTRQc1F6NnY4?=
 =?utf-8?B?ZEZLc2Z6SmFLL1UveG13eWZndjNiQVVlWWZvUUM4QzNlWXZOZ3h1aGYwOElu?=
 =?utf-8?B?QURBZHB6NHI0ZVpVRDVGa01pUVdtWHFucVlsY1k1UnppTVlYTktEa1RuMDE2?=
 =?utf-8?B?Q3hUK05xZG9YbHBqSlVTVUZJcWFqcU9lTjNLRmVaeEg1NklLSys3Wk5qZTFq?=
 =?utf-8?B?b2I3ckNyQzNvMFZvUXFGcGVQRUtIdlFEc3FXYThFYTNUdnZyQUsxZExkR1hq?=
 =?utf-8?B?dlcxL2plS2MwaHdicG4vMXVkdTJkOGpUWTIzb0pET1RCbmtnTklyUzBubWhJ?=
 =?utf-8?B?WFpPVVZGK3ljc2hDQ2ZsZjJpakJpK2pyckZ0S01BaGpqcUppaVRGeXF5dFA5?=
 =?utf-8?B?OWRuVDFQU25VMXF3Um5yQllaZmpZTE0xVEdmeVV6SWlYVEpLR1psK3FaVWdL?=
 =?utf-8?B?V0ZJNlgxTDJVYWpoSEhkRkFoZ2dVa0dRNUpPRkFMNmJYcEpncVczeGtjNjNS?=
 =?utf-8?B?R1BvL2QySVRDZVhvQys4bGpYQjJNaDVBdjUzcDlaU2tjblg5V1FaNnc5bHNP?=
 =?utf-8?B?czYvKzZjaEtmRkdFS0pyaWc0YUdyQ2N2L3lUa2FvTkMrTjhQNjBHZUVTb1NK?=
 =?utf-8?B?Wm5MTUlnOWJYWTJRTW9XTUxudE5zOWZaeWxya3drcEdWZXBBWmZsa3MyZzEz?=
 =?utf-8?B?K0gxUis0ekdNMWtnUXM4L0NIV3dlV0ZIVFVVek5sVkV1M2J3b0cxU0pydlNO?=
 =?utf-8?B?YWZXd0M1d2VtdTFwWGpoN0ZMbGFmTnpXaDl6ekVhdFk0SEVYdUk2ZDVHMitu?=
 =?utf-8?B?c2RRb2ptUC9JbXM4aElRQWlCd0xiR0o2TjJCaHRtZSs5VXk1ZW5MMzhDU01L?=
 =?utf-8?B?U3JQaGlhdmM2b0pkazVDSnViY0pDMXB6OFh4OTAzaEVzMlNxMS92cm5jSW50?=
 =?utf-8?B?TGEvOGZpbU9BRnRvdUpZM1p2TkNhZlVCa2NuVjc1UWhzWi9Rd3E1WXZFTVRE?=
 =?utf-8?B?ZkZqbklHbE1kdVRKWmpqdi9TSi9YSWlPNjhoY1dsdnBWeXNSRDR3U2FGeHdV?=
 =?utf-8?B?M09PRGU5cjZCYnRGdFd3NDZpSmRXbnowZWNSTjRBKzNialJMRDRFK3d5N01Y?=
 =?utf-8?B?S3Y0WVBIT2EyeVRVQXV3c3RVTXJFRlZzb3BiRzBxSDYrRkNTTWw2NDQwcDFa?=
 =?utf-8?B?eEFETnkzdmdSUTlhQVBoS2JWRU16YytFSHJxekRYUzNidXRuWksyYVU2T0M4?=
 =?utf-8?B?VUtJaHRqWXVUSVNRWG9Rd3JJSkdUeHYrMVl3b3dzcGZ6SFFwSXZlNlgrNy94?=
 =?utf-8?B?WktCVWp2OGZKSXd4UFVFTk1IK2xtOXZyWVQrSk53T1M2QTA3TGp1UGthMVFM?=
 =?utf-8?B?VWhvZzk2K0h0dklKMWVPOFZ5LzlOQm4xeEk3RkpBclFFWkR0QzBxdGVESjR6?=
 =?utf-8?B?RkI0T1ZrOTR1OUx0NzNRSFF0eUlrMGt5UWJqOGYyR09qdDNBL2NncWRuT3Nk?=
 =?utf-8?B?MEZ5RE1LQVNtb21ibm1MdnpZM1FqeFFkMktWU2VHaUFMYXFRRHp0QXFPNXo2?=
 =?utf-8?B?TXRKMVhYcTZGWnlDTUx4ZVR5Q09Ca2wyaVBxbVdSTFVwdis3MFo0NVNkUlJR?=
 =?utf-8?B?YVEwMFhiQnpnVlZpQlo2QkQvT3ZlMkQ0clpBK2VLWDZ6dGlqQTJWTllzU1Fo?=
 =?utf-8?B?b2VmTGJBc1N0ME5IZ083TEZVNUMvNGZ0OUJmUmQydk85ZFJxdDU0elQzelpO?=
 =?utf-8?Q?56x5lgHGU2L/tg2d3Smztns=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf32042f-3bf0-46e0-eda9-08de1701c143
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:42:24.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnP354b6dyRm92GnZroihtyK4K6zESc2W3uMBihNoMo8SVgyLSb793M1Ob6RYiwjqQ16GMPBLtYL2mqTAEI5GhId6qRGJyv4gXDhINh17g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10922

On 2025-10-29 09:09, Thomas Gleixner wrote:
> With whitespace checks enabled in the editor this makes eyes bleed.
> 
[...]
> -	 *
> -	 * switch_mm_cid() needs to be updated if the barriers provided
> -	 * by context_switch() are modified.

This is also removing a comment, but the patch subject and commit
message clearly state that the intent is to fix whitespaces only.

This change should probably be moved to a different patch.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

