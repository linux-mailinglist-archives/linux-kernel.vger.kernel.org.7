Return-Path: <linux-kernel+bounces-734559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD6B08327
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DDB1C40782
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0101E0083;
	Thu, 17 Jul 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="VgDc0HPT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2120.outbound.protection.outlook.com [40.107.93.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955A186A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721036; cv=fail; b=Koji6N5F6rucQ4zS6wb66xW3oFMHN/JPvV05qqc02pVHBPop8PaeRVnclgBlHIJTzurRxc9HZTiFvx0sgxOFpF6xneuM92XKhwLQMxLKSOhlI/xGauYUGhFhPiKNaf7ZlsLKkZ9TLYYl61QjsOQ8IRTmwG44KgYaF9YEQodUhBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721036; c=relaxed/simple;
	bh=js1xL1nMk4sve4vC39ilXB6PswROqcchtZ182vzyGsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqCEKE/ulUlfhFSzK/xyOoFfRGXHxM7deRNi7G0NIMSWxNEVEfr0IWcDxeM2HQ0iLSvHMjz+uHCBMuvLAv1CfCh2b963McwwVGIlCav9ZfeMV1IRYk7u88yqrJLlfl5B0WUb0nPqLaQz61UJh4bDXCGsmgsETV7iYnGH/O+2Hjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=VgDc0HPT reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL+NwNo3//LWgOfG47rdl2Y3gayNbENJmOORb/N1P8NhxsSp5d3+Fe6smEXhgR07XSlMg6me8mRUcewdMXkzP3BPE0Cbr/iO9T6DVqM9RweXIvO5fLHDR2hMPUFxw1uHnW6fKLJFUUVo5FuvAv9xHA5U8qpbkUX78WHlWWRPmGBRwL9vec/tuF4oo/GfUVeK2eiOrwYcc2vxq/3+k9cYqCSaIOHjpvh1qB+p058/IBQ2qqGYoYvSaANiehGey6ENNtr8VgvN032sjUXLq1tb84FeKQ/kXraDdIdWC2wGKFXD3TT9ifCSvaYof2kN/S5RBPAxdoYXL9ZzcOiTwcXVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iro2qLyvS6H1CO9EpmK6UbYP7XwmP4UaFqXHvdm6Tcc=;
 b=GRWMRtMVtEkydlc15oSEGvLb0ZUeaXfynGVHseyz4lpMlrQp74ujDR+ie4fXbQbaI2/Oy3QcYFhrAfEMzQL4/D/mr+1OdRiAc1X/XppA6NPp+PGA/UEB4x9Ed/3lGn3JrK+tzmFZIwC0O5IXAFV5Xd2BiDdYAKRCVOwW6aeuzNSayiI5o41tbXokCGOjkHZn7DtctB8dbuHkDUK0tAwldXXMzaoRNFXN/NJmIjtJAdHxbOj5pQlmjML1q0RiJ7sqxTtb8i6Mz82Hp28iuwPZ1OWyAetaAvOers7ZNMUw/YiIDgM3xWrxvI441myMfckismvdxwKQB4Aar194XINI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iro2qLyvS6H1CO9EpmK6UbYP7XwmP4UaFqXHvdm6Tcc=;
 b=VgDc0HPT32fPURT/mwQrXzvocDF8L4PyL9J9nJOHq8elUVOtOFi1n/BF9ZLrPEq8EH86nw/+t6UCgeOvtf7RJt3NywMLpEnUdMIFlLFxpgIFjkAIqJTXn+9GcCfl8mPW5v7lRHsHnyUVyY2cjl+eqfE9hFUgOrzCllrJo9GQbj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BN0PR01MB7005.prod.exchangelabs.com (2603:10b6:408:16e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 02:57:11 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%7]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 02:57:11 +0000
Message-ID: <ef64a101-c983-408e-b738-4fde57901479@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 10:56:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: do not scan twice in detach_tasks()
To: Valentin Schneider <vschneid@redhat.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250707083636.38380-1-shijie@os.amperecomputing.com>
 <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d4ed8553-6a57-4b56-bc6e-ecadd2d9d75e@amperemail.onmicrosoft.com>
 <xhsmhldoo18dn.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <xhsmhldoo18dn.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BN0PR01MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: f8968bc9-417c-48d2-7a9a-08ddc4dda05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJrdy9JdW5rR1IyZ3pSbkcrU0lsZzlObVRCb3o0d3h6TFAzSDJwRXVpRFhR?=
 =?utf-8?B?Ykh1VWtyRGtObWxFeXJkQVJxcHVHSHdtaHpBRFZyeXNEYXhUaVJ3T2l2ejlI?=
 =?utf-8?B?aHJPb2l1b2RKQXVyWGpRUzlvN2ViNWl6T2x4ak1oU25CS2J3VnJYbUtoSEFZ?=
 =?utf-8?B?Nm5iV25EYzhYby9LSmJIU2E3ODFUSGtVRjQwQ3BjbGRhNmM1bnpXM1VoQytq?=
 =?utf-8?B?eXI5TVVMSGNNeDAwMkJaQXVJaTBDdGpXY2FWcmdqU3VDbW9oUm1IeUN2L3Uy?=
 =?utf-8?B?UzNnV2l1NmNlSVkzcStmcVRhUEZOS2ZCbk9XRUZ2cXF1bmN6UUJxdVU3RUgw?=
 =?utf-8?B?SVZoUFdON2E2elRjN2ZFVWxEaERWRFVTSms2V0MrWSs1ZXNyVGZSUkFBc1Ix?=
 =?utf-8?B?M2tiTldmY1ljMGlqMWNmTE1uR2lIM29PZTBZaEJFNldQeFUzSkVtczZGczNC?=
 =?utf-8?B?UDU4dzZwd3dkSmVpT1M0cVRXV1ZoZklFVEVETDFOSER6WnpYdzc3WVpzbElj?=
 =?utf-8?B?UnVzMDU1NDJjZnQvendxL2FyRjh0TzBSOWJ5ekU0bC9jUHlmWG4zcU9NSWxZ?=
 =?utf-8?B?NUtXaXg5MFduMmVNLzMwZEFZZUFEVnNVR0JZaGNyR2Q5bVV3elFiZ1hCdWJH?=
 =?utf-8?B?dEJvZDFDNmozTjRqUHRQaEl6OXlSVllqUXFoa1cvWjU1MWl2R29IS1JRUjE5?=
 =?utf-8?B?QVhEZEIvVjRtTzlzT04yWTNHYk9mckM5d0lJWWp2MWI1dEZhTzV4cm5YWTUw?=
 =?utf-8?B?citLRzNmUEVmMUQ1NVptd1FNUWRCYm5YNW00MnJiQmJFUXlscmV5Sm1QenNy?=
 =?utf-8?B?N0ZsM1VVM3l0U2RPWjRWZm96c241V2U0NWh4S1doa01LSnZmd3JWMkZjeWRs?=
 =?utf-8?B?WEtPZFBjaUNheWw2ODhRTG1rdDY1a01zdGtYcHpWRURvbFFaTmdFYzJmclNi?=
 =?utf-8?B?clI3aTJQK1RSMk14THQ3ZkNlenFtdit3aldXT0g1aElBdi9yd3Q2UXB3K2Y2?=
 =?utf-8?B?dHRGN3NhK1VsL3NHMXExNkZRSmMyZXVNYjhpMGl5UGZqaHlqdHp5dU10VExv?=
 =?utf-8?B?dzRnZ3FiRjhmVnlGdTFWNHBDTFFTcHl5OVZlOURBeTJQNmpPVHdXNXdpQlVQ?=
 =?utf-8?B?aEtrMEh2TGovZGlsTXhlUTR3MVNUejJwa1NoMVdrMzZPWjIrWExMT0Z5UmYx?=
 =?utf-8?B?ZEdFajRZcDdtSEpEMEZ1eDJDQW5qVzFpRlpsblRtSEVrcGhWdDIzQlFQaWky?=
 =?utf-8?B?WWJiYUt5Z2V2NkhSK1NjN3dlS2tUTloyQ3g2bHQ5aWlqNU5KWXQ1R0RzdG0r?=
 =?utf-8?B?QzNiTjBSRkU5TGZocS9QMjQzZ3R5SGQwaSsvTTJBcERMS2lqd2RyamdrYTIx?=
 =?utf-8?B?RnZhRU9LNlJRczIwMGNoaGdXWWtmQnJWbTNuMFV0VTNYQmZpa1FtTlMxNlBL?=
 =?utf-8?B?QXREbFFCaFh6akl2VDhscGZMcnZYdHZhdFpYazh1ZHRtTmRPWWNVUi9NaHhF?=
 =?utf-8?B?dStONFZ5dVJFd0FkakUrTEtJUU5jcjlmSnM2WlFUeERTUnZHMktDK2dxK2I0?=
 =?utf-8?B?MVhLRlVZRzRuUFNYc2gvWDVYMVpoK2FiTUljRVR1VG1sc2RRRVhXUzc1SGxY?=
 =?utf-8?B?RWFxdkdzSmhEM3BQZWN2ekYveE1tYWMzYU9XbW1Qa1dVYVVpTExMTUpCQThK?=
 =?utf-8?B?MHlHV25zcFF5cmJ2eDBoR1JLeE1CUkozb3Vrc0prcnlDdjVJWnVjN01QanVn?=
 =?utf-8?B?SXBkNExqbFlUVFNROTN3bFBJRXJWVU5EbGhNc2lEZklTUzZvMGNUTCtwbUhz?=
 =?utf-8?B?WGZBVHhtOGRpUDU4OGhhbXlLMWtNSlgzSUVZR0tQeUlaWmVyUHZ2a3c1M05H?=
 =?utf-8?B?aEcya3I1SlgvbzR4NnZXSmU2V3dlOUozTUxFQnNUZGEza3A1dERlUU5QWWU5?=
 =?utf-8?Q?2EmCX9oTPlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3IrMFZSVDJPNVpiTFhQSDM0d1J5NTFGMmFqekJNZWhPTUVra0tHcHhHZVY5?=
 =?utf-8?B?RlJjK1ZQb05pOEZDWU1PTDdQTk1BTCtCTC8xeFNMeklDeTM3ZEJLTGdUM3Vq?=
 =?utf-8?B?ZUVuTGtHSW5iTWQzYm9yQzFqSmhTUkRsaVJnSXhUVVEwRnY1SjQwVkxEeWVX?=
 =?utf-8?B?WkRndkVva0RISnNmWmsvM2ZIMnhuMjBjRkdMZkxUN2RNMDN4WW5lQTF0b2Fp?=
 =?utf-8?B?WlUwZHVaTXY1T1hoVXdiNWtIdjRKMUVhMGl5UFZCOVJUMXdGL0s3Ums2UmNi?=
 =?utf-8?B?bC9BSTc0a3hreHBmSnNWVUppSWJiRjBOeE14Sk5BeXFyblFvMjRhVXM5T0VP?=
 =?utf-8?B?UlRqQmVMWnNjTFNuZy9iaEduSVdFak5ydWxRaGs1OFQ3OTRidGNSYWQ4b3F6?=
 =?utf-8?B?TlRibXdJMTBoZmVuRmJFcWljc1hpcTJwcmp5dnVKcWZuUlpTYnRZSDNuNG16?=
 =?utf-8?B?M01oWHluS2wyWGgrODcraHVac1Y0Smh0VmdIcGYyWnVJQ3Y4eHltdXVlK2Zt?=
 =?utf-8?B?MFhvYUNMZUJjWndUTGZxKzRwTFpEU0NXRmRvQ3FTNWNaS05MM0J2SVhKS0Rx?=
 =?utf-8?B?TXM2L2twd2pQNGFGc1RoV3p0RjFZNFFwOTJFc3dTbTlBQTZGb2krbURvWkRz?=
 =?utf-8?B?eEY1L21GbUdsT2UwSDZiZDcvUzhNMlcwMk1Na2FvOS9JcmtiTmZESnpHOUl6?=
 =?utf-8?B?ZHplOHoyNzJJWXJ0VzZsTmo5WFFvbFRrUEptd3hUMVFuREVQVHhONzV5a1di?=
 =?utf-8?B?bDNjMDBQcms0blJqYzVDbVQwK0xUblpNbml5dWZyeThjRnkxNEpCbWNDYnFw?=
 =?utf-8?B?S0kyUDhpNktocDhhSGlabXVZR0pnSzFmQVhqeGRtY2RnT3FXUmxGZXM5bFFv?=
 =?utf-8?B?bndNNXU4em4rQU1XU1V6L3RpWWlHNzJTa2IrQnErSEMzVG11OWFpNlA5UUN6?=
 =?utf-8?B?YS85YldXNDZXdnVRQnpEQzR1Z2F3T0ZxVkQ4dUZyQWJIL1ltVk1FQ01NZGZC?=
 =?utf-8?B?WDJVODEzZ01jVzJjU09LYWJQNXJGRzRWdStnKzJVQURidDE4WFpIVjFTdGNk?=
 =?utf-8?B?WDRpY2R0bXI0VHFMNlhWcDNEOWFlTU5hYi9YOG1IR0tGem1hTllRTkd2ZTBz?=
 =?utf-8?B?V0MzM0R2RC94M2sxQTFjVlZ0R2JyeHMwa1pBTmJGK0d6QmZHeXdSbncrSVBu?=
 =?utf-8?B?M0JoMENkYWpQdEFkUklwNS9DaGkzei9Cbmk3KzExdGJyOXBzbWtyeFBVQUdj?=
 =?utf-8?B?YzM5Q1N6MWJWRlpKUlU3UnJqbmhydjgxdjIwYWNMeC80Y3hWRzJ2Vk83T0Jy?=
 =?utf-8?B?OUFZdlA0UlpRV2c4WE9kMWY3RGFLTXZaeUFObVNPRXZJdVlYMUMzZzM1dk05?=
 =?utf-8?B?dVBHVFMySFRlOG5nRHlIK1MwL3UyTGFYY29CR1RJa1ZrQlNNQ2YyTVlXQmpW?=
 =?utf-8?B?RU95bUR3WkZacVpTbXlVWmpDQ1QwNUEzdjRQS05na2t1K3k0RlJyQWltTEFa?=
 =?utf-8?B?b1RpaGk2Nis0cnJxbFdUMUtLTFhzT214cGt2ZkVBK1ZOeENRTzNmcDRZSTZX?=
 =?utf-8?B?eDRxcmh2Z245MVlzWVRqaWVybzN0U3U1Qk0vd2x1YUtrcDVpbGtkcDVramdi?=
 =?utf-8?B?RW9iU3p5NWhpbm9WQmJIVFJrRi9rQVQyUFNxbEZXTDkxNDltRFlFMGQ1eENW?=
 =?utf-8?B?U3RUalJTblJLdXBJdHZvVmFZdThmZEwzNzVLOUZLSTU3dUNtblpGRSs4ME9n?=
 =?utf-8?B?MmhhT2k1OGxtcGFHdWR2UW91QTZEazlJK2xOUHRHUmtRQmQzenBqYlB6SnZ4?=
 =?utf-8?B?ZW51ZlZPK2hYZ1FNc3ZTeWo0Mi9WcWl2RWpEZDNubTc1SExmNGZZNWJiditi?=
 =?utf-8?B?UWtFOFlpMlUza05YZ3J2WFM4bVIrakJKd3RaU081c3FCb21HQ1QrL09pU3ha?=
 =?utf-8?B?ajJuNXRIRmxyOE1xTFR2VG01dnRYMnBZS3AySVROODRVdWxCbHdlMXR5anRH?=
 =?utf-8?B?MTN1TmNuejFxeW1WanRqYSt4T1YyU0NBMktuUzBHRFN5OGdsU0xiREdSZHJ3?=
 =?utf-8?B?LzdWM3FudDdLRVVnQTY4OGV2djJZMVBTUmRlZTJLdllvOE1FQXoybThlSlpZ?=
 =?utf-8?B?Z3NOeUl1WWVtMkR3dXFnTm95aFdtU3NyRjcycElOcXdqWGhsMmlONGZ3L0FC?=
 =?utf-8?Q?TzH4JdWvSdD/EXD3ddTRVnI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8968bc9-417c-48d2-7a9a-08ddc4dda05e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 02:57:11.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RYhPtLvEQ7ig7BjjYLTMnb/cvxSTc8aHsU72XdFDY9ZH4l3X/nGMcNvccCEwTABmd6RwALl5GMsyIxVEoyPoWtXvC4kp4uSBhbkbwFHitoDNiDQLfHhUO0bDDrOlaDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7005


On 2025/7/16 23:08, Valentin Schneider wrote:
> On 16/07/25 10:13, Shijie Huang wrote:
>> On 2025/7/16 1:04, Valentin Schneider wrote:
>>> On 07/07/25 16:36, Huang Shijie wrote:
>>>> When detach_tasks() scans the src_cpu's task list, the task list
>>>> may shrink during the scanning. For example, the task list
>>>> may have four tasks at the beginning, it may becomes to two
>>>> during the scanning in detach_tasks():
>>>>       Task list at beginning : "ABCD"
>>>>       Task list in scanning  : "CD"
>>>>
>>>>       (ABCD stands for differnt tasks.)
>>>>
>>>> In this scenario, the env->loop_max is still four, so
>>>> detach_tasks() may scan twice for some tasks:
>>>>       the scanning order maybe : "DCDC"
>>>>
>>> Huh, a quick hacky test suggests this isn't /too/ hard to trigger; I get
>>> about one occurrence every two default hackbench run (~200ms) on my dummy
>>> QEMU setup.
>>>
>>> Have you seen this happen on your workloads or did you find this while
>>> staring at the code?
>> I found this issue in my Specjbb2015 test.  It is very easy to trigger.
>>
> That would be good to include in the changelog.
okay.
>> I noticed many times in the test.
>>
>> I even found that:
>>
>>           At the beginning: env->loop_max is 12.
>>
>>          When the detach_tasks() scans: the real task list shrink to 5.
>>
> That's set using rq->nr_running which includes more than just the CFS
> tasks, and looking at the git history it looks like it's almost always been
> the case.
>
> Looks like env->loop_max really is only used for detach_tasks(), so perhaps
> a "better" fix would be something like the below, so that we can't iterate
> more than length(env->src_rq->cfs_tasks). That is, assuming
>
>    rq->cfs.h_nr_queued == length(rq->cfs_tasks)
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b9b4bbbf0af6f..32ae24aa377ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11687,7 +11687,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   		 * still unbalanced. ld_moved simply stays zero, so it is
>   		 * correctly treated as an imbalance.
>   		 */
> -		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> +		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_queued);

I tested this patch, it did not work. I still can catch lots of 
occurrences of this issue in Specjbb test.


IMHO, the root cause of this issue is env.loop_max is set out of the 
rq's lock.

Even we set env.loop_max to busiest->cfs.h_nr_queued, the real tasks 
length still can shrink in

other places.


Btw, the real tasks's length can also bigger then env.loop_max.

  For example, we set env.loop_max with 5, when detach_tasks() runs, the 
real tasks' length can be changed to 7.


Thanks

Huang Shijie

>   
>   more_balance:
>   		rq_lock_irqsave(busiest, &rf);
>

