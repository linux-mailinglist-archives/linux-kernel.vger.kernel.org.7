Return-Path: <linux-kernel+bounces-722483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB91AFDB2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D343A84FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A025D917;
	Tue,  8 Jul 2025 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUkfwIrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24821E47A3;
	Tue,  8 Jul 2025 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014202; cv=none; b=iVG2NybFQW4zzrtoSj52xa7fR+GTosnY2mly4yaKZ7zoZYnTbbS4x6qr9+Wd01uoe81Zu7BTvaRN7kK4ERYuyPlyLeuGh4IgxUCdYnLsq9GBFhhsKGMROLeTFy6H6ZlY8GWOxQ2QFDhErgewqQYJpEmgXbSWw1/gPPaKGaBqsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014202; c=relaxed/simple;
	bh=5eoOYGA9ThdPasjjaFLkqUooNYXBJMphrUYEZiQOngU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHD8LF+/ur0BxXIwwv+NeacXc8KbnC3YN2ubceBpJ6gvnXpm4NuMQ7xHm7DEYY+Ubr3DioPqotEUiu/Qi9/2PghR4wRN/4LUJhVFGV1gC9USaCToZZ1uKTg7Eiypu7vAKE7KyVVu0UsHTY8MnQeSfNxoHSWfxJo6gJSQJSDu9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUkfwIrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A123C4CEED;
	Tue,  8 Jul 2025 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752014201;
	bh=5eoOYGA9ThdPasjjaFLkqUooNYXBJMphrUYEZiQOngU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUkfwIrKYe4yXb5NBG1KoccZhUKQPBdFlNK62U9rIYDAPMr06PhwM7Q3Q6s52yQfy
	 4IXqJh+w/vzYbPNAPc6V4QuLlSf1K1BJj6aV6E7ZFR1Vua/BgXPLarQox7ArKkTEXn
	 ve5dDmBDoJKRiIGq+hxUrLIHHbFR9dmBUG28Fqf9ZhgHspjWSsh+rGns19+aFnTfSt
	 kRxC9dbPMkibdZ8UUWaxKHnaVbth3nM6YNzjWLIv8MSdmdf/PGfvWHjm4n5XXM6PzI
	 aosWu7wwL8AOyi/YVcg2OqnLxYEKiv+YnM+eELOHW4f+nZD5aTqAGxpJahDN5hNsal
	 n14J5lPQiWGJA==
Date: Wed, 9 Jul 2025 00:36:35 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 0/8] Documentation for nova-core
Message-ID: <aG2dcwDOVlh3ePGa@cassiopeiae>
References: <20250708-nova-docs-v4-0-9d188772c4c7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-nova-docs-v4-0-9d188772c4c7@nvidia.com>

On Tue, Jul 08, 2025 at 03:49:40PM +0900, Alexandre Courbot wrote:
> This series adds some documentation that was relevant to the FWSEC-FRTS
> [1] series, but wasn't sent alongside it as it was worked on in
> parallel.

Joel, thanks a lot for this series. It's great to have this documentation --
very much appreciated.

Applied to nova-next, thanks!

