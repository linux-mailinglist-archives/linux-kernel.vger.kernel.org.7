Return-Path: <linux-kernel+bounces-840511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481DBB4934
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293BB17815B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277642673AF;
	Thu,  2 Oct 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4L+H7jq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9551264F9F;
	Thu,  2 Oct 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423432; cv=fail; b=DmsTvH0ZpJkblO9FBhNPrwYtWcdAkpcblv3BSCINvYcDOZC9ER5aMWs/wn9X2hOnLTNJvFKm1J8M6Yt0UOomOQVajua9K2YUrDKW734hlDmu85atasooLsS8ESOx+WGzEQgweUtR58M41PGasuEn3nE2UcxNqYrqmKshLjSQAFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423432; c=relaxed/simple;
	bh=30keYkDlHvqPrTlXTsktdNEahpZpNyUn5Bjed2UJWi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtgJJ0jmjWjQD0cdsYhSPyPIss88jN855Gi+NR9ofC/J5T7FxOEPp8XS1BE031PgFhVq3K2myTmRk+pT4Z1k91KZqFh1wEctbZE3b7wQQaVdxwQM/P3kHoOwQEGY7NVx2mmpNNjdN0mpR3B0WUNw+YBzrdJcxu34DHDNn5vn2JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4L+H7jq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759423431; x=1790959431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=30keYkDlHvqPrTlXTsktdNEahpZpNyUn5Bjed2UJWi0=;
  b=i4L+H7jqXQ85CEnonl1WWFo+SLRQLyw8M+bF+8JkvevYnhvmBm7ZyJGw
   QXpCjnrMUKlDz6hpJPd3KoVira71BYCdAy53RSE+ZDQBCf5G0LR6TbnqX
   i79QHuuneEyJW7F6Ao27lAnsvUCOgDa095w9pIixY/GjgMDKJ+47Q0Ha5
   EFlpA1RTGbc1CIck84Z90pUSH3lnX3NDpb7uBhkLn0RDAzF66wg/sJUXb
   bXszRM9lRwl0lTzkKwRw8sTITmVDwhxPi6L5l4GH12WpGfwCHI+tCosdW
   bFfPLHraIAyFmgYagQ37Feptu4WX/QUZezxQegMFb86eVVYw6ri/4WcCc
   A==;
X-CSE-ConnectionGUID: zJEU6WrcQtyrfWiHEPA/Dw==
X-CSE-MsgGUID: NECbQ842RLGK4tpG07Itbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="71956920"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="71956920"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:43:51 -0700
X-CSE-ConnectionGUID: YVYsa5pzTAuc/XdwhCcbgg==
X-CSE-MsgGUID: 8NrM6whiQwKKZ5Yyvdmm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="179869106"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:43:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 09:43:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 09:43:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 09:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+wfspsQKOkTeVyBxKZeEVU2sdBNtf4pP+1iOb6LgBNbx0Qt/LyVFr9jy9MNzT+K6NC5vj9xB7w+yFbs9TpV/pkeNWH0HB72FFTs9RILz56fF/j29xFPsE6iNs4nnAVtoMtOt73f63kTKYK7SBcYgrwL1WUi1K+R3+S33W3bLmhuAB83xVQiYrgsRThMNh7r22+acHLofqhvIA+5q7aS9Sdpw/yaq2FAcYxVPMI1qtfEnLNol+TbbRIJX7llkCqHnmy8rU6JqXAOiIX0Yw4+GsWRq8YV+eOCOs5uHZvGC5DY8O5CdpilVs7VCXxwCk80n984Q4mHA3BlLiUNrxXTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30keYkDlHvqPrTlXTsktdNEahpZpNyUn5Bjed2UJWi0=;
 b=CRSiL/Bxx9Idv5shrriIrb2DxjNBDPelyO3QRS9sGQ9aI6IGFSL5Zl8S9JG+jYueg+IzKVp0kjr53DsSamRRzxMhD6zknKSRvXESoDLcf+Y86NInfkgur2FjwQBySKaOM3JCz6G/ZwPIaG6Zi4yDlieANr8tBZUyIESBcDqtgRM7AjC3Wv//p7NsA9H48SSBStvQuqStOUuVbAK53Po30fnX8T+J1sPagQ4/d5qrfJxYxkFJJ7t0DOkk5/iHbkbSgzX2ayl1FwEHCwpREU9TH7s+NVFZPy1sDYCs1103yflhHOEordG5drSZBVRnPaC0a4y+JWhGbYALtBkPQFjumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 16:43:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 16:43:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Topic: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Index: AQHcHCY4c4HVqMw7CEaMcDAeu2aTP7SfbCMAgAU7aICABWR8AIAAUhcAgADzJgCAALu4AIABVGKAgAHMBICAABDqAA==
Date: Thu, 2 Oct 2025 16:43:46 +0000
Message-ID: <SJ1PR11MB6083F946E57D3C1723F341EDFCE7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>
 <aNv9cA7W+NNZuDSc@e133380.arm.com>
 <38569247-431c-4b0c-af0f-aadd6fb26849@intel.com>
 <aN6c3U8te/MK/WlW@e133380.arm.com>
In-Reply-To: <aN6c3U8te/MK/WlW@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB7620:EE_
x-ms-office365-filtering-correlation-id: 937fb4fb-3b0e-4948-eea1-08de01d2dafd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?F9YtaZnn7/2rKA7zHmZfQ3xqxfcEOX723SB7/ytHG6xKVKVIj+RQXxDInvXg?=
 =?us-ascii?Q?Yg6PY2bHDR9MMIgQIsIhplfIbmw6b1FV+2nN7B3feOOZ4bd7kjXO2IhuOC60?=
 =?us-ascii?Q?A6DPytaDZ8nXiLi09WhcyFLyn9039eG1aasix9uM/44DEnquKjp0TEbmgDRU?=
 =?us-ascii?Q?na9FIqtEghrEvlrh139Dfx3cNsasuZDBNNg9KdkWnMwnva6R2bHu81+VoMu6?=
 =?us-ascii?Q?ryr06OeFYwnkrIF6mq5jiDWRSVHOK5/vnnrsLyViMJC8a4won8k1YQttc186?=
 =?us-ascii?Q?UV3sTHhhtGFpfS7IbI+cpWQGBxkZ1kBBs+8i8E5dKFRTZ2GVMLbko3TffRV+?=
 =?us-ascii?Q?K2IQELFSnRjGQDKLwlMa22UQ4EhcUZYA4rAh7s5fnL0MJwZRZ30qyaTkQZgo?=
 =?us-ascii?Q?mkQpd5njTGdlVs4/ifXg0ea1XEjLsn4QKSjdMyz65Pub4xDJy9Gorltvts5b?=
 =?us-ascii?Q?n8U9XANmjU899JKNvFeSXZLR+X81eosExRVOhVOJdliBvVAagikdbqOokTPK?=
 =?us-ascii?Q?zab1zjdai8ZPkmZ49G/MJHBK2tm9Bpvv2hwjkPDGo74leVPt9J7ODQj9cb+N?=
 =?us-ascii?Q?8TmosOKgz8IQ8JKI82POMmM7by2QJto+p7kY6llU+uXa5v+b4+ikDhVjfJb4?=
 =?us-ascii?Q?5dh6aMw2W3W9loTcasz0agjBmPyuyuZLZ5B9aYG5LNQ9oZxxUehrfT0WpQcJ?=
 =?us-ascii?Q?xYyrcDJnsMx/3Skj48Q0+AjJ8IMPJm00tiggstToILF7sd03Pgrwm9Tpc7W8?=
 =?us-ascii?Q?trQRzq/gHlKD/kkJB9qC6bb7SQY+sB2G0TaJXS+q7NdubfFvAcCZff+uMti6?=
 =?us-ascii?Q?xwFTnB7P3SKMxJ2oCSaWUQGj/YgdkfLtVl8Jm2ZGsRWAPHnNYeGQGLA0UxcJ?=
 =?us-ascii?Q?c2agsh6yFy5pyFvOPePJYsIh9VLmCb0yVKNWN/E/hcdlsTCZ9HQ1vaRMRYba?=
 =?us-ascii?Q?YSUx0EE8p9w1go6zbjEKxaKdZvxE7UIX4HTiZpu1biwSQiwFKogIhLqaki4n?=
 =?us-ascii?Q?l3He1e6hoP1FCDjJS/CWL/daqlcI2akV2O4xroKtm7vZEbvq2aJe6nEXSOLr?=
 =?us-ascii?Q?OZHenBKYtfwJarrSkWuCSFjOBzmnwUxjEy3Sqs7oermcCSiXOFN5k/AimCfz?=
 =?us-ascii?Q?xQoB2V6Ef3DxHVw8XgYaZ6gwJbojZwbe5QQsXLkaKWlvO5dHrWZelVfZxBaG?=
 =?us-ascii?Q?pZWNClczdklvBFTx3vUQlIUq7bMaSkwa9zpUOp1pDZuwWypw2iGCeoaZq67X?=
 =?us-ascii?Q?ycuNM5lpXfpenYC++N02YBD5Vd8cYFrKs8HNQpqePIAoX7ltZqFaU6lNcn9C?=
 =?us-ascii?Q?+Asga1mOUjFtcphw6Q1jWriF3Py77wHVRQKQo+GHna7NWGLfg7gIxcPytwI5?=
 =?us-ascii?Q?UJ/51/foGb4I6+qIN+wy8uenvfQM6bnb0NLihi+bEm49HhkkDYRjyrRAmmJO?=
 =?us-ascii?Q?2C5lSfry6XHKuKK+qH44Ork2BtClv+MIvu1FDD2s7mb1qU+OtU0Go8y4zOoF?=
 =?us-ascii?Q?NDQS+xECW0pL0d74IywNcaYtm9HY2DF/wzmU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9N1sgdwuHcqaBot8UZVO6VbP65h/zKXBoHkkGF1JElJ6jA4/H6yI0Xzn6eEh?=
 =?us-ascii?Q?vTUIRBmy2ruazkwDadVWp0yeaCEHufa697doHDfHSXRPyIyatCfjKURDs16S?=
 =?us-ascii?Q?S5Kt7myRXWbe2hhdqcKKMIHhEWI5N7ojm/VK6LbRMhyvxZluTA3I8UI12rl+?=
 =?us-ascii?Q?760+Da0FKsMpIuZi+Xykl07nWNUhYo4FnthkdYI273rLNawDGZwY9S0aet2s?=
 =?us-ascii?Q?OXO0C9GhLvuTYZpbUFZTlNxMIPRkorkY3C60K/QcmnYyuuLbN/2XkUyVa0FD?=
 =?us-ascii?Q?6XJiJzLKexQBpifpc3Tj6zY6RuwcAg9mm2NZf6E7GC9IZuHJiu2ina1GT8By?=
 =?us-ascii?Q?qEboQl3YHeGRmffvf/BBSfotTaFsmaA4k2HNFWGfS5DRtWiBmEk3tVP/1wlH?=
 =?us-ascii?Q?dmhrZjXLbqH4hQtPFxsbvebU/wDo+eG/q1HyODjdHN207wBQdU4xEpbBAjaf?=
 =?us-ascii?Q?urHWlqEqKopCvmSokpjtooXq26IApDUbSMV/E6bIM44Eo02RmiM0qtOIzmab?=
 =?us-ascii?Q?icJ2lM8682kSnWogfI4/4hrj8MMCkyZ38Qf8p3M6SfjbNNLzkGYHN4na/UoR?=
 =?us-ascii?Q?gGIreID7nHtOBp+rBTxDrVjc11nlJpVUFk+W+/2Bnog0J+ZFwyTjK1JNsOht?=
 =?us-ascii?Q?1O/E4KcPVu8Ad9+kMsdG5PbDjRee5U7V+u59BlJGw9pb4J8V+ob+63dQh6MQ?=
 =?us-ascii?Q?EADScvROeJ1UPZ2d04M3FPAZeZoYjIWbP2IEwUQ9efcKs09Q9mApubAHP1Ps?=
 =?us-ascii?Q?P1DgwgTV7lme4PHD9C4V4xDRz3Wb4geq2slwHVxVmPn+GZyjSJnx4jieAfYQ?=
 =?us-ascii?Q?aKD9wFSmMxdTobZZ3knynQUEFbGzgRK8dqcr2BOvnlLCYJ/lHB1sf+56OuDN?=
 =?us-ascii?Q?qH1Qk3X9gHemamBjwpz6OEqMQ5tVe2YHN77V/BfE6p12AJ3sFJRWpDO6R8pU?=
 =?us-ascii?Q?f09lxL+1V7wUxnuLqjWcp6ijbJBy5ARKdSA2Ljzk3gSaiAVOB06am3hq0CAC?=
 =?us-ascii?Q?91HFOUID60Sz4kNPbZrZRhawnSilfQiZVZR1n79VcrsIVgdpewpSjNOnX88D?=
 =?us-ascii?Q?yP9nZzqC+MXlaDqfMVMuXuKmej3D/mqTbMuQZIkYFQXioTr2ldBF4lBwJTvW?=
 =?us-ascii?Q?9yUzn67NkmW6bWYCmBKsngShIC0otkXcHOV9QeudboWTnOhOTsnbjiBSthLs?=
 =?us-ascii?Q?eZrkTjy2OIXFEq6ZY3vHMaI0sfEb4q1J9vSWJ9MdVyEyhTvDAKgOs8Wo0lQZ?=
 =?us-ascii?Q?P3m7/aHwdkDc897GtLmMP4D4myTfT5CuTbpQE64sFBDIN2dNrOxl5GRgFJKW?=
 =?us-ascii?Q?VQi+N8dUane8f8fsWQuLjqqNQ6934Pp5feic3cZ3/UUp1zMFrdyCzhYSBsER?=
 =?us-ascii?Q?7swxB8GJNy5BpAkB0CgMZ1wU9Pp6pWAauDgPWPJXYg7SwZL1Q7Rl+kS1/hP0?=
 =?us-ascii?Q?moJ0DCKwev4rNgibOROtawNNXEqv+JRsMkOpB+jpLjMcq+YH7U9gSKzjg5QX?=
 =?us-ascii?Q?DngY5vpPcOr+BLKpQqwU7H4mxFP8GRIJ66ReJ5qvstv0RhjMvQQjwJo5ecmc?=
 =?us-ascii?Q?RNUsR5TtMz1Kg24OmiDo68f5IsBn8p2Z56olmWPK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 937fb4fb-3b0e-4948-eea1-08de01d2dafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 16:43:46.1865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reENgTUzHgnr9jDiN4pSte+uIEvdewU5azrBMxuA2OeNK3Rzp5ObEZ19J8EThObGAmqLRijcwHlvgmxDQzzALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

> > > So, if ACPI says Q=3D387, that's the denominator we advertise.
> > >
> > > Does that sound right?
> > >
> >
> > Yes, it makes sense, the denominator is the "scale" in your example.
>
> Thanks for confirming that.
>
> > > Question: is this a global parameter, or per-CPU?
> > >
> >
> > It should be a global setting for all the MBA Register Blocks.
>
> That's good -- since resctrl resource controls are not per-CPU,
> exposing the exact hardware resolution won't work unless the value
> is scaled identically for all CPUs.

The RDT architecture spec says there is a separate MARC table that
describes each instance on an L3 cache.

So in theory there could be different "Q" values for each. I'm chatting
with the architects to point out that would be bad, and they shouldn't
build something that has different "Q" values on the same system.

-Tony

