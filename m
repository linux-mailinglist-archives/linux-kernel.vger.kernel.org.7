Return-Path: <linux-kernel+bounces-847805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D748DBCBC67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D491C3C5587
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19F23C4F1;
	Fri, 10 Oct 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="nGOR0qqT"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBE846F;
	Fri, 10 Oct 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077401; cv=none; b=LrgI0Ok6rP/qy1p8eNq/mEgtVFp/uJZe4qICkESF6dtAwRa01GmKyRAXc+TzG/W1dqhcB3payGU5WO68TGcxbVJsK7no5DaCGhSPgXQ3DuhYc+cvgCP8TitnrooKJa4EGzwsOP2TQdz9EDFIxj47t00nYvLQMrTqLR35bTj9coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077401; c=relaxed/simple;
	bh=n4JQfOCqPr0JGIkT2Rm/zXjjbCyikPgal54EzZefOzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is1jMJP5ljzggSu2TiOwk3BveDqzc3REdDO5vuG8nDr+ARIyojGHPexcWulZiE1ZOrcLWcBJIDY4JkpkxkWz0hQA+Jt8oQAyYIAWEIKrPFskm/WxO1WEHu9Tl2vUiAs8QCReKSiauL4DZlKuWs0QRhWWUCgx68taBSQY6/8vs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=nGOR0qqT; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760077394;
	bh=tm/lUilTBDw6IsADQJ8KkEhhEKSkPxGsACAkHAwgEOE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=nGOR0qqThSIuMmKYogJ+REcqbKQCx+8HCpVbGebgp/yYXfBznCeJZ30etMl+JuYU/
	 2ouTBubmFdgqo1W8Zk+NO9WTO52wNb69VCnYTS4G//4pt0ToFWeBklQcxqd3XSRp8T
	 qnxfjq6U3fDqGYlYCAsxnFk2r8TGR9p3JWT9kehM=
X-QQ-mid: esmtpsz21t1760077390td7701a8d
X-QQ-Originating-IP: oxK7XddsRt6IDGptzNKloTsRDPkLDF3OKx8EF4ZwQ8Q=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 14:23:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14211931734184312409
EX-QQ-RecipientCnt: 15
Date: Fri, 10 Oct 2025 14:23:08 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Message-ID: <08298B8B17A59AAE+aOimTFhG8DqrtfH0@kernel.org>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
 <f968ca77-6fc0-4485-a13a-2ed83a7e6617@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f968ca77-6fc0-4485-a13a-2ed83a7e6617@iscas.ac.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OYxOaBiafLsHya8luEzNc7owK3HkXZFe0kT9uHK7w0NeRb6QRoEn/HZp
	TRgtOf/x4MUNp2E2mSO5/2U3ch/UxIYWTpgD7amndxRckapyzlgYjulkWlw4Mbpyl63nGPk
	yWjeM5ZYEWSnm0b1vrmPd/7vHCThuPu1R/6oLvX7O6DwmpQXuObToIaBYi6ULO9Qpq9lvWB
	f3jlJchPm7mnZPJnJ37q8SjNMIbPPNO/a3kO472QMh22hPKYMNBM51Li+pUyVnLTLdcliQi
	eIlWYX1epPSJJzTmHYpvR4od6KDrnm74oCR4H3lfmQQawkGCsm3+NMUkqJ81tD/ejXwacQi
	k0x9scQGKTyrr4dy6LUpdEZZ2fHbHQYdTUYobeu9+QtQpAOh0mj6ecuU5dMjnq/zkwyuHzu
	AFTS5hK6ktO4+0hucKL41Blx+2aSpg+00kTZRtMY/vulhEASfhF1t097N9Vo8yxX6Uh9AXQ
	srChI9vHdLJB5DgymHu2/Irc0V0DIU/DqoXzXVsRDCWP1JcM2mTauBH3anbuIVnOMe2uYgM
	N8ObCqL1W9Ou5f09m+aE4SIndFwnFtAoa3/wPfSBRVmJMGeEJZ4f3JyQBHOI1B5DZZ3Njf2
	RV5uxZGmN4PNLHBXInLDVZVtE6A7TGRYq0sB+bVU648YasNho8fGirl/eqagatJmQjEiMpW
	n07KfGU2C9CaA6LbHjttWDjQl/O+wcZ0dFs9k+nSoH04yt1/PEWKoj830OY6qgj0c1FYFgk
	7E2eEbSNxPxgmCcMbr56S58UsMJN2TTR5AZ51sovkJvfR1Y87TKbTBB3YuGwQL3ZqrGn8Ht
	g69hjbQhQXXUZv3vkVSdFePwGH6SKny6Bq5QzprCbfnBNWEYMdE03b8zpfCfQ34wnJscM+Z
	7dH253B02XvCDY34SFydlVlr6cYyHVpP15RdfGYgt/Z0d/UU3sYLNsmtV6I/FlUNJMf9Ie9
	BcjyUDARy4SS3VYa0EgBX3lUANrpQrrNzvSpG97hyQ6qgE+g1xqlqC9I+53GK1pKHlzBB6v
	EAtzb5j7uZxadNGD5gL98Y9KQ8yrRd5Zh8q4D5YNyrUzyqywvpJOOQQvzHbFT3orlmdVZMJ
	oA4HSLAShxILe52+Xo0WaCw/gZC4XoXxSR17Bb5tvhO3fKmNMm0zfZ9srGfnYgj3g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, Oct 10, 2025 at 02:20:50PM +0800, Vivian Wang wrote:
> 
> On 10/10/25 14:13, Vivian Wang wrote:
> > On 10/10/25 09:56, Troy Mitchell wrote:
> >> MusePi Pro features a single RGMII Ethernet port with
> >> PHY reset controlled by GPIO.
> >>
> >> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >> ---
> >>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 23 +++++++++++++++++++++++
> >>  1 file changed, 23 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> >> index 89a35914710bfd15c6ad27cd8d0de7ccf62e2309..e9a53dc7a417117c82f3e467677290bdaeffc845 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> >> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> >> @@ -47,6 +47,29 @@ &pdma {
> >>  	status = "okay";
> >>  };
> >>  
> >> +&eth0 {
> > For node orders in board DTS for SpacemiT devices, usually we follow
> > node name order because there's no unit address to go off of here, so
> > for what we have here it should be emmc, eth0, pdma, uart.
> >
> > See e.g. arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts and previous
> > discussion [1].
> >
> > Also, personally I think it would be fine to just add the whole
> > k1-musepi-pro.dts in the same patch instead of splitting it up like
> > this. I feel it would be easier to manage this way. For previous devices
> > these nodes have been added piecemeal mostly because the drivers were
> > being developed in parallel, but if you're going to base this on
> > v6.18-rc1 there shouldn't be dependency problems.
> ... and also almost missed: this should have an ethernet0 alias. In the
> most common boot flow it's read by U-Boot to set mac-address so that
> both U-Boot and Linux use the same MAC address. This allows U-Boot to a
> persistent MAC address rather than having to use a random one.  
Yes, I forgot to add that.. I'll add it in the next version.

Thanks!

                    - Troy
> > Maybe Yixun can chime in about this as well.
> >
> > Thanks,
> > Vivian "dramforever" Wang
> >
> > [1]: https://lore.kernel.org/linux-riscv/CAH1PCMa35n4dnJ94-EHGrJyU3kztQYO8_v2CkD=rid466zv3+A@mail.gmail.com
> >
> 
> 

