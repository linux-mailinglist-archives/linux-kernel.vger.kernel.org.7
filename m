Return-Path: <linux-kernel+bounces-834348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1EBA4813
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D035B188851E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB22253A0;
	Fri, 26 Sep 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQ5kA1dW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B75223DF6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901851; cv=fail; b=bWAngeGV314ugHAPDr8clV/jGCbOtH/7MNDevDvjmEk+Wd12qhnM+1J9+7fZZqWHyZPaBeHHFtraaWT3VQ+2AwRYDF+xdWpip/NWrXEBPx9cwolZlmN3UbcNSJr54P1zF8fSVVlN3hJZRs6z3NpEpN9c6xBO1FC4dALVRAydRkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901851; c=relaxed/simple;
	bh=d89AYNiROdjZMcr7VJtBATcbaJypMEei8HqJ0jWF9P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7sb/7Z9JSaxBf+Pg+VsUwjVXaXmR2Oa0lLWvbTQPiiXtFtfm9vZY9Nx/iAHrQ5AFa+cx/BwTSmZ0if+4QqvgUHjzQs9gZghVpHh645cF/J8iHi2ld8tD8mwzf/A6LUPMtobzb/OTC1H7sfBwDjk8lLR2ZB3HIMR/Jn9B6Jtrsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQ5kA1dW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758901850; x=1790437850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d89AYNiROdjZMcr7VJtBATcbaJypMEei8HqJ0jWF9P8=;
  b=FQ5kA1dWu7MdoMYb+GyMndiI26w8u7Pbwb+php3tIFL00ZFhfTIRa4up
   uApfSPiyx9QsJ5IKxSJADzUp10wbZHqTliURMzKX4kqKQSUXyUYJHgoMF
   rpa8aSs8CizL9XkJ/mfqJcK3r9Kg+XKczEjO58dzSGDqYmWYDWCa6CRIJ
   zLUgXmYyoGDftjoM5cr6/1fSfxnb6iWH5cC5y+onUg5mHn0zSQrJByB1B
   YkO7EOB5waD14Lo2/Ug/SL5bt2xR3+TN3puGvOtcn2273sEjzAx0SwrUe
   7obp0GsYfHf8MBNITvbyGTB6T/jb3x5nBfwQ5ToZ20m2kcsxJsrgazPYN
   Q==;
X-CSE-ConnectionGUID: ICQVxHQBTDuX7wf4Z9hdxw==
X-CSE-MsgGUID: FKJVSpleTTej+eroaU8ssw==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61156337"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61156337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:50:49 -0700
X-CSE-ConnectionGUID: CfisOx+vSIGOLpdLasKmSA==
X-CSE-MsgGUID: s+5314gBQGae6oWFTgiAkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="176765976"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 08:50:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:50:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 08:50:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 08:50:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5Ov88NagvAWoBwz5l+gwjIv7Q3jTNb8uorAALMHGSbD70k6Ls4znRJ2rBKS/JH5/w5u20EQccOF/Y+VCejfvLmlSfFsOkvsKi/exGjLy4yYl65SiqxwAN7DWyFNTd+a4vOJ/grcDWL3xnhg7VuSj8JAAq5RxnxErHh5uoMgT6UqEQLFiAQbXCLHFQbwlOQFgzMwgnwge1ImdDpXEMs3v78MqAYtr+1W2hBrWdTddmrw8CoQYZ+NMdugvb3FO+a4TKaurx/qA2ew/SfF2V8KDN9vzrNZgm90aFRlWLIMQ2MHarhrOEi/Ls6xn2V7V/T9swO4T8zUh5fTBsN4wZ5O3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d89AYNiROdjZMcr7VJtBATcbaJypMEei8HqJ0jWF9P8=;
 b=IBezUYecotTioudT8m41Fkl/rNrrwHbduMcktHX9s+SrqIkqTU+xMVu+LO+wvVRoeZIjlXZ6tUipsRSm52nnV9GRnLFrWezvC3sr1U5KP7q3PwuxrIaByUF74uKaCrQNaFIP9Ca3siw2bFq3lSs+0w6p9djmdUsCuWvHWhDal6931/ajfyOwv9yZ7O7/hE9cu2c4W22v5dGFd3Tj0UGm2a3iCfkAVeru5nX7icWFHU2ccx3IZTryHHOTH3wSZmaTqqtjBwFRWqmMBTX69KEgVU6au3GxNQJ07da2dZAHa+OO36ypSeNlePQRtDf9ihNGkr7vdUo6O+uiPsD6DAIXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 15:50:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:50:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: Fenghua Yu <fenghuay@nvidia.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, Dave Martin <Dave.Martin@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on
 Clearwater Forest
Thread-Topic: [PATCH] x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on
 Clearwater Forest
Thread-Index: AQHcLp2i7Y1Cwof4G0a2uJcelGHhlbSlnRHQ
Date: Fri, 26 Sep 2025 15:50:42 +0000
Message-ID: <SJ1PR11MB6083D2E66F894F5C65530927FC1EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250926041722.510371-1-yu.c.chen@intel.com>
In-Reply-To: <20250926041722.510371-1-yu.c.chen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6392:EE_
x-ms-office365-filtering-correlation-id: fd9bf1c6-ec8c-4da7-11dc-08ddfd1472f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?o5Wp8fUz1imc1eJERq1RcG8cX9AmK0yjYr7BDe3SRD6bZhpUMZqG3XUOEixZ?=
 =?us-ascii?Q?aJSgZbIloKhEbU5iMUEpYN0CpnVEQjHp4RwVJFgxqBDO40YqOhOqI+zZuiGF?=
 =?us-ascii?Q?UnbjHYeNxb9dzLMelmU3oXDFTIi3bjjKbPCvsAb09X2wI+D1EyUyNluv2OAx?=
 =?us-ascii?Q?QRjxGOhhL7l0a74LBq/+nWlLCszY/RDDtLvFAGE11HfkT3UWgLl/ocBsz9HY?=
 =?us-ascii?Q?h6+QidruJF6dOvMj8BRa22b5PZ0Mp8MpIKTHgBOH68uU3K49ijNDtu/4vdJo?=
 =?us-ascii?Q?9wqwzpmitvrP48RguYBZSKuxsuhTvIEHiLj6u1Z6evIwfnC9AkPoCmP7t6oh?=
 =?us-ascii?Q?ef6oWuFOwVWfC+iSwNGSb7jwBSMDCHR4P2fnOLnw5lmdW3mS/NJFMEmen6iD?=
 =?us-ascii?Q?FG4GXFkUP9pYhONfRarSIgoeLwSfAINx/lbYQYbjCRr+hZk8wLnKSTcGh/3d?=
 =?us-ascii?Q?bIUqw6n8T9GYixOg0WViBGh9Kwh9N5yXOwPU2E5u88tFcHAS2tWGP0HyxLdk?=
 =?us-ascii?Q?bh3pAE8T/mfPk8tFLb8z4SN/1eHS/S12S2v0ZvfFu8pjEdq2YuWUqH5jZXnK?=
 =?us-ascii?Q?atr+zC2KkNrz0DXY0f1NOc+nyzyIgeXhYaD1yL86A78OO1W/pw5zZPCgPINS?=
 =?us-ascii?Q?6KuvSYnkQZkpuB/AvOqSRRTGGqKT8gtYOUCkW7aDMHm/jf5WVcIJmczgrkkG?=
 =?us-ascii?Q?R87Sd6qNSDZLU5k+0N1uR+f8/8k658E70ld3w5TijMjTTWNKp3YC45cY6xJX?=
 =?us-ascii?Q?4Zq7ahLslJKP32IWjmWUNtXEeEggbW8VYaX4G+pypTH8bpSVCknvO3OygOTq?=
 =?us-ascii?Q?cK9FHNcWZhpwqYwsnRTBVxEtEEQADWAgZzvp9blvgic89mfk+LLIsZiEdONV?=
 =?us-ascii?Q?aCDBYbuseqW2ebp3HV7Ts6QpcrmidRn8xdXZGqg1+R0weL3TH/amKQUBIroS?=
 =?us-ascii?Q?eF7B4wAopUVF8WV59a6dzXIPqbEITPX6q0/CaDi6yprLOerwFomccpMRbQJ1?=
 =?us-ascii?Q?NnowFFhGS73yCJsT3cG6jI+YJEN5snMjYO6jvs1laE0f2fWq82AUaIGLgB3Z?=
 =?us-ascii?Q?ctlF/K4YSNQkcpGeKBrW6N0r2UzvcjXuwwtFWHe2EJb6JgZ+C287tGqI286m?=
 =?us-ascii?Q?ZV0SX4DzaNrJ5ZCr/ICMaHm/stw+3014jIG0JMnYr9g4k+X0LuEH2QaO1Hmu?=
 =?us-ascii?Q?i5yt+jDyYSdowO/lYXi9hMQOZLuFmPnX3RcLAFg4Al27yOfSaV7CdGz0knLP?=
 =?us-ascii?Q?HtKpOINM/bteXg9kKxZA+ejI15zX8s8rsTH5ZPC36V7d4r0FXlmHNF5fvAOT?=
 =?us-ascii?Q?ZPSuAPasn+/ZCyrXt5Mi8RZSv3riRyX+LMP33P9kLHBS1KyErRIhBZvBFXJP?=
 =?us-ascii?Q?mRZrdgEr5GBr00PPeoHI/LYR5Cqev68lO7HsN86YMNDbkvwJuBb2FvYmTBPe?=
 =?us-ascii?Q?holO2ec94R/urLBF/2gbVKUidA4wj3r7jYBM6Hpk/r4eUw9024x+sdMsEwev?=
 =?us-ascii?Q?XayUuCp5ChJKfeU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5GxIxn20twlxfCZdGDQe9BQ21FIVdQMCYp8my56V0dAdcaEad0IPvBV3z/S/?=
 =?us-ascii?Q?YqLOYHPnVCWckD8bThVZvzUAjouMCyrospaocTEAWjL11BBHUkif2euahRnR?=
 =?us-ascii?Q?gkVDGZ4J59VoXLFgxF3PRhLhx+8ajkmoB3sitaXTReyBNIl5+WwUoD0aKgWp?=
 =?us-ascii?Q?IxmXLVvPt3w3FV9MLN8LjgaCXo9lMSBf/uWOr2CKv1U5IsI699/+nMGika7A?=
 =?us-ascii?Q?K/Uey+EzWkMj6T99I1s/RR0SDTVwAXeAkdj0R2Ou3d7fx2LftDEFnE8NLJgy?=
 =?us-ascii?Q?tgb+2/4kMA9j/ku32pE+GwwRL3Ss1S9S4wxhJrM2VrLxPRXQ99GGZTCnyuDF?=
 =?us-ascii?Q?V91kPVPjmOEtWX5R4rc4kI1B7DmGJhQO8fwB+CTu0WVHhkgvpK7GMd4zI8y3?=
 =?us-ascii?Q?2tTs0SGfVsuGoylLTE5MUOo+NAfXIlaSLc7jHReFvf+6cLEGeOIN6Soh0vcc?=
 =?us-ascii?Q?u+dnrIzOswnTznb3qE8S4Hw/htT6PNgCeCbcZynsntr3AZq1c/vljRw46Q9K?=
 =?us-ascii?Q?EgdfqqiSyNEaGtH5q0lbEvx42+AGghdYlPeHXnJHN9KUTaA9VbZ6cndrL/lZ?=
 =?us-ascii?Q?wrGCu4j/EsYz1rLVKMCDMB0tkAmKSHpFtfvEm7Jw1c0bEsLt91rtlU62UFkk?=
 =?us-ascii?Q?NyFCVL/2kTL6lFLDJ5wwHkCEgjB+RspabpBHY+hb3ePMwNpwvpWjW1W8gFEJ?=
 =?us-ascii?Q?WZXWGKTGPvYE8yHXB8zWsBe4YZ2+dO/BA9+U58z+MrYI6vnYiOYp5j3HSlPW?=
 =?us-ascii?Q?EH/sODfi2z8Ysaun0RDHLNw+hLHNqet0Bj+97Ne+VRbJtXxLPJIXxl+8O0Bc?=
 =?us-ascii?Q?t64IopT0xweYISTZYLd4YlpO4W6ABda2TmaGl5pTeCd8I2fq8TX7Vbzpi9fA?=
 =?us-ascii?Q?QznIn47Z22KnYHBTPQtwlkk31IpxmsYTxlpaHPOx8d9FGpp7PS58km3Fcpt3?=
 =?us-ascii?Q?DFFRfhPmHFyKINHTyfjA52xBk9Vpt3wr1oMVYeipvbY9iHdjJCCdTq4CPnNg?=
 =?us-ascii?Q?nsVxoqBV+xMOO776/80zn1Tq2pRB79ZVwgv1PuHFHNlc6hlhUPiC6xm7rSZU?=
 =?us-ascii?Q?tkycT8Ls1lErjbABln52nWFGG7Pj0LWX3Ol9zT9W0fBKBnIvROwUX1WT1wdo?=
 =?us-ascii?Q?BejXUNNRl4uKvc5BFZLoLJYEgUjVPE6bAq22MJA/DymvhlOEeOfJwRPwmGW8?=
 =?us-ascii?Q?64j5CmwLMuXtF+E7oVEUHC7G+6yyl42OE4m4i0Wo1qFQxDE5fhrj3E+54hYv?=
 =?us-ascii?Q?o4+4bY8euPw//I9KbcxU/N8/qaipF1NyRmEbT2v1luB9lm9q4GZe/3tj3Zlj?=
 =?us-ascii?Q?jv7WFWrdZWSQkOx2s4jBt1i1QZLTvVKBDMqHxiGr1fnPmaCPNIl3IuMKOU87?=
 =?us-ascii?Q?Q7/7DHkAncPFo04FG3GMO6MIyEzh3QqLy68BlqNlv/zcyynYKelbAAKh9Wys?=
 =?us-ascii?Q?ELxglvGv0KZGOuViO3MC4cUFkKER0mwMQh9zYvkklF9u3C0XwN+3dkXJEjKB?=
 =?us-ascii?Q?2OvECb1sQqO8alWHZvHSCz8WPs/V3MxhIC3Ff+y+NQSfqaFu9QzTE8eXOOiI?=
 =?us-ascii?Q?WVlRCEMTaisSfSUhSF2tADdxNne/oQJrPexLhl4X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9bf1c6-ec8c-4da7-11dc-08ddfd1472f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 15:50:42.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xd//HL6jJwWg5c7UYsx+hLcUwNoYuyCC8jfWL0AZecbx9rxzidmBI6Ut1LowE7nWf8DtqUzpT3cSQ5k8E+tENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

> Clearwater Forest supports SNC mode. Add it to the snc_cpu_ids[] table.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony



