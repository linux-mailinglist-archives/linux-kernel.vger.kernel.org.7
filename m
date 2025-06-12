Return-Path: <linux-kernel+bounces-683879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40181AD7320
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC0B7A69F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC65248F50;
	Thu, 12 Jun 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZHbKkem+"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686624A06E;
	Thu, 12 Jun 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736987; cv=fail; b=IY28JlEKXKyRQhtsZct7UeGGonNFgxhH0ts4wvuc/eig5Xs7ISkBVexw/UbB9kEiTt//wmz9//ZZKY2iHdXizIyCrXAl5cEEjbosHFJq9rki+jUd46MdU/yRHhnIXGrNmJRr+RQFEWfsgZrJbNmzT9nYBnqP8I+TBxiRAjUjti0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736987; c=relaxed/simple;
	bh=SVAAiqjkRndjSIxKDQrMZbe0zYrS7w1ssocWgT6wzOE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=STSPxv02SRymDiGtDdpoOvf3sNEm7hnvktoG0xVg6tuOikOq7E5JZ3/sK0t6QihLehiK7OzNzH8e0+/TLLemlPu7q8O18fNivBZfro3p85JuYrbnvV7ffefkguF6vgjlVgkdDdv/nHNyHcwYliDWebzmGjGI/SSVYTpHuRzzgng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZHbKkem+; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIcbRuuA4p7bxX/HNLlEEju44T+nWOf5oVcm7gR6DjMwZGokVf5dx64UuYa2PRsNoDoX0BFb48AsslnEQnuEzcXYptq+hoa2YZrk98sxZKsXl5FT0FVQJlOH3Z7+ZBX4L2q9Q9VrMlm5P81cJBmJzAosnvW2aFW01OXoxgQT8Fs81SG/r1dVgS9NGnqzcWB6muWdxOhS1gzTmEL+DYTvWYRHMcf543OgGBeASwp3jcjN4eRDea0tScnSCEyn2KniHjc27TnvPKInKNH8sEqwYcLp4ZRVKVMOXGiZI3cJR8KtAYH68LYXzv5hp3EGVRdebt8/SgdGtJR4pbQpckIJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYszY5mQllyUAJaWO+ZVLuarHoRHSrfIRpg0u4nsoA4=;
 b=sJsj2cp62+2A1YT+N7ujQ7s1TLmTz8+Ay9fp1PPujv65AFXuT0h2tRYj8+cCKGnrjCbSeKKbfJJjPKt0FXpE4wyN9hOAiaKdqCPv1liv7UahmQFzhdNU38N0hqpaSOwjk3xSVLRf4o/Xfd6nYh8DwwT+d+ujaZPekrTly//p7cXPr6OwnAeU6LbrlNzfFSKkbD5g6yucnG5KnS33RLUqZgvUtdVnoarMoz+Sh9nH0hLbxC/BX4dntS2MFIDLJaDruOyhbEwgMCNqYM4ncF6Avft30GoBisdiBqC+GiH+Y4O+nRyX38HAignk9yk5IKXFuLMkyDQsE9IPxaMRU1SiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYszY5mQllyUAJaWO+ZVLuarHoRHSrfIRpg0u4nsoA4=;
 b=ZHbKkem+o7v7y1Xwu/PGTE5+GIsJ02OQb9KSlRnxU4VAjQOjFUKKHO0raABU6h7RTu07AgyHQPBSZlqCzQEB1n7TmBNnGTqav9/h8OPhoU95DLGrlNecVrlOl+yitbPP+Tax5ZznnuQptAHYxMdv4Ak5m1Bj0MsP2wFP6+LitdJSMpTd6aiwOOuQ+jF39OElGXverqeLDKgyTtdWZrnbSqOmW7TqW01lP44eqVLNOMO5dabiAYahDmrsRTBhzrEIqADymKz8lFrXo6iXnlWMRlYJuXUI87DTXuC+mKFeAxdCxjJp1zRfz0ltZuPawH+8LieJgFXorRvCPrbRaHOQEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 14:03:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:03:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 12 Jun 2025 23:01:38 +0900
Subject: [PATCH v5 10/23] gpu: nova-core: increase BAR0 size to 16MB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-nova-frts-v5-10-14ba7eaf166b@nvidia.com>
References: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
In-Reply-To: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Benno Lossin <lossin@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: a5982ff8-3f7a-4433-7304-08dda9b9d8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJkaGI5cjA2UzdhZXJtZmZaOGtGdmJrMW96QUZkU0o4Wi9tQWNHM1cvdGJv?=
 =?utf-8?B?a3BpMHJjTURBVERNM1RWUnV3SVJFcEtRNjlYVDBhTGFVNmpBbVZNV2todklI?=
 =?utf-8?B?Y1Q0eWVJc0tFdEZLTE5VYXhJQ3NDc21YV0Nsa3VSQVArWGtGaUFReTEyWTZX?=
 =?utf-8?B?S0VsS01TbU1pLzlwSUJLUHhWUjNGdW0wWVM0TGtEUnpzN1JMbWU5RnljU2R2?=
 =?utf-8?B?TnhzNm1wK3FxTk5aV24veDBndEMwL0hwUWZOUGVXOGpwM1ZaV2h0WURmM2w1?=
 =?utf-8?B?cktVVHROM1IzQW05anZFM1d6MENrU3BwSkdMSHRqQTVwV0s0eXdUNmVRYWN4?=
 =?utf-8?B?Um01Z0pLRmNtZElmTHpINmJVdjVDS05xMzE4V0MvU1ExN1Bjd2ZNd3hDMHZS?=
 =?utf-8?B?UWNwaHlWYkJTOEJidnM5bTZpeVlHcWZ6YVBTV0xtL2VjZTA1dnRHWis2N2Vn?=
 =?utf-8?B?NlYyOGt5NlNTQWMyLzRIK3dwSDdyR3czemdSaW1rRFBMREI3a2xML0poSnk2?=
 =?utf-8?B?bDhKYlNuaVpuK1ZDZ0FiVEpveTRONzYvNVA0cDg3TU4rYnZvdFZGYXAya09N?=
 =?utf-8?B?c1JFWEdiZnphdjl2bDUyQzViOTdiYUhGQ29LSlJpZEozaGc3dEUxSjlUZEFL?=
 =?utf-8?B?ako4MGtvczRndlB1R1JFNFNpVVdPYXZtYUIxdWVFN0lwNkszajFLc082dUFL?=
 =?utf-8?B?WVI5eUx0MFVxQzFEdEswV1VaM2VYL0loVkZISmM5M3kvY016MW1WZktBVCtL?=
 =?utf-8?B?c0h1MGkyMUdXYkZsTEdyVldTS0ZwRlF6R044TXI4eXVMUVh0a0RjYjI1czRl?=
 =?utf-8?B?SFFpWUlhdjB1NmxwREJ0NVZEWjhYTzNBZ21LSWpYQ0RXVUsvdDBlWXpEZGxv?=
 =?utf-8?B?Vk5oYjJJai9JWDdrRHpxWU0vdEcrbENhN1hYcXROWElUMS9UWUIwc2RVU09m?=
 =?utf-8?B?N0hiVFFwb0JLYVkrZjFlOXlmbTdDelJMNElCbDhjOERycXJLUGQrZUwvN0xx?=
 =?utf-8?B?RGNHS0RSRUdvbitYd25DNjRNNEY4aVl1ZXM2VkFuODhadFNFaHNpMFRPaGNi?=
 =?utf-8?B?UG5zZXdwbnZuOEtXdGEweE1OZ3hPbzM1MmlGdlV3WGw5YWZsVlhuRmhTVHFP?=
 =?utf-8?B?dXJRcm54cWdoKzVoNGVMNEFVS012U1hncUZCa0dsdFprYlNCaFRuQ3ZER21T?=
 =?utf-8?B?QVFHWTY3M1BLRkxvbGRocHhPckhNMmRBaFJER0xYeWwyNWpWQUtyN0ErZlBZ?=
 =?utf-8?B?L2pKNGlYMmJIYjgvRnkrYmg1WTZLd2JlM3BKSEswN0VWemZKZUtrY2ZKSXZX?=
 =?utf-8?B?eEtYY3duL3pxem8wbDcxQVVmNzNIUnIzNU01WDR0S2haQUVDZnk3bVQreEQ4?=
 =?utf-8?B?UzVwSHVOWFVOR1FMMU5hSXNBOXMzR01DSVQ1VVQ1UWJSdnQ0ajBYM0ZIRmxM?=
 =?utf-8?B?YlFxdlliNXljQXFYU2NqazBaaXdRcVI1NzhzOU12NzNsTjRoWm5penlpQW9K?=
 =?utf-8?B?U3BEZ3JDZjRxcWJEaWRWOVdRRW5GVHpWWHlSQUNIYjd2bDdEaDh6dUFiOEtX?=
 =?utf-8?B?WmRTNE9VaDUyVjZncWV5RTYxNWpvQVlpKzdmWmIrVGFVOFNjazk3OXhGVTZH?=
 =?utf-8?B?TEdnOTdwTUxaR29IbnRad3VHYnVkN0tyV1JIWHNJZ0pqRWZ2NmkvbWZhTXBt?=
 =?utf-8?B?M1NLNDJ3SFB1SVRaYlY5SXE5dVNxN2MzNWxLTi9qZEwzdjh0bGQ2elJwTFhO?=
 =?utf-8?B?UDRLaE1LMldJYUJlQmFTS3VxUHNNNHpQNHhXeU9IM1dIMjlXdXZBWU42U3R1?=
 =?utf-8?B?SXhXM0VwTi8zNHYvbGx1c09hT01zem5NbkRsVFU3K2RPUGhlM2xmMFVIaEcr?=
 =?utf-8?B?R1ZuS3lTcVBwc3REbjV2NGdRczBCWlIvOG9RYjJsRFczcnI2Ny93WEJaaHRy?=
 =?utf-8?B?ME5kdU9qeDNzRnRNUGhDRWw4MU44MUF0ck0xbmVrVFYzN0YrUjJVWWYzbXI3?=
 =?utf-8?B?Y2pkc0k0K1dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTNMeVRKZi9vOVpvQjlqY0VvWXRYc0VvR0YwMUZ2SDh5WWU3dlNPWC9PTHRi?=
 =?utf-8?B?eXVqVUJLNEV3b2FzSjRWWWo2cm1pZXVlOS81ZFcrS1ZuQm5WY2UwMFg3OXBn?=
 =?utf-8?B?NkNpTHg1THI0Tjd3WW9QQzZuNkIxSll1blgxVFlaeE1PUWZ3RThlaTM0T0h2?=
 =?utf-8?B?QURCeXc0eUJLK0N2Y2hYMDdPWUExaWtDeDlhWFh6aFhydHB2SE9VWDBCcVZ4?=
 =?utf-8?B?NVRTY3dwd3NpT3I4dUFSWGdEcmpPZnU1eDJiMmFnV2piRXdtZUI5Z3NITzJY?=
 =?utf-8?B?WDdlZkpsaDZNVGxlUHVGZjV1NjFZM25naVhVTXZEQkZjYUJtczJrNW5CdmxO?=
 =?utf-8?B?NURrMHVwVE5jeitnMysxWFpCLzhHRUwxUmxGazJlcm9tUms3RThRQU5SN1ZX?=
 =?utf-8?B?TXViSnFWa0NlenY1MDZ4TVJPWE1VN1l2Zk5VKy9hSEVRa014RFViejQxK0lU?=
 =?utf-8?B?V2o5ZnU4WFFIdTVsYWd3ZzlvMXdoME9JVU9TWVp0UVVHRUllV1NCSkZkWDJm?=
 =?utf-8?B?MXpGd2VkNzh0WXp4b2h2TVl4ekdvZlZMOTFaQVhkRGhjMlhMN1QxSlFVMmEx?=
 =?utf-8?B?Ty8zRGJDTzVkVGczWVlTYkdoUDltYmVsK09SbUViUFFjcHlaUDllK0tqNmVZ?=
 =?utf-8?B?cmNtSXNqdi9tUkpWcFZQMGdaakplbWRxU3RQQ0hURUlLTVhFeEIralRVQVR2?=
 =?utf-8?B?UVhMTldUL3RYZmVwT1diWnNySTZVVlVSRi9RU29GZTBIREFhRnF5bFFoUHdE?=
 =?utf-8?B?MEVZMThzdUFxNXcvSWJwN0t4eXZkTHJjWmJES0RkOWdYZWtERXQyalVURTVI?=
 =?utf-8?B?Mmp3bTl0NmtVbW42WXd3cWt2Z3l0eGFZTHJhTHBGY1JQc0RhSzhPMm5wU2ZU?=
 =?utf-8?B?QjNzY2lHeFVERE5nZkhEVlZtQVVERVA3STlSWUZGSDZsbkh2SHhmMjJ3R3JV?=
 =?utf-8?B?ajQrL1hjZWc4WWQ3NkM2N3RsQ0tWRyt6ek5EUmtMd0d5ZkJxS0pkbTkzZUVJ?=
 =?utf-8?B?d204amFyUlVrTWpmSVJDZmJibVBsMTkzMlpmTmFqUXplSlJnSnhGYVRJREtt?=
 =?utf-8?B?ZGJLT05Xd25uaEJHWUlaemYzNG1wM1RUaXJiZ01pRC9nV1JHeGtMYmQydU9M?=
 =?utf-8?B?NDB3M25kaU5TK3A4M3JVUHNYTE1VYUUvdnltNFRyS0FMRnJaeEg3czAxSFVx?=
 =?utf-8?B?OXVpbVI5ekVvbk5XL3RWL3ArYlFNL2MvSFpKeThzMDZ1SlZBczRNMkNvNzlw?=
 =?utf-8?B?U2IrT09vN1FKcEUvVUJ4elZ4ZUJSOVNaY1lPTC8xR3hPMU1WY1hTd01CY0dk?=
 =?utf-8?B?ZkdacVJGUHpEa3hkbVdkTW5PdjhUMk9aanh4NmZSWlArSk0zb0RkWHptYzh0?=
 =?utf-8?B?T0IxcFBnS1JsSFlNU2haOE5JNzU4czhtOGJKd242Y0gzdHk5bTdYYnNoNDF4?=
 =?utf-8?B?ZEk0cGNLaTJ4SUF2OHlnbHkwZkJrWDBpaWVRZ2ZVNTkyVVJNTmliV2pYZVBo?=
 =?utf-8?B?NG1rdi9RRmFBMnlxaERpejRYZXRnSStsR09Yb2JlWTdncjhwRnNsWnAveWdJ?=
 =?utf-8?B?dCtOUjdWNmNzZTZvRTJlT1ZMcW0xYXRJUVdTYVVJOXNRVGJSdElYYkVpN0s1?=
 =?utf-8?B?dDZMWTFiM0xmYWtQblF1NVpsT2l2d242M2c0YVROem5EMnVIOHViSkVlV3dr?=
 =?utf-8?B?eU1uNEltWFBvU2xTWHhJOVV6anpxZy9UWlhIR0ZmTXB2dUNOL1p2WENNMVFQ?=
 =?utf-8?B?UG5LQnp0QXRua2tCZE5XWXRwMFg4cXJPNVVkTjkvakFXV25XaGJvWUF6K054?=
 =?utf-8?B?bkJVVnNLODdVS3gxcjMwdy9rQ1FaTStFWXZqdi9DTlkxK3JYTWo1VjgvUm9L?=
 =?utf-8?B?bUFBbkRKMGM1YlRnU2tOWE9xc1N5bHFpWnNINDhQeVRHVjhPQ0JEWnYwTjJl?=
 =?utf-8?B?aHhWRUZ1cmlEc1BvblpBWi9pL0xLWTJaUlIwa3pmQzIyUjZtbnRLOW1MeW9Y?=
 =?utf-8?B?QXF2RFYxeWJIU21rUHdEd01sVFhtZkN0RHFaaG5xUlhEVmxrZmRlRXM4UFMx?=
 =?utf-8?B?L1cxVlIrb2pEd2NkbDBLdERFbFpScVQxVk5SUGY2S0lrYjl2aHg4aDNodks0?=
 =?utf-8?B?SmhzUzM5ZEVRbGlyZ1VhQWJrZzJMWEkvUTZjamZzNkNZWFFMVGxkRmM2c2h3?=
 =?utf-8?Q?9c2ew5vS3l63sNHaGvZ7YrTJZkccPi6NKPj1COr5Sev+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5982ff8-3f7a-4433-7304-08dda9b9d8d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:03:03.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRDxwTPmvad/aFKYj+J0rgxKzkIkS6Ugb705SpH9Z/IV1hhviBzPq522VEw8veWI5U9+VzxgosPwFl6eW5vVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

The Turing+ register address space spans over that range, so increase it
as future patches will access more registers.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8c86101c26cb5fe5eb9a3d03268338c6b58baef7..ffe25c7a2fdad289549460f7fd87d6e09299a35c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*};
+use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M};
 
 use crate::gpu::Gpu;
 
@@ -11,7 +11,7 @@ pub(crate) struct NovaCore {
     _reg: auxiliary::Registration,
 }
 
-const BAR0_SIZE: usize = 8;
+const BAR0_SIZE: usize = SZ_16M;
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
 
 kernel::pci_device_table!(

-- 
2.49.0


