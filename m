Return-Path: <linux-kernel+bounces-827697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C9B92703
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DF116A90B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0953314B72;
	Mon, 22 Sep 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PyOYK9sj"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020133.outbound.protection.outlook.com [52.101.46.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46628312D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562294; cv=fail; b=lYnlr3QOdSuNIk9+J4/bYThzyfqC6ZOchfHy8xuMJ081BYwDEB0SB9dsGH+d7pYzyI25Xmdy9wepPZ7ILQ1YQ1E5azJE0fecXxDCtJ8gDfZfFAIYMhiLiE1fYV4nqwRb9rZ2IYkcsxZuX+LbFxhj0M1nSkDn8SzuJI1k0Si0MiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562294; c=relaxed/simple;
	bh=KY7xwLO6MsbdpWgxCC5L0qBFhaV/gFdd9RumB+wr6mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LUedMpv5WIpgwnh1xwMKDEZ9ITPHXymNEufa7+q3fmuWAzrlzEd89xp/a4Z0VQPzP9mxaMELfPTGe3eJwCBAKns4AfCSgEOWnVJamcEkduFKVt1LWAKmJ7CqhpeCQa2eLsCEN34YnIdqwUbizzVrrjvovbzFANKAK2OxS88qGpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PyOYK9sj; arc=fail smtp.client-ip=52.101.46.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLjQgwHWhXkemODq5n8UFjgplIwlClZh6JcZx1SpyQ9IiL2LOB7nNzo4p+t2OB7mbz/J3jubiggblPhbCB6w/WUydJLIIk8MPyoyS3d6dCpnkQHsck4lCKou0uBapGtZXnXXayzIAEmJtsx9xPT0VTFiFvhGa+TSleYIsJTeoNnW+vgr4jJ+PuSaJC9HlyNeztNXEKgaZxw4nFa2FYcHFDhy6hfkzczHN1LeC2qarc2xyx2eqUz5Z0fZaAFkgM/wlxOldV1JvI2itDRmqRWwW6HXgr0NAbMMkbroPoRVB7AvWzNSPOU6gQZwWw1rlKUBJBO1UsOITDVggMJur53OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q63S/pzCmgYAeiItkbGNfFpVxfO9EDvNlnRPsm8kCck=;
 b=wmiwGR647B0zcXnLKgeO6DF7fAbqKttl6sA0JD5Ic26SC7A7cgmKF222pVaSZb1SXx7YZ3O1VsCNtSqgJ1FwT1p9nZdApwHuWROxN8nOdYr/MOeFEQ3ntDT0tAn7le9TEygzcRwsm9QiErRziztx3bWOH1JW/2UDu/Y/ag1M68gXCNAhmZOQ0ELIdbd8Yv1RH7mR2zSoTZKFpa+WMfAnc8ymxkNLJweSKBDNd+ktnHG9AZkywO5+GNvNuklMYE+qttWicU3QKRavcva66jHaHCRNbP9KxSiU4D1Djlxwfm1lv6o0CGZrDtcsYW40IqUxDD2Mwm34gmUYEOLWOpzgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q63S/pzCmgYAeiItkbGNfFpVxfO9EDvNlnRPsm8kCck=;
 b=PyOYK9sjepL1l6yphU0bsPvw1Wc8Em5o30TpBIhMl6gWjo19sNe1VHZwQ3dwV9d+O0bsHPE2Y2LGCo+OCSHdw53mySafiYTN3+oQPX+7OHB7ZrxVT6ak7Sl1vroTqCYpLWOha+TfEUDJ91KxO1ACRrXGnfnM6WpgTtMHLEcmr6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 SA3PR01MB7917.prod.exchangelabs.com (2603:10b6:806:314::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Mon, 22 Sep 2025 17:31:28 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9137.015; Mon, 22 Sep 2025
 17:31:28 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
 <james.clark@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
In-Reply-To: <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:31:17 -0700
Message-ID: <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|SA3PR01MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ce0df3-5c01-4978-b71e-08ddf9fddcdc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BywBKag54E7GoVc1R3CuGl6+Y3RtrmFZGtz149scBrDwXqlbDg40uJOj+KuR?=
 =?us-ascii?Q?KacIYwGKAvYh8azUjC/T5ACHdruB8/7Yu/j4J/UTS2u9WmdqySpXKEHXuviF?=
 =?us-ascii?Q?hwdObOIrfNk2f6Z2yoa4U6SFYjihz+1rbdFCSGNJKVfCunHaplMkdjtGL+hG?=
 =?us-ascii?Q?QkAtmPuE7aS9vIWo/7G6dBtH7vssXVjM4Ljqkkj+pXZr4fqgxeRmLWj64PMW?=
 =?us-ascii?Q?SCROm0DHbuXM8n06HpO2Cdj6+5UrWW35/wnpxiyoSTeVutY0bM/NJxWMQF6Q?=
 =?us-ascii?Q?HwC/4syQPb2Cvlndl7myZmRyxSOCyGoVXyTHdqrA9d9OaPeKDtpE316tgy0f?=
 =?us-ascii?Q?3BlyAP57uUojdJ0YqIPB8+HbR4RYN3gct/WrMwUZJ+615ekVXbKmB2P4TEIs?=
 =?us-ascii?Q?yRgsFRrQFSvMg8Q2dT1MuLF8UnRrRDSryAPs5XuCrBsZKZmtOei9P31rfAII?=
 =?us-ascii?Q?pGlAnm+RTphuqm3JfMhy0CBs/VMIqb3w6Nb8brmHoWllGLZAAbpFNwNh9cBX?=
 =?us-ascii?Q?HowDBWyG5EFAKpVqACO4JPFvJeo8e90IUof3bNJEWjCESYNSpAQJxP9T/F4F?=
 =?us-ascii?Q?KT7A9bDo7nLDI5EgLB4FBw6UvoDAkVoXDoP9G15qlEsRhwVvCI1cpdaCbWWT?=
 =?us-ascii?Q?GWc/p3O3JinXTQtVzMFYyj7pdxFJQJRU2sTC12Fpml4cWA59HKK3vRzWBLvu?=
 =?us-ascii?Q?Dx4A2fec2YaoQc0APUUYfmv52E/AtMMLSc6OqiOqJMhmSZBegAfAo4IBmG1H?=
 =?us-ascii?Q?stFQHn2aU+8Uv4TmvTUgwgGM9+Hbll87ScDrb7jaDd0nfMUNOBgTYswxckNP?=
 =?us-ascii?Q?goVIZrkGuCJ7n0DdcapJf66IW3HAFDbZcxusmpikzKjYcxUzLTbOEt7V1o9r?=
 =?us-ascii?Q?sByzm7RNVhNItXxRSJGAvSYX3pwHpIRpWv4MXfnCmwGTa4GkhzS9FyTfhDzL?=
 =?us-ascii?Q?H3k0xZAffjz9Azf1XFKIXrW/C/SIWWiUWtI3Qlg3ZK29+1wnumQT+WiJF2kT?=
 =?us-ascii?Q?0GZzcpDoZtAXrU0UEnX8LlB4KUnGJ7FzI1kR6YZilGzdmJX0nxoMVodG5GX4?=
 =?us-ascii?Q?EdUWBbq3H8Vkb8fLZIM4yJlvByhufRD3JCnpdigAdVbkBcdn3VdMrlLTsQVW?=
 =?us-ascii?Q?x6qsM71T/mQN90KTB31YXqFa0eJYE1IxLDAUbiFHsaSDZ7OalXTMUgfMoljp?=
 =?us-ascii?Q?lDvEOTx5IzSDO5o02maj8ybjgnvM+TnqzxJeiFoAeYEXu3Fq8wbIrdcM8OJc?=
 =?us-ascii?Q?xotTKEdPTQ51yfAWIjIULZKa29DOZJVs92aD4WaiU3Cw94NlI3+Z3hlAHPPC?=
 =?us-ascii?Q?vj9AybWpozyWoIFflVsuT40vdGkg1HRowV1xb8jtjtZenu23HG968LZWArH3?=
 =?us-ascii?Q?FGpUEzUW3cMp9QfeMnfb/JIgTHAlejhsKlD411tSs9DXsjx1cQImwQI6QXOX?=
 =?us-ascii?Q?PQvxzg2oIT32Le/cq9u7kv4bkp0PfA2xBa3rVTlDadSm78cHYZxLdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzEhRClpFnkS8aEu21ZyVlYb5HQ+aw0+7vnqZwzJFatpw6DkEaqScuqpupsX?=
 =?us-ascii?Q?zs3tFTBXvVW03kI8SZxQuCInjatVKDlE72+Si+uSO/V03k3m7DVRSyCoyHyk?=
 =?us-ascii?Q?2j5zYYgB/HrXz26dujwNyGMeJwoxWG+fxL207lih6yPrlMEF8isKPLu2DT5u?=
 =?us-ascii?Q?sUR2qnor9c4pXhRIolgbKUBAFVcJ8X6r9VPm94Ig+oR/RygpN2dohmva367i?=
 =?us-ascii?Q?O3hX24MhxaRRiXn1NXjVZF/OdufGRlClOV4tNmUTksdNbWnBgXaFp0EjK1sb?=
 =?us-ascii?Q?wRX2fwhfNqN8q9yG5rHMF1lmVd2q6DBCfLmqhw+cKNjcjo9Tk6ntI/OKdOaS?=
 =?us-ascii?Q?GaYkO7M6kQIHKoy3lVVNEK6n7Qo7uUvy8f2Vfp/O0NPQpQLnSmFUTsvldpku?=
 =?us-ascii?Q?glIcXs198voW9YuV4S4oTAg0qmqMcwT3UadCY7cMFa5zt+TtY0pHNDU+z4jW?=
 =?us-ascii?Q?2yKUPNap78u97qMEJuyUE1WH+GrhMVZ2dZ7EaoG3NczQzGW9lKAh1LjVdUEH?=
 =?us-ascii?Q?sfas442+0Hk+dcUSmNuD17SDJaIARWklJcDXlbOIQatN8UJTegeOXwnPBogi?=
 =?us-ascii?Q?WYZyIZ6uiF9l51e/qyQ4Ie6pG1RJwFqiRxSxbDepDz3ccm6Una8CULTL3jMm?=
 =?us-ascii?Q?0Nm9dlklHu1wWd/diwMxwBsSJPZYIHhwWCn3xc/iPPpj6yE/LerUMeQvQ0Lb?=
 =?us-ascii?Q?q4Pz/Cw3yEccYlNjOAVfGpn7DmxnVqcB+XKe0vidBBEn62TrRSekWta44nUU?=
 =?us-ascii?Q?TPxw9TbAOu2zFaYZM5MdZO0Wpic/UXguBrpK7BFLN8LkyZHoAArlcTO6Pbsm?=
 =?us-ascii?Q?iDkdgYZbGM6GnDkwh3JMXIIADqJljd0pMtvTByaESBz1DAlyX82ng64fr6Nv?=
 =?us-ascii?Q?6uSHvYFY/wnkkMbFWYCjo6ROj8IkQXG0rJ8BbBg+T4PmGFyo9RRzjS43gunL?=
 =?us-ascii?Q?u4YvdxGPl3y2UBquAAzAxn56+Lk9o1Y7UI5ClosmrtLdC+EK7gdRz3WES1XA?=
 =?us-ascii?Q?sifbFus/w3mADERIkLOHDAHoeY3hns5453+xqcpv6/HnkBIPs9MQERkDu7Wx?=
 =?us-ascii?Q?+MOi5pj4Ht6VQhWJKZATkhd83D3SlRdnEj95D43kCbrQIjAEzh+gS5KuMrsu?=
 =?us-ascii?Q?7J5X/uisLbpiPfQLoZ7AL84BINdGHFWyBSb2B4JWaB7C+zf7GoNGXYuR3yzR?=
 =?us-ascii?Q?nfTTiKqah7vju/c1tLa0GePt21uRGaycMws2dQ3QIr0hQN0Q61Gtwi81hvc1?=
 =?us-ascii?Q?XPhvrK9bVj3DHtz9txHdaPLi9JjRruZJ7w6Ef1ZubcseA50IZSVxMOU8TJgJ?=
 =?us-ascii?Q?FjYQoQiLonI1BxFmr/8NW25XKu0g5QhiwxQOzRUZW0wxMVA16NkoUx5hm41V?=
 =?us-ascii?Q?v1gwu2qHVxJDWD2pd90+k562ZzpRh25G0E3qHGQ8hdIKqwMNRqSIBURz1BxF?=
 =?us-ascii?Q?/4/uvCYBO2SS3uMDELxt3F0q6rpQ87v4FqiRgwh+3R9b4DINpO0rWDobE96B?=
 =?us-ascii?Q?HJiiXFxnsozqOlj36uikrag99b6FITBBb0pUu6YHpXLgjFmnPUit4rD7JtJh?=
 =?us-ascii?Q?WS0C2cnBN5I0/XHoeK09QIgFIZ6miJzF4e6xBRyl8Siw2ydr+YIqSJLhVRJu?=
 =?us-ascii?Q?OPIpN+OllUEOafL61y0Nqzw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ce0df3-5c01-4978-b71e-08ddf9fddcdc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:31:28.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+jSv6F8akhLAIm2EdQHuW/TooBuSUWDbRtax4Kc0peIcgwGcdbxMrnZI80dHftkN40/4akZYmsPJ9jTmJjt3rStgLD/zAfBI93a05Sye/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7917

Jie Gan <jie.gan@oss.qualcomm.com> writes:
> From: Carl Worth <carl@os.amperecomputing.com>
>
> The handle is essential for retrieving the AUX_EVENT of each CPU and is
> required in perf mode. It has been added to the coresight_path so that
> dependent devices can access it from the path when needed.

I'd still like to have the original command I used to trigger the bug in
the commit message. I really like having reproduction steps captured in
commit messages when I look back at commits in the future. So, that was:

	 perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null

>  /**
>   * struct coresight_path - data needed by enable/disable path
> - * @path_list:              path from source to sink.
> - * @trace_id:          trace_id of the whole path.
> + * @path_list:			path from source to sink.
> + * @trace_id:			trace_id of the whole path.
> + * struct perf_output_handle:	handle of the aux_event.
>   */

Fixing to "@handle" was mentioned in another comment already.

Something about the above still feels a little off to me. It feels like
we're throwing new data into a structure just because it happens to be
conveniently at hand for the code paths we're needing, and not because
it really _belongs_ there.

Or, maybe it's the right place for it, and the cause of my concern is
that "path" is an overly-narrow name in struct coresight_path?

But if a renaming of this structure would improve the code, I'd also be
fine with that happening in a subsequent commit, so I won't try to hold
up the current series based on that.

-Carl

