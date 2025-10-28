Return-Path: <linux-kernel+bounces-874739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024FC16FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD5507281
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEF351FCB;
	Tue, 28 Oct 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap6HA4Ne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB13350A26;
	Tue, 28 Oct 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686504; cv=none; b=oqMXWs+l4Wyr065OFtc6T2FD7Ns2bCrygwEMu1TsFy/KTkvoVZrHntIL8T+jygVELGtFcN/iNJpV3sjMr3B8rZmOv3aJyF5PHnIIOKNRHjTBkTnKiZByoP28c0/juz9QUIGAwrTmBKbIKA6QvkPNQywGxaJRkzvzLZI9PvpKVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686504; c=relaxed/simple;
	bh=DuSnrySqhofeDqnS4DKDx+YN2NNZl32lm0X0WzjcLCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxMdzio+201oOIDfuhv7SvUCkVmDlshhh5O4WleKPoYBQ8PKmd2BgRiZx/sHxhw6s67WHqhs/RnchJi//dijfsOeyolPSh/1af6aZSFTmUJ6eIEj+dWHAlJ2+9USEUhfdxN3+L7GcE2QKiLgmxErLPNRj6PlfgwvL/cu69nXBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap6HA4Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9ACC4CEE7;
	Tue, 28 Oct 2025 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761686503;
	bh=DuSnrySqhofeDqnS4DKDx+YN2NNZl32lm0X0WzjcLCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ap6HA4NeTjzxTNaI8Je+9eZMy9Icq1rv4XN5dcZkcB6KM8wjzD3mUTdPbu6vIHs2C
	 f5wcH4EqRxyYhOp2aUt2iAYSddJCnLSkXvHmoy/5XNVnf45HFxOz2fRzfKW0HZFCED
	 l14CQb9w6rvGYavgn50RI2i70fPsvcGcIU4gSuwTOEotb9KzDBtVkcFahl5WhqsZQg
	 dcOlSNPev+fjWUNW9RWSCOFf2+mvUuLsX1kJtpCMRRudPCF7sdyFMzbzYEVdB8IJwI
	 bkJgygVnH2CJd4LXg5V74vIPVotNHoM3oi1HORihkL6lu9xeUOj3G/7joq76EWbJZ+
	 wyMeB9iwk6U5w==
Message-ID: <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
Date: Tue, 28 Oct 2025 16:21:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 3:34 PM, Antheas Kapenekakis wrote:
>>> The fan speed is also lost during hibernation, but since hibernation
>>> failures are common with this class of devices
Why are hibernation failures more common in this class of device than 
anything else?  The hibernation flow is nearly all done in Linux driver 
code (with the exception of ACPI calls that move devices into D3 and out 
of D0).

Perhaps you're seeing a manifestation of a general issue that we're 
working on a solution for here:

https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/

https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/

https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/T/#u

Or if you're on an older kernel and using hybrid sleep we had a generic 
issue there as well which was fixed in 6.18-rc1.

Nonetheless; don't make policy decisions based upon kernel bugs.  Fix 
the kernel bugs.

