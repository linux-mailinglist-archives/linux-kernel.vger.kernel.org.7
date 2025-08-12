Return-Path: <linux-kernel+bounces-764804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC524B22778
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18F91B675F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E67265CA0;
	Tue, 12 Aug 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f26Zfakx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178091EDA1A;
	Tue, 12 Aug 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003138; cv=fail; b=c3jvYFJa7rioM2P41hMyil2oo1kHVZwDxUcJo8JWHw6YJklvwt/+qjiHB9ORTh/YSBNIihjr84NYSifkxZXqjzOW8wYvaQ9qCde9Y22XccJldavnek2dwtAUbUerYHq5qr+tCfC3U+7iJCAsRX3R8d1tb/+mkD8nNfVrXbfj6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003138; c=relaxed/simple;
	bh=lDHi+f+b24vkN2faYYWi9GJ4WfZ2fDEpf4xzIkRLrHE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=t98qcH79IC+la8Z0u6KgjWiia8Qp2qvXzYcPaLjrFSRQgYnE6i/33D/kp1ltDP8UsakqXcopfIYlGkQbXPn5qog2JxWmyCm6TsU4ZEZ26jmSxIbUSyzYWhgrjCFqcf9MTeFNWVujHq0nZaNzABKpGQuQ+EoF6ptz5Tc/4XF1ApI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f26Zfakx; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVFwJ6WBx0uIKiejbTWwQDqh1aFxoc3HgY51lgxRgxlkFwFbZ83TTeqo6uRq0A/JZUapT7xjpBmDOIEqsLdJDAhkXcVcygdc/0jY5I31p2DhEF8ogIXh4rxcBCqxPcqx+YWk+WzayC7vdUD/uj+wLnCh11bHq+FCYfGbyB9rjePvZGxDq/AgCSP9rdANxLQF8G5nkcDNn4gYLruOMJAViOJMKyCS/IJKDDuAmHGzDQEPDOfMpDhP0op4zAU2UMa25a2VmbV3bFN6nITiRhDJd2u4e9WPELSVHdWNgdRfn8tGOwuVfumP3yo4RVPs/8UEXUnPO1c710JD5lhQb+TF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPEyv715Eo7AN0s2C6ovOZbf+zlBrLnyxB3c1uQLYtU=;
 b=YSVAEjuL+aFP5rFcz0ASjdKKe86OFsY/JbD8EZ4sdz/eh2q2AdrNyXzIXS+Fme9Ug5htfFNg4xsT8MSw6FGBLWsj2IqAqkUG4bAQX1xPF5EQRpbMc4rkY442nDQ6wJZdF2aSAu1hePZvcj53ENxoQODRBH5MKYejGLWCms90ThZzWDqpqM0QNCQdslZgbx6NyA6EPLMe2LjiOs16wCJarVZ3SOsfj4dkK+W1k1TEo/XBHS0cA71W2alnFyk/vYgqFLFmyKRnLRWDmctfy+5YyLMY7GlwiTTzJ8raRW635OZAL8lILSBIdct+TeT97Tbf6Bj9EtVLl4gAa1l/tLCXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEyv715Eo7AN0s2C6ovOZbf+zlBrLnyxB3c1uQLYtU=;
 b=f26ZfakxIhM2aa5wLRQXTtMFxPo+nVnBzyC+hxKFlA0nh9+xpLua057Q4G3E2C9iS3mOqxBpiDqAQ52bqEQUBntXUF/oRYsZL08qJY3H2LTYHb7XEorVu8COkLbF8UJpnUKYAulvOEiVAQa3yr1G1sugKSRRKmp3nZBI0PfCTWyGySvtnG/IEqlGejtDym1cPNxrSxZ6E7YzFwmJt0unuXiWgQC4byFMrkn4Py0GyT+GibEq9GR/5+rtp/S0+xR63BwjOQIn1MC6iiIlQQbReJ4ostYd7bhHjtZcc8Y6NlwKG5dqzpKzUxtMx2ubdQ+7idKjJrxOgiBoYS94iw8kIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 12:52:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 12:52:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 21:52:03 +0900
Message-Id: <DC0GOOU90TP3.B661QBU4KZT9@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] device: rust: expand documentation for
 DeviceContext
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250722150110.23565-1-dakr@kernel.org>
 <20250722150110.23565-2-dakr@kernel.org>
In-Reply-To: <20250722150110.23565-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6400ef-35e1-4975-2907-08ddd99f0b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eERVOUM5NVJPWXBVa0RWRWNRSmV0K2FJVkJydTA5bnlROE5ERlRXNDZtMWgr?=
 =?utf-8?B?Vy9Kb0hOMnVPZFNkU1VKUnNySklvVnA4ditQZFpCajZ3TVdSc0h5aHZMWTJT?=
 =?utf-8?B?YXVSOTd3TERpbmU1bnZiYWdXTTQvNHQybVNTS0U1SDd6UEFvOVoxSWZhaXNQ?=
 =?utf-8?B?QlI3TU1oN1ZKZGUwUUpLOGJYVEh2aEROTnVLcWdFSTdBTzhMVmcvUXJERjZ0?=
 =?utf-8?B?M05PVmdrSUFkUVdycEhjdGhqTUZ6Q282WVplWkNTYys5dkdLUW9RNTVrZUJ1?=
 =?utf-8?B?L3RMNzBGbnNMbUNwZVk4NTA0UzgwMUFLK1ZwTHVsR2Z6SldIdktJQkNnUjVB?=
 =?utf-8?B?VzNhODlZTGcwa2kzNThqdU1VSzN3N0RQY2N5R0JXYUE1QlNZWEoyclRZcndR?=
 =?utf-8?B?K1JpNmVvWU5WeHBVTm9OeVJSUkw2dEhCY29WUE1mak44QmtOTStPRnBoWU5Q?=
 =?utf-8?B?UzhCTnp3TzJ0UUJhdk1aNHFKN0gyeDQydDhlelUzcFV2dHR1a0ZSbVNSRzFu?=
 =?utf-8?B?blljbTJ5NVlrbmVWT2svT011UVBOWnhTL3draGF3S1VsMHdTQ3NMdEZnNWUy?=
 =?utf-8?B?Tmw4TnVLTkVkcWNhK21hZk9xRjhqbXUwNkNNbHBaWERFb1pFVjZUUkRCQUFI?=
 =?utf-8?B?bkZsdExCMzNsdFpzV1hzZUhWeDhPR3dhT1lrVHdFaGNsZFpJaEZMRE1BcnJG?=
 =?utf-8?B?RnUrazNQYWdlOWJUSlFNYlR6Tm5kZnFSeWJxWmVSclVTbDg2UWkxRmNnRTlH?=
 =?utf-8?B?UDczRTkrZTR5bHNNY2lOVUJDVGdQMW91TlBVd3dXYTFOWW1UTktPM2xNNnRX?=
 =?utf-8?B?dFNZWjJsanJid2VkMXJ3T2hvYlYyQ3R5MkhCeENlMXh1UUhGT0paUzVtMzg4?=
 =?utf-8?B?Y0tDWjl1enhLajY2RSt4U0gwUnZhR3pKSk5WY3FuUHVQV1NXaGdBK21oK1Z0?=
 =?utf-8?B?cnVub1hGLy83WDVsK3ByTkFFMnhwOWxRNHEvN2UySG54eE5OV2JacjZMc2Fu?=
 =?utf-8?B?NW5yYWxFbThVY1VXdmJwQzJOTTNUcEFmZCtmcVNmcHpZaWlvMU8rOEx2NlRR?=
 =?utf-8?B?K3orVHpSaGp3bDd1Zi9NazdiY3dsck1tcmxOeEp0QTVlOWNzSjBGU2NnVk44?=
 =?utf-8?B?RTRDakVSTXlycENGK0sxSnIzY25ObUYyTkphU1ZtejVlVGIxVFM1UExCNHh4?=
 =?utf-8?B?bk53Q3ZveGt3MHB1MDczbXhoVUtPM2RSZ25jQWcyeHNkc3piWDJYVk9CaytZ?=
 =?utf-8?B?Sm1pZEZSMEI2eEhBK0RYdXRDRTJkdjlycEwyOHdVcUF2WnIvcTBDWXZncFBD?=
 =?utf-8?B?SHpscW83MzgwZmVudjl4TndMMXVRWE9pMjExbTQybjd4OWJLWEgwazdYL1VH?=
 =?utf-8?B?TncvaUhheDV3bFMzNXFrbDVqT3BweS9nYjVTcGE3ZGFoK2syeWpObVF3MEVx?=
 =?utf-8?B?SEpnTHNyMDRDcEtNMnovRVViNXl3YjVtaGJEcy9tMUNiSFhKdWk3cG5pZ2w0?=
 =?utf-8?B?SjY0enJJLzUrOElubW9lWkpTY1o4SDRBcVFjcWdaMXRiTS9RRXlIM3FoaE9L?=
 =?utf-8?B?SER3VzcvT1lXMW5reDhBU3QrK3hBeFQrODc4aElZdlhxRzdyVmRvY1pHcU9C?=
 =?utf-8?B?Y1JoYjRLZVNjSlJTaDBGa2pFRWZSSmRCZFdiZS83ZXB3QmVRR3I0bldadDhB?=
 =?utf-8?B?YWh5UmJabk5Cb3F1dGRIOEtTSXVIZEp0eXBTQjI0aE0xVkg1aUh3cXgxYWp3?=
 =?utf-8?B?WGpQcVFiV3dNN0hCNEM2S2kwUGVoaFNHbTQzNFlNNFlRQ3JSRmpZSmlaeVJq?=
 =?utf-8?B?NGdBUHNpYTRHWWI5aXZTRFdBbkYzZW1DQUdIUU5hd1VucDgzWGcvYjRVdUJR?=
 =?utf-8?B?eEJqakpISmltSGZSZk84KzJuOFNqMis1WUhCbjhqcHA1eDUwWFZMRkNGUmZY?=
 =?utf-8?B?NDRabzVHU1FMbUxzUS9PVmxuZkRkTUNRNFVvWml0RWRxL3ozUTlhUTdITDJ0?=
 =?utf-8?B?bUVVRnI2MGdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJBcEVUd1FwYk1RWVRqRUx5TkcrT3F3Z1hKUWM0QzhSNVFHVVJyY3ZIT1o0?=
 =?utf-8?B?cVlaLy9rK29QOXRqYXByUHNFWmtrTmg2bllPTHdhZFk5U1FHY2Jyak5hVkdI?=
 =?utf-8?B?ZngxNi9PdStxTzZKM1FPOHZ1VkdRNlRSZGp2Y3ZKU2dRcktXb3VTSnhlcjQ4?=
 =?utf-8?B?VjVCcUhucnhUMkFUTVJnbnkyYkdUOGEwcHdHNUZIRjZBdHYveE5Bdlo0TjZU?=
 =?utf-8?B?VFlJbm4vWkJlWGtCV2doMlRYc3cvSzU1SVhnUmthSkhsUUdwaGc1MGRwcWNH?=
 =?utf-8?B?SGJyK3FYVXQ3Vzd5MWhERHVOYjJVbEpHV2JBUGlzVlBkVi9NcVY0eDZTejho?=
 =?utf-8?B?VlNlSE8zWkNYeG9hcHZ5c29QVmdQUFQ1V005cHpPUHJlalNFSnFzcHZHWHN4?=
 =?utf-8?B?cVRaRVRtUlE4N2ZwcDlnaVlZbGJmVkVzbzl3QnR5eVJYWVVpVWgxa3I3S1c3?=
 =?utf-8?B?YlFRUlRTa1R5dVBOMDlkN1BJREZhc3ErSXBEOVFXNTNQQ2tYZFM1cm5EQWNJ?=
 =?utf-8?B?RVZTdTJNc0dqL3puYkljT0ZFWXpBbUJiTHlocEFDQ0I1clBZeTJJcy9kVlNI?=
 =?utf-8?B?RUdxV3BsNmZZYkxDUDBGUXJHdVVKaVFlb290YlltNGJSOUVnbjFBSmZSS2FE?=
 =?utf-8?B?YjdpNXV4dFQyM2pKRHYxekZpNXg0L2hmdkZWeHZSd2NNN0hORW9FVEIzdjRW?=
 =?utf-8?B?MGx2ZXRpMExWS2JNWnNwWjVMcW9LT3FZdnNPeW5VdnB6dmQrMk1sbEpyYkFE?=
 =?utf-8?B?cDZmNUk5aVhyR0psRU5mQ2huTVdBTXlNbW1SbU9YZURUWjQ1UlpsWjl2SnZn?=
 =?utf-8?B?eHh6aXlZSStkUW02UTNiblVQSFJXWnJmOVFuQVVGYzNWV0k5N25FcWlGdDJ2?=
 =?utf-8?B?VTVIK3lERUNXTEhhc1dhcUUwSFdzMVVHaUJHZVJHS0lubnRzTExaODN0VTFa?=
 =?utf-8?B?Q0U4SzlZbUhaVDQyZmdDQTc3dGtTbVhtU2ZhVlpPbW00WGp1SDJGTThvQlFI?=
 =?utf-8?B?Q3BGNVR5dE5FMnV5SnVkNmZ0YjQrNjV5dUg0Z25tL2VtZnYra1R1MmtjRmpk?=
 =?utf-8?B?aWNsY3ZBdEFVV1VUeDBEUVJDcnh6NEZjcXMveUM3czlBakhONWRaQ01JSUJa?=
 =?utf-8?B?bkRBWHlqNm80RjQvMHRTMWdSN3pYMHJCM1pPakdFTlNRN0FxSTRuTHV4dnR1?=
 =?utf-8?B?MW1sdHZlOUQ1YkhWbHkvOXkydi8vcGJ2WjBKcFIyRWpaYjhzNGdlZnJwVDFt?=
 =?utf-8?B?VDlobTlMb0E0MTBrRDFiSWRjOUFuOEFFZEhsWjlBQnRJZXMyNTVpUVdxUGIv?=
 =?utf-8?B?RmltUkJoTHZ3NzJ6MGVCVTl1alczTWNZdS9sK2JOeURjVG4rWjV5dFF5NFc2?=
 =?utf-8?B?bVUyV0c1b0VBeHJxMmRsd1ZMVFY4em4vaWtXY3RNSmZxTnJ1cWI5U1lzb3d2?=
 =?utf-8?B?amVBVU1PNzVJZW8vQTZaQlB5TGFQQWFZc1NtaUlsb296b3AyVEgyalJoYUxY?=
 =?utf-8?B?SWdRZXEvNmNWblYxVXhSeVBjTmFYMVpmSW14V2hOVGhYYW1uNkYyRnFuM3o0?=
 =?utf-8?B?Si9vMHB4dERuOWo5elBUSWdjWnJiemVaZkRkT005VWRUMWZNT1ZPNE5tN2ZS?=
 =?utf-8?B?UnFkVUY5UVNVbFU0ZCtvaEJ5NHpZRzhzeTBmR2xoM1I1ZDllUG94UTRlTHRY?=
 =?utf-8?B?eWNQL0dpME56eWt6M05LaW13TXNMWFZpd1gvRUdnWXJhVUNJUU05WlRJT01J?=
 =?utf-8?B?Sys5aXg3MGJaS2FMWHl0N2x0R0ZNOWNia0lXZ1habENoQlN2eUV0eS9YemQ5?=
 =?utf-8?B?R3dMUTJrOS9raVJYSHd4OEZkb282OERQMWRRdi8yVjl2Sjl4Vk9GNUU0ZDdl?=
 =?utf-8?B?dkdXZDE4MG9ycWo0dTZwZ01WaFkyVHVnNmpXVEZPbS9LWFhDWE53L0xsclVm?=
 =?utf-8?B?TU1iK3ljS2lnMGRnQWQwL1BzR09TQ1Erdlk2MU5pT1FNR2t5TndFM0h3QkZN?=
 =?utf-8?B?Qmhmck9Ra1Y4cWxNK3plbFJvYzJMWE5VWmZqNi8yK0FkQ3d6aW5ETWlPd0Qw?=
 =?utf-8?B?VWRROUEySjQ4UzYvMjRaRWtDdUc4TERWQWVGNDRTQzFVYlFzSGl6VlA3R1Jh?=
 =?utf-8?B?L3ZjU1F0aFczdmVicU1rM3Nma09URXFNbDRtT3hHRGNxVUh6MVFhMTRxNG9Z?=
 =?utf-8?Q?7rQ/TJjuWamlWCWVYf66zySX+FgfxS3R2cvl/hpi1N6X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6400ef-35e1-4975-2907-08ddd99f0b1b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:52:12.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk/VaBSojmKH/emLW35Ctnhq4ikHn5Bia8qWlrVsWErbpRi21dL81x7iw0EkJz3GsiIxucDW7yk8MjvfvbnZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

On Tue Jul 22, 2025 at 11:59 PM JST, Danilo Krummrich wrote:
> Expand the documentation around DeviceContext states and types, in order
> to provide detailed information about their purpose and relationship
> with each other.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

A couple of nits below.

> ---
>  rust/kernel/device.rs | 69 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index ca82926fd67f..f5d1db568f00 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -311,28 +311,75 @@ unsafe impl Send for Device {}
>  // synchronization in `struct device`.
>  unsafe impl Sync for Device {}
> =20
> -/// Marker trait for the context of a bus specific device.
> +/// Marker trait for the context or scope of a bus specific device.
>  ///
> -/// Some functions of a bus specific device should only be called from a=
 certain context, i.e. bus
> -/// callbacks, such as `probe()`.
> +/// [`DeviceContext`] is a marker trait for types representing the conte=
xt of a bus specific
> +/// [`Device`].
>  ///
> -/// This is the marker trait for structures representing the context of =
a bus specific device.
> +/// The specific device context types are: [`CoreInternal`], [`Core`], [=
`Bound`] and [`Normal`].
> +///
> +/// [`DeviceContext`] types are hierarchical, which means that there is =
a strict hierarchy that
> +/// defines which [`DeviceContext`] type can be derived from another. Fo=
r instance, any
> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
> +///
> +/// The following enunumeration illustrates the dereference hierarchy of=
 [`DeviceContext`] types.

Typo: enumeration

> +///
> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
> +///
> +/// Bus devices can automatically implement the dereference hierarchy by=
 using
> +/// [`impl_device_context_deref`].
> +///
> +/// Note that the guarantee for a [`Device`] reference to have a certain=
 [`DeviceContext`] comes
> +/// from the specific scope the [`Device`] reference is valid in.
> +///
> +/// [`impl_device_context_deref`]: kernel::impl_device_context_deref
>  pub trait DeviceContext: private::Sealed {}
> =20
> -/// The [`Normal`] context is the context of a bus specific device when =
it is not an argument of
> -/// any bus callback.
> +/// The [`Normal`] context is the default [`DeviceContext`] of any [`Dev=
ice`].
> +///
> +/// The normal context does not indicate any specific context. Any `Devi=
ce<Ctx>` is also a valid
> +/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it is=
 valid to implement
> +/// [`AlwaysRefCounted`] for.
> +///
> +/// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
>  pub struct Normal;
> =20
> -/// The [`Core`] context is the context of a bus specific device when it=
 is supplied as argument of
> -/// any of the bus callbacks, such as `probe()`.
> +/// The [`Core`] context is the context of a bus specific device when it=
 appears as argument of
> +/// any bus specific callback, such as `probe()`.
> +///
> +/// The core context indicates that the [`Device<Core>`] reference's sco=
pe is limited to the bus
> +/// callback it appears in. It is intended to be used for synchronizatio=
n purposes. Bus device
> +/// implementations can implement methods for [`Device<Core>`], such tha=
t they can only be called
> +/// from bus callbacks.
>  pub struct Core;
> =20
> -/// Semantically the same as [`Core`] but reserved for internal usage of=
 the corresponding bus
> +/// Semantically the same as [`Core`], but reserved for internal usage o=
f the corresponding bus
> +/// abstraction.
> +///
> +/// The internal core context is intended to be used in exactly the same=
 way as the [Core] context,

[Core] -> [`Core`] I suppose?


