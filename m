Return-Path: <linux-kernel+bounces-775974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060FB2C6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0131BC3ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139A25F973;
	Tue, 19 Aug 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/HDOLVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8632BD04;
	Tue, 19 Aug 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613631; cv=none; b=SG1abb5NCXD2yYggRu40V1+YfI6gS7Dl9V6NPGB6bFFmtnkVgeO+QUPZuvQOw1EskQ4Guz+rmsSwOgLoeY0A8zZXNqhSkYcA/ObDLe1ClU2vwz266SihTbbPLrDI52ENUy/NGNDFtkmqIzO1PlmIadshQllz4GWARsvOcDH759Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613631; c=relaxed/simple;
	bh=SKAuPgHYFLkG3xi4u2N/IxMYvXw2O5MFk+tqix2Y494=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpYNz4asX/oznJZguPhcUE7qwD82PxvbbU3VkNRu6VfUYTPPUQZElSSD0lFv9TPPoQAFU6ZLOCeZhqB342K0groZqg1HbSbPzjRe2P4X3XnU5AXBU4bYcQIHNlRyfrmC0oGNA0+904SrQZMNI0Egkc481T+2s93PswX1GT/4WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/HDOLVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68283C4CEF1;
	Tue, 19 Aug 2025 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613631;
	bh=SKAuPgHYFLkG3xi4u2N/IxMYvXw2O5MFk+tqix2Y494=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/HDOLVmwAmqhSY0NwTRhTsY/RuI303KBlbDyaFY4O1oPKg+4Z390ZIZYnD2P/gJY
	 3vX8NWPWBHm3RdiuRoSvLWes9gYJCW6M2B6sBEYrBrRZ9arTdwvnhynhCXYyTShdbo
	 m+c+0wpqoJ7Ra/V1VxIXMeiMfGYz2YtsW/GFq9XjNvr4Q8RVqfkRnGZTcak3uG1bXr
	 BQfu8tPiAb4WhGSa0uUH4d5f17vdxH9pCS0CV4k2uKnKnH3FmjuPLnhogVY1JiOGfB
	 F4OOLXSXFaM5tNPFhSICvAnGPNXsEPzPyPXb0T/lQ1jjYKgXNdboaZkG+kD3REvOJw
	 OX0J1++b0c2+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uoNIr-00000007JRQ-1Hjj;
	Tue, 19 Aug 2025 16:27:09 +0200
Date: Tue, 19 Aug 2025 16:27:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts/sphinx-build-wrapper: allow building PDF
 files in parallel
Message-ID: <nmdgtlqqaaqx33ynrpuijm4rlfju7vd7gsbjahcpvl5bwig4xw@zxgo6vvbqitw>
References: <cover.1755540431.git.mchehab+huawei@kernel.org>
 <26e5efca73dbd2f863a51018054a749c9e5f5a19.1755540431.git.mchehab+huawei@kernel.org>
 <19f031e5-0060-4957-8cc8-9cd21e7d6304@gmail.com>
 <87h5y3v456.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5y3v456.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Tue, Aug 19, 2025 at 07:21:09AM -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
> > I couldn't test this because I couldn't apply your sphinx-build-wrapper
> > series on top of docs-next.  :-/
> > Which commit does it based on?
> 
> It is built on top of the PDF series - I ran into that too.


Actually, the sequence is:

	- PDF series
	- sphinx-build-wrapper
	- this one

The dependencies between PDF and sphinx-build-wrapper are
trivial, though: both touches the Makefile; the first one
changes a broken parameter for PDF; the second one simplifies
it a lot.

-- 
Thanks,
Mauro

