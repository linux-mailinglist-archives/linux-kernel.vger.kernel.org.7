Return-Path: <linux-kernel+bounces-773054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B071BB29ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6436C18A27A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1F27E1C8;
	Mon, 18 Aug 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="xp6GF8gl"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571E27A925;
	Mon, 18 Aug 2025 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502381; cv=none; b=tMgz1zXBqZNRd02gOsxtSbmMFG1gVIT/sCbTZ7ulDnux5VdCwgBr7avw4CPMicfjcp7LRJ8h+PdQJaNeBbiYBtYaOtXkeuuCUUIBzHe/gP8v/kTlt7kDAi9RlwTwUEAolBRE9mang6sjFZJWgxEOuRGi+GZnozd2G5av+no7jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502381; c=relaxed/simple;
	bh=EPzh3NzHyqmYZ/c/XBA93Cdzlt0nsRYofywQe6RuU2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEoxkghAM5n5shnmn7eMOQBnoq2HM9rfvS7Nfvw2a4cpYop3emjBBEdmtWqPFizKIrf8dURJb0fAzcdZyaB/xIkRx1aCHUErQ1QedUOiM42jxsjtuo4eE//g9rBLyFENk9+ixyw4dGDT10LV9RLYKDpY4S6Zs6Oas9rytdNSsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=xp6GF8gl; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755502368;
	bh=hGJ5K9s0Yp8aThcYwUIFCFOisXwtrtzSiCz6334Suws=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=xp6GF8gl+MUMZ04JitlW/eTq7Fvx+VNb9uvqbTuYXkdbWLliQI6AGkxZHlrr4+1xX
	 sF6DAv89tGdii/3oyDuzQL3kSZXrj7/Zkqj6XQJ5QkVXwhjeMEjUt94e8rb5zU3fFA
	 jB8ruvsMgoikdXQUXrutQdMjezuW55VbQR1D1kSc=
X-QQ-mid: esmtpgz11t1755502366t70d98cfb
X-QQ-Originating-IP: 9nT85dNpey8gNJPRsy567TDQcjCRP7XKv8Zl8iCkjPs=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 15:32:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7156475783990062859
EX-QQ-RecipientCnt: 16
Date: Mon, 18 Aug 2025 15:32:44 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Haylen Chu <heylenay@4d2.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v2 2/4] clk: spacemit: introduce pre-div for ddn clock
Message-ID: <20058E075D69E4A3+aKLXHNNdwT-SP25i@LT-Guozexi>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
 <20250811-k1-clk-i2s-generation-v2-2-e4d3ec268b7a@linux.spacemit.com>
 <aKKKNynq-w89YeAx@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKKKNynq-w89YeAx@ketchup>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OaUS/vBL36PcajShk/mSqJzEn4iA/N+0M9yBnWC6BX874tGCaCdzawxh
	UjiZcNoahMcEYCqXNIkGR6g/BKSdUMYHoxrt9TgWLiFlEqTFX5qQjjZUFM1nmmgxy3Iss6O
	kAzLvDPOBMEomqyJwNi6Ig8PqAEZq89qWprW5UBBCH+CUlSNNh0VrghtQmmPpIHq9nzebx6
	WmjI88u6xk/c1pq7q2HKu3SJDahZEnzfEV3q0116rHknlNvGARBo+IiE1ncBh9r+jluWUj7
	5ISwcbe0teHum7uia3gwpLlM13ZmMozMHzd+ZEBf9dIB/AbNkp9yFbLH0ca/y1T9CbKNT0s
	5pxG9wZrj7I6klSVBdDGap0chplfMw8CDD6OTL67u+E+Kma+vDGKejtzodLmkqb+PaU8l5Y
	eMlP2r3zUzyyVzyte8SzMBFILnXJFdj9l9c8ODetARP8/Y1H2HnNfxslvJZmBVOkkP8oEaw
	WMcpCnmXqH0W7560PD4hT1N/QvX04vKnLW0Wo34hklWxmPxO/E1mJ8V6Vi+RD+V/3u75Nhx
	0le6tzagG9GWwFWPoVWIye2XypYyJvs4Z42AAinGiF0crvFN2vTNqIPZ+lpaflPztaJ7Nb5
	YU2onG0niS2muG2/QYz5DOmKhagPqc5jBw13ebrlMcxtlCwUDHQzUBrjCkGHmMBKHPuGg5T
	sraGpmVQgkEXEU02w7DNvGEBZZWNGmtTtBPLX90L6H49ZTMDx5GvbNnpz+yYalvyo1HpQ8E
	3dbxuWobki6yH9eDgTuuNwXjltuyOSVDVC+RjsHDcm5GKmqo8wgMCsxgVKnfc4KgmkNERV+
	j/JgAf1ulIy+E4xGdjqKGaTN/EqVDLToCxKZ9CxTmSQjhP3THVfmIYDrShBhm/ZJjxIJy2i
	FqznRxHuvmChtFZRdmLtYe00qZ80ep4mZKkrXRT1s8ihHlZLVA32VRtDLfyryB5visJur/p
	oHcyyX+4vtJDTrRrT4S8oMOUtUdXDanuo8C2LOzybRwhLQu4E2hm0SfYmyNlh4TjfJzFdqa
	I4aND5hP7JCCWHz2YZuj12GREqtBA8ZbgpH7iig5xtiNH2QEX8nRsrkeNTyhunHL4QxYVgN
	a4H3OjeST/IPHXed1VrMgmvUFme6W/kVRtKUkM7ReZfFx2XimKk0us=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Mon, Aug 18, 2025 at 02:04:39AM +0000, Haylen Chu wrote:
> On Mon, Aug 11, 2025 at 10:04:28PM +0800, Troy Mitchell wrote:
> > The original DDN operations applied an implicit divide-by-2, which should
> > not be a default behavior.
> > 
> > This patch removes that assumption, letting each clock define its
> > actual behavior explicitly.
> > 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  drivers/clk/spacemit/ccu_ddn.c | 12 ++++++------
> >  drivers/clk/spacemit/ccu_ddn.h |  6 ++++--
> >  2 files changed, 10 insertions(+), 8 deletions(-)
Hi Haylen,
Thanks for ur review.

> 
> The code change looks good to me, but
> 
> > diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
> > index a52fabe77d62eba16426867a9c13481e72f025c0..4838414a8e8dc04af49d3b8d39280efedbd75616 100644
> > --- a/drivers/clk/spacemit/ccu_ddn.h
> > +++ b/drivers/clk/spacemit/ccu_ddn.h
> > @@ -18,13 +18,14 @@ struct ccu_ddn {
> >  	unsigned int num_shift;
> >  	unsigned int den_mask;
> >  	unsigned int den_shift;
> > +	unsigned int pre_div;
> >  };
> >  
> >  #define CCU_DDN_INIT(_name, _parent, _flags) \
> >  	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
> >  
> >  #define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,	\
> > -		       _den_shift, _den_width, _flags)				\
> > +		       _den_shift, _den_width, _pre_div, _flags)		\
> 
> You changed the definition of CCU_DDN_DEFINE without adjusting consumers
> of this macro. If I'm correct, this creates a build failure.
So I need to adjust consumers in same patch?

> 
> >  static struct ccu_ddn _name = {							\
> >  	.common = {								\
> >  		.reg_ctrl	= _reg_ctrl,					\
> > @@ -33,7 +34,8 @@ static struct ccu_ddn _name = {							\
> >  	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),	\
> >  	.num_shift	= _num_shift,						\
> >  	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),	\
> > -	.den_shift	= _den_shift,					\
> > +	.den_shift	= _den_shift,						\
> > +	.pre_div	= _pre_div,						\
> >  }
> >  
> >  static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> > 
> > -- 
> > 2.50.1
> > 
> 
> Best regards,
> Haylen Chu
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

