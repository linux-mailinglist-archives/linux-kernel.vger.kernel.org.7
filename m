Return-Path: <linux-kernel+bounces-746588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C78B1289D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3E9547F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0A1E1DE9;
	Sat, 26 Jul 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukH++esB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF0B652;
	Sat, 26 Jul 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753498651; cv=fail; b=OYbebE9WM1h0CmL1i7re/V8Bvmlsjk1LrSdrtxTKG5S+X2dJTm5F1vyZws6kt2YsB03In/yi05jc3BmGyFkzLrMdwMtvo+Eq6+vXjFmLecQMLfH0COyh5uYRuXW6sCArz2KusMHF7ePK7Uhwfm1XymK0lGg82e3+i7m+67mqv5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753498651; c=relaxed/simple;
	bh=iNX7J1g/hQ2QM2VWTRzcP3rkf5mjsqeqwHlK9XdMCOk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KVJFV/iHrK9+og6Kajk3QSd2qzVr2sWL9APU+8P9Zl8xLreW4FWwHJnMYxWsIdd1tD1nywcq48boY0Y/jSy4xRkWoDM9ph1NqLiG/vpLpb7paPvvHnAPq7moxCwc6HVvhyEiUBphPUEzPP6JPjjqzHnS50y885dzfPry7OaNRjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukH++esB; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+Kmk7A5kHNkkML1OrCCPiEq9NXreJX2F6eVmSktcsBhslOd6CFHoFYPDrwM7h3Jdpzg8qK7smogg37fv0CVo5rAypi6vRVgseL8CjFOkEzRQlJuT0VC1GPtpJvqDGI69wPElfz+dVAcPSYln3WeiK2bXTD0y7sjxFGMlVjQ25eS6Vng43rYhtDewJV4xu/STCY3FsUUFqkMqrXw0XcZVgTTM/EQaycBheof0D9O8h3MGuySbSvbfcWeoJdtgupVQHruvKO0Twxdcw9DQ3p5RvZRN9i49LHzBIThSx7IwB++IgS9GVLMubhWQJFjUGPZmD+AdyTecoghyYHCg/AU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNX7J1g/hQ2QM2VWTRzcP3rkf5mjsqeqwHlK9XdMCOk=;
 b=gvQKbWC7qH0bGU8NhAPEXXGAaVLSYjrtULkmOq+DIhxy4QNee1HDORFRuOAJEwJMngN8QflRtDNkyknGOtebRygd5u0bj3cGkZJgb1/zJFogXu7EvBCH8GMIOpxamspZfemk6znbtVEU/CdAuhqZizx6r5Epnj8a03HGFskvsiuWl2GNIkzLXTbqVgi8bP3bhfgVmEWxCQ6DPn4HhJRjufzn/fJTt3idBOhyucT6A82TYqoUvFPYlabAiDmAIQLiO/8RXI67GsBE4PurRQjuX9oy8JV4sobKOQegxcu8afoc8VRh/7nqkd+jpTVCGPUYQ2pLC1iC5+kG20NerxTPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNX7J1g/hQ2QM2VWTRzcP3rkf5mjsqeqwHlK9XdMCOk=;
 b=ukH++esBGCjLFZF466Sr8x7ywgIeUKoIDvIiGpJL0XcliNaOFqZo1dtBCbaZ0leUENl/N1ZvqqZ8fQ7lE4Nylkl8XY6agRKLQHEtUiYGHi6vFGMv45AQXKoNUi7+534PNWWZp8iRPTsA/hkzLLX2vO2ly2omVu16nr7g7qFAMXPewb3TUilEhITG1SaSddVctWBMEpcZjNzeO0BFW5avPs/NXHO1RkmVxWARPkY8RsAZVX4uMnQUb0rHqElUr6Gw7prjHZpMUCM6Cobb36F9UeVVnYHWgNu2f6Kdqsttcf5VfwxzeH6hIpJu05Sm02mD9ewDkXYS+R2Ti4ARQtanyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Sat, 26 Jul
 2025 02:57:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 02:57:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Jul 2025 11:57:21 +0900
Message-Id: <DBLNE36GEIZK.25GHWE9UTLUBX@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian" <christiansantoslima21@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
 <DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com>
 <CABm2a9cfK+HuidwQwcD0Cs_n+dvd9Y71tFn=grz1ahGpbPpurA@mail.gmail.com>
 <DBIN4DXACVKW.2XJPQV4RNJD70@nvidia.com>
 <CABm2a9dh9wGPdh+HofM5uZts_O7kFMyKwtGRdxbEw7wsxHvAUQ@mail.gmail.com>
In-Reply-To: <CABm2a9dh9wGPdh+HofM5uZts_O7kFMyKwtGRdxbEw7wsxHvAUQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: cd018f4a-d737-4958-5080-08ddcbf0263b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NkdzN2Uy9NeUgyWGxtYWlzRzFqSnJwQm9lZGw1N2pWMXExVmNQMTQzMU1Q?=
 =?utf-8?B?M1c2SUpjeEJHTHEyVk5OTGoyeGFxVVpPeVd3OExGekdDeEJIVjFxV2tsQWdn?=
 =?utf-8?B?bUU4TGw3c1FCTUFidjlrSzRPYW54ZGE5WUErRktiMjFIYyt0SDY0bUtubGp6?=
 =?utf-8?B?K2Z6QzBVcWxBSWdlN0xVcm45SW01SWlKUGJlWVFiV1JsVWRSNi9rdjlPOVE1?=
 =?utf-8?B?UlFkSkxpS3FBZHRybldtamFZM3BUODgwTjMvRXB0NzVEclYwRXVvNksveW5E?=
 =?utf-8?B?U1hOdmlFZXozNndZWGpmSUpqRVRKN1dsenI3SldqcTJpTzVjMVlHQkkrNk9D?=
 =?utf-8?B?QUFyb3ZsYWI0d3NidkVWQVFPbXl5ZngzVi9BMEY5VjkrZ2hXdzlIUGdyWVM5?=
 =?utf-8?B?MnozblJiUWtzMm55eW5CcHU0c0FObVZMcXdLMG1RUGozVFpyQTFiMHo2RlM4?=
 =?utf-8?B?RzR3Tm9TcUJHMkdsLzRBR2t1Tld2c1ZNM1RoY21tNUdBT1FBcGF1cWNIQlZa?=
 =?utf-8?B?MXp5S2h1Ry9JRllYazRLVjMvYmlQVElIemYwQyszUSthcnJOdVQ0dE81Y2da?=
 =?utf-8?B?cUNvL1Q3bmRRUFlGdXNweUpGWjgwUEJlZlJzRFZEeVFRNkFLbk1KUmxjOEwz?=
 =?utf-8?B?WGlEMEY4b1NBUlVTNUNhb2QxM2lON3pEUFFxVTZqWmNkUVdxQVhXRzhIdFU1?=
 =?utf-8?B?OUtSa1ozQnBQbkFibWZ2UU5RaDFsSmZtVlFZeFNleS9XNDdKbjZ6UC9RTkdT?=
 =?utf-8?B?K2luQ1BMeVFPVzRnVjFaeW05akNTd01TeHAyVVpXNlVsWUtNM0ZLK0NRUFZW?=
 =?utf-8?B?eDNzZ3BtejhXYjl2aVl6dzViT0pyRU5lbGFWR1V3Tm1jSHdSeDAwRW1PZHg1?=
 =?utf-8?B?bEgrelVCVWRxTHM5cUFVOTB1bEtPRG4vSnVDRkhkQVI4SVF3b3VJQVlGa3J0?=
 =?utf-8?B?eGp6VitwYk9KUnA5TUx2QzRPMFZGaGpNVVRkU1E4NjNFcCtsTzcrNU5PMG4v?=
 =?utf-8?B?aHo1VHg4RkpDMEZzYndhTThrWG1MUmozYzhGVFVRMGNrbGJqUnAwTHJlK1E1?=
 =?utf-8?B?UGg2Vk9Lc0dKUG5CR21aYlVDZUhvVDlZaVJuUWVqRUJPNUl4dXRrS1o5TVl4?=
 =?utf-8?B?bU9GcnB0d2dDVFBRb3FOUVBuZTgrMHFPK21zNUJCYURhdmdDVEJKdzA1dGV2?=
 =?utf-8?B?ZmNVemtyVFJDNEVWZHhvamE2enphbCt5QnBmcjJwMmpHQXd3VUVXZ0oweHA1?=
 =?utf-8?B?SmVZVHNnbW5OSHlmNW1iZEVhNURHZy85VW85aElzZU44RDBMZzd0WWp2U0w5?=
 =?utf-8?B?Wk5OMmcwVUcvdlIyRzA2R2I1UHVWS0FNOExnR2JOaUMySWRBSWJ2L2VDcllB?=
 =?utf-8?B?d0t6SnNWdlJkazlEN1FFUGlHLzNaR3BONEQrdGQrUVNUL0xqK2VRVWxzWjVP?=
 =?utf-8?B?Y0FSUjlTTW8va05RVFFhaCtucDFuOWEzZExnNnc3NWNkVTVjRlFXUFl4SFFx?=
 =?utf-8?B?UXJ1VUFTVEVSTXRhQWN2TEIrZXJNTWJ6OVNvMlpTSGFNYmIreXhMRzBMa2tN?=
 =?utf-8?B?MmE1V1FUcmZURzdVdExTQm40ekdEYVJRZEw2dFZzR3Bac1U5aVZ0NnlzUFlC?=
 =?utf-8?B?VUFmVmpRMWVSeTlpd1pSUHUvdHNzR2xKZ1RDYW15dHlwRzhWQWNOYnR1N0ds?=
 =?utf-8?B?R2xGQUJ2QW9qMk1BdEFnc3RsVnJXMGhZMkRFVXZpUlhEai9zMVJBYmUvNU5V?=
 =?utf-8?B?V1JmUDVVS1NOc0krNDVPa0NvR2VhTEpxZ1I3SkpGRTdaR040cVlLRWpIK1NF?=
 =?utf-8?B?N01nR0tQVk5lUm9zb3FzckFkaEVMVVhJemRsc05nN2gyUUhVNjZhdjJkUlRU?=
 =?utf-8?B?cTZYZW8rM2kvcE5aVGJDUFQ5R0tTeWx3RjY3TDhHSHdrTi9yRlM4RXdrc0Zj?=
 =?utf-8?Q?rQfOjdWhw68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2VlZmpmcmkwT0NicmVxa3QwQVhoUlI4bTFEUk5FZHRHT3pvWUJqM244MmZq?=
 =?utf-8?B?WWVqajc1RXdpejd5MlJuSDc1OHkwMktEVlQzeVN4RFhQeW13VllMWmhEUE5K?=
 =?utf-8?B?NHMyYW1XN2NaRDErd0diUWN6QU5tTnNCMUh5bCtKckthMVhzLzRkMjhZZkF2?=
 =?utf-8?B?THBZNWY4SWZMMTBFbXZGQ3Y5RHArTUY2d2wwK3lvR1ZHNVJtMU1JbU5jaVM0?=
 =?utf-8?B?akJIbG1UOHdBUDRWOTdnaDJaendObFlPR0lKelR0QklhNkdPNGQ2UXhucy9O?=
 =?utf-8?B?Vk1ZS0VKV3haN3F5Wi9QZ1hVMjM4Yk9Gd0t5Z3A0cFpMMVc2QldFdTJ3Qmlk?=
 =?utf-8?B?dlBkZ1djWG5CWHRaMkp4OTFQTFM3dUVQemZRUlhKOG9uMGZwUnlXWWNnajU1?=
 =?utf-8?B?QXVSZ3RBUHM0OWhqYlhZTi8xRU9JZDl5R0luWDRVbGIrS3VOdEttVVovejIv?=
 =?utf-8?B?Mm9lZGZwNERieUk4QkNnMGZjYjl1R3BYTC9vZFhZdERFUGpxcGJ3TVRDeEYy?=
 =?utf-8?B?NldpYmNhZFZoNGlFYXBObzd3Um1jYTl0Rm52bGFxcitkV0kwRzMxRHo4aWs1?=
 =?utf-8?B?Znh0ekFwN0FEeC9JQjBDdkdDdGFxd3k4cEs5MnpKZ3BIaTIrTFk2ZHp0Rm1n?=
 =?utf-8?B?Uzc5VGFHOERWK0V0K3pmRGJFaGg5ZUFTSzcvcmVVT1l0M3R4N0hWTXZLZm0z?=
 =?utf-8?B?S0phRXJ6azFSa2dlKzFGbkpHNVRZbkp3QTBJY3RqeVVXTkRIeVpJTytYMWdu?=
 =?utf-8?B?STFVSG9FY0puWEc4dGZkWGFNVk1IZHJGVzlrYXJOd2xWTTYvZDVlUXVLMU9l?=
 =?utf-8?B?Q2s1SjQ5bXZITDZCS2QrQTJteEYyNHFWMlpJWDlMUXhVQVI2L2ZYN3dES2dB?=
 =?utf-8?B?QnJNLzdpQU1vM3dPRnZ6TWZkOVlhRTJqWXdiUTlpdkh6VHMwRXRjUnRXVkJv?=
 =?utf-8?B?RzFkWjROaG5mZTVXZTZsL1RvR3pMTVdYV2ZJd0xpcE1BR1VqQ0pML2oxdzRl?=
 =?utf-8?B?NldYNFlMRGE0UWRLVmtMbzJUd01ZS25mWGViOUgrdks3aWlaRWxhQk5uZnRI?=
 =?utf-8?B?UUVHLzlqMld0RlpsUHprUUxuUytxTEN5ZGVaS00vb2pHTGZiWGhwS04xRjJJ?=
 =?utf-8?B?eW85RTRyZ09ZQkprVll5ZG5EeGpycWhtcUYwMG04aGpXSWhxTVREVjV3UG5n?=
 =?utf-8?B?Ry9WSHBvSlE3WlRWRE44NS9WSGk4RzcvRUd0bUJYZVNOSjZPaGpsSE9VVTBa?=
 =?utf-8?B?ZlkyWDBWaU9DUk5IR2J0ckMrRkpTeFMzUVZCdndYdmpiYytXbGJmVXFLbzdt?=
 =?utf-8?B?SkU1MmlpN2RtdllhK2NsYVlKaG5qRXA5Q0ZkUkkxdjBVaU1yMUxJWXdSdmFw?=
 =?utf-8?B?Zy95N3hiN3AxdDFEdGtnRmo3dndpaEtkSHppdlpBdytUYStqd0hVTnAxWURn?=
 =?utf-8?B?aW5ZUXU1dDRWWkNwSFRNYWtHSDZaWUlQL3RSSDhhTkszOHhNL2Z1Q0RBbUNP?=
 =?utf-8?B?VmFyNHcwMmRGcmF1TGFqcG5MSE12anNNQ1gxUUtFY0ZjUXNSVnpuWXZ4Q3o5?=
 =?utf-8?B?Yy9RbitTTC9lTGxuai9GV0RLNnplcEpGV3pjTVY3L25UZ2pUN0tTdWNIOUh0?=
 =?utf-8?B?WnhoOUc1eDEzZkRpQWd1UHBiRGNVd3kzdjNSbXFpNitRdjZGd0ZJeGRBekZO?=
 =?utf-8?B?ZHV4T2oxN0pwcjB6L3k1YUxuSHlUb2RqSWxtcVJtMU5GRVg0WVkyU3RHdDIx?=
 =?utf-8?B?dzB1dW9HRkZ6cmVnaEpmc3Y3TmpMcENTRHN1SHQ4Uzc0Rm9MWnlwaFFGc1FD?=
 =?utf-8?B?amFxNmdKM3U1VXVkUEVWNmRLc0FySG5LVVQ3TGFpcnZIV1FhU0RsRlY5RStL?=
 =?utf-8?B?VjdEUTZPMmYyQVFrZVdZc2k3MysrSGJvZjhWZ3UrMFFXQmdTRTBNVnZyczhZ?=
 =?utf-8?B?TXlQWnRwcVpIQmo4dDZ6aFZDUmFwdDVBdXNwUUl2MkY2L2tHZm5rVEp5cnFr?=
 =?utf-8?B?Q0ZOOXJnR3V0bHpYL3dVNTB5dkgyeG9PWGFoY2UwSk92aXVYelluMU5oR1RB?=
 =?utf-8?B?Wm9UM01nT3VwWWRIM01VRGNzZGI3TGI4ajN6eUtWdDdOVUMrZVJoQTkxMDda?=
 =?utf-8?B?Y1ZIVm5abldWd1QrZ014bE52SFkwV0RtNEJkcXQwNDVNTDlrR2x1VXlzblcy?=
 =?utf-8?Q?B4XRNpnZUmSF9mvR/HkfRNkPhI4Z+vNXzhE6i3/MzYRF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd018f4a-d737-4958-5080-08ddcbf0263b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 02:57:26.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAc0a2LbE2S95IcjtYdeMInCT81164FlfBKkNr6aisCgFkQZaPPcOXflTzbf87Q4OY2o9WBczplZVCBsHV8X+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Hi Christian,

On Sat Jul 26, 2025 at 3:37 AM JST, Christian wrote:
> Hi, Alexandre.
>
>> To clarify, I am not complaining about the `Self: AsBytes` requirement,
>> I am just pointing out that you will need to update the sample so it
>> keeps building. :)
>
> I see, I was just justifying the decision, sorry if it sounded a bit
> aggressive. English isn't my primary language, and mistakes happen.
> Now, about the patch. Should I submit a patch to fix the broken build?

Your English sounded perfectly fine as far as I can tell (not a native
speaker myself :)).

Yes, please send a v9 addressing the remaining issues we had on v8.
Hopefully we can gather a few Reviewed-by and merge it.

>
>> Sounds good to me as well!
>
> Should I submit this patch to nova-next?

Just sending it the same way you did so far will be fine, all the
relevant folks are watching.

