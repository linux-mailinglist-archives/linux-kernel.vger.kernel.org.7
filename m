Return-Path: <linux-kernel+bounces-900094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34EC5996D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B881134BE37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14830AD06;
	Thu, 13 Nov 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOgYb1tH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19F3161A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060341; cv=none; b=fuMxXFxJKYNjhZOMlmajohRhPcSlB7mIQPTyCKYEj9GNKDxWjZ/P9P+nE2tNNhCE2MnvMvTaCNHVDzJZmGO9jJ+VK5kZ5D8vIs7ekDodH8FPw6UHhCwETzj6F35YK1+xToKf6lzbvDOCeWNcSMg1+1dhVUnrbGdyANuPK2zNZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060341; c=relaxed/simple;
	bh=Y9smVE2v6A+tgVYcflKTZ+tDgKK7i+qAb7N4nXKZcuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOpORU0NXYTBetSTP3mIU/sIRSQfJv4czEXxwy+ftBR/PNmqVlkJw9dCGsHmodRWBRuflLZvnBXGBCfgZqNUkA3yz8wE4ocSVOkD+Rm5i+qc5vwX6Su9TQDRjEMpUSIJE7VkXlYXMmDiYjb7EZNEvzSEYaHT4Ut1kqVaRD+pedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOgYb1tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC502C4CEF8;
	Thu, 13 Nov 2025 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763060340;
	bh=Y9smVE2v6A+tgVYcflKTZ+tDgKK7i+qAb7N4nXKZcuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOgYb1tHK0YsCQNQ27eKv2OIqxJxST9HuH2GBNrGY5xZ4ABcNit5J6rXnODTc49zh
	 jQIfTS6P9ODopRXGU0r/mTTeG1h3WOrMR44JHxx62fi6p5Vwd42ZB+kPZSsr1fTi7v
	 tAuWBk8VECh0RR+oW+C9XILVw3E+hvq+j6KutRCdoBamdRFYKoSQug1JGOIywa+5wQ
	 3k7s3rzgNuiHKxaYQhcBhQEypTvcdihJCzDhdoImbNVOfAbTPfySTahNzQyacSSjhf
	 I0t04f4bDLmUagHm1XoQVUds5LGkg8yC/TE12eKXNzlb1QdIz9zsV0KrzbvAxiGsZO
	 q0k8slu+uMf5Q==
From: Catalin Marinas <cmarinas@kernel.org>
To: will@kernel.org,
	Dev Jain <dev.jain@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	anshuman.khandual@arm.com,
	wangkefeng.wang@huawei.com,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	pjaroszynski@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH v2] arm64/mm: Elide TLB flush in certain pte protection transitions
Date: Thu, 13 Nov 2025 18:58:42 +0000
Message-ID: <176306032240.2459767.9191020544205608195.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017160251.96717-1-dev.jain@arm.com>
References: <20251017160251.96717-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Fri, 17 Oct 2025 21:32:51 +0530, Dev Jain wrote:
> Currently arm64 does an unconditional TLB flush in mprotect(). This is not
> required for some cases, for example, when changing from PROT_NONE to
> PROT_READ | PROT_WRITE (a real usecase - glibc malloc does this to emulate
> growing into the non-main heaps), and unsetting uffd-wp in a range.
> 
> Therefore, implement pte_needs_flush() for arm64, which is already
> implemented by some other arches as well.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Elide TLB flush in certain pte protection transitions
      https://git.kernel.org/arm64/c/c320dbb7c80d

-- 
Catalin


