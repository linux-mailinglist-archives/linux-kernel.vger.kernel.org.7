Return-Path: <linux-kernel+bounces-836472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E3BA9C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080A216CC54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF911FBC91;
	Mon, 29 Sep 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fq9z+ofD"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DE30BF58
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159237; cv=fail; b=dzPbqMuJi3Y/0W7K5SENAZ95/jHnjYVqUWKcNKe16+y69iFIhFfiKMGueN+x/GDs/CXWrRkUmsvjnXfKJc/RV2eCYn3BZ4J2h2+Q3oS+IUMEpz2pLyaiaTOTmOPKelV/girncUDrgf3c+xRiB2Bg4TyxQy4MVUTO+hUecDPsYoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159237; c=relaxed/simple;
	bh=We+Ur7XChgSiPkfNV+KjX/MEvZxgLGC0xma+ZFtkoao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5Iq1ZhEeRtGAnQeoAkC8ZBmN11WqxjFZ95vme5lrw2meK6rkBLmZlEunUULgMATblMujz8zOxTZDTrB95xRBV7T7v7bfnwk6Q/VPOWWnB6qSJN0thZ3S70SGgVXIYLg2J0y9XGBi6C8MyP9FtKgQscUHwZQHUdt9M1r07kPQM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fq9z+ofD; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJdxdFfX9h/JrPAMRgDiwypm1YD9aeKxPdf1LELLN6P60t19UcHkL9ku/TihTx5yp5y9L5cIJnRY/uE8LDHg/oD9aY2dcC6jBRF9eTPoAg+aIh0liGDFU/5tMUN5V1hnR9FmennoQNec+dlm3Wo/9TesoGOTpIAOOYx/L3pCbvsC29rQ74ekYFJCspFctUPeeHvkABwWZsRrN/SnujVLje8t2LaO7j874HoQO1HmxkkuBWlL9PNN1yeOklyOe0ebRJPvzszLk1kGqDSu9yUMcNlcvx99Bnu4SuLdl1bRGa4XAT40U35wMYp3g+erR8qJa224Y2Tr2hhWGAahbcRryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5htbbp4Ycx4/IC+AXP9+VSATZMoK+7Vl4+nCodaqck=;
 b=iT5xASNKYBZmeH+EPfoLHNLwTCcWFFXrOaD6LVx+WRzGKWJ6hpybkCSSH6pCUZ53Kl9qZ5gHoWPNMl/K5zCxVfGmFLeK77GPfZkeOw+viGDxaOiWKc+MCqwzfZUO3aKOCGA3COANEazhCMcZlg51F6gzzYBDMQx+f64DzpCoV+qaY08dlEDDrpt+qiOMqsqn59J7HKSjJR3diAh/ui+Hv+MUr3q9HL0FcyQj5YAye6FzvVmdWjSEfF1uFgSgestom/Q3o1Q6EeT8clA1JFubVtiIcmOI0So2VIH1oIoEw5Uorox5FL0wmLaDtpDTQeXkuQ4rxfr7iGqD2SvCU799rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5htbbp4Ycx4/IC+AXP9+VSATZMoK+7Vl4+nCodaqck=;
 b=fq9z+ofDeCStI8MHIrGH8diviwX6sNiqyPxKSsqtHw00e0X9lB/B8vC8DgEFFOFHIXXZ9wqqgdWRQhe/xGXBJLqinGHqIc6rykEVGJK6oZOdrbQjvMkeJi1T8daVKkg8XfFdfm7yRk6CG6JX7EtHk9jyNsefyzu45JIr7d/UGnXs8SAsGw/rB1OMErRTCOWVeAZ4EEQs8r5PDvxTNsWbdgY1TI7kSyZP00fe/zXHQ3MKRma6uAdWsP0Ul8v7hm2zmwR+IpCykneyaLACRHpgdxe+sPeCVoZneyRBJQaWxat5RZZBGSdHoajLv4RWVuf8mYlG5I5jP+YovasJ3tqHEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 15:20:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:20:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: David Hildenbrand <david@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Mon, 29 Sep 2025 11:20:27 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <CB2E9455-480C-438F-982A-AFCA1051BBDF@nvidia.com>
In-Reply-To: <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0671cd7a-f5a9-46ed-86ee-08ddff6bb9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZR7iM6cgy+s/Bjvcqo1FPxmcTbjEabfSbAmfPfkHQXxdrgWhJopPHphCr3+?=
 =?us-ascii?Q?Wd7Ez9sGJ0mdgybTErbRkUl3p6nBNtprWCJbrPu3vN3tAKMZZR5WLjznZQRf?=
 =?us-ascii?Q?4sH6STksdQPp9tD3u7AXmvpClxOVJSEbt3UuQZZgcqqvyd15l7WXgI/h0afj?=
 =?us-ascii?Q?AGE4uDkYoiatGXZ9edmM9oDYtCVbtprBagAN8bdI3xRaFfrAnkBC/WjHFmzP?=
 =?us-ascii?Q?Y0GC48Gn5xl9ESzoF9d/SV+KbY7kIWUCc6qy6/79jaqGv3MyYDTM6e7/FuVX?=
 =?us-ascii?Q?NrQQxo3gRuroF5gkdaXfaDn6r+s2WA2atst0rMacQwaGNt0GzSsYG3QqbdPu?=
 =?us-ascii?Q?HO3+db98KZIjiYKompfzGvAjfMxDRWLYhmqH3pa45oCR5Z+FCd9ON6gXiKDg?=
 =?us-ascii?Q?zYBdAqHGnpdhyKV3n/TSSZ5wIpuUJvsn9dBgpjh6eg4XiZQn7wQ0MLga/uf+?=
 =?us-ascii?Q?NJrqp/QL7DgiQn3ql+iqHPNTEluBJCOnSPtsj+N3qQ5nSyokgGiaX3R4GjHP?=
 =?us-ascii?Q?Li8lHzPyrtoowbONbisrZd8tYjeCxQpj6MIxEgKC22ektsbMCUjVIfCmbx1b?=
 =?us-ascii?Q?zJQvZZdT+0VuxGtxC427vi0uUwDhvxCvag3Gt+eFupnN7yi9Xi4WKe1AMxQt?=
 =?us-ascii?Q?93kpIuAN7gp61O1YedXQOpDKaqCJ7p4txvg8DGreKHfOsQ4Gwr9HxyfNKDvW?=
 =?us-ascii?Q?PCeNKlTluIfGsZAr9cciGw8P8VkQTMV2rCK1qm8YDzbK4YXXiVaM874iSGmZ?=
 =?us-ascii?Q?MMKoBTS4KjpgiInkYeWWYrZlvylYnNH7NBNeZj0ayCBKUrPwIu6a/3lwXaXZ?=
 =?us-ascii?Q?w+GWiAudmsRkHhnMIY0zxMc5hJIoIbN1+GVTBzNuUZ29cFya08/gTIEQN8dx?=
 =?us-ascii?Q?hz0HK0A4JI5dvGIUy9WmKXGVYw5ZxsRoCxX6SScISUXdzZyFNfahwHBrUkTV?=
 =?us-ascii?Q?YvfqWyYIhIAn5kR3nwCLoRBmuSBABYh/nOMeFEU3jphknCRUBQHrrTs9F4ql?=
 =?us-ascii?Q?PZcYGEJ8e7cT00Iwqza+ZD8TcR+nyZnfrdaXQj6ZGyMH7wFYsi2EYAolPMo9?=
 =?us-ascii?Q?buyn6DbATu9WO+BMCrgOCRvt13V/LLuVdpWwcY5XOAU3gma0Ek1MrPjML49o?=
 =?us-ascii?Q?wUqliQbG4YAp0OO9A7vngH11FnvztXCre4LX8L3dAtFHwIs5q8rwJL2//gmg?=
 =?us-ascii?Q?sO7JFCuvXEHpz59qpHBAP6Wly7uO/vOjsCjM4nUgOAEz5eoJu1CW09NYX4xv?=
 =?us-ascii?Q?3HfghHpD4dhzQ0F5UnxiK5Y4dlKjH735BX7PLP90IAAPm6S//9+p45bTqeCG?=
 =?us-ascii?Q?0puRBQwaF2AXgIQPVhJGx4nJgV6Zg6CK/we4ZtMcm4RN3uovIuENeaBhI6TS?=
 =?us-ascii?Q?zgZWVhG6hKJDQvctJce8IdLMoq9/V2Z+V8neXolCQ6B88339/Ok8JuUMNoOZ?=
 =?us-ascii?Q?Yu3diKKv2Z4iYQAkA1AchZ+ynv8qjjXj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iruELbQCTl0dyN4VLgdOwWFn/AEwP7ze/fyEha9yiNNjWmJW2JR0BBCoaQek?=
 =?us-ascii?Q?uWSXsZ/uD14QcVyg0lBUj6/JKJFrUOpVuzwY6wVWhdx1wM+AO1JH9cS5JXdu?=
 =?us-ascii?Q?P/scDHLGraA38C/6jWK/OZnqMjBI3pM+bjMslhxqH00zUWoSfxrdlPSCzZqd?=
 =?us-ascii?Q?I0FM3KJM9HtdPth64g45b23OmLvOBsmnew4EK3yWbpYELyd8wR2OnkPK+6Pa?=
 =?us-ascii?Q?j/JAm44YF1ci0kDszYTGWJ7zqxLI+tFcwAwWBvZ9nOSSAS8xTsA+I5ME14Vr?=
 =?us-ascii?Q?hWKtbdjAengqH7EZWF3Idc+9yR18P4EKVhNeHr8Fg5j2Dd0NNETHz5a4Kqhw?=
 =?us-ascii?Q?GLDP1Aw7d3DUtR7WrWvupsgqhPNmwe1JcmYtbKFyF1Dq+W+6mEjTqeByxkKp?=
 =?us-ascii?Q?htxIuETzezbnj3F6HKKHj0c7bpPMqcokAKDcADCjhpLNu+vVN/g/FA57TpqX?=
 =?us-ascii?Q?+6McaB0qOj7OhGJ/FbSr2vhb2lIuaCdb5Mv9CjvWDE8rs21/q2r7Y8M3kHoT?=
 =?us-ascii?Q?ddnNxt0GKHdypcZC6dk317v/xqXB220tyHZFwwNLka9iPyGo6c0Y8sHSlcXq?=
 =?us-ascii?Q?Q/Ybx/+2jd93aq/UimPpYLAB09siLgHwsKY6XH8D/l3atAzDCGfRDVtcalBC?=
 =?us-ascii?Q?VdEQA++z+fU/+jxoSKdRQlmPQ3fG6I8fxvCUg8n6CmovHgBo4C03KxbR9rBd?=
 =?us-ascii?Q?yF3e3Hijtg8+kRXtut40f5jAiI9wFNziUwU2/Q1/UgMWLIkj4hgJGjPXWX/s?=
 =?us-ascii?Q?/VXOMMrpuWFjkKYuNuifc7TaOj1/7c/dS+7dzRSpWm3Ld2kiQoDvRwrQ/eD7?=
 =?us-ascii?Q?L2me6NQHqQ0xww3TjWAZfUPHt2GztX3+WwLUmFkNVijK5xg/e9hVCUBzg5Jz?=
 =?us-ascii?Q?z/hMLE9judCJKWhYpSuURWLpeTYVr5K7guJOF9czei0PrK6q2onF44d/VJbf?=
 =?us-ascii?Q?mFvdGuzt47396eKj1B43U6Tv9soYgfjRkB4PHVZTiq3TlMkPIHAFjZhW1P40?=
 =?us-ascii?Q?T5SHcb18yF170tgpMQdmNzNH7aybr+aYWcv08xGlFORG2xUClzi0PHPaAhGH?=
 =?us-ascii?Q?keFf7UYDDvRJKqK0E18Khx/57+HPFN7WnLHZ7dbgbQJithjKlY7NmUOg8eNs?=
 =?us-ascii?Q?e4WlG0of7bFAYm8ILyyVT/hNhPW+xkk48hzyVSeCdAHksi5dGnxSiW503yDI?=
 =?us-ascii?Q?bM2GwHRfIdNndKIN9GT1jCa1WDKv5zIrL20kHdkXBY/BxQzgXDlLdHOmjYsK?=
 =?us-ascii?Q?E568HqHNT25bm0ewE3UFZn4CCytaPvFBgxewnKI95nLWZqcq/pTXgyG7UiGy?=
 =?us-ascii?Q?lvXD10JBzTpkxuAzS437PXmFI+gkmL80O5Y5kRGN9sqKasHRmGlz/XyL62Ve?=
 =?us-ascii?Q?j4Z5I49gXA9NdYW4zVyYaqw43GfbDmYvtCdcktOXjZk9gJE/hAtMG/zn4ujf?=
 =?us-ascii?Q?Af2e4YWGXV3yF43DsQgVKdySSt0dXHVnvTRlEE/NiuUtMHkF7v7PMIbB6Nq4?=
 =?us-ascii?Q?xamuSiYBbefwTPWqrAxKbXK2y7xQ4CV5sYJ0js4s1UZZi3BIJ31/EgGRaSY5?=
 =?us-ascii?Q?09bkPyVvcd5YkkyzuRc9xtFqQzK2TBRHiEevzNQV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671cd7a-f5a9-46ed-86ee-08ddff6bb9f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 15:20:30.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAkztPUKK80YK7Sot8IoQL4IVdw4pFnvFDKAkCv2LBLztAk0RLqhgXKt8K6ITsSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

On 29 Sep 2025, at 7:08, Pankaj Raghav (Samsung) wrote:

>>
>> I want to change all the split functions in huge_mm.h and provide
>> mapping_min_folio_order() to try_folio_split() in truncate_inode_parti=
al_folio().
>>
>> Something like below:
>>
>> 1. no split function will change the given order;
>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_=
order
>> is smaller than mapping_min_folio_order().
>>
>> In this way, for an LBS folio that cannot be split to order 0, split
>> functions will return -EINVAL to tell caller that the folio cannot
>> be split. The caller is supposed to handle the split failure.
>
> IIUC, we will remove warn on once but just return -EINVAL in __folio_sp=
lit()
> function if new_order < min_order like this:
> ...
> 		min_order =3D mapping_min_folio_order(folio->mapping);
> 		if (new_order < min_order) {
> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> -				     min_order);
> 			ret =3D -EINVAL;
> 			goto out;
> 		}
> ...
>>
>> WDYT?
>>
> I think it should be fine as along as we return an error if someone is
> trying to split < min_order for file-backed folios.
>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc985..e15c3ca07e33 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -387,34 +387,16 @@ int folio_split(struct folio *folio, unsigned in=
t new_order, struct page *page,
>>   * Return: 0: split is successful, otherwise split failed.
>>   */
>>  static inline int try_folio_split(struct folio *folio, struct page *p=
age,
>> -		struct list_head *list)
>> +		struct list_head *list, unsigned int order)
>>  {

OK, I will send a proper patch to fix this. Thanks.

Best Regards,
Yan, Zi

