Return-Path: <linux-kernel+bounces-781430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67CDB31265
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6733C3A7797
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F91FECAD;
	Fri, 22 Aug 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=@siemens-energy.com header.b="uHP5ho/8"
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11010020.outbound.protection.outlook.com [52.101.171.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9B2EC569
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852758; cv=fail; b=RuiULscoUWbDlUbj24cHTwUtlgzM+kz8RTuG5mL5yiv0Kyfz43+OkVU+otlAFqlKqn8bMDdioA4DZbojwitzgZqEVdZdKhlU8rdbbJ+6ztP9HZOE0ByUCliPp8N0NAIItw5AMIlEgYwDWtalWUEB9YfrN2VuIofDewGMvtJs+Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852758; c=relaxed/simple;
	bh=tLqW/vX/eYSQIbKQAPPB1O4CVcAsXRnCpEGVpaUfNvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiuHLgFTByzw/MhqfZWQDEEnT1visKwuGe42EY+hh1aPnbw73RM9kbbr82w9m/zX+D6/9CManmOoa8YxzUKivviJBuBG/MmZDFWoOp4WqMReWR3nBUbD+jVNkKDhXSt0bspqLD/Usx4UV78hKTDCep+fWhBaRNqBpiif80cg+rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=siemens-energy.com; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=@siemens-energy.com header.b=uHP5ho/8; arc=fail smtp.client-ip=52.101.171.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens-energy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUXGtg5+iIfcX/2EM1q/ydwfoE5694Av/kKIBc/rzllOEEaK//G79q9BwCDGNyiUXB/zqhOeaR9OiwYDwXJLTl7fRDfbjF68f8Vb2kCx3XZZBadGtPgTWHBdG+izvaXyDke+C7ssgQveJHr5VURsD1h+6VaU8+UiRcVvSslyE9DVLzYefOegJ4qGkagyuqkaeFKc6iZlIg5AJlvgs3mBl33DpcGqYrK4/b8lzTy7EQ2cgnGdkqkL6tNsnM8sLjOujcytJO3Q/Ff+OL7Qvq/u6VaiZZPyk8KW9HyIqwZ56up7q2+7FwH8h/lqWXooTAAg0VB5GE12jyO3CnLcx4SzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLqW/vX/eYSQIbKQAPPB1O4CVcAsXRnCpEGVpaUfNvw=;
 b=pfTNX4cuRT25BDQjQpIGHE/X9Tx/TAbGDMGpPeW2F/SzIuJ2yISEhNqj5HoBgXtwtj3apaj+MilC8xybuCqyVyY0qsaNcdMlrs8+pwPlpcyy//mpQGLkJRP9iIsmoYLoQeTksH+nZrQElo3sq6WnuqCJFmg9o/8BGFawgQEY/myeP0wZMdbkguqQb7j1uVPukAEz+ojUGobeognpzXvz+xlCRPNlosVmi6vkcVgjppNM0qnHGNUMMkSfKBXF5Q0+lslepDe0Ru5TnDb/pii0YrVnV74ET/O6zomm3e6blMwZIDkk2elMUq9RFaNuUnIB/EtxhWU/X/M+hoSHGB0J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens-energy.com; dmarc=pass action=none
 header.from=siemens-energy.com; dkim=pass header.d=siemens-energy.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens-energy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLqW/vX/eYSQIbKQAPPB1O4CVcAsXRnCpEGVpaUfNvw=;
 b=uHP5ho/8K1ugs0UwLnSGT2bSbKVXRjvSgjBpgKjQuDpjJcB0/a/yjGJO9JvedDxiEBbr9bo5UgsUoD3WBYB7u3jTIzlw1qtEZqtCog5nCdEppXl7M6rUMWTZ9Njsu1cyY/+KGCazlQLrt/AiznMpUdK2726AicjNaWqqx/3rx06Qg4fI+lbd35xkuTYMPtz9XyfOT/FwLe8p1UyyW4HQTtLeLxrkq31hjAn13KvtbfjORboxSgPJm776K2HHKN5wFSWQqVJr93MHK8dcZW84wa5tC9MQZbbPAaAKQpH6TUTKSoPOrhFhSVRbH3nfnbFmIgqEd4MTRRQXfxQQfTGYbw==
Received: from FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:91::10)
 by FR2P281MB1768.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 08:52:30 +0000
Received: from FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5233:e398:feb8:a20e]) by FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5233:e398:feb8:a20e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:52:30 +0000
From: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
To: David Hildenbrand <david@redhat.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Christian
 Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
	<akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Thread-Index: AQHcEo6g5ujZ/0rMIka16XkPmN24cbRtnASAgADDDWA=
Date: Fri, 22 Aug 2025 08:52:30 +0000
Message-ID:
 <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
 <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
 <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
In-Reply-To: <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_ActionId=efdb3f77-d482-4c35-ad16-2ce44847be96;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_ContentBits=0;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Enabled=true;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Method=Standard;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Name=restricted-default;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_SetDate=2025-08-22T06:58:45Z;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_SiteId=254ba93e-1f6f-48f3-90e6-e2766664b477;MSIP_Label_36791f77-3d39-4d72-9277-ac879ec799ed_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens-energy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1544:EE_|FR2P281MB1768:EE_
x-ms-office365-filtering-correlation-id: 2ba831a6-a5d6-4803-7347-08dde1593a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFAzeVZ4bzVvMWZ1bDNCNmVDKzhkUTJraDNGeUp6aXhmTWtMWUpySk1RdU12?=
 =?utf-8?B?VFpRZTFnMzhGTWNtb3k3d0ZSeFMrb1lwOUVaMlFuN284clZ0bVIwZ0I5b3Jx?=
 =?utf-8?B?T0Y5YnQ1S0YzTnkyS2ZNTGZCVFdJdXFUOWhnMXhlSjIvazhpODBCb3ZUQ2Zx?=
 =?utf-8?B?VWpQdTNuKzN5MjFNamlXaUNOQ1loSXJjNGVTNjV4cThocExnc3hJaTBYMlIv?=
 =?utf-8?B?YTFDa0NVR0Rsb2dMNXNBUzBBYmNWQmRJZkdpS1lseVpnUjd6cGc0a0lKWHZI?=
 =?utf-8?B?TldDN1BUc2Q1emtHVEVYdjV4VW1ZSEZtRWc2UWVvTVFTZGhnOEUyOW9xQUZZ?=
 =?utf-8?B?eWg1VDh2d0ZDcWJBYW1zejNCeU5GUU03YmJaQUNaaE94Yk1UZy9oNVNza0NG?=
 =?utf-8?B?OE1UUk9RS2tpRHlpcmc3NjNESTg4TjZ2dVg4bFZWOXpVM2NmZ3QxWXVUNVVE?=
 =?utf-8?B?S3JvdzNPQ0FYazdXZG85RWpMR0UzSm9TczlDbmt4UVMzRVFJOFUxd3JoRHIv?=
 =?utf-8?B?eDIxTld3V1lBWkJ1ZkdYakNMRzV6QzlDVzhsZUJvV2ovWENCMndGQkhVWEY5?=
 =?utf-8?B?VXYva2o0SXAvU1FzNXhWOEdraXV4a3lYYytHRmRFdHRNNGl4MnBKb0oxVTZ2?=
 =?utf-8?B?Y2FNZzlvVmhsaThpbW1XcXl2Sk85NVM5MndvanRrWXlYZU03U1QvMDczU2RL?=
 =?utf-8?B?OE0rYXlmOWs4Slp3VVRDNFgzb2JkTDVEUlcxdVF4Z3BJc2w2Yk9GKzA5WENi?=
 =?utf-8?B?MDVnQ1luTE9LMElMamRHVXFRaTExdnBhbmlrUjJNRG8rd1dreFU3NElub21F?=
 =?utf-8?B?cG84d05QRW4xU2dSL1VwT1NKMklneXpwdW93N0dZc253OWJERFJtbmlUSkpB?=
 =?utf-8?B?ZTNlNEtjYWcycEM5VmtmUWpsR3k1WURYWlVMeTRjN1ZNeTNMQVZJSUVNUm9x?=
 =?utf-8?B?UW93L09QU0xmOUo3SktQSWgrVTVWUGx2dWtnTTkwbkp6VXlZSElHd0J6dlFh?=
 =?utf-8?B?YzQyOEVkN1NVZHRiWnl4OHFiZitxZUtka0VZOFhtSHkrMlY0WWdlKzk5eHNj?=
 =?utf-8?B?dElyQ3l1Wms3ZTVyb3Z2YlhMK2twRlBFS0dFTG93WHVzN0RYTjB0a3NSYVFv?=
 =?utf-8?B?ekZDbXgvOWRSMExMeVZlQjJFRjZPTzIzdzl6OGlDcHRHZ21jdDd3N0F0c3h5?=
 =?utf-8?B?OTdSLzlaaFY0UDBEQkdtRlArem9YWUdsVldjZnZwaldEUTVESDJvNW9BM0M0?=
 =?utf-8?B?TTJmcC9rMjg2MGJubDREV0NFdlhqdUlwT2poUEMrYzdCSkJuZU9RZUtaQ3BK?=
 =?utf-8?B?RkMyMUZ5ZERsOVVmZkxZUlpBWld6aUdkNnI3RUcyMURJK2VuZ3FJMjI3djJZ?=
 =?utf-8?B?TjhlODU5OWl1UDdtSS9zWW1qNWlLOXBxVEhGWkxpTGJPWDVOOHkzS0huTUpH?=
 =?utf-8?B?UTlsMHg0VmZIUmJSbUhyRG0yWTBNS0NqNzE3emNuVzBuaEphTGY5ZGhJR0x4?=
 =?utf-8?B?YTdzaXdJcFR3WXEwSXppSEljbGpyZDZ3OTJYL0lVK0ZKN1pFaGNsYUFMTnMz?=
 =?utf-8?B?cUNReFY1enBCS1hMM2VVcTI0bEo5UUd6MUJBb2Z5UURBVi9BY3lXYlA4cE52?=
 =?utf-8?B?UjNtNXpCaWVGLzRpcTdkNkVQaFlwN2RUTUdRUEtZUlRnZW40UUQ2Tlc2N244?=
 =?utf-8?B?Q3JUbTFvdXIrSHRIZW9HWVI3bEdWNnExQy9hQmtrbEU5T1c4WkpELy80UVUz?=
 =?utf-8?B?UnVRQWNGN2QvendMcnhjTEw0WE41bnFoZnJ2dTFFSFdpRDVlazZkQnBOeEJC?=
 =?utf-8?B?bHAzdlZyOTJhQ01scVkzWjZKS3R4OHVadUwzb09kanlLVWEyWFR3c0NwTE1u?=
 =?utf-8?B?Qzc0U1EyZTZsV2F2SmFVdE00Zk02YWREZ1pZZEJiVUZrYlFKQ0QxOVJGajRy?=
 =?utf-8?B?TDlHSjFuUEFORlBiQXE2WVcxQ1JyR2NiSUVKUFZwNFBzNlFFcmhqTHF1RVEr?=
 =?utf-8?B?T0h1bTJYNE1RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1hzMXRMSW9YQndPeEpEOHBkUUIxemlZNnZuRDUzM3h6eVVVNWVIUElxMWVp?=
 =?utf-8?B?ZWdYKzFOS29Cd0dST2VneEowVklKQ2pOS1FjTXJxd3Y3RTRLMlVrMWJFdEN5?=
 =?utf-8?B?cXRMMmZYSlhIeVFMK1FiSXZRNGdGUTRMa1VmdHgvVW4zczFIVlZZTDhCc0xq?=
 =?utf-8?B?K2hTVE9BeHI3d0FHc0w0UXBweVJxK0p0Ty9raWZpVkFjQklVWHZsZ2VDZDJI?=
 =?utf-8?B?blNmdFlpTnI5SFpvYUZiQUc5VThYakE5VkFQNU5tNTNRQVFDWEZEc2NCNXpI?=
 =?utf-8?B?NTJJbSt1dzUxVCtoNXVUWG1QQUpMQjNzL2ZnZVVUaHdnUVZxVkRTNlZuV1VE?=
 =?utf-8?B?b1EwdUR0VHpqbHI1Qkk3bjdwaCtPSytDdkthNG5udlErVXdSQjhsS2h4VlN2?=
 =?utf-8?B?WVV5UzFMencxMUtFL3VkN2RLRGRsWVZneVhiY21jZ1ZPL2VEVzh3eGpQMTFC?=
 =?utf-8?B?SFc1ZTZMdm1GcEZSbHc2VkorMFplc2tvczdUSGZwKzdFczdtbURkV3NMdk5Q?=
 =?utf-8?B?bEhiNmJ4Q0tPdDYrMGNjcy8rVUh4VHNMMWJsTW9oVUhDTlZwTkhMdnducGhB?=
 =?utf-8?B?ajRnRS9keXJ3VHNCUEpBVG9ReUtLV1gzcE1hbDl1ekJXbUVJRHpmSWxuUkpG?=
 =?utf-8?B?L0pXbEM2WVZpaDlkQ0dJWHZGSEk4UEhvSCsvR2trenpybDBQZk1Lc0dmcmJ5?=
 =?utf-8?B?WlhlMVpkckFrKzI4anI3MjBkQ2R5S01tblM1dytRRDZFeURQallQRktpdyto?=
 =?utf-8?B?VXc2eUROUXc0bm05eXVKQzduRXkzeis2OVdZYTFDeHZmQUhqVGxUUk9ZaEtY?=
 =?utf-8?B?RXBUZ3d3UXZ5blJiVlFuZjduNXd1LzNzTUltRVdsVGJrV1JDOUpGd3VoMmsy?=
 =?utf-8?B?dS9lRUk0cjBveE5kRVhUVXY3U3ZNdkl4ZzlzdWoxM2ZSZUZtMVZGWHVnM1lL?=
 =?utf-8?B?bWtLbHR6aUFmc1pMUnhDdnVJOGtxU0RGWW1CTmFQTkRHWGtmRFBycEFVdWI0?=
 =?utf-8?B?STVWcXRDTW5KRmtBWjJOVWxMMUttbTY3ZDN6a0xraWJpcHVCdFNablh1MVZL?=
 =?utf-8?B?NHVTaDVwdkJCWWtXUWxSemFhYlZaTEowN1NROElZY1hYUUxjS0hvM3RleVk3?=
 =?utf-8?B?YWowOUJaVTBjckRFQ2FFU0FEVVNqaE10MjJ4UHc3eG5UL3R2aVR0RjRIeVB0?=
 =?utf-8?B?ZXVlZE05a01LS2ZTb2pweTlPUXRqK1gzT3NoY3B5cGt1T0FlQWdCVERqMm4w?=
 =?utf-8?B?TjVRRmRoZjViV3paVGxZbG5oVnBFTVZrZTJtYy9vK20vcG4xd0E4UXN3anBT?=
 =?utf-8?B?Rk5UdmFWS2RZaHRCU0szOGEwZ3lUZmVmNENoRndIb3Bmbkxqb3JGQ1hTakFi?=
 =?utf-8?B?TzljUnFDV1QzUDVjV2lNbCtiZlA4ZkZtSGd3RzEzcDEzcjYzMHFLcHN0N2Vj?=
 =?utf-8?B?V1NZVUlPTTd2dVVBQm5TRGNQNisvTkpSMGg2SElJdW1oRGwzWDBKQmozVEdZ?=
 =?utf-8?B?N3pYMVNzQ3dmWThrNFlhUWRiNVJvYnVwZGtJblpBdlFURVNVZ3Zlejkxei9S?=
 =?utf-8?B?S0tNT21tMVEzZEE2R20rYTloVFk3S0phaE5PWmpHRS9tVk0xTnpUSGlCYysw?=
 =?utf-8?B?Y0VvRGFDVGtzUktEbGlWYjNUTUdyV3NzRlVnMkRoazY4aGtsWkV4MmFCWTIw?=
 =?utf-8?B?V3BqY21vMWxtbFNJVTBVU2R3bkxqWE1UQ2Q1Q2JJbUdqcmp2YTNHSWwzbjZH?=
 =?utf-8?B?NVNhOTY3SDJFL0I4a3duVWhiNGd0aTFKZ1hhdmhtZmZhRWdWMkZDemgydTA3?=
 =?utf-8?B?SkRwSC9ZOXBoLzdCY3FNSWU4bGdLZ0ZsdU84WXMwTmcxSmpQZ0hNcWRqaTAz?=
 =?utf-8?B?bG1yVVNqcldPaVRLaDdaSGUzd29zb2lCemllMWd2bStOY01ydDNkbHJJTEdm?=
 =?utf-8?B?SUI3ckJtSDRFZUt6YjNzUWVzaXUxYWNjNjZ1dmt0QkdpSk1zS25pK3hGYTlL?=
 =?utf-8?B?dDJFRG1rSElQdmJ2K3NSbVV1SVlZY1QvM1NVK3M1ZXpSMlNkQ3hVaEZMZmlu?=
 =?utf-8?B?OXdPMTJzRDRReGhMeTZEYzNjeFNIMndoTmM1R04wdWw2YVBrb256ZzZzN3M1?=
 =?utf-8?B?UTNhb1FCTlFGQTdXMUJxVi8zWFprN1M4VG9NOTZpNnR1WUFVY3VueXA3Y1Vy?=
 =?utf-8?B?OEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba831a6-a5d6-4803-7347-08dde1593a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 08:52:30.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 254ba93e-1f6f-48f3-90e6-e2766664b477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chDnJWhjineV8+GHami9Cx9svUCErKFZ3/LWegBrOgIDk99bcsUyr6pTN7KXvckBlDSUlr37o/dzlaLi6/tMAa/fj35b9YYA/iBVp5xTzmqNjKetIjjvSB569qVX19ZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1768

T24gVGh1LCBBdWcgMjEsIDIwMjUgYXQgMTE6MTQ6MDBQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IFNvdW5kcyByZWFzb25hYmxlLg0KPg0KPiBCdXQgaXMgdGhpcyBhY3R1YWxs
eSBzb21ldGhpbmcgdGhhdCBpcyBhbHJlYWR5IGV4cG9zZWQgYmVmb3JlIHBhdGNoIzINCj4gb24g
b3RoZXIgYXJjaGl0ZWN0dXJlcz8NCg0KSSdtIG5vdCBzdXJlLCBidXQgSSB3b3VsZCBhc3N1bWUg
c28sIGFzIGUuZy4sIGFyY2gvYXJtIHNlZW1zIHRvIGhhdmUNCnN1cHBvcnQgZm9yIGNsb25lMywg
YnV0IGFsc28gc2VlbXMgdG8gdXNlIDMyYml0IHVuc2lnbmVkIGxvbmdzIGFzIGZhciBhcw0KSSBj
YW4gdGVsbCBhbmQsIHRodXMsIHNob3VsZCBhbHNvIGJlIGFmZmVjdGVkOg0KDQokIGNhdCAvdG1w
L3ByaW50dWxzaXplLmMNCiNpbmNsdWRlIDxzdGRpby5oPg0KDQppbnQgbWFpbih2b2lkKSB7DQoJ
cHJpbnRmKCJzaXplb2YodW5zaWduZWQgbG9uZyk6ICV6dVxuIiwgc2l6ZW9mKHVuc2lnbmVkIGxv
bmcpKTsNCn0NCiQgYXJtLWxpbnV4LWdudWVhYmktZ2NjLTEyIC90bXAvcHJpbnR1bHNpemUuYyAt
byBwcmludHVsc2l6ZQ0KJCBxZW11LWFybSAtTCAvdXNyL2FybS1saW51eC1nbnVlYWJpIC4vcHJp
bnR1bHNpemUNCnNpemVvZih1bnNpZ25lZCBsb25nKTogNA0KDQpJcyB0aGUgYWJvdmUgdGVzdCBl
bm91Z2ggdG8gd2FycmFudCBhICJGaXhlczogIiwgb3IgZG8gd2UgbmVlZCBhDQpyZXByb2R1Y2Vk
IGtzZWxmdGVzdCBmYWlsdXJlIG9uIHNvbWUgYXJjaCBmb3IgdGhhdD8NCg0KPiAoSSBhc3N1bWUg
YWJvdmUgb3V0cHV0IGlzIHdpdGggcGF0Y2ggIzIgYnV0IHdpdGhvdXQgcGF0Y2ggIzEpDQoNClll
cywgc29ycnksIHRoYXQgb25lIGlzIG9uIG1lOyBJJ3ZlIG5hdHVyYWxseSBmaXJzdCBpbXBsZW1l
bnRlZCBzdXBwb3J0DQpmb3IgY2xvbmUzIG9uIG5pb3MyIGFuZCB0aGVuIGludmVzdGlnYXRlZCB0
aGUgdGVzdCBmYWlsdXJlcywgYnV0IHNvbWVob3cNCmRlZW1lZCBpdCB3aXNlIGZvciB3aGF0ZXZl
ciByZWFzb24gdG8gc3dpdGNoIHRoZSBjb21taXQgb3JkZXIgaW4gdGhlDQpwYXRjaCBzdWJtaXNz
aW9uLi4uDQoNCkJlc3QgcmVnYXJkcywNClNpbW9uDQo=

