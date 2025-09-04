Return-Path: <linux-kernel+bounces-800106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CAEB43377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47E71BC6D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9228A704;
	Thu,  4 Sep 2025 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVBDlxQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233D289340;
	Thu,  4 Sep 2025 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969861; cv=none; b=Sm/xCTXDcASG45Q8CRN7XccWzW/456J873nU0QqZx6K/b4EDBwLjmCrjBxHXcVKbnvlVm0DgEDqEnwIgBCjqlyF8UbJuXLUEICTdhjZaxJuY8OEHey9A1R5f7oJr2ROdExQw7Sa4Kd8YcTP8mC8VjDVv9gP818l0VZAgtCRka3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969861; c=relaxed/simple;
	bh=nZy0IyQHaJIUczXcoPF0OoMhKrOWk7gH/dgXGaa5YFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3xcaCoK91dMbnX17VT1UrLOxQQPvSyq95l7Dtdch9yMO+x0mgZs0CnXbBZgPlfFdwXYNGlUIY4RA6cYl80qpFNFrFg4N5hWhpU7DFZ8cn8wEbbs3R5kwp9AK82GmaTGtTq0XzjpnLOJ5GiguY6qkZVfc/rLXx+ZUdLMJ9CpKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVBDlxQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3BCC4CEF0;
	Thu,  4 Sep 2025 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756969861;
	bh=nZy0IyQHaJIUczXcoPF0OoMhKrOWk7gH/dgXGaa5YFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rVBDlxQ9oVZuZrwaWw2ap2AhQP6vpjLGobeO/Y83EidCJIzar6pI6hPd39Xi0PAOt
	 DxhgbuigPi+aL3qPvA+b8YNqKqBDQRY3F2KwETFEGOuDo39LHhZviAw8MaBkIhXhhW
	 13T2B/U2hKvLz1bW3xMY85Uk6prBK3q9teOW7CVdqWUkKOLgl6gqXmddh8hSAFtn6g
	 JEq2JIXfO54ZzoWSuZZdvMNIxA00vFIyigwJdi7WaJaRKA8ZvQF9OIAoUcDDwpJTub
	 OpJJY89wV182Losbe3u5D6sSvQ44hrFyGL8S1xaDa1OUdp1huexvXwkbh7HXU00b3Q
	 PNj0eOP2Qq2Fw==
From: Srinivas Kandagatla <srini@kernel.org>
To: sdharia@codeaurora.org, liuqiangneo@163.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiang Liu <liuqiang@kylinos.cn>
In-Reply-To: <20250903075155.135539-1-liuqiangneo@163.com>
References: <20250903075155.135539-1-liuqiangneo@163.com>
Subject: Re: [PATCH] slimbus: messaging: Remove redundant code
Message-Id: <175696985957.289807.9989826262411299021.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 08:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 03 Sep 2025 15:51:55 +0800, liuqiangneo@163.com wrote:
> Assigning txn->comp to itself has no effect.
> 
> 

Applied, thanks!

[1/1] slimbus: messaging: Remove redundant code
      commit: 9ad5660840925cd6067b22f8e0bd1db87275cf58

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


