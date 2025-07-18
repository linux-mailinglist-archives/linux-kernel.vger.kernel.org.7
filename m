Return-Path: <linux-kernel+bounces-736579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB322B09EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D677F7B77FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809D295DA9;
	Fri, 18 Jul 2025 09:11:12 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020105.outbound.protection.outlook.com [52.101.227.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28129552B;
	Fri, 18 Jul 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829871; cv=fail; b=WQQLHVsPx8a0e/wKqQZzbR0KDzSX5OxzSQv/Ye7ZOnUautMY8FG4nOJtgMi+JCf+Rt7W4ybqv/FkRWOE3G7I8IBwQZs4ENeUSf3EuCGv4hWmOYAA4Jw8rEYeATMb35ZiZ7WW/wCuqQyJJhQHkdnn3GzQE7qOMIiL6APRbqBi47U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829871; c=relaxed/simple;
	bh=1r1brNaOKLuzFL1rT5DyHnX8neZ30SMN3Dyc4ZScVN0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=apjAtvN9S5zoVgYwLkM0UeAC3KdYG/2a75aIm4igo4FkSdEqAmH7nrEDUQuX344LMVWyLaAoCPPBD2eq4P3N2504LkhVIu4Ixg7ANayJX+tEcGYqH6PDNyqSvG+PSh4rux8z1tOKuOsq/Yp8qz1ootaha7pmPuSymz5E2LM/4mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com; spf=fail smtp.mailfrom=siqol.com; arc=fail smtp.client-ip=52.101.227.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siqol.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYCQNFN8tcyJtugR2+ESKUklSZDckS9KRwqssk4lI498NW55Ei75C/Sa+et9fHZK5qkbADeWqcm6wyd/HXJ3gthLUUPbk/4ft2uMqji07Nini8UweQ/iTbZSb8cxU937NOE9+xv4uc/tKnosFE/8ZLmNnjP58+8RNXL6QN4NYzNM3pK3cimrnRIEhds/wpGQcZraoRllbsN05qYKRBxyW0RcWjy39ry6Ra2qr7txoj5UDys6DMzymYMWu0ucDZ8IVyf1pyTYahYBsxR+9+tc5wBlof4z6OqSVCJRmlQ0U/hHLGlVDwekT9DyUhADKy9G0yeN9f2bSc3Vlm/nyFydyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T96F5IEpeWbnQPqvknL9Drxpk90b6z94vkuHOseIJts=;
 b=fPhjifkpeuJS20kdmMSoWG83rjbRKzEyrl2PrZR8kvM0AN6scBJ3lERjMX2c+tNifQ8zyvWLKGsqlzLS/YuuI3T/E8zQV7afR/6VfhTDzFXcNI4aw7jvZAQQxaz16rVTbOFS8L5bRv6twvtkpnBqKvITSfn6HU5nke5ZascSdUNSSII17357Ufyu8v5p74wLZnq/nFdoWT/xdXTr16qZvtRODC6RUZDjRqQ/ZO7TYxJ2AXGmlUwwegd6GF54Pfx+W4raV5a5BlbacMEPugIC3YFZqbkyTzsMg4GnCDDYRVLXtMMA6iOY8GAy0dDtkUjzHamMAjLxnBHX4Y+AzGFuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siqol.com; dmarc=pass action=none header.from=siqol.com;
 dkim=pass header.d=siqol.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siqol.com;
Received: from PN2P287MB2370.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b2::11)
 by PN4P287MB4249.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 09:11:05 +0000
Received: from PN2P287MB2370.INDP287.PROD.OUTLOOK.COM
 ([fe80::ffd6:20f0:fb22:c7d4]) by PN2P287MB2370.INDP287.PROD.OUTLOOK.COM
 ([fe80::ffd6:20f0:fb22:c7d4%4]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 09:11:05 +0000
From: Darshan Rathod <darshan.rathod@siqol.com>
To: zaitcev@redhat.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manish@siqol.com,
	dishank@siqol.com,
	Darshan Rathod <darshan.rathod@siqol.com>
Subject: [PATCH] usb: usblp: clean up assignment inside if conditions
Date: Fri, 18 Jul 2025 14:40:45 +0530
Message-Id: <20250718091045.264129-1-darshan.rathod@siqol.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::17) To PN2P287MB2370.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1b2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2P287MB2370:EE_|PN4P287MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: aebc8c3c-1fec-44eb-7a62-08ddc5db061f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81qlo2zfxAAvHwMsXj8I+Am06i7UtDIyov+siER8UfTdSjVL6BrplwsO4ZfM?=
 =?us-ascii?Q?E3kSvNEKiDoY9GsApTc+QcNXchqjuLY+nNFZUeT3lu6+shmH/J8dIiHH/0Lj?=
 =?us-ascii?Q?6LCYtxJYcUsQ5bSb+gDPhpmuFMHYJUpnuJltbWtGUNOMSpNlC5xN9LCD7zqY?=
 =?us-ascii?Q?2FAEML6dtnYS/fxkMW8kFCQUfm9SU0mDdT9ZVNdvCY5MZBU/NnvyOImglqp+?=
 =?us-ascii?Q?29qLMp9tJ9JrwKg6p0lyGAHO8kxFlWTpqjfjg/OKrlDMguFUk1dn4cQu8QBU?=
 =?us-ascii?Q?08pd9DPNKwFFfxhj7sk5P3UAA60VJLYA9+vHoDZ+a9u49+c5oDVm8qeabPqq?=
 =?us-ascii?Q?wjsSy/7AJ7jDIsay9DEU8dfBpvYI8lS/1a1xtFDkHLT4ndgB2lYuH45ZyZ14?=
 =?us-ascii?Q?NMzB1QqY72BuCK4bftFgip7FhzDAvSUN5/HLkj/7/c3OWfhB+dG5qjYQydU+?=
 =?us-ascii?Q?kH/44yescWd3d4jJwr75xuwAgCVklws8R7yUIv2MkTjBkIBLgm6sPf5P3r+O?=
 =?us-ascii?Q?6xSPEqw6Uvj/BnWZrfG2JoWLNQxyS4P9c623OONFcuH/lJByLC+V5sP1oHwC?=
 =?us-ascii?Q?txK5M3KoU54pzEEkRO3GGDsQALKB26blZDk97yA81YmRhgEpU7A3baar3BgQ?=
 =?us-ascii?Q?tjwCsgTI0joA56Pkk451r41q10gvyYpXopH0F5cIvAv9yhmXJO2cHpz4s4o/?=
 =?us-ascii?Q?DSamzcFF8VSkgt9JEs75Yi6Bh3w24OsRSn1Yp7exZm0B4q48/AkjjmXoUd6a?=
 =?us-ascii?Q?k8qtKlOMZmklFiIjSiz2ieoVdDqudyXMwJ+yv99nnz5t1py0u/YzNv/EJFWK?=
 =?us-ascii?Q?alenQx8p3SV3xlJ3oi9o7t60YYka+bAoeEX0HxNnoR260AuOtvhCfsBz99BA?=
 =?us-ascii?Q?1G9+rq1stwoZuGNOexVH0ounpwrDoQpUFmcAvbDpo4fyGvx5cZrwKiBBkSAb?=
 =?us-ascii?Q?l/8IuHNekU9mgqlWeyiZr0fDW7+8Y2+02FVcjdCQNpPjbeWVBOh4f37qV+aN?=
 =?us-ascii?Q?Hc7CT+N5OlXT6sFQpseK48tj/C4YHBfYJHi+2gFTo1VB2m7yu07t8ZE8AKBB?=
 =?us-ascii?Q?dIBMt9tC8mims5MpCqC2Zge2mi1ICCX4qaJv4ckaXHH1CTkAD2Yn6GQMsfdI?=
 =?us-ascii?Q?3JzZ1DmDHw5HFlsppk9TWzAPs9yyCHkKNgz1AEE+O1rlLqvwNMNePJtvLzqH?=
 =?us-ascii?Q?GIvEsw3PP8kN6nh67NHqgnpTmWk2vs7AzKCfzQK1MEgA5bqC4pXeDC3Gyy77?=
 =?us-ascii?Q?L8g/VsizTieFCMXT9n3EWSxQCNyFKIsCW4IPbFBbHWcFJJw3enWfBfrlqmVp?=
 =?us-ascii?Q?LTep/L5eKZk48e6pUjF4uvJ2cUxUmoeWzD49pO5awziKgil3IskH37XKXCQe?=
 =?us-ascii?Q?T13JDxpKJHnzAon1Nha1nxVSL72DY8L89TF8QnEmGdEPeoUHNGQ8Qs8fZAiT?=
 =?us-ascii?Q?/CQ3pHlMYNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB2370.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HyiiRtnm6r13G6rY8LreLaGJDe7rgDkG8wQyFXaG+BUZlzHNoaNTIx4iMw1k?=
 =?us-ascii?Q?MEkSVqedRt559V71yKKk+jcKQ/uAcq1X2gLDvGT3efGll+bZWepAtRWEutE4?=
 =?us-ascii?Q?YppUAaxuE1O3VTbc0lR5hLOOabQv1AxhB6gj0GrGJHUFySmHZcn5VBUIOSBe?=
 =?us-ascii?Q?4u8Qy0BoO0q4MlHgytR8T55t3R3yBRktejzbqVD/XiuOekWwRVIRYx3JtKyB?=
 =?us-ascii?Q?gulYY/uEbvg4nv21EErw58OHV0w2gov/1yINSr9ZJCUnJXck5oaWyW4FC6n+?=
 =?us-ascii?Q?5yRlz2Jb18Ts9Nk6N+umSlZLn6ezXuM5V69I5G65hNEeFk4vI0CwtEu+DSFt?=
 =?us-ascii?Q?tZowMxh2ffHyMzlKI0lAfy2o4SzR7E4MO8E5sdvfAfvokWNJ4uwFpgJjzvgJ?=
 =?us-ascii?Q?etzkNXDE5UD8Uypcne3uYXg/i+UU8BtS76HRFD1zago793HPyL+BkPpGo32a?=
 =?us-ascii?Q?NTPNXtG7X+iV7CgmzxaP0hBVzoW/2IOIaQrShZjHfSk0rN+u6FwsDlW/GzZh?=
 =?us-ascii?Q?kYM/0Gw4u72xoljDbCf/nOVnaZGQ4dTSJbkfNs4IzT5ypIqIlsh58zHF368P?=
 =?us-ascii?Q?8viEYf1oQdr1kFClIWUCCQqsfPdWeHxhCJWn9U82CMiTzpdqP/bno9bb+I6T?=
 =?us-ascii?Q?ETupPL6AGIoDgVg825Vh+Ihi2MxHUvkfEQYuBcNZyAs4PPX6380err8J2Swl?=
 =?us-ascii?Q?aSOC1EGNMytA2Ijkj7/lTRG093ozVbviL31jBTuNEi++P6qoWblT37I9e/wo?=
 =?us-ascii?Q?OlCXwvexUR6p5fraFQwhwFJA6CeBisVZAoLXPDPpXTgs+zXT1MJWXS/D8VtU?=
 =?us-ascii?Q?1wK+qW35zwq/wwcOaHJEC88l5B/bI/mprCAIIU258BAbMgRb/Th7SlmaS2sj?=
 =?us-ascii?Q?mvCJAt26Nx6e/0DC6pSZeDPhnO045fRiIEYw494KAzm6tENr4fFrft1tfq3C?=
 =?us-ascii?Q?+X5EkF/mRLp0fDwi6OU8k/bVUc2tVqiMVNYXvcv/BqWZ62f6cItfWyQKqE/X?=
 =?us-ascii?Q?s9EhrUyDux1RiCzhuBduVKZE65gjYCncOBXiMkjLnwxZp3rbO5JDUqhBMciC?=
 =?us-ascii?Q?oYCDgZ/KbR262jS3ZHhsMS8vYpqA31yqhtnrvxxt6IP5Cq3tEhpOaGE21Xl4?=
 =?us-ascii?Q?Lqn59cOmn0W1wdIksOvW7X5pLypux9Pn7R0HuFgBZLza6UG8tfudJWm/8puq?=
 =?us-ascii?Q?t++y28kFsdbFTLuIOSPGHPVAYjYlql1htv9hhQN7N2mY2G7Nhk7sIJd3RW3d?=
 =?us-ascii?Q?01cf84J340A5Zi6yMcYMFuRyaRxSe8FwsBkGMBS0ddUknuWVa1LhTIDkU51i?=
 =?us-ascii?Q?tmiGBJH6m7kAZ/des5R/829Yqx7axjur/acmvh9cz9QwEssycI0S+0YqFiNx?=
 =?us-ascii?Q?cpfGtV4DzPXLA1dDngbJYzegRg7qYCUrrJ76T1naMbJrRW1xHhSm64OE0g0t?=
 =?us-ascii?Q?rYQwrkjaLshnHYsWP61767fswbnGtkLEX1tnQXyMmyntEVsNoAb/EEL6xZ1S?=
 =?us-ascii?Q?U+EnvBD0zQRiJjtFXgK4yox0UUM2FtjRl8V3el/ITIAEhius5wnVTP3HqLSC?=
 =?us-ascii?Q?fGOlISh4akng3C5sruN7wNpodO24ALUAK0OFcG9FcIQmcIYwcevVXMZBxRBh?=
 =?us-ascii?Q?dcj8qK9rzRWKMI0CR+3iERmti+NV//MTqeHtoS0wfBCP?=
X-OriginatorOrg: siqol.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebc8c3c-1fec-44eb-7a62-08ddc5db061f
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB2370.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 09:11:04.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e93cdbe6-5a59-4d5d-8570-7b6ea0400c3e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti4ZIDvyRgQy/8Up9wVXX3j45nmkuFw4usL9JYHRRuyDfdj4XiDqbk3UEzdCybR02UYvBoNl//4tfSTzJwZJxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4249

This patch cleans up a few cases where assignments were made
inside of if conditions, like

if ((rv = func()) < 0)

into two lines, to improve readability and be more in-line with
Linux kernel coding style. It also cleans up checkpatch warnings
like:

ERROR: do not use assignment in if condition

No functional change, just a style and maintainability fix.

Signed-off-by: Darshan Rathod <darshan.rathod@siqol.com>
---
 drivers/usb/class/usblp.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index e2527faa6592..acbefccbdb2a 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -366,7 +366,8 @@ static int usblp_check_status(struct usblp *usblp, int err)
 	int error;
 
 	mutex_lock(&usblp->mut);
-	if ((error = usblp_read_status(usblp, usblp->statusbuf)) < 0) {
+	error = usblp_read_status(usblp, usblp->statusbuf);
+	if (error < 0) {
 		mutex_unlock(&usblp->mut);
 		printk_ratelimited(KERN_ERR
 				"usblp%d: error %d reading printer status\n",
@@ -751,14 +752,16 @@ static ssize_t usblp_write(struct file *file, const char __user *buffer, size_t
 		rv = -EINTR;
 		goto raise_biglock;
 	}
-	if ((rv = usblp_wwait(usblp, !!(file->f_flags & O_NONBLOCK))) < 0)
+	rv = usblp_wwait(usblp, !!(file->f_flags & O_NONBLOCK));
+	if (rv < 0)
 		goto raise_wait;
 
 	while (writecount < count) {
 		/*
 		 * Step 1: Submit next block.
 		 */
-		if ((transfer_length = count - writecount) > USBLP_BUF_SIZE)
+		transfer_length = count - writecount;
+		if (transfer_length > USBLP_BUF_SIZE)
 			transfer_length = USBLP_BUF_SIZE;
 
 		rv = -ENOMEM;
@@ -776,7 +779,9 @@ static ssize_t usblp_write(struct file *file, const char __user *buffer, size_t
 		spin_lock_irq(&usblp->lock);
 		usblp->wcomplete = 0;
 		spin_unlock_irq(&usblp->lock);
-		if ((rv = usb_submit_urb(writeurb, GFP_KERNEL)) < 0) {
+
+		rv = usb_submit_urb(writeurb, GFP_KERNEL);
+		if (rv < 0) {
 			usblp->wstatus = 0;
 			spin_lock_irq(&usblp->lock);
 			usblp->no_paper = 0;
@@ -857,9 +862,10 @@ static ssize_t usblp_read(struct file *file, char __user *buffer, size_t len, lo
 		goto done;
 	}
 
-	if ((avail = usblp->rstatus) < 0) {
+	avail = usblp->rstatus;
+	if (avail < 0) {
 		printk(KERN_ERR "usblp%d: error %d reading from printer\n",
-		    usblp->minor, (int)avail);
+			usblp->minor, (int)avail);
 		usblp_submit_read(usblp);
 		count = -EIO;
 		goto done;
@@ -872,7 +878,8 @@ static ssize_t usblp_read(struct file *file, char __user *buffer, size_t len, lo
 		goto done;
 	}
 
-	if ((usblp->readcount += count) == avail) {
+	usblp->readcount += count;
+	if (usblp->readcount == avail) {
 		if (usblp_submit_read(usblp) < 0) {
 			/* We don't want to leak USB return codes into errno. */
 			if (count == 0)
@@ -973,7 +980,8 @@ static int usblp_rwait_and_lock(struct usblp *usblp, int nonblock)
 			break;
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
-		if ((rc = usblp_rtest(usblp, nonblock)) < 0) {
+		rc = usblp_rtest(usblp, nonblock);
+		if (rc < 0) {
 			mutex_unlock(&usblp->mut);
 			break;
 		}
@@ -1031,7 +1039,8 @@ static int usblp_submit_read(struct usblp *usblp)
 	usblp->readcount = 0; /* XXX Why here? */
 	usblp->rcomplete = 0;
 	spin_unlock_irqrestore(&usblp->lock, flags);
-	if ((rc = usb_submit_urb(urb, GFP_KERNEL)) < 0) {
+	rc = usb_submit_urb(urb, GFP_KERNEL);
+	if (rc < 0) {
 		dev_dbg(&usblp->intf->dev, "error submitting urb (%d)\n", rc);
 		spin_lock_irqsave(&usblp->lock, flags);
 		usblp->rstatus = rc;
@@ -1150,7 +1159,8 @@ static int usblp_probe(struct usb_interface *intf,
 	/* Malloc device ID string buffer to the largest expected length,
 	 * since we can re-query it on an ioctl and a dynamic string
 	 * could change in length. */
-	if (!(usblp->device_id_string = kmalloc(USBLP_DEVICE_ID_SIZE, GFP_KERNEL))) {
+	usblp->device_id_string = kmalloc(USBLP_DEVICE_ID_SIZE, GFP_KERNEL);
+	if (!usblp->device_id_string) {
 		retval = -ENOMEM;
 		goto abort;
 	}
@@ -1160,7 +1170,8 @@ static int usblp_probe(struct usb_interface *intf,
 	 * malloc both regardless of bidirectionality, because the
 	 * alternate setting can be changed later via an ioctl.
 	 */
-	if (!(usblp->readbuf = kmalloc(USBLP_BUF_SIZE_IN, GFP_KERNEL))) {
+	usblp->readbuf = kmalloc(USBLP_BUF_SIZE_IN, GFP_KERNEL);
+	if (!usblp->readbuf) {
 		retval = -ENOMEM;
 		goto abort;
 	}
-- 
2.25.1


