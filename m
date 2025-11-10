Return-Path: <linux-kernel+bounces-892738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A9C45B86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E866C4EC29B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627F30103C;
	Mon, 10 Nov 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkx4Sds5"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D6266EE9;
	Mon, 10 Nov 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768003; cv=fail; b=LDEkcsvKPJzFJtAT6uCCJRieXC8y8rqyAPZ59fWTicOTHAUGxZojZKdo4i1ucHwzvz8PFb+XC3cO0Xu2C7RU6+WpxLHN8uZByufRoy/kpFJieYpz/SbkVlyXMqGu1ZhEixUPbetg8FL4VlFqDnMz1NnOK75ooI5yKbymSZwIl1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768003; c=relaxed/simple;
	bh=42lMaqGZmJTpxNdnWEq1Hae+WyTqJLmd/humoAWEr3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tGMYkQebcNwrPwa3peml8VEG8T2KF4WkIuEI2fxp9SXkl62hnmJ4P9rszsfdtJJMuuh/+ZjY7pWqyIqqEIvvFPLkoNy2q8rbr5KGRSkl+Kknwm1hE1TlFtprJCTPBWwuOjk/0s6AkdA7TbicqzenZ8I2B/cEUNxatXHOIqu05tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkx4Sds5; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pigQpjarsAX0v9IXTZ3us6Pystm84WYwK+kHMiE7xQemNyKXqo+GsfreZImAf9jAmkGZyDLxQsaZiTkJHd7KQT9OJVeSUcUfEhZdGrDAFSYutSaOmZMuY5aVIaznpJpP5O7skm3kSQB+0b1aVVikFbd3IP4EoE8e1dRd9XtrRlId79PpYWXj8ib/jUAKKp83vD/R4fNxy3S0AZcI1Fk0hB/RhjnqpOKTPX1o8R3Hf6Z3gQ3x0sMM3dD6VKhWgiYqQ2XNcKYH4w+JPtPgVqiY+zSZLFxfe4qD3KFRSjKkItOsCMYroTzt/TcTgPnYwnqOACECsmX8mHM6BE6OseRfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgHeRQfvZphzAFb9Mw9/C2lDe154q9jHG1IOCsYDRKY=;
 b=YtTRV3N8HFo6BRwOgQQeceFXMN1ku1D7BXwLAaAmAAymp1yGjVwDJnOuJ6Tn4sqGL/DeBDga6lw3W7KFDnQCATUCGnoPru/fYKhsrmIpK6rtDjhXOHknHnR9LZH1uj1qRtIzVD6aXSHHMbbsNEeIgoiY9SQRrxnsVdVui0gVL77ltwSl+lrR7YVijcvNZhAtcR48n78Q0C0UzLkAbHAy/cui6YT9BZ+SVcaHGMtRnJtK20VU6o8XP8kCsfl61yPhZ+uWW6pTfgra5F/lcM4bZoyrWRx0nZn+twiKDgcMWoULJAJ2mylXkaQiRQ5fqkxnRH+OATzvsMUF9VG5anp98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgHeRQfvZphzAFb9Mw9/C2lDe154q9jHG1IOCsYDRKY=;
 b=wkx4Sds5KmD1t9YzcDRyFQwYsnD7FLzM5kfzqSeXifIFYU2EWoO/b4Vu99K2P+ecQbeqHmL2xbG+fkFPzhQK1VSPM1jN+pYNJ4h/+dw0YANoQDAlRZiLh3O9vB6JeVhRnWQyfIMPGSWn6EBI53C3m2xGsufTHGfd0Blh48ze6+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:46:38 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:46:38 +0000
Message-ID: <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
Date: Mon, 10 Nov 2025 17:46:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
 laurent.pinchart+renesas@ideasonboard.com, bryan.odonoghue@linaro.org,
 sakari.ailus@linux.intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com, Dominic.Antony@amd.com,
 mario.limonciello@amd.com, richard.gong@amd.com, anson.tsao@amd.com
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box> <aRGjX1pv0y_lVext@sultan-box>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <aRGjX1pv0y_lVext@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f0adb2-9594-4927-5600-08de203e0b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWx1Z1JHMVdBYXZMamtVcXpoNUtyNlhDdVd0YkFVRzdBQjRjNzE4bVh4ajBI?=
 =?utf-8?B?RHNGZ3M5WUJOTmY0Q0RGNFdYK0lCZ0R1RXBmbnpBdWpzbXVSYXhPUFRhWDRl?=
 =?utf-8?B?UkYydUo0ckcxd21JMWZ2N25tL3NzcFNyM21DM2J0cVVCMnNIVXVWNFIwR1ZP?=
 =?utf-8?B?d1NBZENFSllESUZyaTNPVjVmSHJ5bldEK0pTQytNZ0YwM1d6Z3hOdXdMOEdZ?=
 =?utf-8?B?eTlrbHh1Z3llS3YvOVo2eU0xMml3MlFTTU9DdnhSSnJWV3hWaTJVWXhoTmpn?=
 =?utf-8?B?ME9QeGdwT2xSYjY3OWM2ODlJRUFOTFVPUThtdm5DNHBPUEJReFZTV1VTOTNm?=
 =?utf-8?B?VmtqeVpvZ2t5cGtpb3ZxOEFLaXk3RHp2UVpyQlZsdFRIRTRUUU43QUpEY0dl?=
 =?utf-8?B?aXNJUGI3WUpLMnhGQk92NkZUSXdZRmI0TG5OR3hNb0Y4NTFDQXorQ3NpWGVj?=
 =?utf-8?B?SGR0SnRHT0hZbXAxQWErc3kyYlZuTDBMTlZQK254QWExS0U3S3lUVmxMb3or?=
 =?utf-8?B?cDRoanF5anNMS29vOWw1eDZPUS8ybnVJQXhNVVkrMHY0d0VIcUJQRmoxcVY0?=
 =?utf-8?B?OXoxK1RyOWdCRmtVTFpLWEVhb0dYQUw3RTZHaHFnK2dLVjFHa2xna3JhQ3RQ?=
 =?utf-8?B?VmVoMmxlSDBjUldGMXI3RkNCVTBkbEZMNWkybFo4clhEdGJRUVJ3bk5qRHR6?=
 =?utf-8?B?dnlZWERIY0ZyTnI5Y05JTENnelkxTm43SXpYYXRJK0Y2Y3lOdXJyUklJY3NQ?=
 =?utf-8?B?VW0zc2pNWFVTckpWK3U1Q0FJZmVjS2tQdkdDcnFISGZwNVFUWjZFK1hmYndV?=
 =?utf-8?B?RzA3ZjN5UHB0aXIralJaYkNqNGN3M1JtQ3JMTXFkcFJWSXNIOHUwRWRjaUFH?=
 =?utf-8?B?VnJ4U2szQjY4SVhPak1rSUovbFpUUU1zc1dlUGt3YjM2NEZYcVArVXhyZjNt?=
 =?utf-8?B?WVZjd3JQVzZaNjZMU3NvcjZ5ajloeC91UjFuSC9YRWRIa05RWmg4Sjl0Vm1h?=
 =?utf-8?B?eTI4NWpOSVdxOEhEaVBMNnFHa0dYUFF2TllPeWd5ZVpnd1ZnVE9qUTdxQVBp?=
 =?utf-8?B?YWZlMGxJVFhjVkx6ZktRNVJ1aTMxZ1k4Tkp1RjdtaWY2NnNvZVdkQmFhWkVT?=
 =?utf-8?B?ZG8wVnNSY0dEZkVReWw5cWVDaDZOV2wydDFwdHFhV1E3WmhGbDV2RzFwMzdI?=
 =?utf-8?B?Vnd1azVHdUYzTkNKdi9BSUNqL3lBUVhSKzBwMEZMbEhUay9WUVZCZDJyNDY5?=
 =?utf-8?B?NXc2OE1SdXFuNkZQNUl4aTloTjZta0ovbm9xWkc0alZxNHVOWHRBWWpEWE1L?=
 =?utf-8?B?dWVFV0lzeXpnd2wrQUQvdVFaNm96bVZsZGExbEVERkRWUnYrejJrSnRuQjhG?=
 =?utf-8?B?K0xLMm1MTE1XbndQQkZGMkJxS2hQd090ZzhHSFFZaHAxdURYNWpITjlsSFl6?=
 =?utf-8?B?Z3V0VkNjTzl5bkx1V05qTE1WNG50ajZiOC9uVVRkWGZDemdYT3Y2ZjFCYlRa?=
 =?utf-8?B?L2R1eXh3VVNvY1ZQOFNQODdNQkxTMnpFNUVNQ2QxSGVDWWZ6cDQvb0Y5SHJa?=
 =?utf-8?B?N2ZWdnNNMEpKcy9UcVdGdWdMaEVQYllaMG1FUkFjUm8rM2kyWmMxS0tlYTd0?=
 =?utf-8?B?TVlteTVxNGoxMytTS3pNcHN5L0psbjM2UXMyVGZ2aXpJZjhPaGVuaXVBMks5?=
 =?utf-8?B?dk91S2E0S2JiK21kN0wwTU8vNlJXUVFDRTlsbVJmVWxnODNqcGI2WHdqQ0t4?=
 =?utf-8?B?UnJJLzRJVDFwYTJLREQ4U24xYlFLVWhwYTdNeFFjNnVvNzNKUW4yZVZrVDRx?=
 =?utf-8?B?MnRSd1F4Y1NBZTNLYVBOeDhKUEJNMmJBS2d2aUQ5T3BZOVcvRTE5QmRTWllW?=
 =?utf-8?B?eVVQeTU0R0RUUUR2TFY0c0NvTlhjTjJZNGQxMGRadnlicHFzSVMzdSsybnlm?=
 =?utf-8?Q?WVl7wcxMWmCl6rRn0xJZ/XQV/6DG2wNj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1Y5Mm1YUHRlUUZPcVpMSlZWSnhjWDY0Y0M4dlgwT2dWdGttMllOSG1mbTVo?=
 =?utf-8?B?NC81WkJveWpzRXhiVkdwalBzMEtqSWgvNzZ6ZWpiaExqYVpnRTJFMTcxUlVx?=
 =?utf-8?B?amtRbzYvWk9CL3o5c3Q4MUpBNnIxdHE2M0xTTXZ6b3RXczhwSGRBQlcrajly?=
 =?utf-8?B?bldKeDVSdFNGdlRLWXdxUHV2bDJ5WmRxVVlFV3pyQ3VOV3Y2ZXN1Zm85REZC?=
 =?utf-8?B?eWJjd014NkU3dEpENTg3S09OcE9aMDAzL1RvcVVra2txNVUrblJuekViOTRG?=
 =?utf-8?B?UGYwK3N1SjRoYWRVQWgyMmwxMytzVnFFSUxFWFU5Z3NpVEZwVW8xVFpQMUcv?=
 =?utf-8?B?Yko0anBzMHowMElKNXFCV3JsNk16RVp2eVdWSWk3VHVkckhUekpuUUVGZ3FH?=
 =?utf-8?B?YWk2Zk5JQjZvSEZjL3JiNWowM2xMM21velFRcHdVb0tPSEJOUlVpYU54VXdB?=
 =?utf-8?B?UVVrT3ZuMytoUGovV0hsVlY2N0ZIcERFblR2WEFwQ1N6dUU3dGJ4cll0Qzdx?=
 =?utf-8?B?MWJIdWg5eVlEZi9STk5QemRhQTNxMm43enZPSjRnODhNNmw4dWI0d3Ztdjh2?=
 =?utf-8?B?aUxtOXI2Tjh6NUg0VnNTUnFYS01UelIvTFV1VHVrOWxCRGNPRzVhcHU5MWlt?=
 =?utf-8?B?NEdJenl2b092NUg3N2RLKzNGSy80cUdLQ2FwWG10ejNwQkcxZHhobnAwc084?=
 =?utf-8?B?N290MGdHQnFYQVFoYks0SElIZDhYcDdnVVNZSVRrT2pUNWhrZGwrbVRWQnF0?=
 =?utf-8?B?MDkwSWIrc3dERlRHdXU2T2EzWjdwblRrN3ZYVjRlazhlcS9SWmIvRG85TVpX?=
 =?utf-8?B?eXJBb1VHVkVONCszMXJMZkpUS0UvTWllZHFZc0MvWS9TRHhoaXB6M1krT3N0?=
 =?utf-8?B?b0hsdjFYSnNMR0lBNUx0ZERUR3pLTVIvRjJibW9hbWJZZkg2ZFRDM1pGN0Zk?=
 =?utf-8?B?b1JjSDIxTzhKV0VjQnpqWk1aSGhkaUZVd2ErYkVxQTFRL3JxWDdNTCttTlhm?=
 =?utf-8?B?MWpXTVFtTDNyZlRMRXgrR2Vmck9zUUNaTDdhTVJ0c0xHZ1NQSGU0TlFvRkE3?=
 =?utf-8?B?UGpHd0psT08zdWZsNS8rWjRDWEwrWjk1dElTeDhDT3ZqZ20xcmp6djFzUVZ1?=
 =?utf-8?B?aFovWWZ3ejI1NGFLYVQ3Q3R4NmxSOEtjZnlxY0s4bVhJZXFhQUZ6MVd5b3NC?=
 =?utf-8?B?R0FWUE8xYzNoUGFuY3NvenlTdmtPMmxqZmYybWp4ZGN4NkdIOEVaMjJDUlV6?=
 =?utf-8?B?elRZdXpOWHFiNytGcmd0WTNZYUYyekJYTGJRYm0wK0xRQlRtWkZGVDJ0eXd3?=
 =?utf-8?B?NVRNa0duS2dqVXZBMXF3RXVUakV2V1g1WWtrdVF6Z3hXZEdVTGJ2aGJqb2lW?=
 =?utf-8?B?UWFmeDVUUzZJZzBIZk5jaWIrWVZUNGZjdjNuTktxRk4vL1BVd3RYemo3N1FF?=
 =?utf-8?B?MDZlZGNGWmhmOUlVODgzeXpzRjI3aHJmV1k4RWpQd0ppM2ljdDlZekt2RkFG?=
 =?utf-8?B?Mi9QbHlQU0tiVEFUSE1ldFBkYkVLcVRid04zVVg5eTdwSjdUNy9jRGV5c2R3?=
 =?utf-8?B?eUlobHNYalRuUU9idURKTG9rMDlYbVVqNzkxclBwR21mdmZiRFFaYXRvSmNL?=
 =?utf-8?B?UUxRKzZkcXRCNGhaUXZ2dWVvQ2s2TUJ2cElaZUFJWmdUK2ptMmxTRS9lYWdB?=
 =?utf-8?B?em95NmFoM3phb0hPeDU3OXdGTzVscmNrUGxtbEE2Qk9Cc1IzRmlGdkRpK0JW?=
 =?utf-8?B?ZllQeXJMYnE1TG5RbFhsYk92YTAvZDhKeURWSmdrTmRTaXROeEk4Z25IN1VO?=
 =?utf-8?B?SmROWEhDZjFGL0xjUm1ZdUQ1Ukh2MjlwSUNZVVo5Tm4wOG1uZHUvZWJta1Jl?=
 =?utf-8?B?b1BwWEJoRFRWMG93c0wvQ1YvTEtScTc4OHVOTWNZaG5kc1J1OW5UQTZHNVRq?=
 =?utf-8?B?QzFVWmRXZjZML1dndmd3TE1CK0huUGFla1NMWjBuclJKdmVIRk8xTWsyYVI3?=
 =?utf-8?B?ZEVKRFRFcUl3bFBLZW9SK2ZvL0ZLU09Ndm82c2JLbG8wYmd5QkdJU1ZYb0w4?=
 =?utf-8?B?NE40aW9tUW9JTS9EUjZ1TDlyRzI5aUszZHBhVEpMMklGZFZ5YmR2MG9WQ21y?=
 =?utf-8?Q?R+no=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f0adb2-9594-4927-5600-08de203e0b59
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:46:38.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFDP5iDCnD0eLck6Ys8Rfc24IvXa7w9J/WYC7pgtNj3upSQvRa0m7/m/sA+BS4lF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

Thank you, Sultan, for your time, big effort, and constant support. 
Apologies for my delayed reply for being occupied a little with other 
matters.

On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> Hi Bin,
> 
> On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
>> Hi Bin,
>>
>> To expedite review, I've attached a patch containing a bunch of fixes I've made
>> on top of v5. Most of my changes should be self-explanatory; feel free to ask
>> further about specific changes if you have any questions.
>>
>> I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
>> I should send what I've got so far.
>>
>> FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
>> protecting the list_del() anymore. I also checked the compiler output when using
>> guard() versus scoped_guard() in that function and there is no difference:
>>
>>    sha1sum:
>>    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
>>    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
>>
>> So guard() should be used there again, which I've done in my patch.
>>
>> I also have a few questions:
>>
>> 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
>>     faster to use that than using disable_irq_nosync() to disable the IRQ from
>>     the CPU's side.
>>
>> 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
>>     beforehand to mask all pending interrupts from the ISP so that there isn't a
>>     bunch of stale interrupts firing as soon the IRQ is re-enabled?
>>
>> 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
>>     when the ISP posts a new response _after_ the kthread determines there are no
>>     more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
>>
>> 4. Why are some lines much longer than before? It seems inconsistent that now
>>     there is a mix of several lines wrapped to 80 cols and many lines going
>>     beyond 80 cols. And there are multiple places where code is wrapped before
>>     reaching 80 cols even with lots of room left, specifically for cases where it
>>     wouldn't hurt readability to put more characters onto each line.
> 
> I've attached a new, complete patch of changes to apply on top of v5. You may
> ignore the incomplete patch from my previous email and use the new one instead.
> 
> I made many changes and also answered questions 1-3 myself.
> 
> Please apply this on top of v5 and let me know if you have any questions.
> 

Sure, will review, apply and test your patch accordingly. Your 
contribution is greatly appreciated, will let you know if there is any 
question or problem.

> BTW, I noticed a strange regression in v5 even without any of my changes: every
> time you use cheese after using it one time, the video will freeze after 30-60
> seconds with this message printed to dmesg:
>    [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> 
> And the video never unfreezes. I haven't found the cause for the regression yet;
> can you try to reproduce it?
> 

Really weird, we don't see this issue either in dev or QA test. Is it 
100% reproducible and any other fail or err in the log?

> Thanks,
> Sultan

-- 
Regards,
Bin


