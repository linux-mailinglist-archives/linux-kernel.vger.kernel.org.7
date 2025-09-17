Return-Path: <linux-kernel+bounces-820268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABBCB7D491
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9811B162979
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814ED2C08AF;
	Wed, 17 Sep 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="GWr1NQsv"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6130BBAB;
	Wed, 17 Sep 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098615; cv=none; b=oM0jf5tY7K1LT3p0SuUBRYnx/Nao8dHX0H3GY5W2yUxAHmh6OWjv58v3gJu+LSsF8/G9S3hyCcsQz26lh66Eian+zc/G1IFETJlg3hm8e5qJZTWx0HhOeFlu4o6LPInzcGTJEH5+yRswtrGlhQg9xl7u6NpyqrzH4+lbmRRvcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098615; c=relaxed/simple;
	bh=a8i86YKYXkr6knmxXQEBovk/b9pf5tLiYkXaqtMI3Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEu6YxtXwkTeIBdvgri9R26qFel851QiGmhS7yySGJp9t8IDc2h1SOCDcxX1ixD6i9b6L6WyPAL3U43IhLgoQ3b4q5zBqkBh9Nn1EkxgcokPGCzZADU9D0vmInpVSaUrq9cOkRhrDHxu/ZFvUyaV6iPorwAhsOxPbe5rIT2owas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=GWr1NQsv; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758098581;
	bh=eAKrV9C0nPNTZBS+NWN0knY6QZpHJEt8UIc7f2QSHUk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=GWr1NQsvRsQq2e/4fS4bz3stAyBCFHEZ+se31TJJArUbThPX67FPAKWsR0tlxC191
	 JYLmIUT8k9gG2Ka2iXuWkVXAW1HtD0KRBHItm3THadZ5t6uRzB4qQhLctwPRChx5Es
	 nybcPiSspKHA5lIZW8bJrSK91nRg78sV9Piu3iwM=
X-QQ-mid: esmtpsz16t1758098579ta10142e2
X-QQ-Originating-IP: Ha3YOvxStlM2nRz61S7NoShja4uIqXt3oB2AhlNNz8s=
Received: from = ( [14.123.253.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 16:42:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 211403169003842107
EX-QQ-RecipientCnt: 16
Date: Wed, 17 Sep 2025 16:42:57 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, dlan@gentoo.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr,
	aou@eecs.berkeley.edu, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Message-ID: <A00BFAFA3FC941AF+aMp0kSc6UkR4QUn4@LT-Guozexi>
References: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
 <F213A85E78015F1A+aMpnVc9S_ynYGDF8@LT-Guozexi>
 <b76520ff-f039-465c-a58d-8f0f37bd1664@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b76520ff-f039-465c-a58d-8f0f37bd1664@hammernet.be>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MLyssK0sPeZUniRdzRrLHqiAC2a+8Rcyg4R3w1UmctcYSvjW5AFt1Rk5
	MXk7cAVZWf4STWr5PVM5u+J9J/GzpfBDnX8IJKLUgKBNhOp4R5vR0lIYHWQB14dPI5KsTsV
	x2w0rRuTJJPWmZAAUA2B15FJCMufBBiJfMmnqkt2dTcsvD7bdSY6K02ckgBOnkfvEXj4RiC
	R5+DfVFuaCRmPGEDH7BLcwMlyfWtwXBiaAIxKLq1ZTCo90EiOJG53Je2M75D42jeaFzCk5W
	A3NoSsgbZI1JDh6xxlKNSVNwUglb8jFpqg029WJcye7eCvTAwKek98azgx09wnVn9YSjtrC
	OOsJo6ZjBaHTVkiN+VQqn/Kw472nJVxUmqpxX/p0HuC/QznKUQlXRVhM6EDB2FDQvWTdDr0
	wnuJQiHWGt4GOU7zyZ+jhejebz9jES29DSG7dbOqpkLv/et26w1lTG8DyVwsk/qw19BVJd+
	O5PumntW0uYEo4VlX/8Ed0O+rQeet0UHpij6vfOGR/6CEA9XlFt3YnHMjG/voO3nKXSCZ6v
	Tfl16UewhWrXOPJlUlPfubcTrYCMXhRPqXz9A/otFMW5LhvIILZGNcr7XmGB+kr0d3NQzRS
	5J9XnrvZ4Awskj5S3B1VYvSLaOghTZbHwIUEX0ZIcU1n/MhGv5hJJtS6TNkp4Y3v2M6vn/Q
	srGJN1MXMPGrm92TDOebCWhiA7qiWsLpJWh9pmzGVnb3daA1XzWpKaSGVgeaitZ/7iCSaMj
	MJw/0KMTWwwAtG0GbLE+x2OgyatFo7gB3mt+e89vgjMlGdFnZqtKFy7bFzhMgHaPoTVvFkt
	6FDXnCkdZ/+IkI001ck5Efj4x0mD8IMiNuCVtbAIJMuARY10aKvalEIjDcl8QH1qxc20nyw
	1Fmu2WRwcJ+QyysQKLTZCTUKwx1QpeaHyT3/JeDFq7b58vO+tHZdCZEGiMb+p6i1c1R39P8
	WSz8hUeFzlJ/KTQ3QHYVK+iJfwvFoOtqBuZBWeeFoii5SxIzRWlsaKX6eop+MZb41nyXMWq
	cchS9EacatOsCNjoRaHr5QkYiX3K1By8wUL1coVL+j8Vgza8yNVWMgU6BoqKyRypg9zXChs
	c4zID2E4GG7
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 10:17:16AM +0200, Hendrik Hamerlinck wrote:
> Hello Troy,
> 
> Thank you for reviewing.
> 
> On 9/17/25 09:46, Troy Mitchell wrote:
> > Hi Hendrik, Thanks for your patch!
> >
> > On Wed, Sep 17, 2025 at 08:59:07AM +0200, Hendrik Hamerlinck wrote:
> >> Add UART pinctrl configurations based on the SoC datasheet and the
> >> downstream Bianbu Linux tree. The drive strength values were taken from
> >> the downstream implementation, which uses medium drive strength.
> >> CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
> >> hardware flow control conditionally.
> >>
> >> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> >> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> >> ---
> >> Changes in v4:
> >> - Explicitly use 0 as bias-pull-up value
> >>
> >> Changes in v3:
> >> - Added /omit-if-no-ref/ to pinctrl states to reduce DT size
> >>
> >> Changes in v2:
> >> - Split cts/rts into separate pinctrl configs as suggested
> >> - Removed options from board DTS files to keep them cleaner
> >> ---
> >>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
> >>  1 file changed, 428 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> >> +	/omit-if-no-ref/
> >> +	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
> >> +		uart2-0-pins {
> >> +			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
> >> +				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
> >> +			bias-pull-up = <0>;
> >> +			drive-strength = <32>;
> >> +		};
> >> +	};
> > We are currently using the 8250 UART driver, but hardware flow control does not
> > work properly on K1. We are considering fixing this when time permits.
> >
> > Should we add a comment here to avoid confusing others who may run into this?
> > If so, I will remove the comment once the issue has been fixed.
> Not sure if I’m missing something, but hardware flow control seems to work
> with the `8250_of` driver?
> 
> On both ends I configured the ports with:
> `stty -F /dev/ttyS1 115200 crtscts -ixon -ixoff raw -echo`
> 
> With this setup, data sent with echo only goes through when the peer is
> actually reading on the other side, which looks like RTS/CTS is
> functioning correctly.
Let me clarify my earlier reply(I have double checked):
It is not that hardware flow control does not work at all,
but rather that it fails intermittently.
The higher the baud rate, the sooner the problem tends to show up.

From your log I noticed the baud rate is 115200.
At this rate, it might take a full day of continuous testing before
the issue appears (though of course it could also fail much sooner, since it is probabilistic).

So I am wondering whether we should add a comment here,
or instead put the note in the UART node.

                    - Troy
> 
> >
> > Anyway,
> >
> > Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >> +
> >> +	/omit-if-no-ref/
> >> +	uart3_0_cfg: uart3-0-cfg {
> >> +		uart3-0-pins {
> >> +			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
> >> +				 <K1_PADCONF(82, 2)>;	/* uart3_rxd */
> >> +			bias-pull-up = <0>;
> >> +			drive-strength = <32>;
> >> +		};
> >> +	};
> >> +
> ...
> >> -- 
> >> 2.43.0
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> Kind regards,
> Hendrik
> 

