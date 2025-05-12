Return-Path: <linux-kernel+bounces-643526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3DAB2E32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 05:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9881892719
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E134545;
	Mon, 12 May 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHL6fIpG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6964254878
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747021531; cv=fail; b=gVSE916OSHpfmRD3MvFZ29xqc9+XtzOxNq9/pl+amRb5UScMBxHMYbnWE959j9PNbEaez1TjfN+KzcA4AIxTiTfnG0epIVhD8M5QIiC75ucuR88PQ1nmtv7UpbxjQ2Nr8i7lPm1XKg0T3FSfcmRm5Ize4/FRD5AbWn7TYh7TK/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747021531; c=relaxed/simple;
	bh=ZQB33z8H/hShW1XT6WwHs9jY6v+LkfM4RvfaK5r3vv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xmxn3HMZijHlXZk+WJ3S0MnmUc5qSt2+AmxqumCHK6SMyeaCdJsrHoaNA9rHQ8VL/Rfg6GKiDJ3uqlMrFGKQHjaHXis0NOPzh+0jtYfshTOT+SkVPc2lTYJ7NripuYtJf+XkwniuBQyObw/rO0M+pywWzGxgStsPwbRLI/4Y9QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHL6fIpG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747021530; x=1778557530;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZQB33z8H/hShW1XT6WwHs9jY6v+LkfM4RvfaK5r3vv0=;
  b=JHL6fIpGcYvnUsUyUgHlw0hTmWcy1yqeAjWYUBIiY9EUUxXK60t51FJ/
   4j0vdooMMF7Pt7eUkqEYUFGLEOUVQKo6mKab1m9JAWUjO4fLdbJrsAgpO
   kT9B6qSHiiZECBIYqJ19WJr0cJYjxBzqahUvW8jIRQhq4Edpirc9hg0WC
   Wrh47s73O1BjwvZ6csJUF8CKwkAj4eSSY9nRqjbgZM4qm71NuwhNu8FuA
   UbAMVs8MOhXdIIDt7BZWJZ6xCbIffacu56b+72AzOcDvbKFgnIIibR+a/
   N+Ad1dwTkWhUvlTxMlXPKzWsy5IeU1IE76jWK3VLMLoPffWkKrc0hhGR4
   g==;
X-CSE-ConnectionGUID: AlnujNs5SC2eUKw8V5NWFQ==
X-CSE-MsgGUID: fn3ORzjWSluz8Hs8kgfiLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59432776"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="59432776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 20:45:29 -0700
X-CSE-ConnectionGUID: 2wd4BqqwSWK/HCgpMSAzeg==
X-CSE-MsgGUID: JOZUkVfQSZi7BqcGu2jX9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="160498806"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 20:45:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 20:45:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 11 May 2025 20:45:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 11 May 2025 20:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2t7C8vCE7ZhmQ1kZ16J4vOcUxy82RCx92qWjMMV5msAaXneWdDSKZ4AkmojVyii6K0okQUtc/tsa4ZqmcX+UwHL0YUi0ur/H9eMFFMXnwS1vxkHaq6D5huyMSmu+8nKFGtSuzaRtjvy4F1DFwNO76KAY/ARuaKX2KMaPjl2ufR4OlDe5gojktdRwRU0/VGiO0sEvoR5G48n/W17ocYKuZhV01sWqDVMpdmWcttCFaqZpW5XkQaAldeKQwcNhU81pbfln/pTUrXeRUFQ7xuWyvI3cBmCkb5qC20XhKfe8MYYr8Y0Im/iS8rR9GnBF+BPc+GxN2oKTV50nnpcuEXHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQB33z8H/hShW1XT6WwHs9jY6v+LkfM4RvfaK5r3vv0=;
 b=ODzmU89NrZ7evw5y/jMYoh9E4w7m9mfGasnb1DODb8XRv8Rgwr4lPTrfcDPu97hFyCjgT2quLhQuMCPK+KRJ1WSM/FvAsuCglXaUV9FBFMf4fc4XL3oBvlLr4E2ZsQ+kA4Wf+jn55k5ha6YV6PL+w9AfIWg5Wm8tx5f+5vJRJ7LMbuBIb+sDRHxFxH17EuTWlfRGVVc8+Of6nzTxEK/lCc6rgiKdYlMHFvv+iXnS2hchvJRfXl7Zc52EDN/Jx4kdlntYue9cZ0YDfdSbpiLhsORLyKctpbSuwb+fqr38NaP0K+u8OSRF03ufXZ8nOSWgIjHI67qBIYHJ/gGtl7wp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.21; Mon, 12 May 2025 03:45:19 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 03:45:19 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
Thread-Topic: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
Thread-Index: AQHbwKlZwkA0/SyYsEuLvzUKxjoFibPOTfAAgAAJo7A=
Date: Mon, 12 May 2025 03:45:19 +0000
Message-ID: <DS0PR11MB6373B31B77F9F6CDDFC9439FDC97A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-4-wei.w.wang@intel.com>
 <e8608bf9-45d6-4627-9a1a-88be0ff55cd3@linux.intel.com>
In-Reply-To: <e8608bf9-45d6-4627-9a1a-88be0ff55cd3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 691d3e92-402c-45eb-1b5b-08dd91076abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjNodldiTkwwVmloUG84dVFvNjBWT09iVTBWY2FpU1NpTjVtMVNCMW51V2xF?=
 =?utf-8?B?Q2lCS3VWd090UnVVS0FuRllZREFGaCtiVzNiSjFvaWUrU0hCOUUzdnBLd1gv?=
 =?utf-8?B?U1FDK25MUTNtNnZHc1VtWjBPeUxEb2JxNWdjeHI1RzF3VHQvNXNUSjA3eDVS?=
 =?utf-8?B?QVhkV1Y5cTlBUE5IdlBiTWVmOC9JcCt4eEMrZ3VLeE5mV2dUNVBSbWU4L09I?=
 =?utf-8?B?MnF0cGxQQXdiWkltVHJoNnRIdWlOSGdFNTh3VjRnam5FVWhPUjY3aEVJbGho?=
 =?utf-8?B?ZmVDb1NwR3lCRGQ2b2dwM0I1LytOYkx5clloUDFwZmtPdTJEalA4blFIcEE4?=
 =?utf-8?B?UTN2TnVHVWw4M0xwZjdSbEk5aEs0aE1IdHgrb2wxUkQySmp3a1lJUXljNnhx?=
 =?utf-8?B?MU0xNHk2SnM5RFlGUlZvYXcweTcyOFhrS01uQ0FUWEYwMm16YlVTektxZUtL?=
 =?utf-8?B?a3RhQ2t3c3ZWUTZCNHFhUGRvbnd5RTFjbXB0TkFZbEpmeGNQOTRmYXZ3Q0hU?=
 =?utf-8?B?NHhHK1pFZjBtcHo1K1R1NGc1Ri96eEFPaHk3RTFMQk5CdnBkUnpXR3pjbVpI?=
 =?utf-8?B?V2lNNWRzYkwrNFFxbXZ2SjRyRlRwVWlpWkpqazhSU1NhQzEvQ3dxRndPTkhi?=
 =?utf-8?B?d0FTY0x4T0dNYmNXdTZMRkdoZ3ZtSS9KUVZ1RWxhcWFXMk1iUm4zQWc1aEY0?=
 =?utf-8?B?SERqZEgwdStBZjVFUktHNnVleUo3Mm15ZUc4bFhtTmkwT3htUllFYVhlbzhT?=
 =?utf-8?B?djZrZXNvVkZod3VaRTErWHJtN09leEx4YldzVWx1MmNJTVJOVlN1aUFsdHNS?=
 =?utf-8?B?ek0vZXJYdE4wUXkxK2sweElSa0VxYnRNbEdvS0JaRnB0eWZQMjE5bmRSZHVz?=
 =?utf-8?B?RmwvQThIM2tvK3pDSzRZcEMxZmRtRmtuOEVhTXp1UFBLNWY0U2Y2RWU4ME9B?=
 =?utf-8?B?OVc0ME9hZ0JOMnpqVlZHM0xCU3pKam1tTG5NTWdiR2c3ZnZaR0JIZHVnYzFG?=
 =?utf-8?B?aGtITVBGR3lGd1ZtY1BrWldQb0daQmNkNGttNW5QY3dyeTM1N21iaktxRlVh?=
 =?utf-8?B?RFlRREJWcEVIbFdxcTdESzMzVkljY0pISFFOeGpMcVZZQ2E2MDhOTE5hT3Uy?=
 =?utf-8?B?MEZOUXNBdTYyZld5ZjNLdzFRaGc5UENZMlNkUXRkSkVmUUs3dWFyeS8wOXM3?=
 =?utf-8?B?dHNVV3hITzE2c2M3NXZTSHZPbURxbVkwVjdEN1BtcStDWU9QdHVKZHVURlFM?=
 =?utf-8?B?aS8xem4wbW8wL09DcFpTVnlhLzh4MUdjdnFtTEJIZVlHcEd6b2NRZHJhT1Rn?=
 =?utf-8?B?Z3hOQmZlaFFaU2JZaURpRDRKb2FNTDFUdUM2RVF0Rzd2ZlNTeUVYbDNTc2NJ?=
 =?utf-8?B?SEFHRE5GYUwyMUdOR1F6Qm5HYVdXM0JQVEZ1TzdEaVFuYTRNei8xOTBvYXFp?=
 =?utf-8?B?VUhyZUw2ZENLOWQrQlVWOHNVd1Z0VnVDVXN6a01lSlZMRmtidmtkRFJ2czdo?=
 =?utf-8?B?NVVabk0xR0gzNjNUNHBVMTV6Nk1zTVUzOTdpZXN0VnhIVU41K3dMU1A5ZlZG?=
 =?utf-8?B?KzA4MTVxemdRVzVuSklZMHR1aWVkeDRpRlBjRDNCeUE2YjlGNEt2bGFLTDJZ?=
 =?utf-8?B?M21OeVAvVFVnUUZkSGdiTXFGYmFDRTJDS28rRE5KR2s0ZWJCRkV6YlgrYStW?=
 =?utf-8?B?Z044R2IxQjdBdC9saXZXUUxhYmlaSjlROURGYkYrK0hoMTkyZ0FOdEtrVk9K?=
 =?utf-8?B?L3ZTUUhFUzA5TnJXTi8vMGlxemFlemt2bmlDeUpVTGs0UTJSdVR2WUtWU2Na?=
 =?utf-8?B?dHBFL00rVWhkdHcwTkpLVG1yWktmWTNaS3lGeEwvREtPZThXdm05a0pVcXI5?=
 =?utf-8?B?NVVkc1JJL2tWQ2duT015SlgxYm1lV2RrRXQzQkh6dU56SFBWbU5xUS9WeDMx?=
 =?utf-8?B?cGxQL25hYVhlMkE5QXlpQURqRFplNHp0REl4UVNFZDA1MEFCcEFNSEhnMHNH?=
 =?utf-8?Q?Qr7IFlU2+8SSPIne6Rk7sRCeIn0trE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1qTHlFaGliNG9WbGVUS0gvSmFzc0tMKzdXcVhTWGMrTEFnZUU2cEJPUXYr?=
 =?utf-8?B?UzdCR04xdktiNkNzNmxWTm1wcVg4bGVUL2E1Z1lOZFVyTzBmcWl4eDZ4SHd5?=
 =?utf-8?B?YzZydkFxNlFTcXpZN2V6bW9SaklQbXV3Y2VNSUdyaDdzUEZqVURMRzBHSFZo?=
 =?utf-8?B?d1NJSURuTUd5eTB5cjJ5SlQ1dTE5c29LdFI2SVU5UHVaVUt6NTBkdXZaSnRi?=
 =?utf-8?B?L2ZTckNsZzQzMXN6M1JGS0ZXWjJSYTd3cVJncUxqVGxiaVNxdC80VEVwbER4?=
 =?utf-8?B?NHljVVRxRlNiTFpNZnNTL3dxN2RLWTJPZ1dPRXZuL0YzMXloRERIMm1pdVRm?=
 =?utf-8?B?Rit5MzJ3L09VRnpMZktCNFQ2UnV6NGZKZUpxck5OYU1FZCs1VkNEK1hiZVpF?=
 =?utf-8?B?VlpjdlhRYVNIalFnK1V3cmlrcnVyTk1YalFkTWlqTGYzcWl6LzBEeGo0Vmty?=
 =?utf-8?B?T2NKNnNpT0VYV2xDVDFVSnVUSEIyMGVVSEVFWnQ1RHc2R0tjWklDa0V1Yyt1?=
 =?utf-8?B?TVROcVNyVmlSaDFRR3JOdHVCa3ZqMFhtRzVDYTMwcnBOTEk5ZS96TmtWS3pF?=
 =?utf-8?B?eTZvTHYzTmVIMWhrQkhZNktVNHFJQ1UxdzZ3SXIzaUs3bTlBbVpjaTZRR1hE?=
 =?utf-8?B?ZHZIV1FHVTNyYzdPUEQ5V25ka1A3Qit3Z0ZpVVNnZy8wc093c0wrQlY1WEtL?=
 =?utf-8?B?WW45b0tZSEZkTitzN3JTS2pJWGRLT3pGaGRjL0VyY0VOdTZqYU9yQy9SVi9l?=
 =?utf-8?B?UVBBRkQ4OVpzTytoVjNMdWhGL3pGdC9sczFEeFlEZ2hFNkk2WnJGZTJadzJX?=
 =?utf-8?B?d2NZRFBrdnlCQmxBSGRlWlRrbS9zM0pib09JWEFCOU9EZUJMd29sdHBFS21o?=
 =?utf-8?B?Q0pYa2dHMlZubHhac0MyUFM3UTFNOFQ5OWUyYXhhNWM0RTF5TElVS1dGUmpI?=
 =?utf-8?B?MC8wd21GYS9DN1ljVHVTQWllSDloM3pJSHlBWFdwcVNGWGp0bnJhYmpaR3Bz?=
 =?utf-8?B?ZDhqZDhUWVJySmE5RW9pNDJUQjc0cFdwOXpRUXRmZytQSGpUSEhTVmFyZHBu?=
 =?utf-8?B?UlJQRksyb0tQeTNiZTQySncvSGticEE4TldJeWYvTis5UUFQT3NSK3l6VWg0?=
 =?utf-8?B?a3E4ckw1UTc4c3NUaDA4VE56RUpzcFJsS0VLcHFYV0ZVc1luaitBTDRkaFAr?=
 =?utf-8?B?SWxvTklWL3hteE5WaERPR1cyY09IREtGQ2RWUm1VaXdkb3huZ056LzJsQ0JT?=
 =?utf-8?B?N0wzR2k5c2Yzd1hmTUZkUVdPb3h1S2g1Z3ZnR2JWemIvVUhRdHhSUXlWNTFR?=
 =?utf-8?B?OGNubWlKSzZwSEhyTEswaUJWaE03YkdUQ3A2eFJETThxSmF6SmxHYnNYU29h?=
 =?utf-8?B?YjhnT1E1SGRUamJISFVYejNPazR5aXpsY2tKRkE1ZzlYVkhOcmpqUUI4UDh1?=
 =?utf-8?B?aS9JVHFxNFRtSFNMNG1CYWVFK1dYQnpZS0I4Ulkrb0VHRHdsdndNbUpBUjd2?=
 =?utf-8?B?RmFSU3ZkNHp5M3M3cTVhWXN0b21UK1crc1R5eEVtcDJmaTNHdGo3SWpZT21q?=
 =?utf-8?B?b3FNbWFsTEpqSnpHaWd2UG1rcEpnLzllME9uUlJwbzlaRExaZi80N0ZJRzZM?=
 =?utf-8?B?S2QrbWF1OTVFaVpSeE5PQkZIMkh4UDUvaXZnYTJSNkpCRXNHL2hDbTk3WGpI?=
 =?utf-8?B?QU9NU0pmUXJCbUFZYzRtbGE1elBCbXBMUkp3dHZVSmJiTlhoTEs1QnlBcVVG?=
 =?utf-8?B?S05FYUtXNmoxMU5GWVQrTUlkZmVTdnBUSHlaWXNXa2lrN2ZyUitNNk43VE1r?=
 =?utf-8?B?anRwUWMrKzd6Yy9SaStrU015RU1lT0d4dW1iWkpyQ1FWaFV4L1o5RjdJU3JD?=
 =?utf-8?B?VEVQYWVxUER0M1g1M2FJeVhRbXhpTllhMzNHZGU1OGFzeTEycXFmaUwvYTJG?=
 =?utf-8?B?c3B2a0FTd2pWNzQwTU5vYWRrNHZMUVYxdXh4MzZZRnByaHp3cHZBSlhrN0Fu?=
 =?utf-8?B?aVBXYklUbnl4Y2JkQUhHbG5hMWN5ZStkWG5EVlFacll0MWhGbFRMb1BPNU9Z?=
 =?utf-8?B?R2RKRE5hSGF0RWpQTTNXTnZDbkRuNDh6LzI4QVNsQTZsc0Njd0djSzNyRzl6?=
 =?utf-8?Q?zQqMQPFoeNu3VCg3VU6svQ0gG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d3e92-402c-45eb-1b5b-08dd91076abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 03:45:19.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKDtCj/viN1cQcAo+QkBeJveQN3QNTnRnJgPb3Kmr7ZuQoje+zXCFzy7DY1kJZeDd52pG0WVIZrpg018dfppzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

T24gTW9uZGF5LCBNYXkgMTIsIDIwMjUgMTA6NDMgQU0sIEJhb2x1IEx1IHdyb3RlOg0KPiBPbiA1
LzkvMjUgMjI6MDAsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IFRoZSBWVC1kIHNwZWMgc3RhdGVzIHRo
YXQgIlNBVEMgcmVwb3J0aW5nIHN0cnVjdHVyZSBpZGVudGlmaWVzIGRldmljZXMNCj4gPiB0aGF0
IGhhdmUgYWRkcmVzcyB0cmFuc2xhdGlvbiBjYWNoZSBhbmQgdGhhdCBpcyB2YWxpZGF0ZWQgcGVy
DQo+ID4gcmVxdWlyZW1lbnRzIGRlc2NyaWJlZCBpbiB0aGUgJ0RldmljZSBUTEIgaW4gU3lzdGVt
LW9uLUNoaXAgKFNvQykNCj4gSW50ZWdyYXRlZCBEZXZpY2VzJw0KPiANCj4gVGhpcyBpcyBhIHNw
ZWMgcmVjb21tZW5kYXRpb24gZm9yIGhhcmR3YXJlIGltcGxlbWVudGF0aW9uIG9mIHRoZSB0cnVz
dGVkDQo+IEFUUy4gSSByZWNvbW1lbmQgc3VwcG9ydGluZyBpdCBhbG9uZ3NpZGUgSFBUIHN1cHBv
cnQgaW4gdGhlIG1haW5saW5lIGtlcm5lbC4NCg0KU291bmRzIGdvb2QsIHRoYW5rcy4NCg0KPiAN
Cj4gVGhpcyAxLzMgYW5kIDIvMyBsb29rIGdvb2QgdG8gbWUuIFRoYW5rIHlvdSBhbmQgSSB3aWxs
IHF1ZXVlIHRoZW0gZm9yIG5leHQuDQo+IA0KPiA+IHNlY3Rpb24uIEl0IGlzIHJlY29tbWVuZGVk
IHRoYXQgc3lzdGVtIHNvZnR3YXJlIGVuYWJsZSBBVEMgZm9yIHRoaXMNCj4gPiBkZXZpY2UiLiBJ
dCBpcyBwb3NzaWJsZSBmb3IgYW4gaW50ZWdyYXRlZCBkZXZpY2UgdG8gaGF2ZSBQQ0kgQVRDDQo+
ID4gY2FwYWJpbGl0eSBpbXBsZW1lbnRlZCBidXQgbm90IHZhbGlkYXRlZCBwZXIgdGhlIHJlcXVp
cmVtZW50cywgYW5kDQo+ID4gdGh1cyBub3QgYXBwZWFyIGluIHRoZSBTQVRDIHN0cnVjdHVyZSBh
cyByZWNvbW1lbmRlZCBmb3IgQVRTIGVuYWJsZW1lbnQuDQo+ID4NCj4gPiBUaGUgY3VycmVudCBp
bXBsZW1lbnRhdGlvbiBjaGVja3MgQVRTIHN1cHBvcnQgZm9yIGludGVncmF0ZWQgZW5kcG9pbnRz
DQo+ID4gaW4gdHdvIHBsYWNlcy4gRmlyc3QsIGl0IHZlcmlmaWVzIGlmIHRoZSBpbnRlZ3JhdGVk
IGVuZHBvaW50IGRldmljZSBpcw0KPiA+IGxpc3RlZCBpbiBTQVRDLiBJZiBub3QsIGl0IHByb2Nl
ZWRzIHRvIHRoZSBzZWNvbmQgY2hlY2sgdGhhdCBhbHdheXMNCj4gPiByZXR1cm5zIHRydWUgZm9y
IGludGVncmF0ZWQgZGV2aWNlcy4gVGhpcyBjb3VsZCByZXN1bHQgaW4gZW5kcG9pbnQNCj4gPiBk
ZXZpY2VzIG5vdCByZWNvbW1lbmRlZCBpbiBTQVRDIHByZXNlbnRpbmcgInN1cHBvcnRlZCA9IHRy
dWUiIHRvIHRoZQ0KPiBjYWxsZXIuDQo+ID4NCj4gPiBBZGQgaW50ZWdyYXRlZF9kZXZpY2VfYXRz
X3N1cHBvcnRlZCgpIGZvciB0aGUgaW50ZWdyYXRlZCBkZXZpY2UgQVRTDQo+ID4gY2hlY2sgaW4g
YSBzaW5nbGUgbG9jYXRpb24sIHdoaWNoIGltcHJvdmVzIHJlYWRhYmlsaXR5LiBUaGUgYWJvdmUN
Cj4gPiBpc3N1ZSBpcyBhbHNvIGZpeGVkIGluIHRoZSBmdW5jdGlvbiB2aWEgcmV0dXJuaW5nIGZh
bHNlIGluIHRoYXQgY2FzZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBXYW5nPHdlaS53
LndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gVGhh
bmtzLA0KPiBiYW9sdQ0K

