Return-Path: <linux-kernel+bounces-783827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE197B33329
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 00:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF116481BE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA577246799;
	Sun, 24 Aug 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="LXAmgjfK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2070.outbound.protection.outlook.com [40.92.89.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8E12B93
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756074430; cv=fail; b=Z1F1o8CJCzTPDZ+bXlu+z197NVTe28N6EL4YdCbYeVLkDGXQjH6ONQFWBg6ETKdFa3EfFLN1BA7zSEnqttb504KDyMeDuHlKH7v4Pydc8aWvvk6UAdTrVsiITpGB1VvJNqTNdNmhpJbX8ANxODkTyN6cu67qL3zemb/QiRgdhdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756074430; c=relaxed/simple;
	bh=7lccVmI++z6L1obRkNvoTlAGMjUV1E6Ci72toaX3AeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtABvuAx4fWbj+vcWux+/N/3Ccl7pLcRIvDVS5Fi4iJwhwmbi2zPtYpjQH0h1MghwNnQh6WozTpWMTLGSBr0z2Uv8C9dOFYu3zCHhLDXvNBWlSLO/QD5ubsG+D/BaQdCoQZOYBYod82EonRHkA7yjK7U3L1zIPYeGudsgk+60hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=LXAmgjfK; arc=fail smtp.client-ip=40.92.89.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMWtz/u3xMmUfJ9XWppb2vGopMcrNg0YG4J0VAqb3wpfucyZHJtRhmnAI6rYDeZf8MU5TE8lKVgL0dDrz2B4oUEeMhUsngNa4nvI4Hf6Ww05tPBLUImrVdafaudxINCvkHjNS6OWVqR+By2wSwa8pmbF80HUwOSfMN5o+9BOCi90lltyaevXlOP+vVvKOa66szIhNlcAzi+cj11imoD9BU9X84Arrp7lcTuSfsedyvQtS0j35Lx54bLuI4KrhVGNSWhf9P796zLAke93WRoSXw0+8Ob8VHvQpLLJTpiWnMc4cGXX4M/8TdMOkYZlSX7QA9fy9kU1IfOfT18gEjXEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW6Txf5FP7IW0irCL1Kij5zButVznIRmliCoLJNyt6k=;
 b=G7C6hLH+q1h7O7/TG7ZvPD3LbIwImNF8jCdkTcjewMi19ASomfd02aVsvV+C79Ln4Oml1b8Hq4t7SY0tz+eFd9yUdnxMx5w9cK0Rc0eT+ZcmVLQO4ipC+hv8sUFTmLe9o9b4vDXO1zzuXNRgZzaaloZv6oGpFlz8mAd+pzC+y8B5mR5p/EIKSRh+GK02irewFAOC3SJinopojK5x5i40G8F5rsCAM35FaAylnXYD1+CZmTY3PP5hQcsm8MDqkSr5JbfagCoU9MVty4YmC1Pg6UMgZ4bn+L5c9zeHtb2n0qk6s0800q2OZMGROEU2GB2e5DeeUjlvyAdMsqH3bSMoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW6Txf5FP7IW0irCL1Kij5zButVznIRmliCoLJNyt6k=;
 b=LXAmgjfK8Vkw4DE4WSh8uVrlaSZFnYYWgF0lIHL6D91aHy1p1U9iOCCRV5B2wFETtVIWtmzdPSYTHhdgFt0f3ork4mj2cTqISaZ0UyLIkqnvwdOpbhU62o0mvlHmYFgNkKrFoWSt7mzqELtr7UxAUqi0SU8COasM7vqy6VSk/k41IEt/pMUo3mdolFDbnAJnBYTWbs+j7rifOt3ILFgfrIYHg0JW1P39zjUshnxWLXpwkqujQQmV5ytNNQOiIByS2Qle7Sgn+K+DkXxiFun52UVQLtCWTRh2z6l9Na1Qyo2LP3b6XG+H1Bsrv/pg8AJ+GYJWkXQhRlIfnlNjooxM/w==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by PAXP195MB1310.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:198::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Sun, 24 Aug
 2025 22:27:06 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192%6]) with mapi id 15.20.9052.012; Sun, 24 Aug 2025
 22:27:06 +0000
Message-ID:
 <GV2PPF74270EBEE3CE93E97610E2A869654E43FA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Mon, 25 Aug 2025 00:28:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To: Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Waiman Long <longman@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com>
 <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com>
 <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <088560f6-f85c-4938-9eb4-ef42b1276a02@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|PAXP195MB1310:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e3645c-1d82-4cde-3e9f-08dde35d5adc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|41001999006|5072599009|6090799003|23021999003|15080799012|461199028|4302099013|3412199025|440099028|40105399003|39105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHg4NkNTYlgxa1lCYjBDVVN6M1RxdmxzaXBNZ3hEKzk0cmxxa014VU50WU5M?=
 =?utf-8?B?aEY1WlRDZUY4eVk2M3gxNTlEVTcxWXROenZsZ3psK2FaVFVXZlFkck9kd2tM?=
 =?utf-8?B?SXkyVTVQWGtlK2pwcVU2am4wTlYwK0V1aHFwYkswTytoMTdnQmw1RGtNT2lN?=
 =?utf-8?B?R05TVWIwNzZabXZ0RnNzTjhkdEs1TDBjVmFrVXRPanN6VDNCc0Y0U0RrRXBH?=
 =?utf-8?B?c3pCRk16WS9wcmRzRHVicEI3S2ZJTjdzRXlMRGpNeDhNTlBibm15QVM0RlNX?=
 =?utf-8?B?NDlyRi9pdHExUkREWmEwL0RoU1VRWmNzWENJalU3Qkhkb0I1L2F0K2Y3dzBu?=
 =?utf-8?B?Nkk1SlYzdDQ4M1RxN3NWSVBrbXhheVRpRUJybmR1MWFBUGtFUURIcnF6cXdu?=
 =?utf-8?B?NG9IMmFwcjZ2dk94T1hzcVdUd0R2dlNkUElyYU5la2NHUTlzUVh3c0swNS9I?=
 =?utf-8?B?RTd1T2o5aWdTdU95ZW1nUU1GSGliRFFLQWRZck9DcGRteVpLckhMeVdmTWhW?=
 =?utf-8?B?ZmJnNlhQSENURjhWUFlmTGJsZzhIOHZKck9hNXRvOTZteUlwaVlsb3U0MVFP?=
 =?utf-8?B?ZjIvemc0ZlVNOGNQWXVjbHVkbVlnVFlLODhwK0xqM0h0eGF6ZDZxMnJ1aFdM?=
 =?utf-8?B?RWVPV1lkelNjYlRuTXNrWkpwdnc5M0s2b2U2MmJ6QlhUb0FjdStkeWNXSjRy?=
 =?utf-8?B?akJId0dwbU82MndkaE9LRGg4eFAvbEpzWUV0QUJoRDJXL1FRYXE0SkZmUllC?=
 =?utf-8?B?VE5KUEVZVys5RFZ3eUVKSHZvc0RvcW8zdW9BQzBGSDhTL3ZQdlN3MWVWdTRv?=
 =?utf-8?B?OTZPZmwvamxscDBZMmFObHNaNVl4ajlJUTQyRWxMVGNYMjMzMng4N1JhcVZN?=
 =?utf-8?B?aDVmZHRiSGRZZEt6RU1FYWxKWVlIekhYOGtiSmtJdFhHOFdWVjdESlQxVDRF?=
 =?utf-8?B?cjhPSGcvRFRBMTg5M2U5VTRTSGtXMXZPSGowTmdvb0t4VUhQUXhxTUpoTkM5?=
 =?utf-8?B?MjNCY3NneVIvNENHcHFCRFpZYXh2NEZIcGZzdkFVT2E4ZEpUSDV4cUU1c200?=
 =?utf-8?B?NmY3RDduN3A5UldEOG5MK1I4UWtXWGROaWNrVUpEMnVUWUkrVDNpVzFYcWFT?=
 =?utf-8?B?ajkrMkRPU3REQVhEbytoRFBsU21GMXlpYTVqMzNqc2FmU1RyUFFZTndtcHRM?=
 =?utf-8?B?VDZlOUlkVS9wVUFDUVdlWnZVOGRtdFdaVnFEamFQZ2hLa2QwT3huYUU5MTh0?=
 =?utf-8?B?U29CeEEzaU5LZGF4cUNnQ2ltMjFJc2YvYk9pL0YxcHBlNkVXY051UDA4YlJR?=
 =?utf-8?B?Mkg0cUpTTEpiV1ZZLzRTOXltODU4MWQwZXh3WHR3T1E5eW4vM0t2dDlTVTND?=
 =?utf-8?B?dCtLZi8zMkNEWlZIRnpDU2xCaGdubW5OMDJKTEpPZitxajd3Q1FEOFdPa2VL?=
 =?utf-8?B?M1VDWlE0TFBVNmkvenk0WHgwWWl0WlY0UzlVTmJ1dTZmRDdqODlyUVZVWGZI?=
 =?utf-8?B?Y1FzMkl4ZzVXa0xvQ1hQM29wZ28yVzh3U0hYTThoYk1jOW9Pa1VTSlZxdlhk?=
 =?utf-8?B?UXd6SVJCbWFDVVBPZWdzVGRsUFd3cm9PTDVNL0dSZDdQby96VGkxTURaVnV1?=
 =?utf-8?B?T3FlSitVRVVsTU1lL0t2bEtBVHJuN1gzRXVvTWJEREdOQmxuTzh3SDdjWFR3?=
 =?utf-8?B?a2tkVTNDS09RNmJPQlZ0VVk3cW5CQ1ZJdnBXekloakxRZk9oSTJFbFdqaStF?=
 =?utf-8?B?VSt6VVE4cXF4MjlxRVlBT251WDdOUnRUcWJGejRvU0dDSjVjUEg3MElwU21p?=
 =?utf-8?Q?wDHk/+cMjeeeg4l8u4ZTOHwpkN8OwQNX0306Y=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTQ2NVd0NDlnMzJoTlZ4N1BBRzR4Z2hJOU81Y1hnaW5hc1d4ZDM3ZUdlZ1lj?=
 =?utf-8?B?b0UvcDZITWRxOUFqclY4RDdvbjVDbVJjUGk0MjZnbWc3b3pyd3pzZ1NneFpR?=
 =?utf-8?B?QXpzb3RZdjhWakJKSjAvRnI5SUpvUnBoRXQ4ZmpqQThsRXZSSGJjRzVscGZn?=
 =?utf-8?B?bG0zK0hoNEpZcUxSKzY0WWxQYWl1Wnk3VE43eStsL0kyWFlwZnUybnpuMVBp?=
 =?utf-8?B?d0VhVEVNYktMVkplVm0wbWJmWDB6T1JDcnMycWpGQkNuSlZxcGxFdGY4bnhK?=
 =?utf-8?B?cWlSMjNMeDlNOEM4KzdLc2FIWE1DYndrVmswRkVIUTQ4M0pQZ200Z0NSa1pR?=
 =?utf-8?B?NXQyamZGS29tWnBSNXpPcmZWa0hjaGIvdld5YkhocFllR0psRXJ5YTNvTW9m?=
 =?utf-8?B?azhIeUYvc29mVHBsTkozQ0wwazkyMXRUMExuQXFTeCtTZXBLWGoxamhDakhi?=
 =?utf-8?B?N0dBb2pSUWUzU3FsTG1lcWFlT0RQTnFPcVVuS0tVTGxDRlhBTXY3QTZNVGhQ?=
 =?utf-8?B?RzRZdDZJdVF0NFFMUW5qVDcxY1ZLY0dIcnZSSFJmU2ZBeGtEd1cxSEJhdjdV?=
 =?utf-8?B?dlJzWEZhWjZpQ2U1SlBENU55YzlaMUlwaUlhQ3hPSURKcDYrTHFQLzMyYWhO?=
 =?utf-8?B?UzFmd0RlNzQ2T0l1RU55NEttcktRY0doNFBXMWFNYS9Sdm00WVBLK0V1Y0hO?=
 =?utf-8?B?RFE2ZkwrcUxnSFVOZG9MYmFLaVpVcWpTYkZyeUcySWNjTEpyM21Mdm1EMDA1?=
 =?utf-8?B?eURrTjJiMEFHOVptbjlqVG9uZEh5SEpPSGRQZUhFY1dFemVlbUpOYUFtamh5?=
 =?utf-8?B?QXBTc2RlNUlYbndsRjlIY2dSRHBVQTFYZ0NyL2NyemVFZXE3NHBpVElsSmNP?=
 =?utf-8?B?a0ozbkJibFNVbnJoSHRwbjJ3K3hZRDJueU9KUVNwWWg5Y09NYnpkZlJGeDZZ?=
 =?utf-8?B?TXhlWHBabWdCbUZ2L05xWi9EdzRiVm1OcG5GTEFudmpHbkU3M3FDeGNsWFV4?=
 =?utf-8?B?N3ZVV1hkbndCK0xWa2xKU2xrakVrT3lMd0lmaFE5T2R6SnZhZFNBeXU2TTFD?=
 =?utf-8?B?a0phenBOUmhYdGxSZ2VJa2lVZ1RYblZqUHVadFJXRnFGYkZYRWNCcnJ4K21Z?=
 =?utf-8?B?Y2E4aG1CZFdCZDhXUC91SHhJZ0hPeE9Lb3NRamNweUtJRTNJdzVuWG4wc0NX?=
 =?utf-8?B?OUE4b0NFUWtURXJsc1QwUmI2b3BKaTRnWVNYT0JpZGJpMklEYlZ0bjloaWg5?=
 =?utf-8?B?dFY4UE82ZVBEVnZMSUJ2Z0VWRTdGdkgya2gyaEJrUE5MWmRSYjQ5amE1MjRh?=
 =?utf-8?B?Qk5wTlIxVXNKNzhCanZpdWNxRGJpcEZtS0ZORFZwTTV1YzdQcjQ2bWliSCs0?=
 =?utf-8?B?VitFSVJVVktmcXZmeEtId3kzRm1sNVA3YlVjUnRMSjRGRDBpaWozTS9kQWFr?=
 =?utf-8?B?VmJxeFdWVVBiR3ZZUVU3R2tYMGswamRkcGhRbGRLT2t2OHprUkVnVExhTng0?=
 =?utf-8?B?QmFabzNKakltY3lneTh2NlhyV3k3ek9IOHNJM01oVkJLQXkxMjVCbDR0MldP?=
 =?utf-8?B?ZzlPb29JMVQyNjdiWjV1OC9RUFpoKzh4NVpNYXJadkk3S0dRQzNNY1p5ZURR?=
 =?utf-8?B?N2tFYk9DU0ZrUmVWZU9nKzdpR1VMUlN2NEJUTnUxdkhYVXAwK1hFaTBlOU92?=
 =?utf-8?B?QzIxajFVOU1SS0tWSmQxa01STlpLZkVKSkhDNmpDOVAwL1I3Vy83TStKUk14?=
 =?utf-8?Q?s+PUdIEeRjmkWomULdufqHGtE1AdLgU9E4O7xms?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e3645c-1d82-4cde-3e9f-08dde35d5adc
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 22:27:05.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1310

Hi Jann,

On 4/28/20 23:06, Jann Horn wrote:
> On Tue, Apr 28, 2020 at 10:36 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Tue, Apr 28, 2020 at 12:08 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>>
>>> Oops. I can update that old patch but somehow I thought there is a better
>>> plan which I don't yet understand...
>>
>> I don't think any plan survived reality.
>>
>> Unless we want to do something *really* hacky.. The attached patch is
>> not meant to be serious.
>>
>>> And, IIRC, Jan had some ideas how to rework the new creds calculation in
>>> execve paths to avoid the cred_guard_mutex deadlock?
>>
>> I'm not sure how you'd do that.
>>
>> Execve() fundamentally needs to serialize with PTRACE_ATTACH somehow,
>> since the whole point is that "tsk->ptrace" changes how the
>> credentials are interpreted.
>>
>> So PTRACE_ATTACH doesn't really _change_ the credentials, but it very
>> much changes what execve() will do with them.
>>
>> But I guess we could do a "if somebody attached to us while we did the
>> execve(), just repeat the whole thing"
>>
>> Jann, what was your clever idea? Maybe it got lost in the long thread..
> 
> My clever/horrible/overly-complex idea was basically:
> 
> In execve:
> 
>  - After the point of no return, but before we start waiting for the
>    other threads to go away, finish calculating our post-execve creds
>    and stash them somewhere in the task_struct or so.
>  - Drop the cred_guard_mutex.
>  - Wait for the other threads to die.
>  - Take the cred_guard_mutex again.
>  - Clear out the pointer in the task_struct.
>  - Finish execve and install the new creds.
>  - Drop the cred_guard_mutex again.
> 
> Then in ptrace_may_access, after taking the cred_guard_mutex, we'd
> know that the target task is either outside execve or in the middle of
> execve, with old and new credentials known; and then we could say "you
> only get to access that task if you're capable relative to *both* its
> old and new credentials, since the task currently has both state from
> the old executable and from the new one". (Other users that expect to
> use cred_guard_mutex to synchronize with execve would also have to be
> changed appropriately; e.g. seccomp tsync would have to bail out if
> the task turns out to be in execve after the mutex has been acquired.)
> 
> So I think we can conceptually fix the deadlock, but it requires a bit
> of refactoring. (I have an old branch somewhere in which I tried to
> implement this, and where I did a bunch of refactoring around
> ptrace_may_access() so that e.g. the LSM hooks for ptrace can be
> invoked twice when the target task is in execve, and so that they take
> the target's cred* as an argument.)

Hmm, funny while I totally missed your message at the time, thia sounds
exactly like what my latest patch does.

You may have a look, I would be curious what you think about it:

https://lore.kernel.org/lkml/GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM/


Thanks
Bernd.


