Return-Path: <linux-kernel+bounces-734092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A30B07CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6F63B6FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08A2853F8;
	Wed, 16 Jul 2025 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0zU+Ofz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p9kzqrzN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F17346F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690786; cv=fail; b=PonrGsH17Zlvmnz+cIeJEaWKkUEh7xv8rXMBbJ7V4XWEl37pvwnDJitfHFPo+X+hDqGl5C35NmaDNm/82IwdZO2/jwWm8BCWPjxeZ7rADcnACCMCfKxYPXHMxbirbEOZ+AxNYnMaRfdi2vYDRKeTB5x//X+stGHtl2kuX9I4/Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690786; c=relaxed/simple;
	bh=/wTCqFwKwN0wh/t5yFNsLEgZo1nb+LTHIayxhQhekpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7KdKTZMXa9ea5T+hlTt1D1FvhZVFIr2WOlBLIyiPdw9iKkASv2fh8Qre2MHh1xpXeZPw7hYF3QwM1dRG8rXXnibT1ONnF4AQW5YeqdzzPxqtnCIv+t2HWV58NN4faG8m4jy5H4qORidr/Gd7g8K+ry6weIMv7gOMUdbiUjnLX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0zU+Ofz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p9kzqrzN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHfmsi025770;
	Wed, 16 Jul 2025 18:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WKWIePlY+sQh/ZbGX+
	aoUHERjtutQ7DkXuWc0OfEw6U=; b=V0zU+OfzNjYSvQa7/NFTbab7boO+i+h1to
	RH7OcF8yqe46OLpix6H1VLnnrxCoTJnbS9aINAiQkNm1v26TxWpoBQLsyGJfy+3M
	l5WH0pjDNCnq0FnV3AmgW9UiO9Dkf3fi9jkAdmfCHLYjrHo2foESszcDtoQXB8Ns
	ZJcbm6nA0+gJR642JT+qsU8bpr9xfOzimGs89oq/M6VnVJDhTyT1FiMraglCClIw
	H558b/f/dRSupjO5QlUQi1qBW98Dg1DezzL00oLQOjMgIowX5C6AxXB53xjgljmK
	y5FekRev+iSFgKmNRxHmwJUxPp8gycX6btEsDP2TYdrPKNwioqFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g1kuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 18:32:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHhnSG013526;
	Wed, 16 Jul 2025 18:32:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b7e6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 18:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbOh5TnEySFYKHhWJiMOm87jAvi5JXHGWnBr20k75W7j2t68/GKSFc5pwyYqieNmei9WnscYK0DAbqiNCpYPF1J4a6CYagiBNPF8cKy8/qJXSnzkaUsu3FiH4vSohf0RriffKALhTYyrYKSD2JUvXj4+98aqwSowfGwJUbKCHJOkcELyu8Me+QSR/qTsrGzAtZzPmLZJbuJo5j/3wkTG30F2yUfS+hjfRP1EglqXjQ6EDNFF3AlzSNqpVou7aRh/x1WpAzLSv1sUU5li3FNvbODPvekfrh2HMI+EU3LK4CYYdbrlvAhI9lcBxAYmnvglDKzhv0MwW6Uvyk6bGPG2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKWIePlY+sQh/ZbGX+aoUHERjtutQ7DkXuWc0OfEw6U=;
 b=l3stz6YgRKg3piwztNEoK8RhkT+NHMI9P6/pUnfeBmjIVcbjaXjT+iMbixWCsYHTK/Qw2GzL7Aq51c1yY4XXDksphrvZLFyKo5afRNkR6598bGIJD1GAbplXcjRGNNZRriNvjLsL3WJPi0bz950MqAZApUrrQxFPaYy63J9UdB+aZ+cYZKCF/ercsWfXJI0sj0mb3HclXouM3qCP820k90xcW3OqjDvW7ZwkYqrQQKeR+1jkAm7GzFUGNp60JsqpGv1kaWgM+sGqFSkQ4dcUFVzSoGAcRwOI5oJHX+GQoFDtPiGSPwk/3bGqdntgHIZxxY+VG89NV4IeqtGfM7uf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKWIePlY+sQh/ZbGX+aoUHERjtutQ7DkXuWc0OfEw6U=;
 b=p9kzqrzNF4dFvAI4Z+XAPDiqCiOJCVQjdrzc14pRaFiBUrquUxRoTg25ugPYRz8m18BMudmDNL3zbvMS4Ymtf0Kv+hwA3t/Wp25tmo4n35DZ2bC39vLp94lHXkR5p0vykvuoJzCsQWI9bxZevy1xOaEKqDDP7Fri2YcVj/e7pGE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 18:32:46 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 18:32:46 +0000
Date: Wed, 16 Jul 2025 19:32:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <91aa73d2-bb28-454b-8d23-a277f29c2adb@lucifer.local>
References: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
 <ffeb2324-a1f3-4252-8f6e-4639bc37a151@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffeb2324-a1f3-4252-8f6e-4639bc37a151@lucifer.local>
X-ClientProxiedBy: LO2P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::24) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 175dc1e6-38b0-4d1f-c33c-08ddc4972935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZR9zetadoPxwj3LGRQiarLxGEcnj9ELcyyb6fgvIU/gziJlBrlCUuewGVs6?=
 =?us-ascii?Q?F6GW/cVrtwXkwDl7RFF5cdxryHIkvKfwbipso2EWp/YQLLn5d5e28PYpqQKX?=
 =?us-ascii?Q?CuHPlDtZt0eDOr6WvAoD8fW2h8ApYsSmS2+W8a0U0JLODaq1P2jqem/t8gGk?=
 =?us-ascii?Q?ma5Jw5MUSjEnMswwnAeIL4SnGVl8b3RD+86eQWbIIUjtQYcf9Cvc7KuXPzOK?=
 =?us-ascii?Q?P3+iypHal9Bcy+3DhcZBEm81MkOvL6YMa0v9wHdwK+fJP/3+VSIKZd81rq5I?=
 =?us-ascii?Q?4jGe2tRLap46URKXqywxBHsPNt11SoxDPwBe+IU6GdzGkHNTH+k10jX49oeW?=
 =?us-ascii?Q?ay72jzVx9Exh6o2vuPg2uU9tY8D4OvN5N4Y6tfRTvt3j20jBRgpYg+s0S1id?=
 =?us-ascii?Q?H7tpi3S3gHhgLJLAAdWneZqJ2st/ECpJvk7+gtMBsjBw5bXi/OfxrQMGQqJy?=
 =?us-ascii?Q?niVCsKEhiq0jxutFWYlS/kzIZHgCevWencunj8g8af58DQzzLKoevJIwqY+K?=
 =?us-ascii?Q?o7xt2dCZ2ZbLzqq0tN5+leVrsM5UyWJQR8Stg1AQ9JVPFSPXnhDzrDSQm6Ex?=
 =?us-ascii?Q?NcgE3q6qiJEdWiIItLC1ppPeZxZSGG5H7U2QW/ssWxNhJPXRVlLmYrZZBDu0?=
 =?us-ascii?Q?SmSzn1wBcm6wxdveQ2cgE4YRuXj1SXVm+nIXx783X9DSscbDUqYY4nQSr38s?=
 =?us-ascii?Q?l0Ha5hUyboI7SueisT/ohBViPF9hBpALXOmBkLKaxWhiHImhulBz1MWB9wFF?=
 =?us-ascii?Q?0hmLjd4dXBWMnRM9cs9lmQWvxbb/bccoyTylHEn38xiLKyH2viiMrSV0Q6ze?=
 =?us-ascii?Q?ZuzDSoKjtIrUEtHvLGpzECCBkW6D35ucxaEuTRfvAp1JaQQX3gRwzQ5RJ8q5?=
 =?us-ascii?Q?RdNAgVvdMFet006nOp5W5M+UBZVy1TOGOP8hjFpYYea4+d3yLNTwG7DWTPPC?=
 =?us-ascii?Q?yYR+93YRqyf48qs+TyXIqeHVc6nyz3WkjrdUFtBocIh3b2WvAwlPjG0fbzF7?=
 =?us-ascii?Q?n/pBB3fndqVn5hAQDQ1Lf7HfHtxfxfgCY2bz91qNG3gvH34XeyxDLiUstGEQ?=
 =?us-ascii?Q?ILle+L95sHpbzeuA53cnoZH09gixcpBPhxWLm23YRx7hHSqL+FSW1iXtmmbl?=
 =?us-ascii?Q?vHMwoZ6V8Km2qpBjgZ0TC8UtCf8raKR08XGUQzmN/zzyZv5ZITTyK7sbj7uG?=
 =?us-ascii?Q?jW/fySK+00q6p6Zc6ArTe7m9LqDsO3yV+YlMm8Eo9RygV+o9lXPYMFyzBm0O?=
 =?us-ascii?Q?IUlkLqV6SVUnr6ghW14xteLJoUMvsI6eGU+c/jBrTEZqpdDCAX7QH0dFKr+K?=
 =?us-ascii?Q?DArjh02PWa9eZiXjCq3hNwEbZVKw7FrAYBw8R40CVAPIczTUI1xqwmg3XakK?=
 =?us-ascii?Q?cwE/bTKpb3xd7j1i9MjJNfSYl+1C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?879NVmlV22UtHqdZsjsqXDWFlQwalf6+JRJOdIVbZfZz1IJQYT6kW33nZUir?=
 =?us-ascii?Q?EnoHvb4zEJEokGT671G4fnB+BKMcisgVqnKeXp0Kvew0vsjNbOGNGcHuZYRq?=
 =?us-ascii?Q?6s8YPjGe58T4kHM0lPffeaNWxGUaFOnR0QIx2MCcHvyRzrASBse/Jek+403Q?=
 =?us-ascii?Q?r4Mg2CeESi9H76n34OhDY1FzZpJ1SPBuVclMyimFJzP8GPtTjKSqP33u3T0C?=
 =?us-ascii?Q?+YneabLbq2bJN24P7T9JhxVaYp17IfDdvniBKb+o9zEe/EfaBBQrLpDKFtNe?=
 =?us-ascii?Q?Ke+VTjk35nmui/oALbHm7Ki6HgnzhFmTMpdSWW8bzwfgtdrbXc9uFUku2+lw?=
 =?us-ascii?Q?6q3O95gs0F0Qp/D1UGT9vRojvu3BLrKuj7z7/MtNSIRSilHWTlxwKt1TOVa/?=
 =?us-ascii?Q?nOnI2es8e2HkqftOj0pN1E92T9DkT1iLv4TO/A7M+Mf0kGcO/g1BzWldPkD0?=
 =?us-ascii?Q?3UMnEKAGsH6hgDug2IFs9JsjGtIea2Q9JE8YOV8GwXk6IjiJoprRs7X493v/?=
 =?us-ascii?Q?I8UWHGsMsVWiF/M2TkRX8qRj4dTqxKUfgw4kowlae9/Do+1+4HVxZoG5Fh6F?=
 =?us-ascii?Q?jjRBVlo4R5cS8qrjAx0SjeFewlEGMvNkrkC/U9FZYK8SRGHE1GHiieSr+G1m?=
 =?us-ascii?Q?pYyqO5YIZ92qdfSHgSmkf9OT7MkysRjGCSmxIyltLz8NamzR/6c24aJhw3hd?=
 =?us-ascii?Q?1UZWe/BuGPs71LVLxIp857hmftbOZI2AX0tlfgcFRM9AYyqkIOdwkZrRE9Ga?=
 =?us-ascii?Q?nctqqpLaibkBrIl1kLjwDQrb7SE3uVM/SDLN4vqoZRVqISegFV45b8e0iEYE?=
 =?us-ascii?Q?QoxdJUGb1ISzgor//szioz/61EZo7XWHWwv8N7dzjkksYWINgTNae/kc6zkc?=
 =?us-ascii?Q?YqPrkmrK9mT7/QEtwSiWQ6GKoG1kGFVVnxBNtLCg6m5GGlSIOZ+eLWA33wZx?=
 =?us-ascii?Q?grMo6YQb/dgjL7iY7F+e6tdlXT3EAIISOajAfV0tmZmzhAZ0DqBAohN0smso?=
 =?us-ascii?Q?uLvLFJiWS+8pJ6Ub5N5CSDSJTaoqqUmvMKYIlNdWCQx+b0/QFyZCnbPpbRaz?=
 =?us-ascii?Q?edW8Ioh5590t71LlaFw2hQAJitBtC3VPSIuS/9/GkPAURXPwbGoO/sxFyPzj?=
 =?us-ascii?Q?SIx391G8oYgc5jxix2nHhunI4fKAtfhzxH+66ZtuXIg00sJRhQEI7EgMkcVX?=
 =?us-ascii?Q?0dICNrGUvpIovawnAWchkN7tW8peeBDRabAOWY1hu6eWxZ7OeBNvUP6bBZ/3?=
 =?us-ascii?Q?YAW5SNvNuurvSIAXVttNnravmgzBln2r0/lELx82Qczb2dmeFg6FAsoSZpsb?=
 =?us-ascii?Q?CHEMXzqVxgS4MctFj0Cf86zrEipcCsdF3n3JMeuBFb4IVwNtZnnjuNOZ1UjQ?=
 =?us-ascii?Q?mFnHlnhDEnVTKObm7rnSQshCEfMD/TL+oxfY9hQ/noU7m0C7qITxnmBnj87/?=
 =?us-ascii?Q?okl/Te0YbzjwfUmhX+3rq0v/+aM68X4vwfV4z6zDGEKX4j3Alxxbndp/lFgN?=
 =?us-ascii?Q?rvqMqub/wU331eZsrpbtMNpVm+992+PruH/gYZUjJJyvdVGNk1Qs58P0yyEH?=
 =?us-ascii?Q?L8lFS/x2qvXuQ4XYRWxqs6kFnBuHw2YnrXuwRCUTvS++7BRvw73AfZj1qvNl?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	re9fxUglyOfUlx2MYjq5eo19qsRt45dnSm+l6E6Qs0lM+scfWW/kjOjqFmT/4UzYsVkZU5K4BkdBDHJXScJtLpM0N5+Z0WTSYz7suNg4ht5aA1LrYbNLYKtbaqIYRLQQu5xFD5OsVm2SLJDO+SvJ/FaCm36RN2lQ9BhJqWqZ+m1Kf/86+0Wf6RQNKDrQwfwmKL9MyeZZn7cJTP+PRLMDVUAEKy9eH+UvMIRdmPERnZU2oi67Vu15k89UKwv16qW1xQ+HnDdpe5wrxa4wOCVXke5LzbdvzOWKrcnxZsia5o3oj2h9c0OivIVLdMjFEzBFIKoypulm7UI/WXtsLhZEJE59UyYch0np6tBH1cz4/eIaUHsb/553dwMruHjjZF6FwSRicPOq86OCkfJtHk8y4gZLUQpz8sM0PATou3dD/VeEUhlQku465ejukAFnyvSVZPChZbLZ84vD2ue1tWmLcE6wuT/c1DDw24ejBXWLZIaOqp0+n7D+NY20hEq2Kz5iJJ6XgJWzl8xUxaMAB+Oz00y45ukzIbd5LjrrapE/t9iear1Y4INU4hp4PAnPrNtkMMpPfuvjVwKUXHJEP/5iqOJc+/pJhS02pIzFbiTEFSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175dc1e6-38b0-4d1f-c33c-08ddc4972935
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:32:46.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a81JAs9KQ7ogWE5m5jYWoKYnMmq6JeW553fIUzD7JHnsDMpRiFZXs9HKI/9miuDWwNla0HkBDaZ9zoueAzZwxrMuKm2dND6yqpKk8LjKqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160166
X-Proofpoint-ORIG-GUID: u1vjEpR6kxqmTR6jCLTopmedjcasAhw_
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6877f052 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=SkNZRyk0QqBBsvxwsGUA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: u1vjEpR6kxqmTR6jCLTopmedjcasAhw_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2NiBTYWx0ZWRfX2oVjwjjkxQdf 3pjUAhisNHkTgNS1h86xm/MJuiWwy0uZ88nN4nu/LkL+4DaQ+D6xQ0QDuLfiCRuanNtVPeqb38J u3ln0lIvgWv4wXgmlSp5OgoiWmhevwJ6lL7V0XWFc8ZqpAaqJ18kIEXzTB65y9swqR3Jlcskyco
 MvlrQgz2uIBhVvmL+SbIBrp+fJ/wnd+oJu2kk3rXdP8REVo5zZwck1PyoM4itVaqkYCoMWqEu/i o/a8drHUYb35ZoK+6EW5d+0pf/90R67Jgu0Bh/0ksmgMV4yLTVKo+n99U57TRO9F7gXe5FpfhhR adL0BTCP5gxLD93B5z4SBLzNRLpITfF+ZtcYJo+37BDiKCaQjv+8/ZdOHL3dYBjuB1LZk7BSwh5
 nZFILj1fJum3F/1h79xXOODnVQjJFDk3PatgsWXRr79HV3HsFJfe0xsDdkXD2pd7BI17wExr

Sorry, I'm operating on not much sleep here.

Disregard below, this is valid, we currently permit MREMAP_DONTUNMAP as
long as MREMAP_FIXED is specified.

Sigh.

The repro doesn't repro of course, and there's no bisect. And the dashboard
references reports unrelated to this change also.

So this is rather a painful one.

It'd be good to get some indication of reproducibility and how long things
took to reproduce.

Let me look into it.

On Wed, Jul 16, 2025 at 07:27:36PM +0100, Lorenzo Stoakes wrote:
> Thanks for the report.
>
> This is due to an older version of the series being in -next which allowed
> MREMAP_DONTUNMAP for the move operation which was incorrect.
>
> Andrew - I guess you will merge the newer version to linux-next soon?
>
> In any event, this report is therefore bogus.
>
> Cheers, Lorenzo
>
> On Wed, Jul 16, 2025 at 10:55:35AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in ma_dead_node lib/maple_tree.c:575 [inline]
> > BUG: KASAN: slab-use-after-free in mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> > BUG: KASAN: slab-use-after-free in mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> > Read of size 8 at addr ffff8880755dc600 by task syz.0.656/6830
> >
> > CPU: 1 UID: 0 PID: 6830 Comm: syz.0.656 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xca/0x230 mm/kasan/report.c:480
> >  kasan_report+0x118/0x150 mm/kasan/report.c:593
> >  ma_dead_node lib/maple_tree.c:575 [inline]
> >  mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> >  mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> >  mas_find+0xb0e/0xd30 lib/maple_tree.c:6062
> >  vma_find include/linux/mm.h:855 [inline]
> >  remap_move mm/mremap.c:1819 [inline]
> >  do_mremap mm/mremap.c:1904 [inline]
> >  __do_sys_mremap mm/mremap.c:1968 [inline]
> >  __se_sys_mremap+0xaff/0xef0 mm/mremap.c:1936
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f4fecf8e929
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff93ea4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> > RAX: ffffffffffffffda RBX: 00007f4fed1b5fa0 RCX: 00007f4fecf8e929
> > RDX: 0000000000600002 RSI: 0000000000600002 RDI: 0000200000000000
> > RBP: 00007f4fed010b39 R08: 0000200000a00000 R09: 0000000000000000
> > R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f4fed1b5fa0 R14: 00007f4fed1b5fa0 R15: 0000000000000005
> >  </TASK>
> >
> > Allocated by task 6830:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  unpoison_slab_object mm/kasan/common.c:319 [inline]
> >  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4180 [inline]
> >  slab_alloc_node mm/slub.c:4229 [inline]
> >  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
> >  mt_alloc_one lib/maple_tree.c:176 [inline]
> >  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
> >  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
> >  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
> >  vma_iter_prealloc mm/vma.h:463 [inline]
> >  __split_vma+0x2fa/0xa00 mm/vma.c:528
> >  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
> >  __mmap_prepare mm/vma.c:2361 [inline]
> >  __mmap_region mm/vma.c:2653 [inline]
> >  mmap_region+0x724/0x20c0 mm/vma.c:2741
> >  do_mmap+0xc45/0x10d0 mm/mmap.c:561
> >  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 23:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2417 [inline]
> >  slab_free mm/slub.c:4680 [inline]
> >  kmem_cache_free+0x18f/0x400 mm/slub.c:4782
> >  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
> >  rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2840
> >  handle_softirqs+0x283/0x870 kernel/softirq.c:579
> >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
> >  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
> >  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> > Last potentially related work creation:
> >  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
> >  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
> >  __call_rcu_common kernel/rcu/tree.c:3102 [inline]
> >  call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3222
> >  mas_wr_node_store lib/maple_tree.c:3893 [inline]
> >  mas_wr_store_entry+0x1f1b/0x25b0 lib/maple_tree.c:4104
> >  mas_store_prealloc+0xb00/0xf60 lib/maple_tree.c:5510
> >  vma_iter_store_new mm/vma.h:509 [inline]
> >  vma_complete+0x224/0xae0 mm/vma.c:354
> >  __split_vma+0x8a6/0xa00 mm/vma.c:568
> >  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
> >  do_vmi_align_munmap+0x25d/0x420 mm/vma.c:1527
> >  do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
> >  do_munmap+0xe1/0x140 mm/mmap.c:1071
> >  mremap_to+0x304/0x7b0 mm/mremap.c:1367
> >  remap_move mm/mremap.c:1861 [inline]
> >  do_mremap mm/mremap.c:1904 [inline]
> >  __do_sys_mremap mm/mremap.c:1968 [inline]
> >  __se_sys_mremap+0xa0b/0xef0 mm/mremap.c:1936
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff8880755dc600
> >  which belongs to the cache maple_node of size 256
> > The buggy address is located 0 bytes inside of
> >  freed 256-byte region [ffff8880755dc600, ffff8880755dc700)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x755dc
> > head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> > raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> > head: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> > head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> > head: 00fff00000000001 ffffea0001d57701 00000000ffffffff 00000000ffffffff
> > head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6828, tgid 6828 (cmp), ts 120765032919, free_ts 112542256570
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
> >  prep_new_page mm/page_alloc.c:1859 [inline]
> >  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
> >  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
> >  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
> >  alloc_slab_page mm/slub.c:2487 [inline]
> >  allocate_slab+0x8a/0x370 mm/slub.c:2655
> >  new_slab mm/slub.c:2709 [inline]
> >  ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
> >  __slab_alloc mm/slub.c:3981 [inline]
> >  __slab_alloc_node mm/slub.c:4056 [inline]
> >  slab_alloc_node mm/slub.c:4217 [inline]
> >  kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
> >  mt_alloc_one lib/maple_tree.c:176 [inline]
> >  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
> >  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
> >  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
> >  vma_iter_prealloc mm/vma.h:463 [inline]
> >  commit_merge+0x1fd/0x700 mm/vma.c:753
> >  vma_expand+0x40c/0x7e0 mm/vma.c:1158
> >  vma_merge_new_range+0x6a3/0x860 mm/vma.c:1095
> >  __mmap_region mm/vma.c:2666 [inline]
> >  mmap_region+0xd46/0x20c0 mm/vma.c:2741
> >  do_mmap+0xc45/0x10d0 mm/mmap.c:561
> >  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
> >  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
> > page last free pid 5955 tgid 5955 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1395 [inline]
> >  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
> >  __slab_free+0x303/0x3c0 mm/slub.c:4591
> >  qlink_free mm/kasan/quarantine.c:163 [inline]
> >  qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
> >  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
> >  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4180 [inline]
> >  slab_alloc_node mm/slub.c:4229 [inline]
> >  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
> >  getname_flags+0xb8/0x540 fs/namei.c:146
> >  getname include/linux/fs.h:2914 [inline]
> >  do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
> >  do_sys_open fs/open.c:1450 [inline]
> >  __do_sys_openat fs/open.c:1466 [inline]
> >  __se_sys_openat fs/open.c:1461 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1461
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Memory state around the buggy address:
> >  ffff8880755dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8880755dc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff8880755dc600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                    ^
> >  ffff8880755dc680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880755dc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

