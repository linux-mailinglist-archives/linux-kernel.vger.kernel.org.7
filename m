Return-Path: <linux-kernel+bounces-740235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204AB0D1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452101C234FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E42900A3;
	Tue, 22 Jul 2025 06:07:54 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070828DB7F;
	Tue, 22 Jul 2025 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164473; cv=none; b=ELSw9HGix3NTM1mu1xdrPrELgXwOCNHGLQX5xUT6p/3LJOWvynzwoYS1WxT6zHAmZoSJB9RQ0M1P8Yq6IFvqI2bXdn1UHgM0ED7CEk0wk4rwe0hSo2Xr0BlzHtYh1bQeGPSCDBjOZaGGGHomq2kOHqbmKp/vFywj8eJA2dUrS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164473; c=relaxed/simple;
	bh=Ox3IhCjiBYh+MX6ejpkv6y1uIpwAtiQwJ7amkOxMuBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un1CZKAGkhlaXrqD7q+p0SxSH4/EKGuTk0y1wlEUJZVm4fvGekv34HAfJyQi+BM4LcLY4eL078jcHQijMisMit9UpXd6n6V+9WrPDppw+qb6sEU7pb6WK4lzCUsg2SRwIkOvV7bXDY/TS2LykMIdz1R3ioLkOUbgR+hce3hsZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpgz7t1753164408tad5392af
X-QQ-Originating-IP: lRVZxkrx6pC3u9vYhC9bQPmaTVYkQx9JA3OJjBKNKT4=
Received: from localhost ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:06:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11910796611481900965
EX-QQ-RecipientCnt: 14
Date: Tue, 22 Jul 2025 14:06:46 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Message-ID: <F429DD8B86709040+aH8qdpV2gn2Xk_4J@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
 <20250721103805.531758-3-nick.li@foursemi.com>
 <83f7c489-7001-49cd-97a5-4280eba95fe0@kernel.org>
 <F04DD98A69286426+aH4sT_P0GvttoCOq@foursemi.com>
 <ea2f30ff-b2cf-4b88-9fe8-78950a03d882@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea2f30ff-b2cf-4b88-9fe8-78950a03d882@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MyhNtuNETreePwhjEFGswSHVX+yS2AT0r3JWkWPuEKTsKBZlgGww/McU
	K2IDBlDmTmNYdPKRvJJpdVEOfQkyKadKcr7I7z4/IQgeJ3wT6txAsEEqIucdRrfzpxgnQqh
	AnhqOdPNXAarvvdCuRQb98xUXweMYL3WUCDzYgArs17bjYIAHvlAw7wZYdfZrDYLp+X3ofr
	OU23kpiXAgcrpKzAkuCNLqvxvzZRI2RKGTQJ4kO+iIYONhKNsLRomYbwzzoz328J01PbqBc
	WmOVIjRQ00likWQFefVZH5wgF1ShlW1OkMdsb6aFv4eF3j4AfX1KX3iGztOmli5j6JQcQtQ
	APNtJha1Dr98lYm+IihlbQ15D4wwrHvgW8bFZekgv7qryFdRqzOtr+nuN2PH1a2FDOe1OLa
	yx4eWPxRNYRdlZ6t3Ouz2aBTRX5PBMLdBPQW1iO2P/JIlGP6r4ctc9BlvD0087I/VUyb3NU
	lkyjH9qaGygi2Xg+E6jsoreKoLDEJlZGAb1t04RWSvcGiK0DPNyNTa8eqbUQqvRzStAK9KW
	ukyO1G5WY3Rf0/gm15GlfYmGiLQ0yEFGtCzBYc+szzqWSRX+jK+ixecYa6vZcAVbbYt8k6N
	ONwNFAO+WjWf2CGtzihlcyd0NUEqPNyIq5zr1QM1vD00pvt5513vPlKqo4vp6SvivIgotmB
	CNfIWLpWqkK1vzZ3Pk93CcTRRvhlcczaGDR+7hTxFE8aZyNHDrZI0zwGspEB0PutLELRQpN
	dSz6HTDdy8gyAmhskOu0u9+7f2RGC7ftdR1Fio7Z9JYIY5kVLZnr4qe+9KJz2OprBT089xn
	42aHMv0pM4GQ3me0d7ZmvFAK79sE97z8leOXW9IVjD8dRnCfoRIi2L2FLiSrJZ5GVHkYjqG
	4pqGmZljKX45MUUXa2t+2bXEmTlAsGW6nJVP/6u37Z+VKzRbIVss/29QTC/FVB0LfWd6bRD
	uJsgA7+eRrqZRwU+5XOvBR5+VdGXXz7rz3pBm+LhK/9xkNKEuYfNWv/bd1CeKWbN9L0epeV
	KwZeU/EF1aVKuPsFrmUNIFn+k8RAo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 02:15:38PM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2025 14:02, Nick Li wrote:
> > On Mon, Jul 21, 2025 at 12:48:24PM +0200, Krzysztof Kozlowski wrote:
> >> On 21/07/2025 12:38, Nick wrote:
> >>> +  firmware-name:
> >>> +    maxItems: 1
> >>> +    description: |
> >>> +      The firmware(*.bin) contains:
> >>> +      a. Register initialization settings
> >>> +      b. DSP effect parameters
> >>> +      c. Multi-scene sound effect configurations(optional)
> >>> +      It's gernerated by FourSemi's tuning tool.
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - '#sound-dai-cells'
> >>> +  - reset-gpios
> >>> +  - firmware-name
> >>
> >>
> >> I do not see how you resolved my comment from v1 or v2. Nothing in the
> >> changelog explains that either.
> > 
> > Change logs are in the cover letter:
> 
> 
> And as I said I do not see resolution of my comment.
> 
> If you reject reviewers comment, usually it should be mentioned in the
> changelog.

Understood.

> 
> Otherwise you get now the same review as v1 or v2. Devices cannot work
> without power.

OK.
We will add the supplies into section[required] for the solution.

Thanks.

Best regards,
Nick

> 
> Best regards,
> Krzysztof
> 

