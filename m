Return-Path: <linux-kernel+bounces-831072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917DAB9B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF84164007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24331A555;
	Wed, 24 Sep 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="A54DVHpV"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012009.outbound.protection.outlook.com [52.103.23.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C034D599;
	Wed, 24 Sep 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737857; cv=fail; b=gSxttfbCkZl521PKYrCzIOzyL4Jw+zgU20XSFxgupzUmrK9CIXvrAmUznYaWtbuQEH2NMV+i7iw9rLTJli5mjcMT1TkazurzCWs7yN3BJ6/v7N73Y9BgZYJTZE1zwD0PTl1CoTFh1YrZtNX+XXywdo0FbGMPKtmxx+HygoJKbz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737857; c=relaxed/simple;
	bh=eK3KCR/He4bpml8z8KKVilWo55FMHfQjFzqkqKEo+98=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=G5ueElLrz2LPg+tkl0aUVak06CDg2pTCt4rGWFysM+yMei2G3ShDl/+zTfTdAXcKiYgOxvuSFIjKe4afgaf1I8Io6BtLLJCHcxhk4cfVYzGAszA7iF+3y3nAggvnGdxqUHgGThFmF/Ymkgg84cpg/DZOMIVBsUCxl+LIv+lgV4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=A54DVHpV; arc=fail smtp.client-ip=52.103.23.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3xxynbh94+w3HgWv3gKUUYXDj1UVT77eYklb4svyk+4tyqiNcsIH3RxtTCtzB32IkAu4cA5YukvelKZtaV+Rwq69CnNxQh6DN8qON2jKN0Ff1Wo7eBxpkUe8D8b/5eb8qdwkkjQJNRBYhjFIjR+yV5otNHWLYFT/Y0j1CmJ4S2quAXVDFuC9Fl7FvBUQGy/tyXzen9gV1DzocCQxIpAyRRaA7McK6C6FQlVvVbWxKfjIrNjO0sxf7guVaEyT+NRmFyNNtVujxsXn55b7mx2WHgJZwE2bkS6YLmhevlhSI+LG/JQNP2y4kUv6PShlXTV/qCiMPi+Nid5WkbDB0zCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBc8104s3GbCtHub8taQptOelnFAmA35IoLt3WFfMfg=;
 b=tcdwRHd0Yh/Z6ZdfTse7wkLhV601XtBXmHIEjqRKtGhooCbFlHsJoEGl4eUXssaTuKFdPvUkha/4bsFQzd/Chi9UfVxvNRCio7mDsIAlUYkfGL9N15bHqvZGhU/Jgwc+7j7hasFNaVbYlV31KrQSUnKOrGxoHmSG+zIFrPomTcOXWEOLz8Fagptt9hEuAC7vMTnqEdpjR1F0lhoMZWIX1xWzSux1Xak3rsQJISPcUPEe/uoim66xoSPYa7Sv2NCIXM2eepPTAPVT9qN8dk46bYUMu5bcvfkTbXkLiMvgajL4KAJUnDN85DFqwmIRHgv84AzZlhzvDsO8fm5+MwiCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBc8104s3GbCtHub8taQptOelnFAmA35IoLt3WFfMfg=;
 b=A54DVHpVMJFD9d3dsSNm+mjuZdTYEeW0O+GeZ+YikZ/gQtVjU4yPKxva5xXrGOfwQAnKHantPkWDWYWr+jgd97uSxzYv3eIz84PWHpdESL7iOPNzeYvnw5rxuIISODYkNGbakwiDIacFgaTuWWz/Sg1ajou0z7R4VL0FjDTNY8GXBdx0GlsQcJ85h5d++vwHqtAR4o5s4IauBBaxGmL+hbby9vApIFiVYnlw69RzPEM1dtPgpk4cQYwg140qla4QrZPZw4xPQcUr7o+cnWU4GW5pS+iVRpSgra89KjJj7pqifYGgm96WvtkLd3MwSbeQ+xM6shLi0ROwV24uoMZkOw==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by PH0PR06MB7141.namprd06.prod.outlook.com (2603:10b6:510:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 18:17:30 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 18:17:30 +0000
Message-ID:
 <MN2PR06MB55989CB10E91C8DA00EE868DDC1CA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Wed, 24 Sep 2025 14:17:17 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Matan Ziv-Av <matan@svgalib.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Daniel <dany97@live.ca>
Subject: [PATCH v7] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <bf08a7dd-1f36-4af2-a1fd-74edef8759bf@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|PH0PR06MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0ca0e5-6431-41a4-bddd-08ddfb969f76
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|41001999006|15080799012|461199028|8060799015|19110799012|5062599005|6090799003|1602099012|4302099013|440099028|40105399003|3412199025|10035399007|3430499032|12091999003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUt2ajFaZWNiaXczUDRkWmdvSEF4blgrZnUrV3lra21tdm5SSDVSYVpXTUFp?=
 =?utf-8?B?dnBYdFR1OXY0eGpUbW5yS3VlSWVoNmFqWjliY0FQcEZENmZOeFNwdnBQSVpC?=
 =?utf-8?B?VkpVNU8xK1A4RlMyaWxwMC9aWVpDUFF6UkFEYUx4OTMyUC9CN2hQdjNzUE1F?=
 =?utf-8?B?Z1NUb0l0VTVWSzAyWFlUNEVQYnRpV2dXSkQvdFI1UFNzYjZsa2s3U2JPMjFU?=
 =?utf-8?B?YjdwQXBJR0o3QmNnbFBxRGZsSU1tazJqOGgzcndWY0hsWjF6RUV3SkVlNHV5?=
 =?utf-8?B?Vmh5L0F0TVowWEFJdHFoYVNqa0NTazMvb1pGcTQreStleXc1VGdnaFdwejF4?=
 =?utf-8?B?dk80M0lUTUxkdVdQU2FNVldIUlRQcnlBK3hoTTBKSEd5V2U5eW9UYTdBVkIy?=
 =?utf-8?B?VlduVDU5RU40ZUEzR2pzbjhBMnZZVC9aY2ZVY3lTQ2RHQlhaK0JKRmw1TkNt?=
 =?utf-8?B?RE4zeXVibDVHa25QT1plaFZaOERnUUdSaE1CRlN6Q2JHaWFpMGlhZ09TUGxr?=
 =?utf-8?B?NCtvaTRyditIV3VYN2VYV21aN0gvWGJtckY1alBkRGZpM2FwbXJyWHhHbUts?=
 =?utf-8?B?LzVJSlNrYWtua24yL2Fad1NreUc2WElEOStXL253WlVPMnAwVVJzbTBuc0VB?=
 =?utf-8?B?aitMZFpFRXdxcUhZUklBZ0lPM1NZZVNtM2MwVVFITXhlaS9JZEQ3OWs5UXpU?=
 =?utf-8?B?dXowTWNEOFd5aFc0Y2txQThoSTFDRXRRY3Y1cnIwU1dWSDFBb2JRYXpCOC9K?=
 =?utf-8?B?NS9ORDNIaGM5bzNGdytXdFFoZlBVYjdHbTNVVkMzTWpHRnVndEYwemJoMXZ3?=
 =?utf-8?B?d1k1dnF5aVJvWTgxekkzVE1OSWhWSW44cFp2SXVCdG9IK1V6b3Nqb3ZSdWJ2?=
 =?utf-8?B?SG9obnd5ZjNpK3dpblFGbHFSTHEvSi9Ea0V6bnJnNmRRdWw3SzVTU3ZMbm5R?=
 =?utf-8?B?VW9Mc1lRNHZDaExxV1NVUXAxTy9tamNpRTdpWm1TWDI2Tm9DSlRpK3Yydy8z?=
 =?utf-8?B?aHl1UWFrT0dhanE3Q3JzNS9DaGJjbysvYkxrM3RQa3pZZnpoMjVENFd6cVpY?=
 =?utf-8?B?cDN0ZFUxSkpuN2lWTzIrck0rcGlpYlFKT0lFQ3pxTDVQR3Z1Yzh6bU8xME03?=
 =?utf-8?B?SDFMcVlOWjJVZHV0OXlsUXdJczJtc0ZJc3QycW1lMmZWbXZXUGJDdnJKc0FE?=
 =?utf-8?B?eHNUMmJWWkVQV241Q2xaWWI5Y25rbkR5MEZsbjltQUFhT2ZSQmd4bFQxVkV1?=
 =?utf-8?B?a2c5ajFncHhYWGg1clNJZ2lJaTRzVWo5cmdYeVc1ejRqeWFYNWduUUcvRGo2?=
 =?utf-8?B?MWs3WVlNcXJKVWVxSXRieWkrZnM1TDZQL3dHYkZ5RktSMklsV2dkeVBsdGlK?=
 =?utf-8?B?QzRnaWpOOURkK3Q4cndLUmVYbUtTYkUxd3RjK0tEWndpTTIzOXNsVzdSeU15?=
 =?utf-8?B?dFlmeTVRck9hV29nOCtWbFlYN0h0a1NhcDZSa1d1L2t4ajdYYjJlK1RSaW5t?=
 =?utf-8?B?QWZHWk9TQ0ZBVGFJNE84SDJLM2NRL2ZNWWoyVkpCUW1LU1owbENZYTJvWUlo?=
 =?utf-8?B?QmNDc3ppUVA0a2lya0N0aThKL3Q4bnRvZjNQTFRhS1RiUGlkd1JBcmFUc2h2?=
 =?utf-8?B?RFhkRHNYWTh4SG1VeHJubmxUWG9nNDJhYkJsM0ZMK1V2ejZoTWVsMU9zcFpu?=
 =?utf-8?B?TFlQelliUmRMZzlqeVdYZ2FTVXJTRnl4SUlRNnhYTE05d3Zjcjd4YVlPZFoz?=
 =?utf-8?B?ekxLdHhYaW96MkhSMC9RUkRYYTM1QlBSZmp4cmtNSnVkNkdia0VtRkZNUDB1?=
 =?utf-8?B?R29FOG9JTFd5R0tXdXcrSDBEblU4NC94ZnVwYml4VStCKyt3RXgvRE1PUXB6?=
 =?utf-8?B?a2FYbnorbDBnV1R1NmNZZHJvOHNJbFlqTmFBVzVrc0p1WERpU0JIdkRhUTd5?=
 =?utf-8?Q?TsoiKMoww2xMV/mOQ465KFI2pR5lHz1N?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUNNcXhtbmNCMmxHaWNwVUZMYUN3QkFjY0xnM1BtczdqblJEUHVqaURYUXhQ?=
 =?utf-8?B?SEJraVJMbmFuZ0UrV3hWOVVCaEk1UXBpWHR5WkU0OWt3cXlCN2FDK0d0M3ht?=
 =?utf-8?B?UnNHdjBtNlFFQUlKWDVJbTh2Ni9ndDZ3UER5SFQ1eHdKTUtYOVJBWU1Ldi82?=
 =?utf-8?B?MGlUSEg3VU45REN6WUl0K0lrSE1VdzhHNnhUNUI5MWllZE9CWWVVVS9Lbmlj?=
 =?utf-8?B?Szg3eFc1OWp3SW85Y0ErZGlKM01UNDdscnZiT2d1aVJGalZTdlNHVkZpNlBX?=
 =?utf-8?B?QU5xNFFEcmhBVTdhcjhUaDlicCtycjcvUmh2c1MwOVhxUCszZ3dOV2pBbGxJ?=
 =?utf-8?B?WUI2YmJPMXovY3kwV3k2V2t1OUFuTlMzUDMzNHpGSWFzZDlrK2Z3VktJd2kz?=
 =?utf-8?B?RGlTL20xV3dGZHg5N01FVzlLU005RHhNQnk4Qy9EN0pPWDJjUlRGSXNYa3gy?=
 =?utf-8?B?MWRhd1k1UlNJdXFEcVBxSFNnS242anVGUmtjbDMyYU1ieW51RWhuUDlub3Qy?=
 =?utf-8?B?c1BqSzNGMzVoUUlFL2dQdmgvZ0dYSG9pKzVxbW1OTDBBckhTSDBhc3gvUWJ5?=
 =?utf-8?B?NXhRVHVmUXAwZDBBWElEajhBUEpaVFdIdUdPaW9qeHd5Tmx6UUk4cE9UVnRI?=
 =?utf-8?B?WjB6MkRRM2paYU9ITFdxd2hORU4yVDNuN0hxdUpXR1QyQ1RKclo2K3Judmxh?=
 =?utf-8?B?TlNaQndVbXlqVnd0enpvOFNYeGlxQTFPNGJmOEVKRXNXN3pjQlhDZ0FUeUtt?=
 =?utf-8?B?VjRqVEcvcGp1UWpSbjQvaUVJbHNnRFMvWXcrQkFyLzZNZHN4Y2IrT2pjR1Nx?=
 =?utf-8?B?SXlHVWIzY2J1NEh3eUt0Sm9IYVNDT1FvZkNVOG5mT0FYVGNaSmpjN1RvYWpB?=
 =?utf-8?B?anJkdHhuRU5xUkYvMDlvVlR0TWdlc1ZZcDBIVTdNZStRZCt4SVBXRXB6WE5t?=
 =?utf-8?B?MlFWbkJrSTh4NWl6dFM4M21YekdnSjQ5cXZpKy9STTE3andHL1dqSEV1eldp?=
 =?utf-8?B?K0d6eG4yZ05GTEVlRHNaU0k4TTY4bDZrek01eUF5L0NwTFZCaEYzL3RjRDUv?=
 =?utf-8?B?YjAvZUV4TE9RdVN3Rzd6OUJvaHErWSs2VWtOdStUNldxZDRqaXVreVhsNmlJ?=
 =?utf-8?B?eXJmZzV3RVdLbkpiK3N5UXo5T0FHVnNWcXdyNjJXZmVQeWZYWWQ5eU5sMEZY?=
 =?utf-8?B?Sm5EcW5hWnBvdm5CbXBBWXUzUzF2MUlaa0N5OW56bkFjU1liRFJmQ2dsRDI4?=
 =?utf-8?B?citBWWhibUV3dDJlRE1kOVR0QWFwS0QwNlE5UmxRZllLM0FLUkRKQTBudERm?=
 =?utf-8?B?bTNiMGx6N1E1dU44cjllZjZsUzcvdmFzRlkrdEY2WldLanFXaFhwQ1ArajJk?=
 =?utf-8?B?NUpidmZ6dGVQU2JjWXB1azhEVTRkQXQ3RnNSRi8xdktTcWErUnVFR215b1Ix?=
 =?utf-8?B?TnRDczBpTXV3ek55UmZIL0g3UmwreFVCWTM2WUxPbFNXUGlnZ3RwVkhOZmk4?=
 =?utf-8?B?TnFycjFUTG5BU2VXME12eGV3Qm4raXdQeGt4QmxqRW5xaXhzRE5XYktOV0VG?=
 =?utf-8?B?d0R0UmtOWWZ6WEhLbHNxaGdMM0YrRmJXWDZwSy9DMVBpckRUME4rV1pFd3FS?=
 =?utf-8?B?WXdlS29SQkdCL3VQamlOQWJFdnB0U2c9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0ca0e5-6431-41a4-bddd-08ddfb969f76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:17:30.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7141

When WMAB is called to set the fan mode, the new mode is read from either
bits 0-1 or bits 4-5 (depending on the value of some other EC register).
Thus when WMAB is called with bits 4-5 zeroed and called again with
bits 0-1 zeroed, the second call undoes the effect of the first call.
This causes writes to /sys/devices/platform/lg-laptop/fan_mode to have
no effect (and causes reads to always report a status of zero).

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

Also correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel Lee <dany97@live.ca>
Tested-by: Daniel Lee <dany97@live.ca>
Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204913#c4
---
V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
V2 -> V3: Add parentheses next to function name in summary line
          Use full name in signoff
V3 -> V4: Add include for linux/bitfield.h
          Remove "FIELD" from bitmask macro names
V4 -> V5: Rename `status` to `mode` in fan_mode_show()
V5 -> V6: Reword commit message body
V6 -> V7: Add Link: to relevant bugzilla comment

 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 34 ++++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

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
index 4b57102c7..6af6cf477 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
@@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_LOWER GENMASK(1, 0)
+#define FAN_MODE_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
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
+		FIELD_PREP(FAN_MODE_LOWER, value) |
+		FIELD_PREP(FAN_MODE_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
 static ssize_t fan_mode_show(struct device *dev,
 			     struct device_attribute *attr, char *buffer)
 {
-	unsigned int status;
+	unsigned int mode;
 	union acpi_object *r;
 
 	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
@@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	mode = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
 	kfree(r);
 
-	return sysfs_emit(buffer, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", mode);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
-- 
2.51.0

