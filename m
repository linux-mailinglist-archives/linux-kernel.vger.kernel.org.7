Return-Path: <linux-kernel+bounces-897950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA815C53F83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B856347BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504C34AAE0;
	Wed, 12 Nov 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjFgimRW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620943538A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972415; cv=none; b=PU+5Jmw8mddLfjTzeQ9eu70LaTUjGISOuijMUzWxKjeSuJdFWp8tKiBZ8jM27/eByMzdqmbWr2ZxB+je+9XNJWBPT1UP7NENO2C+T1Ct3gRzgIuY8S4VwSrH1prgStG/XsKRQHmJC+nfevdwFmCGVXWd95CMTIonltXGGiUqKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972415; c=relaxed/simple;
	bh=svyquVfOlmQCnTwOTU1HeKk9AcKWK15SpFPxSVLYHSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WymloWkudJm0lqmCzZtTgE3kDdrXfd/DFNcYgJZ+QVWTEDhakcDyBMyKxk4BknPpTZMhNRAtKY2eBh3M/0olRnboTt+NmZ99GLHvv3alP1Kl/Q4DTxgz+R1qjp61IOCPg5VeeYmzFVSMXsSkG18r9yNAwvdnWI4CPCA4LjOjTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjFgimRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E622C4CEF8;
	Wed, 12 Nov 2025 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972414;
	bh=svyquVfOlmQCnTwOTU1HeKk9AcKWK15SpFPxSVLYHSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjFgimRWTU36hJVBFroyCYIqSjvCu6FSRPmiSQ8EO2W/1YQmYrCkSKZqMvFkd0mQC
	 R7Fha6K277a2BFlpbm4aryDiiiHDxd6bVRPlcJ/1+IjMpO1Yh5eFcr8uBHdlIRoGrC
	 DBJ8kG3cQH9m2Jt0J1PgD/x2nJN4lqb92PEp3Zk5TuUPfLCU/oVqF10P0t5G8RxK7p
	 M53rX0hR3abi0SzDpMLn3OMMctBYlq3PU5RPoNq5rKpP2f1C9BW1n56KAh098L8n4H
	 K9KmPjdQx7DO0bHSsazzyV62JMuJrCzLnoRNt0nIX+C7KJ49mOQQJ+lXlpEGfF627l
	 YSaILRSb5DrlQ==
From: Catalin Marinas <cmarinas@kernel.org>
To: will@kernel.org,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Fix typos and spelling errors in comments
Date: Wed, 12 Nov 2025 18:33:19 +0000
Message-ID: <176297238094.2053466.16803014781753422009.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106135655.8441-1-mrigendra.chaubey@gmail.com>
References: <aQoF3pu8CjO3tAl6@willie-the-truck> <20251106135655.8441-1-mrigendra.chaubey@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Thu, 06 Nov 2025 19:26:55 +0530, mrigendrachaubey wrote:
> This patch corrects several minor typographical and spelling errors
> in comments across multiple arm64 source files.
> 
> No functional changes.

Applied to arm64 (for-next/typos), thanks!

[1/1] arm64: Fix typos and spelling errors in comments
      https://git.kernel.org/arm64/c/96ac403ea2b4

-- 
Catalin


