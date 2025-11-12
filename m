Return-Path: <linux-kernel+bounces-898263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C3C54B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121384E1AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A682C11C7;
	Wed, 12 Nov 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bhyHDUKH"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022074.outbound.protection.outlook.com [40.93.195.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422135CBB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986257; cv=fail; b=MTI62n3BpoDpW3Ku0QCpwoyvP5DdXGeMSB0A12dTx3WSnsTHEdgeiUeAmbf69GsVGl9LdpsnFyZcq1Emm6xkeNfy48IwQdE7crLEpi8E7cU79xEfbxszUsymnI0ifjRvo7tXz2VQTQAIIlWvRe0Wu6xZ3Jlg6glc7uAoSRO+EF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986257; c=relaxed/simple;
	bh=6HybE5pXmHlXS00A2YA8vDhNuKBwAevUEvylrdfVHzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MoyBryQfGIwaPlhcIMpB5x3H5YwmwT/xEpQcer65ZzbMxeBuvX9JW2fKcyjon22hMZpv9vqvVVbrNKGDDsRZPgXO4cj71kWHvl/Fw0dka63OtqSke0hLAr29Pl7hZBi/IMrbkpRObE5hDZ9SCz5jPK1iuJGEP6L4GEKvEEPPyWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bhyHDUKH; arc=fail smtp.client-ip=40.93.195.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE/t6Xc354qyteqYrsVug45Mmz812BZZ5tbARJa5hbj929Y+3+gJojLaCkxvHG99abIvL+Xxad3wEo3ofuf6qe7UfzRYZqLTBCfDFp1ut2fNRI9cIltk5vh/na7osDj6fulzybcasf4eJq8jp22n7xkqUr3WrR3Cky0bZn8PqJC4pUhgssVrPE3tMkErwURd+bC/AH+zPyCrmEizhz2DcHNazrtjSRDAZgtjiQ7JR2i2PLu0wz6YpOuQglTflNBsrJ/TH63n+JzOzpOzYjNB4RzNwpmt8BLfegXxvUb0YmsjNKIerlbJQ3tlxM97VZkA45qaqe3XE8hSr7Y+mLjpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtXhrVlKhGG84ADJZUvXw3TdA12moI/zPmhNqN9ewfQ=;
 b=dM4blAAK1SJ/zsbHfaebsGre2tZjRbDDzRR2C0UqTk21RBXup1nl/QABQ2g0RmooprIeoQMmyqf/0SihWo9TDzmsueqjoKNGc1//hpyo3iTqgjPoWv3Ef5MW0RibSChMlMY5yXImV6EgrfVBdSH5xN4rTu/NtfIdZFNOH+VV886y65aooTA5KklZuvuKcreXxS5UyYjJ/9jWxWMhg8N7TJBvI0G6Pwjp+7/XMZvPjHkOfY8Y74S43AvqvLYA33oLforPxFD3SvoaYN2IL2NL/soPia7QGKCiS47kmBetwYwA7Aqq1KBRBHrNnOPSZQcyfhJuyWaoKntC9sv7KuvKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtXhrVlKhGG84ADJZUvXw3TdA12moI/zPmhNqN9ewfQ=;
 b=bhyHDUKHK9VrHhUgCJruvZbe6HrKhkXMQJy6aw8cmz6M/GYpcvMWZBzpHBfje24BdPmYNcaiPCOT81reNbFmFPCwC23BNfU8GaQx5oGbz8WAUX+wcaito0SO9G/NCSjcDIjPeVcbPim1o9oUtf4o8Rlw9vbri7ml1WLJF4is3vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS7PR01MB7662.prod.exchangelabs.com (2603:10b6:8:79::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Wed, 12 Nov 2025 22:24:12 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 22:24:12 +0000
Message-ID: <0bb112c7-1ed0-4ee1-a1df-6a7d4b224fb6@os.amperecomputing.com>
Date: Wed, 12 Nov 2025 14:24:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
To: Ryan Roberts <ryan.roberts@arm.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251023215210.501168-1-yang@os.amperecomputing.com>
 <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS7PR01MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 59894679-d511-4ead-3f77-08de223a349c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZkMEtNWTZHWTZTUjBLTzlmNTE0cTJkSVVPVldQRzdGT3phZXJ3emxtaWxm?=
 =?utf-8?B?WXlJYXJtT0k2ejFxZi9Eb3g3bUR4L3hvUlZaaW52NGpFTXcvanpuMTJtTUdv?=
 =?utf-8?B?b2crQjNWZzR5UHhZb3Y2NTlYdVpSWjdDdEN5dFNuWFdRSCtxeFVUdE53aFZo?=
 =?utf-8?B?UGNNZitRSXNzK1JMcHN5OWhPQ21jbVpuODZYMWdVSUhRQ09NQTRkbG9KbDBs?=
 =?utf-8?B?Wk9kZEpVTHF1MEM0VEJjb0ljTlNsMzZyR0NrQ1F5dTF0Rm0vRjV1dFc3SXox?=
 =?utf-8?B?ZkZ1clJNT0QwbXFzclJlOU51WmRRbUthSHd4NkNrN0paZlg3RXBXYlVHUVR2?=
 =?utf-8?B?NlN6OERwQUpkY1Q2QmFIVGY3M082Q3ZXdENPVWRPNWZRTVVJM0Zrd01scTJ6?=
 =?utf-8?B?bUVSN2NENG94TTNuaE53T0NxQXhEM01GTFVwOGFEL3gxbmNuVHkzZGVPdWRF?=
 =?utf-8?B?N0NQM3NlbW4wT1krQmZrM0dRLzA1NUFqTjBwajBLcUg2VXNhVVFzZ3RYa0lC?=
 =?utf-8?B?Y0xheWZNaXRSZGYvL2xBTGtCV2c1Z1NzTEhHNzdTZXEreHVVMmNWeGxPUkZD?=
 =?utf-8?B?aExHMlErYnh4RHNMNzZGM2hyN3c1Y3p6VHJySWUrVkdXVUlncnYzbFdta0Vl?=
 =?utf-8?B?QjRsSVpNUkhaRGtSUjZlRVB3MUVuNi9ITE0xbDZWRUFoYjBvYXZFNSs3NWRv?=
 =?utf-8?B?aENBSG9pbWg3YzBEQnJZbit2T01TTnVtbGpGTUNFOG1KWmNiUzZQNlQ1aWJ4?=
 =?utf-8?B?V29XMk9IQkRESnpQdmw4eGN0QmhBY3pkWUJrYXdhOFdLOXJPNFZRS01DNWdG?=
 =?utf-8?B?TzgyNnM4bmxKYUhXMXJGb2ljZmQvWmk2eEhVTm9aZmlyNzBNczk3UlI3RFU4?=
 =?utf-8?B?T2V5NVphNXdHbnMzaW9RU1YrLzhlYzNWR3J0NDRyVk1mQktQVlp6SjNqTmww?=
 =?utf-8?B?Q0FZTEZHSnkxWnl4WGFoUHNoVGRKOU5PbVJCeVBnVnZRdEJRblJKbHdDSW9Y?=
 =?utf-8?B?aEJKeTJCRXVMVkEreWpJejNpS2xBaTg1N1dwQm1reDE5U1hLLzNHamNBcGEw?=
 =?utf-8?B?MGhwc0dSRExFRVA2WHVaSTV2TGNxVEVQUEVhNCtXRytjU3NPSitMaFZPTnhU?=
 =?utf-8?B?bmpFOHZaRVRyREZWYWt5MlFjNXdxVVcxaXA5M1l6bVBiM3lCMFZtL0Vva3Q3?=
 =?utf-8?B?QzBsTVdZUkgzT1pKNFFyaU9CVkhLQmlicTVpVi9iQmhIa0hGVGZqMWpUZlFh?=
 =?utf-8?B?em9Ha2pKckJybkg3akpTWkhWb2s2a0t6WXNGZndEejVrNTdFTUtIU0JORHl5?=
 =?utf-8?B?bFZ5dzN4dXZiRXZhQ2NNQlY5T3dOMkhkN3dGbzJ5Q0E4WXR0OWlabERLWGx0?=
 =?utf-8?B?M3pUd1pkaHpaNWt0cGpRQXNlRTNMTG81V2wvcVNNQ0FDTGQ3ZlI5ZnVPbFJs?=
 =?utf-8?B?MGRvWmZ2ejJWUUo4VmVXWVFzS3pacGRROFp4U1k3UnJ3WHVLaTZLa3dKbGNR?=
 =?utf-8?B?bDhxUkhoQklJeVF5K3NRNG9MUHdjcFFYV3FDSEljUXVaMDlwTjFiZGRjSDlH?=
 =?utf-8?B?amJZM0l3QmF3bVc3UFFQNFppZnA4MlRmMEMyZGdDczRjL0hqNGpwTmJET1hJ?=
 =?utf-8?B?QmtUZ21JTVNvQTVXZUNNTm9iSGlQellqZHFTdGFFdm1ac251b2ZQazFjeElp?=
 =?utf-8?B?MkplOWVtQTBkRjlmSUF4ZkRidVIrRVhrajJJbUtIc3NtMHBidW0zMlh5ZkxF?=
 =?utf-8?B?dS9zbEQwenlIVEN2UWRyYUdSUmRuY1JWQlFhMWtPaXJSY3JTYnNSYzB3dmtB?=
 =?utf-8?B?YStLanFqRTUycUllcWtqYTNPSjFia2FlaUpIM05lVWpCMzYvajhqcFF1RTFv?=
 =?utf-8?B?QitlUmxFRzd5NCtmOW1Yd28xNU1hci9vQTJYVzJZSHIzdFd1M0hWRE9SbWJJ?=
 =?utf-8?Q?GIaRTXNAnuJYyUu1ygQTYIaL1ccg3eHN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkRxUGZqeUNXRFlWZ1RlWHkxV3Q0SFF3RzRxc3VmenZCeExXdENSQ3lTQ0x2?=
 =?utf-8?B?MVlUc3EyREhXRGZrZWhwbkVXVzhYM0UrWGVHc1kzQUdNbnk1ek9xN084V0xu?=
 =?utf-8?B?UkJ0SnBaQ3VKNWFjNThCVno1ZEloV3ZuUWtyQXNDSHdyNlZQMTk3K09VdXZR?=
 =?utf-8?B?SE52czRHaUlpOG82ZTZQdEdhYjk4d1Zwcjc0dGZLdnIwcUt0OUsyN3BpdHQ4?=
 =?utf-8?B?Q0xsYVJuRUwxNU1HOExjSDlkWnEybkRpUjdmdmEyWXNrTFRWMkY3OHNmVUt4?=
 =?utf-8?B?emhPQlIwN3pBeWp3dlBNb3d0TlVyVmJBUXUrRUlHZVpDY0pybDBPZGRPQ1kv?=
 =?utf-8?B?dHZZTDJhSW9va3kzN05aUDJ1bGJEVTRBaG5wTDQ4dHBnbi9ZODJMbmlQWEtQ?=
 =?utf-8?B?SndwdlpDbXdXemJXL2ZNTmFIVGU3UTNjUUZ2dEhvWTd6Qi94dDdLSFRPZFVG?=
 =?utf-8?B?a2JtaEE2ZjdyVDdjcGl6YlcyZVRmSEVkWEF0OUZCaGc5NlNMbjk0OUthQTRu?=
 =?utf-8?B?NDJxa3l4Tm9PdmQ5anRSQXpNanhOck9ocVViNWZZcDdObWNtM1lKWWRVQ29u?=
 =?utf-8?B?WU9YR3pjYzNpeEhwR1pnRTNJRGFaRHpYVFNNK2xVdUJWZmxZNFQ1WHhzOTcv?=
 =?utf-8?B?MU9pVFMwYWhZb3RndXdJZFRleGdIcWdRbkErTXo4WjlHZ3FwVE1ZTzZWWndC?=
 =?utf-8?B?R1NmTjRXWFk2aVI3aXEwV3Q4UW1OT3U4bVRPMm1VUnZ6WlFWM1JkOXV0NjhE?=
 =?utf-8?B?bTIxL0g4dmg0ZHIrMWNTU0dlekEwd0Vtci9HSHJJOXJNU01EVm5BMjMyTDRl?=
 =?utf-8?B?VEdZdTR4R2NNeE9sS2dlLzFEVTlkOWpIUytTTFpFZVVhSHZJK3ZWeVZHZlZ5?=
 =?utf-8?B?UHorWVZKT2U5NWZMYmdQQm1Talk3S3FESWNFVjFkZVNjSHpBS2xxQWVUdjNK?=
 =?utf-8?B?Y001WXp1TllITkRJM3owa1R5aVdPamRWQ3lyM21peU1zNmVwdndpanQ4eDdm?=
 =?utf-8?B?dkwwM0s2cVNEdkdCajZLQmFtQnJrdU4zb210S1pIOEUwUm9GVFI3T0hkNkJ5?=
 =?utf-8?B?WitXdnY2QlhuTloybUJXYSs4b3NhN2JLcmloZlJhQkFYcE5DRXZIVmVDaWF0?=
 =?utf-8?B?bEZxT01oREFCLzVoTzNFV0dvSlhROUE4QUVOMm1yQWoycmFQMmxDMDh6Wlg5?=
 =?utf-8?B?UEhlQVhvQi9KNGFVUFFhZXBxcTRuNHU5NXp3bHBtRi9wOXVMcEV2K2l3cXF2?=
 =?utf-8?B?clFwNEg1VWpwbTJqQXc2ME1vdy9HcEdnRTc0Vk5heDVOeXNFTXQ2RmNtUlR6?=
 =?utf-8?B?L1JmU0VqSVFjQTlwWjVZajRhVnBIM3BjUlpZSThheU55RkFwUS9NRXpCOFpV?=
 =?utf-8?B?S0JnUUhWOGx6N3FOUXVOdXZPS1Q5eVhRMU81RWhGYVpiT21Ia1c5SEtJSThB?=
 =?utf-8?B?b3hJK0sxUnEyMzV4bXQybVhnY3RjN0NCUFM5SVM1VHI0QWtCNlJTK3ZDcUky?=
 =?utf-8?B?bDBXQ1VCbmJXWDRpbFI2eHRHVWc1Z2hLd1BrWENWYXRsUjBCT3ZKbEcxdEdq?=
 =?utf-8?B?Smh4dmFOeDVnc3BjQU1pTUppQVZUbmxNcEo3SU5sekx6bDY2eE4rSURYdWJ0?=
 =?utf-8?B?bWc2em9tRnFTS1ljYysxd2hwdW94MG5HRmM2OWpxc3l1c1E2Sk55UzFycnBa?=
 =?utf-8?B?bkt4ZWJtU09jT2Q3Tm92ZUxGYlNqa1dob2pwaHJZLzZYNGRuZ3M4MVVOdEZx?=
 =?utf-8?B?eDJ4N2c1UGR4MHpFcDBIR1VhR1lrV0gzMCs4cUhJTVBvc09GQUJMemZKZ2tH?=
 =?utf-8?B?WXdrQnZGOWdEdmZtdDNDckswWXJYOWpMRHhnWmV3NG16VUM0RlN1TmZVczZG?=
 =?utf-8?B?OFQ4YXU5TDJXU1ovcFNwd0l2Qmczd1AvNmk5QkI3eTFRbXR0bURoYXdUT0Fh?=
 =?utf-8?B?T1JnZTBFQVYwNjJneEtzUDArL1IwRThaSlJIaHBLOEpBYjQvay9FbTZtYjhN?=
 =?utf-8?B?NktISFVFb0QxcHJ0cHJ2ZnFWUXZVUytCWm82T0o1MzZjaWhVYSsvYkVZUEdB?=
 =?utf-8?B?UDBjS3FDMjljWHJhU1RmMm50YlJUS3ZJaEhxVXk5ME5oNHdBRGNOM0QrZ3R0?=
 =?utf-8?B?OVNmQ1pwWVpUei8vVkwwdldwUU81aXRLR0daY2YvRXlEdHM4ZWRncVAyYnI4?=
 =?utf-8?Q?gZHeIsWlRfvDsvYoQBfcCz4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59894679-d511-4ead-3f77-08de223a349c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 22:24:12.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1m/s/kfYt5nPKPLdN26qCjBNmlji0trhy0i9trffoWVoSbMiV0joxtz6CxgZg/EKrtSBHQ/NNpQxlW/zzu35ebm04nVdyAjNAsEeZGp7mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7662



On 11/12/25 2:16 AM, Ryan Roberts wrote:
> Hi Yang,
>
>
> On 23/10/2025 22:52, Yang Shi wrote:
>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>> rodata=full"), the direct mapping may be split on some machines instead
>> keeping static since boot. It makes more sense to show the direct mapping
>> use in /proc/meminfo than before.
>> This patch will make /proc/meminfo show the direct mapping use like the
>> below (4K base page size):
>> DirectMap4K:	   94792 kB
>> DirectMap64K:	  134208 kB
>> DirectMap2M:	 1173504 kB
>> DirectMap32M:	 5636096 kB
>> DirectMap1G:	529530880 kB
> I have a long-term aspiration to enable "per-process page size", where each user
> space process can use a different page size. The first step is to be able to
> emulate a page size to the process which is larger than the kernel's. For that
> reason, I really dislike introducing new ABI that exposes the geometry of the
> kernel page tables to user space. I'd really like to be clear on what use case
> benefits from this sort of information before we add it.

Thanks for the information. I'm not sure what "per-process page size" 
exactly is. But isn't it just user space thing? I have hard time to 
understand how exposing kernel page table geometry will have impact on it.

The direct map use information is quite useful for tracking direct map 
fragmentation which may have negative impact to performance and help 
diagnose and debug such issues quickly.

>
> nit: arm64 tends to use the term "linear map" not "direct map". I'm not sure why
> or what the history is. Given this is arch-specific should we be aligning on the
> architecture's terminology here? I don't know...

I actually didn't notice that. They are basically interchangeable. Just 
try to keep the consistency with other architectures, for example, x86. 
The users may have arm64 and x86 machines deployed at the same time and 
they should prefer as few churn as possible for maintaining multiple 
architectures.

>
>> Although just the machines which support BBML2_NOABORT can split the
>> direct mapping, show it on all machines regardless of BBML2_NOABORT so
>> that the users have consistent view in order to avoid confusion.
>>
>> Although ptdump also can tell the direct map use, but it needs to dump
>> the whole kernel page table. It is costly and overkilling. It is also
>> in debugfs which may not be enabled by all distros. So showing direct
>> map use in /proc/meminfo seems more convenient and has less overhead.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/mmu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 86 insertions(+)
>>
>> v2: * Counted in size instead of the number of entries per Ryan
>>      * Removed shift array per Ryan
>>      * Use lower case "k" per Ryan
>>      * Fixed a couple of build warnings reported by kernel test robot
>>      * Fixed a couple of poential miscounts
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b8d37eb037fc..7207b55d0046 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/mm_inline.h>
>>   #include <linux/pagewalk.h>
>>   #include <linux/stop_machine.h>
>> +#include <linux/proc_fs.h>
>>   
>>   #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -51,6 +52,17 @@
>>   
>>   DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>>   
>> +enum direct_map_type {
>> +	PTE,
>> +	CONT_PTE,
>> +	PMD,
>> +	CONT_PMD,
>> +	PUD,
>> +	NR_DIRECT_MAP_TYPE,
>> +};
>> +
>> +static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
> I wonder if you should wrap all the adds and subtracts into a helper function,
> which can then be defined as a nop when !CONFIG_PROC_FS. It means we only need
> direct_map_size[] when PROC_FS is enabled too.
>
> e.g.
>
> #ifdef CONFIG_PROC_FS
> static unsigned long direct_map_size[NR_DIRECT_MAP_TYPE];
>
> static inline void direct_map_meminfo_add(unsigned long size,
> 					  enum direct_map_type type)
> {
> 	direct_map_size[type] += size;
> }
>
> static inline void direct_map_meminfo_sub(unsigned long size,
> 					  enum direct_map_type type)
> {
> 	direct_map_size[type] -= size;
> }
> #else
> static inline void direct_map_meminfo_add(unsigned long size,
> 					  enum direct_map_type type) {}
> static inline void direct_map_meminfo_sub(unsigned long size,
> 					  enum direct_map_type type) {}
> #endif
>
> Then use it like this:
> direct_map_meminfo_sub(next - addr, PMD);
> direct_map_meminfo_add(next - addr, to_cont ? CONT_PTE : PTE);

Thanks for the suggestion. It seems good and it also should be able to 
make solve the over-accounting problem mentioned below easier.

>
>> +
>>   u64 kimage_voffset __ro_after_init;
>>   EXPORT_SYMBOL(kimage_voffset);
>>   
>> @@ -171,6 +183,45 @@ static void init_clear_pgtable(void *table)
>>   	dsb(ishst);
>>   }
>>   
>> +#ifdef CONFIG_PROC_FS
>> +void arch_report_meminfo(struct seq_file *m)
>> +{
>> +	char *size[NR_DIRECT_MAP_TYPE];
>> +
>> +#if defined(CONFIG_ARM64_4K_PAGES)
>> +	size[PTE] = "4k";
>> +	size[CONT_PTE] = "64k";
>> +	size[PMD] = "2M";
>> +	size[CONT_PMD] = "32M";
>> +	size[PUD] = "1G";
>> +#elif defined(CONFIG_ARM64_16K_PAGES)
>> +	size[PTE] = "16k";
>> +	size[CONT_PTE] = "2M";
>> +	size[PMD] = "32M";
>> +	size[CONT_PMD] = "1G";
>> +#elif defined(CONFIG_ARM64_64K_PAGES)
>> +	size[PTE] = "64k";
>> +	size[CONT_PTE] = "2M";
>> +	size[PMD] = "512M";
>> +	size[CONT_PMD] = "16G";
>> +#endif
>> +
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PTE], direct_map_size[PTE] >> 10);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[CONT_PTE],
>> +			direct_map_size[CONT_PTE] >> 10);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PMD], direct_map_size[PMD] >> 10);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[CONT_PMD],
>> +			direct_map_size[CONT_PMD] >> 10);
>> +	if (pud_sect_supported())
>> +		seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PUD], direct_map_size[PUD] >> 10);
>> +}
>> +#endif
>> +
>>   static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   		     phys_addr_t phys, pgprot_t prot)
>>   {
>> @@ -234,6 +285,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   
>>   		init_pte(ptep, addr, next, phys, __prot);
>>   
>> +		if (pgprot_val(__prot) & PTE_CONT)
>> +			direct_map_size[CONT_PTE] += next - addr;
>> +		else
>> +			direct_map_size[PTE] += next - addr;
>> +
>>   		ptep += pte_index(next) - pte_index(addr);
>>   		phys += next - addr;
>>   	} while (addr = next, addr != end);
>> @@ -262,6 +318,17 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>   			pmd_set_huge(pmdp, phys, prot);
>>   
>> +			/*
>> +			 * It is possible to have mappings allow cont mapping
>> +			 * but disallow block mapping. For example,
>> +			 * map_entry_trampoline().
>> +			 * So we have to increase CONT_PMD and PMD size here
>> +			 * to avoid double counting.
>> +			 */
>> +			if (pgprot_val(prot) & PTE_CONT)
>> +				direct_map_size[CONT_PMD] += next - addr;
>> +			else
>> +				direct_map_size[PMD] += next - addr;
>>   			/*
>>   			 * After the PMD entry has been populated once, we
>>   			 * only allow updates to the permission attributes.
>> @@ -368,6 +435,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>   			pud_set_huge(pudp, phys, prot);
>>   
>> +			direct_map_size[PUD] += next - addr;
> I think this (and all the lower levels) are likely over-accounting. For example,
> __kpti_install_ng_mappings() and map_entry_trampoline() reuse the infra to
> create separate pgtables. Then you have fixmap, which uses
> create_mapping_noalloc(), efi which uses create_pgd_mapping() and
> update_mapping_prot() used to change permissions for various parts of the kernel
> image. They all reuse the infra too.

Yes, thanks for catching this.

>
>>   			/*
>>   			 * After the PUD entry has been populated once, we
>>   			 * only allow updates to the permission attributes.
>> @@ -532,9 +600,13 @@ static void split_contpte(pte_t *ptep)
>>   {
>>   	int i;
>>   
>> +	direct_map_size[CONT_PTE] -= CONT_PTE_SIZE;
>> +
>>   	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>>   	for (i = 0; i < CONT_PTES; i++, ptep++)
>>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>> +
>> +	direct_map_size[PTE] += CONT_PTE_SIZE;
> Similar issue: we aspire to reuse this split_* infra for regions other than the
> linear map - e.g. vmalloc. So I don't like the idea of baking in an assumption
> that any split is definitely targetting the linear map.

Yeah, this needs to tell whether it is splitting linear map or not.

>
> I guess if you pass the start and end VA to the add/subtract function, it could
> fitler based on whether the region is within the linear map region?

I think it could. It seems ok for kpti, tramp and efi too because their 
virtual addresses are not in the range of linear map IIUC. And it should 
be able to exclude update_mapping_prot() as well because 
update_mapping_prot() is just called on kernel text and data segments 
whose virtual addresses are not in the range of linear map either.

And it seems using start address alone is good enough? I don't think 
kernel install page table crossing virtual address space areas. So the 
add/sub ops should seem like:

static inline void direct_map_meminfo_add(unsigned long start, unsigned 
long size,
                       enum direct_map_type type)
{
     if (is_linear_map_addr(start))
         direct_map_use[type] += size;
}

>
> Overall, I'm personally not a huge fan of adding this capability. I'd need to
> understand the use case to change my mind. But I'm not the maintainer so perhaps
> my opinion isn't all that important ;-)

Understood. I think this is quite helpful IMHO :-) Thanks for the 
valuable inputs.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>>   }
>>   
>>   static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>> @@ -559,8 +631,13 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>   	if (to_cont)
>>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> +	direct_map_size[PMD] -= PMD_SIZE;
>>   	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>>   		__set_pte(ptep, pfn_pte(pfn, prot));
>> +	if (to_cont)
>> +		direct_map_size[CONT_PTE] += PMD_SIZE;
>> +	else
>> +		direct_map_size[PTE] += PMD_SIZE;
>>   
>>   	/*
>>   	 * Ensure the pte entries are visible to the table walker by the time
>> @@ -576,9 +653,13 @@ static void split_contpmd(pmd_t *pmdp)
>>   {
>>   	int i;
>>   
>> +	direct_map_size[CONT_PMD] -= CONT_PMD_SIZE;
>> +
>>   	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>>   	for (i = 0; i < CONT_PMDS; i++, pmdp++)
>>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>> +
>> +	direct_map_size[PMD] += CONT_PMD_SIZE;
>>   }
>>   
>>   static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>> @@ -604,8 +685,13 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>   	if (to_cont)
>>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> +	direct_map_size[PUD] -= PUD_SIZE;
>>   	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>>   		set_pmd(pmdp, pfn_pmd(pfn, prot));
>> +	if (to_cont)
>> +		direct_map_size[CONT_PMD] += PUD_SIZE;
>> +	else
>> +		direct_map_size[PMD] += PUD_SIZE;
>>   
>>   	/*
>>   	 * Ensure the pmd entries are visible to the table walker by the time


