Return-Path: <linux-kernel+bounces-724716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE7AFF631
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EDD4A2D45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F782899;
	Thu, 10 Jul 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXeD96cj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE89539A;
	Thu, 10 Jul 2025 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109103; cv=none; b=UdOGcp/Cjswx+qJjZGBxzcOMtNCFNQVyrtzQKMuRxHpDMZmC3fRS1N/OCPMUSBzByctDdMsMc1EnMjWURrZzT/zLALpo5YaUKN/bQDUaRY4r2JvK7Agk0JYgl4Kn54C41zKH47ZCLGRalMnmPvXuuGO0/3O6kXKiaO9YpQv+fEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109103; c=relaxed/simple;
	bh=P1d0IshYGbaAr/Hr/+3PPdk883uiqvPufCBEpnmmtQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjaEY4tXAPIeTxWxsqZO/Bt/D9KReClKxAUH70cy4ae5+p+5ngTmEMM08Bvq8nWdFL28KNPqnOlPllf3TwBWQa9KuRKwt6baR3rq5ZWYaW3Zl/E+/jLR/JpUHrBCqQaoqOhu5TmbEM2JW3NKIUzyNhidrzHdDiNrHgiAy79qjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXeD96cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AB6C4CEEF;
	Thu, 10 Jul 2025 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752109102;
	bh=P1d0IshYGbaAr/Hr/+3PPdk883uiqvPufCBEpnmmtQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXeD96cjQYgk7BBvsbsPthJVjBguygDmr58DkUqtClTt8EYDlOo2PO4EDaT8nBO4l
	 1htaIsnjtbK2zziciZHnyyoagRCGsofviI36cLjmtD9e9fIpsOuA85YaUDMtq/+7eD
	 eYymN8TttJ1F3gOdwf5maxP6ljB7eeD4/NphgE+w/tSEIrYTarNMwtI10URmBjDdSy
	 AGqsXOcoiltthV0WfAIRQhEx/YHJyxYlDSHL175fZYxZUUbteBiccq6UzGgJePXyZf
	 8XNB4PH7ApHiVscyApAwanNQw+aCFeEOQp3VHlpMAN49Rk9o8pJoJgcbRLqjEa+zzD
	 vNcELqwyc9hlQ==
Date: Wed, 9 Jul 2025 19:58:21 -0500
From: Rob Herring <robh@kernel.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: linux-doc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org
Subject: Re: [PATCH] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
Message-ID: <20250710005821.GA94507-robh@kernel.org>
References: <20250624181320.2810521-1-raymond.mao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624181320.2810521-1-raymond.mao@linaro.org>

+devicetree-spec (because linux-doc doesn't really care)

On Tue, Jun 24, 2025 at 11:13:20AM -0700, Raymond Mao wrote:
> When managing multiple base device trees and overlays in a structured
> way (e.g. bundled in firmware or tools), it is helpful to identify the
> intended target base DT for each overlay, which can be done via a
> top-level compatible string in the overlay.

I think this should be more general and more specific at the same time. 

You might not want to match on a top-level board/soc compatible, but 
rather the compatible for a specific node. For example, you may have an 
overlay for a cape, hat, etc. that applies to a connector node and that 
connector node could be on any number of boards or even multiple 
connectors on 1 board. That's all under development, but so far in those 
cases we expect some sort of connector driver to apply the overlays. But 
I think you could have the same issue of identifying which overlay files 
are relevant. I don't think folks working on add-on boards have thought 
that far ahead.

And since we don't know the target-path up front, it is just left blank 
so far. It would be better if we expressed *something*. Perhaps 
'target-compatible'? Something like that would work in your case I 
think.

You'd have to be somewhat crazy, but you can bundle a bunch of 
mutually-exclusive or unrelated overlays within a single overlay file. I 
don't know that we want to prevent doing that. Someone might come up 
with some not crazy reason to do that...

> 
> This patch updates the document with a note and example for this
> practice.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  Documentation/devicetree/overlay-notes.rst | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> index 35e79242af9a..30b142d1b2ee 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -103,6 +103,34 @@ The above bar.dtso example modified to use target path syntax is::
>      ---- bar.dtso --------------------------------------------------------------
>  
>  
> +Overlay identification
> +----------------------
> +
> +When managing overlays dynamically or bundling multiple base device trees
> +and overlays in a single system (e.g., in firmware, initramfs, or user-space
> +tools), it becomes important to associate each overlay with its intended
> +target base DT.
> +
> +To support this, overlays should include the top-level compatible string
> +from its base DT.

The base has multiple compatible strings, so which one? Has to match on 
any one or all of them?

> +This enables higher-level software or firmware to identify which base DT
> +an overlay is compatible with and apply it accordingly.
> +
> +Example usage::
> +
> +    ---- bar.dtso - overlay with top-level compatible string -------------------
> +	/dts-v1/;
> +	/plugin/;
> +	compatible = "corp,foo";
> +
> +	...
> +    ---- bar.dtso --------------------------------------------------------------
> +
> +This top-level compatible string is not required by the kernel overlay
> +mechanism itself, but it is strongly recommended for managing overlays in
> +scalable systems.
> +
> +
>  Overlay in-kernel API
>  --------------------------------
>  
> -- 
> 2.25.1
> 

