Return-Path: <linux-kernel+bounces-816482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E7B5745D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E911727A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3792F0C64;
	Mon, 15 Sep 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="aJQ9+PVB"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023138.outbound.protection.outlook.com [52.101.83.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5B2F2913
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927699; cv=fail; b=apgge2/IobgGBS1MU0d10U9iokD5PKE176BAeBATiiWoKjpNxxTgyahFumIjcYislq2M3JduRDCSyGCVfdAO4RJqD7epUciophAbomEyFQuwN0nBLt0kLXLE3sm9Nn4u2DhkK4jaf2kMrhLIZDybk+osXcDCZ7Lrrhq65jU9v0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927699; c=relaxed/simple;
	bh=de25aI2M2TxpFTh45HpXhtQF02esbwnpSYa0stiI7j0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4ovUk6r+KE3pqbAJqagA87ki2xqaBp6a97dMhPgo2ChWrYoEhj/lNyXL0vBO5sg4EYvE3uR/n55WODd3/djnLtgodMvUlyiaP6zLFwBurZDxRLuMK2WHYh8gaATVmvsUqlGUx8sseDxNcgxqmZRX/lTEHy+Kna/L8BXmqqW/TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=aJQ9+PVB; arc=fail smtp.client-ip=52.101.83.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFPX8nVNC+1I0iJ1o4xxo5FGaw1ItLfrDR69pKflZbnAqaj3fghws3rfKjcxsUDgioCfGoRWKC5NOJJ1u1zZqspP9oPaPjWaT7AUtVNQp0KGHJIMSyAEuyzNe6gdQaXLyFCvntKlXoisuy1qBMpOUX8Ape8gpCoDgM15Qm80PM/R/QJHE2otkYNJlohzO9dLjN64WqauLId5GmQMvNJ+Jt4AOvPIyAxcSgjxKecYLIowa6Aaspbisvx3IVCbiMbQ6Kc4CXCeXzKg7cDxVoe1SYp7co+bdUe44vH0HbhoXZqXsaxRqflYAynRAtbA5kjD8Sm04pkk7RFTHBKMUDxe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYBK/554M1s+dRijhSMn9jqPzg/jAN58mUNq7pWQbyI=;
 b=JwW7PpIDw0IfKmUgtxgP4MHjaQTVCIj0dv9w2Z6smy+kXKzOcSmKQRZlXZnkjTk01CEC65v8zxCUjZ4gvBc/Idl0lHm/IImBXORK/qmJe/L2lHxuIr/BIdt2XPY7LRU60ivhO8M4nAzdOtFFz4HSHnRq5yC2MZvaHnDYHu3xD/roxEcsz7Clx9BZdH0HiyFLorIb2o4y/sbTdbCBpq6iWaiMAROS3UKucvtQ5Kl3tg4uSWOx+viYbZqgwuOb9ybmvzaWvHY+T2a2iFUsbHm7kZCjGdIgPeMJt8c/P7OMaGGfWeKBdmIIcOY4SD6/2A8rYGbQqb9A0kyMbo3a2f17Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYBK/554M1s+dRijhSMn9jqPzg/jAN58mUNq7pWQbyI=;
 b=aJQ9+PVBCCrcYfqA8s0hOm6rsIGvIFhX5i07EXgeTXaThbguVPHBoB/21ZnuSSaiTmzAjqtLHluU4tdormOvSDQiEZjGx7qbezcN8PgMUyPvyhKERu0hYbKKz3sAFyr4F5hDiiQtqVy4agxIx7g2tDRTop9whQokJJCI/msWmzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 09:14:52 +0000
Received: from VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae]) by VI1PR04MB3984.eurprd04.prod.outlook.com
 ([fe80::e8a0:97a2:eb7b:afae%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 09:14:51 +0000
Message-ID: <2a8277a3-1ab7-4a78-a35a-0af983e1c112@sch.bme.hu>
Date: Mon, 15 Sep 2025 11:13:43 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mailmap=3A_Add_entry_for_Bence_Cs=C3=B3?=
 =?UTF-8?Q?k=C3=A1s?=
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250915-mailmap-v1-1-9ebdea93c6a7@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <bence98@sch.bme.hu>
In-Reply-To: <20250915-mailmap-v1-1-9ebdea93c6a7@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To VI1PR04MB3984.eurprd04.prod.outlook.com
 (2603:10a6:803:4e::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6628fc21-79f5-4d94-0716-08ddf4385357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|366016|19092799006|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXkxcGNtRTd6dHFCNGVuc1g0WVArSHBuclFRTVA4MmVjcWUzbWM1RFdBS3ZB?=
 =?utf-8?B?UjBFUGFKQnJtakphWTUyN2tWMnZ1N1p5eE5UNVgySEU2NWU3L3VEV29POUxL?=
 =?utf-8?B?VHFYZXpjbFFhdGNLbW9teXNhTWFaYWgwc2hQZTFSTVg2UFBDakxoUjdxeWtP?=
 =?utf-8?B?STdYRldMdWFPOEFnb3R4V3ZjNTROb3h2V01KaDlncWVzUkozaTlwSTJHQ1A5?=
 =?utf-8?B?WFJ6Mjk5Ykh6ZnRnL0MyWW0wT05TSjNpVnJTK0dLbkxqaGFpb2F1bW16a0FM?=
 =?utf-8?B?WWhydnUvQ3c3WGZjWk5NNlFoU0dxUDNjTVEzWW1vc1FKTVVxOUdOc0d4Z3lV?=
 =?utf-8?B?MS9HZWVFUlJ0SG1ROHF3dWs5THphYkJ6MC9DdnY2NVBIUFNuY29uNm85OENP?=
 =?utf-8?B?VUdNdWpkdEZ3T2Ztb1U4anUyNDRtQVNpd1pYU0tFNkxtTklIRlh0Rm9CZm14?=
 =?utf-8?B?d2dRMFRwUE9oKzlEWXI2WCtwQW9RNkRNQjcvTm5tTDUyQ1ZzbFhwTnEzbkRz?=
 =?utf-8?B?Z2V5ZkV3TFA5NitYTUl3a282a01OMXAyeVkrd1lYaWkzTmpOWVFFc2swMmJS?=
 =?utf-8?B?d3Y3ZnVJQVdCRnRFeEl2SzlabFZaTzVyUEE4QWZkenZ2eHdGdnpWUDB5cFk0?=
 =?utf-8?B?V2Y3eHI2MEtZd0lnc1RwNEVhVEVCUnFqem0ycWU3M1JRSmVCUy9JVDUyOERk?=
 =?utf-8?B?cmNERXhJMVVXUFgyM2ZHdllNTjJMK2MwWUd6eDhNNmJiVVhkYnlGTFU2aGo0?=
 =?utf-8?B?Z1ByMUpad1UrR2NMdkgxMERyeEwrRHlJUjBvVWI0NlZUdVlqSjR5ZWR2T2hl?=
 =?utf-8?B?bnQ4LzJJMjhSK2tlL0xuL0tyMmFBUWJFNy9Va3lFdUcvdGRBdzM1Rzh5U3BT?=
 =?utf-8?B?d2lNUWhkQlg0azNSZXJoOGpGMVNqdXoyY1Q5aHpQNXVFcFZiRHh6TVhNK0ly?=
 =?utf-8?B?aE5vdmxSaTQxQzVIaUxtNkRhKzg1bUpFM3pZREsrM1FSY00rSWpCdkhNejFm?=
 =?utf-8?B?bDU3WFdHdE5HcTRCVjByRkF6MTdySHozenkyQS9CWUtDSTRlVDhWTUpoRkx4?=
 =?utf-8?B?NmlxOEdkSER1SngxZmhBbHE4VHFUbW00YkljK0Flb0hQdW5MdFVlVmNNUFZC?=
 =?utf-8?B?NmZ3RmhlMllIZHA0bUU1ZmZtclJsNU82cEdxZ1h0S1kzc3A1RlZMQ2ZIY1B4?=
 =?utf-8?B?bTFabVVpaFhtQ1UxdzQwVnNVclI0MFgrVkd4MThJcXJxRXJNV05UVlYwdVlZ?=
 =?utf-8?B?Mkl4RU5GZHR5ejYwTlhxR0RremtxTHBkNndDajVFTXZSZzJOR2RXS281T3BD?=
 =?utf-8?B?Yi9HQ08vUUFsNldoaG5EcDR1bmUzTXhPcWZCVnJveHcrSDZyTkxPRGlqcDY3?=
 =?utf-8?B?S0ZPaHpjYnl1VFpaSnBMYVpSOERPT3FuZWtMSUl4enRtemVEUFN3a1R0N0Z5?=
 =?utf-8?B?ZVAyeXVxa1BKdU5CVjN6c0dHdCsweTJ1VXV0enpBL1JmM21ldVdTYzhod2V1?=
 =?utf-8?B?VllaYVNqak5MSGlqcGpBWlJENjFOV21mNlhPQitia3pyWXN2ZzA2UTA2dHVB?=
 =?utf-8?B?aEE2UXM0NW1JaVo3Q0FaUFJ0VVBJWEY1TUpVWGFxUXNCMk51RGJwdXFLRkFt?=
 =?utf-8?B?ZGdMNkNMcGxlTGdRSzdxV1VrRkp2Yk1mZjJYejdQOG1JaHZsbHNMN3ZZenlw?=
 =?utf-8?B?aTdoQTNoZUVlV2xMU3FTRmdoNVhta1liV21la1R2bHpGYnVvRFdPWTZzc1FM?=
 =?utf-8?B?enljT0JPNndTOTZHRzV3U29wS05RNWRlUUdETXVMM1VDd0hzWG1IbkdNOWlJ?=
 =?utf-8?B?bXlTbWxWTVRnOFV6dUI3eGVrYmh0M2NpeXNwc3lPOGJDTzFIa0JuRXJrMFhu?=
 =?utf-8?B?V1hkMXMzR1Jma3lHd05xb2pJcDZkem1ZV2pWakJzUU44dnlFZnY3Zmx0MCt4?=
 =?utf-8?Q?rMJZgr34Zow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3984.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(19092799006)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdnK2FyY0VoUlpjUlVYc0hUZUdYN0JZVmVXcXZETmJpRklKL0RDdjdzUzIw?=
 =?utf-8?B?MEJTSjNCY1p6NkVpMmxhVmFscGNTZklpcTNubEZ3MERDRUF2STlESkRBZ1cw?=
 =?utf-8?B?eUgrczEwdEpCWUhlQUJMbXJ2V2wwaXJtdFA1WW9jSStyakpIaWg0TVBIWGZh?=
 =?utf-8?B?aTRocTFWTDRFcXI5V1ljZ25oNWcxZlNiQWJsQ2VOU1dUT2NyaUF1YVI3TXlm?=
 =?utf-8?B?ZVdNUjB5QnRnRUdxeEg2bTVzaVlqYjQranlaZkZFOEJvQkhVZjdUa3lzYUw2?=
 =?utf-8?B?VWdnQkJBM01oWlFNS1NVNXZhbXcyT0xveGdJL0NXYVk2VHNsMy9KV2VkSkdk?=
 =?utf-8?B?WWZZTVNla21Ya0pSRDlhMG5FSE1yVkRhSjI3QlkzclNCdVVMTkh3alFxUkxC?=
 =?utf-8?B?RDJwdCtZTlBKSTN5RDZsMjZjWk9WdHZuRkcySkNUV3l1bENJUE8zMk5QNkJh?=
 =?utf-8?B?dmhBSUt4TDEyYVY4RjdTUjh4d2tUa1RxQmhyRGRUN0ZvcmswV281V3VvcXRJ?=
 =?utf-8?B?VnB0TmMvbG84VUI4dUFhdGhqUURvOEJpaFB6RzNRSWZwTG5jM0o1cUJlSitV?=
 =?utf-8?B?ZSsrWDl3dVh5Y05BVmtydHlrR25DRGNSdFRWbGNmNmpWRVUxcEt2aEVkR3RM?=
 =?utf-8?B?bkRlVThWdzNhZzFmd0V4cjVNZW5rNTc2YXMzcmtZWkZtREM1OEFZNjQwTE1q?=
 =?utf-8?B?dmdWVlRUZ1FsR1g4RHRSR2dNMmNXM1Eva3BQdE9KOHFQZXNhSTg4a3BSZGtK?=
 =?utf-8?B?OGl4cWZtWXBlMmFhMy9Yc05GWjZvQ0xoTGJsNGdnSlFXWmMvQUcwN3FlN3pN?=
 =?utf-8?B?OUJVOTZxQ0FqR05BbUttSkF6ZlQ3WGVXMDB6N2NzZFZpZnVxK0tIYXhIUnB3?=
 =?utf-8?B?Q3p3YWRldEp2S0Q0UVkvZWdCNG1vMEF6MlcxYlBOR1I5WnZQdGZsTjZ3c0t3?=
 =?utf-8?B?bjFlVmd6anFwUTh0eGkrbnhCRk1tZExKR05tVU5lQXM3V1RydmFubmthc09M?=
 =?utf-8?B?SGJQZW1Rd1MxUFRuZDdMMUhQWDdPNURnRVQvKzJZSXhRR1Nud2p3M05CN2Fu?=
 =?utf-8?B?NzBqY0kvTEdPZVJnblpJYi9GcEVQcWphMmlGQUZqaDE1V1ljQ2dQdXdNeUFl?=
 =?utf-8?B?OFJPeUxJNHlQa1Q4VVJzYUdlZitNdzBxKzhNWDkxOFdSWVdOdWFYcU9OUWhs?=
 =?utf-8?B?UElrNzA5NiszL1I5Y09NM3lkNHZJbTBkM3lFK2RWYVlGazIwSEFmazV2MjE4?=
 =?utf-8?B?NEN3c0pWV0Jwa0xXM1pKTlQ3L0lRS3c5bXF4OGxHa1VXZ2I3YWR1S0FOMGNM?=
 =?utf-8?B?UWMwbGFxR3I3S0h3UVp4UXJtU0ZuTW80Ynd3MndUcWVDU3FDUzBDVUVGbUFQ?=
 =?utf-8?B?aVFmVyt3M2pqcDhCYWxQYkRYMlRvQ1JITXVmV0FnMzRxZWR2YjNWQWJmY0hR?=
 =?utf-8?B?OGV5NFc3bUx1R25HNzdyYUc2dHBNRVo3ejhGVWlrYXVrR2xiUzl0cDFwWXp6?=
 =?utf-8?B?ZjR4MXVBdlpKTEcxeWlNVDJMNUxiYks1U1BjaUNHdXN1SVp6UEJLM3J5TTNH?=
 =?utf-8?B?dVR1WHprZmlZQThhcTN0ZlFSaVg0dHpvR2VUeEpWZkl3aklCeUsyZDY4SjJt?=
 =?utf-8?B?SS9GcE5pS1BXS01SUEcrRnd4b1B3M0p6WEg0MGtqY1NTY1ZwZXNXY016TWZU?=
 =?utf-8?B?Y0s2OWNLSlRJclFaaUVMU0VmNVlsR2srd0ZPbkFGdkRCRCtYZG5aak0zMTVJ?=
 =?utf-8?B?VVFsaklOZnVJaHc1bEhrZVRyQ0hyZ3ErUWNxNzA4Mk5UME5tSHAwd1ViUEhq?=
 =?utf-8?B?RGJYV3NTMCtZb2hqSEdCSGNhMTJMZ25JMXNsWEpCWm9zTkE4a1gwUklKMGVa?=
 =?utf-8?B?Nlo1b3JodmtZMFJldVgra1NoRmhvUjRIcFpFRW42SXRxWUxyY2NCYXVJSFZC?=
 =?utf-8?B?ZDh5M1hmWVZnYm5RcUlEZ0JvcFAzaENTNmhWYUVMZVJnMUNxYTFPRzlZRDVu?=
 =?utf-8?B?R2k1eGRpVTc1Q2U5UFR1N0ZIc0hHSFB1VStSMldpZjA0Nk1CNm9jdHJJMVYx?=
 =?utf-8?B?b3p4aURmVFN1RlBsdXF3UWdLeWJNTGlIUmRCSnlrNmtPakhmTzFVeVBCbGpV?=
 =?utf-8?Q?tHpACH9rsHgZSEAFpankPSbKr?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628fc21-79f5-4d94-0716-08ddf4385357
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3984.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:14:51.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2lJcbr2uiOA0huvwrZ6+c4H7nB7QaJx3mUROzw56bZtt3c69UcABxZArLCbAxxc56Tji+y2mreOqOcA4Vkp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

Hereby I confirm that this account belongs to me as well.

On 2025. 09. 15. 11:05, Bence Csókás wrote:
> I will be leaving Prolan this week. You can reach me by my personal email
> for now.
> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Signed-off-by: Bence Csókás <bence98@sch.bme.hu>

