Return-Path: <linux-kernel+bounces-783975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57524B334E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FB248051B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B023027C;
	Mon, 25 Aug 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q1lHIkyw"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013030.outbound.protection.outlook.com [52.101.127.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA1366
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094571; cv=fail; b=pon6s5jB1r9OC7pjZ6vQbrhG4JKPLekDQeRG0L3WYZ04l9IGRxgUk11IY4X2uoC9K/Ah7I6xLaPJmfpyYICGcYzFGulNfxy9RXkWgcmgJySdVBywTuHHOsRZ/p4/a39WzSDHeE4YGUrP9dG+zYoWC8+8t1bojlsdPmJiAO9yGw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094571; c=relaxed/simple;
	bh=r0gHckxgERcf+Z6waIKc3sJsgwUuasayf4te0EJzttU=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUj+E9fpCgQg/+BjSWM22uB27QyyWDEWxBKb1q/S6bABy+Mqpf4Sg2LXSZVSzoJy9obzzYMhlGV4OuNkliGSi9Q6U5sW6njeg1mbe2+bamYZK7IAamx56DgAR18vpg1CpZrY6VuHSiL39OVRfK0FyW2QT6eGL29UNGuEAKV8Z14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q1lHIkyw; arc=fail smtp.client-ip=52.101.127.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTa0MdxyMHn8kFyYkjMESQvNb9C0RFidr8dvTRCCGBOdUwbqIwwRCilA3PnKWqW9B6cIaGBvJ8M2QEN84BeJi0ZHj19XrasOV1h40srTe5PK63pWzr3fM99tlbQTgPmTQDG6W5knHo2cizoASyHkjOb8Q7DH2Th+WkfVQamaagu0pdFpM3xDURBHAgP4p5xMLyqYPUkvK9EXQyunFru6h9zt0mOkii5hZQduRH2qLNm80xJKmGbUojwBf67xa88HQ+Z78fVH5vJVyWGPS101GdFKcsLQJLlMSLHGbnZIii9rnXOULumOwkSMnGBufU8fWKsmn/GsmTNoBh7csVqqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntg77YQnUrX8xOAhNNV0WAnvFrAwxaw9Txa+YkY5MGQ=;
 b=eWLlnLLRYI0ALIq7kWXEtgcAERL3fElzteWktroN3BIMvfhvDBD6BCdtpKAm7deV0ehWt57ehsNtt3kFbkIZnobi6XHn/eCVJ3H83H9WLJZKQiMikYvWt0Pl1Y7L6J+nB5lx6R6Z3yjQt3SZAAvuk6H3S2wV0sB7f7IQg46N0q3fIgR6jPnni9NJijWYsdiTcc6tp5Kwy8VWYE19UtozTABX0XFSAmEkIsgeHyDX10OXKptG9x0w7CC9mdv2trot/glxUMZrMBur/w+hBBSdbkhz10H+EuK52SZujhiIRKwXfSnKIlzsv5b0dS453uyEKyW/fCVISXR2SpDzD2p3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntg77YQnUrX8xOAhNNV0WAnvFrAwxaw9Txa+YkY5MGQ=;
 b=Q1lHIkywdmrp3SMxJNYrK9lUWOEhI93Ay8SbfH9o15X1kQFTmeY3oaTloKE3A6JYspRXz8uXX+aPPgXFMXpaR0Pn6t2LLiw7DfytYXyuQJUtOq1egiYYOErVSnDFkBylKl8pFARi6xxp3igVSy0D3APUX+KdBIugJifag3To7Geud57aJWEXEU3sreDESwuKHCd/kwTHJz7mDJ7cRMh3BY2tT1L5023N1neMGAdPWxeE5NgoX1YOI8Ew4lfP9DWoNmTpXKvT2rWHet5eO4rSrnDBa+3agKWLmjR5adMX7FW4LQVYwxK3iLTZB2muL/gEEY6CbDY2xOlrB8liTLd5pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 04:02:45 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 04:02:45 +0000
Message-ID: <d7ce9dd9-e26f-44bc-8ccc-709ab598aa5c@vivo.com>
Date: Mon, 25 Aug 2025 12:02:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: Use allocate_section_policy to control write
 priority in multi-devices setups
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250820082142.388237-1-liaoyuanhong@vivo.com>
 <8bda5b71-e7b9-47af-956b-22b95c957d56@kernel.org>
 <f037ec6c-1290-4caa-a790-1d65d9f7c985@vivo.com>
 <f1a893f7-9784-43c1-a696-b09c31d922fb@kernel.org>
Content-Language: en-US
Cc: liaoyuanhong@vivo.com
From: Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <f1a893f7-9784-43c1-a696-b09c31d922fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR0601MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9154e8-98c8-4cdf-8a49-08dde38c3f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3FIdXVNNzJCaTY4Zzc4MmhFWHhPRjNKTi9IWi93K29OU25ESU9XWmo4dTcy?=
 =?utf-8?B?UHJKRUNYL3gxWEpIUmhBcHR0Wno3ZjRQYlYwOHRDbi90MHRmU1llejZ2ZGth?=
 =?utf-8?B?OUNXN1puaDRXaWRYSjl5RmFZL1RwZmJUVHRGQkRSc1h1cWF2U2JBMWdiWDNy?=
 =?utf-8?B?enpNcHlnY1BGZ0VUTXhoZElTb2h0NmlzeSt2YzdzSHJWRkNmY2VHajVSRkxy?=
 =?utf-8?B?YjZaaVU5ck4xV21Nblp1SW9NTlZSUWoyTHV0bHgxTzRjVTZkVU5kN3E3QVZC?=
 =?utf-8?B?UjdoL3N2Wlg0NkY5RkgyYzM4MHRodmpzeWdDRGJpSEV5N3VLdXJvQkQrVkdE?=
 =?utf-8?B?ZjhNTm11Tm45WmxiV0ZKNlB0VXRIMzZiQmt5b3pQQ1Z4ZHhXUTlicGFOMFox?=
 =?utf-8?B?T3hLWDUvMmhCRmg5KzJQV3VSNmloL05KamtMQXRWbU1KdmI4aGV4cTMzWXhK?=
 =?utf-8?B?ZnZtL3VoTGZ4dkpkVzVPeDM2YnVlcHlDQXZKdDNMenZxWm1LSUpsd25nOHgx?=
 =?utf-8?B?OFRmNkppc09SelVGN1ZUUm14elpLaUxINXYzdERNd1AvemlTanMwMGFPek9j?=
 =?utf-8?B?SjJmSHVzWGp5ZGRyVUFmcGoyNkhJNkd1UnJKdTRsSWdtcVNzeGloZktCdWNw?=
 =?utf-8?B?VFE3ZCtNNkVtL0hIMWwxZmNrcEZGbVMrZS9lN251WE9haStyM0h5VVRMZGxC?=
 =?utf-8?B?OVZUMnJZTmF1dEZpZHVHcVNORGhyL3JkYmlzUHFRamI2aEV1TUk5SnB2Si8r?=
 =?utf-8?B?TUUzU0xaTE1RZ0VZME00a1NJSW5odkdNeXhMc1BmcXBCWC9RL0xQdklxUDdX?=
 =?utf-8?B?SHFHSUcyNEc4eU9FczgrNDFvUGtxWXZ4RUNVUU5wY1N5VFZQSjFjT2w4UlZy?=
 =?utf-8?B?QzdaZzk3c3FZOFNBSE9hQysrSzBZcDBXNkJkU3BIdDNUdUlNNm9QcUZEZW1N?=
 =?utf-8?B?a0E5UW9mK3hLZXJXQU5kcG5YTnZRUmU1dkd3cWl1cXF4bEI0NjF3Ynkxc3lx?=
 =?utf-8?B?cGdyVkwxcnFMVERCaGhXUlZHK3dKcVZCWmFQT0Q2bUtHYlo2cGQ1bVhmTHRm?=
 =?utf-8?B?VU9ZdDNFbkE1VW80b1l1NldVVDlXT3Q5MnRCeVNid3dCekQ1N3BBRldUa2Jw?=
 =?utf-8?B?aFBXc2wzOWtFOXRkWU8xbEtSbno0MHhhNXhlbzA0dXoyTU51Y3FXcjNVMEZJ?=
 =?utf-8?B?WnhIbUFGRU83Mi90dVd4eDJKMTJQby9MZHY3YnA1R0lVVnFOb2pzbEZ4dzM5?=
 =?utf-8?B?aHVLaXB4MVpqeXJaMDRoeXJLREhscG1vTUIxQnd1NGZBcUJZNjJhOXVtYk1S?=
 =?utf-8?B?cUFUVG85ZkhJSmp0SktGeXBjSytTWXdSUFZ0Q2t6MU9RM0lHV1RMSEk3bmFW?=
 =?utf-8?B?Ylp4Z09vaWROTitXUlJyRTlJTUJ1UVZNazRuN3hUbmhFSUJDa05zd04vbm5h?=
 =?utf-8?B?ZHdGbFRDZ3RlOGpGZ3o4dmhMNmpyeG9Mczg2eE1YUC81WFNUellQQmplL2dJ?=
 =?utf-8?B?eWc2S05Yd0tEam1HTmsrUmtVSVlvZ2RZbm8xME0wYkE0ZWFKR2RSZWR2Ylh0?=
 =?utf-8?B?ZTgwUmRQVjBDUzVLUDVFZ1lVRmhocXlSZ2pPRE55Q2ZyVVVOdHRuekdrOFNS?=
 =?utf-8?B?WDQrNVIwSk1keVZFN3YxdXhxNitwN3plYmEzK0Vua2lKU1o5cG5PTER4S3M4?=
 =?utf-8?B?eW5ReTM4cDJDNkpyY0orWFgrTys2ZUlkSW83WUJLT1dSRjIvS2czcFUvWHV5?=
 =?utf-8?B?WXROdmpsMW44TGp4ZmpYR3p2WlhxeG13bFd0dllyVzVZR3A2Q2kyUjYrR05v?=
 =?utf-8?B?U1UzWE5PeHBubEUveENrbUFOcCtqRVFCa0ZBWUVkaFplcjlySFAwZzlHSU84?=
 =?utf-8?B?bFVML1EyNnZFbWkvdEdQb2RnY3JTU1BtYlVWNThqU3FYWHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW50eWF5NytrQzRMK0ZXR1RHRVMwR2Z1ZHUyTkV0Q1h5WmJPdzkyanZaRklr?=
 =?utf-8?B?bVJiUGZ1L00zUEVXRFBiUVBIbFFWLzhDR3dnTDd2TWQ4eGlaczBpYXZ2YnhF?=
 =?utf-8?B?Z3NkalBRTHF0Z0M1Njh4ZENtRWlNN2ozZ1QvZzRuNktYdVJ4b0tiSE9yZlIx?=
 =?utf-8?B?VzJLQnJIUzlNbjJrOFhLNnNDUXZxUXJGTHNLbi94S2N4V2ZUb29oaFZBTE11?=
 =?utf-8?B?WmhheUtjYjVrRGkxSWlBVC9Xb3k0UVdFVFdmdUh3T0pUUG5KeEp2K1AxRlpY?=
 =?utf-8?B?bldRTE5GK1FtQ1ppSmFaY3RNNWdHeXNKem90UFVOeGtFbXdiM2JybjBiYTNU?=
 =?utf-8?B?OTYzOVhVT2RHc0dtNDZCbDljanhDRVhDYWdlR0I2cHJtUUcxYTRMbkhuWTlY?=
 =?utf-8?B?MU1CQzlqZzBSUmtHcVVNazl3WTUrMy9ka0pERU5GOW5BK0p3QVloQjVkb1h4?=
 =?utf-8?B?bEVhZ3BhUndDaEQwcCtmNXc2cmQ0R2l6NW1nTmJPd1QzdGRwcUh4N20vcUlw?=
 =?utf-8?B?eHVBZkRDSzNvTFNVS2Rndkd1dXhSeFJrWU9oWWYzeGNlSytoS24ybHFvcjk4?=
 =?utf-8?B?VExPbWhJNUQ1eENZdjV2ak1ML05CNHpmNFgvWThpZ2p5UFd5K0tZUFFlTmNa?=
 =?utf-8?B?bnZzTWZLSTFuTytIWmxmZzluU2lqUzJMOFF5KzJQMHBUamdrL3pBWE5NWE9w?=
 =?utf-8?B?SXhTanc0aVpJVTVENkRHV3BwajN2bTFnQXZTZm5XeXFSanVQdmZhdVh3S3ZZ?=
 =?utf-8?B?cXlQaGV4N2ZSRXJPSERhVXFhNHNLNGE5bFpEaEtmUnpacmwzdlpBRHRDZm9l?=
 =?utf-8?B?NDljck5nY1VBbS9GWTFuZDRqZXVlVjlwbElyZ0pFSGY2aHZua1I1WDcxZjRH?=
 =?utf-8?B?d1Mra0I4dHp2RXlOWUhkbjAxZGdRdlpuVmJRT3IyZHVJeWNxMmkxNHZQV3d0?=
 =?utf-8?B?Ujgra2FRR0gzRHdUU1c4UkVkTm1EVjNxYVVFdGQ1bERJSTk4UmVvOStUdytP?=
 =?utf-8?B?dllIZzFXTDR6T0RBTGxWU2FWRVZERzJqZmFVNGV3N2g0czdwd1BYOVZRdWdJ?=
 =?utf-8?B?MVNvV01sMmxLdmhBaEg5L2FvU0hYVXNEY3MxZjZQNFJCQjZUSlgzWGNQZUxy?=
 =?utf-8?B?a1pBRFRYU3ZkVDcwU3hFY2gzWmtNdkJ0bTgyOXBOeVl6WGJBVExqTmxkOHVw?=
 =?utf-8?B?MXpWSUNPUi9NSmlHZU5FUC9rQ0JhRzR2Q2lQdGk5ZWIyQ2pvQ1pmQnZGcVc5?=
 =?utf-8?B?VUxvTzFCa2dqRldKeDhvNUUwdFluT1Z1S2kwTnc3NWN6cGE5THVFdDgyWDV0?=
 =?utf-8?B?bEZrbUhyWWl2T05UTWpCQmM1QmUraTdBL3ljK2V0aXZSbDhWV3lDeGt2b1Z2?=
 =?utf-8?B?bHA2QktjeFdTUjZmZGxqT3paN0F6ZnhUbU9xYmQ1cDdRaFc2MHFDelozaDZY?=
 =?utf-8?B?NjFsa1RYUENseFp6TEd3RlVJKzJiVjBRSWttaXNxK0pQNWFNTnhzQ1lGWEg2?=
 =?utf-8?B?YURMdlQyaFhDQnBjYlJaNEFzbW5TL1B4NzR0eXhKemtGNGEyZVYwME50MU9S?=
 =?utf-8?B?dFVmU005UTU5clJtZVd2UlY2NHYvQ2ZHRzN3YS9QWVZSUURkTTZtMUpLVTd6?=
 =?utf-8?B?Uk0yN0JWdWxhMWorQi82Wkxmd2NzQWdzNXhNS211R2dJK0hxVG80UkEvcWJW?=
 =?utf-8?B?VVdzaWtCS0VyemEranUreUlkSzd3Wlc3bzh2SDRKcXJlR1VUUGhqUkcwTkpE?=
 =?utf-8?B?TGx3OVNyV0VoamZkVFBRcllKNnlEUTRVdVptMklxbndWV3J4QngrWE4rMHhN?=
 =?utf-8?B?ZmZ4N2pBV2xkMjVtZExEcTVubzIxL0kxbHI4b1pITUdJcFVLcGJaRXJzRnlN?=
 =?utf-8?B?V2tENTJoby9idFJWV2QvWTNwT0xqTVdwcUhsd3hlSVdpZWo2UXcrN0UrMUZ4?=
 =?utf-8?B?N1NCc3JrR0l2b2l5dUdNcHdCM3FkdGpZblF2TU54V0tBU3FWK0dnTklEMVg4?=
 =?utf-8?B?amh6aU5OTVl4OU1FN0ZqMXQ2TXFkc0tEa1dJNHdmaVZET1BHeDZnMHBZdXZW?=
 =?utf-8?B?c1Z3OFBtOHJnenZKS25KU0R1Y1M0bVBTdUlmUFpBWkdoY1hPOHRGQVd6WG9U?=
 =?utf-8?Q?uHnCzSZjRwvkRRTgww7p21Bg/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9154e8-98c8-4cdf-8a49-08dde38c3f22
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:02:45.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4id2uFENYQBwD7eaKR+1qayWGx2189NNaIxlmU2evAJF2MkkU5UQL4qqg5WliowGZljhqXv9pvYNVg8xeyHVXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510


On 8/25/2025 11:56 AM, Chao Yu wrote:
> On 8/25/25 11:42, Liao Yuanhong wrote:
>> On 8/25/2025 11:10 AM, Chao Yu wrote:
>>> Yuanhong,
>>>
>>> On 8/20/25 16:21, Liao Yuanhong wrote:
>>>> Introduces two new sys nodes: allocate_section_hint and
>>>> allocate_section_policy. The allocate_section_hint identifies the boundary
>>>> between devices, measured in sections; it defaults to the end of the device
>>>> for single storage setups, and the end of the first device for multiple
>>>> storage setups. The allocate_section_policy determines the write strategy,
>>>> with a default value of 0 for normal sequential write strategy. A value of
>>>> 1 prioritizes writes before the allocate_section_hint, while a value of 2
>>>> prioritizes writes after it.
>>>>
>>>> This strategy addresses the issue where, despite F2FS supporting multiple
>>>> devices, SOC vendors lack multi-devices support (currently only supporting
>>>> zoned devices). As a workaround, multiple storage devices are mapped to a
>>>> single dm device. Both this workaround and the F2FS multi-devices solution
>>>> may require prioritizing writing to certain devices, such as a device with
>>>> better performance or when switching is needed due to performance
>>>> degradation near a device's end. For scenarios with more than two devices,
>>>> sort them at mount time to utilize this feature.
>>>>
>>>> When using this feature with a single storage device, it has almost no
>>>> impact. However, for configurations where multiple storage devices are
>>>> mapped to the same dm device using F2FS, utilizing this feature can provide
>>>> some optimization benefits. Therefore, I believe it should not be limited
>>>> to just multi-devices usage.
>>>>
>>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>>> ---
>>>> Changes in v2:
>>>>      - Updated the feature naming to better reflect its actual functionality.
>>>>      - Appended patch description to clarify whether the usage should be
>>>>      limited to multi-devices.
>>>>      - Improved the code style.
>>>>      - Fixed typo.
>>>> ---
>>>>    Documentation/ABI/testing/sysfs-fs-f2fs | 22 ++++++++++++++++++++++
>>>>    fs/f2fs/f2fs.h                          |  8 ++++++++
>>>>    fs/f2fs/gc.c                            |  5 +++++
>>>>    fs/f2fs/segment.c                       | 18 +++++++++++++++++-
>>>>    fs/f2fs/super.c                         |  4 ++++
>>>>    fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>>>>    6 files changed, 74 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> index ee3acc8c2cb8..b590809869ca 100644
>>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>>> @@ -911,3 +911,25 @@ Description:    Used to adjust the BG_GC priority when pending IO, with a default v
>>>>            bggc_io_aware = 1   skip background GC if there is pending read IO
>>>>            bggc_io_aware = 2   don't aware IO for background GC
>>>>            ==================  ======================================================
>>>> +
>>>> +What:        /sys/fs/f2fs/<disk>/allocate_section_hint
>>>> +Date:        August 2025
>>>> +Contact:    "Liao Yuanhong" <liaoyuanhong@vivo.com>
>>>> +Description:    Indicates the hint section between the first device and others in multi-devices
>>>> +        setup. It defaults to the end of the first device in sections. For a single storage
>>>> +        device, it defaults to the total number of sections. It can be manually set to match
>>>> +        scenarios where multi-devices are mapped to the same dm device.
>>>> +
>>>> +What:        /sys/fs/f2fs/<disk>/allocate_section_policy
>>>> +Date:        August 2025
>>>> +Contact:    "Liao Yuanhong" <liaoyuanhong@vivo.com>
>>>> +Description:    Controls write priority in multi-devices setups. A value of 0 means normal writing.
>>>> +        A value of 1 prioritizes writing to devices before the allocate_section_hint. A value of 2
>>>> +        prioritizes writing to devices after the allocate_section_hint. The default is 0.
>>>> +
>>>> +        ===========================  ==========================================================
>>>> +        value                         description
>>>> +        allocate_section_policy = 0  Normal writing
>>>> +        allocate_section_policy = 1  Prioritize writing to section before allocate_section_hint
>>>> +        allocate_section_policy = 2  Prioritize writing to section after allocate_section_hint
>>>> +        ===========================  ==========================================================
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index d6a49de1b7e9..5ce9bf6be462 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -162,6 +162,12 @@ enum bggc_io_aware_policy {
>>>>        AWARE_NONE,            /* don't aware IO for background GC */
>>>>    };
>>>>    +enum device_allocation_policy {
>>>> +    ALLOCATE_FORWARD_NOHINT,
>>>> +    ALLOCATE_FORWARD_WITHIN_HINT,
>>>> +    ALLOCATE_FORWARD_FROM_HINT,
>>>> +};
>>>> +
>>>>    /*
>>>>     * An implementation of an rwsem that is explicitly unfair to readers. This
>>>>     * prevents priority inversion when a low-priority reader acquires the read lock
>>>> @@ -1850,6 +1856,8 @@ struct f2fs_sb_info {
>>>>        bool aligned_blksize;            /* all devices has the same logical blksize */
>>>>        unsigned int first_seq_zone_segno;    /* first segno in sequential zone */
>>>>        unsigned int bggc_io_aware;        /* For adjust the BG_GC priority when pending IO */
>>>> +    unsigned int allocate_section_hint;    /* the boundary position between devices */
>>>> +    unsigned int allocate_section_policy;    /* determine the section writing priority */
>>>>          /* For write statistics */
>>>>        u64 sectors_written_start;
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 098e9f71421e..b57b8fd64747 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -2182,6 +2182,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>>>>        SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>>>>        MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
>>>>        MAIN_SECS(sbi) += secs;
>>>> +    if (sbi->allocate_section_hint > MAIN_SECS(sbi))
>>>> +        sbi->allocate_section_hint = MAIN_SECS(sbi);
>>>>        FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
>>>>        FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
>>>>        F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
>>>> @@ -2189,6 +2191,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>>>>        if (f2fs_is_multi_device(sbi)) {
>>>>            int last_dev = sbi->s_ndevs - 1;
>>>>    +        sbi->allocate_section_hint = FDEV(0).total_segments /
>>>> +                    SEGS_PER_SEC(sbi);
>>>> +
>>>>            FDEV(last_dev).total_segments =
>>>>                    (int)FDEV(last_dev).total_segments + segs;
>>>>            FDEV(last_dev).end_blk =
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 04b0a3c1804d..e0f6589c6a1c 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -2807,6 +2807,10 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>>>>        }
>>>>    #endif
>>>>    +    if (sbi->allocate_section_policy == ALLOCATE_FORWARD_FROM_HINT &&
>>>> +        hint < sbi->allocate_section_hint)
>>>> +        hint = sbi->allocate_section_hint;
>>>> +
>>>>    find_other_zone:
>>>>        secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>>>>    @@ -2828,13 +2832,25 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>>>>    #endif
>>>>          if (secno >= MAIN_SECS(sbi)) {
>>>> -        secno = find_first_zero_bit(free_i->free_secmap,
>>>> +        if (sbi->allocate_section_policy == ALLOCATE_FORWARD_FROM_HINT) {
>>>> +            secno = find_next_zero_bit(free_i->free_secmap,
>>>> +                            MAIN_SECS(sbi), sbi->allocate_section_hint);
>>>> +            if (secno >= MAIN_SECS(sbi))
>>>> +                secno = find_first_zero_bit(free_i->free_secmap,
>>>> +                                MAIN_SECS(sbi));
>>>> +        } else {
>>>> +            secno = find_first_zero_bit(free_i->free_secmap,
>>>>                                MAIN_SECS(sbi));
>>>> +        }
>>>>            if (secno >= MAIN_SECS(sbi)) {
>>>>                ret = -ENOSPC;
>>>>                f2fs_bug_on(sbi, !pinning);
>>>>                goto out_unlock;
>>>>            }
>>>> +    } else if (sbi->allocate_section_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
>>>> +                secno >= sbi->allocate_section_hint) {
>>>> +        secno = find_first_zero_bit(free_i->free_secmap,
>>>> +                            MAIN_SECS(sbi));
>>> Will we hit "secno >= MAIN_SECS(sbi)" case here?
>>
>> Yes, there may be hit 'secno>=MAIN_SECS (sbi)' case, and I will fix this issue in
>>
>> the new version patch.
>>
>>>>        }
>>>>        segno = GET_SEG_FROM_SEC(sbi, secno);
>>>>        zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 5aa9d650512d..fa38a3e6b9cd 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -3942,6 +3942,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>>        segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>>>>        secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>>>>        total_sections = le32_to_cpu(raw_super->section_count);
>>>> +    sbi->allocate_section_hint = total_sections;
>>> What about assigning sbi->allocate_section_hint in anywhere else rather than
>>> in sanity_check_raw_super()?
>>
>>
>> You're right, it's not suitable to initialize sbi->allocate_section_hint here. I'll put it in
>>
>> init_sb_info() or f2fs_scan_devices().
>>
>>>>          /* blocks_per_seg should be 512, given the above check */
>>>>        blocks_per_seg = BIT(le32_to_cpu(raw_super->log_blocks_per_seg));
>>>> @@ -4713,6 +4714,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>>>        logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>>>>        sbi->aligned_blksize = true;
>>>>        sbi->bggc_io_aware = AWARE_ALL_IO;
>>>> +    sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>        sbi->max_open_zones = UINT_MAX;
>>>>        sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
>>>> @@ -4744,6 +4746,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>>>                        SEGS_TO_BLKS(sbi,
>>>>                        FDEV(i).total_segments) - 1 +
>>>>                        le32_to_cpu(raw_super->segment0_blkaddr);
>>>> +                sbi->allocate_section_hint = FDEV(i).total_segments /
>>>> +                            SEGS_PER_SEC(sbi);
>>>>                } else {
>>>>                    FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
>>>>                    FDEV(i).end_blk = FDEV(i).start_blk +
>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>> index 1ffaf9e74ce9..81b99c2a02a9 100644
>>>> --- a/fs/f2fs/sysfs.c
>>>> +++ b/fs/f2fs/sysfs.c
>>>> @@ -889,6 +889,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>>            return count;
>>>>        }
>>>>    +    if (!strcmp(a->attr.name, "allocate_section_hint")) {
>>>> +        if (t < 0 || t > MAIN_SECS(sbi))
>>>> +            return -EINVAL;
>>>> +        sbi->allocate_section_hint = t;
>>> Will it race w/ resize_fs ioctl?
>>>
>>> Thanks,
>>
>> Does this mean that after executing resize_fs, the current allocate_section_hint value will
>>
>> not match the resized size? If so, I've handled the data update in update_fs_metadata().
>>
>> If not, what other areas might cause a conflict? Please let me know so I can address the
>>
>> issue immediately.
> I meant something like this:
>
> resize (cpu 0)					sysfs (cpu 1)
> - MAIN_SECS(sbi) += secs;
> - if (sbi->allocate_section_hint > MAIN_SECS(sbi))
>     sbi->allocate_section_hint = MAIN_SECS(sbi);
> 						- if (t < 0 || t > MAIN_SECS(sbi))
> 						 : what if MAIN_SECS() has the old value before
> 						   statement "MAIN_SECS(sbi) += secs;" since cache
> 						   between cpu 0 & 1 may not the same unless you
> 						   call barrier to flush cache? Not sure, we'd better
> 						   to avoid such race case w/ a lock?


I understand your concern. I will investigate how to prevent this 
situation. This will be addressed in the next version of the patch.


Thanks,

Liao

>>
>> Thanks,
>>
>> Liao
>>
>>>> +        return count;
>>>> +    }
>>>> +
>>>> +    if (!strcmp(a->attr.name, "allocate_section_policy")) {
>>>> +        if (t < ALLOCATE_FORWARD_NOHINT || t > ALLOCATE_FORWARD_FROM_HINT)
>>>> +            return -EINVAL;
>>>> +        sbi->allocate_section_policy = t;
>>>> +        return count;
>>>> +    }
>>>> +
>>>>        *ui = (unsigned int)t;
>>>>          return count;
>>>> @@ -1161,6 +1175,8 @@ F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(dir_level);
>>>> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_hint);
>>>> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_policy);
>>>>    #ifdef CONFIG_F2FS_IOSTAT
>>>>    F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>>>>    F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
>>>> @@ -1398,6 +1414,8 @@ static struct attribute *f2fs_attrs[] = {
>>>>        ATTR_LIST(max_read_extent_count),
>>>>        ATTR_LIST(carve_out),
>>>>        ATTR_LIST(reserved_pin_section),
>>>> +    ATTR_LIST(allocate_section_hint),
>>>> +    ATTR_LIST(allocate_section_policy),
>>>>        NULL,
>>>>    };
>>>>    ATTRIBUTE_GROUPS(f2fs);

