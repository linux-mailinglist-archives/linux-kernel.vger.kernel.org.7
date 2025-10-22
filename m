Return-Path: <linux-kernel+bounces-864751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99707BFB76F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B51189369D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95432863D;
	Wed, 22 Oct 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rTKPKYpU"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8484325482;
	Wed, 22 Oct 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130273; cv=fail; b=b9rUvpkiJAOUkB+3bhj/pUvtcyS3kbnE4wA6k/NuzqhSJ7dAUnf9mbeWD08Ekyy2AU13m1dRMdY8lMAkEVaF71nknhCg4Bj9Zz5diPjngncsAP3uRFtOgsKzOf/+3MnwAd+ZZXDVM74iVAATIws+QRx/1SXl/PvKSoWOrTD8zp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130273; c=relaxed/simple;
	bh=zGsbOGLafBFM9tTksNLEBZ3houETTLBCkNQuoGtj5sQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sRXJ8do/QHl6hvAu+sGal/1vuaxE5Ot3P557U6Kl/hZKLmVR1CRswL/S2svzLBF6iKdgX0t1kwcZIFlnsE4/RT1AGdi8IQZyixlffjS3v9gTTgdh10zhLpv2C5/Bqngk+aCVU88Hbpt1aYoCxzG9yE3df/z0Z/EXc5SgmmVBPXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rTKPKYpU; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/AnQsNfghTOUf6m0RaGw9ENsIK4m1NWskI8u8TB8d/1aN1KvyKMQRLZAWFMHlLNnUSfFaED5YhvGapovFF902BaJvJE/+PxPF1JDq4lIqNb7rvZRYk+lEppS6E/xIH7ku3z3qeaxBma87unzJWOkrsWrTE4dhnDMARJK7KiCvyZuL/atBGmYB/6+VEgz93Rcf28aH0ePSHkdOQlirRWcI2J58rZduVe3+zFnyD+yuZ7DiZNr51CrJveAxuUG8YOEN0Kc9A8+CqQMn7eusAEklkfyT6/X47cjIgxTdlbx8Ahzpm6PI4R3h/S+e92+uQ8Do9MbFfa2p5XJHNZztd/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p2Pl51tjFk36I0RML4KgRJGEFRFYaVrBIr7hc22edw=;
 b=gk3ldlNaPOzN/vDIJ1L23JZJ7OtZJ19HK01mnUrrrl7s3Qll/vXD23MxWp13tzTdxlAGhdaND8BogduChYN7QuYkyrXFlLDm2tIEC76uemasWZAJ2PzOW5K9B85Q9ePkm38E909b6DShP2X7A8lpbVYmtgFCYwP6sBuaJJmnG3YYVCssZa52KkJJI5yS09wNPYqfYB/dilIHPUzsNoM1Ugd9GYESVAhUTrlFF2rfHPC6FzcJdwk+zsYb7s6eHzBhFpWpQuHA53f8Vkcbi9d5fI8UjyC+GbfsruuXtDbR0xzo9wHvkEWAu0Jwe7wsxYJe+xmuuiOoFI4z+0BtjMy/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p2Pl51tjFk36I0RML4KgRJGEFRFYaVrBIr7hc22edw=;
 b=rTKPKYpUKeasXLkBI7//E0fsi5MHGsiZOEuL3ARM6IsfN3jgR00XpMBBBbiV760TjOh04C8hv2Z4WZmDHLl5dRilId8DI0TdYNAsv0EGGKxrVTNkhpyL/4BOkMszLoT5EfYTGOZwop9+UAPrLOjw743DomquNYsHSDpzrAVPwa4Hs0qNO4HEtI9djKU39tTAjTegoGx97BftwnVuMTs9KVhLr8NHPHbQnTKNKiMpqtxUlsBbl0CeJ7ANPvhiituQQMTAHwcpZQYL7RViITYnReS3t1lb1khhTBw328SJR9VqzylsEVZi5P/wEF0bC9sPDurKa7Yp2nNCW6/oQogGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:51:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 10:51:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Oct 2025 19:50:56 +0900
Subject: [PATCH 1/3] gpu: nova-core: bitfield: simplify condition
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-nova-bitfield-v1-1-73bc0988667b@nvidia.com>
References: <20251022-nova-bitfield-v1-0-73bc0988667b@nvidia.com>
In-Reply-To: <20251022-nova-bitfield-v1-0-73bc0988667b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Edwin Peer <epeer@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0318.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 38790c10-3994-4f4c-354c-08de1158e7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25QcmY3cEwzNENGSG5vcG1WUkdNVlRYT2FpRnFENHkySnprNzg1MG5IaHdB?=
 =?utf-8?B?azRCTEw0UWkzTElXejdkSnhHZ3ZjdnRBWTA4RUUveUZHaDhGUldtbzB4SUpZ?=
 =?utf-8?B?WnUrWkJFcnpZRDBpTHdVZHJVSWtYNmhUcmRLNVFxTCt6bldGNHVIMkplUGpw?=
 =?utf-8?B?RGJMa25JaW8vUE1RaDc2ZkFiQjAyOXhEZmVMRFMvdTdsMDVzQVVPbEhpYVFz?=
 =?utf-8?B?K0VNN0lkUDV1MDVzd25jaWgwWjgzVE1EWml3T1lLVHYxMURmbE5aQ0J6WExl?=
 =?utf-8?B?RUJub0NySjQwTURJcjN4MWVsZ2phdDJVOUEzRnRFbCtJSitxaGVqN0VQRWl0?=
 =?utf-8?B?YmdrYXk0Vm0vOWlHRC9tcTlkdHFOZGJsSUh2bENPczZ0Rm04UUFmR2tNZ3RY?=
 =?utf-8?B?dFBadHFwRnR3c0tyLzBQUFh1OHcvZlpmdDExdTdNKzlUZXd2ODlHV2M1M1Vz?=
 =?utf-8?B?NytpR2ZHVTlobUJuVnpGZnJiMThiVEVPc20rbEhJOExDUFNKalNGYnlCY1hj?=
 =?utf-8?B?OHp6MFNKUnhYcjVXQy9WekJxNWZneEx1L0lPL0ZiZ3ZGK2tLcHZ6RGxTVEpp?=
 =?utf-8?B?Q29YRnRNRWo5VW9YQlN6WFY5SGovWE00M0FaaGdQeXZ2V3UwaFB6Tkh0a2wv?=
 =?utf-8?B?RlNsUSsrc3pSQ3JSbUVYSGhjVDgvUWFCYlpxQ2VpYkNJcVFmUlhDQStZVUlm?=
 =?utf-8?B?MnRUZ0ZMajZqeTlFbFFtNzVuM09MZlFsVnYvdWJ5VHk5dVdRZitwMDNBZjFG?=
 =?utf-8?B?VGp1QVdrNzUyUkNUbDhwZUFzZGRGSC9QQ2tIZUs4aVNjRGhDU2l2OHBlUkdG?=
 =?utf-8?B?Y0dDNVNOMmF1TytKRGtKaG1MUDhKNWw1ZkVaV1NwOTRtY2J4Y0RXRldaU3Bl?=
 =?utf-8?B?ZlJ1L1J6TktkN2d1M21MUEZUdkpkYi9BdXM3NmlXd0wwWERJSC9PNWZ6VDJi?=
 =?utf-8?B?LzZwWXhIUThGd2l0UTBBRmVIQ1hkdFJKSEgzRFNkSWJNREpvejkwbFg1ajRk?=
 =?utf-8?B?ODQ3cVRjTjdzcnFWWHBsTUUxTENUUmdOd2VlbE11eEZSQm5nckZKWEVkZUhl?=
 =?utf-8?B?ZGRSc1U3d1YybVhLTVdCMHlKaVFZT0o2Rzg5cVBpSWlzV3g0UU44TG5yRXVh?=
 =?utf-8?B?bUFNczQvSWV1V3h4cUc3c3dyRDF4K1RTL0dyOHhmNzRKeHlUQlhqQkhBbnZO?=
 =?utf-8?B?WHQzM2IwZ0Q2cG42OWRJMCtXeEJxazM1RnVOaEtqNHQrY3dtRzF6UFZpMWlq?=
 =?utf-8?B?TDVTbEFaQnFzT0RxV1MrMEJwclZsNitIQzZoVVZyTUt0MGdRMWFTaWtENkNn?=
 =?utf-8?B?YmkxTHBlcXFoY0FScUIwN25janlaTjNTcVFFb3AzMkQ0WkpXRGVRTElaY1pm?=
 =?utf-8?B?WVMzRzdZK3RNaWVqSFdVNkVOZFhUenFNb2J6b0NVVit0aGhkYjdSN0RSNE43?=
 =?utf-8?B?cjJ0ZGNwM3g5Zjd5ODVoMk9CSGYxTWxuQXE3QUZuU1Z6aHRJTVREKy9YUXdy?=
 =?utf-8?B?Unp2Y2x3U0EwbW40ZFlabW1TOTZwbWQ4eVpPYWMrODBDdEZCcm9ha1U1bVd1?=
 =?utf-8?B?R05uQnRoSHJYVzlTb2FoLzJaTmt3dkxsYXdlK3AxQkRUSUpaby9UaUROWTR4?=
 =?utf-8?B?WEw4ODhCUWJrVWprbHRCYUJrVlVPT09uQ3RkcERkRk1tTG9NbERxYTk4WlNL?=
 =?utf-8?B?ZlpjT2NreW1sMjF1V3NRenExMUFvUUVScW1zVGRHaExMWTE5R2VLSjJrWkc4?=
 =?utf-8?B?M3YxTUdOQjJibjErajZVK3gzS25laHRQNjFPRDh2NEV6WGJEcE1nSTd5RHRt?=
 =?utf-8?B?VHNwVlc3VjkvMjZ1TUtsZnV1YlBYSEJYYXlFdTNacHZ4YUM2SG9uV01DRTlp?=
 =?utf-8?B?Y2hvWmkrUUVkYm41Qm1kcmhOZVBaWXoxQmxnckV2ay9UOEwxdDV2VCtmKzA0?=
 =?utf-8?B?anpTK3N5L0kreWxxUTJRZUVINFBSRHhaYnJLUzZQL0hEOEgyWHh2Um0yVjZG?=
 =?utf-8?B?Z2VXczhjaEJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9OcVA3QUw3bm0rNzNmY0dWN2ZONXVyRGt3SWxUdkpmYmQwZnpYWEtDa1lw?=
 =?utf-8?B?M29iUzBkR295ZlBQbDVLTzhPcGN5N2RxWlpTeDh3S215YldQd3kxK3RkZVUv?=
 =?utf-8?B?emF5bWtzRVpYL1Vody8rMnRmS04yeDFEa0dLQ1pSZlJKZzNZc1Z4TmQ3OEts?=
 =?utf-8?B?MDR1R0RyWjlCWEhVRExlUUNPQlNtWWFFRUptZ0p6Q3gzU1RJR0ZGbFhMUlpO?=
 =?utf-8?B?bTVycmZTS2Nkamo5K1NkandUTm9HeXczaGdiaWs1SWFKRm9FMjYvNVZRM2lq?=
 =?utf-8?B?dGdVVmhmMFRaVjM5VnAzTmw3QkV1SlVyWmlGZWZ0NTBYMldGUFNVS2ZFYVZp?=
 =?utf-8?B?RlM2UTd3NUk5bG9oZU9FNGdIRmxYSkxDZm54b0J5cnVnRm9yVHhQOU1hZ3M0?=
 =?utf-8?B?ampFNDBzWEwvbFplaDBkRDk2cnZaajhVbTRza0I3cUlSOEFubXorZjUyV3F3?=
 =?utf-8?B?RW9ZNXZmVTFwd1ZiaVcvQUlOcDdGNytCV0VRMWNERW1wUGZtT3A3WTlWSDYx?=
 =?utf-8?B?ODQwRXRycUxZVXB3RFltL2JYS3BmWDJ6UWxlNjF4R3JvcFN6TDJ2dGN3eHdD?=
 =?utf-8?B?WWU5ZWJ4YXZCSGlBQXhGMFQ1dlZoSXU2NXFaeGJuWkJJUnBjVTVTc0hFT2NW?=
 =?utf-8?B?WWVNenFnSHNwY2hzbmYvT2hROGJpbVhCTVJERUlUQkRHaVpWSUgxSU1YRGx3?=
 =?utf-8?B?Vzg0TndGQWcwYURudUZhYTBLM3NTREplRXNWZGxVd0lmSWxOTHlIRUFqNU1p?=
 =?utf-8?B?V1NtWDdpOEVzWGNoMTBGL3RISWYyS1pDbEZTbzl2R0pzekw1V0xuSHR0VStJ?=
 =?utf-8?B?ZTBMK0dMeEJrZWZGSUZOYmZMWVZPOEdhSTkwSXREb0Q1L2tmd3IyRVFTM0V4?=
 =?utf-8?B?S1loSTFKdThMWGtmK3NTTXNsQnJsRTIyMzl4TlpGVVRMWGlueEQyWWNzWVAy?=
 =?utf-8?B?TW5YQ1JOSjVIV1Z5K1JQZDZtTVVaNHhLL1NNS0JndFhZb1ZiWFdVdXBTK1Ju?=
 =?utf-8?B?eTRQZDNKNGlKY0VoVGFrdjFGMVFtaGpUTi9kTlNDNVY0TEhBU3lIL2o4SHFw?=
 =?utf-8?B?dWgyTlB4ODRtVlVVcDRuUFVVbHN5YUtRMC9iV21zelRYSFRhQTU2RFBGS1Jx?=
 =?utf-8?B?aDc4SlR3Y1d0ZUFTdHUzM01KcjJUeEY4dGVKN3FOdHJ5WHNsd1BEZGFGbDZC?=
 =?utf-8?B?STlEVDFSUFRkUjd2aEZuZG5pY0VnbnZWM1NkcXBpV2F4TUt3OVMwaEpwWGpz?=
 =?utf-8?B?aFptOGZuVDdBN2hxaFYwak5rTlJydWlGR21aV1FwTXZ5TDVZdDJvWnB4NEJW?=
 =?utf-8?B?Mld4Y2pPakhoSjRQZUpCYmRFSTJnZUx3Y0g3WUoxYlphYmtteWh2Tmg1c1pr?=
 =?utf-8?B?UkUxSERGRzVKOTEwQ3E0d2ZPeGVPMnN4RS9jKzBQZjNZYjh5TG1QbXl6OUVR?=
 =?utf-8?B?UDBDQWlTRjA1aC9yc2IzTTlUcUpYeFI4Z1l6Y2dqSGY3ZGcxamp5clowZjFv?=
 =?utf-8?B?TzByd3Uza3hieG93elJVUHc4UnpGM0M2bzBFZlBMaDFoNlZTL01qTjBJRllY?=
 =?utf-8?B?UnVYdTRRRnhPVHUwZEVmT2dhRHNSVm1kTzlGM0lVYU8wK0FjV2RoVUQzanFt?=
 =?utf-8?B?NUtBRzB5OG1LdVhkREVNUEdBSVdLVVNNcVlZemt5ZWhvUE1wSGliVzFNRHF5?=
 =?utf-8?B?RTYwYVZES2hGZWtLWFJjSWJmZjVKRWRKV05ycDFyWUxFUUhuWlg3NTdhN3dx?=
 =?utf-8?B?UCtpbkRNR3J2RGRDVFZZZmxMQlIwNUVYQU4vWE9mejJ5MmwyaDFZaUJoTmNm?=
 =?utf-8?B?enZoVlV6ekJMTXBXR1R1NDNxN1JKQ012LzYwT2pRRzZpL1hRajBaUlF1YVZq?=
 =?utf-8?B?Q2FmVmZpVDBZNUNGMUhaUVNqOXA2YkRtMFU1NFBZY29wZTNEQU9pWk5kQnpJ?=
 =?utf-8?B?WkpJNHRtZG1Fcm01Y1gwVFhHOFo4aHBRWTN0K1M3dll2eHpQS2VWSGRPYW5T?=
 =?utf-8?B?bGlQZ09pWExrOWtHcnVEaDAyTnZ3U0RWaUpIeE9ZT0M2OTNRNXUvbWphNysx?=
 =?utf-8?B?L2wwQXgrbks4Wi9rRzZZVnlwWTNMYThDMW84MTE5RE1pbGFSN2thOHc5M09l?=
 =?utf-8?B?WW1XcDFvR2xWT1FLZjJicGFFZGFGcXdHRkt1YVJLcnY4RHFjdlpZZkVET0Yz?=
 =?utf-8?Q?ymS6vLuA807C/ZXMp5a8uDPb2jQR0naG/KEhomoDN7P3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38790c10-3994-4f4c-354c-08de1158e7e8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 10:51:08.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOuXsbdoPLp20xUdD/Vac45YgWz+qhROKXXzyiYEKEPiOfj5NcNdH6Sw/713WBZbdddsEJOHl9TSNNqg/6xx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917

This condition was uselessly convoluted.

Reported-by: Edwin Peer <epeer@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/F3853912-2C1C-4F9B-89B0-3168689F35B3@nvidia.com/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/bitfield.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 25579b4c328f..136de7289162 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -203,7 +203,7 @@ impl $name {
     ) => {
         bitfield!(
             @leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(if f != 0 { true } else { false }) }
+            { |f| <$into_type>::from(f != 0) }
             bool $into_type => $into_type $(, $comment)?;
         );
     };

-- 
2.51.0


