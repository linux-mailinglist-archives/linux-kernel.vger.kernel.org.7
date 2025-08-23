Return-Path: <linux-kernel+bounces-783043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684BB328A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C437BB16F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583A258CDA;
	Sat, 23 Aug 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gretWOKM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B4257AF4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953230; cv=fail; b=DJxnkYieNQfTUOLwmvQaFr31dmxKLI3BsAIiYnlvqXLcKAjR02+2D+QX+JiJmi/a25+152XkwYGQmP8+hRDSTzUFXbHEVB70ReLAy1pT3J6OMgsG0BUOEIf5aQwNWEwTpK9/d02jRST/JkU+n5BCvoUTBqVTn1Iw0rpmzcF0Vok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953230; c=relaxed/simple;
	bh=5orzmYMArOKiRGpOZODmi1Z3gbT91dnJB5Oct0nnBXE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtT+5FPxQszQOaiJvvz03peV3lV2s+U30CheyId/2WvE5lb783Md8C+/nFtzbtvfVRLXShn5oSRxWF1P+/EbE5P0EUd+RAjqp1RftMp+Q1UwzTgUnO/mPfBXALapv4be/Xbj4FSvfw7VD3YlCSHriGyN18PUcQ7LyVIm4KngQtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gretWOKM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755953229; x=1787489229;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5orzmYMArOKiRGpOZODmi1Z3gbT91dnJB5Oct0nnBXE=;
  b=gretWOKMOwLYFBX9SpLHOXiG3bHutvufi9h41ekSG0pFQCR99zE+AElX
   R1qphYzCvjcBixS7ssT1yYB3CbH2Xrrue7JQ7di7qUnQSt2y3p7p27Pfb
   3+YIU/KcYy1Y5n8Bijggqz7oGMfG8XSyTKBn294wROGsohhG2tebURQqC
   qw4ACGXSTk9M2SIHi3GwbocUrJMO+Ts2Ph6ee9gnb8gZoT8rXR5Igoc2T
   WDWfTRwXjGI4+u2pmaiHV+soGE2LPwwi6Srl+1wtRzpUTaLdp416l/FSI
   R63eHJG23wWEKlvxrsgbaVTQ/+tSxCef4XE3DdAL4l9o+H0YznXA0SL4y
   A==;
X-CSE-ConnectionGUID: pCeUrkCNQZmZU5gIXj3zkA==
X-CSE-MsgGUID: bvMN5D97SAaI2PgEAj2V6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68941310"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68941310"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 05:47:08 -0700
X-CSE-ConnectionGUID: bVzkK/0YTRSqQbt5D4B/NQ==
X-CSE-MsgGUID: d4Fmm0EXRESIcXWM4jrPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169313031"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 05:47:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 23 Aug 2025 05:47:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 23 Aug 2025 05:47:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 23 Aug 2025 05:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7jaBBb7zb7fTgc+orJjLw4d2n2Bxk2DiZMAUXKktFqPHGLUBCYnyOJdqJkd4CmnDIweHrp/o362WEApYGdUNZs+tbDONSVD/YNJvnVA2zJctgcxzB0dYW+7gnAxoFKUvdEtFIMoLZtq4ohFUFs29SEay1/c1aHUPAA6Gsp6pQRpzlkWGqQYx8d+aVRAO/sUTqPdcMzG9Ve8hNK6BqnrfqAqQU0OVN1g1B1hJeXtrDicPUV9wZZDxBWJE4CLlZdvkZtkafMGov8AdA+E9v5LUP9jrKRPl3Xh+Vv7+fNK0Cb4CC/CyGG+MDmoxAJd0NBgs5xpyb/K9yOKbLbsLbRUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL6i0g2FkzyArL3IwaGNr5o6VQinSv6T9UbtwyDif3s=;
 b=bctngwl6jOA0Hmn/M+NK4harGakkwSCyp2ntMb3i+H1Gm87ysRfpFbuA0wLoU6WkrimJcQW4OmcvzE7GA9PK3BK7Ddtb5ePyvwHVJDY4oSOmubGkYWMM2PlIMDszL+PwNC6UkQy0Qdr9d+dKXNZyw5in0U8T4Wd2gKvaLE/kZcbLYg9h1S7sNWGJuGge155ugOzF+5Vgp74aZ3PGVwM/DeRZBRirnIBbSVgqNBT6xIVra3lb/Fd2VT/EeKd1Bo3VW2V8TyN5wmf98IH9pIfjcNBuNCvDe3FS/jXIYw1+JU0tHhISzptxcl6dN82LUPN/9Rf/Um8UZsGJsJPXmONiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f13) by MW4PR11MB6958.namprd11.prod.outlook.com
 (2603:10b6:303:229::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 12:47:05 +0000
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::7aab:2a1f:f728:eb01]) by DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::7aab:2a1f:f728:eb01%6]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 12:47:05 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance
 control capability
Thread-Topic: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance
 control capability
Thread-Index: AQHcFCfgko8NgNwlVkGoJILZvjU6V7RwL3iQ
Date: Sat, 23 Aug 2025 12:47:04 +0000
Message-ID: <DM3PPF208195D8D635C72DC9769044D0850E33CA@DM3PPF208195D8D.namprd11.prod.outlook.com>
References: <20250823121647.275834-1-aaron.ma@canonical.com>
In-Reply-To: <20250823121647.275834-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF208195D8D:EE_|MW4PR11MB6958:EE_
x-ms-office365-filtering-correlation-id: ca21c8ca-9439-4156-436c-08dde24329d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?KESRAbtCVAXlnPBIFrvd1dUnMD6S4WMyI8oRpLj7q862WJBaHxaBFMP+orHs?=
 =?us-ascii?Q?l4sxfR7bnwReoIjuG6DeQI2ZPu9QjsD/koQtswz6vMr/YYxRM5QHv801Q9aS?=
 =?us-ascii?Q?MfdBpAqPEIYke7AjDkl5LyVSvQSbd+arZGctFa66HyjRJXW0seQT57ts70cR?=
 =?us-ascii?Q?sFW0dFs5x9oJG4NomcPfMpkyTp+S+JwcVTWtBb4NRWn2XiJ9ur5L5vQ3e+Fm?=
 =?us-ascii?Q?bCtpveG4swLw5hueuGJbD1LuXcEgZhMJIvaHvjbBGW8u89rmXP+kCGyqM413?=
 =?us-ascii?Q?/Wb63k5WLthyVr7Lf2AfKabXvxGDaIjzqHrWB7igWXnQxJyn9ddxy4gIMfPf?=
 =?us-ascii?Q?emFiTVC4322nZksZoLWwMwAopznm3pDUmayWvZDGLafNxPLXmhkLpcFdV15w?=
 =?us-ascii?Q?c0Qtlc+4CMCkzm71uN35CECNecFtvWd/CVuqRzSAFkjDQ0oMBx5ZICGaWMzF?=
 =?us-ascii?Q?uQNoWpjgSGaoQzkaEOdCqN4eRV2eTM+zbwbGKpnHuYgJy0uT6fh5M9VRblun?=
 =?us-ascii?Q?7gKCx1xRfkWiTB046dJZ7zMgogVSIB/yOfG1Xl1NIpFrFeZQlO5HCjp6FtcJ?=
 =?us-ascii?Q?pjKJjobrc5E6vnSUXeRE3jds9fPuZqdapRhwt5bwqhtkCYFmPwg7zCHeVcgf?=
 =?us-ascii?Q?ZElFs/WppC5PYkDKrn+fhwYQ7CaPgGeJzbefgHPSyBrvq5zxeTToGu/KvJcf?=
 =?us-ascii?Q?vBJeT4Cvd4JC3l+qNd1S8+JEIy3gbl4IFsR39Pw4+FlGWdIb3Lv/rNj5JnDK?=
 =?us-ascii?Q?6rRvEwdc5iDTJOuAlK30ZUhVvQ3JR4OiE35sOYy28OgeqgWRImDjYdxZjHAp?=
 =?us-ascii?Q?OFRNwsw0Fu0yqTsFMc+6K3lvhb+qu/3vTargXZn43IDfO6X4ZYOzGmpLP3YV?=
 =?us-ascii?Q?PL3pPWh4zEz3wG1ElmNcAo/oz1n6AyuIoQhVVwTPG4a+tkM09yv4t5GbpLoX?=
 =?us-ascii?Q?m58NbAUSwRCZ5+tNo8jCCFZa2ZoydQNSm8OMkPaCA/lXhUs1jk3+Q9NHcEH3?=
 =?us-ascii?Q?mOsyHhlrD0oS8BmhIbE3+243ImK9LyC3YC+uSe2uS2B0CT4QeoHk1gr1bTvK?=
 =?us-ascii?Q?LIRI7kgrlRNQ7YyjRmE/U2V16agK0GsExsAvEAppvkHo1Y5s98NuRhWe8eie?=
 =?us-ascii?Q?ZmVrRFeLCH8FeZSMyg9flHkY/mdI8QcBcDL5ilQ/Vi78cr6jj/fmMEp9oksr?=
 =?us-ascii?Q?ORfP3hDIOa60+7VRJFf78qVcYhtfjGLxTlzs11UQUy+UyASfRmqoZ4YHxQX7?=
 =?us-ascii?Q?TXwfIDZlnZqRsh8ICRaU1ynlS3IOPk8dncRKSUYdC9ldNXPxo6aJS56b4a3K?=
 =?us-ascii?Q?R2cy8J+Lsqo3HP8nLOD4TxSMLNStV1nLRi3tk/Qq39dbzCtiGQuZSY9MU+Jo?=
 =?us-ascii?Q?LJgCbXNgBEwOj4Sd5KrMW3CNEDcjfFxGu9aAmXkl2FhvBTWVbbqQudygRtwU?=
 =?us-ascii?Q?OG7Om+Ut3wfXjPzrn2p2zsk6/xF+mHwehvtkAbwwn96nB3xch9dqM5aMa6V+?=
 =?us-ascii?Q?E5BTGaNL9XnhsBI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF208195D8D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dg7pPHjFUfEh8mx1dNZxUu7hNDgT91MuneVc+JGcEQTR8C8i+e6mV2Hp/b5X?=
 =?us-ascii?Q?qMhYgI9O4Et+BhmiroZmZ57Xq053tf6leWjUvEtwzvBuCmNHhy7vC8UvAVD3?=
 =?us-ascii?Q?3IkYFUVTB5ESrkiQHeeX6tOd29DKBK5pKX0wfGcokreSRq6pwLjuKQ/7Y2H5?=
 =?us-ascii?Q?gw0LRs/5zp/u/5GsrLsx1aVM0G/79zxT3i4lzqOwRlTpO7+Agwhhh0BtM3AZ?=
 =?us-ascii?Q?W7wyoS/Vj/y1gY3h38ZvXLbXI/ukD1ejAXCJFsS29lpk8oP9keVHmW5eigp8?=
 =?us-ascii?Q?qQGE59BdMUTDBZvorZ34Kx56uOetYZtyHkeb1DuhQsDz7tZxkFv+fi1CF+E7?=
 =?us-ascii?Q?+JcFQS/mJMLP7SsKDndw1utYMyI2SRpVZBVsSh0wO5V16r3rXCC0yPmsiT86?=
 =?us-ascii?Q?2Qq4bp7QFbBxS0XsX+6psNh6dW7+wfWuBB+mRadyotYw7PN7Ba8gwbd78xip?=
 =?us-ascii?Q?6XbHVVFMVRDgpctil/45hEaYQ0wCaimcjFb8lDaWDa7VmWAS4FsDHTtVja6f?=
 =?us-ascii?Q?lyhzTWBZFbwLraGWgK7nICeZqVUInCHZPa4a/ETA8vIR9Wwjbql622HSRIfD?=
 =?us-ascii?Q?r1nGRCLtsDsUX/lSXD2ZNNSpww/Q04L9N6yAsIq+hKDQ81Of0VmCuwkqi2mu?=
 =?us-ascii?Q?1dGd+NFq+nOxZMFJUJCJQ9s5WfUnrRrtHgcxkm6KYCr274u93QIjTB/puQ59?=
 =?us-ascii?Q?gxa8CEBtP4DauZ8+aPSHYNfLUn/hd29mVD/hVjmG29xzMZGfIMPSS+/x2DLa?=
 =?us-ascii?Q?qpWO8fnTqowot+CmLRYNl9dbdLg2j3nUrK4hk/t07dEqZ0KU8fNEhN7N0sB5?=
 =?us-ascii?Q?VHAsXP8VPDekJJD2TtXqcRWFT55uRVqnpYrdGEFY5LLSSmJ54xvmDdX0KJcP?=
 =?us-ascii?Q?FdmNqzNqN+emF/PNRmAuEJQGK5zgJW+AUxETiQjabqBbQoiaJ4MazZNF0dRB?=
 =?us-ascii?Q?fMlKPontjpq0iyoTi5G6H4ZDYUDYli/RtXQJzhorvjTXJflT61pdcy7TqNph?=
 =?us-ascii?Q?IFsgY1WHyiVO8o0JHlmOXuUjnAwRdj7t2GDVOV+jFuoGzU2x6xB440ztlVzO?=
 =?us-ascii?Q?zdzjzXsuMiEuwYqPm4STBAqwRTvHZs4JRrsvoRjOHKacCfBlUkYt66fpQoYZ?=
 =?us-ascii?Q?tUTWlP9IrMqiTT+BOF8tMy62QYr9wYOPtUDc0TIb1pMgYAg8yrDfX93vpXFk?=
 =?us-ascii?Q?Luo1kG7JmXxSQsi38Ip21gAzaDC7fTmnMPFZbJCFNYmTnE/ObaBHbXPs6RqC?=
 =?us-ascii?Q?hDce/Y2SPT+6B9LjrxXOyeDHVsab1T0eiTGp0Tjf0Wd3Ns8Mb4hK5Nhw44ge?=
 =?us-ascii?Q?RZwiX5S3VBqt+7wbBnkLQyY+OXKv/zvOt+B/iL3inaJrEoQLDfI2tWNYRTjC?=
 =?us-ascii?Q?uDquRJhpSP2US1VuLQWNVn5igEYx+f03R5zzDEUoqtz7CTDVzcMEjHvTFNZi?=
 =?us-ascii?Q?6/x3A8Zfl94JeU6dOa51E4ydaS7VUFDbSljCfrC38/ptdKttzSeBLJI2mUIR?=
 =?us-ascii?Q?1Mt2e8+qP8sV+8V8/qThONK4Cwn45M8dJXBtIIZjgSOS43deG26w0SOScJtk?=
 =?us-ascii?Q?/nfzeKNr4yMDYK819X97x86tXDgAEi5lPo+kALZI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF208195D8D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca21c8ca-9439-4156-436c-08dde24329d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 12:47:04.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eh6xXjJadsuP+8gdU5yUm1yepFV87uMU/XD4nyoYM0bnxhpY4OHVcif+ffki1QncG1FhRC7Htm9csQATpP8fAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

> Subject: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance
> control capability
>=20
> The VESA AUX backlight failed to be enabled becaused luminance_set is fal=
se
> always.
> Fix it by using luminance support control capabitliy.
>=20
> Fixes: e13af5166a359 ("drm/i915/backlight: Use drm helper to initialize e=
dp
> backlight")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 41228478b21c7..0a3a3f6a5f9d8 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -546,7 +546,7 @@ static int intel_dp_aux_vesa_setup_backlight(struct
> intel_connector *connector,
>  				     luminance_range->max_luminance,
>  				     panel->vbt.backlight.pwm_freq_hz,
>  				     intel_dp->edp_dpcd, &current_level,
> &current_mode,
> -				     false);
> +				     panel-
> >backlight.edp.vesa.luminance_control_support);
>  	if (ret < 0)
>  		return ret;
>=20
> --
> 2.43.0


