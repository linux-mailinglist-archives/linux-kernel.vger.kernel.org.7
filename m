Return-Path: <linux-kernel+bounces-795429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0FB3F1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7C3B68D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CF2DFA2E;
	Tue,  2 Sep 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ENS0H99U"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A825394A;
	Tue,  2 Sep 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777207; cv=none; b=oXNLsqazPSNsLQlze4BqUuAc8PBhzBDkmc6x/wXeLcJRrnEjYshULJvd1ctiZ4TTrSwYVN0vaKZbo9fLAL00TSJ/OAvCyocxZSc6TdHmCTwIe3vpZy/diPHzriFelBcq+llltHX5edB7nYTGDKDt88MnfcRDdzRZVQN6tKV+8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777207; c=relaxed/simple;
	bh=7+ZmVvbuSWjNsHKt4aH0z0j5m0PLR7z1c10b2M+RKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg9ERzOWZhPILy9e6yovju/P/BgzHZ8cLwKBE6yzhzqYtYvmgn5Odww/uar9LjiWYjzhWG6JHZrHxQXZQUgKz6/MbI9hx5zjAgwDkyVOIjI0UwVGQn2mNtppV28kdeNaQvhuZAPOJum94r40E4RysdtcfsaNIhuX5d4+/Z/WCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ENS0H99U; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756777186;
	bh=Wx6uFFrlOYm1QT1WpGuIUZOo6tC3AIX9NR1xVvEN+A0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ENS0H99Uq0rr4s603AMXcvQ6uskyytpR0wan7LPzd9ySJ6giqyPoNh06EXYauwlqy
	 PZLsrRRZhrDfgy/FCS/4f0yEDXQe6qcGzBhUZLPypX220lNbo4sB+OF90i+p4TzCCN
	 7imEaAm2mAnFmdubDNDIjGPOJJq2xfRIPOY/bY4k=
X-QQ-mid: zesmtpgz1t1756777182t6b1f51f6
X-QQ-Originating-IP: hnb0EBq5kdR38t0NCC6tWx42nt3/po6TjNAAMjiMEw4=
Received: from = ( [14.123.255.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 09:39:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7662810495034026138
EX-QQ-RecipientCnt: 16
Date: Tue, 2 Sep 2025 09:39:40 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Mark Brown <broonie@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v2 2/2] ASoC: spacemit: add i2s support for K1 SoC
Message-ID: <C855339EB347C5D6+aLZK3D678QUDB8hA@LT-Guozexi>
References: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
 <20250828-k1-i2s-v2-2-09e7b40f002c@linux.spacemit.com>
 <aLAbk_0emidBCJBn@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLAbk_0emidBCJBn@finisterre.sirena.org.uk>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M28vnsO5i7WeDWYmO+WSrEuYN7LsZmOw20NU2LKZLfonLw2XL4JdtiuV
	dR6fiMc6YExH9qntnQQgRhHe6rIHrnUaj0vVTt00olZY/BIaAbcx6ZdrvWced+ijEMrA7EY
	7sRCST9br0q3oW7D5vmE4SZLvYs+DUTv25A+E5NstiXVhYlnuRbLEgyXFiDga0GBe2ufppb
	rxHD7ePTERoim5fs+eSwRvMu6AbKhWQubch8irlYExQvCjPh+seOp6jd88PI/t1F/ir/KTg
	blThtGS+l93+nQrHL/FGVAIve7273KNM9UTxLKq3jEFYMDUtY6ciWQWXfmsPZrqvme+FnDn
	lfws061EMQcmw2u1NPh8xTfCgP5vV64h2nN8r4ygfCk/KbovKPueJISf8gs7vlU0J/9CD/v
	hMUXgKumEKWmdg2MHtAajsZwgLapPlrzxy/yK3hTDZfudXTKX5WU5ZLZ1c5ZOGo9dGGDdxp
	lujZsYYAJVA5vBTbqzJKzqPEezedq7gNTges3HPPAv0MevpcH7EcCNzi6ZwDGYQJOoZ6TkO
	OzGlXyXFcu0IHloPpo+YNpiuipnH2SBBgCB3PZiIzaH4DttDimqBGCLRTIU8pZS52Yk1P+S
	sf/cG/ZJyGT+uezhvcv8IyOCMXCtVqPHWnx4r9d4/3hIjBxqxYJcyP3pZ/z/nDO/WQWyHvV
	8pU/Q694mI+sl0ALmvpO7x/vtnjazcMlk/sP9QaRXAHbHiMVUNvWvTUAtdfbq6iEN6iaRQA
	9Fxyu5Ej5dsPZim4kqEQ8Gv1UBZ3HaBRIZx0Lp/Ov0iBlU0VHJpkUI8vCL4PW+aV9owzj6u
	Y2I7juWuc8k4KFlN/cmLUGiJ5/rlnZOVIb84dZB2nS89PLRdFXurxv+aLce0mwxQPYvAkgr
	7pL0jca7svT2IbG6YH0AHbezx1J69b8JTfd4AuvVHxLe7dtzvId1X1rVtyI8q7Cl9rzBlkr
	NhMGW+ajp0XcuWQykkBxwd8czeR2U/T8YZFq25F82uuM1j8e+6LENtMP55Ccte95chwqmzZ
	K4sKgYcfNGOkLBsLBQyjGM/XCD+WZf4W8bb/2MXE9KhfUVpNnI
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 11:04:19AM +0200, Mark Brown wrote:
> On Thu, Aug 28, 2025 at 11:37:33AM +0800, Troy Mitchell wrote:
> 
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_DSP_A:
> > +	case SND_SOC_DAIFMT_DSP_B:
> > +		cpu_dai->driver->playback.channels_min = 1;
> > +		cpu_dai->driver->playback.channels_max = 1;
> 
> > +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_DSP_A)
> > +		sspsp_val |= SSPSP_FSRT;
> 
> It's weird and confusing that this isn't part of the above switch case.
Thanks! I'll change it.
> 
> > +static void spacemit_i2s_remove(struct platform_device *pdev)
> > +{
> > +	/* resources auto-freed by devm_ */
> > +}
> 
> If this can be empty remove it.
Yes, I will remove it in the next version.

Best regards,
Troy


