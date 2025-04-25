Return-Path: <linux-kernel+bounces-619618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9063A9BF04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEC61BA2E80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C422D792;
	Fri, 25 Apr 2025 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3sLd7wj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B1199931;
	Fri, 25 Apr 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564207; cv=none; b=Fee6wW7UVgBzHvZk7TRdGcaWm2vGkD3PI2f6CWcJnqTjjR5lFfP+jo8Lzn5xKksDd/IiB9Ux72sziCQWE7GYETGBz6yb769SwQBZalKdME8xGRMfDi3qql83snQteAgpPJLtjRhYbXyWamLLMNPNKANi/mBORzZ4rJ0Id5hzfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564207; c=relaxed/simple;
	bh=dTy+FXOzLAo5sl2RtNZyAr8pL8e+YYGn3pugo1LCZWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdS34hHvie1m+dQvcHv6Uyq+Fznj2YgE2T8yPFipCS1SsJX3diSs3tjAlJVjLnOtc7zswIWouUQ5ZA9ePVcC2/gF/jWeCxApUYyUiRXQv+HuhOOnt8KKoDIa6JFlv4YI7ZHGOdb3o2I4L5R1eEICWGBv7tTuvunE8JHK5+5Xyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3sLd7wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B37C4CEE4;
	Fri, 25 Apr 2025 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745564206;
	bh=dTy+FXOzLAo5sl2RtNZyAr8pL8e+YYGn3pugo1LCZWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3sLd7wjrYLPpIUiBgiqbvwwmkhmfEHgbPk0sAQxOYX9iwDRBZxsKa9b+7YMAzq28
	 GWWlThc0CI0QQXIMAbIo7xfSYJaWaI95PnYGWkFxAG/4o04SL/8tIYFCTHvM036ESl
	 qJ30/MKfnMn1EgXrjTzL21DtmA9JDBsBtnA00Ss1iBTGXr9BZ/W8Sp3iui0ZLo1iDZ
	 9fzlmBIjw92OJCLinCvyoZ1qDjs88Am8SvisYmtWBq7YAtjpf20XOfPBFLMPwvnrQg
	 Cd9qLGzNEObRn3dDM9RXoyUfc07kv9DyqN10b6Zr38gWCd1MNLEntXYsuCYIGATmQ3
	 4rzaH9qUiSfig==
Date: Fri, 25 Apr 2025 08:56:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com, srivatsa@csail.mit.edu, 
	shubhrajyoti.datta@gmail.com, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v6 1/6] cdx: add the cdx headers to include/linux
Message-ID: <20250425-nippy-giga-stallion-0bbdfe@kuoka>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
 <20250424132118.17074-2-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424132118.17074-2-shubhrajyoti.datta@amd.com>

On Thu, Apr 24, 2025 at 06:51:13PM GMT, Shubhrajyoti Datta wrote:
> Move the header files from driver/cdx to the include/linux.
> Adding the protocol, mcdi and bitfield header file to
> include/linux. This is in preparation for VersalNET EDAC
> driver that relies on it.

You should move only publicly exported pieces, not entire headers.

Best regards,
Krzysztof


