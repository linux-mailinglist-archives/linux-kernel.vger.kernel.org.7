Return-Path: <linux-kernel+bounces-839922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E7BB2BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591EB19C3CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA762D0C73;
	Thu,  2 Oct 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="cNLrS0WP"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD91DD9AD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391379; cv=fail; b=AgDbSS96kPYkBq52VDqcvywAla8Mi9ObJYz49ETALKOATw2/5P5XPa/VhNE9HMsGDMARrtxQDdIgS0Ph2cSRpXAKDvI9IYhj1GNOBPgqoTZtDeeJQxhkwKdMp/sGshG7vADn+TXTWFlUTvDfoftAJa39kScb65gHC64waAtIZOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391379; c=relaxed/simple;
	bh=EPkRvSd5tSa+DnBNsumbTbg8yZBJph59ETTMqx8d90M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju8GeteZhzCM/Ab5t57ypC+FX3+uD02mPytxB4zS3i0nK/Dw/HV1o0kAE/9LEi/FLx+MhMzZXA6B/fJEWEUsz458NaUUJLO/BAMD4aPFqEAkArHdIzll4u0rabMvagk99RvIyOb96r28y69U2O+OBaQJAKDc4sc18L1OQ376NlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=cNLrS0WP; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlist7ChYA/U9VeEUIq/h7H1ma+vwKsMm3cKvlGH0OoYRCX0zwBYeHi6uPyU5MAisDsKU+lqwzLcLK0CsqxzLlAhUTG3VkTZXBKDeXOdrUSgNogcFhw38TsqgnXaJPEAzF77quz5X95wG+vtwALc4hoqr2JJA8woy8XZH3ecW/2RDi7kQnXP5jjey40wQ1XA+5NHEXNqrESUbBpalEcr199eIrdrdncfFptCSa5oovLB60dGh70OUKNQjCbUMVIFBAMW+nd+XkXInyF7JDFmpr8Nw6FceHEXZDhBHS6lIB3Acw28s6ZCxhhWHRoTRJsWDCMGxFaOKhGgsjfVTpNvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd3S2pGM7tli/9elqsY/9eyb8Kg99cwZpZFjog4Imig=;
 b=mX2mqOK/d1zzKgb85z6YZsD6WmeF3zC9w0JyMlahALc97KB094X/E37PYEuuHEBRDzIK4OfLPM2JOIDpjVReo5R7lVwAcbVIV7jqGq3UeguDEOooFH+jT38B3pR3u8ntSUQtzVACiZLFxIosyX/+xolHpDXqcm8Ca5eng9vu9mH+TECMWcQeYTW6jmkTHqtzSYJT7jM891dfD+ss6kjEaN2UGDKmrVqx30BOuZeRTU+rVZUujKOwijSdePCEj9EBhgbbjHiKIcvYdZvEQjS6om3lkRPzxjjFWn/zUzqo0SuWphSboIu8yZaFSLS9JY0pY3kfFwpsLuNUz5kTr+K8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd3S2pGM7tli/9elqsY/9eyb8Kg99cwZpZFjog4Imig=;
 b=cNLrS0WPeqAOPdWe+XwXkz2CBELVDOAoF3fjPhAR37/EJmIKeiPKy6zuOP4/oUJI66Zfo0wdwkkfjrfBH53oFo+AR1Jz82+KG4Du4KWlPGKHx0wzam4HXtS7e5Z0qnJr3lBfYaehtOH6r8WlI9hbXu4telTAtQ8gxHF76lSGL6J06EmL051sfMEsRRJPlTztXD2gHexuVWRgwMdKs/fSii72RaOj6RmiTRdFR0sz/KdtEGVN6b6/YAE2fbatpd6Y6+ozZxkETHszFPHDzKPRRvLA8yewJprQkI5pzYcXv4TnMa9ydAkEiEDkLVNNvPVPFjw0BN7ynq2vYQajRH13Dw==
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 CYYPR22MB4264.namprd22.prod.outlook.com (2603:10b6:930:c3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 07:49:35 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::ed) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Thu,
 2 Oct 2025 07:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:49:35 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 2F7D4D04D5;
	Thu,  2 Oct 2025 10:49:33 +0300 (EEST)
Date: Thu, 2 Oct 2025 10:49:32 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <aN4ujFg_uRufUXn-@zeus>
References: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
 <aN0mqU75onKEYSDg@zeus>
 <aN4oad5e7YUNaR8w@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN4oad5e7YUNaR8w@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CYYPR22MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a4bd71-bca0-4b69-60c1-08de01883b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|30052699003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKsZSFfCBg/lY0aeP+JAHvdpxHSi2cwn9tz4IOF1rFU5dV4kUxU+gD7CpkMP?=
 =?us-ascii?Q?lrbW4Sbof+n01UMCD4j/ufJRhIhwBtZFB3qhYPUJerM0brudtdnxc4ZDckM4?=
 =?us-ascii?Q?9VtDtwQovJZER7c49TZrKmcXJx4032+mgpokaZ94oVFKiaC8O0PSCihQ2kzQ?=
 =?us-ascii?Q?HAhlKsNZUZD8pS6AGsV6erykp4x0azLPwBjTU8kE+0QDTWCsKA8CfeIIbs5w?=
 =?us-ascii?Q?ImvnLPK4SsngMvgbpwvpH9QBefniHr0AOWYjAXfADC7YhyWnUY/qgBPH5FXV?=
 =?us-ascii?Q?4/JvAxa7t6TbjC1M/Ct3FPk39MlLE72oSwJULb0jOM0QgMV3TGkqqKVbJXxi?=
 =?us-ascii?Q?mEKena8TL3w0pa4Y5XFQsMaZjziKC6BAg7kmnc3fzJUJZUNVssc7y8SroxyC?=
 =?us-ascii?Q?q4EzB1H+Aj4oERRPE3/TncXiq99e8Bj8p/oXMtAO4OFx4dgLCK6oFD65DUY6?=
 =?us-ascii?Q?eLqEnPZSpQ1h2LUyUKjKc0zO+uqacNgSNBuetRoY3akli8IAxZNMlCMx3YpX?=
 =?us-ascii?Q?fMCEVHBCy8XLcLjjVm168Vwxj8tL+O1vCV6IGyAUOpG5nhaPm+83Kkdb6myI?=
 =?us-ascii?Q?BRt0XkqohnJd59AazuxJzwDEpGNJmLRFaTFdJyYtrhbKh38Dacm5OkoN2tLM?=
 =?us-ascii?Q?3lXhJt2TRgMRaFrGSuXb6WLmxjRLrL5cR8Hc7xgEhrX3NmszPD2CRBCqi6Jh?=
 =?us-ascii?Q?igL0xfT0kHmlT2Hmfs1/j7Hc2L4Mr8FEmZOFTC4NmEV7xK8g8n+1oZe5gLOD?=
 =?us-ascii?Q?OYnKdUKZqhrtT9unnLV6V4fPxjkGNDIf8USgKZDk2XYaEfUoazTVgkge/1+K?=
 =?us-ascii?Q?rH/nk8ia8MDsZSEy0KaeSoF4diMgnAiJAjVs4OrLBUKfRQvrtw4V8Cd9zesv?=
 =?us-ascii?Q?JXHnImbZcp2PYKAG8+wwXcqoI81NWLtXpdu+ieJEelBtOiIsa21Kk/Q8FGaR?=
 =?us-ascii?Q?9wYM8D4PZ3tYT7sFLC+yo3WvlgcNRWtsGKfenlWRLcBfzIgm5k5HEhwtDKwj?=
 =?us-ascii?Q?ldjBAmH/VH9NdIGmnnTE/S8voFX8Efy+UrmRtsy5jpIkrWW+eaRARJS34W3f?=
 =?us-ascii?Q?xXtQOt8CV61mRltMsCyCATAiSIhEKCl1UG6RPQzPa4xIih4lBlKrS/yQRQlT?=
 =?us-ascii?Q?McN3fVmsiBBlvUXXsMBcUvV9KQC9b1RiyrUa0UFh8kFf7je0tamtr+R7CbOA?=
 =?us-ascii?Q?m05a5PmLaO/FGqsWeZX/2Sw1sZF9eac88ghiTRiTEXzgN7Nse5dCuOrl9o6r?=
 =?us-ascii?Q?rzmoewf4qVxeLA+xljut6ipZmyh9zgpCdj7VS249rzd/rx8Ezp/LG9CRL3in?=
 =?us-ascii?Q?9VaoiGDb9QZBkB/LH1GDmlcinShEiEoCVW/LtoSzLAl7BprMdtwLa962fmX5?=
 =?us-ascii?Q?RLbNIig5DcOMcdQqUMnVi25QVij8yi3EaLQV22npP1zUVxDb6Pj68g63P23x?=
 =?us-ascii?Q?WT4i422BzAjYaapv+SJPlTQasIS9tr6dsJwFK3kWx34AWp71fSArPxHvIL1k?=
 =?us-ascii?Q?SmySFMb4ZVlLXRUHG/zyd+uy+l4acogudVP4XeyfRCXczt5qjrrfjtNLtAkt?=
 =?us-ascii?Q?HfzbGdmCyNhW65PhIwA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(30052699003)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:49:35.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a4bd71-bca0-4b69-60c1-08de01883b44
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4264

On Thu, Oct 02, 2025 at 09:23:21AM +0200, Marcus Folkesson wrote:
> Hello Ian,
> 
> On Wed, Oct 01, 2025 at 04:03:37PM +0300, Ian Ray wrote:
> > Hello Marcus,
> > 
> > On Wed, Sep 25, 2024 at 12:19:53PM +0200, Marcus Folkesson wrote:
> > > Driver has mixed up the R/W bit.
> > > The LSB bit is set on write rather than read.
> > > Change it to avoid nasty things to happen.
> > > 
> > > Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9052-i2c driver")
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > 
> > Your patch breaks DA9053 SPI communication (for me, at least) on the
> > 6.1.y branch (I have not tested on master).
> > 
> > The datasheets [1] and [2] both refer to R/Wn in the SPI signalling.
> > 
> > What led to the assertion that "The LSB bit is set on write rather
> > than read."?
> > 
> > In the original code "config.read_flag_mask = 1;", is OR'd into the
> > buffer in regmap_set_work_buf_flag_mask.  This sets the "R" bit as
> > expected.
> 
> Hrm.
> 
> I follow you and agree with what you say.
> Could you please read out R19 INTERFACE register?
> Bit 3, R/W POL, deviates from the default value (1) in my setup, which
> is probably the reason why it doesn't work for me without the patch.

-- >8 -- 
# cat /sys/kernel/debug/regmap/spi2.0/registers |grep "^13:"
13: 88
-- >8 -- 

> 
> Your datasheet revision is later than mine, could you plese verify that
> the default value is still 1 for DA9052 in your revision?

Yes it is still 1 (the complete set of defaults for R19 is 10011000).

> 
> If that is the case, either the datasheet is wrong or my chips must
> somehow been preloaded with some values.

Yes, in my understanding these PMICs are highly configurable via OTP.
(Almost every register can be customized.)

> 
> As nobody else has reported any issue I guess it is safer to revert
> this patch.

Agree -- following the datasheet default is probably the right thing to
do here.

For the future, we could consider an optional device tree property to
describe this read/write bit polarity.

Thanks,
Ian

> 
> > 
> > [1] DA9052 CFR0011-120-00 Rev 5, Revision 2.5, 13-Feb-2017, page 67.
> > [2] DA9053 DA9053-00-IDS2n_131017, page 54.
> > 
> > Blue skies,
> > Ian
> 
> 
> Best regards,
> Marcus Folkesson

