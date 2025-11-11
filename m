Return-Path: <linux-kernel+bounces-894961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAEBC4C913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16461188D57E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37061257846;
	Tue, 11 Nov 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LXbnzdkb"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021089.outbound.protection.outlook.com [40.107.208.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B821D5AA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852077; cv=fail; b=UkTvzB0pNcfMquxYW+H+SQlkZUdkGhF3IIhn0J4kxX0zCE7W7C6it16IXKgQQ6QqtUvcURuAy3R+KcLKO8/np3XebC3gbexEuezE57QIuk7svHtflJPOUALq3x1MJOqLZ/ppN9e9Jt56oO7ZdWkczxhhwe+rIikdmZwIze9vwj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852077; c=relaxed/simple;
	bh=Bp2Cxt2CmkU5hHFkVkz1DNT7x0zDb4UpDO7mlApJcxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSJNtoVXeG8jQejMMCYlY6YvKISy1ZSykVrjaj3rUnFjAIXxY7PYwpwcIsfwdsO0o06RF8QEIbuIKAgjyjvxWGsYr6o/3R+FFZTrICf3HxCy7qDNA+DKxOQiGy0mdoP7zScIdkajx9+38+Bf7Pp2G1IWd0RYLeva4qDxnvPpP3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LXbnzdkb; arc=fail smtp.client-ip=40.107.208.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXhqaYf5AeeP2csm0R5E+txee1PBUP1NjnBObjJ/KNhPo+/hkUAQ9P/TDzxRYsOcPQFKKYplbZVPgNX1/vcfUOn2RawifKbn+ZAId8gYKE2U7+1/eYKRvUKLE4Y/VhWHQINakYeTN4a/5/0p4R5iaMsR9Bw41gr/6dXhaGa5oU3Opffz/uqVszTaAO+6CA4ngNQ5fzeP6Pt7w/z3YEaOmna5+EN/9p9rc+JTtxjoCY8+fK8ULrBb5SYI67yahFLKZxHeSpEupLQ6lraagyikV6McjiiZH74ZVkIew61yILHhMEN6N3v9RuJ+rM1qzKJSrVk+URbXYe9jU+h6ABboNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvQ9pnQG6Qex+OG4MEt4nz0DutsabMWgJtSI1LjFb4o=;
 b=gfd0rqJ7h/mx541RWNjtQZcD11XwaOiG72Sf/FzNHTWWT5DVmxFg9fdIDy+DqalBoUIij5BGZcLbn3BpqzNyo+Hrp1WYs4+eYTcCB69i3XUoorrx65dbuDYv/ZDwToPrh6yJfZ5JwCZYh9na1KupVdhYERNA/k+RBKl6n6qbTYF+yZ8b8YSSNFa0cppTKcCvwWhCUp81o6aVqxya6hDi1LwAod1W+DNjd+nxq7rlechBGpK/Ew3KXKdXg39Uubp3NDSUcrqXTJREpZUKJSSzBbMnjFwjhT91LW/pMXMzQL8XYpAa4sCg3OVEbm0PRnRpRPN4rznCZZyP1ksSoP/8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvQ9pnQG6Qex+OG4MEt4nz0DutsabMWgJtSI1LjFb4o=;
 b=LXbnzdkboME1vgC6tYfDSppzIEkW/LbyIwfFnJXklPODcJSWp6dfA+1SzRNGwgnXUNWq606+Outh1kbVN63buBMBiaBWW4Hn9p8TqPnmEsfx3ge+jtqE69hxIbfXKOY17SGAwq6CK/w9MRefa8YOXdqNZ7/J5tiWfZUjlCA8RoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 BL3PR01MB7097.prod.exchangelabs.com (2603:10b6:208:34c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Tue, 11 Nov 2025 09:07:51 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:07:51 +0000
Message-ID: <ee62fc73-2a08-4648-8852-afa9e2705c8c@os.amperecomputing.com>
Date: Tue, 11 Nov 2025 17:07:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
To: Peter Zijlstra <peterz@infradead.org>, Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20251107161739.770122091@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|BL3PR01MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bed620-c3a5-48bb-bd73-08de2101cab0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZNRjFlaUZWRkR4T0x0SXBJbkJ3d1ZpU3V5WS83WUtLQVQ1MUlzcTh1UTRV?=
 =?utf-8?B?MnMzdm9nTnBFZmgzckVjcUxxZVhUQjZ0NitzWWhDeUdGcDJYMTFUUHZUZkxr?=
 =?utf-8?B?TzdBdEg5cGNmMjVsbG14WmZlNkhqbE9FbnhtbzFkbks0Z3FwYTJWNDZBQ2dY?=
 =?utf-8?B?MWl6RmU3UDduRVFTTzZaNVd1WFp0b1hpZWxqcHVDRXpKTGpHcE02SFJTbHFu?=
 =?utf-8?B?eHE4UjdYSTNKVzNvVWdJUGZjUTZ5MWZvRWg5VWNZYXBiS0FiUFoweGd4Ukpl?=
 =?utf-8?B?dFhGYjRJN3NrR1RHbzRFQ0lWcWhnaTdLMmVOc3V4THR3UW04bVNsV0pZRXFH?=
 =?utf-8?B?RDYyTnRNSGlOVmtXWk9sMW1peGRiQWVIWnpNUWVKa2pOQTVLNUxZL0RITnNz?=
 =?utf-8?B?a3RsbzlMSi83UDQyMG9NYWZSMnd0MlU0b0phWWpvRFlBUnltZUU3ajlxRWZU?=
 =?utf-8?B?bjJ4WisvZTI0V0NxM2k1MkYvS21ZQmtTalNDUTdDcjNFcXB6ZDQxS3FqR3lS?=
 =?utf-8?B?aFliTmZKK2hWZFJUQXVqRm5uTWJYQzl6R3FweGhXTHhHc1BYdi9OUEl3THBF?=
 =?utf-8?B?QkFGa1VDZm1qcit5V1YyWllRaUI5bERhcy82OWphSHhxWkxualdhRjRMUjh6?=
 =?utf-8?B?eUVtNjQ3aDB4T2RZQUlGNm5FbXJNRlJzdG5EUGRwY3NtaHhraDJadHAwWUdw?=
 =?utf-8?B?YldReGd0WlVjM29vMFp0K2JpRWxMU29qSWdCbitwb2pLUnhSZURzUjlWaTcr?=
 =?utf-8?B?SzF3NTNldzRjV3lva1VyM1ZjMERWL3FyWFlIVW5sQjdKN005Y21WNFdUUXJR?=
 =?utf-8?B?by9LeVM2TUlPTjhMcnpmdHNPdmJxSVRxcEJsdjRSbmpuMXpnN2w1TXUzQWIw?=
 =?utf-8?B?dnVYZjdBNnVZSTRkK2NaLzJaQVllTDN3WStYb3pKaXdTVk4vMERvYUkwV3I2?=
 =?utf-8?B?aVRGZWhsQlI1eHN0K284U01PaEY4UDN6dndBdDJtSEYrbHBvYUhRSWJoWmJ2?=
 =?utf-8?B?V1BCb3hMd3FRcmNPUGVBL20zQmNFNmZUcXlyTERuSG1XY0pzTzhhRkQ3K3lp?=
 =?utf-8?B?UXJweldDK1VGNWlnMnNVZXM5UFkxVTVWT1VVVjF6T3IxSXZrUXROMUZUMFZp?=
 =?utf-8?B?ME45L0tObFZDVTJzQ0x6TzZmTTc0RHhRT3lUZHdsb241UGNMd0h3UWdMbDFz?=
 =?utf-8?B?cnF6d2NhdXpkNDUwN24xWUZ3eWRHOGpHQXRyZFArbXJCU1c0dWJuU2g0WTRQ?=
 =?utf-8?B?dFAzUTFoQXRaTmpyNWl6QTBsTGhJUmVDVDZiZ3owZ0J5MlFtaDZXMUFvbkZY?=
 =?utf-8?B?TG1jMmJNcWFUS2M3WkoxbEZ1TnE5R1d1N2tiRElWRTVPNXFPZ3N2V0k5V1N0?=
 =?utf-8?B?eFdQRTdMcVN5aWtXVWJtMGhMS3RZL1BRS0NqK3U4cFgyY1cwaitBMmxJQndt?=
 =?utf-8?B?VDBlUWF6bE9qZWdlbDNhR3ZuQTBvdXlXWm00VVVYNjRDZG1UR0hrY093MFND?=
 =?utf-8?B?YkVSTE9QeFRYRlp1ZzQ5WFdjNjRtTy9VTkdoV3F5TGlxTGl0dVBGRU9rU1BD?=
 =?utf-8?B?WW5BL0VVNW1tQyt5aU5xRXBtQmRBSkFFNGJwOXl0dU9ITzRlSVpSd3pPeTMv?=
 =?utf-8?B?YkdLTkxNSEcxMUtGUWFFbVovNWhINU80eTJjWno4TElxMGpCWjY1VzVQbWZx?=
 =?utf-8?B?YWpXUzNOYUZKdkhjSHNZNGVSWEY1WlBZcVVZejBoelJXSzFPbjRZWXNNbXhh?=
 =?utf-8?B?OVNBbXdIYWdETE82STREUUcrcnZKd1RDeUFTclB0aFdoQmIxMUcvanZFck1C?=
 =?utf-8?B?d2xEbkh5SGVRMzJPcVZsTVFTcVZza05rQXBhaVErdm5Mbzhxa1NqZDVDc1F0?=
 =?utf-8?B?bUtjRFQvOWlGZkFsUVl1WVlXTDNmbXdnMUlrMUpnRy9oZkgvNHV5K25obnRk?=
 =?utf-8?Q?rjLXKOrct1Z0RSEZ+tK/GGzmEjhMw9u1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hxTEFldHZ4YmNFc1d6ZHdlNlBra2xFRGJoNUNmRmsweit1cGo1b29qN0J1?=
 =?utf-8?B?YzBRYUpaS05ja083aVlHbFVsS2I0K0NHTGQ5Q2xvU2tQU0t6ZHNLRTBKZmg4?=
 =?utf-8?B?b25UeFQ2VEpLUE9SVWgxWm5mZFRiUHQzdXJXZ29xM3NPbHc2M2MvQlJBVjln?=
 =?utf-8?B?YjM1ZTJlTDhzYk1jWjFQaGVmR015VFMzdTRtOHVCUm5OTGJsWldrN1l2WDJs?=
 =?utf-8?B?cmRhZ3VhS1JOcHk0T0pyL2pPbEFLbmFqZjE0b2E5eXhQUVNDV1B4MHhUWGds?=
 =?utf-8?B?NFBVTFArZzhZQXJOeWV4Y2QrLzJ2TnhWMlpXRG10MEorTWM5d2NIKzJSWmVH?=
 =?utf-8?B?SU1DYmhHc2ZFRVhNNmpHdG9sUjFPWU5qTEZFTUhKUlByRlhYOWlPcjBqd0Yv?=
 =?utf-8?B?UWRsUFROYTJrVFBvNDgyK3g2SmRsYkkzbGJnWnpEVll5Ym5BK2ZDaXdjQkN5?=
 =?utf-8?B?S2pHdUtiZGRnUjExVnBiVnRVSzBjZmtyMmFFaVliTGd2d1pPVDEzTzF2bloy?=
 =?utf-8?B?OE8rcGR1YUhqaUt0QmlNOE5MWkQ0cGlaaFcxbDRWa2NFQ2dGVnd1S2NqZHVJ?=
 =?utf-8?B?eFZFaHFYOS9UV25UZDE3M1JCWDV5ak5KdktxQU5QeDJReGhDd0ZVNXVyVlZq?=
 =?utf-8?B?dUVIdG4zc3l3N2pJVGNmTE5wVFJHM1NDcFRLNVl4RldYZUFRcllzbWR5MTBW?=
 =?utf-8?B?eWlHU2tHOU9KSk43Y3JNajA2ZzlTUDRWZ25YeUdUNFZxaGRseHEvbzdiM2Ey?=
 =?utf-8?B?a3FTQzVxbGx1bGEvZ0VMUFhFc0M1OUNkellxWXBrR3RZR00rV3kyd29qVTZu?=
 =?utf-8?B?ODhiZUdWUFloT205OWNsOGtzSHl4QWlTTzJBaGJwUEN6Nzc4am9pL3R5S05C?=
 =?utf-8?B?bmNlUFY1ZnRGaVFGYkpXblpxbHdmZjA0eStFNlo4SC9nN2p5MERJQ0srYzh1?=
 =?utf-8?B?UTZiZVV0d2RUdDN4QnhXM2Z6c3BINFhaQnBlWXJnb0VCRmNqVThoQWQzTlpw?=
 =?utf-8?B?QmlJR3NwV3JVcjNJcmhxL01neWd1aFg2TXdkSEpDZno3UEY2aWlSVnFIZnAx?=
 =?utf-8?B?K0Y3NTU5SlIxVDVIak1sOWQwSkQwMTZWdjhJN080YjY2bGtuNkp0SGp5L1U1?=
 =?utf-8?B?YkJVT0tQOVQ2Yi9weUdTZzF6U0ZET2JhbGZWWStST3hOMHE1SDU0T0pOcEVG?=
 =?utf-8?B?S3RQMDJiZEQzVzA3MUdSQisrRWFyVTlFcXNmaGxtY29KcjFWdEQ1ektGWkth?=
 =?utf-8?B?QVJBSUxlTU5Ta1lWRHV5dk55TXgzenZIYnlzWndPVW1tSTFTUkRCcEcycTlU?=
 =?utf-8?B?NkxkdGZuUnI2SHB3T292TWlmZVNaajJhMkZIM2t5Wk1ySEc0aXZ0K1hCSHFY?=
 =?utf-8?B?L25LZFhScXUrTHhuNHhFdUg5Nm5pTXRuVTYvcHp0TC9GSmhEajJta3RSSCt2?=
 =?utf-8?B?bUh5OG1DSU9QRXlpWnZTSzNsS04xSFZEZHprR29wT25lWDQ1eE9KTnJLNkVX?=
 =?utf-8?B?TllmZnlsMHBSYWVCZWlRR3h4dGxGRFFUaFUxTkdKZWxCaXlTQ2paSEVZUDZi?=
 =?utf-8?B?ZnZrb0VyUEpIRE4rMjdkMjl5SVFpZTBKUE9MdmN3a0RMNDJFdU5XSnhhakl1?=
 =?utf-8?B?bVZ1bmRmeFJ6cm5VYW5lYlNVSVdoSVJaUmlTRUtQSkFXdlNlRTRhR0diUFdO?=
 =?utf-8?B?MEVNTUorNHNGUVVhbVlPWmwrUUJUTFFCSkJMUWZKYXhGemdYWTRVei9rUWlX?=
 =?utf-8?B?Wno0L3k2cHBmWmMxNVFuVUw2YWNJanAwSkRDdi8rK3l1ajI0OFdyUDlCMCs1?=
 =?utf-8?B?SHVhS2RoOW9pS3g4Y1B1K1RXRDZXODdZSC9xRWgveW1RUG4zOExhb2tIWTZM?=
 =?utf-8?B?YmJFZU9TMkJxSEcwTFZNYWJlY041ZnV4K0MySWduajNMM1ZpOGc0ZDY3K2tw?=
 =?utf-8?B?ZHh4aEhSRVJFR2tyMm5aTmtwakQ3Zlg5UjIvdGxrK2hUZitBamt0TmZPSnBo?=
 =?utf-8?B?WDcxVExJemcrTzJkRmwwdmtqS0ZkYTlPRndFU1RGc3JncUp6TU1XMGM3TmVi?=
 =?utf-8?B?VklIZVQ4L0c3SXNiR1pURzN1SWUwRURlVCtwQ2M4N0JyaGpqMjByRUlpRGdZ?=
 =?utf-8?B?dUxUYytGZTJZQzl2UXZXRnFsOUplTFBTNnJhZDhOaC9yaGkwZUVzOWFoa0lQ?=
 =?utf-8?Q?yr1NR7MCK3tS8DENbRsPQyc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bed620-c3a5-48bb-bd73-08de2101cab0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:07:51.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk/Ha5a3DCgVsG83x1Pri+B2QFFf3u+SBe/9pfhPU6niySpK9NqSD9FrgZWCxugdo6c8OYEzeYPk9O6Tog5PsDqP523hoJwfHMr0MTXsMfysgPu5UktYvWc9Zo8BogRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7097

On 11/8/2025 12:06 AM, Peter Zijlstra wrote:
> Add a randomized algorithm that runs newidle balancing proportional to
> its success rate.
> 
> This improves schbench significantly:
> 
>  6.18-rc4:			2.22 Mrps/s
>  6.18-rc4+revert:		2.04 Mrps/s
>  6.18-rc4+revert+random:	2.18 Mrps/S
> 
> Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:
> 
>  6.17:			-6%
>  6.17+revert:		 0%
>  6.17+revert+random:	-1%
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Adam Li <adamli@os.amperecomputing.com>

Please see the Specjbb test result on AmpereOne server bellow:
6.18-rc5:			0% (baseline)
6.18-rc5+patchset:		+5%
6.18-rc4+patchset+NO_NI_RANDOM:	+6%
6.18-rc5+revert-155213a2aed4:	+6%

Could you please explain a little the math behind success rate
(sd->newidle_ratio) calculation?

[...]
> @@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
>  			break;
>  
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> +			unsigned int weight = 1;
> +
> +			if (sched_feat(NI_RANDOM)) {
> +				/*
> +				 * Throw a 1k sided dice; and only run
> +				 * newidle_balance according to the success
> +				 * rate.
> +				 */
> +				u32 d1k = sched_rng() % 1024;
> +				weight = 1 + sd->newidle_ratio;
> +				if (d1k > weight) {
> +					update_newidle_stats(sd, 0);
> +					continue;
> +				}
> +				weight = (1024 + weight/2) / weight;
> +			}
>  
e.g: Why 'weight = (1024 + weight/2) / weight'


Thanks,
-adam 


