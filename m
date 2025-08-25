Return-Path: <linux-kernel+bounces-784451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B9B33C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2161188CAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775882D94B6;
	Mon, 25 Aug 2025 10:05:12 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467992D46AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116312; cv=none; b=NiBXadyAu7VD+okG3E6QZGx6lWKUHj2KuLAUUqqh6H8gL+UAnWFeBvCkVJPOkkrpXN1wWlRlTn48e1DqYKFgWhHUJ9XKz0o4UKGwNbqmBXdwaTQ9htSL92PJLHTosWc8s0QOLhF4n6DKwMpE3TPMYIrHAg2Wy5QxZ9+oS6xxSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116312; c=relaxed/simple;
	bh=xA4Bevc65Progms2TjLIsB4K7fMHALISPIPu5s9dzrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGtZ6hVhphZv9QOKPd7EbRj8zSrk8YEnP0COpWk57JfYP1PwHwsmn3Kn4qecs78Hjlaj8fUao8pfLvgN3LlFXjuBpnyZm5ugzC7npctqrH4WeP6B50UrJEdjp+WPewEJRoaZ2ZFl1xXze5iXJe8u3WB6lPH+NlUx9CEKj6++h6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Aug 2025 06:04:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/5] iio: mcp9600: Features and improvements
Message-ID: <2025082506-functional-otter-b04749@boujee-and-buff>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250825103740.31ed77c8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825103740.31ed77c8@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 25, 2025 at 10:38:47AM -0500, Jonathan Cameron wrote:
> On Fri, 22 Aug 2025 09:23:49 -0400
> Ben Collins <bcollins@watter.com> wrote:
> 
> Series applied with that unnecessary include that David pointed out dropped.
> 
> Applied to the togreg branch of iio.git but initially pushed out as testing
> to give 0-day a few days to poke at it.
> 

Thanks Jonathan and to everyone else for the input.

> 
> > ChangeLog:
> > v7 -> v8:
> >   - Style changes in dt-bindings example
> >   - Simplify some return value checks
> >   - Move assignment to where it's checked
> >   - Speeling
> > 
> > v6 -> v7:
> >   - Separate out the mcp9600 IIR series into its own series as there is
> >     a lot of conversation around implementation (removed related
> >     comments from this changelog).
> > 
> > v5 -> v6:
> >   - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
> >   - Correct some constraints in dt-bindings
> >   - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
> >   - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
> >   - Cleanup tabs that were converted to spaces
> >   - Split thermocouple-type default to separate patch
> > 
> > v4 -> v5:
> >   - None
> > 
> > v3 -> v4:
> >   - Based on feedback from David Lechner <dlechner@baylibre.com>
> >     * Allow fallback compatible in dt-bindings for mcp9601.
> >   - Based on feedback from Jonathan Cameron <jic23@kernel.org>
> >     * Be explicit in patch description for fixed width changes.
> >     * Check chip_info for NULL to quiet warnings from kernel-test-robot
> >     * Remove "and similar" for long description of MCP9600.
> >   - Set default 3 for thermocouple in dt-binding
> >   - Rework open/short circuit in dt-bindings
> > 
> > v2 -> v3:
> >   - Improve changelogs in each patch
> >   - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
> >     * Set register offsets to fixed width
> >     * Fix typos
> >     * Future-proof Kconfig changes
> >     * Convert to using chip_info paradigm
> >     * Verbiage: dt -> firmware description
> >     * Use proper specifiers and drop castings
> >     * Fix register offset to be fixed-width
> >     * u8 for cfg var
> >     * Fix % type for u32 to be %u
> >     * Make blank lines consistent between case statements
> > 
> > v1 -> v2:
> >   - Break into individual patches
> > 
> > v1:
> >   - Initial patch to enable IIR and thermocouple-type
> >   - Recognize mcp9601
> > 
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> > - Link to v7: https://lore.kernel.org/r/20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com
> > 
> > ---
> > Ben Collins (5):
> >       dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
> >       dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
> >       iio: mcp9600: White space and fixed width cleanup
> >       iio: mcp9600: Recognize chip id for mcp9601
> >       iio: mcp9600: Add support for thermocouple-type
> > 
> >  .../iio/temperature/microchip,mcp9600.yaml         |  57 +++++++-
> >  drivers/iio/temperature/Kconfig                    |   8 +-
> >  drivers/iio/temperature/mcp9600.c                  | 151 +++++++++++++++++----
> >  3 files changed, 187 insertions(+), 29 deletions(-)
> > ---
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> > change-id: 20250819-upstream-changes-c89af86743fa
> > 
> > Best regards,
> 
> 

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

