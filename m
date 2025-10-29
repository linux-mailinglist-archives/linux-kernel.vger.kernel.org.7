Return-Path: <linux-kernel+bounces-876798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F210CC1C608
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 578CA4E90D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB434A3C1;
	Wed, 29 Oct 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHeaSkdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B8347BCF;
	Wed, 29 Oct 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757614; cv=none; b=LHCBq/8zfFekksvGr9DTG2TfP1rMtY9Inr8mkBV2dj9TibPcfWw3CrOcNPjFCnxDr+pNZWGvSYbsKd9gYq8RYXUH0uWARiAYHTXunxrvqD2kqQbaQloFRV8DicRbBLGvZfWKTSlOFGKhcI0qGALsbpQUjVVjwOMn2Bbmccz8tSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757614; c=relaxed/simple;
	bh=sFZTGSYKTnwBa0p3fbvzTrVI4AToQmojfH/yTJCVaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToGgp1kmvfCzWcCDgFVseL/pmQgIo8S6Bextue641xx5Z0AGrDHtAXZSEXzxQWAu5Hgfbg4siDkIFZPVZGDQJmuDGmYacnuDgMTgITqzB57GIZalcbWVgLLhm6Zs070XvJ/njJX5ic307yHxhPv5mEBkMet2andDIexS5woCMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHeaSkdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE389C4CEF7;
	Wed, 29 Oct 2025 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757614;
	bh=sFZTGSYKTnwBa0p3fbvzTrVI4AToQmojfH/yTJCVaA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHeaSkdZUqEm/ASvyx7Se8Cn5vw18wArwi896aedwI6c251UjEBEQVqFuJsxIR1lu
	 f6ak9jj5f4YdvkpiWB7oUMbADMqid3Q4/200n9gnbV0bdQXUQqSOFFfA+ju5afS1kl
	 j8EOdCT1Y5Rdd4zmtvqbuHQyO7B1f0xv+yfpxsCWXXZTJimfDPg7Ty52SPL8KStUdA
	 h8BHe9vhmQqdHxKeJmGztaotq9bOWyPe9NmxJl+sCQxBzO/ZBy5M9uUmTeO9VLg+G1
	 q6d6jzIeg+9t0B2oAphB9HXtViwAIJdsyBxPze15sh3EduaSe5obvnVC/KsjFXZCmb
	 W+DMfzo95h1nQ==
Date: Wed, 29 Oct 2025 12:09:58 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
Message-ID: <frbpbbvercsmytjmcfidd35p7frfmpuvoogi2s5wvf7rtzv6nr@eqceebjujasj>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
 <r5zjb7v2ngsbx2y63tmdhnm4gbpla5fki4uzpjhvn7sqmzsqi2@7637rbudt3z6>
 <469fc3aa-9b95-4b30-a704-d568a830452f@oss.qualcomm.com>
 <vmtm6wy2ldvobgl2o7cqdtknyfg4fup2pqpddkftnhzs5tgqrq@vbo4j2gmr4px>
 <bfc126ad-1443-4b9a-bc8d-3619606294e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc126ad-1443-4b9a-bc8d-3619606294e2@oss.qualcomm.com>

On Wed, Oct 29, 2025 at 10:12:59PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/29/2025 10:04 PM, Bjorn Andersson wrote:
> > On Wed, Oct 29, 2025 at 09:20:48PM +0530, Krishna Kurapati PSSNV wrote:
> > > 
> > > 
> > > On 10/29/2025 2:45 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 24, 2025 at 08:45:20PM +0530, Krishna Kurapati wrote:
> > > > > From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> > > > > 
> > > > > Enable USB support on SM8750 MTP variants.  The current definition will
> > > > > start the USB controller in peripheral mode by default until
> > > > > dependencies are added, such as USB role detection.
> > > > 
> > > > Which dependencies?
> > > > 
> > > 
> > > Dependencies like pmic-glink and adding remote endpoints for otg support.
> > > Till they are added, we can enable peripheral mode.
> > > 
> > 
> > But this is 8750, Jishnu got qcom,sm8750-pmic-glink landed in the
> > binding 9 months ago, so why are we spending time discussing this?
> > 
> > Why not just add the whole shebang at once?
> > 
> 
> Initially I didn't add those changes because the series already had acked
> patches and I didn't want to disturb them. I can add them in next submission
> and send them out.
> 

Now that you don't carry them anymore - and you have to resubmit this
anyways - I'd prefer that you just enable the whole thing over trying to
make up a reason suitable for encoding in the git log...

Regards,
Bjorn

> Regards,
> Krishna,

