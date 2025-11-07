Return-Path: <linux-kernel+bounces-891024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F3C41A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7FD14E71F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8263E30EF7D;
	Fri,  7 Nov 2025 20:52:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E818C2C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548778; cv=none; b=kz/cYzbHm2otBOlCcDhxQyQ2AzZbxz6Wlo+Z1awvIsrDNTefexOh14teTcc3KEEtS+rLt+OXUpEeokwUlMfxfjSbvxrprQZE/1hGBF++5XeUdAFpEHNBlwP63HLCteVFOL8hi01eh/aC4001uDIbRRveHkuK0hzQMwbYhRQRNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548778; c=relaxed/simple;
	bh=7HxdhqQB/AdBcVQcf/YBfi3ienYG4oe21eicROOFkNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQwVTE34m+bmUfh91/M8kBgUf8cPMLxRhZ4z7NqJBR2lEM1Lxs/D/441HRlEyjGtQ4/Sa0TMblvx79RJJr6kdr2icR4PYC6P4kVyqNMHKky4WffqHbmh7T+pxIEQCvqN0CBf6OBJg8Y2vOpEYO/tASzbr0pIiAFC+Qljm/QPh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B109C4CEF7;
	Fri,  7 Nov 2025 20:52:56 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop cpu_set_[default|idmap]_tcr_t0sz()
Date: Fri,  7 Nov 2025 20:52:47 +0000
Message-ID: <176254876744.3846522.3909820639580560567.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015021024.366722-1-anshuman.khandual@arm.com>
References: <20251015021024.366722-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 03:10:24 +0100, Anshuman Khandual wrote:
> These TCR_El1 helpers don't have any other callers. Drop these redundant
> indirections completely thus making this code more compact and readable.
> No functional change.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop cpu_set_[default|idmap]_tcr_t0sz()
      https://git.kernel.org/arm64/c/fc1abd409318

-- 
Catalin


