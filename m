Return-Path: <linux-kernel+bounces-645439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FDAB4D85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB9466C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156841F3B98;
	Tue, 13 May 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Ogxl62"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721001E5B95;
	Tue, 13 May 2025 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123247; cv=none; b=f1zog/j/bxLSfaImEoRx8vxPlibcktRSMPOfbzcdx9U/YJdXXJt5PZlf6/9qCDe5DrHtb2UQQ97FkR5uKpzfRudUkNkjbUmm+tlHgXHZRURyksjVBhAiBa40TnxtYFb/IRwd/1cELrVA5xEhzjqGwp/u8KrAEFfmAKpY3Cg4RHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123247; c=relaxed/simple;
	bh=e5v0Hap6SaUTiJ36FU+2NrXuY1a9ISkdwMjpp0mHs7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWBm4HKsiKCirLvWEeGrfx001RIHON0xLthMjSq7EsfICtQXdWrTk/MuhdyICdy4XDCeIMOJzdj4rJIPNMh9U2diCXqt3IxSYyGdvolLcPJWXuQjp99XSGiuPZ1QVdTdoQbpJrmaAxeDJl20e8d7g87hoOdwrGt6yVdHjdVNdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Ogxl62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBB4C4CEEF;
	Tue, 13 May 2025 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747123246;
	bh=e5v0Hap6SaUTiJ36FU+2NrXuY1a9ISkdwMjpp0mHs7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0Ogxl62AH6VnNDZCxZuZXWYk4K+HMmNKMf1Q8J4qOhWOLeFJbD92A7V/njn0pWbM
	 0EGhO101pRcAvGnCFq1xMLL+c/yvFqRqTYeNIEu8DupMRhWVDB6rPV++s+YYKRUShI
	 wMUp4sgRhdvy5E0LT+k44cRO9aO0P7/atHc3Yy/cvm6Ny3vE0w73QDZsxtyIPUwnVD
	 EtWn4Qlrfbr/ca8s85018XChFEufNF84MRCw/4aMNpqltyyIFIGuqc0Fqr2TI5TEMh
	 SsqHzVjkBpmYjnyqbmscDeWSkTQIqwNTXT410EY3Z49wwa0MMXPUf8aUtnaVDisAZu
	 ePwbkC8uXzawA==
Date: Tue, 13 May 2025 10:00:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 1/3] PCI: dwc: Standardize link status check to
 return bool
Message-ID: <aCL8Kcseye3okRCt@ryzen>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250510160710.392122-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510160710.392122-2-18255117159@163.com>

On Sun, May 11, 2025 at 12:07:08AM +0800, Hans Zhang wrote:
> Modify link_up functions across multiple DWC PCIe controllers to return
> bool instead of int. Simplify conditional checks by directly returning
> logical evaluations. This improves code clarity and aligns with PCIe
> status semantics.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

