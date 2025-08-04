Return-Path: <linux-kernel+bounces-755687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C8B1AA64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69AD18A1685
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BF23BD05;
	Mon,  4 Aug 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R8L7oIXX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABF1F416B;
	Mon,  4 Aug 2025 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343253; cv=fail; b=AmNkV7UBda3CsouzUEIqOTHG6UMwhu1K4tqh3MgLVIpQ0lvu+PYI/k2LTZQPaDbIpaKDQSB2eF6idqCd+VVuLWr2LePkQJtmqBz4Q9IqQ0+a6zJHEguz+ill8XkXe+9jd1ZCXQC4WopgrcU9i1lmEdLm2n7JwrbEFeJaRXis+Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343253; c=relaxed/simple;
	bh=xasz3HusYlitNAQOqH8HYTrcpOnED8wYzOimbVq38Zs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/fjXAJK49ViltZK2un3laiNmEGpMNOZXoSfZc6+yPJMi8qYaQfZK2ThLzaKZ2PT50CmGp6lGJZkBkaguWKJCiQb9C8bm3oSIaqsFEIunLQdeP7E8yJmaJ/9Npmny7JzwFbPP4Eo1fyZ4dAJtzTK+F/xa5+wa8AX33jTBWUjFB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R8L7oIXX; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1uX909ylBwybXgpKdmXZWWUixRpAhz+WJ9jawVWc830W2w/vZBAuf7XZzMQuMs1hIs8c0BM4puQM+aZsvRq1cHFRARCFly/69XsR9voMSpi1wxPsjLh4XdRmblrJz5nm97COMQALOoxTzzp2qadxEtMeIRqOyZf6EeigjoSzjT04m+jyKGGftdw70kydAGsQ2kZxNunP+VGauFGqzxyY5hI8+lS/Fv3gN7/cSNxSG8ugOXWAExS+Rnz2N6QRQKcvNnUdHEJVoeiwc7TQDJubKSV/gFk1ZR4UXjcOSrhU3Pw672wp4+0VHNptlTaoQNQJz3XuobXCEyF4XTZNt3rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8FsIA4W53e95Gqea1Jt7urfW6hpVRpHo8iLiZNLWtE=;
 b=ZSafjsdY81F+GSLv/8jgre+b16T5gpv9fsu6lJ4owlNAL/hSnzBFm97pkR4zLCXZ2sFEVTPYJvKuOmC3K54SSsQEGD6BUfuFvH/r6MtCcI2FO5m7TVwHy3Cn3IQVclU0gDTPgQ00EUTDISSFiygJqniw1ue2w56LUrZysjyffh18cWK1YXqXdnIOPRzkyFyor9CfNY6HPjhwqPL9vWf5iX4DGTEmFCDGxAREquh/bZDtcLhmpbU8Drs9QgGOHRUKixf1pUl0S5sdSLEutWdo586ETjEh8M9kaMgXgXAFoHmp4WTruur4QzrlOuMwmHTIgDUwwtfObB1BZNakbTkPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8FsIA4W53e95Gqea1Jt7urfW6hpVRpHo8iLiZNLWtE=;
 b=R8L7oIXXvBNoxbFfgxwEIs1pnRevoQmbCnwRyPYOuf35yOFOmxpJNE7RBUanajjSmZHOyJX3NXGzo2nFHNH8m6DVCsvLBu6714KTEtpintlBxHK/Nb6k3DgUfkpP1kvc1c9C2Dk03CDDa+ZMJKHvPT0wDMK4EbU/2t7rvC0DHTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by BL3PR12MB6644.namprd12.prod.outlook.com
 (2603:10b6:208:3b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 21:34:08 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 21:34:07 +0000
Message-ID: <67f1cc75-f678-4112-bd2d-f4f3abcdd845@amd.com>
Date: Mon, 4 Aug 2025 16:34:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 00/10] x86,fs/resctrl: Support L3 Smart Data Cache
 Injection Allocation Enforcement (SDCIAE)
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <e6866fad-1d8f-4fca-baf7-6685e57370b0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e6866fad-1d8f-4fca-baf7-6685e57370b0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::25) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 326000b3-c534-49e7-cbea-08ddd39ea49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05LM3ZsdDRDb3FGVWtYb1ZxVHZCcTdnYytzVDhqY1hPcFJjd2QydXRBZkQy?=
 =?utf-8?B?MjNHaDZtWk5pakxFYnA5ZVFzdjV0cVhHOVkzanY0ajlmblZoTm9oaWJBSjlX?=
 =?utf-8?B?MG9QbDN0M1R5VFZTV3lUWUw2cENQTytuSmdjWEZCYjhyV3hVYTY4ZnkwVlM4?=
 =?utf-8?B?eE9TQUZvbzZYVjFpSExRem5UZHJqZlpaeDdidGFoZFMvWUhnTndkb0JmUHEx?=
 =?utf-8?B?UkVLTXowTEFpM1hld1cwdVJTckQ2cVRVS25abzBSeHFXWDJSdms2Z3diUkR4?=
 =?utf-8?B?ckF0cVlhOElvYUVIbmVscmVGNHBHaklPN24rSkgwS0lkMDQzSFVIQVZ1S1c4?=
 =?utf-8?B?dkRBRnV2WTAzNmpMd0VZSEVnaXFYK0NpNHk4ODRHYzV6ZWdaWlNyUzFmbm1C?=
 =?utf-8?B?WTZuL2JmVUM2NjNJMjVtSUlqTHd1QW5UR25RcythMmQ1K05zbjl5ZVdrSFVL?=
 =?utf-8?B?VnBaOUZGdEduSys0ZkZZNXlncDE3QTY5NVVydjB4dFhsSmI4dHMrSEZyeEFR?=
 =?utf-8?B?NzFlakptNnFoRnFmQkc2aVJNY2VSSnJid29TM1BnUERVZ3ExTjFVd29aNFc3?=
 =?utf-8?B?b25pdUp2REJhc2Q2YmIwL3FNWk9PWEVqa0l0L3hTVGtlSUMwbi9STU1CdnVS?=
 =?utf-8?B?bXhYMzhaUEMxSDAyc2RpUTVLNXBYYjJqOHhLajFrRjdKRmlVeCs5QzRlWGd5?=
 =?utf-8?B?eGwxN1AvYzZha1JhVHl1NncrM0JLbldSc1BRNlprVzlGbGIydFNabUIwRHRD?=
 =?utf-8?B?MmlkdGJlSzRJWlZERE9iTG44NThhcDZYK1ROZHhZazFRV05xQlIvTmNOQ0I0?=
 =?utf-8?B?b2k2eXdxZnZKdE93ZDRzVGxiL1NSWHBabjRIbXBvZVIvbEo3ZUJiNlVIYnJQ?=
 =?utf-8?B?L1hYYTVUYWp2MlYxKzlmb0JWVTFsQ2ZFVEYwN1QxcWRuMnZ5a1FZaUFiYUZm?=
 =?utf-8?B?b1p4STNuczY0NDRrMmxZZlJCZnN4VW1VcUw4OC9lbUYyWjZXa1hDUmFOeVBM?=
 =?utf-8?B?MXN6ak13Sjd4bW04WmlFSG1ZYWhXTE5sMk90ZDd6OGdUdEZDekRMOFJRcHVT?=
 =?utf-8?B?U204N3p5dFh3UXFmMEUwbC9pdDB4Q0JGeUN4aEl3c0ZZd3g5endGRmdNejVl?=
 =?utf-8?B?cTVFV0FyVlZQZGVLNEVkVFVQd2NMUzMyYXVQaFNtZkh5NFJlTUE0UFIvWlRn?=
 =?utf-8?B?akI5amdIc24wd3pXTTZuSGJGUXFaNnlsdDczYTdoc3BEZzIvSzNIK2VJNFhJ?=
 =?utf-8?B?KzQyUlhjQVprWDcyaHloOTVXQlBMUkthSUFYY0RBQlZaMlZpZ1pkZjV4bEpj?=
 =?utf-8?B?eC9hVW0xcUgxK1BnbUZlYWVseDloNVNvTW8xQ1VXbFhXSHN1YUxaNE9XWnRJ?=
 =?utf-8?B?QUx0Y3F2TGdBSkxMUkRCczVlOUJ5c05yN0diSEtDSnhNWUxzYzhsNllkdDhR?=
 =?utf-8?B?eFJDV1VKa0tSbHYrT1UrUjd5Zkw5ZXFWRmJzMlYxL3pHektHNjErcnpvMHBJ?=
 =?utf-8?B?Z0hVZjBXcHhUWnBsUXR5dlgycEx6TGplOXpOUFpGWk5adXpTY3FtQndFM0lD?=
 =?utf-8?B?bWVLRjZUMkNSTG9YMEViZVFVQnBmeDVGZVJadGdOalFLSCtLYndNUklWUkJO?=
 =?utf-8?B?NTFCUjQzN1FwbzFEUkFJbGM0OHRFdUd6bUlxb2I0NUNUQlpmL1NvRmZmcUdr?=
 =?utf-8?B?QUtTVG1qU1JsRElHN0ZFSStjcEFYTENzNmNsYnBFdmlocEhHZUl6QldCcjkv?=
 =?utf-8?B?Sk9pWG4wVHp0V2xvQWt3TlBLcFdMN24rSy8rKzlHRWxBV1FXeWZpZUUzRlly?=
 =?utf-8?B?OEtVQUVYNkVuM0tmRCtFL3FxRm83V0FsTEF1TCtFTy9MUWIyVG4xRGduL041?=
 =?utf-8?B?ajBPdmIwTkdVT2JFWElHMVkwU3VMZFkwWDF3NUpYT05RR1VqQWRvYVV4MzRX?=
 =?utf-8?Q?GLarE7pfJR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXM0S2pKNDMzaGpnUnp1WnJEOTVIWEFhbWJwb1BuZG1CWUNNZ1AwZzRDdGc4?=
 =?utf-8?B?eUpEYlB3cjVrWlBPd3BGaVZNK3dPVU9sb2JoWTVYTUJCaWY3SmJiRElXbjB2?=
 =?utf-8?B?NGhOTTRhRWhrelFzTWZhcmljaWoyRXkvV1ZkUUowNGVyOTN1TU1YSHNEMDhD?=
 =?utf-8?B?TWFLc3NOb1JnekU5RVljaTNwS0RwR3gzaHRTMXV3QmxoS3Z2aEh2YmpySXNY?=
 =?utf-8?B?RXFMRmx1dnp2YzdkemkzWGxVU1hYOWtNajJnWTNyTUlEemZHWEpmVkpxTzEv?=
 =?utf-8?B?ai9FT0ZkbmQ4UkhrSzNrMVJ4cHErZEt0UG1CUkJuVEtWTGl2K0E0SmZuK3Ns?=
 =?utf-8?B?dWMzVGMwcHVoV295QURBOFY2b2ZxcGYwd2dsVzJZUEpKemxMK2VMQnU1ZTVR?=
 =?utf-8?B?UjgwWFZPZ255MnRXWWVoT0VDVy82RzA4akQrb0JDOE1kNURnd3UwelpjVHBr?=
 =?utf-8?B?NFlRK25qZmlJcEJ3NzdnMUk2VzIvcVBaaWJhNGQ1RHdpM0FBaXhzbE5CNmJu?=
 =?utf-8?B?OVB5UjJlYlZKaU01RC80RTdUYlNUSFJLTUZ4eE4wOUMwQTZBcFljRzAxRGNN?=
 =?utf-8?B?aTM0a0xNa2c4SC9XcWlvUXJsd2dZck8rdmVCb0RiaVFCd3pJakVJYjVJOTJF?=
 =?utf-8?B?UXZSWHArY3RTcXpCOWx0RHdpL292dGZLMmNaYW9hc2xoamI4UG9aaUpPeHJz?=
 =?utf-8?B?aCszRkUxc3FDL051TFhScjA4b1hiVCs5SWxIb0poN0lNbXhTU2x0V3laclA4?=
 =?utf-8?B?VlVzQzhvb3o2eTRxR0phRW12ZU5SY1VkSjVQN3FtZ1lVSXZ5aTUzUVY4VGhH?=
 =?utf-8?B?dWNRdTM3YXNsZnpyUENDeWkyclUySjVEYkkycE94UGo2R1hPV25ZQm5PMlo2?=
 =?utf-8?B?WGJFZEhzRmhNd2ZvdE5wZXV6WURSaVo1c3BaRUNHUXNlTDh6K3lzTkhuRVNt?=
 =?utf-8?B?UUZDaHdMYlpNUlBFcXBVOFNDdGxhUml2NkpiSWcxSFJRcFN2Q1FERXlpRlNQ?=
 =?utf-8?B?cERMZXQzRVovUTV5TEJsbEdHYlREM3FZRmQ5L0RhRmsrUEt6Mk40YzYrQ3lP?=
 =?utf-8?B?QnlUZG04clNYeE5qTnZoaWhwbUo4aUI2T1dwTW90bDhpWmZVMW1VRHd0SUxK?=
 =?utf-8?B?bm0xT2Z4TXREOTg4TUJmRUR6THI0eUdEK1VxTzVNZHlvbGRmWWhFSFZiUWs3?=
 =?utf-8?B?MDNnNWtsYlpUR0k3czFaMTFpdU9BRTVROFZ6NGVGQkhNblREQXRVYyt4NTRj?=
 =?utf-8?B?WkpGUWJwUGlTUGFtVFRJd2ZlNHZLQU8wVlV0VXhic3FjWXNydXBkOVRrT1NK?=
 =?utf-8?B?NUE2cU9oNGJIQ0NxSjgrU1VQQWZwNnQzVVFTRVJIQ3FQaTNTZHYwajRrVSts?=
 =?utf-8?B?NkYxcUdqZVZsRjdlQnROU0xIcDZoeVRJdkUzWEcySDBhZHo3SGZjT3BpSFFm?=
 =?utf-8?B?Rmh4Q0wzR0NmajAxZkFCWnpva0MxMEVCSE92T0N3Y0Y2aFhXUVVZYXRmMkd6?=
 =?utf-8?B?S201WVBoL1RCcDErUThWdW15M0RsdW9mYklhNXJGQU5XZmt1UXFHV1RTNzdy?=
 =?utf-8?B?eVJsYnBnMHRVNDBrUmUzVnJEdStweElXbnRNM0IveDZIREg2SE8yMnJuQU9V?=
 =?utf-8?B?Ni9FVWtNelZGWktHdkpUTE4yVFl1d0ZZSG5QM2h4emN1MXJGaDh6djFpRTVV?=
 =?utf-8?B?Um40N2tXYkg5RXMxeVdyS2dvd2xyZ2dlYlJwNStWSlYzTTZETnNkaWRvMW1Z?=
 =?utf-8?B?MjZicXp6MStxZ3RKQm5yS3ZDcnNEMUI3ZnFBcFBZK1BneWtQSGRUR1Nva1gy?=
 =?utf-8?B?a05aLzZ6WTYwc2VXajRmNEEyUFhsTFE5WlYzYnkybDFVa0kyWEdSdllDU3Bz?=
 =?utf-8?B?czA4a2k5U1BEc29qTzU1TWFXR2twNzUzWXBnL2sveVhNTkJDUGliZkRhQmIr?=
 =?utf-8?B?aDE5aDNqUjljOVdrbFNaREUxVGZpUnAwR1ZwNXc3TmhqSzQ2QXgrVVIvOThV?=
 =?utf-8?B?aGRrRE1xa2I4OTlaTjkxZE1CT1dQbCt5TFJKVTdybWszaEVlV2k1WDRYUTR1?=
 =?utf-8?B?V1dNUGRzYURaRS9mSWE2U3Z3b2JsR2VtcG5YQW40UVhSdnN6Z2N5QUJScWNs?=
 =?utf-8?Q?PMlY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326000b3-c534-49e7-cbea-08ddd39ea49b
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 21:34:07.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjzXYR8w3xaRoNL7derT+VgsKXSW4/tHSbMFgRAd4zwCkhCZ5xzQCNTvVI7VF5XL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

Hi Reinette,


On 7/21/25 18:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>>
>> This series adds the support for L3 Smart Data Cache Injection Allocation
>> Enforcement (SDCIAE) to resctrl infrastructure. It is referred to as
>> "io_alloc" in resctrl subsystem.
>>
>> Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
>> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
>> insertion of data from I/O devices into the L3 cache. By directly caching
>> data from I/O devices rather than first storing the I/O data in DRAM, SDCI
>> reduces demands on DRAM bandwidth and reduces latency to the processor
>> consuming the I/O data.
>>
>> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
>> to control the portion of the L3 cache used for SDCI devices.
>>
>> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
>> partitions identified by the highest-supported L3_MASK_n register, where n
>> is the maximum supported CLOSID.
> 
> Even though this CLOSID use is unique to AMD this implementation makes it part
> of resctrl fs's support of io_alloc. It is confusing to have architectural
> specific features be handled by resctrl fs so I think it will be useful to
> add a snippet here to help folks trying to decipher this work. Consider
> for example a snippet like:
> 
>   Since CLOSIDs are managed by resctrl fs it is least invasive to make
>   the "io_alloc is supported by maximum supported CLOSID" part of the
>   initial resctrl fs support for io_alloc. Take care not to expose this
>   use of CLOSID for io_alloc to user space so that this is not required from
>   other architectures that may support io_alloc differently in the future.
> 

Sure.

>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The feature requires linux support of TPH (TLP Processing Hints).
>> The support is available in linux kernel after the commit
>> 48d0fd2b903e3 ("PCI/TPH: Add TPH documentation")
>>
>> The patches are based on top of commit (6.16.0-rc5)
>> commit b4ec95e3bc3f ("Merge x86/microcode into tip/master")
>>
>> # Linux Implementation
>>
>> Feature adds following interface files when the resctrl "io_alloc" feature
>> is supported on the resource:
>>
>> /sys/fs/resctrl/info/L3/io_alloc: Report the feature status. Enable/disable the
>> 				  feature by writing to the interface.
>>
>> /sys/fs/resctrl/info/L3/io_alloc_cbm:  List the Capacity Bit Masks (CBMs) available
>> 				       for I/O devices when io_alloc feature is enabled.
>> 				       Configure the CBM by writing to the interface.
>>
>> When CDP is enabled, these files will be created both in L3CODE and L3DATA.
> 
> "will be" -> "are"
> 

Sure.

>>
>> # Examples:
>>
>> a. Check if io_alloc feature is available
>> 	# mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	# cat /sys/fs/resctrl/info/L3/io_alloc
>> 	disabled
>>
>> b. Enable the io_alloc feature. 
>>
>> 	# echo 1 > /sys/fs/resctrl/info/L3/io_alloc 
>> 	# cat /sys/fs/resctrl/info/L3/io_alloc
>> 	enabled
>>
>> c. Check the CBM values for the io_alloc feature.
>>
>> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
>> 	0=ffff;1=ffff
>>
>> d. Change the CBM value for the domain 1:
> 
> "for the domain 1" -> "of domain 1"?

Sure.

> 
> (nit: inconsistent use of "." vs. ":" in items)

Fixed it.

> 
>> 	# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
>>
>> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
>> 	0=ffff;1=00ff
>>
>> d. Disable io_alloc feature and exit.
>>
>> 	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
>> 	# cat /sys/fs/resctrl/info/L3/io_alloc
>> 	disabled
>>
>> 	# umount /sys/fs/resctrl/
>>
>> ---
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger


