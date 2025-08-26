Return-Path: <linux-kernel+bounces-786852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0DB36C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46E044E014E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC1199230;
	Tue, 26 Aug 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZpGDavk+"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2093.outbound.protection.outlook.com [40.107.116.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AD17C91
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219967; cv=fail; b=ukn9YpvZGfEFGxYqsHLXA/lz9I/1FjyWM476HEy6spGPvo4BiRmvIT8SdVglZNG4NgaJKOde0KZnUnlbF4UetSNtoXi2G+rHHVsPELG+iPY17GGI3ZfQ4sYI6/u4oVzt6Gup8VpqhpiZR3oUV+FF1q1T5SWvsZumYkl3qn3YqQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219967; c=relaxed/simple;
	bh=0qeSRlrUyoJ8yLjwdl7HUnzSCn7s/2BcoC4Gq/8dd0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQQuhLwTbl5p+XcCmHz85lL+5d8Ywo2UJrmg0HRuBuADf+HK5TQI9b+k5V0UFdyh5VyRLOXi1M07nqVPER2sjdxUUx/V65tGHU+PW+ahPoyAyDnqOjwb+1rzTwSk3J5sMyDg0LiWU1woAB9XULyjgkQil4h9CBbOsPZpdBkSpRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZpGDavk+; arc=fail smtp.client-ip=40.107.116.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4ZboHqfc6DpQdoFcmEGZK2O5xvi9Uz2q3Sphj8ayXbLWEea9OkRTacwfxy+qcYZhmfZ9D2nHA9cj9jPs2Eu1q5oQRkUDUtaw9rHTdi/48ME2ng0weURMI/DmXPMb4+pq7ND+TA8rqqGc2Pm1/29nUeNzuMNFrLOYxu8ZE6SgNXA53y9rzUPCtq2Y10P6o6a/l39KxqjLFSkgsmBZgxvKLP6oLyZdclqA6r+fciE5OJWqlKONre0epwGor+xQ3y34UmPis+FCA7ofn/dO2SiyHLroo2if/PoZM8cAS/WA1eXPqSCSObKpoFD2qw3wnpKNoEdLt8mI0y2EbUIXx1llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roFX8bYv2ZQM7W3TUTcYliogTGCMC7Rwp8fVyccA9vg=;
 b=bytbd70eZ+D2hKK+GTVf18/SItey5FAKptIhBTaqIzRkDs8ziEqbNPnpQAZShSOLE0D4dhz90a0ldgUbITyQnBpYjNwB4JgRscMzHT1Bw4rEEUnZ+msSOBrkwk0ntHB18fjfFQDnraTFXNC8DC9F1b4Q7FY47apURUhmkvyJAMOL+q2ooS0Q5hzJXnhf3+Qcq1Eg/dx4kyCWqKMw4r7+L3YJDpUBDIrLb/WpyD4Y33YmymmwrhWZNx64Q/ELwi5js+NYnpjHVziteQs+lf4WarFVPhlyLHSaN+H78G8O25zMm1HZsSFuSU6CDHFT5BAOYLh9tveoKHE3ra80y1ao8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roFX8bYv2ZQM7W3TUTcYliogTGCMC7Rwp8fVyccA9vg=;
 b=ZpGDavk+UA4ZXSjCsLF9ixx4LdpuCVleInym6ux1gCTkMgKXLaZExJxHX6aiH/+pTslMTA62125QouvpUe/Qpcn8MBZRpJvyu4Ad3X4YXjnBYIJto++wc/4KjPtT1jpe65xrZ8WOklBkLVXavgSE7xLGMzziJESCyM7TI24PB8eVf0VE36TZx2DwFP2JGUV2WarVxXQkmEWelsGFOJYcsaAf06PKh3LmEycAnsJzoqZDJZOGaYvlaeT4MWXvPcA7mkQlxyj9+eZpkwyQTAyKlPXOy2yzz03OWxgiikjLX+N8W9462sqhiOlrhEvsP5lxi9Uy7tNpevF7i0inNdIckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10841.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:125::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:52:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 14:52:39 +0000
Message-ID: <e87fb53b-329b-44dc-a14e-e8c7a49d9adf@efficios.com>
Date: Tue, 26 Aug 2025 10:52:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 23/37] rseq: Provide and use rseq_set_uids()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.741798449@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.741798449@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::38) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb41766-24e6-4393-0905-08dde4b033c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlFpRkNLWEJSMHpSSVdZQkxvc09hdDBVdVY3bS95Z3o0aEZvcUU0RWRqL0lO?=
 =?utf-8?B?ZVZZWGlSYVpOQTZHUklZck5GYldSS1hvUlQwTXM2NU9jU0RtUTBSbHYxekg5?=
 =?utf-8?B?ZTF6bjR3S2ZydTQ4QVp4UEtOc0cycFV0T213bDRKb2JyLzB5Y2xlQU01S3dp?=
 =?utf-8?B?V2pjV29QcFRxRzRlOFpiaVdyaXZMZHdTMjVvMmF1WEpSYk85TjJVZlF1ME5U?=
 =?utf-8?B?WTZwcHQ4bldvcllnQVhJelQvRFJFdTF6UldETWtyb0R2d3ZxN3ZOaDI4aGp4?=
 =?utf-8?B?ZjZ3N1Fsczh6TVR1STZKNlYvVGk5VDF3bTF1T0JHeGJwRkg2aUpkRDlBb3pT?=
 =?utf-8?B?WmZNdmNId0g4VjhCSjN3dnpWNjhEQURoNkZLdmlpVlFqcmtqQ0JPdE1YNlY5?=
 =?utf-8?B?U3poYTZoT0VFbjRWRlczbnpVRHRuSjFxRW5ka3NQc1k4V2YxcHdHZk5sdzBp?=
 =?utf-8?B?YkF3WW1LQU13TktIVm9vb3B6c1huMVV5aHZkMFp3Snh4c0JEdU92ZCs1enVH?=
 =?utf-8?B?Nmo1S3hzVTN0UXBRQm81UGd1SGk3bUg3Z0NXeXJvVUx2ZExwT0MzWDdjOFJh?=
 =?utf-8?B?dDJUU3Vtd2lZdHJsR1d1emk1UVZyamF0UmRyMFFOaGtianl2SGJtOVdVVW1Z?=
 =?utf-8?B?YWdVOTBlbzVkNEk3RFhMR1FOVjVHS1pHV1RSSW5mck5TdFlqeTBNd0tXMDFj?=
 =?utf-8?B?Q09vTTNlVUhVNGhnRHg0aG5TR0hBZ2NOTE1QUnI1cThxU0Q1b0oyM1hVdU9k?=
 =?utf-8?B?UXlJeHhrUjk2M1UvVmZDaFkzNTltNmFmSVVldTYvYXJPOXRoM1F2azhsd0U4?=
 =?utf-8?B?QzlnVnRSTXZJWStUY3dUSHEwdzdBR0tGaW9rN1VIajNsdFZPSW40K2djeWIv?=
 =?utf-8?B?M1krUFVxK2s1OGV4WDNLQkVydGQvUXNyR1YzZm5ITk4xZFBuZll6bVpWVGJR?=
 =?utf-8?B?Y3Foc0UzV1FPTjYrY0Myejl6ZUUyVU5TS3JEZUUxcFNNSlVzUFpmbnlYdUtT?=
 =?utf-8?B?aklrL2lKS3JLSStYbmRnb1Q5aG9TMTBTekZuSVRNS2ljVVFITXNLdVRMWDZF?=
 =?utf-8?B?cVJucXZHV1NieGFsWTBtUEMyYnNjQk1NVkMrMlpqb1hQSXhROGpnME9YRGVl?=
 =?utf-8?B?cy9UbEZid2ZRbGpTMkJoUS9MdXBCb01HaDU0RE9tZ2VIOWRhRS8ya3FRV0Vs?=
 =?utf-8?B?b2lHcXBPSmpHREltUm1UbUxiOVhrczZYajZkbUN0b2o0NTdPNkRPNi9ERjFL?=
 =?utf-8?B?cWM0bjlGQWMxTnhPa2FRa3JjOWpPYjhjdkxMUkt2Y0R4YWp3cmR4S0kyZTI2?=
 =?utf-8?B?LzVTcXFGM0ZmN010MzQxWVhEREt5UmFBalRZb0ovOWwxZWRDRGNvVWFuT3Rk?=
 =?utf-8?B?amVYcGVyUXpNR0E0OElFR0Z4VjlYMWwrR0Vtd2plVGFDY2FyRmhjdll1cHEw?=
 =?utf-8?B?NWhRMVdJTWJGM0YzMjZWWXgwSUV0RnVySXU5Vi93R2wzMkhtQzlDTGU4bXFG?=
 =?utf-8?B?WGtnblhCL0VZd21xd2xnSkVRQytLTHNXSU83cGxHVTBoR2o3ay9SaUI1NU1Z?=
 =?utf-8?B?UStQRm9XLzBaRlp5TFR6SlMvNmZyR1gvU00wTU5nY1pxWGRpMmNmSjcwWmVa?=
 =?utf-8?B?djE1d1pKUW1ZanJjSHIxVXU3M0JQZ2t1Z3BCZTgxQ01VSVdPME9qRVk5a1B3?=
 =?utf-8?B?L1R5eFppeHVqZ1lTRk1CVTY2TXBST2JHWHZTVXh6b3J2RFdUbFVISkU2QUJm?=
 =?utf-8?B?dFRvUE5SVUJ5dk9hRy9mWTdHZnpJZFBOWEVkYVNoR1Q4enF6dTMySllET0Jk?=
 =?utf-8?Q?+Pq0owoXvYAZwX8+2Drv/e4E/TvWLr5qyAA+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFSd0l2RTVpbEgyTkl1bm9SUGpZOE5aVEI3anh4V3JaQ0phRGQvbXpOR0dv?=
 =?utf-8?B?V3dPUFNoMUkwaC9SVEZUNWNTL0FPOGFZeGYrL2lkNUpLMmdSQjNwbE9BVWJa?=
 =?utf-8?B?dHR1dk5ScHlYTDBzbWdrQkwrSVFRbEd5QlFDeW1BOEhubm42ekRmTUxRRHdq?=
 =?utf-8?B?aUw2SU12Ym5iNnh5bVF1UDJLSUhORUR4eTd3OTh5L2FDcW5XeGx6ODdYeklF?=
 =?utf-8?B?UUtIOUwwWDVTd2V4MUpCR3QzODVYYmd4dUJJRWNiRS9uaXJRTWN1WTNnaHdG?=
 =?utf-8?B?QmFZQlhHTmdhcWozaDRQMytWcVlCSysvNXl1VFpMOVpNTkJrS1haVUFtZkR0?=
 =?utf-8?B?bGtDWkt2dG81SGNTclZiSFVtWkY0d0wwV3pxbXBnUHNCMW9CZVN2cml4Sy80?=
 =?utf-8?B?dmtqdG5ObFpOL1Eza0NBNXZudGl2bXcvTWpTYXZKZlcrWGxDSCtYcnAxZGRN?=
 =?utf-8?B?R1lCZ1RaNDZTejVqK2hoUHNHL1grc1J5a2p0WnFXaDlNRkI1bkNoS0w5T0pJ?=
 =?utf-8?B?MFRydGI0QWw0QXpOYW1CaW8wVUVKSDJCS2NrMW14RVZYdW5PZTJUeDN2TCtE?=
 =?utf-8?B?VlU0TVNIRGlXSVFpMTVTQUlkVEl0Q1JTZmMxQ3Y1ZWkxSHZkZEdTRzcxM1A5?=
 =?utf-8?B?UlFYd1ozOElUMVkxb3QyVGY4eHVjTTZoRFB6b3kweTVmZGJLeFV3cngrS1NV?=
 =?utf-8?B?US8vZ0dMYmxpUWU4UzdBZjN2dit1Q0k4aTlBSDFMNkRuVW1XTzJ1K2NQVzls?=
 =?utf-8?B?N2pBNTlHK1A5NmN3ZzRCMi8wSS9lVWVZTHR5ankvYVp3QlBJYXY2ZXVHeDJw?=
 =?utf-8?B?ZDBhK0RYRzlRN01xOXYrRENDam02cEZnVVhOeXVhaUxVVW0rcUVVcnNQUWxH?=
 =?utf-8?B?aXEvT0VGQVVZZGxJNzgzdFNqOTFRR0RRb2xaU0tCL2xNaVlzVWhqQ2lTWUdF?=
 =?utf-8?B?ZEtKZmVvY1JSR1VUSVoxK2Rvb1lOT0gvYXBHOE1PSkJZclc3YzZoR2ljQk9G?=
 =?utf-8?B?Sk5QMklLaFFHOFU2RlZTMFlPVlNaczhhaVZ3Tis4cUV4TmVBc0tPRDY3MndT?=
 =?utf-8?B?SWxEZjhTSTB1TzFOYUNzVGlYSnZnUkVIL0l6VWJTUUg1M3dReGlsMzg3Njlv?=
 =?utf-8?B?YTlJWHZkSk5hWDY2Y0haWVozeHE3WmlIcVlJeFZBWnQ4eU1nMndmRXlDcU0v?=
 =?utf-8?B?eDE3eHp0Yzk1TU1LTTlkWjQydmY5WFlyRlZwTVloN1pZb2ZNWC9ySmRFeW51?=
 =?utf-8?B?VnhTTlp4MmFaTHAzUUF4Zy96U3RMbVdYZlBrdkRmRlpDbmEzUFRwZ2gxektu?=
 =?utf-8?B?L2pSR3kvNndpSTkxcUhqMkk5QUIrVmJwL3p2eG1PS0tQUzE0K25TNzJxbmd0?=
 =?utf-8?B?ZWcxR1dJd3RIRVNwUWtMVkVFVFU1WXpISlYxcU1DeXZjYUR2cWNJREF4bm1R?=
 =?utf-8?B?SG10blBBbEF5VWFsSFV3bEJOMDRkNkp5M3lDM0s4QnBtR2tlVm9jYlArTjJk?=
 =?utf-8?B?TVlkTGY1Nm4rVUNjYXhTZVpnVC96VW5VYXZPMFFZZTA1VkpmWEZwdmNqZWZv?=
 =?utf-8?B?SGNmWTJKMWVMeTArK21NTTM0UnZ5NjlkcUFSUVFHMUJJL3daNWlyVTNKMksr?=
 =?utf-8?B?OWtRVW1WeW9JYnU4UHpndXlPOFBwNFJBTHVaeXFTUkV4UVphRVlGd2wzcHBJ?=
 =?utf-8?B?ZURrK1VlZ2FJRklNcWpyS0pyRlZWNG1iMFRZVUpWLytacm0xdjBETER0K0JU?=
 =?utf-8?B?Y3pwbWdWNmxmWVA1QUUveHNuUHIxdVIyTkJUV3lZZEpiWkRqczRWbmZVZ1RH?=
 =?utf-8?B?dUtUcVg5aG9hRXh6TUNmeWxNd0hLdlVjOVlsbnpZd0VUMnZTZzN0eFlqNENx?=
 =?utf-8?B?ZUZlNHg3M09nVkZhMlVqa1ZnZ2dqWVdCcHl4OHlGRTVzd0g5Z1BvUlpDTGtN?=
 =?utf-8?B?Y1o0N3M2SFRFYnJxK0k1amtEdG5QenduVHh5dGI4T2x5aHNxTmdnVUxlWlB4?=
 =?utf-8?B?a21mbXNVS2hnWDhUSnRDOVJzdFNxRHAxdFJUZzgvblBtUGZnUmJST05Dd1lv?=
 =?utf-8?B?ZnVOTXZiUnhWczFDbGF0bms5UnJLM2NJT0hvTkxWaWJIeGZtMllMNWF3SVdi?=
 =?utf-8?B?Q0tSdXdRQ1EwZTFWeURBOEJMVnVhdU4vb1l4RWV3L3VLcVEwYXhvUFRWRXpS?=
 =?utf-8?Q?++5nywVyKc4dalfcHZxhjSM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb41766-24e6-4393-0905-08dde4b033c9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:52:39.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NwS88Lr4wgcqJuwje7VZAitHrxyF3k3FVN27ZNstZlgQpmrRfjC8KwDCWJmPOibNvsxrKgPr/nX8clNMy+BfaMZfocp3ZWEKLXaMEOf/JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10841

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Provide a new and straight forward implementation to set the IDs (CPU ID,
> Node ID and MM CID), which can be later inlined into the fast path.
> 
> It does all operations in one user_rw_masked_begin() section and retrieves
> also the critical section member (rseq::cs_rseq) from user space to avoid
> another user..begin/end() pair. This is in preparation for optimizing the
> fast path to avoid extra work when not required.
> 
> Use it to replace the whole related zoo in rseq.c
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   fs/binfmt_elf.c            |    2
>   include/linux/rseq_entry.h |   95 ++++++++++++++++++++
>   include/linux/rseq_types.h |    2
>   include/linux/sched.h      |   10 --
>   kernel/rseq.c              |  208 ++++++---------------------------------------
>   5 files changed, 130 insertions(+), 187 deletions(-)
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -46,7 +46,7 @@
>   #include <linux/cred.h>
>   #include <linux/dax.h>
>   #include <linux/uaccess.h>
> -#include <linux/rseq.h>
> +#include <uapi/linux/rseq.h>
>   #include <asm/param.h>
>   #include <asm/page.h>
>   
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -38,6 +38,8 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #include <linux/rseq.h>
>   #include <linux/uaccess.h>
>   
> +#include <uapi/linux/rseq.h>
> +
>   #include <linux/tracepoint-defs.h>
>   
>   #ifdef CONFIG_TRACEPOINTS
> @@ -77,6 +79,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
>   #endif
>   
>   bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> +bool rseq_debug_validate_uids(struct task_struct *t);
>   
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
> @@ -198,6 +201,44 @@ bool rseq_debug_update_user_cs(struct ta
>   	user_access_end();
>   	return false;
>   }
> +
> +/*
> + * On debug kernels validate that user space did not mess with it if
> + * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
> + * that case cpu_cid is ~0. See fork/execve.
> + */
> +bool rseq_debug_validate_uids(struct task_struct *t)

Typically "UIDs" are a well known term (user identity) associated with
getuid(2).

I understand that you're trying to use "uids" for "userspace IDs" here,
but I'm concerned about the TLA clash.

perhaps we should name this "rseq_debug_validate_user_fields" instead ?

> +{
> +	u32 cpu_id, uval, node_id = cpu_to_node(task_cpu(t));
> +	struct rseq __user *rseq = t->rseq;
> +
> +	if (t->rseq_ids.cpu_cid == ~0)
> +		return true;
> +
> +	if (!user_read_masked_begin(rseq))
> +		return false;
> +
> +	unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
> +	if (cpu_id != t->rseq_ids.cpu_id)
> +		goto die;
> +	unsafe_get_user(uval, &rseq->cpu_id, efault);
> +	if (uval != cpu_id)
> +		goto die;
> +	unsafe_get_user(uval, &rseq->node_id, efault);
> +	if (uval != node_id)
> +		goto die;

AFAIU, when a task migrates across NUMA nodes, userspace will have a
stale value and this check will fail, thus killing the process. To fix
this you'd need to derive "node_id" from
cpu_to_node(t->rseq_ids.cpu_id).

But doing that will not work on powerpc, where the mapping between
node_id and cpu_id can change dynamically, AFAIU this can kill processes
even though userspace did not alter the node_id behind the kernel's
back.

The difference with the preexisting code is that this compares
the userspace node_id with the current node_id that comes
from cpu_to_node(task_cpu(t)), whereas the preexisting
rseq_validate_ro_fields() compares the userspace node_id with the
prior node_id copy we have in the kernel.

> +	unsafe_get_user(uval, &rseq->mm_cid, efault);
> +	if (uval != t->rseq_ids.mm_cid)
> +		goto die;
> +	user_access_end();
> +	return true;
> +die:
> +	t->rseq_event.fatal = true;
> +efault:
> +	user_access_end();
> +	return false;
> +}
> +
>   #endif /* RSEQ_BUILD_SLOW_PATH */
>   
>   /*
> @@ -268,6 +309,60 @@ rseq_update_user_cs(struct task_struct *
>   	user_access_end();
>   	return false;
>   }
> +
> +/*
> + * Updates CPU ID, Node ID and MM CID and reads the critical section
> + * address, when @csaddr != NULL. This allows to put the ID update and the
> + * read under the same uaccess region to spare a seperate begin/end.

separate

> + *
> + * As this is either invoked from a C wrapper with @csaddr = NULL or from
> + * the fast path code with a valid pointer, a clever compiler should be
> + * able to optimize the read out. Spares a duplicate implementation.
> + *
> + * Returns true, if the operation was successful, false otherwise.
> + *
> + * In the failure case task::rseq_event::fatal is set when invalid data
> + * was found on debug kernels. It's clear when the failure was an unresolved page
> + * fault.
> + *
> + * If inlined into the exit to user path with interrupts disabled, the
> + * caller has to protect against page faults with pagefault_disable().
> + *
> + * In preemptible task context this would be counterproductive as the page
> + * faults could not be fully resolved. As a consequence unresolved page
> + * faults in task context are fatal too.
> + */
> +static rseq_inline
> +bool rseq_set_uids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
> +			      u32 node_id, u64 *csaddr)
> +{
> +	struct rseq __user *rseq = t->rseq;
> +
> +	if (static_branch_unlikely(&rseq_debug_enabled)) {
> +		if (!rseq_debug_validate_uids(t))
> +			return false;
> +	}
> +
> +	if (!user_rw_masked_begin(rseq))
> +		return false;
> +
> +	unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
> +	unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
> +	unsafe_put_user(node_id, &rseq->node_id, efault);
> +	unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
> +	if (csaddr)
> +		unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
> +	user_access_end();
> +
> +	/* Cache the new values */
> +	t->rseq_ids.cpu_cid = ids->cpu_cid;

I may be missing something, but I think we're missing updates to
t->rseq_ids.mm_cid and we may want to keep track of t->rseq_ids.node_id
as well.

Thanks,

Mathieu

> +	rseq_stat_inc(rseq_stats.ids);
> +	rseq_trace_update(t, ids);
> +	return true;
> +efault:
> +	user_access_end();
> +	return false;
> +}
>   
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -3,6 +3,8 @@
>   #define _LINUX_RSEQ_TYPES_H
>   
>   #include <linux/types.h>
> +/* Forward declaration for the sched.h */
> +struct rseq;
>   
>   /*
>    * struct rseq_event - Storage for rseq related event management
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -42,7 +42,6 @@
>   #include <linux/posix-timers_types.h>
>   #include <linux/restart_block.h>
>   #include <linux/rseq_types.h>
> -#include <uapi/linux/rseq.h>
>   #include <linux/seqlock_types.h>
>   #include <linux/kcsan.h>
>   #include <linux/rv.h>
> @@ -1407,15 +1406,6 @@ struct task_struct {
>   	u32				rseq_sig;
>   	struct rseq_event		rseq_event;
>   	struct rseq_ids			rseq_ids;
> -# ifdef CONFIG_DEBUG_RSEQ
> -	/*
> -	 * This is a place holder to save a copy of the rseq fields for
> -	 * validation of read-only fields. The struct rseq has a
> -	 * variable-length array at the end, so it cannot be used
> -	 * directly. Reserve a size large enough for the known fields.
> -	 */
> -	char				rseq_fields[sizeof(struct rseq)];
> -# endif
>   #endif
>   
>   #ifdef CONFIG_SCHED_MM_CID
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -88,13 +88,6 @@
>   # define RSEQ_EVENT_GUARD	preempt
>   #endif
>   
> -/* The original rseq structure size (including padding) is 32 bytes. */
> -#define ORIG_RSEQ_SIZE		32
> -
> -#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
> -				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
> -				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
> -
>   DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>   
>   static inline void rseq_control_debug(bool on)
> @@ -227,159 +220,9 @@ static int __init rseq_debugfs_init(void
>   __initcall(rseq_debugfs_init);
>   #endif /* CONFIG_DEBUG_FS */
>   
> -#ifdef CONFIG_DEBUG_RSEQ
> -static struct rseq *rseq_kernel_fields(struct task_struct *t)
> -{
> -	return (struct rseq *) t->rseq_fields;
> -}
> -
> -static int rseq_validate_ro_fields(struct task_struct *t)
> -{
> -	static DEFINE_RATELIMIT_STATE(_rs,
> -				      DEFAULT_RATELIMIT_INTERVAL,
> -				      DEFAULT_RATELIMIT_BURST);
> -	u32 cpu_id_start, cpu_id, node_id, mm_cid;
> -	struct rseq __user *rseq = t->rseq;
> -
> -	/*
> -	 * Validate fields which are required to be read-only by
> -	 * user-space.
> -	 */
> -	if (!user_read_access_begin(rseq, t->rseq_len))
> -		goto efault;
> -	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
> -	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
> -	unsafe_get_user(node_id, &rseq->node_id, efault_end);
> -	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
> -	user_read_access_end();
> -
> -	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
> -	    cpu_id != rseq_kernel_fields(t)->cpu_id ||
> -	    node_id != rseq_kernel_fields(t)->node_id ||
> -	    mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
> -
> -		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
> -			"\tcpu_id_start: %u ?= %u\n"
> -			"\tcpu_id:       %u ?= %u\n"
> -			"\tnode_id:      %u ?= %u\n"
> -			"\tmm_cid:       %u ?= %u\n",
> -			t->pid, t->comm,
> -			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
> -			cpu_id, rseq_kernel_fields(t)->cpu_id,
> -			node_id, rseq_kernel_fields(t)->node_id,
> -			mm_cid, rseq_kernel_fields(t)->mm_cid);
> -	}
> -
> -	/* For now, only print a console warning on mismatch. */
> -	return 0;
> -
> -efault_end:
> -	user_read_access_end();
> -efault:
> -	return -EFAULT;
> -}
> -
> -/*
> - * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
> - * state.
> - */
> -#define rseq_unsafe_put_user(t, value, field, error_label)		\
> -	do {								\
> -		unsafe_put_user(value, &t->rseq->field, error_label);	\
> -		rseq_kernel_fields(t)->field = value;			\
> -	} while (0)
> -
> -#else
> -static int rseq_validate_ro_fields(struct task_struct *t)
> -{
> -	return 0;
> -}
> -
> -#define rseq_unsafe_put_user(t, value, field, error_label)		\
> -	unsafe_put_user(value, &t->rseq->field, error_label)
> -#endif
> -
> -static int rseq_update_cpu_node_id(struct task_struct *t)
> -{
> -	struct rseq __user *rseq = t->rseq;
> -	u32 cpu_id = raw_smp_processor_id();
> -	u32 node_id = cpu_to_node(cpu_id);
> -	u32 mm_cid = task_mm_cid(t);
> -
> -	rseq_stat_inc(rseq_stats.ids);
> -
> -	/* Validate read-only rseq fields on debug kernels */
> -	if (rseq_validate_ro_fields(t))
> -		goto efault;
> -	WARN_ON_ONCE((int) mm_cid < 0);
> -
> -	if (!user_write_access_begin(rseq, t->rseq_len))
> -		goto efault;
> -
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
> -	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
> -	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
> -
> -	/* Cache the user space values */
> -	t->rseq_ids.cpu_id = cpu_id;
> -	t->rseq_ids.mm_cid = mm_cid;
> -
> -	/*
> -	 * Additional feature fields added after ORIG_RSEQ_SIZE
> -	 * need to be conditionally updated only if
> -	 * t->rseq_len != ORIG_RSEQ_SIZE.
> -	 */
> -	user_write_access_end();
> -	trace_rseq_update(t);
> -	return 0;
> -
> -efault_end:
> -	user_write_access_end();
> -efault:
> -	return -EFAULT;
> -}
> -
> -static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
> +static bool rseq_set_uids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
>   {
> -	struct rseq __user *rseq = t->rseq;
> -	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
> -	    mm_cid = 0;
> -
> -	/*
> -	 * Validate read-only rseq fields.
> -	 */
> -	if (rseq_validate_ro_fields(t))
> -		goto efault;
> -
> -	if (!user_write_access_begin(rseq, t->rseq_len))
> -		goto efault;
> -
> -	/*
> -	 * Reset all fields to their initial state.
> -	 *
> -	 * All fields have an initial state of 0 except cpu_id which is set to
> -	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
> -	 * unregistration can figure out that rseq needs to be registered
> -	 * again.
> -	 */
> -	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
> -	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
> -	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
> -
> -	/*
> -	 * Additional feature fields added after ORIG_RSEQ_SIZE
> -	 * need to be conditionally reset only if
> -	 * t->rseq_len != ORIG_RSEQ_SIZE.
> -	 */
> -	user_write_access_end();
> -	return 0;
> -
> -efault_end:
> -	user_write_access_end();
> -efault:
> -	return -EFAULT;
> +	return rseq_set_uids_get_csaddr(t, ids, node_id, NULL);
>   }
>   
>   static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
> @@ -407,6 +250,8 @@ static bool rseq_handle_cs(struct task_s
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> +	struct rseq_ids ids;
> +	u32 node_id;
>   	bool event;
>   	int sig;
>   
> @@ -453,6 +298,8 @@ void __rseq_handle_notify_resume(struct
>   	scoped_guard(RSEQ_EVENT_GUARD) {
>   		event = t->rseq_event.sched_switch;
>   		t->rseq_event.sched_switch = false;
> +		ids.cpu_id = task_cpu(t);
> +		ids.mm_cid = task_mm_cid(t);
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> @@ -461,7 +308,8 @@ void __rseq_handle_notify_resume(struct
>   	if (!rseq_handle_cs(t, regs))
>   		goto error;
>   
> -	if (unlikely(rseq_update_cpu_node_id(t)))
> +	node_id = cpu_to_node(ids.cpu_id);
> +	if (!rseq_set_uids(t, &ids, node_id))
>   		goto error;
>   	return;
>   
> @@ -502,13 +350,33 @@ void rseq_syscall(struct pt_regs *regs)
>   }
>   #endif
>   
> +static bool rseq_reset_ids(void)
> +{
> +	struct rseq_ids ids = {
> +		.cpu_id		= RSEQ_CPU_ID_UNINITIALIZED,
> +		.mm_cid		= 0,
> +	};
> +
> +	/*
> +	 * If this fails, terminate it because this leaves the kernel in
> +	 * stupid state as exit to user space will try to fixup the ids
> +	 * again.
> +	 */
> +	if (rseq_set_uids(current, &ids, 0))
> +		return true;
> +
> +	force_sig(SIGSEGV);
> +	return false;
> +}
> +
> +/* The original rseq structure size (including padding) is 32 bytes. */
> +#define ORIG_RSEQ_SIZE		32
> +
>   /*
>    * sys_rseq - setup restartable sequences for caller thread.
>    */
>   SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
>   {
> -	int ret;
> -
>   	if (flags & RSEQ_FLAG_UNREGISTER) {
>   		if (flags & ~RSEQ_FLAG_UNREGISTER)
>   			return -EINVAL;
> @@ -519,9 +387,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   			return -EINVAL;
>   		if (current->rseq_sig != sig)
>   			return -EPERM;
> -		ret = rseq_reset_rseq_cpu_node_id(current);
> -		if (ret)
> -			return ret;
> +		if (!rseq_reset_ids())
> +			return -EFAULT;
>   		current->rseq = NULL;
>   		current->rseq_sig = 0;
>   		current->rseq_len = 0;
> @@ -574,17 +441,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
>   		return -EFAULT;
>   
> -#ifdef CONFIG_DEBUG_RSEQ
> -	/*
> -	 * Initialize the in-kernel rseq fields copy for validation of
> -	 * read-only fields.
> -	 */
> -	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
> -	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
> -	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
> -	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
> -		return -EFAULT;
> -#endif
>   	/*
>   	 * Activate the registration by setting the rseq area address, length
>   	 * and signature in the task struct.
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

