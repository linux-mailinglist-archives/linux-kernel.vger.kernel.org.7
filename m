Return-Path: <linux-kernel+bounces-820320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C00B7E984
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBB34850CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0411331AEC;
	Wed, 17 Sep 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="lZ3SH21G"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4C248F40;
	Wed, 17 Sep 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100243; cv=none; b=WFL7USG+WZ0krfN4haDxSuApKfxW+puRssiy/97Gs+0FBc32+N44FFG4QgQbfq+2MFyy/LMQpYI5CZNLJLhAqgAtvjeUZ89mqxpx5gvOcQYD625k6j7olrX6fuY6ycVDv9r4sJ1E2ry2miiHJPCEzSm56+ZVWhY08okG90ldV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100243; c=relaxed/simple;
	bh=JdqwNzvw2pBoIaONIB69wjGL9h0RzgAuRPWTJ//+Xvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b40ZZ0NRSY2B+v30bG3COP8svdKfjQO4Vp/MQ9TdIFTjNhjHOcRXl9QUg4gnKbvGSPJ13OKdhIHYFn/kk+5xraCmHusNchIHn1AXaaK3in2a/GV6j2HqghdwpuaqfaApQOynspjmtIVcbv3p17n4Tnxcs7sUJLK8hhJCvTgL+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=lZ3SH21G; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758100217;
	bh=ri182HmaNLuB6srSO5qdmJymW/n4VZ9nIGHsaPZb9Ig=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=lZ3SH21GVQ1vqKv/sxc8Q2cnolC/6gYgtz9Ee1HASYDlV2SOw6sGQaM0ZixTcXExi
	 vNlfiN/WRQajfZACGmgKnF9574Gdqta7cscnmNx3F2Hrfhf8nWpez0Y9KncwbNY4pZ
	 VhWM5nPo/C2QrE6CZ2Sj4OWVOJPi6ZSIai1O44V4=
X-QQ-mid: zesmtpsz4t1758100215tb76441bb
X-QQ-Originating-IP: wcCz1UpCwLB1mz6bBh5/zOt98BYf3vwoeUmG1MsFAR4=
Received: from = ( [14.123.253.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 17:10:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2326041973068499152
EX-QQ-RecipientCnt: 16
Date: Wed, 17 Sep 2025 17:10:13 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr,
	aou@eecs.berkeley.edu, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <B8941D240B018103+aMp69Tod8hNbLcu_@LT-Guozexi>
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
 <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
 <b76520ff-f039-465c-a58d-8f0f37bd1664@hammernet.be>
 <A00BFAFA3FC941AF+aMp0kSc6UkR4QUn4@LT-Guozexi>
 <20250917090532-GYA1265528@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917090532-GYA1265528@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NvjhxCSDgXICR8b6IQwxKOMEBq3VnbYdQmZA5QjwSrCt2U52JDPD4zs7
	BR3IEEFSJlNYSgw5HkK+7lD/Q/L77qcrHyHrzpXqiF/KJ/yps3D31HwJ7lHSQnn2snSm5Ge
	ghFdU3zRgTfwG0IPxv4hOal9juQKSQkU97S3HpvfYg2IWlRKrtlp+hJmFYtJ+2IQpdSG78+
	NcWcjQgK6/0fIbUlBLZ0V6DYsQq0FpZ11zTNWtPyUYVHRBzJH92PnPrdwHM5J+ydK1hbqNp
	S4SzwIE1ETDf6ZRMslqtzDwlivOCzVZTkApuWRh6LDEMAk3u1xJzOG4bgl0lx7GJSdbq0i6
	05dW5N2r4WUEKJWee83J823Z668iXVTwshiXw52aF5OqJFUrxQhQe58tnRzZ26zceQ3iJnu
	Yln5bQ6x/AlZ19xpp1GN404toyk5C3DSPX/08B4fEfrfSFjEK8vN33SKaT4pRh/14vP8fbJ
	hfAgpGfhmAiuyS1wNHyDiwWUWZYaJlONDa3Ly34nwFw5afhf6/4NljneLn+YlAzEbtAL4Ya
	nVR65eRXX845Lz45/M8Tqvaww/kUp7O0L/2MBKRlle7gRA+3NtUp8wOnD3KwBWXS+57tLka
	Qf1PrJDT54VBYC7FMF/S2whACb/XklrAeCspvpKCavyVfNVgJaBRXzYpewTXUzBaXQrMRlg
	M5J7gmoy0e3buZgdHVaQl2T8/2nbvXvXYgwC5533Fw8ZNvZS4WKhCv/fO+2XmlKHdXd+T6Y
	6rSRQhZ5vUsnirJ+10uWPPwo3aP2yvAbhLJlNi53kWmqmMOrYS1TUd+S0z9yEJjVyy5tclC
	IRodznpSDQ4/mqW2kRF/E0o6Jb+61TEJmy053GtHp/sqZoXN4ZSz0T5qULe1fl5TeoR0T2H
	9T6VtemXA5LkCSAEeca9/KUH7DQTlJheuqw812DQww4VdYpvzTsSv90rG8+Y+5wo73EygLj
	Yqo+JtQ9mMMzGkWKRMFNlH05p+s1AfboFrzzpqWKzbqxqHe2bad2FVygijgCkvVY/ZISO0e
	TIydbpTiYzYzhT+CU7srC5UCFfodJDqNY5UcJXg8EL9qmcjKhsGoO1dzTZRe8H8HgsSM8IH
	7mQ/6P+rwQn6KP8sU65k4OyXw2Qym3aBg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 05:05:32PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 16:42 Wed 17 Sep     , Troy Mitchell wrote:
> > On Wed, Sep 17, 2025 at 10:17:16AM +0200, Hendrik Hamerlinck wrote:
> > > Hello Troy,
> > > 
> > > Thank you for reviewing.
> > > 
> > > On 9/17/25 09:46, Troy Mitchell wrote:
> > > > Hi Hendrik, Thanks for your patch!
> > > >
> > > > On Wed, Sep 17, 2025 at 08:59:07AM +0200, Hendrik Hamerlinck wrote:
> > > >> Add UART pinctrl configurations based on the SoC datasheet and the
> > > >> downstream Bianbu Linux tree. The drive strength values were taken from
> > > >> the downstream implementation, which uses medium drive strength.
> > > >> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> > > >> hardware flow control conditionally.
> > > >>
> > > >> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> > > >> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > > >> ---
> > > >> Changes in v4:
> > > >> - Explicitly use 0 as bias-pull-up value
> > > >>
> > > >> Changes in v3:
> > > >> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> > > >>
> > > >> Changes in v2:
> > > >> - Split cts/rts into separate pinctrl configs as suggested
> > > >> - Removed options from board DTS files to keep them cleaner
> > > >> ---
> > > >>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
> > > >>  1 file changed, 428 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > >> +	/omit-if-no-ref/
> > > >> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
> > > >> +		uart2-0-pins {
> > > >> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
> > > >> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
> > > >> +			bias-pull-up = <0>;
> > > >> +			drive-strength = <32>;
> > > >> +		};
> > > >> +	};
> > > > We are currently using the 8250 UART driver, but hardware flow control does not
> > > > work properly on K1. We are considering fixing this when time permits.
> > > >
> > > > Should we add a comment here to avoid confusing others who may run into this?
> > > > If so, I will remove the comment once the issue has been fixed.
> > > Not sure if I’m missing something, but hardware flow control seems to work
> > > with the `8250_of` driver?
> > > 
> > > On both ends I configured the ports with:
> > > `stty -F /dev/ttyS1 115200 crtscts -ixon -ixoff raw -echo`
> > > 
> > > With this setup, data sent with echo only goes through when the peer is
> > > actually reading on the other side, which looks like RTS/CTS is
> > > functioning correctly.
> > Let me clarify my earlier reply(I have double checked):
> > It is not that hardware flow control does not work at all,
> > but rather that it fails intermittently.
> > The higher the baud rate, the sooner the problem tends to show up.
> > 
> > From your log I noticed the baud rate is 115200.
> > At this rate, it might take a full day of continuous testing before
> > the issue appears (though of course it could also fail much sooner, since it is probabilistic).
> > 
> > So I am wondering whether we should add a comment here,
> > or instead put the note in the UART node.
> No, please start another thread to address this issue, find a solution
> and then ideally work out a patch for it, adding comment doesn't really help.
Yes, we already have a solution. If I can spare some time soon,
I will clean it up and post it ASAP.

Thanks for the reminder, Yixun. Indeed, adding a comment doesn’t really help here.
> 
> Besides, what Hendrik doing here is to complete the descriptions of UART pinctrl
> which is a different thing, let's not mix them together.
Yes, my rb is valid.

                - Troy
> 
> -- 
> Yixun Lan (dlan)
> 

