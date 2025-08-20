Return-Path: <linux-kernel+bounces-777806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A060B2DE14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1723ABE90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29718322548;
	Wed, 20 Aug 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLr4oPvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3332253C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696885; cv=none; b=GmlnxMV+3WHE48lq+If4nVvLsy1fnY9/aotTZmat6WweemgIEFJyxqNpT61RvQhtXdq0w9coctg7TCAW+d6xpKtWrIOBfBE/gz7S2gEQCZOzifSvKrFtJiaVWIlESPxd84ehckf2jWutYhecVr/JYFs9t0ze0mtJAzGVZah2zwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696885; c=relaxed/simple;
	bh=fJG50JT0OUNU51LWIaGFHJLmpQ0f1RLLrMGdC8SZ9GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boiC+srPjgkqwc5TWh0HWkzWYPT8dP96wEaQS8h94pEh4ug8h/oeYsEjNEJekvSAcF/kztwkNTmNX50Y819gbDmomZPSdjZQRINMdlD9DUdaMfRJwPkHPyiqGhRLK1e/xu9CSNIFPq9WD8qPRwNwdbQXDL001viNblPfrnXZI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLr4oPvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543CDC4CEEB;
	Wed, 20 Aug 2025 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755696884;
	bh=fJG50JT0OUNU51LWIaGFHJLmpQ0f1RLLrMGdC8SZ9GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLr4oPvVb4qUicIKYCUNynW3uqKX1oWEGwoqtxQoEeUQpzfEf3A22qzmH1HkLQH9Z
	 3g3bycoIfeINnnilpl0gqYbgKGgXBqns8yLwNnHhQ9U4QUVnrVOoRjAt5wTTvjvuLq
	 QdbIzc31UmU7eols2VPyhEgVqcwGPWmbq7ODLLasi82lTOoeqhtkT1wasHyYNv4PdQ
	 YD7Oshwf9WBr9mDCyPb7FwtZ3nJa/aO02YRfHzp+2Wir87z7Rb9IkYcZQEcI/+asXF
	 7hYlPIJlz+6ZIbOBrmkI+WwTDck8+QAwjnCYZfdwA1aiBZLCJDGeY3BqPBZreysmDG
	 z+ETbpso4yauQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	pratyush.brahma@oss.qualcomm.com
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/numa: Use SZ_1M macro to denote bytes to MB conversion
Date: Wed, 20 Aug 2025 16:34:38 +0300
Message-ID: <175569679035.1410601.2889611634297884263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820-numa-memblks-refac-v2-1-43bf1af02acd@oss.qualcomm.com>
References: <20250820-numa-memblks-refac-v2-1-43bf1af02acd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 20 Aug 2025 06:29:34 +0530, pratyush.brahma@oss.qualcomm.com wrote:
> Replace the manual bitwise conversion of bytes to MB with
> SZ_1M macro, a standard macro used within the mm subsystem,
> to improve readability.
> 
> 

Applied to fixes branch of memblock.git tree, thanks!

I've updated the commit subject:
[1/1] mm: numa,memblock: Use SZ_1M macro to denote bytes to MB conversion
      commit: 4647c4deadcc17f40858be06bcf416369a8f1d57

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.


