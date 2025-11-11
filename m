Return-Path: <linux-kernel+bounces-896118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D076CC4FAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321154F4E02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669ED33D6CC;
	Tue, 11 Nov 2025 20:17:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56933D6C1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892267; cv=none; b=K2EwQcISki5BhtUBll7VEvkcbxUVDgeFQXOs9OC4VcoDnjDMQoOXakYrT9kOpUBv5gu48UI5zcKGTaKW7zwg7mBOVvdfuadKK9XlDBR8GNtcMBORVjTwt4m8zlJBjZfwOfoYZGVawmYNMBn76uDAwXgkq0kpPtwv6BKrFHU2l1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892267; c=relaxed/simple;
	bh=rjjWbC+6nZ0K/d2fxYrlY/9+5/uS8gXkCYH7PL9k9W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU8yD1DWEpjE1aaS4XZbhP+gCYg96EYlE48DvPcPtKP5ETmSsOUaIHVcEy875CmnXbI/1R19mZq/uW44ZXJbQjxNXEByYLaMa2X9dzb5INdeCRuhdPUl5AgOaWu8+YDV9iA8gGmHRXaJHXeNdD6RBapL3Kcnkdtj2H/mYUO/kvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E428DC116B1;
	Tue, 11 Nov 2025 20:17:44 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	ruanjinjie@huawei.com,
	suzuki.poulose@arm.com,
	ryan.roberts@arm.com,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: acpi: add newline to deferred APEI warning
Date: Tue, 11 Nov 2025 20:17:38 +0000
Message-ID: <176289222849.1642362.17029538474789995390.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110212102.816724-1-osama.abdelkader@gmail.com>
References: <20251110212102.816724-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 23:21:01 +0200, Osama Abdelkader wrote:
> missing newline in pr_warn_ratelimited in apei_claim_sea
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: acpi: add newline to deferred APEI warning
      https://git.kernel.org/arm64/c/420cab015503

-- 
Catalin


