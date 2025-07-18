Return-Path: <linux-kernel+bounces-736315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13EB09B71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4361C42D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB941E5B60;
	Fri, 18 Jul 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Dyoosk44"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837919E97C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820327; cv=fail; b=sB7brnGuVIihwTDUZC606cc2mcX5VjSwYW5QFuPDJO9RwWnvBP+rfikbQV/WE+Hgy6UHJDDLNvbFJ+rstkCAU9DnIHVyNdr0+7F5KsnYf2B+NK4gfl6SBv6srPMl5/H4F0xKSuDJSvI3r+yQj0yWRoL49j/kIRdYqW7hO+M+nZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820327; c=relaxed/simple;
	bh=GAuLCdT0L3Wgglg/03Yqw0gKG77rizmhwAacFDeR6PY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLmIRo8tBvPFSUHWZ6/8aCR2f6civVM89RpMNqMqLsN/6sK4z55QyJAnJn0JWWHrpxjEOEkyOazRUWUpfXWK2OfWrHlPeRji8WAlSg4AjaZa/Z4eMLZfpQ2DxpKmI6svP0F+A2ezvfVs1pxi89aVCkhyT3uDRnEg9+1x3Le+CS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Dyoosk44 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIIl7CYJ/0Q2rjTk8N18zPasNTHqGrmEgQW91P/HwECvXBJDhh0qQtneucixI8XVTR+26tfAAFt4IzS6X+GpRbdegMYLO6qFXuYNjdtISP5DbdAj4jqkUrXQH6TvnoHKJS1xNC1s+BCGGxt8S8LsE4PkKe2bixFacPFs5pOzDXf+X1czwOtmt3tcr93XVhgM54rTHFMNrmptZ6ZNwb53z74jp327kxsTyUTuvCM/jd3cqcFjZGOnGnZ71yp2PW1HBY6eP3G9FfKWc3U557un5L4vsC7J6BTgTlNq8t1tnGahyofwHrt1HKjqnZsrHNyfQOYMi/mPAKfrnbIJ3RO+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYoYq4/z7U8saXDbNHf/5YQiPL1RVimVhXdLg7zpUyY=;
 b=EKbcaooq5oFIlGWRQQVF5nOlOzWwGivIah3JWZXdHJhA+bRTJARc9izbWQbXrQ9qJl6WsntKbJENg5fXUZ3n27lFrqhKlyjinVceNlqToJFIMm1UycVI+v++TWRYyIT8Goev1NDGRX39hmo7p4rub16txa5FeKJctljMW3OJsflsYAGbvu1VmV28okhWmkmCG74EVbZ4wIiHNkRbVgo0WURHQlpkS/rba6eidEjFcokgyhFjjilJI2t/nKx2h5Jv5RAp4+amStteF7u85ltnOXC5D5Iixa+COhza1ajcdNF3bU0LNx+8eP/7lDzQEZ338jN0q7oB74NIV7+fxVDoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYoYq4/z7U8saXDbNHf/5YQiPL1RVimVhXdLg7zpUyY=;
 b=Dyoosk44/76fl1J8DSoAUuMJkjSKs16OYzoKNgOgCWv4LQWUT7TvRaWSnmxx20l/FOgaJsN4H7j0VoFngW9pE9CfJIt5PRaJkywgCrfZS/ciHoc7EGQNz2Oww73BM9JMEZ2PBTfMr3/E+xmFAc3bPvp/9B1IwCwTU+lcx9NgZnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB8987.prod.exchangelabs.com (2603:10b6:303:272::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 06:32:01 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%7]) with mapi id 15.20.8922.028; Fri, 18 Jul 2025
 06:32:00 +0000
Message-ID: <8ce3cd68-1758-4efd-80fd-f60fb734e66b@amperemail.onmicrosoft.com>
Date: Fri, 18 Jul 2025 14:31:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: do not scan twice in detach_tasks()
Content-Language: en-GB
To: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 vschneid@redhat.com
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250718054709.8781-1-shijie@os.amperecomputing.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20250718054709.8781-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ccecb2-56a7-4894-11c7-08ddc5c4cd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm9EQVdGU3JPM0hXb3FnTDBjRnEvSDIwTW82b0xUZVNGSFNYMGRuVFIzMUY1?=
 =?utf-8?B?RUY3eGFCcEFiSTBTd25kdlFXL3dJdG9xUWQyV1M1QnEyMnVIOHdvZmxPWnd5?=
 =?utf-8?B?OWRRTlRVa2VTbUZSK2h2am9jZ2QyN2RPOGFjRUVyejB2TUlxU1RLWHQvQUZ3?=
 =?utf-8?B?SlI4V0hGUmZYU0lsMkF2WExxeWxvRUxvMjdzaEwvT28xY3g1bUo5STkyM2Jh?=
 =?utf-8?B?TlhzV2hVTFdQQUtsSDdNRnFtbmxZVnFqNVRMQWxuS2ZSaEFiUldZOS9zcU9N?=
 =?utf-8?B?RVBOS1dCbDM1WVFIV2loTG5sckpDV0VMSzViMlI1UndMNlRENmU0cEx1MnAz?=
 =?utf-8?B?a1lpZTI5NnpyREF3OGcrOExCdVlRNjlDK1pmbzJQb0dCTENGQ2Exa0trZTA0?=
 =?utf-8?B?WnpKOXVwVkxjU2ptODBpREJGcTR5c3JBYmFzeFJKSDlYZDJIbVU4U3k5dWor?=
 =?utf-8?B?d2RyTW9PbVJHeDRVUC9ETWdEZjhVSkdZdE8xelRDS0FOZ2p1MDNtM2hFbXpK?=
 =?utf-8?B?Y1l1VXc5OHRvNEU5ZTByVll3bWNrcXpuVnZBMGFhM0FKenQweFNuMzlGV1A4?=
 =?utf-8?B?NjQ1Y0hWSlRPaDJoODJnUHBiZlhQZlZLb2NtbXo2TnM4ZUc0K0NvdGxQaTlq?=
 =?utf-8?B?ekpFR3JIT3VncUYySDVtOW1nU0tNM1FKN1RqSENkQ1J4NzZQMkR6NzNpdEFP?=
 =?utf-8?B?SmdzWlFZcGJjQVRIcG1Lb2M2ZHQzL2dFNmpmK0NPYnRVM3NKQTVJcG8veXhz?=
 =?utf-8?B?SHZrU1ArMlE5eUZNcnh6ckJkeVlGUzhwL3dLeG42L0YxT1ZnMlI1bnEyRnkw?=
 =?utf-8?B?aVVZWWYvdzFWckRNU0Vta0tkcGhwWXFyd3AyTTZMc0VOMEM4VFBIY3htVHNi?=
 =?utf-8?B?VFhrZkN0ZGErZU9PNjhVUU14ZnpoOHdtRnFjT05nbXRPcFE2UVRQWXZhRk4r?=
 =?utf-8?B?dWdWUGkzSCt5UGliN2gvT0RseVAxRlRkM0dsOTF2Y3ZZZnJidHFRVTJOMFF0?=
 =?utf-8?B?QWd5cmFXMGI5YlkrSVZzRFd2Zkxtd1RrdFJrdFNFbDVFcW55ZWlaZk9Eb2ZC?=
 =?utf-8?B?M0NPalY3VEtOb2JycXhGRjcydXlaWFkrQVFYL0hHN2pKMW05OFNPeUYxKzdp?=
 =?utf-8?B?ZFFPUEVMdmlsbFdXYXpqc0xtRitaTkUybGRnaGVNWjMwQTZNYjNpbkRvUVVi?=
 =?utf-8?B?Si9lNVRXL2k3ZzJ0MVBRNG4vSlY3SHVodWVDM0tDMG9HcHpJeERBMWlyZjd3?=
 =?utf-8?B?QUFyUzQrcnBHV2tPSWI3cnVBeUpPcE0rQVYzWGVWelVQOUhXeDFyOTJLeFY1?=
 =?utf-8?B?SjFlNUFyK01ROGpaa2ZOVTY2SE5DOW1Ma0QxYmtRcDZvME9OMVJqK1JyWXZK?=
 =?utf-8?B?djhSSUtlUGQxWUFsY1o3a0FSZnFBQVVYd2lyT0tLVHFKb0FTN3VGVTk5SDhG?=
 =?utf-8?B?R01mQ3BZRjhBbzJCZW1FdFNVNndkRmhaZmxVMzMxbVkzWUxGRzgzM0VLUGRW?=
 =?utf-8?B?alErZGs4YlM4Mkk5endRSytydUhNNTI5bU5wS3dRZytHU0FDYWhmZCtvNDZT?=
 =?utf-8?B?RVF2K1VyMkxhck8zQkxIeHd5NmRQZXJXTUdvQkVWL0FCb0NJSkgxUWlTZWdN?=
 =?utf-8?B?UStoRU5vTU5vdWl5SXgwdWZaUUQyTVpnUmw1dzE3cCtVaThrd2tUd1BubXNn?=
 =?utf-8?B?N0Y2VnlFREZrclRtSXZaWGN0azB1cEJNTlNwajQwakdrbUp2RE95bXRPY3Z2?=
 =?utf-8?B?d3dLYXFvekdEMXQ5VHZXNEZtLzErNk5nYnpXMEE0cjh0eVBMd3pOQjFlUTdv?=
 =?utf-8?B?b3RiaW5jbmxDUjZPakxzeEFFajk0c3VmV2RXZHRIQmJMRDZlU3p6WEs5N1Z1?=
 =?utf-8?B?aDBJQm9NajV5Si8zSk5RTFFudlRmOUVveVBpREYvSVpoNytUTTY5Rll1ZWJW?=
 =?utf-8?Q?GDusNcDi3Cs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2hTcys5MkdaYUNEaFJvUWE3eGZkanlXNmxXeEU2TTZlYUlJNlBjV2tRSXBH?=
 =?utf-8?B?M3F4cENlSlhJMGFtYXZUV0QrTG5sQ1NCMk5wSDZCd29DWmJZYS9BTUdSTE5T?=
 =?utf-8?B?U3FEK3EwTlorYVZQUzRoOW9rY2l2SVpXcTlqam9jTUMreklTSVRxVDVIVm1Q?=
 =?utf-8?B?SDVYZFdMblhkdE10MlFyazBtMHVic0lpUnFza25wUW5pcStmTnZhZlJabDhV?=
 =?utf-8?B?MFZBT3h5Q1NYQ3dOVHpCbE96UFF1YlV0NjhGWTNsOEJMRkJrSjVTVXhFV3o3?=
 =?utf-8?B?SUMwMmZ2OHl5VjFSZ1p0N1REVGxrSTQwSVdlK21xSXVjM0s0djRGV3Mvd09z?=
 =?utf-8?B?RDgzK054emJjeldVcTNyTGt3ZHk5NWZrUjA0c3h5cGtqa2FhMC9POWtFSk5P?=
 =?utf-8?B?eDAxM3V1WGxqUnBtR3BJS2FtdytuRm1mOEQ5NkJXTDYwL3BhanZIVjhYL1R3?=
 =?utf-8?B?S3NHWkxGdkU0cWszUnpCWTB6MEphYndJS1lpWm5FUGY5ZnMzTDEreGpGNlNW?=
 =?utf-8?B?aTdKNVhBTlhGNS9rTDFjME5LUXNaa0QxNzJXeVJxYlRnK3A4UkhUWmxqWVdZ?=
 =?utf-8?B?Y3EvK3Y0b2VMeGxVVjlzRzU0V2M0VHNNNEpaWWdvaTVmemNZSXUrbDdyd3FM?=
 =?utf-8?B?Y1h2c0VNcWtVbzlxNHY1U0N2dlJnLzRNOHIyc205RXgvNFA2Q3FYQUFsNnhI?=
 =?utf-8?B?M3NSbFpFNlFNN0doUVAyTkRZYkxOS2loRlNpMTk4MUFOcHZNckVaT0JIRWxM?=
 =?utf-8?B?Y09LZXh2N09nUnI2U01sdTh6YzdDUVBmK2l5bFMwS29lMjl0cmcxT2FmY1N4?=
 =?utf-8?B?WjZSdWFXRkxlcFhTNVFPZU1GVnZLNmRyd0FYWXYvWEhLUWdLb0hJbHNlK0tO?=
 =?utf-8?B?SklFQzJsVXZ1RUF2ZWhlM0Q0TFlweTNkaDI2a1pyakNTVTF1TUZwamx5NHRO?=
 =?utf-8?B?SU11U0hTTWhLMVBjWG9BZVJOdGovSm9TV3A0WmVZU1FsTEFOeTVhMkRpR3Ri?=
 =?utf-8?B?Y0hpN0dHZHlHdkRTV1Bia3dsbHdsZ01LTG9IL3E5cTBEOWt0T0NKK0ZNbjdu?=
 =?utf-8?B?MXE5TnVZVkhSZWVsZFlRUWxDVTBOc3lKdTFrMlI4OW5yTjgwUmJPMFNkaFIw?=
 =?utf-8?B?TUFNQ25pUWtOdmd6U1EvdnNPS0VFMk1rckVUVUF0ZEovcFFKQ2V4N2FaT05w?=
 =?utf-8?B?STREUGlGNFRqdGFQczZ4NVJzR0FQQTR1TlJNZUZGN1ZPRjJFZU1yYzIyZklN?=
 =?utf-8?B?VWdzUEhiTGJ5Z2hBZkd0YlBnQm5ocjM0eXBFSTJlR2hkSjRqZmlaeGJEd0g1?=
 =?utf-8?B?NHVuR0VmVkhmN0xHZFZkUG5ET0pvMGhxWWtFaU9lUFlCSTkxZVo0K3hUL1k4?=
 =?utf-8?B?enBHcDlYa0M2YjVrMlZPMnpQYm5pUS84UkRkZXJpVHl4KzZSRWd5QTJ3RVkz?=
 =?utf-8?B?b3VIcGJPS0hYVG90TUM1am5MM3E5Umo2ZVVqSjFlNko0M3lSYXBDZWJOM0R5?=
 =?utf-8?B?ekQrS0tMdmh6TGlYR1hWUyttcTBLc1c4NWRIY3FCdmJYTnpTY0ZxLzlHVGph?=
 =?utf-8?B?ajJDTjNDUTlVK0NiTFZ5dkVOeGJsQXFqODZuNXVwcSs0S3MxUDE3NjRXVFZ6?=
 =?utf-8?B?dDlUVFVZaDl6SGZzbnh6YmUyY21PMHNibk1PeTMvenpUb0VTREJpcGVhaHdJ?=
 =?utf-8?B?aVFteENUYzVITmJzVDlFT2duVmZtNDUxR1lFcnl2ZzNIU3R0OUZXL2pKM0pV?=
 =?utf-8?B?dW5ZRWtvNno4UFRYd1R6YXlITldndGNjOG1uSDBsS3pyNU14VmVjcmRmdmQ4?=
 =?utf-8?B?cUhSM3pzY09OdlFrc2EwQmhXS0RnQm5EcjQ2aE9JQmh2NXhqclkzMkJqSi9k?=
 =?utf-8?B?VmpadzBPcThCcXhVWUVYK2hzV0Z6ZkNodnBDQUNTY3NwNjgxbHUySUc2MnR6?=
 =?utf-8?B?SmRuMXlnOGh2WXpQU1ZPN2JtZHFib0MydU1WYWRmZENFRk1pREpXcmpmamZo?=
 =?utf-8?B?eGdpS1ZaQ1luOVd6VlVDc2ovVnliOURUUHVyVHBXN0FqWVRGcjBzVzFyUjVU?=
 =?utf-8?B?SEdtQVlQZDBjRjJVRFA1d1pzdnVRa2x1U3RsNXFqM0lIVWt4VXhRZHROSHBv?=
 =?utf-8?B?VkZCSWZCTWUyMXhvLzJVODVpUzI3aFJJWFExYVI3QWtROUsyVElWSFhHRzQ5?=
 =?utf-8?Q?g6F+JyL+KFlqaZb4UT63l3k=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ccecb2-56a7-4894-11c7-08ddc5c4cd25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:32:00.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OJ+fWcpF6C9YhW3RJVk6Ec3lp7LdrjatR1Xow8hNXsKT6TZrzuk9kRliZWKWg1/PTUs16AhKK1Knz4NNpxqCLyew6l6V1l9J1otwpnAAdDFRisX74l1MkX7IyRoT6/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8987


On 2025/7/18 13:47, Huang Shijie wrote:
> When detach_tasks() scans the src_cpu's task list, the task list
> may shrink during the scanning. For example, the task list
> may have four tasks at the beginning, it may becomes to two
> during the scanning in detach_tasks():
>      Task list at beginning : "ABCD"
>      Task list in scanning  : "CD"
>
>      (ABCD stands for differnt tasks.)
>
> In this scenario, the env->loop_max is still four, so
> detach_tasks() may scan twice for some tasks:
>      the scanning order maybe : "DCDC"
>
> In the Specjbb test, this issue can be catched many times.
> (Over 3,300,000 times in a 30-min Specjbb test)
sorry, I added an extra 0 here, it should be "330,000" times.
> The patch introduces "first_back" to record the first task which
> is put back to the task list. If we get a task which is equal to
> first_back, we break the loop, and avoid to scan twice for it.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v1 --> v2:
>      Add more comment from Valentin Schneider
>      v1: https://lore.kernel.org/all/20250707083636.38380-1-shijie@os.amperecomputing.com/
> ---
>   kernel/sched/fair.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7e2963efe800..7cc9d50e3e11 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9443,6 +9443,7 @@ static int detach_tasks(struct lb_env *env)
>   {
>   	struct list_head *tasks = &env->src_rq->cfs_tasks;
>   	unsigned long util, load;
> +	struct task_struct *first_back = NULL;
>   	struct task_struct *p;
>   	int detached = 0;
>   
> @@ -9481,6 +9482,12 @@ static int detach_tasks(struct lb_env *env)
>   		}
>   
>   		p = list_last_entry(tasks, struct task_struct, se.group_node);
> +		/*
> +		 * We're back to an already visited task that couldn't be
> +		 * detached, we've seen all there is to see.
> +		 */
> +		if (p == first_back)
> +			break;
>   
>   		if (!can_migrate_task(p, env))
>   			goto next;
> @@ -9562,6 +9569,8 @@ static int detach_tasks(struct lb_env *env)
>   			schedstat_inc(p->stats.nr_failed_migrations_hot);
>   
>   		list_move(&p->se.group_node, tasks);
> +		if (!first_back)
> +			first_back = p;
>   	}
>   
>   	/*

