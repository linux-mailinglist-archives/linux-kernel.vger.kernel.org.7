Return-Path: <linux-kernel+bounces-754222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0FB19006
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A595917A824
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A4256C9B;
	Sat,  2 Aug 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+e52P00"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86B243387;
	Sat,  2 Aug 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754168439; cv=fail; b=ZYvx4zzoZoSjEjGwpcG824qfrsr49TctkXJPA4fF4zVuce4yE2wVAfJr0twRgtUF+G/Xld0M4kUrEhdP7V1Zdh4Uv9exO7vsT5EkBTGAW3+XLY1DxGN9L65UqOQnYY2OK1jsNE0pPqm2nFcWK+smJvL13OsIW8cT8kh3yT2tIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754168439; c=relaxed/simple;
	bh=Pbe9vpdqy3otcLxI2EN3MdGWadTpl3EKSje7nxzyzxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8qGO1i0DJQXOccx0FDBeJzzeDy7AoNLt0r0X8T9PAUUnq9jdwgM7H5db6NHEQnzV4dE6l9zFXsVrHfW6zuA1DuqdidOsO4rqz+eokBmQTWC+Kr2G+zUjZKQQQsWh5ZPWyRl2lYYRzDCTaQjGT9sQHiixCHur2YpNc1gjKAO04o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+e52P00; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd795IalxA/C/+dxApT4wQtCCv65zpWmnkujtLKUOP2m5K8g+fVOoau1Q2a3Ra1XwA0+QRqIzkfkHM57hN1b8q2YNQuEUzjQwuaXBj2ZRauZ+KgtAnQZ9jt7gIREtWBgMG4nnpbK+Dc+YhoAlHBPBTL2HUb50ZzZ7whRNtTVFAkJD6k2hEf7cYOVfDmvt4LJej7JlX+NbHWMFuRh2KD3MfdWPxqKV5OYq8MpfekAC3uodWL+2r61+hqrmFkTh30NrsePnYmTOQRAXR4sv6HvYF3L07/o9R4yqjhU1JVlapR1m7lFEI3NOWWLUAKWiGJ8kStbHFH0C6ETzHcfY7NDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZi4Kvt8coDgBmxn7CpqvPWEllo43zzMeu8wNPXgvAw=;
 b=lwPoNrfPyKhj0PQCfmRdvAmgKxenfIsJwH6FHSsljxu0cm7RwVreItmD+/3uYwR0bnF5Ek+OX7Z0Si+Tumkam1G0MQvdW1dVheL2OegMFFKBDDPpHlt527ntoxtcKR+a3O3CKWpSZfyWworeHcKLpnKWYfV+O/k431t0Ttpz3XMkQk/3oCgakKVBkxLsPufi8PzqURfrHorcHxuVb7yXTHX/O3c0iVbROYrBgZZL0cqfsl3322eSmoCYxAbMBgbuVVepm0C7KrEjxZ5HhoPC+dJJqW4gV1hz9ZLWcgBJBt2oRm/zmOlcc10Xbm/mK0IjlxKK9RDL0V3NX6HcXJ++LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZi4Kvt8coDgBmxn7CpqvPWEllo43zzMeu8wNPXgvAw=;
 b=a+e52P00Mby0qgY+oOQfFSIqrUY+09RHgP8zTMUnS61xe40s/OlU9/+a614O+fHFxUCAKt02jzUtwJyQwsZXYyfHWwBiZlgIp7iOmBV5Ndv0yGGwyZrhPHrB6StFRKUDrsCY665h5BIkewLoF9oEq9LmdBjdooKsiSyZAg4hHCOXozfqcrqeh9TnFX76AnN7kwJX/YrUi+/VGgQg87dBo+JNs138aTzANEHnktAKtwBXUA91n085O2UFrtzpBpY58+ilk/+9hQKAf7zkY315zPQ3s6MAAZaJYEO2cR8kutKNyArywoFvowoZhJp1jv5gvyWSkw8K8uNrqaZVTQ4MPQ==
Received: from SJ0PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:33f::33)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Sat, 2 Aug
 2025 21:00:31 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::e8) by SJ0PR05CA0058.outlook.office365.com
 (2603:10b6:a03:33f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.7 via Frontend Transport; Sat, 2
 Aug 2025 21:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Sat, 2 Aug 2025 21:00:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 2 Aug
 2025 14:00:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 2 Aug 2025 14:00:18 -0700
Received: from ipp2-2167.ipp2u1.colossus.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Sat, 2 Aug 2025 14:00:18 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <ojeda@kernel.org>, <alex.gaynor@gmail.com>
CC: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH] rust: list: remove nonexistent insert_at() from the comments
Date: Sat, 2 Aug 2025 21:00:01 +0000
Message-ID: <20250802210001.824022-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: dad02173-11e3-4425-9da0-08ddd2079dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ieZGzlgqoQmyXE/1XdXueBYBj8COsP9AIoAz1HBRDbcb79EhME3KOyLrPSW3?=
 =?us-ascii?Q?RyP46uqwPV2ZGBYHfMR4+Ot2CaUtTjIVB7iG9mjI7mKY2uCAHWXQZvgyWFQu?=
 =?us-ascii?Q?AJk9hV2f9yODUdsxbVTuStPRmqvfrbvPHabjb5ELqU03HY0Ob3IAREgi8qnY?=
 =?us-ascii?Q?s6brKtfP6O4L4+kscIwR2HUachbuU3E4YNr8qtW+7rx92G0OvY79rDTl0Izf?=
 =?us-ascii?Q?dNT/by/E6MUYBnhNWNe+bAlmmfVd/KeMCU7xlutSBzBqDd6+B9CNcVNHEACO?=
 =?us-ascii?Q?bdAYOg7dgk/8qq10Mush/gf91UTrvT1I9Yq9Oel5D4UoKSGlJ+7hgVCDbTbA?=
 =?us-ascii?Q?YP7RUFxKZfiFna4BTEjXoKpK6MMhBdK+qnatNeRuLzQCmNit0uAFS6TQysqI?=
 =?us-ascii?Q?8g+AFmVh2I2jcJi/xE1SWspm7f356WVj+6kWjzePr7WYXC4oRec6/vVwpbS7?=
 =?us-ascii?Q?OOowLJs5mQh2lCFOuAyVOAbcMwAC4Xsndo+dC0DAdlLUi/NUbZJ2Os3Pkav+?=
 =?us-ascii?Q?boU6UYtA9qjopHo1n9FRzIYQc3TOIBAeulKZjV1UWEFwh6w1l/I3KhZ7L29j?=
 =?us-ascii?Q?qGCeAzT9A4YsxzoSqotaHZFgZoDeAXiu9L5dx9Wx/diwqYi4XQ7AflgKaeVb?=
 =?us-ascii?Q?lOlH7+sIxHCNKDSo3JvFmuDvlWgzJYasZqaJIWHXL8QTdJTTMTmSAD/A8+fx?=
 =?us-ascii?Q?84qpa6CV4ViXE8G7LsyxvRX+QD+KJkblGR/T3vlu/ZIGc2js4WbMDQLuYf47?=
 =?us-ascii?Q?XjeLS3bdxW86M/UbkpoHUFG21zXLno7l9yaRkAIEYBAbO0RXgYiSlu5pDunY?=
 =?us-ascii?Q?5kSfYFgHx2Bc7iux558IFu7+b+AgyC84Vd4lpGKZ0PXKao8xSO+9w45SDlNW?=
 =?us-ascii?Q?MPkL6soHLFrapHcGS2bfzh8uksMhZhT4ZMkqyKq/Hi9Zuv/jlVW2DQLRY+F8?=
 =?us-ascii?Q?OasXfEsFq1QhUb/qBcY9xs8QWmKVeliCLu5rCr9lwuGmCBcNshSLFacvltNJ?=
 =?us-ascii?Q?BY+n2AuHa6dBCGF0pTnhB07WSw16jToyc0uI5riTUBblZsnRoblecM6vKOND?=
 =?us-ascii?Q?DXMsTMt1Yzbw0BUlPucycKg9E//1KuZATvPq8tSXQM3p2e2YSZfHimOMTvTI?=
 =?us-ascii?Q?0MZTg/910oZD2+YYmBHPVuI9yB2QyRpVPM0Lpu4lbtkK4e8scvoWIe0zDdOY?=
 =?us-ascii?Q?QewMIxFYRpyNc3Rf1XNNVGF/Mr/2oPwDtA96WmMTfi6XOtKj1FFleI0i7bgv?=
 =?us-ascii?Q?Hyuj6ywCYuJW5PwlrwGCl60sFhd20/3XlUQbhaOejR+3p9oAoHLnyFastFm7?=
 =?us-ascii?Q?skXnr0ClpCKmatq4AEGihoJ9g/owSFkaN1Q+9kJhRnnvaQS3PrcjK0uwLWhS?=
 =?us-ascii?Q?BRqhn9/BcnEwob6q1JlUfRRuiHejBG3F2C09FdCCYA9S7QbMzYEisj4lU6DV?=
 =?us-ascii?Q?AIS22VpBXjAnInP24NUMEc+k9hvIM8XClL/78k7T70J28Q5AbqgLFGtIQtr4?=
 =?us-ascii?Q?X0gpYNMVXSf0RjBHwsfjtevGcEJZSW9bCEHn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 21:00:30.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad02173-11e3-4425-9da0-08ddd2079dbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

The insert_at() method was never introduced in the code. Remove it from
the comments to avoid confusion.

No functional change intended.

Fixes: 52ae96f5187c ("rust: list: make the cursor point between elements")
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/list.rs | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 44e5219cfcbc..f40eaa17a8fc 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -761,19 +761,6 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
 ///     out
 /// }
 ///
-/// // Use a cursor to insert a value at a specific index. Returns an error if the index is out of
-/// // bounds.
-/// fn insert_at(list: &mut List<ListItem>, new: ListArc<ListItem>, idx: usize) -> Result {
-///     let mut cursor = list.cursor_front();
-///     for _ in 0..idx {
-///         if !cursor.move_next() {
-///             return Err(EINVAL);
-///         }
-///     }
-///     cursor.insert_next(new);
-///     Ok(())
-/// }
-///
 /// // Merge two sorted lists into a single sorted list.
 /// fn merge_sorted(list: &mut List<ListItem>, merge: List<ListItem>) {
 ///     let mut cursor = list.cursor_front();
@@ -799,8 +786,6 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
 /// // [14, 10, 15, 14]
 /// assert!(remove_first(&mut list, 14).is_some());
 /// // [10, 15, 14]
-/// insert_at(&mut list, ListItem::new(12)?, 2)?;
-/// // [10, 15, 12, 14]
 /// assert!(remove_last(&mut list, 15).is_some());
 /// // [10, 12, 14]
 ///
-- 
2.43.5


