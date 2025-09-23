Return-Path: <linux-kernel+bounces-828151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF34B94105
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F522A42D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505952550A3;
	Tue, 23 Sep 2025 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="oGLhGyoo"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59622D4DD;
	Tue, 23 Sep 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596833; cv=none; b=nobvlaegbdlZtNMttuOf449tl+y1/GLog2kySm4n2JAZH0vjmCZWCIBisZfG+q6JgQWVAOn3rTLcWban9slKL0Yft+gjSQ0mga1EIdB1ooTmz+06v1Gtq3MRsl6HQU8eAXqRr5kniL2uF7NybbdxUFPf30ZeJAA4bT+/Sujeb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596833; c=relaxed/simple;
	bh=DWtj2aMHR3CGw+799Fzy9/MPClMHk39Me/Dt8ZvK9Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXE0g0QtdMHdW3lOYO6UkW/0Y636I0Uf8oU/Ik63Jbq9AfnnRXfhrTXg2rYekrbTHBV2PPhp6PSccEPD9vL2eXIupl0vRaD8jPhKfLLPD6bCEF76NTxqW0Fd0NTIfVH8Q0YUGP7ycU1rzJ/i5S4ihtNsPxH5uLLKeH/aFpc6oKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=oGLhGyoo; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758596796;
	bh=4NPMmXQNPhh43Vfgs8uvOVv9B0WUHZ6XpV40eYHU7hc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=oGLhGyook+I4kpE21Ln4MDRvgPfFtQZHAimn8DGUBS2EFpqNgDv5V1xZizhHqL69W
	 8Mb9L8i79QD0vV29be5R1gg4Tun1az3/5Zw+ncYm70PqNGac/PRrQyNB0mPu4s5XpB
	 Q+xWBb31+ps8yG3bD4PgiKvvJHCKpTpTu+mB4LQQ=
X-QQ-mid: zesmtpsz9t1758596790t586b0683
X-QQ-Originating-IP: qX9i0wUg26C8yleLcKZzLZ0/pKDmgU7emqW0M+Rvx98=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 11:06:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14575087354260022270
EX-QQ-RecipientCnt: 17
Date: Tue, 23 Sep 2025 11:06:28 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	"fushan.zeng" <fushan.zeng@anlogic.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/5] clk: correct clk_div_mask() return value for width
 == 32
Message-ID: <261F7D53235844E5+aNIOtLYG1NcypGqr@LT-Guozexi>
References: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
 <20250922-dr1v90-cru-v1-1-e393d758de4e@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-cru-v1-1-e393d758de4e@pigmoral.tech>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: No4GWyI4cWt6ew9iQmHdxH84kSJ8w+Ri5rgBTNHqPFQEu5t8t4nJLsIr
	KErIC45YyfWV9Uz1FbBnJ+yfKtG2fnRSgsrOcp5sL4TJIvxvefvOXExlkC7QWMsm9juAtLQ
	0VGj0Mmtq8Oqn+T0UTWvqjTxC9h078hlpT0NyHcICNWBm1V+s2GkKOfVm4BlqijmRkdLGmd
	E0zEKjyflUuZtZ3XEk48FBlb/qSphUdOcpXOOU53BplWEeeiaQ6ZYuszykVWgmbIce6bohH
	/bBsTAfcdsUoyE8Ek9OoacACdmhreWqaHQfSmBw/B2iuwItGxSa3xVMXMUfjFld72y23ZfG
	D3nro/iaJTsqs2oPI1yKCqUiHSNo78oEIJ+E9x/GZQroIaxIJhUkc5C9OPbMY4OZ6cZqJgB
	yIbNL81+vz24ifjmVSdbnEiEMy9arY7hlgThRyWM6xXen05i7jTWfW+Us5BIuoEpLm89z+h
	vpm6la5tDUqS9RMgc6AYb8YG+5DEUYSuPH27a9jzaGs5MOP2ligdSu55vBdsU3hnAPnJR5s
	XWEy9QZOn+C/+OBukx81nmMFR49MErLrCvmyjPGUi6+oKQJ2gIThiCi0RU4wYkQiRlZUsXj
	RCtFJ5iWg+ly5pvNyb/AiZ4afrLP5TVmudv/DAET4AQiZs99B8+GgOsHX+Uffc8fE3g5MmE
	kOnzP0stux+jWPa9RW1SMRMASxOB4RUwqu8EBlsPAWkpkap5H49q0s4aAmfcffbB9JlWKw5
	zq83NEToEOuqvq0Zji1TjN+JqGLyWHw1gL4sgvuI7ZK1opqv7KgF2Rv8CE79J0lO73H0/NV
	UpXwnvXxorzcW+tZfHzki+lFTDd8oLrv2BpAsQZUk8Yj144ZBTyuKVB1/krlI2pFrbwPDqj
	++pQtdQfiCanKBiRhQes3xLhDd3hibBpClQ/5mKSMJwxlVUhI0LveFvtmAsahCjYK3N+smb
	WcIW40bTHXkOSVCUi9AW94YqGyG9itgajLcC6t67jl2fniDCdEdXYpgr9kDrK+dlZS7ER7N
	uCu4zMqA0jqe+366nxiCr5FlEdQWIyV+sc9i/wXNN0+KV5oPB9rhytLDM3lUNgiG3dtD+tb
	78RqBnH8CQP5YMCaO6RahU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Mon, Sep 22, 2025 at 10:51:47PM +0800, Junhui Liu wrote:
> The macro clk_div_mask() currently wraps to zero when width is 32 due to
> 1 << 32 being undefined behavior. This leads to incorrect mask generation
> and prevents correct retrieval of register field values for 32-bit-wide
> dividers.
> 
> Although it is unlikely to exhaust all U32_MAX div, some clock IPs may rely
> on a 32-bit val entry in their div_table to match a div, so providing a
> full 32-bit mask is necessary.
> 
> Fix this by casting 1 to long, ensuring proper behavior for valid widths up
> to 32.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  include/linux/clk-provider.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 630705a47129453c241f1b1755f2c2f2a7ed8f77..a651ccaf1b44ff905c2bd4b9a7043f9e2169d27f 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -720,7 +720,7 @@ struct clk_divider {
>  	spinlock_t	*lock;
>  };
>  
> -#define clk_div_mask(width)	((1 << (width)) - 1)
> +#define clk_div_mask(width)	((1L << (width)) - 1)
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>  #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
>  
>  #define CLK_DIVIDER_ONE_BASED		BIT(0)
> 
> -- 
> 2.51.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

