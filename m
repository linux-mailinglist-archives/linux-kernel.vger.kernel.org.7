Return-Path: <linux-kernel+bounces-721973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10402AFD03F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606AF16B6ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CAA2E49A4;
	Tue,  8 Jul 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw3AElVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E22E4260;
	Tue,  8 Jul 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990959; cv=none; b=OYfkEwIYCmTWR+Z5ygpWQE2EB5W/YUp3RHWTk1fFyMR+ABoTUporO+mfvv/QLVBYiynzxV3SmnWzCKRxtgUwCAULpRBThnBFhUw47PihMOxKxnZ4wnalTeCNwAEDh1i23Hkj57KMqUMZiQ9EoNtw7x19bCaz3lLODCHrjuWD9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990959; c=relaxed/simple;
	bh=+dHSQ9JmLCMi6wTYdjTsY+jTAGkpsnOeqWcR/GE+OM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4euXsFmKc5WVWw7ltMXiqQ4s2nY5UFnX/4A5C3JSpC++oQaSVHRe6CoHT1bQY5IwjyN+6monYpS2l8ZCNgLjy8njOUKCthNO5QjJ2TdQwIHweRwCFs9//MACiL1IseERSE6RK+JmW7DMbhtryusCu+Zz1P8A+Ri4rbII4vB2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw3AElVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58905C4CEED;
	Tue,  8 Jul 2025 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990959;
	bh=+dHSQ9JmLCMi6wTYdjTsY+jTAGkpsnOeqWcR/GE+OM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lw3AElVu96ZxHWjVThIHiVkll4TVzL1PqMoXQLbAuAhrc4cqTc7XC0L7Vwfjq3QrS
	 6ZnV0QiBVgMUN0ro8hOlA0PnBTyz/6aSsqi0QL4LLRtehw+ju0dryymSYksoCg/4o9
	 t49p4h2FaY1xl4LCTa5Z+nfkHAQLz9fF12CoDiXsVzo1kAIZuagkWNotM8DHTOMZcX
	 dhQbffsff+fLrpeVwg6h5b9UvhUA/KTSAXw9X9YCkVMOYpbRQhCk7Idu4CmnZPD2GT
	 CEMlZtndH+qB8bavDB3Xvdy4VNr+WDysZUrh6pw2El6URQux3yJ76IhuKYTJtryvE6
	 OjIJMqWrblrMA==
Date: Tue, 8 Jul 2025 11:09:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jack Cheng <Cheng.JackHY@inventec.com>
Cc: linux-hwmon@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Jack Cheng <cheng.jackhy@inventec.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: Add q50sn12072 and q54sj108a1
 support
Message-ID: <175199095675.509662.6963890763247202312.robh@kernel.org>
References: <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-0-c387baf928cb@inventec.com>
 <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-1-c387baf928cb@inventec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-add-support-for-q50sn12072-and-q54sn120a1-v1-1-c387baf928cb@inventec.com>


On Tue, 01 Jul 2025 12:03:45 +0000, Jack Cheng wrote:
> From: Jack Cheng <cheng.jackhy@inventec.com>
> 
> Add support for the Delta Electronics q50sn12072 and q54sj108a1
> 1/4 Brick DC/DC Regulated Power Modules.
> 
> Signed-off-by: Jack Cheng <cheng.jackhy@inventec.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


