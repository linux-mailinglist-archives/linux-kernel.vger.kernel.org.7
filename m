Return-Path: <linux-kernel+bounces-721705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE7AFCCE8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A236B1BC1D51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3392DECB1;
	Tue,  8 Jul 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAPIob6q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FF21322F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983394; cv=fail; b=SDvxZsndfEHMx9N3QEBIRxyZ/t34AgY/UG4Gvdgx52m6/k0DA5k/Y91DG6OZCgeIJmOERKL0+dSPxgKEu8Uk8Zju60b4fPmCHFRXc7uAkqz5zhx7R6nM1NnXNZ4XTXSrPJicjSkt7sX4nURHp+oBh2hoG2XvXrnhzSvkf9R6fBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983394; c=relaxed/simple;
	bh=ZRhHUWHW0bxWopC5QjQrG7/KSFYgYPles2wv+4gDPLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/WXCIUmURnmtaR0l38dORhDU5yTENjS8GbL9T9mhKkyUuyF7Z+jqmBiYTaLZltOPIMr3ra451xKewwtFw1lUJ94fGr7E56Y88szDSYGO1XuwRBjKwzglEBixyDIPfrlEgdGlmPIoUPGvxPoPsRw/UbvcnnxnQ6GB4dWRo++8iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAPIob6q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751983392; x=1783519392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZRhHUWHW0bxWopC5QjQrG7/KSFYgYPles2wv+4gDPLE=;
  b=fAPIob6qg+O2I5kABTaxwlEwvObnF6EI+FmhsSTwQuOU1uJpUb9aXfqB
   uZ8DuNXTFs9TrOrVhH8f82Yg1KLOuu+JEhFKNsAKqJ3OHg2fm/DuXVRSh
   9QF3ORvI1Hz84FPnX6i6BstP4gY3osenDTGyE5ui42B9bc//tVSuZjNQe
   REKpbrnAlo//Swa7kNaYkyJcLaTraOZH3mFyqIm7/Y8H2qyQLnVSCnx8z
   2bTqgmRMnxB7yXWpOktWV7T/YgX+biUlPzfYj7zUxYdtznuywE9tPQ/TP
   3+Wl8feJg/KgCUH0PPiFRLliYiuIZu3J1IS6oR+c1v7SWR3dh/GWLTVug
   Q==;
X-CSE-ConnectionGUID: Wv692owFRq+FHdV9n3mZfA==
X-CSE-MsgGUID: 4qy2EHMVSyirjUVR5PgGQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58022725"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="58022725"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:03:10 -0700
X-CSE-ConnectionGUID: XCQIaimFRSOsYd3iNa/mzA==
X-CSE-MsgGUID: 58GSI89ZRsitT+G27y1gtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155594140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:03:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:03:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:03:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvhskIEFkujVmot/62BykV60WAKKyaq4B4WANU01PZvWJnrdI47XIgFASElWvMaUStwYvnyD8U/otD8BS+odnMGU00eft4s+Z5NKFPEIuL/jyp1cth+hrbB0wgHrB7fGK2brTs3q1IrSmiw3WvNt+OMzhlCJLqqwTXvHYezfkzX0dZOVEHUIT+XnkVbPECqx9zb0HS11+NOVVvB78hMk80uXMcjwNsILi/2YkyFmcenyuOVtrQUpGOUzrN+Fn6m93QzE4+Ppd7KbFnlKopWPLJiGXqB3VGbRejZIsmEGwXV60PVUG3RxwbhhY8ERKSsW++zqUKlxmM3hyKAcWNQOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDvAmoQbGBkYWBYqUM3sLZFflRn2jzv50rfQzQaQ2eo=;
 b=ikBB0VMgxHRaBFphY0UCaAzpESPz0SHVxbqiDbMUUvkl/E3mQ2Kn3N1eD0gNK1k+BcLRlsDbigr8yUyPNCwLnhDHiO434YZSND6OOt3eoKg4bK+wzmWCI7cexZDfvbSfnVtCRlC7T8prAbS/Sjnmt1DZQSnreO037gUG7NTPk8tj3rTEj3cXFb0I4rC5zhnR/gHR3J2n/iBkYUZO0cWntMsvaIrB2zIPVwQBF/yqp49hy+gc3ATjE58R+/ZYuz6WWtyxYE1t6CY/Y+4qPh8Rd7f/LgZPEl1hetGPV0z5Dfyxt/nHdivjvdDaBnF+k6jR25jLa8W5//XJJtnONN8XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 14:02:58 +0000
Received: from BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff]) by BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff%5]) with mapi id 15.20.8857.026; Tue, 8 Jul 2025
 14:02:57 +0000
From: "Deng, Pan" <pan.deng@intel.com>
To: lkp <lkp@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@kernel.org" <mingo@kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Tianyou"
	<tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/4] sched/rt: Split root_domain->rto_count to
 per-NUMA-node counters
Thread-Topic: [PATCH 3/4] sched/rt: Split root_domain->rto_count to
 per-NUMA-node counters
Thread-Index: AQHb7uc5O9mVovvEEUe6nrCYlBc7+bQntecAgACNZ3A=
Date: Tue, 8 Jul 2025 14:02:57 +0000
Message-ID: <BL1PR11MB6003439ECD3790035E99E5AF964EA@BL1PR11MB6003.namprd11.prod.outlook.com>
References: <2c1e1dbacaddd881f3cca340ece1f9268029b620.1751852370.git.pan.deng@intel.com>
 <202507081317.4IdE2euZ-lkp@intel.com>
In-Reply-To: <202507081317.4IdE2euZ-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: lkp@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB6003:EE_|PH3PPF5ACB2DC0D:EE_
x-ms-office365-filtering-correlation-id: 8cea090b-832e-4a95-e7d6-08ddbe28249b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?A3rtLJCLwFX2TruQtCgEbS9fB8lezEXpUYNGeVVW3YnsD1/ysaywzb7q/jL9?=
 =?us-ascii?Q?vC/LZ43mEw/6TAK4Ysx3La6emt94itSNsxjhXDCT/14MZ3myrT3U8fG3Xef2?=
 =?us-ascii?Q?Bbmuax9JWPQloO5RbCXoBKtCnpYh08yB3lSFRML2C04c+7Kd5ttckqSxvJqZ?=
 =?us-ascii?Q?xjBdUXFgEqX24NxT80sS9wLcKcXpFQPputzumhbTuuw+6YbFdfVyNMAr2Ytq?=
 =?us-ascii?Q?W5yxr0zQVG8sSzYf9eG2OayUdnQAvE4akPUjD3D/3lI6BNlISUKstmEHcS6n?=
 =?us-ascii?Q?NQysr8n3TR6pfsOB6hbf6V7TLa8Mr8CnH+mmm0NuCK5cnU/vdurN6c7o8UnG?=
 =?us-ascii?Q?CuTPYFKg0U6uQC+P2G4bPlo0rhUpHsI8ABTWKHXnAw7gnlJe73SKdi4xCEAp?=
 =?us-ascii?Q?n/y1n3Zigelc1xvti3iQ3JmBO/a1AVt4Chnf94u6FXOc6TuZSnMsSLpk/qax?=
 =?us-ascii?Q?V4O94fyCFPlEhjSPsbzOVXST8KGx78a4c8GD+rB5ZNHBdomSFY1phMNFgQHf?=
 =?us-ascii?Q?SRGXbaNlRM8E9JMp4aCtKMd/kpwPPhrrCHufSXglA9n3O3W24YBuGEmDFCl1?=
 =?us-ascii?Q?E1oSWvZ6yXwWK9RBVK8xusnkcLpFleSDMjPg8C+oIAHV6IBvxtmJtxp38FdZ?=
 =?us-ascii?Q?sD3INmqhYclMPMvTzAnF4o1kw0QKfY/e1ra9A1NK7NMJeoXMFpafoQNxGpA5?=
 =?us-ascii?Q?yqfYsOb6GQlwMcknawjiLD/0FA9GKaZxKvNDM14sa92NzxL1Jcwr9nA1fGTL?=
 =?us-ascii?Q?f78FvR9U1FDNzl7bnanWEWhhYb22Cn6cQa0TunwkpK0fVshrzVebM9cKWXi6?=
 =?us-ascii?Q?aQD2prRlnbTWeUAOyg4CCuoa6+Do+isM3EcnmofWS824RxMXmy3mFY1yOR4y?=
 =?us-ascii?Q?MGSzGX5+q3+skYPIzLwcksSYT3iQt9o5Q/pg2zcKsBmwmD3N1DmlHihHInn9?=
 =?us-ascii?Q?5NBYi2bVTJts17gCe4lP+FeSC+3+OPGbTB0Aey8TILFSLeoTNKfpw4HebMrv?=
 =?us-ascii?Q?KbGtDOpaosfOg/MW+0fFYL/WqlvpSTpiDZs0VojIh5gs02r9pdsab9QMeZzi?=
 =?us-ascii?Q?rx0W6YAMiuTbCJPPwaPtdc6oDK8RYTcylYPvHSK2lJhPp3upNkSFSnhgJv71?=
 =?us-ascii?Q?K5wYZYu3n3D/6CoXe/A1ZLNQdWTq9hUvX48jXDEugtqVpsLwlQM3n0o+O9ck?=
 =?us-ascii?Q?qTsoWBxbfs6/99HyDi3D2rK0y6DskhgIcaGWSwFJNUwyN7WBlfZcqkPATET3?=
 =?us-ascii?Q?77k6MC5Aj0y4t7nfaGGYAFyCPZX2vsdeB7QcGTXaxTDXXoEWcSbwnUlQ0Kp+?=
 =?us-ascii?Q?tLolJ8crhEqXp6yNaDL/42Bs+wzhnChkGPHdmaOvFJIgx2IQ7GVhQh+oi0U3?=
 =?us-ascii?Q?pDC3yqDBBDZ77rpWIN8oBoZwLEFE+BKmiFr5bOwMqVqPPM+XfoM6SXf6t0FF?=
 =?us-ascii?Q?jtWmAQTJsbZ+yeZaW+909/B1e32fAyfN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB6003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eaxWeO1Vck3qJqT9dj6aK+lTEE9nvaXxPVUESXGkQdIiz40Rjb37lqYq4eT8?=
 =?us-ascii?Q?UgBm4KrjunE7ekgCRVz0b3jAA1gIb0M2++W3v9FeanNMzpTT9HjxyYHlGuor?=
 =?us-ascii?Q?YbB0O3kfqsbcox0W3lITPc87UJaEIrGSIsWsvEnn3yIo2XpIq9TqszIFeehE?=
 =?us-ascii?Q?DbNI0GXfYl0OlP+Fqb6bbreDjDtLkxaS5q/ILy94nk8ZyzAQYgzrK5twmLKv?=
 =?us-ascii?Q?YetbbrzHqWvHvHyoQ17sO45I7b7oMoGkqtG730scuz0ggFrNVxdhS3e9rKHw?=
 =?us-ascii?Q?ZfsU8s59APZdTB9miRENoh1xaWp8Sv9YF/jBcMaX6aACoYNefvAxa6bLjIl7?=
 =?us-ascii?Q?CyauZNAMvgxSZWsDGVUeQ6Dpx9MTal3y9XsiX6WavCEIB9oRXy7jzol+U9Tq?=
 =?us-ascii?Q?lKlCTLPYNXlzSNTeJzd0g+MoJun5WfezjSQY1hii8mOp6yj/W+cu4L8NfgAI?=
 =?us-ascii?Q?76DKHtcMOUmNCVgKKW/cGW7xzVUYYmWjKlsfpWknY1TrAoTMssaZgchXY9As?=
 =?us-ascii?Q?TiQBqoW+DELeVSXX525RTEf9jA7pEocLggMbY+VfGKym+ZWPoOKjZbmRVDYB?=
 =?us-ascii?Q?FNDv7/vxvUDkODdKIagrgBHzktnCcFTktUWysfk3JYWCgCEdWVlhLkY+rY0m?=
 =?us-ascii?Q?RQ/dRe5zlStnZS1ayiMMsLT02mmyod4PNXmzXSFDqgEV3h88ZsNCc2jQFUYZ?=
 =?us-ascii?Q?LtBPH8FP9PK3iNlG7hasNMx0k7Efn0cX2fNOeFDwUxchIQ9xJh/Yqlr2p6ZR?=
 =?us-ascii?Q?29mpRR1syilQS+1wTiJEUE9M8cGkOQHspmXeR878JXxRaHVPChXLfOCArlZ/?=
 =?us-ascii?Q?l/pXCkWHonKA2+2hZEC16fMd3aRtrO4FwtAJaGQOy9ExS4Or7tEqdnSxkbVC?=
 =?us-ascii?Q?kjt0ol7e6btxepdJpXLk7qDIbgqIjS+0An3qVy9/HrHRciL0rvZJfALwWnLn?=
 =?us-ascii?Q?oVIK5wgFJUoK55ebzk0qGM3STnh0AvZFGCMYfCSZoFNGVVCxZNOEQhjxB2rf?=
 =?us-ascii?Q?ludO7NlNHb6YSLRUoVd6CL84D4j9CwPxRIZLHbnjLYejGvb7ldue5NfriedY?=
 =?us-ascii?Q?sg0QWXUeMKUmJG588StJkGJGyzneM/CVTIiwCeWzqNWOUnpprSX/sEIoJGX6?=
 =?us-ascii?Q?ceOy52CLu8KgTypgIeWbmGYJG4GJf/lx/cGcUQ7SF4K8Q8j/VOvpsb1Ped8K?=
 =?us-ascii?Q?s3fMVxEyZ3CxBazy2Kj4pWcCPqPWPC95ZK8h4K32+IMZvJlq02fLIEBlAvLL?=
 =?us-ascii?Q?w/di2HH5JRrxY6sQk//n+jG70B1WpUeuWEuayJrUkg9bkqupFj4N7zQSoHyg?=
 =?us-ascii?Q?q93YcxpxQ8Za7cK2FH8t0SeITbfWtxUG2invBjaFmUtFn5Mdhy5z1DM660w4?=
 =?us-ascii?Q?7J0NHYM2LK3lWt/1RNx+Nv3jr5NVTQA1Qy+NbndmX0XjOnUeZgRn4ddufWHl?=
 =?us-ascii?Q?9iF0yuVIiiR7KUTyQOqvh6u6UF0/pt75lOlKdkgP+EdlewPZgkaJufHtOLD4?=
 =?us-ascii?Q?yMS6Xkcwi/r6hTECiA4gGIy5fG++E/ZADGSUPoY7MsR8eT9/m8RQeI33HcOX?=
 =?us-ascii?Q?xeItgHa75PEqFBZI7iIlYjqsrnTHYncGzd9w9wNF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB6003.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cea090b-832e-4a95-e7d6-08ddbe28249b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:02:57.8121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYBX4RjluOM2fGr0W0yKphugHgUBOiw9ICxd4bmkvXc5XlBBkSTDBpwLEAJI2QKzc70r9+xOwhY0Tt9wFiSoFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: lkp <lkp@intel.com>
> Sent: Tuesday, July 8, 2025 1:34 PM
> To: Deng, Pan <pan.deng@intel.com>; peterz@infradead.org; mingo@kernel.or=
g
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Li, Tian=
you
> <tianyou.li@intel.com>; tim.c.chen@linux.intel.com; Chen, Yu C
> <yu.c.chen@intel.com>; Deng, Pan <pan.deng@intel.com>
> Subject: Re: [PATCH 3/4] sched/rt: Split root_domain->rto_count to per-NU=
MA-
> node counters
>=20
> Hi Pan,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on v6.16-rc5]
> [also build test WARNING on linus/master] [cannot apply to tip/sched/core
> peterz-queue/sched/core tip/master tip/auto-latest next-20250704] [If you=
r
> patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Pan-Deng/sched-rt-
> Optimize-cpupri_vec-layout-to-mitigate-cache-line-contention/20250707-131=
831
> base:   v6.16-rc5
> patch link:
> https://lore.kernel.org/r/2c1e1dbacaddd881f3cca340ece1f9268029b620.175185
> 2370.git.pan.deng%40intel.com
> patch subject: [PATCH 3/4] sched/rt: Split root_domain->rto_count to per-=
NUMA-
> node counters
> config: loongarch-randconfig-r112-20250708 (https://download.01.org/0day-
> ci/archive/20250708/202507081317.4IdE2euZ-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 15.1.0
> reproduce: (https://download.01.org/0day-
> ci/archive/20250708/202507081317.4IdE2euZ-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the
> same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202507081317.4IdE2euZ-lkp@intel.
> | com/
>=20
> sparse warnings: (new ones prefixed by >>)
>    kernel/sched/rt.c:1679:45: sparse: sparse: incorrect type in argument =
2
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/rt.c:1679:45: sparse:     expected struct task_struct *p
>    kernel/sched/rt.c:1679:45: sparse:     got struct task_struct [noderef=
] __rcu
> *donor
>    kernel/sched/rt.c:1722:39: sparse: sparse: incorrect type in initializ=
er (different
> address spaces) @@     expected struct task_struct *donor @@     got stru=
ct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/rt.c:1722:39: sparse:     expected struct task_struct *do=
nor
>    kernel/sched/rt.c:1722:39: sparse:     got struct task_struct [noderef=
] __rcu
> *donor
>    kernel/sched/rt.c:1742:64: sparse: sparse: incorrect type in argument =
1
> (different address spaces) @@     expected struct task_struct *tsk @@    =
 got
> struct task_struct [noderef] __rcu *curr @@
>    kernel/sched/rt.c:1742:64: sparse:     expected struct task_struct *ts=
k
>    kernel/sched/rt.c:1742:64: sparse:     got struct task_struct [noderef=
] __rcu
> *curr
>    kernel/sched/rt.c:2084:40: sparse: sparse: incorrect type in argument =
1
> (different address spaces) @@     expected struct task_struct *task @@   =
  got
> struct task_struct [noderef] __rcu *curr @@
>    kernel/sched/rt.c:2084:40: sparse:     expected struct task_struct *ta=
sk
>    kernel/sched/rt.c:2084:40: sparse:     got struct task_struct [noderef=
] __rcu
> *curr
>    kernel/sched/rt.c:2107:13: sparse: sparse: incompatible types in compa=
rison
> expression (different address spaces):
>    kernel/sched/rt.c:2107:13: sparse:    struct task_struct *
>    kernel/sched/rt.c:2107:13: sparse:    struct task_struct [noderef] __r=
cu *
>    kernel/sched/rt.c:2453:54: sparse: sparse: incorrect type in argument =
1
> (different address spaces) @@     expected struct task_struct *tsk @@    =
 got
> struct task_struct [noderef] __rcu *curr @@
>    kernel/sched/rt.c:2453:54: sparse:     expected struct task_struct *ts=
k
>    kernel/sched/rt.c:2453:54: sparse:     got struct task_struct [noderef=
] __rcu
> *curr
>    kernel/sched/rt.c:2455:40: sparse: sparse: incorrect type in argument =
1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/rt.c:2455:40: sparse:     expected struct task_struct *p
>    kernel/sched/rt.c:2455:40: sparse:     got struct task_struct [noderef=
] __rcu
> *donor
>    kernel/sched/rt.c:2455:62: sparse: sparse: incorrect type in argument =
1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/rt.c:2455:62: sparse:     expected struct task_struct *p
>    kernel/sched/rt.c:2455:62: sparse:     got struct task_struct [noderef=
] __rcu
> *donor
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/deadline.c:2717:23: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/deadline.c:2717:23: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:2717:23: sparse:     got struct task_struct [n=
oderef]
> __rcu *donor
>    kernel/sched/deadline.c:2727:13: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/deadline.c:2727:13: sparse:    struct task_struct *
>    kernel/sched/deadline.c:2727:13: sparse:    struct task_struct [nodere=
f] __rcu *
>    kernel/sched/deadline.c:2833:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/deadline.c:2833:25: sparse:    struct task_struct *
>    kernel/sched/deadline.c:2833:25: sparse:    struct task_struct [nodere=
f] __rcu *
>    kernel/sched/deadline.c:2357:42: sparse: sparse: incorrect type in arg=
ument 2
> (different address spaces) @@     expected struct sched_dl_entity const *=
b @@
> got struct sched_dl_entity [noderef] __rcu * @@
>    kernel/sched/deadline.c:2357:42: sparse:     expected struct sched_dl_=
entity
> const *b
>    kernel/sched/deadline.c:2357:42: sparse:     got struct sched_dl_entit=
y
> [noderef] __rcu *
>    kernel/sched/deadline.c:2368:38: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *tsk @@    =
 got
> struct task_struct [noderef] __rcu *curr @@
>    kernel/sched/deadline.c:2368:38: sparse:     expected struct task_stru=
ct *tsk
>    kernel/sched/deadline.c:2368:38: sparse:     got struct task_struct [n=
oderef]
> __rcu *curr
>    kernel/sched/deadline.c:1262:39: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *curr @@
>    kernel/sched/deadline.c:1262:39: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:1262:39: sparse:     got struct task_struct [n=
oderef]
> __rcu *curr
>    kernel/sched/deadline.c:1262:85: sparse: sparse: incorrect type in arg=
ument 2
> (different address spaces) @@     expected struct sched_dl_entity const *=
b @@
> got struct sched_dl_entity [noderef] __rcu * @@
>    kernel/sched/deadline.c:1262:85: sparse:     expected struct sched_dl_=
entity
> const *b
>    kernel/sched/deadline.c:1262:85: sparse:     got struct sched_dl_entit=
y
> [noderef] __rcu *
>    kernel/sched/deadline.c:1362:23: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/deadline.c:1362:23: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:1362:23: sparse:     got struct task_struct [n=
oderef]
> __rcu *donor
>    kernel/sched/deadline.c:1671:31: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *curr @@
>    kernel/sched/deadline.c:1671:31: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:1671:31: sparse:     got struct task_struct [n=
oderef]
> __rcu *curr
>    kernel/sched/deadline.c:1671:70: sparse: sparse: incorrect type in arg=
ument 2
> (different address spaces) @@     expected struct sched_dl_entity const *=
b @@
> got struct sched_dl_entity [noderef] __rcu * @@
>    kernel/sched/deadline.c:1671:70: sparse:     expected struct sched_dl_=
entity
> const *b
>    kernel/sched/deadline.c:1671:70: sparse:     got struct sched_dl_entit=
y
> [noderef] __rcu *
>    kernel/sched/deadline.c:1760:39: sparse: sparse: incorrect type in ini=
tializer
> (different address spaces) @@     expected struct task_struct *donor @@  =
   got
> struct task_struct [noderef] __rcu *donor @@
>    kernel/sched/deadline.c:1760:39: sparse:     expected struct task_stru=
ct *donor
>    kernel/sched/deadline.c:1760:39: sparse:     got struct task_struct [n=
oderef]
> __rcu *donor
>    kernel/sched/deadline.c:2578:9: sparse: sparse: incorrect type in assi=
gnment
> (different address spaces) @@     expected struct sched_domain *[assigned=
] sd
> @@     got struct sched_domain [noderef] __rcu *parent @@
>    kernel/sched/deadline.c:2578:9: sparse:     expected struct sched_doma=
in
> *[assigned] sd
>    kernel/sched/deadline.c:2578:9: sparse:     got struct sched_domain [n=
oderef]
> __rcu *parent
>    kernel/sched/deadline.c:2242:14: sparse: sparse: incorrect type in ass=
ignment
> (different address spaces) @@     expected struct task_struct *curr @@   =
  got
> struct task_struct [noderef] __rcu * @@
>    kernel/sched/deadline.c:2242:14: sparse:     expected struct task_stru=
ct *curr
>    kernel/sched/deadline.c:2242:14: sparse:     got struct task_struct [n=
oderef]
> __rcu *
>    kernel/sched/deadline.c:2243:15: sparse: sparse: incorrect type in ass=
ignment
> (different address spaces) @@     expected struct task_struct *donor @@  =
   got
> struct task_struct [noderef] __rcu * @@
>    kernel/sched/deadline.c:2243:15: sparse:     expected struct task_stru=
ct *donor
>    kernel/sched/deadline.c:2243:15: sparse:     got struct task_struct [n=
oderef]
> __rcu *
>    kernel/sched/deadline.c:2318:43: sparse: sparse: incorrect type in arg=
ument 2
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/deadline.c:2318:43: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:2318:43: sparse:     got struct task_struct [n=
oderef]
> __rcu *donor
>    kernel/sched/deadline.c:2878:38: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *tsk @@    =
 got
> struct task_struct [noderef] __rcu *curr @@
>    kernel/sched/deadline.c:2878:38: sparse:     expected struct task_stru=
ct *tsk
>    kernel/sched/deadline.c:2878:38: sparse:     got struct task_struct [n=
oderef]
> __rcu *curr
>    kernel/sched/deadline.c:2880:23: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/deadline.c:2880:23: sparse:     expected struct task_stru=
ct *p
>    kernel/sched/deadline.c:2880:23: sparse:     got struct task_struct [n=
oderef]
> __rcu *donor
>    kernel/sched/deadline.c:2882:44: sparse: sparse: incorrect type in arg=
ument 2
> (different address spaces) @@     expected struct sched_dl_entity const *=
b @@
> got struct sched_dl_entity [noderef] __rcu * @@
>    kernel/sched/deadline.c:2882:44: sparse:     expected struct sched_dl_=
entity
> const *b
>    kernel/sched/deadline.c:2882:44: sparse:     got struct sched_dl_entit=
y
> [noderef] __rcu *
>    kernel/sched/deadline.c:3071:23: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/deadline.c:3071:23: sparse:    struct task_struct [nodere=
f] __rcu *
>    kernel/sched/deadline.c:3071:23: sparse:    struct task_struct *
>    kernel/sched/deadline.c:3120:32: sparse: sparse: incorrect type in arg=
ument 1
> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *curr @@
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef=
] __rcu *
>    kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
>    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
>    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/rt.c:2413:45: sparse: sparse: dereference of noderef expr=
ession
>    kernel/sched/build_policy.c: note: in included file:
> >> kernel/sched/sched.h:2627:35: sparse: sparse: incorrect type in initia=
lizer
This warning is not about the change we made, @lkp, could you please check =
it?

> (different address spaces) @@     expected struct task_struct *p @@     g=
ot struct
> task_struct [noderef] __rcu *donor @@
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/rt.c:2456:32: sparse: sparse: dereference of noderef expr=
ession
>    kernel/sched/rt.c:2457:32: sparse: sparse: dereference of noderef expr=
ession
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
>    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
>    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
>    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
>    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
>    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
>    kernel/sched/sched.h:2476:9: sparse: sparse: incompatible types in com=
parison
> expression (different address spaces):
>    kernel/sched/sched.h:2476:9: sparse:    struct task_struct [noderef] _=
_rcu *
>    kernel/sched/sched.h:2476:9: sparse:    struct task_struct *
>    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> comparison expression (different address spaces):
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] =
__rcu *
>    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
>    kernel/sched/sched.h:2476:9: sparse: sparse: incompatible types in com=
parison
> expression (different address spaces):
>    kernel/sched/sched.h:2476:9: sparse:    struct task_struct [noderef] _=
_rcu *
>    kernel/sched/sched.h:2476:9: sparse:    struct task_struct *
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/syscalls.c:1296:6: sparse: sparse: context imbalance in
> 'sched_getaffinity' - different lock contexts for basic block
>    kernel/sched/build_policy.c: note: in included file:
>    kernel/sched/rt.c:1767:15: sparse: sparse: dereference of noderef expr=
ession
>=20
> vim +2627 kernel/sched/sched.h
>=20
> 04746ed80bcf31 Ingo Molnar               2024-04-07  2624
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2625  static inline =
struct
> task_struct *get_push_task(struct rq *rq)
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2626  {
> af0c8b2bf67b25 Peter Zijlstra            2024-10-09 @2627  	struct task_s=
truct *p =3D
> rq->donor;
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2628
> 5cb9eaa3d274f7 Peter Zijlstra            2020-11-17  2629
> 	lockdep_assert_rq_held(rq);
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2630
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2631  	if (rq->push_=
busy)
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2632  		return NULL;
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2633
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2634  	if (p->nr_cpu=
s_allowed
> =3D=3D 1)
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2635  		return NULL;
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2636
> e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2637  	if (p-
> >migration_disabled)
> e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2638  		return
> NULL;
> e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2639
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2640  	rq->push_busy=
 =3D true;
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2641  	return
> get_task_struct(p);
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2642  }
> a7c81556ec4d34 Peter Zijlstra            2020-09-28  2643
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

