Return-Path: <linux-kernel+bounces-837553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C06BAC8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3237A2F97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340C2F3C3E;
	Tue, 30 Sep 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P8okNY3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD02222CA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229388; cv=none; b=DwnKZZev+aQ/FcxCPFGTaCJ9DQiYVL/HSbntE7I4frQEUYEwBCjS8ZvkfTOXvobRBfe35TqnM3Y79N8dgdeJ9eek30MYUjKRwWvgbyBHD5qF/HhwyiqwlnjATrpLum/pKXkv1xkAaEZ3a5hO9ZKv9twqvAvvL+9FXpbTDkLLCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229388; c=relaxed/simple;
	bh=y8R/6AmiIlSggawVurChmk3Eb3jJZPZ3IxiwxL6nbDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Czs9k4iZAyYuZAQOhD5hSvte6MHV8IwUZGJOAbNzBywd2bq0VsE2Aktw4rdMhO6Kon/MsURged76S1NbRc3Rud0a9aGZoW5yo8H766U6QbZzQdSZUtHcOsNxd7DhiZSiNsZsJ3dqnug6HRX2hIaAzn8AP7LCVI+CvlH1pD5765Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P8okNY3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9EDC19422;
	Tue, 30 Sep 2025 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759229387;
	bh=y8R/6AmiIlSggawVurChmk3Eb3jJZPZ3IxiwxL6nbDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8okNY3NQIIkPn5Qv4YogzAM9SokCInKX9qe2gxrn3jcY2FPI1qbJWP9V7Mn46WGo
	 q3n1eaxhCqieFq5kDd5YAvrreg4S+AaMmy8PFOcNXanqNoa17nU+VZjn2SGhzGsHNC
	 oOSdimDVYc/BmJ0GBIHudh1JLk6QgIaSo8k8my64=
Date: Tue, 30 Sep 2025 12:49:44 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Message-ID: <2025093000-shrank-vending-2bd1@gregkh>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>

On Tue, Sep 30, 2025 at 10:42:31AM +0000, Siddh Raman Pant wrote:
> On Mon, 28 Jul 2025 13:22:37 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > HID: core: ensure the allocated report buffer can contain the reserved report ID
> > 
> > When the report ID is not used, the low level transport drivers expect
> > the first byte to be 0. However, currently the allocated buffer not
> > account for that extra byte, meaning that instead of having 8 guaranteed
> > bytes for implement to be working, we only have 7.
> > 
> > The Linux kernel CVE team has assigned CVE-2025-38495 to this issue.
> 
> This commit prepares for the next commit in the patch series. See
> https://lore.kernel.org/all/20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org/
> 
> The patch series has 3 commits, with the main fix being the middle
> commit "HID: core: ensure __hid_request reserves the report ID as the
> first byte".
> 
> Unfortunately, the 1st and 3rd commit has CVE numbers assigned to them
> but not the actual fix.
> 
> Please assign CVE number to the middle commit.

What git id is that?

And this commit on its own fixes a problem, so it should be a separate
CVE, right?

> Segue: Can we not have same CVE number for a patch series fixing a
> vuln?

We can, but generally it's just one-fix-per-cve.

thanks,

greg k-h

