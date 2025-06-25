Return-Path: <linux-kernel+bounces-702742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD7AE86A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC148188DE01
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7A268C63;
	Wed, 25 Jun 2025 14:36:48 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838A267F4C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862208; cv=none; b=AUZ9KaxvTkMmmuUwGWHxqPcryOmOCu1vK6oUDdxhVf/rk9ufQoWEK0gEFpoEOq45nzHQs4Hp1EtrIcfL458fdesTSyFLgZ/LbTDDQalo+XWbpTG9tyrrxnMr3uWFXSoTIvucVz25oDMK30/YM6obYcoSfivGjPYJNNxDe5dcj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862208; c=relaxed/simple;
	bh=NXzXaf7EW6iEYKg0rmfnP1h7InpF/i0PwOvPVjkKJu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBBfPg/Pfnois7IF+OsDL0Mq0sgnhufI7XM2sBsgBbC6tEMpZFxhgY18DPX8dp0MYcNa550ltwv2C7iO5byjWdDYY5Il0W9y2jjEgF4ZHBuMHrofyRx06QTS9aMhA7Yi8/FWHS95xD457fZRZyrZG+kaWE36wQCSAq/NrfezYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55PEZxBr000389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:36:00 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 660662E00D5; Wed, 25 Jun 2025 10:35:59 -0400 (EDT)
Date: Wed, 25 Jun 2025 10:35:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "willy@infradead.org" <willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 4/5] ext4: handle IOCB_DONTCACHE in buffered write path
Message-ID: <20250625143559.GE28249@mit.edu>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-5-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624121149.2927-5-chentaotao@didiglobal.com>

On Tue, Jun 24, 2025 at 12:12:09PM +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> Add support for the IOCB_DONTCACHE flag in ext4_write_begin() and
> ext4_da_write_begin(). When set in the kiocb, the FGP_DONTCACHE bit
> is passed to the page cache lookup, preventing written pages from
> being retained in the cache.
> 
> Only the handling logic is implemented here; the behavior remains
> inactive until ext4 advertises support via FOP_DONTCACHE.
> 
> This change relies on prior patches that refactor the write_begin
> interface to use struct kiocb and introduce DONTCACHE handling in ext4.
> 
> Part of a series refactoring address_space_operations write_begin and
> write_end callbacks to use struct kiocb for passing write context and
> flags.
> 
> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

