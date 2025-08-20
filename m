Return-Path: <linux-kernel+bounces-777941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB33B2DF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C01B625E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D12749D6;
	Wed, 20 Aug 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VPf6ZYD7"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2112.outbound.protection.outlook.com [40.107.115.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32C27280B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699931; cv=fail; b=CfgyxL2O1hypwRBlAgUA6tbBzlF1dIra0UTmHsXmKdplhsWbVzTSTUji1/Ye8oXSbG59j41aSXglKL4nBKhUgwJHxs5WsyAvnIYp5iMvKPaChButvWJsfxERPlwIECDjYSVaZkiOqA/ITxepnQr5jLeIvKbm/Hu5ETTNYjnEB6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699931; c=relaxed/simple;
	bh=SZQibLh3FuX8QMtUv2UFH3Xnx93Gl+yT434JxiF+aUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJX8Q/ODPdx7kaTxpJN+VCbzJz7/eRciayHKqeezY2F8fbHCKADKHLNfDy+1mWj3uPXywPSwCJd0O0G9rxQPYEvO7Peffu83dnlV9uP+6tCsHGsluG36MUwCqEKtjMLeZRnVk7V1H1ZMdjgJFSVAlTNThBa9xUJddMnTL2gu/uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VPf6ZYD7; arc=fail smtp.client-ip=40.107.115.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ9w3MEcpqeOH+KgW79oExHXhx147FuR1YTBymBv0cYHii/D9hZ3BTjwug9Cae6sfQnKSZYp5C2sPoA+ivh2l7YVyq7DAXcYNbYjYfD1pmdzr/oFlLUsd1MDW3SJKasDoJmLh/OJZ2Yk2cWQyWDculan9E9Owrmh7yE+ks///bjIQSMmmHdcInIaZbKOkfiPZztI+CoLK9klhgPt+1lsD5vEFp/XSh+DYKPWhTIcJ3b1ie/NGPCgqSb6UKJ9EoxZQ+DZQ3IQgjnV0SfrZvwy1gFmsn3aOsSv5Mo+OwFp2rEHXxYlsSJ1oHPxucIfMcj1DWRMzLusprOp4bNLUvVX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFE6GUzkYyWTGwSaEkaoFd7wREz3OdVVAUIErwXP9Yc=;
 b=FlpUu05yYbz4qoxOBWofoqCoa1lQW4dimb3sqUSgGA5z1xlpP897hVqF2tkJOk0Ec8UCa4JdcNxgUI1mZjHOYRzak5Rb/DtkSovG1zai1Ag03j8hqAPg0YOAU1fja/RCs6X3H3yLTt/8+JHl5aZK+gGUHjKk9UfRVWqC4u4dmm+ZxXtXMzo4z1vpOD6gbJ8M43MjMrAL6+KXaAZmNoZY+h65/X+LUF/bh/5+gAFg+m5YL7J/TPLNmSMyXDIMeNjmzPjppJ7+ZIjgFadYT20irGCEwqQOV3aa8umPxpmA2XeDzZ7zwQps+OrjuQ8lGV/3PTsfm+AYNCPghGYPp44ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFE6GUzkYyWTGwSaEkaoFd7wREz3OdVVAUIErwXP9Yc=;
 b=VPf6ZYD7Z5B9DUqs3tEDZgExlZabb1wc2rwH6VvTDVwYZ25kKs2EYXPko09vcnKTHNF04iEjnz/T3CQpJ6EOzkM5/GEpBXIKiIVyhGbPxQXplcyDccrqD0uGwHrS+PreDk9xQJr+56r6qGjM7VCgvfXtWXqh5Bd3Z3NIA7/TrtDv4mTxJSS4aoyKz4dWGcfiTklsqEA/xwnXnYP5SpfF8uvgTVLJPxZRiIZWckcq6Crz3Yhd4FPkFKfrv2MOH0/ApEGKSbf4y4gWiZVWtlsPVwMgpnHKhWD+dFEVyb0y7LaU8RhEpQ8uXeaymrKPWB4oGr59KrTWCSzBCDol6NmoOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF6D21D4F3B.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::549) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:25:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:25:23 +0000
Message-ID: <d0ef5bd8-6a01-4350-87a1-0acdfdf38cc4@efficios.com>
Date: Wed, 20 Aug 2025 10:25:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/11] rseq: Rename rseq_syscall() to
 rseq_debug_syscall_exit()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
 <20250813162823.972744605@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250813162823.972744605@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF6D21D4F3B:EE_
X-MS-Office365-Filtering-Correlation-Id: ae29fe36-9396-4ed8-9de2-08dddff56678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDlYRDIxWEJ1YmdhQVZQRmRhLzI2TllsdW5oeWZYNEl6NGI5V2l6YUd2QkxP?=
 =?utf-8?B?OHRpeFRTNGRlbjMzMGdaaitlRWdzQ0N6VFg4T3M2eHR4UGErTU9JU1N0OVZB?=
 =?utf-8?B?Uk9FYmpvYzV2M1VtZWkzdCt6V3VkOEp0VTFXV1dtdU41UW05aGJ1TTI1b2JS?=
 =?utf-8?B?OTR0ZVhsdVNHSHZFQVBTM1FTem54SjlRU0oxTVpnSkJTTWUwelVybU5lV1By?=
 =?utf-8?B?UzlNNFUyWWo4d0laNjBrV1IvbTQ5MTBOeFQ0d1daQ3JRMGJMdERkMEVsODNl?=
 =?utf-8?B?VHFUQW0zWlBFdjJqbEkzbGtGNmQ2NitSUHg4V0lCamVMZDdXY2piYmhJdWht?=
 =?utf-8?B?N3NtNHlXdCtwK0tmTXlML0ZqUTlCZW1HOGgwVEFUcjRpaHNiQVptSG5veXhq?=
 =?utf-8?B?TVhJcFZBZFZFYU5KUHBjdkk4NjVaLzI0Y1VvZjNwd3BVVUlCdGZtOUplWm5G?=
 =?utf-8?B?VjlGc0RkUTJwRkQ3MGdLV3EyL0ZNcExsbkV1WjlSc1RPTEpJNDVZNTY0TmV3?=
 =?utf-8?B?NEM1cXNFNkUxdDVxK2xYMS81dTJLOTAveWdMS0VFdUVacTF2YTUwbFZ1TEht?=
 =?utf-8?B?VG4rTnFyeVlVTlk2QW5sYTA0RjdqUkJMMEFVUmVTUGVncmhDRkVVWVJIditX?=
 =?utf-8?B?cGhCL2c2L0pHWHYzV3M4M2Jhei9paTFDTEVpOFpsV25aMzVyMUdaRHZPMFU4?=
 =?utf-8?B?NTljUFhNMWd3V0VvL3Bsb0F3QW5IYmVoM0E5aEhRQXBndHA4THNxUFA4RThQ?=
 =?utf-8?B?eStRd0FjcHB4NytWd3o0alFoWFh2NWZmSFJXS05Eb0FCbzEwckF0VTRYdXNK?=
 =?utf-8?B?L0M3T0dWdktFcVVxY3FZTDcreVJMeDBSbklsMUhqZFpaOUhWdFhRTlFaVlNS?=
 =?utf-8?B?YnVlNmF0aGFGSGprS2NNUlBrVytPTG1pN0FaejdYNk51R0VkRGgwdjkvVC9k?=
 =?utf-8?B?bU9yaHBhL1NteWwvZFFrdlF1RW9LT2pRUDFld3dHbXJLMU5BRVkwUEx0ZUgr?=
 =?utf-8?B?Mk9SK2x6SHlGTjgxS1hlenBEUUpSNFFkTUVEUnlGM1VuVkVGMEpHRlFZb2Y5?=
 =?utf-8?B?d0ZZUWUvVjBQOEpTTGdhd3RNNEtuOUN5bTBsUXcwVThvUmhvTTRpUHB4NkND?=
 =?utf-8?B?bWI0Z1VxVGhRbEZZeVVON2E4aWo0c0NLVFdrS2k5dEkrL01vMVhud1pyUVFG?=
 =?utf-8?B?SitJMHpCSExXMWh6WEdWR09nRVoxU0RvQzdCNXdTaklZK2lGSWFKeVNxZ1c1?=
 =?utf-8?B?M0llaFh1T2R3RnpKUnBTazFZeEVQVEp2RDFtUFVxeFJHclN0UUFBYm9CUW9h?=
 =?utf-8?B?VTV4T1NxNmpsWElmMmFCdmlKRjZWTHdKRDZvdXV2dVdtWHErVlk4a1ZOV1E1?=
 =?utf-8?B?aGZsRXZ4T21VU1hwUFp2OWFSK2ZZS1NiU2hqRDh2c1hPS0JOTExwNkllVWpz?=
 =?utf-8?B?RTl3bVh5eTNkczZnYmtjSVU1SHBCV2lZZDRxOHdvcGZtM2V4bXB5cU82STIx?=
 =?utf-8?B?NkFxd3M4NU1uS1NwY2hqV2dPWnF4MmtTdVBUeTBTT0RlYm53NVhXVVEwZGQ2?=
 =?utf-8?B?REsvMC9jT1psRnBpM3RpZWx0VjJpYWpOUTJnVUVOQW9FRzNxYUZNTmZsL0RW?=
 =?utf-8?B?Ni9kNVdyUi8xWURwaU4vUHc5bVRiU1lseU04VXZ4TWpGRmpTakljcG4rZmZM?=
 =?utf-8?B?L3U3bURFeVkvUVVXd1ZYazA5WWVEaG5ULzhsUTFNR00xWWVTRWUyUURMWTFC?=
 =?utf-8?B?YU1tRnRXcTVJT0hZUFlwclJKTHErRk43bkdJMHZ2aDRDWXMzNDBMRmtJTVRs?=
 =?utf-8?Q?pYZzx6bhlGEzzfFq1ivxDerQuDYoGXVeIPMCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFTUnV2REJreGZJVUgvcUJQNVp2TjlaSXMxTWYzWkVFQlp4MFNKRXZDczA1?=
 =?utf-8?B?TEYvMjlNOXQxM21DY01JWXg2NHkreGpWbmdwOGRGeWorYnlScmZVVEtPWVBl?=
 =?utf-8?B?ajlLcmVWVTRKVEFBcklzVFBHYXR4bGJXWmRaVk5WSWZrUjB4bzBzbWR1K1dm?=
 =?utf-8?B?MGFHV242Z2duS01OL0RjRTRobVJ4VEM0KzNXUlRlUDBRRGFrckZqeXI1clh3?=
 =?utf-8?B?aTNUT0cxYUlKRGplOXF2VnV0LzNKVjVXTTFLVTBOSzZJN1JJVGtFUUVIaHBT?=
 =?utf-8?B?MjBCNTRCV0VrRC81MldWdXZoUng3ejJNSndrQk1Ia3NKOEVQMlF4dHRRVWVO?=
 =?utf-8?B?blVhRlRpb3FvSVZBby9Eb00xajJLT2NrOGxOcGxpSk5zWlFuRlRnRGg0UTFE?=
 =?utf-8?B?M0w5ZVRQaXZtQjFaa3VDaE92ZVk1eDlXUEMwZEJEbVErRVRUUHlvUHFtVmtW?=
 =?utf-8?B?QjNJSDNuODdqMHAzYW90MWplUk9SNDB5ZklSdjkwZ1VYanRUcEpNYkVpZkh3?=
 =?utf-8?B?ZFZJSUJ3c056R1VaRTM3SmE4ZnIzbXpOVEsrWXZIOXplcUtuZlhEUXFhYk14?=
 =?utf-8?B?R2RMVm5mbGJ3dEdRVWxnT1VTYVE3SitTYW5UY0VEUXJJWDZQYUpaVUFGZ3Bp?=
 =?utf-8?B?NDcvdGlYcExDTHNUUFZNMWpsVVUydkQ5VjN0RjRTTnNuaCt4TnloK2N6cUd5?=
 =?utf-8?B?Z3J2Y2cxVjVSMFdwcUlLV2FQeTFiRGx5cjlOTVliT0RUazBteFM3V0dXbW91?=
 =?utf-8?B?V1VEaEY5VzZvbFFrQnhlbS9QQXBObU9UUW1IWXBSWkpkZEVMemQzOWRKN25k?=
 =?utf-8?B?OUVYY2s1VnNPaXc4WVlTc29XNWpwVFltaWxOS0k2MDFrOGRiVTR1a1NTQ3Ju?=
 =?utf-8?B?L2ZCVHc2V2d5MzRKdTMzT1hJMWF1RThJbkJIazlLa2dLUXRNRWhNbkdxQVd1?=
 =?utf-8?B?YTFCdlFOZXJ1Z1lSdWxHKzh4Qk44Y0p6bXhhSFd5OVJ0MXRCSEJObkZHbzZI?=
 =?utf-8?B?L3RuQWZaQmFnNm1rNGhRczBGWGZmdzR0dkZlTkVseUw3dDkvSEZESkhreHJW?=
 =?utf-8?B?YXVxcnVFV0tNK2ZuOElZQy9VUmJEYTA0RFVsWmxHTy9mUEJEajMrRWxmL1NX?=
 =?utf-8?B?UmNQdmxxYlM5cnluelRuYkpEU01pTjU0cE01eDN3VWdKN1Iwa3FtM3IwcE10?=
 =?utf-8?B?OW1wbFc0cGt6dWVxWHkyNFVqU1JJaDZPbDJidTdhbjJjSUwvenN3ZmNXbVEw?=
 =?utf-8?B?Vi85VzhONitRNytBWkF3NDlmOHdPUTBEcEIxSWx3cmkrSDFBR3ZhOTRmazlF?=
 =?utf-8?B?SDQvcUprMjEveWhSMDFMbURyT0ZYdDRPVXdLRmxRQUZPM3RNSlFORnZYOTJT?=
 =?utf-8?B?ek9XNkdzeWtrNU5ISml6YjByMVZOVGhEbGN1NXdncTV5ZzN5aGVDK2g5Tkp1?=
 =?utf-8?B?TkZ0Y214dEhRUHNKVkJ3STJIS3poNnpSR0YrdjQxZTRwaU5EdDY0MncvSFBX?=
 =?utf-8?B?ODNtd3IxZEVZWUtaV21TbHVLbUNRMkRnbnpMc2VTT0d5dGFVSFozU3M0cUtF?=
 =?utf-8?B?K1dmZHJGbW5aWTh1RjY1ZmJ1emFGbm1GcXFIWUFJQVBlK3VLZm5Ocy9EZXkx?=
 =?utf-8?B?bnJTTWh4NzRrTG1IUTg5US80QnU0Y0VYUHJXWVZBNG9TQzlkSVExeEtMV0xI?=
 =?utf-8?B?NCtZTnVLK0F4bW9QRUVlUUlZZlYyaHJNRFArWUtPWUpTQXBIUXMwd3M2cW1i?=
 =?utf-8?B?SkxVRGVPaFVXU3p1cWJYajRLcUlFMDQ2U2N1akc0YzFlb0YwR3oxQUJRUTNT?=
 =?utf-8?B?QnF6WE9CbGtYQm1SWWE3MmVLdThQU1lxdVFhU002b3JNelVra0ExK1Q4Sm5u?=
 =?utf-8?B?YlNabkxYSlJuYzRKWTNHQU5RVEhNVVRPemExSXg0d0xsMTIrek1uWWRwb0JQ?=
 =?utf-8?B?eEkxYnVVQVJvdG05bTBWMGJtRjlTR1pKY2wvcHVlZmExL1N5Z21MQndJQ2Ew?=
 =?utf-8?B?TzkrWnF4em5wZ0Y4V0xBVTNrV2Y2U3ZZc3k1NzBoTWIyT2dCblVJNFVrSkdP?=
 =?utf-8?B?WDdSbm43KzlvSFBYb3l1YW9ScldhL2dGUlZzSTcycjhiU3F0R1Rsa251Z01D?=
 =?utf-8?B?d2xydTMzb0E2bjVLdDd2QThGZWo0K3Rld1BXa2Y5eVRSb2xUL1djSjRxWkZl?=
 =?utf-8?Q?ngjZ90WqTVCuRs0nO1B2RIg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae29fe36-9396-4ed8-9de2-08dddff56678
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:25:23.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzSyC8eqlnEZM7A64CiPRLkryqgH80UoLwNxTfuZH+jTDlnsdyjv/y2NkI95Okmp1iZ3aIy8UxWjs+zQIEjR7qDsRgWgnl5n0buSEE0U7A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF6D21D4F3B

On 2025-08-13 12:29, Thomas Gleixner wrote:
> rseq_syscall() is a debug function, which is invoked before the syscall
> exit work is handled. Name it so it's clear what it does.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/entry-common.h |    2 +-
>   include/linux/rseq.h         |    4 ++--
>   kernel/rseq.c                |    5 +++--
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -162,7 +162,7 @@ static __always_inline void syscall_exit
>   			local_irq_enable();
>   	}
>   
> -	rseq_syscall(regs);
> +	rseq_debug_syscall_exit(regs);
>   
>   	/*
>   	 * Do one-time syscall specific work. If these work items are
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -113,9 +113,9 @@ static inline void rseq_exit_to_user_mod
>   #endif  /* !CONFIG_RSEQ */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> -void rseq_syscall(struct pt_regs *regs);
> +void rseq_debug_syscall_exit(struct pt_regs *regs);
>   #else /* CONFIG_DEBUG_RSEQ */
> -static inline void rseq_syscall(struct pt_regs *regs) { }
> +static inline void rseq_debug_syscall_exit(struct pt_regs *regs) { }
>   #endif /* !CONFIG_DEBUG_RSEQ */
>   
>   #endif /* _LINUX_RSEQ_H */
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -427,7 +427,8 @@ void __rseq_handle_notify_resume(struct
>   	 * this invocation was invoked inside a critical section, then it
>   	 * will either end up in this code again or a possible violation of
>   	 * a syscall inside a critical region can only be detected by the
> -	 * debug code in rseq_syscall() in a debug enabled kernel.
> +	 * debug code in rseq_debug_syscall_exit() in a debug enabled
> +	 * kernel.
>   	 */
>   	if (regs) {
>   		/*
> @@ -476,7 +477,7 @@ void __rseq_handle_notify_resume(struct
>    * Terminate the process if a syscall is issued within a restartable
>    * sequence.
>    */
> -void rseq_syscall(struct pt_regs *regs)
> +void rseq_debug_syscall_exit(struct pt_regs *regs)
>   {
>   	unsigned long ip = instruction_pointer(regs);
>   	struct task_struct *t = current;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

