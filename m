Return-Path: <linux-kernel+bounces-690655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA62ADDA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 19:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB14034D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BCC2376E4;
	Tue, 17 Jun 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFi62LWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DE2FA62C;
	Tue, 17 Jun 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180538; cv=none; b=E5FDXZ8h+vD9/SJceES5chJeAK64FEMfFlcgise1yV88GgU2MATCDNhLzHBf9n63bHgH7uD/yhMitgcX3H18IrwJbNa+A3yFc0rGQUnaEPjSlF3caTyBLrIeGlXWbtR8soYyO3jOVR10GzAJvAzI26vuD4h0SOdWaBmp2vy6+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180538; c=relaxed/simple;
	bh=OL7sXVMiGoIw7l3UO2HZ7bZcbfrL+JTa+SYqgoxJRQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC/bkEiN4iN5fWbzUmlDsZqFSNdhpW2srdjjhAki4hxWka4vN3KQpI9Aqz0/7l7EEcTT5x7mAcVr/coatKQFqLvXZtBnc+jyY7Z3kvei4kZw6DW2yXiFivWQRL7pPnhdPSsqCTDUEuvmAYeuQfhMRvivwIlo6ZVMA3KjfXRPeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFi62LWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8188BC4CEE3;
	Tue, 17 Jun 2025 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750180535;
	bh=OL7sXVMiGoIw7l3UO2HZ7bZcbfrL+JTa+SYqgoxJRQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFi62LWkchK1kWyMleGBtLF3Pgy4xIVuFAiwdLalZq/nWRzCbvA1VlWhxnJH7n2i/
	 /8olxgWzELFw4GCZWJJBKJGATBaszbZVBCHBDOG1FMGc9XMPv8XYE8XuRN4PRvjNuj
	 WXLuRPf5kxY6oJYvRt05m6lUDWA1V7ld1O9Du6qNC5466YT2yssDngD4KnDF5NjOiy
	 PmXmTP2ATRfeprt/+l7jQhJqGxc/k5bkrIE6TWrP5jOd4pqLGz2ezLZEbBytTpjYK8
	 +Lx4jpAplkWj4Lld1Wj/AIoOxPbCsXtc4X/Mc1YF0XUQdlBF4hvWaf1Gf+iJ7J1m5S
	 pKHq7fWry43uA==
Date: Tue, 17 Jun 2025 19:15:28 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v6 6/6] samples: rust: add ACPI match table example to
 platform driver
Message-ID: <aFGisAm-n6Mt70Hd@pollux>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
 <aFB2FZEFcXUsW8lN@pollux>
 <f29b4eba-bd79-4f74-940c-8cff65495ae0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29b4eba-bd79-4f74-940c-8cff65495ae0@gmail.com>

On Tue, Jun 17, 2025 at 05:39:07PM +0100, Igor Korotin wrote:
> I could suggest on of the following:
> DRV0001
> DRVR0001
> PDRV0001

This one looks reasonable to me.

> TEST0001
> TST0001

