Return-Path: <linux-kernel+bounces-836163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6116BA8E99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D93B3A38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF32FC007;
	Mon, 29 Sep 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BEIRWpjq"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021085.outbound.protection.outlook.com [52.101.62.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574931A9FBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142633; cv=fail; b=AWrFj4QXkU5VauOQl33U30u/6fEpXo1Bo2WWQrlSuIstqmHfXF9+Zp8rwqt908dR2vb/amdxOOwiXmhUv2I3xxAjhuWRXVLu9kq7HWR5htHMaQycyNF+lEm8tzJm9yGF4+i6cbb/Qa+cqWc99vkTjoSETm0hLr7CsfBGMQJago4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142633; c=relaxed/simple;
	bh=8p5A3z0UnNLA4F6f/hLJ/luh56x69YrDnvlCqOPALH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jrQ9E8udeeCQ2QzWI1XMNR1DMkYKdJWImPKiQirAWjMZnwfgn1dZK14tZIsteQOAjmF9UXfec50GlD10Gg4oG/BJdsNpFaNWDIYBwcpUcex1hLK7knT+XdgFMfz3+GHu1bCWww4sZgx8hLgj9IHfCOJLba4S50LLBPiv/CtPOpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BEIRWpjq; arc=fail smtp.client-ip=52.101.62.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL2NC1bTFac5bHf/e2pHh2YOUjHKtblKYky9xJK6oVoHO6Mk5KsPR0HdvGR5KRrvsYj3UatWIEDP3HZZbBqrBpyxwlEPaKjjXtlSCZR3qTHPeFlizeA73XUJMmT+/sluYTzygbyqWs5dg+w0dG2pwlZvflKQTcwanMpD7IKlgNAvaozhyTn8jBeoeCQv8+w3SCbLImg1JTJsOOnNisZOWcWOcmbfl4D+IgtpTGswHCLpzlnHxgKTYY/9uZtJDM403zkUpJh1OcWvVCJyiJte4qn+kPoHQ5z4qsUCytORIBXTnoZWOa25OF8I2WHAFwrb8fkRC+L5gedYPGocHPPdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9zbyJKNgeFVSBCywhRkh/hBd7iwZvZo4JH51j3L62o=;
 b=SgaAl5SwDZHuBI4fDPXHHWN8tZl7pBAce0b3XsKfwlDYDQNby3Ik6Q9hUy+q0vJLfpx2mh+4fPuSc2EDeGQbhhTfJpjXsGLpH9kLw+yjkQx/8SauDh3Yq/0TUDxe+dsJV2LTAR2wFFV3idvKSLjq28mVzcS7AnhE4a+e65mDSydBamiQc1JQAYoE3GUeefX+in/pmB9OlAgC7Uze/q9AcbBmKd2ZGZ5uK5KdPCwkrbtn/5MVK11335G5ajG7HlTEF0CJYd20wXW8p/q18ePXNmuH0x8kcQX3Ey3pVGWuXaoDUsZXUf2T4JxMxj1bwP0p/m3TVaIEZ/9bZkCDo0i6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9zbyJKNgeFVSBCywhRkh/hBd7iwZvZo4JH51j3L62o=;
 b=BEIRWpjq0U6MkZDyrCMNsWuqabR2G7QDo+SjDGNCUl5oLDoKsqIdYIsLYDJThK4zeQ9rqFXtl7Ys+XYwtEfYP3xAGhmqR71ok14l43StW0njxozBgP1KKSZTJ+fpdarid/AbUWmDZyYimVmHKl6e5u7pN2kGjqvI/DLPqrpvpHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 CYYPR01MB8385.prod.exchangelabs.com (2603:10b6:930:bc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Mon, 29 Sep 2025 10:43:47 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 10:43:47 +0000
Message-ID: <9c332c5b-83d9-465c-b02f-6648af9a9fae@os.amperecomputing.com>
Date: Mon, 29 Sep 2025 18:43:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/28] sched: Set up LLC indexing
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Libo Chen <libo.chen@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
 Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
 Len Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <959d897daadc28b8115c97df04eec2af0fd79c5d.1754712565.git.tim.c.chen@linux.intel.com>
 <baa45b9a-d8ef-4652-a3c2-83596216fcb6@os.amperecomputing.com>
 <1ec61212-24d5-4147-898a-f93c03c6ac94@intel.com>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <1ec61212-24d5-4147-898a-f93c03c6ac94@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|CYYPR01MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c4421f-6e58-4725-bc10-08ddff4511d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhYekJBRXlWUWVSUlBQNGd0VXF4TmJPUUxZTzk4K1VlQVZwQzlCSndPQlp2?=
 =?utf-8?B?SnBZaHhjQmVIb01Yb2pzeTVQbkY5N3MrM0gyVWcwbmZnWUZkM0NPaUY2eWxC?=
 =?utf-8?B?TmJBTzU3T2tqZ2dLRWlKaUw1Smo1cEJuY1hiYXhBcE1XT29xK0J1NW5CSmdr?=
 =?utf-8?B?dk9GT1gveVV5ZjVBRDlpQitaeDdlVXdha0ZHT1ZmVGY1NjcwaSt3ODF2N3F0?=
 =?utf-8?B?MmtiVE51dU4zTjIrejNSYXBPOVBSdzBIRW9wRTIxa1FvdnhweDVlVm4vSC9p?=
 =?utf-8?B?ZG0zaXRUTkVTMDVNcjBmcjNINzR3R09kUHppcnArWGVlWGROZlFzNWI2TFYv?=
 =?utf-8?B?ZGw5bnVvVHpFcEZ5Mi93b0l5V3NDVktjYTJrdEp1RG53bWh2ZURwakxLdHNR?=
 =?utf-8?B?WFNoZWhrWFF6NzYxb0g5UGp1RFo4M1I1Mnp1cEFCYWMwczVhdnVzOEw3cm9N?=
 =?utf-8?B?WmNMNng4aTVERkdZeDVhNGFFV09nczIvOW56TWdSNXNjejlPQnRURmlZa2sx?=
 =?utf-8?B?bWFWT1JQb0RvaHlZemxrUU5MYjFMdWJpTjlMSHZUejdqdVpUbTRJanB3Ni9w?=
 =?utf-8?B?U2RGTEJHOFU0U05DWW5wOUtDQjlIZmczT210NlBYdTFMWnpVcmxRZWVPY2xw?=
 =?utf-8?B?Uk9Vc251MDc0clNJeW9zRW5MNGtBbE0va3V2Q05QS3RDSGU3SGRUTUd3ZzBE?=
 =?utf-8?B?dHNYOVA3cXhEU21aMEQva05ZVmtwaGw4N2MrdmppWTBnY1ZYd3pRSFJPV1F3?=
 =?utf-8?B?UDVFYlo4YzRRdysvdzNWb2xoQXdMSVliUTBmWU5XMTlUWk53cCtLMTdTWjI1?=
 =?utf-8?B?WEVYdWdvUHEzTmloemRLM0lrNmgrMGNmeHZtbGpTSGhKK2JiWTgwRUNaRVZX?=
 =?utf-8?B?ZkVFbGZGTlFKYmdxaXR1MHVDODNOczdWbUVTUWxIUUhsUEx6YU5CRFlsZkZL?=
 =?utf-8?B?N2Zyd2VDczFuUnNLQjZkeUs5alkrd1F1c0VNNFBFczBlVG5WcE9vOXdxY3hw?=
 =?utf-8?B?WThKWCtSOFc2YTJmQXFTMkR0a09VVWswcjR4NXMzOWYwb2s3VTJPcnZyNVJO?=
 =?utf-8?B?Z25vRDB1VEVZVzhOTzQ4UVV6UTFWMk4zSFZ6akxHRDRmeHRyU2c4WWhmSG5K?=
 =?utf-8?B?Zit6VUdGWjhEMldzSmZ4anY2SlJEWmVTaFFUTWcxa2pyUTd6bVBhU3g4QjND?=
 =?utf-8?B?S0UzTEVKZUpoZXNuT1FBRVJleXNodDM0dFp0YlFMQ1JQcm1LaE5Bc0gxLzZx?=
 =?utf-8?B?dmZOOEQ3dFVJWldEU29GOWZkc3ZQZHRmN2ZpZnFudm02ZTRabmR3d1NISFhu?=
 =?utf-8?B?Nkl6bmF6clkxK09kd2YvcTZlUkI0a2NZQjJlK2IwaUxLN0t1Z3dwTjFWYkNj?=
 =?utf-8?B?U0dDTmF4Q1d0dVN6LzBjQ0xJOG1HM0xDZElHekZmNGtTWm1OSkdpQ2N2dGxL?=
 =?utf-8?B?cnlETHB4blBXVnE2c09jMDVyTzdtTVF1RTI1dUZ2b1JEeFd0NktaeWRkRC8r?=
 =?utf-8?B?MURCVWhQTExxekNrVDRSdUtvcTNOSm4wT29rNHo1QXZ0cy9LbVROWWNLUHh6?=
 =?utf-8?B?dWRFMS9UNFcyQ3JSbFI3ZGVZam5RbW5PK0xQNk9BWkFKV0tidENvL0pqbWky?=
 =?utf-8?B?VUdwUmdhQXZyeXV1QU5rcHRRenVSY055RXZTY04raVZpUlhFaHpwT2lBL2U1?=
 =?utf-8?B?clVFRFpTN1VXVE8zNkc2TVNZeENmYldWSW13blR6aWJTNjQzT1pFL3NGR2cw?=
 =?utf-8?B?WnZ6M2Fvd2ZyL3JUY1V3SVFpK2Noc29Ma2ZqWGorVHYzNnNhRmE5bzVOZm0x?=
 =?utf-8?B?VllLWEp2SXJ2bUhBR1ZtQnhmTTZyUmJSellOdWRodSsyL3JoUUhIYlQ1Ry9F?=
 =?utf-8?B?SHZpT3ZIWGVUY2Q0RVhKdzBHbHR1cWYrdXh0WlYvTVppalRiSnhtaC9HamV6?=
 =?utf-8?Q?AGQWuvCkxAuTc+rx3JO+hayWAPcECm+j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmQ5Z1ZpQ3NmSFVnMS81Z0d6bTBZNW5pcWtndVpHeEZZNjFkbEd4L25Xd3V4?=
 =?utf-8?B?NHU2YkJwTnJWc0k0ZWRxaVNuUkppdUo5MmZIMVJaNlVXN3ZlYXIzRlVRb0RQ?=
 =?utf-8?B?TlorUTdDci9zWVdSSmZwWlVFaHZoQTdnLy9xeUoyOER3eURONEc2SXJQYXA4?=
 =?utf-8?B?dUlxbFpqQStFbGZqLzBvZ0dscm56T0hrQVF2cSs4UWJFNWk2U3pWOEIyRHJ1?=
 =?utf-8?B?dEIybXg2L0IrWnpMQk1CU0VnQVh5TEYvU0NpNWtEWVJPbEdndFkvWERzVTNC?=
 =?utf-8?B?MnNQeTZrYStLMjV1N3JhVjVaZlpEeWNuQ0prMXVZNXNLWmEzZVloNkI4ejNy?=
 =?utf-8?B?cnl2bXRRdEtvQzNKdWtwTEs3ZFVkblpFekFkYWU4NFRZdnVEQ25zWHZUdzNr?=
 =?utf-8?B?RlFOWnF0UUxMdlQxaFJlMVZCSnNHUEVjdndPN2JJU2x0K1RJSE1xNEFyOTM3?=
 =?utf-8?B?Q0RDOHhpblltQWwzRjAvdU54RUpOTkFwZ0cyTnZJM05FTDJKWVBhU3BNT0J3?=
 =?utf-8?B?TnpIZDRmaFRBZk1HTEl5c2t2a24xU3JTMDBORHVpbjI2dlYvNzdMamdLSmpH?=
 =?utf-8?B?ZysrY3dXaEFRcnZVYVdROGZ4RlhiQU5GWUswR05scEtHMG40SXZESEdGMzgr?=
 =?utf-8?B?K3ExNml1MnpEd3ZMRHora2twQk1lS3N5MHJIN1lJSm5DcGRIdHVrNTQrMnhy?=
 =?utf-8?B?bGVDa3R6dEU1RzRsRmtkMjlwMG80bkNWc0JhY0ZGd1Q0aCtDZjMzbEZQREtq?=
 =?utf-8?B?dmI3MThYS3IrL3oxRy9QZUx1K1Fvb2dRRWNBK0FpaFNJcXVCbTFHMXRBekk3?=
 =?utf-8?B?U091blBXQm9XZGVGdm13N2toOFFQbHAzV1RBZVF0WWNsbndiakZNNVdXTUhz?=
 =?utf-8?B?UmhiVG1Kc1FNZkdyVlNYS0VQNHpkYnNIUzNxd1gxV0xtekFhcGhGeEQ3akJ0?=
 =?utf-8?B?NTZUOUwwR0kwWngzU3dPbEVSTS9BdWNQaDNJY2R3N2JCWmVwSEw3dG8wMW5t?=
 =?utf-8?B?Um56VzdiSlozTXMydnk5ZnpIVGRGNERFMVJtek04dUtnQjhicW5xdjRWSUYw?=
 =?utf-8?B?OWN3UGdqQlFHMnJaM2twQ1MzL3hrK1JWNzJuVk14a29nbUo0NDMwL0kyemZZ?=
 =?utf-8?B?YU5mY0k4L0FnVVcwM3U5VTFkdzdPY1NPd2VDaExyeFY1RTd3Qm1abGQrNndO?=
 =?utf-8?B?Sm0xZUkyTkc3Z0lKRkUwTjFtVktVQXltNEtlYVJPRks2c3lJMSs5K0xUeUs5?=
 =?utf-8?B?bHNybytnaHU0OWFWSStrOFEvcFd4dnREZHp6TE4yK0liTTBlMG1qY1NYTkNQ?=
 =?utf-8?B?a3h2OXJDVWRWTDA5eHVXRy9MWGdSM1o4bGJMNW9ZM2lMdHpIK1RrZjBSRWlT?=
 =?utf-8?B?LzZLYXRnVEFrbEw2TVU1TzBYQS9FV21YcWRweVplZjFPb0c1RmVwSVoyRjhp?=
 =?utf-8?B?aHlRWUNoVWpYQ1Q5SkloYUYrOTlVTndTWHo4UC9GSXVCS3VXRk1KSHRuNXdG?=
 =?utf-8?B?YmM2eHFqQ3NmSng5ZnRGa0wxNHdoOTJqZ3ZuMWsxZzlYb2ZSUVRaUS81NDlK?=
 =?utf-8?B?c3MyLzJZY2tqVzY5emJxNDNVWTNSTys1cWZ0N0RxQmVaZDBxRWdQQkF6MlJG?=
 =?utf-8?B?SnVVbjZyQnQ5bTVZT091TFprNkdJaWhrcjZ4KzJqOWQ0Y21tZmxMRkszRG1M?=
 =?utf-8?B?ZFR1alN3LzRYMmtNeWp2ME56UkxEUDBYQiswOXdjTjd2T2hxR3Q3SUtmQjR6?=
 =?utf-8?B?QlMwNkd1V1RPY09IYzE0U0dDL0dVQ2l2TFdlR0NEZW1KeTFFZ085NFcxVW9x?=
 =?utf-8?B?MUVkelJDd2FPLzUrc1VjczRvSTRTTkZSMkZaZm1ZN0RLaHB1UlVnTEpOTHYv?=
 =?utf-8?B?WDU2RFBEYkRIYzkrNmljNHlPUTdldEJDV3A0TVk4RGxOSmdaNmlwaHh4U3pR?=
 =?utf-8?B?N2J5U1Zob015QXFhdTlxWitDaFdJSTlFcDd5bm9mZFNsUVRsbUhmWmFkQy83?=
 =?utf-8?B?TkprVVdydXgxK0loaitHZUZCdjdpNTVZUk9DMnpsTXNaMTRFRzltNWozanp4?=
 =?utf-8?B?dC8zTk0rNWRVdHNOUzdYNnVjRlg2WkVBWGkzZXliM1p2OFJHTjNtY2RpZ2RF?=
 =?utf-8?B?czlHTGhtK29tam5nb2wwb1hRall4UWtibUZXVERyWno5UThDUzBnWW84NjY5?=
 =?utf-8?Q?YRxbf485fixTVasPRC8TR0Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c4421f-6e58-4725-bc10-08ddff4511d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 10:43:47.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNxEFRdEFvOt9mq7GU8rhnu8CeOvxCv2zaZ7X3K+oWcYnfgVTyLg2wiLiKUZd0/B0hYzsrdyMU+q/Jx++q+EAh6Qr2jvb9fzH4rb0wrXMu1NMnnTZXdQBYZ5Qy88X/DK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8385

On 9/26/2025 9:51 PM, Chen, Yu C wrote:
> Hi Adam,
> 
> On 9/26/2025 2:14 PM, Adam Li wrote:
>> Hi Chen Yu,
>>
>> I tested the patch set on AmpereOne CPU with 192 cores.
>> With certain firmware setting, each core has its own L1/L2 cache.
>> But *no* cores share LLC (L3). So *no* schedule domain
>> has flag 'SD_SHARE_LLC'.
>>
> 
> Good catch! And many thanks for your detailed testing and
> analysis.
> 
> Is this issue triggered with CONFIG_SCHED_CLUSTER disabled?
> 

Yes. With CONFIG_SCHED_CLUSTER enabled this issue will
not be triggered. The maximum sd_llc_idx will be less than MAX_LLC(64)
since we have 24 (192/8) cluster domains.

>> With this topology:
>> per_cpu(sd_llc_id, cpu) is actually the cpu id (0-191).
>>
>> And kernel bug will be triggered at:
>> 'BUG_ON(idx > MAX_LLC)'
>>
> 
> Yes, the sd_llc_idx thing is a bit tricky - we want to use it to
> index into the static array struct sg_lb_stat.nr_pref_llc, and
> we have to limit its range. A better approach would be to
> dynamically allocate the buffer, so we could get rid of the
> 'idx > MAX_LLC' check, but that might complicate the code.
> 
>> Please see details bellow.
>>
>> The bug will disappear if setting 'MAX_LLC' to 192.
>> But I think we might disable CAS(cache aware scheduling)
>> if no domain has 'SD_SHARE_LLC'.
>>
> 
> I agree with you. Simply disabling cache-aware scheduling
> if there is no SD_SHARE_LLC would be simpler.
> 
>> On 8/9/2025 1:03 PM, Chen Yu wrote:
>> A draft patch like bellow can fix the kernel BUG:
>> 1) Do not call update_llc_idx() if domain has no SD_SHARE_LLC
>> 2) Disable CAS if domain has no SD_SHARE_LLC
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 8483c02b4d28..cde9b6cdb1de 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -704,7 +704,8 @@ static void update_top_cache_domain(int cpu)
>>          per_cpu(sd_llc_size, cpu) = size;
>>          per_cpu(sd_llc_id, cpu) = id;
>>          rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>> -       update_llc_idx(cpu);
>> +       if (sd)
>> +               update_llc_idx(cpu);
>>
> 
> OK, that make sense.
> 
>>          sd = lowest_flag_domain(cpu, SD_CLUSTER);
>>          if (sd)
>> @@ -2476,6 +2477,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>          int i, ret = -ENOMEM;
>>          bool has_asym = false;
>>          bool has_cluster = false;
>> +       bool has_llc = false;
>>          bool llc_has_parent_sd = false;
>>          unsigned int multi_llcs_node = 1;
>>
>> @@ -2621,6 +2623,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>
>>                  if (lowest_flag_domain(i, SD_CLUSTER))
>>                          has_cluster = true;
>> +
>> +               if (highest_flag_domain(i, SD_SHARE_LLC))
>> +                       has_llc = true;
>>          }
>>          rcu_read_unlock();
>>
>> @@ -2631,7 +2636,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>                  static_branch_inc_cpuslocked(&sched_cluster_active);
>>
>>   #ifdef CONFIG_SCHED_CACHE
>> -       if (llc_has_parent_sd && multi_llcs_node && !sched_asym_cpucap_active())
>> +       if (has_llc && llc_has_parent_sd && multi_llcs_node &&
> 
> multi_llcs_node will be false if there is no SD_SHARE_LLC domain on the
> platform, so I suppose we don’t have to introduce has_llc?
> multi_llcs is set to true iff there are more than 1 SD_SHARE_LLC domains under its
> SD_SHARE_LLC parent domain.
> 

If there is *no* SD_SHARE_LLC domain, my test shows 'multi_llcs_node' is still 1 (true).

Looks it is because the default value of 'multi_llcs_node' is 1.

build_sched_domains():
	unsigned int multi_llcs_node = 1;

And this condition is always false since we have no SD_SHARE_LLC domain,
therefore 'multi_llcs_node' will not be changed:

                        if (!(sd->flags & SD_SHARE_LLC) && child &&
                            (child->flags & SD_SHARE_LLC))

Thanks,
-adam

