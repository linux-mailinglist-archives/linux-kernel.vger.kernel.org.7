Return-Path: <linux-kernel+bounces-720799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AABAFC07B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8646F1884BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18120F062;
	Tue,  8 Jul 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ha7WJgDe"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5E20A5E5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940458; cv=none; b=GQcMB4vTzrF1uPe0GgOHt9CrLu41f1y+SEpTpGPz70GkTLIpJV0K7+YQZSviVz5+1hRFwXH6jD3Rcj0TN+LgQMXSjJ4yLzvlBXQDitUId+t+qSAoKa59ZAnRtVhT4ecPfx5dry0JMdkHBJUOnsS/BXXy6K7x3lewhsqDHdTW9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940458; c=relaxed/simple;
	bh=kN2rGg2gNBfzoLzarmFrc1jj2Kw72Baij/wc1vu6ems=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvfy550S8OL7iJd6f6BnWtd9WpRjLBaBXtdfe/ndpWLukTcMrktLIHi0/QOheNrlM62ERa4uownc+um+QCpro44eVB5Z61APbcSB1ITg9EbuTxPjoL0cmiNHFnt9wO+lTMEUkpR2U0yMmP2HCh6grwovRA+cR7FANy1GpmqAtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ha7WJgDe; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940454;
	bh=kN2rGg2gNBfzoLzarmFrc1jj2Kw72Baij/wc1vu6ems=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ha7WJgDe74gsOm+qeUSIHRg1ZoYq42zJfJfEFAdPLWCIehOh1LgUHY3Lu7ki+g3VL
	 ooAPifuT5592xzW4KaZw5xgMa4XxL+qNaTjlis5u+x1SQvCv4DDgpqdWMbB8KtLLGK
	 jnio7lHVl0gMqGHN9PhT+nK3TN9DTvVaTuzhQLh/TZCHrD66aSYjhqQ0vG5fLY0Q8E
	 YvldycIztxQPZQU5Ai8h/1FqPz4xXhaL8KMHFLLk7NMQdUPh82hUvV1Ggv3/9CauXB
	 05e+Rd10x9SxSsqfmnvkBTmJ111HvMq9x3VTctmTsiKdLUqq6+fjTFHyVQMqwl79va
	 luKLA74fgVsnQ==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 148376ADE6;
	Tue,  8 Jul 2025 10:07:34 +0800 (AWST)
Message-ID: <24c957d3e63bf6dcd58b0807df79350d4b111926.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 10/10] soc: aspeed: lpc-snoop: Lift channel config to
 const structs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:37:33 +0930
In-Reply-To: <20250704182348.53808e0f@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
	 <20250704182348.53808e0f@endymion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jean,

On Fri, 2025-07-04 at 18:23 +0200, Jean Delvare wrote:
>=20
> > @@ -189,28 +215,27 @@ static int aspeed_lpc_snoop_config_irq(struct asp=
eed_lpc_snoop *lpc_snoop,
> > =C2=A0}
> > =C2=A0
> > =C2=A0__attribute__((nonnull))
> > -static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum aspeed_lpc_snoo=
p_index index, u16 lpc_port)
> > +static int aspeed_lpc_enable_snoop(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct aspeed_=
lpc_snoop *lpc_snoop,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct aspeed_=
lpc_snoop_channel *channel,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct a=
speed_lpc_snoop_channel_cfg *cfg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 lpc_port)
> > =C2=A0{
>=20
> I'm confused by this new calling convention. With lpc_snoop and index,
> you could already retrieve the aspeed_lpc_snoop_channel struct and the
> aspeed_lpc_snoop_channel_cfg struct. I can't see the benefit of the
> change.=C2=A0
>=20

My motivation for this choice was to isolate the association between
indexes into the arrays to the call-site of aspeed_lpc_enable_snoop(),
rather than have that information spread through the implementation.

I considered the approaches you outline next before posting v2, so
while they have their merits as well, I'm going to chalk this one up to
personal preference on my part.

> It even forces you to add an index field to struct
> aspeed_lpc_snoop_channel_cfg, which would otherwise not be needed.
>=20
> If you prefer to pass cfg instead of index as a parameter, that does
> not imply passing channel too. You can get the index from the cfg (if
> you decide to keep it in that struct), and then the channel from index.
>=20
> Or you could even pass only the channel (to be consistent with
> aspeed_lpc_disable_snoop), if you set channel->cfg before calling this
> function. Again this implies keeping index in struct
> aspeed_lpc_snoop_channel_cfg.

*snip*

>=20
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Enable LPC snoop channel =
at requested port */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, HICR5, hicr5_en, hicr5_en);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, SNPWADR, snpwadr_mask,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lpc_port << snpwadr_shift);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_set_bits(lpc_snoop->r=
egmap, HICR5, cfg->hicr5_en);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, SNPWADR, cfg->snpwadr_mask,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lpc_port << cfg->snpwadr_shift);
>=20
> It is a good practice to align the second line on the opening
> parenthesis of the first line (as was done originally).

Thanks, I've fixed this up.

*snip*

> > =C2=A0
> > =C2=A0static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> > @@ -339,6 +326,8 @@ static int aspeed_lpc_snoop_probe(struct platform_d=
evice *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static_assert(ARRAY_SIZE(cha=
nnel_cfgs) =3D=3D ARRAY_SIZE(lpc_snoop->chan),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0"Broken implementation assumption regarding cfg count"=
);
>=20
> Both also need to be equal to ASPEED_LPC_SNOOP_INDEX_MAX + 1, right?
> Otherwise the loop below would break. But it turns out that both arrays
> are now declared that way, so it just has to be true. This makes me
> believe that this static assert is no longer needed.

My intent was to convey that we require the arrays to be the same
length, as opposed to being declared such that they happen to have the
same length. It's a property of the design rather than the
implementation. All static_assert()s should be obviously true; IMO
their purpose is to communicate requirements and constrain change.

With the view to getting these patches applied I intend to keep it.

Thanks,

Andrew

