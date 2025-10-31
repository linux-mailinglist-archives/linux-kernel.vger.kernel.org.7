Return-Path: <linux-kernel+bounces-880654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB3C26417
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74B61A245D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D962FD697;
	Fri, 31 Oct 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TdbTIOyD"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023122.outbound.protection.outlook.com [40.93.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F21494A8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929975; cv=fail; b=Yy51/Wx4cmBBuD4F7Y2cjru3S844Skdpsz3+jim/wmi+BH9lDZ3wWuPMcuZXpZ7tEX8SlEEz1NAlbvqFDCMuGJCHt6S/ICHSGCWhF9H0tjbOgQFNYD2Isb764cljkiN3CCnYj9hDJnLhNDF0r/sOoBrGo/x/cQQV59gZscjkkNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929975; c=relaxed/simple;
	bh=4Tl6RtFaqYHKcnchPsNvuq0c+Trq5BkwwvDn26El+Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=un3KC5rqGKldfupf4BHidnwyq/hgiN0VU4gl5pm4nMPbPi5qOulS95kCfsY5qm3oNjnpNAcy+6B6l5FuvEdduK4nhxecds/uO4quu+d0EarPubZStICKqozcoShDURmltGM3VRz+wVZVBvWP9O2sv6i9e3BR8YIaJ4sS0JiQ72g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TdbTIOyD; arc=fail smtp.client-ip=40.93.196.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akXOOYvdL9/OO1w9C3Z+dwaScAizGBXvGnAAQarAe39BcnuUu767rgxwO4HRMpVXtzdRMFnhxzdcTasHLXhSNPzfqr8SbkuYMbM4gUyM1h8G8gUK09oF2RZi0dG5VHs/YdV8j/snyhh4XJ6LCniO8MfwXFRkB2M+Mkye4CWHQlbNGSjsyLm0bRsCJ7wTwjGowQC82f7zCduFGfLpYdAQJ6YrcvhpxbCgvLTbOp4/3ym/steYFebOegeQl1etnxvLAbZ7M+I3TwxVAmOoFkS54VUS+HohbWigkKj4DV8sgG8JPwtoY7y1tG/vvTVipyGx2Xm1RcHwenz0JNSM2Rc4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lENCSqJiwkU/tkME1cwcx1qd6Lv0WyhqS57/ug6YfV4=;
 b=AhWFVID+7kE4kYGRIUpM00ujgZo6eE6IAkgvTtGvKxW0iD7LszQv2gcUytZ7tFMlBFpAWGb8ndh2woZrt1EHS2ZapFJ71WBTmNXvdUY5IvO3TyzNOsrUqCR9f9mzFgQjKF+kSIjbfd4KPbJbZHpJ/hD1IqJc2UpvO+zHetYj0judp4hsnRHZ6QmDfX7U3MKx8jS2oDVStLXYMeuIha/cefW39kpZQ/F133vKqbv/barcrusXDwMvlpe8Wqs7rlInvwtnfAFQoYC0VZTbtMoSSkk8YAXuuakvnaS3BDZaBNHvH2O8Wuhg1XeM7iVgT9BRZp9gEtWiapehNi/SbKfZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lENCSqJiwkU/tkME1cwcx1qd6Lv0WyhqS57/ug6YfV4=;
 b=TdbTIOyDRWOhWFo7h9cLa/8RMrhTMiEbfGwJ+H+c6ym/EjdVOyidC5zvGpIUvzlKXImN9oAdhnIix9NbmprZs0T33Ua5RLQWifHVyDR2ZwAULLbwPNgccGRvxe+bLNziz89mV5KuMNxIF8NI3DP2GtRsEHwgh2ZffxSkjmuzwTM=
Received: from MW6PR01MB8368.prod.exchangelabs.com (2603:10b6:303:246::7) by
 SJ2PR01MB8050.prod.exchangelabs.com (2603:10b6:a03:4d3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Fri, 31 Oct 2025 16:59:30 +0000
Received: from MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4]) by MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:59:30 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Christian Loehle <christian.loehle@arm.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik
	<sh@gentwo.org>, Shijie Huang <Shijie.Huang@amperecomputing.com>, Frank Wang
	<zwang@amperecomputing.com>
CC: Christopher Lameter <cl@gentwo.org>, Adam Li
	<adam.li@amperecomputing.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Topic: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Index: AQHcSdIkzb5ACY/RjUKE3gUR7pL817TcC1gAgABs6zw=
Date: Fri, 31 Oct 2025 16:59:30 +0000
Message-ID:
 <MW6PR01MB8368CC4C901DBAF9BE19579EF5F8A@MW6PR01MB8368.prod.exchangelabs.com>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
 <394a9798-06e4-4e61-b081-eeecbc67a22d@arm.com>
In-Reply-To: <394a9798-06e4-4e61-b081-eeecbc67a22d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2025-10-31T16:59:28.710Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=1;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR01MB8368:EE_|SJ2PR01MB8050:EE_
x-ms-office365-filtering-correlation-id: 4e7d307b-158f-4dbb-ba55-08de189edbcc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1slQ2n2ahGCvBfi/I2UhzXQ6N3Xy4msnaU17zjtttjSqJ10xQRVKHdipUfrJ?=
 =?us-ascii?Q?usRtkYtFsb02RTNSYhEsxEtduTE0pn5dDD4dT20Ar686e/HYHAmqjkM454CJ?=
 =?us-ascii?Q?SgiESVLVlK5/KGmsTGCjHXEdOky3lT2MJJKlG+Ceup/RpufmMmjEzyQ6kIIZ?=
 =?us-ascii?Q?ypzwZUui+RnMgiI+nVMi9iQQKj94+UFxvEdGX9w5pU93GRUi0T/C+cbRiBsa?=
 =?us-ascii?Q?SbD57qy7N1E6sVl9C22StcxY1qOOTCU9vkLMfiXfQyU6/H8hJQFKSnjX+9MZ?=
 =?us-ascii?Q?igngVziKFs2bqecmeesbHWxj4gme6HexTr/vgeap3OPePVHE5JfefsiKa7w2?=
 =?us-ascii?Q?QTdr9jLSQk7aLhFME6m8n7OGIIFoH/upbZe8bQ55mk2X/Qa28irFGxEPMbet?=
 =?us-ascii?Q?W42HrnO3v+RNQdek7atmCplOHWYXY9E0pusMi9NdfQc8wZdMbWuK3HicF+yR?=
 =?us-ascii?Q?TACNHUUrVmIeuoaGSQyzybnAGsmEZs6Rs49kQ36918ST3Zj+uIbDNXYP599k?=
 =?us-ascii?Q?qwB9cHAwEQXTyJdTukbxVrOGSROEjvLRQYrVPsrAIXk5cIkWlQk2e22aRShZ?=
 =?us-ascii?Q?PY2w6zqULAeRfj2KIvLb5qdb0UCpjo14DBQYCfPU9jnNTuXO3SE9pbt3fk4G?=
 =?us-ascii?Q?dWl1X743GRuSCe8taLy+caQ3WZ0whPAN+uUJ3f09JjVTz7D5y/Dbhi8msd7A?=
 =?us-ascii?Q?+vF3QXS8lfA8cuZoqAshKJZTpqsdzFAMKj5hP0ViGEmXJrlCniuOo1HMNM16?=
 =?us-ascii?Q?wneytu5D/c7GbH67Qgn0gRgS37TpjUMX2BGd/tS5gJGyo8YWeWyvDE3OwcV5?=
 =?us-ascii?Q?keA+KYxClT7X1zYd2Tj1wp/Sdx7TcS97jrm1bfLulaPpR6Qubk9Jcl/OeIHG?=
 =?us-ascii?Q?BAMh2CypZs3VUnOkf/z1yKCU/5bBKBvpciVOkShwp8ggTeal/a9fCy/UJKz/?=
 =?us-ascii?Q?iIwz37xRdOsAEsTKNVizdbP7cPgqxyctQ2cqyk9sESriH/lGDof7T7g1mEoy?=
 =?us-ascii?Q?G4/GkjVv6pdlIDGPdG8EE7UEvIw89NMoWcs08ubYteH51LTLwCGTKKh86nU6?=
 =?us-ascii?Q?CSvWEStuW2nX7VIALyj1ngTKC4i+zaKYA9pK8BG7GW85ymg6Gpmvv/lM2p8N?=
 =?us-ascii?Q?9bwUWL5/dSQu5HU2DmG703d1DN9au23qCaVgnHzMe5DI+ySep7S9I8zW0h6Q?=
 =?us-ascii?Q?UbcqnFSPNpAm95qxDaMFOKzmXduGZCbdwpHZl8aLZBva3022nlxnJaIRcUtx?=
 =?us-ascii?Q?wassdzQwzlsTFrwCS4P9eDeAP8Ts0EcyEANubNrqxr20txkc5XCDXg+YXrWo?=
 =?us-ascii?Q?rUanJpiYofgjfh1EVJi7X+DL2oFSDSTFbcE6jo8LP/HZxwbfvU6H4+/Fw7y+?=
 =?us-ascii?Q?akIWvIEvAaYUu49vfKNvKstSmJL3bt1UHViSvscjQGtxHskdeXcRUWeEfduV?=
 =?us-ascii?Q?gepsGmQ1/KagxGAko5gKn7P9VQ6rNvt8558OahDV0kldhMt6gzLouIs2uO/U?=
 =?us-ascii?Q?/8m9Ebmi9wtETzxTjn5HgHQFnV1a4xcERfab6OyKVq0SMuMmAfV0qs8tgg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR01MB8368.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5RPiLrKwhbKN59gSc3eCsh2t3OBJaoOJI6+LgXsVG/IjQfXt2guq9yZYGndp?=
 =?us-ascii?Q?PapyonpBSBw4s/o4FuasHRdjjsrnfUIQ3ZxX9IDB4lNbzrf/TdC7UoPthkGv?=
 =?us-ascii?Q?7m+WTp1qBtuCV8IsrKQMJPkHQSjJd6IH0UKsUFi5Jk9EtdO3jto8D3230Ihg?=
 =?us-ascii?Q?c91s2xx2e2LvoP176AgqI4kWbv+cnIZ9FFf7jvl8MkDD8VWNs+N9B3cZPRUa?=
 =?us-ascii?Q?s4dcLWIqRN4/SJVXG9HG3iFsV5ae/HWnGazPfsVTQ8QgmGDIb/uDNevdO4js?=
 =?us-ascii?Q?iGTYLe2mb+IGo9cCT6Ln9Wzf00LPjTgB7sv24NTYuUzVYpdCC7j5H4hteiZd?=
 =?us-ascii?Q?/cJ0VsUrYDw0fhRIWPq/RfLkNqcGp0Pcb1UL8Hxjj8v2/Aj3kLzoA+prLgTf?=
 =?us-ascii?Q?4sIqMe7oWGeUf36Per80aspzIZxxoNyn3yUke8GmlO2FcSya6aLhr1UYYHK9?=
 =?us-ascii?Q?Z9kAFXIv2Xr+qBgZxKespYIGkywSL6ojH+GcO8so5P90oys9BN9f2hDftyQc?=
 =?us-ascii?Q?f2Pzv/7o2Nq4t1v+PBujsEfcQmLTWWKTblItgAwl5S1z7OlJul7sFwtazwCn?=
 =?us-ascii?Q?MFzWbFZg4n+Gv2ryS8nzHg4b9K5ZMNFIgsnu5kpfCzkW+o+Rewls/WvTBDej?=
 =?us-ascii?Q?Uq6gBqojdChjIvUnu3M/jVu5BNRdIM/V+PwX0SD4Af3P/ciRNS7vJlyx7kd/?=
 =?us-ascii?Q?5X4p9St1dWZtnVmS54Hzcmy6MTQNfO4AvgfRtTIb/M+MFq/Zvk+RDeLxBvpd?=
 =?us-ascii?Q?jHybXD6oTh6HRS2GJ1dqrUMVt8KB+MD4f1hz58NR6NddnnCQTBoH/3VuelPv?=
 =?us-ascii?Q?opNddHM+7mRPsPK0mY/j243P7RIcyoGx7bSvdLTW4U+klcQC4fNXzQqXaUdq?=
 =?us-ascii?Q?ylqjH88Ui3n/MzV5TelAMlSRlRazbwC+P1yt1Yu9z5DNGaT7aTAfNSa6bsLr?=
 =?us-ascii?Q?2VXdrhXHSo3PGJb4dC3hZGzbSB7+mRg0CZ24jKE3vpaRnFztN+A2dRD/q9jc?=
 =?us-ascii?Q?+0nq2kTCXuQS3v7kd7tEjA5xtPXlYRXb7n6C+xGFkSk4IhM8yoFGfDRWrSyX?=
 =?us-ascii?Q?BR6TIV/mpDfgZUi05W36bFsnZCfR9ZmOmR5dd+FB1/cekiwirlOJAOoxzKbh?=
 =?us-ascii?Q?+QeZLIp+huN+WNudNhHtHlvrnWwFm3rFFy4M41uEDFUXs+Bqy1AKDZcYxnx3?=
 =?us-ascii?Q?bRZ95dZprXbde+lrGTElTJslymJH2zEyYPEJal3e5ig33PM/SSZjorVCxwtW?=
 =?us-ascii?Q?Noj1Z4ZOECZ7DQXhh9NwgBMjAwawfiVq4cNrz1oVpPWct+fQMwBLAFXDZO9n?=
 =?us-ascii?Q?uGj+fr8ujDMnT6RvW2QUoJIrSa/SqhVarWRLFpDFZPiRaPOwF1U0NrvxFwPA?=
 =?us-ascii?Q?X0PCBs038qNVNOXhTW1l/L3dvmQg0uW8rfCirpNyYrBiadiUYslJ/5VpXSBZ?=
 =?us-ascii?Q?tqY5KWvXqqcYKuTJL4WXTHRlrf1FIbT+pkTCorKVNLDPiLLpdZeQ7gQNwFgq?=
 =?us-ascii?Q?Weeedv8hn/CJ19g86wuIgi1HY9w6Q9RV2LGLfqwIsoJMEYSa3SA60Yujlzml?=
 =?us-ascii?Q?ZwyZwCWpXP68bzxGDWT+jMcezBXLCGiw9sciGk24Me2IymoewBzNrMawGZUT?=
 =?us-ascii?Q?XinDEjrfkRMUF8MZApDnbcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR01MB8368.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7d307b-158f-4dbb-ba55-08de189edbcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 16:59:30.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 941GV9X6hmtQ8/uESmVbkCIzagwM+SbAus6pnZjRdmIV79MOTwbrBVyc7IS+gf0JF8hP8ahxt8qcWoEu9BQ+0rhJW9El4wfcE/N5Amy/CHeidb+zZerxjrBVahlpU8Ti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8050

Yes, I agree that EAS approach is not suitable in this case as they require=
 a heterogenous CPU topology.
The issue is that the existing checks are for a completely idle CPU, wherea=
s `cpu_overutilized` implies
the CPU is busy but not yet overloaded. I ventured into EAS as this `cpu_ov=
erutilized` relies on
`sched_energy_enabled()` being active. The point I wanted to convey is that=
 - we still need a `cpu_busy?`
check to make use of the cache locality - for SMP systems. Would appreciate=
 some pointers on the same lines..

Regards,
Shubhang

________________________________________
From: Christian Loehle <christian.loehle@arm.com>
Sent: Friday, October 31, 2025 3:17 AM
To: Shubhang Kaushik OS; Ingo Molnar; Peter Zijlstra; Juri Lelli; Vincent G=
uittot; Dietmar Eggemann; Steven Rostedt; Ben Segall; Mel Gorman; Valentin =
Schneider; Shubhang Kaushik; Shijie Huang; Frank Wang
Cc: Christopher Lameter; Adam Li; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup

On 10/30/25 19:19, Shubhang Kaushik via B4 Relay wrote:
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
> When Energy Aware Scheduling (EAS) is enabled, a task waking up on a
> sibling CPU might migrate away from its previous CPU even if that CPU
> is not overutilized. This sacrifices cache locality and introduces
> unnecessary migration overhead.
>
> This patch refines the wakeup heuristic in `select_idle_sibling()`. If
> EAS is active and the task's previous CPU (`prev`) is not overutilized,
> the scheduler will prioritize waking the task on `prev`, avoiding an
> unneeded migration and preserving cache-hotness.
>
> ---
> v2:
> - Addressed reviewer comments to handle this special condition
>   within the selection logic, prioritizing the
>   previous CPU if not overutilized for EAS.
> - Link to v1: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-=
propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
>
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb27959bc130d288d5f80677f75f8db8b..ac94463627778f09522fb5420=
f67b903a694ad4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7847,9 +7847,7 @@ static int select_idle_sibling(struct task_struct *=
p, int prev, int target)
>           asym_fits_cpu(task_util, util_min, util_max, target))
>               return target;
>
> -     /*
> -      * If the previous CPU is cache affine and idle, don't be stupid:
> -      */
> +     /* Reschedule on an idle, cache-sharing sibling to preserve affinit=
y: */
>       if (prev !=3D target && cpus_share_cache(prev, target) &&
>           (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>           asym_fits_cpu(task_util, util_min, util_max, prev)) {
> @@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct =
*p, int prev, int target)
>               prev_aff =3D prev;
>       }
>
> +     /*
> +      * If the previous CPU is not overutilized, prefer it for cache loc=
ality.
> +      * This prevents migration away from a cache-hot CPU that can still
> +      * handle the task without causing an overload.
> +      */
> +     if (sched_energy_enabled() && !cpu_overutilized(prev))
> +             return prev;
> +
>       /*
>        * Allow a per-cpu kthread to stack with the wakee if the
>        * kworker thread and the tasks previous CPUs are the same.
>
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-b4-follow-up-ff03b4533a2d
>
> Best regards,

So if you're actually targetting EAS I don't get why you would check overut=
ilized (instead
of asym_fits, what about uclamp?) but also, given that many EAS systems hav=
e only one common
llc I don't quite get why you would want this anyway.
Do you have a system / workload showing a benefit?
(I find with EAS heavily relying on wakeups, what we do in the slow path is=
n't that important
for most workloads...)

