Return-Path: <linux-kernel+bounces-785361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E8B34995
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69DC1A88307
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F69309DCD;
	Mon, 25 Aug 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DXWd0Phy";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DXWd0Phy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022125.outbound.protection.outlook.com [52.101.66.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE5306D3F;
	Mon, 25 Aug 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.125
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144888; cv=fail; b=hyPYZI1D3h+4WLfm/YpTZWYaQIJrlm90tPe8iEAXf3VD7wfJ0KRkNTrcG7ajVeGjYKGsdiylkf4geqw679Cs5msIC4iWTbEUtgsnIV31mnxrvlKwQT55p7t5EQj7W+HNRAtNk5n7tqc5fdLWevAn0jmQvh2efoADyDXEOHMDws0=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144888; c=relaxed/simple;
	bh=w/ekbkgCOXEhyRKoxdRNa9/AS/10sLkQq5S+7YylsrY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i571XGu8Ezb0Up8vOZ+IeOpaTTt3VDxu+JY9gTnMLuTYoWUgnftOQUIoLxhIOMbCteh896EQqFV0sSi/JpG2zho/i4hJY+qJb+kXLePJpadGNCbSM/NaKmlPODcOUpM5sl9dj6Z/vTJjolu9ElhtAtCMaMgFRA2CxKF8aR2j19A=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DXWd0Phy; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=DXWd0Phy; arc=fail smtp.client-ip=52.101.66.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MSXZDYfBUSWLFUxwPC2qYYdmttxncdBQih7N2qxdBZq6uVqoibBCcmDzptB0psRTHr5EgQ8KPe2o4sN48R1xG/+SNwVRPSm9+I0oaHicLvty/b+J0nwj40jOPM2fB4NFCKnmm4umCcqZ87y+dKsq/nMDuqiiZCDIfAbGMGjVk/sNoJn8qr/EuI/l93KYectkWQ5rwv3CP5JmfPsJDtsg9SkeT11J/t+ZnH8ZzOnO4nrdhBRlhvws3x9O4vuj2RWtrDdPRNsoItQ4D+n397bfv+vRYXQqKF8dp8hVL9SoWaZqm7VonsDLEcofRkXLwQXnhGDROzCgIrJZy1cKM2lFIg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANuLj9pE1eQqFPWvL+9c9oUHXxjsR9iNq463T6iFlXA=;
 b=t5ib6ByJ3i8xFYEBrv7tqDljD5PNruMHHBc9YQPXe/RFcWTWUVZtXkSUTC1h/k087QMFF4FXM7cC4SWuZOi7Jmanpo/Os+T6uYFK69ktZZ/2WTOy1yFNFI4ysoN4FdeUQRCdirCvh/zjIk1TSCuvprfBLvVC7JpYk1Ckj4YCy6xtM7q3e7eCLymfcq2m9/XK0xhM9z1PzcZX5AeyA79vY+YMjpBxSXLEYR6Abzi/zI7mkH8sTU++rhWj4o3DlaORuT1wceKFNJUV1mkL+3GLAV1+C5tIdwdod4nnZiJWgAGKzsV2m/2VgpwqSQxg5vo1ES8gLXLQJJEkLI5eHmHEcQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANuLj9pE1eQqFPWvL+9c9oUHXxjsR9iNq463T6iFlXA=;
 b=DXWd0PhyWiDu3zNnk6fkgBMUFme+Q0Aws2DMUcE2X2IwF3DCg1rg6C3hTqBnDLZMOn+hkPba/ti83ODA2MWLBWDWCm+M8va+wWGYq0T7evoFXiCYqZyjzUXfDZ8PW8BaNw1nkEiRK9rv4xWpye/1AvMHsNw4xtdrciQuhRbHpsE=
Received: from DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) by AS8PR04MB7829.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 25 Aug
 2025 18:01:17 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::60) by DUZPR01CA0010.outlook.office365.com
 (2603:10a6:10:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 18:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Mon, 25 Aug 2025 18:01:17 +0000
Received: from emails-3081853-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-81.eu-west-1.compute.internal [10.20.6.81])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4532B8037C;
	Mon, 25 Aug 2025 18:01:17 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1756144877; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=ANuLj9pE1eQqFPWvL+9c9oUHXxjsR9iNq463T6iFlXA=;
 b=AMU3BfSaKzM+Af4508yVoA8U8yg8PiZSxvrv+lJzpKaHEmDXeZpvQhfVKXV52TBw+4DbR
 NNNgXhpqOz9uZmg4/lSkCqxvBR/yR+9XnONTY1vP+oq1YE/EVx6vm5POY6AAJrZobVzczul
 Lgxw4HMM3k8Sbp8vgbBPV2luvIIjypU=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1756144877;
 b=WjYwCIpLoL0SANni6fkoqy58/5+5ylixaHy1gzbMRFIZBm0OARYwkPNOfo7mhH1bRHsDp
 dFCfe+HjmxlfhOIUmb35kz3BLuoSH7C8TkDJw/cCk6uuR+xd9YUjBGtov+TBGMeXzk9BKeE
 iHflaQ0P1FlDA4ykpTkfveqh1AFk0ig=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhcX7q1tfGVUVwAoHF0eYCfcz3ltf0QpLo6yiZ9puV3uJhrDKim45NRJG96PmCI/ZthgSEtGwwHBEDzIBYwK/QtTjcPIUtdSOUAJTSVsvWdpDiXSK8WqtpV8A5UbFK/0et5TMZoTdCUeGnrhs/Vq4fpOen9L6ZfoNglERnGurWDl5ksVfIUekqV3r1dmsq8krThVpndPz3XVhe8ZXpsuGhrL8hY2rhvzRUC9V3xN2+Xf2fyxyivOrWFPhV1NkviLonlZgaul9Qz3lGf1ceV6L/HDLqlzzwhHDUN3jlZnoyo7asfXEtVubN51kzfUNDk2p+mmYzudnOFZIi2ix+0y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANuLj9pE1eQqFPWvL+9c9oUHXxjsR9iNq463T6iFlXA=;
 b=DjH/jgIAORqsASgFCKmq7I49oseLvhr4nNzwJjbjHL4YyOtS7hSRQfzTpj/hAqLcEWl/uVYm1H11HDJf22nAoNMABrhtBy/MfAJHjdmWUYpw2HzFpeLSWQ6aYvq2NaON2TbNZxGvIVhUDFzKjQXrRmhb/8kbR14WDhLxEd9oPYc2jO47nwUHHm/rqdYT8N2atot9RJ5I/llloglVnGyp9fCqHeSeJxk/cLYcW/UobymefjQMMeWGcH09K+mldU9zyUjsR1bhgvqgndxN9nFYdCHzP5pi6WHV6Pb4wDYz+//zFyvJW50Zu9yE9h831eXk8ZAcWvP0HnrnLJY7hPBkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANuLj9pE1eQqFPWvL+9c9oUHXxjsR9iNq463T6iFlXA=;
 b=DXWd0PhyWiDu3zNnk6fkgBMUFme+Q0Aws2DMUcE2X2IwF3DCg1rg6C3hTqBnDLZMOn+hkPba/ti83ODA2MWLBWDWCm+M8va+wWGYq0T7evoFXiCYqZyjzUXfDZ8PW8BaNw1nkEiRK9rv4xWpye/1AvMHsNw4xtdrciQuhRbHpsE=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM9PR04MB8289.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 18:01:04 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 18:01:04 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 25 Aug 2025 20:00:55 +0200
Subject: [PATCH 1/2] arm64: dts: lx2160a-cex7: add interrupts for rtc and
 ethernet phy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-lx2160-clearfog-omissions-v1-1-e3a28c0ea55f@solid-run.com>
References: <20250825-lx2160-clearfog-omissions-v1-0-e3a28c0ea55f@solid-run.com>
In-Reply-To: <20250825-lx2160-clearfog-omissions-v1-0-e3a28c0ea55f@solid-run.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM9PR04MB8289:EE_|DB5PEPF00014B8F:EE_|AS8PR04MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fcf263-1554-4b2d-c5d0-08dde40163a4
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SW8rUzFhQUlKSmNIRXhOTklFaklGZzRzTnBxaStES1RRNFpoSjVUeTdYK0NR?=
 =?utf-8?B?Z0N3dVBDVWxaY1FmUm1tWTNXVmU2OS9ncWVHL25YUVJKQjFnSDFqYlg0TGky?=
 =?utf-8?B?Y2s1a211c1VpcWtlS2xoT044K3lpQXJYMjZCWFFkODBkMW1VR0FKUk5HNXla?=
 =?utf-8?B?SUppWkZBYjRtRGFaMlc1b1J4NnBTR2RTMjVrSkkvZk9NZ0szU1BhTi9taXRJ?=
 =?utf-8?B?SCtKc0d3cXAxQ1c4Ly9UZWtyV3A2dHFsZ01OQlJGdWtPWm9teGZWYlg0QzhX?=
 =?utf-8?B?bnZKNGY5K29aMDgwOHl6SlIwbi91NzRsUENVQ2NkNS92NEpQT3dOd0NvQXI3?=
 =?utf-8?B?RXY3MC9mYkhHWU1iODZpTWlhMmNuY1hkWjFPWjc3d0dUcThqcmc0MHV4cVBz?=
 =?utf-8?B?SmFRWlVyWTJTelZMazU4MmNmc3hRZ1UraVN2UjNBeEZqN3dTczhuRnBXdWc0?=
 =?utf-8?B?RzRWdWdzNEV0dmxHTUhZSElzakc4YXNxOENudDF4TitWMUMxQk93WjJ0SWtu?=
 =?utf-8?B?TDJzaHhFRWhYaEgxVExqMXFFay9CT1I5ZXh3bVQ4UVJCV3hHaHRQcHdhZDFI?=
 =?utf-8?B?ZGY5SXJPZlpYRjVHWUNLbWFQdDFFSUo5TG5reVNjbGVJaTYwd2JMTGlVRS8v?=
 =?utf-8?B?c2gxUmVTYUNSZTVna0RFSTN0dWFKRWRVclVUR3NnUEJvdUtTN3JZd1E4aTVT?=
 =?utf-8?B?N0N0aDBWQUswVENxeXp1TlNnTVRTY1lRamJmVzFSZlphYTNHZ1FOQlV2UDBO?=
 =?utf-8?B?WnBtbHNvZU16MHgySjB2MkdaS2ZYU3hNQzFJVWVIclViYm9aK2dsaUN2TVM2?=
 =?utf-8?B?YWVIMWJxd3JGM0dKWWt2Y3RRSFpZY29PNFBDSHR6R1NWRlhKM0FMKy9XMll1?=
 =?utf-8?B?cDBFa1plYzRta2p0THlSSThaZ1hkYUwyOTJlVk9JK3NwN1ZOOFVaQjFUTzd5?=
 =?utf-8?B?NWxJQStqYXVTNlUrT3V5elB1WjVvUzNNNVE2Nml4YnVTNndkckZBbGQvNkE3?=
 =?utf-8?B?Q3lZa0N2YXJHb1pVOG9qZG9nTGVTR0ZYcTc1ZkJIZGJuQnZBSzNSc2o5eEdx?=
 =?utf-8?B?bG1ERVZyN2RZaFRzKzkramhxY3hTU1R1cUcvMWF5bG5hUXJydnJLYmtwWXpv?=
 =?utf-8?B?TkRlT0xERUZ1eVM2NEtBMklGc1RRODcrTm1zdEtKYzlSMy8xYjA3cW8rL3Vu?=
 =?utf-8?B?RTA0Z1diV3U2U1NmRnM0VWVIV2I0NUIvT2FCUVVMK3R5bWVUdE1UUk1ucVJR?=
 =?utf-8?B?N1FFV3RpczFodGlzM0pack8wcThIdU85endXcHVWcUI2Sk9yNmFseE5aNjdj?=
 =?utf-8?B?cGpHNlRsWVdONHpkR3VPd29jWVR6YmFYVmtRY2tkeWtBeWEyS2hwbGNUcGQ4?=
 =?utf-8?B?TEpKeldRZHN6U2RCaHB2MUh3TnluS3gwOFc0V0xGY25LL25ReTZWeTZJdlRO?=
 =?utf-8?B?bWI3ZGJDWGlTcE5kY2x3V2JtakwrYTl6UUx4WGV4MTAwSDA3ZENXY0VRcU95?=
 =?utf-8?B?Snc4MURIRzV4aWFmV09SVFAycjkydHBsMHNpcXl3WVAxM3VwRjh5SDVlckVF?=
 =?utf-8?B?OUtzdW1BMGJRTHZGbGpRa3NjUi9Vcy9VR2wyb1BRMjVxeTdBUllyaENFT2xw?=
 =?utf-8?B?UGZBVVlaVlIrVnJteHhpL1FYUG1NcExhM0l2ZTZuVS9RRUplZkN4TzJYdlJH?=
 =?utf-8?B?dSt0bHRjS1dqTUtlbW5obXEvbXZlZlJPdEtSSmR1NVdPUWVVVWlJbnE0R3Ru?=
 =?utf-8?B?RGdDUnJHLzQ2bEpwN1VmQk1QNzZ6UklqL3dnZDRFVUpQMFNPd0IzOTFKUkw2?=
 =?utf-8?B?aWxiTkVUT00vMDlTNnRBV2k1VXpNaGVPcmxkUDhTMWVzRkpOSVV5Sm9pVmI3?=
 =?utf-8?B?UzNiRy9WWXlSekw0ckJrUnlHTGZjMitoM3BZRzdRalg2RTk1bDNIcG44L0pY?=
 =?utf-8?B?aDkwTUx4bmg1azRxbmMraXY4RkE1NlpOcXJ5QkF4Vzh4ODZPUk9ZT0N1dEZZ?=
 =?utf-8?B?VGFtbE5mME93PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8bab0fd1f7b74a5f9516d074d765a45f:solidrun,office365_emails,sent,inline:b7f6fed3d82496f51e06eac14cea92c1
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7cac9261-b112-4e76-cba1-08dde4015bd2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|376014|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1E2TlIyU3l0NklHaFFmL3hpVm8vMGNWVlp0cnhLUTQydDlZKzVhTCtPbG9C?=
 =?utf-8?B?MHA0dmZsWjJ1WnFHamZpclRVQkVrd0ZhekhacWtnK2pkUHlUQW9LWUxDTjVw?=
 =?utf-8?B?RExVeTNqMUw0M0hRdzhkelN6TDFXSTFPS1BTSEREREJQOFJTa3NlYVlwd1Fy?=
 =?utf-8?B?ZnN3RSsyT290SzdVK0c0cFBJdzZsQW1EM1dYeDBtQnh6aEVVZTg0aWhFdXBa?=
 =?utf-8?B?dzBqcUo4bys3a2g1K1RSUDROcVc2SklGU3NPVTM2aFE5c04yek9oWDAraGt0?=
 =?utf-8?B?eXNyZE1xZWJjeGJxZTMvWWxGWUdBTHc0VGh4MW9wV3NOcTcrdWVmQnhONjdH?=
 =?utf-8?B?TFNVcXNSYVlVM1VmalNlYzN3SW1HaG9KRHNLdVpMaHZuTk90RU1QWlNPaU50?=
 =?utf-8?B?dm01elNJSC9reFNSWDI3WE85d0k3bUp2SW9jc2I0bzRaTkJkemNML1ltT2Fv?=
 =?utf-8?B?N095Vm04amRJdi9BUm5DbDg3Wnh6RnpmcVFjTHJxeVRCcExJdW4wSmhNOWJE?=
 =?utf-8?B?aG5JTEo2c00vRm1MQysrVDBJS2Y1VnAwTXdmWTR5T1hCNGVYcGxoQU9CeUhl?=
 =?utf-8?B?d2M4Z0VveU1rV05QWE5JQ3hNS3h4WlZmRktBZmtoY0dvbWQyb3JJZ3U3bXNR?=
 =?utf-8?B?Y0dhSkdLQ01iS2FoVkc4Z0l4ajZmQkZEOWhTekgyb3J5WDRqL0JkNkRaNXdl?=
 =?utf-8?B?Q0VXb3VLRlQrd0dRd29UYXNlYTNVZ1IwdTkvNGptb1ZRZ2U4ZVBMVmF3Um42?=
 =?utf-8?B?MFNSUkNwb3VNMEl3Z2tha0ZyMmtOSGRiMWE5VS9HZ21Ma3hoMUltWDlHeCs2?=
 =?utf-8?B?ZWwrTGFwb1BDZUZiS29vV3dQZys3TGxpeVFzWVJnUjJTSks0cjNNQXZ0ZDI1?=
 =?utf-8?B?NTJFY1dKczArNC9TM1JsUUtCTjdGT2dPQk5Scnliam9IYVJXRTB0SDNhRHgy?=
 =?utf-8?B?d2xubGovM3lid2tFSU1pYktYTm9OU2ZHUXYzNk5TTWs0dzVjN1ZNa0dTMTVp?=
 =?utf-8?B?a1h2aTJrWVVZekxidzI4WUJ5MFNkUXJGL3ltSE96VkIyYUVrVGlvWHNFOGE4?=
 =?utf-8?B?NDRmZW8vbUg1U1Naa3F5RWwvK1BLQU9ETEtEWUU0V3FKMUhWdkY3VndLN1JH?=
 =?utf-8?B?MFd6SGxKNnFhNzFxaVJ4WGhrRXVHK0xZMTBzUVRHb21ad1FTY05kVXoyVm12?=
 =?utf-8?B?RFRGak81cGp4RGUzNVhwYXJueWdleXdQdGRncVdpakY0Nndlc2RKN3g1STdV?=
 =?utf-8?B?c0RsZTc4eFV4eElrN2dkR2xhajJjRnNPVndCWEFNNHRhaDNORGRrWmtFWjBm?=
 =?utf-8?B?SkhyS0syWEdSbStmWU1ZZll1SU9rUzFMZnpiUUxnVTNaNmFRaXd5cWR5eXRU?=
 =?utf-8?B?NHlWdWpZTjNXN0hJTEhGZHVid0d2UUMrcnUvaC9Yd3ByRzJnYm5EdzZoVm9x?=
 =?utf-8?B?YVozc2thVDE3N0l3TGhVdFlYdmpIbk1jQ0wzTDhFdkY5R2tMaXZXcFhQN3M0?=
 =?utf-8?B?REh1emxXVHZ3VXBPZzBMa2hTc3p1bnBaaFJsazdDZ3FDRlp5Z3VpMFFoaFVh?=
 =?utf-8?B?U0pydnFKa0RwbzVUb2ZCdlEwMkdMVGNNNkVPZ0dGcktxd2phT3NSWURDeDVK?=
 =?utf-8?B?YzFaWTRwL2tPUEdsSWpFUGZFY093OCt3NVRIWCtheUI1Wjl0VzdqRml5N2RS?=
 =?utf-8?B?bWZ0cUw2UVJKZldXSFpwdklZL2JFQVd1NWNpN2Z3K1VqQmMvMlQ1S1dPNkN4?=
 =?utf-8?B?a2FkQVdNemhyWTZjbHlMajJydytSaEtvSUpxQTFHcTRvMFNUWDNTaXVvL3Rn?=
 =?utf-8?B?dGltNTFwU1hib05ZMzJlNDJLWmpOYVZ2Zm9lWEZselE0aFI3UU5RYnkrbzBh?=
 =?utf-8?B?K0g3UkM5UWx0OCtia0ErVzNiZjl2ejE5R1B3THJ6aUg2TVl5OFAwNytzMXFa?=
 =?utf-8?B?Y2hEbkRzNDgydFZhQlREMFZNaUQ4SmNRYjlOaTcvMTJkV1NiMi9CL3NvMzJR?=
 =?utf-8?B?bkxLNkF4c29LbDR5RE9aeTVmRmV5Qk0xRkN6ZXZFVE1wY2cyRGxVTkwrMUdH?=
 =?utf-8?Q?ue/8ZJ?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(376014)(14060799003)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:01:17.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fcf263-1554-4b2d-c5d0-08dde40163a4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829

SolidRun LX2160A CEX-7 module has interrupts wired for both the rtc and
ethernet phy.

Add description for those interrupts to the rtc and phy nodes.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index e4b727070814f9183904a7384c47229e364186b5..eec2cd6c6d32a72c332223f15d195878bb65d7f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -41,6 +41,7 @@ &emdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		reg = <1>;
 		qca,smarteee-tw-us-1g = <24>;
+		interrupts-extended = <&gpio2 4 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
 
@@ -156,6 +157,7 @@ &i2c4 {
 	rtc@51 {
 		compatible = "nxp,pcf2129";
 		reg = <0x51>;
+		interrupts-extended = <&gpio2 8 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 

-- 
2.43.0


