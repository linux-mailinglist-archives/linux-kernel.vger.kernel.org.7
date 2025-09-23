Return-Path: <linux-kernel+bounces-828991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4FAB95FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9804E3B650E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50141324B22;
	Tue, 23 Sep 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="pXPo+p6C"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012062.outbound.protection.outlook.com [52.103.2.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281132143C;
	Tue, 23 Sep 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633603; cv=fail; b=mG1JZzrHDw8V49a+QhGya83Fu0FiBRfQvEf0ut/yfzYA985PJOLGk2RVvqrMWAwkyNVV6oISzQU9MmWEIBNQTKelDAxszBZ6nH6hyvfINicbXKocxE/4PJKFddXpEEL2PHuimw2WDm8+nnR0l1ol3011l/FO+EuwT1NjlBA7UBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633603; c=relaxed/simple;
	bh=GaKKDSbocUOzPu4IEfcHf7dseoegqy9m2WkS4E+R8sE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hK6n8jozFy37qgUiCSDz2gkL/NJzE4tyoLP1hRD3Z0FF/mhRi8hEZcBcCFiJI280VhaJXJUeViWJpGUJLgcEwRXyYcb8/7rJ14fm9MJveAaxL88iTK7ddoDlX6zGOhXqD4HCpeD5hCJbTEPdyUlWcnpd03J2i1Fof1aNEfZ6f5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=pXPo+p6C; arc=fail smtp.client-ip=52.103.2.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3TlVhg0LfgQ8aiFHWsq6E1DXu82k6N+9Tp08vIXgQFHQo+AimTr+r2+iEOOuChi/RaiGaGCH4HzwrmlMs6IsUEA6G6p3usXVURssCSfqvx4oJ54Eqk+1haIur3Fy2DLWD0y64Onrb+w+rIHmt3Juq9rqBnCxgbt2zFbeDda+dDZIGI5owGzJioknUzYz2NJFoI3k7bsieNBTY98486eDUz1zZVqzzdxC5BcMtvIFFYnFFD5DFbh5GvoyfZuIDpkfvKkfQE3BKTI7xqsXtNgLUMviWW29a1P27rnuIvwzA2+sYh8LD5oKUJ9gYXgDUlpL/gHWvSmKy+k+y3H7hddPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+YlHUnP9utU/sWY6EIGS79XmmTYoh/FEt/KhqjI7bM=;
 b=RcVhx9+zbSWVoVJcnycKd54r/PmtK97zltx4UKzzKhjOMxjcbV+sikoUo+AmWHAG2Fu6kbJ7HERn8lpL3/ra5V1CjGgpQYGEqqxHotPBpMr3KN27xFTtaWBK6GkZtNl+4UkeEcZkADBhjZmy3Qig0S5f3GBYn/hcQuPxBtdLhhVXlPH4iquuDIy4/LJEDx1+8ByiXTfOU5THJQx9eYDlZfoxuVlHxK3AaHWgcntb2RB+jFGf5/CEn1CdAP8OR9V5VDsBAVFJJXWRvgiYbnbN7gb9vAtTcvblwFZ2uBMpAjNXKCgVRMxo0xO+1vvA33LCRDacDPpgxf5smTLjwHc8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+YlHUnP9utU/sWY6EIGS79XmmTYoh/FEt/KhqjI7bM=;
 b=pXPo+p6CKKpy1EjhWXZyzGr9HBJZRVGh9mi690yHJaiJiYxkxIixyxpb7WlzO6VM6Ltlmt/znje15HfH8QrcDcZzgFLzrfLgHTEZ0PAP+Pem09luaLwJ956MYn4rs4JVkRBJtFCN9LbxvcVQK7CkS+BoJGck9RHJTRuKWAg5tdYPQyTlKzTfVwJgRnnbQfEdVWJdukeKt4w8eQS2bfAkD55zkazL2y1eIqM04+Lkh49J7KkdHJmHXB0T6FPFL4r3Jf2X/uhusEnUju+5FvUVqEhB7rEgBHNPYA4DwRvqher/0mowpp+N/oriKkaMQSOolD8967YFnGX4TR/ZjPY0CQ==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by MN2PR06MB6653.namprd06.prod.outlook.com (2603:10b6:208:20b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:19:59 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 13:19:59 +0000
Message-ID:
 <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Tue, 23 Sep 2025 09:19:39 -0400
User-Agent: Mozilla Thunderbird
From: Daniel <dany97@live.ca>
Subject: [PATCH v5] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Markus.Elfring@web.de, hansg@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
 <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <3bd28870-d6eb-4659-a533-7c3b80d14595@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|MN2PR06MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 1220035c-415a-452d-c934-08ddfaa3e2f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|8060799015|23021999003|15080799012|19110799012|461199028|6090799003|41001999006|5072599009|440099028|3412199025|12091999003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkJ3N0cwajVuR05mRHV1Q0hiMkUyNWlQSnRUQVE2c1dxemt5RHBnQU1pZkww?=
 =?utf-8?B?NHZLZFNGOW5xZ1J6K3lKekRnRzZ1TGhUMHh3WUx3QTVNbi9COHY3dXFFT3lK?=
 =?utf-8?B?UTU4UUlQeDgybTk0UDZQSEplQ0ZaYTlLS2ZJK1Mxb2JwWER3ekRla0p5ZEFF?=
 =?utf-8?B?d0Ztbmg2QkxtcjAwSEtrbHZncCtNQkI2bWowcGt5bUpoR2N4YlRwanE0OVBy?=
 =?utf-8?B?WlpvK096THVmbFlVdmdQSVRHZ0hacDFndDJqcURuejdVTlBKMis0SUZRaExT?=
 =?utf-8?B?bmhHbHlRVnRVb1BIL2NXRjhnNHJOUkEyZ0JTbUlOTFgxTW9vUnl5K0h4dXVS?=
 =?utf-8?B?emt4eGQrNjB5OU0zNjUrazBsZmEyKzRCYVRMZWFYdWxWYjlVcno3L1o0VG1j?=
 =?utf-8?B?K1MyUER2bUhheDhFM0FpejQxUXo5SUNFZytIaitqd1ltQ1NkK0ZnZW1QaVp2?=
 =?utf-8?B?bzVldnc2UkhMUDdUUTNuYllPY3Z5cUY1MTFBc2YwSWVHamZUcUdHaUJnQjRz?=
 =?utf-8?B?eHM3b2dZOTN1UE1DTHpVeURadDNkUFpjQTNpL2ZDaWpSL2llSTl2Z21QcCt6?=
 =?utf-8?B?R0ZkVytiQWNpYStaVnBXRHgveDlzY09SNmMvbW9kWWg2TFF5ZWJ6Y3Y2VXRm?=
 =?utf-8?B?eXBYeERNY0dSVGZralRSRHZ4bDFRY3lUb2pGYnZvU08rNXc4eU9uTUtDdkVX?=
 =?utf-8?B?UFMyVzFTVGZiMVRZSTVpQkIvemFjQm1qTDJvQ200SGx5K2dUYlR3YUdPNk5r?=
 =?utf-8?B?S0RNYU9tWEdBTUdxRmN3eEUwTEFxSlFTRlR4eHpuSDVjTVdnVEtSK3NHbzh0?=
 =?utf-8?B?cThBbDdzSHM4WDFDc2YwQllNeUdFRWhKaktCS1VoWHhoYW9ueE9rUUV6SE8z?=
 =?utf-8?B?ZGpxWS9RSXJxaHFaTmdobjJGSXZuQitJVDdhVW9Wa2YwZFlqK24wV20zZW1H?=
 =?utf-8?B?V3d1Ykg5ZDQ1VzRQWVdkVXpTdmt5SkZQVlZkcU1EM3l2SVpQVGZUbkRZcUdD?=
 =?utf-8?B?NHJ0dkNKNEtRTHFKejh6a2tNbE9TSlZtQmIxT1Y5LzZBc25lZDlGQ3BlbDQ5?=
 =?utf-8?B?ZVZ1SFNucEU5ZEE3dUt4WWpxV0d6VHRncjhneU1wVmxUeHlwQlRzbS9PSWVm?=
 =?utf-8?B?Q3Q2TzNGa3ZNSFR6VTAyRjdlek13RE5paG10Y2J3NlFLbVBUS0xsWUdEeWlN?=
 =?utf-8?B?anRER3BRQk9oUHBiR0JZbk5OOUZTZ2R2K1FzdlkxaEZaaTlSTkxFbndnWVVw?=
 =?utf-8?B?OVFBZytLT1B4RFhTcnFTd2dPMlprMHowR3FKUVV5cXhUUGxiRmN0aWJoa2hO?=
 =?utf-8?B?NWU2SllnVFBQWEJvODVEdDRsQXhKVjlMaVBwOHYxZjJlNytCQ0gzdjRzWjVE?=
 =?utf-8?B?MnYxeTRMNkVyUThyMDdtVmQ2R3Y3RmFDWXd6TXpZWFplSE1sMkhjb2hBMmNT?=
 =?utf-8?B?UTFpU3ZnQVVDbDIwVVpGd0VtcmhRak81OE9qVjh1QnhLaHBQYWF6MURTME9F?=
 =?utf-8?B?VFV6M1FRUUpybjRDczJ2aU9Ed2x5MGRDNytiY2daVDl3Z043eFVXdGUvbWt6?=
 =?utf-8?B?dEFOeUl3OC9IRStpUnVUNkdLK3RoWFM2dy80cDI2NW02bmo5T3B3endWRit1?=
 =?utf-8?B?akdnb0YwQ3NkMEJ2cE8xMmpGeU5mYW1DVm4wcGg3dDNhUEdaV1BxYkp5eU0z?=
 =?utf-8?B?ZjQxZmhrS05oYkYwTU10UXJCTXpsOGRaRWpUbDlQNFpoS2wzTTNPVDhRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2dGUGtXSWNGcUZGZW5LMThBUmp0SDZibUF4ZWk1dFJhOG1BNmVqc0k1UkV4?=
 =?utf-8?B?UlhxY2V3a3pqV3FOcW9TRXBRSVp4bUJSTHY1L0M0eTZmM2hRRldNdXoxUVRY?=
 =?utf-8?B?dVFjZVE2K1lwVGNaZmFzbkFGcUdaY3Q0NFFNSWhEVkJ0eXBGL1V1clhQOUlT?=
 =?utf-8?B?NHlIaHZQeEZWWUpiRVlDdkp2NlFBZmx1WTVFcitZQnRvMzB3aVB0TEE2cGhr?=
 =?utf-8?B?b0wySk5ncHB5UmJFc2JkV3NYd3BkUXM2VmRjVWgzcURmUjdwOTN3T2s2c2pV?=
 =?utf-8?B?K3BIZ0lCRGd3dlhNY0k4VDR3VmFxRkxJQm9YNGZiT3dWQzdBTml5NmZQM1BN?=
 =?utf-8?B?aVhIWFd2S3ZxTlRMY2lSZWVpbjIxSFlURTlUZnpGd0d3RWg3RFlJczBNbWVi?=
 =?utf-8?B?N3NKRjFBKy9OWDFGRjdzZTdLVGJoNG00MkwyTWpFdVhNNjlJWU1aazA5VG40?=
 =?utf-8?B?OGVvckorb1ZxVHpXYmFGYzZHU1UzME5xZHF4K2NxaVFqbHA3bXFJbVlpRmRM?=
 =?utf-8?B?WUR2VExZUWdPVEFhNmw2aVpiSmh2UVZqSlBLK3BXV3FtMStzR0phMi9VVkwv?=
 =?utf-8?B?UVFFMFVjc3V4QVFsdU0xSk1FOEVMTnZXZ2lxazExeEdBdWVkTEtJWjBQMVR5?=
 =?utf-8?B?dUFxVlJmM1dHaDFqZ1AyekR1WHJQaE5lVG12Q0RKMUQ1eTRCUy9YKzIxYVNP?=
 =?utf-8?B?bjF3bEczQnZMY1JwUWx4M1pwVlJpeWYycVA5NnRYK3QwWEw3Wkc5aHBheTB6?=
 =?utf-8?B?enRiZ2FjTFpKdjF4V2owakt0QzhVRWd6TU42WWQwQ3Q5YXBPcnFocjV3bmJ1?=
 =?utf-8?B?cFNOL0lPVzE5UTdvMnZNeE9nWFovSFZMZEJLUzQwNWN1ZnQyTUFsVS9DQTJh?=
 =?utf-8?B?T0VSOXRBU1lyUW5SS3QzSzJDaEthR1JMK1BWODVLZDJPTXhLbXpiWmE0VWJG?=
 =?utf-8?B?TXI5MHlNWGJYaU9XRnBESXZIOUNFWmYrT2VNb1BlVmc4eEhHZmYyV1VSRkpk?=
 =?utf-8?B?aGNJMUJrdGlRWVJQZHRnSTRtVlZXYU5nQW1yZVFiM0drcklWUXM3Qi9LbEJn?=
 =?utf-8?B?L2NtemFOMm5zRk5rdXo2ZDAzaEN4am9yWWNSSjV0Y3paM0g2UEdWNlpaT0gz?=
 =?utf-8?B?dXNqbkFsSWc2Qy9TUDc1QzB5Qjc1dFRkS0Q2bWdDeFlDdUx5RTc0Sk8xYjFl?=
 =?utf-8?B?MGhRSVl3WUFqQ204M0J3OVRTK2dmMzBwTzZJdERSVEZxOVNTanQwZi9ubnJK?=
 =?utf-8?B?WjZoNUlKZEdKMHdmeng3UjhTRXE2dmdlZGMwdDFlclBqR1Jiempwd0ZBbkRq?=
 =?utf-8?B?MGhZQTJFdTM0NThiQitndHNRMzFrbXZCdEJiUXliQ3BpZWw0OEtocGF3SXQ5?=
 =?utf-8?B?N2NBakhyTVUyRTBwemNOek4wWGFMRzlyRmNHQVFCYzRtL1czOEpSdm1hM3B4?=
 =?utf-8?B?QmZOdDlsVEp4V0ZoOXdYQm1IeVRsaFBja0dqWUtsWU5FTWNTL0xmTG14YlBO?=
 =?utf-8?B?MW42WnhIOHZMV0drOFJIeVhwbnBnbmYxSHFENmNCNG9IenZ4UzluWE9kejdt?=
 =?utf-8?B?ZStUcVptS3psM1BncFh4MERsZnkyclJjdk5BVlZjZS9OR2hCT2IrbU5QejVp?=
 =?utf-8?B?OHQ4TjE0NDFZaEgyODU1VHBRSllsd1E9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1220035c-415a-452d-c934-08ddfaa3e2f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:19:59.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB6653

> Ah okay so the variable name is misleading then as it's really "mode"
> that is returned, not really "status"? I think this is fine then although
> I'd prefer to have also another patch on top of this which would rename
> that variable to mode.

I renamed the variable to `mode`.

Is there anything about the commit message I should change?

-- >8 --
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

Signed-off-by: Daniel Lee <dany97@live.ca>
Tested-by: Daniel Lee <dany97@live.ca>
Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
---
V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
V2 -> V3: Add parentheses next to function name in summary line
          Use full name in signoff
V3 -> V4: Add include for linux/bitfield.h
          Remove "FIELD" from bitmask macro names
V4 -> V5: Rename `status` to `mode` in fan_mode_show() 

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

