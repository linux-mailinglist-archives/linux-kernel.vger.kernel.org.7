Return-Path: <linux-kernel+bounces-876564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189ECC1C295
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097386E5629
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9B346A19;
	Wed, 29 Oct 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="A4cvzrUV"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020097.outbound.protection.outlook.com [52.101.191.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15370345CAF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752624; cv=fail; b=aHTrt5ev718utqSoNXrNx0Sn1pY/IU96uJVN8kTXa+wmox3imeMgZz/iE3FzKw8jB4LrkJwJy1f2jKHT+RJIk7jeubLHU63Z5qOXyUezv/+4WubvrtXtdAVl8Y9jpQTOdsAgV+6BZBaq2TEnmtPZ0FttVcCcJWY2IGyyHEr9WDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752624; c=relaxed/simple;
	bh=IC87kDAN493JK6rT3y7g1n/45W2Nm0b5V+2SuxkujC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0UHt/jsB6To9o8uf6YeXsuDNMw/x6lj8qt9kw5ofd+aMRbBhhICzlJhX434YpKHB/sFNrf1oPSwizAqUsAUtRIbelY6xuPuNmaUPzlXxvO8lHZzmjHOvDCMwVGklwGtvpiL017J5GohSQFYmj1S8taX+z1mmZf169o9eBx3WSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=A4cvzrUV; arc=fail smtp.client-ip=52.101.191.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTqlZva2K8oB3FtbvlhSae8VV7q6k/G3ByQl8F3pghah3xHblRZiWbTivgfXrcSJhEd3gZeI9WSR6xvLVmh0KAE41yUX9XOUBRKly5MvR26bP1hoXFSghqeBGemAgWMybhJb07KZ9DJNhX4kkG0LXzog9VwjlUaKfM2xnl0lmCNuO5j099xhwNdYOv6cH5CadXOyXGz9JF6tAYyHtcSYccU9yCmAY6hHOSTHrUu504fI7/g8g73A5cM2skJ3llz+iwPjIWMDXV4yJktLSBxUlxD5gWJELDE6t+uMw8PSMLe2G5bM9eFr0EqN251gdcJjaz6DCOJWHikQG9yz4SxDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZCz4pYtTMo+gy0ARc1UhMEiktnP+sdoeK3HALoh3Zw=;
 b=NHBHgG2MoLhPomet/YX6O2AUCMkaGzwXU52SEpH/MwyUn991DYq2GiNddqigEQlk3NM8B/6t2p/lnhtlKPEb25ioK3Ml7E1q/kwE49QGtTqr4IJNwQQQG2kCk3WsUog39Vco3aVCV/WpO5Vx0HN1RQVwGbtVPNtJoP6uLe1JDFIJIKki58nsJaVtkTItqaMhgxe0I9cgqc/z0qUC2ztlLH0BCWFrqQs9TqEc15k2KihpngDcaRmAwumcBwDoQbjh+XEgdhs4ZlCMAEDaxUc4e/fEVeyozo4pUCGDEx/8Dpiu+XKj9raj3GM8h69F5Vrk2d949QqYA0uYVecmtea4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZCz4pYtTMo+gy0ARc1UhMEiktnP+sdoeK3HALoh3Zw=;
 b=A4cvzrUVKVx4BWg+7kRxYyHADPnwUBnjjd855xgBKRTldlcQrJNroV8VNnJLkkc56Xzmde77Aq0WIvguuyGVwB5A9wx6QzsMyMuW7TGWEKcceUZIIonBPJ8UgB69dyfgJeO/v7vv9OPwRWNqHcTpRXZBUG2pTP5Dc9dS7sLH6SiWxOTY668107gJ5189jnEwtcKWDhS/tdecOpnosFUTYdkc8g4AbmM/hCZWiSEMDFKvHU2kCC2LBceHvFCuqWXK8wAOOodTo/bkHKMaAwvtAf+o/kydVOrJxUELfRpeNCxEn3mcH78fJvJwe+rqfVnmrSTaigUxIy9aw3HRixffug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 15:43:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:43:39 +0000
Message-ID: <9e37e99b-42db-43ed-bf28-6a606d42993d@efficios.com>
Date: Wed, 29 Oct 2025 11:43:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 05/20] sched/mmcid: Move scheduler code out of global
 header
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.592186000@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.592186000@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd5b879-153e-4d7f-557f-08de1701ee0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUhiSzlidjlGam43NnAxZXpYU3hYb0QwS21GemhyTGZrOUxsMkllcFJON0k3?=
 =?utf-8?B?VEprV2prc0pNMHV0THZ3Nzl1MXV4RU5nVGcxQmNsZHAwV28xdU85YUFRcjIw?=
 =?utf-8?B?Rzc2ZnpVOVJsa1JuRmFZLzBNcGR1YmdTcS8wUzZRZ1FBL2s2YUc0eEwxcWEw?=
 =?utf-8?B?OVBKOUFQd1grN3lwZGRLTjRjcjhKMWtIb0c2NHhuOGQ1dTR6TitjTkZTbW1W?=
 =?utf-8?B?T0dvVUtwdnJhTm1FeGJtQkxLblhJeTBWVlphNFpqRExQcjMvOWUrQXhwRm84?=
 =?utf-8?B?cTFhU3g4T2cyQkNHYlY2UXpzS0FuV3RKbjdMWWRhSzZUN1lyNmZlUzFpaEJF?=
 =?utf-8?B?eFN5T3FxazhSVnlXTDdTQ2p5bzNFclBSdm0wUys2U2FQQkJZdVVtRnprVjlX?=
 =?utf-8?B?cWlXNXhOZk9EaFYreGsrY0YzbzFNREl6cUlTREJWdWZ5d0VRTjRHV1NnbUZM?=
 =?utf-8?B?S00yQ1MwSjE1RkFLTlorczBnWi9FU29FMi8xeU1mMWcwQVNyMGthcnpwN0sx?=
 =?utf-8?B?UngwcS9vQXRqWnVpSGs2VmhqQzJrUEV6bEhXS2E4bjlqTmRWTGRRTzRnQjRV?=
 =?utf-8?B?N0RhZlUxMWxQZGcycU1oSFlNc3pjYnM5UEdUdFQwN3hQM3BlY1p5eGpQOExq?=
 =?utf-8?B?NzRqUDBkWlUyOXUvYUk2d2ZTSnhIeG5sOFF6Y2lWOGtEOVRIcmJjYndaL25l?=
 =?utf-8?B?cVU1bEk0V1owRlFWZ3dhTktESi9Ibzk5L0lraXVtQjNvWVpvSStRcXp6aitz?=
 =?utf-8?B?RjUrWGZSTFJVcXdmMkpaUVU4K1pzUWRRckN4c2JsT3VvV2RkL1NxKytKNWJx?=
 =?utf-8?B?djBXV2tucCs5OE9hM2ZjT3c3TlplSG5zb0JSeE52S1IwcldaZDdsWFFaN0RP?=
 =?utf-8?B?S2VnZURiWnIyNDZOM1hyb2JtU2o2UTVlTTZwN1oveGUyaEZ2eHM1TGVDLzQw?=
 =?utf-8?B?N2dSa3dXVFhUbC92a1pVek55dWJUemdHdTdIcGFMYWQ0eDdjU0hDTlNscUpI?=
 =?utf-8?B?MDYzUmNzaHQ2Mnk1SWNUaFljY2YxbDNJQk8rSnZhWWdMY01EbjBFL2NIaytM?=
 =?utf-8?B?VitoT1dQTGovcU5MUjFEcS9HRDZCSEVwa1hzY3lLVXpxemZKNXgyR2NHaHZp?=
 =?utf-8?B?SVhoMTBIdmdGdWJuaEZVemdmalhoaWYySkNSdXlmbXNuWkdrdENHQU5aM0pj?=
 =?utf-8?B?b0srTUNuUTY2WTF3bXZRbE1NdHhHK2lDSmh4UHpLbTFrdSsxMit1LzA0cHRW?=
 =?utf-8?B?ZFdlOU9aY0pPZ0t6U1ZHbW5la1pPRXRaMytKaXh3Rm5aQjlheTNvQkM0SU9Y?=
 =?utf-8?B?c1g5WmhLcXdCRXlCeHdONTN1NXpuQ3VLSm8yWnhtNDR4YWQ0N0lhYnp5VTUy?=
 =?utf-8?B?Tnc4VVQrVDZqT1ZTYkc2b3FyQmpuOHFlSVJ6VnNnU1dqaXJHN2ZTUUg5TWN2?=
 =?utf-8?B?eTk3NUU3NUtzRW5hdDFmS0RoRHpORzZxaTZjVzhxZE9HNU1hMkN6Q295VmVK?=
 =?utf-8?B?aXp1RTNUTmtqMHQzVEZZZ3Brd3I4SmhRNlRaOS8vbGVSdlpaM1JaM2ZrWmxC?=
 =?utf-8?B?TVNLUDkyRjJDVk5lcyt2eUhvWnNhRU1VbXpnbFZYaGJaSGZqRlJkSitXZUJG?=
 =?utf-8?B?cjF2Y2dGbFZpOUc2YVVEd2Q0NWNUOUdzdG9GY2tLVGVJd1IyQ0d2VWJ0S0NS?=
 =?utf-8?B?QS80ZmRMdFE5Zk1VVWp6Q3V3NnpraW9NcVdGNlBaTFBZdmxwbVRyUnc2VGxD?=
 =?utf-8?B?Wk9hbkk3SWdTcHduQ200N1RrdmtNeXFCWGhMdVNqWll5SDdGcVJ2Y0d3WlJy?=
 =?utf-8?B?SXVMSEtQU1VIanFZR2xMY21EYTBycTlQSC8rcE9ocHNBRlA2enlNcjNoazh4?=
 =?utf-8?B?S1ZLQUVDdGEvL0RuQjF5eFdKOGVCWklKR0t0RWM2ekxYT2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUl1ZWI4NkZvVWZGMWo0UzZ3RHFtY2puU3hycDJMaHovMWp6VWdKeURxbEZ4?=
 =?utf-8?B?ajh5TE9nUzhHaExQT1NqYkE2K2o3emFoOEJidUZvdWtpQXdGZ3BTVVZaY2tR?=
 =?utf-8?B?OWQzNkRHK29mZ3ZSc0tkVnlNWjBqRVViZzk4a3FzRGNLTzdSd3dQRHMzSTBa?=
 =?utf-8?B?ZnJHYlVPSVA3RXk1cGxEUFE3RXJlMHQ0ZnNvcTZtSmlqNHJvcExsU0o4czZX?=
 =?utf-8?B?VktpK2ZHUkE1OE8wVFE4bkY5dTdweElLbkJrZUloWWwzSHZrYStOTTdGUG5G?=
 =?utf-8?B?YzZDYUFmZktNZ3dMUVc1NmwwZFlONXdsL2l0YUZKb1dWSGNiWGx4NEUxM2xm?=
 =?utf-8?B?QXdWUmVIdkpiaW1oMlNXdUhUU09RdFRKMUsxdytGbE1ZajB3MytIM3JlYWVS?=
 =?utf-8?B?dkFGT3l5Z1RHcGF0eHlqVWlKVk9kYjhjajhOeXhhampUajhMZU9wQVRib3Rt?=
 =?utf-8?B?MkFSTDF4YSs3eXlmVGxzTGVTendudmNRS1htR1krMnBveThYWUp6aVJUSTMw?=
 =?utf-8?B?WXpxbU53MFRRN2ZJWlFST0dCWTF0bHRXMzhWTk1XM2ZwMUFnbzhtNHlOclVu?=
 =?utf-8?B?eVg0SlZSUXJFOThVZk9WQk9MNG1Zdjd2aXpBalNocmZiMEcxNTJuUVUxOEh3?=
 =?utf-8?B?Z1V0c2VGQzg2K2wydTVZSnNKeS9VRXp3cmFrczNNM2ZWRUkyN3R1T3lCNzgx?=
 =?utf-8?B?enlDVVFZV29kcHo5c2YxTXFydW5Zc3VWZU9KYWZTdU94SGR4R3J5cXl2L2tv?=
 =?utf-8?B?OHdnZk90TzY1ZkhlTmRmU05OcGF3Mmxra1E1UXNVUUU1SExHaFhyUHJERmNP?=
 =?utf-8?B?dXB6akJHSFNCWEc5bklLVDRVbzZLUlBmYXJueEc2SXB5N2pGMnlDdDU2cTVQ?=
 =?utf-8?B?RW9FWHNaWlJoK0ZTeWhCMWxvYzVBSGgzaGdScVNyZGsyL3NjTDFsd0ltOFpC?=
 =?utf-8?B?dnI0MmRRUGhJUXpITWRzY20xT0tsTVVmdFdpOEZBK1V3eDRaTFZUK3JwSWhC?=
 =?utf-8?B?bDh5SXIyTHVZcVNUSHVSOHM2S2tPWGRHNzFlajRBK0xML1UrMlhoSVdHNzlu?=
 =?utf-8?B?YjJkbzRJZUdIbVZLOGR6MnV6M1VUQ0IxcEx1TllOaklMTjFLME1seDgxUUsy?=
 =?utf-8?B?Rk50RzBsRjFIMmZjYmEyOVF4UTBHNnFWYzM5RjJ4d3BRU29oMktUTytkQnlN?=
 =?utf-8?B?Wlpidy9tdGJxRkhGRndTdmZ4MXZKR1pCaGRvbmczYXJLUnJKc2xlWDVkdnNt?=
 =?utf-8?B?WmQ3K1BMSGJKNXJBSVVmVC85ZHZZMlJjZG5KbWluNENlN1JLZ0F3RWJIM3dm?=
 =?utf-8?B?eGt3cFltN3cxVUIvWFhaWnUyaFcvdnJOVzVSUG5nWCszeXZlTXQ5N3hMZVM3?=
 =?utf-8?B?c1NKYU1wTlZETlJEM1JDbmg0TVlIaFRpZTNrc2UzdFlmQ1JkSld0Q2xyUDF0?=
 =?utf-8?B?OUd3ZHpDSGNPSG02RC9BWTVrdEdXTWZEVG5EQ2wvNUpKUXdJR1piY0Z5MWtN?=
 =?utf-8?B?VFUrK0tFYTBIN2NhaTBXOG5rL1JQVXdBQVhXR2JEMzc2MHBWVEJHVjFiendn?=
 =?utf-8?B?SHV0QWZqQjRFM1F4OVNqdjRpNEcxblBSWTJ6VUNmOFFGK0w0QVZDRmxrNTVj?=
 =?utf-8?B?YlBoZnFyRUN2cnB1WGZPbUtaN1hsdENjTHZkVmVuSDh3QVFrb1dUcXpLSkFS?=
 =?utf-8?B?QkVXQnc0U3ZDL0xwWGRPb3JidERkTXlEV3YyOWVHbmpXRnFod3pQQXY1Z3hH?=
 =?utf-8?B?S3FzbEhIQjRyT0ZNNEJDajZKcVN1RXZqQm41SzQvY0gxVnZUdUcrNmxQSHNw?=
 =?utf-8?B?VnZZTXZXd0FvZVRFT0FoQ2pIOTFOZ0F1bDc1MnE5bm02Rng3MnVTSUNxUjZo?=
 =?utf-8?B?Zk9HWGRRTlpUb3Jta3JQYVhhaTBPbitaVXlhdXUyWEhlSmM4ZkE3cU54T0Ur?=
 =?utf-8?B?NlhKcmtFcGxDejdOaXVaYWJFZnRTUzJrUk15NE5BVGM3N2NkdDVSSVV3TUJ0?=
 =?utf-8?B?V0ZPamloMjBZNXhYaDRZUEdEcUdHSVlEKzlvK0RIYUdEUnpTSXhVVzFKLzlC?=
 =?utf-8?B?YWdRWER1ZiszeXF0WWhaeTkwL3FrMy90Y1laaVJjdTZTQ2NRbXhaNDkzbjNO?=
 =?utf-8?B?Ny9MSGhFSDdGY3NuWVpGc25kSU5iMVFlQmE5d01xOXAxaWQ3R1NxRTNFMkxF?=
 =?utf-8?Q?WZ/dTKPTVnJQVAo21AaYv98=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd5b879-153e-4d7f-557f-08de1701ee0f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:43:39.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGjOLgVJdIhxkLTjAmLbxCu/rnQKOkT0izJZ2qmbMjfeSFkDL8Hm5BOhC8KZbUnNimvOLxG1CVFQIKRlSA0n62HN80N6Z5yuJ2afIf1Dg2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9044

On 2025-10-29 09:09, Thomas Gleixner wrote:
> This is only used in the scheduler core code, so there is no point to have
> it in a global header.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

