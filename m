Return-Path: <linux-kernel+bounces-777778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D02B2DDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DD01C46065
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CE031DDA3;
	Wed, 20 Aug 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jZlewpRl"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2098.outbound.protection.outlook.com [40.107.116.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB531DD99
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696239; cv=fail; b=uy8wtfW2nza476CVFyQIO4fQaaDmK5iADkHzlICiVHJczJhv4nKN41Ou9C9tBn9FLASPP8+4qOsZuFNQZlrlYv8zac8O8NvyU0Hkl9mrbCG2JPrjYEFxWo5UAh9cJOqp4FmiaIL/4UyqWJl25GE+t1002tgL5Xd85SmYpaNB+sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696239; c=relaxed/simple;
	bh=n9JENWOfe+KcoBqz+fXw6ttERatWDrWJOewl/LtsLtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GFz2K5aVpZwszyozTTHEKjVSnS5o0Zq6uNfUkvo7xSgZ5zysUNGEAM4pqD2xkrWZPsrqo6NDbk/D1kvP/nTozeHBb5WD/xt+nryIAIqY74W4cExhMABZ/5qV9fNrhJNHp4XsIfPPWhRjF/iXxdUJE1xKcPk0QNS7+mdwNzo4MBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jZlewpRl; arc=fail smtp.client-ip=40.107.116.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy1iGctyoPdEYDGNLqy/xRr3kbHIEy4M2BhZKTv2+tfwkuAMOky4FRFZsbxcmsD1HNYGQPFXUh8pqzhD4RplEOc7qLxjCK2PGf2BSP0AxoFKs7Gugt1Bv7Ge7wkwzhMQn67xmoxU0vbzhzN77D/YjC7bnOSb3EGLBggLVhBYJAJoIwgr9PM0t0WTePSBsUAUhET1VgF7z80a74G1Imtb6jRtScrsyR2q4CqZNmMgjJzuBEoZtyr3/Qh6ibRErfg0un0FH3uPO91UlYaKzpdy62PUNZVSD/wYhqnxtO8ZOx8ouuQVBPFcIzPgusJ6jxfl8YEsPYZU3domCrqaz858WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IBGtL3VF46MtpG/nL6huOdNbGiCSGnUT0UdCW8N6Xc=;
 b=G24giaM/YnHp+6tBG4krYZQPHsFioDZ03t9NrPFplABVlDT991nTy5LFroLrGHAVc3+PyW7N3wCFO2lDm5dKyXkvFP5tER4BiyBmiY6A4FYx6q4UxqhkM09yKg7uaAFfPFO2OLQ31GmjEXt8+0j69eu7hehm0hKQYfKdTDpC51EsH2ykgNjiyKSzKn1d+wZZU/ufYbi16WtD6kWTF7exPKTEK8Dqq+gllP7l2ZBx2Bw8+u/+0TOUXJaWnfzbvtx0IqikDVw3CtRBPWjHqXgsZy18JagEKKMpOkDlfdfYbe9/RwPYWSirC+qi+QdjNqHDhWcdNccg/OvCTkkEvRY24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IBGtL3VF46MtpG/nL6huOdNbGiCSGnUT0UdCW8N6Xc=;
 b=jZlewpRlVx13ssMvYyr6mOk8+H1hPn7Po/QESjzoDBJfpNVlHyQIcpOoyq6aw3O6txduH+WjShi4g0mwAgtoQCQTrGLvlyd8sPEXxddqYT13RK0JYvtSpxUdzpq8ByC9DpAOvXqeasAOCxyvnFaMwMTQdBSZ+2ZjI/2izbj7NNVDBtkxogEnrODHVXAfgTr40KVOuQmE23JH99m9REyhEMl5hfKzpE1hQt0AfaRuXKLOpGrdI1xvZCLg93CoVXDuUDTagMZVV0e0/mzlG7a1hVYO4rKKgI+ul388AThBsCsiF81dNn7f+UVUb/d3Z2oPiM7OBe9nv4w/P8G3Werbaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:23:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 13:23:52 +0000
Message-ID: <a2f916f1-0693-41aa-be72-465d84da5123@efficios.com>
Date: Wed, 20 Aug 2025 09:23:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: Protect event mask against membarrier IPI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <87o6sj6z95.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87o6sj6z95.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0349.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11073:EE_
X-MS-Office365-Filtering-Correlation-Id: a66668af-be77-4dc2-6a6b-08dddfecce70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDBWazJIMlg2UHdJRlE5RE9LTGdNWldCbUo1QURrVm1KN0hCeitXTFpUbnkr?=
 =?utf-8?B?SlFpL3E5RTNDODZuazhwRkNpcHlNL25ZU01BVm5hYkluRlpwekdnMDFEM2w2?=
 =?utf-8?B?UGhpYjQ2ZWEyc2xpM3k2UHZESkNkTUtKZ3hCVHFyZ2JtZU9KUDlycmppR2s5?=
 =?utf-8?B?d2ZocmhkV3FGUllMOFFBVVNCc0lyZWliRlNZczBUNi93T2UxYnZvRldESjlp?=
 =?utf-8?B?STFnSGNSQTVCdkNHTURXL204TUZQVVYzQWE2QnBHaDVDaGsxa3J6Q0pvRks3?=
 =?utf-8?B?cURzVXRUZDdrMUtSYkJ2MWNWTXMxWG9oQk9IbTN0S1l5TVNNVyt6K1gzSkhk?=
 =?utf-8?B?QWFHQlhjNmJud29wVlV0V1NjSzBDME9mUkQ3QVFSTzRWcHRJbEw4QjBrcklS?=
 =?utf-8?B?a2ZGZlBtRUhTMFhtY0psekh5dkdzRWNBREMycGtVd1B1cXgzd0NQeHhBRHZX?=
 =?utf-8?B?V1Bid1RnSktHTXEzVmZuTUFlQmRjQk16M2dEd2QydnMrSk5XWWpselUyZXpx?=
 =?utf-8?B?UEFRM2ZBaUY1eGh0Tml5NEVXQnJxODBkTFQzMThjRjlQY2ttVlJwUW5KdTBu?=
 =?utf-8?B?WGd0dWhPdCtXeWJ2STVYcWF4L2lESkhoRUFNS1p5WTU1c0JPZU9xNDBrTTBC?=
 =?utf-8?B?cVJwYW9FY2ZjMytTdHZCSEplL2o4SnE5aExONmthc0IwL1BrMDU5N242OGdv?=
 =?utf-8?B?d0YzZTFkWENTN3hZUHloQWNRdGJVUE1PRTNPamtSSXhvZUliaUVpVlVUSE9y?=
 =?utf-8?B?V1J2TU9zU1d5dHM4WGRNakhtRlVMTnhmUFM2NStEaGIwUmt1YTBxY0Z4Vnlu?=
 =?utf-8?B?TEhrdHpELy9QdjBpd045WkwxaUZodkUvSThqd1FrNTM5U0ZWTjVvR1JxL3Qr?=
 =?utf-8?B?bTk1SnRyd2xCaHB4dS9ERmQ3RHRVZmlhNFFwckVDMnZoVWJOT2lKSVc4eU1u?=
 =?utf-8?B?VllsV01QNHU0SW9VTWJ6YTRpeCtoVmFMSEJtRTdESkc2eWg3K2VERzJyMGdl?=
 =?utf-8?B?amZxQ3VZdW5lMlJkM2hiajU5M00rYmR5ZDN0WTcyMzhhaHNLTm5VRk9leGVx?=
 =?utf-8?B?RDRCbUU3T0N3dDMxbE5hVzhzQ3BIaTN5M2pnYThPY1dYcytTN1d5N0t6UXZK?=
 =?utf-8?B?YXBjYThFRy9oNlpVWnNqZWxSOXhTZUhlbkU0ajNDU2hDdVZ5M2JTNmp0THhw?=
 =?utf-8?B?cUdudUNVVFdjdWp2NVhxVFQ1Q0FvaExEUSsvVHA2aXlOaFB4TzZBelEzMHZ5?=
 =?utf-8?B?M1lXaS9HT0piZG5YTStwMUpHUXlrblFJSlgrTFBiMFFFNHowdjBpTkIram5X?=
 =?utf-8?B?NEdrSWxhVE52SS9qTlQ1UTIyMmJkZXpQZS84aEVFa2RraVhhYjdua1lQS1Rp?=
 =?utf-8?B?S2FxWU9UVmJXSS93cktVZjZFNDdRdDg5ajB2NVIyK2oyUjJyd3ROdzBmR3Mx?=
 =?utf-8?B?QTd5SkYzYXJLNUU4WjBDemJYNjRScFJVN1IvSXYwY3J6dVFWanZVZVdqbW41?=
 =?utf-8?B?cWZkN05xVitualE3dk1EWWFTS1REWmJkMzBUMGN5cHMyaFFzZ1JBc1RVamtK?=
 =?utf-8?B?RzdZZWFzTE5YaENYMnI3L3NBeDBjOWM4aFhhenVqRnQrWGowZm1lNjkzUzJa?=
 =?utf-8?B?NHh0WHZ0VlVLTDBzL1pINHVkZHZEbWdON25ualp4VUx0U3VuK2NxYVZtTFo1?=
 =?utf-8?B?YW9yZ3pGcWoxeURBR25uanVGMFFwa3RkOHF0ZDA1SXAxZ0NRMVNLRGJ3M2lK?=
 =?utf-8?B?VElLSElLV1NrVklVOHJBSEN4Z01LQUFnSyt3UGxrSU1HTjdFS2xoNGxESXFK?=
 =?utf-8?Q?v+WMQxziFC+R165+51Ris12et7qzocXQ+gQVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzliYlBkTGROZnlGajdYYzRCUGxPTmVMT3dXSm9SbVBmWUNrYzBZdzFTS1BY?=
 =?utf-8?B?MnFNdVhrMndUUzRVYTBQNkpyUUVmcjZxZVcxUjBkVHVmS1A2QUF1Mmh4eFhN?=
 =?utf-8?B?ak9oZmtFeWo5U2dzZ2NwMitOWGNBNCtyTXliSXgvaWpzMzNoMTVxbzVZTVRv?=
 =?utf-8?B?S2hWaXFSN29jTHgxNng1K3dLaHlrdzhydHhqbklrS1VMMTRtOUR0UEhsbTRk?=
 =?utf-8?B?d1gvZlVmaStQQUtPNmdkV0lma2lxaUtnaXY5dUNoUUpZZ3lYUE1XYUFhKzFD?=
 =?utf-8?B?UFdHT0x4TFhXZUNiR0FJdDhCTlhhbUZKdnI2bXA0bFRPaC9ySFlNVmZWWVZr?=
 =?utf-8?B?ZjJua2lSR3E0TTZIUXB2SkxnRG4yTHRURTc2OCtzelVseWsxZXBFWk15ejFZ?=
 =?utf-8?B?bXNzaHJCNUlLREI4MlltN2lwQnNDTmVUMFJleUtDYk56aVpWT1I1VXhmSFdV?=
 =?utf-8?B?M1JMd1ovN1kxbjd1bG1oWklqREpUSFVJbWxpTmpVOFd1RzVtdjB4bTllMTlH?=
 =?utf-8?B?cHdjY1B3TEllOS9KZDdrUHZRNS9WejZYYi9FWFNCanJmeXdRNURvYmVPb0Jq?=
 =?utf-8?B?QW1aSjFtTzVmUkh0UTVOOGRxdUh4cFprSGFLeGVWem9yTUtPdzM3NWZUWVVt?=
 =?utf-8?B?U054TTlQVlplVG11a1I1emdWZFpEZENGUWx1N0I3b1M3aEZFQmE3UTZZbTFz?=
 =?utf-8?B?V3c3Q0VXdXNZdGZQU0xxdXFBZi90ckZ0cHRGUE5tUnBZdTFid041S3ZLZ3o0?=
 =?utf-8?B?S3k3RS95T3hRUy9tem90cFQ3amNkQ2JKSStLaDhIUWF1NTVXT0xTWW8wZ25r?=
 =?utf-8?B?ZTJ6Vmk2ZDkvSFhIVkdueVI2WXdMVktLaTYwNElHbmZmRmphNkN2Z2dxUk16?=
 =?utf-8?B?SGFOT2V0OXBhRjR0YXNtS1RMeDRhMlljOVpuQW9LOGZkc2F6TUxna2VVMUEx?=
 =?utf-8?B?Z3JISkE3NGs0dE93anB1MmM0SEIzODA4QjNZMndNbmQ0SW9DZjcydk1ZWEpQ?=
 =?utf-8?B?akFCd1BNM3ovYnQvTVNiL080NjdVdDlsb0tjbWpaQnBUU0hWOVF5Ulh6UW16?=
 =?utf-8?B?cjIzZHFVWXErT0VEQVczeGoxZmpUWDV1b3Z3RHVVVmFvZGtxV00xWm1nR1pU?=
 =?utf-8?B?d1ViT3hDMEkrR2R4YVptYTNiVmYzUU1JVW8rUXhDZCtoOXphRlV0QndtaFpC?=
 =?utf-8?B?djNGTHI5RlFYL2lIRGZQazJ3cUd0K1RDSDlDRWtwRHp0Mjc0V2FiVStwK3or?=
 =?utf-8?B?cFU3TVovaW1hbDlDNlo2R3dxTlRtdG9zeGYraTNWMXp3U2RNb3ZZM2N5dERC?=
 =?utf-8?B?citUZDUyT05CMnUzUTg3TzBrVVQwR2srck1nQ2tZdmlMUVJKcnowVWpGcHZW?=
 =?utf-8?B?MTdjdW9tbTRqQnV0dGNScVFFU1hseC9lUXhwMTROOUpKd2hNSXovQyswVU41?=
 =?utf-8?B?aWNBR214T3VRNlU1ZmpicUhNaXdlQ1E4TG9zV2kwR2xJQjNrN0VPSUcySDUx?=
 =?utf-8?B?MndJYkR0Ynd5WVJEdmUrWklnVFJIcmYxdThJMUxMclMxWWE5UEZUckJ1S1pS?=
 =?utf-8?B?b2IvTFQxWnhsZHJqR0ZjQjBBMVp4YnJuNFI5QW5NQ3YzL0ZqRHNqZDZpdS9F?=
 =?utf-8?B?SG81RmxadlRieEljeWVoWTEzSTNXVDFyWmo4b1VZelowU0IreUZmWXRHNzVz?=
 =?utf-8?B?Y0xwZFhiNTRyWnZXOHBXODFqdTNLQnlHRGRZWEl5R2tVcVlXRkw2bElVSW1E?=
 =?utf-8?B?UCtWOU83TGo3YTFBUWswRWFRK204SGpJS0wzVHJoTzY4Y1NWSEVDWklkem1r?=
 =?utf-8?B?akN0NGI3bm82MHJ4MUJEeDhqYmRSb21JM0VUM1lGTDE5YWFOeWNmeFl3MitX?=
 =?utf-8?B?UGplK1hlUjJSZ3JVMmpZVEhJMm1SVlVvdE5ZK2Y3T0tzZGhlY3VKcS9KVkV0?=
 =?utf-8?B?SmVuMUtkakhTMUVPRndycjc0YjRwdm13empHVGRMVGYvK21iRUNNZDRBTkt0?=
 =?utf-8?B?MDliU1g0RG4xRVkzOHFJc1MyejgwK1FSMXgrK2xjTlU4NThuaWpreFdYcTNG?=
 =?utf-8?B?OENtdGI2YVlNU29qckwrSkUwVDlPRkxKTEpPQnFrRTRlblQvV1VQaXM5QXV3?=
 =?utf-8?B?QVE2NTlSUlR2dCs0U2hZTmx6OEpwY3NRbFg0ZDhqOXd3OFNubmtTL0Q1VG9t?=
 =?utf-8?Q?79V3+DitRvk5bQHCRpoROZc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66668af-be77-4dc2-6a6b-08dddfecce70
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:23:52.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6drkReENDm1CzqfOfZn45ftIQtqSQjeGEAxHGiZt/onxi/ouvwN7KVlPsyff1Q9LnwprVxERoGb07UGi0bNIz1cO128iI8J+fEDlOBqbpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11073

On 2025-08-13 11:02, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 12 Aug 2025 16:34:43 +0200
> 
> rseq_need_restart() reads and clears task::rseq_event_mask with preemption
> disabled to guard against the scheduler.
> 
> But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
> from the IPI, which leaves that RMW operation unprotected.
> 
> Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.
> 
> Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>   include/linux/rseq.h |   11 ++++++++---
>   kernel/rseq.c        |   10 +++++-----
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -7,6 +7,12 @@
>   #include <linux/preempt.h>
>   #include <linux/sched.h>
>   
> +#ifdef CONFIG_MEMBARRIER
> +# define RSEQ_EVENT_GUARD	irq
> +#else
> +# define RSEQ_EVENT_GUARD	preempt
> +#endif

We should also update this comment in include/linux/sched.h:

         /*
          * RmW on rseq_event_mask must be performed atomically
          * with respect to preemption.
          */
         unsigned long rseq_event_mask;

to e.g.:

/*
  * RmW on rseq_event_mask must be performed atomically
  * with respect to preemption and membarrier IPIs.
  */

> +
>   /*
>    * Map the event mask on the user-space ABI enum rseq_cs_flags
>    * for direct mask checks.
> @@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
>   static inline void rseq_signal_deliver(struct ksignal *ksig,
>   				       struct pt_regs *regs)
>   {
> -	preempt_disable();
> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD)
> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);

Then we have more to worry about interaction of the following
rseq events with membarrier IPI:

- rseq_preempt, rseq_migrate, rseq_signal_deliver.

Both rseq_preempt and rseq_migrate are documented as only being required
to be called with preempt off, not irq off.

I don't see the point in sharing the same rseq_event_mask across all of
those rseq event sources.

Can we just move the event sources requiring preempt-off to their own
word, and use a separate word for membarrier IPI instead ? This would
allow us to partition the problem into two distinct states each
protected by their respective mechanism.

>   	rseq_handle_notify_resume(ksig, regs);
>   }
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -342,12 +342,12 @@ static int rseq_need_restart(struct task
>   
>   	/*
>   	 * Load and clear event mask atomically with respect to
> -	 * scheduler preemption.
> +	 * scheduler preemption and membarrier IPIs.
>   	 */
> -	preempt_disable();
> -	event_mask = t->rseq_event_mask;
> -	t->rseq_event_mask = 0;
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD) {
> +		event_mask = t->rseq_event_mask;
> +		t->rseq_event_mask = 0;
> +	}

Instead we could sample both the preempt-off and the irq-off
words here.

Thanks,

Mathieu

>   
>   	return !!event_mask;
>   }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

