Return-Path: <linux-kernel+bounces-775921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15EB2C674
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665CA1884837
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D7343D6F;
	Tue, 19 Aug 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogb6q3Zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FE343217;
	Tue, 19 Aug 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611932; cv=none; b=t6QPeDSKnXAu4dYRQzYfhzRlCHMjoFbwabFFhSMHCxQljvAlPwe7syFv00khxiG++id26p8BwE9xkUIiwtq0kghJLiZvefCmYNhEWV+TLSDHhN4V3VnBucYSjL58963rvLu8EtjQ25uyGGcgryFx8G0ZexQFXCVEnFt8DgfrVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611932; c=relaxed/simple;
	bh=qegJliyCwkUB9tOPFffvUwCm+VjLhHymTL03rrMDI5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNBYZmLpCbUNLsNrhAvRYuoolTAf4gZhYAeqvlN1CbRCmqfec8/RpGkHtDaagZFJZq1VRe0hxz6CryOnDKv2Vy4qU0xIfdn/CK/K31AkBmMqBUE/+ndEBQUmdQNDd/Gjl+r+HGFCeGQ6Upc9KYFFODiUgSNNT7uV6sGybM4wFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogb6q3Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D132C113D0;
	Tue, 19 Aug 2025 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611932;
	bh=qegJliyCwkUB9tOPFffvUwCm+VjLhHymTL03rrMDI5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogb6q3ZxsL3Pf7yxU+Ivavw47aEkHyn6W67vp/gW2ryEY2aT1erv92eZDsgI93gyw
	 TUbV0UdJocFNzVMVDhCJBhN6TTR6kgb9CWbXmnkHDJ32h5noBnG1o+lKSfq3nzwolj
	 pUv4xkFm/SjjfdGdfqCByMyTIMn455kOkLKdey9PklYOBtmSQ4+VDF0w0d6hANFkqG
	 w5ER7HiAWHgexqotU6+kAkL4QK7vtp4wZSlWNxwes84YDX6Mo83TJq8hRxVv3w2MKV
	 uHaWtHsVxBH3hgYtPK+5iuyE4m9x7cMtbrpgY/wqv+JUSGd61NJgonfKRg2qGUGtOC
	 Cs2gCsTz96QxA==
Date: Tue, 19 Aug 2025 08:58:51 -0500
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	devicetree@vger.kernel.org,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: st: add new compatible to
 LTDC device
Message-ID: <20250819135851.GA115029-robh@kernel.org>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>
 <175560127037.3969097.6130940505156039734.robh@kernel.org>
 <e144225c-e0e6-4d3e-a4d8-e4c48cdef3f6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e144225c-e0e6-4d3e-a4d8-e4c48cdef3f6@foss.st.com>

On Tue, Aug 19, 2025 at 03:17:46PM +0200, Raphael Gallais-Pou wrote:
> 
> 
> On 8/19/25 13:01, Rob Herring (Arm) wrote:
> > On Tue, 19 Aug 2025 11:15:54 +0200, Raphael Gallais-Pou wrote:
> >> The new STMicroelectronics SoC features a display controller similar to
> >> the one used in previous SoCs.  Because there is additional registers,
> >> it is incompatible with existing IPs.
> >>
> >> Add the new name to the list of compatible string.
> >>
> >> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> >> ---
> >>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 30 ++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> Hi Rob,
> 
> It seems several patches of this series triggered your bot without
> warnings/errors messages.
> 
> Did I missed something or is it just a glitch in the matrix ? :)

'make dt_binding_check' is broken in linux-next which is used if the 
base commit is not specified or not found. The latter was the case here. 
Should be fixed in tomorrow's linux-next.

Rob

