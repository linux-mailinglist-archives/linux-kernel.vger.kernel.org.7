Return-Path: <linux-kernel+bounces-726853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D009EB01207
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60B51C2690F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E21A5B99;
	Fri, 11 Jul 2025 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkRBkV/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296141A3155;
	Fri, 11 Jul 2025 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207121; cv=none; b=fbgl43W1auysSZDhE4Sd/IxBudlZPaQWRhPG3GGIlghCvh02nXJnEVUrK6AIH1iyYEu1gNMGVqRVCLidCt5dTLQsedYigQdnn3PONFi8PRE+KWMCVffkfJjce6JqIWXf6QaGWg9ArQu/BKEcR4NyerLd+k+xLARtvDl2nxkqHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207121; c=relaxed/simple;
	bh=KuLnRKLGioWUQByLwtaHFKMHDwatqsfOvmbgjMqtctA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgyhcRNNsalIfuuEY3Samqbx2xFRuxdE+5m+PPLB1W+EcYEHJejbhZ/UaJhF7RON8cEM1wOd+nYqUACkOtzJmcP44VtiQ3uLTfWD2SdficAvw1BtyQKseE8XrGe1wPEMpR6gKsFw7qCY5pPRBO85Gr88NUACAt8hUWyWGPZBqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkRBkV/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA3AC4CEEF;
	Fri, 11 Jul 2025 04:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752207120;
	bh=KuLnRKLGioWUQByLwtaHFKMHDwatqsfOvmbgjMqtctA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkRBkV/9HmId+PjSORfEv/uoK2D4l2gtUmhgmle5/A7werYDLF/exW3HN9yO4c3Aj
	 eSTu7tfG9/ROGOQcQXR/nF+qWS2POdJocC1kBZcKwDgU1O/809S9pTiHw73deSO1uY
	 jhbIXhsSE0OYg6VKelI9BlMSdXnL/tvR6z69KXbqefFMCJxTL7PdwnWoKriBWa/nWf
	 FjQiv30MYaw0CAxbDWKr44jkTqEut/C00jinBGSoIWYZENOpZ0N/l57bI4ERHZUQxi
	 1H04fhr5HfgzDM5OMMtopK8NqrC8291BGwAeJpRUx8kwzq8kjUfQJWEE14cIgAhhLN
	 jVBKcXhRHHa0w==
Date: Fri, 11 Jul 2025 04:11:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Radu Vele <raduvele@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
Message-ID: <aHCPDXonAevxkMho@google.com>
References: <20250711003502.857536-1-raduvele@google.com>
 <20250711003502.857536-2-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711003502.857536-2-raduvele@google.com>

On Fri, Jul 11, 2025 at 12:35:02AM +0000, Radu Vele wrote:
> Add a lock associated to each port to protect port data against
> concurrent access. Concurrency may result from sysfs commands
> and ec events.

I realized the critical sections are way too large.  What exactly data the
lock tries to protect?  Is the race possibility introduced by any previous
commits?  Please provide more context.

