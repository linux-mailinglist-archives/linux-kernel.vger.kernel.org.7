Return-Path: <linux-kernel+bounces-857217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA4FBE6372
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F7FD4EE86A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB1299AB3;
	Fri, 17 Oct 2025 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="NrA2hetM"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C227FB3A;
	Fri, 17 Oct 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672256; cv=none; b=iu6d+6ztg910KuNd8D+IIwVrN+W71LCz9zr7QcxniCYktaLgSxpN/41HIfBi54fBDcf1UeTDQqS/I9risxLztPkW3jfeGaqvz70kJlGQz0d8yGQaMalcrYlMpog4Fjfi85MvFSUBsMe8H2q/wRJqi13kU5RW3suLhoHjymUoUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672256; c=relaxed/simple;
	bh=6sKxFmD7xtbhw/U6fWw/5xDqmGg+lEMB/j657bkCRcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+lOqSK/aNDBsjll22W5VconReNyNutKShTZGhXFcFEFbG0D2P5ZHcFRmV6dBcNyULBAHKi8OM1oETCX8DuO5lEsqtzfxn6NC2IVQOUA6g2toGfNSa2IA4NFTEtnFFWEWo9t+IrZF/WsmIZHlJOMZxipAmDNvLXD8gqfKAEqFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=NrA2hetM; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760672216;
	bh=oBjWx1I4AnKMBoTG5upDqtcSRJpj6kwgVgcH9gHhiWk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=NrA2hetMPmqFFX5VpPiNznP6QG+gEN5FQ0Npwqqr/HbKLiz6wkybhayL4h1d/eiR5
	 m8O8yCQN9xVCfoKwSSZrfsf5fQpCXpKqC94gyHeplIGhf3QqXXfvcS5hRkhfolud+U
	 KVqnqKGvtPqwKVUzAt3UMoz4JDzcPUQZEOTsLuR0=
X-QQ-mid: esmtpgz14t1760672214t0abf1794
X-QQ-Originating-IP: TlDX3I/w/Ks7UHXpGBXnho4hAw+exomsa25mQwPtHzQ=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 11:36:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14831178928690405288
EX-QQ-RecipientCnt: 17
Date: Fri, 17 Oct 2025 11:36:51 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v5 0/2] ASoC: spacemit: add i2s support to K1 SoC
Message-ID: <A22605E3906E8F62+aPG50wdFlFzSMORA@kernel.org>
References: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mp6z4bZjgTSTBwMUNg8zA9wA/BtlxsS9MvS/mi3uCzcjbQONLrFwQzbz
	dz5OzhjNhIXMdzbgh/z+kgzyVmiEZE1XTmMUgo+3svy/SPM2C/AcoK9jP9QO6O8klYpQmYS
	55IxhdsElLrIPghaVjkI/eS/o6hTz3ohnbLuzB9AaOKxxw6clpBvD3UuYmu3Raz13gdcKM4
	qbPVQM4Bg5ILXQH3zJiCv92C/ulr67NraHCgYxj1gaIJQzYmq2QnqHYLsZqB/8XZaCYkymP
	K0x3ypYmu+wftAFUX0NhCP+klCe85C7+MkF7jTihyDVUxEbUlz2KtOBmYpWtEFVntUnZ9R6
	Gi0oymDYJchg8GupgKq5ow9e4dJZFE85qyaoh0MYZ1CpKboznjT2r2qhODxSFHEkCsdSdB+
	43VId5UPNcVy2Pj0y7Z7zi7r5rsGE69Zu/EauTiEFRrHRe+dT2gdeq/o8WQc/4KVK7OI2NG
	Y79OpeVURHVXtNyqbWUYMGPaynT2v6GAYVugQIOW3qC2S/dpfBc9Xi2Ij+2HABuh+e80UTZ
	blXJBR5w7EPhcsL/I1ECHWoR4HVhxA6jqEFVtW5OKaOQs3jq3cpZ4xXD3KYyxRAUmfTpw8L
	Vv29lgO/O6aTsMC+gkwXrXYoD/Y6n5G2fviaurpcFQGwxOfBwFKU+taucR0x6T189WPB02l
	G4YT2P+Vr1e6LGazbLf1FEhIagTYPQxwrPtY2s7Cqgm6eK9/zs+Mx52VI2kba0cqW6xjfTf
	uDV1uFKWVu/rVH2OLUVdH6+lOYZzBi0Y1qHDzPMVgWcn5fKRocfUrv8Z3V5rnyZ65szvmNG
	YKA5t2DQn/cMrj0zepSB1AwEDBA4noDHLdfd/wwB+93EelsrBm2tCthal30yWhQi3+55Fc6
	OjfF1Q5YXwQ9BOnAxeGy21VNyEXBY9qLCoOltTGi65fybAc4sJWWA43h4ufS6vhamYoM/6n
	6dA4oe+c9qSnUrN3XmemxZc56cW3U2T4bv3V8un+BnW3P3za6vFii/sAhvInnsNmIXMdeke
	4PjgDtmtYhEWjAzliw7Sq8UlIs+vBPaQT+WglQz7jXGlidmHynU8xkV0f7USxez2i8edzoW
	sZrnwJhI2rvtxN5YmB1vYA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Fri, Oct 17, 2025 at 11:16:16AM +0800, Troy Mitchell wrote:
> On the K1 SoC, there is a full-duplex I2S controller.
> 
> The I2S is programmable, with the sample width configurable
> to 8, 16, 18, or 32 bits.
> 
> A dedicated FIFO is provided for transmit (TXFIFO) and another
> for receive (RXFIFO). In non-packed mode, both FIFOs are 32
> entries deep and 32 bits wide, giving a total of 32 samples each.
> 
> The register definitions can be found here[1]
> 
> Link:
> https://developer.spacemit.com/documentation?token=Rn9Kw3iFHirAMgkIpTAcV2Arnkf#18.2-spi%2Fi2s [1]
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Changes in v5:
> - Patch 1/2:
>   - nothing
> - Patch 2/2:
>   - dont't read sspsp value in spacemit_i2s_init()
>   - set SSPSP_FSRT bit for DSP_A mode (was missing in previous version)
The changelog here is wrong..
Correct version:
    - do not set SSPSP_FSRT for DSP_B

Best regards,
Troy
> - Link to v4: https://lore.kernel.org/all/20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com/
> 

