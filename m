Return-Path: <linux-kernel+bounces-867399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C95C027E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB05018AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92AD33F8C8;
	Thu, 23 Oct 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxT2n21u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EF30CD85;
	Thu, 23 Oct 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238106; cv=none; b=SdzboDsv96ZeoqUIAEP9OCaM6B5Wq56OBZBm+vqcqciQE+Yq5h5vBEeVlwOhL3doyla5qawOA7SuCuVmdnX0+PPutoiwkWXxcn66lLcWbDa7tLjj0RU6wUa9PcW4bc3nKAcpSzGJHjNVh4lJV+dJAXhcelRRU6i8J3+CPGuYCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238106; c=relaxed/simple;
	bh=HFbHH8CV1hWkCQZ8V2BcUz8qzfhboPkZ3UfAxQ+TdBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KL7NJljWJjb2dITbo3lk5YPN9k29sm4DxUrpBA1LdG+KPTYH3sLUV9XXRgbj5/w/stX83R82joFgjdgR1uPzQTpqMjCGw6o3phGPMdeZyDICa6j489dK+EUmKL3JE2nhy71GozJGuBoY8fqjsUzYYzj6Z3Y9DazJ6iHmG3CP1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxT2n21u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298A4C4CEFD;
	Thu, 23 Oct 2025 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238105;
	bh=HFbHH8CV1hWkCQZ8V2BcUz8qzfhboPkZ3UfAxQ+TdBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qxT2n21uWhB6zc9W0TrTRu4xWn6UEN/EJ2Fv/TaCCl1iPubRAi/luzyHF3RInEnPG
	 6CcsRFaQCVlkuRowmJnxZ5Lmc10uLvoV90lhwPfzHv02svbXksuGCSWetzKsUI4M9A
	 nss0EF1Bt50Hmr3/gw/OPUIgymUDbGotRH7ehI865/GtCFmQkhaJfEtaUQ3ymaaFZ6
	 WJHeUG8aALbGMLpPuh7epL6n6QepG5FI6DPmh0PuqIbwXo9OcLEZQoUF+wfTCsbUB/
	 F36MxIdt185pW3t8NKD2gdtrIRaeI16DGULg9PhGhmcBDxDvUWFrBCfPYsWG3QDuuR
	 5sUf0NelvZ6ng==
Date: Thu, 23 Oct 2025 10:48:19 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, 
    Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't
 populate root node
In-Reply-To: <20251023160415.705294-1-linux@roeck-us.net>
Message-ID: <2bef32d0-2c35-c93d-08a8-71966c1212f2@kernel.org>
References: <20251023160415.705294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Guenter Roeck wrote:

> Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by
> probing DT devices when ACPI is used"), riscv images no longer populate
> devicetree if ACPI is enabled. This causes unit tests to fail which require
> the root node to be set.
> 
>   # Subtest: of_dtb
>   # module: of_test
>   1..2
>   # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:21
>   Expected np is not null, but is
>   # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
>   not ok 1 of_dtb_root_node_found_by_path
>   # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:31
>   Expected of_root is not null, but is
>   # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
>   not ok 2 of_dtb_root_node_populates_of_root
> 
> Skip those tests for RISCV if the root node is not populated.
> 
> Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing DT devices when ACPI is used")
> Cc: Han Gao <rabenda.cn@gmail.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Paul Walmsley <pjw@kernel.org>  # arch/riscv

thanks Guenter,

- Paul

