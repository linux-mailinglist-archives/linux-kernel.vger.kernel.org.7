Return-Path: <linux-kernel+bounces-873965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D212BC1533C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532C85875EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772832D450;
	Tue, 28 Oct 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F8cI6hdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8C244686;
	Tue, 28 Oct 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662039; cv=none; b=HpW7u4pViOhrmhXMMa3+Dsv5JEr4QiHaID2eVOPTTYghtvctIrLpiD4x79WWJeahhgCw4DXJYwWRXk0+2kv8QobM58qSPpUZ2RtxhigRInBJNHCGS16KvjTyS4jn2Avy0w++JzWyvR1DlPWWHhc/zp4+xzxDGFSqi4Kih1ZZXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662039; c=relaxed/simple;
	bh=IPiuye0G0ziezFVxKudFMVQX3Gml5aAfJDahBkPrTcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keZ2Y5WNueOcrbnzthv0+Po3ADPW9o/n6lCjQoWLP5WLolQJDkavZ/YhSaZJnfcSBIlz6RHOpCZkl2SYFzM2yhQoo/QbAPqvZmywNbqGZsPfVnh9gQ2VckSnfVFRGFztdHPL+6zX6+9JI87WxVRejdzKnI61TQ6QzvPRYjES/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F8cI6hdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1158BC4CEE7;
	Tue, 28 Oct 2025 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761662038;
	bh=IPiuye0G0ziezFVxKudFMVQX3Gml5aAfJDahBkPrTcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8cI6hdNYJZZXnysaQ3qKV0HEAlrinQ/36w0vFX+YlxVFETz0FmCdhxsjqqfLR9mm
	 +6zSjHCJkmw/++LgUlVv6b66Jrci/zdfnAUX6T/TGHeMDkmSaZIGDd1NSgHOATXDdi
	 zb/lBCAoFTLBmKAvf46YVLfXHW2PpvYmB0zJ1/Wk=
Date: Tue, 28 Oct 2025 15:33:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Detect and skip duplicate altmodes
 from buggy firmware
Message-ID: <2025102834-unwanted-slacks-c7ff@gregkh>
References: <20251016055332.914106-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016055332.914106-1-acelan.kao@canonical.com>

On Thu, Oct 16, 2025 at 01:53:32PM +0800, Chia-Lin Kao (AceLan) wrote:
> Some firmware implementations incorrectly return the same altmode
> multiple times at different offsets when queried via UCSI_GET_ALTERNATE_MODES.
> This causes sysfs duplicate filename errors and kernel call traces when
> the driver attempts to register the same altmode twice:
> 
>   sysfs: cannot create duplicate filename '/devices/.../typec/port0/port0.0/partner'
>   typec-thunderbolt port0-partner.1: failed to create symlinks
>   typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> 
> Detect duplicate altmodes by comparing SVID and VDO before registration.
> If a duplicate is detected, skip it and print a single clean warning
> message instead of generating a kernel call trace:
> 
>   ucsi_acpi USBC000:00: con0: Firmware bug: duplicate partner altmode SVID 0x8087 at offset 1, ignoring. Please update your system firmware.

Is this firmware in devices you can buy, or was it just in devices that
were pre-production?

thanks,

greg k-h

