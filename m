Return-Path: <linux-kernel+bounces-898437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E0C554DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65A6334837E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE52BEFF8;
	Thu, 13 Nov 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkrGtKmV"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD02BDC14;
	Thu, 13 Nov 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998094; cv=fail; b=bH71B1MRZGqDp3eZArAqCRQ2lOQqsisBC63GBozrNtDF1zAIsoaAOMa+OKJSkOOlp26y70CTFL8GmCauNbQfmZ7oMKJVm7kLE7Xnt45HvhJ1mWqx46QvgIXtWF4SaQvJaEdsd/HHdEuKsKSHcU/8sRXEjBhM/F2anIDjJV3tOxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998094; c=relaxed/simple;
	bh=LRtwJKiHAFb8XOH7T/nfB0lN5ucOfx5h8YY7e/XkWEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ta6W4CuCCvl87JJylsnnP4WaiucoWv8iOGHc2LMyr6mswrQFe/JITiy888WUrON5iox11aDq/2DHhKVa9trH5ahf/Ih2oVeCPkpISPysfX6igwRoat2oUndKZkV9xPH5Tbr90/ylA5PckJ6wdaXVhXjDrqFUn9GmA/5/XbVziqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkrGtKmV; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoedmXlpP+0IoKRv2ssOBF/qcISHkg8vvWPGAfGRVXcDB+sbsjJ/ExO6z+4JTqt8zoBp1Kz9LpJLOyDUaNLow0k2ImZULoH26UuXYoq6bDl3S32mAIkMshSgtGsRlRPoXc4tZHUV1867Q5gEZ83LoLx3jlwxvdaVKlcnWUeB7dwq5IKcwiyBR8VaizULDgvm1oSZZM/hnpbXKMzqyVbNW2/EyTCO1l3klU4eBJA5UMx/oPvMCWs6BBz4ql2LAmkC8UsZHm3uuSoZcVp/lQOTlhv8QvaqNEVGOxuzfjfts+vJNyZb/tYBkcn1Cu+fL7O62Y+pmMKARHVPZcyFYF8C9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AAu1lYzxbvovD97emd8njkeSBmyc+qV0jKIF608lrw=;
 b=nASryJ5Dcbnf0vdY+37yasRGhsh7lKO0gFYyu2Ps4nLzjk4YB9Ap2R4oKWlgzZ3r0w8D62aPk9VkSilz8HO6l53I+2KkKCPILfUVjKlu3fFUj3bkVs0ZKgVm6CVxtB8nSPbZUyJKKZ+MhIa6LiXfHJwAASaeJHBj3+qnzHqa3YbD34CF2iQLGbmQssUtJd5lem2o+4viy9CneaD/OGjCcBBTnNDirY+x1+XTMm1gnZspAX+5gGOLX3+U7M7rN8hI25GxiOmKBVKM/mu6HS5y69i80TYrssAxMXf401X++GWcGqrDQgi4/HXRXPlmjuZX9LWD4Mp2wLwsjVc3PMGofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AAu1lYzxbvovD97emd8njkeSBmyc+qV0jKIF608lrw=;
 b=TkrGtKmVwP+S0NtGzQz1rfMQJxyte66M+LUqbxqWt1iXmwHmHyj5+MT80av1HunMjyg5hxYcdDCTYRq92JOd77etEvwRndokobYB0kerWpCp4ycWJmRGxT1vRG9A3L6sDGLAGHDYQxsMMD122UGniBvihfzOZze4S1ZZQvhcs1RQ0tqql6QpIGpb6lQpUWvzlNOUoYpKsFGjYKC3Dr+WZC87Ri0Hi4HAM91WU/JvhI4bD0eQPJ0vAF1Zmb1alNkfFKD4Ygc0ggwuDLCsXrDOUDv50Kyh+7PRsrpuHKFPkFKXOfTY3sPPbJ3yvzRDpyRmjNfSJQ7WcnZv5pmh3Aq6HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:41:24 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:41:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH v4 01/13] gpu: nova-core: falcon: Move waiting until halted to a helper
Date: Wed, 12 Nov 2025 20:41:07 -0500
Message-Id: <20251113014119.1286886-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113014119.1286886-1-joelagnelf@nvidia.com>
References: <20251113014119.1286886-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f151bca-6ade-4917-9017-08de2255c11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gcsc38WaVEppv56glAC0CT3dsIimU7XoMZ41jAjJagkbV+hbSHq8Vz4MdtPw?=
 =?us-ascii?Q?jjo4gwADP7515fdzllDvAMIl/gFHNDECTcG/nrJ5klVUI4gYM0o+5oumzn98?=
 =?us-ascii?Q?ssqV1gdNvOEvpB+aeygumb6QsTQHnevTDjITUCu1+QkfWDbUrbmyCq/Om9oj?=
 =?us-ascii?Q?eEgq0yZY9n5IAmS93BPo3h8bvegZFTHiGx1J5AIRi+i85m8QbQ35JIPPIHDT?=
 =?us-ascii?Q?y34DvXQOwa9HHC9h1AXOCL8yxGVXJlRtsY3KIdRGsLavKpm0xWaGo7f+O6Hi?=
 =?us-ascii?Q?vK1mNJ+wWRR5EQ+VdXoAzL6cG1jqnOFJrf9Ycs97Wo8TeULbCpulgC5eD3lj?=
 =?us-ascii?Q?l7FGMDrgYrdLaX85B8V08jeyVrvSncGxQ+pLEv5DiA7TMn26yEC+tafB4IbQ?=
 =?us-ascii?Q?ZurfoS32WHjdeq4nGgNRDAJ0BewDzmwzSFwnvhI5aQMEiisV2uoFN8nm6Iny?=
 =?us-ascii?Q?BoW/HDnvr8Ax4eiPmwrdgxOvCIAmRKdNaaiuKBuJ1QfO3+7cttfJ0zmb4sGa?=
 =?us-ascii?Q?Y+2OG6CRN1MTIY8NlAAaH+gI/rhvX4VD9cflsTOST5qlsCx5uaucSZw3avtt?=
 =?us-ascii?Q?AkFWl0dD8epvGWTZa6w/PS8srnPALeJVLH8xbXRgNu1EzJPQ4f8TBmbIQt2M?=
 =?us-ascii?Q?uzP3+8JCeG+ZUQFwJ4PGgjuCwDY3SNV2lC0BLKD0Y7PJif+6HMxrBXCBZbFg?=
 =?us-ascii?Q?WColpuBnjHXY4smJV7Hq7GbRocNtt3W7C+f9Uh2ZL3VcxI7OlCQtbhZd4Tmz?=
 =?us-ascii?Q?dzv8xI2N+ihLI7hM5NcDz5qo9F7xv3lFWLDuPn2nknMukUz2HwpiojgUtno3?=
 =?us-ascii?Q?E/W6d9vDCBYw0akK253p+OF8QfMAsTF1ShGSvvsA8F5iJhFoWkLoJfu4kgAs?=
 =?us-ascii?Q?ZpPwgBKctM63CoEmoJCE9MpbDywJctdBrAj5WIr/dDZdVyR9Qi04uhb+BzCa?=
 =?us-ascii?Q?FsCARVbhYAq86JuRa6eVDSGj4Q6cp4SuPVNHTCrpciY26htP/NZUhnTwTJTm?=
 =?us-ascii?Q?7HWr7DchKzmdXJtv1GpwdmSPf2G0nvmTi9lpv/GqdxL42mvIryURRFInh7dx?=
 =?us-ascii?Q?Ut3FgmxNvxd21te5h5xAhZ/Nk0rVHbHbm+ldFhSnnCOx9EVXyh9V7LUOxliK?=
 =?us-ascii?Q?1NXdK2t2kceRoDbwzwhY5EQ7DUr04kkbh0F7Gx386eqF61bKC/l1q2MBp0Od?=
 =?us-ascii?Q?Wf6iCrcRSk/Ojl1qBytlGnPHe8JBYXNU3Dze5zIbPt/72PmtrL1ZKUlC+zsW?=
 =?us-ascii?Q?DiIW0OcDbBQWnZOqCzm4T69qpC/DeSp+55Tc4pTHUQkcJL2f+TCCRx6KZoKF?=
 =?us-ascii?Q?Zzb6PVxKwI0KGKZ/XFSAl0uP5STHdYRbug13vbD3xQQOLtyCDhAG1zWiAXmu?=
 =?us-ascii?Q?CPxFYtjjR+gdHcANpqxyhVM3e7vHfxK6C5/ozQ5HQibNfkChK7uKcb+JFA5o?=
 =?us-ascii?Q?knT/IdsifwoWk94VYA0pKrAauRLifpaH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wZuDkICWrs1L5n8TJZT2MS6JcUIrCuLpSCUn1YBm7fMU7pSE7Te/Pt9Y4mB?=
 =?us-ascii?Q?4BOsyGqfjshJX5gNFrOJ972Di16l9kprX5sOBNRyIp02I7aFVk6fXdbHHvSP?=
 =?us-ascii?Q?R+C2k5eYfXJ5rLFTJhoy/ulObWsTjdq3/efTHSi6RCJFEhKF7+Q9xiy0OaW5?=
 =?us-ascii?Q?7/9BM/CuAcUW8jfjYlDASr+/Q+28rfVI8q3hshcdsE59uN9wK81eCWsVOJXb?=
 =?us-ascii?Q?mOza0I2UfO2ngtEyB/OFxdsPm80D30Fdd6jlJXrSIzbKYL+90hzlj5nNM+gN?=
 =?us-ascii?Q?G0x9e/qsqBRFOmOKByjZZW2W6M/e9lVqTZ3TMiYekCXtSCXZqjSsljIeX2MZ?=
 =?us-ascii?Q?fjRtDG8A7ViHCGv4JaFcTqZ/nhCPuyT7lReeWeg0LBSN2ULOicLTwA6dCqHD?=
 =?us-ascii?Q?TY39DN9Lmldl52/lXUMnZr/wjJIioKvZTarkk9skbf5VlbH061phm/qGE4Wj?=
 =?us-ascii?Q?rhCDbvtfj8MB3CikMk/oqH48egW3s1cHk+Aen9KGmyNhecFkYczpwlhJn4HK?=
 =?us-ascii?Q?0NgH0KBTUJ4/C/vy24UQwt+AtrSblwfYTXC3tAH2XFaOuGIPbVBsGefoKFyj?=
 =?us-ascii?Q?AKLBhawOfVrfpLKg9C7pPRwU3w56lCQjBxEHWsWB7nw9aLjzFtXMSSV5FjWu?=
 =?us-ascii?Q?KiqlxFT1kgOV79V4jPIvnw0cH48P95rb2PIrsMLHbFDLKKM9xtw/sut7cG7c?=
 =?us-ascii?Q?2Lv9qjgnMp+hVnWq9D066yy48IQAGxJObT9jkb4vD0mXEpNJv4J1aZmTUpGN?=
 =?us-ascii?Q?HnzC0yfjKdg91PrD5MVfcwE+rOGKwrB935NTo0vVGh5Ysa57xxag/hsWJjNQ?=
 =?us-ascii?Q?lPp1itwHLVB4+JZAAnH01j6nFYNiFk1MHBMiaKgikauDngBkNV5w2lmeg0Vy?=
 =?us-ascii?Q?hG+/yQX1Od+/59NHyzBECeyYYfQMmxmTO1DXWk7T4PTAxgTFJs4aOrvZLNrC?=
 =?us-ascii?Q?FhN8sbNBeR7R0JdwcHQOWs4YIcteBQmUzHt1eY+z9zhmV1yB75zj7/RTftdO?=
 =?us-ascii?Q?pcRThrOukJxGIx7eztLvQWScS/aFWEcntCXHUdNLkHoI4zngNoMenjodpup4?=
 =?us-ascii?Q?zmV2avHCGJOhivHts+oz5rgrywqRjVGU7+95yZ5LanQM+xBRUdM6HZM2qoJo?=
 =?us-ascii?Q?5YNpa2MQVBN7CQBM7AZOmRwMFDn2hKOMBs4yazbHl/u1SCAhVgKGCoy+GVE1?=
 =?us-ascii?Q?N7LhjofqQTPhAHoFFunPkJSzSgQaIOqQ14Xwkr9mgX8UfbFzXUwdAsqSlU8Z?=
 =?us-ascii?Q?N32iTFioJImXfqy7mrPBcqya4JmaDJ1/26yxYc6LyPlJdMp6i7FzOpdqXVFg?=
 =?us-ascii?Q?ZAdKEOI18XARHXxQ5/6BahRDXyFmsyv6WjRwoiQFWLJW/AulDwzr02ZHEqHR?=
 =?us-ascii?Q?dZv0fQocKxjeqMRc1PC7Aqos5CxnND8O9j8xok+gl6OA6UEqdTvqnK7h75n/?=
 =?us-ascii?Q?7Pl4LUbC+ztddI2pYn5b+0Mx5xza0H/IJ8JPeOwWA7P70moZI2y238bdD+mf?=
 =?us-ascii?Q?zmIygBr0DEURL9oodVajCPLaEH+HZ21nDVCuqEDq2P6HzVihyjP5kui5lOX3?=
 =?us-ascii?Q?MV780mS8sDJ0npnnd2Fh3lYBdts6kkbr4IHjA8B4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f151bca-6ade-4917-9017-08de2255c11d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 01:41:24.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS4XOcQuwqsBRnSx0z9AdJWvC4KWIkCMAl/Xam2vBL2rIHu4IpC6RGLv3ZAhLiDaj9v4/2grrAa3UosMdMk1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

Move the "waiting until halted" functionality into a helper so that we
can use it in the sequencer, which is a separate sequencer operation.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 05b124acbfc1..1e51b94d9585 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -551,6 +551,19 @@ pub(crate) fn dma_load<F: FalconFirmware<Target = E>>(&self, bar: &Bar0, fw: &F)
         Ok(())
     }
 
+    /// Wait until the falcon CPU is halted.
+    pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
+        // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
+        read_poll_timeout(
+            || Ok(regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID)),
+            |r| r.halted(),
+            Delta::ZERO,
+            Delta::from_secs(2),
+        )?;
+
+        Ok(())
+    }
+
     /// Runs the loaded firmware and waits for its completion.
     ///
     /// `mbox0` and `mbox1` are optional parameters to write into the `MBOX0` and `MBOX1` registers
@@ -585,13 +598,7 @@ pub(crate) fn boot(
                 .write(bar, &E::ID),
         }
 
-        // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
-        read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID)),
-            |r| r.halted(),
-            Delta::ZERO,
-            Delta::from_secs(2),
-        )?;
+        self.wait_till_halted(bar)?;
 
         let (mbox0, mbox1) = (
             regs::NV_PFALCON_FALCON_MAILBOX0::read(bar, &E::ID).value(),
-- 
2.34.1


