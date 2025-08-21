Return-Path: <linux-kernel+bounces-778730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57EB2E975
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAED1C87C28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166D1B041A;
	Thu, 21 Aug 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BLreti9e"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2618991E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736370; cv=fail; b=mouYjJLm/UhDcqd8SEdHava4xuBxrMD8cdRAEo6e+2KVJ2mru5AGbE+pBVQxsYs951DU8iHCyrC2p0I/Ylo3Ia62UHY0OXeKwkMgtMhOqqBL6HpZuCT0m3The3xvdV2aAUef3Slgt2ZACG6NyK3LFnthkU/5JeCBU7mNvvMlzfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736370; c=relaxed/simple;
	bh=nS2jvFJkkteK4Yw9eS7WlgNs+ZGEyX1Bl/zFFNsau4k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uK019B7BniXaX7XBLh9PEh8PepoBPwINabJDHoD3HeK3qfic0tVqM0+Ab3Un3iE0OmxNK4h+gdng2iy7TjNBpFW7x1XT7vIphQhxGza8fcyUWjotG5yq7OZouFdnrIlhLprUn4sSS/KKfXS2MNlOe4nZtV0NnLL2jRvd/hgs3H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BLreti9e; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQz3w2BhHuygs9mv2KCtYA1ETrey7Y95MCAhOa5UEXjvm/Nd2UX13W9F+8drpPXVTx7LwEvLsq5F6Z3nbXF51sakGTvQ1FffbISJRaOjzFFkkseyKOhpGtAQ2VvMsJzmdxoQSSnHVs9X59SXybx9IxO73nHoFvIfR0X1CYmxeEgl9Umb5+vz1NwQ3fbFOUHXurg4IbMeFz6IPG0DCkoYcHAU/Xyzjl4wGP0ZplJXhU2vAqhvmtxtgP4ClEuMWGd0hUoXxggc2gO5m7VQh9hninblh+b3gb6oUQ8l4cJiM4/dgWQ8341NbPpsSYhjan7FXc7s8rn3DcfuQHIJhJAuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS2jvFJkkteK4Yw9eS7WlgNs+ZGEyX1Bl/zFFNsau4k=;
 b=B/HVdj0TN093Av0RRF3t5Yystp49OAD5jA4e9ZaQWIUD+YpEjBsfesDfCspLcSEEIpsl4/X22ABUrHcccpLf/kTkrj+rjuiW2DAP0cGIJHT1FXRvnv5zmEs9mppkBAKbAwcVykp8JNir5a5Lc10fjgZEj2OIepHjJNTd5S8nNeNbwCFqFRkWaMoxLC4ZsxnYCARtAB0lvs0YGAQfSHvw9sx7wjTufLDHnrQcXqzk6+t9lMcziQdDYwgLkWYHNhMmNRUyO/vd+IqiJq8gNp1vEeupOH9Ug5+9+8VOJlrsdG8CUOKLFqhjUmNpU56lc/rE414NjvJ4DwNhYuWT/jU3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS2jvFJkkteK4Yw9eS7WlgNs+ZGEyX1Bl/zFFNsau4k=;
 b=BLreti9ez+av8ONoCCxfGDNfOaI3e5tqWNFG8mQCuY37Zt9S3a7ZoUSZpl+nAf22DjqJ9kYuHqFk83M6U22mQFX4nk2WfY2G2SBkU66ih3c5ZmfxvK4upLvI7WaG0eWLKkQ9DTlA8oTXGsboCBE5FnD/tcceGs/9nmIeKU7yIpqwf7SG9M8gnPMNLdF8IVqTIE9ZyX8o6568W7qxucX3gPvFnVyy7QQztJIWY8W4mxUSWlmjNgbvme1RskKKbsYJvjKlDq6+Pota0k7etv9iWXqvH6u47OVm3YPlm8FQ2F6JYT+nEoyo3Muc8jAyySJuPUBgGSCOmtW1t7SsCe6RPg==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH7PR03MB7785.namprd03.prod.outlook.com (2603:10b6:610:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 00:32:45 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 00:32:45 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Michael Walle <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
	<linux-mtd@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: RE: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Topic: [PATCH v3 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Index: AQHcAPLLJpnSjUK3G0+J/n9y4LRWFbRKRaUAgAAAp3CAAAT8GoAiGIWg
Date: Thu, 21 Aug 2025 00:32:45 +0000
Message-ID:
 <MN2PR03MB4927D29E06586CCE7D0547FEC632A@MN2PR03MB4927.namprd03.prod.outlook.com>
References: <cover.1753839339.git.khairul.anuar.romli@altera.com>
 <566fc1168db723672ab0bc6482ec7b72b4b8fe2b.1753839339.git.khairul.anuar.romli@altera.com>
 <DBP7P3RWX17B.14Q27IBS3T3FL@kernel.org>
 <MN2PR03MB49271E2D022D305BC149BA4FC624A@MN2PR03MB4927.namprd03.prod.outlook.com>
 <DBP84FIUUQO7.369TFNTJFELMW@kernel.org>
In-Reply-To: <DBP84FIUUQO7.369TFNTJFELMW@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|CH7PR03MB7785:EE_
x-ms-office365-filtering-correlation-id: 32b1faf5-1bd6-4fc6-e399-08dde04a3f4f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWF1Ulg4T2xZa0NOa2xUNFYzSWNSVXI4VFZQb3l4WXpjQVpSL05QT1BXNzNT?=
 =?utf-8?B?RlJOUVZYbXR2dWdkaGZSbG5rYU5oanJOSWtZQ0RDM0xqOVh4NlIwMklrTFBD?=
 =?utf-8?B?V3UzMmtXTE5mRjgvNWp1bjRFenU4V3NLZ1hUSEZSb1dhQzBlNk5sM2FqeFJn?=
 =?utf-8?B?Nm9aWm9RQTZweVJjUHRkNXB2RS9Nd2YvTFE5cHJwVDg3aTlBZ0RHUTdjSmZs?=
 =?utf-8?B?TFYybEEvOGZRVmhBeStBV3dSRnQrazhRZk5PNDZSeENTcnl6V29ZeUd6M2ww?=
 =?utf-8?B?RDlmUSt4RVhmVTBtcGhoLzJ0TWh0MUZYWXpEM1p2VDZ0eHRCVHVxejJPdEVV?=
 =?utf-8?B?cDZxQTZUcG9HUmpTMTVmcWpmWHFqbjVWblVURExtM01nL3hyYjBNN0RsNERz?=
 =?utf-8?B?bmgzODZnU3JXbHZnV01QelB3OE95VEpnMFg5bE1YRWowUG5yL1kvU045UERn?=
 =?utf-8?B?M0V1SnkvUE1DWHIyaGV3WHVMbVBsanBaS0U1K0NPVi9McjFEY04wQzVlQVZ1?=
 =?utf-8?B?czlGMXdzUlV1cG52YzlPQkVsSjltNDBBVXNmK21ZYyt4QkZYOE9XNzd4QVlF?=
 =?utf-8?B?SkZ3YUpSSWE5cy9odi9JNjdCa2VFT3ZzMEdTQS9Ca3J6dXlHNzRNRFdjNmk5?=
 =?utf-8?B?UnZWbXovZkZUVUFZZjcvbkg3TVNIaC82aVlNYjdxcWVsWWVkcXZEMTJlLzla?=
 =?utf-8?B?b0lBYmRsZDFEbjJ6NzE5MnJaSmowQWxkbUlYNzJyTkZlN0xxc0p2clZ5WXlH?=
 =?utf-8?B?OEhzYVgvN01rS3A2aU50NXhDby8rT3JlWStaTDBsY3lWMGc5VGtQWmRmVm9G?=
 =?utf-8?B?UnhDR0JWc2dpK2ZUOHBiMG1uUGNXdHVpYldDM1M2dEJGeXN1cGFTTkZMM1VI?=
 =?utf-8?B?WG1uUzkxalhsVHZTTDEzeW5LRkk4Y1ptUzNuQzdLS2RQT1BoUC9vTE5Wek8w?=
 =?utf-8?B?TUM0L3dLOFdrUVgvNGpZTFc0ZnJiaFBlSU9iRmJSRzNjT1ZWc2U0UG9Ka3p1?=
 =?utf-8?B?SDhMMXByZm1oMFN5QWxZMlVNRGM5ZWlRcGcyTml0WFhPSDN3cCtVbUVSbEVt?=
 =?utf-8?B?M0hwUmt1dDlwdGZXWFpLN1RObmpXUmlubjhQSzdvTVZXS3Zva1I2aDhpOWZw?=
 =?utf-8?B?S0VNZWUzSzRnSWs4bjMwUVkvOEQyK3lpL2IxODNxN1ZNQ1NDTVpzeEVIcXlR?=
 =?utf-8?B?TElDSEJhSDMraUFBKy9WelJYazMrYmJSZWZqT1psdVNLNEFjYTRFZ2w1eTRY?=
 =?utf-8?B?UVhpbFB5eW5MaVZNN254TFBJNmN0QUlhd0ZzMGYzdzlpbXdHck0vMXlOc0Y0?=
 =?utf-8?B?dDhCclVlOFBsdUN0Q1J0SUxKMHJ6a0NKa1lKMVJKenhKRnZ1d2RmK0xHWDMw?=
 =?utf-8?B?K25NZUYvVXdsM3dURkVXSlpiTkNQeCs0TWdHZFU1YlB4bFp3Z2J1ZHE5V2Z2?=
 =?utf-8?B?ZnVZOVlZc0o2WFMyS0lKTE1aQjNZVVJ5cFVxUWVQS0lRRlI5NWdQRUdWMFZZ?=
 =?utf-8?B?WW1YdkxiUGVpQ3FyejFrNkpHQUp0clEvSjNHd0t3Q3hUak1zM0NKcGhmZHhC?=
 =?utf-8?B?TC9lZ1hIU1MzNnZCUFRxcWxiWUMwWVNHT2dMQkpKU0huM3VXa2pFSzdTbmZN?=
 =?utf-8?B?UGVHMVE0c3ZWck5hSGRPbHlCaGRoWDc2Z1MzTkhuUDVjM3FQY0FySm1BS0Ur?=
 =?utf-8?B?UlZ2UU44bk5yd0c3bytwUzdwM2hyeHdsRE81bVNSWmdPMkVBRUtOU2tBc0NL?=
 =?utf-8?B?QWFPMXhkeVFIR1lTNFY1cHIzOERlOFEvTGo3TWFaU2Y0N1FwRFV6aStaTnpD?=
 =?utf-8?B?OXBDaEhHSnVxc2VRK0dsb2trbisvUVRXZGx6eDc0NXJuSzJ2UGw5TmU2N1Zn?=
 =?utf-8?B?UW9hUVhSWkpkc3k5L0VqOFMyeXdVNGgva0JVV2RIV2xvNTRHRm1CMENZK2F2?=
 =?utf-8?B?d0RtTFhqQnJ6ZkVsR2h1NzR5d05kcENGUHdWK053SFhkYlNWYWdycHREeitL?=
 =?utf-8?Q?BjWiLwe4SSr30pLg6EmE/vFwF4Yg7Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnB6RVR4YkMxZFdvQzhoQkQ3NGM5OXdVQ3cyeDdtZjZKNm9MUVkrQzBxNkc3?=
 =?utf-8?B?cTIvdEpVdnJBaCtML1N3ZXF5NVhwRHNybWtYRTdnb0dIQ3ZqZjFtMVBMb01j?=
 =?utf-8?B?bEEwUmpGdWMxL1pwYkxWbUJ4TXpmUDhkalU2d016SjVZdHNRc1RsUEVzWDAv?=
 =?utf-8?B?NHA0T09zVEJ1d3pCWWdmNDdRUzdnZXVOMk42UVNzSzBDZFNmSDNNVTFKVFJE?=
 =?utf-8?B?WXpvK0pHMVI5V0xKejVDKzVMdno0NTFYV0tpamtaWXRTQTFyazhPaEVHNEhq?=
 =?utf-8?B?TWtUU2g1N2pKSS82ekJPakFJVE9QRlo4azRwQVRWOHc4MUtZRFRXMjNvcUdB?=
 =?utf-8?B?ZDdyeHVCZGVuY1NaTzQ1em5seTRQa0JKZFdIVXNZdE1KUWMxczFPVlNPQlJB?=
 =?utf-8?B?cFRHS1RWazczVGpPVlNiVjlhcW1KZk5oZWN4ZkVxWWZRWlBMTFVMT3p1SGg1?=
 =?utf-8?B?TWp3c1pCV21IRWJBbEI0NXhveFBDSStRdDMzZW9SN0hya0h5cWdKcktwY3Fp?=
 =?utf-8?B?NURVUE9GR0xNeXJ0UHFxclZlRk13Y2V3bnFTSG9VbTVNc3lyNi94M0drRnVt?=
 =?utf-8?B?cGdzd0NtOGdjaGpQR2p6SjVkWTltUUdvczZuZWJ6UFZUdmF6REFNL0JWMHZ4?=
 =?utf-8?B?VVNPTTgrdk1VZnFQZk80M1hVQURhdm9nczFrdHMwckRYL1lxSGhTcDBZcFZ0?=
 =?utf-8?B?bHE3V2FBRVZKMzNUWTFPTHM3RGg3UW9COVJuWWhYYkpPVDY4cGhEeW9tVkRP?=
 =?utf-8?B?TGNvY3pHa3lncHVxa2lRd1JmVG9aL3Z2WHhxZUExciswUE1WZFloL3Npb3hH?=
 =?utf-8?B?WHZ0eExTMkVqUytRR1J0WGR0WjN4enlXZDhMUktla3lOcmYxTTllSElleXcw?=
 =?utf-8?B?VStXUmVVYzRFUHo3VnhuVTVDK0NNQitoeHJNQ25rWHl2cjFzVG9mTERQdFFC?=
 =?utf-8?B?eVVGNkVqUi8wOTNzVWN1VktMU0tER3RvKzhKeFQ2UU1ta0ZTWmJ0ODN6THVu?=
 =?utf-8?B?S2dzWmc5NXNSa0VqVmY3Tmk3dlcxQTB2WFF5MU80eXRHbUpvSzlUOUpGUG5J?=
 =?utf-8?B?MWw3ZU5RZHZsSnY4V0dPOEduTEg0UnppdFhWK3llOHJSZkpXbGdkQzVMa0U2?=
 =?utf-8?B?cXo0T2l6a1J0VVd6OXVKZG83RUM2NDI2RVdPTk1Fb2JQV2pnUTFjVnMwK1FI?=
 =?utf-8?B?cmxWSy8wWTdpKzEvS0dHS0J6NFFYYVF5eW1QRlN2bS9BbkdJZElsOTdXeEVB?=
 =?utf-8?B?cnkyYVlwVWQ5TXMvWlZXWGlvemdjY2VNTjdVcDhTa0pxNVBlUmpscUM3MnRI?=
 =?utf-8?B?alViV015OWh6aVk3TGZLcGZUYjMwdHNLWGZBbnBXMEpyMisrSmw4UGFvMDBH?=
 =?utf-8?B?SUpreFJ6eEdIaXVqdGV5SzBHU2pPZWRWYWhkOFI1dmptYVRiWExrMmtMeWFE?=
 =?utf-8?B?UVl4bDlHNVkvL2Fvd2p0Y1J1eEd2Z2FKNEV1dnp3eXVhcWRKV0h4RHVjbm1T?=
 =?utf-8?B?eVpzek8vdnRaQUpQR1VJMElhcFdtQjM3elhGWkZYYWZyaC9VdW1xV01TL2xq?=
 =?utf-8?B?WWJmSWhOZHhBM2lTWmREZDgxcTJBQkNMNnl2dWd6SDlFSWRFZFZoWjU4Z2Jo?=
 =?utf-8?B?dW1JTXhhc2V1Y2FJTzFWZDFqUHgrb05HUGhOQ3RDeE44Wm8zV3hZSjVuSTBZ?=
 =?utf-8?B?MXNXUmdUeERXb2dUTU02WmFYM1F5ZHM5aXhKMlE0a3ZXWlBuTjBVK0JHZmg0?=
 =?utf-8?B?Qy9wU2lrWndtS25ETHc5UGNvR1hqWWZzeUJicmtDdEVDSnFETlpEOFJmOGhC?=
 =?utf-8?B?VkZQMmNlZndybWFHSk9hbHk0KzZTSzZLU3hOb0R3Z0gzQkNPclQwMzBpUFJB?=
 =?utf-8?B?Yy9YVlZTZlRXVGlyUlg2bzIxUlBMaHgyNjcreEF0aEZZZGxoVXZKeWRIWENC?=
 =?utf-8?B?alhSWjZ2TWwycVVjM3V6Y1RSaTRJUUtBd2RVL2RCdWtJTWNkTGVTQ1Y4ZTBw?=
 =?utf-8?B?eUQrZTI0dXozd3dDMEd6UnB0TFc1MnZ6dUNLU1hYQXBJQlF1MFlMZ2J2ZVo4?=
 =?utf-8?B?UVlEY2VQQzYzUm9BckxtUElBTEh0eldUeHhuZ28vcktzWjgyRm9XVlZXYldp?=
 =?utf-8?B?L1MraUlZVkorckcxSTIvcXdFRmdMcEoxanpab2RyTExPMzFMWWUyVzhhck8r?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b1faf5-1bd6-4fc6-e399-08dde04a3f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 00:32:45.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iu7hye2MHndiBvghNb3WJaHFpOKI/WD30MzfsqjHknUDqczzNFccIoW/7MOSfY7iVEXzP8SV8xeZC3bBMJBYlxZuOkxXVVubJK4HixpCdJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7785

SGkgTWljaGFlbCwNCg0KU29ycnkgZm9yIHRha2luZyB2ZXJ5IGxvbmcgdGltZSB0byByZXBseS4g
Q291bGQgeW91IGFkdmlzZSBtZSB3aGF0IGtpbmQgb2YgYW5hbHlzaXMgZG8geW91IHdhbnQgbWUg
dG8gcHJvdmlkZT8NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KS2hhaXJ1bA0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwu
b3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDMwIEp1bHksIDIwMjUgMzo1MCBQTQ0KPiBUbzogUm9t
bGksIEtoYWlydWwgQW51YXIgPGtoYWlydWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbT47IFR1ZG9y
IEFtYmFydXMNCj4gPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz47IFByYXR5dXNoIFlhZGF2IDxw
cmF0eXVzaEBrZXJuZWwub3JnPjsgTWlxdWVsDQo+IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290
bGluLmNvbT47IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Ow0KPiBWaWduZXNo
IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+OyBvcGVuIGxpc3Q6U1BJIE5PUiBTVUJTWVNU
RU0NCj4gPGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgb3BlbiBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gR2VybGFjaCwgTWF0dGhldyA8bWF0dGhldy5nZXJs
YWNoQGFsdGVyYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8xXSBtdGQ6IHNwaS1u
b3I6IGNvcmU6IFByZXZlbnQgb29wcyBkdXJpbmcgZHJpdmVyDQo+IHJlbW92YWwgd2l0aCBhY3Rp
dmUgcmVhZCBvciB3cml0ZSBvcGVyYXRpb25zDQo+IA0KPiBIaSwNCj4gDQo+ID4gPiBPbiBXZWQg
SnVsIDMwLCAyMDI1IGF0IDM6MzkgQU0gQ0VTVCwgS2hhaXJ1bCBBbnVhciBSb21saSB3cm90ZToN
Cj4gPiA+ID4gRnJvbToga3JvbWxpIDxraGFpcnVsLmFudWFyLnJvbWxpQGFsdGVyYS5jb20+DQo+
ID4gPiA+DQo+ID4gPiA+IEVuc3VyZSB0aGF0IHRoZSBwb2ludGVyIHBhc3NlZCB0byBtb2R1bGVf
cHV0KCkgaW4NCj4gPiA+ID4gc3BpX25vcl9wdXRfZGV2aWNlKCkgaXMgbm90IE5VTEwgYmVmb3Jl
IHVzZS4gVGhpcyBjaGFuZ2UgYWRkcyBhDQo+ID4gPiA+IGd1YXJkIGNsYXVzZSB0byByZXR1cm4g
ZWFybHksIHByZXZlbnRpbmcgdGhlIGtlcm5lbCBjcmFzaCBiZWxvdw0KPiA+ID4gPiB3aGVuIHRo
ZSBjYWRlbmNlLXFzcGkgZHJpdmVyIGlzIHJlbW92ZWQgZHVyaW5nIGEgZGQgb3BlcmF0aW9uOg0K
PiA+ID4NCj4gPiA+IEFzIGFscmVhZHkgYXNrZWQgaW4gdjIuIFRoaXMgbmVlZHMgYSAobW9yZSBk
ZXRhaWxlZCkgZGVzY3JpcHRpb24NCj4gPiA+IHdoYXQgaXMgZ29pbmcgb24gYW5kIHdoYXQgaXMg
Z29pbmcgd3JvbmcuDQo+ID4gPg0KPiA+ID4gLW1pY2hhZWwNCj4gPg0KPiA+IEhpLA0KPiA+DQo+
ID4gV2UganVzdCBydW4gdGhlIGZvbGxvd2luZyB0ZXN0IHdlIG9ic2VydmUgdGhlIGNyYXNoLg0K
PiA+DQo+ID4gdGltZSBkZCBpZj0vZGV2L210ZDEgb2Y9b3V0LmltZyBicz0xTUIgY291bnQ9MTAw
MCAmIGVjaG8gc3BpMC4wID4NCj4gPiAvc3lzL2J1cy9zcGkvZHJpdmVycy9zcGktbm9yL3VuYmlu
ZA0KPiA+IGVjaG8gc3BpMC4wID4gL3N5cy9idXMvc3BpL2RyaXZlcnMvc3BpLW5vci9iaW5kDQo+
ID4NCj4gPiBGcm9tIHRoZSBvYnNlcnZhdGlvbiwgdGhlIGRkIGlzIG5vdCBlbnRpcmVseSB0ZXJt
aW5hdGVkIHdoZW4gdGhlIHVuYmluZA0KPiB0b29rIHBsYWNlLg0KPiA+IE1heWJlIHRoZXJlIGlz
IG90aGVyIGNoYW5nZXMgcmVxdWlyZSB0byBlbnN1cmUgdGhlIGRkIG9wZXJhdGlvbiBnZXRzDQo+
ID4gdGVybWluYXRlZCB3aGVuIGRyaXZlciB1bmJpbmQvcmVtb3ZlLg0KPiANCj4gSSdkIGV4cGVj
dCBhbiBhbmFseXNpcyB3aGF0J3MgZ29pbmcgd3JvbmcgaW4gdGhlIGtlcm5lbCB0byBqdWRnZSB0
aGUgY29ycmVjdG5lc3MNCj4gb2YgdGhlIHBhdGNoLg0KPiANCj4gVGhhbmtzLA0KPiAtbWljaGFl
bA0K

