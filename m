Return-Path: <linux-kernel+bounces-847332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0FBCA8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D91895ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5986331;
	Thu,  9 Oct 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4xG3bYOw"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B4246BD7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033605; cv=fail; b=YO/YTt/SACP4qGL+Cz6UNSFlS96rllBDi/MgIulcuh7XVl0HN6mlKYBITcp7zT4QjTXksKc5Vfdp4WdRr8p2Hd0/8UwKbl6T3x/nT8IBl5XP9+ddZz0xCPqKdRgLNELAMJIQLlP6x8c5l2rmszR/3/iD5u54RUfkFP6gXS+pdBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033605; c=relaxed/simple;
	bh=2GoyhUMZBvD3JCOKXnc+pAamnKTgR0bNgaNp4rI0QBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2leXXCHnoF8mLRuPrpfzak/XDZsbO7gZL/IvDq5bD4Wo1LB24hFsLqfkFAYlaDBtKdKVUnzIXohLBRde4s0mbzEGacxRsBSlIzgrnuvl9LlBZ2aGgJ0MGKkO/kGtY985VVCSunSDKLd7qMSKV5hFlj9RwJyc0gssffRUyDkUbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4xG3bYOw; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDXMzIJP5kCYrHk4uQ3Gs/hBUNXrvboJNyRwoUXurJZNgSsp91/AyQ2V3WtVzBArhg9GWPMpq4wzxPiNtPSAePpWSP0FiPR8m3PwD+XAtaoXXVObD/y0sDFmJFb0jmEWalyK/qBKMT4py7MyCszgeoA+4oL5loggbAL9HSRKnUaXfbzvM1hwYWUHwuXImTU4PID8eCIkqzK33pAb33eaerGm58c/Cz/x0NLyOSPmrJP7tApk6NMWTv9JcKc/K0c803cGtHLkbIqgxlJgYVM3EGugWbelLkRz4M9J+KjRB7ZlGLXzL2hfMC0xQVSVwu2tMZW/ahqC+6r77UFHnqufFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GoyhUMZBvD3JCOKXnc+pAamnKTgR0bNgaNp4rI0QBo=;
 b=LIYOxWbIILAAHwaQZKCj8bnDS2+NZUm67bDhj7gdsDZzIiCWsBbVuulWz85I5GPRvWgBLTXHNGlAFdE8nGZnMT0K2h7QNXNOvrZnRANUsFjYTHPEXqDzp/KqGPUEk6wDUb0kASNPQ+j29HzNxicdxlN5HoOR6/lX71XAr6gKJvNVEJuFBrBjOCAwxkq4Tt9SpKmh+G2zDR57Ltm+DjcW4Qrj045nvIa6cSuM8FFK6+1MxG4Lp7WQU+4lNKNXba2UEuL5XCLzE+pa2JJb3DwusgHjq9ebohJTVbVW4vn/xlT02lLlmvl3pHgyJtRjHLwfI3nvLuRTzQSwo9yNFhaD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GoyhUMZBvD3JCOKXnc+pAamnKTgR0bNgaNp4rI0QBo=;
 b=4xG3bYOwxM9Ey8h0Dx+bhzI7wMzSg6sQuPt1Pj70Zdmip2zoVPcWJRwrJ8FxvJt4CdZEAZZV7190ZJUFR1NQ5HxsdJnm7xzsA35bDzMHE6BFIY77i06P4SLQHaU18yb1KQtApaatXdTBZEs9KVshwlnpYzS6NsMnBgljj5d+E3o=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 18:13:20 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 18:13:20 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Klaus
 Kusche <klaus.kusche@computerix.info>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Topic: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Index:
 AQHcNsLPYAWj0urMzky4n4OHi8ST+rS1I8EwgAADDACAAdp8gIAAQCGAgAAPnICAABJ7gIAAqaAAgAFKggCAAEY/gIAAdKqAgAAQAvA=
Date: Thu, 9 Oct 2025 18:13:20 +0000
Message-ID:
 <LV3PR12MB9265301AEA5D0EDB672DC7A594EEA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
 <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
 <20251009171331.vplg2zcfystojcxo@desk>
In-Reply-To: <20251009171331.vplg2zcfystojcxo@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-09T18:10:48.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB7842:EE_
x-ms-office365-filtering-correlation-id: d15bc2c3-a6a7-4dfb-8677-08de075f8750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ClT7+OBnKaUme8NogFpYOKGuvMuWB9JNcZ2hiInJDlGVpwHM7qVdz9EeuYWO?=
 =?us-ascii?Q?kPutzmKTjPFgvBKhpt7bzR/4fbdW1UJcn+ljTVzjSy3f1VXLop3ozHAlo3kZ?=
 =?us-ascii?Q?ucGYBvMkuzD9Kn7hLrJ72u+Dz6hOFg/IsV82prMvEB4aYmTrKavvy/ownWiW?=
 =?us-ascii?Q?3rObdKNBVc6lyZLj6gZtE5EjZKa4tXbyy/CfMJs5fvWyqD0WSuUq1eyLmAcz?=
 =?us-ascii?Q?G1DNItwFdSDjVOb1u5IkXYToodA9SxXEX21p7wtsuVyU1UBTHXbTmpl41UFA?=
 =?us-ascii?Q?Jojh15VKZjUC0oNAzgeUm8aEW2ZQnRNbOSArMjVdoZqBRXS53+G9xst9dAhy?=
 =?us-ascii?Q?FCIQoyK0xWjoA9803SZKKF32VRw8lpM1ZdLocE5XSEPO1S6WXiAUkIXpuKqY?=
 =?us-ascii?Q?4AbyxRcqWqL8N9lpSKEetFsg12hOc2bVl5yjjSaPt18BSFsIrsfiJhaLuIdk?=
 =?us-ascii?Q?EsnQ00cpiIU/xv4RF4Nkzh5Zk0RkdlHBsq4EySivTsEq8ybOb/AmF6WCZm7l?=
 =?us-ascii?Q?M+VnlsAdID6I/yjDWEYl81ZInJ2kxN289lNx/d8J7F12I5HVir6va9tMt57P?=
 =?us-ascii?Q?GZgRdGRw1ytvExdX/MtRK4udF7HPT4fXZUgrdhT1rqQ7IfVDzCxAlTI51sio?=
 =?us-ascii?Q?VHu4E31OsUiYjh9MiwJ7W+vyWBslZugU1NeVUI05BOvUZeuAL8Hag1arTs1A?=
 =?us-ascii?Q?NS8xGySNDRnfKJ8mnB2tqS6HRkD01GAsDdCeTUV8j9017Z6QyjiC88wv+em/?=
 =?us-ascii?Q?qQNlOSBp15btvBAMCGuTMGlC2eE8O336GpmOxrL/xWrpnEze9L2T2l1GDnUn?=
 =?us-ascii?Q?NxJIe4Cg9VWDS+c/9rLn7Pp5Ab81RHjE8S3AfGnHJLMTZDguMtYTqgeldH/t?=
 =?us-ascii?Q?L4VWQ7WwzrQbmhw+8F5yrXwV81+HNtLoXexaUynMmCyierzhy6NIiLgJZHOU?=
 =?us-ascii?Q?Dd+fkEsJT8FispKBAZNElM3DefVm5PY7cFtd0wIu6G/IUmkwTpb88ilLdFda?=
 =?us-ascii?Q?tcL3hjI3t37Y6cIAvWEbug89RwzIMIYDZpA5e2A0FZ+6+uIR0jT/sgb+EwtH?=
 =?us-ascii?Q?4jahuNI3p21aL4HXVVP0a6O85N0h4ZmTXehR95y0PHW0nY/VDCuw0j6zU5pU?=
 =?us-ascii?Q?in3MWOnBV8o0EIpKoUEAZHd/+9HLEe0/aZ10rDgVOaRJt/1VujmnrzOQbUS7?=
 =?us-ascii?Q?26pB270T+Z1jcxhdh0FGnSjD3dCAnsoKp6bDsPnQMqkK5aJpPQdVjErLcjxu?=
 =?us-ascii?Q?F075PNebHU65d73MZ317l2WBtBKXJw0Rl8m1UPVScJisaNfVVze3h/BtDTHh?=
 =?us-ascii?Q?D+TzVABh3imo5+gNcenWj5HxbM/mSujoLI/1U0cbzYjSe9j+P4KPcB0MYptl?=
 =?us-ascii?Q?BhKCNUx5GTdQx0F7NkJPIXraKeeFU97G9c+kTkxBjL14TVwo+J+3i1Hw5mCA?=
 =?us-ascii?Q?9J0u5vEo9HFGyt5iA5M3zfG/8XnOf0RirT7Dir39P6TZfwitQTTOoHVgsCCK?=
 =?us-ascii?Q?wmTNIrBm+YgbFlQtz5aQcFQ+PKgmue74g+a1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/Xoh2daUbuzJfJjZUu2WAae4IUUheOEaR9V2y1cHuhlQV4MZTuYUPnLx8cUn?=
 =?us-ascii?Q?3N4dYtfv3ptzzhuOiENfqS7iC8QBZb9e4Fm/wrI4JXL/j7RJgJcXrit1JxVW?=
 =?us-ascii?Q?2ElcnkoUF8Sd7lqicMHLPJJ1VB2rfzolrL8EmAjannsNwmMFXutWGqJm8x25?=
 =?us-ascii?Q?CJRN5JIsqn717vYnjVobdEgeF4JoP/tP6v+QgKy6TTRrS4IIdNmNc1lyEn4t?=
 =?us-ascii?Q?ZFCilVqelBvxn4KEIxUqyjrixfh7IX9vGtHqHWKtn7gHNWmSgs0nnbH8CJq7?=
 =?us-ascii?Q?TU3XlW5H8ukv5Z7meSKCbO1qetGazfgUKcBa8xUoWKFcljrF4LhQiLY3jhLg?=
 =?us-ascii?Q?bW6bhuE8wRcIEtAhs9qhncya2B3uHvUPeVjhi52E3646EKwrNPnbHs+7vo/k?=
 =?us-ascii?Q?7iRI8g8+/2xY4PRJNpANHklADtRZRS4odUMnoZxuzWYjrEBFcPPoJyjdlW7a?=
 =?us-ascii?Q?RvA3jHn/Iu+4jnToM8W7598/+TlH50A5bMmRoszmkf2JL76zJR2tfLUYYIJ9?=
 =?us-ascii?Q?DuT6oVsMkMltMhrMDShliT9vOwcBCx3CY4Zm+RY4KoxHcLuiEEC6d0t+FEL6?=
 =?us-ascii?Q?d8tKwE+qPbldkIIf4ElcY2UV8BWSWzCPfVEWwlTsik1Jean3kd4JxbnysmdK?=
 =?us-ascii?Q?nNA09+TtLxqbtPSy4hIyFePlj3VvlhbvkQjrJXUooEiQ0taU7qEg6rkBCCxH?=
 =?us-ascii?Q?hd3LQ1gRsp69l/u3zpAA6bkYDFgnQpSviJ1boxzzAwvLl9B3nFBXQalFIckU?=
 =?us-ascii?Q?xkJRWRiYGwzk01yALSuerHlghh7IBHYj0c3D5C5fn6+0Jls0JGAPqyGpzHxO?=
 =?us-ascii?Q?9xFjQiQucKOqsu8WxmHrOEdgIEF9ufhb86c0lyoNpPwAhkTkQllFiHDOuMKx?=
 =?us-ascii?Q?LjLBPLaPkoWhEl/iAGW7nsMs7dFnZzGjRs2IVaP7JN0EWOCidE/FeC/GyBw9?=
 =?us-ascii?Q?eziKEeWrvwE4yu7y85VugI4PGWPBHZfrwF3lt3IXXmJHvl/YgmhvBG285RV8?=
 =?us-ascii?Q?kPN069pi6QsRWmW5mrcJlpud7bshiFRdgBfM1vWMyezzOcHpBZwObs/MMSKL?=
 =?us-ascii?Q?KLJjVbqGBZNwa+Zc7UReqA44VsVOHS19jbQOfr7pxZdK3VF7y5o6rffQA7sh?=
 =?us-ascii?Q?Th7pfJ27/l4+dAfX1VqdOzhOZWLUpFUtri2bj37VRvwtDx8kH7/zv1EqV0Nj?=
 =?us-ascii?Q?/ZacxmmAsDA8edoQ0WA/iMyE1J5ZfDpWJz5BQt8ZKq8Y/Nf3SB3ejFBmNsm5?=
 =?us-ascii?Q?EoN05j9qGkNthzvl0rLOyLbYAAUZjpRIqYgThuQ7Yk6kI0mCU2zjD9R4WDpd?=
 =?us-ascii?Q?VT0p8NfJsGkk+SKYEtj1KnlElAfKg7y0PEO08ttp59F8Q9Bzd/CxsMGjSZ0K?=
 =?us-ascii?Q?44hebZFdzM4A312LGRXbhIXKYV1Nx1Wd+oBooZh2SH1HEbOBxdKGmiL1DJ7M?=
 =?us-ascii?Q?d8VvYNdCsIiDx7Esd1watc0pd82gOrsvsGjNW1Y/Cyx2gomPVvDFUFoihnea?=
 =?us-ascii?Q?6USxx/wAIk5nVwph1RVkORcuzyw52kDYZnYqX826kT5k2GTI2JFfXXxOAb1d?=
 =?us-ascii?Q?LDwm+a87hPxK8kWBU6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15bc2c3-a6a7-4dfb-8677-08de075f8750
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 18:13:20.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Yge9Es6deuQ/0DO66PBYwaIDAtA0lecmL0Dv4ZO9Uau8LR1/i9aajp73qox2J17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, October 9, 2025 12:14 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Kaplan, David
> <David.Kaplan@amd.com>; Thomas Gleixner <tglx@linutronix.de>; Peter Zijls=
tra
> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Klaus Kusche <klaus.kusche@computerix.info>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Oct 09, 2025 at 12:15:57PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 08, 2025 at 11:04:32PM -0700, Pawan Gupta wrote:
> > > Thats a lot. OTOH, most of the bugs.c is __init code, do you think it=
 is
> > > still problematic?
> >
> > What is wrong with aiming to not have dead code in the kernel if it can=
 be
> > removed cleanly?
>
> Nothing wrong with that. There are certain things (like I mentioned
> earlier) that needs to be moved out of bugs.c.

If we really want to optimize a CONFIG_CPU_MITIGATIONS=3Dn kernel, why not =
also look at alternatives that will never be enabled?

All the extra NOPs I think can affect performance in various ways and if th=
ere was a way at compile time to know that the alternative would never be e=
nabled (because the feature is completely dependent on a cpu mitigation) yo=
u could eliminate the NOPs...

--David Kaplan

