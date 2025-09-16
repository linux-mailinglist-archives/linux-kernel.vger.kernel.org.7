Return-Path: <linux-kernel+bounces-819059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B7B59AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41247A2DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884E32F754;
	Tue, 16 Sep 2025 14:48:06 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022087.outbound.protection.outlook.com [52.101.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1E2D321A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034086; cv=fail; b=fP1mTMYkNHFW5nk7ctw4ut3c4ZAc4Lsv5MxGDITIIiukPjk4Q8PqUUOe7yyGNVwp1QSs20Vugo+f/Mw8n5kmE9/Pz5FeUB12P+6ahMouUuqScvtmfbwYF9wv15CbF3zfJvkd63mc4sLd8o8ilEbadlwrwRAmIqh4RstsMhjynVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034086; c=relaxed/simple;
	bh=T6CZF1al2/Y3+fBrg8TJwTX61Bcy3an+Seu5z2oN/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ABB4FZubElZtHasOBN4HaE8Rd47WtB20+kQwi+vP0oivKOWa8br2SV2poQgF4irA2IZhUDuL3YekKLUhoJBfV5r4PtQH2RpnE6Qf/m66evquaRDFy4zvrr4PLGSTBJFzvAMLScpSs46ZItV1J3tOwhoI/QvSxDpTsAFAYcmCtyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb5kKN/aodh8VB4iIKWqYfIG5NariBlf0I+4jrsFBNg1IjYyOF3mplzS4+5jobq9TrdbAcNcEnJQfqhSImfOR99/fVl4dihsK8hgX9MGZAIQI4UhpXSNEVGJWQwhKjoWWfBtsXWCstKMM7Ow3A81p6LNs0gqIu/KRXFkEv0B5BnY2+I3HtvYxHJPiWmy435Rcc4GrfdMvaIfmhpRge5ggz+UacSUX9qrMElYdmDd2DOfThEw+bUgUGCjM9AfJo/S0P570rUJiG0pEoa+d5rWcJ/d3CeGE6qtqVUIy1QMEohMWTnAnQLgh5Bf9+40iKTATGcVXoahUsmaADQSO7XDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNuCN92EVEtKOj4o5YWr7VidFEQd2FiepmLltH51BQk=;
 b=oVRSKAVVNxYzTCgJudK9n2m/qu4370ZDcekzSzcSmyf/zVqLvGfDZCQbvZrCPt1Dxc6rCL0L2bA2vZ3oQ2mW1G4IvPtZNJYQC8nP8XNVz2lUjeBhjXfklzMmN15VTxfQe+FV02ZHPvEmaNXxmwPhcpo3AcYl9d8C9H3M50b1pWG52vh/OhdY9OlsslXVH63w+tk6ZfWtARqEp8l+JZZwTHGtBOXLpBCb75UTWJRS2qdldI4Oar4QgDULGi9h4FIHDzoP9cyX6YyYuGuUFywAkLI3S+6JmYcKhjhKMOqNRFRI+I2eJJAGXgRrZhEHtZW2GN5VutBLph5zdyQhb6Zp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3354.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:10c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 14:48:01 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:48:00 +0000
Date: Tue, 16 Sep 2025 10:47:56 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
X-ClientProxiedBy: BN0PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:408:ec::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3354:EE_
X-MS-Office365-Filtering-Correlation-Id: ebaf5dfa-150f-4dbc-43ca-08ddf5300862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3JtTmp3dDVYdmdtVGQzdmJuMUc2NVFnaG1Memg3a08wdDFRdkpLNkdhWWRu?=
 =?utf-8?B?VSs1NkdLTEFudFI3Yk4rTGpRZjRpd2tEQnNndGZMMm81VUc1aVp0ek15MDZC?=
 =?utf-8?B?Z0ZicG5FemxSaHh5U0cxd2JPOXhjVUZCcnhjY0UxczQ2TVBFb2dXSDZPVTRo?=
 =?utf-8?B?UExDL3FvN21lSkp3SFZsVmZSejN2WG96Y3hUbU9PMnNDUG1qeElPd2hsTzFE?=
 =?utf-8?B?a3g2S2Jwb1dNTDhpWCsrdW9JYWF2OGg4YmVNTHVXQVhtNkozZ1RRaWJPRGdo?=
 =?utf-8?B?MEZtRmRUUXRZZ2l0NXNuK0FKQ2ZVck93VkFraE5qQ3RscUNMZHRRaEVnT1RP?=
 =?utf-8?B?dFlyVmxaWXRCVjFLOXM0ajNNTVhNb0o0K3gyVWVnL0xwaUxHQWZDRkJXcXVa?=
 =?utf-8?B?WHFoVFk0NzFjczB6UTRTbldDUHREQzlXMUd2Qi9PckV4MXhMZWdiOVNoWC9O?=
 =?utf-8?B?NEJNUkZSK1p1STVYU1dPekRFNVQzMUJnSklIRklZTlI3Qk1WL2M1MzFQbWlG?=
 =?utf-8?B?QXJ5Um9tVm9CZ3ZRYmRZSXpQVm8welhra3dJN3BCTy9DTHVnOTdoNFdNYTZ1?=
 =?utf-8?B?NC95US9ZMGZ1TENnS1lKQmZjdzd1ZkRxSU9qT1BMc2ZrenF5R201ck1TRjFv?=
 =?utf-8?B?WVB6Nk1jSVRmY1JQSXB5SGkxcDRwSEFqSG9xRmJZRitGZW01YUhENE9KMGJp?=
 =?utf-8?B?Y3M0cUk3bWlVTS9PNzJmbUtObVdhRzVSSSs4WUUxZlhUSlVSQlZzOWdHMDd4?=
 =?utf-8?B?eUovRlN0ZTB1cTUrYnlLYlRIZXhzdWJPdWh3amVlUFZPa2RQN3ZTOXZGNzBC?=
 =?utf-8?B?QVJ1NTd6UDRCU2ZzMk42VGlLQ1hjSm9nQU4wZisxc0lmWU9PNjEwOUM3R2Nj?=
 =?utf-8?B?dXRycC92MEc4UGNUTjk5d2twYVJUaHhNR081Skx5UmZVR0tOVFVUdFMyeU4v?=
 =?utf-8?B?NlhQQk5XNFhDOStHalBycjN6Q2VPNHVyWHoxV0plbCsxMllWaEpIQ0pPQ2Zr?=
 =?utf-8?B?enpTdjJuT2N0MFVZb2VkckFBdGh0Tm1icW45eUZURHhERDZvU3Z1L201OVJW?=
 =?utf-8?B?MC9sZFhTWU12dE11MnBTc0pwbkZoMC96V2drMU5GR0p3R1haQ0VFQzlaVGxR?=
 =?utf-8?B?KytCZVQwZ2pvV3pBV0IzK202SmdpdE92ejF3WUhwbnVuMzFpS3Vqb3VwRjVQ?=
 =?utf-8?B?NjYzNFVyZVJYWnhlaFJ2N1hiZ3pUVTJBY1EybFRTZi8rak1pc044R1VLUllJ?=
 =?utf-8?B?Z1pOcWt3ODdRc1V2U1ZXQ1FWUFA5UlZDSFNOSDUrMi8yVHJtVUdKVUZqWURD?=
 =?utf-8?B?bGJ1UEVJUUloWnJwQWEybE5UNmU2MmZsc2huUFBTUjJ6c296SFZadzgwRGxK?=
 =?utf-8?B?QVBZcTdQd2p0d0hqdllSeFRrc0lEb0ZHbHZIUWtkMmcxVklyd04rSUpDcEdE?=
 =?utf-8?B?QVlVdkhhTXFOeFFrd2ZWUFlrangrS3dUczJtOEkyOGN0Rmc2OHhPQU1xaStr?=
 =?utf-8?B?ZmlyS1pXMlN3K1hteHQ3WFB4UTVKUkZmWU8zcGI4OVRGSXBBbFZLcnBqeDZi?=
 =?utf-8?B?TmpPeGlFeDdzTjlIU2hhMm5vRUVWcFZNOHJhdjNDQjVnc3FtNDBjckhHc2t1?=
 =?utf-8?B?NjFQb0F6aDRxZVRNWlY2TUY3Ky9OWEVVbHpDMnI4M3J2TDlSTksvTTYvSjFM?=
 =?utf-8?B?dWxGOXV4QWltaUgxeHVaY2w5dXNyeWozRGNFYWNPQ0k1V1J0eXpVeTEwQVhN?=
 =?utf-8?B?Z08xMmdPcGo5SzNjKzg3YldJeERNdkhiMnJ4elZveXNWOWRmSTVsZVo2U1ZY?=
 =?utf-8?B?cmhFUzBYSjBxaGV1aGUwSlBITmpwejdtRmdLOGFqRmdBOWtENzVCWk5VM3Ny?=
 =?utf-8?B?RHNoRnRybjRXZ2tvNTBaZVFOdUcxSzB2S1Q0eGNjTjlBS1ZRU2dmZ0xCWWlM?=
 =?utf-8?Q?vD12B3InBLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNjcFZkOFdhZDFsa3R4Kyt3bHZUQ21SUjhBWmQ2d0FMYW5jS0p4S0NHdG00?=
 =?utf-8?B?amo5V0JPWDY3bjFMcTdkc1FKQTRuNzhudmdhcjJQOUdVRm5CSkltVFNibU0z?=
 =?utf-8?B?UGNZRE0rZENXWjExanFNeExoZ2VxZE1BdDkxYklsYVllWWhRUGhSUkpMVWMy?=
 =?utf-8?B?ZWx4UUhvZTl1QnlpZUpRNWpML0hOcCtiVnhQQWJCOFNmR1hjV1ZhbHkrSVh5?=
 =?utf-8?B?ekxrak0wTHcvOVBBdHVRdGdFQmtlVmNZV0pyUE1kYzBGUGtxMWo5SE52T2Z1?=
 =?utf-8?B?cmYyNnFUTGEvYWJ3TjMrbk84Rms0NGh2WXRER3NacHdEUktrdUdweHRCWHZG?=
 =?utf-8?B?QTdtbE9DUG5CQk1UWDNqZS9iOHhIdDJyRW5QZzBabHlsVW5pTE1KRjlnKzFa?=
 =?utf-8?B?amR2N2NleGhqcnpYSkd2bzJOaTJIQ0JaRHNoUWFjUWNNZ01ReVBtOXBMTlI1?=
 =?utf-8?B?RWJkZzNwQnZKRFVuK3p5L0pDNlhIL0NTY0VXSU9CaTN6dFJKMTh3SjM0V3JF?=
 =?utf-8?B?cVB6MW9TYkFHYVFaK0h0WDJ6ZVY1eU01ZysxMWZSR2U3REVNNis4bEh2NEg5?=
 =?utf-8?B?dHZYUEhKZ1RIT2JCSXUzQkhHWHB5VERRcVl5cW5RZG1ZdDZuMmRrbjRvZzdw?=
 =?utf-8?B?QjRIcG9GbDhtcEhnSldnNWpRckYyaWhSLy9QSStNRjJuWWViSmtiNHM4STZL?=
 =?utf-8?B?emU1ekZpbHJRREtJU1RKa2g3bXlsQkhuZE9LRTY1Vndid0REVEZFMXVZdUxR?=
 =?utf-8?B?WXN5MzI2NnVTK1RLRkxlMEd3QUl4ay9nZEY5R1JnU2tJajkxUjFCWVo4cjFG?=
 =?utf-8?B?OHpZMnl4ak91eFVSWGJxbGVFZmVyNmowSHdXSTNYeHNGY0R0WXpQMzFrNTM1?=
 =?utf-8?B?bEd3bXBESFNMa2tuWDZ4VTRkTWRybDVtMytSWGxINU9McHR2SWFkMDNncm5R?=
 =?utf-8?B?Tmx6UGk4RmsxaFpjQTg0SHdoU0tDQlkrWlhlelBnZ1hTYmtGUlhjbjVYcWJk?=
 =?utf-8?B?MW5naDE4VzErZ0V5QXRSZW9EYnRac0lacGlLaDRQcEM5dFhVN3dnVXhPQ0tW?=
 =?utf-8?B?bE5CT29mUUJtSDNKM09NQjExTDR0UVZCUEJodW80dW9ESDBUZ01oWFRzNGIw?=
 =?utf-8?B?REE0NlRoT0JOLzN3WGVHSGo2UjhkOVJFYm1rdWtZcDJYMnVvL3JZS1AxQkdy?=
 =?utf-8?B?ZThiN2hoOFlsMERKMmpBTVF6M3JzR0ZJWjNMZXhPOXJ0Tk4rVEJieFhTb2lC?=
 =?utf-8?B?M2ZzVGJPbUJSTmllQ002aFN4cnVaaFZ2THB3ZktEeVQrVEpndU51VEVmOXlj?=
 =?utf-8?B?d0xNUGZSelVmZEROK3lNZ3JBVkx0Y0p2eHBzOVhlem41NkJBYWpLNlh5K1Bs?=
 =?utf-8?B?QWh0QTRoVjJtVUJwQXZnRGNCMW1sd2VnbFd0cXJuK3lCRDVsYnE5cUgzS2xi?=
 =?utf-8?B?TUwzNDhyYkN1TndicUE0QlUxdDhEVEdRK0dydDJUR1RhWW9QY1NrNkcwUkdm?=
 =?utf-8?B?ekJqajFnN2FJYzYxeUFOb0JaamRoZHA5bDJRQjN0TEVzc1dyR25KZmhqN2NT?=
 =?utf-8?B?NVdaaGZjZGpjbzhYRlhzYkdQa1FuWEUxV1pDVEFqSzNHUlJZejJLa2wxZU9H?=
 =?utf-8?B?K1pKV29yRU5WaWMxejRDTk81QzIvbytJVk0vUHdVUGI3RjluYzdFQ2pPK0xU?=
 =?utf-8?B?VDc2SHJXeUYyTFFROEZ1MmZ0RmlXTTZQTmtpbXJYYzh2anVYM3lDTC9lOUlB?=
 =?utf-8?B?SWg5cGc1UUNRV1h5dDFubGY5ZGdMTTUyd0hBbi8zbisvZ0Z6dE5RcmdYSkVu?=
 =?utf-8?B?SmtyemtmM1BUeFlBZnUyRy92bGRXUEhZVTdyL0JJYTFsY3VVYWRUVFBiZFNn?=
 =?utf-8?B?VkhTUUhnY1JXSjB1bW10UHRrZjFqVmlGVFYzQWhRUUtzbTJxbFM5L0d2VktU?=
 =?utf-8?B?bCtRVWlaaVFUT3QvQ0ZLWnI0eEN2dUdxaFFqTmFpTTczcUtZRDJxdVl3bi90?=
 =?utf-8?B?bGtmamFCOUhDUGYxZHJZUzl4V2pwR0lOWVBxWTBobjh3VWJPMjZQZW9VbjNq?=
 =?utf-8?B?SnFkeDdxRkxpSE4xQ2lDNnE3QU5zTjhLeTFvNVBweXU2TGtvK0djTjdSZy8v?=
 =?utf-8?Q?6WSU9iWiNZNIk5Zoymqk3HxFK?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaf5dfa-150f-4dbc-43ca-08ddf5300862
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:48:00.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+5GMTFH9KH+FR+yDfACYU7eizl0hvj1DcSNNZBHlBWPIYFeQWJGaAbCOrvDWSCX/Ao3he/cJgVEGgrGAMKivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3354

On Tue, Sep 16, 2025 at 11:09:45AM +0200, Michal Koutný wrote:
> The action in this case should be to assign non-trivial quota to target
> task_group (or un-rt the task), no?

Hi Michal,

I would prefer not to take any action. However, is there a strong
preference to demote the rt task so the CPU controller can be enabled in
this context?

> What setup do you envision for this message? (CONFIG_RT_GROUP_SCHED and
> cgroup v2?)

Yes. At this point, RT_GROUP_SCHED would be enabled at runtime.


Kind regards,
-- 
Aaron Tomlin

