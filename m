Return-Path: <linux-kernel+bounces-895254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44FEC4D5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D09C188C525
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F820354AD1;
	Tue, 11 Nov 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRac+31B"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB6351FB6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859615; cv=none; b=l7r5UJdWTlZ92Ma76sUAATQPRr6AkkMSBxMsYFxNaUoR/jHjV3WnmVLTGlvDsNA8YXDYoMtyw6M0UUevo2WnSPun9PvBTsfFu26VuVL1LaH4QG3ZxuspwU+/pOR24tMJ9L1EWEyGtNLnNVeVxGuyvGiN5wpCJ4qwHbobmyfdoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859615; c=relaxed/simple;
	bh=Qp7xsraUU4SrNfBBzn36h7G4bnVy//RON9DhL8n1+Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHsGZcL0bpVPADNKwksP+i/WENQPUYysAmOveXDWUWPkOztiqMv8b5BwSwYNMffD8FqUkVe0hrM0brBiwAsNrvtJIC5jKbNnagKW6wjRAemJsGcDBlOVBh0bsncQsKkNubDg4K/nbQSF0r9QXTElA0SsHJcIry7uarc0LnXtZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRac+31B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b38de7940so1296381f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762859612; x=1763464412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FSw2q+tUzpKX3kn65yT6WaAtK4JE8qw4wJ/BIciekXs=;
        b=SRac+31BKxmRtPmr/k2ZUSe1tzvEvkkhnBdTX8ngJoHTVGc1cvgWfImTW3BgJcIPeA
         N4QugLCYiI1lOVZE+Zs6XIORSUpEw8XG94qkbtR4jeDnvhp8Z2gPNX2cNIYEh/Z1HSaU
         7v2MJ+XPdbqq9dbfHkUSNmyA6qz15WSVDsgZCIAy9euoIMTU0klt3uL1CoFxEbivzVDH
         iqgG5xpsOeAZoFcUMo6XXzSad1JkgBXDvsj1/Jq+7EMtxYdo/6bSj/ccS7VANuI6tlX5
         DXYji+VDuQEdpAEGe1sLIVnrYviuZbQXD2DZSLdX0Cvfg0ztx0kepaaBo2qDCbGOq+08
         F98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859612; x=1763464412;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSw2q+tUzpKX3kn65yT6WaAtK4JE8qw4wJ/BIciekXs=;
        b=DwJAxiDxvG71osjDwv/1UnlmaejG/1+BjwPM9dEopqJmr4tRr16PzqVlH1Vx/bPMgB
         kaIMxaQ/KrxSRfiabTpi89QY8HHezCh06S13vylIBzth3TOsVg7zjUv5szsWSCJY/b21
         J+HL6gNw1fwz0fXMgQPKpNFSuE/UOg2w0hw/ncBwM0CehYq7khKn9j47KQxNB/LXOUEm
         S1/gSOloaAXne6HqW82fXRhYreTa1SVDyq+sm0LVg6MviyraBeNgtoJiDItmp6lehTRA
         v8lazpQG0/X52++kkdl7KJ+gXMI3m0H51vsndia3GLeIcaNUbDgI3Esb1GX7lP2aRTey
         0TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYjstfbsePZyr0YheKnpSm3sH6fDjN87VpNJccbGkvSrFYVA/za4gNDI651z1jv9OkR1+kU3akd+3Vciw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+f0E2NMd9lhclouCKbhRBOGLY2u2OOgai9Vz/Q0pEty8F+TtV
	A/PO8a1QfhYJPmriFrp1unCCA17SOJNTPMhjHklp1cVNemimyEgFcTM/EqzDrmmReqo=
X-Gm-Gg: ASbGncui+KmAOKpi+oLJG+UnnY3Q68jFXB4/ML9vdby3IUtT4Qp9fcC78PC8zbQJ2jQ
	6UfWvZW75l8f+RB/igZNu+Y/oCNxufrPsShXlto1ZT8UOIC8aFRkt6xa001tcbm/np/Bu/FdCc2
	8UtWvNESNhSJIiPJyQpEX1zKEZHWDN2ehFhjJGvYYREa2vM1do0fgd6ovyUcPXfOyQgO8ytniRW
	UAxfnCuGRjXEOdb3PLYUq+Z0H6MZK6epBxnaGvrU807r3E59Ptsq2w4o1UEMMpasCi5w04ErnvU
	Kpw+XE+Hpt9Y71lFndT8XembYla4XVh5USWuKZ92PHc5sPSjCfu+4u95vOo3ANu9XfD5qdCz/yP
	4U4QK7wCJMPfQNcYQqSAxnK+8nPiIJuQTK4bUb0AoVlOT4CVY+qUGeLVO+xFfFflPaCMVCdNP++
	W4V5a14Ltgm2D7x50snYFzt/K0Ov6ta4gB84u4
X-Google-Smtp-Source: AGHT+IGt0mS3fikIe1P3rSFvFQbkViuKacA9P/wwJXnkM3SPblhW5wfnbrDtgVd0psK6reWFQctjYQ==
X-Received: by 2002:a05:6000:4107:b0:429:ed90:91dd with SMTP id ffacd0b85a97d-42b2dbe4274mr6796451f8f.6.1762859611849;
        Tue, 11 Nov 2025 03:13:31 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.139.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b380a3a30sm13530252f8f.4.2025.11.11.03.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 03:13:31 -0800 (PST)
Message-ID: <88737b14-1610-420b-bfcd-a4c8337eb4f4@suse.com>
Date: Tue, 11 Nov 2025 13:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsx: Set default TSX mode to auto
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: dave.hansen@linux.intel.comd, linux-kernel@vger.kernel.org, mhocko@suse.de
References: <20250820132104.8633-1-nik.borisov@suse.com>
 <d216cfac-803c-47d2-8fc7-dee3eb346d58@intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <d216cfac-803c-47d2-8fc7-dee3eb346d58@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/25 19:46, Dave Hansen wrote:
> On 8/20/25 06:21, Nikolay Borisov wrote:
>> The last known vulnerability concerning TSX was TAA (CVE-2019-11135) a
>> lot of time has passed since then and Intel has released a numerous
>> processor which do not have the TAA vulnerability (Cooper/Ice Lake,
>> Sapphire/Emerald/Granite Rappids) yet have TSX disable by default.
>>
>> I believe having the default to AUTO rather than OFF strikes a good
>> balance between mitigation and reaping the benefits of the TSX feature.
>> So let's switch the default to AUTO.
> 
> At a bare minimum, the help text needs to get fixed up too. It still says:
> 
> 	Therefore TSX is not enabled by default (aka tsx=off).
> 
> I'm also not highly motivated by the fact that CPUs have been released
> without TAA. I think TAA is mostly irrelevant. CPUs had been released
> with it mitigated even in the original commit that introduced this
> Kconfig option: db616173d787 ("x86/tsx: Add config options to set
> tsx=on|off|auto").

To add a bit more context about the change, SUSE has been running with 
TSX enabled for the past 6 years and we haven't received any complaints 
from customers. Furthermore, there are customers which explicitly rely 
on TSX being enabled for sane performance.

It's our desire to be aligned with the upstream default option rather 
than ship a different options, hence the compromise we arrived at is 
switching the upstream kernel to auto so that TSX gets enabled by 
default unless there is an explicit reason not to.

> 
> What has _changed_? Are there lots more folks who want to use TSX than
> there were in 2019? Did it get faster? Has the chance of it being
> exploited (separate from TAA) gone down?
> 
> Now would be the time for folks who are chomping at the bit to use TSX
> in their big fancy apps to stand up and say why they want it and why
> having their customers use the command-line to override this Kconfig
> default is not workable.
> 
> Also, from distros, why not just set the Kconfig option to something
> other than the default? I mean, we put Kconfig there for a *REASON*.
> Let's not pretend that it's a massive engineering effort to change it.


