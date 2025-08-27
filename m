Return-Path: <linux-kernel+bounces-788880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A9B38BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0C4177A34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169830DEA3;
	Wed, 27 Aug 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaPvCRUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC12EDD70
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331523; cv=none; b=LtA629zvZIXv4R/9CXafYpUEXXcNw4Vuq2NXMJ6Rvs3ipMy8BZu6Zn3qJOAZpzgD3NNfF2AhdbRlO35cNBkiL2/sedxZQMTvMntXuXZV7pGUDq0+vaiilUenhHbOrpSjWJ6sT6wxTdeoNriYauNBhg2yFAhLk9+2cRIvpjXk78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331523; c=relaxed/simple;
	bh=zBANCspRSkikcKMC+MCnrC2GrLJgJj6EBh2lTwmuoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0Wb3vFjKFQsCWgGcUvPAicExsARnrBn4ZrrEMZUp3O1hek9NNHLHCQiO2M5x+LzGkcxTFKFS4aTfRW4fprS1A52qBDTezuBP7zmcAy1Fqb/N0BWHUCDwVKNx2Ew6F4JDqOxyR/c0hP5UOtmuSrzvOxziDs7/I1rjVr1RQm0vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaPvCRUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA68FC4CEEB;
	Wed, 27 Aug 2025 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756331522;
	bh=zBANCspRSkikcKMC+MCnrC2GrLJgJj6EBh2lTwmuoHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaPvCRUQB2WEZ3ZLB4b0wjFXrYG7pV3Td3WyLY8PvOHGOuFtBha1niv+NR7h0lli/
	 5XjVhvcUOTkvxiUTsbwU+C/Nda4fer4Wi+YAam4cevQJ78Ik8JSWCSg4Zsiy2PN8Wp
	 RdPfQ6UjVSLy0TIKAffaJe+sadr7S+l/L+gGWREaRb8l0L9vx+9C4Ss8U9oSWBFOra
	 TTkZDp7+Tm95DudjkSBrGfO5vCP5mrunUF5WS6iaLOmQx41iBI4pl6haMOoHEFXL/n
	 8m/zV/0wZieAbwGHmfTtm9Y5EBxIfI4tBFIe84lwpX/VK7VjzZc60Q+ffi7t4GURYv
	 OtbAN6jwRBeQg==
Date: Wed, 27 Aug 2025 14:51:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] x86/bugs: Use early_param for spectre_v2_user
Message-ID: <5de5fl7tuo5tobdlck5a7inomwecrmw5lbhtp3ldqsxem2wzfy@4sdzpuu77zqe>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-2-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:56PM -0500, David Kaplan wrote:
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1826,7 +1826,7 @@ enum spectre_v2_mitigation_cmd {
>  
>  static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
>  
> -enum spectre_v2_user_cmd {
> +enum spectre_v2_user_mitigation_cmd {
>  	SPECTRE_V2_USER_CMD_NONE,
>  	SPECTRE_V2_USER_CMD_AUTO,
>  	SPECTRE_V2_USER_CMD_FORCE,
> @@ -1836,6 +1836,9 @@ enum spectre_v2_user_cmd {
>  	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
>  };
>  
> +static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
> +	SPECTRE_V2_USER_CMD_AUTO;

Should this default not be dependent on CONFIG_MITIGATION_SPECTRE_V2?

> -static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
> +static int __init spectre_v2_parse_user_cmdline(char *str)

Should probably swap "parse" and "user" to match the namespace of the
surrounding code, i.e. spectre_v2_user_parse_cmdline().  This is for
parsing the "spectre_v2_user" option after all.

>  {
> -	char arg[20];
> -	int ret, i;
> +	if (!str)
> +		return -EINVAL;
>  
>  	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
>  		return SPECTRE_V2_USER_CMD_NONE;

This return value no longer makes sense here, as this no longer returns
'enum spectre_v2_user_cmd'.

But also, most of the other mitigations allow you to override the
compile time default with the cmdline.  Might as well allow that here
too for consistency.

-- 
Josh

