Return-Path: <linux-kernel+bounces-897753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D5C537AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D1F2351A94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6F33DEE8;
	Wed, 12 Nov 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtp6zaFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E4328636;
	Wed, 12 Nov 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965242; cv=none; b=rQ6Z2tsYg5ib8jLqMkEaoHV7hNcOVOPdaDyAR0NMaYEtee53rW7X2X9AtdiHJKfY05IMwZupcbONw0LCcIVuJ/+As/cZ5bq5XGqSQtFs9kN8lycDr8lhHJZPTPakfH614s4zwIKjbx8EoW43cVg6XtASafoUBwjAGu36d+Qn1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965242; c=relaxed/simple;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gVrOVW3OQ5tNF/4ouPXo2sqwOnlFuECRWvrn6M9K21R/BRzbCDhR6xGSK5CKDpGrXezPQfVJZu4X/tZx0DDT+gd3g7ljRIg2T2ZBp1YLjVY+Ho3D/akBSCOxmoE/ftdBuD0d/URFsfv2EhpGV3Doycc0U2K3O4UMdQtEqkNbHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtp6zaFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A83EC4CEF5;
	Wed, 12 Nov 2025 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762965242;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vtp6zaFfCG/8wB2rosTWXKsC2EFAYkz4cAPI2WIDgpyZoBNUXagfqCV2d/sOnAxw2
	 NBmeijGWaRZxgMBNLUfSRXWx6Z3Z39NSnlnLorcSH3hsOyRKTPOBDwSMtMddTWrd4I
	 6vo24/SSCJVs51afVeDEe8BdK9BNPEOir/204uyYDKhP2KkxYe7zwkng+euxFj18w7
	 D6QXJDelULvzK+eLkYAkEvwbm2bYjP2TwJLdP1ergtQSwdoitaBHCIE7Lu+FGauGg4
	 TW1uRfWP8h8oCB8Rrr2JXonc1g/a8WuCDtDMQvplQ8YPDDIknMvI4YcbNUVa+kRm/w
	 GUaRXn/iGGPkA==
Date: Wed, 12 Nov 2025 06:34:01 -1000
Message-ID: <74da46d928cb25b9e0a892f20e0323c3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix unsafe locking in the scx_dump_state()
In-Reply-To: <20251112073328.14303-1-qiang.zhang@linux.dev>
References: <20251112073328.14303-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-6.18-fixes.

Thanks.
--
tejun

