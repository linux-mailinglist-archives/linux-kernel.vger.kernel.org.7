Return-Path: <linux-kernel+bounces-843145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0799BBE7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84AF74EF4E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536EC2D77FA;
	Mon,  6 Oct 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNUVnArq"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152252D59EF;
	Mon,  6 Oct 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764388; cv=fail; b=jYn49+o5A3RBbHGIpZw25M1WD0St3PiclSevxEJzXLpyC94HW1Fc/sePzr9kZQtdmVLVAqEktxTEVQA715hjcyAuFPGuaVzrN6PFIQ65DMnvUnP8exkVVhMTFpuN4jhYS3WBFiXdv5H4l3mP00caTvBbqAP5X3u/VEmyXe75Tvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764388; c=relaxed/simple;
	bh=FvtG4AsffTZPFD+0p1B4HawJgm6lC0L4GO1vw7jpxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5eL3qt6RkSAR6sNqSUBxUbcJvf2beD6M6opYH7UjUhToCbilSmgRCxWNZMoxQRcImTqFCmWKw9wtQxFqFmVTMo+/e1sE4WkcjSQNUYfjmIY1cxiu0ZLw7xg/st27umzHSbeca5G4iDAcVjgqpMGYx8FNUOHV9/91lg29Uev2pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNUVnArq; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5o8SM1Lwph/Mf2CuzQg4kZ340/GVuRuU8alCnMPI7ysfhpxpMljjgF9NnL35rp/6A4KaTpNDso2O1+uThjN13j6Q7QnH+jSGRzgdfI28CbsuCNe+r2iMH/C/cgAdzfFECupCMRF/GWNloAUuPz/UWFVeGfos7BRMzp0tfEjcz1/Jty0g7HjTVfYfxubTXtqeevwajrT8DnxIFfivQbOrcurb4bTTS5O3HZf3a7HVitZnavzc7Ork84B2dwHEHoUswQpbuTXg6fwIRAhdOfhay3DZtuPNvD2DPVpNdSsbrL/+wJ8QpI991scHga1ifhIhoeJ+wPELN3FWXSiHJmMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLZFaoEc4LF7YLYNEOb3wa1t0fVORzuZvsfnowTaB84=;
 b=Qn2n7Quv+BZ5SGP6KZ1w9rQrHdwjT/wIlouFcB+1EoSiZoRyS6qqdlMNiFsPJo8UZaNzHxFtwUDu1sfn2ZtcFKhdHpWbhqjUdC4n9+yGT75lJ1d+dxHmzdfFitShkL02Tg6Np7tNUQ25q0MEaAEuL1SjCs66tRvnHVHnKh3SUyHaqTteDOh5Yh8yVovmNJ7ao83j6e8zRY2FGt6H1WOWykHjKXVC2QaUTwjunrCt+5zTIm/FBl7qmOcR36IDE1Uah+QNKiRkwzES7+8+epKbluK/Q0aGjInLBeMNVI3c9YbwmXNX/lCBCbGkbBA6DqHzMtkoOp5/eFlFpxpgIyCTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZFaoEc4LF7YLYNEOb3wa1t0fVORzuZvsfnowTaB84=;
 b=CNUVnArqhhnGKerU/NiPBt+078yjuYYIsYoWO0jc16PbdoCCXPaOTTAxmT8I1bBp4GoJCb8mVNTnyYxm+x917e1tN8JqvH38n2ZXUH2UgVgn+4wwufd6+EQNy6vvRxqlDI/c0Wdvezog32QPGN7Zub12anY4SlGnk7TYru+zQAbK5TdZUAZGVBKFG9K4IzkPDfcNcxgZ6PCyhaIVHQfG0gXvDwG0gfr7LBKvVAVETnUQJgCqyptgFfj2m//zwrbgI2bFfeKVMgCdFtvCSJ+GC+9mtdTPLo+MIg8DHbYLBZcWKRSh6EmlgWAp43aU3LQFoXhBe2Et2R6ei2pjI+feoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 6 Oct 2025 15:26:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9182.015; Mon, 6 Oct 2025
 15:26:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-csky@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: abiv2: Adapt to new folio flags field
Date: Mon, 06 Oct 2025 11:26:21 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <8CDB6C1C-5EFD-4B04-B232-4A90CD65849A@nvidia.com>
In-Reply-To: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
References: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b9f4c6-8df7-42ca-9aa7-08de04ecb59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aSs0K0pQb1lyMnh4V0lKaWxmbzBUV1lRUEZFZFRzRTlLSmFoR2I1Zy93blJp?=
 =?utf-8?B?RmdmWDlTYTFVa2JEa3FpdC9FMlNlczdjWGxycWdiMmZ5U0dadHlKTzJZeWtr?=
 =?utf-8?B?OHRYWkNBQWhEbjk2QkdCM21jSU9YQzI4bEd1ZGxnYkFpbWF1clFKNk14ZG05?=
 =?utf-8?B?VUs1aGJqRmY1UG9yUEpHQlN2KzBpeDBXQVZTTklLNXJpOFlKbHFqTXl4Qloy?=
 =?utf-8?B?VVIxTkd5RjNLRGt0dWNnZGQ2Y1NwK3duem9mMFdwcEprRmlyRktmS1lKeHJG?=
 =?utf-8?B?T2NPSmpzSnIwVitVOHMvWU5LNDlUNFViNERhWWZZRFYrV0U4SVpFUjZ4K1dJ?=
 =?utf-8?B?dlZFbGluMzJZMzBLR1JWTVcxRFM5ZXR6dVpvUnlHN001NS8wSlVsRUdBY0tj?=
 =?utf-8?B?K2l1enU3WWhjTEU4dmpVQlNwRENBeU5GTnJtUVo0UTNPcHlKUHRZZ2JoQjFO?=
 =?utf-8?B?OGU2QUx1d1padHdIQks0OG54b2dybHhoUUxBUTJJTmxtbWpQVnpoZVlDNkZz?=
 =?utf-8?B?WDNLVk1pUGViRXFJKzJabnNZc2Uzbmpja3FBbFpnNmd1WU9DRjQrcXBiRGc2?=
 =?utf-8?B?WlV0Y1hIYnpmeDNnNjB2NEU4OWU4dUN0cDI1Ym1aTnZFQ29hWVJpZGhCNU1p?=
 =?utf-8?B?TUlMcnArTk9NTWNTdTFUU2MyWjZQMStscTYzMkhSMU9QU1JLZElZOUZCb2E4?=
 =?utf-8?B?Z1pzR01EL3M3TTkzc092a2diVDdDcUlpV2RHa1pIRTB3UlkzNGgyYk5YTGd5?=
 =?utf-8?B?UGhMV3dXM3B4bzlsQno0YU1TK2pkY2JHQVFDRHNwc1UvbEh1UXpqTjNENEZH?=
 =?utf-8?B?d2xic2xmdHVwSkRVZXd6Q210WVFKVU8rVlVyRysycG9ldmFlSHpKN3pCcXFN?=
 =?utf-8?B?VU9POFBKbE1kT1BMclhtNzNiL1RkTVBaRElIYnpwQUJZZTdDb0pzMVI4R2gr?=
 =?utf-8?B?SHBJemtJbGdwd2Flc0gvY0xMV0Z2ZHl4M1JTbkhiLzArbWYxUUFSRFJMS1VK?=
 =?utf-8?B?aGtOMHphU0ZodEVCYjhxTFFxK09XMW5OeS8xRWVpaTdOZmFBUHQxc2ZrQjZp?=
 =?utf-8?B?ZVYvNFhWTm9TQ0ljUElPUWFQVC9wSGt5ellIVUttNTQ4ZkJ5ZUdXWHJncXho?=
 =?utf-8?B?UU9EOE9lT0phL3hCL2R0Y3FORTN0TGFuRUhnKzh1SEdjaC9qR21NVHljN3Jj?=
 =?utf-8?B?UmZRN1FhTjM3akdoZ212L2RmMHhYeDBreVFMVlN5RTE4aGdqQjIwbGkvenhI?=
 =?utf-8?B?dU44VHltZjB5WG9mdXdjV01WWjhwWWU3MXVBbi9ZYU8xalZ1SXN5dWpYWlNp?=
 =?utf-8?B?UkIxTThrMDBmR0hLWnRqVXl5V2g1Mi9ORVZVYk5BS3lITjZmY0kzWU9xeXV5?=
 =?utf-8?B?ZTdGV25kVjN3Z1dMYy9idkZYckZzb0lYVitNVlhhSzk5VkxlRHZCU1htMHg0?=
 =?utf-8?B?b2dnZGVwUm4zdDZZMXRhVVpFMkNrU0FOVjNXaFphS09yOXo1enVoZVRaUzJ1?=
 =?utf-8?B?THFhMjMvSUNtS04ralBpWGtMcnA0ZUt2ZUkwSzVNaHNvWnVXeXUwNzFkV3B4?=
 =?utf-8?B?ZWhJM2IwTng4aE1YaEU4THRCdGJ5KzNabFUxUUw0QUdDZG9wUnpJWjQ2NlIz?=
 =?utf-8?B?MS8yUWp2bFg3cWc3YWtxUmthc3piN09RbTlZNXhKalExbDRSdXM0TWQvenRm?=
 =?utf-8?B?TkpkbUVuM3pmRTJUME80QnM5Z1V3M2x4VHNObm9XaDVvVkJGSThndWpkbXJM?=
 =?utf-8?B?Ym9sOTdKVXN0VG1qbjZyZWJ2WEcrK2hrVzN1Y1BweG9mMG9WRHR6OHFrRnJR?=
 =?utf-8?B?T2g4eTgrTEdCZWV1RitSRmZ4SWRmaWhXU2x3endPbzFZQ2M1SlhtQXIxNkRY?=
 =?utf-8?B?UnBIVXNpVDgyMmU2ai8vKytLUWxUbW5DN0l2M0p2ZEpkV084SHRySWNnZDJy?=
 =?utf-8?Q?aDX82j3sJaZ/xT5xkRnGESkpNJ2DwZ8d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9LVnA4UTNyZW5zeTF6SzQwQ2MzbmF0aUVXVlZ5bXF5ZU1DMy9va0NVSSt3?=
 =?utf-8?B?Vk5MRi9JL1JvcUtvVnBSUHNMSEpuSFg5UXl4ZHdDeFpiaXdOSjFrY3p4eEJJ?=
 =?utf-8?B?WlVGQU5yOVlsOTRlQlA5SVZHREY4eFNuZjlxSGhnYzUrRXBmVzU3eERQdytq?=
 =?utf-8?B?Uk9WWUdHMXptaEx0N0d5cG8xdXhjdFNRdG9tVmZndU5UKzMvanN1MGNLbHVq?=
 =?utf-8?B?QVhLWkMwWDJ5Y0tiZjk1OHNtVTVpRFhKZ0hwditBMUowUkg3OStjcnVsSStz?=
 =?utf-8?B?UE1tNjRybmRQOXFRWXdMdzlYajViSXdoZCt5Zm9uNXF6Sm90cTdvaU5CeDFu?=
 =?utf-8?B?QUhCZ08zWXBrZGk0eExCeEgyS2pGTXhqSXE1a1I2ZjNkZGxQSnBQeTBqNlhR?=
 =?utf-8?B?a0hmdCtaeEludkFOT3VMWXFqZ01mVENyYWFWNDZpbUZkOXczK003Q2RoYS91?=
 =?utf-8?B?Z05sTUR0MDVBUGFQbTFOQWdKall2TG83K051aDZob0RNTVdUVWxwZjdTTWMw?=
 =?utf-8?B?U3VHNFgzdGtqaHJYeWdnVnVsbytnR1ZMV0VzSmM3NURCemR3SytjcU4xemZl?=
 =?utf-8?B?VEJXd0FtTk9CSHYvRllLNzV0clA0aWFVWnlmQVJuUG5Mb2FiVWpxei9FR1My?=
 =?utf-8?B?aTFSZXR4Mmt6SzZoRkNnK3paSUR2OHFQbUdmRjNPby8zdjY3NzBJaklWSlJL?=
 =?utf-8?B?cmxELzduS0lBY3J0NlBOcEt4K0t5bTY3dlZjUlBtYTlJREZiNTRVQU9McGFz?=
 =?utf-8?B?alFEa2hocmQ5RDJFOEljVWNkazdiTWJqTldWTXg5azlyM3puQTJJWFp1UmZF?=
 =?utf-8?B?Ny9MS01yelZkSm9SOWJ4d1UvbUYrTGc2L3JvTEVnN1FjMkpzcWJoUlN3NmVS?=
 =?utf-8?B?NjFMY3FVV0NtL1ZPSUsyS0NZcWJudG41bU16WWRSM0Q3R0xwTERQMDFncmNW?=
 =?utf-8?B?d0ZhM29Wdm1DUmpsNHM5OGZIbGNnY21aUEFQVlNYcGVFWVBWUkpRNFFyMjlk?=
 =?utf-8?B?R3hxVnVjRE9WdCszZHR2MnZWcmF3cGxxUW40Z2hFcWNxallyQVFRNTBkYkhj?=
 =?utf-8?B?UE1GalQrd0lRb1Q1U0IzdzBRcFFCWXJsSjAxWG5xNUF1NGhTd2haNm4wek1q?=
 =?utf-8?B?d210WXFMM0NBbmg3bys2eUlGM0JTeFFWbFdjTGFFZzJMQ1pVYjQyMmVVZkts?=
 =?utf-8?B?bUJtbXV5ckozbkhzT2lLbHdycW56OXBaQStqNXNDamVQNDJaYkIzdFVMcXZj?=
 =?utf-8?B?ODNpSmk3bUNrVXB6YTltaThIaWxBR3lYak5Halpxb0sxVFhZcS90VEl1cHpp?=
 =?utf-8?B?dnFFME5EcDAyZzZ2T2lEcWJ6VkZFU2wxTlB6VDBVOUowSEdGdENQdlQxdWxG?=
 =?utf-8?B?TmJUNXNPSm1DY0pPQnFBYWZqa1BFR0ROSThlZGhBbXkwbUpiL29SeG45M2tk?=
 =?utf-8?B?Wll1VzR0cjZWcXRqeDF2cTJmOHdEZUtHUitTY1Frc01BekhMSGk0cHk0aExZ?=
 =?utf-8?B?d1QwY2VFOFFuY3ZERUkySDR1dzdHQS83d2dxdTN5WjQyalNjRW1EZ0E3Mzlx?=
 =?utf-8?B?cWlaK1pCTWw5WkkvZ01PNkZmL0p4cURDdVFnN0REQ0wyNE9YaGhhSlVpNUtF?=
 =?utf-8?B?SXlyMGh6Sk82aTV5ZjNPV2ZQenNwcFZUbzd2UDAvWTdTZjQ5Tm1EODdMaGto?=
 =?utf-8?B?ejczbHFrWnRlTWlkRnlFNUNmampocUlTWnpHc0hsR1VBQ2ZkM3M0U1hZclV5?=
 =?utf-8?B?UEJYZlhneGdROC9XQlYwYm1SQlowNXpGVWJyVkRYTGRid2NSZ0dTRXN6WmZR?=
 =?utf-8?B?Rll6ZVkwU1lKWDVWUllvSFJ5ZVJxb2hoSy9ESllFL2h5UisveVc0c0FFREor?=
 =?utf-8?B?TkRJbXVrcXlibkRJSVA4cWxwZTN6NEQrZDNrWWRwVmpVNGxIMjJmSzIwNTBh?=
 =?utf-8?B?Rnkvd1UvUEdJajB0V0x3c0h5NHI1WVg5TjZaT0hBRGhWTU9RZlZ6anRXZFYz?=
 =?utf-8?B?NkFNSVJYRy83Unl6UzlhTEliR1o5WUZRSzVUanFoS2kzV21BZW1nVXNZY0ZK?=
 =?utf-8?B?ZzBSTGFTNVNneWdlZnIybDN2K050Rkp1N3N4a0VkNUpEMG9lVUI4R0NZQVJu?=
 =?utf-8?Q?tpEETBD1Txrgwe5HFjCwbXACk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9f4c6-8df7-42ca-9aa7-08de04ecb59f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:26:24.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9goebwERFA7a4ucX7T0U0jeYO/M9RnpjrPVzdKL9RJoQo0cho+7MQLTrtCyr9eO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

On 6 Oct 2025, at 8:13, Thomas Weißschuh wrote:

> Recent changes require the raw folio flags to be accessed via ".f".
> The merge commit introducing this change adapted most architecture code
> but forgot the csky abiv2.
>
> Fixes: 53fbef56e07d ("mm: introduce memdesc_flags_t")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/csky/abiv2/inc/abi/cacheflush.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

