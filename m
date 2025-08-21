Return-Path: <linux-kernel+bounces-778920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17275B2ECC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910EA1894DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83C27CCF0;
	Thu, 21 Aug 2025 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CDJYfQsM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10072505AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750464; cv=fail; b=jGICSIh4lxJu8Sjx5Jy3pxdbv/AwmgYrEd5C6p8urf4cmpa0iEeMkRQ9HC90xK8oeK0cuT72i7uATwGugYa2a2qAvTKciYCGL32l1cLlZ+wiPOUjrZAloRnOnUd0Ze/Obnok/EQQWb3x6qE4ZVdq7pc3he7xAKas7TNn0kqePpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750464; c=relaxed/simple;
	bh=QFwnhknBmjOOHNniFo66jnzKbofvwPAKeKPv95Z5zqw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q7929dmEb1JxhQHQibgzEqTTbMXpLRohup9nFLQdgk99F0Ft3hhYSxHBGBgXkXwaErM7vrWsGHPn9kcJtEsosMm7TN9tSvxXVE1X/VVoIMjJ2xo8OTTKJz1DNgVAuJlpyQ5PYFvF+RYccKXF5qYGNwtvr6k4SxErqx3YDXJoxyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CDJYfQsM; arc=fail smtp.client-ip=40.107.94.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDzDZULsbCr1bq/pxoKj3r+bhvbNbHZj/t0obd4CFkmtkUbOkR3I8VS6ahF8UoFLLizwljVpVyPS02rCroHBT4ogcT7X6Xm6sroS6yX7RYB+0xPcYTQgpK/NGKg8QBAW3bDbRUuph+/l1YtTSTyDGy2IZ7kglrTBtWo8Ra8O/TatqvKrYDAd/1gGT0eHX1C7qM6z63jhZd6bXXWQtj4tJSog1Qp9h8FgUFaD15wWE9P/u3AwoZzWuLNBP5c+/DH/sKNbuUEaXP3X1S1ovnVwgAem6G/r36FUzkoPAcYY7a9oCl9dwgVtaFL11nBSDdkd62Mah7jg/YK+K177TLphAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FNAuKUlmzmRdEZxkwVxVOLkEwzrUbZg4rpLTlvjb4U=;
 b=UugdLdMxh18WtKW9EwGD2Ft6jTpJSmYKpA2aW6eswxfoQDpcXkwsfDjdRfp59LrifEEzyX/GuME5/cEsEj+bWo1JQqVpY03tjl8Sf6c4IpvorkFBgxkhFqKNT1th6OtlaTF3kW95R3gUhvPjQ/jO6TbJt9KRGyCn2Co/xIggnMK/yEK4TD+uEMNX0x9NRL++4DtWs49DpF5VvcMvWvQBhql6K/TLGTBzoy4TteoIlgvhlpeFPwfJOunnH512yeddB1BY/THvoc0TXMWmGR/t1GnBZghFToAPMwv8YfeblH1HNP9wgIwPHMCRDtEVon530s4V68JJ9IRgVOU4MQj6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FNAuKUlmzmRdEZxkwVxVOLkEwzrUbZg4rpLTlvjb4U=;
 b=CDJYfQsMCey+JtYsow3qQXTj4NFksP9nwY6sxQF9q+0aBeCh8KTL9oG3IrPi1oZizRLz9+fjlICmBv3NoCALBTzgCoVq1031iokDTf2fFXWFKDf9J93xZ4QHQ14et+hUbYhEfGjZwE6J3s7mtlkqaXD74aNeY/zKczMUTVhG5T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA6PR01MB8829.prod.exchangelabs.com (2603:10b6:806:42f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Thu, 21 Aug 2025 04:27:37 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 04:27:37 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH RESEND 0/2] tick/nohz: CPU cannot enter NOHZ idle balance state
Date: Thu, 21 Aug 2025 04:27:05 +0000
Message-Id: <20250821042707.62993-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::6) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA6PR01MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd6438d-f28e-4f9b-ec87-08dde06b0eb9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CA4m+DKne9IsziZs2sH8VKBJ3QgDzqS3bRNzMdAHBafmv/Fzm9DrE4hvnCZG?=
 =?us-ascii?Q?CngwW/tXgc6G5s9aTrvdWOKP9FkzNPrqvmveukarhsMvUTmowxpG4XFyb9CB?=
 =?us-ascii?Q?OVF33oQ4OqgFPPEZ6tHrI9MB0aD3jdxqlaPfDpnQXhHkgyP6qFKLSyu2/l/3?=
 =?us-ascii?Q?+FGgYTVLQjHDhaTJr8S2bHkFRKrlIEilTBbj/Oe4g/1GzhA8mxLL/lokaZK4?=
 =?us-ascii?Q?yIJ682ciDBTwkvob57QcQY6tAr5eXkWV8SOxVuuSJpXG8hlLowG4NggkGYaa?=
 =?us-ascii?Q?pdhadNnNFeKfRSGGjBeUxQUj8YoP4kAMq5/E5bo1LOPFtJLMUgeaHLgDSdTy?=
 =?us-ascii?Q?SABOKOa5wke7HdEnHmNQGcRBC3sWe2G9XMV4HhW8/XDJIukKPNKfRHtb6tZu?=
 =?us-ascii?Q?GVPcDwZETMkl/fTzWnnfvmupbh7vuXQ9swOeSdwpqzelwmrC7xJjztFLrWGo?=
 =?us-ascii?Q?rpOf2Gc4cr0+t8tusDypojiLSNuWIhGDAgld3ScxLQikG5XjxLECuxNpc3Qh?=
 =?us-ascii?Q?qGs77KwYcIiW2YAGorWEFPm7XuQFDUBCDmwtaQDRHjMUchrw6xmwxIzbCzHj?=
 =?us-ascii?Q?oMJgv7qlgnP2ifpF9iXe8okWLu/mb9oDiaORCgSgq1vEFMtIuiPfSOjvkati?=
 =?us-ascii?Q?rFgDTvC/FkssL5OxjBgY94UxZ0vpim8RE9djpy/9E9Fu8gOekMVQGAaEy/wb?=
 =?us-ascii?Q?ya2dCklZ1Zvo2uEJ/v9wj5bbSFlw0hbhIZUd2Pd7p4DzijizxxIAwuO+Db9b?=
 =?us-ascii?Q?PL/gQPqy1Mr5kl58W+WV/0x1OR6Q3j+ibauNlWQ234b4pyJqcZNKsneNDPLr?=
 =?us-ascii?Q?mZgB7Ut8TThsfhyLBTfiC3S6VbeteCOuUgqcZ8m4tc2JG5oOnZCOzIg0Utg3?=
 =?us-ascii?Q?BloqM9rZEg/ITnqiVj33hIAk3SIO8yHfBPNvLK1D07cwQ9yr+u+Gf+xaepAZ?=
 =?us-ascii?Q?6Ih4ts3IMKLv+NYGU9i+GCGXisHygNeNWfX20P37AEVYRiZ8yX15G/9rv0B6?=
 =?us-ascii?Q?A3jarekyb+2+ktyuwueaR4evTTyBW4oeGhSs26Cv4JQ8wOMoiC4kZsREPpVF?=
 =?us-ascii?Q?hEUmKHspebVMKeDttLLMPdSOqcL4NKctQF2dvu0aV9i6HfYU+nJXSMhE/a+h?=
 =?us-ascii?Q?fduFCu1sxCfRrtUajwNhKOT1Oqb5yk8RqrnVfCQIc1VwlEv/wneMDeP0UpZM?=
 =?us-ascii?Q?wKyqiyWRbWK6VD2qomAKuroJG0iONFZ8r9AQvjQkUdmuYgGsc7OaA/+XdcUi?=
 =?us-ascii?Q?1eZ3SIrXN1hkQZGD8OdpBxBmqtQEw8C2kGWXxKz0qmlECVFJGUyjys4fFL3/?=
 =?us-ascii?Q?/wSyTaCmQ854zFX8bGwPDzdmEt2liIV4sqyb7a6GHsNFnJESE0IwG8VqngTe?=
 =?us-ascii?Q?tDLRAt9pGivPdDxfgx+bxh8KpxmAHAYtbvY8aT7JAmoA3781om66BDqo9gsj?=
 =?us-ascii?Q?J3OqYtG9QEJwl+dDwNUyUPPNM89fG99etpY/jWZ/sguoUot/wAg6B9BptT9o?=
 =?us-ascii?Q?Lhi8phDfeaXDzGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ET9s7herhYiJjuzg8/wWtt5DzIFVN9I2wNVQChhq6pInQf7/CObPBDj5ejdU?=
 =?us-ascii?Q?k+PIgvP+tu7EaKQFX8juOju1uoc6BsIckaIqTaTXJKzpDZp7uzTmzQeaOBE3?=
 =?us-ascii?Q?sBCT2umZXRRhgHOsHZvC3TdW+t9E4RnKIYiW7219GTlsLlw1vlbE0P/es5LF?=
 =?us-ascii?Q?wM2WDeiSYf69uqz1UDWtTYJ/YuTI6b20rF5LXeIPySP94HGqgwCCPzWeroQp?=
 =?us-ascii?Q?T78U40cL2NEizDDyypVS9L74rOmp/RfI/ixQaFqqAyhFhaXYwL0hJSTQbivO?=
 =?us-ascii?Q?/Q2+RqiSMCTcWnwXiS8JAVP7F1HWRQqOJfSu9nNdo5gBDyjnvvEbfemv8TDf?=
 =?us-ascii?Q?+hKv4gCW1kzpeclVXXKErK+8oStc79JrkCYgK+741UWFThg9fyH34Lx36Q4J?=
 =?us-ascii?Q?7jYCkfXGl77XbjV6td3KJCIu7ezeRHaLNnSN5WCGjBeVil8RbOwiUIJUaKbT?=
 =?us-ascii?Q?UMx01FRwPbVzGjlaZG7e7tpZBY+CfOwDCvunId8YYKviAs+66eSpipVGsXRd?=
 =?us-ascii?Q?pKjhLbBI1m4QM4GY5X0bmA1hXeJILY0CxTnvB7/MYYLcrOhvKLfsMM8yaAw7?=
 =?us-ascii?Q?pljBm0CDz/Vnt7ruzfJQMihRgDuEvdGPgV+tNigpqS4fg/oxre35MvPzvmMb?=
 =?us-ascii?Q?nRC9dlFm8QObk7lGrbiu+UbjFkziHBNiucTuP7/HWwkjL6NmbAUeJN468qf0?=
 =?us-ascii?Q?g9ZyxVqyKTsJ9GXv+455pA7aNt5hq1cvcO5WhYFWRBWw7lhmvq+sJqmT0ztt?=
 =?us-ascii?Q?hNWlZBkmHpxCSsPTrzjMxwpRDHZwGoxIC5BDeNgkKAZvZYCtoRunopdfKd3V?=
 =?us-ascii?Q?gzVk02prQ0h+XJygqnp1Q3RqD9ST9DGcFaCP7y7kNQjAeEV4qsCfHcJ+kgy3?=
 =?us-ascii?Q?a2eUrpuDAdtdh89TRsO6xmH1PI2yWGN/MGaux/H2+FyuKsi6haBseYFzpM92?=
 =?us-ascii?Q?PDYoSvA2ega38chYVFzPz+xEt99Ja9IQG8IKkQum3oGbPqNULo+Z2LsxEp74?=
 =?us-ascii?Q?CWfFN3uGUEg1K/nzWiqEP8YWat5SK2b3ntQcj9pP7993WqfPmkYysFjWhDqj?=
 =?us-ascii?Q?dSKKLemHOAMr9aZo5JRFM2UCHpnZVP02SrFszzTJF/J9j5CHFgdpOnvAHGa5?=
 =?us-ascii?Q?+jF/1ccV8RZfDnxhG7hmj0Cj3FMbWrprOyT6HZfRPNpt8iGVUQOOeF+mq7/m?=
 =?us-ascii?Q?NQYtVGmw5MSMfTgJV4xnB/vkpOWfsxN05iBj4gGQzpP7eRvbJVPZIsdJNSzs?=
 =?us-ascii?Q?GgZKKNhVQDiBDkFJ1/XxNIedGL0lBpklQ5gKkXrxxEIIcNFFthQ3M2Ezrl/Z?=
 =?us-ascii?Q?4JTCGPAC82jaWjAYBOsDurxEzovBBQtVdjnK3KORMkD27KinmQoYz5GNOjXE?=
 =?us-ascii?Q?Io3hK12YWU58LuvjWrnIzjoBAaJ9i3UXV+deGEovzFV0Ce2fb4TqaoGvx7QE?=
 =?us-ascii?Q?cjfS4dd0VnoMOTUMNXH9n43JlkDAPizvogGimlU9yndj0Nv5IvLYapzBx0l2?=
 =?us-ascii?Q?2TpbulJ4ehE6ZyOVh30jcLdWy+UXb/UKn0sDcL3xZy7ZgXndrjRYfmlbG+5z?=
 =?us-ascii?Q?Ii4T3zsGoEJQ+WHW1TJ49bsBl78N0AhVzi+Ozi4U2gwlJwRZoRIsePFpZa51?=
 =?us-ascii?Q?N24xHuhMvQU37PZtM5UU9lE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd6438d-f28e-4f9b-ec87-08dde06b0eb9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:27:37.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyR5WWC4xC4/8OEJJgJxXq7WQUNcnqQEBuV/QTghs/Fv16kdQ//oxB40fzaw/XJxMcyufOTRRgUHXRLyWs7REFtDV8/xGhDL9g9DA1CrlCMUI96nRWeHReAN1DvSbr+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8829

Valentin Schneider suggested to resend this patch and copy to
scheduler reviewers [1].

When running llama on arm64 server, some CPUs *keep* idle while others
are 100% busy. All CPUs are in 'nohz_full=' cpu list, and CONFIG_NO_HZ_FULL
is set. The server has 192 CPUs, with kernel option 'nohz_full=0-191'.

The problem is caused by two issues:
1) Some idle CPUs cannot be added to 'nohz.idle_cpus_mask'. This bug
is fixed by the first patch in this serial:
"tick/nohz: Fix wrong NOHZ idle CPU state".

2) Even if the idle CPUs are in 'nohz.idle_cpus_mask', no CPU can be
selected to do NOHZ idle load balancing because conditions in
find_new_ilb() is too strict. This issue is fixed by patch in [2].

We can see that the idle CPUs are not in nohz.idle_cpus_mask. The NOHZ
idle load balancing only considers CPUs in nohz.idle_cpus_mask. The ticks
on the idle CPUs are stopped and therefore period load balancing
is not triggered. Therefore the CPUs are not used and the
imbalance persists.

A CPU is added to nohz.idle_cpus_mask in:
do_idle()
   -> tick_nohz_idle_stop_tick()
      -> nohz_balance_enter_idle()

nohz_balance_enter_idle() depends on '!was_stopped' condition.
It looks 'was_stopped' is used to avoid duplicated calling
nohz_balance_enter_idle() and duplicated setting 'ts->idle_jiffies'.

When the CPU is in nohz_full mode, 'was_stopped' may alwasy be true.
The call path might be:

tick_nohz_full_stop_tick() /* stop tick and set TS_FLAG_STOPPED */
... ...
do_idle()
    -> tick_nohz_idle_stop_tick() /* was_stoppped == 1 */

The first patch "Fix wrong NOHZ idle CPU state" makes
nohz_balance_enter_idle() independent of '!was_stopped'. It is safe
since in nohz_balance_enter_idle(), there exists a condition check
'rq->nohz_tick_stopped' to avoid duplicated nohz.idle_cpus_mask setting.

The second patch "Trigger warning when CPU in wrong NOHZ idle state"
is for debug only. It is not intended to be merged. The patch can help
to reproduce the bug.

Warning is triggerred when CPU is in this 'wrong' state:
1) tick was already stopped before tick_nohz_idle_stop_tick()
   stops the tick
2) and CPU is not in nohz.idle_cpus_mask
3) and CPU is idle
4) and tick is stopped

When kernel booting on my system there is warning:
[   15.536604] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:1230 tick_nohz_idle_stop_tick+0x148/0x160
[   15.550687] Modules linked in:
[   15.553731] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc1-cls-00002-g39cde4c0206e-dirty #109 VOLUNTARY
[   15.580390] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
<snip>
[   15.703028] Call trace:
[   15.705462]  tick_nohz_idle_stop_tick+0x148/0x160 (P)
[   15.710502]  cpuidle_idle_call+0x118/0x1d0
[   15.714588]  do_idle+0xf4/0x100
[   15.717717]  cpu_startup_entry+0x40/0x50
[   15.721627]  secondary_start_kernel+0xe4/0x128
[   15.732745]  __secondary_switched+0xc0/0xc8

After the first patch, CPU is added to nohz.idle_cpus_mask.
NOHZ idle balancing can move task to this CPU.

Adam Li (2):
  tick/nohz: Fix wrong NOHZ idle CPU state
  tick/nohz: Trigger warning when CPU in wrong NOHZ idle state

Links
[1]: https://lore.kernel.org/all/xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
[2]: https://lore.kernel.org/all/20250819025720.14794-1-adamli@os.amperecomputing.com/

 include/linux/sched/nohz.h | 2 ++
 kernel/sched/fair.c        | 5 +++++
 kernel/time/tick-sched.c   | 8 +++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.34.1


