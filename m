Return-Path: <linux-kernel+bounces-874954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83FC17BED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29AFA4F3020
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE52D97AB;
	Wed, 29 Oct 2025 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fuf3whdF"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C12609D4;
	Wed, 29 Oct 2025 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699911; cv=none; b=HWagVsyyVw3mQ96B/nw0FJaqCRmF+7DYJTTOtxXyipY0FX2BywgTiZFYkcbbYKDxR5imi9Qwrxt3+knijnjK3vuOO+YdNZf8nRZiI3+rODpXBLb2T/yqCoE5NDggr+9RkjzAGysG5lbWuUW8hwtSzyu1VkLRr94TFGQKs/eFmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699911; c=relaxed/simple;
	bh=NJjvyvfgKJfTUHiq8JgYMwcQRN5gc8bcfferGDUhiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNt20MFpZQsSxS6tstk/eSCOhuMzbQ8bKY9zCmSsC2PJ2tHDWvsymf8mUom4l5/qNoTIhBiuJuY8YfYdhB5+CS9y7IgKzd73Lk4pCBnPMm9ZOhSZwFnTKCehZgYGNl0wxAJWeV4Wbq5MDNLHdmROz1WwXc9ktF7Ad357WNgkTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fuf3whdF; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761699826;
	bh=WhJq3Ipi1fnHde+8mqcuR7GcMe5QQYJXmTD2tu08/bk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=fuf3whdFbHh6qrUHjLsaIs5jmpVY42jdMsHK8hMiW51zk4xaHisUDNbGj92mM1TOj
	 wLO94+iGZHGmpCblqSpKzzHAwIhq0jBE+ZmjPu1bw/rPKrDDGNu6XxNewU2Qfr2V8N
	 kWgd0sMxx/sz3AmQj/TmLIEuxHQXmq7prORw7BQE=
X-QQ-mid: esmtpgz14t1761699818t16bf4f72
X-QQ-Originating-IP: 4PI68DuhWu4P70idAW3AQJNj1pCz19XsCYRw2ixuntQ=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Oct 2025 09:03:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11185435277983628578
EX-QQ-RecipientCnt: 9
Date: Wed, 29 Oct 2025 09:03:37 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Encrow Thorne <jyc0019@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH] clk: spacemit: fix comment typo
Message-ID: <B07B2D0180A31C0F+aQFn6XlzuhgGRnWq@kernel.org>
References: <20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ODcDgdcDagQK0jLi0Idn8OOQ9rSlepOuej7hvMXc4bjdk5Yui8m8tUy+
	cJOIZERoNVpe/jtWHzbVw00LpDJREvFZcEsSmzOVxwdvwj8mTE/wRNmnaLa2jTJQTukw1Hc
	OVyPjYBPaeHZEyLTcCfBJuqtU5jXJwUXK5gGGixygfTD2EN9J38hiicIwMkDFyVc+lbFZCv
	p21JZc95IZf1Uv0QZtw6HzM5DPwxDIAW+Ocfl3P/I6G6g4T1BNlYNRKzjsqmESr1nreYESd
	f4d1FAeCvY4wRzduKULyuJ+i7ebefj6IPtQl4Aj0VT8iKXn1wlIxHF8CK/Tem3U31vxGuIJ
	AoYO4Y1gEhNPpaLTvNowvo7btvEjtvML8K38uvCQ7nxsFejmiGffQ5nR3pmvctpb8tKeqkR
	rIYAESlU/D3r3wwd6+sf4tZyWb9B4uwdzifHMyaMk5Ngg6pLTkGQbJNQByqAs8gUIxTjQ7j
	BzPR1Bnb/c9Dp1SfsK0kt12lgy2/BlM2dcgD/jTQ5TS4+sBt/fEaLxXPZQ56O9rn/YIidxc
	lv5oDiPBncbJZ74E4akd+oxr/2QziAM8WlZNq/5xKXU3fTN6QxB3KYpmM+70+GArn2i7ReG
	7EODMVWRz0omCyVVeJvivhBisVGJ+87aUc0zo7Kz6PgDQ1RZtDg66hvYe4XtufUQSzPqej7
	1Tdeu9bxwviEwvc0xqINLQGYgpc5MXeyOjSwyz44J5Ke7RVQIvv7E7E/eHP7ClfaGtF6VjS
	yR181FenqW6naMwMCvf720DGPnnrnZvLLxA17Oqf4x3OQDzAET6M2EjzC4YpnO773ONgekv
	bGTjWuzQ99itpwXuOvTao5+MHbub8+kN6fVtuIL1PlQtLEBP+BhygoWu+OXXIMx6+IM7eNh
	j878rfnZqNxOMs0UfshFgx8x7jiLvZGm90Efn1x5wHfLPgU6nQSw7uB29JTAVm8M/VGhpYW
	HCHLoxKp9ROyh29mdKscTqqHk9pdUNiji2/RtUWM8eQ29Pk4KtkHZZ5zAML/lVoJzSeAwlw
	a3K3/jUSJjZVfm0judYBiqOySdpVo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Oct 29, 2025 at 12:05:39AM +0800, Encrow Thorne wrote:
> ccumix.h was copied from ccudiv.h and the comment after #endif was not
> updated.
> 
> This patch fixes the incorrect comment to match the filename.
> 
> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> ---
>  drivers/clk/spacemit/ccu_mix.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> index 54d40cd39b27..c406508e3504 100644
> --- a/drivers/clk/spacemit/ccu_mix.h
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -220,4 +220,4 @@ extern const struct clk_ops spacemit_ccu_div_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> -#endif /* _CCU_DIV_H_ */
> +#endif /* _CCU_MIX_H_ */
There's no reason to discourage beginners from starting with comment fixes.
Nice catch! Encrow.

Reviewd-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

