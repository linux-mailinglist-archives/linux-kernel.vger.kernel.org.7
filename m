Return-Path: <linux-kernel+bounces-732634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30CB069D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F021C21162
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62B2D46C7;
	Tue, 15 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPWdbcvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E82BEC23
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621776; cv=none; b=ufhdzvpR58BRJdbWAt4GnCiXIO3J0pBjYkrT+74sxt9dzAxxhRHlLMT6xF/TFSB/bXZJCn1OB2NkCFmMthoHVGwshSBb7R391jVthJ1sMJ2/cU2JZE4PDTF+qA7YgfMa4D7nmBjr1o+eufYA89uf8Qb+f2xnK2YuzPtUvrJIpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621776; c=relaxed/simple;
	bh=j1LB/sQmMIlG0zz2sXx8WmnMUfDTKW926uCb2WCG+s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzkKYjorbMguzZojZzW98DJEIZryzQP6iuvFj4q53ExSSp40zsrGUieMq72sRvN23FZ2FjvKra2UQYublVwZtvKKC5xERHUbxDNjnJTEtDikrZVkXFTV4imE3cxJ6dYcf/4R+3VpvDN7BjjvM9Ea5GXLwLMqRd6YolFSVj2kZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPWdbcvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4044EC4CEE3;
	Tue, 15 Jul 2025 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621776;
	bh=j1LB/sQmMIlG0zz2sXx8WmnMUfDTKW926uCb2WCG+s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPWdbcvUlzY1C+zDUKuNlaBRYqRppGCR75JNewSjs70MzRVuBJA0YZhZeojgnnUzG
	 217WE6TPyjuKgUVJcbYHC7L7jtROkocjwXrU/sGWVIxkwH5UNnlrNp3YmBKgVaCT50
	 VmnFhNydiTHs0ja5RdmKFfQZ0VozH4z24+4o1eTKOxqktakkLA8L1sazea/hd+tYdS
	 pxTNDUuv3XPT+vIcesvyYnOZNfU0bLIS6l1PmRE2Mx/lrKCubKHjwUKymFbYvGvA/E
	 6yGhYwjQjXOb/S/cREcFOfLvPZq7Cb6uxWJsEulXSovvtH8t90pEao3hW1w85jmAB+
	 ryaCAhJTjO4xA==
Message-ID: <5c038378-dd65-4a4d-9a5b-d3604769b658@kernel.org>
Date: Wed, 16 Jul 2025 08:22:54 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 18:18, Rick Wertenbroek wrote:
> Have nvmet_req_init() and req->execute() complete failed commands.
> 
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
> 
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
> 
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
> 
> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Forgot: this needs a fixes tag and cc-stable:

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org

-- 
Damien Le Moal
Western Digital Research

