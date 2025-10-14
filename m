Return-Path: <linux-kernel+bounces-852241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD8BD8862
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445164293E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00432EDD60;
	Tue, 14 Oct 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E9xidlXs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E9xidlXs"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D82EBB81
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435086; cv=fail; b=QV4WKtIin20zVNPc2y4RrHjQdCtWcpUHVUWh4PSG0yo8YzLLs29Z6YremFeabBOBajxDG7WlYm/viHJSB7RSLV0/sjX9luKWiqIvN6IfVpXCsOVXNdTbGFiaPfx8qxnviQJNxvnrbLtN3JGl8BybA5rkXKnuFR+Tuw9u9kYRjas=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435086; c=relaxed/simple;
	bh=DZJgElcVprW+5DDfPlX6iK8yYb8Mvk5bO6OU3d9HLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PonNaILY0i2jqKXYjYH8XzXNAruw83fI0oMTdd4J8ztkeQKc6198kedvYYyK/gC5s51fiqM3Bjb5dFGj2c/TrL6B2TW1XqWFDtN8Sde7Fcr3T8UohYilSFKiRUK/uC9MgUjHvfbhfRY3Zox3Zr/wPK72GNv0VgFW/aB8wy5c1R0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E9xidlXs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E9xidlXs; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kmKUaWDLgVjwwLDPMLva7GHTLaZyd7M0ju65xQyDDsuPBgZ9PnmkypeiG9B5ASlkRKAN8TQJbbKgC/QPWv7U8S5PStTv+z3b9y5NlxOWZQT4e9U2+vo6FThA+806xPodX5CIZiu3M7cbT4Ma7cM8XaycfiJls0FlVf2FEft4rZL6hGUkbK4NG+yQVM7LtnWcMGiLu0LmcV2bkW8kqxEW4al244uZBjgDd/1T07Bh7Gvd7IMIwbCUwKF0tiiF0vvjhAMwEmtNQDleEEhR1IHuGazJOwf/vrLXhRe2bIzqdyY/PBd8dHtqJxQ1/6USRIpde72xRN3PdYondmjGZMBjXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfH+6B3fwjdIugmrRJNP7xuDJ1cMcjvXCCgBV3UdjbQ=;
 b=W6AR9Rl5ZUHFOrlowlb+PIcQTjty2hFMh/5HZpLUy4VIiCgB9c6+rJHIySGlo2cdxj3q7DYSiz/KD1y5FHZ9LkjSSJrdSY7m6DAXHYkHKOeL3YuugqgGCKhS7bEyL+RswQWloFPMhjbi3sjFmMQu9Oty+hYqLaoyL1lFYkMIK9P8UtYXBqEU7OJmb1cL+qfpg8AHx81R6xjztwq70x5rUUVEWjffakJrsZEAf6SM0VCRKlbvgTKD3xUu2hZ/QNj/xNS99ra3XRNcI4/emhvnwX36asbgjYuMuU/NG/His/0/auqOy790KMu2FQpW+9B5+jb/mucj55K42OXcHc7lCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfH+6B3fwjdIugmrRJNP7xuDJ1cMcjvXCCgBV3UdjbQ=;
 b=E9xidlXs9mZfO7+IZWz7SWX+MV6yk255mN5ItKluJ5HJ+pQ3dID4h+22EeUn1antZ5CMrWUjHa4WaHiOoI8gVDXdNL30VTE8OVOU20JLhy69jekjFx4MC23rhX8GB+8Et3sUDB2kU+z6kdbfPeakZZHKPPWdzm7jp8DE6UfT3rc=
Received: from DUZPR01CA0289.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::20) by VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 09:44:40 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::45) by DUZPR01CA0289.outlook.office365.com
 (2603:10a6:10:4b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 09:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Tue, 14 Oct 2025 09:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+8TAy20ywj+aN5JTu04unhveXPFCK1p88Sm0Xugp+07MER/oI2vfOqkJxHRtsVlbgIcGWIJ3/4Y+ziB6JIc9QPOEnLe47mHL2kQA2eXlrXts5R+arLV5EZJU+Bol5fmDCfkf0HtMWLNXn0OM+0aNPifXwitU4fOZ5O1PaVzda8fcW6D0n0VKJyuWfuNru3ZZeTlVxqkBvi2iOZXmGTrk6CThXlwD7JneJzgvUNseg0IPYZJWBcwh7BRAlpSoGfbQunWfwRp5QcH/CsygYuGNPCugDz5Q8NjvaOiFiNz+psMqsNDCz99RDAUe1AWeXaJ4KF81JDM3hUgFAZTuAUqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfH+6B3fwjdIugmrRJNP7xuDJ1cMcjvXCCgBV3UdjbQ=;
 b=CxSbAOqrVV55JzYv1lSB+kje2660i0mjSqi1QPdwm/OpzDJw5mThiAfyKoclGofwLBKrOTdmt+Q7G7Iv81AdF+UXAbzMgpKf2zPIOaG7KXLUuYrz8bnn/j4f2WEKBjRZ6RITEdXQa2EAd+YSEz7C8NCnloELwwdDnv9wpafnoEBxe+VZlt5L83LAfFqA2MfrGVy3kzKKdbZHobIZ2vFnZoKaKZ94qDqlcfIL0td1sPQ7lhiSMG3Yk/2nrpRYjb6CPPt29h5I9dwEuf3tWZuW7Jyu8Z8UFmXhl7JXOlx0uR5YpHwElLx06KOt7QYWaW4WWjGi1jnmzOwV73GSnQbjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfH+6B3fwjdIugmrRJNP7xuDJ1cMcjvXCCgBV3UdjbQ=;
 b=E9xidlXs9mZfO7+IZWz7SWX+MV6yk255mN5ItKluJ5HJ+pQ3dID4h+22EeUn1antZ5CMrWUjHa4WaHiOoI8gVDXdNL30VTE8OVOU20JLhy69jekjFx4MC23rhX8GB+8Et3sUDB2kU+z6kdbfPeakZZHKPPWdzm7jp8DE6UfT3rc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS2PR08MB8286.eurprd08.prod.outlook.com
 (2603:10a6:20b:555::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 09:44:05 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:44:05 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] drm/panthor: Introduce framework for architecture-specific features
Date: Tue, 14 Oct 2025 10:43:30 +0100
Message-ID: <20251014094337.1009601-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251014094337.1009601-1-karunika.choo@arm.com>
References: <20251014094337.1009601-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::8) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|AS2PR08MB8286:EE_|DB1PEPF000509EA:EE_|VI0PR08MB11136:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcb9f30-0858-4378-a3c2-08de0b064bc9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Ipbb/jbUDLrt+LBxOson88BUh6B5mEZbav4L4S1VFO0iIOuPEoRdubjtBhcy?=
 =?us-ascii?Q?tE/2CZSB+PwwIrE5efYosRPSjwk17YvnY22+rD34Zfd6s1XjCwiwZ67jhEIJ?=
 =?us-ascii?Q?JJbEdlJEpl9yXKHGcBIq25jslFPpk3M6X1QRIl+SPI7nB1uRhpNuYt0JiafH?=
 =?us-ascii?Q?qOwsf634fAQPjZz3iTglJ70n83K4W/eapbxEVGTvE4YeFdN22wCxU9hu8uPZ?=
 =?us-ascii?Q?f0SQ4KD27ncgjkf9HZTtegKttrpwctb9b8FTrej7OGDw5IrRLSPBAeXJag8W?=
 =?us-ascii?Q?4Wm9mSgiZkZK/J439V7Q7v08dj9KSHgI1MOuOIoZnjDvdNQ2+QAALRM3YQlt?=
 =?us-ascii?Q?XrFlXr+II2yr/V4QxjMYiNpvUorEFsxLxnL1xBiHnpTqz+NOStmEQ0J4JrKU?=
 =?us-ascii?Q?tGmd03g+/NYsmzGIPFFuBr0a8oy1VydrN/mP1s7zU/vdbYHu1lFTk3YKliuI?=
 =?us-ascii?Q?P13Dp3KllKWhDqF9ip1HL8EW+cTDdXOcFWokW9kNecrAyqw5wXJARNucYAni?=
 =?us-ascii?Q?8U+m9iHt7QLJO0Xy1xCmBV/OjyLFz85SNAT2pofk7VMqgSxP5K3V2CnIQDpq?=
 =?us-ascii?Q?Rq37LkRtTKg7Sm/NkHJz+WeK9y3KdZK41azc6VIIEAIgm+GFDqh9NtmIv3dC?=
 =?us-ascii?Q?HGKHhhutNP6950R+QSTpqUrija2qbJ2tPxBxKyOztRi4uzbMJIfoItEJiBdk?=
 =?us-ascii?Q?L1ZNAdAyZkN7aFOLRv9yeMLD8jgXfXPA35uEsttnFcedZ76uWjpoMjKzIWCB?=
 =?us-ascii?Q?158Uz6HMoPaYwr1WTDjgQPiX62T5kGGVRLpU7TAKqZqBOxXw+qW8AOLmWyK8?=
 =?us-ascii?Q?r8GK9Zh2I4Ga8FPMm2Gg8MFK5pj5po5U96s2S4BV1VHmWzZkStv8cJpmLQe2?=
 =?us-ascii?Q?9aoajWzW0oRCmzdUspGm3A717l9ACkm5kD/HgtPdojWMlbekcaKmxW34574Q?=
 =?us-ascii?Q?9BIs7D+5AGuec3pgrbjvqWuXEy70O3XU1uzZpN7qHxEdKJ9YU3q9O6GvpTo6?=
 =?us-ascii?Q?QZhTMM3bWrgKxMbRud5BG9/XbeUXH2mYx5rH2gmMl3L4nM+q/Oi93TjtOJL+?=
 =?us-ascii?Q?UEbaFBTijuqrU2LvsWWxrPJJZzgXFZUt47RoPvFpreEagt3XXy+x475YUy3E?=
 =?us-ascii?Q?bf5E2IeNfCmFmo4fzlvEcmx54ey0K+Q0gXbSpV/6oOvEAzD44m2Z5Yoeov4l?=
 =?us-ascii?Q?5hZytgQ9+sOpilJtcq5XaAy798SI7DhwPH8no4N2a1NjUXZ833ZS12qxqjeO?=
 =?us-ascii?Q?W+4DBEBJ7K5mPoPXuHyDga5/RXgYXtc/mV4fLRDIUMVu/d6lEUDEkFZeQJvp?=
 =?us-ascii?Q?J+FZIp/rFoUWJ+KR8yUaYm5ZQKnEF4qpKouVJiPjaxeEy6BxVbu0yG5ZWlw6?=
 =?us-ascii?Q?T1ADHuV0FBZTQh/lfuepmx4o9PUgtszP6WDubCN8igKgiv4rIOnaCYovl9SO?=
 =?us-ascii?Q?IzrDzxqKgvtMw1ognDIAk0l0yi+M4Afs?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8286
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c6f57e3e-89c7-46fc-aaef-08de0b0636cd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XdfojZANrsTRGVr9MUFpB+viPXMB3ePjboThRlMBvAWF0ZLuRzfrE63hshb8?=
 =?us-ascii?Q?HhEa5ThTKSIQWkxDiyIlywmlReduKWJu6e+YhNkFhw04aM6cW3O90Zpoqc6D?=
 =?us-ascii?Q?+3eCb9T0IZFbUBzkivuFts4vqQTesSKwfGY4VA3jcbvfjw1PD34BLRIrZea8?=
 =?us-ascii?Q?S962pUECU+tSuizSdgBXgI8wr7nBl5+nWHwfpSMrtX46DynmHrRxX98fpnp7?=
 =?us-ascii?Q?7WbeREgcibAk1jWUWCtvclgvwzxABTzCViGoZ7R16EOjTFdL0BSqN5+THaRN?=
 =?us-ascii?Q?7oVjcY2Jk7dq7gmttnxL4dhIAXlTB5I8rIwEe6HjG0nIzPllMwIVNRUWggeB?=
 =?us-ascii?Q?HZtq4l23/KMryvby7lpnTdgSylf8QC49R/omNqt49bu7yyAQqWxhqcumKEEu?=
 =?us-ascii?Q?iTldsrTN4bVWdKR3WsJQN+ollfDAA6jzPJn5Sle6mIAiIyo4KBxVdxrJfHtP?=
 =?us-ascii?Q?Ee/XH8EvzVFFSbAeIMtcjWpsob0pxAvhFN2pwInTjxAMzYlq96B3Aqd8YBde?=
 =?us-ascii?Q?fVCtoAtMVcEqkvjnP6WDZYL20bIBJL/ifWv8Yid31Jvru2Eh7DJ2F7pbUR8B?=
 =?us-ascii?Q?UBEj1C3lFzOk8p8RHkjszr4RTDL1uE/QYNai4UN6hl8Ng79bY05Ehuy7PYjS?=
 =?us-ascii?Q?GdtgBWNfFiUiwoUdzeD7lSQkg8DepIjoB/cgjrZA6N3bWajzQUXWSDyVBY5L?=
 =?us-ascii?Q?yRbojt1klZb52dKxYldOhaScIkke5KJBxAGO1MGhEpIr2/af1E7cIzSOZn+V?=
 =?us-ascii?Q?wuVkizrTFGTYVGIPqd8kWIK0XdesG9mLuP0hwvIdRxhCcepRit0sGkwFVoyk?=
 =?us-ascii?Q?4AmMg1UmdkCax8bhiPAMEHUZl9R6kIggUiRl+gAKel6r5gLdhTgyD4/CjViZ?=
 =?us-ascii?Q?N9LA3lB0OA7zL9QDRlO3Qc2DIfTkxTpajX57V4r/CRtw8ypULobpEcOYOVCR?=
 =?us-ascii?Q?+yipZT7qWT9dzRErcTgFuBV7+Jbq/YE2ZQZxScuxEkKR+GnyS7hZJzx0cdjI?=
 =?us-ascii?Q?qupgpRv7fWie0s5l+wU7izks05mdRNEme8BrgNmH8b7SsyuOTenGClJdSzwo?=
 =?us-ascii?Q?RzP1BKp4pkTNUfLFtSAPeERX43NiARDuJGyHZgbpLNfIbUqKrM5pqY280KLJ?=
 =?us-ascii?Q?A0DP3QB6d32b108eGLMtzIalB55YKfovFlQ6Gd+0La4N/0Oxorvz7akdXtts?=
 =?us-ascii?Q?dFgO7WMSy2MLyJoUbjobioKziBlyuK63AXWpI2o5BAZfv8GqlXp6DwgPB+8c?=
 =?us-ascii?Q?OdSVSTF1UTjs2z6iovkMaAOfQrOiDBZ6GJ9lNCTQ9ZO4ZDnKrPk8Pem6LELv?=
 =?us-ascii?Q?Qm2RxX0v7FOtzBj63Ox1U5PcX35jZtx/jscKi850eFtUhMF78tXB3odme2Pz?=
 =?us-ascii?Q?GsGIH7Pqzn5/kPvrJDQUBFRrmVHIu+EUQH/7+IqMOwRNnpD/XU/IHY1E5JcQ?=
 =?us-ascii?Q?w7T9s4eI4Ks9ntZc7xA2kZ4ld+PGXJ9FFAxv+Jz3ZspdeSg8YMfcr9ue/qyJ?=
 =?us-ascii?Q?aymQFFWe0iKejEp5/VoE87laPj2bcSDLwfa51YyXgTro5dmZUdQo+2mPuI7v?=
 =?us-ascii?Q?wsaaHvPBBYxiYnLnt94=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:44:40.1349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcb9f30-0858-4378-a3c2-08de0b064bc9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11136

Add a framework to support architecture-specific features. This allows
other parts of the driver to adjust their behaviour based on the feature
bits enabled for a given architecture.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c |  5 +++++
 drivers/gpu/drm/panthor/panthor_hw.h | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index b6e7401327c3..34536526384d 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -186,3 +186,8 @@ int panthor_hw_init(struct panthor_device *ptdev)
 
 	return 0;
 }
+
+bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature)
+{
+	return test_bit(feature, ptdev->hw->features);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 39752de3e7ad..7a191e76aeec 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -4,14 +4,32 @@
 #ifndef __PANTHOR_HW_H__
 #define __PANTHOR_HW_H__
 
+#include <linux/types.h>
+
 struct panthor_device;
 
+/**
+ * enum panthor_hw_feature - Bit position of each HW feature
+ *
+ * Used to define GPU specific features based on the GPU architecture ID.
+ * New feature flags will be added with support for newer GPU architectures.
+ */
+enum panthor_hw_feature {
+	/** @PANTHOR_HW_FEATURES_END: Must be last. */
+	PANTHOR_HW_FEATURES_END
+};
+
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
+	/** @features: Bitmap containing panthor_hw_feature */
+	DECLARE_BITMAP(features, PANTHOR_HW_FEATURES_END);
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
 
+bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature);
+
 #endif /* __PANTHOR_HW_H__ */
-- 
2.49.0


