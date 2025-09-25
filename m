Return-Path: <linux-kernel+bounces-831948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355AB9DF67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF03B49F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D780258EEF;
	Thu, 25 Sep 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eoOnHwou"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B02367BF;
	Thu, 25 Sep 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787412; cv=fail; b=JdzqdQq1iMVrv9guE6FS65UYkM+bVgM0TNOkv3lzo79TPJNgxOJK1hCgQcroVLEXlg9h1+sJfCzfkj86u9tIBDAbr7f93BzuFlUQq7KT9snckRG0Bp8zRkSd3wadppUdGZR3Jxt15J64Sw7gMQ2USKcVpyHt0ne8TGjgB0oBdd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787412; c=relaxed/simple;
	bh=lxh8JyP39fpnnwKqEl9AoA9LxM1JVLeRPqNViMhmhro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MApEbp1Bw+qQiSsph9tId25TOB6eARvr7MSbIjwX6y0yO8FQ/goqatiVjiQQbX0V9Gv69TcHlgcwO6UzxXtifDr1etsuGJ0ZvzcCHtGv1TmHeN9dFWCKijKhtR6UgHxkeW/Jpt5mMlgtWaLD5ThlBD3LNF8qz2b/+3td3H3YWhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eoOnHwou; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHWsB8gmfE7qnNxMBa0KNyjuQyeg7GjYo3brbZ0A/Sp42RVbJ+s4U2zp+GpdKbgvO9CoohzbItHJYZdJF7b/k1mfw2K66lVqp86vCN6abdFrgl2SjBhVT7ZBZAMB4Ya/D5aeb36H30xIFvp1akwirPSJdbAzoq7vHwCGaeOhfs5weshjfvWvx9olQ2+LYq6sAVi/at05gVoHyIjL5zz6sHvbyl1+9PmhnAA3IUb3grguX+ZRX8m50aCXkke/Xl72V+xedYtJh1sv8dNM1asYDKb7dveJGAyXHbbZJoiid24Sdsk26eJvMYaHJDmxEpWFk6cIJOS39D+av6KGTIGjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+ibJYiSO+3dzYGHFtbVIytsobAQN9I4xVtAB34iH4w=;
 b=Ki3xeaq7neYl2EBq6HLfgY9CedZjl8Iy36KhVHRQ3YhGCphsUZflZha56PiDqRpxcw3Aw9znc1kAlQS6FuUy9lcTPuamqy3WoYhzaAlodaVaIkolwU40Xs9JAO9GGOas8kI+kVjuxswqJCSDMoK4oRkv79GdttauwcPHolkeQOy05ZT0KO4MNZJW6YdKWdIU1a5D/njvQad1w21sLW1t0PRGh0oVLJxOuXBuug6uBzamRlMw+nnumBh5rDcziuQ9jYF1snX+Hrsd+iJ4vOLCF3mTOpQYykTQ86GyhOeAOWQvsF4+cpaR5o/02Hs4VQMzgWpf/WmBfGHVgHNNmSQFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+ibJYiSO+3dzYGHFtbVIytsobAQN9I4xVtAB34iH4w=;
 b=eoOnHwouV6oqiINEDY+Bh6MuQ2bbOPOqabSdU4kNJ+2paK6kHCQ3BbIFdzPOBwCNQevfjVgPqVohgML9KhbzkSEdwxpZcvbti6ufO6ne9900Gjw/SYKj/E9CvAe+ZesOZZBiLCcv7k0LpMAuSlwvaFc0TxgKONEUY9Y1xAF/2lVJA5Qng20NXQeF6qHCTuqt0n/iO0qsqCBHeNTnFA2ozOA7nDQCtXqqcdVmlNuswxkBsglGqc2kMYXrgB67UjSQbxlS6iX9LAUtQ9kiSoe1XoZmeF5KLs4XNiNX65nsz3PUNVBdCHDeEiIupa69JHA4L5EOKbBZEkx+TCD2CL9idw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10400.eurprd04.prod.outlook.com (2603:10a6:102:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:03:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:03:20 +0000
Date: Thu, 25 Sep 2025 11:03:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250925080317.2ocgybitliwddhcf@skbuf>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-13-vladimir.oltean@nxp.com>
 <20250924135429.GA1523283-robh@kernel.org>
 <20250924154534.cyyfi2aez46iu2sw@skbuf>
 <b18dcd60-8e14-4328-82b1-f4e5c75cfe96@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b18dcd60-8e14-4328-82b1-f4e5c75cfe96@solid-run.com>
X-ClientProxiedBy: VI1PR07CA0285.eurprd07.prod.outlook.com
 (2603:10a6:800:130::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10400:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ba9b3d-d8f3-4d0d-7ba8-08ddfc09fdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?T+MigAYfAu/VlU8dLcYNT2nzrWrNT8qs+JVdAZTVZmixxSBRbwIEbyc/mM?=
 =?iso-8859-1?Q?8WJSZdGijaQ6udNnvGt45EDP4I+TU8ZuR6QKcKmmSRhhdcp/x2lOzJ0DFs?=
 =?iso-8859-1?Q?X0v8A35PGDeIZfSKOpLA/ja3fW415Wz4h5V2Redk+JEC9XI415e5Cz4JPr?=
 =?iso-8859-1?Q?O7z5VKGxH4d053WyYvGAP43/O56bum9VYsAgaDUKXNWvLtzd7ZjuFoScXU?=
 =?iso-8859-1?Q?O4WPeEKB7w8+MTbCF7mEAHJg4bBRV3893LE0X4G1q0DqfKJ8bbC1p8f/FT?=
 =?iso-8859-1?Q?rflBUFVCDt3bhGhDAO52n+S43pAMbi6wM5vQV67c0N0olY+tCglVb8bWfG?=
 =?iso-8859-1?Q?rv5frbbjRkahjlaINUXW4sUGOJglAiy23Mug+m0R5FKXFVrfjB4Gtszabo?=
 =?iso-8859-1?Q?t1+znEHoU4MUYePxZR9wi9OB7D/z9RjzYmP3Q1zuFPwC2E7WhUY8O+Foro?=
 =?iso-8859-1?Q?2yjUnB4Hl8rX1qaOqls9Y8NREkKA94BnfJdriOvzW6yj1Cbasra+9IrkwQ?=
 =?iso-8859-1?Q?Vh8GxufCMdOBEu+byjpTWfbXBFw0yRCLGiBAkSjUwcPAgo3+1yJ4SSPkQA?=
 =?iso-8859-1?Q?fD1y1Txd5laiuWpnQzAV2RbzXSK/QuvMMihPbNy6OCD342RA8wOYgwm9WO?=
 =?iso-8859-1?Q?SkU3iQKesDx54sUr6RB7zxw8yTXCQfZ39gJsuSiyeMjfYBq8bNj9eddQze?=
 =?iso-8859-1?Q?cIJJizoEVJvnwZyop32B1saQhWvHyPkub8eRuDhAebmrHlNI6qhlNd33HH?=
 =?iso-8859-1?Q?K0DlK2Bw4iX2jIaG5DJWWvw6EeaZKHZY/Yu4QV35bAj6aHoTUJDE9pi6ir?=
 =?iso-8859-1?Q?dr/FkODHnWQNeQKgTwCGj6lqc7fvXGd9OHmAnkASL9tEyCJhIdISSbS9Ig?=
 =?iso-8859-1?Q?FN9HMjMhGqtSqIF23uK0eyPdqkoMJVp2XUPwRs0oXbLKUjziEQIf5/tsOE?=
 =?iso-8859-1?Q?Sz4dLps0dcMt7kwoP9f5h9q+/pDFp4PNxgBVGalbizIif5D+XzSvzvYvKr?=
 =?iso-8859-1?Q?4Rb1IVhn225nvqoSrw/oQfgblucW2BxThr5EiLbMhZ8MqthTEQ1KDVZgtT?=
 =?iso-8859-1?Q?5lBDadkXVSk9WGpEGEVIAQ9IJv7baBl1quXB32pdQOq4Sg4Z1/AcYA7Hly?=
 =?iso-8859-1?Q?NzUdIbc2TpSiixIFqvY49nzy1yXCGnXsP/dGSoHsYr3t57wyvDI4Q45fSD?=
 =?iso-8859-1?Q?Hz9dlF1uSNhdkmww5VLsH+bHcoqYewd7QinVa22DxFcdhoyAfRTylPaUF6?=
 =?iso-8859-1?Q?gk2MJCk0m+TW7PSKpKLWtzrXTkm6xTGdnKO1m2hyLFdIPK23EnNGH2XL7j?=
 =?iso-8859-1?Q?3xsn09wqTzXIff0MnWA6a6XhTF6dBXXpzkZZHaT5sEhClAeQ0TPJ2CXYQP?=
 =?iso-8859-1?Q?gJD7RV4ZsVu1/hZ4nZCFLXx4Vxcqa4U37JbPgwjqq51G5qK97fS+ESgocO?=
 =?iso-8859-1?Q?+hHMNFF1rC2hAWv/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?A9kOB/4gUulCR134VR6gKJq68oNAc15wu2IU2wc89kMfvoI5UqFEpNJ/wT?=
 =?iso-8859-1?Q?dsT1u0b49/lmSbgB8/NRxV/NdNVwMJilOgQKmV6ppbrHLifd0P6LpOVVkQ?=
 =?iso-8859-1?Q?GXINW35S60cAUOhTNQaMf3LDNSztkIj06XHQdiJyuf8s10qfg8TFObD07I?=
 =?iso-8859-1?Q?TR5rGjbeskYp0X5hfXFDG/50rLC4dl1cma73AykN5x5ov2aZIKNXz1t0sA?=
 =?iso-8859-1?Q?uDTrId4xIWh1AmugdSMM3Zcrqtcq9wO85pYJn52YsV18yXWur1aqnK6E0q?=
 =?iso-8859-1?Q?wnBxExm3PD4OX6tivjVSV3ifaySrwJ6kBIY00StgopxNIX+GedhcMP57fE?=
 =?iso-8859-1?Q?f7VAxcFgOP86NiWprP8k0seLFKrwXcYs6qWLTifK5S5fLIcrGon7Au1u4G?=
 =?iso-8859-1?Q?jC2WxrVQXJX10RJoM1nHLYYr6rINlByem4ACS/at3R5KsuECOzaIHWxlzC?=
 =?iso-8859-1?Q?6rWGXNuSiVblQNhWhooZRMIQ1DGtld71O+Gqf102yy3rLECTn10vpnks8L?=
 =?iso-8859-1?Q?R+nDzGAskz0+vMuIUJ1lxvGx3tVFcFfK8qe4Pmd8sdNiGwrn1ElutcikML?=
 =?iso-8859-1?Q?ThBodaxaLPNBMeXc8nX280ABmJwSV0kyROho7lERgByhbTvbapHJ6xrAFd?=
 =?iso-8859-1?Q?pzbfd9ZiUT5wouAst1A4FdgBLL0uvqN/Rx/iWZ9/5EW0WuRlfw10iRzmiC?=
 =?iso-8859-1?Q?ythm1NZylucClE3JmBiTJaX9wV3wzSrmxL1w71dK7gjejftIQj5hvZMRug?=
 =?iso-8859-1?Q?f9EBntjA7bboCpKGQxcrtSZdl/jzY6wxBrwW3kK93gxJh7VbkbuL9nhxxr?=
 =?iso-8859-1?Q?Qgm97TWgfWTuSrAMkjD+caaNeF6gmDzjWc1kSoQf2h67Y37VLyVPFF4z+o?=
 =?iso-8859-1?Q?y3j0/KovY1/AySQsQk4KiPiHf9TTFZD960t9zdWFxqFCqaUxDP34Vsnw66?=
 =?iso-8859-1?Q?P3VwvuR94k/LlaVG0JLfLqVN45WEDyvS1BY7daPIoKF36Sja3mlq+19xWL?=
 =?iso-8859-1?Q?jp/lLJt8S9ZFwb6eBUWmSE/LZRHEOsnzHenhSqmmOVrotNTXyHAaOsvQ2D?=
 =?iso-8859-1?Q?1SVd5kkIIOZXpsVxyykaESL7cP+WVwyGzuhHI0PvoYJsHIM9WsVZwvyZ3e?=
 =?iso-8859-1?Q?UHcKka1MSXd6uFFFgSjeZiHicZV/ZhM1p0WfzHjfznR0tJHNRdcl4F5vmA?=
 =?iso-8859-1?Q?f/FfAVPxySuPxYij/Zp2HT4anVQcCcEc0pbEyJmRdlf9InMvyllSMqKWxu?=
 =?iso-8859-1?Q?ILm9gGD8LoqNj3pBGP7j7zPub+zJSaxNkrNx9Mk/ukfSk4IK10D9RHu8sv?=
 =?iso-8859-1?Q?A5dgQ7MOSpLxSC/vJngkZ/PTmnCZ0M74zgmAiEJxUbF6Gt9yW+tTSO+XA9?=
 =?iso-8859-1?Q?axJdlKtXN+PYa9jJqWgUwnx94YiJLf7MRSNFz/eEw0OFxF49ya+bnu5UZ+?=
 =?iso-8859-1?Q?KBS52z7QIY19a+VIO/FUs6hdVknP1gu2/NjOxiGuxCUToQDBV1YKKgOGB9?=
 =?iso-8859-1?Q?xQPACFJyTSEjYwuldx8ZNhmuZNkYwFQR5ev8BXsT0PFeSED36qpUsE/l1j?=
 =?iso-8859-1?Q?f2oHum/QVd3mEGKc1EpfNJdWguet7s+TMvhJSFANYKthnl/9QRGZ9fgGwY?=
 =?iso-8859-1?Q?laJ/GsCBhcGclBOsGSKv5oeSQERwc3dqXJE5mTkPiB3QNprOUOK5a0L90A?=
 =?iso-8859-1?Q?5EYS1Ce8/2D5q9GFWEr6SR9U+vU6LKZnO6OVbtkD+YSfxDLLhWs8aK/rmo?=
 =?iso-8859-1?Q?JCqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ba9b3d-d8f3-4d0d-7ba8-08ddfc09fdfe
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:03:20.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEmdEGfJuZSVSCLjeJc8NjZKQmcTNr2yIRQm0NlblmDwP4r42+eNlY9ul8ISeURp70NaOjozjhUeOeaQyzNoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10400

On Wed, Sep 24, 2025 at 03:56:23PM +0000, Josua Mayer wrote:
> >> There's really no difference between having child nodes 0-7 and 8 phy 
> >> providers vs. putting 0-7 into a phy cell arg and 1 phy provider. 
> >>
> >> The only difference I see is it is more straight-forward to determine 
> >> what lanes are present in the phy driver if the driver needs to know 
> >> that. But you can also just read all 'phys' properties in the DT with a 
> >> &serdes_1 phandle and determine that. Is that efficient? No, but you 
> >> have to do that exactly once and probably has no measurable impact.
> >>
> >> With that, then can't you simply just add a more specific compatible:
> >>
> >> compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
> >>
> >> Then you maintain some compatibility.
> >>
> >> Rob
> > With the patches that have been presented to you thus far -- yes, this
> > is the correct conclusion, there is not much of a difference. But this
> > is not all.
> >
> > If I want in the future to apply the properties from
> > Documentation/devicetree/bindings/phy/transmit-amplitude.yaml to just
> > one of the lanes, how would I do that with just 1 phy provider?
> I believe it is possible for a driver to create multiple phy objects
> during probe, and for the xlate function to return the correct one.
> 
> Then, whether you follow a phandle to the parent with 1 argument,
> or a  phandle to the phy child with 0 arguments provides same results.
> 
> The driver already creates a phy object for each lane with:
> 
> phy = devm_phy_create(&pdev->dev, NULL, &lynx_28g_ops);
> 
> Once the second argument is changed to a valid lane node,
> it's properties will be accessible.
> 
> I prototyped this a while ago:
> https://github.com/SolidRun/lx2160a_build/blob/develop-ls-5.15.71-2.2.0/patches/linux/0030-phy-lynx-28g-add-support-for-device-tree-per-lane-ph.patch

Ok, so because I did not actually try to prototype this, it seems things
got mixed up in my head and I did not realize it would be possible to
keep forward compatibility of old kernels with new device trees as well.

Essentially, because #phy-cells = <1> goes into the top-level "serdes"
node, and #phy-cells = <0> goes into the child "phy" per-lane nodes, it
becomes possible to superimpose the legacy and the modern bindings onto
the same structure, and have compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g"
so that each kernel revision picks its own format in a way that doesn't
bother the other.

Because I do care about use cases such as bisections with the same (latest)
device tree blob, I can take this as an action item for v3 and keep bug
compatibility with "fsl,lynx-28g". What I said here:
https://lore.kernel.org/lkml/20250908093709.owcha6ypm5lqqdwz@skbuf/
about "fsl,lynx-28g" being unable to reject unsupported protocols on
SerDes #2 remains valid, but on the premise that it hasn't been a
practical problem for the current mainline users, it seems to not matter
regarding this decision.

For the next revision I will allow "fsl,lynx-28g" as a fallback
compatible for SerDes #1 and #2, but not #3 (i.e. the current mainline
users, but not more), and #phy-cells = <1> will be allowed to be present
in the top-level SerDes node only if "compatible" contains "fsl,lynx-28g".
Otherwise, we need to have #phy-cells = <0> in child "phy" nodes.

Is that ok with everyone?

