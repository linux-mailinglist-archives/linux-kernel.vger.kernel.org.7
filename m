Return-Path: <linux-kernel+bounces-894391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA493C4A037
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07C134F3C28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07D2561A7;
	Tue, 11 Nov 2025 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzgH7UxX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D53256C88
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822310; cv=fail; b=qgMJs6bZZwSfyxahmQHAnQHIL4o9eA3A1hZUr5kQkimhkqV9U0oST+mbNQsmsm+8vjPO3+wKnjg9KcGxuYJdPmCJAJWUtdZICIVd6XJp7Y63fGHIT/b+3/8BL93bJN/z2E0UjS0bCVNr7TZHyf1G3f5lpUjo2x+8nK4QL7Dlsxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822310; c=relaxed/simple;
	bh=KbyvzE9hnnG5iXh6cY0PCJBOHvIpaNroB7wbLnW/uQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BmCoz4/PLykXWN4DpFPhjfe/UIkg9gvzJxcRnYNw5yazFdNtOGzA5VzECMtgrqRqlQ33FXSDkFIkRaULVpQR+V0OCpAdkmCjR+2nrdQvnt7d48c7Fu/Gv8c+9fSdYzVEmKXaVZlrjyxiv//6Xsn9t8TQjs+FJAyDhQ1NP06O8Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzgH7UxX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762822308; x=1794358308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KbyvzE9hnnG5iXh6cY0PCJBOHvIpaNroB7wbLnW/uQ4=;
  b=HzgH7UxXI6BnDc93jRbkdIM++Kzf3LXhFxK1NoHpU1fwcPtNdyhr4NYL
   jotn+LBMTguBZnQK04p+dskCvZ3D2yjA6Vgx6dEFS0CKVQ57nV41IGzR5
   i7MOdsyBOzkhduaySlTGtrzttZXidFod33mQkvQUd7Nz9ifCppgkAtL2C
   sYXPD66WdNzQbm9yvMTvlr7XVQmlgyl6jSFrOxAISfnb3kaJeDCZFfE6u
   aCIqvUJ4zqZJoQYtiytjyTdg5n31c59ZLx5+1bLIDowVDzhAG68/tPT1W
   FCm0s++HBiX0lTXrv/up2KR6uqxbI/XGrTgo5zRp5jDlpj8ooSMqVFJ16
   g==;
X-CSE-ConnectionGUID: Z6PKUdzkRtGOlc6T2fGnkA==
X-CSE-MsgGUID: Vq4uxuR5TcS5Zxvzt7hlWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64788477"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64788477"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:51:47 -0800
X-CSE-ConnectionGUID: KCz/R8GcR8CiJhvYquRahA==
X-CSE-MsgGUID: d/YBXZbUSfiw1z1jarB64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188457257"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:51:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 16:51:46 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 16:51:46 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 16:51:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN5IRnj5XYRcmU1ObET8hE61FHdEFquqm6fT43p0IwyIgEbc7FWoGUcqYlgn/7jOl17hU7TjiHC3izY809LSjo8wZ0I5O4pA3BLyvRjl+0YHu9EEOmH7AlZ0KdfU+CXXsdbzluxE55/LvenSDqStWCrTk7DoQC+OK8NEC7TLUgIGx+hM0rSQIOw7kzW2BoGAgLNq7urB6L4GxVBtis794TDCeo7QDCOjAJE7WD6pjPJ2yCmF7DvxcUC0ElQru9IH46ehaU1XaoGy7AHqGcu6tm9ALnhKM4Ey81kdRfZnAAZkhVpZ0hROYJJmcRNsc+RK+8kSRYLk0ShGYGsnOFY1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbyvzE9hnnG5iXh6cY0PCJBOHvIpaNroB7wbLnW/uQ4=;
 b=hQDHkYA1c+vpYmlbwnLjOj1Hgafnp7Zs48i1ChT782D4aohBsQxfBm4O2CxJ5K4vzFN1QKki6OdaTY3hLf8ougS2FBf2LHKJKi1CSMoSVy+SRMmcXjnf/A8g9dsUu1l/fq1syoT/CqP1Ghycudd+wBtiV/dhUEuANjEJG3wQYPlvTZN9wRWuwLm3jJYo+gjCtvsph3yNqTeMsvCHaF3wAobYUyiPkQjtqlXu/SZ/zMT+sPdErUhg5xXxksplACTIQJ1M+0oqav2lauZ07gmvkVsUc+/q+f3QmGfebC/Qt0gvhyNyKDcey6TgpCrJfrZ5dPQhbWgTi8MvEe/ND3eKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:51:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 00:51:44 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, Babu Moger <bmoger@amd.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Topic: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Index: AQHcT4VCMZzJIaIcpEO5HF/nc2I90rTnxWyAgAAGSYCAAAv9gIAAFBMAgAQ1DACAAIf5AIAAAPNg
Date: Tue, 11 Nov 2025 00:51:44 +0000
Message-ID: <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
In-Reply-To: <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB9473:EE_
x-ms-office365-filtering-correlation-id: d8c1f9cc-567e-4376-f9cf-08de20bc7c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WGhiZzBLa0krOXVnK1F1UFVyOVQ0bDBQWVpTL2ZBbjNWM2M2WlBZOWhaQ1Rp?=
 =?utf-8?B?dmxOWWt1TkwrcVJvZ0tNeFlUWWRyVHdkVVhzRkhUUzEyOFNqVE84RjRNd3JS?=
 =?utf-8?B?a3JmTGNGOGpQb0lnMEh1bC9KRVY3MzJ1Y2xuUWk1UHV0U2JQRUMyaXBkdWpW?=
 =?utf-8?B?TWEwZThNU1J4OEZIU0tnTTZ4T0pBZzFmWFo1d0laWWtZY0MvelpzK1h6cjhP?=
 =?utf-8?B?RFJ5NlJxQlBNR0UyeHRrSTVyN0VndXF4QkE0MGZHN3R3UjVPOUJhRG9CNHow?=
 =?utf-8?B?bzZaR09TbW9iSW9FVHpSVjVSL1VKMUR3MVFIUXJ3UHQ2K24wSnVMYkNMaXlh?=
 =?utf-8?B?S1VSNUlyaHNGN1NjVUtVRXBLZlQ0VnJkSS9vUHZmMFVKMkxjNzlZMXRFYkQz?=
 =?utf-8?B?ZVJiZnNYNEdCaEUwR0pVektEMW0vRzUwQkt5U0FBK1hDNkdGcGwrNW9QaUNm?=
 =?utf-8?B?eXJIS1AxRDFka2daNG1FdmxkMXVEL0tqNXJIaVlJS3Ryb2JybXluU1pEaUhY?=
 =?utf-8?B?UzU4TDk5RHpMVUU3emZXY3E4NGZtcHR2d0xkeDRPVnc2MDJleUV5dzRCaWZr?=
 =?utf-8?B?WDhJc0ludGI1UUsyb0xQdTQvSWJQWDFYV1lTc1VZRVppTDgrckpLV0dxazgx?=
 =?utf-8?B?SEE3SkNWK2dPS3dIMW40TG5hSng3b0wvVVZVTThSL3VOM3lic25OVnlhTmxh?=
 =?utf-8?B?WE44TjZvOXNoZXJvU25MbkpvNktqdXVtbGhFMzhVaXVwQ0dWdXp0USsvSC9K?=
 =?utf-8?B?T2hZNGVpekE2MTZoZ2YxTkdDWk9vVldkcW9TMERrZ2FTdzZUY2lmUkJwOFRN?=
 =?utf-8?B?TkJqM1NkbW9VUlg5b2gzSVVyNWFFZUxPeHY3K2FPb2R1dTlRMXh3bTMxYlc4?=
 =?utf-8?B?NWcvb1VrbWV4b2RPOXpuKzlvVHlxbitvSXllZDVkVGtZSVd2OFo5bUNzSWgz?=
 =?utf-8?B?TnZaZWVnZkhwb3VWNmQ4STdlYXgzSERvZjhlb0xCRlE1TkpiWVhlZktFM3pD?=
 =?utf-8?B?Q3lic3NueWQ4UjQ0VEkybitrY2FRb2ptRmlsc092M0ZpbXRhTGlvLzhrL09m?=
 =?utf-8?B?NlR2eW9ZcllydE5Rbkc3eStEK1lUdVM0OXVZeG1ZRjlhamMyYngrdWtJSmNF?=
 =?utf-8?B?b0FXdms2V1l3M0J3OGd2cGlGOTdtb0hBUXFpYWZadmRaeWVndm0xeUlvQjlk?=
 =?utf-8?B?ZGxocVJ0alZ4cHcrQitNc0pTdWVSRFhzN0FETHNrb2R4UER4Z01NU1Q1NWt5?=
 =?utf-8?B?bHRtVUNvQ0ViVmIwTEgzV0xESGs4eHhmbDBJU3J1djhQMStwN1QrU09tOXdN?=
 =?utf-8?B?ZC9ZV05KcmtvY1ladWJPUnMvb3Z4c3FLVlQ5Q01nSDAvQk1QendFcFBQSmh0?=
 =?utf-8?B?SGhOVVUvNVBjb252UkU2Y1h6VVY2U0FrREgxeElKZTljYWdGMzcwVnI3bWdv?=
 =?utf-8?B?U2ZOQ1NReDA2VXBYdEJlOERYSDRPVHp0T2JGeFk1bVNGVWIxdmZYQ2s5UGxl?=
 =?utf-8?B?Z1FPR1RpN0dWSW1tdFF0QmFuZ0dDZTF6K3FSWXlkZ1lhd0dPR1Fndm9lU3Rw?=
 =?utf-8?B?RkFHaW1hUkRuekFrTnRYMTJIL2tzS2M4a0MrK1drdjZCS3MwRW1Ra0dySHF3?=
 =?utf-8?B?VEVlMFFDKzR2OFRXcmZrOG53eE80UXowVGhtWDlEWjd6dTZKbDZxdEFLZnBY?=
 =?utf-8?B?bDJVazNaVnhvN3JVWUw2YnNDR1c1VnN0aUZTcGoyUm0wcUpGbFpENXVIanZa?=
 =?utf-8?B?Z0NZY21sUjdjRkNpMjcxakN1TVg0K21jUU9xcS9wR0Z4TWxhZE5wOUxsYVVL?=
 =?utf-8?B?T1NPL05hWm9HNjR2VWZVOThiTGhHeTZwQjM1cXVhSGIrbHZDK08yejN2a3dD?=
 =?utf-8?B?SDgzdG0vcjgxRDBtQ2E2R1ZPNzVBWlk5Yy8wdGdyV0NOYVlEcG84NERIVkQz?=
 =?utf-8?B?T1VuVjJ2TGY1WTZ3bVk5cE5nbnNnVWJKV09TckgrNllRZnJoT0c1bzgrSlZD?=
 =?utf-8?B?RFVFYjdHdzhQT1pLbjQ4VHRpQUlLMmxjTnBYMzBQUzE0S3VnT3h2dzlkYTF1?=
 =?utf-8?Q?dp6K9E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjVwbjQ0cE1HVnBXYVpXSlk1UERENW4yRXQ0eWRIQ25JSGNsV2NSVDQwSkoz?=
 =?utf-8?B?WXJxSkdsblNqR3psRkRtUDdlWEN3MVUrbUt2NlJJUWF1NXlJcVpLc2N0RFZz?=
 =?utf-8?B?eXVvWHZXYmRhUFJROWpseFhlSFI0S1VnLytMMk1pUVVHT1VSVnQ5by9qZVI2?=
 =?utf-8?B?RktLWjhGR3dmMG5MQnRzTG02Yk82dDF2VGhTUXV5Z2lQSEtqRVhpcnZZK0tB?=
 =?utf-8?B?aHJKbFlGNUczckMyYm5nT3VoTndGaHg1a0w5em1kNDk0YThOSWlLcDhrWExF?=
 =?utf-8?B?NHhJNHZRV3BFTUdKM1NMTTg5aWl5YzJLVzEyeEgyaFVhR0hYdmNBeEFaeTVl?=
 =?utf-8?B?UUp6ZXNCR0NrQXUweSt5N1Z6SWVyZm9EQ0J5SXVlckJmczJhcmIySmg5Uklj?=
 =?utf-8?B?UzVMeE5ncFVJZ2Ezb09PTzJFOC9QZWIyWUZHR2poY1FWQ0NMM3hYeHRtQUQr?=
 =?utf-8?B?T2xMNXZ1SmJQRUM3Nmd4RktydkhycCtLNXA5ZkFDNlFFZkdxNzQzUytVWlc5?=
 =?utf-8?B?c1M4S0w1K2lobVNKbUNXaHdIS1EvUGhPdlFyN0MzWEZxaWViUHRGc25HekRl?=
 =?utf-8?B?eTNBeVN5OVNlNGVrWmwwMHd3Z2lHbGMyRmFWYVAzQ1J0Yml2SUt1aDVWK0dU?=
 =?utf-8?B?SlJWQURtK3VOcFdvUVpVNFFvSnlES0UxMnRrK2Nza1ZocHBuY3FEd0dEbkR3?=
 =?utf-8?B?a3hPc24zZkg1eEhpSjdUOGxHYjRxdjczMVprZW5qanRuN1huQlYza2RrVFRi?=
 =?utf-8?B?dnFTeUFteUVQZFZoUXdGeWJCSDUrV0tkVHlmeWFXM2F2bU56WGQxaVl4VkM0?=
 =?utf-8?B?OU5JRWxaa21FTm5mdlpWK2crblc5TWs5VkRMOXovVnllcnk2bWVZQ2tidGRE?=
 =?utf-8?B?QUJ0TlFIaUdnVWZZVHgxYldxbVAvbnZ1NVhEN0YzTUJ3V2g1VStZazJrOUNW?=
 =?utf-8?B?RmRrVnRnNHhMWlUveGV4Ry9MdTRHZ0s3Mm1oVnNGcTgxaDBkS2cxZ2MzSmdJ?=
 =?utf-8?B?MnNUSENTZ29vcDJwWjRYMUx3S0xQa1hlMWdDdnpQV2sweUcxR21pV3d3Vk1I?=
 =?utf-8?B?VE1XdXNrOTVQVHA3SlpWRytoZlhIT0w4ZEJwSDNFSnZzdUs0UHpiY1ZrNHNx?=
 =?utf-8?B?Y1BIcnhMUDQ0S01jQWVESzNWaWh5cFdzODNVbTY5dStIeUJPS2kzZEtXMGI3?=
 =?utf-8?B?M3ZtMTRBaGdHazZMREVuVXFhcGtUcnZVS2JsSHZibVBheXlIWGVBcWwzT3Vu?=
 =?utf-8?B?cTJFSWl3YzlaSHo0V1RhOEc3YlFYaU5iTEovSldiSGJFdjJLVmUxQjFuSlhL?=
 =?utf-8?B?SmtaWjFkaVVWc2JySWJiVW9EU0Z1RE52OEtGRjJ1Ly9LN3c1TXlGRCtWMXRS?=
 =?utf-8?B?QmtaQW13ZkJBb3VaSlJXdVN1RjViVEc0OHVUZWU0Z2R5MkJsZnY1TWZMcFdO?=
 =?utf-8?B?TzFkUmdNT0JRRXhCbS92YlhBMUllYWZ1b0JSWUVrd01SVDRHQU5pNWcvdFpR?=
 =?utf-8?B?bTd6Skg5emFpWklaaHNlQ1lTMTJTWkJBbGlEVXFSOTRocmdKUWFXZnNZMnJn?=
 =?utf-8?B?c3F0ZmsrWGVBUGhZRVlxU2FIWktsanV6ZWk4Q0NHZ045R0M4emFkYmkzL0RO?=
 =?utf-8?B?VWtVeHBFSmU4TzhFeGlzSjhLY3A3RUFVcTNpTGNjOFZjUUt0N2ladzZjL1ZG?=
 =?utf-8?B?bXZCRzQ0S0tEL0JmRys4eFU1VWQrdmc2RVdmRldwYVdidmVEN3NkNCs1VnQ2?=
 =?utf-8?B?VmlSK3BJazRZb0VjKzYzc21jM2VBeFZEVGRDMENnaW9qN1RTSUIzZzU5cmFL?=
 =?utf-8?B?bDJyNUFpL08waVMxRlNWV0k1S0hDblFRckRKU3NHc0xIcWdLU2FBOEpzZ2hU?=
 =?utf-8?B?VEFoMG9sb1p5dnhBTUpvdWEzZVFTZ08vUEZ6NTNaUlZ6QkM2NHI2ZDJ0Wi9H?=
 =?utf-8?B?U29mVU9ROVhhNk1ha1JWQUdKQ3BaSjlidlg4SDVEd2xhVFcyK2YxUUR2bVR2?=
 =?utf-8?B?aTRRYkNmMzhiK0RQUnZRbDkvSEZLcDkvd3FaMVB0T1h0c0dWc1pFKzhxMXhP?=
 =?utf-8?B?TU91MG5oc0ZuVTRNSmdad1RZRUdPZnA5UlREcXBuWkNIaFh2aVo2ZWcveUdB?=
 =?utf-8?Q?mE5oCboIjseaGgkfhach6oNon?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c1f9cc-567e-4376-f9cf-08de20bc7c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 00:51:44.8494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4sbboL9YXmUSczn0QazDBjwjJr7+jUYXx8cv6W9VAeWXP7UDY9AxAKVAcdn3Wc3BY2mJPP6mZi7uL5HkkVJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
X-OriginatorOrg: intel.com

PiBUaGUgZ29hbCBpcyBub3QganVzdCB0byAiY2xlYXIiIHRoZSBDQk0sIGJ1dCB0byByZXNldCBp
dCB0byB0aGUgc21hbGxlc3QNCj4gdmFsaWQgbWFzay4NCg0KInNtYWxsZXN0IHZhbGlkIG1hc2si
IHNlZW1zIGxpa2UgYSBmdXp6eSBjb25jZXB0Lg0KDQpJbnRlbCBoYWQgb25lIENQVSB0aGF0IHJl
cXVpcmVkIDIgYml0cyB0byBiZSBzZXQgaW4gYW4gTDMgbWFzay4NClN1YnNlcXVlbnQgQ1BVcyBv
bmx5IHJlcXVpcmVzIDEgYml0Lg0KDQpBTUQgYWxsb3dzIHNldHRpbmcgemVybyBiaXRzLg0KDQpT
byBmb3IgQU1EICJzbWFsbGVzdCB2YWxpZCBtYXNrIiBpcyB6ZXJvLiBWZXJ5IHNpbXBsZSB0aGVy
ZS4NCg0KQnV0IG9uIEludGVsIHlvdSBtdXN0IGhhdmUgZWl0aGVyIG9uZSBvciB0d28gYml0cyBz
ZXQNCihidXQgaXQgZG9lc24ndCBtYXR0ZXIgd2hpY2ggYml0cykuDQoNCkluIHNvbWUgY2FzZXMg
eW91IG1pZ2h0IHdhbnQgdG8gcGljayBhIGJpdCB0aGF0DQpvdmVybGFwcyB3aXRoIHRoZSBzcGFj
ZSBzaGFyZWQgaW4gdGhlIGNhY2hlIGZvcg0Kbm9uLUNQVSBkZXZpY2VzICh0eXBpY2FsbHkgdG9w
IHR3byB2YWxpZCBiaXRzIG9mIHRoZQ0KbWFzaywgYnV0IHNob3VsZCBjaGVjayBDUFVJRCBsZWFm
IDB4MTAgZm9yIHRoZSBleGFjdA0KYml0cykuDQoNCk9yIHlvdSBtaWdodCB3YW50IGEgYml0IHRo
YXQgZG9lcyBOT1Qgb3ZlcmxhcCB3aXRoIHRob3NlDQpub24tQ1BVIGFsbG9jYXRpb25zLg0KDQot
VG9ueQ0K

