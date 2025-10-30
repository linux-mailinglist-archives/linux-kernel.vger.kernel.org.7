Return-Path: <linux-kernel+bounces-878598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D07C21144
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C78188A8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768A37A3B4;
	Thu, 30 Oct 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nTUJUqgb"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022097.outbound.protection.outlook.com [40.107.193.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A431197A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839820; cv=fail; b=ZIodeMwA31rRb/UKLGmklu4L4YpzqHOP2dd1xo+aWycc+y6vyHX8sxWs+mXtv0gU7xrJ8xEvwza+nx67uY+ktY1y9z/dHUeVYIZ1nAoFdCDOuvNYbEHHpr2QQBitFYbiHFkc1YvTIrzUWdygqTaqMBWfGrSedFvNq70SDktE7UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839820; c=relaxed/simple;
	bh=zGqgMMleKegIx0gQ0Rv343GIatOfSlAm4PR7Qi5F+G8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BE5DUkZb7UidpC8yKzdnleaRK6mYxPsxg7G86+tMps1TssR7VjDLfON8wGqdK/rBEJaaB+CimWVEW5q9Ujo9n9OWrgjA3ah3WYUV0ZufNjACFQtij/Kihn75LyfH9olfnCcib6hTByld04S0W4+ft9/VohYa7tVgS/G34sjIIto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nTUJUqgb; arc=fail smtp.client-ip=40.107.193.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvK3qnlH5yoBiLtFFj1js6ASsJNKChJiuxhdoK8z907Ckl+TZ8VlCB8DF5wqq7xciDGWokwxoA9YT54DkKO4TWh4iaU+pb2ojdbB8p3+nQpX4qVeFn/AtuB/Z3fZ7aRmzpFOMtla0SqSZcowHD0LndOd36Vrg+qMVsXvu1RAX4ZI1gnGPUzyJPtk8mIm+L3HDBdGp6jfVzO7Brknp4yKWrvZrehdZt2ehNalWYSbz3RksYC2txvwB8TbiTHJW2cwDoyekyMsu8Y39omGsmxfL+VYSrSv6OMwBh2vSS4CorhtRUNpVyWzz7Tfqt/XjrrYOqHBOZyJqvG8dUrDVpAv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeC50+PMRh0++spFjVSJn2qC3+KZWi0r3+jGpcOxgNk=;
 b=N4f5BEm1qTbX0dCQduikYGGzzZTi9+/a7DSXHeF3J6M6+D9YBmKSbPIYk3LwTRmC1Vp5eSVUw7Wf+ZLAl+vEdrDhuclD+uG9rjPPokZz5puppfdpg9qFCK+Xl8obiWrLdCxYebV4QPM7uyZesUYH+i2jRVtpEZ37aJ9MwRySvcTUQDnSTbIHx0QChZo5emO/hdC4viwwzjpZAMlVHh8/FAiexi6z6RGhnt6zmuBnMXG5/oQ1Co6ncGGE2ksLVEkPNfpN03YrKiyaiJ5mXP++z+ZyjKnMa5Cse+Z6fEINR6n0AveS8DJxmZKEJWljSr0D67UPPQj6fYFd2EQogBvvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeC50+PMRh0++spFjVSJn2qC3+KZWi0r3+jGpcOxgNk=;
 b=nTUJUqgbGMQWLgY7AvmnhLLANVwxN0Kkuy/eyZ0t5kYL4uEguE5uNfU+3qXRZmxBiFtgj2TGDaCw1bQhOAL0QbhDrc+ROOxMSXrpQkUZRtsoGBDlHnecANVy6FieeGqLhRsFRxd5Cs+/2J6HWRZ3Au0YMKDtBB2WoyTYHgMy2Y0Q1/WH8z6KXwea2pVud44DG65PkqKrAatHqvdxpDHdTPoKVoJXc4gyZigAvMoGDshY6k+pmXkEd2tl5eMe/vgPopo07kBAKlID0gRS8KEWKFI4QR7UF+cO5JR/E+ocNWaRrJ7PcvTi/STpv3AmGznDp472Vz3sWQ8uGFo3Nz9QqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8775.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:56:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:56:55 +0000
Message-ID: <c20d4639-12d5-4794-a432-9fffcc1d9650@efficios.com>
Date: Thu, 30 Oct 2025 11:56:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 19/20] sched/mmcid: Implement deferred mode change
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.468663211@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.468663211@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d163d19-4b01-4b86-dedb-08de17ccf314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amY5YzNjRmRJd0l4V01LMjh5TFJaYTFiQU1PS2p1Mis3ak5BUDNLTXowZUhH?=
 =?utf-8?B?NzRHQ215S3FrelFnZjg5Wlk3UDdnU3ZGelVRWnQ1UUhvOENUT3pxZ2Jzb0tE?=
 =?utf-8?B?cGFRVEV4d3k2ZExKTTRnMlVIOXBIWGVNQmN0dTk0S05JZlBibVA2M3RFTWlp?=
 =?utf-8?B?WlpjZ1YyRnZVcFhDWDFuVGhOL1JENEsvaHlxNUR6ZGk2UHEzdzlOd2FrenJR?=
 =?utf-8?B?RmhqMG5DbnNXSVh4UnRHRkdDbkpEZDlScjM0NnNhdDh3d0J3akhaQTlRVndv?=
 =?utf-8?B?a2RnYUQ1K3o3L1A4aTYxNWRHcEZXeTFJWnp4eis3MVRQbHdTYXBEVWl4c3pH?=
 =?utf-8?B?NmNMZzlLOS9OY0txaVFsSUtKNTRCNWRaeldYZXhJaytWUFFNYW1ZTkhMeU1k?=
 =?utf-8?B?NHVwKzN4SThmcVd4QXo1RU1KdkphUWE2QXVrTDRmb01tVUMxL1ZFUVVqWWVM?=
 =?utf-8?B?dnJlS00zQXBBNWlONzFweFdXNEtqOUJiUEFTbkdJcis2U3ZGWEZmYmt0NGV0?=
 =?utf-8?B?VThWQkNZRFpNWjUrU0Q1UWFiZkg4ZC9pS3Q3MkJHR0RzckNVKzNXeU9vYU5Q?=
 =?utf-8?B?Y3NrUkNQQXFPZ1dUQmE3dW1sTjZla3hBNWd5YlZDQngzWmtmcHpkS08xbkZi?=
 =?utf-8?B?RlVBUnJZaXIyRGlPa1JuUzViZWx2bmVCUUNPRWFOcGJ2aEdHTVZONE9IN0E2?=
 =?utf-8?B?anJORklHZFM4THp3K2w1L1R1VkZ3cXBsN0xUd1ZraVJ2TDdoK21oTWluUm5I?=
 =?utf-8?B?QnZ0VUYwN2FDald6QUY3MkNXYnh1QWVBZmRjWHJnYWFuYzBrOFBQYktmM084?=
 =?utf-8?B?OFRVR3h5OTZBYXZFMVFPc09MYmdHemlZSk5QNTBqZXY5Q3M4bDVEbDNlUUgy?=
 =?utf-8?B?V3EvR3lpOUlsMFdOb0p3QVJIS1YyNVpnbXN1eThrTmpBbXFqTEx0dGk4TU5H?=
 =?utf-8?B?bFRSSmVSTU1mVkVqRDJPT3RDZWxheFdsVnpRNEVwS3k1SkRWdEdoQzB2T1Fa?=
 =?utf-8?B?NnptaXY3VWtMSDdNeEkySy9OMHo4RGEyZGJKaTJabGlnSHF0bnI4UGZIVmVs?=
 =?utf-8?B?V0QxU1FKWHRPcjloempaV0VlZVVueXZSbm5zeHNBcFJTaXhZYlJUTDg4dGd3?=
 =?utf-8?B?M1dNTmpvUitSMENza09MSHFLSS9aZVo2NzVWUnFWK040VGRkeTBPUFg0UWEy?=
 =?utf-8?B?Z1QyUitpZnEwYncxa3UzT0RyaVYyaTZTb3F6TTY2eWJJT3R2V1hrSTFrKytT?=
 =?utf-8?B?STRFRTJhVzR2eGFEU1I0Mm9DalhvT0dFUzI4bGlCdUIxU3ZMaWw2Vk40TC9k?=
 =?utf-8?B?ZkFoWm02M3o2TnMrTkxaU3ppSlkvVk16RUMxOXJjdGVBTGlGNEtKcE9YYW53?=
 =?utf-8?B?aU9mZEZhU3lZNGo1cXJPbis3MWY0NXJTWXRDaVI5UGpRV2Y1MU5Eenpienhx?=
 =?utf-8?B?Vk1YWjJZdmlUQlcxZ3dhNVhnckFVQVJDNkdJTUdzWHVMeG5SQ2JLN1MvWWFu?=
 =?utf-8?B?NS94V05vVEJNTUF3VjkvUXVNcXNYY3RYZ1crQm1Odmc1ejBzYVBLRXljS3JX?=
 =?utf-8?B?UENvdUk0bmp1VEZTZGljZy9OQkJjQUVqTENVVHhuY1hQbFE1SXYvZm9NTlh2?=
 =?utf-8?B?SGJLVGtCdldNMjlKY1NNVUZQUTlQNHEwK2puNzZ0ZlhiUzFuZ050MTI1NTVu?=
 =?utf-8?B?OWs4OW1HVTV5S0d6cWs0emdYb0lNK3NsSFo3dkNuWGZ3QzBXekFjbnpMWkZ0?=
 =?utf-8?B?eFNvVTk0bkNyL1kvY1JUNHdpNnZMdU5ZQnlEenNnL2QvaHFHUk0xRlVwaHdT?=
 =?utf-8?B?cldvbCtOMVFuVWM3aGRDM2dhejlUM1BybStaYzdkVWdnamxTRVQ4eVZoSE1U?=
 =?utf-8?B?QWh0b25qZWs3cXBzM244RDNvRXloNnBnSms5T0xjQnZvTWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTJhNWpQSytvQ2xrUFY4YVdRcjhHZUZTaHNURFJRZ3dKa2pLODlobXBITXAv?=
 =?utf-8?B?clN0RXNWdmF4YlZjK0JmeWhMWFBqQ01UZkRRdE9jTTBlSzhNcjV0THYvenBP?=
 =?utf-8?B?YUJ3QStkS0hGbUt2cXd1ZzBRbUh6ZTFHZWxNNVN2TkplY0pjVmN2Q0VHZU11?=
 =?utf-8?B?eVpwUjVESS9nbWdGclAzUHZzSUJvYnc0WmxwYnlUWlREUTRMOWN0V3U2MEs4?=
 =?utf-8?B?ZkZJS2dyTHR5cHBsV3pXMHZQRytIeG1Ma1FSdE9KRjJZbmVkYXVMaS8zWHF2?=
 =?utf-8?B?QkE5Z0lYNmMyeDRxNittNGIvMWNqdTArbnUvWTVWbHR2YkYyV3RHSFFnWWVN?=
 =?utf-8?B?WXBPb3VuOXQxd1NsQ1hVbnZEQ1JKTnhPeTJyUC8vTS9CV09LK1BrRUlOc3hM?=
 =?utf-8?B?dEVENkRwMi9PTXlnN1ZobjJLZDdVZUcyNDlmOENNbytiT1ViT1NwTjJmZkZU?=
 =?utf-8?B?eHBadHp0Y1VIVDJScFEzbGtTU1lWbk9aN0M4eDRybm9MQi9WcHFKekR4Q3ZW?=
 =?utf-8?B?L2d0aHZQNUo3ZnJTYkRGU0w2MG0zaldqVGhzcTJHQUo1NS9FTkQ3QW1JZENN?=
 =?utf-8?B?ckVVNGgvUWJDN2ZnQlRzSXNjNElJd20vN2ZIYXhURTRpajBaT25zWUh6bFIw?=
 =?utf-8?B?dzdnOEN2a2tzNXh0alRsbnJzT21BNllwMjQ4SkdWSGtQMHJzb29ibWxmeEdJ?=
 =?utf-8?B?OVdPZXowNS9QV3ZkWGYxQ3M4QWo2a095clNPUHp0d1A5cTJWaGMwZU1KQXFH?=
 =?utf-8?B?cGpZa2lkL1BBZGxQcXM5bklGMnc1NjIzS2VNSU9SK243bXR5Y3dCb3UrZTlv?=
 =?utf-8?B?S0JTNUpwdVJVajNNUHNOTjRzWkNEY3VkODFON3dwK3F5RmtuVUJVdTBjTURr?=
 =?utf-8?B?WHNsNmZsVU83Nk9wNmVSTGwxSkNnYmdheVV6R1hBdUhZc1BqeFNqMlN0U1FW?=
 =?utf-8?B?UUZRcDVybWtkZ3dROTYrTTgrTFBwUlpra2h3RG1wQUZRQXlCQXlaWFdRRDZP?=
 =?utf-8?B?NldNNk54RFNxMW42QXUyRnVvKzduam5TSndzaWFmdnlNNlNHRlVHK0xjV1BT?=
 =?utf-8?B?MXNKQ0JZYWoxOXB4NGNzVjlxdWRmVWFWR1pEYmJ1QnFiRnNkNDdwdWo5cjk2?=
 =?utf-8?B?Z01mT1c2Z3pXWDdWV1N3SzhxcGJSbUV3SnVmcC80WFl1RWRBSW1DcWYyUHBk?=
 =?utf-8?B?TDh1eWRhNW9ieFpyNmg1aXZSSndnbUJkTEcxNU9QWkdXOUFlWForZllVOEhZ?=
 =?utf-8?B?KysvTC80d3hqZFFGV3IxZzRHVWtXY1c2Z2VoK0J2YjIzQlNRNnNsUjZJdzBG?=
 =?utf-8?B?ZUMwQnVJWUR4Q0hjeWRValdCZW50M0RaUUs5T1UzbFVMalJYWnRob3Yxekd6?=
 =?utf-8?B?ek9WdUg0MzBvL2VuOFI2eWxBSzIxYk1PK2dSMGRGKzBQdWk1dXZpOExnSGVG?=
 =?utf-8?B?L0krVVRaaTE5N3lVNlczVm4zbHV4dXdEdmJpbDY5WUltU1V4MmlkdkxzSVR5?=
 =?utf-8?B?TGwxUC8vWXI5RlhlaEJGSGhqaFM5VlRieWFpWFBkWWRtZFNScTJRUUREcWZi?=
 =?utf-8?B?UDhUMzlSU28relN5ZHg5QndMdFZocXhWZlBoL3F6dW4xRS8zT25QY2pTTDVi?=
 =?utf-8?B?RFlWei91NlNBSlVUM29IWFRpU2FxWGdITWJSVWhXQmtUajRsVjcwS0I3elpl?=
 =?utf-8?B?OURVY3pzcjAwdlh6Nzd6emhldEtrT3RLaDZTemN2TW9kVk8vMlVZWXJ3TFBr?=
 =?utf-8?B?dllrQXcxWldKVEQ3SVd6TmUvQnVoTGpRQlk4WEtVMTRQOTJtdC9KSVFoWUJO?=
 =?utf-8?B?YlMvd1ZoM01HN3JST3g5aDY3RDViMkJhZ3pxWU9wazRoVk9QNnp2NFk3UG5S?=
 =?utf-8?B?WHI4ajQvV1M4MkhzYktnWGFVdERsamZ4L3N2QURpNGswbjdibFhoUnJabXhq?=
 =?utf-8?B?aFhCSmtoQno3QnZKQ21NWVpOa01TMmM4dFJvOTFpYVhOdjVZRG5TUTBkMXZG?=
 =?utf-8?B?TUtWSGJLR05WT1FqdkZkVHJPK3M5L1IvNWJrdXUva2prOVlSRDBWRWVOU1RU?=
 =?utf-8?B?Yk9CTTJZbm9tVnV6MVV1RHpBYzVDQ1ZQNU5hQnoxdFRad2JHZUdKRGljUUhG?=
 =?utf-8?B?VUxLOHNuUHVvTTQ0bWpQTlc2MkVjQnc5K3kySXFlVkpMa2U1SFJNUVNBTWlZ?=
 =?utf-8?Q?rYXfYuh/LO01hUSTc+lSu50=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d163d19-4b01-4b86-dedb-08de17ccf314
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:56:55.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY7/kUSLi6CegWMvG+CDctfZLYuqiZcH01B9KKFeZUnZbQbPa9PQhU4xeCnExq7+W1AsK7sjevnSR/nbb9SujZTnFmktF/AuuNaKGe93y9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8775

On 2025-10-29 09:09, Thomas Gleixner wrote:
> When affinity changes cause an increase of the number of CPUs allowed for
> tasks which are related to a MM, that might results in a situation where
> the ownership mode can go back from per CPU mode to per task mode.
> 
> As affinity changes happen with runqueue lock held there is no way to do
> the actual mode change and required fixup right there.
> 
> Add the infrastructure to defer it to a workqueue. The scheduled work can
> race with a fork() or exit(). Whatever happens first takes care of it.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

