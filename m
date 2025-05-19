Return-Path: <linux-kernel+bounces-653330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F123ABB78E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F77F7A3001
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF026C3A0;
	Mon, 19 May 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBCemz9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913FC1DE4EF
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643758; cv=none; b=cMNP3DPYywpthTsmAetR1KPWy3A7BKqArgN8BEhnk9X5Exi2kcc9X6gTBhnjjImAox6z03Sl8gtsg4ureyLbj9AV8bZpd68yhzLzQKfFxz+Mcg7hI4xZRFMKTwqG6uOBgPOIbUjKFW+2vxEstMExvnDbGJf1+Efc14BNJ4GGemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643758; c=relaxed/simple;
	bh=z8lOPEJLkQ/XyN0ChDJR14uTpgdR3CL7aP0C4KvfHCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boQe3AQZeNklI7ThAu+mmO+WfKF6hzswogGGrSTHErnLQHN3CyjQoMbq7KlvdyOrQEvLk58vOonWkHsLM1oGeNFw0Es1B06slqhkzi9HegZkVxcx8QHqQY9iyfv//hqMnj6eiW0K0XiZ0aELeMyYwoPEObhVh3fyJtMv++PFHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBCemz9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C7FC4CEE4;
	Mon, 19 May 2025 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747643758;
	bh=z8lOPEJLkQ/XyN0ChDJR14uTpgdR3CL7aP0C4KvfHCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBCemz9uq5HvtVHtzvR9t/VEAUFeBY3oljoEebDhU8ptZNC5Pnt64dUUGBsFd54Ke
	 EsDazvh0701diiCmKFQpJHcKzckIEgjDnBrxVJzHv3xjg7bSd0nBSO5iT0jxM9jix6
	 +9oM+O1cYU0vPnZ02cgMIZ4uXztbObaxMABSOkcv98IOBjvg2GOQuw0BA6a/0qKcHr
	 Ymg/HU4uGrevDaOnY1rrI1DxSH/YBrWiMq1uFUoacgoznjM64vdUBP4hhfkCl4BKnN
	 TIJe9EgbJPBsYsqFnjGaIontP9WQ2xF0sZvl4R1WrEREVurDvHeqHUmCs2eIKq/lpQ
	 HOFu0geA8oMyg==
Date: Mon, 19 May 2025 10:35:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v4 1/6] x86/cpu: Use a new feature flag for 5 level paging
Message-ID: <aCrtaQhArS7gSb04@gmail.com>
References: <20250517091639.3807875-8-ardb+git@google.com>
 <20250517091639.3807875-9-ardb+git@google.com>
 <CAMj1kXE=-408evLMwPkH5SqK-=QPpONGSXCi4_YeZAgLt06Aqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE=-408evLMwPkH5SqK-=QPpONGSXCi4_YeZAgLt06Aqg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> >, and add a
> > new string la57_capable to indicate that the CPU feature is implemented
> > by the hardware.
> >
> 
> ^^^ forgot to drop this

I've rewritten this paragraph to:

    The 'la57' flag's behavior in /proc/cpuinfo remains unchanged.

Thanks,

	Ingo

