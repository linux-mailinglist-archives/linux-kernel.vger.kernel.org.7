Return-Path: <linux-kernel+bounces-858486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901EBEAF7E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1515E7BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C72F0C64;
	Fri, 17 Oct 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF68YOtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D82C0F92;
	Fri, 17 Oct 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720274; cv=none; b=AjZCnClYtig7QvQJ/kvgJmJiDTDiTgqpA9rNqkM3fG7qtt7FUC8UQZjymekCG8sq3C1XC9eW5Bu9BGVKSKkAsuI41fOWbdpRPP6bnNaBeYEmdOb5FqVgRWSivoKZgUSvdqjBTzA+Mcu9G74dEd1ABjMzqWl+yOKtneeo3j1toRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720274; c=relaxed/simple;
	bh=F6jxAb9rgM6brFkbFq3tCx4gKWPd0j6XJ3xy7PNBcSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL6sOye4xYfMm6EhxJiQ5z488pfu+Dmaa5O6A2oD0e7JLDFN5A2mWjGmBp746mHEpG1iadvWInqNHondo6eiHwlpKKLzCgdx2UeakhUN05+0xRj13tR+a9OYvTiuwDFRIg/1f/TPx3B/bfcMHOSbhSJN4cJKjZugjnFAsLCaZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF68YOtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6554AC4CEE7;
	Fri, 17 Oct 2025 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720274;
	bh=F6jxAb9rgM6brFkbFq3tCx4gKWPd0j6XJ3xy7PNBcSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IF68YOtS0wdkS7HKYOQHsSru9JiS7k49Jg6Voal6vFs9fyG5XHv3fojMzsc41WaGz
	 yXJXYc+NPmnLsQPkUw9MdzmbqozoLczhCwqOpP1ROA6l4jIzyN91skFlILU+6Lf8h6
	 7saxzDm1d0kQ81tFSJ9QaJcQj7iBLlUgDqvRi+ODZ8FkaCmCCmKxk0KJwb/WBwSvqf
	 DEDB5kLlROoguKJwIR+sdWYeyrn6egr9BmthkmrhCPLQY7ZX3G7AsWP6Dl8SuDVEsa
	 U91KQvcOrUvZUzTINsBN1mRmrkagjqF2L4aYHHe0K3DQfeerP73wTK7U47k92Vxq6C
	 0WSC6uV31sKWQ==
Message-ID: <41cbe52d-1d97-4889-95f8-8ea8257a94d6@kernel.org>
Date: Fri, 17 Oct 2025 11:57:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ASoC: amd: ps: Propagate the PCI subsystem Vendor and
 Device IDs
To: Simon Trimmer <simont@opensource.cirrus.com>, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com
References: <20251016150649.320277-1-simont@opensource.cirrus.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251016150649.320277-1-simont@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/2025 10:06 AM, Simon Trimmer wrote:
> This chain of two patches propagates the PCI subsystem Vendor and Device
> IDs so that they can be used by component drivers to differentiate
> firmware loads.
> 
> Simon Trimmer (2):
>    ASoC: amd: ps: Propagate the PCI subsystem Vendor and Device IDs
>    ASoC: amd: amd_sdw: Propagate the PCI subsystem Vendor and Device IDs
> 
>   sound/soc/amd/acp/acp-sdw-legacy-mach.c | 4 ++++
>   sound/soc/amd/ps/acp63.h                | 2 ++
>   sound/soc/amd/ps/pci-ps.c               | 9 +++++++++
>   3 files changed, 15 insertions(+)
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

