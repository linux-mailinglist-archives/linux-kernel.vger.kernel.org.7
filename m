Return-Path: <linux-kernel+bounces-768359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED29B26030
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454205C670A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4B2EA46D;
	Thu, 14 Aug 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbXqa7gm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095242FA0CD;
	Thu, 14 Aug 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162040; cv=none; b=AX684Po0byKUpXWmYB/LqQU2g09dd6zOCfraGhfUiIzdTCl+9JyUE6eAYSYhWf0eoJCIC/UxQJtVX3TLK6h8Yz13JdOqRn9hJ6107JKextr3LBADPpUXqfFro67dsVWGRRzNyQgV4Vy3a8eNDLfOhMqNZpS/pF1zNPR7m90BVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162040; c=relaxed/simple;
	bh=EGVHfeu0wPCbhXQ0h6+1/VSrfLHeLlCk/KVjHEkCufY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T70uICB80SyjezK4023rmaO9wqVOJOLTdIGJVqvfFzqXdqCXVsN7wkPU0ystsoVxpSw9CsuxhK93B0aF/V3CNeLPIzgjeYPeLZnaLvRBhbBrzeUP+fSaNesFzuQhUcaGBp6SR7eOdROb1gvM/RW19yRYahSHP24hhX5T6FeMcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbXqa7gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA089C4CEED;
	Thu, 14 Aug 2025 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162039;
	bh=EGVHfeu0wPCbhXQ0h6+1/VSrfLHeLlCk/KVjHEkCufY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbXqa7gmmKg9J1uFmxvqJx7OqUY9EXZqk/wrAJ0kW4qOc0I495spwEFyuXfX4J9qS
	 NvxKYJmugRwGBq46XXNoIqgMUfH0C+TR+LYGhtRN3+VShPwFCLjjS81T+EXi+zY4Ja
	 NhE1XNX5UI2gmxcXJOnIc9x4c3ZKqSQn0FJzDdgAy2hLQXcdI7krOm7gjrkeMLcqrf
	 xjXTG2USDd0PX2+FZRTPSD7ceAA8z8waj+NkefNBtJ2e1qT2kyfNwm5Cntn/6YnrB1
	 a2B0Ui7GXlwHEnvm3oHU0o2wFcWs32c0igzKM0ozTMdkwZhUfNilZZANGfhMID1cxU
	 hn7K38Qpo1pDw==
Date: Thu, 14 Aug 2025 11:00:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Smirnov <asmirnou@pinefeat.co.uk>
Cc: mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: Re: [PATCH v2 1/2] dt-bindings: Pinefeat cef168 lens control board
Message-ID: <20250814-imaginary-authentic-agouti-07a3dd@kuoka>
References: <20250811213102.15703-1-aliaksandr.smirnou@gmail.com>
 <20250811213102.15703-2-aliaksandr.smirnou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811213102.15703-2-aliaksandr.smirnou@gmail.com>

On Mon, Aug 11, 2025 at 10:31:01PM +0100, Alexander Smirnov wrote:
> From: Aliaksandr Smirnou <support@pinefeat.co.uk>
> 
> Add the Device Tree schema and examples for the Pinefeat cef168 lens
>  control board. This board interfaces Canon EF & EF-S lenses with

Also, some stray indent is here.

>  non-Canon camera bodies, enabling electronic control of focus and
>  aperture via V4L2.
> 
> Signed-off-by: Aliaksandr Smirnou <support@pinefeat.co.uk>

Best regards,
Krzysztof


