Return-Path: <linux-kernel+bounces-743883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FFB104FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CB816886C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312E288C04;
	Thu, 24 Jul 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NYAyhpAu"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013016.outbound.protection.outlook.com [40.107.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF4287507
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346796; cv=fail; b=LgfKccVeUXV6S6pIyVNvIRbCK8Fw/GxXMt+aPQuCOVIKipxyb1Mxe6jD63oBHlFMl4DqzCMg5fkleAl4Ax4WxepOox8ifsZ6K4UkqbNvNApqlDHUCHwhCejUTpp6YXlrx8rE5rxVURkVaIgc9Qwju7XKjEh9Y1ZyOCJ8kEiv21U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346796; c=relaxed/simple;
	bh=7ZmZvtSp5iYqkaPm3LpbNT0nkr6iLUFW+9FVNUCNCFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rA40SrkPBWdqpVSGzMWQnwutto+HVkai1g8WYkfD+rlsz8fjUk8SkwWAb1tyniLnoFOdLAtz5QmteJwy+KNS8Hr0armal/5l96EW33ibrCGg5V1TekcUIUtjQW1IH3UhYf7LG13i3mSxnjNrCFCfbgZhimOnKf17izXH5+TK4Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NYAyhpAu; arc=fail smtp.client-ip=40.107.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLKoiZUo3aavabzoH3W6HZyZ3kL2Qf9NKKzjU9y+xxZw4iQAd6HhDHdBopigKfzLs5T1LT6agXlMZHqdfjo+pvlG3sJYY7rh3ldGp5RIc0BUUqNIBCaogMOPjADKCGsWirn/n+0OpVtNsXC/SjQzFV4rgJtVWyD8I7Zp84DeuHeQG2I0B6RVSxy7hCXgM7yRZKLrf2ZIC85l9Lr889/r5wL1rhdkl9vmSUQAKqAyPwZKvobxapHa85eOm+N5Vr4bL7MsWNhTVpDMDawKR5kF0Z439iMUQHC0V5PxRAXfjckFu726xBrfGW3IH7nLGUqSdHLR7/RB7U9lvMpE4BQbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeGLSosyYKQqsd8zPFFEKYV08ZzaFUYy3qnuI6KtOPY=;
 b=KZW8DyL97D1xbQ1AO9dCEyk4dmgUQ2eaCf2R5DhhBMiKUmpadcU5Ca8hSseXJNe9xwzbzrf2kuV7v74cwb07MiH+4vIQ33T0wcjjqltNLhuIF81b96lBsl9tUmzQPhm/o118wPobWgOpuTnQRsWVQxqpECX4vyFXXV5LRlPjuQKp3/kePa2xRZ39WpdigDfkxCmDzkNIg5csEuYBQbhbOvCEtYMEeFXASCuPoHmCXY94Lf/tvD6x2uKyH6TPg0sHO99YkAG/4ZIqD4cC1KPw7IXHJlpFGr4XWFesepGfS4E2qRJ5bG0XDxPTo/QFynMj8CYDLNyOLjivmzdt958nCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeGLSosyYKQqsd8zPFFEKYV08ZzaFUYy3qnuI6KtOPY=;
 b=NYAyhpAuwMcJxdhVyqenvdUTzitQ116c/lq9vVyCNr0oGmoAxpheeozD1w1pBeV9PICIbueKRwWKu7VcdhM04FAdL0pP5C5Skqlcf8UUHOxXbJOdbOMcxT2QZmr0FPJ6I7COS5hx+DCdjPHB5oELn2QHLgNWjVb+NkDkjLSJWKrb4H0bDEExerpiapXmP4TRY8ZytCGVeaEqyTZ9veFNkWoe2QZDwcqDM9gWTkbE0SvMOLoHdJW8o3E4Pcda7qV780TLHEsSXQm1sgT4b0guB2tstamw5tXDWqmyOXuxorjkfxKrKIImjS072wfbIzaigAgR5lnkEkeUwJmicHq89A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:46:32 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 08:46:32 +0000
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Huan Yang <link@vivo.com>,
	Christian Brauner <brauner@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [RFC PATCH 9/9] mm/migrate: apply migrate entry page_type
Date: Thu, 24 Jul 2025 16:44:37 +0800
Message-Id: <20250724084441.380404-10-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724084441.380404-1-link@vivo.com>
References: <20250724084441.380404-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PS1PPF2A261C07C:EE_
X-MS-Office365-Filtering-Correlation-Id: 79320430-d5f0-4344-d1ef-08ddca8e96ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9lYoGZqXYvpDc+8RbwSJLR3EuU22Van1oAqzd4DponrfI4u34IHAC+9CAY+?=
 =?us-ascii?Q?XPwJFTpGVBz7cF/2hRCJPfhbtX+N3ORjHo1JIq1w/AUs7lm5Tjv9xqzEH3Pg?=
 =?us-ascii?Q?QpbVKnLgLIZDGnwJ8LRdKIWg4MZs2k6xc/yjeSkurydDlUf2do9q+yrFQB0M?=
 =?us-ascii?Q?UKRVuFjirgngD85oByLrcnnoAbss4SL8zvTNyGfCl8tc8RC2AKDGQXQkbKQO?=
 =?us-ascii?Q?FA9ou2M6K8z+Gz0UifBDl4EwpKv8/Njh8eekhWGytOLcp0Ad9oTu4YuuvJse?=
 =?us-ascii?Q?7Y3//czHsFaVbc6cAFfbSxck4Z27YjDQwuB++KYFgz8dt1WQLXWPXrIbWd3g?=
 =?us-ascii?Q?hTN0546eWW5qkO/Nrg2O8j9nb8lD9usodHlxmS2jjypqictYVFVsJBnl6DHJ?=
 =?us-ascii?Q?X3463XIA9QhmFWLRbZo7IW07IpY/VzN3vT7CZw6k+ZhuOYtiBiBunQ4a9CmA?=
 =?us-ascii?Q?3cz7l1tseqsQE2/i/BldzPegoKLrQ+PiIu5qqoN0o4G6+B/GLe7UiCWvodJ2?=
 =?us-ascii?Q?O9LKtDDv0Uye+WVGBhKPZGoe5Uus64U+VIEKvhKJGIEFUvoJFFEcHFQT5ZSB?=
 =?us-ascii?Q?a02z8jIgWmAkKdz9RLwqa/kTivR46TyrsxAecWDMk8beMGl849l6b03HX5Nr?=
 =?us-ascii?Q?L7rkgObRkzJzHDtRl59IzrFoafSNbh/aXELxWd1DTksS3TIbNU3N0IWbgu5e?=
 =?us-ascii?Q?6p3QNjDIYsWFeMtfvw7FNmwc0KrsqSmmzk995wABgRXN5/9cZgFnFkLOuZu/?=
 =?us-ascii?Q?UTmThu70LVcSWobpeSMnt8gl2aPTqoJelS2oaYgQIntiUsoFmwpTCYYF+teY?=
 =?us-ascii?Q?CzA0J/0JpfV0unSCnxyvnwj6rtlke6K61+SLncSJ8iTf0DROggXYyCOdw2hC?=
 =?us-ascii?Q?vViZGG+44TTeohQMUv38K20mxg7li9iBoLCl3S9sjwnhgFy/YBN4agvV7wi4?=
 =?us-ascii?Q?GoTD8Vbg62tdRLecrlD7pEhtnFdb8PBB4MoQx8IfZz88D6yJ+JTBLpFs8iwS?=
 =?us-ascii?Q?sWSiqOvs0xdiurjO7m/rLnRPz/gMd3Gy4S+4RUPeWKzbfohYlNER1hNfPTUA?=
 =?us-ascii?Q?nKNJQBMpd+ocsQz7Wd1eZHbMlwKLwKVW9YZ8B80A2onAQvbm8PEx64AmIo+p?=
 =?us-ascii?Q?rftXXD0rGcHc+hh8qxPz15lbENF0hxEjIpesdATTC6wZYSX1eWLPcQoVeVM1?=
 =?us-ascii?Q?OsWFYJ6EDxDhRnxcpcyHvTW1w4mnPnT43aQdZLwTjYQg2CVmk6etUHy5Thi3?=
 =?us-ascii?Q?Be0rm0aC7calXc/VHi+h1YYwQO/voUTva+Qgc3CdnYcQYWRtFNaQiWuTxW14?=
 =?us-ascii?Q?gS1cGw9iZ7sDbg/e+DQbSfFb0QzVqz5b+75duHlYaC4N52tHRnc/rOqmwe9d?=
 =?us-ascii?Q?7KidVtpNf7Gfsa1BZL+5bTLEDlbPijlClZH3z0UzhgJRipClhvF3m8eYfSmR?=
 =?us-ascii?Q?ndzB43dJEErX919eWvmlqQky/U2hkEVZId4RKGNXRidD35UtIrQaaUUYJLYM?=
 =?us-ascii?Q?C0qb40Jkl7HIkQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aOeCIFtqjagl6TvXrHA+a3BVDmRLOJPNNJ7PbogCqP1whvPrNhCyCUOMnCjJ?=
 =?us-ascii?Q?fkwJoZ53yYG/y2OmJNM/nO5iejYP/yrFLY+kijiRljXFc6kzg6XQyweKsHyW?=
 =?us-ascii?Q?KDRHVJ0/2jrCij8oVzGh/bhBeCSX0qqH6WAwQoyseKfgn8761KrF4/oj/CqH?=
 =?us-ascii?Q?5lKoytspcxDkNAkk/aPKHF1Gf0ZtRm6bFitjwQOr+h+kNoKR02eMNguMy5C0?=
 =?us-ascii?Q?XLB5e6d7cxAx2uvvjOsRaufdx5NQwejFX9d+abKjE8Y9w0mjqkdCYI7HwIxg?=
 =?us-ascii?Q?v0LyEE3O5gkDz+TPqDHoBeL3/z/JSVkmC/Gx9kVdkRXEmotrO/O1aQ7B53sp?=
 =?us-ascii?Q?z1Wqx3eHg2DNP7CZfvPYG462dk4ytqntxBocJM6sP4Y0bNu3kcdBYcPjMxFB?=
 =?us-ascii?Q?jicFeBDHaicIfk752o9Qs53G234b1vty9jJdc8CzUo918Q8/CbpJW1q+mx3C?=
 =?us-ascii?Q?+o4eTM8F4ykfil7FBQNrBGm/88BmtvsmA2dZrsaCDbp2KNQ6wZBC3TPPAk8b?=
 =?us-ascii?Q?9sciiU4nNxfOoRkVY++FeTrShq9ekyyirtPua0N6HSNXtF7tXY97JXSN3Lh2?=
 =?us-ascii?Q?5MijDN7Rl6fbV9sJ2rTu3j3GaJeXdGsf2ghd17KxI5Bi6DaiKCL8+aveEF/w?=
 =?us-ascii?Q?jxdMSfmGKPCAC+aaiQTntRZAqfBTpEqpoKWOL87De9V8jDOoFYCP6ELaYrEU?=
 =?us-ascii?Q?pNTxiAbXHMzQBsymzZHOwdyrGXLOJ/fNjpudbnhaaOwsEN+4W9XHjM5/KfyS?=
 =?us-ascii?Q?1X+qp2bsCK03Pp+yQEMMOKmTTvGAhMmTL8UhFz+CRwYHk4D23AfvYwtsb7xx?=
 =?us-ascii?Q?FfJiwtGzrOwue7tD2vDGX4tQpMm5/mOQln+h8COekaEaLejP+bkIHCtEpkWS?=
 =?us-ascii?Q?Cf8ZmUctpwearmxSh6I1+zI1gRmdqlbDjgowX0LoWGssVlN1LG3lS0aPj+xS?=
 =?us-ascii?Q?cTCh9XVZduwHcZotT9ua5tUgqsEYsy2hpWAm5r3/1108ckIvrkVwEGM5nZ57?=
 =?us-ascii?Q?KU1U1m00Xx5Blh0IhNymNe2+6zUMi6GUEBL4rKqjorWHXQ669cI+6XzeV+J4?=
 =?us-ascii?Q?+XBFy4P9JEWOkeV5x2EaH6UmA7WP5a1NxsKsApAZYIPWipekY0kDJ/CsXAG5?=
 =?us-ascii?Q?f33zK2EFZEi5hY22FdG3zJ8v8mMaNukZz0kQjDM6DwPTHqcFLKD/kVPFa6YT?=
 =?us-ascii?Q?BAxaRjtDB4NWJgDwYMQisU7k3OdTsDFWfqtlKc/EF2LjjjhW97hmjKfWncGb?=
 =?us-ascii?Q?CGw8EPvFS8XME9V+907TfdLcYjdCPT0Lt+5n9bmfBB7AHRDMihVk1TKhlps7?=
 =?us-ascii?Q?r2wQLoZM0JSsosxTa3FzvsGchvQAN4mCX/Z7ZQg20yRAc+k9H9r/0nIxwOQ6?=
 =?us-ascii?Q?dTF7pVO/qf/kRZsae80XJJ15ccqDa0aL6jWQ102aC5dKTG08W2OnR2vBx34d?=
 =?us-ascii?Q?uUvONBrWCtOE8A1R0Tdg2ZrxWl7rReWBIDI4l4gzcT67XYjvLxaxjUvZpmCO?=
 =?us-ascii?Q?6V0IQJQ8alKbg1si+7SdrrGHUd0TF4yd3gdc9Zf5tuynAveZKiLAoZY1SX+i?=
 =?us-ascii?Q?NIKEKzfLKzu0GcvJxDZV+bPiR9eQd4XE6zRX8SUh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79320430-d5f0-4344-d1ef-08ddca8e96ff
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:46:32.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIUzY5PXC5VbyhJ39CEoQDIDcOkWiiqjna22U92Mm9UhVhVFd/gUAQy3g9Q0qHwkMSGp1waWe06NM5vnuk2WQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C

When a single-page folio is already unmapped, we can reuse the page_type
field by setting it to PGTY_mgt_entry.This indicates that the folio is
in a critical state where no PFNs for this folio exist in the system,
with migrate entries used instead.

The lower 24 bits of this field can be utilized to store the count of
migrate entries during try_to_migrate.

It's important to note that we need to initialize the folio's page_type
to PGTY_mgt_entry and set the migrate entry count only while holding the
rmap walk lock.This is because during the lock period, we can prevent
new VMA fork (which would increase migrate entries) and VMA unmap
(which would decrease migrate entries).

After a folio exits try_to_migrate and before remove_migration_ptes
acquires the rmap lock, the system can perform normal fork and unmap
operations. Therefore, we need to increment or decrement the migrate
entry count recorded in the folio (if it's of type PGTY_mgt_entry) when
handling copy/zap_nonpresent_pte.

When performing remove_migration_ptes during migration to start removing
migrate entries, we need to dynamically decrement the recorded migrate
entry count. Once this count reaches zero, it indicates there are no
remaining migrate entries in the associated VMAs that need to be cleared
and replaced with the destination PFN. This allows us to safely
terminate the VMA traversal early.

However, it's important to note that if issues occur during migration
requiring an undo operation, PGTY_mgt_entry can no longer be used. This
is because the dst needs to be set back to the src, and the presence of
PGTY_mgt_entry would interfere with the normal usage of mapcount when
setup rmap info.

Signed-off-by: Huan Yang <link@vivo.com>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 mm/memory.c  |  2 ++
 mm/migrate.c | 28 +++++++++++++++++++++++++++-
 mm/rmap.c    | 17 +++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4a7695b1e31..f9d71b118c11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -861,6 +861,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
+		folio_inc_mgte_count(folio);
 	} else if (is_device_private_entry(entry)) {
 		page = pfn_swap_entry_to_page(entry);
 		folio = page_folio(page);
@@ -1651,6 +1652,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		if (!should_zap_folio(details, folio))
 			return 1;
 		rss[mm_counter(folio)]--;
+		folio_dec_mgte_count(folio);
 	} else if (pte_marker_entry_uffd_wp(entry)) {
 		/*
 		 * For anon: always drop the marker; for file: only
diff --git a/mm/migrate.c b/mm/migrate.c
index a5ea8fba2997..fc2fac1559bd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -241,7 +241,8 @@ static bool remove_migration_pte(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	struct rmap_walk_arg *rmap_walk_arg = arg;
-	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->src, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	struct folio *src = rmap_walk_arg->src;
+	DEFINE_FOLIO_VMA_WALK(pvmw, src, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
@@ -334,6 +335,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
+		folio_dec_mgte_count(src);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -342,12 +344,27 @@ static bool remove_migration_pte(struct folio *folio,
 	return true;
 }
 
+static int folio_removed_all_migrate_entry(struct folio *folio,
+					   struct rmap_walk_control *rwc)
+{
+	struct rmap_walk_arg *arg = (struct rmap_walk_arg *)rwc->arg;
+	struct folio *src = arg->src;
+
+	VM_BUG_ON(!folio_test_mgt_entry(src));
+
+	if (!folio_get_mgte_count(src))
+		return true;
+	return false;
+}
+
 /*
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
 void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
 {
+	bool undo = src == dst;
+
 	struct rmap_walk_arg rmap_walk_arg = {
 		.src = src,
 		.map_unused_to_zeropage = flags & RMP_USE_SHARED_ZEROPAGE,
@@ -356,12 +373,21 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
 		.locked = flags & RMP_LOCKED,
+		.done = !undo && folio_test_mgt_entry(src) ?
+				folio_removed_all_migrate_entry :
+				NULL,
 		.arg = &rmap_walk_arg,
 	};
 
 	VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src != dst), src);
 
+	if (undo)
+		folio_remove_mgte(src);
+
 	rmap_walk(dst, &rwc);
+
+	if (!undo)
+		folio_remove_mgte(src);
 }
 
 /*
diff --git a/mm/rmap.c b/mm/rmap.c
index 2433e12c131d..f3911491b2d9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2263,6 +2263,7 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 
 struct migrate_walk_arg {
 	enum ttu_flags flags;
+	unsigned int nr_migrate_entry;
 };
 
 /*
@@ -2282,6 +2283,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	struct migrate_walk_arg *mwa = (struct migrate_walk_arg *)arg;
 	enum ttu_flags flags = mwa->flags;
+	unsigned int nr_migrate_entry = 0;
 	unsigned long pfn;
 	unsigned long hsz = 0;
 
@@ -2548,6 +2550,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 						hsz);
 			else
 				set_pte_at(mm, address, pvmw.pte, swp_pte);
+			nr_migrate_entry++;
 			trace_set_migration_pte(address, pte_val(swp_pte),
 						folio_order(folio));
 			/*
@@ -2565,11 +2568,24 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		folio_put(folio);
 	}
 
+	mwa->nr_migrate_entry += nr_migrate_entry;
+
 	mmu_notifier_invalidate_range_end(&range);
 
 	return ret;
 }
 
+static void folio_set_migrate_entry_type(struct folio *folio,
+					 struct rmap_walk_control *rwc)
+{
+	struct migrate_walk_arg *mwa = (struct migrate_walk_arg *)rwc->arg;
+	unsigned int nr_migrate_entry = mwa->nr_migrate_entry;
+
+	if (nr_migrate_entry && !folio_test_large(folio) &&
+	    !folio_mapped(folio))
+		folio_init_mgte(folio, nr_migrate_entry);
+}
+
 /**
  * try_to_migrate - try to replace all page table mappings with swap entries
  * @folio: the folio to replace page table entries for
@@ -2588,6 +2604,7 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 		.rmap_one = try_to_migrate_one,
 		.arg = (void *)&arg,
 		.done = folio_not_mapped,
+		.exit = folio_set_migrate_entry_type,
 		.locked = flags & TTU_RMAP_LOCKED,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
-- 
2.34.1


