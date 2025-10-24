Return-Path: <linux-kernel+bounces-868838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFDC0648D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C286F1AA40D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83B3176E3;
	Fri, 24 Oct 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX9Muh2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95E3191A4;
	Fri, 24 Oct 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309608; cv=none; b=asav7xedo+bQ+m3n9CHYr9SFr2ohMSzL3yKkWL2D7bgaVsoBMW9blQUAMJvpRro+W6m3b/pNW3876Fd/C8GGRGyBmaz0P/AI0DSUdsK8nhaJ788Oap0EkKlAMSIH/tIyM+poAqH/knzCQRNTiSLkLvgy++Jp+h6JTslgA/a/+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309608; c=relaxed/simple;
	bh=ov/mJRpGjcnbWbNRcCb4IScCIGVbiV/goE+EpvdsJKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz+rXBdU3LRMCSbgWi+Xzod6kV7IxrqOnZV32f6VM6TOriInMlw5T1KF0RQzgbN1BXvh6Fbkzl6LwuJfO/Vcuagiq+7z7CqevxNsnZZRKXp6/T6Lka/+LV8jy3rGqZKv3YyuBaVxNiXSmNuFOzFKoLj6mIdbel5oM8mfQT5VTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX9Muh2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2953EC4CEF1;
	Fri, 24 Oct 2025 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761309607;
	bh=ov/mJRpGjcnbWbNRcCb4IScCIGVbiV/goE+EpvdsJKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX9Muh2+BKGA1HorCeMzv1BnqR+HbQmsUvRC9S2NxvWCb4pcJKlIxwo+F1HDg3fsY
	 qZQBXUMlcLNWQgsd7XJA3s8gVP6Q6oVVUs6UoqJWlsMVOROUCOFIUSlp/5VVJNfQWc
	 fUbOeGEOP9Ymz4VP7BIFqd6vb5Y+DKnyqUweHCSAoB2BVIInpHLaw4t3anVHJ6y/Mv
	 RUnKgCVPIsz6W11U1xAqr4lgVyVhnRcw0/yfRlHkcX7nCmZvHmvHI8kGDarKB6SRMt
	 pngOSpn6nPql7jEmk4ZF/IQFdxbkeyKQnnN5tmnmDBaMmNctGwP9DQsJY1gf6QRNHD
	 jjFbGwNjQM97g==
Date: Fri, 24 Oct 2025 14:40:01 +0200
From: Greg Kroah-Hartman <gregkh@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steffen Jaeckel <sjaeckel@suse.de>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	dima.ruinskiy@intel.com, Mikael Wessel <post@mikaelkw.online>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
Message-ID: <2025102411-hamper-botany-b6d4@gregkh>
References: <2025100116-CVE-2025-39898-d844@gregkh>
 <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
 <20251024132734.30522c31@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024132734.30522c31@pumpkin>

On Fri, Oct 24, 2025 at 01:27:34PM +0100, David Laight wrote:
> On Fri, 24 Oct 2025 12:53:44 +0200
> Steffen Jaeckel <sjaeckel@suse.de> wrote:
> 
> > Hi Greg,
> > 
> > On 2025-10-01 09:43, Greg Kroah-Hartman wrote:
> > > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > > 
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > e1000e: fix heap overflow in e1000_set_eeprom
> > > 
> > > Fix a possible heap overflow in e1000_set_eeprom function by adding
> > > input validation for the requested length of the change in the EEPROM.
> > > In addition, change the variable type from int to size_t for better
> > > code practices and rearrange declarations to RCT.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
> > > 
> > > 
> > > Affected and fixed versions
> > > ===========================
> > > 
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
> > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
> > > 
> > > [...]  
> > 
> > we believe that this CVE is invalid since the sole caller is 
> > `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the 
> > necessary checks before invoking a driver specific implementation.
> 
> Nothing stops an attacker-written program doing the ioctl.

How exactly would that happen given that this all goes through the
ethtool "wrapper" for the ioctl function?

And if that is true, then the other set eeprom callbacks also need to
have this same "fix" for them, so it's either one or the other :)

thanks,

greg k-h

