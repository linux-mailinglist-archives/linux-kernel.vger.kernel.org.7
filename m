Return-Path: <linux-kernel+bounces-894702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAEBC4BA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 721CE34E84B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6EB2D130B;
	Tue, 11 Nov 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZWreNh0E"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB62D24BA;
	Tue, 11 Nov 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842010; cv=fail; b=Y5WDCy4Gtd0cAQKINb0REhWs6aXBj7lt1LObxcvFbG0cvmEz//ls+a77N8ZB/2BVkqjrr7cBCulYirNGgge93/psxWRcj34c7fBxfNhhLE/hIKxriixDYT/Q4hLp5+034H355mNZceh/FvUpuzZpge7N1utVVclgtliwkJfxhP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842010; c=relaxed/simple;
	bh=u9zA5RvC558ZyoJkVvrKXeropR/+cdchw9ztabjYnoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgYty0zeK59TNbToXHAb90EG1kcc+It2kYLvPc01G27mfOYj2QDbfq0OsytTiQJMbNNurG9np8eDZlQK830W3Sgw/QnlivWHhVJMQAVO5bBbfY8bzcqU3YXI+rA6HJj73bUFdslqSF3Q5C/kYSVbsyPkNyX4wr64Q733WTHdLUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZWreNh0E; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDuzZeXAHTqLIXz7jhg6vd26jVGDznbb0uZMeaHmo5a8r6bXjf2KpoDDMcQgxhdiPQdChMIST0lriU5j2eKebLDnNmOIKDcZIRrjL0WWnmN3IlYAkiIdssulZFYRHMgRgGvGoOePB2u1h26PiT/vfJMNGaUVoZU4J5htW1L29EeWn2lJzJ3E9mg665zw7jjD/D7qEvDv6iTzzOprm821tLVtrUZvjFEIiNTASG55l9SMthPB9uCdowhdt37D5ayI8L30uozjJwpG9D1ktKwArU0hCzIQGz0P/C+OU2yhXxX4SY4+2YdFUiFo+syKMqaJ2XxV/bZrQUb9qKNzU0SaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdNpXZVEgFt8QqZYz71hy6Cd0ShLyMZMhgZJwxeLlJw=;
 b=KR3sNxrwAkKOycLwOLUCFMaayVR+9vIO9nfRYj03pacKL0tvIfnRYXSckWF9SSSArwQV1jQ0JCjHceutxW/HiE7nX9bfKkMgqiMfcy/XEMPHE6yYz4DJj83zqvQo3MAUKaw8WsjUtkb4L/oKg3e/LpLwQTKSuxPIEZoFGYvwrexuBsUFWcKa7flXoZx3gZSFkFNGufiP1BDMF8LMdo2hkH829hpBnfRhw1pgfkqu4WU+IdSxyP+4VgVrZL9eo/HXjqbi1mKxnZVpLXYTxEpBaq13FV86jSxfkpXC05Oi5xWmU4I9IHq/8B+zB0MBzHQF+ak3AjZ7CCGDiOFF4t4AGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdNpXZVEgFt8QqZYz71hy6Cd0ShLyMZMhgZJwxeLlJw=;
 b=ZWreNh0EmjOqZT9CFcmwim9794o0Rks2MR9A/DieGWErDbtHNBX+cOYHxAk9XtsPNU7HpE3/DE4xhI4maUFp/ECHcWGHlKFeTL6qrpuaJkqKDVsXIskTbCMvVV/HkOlzx65hoX5Rb2sV0aLk8q9b5wLFmX9X1mv3iBqMJeDREiWWpcZpb+3mK+OY4nomwJND79ZjopuzRYtyfT2TOHqXV5tD5tdHKdz1HQFU/sah9t5qZMF1ukhHz5yl2rZvFNkYVGrvQNTVsGXCu3Nb7oW2gv6L7QZZ9LWBFvUQhPjonp2oFncoL219R9rRpKIv4z6dalmnnKkS04AEEbcCsgG1qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by BY5PR03MB4968.namprd03.prod.outlook.com (2603:10b6:a03:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:20:04 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:20:04 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2 2/2] arm64: dts: socfpga: add Agilex3 board
Date: Tue, 11 Nov 2025 14:17:39 +0800
Message-Id: <97fea9a15bfe2a3d52d5b75bee6bda25615422e7.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
References: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:d10:32::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|BY5PR03MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2631ac-ea44-4431-1b10-08de20ea5a10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDQzV2ZqczhVYlJMWVJIWTU3YW8yUDBLS040K1BQV1R3UmNSa3VPcmVrcER5?=
 =?utf-8?B?M004VkhXZjRNQmpDY2wrT2gxdGM1NkxBdlZuUlk3d0wyQmdTdmJweXRha3FX?=
 =?utf-8?B?ZGNtaUNueUR2VkJ6MWs0ZjdmTTRVbVR6eDZ2WS8wa2JDdXI0SGVjM1gzLzBj?=
 =?utf-8?B?bktTYzJUWW9WNzg1U1J3UHMyL2lJV3k3MGNVYTVwdkExVEQvNlY4SitZSkVr?=
 =?utf-8?B?MkorZkxtVHFETFFpQzhSUHRLbmxEUGtvM3Nhd0lVTGVmSlFBRHJkeDJJNVpM?=
 =?utf-8?B?OHlkV28rRmRGUTRpdHRpZy9iaENRZ3hBK0taWmNpTEpQbUZlMkk1ZkNDK0xP?=
 =?utf-8?B?NzdBaHVxbEJMem1VUUZ1emhvaGN1eitMQ2s2UHkxUHpRR3pxMGJuUEhxUk1n?=
 =?utf-8?B?aHBscnptdHBXd2hYTERZRlhIbWx3ek5xcy8rTTF3NmpWMlVHTWoxUzRnV05v?=
 =?utf-8?B?M1BBb2dVT2NNQm9ZV0pldHgrZm1tdzBYODN2T3lnelJHWHAzK29acmV0S2tq?=
 =?utf-8?B?eVQ5S0liRGU5K1F5dmtNRGhKSHlnS1FxbDIzcVMyYUNEQ0hhODRob0ozUElr?=
 =?utf-8?B?QWZTL0NvMWNkSzhzL0V5VXZ5d2RBQkEvSWMwYWs4bUhPakpTZWo0aGQvcjVY?=
 =?utf-8?B?MXFrSkNKeUNmWGVHNmtGdlBVeFRVUVIwRS8xcGpHZDZqanZ1MkJKWDJIazJF?=
 =?utf-8?B?aXNzb3htSksrcVF3dW01YXRSNDVSSEs3SytqcERLTlpoUEdWSUg0TVJOS0Yz?=
 =?utf-8?B?ZUdPZ293c3REODd0eEIwOUcxT2hHOWdqNlQweE9HZkRVK2xMNkRTQXVZZ3Jp?=
 =?utf-8?B?VVZiYjkrUWlENG1Eek9seWJmbXBOUVNVb2UzVm1pa3hTSnM0TG16NGtmalhr?=
 =?utf-8?B?TEFpQkpSQ2o3Wk1iL3hhWDBWR1pjMmlVSlhVdkpZTSswZEZjZWJTd0NVcHUy?=
 =?utf-8?B?L1MwekZXb0RFZ1JrMHlVOU1NcUdVVThDVElrTXR4R2Q3ZHRMZ1h0MW44RGt3?=
 =?utf-8?B?azhMVU82UVpsMXNkZ21EVzZnTHhHRmpzYllXT0tKaGE3Q3BtQWMyOGZZYVdr?=
 =?utf-8?B?eFJKZXlETXVTU3RyUERWaGQzWURjR3FBcXVRbStXZnl2RVFLbjZ6bE5HL2F5?=
 =?utf-8?B?RllIWmg0Q05kaGJwWHh4MVFWMmNtVUljdTl0ai9jR3pDYWRhY2U5RnRpUUZw?=
 =?utf-8?B?RC9VYnhuemIya0JzSTBkdVh4aFo2dnpKa2FSMDZFVHJzMHhjUjdEaG0vNnhk?=
 =?utf-8?B?L21VY2VnQ3JmR2Z6LzdqM0xwQW9QVG42ZTNJWkZBVTN3MFlvbzM1aGlPQjhK?=
 =?utf-8?B?bC9hVTg1VnZKdEl4R0c5VkoyMXJrZUt5UVhrcVFTWXlGODFZaVhCcitnV2lU?=
 =?utf-8?B?RXB3M1NDcGorM01BSnFuS3VCenFmckhwU1N3RG5LREV2K0tjYmNBWE01eHFw?=
 =?utf-8?B?YXE2aWR6d1Y4aFhOYUs3eFVRdkdmUEgvR3NDaVpJZjluU2xFbGFPaUQreUhE?=
 =?utf-8?B?bDE1Vmx0MmVSYXYzcE1rcWdUNGVYSkpWbFlhVzF4WjhNMmZiN0cxdmlKMzll?=
 =?utf-8?B?dVU0M0pNQWppVE1GOTVsRGpsM2JGemVxYzljcmJxUXY2aUwzY0lwa29MK2hh?=
 =?utf-8?B?Z3l4MitmYzVkQUthcEJEL1FDc2J0SWFpaDRPUGVxTlRVc3ZIWG5vY2NjN2Rj?=
 =?utf-8?B?M3dBRHNuR2hMRmlvNDJEemVpOHk4NklaVUpEYmgweU9IKytZdTR2M1hRRUdR?=
 =?utf-8?B?b0hETWtQeVgvSGxBdXVXRW1xZjJqdDJGeHY5VHgxd3hwQXJicHVIcnhzSHFE?=
 =?utf-8?B?aG10U0dXRXJtazJhbnRrSXlCaUZSUlpqSklIU0lLdEZDbG5CUkszcjVudllL?=
 =?utf-8?B?dlNlRTBDaXlLelgxTlNXN0M5WTQvTVhOWXVnby80MTdVTnlxVUZWVXVlQUhF?=
 =?utf-8?B?V3hPRWNuQ3F5NTBhVytFNXdYR21Hc0tZeEpieTBhSG1nemwxR3NVbnlWTFNu?=
 =?utf-8?B?OEpxVmZBcWN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THo5U2VBamFhVThtWlZQLytZUkJ3NW50T2VRR0E3T3ZvbzdZUEhERmhnUGpD?=
 =?utf-8?B?eFlKVDZ6c1BtS3praVBXRXZPdDlETnJuRkp3cDNYSTRSaVlRQjROWEtoSk5w?=
 =?utf-8?B?cHhSMGgrNFFGUXpzaXVwbFQ2R2hXdUhmYlZwT3FBNHppWUoxandYWEZlQ2w0?=
 =?utf-8?B?ZXZhVjdoR05BZW9GUS9KUDZwdG9FdU9Ha0lZTTFzWnF2WUtnNVpxekFwamg5?=
 =?utf-8?B?M2E1VXJQYStpc3EzUFJNNmJFSU5iNW41YTRzSWViVzZ6R3JobFRNK0t6VTY4?=
 =?utf-8?B?S1ljWVpyK2RmdDVHOVNYaWthRUpBd21NeUoraXoyaXhSQXVLaU5nM1RiZUFK?=
 =?utf-8?B?ZTJMTXhiNnlNUXRYb2pkVXh3WmcrVlVZdzZ3V01JRVhuYmVwYWU5SWtSWkR6?=
 =?utf-8?B?L3ZsM2pqTmZUZE9GODF5ZW12SnJ4cUpsaXlhazdFTzR5Q2ZONE0rM2RLMDZW?=
 =?utf-8?B?Z3V1RDg0MWQ3bFZoUzVuNnU5L3BGWEROblI3Y1FQZmUyS21sMUpQbnV0Z0t0?=
 =?utf-8?B?bHMrRHU3SG90UC84TVBiU1JLenQ5VnBIZVZ1M3lmWHgrVzdYNkwva2dYajN0?=
 =?utf-8?B?TW44NVN4ZUtGV3JIZ3RRZ3JjNXh2U3lmL2NzeDRaaWRySGI0MUtwZkw2eith?=
 =?utf-8?B?WnE0dy9RVHRydVRwZEJhS2xwQy9RNHBsSDlKVWphM3kzYVdsWUxyQ29Sa05x?=
 =?utf-8?B?bmI4V3dZNWVMVXVWL21NV1dKUlY5d3Z6Y0lJbXFRVU5rekZ1ejExcHJCc3Nn?=
 =?utf-8?B?QnVuSXJ3MzlzTmtRUGxLRUtWdHRnVXJxQzZ4cFFZeEN2ZzBXZFRkb29jUTZO?=
 =?utf-8?B?cFJzbmN2Y2paTXVOTGN0bGQrY0wycjR4Y0dtOW5kR1hmUVNYMUFHc3BkdWNG?=
 =?utf-8?B?QStucDhxcjJia1pmME85akFBZncxbTBDcnBPTjR0dzkzQUFsWU54ejBBNU9i?=
 =?utf-8?B?djZHTmxVZ1Z1YjJZS1grcFBWSTZlSU1RV3FCTmd5SHgxU2ZKZFo0Y3JEQVRC?=
 =?utf-8?B?KzJtY2hOMmpFWGdocXk0L1VPV3o2SzhrS3p1c2VYUGdtcXVpRHBZODhiS09J?=
 =?utf-8?B?YmZDK3E3OS9jNjZ3dXQwNVhFQnhqdE1qdmtvUzdKaFAwWjNPMytBOFBteXFE?=
 =?utf-8?B?VjRRZksyTHR6NmJMV1VhQXMzakVwcVBnWkI0ZkpBREp1NVRIM3hIVkZnYmVR?=
 =?utf-8?B?cnJzMEhmOTg1QTJDZ29hMmU4ODB0UjFSQ1NtdE9QbkwzaUtIVFVmYmRwc25H?=
 =?utf-8?B?NnhtUEdrMHFVVm4vSHY1NmdlVS8vRkFRdTYyL2p3Wjd1OEszeWFEK00zaHla?=
 =?utf-8?B?ei8yUGdhdkE0anZ5TjRmaWFESVZ5TUsyUHAxNno3SjBzZE9qa3RmeXhMQ29B?=
 =?utf-8?B?K3RQZFpDMjAzNWpYaUN5dVhwSVBHdkFKMFVvdGcrRFpFdDhEOXdMMko5MjBz?=
 =?utf-8?B?WTZkTXdXUStGcnExM3dpczFSaEpQT0ZoZXFPYytISTFKSlpRUmkwcnJ5WG0w?=
 =?utf-8?B?a3NZOVNTRXRoMW1nYW0rWm0vUm4wd0lvaG9yb09TdzdnTXU4MEpHcHpVbExk?=
 =?utf-8?B?TktnekdtRUZSYStWZHZDamNveTVlWXR6M3dBS25IRnFkaGJGSmlCTnlvTkhO?=
 =?utf-8?B?bDBzOG1iOGVEOWpRY3JXemhkbndPeDI2TjRrMEI1WU5jbWs4MWtSUWRmN0ZI?=
 =?utf-8?B?eDNNN1prOWMrWEdla3NMNkpxenNxV3hlRkNIMEVmYVZ2ckFMSEN3YndCRmJh?=
 =?utf-8?B?dWVpaDVySVpWd1VHN3dNSTZFcWdJTFRYaU9mUmozNXJHWjJFakxOZEl4RnR5?=
 =?utf-8?B?N3k2eExGRzBzVjRhWmNSeE1lakZzZFZJbUxxVWRzVnh4V20rVnBBdHIzTWtz?=
 =?utf-8?B?RENTTjhiUER0OU9HR0Y2OGhoRjVmOU5Kd0l6RmhLa0hnOWszVWFWK3RrTE1V?=
 =?utf-8?B?QjllLzEvcm1zUVk1enhPa09jZVJ5VWo1YnJ6MHNZZi9YNTQ4VVp1czlHZkJF?=
 =?utf-8?B?eWV2cXpZWHRuY1dIekx2cTlNUmFPTnlVUFNMWXI0elI3ZVBhQnh1S1pUWHFu?=
 =?utf-8?B?NTZQRWdJWHg1KzJYZkYvWHBpTk1sYWxaczFkZTdiK0x0dkRUUFJqRzUzcjVH?=
 =?utf-8?B?TFg2dVA0RFN4ZmVlNEZjNWpMVldpeVlWM0pRaVpMWEZVSXlwa2k2Y1lBYzN1?=
 =?utf-8?Q?tY5vw1/bMIqEkrAH8VSCzCyJgVYoFFEDm1qH+Lp2YsFb?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2631ac-ea44-4431-1b10-08de20ea5a10
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:20:03.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU7tULCoTQ40pqAZNRgTAEyeba7YDM/eexpSYEe+tLm5lM/G1gKDZagO36qxhTAixb0egCkk1mVajKnI4MY3y5lAzTXP/eCiMZzbXPDwdt1TwO7Q5q3Ihjwf2q4V/qiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4968

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a small form factor board similar to
Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---

v2 changes:
 - Use separate dtsi file for agilex3 instead of using agilex5 dtsi.

v1 link:
https://lore.kernel.org/all/aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com/

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex3.dtsi |  17 +++
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 126 ++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 391d5cbe50b3..a117268267ee 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex3_socdk.dtb \
 				socfpga_agilex5_socdk.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
new file mode 100644
index 000000000000..4e55513d93c4
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+
+/dts-v1/;
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	compatible = "intel,socfpga-agilex3", "intel,socfpga-agilex5";
+};
+
+/* Agilex3 has only 2 CPUs */
+&{/cpus} {
+	/delete-node/ cpu@2;
+	/delete-node/ cpu@3;
+};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
new file mode 100644
index 000000000000..fe353972fbae
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex3.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+	compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex3";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00600000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x00600000 0x03a00000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.25.1


