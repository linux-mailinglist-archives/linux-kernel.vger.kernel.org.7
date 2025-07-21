Return-Path: <linux-kernel+bounces-739241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01DB0C3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35DD7A2EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAC2D29DF;
	Mon, 21 Jul 2025 12:03:19 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FB291C0A;
	Mon, 21 Jul 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099399; cv=none; b=Jd7X0nRPdlvDHt9ukW9qN3K9iifHFlb9R7tg1QNWasDehRfvihvtqrAgTZYp3qv000YQTzV/q8KGZpXHXYdMEPhft6Edln4s+fkX5wLXVY6Bz/1v/OWS3wUpLfW4ckYDqPmkt9p08WJZmwCTeLAdcDiV47LH7UwaSjOUP3WFeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099399; c=relaxed/simple;
	bh=L5qsIxuvHyfcqD23PAauHEBvAc9IlcRhaka9YEdv+lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0ElnFSHLDYPmBF6ZOEwdOdYgFlOk1WKgyHkcfElKRb4YYs74jGEzEMY/qX0RHf4TnJxM6Dp5NwXFUcPpQ7GUkZCA5uMjjI946lPAFZFw09Sra7YcQ/Ty/4EYcIz7zUheTMUe+vywjioWXVrWML95dDKA70xL/HT1GBiKOt1tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz21t1753099345t7e73bfbf
X-QQ-Originating-IP: AXZvxwazFJGly/vNa7p+LCy4S+Cfg47Zclcv/a3cTWM=
Received: from localhost ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 20:02:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12701394614821551690
EX-QQ-RecipientCnt: 14
Date: Mon, 21 Jul 2025 20:02:23 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
Message-ID: <F04DD98A69286426+aH4sT_P0GvttoCOq@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
 <20250721103805.531758-3-nick.li@foursemi.com>
 <83f7c489-7001-49cd-97a5-4280eba95fe0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83f7c489-7001-49cd-97a5-4280eba95fe0@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MQqtfF4R/f2xKtcKgY4SDDHMLtkrTNkiroXOvfJw3YOcpLyRSXlFcbA4
	d2NF0IJaJm3W8sQ+322H67UDvLUIe+9vW9Teq84LLuU0Bj85qX2dy/U9i7IbRHR6uXO0ZTK
	5C4TVDyXPPOhad+13hX53nblnwThHP2XkQk4XT2tVMB/Sv0cceo9tjdxm9JTAMdqVqQu6vu
	jFgbgdikqUkG0MGDR3A4GgNsk7+d9WC+8m4n+Rr2Oe4c2fdHR2JcdtXt4/k+GnrT6B6EUP+
	JDDURWlwEJjx/eG3KTQJy7ZXshen8Mbat6epxDGKjO0JoqNFn36UMKjMLjHoykXftjHnvJX
	ApFn0RcKxr7Vai3abT01eMsLjHldpW6FPpQnYgqqMphZTNGloszk//CLOcW6nrrd19yh+16
	icvxJC4HijN4lKp2dG0MkS59zmSD8m8Z+csxOdU0pTUxRy/eDDMUUZqZgwKu/p327TYOuAd
	4a3MhJv9KOJnv2cLdPnGcmdJlDUnTgm8ewggSmaLO4YFZX/YO6jMQLKyvYzALHR/ecwXvxI
	WKQrRS4XAuVKplT7CIVmtO9YJGgt9H21du2vdAJDyLVOH8pHJA3D/Jta6HB6xwh42h1wvIH
	vZskYsazIcYKNMn6CzwitBGWqcSB6AXDzvED08gd1jSXOyQf7FRCOVgS70p84kPDo6rkP2s
	DrRXjMgMkHXNSDfOLAbIqVUCj5wpHBnlgcH1rdT0P5lXk5noF8rQ26enCxrILqCM7K0T/z4
	WCDNzTdqhb2Nm0w2AOoTchiXZQ0rVDSmz5NulzqQTC4/5aTIw95Gwaz78kr6Jaw/9wvCDC9
	vlzqZkaZHM8TT4mVAx5BtT2th6zDMOuPrVh7E4ELOMrkbiVNqJUvfpk0DfoqNqhafNYy88L
	Tu+koPzf7efhQhf6m1XTiObiGP2MKpwYlNn7j4JuEuEvtTYcCIzce4flldBQYIa4bqWKZTB
	ToYgCCpXYBc8FSyjxUPDiuKN0TH0DV7ixfIEGz6l2HeU5ZK22BziJNDwFDko3IOnOnsFFub
	AaK9Ft+TSjxxaBE3j16hG4k4paGxy65uUcI79d+ZJzrm+CT4YH3XFYr2bFN1ll6NqQcWMGq
	g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 12:48:24PM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2025 12:38, Nick wrote:
> > +  firmware-name:
> > +    maxItems: 1
> > +    description: |
> > +      The firmware(*.bin) contains:
> > +      a. Register initialization settings
> > +      b. DSP effect parameters
> > +      c. Multi-scene sound effect configurations(optional)
> > +      It's gernerated by FourSemi's tuning tool.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#sound-dai-cells'
> > +  - reset-gpios
> > +  - firmware-name
> 
> 
> I do not see how you resolved my comment from v1 or v2. Nothing in the
> changelog explains that either.

Change logs are in the cover letter:
...
v2 -> v3:
.../foursemi,fs2105s.yaml(patch 0002)
- Drop "schema for " in the patch subject
- Delete the description of the property reg
- Restore the property clocks to v1
- Keep the same order as in list of properties
...
v1 -> v2:
- Adjust the order of patches according to the dependency relationship
- Rename yaml file to foursemi,fs2105s.yaml
- Fix some properties and error definitions in foursemi,fs2105s.yaml:
  sdz-gpios -> reset->gpios
  fs,fwm-name -> firmware-name
  Delete fs,dai-name
- Drop "dt-bindings for" from subject
- Update the driver code according to the update of DT schema
- Fix warnings/errors reported by running checkpatch.pl --strict
- Fix warnings/errors reported by running make dt_bindings_check

Thanks.

Best regards,
Nick

> 
> 
> Best regards,
> Krzysztof
> 

