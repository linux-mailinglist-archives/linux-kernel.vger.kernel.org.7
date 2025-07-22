Return-Path: <linux-kernel+bounces-740190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D287B0D132
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D72A541DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C828C2D6;
	Tue, 22 Jul 2025 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+vZz85e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDED4C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161946; cv=none; b=hlXicKnSo1anh6dsY/n+1EBWfFOUL54cVp2UzTWjt+tP9rx6o7spcGB5Dctfuvsv9JCgIrpAdsLE260wpasQVS3ZkbKeCCdg3tvRtf6ZNxpzxA02UkcseC92oOQNkekHXogLEgxekes8lcDPYjrtwa6s/MGw9TUfkHNUP7+ViMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161946; c=relaxed/simple;
	bh=S8eJ2zE2bJcCiLY5hdsxgdpt+XaUxvq97cTdsmOY9xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUXQpuRH41KG4XV3S6HFJs8/lG2WI8axqNbO4elx98fqWYT8TfXrojsHT6j7w+pQSk32eUluEadO9FAHRiSnDH2LEc6fcgnr/iyUZb+Fsi0trZib+nlbDbHerqNOWXS4L0id7pX0SKmSVAHgLVV17KAOEeRdkY4yYNYBD/duqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+vZz85e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8537DC4CEEB;
	Tue, 22 Jul 2025 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753161946;
	bh=S8eJ2zE2bJcCiLY5hdsxgdpt+XaUxvq97cTdsmOY9xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+vZz85e0qxGT+U797OBHwLWt4lb9vwhjrY4ncR/1CLELGkk0i0c0kbez4Dxpvoy7
	 ISUxEekcPzfdVkkqZBW4vOnbawQZ9sF5X/9hTVVnd5xQQRUGyeN5oIcWn8YvH26lm3
	 L8OEqr8VY75mr8IvimqHk4r08LOkjVkrr67OIIFY=
Date: Tue, 22 Jul 2025 07:25:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
	Kees Cook <kees@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	kernel-team@android.com,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] binder: Fix-up binder_alloc kunit tests
Message-ID: <2025072227-obscurity-manor-a8c7@gregkh>
References: <20250721235449.1316533-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721235449.1316533-1-ynaffit@google.com>

On Mon, Jul 21, 2025 at 04:54:49PM -0700, Tiffany Yang wrote:
> Do clean up that was requested in reviews for the binder_alloc kunit
> test series [1] after it had been accepted. Add a copyright notice to
> each of the newly created test files, as suggested by Carlos [2].
> Replace instances of snprintf with seq_buf functions, as suggested by
> Kees [3].

This should be broken up into "one patch per logical change" please.

thanks,

greg k-h

