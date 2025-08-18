Return-Path: <linux-kernel+bounces-774173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A53B2AF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A82894E2AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99923570C9;
	Mon, 18 Aug 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZEuau1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830932C33A;
	Mon, 18 Aug 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538309; cv=none; b=WGtXvXVcmm/5gGhPk33XWC0u0GCcVxVfeOJMyABpkknxil36hUmwvXpAOT5v+8ppfb4s9dS278FmaVIAkcu5FaX4hJS2U1LORceDkKNn2XiFjP8Kkq9Ej2KSGSLNHXN7YcjS/UDDFoP0qkmNun+iGSM5L9Ugb4Q+Uj4ehlhy0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538309; c=relaxed/simple;
	bh=mF/CW5aAEQgDT+OAezbsRp+d9z4XVVZyDXgDqKkePis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgo4oWNp9KcyLr4Q0Tyb/gRbSqy/p4Swxuvs0CIk6cFVWX0oOwjeOrZ2IOPOTp+zjpHtyYuJwsNWPZpRbU1XR0jofU0MVMWuul++MpaDiWuRZXhFPfRek5/SQF6oxtz7QaZbTkX75DOZe9wxjYI115ilzGoPTeNnHhgQdIllOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZEuau1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1DDC4CEEB;
	Mon, 18 Aug 2025 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538308;
	bh=mF/CW5aAEQgDT+OAezbsRp+d9z4XVVZyDXgDqKkePis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZEuau1ilMigYR6sE3ycqybvBBfxu4cT4RDewaxT0p3Folqihwx4NGgVB3CmBCg48
	 ihSDtZdmMy/unNb2Z5kB+E6+qYY6sZKL+h/Q2BxBBbscPlsxa2ZZy6H3I8e4UvTn1j
	 krRlGfhS96PPTzu3w7WvCXmob+iBe954KeJMUCqdT7wTw39BALf7mDZ9Zq42Cm/pkD
	 srQPQaLE8L/Z9VvB9R6e7wO5OUhZKvHFMtLaX5r1toCu12Uo2tiXLW1YJyza2AHGZG
	 DDUhzXlFBL6plUl3fpG27Cuq+THU21JeY2AzUVeh5nmTw3Z1IvaDNsQZHQmGZB9UP6
	 jrdbQ6U1u48jA==
Date: Mon, 18 Aug 2025 12:31:47 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Gregory Fuchedgi <gfuchedgi@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: update TI TPS23861 bindings
 with per-port schema
Message-ID: <20250818173147.GA1496879-robh@kernel.org>
References: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
 <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com>
 <eab6d2d2-9337-40fe-81c7-95dc1956ce6f@kernel.org>
 <CAAcybusHjAR67N0rumb6M_uG1ct3aa=zv2XkpUjhSSxv0NdzFA@mail.gmail.com>
 <ff167728-a4a7-4f7d-a809-d0e482ab7dd6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff167728-a4a7-4f7d-a809-d0e482ab7dd6@kernel.org>

On Sun, Aug 17, 2025 at 09:23:09AM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2025 05:00, Gregory Fuchedgi wrote:
> > On Tue, Aug 12, 2025 at 12:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>> +  shutdown-gpios:
> >> powerdown-gpios, see gpio-consumer-common.yaml
> > It is called shutdown in the datasheet, but seems like neither powerdown nor
> > shutdown truly reflects its purpose. This pin doesn't power down the controller
> > itself. It shuts down the ports while keeping the controller available for
> > configuration over i2c. Should I call it ti,ports-shutdown-gpios or maybe
> > ti,shutdown-gpios? Any other suggestions?
> 
> 
> Feels more like enable-gpios.
> 
> > 
> >>> +patternProperties:
> >>> +  "^port@[0-3]$":
> >> This goes to ports property.
> > Do you mean I should add another DT node that groups all ports? such as:
> > compatible = "ti,tps23861"; ports { port@0 {...} port@1 {...} }
> 
> 
> Yes.

Except this is not an OF graph. Don't re-use it when it is not that. 
Maybe 'poe-port@'? Is multiple ports/channels something common on PoE 
chips? I'd guess so. If so, then come up with something common.

Whether you should have a container node like 'ports' is a separate 
question. You get exactly 1 address space for any given node. So if you 
ever might need to address multiple disjoint things, then you probably 
want a container node.

Rob

