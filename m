Return-Path: <linux-kernel+bounces-888762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A5C3BD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F43A1883F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D3341649;
	Thu,  6 Nov 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOZQs6c8"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D930EF98;
	Thu,  6 Nov 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440091; cv=fail; b=Xt/zXTVyAR7OjEX0WuOh3dCC3lWFUyUhyx4F1+qnNj+KotKH6j7y8pO4aFwvlnxoJrUxwZHwv1x17gRFfRvJJ4J3xlBe0pUsdOmaZN1jqnHUyBjjNgI7cg+0rFeVOXfA/Ytf9cooQvEUvL0XPWLMFpPY0dxjc9e8/OxR/OE4zMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440091; c=relaxed/simple;
	bh=aqRhoJT+6KpKV/y610JX1O9owb86bEWwNTORo2cgGCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqSS132EwyU5parM81ESCGiUdZxZZbESnNq9bgFIQeeJOmDELNxRSw+nRsdCFvr4rmbjjri7QvhAzj8efN9FxZUZNIQRJD21lXLLc3q1rBO3HG92MmVUOHZKfabFxeMJ04zLvzHYPjGcExzLFKjXOd6LsnUo+lPvRE7DlbZCHTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOZQs6c8; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2qnytWh2RJyMlgu6NANdC1JW7GR++nyDrg4Bjitep7TgDtit/cGOp5qi4frf/mvwTLWxZaW1HTQsHToZuAVVR2+zJb4XoiO3LcjabJlaVhQA0j/alaovOcpJKECxfjC0ofkxiLohtmxHPcVgnETD6POTdalZw2+rsMpGC0fscIpo+rbLQj0MLlW0Nr8kvIkJi87FbfEQtSk39InOMxuu1n44K424DFREW7dCAJThfhdjsKEbFt9ojfLQb6eDB8mQB+N35DikpD9gKtaocq8ME+4oIbESP66WE4UAcbuNeMc5oTRyc6m7nlDznBzJDkZuGdZuaqQzSq7p15LP52v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqRhoJT+6KpKV/y610JX1O9owb86bEWwNTORo2cgGCo=;
 b=f19/UZsOnkObuqliw6qRzHkeZEaB6LhsbmBC/98sdduTWrbMw8LMxe0R60sDN3lX5FtW8HvBrjaDvw4lUY08JAU5d2/XPVnxJ0xz7liL04ZxyykWBroG+HERCRnPa/a2TyBw3VUd5QioJjnOo0JBjt6YRcksLCmUOrIVHjLP546DzHfo3NC/N+8kKmq7EWCj53JFqmeW2oBEcMNUoxHEF8oiZL84+s6FEIdXaezZrW4Yvef4ZlsMJh9ndDfBnkAGZONpTTsJCVUCbYSjnQb4+2kcScl4WsZUEi/UiAX8ceBwpeIUzbq3/5LKzh++5/UeH4AtpBZcS+/H9LaCDuxo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRhoJT+6KpKV/y610JX1O9owb86bEWwNTORo2cgGCo=;
 b=sOZQs6c83qj74f3sALNgv4d9g3MeOhUEHGAgV6WbJx7j4DSyZPmk8qFa2o3JDrIM1DP7vTY6RVpR59AzyLW1dXEEKw/EXlDNgrhAKmN3SW+SvMzXGmFR/1YbIDKhMtlNvMDUAQmtSG/eeQ3s+hIH7bH/DiaxgVwTgvsHPEL9ofpzFh5rv7Gsqcm8lGEhBulcu9k8zfswBAcY9QY/HugDYRsR8s7LxClB0QaI8yUkthJO4GcgpHnDrt6Y7IGWzzT1Cm8lJ8SHmhgMl4Oomal3BlIx+bhXuPNn363CQQjtHXROArv1dpp8KTF4AVRsAW/rnr2xSrwgagvj8SNh7axdMA==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:41:23 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:41:23 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dakr@kernel.org" <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>
CC: Alexandre Courbot <acourbot@nvidia.com>, "lossin@kernel.org"
	<lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "aliceryhl@google.com"
	<aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, Edwin Peer <epeer@nvidia.com>,
	"airlied@gmail.com" <airlied@gmail.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"gary@garyguo.net" <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 6/6] gpu: nova-core: use gpu::Architecture instead of long
 lists of GPUs
Thread-Topic: [PATCH 6/6] gpu: nova-core: use gpu::Architecture instead of
 long lists of GPUs
Thread-Index: AQHcTtEWmexrbbR050yKY4uDwLxBM7TluTQA
Date: Thu, 6 Nov 2025 14:41:22 +0000
Message-ID: <fc6616d404d8fd04a62bd90fa0f79e2c9d2a17da.camel@nvidia.com>
References: <20251106035435.619949-1-jhubbard@nvidia.com>
	 <20251106035435.619949-7-jhubbard@nvidia.com>
In-Reply-To: <20251106035435.619949-7-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: d99c92c5-b511-4e1d-9ace-08de1d428e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGg2WVIzY2JHUk9Tc2s1M3hTMEhMenpSdzVCYjlkdUtOc0E3TnoyZEpML3FN?=
 =?utf-8?B?ZEMrK3crUkhrM0pLMkhKNU1OcCtpMmZSaE9RS0p1Z2xFdGlsQnozSTJQQ1g3?=
 =?utf-8?B?d1ZPRjNnMVU3YlNzWEdBS0JTN3lZNGxGTzFMVWdPL0cwN2tIWTJRak5CNUN2?=
 =?utf-8?B?dTd4VDJDRjZ6Ui9rbjZjZjVnSEp6VEdKRGZtQmFiVzF0dzhMQTF5OWhONENV?=
 =?utf-8?B?SXorQW02cXBiR3NybmF4U1Rlc3RmZ1kvMEpQSnZEa1A4V2hGZStvazUxT2hv?=
 =?utf-8?B?M2pBbWJReXNPVG5QUmx6SUV3elNhcWh4REFTVkdvSlZ0NHlIbU56S09DODR4?=
 =?utf-8?B?ODRJNXlUOEZjQkhRTjBIeFd5T2Vjb2dBeW44eTV4VUJzUll2d1p5SktSSldX?=
 =?utf-8?B?Rzg5cjljQ3RuREcrWWVEOVFJOTdsZHdOL0poQmlMdFd1QnZDbUxYWjhsQXN3?=
 =?utf-8?B?VWZJZXoyRSsrcm5nL1UzL0VKOVZYa2QrQnFLSURwZm03RGtFZ3I5WWFOQjNT?=
 =?utf-8?B?ZldpZm0vSlFzdDVGVytqVHVLUm9UQzEyMUVXQTJYY0V6ZG1CM1dsVXdJUlU5?=
 =?utf-8?B?c3NJWGhUaTBSaFk2anlzeFR3M1ljUjJmVEl6VEpqanBlbXZtNXFockszaXlD?=
 =?utf-8?B?bXJHUTMwVktjd2xXN01pNnlkNGQ5NnlET3A4VXJaL0ZvSXlhN2c0cXNJNUZP?=
 =?utf-8?B?cWdzdndYZnFHSnYvL0dzYUlIVTh6TEkraEhGUVhlTFM3TVE3S0hkQ3VKMlFx?=
 =?utf-8?B?c0ZwbHQrdXNtWEp2NjhLTFhYZTlMMTI5WTJKMkE5aTFNa1lBSjlBR2F3UUVs?=
 =?utf-8?B?QmJiU2x3NHFlL3lpdjk0cmM5Qkg1ZDV2TVBqM0hwUy9hazIzS0FoRlRIMkl4?=
 =?utf-8?B?RXRJcE40cVFhdkNqWW1WYXRIWHkxa05GNDBTY3hhTThIN3V0WUpUVWZYMnh6?=
 =?utf-8?B?dEM4SGN3SHp5YXErNjB6YStJRkp0R1RnTW9pdFJEbEthOUtvbHJlQ2lBa2VL?=
 =?utf-8?B?eWtJWFAyTUdQa2NHRXk4VnBDQjBuRzFNYnY1d3VUS0Q4ZXdYUkQwZTlmNVJV?=
 =?utf-8?B?TFpKc0dHeEsra2p1SXZ3KzJLMGFITEZYY1IyTTVoYytDQXRIdE1taDRrWHpE?=
 =?utf-8?B?eVp5V0xVenpXVVpzOU0vaU1OUUR5ZHZYeWYrdEt4d0ZraHlram9xK0tEVDV2?=
 =?utf-8?B?MGp3SWdNaEJPMjlKRVk1WG90QUwyTkxUVGNhb0dTVUFUZjBKWTd6US9JOC94?=
 =?utf-8?B?YnQrREJLeUkxSEZJMzV0OG85d0huSi9XTkt2cmd5SW5nV2RhUXFOM2ZNNElR?=
 =?utf-8?B?SGJsOU5Zc0QzcWFkRjZYeG5XWm1kc2ZSWGpIdTZtelVneVFlV01nSTN3VkdM?=
 =?utf-8?B?Q2lzUkhodEpWOUREVHlCejk0U2ZEUzJ4STFHeEV2ckhkSlNEYUR1YkpKWmh2?=
 =?utf-8?B?bk5pRU1Pb2pCQWxSZzBpbFE4RGlTdWVVREw1OU1DR2hQV1J6cWlQZ0xsUGJn?=
 =?utf-8?B?dVY1cmhPQVVoOWc1S1VXMGNuMDhnS0NkRHJDTGNNb2FtVlJjeGswcXd6N3g2?=
 =?utf-8?B?aUVjcG1aa0xyWVVPcU1QVWNpakk1RjdLN3lLa3NNTkVsTEJzSGJKcm9TTFlY?=
 =?utf-8?B?blYxcjM3L3pOTVRuVEU1eWRuSldacHdCaUdlRU9WRjd0T2dOUVp2NnY1WW9K?=
 =?utf-8?B?V0tsS2s2YVhrcVBrOHN0T29OMXR4WWx1cFRNYU5mSVJLNVAwdkxhNjQ1Qmhy?=
 =?utf-8?B?Nld3aFBBUHBuOCtLWDllOWsrQWovQllZbDVGUWxHRFJ2ZjFEcndjK2FVaGZZ?=
 =?utf-8?B?RWtrYWM4UE9odGpLV283dS9paTJNb2JkdENwd2tySXBFQW5iVlhHNXBNV216?=
 =?utf-8?B?QW5BVU44NzRtRzFZSmdaR0FRcE95ZUZqVzhhNHZxY0Z1dERoZ1c3Ymp3bEtz?=
 =?utf-8?B?Tlg0MTdYamNCOTFxV20wZksrWE5sazlNZDBveGxDMGZtTE1lQTdaWWNTUkF4?=
 =?utf-8?B?SmlqbVBWeTBZdjZMbVQ5OCs1L3d0Y2Roa2k1NHM5aUJkZ1kxWlE5TlhzaThL?=
 =?utf-8?Q?GNVRRr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDJlQ1J6b1FYVzgzUyszY2RVUmJ4Yk5IMkR6YWxWbGFROXZOd1pzZktlclVJ?=
 =?utf-8?B?L1dST3FrdXhkTjJXL0Rqa3o3OEJZY0hMUDYwM3h0T2labEUxcVZvRk9LVThX?=
 =?utf-8?B?UXFuZ2dWODRGeWxhVDVQS3Q1QkpWSUNCVDg2RU4rVFhLRXpjc3o2M3kySmlI?=
 =?utf-8?B?dmNkVjJHVWN1QktwUDRuMU9qY2lNaERiSWtaTWF5YTZERVcrOVBuWTVrVGhy?=
 =?utf-8?B?ZjU2dlppcnJuYjdZalNPV2tvZWNucW5jeEE0eDJkNWVjUzRlRTNGcC83Q2NV?=
 =?utf-8?B?V1lvZFgvRzVoYnZDcjR5cmZ6OU94S3NHdEZrdTdmbFNjV1JqQXBMVWE3Qm9T?=
 =?utf-8?B?WFFHbTQ0SE12d2FnY1orZ1h2M0kvd1Z4aEZkU0Q3ZFhmQnp6dzJzRE1mVTY1?=
 =?utf-8?B?dzZoN1ZsdlhySmZ1aGxsNSt6V0QwUmJQb1FLeFhFcUl3KzQ1V0xmQllNRDF6?=
 =?utf-8?B?aE1yM0tWVmhLMHpra3ozWWdhV20vL0VwMnk2OXpCdGlsYmJsdXZPMGwwaW1Z?=
 =?utf-8?B?dWEvZzVGTjR2a2xaSGVNZ0owS2dSNGRoV0dDKzhscGxZUWhlaXY2WVErdEps?=
 =?utf-8?B?bmQzNHA1VU1WM25KaUh6aEowUHNJbnVFVnJ0SlFJWlp6bFpRRVkyWEE2K05i?=
 =?utf-8?B?U1dRTDVLZkwwWFBvblluLy9JWUhnbXRlWTltOU1FZUV0TkIwMHQxVy9WbGsz?=
 =?utf-8?B?ZVZDb21VMEZWMi8xbGh2ZHFaTllSclN1eHV5Z3o1WnVEbHRsQ3dJZjMxT0FJ?=
 =?utf-8?B?NkE1aWZBYm5YUlZWVHNDbW9GNjlOZDBOUHdxNS8yenRnQ2Zqd2lJaXpYZmRV?=
 =?utf-8?B?bzdiQmIySDRESVRuckJJNjNkU1ljWjJ5T3JWN2JYYVFwQkNTOThkVlo3L1Jh?=
 =?utf-8?B?ejl1SzA1WmpuRitUbWlLSWF1Vis3SXhWd1VQY1Q2emRGZ2xPWklFWFVZUmo1?=
 =?utf-8?B?ZllPd2w1Tmt6QlNSbjlPWTkraWpra251ditPOFdoVTQ5SExCYkkxRTJ0NURj?=
 =?utf-8?B?Vnc1UElQdUFKc0hPaVRlRHd6bHZLYmdCdGZaUERkUHZwUU9zNGQ4WnVIcnIr?=
 =?utf-8?B?ajJmTXJFRXZaVi9CdTUyZU9mcVBoeFF6SXVOQkpGaFE4cHhPdTd3OTduTEdz?=
 =?utf-8?B?YklYVVhORjUwWWw3QmdvaXJNOU8ySzRHbEZMalpJL0N3c0dGNnFPOG95M2dX?=
 =?utf-8?B?eG1ZSXRnd0xNbkNQczdqdkp4Wi9UUG15alJITXRvNUpxY3A5NzVrNW5MUzdK?=
 =?utf-8?B?MGNMRzIrZFpNdDNlc09hNFZpOTJkUVQxU0lVd0tNcEs5Q00zMTBqZ3RCejVz?=
 =?utf-8?B?bHI0SHRuY0dtMkJZZTVvQk5kSW9QTUxZU0J6WXlpWHFETTMrbjlJbXpRQ3M3?=
 =?utf-8?B?VmNtb2NIekdqZ0NzblVJMDgzK2J5OHNVYnkvMFo2YVlha3FNTjZFMGd2VU9Q?=
 =?utf-8?B?cmpGSCt5ajNNbWJQb0pWWHlXRXhMTWMxUHdGL2RqRytwV2loakIrYndzUitq?=
 =?utf-8?B?MGpOaWJBS09zcjZzcFFGUVNKZzNGWThEMEJGNHBVaFRKSUZDdDJkc05HZ3hU?=
 =?utf-8?B?S05kRjBST3JjU1YvWmFwemNDUEFRTTJkUFRGVU5BWE96c084WlBpc2EwbXkw?=
 =?utf-8?B?MFV1NStKN0d3YlJIbm9RZFUrbHdkL2E0WUU4eVhmQnc3THJSYngvQm9SVUwr?=
 =?utf-8?B?aUJKVFozUUNCcG5kWDg1NVJKWjRjMEpxTkRyaXVYMTlwenFJaURuMlFiNlpJ?=
 =?utf-8?B?SU5JRU84VDBnd1NKNDYzbENlM0hFOUVqNGQ3YkxyV1ZUNFRZU0xjTjI0Q01D?=
 =?utf-8?B?dGM5RHpaZy8rT0hxVitPdVJXT2RUSTdrWDdHVlFONjZqSVR2RU96UGkreG9V?=
 =?utf-8?B?d0plb2RoVFhpaldGR251VzZRUkdLS1JMOThKaW9NVFJwUXBQN0kyVHptV3ZV?=
 =?utf-8?B?WVJJSHBnekUvVnQ1dlZOLzBDVEpQWEU0UTdUN3E2RUs1UnUrelQwTldoZDZC?=
 =?utf-8?B?TGN3aWt1UGlwaW4vc2NHbDNVOENUYnB4ekYyNDZBOTI1dG40QWk2UkMzeUow?=
 =?utf-8?B?NFJRM2dYdVNmMkFtSzRhVDhYY05DMHJwcWVZVmw2a1NCVkwyc0s4RndFQ0hW?=
 =?utf-8?Q?gAHm0r1w9+schTsN5JldHhlEE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F1F1C81F234741BD263CA8582455D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c92c5-b511-4e1d-9ace-08de1d428e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:41:23.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8jDPcu0lEXytUhCZX2mwgWh9ebZ5qTcTTYlXONQnRMN5Ub60QqVvztDDyxdT4bubL66GSQM0yw+ZH5684TYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

T24gV2VkLCAyMDI1LTExLTA1IGF0IDE5OjU0IC0wODAwLCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+
IC11c2UgY3JhdGU6OmdwdTo6e0FyY2hpdGVjdHVyZSwgQ2hpcHNldH07DQo+ICt1c2UgY3JhdGU6
OmdwdTo6ew0KPiArwqDCoMKgIEFyY2hpdGVjdHVyZSwNCj4gK8KgwqDCoCBDaGlwc2V0LCAvLw0K
PiArfTsNCg0KSSBkb24ndCB0aGluayB0aGlzIGNoYW5nZSBzaG91bGQgYmUgcGFydCBvZiB0aGlz
IHBhdGNoLiAgDQo=

