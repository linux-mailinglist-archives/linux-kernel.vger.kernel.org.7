Return-Path: <linux-kernel+bounces-734136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D5FB07D77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A76B3B0C79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557E2BCF41;
	Wed, 16 Jul 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="tXZUVWiO"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFF29A333;
	Wed, 16 Jul 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693304; cv=fail; b=BFoDf6dKumpvM5sn/z/XG2LArVdr2pty0M6mQfswVSGp4wQxi4dPL8Cmd1nQFTSELhLnhxvwpnVhkZmoZVM3qmtWY6pNr/xau8bYyovM7/9/xMHo1XOsFNHRHS63J4nk5i6ifM7crV41Pta4ILockPnH92nU4WVcL1P3/UAV8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693304; c=relaxed/simple;
	bh=IVYGvGEPL7sqtgVtO/ZKOJ63Yw195VZjieMHQjK6vPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAl3EhV4VpAA0mTVOKCpjvTMu1iuc/JfqSoc7ijFO1d+n9WDxFHTmqwCAtd0xeSW6IULR8OWmyLHdA8W6wYYRJXxEHXBZ8Q+w8XMDPMhlxV3hED7girgwyKdlTFStmByeQAnZzg1p3kB4UK+SzNThAvGWPS844hUgAt4FyHg5Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=fail (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=tXZUVWiO reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPOVQUgU9UnRMsLzgQJE+EEMDLsc5AAdMKKgI3ZKrFbZg8D0piTqUqkRCeu8MR/pjRvV33oanNK/LI5Imu+tzq6Kxg39VqXnZj9uMS996O7siWZ4WxsVpE6D4zwVNFic3VAJQDOzDh0OyF+C29TDNhZQbhp75qN3DmcoUNwmakD3SAnA0GYCCPhyOMtqkI3hOiAjsDH+lZK20MekjzSZ+AIi8u1evZQ1PEitDMW0qJFLcJ9f1/x/EsmLHsQC1PzXKRxcVN7dQPFUCq5JEtLPFZps3H9Vyi0ih7jzyXRL02r/DTPN0/bptw6Qf4JF4kj3u2gUp5YH8Du6YJ17YpkgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFBS474mWwWyzAMjIpNCm6/WO+mDj2nXwLpXPjzST/I=;
 b=cR4HILyYL4TuNCe2iiWUXZoZpv1rGxfCoJdN9CWAtgkvA7nkHLmq2NIMEUZCr1HtFvdfteZ5qS7dDiUsdAL7ezFKu8cXRjfiaaFnsK/HX7Y5CzXl/3FJGMT6Y1XqWxcQ/k/UetPeQ7978BycFWtQcCP5mfCOxc1AY+zCZxTIMtRqBlgv1yL7Ehcli5CGpXLkZAEbnx2x96H5teyWOY59DXml2GzzGyA78egR16mBias/P1IlcckS9P6SweNvgwfDyl9NjPfoLyIOBRcYCWZAPN7YdVUlYbJgNlbTC2zQBffGvd+dxBA09zyVcAv+zdVNKKQeZ2rQ6LFx9wtu395Qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFBS474mWwWyzAMjIpNCm6/WO+mDj2nXwLpXPjzST/I=;
 b=tXZUVWiOjWf0v2rsViHDsKbI2y8FkFL1X0ZO6UfY6Vw0UVcVIXRek3RwM6OYb4ran3Qav+T2pCT0GhiERnLC59Bmdiwhv9XNYl67a/4g+2CQWdoZBeGE0bKhW8IuUKCR+yow2soxPwjuKUFvG8RtFIO6IUxutUbc8NRnOfwzp20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from PH0PR08MB8275.namprd08.prod.outlook.com (2603:10b6:510:16d::10)
 by BN8PR08MB6259.namprd08.prod.outlook.com (2603:10b6:408:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 19:14:59 +0000
Received: from PH0PR08MB8275.namprd08.prod.outlook.com
 ([fe80::5d18:97d1:98d9:33bd]) by PH0PR08MB8275.namprd08.prod.outlook.com
 ([fe80::5d18:97d1:98d9:33bd%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:14:59 +0000
Date: Wed, 16 Jul 2025 20:14:52 +0100
From: John Keeping <jkeeping@inmusicbrands.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC/PATCH 2/2] phy: rockchip: usbdp: implement .set_mode
Message-ID: <aHf6LGtYiLNFRQDF-jkeeping@inmusicbrands.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-3-jkeeping@inmusicbrands.com>
 <3981131.iZASKD2KPV@phil>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3981131.iZASKD2KPV@phil>
X-ClientProxiedBy: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To PH0PR08MB8275.namprd08.prod.outlook.com
 (2603:10b6:510:16d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR08MB8275:EE_|BN8PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9cd202-7e09-437d-dc87-08ddc49d0e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JNtC8YfHBenYiR0nQrfepJFYCjcRb416W6BibDJPjgImlYrD+7LyjJmBut?=
 =?iso-8859-1?Q?hHWDYuxS+K16pSQNMrgzmpnMiP37YNJbUXMJ121Pbn9zosc9MLn/ALKVd6?=
 =?iso-8859-1?Q?3QTB/xy6fl1JlcJ3cKlO1g0ytsQ33rptWg+lcRWpNfiQEadVFru0csfW9M?=
 =?iso-8859-1?Q?Y53yVvglfQkbg18AnDP67k/DoCyyFxBfLaYYdc68dDKgx0k37bvSstXx5d?=
 =?iso-8859-1?Q?+ic+rcwpMjKZrlARfCzzNQWzHV0CtgehuhhdbJcZG1/23ldJT/GtzvObWx?=
 =?iso-8859-1?Q?MYVYY3p/bRkmPZEc1KHQQo58z05TIYsyMPPpiOhB2sZv318w2DMmWOKNeV?=
 =?iso-8859-1?Q?uRwK20XpyPzRhmC6d8oqOmes8g4mvy6Sn3jbX7/oRulr4gxcpkb/H+3phN?=
 =?iso-8859-1?Q?d7HQpwggWYd6MVTPwIjGHSFzVa+tZPAEPSKy3h4wcXqkvkkVnspZ7kpj3K?=
 =?iso-8859-1?Q?XDbiUcR9lcoGSr1XMHNoW3ngIxFJ+P9brPIpp8+haEgnvH8vRfeZJJLq0g?=
 =?iso-8859-1?Q?XczdhOH3y3V16yuE7yjg2FFBW6D4GoGFEaefCjU7GRNmXbyKBYDFwpHbs6?=
 =?iso-8859-1?Q?dbBnwyking+8XGp++M8BxDC5DVH7sW7Bqkvk63jmt+yIp+CHsLKKuDIMks?=
 =?iso-8859-1?Q?pnuIUjU5OXbLhtCuPD7nX9kkPQTATLlagYCxwA89hW/3u9JJOauTA2TnQ3?=
 =?iso-8859-1?Q?f9lxO3P5SEIoe961YUCtVDElBWDErGtVl/Wl6zHY06zMIqZI2YhAapAM+Q?=
 =?iso-8859-1?Q?xNYsJUyvK0U6wg2/3HYJjmi8rhvVBf+B90IDfUioWtSVjkfuUKd0Gftbqm?=
 =?iso-8859-1?Q?6SVCb3SONH52AmUPII88rj1GukC1YqfaJPFG7nZzBrObPIsqR/Iinu4pDw?=
 =?iso-8859-1?Q?JwYBIkdYa/BfJsZQgsJGdwjd7GSPxMU0WZFCRsK3TsO8KPDRQklyxJkOEa?=
 =?iso-8859-1?Q?6vPGd1BlHkl+kS6VbAHe2tkqlKjHrPqfg5GduXUI7vewLrmcyXkLEWUGkG?=
 =?iso-8859-1?Q?ECF2Pp1XTN1/vGEK3lTxfFzHQn4oGRjrH+LButaSfa7OcTFl3+mXjlA+DJ?=
 =?iso-8859-1?Q?iGI7X2VBsyxQcJHHKSF6pYsiJYjCjFSRzXvMi+9NR399fhpAIHZgDp4AIR?=
 =?iso-8859-1?Q?J3cHUHxVXkyLcf9kKjZjNYl2W2CIgNO4SBeGgdiju9sTHjBfeztx+WPWBN?=
 =?iso-8859-1?Q?kkFz0XgdCqkIv8OdTX7/PJnHUBmTPoB8S6iRCOyDQlBg8AH0KV+nXHnbRn?=
 =?iso-8859-1?Q?dp/ECgvtT8yEKE3HTwzcx2OYRNEZXSsUyQCC/v0WPqy1BLb1WGIHT+boDJ?=
 =?iso-8859-1?Q?h/KrpIfhCcavFKtJOMhd7dqTut/gJrHcnVIVbgUSwuqaH57J6qrdvFbDBU?=
 =?iso-8859-1?Q?ud/aNCx3bXKOv+Cb82DW50X6P9MGTLQTpK4dqHn20DNoXBS8mUmTs7+jQf?=
 =?iso-8859-1?Q?d9AGWYOHVorl6nSC6gmrf8r86oLamHugfnm6W8kIkWdTXy3gtUEvwYPQan?=
 =?iso-8859-1?Q?rwDNdW47sQaxo2l/1t/fvXR2m8gDXumKcRYhywlOrWjV9WMYjCfM47Er5Y?=
 =?iso-8859-1?Q?EM5/Y8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB8275.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?BNyt9hlGCUjNsTSAQK1E0GsvJxKZmVWFJp142cYN9SGGl/Y8kd9da+eL3B?=
 =?iso-8859-1?Q?SRyH+QNsWrdGI7zON1Bg3eWXeM2F85JHWG4RjEjD/T2YnlKQTMylYMzq0j?=
 =?iso-8859-1?Q?w1DzhrfKhPmPqeiWnoYYXvqILDURF5X0vdh6MPlxlHwYGmre4And0MTNdV?=
 =?iso-8859-1?Q?RGzicS/JWdgdnQ2reQ8w/P0Ecx/FjdCytCNTaH7UfEIY6aHBRnLM+cV2Nf?=
 =?iso-8859-1?Q?66uktQ/MW7z7hwFU3ul6lFqAxkkL3dNBhuQqV3lGHBBt/YtNkcguptUpFv?=
 =?iso-8859-1?Q?QJJeJqbWL9M3gajudq3xbuny3gYLq/vyb3/RWDdkku5W1kyqU5511fWVoK?=
 =?iso-8859-1?Q?6ttAxOjXvArppMAMhsgu+9Z5eLFa85wlHpZL5+dXRL8m4B9ttLjZD2+ik+?=
 =?iso-8859-1?Q?HhH10eoNRsiPUByH+KvHA2C5gbL9FDfKl2hdLXKb8x1MS8lbSm0tMSKtm9?=
 =?iso-8859-1?Q?lNEitWG1dRQh2k6pB9k7bkq6ruCrhNv6pzm3fJJKlIesp0MmFcvnoebtqd?=
 =?iso-8859-1?Q?n316/jZe2n3muKpwde6PLA7bf2C6NLoVaDZuDwt1RTInVg4v0RWcGBpqmd?=
 =?iso-8859-1?Q?F1oJ9nfMCHkQuDoz+EATbCIciqeXe4jk0uKGOcicSqboeqjgoNT8ALOvHL?=
 =?iso-8859-1?Q?ecmnbybhBoyjmeiFT7KSQZZRBvsmwaoCPdc04qrtxIB6w61hb1dRWS+iso?=
 =?iso-8859-1?Q?nWjpDfsE5CO3Go6PQnC8yDggPB4emwzPHeYFwWXGbC81fFOa4v4xhviP1r?=
 =?iso-8859-1?Q?RnCkhHnVUGAp48Wtcqnciw4p1oDN1W7QcXAyIX14WBsaul+ZHknkZ92bc1?=
 =?iso-8859-1?Q?hqDDYwLeixH6mz5t215jKhAVE3eeh53cXHxml+RCy/Gb5lPUgfWMz2ljWd?=
 =?iso-8859-1?Q?qscs8snxyVwUc/X0BY4gVKuJgFlWz25Uw42B70tcAl3YZjHWnn/xiWraLw?=
 =?iso-8859-1?Q?eBpzKg1cVK1IacFRnJiXjUvSXMNuPMLdoh3kh2925DeOuZeuE5idrXjRQt?=
 =?iso-8859-1?Q?4cJBbxN1gb897/Hc++f7VWDiEc/G33CQdzfnELGfEZQjqPYdrL4qxOvHDz?=
 =?iso-8859-1?Q?E9f+r4ZGQf8MD7T+9wzuaC8lUkyUpDoI0fcwGzKYWWFpvww+wcy4On3suW?=
 =?iso-8859-1?Q?N0jaqp/tnBnNuWIXKMf7R1ls3iW3O4GalOwSz73pLK+/tdmdWUdjt6v1F7?=
 =?iso-8859-1?Q?ypycBA9mYNq59RiueMdzUqCKW+glV/8XJRdggZL6t3maGCYbezlhqrdDKD?=
 =?iso-8859-1?Q?QnVagvgmDbOYsfK3yIcTw9Vv4HqB5erkGoOa8GwN2S2xVeIyvpckJbrvKx?=
 =?iso-8859-1?Q?uEvlFC4Iattxi9x5faN/nfPHHI99GGyoBxse/UbKsTbDiAXBIEp4pPlzeW?=
 =?iso-8859-1?Q?2Mya5ooVbK7QLscR2IBTbv4vmimvsQk9OT4ddcp3hvV/XyCh5Cyzb+/GxZ?=
 =?iso-8859-1?Q?yjcKzP+BCwrdgYM+3JAVdKoAOIRXqWNqp/GLlSbaeoPR7WfG4evfBgO2nK?=
 =?iso-8859-1?Q?78WvlRJkJ8CSvII7JEzHB/FxykJ14KM/F55JO7MDMUS6ziESvKI0BgFBk8?=
 =?iso-8859-1?Q?H2zqEqFJarY8lHljLkQzOA+EtctIhDiFrZF/ic8vUDmBGyeicveqYxC7TA?=
 =?iso-8859-1?Q?43PtqhNhT2ruDp7rzlERhEVAUU9vMr/W321c8T8K5czNIEiQcmlF/TyA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9cd202-7e09-437d-dc87-08ddc49d0e89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB8275.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:14:59.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ataL6TxFSFtEDXwUhTRRUjjDSSzrfjR+vs8L3uME9xDLBpADkjYiKoNU0P8zLSni5I5X1YtcSdXT5prIIGt4gDY33txzW9YWskmZH0s6eZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6259

On Tue, Jul 15, 2025 at 12:35:47PM +0200, Heiko Stuebner wrote:
> Am Donnerstag, 10. Juli 2025, 17:22:50 Mitteleuropäische Sommerzeit schrieb John Keeping:
> > When the orientation of a type C cable changes, usbdp set the new
> > configuration in its internal state but does not write this to the
> > hardware.
> > 
> > Make use of phy_ops::set_mode to write this new state.  This should be
> > called by the USB controller when it is notified of a role change
> > (assuming it is acting as the role switch) and will be called at a point
> > when the controller does not expect the phy to be operating normally.
> > 
> > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> 
> with the comments from Ondrej in [0] the whole thing seems to be
> slightly more complex
> 
> 
> [0] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250225184519.3586926-3-heiko@sntech.de/

I spent some more time looking at this and have found what looks like
the vendor kernel's approach to this issue [1].  It seems that Rockchip
set the autosuspend time to 100ms and hope that is sufficiently short to
allow the controller to suspend whenever a cable is unplugged.

[1] https://github.com/rockchip-linux/kernel/commit/5ac62b80f7471ee9858ab0459af07180de938b51

Having experimented some more, I was able to do something similar
without needing any changes to the phy driver by applying the changes
below on top of patch 1/2 in this thread.  This depends on runtime PM to
ensure the controller is suspended whenever a cable is unplugged, but if
CONFIG_PM is enabled then it should address those concerns because the
controller will be shutdown and the phy configured via phy_init() in the
normal sequence.

It sounds like Thinh doesn't like this approach, but if the requirement
is for the controller to be shutdown and restarted whenever the
orientation changes I don't think we can avoid some changes in dwc3.

--- >8 ---
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6573cca0eeaf5..b707afd38cc27 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -199,6 +199,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 		dwc3_otg_update(dwc, 1);
 		break;
 	default:
+		if (dwc->force_suspended) {
+			pm_runtime_force_resume(dwc->dev);
+			dwc->force_suspended = 0;
+		}
 		break;
 	}
 
@@ -272,6 +276,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 		dwc3_otg_update(dwc, 0);
 		break;
 	default:
+		ret = pm_runtime_force_suspend(dwc->dev);
+		if (!ret)
+			dwc->force_suspended = 1;
 		break;
 	}
 
@@ -2485,7 +2492,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	default:
-		/* do nothing */
+		dwc3_core_exit(dwc);
 		break;
 	}
 
@@ -2552,7 +2559,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 		break;
 	default:
-		/* do nothing */
+		ret = dwc3_core_init_for_resume(dwc);
+		if (ret)
+			return ret;
 		break;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4d..7e1d480c59ae1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1390,6 +1390,7 @@ struct dwc3 {
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
+	unsigned		force_suspended:1;
 	unsigned		susphy_state:1;
 
 	u16			imod_interval;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 8f427afa8eb93..16aac8384ca3d 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -461,6 +461,7 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	flush_work(&dwc->drd_work);
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }

