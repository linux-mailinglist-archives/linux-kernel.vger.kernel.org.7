Return-Path: <linux-kernel+bounces-781119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E17B30DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34CC5678AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74163271447;
	Fri, 22 Aug 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ICeuazS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F0393DE4;
	Fri, 22 Aug 2025 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838297; cv=none; b=QSd2CVA13ncknpCrp1uH8DfFxJ4cEPTx9QyZ5BeOT+iE4iDK5O8iMq6qfB74lhTmzo0NWiALUc532aMT4T8Vw7XekND/cFSZHJrDf4LKZq2boVTpstCnuxdFlRXpmrHcuhlT62SAKxBxg1gGXTwJifm1t+uYGH3ISsdctErECVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838297; c=relaxed/simple;
	bh=D6wTeMrZWJGGAw5I8c6SVUz7qymK076WePTtoLzILdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONwNCcq9W6JBalrK+adZkE82QzpxcXp0nAsigiLPwqc6oIUYuSTW4KgorVqRVWm6t5QSNL7hqUxl1DvLFxDbeiayfeyiqKVbv9CqhVEUmUreQpN5y9LDabYMb8XIIPjOBgMVVAMWTMUx3azGdkRIIG6cUPn4ZBsGsD5YW+BFb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ICeuazS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC460C4CEF1;
	Fri, 22 Aug 2025 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755838296;
	bh=D6wTeMrZWJGGAw5I8c6SVUz7qymK076WePTtoLzILdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICeuazS3MCUCB9cWbsk6EpH5ODc7CvBx/elXVn1IQA139BZFbNphLF8e4BTkVRvFJ
	 nujNmorlJZlBcRImJbFqLhdARYHH/1HmbgHmY7vQTE67ogVTQMyQKQxf87EA8SQoa2
	 qEaWmgFabSN8/qSmbZMirjqrHvZXDUuxR/EWbH3E=
Date: Fri, 22 Aug 2025 06:51:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors
 capability
Message-ID: <2025082213-antacid-correct-53b1@gregkh>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>

On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
> The UCSI spec states that the num_connectors field is 7 bits, and the
> 8th bit is reserved and should be set to zero.
> Some buggy FW has been known to set this bit, and it can lead to a
> system not booting.
> Flag that the FW is not behaving correctly, and auto-fix the value
> so that the system boots correctly.
> 
> Found on Lenovo P1 G8 during Linux enablement program. The FW will
> be fixed, but seemed worth addressing in case it hit platforms that
> aren't officially Linux supported.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Any hints as to what commit id this fixes?

thanks,

greg k-h

