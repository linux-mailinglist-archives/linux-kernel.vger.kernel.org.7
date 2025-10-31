Return-Path: <linux-kernel+bounces-879477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406C0C23359
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC214023D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C72857F0;
	Fri, 31 Oct 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cC49Lh4f"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022129.outbound.protection.outlook.com [40.107.209.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC363283151
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882603; cv=fail; b=fxVEMZWAf6bYIaQ7t9ssSK3D42hqpLbRZESRsV44/vinlGljT1ntOr/Nk1b7fBT3mTNlvMmEJiVrSekoLtZlw4HnCoa/JLG2AaCncsDCntg3/YU7ui81pPEc9BqXWINKKYWwhM7AE3AwkljhWlR2xvn2YTfOYoRan8EJj5aDhwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882603; c=relaxed/simple;
	bh=UUL7SNL2zrRwKlKz2bjb0hQD4E1DRf/w7ahttzapXRU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UW44EsEcVCFjEygf2vBTWINYBzA5+IP2Nu+75kFrEcPVP1IVFssyvYYr8YvUsRRkN08EMhg9py6bf24FNjat0DKVv2KsLEj0RSxpRf6EDMm2I9iEXxPnTEHQ+QYWCrKOved+6ZnERmQR+pdERBIXPJL3UsSWFmEnJAKMeUoCmB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cC49Lh4f; arc=fail smtp.client-ip=40.107.209.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yORU8D73rSOJNF1Z623yHhyDAZvKbzwwk0dDzDOu4Q1Q9jMXEKVlkxq+FR9a+XdcQp7ipDU385Xc0cVOJJOSbr5RsU4cqQdCB3odgjl+9mHHHReZuIFnK74puZaAvSxzwaJHDAEcOVLjNYfT4YFTqpTN4kssC02KDSyrrW5jJ0RjRtSDib94roR8WAB2btVq1M9662zxRAW4DDfB/9APKw2baFPBSSoAddpaadn0klkYcr5RznQ8xlcyMOlhFUg8lmEzClCQuO2cyEYVSHwiuRPMnLudgCygnlOAbb3xemLFMdlz9OEP26AFA8l2an5QpBf9tguv2tx5TKxLnh18aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhtBCgBNaHdkFxfK++fI1K2tyQdnDAZWDLcdFqxeIeA=;
 b=gwK+XiyLWCTt8CoPF5lDQGb6fLj/h3cjvZ1Gntcl1+yP4xU2kvQ3tHxVioXmTcnSr+U+YZfgVYA2PTJE5+aOWjmCmt1khy5WXUusqCwInv8423t4gQt3zUnNJcDUFI67gE0mIQoPIOK4YQWPrUijT0CVDFAdW8Jtlj3mK924jd69eMjY2NBQOBGyGScf5p7OBwJExQ5teguwuy9zqo7hjZCyCQ4qju5EvI3TPb/STIhYopjWOJEirx06/k7y0M7ips1q2w4RdrrrmLnoiLa0Wwxc3U4FJ6bOPutsjV8PLwdc5RbxHJ1KyLYf9jFjr3jC2zp52bj1xuiq5J4XhJZFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhtBCgBNaHdkFxfK++fI1K2tyQdnDAZWDLcdFqxeIeA=;
 b=cC49Lh4fyzO4esbmnzHfV6vNnX9gsYzMO8chxkNoxzjPdSY8ZZT0rvYajVjmF2C9wFVjo2RdNefkE5kVejPiltt9UvfogK2Nt7lTuNpNdvxVlG9AvJj3IptX9OpgmgVJQsQAfoIQwzE6tzl1Codpo+DthUS+GBcww8fmxVFxjyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 LV9PR01MB994129.prod.exchangelabs.com (2603:10b6:408:366::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Fri, 31 Oct 2025 03:50:00 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 03:50:00 +0000
From: Carl Worth <carl@os.amperecomputing.com>
Date: Thu, 30 Oct 2025 20:49:32 -0700
Subject: [PATCH 2/2] arm64: mte: Defer disabling of TCO until
 user_access_begin/end
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mte-tighten-tco-v1-2-88c92e7529d9@os.amperecomputing.com>
References: <20251030-mte-tighten-tco-v1-0-88c92e7529d9@os.amperecomputing.com>
In-Reply-To: <20251030-mte-tighten-tco-v1-0-88c92e7529d9@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Taehyun Noh <taehyun@utexas.edu>, Carl Worth <carl@os.amperecomputing.com>
X-Mailer: b4 0.12.0
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|LV9PR01MB994129:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fa2e77-caa8-4dad-e3b0-08de18309113
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVRnaUpsTi9pcDNWQzQ1Y2dSZW0rVTFTeGtmUW0wMWpObW91OTU5S0FBWGhS?=
 =?utf-8?B?NkpGbXZTckhlRjBja0E4NGN1cW02OGpQcWJUZHpMN3V2Qmowa2dNQmIvUVhm?=
 =?utf-8?B?S3prL1E2U1YwTUJjemVvN3h1U1RqaVBGOGZSdmxZNnRVKzFNczcvTkFhb1Rw?=
 =?utf-8?B?azZBVFczWUtTVGxlblo3V2tsU0JwN1FRTGtVM0VVZ3dtMFk0bmhKNno2am9T?=
 =?utf-8?B?cFZwSTlEdVRvaG15NWJDbHN6U3ZyUXlRNlpkYmp4S1hJL0hCQXA5MDRBcEZl?=
 =?utf-8?B?eHhDWDdOdCtOOWhPd2plelNySXR4UGVsNlh0S1YxZ2dubkNxR2M5Z2pXN0tX?=
 =?utf-8?B?Z1JMMmE4OFc4eVh2OHplNFFzTzJpaHhxd09YK3lQTGszT2I5SzV0SEppMWRs?=
 =?utf-8?B?QTBkeDJSaEpESTZyWDA3d2NSNkR5ajNwdUxGeVFGMVY1L1hlU0gxMG54Nkxx?=
 =?utf-8?B?aFhnbkFHTUQrZEZIOG1leEdsQXFUUTZBQldhRHJtZk1rcS9lSjJ0ek1qMHpl?=
 =?utf-8?B?N1VsUGNaVFkvOEhUbFp6ODlrbVdpYkZiTlo0dUFpWXNvSmpySDJrQm51a0h2?=
 =?utf-8?B?b004NE5ZQWFBSnFuSk45MXRrTXc3bVFMNGJmWE03dmZDdXZWbXNKWGdoTWpt?=
 =?utf-8?B?dHZOdlJHNUNOWmNITG1qVUNpU29nUVZNNURGd0RYOEtkbFJ5WFlMM2dYQk5O?=
 =?utf-8?B?U2Z0QjRnUkQ1eWxSTUgrTW1URVY0ellKYWtpcGVKQnk5aHZ5NzZiZVgyM3VQ?=
 =?utf-8?B?SXpmcEp0bmZiQVhRZE1GbG9TOWVtQWpSUFdvS2hEVlJ5SGJLaExHODI3RXVY?=
 =?utf-8?B?NHRkbFFBNlNwTGx5VW4wcmlaNWJpM0JCeDJpRDVDZG9hVjhjYklWUDFiRWN2?=
 =?utf-8?B?bGR2bTQrVVAyNkpXeG5UMTJGZ1RJWk5JL1Btakhib0hUdjk5UjNlelowV1Q3?=
 =?utf-8?B?UGRzQkYwb3B3SktKQ0E1T1VwOXY2K2pqMlo5ZGJmTFFtZnQvR3MwVG5QNnpO?=
 =?utf-8?B?MlYzdkVUeDVQbFdjTTJLUVBlbW4rL1IySG9LWGNwMDNiazZDMFIvcVRmRzdU?=
 =?utf-8?B?Z3VRUXR5czBVaWhCRll3MnpVMi9Hditsb3lxVGtsU1FkL1g3K1ZUejRNeVVp?=
 =?utf-8?B?M3lzaVlnYVM5QldRWldmNkd6bFJQamRHaVo0NTd3NkJHdXA0SithdWJTb256?=
 =?utf-8?B?eEJsZGtQN2xZWDh1Z2IyRlh0WGE4VkNLVXV4RG5QKzNJOWwxU0tKUU9PbU10?=
 =?utf-8?B?Q2F6dE85bjc0YkljdU5DWDRWb2VrWHJZYmIra1I5VSsvWGk4Z0ZkYkdXNDhX?=
 =?utf-8?B?QVBMdXZKYzhJOFAxTG95SzJ6QnRCREtjM3AyMEMrNFdDVmNDQlBZSXZiQjdG?=
 =?utf-8?B?Wk1CUXpuWGJJeXJqbUcxamdaNmhMTmN5NHVxMEliTUN4ckc4OWVvMWRIZnJw?=
 =?utf-8?B?aU9iOVRIUDdNRFlxYUNhVXNFM3dDSkdBS1dZNFFWUGNOejBSMWZSY00vOGRo?=
 =?utf-8?B?b1l4Zkp0OWw4d2RjR2s5NEhFaFlISGdzb2grN0pBNmhYemxFN2pZZWZ6dVJh?=
 =?utf-8?B?Q0xiY2szblpWd1RIdHdueTdsUGU4RFJkZXhUUHJpWmZZK2llamNnNHBMMTJF?=
 =?utf-8?B?c2lrZHRFcWN1WjZpZEVZek03eXZLVU9OOTVaaS9mb3NiVDJWTUF4ekJyMkFE?=
 =?utf-8?B?TGl2ZW9CTHVaWlFvc2RvdnNURlIrWXNvMW5hbTcvZlQyTndkRmNyN1BCYjZN?=
 =?utf-8?B?SlA3Yk5lbVlPSkpJb0lLN0NxaklNVy9zVW0zemF1UUI1T3VScFc1NHA3Rjd1?=
 =?utf-8?B?V0YzNGdRMk4vak1WWVBCMkRuckVYSHRGUUNwYitpMDE5THNMWjZWV3ZVMzRR?=
 =?utf-8?B?Mno1QkhOVEg2SG13eVByaHNNbkc3MEtGWm80NWhYakloc1lESFhFSVlrVExT?=
 =?utf-8?B?SjVFa05Lend6R0pYZ0NrZGlmSGQvems5amJtVUNuRkhRcDdMS0RGZXU3WTU0?=
 =?utf-8?B?OVlUcFBmdW5GRFhJWW1IRTF6b0lxLzZ6TWVBSm42Q3BmSmxmcHVmU25hT2pM?=
 =?utf-8?Q?VP/eL0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhYYzZzL0ZKQnZCYUI0dEc5SFNXcVdzdHlvN2I5SmtkZTM5dVZXMzNjYWlO?=
 =?utf-8?B?VHZVaStiVGR6N2dNalRxaHp0Q25SOGEzMTJIdk1acFJCdnh2SCtNeEg2NVY1?=
 =?utf-8?B?NGVmWlBJRDJXdDFTZlRPNUZUbXFzV2U5TzdNaXd5ZXhkaUtiMTBSejBqMitp?=
 =?utf-8?B?MnBsV1pHamVXSmRtM3hqb2JTRDVFQ25PZE5aSHBaNElweXE5TmNaM0hBOE9H?=
 =?utf-8?B?QUQrRzZFWHFEQ3RLN1R3bTFFUjF0S2lIUWQ5bG5FbmtSV3BkS0ZlL214QjN5?=
 =?utf-8?B?RFJrM1hZRTBTVkRwUEN4Ri8rTVpjd3I2clZWdlM0TVhhbnJYN0NnQzZmSnYx?=
 =?utf-8?B?TTFYcWpTRnp0b3BtdkhvUENUakNkN3FnTFhxS0VKaWhLWkRrbVBNTnMySnBh?=
 =?utf-8?B?SmdxOTdiMnB6ZTJHeG5BVHd5bkk1d0U2RDh4QzNidUZDK3VkQmo5VFNWM1Yy?=
 =?utf-8?B?OUs2elRvbHJabWxJM2xYMGg5ZkFjNXE4Z2Qwa25GNEorY2l1Q29OMjdJcHR1?=
 =?utf-8?B?WW1nTk1lenZERU1JZUJuSlVaK1dZVXdtcnhHdGxkM25JM0xqSkpVNGtoaWpS?=
 =?utf-8?B?R3NaSmY0OWRaSkRiUnlueG0zbytnMm5PM1U0dHJhUS84Wm1pT0NhTUNmY0pU?=
 =?utf-8?B?dE9MN1BmbEZWQTl2ajN6bE5NYkRDWTFpUUNZY3dwdnYrQ1FJQTBLcVhIR0Nn?=
 =?utf-8?B?VmM0SEFjUTA1bTgzNDhRcjZPZ204RzMzcGZwVTFUdS9yYnd2RTdXZm93WDd5?=
 =?utf-8?B?NXgxUmljVXlsSkhXQnUxY1BHTDVIUlZKdTFkYkIrdzNoQmkydlBTRVg5alJs?=
 =?utf-8?B?UjF2blprcTlXNkRvQjlKRHM3aG9ETXk4YlhXVnZwRDRORkd4YVRhMmlRK1Y4?=
 =?utf-8?B?R1d0NENKeW54NzFuYWZsWlVac24wRnpjLzFySEpJa1dCb1FsakFUMmpLU2lj?=
 =?utf-8?B?RXJtNlVwMDJXcTY2THhQVG5qYktDMit1L0hsQ2oyeUtRRVYxOThZNXhNWTdu?=
 =?utf-8?B?ZityUld3Wm9kVHZqbktsUHpCaDJyVVI2dlB4N2ZCTTRRcWZMdzdwcjFvbVov?=
 =?utf-8?B?Z2JXSndBWk9jWFk2TVRkRHJ3QUQ0TElwRVdLQzh2eE8xd1FKNzh6Wm52R2hW?=
 =?utf-8?B?QWhsYzBWcytqOWtGZXIvaWRiZmZZcTcvL3ZQWXFCQjhzZjNpRlpwU0NIbi9p?=
 =?utf-8?B?TXFDcC9meUc4eVBZdWhCaFF6OFZya3gxVDJrMU4rY011anZkNWRIbFFEbkIw?=
 =?utf-8?B?K0l3WHJjc3Z0c253d0hybnhodFlFS3U5VVpUS1lTYWZpamR2dEcySnRud3Y4?=
 =?utf-8?B?N0RCNDFuRE9vTU1aOUJCUXpCSHBYd25UT2RvQS8vNmxOaS9pZ0ViTUNKWWZm?=
 =?utf-8?B?cW5iTHRwQ0JRalNHUStUNW51bk1JdkwzNTJicDVhU2gvV3N0c3NBRGhpbUIz?=
 =?utf-8?B?ajVrZGtzUUxGaE9zSmwrQWlRNFVUK2tuSjJBdDgwRlRhZEJ4WDdvK3lpMm00?=
 =?utf-8?B?K3VwblRYMnJadVlVME0zWXlVS0d1TFExemVMckdtSldrZnpsOE5HWVBhVFBS?=
 =?utf-8?B?RnlsU3drUDV0M1duUnovOXI4OWE1KzVCL2RDdGIrdDE2TnJmUWphYjRQTkR3?=
 =?utf-8?B?ZG1vT2J3cFRrWTdydEtiaWFiS01LS3U4anBqUncrYW9RZE5OOXU5MnpkNTU2?=
 =?utf-8?B?RXgyaFNrR0NyQUV0UG4yaVBMQXdHVzVUcjlXT3ZVT0cyeG9KTThpZG8ybnpZ?=
 =?utf-8?B?RXVnbnRMaURad3hZTnY5RnZldVF6NDlqeWNWWXFabGI4VDBVdkt6dFNqQWFy?=
 =?utf-8?B?KzUyZHFYUGJRU3dzOUpCMzIwZUVUZlRZWUlyN2tDK0R5YWF0YXVlNXAzWkRh?=
 =?utf-8?B?bzl6LzJYSkhyeURtRGxKdS91VUpXS1dSTlppekoyN3hDWGZkcnkzYitlZmdZ?=
 =?utf-8?B?QVFTekJlamdhbkFtUFA1eHdwd21CNkFqNTM1WWdhSk9HUFoyM2JJdFFvRC9X?=
 =?utf-8?B?c1k5d1QxYkFPQkM0VC8yRE54eVZkNTZ6emJYQ1paakV3R240Y0NJT3RhNEgy?=
 =?utf-8?B?TlRsRkcwangxejlQdjJCNUtpZnJhL0V3SXNiUXFDWS9qL2RtSWpNaTBRRDNQ?=
 =?utf-8?B?RjFDZzB1RXk0SHdjV1JpeXNlOUo0dzBlbnFHcXNMRzFBWkc5VWk5RW01a3h4?=
 =?utf-8?Q?A4WGhjz7odbOoiGZxd09BXE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fa2e77-caa8-4dad-e3b0-08de18309113
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:50:00.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdY096EXFINcsrNdpQ/BQC6mDP/7di66ppiw2pyExXiFCs20fbzk5jhnW38DA5yOl1dcayzCRzoV1y4M8yVn8fNceyBcTyOWxLdBHHwgVUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR01MB994129

The PSTATE.TCO (Tag Checking Override) register, when set causes MTE
tag checking to be disabled. The TCO bit is automatically set by the
hardware when an exception is taken.

Prior to this commit, mte_disable_tco_entry would clear TCO (enable
tag checking) for either of two cases: 1. When the kernel wants tag
checking (KASAN) or 2. when userspace wants tag checking (via
SCTLR.TCF0).

In the case of userspace desired tag checking, (that is, when KASAN is
off), clearing TCO on entry to the kernel has negative performance
implications. This results in excess kernel space tag checking that
has not been requested.

For this case, move the clearing of TCO to user_space_access_begin,
and set it again in user_access_end. This restricts the tag checking
to only the duration of the userspace accesses as desired.

This patch has been measured to eliminate over 97% of kernel-side tag
checking during "perf bench futex hash"

Reported-by: Taehyun Noh <taehyun@utexas.edu>
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
---
 arch/arm64/include/asm/mte.h     | 21 +++++++++++++--------
 arch/arm64/include/asm/uaccess.h | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 70dabc884616..3608ba452da5 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -258,15 +258,20 @@ static inline void set_kernel_mte_policy(struct task_struct *task)
 		return;
 
 	/*
-	 * Re-enable tag checking (TCO set on exception entry). This is only
-	 * necessary if MTE is enabled in either the kernel or the userspace
-	 * task. With MTE disabled in the kernel and disabled or asynchronous
-	 * in userspace, tag check faults (including in uaccesses) are not
-	 * reported, therefore there is no need to re-enable checking.
-	 * This is beneficial on microarchitectures where re-enabling TCO is
-	 * expensive.
+	 * TCO is set on exception entry, (which overrides either of TCF
+	 * or TCF0 and disables tag checking).
+	 *
+	 * If KASAN is enabled and using MTE/(aka "hw_tags") we clear
+	 * TCO so that the kernel gets the tag-checking it needs for
+	 * KASAN_HW_TAGS.
+	 *
+	 * When the kernel needs to enable tag-checking temporarily,
+	 * (such as before accessing userspace memory in the case that
+	 * userspace has requested tag checking), the kernel can
+	 * temporarily change the state of TCO. See
+	 * user_access_begin().
 	 */
-	if (kasan_hw_tags_enabled() || user_uses_tagcheck())
+	if (kasan_hw_tags_enabled())
 		asm volatile(SET_PSTATE_TCO(0));
 }
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 1aa4ecb73429..248741a66c91 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -417,11 +417,41 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
+
+	/*
+	 * Enable tag checking for the user access if MTE is enabled
+	 * in the userspace task.
+	 *
+	 * Note: We don't need to do anything if KASAN is enabled,
+	 * since that means the tag checking override (TCO) will
+	 * already be disabled. In turn, the TCF0 bits will control
+	 * whether user-space tag checking happens .
+	 */
+	if (!kasan_hw_tags_enabled() && user_uses_tagcheck())
+		asm volatile(SET_PSTATE_TCO(0));
+
 	uaccess_ttbr0_enable();
 	return 1;
 }
+
+static __always_inline void user_access_end(void)
+{
+	/*
+	 * Restore TCO to disable tag checking now that user access is done.
+	 *
+	 * This logic uses the identical condition as in user_access_begin
+	 * to avoid writing PSTATE.TCO with a value identical to what it
+	 * already has (which would needlessly introduce a pipeline flush
+	 * and could impact performance).
+	 */
+	if (!kasan_hw_tags_enabled() && user_uses_tagcheck())
+		asm volatile(SET_PSTATE_TCO(1));
+
+	uaccess_ttbr0_disable();
+}
+
 #define user_access_begin(a,b)	user_access_begin(a,b)
-#define user_access_end()	uaccess_ttbr0_disable()
+#define user_access_end()	user_access_end()
 #define unsafe_put_user(x, ptr, label) \
 	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), label, U)
 #define unsafe_get_user(x, ptr, label) \

-- 
2.39.5


