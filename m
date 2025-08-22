Return-Path: <linux-kernel+bounces-781979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58978B3196D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4B1D00D55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B12FE59B;
	Fri, 22 Aug 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF9uiuc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3C1624C0;
	Fri, 22 Aug 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869251; cv=none; b=SSB8trnDAf269OLel5xC1ELGlYFf5XVk4dILAwueadSCUNqPgn6xgYwYfK2Z9Eu/KCTTOa9DPU7sA7Aai6i961afRIciPiwOnzI9a99Xi5vcwmZtaaB1+OgwdcSgYk41GMOuhnkaviT6bUr6g5DJbkLfvW1VSA8JseQQnwa+v6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869251; c=relaxed/simple;
	bh=W5W7qyk9rAPLhmzuGclgp+ntydMraJW/Y5JVIxQeMTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ+zYnTbBfbwlvKiPq3B8FGobT0Mam1ea4/A5p7+ezwaLg5LOwEfpfRzuy4r/Zu4IjbucxgHHI+cwM4T8DNsmg3lrvhM7d1eeM2I/Orqcabf4FZHN0sNmA2n7g7imBqlGOMl17n52EYX+SO6Zg8eSAfPYgweI8yY0+baOvSFe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF9uiuc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D3CC4CEED;
	Fri, 22 Aug 2025 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869250;
	bh=W5W7qyk9rAPLhmzuGclgp+ntydMraJW/Y5JVIxQeMTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AF9uiuc5e9Qa/lNrnQ85GHhbwjlsVNG//QY6D533GTgb5nvfrgvn+oGP/fUOy6LgO
	 IZBYRE0GW+u7LKx8mc9sMZ/HZJYpdApqkt8PjAjNWehe/ucmjVg43Nw6XcEr94kytQ
	 wf/IrhoN2liaGd7azQ4HBkuEUlC1FUakDwvrJgrXcWJ/rP2y2AmGcsYmG4J95VV1gP
	 B+hnhbayt4nMvHA84622mcqvieBm98OP9rONAenx46FWih/LLwupj7U3yJbsfGsxMQ
	 PaasAI1mZkuktQ0imqAF7BZoV6CJk+xvDhk9ykTMCfs/WKSlod/EBOcBpdoeBCKgpn
	 PH5rl6Vwp04MQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upRnk-0000000C9Vj-1Mzt;
	Fri, 22 Aug 2025 15:27:28 +0200
Date: Fri, 22 Aug 2025 15:27:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: mchehab+huawei@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
Message-ID: <fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
 <f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Aug 22, 2025 at 09:01:03PM +0900, Akira Yokosawa wrote:
> Hi Mauro,
> 
> I see this has already been merged, but let me comment after the fact.
> 
> On Thu, 21 Aug 2025 10:16:43 +0200, Mauro Carvalho Chehab wrote:
> > Makes it more adehent with modern Sphinx LaTeX build setup as
> > defined at:
> > 
> > 	https://www.sphinx-doc.org/en/master/latex.html
> > 
> > There, it suggests:
> > 
> > 1) to add: 'printindex'
> > 
> >     “printindex” call, the last thing in the file. Override if you want to generate
> >     the index differently, append some content after the index, or change the font.
> >     As LaTeX uses two-column mode for the index it is often advisable to set this
> >     key to r'\footnotesize\raggedright\printindex'.
> > 
> > This indeed solved a corner case on a distro where the index was not properly
> > generated.
> 
> This looks good.
> 
> > 
> > 2) to add at the main example:
> >          \PassOptionsToPackage{svgnames}{xcolor}
> 
> OK.  So I guess Sphinx's latex builder is going to start using SVG color
> naming in the near future.
> 
> > 
> > 3) I got a corner case on one of the distros was using xindy to produce
> >    indexes. This ended causing the build logic to incorretly try to use
> >    T1 fontenc, which is not UTF-8 compatible.
> > 
> >    This patch adds:
> > 
> >         \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
> > 
> >    to cover such case. It should be noticed that, as the config doesn't
> >    have \usepackage{xindy}, this will be used only if latexmk ends
> >    using xindy.
> 
> But I can't see how this macro (executed by XeTeX engine) would have any
> effect on xindy (command) invoked from latexmk.
> 
> Can you elaborate on your theory of how it works?
> And which distro runs xindy?

I can't remember on what distro I saw the issue, but I got it during
my builds, where, instead of running makeindex, it tried to run xindy,
with failed because of utf-8 fonts.

My theory is that, on one of the ditros, there is a /etc/latexmk
or similar containing instructions to use xindy instead of makeindex.

In any case, this rule is harmless on setups that use makeindex:
it only affect setups where there is a latexmk or .latexmk file
setting xindy as the default index builder: if this is used, 
xindy will use utf-8 fonts instead of Type 1.

Thanks,
Mauro

