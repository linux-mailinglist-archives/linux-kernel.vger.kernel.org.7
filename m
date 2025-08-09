Return-Path: <linux-kernel+bounces-761204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DCB1F5C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23B517C6F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375F2BEC37;
	Sat,  9 Aug 2025 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAufsOUh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A025743D;
	Sat,  9 Aug 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754762699; cv=none; b=WkDE22kmkRoXa21kBOYEkX153yJt3TNewsiM/jYjs/97LjJTNbWCgy28UPfeZQXlVVOz5RBZL51pi+2AWjrs8WbOkSCTVXXdv3bq2lDdgE5Xg3SFXNYoXwKTzQiT0BzAvP2r3irlXZS5T6hvcP8XP5aXiQyIekqHh8OTO8fM8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754762699; c=relaxed/simple;
	bh=ye0BVOe3WtLfMAqPZQ5/XtZYfSi2vkU8EVz2kZdrg/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEUFnRuoLRXrPWf1n4LcPziXQQkQTnvyPqBqTbmB8Fmmh1x2K8FbgFr6GT4daom12eoS0uz2aRDsdG7Io3SN9ff6dWXBMuQu8qiKPsmkKVFIn7jq0QFQBnSt13SE2WfGFRBGYdNX2xeQoBPDJbDFSdqVn4apEhEl/xB1HDm6DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAufsOUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B9C4CEE7;
	Sat,  9 Aug 2025 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754762699;
	bh=ye0BVOe3WtLfMAqPZQ5/XtZYfSi2vkU8EVz2kZdrg/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAufsOUhF7XitVnlSNLGNNcSNeSHfzW6dYseBdGTsGOKa0vH++22W+/33RSUHbnQ8
	 t5ZXf5V+YgRthS5dZ4/4myTLKLDpJ3gcz+V6kzAqrT53pzosVzMyHTlQYgaCGp5/bO
	 cTmAziplICQnPz4sJNbn0XH1EKe6Z8vYPqKznReqvbrg1CVXEAdtgF8HaNILRIBeYR
	 aCAO+zeCPSnfBTWKuUhxWMcvZ5m81Uap6iEZpqRYllaLS8h01bv8ndyD1ECyxWBzVY
	 pEb47GletYXb+9ncsh0MIqV1iaMg1n0F2OLZYG29O1/5IOUWywYAd0k6Q2qvL+0gkT
	 tuqnSucrrZ/eQ==
Date: Sat, 9 Aug 2025 08:04:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: remove redundant __GFP_NOWARN
Message-ID: <aJeNyU-ivn8aEy8k@slm.duckdns.org>
References: <20250809141358.168781-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809141358.168781-1-rongqianfeng@vivo.com>

On Sat, Aug 09, 2025 at 10:13:58PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

