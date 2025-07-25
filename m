Return-Path: <linux-kernel+bounces-745757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED1B11E03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ECE583611
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BB2E7BA8;
	Fri, 25 Jul 2025 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8CTo6e0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA061224225;
	Fri, 25 Jul 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444783; cv=none; b=E0mcCTTQgptvwPLjFvS/2MHkbRFtUkAw/rTyrYGiOSwfmhT5Q7pn1gQRciKeuv/+zxz/zPBRxd1GNNVQ7TGSO5KNtllpieKWUqHSZZvOJLZEJ1UjMDXx0cOOJcCu58eharN6WCQisR5sKcxRPP/aoarXyVUvUL4tifsDnXSGW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444783; c=relaxed/simple;
	bh=H5tg3SeJGrLCCrs8Qf0ae3+N8qspr5A+ip8m7pauS1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT6B28BWEEI2uFmo9q7fkEIwogislM5PL5JQOigmb0H93Mn1v8G1RHB5wr57+1TJR416X/QlK/df/ml1n7PGxiVNN1gPF5EhiAZBF1q0NhotEikkHHwKlpF6rko0+AktlSJ50RRJDuGYUgrerMtutRICE50zu+/3/0ixYlNxW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c8CTo6e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3CEC4CEE7;
	Fri, 25 Jul 2025 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753444783;
	bh=H5tg3SeJGrLCCrs8Qf0ae3+N8qspr5A+ip8m7pauS1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8CTo6e0PQlRkZp/cvin4nbHYq0oaSKYymC0ODHGx2n5DjwrKeSaQkqL5N7y5MqYY
	 Mc/M9Y10Ilu5jjgXG4yZfYrY+NR+QqsNDhvS5BKWqjCmvm5NtgT+xgFBfw9b7Pn9am
	 MN1Qt5nc2arGz/U9+rA172GUlp6uSlGvtOUxjASU=
Date: Fri, 25 Jul 2025 13:59:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Add shutdown handler
Message-ID: <2025072512-hertz-dentist-67dc@gregkh>
References: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
 <2025072542-bleep-parting-3e7a@gregkh>
 <852ff03d-84cf-42f1-a428-ec747bea835e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852ff03d-84cf-42f1-a428-ec747bea835e@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 03:28:12PM +0530, Prashanth K wrote:
> 
> 
> On 7/25/2025 2:18 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 25, 2025 at 11:51:58AM +0530, Prashanth K wrote:
> >> Currently during system reboot, SMMU disables its translations
> >> while devices like USB may still be actively using DMA buffers.
> >> This can lead to NOC errors and system crashes due to invalid
> >> memory access.
> >>
> >> Address this by adding a shutdown callback to dwc3-qcom, which
> >> ensures proper teardown of UDC stack and prevents DWC3 controller
> >> from accessing memory after SMMU translation is disabled. Reuse
> >> the existing remove callback for this purpose.
> >>
> >> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> >> ---
> >>  drivers/usb/dwc3/dwc3-qcom.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > What commit id does this fix?  Or is this just a new feature?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I didn't Fixes tag because a small dilemma. This patch is rebased on top
> of the flattening series, specifically commit 1881a32fe14d ("usb: dwc3:
> qcom: Transition to flattened model").
> However, I don't think that this commit caused this issue.
> 
> Let me know if you want the Fixes tag.

If you don't need/want this backported to any stable tree, then leave it
as-is.  Your choice.


