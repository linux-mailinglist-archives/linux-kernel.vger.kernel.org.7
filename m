Return-Path: <linux-kernel+bounces-837378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06630BAC2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8124C1925B55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB22F3C0F;
	Tue, 30 Sep 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYnVYuB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDA1C862F;
	Tue, 30 Sep 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223254; cv=none; b=k+fk/310RUPF79o1M5dHH4gkJw6rU4eiGjj34lrsVD2QmZdPnIoZd/5KDcIeEkJdDvifCLlrTYRqbpw8gziIWf16HtguVbz+rcADJl/QpbZbw2VOmXwNcWbpKPKnr2nrDvQPYDxg2HRtL2Wx0a8To7LZQBpJ7fU0KWFkyR6lRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223254; c=relaxed/simple;
	bh=xc3KH1WSU2OPGTdPqjb3BoZZr9G+9kOmNh7pmQcpJnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsL5gsBW42s4o+u97IofO00N0nR/nDVVxMCZz/zIBzfg4nZ0PPr1+ULi5O4ikIt63fM93h7CTCZdONS+OJUNQipbKTpFqhuEVS7tkHvKeqJeTbUNXJn9TJ51vNBlLyk4CQujhdyLezjkF2TIzle6zk74UrNqEmiaCDkizIb3pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYnVYuB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFADC4CEF7;
	Tue, 30 Sep 2025 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759223254;
	bh=xc3KH1WSU2OPGTdPqjb3BoZZr9G+9kOmNh7pmQcpJnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYnVYuB9wRsh8JpixpG1urK32nQRNVo4zkI1bubhQf/u4xrIIiBCzBAH9PyT5peti
	 wWWlPneCmW+r7lgdSXm2xISyo+PWqhqRyjaXIU/sSu3rr8oCMXj794GCIGkiVgVGba
	 3uImsB+Bbc9w4a9BeUjFlMb/4BUNJxbBXS+eDzGF5flBCUBLloz02i/PigOC/Zt6FK
	 fhuUPc/zs9u7+rIkYD+WEk5KfnZp6JWCbxqR/X2Zqbv2iWpOFQHU61hxP5WbeoVVmf
	 BBX/OlVLe82efRcsK5DO/aLMxz0h5TAILD7oBfha0SI1laYlHQVX9Wq+V6orFE3pQK
	 zHq88m+vwDnhw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 918B9F40068;
	Tue, 30 Sep 2025 05:07:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 05:07:32 -0400
X-ME-Sender: <xms:1J3baCHUlm8xhf1e04YPY2VOMYxKbeqCMFEfB9h7z5vKg_xe1B87XA>
    <xme:1J3baKaOlfIFfyQjDo1KkLUSEempytb91BiCGnefeaIOUC2iw-0jmUpfXLQ5mjj-d
    FPPLoiNZbSPMZoNZR8essAOQ9prH_IdD-_SPXaT3K3XBfZvvKK2d88>
X-ME-Received: <xmr:1J3baD0CqSY1zOUzwiwNXAniqPlFU6iOaVV7jxqRwBADkOT10d_sC6UssbrHWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdrlhhinhhugi
    druggvvhdprhgtphhtthhopeigihhnseiihihtohhrrdgtohhmpdhrtghpthhtohepuggr
    vhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehtgh
    hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgr
    thdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:1J3baCd2Qw5LUUyBG0gMR4RscM9vWfs-NrRDBx-O-EYPX9kOwJ_wHA>
    <xmx:1J3baFBmjusv_8hS-N17y5IdItVUKvm3ahHkoY6uERMQaO_AXyHqCw>
    <xmx:1J3baE0hH4tZi10izr1ZM5m8wvF_ZenesZc2Xu-CNQKmnIGy2Tgl-w>
    <xmx:1J3baFNgV0ioUOQQRdkkzOk2N6LFi6D1xLASNewCmUlPr8boHz1eww>
    <xmx:1J3baCc9_r7UkVXxDSXXd5PGmPbXD6sHj3oIgE_tY5o573WFW7FDh7E5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 05:07:32 -0400 (EDT)
Date: Tue, 30 Sep 2025 10:07:29 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, xin@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 01/12] coco/tdx: Rename MSR access helpers
Message-ID: <u75crquhikiczvurynpzytyuge47xagjq3yn5uacx3r65e4lhu@oq362xe2k3v3>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930070356.30695-2-jgross@suse.com>

On Tue, Sep 30, 2025 at 09:03:45AM +0200, Juergen Gross wrote:
> In order to avoid a name clash with some general MSR access helpers
> after a future MSR infrastructure rework, rename the TDX specific
> helpers.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

