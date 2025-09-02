Return-Path: <linux-kernel+bounces-795428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2909BB3F1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A7A7ABEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C62DFA25;
	Tue,  2 Sep 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="NI0LSpJz"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4F25394A;
	Tue,  2 Sep 2025 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777032; cv=none; b=so/TAVkFFKOq3+zC4Gj0mYUwnrLQvpyP55HHS+RrDxxHY6QdNKJbKyilrOykk3u95bTz2EJKUtX/0Mb5d9ZCFZ91fG0BzeK9cVxXEbKPWlXBsnkMyOSNYzI9rEE1nzT+ybPukeyp2290R18gtv8monysXk1aGUh9afyhh6owwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777032; c=relaxed/simple;
	bh=RdNz+xMghh0j3/4HDoLK3CQoLwuA3tAc1tMSvN5dA0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5HYQrjMVwggO7w8lPq5+k9W7NqcmAtnKGuvkqXN7t3dhUNTLVkncxeNf3fsYvSSp1saPrR48RQ5zIrBYpsZzXItXKl+gTvrh4Z+6OdaStyr0ZEof4bA56HnWpp5oF+T+xLdPeaS6FVTwR7McHKQYQdQ4jYpMDwI6MPLLW2TMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=NI0LSpJz; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756777011;
	bh=nuRp5/zQbJKjGxE1cWeR4IjPYVb/g7agSx6QBm8LKbg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=NI0LSpJz5UzXIZWSBcJSQCZDSqxMty+GHteUZsIhUvGY6Z8mZYJRRCHQjRwdbNz31
	 ByDl78IOySsXu68WVg8gYoGVJX/9HjkVgk+N4KvyHTeLz8eAv0tbS9eshM3l/64Ngv
	 PFRlueiKgNPGxZpQ20BPy4skI1ob1pcmYo1Y4A4o=
X-QQ-mid: esmtpgz12t1756777004te7029297
X-QQ-Originating-IP: jhVh9wIS09zFuhXA6omcYkmjiTPVmGhmq1VO4+ZOsYM=
Received: from = ( [14.123.255.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 09:36:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11881375477750079152
EX-QQ-RecipientCnt: 15
Date: Tue, 2 Sep 2025 09:36:42 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Message-ID: <B3CE2A46D0298344+aLZKKpVSf2bRx2pb@LT-Guozexi>
References: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
 <20250828-k1-i2s-v2-1-09e7b40f002c@linux.spacemit.com>
 <20250829171624.GA1027608-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829171624.GA1027608-robh@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MRY6qckr/MVJEYh6A/1bgSglqKY/j5bfCnJ7weGgGKH2WiiE7gWgvwyx
	ROx3k/v9quz/qnnHZ0W+cjCLkH6iXNiat8a5QufRQm0v2kwBP1jc8KqMwRy8xCIsA2TuToP
	xLAmmivicMshqPBZaCdgi3A5vrZHGsqrN2Z9dAxy3Ml2Pu5yYNkYfkO2cG5eh25Ddt0hUR+
	bVU7hgYklwde1VOP4Gz5HBq8yHRRRUu5uZCaFB6yRb8wetQwZFDWmYPBLZfINU9FjlWwrk5
	ov5maQ2caPNapXn8SdisnUO8F9YBQwPZAkS0fEU8jvZ0jwNl0Yp0jTMsbWxkRPzL8XJOAgi
	v2xK192RpDv+TGS0sRgKt+hMPaQ98pH9DAR154YOtnWxTB0gpA1B4izkAvoWzhdjR2AUAUA
	qNS6OeF4IzMRhpsMz2SYx1m0OMVm4OxcLbvzrMYO+VXrSNMFyLsNr7x50eNguBxgrfC6UXF
	/ZuJpmIRExBk0EPj3WX06yIr5kdEG/AKviqqIBJAKjrzWr3dYzywFMBl6epgks+jMb3YQ2n
	4bQKB3XkOlUMMtr2Ve5PyaQr4vchrJr1bDuYCEL9jiBThtuNM/E9r0mZDGyyRrNE4dk5JYY
	neaq2bd0n51P0P/EnJkUb0nAV7TyJfWWg+LWPBdZy2SgxXG+YqqIBulsj5vHSrCeGuEvXLo
	aeXyLwA0UHKGFhKe8StmCp4y6dzufBwxi2YrApeVvUj1sZcD7K0+f+xqpQO2ho9OXFKh5kc
	Bf7q+EOOmOf1ChTvfcZaJ7/8Gq2bWfe6M+X2ejzZsxKle8UPUIFh3I3WWp6xN0V6IcH9MHw
	3nTu0vaAfFUKuJwCiWZY2vXPiI13W3XZf/EEgB00tGSR1TSwWsUJJckRT2r6uDr4OixlzNg
	KHyyNxeQEAvj1YDIEOwhT4UNlgaM7XuvBhM7ihDZNqpJpe/2MIIhI/l26Qhekw8wj5tpbii
	WAKkWh6GdiBJOTJsHZgCZSpuQFi8qQUmfnWNJmWHVQMwelVHZTqXMkbxstGZvQ79Cddlhhe
	41RKG5ygdqZLjmNuEU
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 29, 2025 at 12:16:24PM -0500, Rob Herring wrote:
> On Thu, Aug 28, 2025 at 11:37:32AM +0800, Troy Mitchell wrote:
> > Add dt-binding for the i2s driver of SpacemiT's K1 SoC.
> > 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..042001c38ed8d434889183831e44289ea9c5aef2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
[...]
> > +  dmas:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  dma-names:
> > +    oneOf:
> > +      - const: rx
> > +      - items:
> > +          - const: tx
> > +          - const: rx
> 
> If tx is optional, wouldn't this be simpler:
> 
> minItems: 1
> items:
>   - const: rx
>   - const: tx
> 
Thanks! I will simplify this in the next version

                - Troy
> 
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: audio-graph-port.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - dmas
> > +  - dma-names
> > +  - resets
> > +  - "#sound-dai-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> > +    i2s@d4026000 {
> > +      compatible = "spacemit,k1-i2s";
> > +      reg = <0xd4026000 0x30>;
> > +      clocks = <&syscon_mpmu CLK_I2S_SYSCLK>,
> > +               <&syscon_mpmu CLK_I2S_BCLK>,
> > +               <&syscon_apbc CLK_SSPA0_BUS>,
> > +               <&syscon_apbc CLK_SSPA0>;
> > +      clock-names = "sysclk", "bclk", "bus", "func";
> > +      dmas = <&pdma0 21>, <&pdma0 22>;
> > +      dma-names = "tx", "rx";
> > +      resets = <&syscon_apbc RESET_SSPA0>;
> > +      #sound-dai-cells = <0>;
> > +    };
> > 
> > -- 
> > 2.50.1
> > 
> 

