Return-Path: <linux-kernel+bounces-896116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EDCC4FAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AD5189F4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC42BF017;
	Tue, 11 Nov 2025 20:17:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC63A9C00
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892237; cv=none; b=cnjK2b2a5evpIzmSqQtdWUx2W6gjCn65oPK4KzM969PSOfko7c/Y0vtp76ALFFT/JydhzrXjZ7H9i83RUyzbxxCMgfR4CU4Kx74usC3C1sHAAWl/i4Lf+O/0g+ifSuFOzdHsji7TWtOxulddbyyzD2vG/NbQPQD+GZB2bXHA420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892237; c=relaxed/simple;
	bh=eG+GsqPAj+QRHmnl1ybuCeDEe3LqiKklG5OjM8CICFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLxt089v55IB8JaFrpwYBPDUSgTb5ql67QHf1TJ93W/ZOPyea5DcuAwXr3nQtaxZdhsn2q/16fcYC1HRZeHl1k4PU4+VRa5lOZwTHsY0QlA4GQw3cwyd/0Kvc4LUWI7kSrawqYV1d9ZEqP4cywP4kj9L0AaLx7ZB+83gK3RUF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F2C113D0;
	Tue, 11 Nov 2025 20:17:15 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Ensure PGD_SIZE is aligned to 64 bytes when PA_BITS = 52
Date: Tue, 11 Nov 2025 20:17:08 +0000
Message-ID: <176289222848.1642362.6364140142931460168.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031071255.3335501-1-anshuman.khandual@arm.com>
References: <20251031071255.3335501-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Oct 2025 07:12:55 +0000, Anshuman Khandual wrote:
> Although the comment clearly states about PGD table's alignment requirement
> (when PA_BITS = 52) but the subsequent BUILD_BUG_ON() tests size comparison
> to 64 bytes instead. So change it as an actual alignment test.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Ensure PGD_SIZE is aligned to 64 bytes when PA_BITS = 52
      https://git.kernel.org/arm64/c/e2e21a9757b9

-- 
Catalin


