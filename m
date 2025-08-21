Return-Path: <linux-kernel+bounces-778764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC028B2EAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B905C5C6CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CC2475C8;
	Thu, 21 Aug 2025 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2gFaCfq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58124466C;
	Thu, 21 Aug 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739999; cv=fail; b=JHhyHZxi1oXO9pIeME3r1T7K76+n/5b1PcjY2mX1RQi3vkPCJS5FlbUGWV1tz+hePBjwnhq3ioNfSvrsCWUPUlLfki99IR6KAWq+EKvC+zQviJ5X2OSaJNxY9qRB1gzkR/yFgrpnvex5Hcyvq/4DXReqB7/2jRs4LBpLfhhy1WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739999; c=relaxed/simple;
	bh=TNvKKtRjBS7gKHwP0N9mUC0dRO+OTEyanM87S+59YTc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ABTTsObjU1ykGvsv5Y1BvKBZxDr8NgoJHDxCp9TlzaI4w8j1pNnsPQdrOJspwN+RTybly/Rjnq4/BszrpIMte9K63khgOCJGMyxZRObcz1bxVyf9B1jhDpNJQyDMLK4k+pb9fr9GaHqxNvmKaWilsVDNeeqMa/sikNxgko4Qxnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2gFaCfq; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjFmFyMQOpeuy8ZHM9pMt5eZCQzbAE+tdRRqhK5dVDyr52Wss4gFS4zwQpOpJYT1Q0j1e4dqNNJ7ndWfPAu//bCynxKrro56sS7YuLMj7UW/QX6w1JdP/7nnfI0JjV9n4+icQTkR7xLx3fp9kmS/Uleoj+5D4A+ALx4Pw2H5I0CeaDS0TOa9MiSp6bq2SEZAyfkMvwp7AlKk9cukdjtEGra6WOhFZKoSMk46tTytQReUrDBrytFeMTqAReBFpWeH6nEenHYdjWMfMijFExVNVDFEtpr+rrUl6eBcsv/mo2CPYIRAys5B4V0xCOaOEZhoiBCeflcDTVCZPWBPq2s6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNiJz5UBAYT4EIBNMf4MVVSL7fM6c/C5v8Z4jz8MFvY=;
 b=W3JJbmVGEMa7uOTvSo9Avo66hwoAPAdR/cO4KdWqJnufDX5+hPYeAPT3NfArg1FaUWe0T3Q+hgbHONpKMGmHEL6OTw5s3wlswdVUGGm6kJu3Ol0jZ+h1Ierei8Sm5Wyb3vuZXNotMgstUC61TbQ2HNIQVl1tD7TqlreY4Goh5zXLVh8L585pANJLkJZ3BG5MZYbBe6oFsnR0qZI3cOxJ4iVCNEEZQxUhyTMaMh48FtbOXivSbWV0ZQizAYemGX4O4jFcO0BnbvfTG34AocUlqXZqVonCisGflDZ7WeAUNR9wCDg7wNuTgur/OKJDm5CrB6AWeTPkjZ3rDttS27sApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiJz5UBAYT4EIBNMf4MVVSL7fM6c/C5v8Z4jz8MFvY=;
 b=V2gFaCfqbaQDB/216eJZ3HZ1KDDRd8cwVWSFYidjrDD97MUB/ArRAL8oUnSquN31kA/OeuShZmWp+GplTFlzSJ92A1U66Mcl0nf5nbf5EpLQYuHzE3iWfBKbcMjQF8V2E94ALdPJej3AlEAlp4cDdE0QprQb78lMX5tZeubcvHBkA7MJvP8ggSVZzNZatwnVaepEwPb+S4ITCE4sSHU40yvFYcxgVROUW6y+ONzHu2vc28CqjrLHIk19oibKGS1h2TKc942TO/HKuSjF+pPfhSXRmvzYGvgv/AN4kv6xFa5orcdQc7Rm5QFEzuda3S1kwCkzTdt6zwtlQqBXxi+AAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667) by DS7PR12MB6213.namprd12.prod.outlook.com
 (2603:10b6:8:97::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:33:12 +0000
Received: from DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da]) by DS5PPFEAC589ED8.namprd12.prod.outlook.com
 ([fe80::fd4e:4c62:b756:96da%5]) with mapi id 15.20.9031.014; Thu, 21 Aug 2025
 01:33:12 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Wed, 20 Aug 2025 18:32:51 -0700
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-mgx4u_devicetree-v2-1-ccd2831b29ac@nvidia.com>
References: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
In-Reply-To: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755739989; l=874;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=TNvKKtRjBS7gKHwP0N9mUC0dRO+OTEyanM87S+59YTc=;
 b=LJDWAw5It7801VBC0G+4SAn/06zkHoLCu2spcgeMdD5P6ONOgjGOdPizL1FLcdbbkF9H6kj76
 Bv8FyXE97ShBvWy4PBav0TRd7Wp8oTT9pwgmfatlLkJsuByjsKMoG9o
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To DS5PPFEAC589ED8.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::667)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFEAC589ED8:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: aabc2e49-36e7-4714-f822-08dde052b131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekZHRHEzSWFya08rSG1Qc3AwVWdYZTZOd1Q0OXBkWkkvcHc3UDBoYnhIN2I5?=
 =?utf-8?B?SlN4OFZySGVDNkJZOGFZOHFvVUZwUC94RXFSM1lSbE11S2YwbVBpQmpPV284?=
 =?utf-8?B?YXRkdVg0MldYY0lJRnNac0FIeU5iWmxaQk51aHdwTmJSak1nckFQaGs0MXZo?=
 =?utf-8?B?TDdxSjQ0Nlp6UUJCc3o4WjhER3BXbTR0dnpyb0dVZk0vRGlJUDZUKyt4R1pl?=
 =?utf-8?B?THJaaFRsQzYxT1E3VHNEM0VLK0haUXR2UmxyV0RXUm1LbGxqdVAvZHQzdGtj?=
 =?utf-8?B?QTJzRGFxRjJyZ3NEdGpaZjdwcjcydm4wNktNdVVNUk1UdFhrb0dzZSsybTNH?=
 =?utf-8?B?OUxzTGpBK2RWbkpvdGJSTGFBYTFQa01CZTFYRHllUTE0K3RMazAwNm96K243?=
 =?utf-8?B?aEZLM0h3Wk1lV0l5WDZ4Qlo3SzJKSzczcTFTbU11U283RzVEV09QV2wzdk5O?=
 =?utf-8?B?ZTNBODJSUHBya3hjUlIrL1pTdkZjVHo2ajRNYjFjL3czRk1GVEk2cTliM0tm?=
 =?utf-8?B?NjVudnBjb2lWUzZHM241dEJqaTZmTXUxVEdkNjR0Qy8wRjR3d2FTbXl3TGpv?=
 =?utf-8?B?dlJvNU00SVlTWndVZEwyR1pxVGxxUWp3VHdyb3dnbTBwZFB1bGdDQXJxSHM2?=
 =?utf-8?B?eTFFS2FuMkd2M05RdDhuVUlFbUtzY0hzL1JOWG1ndGpXdmVBeFh6Z3NqMWpt?=
 =?utf-8?B?NkJ5NEdXdnpLSXJ0OVNyOHZza0dERmpPQWpHbFkxdThKVFhhU3pZNmJyejBU?=
 =?utf-8?B?N1ErK0FMUVlobmVVcjNGNnNTbUhxeTQxcXVCVDV2OURFYXZKMHpqb0w4YWdR?=
 =?utf-8?B?VnBrUVlMazMvQkNoRmFBSE9LYWJDMDZHeC9WQVBlcDdCVVIzNGhuSGdHRDRS?=
 =?utf-8?B?dHNmUEptSWp2OEsxU0YrZGhxdkd1eG0rZUxQL2JmcHcrYXFLQVNCdW9xQTlZ?=
 =?utf-8?B?VzdGaE1zTEtPQ2IzNVdTSXY1Q3VBTkluQ3ZMaXV0VWhITDY0TG82RHJYNDMx?=
 =?utf-8?B?a3dtNU5sS2FkTEtPbUVwYkpGSzBBR04xZVlvWVJCdjRmZlh2WWl3N3M4ZlB1?=
 =?utf-8?B?eTJoOFFpS0lXWCt0T0ZucjYxMXhyNnR3Vk1NRktQV0hPMGtEc2pKYi9KK0dU?=
 =?utf-8?B?Z2RnL0VuUmtKU2didEVBdFRsazRTakNndU1wT3kyUmhoM1Y3SmVEZGs4TFRy?=
 =?utf-8?B?bHhPcnkyampxVnk5RmlFVlB6R2JiY0RsUE0xRjZrbEEwNysyNHJEaXkvZlZP?=
 =?utf-8?B?T3V2UVczc1U0ZmpCSXNUTVdwWkVIajg2emJGK1QyakVaK1RiSjByWVlOQml6?=
 =?utf-8?B?MWNTdnRjMERHQnFFVzN6R3AvOU5VcmtMNjBLWGxvelVuODZlNEs5UGJ4QVNO?=
 =?utf-8?B?bmRSbzMvMThpVUZNY2JSU1hkR21XbnljUmlWUWJQYmx1cHlPYzdGOGVENm1x?=
 =?utf-8?B?N1dzYktCRy9RZkthQy9XbWZpdWlsMVVBK01pYW9SK09TQkNacTVJeHBIdjVO?=
 =?utf-8?B?dTJuMCtWdFJlMVQ4NEVvSHFxbFVuL05aNG9DTWZPZ3dZVDdLR2lZOUgvNjFK?=
 =?utf-8?B?N1lDaldGYmo0ZjZtTFVQcHNDNFlNQ0hHR2c0S0tWWTcrUlZsTmVlYjltRlRm?=
 =?utf-8?B?R1AvdU9kZWRTSWdJRDNueDJEaDI3TzhLZ0l2WWJzZGpJTUtYQkNhRldYclIz?=
 =?utf-8?B?YjVTWHhNTkxKVXBoMURDVWd3QVVlQnlkTGc0VjlhL1lIVmNLRHB0N25PaFpT?=
 =?utf-8?B?WG5Fem5HV29oak1YcDhsSEtzcWdIcXJFNEc2R2ltbGFJK2FwQWdDemJISE5C?=
 =?utf-8?B?eFlGcFJ2SmZyaEIyMGtHUlRFZWExM0xkb2Q0OVNIckhhRmJ1TkFnZU1YRFFE?=
 =?utf-8?B?ajRLYzUxSGgvS01TQ0NXb1NnaW5Pc2FTSTJrTHZBREhsZ2NvYmU3TWxUL3o2?=
 =?utf-8?Q?3FUMZ57DgkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFEAC589ED8.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2Z1M3JYTHc2Sm5EcTVVTkMvaW9zN21DN3BoRDZIT2VTckVwdFNpeEt5cTJr?=
 =?utf-8?B?MUU4SFZjbDBYWVhTc29hYnNKVTRWeTFMbzgxZjBWNzg4U3ZvTGl6Y085S0ZB?=
 =?utf-8?B?dEhJNVYrMG9sNHN1N01yVDRUbkg3WTNRYVloNElHTm96VWc3dFJRMGU1NkJN?=
 =?utf-8?B?SW02Yk82NWhRcVc5SytuU0RsKzlwYmltYjhYNi9EK3F2T2lwWjh0VUE1dDdt?=
 =?utf-8?B?SXN3WUsvZm1QUW5PY3Jsc1NoVEpJNEJYNXdhbE1VL3BtdkIySHVqNHhWYTN0?=
 =?utf-8?B?dW5IejBZRHg1a0F3alBGVG11WlZyeUlzS2VzQy9iYjFEMUxybkg5cjZMZXdo?=
 =?utf-8?B?QVhoWGNvZVdEMzJINHlEUFBPdmxTMmo3eXA3TnI2T0hscVVKWC9QZlZJZEVH?=
 =?utf-8?B?SjNLTnk4czI2TnFOK2dyS3BOTFVWU2R2cXNtZmtmWXRJT2djTWpFVG84NlNF?=
 =?utf-8?B?aFgyV0ZIMmdkNWZMMTNHdXhDYTJXaHdRMDVvRGFDT2tXTnZ6UEZFaU02TitC?=
 =?utf-8?B?Zm9qaGJjcWgwV0N0YW5qK3BoTUpnL1p2c1pvOTZKSFp6VXlQNnpVOW51elV3?=
 =?utf-8?B?V3hYZk5jTUtoN2pDZUo0NDdPWWJpenhQNkZjQlRFMjNLWjlKRERPNWRFSzE3?=
 =?utf-8?B?SUovYzk3QmYxOVFDVzN4T3NIaVRTZlJocElkTitGR1BseEthdDZ0UGl2bTVL?=
 =?utf-8?B?UnMyWkN6UG9NbEJXSm4yZlh0eUxkMzV3OGtJYzNmV3VuNG5qdDRrOTlBMUR0?=
 =?utf-8?B?OTdjR3pqY0JKTU9VSHplaVpnWEpYQjlVK0lkTWdiZmFpakZkL2VHVkxONWRL?=
 =?utf-8?B?THNqdGd5dFY2ZVVXejNIditvUlNUQ1lVbWZXcEF3UjZwZnc1SEVhb0E5cjcw?=
 =?utf-8?B?MXMydGFSYXEwT1EvRmtndjcwU3JDVmZaUGd5WkpwY1lKR3RjWVJrM0ExS3JC?=
 =?utf-8?B?d1ZmY2R2UCswbnBSSmtjb09IdGs0Sk9BZU5qUEhsNGFSMm1Pem9Pcksxdmcz?=
 =?utf-8?B?cGs2UFhKQkltWDE5dGZWaGhlbGpFdXc5YjBiWWZ1V2lqbE51WkVkcFN6WW5M?=
 =?utf-8?B?SWNBMGREL0RqTmlBN0NLN2phSiszd1V3am1JVWVaWmNla0dWTHJrQ0dHUk1G?=
 =?utf-8?B?RWJGb2ZKN0Q0aGpVYjk4VDgyMmRpYUM1dlZjS2RRK0ZYM2l5L1hUa2ZSdDJY?=
 =?utf-8?B?NlhiVmJ6SHBxUEpnSXU1MXJBWVFLL2twMmRaODF6Ulh5eXAyZ3JVd3hybFgw?=
 =?utf-8?B?QUZQRU1NU0o0eDFZakhVanBwZkdLZ0JZV3k0L3NsQi9TMUZnN25QbityWXNP?=
 =?utf-8?B?K0VBelU0Zmh4R2R0N1YvS2RyWE9vMFhhaTV4VlVHVStrclJEUTd1NmxWS3VZ?=
 =?utf-8?B?MHlPMHZ1Ky9FUVBWSFVLSU95ZzRzWk5TNkV3S0tTaHJnWkVSRzVQMittd2Ji?=
 =?utf-8?B?eFBqMlh4ek1wWUx4cWxjYzdQdG9DK3loS0dLOFNjdzZmVEl5VFVVdWZzaDYr?=
 =?utf-8?B?SGE5RytnU2t0b2dDY1RWVlBvS1laVWxqNnZxQXFobEVkYitDQzRKTnBvM25J?=
 =?utf-8?B?dHJ6WVU4c3M5UXRmQkFPZ3hxWWJnU2x0NTNYREltUldpU0hPeXh0TWtacjFq?=
 =?utf-8?B?WmZUVGdaNWpaZm11VlJWa2JTWUtVdjBSOEJ6aUpBYytjWHExRDJraUxOMnNh?=
 =?utf-8?B?NlBGSWIzU201MStiV3NYTVhjd3NSakU2bW02OUdVT3dmbkNhRWpWbmdac2Er?=
 =?utf-8?B?NXFSMFR0ZDZaZmxtbDZSN1FEd2pmMEp6SnlLSzV3L3Jkb0drd2ZDdElLVEtt?=
 =?utf-8?B?N0ZuZjJyNlFKU3RST3RHa0JtbXYwU0hLSjk2YngrdkpqOXp3cjhoOEc2UTEy?=
 =?utf-8?B?YzVybGFtU1BQYk9iVEszQ1QyMDRlMkxyTHQzeVE0REtuRGVQOUIwbE1ucXZa?=
 =?utf-8?B?Q3ozTEVMelVyTWJZQ21lemdiaFIvQlU3U0VkeXREeVJGekdNS0VHcFljdjQz?=
 =?utf-8?B?eW9mWXhlYTFQT3NldXV2QUtGeVFJenRrS2ZvR0RUWmM4dWkrZERUcnpXNmdQ?=
 =?utf-8?B?WjV2SHhSSVU5YkZtN0t1c1RMVCs2R3B6VU5tTy9MaUR1U0RSU2d6U2hjNjBN?=
 =?utf-8?Q?llniv+pZdJ3HbBLHGjyO+xAx4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabc2e49-36e7-4714-f822-08dde052b131
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFEAC589ED8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:33:12.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWaEO42QyZaO9gXyPsEO9fz8VJ8fbNkK2X5xDXzz1ZRAYHNRtjtdl9T1w+JqGM9a6Vtgqf/E783v2yCfVz5L0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Adds a compatible string for Nvidia's mgx4u BMC board.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8f4442be815284e1ad085287dc443..e6d180885b52cdff0797693c337bab58661aed03 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -100,6 +100,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,mgx4u
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


