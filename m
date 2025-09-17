Return-Path: <linux-kernel+bounces-821363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720BB81120
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243343A6490
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5602FB094;
	Wed, 17 Sep 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egqvu3YF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF382FAC15
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127504; cv=none; b=c9NLNPOWIJacGSwQ000fawSBDQPFVBkTjaVmcIhv09UnGs6DWvH+wxO3qH5hS1m6L2TDBMY9QXoxO+9ExB65W+qR9OAuGWh7lnW6JS8R6TpTYccb9UjKtP94uLcEG/ph48wha0RL0eunf1z9VgTYQh3a6c47dXcuq9Pm2kuJrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127504; c=relaxed/simple;
	bh=WRy7Z+bcwMk3wr3Dj9QRIuDHPYznnoCBTe2uMY9Zcws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxhNsbOduCsquwiHwNCyQk1kD89MhGK9NCCdBSAwcdEq0gAIxgLMU3/J6HLIML8lXONXC4bFNBYTEnUcRdNxb8Khj2ho5X1/6/JavG/53vgjOoZLZNHIbjmJVg1Gkqp0sd/h2yVikXcqjPKqt36WDig7vHlPIRvMAFj/4jwDC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egqvu3YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F6EC4CEF7;
	Wed, 17 Sep 2025 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758127503;
	bh=WRy7Z+bcwMk3wr3Dj9QRIuDHPYznnoCBTe2uMY9Zcws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egqvu3YF5xmuZYSNNTFeP/P2rKODTVnFovhJTpDjvXipQQHvGGA2CzxBRZz0pNp11
	 0vxF7OiJio8gzGJCCbsCxeRFrqEuuZ2FX3E9RdngQMBQ/qhOQv+JZRfh2RuPP8fCJ5
	 Ck/Xvh1lcj/scDgDDb3FYlHlLMSjqBzgRbgPsI4j7OmAWvrdqLlC1zPJikC05IltMp
	 Kpui3fG00mmu0G6Eqj52cJCU0gj1KOlioYa5r4z59smejO2DjU2onsq4QC8AnSS4Mm
	 RIU0kCFsUhXzwBPfeN1egsWu6sXiAe0WabMTsdLq5QtmYDVgopcwS42hv4ZHLJ9UZ6
	 T52oWTrhoku/g==
Date: Wed, 17 Sep 2025 18:44:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v13 8/9] cpumask: Add initialiser to use cleanup helpers
Message-ID: <aMrlizyqkQ9Zsrz4@localhost.localdomain>
References: <20250917161958.178925-1-gmonaco@redhat.com>
 <20250917161958.178925-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161958.178925-9-gmonaco@redhat.com>

Le Wed, Sep 17, 2025 at 06:19:57PM +0200, Gabriele Monaco a écrit :
> From: Yury Norov <yury.norov@gmail.com>
> 
> Now we can simplify a code that allocates cpumasks for local needs.
> 
> Automatic variables have to be initialized at declaration, or at least
> before any possibility for the logic to return, so that compiler
> wouldn't try to call an associate destructor function on a random stack
> number.
> 
> Because cpumask_var_t, depending on the CPUMASK_OFFSTACK config, is
> either a pointer or an array, we have to have a macro for initialization.
> 
> So define a CPUMASK_VAR_NULL macro, which allows to init struct cpumask
> pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively a
> no-op when CPUMASK_OFFSTACK is disabled.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

