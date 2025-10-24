Return-Path: <linux-kernel+bounces-869150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD7C071C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E403F1C012BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966432A3E5;
	Fri, 24 Oct 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvAFvNfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FB21A238F;
	Fri, 24 Oct 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321296; cv=none; b=atjHttOZ+pOD5gOcK4Vp6su53F9FK2Uqkg7R9rXcUxSg2rZ79OxlObfoERwJmEBzmr+RBLxv6sNQhMLI1sEVkDuzSZj56AJqE6ERdxLSu/pWhZiIl/fvlpIFgRMhcxMv2x034LPKcPxs0egOagbZNdwo5Oa7PSu0nZiXnzV1rHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321296; c=relaxed/simple;
	bh=JqnMh+5p4gimxlPXBBgYVudpI66hb0Yj008dLNRPMuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBKJOo8J9AH/FJYxolOuaO3MI+TZHiXpGlDl308JfphOByQVk9dA6FGMu0RW8YLgvzw/9PjNvH+BZuad7ulyXFM0e5LhfWWTeHWQTvZaydwc0bKIEaQNsrz+amQ02naZFx0ZAGqWKEod7HWNxKfc5f3+yWESW60TaVZQ3ECnEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvAFvNfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE852C4CEF1;
	Fri, 24 Oct 2025 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321295;
	bh=JqnMh+5p4gimxlPXBBgYVudpI66hb0Yj008dLNRPMuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IvAFvNfGiNpSsaNZYql90XJMUVb/2lkR2Pj6NQXPTtZ9xd7OTmQjSpxPZz3yfBAMM
	 Np23ewISAbJg3Ibvn3rbe/XRXN9oRMgaH9HQvn/1rjTuKQvT+i28U2TxIvfHwHnnCb
	 vjmf6rW08g9DBrcSznmqdO8F5b5iBcTMeZ8hkzQKSB9s/rXDUH92zxfZrtM+FEQTXa
	 1shvHKJSUuViDur4SnjDoMWA57zXwHXniLH6yPtLWk/HYDP3EtenIWUlNlamtt3vgf
	 m/cAFA535KyQ9YbsSMiTZ6bPL+wNBqGk0Za9MpfTYE5oxG+mmEzVlyy13qhajY9o28
	 /0G7W3fN6Jr+A==
Message-ID: <314fb56c-54b6-48e8-a5dd-a615712003f1@kernel.org>
Date: Fri, 24 Oct 2025 10:54:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] platform/x86/amd/pmc: Add spurious_8042 to Xbox
 Ally
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-3-lkml@antheas.dev>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251024152152.3981721-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> The Xbox Ally features a Van Gogh SoC that has spurious interrupts
> during resume. We get the following logs:
> 
> atkbd_receive_byte: 20 callbacks suppressed
> atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.
> 
> So, add the spurious_8042 quirk for it. It does not have a keyboard, so
> this does not result in any functional loss.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index d63aaad7ef59..eb641ce0e982 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -122,6 +122,14 @@ static const struct dmi_system_id fwbug_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
>   		}
>   	},
> +	{
> +		.ident = "ROG Xbox Ally RC73YA",
> +		.driver_data = &quirk_spurious_8042,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "RC73YA"),
> +		}
> +	},
>   	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
>   	{
>   		.ident = "V14 G4 AMN",


