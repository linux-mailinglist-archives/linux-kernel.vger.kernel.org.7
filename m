Return-Path: <linux-kernel+bounces-796177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B5B3FCDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADF43A1FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C22F362A;
	Tue,  2 Sep 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ9HpYIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9B2F068A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809579; cv=none; b=lCmdfvfF+qqOCparS53yngMWo47qkIIXgI/rsbSh595B7ySdwcmHzhXViVTyYaqFdyaJ4awmocd5lPv42r4RfiXWZieq437J7MSnf0UAHhpnoD7jseT86mJEIr5SlEK0Hq4e/h7fVKsog0xsowhNk+TkX30fUNn6C5lcBOQ9Esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809579; c=relaxed/simple;
	bh=qdOv0TZDnk3Fxtwy2oj8Po6KhwUJyHJXYLEe3RKwNJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oov+WC1dzgsyFauKj7eHf5WymcufRoY9ncsZDcdErM+1JsjAwrUm6XDZPba8w0eh2bQ9EK0hErlBGtuhU71yk26X83ManbMrzfKvpysy5OBIZLA/J6DbUCCEN+UXHm2pdRsYbAIEqDwaujG7+HgzlbquKf3nj6/IM0p4xrxLfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ9HpYIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED14C4CEED;
	Tue,  2 Sep 2025 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756809578;
	bh=qdOv0TZDnk3Fxtwy2oj8Po6KhwUJyHJXYLEe3RKwNJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RQ9HpYIl1T1Y0Z2LSHjoV2VjUuoeuq0i6sdLxzkUNqWHvyJ0FWm5PFF5nMhG7H0DN
	 x2b3Am0zSMrSifeNAzorRrWYDga7OuOaUWxIjb+ySQCrXZhzO5n5Nza72ZMdVsiG5e
	 Dd4y2DFtEsBlDygKDNVnA1b/hz6OHmvXjyLhrewJ7GuUJ375zz6emDf75/TkjwGB+0
	 BCXmqXLJP0oVi8k1bgEWQC3vrwWU6b5R/2lQGk4gq1XYCqUJ7RVaGOV7/ckZwo7vIw
	 HypwBR5uPpq9VWJH2A9oMjI94S+tv/Dd4PnWDyNzctXOEwjfii/u77v7/XhxgBdXAk
	 2pArlNm+UyhbA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250819070458.1027883-1-alexander.stein@ew.tq-group.com>
References: <20250819070458.1027883-1-alexander.stein@ew.tq-group.com>
Subject: Re: (subset) [PATCH v2 1/1] mfd: stmpe: Allow building as module
Message-Id: <175680957679.2263845.4991001517123713397.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:39:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 19 Aug 2025 09:04:57 +0200, Alexander Stein wrote:
> Export the core probe and remove function to be used by i2c and spi
> drivers. Also add necessary module information so the drivers can be built
> as modules. This reduces footprint of the driver is enabled but unused.
> 
> 

Applied, thanks!

[1/1] mfd: stmpe: Allow building as module
      commit: aa8d4c73e99e8a4612eb4a598f2b29b141a9703c

--
Lee Jones [李琼斯]


