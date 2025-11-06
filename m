Return-Path: <linux-kernel+bounces-889302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57544C3D3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D443B22DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A835028B;
	Thu,  6 Nov 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3+u57qU"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959D34D4D4;
	Thu,  6 Nov 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456949; cv=fail; b=blCl5ZpJousCqtpm8t/RqCRTtzciMQGfTMuyWSn8FfRO+RrCFu/uohNryBr1kAYYdLzD6Y4/7abdYLwAk0Ay+T7hlB9uyuVDd8wifDDd837c0pVx0wprf1igmfl3FAZ7ao2tepuEGMMkwJ3lKRtUINpXfGMyEd3N8tk1IqUr+FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456949; c=relaxed/simple;
	bh=w+Pfkj/Jkj+M7PlpiAi8HRkuGxSptvvdPKoZ1wOMzIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llhQovhPW3mrsVn5W+rOjpqNoZPKBcwkLCA0HNYKqnQLz1OM79kGlIA0TeVwLxVspRVZvqU072U9q5Fyvj/nQ5OS934e8T8xjcflo1dGYOWy7Ky2+WWf+11MBNe+lI9WRZSl2xLRb7wdR2Gk0fawS8ykUNia3B/hgPFC3zefGmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R3+u57qU; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewleQ6svnrdLI3cCM/mEa6k0jX5x1fU/+NZ+ZtTnzTE5UhE/xhPcgF3VY7iK2JYTAvb9m9Xh4OOP9NqCVfhvg9oUxzMa2MHyIbl0FuRoy1K9MdUT2UNXs+4fNyoZ618BDgZtF+yiC/11PiXcKho39pbC5OR3l8I39GQO4n62cC019sQViM+c9/D2WkwGueoLBG1pU8rU4S+dvtx43ALXWbm3dNC9RCiNQCRyhl3KTMlWAx8NXZJe4Xeqz4Wh2iMhRj1rr3HuUMItW1zjtRfLw09J3FBoKLzyHwHLMQojgfgYudHbYiVRYU2rNI8w+ypCg15bXBkrMBXNZ7IYXNDRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktrbxpOtMmlm9rGP/38C+L6coQdpnPpLgQ/9hMoRB0g=;
 b=xxMAgMgIlUIdG6TvV3PhOm8tSPqbfk3KCYkT47ZSRwfSP4/nH6tQVqP10FeDx5dJWFKrIBV3y00dxmv2qeCMwGDBSVlAlOI7mmWTj3nT/jmcMrTU9mWXOk3epeG52QMJeuiYHl9DwUgL+nNbPd3SQMDTmFg8UjaTBCwm4J6WQtJImhPKVE23a6rhscXgU7h1QfV0rH/E74XQMG8LkWJN1MvZnMvujNQlhN6bLDrxeMYExlj0GWhJzu9gkB5/4Zf2XmE31UPpexn57zccN4qUHFrN6PXmEDB5TuJAxNMQCqidxV2eJZh6C6Ursk2UXQW3vAfg8iTNEtorI3vpf11nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktrbxpOtMmlm9rGP/38C+L6coQdpnPpLgQ/9hMoRB0g=;
 b=R3+u57qUtgsS2HeMwiYg4bGYG51kB1r1JB3SLJy1NdpQF+nkIsVIyyPDhj125pWD1rdq0YyYOmIju27wgc3Jb+sNNBAmYd0cwEIW1tXEy1c54R+sQz/I+GaHmD3cCSMvXClbaWsBY8R+YErpRhYe6d5nRscaUHV9SxXxD0akdQSPBgi9iRXkuBCVQ1JXWTWg+qkRI7XOANDB09UkUiuNTdP0Q7jhx50U8tj20TgjduCSUKvJAG1203XHY1mHCi6OEAiXnqdMiCHK7U5FoxFYPnNAtUxHuydukHI/ngXr0dBuzeRQybBUHjeb1olIkPIP3v4MszM5tP1Ca2ZMHnwOoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 19:22:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:22:20 +0000
Date: Thu, 6 Nov 2025 14:22:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michal Simek <michal.simek@amd.com>,
	Wensheng Wang <wenswang@yeah.net>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: mfd: Convert dlg,da9052-i2c.txt to yaml
 format
Message-ID: <aQz1Yt9lk+roRq9z@lizhi-Precision-Tower-5810>
References: <20251106013358.421809-1-Frank.Li@nxp.com>
 <20251106-hull-petri-42878717ee85@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-hull-petri-42878717ee85@spud>
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: f4837a1b-9fd0-426c-b17a-08de1d69ce29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7gl/LTtNlZSVSKKKlKVNlVaxynPhIau7yx72PJqItlNLpLTFrvZjGMKIohd?=
 =?us-ascii?Q?gvKrQDVr6ysRGGt6A85Gys4BhfbImyEMV4XNgZrrOx3wfF/fMegM3cEyJDLC?=
 =?us-ascii?Q?hmNRl7SUxiHtE3Q2gcjf7rTrWW749mrzuO3Erubqx5pclIY7I03Zir9cfbNH?=
 =?us-ascii?Q?gz//taTbYZo18mEQJKTlifbLRg6e2BmcEMPdNhwegTnG7Cv77TzDAvGD6418?=
 =?us-ascii?Q?BCHkFSY7gsTvAg80O2CxtVUIKfPLsnCsdyoUmRLVeTjlJJUXC98QhP6/dO/7?=
 =?us-ascii?Q?MiAm2yKD1hV++EKinbFXW62AYs+J+ZvIfF7mJy4Qm9dLKJq9Ac8/9q06cqDt?=
 =?us-ascii?Q?3daDVKFMRBryeXrQbnKTlerhKIwt+O4RGF6wGURtqgBFw3dpB1KWF78jlt1D?=
 =?us-ascii?Q?lDsmbQFNl+cbI3LB5pNWnEUa4E0aINodzo0uur4vmzYFMW5As/bIjkRNgi2A?=
 =?us-ascii?Q?XCLmVj/wXN/fe5bE+/ppDxMiobnnEjjsFWXYQ4xmakbqcZFm4nwnDfjWR63p?=
 =?us-ascii?Q?WIOAcbCyzJwlSRd+ioBYKYnB/HpPfsjeSiz4gZDAve0H6jEAzdgQHTxkRiSR?=
 =?us-ascii?Q?GOALLEnzjD3Hvo+UNStxTAySP6St5V6x99PBNiTSMUy5oIBZ0i7zHIqyT3qR?=
 =?us-ascii?Q?XJiilKY3uTLX15hVxuzZLbfi/7qMQwa/P5Je24IdIfySP1tvoe6Yn/nvd4WM?=
 =?us-ascii?Q?DGJp7zrCY6Ud6wyE682lhhCwx+PvmCFEGENRf6xBKbBDHiuEdPItZI67ZWli?=
 =?us-ascii?Q?4sMmC+8QIeU/MX4Lq1gkob8q1foatFvupdWtedv8bIHN7d74baNlpmerOxiU?=
 =?us-ascii?Q?5K3qcfhHxEtElnsU0/5mAPTJ6HUR8ldQdnkYQXLPKlg+HSQtuc19zmXGNtmi?=
 =?us-ascii?Q?e/yMbe1PihRqGsFsuHdRxcWGHqmoUZPGt0P05rUs1DNSdkIQJx99LK7MgWF/?=
 =?us-ascii?Q?bW6By1TAzjLdYYYG74IdfFnhCw9EzGlFY1mUmMyqvAY0rJZIRooGxrKX6kop?=
 =?us-ascii?Q?AqsBl7RPeXd6qARokpqy+uFoOXmUvC+HFS/k5YAOPnAOU254eNoQuzpaGFJq?=
 =?us-ascii?Q?pXVyzkvkJezOesQ5Yftw0qlBpkVYWL9fB0/MniQiexhv2fqMG8mqus79A/sB?=
 =?us-ascii?Q?EUSubr8bRkOAzpGgupWcwvZAClmH2g21YPi0yS5tGUuzf89DJiJ1Xx8LMfsN?=
 =?us-ascii?Q?R8eppsddlUUveVpj4ojA/tClw1imH57vvtJnPbhL/66AIRXJ7CqdKYNUkVOq?=
 =?us-ascii?Q?HQbYTiUfVFdl96S0WSDAoLAkrVTdjRncv8Sy/0jWwJr+sBNbvKiR6IHlbm5o?=
 =?us-ascii?Q?sz535wpKlKH8Du8wASlSMPBG6APuhdyWzwygJVoOdTFclhdwQJJ6HCHogJJ7?=
 =?us-ascii?Q?qe2faHttKKTjcKpCjBk9j1X/rAa68zr6O9xvA/4PANpkyuC4N+Hxw10FHoDp?=
 =?us-ascii?Q?5CNghd0zZDxqoCSbfZsJ8AhovjZrwd21h6YqGeqXdP9UFuByXJA3Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ip5xnCKZoYYvKNJI6LOSRaoX1DXnxTCiMB83BDiu3QvIva3/wJv7NMhVX2Tw?=
 =?us-ascii?Q?5HZcgAfG3Q9Hc00jWJ41Wb6V6EGP5Chv7jdGFNKEYpOmhqAz488rireEXsbI?=
 =?us-ascii?Q?hjMqO2Kkc4T6lSjfEYx+N9Oz0XtLFKS/NXu814LJUWe33UAk8t6Dpe1UjYXR?=
 =?us-ascii?Q?iTmfMfn6TU7yId42kIT3sWKZDTrDHJjMbMLHohaErLT7OcIWvJx7cJC+NmQm?=
 =?us-ascii?Q?Wi2AAbqzdiQPOIEMAOTNZYFXhzuJNFZUsDroxSbqtCPL9rb6CJnEpDcGL7tG?=
 =?us-ascii?Q?f+lCJTHnaiD4YLzmavBNxOxgou/gi/zZn3rQe37iCczU7ofblkmfNSw2b6uC?=
 =?us-ascii?Q?vl4F1rfguBxxQ/O1kLSrz0e4xOSsWOfHqa+6ZyCXj/fhLWS6s8mi9WGk054g?=
 =?us-ascii?Q?8vwqAcsWxMdzSSlTtjjtXBmJcP8qWRTRLcoTCTNSj26KvOCbweg8py8J6YZU?=
 =?us-ascii?Q?KbvFffjrrAeYvpjPGQKSvThwFUmFTl9fLPoh4Rs1Akw7Qgb1FN6da/UvktKS?=
 =?us-ascii?Q?udPIQsundQj551f9TeL++8pXRTo8vqPScASqCoyWo+GroJNOEFE7f++9llly?=
 =?us-ascii?Q?BjSe0LKPR84LJ0salMfiQ/WiDH85TiQxNSSrV3q3J0nhk/vUQJoymXZFoq1q?=
 =?us-ascii?Q?/2DA2etGKeIUlatnZXD7n36YowJ4B/yt4LWB4Rif5LYoAD/DcDvoRkwamKcf?=
 =?us-ascii?Q?w2kbuvEKkd1NSTgg0/jFRH7/yXQplwe6wVfKFnZ2NvtSd+15v4KurCFUaF8u?=
 =?us-ascii?Q?8j8OI2padYGqnSAXUMkBqIsmTzMpj6PEk6EyAqnS0TyT9abVf9fNEfCOperJ?=
 =?us-ascii?Q?1KpUYV4r/dLM4DGqZFuEzk+SgvnXNW1xHd4NRRk+zpidjfh+Atb44gFDLDTo?=
 =?us-ascii?Q?xKtnJu85WTmeXehetJTVCY3bCD9BogIGSfbs2L/B8UblGO5oEAwQn/d4dIXR?=
 =?us-ascii?Q?0eXwLjH5W0ZRb6tzklLXnimjLh5fdV4QrZ7YEZ4XSD4rUOjUVOnFxUHf13G5?=
 =?us-ascii?Q?/PatVr6GFizYqcd2RLfyMxYAY27nWIqd8yawesNaIHb2cGgK4pfil8DTEhtO?=
 =?us-ascii?Q?KNmRRlkjFfvxMVS8eSAmzGOxoFB+o1C+To3NlTRb7tBUSq3YfmkjZa4dhRQt?=
 =?us-ascii?Q?EnkTnWWWrEBjD71jRBWcCnvVt/G0JT6C908AJjcljsRp2vYnvT8lTiUXn181?=
 =?us-ascii?Q?itqXfmwzbAz9Y0cDF7yY5qHMtkxBAtDW4pcYK4ub5QsgkrCV0SJBBDlwwIem?=
 =?us-ascii?Q?rDobNF7BLjxUog3u5ISgopDvNoWzDsgZ2EKa2qrX8Jucsf8NmrkKUjaJLafw?=
 =?us-ascii?Q?TsYn/o8PFsM3baot6ecpeBHfLe66YGjgMPHsq2fO/cdfbrKN+ZIs+do/IN4t?=
 =?us-ascii?Q?+IN6h8wvcBbt2mCXSJWcXkz6EadlrYXVQu1AeTqvKlJoM4YZkJIfPljIQuQA?=
 =?us-ascii?Q?CQ9HXFszBF7QgpMDSuiWpQ8F7jZ/ceDoDab5rXTemYwC6ggjYHbnanxz0niX?=
 =?us-ascii?Q?OEv5nWIWc4lCsoo+qe8ya9wwhRFy1l7r2IjbHcU+jIlN5a6NXnKAzwl0jhyM?=
 =?us-ascii?Q?dN8APf4eAv9TeJfjikrB51QmZhUqcyaMrRn8Q8rG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4837a1b-9fd0-426c-b17a-08de1d69ce29
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:22:20.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx2H8sNsHMvfXkUzHtyxeMfSPg02RmBKHkQGpN10DGkGOj525gGrrQqIQmeKsjL8/mDHam1WB8dETq5s8qf7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8825

On Thu, Nov 06, 2025 at 05:39:47PM +0000, Conor Dooley wrote:
> On Wed, Nov 05, 2025 at 08:33:56PM -0500, Frank Li wrote:
> > Convert dlg,da9052-i2c.txt to yaml format.
> > Additional changes:
> > - compatible string fallback to dlg,da9052 to align existing dts files.
> > - Add interrupts property.
> > - Add ref to /schemas/spi/spi-peripheral-props.yaml#
> >
> > Remove dlg,da9053 from trivial-devices.yaml.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/mfd/da9052-i2c.txt    | 67 -------------
> >  .../devicetree/bindings/mfd/dlg,da9052.yaml   | 93 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >  3 files changed, 93 insertions(+), 69 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> > deleted file mode 100644
> > index 07c69c0c6624c..0000000000000
> > --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> > +++ /dev/null
> > @@ -1,67 +0,0 @@
> > -* Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> > -
> > -Required properties:
> > -- compatible : Should be "dlg,da9052", "dlg,da9053-aa",
> > -			 "dlg,da9053-ab", or "dlg,da9053-bb"
> > -
> > -Optional properties:
> > -- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> > -                    input lines are used as general purpose analogue
> > -					input.
> > -- tsiref-supply: Phandle to the regulator, which provides the reference
> > -                 voltage for the TSIREF pin. Must be provided when the
> > -			     touchscreen pins are used for ADC purposes.
> > -
> > -Sub-nodes:
> > -- regulators : Contain the regulator nodes. The DA9052/53 regulators are
> > -  bound using their names as listed below:
> > -
> > -    buck1     : regulator BUCK CORE
> > -    buck2     : regulator BUCK PRO
> > -    buck3     : regulator BUCK MEM
> > -    buck4     : regulator BUCK PERI
> > -    ldo1      : regulator LDO1
> > -    ldo2      : regulator LDO2
> > -    ldo3      : regulator LDO3
> > -    ldo4      : regulator LDO4
> > -    ldo5      : regulator LDO5
> > -    ldo6      : regulator LDO6
> > -    ldo7      : regulator LDO7
> > -    ldo8      : regulator LDO8
> > -    ldo9      : regulator LDO9
> > -    ldo10     : regulator LDO10
> > -
> > -  The bindings details of individual regulator device can be found in:
> > -  Documentation/devicetree/bindings/regulator/regulator.txt
> > -
> > -Examples:
> > -
> > -i2c@63fc8000 { /* I2C1 */
> > -
> > -	pmic: dialog@48 {
> > -		compatible = "dlg,da9053-aa";
> > -		reg = <0x48>;
> > -
> > -		regulators {
> > -			buck1 {
> > -				regulator-min-microvolt = <500000>;
> > -				regulator-max-microvolt = <2075000>;
> > -			};
> > -
> > -			buck2 {
> > -				regulator-min-microvolt = <500000>;
> > -				regulator-max-microvolt = <2075000>;
> > -			};
> > -
> > -			buck3 {
> > -				regulator-min-microvolt = <925000>;
> > -				regulator-max-microvolt = <2500000>;
> > -			};
> > -
> > -			buck4 {
> > -				regulator-min-microvolt = <925000>;
> > -				regulator-max-microvolt = <2500000>;
> > -			};
> > -		};
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> > new file mode 100644
> > index 0000000000000..4ecd498864e4e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/dlg,da9052.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - dlg,da9053
>
> Should this actually exist? It was never in any drivers etc at all, and
> as far as I can tell any users use the -XX suffixed ones. Probably this
> is the only compatible that /should/ have been used, but it might be
> pointless to add now.

A old dts arch/arm/boot/dts/nxp/imx/imx53-smd.dts use "dlg,da9053", "dlg,da9052"

>
> > +              - dlg,da9053-aa
> > +              - dlg,da9053-ab
> > +              - dlg,da9053-bb
>
> The driver also has a bc, I think that should be added.
>
> > +          - const: dlg,da9052
>
> Is this actually a correct fallback?
> I know it is being used, but looking at the drivers I see things like:
> 	/* Select the appropriate current limit range */
> 	if (regulator->da9052->chip_id == DA9052)
> 		row = 0;
> 	else if (offset == 0)
> 		row = 1;
> in both the battery and regulator drivers.
> Might actually be the devicetrees are wrong here?

Ideally, not fallback to dlg,da9052, but need update old dts file to clean
up warning.

If you prefer this way, I can remove fallback and update dts files.

>
> > +      - enum:
> > +          - dlg,da9052
> > +          - dlg,da9053-aa # Just for match existed old platform
>
> Could you just change that one old platform using it?

Yes

Frank

> Otherwise, conversion looks okay to me.
>
> pw-bot: changes-requested
>
> Cheers,
> Conor.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  dlg,tsi-as-adc:
> > +    type: boolean
> > +    description:
> > +      if set the X+, X-, Y+, Y- touchscreen input lines are used as general
> > +      purpose analogue input.
> > +
> > +  tsiref-supply:
> > +    description: The reference voltage for the TSIREF pin.
> > +
> > +  regulators:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    patternProperties:
> > +      "^(ldo([1-9]|10)|buck[1-4])$":
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml#
> > +        unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - regulators
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pmic@48 {
> > +            compatible = "dlg,da9053-aa";
> > +            reg = <0x48>;
> > +
> > +            regulators {
> > +                buck1 {
> > +                    regulator-min-microvolt = <500000>;
> > +                    regulator-max-microvolt = <2075000>;
> > +                };
> > +
> > +                buck2 {
> > +                    regulator-min-microvolt = <500000>;
> > +                    regulator-max-microvolt = <2075000>;
> > +                };
> > +
> > +                buck3 {
> > +                    regulator-min-microvolt = <925000>;
> > +                    regulator-max-microvolt = <2500000>;
> > +                };
> > +
> > +                buck4 {
> > +                    regulator-min-microvolt = <925000>;
> > +                    regulator-max-microvolt = <2500000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> > index 2eff6f274302a..17b72a8028e08 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -103,8 +103,6 @@ properties:
> >            - dfrobot,sen0322
> >              # DH electronics GmbH on-board CPLD trivial SPI device
> >            - dh,dhcom-board
> > -            # DA9053: flexible system level PMIC with multicore support
> > -          - dlg,da9053
> >              # DMARD05: 3-axis I2C Accelerometer
> >            - domintech,dmard05
> >              # DMARD06: 3-axis I2C Accelerometer
> > --
> > 2.34.1
> >



