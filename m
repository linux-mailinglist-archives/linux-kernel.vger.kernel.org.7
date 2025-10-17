Return-Path: <linux-kernel+bounces-858070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5596BE8C70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4B626590
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95C34DCE9;
	Fri, 17 Oct 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAyi/b+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANUun0mO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03676231C9F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706984; cv=none; b=fjGob9RKBQ5tNeFA7veg12/WvMp0qV/w8CiTTWxrGsHfNSH3VmpFjZpcHCfE+J671AUU+GVc4r13MmPPrCoDLEGDi+J6AncNE6b4oSnVvYRtn+pkftQGYshuoe3KAWDmmjDoPzQvsOgPTnMvYEeRB3TxcPtUn0DDFrtkUwDYkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706984; c=relaxed/simple;
	bh=ZY/VVe5tKEqPuyoZjljqipOIHZ/qLbp9ckeFk8B8bsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4pNqs+QBOgsLaMCRhcLd4fr9y0fm4zXLroI+hW7l7+5V6dZw6WTA/QV9BVlpFltFLTz2xUTcuKOgpWRy0BiMb1kn3YSyF0V/0Mu9WtScJIyAmexQamnfZZPepk3fAv2vdCs9WHWc14rF118Y+8Q64cBsuDFE2APu/iy92/9OUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAyi/b+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANUun0mO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760706980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIxHhgOY6yAtsbZxBM1Fa5RyGGV/UJx/WNKi8grOSjk=;
	b=OAyi/b+VoSNORJjYjDO0kSYZdV/El7n5crLGQYgqlbUt97jYL7zvruHPYEdefba7D1ZkIn
	jdEStlcDU/ZMCAy0xzxfXlgJQzqwSpQv2/0xufqKgoflcwEpZ/DqCXa6BcC8CVbemsZZ8x
	cYpvNCYvIXn3HZAPDn/q7cO9ElsWQb608TD45CzxbtH5iVLVdhERI58ecDVkGTYbwqmu90
	qfmmmC3DFIUOcUnfaKQndU1woaq3MZ5GabvxTzM7FrPk7HlRrzhRSJzMJO+R2jDY/HNos/
	CVAT6SmvIoPDk9afhOvgA6X/mTVAK75pjxJ/iElkQRAm0Z3aEZim5xQCP6Spqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760706980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIxHhgOY6yAtsbZxBM1Fa5RyGGV/UJx/WNKi8grOSjk=;
	b=ANUun0mO/B+a3PJZRzJB2OgANQqlE+LhxchrZRyEDLbP1Csfa/TfEajUGKrXOE7d89A+sM
	lE1jHGLlQZINteDQ==
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] irqchip/qcom-irq-combiner: Rename driver structure
In-Reply-To: <20251017055226.7525-1-johan@kernel.org>
References: <20251017055226.7525-1-johan@kernel.org>
Date: Fri, 17 Oct 2025 15:16:19 +0200
Message-ID: <87sefhzn18.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 07:52, Johan Hovold wrote:
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about section mismatches so replace it to catch any future
> issues like the recently fixed probe function being incorrectly marked
> as __init.

I take this grudgingly, but not without pointing out again that this is
just a horrible hack. Why can't this stuff be properly annotated and
recorded in a throwaway section so that modpost can act on reliable data
instead of using string matching on arbitrary function names?

Thanks,

        tglx

