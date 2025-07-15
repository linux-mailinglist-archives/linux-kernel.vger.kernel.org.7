Return-Path: <linux-kernel+bounces-732159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF2B062DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF304A19D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EC204F8B;
	Tue, 15 Jul 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X163asO9"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE721C18A;
	Tue, 15 Jul 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593197; cv=fail; b=A6tdBFEWVHy1bFgxjJHNhUJlyamI5Xj7sMfjKGqaEXwIyAx1mXFezWDCU+WQobjMrHRD4gygju19CAkGvITVu1O5ZlO3TZnb6E0REbOCGCxVJGYFef/MSJvIN3rQwc8q5NKnX44V+19BRdLxAODYIuf7zt3CBfR6HjANL/hFfoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593197; c=relaxed/simple;
	bh=RSd3Bnp4fW/JyyNjw+u4wqc7QOUqV1kc1s9+YvZWU/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srx5Sa08KLDiXE7IREqurAYdfTCTU3EJ0DhcNtfOPk1qe9rvFHo5FuX6C0lrQnnwnCWurrYwQ9RQLvaP5js6anKZnS3go+MD+oJvy8BVh+yyljBdHvFKzYUTGHMAGRWMcZW+3OFM78akKOWFhV3gdfEyMmQ+4Ehd2HRd/1JTj1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X163asO9; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJpKpFeesCDqXDcn1mmPrCuOUAsa7lzj1DhPaO4fystulJF+EoU8gUHa4HxqvWMFzpWzgM9IDheQuYJCII/PdqdhdYEVvQJRsRs7z9JQ9XyJ9uMQZtxTMahuPVH6R8sUi9kmiyUO5AKm7fdsYGjrPQE+jwrgRGOob9tR+gAEUje/MeUYFNswplxCL3bTb/0apAEnwjIX3BvDFPkzguJNO8RG5lfiXQw6IbSQjTYLT4Ul7HlcItCMtNavoTgibecD1SOwv5754rR7zzPblaUDDlZaka38B11dhzkpWY3t/+9QSQrFgH6c87SMx7h0b48GYnlnOlj3hybZ0zO6tfyOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNU7u422M2vwCrvqXZ5ArX6E5y0PBtTGu8TETCKTOd8=;
 b=Tlrm58xZ05x3MXm1fHvp1H2OtZx/cIklpPx/a6xF/QEAsQjpUtFjsXGNzbPJKRYo2Lo+MaZT2/oWCtk6bHmjjXhqJJexrOJUoqd7FzpEJ4fgbEXV28SHzBcFcMp2evisNEekMFQjohMHEi1DIj7HfythnCYpHNwk5N8WfQ2rI406dVKO9RKOYrLgnKfvcd0P1fTF0kUB5yjTKhx337SUx2a9TVxsVdWAmn3t1rdQr2o/ebwH//PwkBavNtn+rw8EwJI6aHyQNxqXEO0HxyrpEC2EBGnsjktapkTKDgU58jn1OwcyOq53DpglyD2addpM8qplRvBVgaY4vgeFMfrfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNU7u422M2vwCrvqXZ5ArX6E5y0PBtTGu8TETCKTOd8=;
 b=X163asO9K/26YPo878XDlegu7UvrQwcVzKsa7RdIOE9t5MmNDTyfmdY+8iX1LO2w/VAmZx4Sy1OOCNliG1/69XW0UiRB3MCcQpJoNuxweYxzS1lvj7vteIxqhOfk0fdc1Ur0TtoajodCf9DnsEi4c4bfM/jfv9YPA9E/tKepO9+H+sr+Cuyxzei2f5O/5DWoRw7G5MHDXMzXdTAl7VRC677BzjFkE6Rk42SEsO6mW8CA0h9qh8XjqhIJ/+Ny0o74I5RiBgoVIcjEHlcRE5PFI9LUhtCl2Q6p9zE0qlAfQR7swhLEgTfYDhvLaP2yPGfffBtHp5A8M/HAcuTiUgbgmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9757.eurprd04.prod.outlook.com (2603:10a6:150:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 15:26:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 15:26:30 +0000
Date: Tue, 15 Jul 2025 11:26:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	gastmaier@gmail.com
Subject: Re: [PATCH v5 2/2] i3c: master: Add driver for Analog Devices I3C
 Controller IP
Message-ID: <aHZzImGbgISePnNJ@lizhi-Precision-Tower-5810>
References: <20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com>
 <20250715-adi-i3c-master-v5-2-c89434cbaf5e@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715-adi-i3c-master-v5-2-c89434cbaf5e@analog.com>
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d16b7b-1c80-4f1f-5a67-08ddc3b3f903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFRNmhxOHdoUlczWGpWWldrMmNXeldPU0ZCd205TGpVVEdyU1UzMkVQbENG?=
 =?utf-8?B?d2ZyWXI2eTNjSHFMTGVvNDVYWVdCT2JjYWFONVZ0S3E2ZG80bnozakh3cjhi?=
 =?utf-8?B?WlVRZDhVVVBmVGhYMThoNkZlNTJaVGw5bXFHQ1A0ZW45Q3lyS0lTd0RtVzZH?=
 =?utf-8?B?RE9tUWRKcWR1ZDR4RU5TU1ljdWNSM01EaGVDMTlNd0hyaEF6eWppdmp3SlJH?=
 =?utf-8?B?b2pZdWpLcllBY0VudWZUTVE2aHl1VWRoKzhUT3VDRkpXRUJWVkpRbW1MRDlT?=
 =?utf-8?B?L2llRVQzRnM2c3VNYVFZUVBKRS9xdnNITm0remxoSmt3dmEzQUNVMFo4dUJz?=
 =?utf-8?B?SFpyL3VreHNlYk42OGdOVFczc2JLWkNyZmRTVDNrSzlPMDFrK1Y3MXE1VE5w?=
 =?utf-8?B?Skt1YjZ2d3B2T09XclY2V1Axd1NOQm5CajE4dU13VllFYm5ldEJQc3B4cm9q?=
 =?utf-8?B?U0JidWxxd0tYM1lZR2VGNHZBdE1VZHpEQm4xd0hvc0d6MTNkWHNMNWllS3Ju?=
 =?utf-8?B?OTdjRFFlYnNRTzgyeVNLd1k1Tk1PVHlzM09RajE5cVlSOUUzM05nNk1CeXhn?=
 =?utf-8?B?dWs3UmxwWFhZaEVCZ2k1YlZmZ0FZWDFhd1RZenRzdWh5U01ld05YeTNqYTFW?=
 =?utf-8?B?bFp3TUZpcDBUM0VsSi9SSzg4SWFhVTViWUVaUUNLNyt5WUpqVG1DalMvMVkx?=
 =?utf-8?B?a2d0UlR3OThiRTg1M3lOT2phTGpMcEltOG13MllYdEVKT0dtVUxTb29zNzMy?=
 =?utf-8?B?bXNJeWJHQ2d3L050RTBHSW1oQWtaRmQzN1g1SVVBUERjd0dJdnhhTy9HZ1BG?=
 =?utf-8?B?TTB6akk1cDhNdkRHbEw1SjJSSm1LSHh1QXJQcFhsdXVkMGRCZlE3Zm45UlB1?=
 =?utf-8?B?eFJNZ21aZ2dKcnFTQWtXempJNEY3cVpJZjJKQ0lvZDl5cU5MVFAweUNiakNR?=
 =?utf-8?B?ZUJwN1ZLajBVMmtJQ3hrRm52ZTVPR1FpYkRMSkpTYTZ0YzhSVFBUSUdLUGVm?=
 =?utf-8?B?VkVhbDZ2Q1FSZzNzbVFvUGlUTHdHb1UxRGpoWEVTTTNVWGx6TUI0WElHT0FE?=
 =?utf-8?B?YWhPQ0M3RUp0RFYzQUZxN0VhUXVVQmxHV3BnWk11dGhuWjlEZ2hQQmE2YlJo?=
 =?utf-8?B?eHJQbGRlN2FCcDJPN1JKa1J0WmZTWVdTSzROT2FSNTB3Ymc4VXpacVB4YXJZ?=
 =?utf-8?B?VHl1UE5YaGtsZkRIeVFtbndKU3lha0ZoTnVqdUdoRjdmSkFOL0ZOWEpBaTc1?=
 =?utf-8?B?QXJtaUh3d0hsUVJGWUxRS2xJTWszUVFoUGx6S3VUclh6NnE5VGJ0czJnQUJj?=
 =?utf-8?B?MU5EUUI1OC9yQnBSbUU2dEY0S05vOFgyL200c1kwYkVkaVZaUy9GTm41QlFH?=
 =?utf-8?B?QWFjMHRoVmFKVEpsVHgxL1IwUFRnUi9yeXVPYWZGZkUwZkgzQlprUVJwZHFC?=
 =?utf-8?B?UXZDcndTNWJHMFI5VFlWeXllV2xDVTAwaHc2enBycmNPUDVGOFEwalVwUlhM?=
 =?utf-8?B?bzNySmZEOW1CWHdCSTNva3dvazlESTZEc0ZGV1U2a2Q2SFEzbjdNVWhza1Vw?=
 =?utf-8?B?Z25uT2p0NkZoMVBHSnB5VFo1Vk40MWFSYWdxTUo1cHo1bHVQaDZqL0JoUVMy?=
 =?utf-8?B?RXhvanlKQS92bmlJOERndFZXUklOR0x4Z1MwNFBpL1pVMmlQRHdVNkk2b1kx?=
 =?utf-8?B?b3BBa0FYS1p6RXBzS05GZnZQaWY4eUpJSCtTVTR5aEw1UlBUa29HaXNIWUp6?=
 =?utf-8?B?bFdjYjljVk11TWxBSXZHdk1Ea3RrUHFFVE1KZWRoMnNuYUh4ZkNNY2hEdXFO?=
 =?utf-8?B?RHZJYUVKeVd5YXhQTUNlK1R0eVNmZUFMdm9BV2hjNDRjMG8vRXNFVGhmcHpJ?=
 =?utf-8?B?aTd6eDV1d21EMkovNUlJWWV4N3NaVVQ5UXk3S1p1cWliaFFFNURJUG9BQWxC?=
 =?utf-8?B?Uk5EelJHZUZ4YUEydi9Vblo1UzJKUHMvMjZLdjcvYUJUaGJyVlVmVERTOFI4?=
 =?utf-8?B?Yyt5Tk1jaXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5aMCs3YXNGUjFDRkc0ZUlLNHpvam9qTWozMXdoQlZ6UkhtY2tFcGhVNVZH?=
 =?utf-8?B?SGhxSVdhZnU2VUdoTkFPZm9wUndvdzFEVUx2bGRqUjM0bC81c3VsNEUwc1Ry?=
 =?utf-8?B?WFpuSnUvWWU0WG9GZExXSm1rUFZsbTBWRmExRndZK0E0czhQdTAyT0tyeUlF?=
 =?utf-8?B?VUZvQWNzT1lMdktBaG1JcnlvMFFZUkw1K0MraURxQWtrNWU5dExqSFl0T1lT?=
 =?utf-8?B?b2Y0aTFSbmw3cnVsN0tDY016WVlzMFp0K1UyRWNXNXJKbkV5YjBOOVZ5aDZ2?=
 =?utf-8?B?WWl2M3lHSU90VlcyM2IyeUFMeThlY2hTR0FVRDAvUWxuY20rdCttZHFUMDJi?=
 =?utf-8?B?YjBnQ29yVnVaRXZpSTYvdDY3V2lNYlNYSXZZUlBQS3ZVY08rSkpCZ3lXR2FS?=
 =?utf-8?B?R2dGbXlWeWsrR2h2b2dxNTNBd2tlbFdnZnRyQUdQYitVYi9aeHJXbXgxMnJE?=
 =?utf-8?B?dHNvQXZKUWlIT3FGTHV3WS9mM1llalBBZklpZmV3NUVMTGdlNDVPVzBWaURq?=
 =?utf-8?B?NmlvdTVoc09TQkVZRi9kRldEVlVuS3VVdEpUL1ZLNHBWMFpweHN5amdGWnda?=
 =?utf-8?B?TE1DemYrR1hFVEs5bEkwVGc4QVNPSlFiOHhjb0FVWmdrWXhPM0E4UFpvNE1p?=
 =?utf-8?B?TTdYWkt6Y3BHS3JlMTdZR09oRVRPYmdJTmdMMkFUc0UwdDRIMElBMEpKVFor?=
 =?utf-8?B?RHBxMHVQa1E4T1h6Q0FaZzFGL3ZUMVAxeENOQVZUNXkxU2U4YTJlTzVIM1FN?=
 =?utf-8?B?czlHT3lUWHVXTG1TRlNnUFRvaXVaZ29VQWFoeVVzT1NrSllwRlE5VjZhNDdr?=
 =?utf-8?B?Q1dLVlRSMC9xeEtYQmR3VzFrQ3NLUUM4WVRnSm9vcW1yelJuK1J6WE5FMHh1?=
 =?utf-8?B?SklxaWhTU1lDSThCT0dsWk12ZlJLVlFQak1MaDJ4djI4Z2hRWkR6aEo0RlZk?=
 =?utf-8?B?U081aFNuK0E3aXI4bmczRDNYMDhubDZrVDBWZmplSXdnZVlYTW5ZVGlDdXNq?=
 =?utf-8?B?QzZlT1pzdWZMNHVvSGphVnFNY0N3b3lFMlhGcW44ZWZRR1ZiTTZzZE1oRWxW?=
 =?utf-8?B?TGtHQXA4TGtpU3BjU0phUlkyRjl6SFlnUGNRNHdtNlNaRmduRWQ5OVpPbG5h?=
 =?utf-8?B?OWZBeHovZGtjNEJMbzJrVFV2ZU0rK0RkTEpCeW5mMXplSWt2N3ZYZ3Z1bFM1?=
 =?utf-8?B?TlpXbXk5WWxzVUlVNVhWN1Q0em1DRGlYUkwzcVQ0emF0bnpoUDNtRDVLUFVE?=
 =?utf-8?B?aVZkY1Izam13TTNKZGpacUl3K0oyUDJVcTNSZVREaVJKQ0Y5QWFJdWVjaHVH?=
 =?utf-8?B?UlRMT3pPYUdLSnA3eEdvNVJsQ1BtTlBKaTFSL1ZLdExMUjEyL3hxNFBrcjVS?=
 =?utf-8?B?Z1B3M0g0aXo0akFKTDRSbTdmMjMxUG9xTGdHRTZMdEtoU3BxcmF6WlJRRkF4?=
 =?utf-8?B?dTA4cUdSZEs1a2JIcWM4elUxMjU5QXBPZ2JEYkVNbDBiZkRaRGthVVExRmVo?=
 =?utf-8?B?SysvTWlZY3ppYldESG1lbjFkcWZxSzBvR2dUbjFsNlM0VHVDT2FqQVV2dE80?=
 =?utf-8?B?Yi83SWtwK3IycVViVzBZL3orWEl3dFVRSlo5RWo4V0V4YkNnK2J6NDhxbUpz?=
 =?utf-8?B?cmNWUGtUeHpyVWNkTGpmZ3lQZjYyaUwvS0J5NTZ6dkxjVmxFMnEyUFBIZ3p5?=
 =?utf-8?B?MkhtanF3bVpiYVRRQUw2M0Rhd0RIQ3VNS3BIRHQvL0Q1MUtEa1lubHJkejVi?=
 =?utf-8?B?L2xUUllYZi9KWC9SZjRJN3ZKNHhHZmFjd3F2TlZpZlVZa2NkMFVvUnpsQ0xH?=
 =?utf-8?B?OVIwd2pORG83MWM0NkpOWjFoc1dDOFpMMFV5dkVGbHEwdndScFRkWFBNWGk5?=
 =?utf-8?B?ZXN5QUtZcXp4M3Vsbk5Qd0EzbTZBR09KQW5yWDN6UjgyRDJsYXhkUSs2L2NZ?=
 =?utf-8?B?eU42Yk5iRUJoVWV2eUpTd1VYNnpqbkxMQTNpT1VRYmtqVUhuNGllNjM0V1JT?=
 =?utf-8?B?ZlV3Um5NZnp4MmtyaHhINkVHb084RTRRTk1RdjlCUmZEOGV4K0NkVkJFVi9Z?=
 =?utf-8?B?WU9PVEQ2RFR5VFRRSGtxOHgwYVYrMHhSKzVHTkpvc1NMSVAxMnJEN0xrZ1VB?=
 =?utf-8?Q?o58c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d16b7b-1c80-4f1f-5a67-08ddc3b3f903
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:26:30.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfL9V5+XnIeXiQbt9P2Tiesafzi4/wcPm8I0lCVfl+aO6r8mW5FyOlQZ53Cs4KlzJO/lFLpyBfsaEnnxJgUjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9757

On Tue, Jul 15, 2025 at 10:56:04AM +0200, Jorge Marques wrote:
> Add support for Analog Devices I3C Controller IP, an AXI-interfaced IP
> core that supports I3C and I2C devices, multiple speed-grades and
> I3C IBIs.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  MAINTAINERS                         |    1 +
>  drivers/i3c/master/Kconfig          |   11 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/adi-i3c-master.c | 1019 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1032 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f212529276f4ab28f4b7d16b4105a8cf9ff5e2e..f527a1276358cc03b7c3461c2aa1aedfb0e9fbbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11456,6 +11456,7 @@ I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
>  M:	Jorge Marques <jorge.marques@analog.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> +F:	drivers/i3c/master/adi-i3c-master.c

Add i3c mail list?

>
>  I3C DRIVER FOR CADENCE I3C MASTER IP
>  M:	Przemysław Gaj <pgaj@cadence.com>
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 7b30db3253af9d5c6aee6544c060e491bfbeb643..e0153362de9b6fe4eb11841fdc7e0b17a858e4f8 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -1,4 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config ADI_I3C_MASTER
> +	tristate "Analog Devices I3C master driver"
> +	depends on HAS_IOMEM
> +	help
> +	  Support for Analog Devices I3C Controller IP, an AXI-interfaced IP
> +	  core that supports I3C and I2C devices, multiple speed-grades and I3C
> +	  IBIs.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called adi-i3c-master.
> +
>  config CDNS_I3C_MASTER
>  	tristate "Cadence I3C master driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index 3e97960160bc85e5eaf2966ec0c3fae458c2711e..6cc4f4b73e7bdc206b68c750390f9c3cc2ccb199 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ADI_I3C_MASTER)		+= adi-i3c-master.o
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..771e46fd6c2b9d5349a7adc490cfb6d112bf86d3
> --- /dev/null
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -0,0 +1,1019 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * I3C Controller driver
> + * Copyright 2025 Analog Devices Inc.
> + * Author: Jorge Marques <jorge.marques@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fpga/adi-axi-common.h>
> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "../internals.h"
> +
> +#define ADI_MAX_DEVS			16
> +#define ADI_HAS_MDB_FROM_BCR(x)		(FIELD_GET(BIT(2), (x)))
> +
> +#define REG_ENABLE			0x040
> +
> +#define REG_PID_L			0x054
> +#define REG_PID_H			0x058
> +#define REG_DCR_BCR_DA			0x05C

nit: 0x5c to keep consistency with other hex value.

Look good overall, thank you very much.

Frank

> +#define   REG_DCR_BCR_DA_GET_DA(x)	FIELD_GET(GENMASK(22, 16), (x))
> +#define   REG_DCR_BCR_DA_GET_BCR(x)	FIELD_GET(GENMASK(15, 8), (x))
> +#define   REG_DCR_BCR_DA_GET_DCR(x)	FIELD_GET(GENMASK(7, 0), (x))
> +
> +#define REG_IRQ_MASK			0x080
> +#define REG_IRQ_PENDING			0x084
> +#define   REG_IRQ_PENDING_DAA		BIT(7)
> +#define   REG_IRQ_PENDING_IBI		BIT(6)
> +#define   REG_IRQ_PENDING_CMDR		BIT(5)
> +
> +#define REG_CMD_FIFO			0x0d4
> +#define   REG_CMD_FIFO_0_IS_CCC		BIT(22)
> +#define   REG_CMD_FIFO_0_BCAST		BIT(21)
> +#define   REG_CMD_FIFO_0_SR		BIT(20)
> +#define   REG_CMD_FIFO_0_LEN(l)		FIELD_PREP(GENMASK(19, 8), (l))
> +#define   REG_CMD_FIFO_0_DEV_ADDR(a)	FIELD_PREP(GENMASK(7, 1), (a))
> +#define   REG_CMD_FIFO_0_RNW		BIT(0)
> +#define   REG_CMD_FIFO_1_CCC(id)	FIELD_PREP(GENMASK(7, 0), (id))
> +
> +#define REG_CMD_FIFO_ROOM		0x0c0
> +#define REG_CMDR_FIFO			0x0d8
> +#define   REG_CMDR_FIFO_UDA_ERROR	8
> +#define   REG_CMDR_FIFO_NACK_RESP	6
> +#define   REG_CMDR_FIFO_CE2_ERROR	4
> +#define   REG_CMDR_FIFO_CE0_ERROR	1
> +#define   REG_CMDR_FIFO_NO_ERROR	0
> +#define   REG_CMDR_FIFO_ERROR(x)	FIELD_GET(GENMASK(23, 20), (x))
> +#define   REG_CMDR_FIFO_XFER_BYTES(x)	FIELD_GET(GENMASK(19, 8), (x))
> +
> +#define REG_SDO_FIFO			0x0dc
> +#define REG_SDO_FIFO_ROOM		0x0c8
> +#define REG_SDI_FIFO			0x0e0
> +#define REG_IBI_FIFO			0x0e4
> +#define REG_FIFO_STATUS			0x0e8
> +#define   REG_FIFO_STATUS_CMDR_EMPTY	BIT(0)
> +#define   REG_FIFO_STATUS_IBI_EMPTY	BIT(1)
> +
> +#define REG_OPS				0x100
> +#define   REG_OPS_PP_SG_MASK		GENMASK(6, 5)
> +#define   REG_OPS_SET_SG(x)		FIELD_PREP(REG_OPS_PP_SG_MASK, (x))
> +
> +#define REG_IBI_CONFIG			0x140
> +#define   REG_IBI_CONFIG_ENABLE		BIT(0)
> +#define   REG_IBI_CONFIG_LISTEN		BIT(1)
> +
> +#define REG_DEV_CHAR			0x180
> +#define   REG_DEV_CHAR_IS_I2C		BIT(0)
> +#define   REG_DEV_CHAR_IS_ATTACHED	BIT(1)
> +#define   REG_DEV_CHAR_BCR_IBI(x)	FIELD_PREP(GENMASK(3, 2), (x))
> +#define   REG_DEV_CHAR_WEN		BIT(8)
> +#define   REG_DEV_CHAR_ADDR(x)		FIELD_PREP(GENMASK(15, 9), (x))
> +
> +enum speed_grade {PP_SG_UNSET, PP_SG_1MHZ, PP_SG_3MHZ, PP_SG_6MHZ, PP_SG_12MHZ};
> +
> +struct adi_i3c_cmd {
> +	u32 cmd0;
> +	u32 cmd1;
> +	u32 tx_len;
> +	const void *tx_buf;
> +	u32 rx_len;
> +	void *rx_buf;
> +	u32 error;
> +};
> +
> +struct adi_i3c_xfer {
> +	struct list_head node;
> +	struct completion comp;
> +	int ret;
> +	unsigned int ncmds;
> +	unsigned int ncmds_comp;
> +	struct adi_i3c_cmd cmds[] __counted_by(ncmds);
> +};
> +
> +struct adi_i3c_master {
> +	struct i3c_master_controller base;
> +	u32 free_rr_slots;
> +	struct {
> +		unsigned int num_slots;
> +		struct i3c_dev_desc **slots;
> +		spinlock_t lock; /* Protect IBI slot access */
> +	} ibi;
> +	struct {
> +		struct list_head list;
> +		struct adi_i3c_xfer *cur;
> +		spinlock_t lock; /* Protect transfer */
> +	} xferqueue;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	unsigned long i3c_scl_lim;
> +	struct {
> +		u8 addrs[ADI_MAX_DEVS];
> +		u8 index;
> +	} daa;
> +};
> +
> +static inline struct adi_i3c_master *to_adi_i3c_master(struct i3c_master_controller *master)
> +{
> +	return container_of(master, struct adi_i3c_master, base);
> +}
> +
> +static void adi_i3c_master_wr_to_tx_fifo(struct adi_i3c_master *master,
> +					 const u8 *buf, unsigned int nbytes)
> +{
> +	unsigned int n, m;
> +
> +	n = readl(master->regs + REG_SDO_FIFO_ROOM);
> +	m = min(n, nbytes);
> +	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, nbytes);
> +}
> +
> +static void adi_i3c_master_rd_from_rx_fifo(struct adi_i3c_master *master,
> +					   u8 *buf, unsigned int nbytes)
> +{
> +	i3c_readl_fifo(master->regs + REG_SDI_FIFO, buf, nbytes);
> +}
> +
> +static bool adi_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
> +					    const struct i3c_ccc_cmd *cmd)
> +{
> +	if (cmd->ndests > 1)
> +		return false;
> +
> +	switch (cmd->id) {
> +	case I3C_CCC_ENEC(true):
> +	case I3C_CCC_ENEC(false):
> +	case I3C_CCC_DISEC(true):
> +	case I3C_CCC_DISEC(false):
> +	case I3C_CCC_RSTDAA(true):
> +	case I3C_CCC_RSTDAA(false):
> +	case I3C_CCC_ENTDAA:
> +	case I3C_CCC_SETDASA:
> +	case I3C_CCC_SETNEWDA:
> +	case I3C_CCC_GETMWL:
> +	case I3C_CCC_GETMRL:
> +	case I3C_CCC_GETPID:
> +	case I3C_CCC_GETBCR:
> +	case I3C_CCC_GETDCR:
> +	case I3C_CCC_GETSTATUS:
> +	case I3C_CCC_GETHDRCAP:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static int adi_i3c_master_disable(struct adi_i3c_master *master)
> +{
> +	writel(0, master->regs + REG_IBI_CONFIG);
> +
> +	return 0;
> +}
> +
> +static struct adi_i3c_xfer *adi_i3c_master_alloc_xfer(struct adi_i3c_master *master,
> +						      unsigned int ncmds)
> +{
> +	struct adi_i3c_xfer *xfer;
> +
> +	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
> +	if (!xfer)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&xfer->node);
> +	xfer->ncmds = ncmds;
> +	xfer->ret = -ETIMEDOUT;
> +
> +	return xfer;
> +}
> +
> +static void adi_i3c_master_start_xfer_locked(struct adi_i3c_master *master)
> +{
> +	struct adi_i3c_xfer *xfer = master->xferqueue.cur;
> +	unsigned int i, n, m;
> +
> +	if (!xfer)
> +		return;
> +
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct adi_i3c_cmd *cmd = &xfer->cmds[i];
> +
> +		if (!(cmd->cmd0 & REG_CMD_FIFO_0_RNW))
> +			adi_i3c_master_wr_to_tx_fifo(master, cmd->tx_buf, cmd->tx_len);
> +	}
> +
> +	n = readl(master->regs + REG_CMD_FIFO_ROOM);
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct adi_i3c_cmd *cmd = &xfer->cmds[i];
> +
> +		m = cmd->cmd0 & REG_CMD_FIFO_0_IS_CCC ? 2 : 1;
> +		if (m > n)
> +			break;
> +		writel(cmd->cmd0, master->regs + REG_CMD_FIFO);
> +		if (cmd->cmd0 & REG_CMD_FIFO_0_IS_CCC)
> +			writel(cmd->cmd1, master->regs + REG_CMD_FIFO);
> +		n -= m;
> +	}
> +}
> +
> +static void adi_i3c_master_end_xfer_locked(struct adi_i3c_master *master,
> +					   u32 pending)
> +{
> +	struct adi_i3c_xfer *xfer = master->xferqueue.cur;
> +	int i, ret = 0;
> +
> +	if (!xfer)
> +		return;
> +
> +	while (!(readl(master->regs + REG_FIFO_STATUS) & REG_FIFO_STATUS_CMDR_EMPTY)) {
> +		struct adi_i3c_cmd *cmd;
> +		u32 cmdr, rx_len;
> +
> +		cmdr = readl(master->regs + REG_CMDR_FIFO);
> +
> +		cmd = &xfer->cmds[xfer->ncmds_comp++];
> +		if (cmd->cmd0 & REG_CMD_FIFO_0_RNW) {
> +			rx_len = min_t(u32, REG_CMDR_FIFO_XFER_BYTES(cmdr), cmd->rx_len);
> +			adi_i3c_master_rd_from_rx_fifo(master, cmd->rx_buf, rx_len);
> +		}
> +		cmd->error = REG_CMDR_FIFO_ERROR(cmdr);
> +	}
> +
> +	for (i = 0; i < xfer->ncmds_comp; i++) {
> +		switch (xfer->cmds[i].error) {
> +		case REG_CMDR_FIFO_NO_ERROR:
> +			break;
> +
> +		case REG_CMDR_FIFO_CE0_ERROR:
> +		case REG_CMDR_FIFO_CE2_ERROR:
> +		case REG_CMDR_FIFO_NACK_RESP:
> +		case REG_CMDR_FIFO_UDA_ERROR:
> +			ret = -EIO;
> +			break;
> +
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	xfer->ret = ret;
> +
> +	if (xfer->ncmds_comp != xfer->ncmds)
> +		return;
> +
> +	complete(&xfer->comp);
> +
> +	xfer = list_first_entry_or_null(&master->xferqueue.list,
> +					struct adi_i3c_xfer, node);
> +	if (xfer)
> +		list_del_init(&xfer->node);
> +
> +	master->xferqueue.cur = xfer;
> +	adi_i3c_master_start_xfer_locked(master);
> +}
> +
> +static void adi_i3c_master_queue_xfer(struct adi_i3c_master *master,
> +				      struct adi_i3c_xfer *xfer)
> +{
> +	init_completion(&xfer->comp);
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +	if (master->xferqueue.cur) {
> +		list_add_tail(&xfer->node, &master->xferqueue.list);
> +	} else {
> +		master->xferqueue.cur = xfer;
> +		adi_i3c_master_start_xfer_locked(master);
> +	}
> +}
> +
> +static void adi_i3c_master_unqueue_xfer(struct adi_i3c_master *master,
> +					struct adi_i3c_xfer *xfer)
> +{
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +	if (master->xferqueue.cur == xfer)
> +		master->xferqueue.cur = NULL;
> +	else
> +		list_del_init(&xfer->node);
> +
> +	writel(0x01, master->regs + REG_ENABLE);
> +	writel(0x00, master->regs + REG_ENABLE);
> +	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
> +}
> +
> +static enum i3c_error_code adi_i3c_cmd_get_err(struct adi_i3c_cmd *cmd)
> +{
> +	switch (cmd->error) {
> +	case REG_CMDR_FIFO_CE0_ERROR:
> +		return I3C_ERROR_M0;
> +
> +	case REG_CMDR_FIFO_CE2_ERROR:
> +	case REG_CMDR_FIFO_NACK_RESP:
> +		return I3C_ERROR_M2;
> +
> +	default:
> +		break;
> +	}
> +
> +	return I3C_ERROR_UNKNOWN;
> +}
> +
> +static int adi_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> +				       struct i3c_ccc_cmd *cmd)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	struct adi_i3c_cmd *ccmd;
> +
> +	xfer = adi_i3c_master_alloc_xfer(master, 1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	ccmd = xfer->cmds;
> +	ccmd->cmd1 = REG_CMD_FIFO_1_CCC(cmd->id);
> +	ccmd->cmd0 = REG_CMD_FIFO_0_IS_CCC |
> +		     REG_CMD_FIFO_0_LEN(cmd->dests[0].payload.len);
> +
> +	if (cmd->id & I3C_CCC_DIRECT)
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_DEV_ADDR(cmd->dests[0].addr);
> +
> +	if (cmd->rnw) {
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +		ccmd->rx_buf = cmd->dests[0].payload.data;
> +		ccmd->rx_len = cmd->dests[0].payload.len;
> +	} else {
> +		ccmd->tx_buf = cmd->dests[0].payload.data;
> +		ccmd->tx_len = cmd->dests[0].payload.len;
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	cmd->err = adi_i3c_cmd_get_err(&xfer->cmds[0]);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> +				     struct i3c_priv_xfer *xfers,
> +				     int nxfers)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	int i, ret;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = adi_i3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct adi_i3c_cmd *ccmd = &xfer->cmds[i];
> +
> +		ccmd->cmd0 = REG_CMD_FIFO_0_DEV_ADDR(dev->info.dyn_addr);
> +
> +		if (xfers[i].rnw) {
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +			ccmd->rx_buf = xfers[i].data.in;
> +			ccmd->rx_len = xfers[i].len;
> +		} else {
> +			ccmd->tx_buf = xfers[i].data.out;
> +			ccmd->tx_len = xfers[i].len;
> +		}
> +
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_LEN(xfers[i].len);
> +
> +		if (i < nxfers - 1)
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_SR;
> +
> +		if (!i)
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_BCAST;
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp,
> +					 msecs_to_jiffies(1000)))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	ret = xfer->ret;
> +
> +	for (i = 0; i < nxfers; i++)
> +		xfers[i].err = adi_i3c_cmd_get_err(&xfer->cmds[i]);
> +
> +	return ret;
> +}
> +
> +struct adi_i3c_i2c_dev_data {
> +	struct i3c_generic_ibi_pool *ibi_pool;
> +	u16 id;
> +	s16 ibi;
> +};
> +
> +static int adi_i3c_master_get_rr_slot(struct adi_i3c_master *master,
> +				      u8 dyn_addr)
> +{
> +	if (!master->free_rr_slots)
> +		return -ENOSPC;
> +
> +	return ffs(master->free_rr_slots) - 1;
> +}
> +
> +static int adi_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 dyn_addr)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	u8 addr;
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(dyn_addr), master->regs + REG_DEV_CHAR);
> +	writel((readl(master->regs + REG_DEV_CHAR) &
> +		~REG_DEV_CHAR_IS_ATTACHED) | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel(readl(master->regs + REG_DEV_CHAR) |
> +	       REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	int slot;
> +	u8 addr;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	slot = adi_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
> +	if (slot < 0) {
> +		kfree(data);
> +		return slot;
> +	}
> +
> +	data->id = slot;
> +	i3c_dev_set_master_data(dev, data);
> +	master->free_rr_slots &= ~BIT(slot);
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel(readl(master->regs + REG_DEV_CHAR) |
> +	       REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_sync_dev_char(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_dev_desc *i3cdev;
> +	u32 bcr_ibi;
> +	u8 addr;
> +
> +	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
> +		addr = i3cdev->info.dyn_addr ?
> +		       i3cdev->info.dyn_addr : i3cdev->info.static_addr;
> +		writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +		bcr_ibi = FIELD_GET(I3C_BCR_IBI_PAYLOAD | I3C_BCR_IBI_REQ_CAP, (i3cdev->info.bcr));
> +		writel(readl(master->regs + REG_DEV_CHAR) |
> +		       REG_DEV_CHAR_BCR_IBI(bcr_ibi) | REG_DEV_CHAR_WEN,
> +		       master->regs + REG_DEV_CHAR);
> +	}
> +}
> +
> +static void adi_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +	u8 addr;
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel((readl(master->regs + REG_DEV_CHAR) &
> +		~REG_DEV_CHAR_IS_ATTACHED) | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	i3c_dev_set_master_data(dev, NULL);
> +	master->free_rr_slots |= BIT(data->id);
> +	kfree(data);
> +}
> +
> +static int adi_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	int slot;
> +
> +	slot = adi_i3c_master_get_rr_slot(master, 0);
> +	if (slot < 0)
> +		return slot;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = slot;
> +	master->free_rr_slots &= ~BIT(slot);
> +	i2c_dev_set_master_data(dev, data);
> +
> +	writel(REG_DEV_CHAR_ADDR(dev->addr) |
> +	       REG_DEV_CHAR_IS_I2C | REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
> +
> +	writel(REG_DEV_CHAR_ADDR(dev->addr) |
> +	       REG_DEV_CHAR_IS_I2C | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	i2c_dev_set_master_data(dev, NULL);
> +	master->free_rr_slots |= BIT(data->id);
> +	kfree(data);
> +}
> +
> +static void adi_i3c_master_bus_cleanup(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +
> +	adi_i3c_master_disable(master);
> +}
> +
> +static void adi_i3c_master_upd_i3c_scl_lim(struct adi_i3c_master *master)
> +{
> +	struct i3c_master_controller *m = &master->base;
> +	struct i3c_bus *bus = i3c_master_get_bus(m);
> +	u8 i3c_scl_lim = 0;
> +	struct i3c_dev_desc *dev;
> +	u8 pp_sg;
> +
> +	i3c_bus_for_each_i3cdev(bus, dev) {
> +		u8 max_fscl;
> +
> +		max_fscl = max(I3C_CCC_MAX_SDR_FSCL(dev->info.max_read_ds),
> +			       I3C_CCC_MAX_SDR_FSCL(dev->info.max_write_ds));
> +
> +		switch (max_fscl) {
> +		case I3C_SDR1_FSCL_8MHZ:
> +			max_fscl = PP_SG_6MHZ;
> +			break;
> +		case I3C_SDR2_FSCL_6MHZ:
> +			max_fscl = PP_SG_3MHZ;
> +			break;
> +		case I3C_SDR3_FSCL_4MHZ:
> +			max_fscl = PP_SG_3MHZ;
> +			break;
> +		case I3C_SDR4_FSCL_2MHZ:
> +			max_fscl = PP_SG_1MHZ;
> +			break;
> +		case I3C_SDR0_FSCL_MAX:
> +		default:
> +			max_fscl = PP_SG_12MHZ;
> +			break;
> +		}
> +
> +		if (max_fscl &&
> +		    (i3c_scl_lim > max_fscl || !i3c_scl_lim))
> +			i3c_scl_lim = max_fscl;
> +	}
> +
> +	if (!i3c_scl_lim)
> +		return;
> +
> +	master->i3c_scl_lim = i3c_scl_lim - 1;
> +
> +	pp_sg = readl(master->regs + REG_OPS) & ~REG_OPS_PP_SG_MASK;
> +	pp_sg |= REG_OPS_SET_SG(master->i3c_scl_lim);
> +
> +	writel(pp_sg, master->regs + REG_OPS);
> +}
> +
> +static void adi_i3c_master_get_features(struct adi_i3c_master *master,
> +					unsigned int slot,
> +					struct i3c_device_info *info)
> +{
> +	u32 buf;
> +
> +	/* Dynamic address and PID are for identification only */
> +	memset(info, 0, sizeof(*info));
> +	buf = readl(master->regs + REG_DCR_BCR_DA);
> +	info->dyn_addr = REG_DCR_BCR_DA_GET_DA(buf);
> +	info->dcr = REG_DCR_BCR_DA_GET_DCR(buf);
> +	info->bcr = REG_DCR_BCR_DA_GET_BCR(buf);
> +	info->pid = readl(master->regs + REG_PID_L);
> +	info->pid |= (u64)readl(master->regs + REG_PID_H) << 32;
> +}
> +
> +static int adi_i3c_master_do_daa(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	int ret, addr = 0;
> +	u32 irq_mask;
> +
> +	for (u8 i = 0; i < ADI_MAX_DEVS; i++) {
> +		addr = i3c_master_get_free_addr(m, addr);
> +		if (addr < 0)
> +			return addr;
> +		master->daa.addrs[i] = addr;
> +	}
> +
> +	irq_mask = readl(master->regs + REG_IRQ_MASK);
> +	writel(irq_mask | REG_IRQ_PENDING_DAA,
> +	       master->regs + REG_IRQ_MASK);
> +
> +	master->daa.index = 0;
> +	ret = i3c_master_entdaa_locked(&master->base);
> +
> +	writel(irq_mask, master->regs + REG_IRQ_MASK);
> +
> +	/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +	if (ret && ret != I3C_ERROR_M2)
> +		return ret;
> +
> +	/* Add I3C devices discovered */
> +	for (u8 i = 0; i < master->daa.index; i++)
> +		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +	/* Sync retrieved devs info with the IP */
> +	adi_i3c_master_sync_dev_char(m);
> +
> +	i3c_master_defslvs_locked(&master->base);
> +
> +	adi_i3c_master_upd_i3c_scl_lim(master);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_bus_init(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_device_info info = { };
> +	int ret;
> +
> +	ret = i3c_master_get_free_addr(m, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	adi_i3c_master_get_features(master, 0, &info);
> +	ret = i3c_master_set_info(&master->base, &info);
> +	if (ret)
> +		return ret;
> +
> +	writel(REG_IBI_CONFIG_LISTEN,
> +	       master->regs + REG_IBI_CONFIG);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_handle_ibi(struct adi_i3c_master *master,
> +				      u32 raw)
> +{
> +	struct adi_i3c_i2c_dev_data *data;
> +	struct i3c_ibi_slot *slot;
> +	struct i3c_dev_desc *dev;
> +	u8 da, id, mdb, len;
> +	u8 *buf;
> +
> +	da = FIELD_GET(GENMASK(23, 17), raw);
> +	mdb = FIELD_GET(GENMASK(15, 8), raw);
> +	for (id = 0; id < master->ibi.num_slots; id++) {
> +		if (master->ibi.slots[id] &&
> +		    master->ibi.slots[id]->info.dyn_addr == da)
> +			break;
> +	}
> +
> +	if (id == master->ibi.num_slots)
> +		return;
> +
> +	dev = master->ibi.slots[id];
> +	len = ADI_HAS_MDB_FROM_BCR(dev->info.bcr);
> +	data = i3c_dev_get_master_data(dev);
> +
> +	guard(spinlock)(&master->ibi.lock);
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot)
> +		return;
> +
> +	slot->len = len;
> +	buf = slot->data;
> +	buf[0] = mdb;
> +	i3c_master_queue_ibi(dev, slot);
> +}
> +
> +static void adi_i3c_master_demux_ibis(struct adi_i3c_master *master)
> +{
> +	while (!(readl(master->regs + REG_FIFO_STATUS) & REG_FIFO_STATUS_IBI_EMPTY)) {
> +		u32 raw = readl(master->regs + REG_IBI_FIFO);
> +
> +		adi_i3c_master_handle_ibi(master, raw);
> +	}
> +}
> +
> +static void adi_i3c_master_handle_da_req(struct adi_i3c_master *master)
> +{
> +	u8 payload0[8];
> +	u32 addr;
> +
> +	adi_i3c_master_rd_from_rx_fifo(master, payload0, 6);
> +	addr = master->daa.addrs[master->daa.index++];
> +	addr = (addr << 1) | (parity8(addr) ? 0 : 1);
> +
> +	writel(addr, master->regs + REG_SDO_FIFO);
> +}
> +
> +static irqreturn_t adi_i3c_master_irq(int irq, void *data)
> +{
> +	struct adi_i3c_master *master = data;
> +	u32 pending;
> +
> +	pending = readl(master->regs + REG_IRQ_PENDING);
> +	writel(pending, master->regs + REG_IRQ_PENDING);
> +	if (pending & REG_IRQ_PENDING_CMDR) {
> +		scoped_guard(spinlock_irqsave, &master->xferqueue.lock) {
> +			adi_i3c_master_end_xfer_locked(master, pending);
> +		}
> +	}
> +	if (pending & REG_IRQ_PENDING_IBI)
> +		adi_i3c_master_demux_ibis(master);
> +	if (pending & REG_IRQ_PENDING_DAA)
> +		adi_i3c_master_handle_da_req(master);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adi_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
> +				    struct i2c_msg *xfers,
> +				    int nxfers)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	int i;
> +
> +	if (!nxfers)
> +		return 0;
> +	for (i = 0; i < nxfers; i++) {
> +		if (xfers[i].flags & I2C_M_TEN)
> +			return -EOPNOTSUPP;
> +	}
> +	xfer = adi_i3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct adi_i3c_cmd *ccmd = &xfer->cmds[i];
> +
> +		ccmd->cmd0 = REG_CMD_FIFO_0_DEV_ADDR(xfers[i].addr);
> +
> +		if (xfers[i].flags & I2C_M_RD) {
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +			ccmd->rx_buf = xfers[i].buf;
> +			ccmd->rx_len = xfers[i].len;
> +		} else {
> +			ccmd->tx_buf = xfers[i].buf;
> +			ccmd->tx_len = xfers[i].len;
> +		}
> +
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_LEN(xfers[i].len);
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp,
> +					 m->i2c.timeout))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	return xfer->ret;
> +}
> +
> +static int adi_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_dev_desc *i3cdev;
> +	u32 enabled = 0;
> +	int ret;
> +
> +	ret = i3c_master_disec_locked(m, dev->info.dyn_addr,
> +				      I3C_CCC_EVENT_SIR);
> +
> +	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
> +		if (dev != i3cdev && i3cdev->ibi)
> +			enabled |= i3cdev->ibi->enabled;
> +	}
> +	if (!enabled) {
> +		writel(REG_IBI_CONFIG_LISTEN,
> +		       master->regs + REG_IBI_CONFIG);
> +		writel(readl(master->regs + REG_IRQ_MASK) & ~REG_IRQ_PENDING_IBI,
> +		       master->regs + REG_IRQ_MASK);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adi_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +
> +	writel(REG_IBI_CONFIG_LISTEN | REG_IBI_CONFIG_ENABLE,
> +	       master->regs + REG_IBI_CONFIG);
> +
> +	writel(readl(master->regs + REG_IRQ_MASK) | REG_IRQ_PENDING_IBI,
> +	       master->regs + REG_IRQ_MASK);
> +
> +	return i3c_master_enec_locked(m, dev->info.dyn_addr,
> +				      I3C_CCC_EVENT_SIR);
> +}
> +
> +static int adi_i3c_master_request_ibi(struct i3c_dev_desc *dev,
> +				      const struct i3c_ibi_setup *req)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	unsigned int i;
> +
> +	data = i3c_dev_get_master_data(dev);
> +	data->ibi_pool = i3c_generic_ibi_alloc_pool(dev, req);
> +	if (IS_ERR(data->ibi_pool))
> +		return PTR_ERR(data->ibi_pool);
> +
> +	scoped_guard(spinlock_irqsave, &master->ibi.lock) {
> +		for (i = 0; i < master->ibi.num_slots; i++) {
> +			if (!master->ibi.slots[i]) {
> +				data->ibi = i;
> +				master->ibi.slots[i] = dev;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (i < master->ibi.num_slots)
> +		return 0;
> +
> +	i3c_generic_ibi_free_pool(data->ibi_pool);
> +	data->ibi_pool = NULL;
> +
> +	return -ENOSPC;
> +}
> +
> +static void adi_i3c_master_free_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +
> +	scoped_guard(spinlock_irqsave, &master->ibi.lock) {
> +		master->ibi.slots[data->ibi] = NULL;
> +	}
> +
> +	i3c_generic_ibi_free_pool(data->ibi_pool);
> +}
> +
> +static void adi_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
> +					    struct i3c_ibi_slot *slot)
> +{
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +
> +	i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
> +}
> +
> +static const struct i3c_master_controller_ops adi_i3c_master_ops = {
> +	.bus_init = adi_i3c_master_bus_init,
> +	.bus_cleanup = adi_i3c_master_bus_cleanup,
> +	.attach_i3c_dev = adi_i3c_master_attach_i3c_dev,
> +	.reattach_i3c_dev = adi_i3c_master_reattach_i3c_dev,
> +	.detach_i3c_dev = adi_i3c_master_detach_i3c_dev,
> +	.attach_i2c_dev = adi_i3c_master_attach_i2c_dev,
> +	.detach_i2c_dev = adi_i3c_master_detach_i2c_dev,
> +	.do_daa = adi_i3c_master_do_daa,
> +	.supports_ccc_cmd = adi_i3c_master_supports_ccc_cmd,
> +	.send_ccc_cmd = adi_i3c_master_send_ccc_cmd,
> +	.priv_xfers = adi_i3c_master_priv_xfers,
> +	.i2c_xfers = adi_i3c_master_i2c_xfers,
> +	.request_ibi = adi_i3c_master_request_ibi,
> +	.enable_ibi = adi_i3c_master_enable_ibi,
> +	.disable_ibi = adi_i3c_master_disable_ibi,
> +	.free_ibi = adi_i3c_master_free_ibi,
> +	.recycle_ibi_slot = adi_i3c_master_recycle_ibi_slot,
> +};
> +
> +static const struct of_device_id adi_i3c_master_of_match[] = {
> +	{ .compatible = "adi,i3c-master-v1" },
> +	{}
> +};
> +
> +static int adi_i3c_master_probe(struct platform_device *pdev)
> +{
> +	struct adi_i3c_master *master;
> +	struct clk_bulk_data *clk;
> +	unsigned int version;
> +	int ret, irq;
> +
> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> +	if (!master)
> +		return -ENOMEM;
> +
> +	master->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(master->regs))
> +		return PTR_ERR(master->regs);
> +
> +	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &clk);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to get clocks\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	version = readl(master->regs + ADI_AXI_REG_VERSION);
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1)
> +		dev_err_probe(&pdev->dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
> +			      ADI_AXI_PCORE_VER_MAJOR(version),
> +			      ADI_AXI_PCORE_VER_MINOR(version),
> +			      ADI_AXI_PCORE_VER_PATCH(version));
> +
> +	writel(0x00, master->regs + REG_ENABLE);
> +	writel(0x00, master->regs + REG_IRQ_MASK);
> +
> +	ret = devm_request_irq(&pdev->dev, irq, adi_i3c_master_irq, 0,
> +			       dev_name(&pdev->dev), master);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	master->free_rr_slots = GENMASK(ADI_MAX_DEVS, 1);
> +
> +	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
> +
> +	spin_lock_init(&master->ibi.lock);
> +	master->ibi.num_slots = 15;
> +	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
> +					 sizeof(*master->ibi.slots),
> +					 GFP_KERNEL);
> +	if (!master->ibi.slots)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&master->xferqueue.lock);
> +	INIT_LIST_HEAD(&master->xferqueue.list);
> +
> +	return i3c_master_register(&master->base, &pdev->dev,
> +				   &adi_i3c_master_ops, false);
> +}
> +
> +static void adi_i3c_master_remove(struct platform_device *pdev)
> +{
> +	struct adi_i3c_master *master = platform_get_drvdata(pdev);
> +
> +	writel(0xff, master->regs + REG_IRQ_PENDING);
> +	writel(0x00, master->regs + REG_IRQ_MASK);
> +	writel(0x01, master->regs + REG_ENABLE);
> +
> +	i3c_master_unregister(&master->base);
> +}
> +
> +static struct platform_driver adi_i3c_master = {
> +	.probe = adi_i3c_master_probe,
> +	.remove = adi_i3c_master_remove,
> +	.driver = {
> +		.name = "adi-i3c-master",
> +		.of_match_table = adi_i3c_master_of_match,
> +	},
> +};
> +module_platform_driver(adi_i3c_master);
> +
> +MODULE_AUTHOR("Jorge Marques <jorge.marques@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices I3C master driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>

