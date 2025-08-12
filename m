Return-Path: <linux-kernel+bounces-763899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2512B21B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75683462A45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E82E2DC4;
	Tue, 12 Aug 2025 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="xaDPW/hq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504222882C9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967973; cv=fail; b=KXDerzAox8mn9Csb8ByAEvTjF9hdCIkumqKtYw1h9mBmOGJHIJA2Of2bOYx+M46hY1W2Ez+8h9db+QcScs3CQMFBbW/ifq/RfQrqy1Q8uCKGWnsOUI7EHh+ToU5Cir7UWIUttM7+sFMkGluZI+Dy7lehE+NdMdWAywngD2zFysw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967973; c=relaxed/simple;
	bh=4dcntWEkdNyzAHERUDXaZrv/jkvO/AYlmt7oWRE6p2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mcrQ6/LLuBMIJiq1kzNGwF4EgF4qlqBMq69x6J+OoWGsSYncvRJ1B6kJPwl9bZib+ySpa8LMmMgQFoZapERQ9YAISRgJuWlbyYbSXs69/BgnrB1SBccuiiY6h5WhsBocecW54f867jz6vGOySLVWjV/wL/p5NRI+GBHq8wAyLW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=xaDPW/hq reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOUMEJ3gxUf2k7BDh3/p566VmGyeipRaUH5IetrPSC7E2ZZ04un3iA2SVq7r48WDTpFMOfM+mNMdKQWZhP93TIyiv6O8POZPafLi3pOlxWu1cKfsppYNV2uAxNRzDGUPrUAHAG6wQVzzGqlIewyAvooiwFrp4Wau8z93qhw02+zggfX6mBG+Tyv2U9VfWXXiYNnAb9WnPA9WUWjoTO3gatIFtgiAlqEObJA+VnuMrrbEmcAX07YUZgYxiq0t6CfHoBLN//H0B15+65BMGzSsDsqpkwnFdq7ziv2DpoUB06/UdCNTU/4vcwv6E3ZD89rBBNjkVq+QGhMJih5kNUQ1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q5+PPEUElpq5Wp2h+8692l4iYTLKOGkgMDPsLzNy6Y=;
 b=PL+qUSe10B9vXMBA04crkxCzWSwg5/QwzNBwrCVyuRZmoDTTE3Hd3Lg2X2Nj9WEIptXfgkzR6nSr221ew+wZfB/VeXhTLpb4Qk9P6fDDv/LpzXSTkA5Ec8jFlWvouy6JUOM87jZpY+ZuIXRqMk14euGx1nurQgWLSM36wJicB9wRB1Xoy0FTvvkidAgXm0lyFYqqB6QbjZdzFH24bfV/GEXYmEStvNhTdpTMZXSmdetpvegLM//Tah58XQv8PlGE9SGfWKw1UFMlvWUz4+iBU4VaHI7o+mK2lK8aYQQK+HyVi0o6z83ceqOuSkAAa0DookPdnsKh7cfux7OESeAKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q5+PPEUElpq5Wp2h+8692l4iYTLKOGkgMDPsLzNy6Y=;
 b=xaDPW/hq+Jl9kLWQg0eD0R5q3mGXPdPbpM58SLH//p+NWTzflfXdmpXht5GIuxD0oYvx5McCNIrXZdQ8SRZA1wX7IWhT8zp3aa5yA2ZZQgV54XXd42LtxbmLKjVVwxU+gIJmTJkYIwEZHZkprU46BI1+i5NOfODePugk07sNCng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SN7PR01MB8043.prod.exchangelabs.com (2603:10b6:806:349::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 03:06:08 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 03:06:08 +0000
Message-ID: <415e4351-10b3-4134-ad11-8dd1cda037f1@amperemail.onmicrosoft.com>
Date: Tue, 12 Aug 2025 11:05:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
To: Jeremy Linton <jeremy.linton@arm.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org,
 bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de,
 nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Lameter <cl@gentwo.org>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:990:58::16) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SN7PR01MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e993cf-3070-4a2a-972f-08ddd94d2f1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0hINEZGeC9QYW9NL0kwK3F3c0hscW9ld1A3M050SGkvMkIwZ2o0R0c5cFNH?=
 =?utf-8?B?WjJkbis2SnNGb3FIaUZuYTlxMmpCdFJRTWYwWWd1cnhPMzZCMFU2dmdYbmNo?=
 =?utf-8?B?V2NHUmM0UGNWUC9FVlNXWHhOQTdJSkRhci9lQlh3TkEySXp3M2F2UldCcmp1?=
 =?utf-8?B?d0k1WE56ejJ3c0dHcC9aZmZCbFNiSU13MFEyaVE5TFhkajhJTGhoQjEzWURU?=
 =?utf-8?B?bnNGeGpGYUdOWVFrRWRRTFVoSExZbWtYNmhUWWhRczFid2ZmK1N2b2ZmTXZE?=
 =?utf-8?B?cVlXMTV1RTF5MTVTZEdGU0NTZHBCbUJHWDBMRDdwb2NHNUV0SXIvczErajQw?=
 =?utf-8?B?UFVna0NNcDVzVnZIcE1ZUXZSOWRYUFhwQVNTa202MTlmNGxzd0p0RVZUbnFi?=
 =?utf-8?B?Q0tTYWxYU3FRUEF6dE55VkJQWjk4QXl2Q3FkazJXVE1id0FHQWtENFJpTjhy?=
 =?utf-8?B?MEtNdWFpb2JIRmN1cXh1ZkJjejV1NzNvZyt2UGpTNXlka1RwZnVWY1VnOXB6?=
 =?utf-8?B?elY3b1p4V3Q0MnRsWFhjNEVEK2s5NVNlS09SVElkb3FZd3dWUm9JOVlQaE1j?=
 =?utf-8?B?VjZVMVkyL0haaW8wRU5MYW5uQnpVNTVwMjhkVWVhVTBIcHFKamxoM01jMzhT?=
 =?utf-8?B?NDZVbDhlS0lIcElBMkN2Y1hkUzg4dDVlRlZ4UXNaNTVNUUJLL1NhTG15Nnh6?=
 =?utf-8?B?cjgzbGJ0SFFFbFZKd3VPZTMyMzV1OTAxNGZjUXBqZ0VMM0taYVFPWnpuWm9V?=
 =?utf-8?B?VDFza0dWRitRVjVqK216VlMxWFNoSnBWeUFscVUxSzVOcFgxQXBPUzQxSitF?=
 =?utf-8?B?M25qaTdSUFR1cFJxZkY5RnVkelpKT0FKeFd1RGRCbzUxNGZQeXFIQUFleUht?=
 =?utf-8?B?ZFNTMFEyY2syWGVMSjRqVTQrRG1vWGYvNFhTQ282R0xDRVB5SVl3QUxKU2FU?=
 =?utf-8?B?ZnNsbnBZL3BTZlVBZGtDdUFCYWFtdkRkdE50RHZFbmVrcU00SklBMXk0VnMv?=
 =?utf-8?B?bUlnS01jMDFFSC9PcXVabkRCT3prcUhUMGVwdW9xcjhKZERjR2k4OUpia28r?=
 =?utf-8?B?cFdTSDJhaUtjL08xR3I4cHMyOS93N3g2Y0x1KzVYWTM4eHRuU0tGYXd0R0t0?=
 =?utf-8?B?dkJTajVGdkhEQnptRVRDZytzbnhHV3VTcmdTTGhRcWNVQXIzbGlJOVUzWmpr?=
 =?utf-8?B?SG5oRGxFWEN2VDVLZVIzbDdZSDQzcFZYTEpMR2svUU9CQkU4OGNndTRxMEp4?=
 =?utf-8?B?dTF1TzJzajE5UU9NSTdmTmpYMTFXa3hUdzJ1U01YQXBkWnNER1VVQ0dQN2hX?=
 =?utf-8?B?RUY2L2xWeXpkc3Zmc0wweHJDUUZISjlBcG9PWE9helNCVUR1akptWWhwb2ZM?=
 =?utf-8?B?SXgzeWQ4TU1sdEtEYmowdGlIYVVKNWFTMHk2cG5aUGV2R0w3NnNXS29qSnNt?=
 =?utf-8?B?OVJoM0RCWGhSWWk4VHAwdHFrSFc1bWU0ZUtRYUx0dTV4Z0l0bUxqNG1rSmpi?=
 =?utf-8?B?c0FLUnVmQWNobTFvUWZtZDlnM2FZWFpreHZmN01vYjFVZ0hSR2xLT2Q5eUdL?=
 =?utf-8?B?S2plWWorYVRMUVNhMGN3RjFSWXZaYlpzSndEQnpKZVhlSGY1OW9TVWtia0t3?=
 =?utf-8?B?ODc2MWgzZlQrWTFPaWhkaEhUMFV1OXJhSVYzYUkxRDY3eTcwN00zK2dHN0hI?=
 =?utf-8?B?WjNJS3NCNjhQamp5SjBGejZHczJNS1B0SUNPbGFSN2VLZHZYTmhDUFBZcGxF?=
 =?utf-8?B?dExVTXY5MS90TDUvMEloaHhGTnZDOHBNN1ZCOXQvZEZrYTQ5SGZFY3FlZFB5?=
 =?utf-8?B?NDBpTVpvMTBmSmpZUk1tbWJZTTg2cjVKWTJYUFE4TjdNSTJmTjhscmpSZ0d6?=
 =?utf-8?B?QW1wK0Y4L2NVVTlNS2VUeVhLNWFWNUd1cVk2VFdDM2dxQjRBUjlJV3FUVnpO?=
 =?utf-8?Q?CljY6SnkZTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SldVS2RNU1UrQkh3TzJPNCs4RkZJOE9ROEZic2tFSEFBa2pHVFFPeFV6aVU1?=
 =?utf-8?B?U2ZQVlorYmszVWhMOFlVYThBbFg3L2Q0OVE5dndiVTE0VFVZTW5odlhsS3pT?=
 =?utf-8?B?NXhKZkdmVUkxUG5KakRsTHJQR3V6amRFMWwrV1h4bTMyd1JFYmw1cWJXczhs?=
 =?utf-8?B?VDd5MExuTGQrYXBJZStYVm1VREdYSGtWT3RZQjdoV2gvc0J6SEwrM3B2aDZo?=
 =?utf-8?B?MUxlc3hLK2UzQW12eVBYcThPbVQrK04rdWtuKy8xN1lLdDdCN0RqVDlhS3Ev?=
 =?utf-8?B?dGgzaGRPVjdqWXNzRGorYVVuUXFrcXUybUlNaENmTUFzSWdtMlQ5YUcrUUZ1?=
 =?utf-8?B?RUphN3lWWHc4NmJ2ZDlaU3duTjA0NWx0aUNrNzBxdGhPS0cxUFAxUUtxWWRN?=
 =?utf-8?B?dXVIS0kwQnBMdU1QdzRIcXFmM3UyK0FFQnp6L204S2Z6SUJhQ3pQaDV1dGU4?=
 =?utf-8?B?VVl2Z1pQdG1kT0k2L09KZ1h1cWEvZGllUVk1cmJTTldTeGprbitFMndxMGZj?=
 =?utf-8?B?RUIzZ3c0U1V3UDlHYU1KMCtZbzNJSGtLbUl6K25QRUFxUHNialVsWHpueUsy?=
 =?utf-8?B?bldEb3ZEQ0ZwY2JGWFRCVXZ5OFhMYloyelF1WGw1MW1xMVhGVlBPYWxsdmlL?=
 =?utf-8?B?OUtsdUg5cFdxRmM4NEwvT05JVFB4K0l2NG1BWGdnVDVzQnZIazNWS0k5MHBN?=
 =?utf-8?B?cng5TnkrNnBpK3BpM3ZsWFFmT21tR2F1T29FalZ3Nlh4ZlNRM3dQQkw1QXFu?=
 =?utf-8?B?RzlNNFgzbEdDaFc5WlY4RzdMb2JRMStHbzVMeFhuclZxM3VrQzlwODhybnRD?=
 =?utf-8?B?OEpsOFhxcU5HQ1BWczlBWWFyNzNtTmRWcmlCQ3Y3MTdjVUJ2YXd1YXFpMlIx?=
 =?utf-8?B?RGVhU0l5ZVpnRzJrMUZILzJuUWtsY0V0U29TWDhhdDNaTy8wbVhtRDZ0SjMy?=
 =?utf-8?B?QmlPalZSWWRjL3NPeDlyTGVkZlNjeTVHdVhZYVpnMTQrSUFLd1QyQUZqK3dZ?=
 =?utf-8?B?Q1ZTUkRSTXlGUnV0dkxJMWJLNytWK3RwU2lYWFBwUjdvRk50bWI2c0U1aHVp?=
 =?utf-8?B?U01RUU5uS0I5Wm1SWFpoZ3AwZUI3ZTNNT3V6WXdiKy9XVEIxeThrdGFyYTZG?=
 =?utf-8?B?a0ZjVDcxbUlZM3J3Vy9hQVdUOFFQMVREQ3VRM1dFeFpQRzBTZk01Zk5QeVB6?=
 =?utf-8?B?OFJrbUdRNSs4WWtKb3BoOUlUNnMrUldPWGxra0NjZEI4MmkxYjh4VnFvSHB1?=
 =?utf-8?B?enoyUStnM2NtdmpyT3VHOXNkWXdkZ0NNVHNuRUpGbmFjOWkvQTMxOEZIZWUw?=
 =?utf-8?B?enExV2Y5RWpNa0VYT3NFNlpKOEF4bmtRcFVrT3g3OWp4eEpLM3FIQ2pyYU9z?=
 =?utf-8?B?VFBGdEJiQ1U3OUVvMTZkWFVyNis4Y2NYSzJhWmdaTXJZRzhOejJQM1A2R0t3?=
 =?utf-8?B?eUNFa1c2K2NxalV4OU91WHFHczNOcEowVUl4a3pKRHY4MFVKR2NXSzY3anpn?=
 =?utf-8?B?OTNZMFFVR0srbHRIRnVwd1MxY0VabGo5WkxlQkdidUMzRHVjN3J4Y2hYNGk5?=
 =?utf-8?B?czV1dmcyS3F3S0RKVjVpdndIZERiTjg2elpuUXorTzVyUndQVmdwUHJBOGtE?=
 =?utf-8?B?SlczUzliQ3czcDVTQVhPWVNnOThNYW1pVEFRbzBhcmJnN0FPRkVQVENTeDU5?=
 =?utf-8?B?akFzcHh5N3o5ZVRsMnRDWHBqVFVqdktHSzNVblR6RTJKTkprY1FpQlNoRUQ3?=
 =?utf-8?B?Tmgwa2xCbnltQkxVZTE1RHoxVXRjcllLTFA3NFhXM21IbDExWk9WbXhBU21l?=
 =?utf-8?B?YkJDUDFZUWVyLzhXeWxGR3J5SDJpMGtOS0xwM0d6MFRhNTFUdGZEenhiakpy?=
 =?utf-8?B?NEdIdVJvMVVZL01WekxTUTVwTWdvWVFIZVlzRTVUMTgzamVvUmZkY1hBNTdP?=
 =?utf-8?B?Q1B2Zm9lT2xIY1RMR1h5S3hpeWlvK0lEUHk2RkF3dFZBQnQ2TE9IRTQyeUlm?=
 =?utf-8?B?aFlCN3Y4Wm9HY3BrNlJOdWdCeXBJYzRheXozUE5lS2xuV05CVmt1THJKL2Zm?=
 =?utf-8?B?UHFZa3BJdE1MRkhtNW85VzJoeFJLN2Y3SjYrQTNmQitiN3VLdmRnV1l3VEhw?=
 =?utf-8?B?eTl3ZzBiUng3ZWhCUzgvblJHeVVBZDF4dHdUczZRdDhVUnh4ZkFhMlgzV0g2?=
 =?utf-8?Q?q01+sEsRWeutHn0dSkT/nf4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e993cf-3070-4a2a-972f-08ddd94d2f1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:06:08.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7l1UUH92EhppO12stzreN0Dj6VJptZ6eg1TqB5zC8vMFULQ1euxSLHSBbQsaHY7+e1EmBAZB//3O8DAXAVTCmcopSMrOKVHESUctU2MNqrrr54HiY+U2+FI3jFU8qLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8043


On 11/08/2025 23:13, Jeremy Linton wrote:
> Hi,
>
> On 8/7/25 9:55 PM, Huang Shijie wrote:
>> In the server, if some workload which will create lot of
>> tasks, and will have many task migrations, we can get better
>> performance when we enable the CONFIG_SCHED_CLUSTER.
>>
>> For example, the Specjbb may have better performance:
>>      Critical-jops : 26%
>>      Max-jops      : 7%
>>
>> So enable it by default.
>
> From what I've seen, SCHED_CLUSTER seems to be a bit of give and take 
> depending on benchmark and machine. I'm not sure if it should be 
> default enabled or not, but it would really be nice to have at least a 
> larger sweep of benchmarks/machines in order to be sure of the decision.

Yes, I agree.

Maybe I should create a patch only enable SCHED_CLUSTER for Ampere's 
machine.


Thanks


>
>

