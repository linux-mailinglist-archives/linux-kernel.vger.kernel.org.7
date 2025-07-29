Return-Path: <linux-kernel+bounces-748719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BBB1454A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91256542661
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E411187;
	Tue, 29 Jul 2025 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn9MkEoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB814611E;
	Tue, 29 Jul 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748329; cv=none; b=J8jNoG1R7lyU0uz4Dx17xz8ropLTh5egq8V4sbwdwqVU877UB6Ftyjoa+pR43/0iVFelk1atpVuc96PcdcDvmZmsBPFFxZBaH4ipxvUnwHIgQ7TGiwmIwD2M+AXd6GGPIwda+ow3O/DLVa8QoWU2BkkvlFJQ/qL+SZtSDFN0IL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748329; c=relaxed/simple;
	bh=x8tvYZmVKuAqtiJu5GxhyqKrIDYiII9xZx6ML2eDwMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2AhnnQGLXj0OhoEznDs2EG4MUriDyurVol+QRW9WLxX4R+vmbVHgR2F5F3hXxdvtPzlewKi35E7X+rcZBhiizvsj5DF5AomEjGCujVRDmZTGcj2vKRqX0EVUF/0qGe8HYcSCa2eQUSpd/LmWazVH2RmapicTlywTRvsaqoKgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn9MkEoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB72C4CEE7;
	Tue, 29 Jul 2025 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753748328;
	bh=x8tvYZmVKuAqtiJu5GxhyqKrIDYiII9xZx6ML2eDwMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dn9MkEoVLb/pxXOYjFx3bYRpBjPYE39I1kyUPxf8iy3LlDMZ77CzGOYRUYBW31jqz
	 /GKurD/wOivcwcwAZQtZxc+Gz38xX3nC7jl3+PlZcO/UNH3eGJZYITPVAgYKelFSPi
	 dG4EECGYBgntcIo1TIExojC5t7stumHoqrBTr/W2yC+JBebQwwSbJNhG7l3lOoUzWl
	 da+mtyfZfif8c5SQ/OHnmZLHXbPjFt1LgQZoZNT6ovTvmPZJthWBqJNR6flms3B5Yw
	 1BZd/ecCuQbMTGRrpT5OxjQUEKIrmLMYKfrIQfExbeQD/ICoZ+BCFhxBK6CYKyrI/0
	 wMMQEn61J5ciQ==
Date: Tue, 29 Jul 2025 02:18:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: <dan.j.williams@intel.com>, Jakub Kicinski <kuba@kernel.org>, Sasha
 Levin <sashal@kernel.org>, <workflows@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kees@kernel.org>, <konstantin@linuxfoundation.org>, <corbet@lwn.net>,
 <josh@joshtriplett.org>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <20250729021842.521c757f@foz.lan>
In-Reply-To: <20250729001233.4dead173@foz.lan>
References: <20250725175358.1989323-1-sashal@kernel.org>
	<20250725114114.3b13e7b1@kernel.org>
	<20250725150046.3adb556c@gandalf.local.home>
	<20250725125906.1db40a7f@kernel.org>
	<6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
	<20250728134653.635a9dc5@batman.local.home>
	<20250729001233.4dead173@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 29 Jul 2025 00:12:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Mon, 28 Jul 2025 13:46:53 -0400
> Steven Rostedt <rostedt@goodmis.org> escreveu:
> 
> > On Fri, 25 Jul 2025 13:34:32 -0700
> > <dan.j.williams@intel.com> wrote:
> >   
> > > > This touches on explainability of AI. Perhaps the metadata would be
> > > > interesting for XAI research... not sure that's enough to be lugging
> > > > those tags in git history.      
> > > 
> > > Agree. The "who to blame" is "Author:". They signed DCO they are
> > > responsible for debugging what went wrong in any stage of the
> > > development of a patch per usual. We have a long history of debugging
> > > tool problems without tracking tool versions in git history.    
> > 
> > My point of the "who to blame" was not about the author of said code,
> > but if two or more developers are using the same AI agent and then some
> > patter of bugs appears that is only with that AI agent, then we know
> > that the AI agent is likely the culprit and to look for code by other
> > developers that used that same AI agent.
> > 
> > It's a way to track down a bug in a tool that is creating code, not
> > about moving blame from a developer to the agent itself.  
> 
> I don't think you shall blame the tool, as much as you you cannot 
> blame gcc for a badly written code. Also, the same way a kernel
> maintainer needs to know how to produce a good code, someone using
> AI also must learn how to properly use the tool.
> 
> After all, at least at the current stage, AI is not intelligent. 

Heh, after re-reading my post, I realized that I could have been too
technical, specially for people not familiar with electrical engineering
and systems control theory(*).

What I'm trying to say is that, while AI is a great tool, it is just
another tool that tries to guess something. If you get enough luck,
you'll get decent results, but one should never trust on its result,
as it is based on statistics: it will guess an answer that will likely
be the right one, but could also be completely off.

(*) systems control theory is a field that studies a system stability.
    It can be used, for instance, to ensure that an electrical motor
    can be properly controlled and provide precise movements. It is
    not limited to mechanics, though. It can used to explain other
    systems that have any sort of feedbacks. at the light of the 
    control theory, an AI training would be mapped as a feedback.

Regards,
Mauro

Thanks,
Mauro

