Return-Path: <linux-kernel+bounces-838033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA2BAE468
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3861E1648EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5926C3BE;
	Tue, 30 Sep 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czmSVlnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491E1F5847
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255624; cv=none; b=iY7krCcoLM3EzsXDs+EL9UgXBGLMHxilDhA6fNv+882mlEyXt6y9SbqZWbeZcpqFWXEpxygspe3sfuA0SLibCdx5DYyqh8qIv/SYkjFRSFa1YeXT4V9pF0TK4A6r2+4BcnXW8CLZpPOHzcIi3aPEdmdbwyQNCFM5EHTXn6gHGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255624; c=relaxed/simple;
	bh=e88PK1550TwXdpNHVoIH23dZq982DbcOeH15tOlEHSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjTp9kBya/4OQY6dJPPCQYNsr/JcHrSSu0auzSy/RST34sMWywX450d1CgF9bbcNBLcKM+ghYs5XF1jtnE7UV87Mze+0YVhzDiLc2uhl4yrDkUntxCgPSqeqJ4Ir5K1Ykw8W+gnR7mZ0W5lmneagcJxxpr4tiQJaCSHplSgWLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czmSVlnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5629C4CEF0;
	Tue, 30 Sep 2025 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759255624;
	bh=e88PK1550TwXdpNHVoIH23dZq982DbcOeH15tOlEHSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czmSVlnPPYpkVZHNoJS5Ue5LsO9/ctsskKKlKQ1Kj4FNTcvgeKQOkJC/yb3vL68Ir
	 zuo+MWJUG4lsT+GFDpB2JQ6PYJLHqV6V2gdlNGly6kkt03/S3yQxmzjQ8I733gnP61
	 q4wWFciFV/TEM97AtwLivWA+o11S4O8hwbvHt3w0AK8xSnAta24kiTaO5ideyFDj3j
	 OZEoSoR91tpP01cwPNLqFP7f3bWnlvCIBUS6USExY+o4AflBnWgcI7v4FZHJdGOzyn
	 Kqzoeg2mBCGWgdl8rmRR10NJJhRHZOQ5tgM4jQb0U4uvuRWVzvWMpWd65al19Rr0yC
	 e3FJWGZ1VgapA==
Message-ID: <83af8076-0c18-40e6-833b-1b761af2e1b9@kernel.org>
Date: Tue, 30 Sep 2025 13:07:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] AMD root search fix
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Filip Barczyk <filip.barczyk@pico.net>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2025 11:45 AM, Yazen Ghannam wrote:
> Hi all,
> 
> Recently, there have been a couple of reports of the AMD64 EDAC module
> failing to load on v6.14+.
> 
> This has been root caused to the recent AMD node rework. Specifically,
> the root device caching method breaks on non-reference boards.
> 
> Patch 1 is a proposed fix.
> 
> Patch 2 is a minor cleanup.
> 
> Thanks,
> Yazen
> 
> ---
> Yazen Ghannam (2):
>        x86/amd_node: Fix AMD root device caching
>        x86/amd_node: Use new root search helper
> 
>   arch/x86/include/asm/amd/node.h |   1 -
>   arch/x86/kernel/amd_node.c      | 107 ++++++++++++++--------------------------
>   2 files changed, 37 insertions(+), 71 deletions(-)
> ---
> base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
> change-id: 20250930-fix-amd-root-2a6529e8162a
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

