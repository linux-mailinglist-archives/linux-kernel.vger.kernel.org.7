Return-Path: <linux-kernel+bounces-738710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD043B0BC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270003B5EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA43219A6B;
	Mon, 21 Jul 2025 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD0nji9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866F15E5D4;
	Mon, 21 Jul 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077577; cv=none; b=SZ08zsVfdFMVyn1wRZkTUL7SVD91YUpnfheOV5Lza3aGSaz3BMZcNpCR/yHFdP5dFd4mCyC/YZYLi+VtNkFmWUO1ny5pargWtDpkl67l6EzQ4nZCHQGyNqGfgp+35aw5xVrsPqiz7uJeGhYRpOeUoR5Bnq+/4jjBiTE6whUGjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077577; c=relaxed/simple;
	bh=zjQ/ZII2jFeRZRBqkncnTPUBSw5cJUTUCUt28phW4L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XspWzdPoFXYAAP+xCyNNlmSBrvpaWgFfAi2jvXebuwXQWi+30/RkcftJituJCuhyqgtezm/rScpbHnCrUQyvodUebuHkAVdoaU+/0ytV+I0GuewKZ0OU86+9cogqr47UEf3/koW6yo928Z76WgAvypUIBip5JlicwUCfb6+oxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD0nji9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86675C4CEF4;
	Mon, 21 Jul 2025 05:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753077577;
	bh=zjQ/ZII2jFeRZRBqkncnTPUBSw5cJUTUCUt28phW4L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AD0nji9LCOZCAehbmeHIzdSB1qc54+lE9yZNHjUuaosBqvKBqm2Ey9G7l6DmWRSvH
	 6aXUh6dbMaJqBsBESLrWkgn1XWP0WFHZfpsMUskFta+ZnwMn1bp2bMxIa3l6KWbg08
	 Osquc0kMjChGtKac2z8S/PJtwefca5jlxgmdgoyGExB5FrGJRRoQNNV6gRow3KrkeD
	 SH0uvNJfzvHIu+50QSE4DgK7pJi0/fMNU7qWTspwhFDqURLBsrJ0/+jMkxj02a/FL+
	 V9CiZeXrRfFESP0Tk0bGqxEWfh6jBsHJ1vaQGkXA17iZM3IS1Yvx/DKS4669FEcLZ0
	 L++0rOZXZ1/jA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20250626060952.405996-1-yung-chuan.liao@linux.intel.com>
References: <20250626060952.405996-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: stream: restore params when prepare ports
 fail
Message-Id: <175307757518.149817.4212801987384609949.b4-ty@kernel.org>
Date: Mon, 21 Jul 2025 11:29:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 26 Jun 2025 14:09:52 +0800, Bard Liao wrote:
> The bus->params should be restored if the stream is failed to prepare.
> The issue exists since beginning. The Fixes tag just indicates the
> first commit that the commit can be applied to.
> 
> 

Applied, thanks!

[1/1] soundwire: stream: restore params when prepare ports fail
      commit: dba7d9dbfdc4389361ff3a910e767d3cfca22587

Best regards,
-- 
~Vinod



