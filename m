Return-Path: <linux-kernel+bounces-731675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC533B05816
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C403BFF95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B71494C3;
	Tue, 15 Jul 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1n5vuBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D52D6414
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576287; cv=none; b=lNonnndoiNKs63LRO4ntyQ+qpTLtZwCygbRDAmwN7T0r8UMYibI+/p6B4vabNNo8ymA6lexjPFIjl2+fO0ss/yfo93LxNuxjwHEfsOLUwrjdz/eegcsplUtnwRBHbQ/b4A5/8jIJ0iE+gKWT5MkJzviSJnxt6Jgh9Njb0IPGzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576287; c=relaxed/simple;
	bh=ij9HxtNtdiFFDc1xDDKCbWEvFhjS34y8qM/iHGZqTm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em5xFpBxwPMwemmzGPaA4gyxzZOQZFELAKeQ6xioXrHZLkEACr4BW8yYlikiXzRA7Wa6c2WZszUVWWyxedaoPDy/Io9EgrEwMmdpTx6GZPBlBkA777El4W8pbGWnKMCcAn63X6F9T1k2JYVAABo+u7gtXkKhDPKbPhUT7gRvQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1n5vuBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA60C4CEE3;
	Tue, 15 Jul 2025 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752576286;
	bh=ij9HxtNtdiFFDc1xDDKCbWEvFhjS34y8qM/iHGZqTm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s1n5vuBea8a7piRN0B4vBg88lrZjktYoBOAbyDqLbhPQN0Zr4jxhbg5brFW/7AUiI
	 ZfyRVZbh67QXU0F5v7A/tmCFaUdNXpyAq8G7Q1DtnHcQZ58nByRvhYErSZf1tWf67F
	 LpVFwidoU1UZtoTRJhTCuqOh8NAjiW7Pwp3ZE+DO/jOuHk3RWO1L7OBePG+sFvOaX7
	 9KrpFR9s4I/j2jz92n8ZfIE3tCxqEXQP3mai8qJvKyqiu8iwJS64gFlDmeLDsblfTn
	 v2Lp7bAoSAjIVICzKPfihiYUiuFlOoKzs3FR3o9GZF0v2tGkfbqw/Giq7ZPRxL3Qkz
	 /Kv4yDvAwTOdg==
Message-ID: <12c6632b-65b7-43da-a954-7107ac8cb1b1@kernel.org>
Date: Tue, 15 Jul 2025 12:44:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display:fix a Null pointer dereference
 vulnerability
To: jackysliu <1972843537@qq.com>, harry.wentland@amd.com
Cc: Austin.Zheng@amd.com, Dillon.Varone@amd.com, Security@tencent.com,
 Sung.Lee@amd.com, Wayne.Lin@amd.com, airlied@gmail.com,
 alexander.deucher@amd.com, alvin.lee2@amd.com,
 amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 joshua.aberback@amd.com, linux-kernel@vger.kernel.org, linux@treblig.org,
 mario.limonciello@amd.com, ryanseto@amd.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
References: <220f9fb4-45ad-4997-9572-564242737dd4@amd.com>
 <tencent_54FF4252EDFB6533090A491A25EEF3EDBF06@qq.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <tencent_54FF4252EDFB6533090A491A25EEF3EDBF06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2025 05:16, jackysliu wrote:
> From: jackysliu <Security@tencent.com>
> 
> A null pointer dereference vulnerability exists in the AMD display driver's
>  (DC module) cleanup function dc_destruct().
>  When display control context (dc->ctx) construction fails
>  (due to memory allocation failure), this pointer remains NULL.
> During subsequent error handling when dc_destruct() is called,
> there's no NULL check before dereferencing the perf_trace member
>  (dc->ctx->perf_trace),
>  causing a kernel null pointer dereference crash
> 
> Signed-off-by: jackysliu <Security@tencent.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

You should disclose that you used some AI tool for that... and that
other report(s) was really fake finding.  People should know you
generated it with AI, so they could make informed decision whether to
even allocate time here.

Best regards,
Krzysztof

