Return-Path: <linux-kernel+bounces-613845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34684A96272
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBA7A9738
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E6259CBE;
	Tue, 22 Apr 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="penu3/YZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DD25743F;
	Tue, 22 Apr 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311288; cv=none; b=cI1o5uiJzjk3WVYsWSL9r7uk+TJDVv1YG1D2LSiJPS4vDjPdBPhfIay3dBllrqPPWGHPYLUmbOp/p4aQY16afSmEuWNkaOLZQMEMMAarnjRA+Edp1CfMlFgED9TPCd4dqQv24FFrTETt+jgndUT2Jtvhkxi8acMGgkX9aE9TmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311288; c=relaxed/simple;
	bh=1Vpx6IWGw8fnpaFdAhzIBN6OlsDoegH8mN06+Y65eVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+zOzyqkh2fML7tAuV6YvhKg+VhU5eHzh2soCqwFfmPzlCbUMVpRoQo0h8ZNYPpqy8mgTHdJdi6fgYc/d3JyBjqCE7ztgCqU3BavfWsA0JnTKpgPGhQGdB33E6IsuGw82Pmd4AqzYSlMTcvyfwW6HmSsunKzknAA6jY41QKej4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=penu3/YZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E3BA01F929;
	Tue, 22 Apr 2025 10:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745311277;
	bh=j42C1neK3aBXGc+3YIjfO2v8Xt2aMCt3/0zWgtV9maI=;
	h=Received:From:To:Subject;
	b=penu3/YZVEI07stg2iQTLUOpNVxP1HOxBAdODDevRCDZPAJCgLpfGVefwkW/zq4yK
	 Rak6XOa9G2kod7SBw6TJPCJ8uFa/q4TQywOm1J8XqIZRCAQC7Cztqt3vlepvWqF3XT
	 N/iwt/q2/75cJAr1Z5Tu3KOekjVlUNaxDglJORQrY+OnSA9KpRbBSkA4AqHJ3ztnhq
	 jjOzB8olRLLfUBsiTQ32s30FTValKeVCLAYqQIprBaFJ9B/QTcV1BcD0vyFNI6aqkK
	 0n3YhqZKABBuSIbdQL2m2/WzkSM55NQYD5xfqDTdh2wrHev+pNuTxS8L5C0xnmF5YA
	 CCcGAsK+D5jmg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 952EE7F820; Tue, 22 Apr 2025 10:41:16 +0200 (CEST)
Date: Tue, 22 Apr 2025 10:41:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Philippe Schenker <philippe.schenker@impulsing.ch>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Message-ID: <aAdWLFS2UYciaJc8@gaggiata.pivistrello.it>
References: <20250417112012.785420-1-Wojciech.Dubowik@mt.com>
 <20250417130342.GA18817@francesco-nb>
 <95107ed358b735cbe9e5a1af20a2d6db74c5ed64.camel@impulsing.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95107ed358b735cbe9e5a1af20a2d6db74c5ed64.camel@impulsing.ch>

On Tue, Apr 22, 2025 at 07:57:32AM +0000, Philippe Schenker wrote:
> Hi Francesco,
Hey Philippe!

> Not sure this causes any side-effects maybe you guys want to
> investigate further about this.

Yes, we did, the correct implementation would be the one I linked
in the previous email.

> I needed it due to the strange requirements I had (described in commit
> message).  From my point of view it is correct to link the vqmmc-supply so
> the voltage can be set also to something different than the default fusing
> values.

It does not really work fine, because you have this IO driven by the SDHCI
core that is going to affect the PMIC behavior at the same time as the I2C
communication. And even if you remove it from the pinctrl, it's the default
out-of-reset function, so you would have to override it and set this pin as
GPIO even when not used (this would work, of course).

My request is to fix it in a slighlty different way that matches with the way
the HW was designed.



