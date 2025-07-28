Return-Path: <linux-kernel+bounces-747454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356EB13407
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2FE176777
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE14219E8F;
	Mon, 28 Jul 2025 05:11:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B6290F;
	Mon, 28 Jul 2025 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679473; cv=none; b=XawiukMHDEsW1Z4FZmLU9WNVBHaXNpAaL4GVwlGXX4WG55ebRriTj1lS12kimvPyNWyThgj+ynXHEUTN3F3Snc9rFAZ7Vs9IgyadsmFIjMeINC9qpszm6svijRl5Tz/t8Eff6CO/A8igLleS7uUDkKB9v760VYfPazQipq6oJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679473; c=relaxed/simple;
	bh=4nEe5PLFL6Y1WwycjvwOrFYlLqHEUi7f5SQZnpdS9AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnW/mCbksqXd8QGAGSokB9A2x60f0KmMfXa+YJ+AS7bVbHH7GvTL/X4ff/kgffJjWc489+e45XMkHbIUTDZDQryLEkdKjBT4w+vrJf7EWB+DiS9FIn+jXMFK3Ofob5+Kf7K+iVBe6aeOahvNe3xgZNfEvZsgdGu4Gef5AGq5yOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F09FC4CEE7;
	Mon, 28 Jul 2025 05:11:12 +0000 (UTC)
Date: Mon, 28 Jul 2025 07:11:10 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Erik Beck <xunil@tahomasoft.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Message-ID: <20250728-dashing-discerning-roadrunner-bc8b87@kuoka>
References: <20250727-linkstarpatch_v4_6-16-rc1-v4-0-0dfa7aa06ec9@tahomasoft.com>
 <20250727-linkstarpatch_v4_6-16-rc1-v4-1-0dfa7aa06ec9@tahomasoft.com>
 <9ebd9797-8d92-4799-bb8d-59a796e6043c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ebd9797-8d92-4799-bb8d-59a796e6043c@linaro.org>

On Mon, Jul 28, 2025 at 07:07:32AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2025 02:03, Erik Beck wrote:
> > Add device tree bindings.
> > 
> > This device:
> >   - Has not been supported previously in the mainline Linux kernel;
> 
> Irrelevant, drop.
> 
> >   - Is a single board travel router made by Seeed, using an rk3568;
> >   - Has four ethernet ports;
> >   - Has four USB ports;
> >   - Has WiFi (MediaTek MT7921e);
> >   - Has a real-time clock (rk809)
> > 
> > Base commit:
> >   - commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 ("tag: v6.16-rc1");
> 
> Irrelevant, drop. This should NEVER be part of commit msg, because it
> makes no sense once applied. It is not even true in that moment.

Also now I see checkpatch warnings...

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof


