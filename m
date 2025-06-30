Return-Path: <linux-kernel+bounces-710097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E778AEE71F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 21:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0943AF3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B82E6D11;
	Mon, 30 Jun 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epguPmh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBE43151;
	Mon, 30 Jun 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310137; cv=none; b=qT2hRVhoyomnUwFFKkEtCS+x4oTwSt0doimBXj01vdI0+/Pbw9RDWi6p8iNNAH1P9lrwn47aH4swRi94OZbYujFFNV855HVa1LU0xWwtx4oiDDvXok0dBmk5YNXcDr0e3cOax14VhzbiMQ7LZCqR7S/36UjhX1vFYc3621F79Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310137; c=relaxed/simple;
	bh=gXjaSN0k3lznU4sgAYnTXC6GtTqY7k9V3HXXfKRy4mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOsgO6Z4mOTvnUOyqhv3i/IWZuF2hJUGfOZoFf6q/SEAxWI426zCv5Ge3NN8CJupYx1p6+9ewLk+1Bv4XU7WckxdWLwZHVc3RFMkdWCcYMqp3KSL/SOWyFYNrZ6qh8VBqYLDdD6LBwS0V7fWJ7EpJ/LgS1oF+WTmqqB2KN5qcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epguPmh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0ACC4CEEB;
	Mon, 30 Jun 2025 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751310136;
	bh=gXjaSN0k3lznU4sgAYnTXC6GtTqY7k9V3HXXfKRy4mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epguPmh8MyrJeCkgwxK7EQ7PGyTUFoqOJXXpmVyweNvm9Jpgrk2Hfx9Oi0G4Yl1Sc
	 3c8Wptu4jQuKHzWaxr/n13E/2d5V+XEJtyh164XbWW5s/He76ZKuTLQ0RauOWr+HOv
	 sjoF6cLGkZ50kLoGYXBOdae+hvzy7CS6EdrwkPkjMJ/NhPZ0LBS8RGE2L0a4tgwxdp
	 +0lm9le49S7SqLr31Z4tEhr/VJiNfKiYJznTBJj/kKbmtgIpuL/7iGdH0mIkfgBQmC
	 /JKV2mkjniib/q17TNwKCWBY8pfxn3gGEngzB+eSpMhXndUxH7dLMP4cm0tW5OR6+A
	 mHFzPtXSJzZBg==
Date: Mon, 30 Jun 2025 21:02:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, Raag Jadav <raag.jadav@intel.com>, 
	"Tauro, Riana" <riana.tauro@intel.com>, "Adatrao, Srinivasa" <srinivasa.adatrao@intel.com>, 
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>, intel-xe@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] drm/xe/xe_i2c: Add support for i2c in
 survivability mode
Message-ID: <wtuwnljkbqqmzvjc6kvdrjmpdcfo5pq6hslirf42wt5ncizzdt@6ofeiipffkcf>
References: <20250627135314.873972-1-heikki.krogerus@linux.intel.com>
 <20250627135314.873972-5-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627135314.873972-5-heikki.krogerus@linux.intel.com>

Hi Heikki and Riana,

> +err:
> +	/*
> +	 * But if it fails, device can't enter survivability

nitpick: the "But" follows the "if". As we don't have the "if"
anymore, the "But" leaves the reader a bit flubbergasted :-)

If you are going to resend, please, remove it. Otherwise it can
be improved before submitting the patch.

In any case,

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

