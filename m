Return-Path: <linux-kernel+bounces-776892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD10B2D2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5ACB685725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82EA218AB4;
	Wed, 20 Aug 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fOBE3Z27"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2124.outbound.protection.outlook.com [40.107.92.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7BEACD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755660936; cv=fail; b=g3OKaHusGijlTAfzRRgEsGkUWGIXOVqC+KWzG13vDQ4srxXKzjyOYSiEfB3P8i5hRXqO+e3HI4dk9JU1oxbE0XOca97kGLpmFX3wfLSOv/h0U2A4xUiIw9eY+KyaHGvxOpD9UbfVUGkBXykfKMa4it5Y/MURjh6Eq7jzIpeawY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755660936; c=relaxed/simple;
	bh=bc+SilFoYbjiVgQxgp5vEcki2LW3XX8TwZ5Md2rQzXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb5XqBl0bdkKuyTd85IFk7kCFJxQBcj3FyRdc2RPA1I1YQkPXIakT3FCVzMQB7vjWlYSx1ogfIavHU7tEfl5xhs41ffIG1FYMukmufRckq3kwHRPintCQSL5ux+MXVIElHULP1k/8kRpURlZjaiGb16XxECvXhw660SsbQXDRHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fOBE3Z27; arc=fail smtp.client-ip=40.107.92.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZaMx1KNKoe3muyJwPYTe2+iITfCUjJCL7RFGZqg2r39xL8yAT77db72S7lAit4GoVQpup7eG+2VHmyQF09Yaje47QY9W0DCDah+cgkOn7pZBhhQQxow6GIjCdyTCEkx25KBHXA3g0MTfdVL3hTkrOMNWf4XUecJATTbT51Ik0Os1B7WDoq78CQMHMlE0wMFnuXXsB9wSLtDC44vWZCjmWcTbG5Eze1a8aP6vTnqeW33Uw/g/Xbsn0jUnWys26Se0vM+Vo0txqIqXsTGLeQXkUEDH87od6lZEhGRigXcGkaBmo+8JgMHZd7vvHVI0gk0z4gEFe0+sijmwflMJEXibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0m9WLDs0pUa/eYI5Ectma+u9CedrMjRKNB3nO0C91E=;
 b=pkKvab+gbJGLT/dkUYIejxAl8vrt/VEAlEH2+WJArKCxrWUExgnYmowTBZz86IiNF20MpSE9JyuzGDUnl6QWIMQjDzB00MjtLTpC/5Ly8UMMdzGW/bWwYfqarwN6TBbl8vPjRlz7lJ+4JMsU4nvmklXG+0VMT0Y8D53XVRXk/KqozYUf7Pst6GhbaICNounjq8WE7p7T9aG0LopgTB5ZyR+pkuHDYvQ10F6PnFjIFw62zBX/1wLtExtOk9VSH1kht5xsRf/v/cC+5jY5gLiTxim14/41xwtaSUVT9GlYqrzQ5wx8iH/Xnu0VXzFEi5bzQOnUbAZoPcf3eRpF8kA/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0m9WLDs0pUa/eYI5Ectma+u9CedrMjRKNB3nO0C91E=;
 b=fOBE3Z27S1SUHeaC14omuW2Y711qavErVaOwnHAK4PbGCXnQJCKS/7yayhbDR+peEu6LafSPvLOh2ZSKw2n00cL8Vw0T/6jSEIo23pA2Sv5OjThUpyzD0q0A115I04uIuGWYQkByM01GK6mEoMdV9rRok2PTrbcghepEZDzHbXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 DS4PR01MB9411.prod.exchangelabs.com (2603:10b6:8:29d::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.23; Wed, 20 Aug 2025 03:35:29 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 03:35:22 +0000
Message-ID: <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
Date: Wed, 20 Aug 2025 11:35:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB
 CPU
To: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|DS4PR01MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f97205-9149-4180-ed4c-08dddf9a9810
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0hlamRicC90Vzc2R3RHdS80bnA3UkRHNXZjdEI4bytRK2NKTmlRcWtTL0pB?=
 =?utf-8?B?ampodHR3SUtmL1RqaU91MXB1YSs0cVI2NUVUcGR6cjdxYkhwczRTcVovSFRE?=
 =?utf-8?B?SjhScmMzR1U4WFliV0VVVjNMeE9HUGNCWGZ6Y3I3NDZ5d2xRR1oybnN2c1lV?=
 =?utf-8?B?d3lnTVYzWHdGK1RKc0EvZVpIcEhIYVJwMVJTYnQ3R3N5dHJYQTExbWZGSVJR?=
 =?utf-8?B?bUhEbitBQTNZa242MHhaMVlrb3lRQnVGR2pJQ0VDTkIzbVVzbTM2OE14TmpH?=
 =?utf-8?B?N09YWHA1Szk0bDgrR2xFYkZHa0daZ1doYUt1eU5ZVHQ4aERVR3pWeUxSV1Rh?=
 =?utf-8?B?MkQwRlcrVTE1eW56cVMxV3NTN2dmamFlMlo0QllXQ2NOK0l6aCtpanMvY0Ey?=
 =?utf-8?B?VTR3eHpJK0F0cUVLelozbW54d1pEWkNuM1BwVXhmbTJFdnU1QmZCbDVpVUFB?=
 =?utf-8?B?eExIUklIZTNiZGQ5emxzaThvZi93YkkxK2ROUWxzVSthMk1HTnlITFNYTlZS?=
 =?utf-8?B?dFhXb3JIYS9EMTVuMmQrbUVrNFNjWmpJUEl4Wm8zUU8wcEFzMmRGbHd0TzVa?=
 =?utf-8?B?MmdNUkVrdU5ueWVOeXdJUnZwM2I4M3F5dTNtWEY5a1ZvU3JpdzB3V0tGNmJC?=
 =?utf-8?B?N3N1SnNleE1PMldaV0dOMDNEbHo0M3dLdmZrRmdwWFNkZklxZnE2TitHZ2Rm?=
 =?utf-8?B?RTBwNlI1ZDQvaW5vTmVmaXNjZDBQWTFhbVhFWDVYUW5ReGFycSswK3RvTE0x?=
 =?utf-8?B?UEhMWXdVRVpZQkNmV2J6bXVoNjArdzEraGpvdTMrTHBrRk5maFV1cnJac01D?=
 =?utf-8?B?d2UvRHBzMUZVVEMxUTJRdm5pNDdrRkJnOHplYVBDSE55NWVON0pXbUdzak94?=
 =?utf-8?B?VkRFTjdLMFZRTFJIUEQ4aHFkd002ck81Vk9BOWIrL0NhMS9XRmdSckJZeUtU?=
 =?utf-8?B?NFBuTTYwMFhaa2l1SFk3WmhlTzRhS2JERUpYMk5ZT1dydVdFYXJFRXBlMlFO?=
 =?utf-8?B?M0RoSzhtZW9TdkhhdGdZdTFaZW0wUTVpS0ZnRytQUDRLR0xTdVdvUWtBWDR1?=
 =?utf-8?B?Q3I1SXlneXpvb1VjQ0wxNzJTUWkzRjN3MENCQWljdnBnaThwV0t6MG81aE9a?=
 =?utf-8?B?cENhTmwvZnlSWGljZVpaVU5yVkU5bFJqM1lYREk0VHdRMlMzMjk4dGxWNHFG?=
 =?utf-8?B?aGF1dGx2Vko0d3lNNG54QUxrWjJkbTFVK3hpNGtYRC9VYWZiWHFUb0lvNFlC?=
 =?utf-8?B?a3NsQU0raGNlbFJUT3ZsUXpKbFBsQ0RjOCsvNWF4bXJ5NUlpWjVPWHdRK2ti?=
 =?utf-8?B?OENRV1hrSXRrSmtpSnlQbmFPR1p3aTdwN3VpRzkxRFlzVm9LclhLRzVYWFhL?=
 =?utf-8?B?dFZZWVBMT0pSU2ZKa0VaVEo2Z3lydituK0tnbzh1d2kvVjhFa0h1bURuellF?=
 =?utf-8?B?WUpRWGtwUi9OUXpDcDkrTnE1Y0l1NWpVaVRMczErZEg2dGd2U1pFVVBOdlVr?=
 =?utf-8?B?bS9uUEg4WWN3NVVNWnMvTXZPNC9scURtTlU4VE5sMFprT0tXd3dVNndQek1P?=
 =?utf-8?B?S0k2R0RKeGxoZVE4SUY0dnRxWWo5NkRUOVorL1NRQ3I0cE9xcStIaUl0SWMr?=
 =?utf-8?B?Ni9tUVVuWE1MQ1hMS2RKVCt2Z0pFMWtnTklyL1R4SFVqVUpmczc2NmJsSTNQ?=
 =?utf-8?B?VGdjMmc5STQ5SFYrcloybGxqODFYYkViUVpnR002MzVFZ2RoSFpxbTZNVXI4?=
 =?utf-8?B?NTZTY25LSFdoL3BxcWlDUDRSREhlSUtEakl0QTZRL01kczh2YlRtU1JUUlBw?=
 =?utf-8?B?dGxtKy9KeFp1OEE5QXlpZmM5eVhOUDNXMFVKZ1d3U1l3RzBoZlY4cElRUTgr?=
 =?utf-8?B?WmhjMnNWRlRDdXNKRFZiejluVVBWZmVBRTF4cmo1VXRDcFZtTTBOZ0phNkRE?=
 =?utf-8?Q?YMq11fxfRjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3VhL0J3d2VuVlJETUI2bEVKTnBOaUR4RjRXQ3JsZEpnNUJ1SHhuV05GSTFx?=
 =?utf-8?B?TDhOOWZwSEtwMExBSEZ4QzFxL1lDVmhBczEwSTl6MWI1ZFVQQ2N2dlc3SE5w?=
 =?utf-8?B?L29SYng0ZE1PYkFkdlZadk5kRjI0NUdaVVNUbEZrQmU1dkVVU3FOQURrK044?=
 =?utf-8?B?TDZneXU5a0xWMUpjTXZuSGNDa3dIUU40bDBVdllKQVlyM1c2RWRRVzBNSkNL?=
 =?utf-8?B?NU1Qb3JQbWpkc2UzY2VtaC9OZHluRlhoZHNQSWloNWFsWGE0M0NUUkhJTktZ?=
 =?utf-8?B?a3ZhWlJkaTRWUkZyc014dmRNL0Z3Qktxd2J1VnY1eU5zSFBDQlFBME1MaUdF?=
 =?utf-8?B?TGdMSm5kUkNqNVFILzZPcFA3djlVRFptQWR6K3EvQzZqWk1iZEJxdG1xSFJn?=
 =?utf-8?B?aFJTb3dqMnNoWksva3h3Q1YzSkw2Y1NESmhGZ0ZlcDhCQ0tTVFVTdkJIQVRZ?=
 =?utf-8?B?WE8zMHhXWVVoSld1NUpWcmN3VCtrT3YzWE9BZmM0c2RKRkdBcDYrUzgwZEQ5?=
 =?utf-8?B?dE9DNXp0Yy9DcWNHSUdTWDlaVUFTNWRLL05xU2xYeXArZ09XYzJ5UzJUMENM?=
 =?utf-8?B?WkxKUXl2OGFjVFU2T0hMcWdRbzFZVVR5WHQwRExHZGs2aXJIS3ZaRlBJR0lZ?=
 =?utf-8?B?Umc0R3dGRGQ5V0N5MnBYZ0JDS3ByRk9VS3k4VkNud3Npd0xXTGYvTGxrc2dy?=
 =?utf-8?B?ZUFJd1Z1eERpSm5acGNhdWxkMTdyWkQyTXdaV2M1Mk9US3ZVSWRNTXN4Wk1r?=
 =?utf-8?B?UC9QQmRPNW15ZkZpZkN4dWdkb2VnYlo4aElCNHlOdHdqMUJxYmo3YUMyMXdk?=
 =?utf-8?B?cHk5ckpLMUZON2Z3aENNTjByR09uMGVONzZFaWl6ZElkbXphRXhnTEpQckdw?=
 =?utf-8?B?NDBQallFZVd6djkyVnppRTU2OTBWY1ArbmtveWpvT1hJQzlkcmpoYUE1Y1dI?=
 =?utf-8?B?RTBTbXdzTlUrOHpkN1lGaVpTaWNWOUpSWkxSek9ZZkdFNWZKakNuNWdqZmJM?=
 =?utf-8?B?SnJuOStIVkx2UGpoMEJXM0FNVXlNQzJhRTd6dHhob3g1MUhsM3RHQXNmbUpX?=
 =?utf-8?B?U2RwNDRDOVV2S3BBL1JqT3JNWEdWRmdmSHFRQ2RwcHg5OFJXZ0o2L25ZYTFH?=
 =?utf-8?B?cW5ORWJZNzlzdmRaVEJVVlZDL2tHeGhuYzRTd1ZLR1NSdUVQZlc5clJXM0hy?=
 =?utf-8?B?U1NvZW5rOVN2UVA4bWFnOS9oZnRlaHJBV3FOaHRLWFdLQk9DNXJVRmNNNTE2?=
 =?utf-8?B?TStzQk1ZNnJ4eWlEN2tSaU9CWlFHOGx2bjROTkJCaDBNRDl4VHV4bG9vVmh4?=
 =?utf-8?B?bVJQRHBZZHFxMG1aRnJLOWMvbWkzenppOUE1WXptaVNRZUNIazZDKzVKUnB3?=
 =?utf-8?B?bmhXRlM2UVE5TUpheStVVjdiWU1HeVNIVW1hcTNHU3BqSDk5NFgzU0J2am9T?=
 =?utf-8?B?QVRYOGZGSmxrR3kyZDlSck8zaWdzRVc5emgyaFUycDJLb3FXQ2Z0Z3AzdCsr?=
 =?utf-8?B?Q0hLcklPMzlJakFEOXFWbHRiN0NnOXoyVytUOVB5QitEalZXMjNudHFTRFNC?=
 =?utf-8?B?UmRNTnhCTjgyaDRSajc0M3pPWHBHUkNNNkRQMW9JNXo2K1FDOWx1THdOVW51?=
 =?utf-8?B?V0R5eDJhZ0RwTEJkd2l5UmhqOUttbVpOQzJYdkZHWDFKVDVjbHBkb1pVaW9J?=
 =?utf-8?B?UVVkRm1JbmtFa2VBY3prcnhVRUNWRG9lVjVnOWZhaDlsdW9idVIwcEtRSW1s?=
 =?utf-8?B?QWl4N2dQemFmOTV4RlJFc3hBMDhBTTN6MzNjRk1TVWtNUUtMUkRtNlgzd0RN?=
 =?utf-8?B?N3pMMXRlSElPM3JsTkc5VnZ4N2krdVE3a3lydWFzN3htVVVSYytMais2OHkr?=
 =?utf-8?B?Sk95a3JhRFBOZDJOa2JYTHZrTXlnaDJWUlhVbUVoRGFlbVoxUy9PaDdmRU1h?=
 =?utf-8?B?Tm5IQTN2SFgxV1BMRGJ5VVN0bDkxQm4wc0lIeW1PVmZ4dmVpdk1xczZ4VDUw?=
 =?utf-8?B?V055L0xzU0taZkR4eGZHRWpVT25sWFlBd1QreTB4dGhIRzFZbVBMNlZjdFJB?=
 =?utf-8?B?Wm5rNGhmY25BV0grRk9WMitLM0JiTVpnU2FEa0RLYkMwWXl0Mzkwa2J2WVIw?=
 =?utf-8?B?UlJOSG9JRzIyQ3U1QzVaczVBd0R5ZFBCOTM4ajRsWHlleXBoQ3RhK09BRSta?=
 =?utf-8?Q?TnyIwuc/ugcbPDavpoB/E5I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f97205-9149-4180-ed4c-08dddf9a9810
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:35:22.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxXMjwSyjdSB6OpDz1BFYLSJSEglfSv4zadPr1YaBEG3HGC/cbkmkPT4AhsXrRLj1UJ5t3jVaowcUHLukmPGKwXtzGYStbFsOFgCvvGaXldqJ125Gr1EqvwgzeqmljAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9411

Hi Valentin,

Thanks for your comments.
On 8/19/2025 10:00 PM, Valentin Schneider wrote:
> On 19/08/25 02:57, Adam Li wrote:
>> A qualified CPU to run NOHZ idle load balancing (ILB) has to be:
>> 1) housekeeping CPU in housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
>> 2) and in nohz.idle_cpus_mask
>> 3) and idle
>> 4) and not current CPU
>>
>> If most CPUs are in nohz_full CPU list there is few housekeeping CPU left.
>> In the worst case if all CPUs are in nohz_full only the boot CPU is used
>> for housekeeping. And the housekeeping CPU is usually busier so it will
>> be unlikely added to nohz.idle_cpus_mask.
>>
>> Therefore if there is few housekeeping CPUs, find_new_ilb() may likely
>> failed to find any CPU to do NOHZ idle load balancing. Some NOHZ CPUs may
>> stay idle while other CPUs are busy.
>>
>> This patch adds fallback options when looking for ILB CPU if there is
>> no CPU meeting above requirements. Then it searches in bellow order:
>> 1) Try looking for the first idle housekeeping CPU
>> 2) Try looking for the first idle CPU in nohz.idle_cpus_mask if no SMT.
>> 3) Select the first housekeeping CPU even if it is busy.
>>
>> With this patch the NOHZ idle balancing happens more frequently.
>>
> 
> I'm not understanding why, in the scenarios outlined above, more NOHZ idle
> balancing is a good thing.
> 
> Considering only housekeeping CPUs, they're all covered by wakeup, periodic
> and idle balancing (on top of NOHZ idle balancing when relevant). So if
> find_new_ilb() never finds a NOHZ-idle CPU, then that means your HK CPUs
> are either always busy or never stopping the tick when going idle, IOW they
> always have some work to do within a jiffy boundary.
> > Am I missing something?
>

I agree with your description about the housekeeping CPUs. In the worst case,
the system only has one housekeeping CPU and this housekeeping CPU is so busy
that:
1) This housekeeping CPU is unlikely idle;
2) and this housekeeping CPU is unlikely in 'nohz.idle_cpus_mask' because tick
is not stopped.
Therefore find_new_ilb() may very likely return -1. *No* CPU can be selected
to do NOHZ idle load balancing.

This patch tries to fix the imbalance of NOHZ idle CPUs (CPUs in nohz.idle_cpus_mask).
Here is more background:

When running llama on arm64 server, some CPUs *keep* idle while others
are 100% busy. All CPUs are in 'nohz_full=' cpu list, and CONFIG_NO_HZ_FULL
is set.

The problem is caused by two issues:
1) Some idle CPUs cannot be added to 'nohz.idle_cpus_mask',
this bug is fixed by another patch:
https://lore.kernel.org/all/20250815065115.289337-2-adamli@os.amperecomputing.com/

2) Even if the idle CPUs are in 'nohz.idle_cpus_mask', *no* CPU can be selected to
do NOHZ idle load balancing because conditions in find_new_ilb() is too strict.
This patch tries to solve this issue.

Hope this information helps.

Thanks,
-adam

 



