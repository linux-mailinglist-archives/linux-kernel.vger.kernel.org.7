Return-Path: <linux-kernel+bounces-808557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D66B5017B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955203669AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9225B30E;
	Tue,  9 Sep 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Rvr7R2bQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E851459F6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431842; cv=fail; b=WSvL29fKN66j2nAn6J/bTdPOK5uqEfma7UpHOyXt3Pux5CC28Ib02oMAieCGnaXiaVwIP6ebbI+eA4qO+6p9QRhd+OwRtYGhOD2C4atHJNljEy1ofKDBiBBVXZVU2X0Z8f44r1th8RDZRRKKPQ+XnaT3FcSzMMIl90+NDKQqW2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431842; c=relaxed/simple;
	bh=En2iaIurj6B8DTteFO2JwpqtvISmOJDeOutAqcCscf8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hrw92WAAjG672jA7yjM1T5JnJA6lJSS4au2skhzA47Ude8iP/v/wziwhG1l14//A6RdOUdIecjzae/U9dqZ+l1iyBHr2K8Rqb5XR8AMnoaS+436LunKWFdjKVvl13cImwiEYxe3r/WneVnUwLL9eZMU6UAZSK0uMc5Rtf4ciYOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Rvr7R2bQ; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY6SD+87w2gr40Y6+Qh+XHTvsJvSAACotOrQFzEiqgyGkW9z3r203ePduaJTQye+dhRO812nVYY4PkBwf0DhPdDuv2F0BphVcg/w/P9g1eQPr/5Ngt33oChhY1TRB1MwF3c3bcJ6mlgGhrpzVFngt9Bqn6zdRH7TQ2D8ZWdLdPLiyTMovYb9Cge+5YJ81NSNMBQG0rUbjMgejcxK+JbcaCEHqVySzB0GSrK78tgyU2oatm8tcko5c7tKSD8ju8c8S04BbJvkeDB3zO6SJy5FCXOBFMmOZUeNhOv8/kyqoxwm62BuRpEafkiy5+T1pkVrzdoBFtxR+vZLQ0AJu/lRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L74ioPCxm46RlIOI/6RbcTXCKETGDywnNjSlx86t9k=;
 b=BGhbHYCJmpCpPCMtSLd9EvYsWBfnFExcbgN5Xp8VAwEKHXxK7cC+1uUaIwLERGphtRDvR/5+KgDyNjHd7d5BQvcG8VGwZdF9pL0sdmDt2fOkWpEtQWkV4dg5IuAvhg6uY8qzzn7dK2Hc4gJhwLB/zhHxo4CiOamXNtdkODj7TG3RIKRbY0rsE7dBVq/qb9KkeTkXjYR/VmKdaRIkO4oDtsZtmpwAr8iR6nuUcnVJPq6PE/4baU8JtFfu01JCMIbdIlkEAlDtk8Dn4xgTlm33M1L/eHvTNcE9VVT4DG7zZYnIJ06CP2KxgiKu+5Z8RPkVonL3hVrU6KbtYBgtZkH86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L74ioPCxm46RlIOI/6RbcTXCKETGDywnNjSlx86t9k=;
 b=Rvr7R2bQq8xaej+Oy1s2XgsVt+MGAHDL12Z/reYsuh6kudvYOsEhamQmaoxX2bKpCjGLv8fgUP6xI9t9mThiIXx2a8ltCUpJOQUz3MdlWrpBtBfEVHqhq/XaCwUPJogqIfvVPUjmsdjobyV+gQ1hp1Vv43UEzUq2TSCu/An/hPLUImp4ibNim37nGkZQplPphS+E4sRlecu77QduwEyEUlFhP9P8/+KFxx8LJEZbs0t2iwQOhI0+1hBMFObriuuu/Yy7c6f85RYpcWcKZe/dVVeCuIc54VZCN+zHHfUVxB6eAyit2V3QpexVxmpfpbRxWheE5nOhtVY6+qb/7MLVxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB3465.namprd03.prod.outlook.com (2603:10b6:5:ae::19) by
 CO6PR03MB6211.namprd03.prod.outlook.com (2603:10b6:303:13b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 15:30:38 +0000
Received: from DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30]) by DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 15:30:37 +0000
Message-ID: <91cd7ccb-e821-48de-8d52-f8889af80a08@altera.com>
Date: Tue, 9 Sep 2025 08:30:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change Altera socfpga-ecc-manager.yaml
 maintainer
To: niravkumarlaxmidas.rabara@altera.com, linux-kernel@vger.kernel.org
References: <20250909144620.579196-1-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250909144620.579196-1-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To DM6PR03MB3465.namprd03.prod.outlook.com
 (2603:10b6:5:ae::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB3465:EE_|CO6PR03MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8444f8-5847-4209-9186-08ddefb5d3a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTZjNHNIZEIwVkhWdE41TW1NbDVHejEvTFZ4b1ZNbUhvNVk0L3RNNzBGTWVL?=
 =?utf-8?B?UnE2dFBOK0JRNlZNUlowcmMrVi9ZTTV1V3dBOTNCMm1NMXNVc2liVDljRjJt?=
 =?utf-8?B?ZU82eC91M1UwMjhTYitmZ3oxQnpJRjNMZ3luMytCT0NUZkUwdjRQL0xVNTl5?=
 =?utf-8?B?Rk9YTUlxTnFyZnZVUndwRU5GZGI3UkRxTWszQXV1S1UraWZGZVVJNG11czRj?=
 =?utf-8?B?dnU5dTM1UGIxQi9RekVVK2lmZjVRcnAvbTJHaGt0eldoa21DSG9MNnlFMG4y?=
 =?utf-8?B?ekhQUUZUZkJ1WEJMNndQdFFZbWVqbmhFZkdlZU9aMFpLb3hvSU44bzU0VnFx?=
 =?utf-8?B?Rk5FU0EzcG1UWVpnUC9FM2I4UHc2UVRIWXJMUW9FTkdBUk9iblZwRlR1VTU4?=
 =?utf-8?B?ZmoxbUUrZ1I2VEFaTFZDZXJ0WTUwWGJhTlRBcW15aFEwWm1IaDdPTklveSth?=
 =?utf-8?B?OS94SkhSaGlsbHhwUDk3c3daTFFoRW1RWTF6ZWFZRjFZaVhvblo1SXMwV1p4?=
 =?utf-8?B?VlBNWGdTN1NOL0pxaFpKdVdjNjNQUTdhWVlnb00vTnArazJlWFNxM091cWVv?=
 =?utf-8?B?dlkzYXRkQk9udnZsbDk3QkFmOTJBRWNEZGpJVmVqVHhFTUZ6LzlHSFU5UHdM?=
 =?utf-8?B?S0VmVng2bjlLZDhZR0JXWThsYkR4eEQ5Z3BsNXNkZG5jRFhIa1RiQS9DV3pp?=
 =?utf-8?B?TjdxR3FNMEZzMWZ4T3EzNlo3UnFwSXMwSEwxZmZac09vdThDdzEreWQ4MkJV?=
 =?utf-8?B?WkdzZi9VdC9zYTNpUGVBQnFXS3Y0bWhmWkxVK2tpWjVMOUNpcThlK0ZyT2k4?=
 =?utf-8?B?akdXOU56cVR5bXcvSm1MQ0dtOEQ1K2dWbFdlaFNRNW1MTVhwOEthb2dpREh2?=
 =?utf-8?B?UTR3WERuWTM3U2xuVzdsSG1INDFYWFAxaUxFa0NsYk5nMGxkS1JYTUJNbkcw?=
 =?utf-8?B?T1E5aDRZUThiTEg4UGRiVzVZcmxCYnM2ZTlGYlR3QVhFTXYwK1Rwd09RUXJJ?=
 =?utf-8?B?b0hXanpERGQrTkNkc2NtRVhqdXE2K3dmcGlVS01XWmJNREM3Mkd2eXRNOHRQ?=
 =?utf-8?B?STVsaUI0a2ZkQkcvQWVGK3hvUDA0TU1KSzJ3YzFnTU1yRmdGVkdGNXVub2VD?=
 =?utf-8?B?VG1UNnFLSUNJVm1HVlRGVlVyQ2V2NzhwME1IY2NxdWxSUThENTF3NlhYbEFP?=
 =?utf-8?B?OU5keXpMbkp1TXhuYWhZYURaQ3dLUk5xS1lPUWFZTlJ1TXpuT0tKaUZmOGNw?=
 =?utf-8?B?OTZ4OTAwaWZSU2c1MFgvRGFVUmdZM0tUakJTVmtzaGFlR2RCS3hDWXJ4aDQ5?=
 =?utf-8?B?WC82R0xtSnRpaWo1QTJsMS9iZ1pKU2hUTGpqdVVKK0RJeWRQWWVoYng1RXpU?=
 =?utf-8?B?MzNuQnNId2ttTUpheG4ySm5yK1NXRVZuSVY1VnVoTmZzSW5QMDBOQXFPQUN5?=
 =?utf-8?B?ZXNqSm9kWXUzNUwzeVFSRWdteXVKQXVFWTgzVXVQREtCc3VaUzJweGdTYkp3?=
 =?utf-8?B?UjN5R3hhc0hSQldxTks0aEoyVXF2bWU4SjFWY2tuSG5pK3FyTUdMcEtJVWtT?=
 =?utf-8?B?eWY0WnN2UzVOSWxjcU1rVkhSaEh1dUwyTllEZDllL3U5ZEZuUXVydHpUNE8x?=
 =?utf-8?B?cWxidVZoUTFQbFFrUzUwRTEzSTlDR2pRa0hBL0dkK2NCSTZHT3pUeWRKcTEx?=
 =?utf-8?B?ZkxSNnJyQkJ2VlJCc25pZUpOSWh1dE9OTHN6OTdwUXJycitRR1JRTk56cHZ5?=
 =?utf-8?B?UzViUHlGMmwvdTRtSER3d1NVVGhiL2FIMHBvUXg4dHJmOFVudmpnU3JhZU5x?=
 =?utf-8?B?S2JCUnBvQXZRVWhqaHJ4VUowVHBSamxJTm8wdVN2enpLVTRXTnozRnp6c2xj?=
 =?utf-8?B?NmZxMmdqSU5qT0xvTjUyQmNhdGMydUZGc0dXVXhaZGp0cVIwNEFSTDZNcHdO?=
 =?utf-8?Q?ztqxNA3V+Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3465.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBQNy9LWGRuZWt5dzZLWm1CakZZcXhKK2dkY1k3RkNpZ3d6WVdKTER1REJK?=
 =?utf-8?B?Q0tLU3RiaUY2MGFXVUo5Y2N6cUhqT0pQTCtQRzZBb25VazVBZ01sd2F3SnBM?=
 =?utf-8?B?RldoNStPejR1NC9MNzRkNjk3WUdPaURKWWQxMEF5VGVWSWZibFc1ZEovU1Fn?=
 =?utf-8?B?UFNOaUhaUll4NkgwMTMzYmVTRFQrZHVNQUlEY1EwZFdSVFFIcHlWT05tcWti?=
 =?utf-8?B?dHdKS05INFpYN3BZNUF5Ui9PUExpbFAxckpIeUh0ZkdRZ0sxeGs1cXVmSXYw?=
 =?utf-8?B?ekp2dGd6TXFxT2kzRVVuNDY4Vk8vRENWYWRKSnRyTkR2VVkxOHJlckpzb2tI?=
 =?utf-8?B?akhBdEwrLy91WG5EUGcrR1hrVnYwcE1rTW9XSFF0NnNoa1BUclV4ODhRZmNS?=
 =?utf-8?B?WDJhTzRuVE9pdE0vMk4xanJ1WnZRQzZxMFB4RWJKUTdPc2NMSXo4cmU1d3Y1?=
 =?utf-8?B?cUJFTDQzU04wN1FaNWpHSXI5NndLUURzM0ovWnRGYlNuRVdXK1ZERXpmSElh?=
 =?utf-8?B?T3VHUWZtQm1scU11c25na2Q3SlZ4anY3eTUvZVVGOU4vckpwVllVMFlMWm9U?=
 =?utf-8?B?b2d2bTNLT1VGaXkzN0R3K0hqS0RLV2RScjNYZCtiTUVLcTc4c3NRajVDR3p6?=
 =?utf-8?B?REM4RkVYazh1SHpYeHhTb1BzZTArT3I2aEk3RlJBSUdSaFV0YlhkalJ3VkVS?=
 =?utf-8?B?UjlwdTdyaFZmWmkxOFZXVkVCT1BMalpqSmdNT3N4bjl0YWw0OE9QY3pUb1U5?=
 =?utf-8?B?K3RVMkVMUjc4M3c4cG1FelBLUUoxeElYL2hoZmY1Qjg5WTVpaGd3aEdpMjdX?=
 =?utf-8?B?MkdRcUVvM2xSSjFLR1JwOVUxajBDK3JHMUY4dS9UU0E2akw0VHNVMlJUOHM0?=
 =?utf-8?B?TjNKSzJmS2NyeHViYjdoaU0yT0VHUzM1UitCZDMrYlVCYlg1SFdJZEtmc1N4?=
 =?utf-8?B?UUNOM1dtUlFKR3I3cGV5b1RnUzYrUkhiTHNPMGJqNTZYN0lET0JqOFA5ZkVL?=
 =?utf-8?B?VDk1M3lMcUpSeVdXQm9BL29iV0FIYkZWcEE0c1R3bzV6SEZ5Ym80ZlhiMjN3?=
 =?utf-8?B?QXBSOHQ5ZDlHeFFZSzV2R1ZlcmNqNWJjbHZMQUg2Rmg1Y2l5RG11TjBGUEVm?=
 =?utf-8?B?aW5IalhYTjdSWWhVNlhQTGJpOVpDakp4Ti9Bdm1ZOEZsTE9FNUpQa1N1eVlL?=
 =?utf-8?B?ZG15RmpCZnA2cGRxa0k0N29VWStFSmNRaGdkWkxBdDBETENnemxianA2anp3?=
 =?utf-8?B?U2lWS3RKdVgwckZSR2tuU2I1SzZ5Sm10RXBDNnc2cTBzQTZMVUZDQmVPbmI1?=
 =?utf-8?B?Y25COUV5WEUxaGVIeFc1dVgxQ1ZSbjlEUVplREZ5YVUzVXV2TzBLUk4wb0tD?=
 =?utf-8?B?YUx0ZlVjODNpSjF2Ly9GY25GZlphYjhnTDB3SEl3TnRaTFdndDg0Vk9Felhn?=
 =?utf-8?B?bUxvUlMzZnE0RHVWTU9DM3lKSFVNa29SQmZTTEUzcDJ6R3dUbGVWWHJTTC81?=
 =?utf-8?B?dEE3UHFidTRFNjFTdnZCeWlVcEloN3lhdHcyNCtldWlPdjFXS01SUlE5RVNV?=
 =?utf-8?B?MVNuTEx5MUJRSmIvSEJDTzVMK2NwRFR0UVFvRE5PTGFPdHVZbkpHTThhT3hu?=
 =?utf-8?B?NjBocVlYSnB6UDdCSmZsclhLMlI5NTRWOHNFTis1Y1phbEdJbXk5SmE1akpi?=
 =?utf-8?B?ZmFPZEpXMmI0RjNZQmFWa3lxeFZPZ0RiTTcxWG5CNDBYQUZxcDZCVC85NWZH?=
 =?utf-8?B?RU9hT2JvbThCVUw3cHdGcUJNQVZtYVF3ZkJBa0lrVkJRSDJvUWdVc1AxNWF3?=
 =?utf-8?B?bE4wbEZqLzM2SkU1dHZRTnE4VmZKUlpZaHNYYS9aK2dLbFVKMTdFSk9yVk5O?=
 =?utf-8?B?bVdCMVk4NVRNMGxJNUNBZU5xbi9HOC82MXRQd0ZOY3VncGpJdjhseVA1Mnh5?=
 =?utf-8?B?enFCZEwzNTlvZlhlNklzUi9aWTk5Q1hUVVJkRDYrZG9hOTU4aGxYemNKOGta?=
 =?utf-8?B?bnJJMzIvVjJOKytRdmdBWGJ0WGlPazlESHk5RFFvV1lQS3FDSHZrTDlkSVNY?=
 =?utf-8?B?dTBtWEs0NzJpbmFvdTgrNmxiRW1rbks4TTF2ZFh0eUZKR1BLM2xxWXU0SkFE?=
 =?utf-8?B?R1N3RjJXN1lsRW1IcXJjVjhJdlpBTldaa1FaL3JKTnhFdStGdTlTWDRuZStR?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8444f8-5847-4209-9186-08ddefb5d3a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3465.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:30:37.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5bzR1mW2YDXs4GEvhBlRKbzwuIdI0prF5Y69XBSgivvpjg5vRLBEq58zIakR3axSdzVp2YNRHZ4jIyJouLrBKzcMX6B75ri3EAloDJtvGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6211



On 9/9/25 7:46 AM, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>
> Update Altera socfpga-ecc-manager dt bindings maintainer from
> <matthew.gerlach@altera.com> to <niravkumarlaxmidas.rabara@altera.com>
> as Matthew Gerlack is moving out of Altera.
>
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..bd97db99e75e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3362,7 +3362,7 @@ S:	Maintained
>   F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>   
>   ARM/SOCFPGA EDAC BINDINGS
> -M:	Matthew Gerlach <matthew.gerlach@altera.com>
> +M:	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
>   


