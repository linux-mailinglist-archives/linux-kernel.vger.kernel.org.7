Return-Path: <linux-kernel+bounces-760050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA4B1E5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FD116E6F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167CB2701D6;
	Fri,  8 Aug 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT0YrPr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9F1A2381
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646909; cv=none; b=UlMDGO8naV6GNAR+6Bv0jjPGNZBrlGKM2Jt4cOm4+NDqC2ksy82bzB7qXMmggBNtwnFw5p1ZnRwdJKpJRp/5vvlj4qmb9pYwYEhZO1qFDXJj80wDYmd+6KKB0hl296Ci7gFsqsZAse5BCtgpxwW0m0bI1YqghsWaAkOJKMYJBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646909; c=relaxed/simple;
	bh=kgpYzkkc9QBv25eLpNVRLprtqy4ju/PA00/LlkuHvpA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kUnCrzdnQCtaEagoVput4348GlYFW6Zwz8TxnedHQUgzROPnOHBveR4Js5ET60QJkyh8X7zxD+i29tbZAw45lvVS4CE7KNTGtZ6BnpRxZh28DjJhCDR26FrMHdXAWZopoH1jkcLV7WYiiXA74ir3rDfWchpYXEUpwFVvGeVSdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT0YrPr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA912C4CEED;
	Fri,  8 Aug 2025 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754646908;
	bh=kgpYzkkc9QBv25eLpNVRLprtqy4ju/PA00/LlkuHvpA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AT0YrPr5ZgcMul/B7fsYnlxg+25IpvnpKd5Wa1xey8t0aB7MTZvc36cXdmR16X6Pf
	 ybVd6n2N2cUqhLlqvUjHo30/eSoTVDjGQSyxzQC3l72GrUsn4K/7G2Sp7OfBU0LjHa
	 mAhunjdPLf0XN/fi4PqRhzeCmYcWLaRvaXEDEoarD/HoiiH3y2P1/PL7uwTeLMCHFL
	 Is+kpb0ERePcWvM+WWpmHygbqincjsTs6hn5EkvP685GL1HEZqxRFbudzF+xrroGKs
	 DCjxqNRsD8qjzYeCh9fX0XMVolCLnWt4iTf5pWpaT5pd8wN8hlfYloKmXSEWb8kYxH
	 8SWSEQDl6PXlg==
Message-ID: <19a5cdab-a0e9-46eb-903f-f9bf405804b9@kernel.org>
Date: Fri, 8 Aug 2025 17:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] f2fs: Add bggc_io_aware to adjust the priority of
 BG_GC when issuing IO
To: Liao Yuanhong <liaoyuanhong@vivo.com>, jaegeuk@kernel.org
References: <20250808094801.250480-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250808094801.250480-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2025 5:48 PM, Liao Yuanhong wrote:
> Currently, we have encountered some issues while testing ZUFS. In
> situations near the storage limit (e.g., 50GB remaining), and after
> simulating fragmentation by repeatedly writing and deleting data, we found
> that application installation and startup tests conducted after idling for
> a few minutes take significantly longer several times that of traditional
> UFS. Tracing the operations revealed that the majority of I/Os were issued
> by background GC, which blocks normal I/O operations.
> 
> Under normal circumstances, ZUFS indeed requires more background GC and
> employs a more aggressive GC strategy. However, I aim to find a way to
> minimize the impact on regular I/O operations under these near-limit
> conditions. To address this, I have introduced a bggc_io_aware feature,
> which controls the prioritization of background GC in the presence of I/Os.
> This switch can be adjusted at the framework level to implement different
> strategies. If set to AWARE_ALL_IO, all background GC operations will be
> skipped during active I/O issuance. The default option remains consistent
> with the current strategy, ensuring no change in behavior.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

