Return-Path: <linux-kernel+bounces-885851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01FC340BB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06558465029
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C802C08AB;
	Wed,  5 Nov 2025 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpDOHFR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9725FA13;
	Wed,  5 Nov 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324047; cv=none; b=nNjnyF1nQ5S4T8Ou/lRx4mpciZzl8C+VdanzCO7NX1VYXDGrgCM1Fm/Zm+krb76tZo9G6sX6jXXJ9OnvdaAHtsABozXt0lQfN71OLW01EQE7iCnla8EYVgYyJFrXJ8dLtRFt+kU3/EZIe6jbQ34yEho3pKar2cjtOs8At/YA0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324047; c=relaxed/simple;
	bh=WEXynaLhwvqt5Nr419lgw8is6oFNwfs5frIPl9XDi4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=InoC7hpiGUojT+dN0qMQg6Up0ZNrSznXYjXyqG3iTFHENvC3yRzY/R2J3qi7sEUALdEa/WAJNQICP3I6cc9N4F7NaI/vM81Bby7nNrYx6RXrV42qTToiCDr/QQuk+nSWbEfTw5TB534GrVzGNnMC/ugNYtvNnFKz51dcDe+/xHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpDOHFR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E20C4CEF8;
	Wed,  5 Nov 2025 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762324047;
	bh=WEXynaLhwvqt5Nr419lgw8is6oFNwfs5frIPl9XDi4U=;
	h=Date:From:To:Cc:Subject:From;
	b=RpDOHFR/fUhVCjmPlPGbQurnSVhiwG+yO8O5RGMpr+RSHhZVaRUs+P20leQfToxCN
	 uJ+6uQlAZdyS6lCun2slxKD420B3Xi3bOJPH07IxAh8pMzKJ5d+ksO4uGsc+KEkHPT
	 OU2lrr8RTVNc2x7JBTc2hDi+lkWlyMg9ACixDGm0DBmQcEtJQ8WPXlcNrYIvAjTlUa
	 2Y0rSIG0aapDfuf5GCJlcHmoD9VOfYv8YT+Z+G1mu9hK7nvmIyo07bQElaQlR4aeI8
	 26UEiRWsUY4022Wry8gy8661l19qXmZhQEmfEbwIv/jIhkZmPq+ziGRkxI/RDgN5if
	 gRculuSRQsM6g==
Date: Tue, 4 Nov 2025 23:27:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.5 uploaded
Message-ID: <20251105062723.GA2341496@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.5 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 21.x
series is no longer supported.

Cheers,
Nathan

