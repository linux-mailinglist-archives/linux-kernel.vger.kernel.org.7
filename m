Return-Path: <linux-kernel+bounces-839701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6BBB2313
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FA9189E37B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1B1F956;
	Thu,  2 Oct 2025 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="BK/Nwjhe"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023079.outbound.protection.outlook.com [40.107.44.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD1B652;
	Thu,  2 Oct 2025 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366754; cv=fail; b=qgToXkO+/e5aezOZUF34AO3t195MnLblyFCJAH4UOEhCaHtvtxowiXvD0MfViMMPTO5hRikj8E1vHcCvvsvkFjscESnY+klfzRYjqoZbUlKXtnpP2S/VRyJ5e9RHQ9Pwo8IWFFgYMSC1jFkZReHrRyw3xSCzlz9TWOhdG2+rqmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366754; c=relaxed/simple;
	bh=js5JECUDsT7GjW2/d+HBNTADFQiuvV+I+Rbi8irBvUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QVxNeaEOp9LRVGtiax8yqp8fUA8mEJAmnHJRU6yA+AYudeTYgRNX92RTjlK+mFY3NYr//1bbryiiIWFajSHjdBAzNT8lspzRFRorvza5oe6vYiJpQJSIDrO6w/r7v1DiTcwuAFROXTynZf9XTucLM0uCbThJxKF3S0c4rMNh3vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=BK/Nwjhe; arc=fail smtp.client-ip=40.107.44.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o96bKVqx8XODb0675pKlwiSWncakrwY4UPJUyEkIsngpuS3hRBNN7GfE1dHc+hOd53EcgFAw3PwKm11bhDMp1wK3s7mNZ4/FoxDn5ewnl5K2cVQRGQU25q0ZcSD+fLnycfU09arwugPdeTuZwOQ0JESq7L1TwrBMUE1y0dKiQzDkbyGLz7gajAvyoNbHVanI4oqVx/z+eAQrROfN42IVeBvx2x2rJkmNJ3ahuyKV7iwPK9muuIj3IVKeimymm3MR4A+x1ghAu2a5DJIPQg9gDxYSrYnVP/NKbtZjRB2DfoSVxwYtHr9CiO+b0NSUsvo2V9q6pup9jN99p1Ai0mrxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rbA466Cq6Xn5iMjC909XZt3zitGqubjawR3Tkn0yeE=;
 b=eU7Q6gtSh67EpMbtxhPSEhdtLedXj6Fabma1vOx0+9RowXkBtE1oCze5z6g8mv9zx8tM48CE85dtrkY6Bi3FBmn73t+rigi2Yul5DtNuFPD1lgY86FwdPQN06G5krpCpG4sNPxlDAr+NxB6AYKzrJsyYIgQ0xZrtzhhGF8K7qNrUK/tN3foBt7Pg2ipfscnYbcKvSH7x/6w6ikNBmVa0bbc9Vrk7fqq2IiNxv5zUtvFdz24vggOs/IRU38pL1k+py7ZvYukG/tj2acd+rURUB2vuz2BiK/ISaxPZLq/+tqwQmX/nIDYd1U/O4Q7usB+M8b+OmvTMbRWTw7ECkGt/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rbA466Cq6Xn5iMjC909XZt3zitGqubjawR3Tkn0yeE=;
 b=BK/Nwjhe7bU9XciP85fotFCDOja1N0vA5eCpFrcnuPCOdNd8nP0fA1apXxTaqN3a3h8sGjjmpbQ81fQfZ2Fg57uUTZ92oeMcXbcQGbM8cgePZBdXtsOgwJI+O0cYDQhzpDLJb9cOOeowQz++ZpYCaWG9ehwazR7KLA6m7PClKgWE+jmEQPtgiTudnjbMHS4k7+A/CKOpUfmbWRV6S4NDIj+U1m86rOeZsqCQCIYJykJlu8L+cSYoaRGXmuRVYkdVWX1babdDLdkVIdYpCnBJqIvsMDA377qZLR79hwAH+3J6GUuQqJglBIN7DgvMlPHmT8Wq9uSzm3rEPR4bQZiH/A==
Received: from KUZSPRMB0005.apcprd06.prod.outlook.com (2603:1096:d10:2d::7) by
 SI2PR06MB5089.apcprd06.prod.outlook.com (2603:1096:4:1a8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 00:59:08 +0000
Received: from KUZSPRMB0005.apcprd06.prod.outlook.com
 ([fe80::5145:1a84:4b73:f8cc]) by KUZSPRMB0005.apcprd06.prod.outlook.com
 ([fe80::5145:1a84:4b73:f8cc%5]) with mapi id 15.20.9160.013; Thu, 2 Oct 2025
 00:59:07 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Topic: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Index: AQHcMCddF4ITLdJQAEi3Dh2gsBLdrbSouQGAgADw4ECAAIsggIAD2XvQ
Date: Thu, 2 Oct 2025 00:59:07 +0000
Message-ID:
 <KUZSPRMB000536A7B10DA3052340556AF2E7A@KUZSPRMB0005.apcprd06.prod.outlook.com>
References: <20250928032407.27764-1-ryan_chen@aspeedtech.com>
 <20250928032407.27764-3-ryan_chen@aspeedtech.com>
 <0a12f3ac-2600-4ede-a738-f4ab43ad4bee@rowland.harvard.edu>
 <KUZSPRMB0005CC6A87F6FFC5A08F12BFF21BA@KUZSPRMB0005.apcprd06.prod.outlook.com>
 <be6a9306-c88a-4cd5-9b88-dfd4d6e2933c@rowland.harvard.edu>
In-Reply-To: <be6a9306-c88a-4cd5-9b88-dfd4d6e2933c@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZSPRMB0005:EE_|SI2PR06MB5089:EE_
x-ms-office365-filtering-correlation-id: 0dd6779c-7884-498b-e71a-08de014ee404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5xkdCR32iUewUM+tkmd++kOyHwK3JYunmPxcBpRcfe4i1N0ir1lFty31FCOV?=
 =?us-ascii?Q?h4U7toIZf7sfSuRfO5UWt3Iq2Hh8neKDY1MAP4jELgi4aUp8Xh2nOGSq9VyR?=
 =?us-ascii?Q?EZYSQZqKBv4xlCunL978e1ihs7G+mll4C9Grka3hfuRPn+o56RQ6kryzd9d9?=
 =?us-ascii?Q?9AgPWTCS6X0hyHvPlVLAibuyjf6/tESvnswOUNijJsUf8j92cdP6rwE/GPVY?=
 =?us-ascii?Q?M3c3YT+HL3yWxO4xxzlSiZJe+iaOeoqjg57WX4H66UQSs7RJ9x3ywMRpjjD/?=
 =?us-ascii?Q?EjOuS9kc62UhHDG676Ax5v5eWfDpCjkLekFHFoRihwOuft5UXIZchb82xWdi?=
 =?us-ascii?Q?b+hobFrsORkMxDDGBMOgTBpTdn24ZDl1WsRmKGos2YMRp8Ier5JSFBZbNWhj?=
 =?us-ascii?Q?WPG2Clgpx2DKzwQ/7RpI7uF43UG0bj5+KqFWpB/xVNUOSaMXnsjDPeOBnhAW?=
 =?us-ascii?Q?BU+XGRAFygwpzdCkXhpLxjQOjGe/gFG5+S3znxUES6UkL2Yqj+aBal+3OTqQ?=
 =?us-ascii?Q?zwS7XQ4QRtF3KDeDa9paksmgkzDKIHfJPb+/K9TxhKk+mYJzceorpWtL9b3J?=
 =?us-ascii?Q?DMmJz2FYG+pBfdhHMStS5+125NQYI8kQi18+b0xktpqqsm5D9Si7AeAsgI2x?=
 =?us-ascii?Q?Mghuh3yZg0GLgJSt8VXzdh6wdzP2BrB5QHlmbBcKiSTfaIzbuYH0vHp6guFz?=
 =?us-ascii?Q?oFpjAefOnlwanN6iZywzu5+d3lvHOJ0hMVFbd+knmKi9WyWDe7W7sn/87jTT?=
 =?us-ascii?Q?pgXw4SCj2GD9KFFCQ0smAO9dvm+D6KJoy/m8FiUpasRBqadaL15c6T58its2?=
 =?us-ascii?Q?77z2d+dliG4OewLq8Dz02UoOfwAiQOgAbYok4QNFM9mI6kZCmLvf+OybbKRZ?=
 =?us-ascii?Q?jPPMSv0v7+CD8hVY5Gep0H/KcLVBeymmTaBQcJqSDGpFe8o8O8RbxIO3zNh7?=
 =?us-ascii?Q?dLf9LzW8T1UicNxPRkwfOFulGZViD8sBL6UABPN9DzpkXmV0zZMG3AMe3teM?=
 =?us-ascii?Q?CaMLCvJR7WBwEA8BfFfUIol9jEeAAZKkpzC0UIZojn0cw8hS7HSYTK2NNbo0?=
 =?us-ascii?Q?CCQaTvADcnIwRjAuYF8ATPq3y9sUZAtXNaDgSgL0w9JCNre7bslICJP5TOJc?=
 =?us-ascii?Q?J9qK01FCeTQLwmnUhkNvKp17X9/8NrEgL77j0Dd27Mkhwdx+C/86I5k3D+1I?=
 =?us-ascii?Q?XnPbJyxXAlFVgf/7z9ajAHuP5cCK867hwUL1qZXQjDPh+A8r9CY6es3rsyQC?=
 =?us-ascii?Q?bV7I4H7plqFC1uhAbPTgwV3bu//1jFbcQBRRyKci3iXDqbvdvCBmwa9X+CS9?=
 =?us-ascii?Q?T4du/JOZV2Oe1E3EUsKXco2iV3wfYn3BPBVUNqVkN09i3NMNrk63q78Bup/D?=
 =?us-ascii?Q?fZ73gw0XBAbrgUAHOqzVYR355/jB8hDynDfJNGW7FOeUUDPaqZpR/zWgP0w6?=
 =?us-ascii?Q?UUNeTHEW67t61MVsVOTXue5sBGlzNJBnMen0llFOjGs8p1dxSosIPjec/oXA?=
 =?us-ascii?Q?8bGggfjvzUZueOFcg0Vizf453e//0OoCk2m+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZSPRMB0005.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eEIf+kZFkSKOKk7JGSMxrpQCoEnVec7Wn6vId25dLsTjuVR64ftXHoCgtW9+?=
 =?us-ascii?Q?8Ml8VDRGPPRbYEHjLiANZ2ihzW0mhS9g7eSc5rdiwK5+VQot2L3/TxFqn7rx?=
 =?us-ascii?Q?0gLJ33YS7DxfFXhq+zos5aTdgFeSF7iLQZWZH6W7l2pD2InYVzhaQypkS7iD?=
 =?us-ascii?Q?adUoKrI9grWrAVAQJ3vSIG16jB9zXV7opdnhx3zit3eJBJT/A8K7in7eRCsc?=
 =?us-ascii?Q?5JBNDStOHo9noZEy4kDNnLBUOa3LX63JmOZf/o40+jSPKHiZGtSCFJL99Wq9?=
 =?us-ascii?Q?sVcq2BNBi0QQ+m78QOeNnk3HGpBuN2gO8eMbDS1u4YwA65mh5bkGBQZQLt+3?=
 =?us-ascii?Q?R5r4uthtiBF61Tks15nSLJ9SA+Sa5OD/+EAFtBHjViXELhXfq3yyuPeNnecE?=
 =?us-ascii?Q?k7UJ181P7EmVdMl5Dtqfxk5pFveWOJbIt5LpIsgALLAyPC0CkCKBV2FnEM40?=
 =?us-ascii?Q?V7+tbBel8nuB5HBgNKRKoX3wCLj5IPPxw+bCWskKBefClM96PL8DahC1p/hZ?=
 =?us-ascii?Q?16GTccyucStjnpfjeqTvcWQD4poxLWpRLZ/nRfZFuYbbdQo4iHpTPkBdKadL?=
 =?us-ascii?Q?tLNUqWQfuwJ44vGdegi3bobLWJxndEBTAYOLLO3XjitQRjHhBxxG9vWx08dF?=
 =?us-ascii?Q?SMMQsgJdBmIAJlS6ZmG8Dp44GDDIWB7WHDHxpLdt9J3+/rO/EaBQGBMtiaI3?=
 =?us-ascii?Q?1MdJaogSgV95QVaYCiTxG0TqgNkneUMLkIgB7H4U5IPaSvoh5EanEs5sxOrX?=
 =?us-ascii?Q?BjD9Iaw0IpQ4tnuVodi9ZwsBl0ihrRF7p+4XHFOln7M+mYZp6t1f8qJzWzoP?=
 =?us-ascii?Q?0Mt1VMMfOTYvHtbmES2M2DZNwIkW8GA1j78eR9Nmn723sd5g5qjEQCFS0iJ0?=
 =?us-ascii?Q?pG8TIun1qj44SWtAvEcSXg3WLAi11q0hi4SoKBsao+LOPIsAIvtjVQEnUOpE?=
 =?us-ascii?Q?DZxEycbOomN1t6K3mk4nTQA/fGQktCRMWvfyNM/On4xVdRF0CrH+PlNeH7Hf?=
 =?us-ascii?Q?ukHQVgCt1J4DIwSyh7bbeSyhAlQFcho13S33H/h7V5jG7YbbP4LxrTgvsHIv?=
 =?us-ascii?Q?yWgqYHrcVqr0HU7NCwlHhPoE5+eCyOs9BMFTXbxH0v+pkOYdVE5FXYOU9T+g?=
 =?us-ascii?Q?Tr1o1NSdoKm59LHxqauecHh00fLH75Bo2ifZoDzgAwCb9PiHmYR/btQgQxtQ?=
 =?us-ascii?Q?QzXeFygI5N+WFf5JyO94ktO0he4bktow3Ad3sTGkiO+QqzgUerG59xduGl88?=
 =?us-ascii?Q?8Hk+dxjs/8XOINpNBV0VmHKKDP8WMh4IICZHp41YEOmUxZVANpsWvs1K+1/F?=
 =?us-ascii?Q?vtdFgKm6ZRg61Heu/mDZJpl41keLbFXp0JBEKsXcOusqUeQcaVqLVt9IO98Z?=
 =?us-ascii?Q?I+q4yNc8ujmZnru0yJ+RnUMyRUnAY7FEJbEvwoD+vtUSD7RzjrH39dbmkntG?=
 =?us-ascii?Q?VKfDarpkB2PwC8fG7LixNP9KJCcz4JaxZPAKKDxWLUIEfO/wcNO2w8GZlLCY?=
 =?us-ascii?Q?VfU/xTbXfGws+lYsd29M6mavMzTqDsjARzV20ryokwSAhPNlH0dnbPAlo8la?=
 =?us-ascii?Q?Sha35mvN8VTOv3lSd7a9mzrwjq8xLsfbfg/3b2u6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZSPRMB0005.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd6779c-7884-498b-e71a-08de014ee404
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 00:59:07.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umng5dQMnucsgW1GMyIMIwAYssLGCf7nVXssl58WT5tFhpxWcwiAkgetL2KoUvBaGa58hx4BmHKBeRNMGgw7/7uk48GKr6JzmIy1FGh3/VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5089

> Subject: Re: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
>=20
> On Mon, Sep 29, 2025 at 05:56:13AM +0000, Ryan Chen wrote:
> > > > @@ -253,8 +256,13 @@ static int ehci_platform_probe(struct
> > > platform_device *dev)
> > > >  	if (!pdata)
> > > >  		pdata =3D &ehci_platform_defaults;
> > > >
> > > > +	dma_mask_64 =3D pdata->dma_mask_64;
> > > > +	match =3D of_match_device(dev->dev.driver->of_match_table,
> > > > +&dev->dev);
> > >
> > > (I just noticed this.)  The "dev->dev.driver->of_match_table" part lo=
oks
> odd.
> > > Why not just write "vt8500_ehci_ids"?  Do you expect that this could
> > > ever have a different value?
> > >
> > > Alan Stern
> > Thanks your feedback.
> > I used dev->dev.driver->of_match_table rather than hard-coding
> > vt8500_ehci_ids to keep the probe code generic and tied to the driver m=
odel,
> not to a specific symbol.
> > Functionally it's the same here, but this pattern avoids coupling the
> > probe to a particular table name.
> >
> > How you think ?
>=20
> The code doesn't need to be any more generic than the source file it
> containing it.  This particular probe function will never be called for a
> different driver, or a device that matches an OF table different from
> vt8500_ehci_ids, right?

Understood, I want to keep get from of_match_table.
Appreciate your review. Thank a lot.

>=20
> Interestingly, there are two other places in drivers/usb/host/ that call
> of_match_device().  fsl-mph-dr-of.c uses my approach and xhci-plat.c uses
> yours.  The difference is that the xhci-platform probe routine _is_ calle=
d by
> other drivers, namely, by xhci-rcar.c.
>=20
> I guess it's okay to keep this code as written, even though it's not stri=
ctly
> necessary
>=20
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> Alan Stern

