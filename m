Return-Path: <linux-kernel+bounces-754336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E219B192E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A669918981C8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CC9280CF1;
	Sun,  3 Aug 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b6tLGnRZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043378F2B;
	Sun,  3 Aug 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203403; cv=fail; b=JA6fuGWquPaKgWyWteAfuHJGBftiTiXtRgw4N6gz15cY+0U3h8WOvL07ns3U+ugE+CCZs5fVUlHTjqQylDeHPSHx/ZFvb7jX9RUpNuL2TK3UUCz0hJ24S49NLBMgQzyo42v10jWRdmU27PeSiLd9viuLz5aEm7pzcEkqRsjQvZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203403; c=relaxed/simple;
	bh=NmztBIeZp1glwlm8AxkwdXV1CbpANJAD58H8ielfuBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZib/v0+2xCLAo4e//8oJXohstd/rOGMmhYGBwtZy8oOMq2ufFbM5gDPC7l8ysM0si2QV6lbq+R/ChVIucXZKmOWTg+gSHZ/nei66gKwwA4laYgk+MmDnC3y8H8kJD+umRqfZ0UTnHbiEcNYS2v98ealpY11HinxKImmr1vdRUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b6tLGnRZ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhW4nHgrSzTMGbXIPQIl4MiKqj4Pxb3tOMlWMjljdrES/sQ6372P48SXLaDXZClQThSz946R/qAy4WggrmDIl557CJH6dK4CGXkSb/wio1iTMvkBMcO9Jm+RkQvAZDh460fFAquy3p0Vb/vt8is52ROLtpO/NkjsR/72FrsIJgGxWvZrC+RqclDMSSYhcCkDZshKlCjGydgb7F2IwWVpWanpOkWsI8Fjxl/Xh8huFJ4OXJAAdHvIQpLh08x1yPfBCMsW/RP0hGhRvf/PH82k6MUsBQ0+isfVxfQltPyqwVGYJ1IIKMBGjFKnnB3zUoGX+GdBsGkbylBCsZvLEFvo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmztBIeZp1glwlm8AxkwdXV1CbpANJAD58H8ielfuBE=;
 b=I0S6sPKumG5Aqlt8YYJoSI3lOando6mzhK22f7KCwj7qr6YN5A0dl2pQHSRXLCnoM62do2veofWPXrvXKuE2vGbAJzSQIBZ8UZbURpdTwwsbGvHTIqmlMn/uRcsWVmAv6w3GVGeZyzgfAyrmGynEeaeywLDzajWYrRwzgcbpD3r12Ct+m8lTF3I49H3DlOiQJS6RnZc5Dt5GkyiRB6GGMfN5/RJ+dh3fi1r96VQp/dcH7VEqpv8GDY6EVBMlJSsW9U37WQTawj/SNGEsVz+PyIOeJ2cwtlORrnPOsKuobKI07dFpn03my8kOHgJffqDCp7WtqHFnHQ35WXBIS7IVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmztBIeZp1glwlm8AxkwdXV1CbpANJAD58H8ielfuBE=;
 b=b6tLGnRZWEoReoZlJB9XTavuBaJkuCPc9LFuPc71nchZa9hazKYilmpqJq976p/R8Zdhpg0ARzsQtttVbs7o2l/bd/7wQpOhfcCH0zo38KijfhojziCOk/8R/aCLO8Cyet271t2lVa+X2E8nsYrOLWsKUK1e6VrGhZUSW+O2MYObDg4hUZ48GDjca4tPnAEYYPJdQsFKhhf0A34J8McThJACUMxV97OWGOSLglonCpmyt+tzbSsJXYSChNaZbGqBLtPy8i50L/jpLC6fyY4Q3ydEfbfXIv8rQiyqCVptcPFaTmlgHrndunlB0+oPHRg+3CZkWVPOhbY7E0fHuo19QQ==
Received: from DM6PR11CA0062.namprd11.prod.outlook.com (2603:10b6:5:14c::39)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sun, 3 Aug
 2025 06:43:12 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::3a) by DM6PR11CA0062.outlook.office365.com
 (2603:10b6:5:14c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Sun,
 3 Aug 2025 06:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Sun, 3 Aug 2025 06:43:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 2 Aug
 2025 23:42:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 2 Aug
 2025 23:42:08 -0700
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sat, 2 Aug
 2025 23:42:04 -0700
Date: Sun, 3 Aug 2025 09:42:02 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: list: remove nonexistent insert_at() from the
 comments
Message-ID: <20250803094202.3bf0f38c.zhiw@nvidia.com>
In-Reply-To: <CANiq72mT=Eee3NwxxmysBu4iP6LYuHA2NckrKKVY=qQSSK12=A@mail.gmail.com>
References: <20250802210001.824022-1-zhiw@nvidia.com>
	<CANiq72mT=Eee3NwxxmysBu4iP6LYuHA2NckrKKVY=qQSSK12=A@mail.gmail.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cac8a9a-c01e-4c8d-30e2-08ddd2590454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0l1bUVuTDg3cExzM1ltYXd2K3Y1ZmJoZWNhK0lkZm5DVWQwNndZN1VycFdK?=
 =?utf-8?B?OW1QWlF1cnVycUZ5ZmtxMG5ldFlCOFNFd1IvaEFUaW9PWndkL3lUSG1EMEkz?=
 =?utf-8?B?RTNmR2RsT040N3ZRUXlPM0gxc0tEaUpQN2ttNXJyd2pFZmV3NlV5NnZoRTNE?=
 =?utf-8?B?OTNNYjQ1RzJOdHVySXJNNDF4bGcxcVR0alZMV0NjcGNKRDNRcFJlL3phaGcx?=
 =?utf-8?B?Y3lpN3NqejU3aS9mdk12eUNITk5ZNDBGb21JOVg2K3pvdG11Uk9JeFlqT3NK?=
 =?utf-8?B?WmdCazlocDZyQmVMS2xxc21BNWhncGFRZ2ZPQWpOTmRCNVNGYThuTTIvWnFl?=
 =?utf-8?B?T3crVnV5NjVSSzdWYU9WZXNQTWFxWnNrL0tMS2JadVNHNE9mU290b2t6blQ1?=
 =?utf-8?B?eVhsZlpReS9oMklSVmhjZlFOMEt0SnpBUTUwV0tYM1ppQnhremxPZGZNeS9s?=
 =?utf-8?B?VHh6WldhK1hFWFJQTEp4cEJSZDl3SkgyRkJUWG5MbUU5T0hhcHJhTmV3VktR?=
 =?utf-8?B?UUxpZTREcUJDUk1pZ3VaendTdm14VDlUOFV1a3hzLzBCcFI4WitZTjVRT3Y1?=
 =?utf-8?B?azdpa293MXpETUlnUlFwTVF5QmxmWWF5akRsRVl1L2pHWmJVb0x3ajFHNXY2?=
 =?utf-8?B?WXFzVk1wcytwWHFoVXFJTkxTYVNGYlFnL256aVM0Q3ZDTmJ2ZCttdjQxZVJj?=
 =?utf-8?B?NjJCTDFHUnJ4SmpFZnBmeFNpcFAwaHdlRlJpR1R1NDUzbEtkNElrV0JsY1Yr?=
 =?utf-8?B?ZDJRdHNmaW5lTXFxQStHeGRCbUJRR1g4UGlKNFk0blpHRW5kNVBETUd2NXhL?=
 =?utf-8?B?ZGVpQ2lvUnlnTUF4SHZhUWtvZjZVSWtKSUJOYkVXcWRkWU41MW1YZWVPMFV4?=
 =?utf-8?B?NVd2bDQ0SjR2cm9RMEVPeC9USEVSTUtGMERJTkFlRC9Da2lrT0t4VGs0M0hX?=
 =?utf-8?B?VmIwYmwxK3V5K2IwNGhQZ00yd3BpaytqL2NSTFpmb25KZkNod0RjRnhWcEZT?=
 =?utf-8?B?QW9vc1Q4eUZFMkxiQ0NRK0JJQitNT2lDSzBEbUkxNjU2NGtsM1F0QlNGcXV0?=
 =?utf-8?B?VStZdlJheHRvZUdTYmFyVEpJSkE2TjlRRzhrcW5IS0xyWTZacjJ6ZkZpRklQ?=
 =?utf-8?B?VzU2d1UwUXZjMFZSOXUycy9SK1Z0WHNXVWlGczVBeTRiNjhBR3I3bUd3dWl2?=
 =?utf-8?B?Q1BRaE1PcFE3Z2Y4RXJpenNxUktGVWkvUTZJN1V2Q0tEdmkxaCt1MmxWeXdB?=
 =?utf-8?B?elZ6QUd2dllUTUNHL1k3M0FoWkVuWXZsdEQ0OUVvUFdjNjFKV1I5NVlWVWNQ?=
 =?utf-8?B?TGhBM0hEN3hFZWw2R2xSUDB3SC9qaXhzQ09GSHoxM0NwMndGbjJsa012SDFv?=
 =?utf-8?B?dWUzcXQvVWh2K1FGcDM3MzdzS0lBZ2Z2d2h3WnVsOFgyS0tUWmpaTzJOOUwy?=
 =?utf-8?B?SVBFQmQ0MlZUSkgrZVpzUmNDNy9LWkpxdkx4RkJjT0RWWnVOamZRemRiaHk4?=
 =?utf-8?B?bC8zRWlvZWhGcDd4eHBnZGtSUlVDMlRxWTUvMCtCaGN4VUNQeTdzTDVKNUly?=
 =?utf-8?B?bk5raFZrRGpvS3ZPZmQ5bjZlUlFaaStIUU1nZm9wV2RoVkdocjdvaFFZWWpi?=
 =?utf-8?B?N1VZRmozcmtHN0VQYjlUVTVxaGo0UlhJUGJTd3FSOXYzTVcvT2RobEpkYXNr?=
 =?utf-8?B?dGF5ZHg0RHptdkVaL0dzejJ0RHNnZCtQUHU4R2d0UkdSWTZ6VHh0VU84OTJD?=
 =?utf-8?B?ODFaekwxM29kUFlVd3o5VkExNFM5NjFDNTJhY0JydDBuUGxlUmozZll5NkZN?=
 =?utf-8?B?VEl3QWxpWXBzcEVTY2dzVVREcUdkMThQM1dJRlpQVkJNQUUrYmhXdGRPajJB?=
 =?utf-8?B?cUlYcGplb1Jvdm1LVjNXYWlPSUo4cm44L2d3YTgvU2pWZEtEeVRTWnV0UHEv?=
 =?utf-8?B?bHM5QmFRaEh0RHIrR0gzM2F4ZVZteGZwZEM3YWJEOU5ZUUFGUS9GVGZsRGxi?=
 =?utf-8?B?eEhNalZFalFsM3Rjbi9DeGM3K2thUnpkTXFhaFRjZ0pFS0QvUEwvQjkxVDln?=
 =?utf-8?Q?/ERIx0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 06:43:11.9757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac8a9a-c01e-4c8d-30e2-08ddd2590454
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

On Sat, 2 Aug 2025 23:31:10 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 11:00=E2=80=AFPM Zhi Wang <zhiw@nvidia.com> wrote:
> >
> > The insert_at() method was never introduced in the code. Remove it
> > from the comments to avoid confusion.
>=20
> Hmm... I am not sure what you mean -- `insert_at()` is an example
> function, used in the example itself.
>=20
> Why would we remove that one, and not the others in the example, e.g.
> `remove_all`?
>=20

Oh, you are right, I lost the context when reading the code and
hacking the list routines at late night.

Please drop this.

> Cheers,
> Miguel
>=20


