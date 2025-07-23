Return-Path: <linux-kernel+bounces-743077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243EDB0FA46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F346169994
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A0822B8B6;
	Wed, 23 Jul 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EJdUs3Of";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tnMu1oHc"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0281E7C38
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295243; cv=fail; b=mUuTizoqFHYQ7emR+xwc5+FLBwbRwNussTu2lDgWFqOHERtPgo4400Fe9qTljaPLz1rDhBlldSWGWAhv7J8Ieq//soBheXZvJe9TPHj12wNtSn8/fG+rsqJPI+v/U3FKHhOx/tXPuymbLJOzmspzN59OqS6brqpqLuxFsE54v6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295243; c=relaxed/simple;
	bh=ZJyk9wdsWxAKwQtpypmq9SmEtVINCSZJBD3NT2V7NSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cW1MAW274x7MFBMzYjRWxAqTY/Mtt7HUZaO0EGmfCmnNTasHozZz2tBLxUXj9HjHx85b0F/knKaaudscntCF38nEIWbVy2S1nxoCJur7b9vRosc++z/Sp2vT+yl/MVa8+BETfEKPlnUe3DQ6fatp0/BP5U4GOWcnoW24T5ssgbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EJdUs3Of; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tnMu1oHc; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753295241; x=1784831241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZJyk9wdsWxAKwQtpypmq9SmEtVINCSZJBD3NT2V7NSc=;
  b=EJdUs3OfNwCnzfaVKsJz9NoC30GK6LMVAaal0Q0ar/sYRCzaW1/lkv4U
   1lww9Q/+iaVh1iOg47ZQYzrX/GUC/e9uUubq9eupybmp4QLA4pzOY6KvZ
   32uJ6IUF1Oh7Rq8QkaCa5HrFWFqi4E8Jd9rDx7Cgd6N80jMRsPKc6W+dd
   4QO3uAMThs/m9SSlk+/bqi/5pAztI6qxS8Lvg5nx7qh6tRo6Ank3/rpx6
   Hzur6WjPuMkHYEunjg8fKi0sCNnDa7xm7p3SqLm+tUdUjddXQdw4rhFPS
   tqzgn/MtaO7KsMeDJCITFdAjNtobnzR1SHBCgqLPqalZlLpwRIvAiyWHL
   A==;
X-CSE-ConnectionGUID: 7ycfZCuoSUCwxIDpkZVBiQ==
X-CSE-MsgGUID: 9tbbCeBoTv2ghVltCv8yOg==
X-IronPort-AV: E=Sophos;i="6.16,335,1744041600"; 
   d="scan'208";a="101488662"
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.42])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2025 02:27:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/sTeAamvD7sV78+kLxOJq7UF8/eP2t9yi4ceijjeqqFrQ3xne3PwMH8BSlg0Jv9G9p6cxZvJCdhTDtP8wUtX72ZwYlOHwAlmVntwRVtKpzgnyFzfx8+FgEbfEsp7wDK26CM0ER2iYUDR9zY1ttycGQBey38OjY0BF2+Bl6+fajjaBKlIr0h5SvZ3kw0sPz3TIa4epq4JBLXvuKi6mQ2mmZ7qMLN9xMGgjZJNs6ZA3Gc63xPTu3S1iVSz7UYIUd5Iu20jMl0XG+sHMn+BWVcsQwBTdM9jzhy8+BhZBi5z6Vv/Dw4cSkHp6NFJluxmcqj/pIEA9a5/7ZQYfKYEptF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJyk9wdsWxAKwQtpypmq9SmEtVINCSZJBD3NT2V7NSc=;
 b=CKGAJMjQpzclY8iHw9FuHc6evsM9tQcoNsNZospG/gr0r7c0jx44t+Bk8HkB2zk09xTj5ud9js1PYNwG0otgNUo2DqXehaoVJy/8E86ru0Af/v38vOi/VK8lq9EaUPsFjK07+Bn2nV7DJbH4y/64Is1Obn2SKEf3uBmuquZPZrOIt8FCjuVoSwwWTRGJ3+lIBCGq0V6W+mikoWLluIKU/9gX/xzdvAxpLP80yejn3P3lHSR0Tr3dv29J7VynsZxPWdj4t20Tx8tEukWHBIy49V8mJvZIXk9vH8q3DrdNUQUASbeL6EXZTRt1m+6TXmfEbQqn1KF03+WQoPCzaT/0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJyk9wdsWxAKwQtpypmq9SmEtVINCSZJBD3NT2V7NSc=;
 b=tnMu1oHcO7xqYx0QT/1I9Jq2QT7Z+FwQ7+LMsJ7vwtwzizvfxPbYYrzikn6g1lu6aSaef4e9yz5Vk+6EqPZhqUw4Gs8DYUWkD5zgtnUcli6fpnCvirhEplO+MsdeW3PyvLLOVLRy5alZdfXadLT0osuTIukWcv22GGwWAunl0G8=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by DM6PR04MB6509.namprd04.prod.outlook.com (2603:10b6:5:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:27:12 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:27:11 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: hch <hch@lst.de>
CC: hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Topic: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Index: AQHb+mYXMAEuLxyp1ESYRJA9jnnQSrQ9r1+AgAChYwqAAOufAIAAzOY2
Date: Wed, 23 Jul 2025 18:27:11 +0000
Message-ID:
 <BY5PR04MB684919E8FED440576C3A52F4BC5FA@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
 <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
 <20250722063015.GC15013@lst.de>
 <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <20250723061112.GB18943@lst.de>
In-Reply-To: <20250723061112.GB18943@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|DM6PR04MB6509:EE_
x-ms-office365-filtering-correlation-id: 3544dd9b-d6f5-4be9-6f77-08ddca168a1f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xpLVkdnrnwBE9ulTDJssmdOrXkQ3hfxRbETWOobY88cLSqT2uS+MzNO/Gh?=
 =?iso-8859-1?Q?Yl7RsuNVKIKji2WpzqMNegWoTuSDJX6o03+t3OFcTQ4mv4gRptbhd8KNPG?=
 =?iso-8859-1?Q?y7yDGsDeGSacRRxvLllwOYLHKUCWSOxHA8IwQ+QV7JsLZrxYOBCY59d7UL?=
 =?iso-8859-1?Q?4lJqBFwon80TyeFUGG7+npb4wFB7G5AjpLvhNO9VlhjUTy27VxCMGl/xJg?=
 =?iso-8859-1?Q?zpGJZ6QFX8fFkNQ8ArnF242P+7nWm7yqO43bl1cAxRPH4gWhka4MNtvE6I?=
 =?iso-8859-1?Q?jgZZqG41ZGGnFpBmPQ43QVpQ2JUWtMOUvSh102Eki/dzi3TuXp2OfKPT24?=
 =?iso-8859-1?Q?gDD+V8lRUJvYtr9iyAtsfwuwRgokQNsiJInWCGOzM65FSU8gYfhSCaYbl7?=
 =?iso-8859-1?Q?mSpTGoha5SuvNyFq1CJqoJ/hLlJpJ/nR9lSUH45+Kl5cZWF6i25jqmX0p5?=
 =?iso-8859-1?Q?Y7xhZO73lRoW3jJJFnptCd9rF8umSwsvb/rrhXXHESmDhh2Q3v1qGpd0oh?=
 =?iso-8859-1?Q?6elyg+ZxPxDWqUxr0hW9ixHfgNMnbbK59Co1tKkOBVK6F0BdzRYLiiIed4?=
 =?iso-8859-1?Q?WceAGl1cxAJh9L7FOODZdVyhmMSOJEFVLKfKXbpb+GOQ0I/lSe+QsdyUV+?=
 =?iso-8859-1?Q?ZTPRtrWWarE6tzuP2o005/9lMbEdD12upbMKuukmtT89kpU4PxXVy1Zj5O?=
 =?iso-8859-1?Q?zdYa7M28E2+TFyNJNoDIW3MR+Q8K4eEh7022bxzk7JcbITli5KbD4WMdqj?=
 =?iso-8859-1?Q?/n8rCSrQtMCiMlGuBQ7ph+xyh93s4o4tYGiYClPrMGfNS9v+xLW4+AOcC2?=
 =?iso-8859-1?Q?TIXZZXTaGDvz6Q2eiUp/6r7odYdvXSArmzL/w6rpIYI2/wTSYdW/pdWzyr?=
 =?iso-8859-1?Q?boIwqYBLJF5Quto+emNcWhWfciHYMOdDTSDsRexnTvUkhk2yhhoKsNZCTP?=
 =?iso-8859-1?Q?Ujei8OkK3Xxsq1VuSFGmX6+K4pWekio0eRoo/XiLtviAFtzZ0+zi4OyHiN?=
 =?iso-8859-1?Q?/EG5fjQyfKt8lZk5N/5Cc3b+iLPm0aKjCfSOYWm4Wwb0w4LF8aAIh/80RO?=
 =?iso-8859-1?Q?Reu38ULhXKxQQYWEXK4zy2tH8F/ToJ2EXIsLupM8GfTQ6vDb4FFO0mG11d?=
 =?iso-8859-1?Q?F8sN3LcnwNHWfLuRKklBNxfEl6w86i+Q0qRFfq6Ph7v6cUVcZUnXAtsr4C?=
 =?iso-8859-1?Q?zZQJvovbzjl1NSHoJnmmKINMvB4/NFaRZzq06gKEuzEB9tEYYA5Q/qbDze?=
 =?iso-8859-1?Q?O5H78Z6Oa4PCbOUJZY0vhDdtJn6qEM8kXiONWitsdVENJ+xsDtZPI9VZJZ?=
 =?iso-8859-1?Q?zl/UOVM6owsa690z5753EVQgOqwfZtWLtqSfd1LR5QSYNQwUwQyJKjypoy?=
 =?iso-8859-1?Q?8RxXdeC+TZfcKwO0Bi93LBBN6iyOqwt0T7QYkuOt6F8FgaXAELnEUMdL+S?=
 =?iso-8859-1?Q?0GYoFamy4DAjgLs3/3b2c6/WGY189sSsFYiWX50kV5XEgFPN0u9CFOeK7c?=
 =?iso-8859-1?Q?kKzlwPW2YOxrdAXAUKPq6udogTnN+ZZ0Cx786eBpr9lg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?n2DawOIStHi39eqS3GAEBHeDL1c/1T8CNd74u1YmWPRLgEHeYCaX7A2iAy?=
 =?iso-8859-1?Q?uLNLOFXOVQuQpIc5gygBKtPXm/8scoECCHzXxKSPUUXv9sKWxFbqkvNy/6?=
 =?iso-8859-1?Q?MAQzkCeOLYJagRMDi483rkPhW9edNbJta3Tn03ghpVKvfxXn1w5Txs8VKU?=
 =?iso-8859-1?Q?J1oZS6js64yECnU18WgI2jxJ+1LRsBM/5dYoD107F2VMMCh8bhYx/3mVXa?=
 =?iso-8859-1?Q?rsfR3wEiK4wLk2MaIuEbah42ClUAaZ7/P2kBV/PqMFo5tkAIDOMaeGv9EH?=
 =?iso-8859-1?Q?o3zHzrcoHcxeGJ0gbBcxMoukPjsorBvOFexLV90BqBe+79zJ9q8xytE5Qj?=
 =?iso-8859-1?Q?84LRku5RU9wJUfztAztILTPBjq/tz7n+8uUFKvqMUdkILCsGjOptlaqJeH?=
 =?iso-8859-1?Q?Z6SFvlFh1QW7eOF2rprOuhLlTp+RQd3xnBOd/wf2gnphX+sNn1VpzKsmKz?=
 =?iso-8859-1?Q?ii8zkwhk+agJSSmdw2IXGrvsp5U8/UPAcLUy8j4+NTm18+KKyVslSFjGKH?=
 =?iso-8859-1?Q?dRZ9kflzrB8GjbCHMoSWw/T6XsziQX7V2IwxITPNNnQkxIJR101hSx+70M?=
 =?iso-8859-1?Q?i6CYyKtVAD8+pvxpZpTeOARd2neeF2yDaCqW9J4NkndjUCM28naZC/mcW6?=
 =?iso-8859-1?Q?oPBGifTfhgpZI+lh9XACNOjSr9BWYAXi8Or/JnXxouHpBrMjmFb1kaVgY2?=
 =?iso-8859-1?Q?UVvnQx5Ebq5+JGye5urvu5OLMtxl/ynf88WZpLSKHE5Mzh/DuvOZHtCR64?=
 =?iso-8859-1?Q?n/9pT7JEQHoSeXYZNPszDC5zrd+4yN4hx/ZDOffbRA0xAB+eRn6V0Jndbs?=
 =?iso-8859-1?Q?TAJJ300+cOwGcxiQNEnOpFcEMGkvBBMLgTbCnGtTJJZmpFw5vQzaMo8Jp5?=
 =?iso-8859-1?Q?uhJXfLr2QW10J4IscYqi/IZxOtn52QJKLP6i19WqoGO5okmbs6zchfa2KT?=
 =?iso-8859-1?Q?v920jx1X/hgFVTx67Q67cx1DjpjpA54o7B0HN0Z8vQqoWspWU5Qn/b2+vw?=
 =?iso-8859-1?Q?J3Ynt0Fu9IOLKn5MnrJ3CZNiQqlPPbqIWofdBSO8AXuVVluxRr5uVWKQ66?=
 =?iso-8859-1?Q?SKLNdr968l9pWgMIIN5MQKsW8ycMeWDp4YlWdc2o9AioMF8Ycd3QJGkaDL?=
 =?iso-8859-1?Q?qUfu5SLLBF5L4aB4erwF3COhx7E5obBBb62H6hhl2Xia7SFOcKP4mvZT6J?=
 =?iso-8859-1?Q?uF2jyc8I/pTEvpxEGYySIeHLe3TrVjL6WMaPmk1o+D5zt25LYHO8iPN73U?=
 =?iso-8859-1?Q?2M5LSbPe2YALw4tNPBlQvSbulAGKq2QEN+l6ocUrL11ldjCW8jU4g0xtiO?=
 =?iso-8859-1?Q?CjOZxrMj1AVXX9xyIexDub7JP0nPQwZq2Aa8OJlEq7T3g5fh8okC7PLe7W?=
 =?iso-8859-1?Q?3uPvpcXfW+UkWYtJg70pQ8/pXYYU8BPAeXGuJN4W+qFKkuYr1272fmgeqW?=
 =?iso-8859-1?Q?AbbBkfXF0lTTZOyKhH0mJN3GpcMYdSrEbraXI9C+y81rWHKrRcAut0Y+Cw?=
 =?iso-8859-1?Q?VRdOpTiyIXj6cdXfsmPw5it0ayqokTY87r0SDTouEsVWSWNJHT9Ssouhbf?=
 =?iso-8859-1?Q?RxC4uB2O+nQREb3InMRxDa45EExsPYCUf5ZPr3Gn06KN9Yd37YrXo4mEBu?=
 =?iso-8859-1?Q?P9bBI3QM6qoRV/rq9HW1pQxoo1jv4FpckP?=
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
	IIZbw+atNJZSXNZtKDG43ZyBgnCA27LFVZ8whNz+Ph1PU9/fQAO4geMxN1/Sgvz+3aiEySywvRzYwbbM9Cy4iu9UkzN6OMhawL7KSpnSz7lin5TLj5471Hye7+sRC2xbwkcoQTofDTAlZJEVoTNG5x8xQv+5PiXE9Cowb4OTSxXuWIB64RVrWN+ITJG3b1g5KiC8v6zM9+pghtCLC7MsC6a1fH+DwLnMyHW1P3zyJpYEPHBYplBhF9FFr8CTaX4EbwYtxXwziTdmxe6k754PfcV1FfmTd4rAcldYAHAHQP33+NDN8l08Kw2a/zhFHFvp2ptoZMzA1Ngsrk8VaCIMGpVKxPANBrlzb4nmXyKIcFWQi4ZTulft25Mj5024KQWm4IIYoab64IknioiYsD8NAmvNA8lVMRNzILpOraVKkLpwtYDlcktpBBfqOThzVoM7FnG68hymD6BdnmKMpK26VvtEyF6oQaxoHjzUTCcab+eyjl89C0++Xr3fyDnQnZqQ4LFwcFvXGFQhE8ilYekxgsK681A1wRWHynPjJjSAaEPDMhlEyaAQqHKWaGYJZjaNIOVMZs0sp1AImnWRFIlOGJR2vALnnYu+GD6wQ6bf4F4AK2QKmfUcmAkb1S3AZkkA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3544dd9b-d6f5-4be9-6f77-08ddca168a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 18:27:11.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/QTk44rtVop6V/MnTreGMWdsBQsGxEMrRlMq+nKM6/W6HWdn4DT1bxLOhjMWqIXe9TCQ3YNgSWySCcLPi2NXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6509

From: hch <hch@lst.de>=0A=
Date: Tuesday, July 22, 2025 at 23:11=0A=
>> By "let's leave this in", I thought you were referring to my patch. But =
now that I re-read=0A=
>> it, seems like by "failing a get_log page is fine" you probably meant to=
 let the driver=0A=
>> issue a get_log for LID=3D2 and fail.=0A=
>=0A=
>Yes.=0A=
=0A=
>> Process wise, can you ignore this 2/2 patch and we call this patch-set d=
one?=0A=
>=0A=
>That's what I've done.=A0 Patch 1 is queued up in the nvme-6.17 branch.=0A=
=0A=
Yes, I already pulled it. Thank you Christoph!=0A=
=A0=0A=
-Kamaljit=

