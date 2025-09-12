Return-Path: <linux-kernel+bounces-814583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6119B555EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27982B60EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77432A823;
	Fri, 12 Sep 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="WqDFNydh"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011057.outbound.protection.outlook.com [52.103.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C41302CB2;
	Fri, 12 Sep 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700861; cv=fail; b=i9kcuy1Lpa0CnqiqNnKaelTXcNCh65V6K5+44GN65CRTHBD9XFOQW/DT/fFVz8roXgrCKqjrEEVA7FsmcI+W22Rte+5k7N6i5dj6O1u6pHOdDpyPHXAXhjtzir5F/9gycNm6pLOwuGeY1e3KzmysJNSsB37PD7h6Ejy4IxaDZac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700861; c=relaxed/simple;
	bh=fVP0oq5C2GKVx1n7yalNWTzWsY0wDjNpOmyaqxBJAWA=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=cEnmTaohryQH4qUxkPzqLZeWZKPzIPZKKNK7OXbRCgCHJwO51FTHXIXjfvrwYkdZ7D2qmKMEIbECgH8dzgXMuZoxSCWkeMXKJlbR+e3bizLr4EzLN/GQ7zvAiKD/a5eZKWUlah8GzGq6pI2CWudp6y5cKm+DzdFOawSZ8wEAydY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=WqDFNydh; arc=fail smtp.client-ip=52.103.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4SzyZQgsfzTVNGFPfmjB4X8eOqc84tqSjknUXtmhBBjhfRrRhewd5+HUZ/42JYP1cAkbSLmd7t8XRlh9a3VGL3iwRLXODz4ia7+skt5tNvH6yTuJAB4uGP5IYLHV/5QgfltQ+5G/e6EoLeugk7Lu5ewZDs9K9qPFjujcnTYfGqpsbopDMFhMzO0WLSUiTE7v/qaJ2zG0va804eJJsW85CwV7NnPHWA56QUHlZQSj/3JSPemx5NDcC4uzIAP3zxRUGgRfARpQw81M0dEvtqBifrwG/bQU78qr2LByLtpodJtOPYhFUYsJAQswot5QU7GkfZVgXPnjRVG31JPpKg//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WB5XHOeLHYILbS+1jJ2lFf6RpVNOGKYEfkzJdB8qgg=;
 b=V2WS91UKghFa7MKqYlvJdLjWRab7mtEPCPm4TqN5ttKD89s/65rLpHF+wBgQecWp1IH13pM8XdEiAjIX+Iw81JrhKv2SYZhgHYYR+gVL54dzzoFoJjqH0m3hL2jGGolj3bIQ+ylqVNZI772P9KghTB/H6/2lynZEokSnVcOK3xWH8IRes8wsWpzhFuvYXBKyAGlrnemVoWOrr+FkQPOOIuvFqw7Qydx85zi0QZQdGdROK5TfZj0iuwRLMiwEIte30vw0ls8RZXh1XxWTZAJbzzgi4JBR/MxUx4CrMz/uwrycyqwpbW/lb3L2YUgFJLFL6IjFjCEMV4kYlnj/OwSFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WB5XHOeLHYILbS+1jJ2lFf6RpVNOGKYEfkzJdB8qgg=;
 b=WqDFNydhO8Bql2WD37F76chfgkxVt/zjkbJrs7+Kv+4XYmF/eQMNh3Bgx7lIgmi+yuMdXQFjdr+zoCYtCJsmncQ+Tbm8MvS2jWNIYokmvFEhkjy08lkNHTgSeVlAXNmgLPvweTBRxUednYOA1OD2dg+j7o1MXdjqUw03uq6d6cTB4gKwtXh+dLCHs7OENCHMwgrjNXXCalUNpeJCOyveCmRY6oWFWOUIhFNmAQXEakyjWzbAOTUvwy9WLyYfJ146KVsg64hd6oqll3V/ewH43dK1M4ku/Nbdtq6LP7p9O0K2PUIRgbpzfAVK5EAoyTSGzJdelPXwhobau9MseHgyYA==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by DS4PR06MB10905.namprd06.prod.outlook.com (2603:10b6:8:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 18:14:15 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9073.032; Fri, 12 Sep 2025
 18:14:15 +0000
Message-ID:
 <MN2PR06MB5598DFC94FB13E9F809F0EB3DC08A@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Fri, 12 Sep 2025 14:13:52 -0400
User-Agent: Mozilla Thunderbird
From: Daniel <dany97@live.ca>
Subject: [PATCH v2] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store
To: matan@svgalib.org
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <86bd3541-3ff9-4203-a7c5-f505cf948159@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|DS4PR06MB10905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1577f643-f16a-4344-7fd6-08ddf2282ac4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|5062599005|15080799012|8060799015|23021999003|41001999006|461199028|8022599003|6090799003|5072599009|440099028|3412199025|12091999003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QllqY1drUjFBTXFTYXVSQ0hOWnZDM1dCZkJNNThLdVJQckRNT21JWUJOTHVF?=
 =?utf-8?B?cFpTRlh6UDI1OHQ1SWwvaXphaFN5VDkyNEpnSEwwRDVVTjdVemVWL0JPRWNu?=
 =?utf-8?B?THZjYXhlUmRWbWM0alpZQ2I3UXdsMTNKSmxHZURzRXZwNkVndlZGZ1JQTkE0?=
 =?utf-8?B?MDZlYTlEWGtHQm0vZGJyWnZrdGN0MGUvRXpyUnRQY1ozVEJOS0FDdDhpSHJl?=
 =?utf-8?B?MEdGQml1cy8vUHZhbVZ2M1dHUXI3bUJGRnBCYXRTMWFZQ1RDRXFZR1djU0Ux?=
 =?utf-8?B?RTNHNWI4aGhmWWxvVWxJcno0c0h6dkRWTm9pRlZBaElDMGJqSEZsN3BoaE5M?=
 =?utf-8?B?SGp1QTh1SjdlZEVhS1ViYWFPRmRNWEtvZU9LQUxoRktsK3JLWlhoN3hFcU5Z?=
 =?utf-8?B?eTlpUkNkUmRIemlKN0tCVkp6MjErN3NkK2pQMXhTeE1kdDNOY2dyT1pKc3VN?=
 =?utf-8?B?Z0I2RzkxaFNZV3lQWHRUWFhJODZoYnkzczd3bWRoQzRLaUlidlovaXVLL2Uy?=
 =?utf-8?B?YU1QVWluTDZ5ZG5aZjBjc2xJdVRKdEpDRWR5MXJjMitZRXNBeEd5QkFsQXpL?=
 =?utf-8?B?eDdoZ2phN0xzTlYxaU0zUGJRM2EyeHo2MzNLeDVYTXFWVGhFUHo1VlZncjRU?=
 =?utf-8?B?Y01GS21PRW9yZWhqcE5keG1YNEZVMFIzUDZWemdlMmExVlNIZ08rVzRqQWhr?=
 =?utf-8?B?OTVnVDFYWWFzZ0JxclNhaFpES0U2aFM4NEVhM1lFZmp3YWh1SkFjQjN5amIx?=
 =?utf-8?B?RGVWcnk2dENsUHhZcTJrZ0VOUVM5cHZ4S2lmbG1qNjYvQXF1QUhLWXVRTG1K?=
 =?utf-8?B?M2VHbjJzeFB3UEF6Z2xuZ2d5QjdwVDM1NnF4TkxGSTRqS1kwV3Q3c0JRM2dl?=
 =?utf-8?B?c1RVZFhkS3JaUkpZWUhSNkpmS21SZDZjd3Q3NHVNOElOOVRJTzdzNXNZMkpU?=
 =?utf-8?B?eGd3eFRldmlaTzc2aUJndGVzNlN2ZFlaallRV1crNDN1K1dBYVBVVS9OdVNB?=
 =?utf-8?B?c00zSVFaZGpoRHhocHZQMXA5cUFIYkp1LzljOUNQbEpJZEdpcUFiNHlXSndP?=
 =?utf-8?B?NGpqVWVGM3UxNkg5QjNkODJDNXZDMEdXYWhZOUhIODZkeC9WOEg3ZjJDMzFh?=
 =?utf-8?B?OW5IYldybmRIQ2tCRUMyOWgwaGpDYWtGY2o2RjBZTE1Tcjd3M2Y0UDVveCtX?=
 =?utf-8?B?UzhhRFBvc2RZN1psZG1SNHFpTUpzQ1VGSWV6Mkk3NVBHc2NYLzBKMC92UGVF?=
 =?utf-8?B?Mys1Z252VmEyMmE0dkU5TXJQNVR6Y1hBWW1tQkhNdjBRRmpPcnRLbDR2QVlT?=
 =?utf-8?B?Unpna3ZPcHZaYW1FMHpCNy9QL1dzMkpmTVVqV25mRDVjMzBYdGI3ZTFycmNW?=
 =?utf-8?B?ZEdNbEN3NjdyZUxCd3p5WXBlOWJ5M2hFQkVZV1lxN0t5NWVIdmVHbnVIMjZz?=
 =?utf-8?B?NkRvR1ExTDRyYUhLSkhQaUlEcG9yMmZESUhSVGthV3hVQ3pIMVFIVWRGc3FS?=
 =?utf-8?B?OFp6ayt3c3paYWprRW96aEMxZVVJaFlwaHFlNFdNVTlaVVI2MGNibmlOM1lO?=
 =?utf-8?B?TEkvUVhHRGJ2Uk5xL0l0OTgvcXh6QlVKajl6TEhrYlhncW5xU1FMa0Y1UTU3?=
 =?utf-8?B?QXhkeW1JdE9Id0tMMWE3TTVxRlhFdUxFL3hxdHFnSEF2R2RGdUxmc2NMeGRn?=
 =?utf-8?B?bFQ3Z3YyS3dNYlNRRnFiWjR1cWNEU1FzT3JxMkVldEpkWVFtVGtTakczc05h?=
 =?utf-8?Q?wE5JfNYBg++SVHz67M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTRXcEc1K0F0a2gzbFBwNzgzVlZCd3RPRVBaUXpjeGJ1dHlySHdaZnlOMWQ3?=
 =?utf-8?B?bUIxTy9yUzRHQkRhclM3TlA4VGhOckNUQS94S01wallXNTRPbE5CeU1lOHl4?=
 =?utf-8?B?VEVaaVNqUXJsaFUrc0JTdDF3K2xDOHFyQ1FwaEFZWE5BdnFMKzFnZVhPRnYr?=
 =?utf-8?B?dkNuVSs5TUhlUDBza3FleG9HY0pzUHlrU0xxbVM3bGZDQ1VpcmR1M2RISjdr?=
 =?utf-8?B?VW5CZnUvazh4VDBFejNoWWx5VlkrQnFjdUJHdEtqTndhVTZaby9JUFdwWFNo?=
 =?utf-8?B?ays4cCs5VThFYXhkazVuSmF6VmdRWFk4dG1MUW9melN6MVRNRERXWVcwY0NZ?=
 =?utf-8?B?WGpjdElmS1I2ZGY0Q3ZFQVRtZUtZT0gxWGJpR0VBRHM4OFlzc0lEWmZCSjFi?=
 =?utf-8?B?UWtMRjNrTE5uVkxXUitsTnZFSmU1S0plcXpMRGF6Y0cvdUlqT2hNbmgwYXkr?=
 =?utf-8?B?c2dCQTN5dHNuWGl5RHlXRWlTUkl1R3lNMWlsU3hlb1UyQ05wUlYvdGdkMjdl?=
 =?utf-8?B?SHp5QkJBZmxNZVc4ZXVxRXUvbVFCTnRqWTdnUWVhNnB3VFVHTW1KOGMwdDZN?=
 =?utf-8?B?V2dMQ08zOFU3Q25vZEx4OC9JZzdxd0o0YlI4eXkzVjJBOGJTUCtyTkJNQ0dY?=
 =?utf-8?B?cUNRa0VPWlNMdFZCaHBvVXdVN0ZuSWg5T3hYQWVYOVVjNnp0ZUF2YldGalk2?=
 =?utf-8?B?QnRoYWpqZXVKT1Jac1d3VnNxTXpCU0xmR2NHczRTTkVsbENCcWp2Q0JiRUVT?=
 =?utf-8?B?Y0tsc2o2S3h0QVFLM0c4bG5iWXlXR1ZTV0QxRjVIL2tlVmRyMHZDbmZidUVj?=
 =?utf-8?B?VUpzaUpqcnVEUWJReTBQdWpMQ2ZqOTYzQ3hDczlhak43Q29LcXBYdDIyTkRu?=
 =?utf-8?B?M0R1SWJEMmIrd0FyR3ZaNGdnVnNLVVZpNTB3Z0JnK01RYkoxZFhXK3pZamhV?=
 =?utf-8?B?YWRxazNPV3g5dXhwRUZzTC8rUjFQWlcrL0JLN0orWUY3cU5XUDM3WmdySVZa?=
 =?utf-8?B?ZmV3aDB1UXRmUTJJbmhvTW9QUURpaTZvaWlMS1VrYW1wTS9lQ3ZLVWcwREhJ?=
 =?utf-8?B?NGdLZzNnanRQSUNjOTZiRWFrajBlRzA2Si9EY1E4MEQzdjc5TTZJT1YyNWRD?=
 =?utf-8?B?c1dCQTY5UDJBaFVWMUVuLy9KTDQ5UmYyYkc0YU84bmpFZElwbGVSVXJOSElx?=
 =?utf-8?B?cEdxN2dKbkQyTHdLT0tWU3VGSmNET2NaeHk2b2JxTTJRZ1dUb1lscitCdHhZ?=
 =?utf-8?B?VEd1ZnhuZ2FuNkpCRmNyNFhlQm5Wa3B6VjZVMkVKMkhCVTBsVnhIZ3NRMEZH?=
 =?utf-8?B?WnVMRjFLbkNxRW1KV204WmRZRnArRCt1SjdxOHM0ZytORzVyejFEMWFFMGlZ?=
 =?utf-8?B?U0hBcFEwcitqc2ZDSHhwY0IvekgzS3ZrR2psaE4rdml6anY0QjFOMlduVTFa?=
 =?utf-8?B?Ynppc09hRG1IOU40RFp6K3NrWHdHdGtaeXIvRkc5czdBQlpCMjhsRWNkMkJM?=
 =?utf-8?B?S1RYcEhmSlJpZkRwd0lHVlArYlp0QnQxc0ExK2d5V0lNcXRjb1M0SlJxT1pB?=
 =?utf-8?B?NVlmMS9rOVYzamE3NEpMNlRmYUsvdmNiZGtwaVEvaVJ6YnExUStKWU5XeWg1?=
 =?utf-8?B?MGNPYUU1YzIrY0UvMFZ4OW9CT1kyeVE9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1577f643-f16a-4344-7fd6-08ddf2282ac4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 18:14:15.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR06MB10905

On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
/sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
report a status of 0.

Disassembling the relevant ACPI tables reveals that in the WMAB call to
set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
(depending on the value of some other EC register).  Thus when we call
WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
call undoes the effect of the first call.

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

I can confirm with this patch reading/writing the fan mode now works
as expected on my laptop, although I have not tested it on any other
LG laptop.

Also, correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel <dany97@live.ca>
Tested-by: Daniel <dany97@live.ca>
Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
---
 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 29 +++++++------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932c..c4dd534f9 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7..335afdc75 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -75,6 +75,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_FIELD_LOWER GENMASK(1, 0)
+#define FAN_MODE_FIELD_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +277,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_FIELD_LOWER, value) |
+		FIELD_PREP(FAN_MODE_FIELD_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -317,7 +310,7 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	status = FIELD_GET(FAN_MODE_FIELD_LOWER, r->integer.value);
 	kfree(r);
 
 	return sysfs_emit(buffer, "%d\n", status);
-- 
2.51.0

