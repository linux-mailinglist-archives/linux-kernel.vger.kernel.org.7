Return-Path: <linux-kernel+bounces-843664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABFBBFF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 050B54F2AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36411C5D7D;
	Tue,  7 Oct 2025 01:25:17 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA74192D97
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800317; cv=fail; b=qYDvMtBse6RLc1nhV608CmyC7i7mUCntpfN/6pi6HJUkcGneMiOK8VnnAdK4nQondcX6S404nujk9wftvNAupGDY+B3IBZj/LhmBs8a4B3+zj6dyJxyonZ0ZTbJQqhSrmLXBBaGlSNkG88ZDZfPJmzGbUSDJ2ObPSZ1xQpb1MKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800317; c=relaxed/simple;
	bh=Jicht6/5sKO3CMSX+qzOrsVjMy2DBd8kSlcJLw/IBj0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hW2hDnhaq1TPozbQom+thRt8oFdszjC3YGqRyNnSJxhyUZptkj8pphgERQlJwl592vbdWeUnzMY0Q0VIwC6hxuvX5C5WVE5sc6xKH2BhJt3E2wSQbcQxUxlj+1/wzpHm4ZN6+BS4ufiQ7D1VVGboPaS+9iouI4QvlH3Iq63G2/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmA6nwAeHhn1+YPlnmJTziI37bfnrWtIuroRaMQynPxmxibtADlgivvyM3hxMaONdsdhnRH08aJhusO74QDmawdQ3dkHXsk9Ry6xIk7EiBxY1HpZDKaqtbb5qERU5HImzrD5ntLv8aTa2abE7eT48PdupSsBodhqrBQtKTkoGO27MJtmFoh8XB6s7YcA8bP+qcjQrZXkysijLgqRrsZh1Fn1Q7rVHCAlD5GMs+JQDE7ohwwWsjo7zLWMvhA73WWWYNoEHl5LSpw5k2G5uEe7eyNmSPjHowaS+k5mJ1mPLQ3QiAb6FXSYB9EjU6cfAlRjyrP+XE0/DVG7SAT4zLhPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdjmCTao4t6f62jwaOLj9B9ZaSbYkwQzVtb+Y90gnEs=;
 b=PTdwL63eUhzrJetIz872ArCxz19jakqkBhVEYX5YqSkhi8g8nvdIUQNMIlItRjoLiZu/Iap9nfUJiqtfzrQUt1u9FQ22p0yUldudFBqIc3gyg1Ejq9z1wm1c59qBcdGE1vkVrgADoVSBmvM1rPrxHPsoeFuKY8vzoEJSTu7Tp0NoSJ0pUvHKB7LTDBCit4RCsFLGadlDiuhiDWjAaKzc4Zv2gQ/flf257h2G+CauW20kF/PVKxm9EI8W6kEKzrLmGWkQXAXTtec/h7Uqn2oggyRLugyxvDJVXBDzNMD3Yj3Yx0nX59j7vlvKMh0lVi4xnuj9XGNPYrHRw99ikreJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8319.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:25:10 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 01:25:08 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] tick/nohz: avoid showing '(null)' if nohz_full= not set
Date: Mon,  6 Oct 2025 21:25:03 -0400
Message-ID: <20251007012504.16118-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d8b398-282a-4cfd-1abf-08de05405a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXF1bXpGRkRFbjZiL1ZqRnRVL3lNYWVhdkY3UnprQ0hnQ3hQNUoyU2V5U1VF?=
 =?utf-8?B?dG5TZnRVMkxBejRaNk9Fa3M1V25VZGMwZ0pCdUpwdGllM3VKRlhqQnVzR3FT?=
 =?utf-8?B?SU4xblhIWWhuTHM4WE9SbEtPNHNrZ28zaGx3eUZZa2hCRkhXUEF3RkNqa0RR?=
 =?utf-8?B?Tkc5Zkp0SjJTcjFUMHFMeDdmbnBEL1RWcnlBMEYxU3RLOXVDY3ErRHdrdDln?=
 =?utf-8?B?OUdrbGptVEtZU0F6cnpSRmU5RjhETndkWEtJeHhSVFV6OUx2THJGK2c2REdX?=
 =?utf-8?B?Q3BqM01zT0hjM3pzajRRTFBTYmJ3aUVvSThZL2E2dFVhZW1WbHJxRXFXMVdY?=
 =?utf-8?B?UlAxYWg2MUVoTHErbmV4MlNIOHhZSWQ5MHRHQ2dmeERueEVIRHlPWWl5c1lz?=
 =?utf-8?B?b0Q4YWVjc1lETUM1UzVBMjNxWlhBS3dmUk0vSWVlTGZ1NHBDYkhBbC9ZK2R3?=
 =?utf-8?B?RS9BV2ZCOERUYS9ucWpXbE9KRGVoQmwyQUtDK3VnUHV2MDIxOW5Na0lxUlpj?=
 =?utf-8?B?S2h2L0ZLa1c5RWtJZHQyRlI0M0NHd3o2cU9zc0daZGN2dDcreDFmWG5WM3BO?=
 =?utf-8?B?Q1B2bVhqclR2bjdXRUthbk92Y3kvdW51TEd0RzlncmE4Mmo2V3RHMlp2N0lP?=
 =?utf-8?B?STdDL3gwQVI5OXZ6THdKSWl4cVNraUd1ZEFPbi81eEI5a2tnYktPL2x5V1hv?=
 =?utf-8?B?NnIzSDZWeWxSdkxZZC9hT2RFaFhRSmlMaWJIN3NuMjJmSVp2d0RoYmZORXpV?=
 =?utf-8?B?RDFJbTByd1ZtNnZpeW5pUWtPeFp6MllwaDJ1eFJranlVTGdjcUE5VjZxbmxG?=
 =?utf-8?B?UUVMdTgyZ3U4Rk5aQkNvUVlFS1BLWi95TEdTQVBJZ1N5VXNEb0VJZ2I0TWJw?=
 =?utf-8?B?M2poM2hDbkk4TDNJK1UrMzVGeUVvYWtHZEFRV0JRNzdyK2RraUF5dHlJUnpO?=
 =?utf-8?B?ZlR6LzF0T2N0Y2VSMjdSckNoQUFLNU9WdHJQY3FYQ3FmVjNONmlINlVJckk1?=
 =?utf-8?B?VE1PUy9xcXhReUVwU3NQdWFPSzRtMDRuL2RsZXVWRkU5dGhYUm1IRTN1NmFo?=
 =?utf-8?B?UHdDbXNjMlNia2pmQW1pc0F3Lzl6a1FxRWYxNWFtV2VRVWRoV0VJYkVYWFBy?=
 =?utf-8?B?aEZkNGRCQUI3SmpvNUsvbmFmZ1R3MGZyRTBDS0hkYWhLYlM4SWdKYTg2aGV6?=
 =?utf-8?B?T1lVSEhIRGlqT1grUTJDS2MzVXAzcWR6b1ZIb0FWREYwRU1YdThVQXBCbmdv?=
 =?utf-8?B?QWJLRUNqRWZTS2JncVdkblpSaFlVNERXeWlxSUFjRWVSRXJlSjBzcFhMR2VU?=
 =?utf-8?B?akc3WkFpN2x4TGI5RDlHdS9ERFlOUnQxN2Q5Q0JvYWpWM1ZMSm5DdVVqV1o0?=
 =?utf-8?B?WnlTL214M2d4YVlwNlFQK1J5NC9PYm51YkIxSDQrKzB0T1dLTHp6MHJ5S2x0?=
 =?utf-8?B?ZWlrRm5zNVJDRG84UDhsS2tNQ0c0TGJrV1JnSjNTNHU5NGN2UE53VVNHMC9V?=
 =?utf-8?B?VzFmSDN3aUQyM3JlN01BWjY0U01GQWl2NW5vUEZLc2pPSXdhYmE5RHpod1dk?=
 =?utf-8?B?bXlyazNiSS9MVjFsMGYvSms4VzB5SElJUzhveHVlMC9jUUhwM0c4b3EvZ0JU?=
 =?utf-8?B?cDV2RVN2M3BLTUhmcVh3S05HVThLZGtSS29yWVJHOUFiSXlxd1hJT3d6YnNP?=
 =?utf-8?B?YXNXTzFJVy90U095Z3cxS21GaXc0SVJBcjFkcWs4TFNhOEJuMEE3cWF4a2hP?=
 =?utf-8?B?ZDQzcFNjaHZtdGN6cU5iS3hxQXJjMjRnNTdXcStkZGRESzZ6WGZTSzZqRExZ?=
 =?utf-8?B?aENIaFp4ejB5MlphTnJPNER1VjNMWFhKQUFwVjgyL0JrazJXckVXT2JxNzUy?=
 =?utf-8?B?cFNJS1BQTmNDZHc4bVpQak04Q2w4MlQwRVN1TWwwZVpXbFZrY3JQeHk1cnl2?=
 =?utf-8?B?SmxESzQ2bVJyaHJWQ0NhRkVjaEpNdkxZWmJmaWVMbS9KV3Rjck5VbXM2R3lp?=
 =?utf-8?B?SGhoejl3eXRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHNsSDhPV3NNa0lJRnRiUUU1RUgySmRsZWRTUkJvb2xoU3FURlgxVnJsN1ZD?=
 =?utf-8?B?ekM0RVVZL0xnS1BLQmozUDdLa3pRaEl2d0RITUR0VjJsYit3dWYvNDJBa3oy?=
 =?utf-8?B?dmZGMVdtYWZRMU9xQXdvSURlVDBzVkVGWGhaaXhuZkRQTUxIWXFjWWVkVVJ5?=
 =?utf-8?B?MnFuZmZOMklZc3RqRll3bWlQdWtSc3NjaEUweUFZcTN0QWVYN3MvTmgxK1JW?=
 =?utf-8?B?dnkrNkpWRXV1YnR4M1E2VUI3RmpJeFowdHBMWW1xekpsM1p3dDF4NWRFeWVj?=
 =?utf-8?B?SGhsTW5WNVoyald5TERlYkVRZmZYZUh0Ujl5UEtxZ0YzdUp3N2xDZnVabk5T?=
 =?utf-8?B?NmphTG5aNkRxUjBVYnRqYTZ2UnRBWkVUZ1lSMFBTMFUzcks3NHhoZGlEaVdE?=
 =?utf-8?B?M0hPWnNad0R2T0xUNnlHNndOSmUySlpPTkF2dTM2aEI4bWt1NWZpZjRYRHMx?=
 =?utf-8?B?UE9vMGRHOGZ3eXc1OENJZVEwWThYQUtmb21oVGhHRDRlRUhkck85Y1ZUZmlx?=
 =?utf-8?B?MVRLcldKVUF0Ty9WcDhoS2VmSXljUGtrSlFFVEZMRWFxck5MdGtlbTRkZDVN?=
 =?utf-8?B?SjFvTU5sUzk4aUdFMGd4QzduQ0c4bFhIMDFIckVpQXVoODV0TnFLS0ZFMVF6?=
 =?utf-8?B?WUlPWC9TamVSYlVEdERwaHJmS29vRlpRdjVmei9MY3hVSllob29YcTBhWVBa?=
 =?utf-8?B?OUhlT1gzRlk4UHloenE0U1ZyblJ4YVFrZE5Nb3dhMnBMSDloVW1FOVBPa04y?=
 =?utf-8?B?WGhTa3R5VnpXczhnNndXMDlSREJUc1lwMVljdjBZSTBldW1KanNiT0tWa005?=
 =?utf-8?B?dVdDbFdhSDF0SzhVWlRtTWN6MWpxZUJVSlRxQnpkZHNmelBicWpiV0FHcHVn?=
 =?utf-8?B?REkvclVDZFhnc0VCbHNXdU1XdzUrUVoxdVRrQld2dEl1TXNubHdROCttaWNL?=
 =?utf-8?B?WkpXNFNnZlY0amREYzY2aWcvajFJc0ZPdFYyWnhhSUQydGp0VUVLQy9pTWZv?=
 =?utf-8?B?MzdMSlphZFVEanI4Z3YvRlAwR0JTZFlhTHhCRFJuUWhIV1dmWHoyRFpVMFdy?=
 =?utf-8?B?SVFBVTBKQjVOMldQblVpZm55Nlh3d3RWalhEQ2JwSGFmbFF0dEw5R1dkVllX?=
 =?utf-8?B?RDdQZytIaGhTb3NlMGlIUnVVUTllUlhrOVA2WWFoRVo4MEtsWlZVRVJ4NU42?=
 =?utf-8?B?NWtPSzAxNEozWnJDbmhOSXNDZXB4a2NFUkJHK1VlUkdUenVDS0swOStMWDhM?=
 =?utf-8?B?WjhPVTkzajZseHdpYjYrUENlQ2FyRXdRazhpVUF5V05rT0dyaks4eXVDc3VX?=
 =?utf-8?B?T0xod3crMFJnMTEweFFlaytXN3NuUzBpNkhKcXVPUjlZZHB1Z1IzM3UvUG0r?=
 =?utf-8?B?Zit3d1hVdnJvV0FIOC9FWHVKV0hleUNVZWpURy9YMC9EKzRsQzBnTWZER25J?=
 =?utf-8?B?R1NGMUpBTVBSRTVKenMyR3BLVkZKZVl1eHRkRWM0Sjc4bitKbDFpYnFLWldG?=
 =?utf-8?B?VkJCVk03TGpweGtBbnBVQzlZUEpTeTcvaVBQUzdmbXBVSWZsS2czMjQ2NFNS?=
 =?utf-8?B?Ui9uTENrL2E4VmZIbytMUXF3VmMxdmJ6TUF4bHRYS1hYU1k2KzdpQzBNNm5u?=
 =?utf-8?B?SThFSzBiaW5UbUliL3YzZHdoWDAxWU1hanIxY0pvVTNQYWlYN2tVZUJWaTFs?=
 =?utf-8?B?R3EvTHlZQ0g2L2JTY2FoZ2ZrNkVvMW1pcVZKZW0zNjluT0VhdDd5UHNpSzRE?=
 =?utf-8?B?Rm44c3haZnZVSE1GMGtlUEw0NC95VjJZRG9oRFVhYkVkSm80USt6N09zTW9X?=
 =?utf-8?B?NUxHYk80NUw5R3JSN0hMWXM4bjM5dEd1a3YyVmdIK1FtNGxUUE1NaFA2RTNi?=
 =?utf-8?B?ZmhIVVJ1aG96NitMWk1wVUFQMUVGZWhFQ3gvSWN5RUtUQ1lLb3JPTWttMXhU?=
 =?utf-8?B?aGRuOVp4V3l2eXloREtiK0Q4eXhybWFRaFl4amtob3VNUGRVd1ZhemNHMjRp?=
 =?utf-8?B?RjNiVTU4c01xWlhMeHpsK1p2TUFYNVYwc1R6d2grSlY5NEMvd3hWaTgxVmRX?=
 =?utf-8?B?MEl0Zk9GajdGR0VRSVNTMms2VFdvVGwyQWc4emxyZ0N5SEo4dDhEL1dGZ2tS?=
 =?utf-8?Q?Px1TNj7OnBTKDi6e9NX4/z+gp?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d8b398-282a-4cfd-1abf-08de05405a3b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:25:08.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIBWfCeE4/CJndPoyOkikOdc98f9nu7qIuofWkyu6TRUEtfXbk5+qYWniRkwfAq++08KvvATex6hcS6KAjoTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8319

In the context of CONFIG_NO_HZ_FULL=y, tick_nohz_full_mask (of type
cpumask_var_t) is initialised to 0. Memory is only allocated to the cpumask
data structure, when Linux kernel boot-time parameter "nohz_full=" is
correctly specified (see tick_nohz_full_setup() and housekeeping_setup()).
If "nohz_full=" is not set and an attempt is made to read
/sys/devices/system/cpu/nohz_full, '(null)' can be displayed:

    ❯ cat /sys/devices/system/cpu/nohz_full
    (null)

This patch changes the output to print a newline (or 0x0A) instead of
'(null)', making it consistent with print_cpus_isolated() behaviour.


Changes since v1 [1]:

 - Refactor to use an if statement (Greg KH)

[1]: https://lore.kernel.org/lkml/20251006005824.76187-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  tick/nohz: avoid showing '(null)' if nohz_full= not set

 drivers/base/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.49.0


