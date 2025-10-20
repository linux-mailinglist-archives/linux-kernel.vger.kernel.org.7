Return-Path: <linux-kernel+bounces-861304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A6BF2535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65F2A4EA153
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958E284684;
	Mon, 20 Oct 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAso6ABZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F11CEADB;
	Mon, 20 Oct 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976718; cv=none; b=aUAcBf+CaJmw0jq63c1wuaMJuV6nB4VqzVk0WLMvk+IoPFEfTiJ+lc/6cnxP2nyndJnpXn6fevYnpyGxU2Rjjf05c/8oT4TeJ4QtgsYW4cMKj+vf3i+0CathfwtqyUsPk+2uwxFfvjgTpBGJ45Cox1Mt2glF5pJKP+OedfmudAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976718; c=relaxed/simple;
	bh=NX8xIo2hifxRynZMH1JZIZLdy4bmxazzStoZZqwq6ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YccHvk88sjkLUu5HWmZCxwUxKTnH+E5bjAAX535ZxIXSo13fxnW/JZrwX9D4/pVJiz9dVwHYyscsO7rGllsgyzj8O/Wwq985BzNAGTncdy8OjrrMAW47N2hdJ4N1QDqhoMfpwD/9E6HoMWGULuyxEVR/j+jukTZOOMT4f0ETbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAso6ABZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB106C4CEF9;
	Mon, 20 Oct 2025 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976717;
	bh=NX8xIo2hifxRynZMH1JZIZLdy4bmxazzStoZZqwq6ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AAso6ABZdzm0nnnkB+ZrmRT+hqva/C/KikLf7s+YHeGUxnvJymuRR0YQXHgmaqOb/
	 IwqlGzdWhRb3ep58iSySgrx8QvdGWbId9/HdxSFJVbKs6a+S1Ls037MJ7q0CCUszGS
	 ARyg3EcM5pMT6QxcL3k3eVjtRi1jb3vBAJRBQ3YvS+D9W6JlY0JVZ1S5yRCG3U6AaG
	 xxJfrAWSyHtnk13+K0Lu7T2ppt7j4l/EMKGgvBO0clvryHb+HXSep1qLFchoba++3H
	 0Zn4Boh21pXTlFYdijLVJL45LI9cQAsDxAr1MZsZ+T/eYi9/c9fRCU2CWSnWpCNYgS
	 uHK8G6acOq1Jw==
Message-ID: <f875b4ec-4917-49c5-becf-e32c0d872f7c@kernel.org>
Date: Mon, 20 Oct 2025 11:11:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] Add Enclustra Arria10 and Cyclone5 SoMs
To: Lothar Rubusch <l.rubusch@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, martin.petersen@oracle.com,
 pabeni@redhat.com, rostedt@goodmis.org, bhelgaas@google.com
Cc: arnd@arndb.de, matthew.gerlach@altera.com, tien.fong.chee@altera.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251018121155.7743-1-l.rubusch@gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lothar,

On 10/18/25 07:11, Lothar Rubusch wrote:
> This series was already presented in November 2024.
> https://lkml.org/lkml/2024/11/16/198
> 
> Due to the ongoing complex situation with Intel's maintainership,
> the series likely did not progress further at the time. In early
> 2025, Tien Fong Chee (in CC) informed me that Altera is expected
> to resume maintainership in late 2025. I was referred to Matthew
> Gerlach (also CC'd), who, as I understand, is taking over at least
> part of the Intel/Altera-related responsibilities.
> 

I am actively monitoring and responding to patches. I will get to this
series as soon as I can. Trust me, I have a decent pile of patches to
work through. This series is on my radar.

> At this year’s OSS in Amsterdam, I had an encouraging discussion
> with Arnd Bergmann (CC’d), which motivated me to continue pursuing
> this patch series.
> 
> Hence, a slightly reworded update goes now again to the mailing lists
> and will drive the binding check bot crazy. While not all Altera
> bindings may be fully resolved yet, this series should not introduce
> any new issues.
> I’m submitting it based on prior acknowledgments and will wait a few
> weeks to see if a maintainer responds. If it remains orphaned, I’ll
> follow up with you, Arnd, as previously mentioned - this is just a
> heads-up for now.
> 
> I hope this approach is acceptable. Please let me know otherwise.
> Thank you for all the support in this so far.
> 
> Add device-tree support for the following SoMs:
> - Mercury SA1 (cyclone5)
> - Mercury+ SA2 (cyclone5)
> - Mercury+ AA1 (arria10)
> 
> Further add device-tree support for the corresponding carrier boards:
> - Mercury+ PE1
> - Mercury+ PE3
> - Mercury+ ST1
> 
> Finally, provide generic support for combinations of the above with
> one of the boot-modes
> - SD
> - eMMC
> - QSPI
> 
> All of the above elements can be freely combined, with the combinations
> specified in the provided .dts files. This renders the existing .dts file
> unnecessary. Any additional minor fixes to the dtbs_checks are applied
> separately.
> 
> This approach is also necessary for integrating with the corresponding
> bootloader using dts/upstream, which is one of the reasons for the .dtsi
> split.
> 
> Note: I used AI tools to help refine the wording of the commit messages.
> 

There were a slew of bindings check warnings from V6. I'm also working 
on fixing up the existing warnings as well.

Dinh

