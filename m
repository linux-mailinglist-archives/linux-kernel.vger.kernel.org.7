Return-Path: <linux-kernel+bounces-744113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0079B10824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182A75A47A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB826056C;
	Thu, 24 Jul 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MC3EFd06"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52064267B9B;
	Thu, 24 Jul 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354291; cv=fail; b=hsrqx+UcjaeI7ULqgOHnpfj4uuN4hBbPwUtiChR6x24UXGiN+oWe8qOxWm47yHxSjtMKBSx74UXCY8C9ewIwn4y9k5WPk+4iRktEWLZ5zsWZ2KaBofa/wFisG7o+5F1Lo5XhFp/nmE7V+VFIXnobEBHQ/Dn+joJlNr1lW4aulXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354291; c=relaxed/simple;
	bh=4NcBXDTMLiLWSsCegk1GavAixu6H8a4kVEdzWXQLKC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JiX1xzP5l7AO4252yEIou2uokFuPoCQAnwHJRJanbFpkHbMk+QCVgrFi+QRGIO9mNQyXvsWKyvNrsTBk4uMAQu1rdBPXPtaDAxf3Shd+UQc52Q8gY9NDJSZ0pRAlYqSb6JSLVV3GvJv4Sf50B8LNW/oS3n5Z75Kp7w7bDAz1ENs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MC3EFd06; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBhchEeP0D/JUIes1kUocXVgMXLp+DiNhk28QmJw99SzDRYtg0EbQGcoU5/SPfe7eHLg5mN63RB0TgTpmxTcyqjYQm8OH27WDPQpwbbcOZmQchy6BW4CZaBsmV8j/G3WXWpdT+Tzcub3PDL2PXQDX7/6SsiGQAPNBY3oAETDLb9nH1nNQjQDh7GRQKge+yEwKA5RDzE/LiIgO6uQH/e2umBx2/hU7Nwzqc324jvd797sIGt0SEZ2v6US4Q8B0D2OpFC6FQ1aKnMTop8EBx+juDNVhBy+nDJYrBBIDZSM3A3NqeA/kq0TX1Uo0igDx9EdowlVXo/2NeTC518KRyMAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN/zApS5mcF9H0zlfIuePMvGTu2jL4QdAxTWIncWbzM=;
 b=rH3ZP+8uvtv5YMw2zOwYiPWl0wop91Lsohar5MFQws+Vc/SLbRsTZjFEZicKHWZYG+EA7jl3YpcBwS9ET60NNbib9pEyZ1Ihl/kLvAKOXOePwRg8A7GI4mSTJfuNF8PkaJTM1ULLjtXK26ixyjXAydP+tROKoMKYTqe5wYTYFfcw/ZauOeVf7d4mtZMaGrDH5uotE4WEkqWcb6wV8r2Khym291vL+OZfiPlHrWZemqWWMLaPgwqxhDxt77CE22h5+jY8bbShxZRzxzEuAOJFGvAemQHGQFSx5R8MnvlMmD8JTfQOgcXjmMQz/e9gAi9TBAfLoAWQDaPD5Hw2Eh5GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/zApS5mcF9H0zlfIuePMvGTu2jL4QdAxTWIncWbzM=;
 b=MC3EFd06aa29++x7zQ2LGMQcyy5lucg8vKZwvtNN6UA6MjMO4IufXzAfJJBuwDjU/a+ooCagKwlLBEULjQis/IuHGEjWqj8Hl/B6ibE88UHoq/wTW2IdOvYEb6A5eKQMIl+4+sZ+rA/oyHnbv4k/dirlaoeueT9lhYxDKkp9AMvTRpfLPGW/toHyk2ukA1I1j3ZQvT7uJ6FzIYfWirvJwJKCfIKg5AY1jtcHKPxMdf0kHrUZbkDaq/5Ge+Z7YLmul/bMZdCt0eF7TTHP/W3S8uE4RfD+RkmC8hmKtc508PU51FnW0Z0NaRljeD8hpK28WkEOhPsgc/Qep7z4kGMNsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 10:51:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:51:25 +0000
Date: Thu, 24 Jul 2025 18:51:15 +0800
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add PF0900 regulator yaml
Message-ID: <20250724105115.GA1748604@shlinux88>
References: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
 <20250721-b4-pf09-v2-v2-1-e2c568548032@nxp.com>
 <e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org>
X-ClientProxiedBy: MA1PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::23) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c189265-f4ef-4457-a832-08ddcaa008fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xycj2YJrczwVT6tR6zAma7XrvuictAn2iyEm090q4v7FQWiLP7cVlzwV6CvX?=
 =?us-ascii?Q?Dayro2yFZqSFSN55gCdxpdeWaTWU0gz0XoZanLDgpo2ut6mXtI8NDsZa6F4B?=
 =?us-ascii?Q?ExYPj0XmykaJB1/KVJpwYShOJCzIsaptRUJe6Xyj3SkSp+mROLKncm0S8rKF?=
 =?us-ascii?Q?hyeFQpc0KVh153IwyhM2zIHT4judd6p/dSRUQJ3Bz9G3eU6Su9jAd+DSNuE+?=
 =?us-ascii?Q?4gcbdsStYKMQUhWYiUXgctkcSnBzwBBY0rzL0CtqSK/Z8g29EweaSC+CsbTI?=
 =?us-ascii?Q?R2cKCfz8HwJD5p8Yh0lsL74QxepgEGXgiT6aDJNZyysp+cG3n20Z3+WQD2y3?=
 =?us-ascii?Q?uTNcD1i/YpzqBveu/ZXn/tWubdzO6nnkPdrVOsUuginRVuPTVzkZpCAtXrHf?=
 =?us-ascii?Q?2Vw/qQC0/kovAUUhWesN2tbsdhVCU6X+01nv6/tO9VcltLXxdca6pwIz6OTT?=
 =?us-ascii?Q?RKn3V5Qhf2oMq9Rz0X4VoXO1e3akAM2GrGQq1zv1uE1AEBry34PaGfWzL3bW?=
 =?us-ascii?Q?OXqJa5fVUHOkhOPCj9H0aUx49iyC5dHsmtPMX/nGQDRyJ3v1x2ct3A/fmOAg?=
 =?us-ascii?Q?1+qqvud5T9T6CWcxwwNVHvDq19VbY6nGOJUnTeilFHa22reBQppufxV1HHo5?=
 =?us-ascii?Q?JeNcEMm78aJB8JZlDy5XbTY6LZ5e+DBOYgcnpOrMNbkEmzPZv6nVOq3JVGov?=
 =?us-ascii?Q?LH6PkFwFMffe7gUJVDIEm+vXgIgnM007gqnRRcYgLD7IJQ3bipGNe2TgUQSV?=
 =?us-ascii?Q?wzD9G2n16GIOl++W7t8Z9GuMa7dvXBPtU356Zuc/+IJU4rinuIP3OzKFsYo+?=
 =?us-ascii?Q?NyC56TXrXZn2DMEu84trWlaXe7Vjy9HU1nXBko0RFl4PdOPiLIkvcqPPZL7i?=
 =?us-ascii?Q?XRE90VTfuEkmPg0gMzIiNprplHpNLTEypYStro97a8a4IO9EaB06yaudfxbZ?=
 =?us-ascii?Q?EzZKuoMBX1pY1MFGhEoY6/hGFBwjZ5OaRa8J8iRNT/vRiXNrh6xrM7bXUQM/?=
 =?us-ascii?Q?zN4UEjEnMcyM1ogjBpaKsXutgkdvSe/pwXSQAbJgLOt0BVEaw9cGIEqFXA/j?=
 =?us-ascii?Q?/8O2RBj8VOPoHRQ57tPRBUEsztwCAki6VXClKJ7mQgQJJPqD99gPF5O9MoEu?=
 =?us-ascii?Q?jdakmacIVNanqdmeltYU2vaz+nVKFfwOkGe8k0jAheon/0Eg5M0gmod1Qm55?=
 =?us-ascii?Q?B4pppT/SPtK79v0Jb8tY7ck+2jTqEYIVRh63V+0vq8bl1+DAeXSy48RtHPNt?=
 =?us-ascii?Q?WTx7YwDtHJRvrmkydAhXs3c+a/5anN9ePkiRj8/2TnUE9PAiSdVUyYVhjVLe?=
 =?us-ascii?Q?lzm14PjFD8Fwu7zmQSXyr1udYnPTHUC8R9G+LAJTNhO7LRVEqpkk21bW0AGa?=
 =?us-ascii?Q?TM1ttRxDRLsD0APVEivTUtb94JwRA1T4lxq2DXrbLIZvGtiZtvUtjTOGLtGV?=
 =?us-ascii?Q?kGQ7Xiqg8EovsQcltnM+GOVGwxNou8OlCQDMGG4jGT5vgfnx3K7u1toGUYgj?=
 =?us-ascii?Q?zPU2nlbraqOVszc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBs9lE+n6rIxlJhE3NXHOCDJDgDPY97Xuc5nWZpEjIkFUfsgwE0QQl5CtAxY?=
 =?us-ascii?Q?D97QjyMIrw+195qOqIxPpyr+n3l8WgOWY+1l8dQapMbblXWii2Rc3+dm+Y/0?=
 =?us-ascii?Q?aS08PY2nXmAi3PWkz9uTBh/scT2Jl7tU0c0cTqxc3uSzTdmEucEu5crCLda3?=
 =?us-ascii?Q?D2OXWoGTlbSxT0vsNVZblWPYyOF7i8vH5Z9tK01SxMct0w/aNQP4gAqg4jcZ?=
 =?us-ascii?Q?vbXo9r8/iixdJTdMEvZCaaMtoYAiI7AT8totzwEe4Hjl6LQjzokWy2JSLW21?=
 =?us-ascii?Q?V3q9OBxlNIxhrulHsltrqJ7fWDUe25jbCW4u8ALvLqO9TlYjICwY2HpNL5KR?=
 =?us-ascii?Q?1fxKumz9HdtLbbaFS49BYzs8upROTdiiIDWhAOGO7vIdYZuyL3aN+PdlrH3H?=
 =?us-ascii?Q?+f4k+yP3+HXKjIbIyC+bjo4r4p2ocEc50qUSJwFE+n2cBl9yRUPSu8lp8fyu?=
 =?us-ascii?Q?VVsnqewbJVTkk09Y2o+SoDQgx5GDjYN8kztGgtOY4qDDMfwfzx8n9wajmn6o?=
 =?us-ascii?Q?pABrP7xsbpp7/d+65YgEXcdFi6aao5//htVc9m1z0u014JDN/hoU0GNB2aQ9?=
 =?us-ascii?Q?iX5fqYy4RmxOsWHmnoWAopaG4OhQTt87MyGDf8xkjCgO95iD+D/iIbKsSXMS?=
 =?us-ascii?Q?qWRVfyGCz789rxJbaZ+r61IPK9Mi9qHFlzPlhCX4XxacIii2Pek9kz1L4uDG?=
 =?us-ascii?Q?gZL4Qrqy7wsGULq0eq+t3ISl22g1Hr+hOW99MHbUAcdAk1lYCqJcIn2LnDu7?=
 =?us-ascii?Q?AhTXlsDsnBfKxu6+g+UxUqxim5blBwbjFAX0JYMN8o1EeTmRoWF0bOphPBUk?=
 =?us-ascii?Q?7aqLCNhIf0SW3ewMlXfgZscoLDZYGKKtwuWFisdwjjtAvy2ZZKs9TrgldKno?=
 =?us-ascii?Q?IPkw/2OzMibA8jV292yBPZnSFvAZ9RPFri+0fz0ctv4pHZzUgqXhs4QY5mRc?=
 =?us-ascii?Q?GZUgmD+TSx9lXrWgsVVL/m9D5M5rDLVpY+ajwrDrzAQskGkR5YgzTobRip0k?=
 =?us-ascii?Q?iA+uYzMOb+A23WoIlLIonRV2x+2BNMz42TygOmhsTRACMlW6q7dIIlphfVsB?=
 =?us-ascii?Q?w6+OCZdJIaXlbevWvkyzEFoW4dDB5IheofL4Ycldj2Ayju66d4ascZyCCeqp?=
 =?us-ascii?Q?LcKgMhFtPaxOY+V663jnbUUWknI2dyyaI5bmMd5t8SjzdCq5W4Tyw9JyA8MA?=
 =?us-ascii?Q?KmEg/f8mPQcq9lzM1IjRzEw9ujlBgvQ/zMenJs3H2lu9y0vBZM1Foz5nFxRL?=
 =?us-ascii?Q?NmRqF9wZBS65bhGLYjtBvHW1cSpxP0q1/AfIPqrGutsK/oTgFpXoCpm8j3YC?=
 =?us-ascii?Q?+AwfH08ClpbHa+AWKze9xTGkATYy6gER6tCSaf698fJPY5w0stNoXPq4rD4a?=
 =?us-ascii?Q?h4kmlGqHIl0exvv8kskBvLpcAwlsSkBckWRzxt0jZtglG9OPIricSGm6D870?=
 =?us-ascii?Q?2KHaeazedqYMyhH9t4BhM4K+bxEAM3KUco7bKqR2zbMVezyaj0dEiXqz3qQ9?=
 =?us-ascii?Q?vlLSQnHd8Ux0wJXxt434qExIMtJ3hMtXi7zLcyyoNGhxumUl9nqFuN0bePi8?=
 =?us-ascii?Q?7Llc3NAPolzEnz3BpXV0MLC15bBVFwvnwNcJVvYR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c189265-f4ef-4457-a832-08ddcaa008fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:51:25.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiR7OLolwOHUun55Gc8YzBk/AyKBbVshzKIBNDO3Yd53PRHCddTWOafWpRJQNPHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643

On Mon, Jul 21, 2025 at 09:28:59AM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2025 09:11, Joy Zou wrote:
> 
> Subject: Reverse prefixes.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> > +
> > +  regulators:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      VAON:
> 
> Lowercase names.
> 
> > +        type: object
> > +        $ref: regulator.yaml#
> > +        unevaluatedProperties: false
> > +
> > +    patternProperties:
> > +      "^LDO[1-3]$":
> > +        type: object
> > +        $ref: regulator.yaml#
> > +        unevaluatedProperties: false
> > +
> > +      "^SW[1-5]$":
> > +        type: object
> > +        $ref: regulator.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          nxp,dvs-run-microvolt:
> > +            minimum: 300000
> > +            maximum: 1350000
> > +            description:
> > +              PMIC default "RUN" state voltage in uV.
> 
> Why existing properties are not suitable?
Have not found the property that can set run state voltage in regulator.yaml.
Can we add a property for run state such as regulator-suspend-microvolt?
> 
> > +
> > +          nxp,dvs-standby-microvolt:
> 
> Why existing standby state bindings are not suitable?
Have found regulator-suspend-microvolt property that can set standby state voltage.
But the regulator-suspend-microvolt property is now deprecated. Can we use it?
> 
> > +            minimum: 300000
> > +            maximum: 1350000
> > +            description:
> > +              PMIC default "STANDBY" state voltage in uV.
> > +
> > +  nxp,i2c-crc-enable:
> > +    type: boolean
> > +    description: If the PMIC OTP_I2C_CRC_EN is enable, you need to add this property.
> 
> 
> 1. Why you cannot just read registers to check for this?
> 2. You need anyway proper description what is this about and then wrap
> according to Linux coding style.
Controlled by customer unviewable fuse bits OTP_I2C_CRC_EN. Check chip part number.
So can not get the I2C_CRC_EN config by reading register.
BR
Joy Zou
> 
> 
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - regulators
> > +
> > +additionalProperties: false
> > +
> 
> 
> 
> Best regards,
> Krzysztof

