Return-Path: <linux-kernel+bounces-584246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526FFA784F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 00:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781133AD390
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6E21770C;
	Tue,  1 Apr 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IM48V7mO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q+A4CBNx"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A451EF396
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547939; cv=fail; b=ArOInXds5u73QWFIhx1916eAcGtlc5HVyvUJJv6vJISlZhWpg3f1LyN52BluRrHU7a3L/jySWkOiOPgPRYnjYtwAn/EGr76uA57v6AaR2n1xTJ4kV/8V9cXzv6mipOxODGgLB3ZA8UfyGPfUx3t5Ld4hjs+Bs2BwhA9c/P86kvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547939; c=relaxed/simple;
	bh=c6IaoaB//udSbzdLSmjoR/uskXiHID/7Szo0Duxsi+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSOdYRhu46tKg4t3BNReja340UOCPLIRrG8Nsp5FKxyvd0FlluPNQ1NhsD94onhVTTHKwpoUonkqNPomVRrOs0JR7e2fuGu481uW1yLwdLAHE6QAfPt6idr5QEBGvp7fMj8gEi3fnHKqilWyJvRjlIqgHgZUcJGvFa2jHTIuKaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IM48V7mO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=q+A4CBNx; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743547937; x=1775083937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c6IaoaB//udSbzdLSmjoR/uskXiHID/7Szo0Duxsi+4=;
  b=IM48V7mOmnV7aQ+sRrZkPPLeB3VApdh51TWLcjXVA2z8we8dE/vyb+Fz
   ZGTnFgZKpw8/WOQ0088tHgJFpyM1mQTPBXxXPhJ3a8lYEpf9Wwp4/ISWJ
   T78kZTWClh99ijrdsLposYm6Z7LtWQzKr9d42oHsRzxTHye4txAljDmB9
   uPFEiQOC1z2a0/KgFe0J4KLcXL3g8Hl0mKe63n3s8bNSPkE319Lr/fqxB
   +4UaIezWCIf8GcZiiYnVCfXs2Jq6x+G8g+ehKrwsHCuABuEKVp9EJ9uBk
   94e81iRZwA+ZW5m5CdkvR+1ccq0PBwFOk5AsFrE9tolZdFcmJrtf8lKyh
   w==;
X-CSE-ConnectionGUID: +vcg6hzNS9aHrLknfnPFyA==
X-CSE-MsgGUID: UohW3IEPTzKIVJlzA3c8nw==
X-IronPort-AV: E=Sophos;i="6.14,294,1736784000"; 
   d="scan'208";a="67235740"
Received: from mail-westusazlp17013079.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.79])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 06:52:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeR8hkKxt1Ja/3smoYfBEDhs4+G1cSR4V9tmd6bRvQY6YgBFWCkddFOYAAtmavAehI75eTenIXkcETHa2uOV5DGjuSSNBsw5OO1+lr+PDzIdu1Zkq/0H7wDnCAOBJ1ZmESXS3XcMurvnbjpEAMpRwaj35GyCDdpB45kwDGd1k7TPtVJ2YzxUykCpBX/Ov8vXM2BuO/4LJO0BDhkHTClzn9u8tOCUAZs/TEz/d0FcuyKsas5srJIl8DyhvVA03hIOBP787HYH9tmfy2OKQXYscqErJnIZ4hZGZgoACTJHJqP5RODLdFQVNdiFti6MmQUSJBgQyDXFirSKc95hTsoDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI7sdOvqzMHAfneYQOUBoUjRGPWMRuAyZQ1PmovLgz8=;
 b=oVDzcT3C94DRAD6Q78GICAZYE0N3owzM+eM1ZGTd8Pei+rFcIYhs/TZeuWUgiUhrDWAXdfraWWM751g1qM6LnDyANK7qTIKFD10/mXMJitshnvzgVEwNMO8CDmjtGBa6KYVFDX55E7N9ekAzKEekvOmXs3Y+p1w5akFCaYZ/fcJflCRCl/VG9ZMt6nLco3znpdn4Xq/yq3GOYIcnQmmXVHDZfwvl3bS9Ot2gj5HhVNvTwibi4P46FV6dCcVOZeu8QovXE+M+tplCLbz/kMesw332aQMMNO7FoLnrWfDDnzezHsLQxMZdESG2RoPVb5veej/r4TS86/sj7UcSFj2Fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI7sdOvqzMHAfneYQOUBoUjRGPWMRuAyZQ1PmovLgz8=;
 b=q+A4CBNxUfbWit+bZOgK1PJJW0WPk58xOSKKgNqQBNoZJSamGb2ay3DMnMsWw+0XldiQ8VLIccYGH7Lvzh7vorEjEsDB0bwDQXqfQwqJO9Ekyprc3oJB+aUP0KI+dTovGpbciEDA2dRcxSMi/jKobEJzjPxbMan1fN8vYXM1ESQ=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by SJ0PR04MB8470.namprd04.prod.outlook.com (2603:10b6:a03:4d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 22:52:14 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 22:52:14 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Topic: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Index: AQHboCmElT3ixkj0uEiWsWJv1g7nM7OM286AgAJ/nZ+AABS5Zg==
Date: Tue, 1 Apr 2025 22:52:14 +0000
Message-ID:
 <MN2PR04MB68629F5634238CCB432DD9FDBCAC2@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com> <Z-pDY0aNYLgtiCUc@ryzen>
 <BY5PR04MB68491AD9C47CD7AB9B552098BCAC2@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To:
 <BY5PR04MB68491AD9C47CD7AB9B552098BCAC2@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|SJ0PR04MB8470:EE_
x-ms-office365-filtering-correlation-id: eaa4da1c-50e1-46bc-07bd-08dd716fd8b0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h3YZ1Co58DwYbiH2k2ANMEMJxilHRW5mHkXBfJUsSkl0r3r0H/YGNWrga/?=
 =?iso-8859-1?Q?GCNTVl9zS+y7KKZJLj+jZWFfdIl6+Av3PTfeKpoyFvpaYgUtMwkfnUjWrB?=
 =?iso-8859-1?Q?u+8fZgAO8JYrztjHy4ORyGZ9oi7W+nOYuGn2trSlNjxQv2sMvPRVETO7Pm?=
 =?iso-8859-1?Q?gTENDPxBKTsS/aFTsFj7FqYelrVGkfOQJc3ZvAuECJMNB6hj9qhfIAEC2Y?=
 =?iso-8859-1?Q?8xNkCBid054JUABUT+xm/9hn6eaxoGZQC5iOw26vMuOa5IgNM0qdC9Sl9W?=
 =?iso-8859-1?Q?7yepKZMpL5uTEmnVeNfQgOYGNXw2/kcqgjmGq1ZT74HhpDwRH81kG+U5+o?=
 =?iso-8859-1?Q?2b5EelOr6IJchl2WD68upUfe106Y/ZzIBYOSGoBYG7WhQih7AjnfP7gR0x?=
 =?iso-8859-1?Q?1563Yir2V59c3qqqzGjymZSyet4ZZD0qkmwT1Dttw994CcY/TehFgOCQsZ?=
 =?iso-8859-1?Q?8mKcOAPhf+G9JkIJIIrvCNPXt/ae5exD8G75wKgV1qxJnvMUeDdjB9P09W?=
 =?iso-8859-1?Q?dNwE+FteuI243Wdz8E/qz3d6cmX1o6vX0bBZqHN51jxBDFuMJttNNljsEZ?=
 =?iso-8859-1?Q?IlmwZQq+5tbhfglXuvmbwpkf8J2PleIGCHKf767XNwWQbD6wzAq8RNrXsN?=
 =?iso-8859-1?Q?VvX1NIZcRp+Ndi/tTkAwyBqrAnq6+CaarQkTznsDwTovRC05B1OK8Wu9OR?=
 =?iso-8859-1?Q?GmyRlUW/pExMQ7jQph3tLX+Gcd/dOWkdbLvnUpAj2fDHqPyVo3vQcBt7wp?=
 =?iso-8859-1?Q?edCZ4vQWhvmYuFD0SMi1Zh2pasrpCH+1gRZQfFistnpN6xbh3ZYIOwAfy7?=
 =?iso-8859-1?Q?7isCnxk9zFV1dhNRvSfJAoWf0qqyrK/FyVWUGvUP2inUVoEVTjShBvNtFo?=
 =?iso-8859-1?Q?4eqLmEMLmZxdasvHj4LMSePJtz0DQUhGYsB0iHkeB/Oedv6/hyWvtEXgfn?=
 =?iso-8859-1?Q?2V3b8i/9Lo9Id2ea81HDrYL1bXMtIfVo5GAL6L2l4Q4oGrt6pTcGghH80M?=
 =?iso-8859-1?Q?Wu1p/HBPto0WQDNE5jLvgwIA1/M9JgFrbVE8MvzP7ELVMLgCftnYW2wn6c?=
 =?iso-8859-1?Q?/mhlRinDaLYgkSDf+DmR0Trf8ORh/QEaagD0i8YiU7kLcgSmbyT78w1aZU?=
 =?iso-8859-1?Q?q7YkNL1b9OvjzFuylOu2vHVIAvbj7rqJ4RF9JQL3A8jWXXLIBeL7jc0+tY?=
 =?iso-8859-1?Q?+JFgxVjTgMP7IGuZkxPUfmZR7ohLUr0Gcup9hum+WNfgpUt2w1yMk9ybUY?=
 =?iso-8859-1?Q?EHu/oHY6jZRzRFVgbXqUX5fKgqdBnNYdpmDI9s9ndUqrnaFQSekPIK5ObA?=
 =?iso-8859-1?Q?o0cZCChu8koPE5cAKxVOSz4xEJoHJxmIyTFtyEEUQQHk4tsKm4zz5bLwm5?=
 =?iso-8859-1?Q?q9OBIDUoS7YWPxw+dQ/4zZ1DAewtrmXk1EGMOI+zcONA8EGaS6W6ipwCEA?=
 =?iso-8859-1?Q?ZGtNEuZh6tg4IGAJSR8ajuC+IJE6rKiDRk7noyVVozSWF1DUsTIWTkIuxe?=
 =?iso-8859-1?Q?VmeVvKrRuLPWxol82i3Cq4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?g2w0VOs/JfehQvZRMxZAWbTAspEKbVz+cyT3JJBbIX8t7BXc8QDp1gdy7Z?=
 =?iso-8859-1?Q?WRSsjh5OikQTpIP4oVHagnKJovT6cYqJaVMlU0oq4EYk+rPW0F1wbBo1sF?=
 =?iso-8859-1?Q?fUXZxaEiM9OtkwKNv/KJaXHC1NrZ1OjOS34qyMPnD0sba0ZfavrFPmnY6a?=
 =?iso-8859-1?Q?Qt22ZJVwfobfbieAJcjcLRuqEN8ZXGWNN5yJlDCazFDeBAJk7snGWLHyZ/?=
 =?iso-8859-1?Q?Ue/AP8Fw7o91Rs9UJ9EpkSXHkN4ckyOzUtLMewIFk3n+oUlxzryDCAVHrL?=
 =?iso-8859-1?Q?hcsGk6E059+f0m2aCR3ftGJ1bQcbK0qdsofLRONwfOOaHSnC4f9hT9n04V?=
 =?iso-8859-1?Q?GwWM3Sm0yxP6CgxjUsFkGONijUO/ua2IN6SdcMUA+AlfQ09Rz0eEox4xzG?=
 =?iso-8859-1?Q?Cqmu4lZXnrpQtenuG8raPBTNx47rmju65IJvEsyU/DkXOqq9XregaWJRRq?=
 =?iso-8859-1?Q?dtoLQz4SHEx5hgQX1WwSBWWmWdwBiXEKn9yY8LzgBSUm3mq25+NMBb96xa?=
 =?iso-8859-1?Q?kVBbGUYD6fJSXGFXatuxOM54wqq1TfyyPe34GgJpM0jZ3HwCTZPFOdpVZo?=
 =?iso-8859-1?Q?hhj637iyDC6uZNUy35Xbjj3VYTqZC3Vv116U5WsZrkzafP4ggtEQHt5btq?=
 =?iso-8859-1?Q?lBqwuiTh69GmiSdiu4uXVzYfjNS86NuhYtu7lEolyMHQCAYi1sOTZCdJfu?=
 =?iso-8859-1?Q?S9S3f02gYpF8NpC7ozybYRKO7EUdLQB8lx2QRTQix4i/BJ+HW4yZYO/T0i?=
 =?iso-8859-1?Q?8aUPLb2A98IyNQsz9S4VQ6Y6+N2FhVy7zPwJPhKnHOHE5qXCfy6r1y8gpx?=
 =?iso-8859-1?Q?lpk+T5c+DDTLAjT+XAKi28V+7BTGEtFBlqU9r6bQ0sz2h1xM1/VEFCYp2C?=
 =?iso-8859-1?Q?xuQMABbWOeq9KRCJXVjqWjj2pfAtBclV7CrbvWfSPupom9nelJnQ/gGxKo?=
 =?iso-8859-1?Q?i3ZWSENlXzKoOZIJGy8QnH/l//v9OHfOba6Lb1u/q0xcGBas2cC3eloAPU?=
 =?iso-8859-1?Q?GW3HlYI1N1BPlMz37hR8W2NBlosLW9E4AKgJPz+HvjqcaWTTNiVkI+AzsC?=
 =?iso-8859-1?Q?rxOsrEWa7liOLU+uB6mkFOrciCRsmp37cs2beIlRmF4CR6K/gL2knOl8ZV?=
 =?iso-8859-1?Q?IhSY4pba89OvH6FqiiaS0ds0/ukvowq5U2zoYOXu8IXVnd2et4bfQV4cAl?=
 =?iso-8859-1?Q?dwKJCN3RQFXjx8qoC4kGk1dj6Zsy1PTlSHuFcGnyWIPM7kZ1/4R2vtBHox?=
 =?iso-8859-1?Q?6xLmyhbqT6+FSrlmtXvWaRfzCamrH+0aiLtejZvKZnXtqSJo11580kFj0B?=
 =?iso-8859-1?Q?4fPKEgHCHZta9qZ1nZky8wzqXl1LR/mqSJO8OmvvaQzKKyLxthcU1D5WbU?=
 =?iso-8859-1?Q?2InUWPByP5EPGKCi0JwDJd9ZGJsfpekrNiJziZOW1cXRyIzu8ypHZLyBvY?=
 =?iso-8859-1?Q?REyZUv0hxATjMVj1Jx4KohmZ0dSsMP+zt1SXHgqU4eFIS/Oi8yHbzwDq7d?=
 =?iso-8859-1?Q?79yRk92KXiQnZoPePz6scwLbeIEWRmpWljs/6PCKo33i7vf/DkJuV8SBqe?=
 =?iso-8859-1?Q?x9323Ud2el98i/IJ2Ua4IAzioT/SyDXZZ2/gNF1JHGEAodTqEC+NjoRVGF?=
 =?iso-8859-1?Q?fickurk7jqsk1jHwU+6OLF77oaDo5dvUZC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rF8V1ARjhMG9V7ryCFkppnXEG3DhTwPiJUYwuMCSWVlh2u84eGXaFoun/tKd/Nn+fFZuHm4DqRCO4AMqlpxM5dM0rZOrAW3pL765G7stEX/8Rn8YYL7RUHOminKowXc6x4KzMmjLKLDxhAHN298JZUr41II+DmJ5i7+6SthBSyGveRksU+AjJshikb8diEJriXVRfhUxk62laDLBDa1PkAivIPBLR8dCGxLEJRHbot2mrP7sqLZnnQllT2emnh/zIfffU4fsvx/lrCPlJxsKeQeDqTfMGRWGS2flBBwBeY7dY4gMxElgrHZwntrchhPMhgcStKr4FPGR7+KXKwli++bUEPQ7EcPWiEXurj1XHWbVnu//Hs71wRAVQdbzF9RhmwkMwKP+G+nxsaUWgs5OsqOyIbnmoBofqgNIF/Nx1jCyzTc5qCgTiv9RaRwnva89WnzahDsubjtXJBxhzUr9o2dhf6ctmRdytS23aye8d6lCcEyO7Vf3JQ5hznYHyMrYPCPrfQ5e08NMrJgntQjbPI1CHmq7HDoHbVoMr0ba3YmTY4L6QP998z23irLf5jRwMDT0f8EbDxVBDyWCaiGzAHFDLLmkY/zE5cfuRHULbIJ15MB052UQe+xNczWZqwJx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa4da1c-50e1-46bc-07bd-08dd716fd8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 22:52:14.6620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aP2mPKl+6pndnbeELNdnYvMbwYqzLOEuBeaC2/vbJA9Dqz0YnlFzyPKl0HTPU54ai//Hzlf2hkbNSeKJSrPVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8470

Hi Niklas,=0A=
=0A=
On 2025/03/31 00:25, Niklas Cassel wrote:=0A=
=0A=
>Like Damien said,=0A=
>=0A=
>> Added capability to connect to an administrative controller by=0A=
>> preventing ioq creation for admin-controllers.=0A=
>=0A=
>patch 2/4,=0A=
>I think I deserve:=0A=
>Suggested-by: Niklas Cassel <cassel@kernel.org>=0A=
>=0A=
>on this patch.=0A=
You sure do. I wasn't aware of this designation. I'll add it. Thanks for=0A=
all your help.=0A=
=0A=
=0A=
>> * Renamed nvme_discovery_ctrl() to nvmf_discovery_ctrl() as discovery is=
=0A=
>>   more relevant to fabrics=0A=
>=0A=
>patch 1/4, you need to move the function, but can keep the name.=0A=
Like I replied to Damien, I wasn't able to easily move these to host/nvme.h=
=0A=
so they're in core.c.=0A=
=0A=
I'll separate into patches as you suggested.=0A=
=0A=
Thanks,=0A=
Kamaljit=0A=

