Return-Path: <linux-kernel+bounces-880825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F65C26A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF334E5F84
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31429AB1D;
	Fri, 31 Oct 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyG60COe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039E19E968
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937404; cv=fail; b=TeQcNdEntohCwbCPVaz5gsEhQaPPwvWBmE6p3SBdIc+lNGNlED6hEafiBY8Uzaj7XO45FqYLSsx9XA2FTOCo9H/Z/UQMKLUZJgF2XvbfGoiNPzNb3W5xYGwX/2C2oVrAcX8fairFaDvUiTfnRceK2zmyxnxPqGfDO70GJNbXf20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937404; c=relaxed/simple;
	bh=5VGEVf+JpzZyJM9sacUcBz9iDA8jhYb8dcUef/g5Kk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bV9Z8crrjMO08H1TNwI7O8sIY6gxZUOIBEJonj2/L/9zsqs0O3rNg2ZEqmCQ2MhBaBq6mjG7ygNUy3sypK4OpTgBXQ1Uy7yQBmNPuRe3+YwWMNnt03G507g33HqxJGKqCREWdh4KpZQDPjZIXy9CkVH7fxHEst8pGkXB7S9brok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyG60COe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761937403; x=1793473403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5VGEVf+JpzZyJM9sacUcBz9iDA8jhYb8dcUef/g5Kk0=;
  b=LyG60COehZzk982QH90i9ir3W1gNUMoTP8JkG+XJtqbCMFfMPu+0Me1G
   WfbCwxFuaOLJJ+u3FLDwmh4+J/oxOWPtJkKmGxtUmPbzK+ipo30PtBZcK
   P76ZyCfEsYpT3hmFL7BbI6mWCTVrT7U7PwIe7u7lRnDL29CQ7oG7t06LW
   yuVPaJB1nZrj2aQ3OGKzGyxqqaJIKiGslTUbSVDIwJawSMRMsyaONwX1U
   EP9jXGV9lpbSodRT9LcJgWkYsvUR8nZUZNVN82XzzT4myUAnHK79vtE5s
   nnnNpdKIJsRNpunI6ORcMr778Kfq2T+Jdx771GSSPe408IL7eWQU9i/aq
   w==;
X-CSE-ConnectionGUID: 3RECpuA+Qb6vRj7zeN7U6g==
X-CSE-MsgGUID: RBW2TFbKSPWxIGwHJmnjxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67943516"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67943516"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:03:23 -0700
X-CSE-ConnectionGUID: 1gg0CwW4QgWxtaff+odu5Q==
X-CSE-MsgGUID: 25/v7MxHQWaLf6myUEp5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186641081"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:03:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:03:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 12:03:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq1mmrf2pPrCPJ8MKZYZ9Q+3fYRWIYCV0n4611NtrtusJovC3Ix/Sz7ndfMN0gQ0aeiwaCaGsGtKZA/Jr3vPeVIsOQ8Rzai0480ZFyQpygM5WNXDrZQmlTR01L3lu26PoDmT+DkQ1aV+EH6Ss6ApuZyyzOOVOG7/a5fWaXeng/0LJWfIesO390aQpIkJ40rckI4uiImsATSv6WYoNzIQxDKTqtJIZnPyAyTqhtEWysqU9dn0WV0R0fAe0ppd1qpfBaAab1kQNtH5MXdvMEhKvSU6kJlEPfnPIuZi94/QTWy8XkQN02vfv5/qfK1cGmLU9LGfvs9j+RKG6ZabisGZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VGEVf+JpzZyJM9sacUcBz9iDA8jhYb8dcUef/g5Kk0=;
 b=H/NvJviImVDi7vrk76RMaswY8ckS/T9VnpyvW7XQOf/k2fTTDWWSXu79etHjVJUS+kXNLxbLlrYjMiWGt67lnGLbke2CX+mo4woCrwWkot55cGy4+0JLlyy1wDK9K3YK1agCuGLVhr+pHESSObSquspAjRdI9NAieeL0JnfAlebB8pKrBkq8s+V6VM3UVaBWLB0aA2lZkgD637lD5cO+72sT/c/HS4xjFrL8sMJhzag5yH88J0iEUlBMvm5hvs9/zFjOnXXT+KvFedG3Flox+S/M5ZLGo80uO62TLVxOfIf3cWdFLqk23oHmysxrLoOJkvhrGMy29tUU+E6onYMaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM3PR11MB8715.namprd11.prod.outlook.com (2603:10b6:0:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 19:03:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:03:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Thread-Topic: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Thread-Index: AQHcSpKn2ZdAlOH+uEyPC68gs0k/kLTcm3DA
Date: Fri, 31 Oct 2025 19:03:15 +0000
Message-ID: <SJ1PR11MB6083A4A7720723C14F3AE314FCF8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251031181722.250851-1-atomlin@atomlin.com>
In-Reply-To: <20251031181722.250851-1-atomlin@atomlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM3PR11MB8715:EE_
x-ms-office365-filtering-correlation-id: 2a05159a-14d3-4697-f881-08de18b02566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?+LLO3UM1EQ2eYwmPaa6f9oU14CYSoIMvV3Ovxbpm0fW75ygG9ZRTOtUctlck?=
 =?us-ascii?Q?oDvM37HiL16CVBB8w+e7Vnch0TACpoED4+VGnqA73a+nzljeZeUXVf32i2I7?=
 =?us-ascii?Q?kNIsTIq8uBv58zXmhdB0bynTuZ/Z7kMU0YGimjTvQz9LQ2/pttJT4n5ZAxDC?=
 =?us-ascii?Q?TiYfLgldJoH7MCkEm4HlJydX/kshlCfGQ3yO/UF8IOKJ2RzUf641eUffQddp?=
 =?us-ascii?Q?8wEu9UjdQmFcm9pYrcI9wbqP41O/tDiE+vkhDr9WTPToc+rdWjxgNII9ePnu?=
 =?us-ascii?Q?e7IUD7MLhE5QA8rUJ15BReh7VYrtY7pkaO/EyMJLF93DqqeWLtCxBt7fG3cE?=
 =?us-ascii?Q?yk1I2l6ArDRgsCf5nqbAklyB3pLXfVrZU3fN4j0gk7aLj4mXPqPv25Rs5zvZ?=
 =?us-ascii?Q?yR2Tho1RGQXYl+Z6U/6oVi7rw4zFzwBysmXGxNpBLR6+ZUIPX4UNw4EOfIT/?=
 =?us-ascii?Q?lItMJ9XFTd4KcE2qEPL0Xg86/ruYhouXSZ4PgqfEEr82L/Ys2yt7S6RPAQuo?=
 =?us-ascii?Q?p50CyJli2TQDiW9z6PwxhimRikceE9EqXNdoYL87Kt/RJUYeFqp/I6GRPUNJ?=
 =?us-ascii?Q?guicuW+5WmQPFxK8FonVuwa8/f69ep3FGx7T6zuqI9RUcvvZ+El9Os+Tdu0o?=
 =?us-ascii?Q?nKiENfl7ixT1ZCmSrd2Lfchs/LA9zu8H/b5NhMcqxX1LhecIrR66g5GmbXx3?=
 =?us-ascii?Q?MGpig2wEAo8ckpcsD3G+RGs84XU89U29F37EQy8qsOEB6BEE99ic7EUlGsZ7?=
 =?us-ascii?Q?kfW2q5OQMbgI3jVIuk1aCPjAjObiyq/8te5KL50kLAo7jX8/2khQkJIYZbnN?=
 =?us-ascii?Q?lcitH9vmMCTbbidg56v8DS29W3fLmFSiv2d/Y/3cC0DFd9OWpe6+m68hNkWb?=
 =?us-ascii?Q?GQNUW8HKAoYXXUB5CT9BmIwHXuRscn508+kZDYn6uWZAqto3LXMfY0puCNYF?=
 =?us-ascii?Q?JIWendPjuF7Tt5Gf8/z2gEYl7RHLMg+pyhTkKu/yEwN0Qvt0KiRVIvQY8kgZ?=
 =?us-ascii?Q?/ebit8BBD3T2S263HI5P/z0DO0+0XIz81h3gKPwL/NVNYq4WRIBVQOu+eF8o?=
 =?us-ascii?Q?PJJrP5KGJyKFB5SxcMDGmWWbM/QDvUrokpA7NCvBMz5A9MXrUCTlKfyPQxY9?=
 =?us-ascii?Q?6WAOJT/U5abBJyatr2sEM1ExTXIwr3U9FrC7vWsutOC5Ocoi+sasYcKFIYsm?=
 =?us-ascii?Q?lUyebhSTwOPXzZ9N4YtnkuMPu9gjgLc6x6SuHYCndXuzE+MOe9pNcvfFyIB9?=
 =?us-ascii?Q?irG8CmGkX8K+ZuLccTx+56B9t2jVIHyzyCP7oB/1oP/eIpOJ/zSGb6fcmYbZ?=
 =?us-ascii?Q?SfzDj5JG1aAaGdbyq9eTdLfJKU1bv1/Ze8/ZycxPu44RZ6aalqRnhGgMmO1h?=
 =?us-ascii?Q?8XVaTaTp+X53KMqdAifDh2CAV4E+VWvMJeALxR+pBv+ZiUL9qCREERzW4XjI?=
 =?us-ascii?Q?PMmFX+pxtSVB1lxWm6rZTCZEBUfnML6NAmOw9Dk3HEHJBtvnkyMRP/gsplIV?=
 =?us-ascii?Q?zAeMq6zXqam55M5kUkAEeliChDCxToLLCkJfTSmNFZv6ypY5s5lyrYc4aA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDIg9NKSFht8Q6/0nJ47po5khDN4ImwhpNgVQiPIKNUziKJ1LehwFZNtcxQu?=
 =?us-ascii?Q?zFtEP+GI55cq44xxVYpI9GvSEanUdWnaFbTzIfrtGP8MwlJNho3JN/W0XkJ7?=
 =?us-ascii?Q?D12SoaNvzsakUe98xj8aB6p7N4wyoE+wxvOLxS3Cnax76qkW5aH3sdMlta4I?=
 =?us-ascii?Q?634halIyCtrJhePMIZ0vLy5v9kP+Ndp2q6SgSsLSOMbl87egtQgTbMf/pyvQ?=
 =?us-ascii?Q?ilsezxt7A9Jr0gJ/BXbekIfKtqv5z2evHo2U9BVxl7BT051KukTLyJKv1ZvA?=
 =?us-ascii?Q?fRMQr9T2oXLyOXQOYIc44GvRoRFQgaiN4Y/C2ZqNUFKoNAmbQ3IJYhL0/KkE?=
 =?us-ascii?Q?0FaOHNgGp08PsA9LyrYWM49HK2C/tbKN85l7SnxxraLASHR2RGxoE+DLTq1g?=
 =?us-ascii?Q?LajoQus4hHUFO0u3iU9No2Op6CXzECrVwf/yMVqVGKd7Oks1+P2z5uammzg/?=
 =?us-ascii?Q?MeMfHBqKkA6Dl2fupGnaafB+vOWTBGw7t1Zba9xIa2afs8T6k032U80NbMj1?=
 =?us-ascii?Q?lwq6/eLVGrkBRYf2Dc+1kmGMVZjFdfACLv2yHyrqgxEfCqMSh7dqGAb+r1o1?=
 =?us-ascii?Q?S3pNVUbbCbxE/jHS09a1h4QJKdTqu0QYdwRg6SjnZhCp7FHbNlDux7KOfP+I?=
 =?us-ascii?Q?A76wlEbhIzFvH/YxgwbGD2hCqQ2Z30e2ZLCnPMYSMYiCkzqhN8UBFVVo1n8c?=
 =?us-ascii?Q?yCDSniJMpeqAMXoxcyhDWiloExPXAbLKkHAo+7qyWUqOMdhELDt3TkvakVoI?=
 =?us-ascii?Q?lssvRxkWfqiYBfko6qGH9vdgStRMgNargvyAc3wFlAYwIU6My/5OngOl29uD?=
 =?us-ascii?Q?hf9UH2MLTXpXtZc4mS0ZVVdydGhxsk4GGbZiVAmDegqkKlzMZfkUx567QCh6?=
 =?us-ascii?Q?WHvoUN8PmE0v0k8kQkW96wwfoLWbiwd+eS2SRCh2ZH0xgLTzu8+B0HFxbFcn?=
 =?us-ascii?Q?8U8ETfVfjl9ckd0B1EdkyNurT2P/gTSGijbc6snL1XC8v3aGociMP4NFyGSw?=
 =?us-ascii?Q?muzy4t5VBVLR1vlU+ui7Lw0NWWRaflZfn+B9KIQQ8ZXTc5H1MRZHpQx/Ul+l?=
 =?us-ascii?Q?+BzF+x/If/hd+HaPOnxu2q+kgKL5/mUdpsUdUmYDzxrFniT89XBribcJbtgK?=
 =?us-ascii?Q?xGy6BYtxLvfSgA8kQuu01siCzKPsS0FAxas3NFEqtodxuJCIKXSTtT/25up/?=
 =?us-ascii?Q?Pk48K4FSrHM3JTeQNx7VkgZ4EicwkMYlulweSgNXzR1twog+J0CNlY473uX9?=
 =?us-ascii?Q?+TOoxtRUdqGsvNuxTxWDGPb/ZPXQB46da5lLj0/lI0/cvZdbFQy0ZnoVFvA+?=
 =?us-ascii?Q?h7dr47OE8jp+dvB5lKVoXRZw15gkrepSQz+KDvkuh1P/SWpCHXHTtGYQaKKS?=
 =?us-ascii?Q?Ed/6FPsv3HoE2sWnjg8+LDn3IMlaGje2o66GnRKokz1FLZ1r7/n549olsn1D?=
 =?us-ascii?Q?UFlg9ov6CvYnbeaSrdgfM7MFkQaYy4q3g/b0K9tI1pBTxVFjwpjMUaqGfn8H?=
 =?us-ascii?Q?3pStl9H0rg3A2zafDoq0WWFiaNrEjejS7PuHj7LDAfg8tI0AlAEui2a9svet?=
 =?us-ascii?Q?Ijh+/fFaxKbfqPQ9tN+EvfjnC+lGGiNTSjeKbq9q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a05159a-14d3-4697-f881-08de18b02566
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 19:03:15.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UH3N3BR4jmBIxJaeEGHVbdKtulmAeMDpvH2d4ea7D/izF9a8ubeF0UZwmqRK3df/kkh+u+YX7e4jaj30gpldPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8715
X-OriginatorOrg: intel.com

> The current resctrl schemata output provides only the domain ID and value
> (e.g., 0=3Dffff). This patch updates the schema format to include the
> underlying topology, making it easier for users to correlate the resource
> domain with its assigned logical CPUs.
>
> The output changes from "0=3Dffff" to "0=3Dffff,0-15".
>
> Please let me know your thoughts.

1) You'd also need to change the "write" path for the schemata file
(treating the CPU list as read-only).

2) This would break user ABI, so is not going to happen.

Users can see the association between the domain numbers and
CPUs in sysfs.

$ cat /sys/devices/system/cpu/cpu0/cache/index3/id
0
$ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
0-27

Maybe not as convenient as a direct read-out in the schemata file.
But the information is easily accessible.

-Tony

