Return-Path: <linux-kernel+bounces-888066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF49C39C19
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A0E3BFA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD330B502;
	Thu,  6 Nov 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W528h3Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591C3093CB;
	Thu,  6 Nov 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420098; cv=none; b=DCnVbFjopdpCG5RSiuqgZV5QWiM4tHrfoPVGPUsOuZQSaJpIDZxYSyl58a2eB2pKjC8j6m55iWq7eGPGbcbNF2+7Z7xiQ8Wh1Pynije8YFQgrTxZ52mLIJ4mYa/j18DZjlCQEtlald7UxHzVYn1pLcUGq+sliR9kz5Y5hDfLdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420098; c=relaxed/simple;
	bh=rk1PT9PwR2eCejiCdlRuPwCQCGds36SuO0Ti60jsH8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQWvg38Or2miLR6gjADm2uTNKWOxwy+mVKOBmE96mAFh+bceH5kU6KcdjIpfwTZvmT13zoj9hqG+4+ybyen8a5Q1KMhpRSnFOvSAncDfflbeuUteFFkAHjQuRZ4ebD0gRXfZNoWzZaK/IcaBMhHU3yUxxjujK7EXG8pVex8qiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W528h3Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F34C4CEFB;
	Thu,  6 Nov 2025 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762420098;
	bh=rk1PT9PwR2eCejiCdlRuPwCQCGds36SuO0Ti60jsH8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W528h3Oqa4FXXHxfeqgTjFq2ulEARUCNwCEd0LEuxnwodMkXGJvS78/fwTeQ19iD4
	 4ZkNH+7NGh68H2saSQARfnXNV020vdnBY7oOJxoKm1mdQlFtzCc6IjU4S1u2OUceXd
	 rXzJO8M4t8be4b5SPbRn18zDHzeT5HqMMpE2IQFIZ5O93oyySpBNQc5/sdo2kB5iBU
	 ggZ182CxjPIstotj2YI9VjrZP+LrkbgWNX2jEXn0oetB7s2jDiYGjzFAXldA6uov57
	 fM5qZ0Qlbf4YYQZxPkvoDX/Pz1vCureUkICvOH/IOoWkD/8UJntakIMT/6Xl8IX3MG
	 8mCphn+pU4hkg==
Date: Thu, 6 Nov 2025 10:08:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mux: Add description for enable GPIO
Message-ID: <20251106-imported-bull-of-storm-8c19fc@kuoka>
References: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
 <20251105-add-external-mux-enable-gpio-v1-1-e59cba6f9e47@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-add-external-mux-enable-gpio-v1-1-e59cba6f9e47@vaisala.com>

On Wed, Nov 05, 2025 at 02:49:12PM +0000, Tapio Reijonen wrote:
> Add description for enabling GPIO-controlled multiplexer
> GPIO pins, according to the state of the mux idle state.

You basically repeated binding. Please explain here which GPIO this is,
e.g. give concrete device example.

subject prefix - missing gpio-mux:. You are not adding enable GPIO to
entire/all mux bindings.

Best regards,
Krzysztof


