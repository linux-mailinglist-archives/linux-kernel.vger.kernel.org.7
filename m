Return-Path: <linux-kernel+bounces-732030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA81B0611B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C767A181A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D50225413;
	Tue, 15 Jul 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XxuhxClW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3291FF1AD;
	Tue, 15 Jul 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589021; cv=fail; b=N2orAr+ZD/6Tiwyi1b/cfzHpm0VvQVimOIKDki6kbGAGAwJPTtpmXKg5w1E/2dwVymZCrCCXp7ZdQIOmExq15XanbIWIui1mYiDw/Z80TzxPZVk+4PGhSOjKMY8/LzjLvCybbDgtxEfC3WKPVjrjd1yGqfGiGZTRKA/o5t+s7v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589021; c=relaxed/simple;
	bh=s2VadCplfgjYoChxV+zGHMCW5nwIiE/UUCoXHmC3rW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETHgaDkWTqD+KuyvUi4KGzSsfZ5jy749qPfm1FA2rpHFL2JicqtSgVpDlDOPOcSH+4NPDZ3rRp/TDG+/OBi7RvKmfyca3Q6W8Nye348Rjzl0OZwjKGIZybcfbg2I4HhGm4AT5c2WRYKCgAiA6fINKPRPRJLcMZ4a9ON461QB//8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XxuhxClW; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrpYCZ2dH+EppFyqKp0ziraITISuUyv9pSWOTjjOZ3rwavHS2J88FAFjcpo0wy++mNilr9zZH51kDDcRhPtu6BWEs7T2oUB7da3nI1Psx5r+/2V1uFEBKYnNjLAMf3NIARW7wz0IjQUYxXlGmUZduxPYd5gLRsBX+f7klvroAahUFXucP2ICT46WbB0IyDGcNhNsWDuuqShUnu9mwGOBkvf9KWqttFi4/8MShHnNqlrHyNViwbThrVNPtWApZK7lr+FigNN0RgZga3TG3/D8TBPUacMFSk8PM5l9QTfcLr52oZjfjjg+b4PHMHO8RbQgwyht8T5AMY5Ly11BqyL+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyZE3JoYMg5/quGbKcwvqRMZamBqCJ7r7ZP45Oh27bA=;
 b=k6auQNDcMtokiOLwHcw8L1jYHp/848GXhDQ5UtaLRpd9czGzJJCy3jgL5U0t/ZzZSkHwlRBlJF+WtBlW4zXXXKfqHFAb5WaE9kTCnjAhqUZIxFO2TQEJ8yRuZMqMSfq8jP34ORaYhwVqIhf8r8y56eaHXhIxnJmjRxu8c2iiv86fQifb76vu2hYOrZHyJ7tqzgBeX3SLL+ccSmeItIIZcrIno+s4AIiIUfUaayWUoIubfQeAo89nINyKX7vBm9vOVdEJF7Ne37s6nb2BidglyqMrlVUTQlQ98ZU25WKY3+JaC1gZxcEzV0Aq7Z/eujO01/EaNBHu8iAglpybZxWXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyZE3JoYMg5/quGbKcwvqRMZamBqCJ7r7ZP45Oh27bA=;
 b=XxuhxClW14RNF2yAjNrLJDnuNH/k+RShpm03VmqTYDGblMt25CkFC/j2kyNqbY4C6rMg58y3j+ZN/Pds34YS5Ha9baE4nnEdzkY9dSI1L4/vZLXqizoKikUaEqeZyTyvh1jcP4QSuMxxIcI+gU1H6P13PkbKe0O/9qXzZ037Jh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 15 Jul
 2025 14:16:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:16:57 +0000
Message-ID: <e45064ca-56f5-4d86-b088-cd24ffc0e96d@amd.com>
Date: Tue, 15 Jul 2025 09:16:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 05/34] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Dave.Martin@arm.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
 rostedt@goodmis.org, Neeraj.Upadhyay@amd.com, david@redhat.com,
 arnd@arndb.de, fvdl@google.com, seanjc@google.com, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, xin@zytor.com, manali.shukla@amd.com,
 tao1.su@linux.intel.com, sohil.mehta@intel.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, peterz@infradead.org, xin3.li@intel.com,
 kan.liang@linux.intel.com, mario.limonciello@amd.com,
 thomas.lendacky@amd.com, perry.yuan@amd.com, gautham.shenoy@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <d55fea7bdb5df1e39de59b23289197ace08020b8.1752013061.git.babu.moger@amd.com>
 <CALPaoCgt=fk8-pOunx7EiR3ESLV2EWCBxpo3My2q7Nz8uXfz-g@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgt=fk8-pOunx7EiR3ESLV2EWCBxpo3My2q7Nz8uXfz-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:20::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bf93a3-e71a-44fe-7f79-08ddc3aa4183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2owUEd0SEkwODYzY0Q5QlQrQkNuYlV5eGRzRVNvSi9ZQldFY0FvbHpLVTZT?=
 =?utf-8?B?WG1UNlkybFBVMk4wUmdIVnN5b1p0TkhlN0xha2FQdWZjZ0ZGcit6Vk12MU8r?=
 =?utf-8?B?Wmw1MklWTTNJbFc5M2RKcWhKS2dXVHM5Vlo4YXNQR1pwVXNGM2R2cjNWKzVs?=
 =?utf-8?B?b29zUDIydlhBc1I1RHVqMS8vbC82aERTRTNDRW1iN0VaR1NLRDY1eGRZYzFR?=
 =?utf-8?B?RDhYaCtsTi9HdjN4SGZ2TnBWWmg1aUM1MnlDWlFTSGNKbFRGcVc2T01TTlh6?=
 =?utf-8?B?cmdMQmlmUTBBU1F0TGluWVBiUkdTSGE2b3hFeU1yYkxMMnk0MG1JOThjU1JK?=
 =?utf-8?B?Z2ZlMVg3UDd0cDA1NEQwaXRsV1hKWW5PR0pYbVZ3VGxsUE9JNTk2N2JWdnli?=
 =?utf-8?B?Wm5ST1JkWjQyeXBpRWpma0RtU1RzbW15Z3Zma2QzTzhuNWorVnFOdVc2N2lv?=
 =?utf-8?B?cUxPbXl5N2VDcW5raHZBdkRRZ1BGbk5FdVhsUXlkaGtYSnc5cDlMOXNhcEpy?=
 =?utf-8?B?SkU3dWNDWXdnSUhTanlESzJoZGJjalhGVHk5UHFRWGtaTUl3R3d6S2xiK2Iz?=
 =?utf-8?B?TXN1RGtGNkFqZkQ0cW04eTBscGRlVEMvbkxOdXl1dkw5MnF5M1paeUdCcHpl?=
 =?utf-8?B?Zk04a0RRZzRmL0grRU1wWFN6cjBOS01hazl4UkdENWhuZldua3BvTXh4a252?=
 =?utf-8?B?VEduN2EwVjdaM1NzL2ZOYTREY01nZXVObkdNWFVyK1I2NUFXSmZxRVJVWm5Q?=
 =?utf-8?B?eWtPSFNCSTljVUdYMGJSMUxKSlQvdS81UEpJaWJmcnZRbmNBeEhmUmtNY25D?=
 =?utf-8?B?Q1lVaWhlNTErdDNMaFpxRG54L05mRUtqR3h6UW9odWZHb1hseEpMeFZBU2FE?=
 =?utf-8?B?cThrZ0hmWjFZc3hTZnZNamtobEUzMXhSZ2tVSHlDUEthcDRFUTh3d0FUZTJx?=
 =?utf-8?B?SkFxSE4vYzh3M2tydzlGWEFKQTBQMzhVWlVTMVo3YTJFcVROdEYrVFVhSWhl?=
 =?utf-8?B?UjdpdHpGa01JOVZDdy9VbDBYMHNTN2NuUTFIVUw5K1piVzR3TG1rYVRMRlp6?=
 =?utf-8?B?WDE2dk9HNFgwQUhxWFFSYlczREl1SGJESzNCWmxOaTBPanZOc1poOWw3RXFl?=
 =?utf-8?B?YXdoLzhWV29xVURBdVhqa0pLUDR2d0c2K1N4RUhtLytWT0lQTm9rQTUwWWEv?=
 =?utf-8?B?Z3E4REJrNzZhR283alZORG1rYThIV3B4Tnp4cC95WUl2M1ZNU0FxK0N0NDJk?=
 =?utf-8?B?R1RiT2tDNXRmbFBqTTVVZjdtQllFZ0RIM254c1BhejZ4K0ROc1dlZWFzMXJu?=
 =?utf-8?B?dmZrcE5ObGdTalc4eDJ1Y2JjS3BSSHkyRkVucUozampYdk45SmJhNmc3N1hl?=
 =?utf-8?B?bmtSYkIyaFlGcWE4T2FXSk4rQjE5YStsdnFQUTNaSGl3SThTUGM4ck9uTWtj?=
 =?utf-8?B?a240S0owMHM2cCt2REhGWU53YVpZOVdiUTFUcWI2Rzh6dzFYVUxCOUpKSG5t?=
 =?utf-8?B?UUxOeGE5dlY2Zm9FdGZrNlZQT1ZoTVJCeTU5RkdTNDM5VW9DV1dieDdFdWFL?=
 =?utf-8?B?WEt6VlZjaUxUTE84UmYwSkpsZUlGSUJqT0J0Yk42cGlZYTJIN241cyt4bjNG?=
 =?utf-8?B?K0NLdElxTDZ2RkgwOGZnSlJGSDR0TnQ3MFl2ZDNuMFFybnU1dTlzRDYvS0dY?=
 =?utf-8?B?b2ZwelFxUzlIVDVLR0JzMjlWaVkrZmV3UnE0NjQwYk5CbzlSQmlMd0ljWVk4?=
 =?utf-8?B?QksyT0VrNDRpS3h2OU9nb3VhUGNBY09RckRiTFh2L0hYZE5GV0tZY3FxMTNs?=
 =?utf-8?B?b0I0ZStMWTNKNk5LTUhYd0JscitRemdjZjFNY0Y3bWdmSzgvcE1mVGtSMTUw?=
 =?utf-8?B?bDU1dHFZYzJZT0NZcXVOelFlSUdVYXVBOHk4aDErQVNkTk1TUWdMWEJiL1M5?=
 =?utf-8?Q?hQwQehQRoHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWVOeElMUGlvbVJ1cXJXVGRPYVZyVWtmYk1Wa1dqd1pVaWdnRU5iMFg3TTlk?=
 =?utf-8?B?R2sreStlQkNpYlYvQk5PMTBMSnZ4T3ovWCtKOGhhcmYwZ0Fqa284V2ZlQ20x?=
 =?utf-8?B?K0VhMzdIU2ZYdUNyRWxIYnpFNUdSdnYxTlhhSFFwUEtxRlQ4TkpzWG5BZWRo?=
 =?utf-8?B?ays0WXd4a3NqaXZVQ3NQVlBVZzFyTjI4ZDhPWFFCZGVyUW1ZUmNPWlhIQlg3?=
 =?utf-8?B?SnkzV1JkTkFDUi9oeVJzWUhWdURjUXdsbUQ1cDY5cWJpVTVEYVc2MVl2NHkw?=
 =?utf-8?B?dEpwWUVDOUYrTlJyM3RkRndUWCtJS2gwdzkrTGJBSWxRczJnZTRzOE04My8y?=
 =?utf-8?B?bDdGQi9FV1c4bXd5N0UzU1ZNOVc4amViTDdzenE3OE8rL2lOUmlzRE5OZUM5?=
 =?utf-8?B?d1pxTFdlbzZibThXbS9BLzh1K3RWa2wvM2dyRW1Qa3dudDRrTXpiK1g3bTF5?=
 =?utf-8?B?bFVSb29pYTI5Z1IwVzNsRHBXU3JWU296ODBsKy9GV21BWkg5L1Y4UmJsczU4?=
 =?utf-8?B?aTZXY1hmZ2dteitSdzlzd2UzUCtIZ1ZSWHNyV3VZR0xqV3FrcWhrWmJMVGYx?=
 =?utf-8?B?Tk9adVV3RWJKMVFmbGJOa0JDU0dvbmtQaHZYSi8ybFlCZDE2SGNSaS80cE9O?=
 =?utf-8?B?M1Z1V2dVbTBKeHpNQTVKRWlCREF4YVMyRTdZQ0dDME12d0NrSFN2QWNEY1F5?=
 =?utf-8?B?MlJwNE1SMlBPNHBrb3JJN0hzOGY4Qnh4c0JYWG5nbGljeEYxWU9rdGhSSzZU?=
 =?utf-8?B?RHNOdHFCQjRBVTY5Umkvc05tRFozS1NTRXlCU1NvWGxuMEN5eEVKUmZWQkRY?=
 =?utf-8?B?eEEyZEtxRjdHbURnRXZpVW5nVSsxb1g4ZTU3a1NJL2R1M0F1RzkxMFRnZjNL?=
 =?utf-8?B?WHNZZ203VmlVbSsvMU8wTEdzRVoxQmYxeHZKNnhhblB0eXlkWGFvQmRvRitu?=
 =?utf-8?B?N0M3SlBRWElRVXZpVFdLYmptTFo1NmhXUEVsbjNPL1VQOTBleUMyMDAvTEpj?=
 =?utf-8?B?Mi9rS1pzVnBLZmNkQ3BKNGRjdnpyKzdmcUtXNGRORG9xODNtbkNGSHhmZ29O?=
 =?utf-8?B?dzFkYVBJR0dWTk1Ea3c4UzBENnczTWR2SjQrWjNhU25BU2dnVzUweHkyaTJN?=
 =?utf-8?B?WnFOOC83VEtRQWtidHJlUm5uOGF3V0pkbFd2V3J6NmZ5TUdGZ0VIMVdzL3dO?=
 =?utf-8?B?N3lIVHcvL2hmM2E2VGtrVThCT2Ryb292UTBDaTAvYUd6cVYwdHRrZG5Mei9j?=
 =?utf-8?B?VGI5NEpyL3lXYkdrSWZrMVdCanVDYzdWeXNpWmRBSUZkQW5VdjBQYWp5b01Z?=
 =?utf-8?B?c3dPRUJiM25yMGphN3ZCbEhieTlGT1RqUUhiN0dXbU96SnMxZDAxZEUrTEhZ?=
 =?utf-8?B?OThiZDJDa1RMS1NaamRpM0RvZ0pjaGpFeklzbDBRemhReml6WFk0ekpoMVdK?=
 =?utf-8?B?Z1VBZHJFdVRFMTBNNlp0M0dYQ1NQV0dieTVBSlBITHlJQ0RTK1VESTFVdUpV?=
 =?utf-8?B?c0RFNnBwS1ZaQ05LWEJtcDdiMjRXYjQvUlcrV1c5WURGUGRnSFlXMU1XMVVH?=
 =?utf-8?B?N2QvRUlBbTNlMUlBOVI4WUQwRkowaStldy9ISnZLNmtXQkZYS0xXbnY5RWk1?=
 =?utf-8?B?bXA4ZWE1aHdha0pzcHFOUEowdjFRZDlhNjY1L3RTZDlyaERQeTJCSUZGbzh1?=
 =?utf-8?B?TmxnS3FYblFpOUxyRlVLR0dPQVAyOElLbVZyeHJscUk2a1dlTTNNRGdHUnI4?=
 =?utf-8?B?dWFZWTBzTVNzakdxZFo4cVdINGhOajB3YkJPSHVoODJzalV2VFhyQ3J4a1F2?=
 =?utf-8?B?TTFEbjUyL3lxOUY5eGZ3OFFOYjFLd0tjdG1Vcyt2U1cxUlBId3NRbFVOZVor?=
 =?utf-8?B?YVBtSmExZytqNElsZTdBRUNDcU14c1JhZllHU3NiUVpibUNoQk5FN0dNemgy?=
 =?utf-8?B?RitaZG5aNzcxOWtVYThxRXVtQnd3QkxqZTJmTWRFRzBhR2lnSWliNERCd0tT?=
 =?utf-8?B?WmdKYXlseWkzaFB0dklJdFhiVWR6ODJhSnB2QzlSL0xFQ3FnMVhJT0RPckZ3?=
 =?utf-8?B?V1MzMnY1RXBRUmozOHFaYVVxaUFqTVhhdDRGOGt0NlE4M0QyaXcraENSVWRF?=
 =?utf-8?Q?yNBY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bf93a3-e71a-44fe-7f79-08ddc3aa4183
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:16:56.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW2DK/VKC13BLLE8z7UmQPxG3nfRDVoEsHwT/BOMJCowFAYXqonAjjosdqv1YYZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

Hi Peter,

On 7/15/25 06:47, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 9, 2025 at 12:18 AM Babu Moger <babu.moger@amd.com> wrote:
>>
>> Users can create as many monitor groups as RMIDs supported by the hardware.
>> However, bandwidth monitoring feature on AMD system only guarantees that
>> RMIDs currently assigned to a processor will be tracked by hardware. The
>> counters of any other RMIDs which are no longer being tracked will be reset
>> to zero. The MBM event counters return "Unavailable" for the RMIDs that are
>> not tracked by hardware. So, there can be only limited number of groups
>> that can give guaranteed monitoring numbers. With ever changing
>> configurations there is no way to definitely know which of these groups are
>> being tracked during a particular time. Users do not have the option to
>> monitor a group or set of groups for a certain period of time without
>> worrying about RMID being reset in between.
>>
>> The ABMC feature allows users to assign a hardware counter to an RMID,
>> event pair and monitor bandwidth usage as long as it is assigned. The
>> hardware continues to track the assigned counter until it is explicitly
>> unassigned by the user. There is no need to worry about counters being
>> reset during this period. Additionally, the user can specify the type of
>> memory transactions (e.g., reads, writes) for the counter to track.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> The Linux resctrl subsystem provides an interface that allows monitoring of
>> up to two memory bandwidth events per group, selected from a combination of
>> available total and local events. When ABMC is enabled, two events will be
>> assigned to each group by default, in line with the current interface
>> design. Users will also have the option to configure which types of memory
>> transactions are counted by these events.
>>
>> Due to the limited number of available counters (32), users may quickly
>> exhaust the available counters. If the system runs out of assignable ABMC
>> counters, the kernel will report an error. In such cases, users will need
>> to unassign one or more active counters to free up counters for new
>> assignments. resctrl will provide options to assign or unassign events
>> through the group-specific interface file.
>>
>> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
>> Bits Description
>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> Note: Checkpatch checks/warnings are ignored to maintain coding style.
>>
>> v15: Minor changelog update.
>>
>> v14: Removed the dependancy on X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL.
>>      as discussed in https://lore.kernel.org/lkml/5f8b21c6-5166-46a6-be14-0c7c9bfb7cde@intel.com/
>>      Need to re-work on ABMC enumeration during the init.
>>      Updated changelog with few text update.
>>
>> v13: Updated the commit log with Linux interface details.
>>
>> v12: Removed the dependancy on X86_FEATURE_BMEC.
>>      Removed the Reviewed-by tag as patch has changed.
>>
>> v11: No changes.
>>
>> v10: No changes.
>>
>> v9: Took care of couple of minor merge conflicts. No other changes.
>>
>> v8: No changes.
>>
>> v7: Removed "" from feature flags. Not required anymore.
>>     https://lore.kernel.org/lkml/20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local/
>>
>> v6: Added Reinette's Reviewed-by. Moved the Checkpatch note below ---.
>>
>> v5: Minor rebase change and subject line update.
>>
>> v4: Changes because of rebase. Feature word 21 has few more additions now.
>>     Changed the text to "tracked by hardware" instead of active.
>>
>> v3: Change because of rebase. Actual patch did not change.
>>
>> v2: Added dependency on X86_FEATURE_BMEC.
>> ---
>>  arch/x86/include/asm/cpufeatures.h | 1 +
>>  arch/x86/kernel/cpu/scattered.c    | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index b78af55aa22e..d2950a0177cd 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -490,6 +490,7 @@
>>  #define X86_FEATURE_PREFER_YMM         (21*32+ 8) /* Avoid ZMM registers due to downclocking */
>>  #define X86_FEATURE_APX                        (21*32+ 9) /* Advanced Performance Extensions */
>>  #define X86_FEATURE_INDIRECT_THUNK_ITS (21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
>> +#define X86_FEATURE_ABMC               (21*32+11) /* Assignable Bandwidth Monitoring Counters */
> 
> It looks like this bit has been taken by X86_FEATURE_TSA_SQ_NO. I had
> to move X86_FEATURE_ABMC down to (21*32+14) on tip/master.
> 

Yea. Thats right. Will take care in next revision.

-- 
Thanks
Babu Moger

