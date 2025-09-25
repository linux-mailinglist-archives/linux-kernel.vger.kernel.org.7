Return-Path: <linux-kernel+bounces-831996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C0B9E1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4439F4A61B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14942777F9;
	Thu, 25 Sep 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HW/fwgFq"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429B271A9D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790073; cv=fail; b=DdWYkfycLgDPTG8PMqUUOv8SEs1HXqrTHEUeaA3O0LlyA+B0l5ALsTzpkBxIncsveiIFyh0WbXkT2D3Xg7ZmCqn5nBU6hZTKk/cmTwa5djrkPFfs6FgePaGwU5xp3voKQwyHmY/txk4E8H5orGZZJlOGy3IV5XR8sF9tbG9cDZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790073; c=relaxed/simple;
	bh=d/Vhsf6OUZL42ADdkILxsNfiQBh7PEmDMFv8cRDxKgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kcHI/iQrcO0YBop4PQdK5n+JelFcy8IqRU/D/utkaoXgX1ixf842Nl14lubRcQj2mu855SBCCRyM2hPS63rAE3AfNTw045vJWCsMSd0jxLTV6WZ6Fn0lKumSJJPu4bFF1QoEG8U1TQVkuKd8UJ8AulmSxU9C6NcT6lftC2CwUxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HW/fwgFq; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLucPrTl3FS4372UyM8kKK/e9J2sM/sOLRcSWn4S6l77J540RASI0BNi+Ks5fl6ZrtrM2D1HixJu3DmuNXgQHMm3nXIMCvedHrPvGwt1zoVFXBcaPCxBHCa86E8b94s/9QrSHe0l6ARU/bx69KZBMu+hgvn/edJT4IJCcPFuMtPYfIyQiT0xNjlIE9HeSOMF4Ft1BnScP4aXYmd7dZ/T1w/ZM6Z7kyBuLM1xxsugnlPJ888b7sMSH9kQ31pinfo3T2LOmICHIxCKAwPQJeoVvy/cmKkS6jKEwx4phMYyLuKpPaUwvM+6L+/0fR0xp3y2WmOg9iH99w+ec+BcqOOLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/Vhsf6OUZL42ADdkILxsNfiQBh7PEmDMFv8cRDxKgc=;
 b=uZ0LUSJrs/gID1DFZGIGimFHgP1y3iK9DZdgzyDJUQ1jAkya9iIyGQx3Ty4mdCtjZ2Sl4eFjajGdvkyJhKGzXTn8iWPOPVCI3bvxVtIfKasbXAyKMA34X6e4DNBlaaIsUJjRWoHssEOTAuRG1X/0C1dQnD76sbcGgmvO5cgvO+UyZLTw3CAdwNPMHxwtoq7wBKM25GK9DN3AgcQG3j6UcxYK9YVLrmvTe83cLJ3xs51eLmxoBliLU1iBZyw8U9HHno/hhbisa56wXZE0Itiv1rRXlQAn2RkWmPrgvrUhqbxrXGIJp35q7CGK/+9Bs2BTe88qwSUBhbZ+YfK4+Yflhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/Vhsf6OUZL42ADdkILxsNfiQBh7PEmDMFv8cRDxKgc=;
 b=HW/fwgFq8MkwDLN7FyidQeKEhpQyKtr/16a4f5ClagZsIpFzP19zSGNv+pP6SuMJM3fpvH1e/LB/Y5FRcOBlFU1JedQmEPDpBVTZU5gaugEITGe/Pj3reuBTX6x6HZCusasWKok1t1ql8g4uX0k9ey7vEyAN2f521p0q4kXICRo=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:47:47 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:47:47 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, Jorge Marques
	<gastmaier@gmail.com>, Arnd Bergmann <arnd@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jorge Marques
	<jorge.marques@analog.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Topic: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Index: AQHcLZBu2lcu7eR7HUOLh6RNKtQOPbSjfYIAgAAEBYCAAAXEgIAAD2lA
Date: Thu, 25 Sep 2025 08:47:47 +0000
Message-ID:
 <DM4PR12MB61093CEE50990ECC403D3FB98C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
	 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
	 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
In-Reply-To: <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T08:47:02.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|CH1PR12MB9576:EE_
x-ms-office365-filtering-correlation-id: 004ca160-1bd3-4df2-7bda-08ddfc1033b9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlowZzErMjJOeFEyWUViVnl1Z3RiRzJKZXFoUUg4a0dYUzVBME1ER0JQWGt2?=
 =?utf-8?B?UlZBZGgyUDkwbTU2VWtFUjM5SFkzMUZ6bW5icW5MbXNPa2F5OWY2T01JYjRm?=
 =?utf-8?B?RkZyKytPb1JGakNnOXl5RWRoYUc2cW1uS05zUWpuR2lLbFZ0Qm1iSmRWZjJz?=
 =?utf-8?B?b2dIWjQ0N3pzd1ZhT0ROdmVvZG1oVzQrQjJqckVhYXBSaW8vUHZqaVdKWTVC?=
 =?utf-8?B?NXNncHdiMFpYNUh2cXRwVHhMb0hxeGVWbjI2RmdXZlhNdTkzQ01OOHJzK0pG?=
 =?utf-8?B?Z2RON0o4WnlOeUxlL2sxSEt1RSswd01xSGd1UFc5VW5zeTIxeTZsQjcrR2Zm?=
 =?utf-8?B?Q01TN2Y2YXI5WVROVkNGQXI1dWlnMk9MalY4dVlTZFhhRVZFcXd0T0xjbXkx?=
 =?utf-8?B?RkhhdWhvL2JjK2c4N0pnM29uWmhyOGZLNkluQlNpcXhDTHdBUjhQd0ZzVWtz?=
 =?utf-8?B?aHgvTFBYVmtPU1hrODk2bkVMT0l5Rm9qZklhQnFBMXFyMXFCVVJmQ05mMlhG?=
 =?utf-8?B?ZG9OcmpqSzdndWxIemNvbyt6Q295NmgxVlMyMGRhd2NmMHlobWJIOG54ZUJY?=
 =?utf-8?B?eWhGbThqU08rUjJnV2dsL2MzaHJtNTJWck5YbWF1U1luVVdob3ZKRExIZVBv?=
 =?utf-8?B?alZ3RzMyalFzWHJhbDRYSFV0UzVDU2dVWU0zZmV4UEU0MFkzYnVRTlFOM1A3?=
 =?utf-8?B?aW9ZK3lzcW9nbFA2RHh3VWpxaGUzS1pJOUswNC8wdmx0Z1hxQTFhNE54T1Ev?=
 =?utf-8?B?ZmFIQkxnV2lNdWMwb0RoTmxoejNGYmpyNXRmTVlZeHpSQnVFSzdYV2diUTc1?=
 =?utf-8?B?QTNtYldLRjNrR3gyU0hjTmV3aEZkRHAyd1RzQitVL01GRkkrTFkyN2ZrRzBF?=
 =?utf-8?B?VU5pY3RYYWtDY2RkU3NkNE1lMGh3SE9kQytRVzk1bzB2ekxhR2l4RHJaV0Ra?=
 =?utf-8?B?UkVsR0tzVHJHd1poUU1pd05HMGlZTnh2WlMyZ3dKcXZwYVRVMjBtWkpoWWxa?=
 =?utf-8?B?RWk0YStyek9PUlJHaTROUFFySVJyTnYzcWNSTXZjMXNuSUFUZ2R5YWN4UUNq?=
 =?utf-8?B?dkpvdG50RGdXT3JYdDVXQ3JWSkhzdHVWRFowWEVWVTFrMXR5alBjUFQzOHlB?=
 =?utf-8?B?VEM4RnlZS1Fid210WFd4emEzWDBLL0Z3cEg3elYyUGhsTVRtWHBEQUgrRytF?=
 =?utf-8?B?blEzY3NybDZCNTdxdDlRMnZ2QVgyQXJTbzBmY3N3aXFoeklSRnQ4YnlKejZG?=
 =?utf-8?B?bEwzSmdRR045NTVsUUFOZy9KU1YyeDNqRW8xZWducmJDaVZDbUpxNVo1MzZ4?=
 =?utf-8?B?YTRIN0xYMWZqS1RvZitWcW0wREs5cC83SENtU2hVanF6TlB0L2orUVZ1a1Vs?=
 =?utf-8?B?dlczaTBaR2I2bTY5MmZMMnE3RUFUZzNpMWFNK2VsZFI1SWUzWE1vL2dJVzBP?=
 =?utf-8?B?Rll2d0tiUmExNEJCSlVMd0JCUEgyZDJTZkRmNTB1WGd3STNBWDRBRXRzZGl5?=
 =?utf-8?B?L1VJZ2JQOWlrUUVvUUJ3RHdBeitWbkdsVzlLTldlWWxTNjBTeFpQR3d1Y0tC?=
 =?utf-8?B?TlNwYnNreTZvdUszckdhem4yMGd3cHhKbk43bE5MVmt4UThhUExDbXVSdTBw?=
 =?utf-8?B?bkpjaGFwSllOVDFBcmVZNHNTbE5jMHc5QWE0czA1bEJ1VHh5YW5mdmxsWEY3?=
 =?utf-8?B?M21xeDFRVkFyTnNnY1lLUEN5NWhQUGJDSkxDRThVTjVMelNxekVXVHJDSmlB?=
 =?utf-8?B?b3NWSnh3VUNvMG9SazhXSUk2eW1WT0RLcnFyM2l6MFdUTllPVWhlanBoZmVB?=
 =?utf-8?B?aE5rUGM5dTl2anVkajF6NG5pK3lBOFc3eW5OKzRPcUt4cDlSbGkxMk5ncXE5?=
 =?utf-8?B?TWNROG8vNWZKdGlFQ2pvUGdxeTliemlla3I5QUFIZUlEaWREZUpkanJ0aHJN?=
 =?utf-8?B?ZkNsWFluZEppTHJJYzNwV0JmaS9zOFlGNmdVR3NoTlJacE1qWENKREluV3RT?=
 =?utf-8?Q?2jnoe2dN+9WmXxV21sflvQNTNYWZq0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGR4RWNJNkJBNjVWcEZaTGdPNGJwU2FIekpXSHAydjRXU2k0QXVEQ3g3b2Nn?=
 =?utf-8?B?bnkycW4wZktldnRWUXUzSmQzRlkyMktWaWIybW9Qc2ZmakJkVkdidFlZUXA1?=
 =?utf-8?B?S2xSSjNSY3l2RUEwYUthZ0trY3VRWmcwVkNycDM5bXF3aHBUellqYzd3YVFU?=
 =?utf-8?B?bWNaaWJCazNQOVZyWjMvcVNyZDRBWjR4ODFlMWNmNS9kdzFacE1wdFlUOVBL?=
 =?utf-8?B?cEJ6K2gvV3J5ME4vWGwvQTk3TmJmdm03S0dudHJPdU1acHN5ajJiZzVYUWEx?=
 =?utf-8?B?Qml0QUNOakUrN1FGSndzd2NkZVdZUEc5NFdiNnpkdWQ0MG5NNWN6VUtIZ1lL?=
 =?utf-8?B?dnZxWUZacjlEQmJQcWhjTHRONHRXOSs2WDBsKzQ0Mm0wR0N0YkxZNWgvd3dp?=
 =?utf-8?B?bUNzaW5lRy9KelRCQ2sxOUhxL1VETjNJMHdRZXdETDBkcWdHL0I5WElzaTZJ?=
 =?utf-8?B?b1h3Tkw5bWdxZWhJbE5KZHNQbHV5NTJEQjBZa2xKRTN1YWhIeWJGZ3JGd2Rk?=
 =?utf-8?B?UHVmN25NbEFJenF5a3JOSXRjR2Mwem1UVURwZlkrS01TUTY0VG92LzJWKzBT?=
 =?utf-8?B?c3p3MjB2eUhMdXQ4YWxEenhjWjVWOGVvS25tUEhhN2NGcDdoOE4xWEdYMDhD?=
 =?utf-8?B?cHNOaDE3cHVzcmhTY0RpMEZpSDR5SWdsTjhBR1RMb0Q0aHhJaWRpK1hzNXh6?=
 =?utf-8?B?QjlRR29VbUVtU2owZ0lsY3NjQzZIZG5mamtvUkFxQTB5SFVxYXF1N2p1Unpy?=
 =?utf-8?B?dUFmcWNWcWZ2RmVaYU5Md09zTXlxcDB0elg3VXJ6NGZ0dnRva3dmdFJhU2JT?=
 =?utf-8?B?bElVSzQyUmRwU1A5RVRBay9MamNWdFhmWjAvcFhoWEkva3BQNm0wWW9tbUpW?=
 =?utf-8?B?dXlJVWVOUkU3cVJaRlV5a1JaU3BCSEZGRWxVakpKamtmT3YvTE8zdk4yUnRs?=
 =?utf-8?B?YS8wRWg1eWM2U294SS8yb3pHejdvTU5jNUYvOTJJUmJwNHdiSjh2TVM2cVE2?=
 =?utf-8?B?bzZmWEswZ2RRTDNzM1V6N2dVSmsyQVhtc3VXdVU1WG9SMDRXdFlLdE9iaUN6?=
 =?utf-8?B?Y0dBbGw2Z1pidUVyQ1I3MnpYNnNoMWsxVmRUNS96V1lHU0U4UEd1MlhIeTMz?=
 =?utf-8?B?SmxLQTZHNFBHa0dVbm5mUGFYSjk4eVJoQnJHajgxZ1EzR09yZ0VWRUhiSFFi?=
 =?utf-8?B?NXlYbElJeXJoelhXelhzLzRDSDNReHRTQlE5UHBVUW5teGtMMVVmOEhFTks3?=
 =?utf-8?B?S3IvdUI0MW40SU9GUHNHOW5aeFlkVGtFd0p3UldhZkJQeVVuQVdmS0t1am9s?=
 =?utf-8?B?ZE05dG90VnlNV3V1cFRyMWVDbzNySVNtb0RoT1BBRjFydnJTL3JvYjJ6TFZZ?=
 =?utf-8?B?eFJBa3JWT1E5NDNrVUFuNkYzWHpFNVVmWmNCQkR1a0pSc0NUYTVtN0c4cmlM?=
 =?utf-8?B?V3ZjTkxrMzRJcFcxVjRHV01lSEhPcXl3UWx6NjV1dmExTzR6a282b0ZoWkNC?=
 =?utf-8?B?bkxDTHd5aEtTZFpKQ1VocHNOd0hxaERFUm1GbWt4L0Z2MzEwZk5jbGJYeUM1?=
 =?utf-8?B?YitYdlJkdk5wZHpYbW0vT2NxTklkUTA5VFNwMFRJVlA5VFFGS1BWeVBreGw5?=
 =?utf-8?B?Vi9qR2NtVmVNTHBodXhwcEwzdHZtYWo0bTJwN21EUVV0N2ptMmUyMzdPajFw?=
 =?utf-8?B?S3loRmZEOXVsTml0RFdNMTJWTVE4L1JLTi9TVUpZT0RUWnFkWEgxUVRpNi9S?=
 =?utf-8?B?UFlzL1R5bDdqNXNTYk5vRlJUZURaRVg0UFBsRUFsSThGVXdsdUgralEycWxj?=
 =?utf-8?B?ZzNCTjZkWTBYeWptVU1nZllyTFRyQnZWd1VsRWw1dnUxTXd5RWlQanQ2cWNq?=
 =?utf-8?B?S3h2SVdIQ3RBNzBJRWtSZURLK25haXo3c0hNN2xJd3poVEd4TUdPUHFjQVRV?=
 =?utf-8?B?NnptaDFaZnBFZk5uZ3RGdmZvUXFEOStmL3NYZi9MaGVoREhLR0JjU3E5MWlY?=
 =?utf-8?B?TDBWMStLL1AwdTA1bnJoMTlrd2pYZUtNYnJkOE9Oc2s0MzlSYWQxYjZRVkRT?=
 =?utf-8?B?UmdKZ3BpR0R1L21meE1jaVc0b3AzajUvbVBnWGtKdHlYS2F6VHJBQTNzaWQx?=
 =?utf-8?Q?JSwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ca160-1bd3-4df2-7bda-08ddfc1033b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:47:47.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUJQamyLGnqA5lL8QiDkIZQdVeJIzZZSDaCxfOVAisyUf9OcahhlccLeIOL1nm2OZtXmp33T35t+tdH1WMz4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

W1B1YmxpY10NCg0KSGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TnVubyBTw6EgPG5vbmFtZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRl
bWJlciAyNSwgMjAyNSAxOjIyIFBNDQo+IFRvOiBHdW50dXBhbGxpLCBNYW5pa2FudGEgPG1hbmlr
YW50YS5ndW50dXBhbGxpQGFtZC5jb20+OyBKb3JnZSBNYXJxdWVzDQo+IDxnYXN0bWFpZXJAZ21h
aWwuY29tPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPg0KPiBDYzogQWxleGFuZHJl
IEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPjsgSm9yZ2UgTWFycXVlcw0K
PiA8am9yZ2UubWFycXVlc0BhbmFsb2cuY29tPjsgV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0Bz
YW5nLQ0KPiBlbmdpbmVlcmluZy5jb20+OyBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT47IEFy
bmQgQmVyZ21hbm4NCj4gPGFybmRAYXJuZGIuZGU+OyBsaW51eC1pM2NAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0DQo+IChBTUQtWGlsaW54KSA8
Z2l0QGFtZC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gW3YyXSBpM2M6IGZpeCBiaWctZW5kaWFuIEZJRk8gdHJhbnNmZXJz
DQo+DQo+IE9uIFRodSwgMjAyNS0wOS0yNSBhdCAwNzozNyArMDAwMCwgR3VudHVwYWxsaSwgTWFu
aWthbnRhIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEpvcmdlIE1hcnF1ZXMgPGdhc3Rt
YWllckBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI1
IDEyOjQ3IFBNDQo+ID4gPiBUbzogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPg0KPiA+
ID4gQ2M6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT47
IEpvcmdlIE1hcnF1ZXMNCj4gPiA+IDxqb3JnZS5tYXJxdWVzQGFuYWxvZy5jb20+OyBXb2xmcmFt
IFNhbmcgPHdzYStyZW5lc2FzQHNhbmctDQo+ID4gPiBlbmdpbmVlcmluZy5jb20+OyBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT47IEFybmQgQmVyZ21hbm4NCj4gPiA+IDxhcm5kQGFybmRiLmRl
PjsgR3VudHVwYWxsaSwgTWFuaWthbnRhDQo+ID4gPiA8bWFuaWthbnRhLmd1bnR1cGFsbGlAYW1k
LmNvbT47DQo+ID4gPiBsaW51eC0NCj4gPiA+IGkzY0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBbdjJd
IGkzYzogZml4IGJpZy1lbmRpYW4gRklGTyB0cmFuc2ZlcnMNCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IFNlcCAyNCwgMjAyNSBhdCAxMDoxODozM1BNICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiA+ID4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+ID4gPg0KPiA+
ID4gPiBTaG9ydCBNTUlPIHRyYW5zZmVycyB0aGF0IGFyZSBub3QgYSBtdWx0aXBsZSBvZiBmb3Vy
IGJ5dGVzIGluIHNpemUNCj4gPiA+ID4gbmVlZCBhIHNwZWNpYWwgY2FzZSBmb3IgdGhlIGZpbmFs
IGJ5dGVzLCBob3dldmVyIHRoZSBleGlzdGluZw0KPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBpcyBu
b3QgZW5kaWFuLXNhZmUgYW5kIGludHJvZHVjZXMgYW4gaW5jb3JyZWN0DQo+ID4gPiA+IGJ5dGVz
d2FwIG9uIGJpZy1lbmRpYW4ga2VybmVscy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyB1c3VhbGx5
IGRvZXMgbm90IGNhdXNlIHByb2JsZW1zIGJlY2F1c2UgbW9zdCBzeXN0ZW1zIGFyZQ0KPiA+ID4g
PiBsaXR0bGUtZW5kaWFuIGFuZCBtb3N0IHRyYW5zZmVycyBhcmUgbXVsdGlwbGUgb2YgZm91ciBi
eXRlcyBsb25nLA0KPiA+ID4gPiBidXQgc3RpbGwgbmVlZHMgdG8gYmUgZml4ZWQgdG8gYXZvaWQg
dGhlIGV4dHJhIGJ5dGVzd2FwLg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2UgdGhlIHNwZWNpYWwg
Y2FzZSBmb3IgYm90aCBpM2Nfd3JpdGVsX2ZpZm8oKSBhbmQNCj4gPiA+ID4gaTNjX3JlYWRsX2Zp
Zm8oKSB0byB1c2Ugbm9uLWJ5dGVzd2FwcGluZyB3cml0ZXNsKCkgYW5kIHJlYWRzbCgpDQo+ID4g
PiA+IHdpdGggYSBzaW5nbGUgZWxlbWVudCBpbnN0ZWFkIG9mIHRoZSBieXRlc3dhcHBpbmcgd3Jp
dGVsKCkvcmVhZGwoKQ0KPiA+ID4gPiB0aGF0IGFyZSBtZWFudCBmb3IgaW5kaXZpZHVhbCBNTUlP
IHJlZ2lzdGVycy4gQXMgZGF0YSBpcyBjb3BpZWQNCj4gPiA+ID4gYmV0d2VlbiBhIEZJRk8gYW5k
IGEgbWVtb3J5IGJ1ZmZlciwgdGhlIHdyaXRlc2woKS9yZWFkc2woKSBsb29wcw0KPiA+ID4gPiBh
cmUgdHlwaWNhbGx5IGJhc2VkIG9uIF9fcmF3X3JlYWRsKCkvIF9fcmF3X3dyaXRlbCgpLCByZXN1
bHRpbmcgaW4NCj4gPiA+ID4gdGhlIG9yZGVyIG9mIGJ5dGVzIGluIHRoZSBGSUZPIHRvIG1hdGNo
IHRoZSBvcmRlciBpbiB0aGUgYnVmZmVyLA0KPiA+ID4gPiByZWdhcmRsZXNzIG9mIHRoZSBDUFUg
ZW5kaWFuZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZWFybGllciB2ZXJzaW9ucyBpbiB0aGUg
ZHctaTNjIGFuZCBpM2MtbWFzdGVyLWNkbnMgaGFkIGENCj4gPiA+ID4gY29ycmVjdCBpbXBsZW1l
bnRhdGlvbiwgYnV0IHRoZSBnZW5lcmljIHZlcnNpb24gdGhhdCB3YXMgcmVjZW50bHkgYWRkZWQg
YnJva2UNCj4gaXQuDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiA3MzNiNDM5Mzc1YjQgKCJpM2M6
IG1hc3RlcjogQWRkIGlubGluZSBpM2NfcmVhZGxfZmlmbygpIGFuZA0KPiA+ID4gPiBpM2Nfd3Jp
dGVsX2ZpZm8oKSIpDQo+ID4gPiA+IENjOiBNYW5pa2FudGEgR3VudHVwYWxsaSA8bWFuaWthbnRh
Lmd1bnR1cGFsbGlAYW1kLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IFRoaXMgd2FzIGEgcmVjZW50
IHJlZ3Jlc3Npb24sIHRoZSB2ZXJzaW9uIGluIDYuMTYgc3RpbGwgd29ya3MsIGJ1dA0KPiA+ID4g
PiA2LjE3LXJjIGlzIGJyb2tlbi4NCj4gPiA+ID4NCj4gPiA+ID4gdjIgY2hhbmdlczoNCj4gPiA+
ID4gIC0gYWRkIGNvZGUgY29tbWVudHMNCj4gPiA+ID4gIC0gd3JpdGUgY29ycmVjdCBkYXRhIGJ1
ZmZlcg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaTNjL2ludGVybmFscy5oIHwgMTIg
KysrKysrKysrKy0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTNj
L2ludGVybmFscy5oIGIvZHJpdmVycy9pM2MvaW50ZXJuYWxzLmgNCj4gPiA+ID4gaW5kZXggMGQ4
NTdjYzY4Y2M1Li43OWNlYWE1ZjVhZmQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaTNj
L2ludGVybmFscy5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaTNjL2ludGVybmFscy5oDQo+ID4g
PiA+IEBAIC0zOCw3ICszOCwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaTNjX3dyaXRlbF9maWZv
KHZvaWQgX19pb21lbQ0KPiA+ID4gPiAqYWRkciwgY29uc3QNCj4gPiA+IHZvaWQgKmJ1ZiwNCj4g
PiA+ID4gICAgICAgICAgICAgdTMyIHRtcCA9IDA7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAg
ICAgIG1lbWNweSgmdG1wLCBidWYgKyAobmJ5dGVzICYgfjMpLCBuYnl0ZXMgJiAzKTsNCj4gPiA+
ID4gLSAgICAgICAgICAgd3JpdGVsKHRtcCwgYWRkcik7DQo+ID4gPiA+ICsgICAgICAgICAgIC8q
DQo+ID4gPiA+ICsgICAgICAgICAgICAqIHdyaXRlc2woKSBpbnN0ZWFkIG9mIHdyaXRlbCgpIHRv
IGtlZXAgRklGTw0KPiA+ID4gPiArICAgICAgICAgICAgKiBieXRlb3JkZXIgb24gYmlnLWVuZGlh
biB0YXJnZXRzDQo+ID4gPiA+ICsgICAgICAgICAgICAqLw0KPiA+ID4gPiArICAgICAgICAgICB3
cml0ZXNsKGFkZHIsICZ0bXAsIDEpOw0KPiA+ID4gPiAgICAgfQ0KPiA+ID4gPiAgfQ0KPiA+ID4g
Pg0KPiA+ID4gPiBAQCAtNTUsNyArNTksMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIGkzY19yZWFk
bF9maWZvKGNvbnN0IHZvaWQNCj4gPiA+ID4gX19pb21lbSAqYWRkciwNCj4gPiA+IHZvaWQgKmJ1
ZiwNCj4gPiA+ID4gICAgIGlmIChuYnl0ZXMgJiAzKSB7DQo+ID4gPiA+ICAgICAgICAgICAgIHUz
MiB0bXA7DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAgICAgICAgIHRtcCA9IHJlYWRsKGFkZHIpOw0K
PiA+ID4gPiArICAgICAgICAgICAvKg0KPiA+ID4gPiArICAgICAgICAgICAgKiByZWFkc2woKSBp
bnN0ZWFkIG9mIHJlYWRsKCkgdG8ga2VlcCBGSUZPDQo+ID4gPiA+ICsgICAgICAgICAgICAqIGJ5
dGVvcmRlciBvbiBiaWctZW5kaWFuIHRhcmdldHMNCj4gPiA+ID4gKyAgICAgICAgICAgICovDQo+
ID4gPiA+ICsgICAgICAgICAgIHJlYWRzbChhZGRyLCAmdG1wLCAxKTsNCj4gPiA+ID4gICAgICAg
ICAgICAgbWVtY3B5KGJ1ZiArIChuYnl0ZXMgJiB+MyksICZ0bXAsIG5ieXRlcyAmIDMpOw0KPiA+
ID4gPiAgICAgfQ0KPiA+ID4gPiAgfQ0KPiA+ID4gUmV2aWV3ZWQtYnk6IEpvcmdlIE1hcnF1ZXMg
PGpvcmdlLm1hcnF1ZXNAYW5hbG9nLmNvbT4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zOS41DQo+
ID4gPiA+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBzdWItd29yZCB0cmFuc2ZlciBj
YXNlIG9uIGJpZy1lbmRpYW4ga2VybmVscywgYnV0DQo+ID4gaXQgc3RpbGwgZG9lcyBub3QgYWRk
cmVzcyB0aGUgc2NlbmFyaW8gb2YgbGl0dGxlLWVuZGlhbiBrZXJuZWxzDQo+ID4gYWNjZXNzaW5n
IGJpZy0gZW5kaWFuIEZJRk9zLg0KPiA+DQo+DQo+IEkgd291bGQgYXJndWUgdGhhdCdzIHNvbWV0
aGluZyBmb3IgY2FsbGVycyBvZiB0aGVzZSBmdW5jdGlvbnMgdG8gY2FyZSBhYm91dC4NCklmIGVh
Y2ggSTNDIGRyaXZlciBoYXMgdG8gaGFuZGxlIEZJRk8gZW5kaWFubmVzcyBpbmRpdmlkdWFsbHks
IGl0IGludHJvZHVjZXMgdW5uZWNlc3NhcnkgZHVwbGljYXRpb24gYW5kIG92ZXJoZWFkIGFjcm9z
cyBkcml2ZXJzLiBDZW50cmFsaXppbmcgdGhpcyBpbiB0aGUgRklGTyBhY2Nlc3MgaGVscGVycyBr
ZWVwcyB0aGUgbG9naWMgY29uc2lzdGVudCwgYXZvaWRzIHJlcGVhdGVkIGJvaWxlcnBsYXRlLCBh
bmQgcmVkdWNlcyB0aGUgY2hhbmNlIG9mIHN1YnRsZSBidWdzLg0KDQo+DQo+ID4gV2l0aCB0aGUg
Y3VycmVudCB2ZXJzaW9uLCBpM2Nfd3JpdGVsX2ZpZm8oKSBhbmQgaTNjX3JlYWRsX2ZpZm8oKSBv
bmx5DQo+ID4gd29yayB3aGVuIHRoZSBGSUZPIGhhcyB0aGUgc2FtZSBlbmRpYW5uZXNzIGFzIHRo
ZSBDUFUuIE9uIHBsYXRmb3Jtcw0KPiA+IHN1Y2ggYXMgdGhlDQo+ID4gWkNVMTAyIChaeW5xIFVs
dHJhU2NhbGUrIE1QU29DLCBDb3J0ZXgtQTUzLCBsaXR0bGUtZW5kaWFuKSwgdGhlIEkzQw0KPiA+
IEZJRk9zIGFyZSBiaWctZW5kaWFuLCBhbmQgdGhpcyBwYXRjaCBhbG9uZSBpcyBub3Qgc3VmZmlj
aWVudCAtDQo+ID4gdHJhbnNmZXJzIGZhaWwgaW4gdGhhdCBjb25maWd1cmF0aW9uLg0KPiA+DQo+
ID4gV2UgaGF2ZSB2YWxpZGF0ZWQgdGhpcyBvbiBaQ1UxMDIsIGFuZCB0aGUgbWlzbWF0Y2ggYmV0
d2VlbiBMRSBrZXJuZWwNCj4gPiBhbmQgQkUgRklGTyBpcyBzdGlsbCBhbiBpc3N1ZS4NCj4gPg0K
PiA+IE9uIHRvcCBvZiB0aGlzIGZpeCwgZXhwbGljaXQgRklGTyBlbmRpYW5uZXNzIHN1cHBvcnQg
aXMgcmVxdWlyZWQsIGFzDQo+ID4gcHJvcG9zZWQgaW4gW1BBVENIIHY3IDMvNF0gImkzYzogbWFz
dGVyOiBBZGQgZW5kaWFubmVzcyBzdXBwb3J0IGZvcg0KPiA+IGkzY19yZWFkbF9maWZvKCkgYW5k
IGkzY193cml0ZWxfZmlmbygpIi4gVGhhdCBhcHByb2FjaCBhZGRzIGFuIGVuZGlhbg0KPiA+IGFy
Z3VtZW50IGFuZCB1c2VzDQo+ID4gd3JpdGVzbF9iZSgpL3JlYWRzbF9iZSgpIHdoZXJlIG5lY2Vz
c2FyeSwgZS5nLjoNCj4gPg0KPiA+IHN0YXRpYyBpbmxpbmUgdm9pZCBpM2Nfd3JpdGVsX2ZpZm8o
dm9pZCBfX2lvbWVtICphZGRyLCBjb25zdCB2b2lkDQo+ID4gKmJ1ZiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGludCBuYnl0ZXMsIGVudW0gaTNjX2ZpZm9fZW5kaWFu
DQo+ID4gZW5kaWFuKSB7DQo+ID4gICAgICAgICBpZiAoZW5kaWFuKQ0KPiA+ICAgICAgICAgICAg
ICAgICB3cml0ZXNsX2JlKGFkZHIsIGJ1ZiwgbmJ5dGVzIC8gNCk7DQo+ID4gICAgICAgICBlbHNl
DQo+ID4gICAgICAgICAgICAgICAgIHdyaXRlc2woYWRkciwgYnVmLCBuYnl0ZXMgLyA0KTsNCj4g
Pg0KPiA+ICAgICAgICAgaWYgKG5ieXRlcyAmIDMpIHsNCj4gPiAgICAgICAgICAgICAgICAgdTMy
IHRtcCA9IDA7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgbWVtY3B5KCZ0bXAsIGJ1ZiArIChu
Ynl0ZXMgJiB+MyksIG5ieXRlcyAmIDMpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGlmIChl
bmRpYW4pDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVzbF9iZShhZGRyLCAmdG1w
LCAxKTsNCj4gPiAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHdyaXRlc2woYWRkciwgJnRtcCwgMSk7DQo+ID4gICAgICAgICB9DQo+ID4gfQ0KPiA+DQo+
ID4NClRoYW5rcywNCk1hbmlrYW50YS4NCg==

