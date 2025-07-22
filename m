Return-Path: <linux-kernel+bounces-740120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B5B0D030
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AB1AA80B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4B28C00B;
	Tue, 22 Jul 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="7AS7E5SJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992E13AA20
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154200; cv=fail; b=DWzVofId2Ok6ED/gXOWw0KUkAPifVCFZpQNqomZ4kW62+XFXBZNDKU9wkgF6gh0f+rxVQXcc7KQviacElnni4koaTlPgW0/7w8P2cGErkjX7KjxQNun7aVhzKE8RbH7w45+JQDkYd0GXOn3y64jQqgaS3KnCh/96Wr4oiyW5+Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154200; c=relaxed/simple;
	bh=/vYKRqeZ93xiAlh8t8RKQCzhp9X4ispEP0q450ReMYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Izk2YmEidP71lZlY1qkoOWeoBCtlUUj+VDZiXfkOc8xcr1vuoZ0P5u0HUiU/4WhzeOZbjmbXjzmw3/Wr0+qMuhLGdP2Wax6SrwB/7tMyAQA6s1a3XUDLLBTScFcYXlI6XESyuiEIF03eFbFGTwE2sQvxPsKFSP5deLxFL8YzKgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=7AS7E5SJ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px5XpKTQiTnSS3UtigNsV+fI8u1tjzmcreQu5vOeUNCM6S6ZOYmEpWMSR9NvVVo7jH1hp6F2OEUvKQI2NkXOwD4ED2wwhaImy7CuW0EtOKOp3qQA5u+w05byvok0E7YV0k93l70iH6CpQUD+Q36OFKhhAolJjrJm9OJpv+qb3NgyO/Y7p6o4XzYGs4hfGz3dqzV1osNjDXCJhZ+65UgFfqemJffwqAzIHaTQb8v7SF+7whxwcjNU2yTfOxORJcQnzgEFy0RxWESz65SHzHXlMUxeRv2/9mxS8tMsh5NdVt5dpJks0t1WohwZ1qKZ0VRBP5zNuFhEvFFMtIjcuBIYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vYKRqeZ93xiAlh8t8RKQCzhp9X4ispEP0q450ReMYs=;
 b=c8pO3BRqqNcmqO/Nr0JScxd2Xt7xT8PgVlnphPjSaHk8sEcya/tEs9UFyIzBuGYAbE3uN05JJoSf3JMK/glj0J/De9HUBMEjUdmK1UEbEXy5fzMkLMI4aMA1AvS1HgMEmO5/ViTble2TFl9PTo0ijLQjErCwVxJ5oQizFL1rTQGa36cQpL97sVY0WZeiRTpATu9T7gv4gqxb7E1vYBRowRD1dwhPTJ1/tV+LO5EdIt2FgCD4mh1lLmd11kMcyhrKOibfil22G2XNpu5sVd4V8A6+njqMAU6gf3YLKbli1sy9a//G4/pKDe6yv2f+RUZe7S2awGEICdee3l3SvgYCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vYKRqeZ93xiAlh8t8RKQCzhp9X4ispEP0q450ReMYs=;
 b=7AS7E5SJ5b3jvT14wk2GIPS8TdLFgx3gKYXhHKUQbMB5lTQMMEbdyEyAtC0+8CITB5sJBoDWq7B7cteC3DXcNNTKEd3eRT9STTg2/GqV3xYi/BC/9BtDLxYY7oxPKp2JKjGDNtgrYAZQ+2PC153vMt2AymSB0uZ1n5jjr+KDsKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MN0PR01MB7587.prod.exchangelabs.com (2603:10b6:208:372::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 03:16:33 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:16:33 +0000
Message-ID: <dac3339d-a721-442f-8638-6e4c493f35db@amperemail.onmicrosoft.com>
Date: Tue, 22 Jul 2025 11:16:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vschneid@redhat.com, patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MN0PR01MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c4f79a-d485-4a18-45a5-08ddc8ce2892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUQ2T3JQL0pZNXgyN3Rnc1hjbEZVNzd1elZ4eUE0d2tzTHVlYkdnMlc4SjBO?=
 =?utf-8?B?V2xKZ3NRVDlHUGhpamFrVGYydHNIa1Q1Smk1emZmakdrcmdURkRVSmFUa3Qx?=
 =?utf-8?B?d1F3WVpBYXRmRUZiZHFhYlBiOHdPazIxR1I3eGpsOVlNTmVSZzUxS3JmN3Jj?=
 =?utf-8?B?WXEzMnFuczVZKy83aXJSbmhBRzZNVmNTZEFHc1lqYWZFb1RkcWdZNEhCd2or?=
 =?utf-8?B?eTd5a0ZpVGNtbzBtQkNiZEQwUmFBeEV6TFltSVc3cGh3UjFtTTFQZUJYNUR2?=
 =?utf-8?B?TmFJRThtVm1Valg4NmJlQkxrMDk1UWRRK09VSklreXFiRFdqM1Q2SWtMQ0Vx?=
 =?utf-8?B?Zlp1bWs2NUJpNGFKek9GZmx5VFp0MDlVSmI5K0dWS3dHd3JONnpFUWdodHpC?=
 =?utf-8?B?aUgzZzZEenhqNENVV2xPamZvanpoODVvMFBGa2d4Mi8zQlN3cEdwR0JMT1lF?=
 =?utf-8?B?Uzk3NzNKTFNVdCtKeHRoMkFSaHlrNC9JZ3ZhZXVqcm1UcU1pZ0VublRFcERl?=
 =?utf-8?B?TnhIVGdiaUVQZUFkdUhJYUJpSzJDTDRiWUtDTFAwWkwxUXFQVlo2UmhTOVp5?=
 =?utf-8?B?Qk9mcjAzS1I0Z2NsOUljdEVZUll3UHppSUdBbkNpdFF3SHBhUmFlQjJ1ZFZH?=
 =?utf-8?B?MkNpU2RVTkczbmJxeTZ5TjR4OFFBMmo5aExtUmUwbGdTVTEvbEFzb1c4Q0pv?=
 =?utf-8?B?cTV4MXRabHpkU01jQzJ1TXk1UUs5cXZhMGU3REQ2eDBLME43TVpkOGlvTUky?=
 =?utf-8?B?MjcvS1UwV1hyd1FReUVFWUFLRnA2cDVzMkl1bmZRRkMrS2FRQVVFekttNEZz?=
 =?utf-8?B?R3k1bzRSRnRwVEtDUEtxZnh4bmFlZFZiOXgwTzAxLy93T0ZxbytMUTdBTm1m?=
 =?utf-8?B?bFYxb1YxbEphM3d0dDVDcEYzTlRzdWxtNzdBb2cyMkJiZHl3eTJsRnlYWkhL?=
 =?utf-8?B?RFo5aGN4cnN0WU5GSXRyOWVnZjBvcXA4Tzk4aDJDTWpkQmFsT1QyMmwvR3d4?=
 =?utf-8?B?YzBYdCtqZW44MjZGWTlTNVVGenQ5RGVsVHhVckhpdnhTOVZaVGEwdG5Fb0tT?=
 =?utf-8?B?OU8xcU52VitrWC93YVZHUmxFS1IzTHRIL2dqM090OGFZTTdKSURVRFc3aW9h?=
 =?utf-8?B?L2RDRTZKbkFmVThYYWdQd2lZazh4K2ZYUk1kdG1hdnhjeGN2dlczbG1YY3g0?=
 =?utf-8?B?SVhOc2V4eE55cUg5Y2p2RVVqbDEwUVUzSHpYNFJlMmdYZzN0VVZBSzdCdzFN?=
 =?utf-8?B?VFJidm9qM0NWV2Uxb0o3Qms2ZkRyT3FTbzFzMlNWVWVndWJ0WU1UWHQrV0Fl?=
 =?utf-8?B?TWMweFl3dzdVMHJvanNqa1NMaDZmOFVPdVhRc0Jyb3FMbFEvd3FpMXJRYzZK?=
 =?utf-8?B?dU9XYWtoS2xMYWkzclJVT1FxYitrZkdVMkpYOHJPRVM1UFRvWmtuR25LRlVW?=
 =?utf-8?B?WlFWU0lyK04zMktXTlR5WnVCZFBuNE1odDd2UUVPOWl3YTV5T2hIZUxsYldL?=
 =?utf-8?B?ZmwxTDVBc1ZmVmZYeFVGM0NoMS9BTk51OUtMWVVyUTVydDVWRm9MelVaamdm?=
 =?utf-8?B?QkFaSmNCWUJ6TEpaUnBHYWxJU1I0YTdqSng4ekkwMmJRWXg4bWMybnRGNzdY?=
 =?utf-8?B?dnJFeHh0eElvZTl5enZKK1RSekJ3NmJoNzF6RVoybGRLRkFHL3VwemJ4cTdk?=
 =?utf-8?B?dFZucVFUb3Fuckd2WVdTWFFjS09WQi9OS2tSZnZ6RUJzRmNLTFVpUnc0ZXZy?=
 =?utf-8?B?Z1lxN0E1ak1yWTBlYTZGREN6UWt1Z3BJTEQwTXdFVEhMSDlYL0x0dTlERU9i?=
 =?utf-8?B?TERvQ1NqUFc0ZU5MMkxWcVphRFcyTVh3OFVkeWFMQUNsZzJjSzVacFhiL0JM?=
 =?utf-8?B?R2R3OFIwVVJHTTNJbENjRU45bzY2TmRYR0tFUjBKTWdlK2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkg2ZTV1ZHBiNE5sRkVQQlA5Titqdk1BUWVJSThoS1I0UjVaOGZwNEpqZ2hU?=
 =?utf-8?B?ZTNTWWxjcjFSL3NsRXRoM1g1ekxIUFhmaVJNWEt6ZnY3OHEyUlRDZzdtZlQr?=
 =?utf-8?B?YytqN0xIRFlmTVZQM3ZMRjJpek0rYkJxY3A2NDJZOHpsQ0FYT0J2UnVaQkxo?=
 =?utf-8?B?YW53SzlvK2F3QkVQSVRINGJWUmh1cVI3R3hyNjBPVFpxSnlBTzdCZkwwQjU5?=
 =?utf-8?B?aU4vZVJ2RWpIWFVtanIzSVRzSlAzaWNYR21wOGdBOUFBaXZMclhmN1VXaC90?=
 =?utf-8?B?SUVuS3FzdlVQYi92WER2NnZkU3B5a0xMbENrcXZMd2hZdWZGOXlkdGpiaWlJ?=
 =?utf-8?B?UWtZa2tMWnZ1VTlNU2xETEFUMCtJODkxQmYwZEVYZHJ5NG90WExQNFQ3OG5w?=
 =?utf-8?B?S0RFSVJ6S1Q2dHRjUVptb1ExM3NDL2hBTU80NXdZZzZkbTZtV25CVTZ2MXZF?=
 =?utf-8?B?YjZ1VjllZHBicTZ3UVR4YXdPWURESzMvMlVhcEpoQXFEMWsrZlYrSHNUOFd6?=
 =?utf-8?B?TC9jdmswRmVNc0R2aU9rWGxHdzdYb3dyeWZURUZ3M3M3azBoR3hYSUNBclFC?=
 =?utf-8?B?MkZWdWhMVmdqSHVqRlg1Q2djTW01QXozVXlESld1aVFEVnJjaEhmQjZuYmtZ?=
 =?utf-8?B?ZzBYcFdpT2hBOTlIZks0Sjl6azZlT0h4OXA0SHJvT2FYYlhjbjQrRVlIM2p3?=
 =?utf-8?B?cVdLWXU4dXBoZXZVVEU4WXNiNmw0NjFRQU41U0NnU0EvYmswT2xiR2VrUzJ1?=
 =?utf-8?B?ZUVocWlrK3hMK09DcTJzM2F1eDcvS0RLRFBjVGJtbHV6MHVkRmFZTzVNZ0t1?=
 =?utf-8?B?RksvemxtSVl1L1EwT2paKzM2TmR0SUNaSk9pcm11WGZWQ2d1a0lHeEViaXU4?=
 =?utf-8?B?azhIQ05ZSCt1STRMNjdlc3RpVmsvZHAzTUcrVnEyenA3dCtVRDVQQ3dERmxs?=
 =?utf-8?B?WExibUZPbCt1RlM5Sjl3c3R1VHJqN29nTWdKYWJVUitmUEovWm16V1NhZ0ow?=
 =?utf-8?B?ZU0xSjVLV1FJUzhuMThYOVRGN2FoVURISE1WRGF0RlFjbEVVNisrSFpPWXpY?=
 =?utf-8?B?Q3AvU3F4aDdhZ3hpTjIrYzlFNWtsdHlVaU4zd0p6TnZRYjZKdzNzOFVnQVhw?=
 =?utf-8?B?MkFEaUJqMStTOHVlYkNKR3VGMWxBa0RTRHBYVjJsTDJmSnFmK0s1YkNOWmc4?=
 =?utf-8?B?R0E2WmcyU0NUUnlneTlveGFWQkdxMVlUTHdIL01YN3BmVkhOUElQY2VTUDVN?=
 =?utf-8?B?YXQ5cFhrVzBPUG1sZDcyRm5PbXdQdEdrTjJucFVTR1Ivb2tTRy9nUHBrNkVE?=
 =?utf-8?B?elNLUFM3aHEyTUZFSzJ4QUc5Z2ZMN1N6NzgrUzBRVzh1amRVL1FpTmZJZEJw?=
 =?utf-8?B?enpUZFc4VTZ1Y0pSbVNVTWhFL05Qb3JNNWZqQ0pMbXZUSXBwVWxleHYwaE56?=
 =?utf-8?B?WEJ3bHBVNGoxeDVuaHg2K21nU01TbE0yQ3c1SUJ4c3hUdHV2UUJrRnlnclpY?=
 =?utf-8?B?cElnMFZ5YWdYdHBRL2wxWDJ5Nk9MbHNReHl6eHBZeVVJMHpLVnZWQ1dzREZV?=
 =?utf-8?B?RFplNU1xaUVaUmxpUGFFSXVVWWdOd1VaK1pUeUN3YjdZd1J4bWdDemQwQXB3?=
 =?utf-8?B?b3FUNlpxejRHU3hkK3NlNUVuZ29NNGc5bEZxRWU5MStnZGNnVlp2UFk1VEpl?=
 =?utf-8?B?dzUwaWxtZFNMd05DQW1vdDhFWDdwcFZVNHh2REhzd1o1NXF2d2xxODFNUUxT?=
 =?utf-8?B?cFlvNnFCa2xuRDg3OWt6Q3BydVNFV0g5ZGRMc2VUNnN2MW5ML3k3aFhYRm5q?=
 =?utf-8?B?SzY1Ly9oY2h6LzZDNHlPQk9BWkRKaTFLeHNOYUdWdzlYRjN2MUZZaG5GMEVl?=
 =?utf-8?B?c2dUSDVqVkdZN0NScXF3N1FxMDFaZ2VoVkhiZ29jdGFVZTlqU3RsZ25VNURT?=
 =?utf-8?B?Qm54MHhrQ0grbjJuSkEyQjJvZk4yTkpiSTNjYW1abWpFdWdmdU82YkdGMGlB?=
 =?utf-8?B?SzY5TnBjcmUrbDJ2UTRTZlBDTndNc3c0cFlhQlMvMVNKVE1WNW9Gb0tjRWVU?=
 =?utf-8?B?TWNuZEMyTVQzSUlhSGt0cEwzZ1pOME5jMFN6T1JBcnFJZkhnSXFlQ0pEWkF6?=
 =?utf-8?B?NVJha0cvdFBoM2dLVFJCcGlab3RCL2xLL2Y0bEJCZDlDY3ZIOURnTEJUckN5?=
 =?utf-8?Q?fnWg+YtsnedVW91b/fHahII=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c4f79a-d485-4a18-45a5-08ddc8ce2892
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:16:33.0139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8zsW3v+HZioEuO+7Do3MNcHL23DXK3Vv8aYrj39LOi22T8TZD56CX5ljk+KmT2fwp+jjB5Fr0ehfE+VrE3R6kHJQoDcTexVqpXPkUi35uWptSaBW2YiZfFTviimURHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7587


On 2025/7/21 17:40, Vincent Guittot wrote:
> On Mon, 21 Jul 2025 at 04:40, Huang Shijie
> <shijie@os.amperecomputing.com> wrote:
>> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
>> iteration count limit. It is however set without the source RQ lock held,
>> and besides detach_tasks() can be re-invoked after releasing and
>> re-acquiring the RQ lock per LBF_NEED_BREAK.
>>
>> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
>> as observed within detach_tasks() can differ. This can cause some tasks to
> why not setting env.loop_max only once rq lock is taken in this case ?

Yes.  we do it in this way.


Thanks

Huang Shijie



