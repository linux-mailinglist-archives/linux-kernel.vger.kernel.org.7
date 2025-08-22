Return-Path: <linux-kernel+bounces-781791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D0B316D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9FAE6132
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4692E7BCB;
	Fri, 22 Aug 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=@siemens-energy.com header.b="BBc1hs3g"
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11010057.outbound.protection.outlook.com [52.101.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6128AB1E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864094; cv=fail; b=Yp4uEW7devjxzU4rTX+074CSa3HMTHtFtC4eWDdXnHcXbbTZhAtC7rXYtqCESOCEXfsvwJXnxokk3q4/Sz3p46vBbO+DeWjklviYit6j7CGfmlKAmTFFWOedLsIrsxtFaVLQihCg+XQeAtGiRuEoea/UwfX3v+3chpHJJmCCcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864094; c=relaxed/simple;
	bh=RH3oe1R+nPTwPZfR1e3qVneG2XAQGJ7XsBIaJj2LrYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1MWJzCBqbKu9BSYWl00zi5rywYhe5oScfRpMEcV6aADDCBZKD20FwBRgNc3lVXZWioeHDI5ms0Cns4RYQ0xZYytJaNWsiqOVGstZp46BgFT8k7z4xFpxHBlyzlQ7XcozFP4oqTc3UGv4B7ZLdsm/NlxX6IPdBxnXTpfM8JSh1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=siemens-energy.com; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=@siemens-energy.com header.b=BBc1hs3g; arc=fail smtp.client-ip=52.101.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens-energy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riPv/sy/WdU/zeJ8xTjdSCp5rAydgGQlyjXJYdIMhTiLAQ3ecOoApSb6z95yc9rd2UNsdSZuxg5ZMBi08fGbsd0I28LJZxBR9X0nPSzHW11DbTW0MODq/q+yyBT3NEmL61ZKFgqazfVqMrroOOuD+f27ETgH3ix8OgYR1efW6X0ZLipIYz/xIjpnT9LjnhrNE+XUJnb/zVJ8ccnKSM4yjAde97vXklMRM/AwaHPL/KO703MmZKgcfwY2guWpUjPceEBmvlX0Li1xFrQ5n4zj1mzNacwezf6x+MuSf2oR/vZwosLvbHFl029Lbr3m8QZE/CgiXSGYjhPPqsysbmPMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH3oe1R+nPTwPZfR1e3qVneG2XAQGJ7XsBIaJj2LrYk=;
 b=Dyaw46pxyEV4MeQyUi/ndQGE7WDhiwSl4WYxZvStvSCtcKTKWXX60vOc8ZqNijXbl0KK1KvmLIkSnBXAuOUQt8EyMqJHH591Qc9Ahdm+2+T5EeRCeb0yQ0O3JKMkohEC4CY0BfdYn7Bq7pZg2sHdeXgzlqbeSbT2KYEOPYST5nxImm9ioHw642f3LjgHXqAFzs8Fvo6T54QX8RrRXwYxM/11n5/H7FgQd4zQSBw+Hp5gnds3NV0NgTOgFmbRfleDocS6sOAaprBxnKzkIHSxxqZGbaMBf3A7+VX7ifdJuKkT3Zi24UR0/bDYj5k5tV/bIxXZDGPLy9ozRTuxAhFMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens-energy.com; dmarc=pass action=none
 header.from=siemens-energy.com; dkim=pass header.d=siemens-energy.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens-energy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH3oe1R+nPTwPZfR1e3qVneG2XAQGJ7XsBIaJj2LrYk=;
 b=BBc1hs3gIQev5T6Zi+UnlV5YCzaHpAzdU5h7pGTNv0UejLmBLqG6CQzX5ywvUEgh5XTRmtfgWd1zyUuOvGUUypuf1EJ1HUM83P3in3z0Pzi1EETqCJaRAweU7vDiVE64xK59bPeM9b1wHiprJNChnuktVthrMakUmKiNR408slTkPMX6mwRfF2dWa42W5BZ9qC7y5lYZIo33W3xabM0upuCFu4cnJpPdPBl9Vur5r8TA0EjEUHVt0g2IAaAV88S+XkHJ2rtB/Zdoc/KzU5+J8w8yEJbrLZsuz5e91U0a7553YJvglI0zvynXvuguztKHeevyPBnHOmDhGJNCyXzfXA==
Received: from FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:91::10)
 by FR2P281MB2672.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:66::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 12:01:27 +0000
Received: from FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5233:e398:feb8:a20e]) by FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5233:e398:feb8:a20e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:01:27 +0000
From: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
To: David Hildenbrand <david@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Christian
 Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
	<vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH 1/2] copy_process: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
Thread-Topic: [PATCH 1/2] copy_process: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
Thread-Index: AQHcEo6g5ujZ/0rMIka16XkPmN24cbRtnASAgADDDWCAABUeAIAAH6zg
Date: Fri, 22 Aug 2025 12:01:27 +0000
Message-ID:
 <FR2P281MB15448514081BF9CDCB414E31B53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
 <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
 <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
 <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
 <f6ef7e0f-0b48-4028-ba79-4a5ec66e720d@redhat.com>
In-Reply-To: <f6ef7e0f-0b48-4028-ba79-4a5ec66e720d@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_ActionId=fa73d43e-3f5d-4b9b-b20b-745c0b983e2b;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_ContentBits=0;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Enabled=true;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Method=Standard;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Name=restricted-default;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_SetDate=2025-08-22T11:38:04Z;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_SiteId=254ba93e-1f6f-48f3-90e6-e2766664b477;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens-energy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1544:EE_|FR2P281MB2672:EE_
x-ms-office365-filtering-correlation-id: d680cc90-9b19-41fb-8e6b-08dde1739fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDBkSTZWVXdoQjhoY2g4WkovTlRPMnRidFBaZG5SY1hjVkdmdHR5ZTJXNWpr?=
 =?utf-8?B?SzhxSFhGWGRqTTkyUGhjNGlwMlRZOVhlY0tnclBmZDFpQzlMREl1UFI2bEVC?=
 =?utf-8?B?dUhJTHpNY1k1WWNFelRxd2c4SFZ5NDNERTBUbEV3Qm44RFI5OC9wZExTaWU4?=
 =?utf-8?B?N3Z2UWpYdmNaeWVHOHJ5MG9OYkVZS1grU2JGRWpNY3J5UjdtOUVNSlNaVENq?=
 =?utf-8?B?TEhSOFFWVUpSNXB4UFBCeXhpeG1Md0M2TnRkL3NGWHhNMjBWeWIyVU9wQnNt?=
 =?utf-8?B?aHFsamFNOG91MlhBOEJVVkd5Z1NXUlVnclhXMUpmcThtS2UzdHU5QVlTRmIv?=
 =?utf-8?B?TkdNTG1Ia25KTnJ2MWRQRG5PUGJVRC9HRzZ0R3ViY2RIOHpYKzkvdnIrRnRU?=
 =?utf-8?B?VEFNYlJxUkhqdVNaVnE2ZGI1RFFZRGlwRkJVTm1rZGNsVWswNVFzRGRadTlv?=
 =?utf-8?B?Z2kxUHJyMXNucTE1bjhhMFNDRW9LbzRTUTgzZmxGZzNLMGNyTzA3WStBNU5V?=
 =?utf-8?B?Nm1qNzZ5ZHdTOFFuRFJWV1BISnF3MWNQK3Ryb05jTWVJU3pIUmZBTGlWODF3?=
 =?utf-8?B?dXN6akFmaUZlTnVsL2lNVHB5YURMT0NZZ1FWS2ZzblNlVnMyaTdPUkIwRy9Z?=
 =?utf-8?B?SnR4c1lyR2hoclk1V1JDbFBRRnJlZ2tmbTJSNjlSUHJLMGY0cG93c01KZG1z?=
 =?utf-8?B?K0lkd3ZFSnJXN3dqbHZpMlVYNlpZRXRUYnNIdFg1ZDhYNkducW5YQjdNK0hS?=
 =?utf-8?B?ai9XQ0ptS1NTbjE5TjE4VTh1cDZoejlQV2xZK2pkNVIwUWpqa1VDZHhCQ3BN?=
 =?utf-8?B?QUpwdFFmSmR6Nmk3OHBJV25GaGp2UVoybHNHMnhEaVhiMkRNZ3ArRHQ2TnJi?=
 =?utf-8?B?ek15U2c2ZS9rWXlTVXlyRzdKS3Jvc0VEbnJuZ3VjUmczNmkzb09vVzNlWXFX?=
 =?utf-8?B?aVg2NkFWNXFoNFZEU2lFM2ZGS2dCRFBNSTJucHBxTDh3M3FxOWJyclNiMUVO?=
 =?utf-8?B?MkJQV0lqRmZQU0dGd3U5dGlBMXRRSmkxalhySDMxK1k2aWd1YncxUHlIWTBh?=
 =?utf-8?B?cTc2dkJiTStWcGdGZGNGYUR6M0VLeVA3UVBreGpYSm56TTJ6VUY3elgzV1pv?=
 =?utf-8?B?VVIyZU1Ba0VQTUsvUlNCYUovZDFlUWkzbTJyWWppUitwMTZVajVuRUZ4YkJE?=
 =?utf-8?B?Mjd0d1BiU092OGF1cnlTUW9EZjVvenZtMzZVbEJlREdOakhwZUQ4M3h1S20v?=
 =?utf-8?B?Mk0wcEpIQVYvNW10WFU5NCtOUVU2T3lrZGhWekRYNjIvcHpRMWNDakpyVDAv?=
 =?utf-8?B?M05WbFdKWk9OMU1IeHk4dmROci9LQXhoaG5JMy9TQndnSjVkendVVS9Xc2xC?=
 =?utf-8?B?WWZzbGJLYW5FREM4N1VDYm9oWHErV1N6U1daTEVncm1qSjFyV0o2eUp3cklF?=
 =?utf-8?B?clFFT2dvTzQ5VXU5enhiN011LzNtOWdlQ2VjTW1TTCtqZFVQUGt3MDVDbW5O?=
 =?utf-8?B?Uk0yZ2R6am0reVdycjhYaGJ3MUx6WlhqaTIxc29wUlJYd21hMURaNTZmU2tw?=
 =?utf-8?B?OGErM2I4aGFJU1hUdkVnSjJMYVIyYUdiV0tLOXFJY0UvYTRDRi9laElWVFFh?=
 =?utf-8?B?MzdVSW1QenNqS0FWTEZpMVI4SW1GenpLVU5oOXowMFYzMkIyMXcxZXA3ZzlB?=
 =?utf-8?B?TGR0YXBjRWlyRVJVSTFJZUUvYUdKUWVGZytDRVpHeU5QZDVjM0ZKeGd5OENp?=
 =?utf-8?B?R3o3K0lNend3cXJDL0xBUTZnbGhab1Y1cHJJTk9RNUMvTml3OFoxelJFQnlZ?=
 =?utf-8?B?bmMwdTV6S1kzdURRYVdyb0lCckErTmppMUExSlhGdGdla2JrazFrbWhwbjc3?=
 =?utf-8?B?QnVlL3JmRXJXRm15dEMrczNiQTZqak9aVVhsN2UweVAwcThSb3M2THlzYTJj?=
 =?utf-8?B?WUVrckVHcE1hZVdLR3dZVExkbkQ1SmlvSzlaLzBpMTVPZFgyU29SS2U0bEtM?=
 =?utf-8?Q?nvA0BLKhFTY+bB+yqRwpPbf/8x2gAY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um1RV1Vjejgxb1NFN1RFVHB3eUVmcVFmSCtBSkRkMXM3ZVZuOGxCL2JxSjM2?=
 =?utf-8?B?aE9tdGZxcm5tZTZ0MHhRbjdIcjA2alo4ZlJNaWdLbVpKK3JnRC81R1ZFQ1p3?=
 =?utf-8?B?SVNIUksyUFNhTG9GZytpeFJTbDhTZU04R2xrNm56LzVCajZ5Ri9iSVRsMjVo?=
 =?utf-8?B?UWhVVnZaL0ZYSFZMcU9rSVRnK2w4K1NaTUNoRTdKa1BodnhUdDJtc3Y4Q0t2?=
 =?utf-8?B?ZTlvQkFHRDhPZmtuMi9OL2M3SGpZVTViVllLdEFaa2E2YUdJWEFIbHdXWVpq?=
 =?utf-8?B?cUg3UmhXYzB0MFpvUzBqSi92ZGt6S3hER2RpbThNRm00Tnpwdll4dHo2MnZV?=
 =?utf-8?B?b3kvdjMrV3J3Z1FrdVQzUVA5WFl1ekVKc1diRFdnTzh0SmxoNFVzS0pseFN5?=
 =?utf-8?B?cksyY3lybitOK21OWUdTVklWcFJIUnh5ZFBUeHVCZU5IODBTSmthZGRRQWt0?=
 =?utf-8?B?ck13QjluQ2dna0pqOVphMkk1c1BjYUMwdEl1VkxsbXRjbHVSRFFoWnRuRDVR?=
 =?utf-8?B?Y1NqM3YybnkyWkhnZ0dVcnJsT3pqbENldWplZFdieG9Xdy9ENTl1WTVodzlj?=
 =?utf-8?B?NWRLdEQrREFiaHhjWVQ2eERtUk5FK2FFMHcxcUFnbGlteVdnOEdIdnR5NGxY?=
 =?utf-8?B?b1JIemhBenJBNW5mcUJ2VUF3d1dHeC9iNFRFTXZ6TWM4dVQyYzliVGZleG1K?=
 =?utf-8?B?bGVjSkVtQ29RQ1hqV0VLUDdmRS9FT2I3QnBYVlVFd2dsNndzY2lZVUZUaGpv?=
 =?utf-8?B?SnEvMmVrK1gyYko5S2I3OCtuU1dOWXNyTUtDNG9MU0ZCNnhUdnVVY3B4dHV4?=
 =?utf-8?B?ZVRHdVdwMk1odkhsQS9sVEhEdHdvSmNOWE1qRndxZExKRmhlK3VEd2REVm1U?=
 =?utf-8?B?TnRUQmNwSjdJdXBvRmltT0c5T1BCb2JmNWVvQkdsK2htb1EzNG14eGZDYzNR?=
 =?utf-8?B?UUdkWXNDeDN2a0picXJvaG4vOFR0c1JBZmxudlNUU2ZER3VPL3ZpNnpxeXN3?=
 =?utf-8?B?K0pib1hmTzJXbXJFVkNJSEhibGN1WnAvMmFjQ3REcXYxWXdNNlBGNlFScmE3?=
 =?utf-8?B?cGphc1E5Z3g1Y3V3SDRPSU43TUJwQUxXNlNtOUVwMDFXZWlsdkZvK3FaaGN5?=
 =?utf-8?B?Rk54aFNWanp5ZVFTNWhuRkUvV0dEeDZZT3ptOXA2eE12SzZMSnBDQ2xXVlli?=
 =?utf-8?B?VndOMStZQXJHTTIvK3E5OG5idHZhYW8yc0Y2NWREaVFXUTZ4bUFmeDdJVUtR?=
 =?utf-8?B?cFdPQXVPZkxJSVBVa09hUVFUL0Y1SmNDVVBoL2dDNFJVM1M0RWk0cnB0NThm?=
 =?utf-8?B?R2YzSU9oZUsxWEhrV3V2ZEM0MEdsR2R6UGduRDVNKzdCU2ZoaWlkclp2WHZa?=
 =?utf-8?B?d0txYkdqaG44dm9XRjFUVXNucUdxanAycHNoWlVuRDc4T0pPOFJzNTZrZnB0?=
 =?utf-8?B?ZEJmZGZkdHdDWEtSbXZoU3ZZRUVSc2w4TXJFbis5bGo3K3NYeDRKaTZDN0cv?=
 =?utf-8?B?Q2hwa3ZsQytPZm50d25rK09kV0FkZnNDb0dRK0ppNXY5c2MrdTRsL3IyekpT?=
 =?utf-8?B?Uy95eHhUTm1zYWhSR2NkQTk4dnBSWXNiS2ZFQ05oNVhaTnQ0NXBjOFIvaWMz?=
 =?utf-8?B?b0FvLzBpbUZtbnNZSUUzUnkwQVZJMWtrZHpqUytEU0tOem03VytQL3R5c09G?=
 =?utf-8?B?MXlOVHBQS2R5d1MrTkdJTklNSTVEVTkxU291ZHM3SjFVTjVEZkhxd3pGbmwy?=
 =?utf-8?B?MEVTRjlEWldzeldxTTNkbTVyWk45UC9sUEJCWEJTTFhhK2wyNmhJVlcvRFlq?=
 =?utf-8?B?d1VqcUtMclU2a2JRQmVXMjdORW1lVXlGNkpZVlhpandOUklwc0YxRGUwME01?=
 =?utf-8?B?SDhVZXpPeThWM2YvZy9Uemphd0NqRCtFbHBRNTYzK2ZmSVNmd28rQXhLQjRW?=
 =?utf-8?B?YTNuNkFoSk1tTnhoVTc5VEt1ODFGODFUb2VCS2tHZUs0dWpFVS8yTGVQQXdY?=
 =?utf-8?B?TWtUc3lQeS9SQTlZekRBQi9WaWRoRVBGV3Jtc1g2aXJjS1YzSnZ2d1VFc29R?=
 =?utf-8?B?bjVMTzc0Q1dIWmU3elhOaVVJdUNzelMyM3Y0UnRKWGNKeStuUGpMWUJYb0xt?=
 =?utf-8?B?anNvZTFEL01qNnNOcUtEakQvOGtBRTdUNm1wbFZySGN4bmhQZCt6Tk55aSs0?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens-energy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d680cc90-9b19-41fb-8e6b-08dde1739fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 12:01:27.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 254ba93e-1f6f-48f3-90e6-e2766664b477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gwwn4/QjyXlglgW6LBuwYPWAqQN5bgxSn5eIUd1oyXoobHUr3H0YJaHDNmr8p9aN9juIMbeAja51FNQTby4HoA/CgTbkAZ09qJ04PRK8yj1dTxEDCP1c7VoCUF2Lq84Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2672

VGhhbmtzIGZvciB0aGUgY29tbWVudHMgYW5kIGV4cGxhbmF0aW9ucy4NCg0KT24gRnJpLCBBdWcg
MjIsIDIwMjUgYXQgMTI6MDg6MDBQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+
IE1ha2VzIHNlbnNlPw0KDQpNYWtlcyBwZXJmZWN0IHNlbnNlLg0KDQpJJ20gZ29pbmcgdG8gc3Bs
aXQgdGhlIHBhdGNoIGludG8gYW4gYWN0dWFsICJGaXhlczoiIGFuZCBhIHJlZmFjdG9yaW5nDQpw
YXJ0LCByZXdvcmQgdGhlIGZpeCBwb3J0aW9uIHRvIG1ha2UgdGhlIHJlZmVyZW5jZSBjbGVhcmVy
IHRoYXQgYW55DQozMmJpdCBhcmNoIGlzIGFmZmVjdGVkLCB0YWtlIGEgY2xvc2VyIGxvb2sgYXQg
dGhlIGNhbGwgdHJlZSB0byB3aGVyZQ0KZWxzZSBjbG9uZV9mbGFncyBpcyBwYXNzZWQgdG8gYW5k
IGV4cGxpY2l0bHkgQ2M6IHRoZSBzdGFibGUgbGlzdCBmb3IgdGhlDQpidWdmaXggY29tbWl0IGlu
IHNlcmllcyB2Mi4NCg0KQmVzdCByZWdhcmRzDQpTaW1vbg0K

