Return-Path: <linux-kernel+bounces-757048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408EB1BCF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D033AE6AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FB2BDC15;
	Tue,  5 Aug 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vU6l6ePW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939262BD5BF;
	Tue,  5 Aug 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435529; cv=none; b=VzHBLsEHRkRU+A7cZpsMY4eQq84cxtksT3Y2M/Vjj77L6tYrEpbOZTFYteWU2HIQ8M/Qv5FhMs05vXZXQHBq+LEH780URkfBexij3B/GaYNBNI8S0GrjbfLU8migbMJxSweW4ZMUOb5k0vYond+OTiFWSws7+cBlsMbEYcBURFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435529; c=relaxed/simple;
	bh=l2pKQvpfyq31+DQw7ZSp6TmHRMSVcnaO2yH7szAIdz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2akTNJicgLlNMjRIZJFKJxk24UDpBZJ5BFT36RWe+c25q92IJp1iw7WyQvHLaSv4PWlrjtZ/izGl9JpqSHMdkrjKtc9S3cVuCwB6dcdSQwyp4jIRzXi67J3MLJKSla1ZsEdgrX2rX1/HmRBsUmt6LwMXE0E4TrqoMGbdfDTWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vU6l6ePW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CDD80E91;
	Wed,  6 Aug 2025 01:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754435477;
	bh=l2pKQvpfyq31+DQw7ZSp6TmHRMSVcnaO2yH7szAIdz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vU6l6ePWnm2Q6XmAFGwJg8x7ESBro7hpWmDLjxlsedcRksyK1S22jWE0cUIbN+p+S
	 bjC8TK5Mf/KdiYVMAnbmU+GU3nf1sWe/FnxIRkfSdPsjnYOOlA4UeMhv+xTPZtdjHB
	 j2RpSD9XXJmlhF4USC97w3fj7rC7t33YnMRuL0j8=
Date: Wed, 6 Aug 2025 02:11:50 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
Message-ID: <20250805231150.GD16330@pendragon.ideasonboard.com>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
 <771aef93-df3e-4a9b-b6d9-3a5057f77ddb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <771aef93-df3e-4a9b-b6d9-3a5057f77ddb@oss.qualcomm.com>

On Tue, Aug 05, 2025 at 03:08:45PM -0700, Jeff Johnson wrote:
> On 7/27/2025 12:58 PM, Sasha Levin wrote:
> > And below is the first test of this scheme:
> > 
> > Co-developed-by: Claude claude-opus-4-20250514
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/agents/index.rst |  3 ++-
> >  Documentation/agents/legal.rst | 42 ++++++++++++++++++++++++++++++++++
> >  Documentation/agents/main.rst  |  5 ++++
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/agents/legal.rst
> > 
> > diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
> > index 354af3f025e5..982602db3349 100644
> > --- a/Documentation/agents/index.rst
> > +++ b/Documentation/agents/index.rst
> > @@ -9,4 +9,5 @@ Agents
> >  
> >     main
> >     core
> > -   coding-style
> > \ No newline at end of file
> > +   coding-style
> > +   legal
> > \ No newline at end of file
> > diff --git a/Documentation/agents/legal.rst b/Documentation/agents/legal.rst
> > new file mode 100644
> > index 000000000000..67e6b2cdff9d
> > --- /dev/null
> > +++ b/Documentation/agents/legal.rst
> > @@ -0,0 +1,42 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============================
> > +Legal Requirements for Agents
> > +===============================
> > +
> > +This document outlines critical legal requirements that coding agents must follow when working with the Linux kernel codebase.
> > +
> > +Licensing Requirements
> > +----------------------
> > +
> > +**GPL-2.0 License**
> > +  The Linux kernel is licensed under GPL-2.0 only with a syscall exception. Coding agents MUST follow this licensing rule with no exceptions. Any code contributed must be compatible with this license.
> > +
> > +**SPDX License Identifiers**
> > +  All files must have proper SPDX license identifiers. For most kernel source files, this should be the first line of the file in the appropriate comment format:
> > +
> > +  - For C source/header files: ``// SPDX-License-Identifier: GPL-2.0``
> > +  - For scripts: ``# SPDX-License-Identifier: GPL-2.0``
> > +  - For documentation: ``.. SPDX-License-Identifier: GPL-2.0``
> 
> I believe the agent has not processed the following correctly:
> https://www.kernel.org/doc/html/latest/process/license-rules.html
> 
> 1) C header files use /* SPDX-License-Identifier: <expression> */
> 2) Contributions need not be GPL-2.0, "individual files can be provided under
> a dual license, e.g. one of the compatible GPL variants and alternatively
> under a permissive license like BSD, MIT etc."
> 
> These two issues jumped out at me...

And the text isn't properly wrapped. Also, compiling the series, I get

----------------------------------------
Documentation/agents/main.rst:3: WARNING: Title overline too short.

=====================================
Linux Kernel Development Agent Instructions
=====================================

[...]

Documentation/agents/index.rst: WARNING: document isn't included in any toctree [toc.not_included]
----------------------------------------

<irony>

Sasha, please make sure you read the kernel documentation before
submitting patches. We understand there's a learning curve, but we
expect contributors to perform due diligence to avoid wasting the time
of reviewers. I would have expected a human developer submitting patches
generated by LLMs to have proof-read the patches, compiled them, and
fixed those issues.

</irony>

-- 
Regards,

Laurent Pinchart

