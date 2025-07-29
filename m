Return-Path: <linux-kernel+bounces-748948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456EB147EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB6C18954B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C7248F4A;
	Tue, 29 Jul 2025 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUsuasxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB232472AE;
	Tue, 29 Jul 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768333; cv=none; b=R+qIR+8iWhsrWJXL/4jURfRnU5mbx2RqfX1TMk4d8eaP5dfY0GzxmDGc/aBp8r7mRtwUwMTq0LqkOSlpPVYZybzNEKRJGrz8vcWoNsXaxVVV8OjcpM4cSqshSSfFlCMsAP04trrK468c1CytNlrw0PYw5Yogn7XFqplHH8gRinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768333; c=relaxed/simple;
	bh=UEiH9Ih/sg9T2Xc80cWXE9rcO43zyUZE5J6/0WXuUIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVn+HMfwzTH1UZs6NiaUkA2Q2jIAn8gGe1UHFHUtI6jZISVtqrigf3k/ao1qYcJw18gmLwt8oDAEiSfqy/Z23q2tj+nkeT6Tt9r05JhLPoxJ13lEiI4SbP/nJy9uuHFYAV+PpV1U1gq0t1/7cUehbdayFeF77Eo1fIUJCmp/kD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUsuasxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE65C4CEF5;
	Tue, 29 Jul 2025 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753768333;
	bh=UEiH9Ih/sg9T2Xc80cWXE9rcO43zyUZE5J6/0WXuUIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUsuasxcXtiuNv0x/vH9Fn1Ix1RlBIVu/05TYqXNjaGlyeda4dAPUFJg63RMhfjhJ
	 nYHIyVBrEqJOZOrWRcaSVL8WhA/ZR9DD14TFRXxkZWaBUtrjAms7uHc6FDevjPPRHI
	 g8coq1Kr3UrARZ6K259YzjupVTlvK6LogUFd+Cb0=
Date: Tue, 29 Jul 2025 07:52:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] tsacct: Remove unused macro definition
Message-ID: <2025072935-mardi-propeller-0d29@gregkh>
References: <20250729053359.49258-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729053359.49258-1-suchitkarunakaran@gmail.com>

On Tue, Jul 29, 2025 at 11:03:59AM +0530, Suchit Karunakaran wrote:
> The MB macro was defined in tsacct.c but never used, leading to a compiler
> warning. This patch removes the unused definition to clean up the code and
> suppress the warning.

What compiler warning shows this?  As part of a normal build?

We have loads of defines that are not used, especially in drivers, are
we now going to start deleting them all?

thanks,

greg k-h

