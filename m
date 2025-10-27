Return-Path: <linux-kernel+bounces-871746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92486C0E3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B2E421A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4224307AEC;
	Mon, 27 Oct 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZHXls19"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D02874FB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573406; cv=fail; b=E95QDiaceuZ3n9Ps1y4UXi/yETpX1/j9heBveHAvjtSdZEcV447jzYLkOp5/xt6YPCwNS8Kgj37CXdU4ph0v/1cMP0/MeEfYp8PmZ/6f1RNLrMzl6vDlvlINk1yDR6qZm4yUYT05EpQsjkj7IDf17bpGe4WDwQZFAgf1+At7nvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573406; c=relaxed/simple;
	bh=ljU4WOr9LQS+FjiUpd8E1WAzDSdQLR4PE5uNlNFwm+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2uCK+Y5tfK8woqeI/MAEFEb1vAR+ZCkK4FiDBggctcidSWMSduYT4xL3HYMoWE7Y9derlho3b4/NM89gOagP03iWI6Q2XmKiCZoJ+BQmu2ZoYRaD4Fy+tsjkspW+H+dNc0JeyPD+O/fkDo2U1pyKteyDJ2bU5BFFfw/E/T9XDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZHXls19; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+t7Sk1xGjaduw5usT3BqvYA9fIh4YSqTjhGPgmdUFJDnfZogMEjnwiOuAyneVp3J9AcJ3bSd0bHXW3FtdgmCc813VGfaxW41pAzmPh47oJ2doQEN610aO8YNhNBuZTUGHdWzol4BVAYfDILv07kltaH4YHHuELbbd00AJGDYkN/llQMUmeQvoCRqjI96ZMvgpk7k+rUeNAge9q68CYqasLQrTSOlXxL1SwjY3BbNMdbeEbSesT+eZ0OK9C+W5TsJ2wel6fr1z0yfOYEc8LPIrJyZ1ClN6gxUZzJmDrrANpBQRZLtQGVyJnCDk6GDepizpEC5zyW/VqEMVj2SyQ3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljU4WOr9LQS+FjiUpd8E1WAzDSdQLR4PE5uNlNFwm+c=;
 b=JuGkq0CT0fBrN3WZ1ncnHGtpGg0WI15w8g0EvhbUmVEsDEkQoaljooRMAySpa6fOWGz3lK8L2JFzVXDkyotMeNKgDz8yjUNh78zaHayUbiHGCZqVqVpM02Cn/82+nBfTFW9a4i1sufnvfBKpjvIoJ4ySKIxdqJDFBK+9vfp6hUnAlN640k4KKNHNGqhRnDyVFWrDLB04hz7akYF24of77gqF9WDlNZQEIMpERqBUnN8iifweaFWBlPU2BFPnDlRJuQFmjC4b9uuinYTWsZkimrepqQwa7ghUUEHtc5o7nV3pwNZQR22bb0xa9554k4SWhYic9r7Sl/qeMlUpaytg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljU4WOr9LQS+FjiUpd8E1WAzDSdQLR4PE5uNlNFwm+c=;
 b=QZHXls19CV2EbSYp29o8bSDyg5KyKCVTKVOhuw54mqPh1+U6esB58v2gJgi8yWgrL4i76xxwkmF4HRj8yG59tzkFJ8w0uaiTL2B/uhuslA7d9X74dZesrkQfp7rguqUIzh6a1xvNHKuTa1C0y8n2DEzokIl0kVlZb2vIM0JjX0s=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 13:56:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:56:40 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 52/56] x86/bugs: Support parsing mitigation options
Thread-Topic: [RFC PATCH 52/56] x86/bugs: Support parsing mitigation options
Thread-Index: AQHcRzU79PUsP8XVakC2b/0R2Iq7YrTWA7IQ
Date: Mon, 27 Oct 2025 13:56:39 +0000
Message-ID:
 <LV3PR12MB926557B2FC8316392BD5B96994FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-53-david.kaplan@amd.com>
 <23c26b13-f195-4363-bfc1-92282459f1bb@suse.com>
In-Reply-To: <23c26b13-f195-4363-bfc1-92282459f1bb@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-27T13:53:21.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SJ2PR12MB8829:EE_
x-ms-office365-filtering-correlation-id: e5c0c090-b854-4776-c960-08de1560a734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXFheFBBZmpRRkd6Tk02cktVck9WbU1NdHBjWDZKQnl3TXR2ZVFzVWJYcTBj?=
 =?utf-8?B?VFdsYXlhdHlqYXJMVWh2dkJtZkFkbkN6cEo1UFhFSHRGZS85ZUtkQjB4NDRt?=
 =?utf-8?B?TlJza1d4RllLY0VodWdzTnhFWmxyZ292TkM5YktRdmZuOEJ4SHhMSWhUZFhs?=
 =?utf-8?B?TUYzcGhRMlpITnl0LytJdjR1WlFRL1BSNXpLV3JDcG5CeUdyclhXdDJpbkNQ?=
 =?utf-8?B?YmZsaCtuWUFzR2hwSkNhL3BodVBzYzFPQ3NBRGNXMEJFS3JzRW5MTHUrMDZm?=
 =?utf-8?B?ZzllblczYmkvUWMvMUxRd2ZBcE5TaFg2RXk0bDRLdDA2bHovdCt5OEVDWlJh?=
 =?utf-8?B?NjJ3bVhzZ1ZnUkwvbDRHdzJDc2pSRldXYlExTnBla1pzVE84b2FQKzNJaUkr?=
 =?utf-8?B?eXdRK0NSbGVBTjJ1aUdzV0NjMDB5Q29tQmdvTUQ1TkU3MDZseXJodXJUVnNs?=
 =?utf-8?B?KzN6cGRXNlhhUTdpZUR3UE1ZWGdzcjVtL09vU1V0ZW5IMmZNaE5iTTlRUWhY?=
 =?utf-8?B?YmhCVFduMmVFMnRPOVIyUVQ0NkI1YVFJakZiWVBaZytLSFRaNnZGcG9pZ0dx?=
 =?utf-8?B?MnVtNkozM3ZwQzVTZmJzWjJBSlp0UWlvR2thWUpJcjdsNS8vbU9rZUpydXd0?=
 =?utf-8?B?OHYwNENNbHVxL0hqenJKSytQdnZsK1FaM3lvdmxYKzhqNVV5N0t5amNxd1Ro?=
 =?utf-8?B?VGlOakdLd1huTUdIVm1yOENHUnZvZlJJdWhQeFFSd0Q2aElwL3VNMzNpUURk?=
 =?utf-8?B?elJJejdxZUNsbVZjdnVZVldTdVJyTVpiVDBzMnNacFlncTNwejA1cjR4N1hT?=
 =?utf-8?B?aEl6cWs4NzZwWmRyZW5jYnI2RkJHYnBVN0ZrQWtxbzY1eGQxUy9BRTNRamNp?=
 =?utf-8?B?bTNzQStha3hOVXp1Z2IzZVp5MDdWWmZOZ2hqOERWZ0FhU3E5UnZMbjE0YkFW?=
 =?utf-8?B?bkk3WDdBODkreURBcjdhK3BENHRsc3l3cHZta3RWRVRmTDlmcCs5bDNrWXZv?=
 =?utf-8?B?WUdEL0N3TUlBRENkZm96ME9BcGVobVlFa1l2NHlnd0dsVks1RXNpbDk1cFBi?=
 =?utf-8?B?L2NoWDYrbEZvTDVFVm1aM1FiakNrMFhJem40bENYSXZjdWxvc2tvS0Z5czdn?=
 =?utf-8?B?MVBMRVVrK2xWTWsyUnFHOVdTUjVZdGVIVkJHWnRrUE5qUzRJY1ZMOU1qRjR2?=
 =?utf-8?B?a2xZREdmRHNQRVRBcWY1RTk1NFdTamNmMFM3amxnZzVLQWI0cXdhdEROM1VP?=
 =?utf-8?B?RVJMSEs3L0MybHJjWGx6RzN6R0IzeVd5ZTBEYm5qYlJ0aCs5REQ2UTFBbnRo?=
 =?utf-8?B?REs0OG9XaG9NaWhkODJPUHFvcG5DN0t5cDh2VUIyeGlPamJuZk1jZFJJUVVC?=
 =?utf-8?B?WlNjcHBDNGxpOHUrSWdIVUxCbXZTb3FIbEd6VUtsMVloYk9temJEektIN09i?=
 =?utf-8?B?RU03YWFuSFFSeUR6bHA2cktnRTE3R2t5QUdiZDFCYk9lVEh4eUtEMFV2SnNh?=
 =?utf-8?B?TWFLekUzcE8wcVh2QlI5MmJkeVR4UUdNOGJWZXdMTG85NGxSekN6OG5qK0Iw?=
 =?utf-8?B?Z1Vra1ltNHpvYTlCWU5wTjNmWTVSVmdSYzUvamt0WURmdUtRRjJiQzdDcnNQ?=
 =?utf-8?B?NVlKT2RhYVpEbmowc0Z2aTd0SlFzL3UzT3M5ZUdPVUZ1aEdlc2Y2WFYwT3RO?=
 =?utf-8?B?bDcwVVNsM1RNY05DZW5OVkhLSUNMb2dOcFdla3dCUU9pSUg4VCtDTVB6TjJp?=
 =?utf-8?B?eU9nbFp2dTJsa3lPdnVQWTFjMG1IWGU1dnd1dHBCOTlWR1Y2d2RGZ1hzOFN4?=
 =?utf-8?B?NERxd3RtQ0Q4dXFaUGJlTi9qOW5MUzJHWUhjR09tU21adUxjYlROOTJDOS9k?=
 =?utf-8?B?RzhqV0NaaGx6ektGK2lMR3EraFAwTVRtYi9pYUxtLzVzdklpcGh4Y1NhT1Ru?=
 =?utf-8?B?WldiaHVIc293NFladkJOeFpEalJySDJFTHZyRkQxSzdZUkd4RVp1dmJKb0dQ?=
 =?utf-8?B?NGhWb2c5dzJOYnRwNnZMUUpFU3B4Zm9CYWtFaTVTWGw4Y1ozWEowcUFjeXVP?=
 =?utf-8?B?K0hJRUFCbEVPTEFnUUEwclFqTER2Zm02blhYUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdNMkF3RFFMTDc3MHBzRDhkL1JnUEtYRG5ocEJKSXV3NDdlZ3JQL3lLenVZ?=
 =?utf-8?B?LzVnVHhrWGNNdzZmNEkzSlFRZUppOEl0emlHcTdRR0lFOWRFMEVlV3JUb2JF?=
 =?utf-8?B?STA5ZjZyTHRla2thZ1VXQVR2SndZdlBkTFZBOU5YWVRyTW9pL1JHY1FkSDl4?=
 =?utf-8?B?cEl2QWFxRFFNTitxRXR3MXBFc1FtT0ZWSVJFWENZb3F3N1hwOGtidDN5V3hD?=
 =?utf-8?B?ZVFsNmdSUk9NODAxb3ZTSWpidDBHeEZGV3JsYUoyaDVWVzJyUU1lR1lDblcv?=
 =?utf-8?B?bXlpUzV3LzN6NWRDK3pPVXJ1THhyME8yYk9vSWx5OURRM3RKY0htMnJFVzJY?=
 =?utf-8?B?Y3VvYXRWS2hOOGQ3VUVOMXFvN2Ixb3RzYlJrTzRTRWZEZjMreE5SUDRYR2pR?=
 =?utf-8?B?ZDZJK1AxUkhXTVl4U0tidU5nTDF0b3RTU2dVMXc1WUVNTzBlYzBValhmejZr?=
 =?utf-8?B?d0F0VHQ5bTZkRzhRRWk2K3VPVnJGUFVRb0c4RXNzb3F1QjI2SUpTMXkzN0lr?=
 =?utf-8?B?bzZCeUd5QllsaDFCeTNvRWpxRTVTMlVyUENndHBjNHdEN0ZnS2REb1NMUW9X?=
 =?utf-8?B?KzBRV00rQmgzTk96eWhXYmtBMzJjckJSd210K0ZnWno3ZTFxckV3R3AvNjhW?=
 =?utf-8?B?ZG1ZcWVnenVXS3dxUVpOYjZ3ZmtDNlRqTnVlUllwTUs3cWt5VjRUNXJrcTB3?=
 =?utf-8?B?WHZ0a1YrN0pmakJSNmhBbUhPV2NvdkFocXFBK1pKWTZCQjg5OGo2MmphRXBT?=
 =?utf-8?B?RXpHUUNjK2hHZVV3RDZWQU9YaFBaTDA4T29VdVBDenV5a1oxMnFTU2VTWVFQ?=
 =?utf-8?B?dHhFRU5IL2JSVHJ0clYwU242cXlrSzYxQXdqS256MDFMSHRvVnRpNXo3dUZI?=
 =?utf-8?B?MXBPQkg3VVI0OVB3T21CV3FuNFZ3QktYcjVXcTRIUjBCUXVVbTB1bDFOWFYw?=
 =?utf-8?B?ZDZwTGNNWC8vM3ZZK28xbmlNc1JRbHZkcWxLZ0pDRE9kYlU4UlpKM1haZDZk?=
 =?utf-8?B?YWx1YlUwRzZ6UWcwY3VKS0V0K29SUFc3elFudnFKWmFiL3YxUW9ZTDZ4Q2E2?=
 =?utf-8?B?R3daa2lnWEFzQVBqN0dyNnZ5dEsrMVJ5WmxTUUVoZkNuRENxSUlla0s2UVZK?=
 =?utf-8?B?cm0vMXNoQzlJNy93SXZ0QzJlSWo2T00wSFdyTjJlTWZ5QzJtN0VmdmxmUWl3?=
 =?utf-8?B?bzNIU3ZiVWdxbVlOYzBIVS82Q2dnNDlQV3czUjdJdHFJaFIwM0hpUkNjRTVi?=
 =?utf-8?B?SGp1YTlQbWZrQ0NhdjlET3NhZFdqcjZOTVhDTU9sRldwaGpVREtRT0QxdVMx?=
 =?utf-8?B?OWlIYUZNQUZDVmFLbEJZM1lEWXo5OUVIT3lSWUs1VTJ4VXRmaDkvL3ZIcHJC?=
 =?utf-8?B?cUV4VG9vOXdUTmQ5bGsyWDZ3aStnYkNUS3NPZWhLSjN4ZDBQZWtrMWpVY2Zt?=
 =?utf-8?B?ay8xSlZpL2NwTVQrb1NxaHBCb2F4YkEzaE85V3VYVmJGclp3YkN6OXZwdmYy?=
 =?utf-8?B?SDFEaVM3aFJOemh4ZGpaOWlMYWNuT05jWk4xZ1NLUW5QUmJVYlAyWWxiRkNN?=
 =?utf-8?B?K0ViZ3JoWUFnTXIwaW12RXZSaWZKQ1lrWXZPaFA1RFFzcUt2R1dmZHR0SCtm?=
 =?utf-8?B?c0JqWk9DU29HTUhGTE1USHNUV2FHSDlEQUttc1NKakdxQ1Y3dElBSjlIckNS?=
 =?utf-8?B?Q0VlbXJOZ2luQXNnZVFmcUtpaThsUmZiNm84Ky9jbnJkLzJ0Mm1mUWVuWHFV?=
 =?utf-8?B?WitEOXpTZjZJaXlVZ2FKcU1VMThwazk5SWRyN1E1M0J1eHZ4TGVCYWVBb3NL?=
 =?utf-8?B?REVkcDdrSlZEOWdPSzBBdVQwWk1Vc3hBOWlqbys4SVIrVjhaNFdWL05WVlNo?=
 =?utf-8?B?MmRGTjBrU1U1aGIrMldFU3VZQ08yS1Rpck44amJaNEdGY3YyZ0lwTXVLYjZ1?=
 =?utf-8?B?K3paWHJmazR1bWFuQmlqdlpSLzY4MTg0aGhUcnZDM1BhZnJlZjdKNDRiMGNs?=
 =?utf-8?B?QkRqS1lvZHA2UGlQNk1zdGZyNVR0emJVOEYyanV5UTZpSVJkeklGTHRhK2Zy?=
 =?utf-8?B?V1o0WGZFMFptWGdGeG4yM2ZZMTFTWXpoalVzTC9ZeW1CVjNEanZIL2dGajBu?=
 =?utf-8?Q?mftY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c0c090-b854-4776-c960-08de1560a734
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 13:56:39.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVhobKMuCKG61zdvW52ZaJwHes1TtiON6MFOvP78jt0Zrw2KXgvM2SKQ8KfuSix1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUg
NjozMSBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBUaG9t
YXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtl
cm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEFsZXhh
bmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCA1Mi81Nl0geDg2L2J1Z3M6IFN1cHBvcnQgcGFyc2luZyBtaXRp
Z2F0aW9uIG9wdGlvbnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJv
bSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcg
YXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAx
MC8xMy8yNSAxNzozNCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IEFkZCBhcmNoLXNwZWNpZmlj
IGZ1bmN0aW9uIGZvciBkZXRlcm1pbmluZyBpZiBhbiBvcHRpb24gaXMgcmVsYXRlZCB0byBhDQo+
ID4gbWl0aWdhdGlvbiBhbmQgcGFyc2luZyBpdC4gIFRoZXNlIHdpbGwgYmUgdXNlZCBmb3IgcGFy
c2luZyBhIHN0cmluZyBvZg0KPiA+IG9wdGlvbnMgZm9yIHJlLWV2YWx1YXRpbmcgY3B1IG1pdGln
YXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBs
YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2J1Z3MuaCB8
ICAyICsrDQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyAgfCA1Ng0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU4
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9idWdzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9idWdzLmgNCj4gPiBpbmRleCAyZTFhN2Qy
ODJlNTEuLjFlMTQyYTY3NjMzNSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9idWdzLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9idWdzLmgNCj4gPiBAQCAt
MTMsNSArMTMsNyBAQCBzdGF0aWMgaW5saW5lIGludCBwcHJvX3dpdGhfcmFtX2J1Zyh2b2lkKSB7
IHJldHVybiAwOyB9DQo+ID4gICBleHRlcm4gdm9pZCBjcHVfYnVnc19zbXRfdXBkYXRlKHZvaWQp
Ow0KPiA+ICAgdm9pZCBhcmNoX2NwdV9yZXNldF9taXRpZ2F0aW9ucyh2b2lkKTsNCj4gPiAgIHZv
aWQgY3B1X2J1Z3NfdXBkYXRlX3NwZWN1bGF0aW9uX21zcnModm9pZCk7DQo+ID4gK2Jvb2wgYXJj
aF9pc19taXRpZ2F0aW9uX29wdChjaGFyICpwYXJhbSk7DQo+ID4gK2ludCBhcmNoX3BhcnNlX21p
dGlnYXRpb25fb3B0KGNoYXIgKnBhcmFtLCBjaGFyICp2YWwpOw0KPiA+DQo+ID4gICAjZW5kaWYg
LyogX0FTTV9YODZfQlVHU19IICovDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBpbmRleCAyZjgyMjYx
ZDAzM2QuLjI2Y2ViNDJlMGNmYiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1
L2J1Z3MuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+ID4gQEAgLTM5
OTEsNiArMzk5MSw2MiBAQCB2b2lkIF9fd2Fybl90aHVuayh2b2lkKQ0KPiA+ICAgfQ0KPiA+DQo+
ID4gICAjaWZkZWYgQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMNCj4gPiArc3RydWN0IG1pdGln
YXRpb25faW5mbyB7DQo+ID4gKyAgICAgY2hhciAqcGFyYW07DQo+ID4gKyAgICAgaW50ICgqcGFy
c2UpKGNoYXIgKnN0cik7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG1pdGln
YXRpb25faW5mbyBtaXRpZ2F0aW9uX3BhcnNlcnNbXSA9IHsNCj4gPiArICAgICB7Im1kcyIsIG1k
c19jbWRsaW5lfSwNCj4gPiArICAgICB7InRzeF9hc3luY19hYm9ydCIsIHRzeF9hc3luY19hYm9y
dF9wYXJzZV9jbWRsaW5lfSwNCj4gPiArICAgICB7Im1taW9fc3RhbGVfZGF0YSIsIG1taW9fc3Rh
bGVfZGF0YV9wYXJzZV9jbWRsaW5lfSwNCj4gPiArICAgICB7InJlZ19maWxlX2RhdGFfc2FtcGxp
bmciLCByZmRzX3BhcnNlX2NtZGxpbmV9LA0KPiA+ICsgICAgIHsic3JiZHMiLCBzcmJkc19wYXJz
ZV9jbWRsaW5lfSwNCj4gPiArICAgICB7ImdhdGhlcl9kYXRhX3NhbXBsaW5nIiwgZ2RzX3BhcnNl
X2NtZGxpbmV9LA0KPiA+ICsgICAgIHsibm9zcGVjdHJlX3YxIiwgbm9zcGVjdHJlX3YxX2NtZGxp
bmV9LA0KPiA+ICsgICAgIHsicmV0YmxlZWQiLCByZXRibGVlZF9wYXJzZV9jbWRsaW5lfSwNCj4g
PiArICAgICB7ImluZGlyZWN0X3RhcmdldF9zZWxlY3Rpb24iLCBpdHNfcGFyc2VfY21kbGluZX0s
DQo+ID4gKyAgICAgeyJzcGVjdHJlX3YyX3VzZXIiLCBzcGVjdHJlX3YyX3VzZXJfcGFyc2VfY21k
bGluZX0sDQo+ID4gKyAgICAgeyJub3NwZWN0cmVfdjIiLCBub3NwZWN0cmVfdjJfcGFyc2VfY21k
bGluZX0sDQo+ID4gKyAgICAgeyJzcGVjdHJlX3YyIiwgc3BlY3RyZV92Ml9wYXJzZV9jbWRsaW5l
fSwNCj4gPiArICAgICB7InNwZWN0cmVfYmhpIiwgc3BlY3RyZV9iaGlfcGFyc2VfY21kbGluZX0s
DQo+ID4gKyAgICAgeyJub3NwZWNfc3RvcmVfYnlwYXNzX2Rpc2FibGUiLCBub3NzYl9wYXJzZV9j
bWRsaW5lfSwNCj4gPiArICAgICB7InNwZWNfc3RvcmVfYnlwYXNzX2Rpc2FibGUiLCBzc2JfcGFy
c2VfY21kbGluZX0sDQo+ID4gKyAgICAgeyJsMXRmIiwgbDF0Zl9jbWRsaW5lfSwNCj4gPiArICAg
ICB7InNwZWNfcnN0YWNrX292ZXJmbG93Iiwgc3Jzb19wYXJzZV9jbWRsaW5lfSwNCj4gPiArICAg
ICB7InRzYSIsIHRzYV9wYXJzZV9jbWRsaW5lfSwNCj4gPiArICAgICB7InZtc2NhcGUiLCB2bXNj
YXBlX3BhcnNlX2NtZGxpbmV9DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG1p
dGlnYXRpb25faW5mbyAqZ2V0X21pdGlnYXRpb25faW5mbyhjaGFyICpwYXJhbSkNCj4gPiArew0K
PiA+ICsgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRShtaXRpZ2F0aW9uX3BhcnNlcnMpOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgIGlmIChw
YXJhbWVxKHBhcmFtLCBtaXRpZ2F0aW9uX3BhcnNlcnNbaV0ucGFyYW0pKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gJm1pdGlnYXRpb25fcGFyc2Vyc1tpXTsNCj4gPiArICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBOVUxMOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtib29s
IGFyY2hfaXNfbWl0aWdhdGlvbl9vcHQoY2hhciAqcGFyYW0pDQo+ID4gK3sNCj4gPiArICAgICBy
ZXR1cm4gZ2V0X21pdGlnYXRpb25faW5mbyhwYXJhbSk7DQo+DQo+IG5pdDogVGhpcyBoYXMgYW4g
aW1wbGllZCBjb252ZXJzaW9uIGZyb20gYSBwb2ludGVyIHRvIGEgYm9vbCwgc2hvdWxkIGl0DQo+
IGJlIHJldHVybiBnZXRfbWl0aWdhdGlvbl9pbmZvICE9IE5VTEwNCj4NCj4gSXQgd291bGQgd29y
ayBlaXRoZXIgd2F5cyBidXQgYmVpbmcgZXhwbGljaXQgaXMgYmV0dGVyPw0KDQpBY2sNCg0KPg0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgYXJjaF9wYXJzZV9taXRpZ2F0aW9uX29wdChjaGFyICpw
YXJhbSwgY2hhciAqdmFsKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG1pdGlnYXRpb25faW5m
byAqaW5mbyA9IGdldF9taXRpZ2F0aW9uX2luZm8ocGFyYW0pOw0KPiA+ICsNCj4gPiArICAgICBp
ZiAoIWluZm8pIHsNCj4gPiArICAgICAgICAgICAgIHByX3dhcm4oIklnbm9yaW5nIG5vbi1taXRp
Z2F0aW9uIG9wdGlvbiAlc1xuIiwgcGFyYW0pOw0KPg0KPiBuaXQ6IERvIHdlIHdhbnQgdG8gYmUg
dGhhdCB2ZXJib3NlPw0KDQpNeSB0aGlua2luZyB3YXMgdGhhdCB0aGUgYWRtaW4gaXMgd3JpdGlu
ZyBhIHNlcmllcyBvZiBjbWRsaW5lIG9wdGlvbnMgdG8gdGhpcyBpbnRlcmZhY2UsIGJ1dCB0aGUg
aW50ZXJmYWNlIG9ubHkgcmVjb2duaXplcyBhIHNtYWxsIG51bWJlciBvZiBzcGVjaWZpYyBjbWRs
aW5lIG9wdGlvbnMgKHRoZSBvbmVzIHJlbGF0ZWQgdG8gbWl0aWdhdGlvbiBzZXR0aW5ncykuICBJ
dCB0aGVyZWZvcmUgbWF5IG1ha2Ugc2Vuc2UgdG8gd2FybiB0aGVtIGlmIHRoZXkndmUgd3JpdHRl
biBhbiBvcHRpb24gKHRoaW5raW5nIGl0IHdpbGwgaGF2ZSBhbiBlZmZlY3QpIGJ1dCBpdCBpcyBu
b3Qgc3VwcG9ydGVkIGJ5IHRoaXMgaW50ZXJmYWNlLiAgSXQncyBhbHNvIGEgd2F5IHRvIG5vdGlm
eSB0aGVtIGlmIHRoZXkgbWFkZSBhIHR5cG8gb24gYW4gb3B0aW9uLg0KDQpUaGF0IHNhaWQsIG9w
ZW4gdG8gb3RoZXIgaWRlYXMgaGVyZS4NCg0KVGhhbmtzDQotLURhdmlkIEthcGxhbg0KDQoNCg==

