Return-Path: <linux-kernel+bounces-814761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DCB55859
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D2AA81D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542D264F9F;
	Fri, 12 Sep 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMB5kFz0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE422256B;
	Fri, 12 Sep 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712460; cv=none; b=Qh5wngyPgOUF805PWUX18AXZOPRpmBfpj9JoCGoXhhN1OMxvsETT8JwQUysUYuhf7va4c83FjSxsZmFWKucAxrw3anPfVb8TT6cGBNluU5seNa4TVwZUP1QH0fB+IiQiBTS7DBOcKYGYGwkFDNQbeZV7snx+Qo3lqYkztFJEwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712460; c=relaxed/simple;
	bh=RGcx0TtggTU05NRX/31eZRhT7+0F5HLxdRyakxLHmjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJd8u0DVVb3XBlNkYVA8dlFIZnZfn12NSjyl+pN62xUX0qvdL7y9ZKBZzg/xD3NjWFJpJqW6ZYbz4W8u/F2PtD9LwkQ3UJayhNH1WoZciCKCkpVFgBVTHLsaIqbybI2v+2EDSGcoEJBdYJExoEOjJ/wAzEtnDwdXPaedv4BEX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMB5kFz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6496EC4CEF1;
	Fri, 12 Sep 2025 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757712459;
	bh=RGcx0TtggTU05NRX/31eZRhT7+0F5HLxdRyakxLHmjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hMB5kFz0BK530ASXZdztqWyR40j1z8lSTN/Q6UgQSaRDUL0ysc37zYiXY3W74T2sR
	 9ebo5pcNXJ6Szkv7P2rfIByTJuSCrDqQ4P1dt986Sawn7PpCpz0eAowkxd6ItR2Sw5
	 RETLSlU6Xt7TINo00WaRMsECxl8EKJEfyp8WMl6hDFtFV84fiCtN4N2NlqZHJA2O6r
	 DdXRTZM+y1pMBrl4jEYnv3aQeEb3FDeo4V7/2gjQcAWd/5r7yaxGW7IVIDjtKXLQqu
	 xci1hjsHSP8HhCJNSoPm4EM1wHjzqlTDwiO6CT2yVI7tMaR85CwnhyLtbHlZBAGv+E
	 om3KlER42getA==
Message-ID: <e0252635-4dc4-483a-911a-fee5a36c19c3@kernel.org>
Date: Fri, 12 Sep 2025 23:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm: Add directive to format code in comment"
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Garcia <rampxxxx@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250912130649.27623-2-bagasdotme@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250912130649.27623-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 3:06 PM, Bagas Sanjaya wrote:
> Commit 6cc44e9618f03f ("drm: Add directive to format code in comment")
> fixes original Sphinx indentation warning as introduced in
> 471920ce25d50b ("drm/gpuvm: Add locking helpers"), by means of using
> code-block:: directive. It semantically conflicts with earlier
> bb324f85f72284 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
> usage in literal code block") that did the same using double colon
> syntax instead. These duplicated literal code block directives causes
> the original warnings not being fixed.
> 
> Revert 6cc44e9618f03f to keep things rolling without these warnings.
> 
> Fixes: 6cc44e9618f0 ("drm: Add directive to format code in comment")
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Need me to pick this one up? Otherwise,

Acked-by: Danilo Krummrich <dakr@kernel.org>

