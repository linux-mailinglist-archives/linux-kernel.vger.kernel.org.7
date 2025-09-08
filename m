Return-Path: <linux-kernel+bounces-805574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE70B48A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034AF1665DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF12F5485;
	Mon,  8 Sep 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SvdiaH7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXfecqra"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B701E505
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327912; cv=none; b=XpQWAyJ5UKBDwzwKD93OSSB+QJUNeeiNaIC4mEQ/YSDop1t0U1dVBAI4/HeIkmT83GmvXXfiH990HxgBl09cWOAlm5pC8MKoLFsj2xNLcaYrTo4PHBme6lDF6k6jDrPUVV5jr4CZAEFdAtPnuWaCLwG7KrHb/P5o3kIwxWBg7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327912; c=relaxed/simple;
	bh=nItLpLln0FIqOaryFrMho5pcHamPfDnhvC4hCCO0twI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8fX8pY5/p+Jz+5yFkabAcdT1CQhf21tiu26wf7e+uFdvpEd1IlJVO+4npmpCYCCv3CN1+8PQAovAHKFB2QIrg6+cbUm/MP40jq8FiUvjKLmvT14+zXeTonZ5O7KayJjblm4ZRQwMfp6LVxqZhaxCfdo8grYr9GR7pKpmD0OSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SvdiaH7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXfecqra; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4404E1D000D0;
	Mon,  8 Sep 2025 06:38:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 06:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757327908; x=
	1757414308; bh=eXniMLCiqQTMUody1zzwv3fUVrwRPJjmN26qgb3DM98=; b=S
	vdiaH7yTVuslaE3BszjLcuRbCTa0WXuayxZFpsNJvMRFOr5HL+ko6YOK1rbcoCIF
	3wsZiHR0xT64TLaXj0YTqCsbsWwryehZvSN5ywp/I1CWPCRibWM9xFCZ1e607jl0
	KKgqdMaoxjS1DeisHPw5srvkO2pu/OpvMfYu2o5q93rts2tP5M3cFbuiZCTLdmSX
	GsXs+Xro7bYmsX1MbFfeYUlnLLcRq1bQbpEDGzKlxoKJF81WaewOrBWZasIlLfdm
	QfM04d4D/v8IHGBJpITuFwz5hqpJzXY6Elexn9CR2c5s98oIbJJGacKNGIiuICBx
	k8KPpxKjc/s5CnQV1pFhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757327908; x=1757414308; bh=eXniMLCiqQTMUody1zzwv3fUVrwRPJjmN26
	qgb3DM98=; b=gXfecqraAjS9e/kHJUWSkipJgdxF1vCrh1jZZo7MNspz+MkYkb0
	6+xKbIZKQhvvWDzoikPDUlG1qWJD+HKjLXcr50NH69fwHw8b+xJus38p7Zxe598l
	0Krow51l5t9gkFUY1RsLg9LtfCzE0dbn1W4j2I/7/iyfKwt3p5EBX26qiIrxGsJV
	gJP+3X4UEJ89kDM1HEqE6OCbA9+OmDOh98HOY6EhGZg46jz4ymoePfgnXN70lOZM
	92cX7aJB8w2H9ylInkOQbeBH5xfDoBQPinwp9nOrAai8fY337pMPaiNWrqgF3SXV
	NxAHYiX3MeQRusjJjV6iKXtTfgMdkUAERYg==
X-ME-Sender: <xms:IrK-aNwyPJqk8RAX8eyK9qLoa4NVvuGwrUqCGke7__atON0G63r9fQ>
    <xme:IrK-aCZmx_XrQ2LkhBsiki7LOdk-Ak0o68gwtMjsSAv-eNk_dNRPLUwldgOF2Yns-
    1qJpZxnJy8iAHhUy-4>
X-ME-Received: <xmr:IrK-aOmrZTr91I02nRduiYx6lIZwoYlerLKnbPwFxBIWOaxmiQ2cTEApWD0GfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrghntggvrdihrghngheslhhinh
    hugidruggvvhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    eplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegsrgho
    hhhurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrohhlihhnrdifrghngheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguvghvrdhjrghinhesrghr
    mhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:IrK-aHFpN7yD3L3v68dpSVMjqtgsCyUPZlNVx3nvsh3WBmUiNMixbQ>
    <xmx:IrK-aFi-olsfiMcbQVZOUByIyjtHhPRenpYPtp3hYYcrd3uY0M1Bbw>
    <xmx:IrK-aJkFKek9xQqFNHOWw3mhUIr38xR4E7NdN2MGtMsEfQgCtVI85Q>
    <xmx:IrK-aOdb1nRV3qw4-lsnNHpQUflhtRGh8iI5_IDItHQxP_jspy1hww>
    <xmx:JLK-aDBfv8WSueAMnt9H00NY5N0c4M6DEJ-hSaFcA5Imto2AdNWRUj2M>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 06:38:26 -0400 (EDT)
Date: Mon, 8 Sep 2025 11:38:24 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, usamaarif642@gmail.com, ziy@nvidia.com
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Message-ID: <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
References: <20250908090741.61519-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908090741.61519-1-lance.yang@linux.dev>

On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> it does not make sense to try to detect whether it is underused, because
> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> actually replace any zeroed pages by the shared zeropage.

It makes me think, does KSM follows the same logic as
try_to_map_unused_to_zeropage()?

I cannot immediately find what prevents KSM from replacing zeroed mlocked
folio with ZERO_PAGE().

Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

