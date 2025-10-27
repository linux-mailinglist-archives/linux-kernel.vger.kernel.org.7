Return-Path: <linux-kernel+bounces-871942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D742C0ED90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3821341D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A384308F13;
	Mon, 27 Oct 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjHqcYc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D022D8793;
	Mon, 27 Oct 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578036; cv=none; b=uZXMkxQPAvdwGKFik1i0KP9jxzxqPF3zh5rNVkKXchWERfymmwPTZMVmdMhS4mrs1mJ2cswDtKczOiMJKT64IRZvr6n+uWWawA23JUPGQkXWGKkSoP0Remt5hs3ksYxAviJczmapglh6XYk1yhep6QgI0+fxFgqZaxMMDQ/uEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578036; c=relaxed/simple;
	bh=W2Fm/JXD3DZoOXC3XAzhtcZToQPBAK1HXhOkauQfS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re62jwoQ4TAWk1KwtoCZUDN3/2JoENEOx9puJkss+1MP0VsIRFSdvSEyQVZyjRG9BRsi8ITfNsTiNIsxTLenlOXYFoZIf0Vmti3/t5zD5TOTQ69TFBBEqavTJF+0lA2Zq0ozXQI0pezpoLiCmq1jiDLrL/pkXpzfVZ21kfeftG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjHqcYc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6ABC4CEF1;
	Mon, 27 Oct 2025 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761578035;
	bh=W2Fm/JXD3DZoOXC3XAzhtcZToQPBAK1HXhOkauQfS8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjHqcYc/bPckDKMAfWyb04uL6xHe4Sfz7haCynNGyDUcz3ouzLeBxJzZb/HA0Q0S4
	 SDfbr+exnE4dssaEmxfq51u1izA5kQd0331hzYLOaWtMsrSqU55Mo2ENaScUFqRr6/
	 D9vPKEluFb32VANqEU/Yp9I0PF5S5XhhkQeW2KlqzXTaGNa2XxyW7LkS5t6jqKNUZb
	 ApCpg0waTEa8vzr5ILz7EnK5R9kGIzqL/L7iCHoNRRFEzGxppbOSxwxl62DxWYP4O+
	 7BzIDSnHw0z/p5/XqJ8j6ND4hsURGHnwpb0cttb/GtYiVBqLMQqNoDKQxfFDrlc1uY
	 CCL4BPcbUhfdA==
Date: Mon, 27 Oct 2025 10:13:52 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251027151352.GA765054-robh@kernel.org>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
 <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>
 <20251025-shakable-jujitsu-3a5e9c8895a5@spud>
 <ugmphokne6ssc7ou7apvbldxg7xxk24wp5jrzdasjiplnu6gfy@ebbuxnjqlsw4>
 <20251026-registrar-impart-0f714e11e410@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026-registrar-impart-0f714e11e410@spud>

On Sun, Oct 26, 2025 at 09:44:12PM +0000, Conor Dooley wrote:
> Rob, Longbin,
> 
> On Sun, Oct 26, 2025 at 05:47:32PM +0800, Longbin Li wrote:
> > On Sat, Oct 25, 2025 at 01:44:00PM +0100, Conor Dooley wrote:
> > > On Sat, Oct 25, 2025 at 10:27:13AM +0800, Longbin Li wrote:
> > > > On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
> > > > 
> > > > > > ...
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    oneOf:
> > > > > > +      - items:
> > > > > > +          - const: sophgo,cv1800b-top-syscon
> > > > > > +          - const: syscon
> > > > > > +          - const: simple-mfd
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  "#address-cells":
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  "#size-cells":
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  ranges: true
> > > > > 
> > > > > Do you actually use ranges?
> > > > > 
> > 
> > Actually, I do not use it.
> > I added it following Rob's suggestion in
> > https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/.
> > Should I drop it or not?
> 
> I don't know why he suggested it, if it is not being used. Rob?

Child nodes are memory-mapped, right? MMIO should have 'ranges' all the 
way down. Doesn't matter if Linux (currently) uses it or not.

Rob

