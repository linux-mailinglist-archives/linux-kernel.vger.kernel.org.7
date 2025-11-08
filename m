Return-Path: <linux-kernel+bounces-891732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F912C4357A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35903188D4CE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751F29C321;
	Sat,  8 Nov 2025 22:25:00 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C02853FD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640700; cv=none; b=VsaTAmRP+fbP97vA6aRdY6Q5RduiGFftSwk2ECswCZLOQEnrbjweTxw2iYX47c+UoIFCgMnsMH7ilqhT2xaYJLoDw1XEvsqDw3yJXdLDnTKwhZFXBUtqCfv9PaRyei0WRwm1Dc4hTS/LZTQn7lI/cD1b9RNOh6FpssDBEgLIfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640700; c=relaxed/simple;
	bh=2Mv2eWVx/Gp/9zmenLTCFy4zz2PyZwi5pO/4yt7VAqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqZesJ9rl58DaAwszg0MKEya4rC+Gl/FFhNrX0+dFXAKnPBze4DC2AUHa60vAXr279W/zWkK8XrdL/iO3htzASAal4HeXfhHS+L24zwmZ/OY4v96Ea/PPKllGeZUN/ERLkPeB9jEpHwQT+TsP9rmTR9JFAn6BRpyz6SZR0LLEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88245cc8c92so1317786d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640697; x=1763245497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIK9zYAgTOFKn0gaT0fUYRv/pXw/XsmvNmFsqqYFUAk=;
        b=uY9GiNRb2dooXlkzG5mRU1XZM96apJ62dWX5ao39vbw6XD2Z/+F8j9et8L4qVjr6El
         Ho2sfoZ7hmQMBzP7v17DlMscPupR6Gvaf3EgeW4T287SXVi/wdSK2uRi9hDT9p7TVwiR
         eTMNA8RoFGHIvV9XiXlvgPS5bFdR68cHEEYKl7iY74pPKQRm4y/Zg4NO2tcBpU0mvuSN
         0J7ECh4tzs8FxjxkahB7ZGq1eE6GfK4AINPrWsbVLffBgS14Gw3ACLYN09GqIMQFeU9r
         XF1X2rVbADWRFoP4yffg2VBwRTNiCMho9KCiCXy1LMOOoKUWL41rzu8TmfmjFPP7lJRG
         Avjw==
X-Forwarded-Encrypted: i=1; AJvYcCX7qm+dW3La9BJbifjZojbWxIIokj+OPGAiZL/zXYFq9j447+wJJEw4mETw3irAljqmbJY1UL7noDP0vxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYQMhZmTB6TYmhRyksgUQ/wOX8zVGKY6EWu+J1e4vFPLphPoc
	X2OYk2fmMk9UwOuQ0/E/CtKgcJG4H7GHYw21f7ehDkXnQf6hIich2B6I
X-Gm-Gg: ASbGncu8UOkUGt8HFaV3jRaf+E3DSMs/CSLo9pZfJVzI6wSPOnv3gxNASYIJosIKNbp
	QBa5ACasHDApcSo1dHEWD075+93wYeiDezXPFzCYYKRzQ01o9gIysGYCml14PHrOYe9F38FZEAi
	aT1LKgzmmQXganG+/Jh634Rq3RdpHl8MSK6eRhVZK7lOPmMwifu341MJnUi6x8dP+5rUXwDy1NL
	Kq6Z5h8NLO331uWv9w8TPT2RDlHaSlzoSDcvyAlHLR9zSOM95MkeuCYETEWuPhCkfhpkKD4wSkz
	3cnbjx1OixRoQQFOzaBIk8SlZ37gBGur5zLwbWUBrTHZskLpj15bgYAJz/bpbCvFc7aPH4ZFta7
	P4qoM3Hmssrs5BWLNOAVh/ZGo1LXcJK1p+RbzSPfZ8BaaqDpgq5cbYWUePdDMFJ4LYVC9RgJ80g
	Mr
X-Google-Smtp-Source: AGHT+IEjXFwr+Srm4QmfVRgu2vNEak6lu57AWOlSK22OF1wICTm1uk8SpWxSTMr5t0Nyhn7q3c8MDQ==
X-Received: by 2002:a05:6214:daf:b0:880:5851:3c61 with SMTP id 6a1803df08f44-882384ae832mr39079716d6.0.1762640697346;
        Sat, 08 Nov 2025 14:24:57 -0800 (PST)
Received: from [192.168.2.45] ([65.93.187.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238928a80sm21582896d6.9.2025.11.08.14.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 14:24:56 -0800 (PST)
Message-ID: <baf4fd6c-1796-47cb-a9bb-72521a217453@vasilevsky.ca>
Date: Sat, 8 Nov 2025 17:24:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Fix mprotect on book3s32
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nadav Amit <nadav.amit@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org
References: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>
 <878qgg49or.ritesh.list@gmail.com>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <878qgg49or.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-08 14:16, Ritesh Harjani wrote: 
> Shouldn't we flush all if we get tlb_flush request for full mm? e.g.
> Something like this maybe? 
> 
> +void hash__tlb_flush(struct mmu_gather *tlb)
> +{
> +       if (tlb->fullmm || tlb->need_flush_all)
> +               hash__flush_tlb_mm(tlb->mm);
> +       else
> +               hash__flush_range(tlb->mm, tlb->start, tlb->end);
> +}

That seems reasonable, I should be able to test it next by next
weekend and re-submit.

> Thanks again for pointing this out. How did you find this though?
> What hardware do you use?

I'm on an iBook G3 from 2001, running Arch Power:
https://archlinuxpower.org/. I found the bug because SheepShaver has a
configure test for mprotect, which was failing--I was quite surprised!

The bug reproduces easily on qemu (with the `mac99` machine), if you'd
like to try yourself.

-Dave



