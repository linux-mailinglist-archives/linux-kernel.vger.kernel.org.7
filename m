Return-Path: <linux-kernel+bounces-820315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E29B7E3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4661C071BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E830B523;
	Wed, 17 Sep 2025 09:05:38 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B963093B8;
	Wed, 17 Sep 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099938; cv=none; b=UFOFCH6BLK2bLUc6LtjjJw6GueSvorGCVQI2k0p28U1FFjbSRSQNdIscf+GxW3vFDqpH976gBILjyqyX9A36GMUzCTs9J5T5n8tbGMfcO7XLitwexMR+cHOgC1J1/ANEM6yw7ee7zqCQAnSL9DrbwvcQjLDK44XGkflEo1aQD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099938; c=relaxed/simple;
	bh=dmmvGJe32wRJBDb1N1xG/Xr8pHkbI7gEJtrOH+aUo00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDcPvUJOeGR83K2K4zxlQ6xyZ7JXmMQkRDYWABjnlj6cOYTR4kWXp4/ePKPpsmuEom3c26ooAH3aXPq0YY6cx4f6RegRKMkpEPEg2FHwbx9Vj5GDYO/Ye9tUdGx9sYbDVLn8AdrJkomo7aT8nxtPU128+Zw/CTQ6OkoeJO4YqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2D9C6340FEC;
	Wed, 17 Sep 2025 09:05:35 +0000 (UTC)
Date: Wed, 17 Sep 2025 17:05:32 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr,
	aou@eecs.berkeley.edu, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <20250917090532-GYA1265528@gentoo.org>
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
 <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
 <b76520ff-f039-465c-a58d-8f0f37bd1664@hammernet.be>
 <A00BFAFA3FC941AF+aMp0kSc6UkR4QUn4@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A00BFAFA3FC941AF+aMp0kSc6UkR4QUn4@LT-Guozexi>

Hi Troy,

On 16:42 Wed 17 Sep     , Troy Mitchell wrote:
> On Wed, Sep 17, 2025 at 10:17:16AM +0200, Hendrik Hamerlinck wrote:
> > Hello Troy,
> > 
> > Thank you for reviewing.
> > 
> > On 9/17/25 09:46, Troy Mitchell wrote:
> > > Hi Hendrik, Thanks for your patch!
> > >
> > > On Wed, Sep 17, 2025 at 08:59:07AM +0200, Hendrik Hamerlinck wrote:
> > >> Add UART pinctrl configurations based on the SoC datasheet and the
> > >> downstream Bianbu Linux tree. The drive strength values were taken from
> > >> the downstream implementation, which uses medium drive strength.
> > >> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> > >> hardware flow control conditionally.
> > >>
> > >> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> > >> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > >> ---
> > >> Changes in v4:
> > >> - Explicitly use 0 as bias-pull-up value
> > >>
> > >> Changes in v3:
> > >> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> > >>
> > >> Changes in v2:
> > >> - Split cts/rts into separate pinctrl configs as suggested
> > >> - Removed options from board DTS files to keep them cleaner
> > >> ---
> > >>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
> > >>  1 file changed, 428 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > >> +	/omit-if-no-ref/
> > >> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
> > >> +		uart2-0-pins {
> > >> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
> > >> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
> > >> +			bias-pull-up = <0>;
> > >> +			drive-strength = <32>;
> > >> +		};
> > >> +	};
> > > We are currently using the 8250 UART driver, but hardware flow control does not
> > > work properly on K1. We are considering fixing this when time permits.
> > >
> > > Should we add a comment here to avoid confusing others who may run into this?
> > > If so, I will remove the comment once the issue has been fixed.
> > Not sure if I’m missing something, but hardware flow control seems to work
> > with the `8250_of` driver?
> > 
> > On both ends I configured the ports with:
> > `stty -F /dev/ttyS1 115200 crtscts -ixon -ixoff raw -echo`
> > 
> > With this setup, data sent with echo only goes through when the peer is
> > actually reading on the other side, which looks like RTS/CTS is
> > functioning correctly.
> Let me clarify my earlier reply(I have double checked):
> It is not that hardware flow control does not work at all,
> but rather that it fails intermittently.
> The higher the baud rate, the sooner the problem tends to show up.
> 
> From your log I noticed the baud rate is 115200.
> At this rate, it might take a full day of continuous testing before
> the issue appears (though of course it could also fail much sooner, since it is probabilistic).
> 
> So I am wondering whether we should add a comment here,
> or instead put the note in the UART node.
No, please start another thread to address this issue, find a solution
and then ideally work out a patch for it, adding comment doesn't really help.

Besides, what Hendrik doing here is to complete the descriptions of UART pinctrl
which is a different thing, let's not mix them together.

-- 
Yixun Lan (dlan)

