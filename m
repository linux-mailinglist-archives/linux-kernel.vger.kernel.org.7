Return-Path: <linux-kernel+bounces-589373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A0A7C4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 22:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F7189E576
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7691E1DE9;
	Fri,  4 Apr 2025 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idzrEJdT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753DDDC1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798224; cv=none; b=FgfT3SYlHTBy+dTtrX41shF1YAGLgjkU15n0wBjOJhVq+lJwUz2vGQVsftalUJqH8LMNiXsE72S+DWbb0XIuWPMx2FprmMlHH90beaSoghLX+A5+oWr55QR/bIzVQdahShRZGgCgR51+TLKGfnZQMZ1pGcCe9GmNiLEHCIlZi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798224; c=relaxed/simple;
	bh=qfRn8CjnTrOZkX2GSeMMZOa8dlZBM4yEMS1Jo5gdzsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M82NpcQcuX2G/O2Irvngpe2dXHpmIgyXYRg4oetkMiJIRLXbRYVNr939SFxuPT6bc+YvxSKFBkdxA70rc0xNpvx69SjbTU1HpH+tq0D1Z08c5m0rDVVGb2GNxu6WT2qyX5LQd67goWcgEm661IooE0QzhlL0XpgIySa+2j1NFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idzrEJdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BC7C4CEE9;
	Fri,  4 Apr 2025 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743798223;
	bh=qfRn8CjnTrOZkX2GSeMMZOa8dlZBM4yEMS1Jo5gdzsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idzrEJdTdN4KewFR69sY1krGQpIuBQ0JJ4ddUIhiC4NHSxUG6NKVoNCXgB132KQB/
	 KyBpuMmdK6UNMGz4Y5bpicEW04m4u0SzGcYih2UfdJn/93jZdSZvQEWjmerz5dkEgS
	 Qqvidw1Z/heb7/b/RZbb78GtTiL2G1L+g/JYpEAk7VLjjyDzYrRk96t+qqoHDemOWP
	 LehKCfy8uSkcmGcOCCJFoBIkPaYj0jkMuWkyZoh9DKbGkG9VKSMGukLyNxvjYd0rMi
	 fdfy3FK+v2hDQB42HMTYkSXZmE3PyVK4LdpZ+oLtvsTmAVvNcMGyR6CJZkn/UhtgPI
	 7amUoXrMAqkaw==
Date: Fri, 4 Apr 2025 13:23:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v2] objtool: Fix SYSCALL instruction handling and
 INSN_CONTEXT_SWITCH
Message-ID: <n64kpy635gwplph5uyxzek5p73u7ubuspjtpegtssr74krjpw2@uhsaautjvu4b>
References: <b1c60a498c6146de0706572d3f47d3723ca91743.1743797052.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1c60a498c6146de0706572d3f47d3723ca91743.1743797052.git.jpoimboe@kernel.org>

On Fri, Apr 04, 2025 at 01:06:26PM -0700, Josh Poimboeuf wrote:
> With SYSCALL and SYSENTER removed, INSN_CONTEXT_SWITCH now has a sane
> well-defined return semantic.

Argh, this last paragraph doesn't mention the rename of
INSN_CONTEXT_SWITCH.  Changed to:

With SYSCALL and SYSENTER removed, INSN_CONTEXT_SWITCH now has a sane
well-defined return semantic.  Rename it to INSN_EXCEPTION_RETURN to
better reflect its meaning.

> v2:
> - rename INSN_CONTEXT_SWITCH -> INSN_EXCEPTION_RETURN
> - clarify that xen SYSCALL is a hypercall
> - check for SYSEXIT

-- 
Josh

