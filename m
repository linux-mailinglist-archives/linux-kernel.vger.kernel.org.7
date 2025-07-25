Return-Path: <linux-kernel+bounces-745376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBAB11912
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06875165A19
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A862BD03F;
	Fri, 25 Jul 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9eZq1nR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89479291C0C;
	Fri, 25 Jul 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427995; cv=none; b=KV5/WFvQ0KCJiZkdSBLx1+vPz/3aPLstAXe6IdymeIrJppu+i4C94xvbcJO/k9+nW3/v476sDGF00TU4LVDhSpZ8hRVKpY2Uk2WAWp2a0G3pWi8tBkliDeqeFOtiGscQFcpRL5qy9JYAMInIxN3+IURpZ2svpBdDG/ozgxmqp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427995; c=relaxed/simple;
	bh=VR8JYjBGk/xk0gXQFHMEDYZh1TZoXARwpLjk2gA9b7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6K/yIqRQlz1sUsR1iPzwCd4RmoyawEY4EEHiMouR0A7hYdlPZaaukb5Vz8Cur9c3UwUhkdtzj6RHeMVyMFZka9LuoD9c58qs55WNXd1RwQCjcs0p4zHdIOURCXfKCsuCMk5DeSQ6KN+SAmb/Np3gGHvWMRVzSrGy9TBwZnh8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9eZq1nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F25C4CEE7;
	Fri, 25 Jul 2025 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753427995;
	bh=VR8JYjBGk/xk0gXQFHMEDYZh1TZoXARwpLjk2gA9b7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9eZq1nRLUaHP48slXu4Ckx0MAYnF8Zl/ga2C09ygsytDJwAl5/t0QSMiquwaJl1c
	 xb6D8QnY1yxzIwrslr8M2/A3H/77UpNN3iP/Gjh9iDn7MKc+Z+9lJiVztPYp0nKUbR
	 cJEjgLNqYI5DuU/qVIjb6tKxsA6LHkuns3x/tJsG3L2KtpkxVUNlpYDcEGNrW+hDsk
	 tXugQY1xPgLbw0xaPtZSx32zg/nKQIdGHWYgeFahhRQWvju2evkC2UwULYeWdgaxCY
	 gcD0qr43YynkPJ7AJoGQenGO+eiCwJDDBp3IrpS6K3d6u3RjbrpgJOTOxFsT+puCzM
	 QJW4gKRUd7+aA==
Date: Fri, 25 Jul 2025 09:19:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: Add MPS mp29502
Message-ID: <20250725-cuddly-peacock-of-advertising-2ffcde@kuoka>
References: <20250724091011.550761-1-wenswang@yeah.net>
 <20250724091306.551131-1-wenswang@yeah.net>
 <20250724091306.551131-3-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724091306.551131-3-wenswang@yeah.net>

On Thu, Jul 24, 2025 at 05:13:05PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS mp29502 controller
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

How did you implement previous comments?

Best regards,
Krzysztof


