Return-Path: <linux-kernel+bounces-868753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94790C060DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0473A3D72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0132BF43;
	Fri, 24 Oct 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCn2K7sL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30432ABC3;
	Fri, 24 Oct 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305175; cv=none; b=XZ4L/Zui3My0pRWiE8USYRRUOOQ9FgwHbb792QrRGlvAZegKD4rkGQkaBnPlgNsx6WPwdnzjmc177HB6Fi5Fk6wk71FqnheB/aGLl1eQMK4JeW9/rBclLdzdeCeVCmI2iNOcTAqneyI8BmW8CiEIORU46ZTQi76efqqWjkG2m/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305175; c=relaxed/simple;
	bh=hdZEQYE5XmKn1cnt8vfDhB9Mvh98fj+DYIUBBlRU2rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh0bd1EjsAcVCkFV6w7l7kLSmRUo0iiM+lYnlGP++Q5y16sY6ZPxoT+9IcQNFXO/QZD1hG/5/W9y2VPnNbRoE3/2djbEpimIsEakAH3/d0Kti+8DXT7RssTgPrkc7IVQrf5eu4pCSw3RbbYgweSfdLcqsjz6GnxXZm26I4yDt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCn2K7sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2620C4CEF1;
	Fri, 24 Oct 2025 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761305175;
	bh=hdZEQYE5XmKn1cnt8vfDhB9Mvh98fj+DYIUBBlRU2rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCn2K7sLOKvA0wZYKHE0YFk1mRfBlrSqV8cGbTWalTQnxIyutiHpK5wGdOcLpdrYK
	 yAGllIKgtri5xDNrM/ew76bbLmmxOMGj/yf//WURFuK6zTise3CSYHLlASPVhv8DKa
	 ZG/dVXILHxVw+JVa3pcr6zYnJWp4e7MiOkpqrAurBG8f/CRZqQyyf2xfP1maqHaKzM
	 ZDP69azRJWOWJqzpcVIUBsOq0XYeIvjA3OOAwDlOQaZMlISCuTXDEmrD4y80ERhYJc
	 dv9gf8ILgl6G1IN7/qYyF1502A4alW5qsfkr3pCBTFw0seKc0eTP22GCS1wrOOzYDg
	 udY57Cnyln24w==
Date: Fri, 24 Oct 2025 13:26:08 +0200
From: Greg Kroah-Hartman <gregkh@kernel.org>
To: Steffen Jaeckel <sjaeckel@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, anthony.l.nguyen@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	dima.ruinskiy@intel.com, Mikael Wessel <post@mikaelkw.online>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
Message-ID: <2025102432-motive-passage-eacf@gregkh>
References: <2025100116-CVE-2025-39898-d844@gregkh>
 <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>

On Fri, Oct 24, 2025 at 12:53:44PM +0200, Steffen Jaeckel wrote:
> Hi Greg,
> 
> On 2025-10-01 09:43, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > e1000e: fix heap overflow in e1000_set_eeprom
> > 
> > Fix a possible heap overflow in e1000_set_eeprom function by adding
> > input validation for the requested length of the change in the EEPROM.
> > In addition, change the variable type from int to size_t for better
> > code practices and rearrange declarations to RCT.
> > 
> > The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
> > 
> > [...]
> 
> we believe that this CVE is invalid since the sole caller is
> `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the
> necessary checks before invoking a driver specific implementation.

Great, will this commit then be reverted?  I'll go revoke this cve now,
thanks for the review.

greg k-h

