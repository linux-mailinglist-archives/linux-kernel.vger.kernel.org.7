Return-Path: <linux-kernel+bounces-848937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42727BCEDB0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ED4425212
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF376A8D2;
	Sat, 11 Oct 2025 01:18:42 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020077.outbound.protection.outlook.com [52.101.196.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2934BA57
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145521; cv=fail; b=qtgNhMoU4Penne8iQL0md8j5x48VYe4nc8sduNYrx5UmqFohz2Tk91xTwb4Eg5boi61OqKEBOJWGMS72JEMRXgS1x+cCEOFDc2pWdfq+ZEKz3Lx9QVyo5uMXA4nWU+VvFqKawFk3H4c98rIqo2+ZqRF0GjEX07pdFbWa/a2KYTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145521; c=relaxed/simple;
	bh=h706qtzupE+HQp/UJL+tzQR//QdaBytsTgjmaar158k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mn5EuW6G/Wwg1JLFSOJ/xEQ19CVQXHSSm/if738I6AaZ/B7iMiI5MPT2Jn1Daz5X53ZUDr1SEtTcY1wCKWZoxF3BZNrMX1sp/3qUMHvR7RZ+dLwjtFjjrT9DiP0vESqZp5vPd2qcLGueLSbR02aBq8bZWifxIfaNz0YomNEKKpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niCBJhf5WuX9Yn8R7FehvAqcAE6S7vWiqgGZQJGFidOTRDDqPGcdQNSR+Tedpy7bNZOFsuaqjHb3pqqJJ+vYYt2F+uMU5W6dMBJx4QjXcrdN1owzYXcj+j4r7HqH5qSInFQfVX1x/2bXGiTw1KOVYGDovsDZzs3iWytj5p8SABOOVLbybcmfiPWSQd0pe9eyW+VGt1MPw7zyHjbuppvtSeLSxyLtiWGQIcNttSzY3a3vkYw771ZZBWZh7oIO4k1kSihpXDiM//oyWePGS0SAgLYJ4mWnrTLZivitE4n3fiv+CEUDZjh2pm1UqGa7cW2L7Ve1Pf1P68hlFLKEJBsiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLzEchugWDx3koHFmGrl4hdX3TvDVAKwK0QJ7Ds3cjE=;
 b=ph61/iDjQ2AsAxNJXIrZVlGvV/TPHZbzhUEvYlXD/d5FfAz1HLtFk0Gh5UsFLXGiQEhwOgFBECZJ62jDm9KwlHrkWMKtK/LE3j92lin72Irx62axdseH5daLs2RS5Ti2tWnM122YoUQ4L9UCA0clCosVxejp8yzeCkTKEDLETKSXnxldBAIx0bsWnCAYhQGwF2/9SqjRfYf1rNj92Z/HSOdXmqX5uzZHmyJ/y45xPWAUHMvUqJZIcbUiCIkUj0t1YZjHvQAcR3Rs5gLIqIBPx7lRJrAl94TUAdRwJlcc8TGS43rzi0oDN9wAX5U1vvO6c4xFHc9nhJ9/Lg/euN3jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7766.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:18:36 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 01:18:36 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	nathan@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tick/nohz: avoid showing '(null)' if nohz_full= not set
Date: Fri, 10 Oct 2025 21:18:28 -0400
Message-ID: <20251011011830.6670-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c91452-7f69-45fa-47ff-08de08641929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFV4T1dpTllnVFVmUWJMT0NhckF3cW4zdUFOSkw5WFNOdnNOeUtUd0RVd3p1?=
 =?utf-8?B?ZlNwd3dQN1dXRUIyZ2w4VklPcExxZkFldFNuaVNsMXVxOTRLTkd6bXNZR3Fq?=
 =?utf-8?B?YnRtSnozeDU3VytIUFdESEJ5aEY1VFIyZVEvU09HRGlsbzFTWXVWNTdZWGtF?=
 =?utf-8?B?bGo4MVhDZmlkK3J4TUlud1huM0NnTTk1Y3VQRjBQNHFoMXRzVmZTbFArcmUw?=
 =?utf-8?B?NmZ4emJFUWJXNnB5MENYSDRRRjJjVXBZRWlmdXBTMGlDb05MSFdXVi9wWUJG?=
 =?utf-8?B?MnNjeXByNTB4Wlk4UkJrT1JWUmFMUitLcUd0d1ZHc2wxMDl1VWJ5WWl4VnJE?=
 =?utf-8?B?VnlJaG9kMVhNdmlFQllxalROR1pWTUpvYThUd2tLc3RySGZCOFVxWUhWak9B?=
 =?utf-8?B?YmNCamJZaXNrMytIdHRZTmR6YXdqdXhRUktPSzhzUXQ2V2pJNUdrYWJEeUJy?=
 =?utf-8?B?N2hpWnZjemZjcEErMUhMdmpueWd6eHdndlc5QWdMSkRsWURDRUVudUVSaFBq?=
 =?utf-8?B?aTQ4V2pvSW5lMXpzakZMZjhGaUM3VmFJRng4NGtEajNQUG4wM3pmbTUyai9y?=
 =?utf-8?B?eWhEOU9rekZVazFFY3Z1M2xJcENjRHNqaXdvNXhGOXgvYnBwa2dINDlJV2g0?=
 =?utf-8?B?RVVWQ2hvV2llQVZxc0JrcEJBZGg1RUNyQ01tajJEUHQvU0JLOFVkSmtoQkdW?=
 =?utf-8?B?eXRJT2JEKytkd1Q0cmRYNms3WFZMTUlrVGtqZGVnZHhteVBxbGltTSt2VDha?=
 =?utf-8?B?S2RwNXB4b3VCZytjVEQ2Y1hlSDZyYno0a0x0S3hFSUJTYkROSS9rNXRIQkFw?=
 =?utf-8?B?dE9HS3VGSlVkcWZ1TU80Vk1SZ0xEU0VMcmNYZGE2VzN4TTZxQk84Znp1bG9r?=
 =?utf-8?B?cmdGc1FVdW1sSXZGenNCcDVZOWgwY2ozSGJ3VlZoUTBsZi9sRnkvbzNlcDRY?=
 =?utf-8?B?R2ZtVXdjSENadjNFRHJ1OWlCeHIyaHcwWmVjV3ZNT0x4aWxaYU9IRVRLYXpO?=
 =?utf-8?B?aGMva29wN20zbXFHaVF3WUpZNU9ESmhMQm1oQUl1RjhjcTVJM0NoRHBHNU1v?=
 =?utf-8?B?QXNRVDlCa0pyOCtxYkd2b25WSnQ1YnlNQ3VVMXlaUi9LMlZxQmhiN2p0NDBO?=
 =?utf-8?B?MkhyQm8yallvT1lCWmw5cDVmUWM3U05zQ2dybkpkdzBvMHJhemhBdEQ2QjBw?=
 =?utf-8?B?Ykxpd3RUQUJPVXF4aXdHdE5TWXg0SkxWSXRENENsS21NUXJGa2FVWVVUVm9s?=
 =?utf-8?B?R1lTdUQvMzlMZnIwcXM1aGduV2hGbi9mLzlxcDVuWEQ0YklRVHVpZ0ZUSlc2?=
 =?utf-8?B?NFNGdGgxSkcyRTNhZysyN1B1eHFSd1RaUjZ2b0dUcTJ0S3VSME5tVFgzcGV3?=
 =?utf-8?B?akpCcFMvTXNrOThScEZjNDBRRnFvS3JMVFUxRDgyUHdKOHArdkg0WThTZzdX?=
 =?utf-8?B?V0oyVTV3ZWNnT3BDY2x0Rnh3VTB6RGNvUzBFbnR2SVBZRnZTSTlNZnRQK20w?=
 =?utf-8?B?aXB2MVNTNXVHMHZKb0llVTgyUmo5WEVBd0NqbnBTYngxcWwxb0NIRDBvaDFU?=
 =?utf-8?B?QmdFZjEyeDdKVFRnN1dxMldJaUhwNFgwaVI1Q2pSS3cxODBNYjhGRFJXQ0pJ?=
 =?utf-8?B?Um1xNWl6Q3o0aUozamV5UzU1Y0FWYmtNaGc3ZjVPYzNVMnR6MUpPVU9PL3Ni?=
 =?utf-8?B?RzNNWmhDTFFxaENKaFhLT0VhQTFTM3JvVml2MExvWTdFdnNiVHV6T2hSRjlD?=
 =?utf-8?B?d005UThYQ1dBZjA0cUxXSkVhU1R4RVlxMjFsVnlGckY0YVJPZmQzUWFGaDlG?=
 =?utf-8?B?dWo4eU01LzdHV2FZelUrZ3ArOS9MQVR6QjBGMTdEU0pjSmlSdDBhL0JxWUF0?=
 =?utf-8?B?NkxyZ01qWUZjS3VVMzh6T3Vqb0tiRFp1TWV0M1c5TkVvZEo0dXd5eTMxb1Nt?=
 =?utf-8?Q?G77p+TSyQVYhJ6jrZEsmFCA0v5PI93wC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHMyakFXWGFNR3MvTlNIMGJyak4xV3JJb25HR01VUU12aWUwdk9qNVF6YVhJ?=
 =?utf-8?B?SnJWWjBoYVY4cVE1NWZEZ2diYWRXaGl6aVNzU1VtTW5vNXNMdlA2UDNuM0R4?=
 =?utf-8?B?aWV1cTVWNWk5SGJSSGJTVFdacXZ6UHJUY0F4OHlZK0ZNc0JjNGhMSGVPZjNr?=
 =?utf-8?B?VHdDVEZsb1RZMTNmNDdScEJaM1ZRY3hVazEyWU9iOWM4blJ6U0ZBT3dId1lo?=
 =?utf-8?B?Zkp2bllUS1ZMREZvWUVNRjlGbHo0WXVaWDJTUnJ0NU9vSzVWa3RYc094S014?=
 =?utf-8?B?cEhpaUhySklvNkltdURhaXNqenRzSDZHY3EvLzdmU25LKzRHU08xSGdIazF5?=
 =?utf-8?B?WmM0ZkRIdUhWQ3REbjZSY3pzVXdKekxROVJrNWVERUFybkxzSFNhVU03YkZ0?=
 =?utf-8?B?YnpMZ25VWHdhN3BqcXhsZ1pqOVdaakZiRS9RR3o3ODhySkNWbFQ3NHlsU3JX?=
 =?utf-8?B?M1hTVi9UVForOFRXcEdydHJsYXdOZXBoQkhZc1JBZkN4UFJBUTZwWk5pdEF6?=
 =?utf-8?B?cTJCY1ZkQVNlY2dXZWFPaUZoN2hiZ2Z6SEltU29uN3RjS3AzdXE4VytCMnFp?=
 =?utf-8?B?ZytqVm9RN3VrdnpIblBFVS9pbjEvNkxmK2tuQU12UmszRTRUdGJLSXhTTzdX?=
 =?utf-8?B?Y2QrSVNkL0xidUZ4M0t5bE8wZncrT2MzWkkyQXFqNTlBRVlORmo4Ly8xRTRL?=
 =?utf-8?B?RmltcUpYaisvMFNMZXFvTldab2Z6a0NleUozU2pJQkxydy9Xa2Z5TjcyU0NG?=
 =?utf-8?B?ZzVuV2l2WmNpUHRlUXpBUXhMWmNRT1lQdGNwMlByQ1J2L0JVWjZjZlZMbHZh?=
 =?utf-8?B?dWZTYm9YOG1ueWx4RUo1ZkpQMUZlcHBwVU40SjY5aDB5Q254L1VvWmxHdGN2?=
 =?utf-8?B?RkZ2YTBiVzdDSC9jdTBFSGpSRXhXZFJpa08zQ080RzlEbzVmM1FuVEhtQ1dn?=
 =?utf-8?B?M1dhV2gzTHByaFVLTThZc1o0aFA5TkxYbVl6N3pDUS9LWkI2bDFCSStHYlp1?=
 =?utf-8?B?WVhVS3REcUh3aVk1VEJlblZGaE1GZHlHVW1OQkg2UXlheEllNVVEbzN5bFRW?=
 =?utf-8?B?dFFsNzliZjNXWVFiNHRXdnlBR1ByRnYzMVRJUm5kRTVLWVpDVndKYU91VWdF?=
 =?utf-8?B?SGZtNTN6aHJIODU2M0hDVS8yRzBnM0QyT0tVNnliWGwvci9LQ2hWbUJyK0My?=
 =?utf-8?B?WHFoZnlwdCswdDBETjB3NWNlNW1TVFJFM1o1TWp4cTJFeG5Xdkp2TjdRYTN1?=
 =?utf-8?B?QzJrV09DWWJkYVE4MC9LWFFlS0l5dUdwSnlNRlRvcW02VjFUZjl4T1kwbE9N?=
 =?utf-8?B?UnBxRXBMSzNMZHBTM0o1TlNJbnNlenpqdHo3THZGZmh2aXU1NTZZRjU3dWRN?=
 =?utf-8?B?WGUydUNqc0l3MCtrdlJpK0R3TGZlMFl1NmhUeTlsY0JRODZzUlRWVGFqQTdB?=
 =?utf-8?B?ZklrZzdCR0VTWTF2Vmg2TmZYUmJHcXVDeW9KdlNyVi9lZ3NtYSt0TU5udkFI?=
 =?utf-8?B?Nkh5SUZGc0RPTVNCVEk4c1dPU3dubmFQaVBSTHJNcFVGamF5bUlFWDdnNmhE?=
 =?utf-8?B?MElXRG92N1oxZlFWVXBjVGtnRE1FYmdHOFA1WHJqaEM3ZThOUCtaR1FSSzVS?=
 =?utf-8?B?KzNjdkRFNDlXNHJOTkJLTTBqZjN1MEsxZVI5b2xkSmVUYmVLamlTZDlEeGc3?=
 =?utf-8?B?UExxRzg0UTUxdzV6WU1wOUEzMzNiV2tIMS9zeWQ2SGUzTEZYMTlaWDcxbU5B?=
 =?utf-8?B?VEpkYnNCTkdtbTdHUXk4Z01SZ1JQeUoyTzJoZjRCVkt1ZWJZZlNIb0w0cVl6?=
 =?utf-8?B?MlFqL3k4VjFxVjlhOFcwUG1GbmxZb09nZUc0bHp4bEFLTllHdTdXK1lYZ1pJ?=
 =?utf-8?B?OWtyWDVkRlFHSjRULzlURC9UQ1hpdEtsdmQrQXlrcjFzSHpyWk9kYXZIMjJZ?=
 =?utf-8?B?U0VDdVViaUNMbzVBTTFWMnZGZ0R4OFhoaDg0QmpzMitzc0hweWdzU3daejc2?=
 =?utf-8?B?SG9mWkplRURGZU5XWkp4eE4xZDhyWk90QUZPVE1GeVZERVR5VnZ0NEJSdlU1?=
 =?utf-8?B?bFNyMitjeXlmT0owUk1VSG11VFloNnBlMHhUSXMyRHpHLzB1UnlRR3N4bDNl?=
 =?utf-8?Q?bj0NVB8Sdud35G4H+/hSvgOoG?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c91452-7f69-45fa-47ff-08de08641929
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:18:35.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw6TFJMsnCUsqRiLspieB4a1chSFjBExYR//Rsc9inmOgE/QRD1JSKwGLoN5wpbzg1l+dcduMzUKaUSvVkVkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7766

Hi Nathan, Greg,

Thank you for your feedback so far.


Changes since v2 [1]

 - Removed unnecessary else statement (Nathan Chancellor)
 - Used cpumask_available() instead (Nathan Chancellor)
 - Used DEVICE_ATTR_RO for nohz_full attribute

Changes since v1 [2]

 - Refactor to use an if statement (Greg KH)

[1]: https://lore.kernel.org/lkml/20251007012504.16118-2-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20251007012504.16118-1-atomlin@atomlin.com/

Aaron Tomlin (2):
  sysfs/cpu: Use DEVICE_ATTR_RO for nohz_full attribute
  tick/nohz: avoid showing '(null)' if nohz_full= not set

 drivers/base/cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.49.0


