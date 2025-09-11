Return-Path: <linux-kernel+bounces-811249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A92B52669
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE33AD06C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08A212572;
	Thu, 11 Sep 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1hlLhMv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6735433B3;
	Thu, 11 Sep 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557365; cv=fail; b=mi4SD3XAWUEPGqPscHWkyXzbiPaXh6ujjBwrmieLpO6NTGMB49R1W2k0Yvv08IKaUnRIW6lm6nZzSzHJUor13sZ6P+v7BGVkZYzMGlZXJ87TX2n40JaPAwH7Yy/nGPRGUBL1C7IcEewqXYQ0D3fVi/BIremIdfYFp9LkM8NoPLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557365; c=relaxed/simple;
	bh=6Lpydwz1iX8qjXZXYMldUuwyjpeAYDZIcseqGyPSih8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=TckWWkyoY14vJXY+EOJ4qmi669DOlPN2xBp+hirYjhocHq8Tm/7LNmU6aVKE6paxqX9aKkgdt+gJA/430pUigC9eb2Opvcvl1X0Q5FI/lXVnYLLYzpVezShG18VEwpsqhd0lf8GyiQfiFkZiBmOXWPKo5BhTG88J57wnT/i6aMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1hlLhMv; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyZPJiKh2xXXPXRFsVCKGguXMInMEOIoMIvaI6t+Pq13D+j/k9ILSCo/9XIVHOeXdsDZKIv7KVLySNrUjj4bTYiX9sFAI/KxtioeOApwMj655IraFKCPlCIduI1Y00aQay0KhjAMJgJV2+tB+nNZdpQsRv/f2CbyN0yuCkfJDZlBfnYWMD/w3Y//fwPHkptm1fkmN0vYZbdjb0KNRwU/USaPIxx0QobsaoFsGXUzCI4etl0E4rbH10g08PJ41Q0TbX5ekFC4UXvfp1e3ZnzM9Pn0Qw/Z+5Us//euaetEYAaVqH1kNu52wTjC24C22yB0yXjNFfPsznf/0foeFjKUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW59TaqKQGNO7+jrRiQG6KPOUjDx4MFlEbe395jF1+U=;
 b=dKEKQHm2LlOu1S9Z/uvpxOMaJMR62LFAQvQhygthwctxwcBAJQ1zAYQO20J9gMCMyKRGAlcDadqGBiE8KEHWHdAQhVQDa9tCKwDaZDsqgYDyh3MrXXaS4W1oDRdqDHsQl44QPgzxH3V8Zl/GWIO1hM1K12QkhHrztjiIhEAq2b+lvt0IkRQ10KBX+yysGWT3krUBZ9KDsmarptBrQLt7j7dhtDkocqn7gOKbO/lDvpKxW5FYk3XlXN/YWdidu/SNRe5CcXo9Fe9K57WZTiAshXoTFI285k9/FxmIbOCfa236ls7y7UKJ+OsdyCPh/GztvIgMzCnP+RADyRKvEJ1uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW59TaqKQGNO7+jrRiQG6KPOUjDx4MFlEbe395jF1+U=;
 b=b1hlLhMv3voK6I14YOZO7QJp1LBhIND8xHyCREakTR2U+ttCtdqMI3MhKLOMzaThVp6ujmrnzEjzbt/NphabfH5Nbspp4WzjOEGQvAGgvoTJd79MxgiAQWQlyJ2jUodmgvrLxL+aKCDfV971gUQ2vkarGWnbvAGE/L4Wn5HFxLqArd3PZvDrJ+LTEUBu6uPhFN2imG0olTSVqB/R9wnBO3IOxqGM3E205O528bT9xtL47uGz/hhd/d9zA3tycOyy/IGZxF8fiQNinZGu4RHzF/35lhhPP0GvgzcyzHScB8jrQ74J71wotdAshTdrrXsltZxPZ2vr3v2hRIy9XhXgqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 02:22:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 02:22:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 11:22:33 +0900
Message-Id: <DCPM31MOC3A9.25PT1N4AVJ5WZ@nvidia.com>
To: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>, "Alban Kurti"
 <kurti@invicto.ai>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250905140534.3328297-1-lossin@kernel.org>
In-Reply-To: <20250905140534.3328297-1-lossin@kernel.org>
X-ClientProxiedBy: OS3P286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: db35b593-95a7-4bd4-59c9-08ddf0da12f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU41SUg4bE4vZ01BZi9ERGRtbGYrckg4M3dXUEtJR28vWkpUVkRFNFR5NEQ2?=
 =?utf-8?B?VTB6YU50RlkzMko3WlhZb0htOFBlN3BoZC8zbmhFSzdvR1lNWm9NSUJYakNj?=
 =?utf-8?B?WVhCZitrdDE1bDJnUEI1aFV4SUx6MUlxVjBPYXZ4NDJES1RzTmtZbUdoVE9B?=
 =?utf-8?B?Sm43N3BwWTQvNjZIRUdwK05sYytXSHUvUDdNNXdnUlprYkZCL3RiVzU5Yldy?=
 =?utf-8?B?Uk0zM1ZkQVNGREZhZ0VHQVkxU25RYnh3enpYTDFnYmVDZXhvQmJzcWhCOHMv?=
 =?utf-8?B?ZWNQZytJeHo5VGhhTWZGZ2dTaU43QUFTbjNRL0k2YzVpeStnN04vb25wbUYr?=
 =?utf-8?B?dDJYS1NGWTVZa01KZ2hYWGxHUXFkNlFXbGhSSXFNU0E3TlBNU3FxZ3F3Mm9R?=
 =?utf-8?B?cDlzTEkvODdLbmUyNmxOK25vRW1RdExwOVNGNW16WTJaalRuQU5mK1BMdDhO?=
 =?utf-8?B?OVVaY0xLdkR5a1paN1JHaXlnaWFsdTYxbS9lc1dNbTFQTGZzWWgvLzJHTnlz?=
 =?utf-8?B?dU5hT3ppNGNEZ0N3T3MzSVJtb0xvM3YvdUJHTzd6cG1maGk2S3RaL3IzRnU1?=
 =?utf-8?B?UHNkeTlqb0hkQkxVczlDTDlHQUcxbHVJK2pEMnBGZmRjenljbXoyYWNnelFR?=
 =?utf-8?B?Y0VVNTdXN04vMzA3MDIyZjJHQ3dESnBDSytnb3RucHY0YmQ0MFNjY1kyWGQx?=
 =?utf-8?B?NEo0ZGNkd0dMNkhCb1lmTzE3aDlRS2x3OCs4MitJcFFpdVhVcWxhVE1XRHNu?=
 =?utf-8?B?ZGN1aHR2cHJkWXYweU5vRWh3RlNIU2NDMlFvQm1PK3FYOW5CK0hNRlVBUSto?=
 =?utf-8?B?cjFpZ2RpTml3djltU0ZSMmxBTVptTW9ma0pPOEFjOTZtZmxGdWpOQW4xWlEx?=
 =?utf-8?B?MXpPV1dJa1plMk4yUW9uUnFYOFlqRStkSXNWM3JpRFhIaGVqR3FtQzhLeUE3?=
 =?utf-8?B?SkVSMU8vTUNMd0FCdy9reHQxMjZ1eG5pQnE2T1hLOW0xYnFBanMrbG5lc1hl?=
 =?utf-8?B?V2J0TVFUK2Q2QXNDSVpLdUpDL0VNTUtMY3lwOGJVcGxMRTBVREVDQWUvdlZl?=
 =?utf-8?B?bTJucFVkRTM2cXowTjlsTXlXclpNVXJXNmk0cTIrb2ZlUXBpWEJtRzJCQXlt?=
 =?utf-8?B?MHZnMnhoQktTUUloclNRd1lPY1FXSmNvS0tiRDRtZG9Qa2h6Y0NKUWlBSGtX?=
 =?utf-8?B?RER1OForRTBDTGhkVEp2akJXenk3cURNVzl4WHluVFU5WHBmU1M4VzRSN0tp?=
 =?utf-8?B?Ym9NOVlCZUVMaFhzMTN5U1BsbjltMFcydGZ5V1phSEJLZ0plNWdINlllMGRL?=
 =?utf-8?B?eC9mWlJ6QURwbG9sYTdZVERzNjBkem1OT0VtOFQvbEtiSysxbjM2a2QrTDFP?=
 =?utf-8?B?eUJPNGpUbndqSGlQTUc3djRwejZWZXd1SlVSeTlCTUxQZ08wVytHRkVsd3FN?=
 =?utf-8?B?eG4wQ01UZHIxcEpVb3RDZitWWkhxZXgveXRxZU1qMVUzUGc0d2VWQjdBOW8v?=
 =?utf-8?B?N0ovODU3aVIxMXpPSjhiNUVCTEFPT3lnT0xNQmxJZ3Bjam9MTFg0aG5QVWtM?=
 =?utf-8?B?LzVGblZvMk5na2ExWEdibHNMM25RbkNtc0NOVHVxOHAwMFB1dGJlSXRRa3Ev?=
 =?utf-8?B?bFJVM1VaeUMvVWZPUmd6T09maDd3bmdMNTdJOEwrYy9ERzV3VUpldE9yQTJ5?=
 =?utf-8?B?WGsrVlhtRkljaWdENHo3T09XbDkzYUtmN0pWUllOV3VGRnhUaW1uU2tBaGRB?=
 =?utf-8?B?ejFrNEJ0Y2k2anJmdzRYVlZzTEFTcU82VkdlNzNlQmVyTngwQkJhZSttdEw0?=
 =?utf-8?B?bStLZURxTWNnN3UzV3drNTJMTGJUcXIybFJZME1MZFR3eEJzSEtaMUNPNDRU?=
 =?utf-8?B?QWNMOVhmNUF6dEY1elRtVU5FdDhsOWhNSkNpQmd1UFpVOWYvTEtqZHBYb0Ra?=
 =?utf-8?B?SjBjY3M4aGpveSs4TldPTDA4SWhjSmlCcVFtM3VTWDB6T2dUWlAvNE0ydXVU?=
 =?utf-8?B?WFN4aWtTMGNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWNWNmZiczVZdzBocXV1ajNxMis5V29XdkFodU0xdzlWcGI4c05ncE51VjAv?=
 =?utf-8?B?VytsOHQxVGNrd3pBTTFBSWNKRnBRWlEwZW82ZUZiTllGWk9Vd2FLUSszUEox?=
 =?utf-8?B?QnZpaVI3TTNPekE3M09SQ05HcjJHRjc1N1hHNysxdXdjNzRTVktvb3R5YldC?=
 =?utf-8?B?ekdacHZSSHRaOG1waHAvRlcwSm13ZDZnZ1A2a05IYWhwb3N1Q1lTOGFlbUFr?=
 =?utf-8?B?Wk4zQnBSbDA2Y0x5SG1iYVdJU1dzN3BOUm1SV1VJa3Vjc3FBWTUxb0s5emNi?=
 =?utf-8?B?bkZDc3FqZDJKSDdLVURzZDBxQWt4azM1VnFsYWxqS0J4Tkw3SWhCcm5KZS9G?=
 =?utf-8?B?dHlpYUlYdHlMdHA0RUUrbVpFNkNBUEN6RDBjL0pycTdLUXhhaEFWUWh3S1JR?=
 =?utf-8?B?MklITXJGUTdjVC9BZFBIT1dBWmVEWCt6OEZyUE1CS3hncHI1TTdRZzU3VitD?=
 =?utf-8?B?RUVrM1NvTkZZK3p3QTltY3htU25DK2RzelU0cEtmVTdpSnN3R0FlTDF2RGJ5?=
 =?utf-8?B?d1lZY0w2NFZQaEJQMlhPTnRwU25nNE91MndBazgyYmRhcXQ5QUxET1dCWGhL?=
 =?utf-8?B?YVUybkpieTZHaCttTW80Lzk3TUNrVTZmcTFGL1lSa2dRbEdYdG1HTG44dXdK?=
 =?utf-8?B?b2VFeHJhU2Z2MTVaUkwwZllVVktEcDNvS3BLVzRVZmYwT1NLZ1lBcW9jVytw?=
 =?utf-8?B?WXkvbFdBYnMwM3VFUitnYlZQK3JMUzFtUEZjOW9RZFgzMG5teFBhWGVCekZm?=
 =?utf-8?B?VDlHUllXSTNyM2kwc2J4MHk3TGZQM2M5dCs2UERSZUFZaGhKNnp1V295Y3cr?=
 =?utf-8?B?d09UbDdibUxHcDNtUE9VY28vbkhTb0Z3YUNRd0cvZFEyZ1hxalJ0NzlmUlNu?=
 =?utf-8?B?Tnhsa2swcXd5NVYwUnZWcHRtTytlYzNXcmtyTVd3OHdxOU1CVEw1WlZGOTFj?=
 =?utf-8?B?WGgxM3oyaGdFYWZCN3NoMUgrblZkUXJvWFBKcHJlREhKTWpDNGhzZGtIcW5U?=
 =?utf-8?B?NnFaZzJ5Tll4dExUeFF3OXB2VGlld1dGVVJsVTBTQmZOOVZweDhxalB1b2RW?=
 =?utf-8?B?ZHpnRm9iTi9DQm5WMWtpSEZsV3U1czdsZUdjeTBTa1p2d1NmVUgxeUVBL3ZL?=
 =?utf-8?B?WjFvWGFhQ3hubTVod3Z1aDZHUmNxK3NjQjFiRGZmQWNRQnNUenZxMHJERFJR?=
 =?utf-8?B?TG9IWFBLMXl0QWhCTWFnYlBlZ0w5NzJXVkxrejVOUUk1WkJabEttOTRFeTVX?=
 =?utf-8?B?TVQvNUtEb2tCVy95KzIzYk5FZ1NKa3dXSUFzYk03YXdsNko1RE04czBvbHVW?=
 =?utf-8?B?aHdYYktrbE9MS24zUUs0V0c5UStpa1k5RFhyd0R0RWhSN3dzMmRxWHhBek5l?=
 =?utf-8?B?aHFoQTZZNkNVWStpYnBxemRDRHFFMmlhQlRUeXFvK2lqREJ0UlJCL2oxUHV3?=
 =?utf-8?B?eE41bW85Qm5EL1N1ZWxFSlF5a2NRMDhCQW1ob1RkNWNZVjZtb2o4VEU2Sm5m?=
 =?utf-8?B?dE9MMFpVQ2ZTVi9wU0tvMEpTZ1BNRFZBTzZzMEFZUEVlcUkyQTJ6aDhicW8w?=
 =?utf-8?B?ME55dklNdWtEUjZGamJYVXR3bHdBNDZmcGRhdEJCM01maDBCZWhNcnpGN3Vz?=
 =?utf-8?B?Y1VjMDZqbUZ3Z2hsTlhhTE9DTzUrNXhGeTJ1ZUwzWkhkUlRKVjhpNXJjcjJ2?=
 =?utf-8?B?NUlITVl5S2NUQzJLaEJ6aHkxRndXaitLa0VzUTdFRlhpSUJkNTN0WVdzMjBh?=
 =?utf-8?B?cm9tQjhzT216eHJSNHNzTTF6SEJFS2dkMVdQKzc5K1hFeFZOemgvS1pYemRI?=
 =?utf-8?B?ZElKWkdNbDZLVkFGWEI5SDY5QnhkN052aytUM3d6VnAzZTFsOWNxa2RqWmtV?=
 =?utf-8?B?MVB0V0JSTERHSWNVR1BwMG5UdUpOOHJGd0RYZUlWNGIwUy92dTZSMXNBNHV4?=
 =?utf-8?B?RUJpVlcrdmttZHIzY2tyWXhueW1BODJLaEZ4Y1FxRWlwM3hoaTJSVXJHY01x?=
 =?utf-8?B?RnJ1Z2dreC9KaitXd0NZR25wdkNqSWpJd0RtK0QrbEJ3RjAzNkc0Rm9RTjJp?=
 =?utf-8?B?T1pyMnJKaXFXQzdrRnAvTzhYS1drbHI1NzdieVBzL01hV2EzcmpDaVFRNm05?=
 =?utf-8?B?ZXNFd2MzMkkreEE0Z2w4UHRjM3hnRjExQTFjL3VQcDdmSlR6aFhFWFZiQ2RU?=
 =?utf-8?Q?r5/INlLMpnd5Aqgt0BFA1MV4G4Pblrnmd7ywFNvut7Ro?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db35b593-95a7-4bd4-59c9-08ddf0da12f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 02:22:38.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZYl26RxZhhUHP5570NjiHEYj8LcPdo2qj8R9FbXGeXURgNlHM6FvEHa4pmTy/+E+Tc5kPMkWyqriNzTNxWA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

On Fri Sep 5, 2025 at 11:05 PM JST, Benno Lossin wrote:
> Allow writing `_: { /* any number of statements */ }` in initializers to
> run arbitrary code during initialization.
>
>     try_init!(MyStruct {
>         _: {
>             if check_something() {
>                 return Err(MyError);
>             }
>         },
>         foo: Foo::new(val),
>         _: {
>             println!("successfully initialized `MyStruct`");
>         },
>     })
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b8=
98336e2d54f80715f00ce00f21f74d2f
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks, this is going to be very helpful for nova-core as well.

