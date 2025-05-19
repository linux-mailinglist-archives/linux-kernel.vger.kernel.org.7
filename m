Return-Path: <linux-kernel+bounces-653601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C1ABBB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6217F17BFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8802741CA;
	Mon, 19 May 2025 10:56:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980226C39D;
	Mon, 19 May 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652216; cv=none; b=g/pvdDNzVnHch4I7lPfy3aSlGv1yHNNdxNIZAZb5g0u07epGeij/OB9UUFon1NWT2Ap5JSkKxUwO73CzVz5BqIhLjYtt6oUbnyXVwov1rXgcUHLtVQ6Yd/0Xk4DbDjTxmAmkdztBYZivODDfvKZQa5fFRLXz8D6su5B8EegmMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652216; c=relaxed/simple;
	bh=zFXlNut/pUjoMyE+iTK+XDo66riL7v/QWb1005ljrzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8Q7rHkEHbgOGJHg8RzV07qWYLh/ZdMCE9lOtdw9EV88D6fkJKAd8IA/HErZtU+HKLuPZWip3mTkjn5yhS3Hyp8ptRvEAeTWnTmGIy/T2DUlobVQme/Fj+5EbcGrNh7fvxADoyb9ZJJun2BNdNhCIYAehi8gAGhHjR1Ma7qHgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D7C4CEF0;
	Mon, 19 May 2025 10:56:53 +0000 (UTC)
Date: Mon, 19 May 2025 11:56:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: James Clark <james.clark@linaro.org>, James Morse <james.morse@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>, Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: errata: Work around AmpereOne's erratum
 AC04_CPU_23
Message-ID: <aCsOc7VeJTJFk-x6@arm.com>
References: <20250513184514.2678288-1-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513184514.2678288-1-scott@os.amperecomputing.com>

On Tue, May 13, 2025 at 11:45:14AM -0700, D Scott Phillips wrote:
> On AmpereOne AC04, updates to HCR_EL2 can rarely corrupt simultaneous
> translations for data addresses initiated by load/store instructions.
> Only instruction initiated translations are vulnerable, not translations
> from prefetches for example. A DSB before the store to HCR_EL2 is
> sufficient to prevent older instructions from hitting the window for
> corruption, and an ISB after is sufficient to prevent younger
> instructions from hitting the window for corruption.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

For the core arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Marc, Will - any preference on how this should go in (kvm or arm64
trees)?

