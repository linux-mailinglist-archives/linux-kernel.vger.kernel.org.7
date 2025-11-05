Return-Path: <linux-kernel+bounces-886818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF9C3691E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361071897BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269233CE8D;
	Wed,  5 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQRw4vsQ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B98333741;
	Wed,  5 Nov 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357732; cv=fail; b=XUuF1wORTtu+oICVUszaA+iu8VTr4Fqyh2ieISF1XS67YGlGOZBRhSEDSiVJex82Si3myIsd1+1tbiLf28m6iDEwX0ZOAZqiKwm9iQmUTNcK4k189EXUhG3aNA3gUuqWjd8IlERa2ZRrIyAg9Uljw5MuZOElDOA+BG6vXdVKC/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357732; c=relaxed/simple;
	bh=Q9bTb5CRzxftRBVGejuCBkLpZLLxpNmtdQUR2a+493A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MX010OBOxTo+FlJE8N/iSxODKkOxg2FSQaml4xKgNdXtZKyvYxUoCP4roV+YcC3MkHCzvS7/NWK0knSwxxjlQLEKrlpY9j4qLs7aQ0oBSvQpwgh7X2NW+svu3TsHzL7hJz58QRM7GAjiQ1L9QoxI5Ri3kbmG9hq1f5VtHINaej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQRw4vsQ; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8X1oEX0I1l6+elCObVjQxig8QMTTcUsZ5klT6xHt+v/O2drYQl/efcNFlpay6q7eeE+9n3OF6hgztxRHXCZhTasNgIgIZqpus4r9iT1WZsMGXPIaEMpPoQcfSKReK8DRhvti46rwl/RO4P5tmWNpSFnWY8aDWJAZAUNUX+Cu2EZ4XbMqKPZV4QNlKre1DC/PQDEwZHjnNFrLQLfZKNhG6uSJ2WL2+YqXZDbuEZ3S+v4zI/pZkL3hWhnDD109K4jZqbkzzBFR2oevDXQSOzFpWt3AoCmJ1JUTYrSIBhWltPszt4VfS/007JEPfNCQ3Yhpx254V/fdCoqvba3RJWEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9bTb5CRzxftRBVGejuCBkLpZLLxpNmtdQUR2a+493A=;
 b=Qd7YTK2nh/mtZcMr2YAApCQh/0eSoERrKKo6dFNaYimCUK15or1SEVqwe50LFIDcNhXH0Rl+ub1FgbzEJ/SjeyemXKNpfJ6DnuaXpHnpzivtEYq/LlD7Vyhx+HD2x3POPLUsq6SmiOC/pfc9ttt8lspaXfuZ6Hf7pl723xm+i4qlhjZj/ZINc2ALNVv//MHA+EdQVWGO01eyyS5pEIt41o5KKMFqD8lxgrhDenfZw0ut1mK2SBCRHkzJwipatlnV3R21d5WbU6hf2f1YEyoiI3+82Poc9qBrqMyb6yK8jBydyYlzIcZX9zKu6SVmHDZYSbWbVFKUqmegjJr6NQZXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9bTb5CRzxftRBVGejuCBkLpZLLxpNmtdQUR2a+493A=;
 b=fQRw4vsQJunjIOUa2sPquj3os3cLVj27JT8lDAM7cO40Zt7Llbf3I9A5NixphqyS304+WQx32YxxL65YYf3CkeZk4KWFHlq5FP2OjaN3lNTAjOVR812xb9kx5lDi5SyXvnFeQmbi21gtKLjopTPK6WRtT1VaG4bzO1dHPxuiykhBfZRlb4gIQTYCdWgYsA9kfrnjf4eyFPxqaJ9RKQoaosHKnrRUGB5MMNDjnN3aOTTpbj1uIT2pagKlEC/mM9viSLEzoxZBOb95gj27b1bip36GldrjWJLjVF45+h8hCSfHK9YE9u8HasCUaprCJibRqetEZAKSu3TthRpmXYYDug==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 15:48:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 15:48:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sebin Francis <sebin.francis@ti.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Brian Masney <bmasney@redhat.com>, Vignesh R
	<vigneshr@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Thread-Topic: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Thread-Index: AQHcOM+l7sFcrdl8hEKQrktlH0f/Y7TinB8AgAHIe4A=
Date: Wed, 5 Nov 2025 15:48:47 +0000
Message-ID:
 <PAXPR04MB8459AE5010282F9A6DB4456988C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
 <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
 <6de227bc-af06-491a-97f2-800b7523ea42@ti.com>
In-Reply-To: <6de227bc-af06-491a-97f2-800b7523ea42@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7395:EE_
x-ms-office365-filtering-correlation-id: 11a27753-024f-44d2-22be-08de1c82cead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nm4yWGlneE5DWlJTWVZ4dlJDM1BHKzhRRXpwbTBod3ljVlBFd2FuQlY3ZnMz?=
 =?utf-8?B?bUJUTFNpNEdjUTlTTUdLaktkQnd0NlJLZUZveUxwcndkcVdFdEt0TGF2L21s?=
 =?utf-8?B?NUhhc1ZVbEtRc3N1dDVlYmJjb056QW1NOE1oTkVzSnJGdklFYkF1anZHMkFv?=
 =?utf-8?B?RlNJNldDZjdNdGFYby91clppZk4xVWVCaitNcGZYVlFGbnpHWW0rSEl3cEIr?=
 =?utf-8?B?TjFSTXc0QkdlZXdiZmVjYUNZaldXSnZrMmZqOHEzcFNuWGltTUJRUldVWXlG?=
 =?utf-8?B?cGdKQzVxV0R4MHYrTG1lN3RqajhmeFM3dENlem5RNVNCb2Y3V255RWdTcldX?=
 =?utf-8?B?Q2k0eDMyd1BCNEVGOUlLWWU0TjgvYk50RHJ3RVgvaDV5M3l0TW1JT0dIVmcx?=
 =?utf-8?B?MUJMbGd5ZVo0QzBxRmxhZGFlZmJvNFQwd0pTSWlYK25LQ1FmdmJFdXhpVlUy?=
 =?utf-8?B?THNCVjJMVWpaY2U5L3c4bkF1RERtV1ZIOFFCVEFhUkNFNytFanU1eS9CL2ZK?=
 =?utf-8?B?TUh6dTdQMnFxdnhZZWthYmllZXZwRGc1OEtrenRCU09XSnBIZ2p6UnZBamJG?=
 =?utf-8?B?SFRrcjE2Z2Vld0Y5d1lJa2tqRCtyQlRvem1NSnRaSDZyM1cwUVJnT2pESm1F?=
 =?utf-8?B?YjZqUWZHV21yUmhkUFBUMmptcUJwMmxGSU84d25Qd1ppK3dHcEIxTlZ4UzZK?=
 =?utf-8?B?VnJIRXZTYWUvZ2twNXNNZG9jbUw3cXNVUFVVZDJFbVpVRXFOcjdrL29TWWxq?=
 =?utf-8?B?MkZGdms3ZWgzbzZHY25rZm55d3Z3ejRPZlJmS3BwUzJHTjFHRzhwL0libGU3?=
 =?utf-8?B?eEpYby9GK0JRWmxBWHE0bUdZL3VsTnFKN2N6bmduOXVDTlJjTWFudUlzczlS?=
 =?utf-8?B?eWFyREFLNkdKYjlzWVZRcFhlbFpDREVlNHlydFU4QXFhKzNqakQ1c3ZkbzFu?=
 =?utf-8?B?eWx6cW1lVUN6WlNwQ1VZdUU5VFI5bXR5Y0JMRmt4Y0Z4VG1hRjNleE53SDcv?=
 =?utf-8?B?TjdQY05PcmQxUDhIQk1lSGdhMTlGbytZQXA4eFFIN1NtZTUzYTVaRmpkR2hn?=
 =?utf-8?B?amlhT3hvNkgvMFJTMEYxa3ZEa3BtbUduQXNrNFVqUVpkd2c3d0RhRnZacWNC?=
 =?utf-8?B?OGswTktkOEZpeFNJNUxTaVpRemllY2pLTzJkUmZ4dncxTzBhNTdpUEg3bUNt?=
 =?utf-8?B?NTI3cHZkcXFvL1pwSXJKZXI3TGY4ejBZbnArblJZWWFuNVh2Z2o2VHRBRGt4?=
 =?utf-8?B?bFlIRlZjcE9FVzJCeENEeDBtWU4zWWJvODFudU9sRndnbnBmWXl6V0RWdVgz?=
 =?utf-8?B?MjlDeWgvYnlDbVg3Um9VSEpkZXVRd2hPOVZ1OUNxa1ZwcGswa0ptcEtMVGVI?=
 =?utf-8?B?OTMwNUFOZUdlcnV0SWZRTXY0OHoyUlJlVG96UmFmRUtkMUtkR1BXUkNpVktz?=
 =?utf-8?B?RjNVaHZEdUlja2U1VE51QUdQM0hkY21Lb1ZTcnBrRk01RUN3dGJwSWFKNXdw?=
 =?utf-8?B?cmFZKzkvNlhaUkRPeWVlN1dhOUJpc0NmSFdDb1NCWForQlFqYklndUtGMG5w?=
 =?utf-8?B?TE1lMGFPM201dGpSZE9RZ0NpWVhkSis0N3NEYWVEWEZ4L1NHZzh6RVAxMHdJ?=
 =?utf-8?B?VmcyMXBiZVlZUUZ3QmZ5b2RPWEJyOW1BM3dhTy9FRSs1Y2ZSdzFhVTlNWGtO?=
 =?utf-8?B?MXFjQzYrTVU4ZlJ2enM4Wm9hV0R2ak5kUXR1T1pzVmF5OGJobjAwbEw3ODNx?=
 =?utf-8?B?QysyMkJ6Rng0a1hKUDUzdUtWWko5QUwvenZNajRlZXVsd2tycmZyRnlyS1V1?=
 =?utf-8?B?OCtlb2NWK3BVS1h6UCszYlRHcVFxR0ZkTG9oSkxVdUwzeWV4cUlFbHMydVY1?=
 =?utf-8?B?ZWFoTnl3QU5KZVFlV29pTFZ4ajFvdUJZd2Q1UFlqMlhLdjNJc1FXTkxrbnBQ?=
 =?utf-8?B?MjJ6ZkxqcWxrUHcwbjBjTHlOV2dKWWoyS1JQUlR2OCs0M21aOHFJRVJjdWdl?=
 =?utf-8?B?VVdBNE1QY1ljM1QvOVhVTENRNllWaS9jNjF4RlVRL0hteWVxeTN5UDRiVTRv?=
 =?utf-8?B?SXFVaHh2eXRSSzlpZndoOVNNSDRjQjVod2UvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk9Yek1pNjR1Y0VuYzNGcUFkSmVYQXQ5OE1OR0s4Q0tiNUo4akxwb05lbThX?=
 =?utf-8?B?cUNNZUNFL2xWUXhWWFhSazloYVZUaUFRbk1MM3lYZCtBZURGRFEyL0pmTkZB?=
 =?utf-8?B?b1NRaXcrQU9RS0ovZVhiaGFqU3JoVHZvVFZFcWNQTXZjcTNxUTlzQWxFWUpj?=
 =?utf-8?B?aVhLMkRvTWFCVWpsYm5pTWJKclJ2SmRLMVlmVXovV0NkVmhOeFYxbHdQL3Z2?=
 =?utf-8?B?ME5HOU5YdloyZ0R4My9aVG5YeE5HbDlEWjJDTktPVy9lbU9tdDRnZkNXalZZ?=
 =?utf-8?B?UE1sZUtkcXJCd1pmNFFZbzVqd1JNZ2JYeFUxQitTMjNOb25iTUlPQkJDUTZy?=
 =?utf-8?B?TUxKZjNlNUx4bTRHWXUrYllnTVB5OW5OQVRYNXp4WUZQZENiWFpBRG5ycEE1?=
 =?utf-8?B?anRxNldJVTZVMm1QeEZJcFdIY0g4bzA1QzN0ZElHWGdnc0g1UzFpcVJQNjh2?=
 =?utf-8?B?Qks2Umw0SW5YWjdpQVV4TEpxM1dSNUtZbkhFQk96OVhKOUZsUGl2cHlSMjQz?=
 =?utf-8?B?Tkg1V1lZYStuOTVkOGo5RXRYVDRadXRIbGYrUndRN01aTnozTkI4TzlWMjQw?=
 =?utf-8?B?aGkrVUplSWFQTC92Ny9JTEhnd1YvaEdDbnRWQVdFK3dJakhndHRwZ0tBdWE3?=
 =?utf-8?B?NDRVZkhxcVZ1TW92WWlWcjFlM000WDdsMU05MmtaYjN0LzhyS1BNMGpVdXd6?=
 =?utf-8?B?NWpnVi9XZ2RoVUZ5QXRscjRIRFgrMUl4L0QrVTJNOWlGT21Oek1LRlN2SVJI?=
 =?utf-8?B?cmZXT25oZURPbXpUMHJ5Vng3MFZmVEZPTkNoUitZRmwzV3Z3Mk5ya1k2aDBn?=
 =?utf-8?B?VzN3ay91UjluTnhidmFReHd5cCtCMENOQVlLTWhrZTRmQ3RjZFFvSS9lUzAv?=
 =?utf-8?B?V1F6M2VoR0h2TVBDb3hicFRxa2IyWC9FZ1VaQ1RaMUI0SXl2d2g2SEZmNWtw?=
 =?utf-8?B?MWVqOW5aM2lURlJsNHpnU2V1QlBrN05ad2t0dTJCOGRqOFY3ZjVqL3ZxSmc5?=
 =?utf-8?B?TExQY2E1NW52SlVkZ2pSOVcrTUl5QkFDUGNtME9YZEh6UUpkeWhtSXFodTlH?=
 =?utf-8?B?VE1YZ3lQQ05NaEV3SnJYaUd1dVVqalhoMTRmWkNxODVxcEpuRWpoK3ArRXp4?=
 =?utf-8?B?NW00SzNSRDExN3dzR2ZwQVNzNnZXNG1tRXIxbUJxb0JkK25VaUJKQUZPWGNK?=
 =?utf-8?B?dFhFNkFsaUR4QjhlWkdwYlp6ZEpsUWtuSkptcVE3YkJYTnVDZWVoUTBldjd2?=
 =?utf-8?B?RjVxbnBmKzZ1NEZXR1lEeEY0YUNmSHcwQThKTU9vY2dJYkJnK0V5bWh2dTRC?=
 =?utf-8?B?Z3Z4ODhDclNYd25qSWhLcEJ5VXUwUDJIMFk1cERjZ05qSDdBSmFyK0lsZ2xH?=
 =?utf-8?B?eVF2SjhuY1FjSlo3UVZsTkdHcWtaQTRKMjdBKzV4RDRTNUh5cmVxY2hoTzNj?=
 =?utf-8?B?eXQwRlhxR0ZoR3E5UzdROHkwaGd2YUoydWZKbWZFR3E4WnF4MGd2ckZqcFlY?=
 =?utf-8?B?UjRHaXdBT0dyK0hOWmdpL0daZDZWa0ZaeUFybWZoQWZJL3dxSUpPMnJjNnVZ?=
 =?utf-8?B?eVBVUTluYTU4ZFlMcGVJSVBrZE1UYzhJd05JOERwcU1VcU1RbjdOL3R3bU11?=
 =?utf-8?B?dmRQQnBhNkVIRm1HbzQyM0w5WEJvZit3OVlhMmVPdG5MdUE4UTkwdXlaOWx5?=
 =?utf-8?B?bldvMkdRK0xoOEhGRmdvbWNRa2lhZUtZemtETGJEQUV3V3NjemRpNGtnWkZr?=
 =?utf-8?B?UHpJVVE2TTdDNC9NNjJSeHJMdlZSNSt4S2cxOGlBVXZhOUdpQ1lFVUJNei9m?=
 =?utf-8?B?Z0F0TWhjYkJqK0VWaXZIY3k3WnZ2Njl0eE9HMEx2VEplTElwUCtBd3VqUXpB?=
 =?utf-8?B?blc1WndiRGt1OEd3WXVjQ05FUFUydWtyZVVkOFI3UC9vY2pHL3lTUVFXcVJ4?=
 =?utf-8?B?bDFZWjQ2YnlEaEZ0L3ViRXNTQU9MNzlXUTA5cks2NmxpN1doY3Z1UjFVSlB2?=
 =?utf-8?B?TjR6d3d3a0h4RE5kU0FNajg3SEFrSzBnbGgxa0Q1cjJ0dmgzd2JtenBqRXkx?=
 =?utf-8?B?bHI3OWtXbVEzZUNqTmwyNWw3WUk5dlcvT3RDNFBzaTZnM0lCVGRvSE8zdS95?=
 =?utf-8?Q?tefA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a27753-024f-44d2-22be-08de1c82cead
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 15:48:47.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThGZj91MIVynIYQmIoDr+O9xEb3HnvhNwbWTT+VbO8yRhckTCasD7peIgWhRnXzLeQ1qWRi+wFw1Cjw8VoFLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395

SGkgU2ViaW4sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA2LzZdIGNsazogc2NtaTogQWRk
IGkuTVg5NSBPRU0gZXh0ZW5zaW9uDQo+IHN1cHBvcnQgZm9yIFNDTUkgY2xvY2sgZHJpdmVyDQo+
IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gMDkvMTAvMjUgMDk6MTgsIFBlbmcgRmFuIHdyb3RlOg0K
PiA+ICAgLSBJbnRyb2R1Y2UgJ2Nsay1zY21pLW9lbS5jJyB0byBzdXBwb3J0IHZlbmRvci1zcGVj
aWZpYyBPRU0NCj4gZXh0ZW5zaW9ucw0KPiA+ICAgICBmb3IgdGhlIFNDTUkgY2xvY2sgZHJpdmVy
LCBhbGxvd3MgY2xlYW4gaW50ZWdyYXRpb24gb2YgdmVuZG9yLQ0KPiBzcGVjaWZpYw0KPiA+ICAg
ICBmZWF0dXJlcyB3aXRob3V0IGltcGFjdGluZyB0aGUgY29yZSBTQ01JIGNsb2NrIGRyaXZlciBs
b2dpYy4NCj4gPiAgIC0gRXh0ZW5kICdjbGstc2NtaS5oJyB3aXRoICdzY21pX2Nsa19vZW0nIHN0
cnVjdHVyZSBhbmQgcmVsYXRlZA0KPiBkZWNsYXJhdGlvbnMuDQo+ID4gICAtIEluaXRpYWxpemUg
T0VNIGV4dGVuc2lvbnMgdmlhICdzY21pX2Nsa19vZW1faW5pdCgpJy4NCj4gPiAgIC0gU3VwcG9y
dCBxdWVyeWluZyBPRU0tc3BlY2lmaWMgZmVhdHVyZXMgYW5kIHNldHRpbmcgc3ByZWFkDQo+IHNw
ZWN0cnVtLg0KPiA+ICAgLSBQYXNzICdzY21pX2RldmljZScgdG8gJ3NjbWlfY2xrX29wc19zZWxl
Y3QoKScgZm9yIE9FTSBkYXRhIGFjY2Vzcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guIEkgb25s
eSBoYXZlIGEgbWlub3IgY29tbWVudCwgb3RoZXJ3aXNlIHRoZQ0KPiBwYXRjaCBsb29rcyBnb29k
Lg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKw0KPiA+ICtpbnQgc2NtaV9jbGtfb2VtX2luaXQoc3Ry
dWN0IHNjbWlfZGV2aWNlICpzZGV2KSB7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgc2NtaV9oYW5kbGUg
KmhhbmRsZSA9IHNkZXYtPmhhbmRsZTsNCj4gPiArCWludCBpLCBzaXplID0gQVJSQVlfU0laRShp
bmZvKTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSsrKSB7DQo+ID4gKwkJ
aWYgKHN0cmNtcChoYW5kbGUtPnZlcnNpb24tPnZlbmRvcl9pZCwNCj4gU0NNSV9JTVhfVkVORE9S
KSB8fA0KPiA+ICsJCSAgICBzdHJjbXAoaGFuZGxlLT52ZXJzaW9uLT5zdWJfdmVuZG9yX2lkLA0K
PiBTQ01JX0lNWF9TVUJWRU5ET1IpKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArCQlpZiAoaW5m
b1tpXS5jb21wYXRpYmxlICYmDQo+ID4gKwkJICAgICFvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUo
aW5mb1tpXS5jb21wYXRpYmxlKSkNCj4gPiArCQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCWJy
ZWFrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChpIDwgc2l6ZSkNCj4gPiArCQlkZXZfc2V0
X2RydmRhdGEoJnNkZXYtPmRldiwgKHZvaWQgKilpbmZvW2ldLmRhdGEpOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBUaGlzIGFib3ZlIGxvZ2ljIGlzIHRhaWxvciBtYWRl
IGZvciBJTVggaXMgaXQgcG9zc2libGUgdG8gbWFrZSBpdCBnZW5lcmljPw0KDQpZZWFoLiBJIHdp
bGwgdXBkYXRlIGl0LiBJdCBzaG91bGQgY29tcGFyZSB3aXRoIGVhY2ggZW50cnkgaW4NCmNvbnN0
IHN0cnVjdCBzY21pX2Nsa19vZW1faW5mbyBpbmZvW10gPSB7DQoJeyBTQ01JX0lNWF9WRU5ET1Is
IFNDTUlfSU1YX1NVQlZFTkRPUiwgTlVMTCwgJnNjbWlfY2xrX29lbV9pbXggfSwNCn07DQoNClRv
IFRJLCBJIHRoaW5rIGl0IGNvdWxkIGJlIGV4dGVuZGVkIHRvDQorY29uc3Qgc3RydWN0IHNjbWlf
Y2xrX29lbV9pbmZvIGluZm9bXSA9IHsNCisJeyBTQ01JX0lNWF9WRU5ET1IsIFNDTUlfSU1YX1NV
QlZFTkRPUiwgTlVMTCwgJnNjbWlfY2xrX29lbV9pbXggfSwNCisJeyBTQ01JX1RJX1ZFTkRPUiwg
U0NNSV9USV9TVUJWRU5ET1IsIE5VTEwsICZzY21pX2Nsa19vZW1fdGkgfSwNCit9Ow0KDQpSZWdh
cmRzDQpQZW5nLg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstc2NtaS5j
IGIvZHJpdmVycy9jbGsvY2xrLXNjbWkuYyBpbmRleA0KPiA+DQo+IGJmODU5MjRkNjE5ODVlYjll
NTk2NDE5MzQ5ZWI4ODNlMzgxN2RlNzMuLjFlZDIwOTFlM2Q0YTk1MQ0KPiBjODY2MmRiNGM5NGRl
DQo+ID4gZTRiOWM5OGI4MzI2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1zY21p
LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstc2NtaS5jDQo+ID4gQEAgLTE0LDYgKzE0LDgg
QEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9zY21pX3Byb3RvY29sLmg+DQo+ID4gICAjaW5jbHVk
ZSA8YXNtL2RpdjY0Lmg+DQo+ID4NCj4gPiArI2luY2x1ZGUgImNsay1zY21pLmgiDQo+IA0KPiBb
Li4uXQ0KPiANCj4gDQo+IFRoYW5rcw0KPiBTZWJpbg0K

