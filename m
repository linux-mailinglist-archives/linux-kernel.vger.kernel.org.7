Return-Path: <linux-kernel+bounces-894707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E40ECC4BAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAD4F5147
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12502DA751;
	Tue, 11 Nov 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DKx0IIxt"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF92D878C;
	Tue, 11 Nov 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842080; cv=fail; b=d1k1fTrJ8/+W8xsPQ+LY4LeKnDSTlRbYpcPMtGYwBqkOjX182QUR5sKOS3VV6UzopftnVz6dpoujzaWnHgbXKj2yX06C0CztKy5hQeoVgwFtAh7ijK5+0KnnZHUFpeQuuRclivveqlNBLpXBn8FGXN5aH2TZkPWAQUZ2QEsUDQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842080; c=relaxed/simple;
	bh=k/TjjbL5jem4FUbUlHLlTVyeB5QpN+wochC1vtP1de8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0Ur6/Ch8OQ68CA+W9P8R+oOUXHfiRdK5K9ot2IHUwO9SKg7OpKiacPWt0wImb1sQOdQM3uFFJ6R5vBkvDtcEwAEB90cJfOaxQbytFRKBck/Q3C9HMZ8sFbbotrO6z8PvdtW4bTMKyuyMnCT6Gj9bGVP3IjzPJx3SVbVLQmUWl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DKx0IIxt; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZY62dlieHxzwrbrZJcKnvmFObI2l5oUccj9jj7SVPubNEC+YiPmsc5wVT+fzRDFK/yRm7KMUqU3/YGSXO7aUATotzIpKF5N1hP5efRw7Zft3RXEtbOXGfsDTX5nP3wvOwibht73XBrnQN78r5JqhLamv7lcnopWqt5djuIU6+9ZpO6BNmGNOA+ytGiBqd7y8INt+19beMaZAvXOM04BnET7b17P9UbXy8dQ1t27ZfHysRsZTRteriojWqGfIZHC8mXuOBjP56i3RPY1FyYGtqZPOqDfZH1J+mwnabAvxYygzf8o8xk3A9KoFveaySEwkmmEDNxQ4eoSsZ7udDvZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KNzzFC0TvRcz8JLcx5BtRh2tStRWwyn2lSvklpovrw=;
 b=vmGDjD9GgHD40qAFDchRHYVEh9H+9tqsA1F5scDJX5nj6g4/n9Pmz/5Gtcmh9ka+6GV8fSGN5L9VJ69pgMqZNvn4c+G8COJRYXi0giVCnX6PYLe3ShSt0+6waLmWjJMJ5u2JBtHe1g0nGwZ6lVi1uRrgtkVD7RC3li/DD0PKKQUllVvexFh/PDjlmecBlIZ15qZXU3erPRB9zWgktioAqBZuT34lqLhQJFv81DktHZJ8pi29ddpeRO21SZrf4AL5/yxcew5e0Lr+Fyb2cgAeHuQ/x7A2+QtBUFVOEGPWva/kYEsKag7JpvvTEkhag2s6PGLV+pV81VvLSOa15rwxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KNzzFC0TvRcz8JLcx5BtRh2tStRWwyn2lSvklpovrw=;
 b=DKx0IIxtVA9zAfWzn+B23cb3ozO4oxoeqdh8SgwV/lngi9jV3hV7b77i3UBHvYMW/dwBRKX0uV8kVoDt3G0RbopCQ6L/FE7tRGyGZ2do/c4xGkCQJeo3QnkelAcmxOgGTPB2MOiSqOuIlGwXayAmi3NmSXSjMcnE1IT9Oo4o0bN9MyNnrFfKXqM+OVd8wVX2uHMIbNifyPhAt0uJxkxblDXQ4/jasSzWuWp+K02QzCncGpxb5R85hLowFSRyUwjcfXTA9msyefGiWlIa/9TJCFx7iF24o3WtdvLz9JWyXNERtHZ7PGZGUwU4q+xaT3X1wImsohZx55iFtP6bvc2WCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 06:21:17 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:21:17 +0000
From: adrianhoyin.ng@altera.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	Thinh.Nguyen@synopsys.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 4/4] usb: dwc3: add support for configurable DMA addressable bits
Date: Tue, 11 Nov 2025 14:18:48 +0800
Message-ID: <c69076470c19fc03d92fc04cdb10960873bc2bc0.1762839776.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762839776.git.adrianhoyin.ng@altera.com>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdbb286-5a62-4754-90dc-08de20ea85b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjZlOEl5UVVkRXAydEhFQ2pReDdrREhlNmdvZ2Qxb3ZlM1JaMEhuSFB5TWor?=
 =?utf-8?B?eXNwTmUvUCt3ZGlYOGV5aSt6SE42K1hScW1JRmlQb0NEZkQyQkxCbW5WWHJi?=
 =?utf-8?B?bWFrNkVVSnFHYm1jczYrSVdiSkNoK21jeWNRNkQwcktVU3FVL09uT1NrR0NO?=
 =?utf-8?B?QVVXcnRlNWZwcmhhbTlLM1FTSVVDM0p0bXFHclNYaEpVbzBlODliWnRYMC9Q?=
 =?utf-8?B?V2ZyWVYvU3BsYm8zSnZmWmJIVmVodW14U2h6dXA4UFhLVmx6T2NGbCt1bkxU?=
 =?utf-8?B?UVA3ckRWYVQ1VW5YU3lzaG1PUXFXNDVoMUdYSk1Sa0d5NHZteG9neFlIZktS?=
 =?utf-8?B?SWIzQ2gxM1JwcXFOOFZDSFNKTXRUdE5pNHFYKzE5dkF4UnJPbHNrZ2NzMEN4?=
 =?utf-8?B?aGRZV3Q2akVuZXhEdTN6amtocDhZTHowM3V6MlFNZkRxQ2xSSGQvaFdGbWlx?=
 =?utf-8?B?L3h3dlJjUWRmbThlTmhTV1FYdGFoMnYyVTNhVGZSTlN6WkVrSTVrcnQ5SUs2?=
 =?utf-8?B?My93UDdzQUVQd3cxcS96YUh0aUVYdlhyR0c4RlRDQ2l4NUtKUlVaRkFEdndu?=
 =?utf-8?B?SzBramRHVTd4RDgyQlR4TFVYLzYvUS8vcjg5UzZCMTdSNGg1dmxnQ1crVlRz?=
 =?utf-8?B?ZVVSYUttNzVaTlVsM1o2dXBLVy9vd1NUbW1iekFYZURrVy94MXRxTnA4a0Z4?=
 =?utf-8?B?TjZyTGI1b25hU1lTSE5Pb1YxOEZaKzUxWUczY1lMbVZCWHEwa09WQStvQnJJ?=
 =?utf-8?B?NDdyS3gwMXZoQ3hkd3dGMFI1a1YzWVZNK2tGUmdhMFlkakp0c1BwMHUvaTBu?=
 =?utf-8?B?M1lqck9mRFNKY1lPeStSc0JXbkFNbzYza2FpUVprdlltdGN1OWEwdHlJek1w?=
 =?utf-8?B?R1dlTmR6ZnFnMFZ6L1F1WWJ4YWRGMlI2L2p0YjRCblJJOVVDQm9nYjNacXA5?=
 =?utf-8?B?WVcyWnNvYTBhL09DeDlRaVNLVVM2bCtqN2ZWTGJKV0Y4MEFNNGhoMGIvVjN1?=
 =?utf-8?B?MDNCRVZlZkN6R285VVl2SHFlNC8ydTVjWWJ1S1A2NC9hZE15SjdBNTZ6dEIr?=
 =?utf-8?B?ZURmVGJFNTRHeGt4TkRDY3RwT3ZaTGZIOHVkcUk0TDI2Q040dHdsaHhUTXdh?=
 =?utf-8?B?bHByakdiMkRSd01ENkV2YlkrdDAvM2RlVHI1ZlNtZFIzQUlEVldFbjA0UzNU?=
 =?utf-8?B?VUZlVngwT3FFazZwellvVXBuNlQ5RFpGdStWZlZTMXB4MnlhOGtqTUZyM1lm?=
 =?utf-8?B?cGdSNTdGNmtJQTlSL3dQRWYzWEx6QlZ0QjJpS1B2SmMwUFFTcyt5dXlnaDR1?=
 =?utf-8?B?dG1UbnZMRXFhQWdxNnBSYUNSSk1YMXhON0hHK0dzRHQ3OGlpRXBUdWkydE5t?=
 =?utf-8?B?UVFYSGdCSEpBL1p5OEJlazBsUGY4T2hNQzZ2M3dJekIrbDVkeUxiSHdUODcw?=
 =?utf-8?B?T1pITUxraEtHZFpJbGw0TUlWRnhVRHo3dFNTam9CRjI2RS9kb2JRS3dvS0JT?=
 =?utf-8?B?MnQ3d2ZaYUJoS0JiaTY5Y3pkbFA2bUdTcUtLUmVtYUoyYmxzVzljTWx2M3BL?=
 =?utf-8?B?eEY5VW1DMHZrOGtzVk9SVnJYdXQ2WTFOYldUTjR4dEllRENNTlExaEpEYUVh?=
 =?utf-8?B?S3FGVmpSOXc5KzJIdDhFakIybGpTbWZOTEg4ZEZIUmpNZjBzWHl1UFBIOEdn?=
 =?utf-8?B?U1gyVmI2b2hJbXRSQVoyK052WGdZbmpPb3JIR0UwTlZGRGsvdFY3ZGczaWNJ?=
 =?utf-8?B?d1JzR2JQV2VBdFNoelBITTlPT05iaVpuemlwZVpnRVh2NUFGUGhULzZsSkpL?=
 =?utf-8?B?eXM3NVFHYXR3ODVXdzM5UkFYZlo4bVJFT0Z1L1RWQ05tN3RFdTViSERqZm9I?=
 =?utf-8?B?VmswRmtFUjEzenJ6OGwwZVNpbFZZWUpuL1RzN3UrU0w3a3Fmd0pmQjVrdWlB?=
 =?utf-8?Q?Sk2Yf15GyMFACu8Dc3a2ek9dEmBL6ap7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TitKWUdGT0JxNkN1bEJIT0pLT045VmtFUmVUWkFackdsQndrRU9yY3hVQ1dk?=
 =?utf-8?B?VXBVZ1ZHbmtoZGthYzA4ZG1ZdW9yalduRkxTZWxOblRkTFdjVnZFZGtMVzZC?=
 =?utf-8?B?T3lpM3FuM0p5Zm1XNTErNitrOGVOcmNSSGhzVFhGYXJnK0Y4OUs3R21BOExI?=
 =?utf-8?B?VE9Nb054NFVORHJyZFJOMWUxTzRQRDdoV3hMSU9qL3Q1TW9zMkZyeW81c1Zi?=
 =?utf-8?B?MEtnVXNySmNlSWFuRE00bTh4dHM4Yi9wT0ZXRWNVYThtSGMrUFIva2pxL0Ft?=
 =?utf-8?B?RzczU0M5b0RtUy94cTZnSFE2N040THkwZ2hUZForY2lpS3N4SnViaWFyL3U5?=
 =?utf-8?B?cFNBSTRZK0I4RjdZSVVFTXB0bUVPc2FNWEEvdXdpenplWWp6OXR6M0M3eWU5?=
 =?utf-8?B?RGNISWVKancwd1FXTnNPRUhyNU1OTmp2eDJtdE1pbWR4NFFSUzBQbTQxVWxO?=
 =?utf-8?B?bmU5dTkrUkVFRWgwa1N1bS8xcjY1b1ZFSnNCb3NTamdJWW10WEk0RzBUYjVP?=
 =?utf-8?B?eHRqeTVUeDF4b2lkSGZEL0hQbnBXYmYrbFE4UnZPWEVMdEJaYUFGaG1jUjdU?=
 =?utf-8?B?VSsrUFBqNS9aaklGaTZ3N3hYR0MyS2pNb0luRitHeWZrWXJXZ3NjaWsyKzhK?=
 =?utf-8?B?aUgvaEtHLzNyN1BvRmhtbmNqWHdxWDdNclpwY0pzcTBwRnlzU2VlbDE5RTBi?=
 =?utf-8?B?QkdoZEZnSVdqcSs0dzg2YXI1V1AyNDJhQUJpWGZicnJRUmNTVDROSFFsZDFr?=
 =?utf-8?B?d0hqN0Z0MzBFS0pwWFE0T3NiU1Q4NTg2WVZraFlEMGZJT1hYTTEvM28vSGhl?=
 =?utf-8?B?c0xlSDdacXFDUGVzSnNLcjlPS3h5a0I4elpwZUxidDlyOTVXSGkyc2JGWHZa?=
 =?utf-8?B?SnNaMnBmMXNpU1d5YzhWWkNoLzJzTUNHQkpxZUdsRmZpUHVWSFFNQ0wxbVR1?=
 =?utf-8?B?UDhMeWd0eWxhMXNmOVdQUkNiWEdTUzQ2ODBlNzk2d1JzK205UmVUL1ZnRTlD?=
 =?utf-8?B?NFhuNGs3My9BV0Z2RHdpMnI1eTR6TW1lUEJ2VUZaS003WUgvRnR6QWtuMkZv?=
 =?utf-8?B?dFdzbkxiK0RSSkx6S05JSVdvdWVuZ20zRStwZ0NacmFnZnFsQk0xTTFFWWcr?=
 =?utf-8?B?am9wenVQVkhxbnA0ZlU0bmRpMmdZUWdjclNnUzMrUENYT3ZhRU1oaDlHVmk2?=
 =?utf-8?B?N1ladUgzOU84ZUdPaURsZmltVmhYdENwZUc0ckh4ZWYwRENVUnJQUkVtRGlP?=
 =?utf-8?B?eUZYd0RXdVRqaE1Gc2c4OGRNRVN3c2VHdFhKTDZNSGJXMFRLajFwb2RISEc4?=
 =?utf-8?B?TUtyNVFaYVY4TEJoa3ZVT2sxcXRmL1MvTWdDZVRiNkNCSUFwUFhxZjlVNHVt?=
 =?utf-8?B?U25pek5kcFVRQUpONE1SYUU3ckZYVElNRjJ1bWRSQUlUNGRMZEU0OUd1SkRt?=
 =?utf-8?B?TWNlZTJMSklxa1ZtR29zZzJnbWpnbjlSM1JobnN3WWF2R2twbmRsQ0JBbFpU?=
 =?utf-8?B?R2taVUpELzRjYVRlRnZuZTZ5Q1UzZSt4b2tySDNlbkdjbkl3ZFFvR1ZwaXZj?=
 =?utf-8?B?UjRKNEtCMDBTZzlwTFcrelZnUGFIVC9sd0ZLS1dXdVdJY0FDLzFzQ09vd29w?=
 =?utf-8?B?VmFuT2FLWEdLM3liNkNxQ0svNzMrK2t5aHFpSTM4WE1OMEtDeUVFeENjKy8z?=
 =?utf-8?B?ZzMvSFFUZ1NSeTFycDhRRGMxTUx2QWVjb3pwYUo4SkJxRnEvYk5pMnNpZjk5?=
 =?utf-8?B?YnRpRUpxRTJxSnZ4UU1CTnFjaE1UaEV5VUpTUUtGZ0I4UXZYaHlpc2tUbWVu?=
 =?utf-8?B?MWo5THFjUzUrMnpHU1ZITjBQN3dCclVTaUYrMklwRkJ6SDVGT296NjRhNVhT?=
 =?utf-8?B?VkpzS3ovdVR2RUJ1R0lLQ0Mxd0MwZ2dKbkI0K0ZZZnQ4VmxvUDBaaGJMUWFS?=
 =?utf-8?B?d090K2x5QXlqWHVQeUlsTWRxWlVEK0dMMjdjSmNGUVU5YVVTb1lhRVJQd3ZY?=
 =?utf-8?B?bUVrWExqYTJvUVRPV0oramh6Sk4rRlV0L25PWE9xeVA2U3B5Q3M5SCsvNzhh?=
 =?utf-8?B?RzhPN0g0NlByVDljUjhBUWdVTU5HS2NKMkwzMlVhdUNnaVlwaGZiL2hUejI1?=
 =?utf-8?B?bzRtSTQvMUwvV3Z6VTR1RDljNnhxa3RBaENBc0cxYzg5U1ozeWFkMkMvOGNE?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdbb286-5a62-4754-90dc-08de20ea85b0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:21:17.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2BoAYLZkqw9WxxktW0btxj0/fg5iZV6ovAIqpdOxJk6UGUAeCb+WT7nZiwOfcidhZAbo+zNWcIV6mt7QVOYyGVZVOsGza10i7Pa+JH7xKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add support for configuring the DMA addressable bit width in the
Synopsys DesignWare USB3 (DWC3) core driver.

Altera Agilex5 supports only 40-bit DMA addressing. Setting an incorrect
DMA mask (such as the default 64-bit) can lead to address truncation or
translation faults when the SMMU is enabled.

This commit introduces a new field, dma_addressable_bits, in the dwc3
structure to track the platform’s supported DMA width. The default value
is set to 64 bits, but for Agilex5 platforms (altr,agilex5-dwc3), the
value is overridden to 40 bits. This field is then used when setting the
DMA mask to ensure compatibility with the system’s actual address bus
capabilities.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/usb/dwc3/core.c | 9 ++++++++-
 drivers/usb/dwc3/core.h | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ae140c356295..20e655364135 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2179,6 +2179,9 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	dwc->xhci_resources[0].flags = res->flags;
 	dwc->xhci_resources[0].name = res->name;
 
+	/* Initialize dma addressable bit to 64 bits as default */
+	dwc->dma_addressable_bits = 64;
+
 	/*
 	 * Request memory region but exclude xHCI regs,
 	 * since it will be requested by the xhci-plat driver.
@@ -2194,6 +2197,9 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
 		}
 
+		if (of_device_is_compatible(parent, "altr,agilex5-dwc3"))
+			dwc->dma_addressable_bits = 40;
+
 		of_node_put(parent);
 	}
 
@@ -2243,7 +2249,8 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 
 	if (!dwc->sysdev_is_parent &&
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		ret = dma_set_mask_and_coherent(dwc->sysdev,
+						DMA_BIT_MASK(dwc->dma_addressable_bits));
 		if (ret)
 			goto err_disable_clks;
 	}
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a5fc92c4ffa3..ddc42c88da93 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1180,6 +1180,8 @@ struct dwc3_glue_ops {
  * @wakeup_pending_funcs: Indicates whether any interface has requested for
  *			 function wakeup in bitmap format where bit position
  *			 represents interface_id.
+ * @dma_addressable_bits: set if we need to configure a different
+ *			dma-bit-mask other than 64 bits.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1414,6 +1416,7 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+	u32			dma_addressable_bits;
 };
 
 #define INCRX_BURST_MODE 0
-- 
2.49.GIT


