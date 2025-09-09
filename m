Return-Path: <linux-kernel+bounces-808900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D1B505EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608311B28111
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D030499B;
	Tue,  9 Sep 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gnPafKCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WOe1d5LB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D7303A09
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445106; cv=fail; b=ScnRTzE86oX8B68N9n6S2/2TxqELo9F7ZeOi5bmqlLRLhnJKxIzaFTg5PccVasfqKvQmAoYkJDZMqHOxFmJ5a+YrCF4UDd3fAyOaRGfQE8Pnm6Ljcq1YV/g1i9iVDkxwC04owHjcni9CvKic4RLOcgjOo4h6YdyST7jTNjUi3WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445106; c=relaxed/simple;
	bh=bMvz835CKSsOqA6usJf0hvPZVGQK+kFyjNBmu9PiPN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHpJa+H1UdwT8pxp/l4KJ+KYl3+SH7qasP5tPktJGDK75JCqoVSJPIzN2euMhxpS1Yp5gh9KEJq+yF7Yemo/ppXAYNXbrAAuIAUjOyweWMKE29AEycj7L+YBUJtuYzqH7tUtwgqkI2P0eAco6bhqk5B1W2PLuPyngw9VEDk5tcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gnPafKCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WOe1d5LB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589FtfBY020235;
	Tue, 9 Sep 2025 19:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xYMschXM4hT5QdirT9F/P5bF0eCuwcLYsf6f7qx/3nQ=; b=
	gnPafKCM4v0U/0lJE20D8rkP9tNEalFYl2eXv4qr9csrh5GBoYrTopjukv6gPN4V
	tvhaHzZLq+ZwGYiVeyHVZv5gQC8V8QhrVozyczpAIQzA6TUKW0Ah+wsW060PIA7T
	hGYjTdEgksvcNeodCD1HuBhgL9Q+L1ybTCfBwpL4rFbmfUEpWQSXRM2vjbpscq51
	LeOWdANCXRnxyyCsE6sEhouf0lz+wVQaCEgFhtZHh9UFNkPlBWO8tH1Wz85lJxBt
	RFTIeHeVmZIP1JSdex+YrCHpT7JPNVyRbeFFmXy0NSWrMm655w3IqEpaHFRs/wTp
	4da1HGTFalNDzDJ6FDUMLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shtjg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:11:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589I9elj002808;
	Tue, 9 Sep 2025 19:11:09 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdgj32x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnJ4StFdzugkM6ZQauOUEh1mCHKrSrdm7aM3nPZoZngb87mftQXBKEyWDrO94rSlYrqQfWCHujcCAlRry1R0bf8JRlIWZwU17S5cza7vrqD5zeTniXhAaPMuj41W4gkbwEklu6oOreqhcjosQXh4BIF42IZ7RGfIrFokEZWVb7WwTT6jDJIoCQAqqBJfl3/3GnVO69mWTCTpXk0zqf2zoZ0iE3IMXnCCdZof5GqWGRe+sYvwm+9whGM0KS8iR6RGuMgI2QBUcboRnUxQtUrzVBzgLMVKVRqPs7CPdkodIWCUiYGyv+GaCBUNA6upxCnrOD40+B620tTWvpg6CDnl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYMschXM4hT5QdirT9F/P5bF0eCuwcLYsf6f7qx/3nQ=;
 b=YFkkelKURYL+hCVXlm+bcQ0vqf2eQRjAiorIkonI0yPcfv6TBXmuxOflaV2GG6D2ah6DfNllEdzs7U4Gf9qbf/M3WR6lvpwEiQxO+21EJAIDD5wm2azCNQG3dCVHv9C/urA4FvZM5mqxkUWEbL3guy9CTKR8NC6t0BjJgaCYWuiFS7y3zEuuo9q7z94F7tphZwJiTEhpzsVjCEvQ85e4lzNKbfawR/HSh70o3ygW/Q2THkwIuO6NRG+moRFbce3vtEzX7l6bVFj0t1kohb9b4WlCtIO4lOYFN7QsXZ7Gmu/kaRnYXWQjUy614S1YhPgKk/NnuiUobZBlxV8Erqcc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYMschXM4hT5QdirT9F/P5bF0eCuwcLYsf6f7qx/3nQ=;
 b=WOe1d5LBbYSpyzsBqFKsI79HCnaZ7PTIGp04HoUgN16nro0qeGKYHv3NshLcEwiBBoSvVFqoK6x7k6EPCItoFhlhoov5ehXviB1d2prRdAXnjgJxT9RaEc9flK74eqciyJQuXjskILUYG/ktudWGnAQRz3UTFTOMvj3MVQkAoqs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:10:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:10:04 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v1 6/9] mm: Change dup_mmap() recovery
Date: Tue,  9 Sep 2025 15:09:42 -0400
Message-ID: <20250909190945.1030905-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0480.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3427d6-c5fb-4d15-b4ef-08ddefd47b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrAD13X7dykpu1NOA4ZAYiwPoFyGS+kEt2G4TSZ+s0SJnzsmoC9CR9OLI65t?=
 =?us-ascii?Q?3mIKq1gMOSBOfStf+XHsMwWxvYdtny8HEvWOWTbLNtqBJZ0eEW+9HU6bj5p/?=
 =?us-ascii?Q?kyY8H3wIlbybpg/MjH4SHr/Ov2XxcjZzCwh88yvnNjLGxKZm9eI+TEM2y4Pj?=
 =?us-ascii?Q?P/BovjjRajcNRjnXL0llEFOEVAmvdFmEkU0YAAuLxzcLS+XPE0fyAN2f0CQC?=
 =?us-ascii?Q?kY2/Osvl4HaTa4j+QEoWQPXW9mzN2Dp/rT8/dwXetaaqHMlZeEbP4O0vEf4y?=
 =?us-ascii?Q?V8fyAGspTjtd3a90zKZnI4Qz2qHhiA2pTbE4Cn11XKw9EpZWjXm27fC+yCKu?=
 =?us-ascii?Q?2QN36hL/FLdAc6KglamtJGZMM6vDO0mj8CsdMWeYUYymSJnKMekaDUzSSsNx?=
 =?us-ascii?Q?hV98tAlLNHHsRDPPZAGTyqVYvnoSiC+ytRTP+ohC/YE0mnJxsK877wMgfTrK?=
 =?us-ascii?Q?ramQuKvn1N53AabNlC1gpppWF3MULCxuHBbbqQQz3DUenbgLuQtlaeUkbGsi?=
 =?us-ascii?Q?8F07o0KLViUR2qdOcIAO/Sk5KT1YHa7Seu/KrnRm00tbi4r88AiJapF+L0uk?=
 =?us-ascii?Q?j8Lok71DfjqM/G2efmftn2/JJkReaUw6SDgOJ2hD9e/J7VWDkFjzUDhyfaY4?=
 =?us-ascii?Q?07JH+sleQE8dJdl6hiCn8Qaqskf5M/wri2smJd7y3TU1gBOq4sXP7FZNi7T0?=
 =?us-ascii?Q?m+8U6nOZW+Mmza+3fZrXk4fRZg8FlnC6bfF/g9Bn46H08iISQAckROnP9xDr?=
 =?us-ascii?Q?LfVZR+RErpkIQr1YbvGRX31jdGiH7W8CxV5SAKRCuYVVNN4PPYswYEQPWjco?=
 =?us-ascii?Q?cI4/dH8UmF0GSUdSc8Wi9WPT45U1OwTio1SDzyfvgKMok+D/6/1BSi5zft6n?=
 =?us-ascii?Q?p1ghSo88gRHGFF4C/S5bRlkO1q5+y5Kl1KV+hLht85OudefSiXPmUOLROpWs?=
 =?us-ascii?Q?jNlJb4JwiFr/Ima5jrPz7RODDX/kPfwpyxyeW8eGNrmQ6rF+sxnZlky5rP7E?=
 =?us-ascii?Q?0J4BI+nqBpvqze8v5VJhytOx6jhuT7+Pg/4uUR/ZaOINgQQcY+v+uINgs/BH?=
 =?us-ascii?Q?76rQfFzTgIVOcGj3bsJxHZeu0KbKo0vjsQkjVlnDTzDxoN83Mv6Ar/5BxTBG?=
 =?us-ascii?Q?Db7avSOgETeKaINYZEn7T2y6UMVqCKj6TE6hJaaHG2VZUzb8t1Sj+DTskHqw?=
 =?us-ascii?Q?ifdivDCSqhdnGAYJokJ1rx3MO5riFxl1jDhRW61vumJjqD+/tIR0S+MD8/ud?=
 =?us-ascii?Q?z00fnb57IpBWuIxxQ4H4R4qZ9/yH40qmPK8phMTe5EBiBfi0bCyHSwzQFXhW?=
 =?us-ascii?Q?ATRjvUDG6nh2+rEtSxe39MtucZyL9Y1SJAMtecbU1Qh3NUCDtLFNFqlZbHAd?=
 =?us-ascii?Q?pDWz3CoIYWBG2rUycfCh0zDEiANHnVV/UQ8J3gtwDFxXOOdrI3ladTY+q3ib?=
 =?us-ascii?Q?RVIRvuTLTKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axjcLjd+vGelJbLRPXVAl0pfzm3zWVZ4iNMHONnBO8mUdeLv6ksIMy7h+K3c?=
 =?us-ascii?Q?yXmfzA2tjtNUrVjc/pTu5B6b3WYJOhloP4wySTfCllv5c9NvJqAW0M0u5npb?=
 =?us-ascii?Q?S2eIEQSjDYnfjFUQdVBpCfjhfw24FqeLxskjEjyuXy5j47/604O8i66RuChO?=
 =?us-ascii?Q?bGuc/PLFSK4YD+vMTQM3a+C+fsAxP9PpXgsrFW0aZz0lmDRveTIVrpQLa8RX?=
 =?us-ascii?Q?7IA0gj4zq31h9HpuFTrfUcfq4A8wj+0slfqAM+MA2T6IcXNLOCPuVYLCzudI?=
 =?us-ascii?Q?CboQny3L12VFxEny3oTdpsrL6ylfU3Ry1S6+yK9RLcwCRYf7iWmqNxcR6j5l?=
 =?us-ascii?Q?yJMbwVWZDbin3FRFxwoX/hVT4X4W+O7XyC7dEZ5AL1d555EaproShSn1zILh?=
 =?us-ascii?Q?es5+IWJBZCUNS2BG7uV4x3+vU++FnOsHkXh5o5Byvn/7NmQ4mbh3SRafEH8b?=
 =?us-ascii?Q?QZR4diYmYH3VnUIdR6BruCEmLC6wTAqRR4VgSMLJnNzvYMTpYIbqQaYBeZEV?=
 =?us-ascii?Q?/6r+8/oxrbJxsl6vzo5FmxcsDQWiXSHOLNCvkTSdbHBMABZDomKUiQlgsQ2Z?=
 =?us-ascii?Q?wGcAYtK/53dvjmmdpS1TS0kg2MN+56sTlXYrp+ArGSVK0xh9r4/WRWlIBnP9?=
 =?us-ascii?Q?Tyz+Yext4w8ja6UXb7o3JDnnoRjUaaVBo4oIkiTxn2/DIkuLPNPOpd6vjfyT?=
 =?us-ascii?Q?lATf4FO0+VdTbR1khC4yHTOd3cbkJMFQXW5oe8m9H0+HPInheY/3lUqqZBtl?=
 =?us-ascii?Q?Zu4znab/2FCRGQLT1e3L23AoYt0+SVZCinUNeuqahlDoRRenb2Eko7e+lbvO?=
 =?us-ascii?Q?EjBzj4oj4Q51IVNmLuqpaQ9d6ptWFkVnZNK3pAI9lNGLswgcYsXEruMXhpOM?=
 =?us-ascii?Q?E0rM1PQRZoNkIGYHuL5ryjdfP3TssGAfi71wViH9Z4POzeg1pOBNR/9nQhrf?=
 =?us-ascii?Q?lIaOpqjG1j+pS7Di4+7DmeCwrAz0hn3eUnfzZqf1KGP55BdUoEtSfLwr9XQf?=
 =?us-ascii?Q?OwAYnMbVv/SlekEKRWQPins//vykQEtc174WugcAcp/3/zsBZcrHQdmD9tVz?=
 =?us-ascii?Q?Tzf4UCwLHadgeQcHuA00RRJSZ1GwKgCZY69X3HtuCJDkkzB3Wl4AGTY1AGas?=
 =?us-ascii?Q?VElTcnBUTEgdsEBR1WdecwfijgLEx9jJPTruKe3LV5gacFFcc1Qb1Ggm5WFw?=
 =?us-ascii?Q?71+0TfzWm3C7NXldOzOntyniTSu7AG1v2LAYEbFyZXLZeaQ9EEC1BdvCAbE9?=
 =?us-ascii?Q?j7KsUO8Ht7lKOwpRE4jfARgwj7t5/jVRhwg9lB6+Y7ZoSw/Ei6D9OHPIAo1F?=
 =?us-ascii?Q?47zNyeHWIJq4Ik1kD6Eh2GL1VALdPnoWfTQkoSpjLAto7IYHg3ngNrcwY2vl?=
 =?us-ascii?Q?AODmZm9Hw0dOOP/2TB/SDIEef/YJbiVq/v2I8xqQw8060ywDyiWO9WhsqYVk?=
 =?us-ascii?Q?hPB3dza7iwUNbipDwpbOs0dHpcHcSym5oSIRCUvSHbggQS3ugq8TDouvXg5l?=
 =?us-ascii?Q?QQ4I+ns71NrkSjm0TkNohrZKaYR7ErsCXw9SBcZmIUFVqeDjrXsSWf4vGtT5?=
 =?us-ascii?Q?/xb0hIf15s9P8y50ueOK7xbnX2G7JYI/RqlRtutPsFy9VML/vrdWcXfochHK?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+efqXQzmacN9YxVmqtgeBJMGy2Je8WObDkdZDS8t5OOss7jo+WvC6WI1C3hK+Xu6iGF5B3VCqxpoav3a6OkSnRgEdbw3yGrR2Rx83SsVVnj4HbEo38iMI7LCY3PXULMWCYTw8xwy9jX30kE8pzhANL16Wf3sap6mSP/KYgA/LBRNO9PapIwUVoSSTOWDIzCYCjnXi3txjKuoLHh+FBEbFkwtF1y25F6iZrukYUVGqSiDnwYcqAyZGmIXWe7U4Y5/yaJe9W7HDTrwvIEjLhnNZ4opNimLsTlNguUNLGzViszOM1mSL9gA1MsY+aJXEjuWewfCxGOkzz6c3rAgKI34YrRK7OxB9aKAZd551LQx67HAIBwffARIB/S/FllMT4Nu8tuxq4+EzYEdxVJBVeln9UMwY2/fczIi23PqU3MExGi7BOKfnskrasOL75JlhMKgXwRGryJuRPyk3eo3lVHcfDWHjhyGMUkqckmRjyYai47fs1RMCJbXJExo1KcgGa8nGyDdf6WLHYdzmq6WhszXHSIlivLVwHZt/zoGmqkszq9x4gejw7GSMCYpzGJg5mZh2PqXGXj1QM/i4OMhGNHp7R7gw+H1z6lsFpU3IjI40gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3427d6-c5fb-4d15-b4ef-08ddefd47b4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:10:03.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJlsfepbdA80qtNGrxgV8xhj/AMcmdy04dWV1M4vDsSgUDZB60gKhD3i1vD/LPZtZKX8fnA+l/o2rrQP8cFWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090188
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c07bcd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GSebvwEjJFBsbC99ckQA:9 cc=ntf
 awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX7KPJF1wK6PFe
 xckOOY22Q08vQtZyNEALN7uwoeQBMWrJqcwkXLNzFDGuYcQdGPC0elJxeywfbhAknrGOKx/lSA7
 5jVMTMzxm0jc7nM180+vJT7foZWjA3YwgoIO+e6/L4d5dCRPsdF1h6D/RAnPba5dk/9M0dS5Af1
 BWoU7hj27UPAmvIyFI+o6bDl62JQ3haQagsRpIlWNESPVz8IAHDsFivzW/7YWFJ0r62l241JI5s
 yigwrX4XY1481/+9SI6rk2BcwrXKy84dlWjl1UDbn/uzq5hv4lsqVuKHTorgxOATK5Ud6JHtiNi
 oqvibdLAlWWUTNv9lUpX4j8kFMV7ArMaEJ8VUYHyDrYGPttOAtEDE1q9mI40q8+77jyCDK/kddU
 UoCKyPaN69QLs/rOerJPSS2MNF/zTw==
X-Proofpoint-GUID: DeUDRDHm8OZXHwh7FAn5YkedGW9xGfQ-
X-Proofpoint-ORIG-GUID: DeUDRDHm8OZXHwh7FAn5YkedGW9xGfQ-

When the dup_mmap() fails during the vma duplication or setup, don't
write the XA_ZERO entry in the vma tree.  Instead, destroy the tree and
free the new resources, leaving an empty vma tree.

Using XA_ZERO introduced races where the vma could be found between
dup_mmap() dropping all locks and exit_mmap() taking the locks.  The
race can occur because the mm can be reached through the other trees
via successfully copied vmas and other methods such as the swapoff code.

XA_ZERO was marking the location to stop vma removal and pagetable
freeing.  The newly created arguments to the unmap_vmas() and
free_pgtables() serve this function.

Replacing the XA_ZERO entry use with the new argument list also means
the checks for xa_is_zero() are no longer necessary so these are also
removed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/memory.c |  6 +-----
 mm/mmap.c   | 42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 24716b3713f66..829cd94950182 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -408,8 +408,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		 * be 0.  This will underflow and is okay.
 		 */
 		next = mas_find(mas, tree_max - 1);
-		if (unlikely(xa_is_zero(next)))
-			next = NULL;
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -428,8 +426,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		while (next && next->vm_start <= vma->vm_end + PMD_SIZE) {
 			vma = next;
 			next = mas_find(mas, tree_max - 1);
-			if (unlikely(xa_is_zero(next)))
-				next = NULL;
 			if (mm_wr_locked)
 				vma_start_write(vma);
 			unlink_anon_vmas(vma);
@@ -2129,7 +2125,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 				 mm_wr_locked);
 		hugetlb_zap_end(vma, &details);
 		vma = mas_find(mas, tree_end - 1);
-	} while (vma && likely(!xa_is_zero(vma)));
+	} while (vma);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 0f4808f135fe6..aa4770b8d7f1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1288,7 +1288,7 @@ void exit_mmap(struct mm_struct *mm)
 	arch_exit_mmap(mm);
 
 	vma = vma_next(&vmi);
-	if (!vma || unlikely(xa_is_zero(vma))) {
+	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_read_unlock(mm);
 		mmap_write_lock(mm);
@@ -1858,20 +1858,40 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 		ksm_fork(mm, oldmm);
 		khugepaged_fork(mm, oldmm);
 	} else {
+		unsigned long max;
 
 		/*
-		 * The entire maple tree has already been duplicated. If the
-		 * mmap duplication fails, mark the failure point with
-		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
-		 * stop releasing VMAs that have not been duplicated after this
-		 * point.
+		 * The entire maple tree has already been duplicated, but
+		 * replacing the vmas failed at mpnt (which could be NULL if
+		 * all were allocated but the last vma was not fully set up).
+		 * Use the start address of the failure point to clean up the
+		 * partially initialized tree.
 		 */
-		if (mpnt) {
-			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
-			mas_store(&vmi.mas, XA_ZERO_ENTRY);
-			/* Avoid OOM iterating a broken tree */
-			mm_flags_set(MMF_OOM_SKIP, mm);
+		if (!mm->map_count) {
+			/* zero vmas were written to the new tree. */
+			max = 0;
+		} else if (mpnt) {
+			/* partial tree failure */
+			max = mpnt->vm_start;
+		} else {
+			/* All vmas were written to the new tree */
+			max = ULONG_MAX;
 		}
+
+		/* Hide mm from oom killer because the memory is being freed */
+		mm_flags_set(MMF_OOM_SKIP, mm);
+		if (max) {
+			vma_iter_set(&vmi, 0);
+			tmp = vma_next(&vmi);
+			flush_cache_mm(mm);
+			unmap_region(&vmi.mas, /* vma = */ tmp,
+				     /*vma_min = */ 0, /* vma_max = */ max,
+				     /* pg_max = */ max, /* prev = */ NULL,
+				     /* next = */ NULL);
+			charge = tear_down_vmas(mm, &vmi, tmp, max);
+			vm_unacct_memory(charge);
+		}
+		__mt_destroy(&mm->mm_mt);
 		/*
 		 * The mm_struct is going to exit, but the locks will be dropped
 		 * first.  Set the mm_struct as unstable is advisable as it is
-- 
2.47.2


