Return-Path: <linux-kernel+bounces-890724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1701C40C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D68E4F3E10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B02EBDF0;
	Fri,  7 Nov 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRZ7r4cT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A82836A6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531640; cv=none; b=Kgzu9DqKn8P9YOwdX7vWkJYK7hC59cL7EsDmovDqPFGtZCPH2uxP4oUjzFSNYQBpPSumZ++bvCyro3B434lQE54WN/rwx4YkJQUeyqiIFg0cxfzytMpWmVX4Rg+6dYpRpV1i8lYblHTS9QCO/dOTLmDhOZ1x6Xr1MYeiHNhf9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531640; c=relaxed/simple;
	bh=KmNg0IbiQSMgIBfWpyOISbt53znceGdIygj3J1+GoFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MIXOdixUV/6Sm6VmESyla3rmbRNf3WnA9alv4+E9B4DZ6Vma0tzYF6b1m8Kk5ShvXZmY+Y/YOpxundHXu4cC8VbO+kTjaAZTWCqZ5iIaQFY9epdcjQ88r2iYRyjDvaM49sJb1y7VBkrIxy3SbsmtHaVHBny8ZZo/NKTM8lSqtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRZ7r4cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214CC116B1;
	Fri,  7 Nov 2025 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531640;
	bh=KmNg0IbiQSMgIBfWpyOISbt53znceGdIygj3J1+GoFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fRZ7r4cTjf5cb+wQfQZKSi3nxrTbj66GE5KbiX42htXpJ44IXf3nBmo+xC4o+q7TA
	 BRXzD67osZZSe5TEP3UnkDASXEMhdSAiGFcXkjedQ7CCSsHMJlwH57SJmRIb/XCc+V
	 sa8Wvr4hF1Jw3bYrpn3i2K6GJEMueq3rSmlNZQiOu89kvKXq8kl+xoD56DiPOKor8h
	 XPHuYlvf27NrmVcpFt+gtjOFbxd/4hbMJbfWr+jh5UFLH2X2tiLpibtfSo2h7LWloB
	 eGQNAROrX3tSYtgs66K6dFgmfjbzrkO5Jm79bK1xZlxpbl2e+L4DUnV41N81eAfEqB
	 gOE15k6fuoYGQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  rppt@kernel.org,  graf@amazon.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
In-Reply-To: <CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 7 Nov 2025 06:15:37 -0500")
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
	<mafs0cy5ub0nc.fsf@kernel.org>
	<CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
Date: Fri, 07 Nov 2025 17:07:18 +0100
Message-ID: <mafs08qghbzd5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07 2025, Pasha Tatashin wrote:

> On Fri, Nov 7, 2025 at 5:24=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Thu, Nov 06 2025, Pasha Tatashin wrote:
>>
>> > We must check whether KHO is enabled prior to issuing KHO commands,
>> > otherwise KHO internal data structures are not initialized.
>>
>> Should we have this check in the KHO APIs instead? This check is easy
>> enough to miss.
>
> I considered adding a kho_is_enabled() check to every KHO API, but it
> seems unnecessary.
>
> In-kernel users of KHO, like reserve_mem and the upcoming LUO, are
> already expected to check if KHO is enabled before doing extra
> preservation work. I anticipate any future in-kernel users will follow
> the same pattern.

Hmm, fair enough. I suppose we can always change this later if it causes
more pain.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

--=20
Regards,
Pratyush Yadav

