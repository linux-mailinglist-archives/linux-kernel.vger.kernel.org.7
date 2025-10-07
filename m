Return-Path: <linux-kernel+bounces-843665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A58BBFF31
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF47A4F2783
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDC1C5F23;
	Tue,  7 Oct 2025 01:25:23 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D7196C7C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800323; cv=fail; b=KZ3Y1k1Us/XDNFZM0fHYus7g+kgL5eDcc96e6PhpP0R+AbS1nHYsV52mO1gPKbv1yg4wPKMzf+feXwKDHTIS1RPqWTfJFsveoZO0gjc7qnc3XsxcuHLkApIQk5vAVPOO51eZCo+643zNw1yL9o23w66wHwJJeUE8z6+EIcFDvDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800323; c=relaxed/simple;
	bh=I6LzgXtJJFkrQEkPnj2MpJaoFMAHtb0skNZ+wqaqoMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vwd7/BgxN9jdCHV74wL55yJlckEfhgV6pjvchAzLhgwvDPux0srQVxK2FGsMfphA+i5nK+pY0CK4M/OWvpEqbP6AUB538YPGbfbo/+63iGGyS6PRekcuNy/VlNKaq/e6rtEKUceUMuO1iar69Sqr3jlSF8w2pOOlal5Wvzb+eGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQmZN5lnsbbBk0q7Gpjjp4MjPwBjkHwG58Kt+HoUZW6dYrw9JtevQv2TYNnNVxSiJ3et81Qg/IY6TrJuajDQ1EGEo+5YDfv2sCCgBvQdxlAFKr8o75kkvPiqe39qRJVRCqllJtJn8aO1fiYk059nsbq/z6yU2OrJ01kyYZVkQVjCseKaZhlNREGc6PIK/0xstt1XBTdSwBwFcRoxJinULu1k2Kfr4Kb2t5RmWqRJ3iq1kksQh5SvGRh5HWnkt5siTmQ1198E6mMk1uurrbA1jIkN1ahjzfeVna5+r+KnvC6SacMUN7zDWqSB+sMyWixAF7BFk4aaO81XBLgdjEv33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO1mPx4+4Y3KIHxtzEz6Cw+E56V/DuVEcgvpcn7Fa40=;
 b=CI5zCCZ+vNJZPGDwoTjzhpdmwGMfBordXx06p2DtqerrK55V8DFGOve+GAWncqa4WA5sQmAEeHQohA/qchbcjgAeDAoDRp36lKrZFbc9n0Hp1z2AEkVu9oF5qLqchowOLbhlB7hWuLZ204J50Ro7LeS+Fg/yEXEn9UP5Fy4KbJhXEYcCreyr3L0hHyqrocX7nLKWUeHLLC5+vcaUkkZSGobF7YxQcR+/lGKXM9+yXrLqtnyrDLefLN/NiKnRFYwne9G18zPGQOYn2SAY5L8mqugKykN/zkQ1Y2OomsJqkgGTRXpsCD3XyfAe9eF7WImXKQNzalQ+9Ufb9iwmAd6SZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8319.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:25:12 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 01:25:12 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tick/nohz: avoid showing '(null)' if nohz_full= not set
Date: Mon,  6 Oct 2025 21:25:04 -0400
Message-ID: <20251007012504.16118-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251007012504.16118-1-atomlin@atomlin.com>
References: <20251007012504.16118-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aa765d-066b-4608-23af-08de05405cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0JwTHNoUFFaeTdncWFLQlpleGt6NXVlazYyelZNTGpIeUJNT1A5cEJxRFgz?=
 =?utf-8?B?cVFUa3R0S3I2aGlUREZGNnQyVngxK012Ung3SHJJUnR4WjNHYlgvSEpHVk4w?=
 =?utf-8?B?VnBRK1Uzalg3V1B4VkFFS1BEKzNVSXdUODRmNjlVYWtBM2RsK3J2YVN2QUhL?=
 =?utf-8?B?Mm93WjFHTFBWWGJJbmIyZWh6emNCSmc0UTZlSUQ1K3UvV29sU2lkbnQxZmN2?=
 =?utf-8?B?MWlhM0prd1gxOU40azF2K1BQUlpnMkttWU1KK3pQQUZodFpibmZsWGF5NklI?=
 =?utf-8?B?WWNoTlR1L1JGaEVVS01TMUtOcGwyVkxCWnBpK1QrbkxNYlJTb0k1UHBOekw1?=
 =?utf-8?B?eklrNHZ0bXl4Uyt2MFR4SkhzSHY0ZjRtek5SRlhXTE9NSE85OEJpQXluT0d1?=
 =?utf-8?B?a0lmNlRiK2s2Wnp3V1M4M3JRclI2aUVXN1U3OXcwVGtEVS9RaXhEcXFlZzQy?=
 =?utf-8?B?K2Zja0JYYmJhdDJUcTlNYlRiTG5uMWxTQUZvcVlrREQvQnNZM25nMnhDN04v?=
 =?utf-8?B?Q2NJYWZSS1lkUzdvdUNLN29aa0l5c0k4TnZlSUYrTmJVMThxN3ZvSTdGS3BQ?=
 =?utf-8?B?aUxTa0plaEFwSjJoM01XSGM2c3d6TjQxNFhrU1AzWnJWRk1mVGc2RTdYenE0?=
 =?utf-8?B?RTJGQXNuWEVPQ2oyaS8zbElJNHhFdldiMm9uWlhadWd1bS9LWWlkV1VSbTRq?=
 =?utf-8?B?Y1BGeTZTb0xjOHJvNzQ3Z3ByUVZHN2FvZVJrUmQvR2w1ckMrY0t0ajh2YU5z?=
 =?utf-8?B?Y0VqR0lkeklmbnI3WUNacDBHWkhNdEFtVmRVOXN3cHdDVXlNRW52c3dKbWNs?=
 =?utf-8?B?RlRsMnBFVXlodTB3elRlTnF2Q2tmWmlPOE83Z3ZZT0xXa0lzVkVCeDYvcnVr?=
 =?utf-8?B?SE9jT0hXanBrVWVFYjI4T3M4c0xud2VtaDlqNlhNbmJ6Q1FKQndWaC9kRk1I?=
 =?utf-8?B?SU0rVFpMeXNpR1QxQ1V0SC8wWFBvbDdUeG5ydHVBeGVudFhPTjl2UWR1Q3pQ?=
 =?utf-8?B?NVVmM2VSNEIrMW83aUoyU3FJMGhEcG1RQnd5YytxMkV1OTduRlZFUTZhR3A5?=
 =?utf-8?B?cHR4QVNvOC9vK2dPY1E2a0ppUlFCZGdLV2xDMk1YZXFLeWc0QnR3eVJEWk05?=
 =?utf-8?B?Z1JDb1NselV0NXk0NUZnZ3lvdUV6cjRVbFJLQi9hcUlrZmNQVlcxSmhXSitQ?=
 =?utf-8?B?VFk3eEVEbHBqMldPbUVWUVRidFJYSFZNWCs4ZHJYMUtoUzg5T1ROUXJoV3NG?=
 =?utf-8?B?WjdBNGRNc1o0WFBhL2hIbUdyOGh6dFdGV3B4d1lUa1dkekorWVNGNlNIbW41?=
 =?utf-8?B?MFVCOXpQRnBPVUU1dHY5VDFCbUtpU2xpUHRwSldRSThyYnkyVXUwOGMvQTFx?=
 =?utf-8?B?SXp0bjZqR3c0cDhtZGVvUG44cTF5LzdMMjl6N0x1elNkYWlmbkU3RGpJR1JL?=
 =?utf-8?B?OEEwZmxidURCWjhkeGpRZ05RT2YwVlduWkY1RGVVdy91S2RzOFVzTFVSS3Ji?=
 =?utf-8?B?TjJabXY1alViL29BZGd1Q0NjR04yK2JTaGJvbDk5dmpkSVpuRDM3cnYrcjhF?=
 =?utf-8?B?OENjSFhnRTl1RmlCaDh1TVM3QlVZWG5YY2VvUmsvcDlXeU11MFZLTG5tU0RE?=
 =?utf-8?B?UjRJaUlIcUp5VVlzeWRyNkk1d3hiS3dnUlpDQzJ5L1ZkQUQrb3g5SlpQd29H?=
 =?utf-8?B?b3M0M2xwVUMzNDZnbHBXVlF4WmlCeVU2RXJQQklwaWNxbWZkMlNzRUVqMEVN?=
 =?utf-8?B?WGUwelJkWURHM3o2ZlNobmNOOEM3TjZhRDZLdUNvUlJKenl2WDl4OXROU3lV?=
 =?utf-8?B?M0pmeUVEanpKUXFmN3ZmNUR3QS9DaldST3U5SHdRMks3Sy9sU1Z2SHJkZGJB?=
 =?utf-8?B?YXRuMitzRE5HcDFXZmFnQUpKd253QWNmZ3VGc3RMNUJQeWMrbGZZcTlYSDIz?=
 =?utf-8?Q?ugeLe3UUbBd3fXQkpVpyLPZSG3mYQLR4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnU1blc3SVVjRjY3WWV1RG01YUMzNm4rdDQ2YmIxbXllbnB4dFZCRDMzNS9a?=
 =?utf-8?B?K1VPMk5uVTJwRWdnMVEraWdua0NxT1ZCZzJOS2p4TW84SmRONm44akZ6Mzg3?=
 =?utf-8?B?ejFEYXJCbG5rZTFlQVZwWlVRYUdQSld2M2Ezb3QrUGNrVnB0eXMvUlhINWpq?=
 =?utf-8?B?M1J6Yk5ZQnBRSWlWWWZMRVBuUllraGVycS9lT0l0Nkd5ZlVXME0wOU5sbEhU?=
 =?utf-8?B?bGE5ZHhYa0dla2pNSjA3bDN2Q3I2ZVEwdXZYRjB5azR5MHhQb2dNZEVQaHNR?=
 =?utf-8?B?REFFV2dlOGRkSGtDbXg1L1Uxd3RqUnRTbHZyT2hWOC90QkN6WnBybGczNnJT?=
 =?utf-8?B?bGxmMVZ1dXRNMTF0dFA0bXgzQ3dPQXVPcFo2MHR3VW5OSENiN2VCZjNUQ0NT?=
 =?utf-8?B?alhnRGlYVytUK2dadi9veGtHT0FLTzFsaStYRTBQT2FGei9xR25nT1pZYjdK?=
 =?utf-8?B?NUxvZXdoNm1xaFBrN3dtVDZReW1QWUIrME02a1hZWEdCU08rVklKbDU1bFA0?=
 =?utf-8?B?dk52R0xkbEtHZTQrYnpLQnV1NFJOUTlaNWl2WGh0bkwzc2dPUUlQMU82L2Vz?=
 =?utf-8?B?c3diSitnQTVpcllaR1JiMWNKdXlKVXM5TEhBakhaMWxUa3dvUjQ5WCt4U013?=
 =?utf-8?B?cmMrRjkwTmp4Tm1hTG5zV0RJamY3YUV3d3Y5a3ZBcGt5NkdnSlN6ak5BT1dE?=
 =?utf-8?B?ZmFNdlhoOTRiSFYxNHM0MWdhTHRJUzVQSkF2YUhmTUpieHVRZyt2bTJXSFdB?=
 =?utf-8?B?L212ZVlQbHdpOGNQOGlDTzM2clJ2Y0QwWnlGeFVwR2dpZ0MwUGQzVld0aW1z?=
 =?utf-8?B?QyszZkt0RlVSZzJ5Wkw3M05Wa25UNnVOY3liYkY4cEk3RUttdkUweUoycm9t?=
 =?utf-8?B?NXdJWmZtVkpvVURvNWVQeXZYUEpMMURXYytVSEZxQmszamtrZmdsaDJhKzdw?=
 =?utf-8?B?bHgvdTVxT3Mzc21JSnBVaU9rN1NFY2o4aE40Tmk1LzdGNWszU2V3b1AwZS9n?=
 =?utf-8?B?N3A3MXdoRHc4TDhlbUdIS1A5UmVBSHkzWE5ZeXhjYjNlTkNRcUhmRFBhWlIx?=
 =?utf-8?B?cXFHQVZOMnRuQWUxTG90OFNGdXlpdlBWZDQ3Z21BSVFxakRYUmhsTkZLNzBv?=
 =?utf-8?B?YUJIbWV3OWhjZm9LK3NKQVVSbmdXSy9oZ3lQOWQ5TDBSL1JwRGNnQmlmTUlu?=
 =?utf-8?B?YzVHOGFXN2hEb0NYNkd6MGM0SEhVSUQyNU5WL1pma1ZSNzdLUVVkaFJmS0JU?=
 =?utf-8?B?M3BoYTZKaXV1Q3ZscEcvL2d6dXhDRElSaEh5MUw0enhpd2NaVmo1d0tRTHUv?=
 =?utf-8?B?b0szaldkSkYzS2U2VC9Ua1ZNaHhWMGdDQVJ3NDVQMkdVVngyYStsTGMvYk5X?=
 =?utf-8?B?YncyRm9FdWhrYW9tMkJDamROb1QyV0pidWdRUWFVUjEzUVdpcjZMNjlMTjZq?=
 =?utf-8?B?cjhYMjJOcVQ0dFRSOUNuNm5KK3Bzd2VXYnR2SDNTN0dTaGdVOU93NWE1OThm?=
 =?utf-8?B?N0EvNmUwdEl6dlhoQk9OYkNLSlEycnZKU2NFVGd6aDlCODUrS1pzSFY5eHpC?=
 =?utf-8?B?ZXlIRkY0Uk1WYXIydm91OUFOd0pxT0Y3ek1qTHV4Y0U5UjFQWEpWRTBuTUQr?=
 =?utf-8?B?TEZmbHNnaHhsc3Z0THNWM1RoQ1Y0a3lXeThjdlkrL0dFeUhnNHZwcGdZZ2M2?=
 =?utf-8?B?S0M3TmdWYVpUZXVWRzlXYWxWTzdiZERmNGhHbEJuVEd0Y0JuMFBDRFN1d2I5?=
 =?utf-8?B?NjgrOU13aWttQ2RzNmlteUk2TXZRdzE3QWFQNVdieDN1UEJLeUZHYjV5TjZ2?=
 =?utf-8?B?MUdkb0NZZWhPQjAzc1VyQ1BudTlCTzgrbjExem1JUkV4eUdWV0JYWTJhYmRT?=
 =?utf-8?B?ZHVjVjZBa01xcytnd25GdWV4WnVmZTNmZzRIY1RyK2ZhejhjNzNMb1NySVJ4?=
 =?utf-8?B?SU04cUs3RlAzOEhYWXhFNE1xeDNvcllYRUN3WmVtSU5zTzlSM0Jvc0xtY0FK?=
 =?utf-8?B?WGZpYm5TTmZEeE1aZ2dqQjBGUmQ5enR1ckdvbkFodUpjZnlGOFdmclR6T3Jw?=
 =?utf-8?B?V3lDUHlHTGprYXpOOC8xVGZHK25zMzNDbEdZSzkrQVJqT1V0aVRTOEV4YVY4?=
 =?utf-8?Q?01oRAB2HnDZzvgxDBHUfAR/VV?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aa765d-066b-4608-23af-08de05405cc6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:25:12.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +di+ttit59cFiyiYTT1Avyf1+7zl/MFQTnaEC6l5Hdze56vJ5oVmsMQIxshBe/YueNrM8b3QNWPyYA7BJvEXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8319

In the context of CONFIG_NO_HZ_FULL=y, tick_nohz_full_mask (of type
cpumask_var_t) is initialised to 0. Memory is only allocated to the cpumask
data structure, in tick_nohz_full_setup(), when Linux kernel boot-time
parameter "nohz_full=" is correctly specified (see housekeeping_setup()).
If "nohz_full=" is not set and an attempt is made to read
/sys/devices/system/cpu/nohz_full, '(null)' can be displayed:

    ❯ cat /sys/devices/system/cpu/nohz_full
    (null)

This patch changes the output to print a newline (or 0x0A) instead of
'(null)', making it consistent with print_cpus_isolated() behaviour.

Fixes: 6570a9a1ce3a1 ("show nohz_full cpus in sysfs")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/base/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fa0a2eef93ac..10924fb5103b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -304,7 +304,11 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	if (!tick_nohz_full_mask)
+		return sysfs_emit(buf, "\n");
+	else
+		return sysfs_emit(buf, "%*pbl\n",
+				  cpumask_pr_args(tick_nohz_full_mask));
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
-- 
2.49.0


