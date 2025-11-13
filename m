Return-Path: <linux-kernel+bounces-898329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE13C54E49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9AA3A2915
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476EC7262E;
	Thu, 13 Nov 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C+lAW5ku"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021082.outbound.protection.outlook.com [52.101.62.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380F3B1AB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762993591; cv=fail; b=ql9y3rkV5IeJgIj681H4f28tUdQgNIkEqti/pDpWJKAwUbYcOjNcRpsClN70D/AuM8rxjfnnt5hilQ1cfG6Wq+Z1MUigh2caljO92AOttEUcg+4Z23OP5EhdA6UG/UVRRGJ2KHtc5Kllk0D5ue0tIYn+3zI7H11+OVo0q6IvcBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762993591; c=relaxed/simple;
	bh=2tXKSvK40YROBBxMRdPKdyBYEsMFdvH0pvn8/Fg/xBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlciTyWVWY3S2Ndjkn9ywao2AonpzLGXXbg0qkIzIYgjSKj8YehRH2+SH+i5UASFOeIr19hv2mz+bMfeKjvSrBQrQl1Uzbt4ayXpQtO90KQBuvZK0XWVHP7SwXyE8x1ymRVT/Z+gb15RxLGngO5s1o1C0f9OfAwGjMx0oRHHg4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C+lAW5ku; arc=fail smtp.client-ip=52.101.62.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlae8gewZ0/ObtFEJfIz1xA/V79wbBEj6jLYPOJhPrwUk/Tpakrv8sbRr+RbM6kb079vrpMdmzETVW8e/8WGOqDBox0+On74nOI+OLIMlHYC+6iwrMmx9MZzKialLdKnyHkzYt1tMV/US1MjPemwK/UlP+VVGOO/4/kkoX4lX0F3HMWhLDcjWO8Um03NeJ4ndKbTKnxOD3rDgheNJ+ZXjalkZpiFayyRTBGX3vaH11+hcnDiNCnmcoB1CRAxpUq9I3nrJpKOv0YGtobGBWGsgeee8UjXX8UJGFziHY0QF4+7rN5zqnUcjVSqi4tWmoWERLHHcbdK4N+Gxg5YJB31+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJRJJd9ESQ0oOvHXXj2efm0J9vRnekJvSZIGedR3Ryc=;
 b=YfqJLadiHM72VOkRTxY76cYdnrz7sFknCO1s/s1RrqIAI4T3KZYTd1Mq6yrL09mRSiJm1/u9R95Ex3nZJgexmlNkX8y6DFdViAA1xFA8M6NgXU+Ifdyq1IC761xXO3vZMa5JJ474/5joUH8ab7vWLnEl4RmKWBbJci0PRsXD79Ph18q3om94OtAEQhGq/bWfvIT0lKJkOy9W/Fkm9Z7Ujqxb24uJIDOh8ML0r+8sh2ONRImE+pWx6Y1f+Vb2LFP7mbctjWgt6apLlRCH+O/4DLYHHfOi60ueHtW5OKlHhFKugVnevxaGubPHu3Uj/drFwyp33FXZsbliNPPB99Na0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJRJJd9ESQ0oOvHXXj2efm0J9vRnekJvSZIGedR3Ryc=;
 b=C+lAW5kuVRZTLNGRNY6pQQJfc92UaQnd4L+zfTW5ZXw3rmi36hOl/7Xwso5BQE2+Nk0oz9FzKmNHeQkEKV5I0xGslTvloEOE/GtBJDlxS7sOp5AtYlbJkVVMlSUd2vUi7gwtuzIkTCUDQowNdT5k8sOzeG+SbGGQL7A5/sTh6n4=
Received: from MW6PR01MB8368.prod.exchangelabs.com (2603:10b6:303:246::7) by
 SJ2PR01MB7934.prod.exchangelabs.com (2603:10b6:a03:4c5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 00:26:25 +0000
Received: from MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4]) by MW6PR01MB8368.prod.exchangelabs.com
 ([fe80::1f1c:cd78:aa20:86c4%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 00:26:25 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Shubhang Kaushik <sh@gentwo.org>, Shijie Huang
	<Shijie.Huang@amperecomputing.com>, Frank Wang <zwang@amperecomputing.com>,
	Christopher Lameter <cl@gentwo.org>, Adam Li <adam.li@amperecomputing.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Topic: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Index: AQHcSdIkzb5ACY/RjUKE3gUR7pL817TgrgAAgA8jSUE=
Date: Thu, 13 Nov 2025 00:26:25 +0000
Message-ID:
 <MW6PR01MB8368D97F29454BEAB677FF6DF5CDA@MW6PR01MB8368.prod.exchangelabs.com>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
 <CAKfTPtB25-M9sxm4vRQVaYvGkZjyoyZUh-NQ0+rZRuv3szSZ0A@mail.gmail.com>
In-Reply-To:
 <CAKfTPtB25-M9sxm4vRQVaYvGkZjyoyZUh-NQ0+rZRuv3szSZ0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2025-11-13T00:26:25.255Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=1;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR01MB8368:EE_|SJ2PR01MB7934:EE_
x-ms-office365-filtering-correlation-id: e4ea4178-4cde-4549-e8d2-08de224b47d4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CYtKN6k1sOpy/yChe9bHhuN5akx30+9OVLTTcMpE5OVJPBAeJ5+HnHpd+JGa?=
 =?us-ascii?Q?BHImPHTBFd+cKrEWShSTvzLWQTA11QFIOKNt/vya2KZdIw97OBm4XQE54Coa?=
 =?us-ascii?Q?x7EJQArtfhbMU8gxgiakE7C0adJPd2wl+6doXGVqkbrilGg+6N+dSFbEEcz3?=
 =?us-ascii?Q?jS5KlSeONGj/UBNRolidpDPsfbKi+4+Ym38/sDLhhHlUinqTrcDfa0LRoXGW?=
 =?us-ascii?Q?wlDxPiESZF7tZAnCNmhhP8BU1noVdcYkgtzRsxGjaLs+tIAQXkmU+junqWWL?=
 =?us-ascii?Q?p/YrvMdGb8dTE8K5LiyELGRlCUof66VT+kYEHGl7uf1DGTDSQn27yrS+XRIT?=
 =?us-ascii?Q?U8GpZyE7fCXEw6R8NphG2yWqSXLhHCLPdUGRNd+j0xR8w5h/sX0qpTxsbjix?=
 =?us-ascii?Q?yOjpdCK+OVdUhKsLFuV8zU+529NQp6XsqeI0UWi6WCSD00VLYpY5a03J4vF0?=
 =?us-ascii?Q?z82SdxyqTWOVy95kgWL7To4OnkBxyUySXWH4PSRxJRBywgbRm7a/ocigmMMF?=
 =?us-ascii?Q?q18I8UDXqVBt+igdLrIxCQqVnMMpBUkp6RITwtbRCXzPCVwFQyoROotY4N77?=
 =?us-ascii?Q?j1rnwnCzrOoEmcMgUZejCYcetqeM9aAYyEj1pR03A5fpcdmTahSzTUJNFr7y?=
 =?us-ascii?Q?P74VaNDVNu3I+Z8yxNKh7PJYkciSEl5DlXkLNYoU7iCzz1Pdjzoa3MQrafum?=
 =?us-ascii?Q?tXQDtzUYuJN9boz4FHgSCHv15+39ut78t3PgcjHO61XPHyLtAv+IDdpUKrbn?=
 =?us-ascii?Q?p1JsuupuM7yQaDXlstX+/Wk9Qla5m6KyXakQVNWNtQiY4BZQixk2sVfwBJPK?=
 =?us-ascii?Q?3FQ5C/TUjZK6oLdmnEXXnXejJx4FOmyXnG89d4HyjAXtUqjOEwBt1ikd/jYH?=
 =?us-ascii?Q?XEXoHhMMT/XPXBKsiZP5mMD+ehgY8r2TwjaLw3xpNLAyFpYIz3N6wh5JVyrk?=
 =?us-ascii?Q?FwEWHr1D9TCQzrm0mmyFVqtf5p3pYasTlLQBfjKI1U1C1IB9+PSdomAa/avu?=
 =?us-ascii?Q?+OBIdbp9PcdR226wkIvNhALkOOeoupJ5wwqfCwcL6SKQKo9TC1yhZ386xxlX?=
 =?us-ascii?Q?0rmF7z/467H5tyLX+qz/hCPFoIOojcuNIhxi0WqHoScqWhQhbC179DYkTiVa?=
 =?us-ascii?Q?RsP1PkoCny6wyueOGgqC2X9dfI7xaICJ76OqNOG+dd329/bxkrCpmGNmIoaC?=
 =?us-ascii?Q?wZHQoMpz4BkMWJbh0o8uhWTvQwKvetStSVD30vr+MveatrPk7NVmUj6vF2to?=
 =?us-ascii?Q?3ikGipHdI8C6NNru5qt24+CHxTrhTvM/Xa/k7fEQmlud7k8kecaPhZwddWST?=
 =?us-ascii?Q?dl+EENMPK6kjynTCDPr07rwjM1cUVoPCetYJJdWN2dsztxKOeElidnlvyU3v?=
 =?us-ascii?Q?rS1G4IVrdc9vsXuXvMZXaIGaZmlIl4GHOcHfbnmFVKigpcFAeAByeQ2y1bhY?=
 =?us-ascii?Q?WDl6CNaCLu+2YLmlkN+iTIg6FVFBBAgDzZdsbi3FLih0GzI7BAFRSVmQBG4J?=
 =?us-ascii?Q?bPrszTgmPzEDElsqN4W5RJbTqf45ANh9bvpt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR01MB8368.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aOWMYCPjrIBpaLQ69idBn15X8u6xdX/X/Uz1tgBCzettZjkp5qGTvvlC78ee?=
 =?us-ascii?Q?kM1CGc4XgH1hf6BuFdloT0p8hLrlcmbpuni9FoLHqsKDHy90jIpxFClDbZuK?=
 =?us-ascii?Q?ejfBUw/Sr9Omds53cqSO8E0uln9xAfmPiUsIVBybSWsC4R6jjCvkh/qKJqOu?=
 =?us-ascii?Q?RMlkMvBeNbG3u0BJWYqb02T+LhSp6QKsDR2GxyjKh7kAAbRmQqOV5GkqoeCb?=
 =?us-ascii?Q?c+j/HqPAUmVo90rPAi9AB0dPeBcFmR5BBkRZUk2WFWr5eIK7f/KSZCsy3Xwc?=
 =?us-ascii?Q?uzW4j/UXyfbOCd4ZHOPYxB6W0bVA2+xT7fPuZc0wf7vxS8DvMu6xWE8vzYjk?=
 =?us-ascii?Q?bYsEttQT37pbGofk38XI6sVp58eP+gRkkFWPVu5LogOR3wJ4ebaThUCpjoH8?=
 =?us-ascii?Q?kAp18YA2ne8SLogq7OIRWYP6fgeB9SL/rKRxEBsNAeIWQaHqB6hIcc4FMoLp?=
 =?us-ascii?Q?VDrINr/oRzp5TUIM/yWLqZ8ofD4dE6YVM+wdkZOpfU4ltir4QDu9jCUHPP1e?=
 =?us-ascii?Q?alMA+24eJUfK8XWwAFZlVap3pLpyVD1tVJOSVp02ku9KrwH5MGsNspW4FWO0?=
 =?us-ascii?Q?+GoMRJlbSScorHZPoqQ+CkjqP9eIEVFPurtVxu8wHqmE4VbDCsle3cbi5sB5?=
 =?us-ascii?Q?e5JCEjU53YRg0K2N8NGpzmSRwTHcxrPW4zoJfxjbBqJvYj3p8/JE+Nk68NrZ?=
 =?us-ascii?Q?3yrXupxksLT6UmN53XskBrTyCZmVXoiGk4zAGBUfhzQEnGrsdfP96XT3Ibqs?=
 =?us-ascii?Q?alhxFqL2mR2k9ABbLhsiAdC5075E1WkZKxnRrk9MbnleDKTMyK6/tqNLDIE8?=
 =?us-ascii?Q?J7FmTbWWp2JR68TE4siT5M5jmYa7p1wTR+UwOwJq9zrBFmdr3kXYmMxZrr2g?=
 =?us-ascii?Q?D6EgHWPKY/jU1GhVbnjvDMX/Iye0IKSW9zpt9sOWSKDd9awIRo1TBkgfHdoy?=
 =?us-ascii?Q?DWETMJZoICPJHsZOhuh1s7uGkiH4AeKrnDY+iw0Zk/EbY9n8IBU1JaJjaKEB?=
 =?us-ascii?Q?GkC/ghlh6VQRDcUXs0MsZwEic1VRJTA/GjRbaia30LlpdSoXUHGHBSSt5ugD?=
 =?us-ascii?Q?8gydAPWYJM/bmUHf8R0n+Du7Fw6SYVehi0MxWm1Zjm36pSsRGHrnDsELcPtv?=
 =?us-ascii?Q?HNWUoSGxf1+lRrQP/2n8gHqWNYNd3xL6pStymK9K+EQl+PLA3Vr+rkrRWDvG?=
 =?us-ascii?Q?2+5ju9Lve4dU1RMZ6M/N9+z2ucvF6yNy9gCBxVtxBErgQ2olAPN2zt5p3yI+?=
 =?us-ascii?Q?Jun36e1Vcm2Mka+eRzs3S1s68z58GMJbwn2yzw7PBt7fD08ZkUdmNlvtDyMt?=
 =?us-ascii?Q?8T8TKlKbaKYLqDfxbdds01yY5nedicrsJM+N2LBw8p3ljd+sEKAbhy49h1Ju?=
 =?us-ascii?Q?NpW7Xfl1+WahW02mgBGKPyusVHagh7zbu+ayC+Mwk+pvqQUjQ7TVAtDl5gdR?=
 =?us-ascii?Q?NWStuf5/cNRR4McA+8pqhCHKcXpLk/32DmNni9kjmnpUsO4W/8XyYMj3RxiG?=
 =?us-ascii?Q?O8cy0wmBnKu3un0gITyfFTNXSV83nbIasLiX+Kx2gUtfUth3vWN2CqVnSRAq?=
 =?us-ascii?Q?mJa+qvqQ81ONh9ruNziA7/A32+XI78gHTu8tu7ED/93vTiiHZfPw7FzIaRwu?=
 =?us-ascii?Q?rA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ea4178-4cde-4549-e8d2-08de224b47d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 00:26:25.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ayz0eiJ8HeBvzvc65YgdE5gGtgMolgxe1HjdnBJK1kimO7gcgQjBS8okRUehGD7TR2r2Fy/NsE6SliP7lBk5XtJf0tYO1fvebEb2+B6iucgLADR45uEKyxkpgK3xItDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7934

> From your previous answer on v1, I don't think that you use
> heterogeneous system so eas will not be enabled in your case and even
> when used find_energy_efficient_cpu() will be called before

I agree that the EAS centric approach in the current patch is misplaced for=
 our homogeneous systems.

> Otherwise you might want to check in wake_affine() where we decide
> between local cpu and previous cpu which one should be the target.
> This can have an impact especially if there are not in the same LLC

While wake_affine() modifications seem logical, I see that they cause perfo=
rmance regressions across the board due to the inherent trade-offs in alter=
ing that critical initial decision point.
We might need to solve the non-idle fallback within `select_idle_sibling` t=
o ring fence the impact for preserving locality effectively.

Thanks,
Shubhang Kaushik

________________________________________
From: Vincent Guittot <vincent.guittot@linaro.org>
Sent: Monday, November 3, 2025 1:04 AM
To: Shubhang Kaushik OS
Cc: Ingo Molnar; Peter Zijlstra; Juri Lelli; Dietmar Eggemann; Steven Roste=
dt; Ben Segall; Mel Gorman; Valentin Schneider; Shubhang Kaushik; Shijie Hu=
ang; Frank Wang; Christopher Lameter; Adam Li; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup

On Thu, 30 Oct 2025 at 20:19, Shubhang Kaushik via B4 Relay
<devnull+shubhang.os.amperecomputing.com@kernel.org> wrote:
>
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
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 return target;
>
> -       /*
> -        * If the previous CPU is cache affine and idle, don't be stupid:
> -        */
> +       /* Reschedule on an idle, cache-sharing sibling to preserve affin=
ity: */
>         if (prev !=3D target && cpus_share_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>             asym_fits_cpu(task_util, util_min, util_max, prev)) {
> @@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct =
*p, int prev, int target)
>                 prev_aff =3D prev;
>         }
>
> +       /*
> +        * If the previous CPU is not overutilized, prefer it for cache l=
ocality.
> +        * This prevents migration away from a cache-hot CPU that can sti=
ll
> +        * handle the task without causing an overload.
> +        */
> +       if (sched_energy_enabled() && !cpu_overutilized(prev))

From your previous answer on v1, I don't think that you use
heterogeneous system so eas will not be enabled in your case and even
when used find_energy_efficient_cpu() will be called before

select_idle_sibling looks for an idle cpu that shares the cache with
target, Isn't such migration inside the same LLC good in your case ?

Otherwise you might want to check in wake_affine() where we decide
between local cpu and previous cpu which one should be the target.
This can have an impact especially if there are not in the same LLC

> +               return prev;
> +
>         /*
>          * Allow a per-cpu kthread to stack with the wakee if the
>          * kworker thread and the tasks previous CPUs are the same.
>
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-b4-follow-up-ff03b4533a2d
>
> Best regards,
> --
> Shubhang Kaushik <shubhang@os.amperecomputing.com>
>
>

