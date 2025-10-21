Return-Path: <linux-kernel+bounces-863002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC0BF6C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1820E487B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2C33710B;
	Tue, 21 Oct 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp7mGeKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5713370E7;
	Tue, 21 Oct 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053191; cv=none; b=r0GCKia5ZOwda4fP6CWFJ3eUab4l0HyHIa5Gvt/FKW7ITetk3AEWUG6ADjAcjqHi9rOi4LgeIsFcfXE5qRSzC9FP65ilsZIMdqZsHDFK0Yz9KuqLtDZlodkLHYW8hk2t00lrVdett2bPQlYbsrR2ZSeGuzum0f++NgaBu1FSnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053191; c=relaxed/simple;
	bh=mMSvgzeevb/tNsBtbMj0XDd/jCMbDeUuPxUm0ECM0uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef4g4AILX1+EUHoO2q/6VXvzkFZYLSXpcJPthYa04c3vIiBHAtco2z+h5UmlSufq0DQZNbGZCUUl1oEAj0ykbiiJbzS0PmsnCuJuzNli5Bz9bQYLWTLq/hY/FgOfVuKpWDio3IUR165nWTCTqG7Cg3CK9Dtuf8KSMAxXd0zPghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp7mGeKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A4C4CEFD;
	Tue, 21 Oct 2025 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053190;
	bh=mMSvgzeevb/tNsBtbMj0XDd/jCMbDeUuPxUm0ECM0uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp7mGeKybFExcxsSXsFQhYctj5YpaiLa67zVBsCwpKg0da2fFSm05GE2vkEoORwVP
	 NtBbJxuJ+AK74dRywC/fCs5Grpi/maWkMcuaJkejRNbOz4Y4t9gul8L/GDHCIhLhZs
	 3KWmdftqeO7Lf6k736beFglJ1WWqPe9+m3YR8Y6YSxadMl8t76bfKmJQTrRNuyvk2N
	 fY8ZDq2TV/PuTF0XN8RBJ9IFh9jaaV63xOPoRpR605saPLWCRMGhQ5YmuE4WY9HAvw
	 jXzH97sgoJtWZjwoPWXYYZo5YtoC7mr205oe1ntrW1J2D8v45bWeOvj7ybVFB0uWn/
	 2hIpkHZlIqJ9g==
Date: Tue, 21 Oct 2025 08:26:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-actions@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: Convert Actions Owl SPS to DT schema
Message-ID: <176105318705.11992.2891926937989289463.robh@kernel.org>
References: <20251013215834.783501-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013215834.783501-1-robh@kernel.org>


On Mon, 13 Oct 2025 16:58:26 -0500, Rob Herring (Arm) wrote:
> Convert the Actions S500/S700/S900 Smart Power System binding to DT
> schema format. It's a straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/power/actions,owl-sps.txt        | 21 ----------
>  .../bindings/power/actions,s500-sps.yaml      | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  create mode 100644 Documentation/devicetree/bindings/power/actions,s500-sps.yaml
> 

Applied, thanks!


