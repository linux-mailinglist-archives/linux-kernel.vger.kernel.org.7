Return-Path: <linux-kernel+bounces-888024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F980C399A8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D2F4E31EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F0308F28;
	Thu,  6 Nov 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="k5Y1HNQz"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405A3081C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418232; cv=fail; b=TGT8bSd120JymW2eOOH7YdcIepMkIl/+YEv98RQoiuNvS+6B3gRpymANMiP7SVQDkmGNoCQbpjajx8TV2cfdza3K2ac8WtcBP1obkEWae01yRdXOrOuSqvydH9bIfbKhEMZsGh2C4JwCbJ84dSvDtH7ZQtxAbE+W5VQ7gp1chUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418232; c=relaxed/simple;
	bh=3lXWbkoz7nM0zbJT6AQK8xUy+82Ph45Rv6qLhxnpNg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LM46L9c+rkUi+sHcn8cDzYbXQ9yxLbe2sN35+UperLsM/1tyTq41jxolsQ6Eyc62EB5JmWkYeyFeMuQ1hfV2Ey0wW6u54q0/Heqf9Gb/dZ7VRQRT5HByaMDBhnWQdH41UjX9zVyLYkbtORyn61JAA23huqemktAQU/j+9vJpyG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=k5Y1HNQz; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz9dGnYROKsU7AJ+/8zW6nZZnETStST/RxcjQv3Q0gYB5F/ULAH3T52uiiz0mUYA2sN9zTuAxcqXAy/f/wwl2qTKtiKKktiL2MlfctIMvvQUGGDt8iUs/74KkOt2sM1sDl/wTXcXNZRwf4qk/xIQ+ZhnGTrsXTWWH7hyN6XUNBBl9Ax48ZM7EGaoLAKVgoSy84Nms4gAq0DEtzHEdUHsBWDlSyXza46Ba0AasRl8mwLQQXkh2wMgbM45IWRsQJdy8seyNeCITDhBAToQcsge7WrFx28tmnQLAeDrprCZzjIM0PL9lh6/zoTJr5V0ArPW4oUsBEPQJIIKoCUmmOnadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohmJnkI2sOkBBDvooqQHj9KjWHOETSElXSkHPcpFOTs=;
 b=CSI/XzIUu8wOd8vn5tXAlorVLJ1Rm/tUugouNZsksh4fdbmWuuIvL3uwxbC9kH6P1aMTAXYeMX95fPoWpGmO61KtAD3nPMQes9jqX8nS0S60GdmHwvqAG3L3iXsfppt2jiYFRfivghbvBUyW2iBNb63O3zKKfYmIy/8PZrkXgAgoCb+Z4BIUNa/LY9nfXhbg6VM7LbgI08pOv74hO3O/c3xw66upegeJI9PAidvk6hpYDUbd9t0VU5BGh8kb1UDLELP8EEiTR4YmP2eY9+TsfYozAAtA80fDjZ1Wr+FHOrwTYJzMkLwc2fEqkLU4vfBcuDzfhQzPGVpS+q+0W0+nEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohmJnkI2sOkBBDvooqQHj9KjWHOETSElXSkHPcpFOTs=;
 b=k5Y1HNQzLCAvxF4LdPC4B0eDqu8TvxiRNfSQ1F9Y6Nzd1dQmYK4UuUfqocDPZQ8k+NB5MRKxhD9mc6xZ8dUVY3qtFRNvfZqYbZxg3Hw5ofTfDUQeUKo8FyEwKKoau3rYApVi7ZzPq59LBVCPXvmWLM1AcmT6a+RqOcj7Q/zmh2soYRM0kfPl/EmVbtpH3xb/h+t0dR0ENuIRRbOWoztVb57nbKxqfcima5TXP6DFqLWaei+e2IAq8QwYzpkBvUYrWKByQcC7H1h1aHBDiH5ml5kKUHOqhG47CvpgMNwFEPKpATdDYS/C/+zACAKDQ9mjywG7WTmqNzedlJlqQHntAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6429.namprd03.prod.outlook.com (2603:10b6:510:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:37:06 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 08:37:05 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org,
	Richard Gong <richard.gong@intel.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: stop kernel thread once service is completed
Date: Thu,  6 Nov 2025 16:37:00 +0800
Message-ID: <eadf3b34e55bb7edcae9c149fb321115dd859cf6.1762416980.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762416980.git.khairul.anuar.romli@altera.com>
References: <cover.1762416980.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: e810659c-8b30-41af-71a2-08de1d0faa27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qv7wlEclFIxp7bai36jswD5rD6Jf7QXgAVxkiQTfnAlJ4/eWVvx0+onmcnQn?=
 =?us-ascii?Q?vMUO4aNQUvHEJALrZykyYCe5fNrFnONKp+y0d9Eh5DU0UNGDCAFBwjaKTFFm?=
 =?us-ascii?Q?UlDI1zM/ggKTcZzavnlGV2r68POFOqOUlIVyhX0PBW64xsTfd/9aOX89m9Te?=
 =?us-ascii?Q?hiC3vt3OQsSjCjUFQEd1wZMiUx401edDx/jayw1Kb7OeY3IJL+mIFM+0HIif?=
 =?us-ascii?Q?hhQaOW2Zr1MxZye5jGeuycG9AmnrHITzaB5RgJMmJc79sGe1sKMvryEfSjH+?=
 =?us-ascii?Q?l3SMgkZwZoLuzJLwQDiBxpKGcmbX93ef7VJr6mdK7Kb6ToZccqVkzW7wmcf2?=
 =?us-ascii?Q?ZncmCzhHK9ovQg3WeR90RHxGi2TspfU5/oUUq2+WWT5Fx01wLKrxIIN89a5I?=
 =?us-ascii?Q?iHJvaxfDlHQxISQ4EB+erZmhi34gKg4khGjdEwDSfLf/N4TBzmY1NlwbtkeQ?=
 =?us-ascii?Q?2xbS2uy7HJwDVWQoiX/2Z6nAcMqa4pFVjPDDs7dX3LGif0n3gCuGNNPIMPGA?=
 =?us-ascii?Q?3VV9nSj6e+/3fpHrmAKL+xaY1FBWuDsZioZk5Ehtar831/c4ZxIjqQekpjj1?=
 =?us-ascii?Q?ALxdve8DQSi0d13XweNG0mSiQmazOFddwn66FuAC1KGCHAh36np53t+3ONQh?=
 =?us-ascii?Q?hcN92u6SbVcAHRNul3dXl6mYN9axtf3eQNMhb2G64G4aqZjPvoDgbSU9tfXs?=
 =?us-ascii?Q?UC1G6zUeur26i+OwMYc555nDOFuu3zker9V9bls1wkST3CwR1UK/0CJWcEFx?=
 =?us-ascii?Q?SutltKhUR7470FAkXI9whLGqQdcEdyvhibTnYH2MHLgntKNSTZI+CzhMadTk?=
 =?us-ascii?Q?DVyZ5pLzVUxDWnKR1f+/DBP0tqy8/waalza1jafMS1WoVf9mghlYWWKI/Cd4?=
 =?us-ascii?Q?X/zCOlR6UPfRc4qiTGISOKiR/ZmU1BYdbR2zN6Vqv8Bl2K52QXWKLvZbXDmy?=
 =?us-ascii?Q?g/3aDd9s1Iaj91Sh3E4vHEo65hWmofcVgFCmbwHvZNDKJZqHoeMTOAiPnAQS?=
 =?us-ascii?Q?+hG5JZs4oFaEoKUTC0FwT04lBQD0wMURCVzJe2zszW7/rIc4o9Y/ywdJCs+V?=
 =?us-ascii?Q?ZEeWXbCfz41nJbwO7/hUQCzJaEM6N23NvpN7QI1PGzCf9hx8zjJtNa8IarU+?=
 =?us-ascii?Q?NBw6i7gVts189SsYO6vhcDGyu2rV52Hc5q6DhCAIe/p1thvQhpQUtl2NraH4?=
 =?us-ascii?Q?HTtDb+UBed3ncDVyyDLxjcnTXJYh5yJZfQHUTEn0mgN+mjDvOddkLX27DUaT?=
 =?us-ascii?Q?7Gvf3J1EVBdecexp+pMCvn7Rr/y8K/qSEQoB9e2vXaZt+DbkjO2eySCES4Ra?=
 =?us-ascii?Q?lXvOt3x2edCWYx7gKOHS9bN6oZhmwPEmM+/GqN/g+NAZKWg5mc1gySp+OqiF?=
 =?us-ascii?Q?39MtzPSUwquyzV0V7UJjstlAqk1Gb0CYsIVNLKlEmXTPHoJp02dcacpfMaqw?=
 =?us-ascii?Q?OYMFewqgPXyD0MBJFcCuLWKUDOONfCZA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?237kI2s3txIAYfY20bQu0iWxzEF0ORQ/+RCzysDlAv0tYoSCaUv9v9wB/a6l?=
 =?us-ascii?Q?MdkP8aGxg6d0yKikAfRFuwNvrj4vmTllmU+3AHSxh+8IknYXKrUiKVtxKF1J?=
 =?us-ascii?Q?qUqN4CeqPdNTsuVfsTdP5c9XzoBMGJtLyOhiBsX3X9RI5Rr6iiCiFxO1Magg?=
 =?us-ascii?Q?SscIArb+GL9DTOIr8k+bQbiQhmD1ssxqDzYHq9xaqelfy5ViZ+89G8oTDaQ3?=
 =?us-ascii?Q?WZx9+Mv0EAg9LY9mvgnfJM3BR3tyWH8wtFyYbyeGl2kIVlIGs59V/UrRuV8G?=
 =?us-ascii?Q?XYRSBtd/oDAxXJnix3psiFLmTfMxQEvZZQ02VGmiOymQmA2Ngaacc+7Ak8GA?=
 =?us-ascii?Q?GW8qd6CNdx1u+62ucTbTcWVyoBrHIjL86OuC/Htq99q0/HGVXpZyOtshqaoC?=
 =?us-ascii?Q?DwZdkqFys3chuKnN5ny6DEazktYt04BuLp6RflQPYy7+R1V1fAJFD5zNTYaO?=
 =?us-ascii?Q?Sg2b7LZ6LBqvJo/dQwJSLdH6AIxoPHLpcHLRZCt8mqeurEPox+h9tbRf6fK6?=
 =?us-ascii?Q?KQfJtzEhir4+waLAO1zogTsq2elkBezygQCwaPuC7Xw/cw7OXx9RZChcJQq0?=
 =?us-ascii?Q?+UwMNpeAfxAdwVj2QOvMsP6Gmhv/BOAcyxDbUo2iJZ9xisptpgtCER04SrZe?=
 =?us-ascii?Q?13PQ9qm8R49H9HKpUs/3L3itILme6W14ythDx0IpYjqRfD3IFB4mbiJGrMZ7?=
 =?us-ascii?Q?TYSnCTGW0EqNAtvy2Gvpqa6KgJIG3TbUlrxWzvH2IRHT4HgDizBfCgrUyQtM?=
 =?us-ascii?Q?s6clmMncj8pJ/pWnQFVb2qfNMEcCEqqV4IG1SXY7HDTpUv3nUZ2PfOzsC7OD?=
 =?us-ascii?Q?0SgJ0LgSuvSXwSC86vOypCX916ttl/C9oTAvs2TrCmf4qKuaCKCAHLZmyiLs?=
 =?us-ascii?Q?cjqhW3UJipQlC4pKhTKtB/vNDDrZTsk9C1RZlBF2ExHEV4JCTC/c07GdZUQY?=
 =?us-ascii?Q?VMMeqiodBUkKgx6Ey6cDfMQUHNa9hFibN4NETuw3Jk8DirTZX2Y+u4bh5tQx?=
 =?us-ascii?Q?HUhTQli10Z5dQ+2+yBrISkeeZsKUv1ZX4yaPYbN00AX1r1UJCSYBOnO6jH9r?=
 =?us-ascii?Q?KjpWZDgkhbpQGi3jRrWtqCMzyzouSA9edW1PLW2/Pl+q2Ac4GfRV6X2ch/0S?=
 =?us-ascii?Q?i1InX7Clb+XaNqbAXqwniRPy2QGZ0slahFOjKME1kEcrKejFEwHWsae5lx/E?=
 =?us-ascii?Q?+f293XfAWZmuSfdFBOBAvO5fmVdkn9p6myQzo5wMo+/l6b3zH7BeFGTdqFfp?=
 =?us-ascii?Q?29u3hfuhN26YPNn4ks18zVgRDbB92jJH1OSusNvQVPeDBEdxrl4PRyNVLA69?=
 =?us-ascii?Q?iq3QSk7Hdsl6wDr1fxj63XVOd5rjGTUy2J2aQGXmnK7a3DQevtwFLPRXZJvQ?=
 =?us-ascii?Q?YiXONWrs50jeaIs2nIcXcTDRcvIi9BkWn5Vlha6RV57y5OoKp2v2DDHLxBer?=
 =?us-ascii?Q?RB+6xW8eFHP0XN5gz9Cm1ySkFFhuXYOq1zjWdUBb5RjWJT0KuUkSGUEM7Y0d?=
 =?us-ascii?Q?WmPon0TxFOT+/hIURZyuAAmj3x3hAGj0TNx16Zl5j7X+DoMsctYPBax1VaU1?=
 =?us-ascii?Q?S1+zUtP2iWfxuutInD56BhxQo/byFkkZdhIF8a3IZfhTLTGqiYwFj2WLZpyw?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e810659c-8b30-41af-71a2-08de1d0faa27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:37:05.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQxj3esgWpl+qpq+MosBOQMYUAS1cUTO+MqLhO7M5uLXD0fNwai0Kw3aAzJxwVxB8AxeVx+AQPvA+SMtbhG2Xx0D1CzeTjzY9RBLl8wqibM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6429

This patch resolves a customer-reported issue where the Stratix10 SVC
service layer caused maximum CPU utilization. The original logic only
stopped the thread if it was running and there was one or fewer active
clients. This overly restrictive condition prevented the thread from
stopping even when the application was active, leading to unnecessary CPU
consumption.

The updated logic now stops the thread whenever it is running, regardless
of the number of active clients, ensuring better resource management and
resolving the performance issue.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..ec39522711ea 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1040,8 +1040,8 @@ EXPORT_SYMBOL_GPL(stratix10_svc_send);
  */
 void stratix10_svc_done(struct stratix10_svc_chan *chan)
 {
-	/* stop thread when thread is running AND only one active client */
-	if (chan->ctrl->task && chan->ctrl->num_active_client <= 1) {
+	/* stop thread when thread is running */
+	if (chan->ctrl->task) {
 		pr_debug("svc_smc_hvc_shm_thread is stopped\n");
 		kthread_stop(chan->ctrl->task);
 		chan->ctrl->task = NULL;
-- 
2.43.7


