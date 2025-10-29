Return-Path: <linux-kernel+bounces-875167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3296C185CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F919C06DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BF2F7440;
	Wed, 29 Oct 2025 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea2h8PMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E97548EE;
	Wed, 29 Oct 2025 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717172; cv=none; b=H+HNMB8ViSXibnRErAR6eyqftYUv9LiIa9bxas474ZlPkDdAHV/URhYWlkoLb5upLl4zBmpYkdRyqr+OA8AgrbdiYOxApiNBc9pBE7ePRyTomYXJNUAhiam796QEWGP66ITSBR3kuxxolTTzS6fARN2NYprSA+OM/ByJdPvz6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717172; c=relaxed/simple;
	bh=t2OAaxS3wOZJ96sx/1U0Mf33iqWHQhqhtM+FHQmSM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdcqxIrphWOkN15N1z/iFbDW7+EdLRAHiXsfE+m7E9w47/uft2QL/UwmgLJFeJ5DuhEfe40sWlWmobMhuD4axma8+QlGY+ThHrHDPthrO9qcP0L99XLnCm5eeLM7QZ1QHfudGgL0q/ISZ9z2juUCtrVudaO1RJiWMHWy1dfxJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea2h8PMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C14BC4CEF7;
	Wed, 29 Oct 2025 05:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761717171;
	bh=t2OAaxS3wOZJ96sx/1U0Mf33iqWHQhqhtM+FHQmSM2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea2h8PMkfBD1QkHfA1E6oBD2dOmFHRHb1f28k1ERF1DCz9HRdg6rnplikDuFPMaF1
	 4+VeuZomyt+Xz9fAfQFKiypsQvVfTEDM5PeOyjyAqTWdBEibzyBT+YqgSlDIcGoaLT
	 iuJ+hax20NkCqvesZ5IxCit0pLEFoBzhAa+sRphxzCpO4QFaENz3zSROuRkpFJICX/
	 wlAoV4nC6oVduKs5i0KKNX9+EsilcE4jzT1ksWUTG0HVXwWC6CD+o1ZniXDqKZqQ2v
	 cqZOapLrEVGk71LMBYL/aCnxTmsoLitK68sE7gd4iAyLbTduZhJwLxQw423T54S1B3
	 XxXvh119/YQiQ==
Date: Wed, 29 Oct 2025 06:52:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: Add MAX77675 regulator
 binding
Message-ID: <20251029-festive-solemn-mouse-c7a3cd@kuoka>
References: <20251029023253.150257-1-joan.na@analog.com>
 <20251029023253.150257-2-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029023253.150257-2-joan.na@analog.com>

On Wed, Oct 29, 2025 at 11:32:52AM +0900, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
> 
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.

My comments form v3 were still not applied. I pointed out this at v4.

You still did not reply to comments. Did not implement them, either.

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof


